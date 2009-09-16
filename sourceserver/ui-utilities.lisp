(in-package :ccl)
(provide 'ui-utilities)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;

(defun first-subview (view &optional class)
  (flet ((return-first (subview) (return-from first-subview subview)))
    (declare (dynamic-extent #'return-first))
    (map-subviews view #'return-first class)
    nil))

;;;
;;; Window utility functions
;;;

(defmacro do-windows (var&options &body body)
  (unless (listp var&options) (setq var&options (list var&options)))
  (destructuring-bind (var &rest options) var&options
    (let ((do-window (make-symbol "DO-WINDOW")))
      `(flet ((,do-window (,var) ,@body))
         (declare (dynamic-extent (function ,do-window)))
         (map-windows #',do-window ,@options)))))

(defmacro do-pathname-windows ((window path) &body body)
  `(map-pathname-windows #'(lambda (,window) ,@body) ,path))

;;; ENQUEUE-ACTION executes deferred commands, and is currently used in menu items.
;;; It's currently built on top of EVAL-ENQUEUE, but since it uses real functions
;;; instead of simple-eval-ed lists, it makes it easier for us to put different
;;; schedulers beneath it.

(export '(fn-enqueue enqueue-action enqueued-action eval-enqueued-action))

(defun fn-enqueue (fn)
  (eval-enqueue `(funcall ,fn)))

;; Given one argument, enqueues it as a closure.  Given two, enqueues the
;; second with the variable bindings given in the first.
;;
;; Examples:
;;	(enqueue-action (load (ask-for-file)))
;;	(enqueue-action ((file (ask-for-file)))
;;	   (load file))
;; Executing the first form has no immediate effect, but the next time
;; the toplevel-reader gets time, the user will be asked for a file and
;; that file will be loaded.  Executing the second form asks the reader
;; for the file immediately, and loads it later.
;;
;; The inner IF clause is an optimization to avoid consing closures for forms
;; that are already funcallable.  It could be eliminated, given a smart compiler.
(defmacro enqueue-action (bindings-or-form &body forms)
  (if forms
    `(let* ,bindings-or-form
       (enqueue-action ,(if (rest forms)
                          `(progn ,@forms)
                          (first forms))))
    (flet ((function-form-p (form)
             (and (listp form) (eq (first form) 'function)))
           (parameterless-function-call-p (form)
             (and (listp form) (symbolp (first form)) (null (rest form)))))
      (symbol-macrolet ((form bindings-or-form))
        (cond ((or (constantp form)
                  (function-form-p form))
               `(fn-enqueue ,form))
              ((parameterless-function-call-p form)
               `(fn-enqueue (symbol-function ',(first form))))
              (t
               `(fn-enqueue #'(lambda () ,form))))))))


;; ENQUEUED-ACTION creates a function that will enqueue an action; such
;; functions are suitable for attachment to a menu item.

(defmacro enqueued-action (bindings-or-form &body form-or-nil)
  `#'(lambda () (enqueue-action ,bindings-or-form ,@form-or-nil)))

;; This should go away.
(defun eval-enqueued-action (form)
  "Save 12 bytes"
  #'(lambda () (eval-enqueue form)))


;;;
;;; Progress
;;;

(defvar *report-progress-to-listener* t)

(defun report-progress (format-string &rest format-args)
  (declare (dynamic-extent format-args))
  (if *report-progress-to-listener*
    (progn (terpri)
           (apply #'format t format-string format-args))
    (let ((window (front-window :class 'fred-window)))
      (when window
        (apply #'set-mini-buffer window format-string format-args)))))

;;;
;;; Small icons
;;;

(defparameter *read-only-small-icon* nil)
(defparameter *writable-small-icon* nil)
(defparameter *modro-small-icon* nil)

(defun make-small-icon-bitmap (hex-string)
  (let* ((bm (#_NewPtr :errchk 78))
         (base-ptr (%inc-ptr bm 14)))
    (%put-ptr bm base-ptr) ;BaseAddr
    (%put-word bm 2 4)             ;rowbytes
    (%put-long bm #@(0 0) 6)       ;lower-left
    (%put-long bm #@(16 16) 10)    ;bottom-right
    (with-pstrs ((sp hex-string))
      (#_StuffHex base-ptr sp))
    bm))

(def-load-pointers projector-icons ()
  (setq *read-only-small-icon* (make-small-icon-bitmap
                                "40006000307018880CC807380310039002E0046004700798070C0606BC020000"))
  (setq *writable-small-icon* (make-small-icon-bitmap
                                "000000000070008800C8013801100210022004200440078007000600BC000000"))
  (setq *modro-small-icon* (make-small-icon-bitmap
                                "400040000070088808C8013801100210022004200450079007000602BC020000")))

(defun draw-small-icon (window small-icon position)
  (let ((wptr (wptr window)))
    (rlet ((trect :rect
                :topleft position
                :bottomright (add-points position #@(16 16))))
      (with-fore-color *black-color*
        #+carbon-compat
        (with-dereferenced-handles ((pixmap (#_getportpixmap (#_getwindowport wptr))))
          (#_CopyBits small-icon pixmap (%inc-ptr small-icon 6) trect 0 (%null-ptr)))
        #-carbon-compat
        (#_CopyBits small-icon (rref wptr windowRecord.portbits) (%inc-ptr small-icon 6) trect 0 (%null-ptr))))))

;(draw-small-icon (target) *modro-small-icon* #@(0 50))





;;;
;;; Splash screen
;;;

(defun make-save-hula-splash-window ()
  (make-instance 'window
    :view-position '(:top 100)
    :view-size #@(300 80)
    :window-type :double-edge-box
    :view-subviews
    (list
     (make-dialog-item 'static-text-dialog-item
       #@(5 10) #@(450 30) "Saving Leibniz Image…" nil
       :view-font '("Times" 24))
     (make-dialog-item 'static-text-dialog-item
       #@(25 40) #@(450 20) "" nil
      :view-font '("Monaco" 12)
      :view-nick-name 'progress-text))))

;(make-save-hula-splash-window)
;(set-splash-window-progress-string (target) "Saving the ARM snapshot (~D%)")
;(window-close (target))

(defun set-splash-window-progress-string (w message)
  (let ((v (view-named 'progress-text w)))
    (set-dialog-item-text v message)
    (window-update-event-handler w)))

#|
	Change History (most recent last):
	1	4/29/92	ows	
	1	9/28/93	HW	Now it's in RSTAR SourceServer.
|# ;(do not edit past this line!!)
