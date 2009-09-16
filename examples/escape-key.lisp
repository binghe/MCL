;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 5/22/95  akh  mask was wrong
;;  (do not edit before this line!!)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; escape-key.lisp
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.
;;
;; Make the "ESC" key cause the next character to behave as if the Meta
;; key were pressed (just like EMACS on keyboards without a Meta key).
;;
;;

(in-package :ccl)

;;; Escape key for Fred.

(defparameter *escape-key-comtab*
  (make-comtab #'(lambda (w) (run-meta-fred-command w))))

(defun run-meta-fred-command (w)
  ;; #x100 is a mask with the option-key bit set. NO IT ISNT
  (let ((*current-keystroke* (logior #$OPTIONKEY *current-keystroke*)))
    (funcall (keystroke-function w *current-keystroke*
				 (slot-value w 'comtab))
             w)))

; Make sure we get "ESC", not "Clear" as the name for the escape key.
(pushnew '("ESC" .  #\033) *name-char-alist* :key #'car :test #'string-equal)

(comtab-set-key *comtab* '(#\esc) *escape-key-comtab*)

