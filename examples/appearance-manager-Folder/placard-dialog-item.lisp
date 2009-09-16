;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; placard-dialog-item.lisp
;;; PROVIDES A DIALOG ITEM FOR PLACARDS
;;;
;;; Copyright ©2000 Terje Norderhaug and Media Design in¥Progress
;;;
;;; Use and copying of this software and preparation of derivative works
;;; based upon this software are permitted, so long as this copyright 
;;; notice and the author's name are included intact in this file or the
;;; source code of any derivative work
;;;
;;; Digitool, Inc. is permitted to integrate parts or whole of this module 
;;; into MCL without including the copyright notice, as long as the author's
;;; name is included in any file containing or derived from the contents
;;; of this file.
;;; 
;;; This software is made available AS IS, and no warranty is made about 
;;; the software or its performance. 
;;;
;;; Author: Terje Norderhaug <terje@in-progress.com>
;;;
;;; Tested on MCL 4.3, but should also work with other recent versions of MCL.
;;; Backward compatible if appearance isn't available.

#| VERSION HISTORY 

18-Jul-2000 TN view-click-event-handler sets the position of menu to same as view.
17-Jul-2000 TN Version 1.0 released.

|#

;; #_drawtext -> grafport-write-string
;; ---- 5.2b4

(in-package :ccl)

(pushnew *loading-file-source-file*
    *module-search-path*
    :test #'equalp)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :new-control-dialog-item)
  (require :appearance-activity-mixin))

;; --------------------------------------------------------------------

(defclass placard-dialog-item (new-control-dialog-item)
  ((procid :allocation :class :initform #$kControlPlacardProc)
   (menu :initform NIL :initarg :menu))
  (:default-initargs
   :view-position #@(0 0)
   :view-size #@(64 16)))

(defmethod view-draw-contents ((item placard-dialog-item))
  (call-next-method)
  (with-item-rect (rect item)
    (with-font-focused-view item
      (with-fore-color (if (draw-active-p item)
                         *black-color* *gray-color*)
        #+ignore
        (with-cstrs ((text (dialog-item-text item)))
         (when text
          (let ((length (length (dialog-item-text item))))
            (#_MoveTo 4 11)
            (#_DrawText text 0 length))))
        #-ignore
        (let ((text (dialog-item-text item)))
          (when text
            (#_moveto 4 11)
            (grafport-write-string text 0 (length text)))) 
        ))))

(defmethod view-draw-no-appearance-contents ((item placard-dialog-item))
  (with-item-rect (rect item)
    (#_FrameRect rect)))

(defmethod view-click-event-handler ((view placard-dialog-item) where)
  (declare (ignore where))
  (let ((menu (slot-value view 'menu)))
    (when menu
      (unless (menu-installed-p menu)
        (setf (pop-up-menu-auto-update-default menu) nil)
        (menu-install menu))
      (set-view-position menu (view-position view))
      (menu-select menu NIL))))

;; These may potentially be eliminated by toggling the order of hiliting vs invalidation in superclasses:

(defmethod view-activate-event-handler ((item placard-dialog-item))
  (call-next-method)
  (invalidate-view item))

(defmethod view-deactivate-event-handler ((item placard-dialog-item))
  (call-next-method)
  (invalidate-view item))

#|

;(init-appearance-manager)

(make-instance 'window
  :view-size #@(200 100)
  :view-subviews
    (list
      (make-instance 'placard-dialog-item :view-position #@(-1 85) :view-size #@(60 16)
        :view-font '("Geneva" 9)
        :dialog-item-text "100%")
      (make-instance 'placard-dialog-item :view-position #@(58 85) :view-size #@(60 16)
        :view-font '("Geneva" 9)
        :dialog-item-text "Line 33")))

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide :placard-dialog-item)

