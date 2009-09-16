;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  3 7/18/96  akh  move macroexpand stuff here
;;  2 10/17/95 akh  merge patches
;;  2 5/22/95  akh  bind *enqueued-window-title* in window-enqueue-region
;;  (do not edit before this line!!)


; l1-ed-lds.lisp
; Copyright 1995 Digitool, Inc. The 'tool rules!
; akh move key bindings here, and some more fns
(in-package :ccl)

(defvar *enqueued-window-title* nil)
; no more funcall-in-top-listener-process - just do eval-enqueue NOW
(defmethod window-enqueue-region ((w fred-mixin) start end 
                                  &optional mini-str single-selection? evalp)
  (let ((stream (window-selection-stream w start end)))
    (eval-enqueue ; could just be the function
     `(funcall ,#'(lambda ()
                    (let ((success nil))
                      (unwind-protect
                        (let ((*enqueued-window-title* (if (not (window-filename w))
                                                         (window-title (view-window w)))))
                          (declare (special *enqueued-window-title*))
                          (selection-eval stream single-selection? evalp)
                          (setq success t))
                        (stream-close stream)
                        (when (and mini-str (view-mini-buffer w))
                          (set-mini-buffer (view-window w)
                                           (if success
                                             mini-str
                                             "Aborted."))))))))))


(defmethod window-eval-whole-buffer ((w fred-mixin))
  (when (view-mini-buffer w)
    (set-mini-buffer w "~&Execute Buffer…"))
  (window-enqueue-region w 0 t " done."))

(defmethod window-eval-selection ((w fred-mixin) &optional evalp
                                  &aux (buf (fred-buffer w)))
  (let* ((frec (frec w))
  	   (single-selection? nil)
         (pos (buffer-position (fred-buffer w))))
    (multiple-value-bind (b e) (frec-get-sel frec)
      (if (eq b e)
        (multiple-value-bind (start end)
                             (buffer-current-sexp-bounds buf pos)
          (when (and start end)
	      (setq single-selection? t)
            (setq b start e end)))
        (frec-set-sel-simple frec pos pos))
      (if (eq b e)
        (ed-beep)
        (progn
          (when (view-mini-buffer w)
            (set-mini-buffer w "~&Execute…"))
          (window-enqueue-region w b e " done." single-selection? evalp)
          (fred-update w)
          ;(window-show-cursor w)
          )))))

(comtab-set-key *control-x-comtab* '(:control #\c)    'ed-eval-or-compile-top-level-sexp)
(comtab-set-key *control-x-comtab* '(:control #\e)    'ed-eval-current-sexp)
(comtab-set-key %initial-comtab%  #\Enter             'ed-eval-or-compile-current-sexp)
(comtab-set-key *control-x-comtab* '(:control #\m)    'ed-macroexpand-current-sexp)
(comtab-set-key %initial-comtab% '(:control #\m)      'ed-macroexpand-1-current-sexp)

(defmethod ed-eval-or-compile-current-sexp ((w fred-mixin))
  "if *compile-definitions* is NIL, then evals defs, else compiles them.
   Used by the ENTER key."
  (window-eval-selection w))

(defmethod ed-eval-current-sexp ((w fred-mixin))
  "Evals current expression regardless of value of *compile-definitions*."
  (window-eval-selection w t))

(defmethod ed-eval-or-compile-top-level-sexp ((w fred-mixin))
  "if *compile-definitions* is NIL, then evals defs, else compiles them."
  (let* ((buf (fred-buffer w))
         (pos (buffer-position buf))
         (start (ed-top-level-sexp-start-pos buf pos t))
         (end (and start (buffer-fwd-sexp buf start))))
    (if (or (null end)
            (not (<= start pos  end)))
      (ed-beep)
      (progn
        (set-mini-buffer w "~&Execute…")
        (window-enqueue-region w start end " done." t)))))

(defmethod ed-macroexpand-current-sexp ((w fred-mixin))
  (multiple-value-bind (form endp) (ed-current-sexp w)
    (if endp
      (let ((stream t)) ;(lds t w)))
        (flet ((expand-fn ()
                 (pprint (let ((*package* (or (fred-package w)
                                              *package*)))
                           (macroexpand form))
                         stream)))
          (if (find-class 'listener nil)
           (funcall-in-top-listener-process #'expand-fn)
           (funcall #'expand-fn))))
      (ed-beep))))

(defmethod ed-macroexpand-1-current-sexp ((w fred-mixin))
  (multiple-value-bind (form endp) (ed-current-sexp w nil t)
    (if endp
      (let ((printed nil)
            (stream t)) ;(lds t w)))
        (flet ((expand-fn ()
             (loop
               (multiple-value-setq (form endp)
                 (let ((*package* (or (fred-package w) *package*)))
                   (macroexpand-1 form)))
               (unless endp 
                     (unless printed (pprint form stream))
                     (return))
                   (setq printed t)
                   (pprint form stream)
                   (fresh-line stream))))
          (if (find-class 'listener nil)
           (funcall-in-top-listener-process #'expand-fn)
           (funcall #'expand-fn))))
      (ed-beep))))


; End of l1-ed-lds.lisp
