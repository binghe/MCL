
;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  3 10/5/97  akh  see below
;;  2 8/25/97  akh  optimiizations for long menus
;;  11 1/22/97 akh  fix view-draw-contents for non-color window.
;;  8 5/23/96  akh  fixes for non-roman script in view-font, or menu-item-title, dont lsh ff
;;  7 5/20/96  akh  nuke random bold font, lose draw-popup-title-string-in-rect, indentation
;;  2 10/17/95 akh  merge patches
;;  3 4/10/95  akh  probably no change
;;  2 4/6/95   akh  add optional crescent for pull-down-menu
;;  7 3/14/95  akh  no change
;;  6 2/9/95   akh  add-menu-items sets style more often
;;  5 2/7/95   akh  tweak the guy who sets menu-item-style to match parent
;;  4 2/6/95   akh  put back old version of view-draw-contents - prefer crop title with ... vs clip it. Also clipped pull-downs too much.
;;                  Put some bizarre bold stuff back to plain.
;;  2 2/3/95   slh  merge w/new-pop-up-menus.lisp; copyright thang
;;  (do not edit before this line!!)

;; dont say #\altcheckmark
;; revert make-new-pop-up-control - new one fouls up font
;; --------- 5.2b6
;; make-new-pop-up-control - more modern
;; draw-theme-text-box uses with-theme-state-preserved
;; export draw-theme-text-box
;; ------- 5.2b5
;; clean up vdc pop-up-menu and pull-down-menu
;; ------ 5.2b4
;; draw-theme-text-box gets active-p arg, default is T
;; vdc pop-up-menu uses draw-theme-text-box LESS often?? - and now not at all
;; ------ 5.2b1
;; use draw-string-crop-in-rect
;; menu-install handles non 7bit-ascii title
;; lose the menu-install after method that fusses with script
;; draw-theme-text-box uses with-cfstrs-hairy, vdc pop-up-menu uses draw-theme-text-box more often
;; ------ 5.1 final
;; view-click-event-handler does allow-view-draw-contents and with-focused-view nil 
;; view-activate/deactivate do with-focused-dialog-item. set-pop-up-menu-default-item focuses on window
;; draw-theme-text-box doesn't cons a macptr when truncwhere
;; *use-pop-up-control* T on OS9 too
;; set-view-size/position changes weren't needed - real problem was elsewhere
;; fiddle with view-corners of typein-menu
;; set-view-size and position fix to erase old corners
;; move theme-background-view to views.lisp
;; view-activate/deactivate of pop-up-menu do activate/deactivatecontrol
;; ------- 5.1b2
;; picky picky re view-corners
;; add view-corners ((view typein-menu))
;; defclass theme-background-view
;; fooling around with the test code
;; ------ 5.1b1
;;; 01/04/04  redo change to point-in-click-region-p - add menu-select-v-offset, called by menu-select
;;;  add-menu-height if view height > default height
;;; akh undo change to point-in-click-region-p
;;; 12/22/03 menu-install knows about menu-font, clean up menu-select a bit
;;; 12/21/03 call draw-theme-text-box with truncate t
;;; 12/05/03 add/remove-menu-items get default right when control-handle
;;; 12/03/03 max-menu-width tweak, define methods menu-item-icon-handle and num for menu to return nil
;;; 12/01/03 view-default-size of typein-menu - fudge for osx-p, change point-in-click-region-p of pop-up-menu
;;; 11/15/03 remove-view-from-window focuses - from Terje N.
;;; 11/14/03 better add/remove-menu-items - from Terje N.
;;; 11/09/03 add a comment in test code
;;; 10/28/03 theme things don't require osx-p
;;; 11/04/03 add-menu-items focuses - remove-menu-items also
;;; akh lose #_hilitecontrol
;;; 10/26/03 akh view-default-size - height big enuf for small icon if any icon, fudge width too
;;; 10/17/03 akh draw-theme-text-box - make truncwhere arg work (from Terje N.)
;;; 05/22/03 akh fix max-menu-width in case something is not a menu-item (from Toomas Altosaar)
;;; 05/06/03 akh part-color of menu-body default to nil if control-handle
;;; ---------- 5.0 final
;;; move warning re use-pop-up-control and item-display to install-view-in-window, don't whine if item-display is "".
;;; *use-pop-up-control* true if osx-p
;;; fix view-corners when control-handle for possible title
;;; fix remove-menu-items in case removing the default item. fix add-menu-items to always make-new... if control-handle
;;; fix for *use-pop-up-control* true and pop-up contained in subview of window
;;; ------------- 4.4b5
;;; junk for theme-background in pull-down-menu and menu-title
;;; --------------- 4.4b4
;;; more tweaks for set-view-size and position, add view-corners
;;; ------------- 4.4b3
;;; 03/02/01 akh kludge re control-handle turds when change position, also tweak size-rectangles for typein-menu-menu if control-handle
;;; 02/15/02 no mo consing in set-pop-up-item-check-mark
;;; 02/12/02 akh adjust max-menu-width if icon shows up in title
;;; akh menu-display-v-offset for pull-down differs for osx-p
;;; 01/06/02 akh view-corners of typein-menu-menu so title if any will redraw, see menu-select when control-handle
;;; fix set-view-size and position to update control-handle
;;; -------- 4.4b2
;;; 11/06/01 move a method re pull-down-menu to after class exists
;;; to enable drawing using Draw1Control (to get "aqua" or less ugly "graphite") there is one new slot in pop-up-menu which is control-handle.
;;; There is a new method use-pop-up-control - the default method returns nil.
;;; If you are willing to live with the shortcomings of use-pop-up-control in return for "aqua" then you can define
;;; a subclass of  pop-up-menu and add a method for use-pop-up-control that may or may not return t
;;; or you can set ccl::*use-pop-up-control* to t which will cause the default method to return t.
;;; The shortcomings are 1) add- and remove-menu-items don't dtrt (actually may work now),
;;;     2) vertical size is always 20 (or maybe 17 sometimes?) other vertical sizes do not work.
;;;     3) empty menus won't show the-empty-menu-string, which is usually "<No items>"
;;;     4) won't work if pop-up-menu-item-display is a non-empty string (vs :selection or "")
;;;     6) dont know what will happen if hierarchical pop-up (use of same is discouraged anyway)
;;;     7) changing the position does not work correctly (i.e. in IFT) - fixed now
;;; Does show the icon, if any, of selected item which is cool.
;;; Thanks to Alex Repenning for info about NewControl re pop ups and for encouraging us to do this.



;;; 12/29/01 akh fudge in view-default-size if osx-p and (use-pop-up-control)
;;; 12/17/01 akh fix set-view-position and set-view-size when control-handle exists though set-view-size height doesnt mean much it that case
;;; ------- 4.4b1, 4.4b2
;;; 05/13/01 akh menu-select diff for carbon re font so works with osx
;;; 12/30/99 akh more informative print-object method
;;; 12/29/99 akh pull-down menus draw with fore and back color switched when selected - vs #_invertrect,
;;;          back-color defaults to window vs white
;;; 12/29/99 akh menu-select of typein-menu-menu changed for possible platinum-pop-up
;;; 12/29/99 akh get-menu-body-text is now a subfn used by view-draw-contents and view-default-size
;;; 12/28/99 akh set-part-color does invalidate-view
;;; akh changed so :menu-title color really only applies to text - not frame and little triangle
;;;      added :menu-frame part-color
;;; use set-menu-item-script
;;; ---------- 4.3f1c1
;;; 05/24/99 akh view-default-font is system font, use #\altcheckmark for non chicago? or is it non system this week
;;; ---------- 4.3b2
;;; 09/29/98 akh add a view-default-font method vs :default-initarg
;;; 09/28/98 akh set-pop-up-item-check-mark - don't #. font-codes for "Chicago"
;;; 08/14/98 akh view-draw-contents uses :title-background for the background of title - default is nil
;;;            formerly used :menu-body for both title and menu rect  which defaults to white
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  pop-up-menu.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995-2002 Digitool, Inc.
;;
;;  This file implements pop-up menus, according to the Apple standard.
;;  it also shows how multiple inheritance can be handy! oh really
;;

;; Classes defined in this file:
;;
;;   pop-up-menu        - pop-up-menus that deal better with non-chicago fonts
;;   action-pop-up-menu - pop-up-menu whose default item is set to do nothing
;;   pull-down-menu     - like a menubar menu (no outline, no triangle)
;;   typein-menu        - you can pick a value or type in your own
;;      typein-menu-menu    - the little menu inside a typein-menu
;;      typein-menu-item    - menu-items in a typein-menu must be of this class
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Mod History
;;

;; 10/01/97 akh  menu-enable/disable - don't inval view unless necessary
;; 07/23/97 akh  add-menu-items - only call set-menu-item-check mark if was non nil
;; 12/10/96 akh fix view-draw-contents for non-color window.
;;  9/11/96 bill  (method view-click-event-handler (pop-up-menu t)) does nothing
;;                if the pop-up menu is disabled.
;; -------------- 4.0b1
;; -------------- 3.9
;; akh nuke random bold font, lose draw-popup-title-string-in-rect, indentation
;; 03/26/96 gb    lowmem accessors.
;; 02/29/96 bill  export action-pop-up-menu as suggested by Andrew Begel
;; 12/05/95 slh   update trap names
;; 11/30/95 slh   fix _PopUpMenuSelect call for PPC
;;  3/16/95 slh   added action-pop-up-menu
;;  2/02/95 slh   merge pop-up-menu.lisp with new-pop-up-menu.lisp
;; -------------  3.0d17
;; 12/29/94 akh   merge with d13
;;                menu-select inverts pull-down-menu before action rather than view-click-event-handler doing it after
;;                (action can cause redraw which makes parity wrong - and it looks better)
;;                highlight-title is an initarg
;;                crop titles that don't fit, do menu-item-action with event-processing enabled 
;;                set-pop-up-menu-default-item does invalidate-view stead of most callers, set-view-size and position
;;                don't if same making resizing dialogs less bouncy. 
;; 06/07/94 bill  (method remove-menu-items :around (pop-up-menu))
;; -------------  3.0d13
;; 10/16/93 alice menu-disable and enable for typein-menu do menu and editable-text
;; 10/15/93 alice view-draw-contents more tasteful when disabled and color or gray scale.
;;		      and menu-select of typein-menu-menu puts back the top edge correctly when disabled.
;; 09/19/93 alice Add-menu-items leaves the default-item number unchanged and fixes the
;;	            check marks or sets it to 1 if any items and default-item previously 0.
;; 04/10/93 alice view-click-event-handler for pop-up-menu make sure he's still there
;;		      after menu-select
;; 02/18/93 alice position of title is f(leading), typein-menu-menu has a menu-select
;;		      method that erases a pixel or two, v-offset is now 2 for both flavors of typein
;; 02/17/93 straz tiny triangles for small menus (e.g. Geneva 9)
;;                editable-text (subview of typein-menu) inherits container's view-font
;;                dialog-item-enable/disable for typein-menu
;; 02/15/93 alice title (the text to left) does not hilite and is not mouse sensitive
;;                default size of typein accounts for title
;;                auto-update-default back to nil for pull-down-menu
;; 02/15/93 straz view-draw-contents on pop-up-menu, dtrt if no selection
;;                auto-update-default t for pull-down-menu
;;                add documentation, bold fcn names, clean up file text
;; 02/03/93 alice pop-up is no longer a dialog-item - use menu-enable, menu-title etc.
;; 01/18/93 alice add pull-down-menu and typein-menu
;; 11/11/92 bill  Straz'es patch to add specify background color with :menu-body.
;;11/05/92 alice view-default-size dtrt if no items and :sequence
;;11/04/92 alice set-view-position does invalidate view - for ift, export a few
;;----------- 2.0
;; patch 0 Make hierarchical pop-up menus work correctly.
;;     Fix redrawing on set-view-size of a pop-up-menu
;; --------------- 2.0f3
;; 03/19/92 alice in menu-select (menu-items menu) => (menu-items selected-menu)
;; 10/18/91 bill  optimize view-draw-contents a little.
;;                Adjust position of pop up menu
;; 10/15/91 bill  window-font -> view-font
;;                Add the little System 7 triangle.
;;--------------  2.0b3
;; 06/21/91 bill  wkf's mod: Add foreground color for titles of pop up menus.
;;--------------  2.0b2
 
;;;;;;;;;;;;;;;;;;
;;
;;  packages, proclamations, and requires
;;

(in-package :ccl)

#+ignore
(eval-when (eval compile)
  (require :toolequ))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(pop-up-menu selected-item pop-up-menu-item-display
            pop-up-menu-default-item set-pop-up-menu-default-item
            pop-up-menu-auto-update-default set-pop-up-item-check-mark
            pull-down-menu
            typein-menu action-pop-up-menu
            use-pop-up-control
            *use-pop-up-control*) :ccl))


; Hah - no more dialog item!

(defclass pop-up-menu (menu simple-view)
  ((width-correction :allocation :class :initform 0
                     :accessor pop-up-menu-width-correction)
   (menu-rect :initform nil :accessor pop-up-menu-rect)
   (title-rect :initform nil :accessor pop-up-menu-title-rect)
   (default-item :initarg :default-item :initform 1
                 :accessor pop-up-menu-default-item)
   (auto-update-default :initarg :auto-update-default :initform t
                        :accessor pop-up-menu-auto-update-default)
   (item-display :initarg :item-display :initform :selection
                 :accessor pop-up-menu-item-display)   
   (control-handle :initform nil :accessor control-handle)  ;; new slot
   (cached-title :initform nil :accessor pop-up-menu-cached-title))
  (:default-initargs
    :view-position nil 
    :view-size nil
    :menu-title ""
    ;:view-font '("Chicago" 12 :plain)
    ))

#|
(defmethod use-pop-up-control ((menu pop-up-menu))
  ;; check font too?, colors?
  (and (not (typep menu 'pull-down-menu))
       (eql 20 (point-v (view-size menu)))
       (appearance-available-p)
       (let ((item-display (pop-up-menu-item-display menu)))
         (or (eq item-display :selection)
             (equalp item-display "")))))
|#

;; dont break MCL
;; users may define a subclass of pop-up-menu with a use-pop-up-control method
;; or set *use-pop-up-control* t
(defparameter *use-pop-up-control* t)
(defmethod use-pop-up-control ((menu pop-up-menu))  
  *use-pop-up-control*)

#+ignore
(defun hitto () ;; thats Finnish for Oh damn
  (if (osx-p) (setq *use-pop-up-control* t)))
 
#+ignore 
(pushnew 'hitto *lisp-startup-functions*)


#| ;; from platinum pop-up menus - fixed now therein
(defun maybe-draw-new-pop-up (menu)
  (when (and  (appearance-available-p) (not (typep menu 'pull-down-menu)) (not (control-handle menu)))
    ;; dont mess with pull-down menus - If I want a gray one I'll say so.
    ;; They are intended to look like menus in the menubar which do not have any
    ;; shading or other embellishments.
    (new-draw-pop-up-menu menu)
    t))
|#
  

;(defmethod install-view-in-window :after ((menu pop-up-menu) window))
(defmethod install-view-in-window :after ((menu pop-up-menu) window)
  (when (use-pop-up-control menu)
    (let ((item-disp (pop-up-menu-item-display menu)))
      (when (not (or (eq  item-disp :selection)
                     (equal item-disp "")))
        (warn "*use-pop-up-control* and item display ~s are incompatible." item-disp)))
    (make-new-pop-up-control menu window)))
    
#|
(defun make-new-pop-up-control (menu &optional (window (view-window menu)))
  (with-pstrs ((sp ""))  ;; we draw the title if any for highlighting
    (let ((handle (#_NewControl 
                   (wptr window) 
                   (pop-up-menu-rect menu)
                   sp
                   t
                   #$popupTitleLeftJust 
                   (slot-value menu 'menu-id) 
                   0                                ;; max <- pixel width of menu title
                   (if (appearance-available-p)     ;; Appearance-compliant pop-up menu
                     (logior #$kControlPopupButtonProc #$kControlPopupFixedWidthVariant #$kControlPopupUseWFontVariant)
                     #$popupMenuProc)             
                   0)))
      (setf (control-handle menu) handle)
      (let ((default-item (pop-up-menu-default-item menu)))
        (when default-item
          (#_setcontrolvalue handle default-item)))
      ;(#_setcontrolpopupmenuhandle handle (menu-handle menu)) ;; does nada
      ;(#_setcontrolpopupmenuid handle (menu-id menu))
      )
    (unless (slot-value menu 'enabledp)
      ;sync up what we believe with what the mac believes.
      (#_HiliteControl (control-handle menu) 255))))
|#


;; kludge to fix first time set-view-position leaving turds

(defun make-new-pop-up-control (menu &optional (window (view-window menu)))
  (with-pstrs ((sp ""))  ;; we draw the title if any for highlighting
    (rlet ((fake-rect :rect))
      (setf (pref fake-rect :rect.topleft) #@(-3000 -3000))
      (setf (pref fake-rect :rect.botright) (add-points #@(-3000 -3000) (view-size menu)))
      (let ((handle (#_NewControl 
                     (wptr window) 
                     fake-rect ;(pop-up-menu-rect menu)
                     sp
                     nil                             ;; visible
                     #$popupTitleLeftJust 
                     (slot-value menu 'menu-id) 
                     0                                ;; max <- pixel width of menu title
                     (logior #$kControlPopupButtonProc #$kControlPopupFixedWidthVariant #$kControlPopupUseWFontVariant)                                   
                     0)))
        (setf (control-handle menu) handle)
        (let ((default-item (pop-up-menu-default-item menu)))
          (when default-item
            (#_setcontrolvalue handle default-item)))  ;; shouldn't this do the gag song and dance too.
        (set-view-position menu (view-position menu))
        ;(#_setcontrolpopupmenuhandle handle (menu-handle menu)) ;; does nada
        ;(#_setcontrolpopupmenuid handle (menu-id menu))
        )
      (maybe-add-menu-height menu)
      (unless (slot-value menu 'enabledp)
        ;sync up what we believe with what the mac believes.
        (#_deactivatecontrol (control-handle menu))))))

#|
;; this fouls up the font of the drawn control, the menu-items are OK
(defun make-new-pop-up-control (menu &optional (window (view-window menu)))
  (progn ;with-pstrs ((sp ""))  ;; we draw the title if any for highlighting
    (rlet ((fake-rect :rect))
      (setf (pref fake-rect :rect.topleft) #@(-3000 -3000))
      (setf (pref fake-rect :rect.botright) (add-points #@(-3000 -3000) (view-size menu)))
      (rlet ((out :ptr))
        (#_CreatePopupButtonControl
         (wptr window) 
         fake-rect ;(pop-up-menu-rect menu)
         (%null-ptr)      ;; title
         (slot-value menu 'menu-id)
         nil      ;; variable width
         0      ;; title width 
         0      ;; title justification
         0      ;; title style
         out)
        (let ((handle (%get-ptr out)))
          (setf (control-handle menu) handle)
          (let ((default-item (pop-up-menu-default-item menu)))
            (when default-item
              (#_setcontrolvalue handle default-item)))  ;; shouldn't this do the gag song and dance too.
          (set-view-position menu (view-position menu))            
          (maybe-add-menu-height menu)
          (unless (slot-value menu 'enabledp)
            ;sync up what we believe with what the mac believes.
            (#_deactivatecontrol handle)))))))
|#


(defun maybe-add-menu-height (menu)
  (let ((vh (point-v (view-size menu)))
        (dh (point-v (view-default-size menu))))
    (when (> vh dh)
      (add-menu-height menu (- vh dh)))))
  
;; does make it bigger for all the good that does
;; seems to add to default height rather than current
(defun add-menu-height (pop-up-menu height)
  (let ((handle (control-handle pop-up-menu)))
    (when handle
      (rlet ((hgt :word height))
        (errchk (#_SetControlData handle 0  #$kControlPopupButtonExtraHeightTag 2 hgt))))))
  

(defmethod view-default-font ((menu pop-up-menu))
  ;'("Chicago" 12 :plain)
  (sys-font-spec))

(defmethod the-empty-menu-string ((menu pop-up-menu))
  "<No items>")

(defmethod print-object ((thing pop-up-menu) stream)
  (print-unreadable-object (thing stream)
    (format stream "~S ~S"
            (class-name (class-of thing))
            (let ((title (menu-title  thing)))
              (if (and title (not (equal title "")))
                title
                (get-menu-body-text thing))))))

;------

(defmethod set-pop-up-menu-default-item ((menu pop-up-menu) num &optional force)
  (let* ((old (pop-up-menu-default-item menu))
         (items (menu-items menu)))    
    (prog1 
      num  
      (when (or force (neq old num))
        (when (and (neq old 0) items)
          (set-pop-up-item-check-mark (nth (1- old) items) nil))
        (when (and num (neq num 0) items)
          (set-pop-up-item-check-mark (nth (1- num) items) t))
        (setf (pop-up-menu-default-item menu) num)
        (when (eq (pop-up-menu-item-display menu) :selection)
          (let ((window (view-window menu))
                (handle (control-handle menu)))
            (with-focused-dialog-item (menu window)
              (when handle
                (cond 
                 ((neq (view-container menu) window)
                  (let ((old-rect (pop-up-menu-rect menu)))
                    (rlet ((gag-rect :rect))
                      (setf (rref gag-rect :rect.topleft) (convert-coordinates (rref old-rect :rect.topleft) (view-container menu) window))
                      (setf (rref gag-rect :rect.botright) (convert-coordinates (rref old-rect :rect.botright) (view-container menu) window))
                      (without-interrupts
                       (#_setcontrolbounds handle gag-rect)
                       (#_setcontrolvalue handle num)
                       (#_setcontrolbounds handle old-rect)))))                 
                 (t (#_setcontrolvalue handle num))))))
          (invalidate-view menu))))))


(defmethod install-view-in-window ((menu pop-up-menu) dialog &aux ok)  
  (declare (ignore dialog))  
  (menu-install menu)
  (without-interrupts ; this is what dialog-item buys us
   (unwind-protect
     (let ((container (view-container menu)))
       (set-default-size-and-position menu container)
       (setq ok t))
     (unless ok
       (set-view-container menu nil))))
  (size-rectangles menu)
  (invalidate-view menu))




;;;;;;;;;;;;;;;;;;;;
;;
;;  definitions for pop-up menus
;;


#|
(defmethod initialize-instance ((menu pop-up-menu) &rest initargs &key dialog-item-text)
  (declare (dynamic-extent initargs))
  (if dialog-item-text
    (apply #'call-next-method menu :menu-title dialog-item-text initargs)
    (call-next-method)))
|#

(defmethod initialize-instance :after ((menu pop-up-menu) &rest initargs &key highlight-title)
  (declare (ignore initargs))
  (when highlight-title (view-put menu :highlight-title t))
  (let ((default (pop-up-menu-default-item menu)))    
    (when (and default (neq default 0))
      (setq default (nth (1- default) (menu-items menu)))
      (when default (set-pop-up-item-check-mark default t)))))


;------------
; Geometry

#|
(defmethod set-view-size ((menu pop-up-menu) h &optional v)  
  (declare (ignore h v))
  (let ((old-size (view-size menu)))
    (if (osx-p)(invalidate-view menu t))
    (call-next-method)
    (when (not (eql old-size (view-size menu)))
      (size-rectangles menu)
      #+carbon-compat
      (when (and (control-handle menu))      
        (#_SetControlbounds (control-handle menu) (pop-up-menu-rect menu))
        (maybe-add-menu-height menu))
      (setf (pop-up-menu-cached-title menu) nil)
      (invalidate-view menu t))))
|#

(defmethod set-view-size ((menu pop-up-menu) h &optional v)
  (declare (ignore h v))
  (let (; (new-size (make-point h v))
        ;(old-size (view-size menu))
        )
    (when  t ;(not (eql new-size old-size))
      (with-focused-dialog-item (menu)        
        (invalidate-view menu t)       
        (call-next-method)
        (size-rectangles menu)
        (when (control-handle menu)
          (#_setcontrolbounds (control-handle menu)(pop-up-menu-rect menu))
          (maybe-add-menu-height menu))
        (setf (pop-up-menu-cached-title menu) nil)
        (invalidate-view menu t)
        ))))
  
#|
(defmethod set-view-position ((menu pop-up-menu) h &optional v)
  ;(declare (ignore h v))
  (when (not (eql (view-position menu) (make-point h v)))    
    (call-next-method)
    (size-rectangles menu)
    (if (control-handle menu)        
      (#_Setcontrolbounds (control-handle menu) (pop-up-menu-rect menu)))
    (invalidate-view menu t)))
|#


(defmethod set-view-position ((menu pop-up-menu) h &optional v)
  (declare (ignore h v))
  (when  t ;(not (eql new-size old-size))
    (with-focused-dialog-item (menu)        
      (invalidate-view menu t)        
      (call-next-method)
      (size-rectangles menu)
      (when (control-handle menu)
        (#_setcontrolbounds (control-handle menu)(pop-up-menu-rect menu))
        (maybe-add-menu-height menu))
      (invalidate-view menu t)
      )))
          

(defmethod size-rectangles ((menu pop-up-menu))
  "does a lot of tweaking to get the thing to draw right"
  (let* ((my-pos (view-position menu))
         (my-size (view-size menu)))
    (when (and my-pos my-size)
      (setq my-size (add-points my-size (if (pull-down-menu-p menu) #@(0 -1) (if (control-handle menu) #@(0 0)#@(-1 -1))))) ; ??
      (let* ((text (menu-title menu))
             (title-offset (make-point (if (eql 0 (length text))
                                         0
                                         (+ 8 (string-width
                                               text
                                               (or (menu-font menu)
                                                   (view-font (view-window menu))))))
                                       0))
             (menu-rect (or (pop-up-menu-rect menu)
                            (setf (pop-up-menu-rect menu) (make-record :rect))))
             (title-rect (or (pop-up-menu-title-rect menu)
                             (setf (pop-up-menu-title-rect menu)
                                   (make-record :rect)))))
        (rset menu-rect :rect.topleft (add-points my-pos title-offset))
        (rset menu-rect :rect.bottomright (add-points my-pos my-size))
        (rset title-rect :rect.topleft (add-points my-pos #@(0 1)))
        (rset title-rect :rect.bottomright (make-point (+ (point-h my-pos)
                                                          title-offset)
                                                       (+ (point-v my-pos)
                                                          (point-v my-size)
                                                          -2)))))))

(defmethod view-corners ((item pop-up-menu))
  (if (and #|(osx-p)|# (control-handle item)) ;(ccl::editing-dialogs-p (view-window item)))
    (let ((rgn ccl::*temp-rgn-3*))
      (#_getcontrolregion (ccl::control-handle item) #$kControlStructureMetaPart rgn)
      (multiple-value-bind (tl br) (ccl::get-region-bounds-tlbr rgn)        
        (let ((btl (call-next-method)))  ;; maybe it has a title
          (setq tl (make-point (min (point-h tl)(point-h btl)) (point-v tl)))
          (values tl br))))
    ;(Multiple-value-bind (tl br) (call-next-method)
    ;  (values (subtract-points tl #@(2 2)) (add-points br #@(10 4))))
    (call-next-method)))


(defmethod view-default-size ((menu pop-up-menu))
  (multiple-value-bind (ff ms)(font-codes (menu-font menu))
    (let* ((item-display (slot-value menu 'item-display))
           (max-menu-width (max 10 (font-codes-string-width (get-menu-body-text menu) ff ms)))
           (title (menu-title menu))
           (title-width (if (eq 0 (length title)) 0 (font-codes-string-width title ff ms)))
           (fudge 0))
      ;(when ff (setq ff (logand ff #xffff0000))) ; nuke boldness if any
      (when (and #|(osx-p)|# (use-pop-up-control menu)) ;; the arrows thing is bigger in this case
        (setq fudge 2))
      (setq max-menu-width
            (+ (if (eq 0 title-width) 9 18)
               fudge
               ; we used to dolist always
               (if (eq item-display :selection)
                 (let ((item-max (max-menu-width menu)))
                   (if (> item-max max-menu-width)
                     item-max
                     max-menu-width))
                 max-menu-width)))
      (multiple-value-bind (a d w l) (font-codes-info ff ms)
        (let ((height (+ a d l 4)))
          (make-point (+  title-width  max-menu-width (if (pull-down-menu-p menu) 5 (+ 12 w))) ; was 15
                      (if (use-pop-up-control menu)(max 20 height) height)))))))



(defmethod view-font-codes-info ((menu pop-up-menu))
  (if (slot-value menu 'menu-font)
    (multiple-value-bind (ff ms)(font-codes (slot-value menu 'menu-font))  ;; ugh
      (font-codes-info ff ms))
    (multiple-value-call #'font-codes-info (view-font-codes menu))))

(defmethod point-in-click-region-p ((menu pop-up-menu) where)
  ; prevent changing selection when mouse doesn't move.
  (when (view-contains-point-p menu where)
    (let* ((vh (point-v (view-size menu)))
           (lh vh) ;(view-font-line-height menu))  ;; << odd behavior with use-pop-up-control because the menu may be bigger than it needs to be
           (rect (pop-up-menu-rect menu)))
      (declare (fixnum lh vh))
      (and (< (rref rect :rect.left) (point-h where)
              (- (rref rect :rect.right) (menu-display-h-offset menu)))
           (or (< vh (+ 2 lh))
               (let* ((v-where (point-v where))
                      (v-pos (point-v (view-position menu)))
                      (offset (menu-display-v-offset menu)))
                 (declare (fixnum v-where v-pos offset))
                 (and (> v-where (+ offset v-pos))
                      (< v-where
                         (+ v-pos lh offset)))))))))

(defmethod menu-display-v-offset ((menu pop-up-menu))
  1)

(defmethod menu-display-h-offset ((menu pop-up-menu))
  1)

;-------------
; Appearance

(defmethod part-color ((menu pop-up-menu) key)
  (or (getf (slot-value menu 'color-list) key nil)
      (case key (:menu-body (if (control-handle menu) nil *white-color*)))))

#| ;; moved to dialogs.lisp
(defun current-pixel-depth () ; compare to the screen-bits function
  (with-port-macptr port
    (with-macptrs ((portpixmap (#_getportpixmap port)))
      (href portpixmap :pixmap.pixelsize))))

(defun current-port-color-p ()
  (with-port-macptr port
    (#_isportcolor port)))


(export 'draw-theme-text-box :ccl)

(defun draw-theme-text-box (text rect &optional (text-justification :center) truncwhere (active-p t) (color nil color-sup))
  ;; could add a truncate option and use TruncateThemeText
  (let ((start 0) 
        (end (length text))
        (*in-draw-theme* t))
    (when (not (simple-string-p text))
      (multiple-value-setq (text start end)(string-start-end text start end)))
    (when (not (fixnump text-justification))
      (setq text-justification
            (case text-justification
              (:center #$tejustcenter)
              (:left #$tejustleft)
              (:right #$tejustright)
              (t #$tejustcenter))))
    (when (not color-sup)(setq color (grafport-fore-color)))
    (with-theme-state-preserved
      (with-fore-color color  ;; after with-theme-state... 
        (when (not active-p)  ;; let it have it's own color if active
          (#_SetThemeTextColor #$kThemeTextColorDialogInactive
           (current-pixel-depth) (current-port-color-p)))
        (with-cfstrs-hairy ((cftext text start end))
          (if (not truncwhere)       
            (#_Drawthemetextbox cftext #$kThemeCurrentPortFont #$Kthemestateactive t rect text-justification (%null-ptr))
            (progn
              (setq truncwhere
                    (case truncwhere
                      (:end #$truncend)
                      (:middle #$truncmiddle)
                      (t #$truncend)))
              (with-macptrs ((copy (#_CFStringCreateMutableCopy (%null-ptr) 0 cftext)))
                (unwind-protect
                  (progn
                    (rlet ((foo :boolean))
                      (#_TruncateThemeText copy #$kThemeCurrentPortFont #$Kthemestateactive
                       (- (pref rect :rect.right)(pref rect :rect.left))
                       truncwhere
                       foo))
                    (#_DrawThemetextbox copy #$kThemeCurrentPortFont #$Kthemestateactive t rect text-justification (%null-ptr)))
                  (#_cfrelease copy))))))))))
|#

;; for both pull-down and pop-up
(defmethod draw-menu-title ((menu pop-up-menu))
  (let* ((text (menu-title menu))
         (no-title (or (null  text)(equal text ""))))
    (unless no-title
      (let* ((ti-rect (pop-up-menu-title-rect menu))
             (enabled (menu-enabled-p menu))
             (colorp (and (color-or-gray-p menu)(window-color-p (view-window menu))))
             (disabled-color (if (and (not enabled) colorp)
                               *gray-color*))
             (title-color (or disabled-color
                              (part-color menu :menu-title))))        
        (multiple-value-bind (ff ms)(view-font-codes menu)
          (let ((lineheight (font-codes-line-height ff ms)))
            (progn ;with-fore-color title-color ; 21-Jun-91 -wkf  ; draw-string does it               
              (with-back-color (part-color menu :title-background)
                (#_EraseRect  ti-rect)
                (rlet ((my-rect :rect))
                  (copy-record ti-rect :rect my-rect)
                  (let* ((rect-height (- (pref my-rect :rect.bottom)(pref my-rect :rect.top)))
                         (delta (max 0 (ash (- rect-height lineheight) -1))))
                    (setf (pref my-rect :rect.top) (+ (pref my-rect :rect.top) delta))) 
                  (draw-string-in-rect text  my-rect :ff ff :ms ms :color title-color))
                ))))))))

(defmethod view-draw-contents ((menu pop-up-menu))
  (with-focused-dialog-item (menu)
    (draw-menu-title menu)
    (let ((handle (control-handle menu)))
      (if handle
        (progn ;with-focused-view menu
          (if (#_iscontrolvisible handle)
            (#_Draw1Control handle)
            (#_ShowControl handle)))))))




(defun paint-menu-gray (menu)
  (let* ((ti-rect (pop-up-menu-title-rect menu))
         (no-title (equal (menu-item-title menu) "")))
    (rlet ((ps :penstate))
      (with-item-rect (rect menu)
        (#_InsetRect rect 0 -1)
        (#_GetPenState ps)
        (#_PenPat *gray-pattern*)
        (#_PenMode 11)
        (#_PaintRect rect)
        (unless no-title (#_PaintRect ti-rect)) ; ??
        (#_SetPenState ps)))))
  

(defun get-menu-body-text (menu)
  (let ((item-display (pop-up-menu-item-display menu)))
    (cond ((eq item-display :selection)
           (let* ((selection (pop-up-menu-default-item menu))
                  (items (menu-items menu)))
             (cond ((null items) (the-empty-menu-string menu))
                   ((zerop selection) "<No selection>")
                   (t (menu-item-title (nth (1- selection) items))))))
          ((stringp item-display)
           item-display)
          (t 
           (format nil "~a" item-display)))))

#+ignore ;; obsolete
(defmethod draw-triangle ((menu pop-up-menu))
  (cond ((< 16 (point-v (view-size menu)))      ; Big triangle
         (#_line 10 0)
         (#_line -5 5)
         (#_line -4 -4)
         (#_line 7 0)
         (#_line -3 3)
         (#_line -2 -2)
         (#_line 3 0)
         (#_line -1 1))
        (t
         (#_move 2 0)
         (#_line 6 0)
         (#_line -3 3)
         (#_line -2 -2)
         (#_line 3 0)
         (#_line -1 1))))



;-------------
; Click event handling - sez who

(defmethod view-activate-event-handler ((menu pop-up-menu))  
  (when (and (menu-enabled-p menu)(control-handle menu))
    (with-focused-dialog-item (menu)
      (#_activatecontrol (control-handle menu)))))

(defmethod view-deactivate-event-handler ((menu pop-up-menu))  
  (when (and (menu-enabled-p menu)(control-handle menu))
    (with-focused-dialog-item (menu)
      (#_deactivatecontrol (control-handle menu)))))


(defmethod menu-disable ((menu pop-up-menu))
  (when (menu-enabled-p menu)
    (invalidate-view menu)
    (when (control-handle menu)
      (with-focused-dialog-item (menu)
        (#_deactivatecontrol (control-handle menu)))) ;(#_HiliteControl (control-handle menu) 255)))
    (call-next-method)))

(defmethod menu-enable ((menu pop-up-menu))
  (when (not (menu-enabled-p menu))
    (invalidate-view menu)
    (when (control-handle menu)
      (with-focused-dialog-item (menu)
        (#_activatecontrol (control-handle menu)))) ;(#_HiliteControl (control-handle menu) 0)))
    (call-next-method)))

(defmethod dialog-item-enable ((menu pop-up-menu))
  (menu-enable menu))

(defmethod dialog-item-disable ((menu pop-up-menu))
  (menu-disable menu))

#+ignore
(defmethod view-click-event-handler ((menu pop-up-menu) where)
  (declare (ignore where))
  (when (menu-enabled-p menu)
    (let ((no-text (eq 0  (length (menu-title menu)))))    
      (unless no-text
        ; want to hilite not invert
        (title-hilite menu))
      (menu-select menu 0)        
      (unless no-text
        (title-hilite menu t)))))

(defmethod view-click-event-handler ((menu pop-up-menu) where)
  (declare (ignore where))
  (when (menu-enabled-p menu)
    (let ((no-text (eq 0  (length (menu-title menu)))))    
      (unless no-text
        ; want to hilite not invert
        (title-hilite menu))
      (allow-view-draw-contents (view-window menu))
      (with-focused-view nil
        (menu-select menu 0))        
      (unless no-text
        (title-hilite menu t)))))

(defmethod title-hilite ((menu pop-up-menu) &optional un)
   (when (view-get menu :highlight-title)
     (let ((rect (pop-up-menu-title-rect menu)))
       (when rect
         (if un
           (invalidate-view menu)
           (progn
             (#_LMSetHiliteMode (%ilogand2 #x7f (#_LMGetHiliteMode)))
             (with-focused-view (view-container menu)
               (#_InvertRect rect))))))))

(defmethod set-part-color ((menu pop-up-menu) part color)
  (declare (ignore part))
  (call-next-method)
  (invalidate-view menu)
  color)


;-------------
; Adding/removing items

#|
(defmethod add-menu-items ((menu pop-up-menu) &rest items)
  (declare (ignore items))
  (call-next-method)
  (when (pop-up-menu-auto-update-default menu)
    (let* ((default (pop-up-menu-default-item menu))
           (items (menu-items menu)))
      (when items
        (when nil
          (dolist (item items)
            (when (menu-item-check-mark item)
              (set-menu-item-check-mark item nil))))
        (cond ((and default (neq default 0))
               (set-pop-up-menu-default-item menu 0)
               (set-pop-up-menu-default-item menu default))
              (t (set-pop-up-menu-default-item menu 1))))))
  ;#+ignore ;; does it work - ??
  (let ((handle (control-handle menu)))
    (when handle
      (with-focused-dialog-item (menu)
        (#_disposecontrol handle)
        (make-new-pop-up-control menu)))))
|#


;; this is stupidly inefficient when control-handle
(defmethod add-menu-items ((menu pop-up-menu) &rest items)
  (declare (ignore items))
  (call-next-method)
  (when (pop-up-menu-auto-update-default menu)
    (let* ((default (pop-up-menu-default-item menu))
           (items (menu-items menu)))
      (when items       
        (when nil
          (dolist (item items)
            (when (menu-item-check-mark item)
              (set-menu-item-check-mark item nil))))
        (cond ((and default (neq default 0))
               ; (set-pop-up-menu-default-item menu 0)
               (set-pop-up-menu-default-item menu default)
               )
              (t (set-pop-up-menu-default-item menu 1))))))
  (let ((handle (control-handle menu)))
    (when handle
      (let ((items (menu-items menu)))
        (with-focused-dialog-item (menu)
          (#_SetControl32bitMaximum handle (length items))
          (let ((default (pop-up-menu-default-item menu)))
            (when default
              ;(set-pop-up-menu-default-item menu 0)
              (set-pop-up-menu-default-item menu default t))))))))


(defmethod add-menu-items :after ((menu pop-up-menu) &rest items)
  (declare (dynamic-extent items))
  ; fix this mess or nuke it and do in main method
  ;  nb changing the font of a menu on the fly wont do item style today
  (let ((style-num (lsh (logand (view-font-codes menu) #xffff) -8)))
    (when (neq style-num #.(cdr (assq :plain *style-alist*)))
      (let ((style (inverse-style-arg style-num)))
        (dolist (i items)
          (when (not (menu-item-style i))
            (set-menu-item-style i style))))))
  (setf (pop-up-menu-cached-title menu) nil))


(defmethod remove-menu-items :after ((menu pop-up-menu) &rest ignore)
  (declare (ignore ignore))
  (setf (pop-up-menu-cached-title menu) nil)
  ;(setf (pop-up-menu-default-item menu) 0) ; nah, use around method below
  )

; This prevents the default item from becoming larger than the
; number of items in the menu. It also keeps the default-item
; constant even if its position changes.
#|
(defmethod remove-menu-items :around ((menu pop-up-menu) &rest items)
  (declare (ignore items))
  (let* ((default-item-number (pop-up-menu-default-item menu))
         (default-item (unless (eql default-item-number 0)
                         (nth (1- default-item-number) (menu-items menu)))))
    
    (when default-item (set-pop-up-menu-default-item menu 0))
    (unwind-protect
      (call-next-method)
      (when (and default-item (menu-items menu))
        (let ((index (position default-item (menu-items menu))))
          (set-pop-up-menu-default-item menu (if index (1+ index) 1))))
      ;#+ignore 
      (let ((handle (control-handle menu)))
        (when handle
          (with-focused-dialog-item (menu)
            (#_disposecontrol handle)
            (make-new-pop-up-control menu)))))))
|#

(defmethod remove-menu-items :around ((menu pop-up-menu) &rest items)
  (declare (ignore items))
  (let* ((default-item-number (pop-up-menu-default-item menu))
         (default-item (unless (eql default-item-number 0)
                         (nth (1- default-item-number) (menu-items menu)))))
    
    (when default-item (set-pop-up-menu-default-item menu 0))
    (unwind-protect
      (call-next-method)
      (when (and default-item (menu-items menu))
        (let ((index (position default-item (menu-items menu))))
          (set-pop-up-menu-default-item menu (if index (1+ index) 1))))
      ;#+ignore 
      (let ((handle (control-handle menu)))
        (when handle
          (let ((items (menu-items menu)))
            (with-focused-dialog-item (menu)
              (#_SetControl32bitMaximum handle (length items))
              (let ((default (pop-up-menu-default-item menu)))
                (when default
                  ;(set-pop-up-menu-default-item menu 0)
                  (set-pop-up-menu-default-item menu default t))))))))))


;---------------
; Selection

(defmethod selected-item ((menu pop-up-menu))
  (nth (1- (pop-up-menu-default-item menu)) (menu-items menu)))

;Update the menu's items then displays the pop-menu.  Default-item is the
;item which will come up selected  when the menu is displayed.
(defmethod menu-select ((menu pop-up-menu) num
                        &aux selection
                        selected-menu
                        selected-menu-item
                        (a-rect (pop-up-menu-rect menu))
                        (pos (with-focused-view (view-container menu)
                               (%local-to-global
                                (wptr menu)
                                (rref a-rect :rect.topleft)))))
  (declare (ignore num))
  (menu-update menu)
  
  (multiple-value-bind (ff ms)(view-font-codes menu)
    (let* ((handle (menu-handle menu))
           (cached-title (pop-up-menu-cached-title menu))
           (items (menu-items menu))
           (orig (if items (menu-item-title (car items)))))
      (when (and (not cached-title) items)
        (setq cached-title (adjusted-menu-item-title menu)))
      (unwind-protect
        (progn ;with-focused-view nil
          (when cached-title (set-menu-item-title (car items) cached-title))
          (when t ;(not (menu-font menu)) ;unless same-p            
            ;; may not be needed?
            (#_setmenufont handle (ash ff -16) (logand ms #xffff)))
          (setq selection (#_PopUpMenuSelect
                           handle
                           (+ (point-v pos) (menu-select-v-offset menu)(menu-display-v-offset menu))
                           (+ (point-h pos) (menu-display-h-offset menu))
                           (or (pop-up-menu-default-item menu) 0))
                ;we get the selected menu in case you want to break the rules
                ;and use heirarchical menus in a pop-up menu
                selected-menu (menu-object (ash (logand #xFFFF0000 selection) -16))
                selected-menu-item (logand #x0000FFFF selection)))                  
        (when cached-title
          (set-menu-item-title (car items) orig)
          (setf (pop-up-menu-cached-title menu) cached-title)))
      (when (typep menu 'pull-down-menu) ; gag-puke
        ;(#_Invertrect :ptr (pop-up-menu-rect menu))
        (inval-window-rect (wptr menu)(pop-up-menu-rect menu))
        ;(#_Invalrect :ptr (pop-up-menu-rect menu))
        )
      (unless (eq selected-menu-item 0)
        (let* ((items (menu-items selected-menu))
               (update (pop-up-menu-auto-update-default menu)))
          (when update
            (set-pop-up-menu-default-item menu
                                          (if (eq selected-menu menu)
                                            selected-menu-item
                                            (let ((1st-level-submenu selected-menu))
                                              (loop
                                                (let ((owner (menu-owner 1st-level-submenu)))
                                                  (if (eq owner menu)
                                                    (return (1+ (position 1st-level-submenu (menu-items menu)))))
                                                  (if (null owner)
                                                    (return (pop-up-menu-default-item menu)))
                                                  (setq 1st-level-submenu owner)))))))
          (with-event-processing-enabled 
            (when update (event-dispatch))  ; let it be drawn          
            (menu-item-action
             (nth (- selected-menu-item 1) items))))))))

;; doesn't really work when size is much bigger than it needs to be
#+ignore
(defmethod menu-select-v-offset ((menu pop-up-menu))
  (if (control-handle menu)
    (let ((lh (view-font-line-height menu))
          (vh (point-v (view-size menu))))
      (cond ((> vh (+ lh 2))
             (let ((mouse-v (point-v (view-mouse-position menu))))
               (max 0 (- mouse-v (- vh lh)))))
            (t 0)))
    0))

(defmethod menu-select-v-offset ((menu pop-up-menu))
  (if (control-handle menu)
    (let ((lh (view-font-line-height menu))
          (vh (point-v (view-size menu)))
          (mouse-v (point-v (view-mouse-position menu)))
          )      
      (cond ((< mouse-v lh) 0)            
            ((and (> vh (+ lh 2)))
             (max 0 (- mouse-v lh)))             
            (t 0)))
    0))





  
;---------
; Install/deinstall menu


(defmethod menu-font ((menu pop-up-menu))
  (or (slot-value menu 'menu-font)
      (view-font menu)))

(defmethod view-font-codes ((menu pop-up-menu))
  (let ((font-slot (slot-value menu 'menu-font)))
    (if font-slot
      (font-codes font-slot)
      (call-next-method))))
    

; dont lose the default item
#+ignore
(defmethod menu-install ((menu pop-up-menu))
  "Creates the actual Macintosh menu with all of the menu's current items."
  (let* ((menu-items (menu-items menu))
         (default (pop-up-menu-default-item menu)))
    (apply #'remove-menu-items menu menu-items)
    (init-menu-id menu)
    (with-pstrs ((menu-title (menu-title menu)))
      (let ((menu-handle (#_NewMenu (slot-value menu 'menu-id)  menu-title)))
        (#_InsertMenu menu-handle -1)
        (setf (slot-value menu 'menu-handle) menu-handle)
        (when t ;(menu-font menu)
          (multiple-value-bind (ff ms)(view-font-codes menu)
            (when ff
              (#_SetMenuFont menu-handle (ash ff -16)(logand ms #xffff)))))))
    (let* ((colors (part-color-list menu)))
      (loop
        (unless colors (return))
        (set-part-color menu (pop colors) (pop colors))))
    (apply #'add-menu-items menu menu-items)
    (when (and default (neq 0 default))
      (set-pop-up-menu-default-item menu default))))


(defmethod menu-install ((menu pop-up-menu))
  "Creates the actual Macintosh menu with all of the menu's current items."
  (let* ((menu-items (menu-items menu))
         (default (pop-up-menu-default-item menu)))
    (apply #'remove-menu-items menu menu-items)
    (init-menu-id menu)
    (rlet ((foo :ptr))
      (let* ((the-title (menu-title menu))
             (menu-handle))
        (errchk (#_CreateNewMenu (slot-value menu 'menu-id) 0 foo))
        (setq menu-handle (%get-ptr foo))
        (if (7bit-ascii-p the-title)
          (with-pstrs ((menu-title the-title))
            (#_SetMenuTitle menu-handle menu-title))
          (set-menu-title-cfstring menu-handle the-title))
        (#_InsertMenu menu-handle -1)
        (setf (slot-value menu 'menu-handle) menu-handle)
        (when t ;(menu-font menu)
          (multiple-value-bind (ff ms)(view-font-codes menu)
            (when ff
              (#_SetMenuFont menu-handle (ash ff -16)(logand ms #xffff)))))))
    (let* ((colors (part-color-list menu)))
      (loop
        (unless colors (return))
        (set-part-color menu (pop colors) (pop colors))))
    (apply #'add-menu-items menu menu-items)
    (when (and default (neq 0 default))
      (set-pop-up-menu-default-item menu default))))


  

; need this for kanji menu items
#+ignore 
(defmethod menu-install :after ((menu pop-up-menu))
  ; Need to make extended string titles appear in some extended script
  ; need to do this even if menu-script is "osaka" - weird
  (let* ((menu-script (ff-script (view-font-codes menu)))
         (mscript-2byte (two-byte-script-p menu-script))
         ;(system-script (#_GetScriptManagerVariable #$smSysScript))
         (xstr-script (extended-string-script)))
    (when (or (and xstr-script) mscript-2byte)  ; (neq xstr-script menu-script))
      (let ((the-script (if mscript-2byte  menu-script xstr-script)))
        (dolist (item (menu-items menu))
          (let ((title (menu-item-title item)))
            (when (or mscript-2byte
                      (and (extended-string-p title)
                           (real-xstring-p title)))  ; stuff I don't understand
              (set-menu-item-script item the-script))))))))
#|
              (set-command-key item (code-char #x1c))  ; backarrrow
              (unless (eq 0 the-script)
                (set-menu-item-icon-num item the-script)))))))))
|#



(defmethod menu-deinstall ((menu pop-up-menu))
  (let* ((*menubar-frozen* t))
    (call-next-method)))

(defmethod remove-view-from-window ((menu pop-up-menu))
   (menu-deinstall menu)
   (call-next-method)
   (without-interrupts
    (dispose-record (pop-up-menu-rect menu) :rect)
    (setf (pop-up-menu-rect menu) nil)
    (dispose-record (pop-up-menu-title-rect menu) :rect)
    (setf (pop-up-menu-title-rect menu) nil)
    (when (control-handle menu)
      (with-focused-dialog-item (menu) ; <=
        (#_disposecontrol (control-handle menu)))
      (setf (control-handle menu) nil))))


;;;;;;;;;;;;;;;;;
;;
;; action-pop-up-menu
;;
;; An action-pop-up-menu should have a separator as the second item;
;; the menu will pop up over the separator, so a quick click doesn't
;; cause anything to happen.

(defclass action-pop-up-menu (pop-up-menu)
  ())

(defmethod view-click-event-handler :before ((menu action-pop-up-menu) where)
  (declare (ignore where))
  (set-pop-up-menu-default-item menu 2))

(defmethod view-click-event-handler :after ((menu action-pop-up-menu) where)
  (declare (ignore where))
  (set-pop-up-menu-default-item menu 1))


;;;;;;;;;;;;;;;;;
;;
;; pull-down-menu
;;
;; omits the triangle and outline. No default


(defclass pull-down-menu (pop-up-menu)
  ((:crescent :initarg :crescent :initform nil :reader crescent))
  (:default-initargs
    :auto-update-default nil
    :default-item 0))

(defmethod part-color ((menu pull-down-menu) key)
  ;; don't default body to white
  (getf (slot-value menu 'color-list) key nil))

(defmethod menu-display-v-offset ((menu pull-down-menu))
  (if t ;(osx-p)
    (+ 3 (point-v (view-size menu)))
    (1- (point-v (view-size menu)))))

(defun pull-down-menu-p (menu)
  (typep menu 'pull-down-menu))

#|
(defmethod view-click-event-handler ((menu pull-down-menu) where)
  (declare (ignore where))
  (with-focused-view (view-container menu)  ; << focus she said
    (#_InvertRect :ptr (pop-up-menu-rect menu))
    (menu-select menu 0)))
|#

(defmethod view-draw-contents ((menu pull-down-menu))
  (let* ((enabled (menu-enabled-p menu))
         (colorp (and (color-or-gray-p menu)(window-color-p (view-window menu))))
         (disabled-color (if (and (not enabled) colorp)
                           *gray-color*))
         (title-color (or disabled-color
                          (part-color menu :menu-title))))
    (with-focused-dialog-item (menu)  ; take font from item, draw in containers coords - this is the other thing that dialog item gives us
      (multiple-value-bind (ff ms)(view-font-codes menu) 
        (draw-menu-title menu)  ;; very unlikely that there is one
        (rlet ((a-rect :rect))
          (copy-record (pop-up-menu-rect menu) :rect a-rect)
          (let ((mi-title (get-menu-body-text menu)))
            (with-back-color (part-color menu :menu-body) ; 10-Nov-92 -straz
              (#_EraseRect a-rect)
              (cond ((crescent menu)
                     (let ((tl (rref a-rect rect.topleft)))
                       (#_moveto (point-h tl)(point-v tl))
                       (dolist (length '(5 3 2 1 0 0))
                         (#_line length 0)
                         (#_move (- length) 1)))))
              (progn ;with-fore-color title-color ;; draw-string does it
                (let* ((left (+ (rref a-rect rect.left) 7)))
                  (progn ;with-clip-rect-intersect a-rect  ;;draw-string does it
                    (setf (pref a-rect :rect.left) left)
                    (incf (pref a-rect :rect.top) 2)
                    (draw-string-in-rect mi-title  a-rect :ff ff :ms ms :color title-color))
                  )))))               
        (unless (or enabled colorp)
          (paint-menu-gray menu))))))



(defmethod view-click-event-handler ((menu pull-down-menu) where)
  (declare (ignore where))
  (when (menu-enabled-p menu)
    (multiple-value-bind (ff ms)(view-font-codes menu)
      (with-focused-dialog-item (menu)  ; << focus she said
        ;; redraw with back-color black and fore-color white, or fore and back switched?
        (let ((orig-back (or (part-color menu :menu-body) *white-color*))
              (orig-fore  (or (part-color menu :menu-title) *black-color*)))
          (rlet ((rect :rect))
            (copy-record (pop-up-menu-rect menu) :rect rect)
            (with-back-color orig-fore
              (let* ((mi-title (get-menu-body-text menu))
                     (left (+ (rref rect rect.left) 7))  ;(if pull-down-p 6 (max 6 w))))
                     )
                (#_Eraserect rect)
                (progn ;with-clip-rect-intersect rect ;; draw-string does it
                  (setf (pref rect :rect.left) left) 
                  (incf (pref rect :rect.top) 2)
                  (draw-string-in-rect mi-title  rect :ff ff :ms ms :color orig-back)
                  )))))
        (menu-select menu 0)))))


(defmethod point-in-click-region-p ((menu pull-down-menu) where)
  ; in this case it can be anyplace
  (view-contains-point-p menu where))

(defmethod use-pop-up-control ((menu pull-down-menu)) nil)

  

;;;;;;;;;;;;;;;;;
;;
;; typein-menu 
;;
;; its items should be of type typein-menu-item


(defclass typein-menu (view)
  ((menu :initform nil :accessor typein-menu-menu)
   (menu-position :initarg :menu-position :initform :right :reader typein-menu-menu-position) 
   (editable-text :initform nil
                  :accessor typein-editable-text))
  (:default-initargs
    :menu-class 'typein-menu-menu
    :view-subviews nil
    :editable-text-class 'editable-text-dialog-item))

(defmethod menu-disable ((menu typein-menu))
  (let ((mm (typein-menu-menu menu)))
    (when (menu-enabled-p mm)
      (menu-disable mm)
      (dialog-item-disable (typein-editable-text menu))
      (invalidate-view menu))))  ; get the title if any

(defmethod menu-enable ((menu typein-menu))
  (let ((mm (typein-menu-menu menu)))
    (unless (menu-enabled-p mm)
      (menu-enable mm)
      (dialog-item-enable (typein-editable-text menu))
      (invalidate-view menu))))

(defclass typein-menu-menu (pop-up-menu)()
  (:default-initargs
    ;:auto-update-default nil
    :item-display ""
    :default-item 0))

;; so the title if any will redraw
#| ;; what
(defmethod view-corners ((tmm typein-menu-menu))
  (let ((cont (view-container tmm)))
    (let* ((tl #@(0 0))
           (br (add-points tl (view-size cont))))
      (values tl br))))
|#

(defmethod view-corners ((tmm typein-menu-menu))
  (call-next-method))


(defmethod initialize-instance :after ((view typein-menu-menu) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs)))


;---------

(defmethod add-menu-items ((menu typein-menu-menu) &rest items)
  (let* ((second (second items))
         (typein-p (and second (string= (menu-item-title second) "-"))))
    (if (not typein-p)
      (apply #'call-next-method
             menu
             (make-instance 'typein-menu-item :menu-item-title "None")
             (make-instance 'menu-item :menu-item-title "-")
             items)
      (call-next-method))))

(defmethod menu-display-v-offset ((menu typein-menu-menu))
  (case (typein-menu-menu-position (view-container menu))
    (:left 2) ; line up with title & text, doesn't cover the control (could erase it oneself)
    (t 2)))   ; maybe we will

; do we really want these dudes to have titles?
(defmethod size-rectangles ((menu typein-menu-menu))
  (let ((title (menu-title menu)))
    (if (eq (length title) 0)
      (call-next-method)
      (let* ((my-pos (view-position menu))
             (my-size (view-size menu)))
        (when (and my-pos my-size)
          (multiple-value-bind (ff ms)(view-font-codes menu)
            (setq my-size (add-points my-size #@(-1 -1)))
            (if (use-pop-up-control menu)(setq my-pos (add-points my-pos #@(0 1)))) ;; tweak else lose top edge
            (let* ((menu-rect (or (pop-up-menu-rect menu)
                                  (setf (pop-up-menu-rect menu) (make-record :rect))))
                   (title-rect (or (pop-up-menu-title-rect menu)
                                   (setf (pop-up-menu-title-rect menu)
                                         (make-record :rect))))
                   (title-width (+ 8 (font-codes-string-width title ff ms))))
              (rset menu-rect :rect.topleft my-pos)
              (rset menu-rect :rect.bottomright (add-points my-pos my-size))
              (rset title-rect :rect.topleft (make-point 0 (+ (point-v my-pos) 2)))
              (rset title-rect :rect.bottomright (make-point title-width
                                                             (+ (point-v my-size)
                                                                (point-v my-pos)
                                                                -1))))))))))

(defmethod menu-select ((menu typein-menu-menu) num)
  (declare (ignore num))
  (let ((num (pop-up-menu-default-item menu)))
    (if (or (not (menu-enabled-p menu))(and num (> num 1)))
      (call-next-method)      
      (let* ((c (view-container menu))
             (pos (typein-menu-menu-position c))
             (view-pos (view-position menu))
             ;(w (- (point-h (view-size menu)) 2))
             (tl view-pos)
             (br (make-point (point-h (view-size c)) 1))
             t-pos t-w)
        (when (eq pos :left)
          (let ((text (typein-editable-text c)))
            (setq t-pos (subtract-points (view-position text) #@(2 2)))
            (setq t-w (+  (point-h (view-size text)) 3))
            (setq tl #@(0 0))))
        (rlet ((rect :rect :topleft tl :bottomright br))
          ; erase top edge which is not obscured by the menu contents
          (#_eraserect rect))
          (call-next-method)
          ; restore top edge
          (progn
            ;; change for platinum-pop-up compatibility
            (invalidate-corners menu #@(0 0) (make-point (point-h (view-size menu)) 1))
            ;(#_moveto :long view-pos)
            ;(#_line :word w :word 0)
            (when (eq pos :left)
              (#_moveto (point-h t-pos)(point-v t-pos))
              (#_line t-w 0))))
            )))



(defmethod initialize-instance ((view typein-menu) &rest initargs
                                &key view-size
                                view-position
                                menu-class
                                menu-position
                                menu-items
                                menu-title
                                view-font
                                item-display
                                (draw-outline -2)
                                (dialog-item-text "")
                                editable-text-class)
  (declare (dynamic-extent initargs)(ignore menu-position menu-items menu-title item-display))
  (apply #'call-next-method view 
         :view-size view-size    ; make default size&pos work right
         :view-position view-position
         initargs)
  (let ((menu (apply #'make-instance menu-class               
                     :view-container view
                     ;:dialog-item-text nil ; ??
                     initargs)))
    (setf (typein-menu-menu view) menu)    
    (let* ((edit (make-instance editable-text-class
                  :view-container view                  
                  :draw-outline draw-outline
                  (if view-font :view-font :ignore) view-font
                  ;:margin  (max (nth-value 2 (font-codes-info ff ms)) 6)
                  :dialog-item-text dialog-item-text
                  :allow-returns nil :allow-tabs nil)))
      (setf (typein-editable-text view) edit))
    (when view-size (view-size-parts view))))

(defmethod view-default-size ((view typein-menu))
  (multiple-value-bind (ff ms) (view-font-codes view)
    (let ((text (typein-editable-text view))
          (menu (typein-menu-menu view)))
      (if (and text menu)
        (let* ((size (or (view-size text) (view-default-size text)))
               (h (max 100 (point-h size)))
               (v (point-v size))
               (title (menu-title menu))
               (title-width (if (eq 0 (length title)) 0 (font-codes-string-width title ff ms))))
          (make-point (+ h title-width 6 (if (> v 16) 22 20))(if t #|(osx-p)|# (max 22 (+ 4 v))(+ 4 v))))))))

(defmethod view-size-parts ((view typein-menu))  
  (let* ((size (view-size view))
         (size-v (point-v size))
         (size-h (point-h size))
         (menu (typein-menu-menu view))
         (text (typein-editable-text view))
         (title (menu-item-title menu))
         (title-width 0)
         (v-delta 2)) ;;  ugly on os9 but the focus rect does show
    (multiple-value-bind (ff ms)(view-font-codes view)
      (when (not (eql 0 (length title)))        
        (setq title-width (+ 8 (font-codes-string-width title ff ms))))
      (let* ((menu-h (if (> size-v 16) 22 20)))      
        (set-view-size menu (make-point menu-h  size-v))
        (set-view-size text (make-point (- size-h (+ menu-h 6 title-width)) (- size-v (+ v-delta v-delta))))
        (case (typein-menu-menu-position view)
          (:left (set-view-position menu (make-point title-width 0))
                 (set-view-position text (make-point (+ menu-h 4 title-width ) (+ 1 v-delta))))
          (t 
           (set-view-position menu (make-point (+  size-h (- menu-h)) 0))
           (set-view-position text (make-point (+ 0 title-width)  (1+ v-delta)))))))))  ;; 0 was 2

#| ;; makes more sense but doesn't dwim
(defmethod view-corners ((view typein-menu)) ;; so the focus rect will show up
  (multiple-value-bind (menu-tl menu-br)(view-corners (typein-menu-menu view))
    (multiple-value-bind (text-tl text-br)(view-corners (typein-editable-text view))
      (let* ((menu-top (point-v menu-tl))
             (menu-bot (point-v menu-br))
             (menu-left (point-h menu-tl))
             (menu-right (point-h menu-br))
             (text-top (point-v text-tl))
             (text-bot (point-v text-br))
             (text-left (point-h text-tl))
             (text-right (point-h text-br))             
             (my-top (min menu-top text-top))
             (my-bot (max menu-bot text-bot))
             (my-left (min menu-left text-left))
             (my-right (max menu-right text-right))
             (container (view-container view)))
        (values (convert-coordinates (make-point my-left my-top) view container)
                (convert-coordinates (make-point my-right my-bot) view container))))))
|#
        
 
                                                      
(defmethod view-corners ((view typein-menu)) ;; so the focus rect will show up    
  (multiple-value-bind (tl br)
                       (multiple-value-call  #'inset-corners #@(-4 -4)(call-next-method))
    (if (eq (typein-menu-menu-position view) :left)
      (setq br (add-points br #@(2 0)))
      (setq tl (subtract-points tl #@(2 0))))
    (values tl br)))


(defmethod set-default-size-and-position ((view typein-menu) &optional container)
  (declare (ignore container))
  (call-next-method)
  (view-size-parts view))
    

;-----------


(defmethod install-view-in-window ((menu typein-menu) dialog &aux ok)  
  (declare (ignore dialog))
  (without-interrupts
   (unwind-protect
     (let ((container (view-container menu)))
       (set-default-size-and-position menu container)
       (setq ok t))
     (unless ok
       (set-view-container menu nil))))
  (call-next-method))

; do we want to  deal with vertical changes as well? naah
(defmethod set-view-size ((view typein-menu) h &optional v)
  (declare (ignore h v))
  (let ((menu (typein-menu-menu view)))
    (setf (pop-up-menu-cached-title menu) nil)
    (call-next-method)
    (view-size-parts view))
  (view-size view))


(defmethod menu-display-h-offset ((menu typein-menu-menu))
  (case (typein-menu-menu-position (view-container menu))
    ((:right :left) 
     1)
    (t  ; this we probably won't ever use     
     (let* ((text-size (point-h (view-size (typein-editable-text 
                                            (view-container menu))))))       
       (- -5 text-size)))))

(defmethod menu-item-icon-handle ((item menu)) nil)

(defmethod menu-item-icon-num ((item menu)) nil)

(defun max-menu-width (menu)
  (multiple-value-bind (ff ms)(view-font-codes menu)
    ;(setq ff (logand ff #Xffff0000))
    (let* ((max 0)
           (fudge (if (and (not (typep menu 'pull-down-menu))
                           (or (fboundp 'new-draw-pop-up-menu) (use-pop-up-control menu)))
                    (dolist (m (menu-items menu) 2)   ;(if (osx-p) 2 0))
                      (if (or (menu-item-icon-handle m)(menu-item-icon-num m))
                        (return 24))) ;; constant 16 may be wrong in some cases
                    0)))
      (dolist (m (menu-items menu) max)
        (when (> (setq m (+ fudge (font-codes-string-width (menu-item-title m)
                                                  ff ms)))
                 max)
          (setq max m))))))
    

; vanilla menu-item action functions do not take an argument!

(defclass typein-menu-item (menu-item) ())

(defmethod menu-item-action ((item typein-menu-item))
  (let ((action (menu-item-action-function item)))    
    (let* ((menu (menu-item-owner item))
           (ti (typein-editable-text (view-container menu)))
           (new-text (if (and (eq 1 (pop-up-menu-default-item menu))
                              (string= "None" (menu-item-title item)))
                       "" 
                       (menu-item-title item))))
      (when (not (string= (dialog-item-text ti)
                          new-text)) ; prevents flashies
        (set-dialog-item-text ti new-text))
      (let ((items (menu-items menu)))
        (dolist (i items)
          (when (menu-item-check-mark i)
            (set-pop-up-item-check-mark i nil)
            (return))))
      (set-pop-up-item-check-mark item t))
    (if action (funcall action item))))

(defparameter *chicago-font* 0)  ;; avoid some consing below
(def-ccl-pointers chicago-font1 ()
  (setq *chicago-font* (ash (font-codes '("chicago")) -16)))

(defun set-pop-up-item-check-mark (item mark)  
  (let ((menu (menu-item-owner item)))
    (when (and menu (eq mark t)
               (let ((font (ash (view-font-codes menu) -16)))
                 (not (or (eq font (ash (sys-font-codes) -16))
                          (eq font *chicago-font*)))))
      (setq mark  (code-char 195)))  ;; weird = macroman #\altCheckMark
    (set-menu-item-check-mark item mark)))
  


(defmethod view-click-event-handler ((menu typein-menu-menu) where)
  (declare (ignore where))  
  (let* ((ti (typein-editable-text (view-container menu)))
         (items (menu-items menu))
         (text-p (not (= 0 (dialog-item-text-length ti)))))
    (when (not items)
      (add-menu-items menu)
      (setq items (menu-items menu)))
    (if text-p
      (let ((str (dialog-item-text ti)))
        (unless
          (let ((n 1))
            (dolist (item (menu-items menu) nil)
              (when (string-equal str (menu-item-title item))
                (set-pop-up-menu-default-item menu n)
                (return t))
              (setq n (1+ n))))
          (setf (pop-up-menu-cached-title menu) nil)
          (set-menu-item-title (car items) str)
          (set-pop-up-menu-default-item menu 1)))
      (progn
        (when (not (string= (menu-item-title (car items)) "None"))
          (setf (pop-up-menu-cached-title menu) nil)          
          (set-menu-item-title (car items) "None"))
        (set-pop-up-menu-default-item menu 1)))
    (with-focused-view (view-container menu)
      (call-next-method))        
    (when (dialog-item-enabled-p ti) ; let it be typeable always - gratuitous change - forget it
      (set-current-key-handler (view-window menu) ti))))

;----------
; Menu body width

(defmethod menu-body-width ((menu pop-up-menu))
  (let* ((ti-rect (pop-up-menu-title-rect menu))
         (ti-width (- (rref ti-rect rect.right) (rref ti-rect rect.left))))
    (- (point-h (view-size menu)) ti-width)))

(defmethod menu-body-width ((menu typein-menu-menu))
  (let* ((ti-rect (pop-up-menu-title-rect menu))
         (ti-width (- (rref ti-rect rect.right) (rref ti-rect rect.left))))
    (- (point-h (view-size (view-container menu))) ti-width)))


;--------
; Adjusted menu-item title

(defmethod adjusted-menu-item-title ((menu pop-up-menu))
  ; gag
  (let ((items (menu-items menu)))
    (when  items
      (multiple-value-bind (ff ms) (view-font-codes menu)
        ;(setq ff (logand ff #xffff0000))
        (let* ((w (nth-value 2 (font-codes-info ff ms)))
               (max (+ w 12 (max-menu-width menu)))
               (width (menu-body-width menu)))
          ;(print (list max width))
          (when (< max width)
            (setq max (+ w 13 (font-codes-string-width (menu-item-title (car items)) ff ms)))
            (let* ((ss (font-codes-string-width " " ff ms))
                   (first (car items)))           
              (%str-cat (menu-item-title first)
                        (make-array (ceiling (- width max) ss)
                                    :element-type 'base-character
                                    :initial-element #\space)))))))))

(defmethod adjusted-menu-item-title ((menu pull-down-menu))
  (declare (ignore menu)))

(defmethod adjusted-menu-item-title ((menu typein-menu-menu))
  (case (typein-menu-menu-position (view-container menu))
    (:right nil)
    (t (call-next-method))))

;-------


(provide 'pop-up-menu)


#|
;------------------------------------------
;;
;; Test code
;;


(progn

; a "menubar" in a dialog
(defclass my-menubar (inspector::bottom-line-mixin theme-background-view) ())

(defmethod view-default-size ((view my-menubar))
  (let ((container (view-container view)))        
    (when container       
      (make-point (point-h (view-size container))
                  (+ (view-font-line-height view) 4)))))

(defmethod install-view-in-window ((view my-menubar) w)
  (declare (ignore w))
  (multiple-value-bind (ff ms)(view-font-codes view)
    (let ((container (view-container view)))
      (when ff
        (do-subviews (sub view)
          (set-view-font-codes sub ff ms)))
      ; sets slots
      (set-default-size-and-position view container)
      (call-next-method)
      ;; don't know default sizes/sizes till all installed
      (let ((hpos 0))
        (do-subviews (sub view)
          (set-view-position sub hpos (point-v (view-position sub)))
          (incf hpos (point-h (view-size sub)))))
      (invalidate-view view))))

(defvar pop-up)
(defvar pop-up-2)
(defvar typein-right)
(defvar typein-left)
(defvar pull-down)
(defvar my-dial)
(defvar phoo)

(defun test ()
  (setq pop-up
        (make-instance 'pop-up-menu
          :menu-title "A pop-up-menu"
          :view-font '("geneva" 10 :plain) ;'("Osaka" 10 :SRCOR :PLAIN (:COLOR-INDEX 0))
          :view-position #@(20 25)
          :menu-colors `(:title-background ,*yellow-color*)
          :highlight-title t
          :menu-items
          (list
           ;#+ignore
           (setq phoo
                 (make-instance 'menu
             :menu-title "Phooey"
             ;:menu-font '("geneva" 10 :plain) ;; should inherit from parent pop-up
             :menu-items 
             (list 
              (make-instance 'menu-item
                :menu-item-title "abc")
              (make-instance 'menu
                :menu-title "two"
                :menu-items (list (make-instance 'menu-item :menu-item-title "twotow" :menu-item-action #'(Lambda nil (print 'cow)))))
              (make-instance 'menu-item :menu-item-title "def"))))
           (make-instance 'menu-item
             :menu-item-title "item one"
             :icon (list nil :ICON 131)  ;; wont dtrt for 68K or no appearance manager.
             :icon-type #$kMenuShrinkIconType
             :menu-item-action #'(lambda () (print 1)))
           (make-instance 'menu-item
             :menu-item-colors `(:item-title ,*blue-color*)
             :menu-item-title "item two"
             :icon (list nil :ICON 130)
             :icon-type #$kMenuShrinkIconType  ;; this was funky - maybe always shrink
             :menu-item-action #'(lambda () (print 2)))
           (make-instance 'menu-item
             :menu-item-title "item three"
             :icon (list nil :ICON 129)
             :icon-type #$kMenuShrinkIconType
             :menu-item-action #'(lambda () (print 3)))
           (make-instance 'menu-item
             :menu-item-title "item fourteen"
             :icon (list nil :ICON 128)
             :icon-type #$kMenuShrinkIconType
             :menu-item-action #'(lambda () (print 14))))))

  
  
  
  (setq pop-up-2
        (make-instance 'pop-up-menu
          :item-display (if *use-pop-up-control* :selection "A pop-up-menu")
          :view-position #@(20 55)
          :view-font '("Geneva" 9)
          :menu-items
          (list
           (make-instance 'menu-item
             :menu-item-title "item one"
             :menu-item-action #'(lambda () (print 1)))
           (make-instance 'menu-item
             :menu-item-title "item two"
             :menu-item-action #'(lambda () (print 2)))
           (make-instance 'menu-item
             :menu-item-title "item three"
             :menu-item-action #'(lambda () (print 3)))
           (make-instance 'menu-item
             :menu-item-title "item fourteen"
             :menu-item-action #'(lambda () (print 14))))))
  

  (setq typein-right
        (make-instance 'typein-menu
          :view-position #@(20 80)
          :menu-title "A type-in (right) menu"
          :menu-position :right  ; also try :left
          :menu-items
          (list (make-instance 'typein-menu-item                
                  :menu-item-title "elephant"
                  :menu-item-action #'(lambda (item)(declare (ignore item))(print 'babar)))
                (make-instance 'typein-menu-item                
                  :menu-item-title "peanut soup"
                  :menu-item-action #'(lambda (item)(declare (ignore item))(print 'babar))))))

  (setq typein-left
        (make-instance 'typein-menu
          :menu-title "A type-in (left) menu"
          :view-position #@(20 115)
          :menu-position :left
          :view-font '("geneva" 9)  ; try this
          :menu-items
          (list (make-instance 'typein-menu-item                
                  :menu-item-title "elephant"
                  :menu-item-action #'(lambda (item)(declare (ignore item))(print 'babar)))
                (make-instance 'typein-menu-item                
                  :menu-item-title "peanut soup"
                  :menu-item-action #'(lambda (item)(declare (ignore item))(print 'babar))))))

  (let* ((bar (make-instance 'my-menubar
               :view-font '("Lucida grande" 12 :bold)  ; try this
               ;:back-color *lighter-gray-color*
               :view-subviews
                (list
                 (setq pull-down
                       (make-instance 'pull-down-menu
                         :crescent t
                         :item-display "Commands"
                         :view-position #@(0 0)
                         :menu-items
                         (list (make-instance 'menu-item
                                 :menu-item-title "Eat it"
                                 :menu-item-action #'(lambda ()(print 'yum!)))
                               (make-instance 'menu-item
                                 :menu-item-title "Inspect it"
                                 :menu-item-action #'(lambda ()(print 'hmm!)))
                               (make-instance 'menu-item
                                 :menu-item-title "Send it to Mom"
                                 :menu-item-action #'(lambda ()(print 'mom!))))))
                 (make-instance 'pull-down-menu
                   :item-display "More"
                   ;:view-position #@(85 0)
                   :menu-items
                   (list (make-instance 'menu-item
                           :menu-item-title "Eat more"
                           :menu-item-action #'(lambda ()(print 'yum!)))))))))
  (setq my-dial (make-instance 'dialog   ;:color-p nil
                  :view-size #@(300 210)
                  ;:theme-background t
                  :window-title "Pop-up Menu Test"
                  :view-subviews (list bar pop-up pop-up-2 
                                       typein-right typein-left)))
  ;; why not add a font slot to menu?
  #+ignore
  (multiple-value-bind (ff ms)(view-font-codes pop-up)
    (#_setmenufont (menu-handle phoo) (ash ff -16)(logand ms #xffff)))))



(test)        ;; try me!

#|
(dotimes (i 256)
  ;(remove-view-from-window pop-up-2)
  (setq pop-up-2
        (make-instance 'pop-up-menu
          :item-display (if *use-pop-up-control* :selection "A pop-up-menu")
          :view-position #@(20 55)
          :view-font '("Geneva" 9)
          :menu-items
          (list
           (make-instance 'menu-item
             :menu-item-title "item one"
             :menu-item-action #'(lambda () (print 1)))
           (make-instance 'menu-item
             :menu-item-title "item two"
             :menu-item-action #'(lambda () (print 2)))
           (make-instance 'menu-item
             :menu-item-title "item three"
             :menu-item-action #'(lambda () (print 3)))
           (make-instance 'menu-item
             :menu-item-title "item fourteen"
             :menu-item-action #'(lambda () (print 14))))))
  (set-view-container pop-up-2 my-dial))
|#


)

(setq w (make-instance 'window
          :view-subviews
          (list (make-instance 'view :view-position #@(40 40) :view-size #@(150 100)
                               :view-subviews
                               (list pop-up-2)))))

;; makes menu colors work better when appearance manager
;; but in OS 8.5 and 9 screws up some little dohickey in the menubar
;; don't even think about it if osx-p - doth crash
(when (and (not (osx-p))(appearance-available-p))
  (set-part-color *menubar* :menubar *lighter-gray-color*)  ;; or some such color
  (set-part-color *menubar* :default-menu-background *lighter-gray-color*))
|#


  


#|
	Change History (most recent last):
	1	2/17/93	straz	added to Leibniz
	2	2/17/93	straz	tiny triangles, editable-text inherits font, dialog-item-enable/disable
	3	2/18/93	straz	support icons
	4	3/01/93	straz	fold in Alice's changes
	5	7/16/93	straz	fix view-default-size for typein-menu
|# ;(do not edit past this line!!)
;;;    2   4/06/94  bill         1.8d319
;;;    3   4/28/94  bill         1.8d355
;;;    4   8/16/94  ows          1.9d045
