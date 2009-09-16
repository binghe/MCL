;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; new-control-dialog-item.lisp
;;;
;;; MCL CLASS FOR NEW MACOS 8 CONTROLS
;;;
;;; Copyright ©1997-1999
;;; Supportive Inquiry Based Learning Environments Project
;;; Learning Sciences Program
;;; School of Education & Social Policy
;;; Northwestern University
;;;
;;; Use and copying of this software and preparation of derivative works
;;; based upon this software are permitted, so long as this copyright 
;;; notice is included intact.
;;;
;;; This software is made available AS IS, and no warranty is made about 
;;; the software or its performance. 
;;;
;;; Author: Eric Russell <eric-r@nwu.edu>
;;;
;;; Note: Changing font and/or background color may not work for some 
;;;   controls.

;; 09/07/04 fix set-view-font-codes for no color because theme-background - from Terje N.
;; 08/10/04 fix view-draw-contents :before screw cvs
;; 08/09/04 system-font-spec -> sys-font-spec, with-timer in view-click-event-handler 
;; 06/21/04 reinstate view-draw-contents :before - fixed to only call #_movecontrol when needed
;;; 10/23/03 fix for animated controls being contained in a subview - from Terje N.

(in-package :ccl)

(export '(view-draw-no-appearance-contents
          text-justification set-text-justification 
          back-color set-back-color))

;;;----------------------------------------------------------------------
;;; Requirements

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :appearance-globals)
  (require :appearance-utils "ccl:examples;appearance-manager-folder;appearance-utils") 
  (require :appearance-manager "ccl:examples;appearance-manager-folder;appearance-manager"))

;;;----------------------------------------------------------------------
;;; "Syntactic sugar" macro for setting the control handle data

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro set-control-data (item data-tag mactype &rest value-forms)
    (let ((item-var (gensym))
          (handle-var (gensym))
          (data-ptr-var (gensym)))
      `(let* ((,item-var ,item)
              (,handle-var (dialog-item-handle ,item-var)))
         (declare (dynamic-extent ,handle-var)
                  (type macptr ,handle-var))
         (when ,handle-var
           (rlet ((,data-ptr-var ,mactype ,@value-forms))
             (#_SetControlData
              ,handle-var
              0
              ,data-tag
              (record-length ,mactype)
              ,data-ptr-var))
           (invalidate-view ,item-var))))))

;;;----------------------------------------------------------------------
;;; Class

(defclass new-control-dialog-item (control-dialog-item)
  ((action-proc :initarg :action-proc :initform (%null-ptr)
                :allocation :class)
   (text-justification :initform :left :initarg :text-justification 
                       :reader text-justification)
   (back-color :initarg :back-color :initform nil :reader back-color)))

;;;----------------------------------------------------------------------
;;; Re-set the action-proc slot when MCL is launched, because 
;;; kill-lisp-pointers will get rid of it when you save an application
;;; (thanks to David B. Lamkins for pointing this out)

(def-load-pointers new-control-dialog-item ()
  (setf (slot-value (class-prototype (find-class 'new-control-dialog-item))
                    'action-proc)
        (%null-ptr)))

;;;----------------------------------------------------------------------
;;; Also use #_DeactivateControl instead of (#_HiliteControl 255)

(defmethod install-view-in-window ((item new-control-dialog-item) dialog)
  (call-next-method)
  ;;
  ;; Control-dialog-item will allocate its own handle in 
  ;; the :before method, so we've got to get rid of it
  ;;  
  (with-macptrs ((handle (dialog-item-handle item)))
    (setf (dialog-item-handle item) nil)
    (when handle
      (#_DisposeControl handle)))
  
  (when (appearance-available-p)

    (multiple-value-bind (ff ms) (view-font-codes item)
      ;;
      ;; Make the handle
      ;;
      (make-control-handle item (wptr dialog))
      ;;
      ;; Call #_SetControlFontStyle
      ;;
      (set-view-font-codes item ff ms))
    ;;
    ;; synchronize state of control handle with enabled-p slot 
    ;;
    (unless (slot-value item 'dialog-item-enabled-p)
      (#_DeactivateControl (dialog-item-handle item)))))

;;;----------------------------------------------------------------------
;;; Break this out into separate method since so many of our subclasses
;;; need to do something different with it.

(defmethod make-control-handle ((item new-control-dialog-item) wptr)
  (with-pstrs ((sp (dialog-item-text item)))
    (with-item-rect (rect item)
      (setf (dialog-item-handle item)
            (#_NewControl 
             wptr
             rect 
             sp
             nil
             0
             0 
             1
             (control-dialog-item-procid item)             
             0)))))

;;;----------------------------------------------------------------------
;;; Use new #_IsControlVisible trap, and draw a gray rect when the
;;; Appearance Manager isn't available

(defmethod view-draw-contents ((item new-control-dialog-item))
  (if (appearance-available-p)
    (when (installed-item-p item)
      (with-macptrs ((handle (dialog-item-handle item)))
        (when handle
          (with-back-color (back-color item)
            (if (#_IsControlVisible handle)
              (#_Draw1Control handle)
              (#_ShowControl handle))))))
    (view-draw-no-appearance-contents item)))

(defmethod view-draw-no-appearance-contents ((item new-control-dialog-item))
  (with-focused-view (view-container item)
    (with-item-rect (rect item)
      (with-fore-color *light-gray-color*
        (#_PaintRect rect)))))

;;;----------------------------------------------------------------------
;;; Use the new #_ActivateControl and #_DeactivateControl traps

(defmethod dialog-item-disable ((item new-control-dialog-item))
  (when (and (installed-item-p item) (dialog-item-enabled-p item))
    (with-focused-dialog-item (item)
      (#_DeactivateControl (dialog-item-handle item))))
  (setf (dialog-item-enabled-p item) nil))

(defmethod dialog-item-enable ((item new-control-dialog-item))
  (when (and (installed-item-p item) (not (dialog-item-enabled-p item)))
    (with-focused-dialog-item (item)
      (#_ActivateControl (dialog-item-handle item))))
  (setf (dialog-item-enabled-p item) t))

(defmethod activation-hilite ((view new-control-dialog-item) hilite-p)
  (when (installed-item-p view)
    (with-focused-dialog-item (view)
      (if hilite-p
        (#_ActivateControl (dialog-item-handle view))
        (#_DeactivateControl (dialog-item-handle view))))))

;;;----------------------------------------------------------------------
;;; Use the new #_HandleControlClick trap

(defmethod view-click-event-handler ((item new-control-dialog-item) where
                                     &aux part)  
  (with-focused-dialog-item (item)
    (let ((handle (dialog-item-handle item))
          (action (slot-value item 'action-proc))
          (modifiers (get-modifiers)))
      (declare ;(dynamic-extent handle)
       (type macptr handle))
      (when handle
        (with-timer  ;; <<
          (let ((window (view-window item))
                (container (view-container item)))
            (when (neq container window)
              (setq where (convert-coordinates where container window))))
          (setq part (#_HandleControlClick handle where modifiers action))))
      (if (neq part 0) (dialog-item-action item)))))

;; ----------------
;; in case installed in a subview

; SVS following method causes uses of databrowser in multithreading situations to flood system with window-update events
;;#+IGNORE
(defmethod view-draw-contents :before ((item new-control-dialog-item))
  (let ((handle (dialog-item-handle item)))
    (when handle
      (let ((topLeft (convert-coordinates (view-position item)(view-container item)(view-window item))) ;; pardonnez moi but (abs (view-origin)) was incorrect!
            (control-rect-position (get-control-bounds item)))
        (unless (eql control-rect-position topleft)         
          (#_MoveControl handle (point-h topLeft) (point-v topLeft)))))))

;; omit the #_movecontrol that happens for regular control-dialog-item ??
;; wait for view-draw-contents. avoids brief appearance in wrong place
(defmethod set-view-position ((item new-control-dialog-item) h &optional v
                              &aux (new-pos (make-point h v)))
  (unless (eql new-pos (view-position item))
    (without-interrupts     
     (invalidate-view item t)
     (setf (slot-value item 'view-position) new-pos)
     (when (installed-item-p item)
       (with-focused-dialog-item (item)           
         (invalidate-view item)))))
  new-pos)

;; do it now but still need the before method in case container moves ??
#+ignore 
(defmethod set-view-position ((item new-control-dialog-item) h &optional v
                              &aux (new-pos (make-point h v)))
  (unless (eql new-pos (view-position item))
    (without-interrupts     
     (invalidate-view item t)
     (setf (slot-value item 'view-position) new-pos)
     (when (installed-item-p item)
       (let ((handle (dialog-item-handle item))
             (container (view-container item)))
         (with-focused-view container
           (when handle 
             (let ((foo-pos (if (neq container (view-window item))
                              (convert-coordinates new-pos container (view-window item))
                              new-pos)))
               (#_movecontrol handle (point-h foo-pos)(point-v foo-pos))))                 
           (invalidate-view item))))))
  new-pos)



(defmethod call-with-focused-dialog-item ((item new-control-dialog-item) fn &optional container)
   "Account for the fact that the control rect of progress-bar is in window
      coordinates (rightly so)."
   (if (appearance-available-p)
     (call-next-method item fn (view-window (or container item)))
     (call-next-method)))




;;;----------------------------------------------------------------------
;;; Use #_GetBestControlRect when we can, otherwise call-next-method

(defmethod view-default-size ((item new-control-dialog-item))
  (if (and (installed-item-p item)
           (logbitp #$kControlSupportsCalcBestRect (get-feature-flags item)))
    (rlet ((r :rect :topleft 0 :botright 0)
           (offset :signed-integer))
      (#_GetBestControlRect (dialog-item-handle item) r offset)
      (subtract-points (rref r :rect.botright)
                       (rref r :rect.topleft)))
    (call-next-method)))

;;;----------------------------------------------------------------------
;;; System font is no longer hardwired to be Chicago, so we fetch it 
;;; at runtime.

(defmethod view-default-font ((item new-control-dialog-item))
  (sys-font-spec))

;;;----------------------------------------------------------------------
;;; Use new #_SetControlFontStyle trap

(defmethod set-view-font-codes ((item new-control-dialog-item)
                                ff ms
                                &optional
                                ff-mask
                                ms-mask)
  (when (installed-item-p item)
    (let ((bgcolor (or (back-color item)
                       (unless (theme-background-p item)
                         (get-back-color (view-window item))))))
      (rlet ((fore-color :RGBColor)
             (back-color :RGBColor)
             (style-rec
              :ControlFontStyleRec
              :flags     (logior (if (and ff-mask (zerop (logand ff-mask +font-only-ff-mask+)))
                                   0
                                   #$kControlUseFontMask)
                                 (if (and ff-mask (zerop (logand ff-mask +face-only-ff-mask+)))
                                   0
                                   #$kControlUseFaceMask)
                                 (if (and ff-mask (zerop (logand ff-mask +color-only-ff-mask+)))
                                   0
                                   #$kControlUseForeColorMask)
                                 (if (and ms-mask (zerop (logand ms-mask +mode-only-ms-mask+)))
                                   0
                                   #$kControlUseModeMask)
                                 (if (and ms-mask (zerop (logand ms-mask +size-only-ms-mask+)))
                                   0
                                   #$kControlUseSizeMask)
                                 (if bgcolor #$kControlUseBackColorMask 0)
                                 #$kControlUseJustMask)
              :font       (font-codes-font-number ff ms)
              :size       (font-codes-size ff ms)
              :style      (font-codes-style-number ff ms)
              :mode       (font-codes-mode ff ms)
              :just       (alignment-arg (slot-value item  'text-justification))
              :foreColor  (color-to-rgb (font-codes-color ff ms)  fore-color)
              :backColor  (color-to-rgb (or bgcolor *red-color*)  back-color)))  ;; *red-color* is dummy when not setting backcolor
        (#_SetControlFontStyle (dialog-item-handle item) style-rec))))
  (call-next-method))

;;;----------------------------------------------------------------------
;;; New utility methods & functions

(defmethod set-text-justification ((item new-control-dialog-item) just)
  (unless (eql just (text-justification item))
    (setf (slot-value item 'text-justification) just)
    (multiple-value-bind (ff ms) (view-font-codes item)
      (set-view-font-codes item ff ms))))

(defmethod (setf text-justification) (just (item new-control-dialog-item))
  (set-text-justification item just))

(defmethod set-back-color ((item new-control-dialog-item) color 
                           &optional (redraw-p t))
  (unless (eql color (back-color item))
    (setf (slot-value item 'back-color) color)
    (multiple-value-bind (ff ms) (view-font-codes item)
      (set-view-font-codes item ff ms))
    (when redraw-p
      (invalidate-view item))))

(defmethod (setf back-color) (color (item new-control-dialog-item))
  (set-back-color item color))

(defmethod maybe-reinstall-item ((item new-control-dialog-item))
  (let ((container (view-container item))
        (level (view-level item)))
    (when (and container (wptr container))
      (without-interrupts
       ; don't re-draw until we've re-added
       (remove-subviews container item)
       (add-subviews container item)
       (set-view-level item level)))))

(defmethod get-feature-flags ((item new-control-dialog-item))
  (if (installed-item-p item)
    (rlet ((features :long))
      (let ((ecode (#_GetControlFeatures (dialog-item-handle item) features)))
        (if (zerop ecode)
          (%get-unsigned-word features)
          0)))
    0))

(defun get-modifiers ()
  (if (boundp '*current-event*)
    (rref *current-event* eventrecord.modifiers)
    0))

(defun alignment-arg (keyword)
  (ecase keyword
    (:center  #$teCenter)
    (:default #$teFlushDefault)
    (:left    #$teFlushLeft)
    (:right   #$teFlushRight)))

;;;----------------------------------------------------------------------

(provide :new-control-dialog-item)