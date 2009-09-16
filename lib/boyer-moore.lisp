;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  5 6/7/96   akh  fixes for kanji, bill's fix for case-matters
;;                  use consistent upcasing.
;;  3 5/23/96  akh  fix for target string being extended
;;  5 3/22/95  akh  fix ensuring cell selection in the table
;;  3 3/2/95   akh  no change
;;  2 2/23/95  slh  OK" -> "Find It" for files list dialog
;;  2 2/17/95  slh  is now default mechanism
;;  1 2/15/95  slh  new in project lib
;;  (do not edit before this line!!)

; boyer-moore.lisp
;
; Copyright 1995 Digitool, Inc.
;
; The Boyer/Moore string search algorithm.
; Implements MCL's "Search Files" dialog action with Boyer/Moore algorithm and gives feedback
; while the search is progressing.

; To do
; Only finds one occurrence per block.

;;;;;;;;;;;;;
;;
;; Modification History
;;
;; maybe-start-isearch - make extended string
;; dir-text-files uses text-file-test, handle case-matters in get-bm-string non-7bit-ascii case, handle multiple encodings
;; get-bm-string handles desired string being unicode (i.e. maybe not 7bit-ascii) - todo: make work for utf16 files ?
;; --------- 5.1 final
;; 12-6/02       Don't declare base to be a fixnum in find-bm-tables-in-file. This allows us to
;;               search files > fixnum in length. Any slowdown caused by this should be negligible
;;               since boyer-moore for files is io-bound anyway.
;; 10/08/96 bill find-bm-tables-in-file no longer calls scriptruns-p unless
;;               the search string contains extended characters.
;;               This speeds it up noticeably, especially when searching over
;;               a network.
;; ------------- 4.0b2
;; 07/31/96 bill find-bm-tables-in-file uses with-newptr instead of
;;               %stack-block to avoid GC'ing the heap consed stack block buffers
;;               (maximum size for stack consing is slightly less than 4K).
;; 05/26/96 bill bm-do-dialog-file-search-internal says "Finding ..." before
;;               calling dir-text-files. It also doesn't say "Finding ..."
;;               if it gets a list for a pathname.
;; 05/24/96 bill Remember case-matters in the bm-tables. Use it.
;; ------------- MCL-PPC 3.9
;; 11/29/95 bill #_DisposPtr -> #_DisposePtr
;;  5/30/95 slh  added an eval-when; find-bm-tables-in-file uses with-FSOpen-file-noerr
;; 05/21/95 psz  Correct base for first bufferful in find-bm-tables-in-file.
;;               Extend bm-do-dialog-file-search to allow list of pathnames instead
;;               of a single one.
;;  4/27/95 slh  only searches text files
;;  3/09/95 slh  error dialog for DIRECTORY errors
;;  2/15/95 slh  added to ccl;lib
;; ------------- 3.0d17
;; 06/03/93 bill remove process-run-function from bm-do-dialog-file-search.
;;               The process is now created by the dialog-item-action of
;;               the "Search Files" dialog's "OK" button.
;; ------------- 3.0d8
;; 04/29/93 bill current-process -> *current-process*
;; ??       bill no longer fails to find string that crosses the first block boundary.
;; 02/04/93 bill put up dialog before (directory ...) so that user can abort by
;;               closing the dialog. Each search now has its own process.
;; 02/02/93 bill (directory ... :resolve-aliases t)
;; 12/16/92 bill %stack-block -> with-newptr until %stack-block can deal with larger blocks
;; 10/16/92 bill The behavior of the selection changed in set-table-sequence.
;;               Bullet-proof this code so it works independently of how
;;               the selection changes.
;; 08/20/92 bill double clicking on white space in the "Files containing..."
;;               dialog no longer brings up a "New..." window.
;; ------------- 2.0
;; 10/08/91 bill mac-file-io moves to CCL package
;; 09/05/91 bill Removed last vestige of LAP

(in-package :ccl)

(eval-when (:compile-toplevel :execute :load-toplevel)
  (require :mac-file-io))

(eval-when (:compile-toplevel :execute)
  (defconstant $bm-buffer-size 8192)

  (defmacro %char-code-upcase (char-code)
    (let ((c (gensym)))
      `(the fixnum
         (let ((,c ,char-code))
           (declare (fixnum ,c))
           (if (and (<= (char-code #\a) ,c)
                    (<= ,c (char-code #\z)))
             (the fixnum (+ ,c (- (char-code #\A) (char-code #\a))))
             ,c)))))

  (defmacro with-newptr ((ptr size) &body body)
    `(with-macptrs (,ptr)
       (unwind-protect
         (progn
           (%setf-macptr ,ptr (require-trap #_NewPtr :errchk ,size))
           ,@body)
         (unless (%null-ptr-p ,ptr)
           (require-trap #_DisposePtr ,ptr))))))

(defstruct bm-tables 
  string                                ; the search string as a vector of character codes
  len                                   ; the length of the search string
  match                                 ; index in string -> shift for last chars match
  mismatch                              ; char -> shift for last char mismatch
  case-matters                          ; boolean, true if case matters
  extended-target                       ; boolean, true if search string is a truly extended string
  )

; 1. the upcase function used should be the same as %char-code-upcase
; 2. what if target string is truly extended and file has no 2 byte scripts?
;      Then it isn't there period. Oh foo, really have to parse the scriptruns or allow
;      some wrong hits.

; assume called with a string which may be extended but need not be 
(defun bm-string-upcase (string)
  (let* ((len (length string))
         (res (make-string len :element-type 'base-character)))
    (declare (fixnum len))
    (multiple-value-bind (real-string offset)(array-data-and-offset string)
      (dotimes (i len)
        (setf (%scharcode res i)(%char-code-upcase (%scharcode real-string (%i+ i offset)))))
      res)))

#|
(defun get-bm-string (string &optional case-matters)
  (if (and (extended-string-p string)(real-xstring-p string))
    (let* ((length (length string))
           (new-string (make-array (+ length length) :element-type 'base-character :fill-pointer 0)))
      (dotimes (i length)
        (let* ((char (char string i))
               (code (char-code char)))
          (if (< code #x100)
            (vector-push-extend char new-string)
            (progn
              (vector-push-extend (code-char (ash code -8)) new-string)
              (vector-push-extend (code-char (logand code #xff)) new-string)))))
      (values (ensure-simple-string new-string) t))
    (ensure-simple-string (if case-matters string (bm-string-upcase string)))))
|#
;; maybe do so 
(defun upcase-the-ascii-chars (string)
  (dotimes (i (length string))
    (let ((code (%scharcode string i)))
      (if (and (>= code #x7f)(neq (%find-encoding-for-uchar-code code) #$kcfstringencodingmacroman))
        ;; because searcher can't upcase when search string includes non roman stuff - it's case dependent in that case 
        (return-from upcase-the-ascii-chars string))))
  (dotimes (i (length string))
    (let ((code (%scharcode string i)))
      (if (and (%i<= code (char-code #\z))(%i>= code (char-code #\a)))
        (setf (%scharcode string i)(%i- code #.(- (char-code #\a)(char-code #\A)))))))
  string)

(defun get-bm-string (string &optional case-matters)
  (if (not (7bit-ascii-p string))
    (progn
      (setq string (ensure-simple-string string))  ;; copies -       
      (if (not case-matters)(setq string (upcase-the-ascii-chars string)))  ;; dont if not all macroman
      (multiple-value-bind (string encoding) (convert-string-to-mac-encodings string)
        (let* ((length (length string))
               (new-string (make-array (+ length length) :element-type 'base-character :fill-pointer 0)))
          (dotimes (i length)
            (let* ((char (char string i))
                   (code (char-code char)))
              (declare (fixnum code))
              (if (< code #x100)
                (vector-push-extend char new-string)
                (progn
                  (vector-push-extend (code-char (ash code -8)) new-string)
                  (vector-push-extend (code-char (logand code #xff)) new-string)))))
          (setq new-string (ensure-simple-string new-string))
          (values new-string
                  (neq encoding #$kcfstringencodingmacroman)))))
    (ensure-simple-string (if case-matters string (bm-string-upcase string)))))

(defun convert-string-to-mac-encodings (string)
  (let ((len (length string))
        (guess nil)
        (start-char 0)
        (strings-so-far nil))
    (dotimes (i len)
      (let* ((code (%scharcode string i)))
        (declare (fixnum code))        
        (when t ;(> code #x7f)
          (let ((encoding  (if (> code #x7f)(%find-encoding-for-uchar-code code) #$kcfstringencodingmacroman)))
            (if (null guess)
              (setq guess encoding)
              (when  (neq guess encoding)
                (push (convert-string (%substr string start-char i)
                                      #$kcfstringencodingUnicode guess)
                      strings-so-far)
                (setq start-char i)
                (setq guess encoding)))))))
    (let ((last (convert-string (if (eq start-char 0)
                                  string
                                  (%substr string start-char len))
                                #$kcfstringencodingUnicode guess)))      
      (values 
       (if (null strings-so-far) last
           (apply #'%str-cat (nconc (nreverse strings-so-far)(list last))))
       ;; return encoding if there is only one
       (if (eq 0 start-char) guess)))))



(defun compute-bm-tables (string &optional case-matters)
  (let (extended-p)
    (multiple-value-setq (string extended-p) (get-bm-string string case-matters))
    (let* ((len (length string))
           (len-1 (1- len))
           (len-2 (1- len-1))
           (mismatch (make-array 256 :element-type t :initial-element len))
           (match (make-array (max 0 len-1) :element-type t))
           (pred (if case-matters #'char= #'char-equal)))
      (declare (fixnum len len-1 len-2))
      ; compute mismatch table.
      ; mismatch[i] = how far to shift if there is a mismatch on the first
      ; compare (with string[len-1]) and the character in the text is (code-char i)
      (dotimes (i len-1)
        (declare (fixnum i))
        (setf (aref mismatch (char-code (schar string i))) (- len-1 i)))
      ; Compute match table
      ; match[i] = how far to shift if there is a mismatch in the ith position
      ; of the search string (i < len-1).
      (dotimes (i len-1)                  ; i is mismatch position
        (declare (fixnum i))
        (setf (aref match i)
              (block match
                (do ((end len-2 (1- end)))
                    ((< end 0) len)
                  (declare (fixnum end))
                  (do ((j len-1 (1- j))
                       (k end (1- k)))
                      ((< k 0)
                       (return-from match (- len-1 end)))
                    (declare (fixnum j k))
                    (when (eql j i) 
                      (if (not (funcall pred (schar string j) (schar string k)))
                        (return-from match (- len-1 end)) 
                        (return)))
                    (unless (funcall pred (schar string j) (schar string k))
                      (return)))))))
      (make-bm-tables :string (map 'vector #'char-code string) 
                      :len len 
                      :mismatch mismatch 
                      :match match
                      :case-matters case-matters
                      :extended-target extended-p))))

; Search array from start to end for the string in the bm-tables descriptor
(defun bm-search-array (bm-tables array start end &optional script-p)
  (declare (ignore script-p))
  (declare (fixnum start end)
           (type macptr array))
  (declare (optimize (speed 3) (safety 0)))
  (let* ((string (bm-tables-string bm-tables))
         (len (bm-tables-len bm-tables))
         (len-1 (1- len))
         (match (bm-tables-match bm-tables))
         (mismatch (bm-tables-mismatch bm-tables))
         (i (+ start len-1))
         (char-code 0))
    (declare (fixnum len len-1 i char-code))
    (macrolet ((do-it ()
                 `(loop
                    (when (>= i end) (return nil))
                    (let ((array-idx i)
                          (string-idx len-1))
                      (declare (fixnum array-idx string-idx))
                      (if (not (eql (the fixnum (svref string string-idx))
                                    (setq char-code (array-ref array array-idx))))
                        (incf i (the fixnum (svref mismatch char-code)))
                        (loop
                          (when (< (decf string-idx) 0)
                            (return-from bm-search-array (the fixnum (- i len-1))))
                          (decf array-idx)
                          (when (not (eql (the fixnum (svref string string-idx))
                                          (array-ref array array-idx)))
                            (return (the fixnum (incf i (the fixnum (svref match string-idx))))))))))))
      (if (or (bm-tables-case-matters bm-tables) 
              (bm-tables-extended-target bm-tables))
        (macrolet ((array-ref (array index)
                     `(%get-unsigned-byte ,array ,index)))
          (do-it))
        (macrolet ((array-ref (array index)
                     `(%char-code-upcase (%get-unsigned-byte ,array ,index))))
          (do-it))))))

(defun find-bm-tables-in-file (bm-tables file &optional found-function)
  (unless found-function
    (let (res)
      (setq found-function
            #'(lambda (pos)
                (if pos
                  (push pos res)
                  (prog1 (nreverse res) (setq res nil)))))))
  (let ((script-p nil))
    (when (and (bm-tables-extended-target bm-tables)
               (not (setq script-p (scriptruns-p (truename file)))))
      (return-from find-bm-tables-in-file nil))
    (with-FSopen-file-noerr (pb file)
      (let* ((len (bm-tables-len bm-tables))
             (len-1 (1- len))
             (buffer-size (+ $bm-buffer-size len-1))
             (size 0)
             (bytes-read 0)
             (base 0)
             (index 0))
        (declare (fixnum len buffer-size size bytes-read))
        (with-newptr (buf buffer-size)
          (with-macptrs ((buf+len-1 (%inc-ptr buf len-1))
                         (buf+$bm-buffer-size (%inc-ptr buf $bm-buffer-size)))
            (setq bytes-read (setq size (fsread pb $bm-buffer-size buf)))
            (with-macptrs ((ptr (%inc-ptr buf+$bm-buffer-size (- len-1))))
              (#_BlockMove  ptr buf+$bm-buffer-size len-1))
            (loop
              (when (> bytes-read 0)
                (setq index 0)
                (loop
                  (if (setq index (bm-search-array bm-tables buf index size script-p))
                    (progn
                      (unless (funcall found-function (+ base index))
                        (return-from find-bm-tables-in-file nil))
                      (setq index (the fixnum (1+ (the fixnum index)))))
                    (return))))
              (when (< bytes-read $bm-buffer-size)
                (return (funcall found-function nil)))
              (if (zerop base)
                (setq base (- size len-1))
                (incf base $bm-buffer-size))
              (#_BlockMove buf+$bm-buffer-size buf len-1)
              (setq bytes-read (fsread pb $bm-buffer-size buf+len-1))
              (setq size (+ len-1 bytes-read)))))))))


; Call FOUND-FUNCTION with one arg, the position in the file, for each
; occurrence of STRING in FILE.  Calls FOUND-FUNCTION with an arg of NIL when
; the last occurrence has been found, and returns the value as the value
; of BM-FIND-STRING-IN-FILE.
; If FOUND-FUNCTION returns NIL, return NIL from BM-FIND-STRING-IN-FILE.
(defun bm-find-string-in-file (string file &optional found-function)
  (find-bm-tables-in-file (compute-bm-tables string) file found-function))

; Call FOUND-FUNCTION with two args, the file & the position in the file,
; for each occurrence of STRING in one of the FILES.
; If FOUND-FUNCTION returns NIL, go immediately to the next file.
; Otherwise, continue searching in the current file.
; Calls FOUND-FUNCTION with a second arg of T before starting to search each file
; and with a second arg of NIL at the end of searching each file.
; Calls FOUND-FUNCTION with a first arg of NIL when the search is all over.
(defun bm-find-string-in-files (string files &optional found-function)
  (unless found-function
    (setq found-function
          (let (res one-file)
            #'(lambda (file pos)
                (cond ((eq file nil) (prog1 (nreverse res) (setq res nil)))
                      ((eq pos t) (setq one-file nil))
                      ((eq pos nil) (when one-file
                                      (push (cons file (nreverse one-file)) res)))
                      (t (push pos one-file)))))))
  (let ((bm (compute-bm-tables string))
        search-file)
    (flet ((inner-found-function (pos)
             (funcall found-function search-file pos)))
      (declare (dynamic-extent inner-found-function))
      (dolist (file files)
        (setq search-file file)
        (funcall found-function file t)
        (find-bm-tables-in-file bm file #'inner-found-function))
      (funcall found-function nil nil))))

(defun dir-text-files (dir)
  (directory dir
             :resolve-aliases t
             :test #'(lambda (file)
                       (text-file-test file)))) ;(eq (mac-file-type file) :TEXT))))

(defun bm-find-string-in-dir (string dir &optional found-function)
  (bm-find-string-in-files string
                           (dir-text-files dir)
                           found-function))

;;;;;;;;;;;;;
;;
;; Upate MCL's "Search Files" command
;;

(defun do-dialog-file-search (pathname string)
  (bm-do-dialog-file-search-internal pathname string))

(defun bm-do-dialog-file-search-internal (pathname string)
  (let* ((dialog (select-item-from-list
                  nil
                  :window-title (format nil "Files containing ~s" string)
                  :modeless t
                  :default-button-text "Find It"
                  :action-function
                  #'(lambda (list)
                      (when list
                        (maybe-start-isearch (ed (car list)) string)))))
         (sequence (find-subview-of-type dialog 'sequence-dialog-item))
         (button (default-button dialog))
         files error)
    (unwind-protect
      (progn
        (setf (window-process dialog) *current-process*)
        (if (consp pathname)
          (setq files pathname)
          (progn
            (set-table-sequence sequence (list (format nil "Finding ~s" pathname)))
            (multiple-value-setq (files error)
              (ignore-errors (dir-text-files pathname)))
            (unless files
              (when error
                (standard-alert-dialog (format nil "Error: ~A." error)  
                                  :yes-text "Ok" :no-text nil :cancel-text nil :alert-type :note)
                (return-from bm-do-dialog-file-search-internal nil))
              (set-table-sequence sequence (list "No text files correspond to:" pathname))
              (return-from bm-do-dialog-file-search-internal nil))))
        (set-table-sequence sequence nil)
        (set-cell-font sequence #@(0 0) :italic)
        (set-table-sequence sequence (list (car files)))
        (flet ((f (file index)
                 (without-interrupts
                  (flet ((ensure-selected-cell (sequence new-cell)
                           (let ((old-cell (first-selected-cell sequence)))
                             (unless (eql new-cell old-cell)
                               (when old-cell (cell-deselect sequence old-cell))
                               (when new-cell (cell-select sequence new-cell))))))
                    (cond ((null file)
                           (set-cell-font sequence #@(0 0) nil)
                           (let ((sel (first-selected-cell sequence)))
                             (set-table-sequence
                              sequence (cdr (table-sequence sequence)))
                             (when sel
                               (setq sel
                                     (if (eql sel #@(0 0))
                                       nil
                                       (make-point (point-h sel) (1- (point-v sel))))))
                             (when sel (ensure-selected-cell sequence sel))
                             ))
                          ((eq index t)
                           (setf (car (table-sequence sequence)) file)
                           (redraw-cell sequence #@(0 0)))
                          (index
                           (let () ;((sel (or (first-selected-cell sequence) #@(0 1))))
                             (set-table-sequence 
                              sequence (nconc (table-sequence sequence) (list file)))
                             ;(ensure-selected-cell sequence sel)
                             (dialog-item-enable button)
                             nil))
                          (t nil))))))
          (declare (dynamic-extent #'f))
          (bm-find-string-in-files string files #'f)))
      (setf (window-process dialog) nil))))

(defun maybe-start-isearch (window string)
  (let ((fred (window-key-handler window)))    
    (when (and fred string)
      (ed-beginning-of-buffer fred)
      (let* ((buffer (fred-buffer fred))
             (pos1 (buffer-forward-search buffer string)))
        (when pos1
          ;(set-mark buffer pos1)
          ;        (set-fred-display-start-mark fred pos1 t)
          (set-selection-range fred pos1 (- pos1 (length string)))
          (window-show-selection fred)
          ;(fred-update fred)
          (let ((s (make-string-output-stream :element-type 'extended-character)))  ;; should be the default
            (format s "~A" string)
            (setq *i-search-search-string* (string-output-stream-string s))))))))

#|
; this is still flashy on newly opened window BUT less
; dont know why 3.0d11 is better - also it make the whole thing visible

(defun maybe-start-isearch (window string)
  (let ((fred (window-key-handler window)))    
    (when (and fred string)
      (ed-beginning-of-buffer fred)
      (let* ((buffer (fred-buffer fred))
             (frec (frec fred))
             (pos1 (buffer-forward-search buffer string)))
        (when pos1
          (let ((count (- (next-screen-context-lines (frec-full-lines frec)))))
            (frec-set-sel frec pos1 (- pos1 (length string)))
            (set-fred-display-start-mark fred (frec-screen-line-start frec pos1 count)))
          (let ((s (make-string-output-stream)))
            (format s "~A" string)
            (setq *i-search-search-string* (string-output-stream-string s))))))))
|#

; End of boyer-moore.lisp
