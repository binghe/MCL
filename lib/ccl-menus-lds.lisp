;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: ccl-menus-lds.lisp,v $
;;  Revision 1.33  2006/02/12 21:55:08  alice
;;  ;; update copyright date in about-dialog
;;
;;  Revision 1.32  2005/03/20 01:31:04  alice
;;  ;; lose *string-compare-script*  and *use-pop-up-control* in preferences dialog. don't specify font for value: pop-up
;;
;;  Revision 1.31  2005/02/18 05:18:57  alice
;;  ;;; vdc of underlined-view uses draw-theme-text-box vs. #_drawthemetextbox
;;
;;  Revision 1.30  2004/11/11 20:00:57  alice
;;  ;; add function disable-or-delete-preferences-menu-item
;;
;;  Revision 1.29  2004/10/11 23:41:45  alice
;;  ;; remove preferences from tools menu if OSX
;;
;;  Revision 1.28  2004/08/04 02:02:02  alice
;;  ;; #+ignore old search-file-dialog, add some folks to credits dialog
;;
;;  Revision 1.27  2004/07/15 20:27:14  alice
;;  ;; window-minimum-size -> view-minimum-size
;;
;;  Revision 1.26  2004/07/14 15:28:50  alice
;;  ; set-view-size of underlined-view does invalidate-view if bigger horizontally
;;
;;  Revision 1.25  2004/07/08 22:20:34  alice
;;  ;; edit-anything-dialog makes the forget-button be the "cancel" button so #\esc does what it always did - Nope - too weird
;;
;;  Revision 1.24  2004/06/18 04:08:27  alice
;;  ;; trace-dialog and prefs-dialog use scrolling-fred-view-with-frame
;;
;;  Revision 1.23  2004/06/06 03:59:44  alice
;;  ;; *preferences-command-key* can be nil
;;
;;  Revision 1.22  2004/06/05 01:10:20  alice
;;  ;; preferences menu stuff
;;
;;  Revision 1.21  2004/05/26 18:27:37  alice
;;  ;; update copyright date in about dialog
;;
;;  Revision 1.20  2004/05/06 21:59:16  alice
;;  ;; edit-anything-dialog uses scrolling-fred-view-with-frame
;;
;;  Revision 1.19  2004/05/03 19:42:24  alice
;;  ;; theme-background-p (view-window view) -> theme-background-p view
;;
;;  Revision 1.18  2004/04/26 04:35:44  alice
;;  ;; v-d-c for underlined-view fix for theme-state being backwards on osx
;;
;;  Revision 1.17  2004/03/28 20:03:54  svspire
;;  v-d-c for ((item underlined-view)) calls theme-background-p so trace dialog works
;;
;;  Revision 1.16  2004/03/07 23:07:12  alice
;;  ;; update-recent-files - use string-equal vs string= so won't barf if encoded string
;;
;;  Revision 1.15  2004/03/01 00:07:00  alice
;;  ;theme-background stuff
;;
;;  Revision 1.14  2004/02/23 04:23:33  svspire
;;  'Open Recent' menu item per OSX Human Interface guidelines. Somebody asked for this.
;;
;;  Revision 1.13  2004/01/29 04:22:40  alice
;;  ;; Damn the patch was wrong - revert
;;
;;  Revision 1.12  2004/01/28 22:07:35  alice
;;  ;; forget-action-function - we lost a patch
;;
;;  Revision 1.11  2003/12/29 03:38:37  gtbyers
;;  Use UNCANONICALIZE-SPECIALIZER
;;
;;  Revision 1.10  2003/12/08 08:02:46  gtbyers
;;  Use %REMOVE-STANDARD-METHOD-FROM-CONTAINING-GF instead of %REMOVE-METHOD.
;;
;;  2 4/1/97   akh  see below
;;  12 7/26/96 akh  get-spec-from-dialog - no error if specs/qual do not exist
;;  11 7/18/96 akh  trace dialog gets step pop-up
;;  10 6/7/96  akh  put back some save-application-dialog stuff
;;  9 4/24/96  slh  updated Credits dialog
;;  8 4/24/96  akh  1996 in about box
;;  7 4/17/96  akh  load-preferences-file - bind *package* so no lose it
;;  2 10/17/95 akh  merge patches
;;  21 5/17/95 akh  window-show nil in search files
;;  20 5/8/95  akh  fix package defaulting in edit-anything dialog
;;  18 5/7/95  slh  balloon help mods.
;;  16 5/4/95  akh  environment-dialog - put back some older stuff so menu and table stay in sync.
;;  14 4/26/95 akh  dont remember
;;  12 4/24/95 akh  add a get info button to get info, make package selection do the deed. 
;;                  Print X in margin for defs that dont exist any longer.
;;  8 4/12/95  akh  env-edit-action uses filter-table-sequence
;;  6 4/7/95   akh  enable and disable the forget button in get-info, default to inspect if thing isnt a symbol
;;  5 4/6/95   akh  apropos-dialog and edit-anything use *package* if no fred-window
;;  4 4/4/95   akh  so does apropos-dialog
;;  3 4/4/95   akh  edit-anything-dialog gets package from front window
;;  2 4/4/95   akh  add a "forget it" button to get info - remove method or fmakunbound
;;  (do not edit before this line!!)


; ccl-menus-lds.lisp
; Copyright 1995-2004 Digitool, Inc.

(in-package :ccl)

; Modification History
;; preferences handles popups whose menu-item "values" aint symbols
;; recent-files menu shows name without escapes
;; say :center vs #$tejustcenter
;; add *preferred-eol-character* to preferences, use y-or-n-dialog vs message-dialog
;; -------- 5.2b5
;; vdc of underlined-view passes active-p to draw-theme-text-box, class underlined-view gets text-color slot
;; update-env-table - double-click kludge
;; ------- 5.2b4
;; edit-anything-dialog - make sure the insertion font is OK - don't know why it sometimes wasn't
;; update copyright date in about-dialog
;; ------ 5.2b1
;; lose *string-compare-script*  and *use-pop-up-control* in preferences dialog. don't specify font for value: pop-up
;; vdc of underlined-view uses draw-theme-text-box vs. #_drawthemetextbox
;; -------- 5.1 final
;; add function disable-or-delete-preferences-menu-item
;; ------- 5.1b4
;; remove preferences from tools menu if OSX
;; -------- 5.1b3
;; #+ignore old search-file-dialog, add some folks to credits dialog
;; window-minimum-size -> view-minimum-size
;; set-view-size of underlined-view does invalidate-view if bigger horizontally
;; edit-anything-dialog makes the forget-button be the "cancel" button so #\esc does what it always did - Nope - too weird
;; trace-dialog and prefs-dialog use scrolling-fred-view-with-frame
;; *preferences-command-key* can be nil
;; preferences menu stuff
;; edit-anything-dialog ignores errors around window-package
;; update copyright date in about dialog
;; --------- 5.1b2
;; edit-anything-dialog uses scrolling-fred-view-with-frame
;; theme-background-p (view-window view) -> theme-background-p view
;; v-d-c for underlined-view fix for theme-state being backwards on osx
;; v-d-c for ((item underlined-view)) calls theme-background-p so trace dialog works
;; update-recent-files - use string-equal vs string= so won't barf if encoded string 
;; 'Open Recent' menu item
;; oh damn the patch was wrong!
;; forget-action-function - we lost a patch
;; ------- 5.1b1
;; 12/03/03 *string-compare-script* can be nil
;; kludge in edit-anything-dialog and trace-dialog to make specializers 1 pixel bigger vertically - why?? - nah fix it in vertical-labeled-items
;; more underlined-view from Terje N.
; 11/21/03 view-draw-contents of underlined-view from Terje N.
; 10/28/03 theme doesn't require osx-p
; fix get info dialog when making a method undefined - from patches 5.0
; about-dialog says 2003, lose cancel button in credits dialog
; --------- 5.0b6
; add a few to preferences dialog but they don't have documentation!
; ------- 5.0b3
; preferences dialog gets theme background
; trace-dialog gets theme-background, underlined-view tweaked for theme-background
; ---------- 4.4b3
; lose view-font "chicago" - let it default
; more osx crap re button size
; ----------- 4.4b2
; 05/22/01 akh some osx crap re button sizes and positions
; akh alphbetical thanks to: in about dialog
; ---------
; 08/22/99 akh add some *fasl-save.. to environment-dialog
; ------- 4.3f1c1
; 06/02/99 akh do-anything - #' gets the function
; ----------- 4.3.b2
; 07/07/98 akh  edit-anything and trace dialogs pull package if any out of selected string if any
; 02/28/98 akh   do-anything tries to find the "thing" in some package when all-packages requested
; 05/07/97 bill  Specify true value of :table-vscrollp for arrow-dialog-item instances
; -------------  4.1
; 04/02/97 bill  1996->1997 in application-about-dialog
; ------------   4.1b1
; 03/21/97 akh   add *inspector-disassembly* to preferences
; 10/11/96 bill  load-preferences-file preserves *compile-definitions* if (compiler-excised-p) is true.
; -------------  4.0f1
;  9/23/96 slh   new prefs vars: *autoclose-inactive-listeners* *always-eval-user-defvars*
; 09/10/96 bill  (method get-env-value (prefs-dialog)) won't try to funcall NIL, even if it's fbound.
; -------------  4.0b1
; 08/12/96 bill  filter-table-sequence invalidates the table unless all the elements are the same.
;                This makes it work with the new set-table-sequence, which invalidates
;                less than it used to.
; akh get-spec-from-dialog - no error if specs/qual do not exist
; akh trace-dialog defaults package whether or not selection
; 04/17/96  alice let *package* in load-preferences-file
;  04/06/96 bill add a "Credits" button to the about box.
;  03/05/96 bill load-preferences-file, env-file-path uses #$kOnSystemDisk instead of
;                0 for the vrefnum arg to findfolder.
;  01/05/96 bill search-file-dialog uses eval-enqueue instead of process-run-function
;                if *single-process-p* is true.
;  12/20/95 bill no *pascal-full-longs* for the PPC
;  6/09/95 slh   flashy about box here
;  6/06/95 slh   help specs
;  5/3/95  akh   make preferences dialog work again
;  4/18/95 slh   fix error when saving prefs if no prefs file exists
;  4/11/95 slh   add-preference-var/s sets initial value (for modules prefs)
;  4/21/95 akh   add get-info button to get info dialog, add X for methods/functions that are no 
;                longer defined. Modify set-view-size for new buttons.
;  4/14/95 akh   fiddle with size & position so environment dialog fits and doesnt show partial line
;  4/06/95 slh   Split environment-dialog class into env-dialog, prefs-dialog


(eval-when (:compile-toplevel :execute)
  (require "DIALOG-MACROS")
  (require "RESOURCES"))


(defclass mcl-about-dialog (dialog)
  ((pict-hdl :initarg :pict-hdl :initform nil :reader pict-hdl)
   (icon-positions :initarg :icon-positions :initform nil)
   (icon-size :initarg :icon-size :initform #@(48 48))))

(defmethod view-draw-contents :before ((dlg mcl-about-dialog))
  (let ((pict-hdl (slot-value dlg 'pict-hdl)))
    (when pict-hdl
      (rlet ((rect :rect
                   :topleft #@(10 34)
                   :bottomright #@(329 348)))
        (#_DrawPicture pict-hdl rect)))))

(defmethod view-draw-contents :after ((dlg mcl-about-dialog))
  (dolist (icon-position (slot-value dlg 'icon-positions))
    (rlet ((rect :rect
                 :topleft icon-position
                 :botright (add-points icon-position (slot-value dlg 'icon-size))))
      (#_PlotIconID rect 0 0 128))))

(defmethod window-close :after ((dlg mcl-about-dialog))
  (dispose-pict-hdl dlg))

(defmethod dispose-pict-hdl ((dlg mcl-about-dialog))
  (let ((pict-hdl (slot-value dlg 'pict-hdl)))
    (when pict-hdl
      (#_DisposeHandle pict-hdl)
      (setf (slot-value dlg 'pict-hdl) nil))))

(defmethod application-about-dialog ((app lisp-development-system))
  (let* ((pict-hdl (ignore-errors
                    (with-open-resource-file (refnum "ccl:Library;MCL Background.rsrc"
                                                     :if-does-not-exist nil)
                      (let ((pict-hdl (#_Get1Resource :|PICT| 128)))
                        (unless (or (%null-ptr-p pict-hdl)
                                    (%null-ptr-p (%get-ptr pict-hdl)))
                          (#_DetachResource pict-hdl)
                          pict-hdl)))))
         (height (if pict-hdl 410 100)))
    (make-instance 'mcl-about-dialog
      :auto-position :centermainscreen
      :view-size (make-point 340 height)
      :window-type :double-edge-box
      :window-show nil
      :pict-hdl pict-hdl
      :view-subviews
      (list
       (make-dialog-item 'default-button-dialog-item
                         (make-point 240 (- height 26))
                         #@(70 18)
                         "OK"
                         #'(lambda (item)
                             (declare (ignore item))
                             (return-from-modal-dialog t)))
       (make-dialog-item 'button-dialog-item
                         (make-point 240 (- height 54))
                         #@(70 18)
                         "Credits"
                         #'(lambda (item)
                             (let ((w (view-window item)))
                               (window-hide w)
                               (dolist (view (subviews w))
                                 (set-view-container view nil))
                               (dispose-pict-hdl w)
                               (do-mcl-credits-dialog w))))
       (make-dialog-item 'static-text-dialog-item
                         #@(5 0)
                         #@(310 28)
                         (format nil "~a~%~a"
                                 (lisp-implementation-type)
                                 (lisp-implementation-version))
                         nil
                         :view-font '("geneva" 12 :bold)
                         :text-justification :center) ;#$teJustCenter)
       (make-dialog-item 'static-text-dialog-item
                         (make-point 9 (- height 48))
                         #@(220 38)
                         "Copyright © 1995-2007 Digitool, Inc.
Copyright © 1989-1994 Apple Computer, Inc.
Copyright © 1985-1988 Coral Software Corp."
                         nil
                         :text-justification :center
                         :view-font '("geneva" 9))))))

(defun do-mcl-credits-dialog (&optional (w (make-instance 'mcl-about-dialog
                                             :auto-position :centermainscreen
                                             :window-type :double-edge-box
                                             :window-show nil)
                                           w-p))
  (setf (slot-value w 'icon-positions) `(#@(40 67) #@(249 67)))
  (set-view-size w #@(340 270))
  (make-dialog-item 'static-text-dialog-item
                    #@(45 10)
                    #@(250 80)
                    "Written at Digitool, Inc. by:

Gary Byers, Steve Hain, Alice Hartley, and Bill St. Clair."
                    nil
                    :text-justification :center ;#$teJustCenter
                    :view-font '("geneva" 12)
                    :view-container w)
  (make-dialog-item 'static-text-dialog-item
                    #@(45 100)
                    #@(252 120)
                    "Special thanks to:

Apple Computer, Takehiko Abe, Toomas Altosaar, Sheldon Ball, Bill Cheng, Peter Christy, Doug Currie, Russ Daniels, Byron Davies, Marc Domenig, David Lamkins, Terje Norderhaug, Alexander Repenning, Alan Ruttenberg, Carl Schwarcz, Andrew Shalit, Shannon Spires, Jim Spohrer, Steve Strassmann, Kent Wittenburg, Dave Yost, and all of our testers and supporters worldwide."
                    nil
                    :text-justification :center ;#$teJustCenter
                    :view-font '("geneva" 9)
                    :view-container w)
  (make-dialog-item 'default-button-dialog-item
                    #@(190 230)         ; middle: #@(135 xxx)
                    #@(70 18)
                    "OK"
                    #'(lambda (item)
                        (declare (ignore item))
                        (return-from-modal-dialog t))
                    :view-container w)
  #+ignore
  (make-dialog-item 'button-dialog-item
                    #@(80 230)
                    #@(70 18)
                    "Cancel"
                    nil
                    :view-container w
                    :dialog-item-enabled-p nil)
  (if w-p
    (window-show w)
    (modal-dialog w)))


; define the stuff for the open-selected-file menu item

(defvar %last-open-sel-string nil)

(defun open-selected-file-menu-item-update (item)
  (let ((w (front-window))
        (sel-string %last-open-sel-string))
    (if (and w
             (method-exists-p 'open-file-item-title w)
             (setq sel-string (open-file-item-title w sel-string))
             ;(open-selected-file-test)  ; way too slow sometimes - when?
             )
      (progn 
        (when (eq sel-string %last-open-sel-string)
          (return-from open-selected-file-menu-item-update))
        (setq %last-open-sel-string sel-string)
        (set-menu-item-title item (%str-cat "Open " sel-string))
        (menu-item-enable item))
      (progn
        (set-menu-item-title item "Open Selection")
        (setq %last-open-sel-string nil)
        (menu-item-disable item)))))

; 'open recent' menu item

(defvar *recent-files* nil "List of pathnames recently edited. Latest at beginning of list.")
(defparameter *max-recent-files* 20 "Maximum number of files in the 'Open Recent' menu.
                                     nil for none. T for unlimited.")

(defun update-recent-files (&key filename &allow-other-keys)
  (when (and filename *max-recent-files*) ; nil for none
    (when (numberp *max-recent-files*) ; t for unlimited
      (if (> (length *recent-files*) *max-recent-files*)
        (setf *recent-files* (subseq *recent-files* 0 *max-recent-files*))))
    (setf *recent-files* (remove (namestring filename) *recent-files* :test #'string-equal :key #'namestring))
    ; move it to the front of the list
    (push filename *recent-files*)))

(defun open-recent-menu-update (menu)
  (apply #'remove-menu-items menu (menu-items menu))
  (dolist (path *recent-files*)
    (add-new-item menu
                  (mac-file-namestring-1 path)
                  (let ((internal-path path))
                    #'(lambda ()
                        (if (probe-file internal-path) ; these will never be aliases because
                          ;  they get resolved before being put into *recent-files*?
                          (ed internal-path)
                          (progn
                            (ed-beep)
                            ;;(format t "~%Cannot find file ~S" internal-path)
                            ))))))
  (add-new-item menu "-")
  (let ((clear-item (add-new-item menu "Clear Menu" #'(lambda () (setf *recent-files* nil))
                                  :enabledp *recent-files* ; broken
                                  )))
    (if *recent-files*
      (menu-item-enable clear-item)
      (menu-item-disable clear-item)
      )))

(defmethod open-file-item-title ((w window) last-sel-string)
  (let ((key (current-key-handler w)))
    (when (and key (method-exists-p 'open-file-item-title key))
      (open-file-item-title key last-sel-string))))

(defmethod open-file-item-file ((w window))
  (let ((key (current-key-handler w)))
    (when (and key (method-exists-p 'open-file-item-file key))
      (Open-file-item-file key))))


; perhaps its silly to remember the string across closings of the window
;(defparameter %edit-anything-string "")

(defvar *edit-anything-dialog* nil)
(defvar *ead-fred-dialog-item* nil)
(defvar *ead-table-dialog-item* nil)
(defvar *ead-fred-dialog-position* nil)
(defvar *ead-what* :definition)
(defparameter *ead-size&position* (cons #@(350 296) '(:top 50)))

;;;;;;;;;;;;;;;;;
;; underlined-view

(defclass underlined-view (simple-view)
  ((dialog-item-text :initarg :dialog-item-text :accessor dialog-item-text)
   (text-color :initarg :text-color :initform nil :Accessor text-color)))


#|
(defmethod view-draw-contents ((item underlined-view))  
  (let* ((size (subtract-points (view-size item) #@(1 1)))   ; allow for descenders not to smash into line
         (topleft (view-position item))
         (bottomright (add-points topleft size))
         (bottomleft (add-points topleft (make-point 0 (point-v size))))
         (color-p (color-or-gray-p (view-window item))))
    (multiple-value-bind (ff ms)(view-font-codes item)
      (let ((ascent (font-codes-info ff ms)))
        (with-font-codes ff ms
          (with-back-color (if (and #|(osx-p)|# (view-get (view-window item) 'theme-background)) *white-color* nil)
            (with-pstrs ((p-title (dialog-item-text item)))      
              (#_MoveTo (point-h topleft)
               (+ (point-v topleft) ascent 1))
              (#_Drawstring :ptr p-title)
              (#_MoveTo :long bottomleft))
            (if color-p
              (with-fore-color *tool-line-color*      
                (#_LineTo :long bottomright))
              (#_lineto :long bottomright))
            (#_MoveTo :long (subtract-points bottomleft #@(0 1)))
            (with-fore-color (if color-p *white-color* *black-color*)
              (#_LineTo :long (subtract-points bottomright #@(0 1))))))))))
|#
;; from Terje N.
(defmethod view-draw-contents ((item underlined-view))
  (let* ((size (subtract-points (view-size item) #@(1 1)))   ; allow for descenders not to smash into line
         (topleft (view-position item))
         (bottomright (add-points topleft size))
         (bottomleft (add-points topleft (make-point 0 (point-v size))))
         (active-p (window-active-p (view-window item)))
         (theme-state (if active-p #$kThemeStateActive #$kThemeStateInactive))
         (fore-color  (text-color item)))
    (with-fore-color fore-color
      (multiple-value-bind (ff ms)(view-font-codes item)
        (with-font-codes ff ms        
          (rlet ((rect :rect :topleft (add-points topleft #@(0 1)) :bottomright bottomright))
            ;(if (osx-p)(#_eraserect rect))  ;; <<<< else sometimes looks like drawn twice in sligtly different positions
            #+ignore
            (draw-string-in-rect (dialog-item-text item) rect :ff ff :ms ms :color (if (not active-p) *gray-color* fore-color))
            #-ignore
            (draw-theme-text-box (dialog-item-text item) rect :left nil active-p)
            )
          (rlet ((rect :rect :topleft (subtract-points bottomleft #@(0 2)) :bottomright bottomright))
            (#_DrawThemeSeparator rect 
             (if nil ;(not (osx-p))
               theme-state
               ;; osx seems to get states backwards
               (if (eq theme-state #$kthemestateactive) 
                 #$kThemeStateInactive
                 #$kthemestateactive))))))))) 

(defmethod set-view-size ((view underlined-view) h &optional v)
  (declare (ignore h v))
  (let ((old-size (view-size view)))
    (call-next-method)    
    (when  (> (point-h (view-size view))(point-h old-size))
      (invalidate-view view )))
    )

;; more from Terje N. - well it does change but seem backwards to me
(defmethod view-activate-event-handler :before ((item underlined-view))
   (invalidate-view item t))

(defmethod view-deactivate-event-handler :before ((item underlined-view))
  (invalidate-view item t))



(defclass edit-anything-dialog (dialog)
  ((last-thing :initform nil :accessor last-function-name)
   ;(last-package :initform nil :accessor last-package)
   ))


(defmethod set-view-size ((view edit-anything-dialog) h &optional v)
  (let* ((old-size (view-size view))
         (new-size (make-point h v))
         (delta (subtract-points new-size old-size))
         (h-delta (make-point (point-h delta) 0)))
    (call-next-method)
    (let ((v1 *ead-fred-dialog-item*)
          (v2 *ead-table-dialog-item*)
          (v3 (view-named 'search-text-item view))
          (v4 (view-named 'specializers view))
          (b1 (view-named 'forget-button view))
          (b2 (view-named 'get-button view)))
      (set-view-size v1 (add-points (view-size v1) delta))
      (set-view-size v2 (add-points (view-size v2) delta))
      (set-view-size v3  (add-points (view-size v3) h-delta))
      (set-view-size v4  (add-points (view-size v4) h-delta))
      (set-view-position b1 (- (point-h new-size) 215)(- (point-v new-size) 30))
      (set-view-position b2 (- (point-h new-size) 325)(- (point-v new-size) 30))      
      (set-view-position (default-button view) (- (point-h new-size) (if (osx-p) 90 85)) (- (point-v new-size) 30)))))


(defmethod window-close :before ((w edit-anything-dialog))
  (rplaca *ead-size&position* (view-size w))
  (rplacd *ead-size&position* (view-position w))
  (setq *edit-anything-dialog* nil)
  (setq *ead-fred-dialog-item* nil)
  (setq *ead-table-dialog-item* nil))


(defun make-qualifier-items ()
  (make-menu-items '("None" ":Before" ":After" ":Around")))

(defmethod view-minimum-size ((window edit-anything-dialog))
  #@(260 241))

(defun edit-anything-dialog (&optional what initial-string pkg)
  (let* ((w (front-window))
         (dialog *edit-anything-dialog*))
    (when (not initial-string)
      (when w
        (let ((key (window-key-handler w)))
          (when (and key (typep key 'fred-mixin))
            (multiple-value-bind (b e)(selection-range key)
              (when (neq b e)
                (multiple-value-setq (pkg initial-string)
                  (string-package-and-tail (buffer-substring (fred-buffer key) b e)))))))))
    (when (not pkg)
      (cond ((and w (typep w 'fred-window)             
                  (let ((p (ignore-errors (window-package w))))
                    (when (typep p 'package)
                      (setq pkg p)))))
            (t (setq pkg *package*))))
    (when (not (and dialog (wptr dialog)))
      (let ((size #@(350 296))
            ;(vpos 10)
            (lmargin 6)
            ;(delta 31)
            ;(col2 95)
            next-y)
        (setq dialog
              (make-instance 
                'edit-anything-dialog
                :view-position (cdr *ead-size&position*)
                :view-size size
                :close-box-p t
                :window-type :document-with-grow ; with-grow?
                :window-title "Get Info"
                :window-show nil
                :back-color *tool-back-color*
                :theme-background t
                :help-spec 15030
                ;:allow-empty-strings '(specializers)
                :view-subviews
                (vertical-labeled-items 
                 :dialog-width 350 :col2 95 :delta 29 :lmargin 6 :vpos 10 :lastvar next-y
                 :items
                 (("Name:" editable-text-dialog-item search-text-item nil
                   :help-spec 15031)
                  ("Specializers:" typein-menu specializers nil
                   :menu-position :left ;:right-pop-text
                   :menu-class 'spec-typein-menu
                   :help-spec 15032)
                  ("Qualifier:" pop-up-menu qualifier 160
                   :menu-items (make-qualifier-items)
                   :help-spec 15033)
                  ("Package:" pop-up-menu package 160 
                   :menu-items (make-package-items t)
                   :help-spec 15034)
                  ("Show:" pop-up-menu what 160
                   :help-spec 15035
                   :menu-items
                   (make-menu-items
                    `(("Definition(s)"
                       ,#'(lambda ()
                            (do-anything :definition)))
                      ("Applicable Methods"
                       ,#'(lambda ()
                            (do-anything :applicable-methods)))
                      ("Callers"
                       ,#'(lambda ()
                            (do-anything :callers)))
                      ("Documentation"
                       ,#'(lambda ()
                            (do-anything :documentation)))
                      ("Inspector"
                       ,#'(lambda ()
                            (do-anything :inspect))))))))))
        (add-subviews dialog
                      (make-dialog-item 'default-button-dialog-item
                                        (make-point (- (point-h size) (if (osx-p) 90 85)) (- (point-v size) 35))
                                        (if (osx-p) #@(74 20) #@(62 20))
                                        "Find Def"
                                        #'callers-action-function
                                        :dialog-item-enabled-p nil
                                        :help-spec 15039)
                      (make-dialog-item 'button-dialog-item
                                        (make-point (- (point-h size) 215) (- (point-v size) 31))
                                        (if (osx-p) #@(96 20) #@(86 20))
                                        "Remove Def"
                                        'forget-action-function
                                        ;:cancel-button t  ;; bizarre
                                        :view-nick-name 'forget-button 
                                        :dialog-item-enabled-p nil
                                        :help-spec 15038)
                      (make-dialog-item 'button-dialog-item
                                        (make-point (- (point-h size) 325) (- (point-v size) 31))
                                        #@(76 20)
                                        "Get Info"
                                        #'do-anything-from-item
                                        ; its always enabled - no hook with editable text - tant pis
                                        :view-nick-name 'get-button
                                        :dialog-item-enabled-p t
                                        :help-spec 15037)                      
                      (setq *ead-fred-dialog-item*
                            (make-dialog-item 'scrolling-fred-view-with-frame
                                              (setq *ead-fred-dialog-position*
                                                    (make-point lmargin (- next-y 4)))
                                              (make-point (+ -6 (- (point-h size) lmargin)) 100)
                                              nil ; or ""
                                              nil
                                              :wrap-p t
                                              :allow-tabs nil
                                              :buffer-chunk-size 128
                                              :h-scrollp nil
                                              :view-nick-name 'result
                                              :help-spec 15036)))
        (setq *edit-anything-dialog* dialog)
        (setq *ead-table-dialog-item*
              (make-dialog-item 'arrow-dialog-item
                                #@(-3000 -3000)
                                (make-point (+ -10 (- (point-h size) lmargin)) 100)
                                nil ; or ""
                                nil
                                :table-sequence nil
                                :view-container dialog 
                                :table-print-function #'edit-callers-print
                                :view-font '("monaco" 9)
                                :table-vscrollp t
                                ;:table-hscrollp nil
                                ))
        (set-view-size dialog (car *ead-size&position*))
        (install-fred-item *ead-table-dialog-item*)))
    #+ignore
    (let ((spec (view-named 'specializers dialog)))
      (set-view-size spec (point-h (view-size spec))(1+ (point-v (view-size spec)))))
    (let* ((di (view-named 'search-text-item dialog))
           (pkg-menu (view-named 'package dialog))
           (what-menu (view-named 'what dialog))
           (fn #'(lambda ()(do-anything-from-what-menu what-menu))))
      (when pkg (set-default-package-item pkg-menu pkg))
      (dolist (item (menu-items pkg-menu))
        (set-menu-item-action-function item fn))
      (when di
        (set-current-key-handler dialog di)         
        (when initial-string 
          ;; ahh it's select-all that clobbers insert-font-index
          (multiple-value-bind (ff ms)(sys-font-codes)  ;; or (view-font-codes (view-window di))
            (let ((buf (fred-buffer di)))
              (set-buffer-insert-font-codes buf ff ms)
              ;(push (list initial-string ff ms) cow) 
              ;(set-dialog-item-text di initial-string)  ;; doesn't get the font right sometimes
              (buffer-delete buf 0)
              (buffer-insert buf initial-string)
              (nuke-anything-result dialog)))
          (when (not (symbolp (thing-name-from-dialog dialog)))
            (setq what :inspect))
          (select-all di)))
      (when what ; may never be true this week
        (let ((what-di (view-named 'what dialog)))
          (set-pop-up-menu-default-item what-di
                                        (1+ (position what '(:definition :applicable-methods :callers :documentation :inspect)))) 
          (let* ((spec (view-named 'specializers dialog))
                 (qual (view-named 'qualifier dialog)))
            (if (memq what '(:callers :documentation))
              (progn (menu-disable qual)(menu-disable spec))
              (progn (menu-enable qual)(menu-enable spec))))))
      (window-select dialog))))

(defun callers-action-function (x)
  (declare (ignore x))
  (let ((thing (selected-cell-contents *ead-table-dialog-item*)))
    (with-event-processing-enabled
      (if (option-key-p) (window-close *edit-anything-dialog*))
      (edit-definition-spec thing))))

#|
(defun forget-action-function (x)
  (declare (ignore x))
  (let* ((cell (first-selected-cell *ead-table-dialog-item*))
         (thing (cell-contents *ead-table-dialog-item* cell)))
    (with-event-processing-enabled
      (if (option-key-p) (window-close *edit-anything-dialog*))
      (let ((def (car thing)))
        (if (typep def 'method)
          (%remove-standard-method-from-containing-gf def)
          (when (eq def 'function)            
            (fmakunbound (thing-name-from-dialog *edit-anything-dialog*))))
        (redraw-cell *ead-table-dialog-item* cell)))))
|#

; also check for symbolp from slh
(defun forget-action-function (x)
  (declare (ignore x))
  (let* ((cell (first-selected-cell *ead-table-dialog-item*)))
    (if (not cell)
      nil
      (let  ((thing (cell-contents *ead-table-dialog-item* cell)))
        (with-event-processing-enabled
          (if (option-key-p) (window-close *edit-anything-dialog*))
          (if (symbolp thing)
            (fmakunbound thing)
            (let ((def (car thing)))
              (if (typep def 'method)
                (%remove-standard-method-from-containing-gf def)
                (when (eq def 'function)            
                  (fmakunbound (thing-name-from-dialog *edit-anything-dialog*))))))
          (cell-deselect *ead-table-dialog-item* cell)
          (redraw-cell *ead-table-dialog-item* cell))))))

#|
; well what we really should do is show stuff for which we have source file info
; but which is now undefined differently
(defun forget-action-function (x)
  (declare (ignore x))
  (let* ((thing (selected-cell-contents *ead-table-dialog-item*))
         rem)
    (with-event-processing-enabled
      (let ((def (car thing)))
        (if (typep def 'method)
          (progn (%remove-standard-method-from-containing-gf def)(setq rem t))
          (when (eq def 'function)            
            (fmakunbound (thing-name-from-dialog *edit-anything-dialog*))
            (setq rem t))))
      (when rem (set-table-sequence *ead-table-dialog-item*
                                    (delq thing (table-sequence *ead-table-dialog-item*))))
      (if (option-key-p) (window-close *edit-anything-dialog*)))))
|#

; what?
(defun definitions-action-function (x)
  (declare (ignore x))
  (let ((pair (selected-cell-contents *ead-table-dialog-item*))
        (name (thing-name-from-dialog *edit-anything-dialog*)))
    (when (option-key-p)
      (window-close *edit-anything-dialog*))
    (if (cdr pair) ; no source file info - gets dialog re search fred windows?
      (edit-definition-2 pair name)
      (edit-definition-spec (car pair)))))


(defvar *direct-methods-only* nil)
(defvar *current-package-only* nil)

(defun do-anything-from-item (item)
  (let ((what (view-named 'what (view-window item))))
    (menu-item-action (nth (1- (pop-up-menu-default-item what))
                                    (menu-items what)))))

(defun do-anything-from-what-menu (what-menu)
  (menu-item-action (nth (1- (pop-up-menu-default-item what-menu))
                                  (menu-items what-menu))))


(defun do-anything (what)
  (with-event-processing-enabled
    (let* ((dialog *edit-anything-dialog*))
      (with-cursor *watch-cursor*
        (let* ((spec (view-named 'specializers dialog))
               (qual (view-named 'qualifier dialog)))
          (if (memq what '(:callers :documentation))
            (progn (menu-disable qual)(menu-disable spec))
            (progn (menu-enable qual)(menu-enable spec))))
        (when t ;(dialog-item-enabled-p (default-button dialog))
          (let* ((new-string (dialog-item-text (view-named 'search-text-item dialog)))
                 (*current-package-only* (get-default-package-item (view-named 'package dialog)))
                 (*package* (or *current-package-only* *package*))
                 (thing
                  (let ((maybe))
                    (if (not *current-package-only*)
                      (let* ((rcase (readtable-case *readtable*))
                             (rstring (if (eq rcase :upcase)
                                        (string-upcase new-string)
                                        (if (eq rcase :downcase)
                                          (string-downcase new-string)
                                          new-string))))
                        (dolist (p %all-packages%)
                          (let ()
                            (when (setq maybe (find-symbol rstring p))
                              (return))))))
                    (when (not maybe)
                      (setq maybe (ignore-errors (read-from-string new-string nil nil))))
                    maybe)))
            (when (neq what :inspect)(nuke-anything-result dialog))
            (if (not thing)
              (ed-beep)
              (let ((*standard-output* (fred-item *ead-fred-dialog-item*))
                    (table *ead-table-dialog-item*))
                (set-view-font *standard-output* '("monaco" 9 :plain))
                (set-dialog-item-text *standard-output* "")
                (case what
                  ((:definition :applicable-methods)
                   (setq thing (get-spec-from-dialog dialog))
                   (let (defs)                     
                     (multiple-value-bind (type name specializers qualifiers) (parse-definition-spec thing)
                       (declare (ignore type))
                       (cond
                        ((and name (eq what :applicable-methods))
                         (setq defs (find-applicable-methods name specializers (or qualifiers t)))
                         (cond (defs
                                 (when (not specializers)
                                   (setq defs (sort defs #'edit-definition-spec-lessp)))
                                 (setq defs (mapcan #'(lambda (m)
                                                        (or (edit-definition-p m) (list (list m))))
                                                    defs)))                               
                               (t (format t "No applicable methods for ~s~@[ with specializers ~s~]~@[ qualifiers ~s~]."
                                          name specializers (when (neq qualifiers t) qualifiers )))))                                             
                        (t (let ((*direct-methods-only* (neq what :applicable-methods)))
                             (declare (special *direct-methods-only*))
                             (setq defs (edit-definition-spec thing t)))))
                       (if defs
                         (install-table table dialog defs
                                        (make-defs-print-function defs name)
                                        #'definitions-action-function)
                         (install-fred-item table)))))                  
                  (:inspect
                   (let* ((it (selected-cell-contents table)))
                     (if it
                       (inspect (if (consp it)(car it) it))
                       (progn 
                         (setq it (get-spec-from-dialog dialog))
                         (multiple-value-bind (type name specializers qualifiers)(parse-definition-spec it) 
                           (when (eq qualifiers t)(setq qualifiers nil))
                           (if (and name (eq type 'method)
                                    (setq it (find-method-by-names name qualifiers specializers)))
                             (inspect it)
                             (if (eq type 'function)
                               (if (fboundp name)(inspect (fboundp name))(inspect thing))
                               (inspect thing))))))))
                  (:callers
                   (let ((callers (edit-callers thing :return-it t)))
                     (if callers
                       (install-table table dialog callers 
                                      #'edit-callers-print #'callers-action-function)
                       (install-fred-item table))))
                  (t (let ((out *standard-output*))
                       (install-fred-item table)
                       (view-put out :right-margin (- (point-h (view-size out)) 10))
                       (show-documentation thing out))))
                (fred-update *standard-output*)))))))))

(defun install-fred-item (table)
  (set-view-position table #@(-3000 -3000))
  (let* ((w (view-window table))
         (old (when w (current-key-handler w))))
    (remove-key-handler table)
    (let ((new (when w (current-key-handler w))))
      (when (neq old new)(set-selection-range new))))
  (add-key-handler (fred-item *ead-fred-dialog-item*))  
  (set-view-position *ead-fred-dialog-item* *ead-fred-dialog-position*))

(defun install-table (table dialog list print-fn action-fn)
  (setf (table-print-function table) print-fn)
  (set-dialog-item-action-function (default-button dialog) action-fn)
  (set-table-sequence table list)
  (set-view-position *ead-fred-dialog-item* #@(-3000 -3000))
  (set-view-position table (add-points *ead-fred-dialog-position* #@(2 0)))
  (remove-key-handler (fred-item *ead-fred-dialog-item*))
  (add-key-handler table)  
  (cell-select table #@(0 0))
  (set-current-key-handler dialog table)
  (dialog-item-enable (default-button dialog))
  (dialog-item-enable (view-named 'forget-button dialog))) 
  

(defmethod view-key-event-handler ((w edit-anything-dialog) ch)  
  (let* ((name (view-named 'search-text-item w))
         (what (view-named 'what w)))
    (if (eq name (current-key-handler w))
      (if (and (or (eq ch #\return)(eq ch #\enter))(not (dialog-item-enabled-p (default-button w))))       
        (funcall (menu-item-action-function (nth (1- (pop-up-menu-default-item what))
                                                 (menu-items what))))
        (progn
          (when (not (or (eq ch #\tab)(eq ch #\return)(eq ch #\enter)))(nuke-anything-result w))
          (call-next-method)))      
      (call-next-method))))

; kind of a misnomer - makes cut etal nuke result
(defmethod update-default-button ((view edit-anything-dialog))
  (when (eq (current-key-handler view)(view-named 'search-text-item view))
    (nuke-anything-result view)))

; we now don't nuke when messing with specializers
(defun nuke-anything-result (view)
  (let ((s (find-subview-of-type view 'table-dialog-item)))
    (when s
      (when (table-sequence s)
        (setf (table-sequence s) nil))
      (dialog-item-disable (default-button view))
      (dialog-item-disable (view-named 'forget-button view)))
    (setq s (find-subview-of-type view 'scrolling-fred-view))
    (when s 
      (let ((buf (fred-buffer (fred-item s))))
        (buffer-delete buf 0 (buffer-size buf))
        (fred-update s)))))
  
#| Defined in l1-menus
(defun make-menu-item (title &optional action &rest stuff)
  (declare (dynamic-extent stuff))
  (apply #'make-instance 'menu-item :menu-item-title title :menu-item-action action stuff))
|#

(defun make-menu-items (titles)
  (mapcar #'(lambda (n)
              (let (rest)
                (when (consp n)
                  (setq rest (cdr n)
                        n    (car n)))
                (apply #'make-menu-item (if (symbolp n)
                                          (string-capitalize (symbol-name n))
                                          n)
                       rest)))
          titles))


; make this guy an extension - I think its silly - well maybe not

(defclass trace-dialog (string-dialog) 
  ((last-thing :initform nil :accessor last-function-name)
   ;(last-package :initform nil :accessor last-package)
   ))

(defmethod view-minimum-size ((window trace-dialog))
  #@(270 280))

;(defparameter *trace-dialog* nil)
(defparameter *trace-dialog-size&position* (cons #@(360 356) '(:top 50))) ; was 336

(defmethod window-close :before ((w trace-dialog))
  (rplaca *trace-dialog-size&position* (view-size w))
  (rplacd *trace-dialog-size&position* (view-position w))
  ;(setq *trace-dialog* nil)
  )


; from cut/clear/paste and view-key-event-hdlr
(defmethod update-default-button :after ((d trace-dialog))
  (let ((other (view-named 'untrace d)))
    (if (and (dialog-item-enabled-p (default-button d))
             (ignore-errors (%traced-p (get-spec-from-dialog d))))
      (dialog-item-enable other)
      (dialog-item-disable other))))

(defclass spec-typein-menu (typein-menu-menu) ())

(defmethod view-click-event-handler ((menu spec-typein-menu) num)
  (declare (ignore num))
  (make-specializer-items menu)
  (call-next-method))


(defun update-untrace-menu (menu)
  (apply #'remove-menu-items menu (cddr (menu-items menu)))
  (apply #'add-menu-items menu
         (mapcar #'(lambda (info)
                     (make-menu-item (prin1-to-string info)
                                     (compile nil
                                              `(lambda ()
                                                 (untrace ,info)))))
                 (trace))))

(defun trace-dialog (&aux initial-string)
  (let ((dialog (front-window :class 'trace-dialog))
        (w (front-window))
        pkg)
    (when (and w (typep w 'fred-window))
      (multiple-value-bind (b e) (selection-range w) ; or (ed-current-sexp-bounds w)?
        (when (neq b e)          
          (multiple-value-setq (pkg initial-string)
            (string-package-and-tail (buffer-substring (fred-buffer w) b e))))))
    (when (null pkg)
      (cond ((and w (typep w 'fred-window)             
                  (let ((p (window-package w)))
                    (when (typep p 'package)
                      (setq pkg p)))))
            (t (setq pkg *package*))))
    (when (not (and dialog (wptr dialog)))
      (let* ((size (car *trace-dialog-size&position*))
             (size-h (point-h size))
             (lmargin 6)
             (next-y 0)
             (menu-item-list '("Print Name & Args" "Break" "No Action")))
        (setq dialog
              (make-instance 
                'trace-dialog ; instead of string-dialog, requires one field not empty
                :view-position (cdr *trace-dialog-size&position*)
                :view-size size
                :close-box-p t
                :window-type :document-with-grow
                :window-title "Trace Function"
                :window-show nil
                :back-color *tool-back-color*
                :theme-background t
                :help-spec 15070
                ;:allow-empty-strings '(specializers result)
                :view-subviews
                (vertical-labeled-items
                 :dialog-width 360 :col2 101 :delta 29 :lmargin 12 :vpos 31
                 :lastvar next-y
                 :items
                 (("Name:" editable-text-dialog-item search-text-item nil
                   :help-spec 15071)
                  ("Specializers:" typein-menu specializers nil
                   :menu-position :left ;:right-pop-text
                   :menu-class 'spec-typein-menu
                   :help-spec 15072)
                  ("Qualifier:" pop-up-menu  qualifier 170
                   :menu-items (make-qualifier-items)
                   :help-spec 15073)
                  ("Package:" pop-up-menu package 170 
                   :menu-items (make-package-items)
                   :help-spec 15074)))))
        (apply #'add-subviews dialog
               (make-instance 'underlined-view
                 :view-position #@(6 2)
                 :view-size (make-point (- size-h 12) 20)
                 :dialog-item-text "Function")
               (make-instance 'underlined-view
                 :view-position (make-point 6 (- next-y 8))
                 :view-size (make-point (- size-h 12) 20)
                 :dialog-item-text "Action") 
               (vertical-labeled-items :dialog-width 360 :col2 101 :delta 29 :lmargin 12
                                       :vpos #.(+ 31 -6 (* 5 29))
                                      :lastvar next-y
                                      :items 
                                      (("On Entry:" pop-up-menu before 170
                                        :menu-items (make-menu-items menu-item-list)
                                        :help-spec 15075)
                                       ("On Exit:" pop-up-menu after 170
                                        :menu-items (make-menu-items '("Print Name & Values"
                                                                       "Break"
                                                                       "No Action"))
                                        :help-spec 15076)
                                       ("Step:" pop-up-menu step 170
                                        :menu-items
                                        (make-menu-items '("No" "Yes")) ))))
        (let* ((dlg-height (point-v size))
               (fred-height (- dlg-height next-y 50))
               (button-y (- dlg-height 36)))
          (add-subviews dialog
                        (make-dialog-item 'scrolling-fred-view-with-frame
                                          (make-point lmargin next-y)
                                          (make-point (+ -6 (- size-h lmargin))
                                                      fred-height)
                                          nil
                                          nil
                                          :wrap-p t
                                          :part-color-list `(:body ,*white-color*)
                                          :allow-tabs nil
                                          :buffer-chunk-size 128
                                          :h-scrollp nil
                                          :view-nick-name 'result
                                          :help-spec 15077)
                        (make-dialog-item 'default-button-dialog-item
                                          (make-point 40 button-y)
                                          nil ;#@(62 20)
                                          "Trace"
                                          #'(lambda (item)
                                              (do-trace (view-container item)))
                                          :dialog-item-enabled-p nil
                                          :help-spec 15078)
                        (make-dialog-item 'button-dialog-item
                                          (make-point 127 button-y)
                                          nil ;(if (osx-p) #@(68 20) #@(62 20))
                                          "Untrace"
                                          #'(lambda (item)
                                              (do-trace (view-container item) t))
                                          :dialog-item-enabled-p nil
                                          :view-nick-name 'untrace
                                          :help-spec 15079)
                        (make-instance 'action-pop-up-menu
                          :view-position (make-point 210 button-y)
                          ;:view-font '("Chicago" 12) 
                          :menu-items (make-menu-items
                                       `(("Untrace All" ,#'(lambda () (untrace)))
                                         "-"))
                          :auto-update-default nil
                          :update-function #'update-untrace-menu
                          :view-nick-name 'untrace-popup
                          :help-spec 15080))))
      ;(setq *trace-dialog* dialog)
      (set-view-size dialog (car *trace-dialog-size&position*)))
    #+ignore
    (let ((spec (view-named 'specializers dialog)))
      (set-view-size spec (point-h (view-size spec))(1+ (point-v (view-size spec)))))
    (let ((di (view-named 'search-text-item dialog)))
      (when pkg
        (set-default-package-item (view-named 'package dialog) pkg))  ; ?? or as you were??
      (when di
        (set-current-key-handler dialog di)
        (when initial-string 
          (set-dialog-item-text di initial-string)
          (when (> (length initial-string) 0)
            (dialog-item-enable (default-button dialog))))
        (select-all di))
      (window-select dialog))))

; needs to enforce a minimum size
(defmethod set-view-size ((d trace-dialog) h &optional v)
  (let* ((old-size (view-size d))
         (dh (- (if (not v) (point-h h) h) (point-h old-size)))
         (dv (- (if v v (point-v h)) (point-v old-size))))
    (call-next-method)
    (dovector (s (view-subviews d))
      (let ((size (view-size s)))
        (cond
         ((or (typep s 'editable-text-dialog-item)
              (typep s 'underlined-view)
              (typep s 'typein-menu))
          (set-view-size s (+ (point-h size) dh)(point-v size)))    
         ((typep s 'scrolling-fred-view)
          (set-view-size s (+ (point-h size) dh)(+ (point-v size) dv)))
         ((or (typep s 'button-dialog-item)
              (eq (view-nick-name s) 'untrace-popup))
          (let ((pos (view-position s)))
            (set-view-position s (+ (point-h pos) (round dh 2)) (+ (point-v pos) dv)))))))))

; used by trace and edit-anything
(defmethod thing-name-from-dialog ((d dialog))
  (let* ((new-string (dialog-item-text (view-named 'search-text-item d)))          
         (*package* (or (get-default-package-item (view-named 'package d)) *package*))) 
     (ignore-errors (read-from-string new-string nil nil))))
  
  
    
(defun make-specializer-items (menu)
  (let* ((dialog (view-window menu))
         (thing (thing-name-from-dialog dialog))
         (v (view-container menu))
         (string (dialog-item-text (typein-editable-text v))))
    ; what if you add some methods???
    (cond ((neq thing (last-function-name dialog))
           (setf (last-function-name dialog) thing)
           (apply #'remove-menu-items menu (menu-items menu))
           (setf (pop-up-menu-default-item menu) 0)
           (when (and thing (function-spec-p thing) (standard-generic-function-p (fboundp thing)))
             (let ((methods (%gf-methods (fboundp thing))))
               (when (and methods (%method-specializers (car methods)))
                 (flet ((down-thing (x)
                          (let ((*print-case* :downcase))
                            (format nil "~S" x)))
                        (maybe-class-name (x) (uncanonicalize-specializer x)))
                   (let* ((list (delete-duplicates
                                 (mapcar #'(lambda (m)
                                             (let ((specs (%method-specializers m)))
                                               (if (null (cdr specs))
                                                 (down-thing (maybe-class-name (car specs))) 
                                                 (down-thing (mapcar #'maybe-class-name  specs)))))
                                         methods)
                                 :test #'equal)))
                     (setq list ; cons much?                     
                           (mapcar #'(lambda (title)
                                       (let* ((item (make-instance 'typein-menu-item
                                                      :menu-item-title title)))
                                         (when (string-equal title string)
                                           (set-menu-item-check-mark item t))
                                         item))
                                   (sort list #'string-lessp)))
                     (apply #'add-menu-items menu list)))))))
          (t (dolist (i (cddr (menu-items menu)))
               (when (menu-item-check-mark i)
                 (unless 
                   (string-equal (menu-item-title i) string)
                   (set-menu-item-check-mark i nil))
                 (return)))))))
 
(defun read-list-from-string (string &optional (eof-error-p t) eof-value
                                      &key (start 0) end                               
                                      &aux  result (len (length string)))
  
   (with-input-from-string (stream string :start start :end end)
     (loop
       (when (= (slot-value stream 'index) len) (return))
       (let ((token (read stream eof-error-p eof-value)))
         (push token result)))
     (if (null (cdr result))
       (car result)
       (nreverse result))))

(defun get-spec-from-dialog (dialog &optional method-prefix)
  (let* ((thing (thing-name-from-dialog dialog))
         (specs (let ((menu (view-named 'specializers dialog)))
                  (when menu (ignore-errors 
                              (read-list-from-string 
                               (dialog-item-text (typein-editable-text menu)))))))
         (qual (let ((menu (view-named 'qualifier dialog)))
                 (when menu (nth (1- (pop-up-menu-default-item menu))
                                 '(nil :before :after :around))))))
    (when specs 
      (if (or (not (consp specs))(and (consp specs)(eq (car specs) 'eql)))
        (setq specs (list specs))))
    (if qual 
        (setq thing (list thing qual specs))
        (when specs (setq thing (list thing specs))))
    (if (and (or specs qual) method-prefix) (setq thing (cons method-prefix thing)))
    thing))

(defun do-trace (dialog &optional untrace)
  (flet ((foo (view-name)
           (let ((n (1- (pop-up-menu-default-item (view-named view-name dialog)))))
             (nth n '(:print :break nil)))))
    (let* ((thing (get-spec-from-dialog dialog :method))
           (out (fred-item (view-named 'result dialog)))
           (before (foo 'before))
           (after (foo 'after))
           (step (let ((n (1- (pop-up-menu-default-item (view-named 'step dialog)))))
                   (if (eq n 0) nil t))))
      (set-dialog-item-text out "")            
      (let ((what (if untrace 'untrace 'trace)))
        (prin1 (if (and (eq before :print)(eq after :print)(null step))
                 `(,what ,thing)
                 `(,what (,thing ,@(if (neq before :print) `(:before ,before))
                                 ,@(if (neq after :print) `(:after ,after))
                                 ,@(if step `(:step t)))))
               out)               
        (terpri out)
        (fred-update out))
      (catch :lose 
        (handler-bind
          ((error #'(lambda (c)
                      (let ((out (fred-item (view-named 'result dialog))))                                            
                        (report-condition c out)
                        (fred-update out)
                        (throw :lose nil)))))
          (if untrace 
            (%untrace thing)
            (%trace thing :before before :after after :step step)))
        (let ((u (view-named 'untrace dialog)))
          (cond ((and (not untrace)(%traced-p (%trace-function-spec-p thing)))
                 (dialog-item-enable u))
                (untrace (dialog-item-disable u)))))))) 

(defun make-package-items (&optional all)
  (let ((l (list-all-packages)))
    (setq l (mapcar #'(lambda (p)
                        (make-menu-item (package-name p) nil))
                    l))
    (setq l (sort l #'(lambda (a b)
                        (string<= (menu-item-title a)(menu-item-title b)))))
    (if all (rplacd (last l) (list (make-menu-item "All Packages" nil))))
    l))

(defun set-default-package-item (menu pkg)
  (let ((items (menu-items menu))
        (pkg-name (package-name pkg))
        (n 1))
    (setq  n
           (dolist (mi items 1)
             (when (string-equal (menu-item-title mi) pkg-name)
               (return n))
             (setq n (1+ n))))
    (set-pop-up-menu-default-item menu n)))

(defun get-default-package-item (menu)
  (let* ((n (pop-up-menu-default-item menu))
         (item (nth (1- n)(menu-items menu))))
    (if (string= (menu-item-title item) "All Packages")
      nil
      (or (find-package (menu-item-title item)) *package*)))) 

;;;;;;;;;;;
;;search files support

#|
(defun files-containing-string (string files &aux (scratch (make-buffer))
                                       old-window)
  (mapcan #'(lambda (a-file)
              (let ((real-file (probe-file a-file)))
                (if real-file
                  (when (eq (mac-file-type a-file) :text)
                    (when
                      (if (setq old-window (pathname-to-window a-file))
                        (buffer-string-pos (fred-buffer old-window)
                                           string :start 0 :end t)
                        (progn
                          (buffer-delete scratch 0 t)
                          (%buffer-insert-file scratch a-file 0)
                          (buffer-string-pos scratch string
                                             :start 0 :end t)))
                      (list a-file)))
                  (warn "File ~a not found." a-file))))
          files))
|#

(defvar %previous-search-file-string "")
(defvar %previous-search-file-file "")
;(defvar *search-file-dialog* nil)

(defclass search-file-dialog (string-dialog)
  ()
  (:default-initargs
   :window-type :document 
   :window-title "Search Files"
   :help-spec 15060))

(defparameter *sfd-size&position* (cons #@(410 101) '(:bottom 11))) 

; Make sure GC will recover the frecs for my fred-dialog-items
(defmethod window-close :before ((w search-file-dialog))  
  (rplaca  *sfd-size&position* (view-size w))
  (rplacd *sfd-size&position* (view-position w))
  ;(setq *search-file-dialog* nil)
  )

(defmethod set-view-size ((w search-file-dialog) h &optional v)
  (let*((old-size (view-size w))
        (file (view-named 'file-item w))
        (string (view-named 'string-item w))
        (button (find-subview-of-type w 'button-dialog-item))
        (delta (make-point (- (if (not v)(point-h h) h)(point-h old-size)) 0)))
  (call-next-method)
  (set-view-size file (add-points (view-size file) delta))
  (set-view-size string (add-points (view-size string) delta))
  (set-view-position button (add-points (view-position button) delta))))
 

; dunno if i like this
#+ignore
(defun search-file-dialog (&aux initial-string initial-pathname)
  (let ((w (front-window :class 'fred-window)))
    (if w
      (progn
        (let* ((p (window-filename w)))
          (if p 
            (setq initial-pathname (namestring (merge-pathnames "*" p)))
            (setq initial-pathname "ccl:**;*.lisp")))
        (multiple-value-bind (b e)(selection-range w)
          (when (neq b e)
            (setq initial-string (buffer-substring (fred-buffer w) b e)))))
      (setq initial-pathname "ccl:**;*.lisp")))
  (let ((the-dialog (front-window :class 'search-file-dialog)))
    (if the-dialog
      (let ((keyhdlr (current-key-handler the-dialog)))
        (when initial-string
          (set-dialog-item-text (view-named 'string-item the-dialog) initial-string))
        (when initial-pathname
          (set-dialog-item-text (view-named 'file-item the-dialog) initial-pathname))
        (when keyhdlr          
          (set-selection-range keyhdlr 0 (length (dialog-item-text keyhdlr)))))
      (labels ((item (type text size position &rest rest)
                 (declare (dynamic-extent rest))
                 (apply #'make-instance
                        type
                        :dialog-item-text text
                        :view-size size
                        :view-position position
                        rest)))
        (when (not initial-string)(setq initial-string %previous-search-file-string))
        (when (not initial-pathname)(setq initial-pathname %previous-search-file-file))
        (setq the-dialog
              (make-instance 'search-file-dialog 
                :window-show nil
                :back-color *tool-back-color*
                :grow-icon-p t
                :window-show nil
                :view-size #@(410 101)
                :view-position (cdr *sfd-size&position*)))
        (add-subviews
         the-dialog
         (item 'static-text-dialog-item
               "Enter a pathname and a string.
The pathname may contain wild-cards."
               #@(290 32) #@(8 4))
         (item 'static-text-dialog-item
               "In Pathname" #@(85 16) #@(4 43))
         (item 'static-text-dialog-item
               "Search For" #@(85 16) #@(4 68))
         (item 'editable-text-dialog-item
               initial-pathname
               #@(285 16) #@(100 43)
               :view-nick-name 'file-item
               :help-spec 15061)
         (item 'editable-text-dialog-item
               initial-string
               #@(220 16) #@(100 68)
               :view-nick-name 'string-item
               :help-spec 15062)
         (make-dialog-item
           'default-button-dialog-item
           #@(329 68)
           #@(55 16)
           "  OK  "
           #'(lambda (item)
               (setq %previous-search-file-string
                     (dialog-item-text (view-named 'string-item item))
                     %previous-search-file-file
                     (dialog-item-text (view-named 'file-item item)))
               (if *single-process-p*
                 (eval-enqueue `(do-dialog-file-search
                                 ,%previous-search-file-file
                                 ,%previous-search-file-string))
                 (process-run-function "Search Files"
                                       #'(lambda (pathname string)
                                           (let ((*standard-output* (ed-standard-output)))
                                             (do-dialog-file-search pathname string)))
                                       %previous-search-file-file
                                       %previous-search-file-string)))
           :help-spec 15063))
        (set-view-size the-dialog (car *sfd-size&position*))))
    (update-default-button the-dialog)
    (window-select the-dialog)
    the-dialog))


(dolist (item (slot-value *tools-menu* 'item-list))
  (menu-item-enable item))

(defvar *env-table* nil)
(defconstant *env-value-position* #@(281 55))  ; position of value item in dialog

(defun nil-or-number (name val)
  (let () ;(val (cadr thing)))
    (or (or (null val)(and (fixnump val)(>= val 0)))
        (progn (y-or-n-dialog (format nil "~A must be nil or a positive integer." name)
                              :yes-text "OK"
                              :no-text nil
                              :cancel-text nil)
               nil))))
      

(defun print-base-chk (name val)
  (let ()
    (or (and (fixnump val)
             (< 0 val 32))
        (progn (y-or-n-dialog (format nil "~A must be an integer between 1 and 32." name)
                              :yes-text "OK"
                              :no-text nil
                              :cancel-text nil)
               nil))))

(defun non-negative-integer (name val)
  (or (and (fixnump val)
           (>= val 0))
      (progn (y-or-n-dialog (format nil "~A must be a non-negative integer." name)
                            :yes-text "OK"
                            :no-text nil
                            :cancel-text nil)
             nil)))

(defun any-integer (name val)
  (or (fixnump val)
      (progn (y-or-n-dialog (format nil "~A must be an integer." name)
                            :yes-text "OK"
                            :no-text nil
                            :cancel-text nil)
             nil)))

(defun any-integer-or-nil (name val)
  (or (null val)
      (any-integer name val)))
      


(defvar *env-categories* nil)  ; redefined later

;  sym val-in-table initial-val help-spec . type  - nil means boolean, T means typein
; fn is a validity check and view is a pop-up for values
; N.B. help-specs don't buy you much these days and rather pointless since we show
; the doc strings.

;(def-preference-var *futz* nil :category "Vomit" :fn-or-view #'numberp)
;obsolete
;(defmacro def-preference-var (name value &key (category "Environment")
;                                   help-spec fn-or-view)  
;  `(progn (defvar ,name ,value)
;          (add-preference-var ,category ',name ,help-spec ,(eval fn-or-view))))

(defun add-preference-var (sym categ-name sym-name init-val help-spec fn-or-view)
  (let ((new-info (list* sym-name nil init-val help-spec fn-or-view))
        (categs (symbol-value sym)))
    (unless (dolist (categ categs nil)
              (when (string-equal categ-name (car categ))
                (unless (dolist (var-info (cdr categ) nil)
                          (when (eq sym-name (car var-info))
                            (rplacd var-info (cdr new-info))
                            (return t)))
                  (rplacd categ (cons new-info (cdr categ))))
                (return t)))
     (set sym (nconc categs (list (list categ-name new-info)))))))

(defun add-preference-vars (sym categs)
  (dolist (categ categs)
    (let* ((categ-name (car categ))
           (specs (cdr categ)))
      (if specs
        (dolist (var-info specs)
          (add-preference-var
           sym categ-name
           (first var-info) (third var-info) (fourth var-info)
           (cddddr var-info)))
        (set sym (nconc (symbol-value sym) (list (list categ-name))))))))

; Initial values get reset by def-ccl-pointers below this.
(add-preference-vars
 '*env-categories*
 `(("Environment"
    ;(*string-compare-script* nil nil 14220 . ,#'any-integer-or-nil)
    ;(*warn-if-redefine* nil nil 14212)
    ;(*save-local-symbols* nil nil 14208)
    (*inspector-disassembly*)  ; why need balloon help when has doc?
    (*record-source-file* nil nil 14202)
    (*arglist-on-space* nil nil 14203)
    (*autoload-traps* nil nil 14204)
    ;(*save-definitions* nil nil 14206)
    ;(*compile-definitions* nil nil 14207)
    (*paste-with-styles* nil nil 14209)
    (*load-verbose* nil nil 14210)
    (*verbose-eval-selection* nil nil 14211)
    (*break-on-warnings* nil nil 14213)
    (*backtrace-on-break* nil nil 14214)
    (*error-print-circle* nil nil nil)
    (*break-on-errors* nil nil 14215)
    (*fred-history-length* nil nil nil . ,#'non-negative-integer)
    (*autoload-lisp-package* nil nil 14216)
    (*control-key-mapping* nil nil nil . ,(make-instance 'pop-up-menu
                                            :view-size #@(98 24)
                                            :view-font '("Courier" 12 :bold)
                                            :view-nick-name 'other
                                            :menu-items
                                            (make-menu-items 
                                             `(("Nil" ,#'(lambda ()  ; these dudes should take an argument so you can find the darn container
                                                           (set-env-value *env-table* nil)))
                                               ; doesnt fit in the dialog!
                                               (":Command-Shift" ,#'(lambda ()
                                                                      (set-env-value *env-table* :command-shift))) 
                                               (":Command"  ,#'(lambda ()
                                                                 (set-env-value *env-table* :command)))))))
    ;(*fasl-save-local-symbols* nil nil 14217)
    (*save-fred-window-positions* nil nil 14218)
    ;(*listener-indent* nil nil nil)
    (*autoclose-inactive-listeners* nil nil 14219)
    (*always-eval-user-defvars* nil nil 14220)
    ;(*use-pop-up-control*)
    (*dont-bring-all-windows-front*)
    (*disable-bubbles-on-inactive-windows*)
    (*preferred-eol-character* nil nil nil . ,(make-instance 'pop-up-menu
                                                :view-size #@(98 24)
                                                :view-font '("Courier" 12 :bold)
                                                ;:view-position *env-value-position*
                                                :view-nick-name 'other ;  can only be one per category? unclear
                                                :menu-items
                                                (make-menu-items 
                                                 `(("NIL"  ,#'(lambda ()
                                                                (set-env-value *env-table* nil)))
                                                   ("#\\Linefeed" ,#'(lambda () 
                                                                       (set-env-value *env-table* #\linefeed))) 
                                                   ("#\\Return" ,#'(lambda ()
                                                                     (set-env-value *env-table* #\return)))                                                   
                                                   ))))
    )
   ("Compiler"
    (*fasl-save-definitions* nil nil nil)
    (*save-definitions* nil nil 14206)
    (*compile-definitions* nil nil 14207)
    (*fasl-save-local-symbols* nil nil 14217)
    (*save-local-symbols* nil nil 14208)
    (*fasl-save-doc-strings* nil nil nil)
    (*save-doc-strings* nil nil 14205)
    (*warn-if-redefine* nil nil 14212))
   ("Printing"
    (*print-pretty* nil nil nil)
    (*print-array* nil nil nil)
    (*print-circle* nil nil nil)
    (*print-length* nil nil nil . ,#'nil-or-number) ; t or a sanity check fn means its editable-text
    (*print-lines* nil nil nil . ,#'nil-or-number)
    (*print-structure* nil nil nil)
    (*print-escape* nil nil nil)
    (*print-gensym* nil nil nil)
    (*print-radix* nil nil nil)
    (*print-readably* nil nil nil)
    (*print-level* nil nil nil . ,#'nil-or-number)
    (*print-base* nil nil nil . ,#'print-base-chk)
    (*print-right-margin* nil nil nil . ,#'nil-or-number)
    (*print-case* nil nil nil . ,(make-instance 'pop-up-menu
                                   :view-size #@(98 24)
                                   :view-font '("Courier" 12 :bold)
                                   ;:view-position *env-value-position*
                                   :view-nick-name 'other ;  can only be one per category? unclear
                                   :menu-items
                                   (make-menu-items 
                                    `((":Upcase" ,#'(lambda ()  ; these dudes should take an argument so you can find the darn container
                                                      (set-env-value *env-table* :upcase))) 
                                      (":Downcase" ,#'(lambda ()
                                                        (set-env-value *env-table* :downcase))) 
                                      (":Capitalize"  ,#'(lambda ()
                                                           (set-env-value *env-table* :capitalize))) 
                                      (":Studly" ,#'(lambda ()
                                                      (set-env-value *env-table* :studly))))))))))

(def-ccl-pointers environment ()
  (flet ((sort-em (a b)           
           (string-lessp (symbol-name (car a))
                         (symbol-name (car b)))))
    (dolist (categ *env-categories*)
      (rplacd categ (sort (cdr categ) #'sort-em))
      (dolist (spec (cdr categ))
        (let ((typer (cddddr spec)))
          (when (typep typer 'view)
            (set-view-position typer *env-value-position*)))
        (setf (third spec) (symbol-value (first spec)))))))

(defvar *preferences-command-key* #\K)  ;; can be nil

(defun set-pref-command-key (&key  (char *preferences-command-key*) (modifier nil)(what #$kHICommandPreferences))
  (when t ;(osx-p)    
    (rlet ((out-menu :ptr)
           (out-index :unsigned-integer))
      (let ((err (#_getIndMenuItemWithCommandID *null-ptr* 
                  what 1 out-menu out-index)))
        (when (eq #$noerr err)
          (when char ;; can be nil ?
            (#_setMenuItemCommandkey (%get-ptr out-menu) (%get-unsigned-word out-index) nil (char-code char))
            (#_setMenuItemModifiers (%get-ptr out-menu) (%get-unsigned-word out-index)         
             (ecase modifier
               (:shift #$kMenuShiftModifier)
               ((:option :meta) #$kMenuOptionModifier )
               (:control #$kMenuControlModifier)
               ((nil) #$kMenuNoModifiers))))
          (#_enablemenuitem (%get-ptr out-menu)(%get-unsigned-word out-index)))))))


(pushnew 'set-pref-command-key *lisp-startup-functions*)  

(defun put-prefs ()  ;; or lose prefs
  (if t ;(osx-p)
    (let ((foo (find-menu-item *tools-menu* "Preferences…")))
      (when foo 
        (let ((idx (menu-item-number foo)))
          (remove-menu-items *tools-menu* (elt (menu-items *tools-menu*) (-  idx 2)) foo))))    
    (when (not (find-menu-item *tools-menu* "Preferences…"))
      (add-new-item *tools-menu* "-" nil :disabled t)
      (add-new-item *tools-menu* "Preferences…" 'environment-dialog))))

(pushnew 'put-prefs *lisp-startup-functions*)

;; misnamed - also allows enable 
(defun disable-or-delete-preferences-menu-item (&optional (what :disable))
  (rlet ((out-menu :ptr)
         (out-index :uint16))
    (let ((err (#_getIndMenuItemWithCommandID *null-ptr* 
                #$kHICommandPreferences 1 out-menu out-index)))        
      (when (eq #$noerr err)
        (let ((item-num (%get-unsigned-word out-index)))
          (ecase what
            (:disable (#_disablemenuitem (%get-ptr out-menu) item-num))
            (:delete (#_deletemenuitem (%get-ptr out-menu) item-num))
            (:enable (#_enablemenuitem (%get-ptr out-menu) item-num))))))))
    

(setf (documentation '*disable-bubbles-on-inactive-windows* 'variable)
                   "Controls whether close, minimize, and zoom
bubbles work in inactive windows. T for OS9
behavior, nil for OSX behavior. Takes
effect only after windows have been
deactivated.")

(setf (documentation '*dont-bring-all-windows-front* 'variable)
                   "Controls how windows behave when MCL is
selected. Set to T for normal OSX window
behavior, nil for OS9 window behavior."
)

(setf (documentation '*preferred-eol-character* 'variable)
                  "The character to use to denote end of line
when a Fred buffer is written to a file.
NIL means leave content as is.")


;; Base class for Preferences dialog and Modules dialog

(defclass env-dialog (dialog) ())

(defmethod env-init-action ((dialog env-dialog)) )

; its passed for Cancel/Defaults/Revert buttons, type-in field
(defmethod view-click-event-handler ((d env-dialog) where)
  (let ((sub (find-clicked-subview d where)))
    (when (or (eq sub d)
              (memq (view-nick-name sub) '(cancel defaults typein-value revert))
              (get-env-value d))
      (call-next-method))))

(defmethod view-key-event-handler ((d env-dialog) ch)
  (when (or (not (memq ch '(#\return #\tab #\enter)))
            (get-env-value d))
    (call-next-method)))

(defmethod get-env-value ((dialog env-dialog))
  t)

(defmethod update-categories ((dialog env-dialog) from-key)
  (declare (ignore from-key)))

(defmethod install-categories ((dialog env-dialog) categs)
  (declare (ignore categs)))

(defmethod update-buttons ((d env-dialog)) )

(defmethod make-category-items ((dialog env-dialog) table categs)  
  (mapcar #'(lambda (categ)
              (make-menu-item (first categ)
                              #'(lambda ()
                                  (reset-env-table-sequence dialog table categ))))                                  
          categs))

(defmethod reset-env-table-sequence ((dialog env-dialog) table categ &optional force)
  (let ((specs (cdr categ)))
    (when (or force (neq (table-sequence table) specs))
      (set-table-sequence table specs))
    (setf (original-table-sequence table) specs)
    ; either this or filter again:
    (let ((filter (view-named 'string-item dialog)))
      (when filter
        (set-dialog-item-text filter "")))
    (set-current-key-handler dialog table)
    (update-env-table table t)))
            
(defmethod env-show-doc ((dialog env-dialog) info where)
  (declare (ignore info where)))

(defmethod refresh-env ((dialog env-dialog))
  (let ((table (view-named 'table dialog)))
    ; simulate category selection to update table
    (set-table-sequence table nil)   ; force update
    (menu-item-action (selected-item (view-named 'category dialog)))
    (let ((seq (table-sequence table)))
      (dotimes (n (length seq))
        (redraw-cell table 0 n)))
    (update-env-table table t)))

(defmethod do-env-type ((dialog env-dialog) it val-type v-bool v-typein v-other)
  (declare (ignore it val-type v-bool v-typein v-other)))

; revert to prefs file values if there is one, else to values current
; at dialog open time
(defmethod env-revert ((dialog env-dialog))
  (multiple-value-bind (path file-p) (env-file-path dialog)
    (if file-p
      ; should catch & report errors
      (with-open-file (stream path :element-type 'base-character)
        (load-from-stream stream nil))
      (update-categories dialog :revert))
    (refresh-env dialog)))

; Returns values prefs-file-path, file-exists-p
(defmethod env-file-path ((dialog env-dialog))
  nil)

(defmethod env-save ((dialog env-dialog)) )

(defmethod env-save-file ((dialog env-dialog) path file-type categs-sym)
    (with-open-file (strm path
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create
                          :external-format file-type)
      (file-length strm 0)
      (format strm "(in-package \"CCL\")~%(set-env-categories ~A '(~%"
              categs-sym)
      (dolist (cat (symbol-value categs-sym))
        (dolist (spec (cdr cat))
          (format strm "~S ~S~%" (first spec) (second spec))))
      (format strm "))~%"))
    (update-buttons dialog))

; called by env file when it's loaded
(defun set-env-categories (categs pairs)
  (flet ((find-spec (name)
           (dolist (cat categs nil)
             (let ((spec (find name (cdr cat) :test #'eq :key #'car)))
               (when spec
                 (return-from find-spec spec))))))
    (while pairs
      (let ((spec (find-spec (pop pairs))))
        (when spec
          (setf (second spec) (pop pairs)))))))

(defmethod env-use-defaults ((dialog env-dialog) categs)
  (dolist (cat categs)
    (dolist (spec (cdr cat))
      (setf (second spec) (third spec))))
  (refresh-env dialog))

(defmethod env-edit-action ((dialog env-dialog) item)
  (declare (ignore item)))

(defmethod env-aux-control ((dialog env-dialog) categs)
  (declare (ignore categs)))


;;; Preferences dialog

(defvar *preferences-file-name* "MCL Preferences")
(defconstant prefs-file-type :|cclP|)     ; really a text file, but hide its contents

; Believe it or not, this is a platform independent way to tell
; if the compiler has been excised. See the excise-compiler function.
; This function belongs somewhere else, but right now it's only called
; from load-preferences-file, so it's here.
(defun compiler-excised-p ()
  (not (and (boundp '*nx1-alphatizers*)
            (hash-table-p *nx1-alphatizers*)
            (not (eql 0 (hash-table-count *nx1-alphatizers*))))))

(defun load-preferences-file ()
  (with-simple-restart (continue "Skip loading preferences file.")
    (flet ((check-dir (dir)
             (if dir
               (probe-file (merge-pathnames *preferences-file-name* dir)))))
      (let ((path (or (check-dir (findfolder #$kUserDomain #$kPreferencesFolderType))
                      (check-dir (user-homedir-pathname)))))
        (flet ((load-it (path)
                 (when path
                   (let ((*package* *package*))
                     (with-open-file (stream path :element-type 'base-character)
                       (load-from-stream stream nil))
                     (dolist (categ *env-categories*)
                       (dolist (info (cdr categ))
                         (set (first info) (second info))))))))
          (if (compiler-excised-p)
            (let ((*compile-definitions* *compile-definitions*))
              (load-it path))
            (load-it path)))))))

(defclass prefs-dialog (env-dialog) ())

; do this before changing table sequence or selected cell
; returns t if ok nil otherwise
(defmethod get-env-value ((dialog prefs-dialog))
  (let* ((table (view-named 'table dialog))
         (cell (selected-cell-contents table)))
    (if cell
      (let ((fn (cddddr cell)))
        (cond ((or (eq fn t)
                   (functionp fn)
                   (and fn
                        (symbolp fn)
                        (fboundp fn)))
               (let* ((di (view-named 'typein-value dialog))
                      (value (ignore-errors 
                              (read-from-string (dialog-item-text di) nil))))
                 (if (or (eq fn t) (funcall fn (car cell) value))
                   (progn (set-env-value table value) t)
                   (progn (select-all di) nil))))
              (t t)))
      t)))

(defmethod update-categories ((dialog prefs-dialog) from-key)
  (declare (ignore from-key))
  (dolist (categ *env-categories*)
    (dolist (info (cdr categ))
      (setf (second info) (symbol-value (car info))))))

(defmethod install-categories ((dialog prefs-dialog) categs)
  (dolist (categ categs)
    (dolist (info (cdr categ))
      (set (first info) (second info)))))

#|  ;; why did we think this was needed??
(defmethod view-key-event-handler ((window prefs-dialog) char)(call-next-method))
  (let ((key-hdlr (current-key-handler window)))
    (if (and key-hdlr (memq char '(#\return #\tab #\enter)) (not (allow-returns-p key-hdlr)))
      (if (eq (view-nick-name key-hdlr) 'typein-value)  ;; dont let #\return do the default-button if bad value
        (if (get-env-value window)
          (call-next-method))
        (call-next-method))
      (call-next-method))))
|#

#| No, always enabled so you can revert to state when dialog opened.
(defmethod update-buttons ((dialog prefs-dialog))
  (set-dialog-item-enabled-p (find-dialog-item dialog "Revert")
                             (nth-value 1 (env-file-path dialog))))
|#

(defmethod env-show-doc ((dialog prefs-dialog) info where)
  (show-documentation (car info) where))

#| ; lose it - doesnt work
; Process the 'type' item (a choice popup menu).
(defmethod do-env-type ((dialog prefs-dialog) it val-type v-bool v-typein v-other)
  (set-view-position v-bool   #@(-1000 -1000))
  (set-view-position v-typein #@(-1000 -1000))
  (set-view-position val-type *env-value-position*)
  (when (and v-other 
             (not (eq v-other val-type)))
    (set-view-container v-other nil))
  (unless (eq (view-container val-type) dialog)
    (set-view-container val-type dialog))
  ; well thats real general huh!
  (set-pop-up-menu-default-item 
   val-type
   (1+ (position (symbol-name (cadr it))
                 (menu-items val-type)
                 :test #'(lambda (a b)
                           (let ((title (menu-item-title b)))
                             (string-equal a title
                                         :start2 (if (eq (char title 0) #\:) 1 0))))))))

|#


(defmethod env-file-path ((dialog prefs-dialog))
  (flet ((check-dir (dir)
           (when dir
             (let ((path (merge-pathnames *preferences-file-name* dir)))
               (return-from env-file-path (values path (probe-file path)))))))
    (check-dir (findfolder #$kOnSystemDisk #$kPreferencesFolderType))
    (check-dir (user-homedir-pathname))))

(defmethod env-save ((dialog prefs-dialog))
  (let ((path (env-file-path dialog)))
    (unless path
      (error "Unable to determine a path for the Preferences file."))
    (env-save-file dialog path prefs-file-type '*env-categories*)))

(defmethod env-edit-action ((w prefs-dialog) item)
  (filter-table-sequence (view-named 'table w) item))

; used by environment-dialog and refilter-table in list-definitions

(defmethod filter-table-sequence ((table filtered-arrow-dialog-item) item)
  (let* ((orig  (original-table-sequence table))
         (str   (dialog-item-text item))
         (strlen (length str)))
    (if (eq 0 strlen)
      (when (not (eq (table-sequence table) orig))
        (set-table-sequence table orig))
      (let* ((vect (temp-table-vector table))
            (fn (cell-to-string-function table))
            (all-eq? t))
        (when (or (null vect)
                  (< (array-total-size vect)
                     (length orig)))
          (setq vect (make-array (length orig) :fill-pointer 0))
          (setf (temp-table-vector table) vect))
        (setf (fill-pointer vect) 0)        
        (dolist (item orig)
          (when (%apropos-substring-p str (funcall fn item))
            (unless (eq item (aref vect (fill-pointer vect)))
              (setq all-eq? nil))
            (vector-push-extend item vect)))
        (set-table-sequence table vect)
        (unless all-eq?
          (invalidate-view table))))
    (dialog-item-action table)))


(defun environment-dialog ()  
  (env-dialog 'prefs-dialog
              *env-categories*
              "Preferences"
              "Variable       Contains:"
              :filter t
              :aux-control :value-popup
              :help-spec 15110))

(defun env-dialog (class categs title table-label
                   &key (position '(:top 50))
                        (size #@(386 305))
                        filter
                        aux-control
                        help-spec
                        doc-wrap)
  (let* ((sequence (cdar categs))
         (table (make-instance 'filtered-arrow-dialog-item
                  :view-position #@(9 59)
                  :view-size #@(250 104)
                  :view-font '("geneva" 10)
                  :view-nick-name 'table
                  :table-sequence sequence
                  :original sequence
                  :table-print-function 'print-env-var
                  :help-spec 15113
                  :table-vscrollp t
                  :cell-to-string-function
                  #'(lambda (cell)
                      (symbol-name (first cell)))
                  :dialog-item-action #'update-env-table))
         (cat-popup (make-instance 'pop-up-menu
                      :view-nick-name 'category
                      :view-position #@(64 7)
                      :view-size #@(198 20)
                      :help-spec 15111))
         (doc-view (make-instance 'scrolling-fred-view-with-frame
                     :view-position #@(8 192)
                     :view-size #@(252 96)
                     :view-nick-name 'documentation
                     :part-color-list `(:body ,*white-color*)
                     :allow-tabs nil
                     :buffer-chunk-size 128
                     :word-wrap-p doc-wrap
                     :h-scrollp nil
                      :help-spec 15114))
         (d (make-instance class
              :window-type :movable-dialog
              :view-size size
              :view-position position
              :window-show nil
              ;:back-color *tool-back-color*
              :theme-background t
              :window-title title
              :help-spec help-spec
              :view-subviews
              `(,(make-instance 'static-text-dialog-item
                   :dialog-item-text "Category:"
                   :view-position #@(7 10)
                   :view-font '("Geneva" 10 :bold ))
                ,cat-popup
                ,(make-instance 'static-text-dialog-item
                   :dialog-item-text table-label
                   :view-font '("Geneva" 10 :bold )
                   :view-position #@(7 37))
                ,@(if filter
                    `(,(make-instance 'editable-text-dialog-item
                         :view-nick-name 'string-item
                         :view-position #@(144 36)
                         :view-font *fred-default-font-spec*
                         :view-size #@(114 14)
                         ;:draw-outline -2  ;; unused
                         :help-spec 15112
                         :dialog-item-action
                         #'(lambda (item)
                             (env-edit-action (view-window item) item)))))
                ,table
                ,@(case aux-control
                    (:value-popup
                     `(,(make-instance 'static-text-dialog-item
                          :view-position #@(281 38)
                          :view-font '("Geneva" 10 :bold)
                          :dialog-item-text "Value:")
                       ,(make-instance 'pop-up-menu
                          :view-position *env-value-position*
                          :view-nick-name 'value
                          ;:view-size #@(80 20)
                          ;:view-font '("Geneva" 10 :bold)
                          ;:menu-position :left
                          :help-spec 15115
                          :menu-items
                          (make-menu-items
                           `(("T" ,#'(lambda ()
                                       (set-env-value table t)))
                             ("NIL" ,#'(lambda ()
                                         (set-env-value table nil))))))))
                    (:add-button
                     `(,(make-dialog-item 'button-dialog-item
                                          #@(185 37)
                                          #@(77 15)
                                          "Add Module"
                                          #'(lambda (item)
                                              (env-aux-control (view-window item) categs))
                                          :view-nick-name 'aux-control
                                          :view-font '("Geneva" 10 :bold)))))
                ,(make-instance 'editable-text-dialog-item
                   :view-font *fred-default-font-spec* ;'("Geneva" 10 :bold)
                   :view-size #@(60 14)
                   ;:draw-outline -2  ;; unused
                   :view-position #@(-100 -100)
                   :view-nick-name 'typein-value
                   :help-spec 15115)
                ,(make-instance 'static-text-dialog-item
                   :view-position #@(6 175)
                   :view-font '("Geneva" 10 :bold )
                   :dialog-item-text "Documentation:")
                ,doc-view
                ,(make-dialog-item 'default-button-dialog-item
                                   #@(290 250)
                                   #@(65 20)
                                   "OK"                 
                                   #'(lambda (item)
                                       (install-categories (view-window item) categs)
                                       (return-from-modal-dialog nil))
                                   :help-spec 15120)                             
                ,(make-dialog-item 'button-dialog-item
                                   #@(290 215)
                                   #@(65 20)
                                   "Cancel"
                                   #'return-cancel
                                   :view-nick-name 'cancel
                                   :help-spec 15119)
                ,(make-dialog-item 'button-dialog-item
                                   #@(281 106)
                                   (if (osx-p) #@(100 20) #@(90 20))
                                   "Use Defaults"
                                   #'(lambda (item)
                                       (env-use-defaults (view-window item) categs))
                                   :view-nick-name 'defaults
                                   :help-spec 15116)
                ,(make-dialog-item 'button-dialog-item
                                   #@(281 135)
                                   #@(90 18)
                                   "Save"
                                   #'(lambda (item)
                                       (env-save (view-window item)))
                                   :help-spec 15117)
                ,(make-dialog-item 'button-dialog-item
                                   #@(281 162)
                                   #@(90 18)
                                   "Revert"
                                   #'(lambda (item)
                                       (env-revert (view-window item)))
                                   :view-nick-name 'revert
                                   :help-spec 15118)))))
    (apply #'add-menu-items cat-popup (make-category-items d table categs))
    (setq *env-table* table)
    (env-init-action d)
    (update-categories d :initialize)    
    (set-current-key-handler d table)
    (dialog-item-action table)
    (update-buttons d)
    (modal-dialog d)
    ;(window-show d) ;for testing
    ))

(defun update-env-table (item &optional no-click)
  (let ((c (first-selected-cell item)))
    (when c                          
      (let* ((it (cell-contents item c))
             (container (view-window item))
             (v-bool    (view-named 'value container))
             (v-typein  (view-named 'typein-value container))
             (v-other   (view-named 'other container))
             (val-type (cddddr it)))
        (cond ((eq val-type :off))
              ((or (functionp val-type)
                   (eq val-type t))  ; itsa typein
               ;(if v-other (set-view-position v-other #@(-1000 -1000)))
               ; and/OR perhaps set his container to nil
               (when v-other (set-view-container v-other nil)) 
               (when v-bool  (set-view-position v-bool #@(-1000 -1000)))
               (set-dialog-item-text v-typein (format nil "~D" (cadr it)))
               (set-view-position v-typein (add-points *env-value-position* #@(2 2))))
              ; restored from 3.0a5
              ((eq val-type nil) ; itsa boolean
                 ;(if v-other (set-view-position v-other #@(-1000 -1000)))
                 (when v-other (set-view-container v-other nil))
                 ; and/or set container to nil?
                 (set-view-position v-typein #@(-1000 -1000))
                 (when (not (eql (view-position v-bool) *env-value-position*))
                   (set-view-position v-bool *env-value-position*))
                 (when (and (null no-click)(double-click-p))                     
                   (rplaca (cdr it) (null (cadr it)))                              
                   (redraw-cell item c)
                   (setq *multi-click-count* 0)  ;; <<<<  else sometimes "respond" twice ?? So say "OK we did it already"
                   )
                 (set-pop-up-menu-default-item v-bool (if (cadr it) 1 2)))
              ((typep val-type 'simple-view)
               (when v-bool (set-view-position v-bool #@(-1000 -1000)))
               (when v-typein (set-view-position v-typein #@(-1000 -1000)))
               (set-view-position val-type *env-value-position*)
               (when v-other 
                 (unless (eq v-other val-type)(set-view-container v-other nil)))
               (when (not (eq (view-container val-type) container))
                 (set-view-container val-type container))
               ; well thats real general huh! - lets fix it a bit
               (let* ((curval (cadr it))
                      (curstr (if (symbolp curval)
                                (symbol-name curval)
                                (format nil "~s" curval)))
                      (pos (position  curstr
                                       (menu-items val-type)
                                       :test
                                       #'(lambda (a b)
                                           (let ((title (menu-item-title b)))
                                             (string-equal a title
                                                           :start2 (if (eq (char title 0) #\:) 1 0)))))))
                 (when (not pos) ; bogus value - revert to val at startup 
                   (setq pos 0)  ; who says its first or any more valid?  
                   (set (car it) (third it))
                   )
                 (set-pop-up-menu-default-item val-type (1+ pos))))
               ; this doesnt work in preferences dialog - so lose it
              ((consp val-type) 
               ;(if v-other (set-view-position v-other #@(-1000 -1000)))
               (when v-other
                 (set-view-container v-other nil))
               ; and/or set container to nil?
               (set-view-position v-typein #@(-1000 -1000))
               (when (and v-bool (not (eql (view-position v-bool) *env-value-position*)))
                 (set-view-position v-bool *env-value-position*))
               (let ((new-val (null (second it))))
                 (when (and (null no-click) (double-click-p))                          
                   (setf (second it) new-val)      
                   (redraw-cell item c))
                 (when v-bool
                   (set-pop-up-menu-default-item v-bool (if new-val 1 2)))))
              
              (t (do-env-type container it val-type v-bool v-typein v-other)))
        (unless (eql it (table-last-cell item))
          (setf (table-last-cell item) it)
          (let ((output (fred-item (view-named 'documentation container))))
            (set-dialog-item-text output "")
            (view-put output :right-margin (- (point-h (view-size output)) 10))
            (env-show-doc container it output)))))))

(defun set-env-value (table value)
  (let ((c (first-selected-cell table)))
    (when c
      (let* ((thing (cell-contents table c)))
        (when (neq (cadr thing) value)
          (rplaca (cdr thing) value)
          (redraw-cell table c))))))

(defun print-env-var (spec &optional (stream t))
  (let ((*print-case* :downcase))
    ; in geneva 10 dot = 2 spaces, altcheckmark = 3 spaces
    (format stream "~A ~S" (if (second spec) "•  " "    ") (first spec))))


; End of ccl-menus-lds.lisp
