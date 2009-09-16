;;;-*- Mode: Lisp; Package: WOOD -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; disk-cache-inspector.lisp
;; Inspector interface for the disk-cache data file.
;; This code is as gross as it is because format is so slow.
;;
;; Copyright © 1996 Digitool, Inc.
;; Copyright © 1992-1995 Apple Computer, Inc.
;; All rights reserved.
;; Permission is given to use, copy, and modify this software provided
;; that Digitool is given credit in all derivative works.
;; This software is provided "as is". Digitool makes no warranty or
;; representation, either express or implied, with respect to this software,
;; its quality, accuracy, merchantability, or fitness for a particular
;; purpose.
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; A disk-cache inspects the normal way, but has a command that
;; brings up a contents editor.
;; While in the contents editor, you can move to any address
;; with a command, you can control-click or double-click to
;; move to a pointed-to address and set @, and you can option-click
;; to just set @ to the pointed at value.
;; The commands menu remembers the last two addresses visited.

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; ------------- 0.96
;; ------------- 0.95
;; ------------- 0.94
;; 03/21/96 bill %typed-uvref -> aref inside a lying declaration.
;; ------------- 0.93
;; ------------- 0.9
;; ------------- 0.8
;; ------------- 0.6
;; 03/18/92 bill New file
;;

(In-package :wood)

(defclass disk-cache-inspector (inspector::usual-object-first-inspector) ())

; True to bring up the contents editor by default instead of the structure editor.
(defparameter *inspect-disk-cache-data* t)

(defmethod inspector::inspector-class ((object disk-cache))
  (if *inspect-disk-cache-data*
    'disk-cache-inspector
    (call-next-method)))

(defclass disk-cache-inspector-view (inspector::inspector-view)
  ((last-address :initform nil :accessor last-address)
   (current-address :initform nil :accessor current-address))
  (:default-initargs :cache-p nil))

(defmethod inspector::inspector-view-class ((in disk-cache-inspector))
  'disk-cache-inspector-view)

(defmethod inspector::compute-line-count ((in disk-cache-inspector))
  (floor (+ (disk-cache-size (inspector::inspector-object in)) 15) 16))

(defun encode-hex (value string index digits)
  (unless (and (simple-string-p string)
               (fixnump index)
               (fixnump digits)
               (>= index 0)
               (<= (the fixnum (+ index digits)) (length string))
               (fixnump value))
    (error "You lose."))
  (%encode-hex value string index digits))

(defconstant *hex-digits* "0123456789ABCDEF")

(defun %encode-hex (value string index digits-left)
  (declare (optimize (speed 3 safety 0)))
  (declare (fixnum pos digits-left value))
  (if (eql digits-left 0)
    index
    (let ((r (logand value #xf))
          (q (ash value -4)))
      (declare (fixnum r q))
      (let ((i (%encode-hex q string index (the fixnum (1- digits-left)))))
        (setf (schar string i) (schar *hex-digits* r))
        (the fixnum (1+ i))))))

(defparameter *disk-cache-inspector-string*
  (make-string 16 :element-type 'base-character))
(defparameter *disk-cache-inspector-value*
  (make-string (+ 8 2 8 1 8 1 8 1 8 2 16 2)
               :initial-element #\space
               :element-type 'base-character))

(defmethod inspector::line-n ((in disk-cache-inspector) n)
  (let* ((disk-cache (inspector::inspector-object in))
         (address (* n 16))
         (size (disk-cache-size disk-cache))
         (string *disk-cache-inspector-string*)
         (value *disk-cache-inspector-value*))
    (let ((count (min 16 (- size address))))
      (read-string disk-cache address count string)
      (do ((i count (1+ i)))
          ((>= i 16))
        (declare (fixnum i))
        (setf (schar string i) (code-char 0))))
    (encode-hex address value 0 8)
    (setf (schar value 8) #\:)
    (let ((index 10)
          (word -1))
      (declare (fixnum index word))
      (locally (declare (type (simple-array (unsigned-byte 16) (*)) string)
                        (optimize (speed 3) (safety 0)))
        (dotimes (i 4)
          (encode-hex (aref string (incf word)) value index 4)
          (encode-hex (aref string (incf word)) value (incf index 4) 4)
          (incf index 5)))
      (setf (schar value (incf index)) #\")
      (dotimes (i 16)
        (let ((char (schar string i)))
          (declare (character char))
          (setf (schar value (incf index))
                (if (graphic-char-p char) char #\.))))
      (setf (schar value (incf index)) #\")
      (values value
              nil
              :static))))

(defmethod inspector::prin1-value ((i disk-cache-inspector) stream value
                                   &optional label type)
  (declare (ignore label type))
  (if (stringp value)
    (stream-write-string stream value 0 (length value))
    (call-next-method)))

(defmethod inspector::inspect-selection ((v disk-cache-inspector-view))
  (let ((selection (inspector::selection v)))
    (if (eql 0 selection)
      (call-next-method)
      (let ((address (* (1- selection) 16))
            (h (point-h (view-mouse-position v))))
        (multiple-value-bind (ff ms) (view-font-codes v)
          (let* ((w (nth-value 2 (font-codes-info ff ms)))
                 (char (round h w))
                 (word (floor (- char 10) 9))
                 (dc (inspector::inspector-object v))
                 (new-address (cond ((< word 0) address)
                                    ((> word 3) (ed-beep) (cancel))
                                    (t (read-unsigned-long dc (+ address (* word 4)))))))
            (if (option-key-p)
              (setq @ new-address)
              (progn
                (when (> new-address (disk-cache-size dc))
                  (ed-beep) (cancel))
                (scroll-to-address v new-address)))))))))

(defmethod inspector::inspector-commands ((dc disk-cache))
  `(("Inspect contents"
     ,#'(lambda () (let ((*inspect-disk-cache-data* t))
                     (inspect dc))))))

(defmethod inspector::inspector-commands ((in disk-cache-inspector))
  (let ((view (inspector::inspector-view in)))
    `(("Inspect struct"
     ,#'(lambda () (let ((*inspect-disk-cache-data* nil))
                     (inspect (inspector::inspector-object in)))))
      ("Go to address..."
       ,#'(lambda ()
            (let ((address (let ((*read-base* 16))
                             (read-from-string
                              (get-string-from-user "Enter an address (hex):")))))
              (if (integerp address)
                (scroll-to-address view address)))))
      ,@(let ((last-address (last-address view)))
          (when last-address
            `((,(format nil "Go to address #x~x" last-address)
               ,#'(lambda ()
                    (scroll-to-address view last-address))))))
      ,@(let ((current-address (current-address view)))
          (when current-address
            `((,(format nil "Go to address #x~x" current-address)
               ,#'(lambda ()
                    (scroll-to-address view current-address)))))))))

(defmethod scroll-to-address ((v disk-cache-inspector-view) address)
  (setf (last-address v) (current-address v))
  (setf (current-address v) address)
  (setq @ address)
  (let* ((inspector (inspector::inspector v))
         (dc (inspector::inspector-object inspector)))
    (inspector::scroll-to-line
     v
     (1+ (floor (min (disk-cache-size dc) address) 16))
     nil
     0)
    (unless (eql (inspector::compute-line-count inspector)
                 (inspector::inspector-line-count inspector))
      (inspector::resample v))))
;;;    1   3/10/94  bill         1.8d247
;;;    2   3/23/95  bill         1.11d010
