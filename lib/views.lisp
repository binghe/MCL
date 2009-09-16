;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  6 8/25/97  akh  one arg point<=
;;  5 7/4/97   akh  see below
;;  4 6/9/97   akh  see below
;;  3 6/2/97   akh  see below
;;  4 3/9/96   akh  probably no change
;;  2 10/17/95 akh  merge patches
;;  3 2/2/95   akh  dont remember
;;  (do not edit before this line!!)

;;views.lisp
; Copyright 1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.
 
;; Modification History
;;
;; call-with-focused-dialog-item of simple-view is woi
;; --------5.2b6
;; call-with-theme-state-preserved less aggressive??
;; call-with-back-color, call-with-fore-color call-with-fore-and-back-color use with-theme-state-preserved
;; add macro with-theme-state-preserved
;; call-with-fore-color doesn't mess with theme stuff - now it does again - ugh
;; ------ 5.2b5
;; lose use of the #_offsetrgn :rgn ... feature
;; set-view-position - don't do #_eraserect
;;  ------ 5.1b3
;; 08/31/04 undo change to unfocus-view
;; 08/29/04 set-view-size, position, and container - fetch container inside woi
;; unfocus-view does #_qdflushportbuffer
;; view-focus-and-draw-contents gets the right clip and visrgns - many thanks to Takehiko Abe!
;; with-fore-and-back-color modification
;; undo change to set-view-size for window
;; window-prior-theme-drawing-state is actual state vs T - might come in handy
;; with-fore and back-color moved here
;; v-d-c of theme-background-view uses window-prior-theme-drawing-state
;; fix set-view-size for window with back-color and not theme-background, remove some #-carbon-compat
;; 06/28/04 set-view-position invalidates what it erases
;; 06/28/04 set-view-position for simple-view focuses on container
;; fix bug in below, and do it old way on OS9 (I dunno why)
;; view-clip-region for simple-view includes corners
;; set-view-size and position for simple-view handle live resize better?? -
;; v-d-c theme-background-view uses with-macptrs, don't call invalidate-grow-icon
;; move theme-background-view here
;; fix invalidate-region from Toomas Altosaar (wish I knew why needed!)
;; ------ 5.1b2
;; compute-view-region accounts for view-corners - from Terje N.
;; ------ 5.1b1
;; invalidate-region move woi to before fetching wptr -  from toomas altosaar
;; --------- 5.0 final
;; carbon-compat stuff
;; -------------- 4.3 release
;; akh add stuff to defer view-mouse-enter... till window is drawn
; 08/20/99 akh set-view-container - if view = *mouse-view* and new container nil set *mouse-view* nil
;--------- 4.3f1c1
; 07/05/97 akh point<= with one arg doesn't choke on big points 
; 06/17/97 akh  tweak invalidate-corners for negative max - can't possibly matter
; 06/02/97 akh  remove-subviews deals with scroll-bar being gone already because the scrollee is gone.
; 04/29/97 bill invalidate-corners protects itself against points whose coords don't fit
;               in 16 bits.
; ------------- 4.1f1
; 09/16/96 bill Add commented out version of focus-view that repositions the pen.
; ------------- 4.0b1
; 07/21/96 bill invalidate-region moves the part of the window's update region that is not part
;               of its invalid region into its erase region. This ensures that newly exposed areas
;               of the window get erased to set their background color.
; ------------- MCL-PPC 3.9
; 11/21/95 bill start eliminating explicit mactypes from trap calls.
; 3/16/95 slh  view-origin: tolerates nil position (for set-focus in set-default-size&pos)
;------------- 3.0d17
; view-focus-and-draw-contents for simple-view do ala dialog-item 
; - check that view itself needs drawing - factor out common test
; discard-all-subviews not used
; make set-view-position work if backpattern and views parts do not fill his box
; invalidate-region - re window-invalid-region - the #_sectrgn had a coordinate mismatch
; set-bordered-view-size not used
; in set-view-container - if she moves from one container to another in same window, dont remove
;   from window. Makes split-pane more peaceful.
;invalidate-resized-view-border does less if height unchanged - makes resize fred-dialog-items prettier
;------------
;11/15/93 bill set-view-scroll-position scrolls the window-erase-region
;              and window-invalid-region
;10/14/93 bill invaldate-region now corrects for the coordinate system
;              of the window.visrgn. This prevents some unwanted flashing
;              in some cases when invalidating with no erasure.
;------------- 3.0d13
;07/06/93 bill  Make invalidate-resized-view-border & (method view-clip-region (simple-view))
;               work on views with null size or position.
;-------------- 3.0d12
;11/18/92 alice view-click-event-handler for view calls next method if where not in a subview
;		view-draw-contents for view also does call-next-method
;		also view-activate and view-deactivate-event-handler
;02/11/93 bill no more third arg to invalidate-grow-icon
;09/18/92 bill Duncan Smith's patch to view-contains-point-p
;06/01/92 bill unfocus-view becomes part of the focus-view protocol
;04/24/92 bill No more (#_SetOrigin 0 0) in focus-view
;------------- 2.0
;02/22/92 gb   Move (re-)initialization of *TEMP-RGN*, *TEMP-RGN-2*, *EMPTY-RGN*, 
;              *SIMPLE-VIEW-CLIP-REGION* to l1-init.
; ------------ 2.0f2c5.
;01/07/92 gb   don't require RECORDS.
;10/25/91 bill set-view-scroll-position needed to invalidate-view if scroll-visibly was nil
; ------------ 2.0b4
;10/21/91 bill (method find-clicked-subview (null t)), (method view-contains-point-p (window t)),
;              flet -> let in find-view-containing-point
;10/16/91 bill handle symbol-macros correctly in with-[font-]focused-view
;10/29/91 alice def-load-pointers => def-ccl-pointers
;09/13/91 bill with-font-focused-view
;09/03/91 bill initialization of *setgworld-available?* moves to l1-windows.
;08/26/91 bill :pointer -> :ptr, indentation
;              focus-view is generic and uses set-gworld
;08/24/91 gb   use new trap syntax.
;08/08/91 bill call view-(de)activate-event-handler after set-view-container.
;              Also, handle refocus-view differently.
;08/06/91 bill focus-view no longer defaults the font-view parameter.
;07/26/91 bill view-default-size methods move to l1-windows.
;07/25/91 bill invalidate-region & validate-region update window-invalid-region
;07/21/91 gb   LET vice FLET in WITH-FOCUSED-VIEW.
;07/18/91 bill point<= for use with help-manager.
;06/17/91 bill CALL-WITH-FOCUSED-VIEW expects a function of one argument, the view.
;              CALL-WITH-FOCUSED-VIEW generates one without using DOWNWARD-FUNCTION
;              FOCUS-VIEW takes an optional FONT-VIEW parameter.
;------------- 2.0b2
;06/05/91 bill focus-view honors view-font-codes
;05/13/91 bill find-view-containing-point searches all windows if view is NIL.
;03/18/91 bill window-update-cursor calls new generic function: find-clicked-subview
;----------- 2.0b1
;02/01/91 bill add regions-overlap-p to view-focus-and-draw-contents for simple-view
;01/08/91 bill preserving-update-region now uses the new traps package.
;01/04/91 bill Don't remove-view-from-window in set-view-container unless necessary.
;12/28/90 bill remove view-focusable-p: make it in-line in focus-view (save space).
;11/07/90 bill Don't allow focusing on da-windows.  They may close mysteriously.
;10/24/90 bill Simplify set-view-container by making install-view-in-window
;              and remove-view-from-window do lots of the work.
;10/16/90 bill check for null window-erase-region
;10/01/90 bill view-origin-slot, view-clip-region-slot, remove commented out code.
;09/25/90 bill brain-damage in regions-overlap-p
;09/12/90 bill nix find-named-subview.
;08/16/90 bill Remove commented out old clip-region maintenance mechanism.
;08/13/90 bill something-to-draw? -> regions-overlap-p, discard-all-subviews
;08/08/90 bill Warning: _InvalRgn, _InvalRect, _ValidRgn, _ValidRect ignore the
;              clip region: CCL doesn't.
;08/01/90 bill invalidate-view-border
;07/06/90 bill in set-view-level: need to redraw container, not just view.
;              Change view-contains-point-p to take point in coords of parent.
;07/05/90 bill nix wptr-if-bound
;07/04/90 bill view-draw-contents: draw backwards so that clicking works as
;              expected when subviews overlap.
;06/28/90 bill view-click-event-handler now calls point-in-click-region-p
;06/04/90 bill with-focused-view expands into call-with-focused-view.
;              remove bogus _EraseRgn from (method set-view-size (simple-view t))
;05/24/90 bill window-size -> view-size
;05/24/90 bill window-mouse-position is extinct
;05/01/90 bill window-size-parts does adjust-view-region
;04/30/90 gb   use %word-to-int, %iasr.
;04/30/90 bill compute-view-region used view-scroll-position at a time when
;              it wasn't valid.  Do the computation in-line instead.
;04/26/90 bill view-allocate-clip-region.
;04/23/90 bill Add view-convert-coordinates-and-click to view-click-event-handler
;04/12/90 bill fix (in)validate-view for windows.
;04/10/90  gz  view-default-size.
;              Removed redundant window set-view-position (defined in l1-windows).
;04/03/90 bill set-bordered-view-size
;03/28/90 bill set-view-size & set-view-position do nothing if set to current value
;03/26/90 bill add invalidate-corners & validate-corners.
;03/08/90 bill in set-view-container: can't invalidate-view until its
;              container is set.
;02/15/90 bill in remove-subviews: view-subview typo => view-container.
;01/30/90 bill add-subviews
;12/29/89 bill Converted to CLOS.  Reduced consing.
;04-dec-89 as  set-view-container checks clip-region before using it
;02-dec-89 as  don't error when focusing an uninstalled view
;              set-view-container restores subviews properly
;              set-view-container doesn't lose view-scroll-position
;              set-view-size calls general adjust-view-region
;10-nov-89 as  fix to find-view-containing-point
;25-oct-89 jaj fixed some bugs in set-view-container
;17-oct-89 as  no more port-restoral guarantee :-(
;              set-view-scroll-position takes optional 'scroll-visibly' arg
;4-oct-89  as  with-focused-view guarantees port restoral
;              subviews clip to container
;31-aug-89 as  set sub-views containers to nil before changing own container
;28-aug-89 as  (focus-view nil) sets port to fred's junk port
;8-aug-89  as  with-focused-view checks for necessity
;6-aug-89  jaj (focus-view nil) no longer sets port to WMgrPort
;30-jun-89 as  fixed bug in set-view-container
;18-jun-89 as  punted window-[de]activate-event-handler, window-draw-contents
;18-jun-89 as  window-[de]activate-event-handler [de]activates subviews
;23-may-89 as  architectural change
;17-may-89 as  view-container is a function, returns view-container-iv
;14-Mar-89 jaj view-subviews changed to be a vector
;12/5/88  jaj new file


; in-package doesn't work in level-1
;(in-package :ccl)



(defmacro with-focused-view (view &body body &environment env)
  (let ((sym (if (and view (symbolp view) (eq view (macroexpand view env)))
               view
               (gensym)))
        (fn (gensym)))
    `(let ((,fn #'(lambda (,sym)
                    (declare (ignore-if-unused ,sym))
                   ,@body)))
       (declare (dynamic-extent ,fn))
       (call-with-focused-view ,view ,fn))))

(defmacro with-font-focused-view (view &body body &environment env)
  (let ((sym (if (and view (symbolp view) (eq view (macroexpand view env)))
               view
               (gensym)))
        (fn (gensym)))
    `(let (,@(unless (eq view sym)
               `((,sym ,view)))
           (,fn #'(lambda (,sym)
                    (declare (ignore-if-unused ,sym))
                   ,@body)))
       (declare (dynamic-extent ,fn))
       (call-with-focused-view ,sym ,fn ,sym))))

#-ignore
(defmethod unfocus-view (view next-view next-font-view)
  (declare (ignore view next-view next-font-view)))

;; probably pointless and makes things flashier
#+ignore
(defmethod unfocus-view (view next-view next-font-view)
  (declare (ignore next-view next-font-view))
  (when view
    (let ((wptr (wptr view)))
      (when (and wptr (osx-p))
        (when (ok-wptr wptr)
          (with-port-macptr port
            (#_QDFlushPortBuffer port (%null-ptr))))))))

(defmethod focus-view :around (view &optional font-view)
  (without-interrupts
   (unfocus-view *current-view* view font-view)
   (call-next-method)))

(defmethod focus-view ((view da-window) &optional font-view)
  (declare (ignore font-view))
  (focus-view nil))

(defmethod focus-view ((null null) &optional font-view
                       &aux (wptr %temp-port%))  
  (set-gworld-from-wptr wptr)
  (when font-view
    (multiple-value-bind (ff ms) (view-font-codes font-view)
      (when ff
        (set-wptr-font-codes wptr ff ms))))
  (setq *current-font-view* font-view)
  (setq *current-view* nil))

#|
; This version should properly reposition the pen, but it
; seemed flaky in my simple tests - Bill
(defmethod focus-view ((view simple-view) &optional font-view &aux wptr)
  (if (setq wptr (wptr view))
    (let* ((org (view-origin view)))
      (set-gworld wptr)
      (rlet ((pt :long))
        (#_GetPen pt)
        (#_LocalToGlobal pt)
        (#_SetOrigin (point-h org) (point-v org))
        (#_GlobalToLocal pt)
        (#_MoveTo (%get-word pt) (%get-word pt 2)))
      (let ((vcr (view-clip-region view)))
        (and vcr (#_SetClip vcr)))
      (when font-view
        (multiple-value-bind (ff ms) (view-font-codes font-view)
          (when ff
            (set-wptr-font-codes wptr ff ms))))
      (setq *current-font-view* font-view)
      (setq *current-view* view))
    (focus-view nil font-view)))
|#

(defmethod focus-view ((view simple-view) &optional font-view &aux wptr)
  (if (setq wptr (wptr view))
    (let* ((org (view-origin view)))      
      (set-gworld-from-wptr wptr)
      (#_SetOrigin (point-h org) (point-v org))
      (let ((vcr (view-clip-region view)))
        (and vcr (#_SetClip vcr)))
      (when font-view
        (multiple-value-bind (ff ms) (view-font-codes font-view)
          (when ff
            (set-wptr-font-codes wptr ff ms))))
      (setq *current-font-view* font-view)
      (setq *current-view* view))
    (focus-view nil font-view)))

; Make simple-views behave properly mod focus-view
(defmethod view-origin ((view simple-view))
  (let ((container (view-container view)))
    (if container
      (let ((position (view-position view))
            (container-origin (view-origin container)))
        (if position
          (subtract-points container-origin position)
          container-origin))
      #@(0 0))))

(defmethod view-subviews ((view simple-view))
  #())

; Note: since this returns a global variable, make sure you'll never need it
; to live beyond another call to view-clip-region for a simple-view.
; Many types of simple-view's can shadow view-focus-and-draw-contents to
; avoid needing to compute a clip region (use the container's clip region).
(defmethod view-clip-region ((view simple-view))
  (when (wptr view)    
    (multiple-value-bind (pos br)(view-corners view)
      (let* ((rgn *simple-view-clip-region*)
             (container (view-container view))
             (container-rgn (view-clip-region container)))
        (if nil ;(or (null pos) (null size))
          (#_EmptyRgn rgn)
          (let* ((pos-h (point-h pos))
                 (pos-v (point-v pos)))              
            (#_setrectrgn rgn pos-h pos-v (point-h br)(point-v br))
            (#_SectRgn rgn container-rgn rgn)
            (#_OffsetRgn rgn (- pos-h) (- pos-v))))
        rgn))))

;; doing this the old way fixes resize of apropos-dialog on OS9???

(defun old-view-clip-region (view)  
  (when (wptr view)
    (let* ((pos (view-position view))
           (size (view-size view))
           (rgn *simple-view-clip-region*)
           (container (view-container view))
           (container-rgn (view-clip-region container)))
      (if (or (null pos) (null size))
        (#_EmptyRgn rgn)
        (let* ((pos-h (point-h pos))
               (pos-v (point-v pos))
               (size (view-size view))
               (size-h (point-h size))
               (size-v (point-v size)))
          (#_setrectrgn rgn pos-h pos-v (+ pos-h size-h) (+ pos-v size-v))
          (#_SectRgn rgn container-rgn rgn)
          (#_OffsetRgn rgn (- pos-h) (- pos-v))))
      rgn)))


(defmethod simple-view-p ((view view)) nil)
(defmethod simple-view-p ((view simple-view)) t)

; Expects to be called when the view-origin slot is valid

#|
(defmethod compute-view-region ((view view) rgn container)
  (when rgn
    (if container
      (let* ((origin (view-origin-slot view))
             (container-origin (view-origin container))
             (tl (add-points (view-position view)
                             (subtract-points origin container-origin)))
             (br (add-points tl (view-size view)))
             (offset (subtract-points container-origin origin))
             (offset-h (point-h offset))
             (offset-v (point-v offset))
             (container-region (view-clip-region container)))
        (#_SetRectRgn rgn (point-h tl) (point-v tl) (point-h br) (point-v br))
        (#_OffsetRgn rgn offset-h offset-v)
        (#_SectRgn rgn container-region rgn)
        (#_OffsetRgn rgn (- offset-h) (- offset-v)))
      (#_SetRectRgn rgn -32767 -32767 32767 32767)))
   rgn)
|#

;; from Terje N.
(defmethod compute-view-region ((view view) rgn container)
  (when rgn
    (if container
     (multiple-value-bind (topleft bottomright) (view-corners view)
      (let* ((origin (view-origin-slot view))
             (container-origin (view-origin container))
             (tl (add-points topleft
                             (subtract-points origin container-origin)))
             (br (add-points tl (- bottomright topleft)))
             (offset (subtract-points container-origin origin))
             (offset-h (point-h offset))
             (offset-v (point-v offset))
             (container-region (view-clip-region container)))
        (#_SetRectRgn rgn (point-h tl) (point-v tl) (point-h br) (point-v br))
        (#_OffsetRgn rgn offset-h offset-v)
        (#_SectRgn rgn container-region rgn)
        (#_OffsetRgn rgn (- offset-h) (- offset-v))))
      (#_SetRectRgn rgn -32767 -32767 32767 32767)))
   rgn)

(defmethod add-subviews ((view view) &rest subviews)
  (declare (dynamic-extent subviews))
  (dolist (subview subviews)
    (set-view-container subview view)))

(defmethod remove-subviews ((view view) &rest subviews)
  (declare (dynamic-extent subviews))
  (dolist (subview subviews)
    (unless (or (eq view (view-container subview))
                (and (typep subview 'scroll-bar-dialog-item)
                     (null (view-container subview))
                     (memq (scroll-bar-scrollee subview) subviews)))
      (cerror "ignore and continue." "~s is not a subview of ~s."
              subview view))
    (set-view-container subview nil)))

(defmethod discard-all-subviews ((view view) &optional shrink-p)
  (if shrink-p
    (setf (slot-value view 'view-subviews)
          (make-array 1 :adjustable t :fill-pointer 0))
    (setf (fill-pointer (view-subviews view)) 0))
  (invalidate-view view t))


; If container is nil, removes view from container
; Note: The dialog code depends on the fact that the view-container slot is
; changed AFTER the WPTR is changed.
(defmethod set-view-container ((view simple-view) new-container)
  (without-interrupts
   (let ((old-container (view-container view)))
     (when (neq new-container old-container)    
       (when new-container
         (setq new-container (require-type new-container 'view))
         (when (or (eq new-container view)
                   (view-contains-p view new-container))
           (error "Attempt to make ~s contain itself." view)))
       (let* ((new-window (and new-container (view-window new-container)))
              (old-window (and old-container (view-window old-container)))
              (current-view *current-view*)
              (current-font-view *current-font-view*))
         (when old-container
           (invalidate-view view t)
           (when (eq view current-view)
             (focus-view nil))
           (setf (slot-value old-container 'view-subviews)
                 (delete view (view-subviews old-container) :test #'eq))
           (when (and (wptr view)(not (eq new-window old-window)))
             (remove-view-from-window view))
           (set-view-container-slot view nil))
         (when (and (null new-container)(eq *mouse-view* view))(setq *mouse-view* nil))
         (when new-container
           (let ((siblings (view-subviews new-container))
                 (container-wptr (wptr new-container)))
             (vector-push-extend view siblings)
             (set-view-container-slot view new-container)
             (when container-wptr
               (let ()
                 (when (not (eq new-window old-window))
                   (install-view-in-window view new-window))
                 (invalidate-view view)
                 (when (eq view current-view)
                   (focus-view view current-font-view))
                 (if (window-active-p new-window)
                   (view-activate-event-handler view)
                   (view-deactivate-event-handler view))))))))))
  new-container)

; Note: It's important here that a view's WPTR gets set before its subview's
; WPTR's and that it gets cleared (set to NIL) after its subview's WPTR's.
; Otherwise (:method (setf wptr) (t dialog-item)) won't work.
(defmethod view-allocate-clip-region ((view window))
  (let ((rgn (view-clip-region-slot view)))
    (or rgn
        (setf (view-clip-region-slot view) (#_NewRgn)))))

(defvar *view-class* (find-class 'view))

(defmethod install-view-in-window :before ((view simple-view) window)
  (when (wptr view)
    (error "Attempt to set the wptr for a view that already has one"))
  (when (inherit-from-p view *view-class*)
    (setf (view-clip-region-slot view) (#_NewRgn))
    (setf (view-valid view) (cons nil (view-valid (view-container view)))))
  (setf (wptr view) (wptr window)))

(defmethod install-view-in-window ((view simple-view) window)
  (declare (ignore window)))

(defmethod install-view-in-window ((view view) window)
  (dovector (subview (view-subviews view))
    (install-view-in-window subview window)
    ))

(defmethod remove-view-from-window ((view view))
  (dovector (subview (view-subviews view))
    (remove-view-from-window subview)))

(defmethod remove-view-from-window ((view simple-view))
  )

(defmethod remove-view-from-window :after ((view simple-view))
  (unless (wptr view)
    (error "Attempt to nullify an already null view wptr"))
  (setf (wptr view) nil)
  (when (inherit-from-p view *view-class*)
    (let ((rgn (view-clip-region-slot view)))
      (when rgn
        (setf (view-clip-region-slot view) nil)
        (#_DisposeRgn rgn)))
    (setf (view-valid view) nil)))

; view-corners returns two values: the topleft & bottomright corners of
; it's visible bounding box in its parents coordinate system.
(defmethod view-corners ((view simple-view))
  (let ((pos (view-position view))
        (size (view-size view)))
    (if (numberp pos)
      (unless (numberp size)
        (setq size #@(0 0)))
      (setq pos #@(0 0) size #@(0 0)))
    (values pos (add-points pos size))))

(defmethod view-corners ((view window))
  (values #@(0 0) (view-size view)))

(defun inset-corners (inset topleft bottomright)
  (values (add-points inset topleft) (subtract-points bottomright inset)))  

(defmethod invalidate-view-border ((view simple-view) &optional 
                                   erase-p right-and-bottom-only)
  (when (wptr view)
    (let* ((container (or (view-container view) view))
           (ul (view-position view))
           (lr (add-points ul (view-size view)))
           (ul-h (point-h ul))
           (ul-v (point-v ul))
           (lr-h (point-h lr))
           (lr-v (point-v lr)))
      (multiple-value-bind (bul blr) (view-corners view)
        (unless (and (eql ul bul) (eql lr blr))
          (with-focused-view container
            (without-interrupts
             (let* ((rgn *temp-rgn*)
                    (rgn2 *temp-rgn-2*)
                    (bul-h (point-h bul))
                    (bul-v (point-v bul))
                    (blr-h (point-h blr))
                    (blr-v (point-v blr))
                    rgn-ul-h rgn-ul-v)
               (if right-and-bottom-only
                 (setq rgn-ul-h ul-h rgn-ul-v ul-v)
                 (setq rgn-ul-h bul-h rgn-ul-v bul-v))
               (#_SetRectRgn rgn rgn-ul-h rgn-ul-v blr-h blr-v)
               (#_SetRectRgn rgn2 ul-h ul-v lr-h lr-v)
               (#_DiffRgn rgn rgn2 rgn)
               #-carbon-compat
               (#_InvalRgn rgn)
               #+carbon-compat
               (inval-window-rgn (wptr view) rgn)
               (when erase-p
                 (let ((org (view-origin container))
                       (erase-rgn (window-erase-region (view-window container))))
                   (when erase-rgn
                     (unless (eql #@(0 0) org)
                       (#_OffsetRgn rgn (- (point-h org)) (- (point-v org))))
                     (#_UnionRgn rgn erase-rgn erase-rgn))))))))))))

;; not called today
#+ignore
(defmethod invalidate-resized-view-border ((view simple-view) new-size)
  (when (and (wptr view) (view-size view) (view-position view))
    (let* ((container (or (view-container view) view))
           (ul (view-position view))
           (lr (add-points ul (view-size view)))
           (nlr (add-points ul new-size))
           nblr)
      (multiple-value-bind (bul blr) (view-corners view)
        (unless (and (eql ul bul) (eql lr blr))
          (setq nblr (add-points nlr (subtract-points blr lr)))
          (with-focused-view container
            (without-interrupts
             (let* ((rgn *temp-rgn*)
                    (rgn2 *temp-rgn-2*)
                    (left (point-h ul))
                    (far-left (point-h bul))
                    (right (point-h lr))
                    (far-right (point-h blr))
                    (top (point-v ul))
                    (far-top (point-v bul))
                    (bottom (point-v lr))
                    (far-bottom (point-v blr))
                    (new-right (point-h nlr))
                    (new-far-right (point-h nblr))
                    (new-bottom (point-v nlr))
                    (new-far-bottom (point-v nblr))
                    (min-bottom (min bottom new-bottom))
                    (max-far-bottom (max far-bottom new-far-bottom))
                    (min-right (min right new-right))
                    (max-far-right (max far-right new-far-right))
                    (bottom-edge-left (if (eql bottom new-bottom)
                                        (min far-right new-far-right)
                                        far-left)))               
               (#_SetRectRgn rgn right far-top far-right far-bottom)  ; right edge
               (#_SetRectRgn rgn2 bottom-edge-left bottom far-right far-bottom) ; bottom edge
               (#_UnionRgn rgn rgn2 rgn)
               (unless (eql bottom new-bottom)
                 (#_SetRectRgn rgn2 far-left min-bottom left max-far-bottom) ;left edge delta
                 (#_UnionRgn rgn rgn2 rgn))
               (#_SetRectRgn rgn2 min-right far-top max-far-right top) ; top edge delta
               (#_UnionRgn rgn rgn2 rgn)
               #-carbon-compat
               (#_InvalRgn rgn)
               #+carbon-compat
               (inval-window-rgn (wptr view) rgn)
               (let ((org (view-origin container))
                     (erase-rgn (window-erase-region (view-window container))))
                 (when erase-rgn
                   (unless (eql #@(0 0) org)
                     (let ((offset (subtract-points #@(0 0) org)))
                       (#_OffsetRgn rgn (point-h offset)(point-v offset))))
                   (#_UnionRgn rgn erase-rgn erase-rgn)))
               (#_SetRectRgn rgn new-right far-top new-far-right new-far-bottom) ; new right
               (#_SetRectRgn rgn2 bottom-edge-left new-bottom new-far-right new-far-bottom) ; new bottom
               (#_UnionRgn rgn rgn2 rgn)
               #-carbon-compat
               (#_InvalRgn rgn)
               #+carbon-compat
               (inval-window-rgn (wptr view) rgn)))))))))

(defmethod invalidate-view ((view window) &optional erase-p)
  (let* ((ul (view-origin view))
         (lr (add-points ul (view-size view))))
    (invalidate-corners view ul lr erase-p)))

(defmethod invalidate-view ((view simple-view) &optional erase-p)
  (when (wptr view)
    (multiple-value-bind (topleft bottomright) (view-corners view)
      (let ((container (view-container view)))
        (unless container
          (setq container view)
          (unless (typep view 'window)
            (let ((pos (view-position view)))
              (setq topleft (subtract-points topleft pos)
                    bottomright (subtract-points bottomright pos)))))
        (invalidate-corners container topleft bottomright erase-p)))))  

(defmethod invalidate-corners ((view simple-view) topleft bottomright &optional
                               erase-p)
  (without-interrupts
   (let* ((rgn *temp-rgn*)
          (left (min 32767 (max #x-8000 (point-h topleft))))
          (top (min 32767 (max #x-8000 (point-v topleft))))
          (right (min 32767 (max #x-8000 (point-h bottomright))))
          (bottom (min 32767 (max #x-8000 (point-v bottomright)))))
     (#_SetRectRgn rgn left top right bottom)
     (invalidate-region view rgn erase-p))))


(defmethod invalidate-region ((view simple-view) region &optional erase-p)
  (without-interrupts
   (let* ((wptr (wptr view)))
     (when wptr
       (let* ((window (view-window view))
              (view-clip-region (and window (view-clip-region view))))    
         (when (and window view-clip-region)
           (with-focused-view view         
             (let* ((rgn *temp-rgn*)
                    (update-rgn *temp-rgn-2*)
                    ;; (window (view-window view)) ;; redundant - but why did it cause a problem????
                    (invalid-rgn (window-invalid-region window))
                    (org (view-origin view))
                    (offset (unless (eql #@(0 0) org) (subtract-points (view-origin window) org))))
               (#_SectRgn region view-clip-region rgn)
               (let ((erase-rgn (window-erase-region window)))
                 (when erase-rgn
                   (when offset (#_offsetrgn rgn (point-h offset)(point-v offset))) ; to window coords
                   (when erase-p
                     (#_UnionRgn rgn erase-rgn erase-rgn))                   
                   (get-window-updatergn wptr update-rgn)
                   (let ((offset (subtract-points #@(0 0) (view-position window))))
                     (#_OffsetRgn update-rgn (point-h offset)(point-v offset)))
                   (when invalid-rgn
                     (#_DiffRgn update-rgn invalid-rgn update-rgn))
                   (#_UnionRgn update-rgn erase-rgn erase-rgn))
                 (when offset
                   (let ((now-offset (subtract-points #@(0 0) offset)))
                     (#_offsetrgn rgn (point-h now-offset)(point-v now-offset)))))
               (#_invalwindowrgn wptr rgn)
               (when invalid-rgn                 
                 (let ((rgn3 *temp-rgn-3*))
                   (get-window-visrgn wptr rgn3)
                   (#_sectrgn rgn3 rgn rgn))
                 ; view coordinates
                 (when offset (#_offsetrgn  rgn (point-h offset)(point-v offset)))  ; to window coords
                 (#_UnionRgn rgn invalid-rgn invalid-rgn))))))))))

#+ignore
(defmethod invalidate-region ((view simple-view) region &optional erase-p)
  (let ((wptr (wptr view)))
    (when wptr
      (with-focused-view view
        (without-interrupts
         (let* ((rgn *temp-rgn*)
                (update-rgn *temp-rgn-2*)
                (window (view-window view))
                (invalid-rgn (window-invalid-region window))
                (org (view-origin view))
                (offset (unless (eql #@(0 0) org) (subtract-points (view-origin window) org))))
           (#_SectRgn region (view-clip-region view) rgn)
           (let ((erase-rgn (window-erase-region window)))
             (when erase-rgn
               (when offset (#_offsetrgn  rgn (point-h offset)(point-v offset))) ; to window coords
               (when erase-p
                 (#_UnionRgn rgn erase-rgn erase-rgn))              
               (get-window-updatergn wptr update-rgn)
               (let ((offseta (subtract-points #@(0 0) (view-position window))))
                 (#_OffsetRgn update-rgn (point-h offseta)(point-v offseta)))
               (when invalid-rgn
                 (#_DiffRgn update-rgn invalid-rgn update-rgn))
               (#_UnionRgn update-rgn erase-rgn erase-rgn))
             (when offset 
               (let ((offseta (subtract-points #@(0 0) offset)))
                 (#_offsetrgn rgn (point-h offseta)(point-v offseta)))))
           (inval-window-rgn wptr rgn)
           (when invalid-rgn             
             (let ((rgn3 *temp-rgn-3*))
               (get-window-visrgn wptr rgn3)
               (#_sectrgn rgn3 rgn rgn))
               ; view coordinates
             (when offset (#_offsetrgn  rgn (point-h offset)(point-v offset)))  ; to window coords
             (#_UnionRgn rgn invalid-rgn invalid-rgn))))))))

(defmethod validate-view ((view simple-view))
  (when (wptr view)
    (multiple-value-bind (topleft bottomright) (view-corners view)
      (let ((container (view-container view)))
        (unless container
          (setq container view)
          (unless (typep view 'window)
            (let ((pos (view-position view)))
              (setq topleft (subtract-points topleft pos)
                    bottomright (subtract-points bottomright pos)))))
        (validate-corners container topleft bottomright)))))

(defmethod validate-corners ((view simple-view) topleft bottomright)
  (without-interrupts
   (let* ((rgn *temp-rgn*))
     (#_SetRectRgn rgn (point-h topleft)(point-v topleft) (point-h bottomright)(point-v bottomright))
     (validate-region view rgn))))

(defmethod validate-region ((view simple-view) region)
  (when (wptr view)
    (with-focused-view view
      (without-interrupts
       (let* ((rgn *temp-rgn*))
         (#_SectRgn region (view-clip-region view) rgn)         
         (#_validWindowRgn (wptr view) rgn)
         (let* ((window (view-window view))
                (erase-rgn (window-erase-region window))
                (invalid-rgn (window-invalid-region window))
                (org (view-origin view)))
           (unless (eql #@(0 0) org)
             (let ((offset (subtract-points (view-origin window) org)))
               (#_OffsetRgn rgn (point-h offset)(point-v offset)))) 
           (when erase-rgn
             (#_DiffRgn erase-rgn rgn erase-rgn))
           (when invalid-rgn
             (#_DiffRgn invalid-rgn rgn invalid-rgn))))))))

#|
(defmethod set-view-position ((view simple-view) h &optional v
                              &aux
                              (pt (make-point h v))
                              (container (view-container view))
                              (old-position (view-position view)))
  (unless (eql pt old-position)
    (without-interrupts
     (if (wptr view)
       (progn
         #-bccl  ; consistency check
         (unless container
           (error "~s has a wptr, but no container" view))
         (invalidate-view view t)
         (setf (slot-value view 'view-position) pt)
;         (view-move-origin view (subtract-points pt old-position) container)
         (invalidate-view view (maybe-erase view))  ; usually erase-p nil suffices
         (make-view-invalid view))
       (progn
         (setf (slot-value view 'view-position) pt)))))
  (refocus-view view)
  pt)
|#

(defmethod set-view-position ((view simple-view) h &optional v
                              &aux
                              (pt (make-point h v))
                              (old-position (view-position view)))
  (unless (eql pt old-position)
    (without-interrupts
     (if (wptr view)
       (let ((container (view-container view)))         
         (unless container
           (error "~s has a wptr, but no container" view))
         (with-focused-view container
           (if t ;(not (osx-p))
             (invalidate-view view t)
             (progn
               (invalidate-view view)
               (multiple-value-bind (tl br) (view-corners view)
                 (rlet ((rect :rect :topleft tl :botright br))
                   (#_eraserect rect)))))         
           (setf (slot-value view 'view-position) pt)
           (invalidate-view view (maybe-erase view))  ; usually erase-p nil suffices
           (make-view-invalid view)))
       (progn
         (setf (slot-value view 'view-position) pt)))))
  (refocus-view view)
  pt)

; makes a difference iff backpattern and view's parts do not fill the box
(defmethod maybe-erase ((view simple-view)) nil)

(defmethod maybe-erase ((view window)) nil)

(defmethod maybe-erase ((view view))
  (window-invalid-region (view-window view)))

;; if a window has a subview containing dialog-items
;; this sometimes doesn't work though does when
;; called from window-grow-event-handler - I'm confused
;; gotta focus in main method - already focused in window-grow...
(defmethod set-view-size ((w window) h &optional v &aux 
                          (new-size (make-point h v)))
  (unless (eql new-size (view-size w))
    (without-interrupts
     (set-view-size-internal w new-size)
     (make-view-invalid w)))
  (refocus-view w)
  #+ignore
  (when (and (not (theme-background-p w))
             (slot-value w 'back-color))
    (invalidate-view w t))
  new-size)


(defmethod set-view-size ((view simple-view) h &optional v &aux
                          (pt (make-point h v)))
  (unless (eql pt (view-size view))
    (without-interrupts
     (if (not (wptr view))
       (setf (slot-value view 'view-size) pt)
       (let ((container (view-container view)))
         #-bccl  ; consistency check
         (unless container
           (error "~S has a wptr, but no container." view))
         (let ((clip-region (view-clip-region view))
               (origin (view-origin view))
               (old-region *temp-rgn*)
               (temp-region *temp-rgn-2*))
           (#_CopyRgn clip-region old-region)
           (setf (slot-value view 'view-size) pt)
           (make-view-invalid view)
;           (adjust-view-region view clip-region container)
           (setq clip-region (view-clip-region view))   ; for simple-views
           (#_XorRgn clip-region old-region temp-region)
           (let ((offset (subtract-points (view-origin container) origin)))
             (#_OffsetRgn temp-region (point-h offset)(point-v offset)))
           (with-focused-view container             
             (#_invalWindowRgn (wptr view) temp-region)
             (let* ((window (view-window view))
                    (erase-rgn (window-erase-region window)))
               (when erase-rgn
                 (let ((offset (subtract-points (view-origin window)
                                                (view-origin container))))
                   (#_offsetrgn temp-region (point-h offset)(point-v offset)))
                 (#_UnionRgn erase-rgn temp-region erase-rgn)))))))))
  (refocus-view view)
  pt)




(defmethod window-size-parts :before ((w window))
  (make-view-invalid w))

; Sometimes a view has a border that needs to be erased when it is resized
; outer-border is the width of the border outside of the view.
; inner-border is the width of the border inside the view.
#| ; not used
(defmethod set-bordered-view-size ((view simple-view) new-size outer-border
                                   &optional (inner-border 0)
                                   &aux (old-size (view-size view))
                                   (container (view-container view)))
  (setf (slot-value view 'view-size) new-size)
  (unless (or (eql new-size old-size) (null container))
    (without-interrupts
     (make-view-invalid view)
     (let* ((ob (make-point outer-border outer-border))
            (pos (subtract-points (view-position view) ob))
            (offset-pos (add-points pos (add-points ob ob)))
            (old-end (add-points offset-pos old-size))
            (new-end (add-points offset-pos new-size))
            (old-reg *temp-rgn*)
            (new-reg *temp-rgn-2*))
       (rlet ((new-rect :rect :topleft pos :bottomright new-end))
         (#_SetRectRgn :ptr old-reg 
                       :long pos
                       :long (subtract-points old-end ob))
         (#_RectRgn new-reg new-rect)
         (#_XorRgn old-reg new-reg new-reg)
         ; Add the right & bottom edges to the region.
         (let ((left (point-h pos))
               (top (point-v pos))
               (right (point-h old-end))
               (bottom (point-v old-end)))
           (#_SetRectRgn old-reg left (- bottom outer-border inner-border) right bottom)
           (#_UnionRgn new-reg old-reg new-reg)
           (#_SetRectRgn old-reg (- right outer-border inner-border) top right bottom)
           (#_UnionRgn new-reg old-reg new-reg))
          (with-focused-view container
           (#_InvalRgn new-reg)
           (#_InvalRect new-rect))
         (let* ((window (view-window view))
                (erase-reg (window-erase-region window))
                (offset (subtract-points (view-origin window)
                                         (view-origin container))))
           (when erase-reg
             (unless (eql #@(0 0) offset)
               (#_OffsetRgn :ptr new-reg :long offset))
             (#_UnionRgn erase-reg new-reg erase-reg)))))))
  new-size)
|#

(defun refocus-view (view)
  (when (eq view *current-view*)
    (setq *current-view* nil)
    (focus-view view *current-font-view*)))

(defmethod set-view-scroll-position ((w window) h &optional v scroll-visibly)
  (declare (ignore h v scroll-visibly))
  (without-interrupts
   #+ignore
   (with-focused-view w
     (invalidate-grow-icon w t))
   (call-next-method)
   (refocus-view w)
   #+ignore
   (with-focused-view w
     (invalidate-grow-icon w nil))))
#| ; original
(defmethod set-view-scroll-position ((view view) h &optional v (scroll-visibly t)
                                     &aux
                                     (pt (make-point h v))
                                     (container (view-container view))
                                     delta
                                     (old-sc-pos (view-scroll-position view))
                                     (wptr (wptr view)))
  "h and v are in view's coordinates"
  (without-interrupts
   (when wptr
     (with-focused-view view
       (setq delta (subtract-points old-sc-pos pt))
       (unless (eql delta #@(0 0))
         (if scroll-visibly
           (let* ((rgn *temp-rgn*))
             (if container
               (rlet ((r :rect
                         :topleft old-sc-pos
                         :bottomright (add-points old-sc-pos (view-size view))))
                 (#_ScrollRect :ptr r :long delta :ptr rgn)
                 (#_InvalRgn rgn))
               (progn
                 (#_ScrollRect :ptr (rref wptr windowrecord.portrect) :long delta :ptr rgn)
                 (#_InvalRgn rgn))))
           (invalidate-view view t))))
     (make-view-invalid view))
   (setf (view-scroll-position view) pt)
   (refocus-view view))
  pt)
|#
;; some of the new stuff was formerly done by %scroll-screen-rect in l1-edfrec.
(defmethod set-view-scroll-position ((view view) h &optional v (scroll-visibly t)
                                     &aux
                                     (pt (make-point h v)))
  "h and v are in view's coordinates"
  (without-interrupts
   (let ((container (view-container view))
         delta
         (old-sc-pos (view-scroll-position view))
         (wptr (wptr view)))
     (when wptr       
       (with-focused-view view
         (setq delta (subtract-points old-sc-pos pt))
         (unless (eql delta #@(0 0))
           (if scroll-visibly
             (let* ((rgn *temp-rgn*)
                    (window (view-window view))
                    (erase-rgn (window-erase-region window))
                    (invalid-rgn (window-invalid-region window))
                    (view-rgn (and (or erase-rgn invalid-rgn)
                                   (view-clip-region view)))
                    (size (view-size view)))
               (if container
                 (rlet ((r :rect
                           :topleft old-sc-pos
                           :bottomright (add-points old-sc-pos size)))
                   (#_ScrollRect  r (point-h delta)(point-v delta)  rgn)                 
                   (#_invalWindowRgn wptr rgn)
                   (when view-rgn
                     (let ((offset (subtract-points #@(0 0) (view-origin view))))
                       (#_OffsetRgn view-rgn (point-h offset)(point-v offset)))))
                 (progn                
                   (rlet ((arect :rect))
                     (#_getwindowportbounds wptr  arect)
                     (#_scrollrect arect (point-h delta)(point-v delta)  rgn))                 
                   (#_invalWindowRgn wptr rgn)))
               (when view-rgn
                 (when (and erase-rgn (not (#_EmptyRgn erase-rgn)))
                   (#_CopyRgn erase-rgn rgn)
                   (#_SectRgn rgn view-rgn rgn)
                   (#_DiffRgn erase-rgn rgn erase-rgn)
                   (#_OffsetRgn rgn (point-h delta)(point-v delta))
                   (#_SectRgn rgn view-rgn rgn)
                   (#_UnionRgn rgn erase-rgn erase-rgn))
                 (when (and invalid-rgn (not (#_EmptyRgn invalid-rgn)))
                   (#_CopyRgn invalid-rgn rgn)
                   (#_SectRgn rgn view-rgn rgn)
                   (#_DiffRgn erase-rgn rgn invalid-rgn)
                   (#_OffsetRgn rgn (point-h delta)(point-v delta))
                   (#_SectRgn rgn view-rgn rgn)
                   (#_UnionRgn rgn invalid-rgn invalid-rgn))))
             (invalidate-view view t))))
       (make-view-invalid view))
     (setf (view-scroll-position view) pt)
     (refocus-view view)))
  pt)

(defmethod view-scroll-position ((view simple-view))
  #@(0 0))

(defmethod view-click-event-handler ((view view) where)
  (unless
    (do* ((subviews (view-subviews view))
          (i (1- (the fixnum (length subviews))) (1- i))
          subview)
         ((< i 0) nil)
      (declare (fixnum i))
      (setq subview (aref subviews i))
      (when (point-in-click-region-p subview where)
        (view-convert-coordinates-and-click subview where view)
        (return t)))
    (call-next-method)))

(defmethod point-in-click-region-p ((view simple-view) where)
  (view-contains-point-p view where))

(defmethod view-convert-coordinates-and-click ((view view) where container)
  (view-click-event-handler view (convert-coordinates where container view)))

(defmethod view-convert-coordinates-and-click ((view simple-view) where container)
  (declare (ignore container))
  (view-click-event-handler view where))

(defmethod find-clicked-subview ((view view) where)
  (do* ((subviews (view-subviews view))
        (i (1- (the fixnum (length subviews))) (1- i))
        subview)
       ((< i 0) view)
    (declare (fixnum i))
    (setq subview (aref subviews i))
    (when (point-in-click-region-p subview where)
      (return (find-clicked-subview
               subview (convert-coordinates where view subview))))))

(defmethod find-clicked-subview ((view simple-view) where)
  (declare (ignore where))
  view)

(defmethod find-clicked-subview ((view null) where)
  (let ((check-window
         #'(lambda (w)
             (when (point-in-click-region-p w where)
               (return-from find-clicked-subview
                 (find-clicked-subview w (subtract-points where (view-position w))))))))
    (declare (dynamic-extent check-window))
    (map-windows check-window :include-windoids t)
    nil))

(defmethod view-activate-event-handler ((view view))
  (dovector (v (view-subviews view))
    (view-activate-event-handler v))
  (call-next-method))

(defmethod view-deactivate-event-handler ((view view))
  (dovector (v (view-subviews view))
    (view-deactivate-event-handler v))
  (call-next-method))

#|
(defmethod view-draw-contents ((view view) &aux 
                               (wptr (wptr view)))
  (when wptr
    (with-temp-rgns (visrgn cliprgn)
      (progn
        (get-window-visrgn wptr visrgn)
        (get-window-cliprgn wptr cliprgn)
        (dovector (subview (view-subviews view))
          (view-focus-and-draw-contents subview visrgn cliprgn))))
    (call-next-method)))
|#

(defmethod view-draw-contents ((view view) &aux 
                               (wptr (wptr view)))
  (when wptr    
    (dovector (subview (view-subviews view))
      (view-focus-and-draw-contents subview))
    (call-next-method)))


(defun regions-overlap-p (visrgn cliprgn)
  (or (null visrgn) (null cliprgn)
      (without-interrupts
       (let ((temp-rgn *temp-rgn*))
         (#_SectRgn visrgn cliprgn temp-rgn)
         (not (#_EmptyRgn temp-rgn))))))

(defun view-is-invalid-p (view visrgn cliprgn)
  (or (null visrgn)
      (null cliprgn)
      (multiple-value-bind (tl br) (view-corners view)
        (without-interrupts
         (let ((rgn *temp-rgn*))
           ; so *temp-rgn* belongs to us
           (#_SetRectRgn rgn (point-h tl)(point-v tl) (point-h br)(point-v br))
           (#_SectRgn rgn visrgn rgn)
           (#_SectRgn rgn cliprgn rgn)                   
           (not (#_EmptyRgn rgn)))))))

; This exists so that controls can draw themselves without focusing or testing
; for visibility.
#|
(defmethod view-focus-and-draw-contents ((view view) &optional visrgn cliprgn)
  (with-focused-view view
    (when (regions-overlap-p visrgn cliprgn)
      (view-draw-contents view))))
|#

(defmethod view-focus-and-draw-contents ((view view) &optional visrgn cliprgn)
  (declare (ignore visrgn cliprgn))
  (with-focused-view view
    (let ((wptr (wptr view)))
      (with-temp-rgns (visrgn cliprgn)
        (get-window-visrgn wptr visrgn)
        (get-window-cliprgn wptr cliprgn)
        (when (regions-overlap-p visrgn cliprgn)
          (view-draw-contents view))))))
#|
(defmethod view-focus-and-draw-contents ((view simple-view) &optional visrgn cliprgn)
;  (declare (ignore visrgn cliprgn))
  (with-focused-view (view-container view)
    (when (regions-overlap-p visrgn cliprgn)
      (view-draw-contents view))))
|#


(defmethod view-focus-and-draw-contents ((view simple-view) &optional visrgn cliprgn)
  (declare (ignore visrgn cliprgn))
  (with-focused-view (view-container view)
    (without-interrupts 
     (let ((wptr (wptr view)))
       (with-temp-rgns (visrgn cliprgn)
         (get-window-visrgn wptr visrgn)
         (get-window-cliprgn wptr cliprgn)
         (when (view-is-invalid-p view visrgn cliprgn)
           (view-draw-contents view)))))))


(defun convert-coordinates (point source-view destination-view)
  (add-points point
              (subtract-points (view-origin destination-view)
                               (view-origin source-view))))

(defun point<= (point &rest other-points)
  (declare (dynamic-extent other-points))
  (declare (list other-points))
  (cond ((null other-points)
          (require-type (point-h point) 'fixnum)
          (require-type (point-v point) 'fixnum)
         t)
        ((null (cdr other-points))
         (let ((p2 (car other-points)))
           (and (<= (the fixnum (point-h point)) (the fixnum (point-h p2)))
                (<= (the fixnum (point-v point)) (the fixnum (point-v p2))))))
        (t (let ((h (point-h point))
                 (v (point-v point)))
             (declare (fixnum h v))
             (dolist (p other-points t)
               (unless (and (<= h (the fixnum (setq h (point-h p))))
                            (<= v (the fixnum (setq v (point-v p)))))
                 (return nil)))))))         

(defmethod view-contains-point-p ((view simple-view) point)
  (let* ((position (view-position view))
         (size (view-size view))
         (ph (point-h position))
         (h (point-h point)))
    (declare (fixnum ph pv h v))
    (and (<= ph h)
         (let ((pv (point-v position))
               (v (point-v point)))
           (declare (fixnum pv v))
           (and 
            (<= pv v)
            (< h (the fixnum (+ ph (the fixnum (point-h size)))))
            (< v (the fixnum (+ pv (the fixnum (point-v size))))))))))

(defmethod view-contains-point-p ((view window) point)  
  (let ((rgn3 *temp-rgn-3*))
    (#_getwindowregion (wptr view) #$kwindowstructurergn rgn3)
    (#_PtInRgn point rgn3)))
    

(defmethod find-view-containing-point ((view null) h &optional v
                                       (direct-subviews-only nil))
  (let ((point (make-point h v)))
    (let ((check-window
           #'(lambda (w)
               (when (view-contains-point-p w point)
                 (return-from find-view-containing-point
                   (if direct-subviews-only
                     w
                     (find-view-containing-point 
                      w
                      (subtract-points point (view-position w)))))))))
      (declare (dynamic-extent check-window))
      (map-windows check-window :include-windoids t)
      nil)))                    

(defmethod find-view-containing-point ((view view) h &optional v
                                       (direct-subviews-only nil))
    (let* ((point (make-point h v))
           (subviews (view-subviews view)))
      (do ((i (%i- (length subviews) 1) (%i- i 1)))
          ((%i< i 0))
        (let ((subview (aref subviews i)))
          (when (view-contains-point-p subview point)
            (return-from find-view-containing-point
                         (if direct-subviews-only
                           subview
                           (find-view-containing-point
                            subview
                            (convert-coordinates point view subview)
                            nil
                            nil)))))))
    (unless direct-subviews-only view))

(defmethod find-view-containing-point ((view simple-view) h &optional v
                                       (direct-subviews-only nil))
  (declare (ignore h v))
  (unless direct-subviews-only view))

(defmethod view-contains-p ((view simple-view) contained-view)
  (declare (ignore contained-view))
  nil)

(defmethod view-level ((view simple-view))
  (let ((container (view-container view)))
    (if container
      (let ((siblings (view-subviews container)))
        (- (length siblings) 1 (position view siblings :test #'eq)))
      0)))

(defmethod set-view-level ((view simple-view) level)
  (without-interrupts
   (let ((container (view-container view)))
     (when container
       (let* ((siblings (view-subviews container))
              (cnt (length siblings))
              (new-pos (- cnt 1 level))
              (old-pos (position view siblings :test #'eq))
              (i old-pos))
         (when (or (< new-pos 0) (>= new-pos cnt))
           (error "Level out of range."))
         (cond ((eql new-pos old-pos)
                (return-from set-view-level level))
               ((< new-pos old-pos)
                (while (< new-pos i)
                  (setf (aref siblings i) (aref siblings (1- i)))
                  (decf i)))
               (t                        ; (> new-pos old-pos)
                (while (> new-pos i)
                  (setf (aref siblings i) (aref siblings (1+ i)))
                  (incf i))))
         (setf (aref siblings new-pos) view)
         (when container
           (invalidate-view container))))))
  level)

(defmethod view-bring-to-front ((view simple-view))
  (set-view-level view 0))

(defmethod view-send-to-back ((view simple-view))
  (let* ((container (view-container view))
         (siblings (and container (view-subviews container))))
    (when siblings
      (set-view-level view (1- (length siblings))))))

; Nick Names
(defmethod view-named (name (parent view))
  (dovector (subview (view-subviews parent))
    (if (eq name (view-nick-name subview))
      (return subview))))

(defmethod find-named-sibling ((view simple-view) name)
  (let ((container (view-container view)))
    (and container (view-named name container))))

(defmethod view-named (name (view simple-view))
  (find-named-sibling view name))

; This will be shadowed by user's views.
(defmethod view-cursor ((v simple-view) point)
  (let ((container (view-container v)))
    (if container
      (view-cursor container (convert-coordinates point v container))
      *arrow-cursor*)))

; User can shadow these to create mouse sensitive items.
(defmethod view-mouse-enter-event-handler ((v simple-view))
  )
(defmethod view-mouse-leave-event-handler ((v simple-view))
  )

(defvar *mouse-view* nil)

(defun view-common-ancestor (v1 v2)
  (and v1 v2
       (if (view-contains-p v1 v2)
         v1
         (do ((a v2 (view-container a)))
             ((or (null a) (view-contains-p a v1)) a)))))

(defun change-mouse-view (to &optional (from *mouse-view*))
  (setq *mouse-view* to)
  (let ((ancestor (view-common-ancestor from to))
        (between from))
    (loop
      (if (eq between ancestor)
        (labels ((enter (view ancestor)
                   (unless (eq view ancestor)
                     (enter (view-container view) ancestor)
                     (view-mouse-enter-event-handler view))))
          (enter to ancestor)
          (return))
        (progn
          (view-mouse-leave-event-handler between)
          (setq between (view-container between))))))
  to)

; replaces method in l1-windows.
(defmethod window-update-cursor ((w window) point)
  (let ((subview (find-clicked-subview w point))
        (mouse-view *mouse-view*))
    (unless (eq mouse-view subview)
      (change-mouse-view subview mouse-view))
    (set-cursor 
     (if subview
       (view-cursor subview (convert-coordinates point w subview))
       (window-cursor w)))))

(defmethod window-update-cursor ((w null) point)
  (declare (ignore point))
  (when *mouse-view*
    (change-mouse-view nil))
  (set-cursor *arrow-cursor*))

;;;;;;;;;; stuff to defer view-mouse-enter... till window is drawn
;;; happens during resume-application for windoids
;;; also fix so window-hide nukes *mouse-view* if contained in window.


(defmethod skipped-enter ((w window))
  (let ((val (view-get w :skipped-enter))) ;; its t nil or a view - view if delayed mouse enter, t if window shown, nil  once drawn
    (and val (neq val t) val)))

(defmethod first-show ((w window))
  (view-get w :skipped-enter))

(defmethod (setf skipped-enter) (val (w window))
    (view-put w :skipped-enter val))

(defmethod (setf first-show)(val (w window))
  (if (null val)
    (view-remprop w :skipped-enter)
    (view-put w :skipped-enter val)))

(defmethod view-mouse-enter-event-handler :around ((v simple-view)) 
  (let ((w (view-window v)))
    (if (and w (first-show w))
      (progn (setf (skipped-enter w) v))
      (call-next-method))))

(defmethod view-mouse-leave-event-handler :around ((v simple-view))
  (when (ok-wptr (wptr v))
    (let ((w (view-window v)))
      (when w
        (when (not (first-show w))
          (call-next-method))))))

(defmethod window-show :before ((w window))
  (when (not (window-shown-p w))
    (setf (first-show w) t)))

(defmethod window-hide :after ((w window))
  (when (and  *mouse-view* (eq (view-window *mouse-view*) w))
    (change-mouse-view nil)  ;; ?? will cause a view-mouse-leave...
    ;(setq *mouse-view* nil)
    ))

(defmethod view-draw-contents :after ((v window))
  (let ((skipped (skipped-enter v)))
    (setf (first-show v) nil)
    (when skipped (view-mouse-enter-event-handler skipped) 
          ;(setf (skipped-enter v) nil) ; redundant at the moment
          )))

;;;; end stuff to 



; In case you want to change a view's position and container simultaneously,
; the update region is made too big by the code above.  For purists, this
; macro exists (use it carefully, probably inside a without-interrupts).
; oh foo it's used in view-example. And what code above might we be talking about?
#-carbon-compat
(defmacro preserving-update-region (wptr &body body)
  (let ((rgn (gensym))
        (update-rgn (gensym)))
    `(let ((,rgn (require-trap #_NewRgn))
           (,update-rgn (rref ,wptr windowRecord.UpdateRgn)))
       (unwind-protect
         (progn
           (require-trap #_CopyRgn ,update-rgn ,rgn)
           ,@body)
         (require-trap #_CopyRgn ,rgn ,update-rgn)
         (require-trap #_DisposeRgn ,rgn)))))

#+carbon-compat
;; this is untested. It's only used in the view-example.
(defmacro preserving-update-region (wp &body body)
  (let ((wptr (gensym))
        (update-rgn (gensym))
        (another-rgn (gensym)))
    `(let ((,wptr ,wp))
       (with-temp-rgns (,update-rgn ,another-rgn)
         (unwind-protect
           (progn
             (get-window-updatergn ,wptr ,update-rgn)  ;; this is a copy of the updatergn before
             ,@body)
           (get-window-updatergn ,wptr ,another-rgn)
           (valid-window-rgn ,wptr ,another-rgn) ;; validate current
           (inval-window-rgn ,wptr ,update-rgn)  ;; invalidate what was there before
           )))))

(unless (assq 'preserving-update-region *fred-special-indent-alist*)
  (push '(preserving-update-region . 1) *fred-special-indent-alist*))

;; moved here from pop-up-menu.lisp

(export '(theme-background-view) "CCL")

#|
(defmethod theme-background ((w window))
  (window-theme-background w))
|#

(defmethod theme-background-p ((w window))
  (window-theme-background w))
  

(defclass theme-background-mixin ()
  ((view-theme-background :initform #$kThemeBrushModelessDialogBackgroundActive :initarg theme-background
                          :accessor theme-background)))

(defclass theme-background-view (theme-background-mixin view)())

#|
(defmethod theme-background-p ((view theme-background-view)) (theme-background view))
|#

(defmethod theme-background ((view simple-view)) nil)


;; this week it means does the view have a theme-background or is it in something that does
(defmethod theme-background-p ((v simple-view)) ;; huh
  (or (theme-background v)
      (theme-background (view-container v)) ;; not quite - what if the container doesn't but the window does?
      (if (view-window v)
        (window-theme-background (view-window v)))))


(defmethod view-draw-contents ((view theme-background-view))
  (let ((theme-background (theme-background view))
        (window (view-window view)))
    (if (and theme-background) ; (not (theme-background-p (view-window view))))  ;; ??  
      (progn 
        (if (eq theme-background t)(setq theme-background #$kThemeBrushModelessDialogBackgroundActive))
        (unwind-protect 
          (with-item-rect (rect view)
            (setf (window-theme-background window) theme-background)            
            (let* ((wptr (wptr view))
                   (depth (current-pixel-depth)))
              (#_setthemebackground theme-background depth (wptr-color-p wptr)) ;; 32 is depth, 
              (#_eraserect rect)
              (call-next-method)))
          (if (not (window-prior-theme-drawing-state window))
            (#_normalizethemedrawingstate))
          (setf (window-theme-background window) nil
                (window-prior-theme-drawing-state window) nil)))
      (call-next-method))))

;;; moved from color.lisp


(defun get-current-window ()
  ; (view-window *current-view*) ; would this suffice?
  (or (and *current-view* (view-window *current-view*))
      (with-port-macptr port
        (with-macptrs ((wptr (#_getwindowfromport port)))
          (window-object wptr)))))
  

(defmacro with-fore-color (color &body body &environment env)
  (let  ((fn (gensym))
         (my-color (gensym)))
    `(let ((,fn #'(lambda ()
                   ,@body))
           (,my-color ,color))
       (declare (dynamic-extent ,fn))
       (call-with-fore-color ,my-color ,fn))))

(defun call-with-fore-color (color function)
  (if (or (null color)(not *color-available*))
    (funcall function)
    (rlet ((old-fore :rgbcolor))
      (with-theme-state-preserved
        (unwind-protect
          (progn              
            (#_getforecolor old-fore)
            (with-rgb (rec color)
              (#_rgbforecolor rec))          
            (funcall function))
          (#_rgbforecolor old-fore))))))


(defmacro with-theme-state-preserved (&body body &environment env)
  (let  ((fn (gensym)))
    `(let ((,fn #'(lambda ()
                   ,@body)))
       (declare (dynamic-extent ,fn))
       (call-with-theme-state-preserved ,fn))))

(defun call-with-theme-state-preserved (fn)
  (let ((window (get-current-window)) ;(view-window *current-view*))
        (old-state nil))    
    (if (or (null window) ;; (typep window 'fred-window)  ;; if below ok we don't need this
            (not (window-theme-background window))  ;; ??
            (window-prior-theme-drawing-state window))
      (funcall fn)
      (unwind-protect
        (progn         
          (rlet ((old-statep :ptr))
            (#_getthemedrawingstate old-statep)
            (setq old-state (%get-ptr old-statep))
            (setf (window-prior-theme-drawing-state window) old-state)
            (#_normalizethemedrawingstate))          
          (funcall fn))
        (when old-state
          (#_setthemedrawingstate old-state t)
          (setf (window-prior-theme-drawing-state window) nil))))))


(defmacro with-back-color (color &body body &environment env)
  (let  ((my-color (gensym))
         (fn (gensym)))
    `(let ((,fn #'(lambda ()
                   ,@body))
           (,my-color ,color))
       (declare (dynamic-extent ,fn))
       (call-with-back-color ,my-color ,fn))))


(defun call-with-back-color (color function)
  (if (or (null color)(not *color-available*))
    (funcall function)
    (rlet ((old-back :rgbcolor))
      (with-theme-state-preserved  ;; do we need this? seems so, else table selected cells dont work
        (unwind-protect
          (progn           
            (#_getbackcolor old-back)
            (with-rgb (rec color)
              (#_rgbbackcolor rec))          
            (funcall function))
          (#_rgbbackcolor old-back)
          ))))) 


;; might be worth reinstating this - saves some song and dance
(defmacro with-fore-and-back-color (fore back &body body)
  (let  ((fn (gensym))
         (my-fore (gensym))
         (my-back (gensym)))
    `(let ((,fn #'(lambda ()
                   ,@body))
           (,my-fore ,fore)
           (,my-back ,back))
       (declare (dynamic-extent ,fn))
       (call-with-fore-and-back-color ,my-fore ,my-back ,fn))))

(defun call-with-fore-and-back-color (fore back function)
  (if (or (not *color-available*)(and (null fore)(null back)))
    (funcall function)
    (if (null back)
      (call-with-fore-color fore function)
      (if (null fore)
        (call-with-back-color back function)
        (rlet ((old-fore :rgbcolor)
               (old-back :rgbcolor))
          (with-theme-state-preserved
            (unwind-protect
              (progn
                (#_getforecolor old-fore)
                (#_getbackcolor old-back)
                (with-rgb (rec fore)
                  (#_rgbforecolor rec))
                (with-rgb (rec back)
                  (#_rgbbackcolor rec))
                (funcall function))
              (#_rgbforecolor old-fore)
              (#_rgbbackcolor old-back))))))))
            
  





#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
