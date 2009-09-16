;;; -*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  3 10/5/97  akh  see below
;;  2 7/4/97   akh  see below
;;  26 6/16/96 akh  make-point - require-type doesnt work in level-0, use %kernel-restart
;;  24 6/7/96  akh  maybe nothing
;;  22 5/20/96 akh  make-point - no require-type '(signed-byte ..)
;;  21 4/17/96 akh  %copy-ivector-to-ivector
;;  20 3/27/96 akh  copy-ivector-to-ivector does words if possible when source /= dest
;;  10 12/1/95 akh  pstr/cstr-segment-pointer - in l1-aprims, not needed here
;;  9 11/19/95 gb   add,subtract,make-point fixes
;;  5 10/26/95 gb   fencepost in %copy-ptr-to-ivector
;;  2 10/7/95  slh  added segment-ptr fns
;;  (do not edit before this line!!)

;;;
;;; level-0;ppc;ppc-misc.lisp

; Modification History
;
; %heap-bytes-allocated not always fixnum
; ------- 5.1 final
; 11/14/03 Replacing the MCRXR with (MTXER rzero)
;; -------- 5.0 final
; akh fix dbg for OSX to not crash at least when gdb is underneath - oh rats it still compiles using .spbreakpoint
;  -------- 4.4b3
; akh - tweak %usedbytes for static - OSX problem
; --------- 4.4b2
; add %copy-ptr-to-ptr (trivial)
;; --------- 4.3b1, b2
; 07/13/98 akh added %copy-8-ivector-to-16-ivector for stream-write-string
; 09/17/97 akh make-point - require v and h be integer
; 06/14/97 akh make-point from bill, always at most a 32 bit integer, add make-big-point (= old make-point) add-big-points subtract-big-points
; 01/24/97 bill make-point returns a cons for h or v not (signed-byte 16).
;               point-h & point-v handle that case.
;               add-points & subtract-points are no longer optimized LAP.
; ------------  4.0
;  7/31/96 slh  room: use _LMGetApplZone
; 07/26/96 gb   bug.
; 06/17/96 bill break %stack-group-stack-space out-of %stack-space-by-stack-group.
;               %stack-group-stack-space knows to walk the stack segments.
; 06/10/96 gb   dbg: now open-coded trap.
; ------------  MCL-PPC 3.9
; 05/29/96 bill make-point works correctly for (abs v) >= 8192.
;               It also checks for (signed-byte 16) inline, as it used to do in 3.0.
; 05/01/96 akh  make-point - no require-type '(signed-byte ..)
; 04/15/96 akh  %copy-ivector-to-ivector again - got bust for bwds when source = dest
; 03/29/96 bill  %copy-ivector-to-ivector works correctly if src & dest are the same.
; 03/19/96 bill  %usedbytes ignores areas outside of the application heap.
;                It also correctly accumulates static area statistics.
;                room has a new "static:" heap line.
; 03/01/96 bill  update %stack-space-by-stack-group to the new order.
;                room reports (k tsp-free) instead of (k vsp-free) twice.
; 03/10/06 gb %stack-space-by-stack-group: no more sg.next
; 02/05/96 bill  %freebytes, %usedbytes, %stack-space, room
; 01/30/96 bill  dbg's arg is no longer required.
; 01/29/96 bill  values initializes temp0 before jumping to .SPvalues
; 01/19/96 gb    had trouble calling Debugger in saved image;
;                fix may or may not be necessary if CFM stuff changed.
; 01/05/96 bill  extract-typecode
; 12/27/95 gb    values; unsignedwide->integer; heap metering.
; 12/12/95 bill  install-a78 & friends make it possible to g @a78
;                to throw to toplevel.
; 12/04/95 bill  Make dbg work. Arg is put in save7 = r24.
; 11/1/95  gb    memory-metering stuff a little premature at this
;                point.
; 10/25/95 slh   %freebytes, total-bytes-allocated, room
; 10/16/95 gb    fix %copy-ptr-to-ivector; add LENGTH, LIST-LENGTH.


#| MISSING:
; dtagp - only used by bogus-thing-p
(defun dtagp (thing mask)

; %apply-lexpr, values, %temp-list - need "klexpr"
(defun %apply-lexpr (&lap fn args)
(defun values (&lap &rest args)
(defun %temp-list (&lap &rest args)
|#

;(in-package "CCL")

(eval-when (:execute :compile-toplevel)
  (defppclapmacro get-arg (dest arg)
    `(lwz ,dest ,arg vsp))

  (defppclapmacro bignum-ref (dest src index)
    `(lwz ,dest (+ ppc::misc-data-offset (ash ,index 2)) ,src))

  (defppclapmacro get-hv (h v pt)
    (let ((lbl-got (gensym)))
      `(progn
         ;(eq-if-fixnum 0 ,h ,pt)
         (clrlwi. ,h ,pt (- ppc::nbits-in-word ppc::nlisptagbits))
         (unbox-fixnum ,h ,pt)
         (beq+ cr0 ,lbl-got)
         ; Should probably branch around a uuo_interr ppc::error-object-not-signed-byte-32
         (trap-unless-typecode= ,pt ppc::subtag-bignum ,h)
         (bignum-ref ,h ,pt 0)
         ,lbl-got                       ; now "h" has (signed-byte 32): vvvvhhhh
         (srawi ,v ,h 16)
         (extsh ,h ,h))))

  (defppclapmacro munge-points (pt1 pt2 oper)
    `(let ((h1 imm0)
           (v1 imm1)
           (h2 imm2)
           (v2 imm3))
       (get-hv h1 v1 ,pt1)
       (get-hv h2 v2 ,pt2)
       (,oper h1 h1 h2)
       (,oper v1 v1 v2)
       (insrwi h1 v1 16 0)    ;         ; insert the "rightmost" 16 bits of v1 
                                        ; into the "leftmost" 16 bits of h1

       ;(s32->integer arg_z h1 0 imm2)  ; return fixnum or bignum
       ;(mtxer rzero) ;(mcrxr 0)
       (addo imm2 h1 h1)
       (addo. arg_z imm2 imm2)
       (bnslr+)
       (mtxer ppc::rzero)
       (ba .SPbox-signed)
       ))
  )


; Copy N bytes from pointer src, starting at byte offset src-offset,
; to ivector dest, starting at offset dest-offset.
; It's fine to leave this in lap.
; Depending on alignment, it might make sense to move more than
; a byte at a time.
; Does no arg checking of any kind.  Really.

(defppclapfunction %copy-ptr-to-ivector ((src 4) 
                                         (src-byte-offset 0) 
                                         (dest arg_x)
                                         (dest-byte-offset arg_y)
                                         (nbytes arg_z))
  (let ((src-reg imm0)
        (src-byteptr imm1)
        (src-node-reg temp0)
        (dest-byteptr imm2)
        (val imm3)
        (node-temp temp1))
    (cmpwi cr0 nbytes 0)
    (get-arg src-node-reg src)
    (lwz src-reg ppc::macptr.address src-node-reg)
    (get-arg src-byteptr src-byte-offset)
    (unbox-fixnum src-byteptr src-byteptr)
    (unbox-fixnum dest-byteptr dest-byte-offset)
    (la dest-byteptr ppc::misc-data-offset dest-byteptr)
    (b @test)
    @loop
    (subi nbytes nbytes '1)
    (cmpwi cr0 nbytes '0)
    (lbzx val src-reg src-byteptr)
    (la src-byteptr 1 src-byteptr)
    (stbx val dest dest-byteptr)
    (la dest-byteptr 1 dest-byteptr)
    @test
    (bne cr0 @loop)
    (mr arg_z dest)
    (la vsp 8 vsp)
    (blr)))

; %copy-ivector-to-ptr - from hello.lisp:
(defppclapfunction %copy-ivector-to-ptr ((src 4) 
                                         (src-byte-offset 0) 
                                         (dest arg_x)
                                         (dest-byte-offset arg_y)
                                         (nbytes arg_z))
  (lwz temp0 src vsp)
  (cmpwi cr0 nbytes 0)
  (lwz imm0 src-byte-offset vsp)
  (unbox-fixnum imm0 imm0)
  (la imm0 ppc::misc-data-offset imm0)
  (unbox-fixnum imm2 dest-byte-offset)
  (lwz imm1 ppc::macptr.address dest)
  (b @test)
  @loop
  (subi nbytes nbytes '1)
  (cmpwi cr0 nbytes 0)
  (lbzx imm3 temp0 imm0)
  (addi imm0 imm0 1)
  (stbx imm3 imm1 imm2)
  (addi imm2 imm2 1)
  @test
  (bne cr0 @loop)
  (mr arg_z dest)
  (la vsp 8 vsp)
  (blr))

;; FOR MOVING EXTENDED STRINGS TO VANILLA CHARACTER FILE - LOSE TOP BITS OF EACH CHARACTER
;; NOT USED TODAY
#|
(defppclapfunction %copy-16-ivector-to-8-ptr ((src 4) 
                                         (src-byte-offset 0) ;; ACTUALLY HWORD OFFSET?
                                         (dest arg_x)
                                         (dest-byte-offset arg_y)
                                         (nbytes arg_z))
  (lwz temp0 src vsp)
  (cmpwi cr0 nbytes 0)
  (lwz imm0 src-byte-offset vsp)
  (unbox-fixnum imm0 imm0)
  (ADD IMM0 IMM0 IMM0)
  (la imm0 ppc::misc-data-offset imm0)
  (unbox-fixnum imm2 dest-byte-offset)
  (lwz imm1 ppc::macptr.address dest)
  (b @test)
  @loop
  (subi nbytes nbytes '1)
  (cmpwi cr0 nbytes 0)
  (lbzx imm3 temp0 imm0)
  (addi imm0 imm0 2)
  (stbx imm3 imm1 imm2)
  (addi imm2 imm2 1)
  @test
  (bne cr0 @loop)
  (mr arg_z dest)
  (la vsp 8 vsp)
  (blr))
|#

;; for stream-write-string from base string to extended string - only goes fwd - no 68K version
;; could also use for string-to-extended-string or whatever its called
(defppclapfunction %copy-8-ivector-to-16-ivector ((src 4) 
                                         (src-byte-offset 0)
                                         (dest arg_x)
                                         (dest-byte-offset arg_y)
                                         (nbytes arg_z))
  (lwz temp0 src vsp)
  (cmpwi cr0 nbytes 0)
  (lwz imm0 src-byte-offset vsp)
  (unbox-fixnum imm0 imm0)
  (la imm0 ppc::misc-data-offset imm0)
  (unbox-fixnum imm1  dest-byte-offset)
  (add imm1 imm1 imm1)
  (la imm1 ppc::misc-data-offset imm1)
  (b @test)
  @loop
  (subi nbytes nbytes '1)
  (cmpwi cr0 nbytes 0)
  (lbzx imm3 temp0 imm0)
  (addi imm0 imm0 1)
  (sthx imm3 dest imm1)
  (addi imm1 imm1 2)
  @test
  (bne cr0 @loop)
  (mr arg_z dest)
  (la vsp 8 vsp)
  (blr))




(defppclapfunction %copy-ivector-to-ivector ((src 4) 
                                             (src-byte-offset 0) 
                                             (dest arg_x)
                                             (dest-byte-offset arg_y)
                                             (nbytes arg_z))
  (lwz temp0 src vsp)
  (cmpwi cr0 nbytes 0)
  (cmpw cr2 temp0 dest)   ; source and dest same?
  (rlwinm imm3 nbytes 0 (- 30 ppc::fixnum-shift) 31)  
  (lwz imm0 src-byte-offset vsp)
  (rlwinm imm1 imm0 0 (- 30 ppc::fixnum-shift) 31)
  (or imm3 imm3 imm1)
  (unbox-fixnum imm0 imm0)
  (la imm0 ppc::misc-data-offset imm0)
  (unbox-fixnum imm2 dest-byte-offset)
  (rlwimi imm1 imm2 0 30 31)
  (or imm3 imm3 imm1)
  (cmpwi cr1 imm3 0)  ; is everybody multiple of 4?
  (la imm2 ppc::misc-data-offset imm2)
  (beq cr2 @SisD)   ; source and dest same
  @fwd
  (beq :cr1 @wtest)
  (b @test)

  @loop
  (subi nbytes nbytes '1)
  (cmpwi cr0 nbytes 0)
  (lbzx imm3 temp0 imm0)
  (addi imm0 imm0 1)
  (stbx imm3 dest imm2)
  (addi imm2 imm2 1)
  @test
  (bne cr0 @loop)
  (mr arg_z dest)
  (la vsp 8 vsp)
  (blr)

  @words      ; source and dest different - words 
  (subi nbytes nbytes '4)  
  (cmpwi cr0 nbytes 0)
  (lwzx imm3 temp0 imm0)
  (addi imm0 imm0 4)
  (stwx imm3 dest imm2)
  (addi imm2 imm2 4)
  @wtest
  (bgt cr0 @words)
  @done
  (mr arg_z dest)
  (la vsp 8 vsp)
  (blr)

  @SisD
  (cmpw cr2 imm0 imm2) ; cmp src and dest
  (bgt cr2 @fwd)
  ;(B @bwd) 
  

  ; Copy backwards when src & dest are the same and we're sliding down
  @bwd ; ok
  (unbox-fixnum imm3 nbytes)
  (add imm0 imm0 imm3)
  (add imm2 imm2 imm3)
  (b @test2)
  @loop2
  (subi nbytes nbytes '1)
  (cmpwi cr0 nbytes 0)
  (subi imm0 imm0 1)
  (lbzx imm3 temp0 imm0)
  (subi imm2 imm2 1)
  (stbx imm3 dest imm2)
  @test2
  (bne cr0 @loop2)
  (b @done))

#|  ;; doesn't boot ?? can't call most traps in level-0
(defun %copy-ptr-to-ptr (src-ptr src-offset dest-ptr dest-offset nbytes)
  (with-macptrs ((src src-ptr)
                 (dest dest-ptr))
    (#_blockmovedata (%inc-ptr src src-offset)(%inc-ptr dest dest-offset)
                      nbytes)))
|#



(defun make-point (vh &optional v)
  (if v
    (macrolet ((signed-byte-16-p (x)
                 `(and (fixnump ,x)
                       (locally (declare (fixnum ,x))
                         (and (<= ,x #x7fff)
                              (>= ,x #x-8000))))))
      (if (and (signed-byte-16-p vh)
               (signed-byte-16-p v))
        (locally (declare (fixnum vh v))
          (if (and (< v (ash (1+ most-positive-fixnum) -16))
                   (>= v (ash most-negative-fixnum -16)))
            (logior (the fixnum (logand #xffff vh))
                    (the fixnum (ash v 16)))
            (logior (the fixnum (logand #xffff vh))
                    (ash v 16))))
        (make-point (max #x-8000 (min (require-type vh 'integer) #x7fff))
                    (max #x-8000 (min (require-type v 'integer) #x7fff)))))
    (if (consp vh)
      (make-point (%car vh) (%cdr vh))
      (require-type vh 'integer))))

(defun make-big-point (vh &optional v)
  (if v
    (macrolet ((signed-byte-16-p (x)
                 `(and (fixnump ,x)
                       (locally (declare (fixnum ,x))
                         (and (<= ,x #x7fff)
                              (>= ,x #x-8000))))))
      (if (and (signed-byte-16-p vh)
               (signed-byte-16-p v))
        (locally (declare (fixnum vh v))
          (if (and (< v (ash (1+ most-positive-fixnum) -16))
                   (>= v (ash most-negative-fixnum -16)))
            (logior (the fixnum (logand #xffff vh))
                    (the fixnum (ash v 16)))
            (logior (the fixnum (logand #xffff vh))
                    (ash v 16))))
        (cons (require-type vh 'integer) (require-type v 'integer))))
    (if (consp vh)
      (progn
        (require-type (%car vh) 'integer)
        (require-type (%cdr vh) 'integer)
        vh)
      (require-type vh 'integer))))

(defun point-h (p)
  (if (consp p)
    (require-type (%car p) 'integer)
    (integer-point-h p)))

(defun point-v (p)
  (if (consp p)
    (require-type (%cdr p) 'integer)
    (integer-point-v p)))

(defun add-points (pt1 pt2)
  (make-point (+ (point-h pt1) (point-h pt2))
              (+ (point-v pt1) (point-v pt2))))

(defun add-big-points (pt1 pt2)
  (make-big-point (+ (point-h pt1) (point-h pt2))
                  (+ (point-v pt1) (point-v pt2))))

(defun subtract-points (pt1 pt2)
  (make-point (- (point-h pt1) (point-h pt2))
              (- (point-v pt1) (point-v pt2))))

;; not used so far
(defun subtract-big-points (pt1 pt2)
  (make-big-point (- (point-h pt1) (point-h pt2))
                  (- (point-v pt1) (point-v pt2))))
  
#+ignore
(defun dbg (&optional arg)
  (if (osx-p)
    ;; arg is ignored, gdb has to be underneath and one has to do break or fb of Debugger in gdb in order to actually stop.
    ;; but at least it doesn't crash if gdb is there, else does.
    (debugger)    
    (dbg-old arg)))
#-ignore
(defun dbg (&optional arg)
  (dbg arg)
  )

; value will be in save7 = r24
(defppclapfunction %dbg ((arg arg_z))    ; (&optional arg)
  (check-nargs 0 1)                      ; optional
  (save-lisp-context)
  (vpush save7)
  (cmpw cr0 nargs rzero)
  (if (:cr0 :eq)
    (mr arg_z rnil))
  (mr save7 arg)
  (set-nargs 0)
  (call-symbol Debugger)               ; can't (easily) call "traps" inline
  (vpop save7)
  (restore-full-lisp-context)
  (blr))

(defvar *debugger-slep* nil)

(eval-when (:compile-toplevel :execute)
  (declaim (type t *debugger-slep*)))

; Can't just say (#_Debugger) in level-0, since that
; gets us the trap emulator which does #_Debugger in 68K mode.
(defun Debugger ()
  (let* ((shlep (or *debugger-slep*
                    (setq *debugger-slep* (get-slep "Debugger")))))
    (ppc-ff-call (%resolve-slep-address shlep))
    nil))

; This takes a simple-base-string and passes a C string into
; the kernel "Bug" routine.  Not too fancy, but neither is #_DebugStr,
; and there's a better chance that users would see this message.
(defun bug (arg)
  (if (typep arg 'simple-base-string)
    (let* ((len (length arg)))
      (%stack-block ((buf (1+ len)))
        (%copy-ivector-to-ptr arg 0 buf 0 len)
        (setf (%get-byte buf len) 0)
        (ppc-ff-call (%kernel-import ppc::kernel-import-lisp-bug)
                     :address buf
                     :void)))
    (bug "Bug called with non-simple-base-string.")))


; This expects to be called via "g *a78" in the debugger.
; It expects A7C to contain #'%throw-to-toplevel
(defppclapfunction %throw-to-toplevel ()
  (li imm0 #xa7c)
  (lwz fn 0 imm0)
  (set-nargs 0)
  (call-symbol throw-to-toplevel))

(defun throw-to-toplevel ()
  (if (fboundp 'toplevel)
    (toplevel)
    (throw :toplevel nil)))


(defun install-a78 ()
  #-carbon-compat  ;; for now
  (when (not (osx-p))
    (let* ((f (fboundp '%throw-to-toplevel))
           (code-vector (uvref f 0))
           (code-vector-lo (logand code-vector
                                   (1- (ash 1 (- 16 ppc::fixnum-shift)))))
           (code-vector-hi (ash code-vector (- ppc::fixnum-shift 16))))
      (declare (fixnum code-vector)       ; lie
               (fixnum code-vector-lo code-vector-hi))
      (with-macptrs ((a78 (%int-to-ptr #xa78)))
        (setf (%get-word a78) code-vector-hi
              (%get-word a78 2)
              (the fixnum (ash code-vector-lo ppc::fixnum-shift)))
        (locally (declare (fixnum f))     ; lie
          (let* ((f-int (logand #x3ffffff f))
                 (f-untagged (ash f-int ppc::fixnum-shift))
                 (f-tagged (+ f-untagged ppc::tag-misc)))
            (declare (fixnum f-int f-untagged f-tagged))
            (setf (%get-long a78 4) f-tagged))))
      nil)))


;(install-a78)  ;; later


(defppclapfunction %heap-bytes-allocated ()
  (ref-global imm0 heap-start)
  (sub imm0 freeptr imm0)
  ;(box-fixnum arg_z imm0)
  ; set cr0_eq if result fits in a fixnum
  (clrrwi. imm1 imm0 (- ppc::least-significant-bit ppc::nfixnumtagbits))
  (box-fixnum arg_z imm0)               ; assume it did
  (beqlr+ cr0)                          ; else arg_z tagged ok, but missing bits
  (ba .SPbox-unsigned))         ; put all bits in bignum.


(defun total-bytes-allocated ()
  (+ (unsignedwide->integer *total-bytes-freed*)
     (%heap-bytes-allocated)))

(defun %freebytes ()
  (%normalize-areas)
  (let ((res 0))
    (do-consing-areas (area)
      (let ((bytes (ash (- (%fixnum-ref area ppc::area.high)
                           (%fixnum-ref area ppc::area.active))
                        ppc::fixnum-shift)))
        (incf res bytes)))
    res))

#| ;; moved
(defun object-in-application-heap-p (address)

  (with-macptrs ((app-zone (#_LMGetApplZone))
                 (app-lim (pref app-zone :zone.bkLim))
                 (address-ptr (%null-ptr)))
    (%setf-macptr-to-object address-ptr address)
    (and (macptr<= app-zone address-ptr)
         (macptr<= address-ptr app-lim))))
|#


(defun %usedbytes ()
  (%normalize-areas)
  (let ((static 0)
        (dynamic 0)
        (library 0))
    (do-consing-areas (area)
      (let* ((active (%fixnum-ref area ppc::area.active))
             (bytes (ash (- active (%fixnum-ref area ppc::area.low))
                         ppc::fixnum-shift))
             (code (%fixnum-ref area ppc::area.code)))
        ;; OBJECT-IN-APPLICATION-HEAP-P DOESN'T MAKE MUCH SENSE ON OSX
        (when (object-in-application-heap-p active)
          (if (eql code ppc::area-dynamic)
            (incf dynamic bytes)
            (if (eql code ppc::area-staticlib)
              (incf library bytes)
              ;; added check for code here for OSX
              (if (eql code ppc::area-static)(incf static bytes)))))))
    (values dynamic static library)))

(defun %stack-space ()
  (%normalize-areas)
  (let ((free 0)
        (used 0))
    (do-gc-areas (area)
      (when (member (%fixnum-ref area ppc::area.code)
                    '(#.ppc::area-vstack
                      #.ppc::area-cstack
                      #.ppc::area-tstack))
        (let ((active (%fixnum-ref area ppc::area.active))
              (high (%fixnum-ref area ppc::area.high))
              (low (%fixnum-ref area ppc::area.low)))
          (declare (fixnum active high low))
          (incf used (ash (- high active) ppc::fixnum-shift))
          (incf free (ash (- active low) ppc::fixnum-shift)))))
    (values (+ free used) used free)))


; Returns an alist of the form:
; ((stack-group cstack-free cstack-used vstack-free vstack-used tstack-free tstack-used)
;  ...)
(defun %stack-space-by-stack-group ()
  (let* ((res nil))
    (without-interrupts
     (do-unexhausted-stack-groups (sg)
       (push (cons sg (multiple-value-list (%stack-group-stack-space sg))) res)))
    res))

; Returns six values.
;   sp free
;   sp used
;   vsp free
;   vsp used
;   tsp free
;   tsp used
(defun %stack-group-stack-space (&optional (sg *current-stack-group*))
  (when (eq sg *current-stack-group*)
    (%normalize-areas))
  (labels ((free-and-used (area)
             (let* ((low (%fixnum-ref area ppc::area.low))
                    (high (%fixnum-ref area ppc::area.high))
                    (active (%fixnum-ref area ppc::area.active))
                    (free (ash (- active low) ppc::fixnum-shift))
                    (used (ash (- high active) ppc::fixnum-shift)))
               (declare (fixnum low high active))
               (loop
                 (setq area (%fixnum-ref area ppc::area.older))
                 (when (eql area 0) (return))
                 (let ((low (%fixnum-ref area ppc::area.low))
                       (high (%fixnum-ref area ppc::area.high)))
                   (declare (fixnum low high))
                   (incf used (ash (- high low) ppc::fixnum-shift))))
               (values free used))))
    (multiple-value-bind (cf cu) (free-and-used (sg.cs-area sg))
      (multiple-value-bind (vf vu) (free-and-used (sg.vs-area sg))
        (multiple-value-bind (tf tu) (free-and-used (sg.ts-area sg))
          (values cf cu vf vu tf tu))))))


#| ;; moved to l1-utils-ppc so dont have to patch _freemem
(defun room (&optional (verbose :default))
  (let* ((freebytes (%freebytes))
         (heapspace (#_FreeMem))
         )
    (format t "~&There are at least ~:D bytes of available RAM.~%"
            (+ freebytes heapspace))
    (when verbose
      (multiple-value-bind (usedbytes static-used staticlib-used) (%usedbytes)
        (let* ((lispheap  (+ freebytes usedbytes))
               (static (+ static-used staticlib-used))
               (applzone (#_LMGetApplZone))
               (macheap   (- (%get-long applzone)
                             (%ptr-to-int applzone)
                             static
                             lispheap)))
          (flet ((k (n) (round n 1024)))
            (princ "
                  Total Size             Free                 Used")
            (format t "~&Mac Heap:  ~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)"
                    macheap
                    (floor macheap 1024)
                    heapspace
                    (floor heapspace 1024)
                    (- macheap heapspace)
                    (ceiling (- macheap heapspace) 1024))
            (format t "~&Lisp Heap: ~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)"
                    lispheap (k lispheap)
                    freebytes (k freebytes)
                    usedbytes (k usedbytes))
            (multiple-value-bind (stack-total stack-used stack-free)
                                 (%stack-space)
              (format t "~&Stacks:    ~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)"
                      stack-total (k stack-total)
                      stack-free (k stack-free)
                      stack-used (k stack-used)))
            (format t "~&Static: ~12T~10D (~DK)  ~33T~10D (~DK) ~54T~10D (~DK)"
                    static (k static)
                    0 0
                    static (k static))
            (unless (eq verbose :default)
              (terpri)
              (dolist (sg-info (%stack-space-by-stack-group))
                (destructuring-bind (sg sp-free sp-used vsp-free vsp-used tsp-free tsp-used)
                                    sg-info
                  (let ((sp-total (+ sp-used sp-free))
                        (vsp-total (+ vsp-used vsp-free))
                        (tsp-total (+ tsp-used tsp-free)))
                    (format t "~%~a~%  cstack:~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)~
                               ~%  vstack:~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)~
                               ~%  tstack:~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)"
                            (sg.name sg)
                            sp-total (k sp-total) sp-free (k sp-free) sp-used (k sp-used)
                            vsp-total (k vsp-total) vsp-free (k vsp-free) vsp-used (k vsp-used)
                            tsp-total (k tsp-total) tsp-free (k tsp-free) tsp-used (k tsp-used)))))))))))
  (values))
|#



#|
;; from l1-aprims.lisp - same as def in l1-aprims

(defun %pstr-segment-pointer (string pointer start end &optional script)  
  (setq start (require-type start 'fixnum)
        end   (require-type end 'fixnum))
  (when (> (- end start) 255) (error "String  ~s too long for pascal string" string))
  (if (base-string-p string)
    (multiple-value-bind (src offset end-offset) (dereference-base-string string)
      (declare (fixnum offset end-offset))
      (let ((src-len (- end-offset offset)))
        (declare (fixnum src-len limit))
        (cond ((minusp start) (setq start 0))
              ((< src-len start) (setq start src-len)))
        (cond ((minusp end) (setq end 0))
              ((< src-len end) (setq end src-len)))
        (when (< end start) (setq end start))
        (let ((len (min (- end start) 255)))
          (declare (fixnum len))
          (setf (%get-byte pointer 0) len) ; set length byte
          (incf len)
          (do* ((o (+ offset start) (1+ o))
                (j 1 (1+ j)))
               ((= j len))
            (declare (fixnum o j))
            (setf (%get-byte pointer j) (%scharcode src o))))))
    (with-pointers ((p pointer 1))
      (setf (%get-byte p -1) (%put-string-segment-contents p string start end 255 script))))
  nil)

; same as l1-aprims
(defun %cstr-segment-pointer (string pointer start end)
  (setq start (require-type start 'fixnum)
        end   (require-type end   'fixnum))
  (require-type string 'string)
  (if (base-string-p string)
    (multiple-value-bind (src offset end-offset) (dereference-base-string string)
      (declare (fixnum offset end-offset))
      (let ((src-len (- end-offset offset)))
        (declare (fixnum src-len))
        (cond ((minusp start) (setq start 0))
              ((< src-len start) (setq start src-len)))
        (cond ((minusp end) (setq end 0))
              ((< src-len end) (setq end src-len)))
        (when (< end start) (setq end start))
        (let ((len (- end start)))
          (declare (fixnum len))
          (do* ((o (+ offset start) (1+ o))
                (i 0 (1+ i)))
               ((= i len) (setf (%get-byte pointer i) 0))
            (declare (fixnum o i))
            (setf (%get-byte pointer i) (%scharcode src o))))))
    (with-pointers ((p pointer))
      ; actually, doing this in either case is better.
      (setf (%get-byte p (%put-string-segment-contents p string start (+ start end))) 0)))
  nil)
|#


; P is a macptr pointing to a record of type :unsignedwide.
; Return its value as an integer.
(defppclapfunction unsignedwide->integer ((uwidep arg_z))
  (lwz imm1 ppc::macptr.address arg_z)
  (lwz imm0 0 imm1)
  (cmpwi cr0 imm0 0)
  (lwz imm1 4 imm1)
  (cmpwi cr1 imm1 0)
  (li imm2 (ppc::make-vheader 3 ppc::subtag-bignum))
  (beq cr0 @1word)
  (bgt cr0 @2words)
; Need a 3-digit bignum:
  @make2or3
  (stwu rzero 16 freeptr)
  (la arg_z ppc::fulltag-misc initptr)
  (mr initptr freeptr)
  (stw imm2 ppc::misc-header-offset arg_z)
  (stw imm1 ppc::misc-data-offset arg_z)
  (stw imm0 (+ 4 ppc::misc-data-offset) arg_z)
  (blr)
  @2words
  (li imm2 (ppc::make-vheader 2 ppc::subtag-bignum))
  (b @make2or3)
  @1word
  (blt cr1 @2words)
  (clrrwi. imm2 imm1 (- ppc::least-significant-bit ppc::nfixnumtagbits))
  (box-fixnum arg_z imm1)
  (beqlr+ cr0)
  (li imm2 (ppc::make-vheader 1 ppc::subtag-bignum))
  (stwu rzero 8 freeptr)
  (la arg_z ppc::fulltag-misc initptr)
  (mr initptr freeptr)
  (stw imm2 ppc::misc-header-offset arg_z)
  (stw imm1 ppc::misc-data-offset arg_z)
  (blr))




(defun list-length (l)
  (do* ((n 0 (+ n 2))
        (fast l (cddr fast))
        (slow l (cdr slow)))
       ((null fast) n)
    (declare (fixnum n))
    (if (null (cdr fast))
      (return (the fixnum (1+ n)))
      (if (and (eq fast slow)
               (> n 0))
        (return nil)))))


(defun length (seq)
  (let* ((typecode (ppc-typecode seq)))
    (declare (fixnum typecode))
    (if (= typecode ppc::tag-list)
      (or (list-length seq)
          (%err-disp $XIMPROPERLIST seq))
      (if (= typecode ppc::subtag-vectorH)
        (%svref seq ppc::vectorH.logsize-cell)
        (if (> typecode ppc::subtag-vectorH)
          (uvsize seq)
          (report-bad-arg seq 'sequence))))))


(defppclapfunction values ()
  (vpush-argregs)
  (add temp0 nargs vsp)
  (ba .SPvalues))

; The compiler open-codes this (calling it "ppc-typecode".)
; If we need a runtime version, we should probably just
; eval-redef it ...
(defppclapfunction extract-typecode ((x arg_z))
  (check-nargs 1)
  (extract-typecode imm0 arg_z)
  (box-fixnum arg_z imm0)
  (blr))

(defppclapfunction %write-to-file-descriptor ((fd arg_x) (buf arg_y) (n arg_z))
  (unbox-fixnum imm0 fd)
  (macptr-ptr imm1 buf)
  (unbox-fixnum imm2 n)
  (li 0 4)                              ; 4 = write syscall
  (sc)
  (li 0 0)
  (li 0 0)
  (blr))

; end of ppc-misc.lisp

