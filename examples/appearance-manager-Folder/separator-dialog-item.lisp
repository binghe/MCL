;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; separator-dialog-item.lisp
;;;
;;; A SEPARATOR DIALOG ITEM A LA MACOS8 WITH BW COMPATABILITY FOR OLDER VERSIONS OF MACOS.
;;;
;;; Copyright © 1999 Terje Norderhaug and Media Design in¥Progress
;;;
;;; Use and copying of this software and preparation of derivative works
;;; based upon this software are permitted, so long as this copyright 
;;; notice is included intact.
;;;
;;; Digitool is welcome to integrate parts or whole of this module in MCL without
;;; including the copyright note, as long as the author is mentioned in the version history.
;;;
;;; This software is made available AS IS, and no warranty is made about 
;;; the software or its performance. 
;;;
;;; Author: Terje Norderhaug <terje@in-progress.com> of Media Design in*Progress.
;;;
;;; Latest version available from <http://www.in-progress.com/src/separator-dialog-item.lisp>.
;;; Tested on MCL 4.2, but should also work with other recent versions of MCL.
;;; Optionally use with the Appearance Manager contribution to MCL by Eric Russell <eric-r@nwu.edu>
;;; to get the latest look & feel.

#| VERSION HISTORY

1999-07-10 Terje  Version 1.0 released.

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :ccl)

(eval-when (:load-toplevel :execute)
  (export 'separator-dialog-item))

(defclass separator-dialog-item (dialog-item)
  ()
  (:default-initargs
   ; Only customize colors for no appearance manager
   :part-color-list `(:separator-color ,*gray-color* 
                      :disabled-color ,*light-gray-color* 
                      :hilite-color , *white-color*)
   :dialog-item-text ""))

(defmethod initialize-instance ((item separator-dialog-item) &rest rest &key view-height view-length view-width view-size)
  ;; don't use view-length, only for bw compatability with authors old code :-(
  (declare (dynamic-extent rest))
  (assert (not (and view-height (or view-width view-length))))
  (apply #'call-next-method item
    :view-size
      (if (or view-height view-length view-width) 
        (make-point
          (or view-width view-length 3)
          (or view-height 3))
         view-size)
    rest))

(defmethod view-activate-event-handler :after ((item separator-dialog-item))
  (invalidate-view item))

(defmethod view-deactivate-event-handler :after ((item separator-dialog-item))
  (invalidate-view item))

(eval-when (:load-toplevel :execute)
  (unless (fboundp 'appearance-available-p)
    (defun appearance-available-p ()
      NIL)))

(defmethod view-draw-contents ((item separator-dialog-item))
  (declare (function appearance-available-p))
  (if t ;(appearance-available-p) ;; still works even if no appearance
    (with-item-rect (rect item)
      (#_DrawThemeSeparator rect
        (if (window-active-p (view-window item))
          1 ; $kThemeStateActive
          0 ; $kThemeStateDisabled
        )))
    ;; Pre-OS8 compatability: 
    (let* ((active? (window-active-p (view-window item)) )
           (position (+ (view-position item) #@(0 1)))
           (size (view-size item))
           (bottomright
             (if (< (point-v size)(point-h size))
               (make-point (+ (point-h size) (point-h position) -1) (point-v position))
               (make-point (point-h position) (+ (point-v size) (point-v position) -1)))))
       (with-fore-color (part-color item (if active? :separator-color :disabled-color))
         (#_MoveTo :long position)
         (#_LineTo :long bottomright))
       (with-fore-color (part-color item (if active? :hilite-color :disabled-color))
         (#_MoveTo :long (+ position #@(1 1)))
         (#_LineTo :long (+ bottomright #@(1 1)))))))

#| DEMO:

(require :appearance-manager)
(init-appearance-manager)

(make-instance 'dialog
  :back-color ccl::*lighter-gray-color*
  :view-subviews
    (list
      (make-instance 'separator-dialog-item 
        :view-position #@(15 10) 
        :view-length 150)
      (make-instance 'separator-dialog-item 
        :view-position #@(10 15) 
        :view-height 150)))
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Do not edit beyond this line

(provide :separator-dialog-item)
