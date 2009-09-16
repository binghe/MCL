;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    Mirus Controls.lisp
;;    Copyright 1998-1999 The MIRUS Group
;;    By: Chris Young
;;
;;    Provided "as is" and free of charge. The MIRUS Group assumes no responsibility
;;    for any harm that may come from using this code.
;;


;; This file restores some but not all color functionality for dialog-items in OS 8.5
;; Some "genius" at Apple thought it was cool to make the long existing color functionality 
;; do nothing in the presence of the appearance manager and themes.
;; (If I want blue text in a dialog item then I want blue text and I don't care what your melody du jour may be)
;; Another 8.5 problem is that the outer frame for the default button persists even when MCL doesn't
;; draw it - so it remains if one changes the default button. This file fixes that too. 
;; see the method set-default-button.

;;The original version from Mirus has been modified by akh@tiac.net to do radio buttons as well and dtrt when mouse click in an
;; item and then drag outside etc, etc. Doesn't add new classes - the originals should work. Thanks Chris.
;; Colors that work for button-dialog-item in OS 8.5 are :frame :text and :body - the body color is a subrectangle within
;;    the button.The :frame color does not affect the bigger outline for a default button in 8.5 whereas it does in prior OS versions.
;;   for check-box-dialog-item :frame :body and :text
;;   for radio-button-dialog-item :frame :body and :text
;;   for scroll-bar-dialog-item just :frame 
;; We didn't (won't) fold this into the release because it may have some performance impact when you don't
;;  use colors. I'm not sure whether the impact would be significant. Nah - just include it.
;; It's also possible that this will cease to work in some OS version newer than 8.5.
;; Maybe the old color functionality will even return in some future OS version. 
;; The basic approach here is that there are a bunch of :after methods that overdraw the colored parts with
;; desired colors after the OS has drawn them as it sees fit in it's brain damaged state.

;; delete some unused code
;; ------- 5.2b6
;; #_drawstring => grafport-write-unicode - say eol vs #\newline and btw this whole file is probably not used
;; ------ 5.1b4
;; use add-pascal-upp-alist-cfm - try macho
;; don't say moveto :word
;; use with-periodic-task-mask if timer in view-click-event-handler for button and control ??
;; ---- 5.1 final
;; use bevel-button for 3d-button - nah it's ugly on OSX
;; omit colors for check-box and radio-button if disabled
;; simplify  check-box and radio-button for text and body colors, from Terje N.
;; lose calls to appearance-available-p
;; add body-color for radio-button too
;; fix view-click-event-handler for default button in subview
;; change to test code at bottom of file
;; add body-color for check-box-dialog-item - lost it somewhere
;; --------- 5.1b2
;; 12/02/03 timer stuff
;; view-click-event-handler for buttons on OSX contained in subview?? - undo fix - was wrong
;; get rid of bad-button..., colored button text looks better
;; looks like multiline button text now works - so needs-redraw returns nil
;; ---------- 5.0 final
;; akh redraw-color-dialog-item for button - use needs-redraw vs. dont-throb - two separate issues
;;---------- 4.4b2
;; 05/25/01 see "sick of" re osx for check-box and radio-button - 
;; do some with buttons too - kind of ugly - multiline text is also busted in OSX
;; 05/12/01 akh lose the set-default-button redef if carbon
;; 12/06/99 akh check-box and radio-button don't turn text black during #_trackcontrol
;; 10/12/99 forget with-focused-dialog item (it's useless re clipping) - use with-font-focused-view instead
;; 10/10/99 akh button-dialog-item with body color is prettier, use appearance-available-p vs 8.5
;; ----------- 4.3f1c1
;; 02/24/99 akh some fixnum decls, tweak for some positions to do "round up" vs truncate, do 8.5-or-later-p once at startup
;; 02/20/99 akh fix for #\newline - don't ignore color, fix for item-height not = text-height - text is centered vertically
;; 02/19/99 akh fix for big fonts, if text contains #\newline ignore color

(in-package :ccl)

(defvar *check-box-size* #@(16 16))
#| ;; function of default-font can't be right?
  (let* ((d (make-instance 'check-box-dialog-item :dialog-item-text ""))
         (size (view-default-size d)))
    (make-point (point-v size)(point-v size))))
|#

(defvar *radio-button-size* #@(16 16))
#|
  (let* ((d (make-instance 'radio-button-dialog-item :dialog-item-text ""))
         (size (view-default-size d)))
    (make-point (point-v size)(point-v size))))
|#




     



(eval-when (:compile-toplevel :load-toplevel :execute)

(defparameter handle->dialog-item (make-hash-table :weak :value))

#+ignore
(add-pascal-upp-alist 'control-color-proc
                      #'(lambda (procptr)(#_NewControlColorUPP procptr)))

(add-pascal-upp-alist-macho 'control-color-proc "NewControlColorUPP")

(defpascal control-color-proc (:pointer ControlHandle
                               :word Message ; sInt16
                               :word DrawDepth
                               :Boolean isColorDev
                               :word)
    (let ((view (gethash Controlhandle handle->dialog-item)))
      (when view
        (if 
        (case message
          (#.#$kControlMsgSetupBackground
           (view-setup-background view drawdepth iscolordev))
          (#.#$kControlMsgApplyTextColor ;; appearance 1.1
           (view-apply-text-color view drawdepth iscolordev)))
        #$noErr
        #$paramErr))))
)

(defmethod view-click-event-handler ((item control-dialog-item) where  &aux ok)
  (let ((handle (dialog-item-handle item)))
    (if *timer-interval*
      (with-periodic-task-mask ($ptask_event-dispatch-flag t)
        (with-timer
          (setq ok (#_TrackControl handle where (%null-ptr)))))
      (setq ok (#_TrackControl handle where (%null-ptr)))))
  (if (neq ok 0) (dialog-item-action item)(progn (redraw-color-dialog-item item))))




(defmethod view-click-event-handler ((item button-dialog-item) where
                                     &aux ok)
  (let ((handle (dialog-item-handle item)))
    ;; need to fix this - doesn't always work in apropos-dialog?? - seems OK now??
    (if (and #|(osx-p)|# (default-button-p item) (neq (view-container item) (view-window item)))
      (setq where (convert-coordinates where (view-container item)(view-window item))))
    (if *timer-interval*
      (with-periodic-task-mask ($ptask_event-dispatch-flag t)
        (with-timer
          ;(cerror "a" "b")
          (setq ok (#_TrackControl handle where (%null-ptr)))))
      (setq ok (#_TrackControl handle where (%null-ptr)))))
  (when (dont-throb item)(maybe-draw-default-button-outline item))
  (if (neq ok 0) (progn (dialog-item-action item))(progn (redraw-color-dialog-item item))))





(defmethod install-view-in-window :after ((item check-box-dialog-item) window &aux (handle (dialog-item-handle item)))
  (declare (ignore window))
  (when handle
    (setf (gethash handle handle->dialog-item) item)
    (#_SetControlColorProc handle control-color-proc))
  (if (check-box-checked-p item) (check-box-check item)))




(defmethod install-view-in-window :after ((item radio-button-dialog-item) window &aux (handle (dialog-item-handle item)))
  (declare (ignore window))
  (when handle
    (setf (gethash handle handle->dialog-item) item)
    (#_SetControlColorProc handle control-color-proc)))

(defmethod view-setup-background ((item dialog-item) depth color-p)
  (let ((background-color (or (part-color item :back)(part-color item :body))))
    (when (dialog-item-enabled-p item)
      (cond
       (background-color
        (#_SetThemeBackground #$kThemeBrushWhite Depth color-p) ; hack to allow overriding the theme brush with custom color
        (with-rgb (rec background-color)
          (#_rgbBackColor rec))
        T)))))

(defmethod view-apply-text-color ((item dialog-item) depth color-p)
  (declare (ignore depth))
  (when (dialog-item-enabled-p item)
    (when color-p
      (let ((color (part-color item :text)))
        (when color
          (with-rgb (rec color)
            (#_rgbForeColor rec))
          T)))))


(defmethod view-draw-contents ((item check-box-dialog-item))
  (when (installed-item-p item)
    (call-next-method)))

(defmethod check-box-check ((item check-box-dialog-item))
  (setf (check-box-checked-p item) t)
  (when (installed-item-p item)
    (with-focused-dialog-item (item)
      (progn ;without-the-text-if-osx item
        (#_setcontrolvalue (dialog-item-handle item) 1)))))
      

(defmethod check-box-uncheck ((item check-box-dialog-item))
  (setf (check-box-checked-p item) nil)
  (when (installed-item-p item)
    (with-focused-dialog-item (item)
      (progn ;without-the-text-if-osx item
        (#_setcontrolvalue (dialog-item-handle item) 0)))))



(defmethod view-draw-contents ((item radio-button-dialog-item))
  (when (installed-item-p item)
    (call-next-method)))

(defmethod dialog-item-action ((item button-dialog-item))
  (let* ((body-color (part-color item :body))
         (text-color (part-color item :text))
         (frame-color (part-color item :frame)))                                      
    (when (and (or body-color text-color frame-color (needs-redraw item)))
      (redraw-color-dialog-item item))
    (call-next-method)))

(defmethod dialog-item-enable :after ((item button-dialog-item))
  (when (installed-item-p item)
    (redraw-color-dialog-item item)))

  
;; redefs of things in dialogs.lisp

(defmethod radio-button-push ((item radio-button-dialog-item)
                              &aux (cluster (radio-button-cluster item)))
  (let ((my-container (view-container item))
        (handle (dialog-item-handle item)))
    (when my-container
      (do-dialog-items (other-item my-container 'radio-button-dialog-item)
        (if (neq other-item item)
          (if (eq (radio-button-cluster other-item) cluster)
            (radio-button-unpush other-item))))
      (when (and handle (installed-item-p item))
        (radio-button-really-push item)))
    (setf (radio-button-pushed-p item) t)))

(defmethod radio-button-really-push ((item radio-button-dialog-item))
  (with-focused-dialog-item (item (view-container item))
    (progn ;without-the-text-if-osx item
      (#_setcontrolvalue (dialog-item-handle item) 1))))
      

(defmethod radio-button-unpush ((item radio-button-dialog-item))
  (let ((handle (dialog-item-handle item)))
    (when (and handle (installed-item-p item))
      (with-focused-dialog-item (item)
        (progn ;without-the-text-if-osx item
          (#_setcontrolvalue (dialog-item-handle item) 0))))
    (setf (radio-button-pushed-p item) nil)))

; Color Check Box
; These methods provide for color text for check box dialog items under the MacOS Platinum appearance
; Manager, since the stupid appearance manager turns off all the colors. Note that the check box itself
; remains black. Only the text color is changed. (Now the frame color may also change)
; This was written for our convenience, and I haven't had time
; to do everything to make the dialogs completely the way they were before. But for most purposes, I expect this
; should be fine. It's been tested under a few conditions, but I cannot promise that there might not be some
; instance where it might fail.


(defmethod view-draw-contents :after ((item control-dialog-item))
  (redraw-color-dialog-item item))
 


(defmethod redraw-color-dialog-item ((item check-box-dialog-item))
  (when (and (dialog-item-enabled-p item)(window-active-p (view-window item)))
    (let ((frame-color (part-color item :frame)))
      ; (ed-beep) (print body-color)
      (when (or frame-color)
        (with-font-focused-view item  ;; with-focused-dialog-item gets the font right but doesn't clip, with-focused-view doesn't do font but does clip
          (let ((size (view-size item))
                (position #@(0 0))) ;(view-position item)))
            (let* ((cb-size *check-box-size*)
                   (delta (half-round-up (the fixnum (- (the fixnum (point-v size))(the fixnum (point-v cb-size)))))))
              ;(truncate (the fixnum (- (the fixnum (point-v size))(the fixnum (point-v cb-size)))) 2)))
              (setq position (make-point 0 delta))
              (rlet ((rect :rect))
                (rset rect :rect.topleft position)
                (rset rect  :rect.botright (add-points position cb-size))
                (with-fore-color frame-color
                  (#_insetrect rect 2 2)
                  (#_framerect rect))))))))))

#| ;; a test
(make-instance 'window
  :theme-background T
  :view-subviews
  (list
   (make-instance 'check-box-dialog-item 
        :view-position #@(20 40)
        :view-font '("chicago" 18 :srccopy)  ;; too bad default mode is :srcor
        :dialog-item-text "Check
It out" 
        :part-color-list `(:text ,*yellow-color* :body ,*blue-color* :frame ,*red-color*))))
|#

(defmethod check-box-check :after ((item check-box-dialog-item))
  (let ((text-color (part-color item :text))
        (frame-color (part-color item :frame))
        (body-color (part-color item :body)))
    (when (and (or frame-color text-color body-color) )
      (redraw-color-dialog-item item))))

(defmethod check-box-uncheck :after ((item check-box-dialog-item))
  (let ((text-color (part-color item :text))
        (frame-color (part-color item :frame))
        (body-color (part-color item :body)))
    (when (and (or frame-color text-color body-color) )
      (redraw-color-dialog-item item))))

(defmethod dialog-item-enable :after ((item check-box-dialog-item))
  (when (installed-item-p item)
    (with-focused-dialog-item (item)
      (view-draw-contents item))))

(defmethod dialog-item-disable :after ((item check-box-dialog-item))
  (when (installed-item-p item)
    (with-focused-dialog-item (item)
      (view-draw-contents item))))
          
;;; color radio button

(defmethod redraw-color-dialog-item ((item radio-button-dialog-item))
  (when (and (dialog-item-enabled-p item)(window-active-p (view-window item)))    
    (let ((frame-color (part-color item :frame)))
      (when frame-color      
        (with-font-focused-view item
          (let* ((size (view-size item))
                 (position #@(0 0)))            
            (when (and frame-color )
              (let* ((rb-size *radio-button-size*)
                     (delta (half-round-up (- (point-v size)(point-v rb-size))))) ; (truncate (- (point-v size)(point-v rb-size)) 2)))
                (setq position (add-points position (make-point 0 delta)))
                (rlet ((rect :rect))
                  (rset rect :rect.topleft position)
                  (rset rect  :rect.botright (add-points position rb-size))
                  (with-fore-color frame-color
                    (#_insetrect rect 2 2)
                    (#_frameoval rect)))))))))))

(defmethod radio-button-push :after ((item radio-button-dialog-item))
  (let ((text-color (part-color item :text))
        (frame-color (part-color item :frame))
        (body-color (part-color item :body)))
    (when (and (or frame-color text-color body-color) )
      (redraw-color-dialog-item item))))

(defmethod radio-button-unpush :after ((item radio-button-dialog-item))
  (let ((text-color (part-color item :text))
        (frame-color (part-color item :frame))
        (body-color (part-color item :body)))
    (when (and (or frame-color text-color body-color) )
      (redraw-color-dialog-item item))))

(defmethod dialog-item-enable :after ((item radio-button-dialog-item))
  (when (installed-item-p item)
    (with-focused-dialog-item (item)
      (view-draw-contents item))))

(defmethod dialog-item-disable :after ((item radio-button-dialog-item))
  (when (installed-item-p item)
    (with-focused-dialog-item (item)
      (view-draw-contents item))))  


; Color Button
; These methods provide for color for the body of button dialog items under the MacOS Platinum appearance
; Manager. In this case, the color of the button isn't really changed. What happened is a colored rectangle is
; drawn over the body of the button. This way, the button retains it's pseudo-3D look, but is still able to
; communicate color information. The button itself is supposed to look like the types of buttons on some types of
; equiptment which had colors painted on them. I like to think it looks reasonably attractive and yet stays
; consonant with the Platinum look. This was written for our convenience, and I haven't had time
; to do everything to make the dialogs completely the way they were before. But for most purposes, I expect this
; should be fine. It's been tested under a few conditions, but I cannot promise that there might not be some
; instance where it might fail.


(defmethod needs-redraw ((item button-dialog-item))
  (and  nil (osx-p)
       (let ((text (dialog-item-text item)))
         (and text (position #\newline text)))))


;; this makes the colored body box at least as big as the text and draws text with back-color - much prettier
(defmethod redraw-color-dialog-item ((item button-dialog-item))
  (when (and (dialog-item-enabled-p item))
    (let* ((body-color (part-color item :body))
           (text-color (part-color item :text))
           (frame-color (part-color item :frame))
           (needs-redraw-p (needs-redraw item)))
      (when (or body-color text-color frame-color needs-redraw-p)
        
        (with-font-focused-view item
          (multiple-value-bind (ff ms)(view-font-codes item)
            (let* ((size (view-size item))
                   (text-height (font-codes-string-height (dialog-item-text item) ff ms))
                   (height-delta (half-round-up (- (the fixnum (point-v size)) text-height)))
                   ) 
              (declare (fixnum text-height height-delta))
              (when (or body-color needs-redraw-p)
                (let* ((v-adjust (ash (point-v size) -2)) ;(truncate (point-v size) 4))
                       (h-adjust v-adjust)
                       (text-width (font-codes-string-width-with-eol (dialog-item-text item) ff ms))
                       (width-delta (ash (- (the fixnum (point-h size)) text-width) -1))
                       (box-width (max text-width (- (point-h size) (ash h-adjust 1))))
                       (box-height (max text-height (- (point-v size) (ash v-adjust 1))))
                       (top (min v-adjust height-delta))
                       (bottom (+ top box-height))
                       (left  (min h-adjust width-delta))
                       (right (+ left box-width)))
                  (declare (fixnum v-adjust h-adjust text-width width-delta box-width box-height left right top bottom))
                  (simple-color-fill-rect  (or body-color *lighter-gray-color*)
                                           left top right bottom)))
              (when frame-color
                (rlet ((rect :rect :topleft 0 :botright size))  ;item-rect (rect item)
                  (with-fore-color frame-color
                    (#_frameroundrect rect 8 8))))
              (when (or body-color text-color needs-redraw-p)
                (progn ;multiple-value-bind (a d w l)(font-codes-info ff ms)
                 ; (declare (ignore w d l))
                 ; (declare (fixnum a))
                  ;; we redraw the text in the right color precisely (i hope) on top of the text
                  ;; that was previously drawn in the wrong color or that may have been wiped out by
                  ;; the body color above
                  (let* ((text-pos (make-point 0 height-delta)))
                    (with-font-codes ff (logior (ash #$srccopy 16) (logand ms #xffff))  ;; loses some black bits
                      
                      (with-back-color (or body-color *lighter-gray-color*)
                        (with-fore-color (or text-color *black-color*)
                          (draw-multi-line-centered-text item text-pos))))))))
            ))))))
;; N positive fixnum
(defun half-round-up (n)
  (declare (fixnum n))
  (ash (the fixnum (1+ n)) -1))



(defun simple-color-fill-rect (color left top right bottom)
  ;(declare (ignore item))
  (rlet ((rect :rect))
    (rset rect :rect.topleft (make-point left top))
    (rset rect  :rect.botright (make-point right bottom))
    (with-fore-color color
      (#_paintrect rect))))



;; for other subclasses - eg Eric Russells appearance manager stuff
(defmethod redraw-color-dialog-item ((item control-dialog-item))
  nil)



(defmethod view-activate-event-handler :after ((item scroll-bar-dialog-item))
  (redraw-color-dialog-item item))

(defmethod redraw-color-dialog-item ((item scroll-bar-dialog-item))
  (let ((frame-color (part-color item :frame)))
    (when (and frame-color )
      (with-focused-dialog-item (item)
        (with-item-rect (rect item)
          (with-fore-color frame-color
            (#_framerect rect)))))))

(defmethod view-click-event-handler :after ((item scroll-bar-dialog-item) where)
  (declare (ignore where))
  (redraw-color-dialog-item item))

;; the innards of view-draw-text for 3d-button


(defun draw-multi-line-centered-text (item text-pos)
  (multiple-value-bind (ff ms)(view-font-codes item)
    (let* ((pc (part-color item :text))
           (curstr (dialog-item-text item))
           ;(ascent (font-codes-info ff ms))
           ;(topleft (subtract-points text-pos (make-point 0 ascent)))
           )
      (rlet ((rect :rect :topleft text-pos :botright (add-points text-pos (view-size item))))
        (draw-string-in-rect curstr rect
                             :justification :center
                             :ff ff :ms ms :color pc)))))


;; not used currently - now is -see below
(defun font-codes-string-width-and-height (string ff ms)
  (multiple-value-bind (width nlines)(font-codes-string-width-with-eol string ff ms)
    (values width (the fixnum (* (the fixnum nlines) (the fixnum (font-codes-line-height ff ms)))))))

(defun font-codes-string-height (string ff ms)
  ;; this counts a trailing eol but I think the OS does too
 (nth-value 1 (font-codes-string-width-and-height string ff ms)))
  



;; blech - text still in wrong place
(def-ccl-pointers disizes ()
  (if (osx-p)
    (progn (setq *check-box-size* #@(18 18))
           (setq *radio-button-size* #@(18 18)))
    (progn (setq *check-box-size* #@(16 16))
           (setq *radio-button-size* #@(16 16)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; use bevel-button for 3d-button - the OS9 bevel-button is much closer to the desired appearance than OSX bevel-button (sigh) - so forget it


#|
(eval-when (:compile-toplevel :load-toplevel :execute)
(require :appearance-utils "ccl:examples;appearance-manager-folder;appearance-utils") ;; why need all these??
(require :appearance-manager "ccl:examples;appearance-manager-folder;appearance-manager")
(require :new-control-dialog-item "ccl:examples;appearance-manager-folder;new-control-dialog-item")
(require :bevel-button-dialog-item "ccl:examples;appearance-manager-folder;bevel-button-dialog-item")
)


(defclass 3d-button (default-button-mixin bevel-button-dialog-item)
  ((pushed-state :initform nil :accessor pushed-state)
   ;; not really used but creators provide it
   (frame-p :initform nil :initarg :frame-p :accessor frame-p))) 

(defmethod dont-throb ((button 3d-button)) t)

(defmethod view-click-event-handler ((item 3d-button) where)
  
  (declare (ignore where))
  (call-next-method))

(defmethod view-draw-contents :before ((item 3d-button))
  )

(defmethod view-draw-contents ((item 3d-button))
  (call-next-method))  
|#      
 
#|   

(defun ctest ()
;; in osx it doesnt work to set-part-color from nil to something after the fact for check-box and radio
(setq w (make-instance 'window :window-title "Colors"
                       :window-show nil
                       :view-subviews 
                       (list (setq d(make-instance 'button-dialog-item :dialog-item-text "foo
baqres" :part-color-list `(:body ,*blue-color*)
                                                   :default-button t :view-size #@(60 44)))
                             (setq c (make-instance 'check-box-dialog-item :dialog-item-text "FFF
tbd"
                                                    :view-font '("chicago" 24 :srccopy))))))

(set-part-color d :body *yellow-color*)
(set-part-color d :text *pink-color*)
(set-part-color d :frame  *orange-color*)
(set-part-color c :text *green-color*)
(set-part-color c :body *yellow-color*)

(setq e (make-instance 'radio-button-dialog-item :view-container w :dialog-item-text "asd
fqq" :view-font '("chicago" 24 :srccopy)))

(set-part-color e :text *green-color*)
(set-part-color e :frame *green-color*)

(set-part-color c :frame *green-color*)
(window-show w))
(ctest)
|#





