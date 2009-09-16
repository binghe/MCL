; -*- Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  2 8/25/97  akh  probably nothing
;;  3 11/22/95 akh  set *hide-windows-on-suspend* true after map-windoids defined
;;  5 6/5/95   akh  focus she said
;;  5 6/5/95   akh  focus on window when calling window-xxx-event-handler
;;  3 2/24/95  slh  window-title-height
;;  (do not edit before this line!!)


;; windoids.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;; Modification History
;
; #+ignore some windoid-wdef stuff
; define-entry-point doesnt work today -not needed don't do it
;; ------ 5.1 final
;; one more carbon-compat in windoids
;; no mo windowdefproc if carbon
;; no mo old-style-windoids if carbon
; -------- 4.3
; 03/11/99 akh window-zoom-event-handler compensates for Rom bug
; 10/15/98 akh home-grown windoids return conditionally - thank you alanr!
; 10/12/98 akh initialize-instance - no more home grown windoids - fail in OS8.5
; 10/06/98 akh window-title-height tells the truth if wptr
; 10/07/96 bill make-windoid-wdef pushes the result on *windoid-wdef-handles*
;               windoid-wdef-handle-p checks for presence on *windoid-wdef-handles*
; ------------- 4.0b2
; 08/26/96 bill (method window-close :before (lisp-wdef-mixin)) doesn't attempt
;               to modify thw window's wptr if it is null or %null-ptr-p.
;               This fixes Dimitri Simos'es "Closed windoid bug".
; ------------- 4.0b1
; 07/26/96 bill #'windoid-wdef lap wrapper for PPC.
; 06/01/96 gb   un-comment the window-close method so no callbacks in GC.
; ---- 3.9
;; 03/26/96  gb  lowmem accessors.
;01/27/96 bill slh's fix for window-show-on-resume
;01/17/96 bill make work on PPC modulo calling the wdef during GC
;11/20/95 akh  set *hide-windows-on-suspend* true after map-windoids defined
;10/20/95 slh  disabled for PPC (no defpascal yet)
; 5/19/95 slh  window-hide-for-suspend, window-show-for-resume
; 5/12/95 slh  new fns: windoids, map-windoids
; 4/03/95 slh  methods from l1-windows.lisp; get-window-event-handler,
;               window-under moved there
;-------------- 3.0d18
; 2/24/95 slh  window-title-height method
;-------------- 3.0d17
;09/30/93 bill windoid-wdef-handler now preserves stack discipline if called
;              during GC. It worked before by pure luck.
;-------------- 3.0d13
;05/05/93 alice window-event-handler t in case none
;04/30/93 bill window-event-handler, get-window-event-handler
;------------- 2.1d5
;09/03/92 bill don't pass events to inactive windows.
;08/10/92 bill no longer need the :before method on window-close.
;              We can now call the WDEF during GC (which is exactly what
;              #_DisposeWindow does).
;05/15/92 bill Make the :window-type initarg do the obvious thing for windoids.
;04/21/92 bill invisible windows are no longer passed events from windoids.
;------------  2.0
;01/07/92 gb   don't require RECORDS.
;------------ 2.0b4
;11/15/91 gb   change window-show, window hide; nuke window-close per bill.
;------------ 2.0b3
;08/24/91 gb   use new trap syntax.
;08/21/91 bill WDEF works properly while garbage collecting.
;07/21/91 gb   different setf inverses defined elsewhere. Say pref.
;07/05/91 bill get rid of the ed-beep's
;06/08/91 bill add windowdefproc initarg.
;------------- 2.0b2
;04/03/91 bill view-key-event-handler protocol, toggle-blinkers, window-under
;----------- 2.0b1
;07/05/90 bill nix wptr-if-bound
;06/15/90 bill Respect the :window.GoAwayFlag
;06/13/90 bill (method window-close :before (lisp-wdef-mixin))
;05/24/90 bill make (setf %get-byte ...) and friends return the right value.
;              window-position & window-size -> view-position & view-size
;05/23/90 bill remove (defsetf %get-point ...)
;03/12/90 bill (defsetf %get-point ...)
;01/08/90 bill Add setf methods for %get-byte and friends.
;01/05/90 bill Convert to CLOS
;18-jun-89 as  window-activate-eh -> view-activate-eh
;25-apr-89 as  if-if-if -> case
;16-Mar-89 jaj New File

(in-package "CCL")

(defvar *windoid-wdef-handle* nil)

(defmethod windoid-p ((w windoid))
  t)

(defvar *use-old-style-windoids* nil)

(defmethod initialize-instance ((windoid windoid) &rest initargs &key 
                                (window-show t)
                                (window-type nil wt?)
                                ;(windowdefproc *windoid-wdef-handle*)
                                (windowdefproc
                                 (if (and window-type (eq window-type :windoid) *use-old-style-windoids*)
                                   #-carbon-compat
                                   *windoid-wdef-handle*
                                   #+carbon-compat
                                   (error "No old-style-windoids in Carbon")
                                   (#_getresource :WDEF #$kFloatingWindowDefinition))
                                 windowdefprocp)  ; 124
                                )
  (declare (dynamic-extent initargs))
  (declare (ignore-if-unused windowdefprocp))
  (if (and wt? window-type (not (memq window-type *windoid-types*)))
    (call-next-method)    
    (progn
      #+ignore
      (when wt?
        (loop (unless (remf initargs :window-type) (return))))
      (apply #'call-next-method windoid :window-show nil initargs)
      (let ((wptr (wptr windoid)))
        (when wptr                          ; may have failed
          #+ignore
          (when (and windowdefproc (not (%null-ptr-p windowdefproc)) #+carbon-compat nil)
            (rset wptr windowrecord.windowdefproc windowdefproc))
          #+carbon-compat
          (when (and windowdefprocp windowdefproc) (error "No mo user windowdefproc in Carbon ~s" windowdefproc))
          #+ignore
          (when (not (memq window-type '(:windoid-with-grow :windoid-with-zoom-grow :windoid-side-with-grow
                                         :windoid-side-with-zoom-grow)))
            (setf (slot-value windoid 'grow-icon-p) nil))
          (if window-show (window-show windoid)))))))

(defmethod view-default-size ((view windoid))
  #@(115 150))

(defmethod view-default-position ((view windoid))
  ;; in case the "title" bar is on de side
  #@(16 44))

(defmethod default-window-layer ((w windoid))
  0)

(defmethod window-menu-item ((w windoid))
  nil)

(defmethod window-select ((w windoid))
  (let ((wptr (wptr w)))
    (autoposition-show w wptr)
    (window-bring-to-front w)
    (reselect-windows)))

(defmethod set-window-layer ((w windoid) new-layer &optional include-invisibles)
  (if (<= new-layer 0)
    (if (window-shown-p w)
      (window-select w)
      (window-bring-to-front w))
    (set-window-layer-internal w new-layer include-invisibles))
  new-layer)

(defmethod window-show ((windoid windoid))
  (unless (window-shown-p windoid)
    (without-interrupts
     (call-next-method)
     (reselect-windows))))

(defmethod window-show-internal ((w windoid) wptr)
  (autoposition-show w wptr)
  (unless (da-or-modal-dialog-on-top-p)
    (reselect-windows)))                ; move to windoid layer

(defmethod window-hide ((windoid windoid))
  (when (window-shown-p windoid)
    (without-interrupts
     (if nil ;(not (osx-p))
       (#_ShowHide (wptr windoid) nil)
       (#_hidewindow (wptr windoid)))
     (reselect-windows)
     (set-window-layer windoid *windoid-count*))))

; Hide for application suspend event, remember to show on resume
(defmethod window-hide-for-suspend ((windoid windoid))
  (when (window-shown-p windoid)
    (setf (slot-value windoid 'show-on-resume-p) t)
    (window-hide windoid)))

(defmethod window-show-for-resume ((windoid windoid))
  (when (slot-value windoid 'show-on-resume-p)
    (window-show windoid)
    (setf (slot-value windoid 'show-on-resume-p) nil)))

#|
(defmethod window-close :before ((w lisp-wdef-mixin))
  (window-hide w)
  (let ((wptr (wptr w)))
    (when (and wptr (not (%null-ptr-p wptr)))
      #-carbon-compat
      (rset wptr 
            :windowrecord.WindowDefProc
            (rref %temp-port% :windowrecord.WindowDefProc)))))
|#

#+ignore
(eval-when (:execute :compile-toplevel #-bccl :load-toplevel)
  ;;messages to WDEF function
  (defconstant $wDraw 0)
  (defconstant $wHit 1)
  (defconstant $wCalcRgns 2)
  (defconstant $wNew 3)
  (defconstant $wDispose 4)
  (defconstant $wGrow 5)
  (defconstant $wDrawGIcon 6)
  
  ;;values returned by WDEF hit routine
  (defconstant $wNoHit 0)
  (defconstant $wInContent 1)
  (defconstant $wInDrag 2)
  (defconstant $wInGrow 3)
  (defconstant $wInGoAway 4)

  ;;windoid constants
  (defconstant $windoid-shadow-indent 3)
  (defconstant $windoid-title-bar-height 10)
  )


; This is what the ROM calls.
; It passes on to the defpascal below normally.
; During GC, it handles the $wHit message simply, and ignores the other two.
#-ppc-target
(defun windoid-wdef (&lap 0)
  (lap
    @lispA5
    (dc.w 0 0)
    @defpascal
    (dc.w 0 0)
    (sub.l ($ 4) sp)                    ; space for defpascal address
    (link a6 ($ 0))
    (equate _variation 12)
    (equate _wptr (+ _variation 2))
    (equate _message (+ _wptr 4))
    (equate _parameter (+ _message 2))
    (equate _return (+ _parameter 4))
    (movem.l #(a5 d0 a0) -@sp)
    (lea (^ @defpascal) a5)
    (move.l @a5 (a6 4))                 ; defpascal entry point
    (move.l -@a5 a5)                    ; Lisp's A5
    (if# (ne (tst.b (a5 $gcON)))
      (move.w (a6 _message) d0)
      (if# (ne (cmp.w ($ #.$wHit) d0))
        ; Maybe we should frame the strucRgn on a draw command
        (move.l ($ 0) (a6 _return))
       else#
        (sub.w ($ 2) sp)                ; result from _PtInRgn
        (spush (a6 _parameter))
        (move.l (a6 _wptr) a0)
        (spush (a0 #.(get-field-offset :windowrecord.strucrgn)))
        (dc.w #_PtInRgn)
        (if# (ne (tst.w sp@+))
          (move.l ($ #.$wInContent) (a6 _return))
          else#
          (move.l ($ #.$wNoHit) (a6 _return))))
      (movem.l sp@+ #(a5 d0 a0))
      (unlk a6)
      (add.l ($ 4) sp)
      (move.l sp@+ (sp 8))
      (lea (sp 8) sp)
      (rts)
     else#
      (movem.l sp@+ #(a5 d0 a0))
      (unlk a6)
      (rts))))


#-ppc-target
(defun lfun-to-ptr (lfun)
  (let* ((size (- (the fixnum (* 2 (the fixnum (uvsize (%lfun-vector lfun)))))
                  (- ($lfv_lfun) $v_data)))
         (ptr (#_NewPtr :errchk size)))
    (declare (fixnum size))
    (lap-inline ()
      (:variable lfun size ptr)
      (move.l (varg lfun) a0)
      (move.l (varg ptr) a1)
      (move.l (a1 $macptr.ptr) a1)
      (move.l (varg size) d0)
      (getint d0)
      (dc.w #_BlockMove))
    ptr))


#+ppc-target
(eval-when (:compile-toplevel :execute :load-toplevel)

(defconstant *wdef-proc-info*
  #.(make-proc-info '(:word :ptr :word :long) :long #$kPascalStackBased))

(ppc::define-storage-layout wdef-toc 0
  nilreg                                ; NIL
  call-universal-proc                   ; Address of call-universal-proc transition vector
  wdef-defpascal                        ; the windoid-wdef defpascal
  )


#|
(define-entry-point "MakeDataExecutable" ((address :ptr) (bytes :unsigned-long))
         nil)
|#


)

#+ignore ;;;#+ppc-target
(progn

; A ptr containing the code from the windoid-wdef lap below
(defvar *windoid-wdef-wrapper*)


(defppclapfunction windoid-wdef ()
  (let ((variation 3)
        (wptr 4)
        (message 5)
        (parameter 6)
        (tmp 7)
        (tmp2 8)
        (nilreg 9))
    (lwz nilreg wdef-toc.nilreg rnil)
    (lwz tmp (ppc::kernel-global current-cs) nilreg)
    (lwz tmp2 ppc::area.low tmp)
    (cmplw sp tmp2)
    (blt @not-lisp)
    (lwz tmp2 ppc::area.high tmp)
    (cmplw sp tmp2)
    (bge @not-lisp)

    ; The callback is on the Lisp stack, so we can just enter the lisp code
    (mr 8 6)
    (mr 7 5)
    (mr 6 4)
    (mr 5 3)
    (lwi 4 #.*wdef-proc-info*)
    (lwz 3 wdef-toc.wdef-defpascal rnil)
    (lwz rnil wdef-toc.call-universal-proc rnil)
    (lwz 0 0 rnil)
    (mtctr 0)
    (lwz rnil 4 rnil)
    (bctr)

    @not-lisp
    ; We were called from some unknown stack.
    ; Tell %event-dispatch to redraw all the window frames
    (la tmp (ppc::nrs-offset *gc-event-status-bits*) nilreg)
    (lwi tmp2 #.(ash 1 (+ $gc-redraw-window-frames-bit ppc::fixnum-shift)))
    (lwz 3 ppc::symbol.vcell tmp)
    (or 3 3 tmp2)
    (stw 3 ppc::symbol.vcell tmp)
    ; return 0 = false for the #$whit command
    (li 3 0)
    (blr)))



  ;; move to misc - and leave it  here too cause this loads before misc
(defun lfun-to-ptr (lfun)
  (unless (functionp lfun)
    (setq lfun (require-type lfun 'function)))
  (let* ((code-vector (uvref lfun 0))
         (words (uvsize code-vector))
         (bytes (* 4 words))
         (ptr (#_NewPtr :errchk bytes)))
    (%copy-ivector-to-ptr code-vector 0 ptr 0 bytes)
    (#_MakeDataExecutable ptr bytes)
    ptr))


)  ; end of #+ppc-target progn

#-carbon-compat
(defpascal windoid-wdef (:word variation :ptr wptr :word message
                               :long parameter :long)
  (declare (ignore variation))
  (without-interrupts
   (let ((result 0))
     (case message
       (#.$wDraw (windoid-draw-window wptr parameter))
       (#.$wHit (setq result (windoid-test-hit wptr parameter)))
       (#.$wCalcRgns (windoid-calc-regions wptr)))
     result)))

;; this doesn't work in OS 8.5 - fixed now
#-carbon-compat
(defun windoid-draw-window (wptr parameter)
  (when (rref wptr windowrecord.visible)
    (#_setorigin 0 0)
;    (#_SetClip (#_LMGetGrayRgn))
    (rlet ((frame :rect)(goAway :rect)(penstate :penstate)(hilite-pattern :pattern))
      (rset frame rect.topleft 
            (rref (rref wptr windowrecord.strucRgn) region.rgnBBox.topleft))
      (rset frame rect.bottomright
            (subtract-points
             (rref (rref wptr windowrecord.strucRgn) region.rgnBBox.bottomright)
             #@(1 1)))
      (rset goAway rect.topleft (add-points #@(8 2) (rref frame rect.topleft)))
      (rset goAway rect.bottomright (add-points #@(7 7) (rref goAway rect.topleft)))
      (if (neq parameter 0)
        (#_InvertRect goAway)
        (progn
          (#_GetPenState penstate)
          (#_PenNormal)
          ;;Draw Frame
          (#_FrameRect frame)
          ;;Draw Drop Shadow
          (#_MoveTo (%i+ $windoid-shadow-indent (rref frame rect.left))
                   (rref frame rect.bottom))
          (#_LineTo (rref frame rect.right) (rref frame rect.bottom))
          (#_LineTo (rref frame rect.right)
                   (%i+ $windoid-shadow-indent (rref frame rect.top)))
          ;;Calculate and draw title bar
          (rset frame rect.bottom (+ 1 (rref frame rect.top) $windoid-title-bar-height))
          (#_FrameRect frame)
          (#_InsetRect frame 1 1)
          (if (rref wptr windowrecord.hilited)
            (let ((tone (if (%ilogbitp 0 (rref frame rect.left)) #x55 #xaa)))
              (dotimes (i 8)
	        (declare (fixnum i))
                (%put-byte hilite-pattern
                           (if (%ilogbitp 0 (%i+ i (rref frame rect.top))) tone 0) i))
              (#_FillRect frame hilite-pattern)
              ;;Draw Go Away Box
              (when (rref wptr :windowrecord.GoAwayFlag)
                (#_InsetRect goAway -1 -1)
                (#_EraseRect goAway)
                (#_InsetRect goAway 1 1)
                (#_FrameRect goAway)))
            (#_EraseRect frame))
          (#_SetPenState penstate))))))

#-carbon-compat
(defun windoid-test-hit (wptr where)
  (rlet ((drag :rect)(goAway :rect))
    (with-dereferenced-handles ((cont (rref wptr windowrecord.contRgn))
                                (struc (rref wptr windowrecord.strucRgn)))
      (if (#_PtInRect where (pref cont region.rgnBBox))
        $wInContent
        (progn
          (copy-record (pref struc region.rgnBBox) :rect drag)
          (rset drag rect.bottom (+ 1 (rref drag rect.top) $windoid-title-bar-height))
          (decf (rref drag rect.right))
          (rset goAway rect.top (+ 2 (rref drag rect.top)))
          (rset goAway rect.left (+ 8 (rref drag rect.left)))
          (rset goAway rect.bottom (%i+ 7 (rref goAway rect.top)))
          (rset goAway rect.right (%i+ 7 (rref goAway rect.left)))
          (if (#_PtInRect where drag)
            (if (and (rref wptr :windowrecord.hilited)
                     (rref wptr :windowrecord.GoAwayFlag)
                     (#_PtInRect where goAway))
              $wInGoAway
              $wInDrag)
            $wNoHit))))))

#|
(defun windoid-calc-regions (wptr &aux (rgn (#_NewRgn)))
  (rlet ((r :rect))
    (copy-record (rref wptr windowrecord.portrect) :rect r)
    (#_offsetRect 
     r 
     (- (rref wptr windowrecord.portbits.bounds.left))
     (- (rref wptr windowrecord.portbits.bounds.top)))
    ;;Calculate content region
    (#_RectRgn (rref wptr windowrecord.contRgn) r)
    ;;Calculate Structure Region
    (decf (rref r rect.top) (%i+ $windoid-title-bar-height 1))
    (decf (rref r rect.left))
    (incf (rref r rect.bottom))
    (incf (rref r rect.right))
    (#_RectRgn (rref wptr windowrecord.strucRgn) r)
    ;;Calculate drop shadow
    (incf (rref r rect.top) $windoid-shadow-indent)
    (incf (rref r rect.left) $windoid-shadow-indent)
    (incf (rref r rect.bottom))
    (incf (rref r rect.right))
    (#_RectRgn rgn r)
    (#_UnionRgn (rref wptr windowrecord.strucrgn) rgn (rref wptr windowrecord.strucrgn))
    (#_DisposeRgn rgn)))
|#

#-carbon-compat
(defun windoid-calc-regions (wptr &aux (rgn (#_NewRgn)))
  (rlet ((r :rect))
    (copy-record (rref wptr windowrecord.portrect) :rect r)
    (let ((foo (rref wptr :windowrecord.portbits.rowbytes)))
      (if (minusp foo)   ;; ???     
        (#_offsetRect 
         r 
         (- (rref (rref wptr windowrecord.portbits.baseaddr) :pixmap.bounds.left))
         (- (rref (rref wptr windowrecord.portbits.baseaddr) :pixmap.bounds.top)))
        (#_offsetRect
         r
         (- (rref wptr windowrecord.portbits.bounds.left))
         (- (rref wptr windowrecord.portbits.bounds.top)))))
    ;;Calculate content region
    (#_RectRgn (rref wptr windowrecord.contRgn) r)
    ;;Calculate Structure Region
    (decf (rref r rect.top) (%i+ $windoid-title-bar-height 1))
    (decf (rref r rect.left))
    (incf (rref r rect.bottom))
    (incf (rref r rect.right))
    (#_RectRgn (rref wptr windowrecord.strucRgn) r)
    ;;Calculate drop shadow
    (incf (rref r rect.top) $windoid-shadow-indent)
    (incf (rref r rect.left) $windoid-shadow-indent)
    (incf (rref r rect.bottom))
    (incf (rref r rect.right))
    (#_RectRgn rgn r)
    (#_UnionRgn (rref wptr windowrecord.strucrgn) rgn (rref wptr windowrecord.strucrgn))
    (#_DisposeRgn rgn)))

(defvar *windoid-wdef-handles* nil)

(defun windoid-wdef-handle-p (macptr)
  (member macptr *windoid-wdef-handles*))

#-ppc-target
(defun make-wdef-handle (wdef-defpascal &aux (h (#_NewHandle :errchk 6)))
  (let ((ptr (lfun-to-ptr #'windoid-wdef)))
    (setf (%get-ptr ptr 0) (%currentA5)
          (%get-ptr ptr 4) wdef-defpascal)
    (%hput-word h #x4ef9)
    (%hput-ptr h (%inc-ptr ptr 8) 2))
  (push h *windoid-wdef-handles*)
  h)


#-carbon-compat
(defun make-wdef-handle (wdef-defpascal)
  (let* ((transition-vector (#_newptr :errchk (* 4 (+ 2 ppc::wdef-toc.size))))
         (upp (cons-routine-descriptor transition-vector *wdef-proc-info*)))
    (with-macptrs ((toc (%inc-ptr transition-vector 8)))
      (setf (%get-ptr transition-vector 0) *windoid-wdef-wrapper*
            (%get-ptr transition-vector 4) toc)
      (%set-object toc wdef-toc.nilreg nil)
      (%set-object toc wdef-toc.call-universal-proc *call-universal-proc-address*)
      (setf (%get-ptr toc wdef-toc.wdef-defpascal) wdef-defpascal))
    (rlet ((h-ptr :ptr))
      (#_PtrToHand upp h-ptr (#_GetPtrSize upp))
      (#_DisposeRoutineDescriptor upp)
      (let ((h (%get-ptr h-ptr)))
        (push h *windoid-wdef-handles*)
        h))))

#-carbon-compat
(def-ccl-pointers windoid-wdef-handle ()
  (setq *windoid-wdef-handles* nil)
  #+ppc-target
  (setq *windoid-wdef-wrapper* (lfun-to-ptr #'windoid-wdef))
  (setq *windoid-wdef-handle* (make-wdef-handle windoid-wdef)))

(defmethod accept-key-events ((w simple-view))
  t)

(defmethod accept-key-events ((w windoid))
  nil)

(defmethod accept-key-events ((w da-window))
  nil)

; Make these 4 methods share a body as soon as we can stack cons a
; closure over #'call-next-method
(defmethod view-key-event-handler :around ((w windoid) key)
  (if (accept-key-events w)
    (call-next-method)
    (let ((next-window (window-under w nil nil)))
      (if next-window
        (with-focused-view next-window
          (view-key-event-handler next-window key))))))

(defmethod window-null-event-handler :around ((w windoid))
  (if (accept-key-events w)
    (call-next-method)
    (let ((next-window (window-under w nil nil)))
      (if  next-window
        (with-focused-view next-window
          (window-null-event-handler next-window))))))

(defmethod window-key-up-event-handler :around ((w windoid))
  (if (accept-key-events w)
    (call-next-method)
    (let ((next-window (window-under w nil nil)))
      (if next-window
        (with-focused-view next-window
          (window-key-up-event-handler next-window))))))

(defmethod window-mouse-up-event-handler :around ((w windoid))
  (if (accept-key-events w)
    (call-next-method)
    (let ((next-window (window-under w nil nil)))
      (if next-window
        (with-focused-view next-window
          (window-mouse-up-event-handler next-window))))))

(defmethod window-event-handler ((w windoid))
  (if (accept-key-events w)
    w
    (let ((next-window (window-under w nil nil)))
      (when next-window
        (window-event-handler next-window)))))

(defmethod window-title-height ((w windoid))
  (if (window-shown-p w)
    (call-next-method)
    (if *use-old-style-windoids* 10 15)))

; returns back-to-front order
(defun windoids (&optional include-invisibles 
                           &aux wob res)
  (without-interrupts
   (do-wptrs wptr
     (when (and (setq wob (window-object wptr))
                (inherit-from-p wob (find-class 'windoid))
                (or include-invisibles 
                    #-carbon-compat (rref wptr windowrecord.visible) 
                    #+carbon-compat (#_iswindowvisible wptr)))
       (setq res (cheap-cons wob res)))))
  res)

(defun map-windoids (fn &optional include-invisibles)
  (let ((windows (windoids include-invisibles)))
    (unwind-protect
      (mapc fn windows)
      (cheap-free-list windows)))
  nil)

(defmethod window-zoom-event-handler ((w windoid) msgw)
  ;; Rom bug compensation. The msg is sometimes wrong. It's only right the first time.
  ;; Unfortunately because of the control strip thing in lower left of screen,
  ;; you have to move a windoid-side to get at the zoom-box if the windoid has been zoomed.
  ;; Having moved it, you change the unzoomed size and pos.
  ;; But you can move the control strip with option drag!
  (let* ((size (view-size w))
         (zoom-size (window-zoom-size w)))
    (if (eql size zoom-size)
      (setq msgw #$inzoomin)
      (setq msgw #$inzoomout))
    (if (and (eql size zoom-size)(not (eql (view-position w)(window-zoom-position w))))
      ;; kludge # 6 - 
      (progn ;(set-view-position w (window-zoom-position w))  ;; with this it ain't behavin like a regular window.
             (setq msgw #$inzoomout)))
    (call-next-method w msgw)))

(defmethod window-type ((window windoid))
  (if (wptr window)
    (call-next-method)
    :windoid))

; now we can map-windoids
(setq *hide-windoids-on-suspend* t)






#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
