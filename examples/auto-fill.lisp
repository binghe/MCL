;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 5/1/95   akh  copyright
;;  (do not edit before this line!!)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-fill.lisp
;; Copyright 1990-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.
;;
;;  A simple auto-fill mode for Fred.
;;
;;  (autofill-mode fill-length)
;;    Makes space insert a newline & indentation if the line is longer
;;    than fill-length
;;
;;  (autofill-mode nil)
;;     Turns off auto-fill mode.
;;

;;;;;;;
;;
;; Change history
;; 
;; 08/28/91 gb   (Allegedly) cosmetic changes.
;; 05/17/91 bill scroll full left after inserting return char.
;; --- 2.0b1 ---

(in-package :ccl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(auto-fill-mode)))

(defun comment-prefix (buf start end)
  (buffer-substring buf start 
                        (or (buffer-not-char-pos buf "; " :start start :end end)
                                 end)))

(defun fill-mode-prefix (buf pos)
  (let* ((start (buffer-line-start buf pos))
         (comment (buffer-char-pos buf ";" :start start :end (1+ pos))))
    (and comment
         (concatenate 'simple-string
                      (make-string (- comment start) :initial-element #\space)
                      (comment-prefix buf comment pos)))))


(defconstant *wsp&cr2* #.(let ((str (make-string 7)))
                          (setf (schar str 0) #\Space)
                          (setf (schar str 1) #\^M)
                          (setf (schar str 2) #\^I)
                          (setf (schar str 3) #\^L)
                          (setf (schar str 4) #\^@)
                          (setf (schar str 5) #\^J)
                          (setf (schar str 6) (code-char #xCA))
                          str))

(defun auto-fill-mode (fill-length)
  "fill-length should be nil or a positive integer"
  (etypecase fill-length
    (null (comtab-set-key *comtab* #\return 'ed-self-insert)
          (comtab-set-key *comtab* #\space 'interactive-arglist))
    ((integer 5 500)
     (flet ((auto-fill-or-insert (w)
              (let* ((buf (fred-buffer w))
                     (end-pos (buffer-position buf))
                     (end-column (buffer-column buf end-pos)))

                (when (> end-column fill-length)
                  (do ((break-pos end-pos 
                                  (buffer-char-pos buf *wsp&cr2* :start 0 :end break-pos
                                                   :from-end t)))
                      ((or (null break-pos)
                           (<= (buffer-column buf break-pos) fill-length))
                       (when break-pos
                         (let ((c (fill-mode-prefix buf break-pos)))
                           (buffer-char-replace buf #\return break-pos)
                           (set-fred-hscroll w 0)
                           (if c
                               (buffer-insert buf c (1+ break-pos))
                               (ed-indent-for-lisp w (1+ break-pos))))))))
                (if (eql *current-character* #\space)
                  (interactive-arglist w)
                  (ed-self-insert w)))))
       (comtab-set-key *comtab* #\return #'auto-fill-or-insert)
       (comtab-set-key *comtab* #\space #'auto-fill-or-insert)))))
