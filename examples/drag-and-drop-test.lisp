;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 
;;;; Macintosh Drag and Drop for MCL
;;;; Version 1.5.6
;;;; 
;;;; Dan S. Camper
;;;; lordgrey@apple.com
;;;;
;;;; created: 05/13/96
;;;; revised: 09/13/96
;;;;
;;; add-pascal-upp-alist => add-pascal-upp-alist-macho
;;; use #_getregionbounds, modernize spelling of some constants
;;; ----- 5.1 final
;;; no mo HOpenResFIle - more to do re fsref vs. fsspec
;;; --------- 5.0 final
;;; 05/27/01 akh add-pascal-upp-alist if carbon
;;; pbgetcatinfo => pbgetcatinfosync, openresfile => hopenresfile
;;; 12/14/99 akh@tiac.net modified to use advise instead of redefining internal MCL functions.
;;;  This version should work with MCL 4.3 as well as most earlier and later MCL versions. 

(in-package :ccl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :quickdraw)
  (add-feature :drag-and-drop)
  (export '(
            
            *drag-manager-present-p*		; Environmental things
            drag-manager-present-p
            init-drag-and-drop
            drag-window-p
            dragging-now-p
            *drag-error-stream*
            
            drag-view-mixin			; View mixin class for drag-awareness
            
            drag-proxy				; Bounces drag handling to another view
            
            drag-allow-copy-within-view-p	; View accessors for overrides
            drag-allow-move-within-view-p
            drag-accepted-flavor-list
            
            drag-tracking-enter-handler		; Drag Manager callback handlers
            drag-tracking-enter-view
            drag-tracking-in-view
            drag-tracking-leave-view
            drag-tracking-leave-handler
            
            drag-get-drag-reference		; Drag session introspection
            drag-get-source-view
            drag-get-current-view
            
            drag-mouse-original-position	; Mouse introspection during drags
            drag-mouse-drop-position
            drag-mouse-position
            drag-mouse-view
            
            drag-set-mouse-position
            
            drag-copy-requested-p		; User is holding down the option key...
            
            drag-get-attributes			; Drag attributes
            drag-left-sender-view-p
            drag-left-sender-window-p
            drag-within-sender-view-p
            drag-within-sender-window-p
            drag-within-sender-application-p
            
            drag-get-keyboard-modifiers		; Keyboard states
            drag-command-key-p
            drag-shift-key-p
            drag-control-key-p
            drag-option-key-p
            drag-caps-lock-key-p
            
            drag-setup-new-drag			; Dragging from MCL
            drag-handle-new-drag
            drag-cancel-new-drag
            drag-cleanup-new-drag
            
            drag-selection-p			; Boolean indicating drag-ability
            
            drag-add-drag-contents		; Creating drag items
            drag-fulfill-promise
            
            drag-create-item-bounds		; Creating drag region for drag items
            drag-te-hilite-region
            
            drag-count-items			; Drag item introspection
            drag-get-item-reference-number
            with-each-drag-item
            with-each-drag-item-reversed
            
            drag-flavor-exists-p		; Drag flavor information
            drag-count-flavors
            drag-get-flavor-type
            drag-get-flavor-type-list
            drag-get-flavor-flags
            drag-get-flavor-size
            
            drag-get-flavor-data		; Getting flavor data
            with-drag-flavor
            with-each-drag-flavor
            
            drag-add-item-flavor		; Setting generic flavor information
            drag-set-item-flavor
            drag-promise-item-flavor
            
            drag-add-hfs-flavor			; Setting HFS flavor information
            drag-set-hfs-flavor
            drag-promise-hfs-flavor
            
            drag-get-hfs-flavor			; Getting HFS flavor information
            drag-get-promised-hfs-flavor
            drag-resolve-promised-hfs-flavor
            
            drag-add-mcl-object-flavor		; Setting MCL object information
            
            drag-allow-drop-p			; Checks for allowing drops
            drag-allow-dropped-flavor-p
            
            drag-receive-drop			; Receiving dropped drag items
            drag-receive-dropped-item
            drag-receive-dropped-flavor
            
            drag-receive-drop-setup
            drag-receive-drop-cleanup
            
            drag-get-drop-location-descriptor	; Getting drop location information
            drag-get-drop-location-as-path
            drag-get-target-description
            
            drag-set-drop-location-descriptor	; Setting the drop location
            drag-set-drop-location-from-alias
            drag-set-drop-location-from-path
            
            drag-cursor				; Cursor used to indicate drag-ability
            
            drag-show-drag-hilite		; Indicator of view's acceptance of drag
            drag-hide-drag-hilite
            with-saved-drag-hilite
            drag-make-drag-hilite-region
            
            drag-make-auto-scroll-region	; To detect the need to auto-scroll
            
            drag-scroll-view			; Actually performs the auto-scroll
            with-drag-scroll
            
            drag-draw-caret-p			; Drop insertion caret manipulation
            drag-draw-caret
            drag-caret-position-from-mouse
            
            drag-zoom-rectangle			; Animated zooming
            drag-zoom-rectangle-points
            drag-zoom-region
            
            )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Globals & Constants
;;;

(defvar *drag-manager-present-p* nil)
(defvar *drag-error-stream* *error-output*)
(defvar *drag-session* nil)
(defvar *drag-&-drop-window-list* nil)

(defconstant $DragScrollRegionThickness #.(make-point 5 5))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Convenient macro & function...
;;;
(defmacro oserr-check (&body body)
  (let ((result (gensym)))
    `(let ((,result (progn ,@body)))
       (cond ((eql ,result (require-trap-constant #$userCanceledErr))
              (throw-cancel ,result))
             ((neq ,result (require-trap-constant #$noErr))
              (error "~S" ,result)))
       ,result)))

(defun %report-error (error-string)
  (if *drag-error-stream*
    (format *drag-error-stream* "~%~A" error-string)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Conversion routines
;;
(defun %wptr-to-drag-window (window-ptr)
  (cdr (find window-ptr *drag-&-drop-window-list* :key #'car)))

(defun %drag-window-to-wptr (window)
  (car (find window *drag-&-drop-window-list* :key #'cdr)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Given a window or a wptr, see if it drag-aware
;;
(defmethod drag-window-p ((window-or-wptr macptr))
  (if (%wptr-to-drag-window window-or-wptr)
    t))

(defmethod drag-window-p ((window-or-wptr window))
  (if (%drag-window-to-wptr window-or-wptr)
    t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; еее Class Definition for the *drag-session* variable
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass drag-session ()
  ((reference :initform nil :initarg :reference :accessor reference)
   (mcl-drag-p :initform nil :accessor mcl-drag-p)
   (internal-data :initform nil :accessor internal-data)
   (drag-state :initform nil :accessor drag-state)
   (source-view :initform nil :accessor source-view)
   (current-view :initform nil :accessor current-view)
   (left-source-p :initform nil :accessor left-source-p)
   (drag-region :initform nil :accessor drag-region)
   (auto-scroll-region :initform nil :accessor auto-scroll-region)
   (auto-scroll-next-p :initform 0 :accessor auto-scroll-next-p)
   (drop-location-aedesc :initform (%null-ptr) :accessor drop-location-aedesc)
   (last-caret-position :initform 0 :accessor last-caret-position)
   (last-caret-time :initform 0 :accessor last-caret-time)
   (caret-shown-p :initform nil :accessor caret-shown-p)
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Accessors to drag-session class
;;;
(defun drag-get-drag-reference ()
  (reference *drag-session*))

(defun drag-get-source-view ()
  (source-view *drag-session*))

(defun drag-get-current-view ()
  (current-view *drag-session*))

(defun dragging-now-p ()
  (if (reference *drag-session*)
    t))

(defmacro with-saved-drag-state ((new-state) &body body)
  (let ((old-state (gensym)))
    `(let ((,old-state (drag-state *drag-session*)))
       (unwind-protect
         (progn
           (setf (drag-state *drag-session*) ,new-state)
           ,@body)
         (setf (drag-state *drag-session*) ,old-state)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Function indicating the presence of the Drag Manager in the current system.
;; You can also check *drag-manager-present-p*, which is set when evaluating
;; this form and during execution of *lisp-startup-functions* (provided it
;; is part of the MCL image).
;;
(defun drag-manager-present-p ()
  (and (gestalt #$gestaltDragMgrAttr)
       (logbitp #$gestaltDragMgrPresent (gestalt #$gestaltDragMgrAttr))))

(defun init-drag-and-drop ()
  (setf *drag-manager-present-p* (drag-manager-present-p))
  (when *drag-manager-present-p*
    (setf *drag-session* (make-instance 'drag-session))
    t))

(eval-when (:load-toplevel :execute)
  (init-drag-and-drop)
  (pushnew #'init-drag-and-drop *lisp-startup-functions* :key #'function-name))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; еее Low-level entries to/from Drag Manager
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; The system calls this function whenever a dragged item causes an event in a
;; drag & drop window.
;;
;; This method acts as a dispatcher to predefined MCL methods, which you
;; should specialize as necessary.  The methods to specialize are:
;;
;;    drag-tracking-enter-handler   (specialize on a window)
;;    drag-tracking-leave-handler   (specialize on a window)
;;    drag-tracking-enter-view      (specialize on a view)
;;    drag-tracking-leave-view      (specialize on a view)
;;    drag-tracking-in-view         (specialize on a view)
;;

#+ignore
(add-pascal-upp-alist 'DragTrackingHandlerDispatch.p  #'(lambda (procptr)(#_NewDragTrackingHandlerUPP procptr)))

(add-pascal-upp-alist-macho 'DragTrackingHandlerDispatch.p "NewDragTrackingHandlerUPP")



(defpascal DragTrackingHandlerDispatch.p (:word $theMessage :ptr $theWindow
                                                :ptr $handlerRefCon
                                                :long $dragReference
                                                :word)
  (declare (ignore $handlerRefcon))
  ;(with-pstrs ((p "drag"))(#_debugstr p))
  (let ((w (%wptr-to-drag-window $theWindow))
        (result #$noErr))
    (handler-case
      (when w
        (let ((v (drag-mouse-view w)))
          (setf v (or (drag-proxy v) v))
          (if (neq $dragReference (reference *drag-session*))
            
            (progn
              (with-pstrs ((p (format nil "reset-drag0 in-ref ~x sess-ref ~x" 
                                      $dragreference
                                      (reference *drag-session*))))
                (#_debugstr p))
              (when (not (osx-p)) ;; dunno - shouldnt happen ??
                (%drag-reset-drag-session $dragReference))))
          (case $theMessage
            (#.#$kdragTrackingEnterHandler
             (drag-tracking-enter-handler w))
            (#.#$kdragTrackingEnterWindow
             (setf (current-view *drag-session*) v)
             (drag-tracking-enter-view v))
            (#.#$kdragTrackingInWindow
             (when (neq (current-view *drag-session*) v)
               (when (current-view *drag-session*)
                 (%drag-hide-caret (current-view *drag-session*))
                 (drag-tracking-leave-view (current-view *drag-session*)))
               (setf (current-view *drag-session*) v)
               (drag-tracking-enter-view v))
             (drag-tracking-in-view v))
            (#.#$kdragTrackingLeaveWindow
             (%drag-hide-caret (current-view *drag-session*))
             (drag-tracking-leave-view (current-view *drag-session*))
             (setf (current-view *drag-session*) nil))
            (#.#$kdragTrackingLeaveHandler
             (drag-tracking-leave-handler w)
             (unless (mcl-drag-p *drag-session*)
               (%drag-reset-drag-session nil))))))
      (t (err-obj)
         (%report-error err-obj)
         (setf result #$userCanceledErr)))
    result))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; The system calls this function when one or more items are being dropped into a
;; drag & drop-aware view.
;;
#+ignore
(add-pascal-upp-alist 'DragReceiveHandlerDispatch.p  #'(lambda (procptr)(#_NewDragReceiveHandlerUPP procptr)))

(add-pascal-upp-alist-macho 'DragReceiveHandlerDispatch.p "NewDragReceiveHandlerUPP")
(defpascal DragReceiveHandlerDispatch.p (:ptr $theWindow :ptr $handlerRefCon
                                              :long $dragReference
                                              :word)
  (declare (ignore $handlerRefcon $dragReference))
  (with-pstrs ((p (format nil "receive ~S" $thewindow)))(#_debugstr p))
  (let* ((w (%wptr-to-drag-window $theWindow))
         (v nil)
         (result #$dragNotAcceptedErr))
    (with-pstrs ((p (format nil "receive2 ~S" w)))(#_debugstr p))
    (handler-case
      (when w
        (with-saved-drag-state (:post-drop)
          (setf v (drag-proxy (drag-mouse-view w)))
          (with-pstrs ((p (format nil "receive3 ~S" v)))(#_debugstr p))
          (when (%drag-allow-drop-if v)
            (unwind-protect
              (progn
                (with-pstrs ((p (format nil "receive4 ~S" v)))(#_debugstr p))
                (drag-receive-drop-setup v)
                (with-pstrs ((p (format nil "receive5 ~S" v)))(#_debugstr p))
                (setf result (drag-receive-drop v))
                (with-pstrs ((p (format nil "receive6 ~S" v)))(#_debugstr p)))
              
              (drag-receive-drop-cleanup v)))
          (with-pstrs ((p (format nil "receive7 ~S" result)))(#_debugstr p))
          (cond ((eql result t) (setf result #$noErr))
                ((not (integerp result)) (setf result #$dragNotAcceptedErr)))))
      (t (err-obj)
         (%report-error err-obj)
         (setf result #$dragNotAcceptedErr)))
    result))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This function is called when the destination requests flavor data that was not
;; provided at the beginning of the drag.
;;
;; The actual definition of this callback cites a long (actually a parameter of type
;; 'flavorType' which is an OSType which is four bytes) but there seems to be a bug in
;; the defpascal macro (or something).  If you specify a long there then the four high
;; bits are always set.  Defining it as a pointer and then extracting it with %ptr-to-int
;; seems to work.
;;
#+ignore
(add-pascal-upp-alist 'DragSendDataProc.p  #'(lambda (procptr)(#_NewDragSendDataUPP procptr)))

(add-pascal-upp-alist-macho 'DragSendDataProc.p  "NewDragSendDataUPP")
(defpascal DragSendDataProc.p (:ptr $flavorType :ptr $handlerRefCon :long $itemReference
                                    :long $dragReference
                                    :word)
  (declare (ignore $handlerRefcon $dragReference))
  (with-pstrs ((p "send"))(#_debugstr p))
  (let ((flavor-type nil)
        (result #$noErr))
    (handler-case
      (rlet ((temp :longint))
        (with-saved-drag-state (:post-drop)
          (%put-long temp (%ptr-to-int $flavorType))
          (setf flavor-type (%get-ostype temp))
          (setf result (drag-fulfill-promise (source-view *drag-session*)
                                             $itemReference flavor-type
                                             (drag-get-target-description)))
          (cond ((eql result t) (setf result #$noErr))
                ((not (integerp result)) (setf result #$badDragFlavorErr)))))
      (t (err-obj)
         (%report-error err-obj)
         (setf result #$userCanceledErr)))
    result))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Managing the *drag-session* global object & its slots
;;;
(defun %drag-new-drag-session ()
  (%drag-dispose-drag-session)
  (rlet (($dragRef :DragReference))
    (oserr-check (#_NewDrag $dragRef))
    (with-pstrs ((p  (format nil "new-drag ~X" (%get-long $dragref))))(#_debugstr p))
    (setf (reference *drag-session*) (%get-long $dragRef)
          (mcl-drag-p *drag-session*) t
          (drag-region *drag-session*) (new-region))
    (oserr-check (#_SetDragSendProc (reference *drag-session*) DragSendDataProc.p (%null-ptr)))))

(defun %drag-dispose-drag-session ()
  (if (drag-get-drag-reference)
    (ignore-errors (#_DisposeDrag (reference *drag-session*))))
  (%drag-reset-drag-session nil)
  t)

(defun %drag-reset-drag-session (new-drag-reference)
  (with-pstrs ((p "reset-drag-session"))(#_debugstr p))
  (when (drag-region *drag-session*)
    (dispose-region (drag-region *drag-session*))
    (setf (drag-region *drag-session*) nil))
  (when (auto-scroll-region *drag-session*)
    (dispose-region (auto-scroll-region *drag-session*))
    (setf (auto-scroll-region *drag-session*) nil))
  (unless (%null-ptr-p (drop-location-aedesc *drag-session*))
    (#_AEDisposeDesc (drop-location-aedesc *drag-session*))
    (setf (drop-location-aedesc *drag-session*) (%null-ptr)))
  (setf (mcl-drag-p *drag-session*) nil
        (internal-data *drag-session*) nil
        (drag-state *drag-session*) nil
        (current-view *drag-session*) nil
        (source-view *drag-session*) nil
        (left-source-p *drag-session*) nil
        (auto-scroll-next-p *drag-session*) nil
        (last-caret-position *drag-session*) 0
        (last-caret-time *drag-session*) 0
        (caret-shown-p *drag-session*) nil)
  (setf (reference *drag-session*) new-drag-reference)
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Patches to MCL kernel
;;;

#| ;; use advise instead
(let ((*warn-if-redefine-kernel* nil)
      (*warn-if-redefine* nil))
  
  ;; Hook into MCL's event system, in order to trap for mouseDowns and check
  ;; for drag gestures.
  (defun process-event (event)
    (let ((e-code (rref event eventrecord.what))
          (handled-p nil))
      (when (eq e-code #$mouseDown)
        (setf handled-p (%handle-drag-gesture event)))
      (let* ((*current-event* event))
        (declare (special *current-event* *processing-events*))
        (unless handled-p
          (block foo
            (with-restart *event-abort-restart*
              (let ((eventhook *eventhook*))
                (unless (and eventhook
                             (flet ((process-eventhook (hook)
                                      (unless (memq hook *eventhooks-in-progress*)
                                        (let ((*eventhooks-in-progress*
                                               (cons hook *eventhooks-in-progress*)))
                                          (declare (dynamic-extent *eventhooks-in-progress*))
                                          (funcall hook)))))
                               (declare (inline process-eventhook))
                               (if (listp eventhook)
                                 (dolist (item eventhook)
                                   (when (process-eventhook item) (return t)))
                                 (process-eventhook eventhook))))
                  (return-from foo (catch-cancel (do-event))))))))
        e-code)))
  
  ;; Check to see if the window being closed is drag-aware; if so, take down
  ;; the appropriate structures.
  (defmethod window-close ((window window))
    (when (and *drag-manager-present-p*
               (drag-window-p window))
      ; no other drag-aware views, so remove window from list & take down handlers
      (setf *drag-&-drop-window-list* (delete (wptr window) *drag-&-drop-window-list* :key #'car))
      (oserr-check (#_RemoveTrackingHandler DragTrackingHandlerDispatch.p (wptr window)))
      (oserr-check (#_RemoveReceiveHandler DragReceiveHandlerDispatch.p (wptr window))))
    (window-close-internal window))
  
  )
|#


;; This does the actual checking for mouseDown gestures, after first assuring
;; itself that it should be doing so.  It also starts the entire MCL-initiated
;; drag stuff, so it's rather important.
#|(defun %handle-drag-gesture (event)
  (rlet ((wptr :WindowPtr))
    (let ((the-part (#_FindWindow (rref event eventrecord.where) wptr))
          (view nil)
          (local-mouse nil)
          (window nil)
          (handled-p nil))
      (if (and *drag-manager-present-p*
               (= the-part #$inContent)
               (not (and (%i< (%i- (rref event eventrecord.when) *last-mouse-down-time*)
                              (%get-long (%int-to-ptr #$DoubleTime)))
                         (double-click-spacing-p *last-mouse-down-position*
                                                 (rref event eventrecord.where))))
               (setf window (%wptr-to-drag-window (%get-ptr wptr)))
               (setf view (find-view-containing-point window
                                                      (global-to-local window
                                                                       (rref event eventrecord.where))))
               (setf view (drag-proxy view))
               (setf local-mouse (global-to-local view (rref event eventrecord.where)))
               (drag-selection-p view local-mouse)
               (#_WaitMouseMoved (rref event eventrecord.where)))
        (when (drag-setup-new-drag view event)
          (drag-handle-new-drag view event)
          (setf handled-p t))
        (process-multi-clicks event))
      handled-p)))
|#

;; Modified version of above checks for mousedown instead of assuming caller did so.
;; Also doesn't do  process-multi-clicks, because the built-in process-event will do so.
(defun %handle-drag-gesture (event)
  (let ((ecode (rref event eventrecord.what)))
    (when (eq ecode #$mousedown)
      (rlet ((wptr :WindowPtr))
        (let ((the-part (#_FindWindow (rref event eventrecord.where) wptr))
              (view nil)
              (local-mouse nil)
              (window nil)
              (handled-p nil))
          (if (and *drag-manager-present-p*
                   (= the-part #$inContent)
                   (not (and (%i< (%i- (rref event eventrecord.when) *last-mouse-down-time*)
                                  (#_GetDblTime) ;(%get-long (%int-to-ptr #$DoubleTime))
                                  )
                             (double-click-spacing-p *last-mouse-down-position*
                                                     (rref event eventrecord.where))))
                   (setf window (%wptr-to-drag-window (%get-ptr wptr)))
                   (setf view (find-view-containing-point window
                                                          (global-to-local window
                                                                           (rref event eventrecord.where))))
                   (setf view (drag-proxy view))
                   (setf local-mouse (global-to-local view (rref event eventrecord.where)))
                   (drag-selection-p view local-mouse)
                   (#_WaitMouseMoved (rref event eventrecord.where)))
            (when (drag-setup-new-drag view event)
              (drag-handle-new-drag view event)
              (setf handled-p t)))
          ;; or do nothing? because we checked above that it's not a multi-click
          ;(if handled-p (process-multi-clicks event))
          handled-p)))))

(advise process-event (or (%handle-drag-gesture (car arglist))(:do-it))
        :when :around :name drag-event)

(defun drag-pre-close (window)
  (when (and *drag-manager-present-p*
             (drag-window-p window))
    ; no other drag-aware views, so remove window from list & take down handlers
    (setf *drag-&-drop-window-list* (delete (wptr window) *drag-&-drop-window-list* :key #'car))
    (oserr-check (#_RemoveTrackingHandler DragTrackingHandlerDispatch.p (wptr window)))
    (oserr-check (#_RemoveReceiveHandler DragReceiveHandlerDispatch.p (wptr window)))))

;; note that window-close for window already has :before :after and :around methods
(advise (:method window-close (window)) (drag-pre-close (car arglist))
        :when :before :name drag-close)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; еее Class Definitions for drag & drop views
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass drag-view-mixin ()
  ((dr-allow-copy :initform nil
                  :initarg :drag-allow-copy-p
                  :reader dr-allow-copy)
   (dr-allow-move :initform nil
                  :initarg :drag-allow-move-p
                  :reader dr-allow-move)
   (dr-auto-scroll :initform nil
                   :initarg :drag-auto-scroll-p
                   :reader dr-auto-scroll)
   (dr-scroll-amount :initform (make-point 12 12)
                     :initarg :drag-auto-scroll-amount
                     :reader dr-scroll-amount)
   (dr-flavor-list :initform t
                   :initarg :drag-accepted-flavor-list
                   :reader dr-flavor-list)
   (dr-hilite-p :initform nil
                :accessor dr-hilite-p)
   ))

(defmethod initialize-instance :after ((instance drag-view-mixin) &rest initargs)
  (declare (ignore initargs))
  (if (and (dr-flavor-list instance)
           (not (consp (dr-flavor-list instance))))
    (setf (slot-value instance 'dr-flavor-list) (list (dr-flavor-list instance))))
  instance)

(defmethod view-activate-event-handler :after ((view drag-view-mixin))
  (unless (drag-window-p (wptr view))
    (push (cons (wptr view) (view-window view)) *drag-&-drop-window-list*)
    (oserr-check (#_InstallTrackingHandler DragTrackingHandlerDispatch.p
                  (wptr view) (%null-ptr)))
    (oserr-check (#_InstallReceiveHandler DragReceiveHandlerDispatch.p
                  (wptr view) (%null-ptr)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Drag Proxy
;;
(defmethod drag-proxy ((view t))
  (declare (ignore view))
  nil)

(defmethod drag-proxy ((view drag-view-mixin))
  view)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Hook for call to drag-cursor
;;
(defmethod view-cursor :around ((view simple-view) point)
  (if (and (drag-proxy view)
           (drag-selection-p (drag-proxy view)
                             (convert-coordinates point view (drag-proxy view))))
    (drag-cursor (drag-proxy view))
    (call-next-method)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; If the mouse cursor is currently over a draggable item in a view (as per
;; a call to 'drag-selection-p) then this method should return a cursor
;; indicating that the item is draggable.  In most cases, the arrow cursor
;; suffices so that's the default.
;;
(defmethod drag-cursor ((view drag-view-mixin))
  (declare (ignore view))
  *arrow-cursor*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Accessors to the drag-view-mixin class.  These are provided so they can
;; be dynamically overridden.
;;
(defmethod drag-allow-copy-within-view-p ((view t))
  nil)

(defmethod drag-allow-copy-within-view-p ((view drag-view-mixin))
  (dr-allow-copy view))

(defmethod drag-allow-move-within-view-p ((view t))
  nil)

(defmethod drag-allow-move-within-view-p ((view drag-view-mixin))
  (dr-allow-move view))


;; This method returns an ordered list of flavors the view will accept.
;; When items are dropped onto the view, the flavors are processed in order
;; via a call to #'drag-receive-dropped-flavor.
(defmethod drag-accepted-flavor-list ((view t))
  (declare (ignore view))
  t)

(defmethod drag-accepted-flavor-list ((view drag-view-mixin))
  (dr-flavor-list view))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; еее The following drag-tracking-xxx methods should not be directly
;; еее overridden, unless their replacement methods perform the same functions.
;; еее Behavior modifications should be confined to :before, :after and :around
;; еее methods (and be sure to call #'call-next-method within the :around
;; еее versions).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called whenever a particular drag handler is called for the first time.
;;
(defmethod drag-tracking-enter-handler ((window window))
  (declare (ignore window))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called whenever a drag enters a drag & drop window or a view within the
;; window.
;;
(defmethod drag-tracking-enter-view ((view t))
  (declare (ignore view))
  nil)

(defmethod drag-tracking-enter-view ((view drag-view-mixin))
  (setf (last-caret-position *drag-session*) 0
        (last-caret-time *drag-session*) 0
        (caret-shown-p *drag-session*) nil)
  (if (%drag-show-drag-hilite-p view)
    (drag-show-drag-hilite view)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called while a drag is occuring within a drag-aware view.
;;
(defmethod drag-tracking-in-view ((view t))
  (declare (ignore view))
  nil)

(defmethod drag-tracking-in-view ((view drag-view-mixin))
  (when (or (neq view (drag-get-source-view))
            (drag-allow-move-within-view-p view)
            (drag-allow-copy-within-view-p view))
    (let ((handled-by-auto-scroll-p nil))
      (if (and (dr-auto-scroll view)
               (eql view (drag-get-source-view)))
        (setf handled-by-auto-scroll-p (%drag-auto-scroll-handler view)))
      (unless handled-by-auto-scroll-p
        (setf (auto-scroll-next-p *drag-session*) nil)
        (let* ((local-mouse-pos (drag-mouse-position view))
               (caret-pos (drag-caret-position-from-mouse view local-mouse-pos))
               (ticks (#_TickCount)))
          (when caret-pos
            (if (drag-draw-caret-p view)
              (progn
                (if (/= caret-pos (last-caret-position *drag-session*))
                  (progn
                    (%drag-show-caret view caret-pos)
                    (setf (last-caret-time *drag-session*) ticks))
                  (progn
                    (when (> (- ticks (last-caret-time *drag-session*))
                             (#_GetCaretTime))
                      (if (caret-shown-p *drag-session*)
                        (%drag-hide-caret view)
                        (%drag-show-caret view caret-pos))
                      (setf (last-caret-time *drag-session*) ticks)))))
              (progn
                (%drag-hide-caret view)
                (if (/= caret-pos (last-caret-position *drag-session*))
                  (setf (last-caret-position *drag-session*) caret-pos))))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called whenever a drag leaves a drag-aware view.
;;
(defmethod drag-tracking-leave-view ((view t))
  (declare (ignore view))
  nil)

(defmethod drag-tracking-leave-view ((view drag-view-mixin))
  (if (eql view (drag-get-source-view))
    (setf (left-source-p *drag-session*) t))
  (drag-hide-drag-hilite view))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called whenever a drag is exiting a particular drag handler.
;;
(defmethod drag-tracking-leave-handler ((window window))
  (declare (ignore window))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Internal method to determine whether to show the view's drag hilite or not.
;;
(defmethod %drag-show-drag-hilite-p ((view t))
  (let ((show-p nil))
    (if (eql view (drag-get-source-view))
      (if (and (left-source-p *drag-session*)
               (or (drag-allow-move-within-view-p view)
                   (drag-allow-copy-within-view-p view))
               (%drag-allow-drop-if view))
        (setf show-p t))
      (if (%drag-allow-drop-if view)
        (setf show-p t)))
    show-p))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Internal method to speedily handle auto-scrolling, if the view has it enabled.
;;
(defmethod %drag-auto-scroll-handler ((view t))
  (let ((handled-p nil)
        (local-pinned-mouse (drag-mouse-position view)))
    (when (point-in-region-p (auto-scroll-region *drag-session*)
                             (convert-coordinates local-pinned-mouse
                                                  view
                                                  (view-window view)))
      (setf handled-p t)
      (if (auto-scroll-next-p *drag-session*)
        (let ((my-right (point-h (view-size view)))
              (my-bottom (point-v (view-size view)))
              (angle 0)
              (direction nil))
          (with-rectangle-arg (my-rect 0 0 my-right my-bottom)
            (setf angle (point-to-angle my-rect local-pinned-mouse))
            (cond ((and (>= angle 45) (< angle 135))
                   (setf direction :right))
                  ((and (>= angle 135) (< angle 225))
                   (setf direction :down))
                  ((and (>= angle 225) (< angle 315))
                   (setf direction :left))
                  (t
                   (setf direction :up))))
          (%drag-hide-caret view)
          (drag-scroll-view view direction))
        (setf (auto-scroll-next-p *drag-session*) t)))
    handled-p))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called at the start of a drag from a drag-aware view, based on the user's
;; actions.  EventRecord is a the standard Macintosh event record that is
;; currently being processed.  If this method is specialized, be sure to
;; call #'call-next-method so the complete setup is performed.  If the method
;; returns a nil value, do not continue with the drag process.
;;
(defmethod drag-setup-new-drag ((view t) eventrecord)
  (declare (ignore view eventrecord))
  nil)

(defmethod drag-setup-new-drag ((view drag-view-mixin) eventrecord)
  (let ((add-data-result nil))
    (%drag-new-drag-session)
    (with-saved-drag-state (:setup)
      (setf (source-view *drag-session*) view)
      (if (dr-auto-scroll view)
        (setf (auto-scroll-region *drag-session*) (drag-make-auto-scroll-region view)))
      (unwind-protect
        (setf add-data-result (drag-add-drag-contents view))
        (if (not add-data-result)
          (drag-cleanup-new-drag view eventrecord))))
    add-data-result))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called after 'drag-setup-new-drag, if that method returned a non-nil value.
;; Handles the actual tracking of the drag.  If the user has cancelled the
;; drag, will call 'drag-cancel-new-drag.  Calls 'drag-cleanup-new-drag no
;; matter what the outcome.
;;
(defmethod drag-handle-new-drag ((view t) eventrecord)
  (declare (ignore view eventrecord))
  nil)

(defmethod drag-handle-new-drag ((view drag-view-mixin) eventrecord)
  (let ((mcl-error nil))
    (unwind-protect
      (let ((drag-error #$noErr))
        (handler-case
          (progn
            (with-saved-drag-state (:pre-drop)
              (setf drag-error (#_TrackDrag (drag-get-drag-reference)
                                eventrecord (drag-region *drag-session*)))
              (focus-view view)))
          (t (err-obj)
             ; postpone error processing until the rest of the methods are called
             (setf mcl-error err-obj)))
        (if (and (not mcl-error)
                 (eql drag-error #$userCanceledErr))
          (drag-cancel-new-drag view eventrecord)))
      (with-saved-drag-state (:cleanup)
        (drag-cleanup-new-drag view eventrecord)))
    (if mcl-error
      (%report-error mcl-error)))
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called if the user cancelled the drag by dropping into a "bad" location.
;;
(defmethod drag-cancel-new-drag ((view drag-view-mixin) eventrecord)
  (declare (ignore view eventrecord))
  nil)

(defmethod drag-cancel-new-drag :around ((view t) eventrecord)
  (declare (ignore eventrecord))
  (let ((result nil))
    (with-saved-drag-state (:cancel)
      (setf result (call-next-method)))
    (when result
      (let ((mouse-pos (drag-mouse-position nil)))
        (rlet ((dest-rect :rect
                          :top (point-v mouse-pos)
                          :left (point-h mouse-pos)
                          :bottom (+ (point-v mouse-pos) 5)
                          :right (+ (point-h mouse-pos) 5)))
          (rlet ((rgn-rect :rect))
            (#_getregionbounds (drag-region *drag-session*) rgn-rect)
            (drag-zoom-rectangle rgn-rect
                                 dest-rect
                                 :zoom-steps 24)))))
    result))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called after 'drag-handle-new-drag no matter what the outcome of the drag.
;; Takes down all necessary data structures and such.  If you specialize this
;; method, be sure to either call #'call-next-method or replicate these steps
;; in order to decommission the drag manager stuff correctly.
;;
(defmethod drag-cleanup-new-drag ((view drag-view-mixin) eventrecord)
  (declare (ignore eventrecord))
  (%drag-dispose-drag-session)
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Macro for iterating through all the items in a drag
;;
(defmacro with-each-drag-item ((item-reference-symbol) &body body)
  (let ((item-count (gensym))
        (index (gensym)))
    `(let ((,item-count (drag-count-items)))
       (when (and ,item-count
                  (plusp ,item-count))
         (dotimes (,index ,item-count)
           (let ((,item-reference-symbol (drag-get-item-reference-number (1+ ,index))))
             ,@body))
         t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Exactly the same as #'with-each-drag-item but the drag items are traversed
;; in reverse order.
;;
(defmacro with-each-drag-item-reversed ((item-reference-symbol) &body body)
  (let ((item-count (gensym))
        (index (gensym)))
    `(let ((,item-count (drag-count-items)))
       (when (and ,item-count
                  (plusp ,item-count))
         (dotimes (,index ,item-count)
           (let ((,item-reference-symbol (drag-get-item-reference-number (- ,item-count ,index))))
             ,@body))
         t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Macro for iterating through all the flavors in a particular item.  The symbol
;; representing the flavor ptr (the data) may be a Macintosh pointer, if the
;; data was extracted from the Drag Manager, or an MCL object if the data was
;; set via a call to #'drag-add-mcl-object-flavor.  In the former case, the
;; flavor-size-symbol will be bound to the size of the pointer; in the latter,
;; it will always be zero.
;;
(defmacro with-each-drag-flavor ((item-reference
                                  flavor-type-symbol
                                  flavor-data-symbol
                                  flavor-size-symbol)
                                 &body body)
  (let ((flavor-count (gensym))
        (index (gensym)))
    `(let ((,flavor-count (drag-count-flavors ,item-reference)))
       (when (and ,flavor-count
                  (plusp ,flavor-count))
         (dotimes (,index ,flavor-count)
           (let ((,flavor-type-symbol (drag-get-flavor-type ,item-reference (1+ ,index))))
             (if ,flavor-type-symbol
               (let* ((,flavor-data-symbol (drag-get-flavor-data ,item-reference
                                                                 ,flavor-type-symbol)))
                 (unwind-protect
                   (let ((,flavor-size-symbol (if (macptrp ,flavor-data-symbol)
                                                (require-trap #_GetPtrSize ,flavor-data-symbol)
                                                0)))
                     ,@body)
                   (if (macptrp ,flavor-data-symbol)
                     (require-trap #_DisposePtr ,flavor-data-symbol)))))))
         t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Easy way to work with a particular flavor of data.  Note that the 'flavor'
;; argument is an OSType.
;;
(defmacro with-drag-flavor ((item-reference
                             flavor-type
                             flavor-data-symbol
                             flavor-size-symbol)
                            &body body)
  `(let ((,flavor-data-symbol (drag-get-flavor-data ,item-reference ,flavor-type)))
     (when ,flavor-data-symbol
       (unwind-protect
         (let ((,flavor-size-symbol (if (macptrp ,flavor-data-symbol)
                                      (require-trap #_GetPtrSize ,flavor-data-symbol)
                                      0)))
           ,@body)
         (if (macptrp ,flavor-data-symbol)
           (require-trap #_DisposePtr ,flavor-data-symbol)))
       t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called to determine if a view can accept the items being dragged.  Human
;; Interface Guidelines say that the destination MUST accept at least one flavor
;; from every drag item before asserting that the drop can take place.  If this
;; method is not specialized, it will call 'drag-allow-dropped-flavor-p with
;; the view and each flavor in each dragged item; if at least one flavor per
;; dragged item returns t then the drop will be allowed.
;;
(defmethod drag-allow-drop-p ((view t))
  (declare (ignore view))
  nil)

(defmethod drag-allow-drop-p ((view drag-view-mixin))
  (let ((result t))
    (with-each-drag-item (item-reference)
      (let ((flavor-count (drag-count-flavors item-reference))
            (flavor-index 1)
            (accepted-p nil))
        (loop while (and (not accepted-p)
                         (<= flavor-index flavor-count))
              do (setf accepted-p
                       (drag-allow-dropped-flavor-p view
                                                    (drag-get-flavor-type item-reference
                                                                          flavor-index)))
              do (incf flavor-index))
        (setf result (and result accepted-p))))
    result))

(defmethod %drag-allow-drop-if ((view t))
  (declare (ignore view))
  nil)

(defmethod %drag-allow-drop-if ((view drag-view-mixin))
  (if (or (neq view (drag-get-source-view))
          (and (drag-allow-move-within-view-p view)
               (not (drag-copy-requested-p)))
          (and (drag-allow-copy-within-view-p view)
               (drag-copy-requested-p)))
    (drag-allow-drop-p view)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Same as 'drag-allow-drop-p but allows specializations on the flavor
;; argument {via (eql :|xxx|)}.
;;
(defmethod drag-allow-dropped-flavor-p ((view t) (flavor keyword))
  (declare (ignore view flavor))
  nil)

(defmethod drag-allow-dropped-flavor-p ((view drag-view-mixin) (flavor keyword))
  (let ((flavor-list (drag-accepted-flavor-list view)))
    (and (consp flavor-list)
         (position flavor flavor-list :test #'eql))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called when a user has dropped data into a drag-aware view, before any
;; processing of the data has been started.
;;
(defmethod drag-receive-drop-setup ((view drag-view-mixin))
  (declare (ignore view))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called after all processing of dropped data has occurred.
;;
(defmethod drag-receive-drop-cleanup ((view drag-view-mixin))
  (declare (ignore view))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called when the Drag Manager is dropping something into a drag-aware view.
;;
(defmethod drag-receive-drop ((view t))
  (declare (ignore view))
  nil)

(defmethod drag-receive-drop ((view drag-view-mixin))
  (let ((final-result t))
    (block item-loop
      (with-each-drag-item (item-reference)
        (with-pstrs ((p (format nil "receive-drd ~S ~S" view item-reference)))(#_debugstr p))
        (let ((drop-result (drag-receive-dropped-item view item-reference)))
          (unless (or (eql drop-result t)
                      (eql drop-result #$noErr))
            (setf final-result drop-result)
            (return-from item-loop)))))
    final-result))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Same as 'drag-receive-drop but each dropped flavor is broken out for you.
;; Process the information with a specialization of #'drag-receive-dropped-flavor.
;;
(defmethod drag-receive-dropped-item ((view t) (item-reference integer))
  (declare (ignore view item-reference))
  nil)

(defmethod drag-receive-dropped-item ((view drag-view-mixin) (item-reference integer))
  (let ((result nil)
        (flavor-list (drag-accepted-flavor-list view)))
    (when (consp flavor-list)
      (with-pstrs ((p (format nil "receive-drdi ~S ~S" view flavor-list)))(#_debugstr p))
      (block flavor-loop
        (dolist (flavor flavor-list)
          (with-pstrs ((p (format nil "receive-drdi2 ~S ~S" view flavor)))(#_debugstr p))
          (when (drag-flavor-exists-p item-reference flavor)
            (with-pstrs ((p (format nil "receive-drdi3 ~S ~S" view flavor)))(#_debugstr p))
            (with-drag-flavor (item-reference flavor data-ptr data-size)
              ;; data-ptr should be a view but it ain't under OSX
              (with-pstrs ((p (format nil "receive-drdi4 ~S ~S ~s" view flavor data-ptr)))(#_debugstr p))
              (setf result (drag-receive-dropped-flavor view
                                                        flavor
                                                        data-ptr
                                                        data-size
                                                        item-reference)))
            (if result
              (return-from flavor-loop))))))
    result))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Another way of processing dropped data.  This method is called with the
;; appropriate arguments if the view has provided a list of acceptable flavors
;; through the #'drag-accepted-flavor-list call.
;;
(defmethod drag-receive-dropped-flavor ((view drag-view-mixin) (flavor keyword)
                                        (data-ptr macptr) (data-size integer)
                                        (item-reference integer))
  (declare (ignore view flavor data-ptr data-size item-reference))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Boolean indicating whether it's appropriate to begin a drag or not.
;; Should take into account such things as hilited items, where the mouse
;; is, etc..  The mouse position is in local coordinates.
;;
(defmethod drag-selection-p ((view t) local-mouse-position)
  (declare (ignore view local-mouse-position))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called during a new drag from your view.  This is where you add the drag
;; flavors and data to the drag.  You *must* specialize this method!
;;
(defmethod drag-add-drag-contents ((view drag-view-mixin))
  (declare (ignore view))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Called when destination needs flavor data that was not provided when the
;; flavor was added through #'drag-add-drag-contents.  The view argument
;; will be the view the drag initiated from.  Note that the 'flavor argument
;; is an OSType.
;;
(defmethod drag-fulfill-promise ((view drag-view-mixin) (item-reference integer)
                                 (flavor keyword) (target-description t))
  (declare (ignore view target-description item-reference flavor))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Returns the number of items in a drag.
;;
(defun drag-count-items ()
  (if (dragging-now-p)
    (rlet ((count :signed-integer))
      (oserr-check (#_CountDragItems (drag-get-drag-reference) count))
      (%get-word count))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Returns the drag item reference number of the nth item.
;;
(defun drag-get-item-reference-number (&optional (nth-item 1))
  (if (dragging-now-p)
    (rlet ((item :ItemReference))
      (oserr-check (#_GetDragItemReferenceNumber (drag-get-drag-reference)
                    nth-item item))
      (%get-long item))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Boolean indicating whether a particular flavor in an item is available.  Note
;; that the 'flavor argument is an OSType.
;;
(defmethod drag-flavor-exists-p ((item-reference integer) (flavor keyword))
  (if (drag-get-flavor-flags item-reference flavor)
    t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Returns the number of flavors in a given drag item.
;;
(defmethod drag-count-flavors ((item-reference integer))
  (if (dragging-now-p)
    (rlet ((count :signed-integer))
      (let ((err (#_CountDragItemFlavors (drag-get-drag-reference)
                  item-reference count)))
        (if (eql err #$noErr)
          (%get-word count)
          0)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Obtains the indexed flavor type (an OSType) for a given item.
;;
(defmethod drag-get-flavor-type ((item-reference integer)
                                 &optional (nth-flavor 1))
  (if (dragging-now-p)
    (rlet ((flavor :ostype))
      (let ((err (#_GetFlavorType (drag-get-drag-reference) item-reference
                  nth-flavor flavor)))
        (if (eql err #$noErr)
          (%get-ostype flavor))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Build a list of flavor types for the given drag item.  The position of types in
;; the returned list is the same as the relative ordering in the actual drag item.
;;
(defmethod drag-get-flavor-type-list ((item-reference integer))
  (if (dragging-now-p)
    (let ((flavor-list nil)
          (count (drag-count-flavors item-reference)))
      (dotimes (index count)
        (push (drag-get-flavor-type item-reference (1+ index)) flavor-list))
      (reverse flavor-list))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Obtains the flavor flags for a given item and converts them into keyword-
;; equivalents.  Note that the 'flavor argument is an OSType.
;;
(defmethod drag-get-flavor-flags ((item-reference integer) (flavor keyword))
  (if (dragging-now-p)
    (rlet ((flags :FlavorFlags))
      (let ((err (#_GetFlavorFlags (drag-get-drag-reference) item-reference
                  flavor flags)))
        (if (eql err #$noErr)
          (case (%get-unsigned-long flags)
            (#.#$flavorSenderOnly :internal-only)
            (#.#$flavorSenderTranslated :sender-translated)
            (#.#$flavorNotSaved :not-saved)
            (#.#$flavorSystemTranslated :system-translated)
            (t (%get-unsigned-long flags))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Obtains the size of the data stored as a particular flavor.  Note that the
;; 'flavor argument is an OSType.
;;
(defmethod drag-get-flavor-size ((item-reference integer) (flavor keyword))
  (if (dragging-now-p)
    (rlet ((size :size))
      (oserr-check (#_GetFlavorDataSize (drag-get-drag-reference) item-reference
                    flavor size))
      (%get-long size))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Obtains the data for a particular item's flavor.  Note that the 'flavor argument
;; is an OSType.
;;
;; The returned value will be nil if no flavor was found in the cited item.
;; If the data is an internal MCL object, the returned value will be that
;; object.  If the data is extracted through the Drag Manager, the returned
;; value will be a Macintosh pointer to that data -- that pointer must
;; be eventually disposed of with a call to #_DisposePtr.
;;
(defmethod drag-get-flavor-data ((item-reference integer) (flavor keyword))
  (if (dragging-now-p)
    (let ((internal-data (assoc (cons item-reference flavor)
                                (internal-data *drag-session*)
                                :test 'equal))
          (data-or-ptr nil))
      (with-pstrs ((p (format nil "look for ref ~s flavor ~s int-data ~s session ~S"
                              item-reference flavor (internal-data *drag-session*) *drag-session*)))
        (#_debugstr p))
      (if internal-data
        (progn (with-pstrs ((p (format nil "data is internal ~s" internal-data)))(#_debugstr p))
               (setf data-or-ptr (cdr internal-data)))
        (let ((size (drag-get-flavor-size item-reference flavor)))
          (with-pstrs ((p "data aint internal"))(#_debugstr p))
          (rlet ((size-ptr :size))
            (when (and (numberp size) (plusp size))
              (%put-long size-ptr size)
              (setf data-or-ptr (#_NewPtr size))
              (oserr-check (#_GetFlavorData (drag-get-drag-reference) item-reference
                            flavor data-or-ptr size-ptr 0))))))
      data-or-ptr)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Here's where you add a flavor and data to a drag initiated within MCL.
;;
(defmethod drag-add-item-flavor ((item-reference integer) (flavor keyword)
                                 (item-ptr macptr) (item-size integer)
                                 &optional (flavor-flag nil))
  (when (eql (drag-state *drag-session*) :setup)
    (let ((flag-value (case flavor-flag
                        (:internal-only #.#$flavorSenderOnly)
                        (:sender-translated #.#$flavorSenderTranslated)
                        (:not-saved #.#$flavorNotSaved)
                        (:system-translated #.#$flavorSystemTranslated)
                        (t 0))))
      (oserr-check (#_AddDragItemFlavor (drag-get-drag-reference) item-reference
                    flavor item-ptr item-size flag-value)))
    t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Setting a flavor's data (usually called from the #'drag-fulfill-promise method)
;;
(defmethod drag-set-item-flavor ((item-reference integer) (flavor keyword)
                                 (item-ptr macptr) (item-size integer)
                                 &optional (offset 0))
  (when (dragging-now-p)
    (oserr-check (#_SetDragItemFlavorData (drag-get-drag-reference) item-reference
                  flavor item-ptr item-size offset))
    t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Like #'drag-add-item-flavor, this method identifies a flavor for an item
;; but, unlike #'drag-add-item-flavor, it does not actually provide any of the
;; flavor data.  If the receiving application requests the flavor,
;; #'drag-fulfill-promise will be called to provide that data.  Due to the
;; fact that little data is posted to the Drag Manager, and that you don't
;; have to spend time up-front creating data flavors that may never be used,
;; this method is preferable to #'drag-add-item-flavor.
;;
(defmethod drag-promise-item-flavor ((item-reference integer) (flavor keyword)
                                     &optional (flavor-flag nil))
  (drag-add-item-flavor item-reference flavor (%null-ptr) 0 flavor-flag))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This method allows you to pass MCL objects to another portion of MCL through
;; the Drag Manager.  See comments for #'drag-receive-dropped-flavor for info
;; on how to receive these objects.  Note that the objects are tagged to be
;; visible only to MCL image that generated the drag; outside applications
;; cannot see these flavors at all.
;;
(defmethod drag-add-mcl-object-flavor ((item-reference integer)
                                       (flavor keyword)
                                       (thing t))(ed-beep)
  
  (with-pstrs ((p (format nil "add ref ~s kwd ~s thing ~s state ~S session ~S"
                          item-reference flavor thing (drag-state *drag-session*) *drag-session*)))
    (#_debugstr p))
  (if (eql (drag-state *drag-session*) :setup)
    (let ((key (cons item-reference flavor)))
      (if (assoc key (internal-data *drag-session*))
        (setf (cdr (assoc key (internal-data *drag-session*))) thing)
        (push (cons key thing) (internal-data *drag-session*)))
      (rlet ((flavor-ptr :OSType))
        (%put-ostype flavor-ptr (format nil "~A" flavor))
        (drag-add-item-flavor item-reference flavor flavor-ptr 4 :internal-only))
      t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; A convenience method for adding an HFS object flavor to a drag.  You can do
;; this manually by creating a FSSpec record yourself, then calling
;; #'drag-add-item-flavor with the appropriate arguments.
;;
(defmethod drag-add-hfs-flavor ((item-reference integer) (flavor keyword) (path t)
                                &optional
                                (flavor-flag nil))
  (if (eql (drag-state *drag-session*) :setup)
    (let ((result nil))
      (when (or (pathnamep path) (stringp path))
        (with-pstrs ((path-str (mac-namestring path)))
          (rlet (($hfs :HFSFlavor)
                 ($fs :pointer)
                 ($info :FInfo))
            (%setf-macptr $fs (%int-to-ptr (+ (%ptr-to-int $hfs)
                                              #.(get-field-offset :HFSFlavor.fileSpec))))
            (oserr-check (#_FSMakeFSSpec 0 0 path-str $fs))
            (oserr-check (#_FSPGetFInfo $fs $info))
            (setf (pref $hfs :HFSFlavor.fdFlags) (pref $info :FInfo.fdFlags)
                  (pref $hfs :HFSFlavor.fileType) (pref $info :FInfo.fdType)
                  (pref $hfs :HFSFlavor.fileCreator) (pref $info :FInfo.fdCreator))
            (setf result (drag-add-item-flavor item-reference flavor
                                               $hfs #.(record-length :HFSFlavor)
                                               flavor-flag)))))
      result)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; A convenience method for providing data to an HFS flavor object.  This method
;; is usually called from within #'drag-fulfill-promise.  You can do perform
;; this command manually by creating a FSSpec record yourself, then calling
;; #'drag-set-item-flavor with the appropriate arguments.
;;
(defmethod drag-set-hfs-flavor ((item-reference integer) (flavor keyword) (path t))
  (if (dragging-now-p)
    (let ((result nil))
      (when (or (pathnamep path) (stringp path))
        (with-pstrs ((path-str (mac-namestring path)))
          (rlet (($filespec :FSSpec))
            (oserr-check (#_FSMakeFSSpec 0 0 path-str $filespec))
            (setf result (drag-set-item-flavor item-reference flavor
                                               $filespec #.(record-length :FSSpec))))))
      result)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Promising HFS objects.
;;
;; Promising an HFS object involves a bizarre little two-step inside Drag Manager
;; callback routines.  Basically, if you promise an HFS object then you should
;; also include a #'drag-fulfill-promise method that is specialized on both your view and
;; on the flavor specified in the 'promised-flavor argument.  Your #'drag-fulfill-promise
;; method should then create the file and set the flavor's data with a call to
;; #'drag-set-hfs-flavor.
;;
;; By way of clarification:  The 'flavor argument is the flavor of the promise, while
;; the 'promised-flavor keyword is the flavor of the FSSpec (and hence, the HFS object)
;; you intend to deliver on demand.
;;
(defmethod drag-promise-hfs-flavor ((item-reference integer) (file-creator keyword)
                                    (file-type keyword) (flavor keyword)
                                    (promised-flavor keyword)
                                    &key
                                    (flavor-flag nil)
                                    (finder-flags nil))
  (if (eql (drag-state *drag-session*) :setup)
    (let ((finder-flag-value 0))
      ; determine Toolbox value for Finder flags
      (if (and finder-flags
               (not (consp finder-flags)))
        (setf finder-flags (list finder-flags)))
      (if (position :has-been-inited finder-flags)
        (incf finder-flag-value #x0100))                ; #$kHasBeenInited
      (if (position :is-stationery finder-flags)
        (incf finder-flag-value #x0800))                ; #$kIsStationery
      (if (position :name-locked finder-flags)
        (incf finder-flag-value #x1000))                ; #$kNameLocked
      (if (position :has-bundle finder-flags)
        (incf finder-flag-value #x2000))                ; #$kHasBundle
      (if (position :is-invisible finder-flags)
        (incf finder-flag-value #x4000))                ; #$kIsInvisible
      (if (position :is-alias finder-flags)
        (incf finder-flag-value #x8000))                ; #$kIsAlias
      (rlet (($promise :PromiseHFSFlavor
                       :fileType file-type
                       :fileCreator file-creator
                       :fdFlags finder-flag-value
                       :promisedFlavor promised-flavor))
        (drag-add-item-flavor item-reference flavor
                              $promise #.(record-length :PromiseHFSFlavor)
                              flavor-flag)
        (drag-promise-item-flavor item-reference promised-flavor)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Extracts the Finder information from an HFS flavor and returns four values:
;;
;;  Pathname to the cited HFS object
;;  Finder File Creator, an OSType/keyword
;;  Finder File Type, an OSType/keyword
;;  Finder Flags, an integer
;;
;; Method accepts either an item reference number (indicating that the data
;; should be pulled from the Drag Manager) or a Macintosh pointer (which should
;; be a pointer to the HFS flavor data itself).
;;
(defmethod drag-get-hfs-flavor ((item-ref-or-ptr macptr) (hfs-flavor t)
                                &optional (resolve-aliases-p nil))
  (declare (ignore hfs-flavor))
  (let ((path nil))
    (if resolve-aliases-p
      (setf path (%resolve-alias-file-without-dialog (pref item-ref-or-ptr :HFSFlavor.fileSpec)))
      (setf path (%path-from-filespec (pref item-ref-or-ptr :HFSFlavor.fileSpec))))
    (values path
            (pref item-ref-or-ptr :HFSFlavor.fileCreator)
            (pref item-ref-or-ptr :HFSFlavor.fileType)
            (pref item-ref-or-ptr :HFSFlavor.fdFlags))))

(defmethod drag-get-hfs-flavor ((item-ref-or-ptr integer) (hfs-flavor keyword)
                                &optional (resolve-aliases-p nil))
  (if (dragging-now-p)
    (let ((hfs-path nil)
          (file-creator nil)
          (file-type nil)
          (finder-flags nil))
      (with-drag-flavor (item-ref-or-ptr hfs-flavor data-ptr data-size)
        (declare (ignore data-size))
        (multiple-value-setq (hfs-path file-creator file-type finder-flags)
          (drag-get-hfs-flavor data-ptr nil resolve-aliases-p)))
      (values hfs-path file-creator file-type finder-flags))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Method obtains the information from a promised HFS object flavor and
;; returns some useful Finder information regarding the promised object.
;; Multiple values are passed back; they are:
;;
;;   Finder Creator Type
;;   Finder File Type
;;   Finder Flags
;;   Promised Flavor Type
;;
;; Method accepts either an item reference number (indicating that the data
;; should be pulled from the Drag Manager) or a Macintosh pointer (which should
;; be a pointer to the promised HFS flavor data itself).
;;
(defmethod drag-get-promised-hfs-flavor ((item-ref-or-ptr macptr)
                                         (promised-flavor t))
  (declare (ignore promised-flavor))
  (values (pref item-ref-or-ptr :PromiseHFSFlavor.fileCreator)
          (pref item-ref-or-ptr :PromiseHFSFlavor.fileType)
          (pref item-ref-or-ptr :PromiseHFSFlavor.fdFlags)
          (pref item-ref-or-ptr :PromiseHFSFlavor.promisedFlavor)))

(defmethod drag-get-promised-hfs-flavor ((item-ref-or-ptr integer)
                                         (promised-flavor keyword))
  (when (dragging-now-p)
    (let ((creator-type nil)
          (file-type nil)
          (flags nil)
          (promised-hfs-flavor nil))
      (with-drag-flavor (item-ref-or-ptr promised-flavor promised-info data-size)
        (if (eql data-size #.(record-length :PromiseHFSFlavor))
          (multiple-value-setq (creator-type file-type flags promised-hfs-flavor)
            (drag-get-promised-hfs-flavor promised-info t))))
      (values creator-type file-type flags promised-hfs-flavor))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This method is basically just a convenience.  Given an item reference and
;; the flavor of a promised HFS object, it obtains the promised HFS flavor
;; information then turns around and requests information for the actual HFS
;; flavor cited by the promised flavor, then finally resolves the resulting
;; FSSpec into a path.  It returns multiple values, which are:
;;
;;  Pathname to the cited HFS object
;;  Finder File Creator, an OSType/keyword
;;  Finder File Type, an OSType/keyword
;;  Finder Flags, an integer
;;
(defmethod drag-resolve-promised-hfs-flavor ((item-reference integer) (promised-hfs-flavor keyword)
                                             &optional (resolve-aliases-p nil))
  (when (dragging-now-p)
    (let ((path nil))
      (multiple-value-bind (creator-type file-type flags hfs-flavor)
                           (drag-get-promised-hfs-flavor item-reference promised-hfs-flavor)
        (when hfs-flavor
          (with-drag-flavor (item-reference hfs-flavor hfs-ptr ptr-size)
            (declare (ignore ptr-size))
            (if resolve-aliases-p
              (setf path (%resolve-alias-file-without-dialog hfs-ptr))
              (setf path (%path-from-filespec hfs-ptr)))))
        (values path creator-type file-type flags)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Returns the Apple Event Descriptor record identifying the location of a drop.
;; Note that the receiving application typically sets this, and it may *not*
;; be set at all -- nil will be returned if that is the case.
;;
;; This method stashes a copy of the drop location descriptor in the global
;; *drag-session* object so it may be safely disposed of when the drag has
;; completed.  A caller to this function should *not* dispose of the returned
;; descriptor record.
;;
(defun drag-get-drop-location-descriptor ()
  (when (dragging-now-p)
    (unless (%null-ptr-p (drop-location-aedesc *drag-session*))
      (#_AEDisposeDesc (drop-location-aedesc *drag-session*)))
    (setf (drop-location-aedesc *drag-session*) (make-record :AEDesc))
    (oserr-check (#_GetDropLocation (drag-get-drag-reference)
                  (drop-location-aedesc *drag-session*)))
    (if (and (not (%null-ptr-p (drop-location-aedesc *drag-session*)))
             (neq (rref (drop-location-aedesc *drag-session*) :AEDesc.descriptorType)
                  #$typeNull))
      (drop-location-aedesc *drag-session*))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Basically calls #'drag-get-drop-location-descriptor and converts it to
;; an MCL pathname if possible.
;;
(defun drag-get-drop-location-as-path ()
  (let ((drop-location (drag-get-drop-location-descriptor)))
    (if drop-location
      (%resolve-alias-handle-without-dialog (rref drop-location :AEDesc.dataHandle)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Three functions for setting the drop descriptor, depending on the
;; argument.  There is a version of an Apple Event Descriptor record (as if
;; generated using the 'with-aedescs macro); a version that accepts a handle
;; to an actual alias; and a version that accepts an MCL path.
;;
(defun drag-set-drop-location-descriptor (ae-drop-descriptor)
  (when (dragging-now-p)
    (oserr-check (#_SetDropLocation (drag-get-drag-reference) ae-drop-descriptor))
    ae-drop-descriptor))

(defun drag-set-drop-location-from-alias (alias-handle)
  (when (dragging-now-p)
    (with-aedescs (drop-desc)
      (with-dereferenced-handles ((alias-ptr alias-handle))
        (oserr-check (#_AECreateDesc #$typeAlias alias-ptr
                      (#_GetHandleSize alias-handle) drop-desc))
        (if (drag-set-drop-location-descriptor drop-desc)
          alias-handle)))))

(defun drag-set-drop-location-from-path (path)
  (when (dragging-now-p)
    (let ((path-name (mac-namestring path))
          (result nil))
      (with-cstrs ((path-string path-name))
        (rlet ((alias :AliasHandle))
          (unwind-protect
            (progn
              (oserr-check (#_NewAliasMinimalFromFullPath (length path-name)
                            path-string (%null-ptr) (%null-ptr) alias))
              (if (drag-set-drop-location-from-alias (%get-ptr alias))
                (setf result path)))
            (unless (%null-ptr-p (%get-ptr alias))
              (#_DisposeHandle (%get-ptr alias))))))
      result)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This function attempts to summarize the destination of a drop.  If the drag
;; was initiated within MCL and the receiving application requests promised
;; data, then the subsequent call to #'drag-fulfill-promise uses the results
;; from this function as one of the arguments.
;;
;; If successful, returns a cons containing the following:
;;
;;     CAR                CDR
;;     :same-view         the view that is receiving the drop
;;     :same-window       the view that is receiving the drop
;;     :same-application  the view that is receiving the drop
;;     :finder-trash      pathname to local Trash
;;     :finder-file       pathname to Finder file or folder
;;
(defun drag-get-target-description (&optional (resolve-aliases-p nil))
  (when (dragging-now-p)
    (let ((description nil))
      (if (drag-get-current-view)
        (setf description (cond ((eql (drag-get-current-view) (drag-get-source-view))
                                 (cons :same-view (drag-get-current-view)))
                                ((and (drag-get-source-view)
                                      (eql (view-window (drag-get-current-view))
                                           (view-window (drag-get-source-view))))
                                 (cons :same-window (drag-get-current-view)))
                                (t
                                 (cons :same-application (drag-get-current-view)))))
        (let ((drop-location (drag-get-drop-location-as-path)))
          (when drop-location
            (let ((resolved-drop (or (%resolve-alias-file-without-dialog drop-location)
                                     drop-location)))
              (if resolve-aliases-p
                (setf drop-location resolved-drop))
              (if (equalp resolved-drop (%special-folder-path :trash))
                (setf description (cons :finder-trash resolved-drop))
                (setf description (cons :finder-file drop-location)))))))
      description)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Returns the original mouse location (where the drag started) in either
;; global coordinates or a view's local coordinates, depending on the argument.
;;
;; This method works only during a drag.
;;
(defmethod drag-mouse-original-position ((view NULL))
  (when (dragging-now-p)
    (rlet ((mouse :point))
      (oserr-check (#_GetDragOrigin (drag-get-drag-reference) mouse))
      (%get-long mouse))))

(defmethod drag-mouse-original-position ((view simple-view))
  (if (dragging-now-p)
    (global-to-local view (drag-mouse-original-position nil))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Returns the current pinned mouse location in either global coordinates or a
;; view's local coordinates, depending on the argument.
;;
;; This method works only during a drag.
;;
(defmethod drag-mouse-position ((view NULL) &optional (pinned-p nil))
  (when (dragging-now-p)
    (rlet ((mouse :point)
           (pinned-mouse :point))
      (oserr-check (#_GetDragMouse (drag-get-drag-reference) mouse pinned-mouse))
      (if pinned-p
        (%get-long pinned-mouse)
        (%get-long mouse)))))

(defmethod drag-mouse-position ((view simple-view) &optional (pinned-p nil))
  (if (dragging-now-p)
    (global-to-local view (drag-mouse-position nil pinned-p))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Returns the pinned mouse location of the drop in either global coordinates
;; or a view's local coordinates, depending on the argument.  If coordinates
;; had been provided through a specialization of #'drag-caret-position-from-mouse
;; then those coordinates are returned; otherwise, the actual mouse location
;; is returned.  If the drop has not yet occurred then the method will return
;; a (0 0) point.
;;
;; This method works only during a drag.
;;
(defmethod drag-mouse-drop-position ((view simple-view) &optional (pinned-p nil))
  (drag-mouse-position view pinned-p))

(defmethod drag-mouse-drop-position ((view NULL) &optional (pinned-p nil))
  (drag-mouse-position view pinned-p))

(defmethod drag-mouse-drop-position ((view drag-view-mixin) &optional (pinned-p nil))
  (if (dragging-now-p)
    (if (drag-draw-caret-p view)
      (last-caret-position *drag-session*)
      (drag-mouse-position view pinned-p))
    (make-point 0 0)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Returns the view the pinned mouse is currently over, whether the view is
;; drag-aware or not.  This method works only during a drag.
;;
(defmethod drag-mouse-view ((window window) &optional (pinned-p nil))
  (if (dragging-now-p)
    (or (find-view-containing-point window
                                    (drag-mouse-position window pinned-p)
                                    nil
                                    nil)
        window)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Returns the view the pinned mouse is currently over, whether the view is
;; drag-aware or not.  This method works only during a drag.
;;
(defmethod drag-set-mouse-position ((view NULL) (new-position integer))
  (when (dragging-now-p)
    (oserr-check (#_SetDragMouse (drag-get-drag-reference) new-position))
    new-position))

(defmethod drag-set-mouse-position ((view simple-view) (new-position integer))
  (let ((global-mouse (local-to-global view new-position)))
    (drag-set-mouse-position nil global-mouse)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Macro hides the drag hilite for a view, if necessary, then executes the body
;; and restores the hilite (again if necessary).  This technique is used when
;; scrolling many views in MCL which completely repaint themselves in order to
;; scroll.
;;
(defmacro with-saved-drag-hilite ((view) &body body)
  (let ((hilite-p (gensym))
        (result (gensym)))
    `(let ((,hilite-p (dr-hilite-p ,view))
           (,result nil))
       (if ,hilite-p
         (drag-hide-drag-hilite ,view))
       (unwind-protect
         (setf ,result (progn ,@body))
         (if ,hilite-p
           (drag-show-drag-hilite ,view)))
       ,result)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Shows the Drag Manager's default hiliting of destination windows (drawing
;; the gray border around the inside of the window's edge).  If coordinates
;; are provided in the topleft and bottomright optional arguments, they should
;; be in the view-window's coordinate system.
;;
(defmethod drag-show-drag-hilite ((view t)
                                  &optional
                                  (topleft nil) (bottomright nil))
  (declare (ignore view hilite-p topleft bottomright))
  nil)

(defmethod drag-show-drag-hilite ((view drag-view-mixin)
                                  &optional
                                  (topleft nil) (bottomright nil))
  (let ((region (drag-make-drag-hilite-region view topleft bottomright)))
    (with-focused-view (view-window view)
      (oserr-check (#_ShowDragHilite (drag-get-drag-reference) region t)))
    (dispose-region region)
    (setf (dr-hilite-p view) t))
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Hides the previously-drawn drag hilite, if it shown.
;;
(defmethod drag-hide-drag-hilite ((view t))
  (declare (ignore view))
  nil)

(defmethod drag-hide-drag-hilite ((view drag-view-mixin))
  (with-focused-view (view-window view)
    (oserr-check (#_HideDragHilite (drag-get-drag-reference))))
  (setf (dr-hilite-p view) nil)
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This method creates the region that will be used by the Drag Manager to
;; build the drag hilite.  The Drag Manager assumes that the region encompasses
;; the entire draggable area; it will then create a gray border just inside
;; the borders of this region.  This default version returns a region that
;; matches the view's rectangular borders.
;;
(defmethod drag-make-drag-hilite-region ((view drag-view-mixin)
                                         &optional
                                         (topleft nil) (bottomright nil))
  (let* ((region (new-region))
         (topcorner topleft)
         (bottomcorner bottomright)
         (window-p (eql view (view-window view))))
    (unless (integerp topcorner)
      (if window-p
        (setf topcorner #@(0 0))
        (progn
          (setf topcorner (convert-coordinates #@(0 0) view (view-window view)))
          (setf topcorner (subtract-points topcorner #@(2 2))))))
    (unless (integerp bottomcorner)
      (if window-p
        (setf bottomcorner (view-size view))
        (progn
          (setf bottomcorner (add-points topcorner (view-size view)))
          (setf bottomcorner (add-points bottomcorner #@(4 4))))))
    (set-rect-region region topcorner bottomcorner)
    region))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; The auto-scroll region determines the area the mouse may move into to
;; trigger automatic scrolling in a view.  The default version of the method
;; uses the region returned by #'drag-make-drag-hilite-region as a basis,
;; then forms a thick line at the region's border.  The thickness of that
;; line is determined by the constant $DragScrollRegionThickness, a point.
;;
(defmethod drag-make-auto-scroll-region ((view drag-view-mixin)
                                         &optional
                                         (topleft nil) (bottomright nil))
  (let* ((region (drag-make-drag-hilite-region view topleft bottomright))
         (outline-region (copy-region region)))
    (inset-region outline-region $DragScrollRegionThickness)
    (difference-region region outline-region outline-region)
    (dispose-region region)
    outline-region))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; The Drag Manager has a pair of optimized routines for dealing with the drag
;; hilite region during a scroll.  This macro helps implement that.  The two
;; arguments should be the amount that the view will scroll, in pixels.  If
;; the 'delta-v argument is not given then 'delta-h is assumed to be a point.
;;
(defmacro with-drag-scroll ((delta-h &optional (delta-v nil))
                            &body body)
  (let ((result (gensym))
        (delta-pt (gensym)))
    `(let ((,result nil)
           (,delta-pt (make-point ,delta-h ,delta-v)))
       (when (dragging-now-p)
         (require-trap #_DragPreScroll (drag-get-drag-reference) (point-h ,delta-pt) (point-v ,delta-pt))
         (setf ,result (progn ,@body))
         (require-trap #_DragPostScroll (drag-get-drag-reference)))
       ,result)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Implements the automatic scrolling of a view during a drag operation.  It's
;; primary caller is #'drag-tracking-in-view, and it receives a simple direction
;; keyword indicating the direction to scroll.
;;
;; The default version performs scrolling via MCL's #'set-view-scroll-position
;; method, which is not appropriate for all views (eg, fred views), and provides
;; for optimized drag hilite redrawing.  Override this method if the view
;; does not support #'set-view-scroll-position or does not scroll in the
;; standard manner.
;;
(defmethod drag-scroll-view ((view t) direction-or-point)
  (declare (ignore view direction-or-point))
  nil)

(defmethod drag-scroll-view ((view view) (direction-or-point integer))
  (if (dragging-now-p)
    (let ((current-scroll (view-scroll-position view)))
      (with-drag-scroll (direction-or-point)
        (set-view-scroll-position view (add-points current-scroll direction-or-point)))
      t)))

(defmethod drag-scroll-view ((view view) (direction-or-point keyword))
  (if (dragging-now-p)
    (let* ((default-h (point-h (dr-scroll-amount view)))
           (default-v (point-v (dr-scroll-amount view)))
           (delta (case direction-or-point
                    (:up (make-point 0 (- default-v)))
                    (:down (make-point 0 default-v))
                    (:left (make-point (- default-h) 0))
                    (:right (make-point default-h 0))
                    (t nil))))
      (if delta
        (drag-scroll-view view delta)))))

(defmethod drag-scroll-view ((view fred-mixin) (direction-or-point keyword))
  (when (dragging-now-p)
    (without-interrupts
     (with-saved-drag-hilite (view)
       (case direction-or-point
         (:left
          (set-fred-hscroll view (- (fred-hscroll view) 12)))
         (:right
          (set-fred-hscroll view (+ (fred-hscroll view) 12)))
         (:up
          (set-fred-display-start-mark view
                                       (frec-screen-line-start (frec view)
                                                               (fred-display-start-mark view)
                                                               -1)))
         (:down
          (set-fred-display-start-mark view
                                       (frec-screen-line-start (frec view)
                                                               (fred-display-start-mark view)
                                                               1))))
       (fred-update view)))
    t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Methods pertaining the drawing and moving of a drag caret -- a visual
;; indicator of where a drop will occur within a view  Each view may have a
;; different idea of what a caret looks like (eg, text windows will draw
;; a vertical bar but that wouldn't be appropriate for all cases) or they
;; may have none at all.  These methods are provided for structure only, and
;; do not actually draw a caret.
;;
;; Users should override both #'drag-draw-caret-p and #'drag-draw-caret methods.
;;
(defmethod drag-draw-caret-p ((view t))
  (declare (ignore view))
  nil)

(defmethod drag-draw-caret ((view t) local-position shown-p)
  (declare (ignore view local-position shown-p))
  nil)

(defmethod %drag-show-caret ((view t) local-position)
  (declare (ignore view local-position))
  nil)

(defmethod %drag-show-caret ((view drag-view-mixin) local-position)
  (with-focused-view view
    (if (caret-shown-p *drag-session*)
      (drag-draw-caret view (last-caret-position *drag-session*) nil))
    (drag-draw-caret view local-position t))
  (setf (last-caret-position *drag-session*) local-position
        (caret-shown-p *drag-session*) t)
  t)

(defmethod %drag-hide-caret ((view t))
  (declare (ignore view))
  nil)

(defmethod %drag-hide-caret ((view drag-view-mixin))
  (when (caret-shown-p *drag-session*)
    (with-focused-view view
      (drag-draw-caret view (last-caret-position *drag-session*) nil))
    (setf (caret-shown-p *drag-session*) nil))
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Method returns a point in the view's local coordinate system that determines
;; the placement of a drag caret.  This point will be passed to #'drag-draw-caret.
;; The default version simply returns the mouse position passed to it.
;;
(defmethod drag-caret-position-from-mouse ((view t) local-mouse-position)
  local-mouse-position)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Get the highlighted region of a TextEdit record.  If you don't supply a region
;; to modify then remember to dispose of the result with #'dispose-region!
;;
(defmethod drag-te-hilite-region ((view simple-view) &optional (region (new-region)))
  (with-focused-view view
    (oserr-check (#_TEGetHiliteRgn region (dialog-item-handle view))))
  region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Function creates the little gray areas the Drag Manager manipulates during an
;; MCL-initiated drag. The item-region argument should be a Macintosh region that
;; defines the item's area; specifying a non-nil for the optional outline-p argument
;; will cause the function to install an outline of the item's region instead.
;;
(defmethod drag-create-item-bounds ((view simple-view) (item-reference integer)
                                    (item-region macptr) &optional (outline-p t))
  (when (dragging-now-p)
    (with-focused-view view
      (let ((temp-region (copy-region item-region))
            (global-point (local-to-global view (make-point 0))))
        (when outline-p
          (#_InsetRgn temp-region 1 1)
          (#_DiffRgn item-region temp-region temp-region))
        (#_OffsetRgn temp-region (point-h global-point) (point-v global-point))
        (#_UnionRgn temp-region (drag-region *drag-session*) (drag-region *drag-session*))
        
        (rlet ((rgn-rect :rect))
          (#_getregionbounds (drag-region *drag-session*) rgn-rect)
          (oserr-check (#_SetDragItemBounds (drag-get-drag-reference) item-reference
                        rgn-rect)))))
    t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; drag-zoom-rectangle
;;
;; This method animates a movement between two rectangles on the screen.  The
;; 'zoom-steps argument specifies the number of incremental drawings between the
;; source and destination rectangles, and it must be between 4 and 25 (inclusive).
;; 'zoom-speed affects the distance between the incremental drawings, giving the
;; effect of speeding up or slowing down during transit; use :accelerate or
;; :decelerate as possible values (the default is a constant speed).
;;
;; Both 'source-rect and 'dest-rect must be :Rect data structure.
;;
(defmethod drag-zoom-rectangle ((source-rect macptr) (dest-rect macptr) &key
                                (zoom-steps 12) zoom-speed)
  (let ((speed-value (case zoom-speed
                       (:accelerate #$kzoomAccelerate)
                       (:decelerate #$kzoomDecelerate)
                       (t #$kzoomNoAcceleration))))
    (oserr-check (#_ZoomRects source-rect dest-rect zoom-steps speed-value)))
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; drag-zoom-rectangle-points
;;
;; This is simply another way to call #'drag-zoom-rectangle.  It uses points of the
;; rectangles rather than :Rect data structures. See the comments for #'drag-zoom-rectangle.
;;
(defmethod drag-zoom-rectangle-points ((source-topleft integer) (source-bottomright integer)
                                       (dest-topleft integer) (dest-bottomright integer)
                                       &key (zoom-steps 12) zoom-speed)
  (rlet ((source-rect :rect
                      :topleft source-topleft
                      :bottomright source-bottomright)
         (dest-rect :rect
                    :topleft dest-topleft
                    :bottomright dest-bottomright))
    (drag-zoom-rectangle source-rect dest-rect
                         :zoom-steps zoom-steps
                         :zoom-speed zoom-speed)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; drag-zoom-region
;;
;; Method provides similar animation as when Finder icons are moved during a
;; "Clean Up" operation.  The 'region argument should be a valid Macintosh region
;; handle.  'distance is a point specifying the distance to move the region.
;; 'zoom-steps and 'zoom-speed are the same as for #'drag-zoom-rectangle.
;;
(defmethod drag-zoom-region ((region macptr) (distance integer) &key
                             (zoom-steps 12) zoom-speed)
  (let ((speed-value (case zoom-speed
                       (:accelerate #$kzoomAccelerate)
                       (:decelerate #$kzoomDecelerate)
                       (t #$kzoomNoAcceleration))))
    (oserr-check (#_ZoomRegion region distance zoom-steps speed-value)))
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Obtaining the attributes of a particular drag.  General first, then
;; specific predicates.  All functions are valid only during a drag operation.
;;
(defun drag-get-attributes ()
  (if (dragging-now-p)
    (rlet ((flags :DragAttributes))
      (oserr-check (#_GetDragAttributes (drag-get-drag-reference) flags))
      (%get-long flags))))

(defun drag-left-sender-window-p ()
  (if (dragging-now-p)
    (logtest #$kdragHasLeftSenderWindow (drag-get-attributes))))

(defun drag-left-sender-view-p ()
  (if (dragging-now-p)
    (left-source-p *drag-session*)))

(defun drag-within-sender-application-p ()
  (if (dragging-now-p)
    (logtest #$kdragInsideSenderApplication (drag-get-attributes))))

(defun drag-within-sender-window-p ()
  (if (dragging-now-p)
    (logtest #$kdragInsideSenderWindow (drag-get-attributes))))

(defun drag-within-sender-view-p ()
  (if (dragging-now-p)
    (eql (drag-get-source-view) (drag-get-current-view))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Following methods return the state of various keys during a drag.  The optional
;; argument 'when should be one of '(:before :now :after), which corresponds to
;; key states at the beginning of a drag, during a drag and after a drop respectively.
;; The default for 'when is :now.
;;
;; Note that this call is valid ONLY while items are being dragged around.  If
;; the drag originated from within MCL this means after #_TrackDrag is called.
;;
(defun %drag-get-keyboard-modifiers ()
  (let ((now-value 0)
        (before-value 0)
        (after-value 0))
    (if (dragging-now-p)
      (rlet ((currentMods :signed-integer)
             (downMods :signed-integer)
             (upMods :signed-integer))
        (oserr-check (#_GetDragModifiers (drag-get-drag-reference)
                      currentMods downMods upMods))
        (setf now-value (%get-signed-word currentMods)
              before-value (%get-signed-word downMods)
              after-value (%get-signed-word upMods))))
    (values now-value before-value after-value)))

(defun drag-get-keyboard-modifiers (&optional (when :now))
  (multiple-value-bind (current before after) (%drag-get-keyboard-modifiers)
    (case when
      (:before before)
      (:after after)
      (t current))))

(defun drag-command-key-p (&optional (when :now))
  (logtest #$CmdKey (drag-get-keyboard-modifiers when)))

(defun drag-shift-key-p (&optional (when :now))
  (logtest #$shiftKey (drag-get-keyboard-modifiers when)))

(defun drag-control-key-p (&optional (when :now))
  (logtest #$controlKey (drag-get-keyboard-modifiers when)))

(defun drag-option-key-p (&optional (when :now))
  (logtest #$optionKey (drag-get-keyboard-modifiers when)))

(defun drag-caps-lock-key-p (&optional (when :now))
  (logtest #$alphaLock (drag-get-keyboard-modifiers when)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Function that determines if the user is requesting a copy of the drag data,
;; as per the Human Interface Guidelines.
;;
(defun drag-copy-requested-p ()
  (multiple-value-bind (now before after) (%drag-get-keyboard-modifiers)
    (declare (ignore now))
    (or (logtest #$optionKey before)
        (logtest #$optionKey after))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Here's a nice little function that returns a pathname to those "special"
;; folders System 7 maintains.
;;
(defun %special-folder-path (folderkey
                             &key
                             (volume-ref #$kOnSystemDisk)
                             (create-p nil))
  (let ((errnum 0)
        (folder-value (case folderkey
                        (:desktopfolder #$kDesktopFolderType)
                        (:systemfolder #$kSystemFolderType)
                        (:extensions #$kExtensionFolderType)
                        (:startupitems #$kStartupFolderType)
                        (:applemenuitems #$kAppleMenuFolderType)
                        (:controlpanels #$kControlPanelFolderType)
                        (:preferences #$kPreferencesFolderType)
                        (:temporaryitems #$kTemporaryFolderType)
                        (:trash #$kTrashFolderType)
                        (t nil)))
        (create-value (if create-p #$kCreateFolder #$kDontCreateFolder)))
    (when folder-value
      (rlet ((foundvrefnum :signed-integer)
             (founddirid :signed-long)
             (filename (:string 255))
             (fsspec :fsspec))
        (setf errnum (#_FindFolder volume-ref folder-value create-value
                      foundvrefnum founddirid))
        (when (zerop errnum)
          (%put-string filename "")
          (setf errnum (#_FSMakeFSSpec (%get-word foundvrefnum)
                        (%get-signed-long founddirid) filename fsspec))
          (when (zerop errnum)
            (%path-from-filespec fsspec)))))))

;; Similar to the %path-from-fsspec function in the :ccl package, but ensures
;; that the resulting pathname has a terminating delimiter if it specifies
;; a directory.
(defun %path-from-filespec (fsspec)
  (let ((path (%path-from-fsspec fsspec)))
    (when path
      (let ((mac-path (mac-namestring path)))
        (with-pstrs ((pathname mac-path))
          (rlet ((cpb :CInfoPBRec
                      :hfileinfo.ioCompletion (%null-ptr)
                      :hfileinfo.ioNamePtr pathname
                      :hfileinfo.ioVRefNum 0
                      :hfileinfo.ioFDirIndex 0))
            (when (eql (#_PBGetCatInfoSync cpb) #$noErr)
              (if (logbitp 4 (pref cpb :CInfoPBRec.hfileinfo.ioFlAttrib))
                (setf path
                      (make-pathname :directory
                                     (append (pathname-directory path)
                                             (list (mac-file-namestring path)))))))))))
    path))

;; How to resolve an alias without bringing up a dialog box -- which is a big
;; no-no if you're resolving the alias while the Drag Manager has the Process
;; Manager suspended.  Note that PowerTalk completely ignores the #_MatchAlias
;; #$kARMNoUI parameter -- it will bring up a 'please unlock the keychain'
;; dialog no matter what.  Sounds like a bug to me.
;;
;; First we have to define a (basically) do-nothing filter procedure...
#+ignore
(add-pascal-upp-alist 'AliasFilterProc  #'(lambda (procptr)(#_NewAliasFilterUPP procptr)))

(add-pascal-upp-alist-macho 'AliasFilterProc  "NewAliasFilterUPP")

(defpascal AliasFilterProc (:ptr $cpb :ptr $quitFlag :ptr $myData
                                 :word)
  (declare (ignore $cpb $myData))
  (setf (%get-word $quitFlag) #$false)
  #$false)

;; Then we define a few lisp wrappers around #_MatchAlias....
(defun %resolve-alias-handle-without-dialog (alias-handle)
  (let* ((resulting-path nil)
         (search-params (+ #$kARMSearch #$kARMNoUI))
         (err #$noErr))
    (rlet ((max-to-find :signed-integer)
           (found-filespec :FSSpec)
           (needs-update-p :boolean))
      (%put-word max-to-find 1)
      (%put-byte needs-update-p #$false)
      (setf err (#_MatchAlias (%null-ptr) search-params alias-handle max-to-find
                 found-filespec needs-update-p AliasFilterProc (%null-ptr)))
      (if (and (eql err #$noErr) (> (%get-word max-to-find) 0))
        (setf resulting-path (%resolve-alias-file-without-dialog found-filespec))
        (ed-beep)))
    resulting-path))

(defmethod %resolve-alias-file-without-dialog ((path-or-fsspec pathname))
  (rlet ((path-spec :FSSpec))
    (with-pstrs ((p-name (mac-namestring path-or-fsspec)))
      (if (= (#_FSMakeFSSpec 0 0 p-name path-spec) #$noErr)
        (%resolve-alias-file-without-dialog path-spec)))))

(defmethod %resolve-alias-file-without-dialog ((path-or-fsspec macptr))
  (let ((resulting-path nil))
    (rlet ((file-info :FInfo))
      (if (eql (#_FSpGetFInfo path-or-fsspec file-info) #$noErr)
        (if (logbitp 15 (pref file-info :FInfo.fdFlags))
          (let ((file-path (%path-from-filespec path-or-fsspec))
                (res-refnum nil))
            #|(with-pstrs ((res-path (mac-namestring file-path)))
              (setf res-refnum (#_HOpenResFile 0 0  res-path #$fsRDWRperm)))
            |#
            (rlet ((fsref :fsref))
              (make-fsref-from-path-simple (truename file-path) fsref)
              (setq res-refnum (open-resource-file-from-fsref fsref #$fsRDWRperm)))
            (when (neq res-refnum -1)
              (let ((alias-handle nil)
                    (possible-target nil))
                (setf alias-handle (#_Get1IndResource #$rAliasType 1))
                (when (eql (#_ResError) #$noErr)
                  (unwind-protect
                    (progn
                      (#_DetachResource alias-handle)
                      (setf possible-target (%resolve-alias-handle-without-dialog alias-handle))
                      (if possible-target
                        (setf resulting-path (%resolve-alias-file-without-dialog possible-target))))
                    (#_DisposeHandle alias-handle)))))
            (if res-refnum
              (#_CloseResFile res-refnum)))
          (setf resulting-path (%path-from-filespec path-or-fsspec)))
        (setf resulting-path (%path-from-filespec path-or-fsspec))))
    resulting-path))

(provide :drag-and-drop)

