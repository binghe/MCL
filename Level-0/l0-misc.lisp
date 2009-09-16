;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: l0-misc.lisp,v $
;;  Revision 1.4  2003/12/08 07:56:56  gtbyers
;;  Add WRITE-STRING-TO-FILE-DESCRIPTOR.
;;
;;  3 10/26/95 gb   not sure
;;  2 10/6/95  gb   I forget.
;;  (do not edit before this line!!)


; Miscellany.

(defun memq (item list)
  (do* ((tail list (%cdr tail)))
       ((null tail))
    (if (eq item (car tail))
      (return tail))))

(defun assq (item list)
  (dolist (pair list)
    (when (and pair (eq item (car pair)))
      (return pair))))


(defun append-2 (y z)
  (if (null y)
    z
    (let* ((new (cons (car y) nil))
           (tail new))
      (declare (list new tail))
      (dolist (head (cdr y))
        (setq tail (cdr (rplacd tail (cons head nil)))))
      (rplacd tail z)
      new)))

(defun %strip-address (ptr)
  #+ppc-target
  ptr
  #-ppc-target
  (%setf-macptr ptr (#_StripAddress ptr)))

(eval-when (:load-toplevel)
  (when (not (fboundp 'require-type))
    (defun require-type (val type)
      (declare (ignore type))
      val)))

;; redefined later
(eval-when (:load-toplevel)
(when (not (fboundp 'type-specifier-p))
(defun type-specifier-p (form)
  (declare (ignore form))
  t)))

(defun write-string-to-file-descriptor (string &key (fd 2) (newline nil))
  (when (osx-p)
    (let* ((len (length string))
           (n (if newline (1+ len) len)))
      (%stack-block ((s n))
        (dotimes (i len) (setf (%get-unsigned-byte s i)
                             (%char-code (aref string i))))
        (when newline
          (setf (%get-unsigned-byte s len) (%char-code #\LineFeed)))

        (%write-to-file-descriptor fd s n)))))
