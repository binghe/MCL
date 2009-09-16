; -*- Mode: Lisp; Package: CCL; -*-

;;	Change History (most recent first):
;;  4 12/22/95 gb   some area hacking
;;  2 10/26/95 gb   %address-of conses bignums if it has to; hope the
;;                  rest is never used.
;;  (do not edit before this line!!)


;; 07/14/96 gb   %map-areas change for EGC.
;; 06/17/96 bill %normalize-areas searches for current vs-area & ts-area
;; ------------  MCL-PPC 3.9
;; 01/22/96 gb   add :regsave pseudo-op.
;; 01/03/96 gb   %map-lfuns and friends.

#+allow-in-package
(in-package "CCL")

(defppclapfunction %address-of ((arg arg_z))
  ; %address-of a fixnum is a fixnum, just for spite.
  ; %address-of anything else is the address of that thing as an integer.
  (clrlwi. imm0 arg (- 32 ppc::nlisptagbits))
  (beqlr cr0)
  (mr imm0 arg_z)
  ; set cr0_eq if result fits in a fixnum
  (clrrwi. imm1 imm0 (- ppc::least-significant-bit ppc::nfixnumtagbits))
  (box-fixnum arg_z imm0)               ; assume it did
  (beqlr+ cr0)                          ; else arg_z tagged ok, but missing bits
  (ba .SPbox-unsigned)         ; put all bits in bignum.
)

#|
These things were always a bad idea.  Let's hope that nothing uses them.

; ??? is this too dangerous for PPC ?
(defppclapfunction %coerce-to-pointer ((arg arg_z))
  ; returns a (possibly invalid !) pointer iff its
  ; argument is a fixnum. 
  ; Screw: should accept an integer.
  (clrlwi. imm0 arg (- 32 ppc::nlisptagbits))
  (bne @end)
  (unbox-fixnum arg_z arg)
  @end
  (blr))

; ??? is this too dangerous for PPC ?
(defppclapfunction %scale-pointer ((ptr arg_y) (offset arg_z))
  ; adds the unboxed fixnum (someday integer) offset to ptr, returning
  ; a new, probably invalid, pointer.
  (unbox-fixnum imm0 offset)
  (add arg_z ptr imm0)
  (blr))

; ??? is this too dangerous for PPC ?
(defppclapfunction %extract-pointer ((ptr arg_y) (offset arg_z))
  ; adds the unboxed fixnum (someday integer) offset and ptr, returning
  ; the contents of the addressed location.
  (unbox-fixnum imm0 offset)
  (add imm1 ptr imm0)
  (lwzx arg_z imm0 ptr)
  (blr))

|#

;;; "areas" are fixnum-tagged and, for the most part, so are their
;;; contents.

;;; The nilreg-relative global all-areas is a doubly-linked-list header
;;; that describes nothing.  Its successor describes the current/active
;;; dynamic heap.  The nilreg-relative globals current-cs, current-vs, and
;;; current-ts describe the current thread's stack areas.

;;; In general, the "active" pointers in these areas are really the values
;;; in the stack- and free-pointer registers.  Update the "area" data structures,
;;; and return a pointer to the active dynamic area.

; This is called by resume-stack-group in a context where it's
; not OK to signal a lisp error. Hence, it must remain in LAP
; so that it can't possibly cause a control stack overflow.
; The current-vs (current-ts) area is guranteed to point to
; the area containing vsp (tsp) or a younger area.
(defppclapfunction %normalize-areas ()
  (let ((address imm0)
        (temp imm2)
        (sg arg_z))
    
    (lwz address '*current-stack-group* nfn)
    (lwz sg ppc::symbol.vcell address)

    ; update active pointer for tsp area.
    (ref-global address current-ts)
    (b @tsploop)
@nexttsp
    (lwz address ppc::area.older address)
    (cmpwi address 0)
    (bne @tsploop)
    (dbg t)                             ; can't error during stack-group-resume
@tsploop
    (lwz temp ppc::area.low address)
    (cmplw cr0 temp tsp)
    (lwz temp ppc::area.high address)
    (cmplw cr1 temp tsp)
    (bgt cr0 @nexttsp)
    (ble cr1 @nexttsp)
    (set-global address current-ts)
    (svset address sg.ts-area sg t)
    (stw tsp ppc::area.active address)
@tsploop2
    ; Younger tsp areas all have no active area. Make it so.
    (lwz address ppc::area.younger address)
    (cmpwi address 0)
    (beq @tspdone)
    (lwz temp ppc::area.high address)
    (stw temp ppc::area.active address)
    (b @tsploop2)
@tspdone
    
    ; Update active pointer for vsp area.
    (ref-global address current-vs)
    (b @vsploop)
    @nextvsp
    (lwz address ppc::area.older address)
    (cmpwi address 0)
    (bne @vsploop)
    (dbg t)                             ; can't error during stack-group-resume
    @vsploop
    (lwz temp ppc::area.low address)
    (cmplw cr0 temp vsp)
    (lwz temp ppc::area.high address)
    (cmplw cr1 temp vsp)
    (bgt cr0 @nextvsp)
    (ble cr1 @nextvsp)
    (set-global address current-vs)
    (svset address sg.vs-area sg t)
    (stw vsp ppc::area.active address)
    @vsploop2
    ; Younger vsp areas all have no active area. Make it so.
    (lwz address ppc::area.younger address)
    (cmpwi address 0)
    (beq @vspdone)
    (lwz temp ppc::area.high address)
    (stw temp ppc::area.active address)
    (b @vsploop2)
    @vspdone
    
    ; Update active pointer for SP area
    (ref-global arg_z current-cs)
    (stw sp ppc::area.active arg_z)

    ; Update active pointer for dynamic heap area
    (ref-global arg_z all-areas)
    (lwz arg_z ppc::area.succ arg_z)
    (stw freeptr ppc::area.active arg_z)
    (blr)))

(defppclapfunction %object-in-stack-area-p ((object arg_y) (area arg_z))
  (lwz imm0 ppc::area.active area)
  (cmplw cr0 object imm0)
  (lwz imm1 ppc::area.high area)
  (cmplw cr1 object imm1)
  (mr arg_z rnil)
  (bltlr cr0)
  (bgelr cr1)
  (la arg_z ppc::t-offset arg_z)
  (blr))

(defppclapfunction %object-in-heap-area-p ((object arg_y) (area arg_z))
  (lwz imm0 ppc::area.low area)
  (cmplw cr0 object imm0)
  (lwz imm1 ppc::area.active area)
  (cmplw cr1 object imm1)
  (mr arg_z rnil)
  (bltlr cr0)
  (bgelr cr1)
  (la arg_z ppc::t-offset arg_z)
  (blr))

; It doesn't make sense to call this with a fixnum or imm-tagged object
(defun %area-containing-object (object)
  (do* ((a (%normalize-areas) (%lisp-word-ref a (ash ppc::area.succ -2))))
       ()
    (let* ((code (%lisp-word-ref a (ash ppc::area.code -2))))
      (declare (fixnum code))
      (if (= code ppc::area-void)
        (return nil)
        (if (if (>= code ppc::min-heap-area-code)
              (%object-in-heap-area-p object a)
              (%object-in-stack-area-p object a))
          (return a))))))

(defppclapfunction walk-static-area ((a arg_y) (f arg_z))
  (let ((fun save0)
        (obj save1)
        (limit save2)
        (header imm0)
        (tag imm1)
        (subtag imm2)
        (bytes imm3)
        (elements imm0))
    (save-lisp-context)
    (:regsave limit 0)
    (vpush fun)
    (vpush obj)
    (vpush limit)
    (mr fun f)
    (lwz limit ppc::area.active a)
    (lwz obj ppc::area.low a)
    (b @test)
    @loop
    (lwz header 0 obj)
    (extract-fulltag tag header)
    (cmpwi cr0 tag ppc::fulltag-immheader)
    (cmpwi cr1 tag ppc::fulltag-nodeheader)
    (beq cr0 @misc)
    (beq cr1 @misc)
    (la arg_z ppc::fulltag-cons obj)
    (set-nargs 1)
    (mr temp0 fun)
    (bla .SPFuncall)
    (la obj ppc::cons.size obj)
    (b @test)
    @misc
    (la arg_z ppc::fulltag-misc obj)
    (set-nargs 1)
    (mr temp0 fun)
    (bla .SPFuncall)
    (lwz header 0 obj)
    (extract-fulltag tag header)
    (cmpwi cr1 tag ppc::fulltag-nodeheader)
    (clrlwi subtag header (- 32 ppc::num-subtag-bits))
    (cmpwi cr2 subtag ppc::max-32-bit-ivector-subtag)
    (cmpwi cr3 subtag ppc::max-8-bit-ivector-subtag)
    (cmpwi cr4 subtag ppc::max-16-bit-ivector-subtag)
    (cmpwi cr5 subtag ppc::subtag-double-float-vector)
    (header-size elements header)
    (slwi bytes elements 2)
    (beq cr1 @bump)
    (ble cr2 @bump)
    (mr bytes elements)
    (ble cr3 @bump)
    (slwi bytes elements 1)
    (ble cr4 @bump)
    (slwi bytes elements 3)
    (beq cr5 @bump)
    (la elements 7 elements)
    (srwi bytes elements 3)
    @bump
    (la bytes (+ 4 7) bytes)
    (clrrwi bytes bytes 3)
    (add obj obj bytes)
    @test
    (cmplw :cr0 obj limit)
    (blt cr0 @loop)
    (vpop limit)
    (vpop obj)
    (vpop fun)
    (restore-full-lisp-context)
    (blr)))

; This walks the active "dynamic" area.  Objects might be moving around
; while we're doing this, so we have to be a lot more careful than we 
; are when walking a static area.
; There's the vague notion that we can't take an interrupt when
; "initptr" doesn't equal "freeptr", though what kind of hooks into a
; preemptive scheduler we'd need to enforce this is unclear.  We use
; initptr as an untagged pointer here (and set it to freeptr when we've
; got a tagged pointer to the current object.)
; There are a couple of approaches to termination:
;  a) Allocate a "sentinel" cons, and terminate when we run into it.
;  b) Check the area limit (which is changing if we're consing) and
;     terminate when we hit it.
; (b) loses if the function conses.  (a) conses.  I can't think of anything
; better than (a).
; This, of course, assumes that any GC we're doing does in-place compaction
; (or at least preserves the relative order of objects in the heap.)
    
(defppclapfunction walk-dynamic-area ((a arg_y) (f arg_z))
  (let ((fun save0)
        (obj save1)
        (sentinel save2)
        (header imm0)
        (tag imm1)
        (subtag imm2)
        (bytes imm3)
        (elements imm4))
    (save-lisp-context)
    (:regsave sentinel 0)
    (vpush fun)
    (vpush obj)
    (vpush sentinel)
    (ref-global imm0 tenured-area)
    (cmpwi cr0 imm0 0)
    (stwu rzero ppc::cons.size freeptr)
    (la sentinel ppc::fulltag-cons initptr)
    (mr initptr freeptr)
    (mr fun f)
    (if :ne
      (mr a imm0))    
    (lwz initptr ppc::area.low a)
    @loop
    (lwz header 0 initptr)
    (extract-fulltag tag header)
    (cmpwi cr0 tag ppc::fulltag-immheader)
    (cmpwi cr1 tag ppc::fulltag-nodeheader)
    (beq cr0 @misc)
    (beq cr1 @misc)
    (la obj ppc::fulltag-cons initptr)
    (cmpw cr0 obj sentinel)
    (mr initptr freeptr)
    (mr arg_z obj)
    (set-nargs 1)
    (mr temp0 fun)
    (beq cr0 @done)
    (bla .SPfuncall)
    (la initptr (- ppc::cons.size ppc::fulltag-cons) obj)
    (b @loop)
    @misc
    (la obj ppc::fulltag-misc initptr)
    (mr initptr freeptr)
    (mr arg_z obj)
    (set-nargs 1)
    (mr temp0 fun)
    (bla .SPFuncall)
    (getvheader header obj)
    (extract-fulltag tag header)
    (cmpwi cr1 tag ppc::fulltag-nodeheader)
    (cmpwi cr7 tag ppc::fulltag-immheader)
    (clrlwi subtag header (- 32 ppc::num-subtag-bits))
    (cmpwi cr2 subtag ppc::max-32-bit-ivector-subtag)
    (cmpwi cr3 subtag ppc::max-8-bit-ivector-subtag)
    (cmpwi cr4 subtag ppc::max-16-bit-ivector-subtag)
    (cmpwi cr5 subtag ppc::subtag-double-float-vector)
    (header-size elements header)
    (slwi bytes elements 2)
    (beq cr1 @bump)
    (if (:cr7 :ne)
      (twle 0 0))
    (ble cr2 @bump)
    (mr bytes elements)
    (ble cr3 @bump)
    (slwi bytes elements 1)
    (ble cr4 @bump)
    (slwi bytes elements 3)
    (beq cr5 @bump)
    (la elements 7 elements)
    (srwi bytes elements 3)
    @bump
    (la bytes (+ 4 7) bytes)
    (clrrwi bytes bytes 3)
    (subi initptr obj ppc::fulltag-misc)
    (add initptr initptr bytes)
    (cmpw cr0 initptr sentinel)
    (blt cr0 @loop)
    (tweq 0 0)
    (b @loop)
    @done
    (mr arg_z rnil)
    (vpop sentinel)
    (vpop obj)
    (vpop fun)
    (restore-full-lisp-context)
    (blr)))


; We MAY need a scheme for finding all of the areas in a lisp library.
(defun %map-areas (function &optional (maxcode ppc::area-dynamic) (mincode ppc::area-readonly))
  (declare (fixnum maxcode mincode))
  (do* ((a (%normalize-areas) (%lisp-word-ref a (ash ppc::area.succ -2)))
        (code ppc::area-dynamic (%lisp-word-ref a (ash ppc::area.code -2)))
        (dynamic t nil))
       ((= code ppc::area-void))
    (declare (fixnum code))
    (if (and (<= code maxcode)
             (>= code mincode))
      (if dynamic 
        (walk-dynamic-area a function)
        (unless (= code ppc::area-dynamic)        ; ignore egc areas, 'cause walk-dynamic-area sees them.
          (walk-static-area a function))))))

(defun %map-lfuns (f)
  (let* ((filter #'(lambda (obj) (when (functionp obj) (funcall f obj)))))
    (declare (dynamic-extent filter))
    (%map-areas filter ppc::area-dynamic ppc::area-staticlib)))   ; there'll be functions in static lib areas.


    
; If OBJECT is in a read-only area, return the number of words between
; the start of that area and the first word of data in the object.
; Since only vector-like objects can be allocated in a readonly area,
; "the first word of data" means "the first word beyond the header".
; If OBJECT isn't in a read-only area, return nil.
; The "skip" argument indicates the number of words beyond the start
; of the area that we aren't interested in, e.g., there's a header &
; pad word between the start of the readonly area and the subprims
; jump table.
(defun %readonly-area-word-offset (object &optional (skip 0))
  (let* ((a (%area-containing-object object)))
    (if (and a (eql (%lisp-word-ref a (ash ppc::area.code -2))
                    ppc::area-readonly))
      (%i- (strip-tag-to-fixnum object)
           (%i+ skip (%lisp-word-ref a (ash ppc::area.low -2)))))))

  

; end
