;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  2 4/7/95   akh  'character => 'base-character
;;  2 3/2/95   akh  reindex-file says :element-type 'base-character
;;  (do not edit before this line!!)

; simple-db.lisp - database for traps & help files
; Copyright (C) 1990 Apple Computer, Inc.
; Copyright 1995 Digitool, Inc.

; Change log
;
; now all #\return -> char-eolp
; most uses of #\newline -> char-eolp , a few changed to #\return
; ------ 5.2b6
; 03/04/96 bill map-index-stream
; ------------- 3.0
; 11/07/95 bill search-index-stream returns a second arg: position of beginning of key in file
; 11/02/95 bill make-index-file handles a null alist
; 03/24/93 bill char-minus-a limits its result so that (<= 0 result 25). This makes
;               it handle characters which are alpha-char-p but not between #\A & #\Z.
; 10/01/91 bill with-standard-io-syntax
; 08/16/91 bill value-writer arg to make-index-file
; 08/12/91 bill (dynamic-extent #'pred) in search-index-stream
; 08/10/91 gb   Experiment with idea of storing constant values, etc., in index.
; 01/02/90 bill Treat non-existant file correctly in get-index-file-entries
; 12/26/90 joe  Put binary search here (defined in fred-misc too) so that this module
;               could be an *env-module*.
; 12/22/90 joe  Fixed bug in search-index-stream when the first letter of a key had no entries.
; 12/10/90 bill search-index-stream
; 12/03/90 bill in get-index-stream-entries: index entries can be 0
; 11/30/90 bill binary-search.
;               make db-string-lessp not be db-string-less-or-maybe-equal-p
; 11/29/90 bill handle trailing newline in value.  Check for newline in key.
; 09/27/90 bill removed some debugging code, error-p arg to get-index-file-entries

(in-package :ccl)

; Sorts ALIST and writes an index file.
; An index file looks like:
;
; FILE-LENGTH
; B-index
; C-index
; D-index
; ...
; Y-index
; Z-index
; A1-key
; A1-data
;
; A2-key
; A2-data
;
; ...
;
; Zn-key
; Zn-data
;
; FILE-LENGTH is the number of characters in the file.  It is used
; to tell whether the index is up to date.
; The "x-index" lines are 10 characters of file address (base 10) for
; the start of keys that start with the letter "x".
; Each "key" is one line.  Each "data" can be multiple lines but must
; not contain two newlines in a row.
; Two newlines in a row seperate the entries.
(defun make-index-file (filename alist &optional dotted-value-p value-writer)
  (let ((first-cons alist))
    (when first-cons
      (setq alist (cons (car alist) (cdr alist)))
      (setq alist (sort alist #'db-string-lessp :key #'car))
      (setf (car first-cons) (car alist)
            (cdr first-cons) (cdr alist)))
    (with-open-file (stream filename :direction :io :if-exists :supersede
                            :element-type 'base-character)
      (write-index-to-stream stream alist dotted-value-p value-writer))))

(defun db-string-lessp (s1 s2)
  (let ((i1 (first-alpha-index s1))
        (i2 (first-alpha-index s2)))
    (cond ((and (null i1) (null i2))
           (string-lessp s1 s2))
          ((null i1) t)
          ((null i2) nil)
          ((string-equal s1 s2 :start1 i1 :start2 i2)
           (string-lessp s1 s2))
          (t (string-lessp s1 s2 :start1 i1 :start2 i2)))))

(defun first-alpha-index (string)
  (setq string (string string))
  (dotimes (i (length string) nil)
    (declare (fixnum i))
    (if (alpha-char-p (char string i))
      (return i))))

(defun char-minus-A (char)
  (let ((code (char-code (char-upcase char))))
    (declare (fixnum code))
    (max 0 (min 25 (- code (char-code #\A))))))

#+ignore
(defvar *two-newline-chars* (make-array 2
                                        :element-type 'base-character
                                        :initial-contents '(#\return #\return)))

(defun find-two-eols (string  &optional (start 0))
  (let* ((len (length string))
         (pos1 (string-eol-position string start len)))
    (declare (fixnum len))
    (when (and pos1 (< pos1 (1- len)))
      (if (char-eolp (char string (1+ pos1)))
        pos1
        (find-two-eols string (1+ pos1))))))
          
#+ignore
(defvar *one-newline-char* (make-array 1
                                       :element-type 'base-character
                                       :initial-contents '(#\return)))

(defun write-index-to-stream (stream alist &optional dotted-value-p value-writer)
  (let ((index (make-array 26 :initial-element 0)))
    (write-index-array stream index)
    (when value-writer (setq dotted-value-p nil))
    (dolist (pair alist)
      (let* ((key (string (car pair)))
             (value (cdr pair))
             (extra (if dotted-value-p (prog1 (cdr value) (setq value (car value)))))
             (alpha-index (first-alpha-index key))
             (idx (if alpha-index (char-minus-A (char key alpha-index)) 0)))
        (cond (value-writer)
              ((stringp value))
              ((symbolp value) (setq value (string value)))
              (t (setq value (format nil "~s" value))))
        (if extra (setq extra (handler-case (let* ((*print-readably* t)) (format nil "~s" extra))
                                (print-not-readable ()))))
        (when (string-eol-position key) ;(find *one-newline-char* key)
          (error "key contains a newline:~%~s~%" key))
        (when (and (not value-writer) (find-two-eols value)) ;(find *two-newline-chars* value))
          (error "The value for ~s contains two newline characters" key))
        (when (and extra (find-two-eols extra)) ;(find *two-newline-chars* extra))
          (error "The value for ~s contains two newline characters" key))
        (when (eql 0 (svref index idx))
          (setf (svref index idx) (stream-position stream)))
        (write-string key stream)
        (terpri stream)
        (if value-writer
          (progn
            (funcall value-writer stream value)
            (stream-position stream (1- (stream-position stream)))
            (unless (char-eolp (stream-tyi stream))
              (terpri stream)))
          (progn
            (write-string value stream)
            (when dotted-value-p
              (when extra (terpri stream) (write-string (setq value extra) stream)))
            (unless (char-eolp (char value (1- (length value))))
              (terpri stream))))
        (terpri stream)))
    (write-index-array stream index)))

(defun write-index-array (stream index)
  (setf (svref index 0) (file-length stream))
  (stream-position stream 0)
  (dotimes (i 26)
    (declare (fixnum i))
    (format stream "~10,'0d~%" (svref index i))))

(defun skip-past-newline (stream &optional reader arg)  ;; ugh
  (stream-skip-past-terminator stream #'char-eolp reader arg))

(defun skip-past-double-newline (stream &optional reader arg)
  (loop
    (unless (skip-past-newline stream reader arg) (return nil))
    (if (char-eolp (stream-tyi stream)) (return t))))

(defun first-alpha-char (string &optional default)
  (let ((index (first-alpha-index string)))
    (if index
      (char string index)
      default)))

(defun first-stream-alpha-char (stream &optional default (terminator #\return))
  (let ((term-pred (terminator-predicate terminator)))
    (flet ((pred (char) (or (funcall term-pred char terminator) (alpha-char-p char))))
      (declare (dynamic-extent #'pred))
      (let ((char (stream-skip-past-terminator stream #'pred)))
        (cond ((funcall term-pred char terminator)
               (stream-untyi stream char)
               default)
              ((null char) default)
              (t char))))))

(defun reindex-file (filename &optional verbose)
  (with-open-file (stream filename
                          :element-type 'base-character
                          :direction :io
                          :if-exists :overwrite
                          :if-does-not-exist :error)
    (reindex-stream stream verbose)))

(defun index-file-p (stream &optional (errorp t))
  (stream-position stream 0)
  (flet ((err () (if errorp
                   (error "~s does not appear to be an index file.~%~
                           Make sure there are 26 10-digit lines at its beginning."
                          (stream-filename stream))
                   (return-from index-file-p nil))))
    (multiple-value-bind (tyier arg) (stream-reader stream)
      (dotimes (i 26)
        (declare (fixnum i))
        (dotimes (j 10)
          (declare (fixnum j))
          (unless (digit-char-p (funcall tyier arg)) (err)))
        (unless (char-eolp (funcall tyier arg)) (err))))
    t))

(defun reindex-stream (stream &optional verbose)
  ; Check if it looks like an index file
  (when verbose
    (format *debug-io* "~&Reindexing ~s..." (stream-filename stream)))
  (index-file-p stream)
  (let ((index (make-array 26 :initial-element 0)))
    (until (stream-eofp stream)
      (let* ((start-pos (stream-position stream))
             (idx (char-minus-A (first-stream-alpha-char stream #\A))))
          (when (eql 0 (svref index idx))
            (setf (svref index idx) start-pos)))
        (skip-past-newline stream)
        (skip-past-double-newline stream))
    (write-index-array stream index))
  (when verbose
    (format *debug-io* " done.~%")))
                      
(defun get-index-file-entries (file key &optional max-number (error-p t))
  (with-open-file (stream file
                          :direction :io   ; may have to reindex.
                          :element-type 'base-character
                          :if-exists :overwrite
                          :if-does-not-exist (and error-p :error))
    (when stream                        ; file opened ok?
      (get-index-stream-entries stream key max-number))))

#| Linear search version
(defun get-index-stream-entries (stream key &optional max-number)
  (check-index-file-length stream)
  (setq key (string key))
  (let* ((entries nil)
        (count 0)
        (index-char (char-upcase (first-alpha-char key #\A)))
        (idx (char-minus-A index-char)))
    (multiple-value-bind (reader arg) (stream-reader stream)
      (if (eql 0 idx)
        (setq idx (* 26 11))              ; start of data
        (progn
          (stream-position stream (* idx 11))
          (setq idx (let ((*read-base* 10)) (read stream)))))
      (stream-position stream idx)
      (block eof
        (let (found-alpha)
          (loop
            (setq found-alpha nil)
            (if (and (dovector (key-char key t)
                       (let ((char (funcall reader arg)))
                         (unless char (return-from eof))
                         (setq char (char-upcase char))
                         (unless found-alpha
                           (when (alpha-char-p char)
                             (setq found-alpha t)
                             (unless (eq index-char char)
                               (return-from eof))))
                         (unless (eq (char-upcase key-char) char)
                           (when (char-eolp char)
                             (stream-untyi stream char))
                           (return nil))))
                     (char-eolp (funcall reader arg)))
              (let* ((last-char (funcall reader arg))
                     (last-char-newline (char-eolp last-char)))
                (push
                 (with-output-to-string (s)
                   (loop
                     (let ((char (funcall reader arg)))
                       (unless char 
                         (if last-char (stream-tyo s last-char))
                         (return))
                       (if (char-eolp char)
                         (if last-char-newline
                           (return)
                           (setq last-char-newline t))
                         (setq last-char-newline nil))
                       (stream-tyo s last-char)
                       (setq last-char char))))
                 entries)
                (if (and max-number (>= (incf count) max-number))
                  (return-from eof)))
              (progn
                (skip-past-newline stream)
                (skip-past-double-newline stream)))))))
    (nreverse entries)))
|#

; Binary search version
(defun search-index-stream (stream key &optional find-first-entry?)
  (with-standard-io-syntax
    (check-index-file-length stream)
    (setq key (string key))
    (let* ((index-char (char-upcase (first-alpha-char key #\A)))
           (idx (char-minus-A index-char))
           (next-ltr (1+ idx))
           (next-idx 0))
      (multiple-value-bind (reader arg) (stream-reader stream)
        (if (eql 0 idx)
          (setq idx (* 26 11))              ; start of data
          (progn
            (stream-position stream (* idx 11))
            (setq idx (let ((*read-base* 10)) (read stream)))
            (if (eql 0 idx) (return-from search-index-stream nil))))
        (loop
          (if (eql 26 next-ltr)
            (progn
              (setq next-idx (file-length stream))
              (return))
            (progn
              (stream-position stream (* next-idx 11))
              (setq next-idx (let ((*read-base* 10)) (read stream)))
              (if (eql 0 next-idx)
                (incf next-ltr)
                (return)))))
        (let ((found nil)
              (found-start nil))
          (flet ((pred (guess start end tag)
                   ;                 (format t "~&start: ~d, guess: ~d, end: ~d~%" start guess end)
                   (stream-position stream guess)
                   (unless (eql guess idx)
                     (skip-past-double-newline stream reader arg)
                     (if (>= (stream-position stream) next-idx)
                       (return-from pred (values start (1- guess)))))
                   (let* ((new-found-start (stream-position stream))
                          (dir (index-reader-compare key reader arg)))
                     (declare (fixnum dir))
                     (cond ((eql dir 0)
                            (setq found (stream-position stream)
                                  found-start new-found-start)
                            (unless find-first-entry? (throw tag nil))
                            (values start (1- guess)))
                           ((< dir 0) (values start (1- guess)))
                           (t (setq start (stream-position stream))
                              (if (eql start end)
                                (throw tag nil)
                                (values (stream-position stream) end)))))))
            (declare (dynamic-extent #'pred))
            (binary-search idx next-idx #'pred)
            (if (and found find-first-entry?)
              (stream-position stream found))
            (values found found-start)))))))

(defun get-index-stream-entries (stream key &optional max-number)
  (when (search-index-stream stream key (> max-number 1))
    (let (entries)
      (multiple-value-bind (reader arg) (stream-reader stream)
        (dotimes (i max-number)
          (declare (fixnum i))
          (push (read-to-double-newline reader arg)
                entries)
          (unless (eql 0 (index-reader-compare key reader arg))
            (return))))
      (nreverse entries))))

; Compare the KEY string to the string in the file read by READER/ARG.
; Return <0, 0, or >0.
; If 0, skip past the newline following the key in the file.
; Otherwise, may or may not skip the newline.
(let (temp-string)
(defun index-reader-compare (key reader arg)
  (let (rchar
        (str (or temp-string (make-array 50 :adjustable t :fill-pointer 0
                                         :element-type 'base-character))))
    (setq temp-string nil)
    (setf (fill-pointer str) 0)
    (loop
      (setq rchar (funcall reader arg))
      (if (or (null rchar) (char-eolp rchar))
        (return))
      (vector-push-extend rchar str))
    (prog1
      (if (string-equal key str)
        0
        (if (db-string-lessp key str)
          -1
          +1))
      (setq temp-string str))))
)

; This function lives in FRED-MISC, too.
; Repeatedly calls PREDICATE with four values:
;     guess, start, end, tag
; Predicate should either throw a result to TAG or
; return two values: the values of START & END for next time.
(defun binary-search (start end predicate &aux guess)
  (let ((tag (list nil)))
    (declare (dynamic-extent tag))
    (catch tag
      (loop
        (unless (<= start end) (return nil))
        (setq guess (floor (+ start end) 2))
        (multiple-value-setq (start end) (funcall predicate guess start end tag))))))

(defun read-to-double-newline (reader arg)
  (let* ((s (with-output-to-string (s)
              (let ((last-char nil)
                    char)
                (loop
                  (setq char (funcall reader arg))
                  (unless char
                    (if last-char (stream-tyo s last-char))
                    (return))
                  (if (char-eolp char)
                    (if (char-eolp last-char)
                      (return)))
                  (if last-char (stream-tyo s last-char))
                  (setq last-char char))))))
    s))

(defun check-index-file-length (stream)
  (index-file-p stream)
  (stream-position stream 0)
  (let ((sb (let ((*read-base* 10)) (read stream)))
        (was (file-length stream)))
    (unless (eql sb was)
      (format t "sb: ~d, was: ~d" sb was)
      (reindex-stream stream t))
    was))
              
; Call mapper for each entry in the index STREAM with 4 args:
;
; 1) The key, a dynamic-extent string
; 2) The stream, positioned at start-pos
; 3) start-pos, the index in stream of the beginning of the value
; 4) end-pos, the index in stream of the end of the value
(defun map-index-stream (stream mapper)
  (let ((pos (stream-position stream)))
    (unwind-protect
      (progn
        (index-file-p stream)           ; position after index
        (map-index-stream-internal stream mapper))
      (stream-position stream pos))))

(defun map-index-stream-internal (stream mapper)
  (let ((last-end (stream-position stream)))
    (multiple-value-bind (reader arg) (stream-reader stream)
      (loop
        (skip-past-newline stream reader arg)
        (let ((start (stream-position stream)))
          (when (eql start last-end) (return))
          (let* ((key-length (- start last-end 1))
                 (key (make-string key-length :element-type 'base-character)))
            (declare (dynamic-extent key))
            (stream-position stream last-end)
            (dotimes (i key-length)
              (setf (aref key i) (funcall reader arg)))
            (stream-position stream start)
            (let ((no-eof (skip-past-double-newline stream reader arg))
                  (end (stream-position stream)))
              (funcall mapper key stream start (if no-eof (- end 2) end))
              (stream-position stream end)
              (setq last-end end))))))))

(provide :simple-db)
