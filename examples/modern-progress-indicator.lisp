;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; modern-progress-indicator.lisp
;;;
;;; MAKES THE PROGRESS-INDICATOR OF THE MCL EXAMPLES USE APPEARANCE.
;;;
;;; 1999-2009 Terje Norderhaug <terje@in-progress.com>
;;;
;;; Use and copying of this software and preparation of derivative works
;;; based upon this software are permitted, so long as this copyright 
;;; notice and the author's name are included intact in this file or the
;;; source code of any derivative work
;;; 
;;; This software is made available AS IS, and no warranty is made about 
;;; the software or its performance. 
 
(in-package :ccl)

(pushnew "ccl:examples;appearance-manager-Folder;" *module-search-path* :test #'equalp)

;; The progress indicator from the MCL examples: 

(eval-when (:load-toplevel :execute)
  (require :progress-indicator)
  (require :progress-bar-dialog-item) 
  (require :new-control-dialog-item) 
  (require :appearance-utils))

;; Eric Russell's excellent modules:

(eval-when (:load-toplevel :execute)
  (require :appearance-manager)
  (require :scrolling-windows)
  (require :progress-bar-dialog-item))

(let ((*warn-if-redefine* nil))

(defclass progress-indicator-dialog (window)
  ((task :reader progress-task :initarg :task))
  (:default-initargs :color-p t
    :view-font #+modern-mcl :system-font #-modern-mcl (system-font-spec)
    :view-position *progress-indicator-view-position*
    :view-size #@(#.(+ 14 210 14 59) #.(+ 7 15 14 15 14 15 14 -7))
    :window-type #-ccl-5.2 #$kMovableModalDialogVariantCode #+ccl-5.2 :movable-dialog
    :grow-icon-p nil
    #+carbon-compat :theme-background #+carbon-compat T
    :back-color (when (and (appearance-available-p) #+carbon-compat(not (osx-p))) *lighter-gray-color*)
    :content-color (when (and (appearance-available-p) #+carbon-compat(not (osx-p))) *lighter-gray-color*)
))

) ; end redefine

(defmethod install-view-in-window :after ((view progress-thermometer) (window progress-indicator-dialog))
  (when (appearance-available-p)
    (add-subviews view
      (make-instance 'progress-bar-dialog-item
        :determinate-p (not (null (task-denominator view)))
        :min 0
        :view-position #@(0 0)
        :view-size (- (view-size view) #@(2 2))))))

(defmethod view-draw-contents ((view progress-thermometer))
  (if (appearance-available-p)
    (let* ((bar (first (subviews view 'progress-bar-dialog-item)))
           (task (progress-task (view-window view)))
           (determinate? (not (null (task-denominator task)))))
        (set-progress-bar-determinate-p bar
             determinate?)
        (when determinate?
          (set-progress-bar-max bar 
              (task-denominator task))
          (set-progress-bar-setting bar 
              (task-numerator task)))
        (call-next-method))
    (let ((task view)
          (pos #@(0 0))
          (size (view-size view))
          (row view))
      (row-draw-bar pos size row task))))

(setf ccl::*progress-indicator-view-position* '(:top 100))

(provide :modern-progress-indicator)

#| EXAMPLES:

(in-package :ccl)

(init-appearance-manager)

(with-shown-progress (task "Count")
  (dotimes (i 4)
    (show-progress task :numerator i :denominator nil :note (format NIL "count ~A" i))
    (sleep 1)))

(with-shown-progress (task "Count" :denominator 4)
  (dotimes (i 4)
    (show-progress task :numerator (1+ i) :denominator 4 :note (format NIL "count ~A" i))
    (sleep 1)))

;; Check out the progress indicators with their old look:

(setf *appearance-available-p* NIL)

|#