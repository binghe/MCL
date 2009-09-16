; -*- Mode:Lisp; Package:CCL; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ift-macros.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  macro definitions needed to compile the interface designer
;;


(in-package :interface-tools)

;; akh lose more - redefining while and until is a poor idea
;; akh - lose macro get-window-port

; These symbols appear in multiple files.
; These declarations prevent compiler warnings from compile-ift.
(proclaim '(special
            *cross-hair-cursor* *editing-dialogs* *current-item-palette*))

(defmacro item-lambda ((&optional item) &body body)
  (let ((item-var (or item (gensym))))
    `(nfunction dialog-item-action
                (lambda (,item-var)
                  ,@(unless item `((ignore ,item-var)))
                  ,@body))))


(defmacro while (test &body body)
  (let ((testlab (gensym)))
    `(tagbody
      ,testlab
      (if ,test
        (progn
         ,@body
         (go ,testlab))))))



(defmacro until (test &body body)
  (let ((testlab (gensym)))
    `(tagbody
      ,testlab
      (if (not ,test)
        (progn
         ,@body
         (go ,testlab))))))


#|
(defmacro window-manager-port ()
  '(%stack-block ((port 4))
     (require-trap #_GetWMgrPort :ptr port) ;; evil if osx
     (%get-ptr port)))
|#

