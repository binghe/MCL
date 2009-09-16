; -*- Mode:Lisp; Package:CCL; -*-

;;	Change History (most recent first):
;;  1 5/7/95   slh  new file
;;  (do not edit before this line!!)

;; dialog-macros.lisp
;; Convenience macros for laying out dialogs.
;; Copyright 1995 Digitool, Inc.

;;; 12/01/03 akh fudge height by 1 more for typein-meny
;;; 11/08/03 akh fix vertical-labeled-items for pop-up-menu and typein-menu
;;; ------- 5.0 final

(in-package :ccl)

; makes dialog description less verbose and if params are constants we do
; arithmetic at compile time rather than run time
#| ;; wrong
(defmacro vertical-labeled-items (&key dialog-width delta lmargin col2 vpos (font (sys-font-spec)) lastvar items)
  (let ((n 0) result)
    (dolist (vitem items)
      (destructuring-bind (title type nickname &optional width &rest keys) vitem
        (let* ((adjust (if (memq type '(pop-up-menu typein-menu)) 4 0))
               (height (font-line-height font)))
          (when (and (memq type '(pop-up-menu typein-menu))) ;;  *use-pop-up-control*) ;; oops thats compile-time assume true always today
            (setq height (+ height 4))
            (cond ((< height 18)(setq height 18))
                  ((and (> height 18)(< height 22))(setq height 22))))            
          (setq result
                (nconc result
                       `(,@(when title
                             `((make-dialog-item 
                                'static-text-dialog-item                                
                                ,(make-point lmargin (+ vpos  (* delta n)))
                                nil 
                                ,title
                                )))
                         (make-instance ',type
                           :view-position                         
                           ,(make-point (if title (- col2 (/ adjust 2)) lmargin)
                                        (+ vpos (/ adjust -2) (* delta n)))
                           :view-size
                           ,(make-point (or width (+ adjust  (- dialog-width col2 10)))
                                        (+ height #|adjust|#))  ; editable-text of 16 is really 20                              
                           :view-nick-name ',nickname
                           ,@(if (eq type 'editable-text-dialog-item) '(:draw-outline -2))
                           ,@keys))))
          (setq n (1+ n)))))
    `(progn
       ,(if lastvar `(setq ,lastvar ,(+ vpos (* delta n))))
       (list ,@result))))
|#

(defmacro vertical-labeled-items (&key dialog-width delta lmargin col2 vpos (font (sys-font-spec)) lastvar items)
  (let ((n 0) result)
    (dolist (vitem items)
      (destructuring-bind (title type nickname &optional width &rest keys) vitem
        (let* ((adjust (if (memq type '(pop-up-menu typein-menu)) 4 0))
               (v-adjust (if (eq type 'typein-menu) 1 0))  ;; why ??
               (height (font-line-height font)))
          (setq result
                (nconc result
                       `(,@(when title
                             `((make-dialog-item 
                                'static-text-dialog-item                                
                                ,(make-point lmargin (+ vpos  (* delta n)))
                                nil 
                                ,title
                                )))
                         (make-instance ',type
                           :view-position                         
                           ,(make-point (if title (- col2 (/ adjust 2)) lmargin)
                                        (+ vpos (/ adjust -2) (* delta n)))
                           :view-size
                           ,(make-point (or width (+ adjust  (- dialog-width col2 10)))
                                        (+ height adjust v-adjust))  ; editable-text of 16 is really 20                              
                           :view-nick-name ',nickname
                           ,@(if (eq type 'editable-text-dialog-item) '(:draw-outline -2))
                           ,@keys))))
          (setq n (1+ n)))))
    `(progn
       ,(if lastvar `(setq ,lastvar ,(+ vpos (* delta n))))
       (list ,@result))))

; End of dialog-macros.lisp
