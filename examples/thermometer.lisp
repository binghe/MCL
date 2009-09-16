;-*- Mode: Lisp; Package: CCL -*-

; thermometer.lisp
; A simple thermometer which displays one or more values in a rectangular area.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;;;;;;;;;;;;;;;;;;;;;;
;;
;; Change History
;;
;; (pushnew 'KILL-THERMO-UPDATE-PROCESS *lisp-cleanup-functions*)
;; ------- 5.0b5
;; akh lose unknowable mac heap stuff if osx
;; ------- 5.0b3
;; akh 2 osx fixes - not really right but at least it doesn't crash
;; ------------4.4b2
;; ------------ 4.3b2 
;; 01/27/97 bill Make muldiv work with Alice's bignum optimizations.
;;               Make (muldiv x y 1) work correctly, too.
;; 11/14/96 bill Add a font-spec parameter to file-thermometer.
;;               Compute the window height and baseline positions relative to
;;               that font's size.
;; ------------- 4.0
;; 07/15/96 bill gc-thermometer works with PPC EGC areas.
;; 05/30/96 bill New make-thermo-update-process & kill-thermo-update-process
;;               called from add-thermo-update-function & remove-thermo-update-function
;;               so that the process is only active if there's something to do.
;; ------------- MCL-PPC 3.9
;; 03/28/96 bill (method view-draw-contents (file-thermo-windoid))
;;               no longer tries to print info about a null stream.
;; 03/26/96  gb  lowmem accessors.
;; 03/20/96 bill PPC muldiv now works if the product is a negative fixnum.
;; 03/19/96 bill PPC version of cons-area-sizes knows about :static areas now.
;; 02/05/96 bill PPC versions of muldiv, %dynamic-heap-size, cons-area-sizes
;; 05/10/95 bill Make the file-thermometer show the most recently active file,
;;               instead of the most recently opened one. Also make the window
;;               grow if the text gets too big to fit.
;; ------------- 3.0b1
;; 04/30/93 bill Shorten process name so it fits better in the "Processes" window.
;; 04/21/93 bill move thermo-update definition before process creation
;;               to prevent timing screw.
;; 04/21/93 bill make it a background process
;; 04/07/93 bill use a process instead of %install-periodic-task
;; 02/09/93 bill (muldiv 1 255 1) now returns 255 instead of 256.
;; 03/26/92 wkf  Added handling of PixPats. 
;;               User must make (list PixPat) where a pattern would otherwise be passed.
;; ------------- 2.0
;; 02/23/92 gb   remove redundant EXPORTs.
;; 10/17/91 bill $ptask_draw-flag in %install-periodic-task
;; 09/30/91 bill Flavor's Technology's fix to muldiv
;; 08/12/91 bill add more ignored streams to FILE-THERMOMETER
;; 07/11/91 bill prevent rounding errors in view-draw-contents
;; 07/10/91 bill add static g/i space to GC-THERMOMETER.  Put mac heap on left (low addresses)
;; 07/09/91 bill add gc-theremometer, file-thermometer, some documentation
;;

;;;;;;;;;;;;;;;;;;;;;;
;
; Documentation
;
; (make-instance 'thermometer . initargs)
; The initargs (in additions to those for a SIMPLE-VIEW) are:
;
; :pattern
;    Value is a Mac Pattern (or (list (list PixPat)) on color Macs) record
;    or a list of them using (list PixPat).  Defaults to *black-pattern*.
;    If there are more values than there are patterns, the
;    display code will cycle through the patterns until
;    it runs out of values.
;    The accessor for this slot is named THERMOMETER-PATTERN
; :fill-pattern
;    A Pattern (or (list PixPat)) to fill the empty space with.
;    Defaults to *white-pattern*
;    The accessor for this slot is named THERMOMETER-FILL-PATTERN
; :value-function
;    A function to call whenever the THERMOMETER-UPDATE-VALUES generic-function
;    is called on this THERMOMETER.  Should return a real number or a list of
;    real numbers.  The result becomes the THERMOMETER-VALUE.  The default
;    value is NIL which means the value is not changed by
;    THERMOMETER-UPDATE-VALUES.
;    The accessor for this slot is named THERMOMETER-VALUE-FUNCTION.
; :max-value-function
;    A function to call whenever THERMOMETER-UPDATE-VALUES is called. Should
;    return a positive real number which becomes the THERMOMETER-MAX-VALUE.
;    The default value is NIL, meaning no updating.
;    The accessor for this slot is named THERMOMETER-MAX-VALUE-FUNCTION
; :value
;    Initial state for the value(s) displayed by the thermometer.
;    Should be a real number or a list of real numbers.
;    The accessor for this slot is named THERMOMETER-VALUE
; :max-value
;    Initial state for the maximum-value displayed by the thermometer.
;    Should be a positive real number.
;    The THERMOMETER-VALUE should be less than this number (or the sum
;    of all the values in the list should be less than this number)
;    The accessor for this slot is named THERMOMETER-MAX-VALUE
; :direction
;    Which direction does the thermometer move.  Default is :VERTICAL.
;    The accessor for this slot is named THERMOMETER-DIRECTION.
;    The value of this slot should not be changed after the thermometer
;    has been created.
; :length
;    The length of the thermometer in the THERMOMETER-DIRECTION.
;    Used to set the VIEW-SIZE, when VIEW-SIZE is not explicitly specified
;    The accessor for this slot is named THERMOMETER-LENGTH.
; :width
;    The width of the thermometer in the THERMOMETER-DIRECTION.
;    Used to set the VIEW-SIZE, when VIEW-SIZE is not explicitly specified
;    The accessor for this slot is named THERMOMETER-WIDTH.

; Methods other than the slot accessors:
;
; THERMOMETER-UPDATE-VALUES
;   Takes no arguments.  Calls the THERMOMETER-VALUE-FUNCTION, and
;   THERMOMETER-MAX-VALUE-FUNCTION and updates the THERMOMETER-VALUE and
;   THERMOMETER-MAX-VALUE slots with the results.  Invalidates the
;   THERMOMETER to force redrawing if any values change.

; There is a simple commented-out example in the middle of this file,
; and two real-life examples at the bottom (the functions GC-THERMOMETER &
; FILE-THERMOMETER).

(in-package :ccl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(thermometer thermometer-pattern thermometer-fill-pattern
            thermometer-value-function thermometer-max-value-function
            thermometer-value thermometer-max-value
            thermometer-direction thermometer-length thermometer-width
            thermometer-update-values
            thermo-window thermo-update-function 
            add-thermo-update-function remove-thermo-update-function
            gc-thermometer file-thermometer)))

(defclass thermometer (simple-view)
  ((pattern :initarg :pattern 
            :initform *black-pattern*
            :accessor thermometer-pattern)
   (fill-pattern :initarg :fill-pattern
                 :initform *white-pattern*
                 :accessor thermometer-fill-pattern)
   (value-function :initarg :value-function :initform nil
                   :accessor thermometer-value-function)
   (max-value-function :initarg :max-value-function :initform nil
                       :accessor thermometer-max-value-function)
   (value :initarg :value :initform 0
          :reader thermometer-value :writer (setf thermometer-value-slot))
   (max-value :initarg :max-value :initform 100
              :reader thermometer-max-value :writer (setf thermometer-max-value-slot))
   (direction :initarg :direction :initform :vertical
              :accessor thermometer-direction)
   (length :initarg :length :initform 100
           :reader thermometer-length :writer (setf thermometer-length-slot))
   (width :initarg :width :initform 16
          :reader thermometer-width :writer (setf thermometer-width-slot))))

(defmethod initialize-instance ((self thermometer) &rest rest &key 
                                view-size view-container)
  (declare (dynamic-extent rest))
  (apply #'call-next-method self :view-container nil rest)
  (let ((direction (thermometer-direction self)))
    (if view-size
      (if (eq direction :vertical)
        (setf (thermometer-width-slot self) (point-h view-size)
              (thermometer-length-slot self) (point-v view-size))
        (setf (thermometer-width-slot self) (point-v view-size)
              (thermometer-length-slot self) (point-h view-size)))
      (let ((length (thermometer-length self))
            (width (thermometer-width self)))
        (if (eq direction :vertical)
          (set-view-size self width length)
          (set-view-size self length width)))))
  (if view-container
    (set-view-container self view-container)))

(defmethod view-default-size ((self thermometer))
  (if (eq (thermometer-direction self) :vertical)
    (make-point (thermometer-width self) (thermometer-length self))
    (make-point (thermometer-length self) (thermometer-width self))))

(defmethod (setf thermometer-width) (new-width (self thermometer))
  (let ((length (thermometer-length self)))
    (if (eq (thermometer-direction self) :vertical)
      (set-view-size self new-width length)
      (set-view-size self length new-width))))

(defmethod (setf thermometer-length) (new-length (self thermometer))
  (let ((width (thermometer-width self)))
    (if (eq (thermometer-direction self) :vertical)
      (set-view-size self width new-length)
      (set-view-size self new-length width))))

(defmethod set-view-size ((self thermometer) h &optional v)
  (let ((size (make-point h v)))
    (setq h (point-h size)
          v (point-v size))
    (if (eq (thermometer-direction self) :vertical)
      (setf (thermometer-width-slot self) h
            (thermometer-length-slot self) v)
      (setf (thermometer-width-slot self) v
            (thermometer-length-slot self) h))
    (call-next-method)
    (invalidate-view self)
    size))

(defmethod (setf thermometer-value) (new-value (self thermometer))
  (let ((old-value (thermometer-value self))
        (update? nil))
    (if (and (listp old-value) (listp new-value))
      (if (eql (length old-value) (length new-value))
        (let ((tail old-value))
          (dolist (v new-value)
            (unless (eql v (car tail))
              (setf (car tail) v
                    update? t))
            (pop tail)))
        (setf (thermometer-value self) (copy-list new-value)
              update? t))
      (when (setq update? (not (eql old-value new-value)))
        (setf (thermometer-value-slot self) 
              (if (listp new-value) (copy-list new-value) new-value))))
    (when update?
      (invalidate-view self)))
  new-value)

(defmethod (setf thermometer-max-value) (new-max-value (self thermometer))
  (unless (eql new-max-value (thermometer-max-value self))
    (setf (thermometer-max-value-slot self)
          (if (<= new-max-value 0) 1 new-max-value))
    (invalidate-view self))
  new-max-value)


#-ppc-target
(progn

(eval-when (:compile-toplevel :execute)
  (require 'lapmacros))

(defun muldiv (m1 m2 d)
  (or (and (fixnump m1) (fixnump m2) (fixnump d)
           (>= (the fixnum m1) 0)
           (>= (the fixnum m2) 0)
           (> (the fixnum d) 0)
           (lap-inline (m1 m2 d)
             (getint arg_x)             ; m1
             (getint arg_y)             ; m2
             (getint arg_z)             ; d
             (move.l arg_z db)          ; save for later
             (mulu.l arg_x (arg_x arg_y))
             (divu.l arg_z (arg_x arg_y))
             (if# vs
               (move.l nilreg acc)
               else#
               (move.l arg_y acc)
               (asr.l db)
               (if# (or (lt arg_x db)
                        (and eq 
                             (ne (tst.l arg_x))
                             (ne (btst 0 acc))))
                 (add.l ($ 1) acc))
               (jsr_subprim $sp-mklong))))
      (round (* m1 m2) d)))

)  ; end of #-ppc-target

#+ppc-target
(progn

(eval-when (:compile-toplevel :execute)
  (require "PPC-ARCH"))

; Mostly stolen from multiply-fixnums
(defun muldiv (m1 m2 d)
  (if (and (not (eql d 1)) (fixnump m1) (fixnump m2) (fixnump d))
    (let ((p (%alloc-misc 2 ppc::subtag-bignum 0)))
      (declare (dynamic-extent p))
      (multiple-value-bind (p1 p2 p3 p4) (%multiply-signed-fixnums m1 m2)
        (declare (fixnum p1 p2 p3 p4))
        (%bignum-set p 0 p3 p4)         ; least significant
        (%bignum-set p 1 p1 p2)         ; most significant
        (if (or (and (eql p1 0) (eql p2 0)
                     (< p3 (ash (expt 2 15) (- ppc::fixnum-shift))))
                (and (eql p1 65535) (eql p2 65535)
                     (< (the fixnum (- 65536 p3))
                        (ash (expt 2 16) (- ppc::fixnum-shift)))))
          (round (%normalize-bignum p) d)
          (round p d))))
    (round (* m1 m2) d)))

(defun %dynamic-heap-size ()
  (let ((size 0))
    (do-gc-areas (area)
      (unless (eql (%fixnum-ref area ppc::area.code)
                   ppc::area-dynamic)
        (return))
      (incf size
            (ash (- (%fixnum-ref area ppc::area.high)
                    (%fixnum-ref area ppc::area.low))
                 ppc::fixnum-shift)))
    size))

; Returns three values: g size, i size (always 0), threshold
(defun cons-area-sizes (area-type)
  (%normalize-areas)
  (multiple-value-bind (dynamic static library) (%usedbytes)
    (declare (ignore dynamic))
    (let* ((total-size nil)
           (g-size
            (cond ((eq area-type :dynamic)
                   (let ((last-area (do-gc-areas (area) (return area))))
                     (loop
                       (let ((area (%fixnum-ref last-area ppc::area.older)))
                         (when (eql area 0) (return))
                         (setq last-area area)))
                     (if last-area
                       (let ((low (%fixnum-ref last-area ppc::area.low)))
                         (ash (- (%fixnum-ref last-area ppc::area.active) low)
                              ppc::fixnum-shift))
                       0)))
                  ((eq area-type :static)
                   (+ static library))
                  ((fixnump area-type)
                   (let ((area (do-gc-areas (area) (return area))))
                     (dotimes (i area-type)
                       (when (eql area 0) (return))
                       (setq area (%fixnum-ref area ppc::area.older)))
                     (if (or (eql area 0)
                             (eql (%fixnum-ref area ppc::area.older) 0))
                       0
                       (let* ((low (%fixnum-ref area ppc::area.low))
                              (active (%fixnum-ref area ppc::area.active))
                              (used (- active low)))
                         (when (eql area-type 0)
                           ; overhead + (n * prot-size) >= threshold
                           ; n >= (threshold - overhead) / prot-size
                           ; You can't tell for sure in which protected area the EGC will happen.
                           ; It depends on the size of the object being consed.
                           ; So we round up so that GC will happen before all the white space is filled.
                           (let* ((threshold (%fixnum-ref area ppc::area.threshold))
                                  (softprot (%fixnum-ref area ppc::area.softprot))
                                  (softprot-low (%fixnum-ref softprot ppc::protected-area.start))
                                  (prot-size (%fixnum-ref softprot ppc::protected-area.protsize))
                                  (overhead (mod (- softprot-low low) prot-size))
                                  (n (ceiling (+ (- threshold overhead) (1- prot-size)) prot-size))
                                  (total (+ overhead (* n prot-size))))
                             (declare (fixnum threshold prot-size softprot-low overhead n total))
                             (setq total-size (ash total ppc::fixnum-shift))))
                         (ash used ppc::fixnum-shift)))))
                  (t 0))))
      (values g-size 0 (or total-size g-size)))))

(unless (fboundp 'egc-enabled-p)

(defun egc-enabled-p () nil)

)

)  ; end of #+ppc-target


(defmethod view-draw-contents ((self thermometer))
  (let* ((pos (view-position self))
         (size (view-size self))
         (lr (add-points pos size))
         (direction (thermometer-direction self)))
    (with-pen-saved
      (#_PenPat *black-pattern*)
      (#_PenMode #$PatCopy)
      (rlet ((rect :rect :topLeft pos :botRight lr))
        (#_FrameRect rect)
        (setq pos (add-points pos #@(1 1))
              lr (subtract-points lr #@(1 1)))
        (setf (rref rect :rect.topLeft) pos
              (rref rect :rect.botRight) lr)
        (let* ((values (list (thermometer-value self)))
               (patterns (list (thermometer-pattern self)))
               (max-value (thermometer-max-value self))
               (length (thermometer-length self))
               (vertical? (eq direction :vertical))
               (left (point-h pos))
               (right (point-h lr))
               (top (point-v pos))
               (bottom (point-v lr))
               (start (if vertical? bottom left))
               (total 0)
               pattern patterns-list)
          (declare (dynamic-extent values patterns))
          (declare (list values patterns))
          (declare (fixnum left right top bottom start length))
          (if (listp (car values)) (setq values (car values)))
          (if (listp (car patterns)) (setq patterns (car patterns)))
          (setq patterns-list patterns)
          (flet ((limit (value min max)
                   (max min (min max value))))
            (dolist (value values)
              (setq pattern (pop patterns-list))
              (if (null patterns-list) (setq patterns-list patterns))
              (let* ((pixels (limit
                              (muldiv (incf total value) length max-value)
                              0 length))
                     (split (if vertical?
                              (- bottom pixels)
                              (+ left pixels))))
                (declare (fixnum pixels split))
                (if vertical?
                  (setf (rref rect :rect.topLeft)
                        (make-point left
                                    (limit split 
                                           top
                                           (limit (1- start) top bottom)))
                        (rref rect :rect.botRight)
                        (make-point right (limit start top bottom)))
                  (setf (rref rect :rect.botRight)
                        (make-point (limit split 
                                           (limit (1+ start) left right)
                                           right)
                                    bottom)
                        (rref rect :rect.topLeft)
                        (make-point (limit start left right) top)))
                (if (listp pattern)
                  (#_FillCRect rect (car pattern))
                  (#_FillRect rect pattern))
                (setq start split))))
          (if vertical?
            (setf (rref rect :rect.topLeft) pos
                  (rref rect :rect.botRight) (make-point right start))
            (setf (rref rect :rect.topLeft) (make-point start top)
                  (rref rect :rect.botRight) lr))
          (let ((fill-pattern (thermometer-fill-pattern self)))
            (if (consp fill-pattern)
              (#_FillCRect rect (car fill-pattern))
              (#_FillRect rect fill-pattern))))))))

(defmethod thermometer-update-values ((self thermometer))
  (let* ((value-function (thermometer-value-function self))
         (max-value-function (thermometer-max-value-function self))
         (new-value (if value-function
                      (funcall value-function)
                      (thermometer-value self)))
         (new-max-value (if max-value-function
                          (funcall max-value-function) (thermometer-max-value self))))
    (without-interrupts
     (when value-function
       (setf (thermometer-value self) new-value))
     (when max-value-function
       (setf (thermometer-max-value self) new-max-value)))
    (values new-value new-max-value)))

#|

; Example: two thermometers which track the mouse when you run (UPDATE-LOOP)
; and drag the mouse around in their window.

(defparameter *thermometer-window* (make-instance 'window :view-size #@(200 146)))
(defun example-patterns ()
  (list *black-pattern* *gray-pattern*))
(defparameter *th* 
  (make-instance 'thermometer
    :direction :horizontal
    :value (list 0 0)
    :pattern (example-patterns)
    :view-container *thermometer-window*
    :view-position #@(50 10)))
(defparameter *tv*
  (make-instance 'thermometer
    :direction :vertical
    :value (list 0 0)
    :pattern (example-patterns)
    :view-container *thermometer-window*
    :view-position #@(92 36)))
; *th* has two values, one which tracks the mouse in black
; and one which fills up half the remaining space in gray.
(setf (thermometer-value-function *th*)
      (let ((list (list 0 0))
            (size (point-h (view-size *th*))))
        #'(lambda ()
            (let ((mouse (point-h (view-mouse-position *th*))))
              (setf (car list) mouse
                    (cadr list) (floor (- size mouse) 2)))
            list)))
; *tv* has one value which tracks the mouse in black.
(setf (thermometer-value-function *tv*)
      (let ((size (point-v (view-size *tv*))))
        #'(lambda ()
            (- size (point-v (view-mouse-position *tv*))))))

(defun update-loop ()
  (loop
    (thermometer-update-values *th*)
    (thermometer-update-values *tv*)
    (event-dispatch)))

(update-loop)

|#

;;;;;;;;;
;;
;; A windiod for displaying real-time thermometers
;;
(defclass thermo-windoid (windoid)
  ((update-function :initform nil
                    :reader thermo-update-function))
  (:default-initargs :window-type (if t :single-edge-box :windoid-side))
)

(defmethod initialize-instance ((w thermo-windoid) &rest rest &key (window-show t)
                                color update-function)
  (declare (dynamic-extent rest))
  (apply #'call-next-method 
         w :window-show nil :color-p color :windowdefproc nil rest)
  (when color
    
    (set-fore-color w color))
  (when update-function
    (setf (thermo-update-function w) update-function))
  #+carbon-compat
  (when (osx-p)(setwindowmodality (wptr w) #$kwindowmodalitynone))
  (when window-show
    (window-show w)))

(defmethod set-view-size :after ((view thermo-windoid) h &optional v)
  (declare (ignore h v))
  (dolist (subview (subviews view))
    (when (typep subview 'thermometer)
      (let ((direction (thermometer-direction subview))
            (size (view-size view)))
        (setf (thermometer-length subview)
              (+ 2
                 (if (eq direction :vertical)
                   (point-v size)
                   (point-h size))))))))

(defmethod (setf thermo-update-function) (value (w thermo-windoid) &aux f)
  (cond ((typep value 'thermometer) 
         (setq f #'(lambda () (thermometer-update-values value))))
        ((listp value)
         (dolist (th value) (require-type th 'thermometer))
         (setq f #'(lambda ()
                     (dolist (th value)
                       (thermometer-update-values th)))))
        ((or (functionp value) (symbolp value)) (setq f value))
        (t (error "~s is not a thermometer, list of thermometers, function or symbol" value)))
  (setf (slot-value w 'update-function) f)
  (add-thermo-update-function f))

; thermo-windoid's close when you double click them,
; Move when you drag them anywhere but the lower-right corner,
; And resize in the length direction when you drag them from
; the lower-right corner.
(defmethod view-click-event-handler ((w thermo-windoid) where)
  (if (double-click-p)
    (window-close w)
    (window-drag-event-handler w (add-points (view-position w) where))))

(defmethod window-close :after ((w thermo-windoid))
  (remove-thermo-update-function (thermo-update-function w)))

(defvar *thermo-update-functions* nil)

(defun thermo-update ()
  (dolist (f *thermo-update-functions*)
    (funcall f)))

(defvar *thermometer-update-process* nil)

(defun make-thermo-update-process ()
  (let ((p *thermometer-update-process*))
    (if (and p (not (process-exhausted-p p)))
      p
      (let ((p (make-process "Thermometer update" :background-p t)))
        (process-preset p #'(lambda ()
                              (let ((time (#_TickCount)))
                                (loop
                                  (thermo-update)
                                  (setq time (+ time (* 60 (1+ (floor (- (#_TickCount) time) 60)))))
                                  (process-wait "Next second"
                                                #'(lambda (time)
                                                    (and *thermo-update-functions*
                                                         (>= (#_TickCount) time)))
                                                time)))))
        (process-enable p)
        (setq *thermometer-update-process* p)
        p))))

(defun kill-thermo-update-process ()
  (let ((p *thermometer-update-process*))
    (when p
      (setq *thermometer-update-process* nil)
      (unless (process-exhausted-p p)
        (process-kill p)))))

(defun add-thermo-update-function (f)
  (make-thermo-update-process)
  (pushnew f *thermo-update-functions*))

; (ccl::%remove-periodic-task name)
(defun remove-thermo-update-function (f)
  (or (setq *thermo-update-functions* (delq f *thermo-update-functions*))
      (progn (kill-thermo-update-process) nil)))

;;;;;;;;;
;;
;; A GC Thermometer
;;


(defparameter *gc-sizes*
  (list
   0                                    ; heap size
   0                                    ; mac heap used.
   0                                    ; mac heap free
   0                                    ; dynamic gspace
   0                                    ; e2 gspace
   0                                    ; e1 gspace
   0                                    ; e0 gspace
   0                                    ; free space
   0                                    ; e0 ispace
   0                                    ; e1 ispace
   0                                    ; e2 ispace
   0                                    ; dynamic ispace
   0                                    ; static gspace
   0                                    ; static ispace
   ))

(defun gc-patterns ()
  (list
   *dark-gray-pattern*                  ; mac heap used.
   *light-gray-pattern*                 ; mac heap free
   *black-pattern*                      ; dynamic gspace
   *dark-gray-pattern*                  ; e2 gspace
   *gray-pattern*                       ; e1 gspace
   *light-gray-pattern*                 ; e0 gspace
   *white-pattern*                      ; free space
   *light-gray-pattern*                 ; e0 ispace
   *gray-pattern*                       ; e1 ispace
   *dark-gray-pattern*                  ; e2 ispace
   *black-pattern*                      ; dynamic ispace
   *light-gray-pattern*                 ; static gspace
   *dark-gray-pattern*                  ; static ispace
   ))

(defun heap-size ()
  (if (not (osx-p))
    (let* ((zoneP (#_LMGetapplzone))
           (end (%get-long zoneP)))
      (- end (%ptr-to-int zoneP)))
    ;; not really right but at least doesn't crash
    (+ (%usedbytes)(%freebytes))))

(defun gc-sizes ()
  (without-interrupts
   (let* ((heap-size (heap-size))
          (free-bytes (%freebytes))
          (mac-free (#_FreeMem))
          mac-used
          dg di e0g e0i e1g e1i e2g e2i sg si)
     (multiple-value-setq (dg di) (cons-area-sizes :dynamic))
     (multiple-value-setq (e0g e0i) (cons-area-sizes 0))
     (multiple-value-setq (e1g e1i) (cons-area-sizes 1))
     (multiple-value-setq (e2g e2i) (cons-area-sizes 2))
     (multiple-value-setq (sg si) (cons-area-sizes :static))
     (setq mac-used (- heap-size mac-free (%dynamic-heap-size) sg si))
     (let ((sizes *gc-sizes*)
           (i -1))
       (declare (fixnum i))
       (setf
        (nth (incf i) sizes) heap-size
        (nth (incf i) sizes) (if (osx-p) 0 mac-used)
        (nth (incf i) sizes) (if (osx-p) 0 mac-free)
        (nth (incf i) sizes) dg
        (nth (incf i) sizes) e2g
        (nth (incf i) sizes) e1g
        (nth (incf i) sizes) e0g
        (nth (incf i) sizes) free-bytes
        (nth (incf i) sizes) e0i
        (nth (incf i) sizes) e1i
        (nth (incf i) sizes) e2i
        (nth (incf i) sizes) di
        (nth (incf i) sizes) sg
        (nth (incf i) sizes) si
        )
       (cdr sizes)))))

(defun gc-total-size () 
  (car *gc-sizes*))  

(defparameter *egc-sizes*
  (list 0                               ; total size
        0                               ; e2 gspace
        0                               ; e1 gspace
        0                               ; e0 gspace
        0                               ; free space in e0
        0                               ; e0 ispace
        0                               ; e1 ispace
        0                               ; e2 ispace
        ))

(defun egc-patterns ()
  (list *dark-gray-pattern*             ; e2 gspace
        *gray-pattern*                  ; e1 gspace
        *light-gray-pattern*            ; e0 gspace
        *white-pattern*                 ; free space in e0
        *light-gray-pattern*            ; e0 ispace
        *gray-pattern*                  ; e1 ispace
        *dark-gray-pattern*             ; e2 ispace
        ))

(defun egc-sizes ()
  (let* (e0g e0i e0-total e1g e1i e2g e2i)
    (multiple-value-setq (e0g e0i e0-total) (cons-area-sizes 0))
    (multiple-value-setq (e1g e1i) (cons-area-sizes 1))
    (multiple-value-setq (e2g e2i) (cons-area-sizes 2))
    (let* ((sizes *egc-sizes*)
           (total-size (+ e0g e0i e1g e1i e2g e2i))
           (empty-space (max 0 (- e0-total e0g e0i))))
      (setf (nth 0 sizes) (+ total-size empty-space)
            (nth 1 sizes) e2g
            (nth 2 sizes) e1g
            (nth 3 sizes) e0g
            (nth 4 sizes) empty-space
            (nth 5 sizes) e0i
            (nth 6 sizes) e1i
            (nth 7 sizes) e2i)
      (cdr sizes))))

(defun egc-total-size ()
  (car *egc-sizes*))

(defclass gc-windoid (thermo-windoid) ())

(defmethod view-click-event-handler ((w gc-windoid) where)
  (if (double-click-p)
    (window-close w)
    (let* ((size (view-size w))
           (global-where (add-points where (view-position w))))
      (if (and (> (point-h where) (- (point-h size) 5))
               (> (point-v where) (- (point-v size) 5)))
        (let* ((th (car (subviews w)))
               (direction (thermometer-direction th))
               (vertical? (eq direction :vertical))
               (size-h (point-h size))
               (size-v (point-v size))
               (topleft (if vertical?
                          (make-point (1+ size-h) 100)
                          (make-point 100 (1+ size-v))))
               (botright (if vertical?
                           (make-point (1+ size-h) 8192)
                           (make-point 8192 (1+ size-v)))))
          (rlet ((rect :rect :topleft topleft :botright botright))
            (unless (eql 0 (setq size (#_GrowWindow (wptr w) global-where rect)))
              (set-view-size w (if vertical?
                                 (make-point size-h (point-v size))
                                 (make-point (point-h size) size-v))))))
        (window-drag-event-handler w global-where)))))

(defmethod set-view-size :after ((w gc-windoid) h &optional v)
  (declare (ignore h v))
  (let* ((subviews (subviews w))
         (direction (thermometer-direction (car subviews)))
         (size (view-size w)))
    (unless (null (cdr subviews))
      (let ((h (point-h size))
            (v (point-v size)))
        (setq size (if (eq direction :vertical)
                     (make-point (floor h 2) v)
                     (make-point h (floor v 2))))))
    (dolist (th subviews)
      (set-view-size th
                 (add-points size #@(2 2))))))

; Heres the function to call to make a GC Thermometer.
; The defaults put the thermometer at the bottom of the highest resolution
; color screen, and include an EGC thermometer if EGC is turned on.
; By default all other gc-windoid's are closed before the new one is created.
(defun gc-thermometer (&key length (width 10) position
                            (color *blue-color*) (direction :horizontal)
                            (egc-p (egc-enabled-p))
                            (close-p t)
                            &aux
                            (vertical? (eq direction :vertical))
                            (window-width (if egc-p (+ width width 1) width)))
  (when close-p
    (dolist (w (windows :class 'gc-windoid :include-invisibles t))
      (window-close w)))
  (let ((screen-width *screen-width*)
        (screen-height *screen-height*)
        (screen-left 0)
        (screen-top 0))
    (multiple-value-bind (screen-pos screen-size) 
                         (if position (find-screen position) (find-best-color-screen))
      (when screen-pos
        (setq screen-left (point-h screen-pos)
              screen-top (point-v screen-pos)
              screen-width (point-h screen-size)
              screen-height (point-v screen-size))))
    (unless position
      (setq position
            (if vertical?
              (make-point (- (+ screen-left screen-width) window-width) screen-top)
              (make-point screen-left (- (+ screen-top screen-height) window-width)))))
    (unless length
      (setq length (if vertical?
                     (- screen-height (- (point-v position) screen-top))
                     (- screen-width (- (point-h position) screen-left)))))
    (when (floatp length)
      (setq length (if vertical?
                     (floor (* screen-height length))
                     (floor (* screen-width length))))))
  (let* ((th (make-instance 'thermometer
                            :view-position #@(-1 -1)
                            :length (+ length 2)
                            :width (+ width 2)
                            :direction direction
                            :pattern (gc-patterns)
                            :value-function 'gc-sizes
                            :max-value-function 'gc-total-size))
         (eth (and egc-p
                   (make-instance 'thermometer
                                  :view-position (if vertical?
                                                   (make-point width -1)
                                                   (make-point -1 width))
                                  :length (+ length 2)
                                  :width (+ width 2)
                                  :direction direction
                                  :pattern (egc-patterns)
                                  :value-function 'egc-sizes
                                  :max-value-function 'egc-total-size)))
         (w (make-instance 'gc-windoid
                           :view-size (if vertical?
                                        (make-point window-width length)
                                        (make-point length window-width))
                           :view-position position
                           :update-function (if eth (list th eth) th)
                           :color color)))
    (set-view-container th w)
    (thermometer-update-values th)
    (when eth
      (set-view-container eth w)
      (thermometer-update-values eth))
    w))
  
;;;;;;;;;
;;
;; A thermometer to track the currently open file.
;; Lets you see progress of file compilation.
;;


; Test me.
(defclass file-thermo-windoid (thermo-windoid)
  ((stream-pos-size :initform nil 
                    :initarg :stream-pos-size
                    :accessor stream-pos-size)
   (baseline-height :initarg :baseline-height
                    :accessor baseline-height)))

; This should take a font parameter and query the font about its
; size rather than hard-coding the size of monaco 9.
; By default the windoid is put at the top-left corner of the main
; screen.  It pops up automatically when there is a file open to display,
; and disappears again when there isn't.
; All other file-thermo-windoid's are closed before the new one is created,
; unless CLOSE-P is specified as NIL.
(defun file-thermometer (&key (length 250) (close-p t) (font-spec '("Monaco" 9)))
  (when close-p
    (dolist (w (windows :class 'file-thermo-windoid :include-invisibles t))
      (window-close w)))
  (let* ((th-width 10)
         (th (make-instance 'thermometer
                            :direction :horizontal
                            :length (+ length 2)
                            :view-position #@(-1 -1)
                            :width th-width))
         (stream-statistics nil)
         stream size pos display-height baseline-height
         w)
    (multiple-value-bind (ff ms) (font-codes '("Monaco" 9))
      (multiple-value-setq (ff ms) (font-codes font-spec ff ms))
      (multiple-value-setq (ff ms) (font-codes :srccopy ff ms))
      (setq font-spec (font-spec ff ms)))
    (multiple-value-bind (a d w l) (font-info font-spec)
      (declare (ignore w l))
      (setq display-height (+ a d)
            baseline-height d))      
    (flet ((update-function ()
             (when (and w (wptr w))
               (let ((open-streams *open-file-streams*)
                     new-size new-pos
                     display-stream display-size display-pos
                     statistic
                     (first-time? t))
                 (dolist (statistic stream-statistics)
                   (unless (memq (car statistic) open-streams)
                     (setq stream-statistics
                           (delq statistic stream-statistics))))
                 (dolist (a-stream open-streams)
                   (unless (or (member a-stream
                                       '(*doc-string-stream* *traps-index-stream*
                                         *constants-index-stream* *records-index-stream*
                                         *mactypes-index-stream*)
                                       :key #'symbol-value)
                               (not (open-stream-p a-stream)))
                     (setq statistic (or (assq a-stream stream-statistics)
                                         (let ((s (list a-stream nil nil)))
                                           (setq stream-statistics
                                                 (nconc stream-statistics (list s)))
                                           s)))
                     (when (ignore-errors
                            (and (setq new-size (file-length a-stream))
                                 (setq new-pos (file-position a-stream))))
                       (unless (and (eql new-size (second statistic))
                                    (eql new-pos (third statistic)))
                         (unless display-stream
                           (setq display-stream a-stream
                                 display-size new-size
                                 display-pos new-pos))
                         (setf (second statistic) new-size
                               (third statistic) new-pos)
                         (unless first-time?
                           (return))))))
                 (setq first-time? nil)
                 (cond ((or display-stream
                            (and stream-statistics (not (memq stream open-streams))))
                        (unless display-stream
                          (let ((statistic (car stream-statistics)))
                            (setq display-stream (car statistic)
                                  display-size (second statistic)
                                  display-pos (third statistic))))
                        (unless (and (eq display-stream stream)
                                     (eql display-pos pos)
                                     (eql display-size size))
                          (setq stream display-stream
                                pos display-pos
                                size display-size)
                          (setf (thermometer-max-value th) (max size 1)
                                (thermometer-value th) pos)
                          (invalidate-view w)
                          (window-show w)))
                       (stream-statistics nil)
                       (t (when stream
                            (window-hide w)
                            (setq stream nil)
                            (setf (thermometer-value th) 0)))))))
           (stream-pos-size () (values stream pos size stream-statistics)))
      (setq w (make-instance 'file-thermo-windoid
                             :view-font font-spec
                             :baseline-height baseline-height
                             :update-function #'update-function
                             :stream-pos-size #'stream-pos-size
                             :window-show nil
                             :view-size (make-point length (+ th-width display-height))
                             :view-subviews (list th #|text|#)
                             :view-position (make-point
                                             0
                                             (#_GetMBarHeight)))))))

(defun digit-count (number &optional (base 10))
  (setq number (require-type number 'integer))
  (let ((count (cond ((< number 0)
                      (setq number (- number))
                      2)
                     (t 1))))
    (declare (fixnum count))
    (loop
      (setq number (floor number base))
      (when (eql 0 number) (return count))
      (incf count))))

(defmethod view-draw-contents ((w file-thermo-windoid))
  (call-next-method)
  (multiple-value-bind (stream pos size statistics) (funcall (stream-pos-size w))
    (if (null stream)
      ; This happens when you switch out of the lisp while a file is open
      ; then switch back in when they're all closed.
      (window-hide w)
      ; The normal case
      (let* ((filename (stream-filename stream))
             (name (pathname-name filename))
             (type (pathname-type filename))
             (need-dir? (dolist (s statistics)
                          (when (and (neq stream (car s))
                                     (let ((s-file (stream-filename (car s))))
                                       (and (equalp name (pathname-name s-file))
                                            (equalp type (pathname-type s-file)))))
                            (return t))))
             (dir (and need-dir? (car (last (pathname-directory filename))))))
        (let ((height (point-v (view-size w))))
          (#_MoveTo 5 (- height (baseline-height w))))
        (if (and stream pos size)
          (format w "~@[~a:~]~a~@[.~a~]  ~vd/~d  ~d%"
                  dir
                  name
                  (and (neq type :unspecific) type)
                  (digit-count size) pos
                  size
                  (if (zerop size)
                    0
                    (round (* 100 pos) size))))
        (rlet ((pt :point))
          (#_GetPen pt)
          (let ((pen-pos (%get-long pt))
                (size (view-size w)))
            (when (> (point-h pen-pos) (point-h size))
              (set-view-size w (point-h pen-pos) (point-v size)))
            (rlet ((rect :rect
                         :top 11 :left (point-h pen-pos)
                         :botright (view-size w)))
              (#_EraseRect rect))))))))

(pushnew 'KILL-THERMO-UPDATE-PROCESS *lisp-cleanup-functions*)

  
(provide 'thermometer)
