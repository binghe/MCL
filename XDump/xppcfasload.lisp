;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: xppcfasload.lisp,v $
;;  Revision 1.6  2006/02/06 20:46:41  alice
;;  ; fix xppc-subtag-bytes for double-float-vector
;;
;;  Revision 1.5  2003/12/08 08:19:50  gtbyers
;;  Remove commented-out test cases.
;;
;;  12 2/23/96 akh  gary's fix so funcall of macro errors vs. crash
;;  10 12/22/95 gb  xppc-save-string takes extended-p flag vice 68k subtype;
;;                  write readonly section bounds for kernel
;;  5 10/26/95 akh  damage control
;;  5 10/26/95 gb   save-htab writes PPC deleted-markers.  %xppc-fasl-listX
;;                  updated cdrs, not cars.  commented-out forms dump
;;                  level-0;**;*.pfsl to ccl:ppc-boot.
;;  (do not edit before this line!!)

; lose need for subprims shared library
;; ------ 5.2b6
; fix xppc-subtag-bytes for double-float-vector
; ------- 5.1 final
; 05/06/97 bill (setf xppc-symbol-plist) now notices if the plist has already been set.
; ------------- 4.1
; 03/05/97 gb   define & use *pmcl-kernel-cfrg-name*.
; ----- 4.0
; 08/01/96 gb   turn *GC-EVENT-STATUS-BITS* off for now.
; 07/29/96 bill *GC-EVENT-STATUS-BITS* initialized to (ash 1 $gc-integrity-check-bit)
; 07/16/96 gb   xload-level-0: nuke LISP, USER packages if present.
; 06/20/96 gb   pmcl-kernel: version 4.0, libname = "pmcl-kernel4".
;               *GC-EVENT-STATUS-BITS* initialized to 0.
; ----- 3.9
; 04/09/96 gb   import kernel-version stuff; %excised-code%.
; 04/02/96 gb   fix xppc-relativize-subprim-calls again.
; 02/20/96 gb   fix prepend-subprims-code; normalize-code-vector in 
;               *ppc-macro-apply-code*.
; 01/20/96 gb   ppc changes; headers on all sections' contents
; 12/13/95 gb   %builtin-functions%; pkg.shadow bug
; 12/11/95 bill eliminate lap
; 11/03/95 bill warn instead of break about "PPC macro..."
; 10/16/95 *pef-image-file-type* now "APPL".

(in-package "CCL")


(eval-when (:compile-toplevel :execute)
(require "FASLENV" "ccl:xdump;faslenv")
(require "PPC-ARCH" "ccl:compiler;ppc;ppc-arch")
(require "PPC-LAP" "ccl:compiler;ppc;ppc-lap")


(defmacro defxppcfaslop (n arglist &body body)
  `(setf (svref *xppc-fasl-dispatch-table* ,n)
         #'(lambda ,arglist ,@body)))

(defmacro xppc-copy-faslop (n)
  `(let* ((n ,n))
     (setf (svref *xppc-fasl-dispatch-table* n)
           (svref *fasl-dispatch-table* n))))
)

; This is used to pass the value of lisp_nil into the
; kernel.  The data section will look like:
;  dc.l (ppc::make-vheader (+ 1024 3) ppc::subtag-u32-vector)
;  dc.l import_ref_to "set_nil_and_start"
;  dc.l code_address, lisp_nil
;  ds.l 1024  ; lisp_globals
;   ds.b fulltag_nil
; lisp_nil:      ; our TOC anchor
; ...
; which explains what (- (+ ppc::fulltag-nil 4096 12)) is all about.
(defparameter *ppc-application-entry-function-code*
  (uvref (%define-ppc-lap-function nil '((lwz imm1 (- (+ ppc::fulltag-nil 4096 12)) rnil)
                                         (lwz imm2 0 imm1)
                                         (mr imm0 rnil)
                                         (mtctr imm2)
                                         (lwz rnil 4 imm1)
                                         (bctr)))
         0))

(defparameter *ppc-macro-apply-code*
  (#+ppc-target normalize-code-vector
   #-ppc-target identity
  (uvref
   (%define-ppc-lap-function  ()
                              '((li arg_y '#.$xnotfun)
                                (lwz arg_z (+ ppc::misc-data-offset (ash 1 ppc::word-shift)) nfn)
                                (set-nargs 2)
                                (ba .SPksignalerr)))
   0
   )))

(defparameter *ppc-closure-trampoline-code*
  (#+ppc-target normalize-code-vector
   #-ppc-target identity
  (uvref
   (%define-ppc-lap-function  ()
                              '((ba .SPcall-closure)))
   0
   )))


; For now, do this with a UUO so that the kernel can catch it.
(defparameter *ppc-udf-code*
  (#+ppc-target normalize-code-vector
   #-ppc-target identity
   (uvref (%define-ppc-lap-function nil '((ba .SPudfcall))) 0)))


(defparameter *ppc-excised-code*
  (#+ppc-target normalize-code-vector
   #-ppc-target identity
   (uvref (%define-ppc-lap-function nil '((uuo_interr #.ppc::error-excised-function-call 0))) 0)))

(defun make-ppc-header (element-count subtag)
  (logior (ash element-count ppc::num-subtag-bits) subtag))


(defvar *xppc-symbol-header* (make-ppc-header ppc::symbol.element-count ppc::subtag-symbol))

(defparameter *xppc-fasl-dispatch-table* (make-array (length *fasl-dispatch-table*)
                                                     :initial-element #'%bad-fasl))

#-ppc-target
(progn

(defun u32-ref (u32v byte-offset)
  (lap-inline (u32v byte-offset)
    (move.l arg_y atemp0)
    (getint arg_z)
    (move.l (atemp0 arg_z.l $v_data) arg_z)
    (jsr_subprim $sp-mkulong)))

(defun (setf u32-ref) (new u32v byte-offset)
  (lap-inline ()
    (:variable new u32v byte-offset)
    (move.l (varg new) arg_z)
    (jsr_subprim $sp-getXlong)
    (move.l (varg u32v) atemp0)
    (move.l (varg byte-offset) arg_y)
    (getint arg_y)
    (move.l acc (atemp0 arg_y.l $v_data)))
  new)

(defun u16-ref (u32v byte-offset)
  (lap-inline (byte-offset u32v 0)
    (move.l arg_y atemp0)
    (getint arg_x)
    (move.w (atemp0 arg_x.l $v_data) arg_z)
    (mkint arg_z)))

(defun (setf u16-ref) (new u32v byte-offset)
  (lap-inline (new u32v byte-offset)
    (getint arg_z)
    (getint arg_x)
    (move.l arg_y atemp0)
    (move.w arg_x (atemp0 arg_z.l $v_data)))
  new)

(defun u8-ref (u32v byte-offset)
  (lap-inline (byte-offset u32v 0)
    (move.l arg_y atemp0)
    (getint arg_x)
    (move.b (atemp0 arg_x.l $v_data) arg_z)
    (mkint arg_z)))

(defun (setf u8-ref) (new u32v byte-offset)
  (lap-inline (new u32v byte-offset)
    (getint arg_z)
    (getint arg_x)
    (move.l arg_y atemp0)
    (move.b arg_x (atemp0 arg_z.l $v_data)))
  new)

) ; end of #-ppc-target

; Maybe we should use this version for both targets.
; It's only marginally slower than the lap (a couple of extra shift instructions)
#+ppc-target
(progn


(defun u32-ref (u32v byte-offset)
  (declare (type (simple-array (unsigned-byte 32) (*)) u32v)
           (fixnum byte-offset))
  (locally (declare (optimize (speed 3) (safety 0)))
    ;; aref does uuo for bignum val - .spmisc_ref is much faster - fixed to not use uuo
    (aref u32v (ash byte-offset -2))))


(defun (setf u32-ref) (new u32v byte-offset)
  (declare (type (simple-array (unsigned-byte 32) (*)) u32v)
           (fixnum byte-offset))
  (locally (declare (optimize (speed 3) (safety 0)))
    (setf (aref u32v (ash byte-offset -2))
          (logand new #xffffffff))))


(defun u16-ref (u16v byte-offset)
  (declare (type (simple-array (unsigned-byte 16) (*)) u16v)
           (fixnum byte-offset))
  (locally (declare (optimize (speed 3) (safety 0)))
    (aref u16v (ash byte-offset -1))))

(defun (setf u16-ref) (new u16v byte-offset)
  (declare (type (simple-array (unsigned-byte 16) (*)) u16v)
           (fixnum byte-offset))
  (locally (declare (optimize (speed 3) (safety 0)))
    (setf (aref u16v (ash byte-offset -1))
          new)))

(defun u8-ref (u8v byte-offset)
  (declare (type (simple-array (unsigned-byte 8) (*)) u8v)
           (fixnum byte-offset))
  (locally (declare (optimize (speed 3) (safety 0)))
    (aref u8v byte-offset)))

(defun (setf u8-ref) (new u8v byte-offset)
  (declare (type (simple-array (unsigned-byte 8) (*)) u8v)
           (fixnum byte-offset))
  (locally (declare (optimize (speed 3) (safety 0)))
    (setf (aref u8v byte-offset) new)))

) ; end of #-ppc-target

(defun untagged-addr (addr)
  (declare (fixnum addr))
  (logand (lognot 7) addr))

(defparameter *xppc-spaces* nil)
(defparameter *xppc-image-file* nil)

(defstruct xppc-space
  (vaddr 0)
  (size (ash 1 18))
  (lowptr 0)
  (ref-map nil)
  (data nil)
  (name ""))

(defmethod print-object ((s xppc-space) stream)
  (print-unreadable-object (s stream :type t)
    (format stream "~a @#x~8,'0x len = ~d" (xppc-space-name s) (xppc-space-vaddr s) (xppc-space-lowptr s))))

; :constructor ... :constructor ... <gasp> ... must remember ... :constructor

(defun init-xppc-space (vaddr size name &optional relocs)
  (let* ((nfullwords (ash (+ size 3) -2))
         (space (make-xppc-space :vaddr vaddr
                                 :size size
                                 :name name
                                 :ref-map (if relocs (make-array nfullwords :element-type 'bit :initial-element 0))
                                 :data (make-array nfullwords
                                                   :element-type '(unsigned-byte 32)
                                                   :initial-element 0))))
    (push space *xppc-spaces*)
    space))

; Nilreg-relative symbols.

(defparameter %builtin-functions%
  #(+-2 --2 *-2 /-2 =-2 /=-2 >-2 >=-2 <-2 <=-2 eql length sequence-type
        assq memq logbitp logior-2 logand-2 ash 
        %negate logxor-2 %aref1 %aset1
        ; add more
        )
  "Symbols naming fixed-arg, single-valued functions")
        
(defparameter *xppc-nrs* (mapcar #'(lambda (s)
                                     (or (assq s '((nil) (%pascal-functions%) (*all-metered-functions*)
                                                   (*%dynvfp%* . 0) (*%dynvlimit%* . 0) (*background-sleep-ticks*)
                                                   (*foreground-sleep-ticks*) (*window-update-wptr*)
                                                   (*pre-gc-hook*) (*post-gc-hook*) (%handlers%) (%saved-method-var%)
                                                   (%finalization-alist%) (*current-stack-group*) (%closure-code%)))
                                         s))
                                 ppc::*ppc-nilreg-relative-symbols*))

(defparameter *xppc-readonly-space-address* #x10000)
(defparameter *xppc-readonly-space-size* (ash 1 18))
(defparameter *xppc-dynamic-space-address* (+ *xppc-readonly-space-address* (ash 64 20 )))
(defparameter *xppc-dynamic-space-size* (ash 1 18))
(defparameter *xppc-nil* (+ *xppc-dynamic-space-address* 16 (* 1024 4) ppc::fulltag-nil))
(defparameter *xppc-T* (+ *xppc-nil* ppc::t-offset))
(defparameter *xppc-nilsym* (+ *xppc-T* ppc::symbol.size))
(defparameter %xppc-unbound-function% (+ (- *xppc-T* ppc::fulltag-misc) (* (length *xppc-nrs*) ppc::symbol.size) ppc::fulltag-misc))
(defparameter *xppc-dynamic-space* nil)
(defparameter *xppc-readonly-space* nil)
(defparameter *xppc-symbols* nil)
(defparameter *xppc-package-alist* nil)         ; maps real package to clone
(defparameter *xppc-aliased-package-addresses* nil)     ; cloned package to address
(defparameter *xppc-cold-load-functions* nil)
(defparameter *xppc-fcell-refs* nil)    ; function cells referenced, for warnings
(defparameter *xppc-vcell-refs* nil)    ; value cells, for warnings
(defparameter *xppc-loading-file-source-file* nil)

(defparameter *xppc-pure-code-p* t)     ; when T, subprims are copied to readonly space
                                        ; and code vectors are allocated there, reference subprims
                                        ; pc-relative.

(defparameter *xppc-write-xsym-file* t)
(defparameter *xppc-unit-info* ())

; This is just a hint: if PROBE-FILE fails, do a CHOOSE-FILE-DIALOG to find the 
; subprims library.

(defparameter *xppc-subprims-pathname* "ccl:pmcl;subprims")

; This does a heap walk, starting at the indicated logical address.  Any word
; tagged as a lisp pointer gets its ref-bit set.
(defun xppc-note-relocations (space start-dword-addr)
  (multiple-value-bind (v byte-offset) (xppc-lookup-address start-dword-addr)
    (declare (fixnum byte-offset))
    (let* ((word-offset (ash byte-offset -2))
           (end-word (ash (xppc-space-lowptr space) -2))
           (bits (xppc-space-ref-map space)))
      (declare (fixnum word-offset end-word))
      (flet ((note-if-relocatable (word offset bitmap)
               (let* ((fulltag (logand word ppc::fulltagmask)))
                 (declare (fixnum fulltag))
                 (if (or (= fulltag ppc::fulltag-misc)
                         (= fulltag ppc::fulltag-cons)
                         (= fulltag ppc::fulltag-nil))
                   (setf (sbit bitmap offset) 1)))))
        (do* ()
             ((>= word-offset end-word) (unless (= word-offset end-word) (error "Bug: walked past end of heap.")))
          (let* ((w (aref v word-offset))
                 (wtag (logand w ppc::fulltagmask)))
            (declare (fixnum wtag))
            (if (= wtag ppc::fulltag-immheader)
              (progn                    ; skip this object
                (let* ((subtag (logand w (1- (ash 1 ppc::num-subtag-bits))))
                       (element-count (ash w (- ppc::num-subtag-bits)))
                       (nwords element-count))
                  (declare (fixnum nwords element-count subtag))
                  (if (> subtag ppc::max-32-bit-ivector-subtag)
                    (if (<= subtag ppc::max-8-bit-ivector-subtag)
                      (setq nwords (ash (+ element-count 3) -2))
                      (if (<= subtag ppc::max-16-bit-ivector-subtag)
                        (setq nwords (ash (1+ element-count) -1))
                        (if (= subtag ppc::subtag-bit-vector)
                          (setq nwords (ash (+ element-count 31) -5))
                          (setq nwords (ash element-count 2))))))
                  (setq word-offset (logand (lognot 1) (+ word-offset (+ nwords 2))))))
              (progn
                (note-if-relocatable w word-offset bits)
                (incf word-offset)
                (note-if-relocatable (aref v word-offset) word-offset bits)
                (incf word-offset)))))))))

        
(defun xppc-lookup-symbol (sym)
  (gethash (%symbol->symptr sym) *xppc-symbols*))

(defun (setf xppc-lookup-symbol) (addr sym)
  (setf (gethash (%symbol->symptr sym) *xppc-symbols*) addr))

(defun xppc-lookup-address (address)
  (declare (fixnum address))
  (dolist (space *xppc-spaces* (error "Address #x~8,'0x not found in defined address spaces ." address))
    (let* ((vaddr (xppc-space-vaddr space)))
      (declare (fixnum vaddr))
      (if (and (<= vaddr address)
               (< address (the fixnum (+ vaddr (the fixnum (xppc-space-size space))))))
        (return (values (xppc-space-data space) (the fixnum (- address vaddr))))))))

(defun xppc-u32-at-address (address)
  (multiple-value-bind (v o) (xppc-lookup-address address)
    (u32-ref v o)))

(defun (setf xppc-u32-at-address) (new address)
  (multiple-value-bind (v o) (xppc-lookup-address address)
    (setf (u32-ref v o) new)))

(defun xppc-u16-at-address (address)
  (multiple-value-bind (v o) (xppc-lookup-address address)
    (u16-ref v o)))

(defun (setf xppc-u16-at-address) (new address)
  (multiple-value-bind (v o) (xppc-lookup-address address)
    (setf (u16-ref v o) new)))

(defun xppc-u8-at-address (address)
  (multiple-value-bind (v o) (xppc-lookup-address address)
    (u8-ref v o)))

(defun (setf xppc-u8-at-address) (new address)
  (multiple-value-bind (v o) (xppc-lookup-address address)
    (setf (u8-ref v o) new)))

(defun xppc-immval (imm)
  (if (or (typep imm 'fixnum)
          (and (<= #.(ash (- (expt 2 31)) (- ppc::fixnum-shift))
                   imm
                   #.(1- (ash (expt 2 31) (- ppc::fixnum-shift))))))
    (ash imm ppc::fixnumshift)
    (error "Bad idea.")))

; "grow" the space: make a new data vector (and, if the space
; has a ref-map, a new ref-map.) Copy old data (and ref-map
; entries) to new data vector (& new ref-map).  Update size,
; data, & ref-map fields.
; Grow (arbitrarily) by 64K bytes, or as specified by caller.
(defun xppc-more-space (space &optional (delta (ash 1 16)))
  (declare (fixnum delta))
  (setq delta (logand (lognot 3) (the fixnum (+ delta 3))))
  (let* ((old-size (xppc-space-size space))
         (old-data (xppc-space-data space))
         (old-ref-map (xppc-space-ref-map space))
         (old-nfullwords (ash old-size -2))
         (delta-nfullwords (ash delta -2))
         (new-size (+ old-size delta))
         (new-nfullwords (+ old-nfullwords delta-nfullwords))
         (new-data (make-array (the fixnum new-nfullwords)
                               :element-type '(unsigned-byte 32)
                               :initial-element 0))
         (new-ref-map (if old-ref-map (make-array (the fixnum new-nfullwords)
                                                  :element-type 'bit
                                                  :initial-element 0))))
    (declare (fixnum old-size old-nfullwords delta-nfullwords))
    (declare (type (simple-array (unsigned-byte 32) (*)) old-data new-data))
    (dotimes (i old-nfullwords)
      (declare (optimize (speed 3) (safety 0)))
      (setf (aref new-data i) (aref old-data i)))
    (if new-ref-map
      (locally
        (declare (type simple-bit-vector old-ref-map new-ref-map))
        (dotimes (i old-nfullwords)
          (declare (optimize (speed 3) (safety 0)))
          (setf (aref new-ref-map i) (aref old-ref-map i)))))
    (setf (xppc-space-size space) new-size
          (xppc-space-data space) new-data
          (xppc-space-ref-map space) new-ref-map)
    new-size))
                               

(defun xppc-alloc (space tag nbytes)
  (declare (fixnum tag nbytes))
  (when (logtest 7 nbytes) (error "~d not a multiple of 8 ." nbytes))
  (let* ((free (xppc-space-lowptr space)))
    (declare (fixnum free))
    (if (> nbytes (the fixnum (- (the fixnum (xppc-space-size space)) free)))
      (xppc-more-space space (the fixnum (+ nbytes (ash 1 16)))))
    (setf (xppc-space-lowptr space) (the fixnum (+ free nbytes)))
    (let* ((offset (+ free tag)))
      (declare (fixnum offset))
      (values 
       (the fixnum (+ (the fixnum (xppc-space-vaddr space)) offset))
       (xppc-space-data space)
       offset))))

; element-count doesn't include header
(defun xppc-alloc-fullwords (space tag nelements)
  (xppc-alloc space tag (logand (lognot 7) (+ 7 4 (ash nelements 2)))))

(defun xppc-alloc-halfwords (space tag nelements)
  (xppc-alloc space tag (logand (lognot 7) (+ 7 4 (ash nelements 1)))))

(defun xppc-alloc-bytes (space tag nelements)
  (xppc-alloc space tag (logand (lognot 7) (+ 7 4 nelements))))

(defun xppc-alloc-doublewords (space tag nelements)
  (xppc-alloc space tag (logand (lognot 7) (+ 7 4 (ash nelements 3)))))

(defun xppc-alloc-bits (space tag nelements)
  (xppc-alloc space tag (logand (lognot 7) (+ 7 4 (ash (+ 7 nelements) -3)))))


(defun xppc-make-cons ( car cdr)
  (multiple-value-bind (cell-addr data offset) (xppc-alloc *xppc-dynamic-space* ppc::fulltag-cons ppc::cons.size)
    (declare (fixnum cell-addr offset))
    (setf (u32-ref data (the fixnum (+ offset ppc::cons.car))) car)
    (setf (u32-ref data (the fixnum (+ offset ppc::cons.cdr))) cdr)
    cell-addr))

; This initializes the gvector's contents to 0.  Might want to
; consider initializing it to NIL for the benefit of package and
; hashtable code.
(defun xppc-make-gvector (subtag len)
  (declare (fixnum subtype len))
  (multiple-value-bind (cell-addr data offset) (xppc-alloc-fullwords *xppc-dynamic-space* ppc::fulltag-misc len)
    (declare (fixnum cell-addr offset))
    (setf (u32-ref data (+ offset ppc::misc-header-offset)) (make-ppc-header len subtag))
    cell-addr))

(defun xppc-package->addr (p)
  (or (cdr (assq (or (cdr (assq p *xppc-package-alist*)) 
                     (error "Package ~s not cloned ." p))
                 *xppc-aliased-package-addresses*))
      (error "Cloned package ~s: no assigned address . " p)))

(defun xppc-addr->package (a)
  (or (car (rassoc (or (car (rassoc a *xppc-aliased-package-addresses* :test #'eq))
                       (error "Address ~d: no cloned package ." a))
                   *xppc-package-alist*))
      (error "Package at address ~d not cloned ." a)))

(defun xppc-make-symbol (pname-address &optional (package-address *xppc-nil*))
  (multiple-value-bind (cell-addr data offset) (xppc-alloc-fullwords *xppc-dynamic-space* ppc::fulltag-misc ppc::symbol.element-count)
    (declare (fixnum offset))
      (setf (u32-ref data (+ offset ppc::symbol.header)) *xppc-symbol-header*)
      (setf (u32-ref data (+ offset ppc::symbol.flags)) 0)
      (setf (u32-ref data (+ offset ppc::symbol.pname)) pname-address)
      (setf (u32-ref data (+ offset ppc::symbol.vcell)) ppc::unbound-marker)
      (setf (u32-ref data (+ offset ppc::symbol.package-plist)) package-address)
      (setf (u32-ref data (+ offset ppc::symbol.fcell)) %xppc-unbound-function%)
      ;(break "Made symbol at #x~x (#x~x)" cell-addr offset)
      cell-addr))

; No importing or shadowing can (easily) happen during the cold load; a symbol is present
; in no package other than its home package.
; This -just- finds or adds the symbol in the "clone" package's itab/etab.
; Somebody else has to copy the symbol to the image ...
(defun xppc-intern (symbol)
  (let* ((pname (symbol-name symbol))
         (namelen (length pname))
         (package (symbol-package symbol))
         (clone (cdr (assq package *xppc-package-alist*))))
    (unless (nth-value 1 (%find-package-symbol pname clone namelen))    ; already there
      (without-interrupts
       (let* ((htab (if (%get-htab-symbol pname namelen (pkg.etab package)) 
                      (pkg.etab clone) 
                      (pkg.itab clone))))
         (%htab-add-symbol symbol htab (nth-value 2 (%get-htab-symbol pname namelen htab))))))
    t))
     

(defun xppc-dword-align (nbytes &optional (header-p t))
  (logand (lognot 7) (+ nbytes 7 (if header-p 4 0))))

(defun xppc-subtag-bytes (subtag element-count)
  (declare (fixnum subtag element-count))
  (unless (= ppc::fulltag-immheader (logand subtag ppc::fulltagmask))
    (error "Not an ivector subtag: ~s" subtag))
  (let* ((element-bit-shift
          (if (<= subtag ppc::max-32-bit-ivector-subtag)
            5
            (if (<= subtag ppc::max-8-bit-ivector-subtag)
              3
              (if (<= subtag ppc::max-16-bit-ivector-subtag)
                4
                (if (= subtag ppc::subtag-double-float-vector)
                  6
                  1)))))
         (total-bits (ash element-count element-bit-shift))
         (fudge (if (= subtag ppc::subtag-double-float-vector) 4 0)))
    (+ fudge (ash (+ 7 total-bits) -3))))   ; byte count

    
(defun xppc-make-dfloat (space high low)
  (multiple-value-bind (dfloat-addr v o) (xppc-alloc-fullwords space ppc::fulltag-misc ppc::double-float.element-count)
    (declare (fixnum dfloat-addr o))
    (setf (u32-ref v (the fixnum (+ o ppc::double-float.header))) 
          (make-ppc-header ppc::double-float.element-count ppc::subtag-double-float))
    (setf (u32-ref v (the fixnum (+ o ppc::double-float.value))) high)
    (setf (u32-ref v (the fixnum (+ o ppc::double-float.val-low))) low)
    dfloat-addr))
        
(defun xppc-make-ivector (space subtag nelements)
  (declare (fixnum subtype nelements))
  (multiple-value-bind (addr v o) (xppc-alloc space ppc::fulltag-misc (xppc-dword-align (xppc-subtag-bytes subtag nelements) t))
    (declare (fixnum addr o))
    (setf (u32-ref v (the fixnum (- o ppc::fulltag-misc))) (make-ppc-header nelements subtag))
    (values addr v o)))

(defun xppc-%svref (addr i)
  (declare (fixnum addr i))
  (if (= (the fixnum (logand addr ppc::fulltagmask)) ppc::fulltag-misc)
    (multiple-value-bind (v offset) (xppc-lookup-address addr)
      (declare (fixnum offset))
      (u32-ref v (the fixnum (+ offset (the fixnum (+ ppc::misc-data-offset (the fixnum (ash i 2))))))))
    (error "Not a vector: #x~x" addr)))

(defun (setf xppc-%svref) (new addr i)
  (declare (fixnum addr i))
  (if (= (the fixnum (logand addr ppc::fulltagmask)) ppc::fulltag-misc)
    (multiple-value-bind (v offset) (xppc-lookup-address addr)
      (declare (fixnum offset))
      (setf (u32-ref v (the fixnum (+ offset (the fixnum (+ ppc::misc-data-offset (the fixnum (ash i 2))))))) new))
    (error "Not a vector: #x~x" addr)))

(defun xppc-car (addr)
  (declare (fixnum addr))
  (if (= (the fixnum (logand addr ppc::tagmask)) ppc::tag-list)
    (multiple-value-bind (v offset) (xppc-lookup-address addr)
      (declare (fixnum offset))
      (u32-ref v (the fixnum (+ offset ppc::cons.car))))
    (error "Not a list: #x~x" addr)))

(defun (setf xppc-car) (new addr)
  (declare (fixnum addr))
  (if (= (the fixnum (logand addr ppc::tagmask)) ppc::tag-list)
    (multiple-value-bind (v offset) (xppc-lookup-address addr)
      (declare (fixnum offset))
      (setf (u32-ref v (the fixnum (+ offset ppc::cons.car))) new))
    (error "Not a list: #x~x" addr)))

(defun xppc-cdr (addr)
  (declare (fixnum addr))
  (if (= (the fixnum (logand addr ppc::tagmask)) ppc::tag-list)
    (multiple-value-bind (v offset) (xppc-lookup-address addr)
      (declare (fixnum offset))
      (u32-ref v (the fixnum (+ offset ppc::cons.cdr))))
    (error "Not a list: #x~x" addr)))

(defun (setf xppc-cdr) (new addr)
  (declare (fixnum addr))
  (if (= (the fixnum (logand addr ppc::tagmask)) ppc::tag-list)
    (multiple-value-bind (v offset) (xppc-lookup-address addr)
      (declare (fixnum offset))
      (setf (u32-ref v (the fixnum (+ offset ppc::cons.cdr))) new))
    (error "Not a list: #x~x" addr)))

(defun xppc-symbol-value (addr)
  (declare (fixnum addr))
  (if (= (xppc-%svref addr -1) *xppc-symbol-header*)
    (xppc-%svref addr ppc::symbol.vcell-cell)
    (error "Not a symbol: #x~x" addr)))
  
(defun xppc-symbol-name (addr)
  (declare (fixnum addr))
  (if (= addr *xppc-nil*) (incf addr (+ ppc::t-offset ppc::symbol.size)))
  (let* ((header (xppc-%svref addr -1)))
    (if (= header *xppc-symbol-header*)
      (xppc-%svref addr ppc::symbol.pname-cell)
      (error "Not a symbol: #x~x" addr))))

(defun (setf xppc-symbol-value) (new addr)
  (if (= (xppc-%svref addr -1) *xppc-symbol-header*)
    (multiple-value-bind (v offset) (xppc-lookup-address addr)
      (declare (fixnum offset))
      (setf (u32-ref v (the fixnum (+ offset ppc::symbol.vcell))) new))
    (error "Not a symbol: #x~x" addr)))

(defun xppc-set (sym val)
  (check-type sym symbol)
  (check-type val integer)
  (let* ((symaddr (xppc-lookup-symbol sym)))
    (unless symaddr (error "Symbol address not found: ~s ." sym))
    (setf (xppc-symbol-value symaddr) val)))

(defun xppc-fset (addr def)
  (if (= (xppc-%svref addr -1) *xppc-symbol-header*)
    (multiple-value-bind (v offset) (xppc-lookup-address addr)
      (declare (fixnum offset))
      (setf (u32-ref v (the fixnum (+ offset ppc::symbol.fcell))) def))
    (error "Not a symbol: #x~x" addr)))

(defun (setf xppc-symbol-plist) (new addr)
  (declare (fixnum new addr))
  (let* ((plist-addr (+ addr ppc::symbol.package-plist))
         (package-plist (xppc-u32-at-address plist-addr)))
    (declare (fixnum plist-addr package-plist))
    (if (= ppc::fulltag-cons (logand package-plist ppc::fulltagmask))
      (warn "Symbol at #x~x: plist already set." addr)
      (setf (xppc-u32-at-address plist-addr)
            (xppc-make-cons package-plist new)))
    new))
      
  
; This handles constants set to themselves.
; Unless PRESERVE-CONSTANTNESS is true, the symbols $sym_vbit_const bit is cleared.
;  (This is done because the kernel tries to call EQUALP if constants are "redefined", and
;   EQUALP may not be defined early enough.)
(defun xppc-copy-symbol (symbol &optional (preserve-constantness (keywordp symbol)))
  (or (xppc-lookup-symbol symbol)
      (let* ((pname (symbol-name symbol))
             (home-package (symbol-package symbol))
             (addr (xppc-make-symbol (xppc-save-string pname nil (length pname))
                                     (if home-package 
                                       (xppc-package->addr home-package)
                                       *xppc-nil*))))
        (declare (fixnum addr))
        (xppc-intern symbol)
        (let* ((bits (logandc2 (%symbol-bits symbol) (ash 1 $sym_vbit_typeppred))))
          (setf (xppc-u32-at-address (the fixnum (+ addr ppc::symbol.flags)))
                (ash (if preserve-constantness
                       bits
                       (logand (lognot (ash 1 $sym_vbit_const)) bits)) 
                     ppc::fixnumshift)))
        (if (and (constantp symbol)
                 (eq (symbol-value symbol) symbol))
          (setf (xppc-symbol-value addr) addr))
        (setf (xppc-lookup-symbol symbol) addr))))


; Write a list to dynamic space.  No detection of circularity or structure sharing.
; The cdr of the final cons can be nil (treated as *xppc-nil*.)
; All cars must be addresses.

(defun xppc-save-list (l)
  (if (atom l)
    (or l *xppc-nil*)
    (xppc-make-cons (car l) (xppc-save-list (cdr l)))))

(defun xppc-save-string (str &optional extended-p (n (length str)))
  (declare (fixnum n 68k-subtype))
  (let* ((ppc-subtag (if extended-p ppc::subtag-simple-general-string ppc::subtag-simple-base-string)))
    (multiple-value-bind (addr v offset) (xppc-make-ivector *xppc-readonly-space* ppc-subtag n)
      (if (not extended-p)
        (do* ((p (+ offset ppc::misc-data-offset) (1+ p))
              (i 0 (1+ i)))
             ((= i n) str)
          (declare (fixnum i p))
          (setf (u8-ref v p) (char-code (schar str i))))
        (do* ((p (+ offset ppc::misc-data-offset) (+ 2 p))
              (n (ash n -1))
              (i 0 (1+ i)))
             ((= i n) str)
          (declare (fixnum i n p))
          (setf (u16-ref v p) (char-code (schar str i)))))
        addr)))

; Read a string from fasl file, save it to readonly-space.
(defun %xppc-fasl-readstr (s extended-p)
  (multiple-value-bind (str n new-p) (%fasl-readstr s extended-p)
    (declare (fixnum n subtype))
    (values (xppc-save-string str extended-p n) str n new-p)))


(defun xppc-clone-packages (packages)
  (let* ((alist (mapcar #'(lambda (p)
                            (cons p
                                  (gvector :package
                                            (cons (make-array (the fixnum (length (car (uvref p 0))))
                                                              :initial-element nil)
                                                  (cons 0 (cddr (uvref p 0))))   ; itab
                                            (cons (make-array (the fixnum (length (car (uvref p 1))))
                                                              :initial-element nil)
                                                  (cons 0 (cddr (uvref p 1))))   ; etab
                                            nil                         ; used
                                            nil                         ; used-by
                                            (copy-list (uvref p 4))     ; names
                                            nil)))
                        packages)))
    (flet ((lookup-clone (p) (or (cdr (assq p alist)) (error "Package ~S not cloned ." p))))
      (dolist (pair alist alist)
        (let* ((orig (car pair))
               (dup (cdr pair)))
          (setf (pkg.used dup) (mapcar #'lookup-clone (pkg.used orig))
                (pkg.used-by dup) (mapcar #'lookup-clone (pkg.used-by orig))))))))

; Dump each cloned package into dynamic-space; return an alist
(defun xppc-assign-aliased-package-addresses (alist)
  (let* ((addr-alist (mapcar #'(lambda (pair)
                                 (let* ((p (cdr pair))
                                        (v (xppc-make-gvector ppc::subtag-package (uvsize p))))
                                   (setf (xppc-%svref v pkg.names)
                                         (xppc-save-list (mapcar #'(lambda (n) (xppc-save-string n))
                                                                 (pkg.names p))))
                                   (cons p v)))
                             alist)))
    (flet ((clone->addr (clone)
             (or (cdr (assq clone addr-alist)) (error "cloned package ~S not found ." clone))))
      (dolist (pair addr-alist addr-alist)
        (let* ((p (car pair))
               (v (cdr pair)))
          (setf (xppc-%svref v pkg.used)
                (xppc-save-list (mapcar #'clone->addr (pkg.used p)))
                (xppc-%svref v pkg.used-by)
                (xppc-save-list (mapcar #'clone->addr (pkg.used-by p)))
                (xppc-%svref v pkg.shadowed) 
                (xppc-save-list (mapcar #'xppc-copy-symbol (pkg.shadowed p)))))))))


(defun xppc-init-spaces (nrs)
  (dolist (sym nrs)
    (let* ((pname (symbol-name sym)))
      (setf (xppc-lookup-symbol sym) 
            (xppc-make-symbol (xppc-save-string pname nil (length pname)))))))


(defun xppc-fasload (pathnames)
  (dolist (path pathnames)
    (multiple-value-bind (*load-pathname* *load-truename* source-file) (find-load-file (merge-pathnames path))
      (unless *load-truename*
        (return (signal-file-error $err-no-file path)))
      (setq path *load-truename*)
      (unless (eq (mac-file-type path) :pfsl)
        (error "~S is not a PPC FASL file ." path))
      (let* ((*readtable* *readtable*)
             (*package* *ccl-package*)   ; maybe just *package*
             (*loading-files* (cons path *loading-files*))
             (*xppc-loading-file-source-file* nil)
             (*loading-file-source-file* (namestring source-file)))
        (when *load-verbose*
            (format t "~&;Loading ~S..." *load-pathname*)
            (force-output))
        (multiple-value-bind (winp err) (%fasload (mac-namestring path) *xppc-fasl-dispatch-table*)
          (if (not winp) (%err-disp err)))))))
  
(defun xppc-check-symbols ()
  )

(defun xppc-write-byte-vector (stream v start n)
  (declare (fixnum start n))
  (%fwrite-from-vector (slot-value stream 'fblock) v start n))

(defun xppc-read-byte-vector (stream v start n)
  (%fread-to-vector (slot-value stream 'fblock) v start n))

(defun xppc-save-htab (htab)
  (let* ((htvec (car htab))
         (len (length htvec))
         (xvec (xppc-make-gvector ppc::subtag-simple-vector len))
         (deleted-marker ppc::unbound-marker))
    (dotimes (i len)
      (let* ((s (%svref htvec i)))
        (setf (xppc-%svref xvec i)
              (if s
                (if (symbolp s) (xppc-lookup-symbol s) deleted-marker)
                *xppc-nil*))))
    (xppc-make-cons  
     xvec 
     (xppc-make-cons
      (xppc-immval (cadr htab))
      (xppc-immval (cddr htab))))))

(defun xppc-finalize-packages ()
  (dolist (pair *xppc-aliased-package-addresses*)
    (let* ((p (car pair))
           (q (cdr pair)))
      (setf (xppc-%svref q pkg.etab) (xppc-save-htab (pkg.etab p)))
      (setf (xppc-%svref q pkg.itab) (xppc-save-htab (pkg.itab p))))))

(defun xppc-get-string (address)
    (multiple-value-bind (v o) (xppc-lookup-address address)
      (let* ((header (u32-ref v (+ o ppc::misc-header-offset)))
             (len (ash header (- ppc::num-subtag-bits)))
             (str (make-string len :element-type 'base-character))
             (p (+ o ppc::misc-data-offset)))
        (dotimes (i len str)
          (setf (schar str i) (code-char (u8-ref v (+ p i))))))))

(defun xppc-note-undefined-references ()
  (let* ((unbound-vcells nil)
         (undefined-fcells nil))
    (dolist (vcell *xppc-vcell-refs*)
      (declare (fixnum vcell))
      (when (= (the fixnum (xppc-u32-at-address (the fixnum (+ vcell ppc::symbol.vcell))))
               ppc::unbound-marker)
        (push vcell unbound-vcells)))
    (dolist (fcell *xppc-fcell-refs*)
      (declare (fixnum fcell))
      (when (= (the fixnum (xppc-u32-at-address (the fixnum (+ fcell ppc::symbol.fcell))))
               %xppc-unbound-function%)
        (push fcell undefined-fcells)))
    (flet ((xppc-symbol-name-string (addr) (xppc-get-string (xppc-symbol-name addr))))
      (when undefined-fcells
        (warn "Function names referenced but not defined: ~a" (mapcar #'xppc-symbol-name-string undefined-fcells)))
      (when unbound-vcells
        (warn "Variable names referenced but not defined: ~a" (mapcar #'xppc-symbol-name-string unbound-vcells))))))
  
; Slap a code-vector header and a NOP on the front of the subprims code.
; This assumes that the subprims (and the extra 8 bytes) will fit; in any
; reasonable world, it will.
#|
(defun xppc-prepend-subprims-code (space)
  (let* ((path *xppc-subprims-pathname*))
    (unless (probe-file path)
      (setq path (choose-file-dialog :mac-file-type "shlb"
                                     :mac-file-creator "cfrg")))
    (with-open-file (subprims path
                              :direction :input
                              :element-type '(unsigned-byte 8))
      (file-position subprims #x38)     ; rawSize field of section 0
      (flet ((read-u32 (stream)
               (logior 
                (ash (read-byte stream) 24)
                (ash (read-byte stream) 16)
                (ash (read-byte stream) 8)
                (read-byte stream))))
        (let* ((raw-size (read-u32 subprims))
               (raw-fullwords (ash raw-size -2))
               (disk-position (read-u32 subprims))
               (data-vector (xppc-space-data space)))
          (file-position subprims disk-position)
          (xppc-read-byte-vector subprims data-vector 8 raw-size)
          (setf (u32-ref data-vector 4) #x60000000)     ; a NOP
          (when (oddp raw-fullwords)
            (setf (u32-ref data-vector (+ 8 raw-size)) #x60000000)
            (incf raw-fullwords))
          (setf (u32-ref data-vector 0) (ppc::make-vheader (1+ raw-fullwords) ppc::subtag-code-vector))
          (setf (xppc-space-lowptr space) (xppc-dword-align (+ 8 raw-size) nil)))))))
|#

;; wish i knew how to get rid of this - make a copy of the subprims
;; but at least we no longer need the subprims shared library.
;; Alas when a subprim needs fixing we still have to a) rebuild the OSX kernel
;; b) rebuild ppc-boot using new kernel c) rebuild application using new ppc-boot  - UGH
(defun xppc-prepend-subprims-code (space)
  (let* ((raw-size (max 12000 (get-subprims-length)))
         (raw-fullwords (ash raw-size -2))
         (data-vector (xppc-space-data space)))
    (setf (u32-ref data-vector 4) #x60000000)  ; a NOP
    (dotimes (i raw-fullwords)
      (let* ((idx (ash i 2))
             (val (get-spjump-entry idx)))
        (setf (u32-ref data-vector (+ 8 idx)) val)))
    (when (oddp raw-fullwords)
      (setf (u32-ref data-vector (+ 8 raw-size)) #x60000000)
      (incf raw-fullwords))
    (setf (u32-ref data-vector 0) (ppc::make-vheader (1+ raw-fullwords) ppc::subtag-code-vector))
    (setf (xppc-space-lowptr space) (xppc-dword-align (+ 8 raw-size) nil))))


(defppclapfunction get-subprims-length ()
  (ref-global imm0 subprims-base)
  (ref-global imm1 subprims-end)   ;; not defined yet - OK now
  (sub imm0 imm1 imm0)
  (box-fixnum arg_z imm0)
  (blr))


(defppclapfunction get-spjump-entry ((i arg_z))
  (ref-global imm0 subprims-base)
  (unbox-fixnum imm1 arg_z)
  (lwzx imm0 imm0 imm1)
  (clrrwi. imm1 imm0 (- ppc::least-significant-bit ppc::nfixnumtagbits))
  (box-fixnum arg_z imm0)             ; assume no high bits set.
  (beqlr+)
  (ba .SPbox-unsigned))
               
; We're assuming here that the subprims jump table starts at byte-offset 8
; in the same data vector we're in.
; We reference the jump table entry, which isn't really necessary but
; (a) is a little easier and (b) makes incorporating debugging info
; for the subprims code a little easier.
(defun xppc-relativize-subprim-calls (data byte-offset nfullwords)
  (declare (fixnum byte-offset nfullwords))
  (do* ((i 0 (1+ i))
        (b byte-offset (+ b 4)))
       ((= i nfullwords))
    (declare (fixnum i b))
    (let* ((w (u32-ref data b))
           (major (ldb (byte 6 26) w)))
      (declare (fixnum major))
      (if (eql w 0) (return))
      (when (and (= major 18)           ; "b" opcode
                 (logbitp 1 w))         ; "aa" bit set
        (let* ((target (+ 8 (the fixnum (logand w (logand (1- (ash 1 26)) (lognot 3)))))))
          (declare (fixnum target))
          (setf (u32-ref data b)
                (dpb 18 (byte 6 26) (logior (the fixnum (logand w 1)) ; preserve "lk" bit
                                            (the fixnum (- target b))))))))))
               
(defun xppc-save-code-vector (code)
  (let* ((read-only-p *xppc-pure-code-p*)
         (n (uvsize code)))
    (declare (fixnum n))
    (multiple-value-bind (vector v o) 
                         (xppc-make-ivector 
                          (if read-only-p
                            *xppc-readonly-space*
                            *xppc-dynamic-space*)
                          ppc::subtag-code-vector
                          n)
      (dotimes (i n)
        (setf (xppc-%svref vector i) (uvref code i)))
      (when read-only-p
        (xppc-relativize-subprim-calls v (+ o ppc::misc-data-offset) n))
      vector)))
                          
#-carbon-compat                          
(defun target-pmcl-kernel-version ()
  #x04008000)                           ; Get serious.
#+carbon-compat
(defun target-pmcl-kernel-version ()
  #x04009000)
#-carbon-compat
(defparameter *pmcl-kernel-cfrg-name* "pmcl-kernel4.1")
#+carbon-compat ;; wtf is going on here
(defparameter *pmcl-kernel-cfrg-name* "pmcl-kernel4.4")

(defun xppcload (output-file &rest pathnames)
  (let* ((*xppc-symbols* (make-hash-table :test #'eq))
         (*xppc-spaces* nil)
         (*xppc-unit-info* (if *xppc-write-xsym-file* (cons "***fasl files***" nil)))
         (*xppc-readonly-space* (init-xppc-space *xppc-readonly-space-address* *xppc-readonly-space-size* ".text"))
         (*xppc-dynamic-space* (init-xppc-space *xppc-dynamic-space-address* *xppc-dynamic-space-size* ".data" t))
         (*xppc-package-alist* (xppc-clone-packages %all-packages%))
         (*xppc-cold-load-functions* nil)
         (*xppc-loading-file-source-file* nil)
         (*xppc-vcell-refs* nil)
         (*xppc-fcell-refs* nil)
         (*xppc-aliased-package-addresses* nil))
    ; The import descriptor is the first thing in dynamic space.
    ; It's followed by the entrypoint transfer vector,
    ;   which references the entrypoint code, which is the first thing in readonly space.
    ; The first thing after the static subprims code, that is.
    (when t ;*xppc-pure-code-p*  ;; <<
      (xppc-prepend-subprims-code *xppc-readonly-space*))
    (let* ((cv-len (uvsize *ppc-application-entry-function-code*)))
      (multiple-value-bind (entry-address v offset) (xppc-make-ivector *xppc-readonly-space* ppc::subtag-code-vector cv-len)
        (dotimes (i cv-len) (setf (u32-ref v (+ offset ppc::misc-data-offset (ash i 2))) (uvref *ppc-application-entry-function-code* i)))
        (xppc-make-cons 0 0)     ; cdr goes first in memory
        (xppc-make-cons *xppc-nil* entry-address)))
    
    (incf (xppc-space-lowptr *xppc-dynamic-space*) 4096)
    ; Make NIL.  Note that NIL is sort of a misaligned cons (it straddles two doublewords.)
    (xppc-make-cons *xppc-nil* 0)
    (xppc-make-cons 0 *xppc-nil*)
    ; Skip over the nilreg-relative symbols, create %unbound-function% and the package objects, then
    ; go back and fill in the nilreg-relative symbols.  Then start consing ..
    (let* ((nrs-lowptr (xppc-space-lowptr *xppc-dynamic-space*)))
      (setf (xppc-space-lowptr *xppc-dynamic-space*) (+ nrs-lowptr (* (length *xppc-nrs*) ppc::symbol.size)))
      ; The undefined-function object is a 1-element simple-vector (not a function vector).
      ; The code-vector in its 0th element should report the appropriate error.
      (let* ((udf-object (xppc-make-gvector ppc::subtag-simple-vector 1)))
        (setf (xppc-%svref udf-object 0) (xppc-save-code-vector *ppc-udf-code*)))
      (setq *xppc-aliased-package-addresses* (xppc-assign-aliased-package-addresses *xppc-package-alist*))
      (let* ((restore-lowptr (xppc-space-lowptr *xppc-dynamic-space*)))
        (setf (xppc-space-lowptr *xppc-dynamic-space*) nrs-lowptr)
        (dolist (pair *xppc-nrs*)
          (let* ((val-p (consp pair))
                 (val (if val-p (or (cdr pair) *xppc-nil*)))
                 (sym (if val-p (car pair) pair)))
            (xppc-copy-symbol sym t)
            (when val-p (xppc-set sym val))))
        (setf (xppc-space-lowptr *xppc-dynamic-space*) restore-lowptr)))
    ; This could be a little less ... procedural.
    (xppc-set '*package* (xppc-package->addr *ccl-package*))
    (xppc-set '*keyword-package* (xppc-package->addr *keyword-package*))
    (xppc-set '*interrupt-level* (xppc-immval -1))
    (xppc-set '%all-packages% (xppc-save-list (mapcar #'cdr *xppc-aliased-package-addresses*)))
    (xppc-set '%unbound-function% %xppc-unbound-function%)
    (xppc-set '%parse-string% (xppc-make-ivector *xppc-dynamic-space* ppc::subtag-simple-base-string 255))
    (xppc-set '*gc-event-status-bits* (xppc-immval 0 #|(ash 1 $gc-integrity-check-bit)|#))
    (xppc-set '*foreground* (xppc-lookup-symbol t))
    (xppc-set '%toplevel-catch% (xppc-copy-symbol :toplevel))
    (xppc-set '%closure-code% (xppc-save-code-vector *ppc-closure-trampoline-code*))
    (xppc-set '%macro-code% (xppc-save-code-vector *ppc-macro-apply-code*))
    (xppc-set '%excised-code% (xppc-save-code-vector *ppc-excised-code*))
    (let* ((len (length %builtin-functions%))
           (v (xppc-make-gvector ppc::subtag-simple-vector len)))
      (dotimes (i len)
        (setf (xppc-%svref v i) (xppc-copy-symbol (svref %builtin-functions% i))))
      (xppc-set '%builtin-functions% v))
    (xppc-fasload pathnames)
    (xppc-check-symbols)                ; Make sure interned symbols are.
    (when (= (xppc-symbol-value (xppc-lookup-symbol '%toplevel-function%))
             ppc::undefined)
      (warn "~S not set in loading ~S ." '%toplevel-function pathnames))
    (setf (xppc-symbol-value (xppc-copy-symbol '*xppc-cold-load-functions*))
          (xppc-save-list (setq *xppc-cold-load-functions*
                                (nreverse *xppc-cold-load-functions*))))
    (xppc-note-undefined-references)
    (xppc-finalize-packages)
    (xppc-dump-image output-file 
                     *xppc-dynamic-space-address*
                     (+ *xppc-dynamic-space-address* 8)
                     `((,*pmcl-kernel-cfrg-name* ,(target-pmcl-kernel-version) ,(target-pmcl-kernel-version) (:transfer-vector "set_nil_and_start" ,(+ *xppc-dynamic-space-address* 4)))))))

(defun xppc-dump-image (output-file heap-start entry-address import-list)
  (xppc-note-relocations *xppc-dynamic-space* *xppc-dynamic-space-address*)
  (setf (xppc-u32-at-address *xppc-dynamic-space-address*) (ppc::make-vheader (+ 1024 3) ppc::subtag-u32-vector))
  ; Write the 0th and first elements of the kernel_globals vectors as untagged pointers
  ; to the beginning and end of "dynamic space" (this is so the kernel can do a heap walk
  ; to relocate subprim calls.)  Mark these (dword-aligned) addresses as being relocatable.
  (setf (xppc-u32-at-address (+ *xppc-dynamic-space-address* 16)) heap-start)
  (setf (xppc-u32-at-address (+ *xppc-dynamic-space-address* 20)) (+ *xppc-dynamic-space-address* (xppc-space-lowptr *xppc-dynamic-space*)))
  (let* ((bits (xppc-space-ref-map *xppc-dynamic-space*)))
    (setf (sbit bits (ash 16 -2)) 1)
    (setf (sbit bits (ash 20 -2)) 1))
  ; The next word is supposed to be a pointer to some other static section in the application.
  ; The following two words describe the start and end of the readonly section.
  (setf (xppc-u32-at-address (+ *xppc-dynamic-space-address* 28)) *xppc-readonly-space-address*)
  (setf (xppc-u32-at-address (+ *xppc-dynamic-space-address* 32)) (+ *xppc-readonly-space-address* (xppc-space-lowptr *xppc-readonly-space*)))
  (let* ((bits (xppc-space-ref-map *xppc-dynamic-space*)))
    (setf (sbit bits (ash 28 -2)) 1)
    (setf (sbit bits (ash 32 -2)) 1))
  (write-pef-file output-file 
                  "pmcl_application" 
                  0 
                  *xppc-readonly-space* 
                  *xppc-dynamic-space* 
                  entry-address 
                  import-list
                  (if *xppc-unit-info* 
                    (list *xppc-unit-info*))))




;;; The xloader

(xppc-copy-faslop $fasl-noop)
(xppc-copy-faslop $fasl-etab-alloc)
(xppc-copy-faslop $fasl-eref)

; Should error if epush bit set, else push on *ppc-cold-load-functions* or something.
(defxppcfaslop $fasl-lfuncall (s)
  (let* ((fun (%fasl-expr-preserve-epush s)))
    (when (faslstate.faslepush s)
      (error "Can't call function for value : ~s" fun))
    (format t "~& cold-load function:")
    (push fun *xppc-cold-load-functions*)))

(xppc-copy-faslop $fasl-globals)        ; what the hell did this ever do ?

; fasl-char: maybe epush, return 32-bit representation of BASE-CHARACTER

(defxppcfaslop $fasl-char (s)
  (%epushval s (xppc-immval (code-char (%fasl-read-byte s)))))

(defxppcfaslop $fasl-fixnum (s)
  (%epushval s (xppc-immval
                ; This nonsense converts unsigned %fasl-read-long result to signed
                (rlet ((long :long))
                  (setf (%get-long long) (%fasl-read-long s))
                  (%get-long long)))))

(defxppcfaslop $fasl-float (s)
  (%epushval s (xppc-make-dfloat *xppc-readonly-space* (%fasl-read-long s) (%fasl-read-long s))))

(defxppcfaslop $fasl-str (s)
  (let* ((n (%fasl-read-size s)))
    (multiple-value-bind (str v o) (xppc-make-ivector *xppc-readonly-space* ppc::subtag-simple-base-string n)
      (%epushval s str)
      (%fasl-read-n-bytes s v (+ o  ppc::misc-data-offset) n)
      str)))

(defxppcfaslop $fasl-word-fixnum (s)
  (%epushval s (xppc-immval (%word-to-int (%fasl-read-word s)))))

(defun %xppc-fasl-make-symbol (s extended-p)
  (%epushval s (xppc-make-symbol (%xppc-fasl-readstr s extended-p))))

(defxppcfaslop $fasl-mksym (s)
  (%xppc-fasl-make-symbol s nil))

(defun %xppc-fasl-intern (s package extended-p)
  (multiple-value-bind (str len new-p) (%fasl-readstr s extended-p)
    (without-interrupts
     (multiple-value-bind (cursym access internal external) (%find-symbol str len package)
       (unless access
         (unless new-p (setq str (%fasl-copystr str len)))
         (setq cursym (%add-symbol str package internal external)))
       ; cursym now exists in the load-time world; make sure that it exists
       ; (and is properly "interned" in the world we're making as well)
       (%epushval s (xppc-copy-symbol cursym))))))

(defxppcfaslop $fasl-intern (s)
  (%xppc-fasl-intern s *package* nil))

(defxppcfaslop $fasl-pkg-intern (s)
  (let* ((addr (%fasl-expr-preserve-epush  s))
         (pkg (xppc-addr->package addr)))
    (%xppc-fasl-intern s pkg nil)))

(defun %xppc-fasl-package (s extended-p)
  (multiple-value-bind (str len new-p) (%fasl-readstr s extended-p)
    (let* ((p (%find-pkg str len)))
      (%epushval s (xppc-package->addr 
                    (or p (%kernel-restart $XNOPKG (if new-p str (%fasl-copystr str len)))))))))

(defxppcfaslop $fasl-pkg (s)
  (%xppc-fasl-package s nil))

(defxppcfaslop $fasl-cons (s)
  (let* ((cons (%epushval s (xppc-make-cons *xppc-nil* *xppc-nil*))))
    (setf (xppc-car cons) (%fasl-expr s)
          (xppc-cdr cons) (%fasl-expr s))
    (setf (faslstate.faslval s) cons)))
    
(defun %xppc-fasl-listX (s dotp)
  (let* ((len (%fasl-read-word s)))
    (declare (fixnum len))
    (let* ((val (%epushval s (xppc-make-cons *xppc-nil* *xppc-nil*)))
           (tail val))
      (setf (xppc-car val) (%fasl-expr s))
      (dotimes (i len)
        (setf (xppc-cdr tail) (setq tail (xppc-make-cons  (%fasl-expr s) *xppc-nil*))))
      (if dotp
        (setf (xppc-cdr tail) (%fasl-expr s)))
      (setf (faslstate.faslval s) val))))

(defxppcfaslop $fasl-list (s)
  (%xppc-fasl-listX s nil))

(defxppcfaslop $fasl-list* (s)
  (%xppc-fasl-listX s t))

(defxppcfaslop $fasl-nil (s)
  (%epushval s *xppc-nil*))

(defxppcfaslop $fasl-timm (s)
  (let* ((val (%fasl-read-long s)))
    #+paranoid (unless (= (logand $typemask val) $t_imm) 
                 (error "Bug: expected immediate-tagged object, got ~s ." val))
    (%epushval s val)))



(defxppcfaslop $fasl-arch (s)
  (%cant-epush s)
  (let* ((arch (%fasl-expr s)))
    (declare (fixnum arch))
    (unless (= arch (ash 1 ppc::fixnumshift)) (error "Not a PPC fasl file : ~s" (faslstate.faslfname s)))))

(defxppcfaslop $fasl-symfn (s)
  (let* ((symaddr (%fasl-expr-preserve-epush s))
         (fnobj (xppc-u32-at-address (+ symaddr ppc::symbol.fcell))))
    (if (and (= ppc::fulltag-misc (logand fnobj ppc::fulltagmask))
             (= ppc::subtag-function (xppc-u8-at-address (+ fnobj ppc::misc-subtag-offset))))
      (%epushval s fnobj)
      (error "symbol at #x~x is unfbound . " symaddr))))

(defxppcfaslop $fasl-eval (s)
  (let* ((expr (%fasl-expr-preserve-epush s)))
    (error "Can't evaluate expression ~s in cold load ." expr)
    (%epushval s (eval expr))))         ; could maybe evaluate symbols, constants ...

; Whether or not it's a good idea to allocate other things there
; is hard to say.  Let's assume that it is, for the time being.
(defxppcfaslop $fasl-ivec (s)
  (let* ((subtag (%fasl-read-byte s))
         (element-count (%fasl-read-size s))
         (read-only-code (and (= subtag ppc::subtag-code-vector) *xppc-pure-code-p*)))
    (declare (fixnum subtag))
    (multiple-value-bind (vector v o)
                         (xppc-make-ivector 
                          (if (and (= subtag ppc::subtag-code-vector) (not *xppc-pure-code-p*))
                            *xppc-dynamic-space* 
                            *xppc-readonly-space*)
                          subtag 
                          element-count)
      (%epushval s vector)
      (%fasl-read-n-bytes s v (+ o  ppc::misc-data-offset) (xppc-subtag-bytes subtag element-count))
      (when read-only-code
        (xppc-relativize-subprim-calls v (+ o ppc::misc-data-offset) element-count))
      vector)))

(defxppcfaslop $fasl-gvec (s)
  (let* ((subtype (%fasl-read-byte s))
         (n (%fasl-read-size s))
         (vector (xppc-make-gvector subtype n)))
    (declare (fixnum n))
    (%epushval s vector)
    (dotimes (i n (setf (faslstate.faslval s) vector))
      (setf (xppc-%svref vector i) (%fasl-expr s)))))

(defun xppc-note-cell-ref (loc imm)
  (declare (fixnum loc imm))
  (if (= loc ppc::symbol.fcell)
    (pushnew imm *xppc-fcell-refs*)
    (if (= loc ppc::symbol.vcell)
      (pushnew imm *xppc-vcell-refs*)))
  (the fixnum (+ loc imm)))


(defun xppc-lfun-name (lf)
  (let* ((header (xppc-%svref lf -1)))
    (unless (= ppc::subtag-function (logand header (1- (ash 1 ppc::num-subtag-bits))))
      (error "Not a function address: ~s" lf))
    (let* ((n (ash header (- ppc::num-subtag-bits))))
      (if (> n 2)
        (let* ((bits (ash (xppc-%svref lf (1- n)) (- ppc::fixnumshift))))
          (unless (logbitp 29 bits)
            (xppc-%svref lf (- n 2))))
        (error "Teeny, tiny, little function : ~s" lf)))))


(defun xppc-record-source-file (symaddr indicator)
  (when (or (eq indicator 'function)
            (eq indicator 'variable))
    (let* ((keyaddr (xppc-copy-symbol 'bootstrapping-source-files))
           (pathaddr (or *xppc-loading-file-source-file*
                         (if *loading-file-source-file*
                           (setq *xppc-loading-file-source-file* (xppc-save-string *loading-file-source-file*))))))
      (when pathaddr
        (let* ((keyval (if (eq indicator 'function)
                         (xppc-make-cons  pathaddr *xppc-nil*)
                         (xppc-make-cons
                          (xppc-make-cons 
                           (xppc-make-cons  (xppc-copy-symbol indicator) pathaddr)
                           *xppc-nil*)
                           *xppc-nil*))))
          (setf (xppc-symbol-plist symaddr) (xppc-make-cons keyaddr keyval)))))))

(defxppcfaslop $fasl-xchar (s)
  (%epushval s (xppc-immval (code-char (%fasl-read-word s)))))

(defxppcfaslop $fasl-mkxsym (s)
  (%xppc-fasl-make-symbol s t))

(defxppcfaslop $fasl-defun (s)
  (%cant-epush s)
  (let* ((fun (%fasl-expr s))
         (doc (%fasl-expr s)))
    (declare (ignore doc))
    (let* ((sym (xppc-lfun-name fun)))
      (when sym
        (when *xppc-write-xsym-file*
          (let* ((pname (xppc-get-string (xppc-%svref sym ppc::symbol.pname-cell)))
                 (code (xppc-%svref fun 0))
                 (start (+ code ppc::misc-data-offset))
                 (header (xppc-%svref code -1))
                 (nwords (ash  header (- ppc::num-subtag-bits))))
            (push (list pname start (ash 
                                     (dotimes (i nwords nwords)
                                       (when (eql 0 (xppc-%svref code i))
                                         (return i)))
                                     ppc::word-shift))
                  (cdr *xppc-unit-info*))
            
          
           ;(format t "~& lfun-name = ~s" pname)
          )))
      (xppc-record-source-file sym 'function)
      (xppc-fset sym fun))))

(defxppcfaslop $fasl-macro (s)
  (%cant-epush s)
  (let* ((fun (%fasl-expr s))
         (doc (%fasl-expr s)))
    (declare (ignore doc))
    (let* ((sym (xppc-lfun-name fun))
           (vector (xppc-make-gvector ppc::subtag-simple-vector 2)))
      (setf (xppc-%svref vector 0) (xppc-symbol-value (xppc-lookup-symbol '%macro-code%))
            (xppc-%svref vector 1) fun)
      (xppc-record-source-file sym 'function)
      (xppc-fset sym vector))))

(defxppcfaslop $fasl-defconstant (s)
  (%cant-epush s)
  (let* ((sym (%fasl-expr s))
         (val (%fasl-expr s))
         (doc (%fasl-expr s)))
    (declare (ignore doc))              ; could push it on some vcell somewhere.
    (xppc-record-source-file sym 'variable)
    (setf (xppc-symbol-value sym) val)
    (setf (xppc-u32-at-address (+ sym ppc::symbol.flags))
          (ash 
           (logior (ash 1 $sym_vbit_special) 
                   (ash 1 $sym_vbit_const) 
                   (ash (xppc-u32-at-address (+ sym ppc::symbol.flags)) 
                        (- ppc::fixnumshift)))
           ppc::fixnumshift))))

(defxppcfaslop $fasl-defparameter (s)
  (%cant-epush s)
  (let* ((sym (%fasl-expr s))
         (val (%fasl-expr s))
         (doc (%fasl-expr s)))
    (declare (ignore doc))              ; could push it on some vcell somewhere.
    (xppc-record-source-file sym 'variable)
    (setf (xppc-symbol-value sym) val)
    (setf (xppc-u32-at-address (+ sym ppc::symbol.flags))
          (ash 
           (logior (ash 1 $sym_vbit_special) 
                   (ash (xppc-u32-at-address (+ sym ppc::symbol.flags)) 
                        (- ppc::fixnumshift)))
           ppc::fixnumshift))))

(defxppcfaslop $fasl-defvar (s)
  (%cant-epush s)
  (let* ((sym (%fasl-expr s)))
    (xppc-record-source-file sym 'variable)
    (setf (xppc-u32-at-address (+ sym ppc::symbol.flags))
          (ash 
           (logior (ash 1 $sym_vbit_special) 
                   (ash (xppc-u32-at-address (+ sym ppc::symbol.flags)) 
                        (- ppc::fixnumshift)))
           ppc::fixnumshift))))

(defxppcfaslop $fasl-defvar-init (s)
  (%cant-epush s)
  (let* ((sym (%fasl-expr s))
         (val (%fasl-expr s))
         (doc (%fasl-expr s)))
    (declare (ignore doc))              ; could push it on some vcell somewhere.
    (when (= ppc::unbound-marker (xppc-symbol-value sym))
      (setf (xppc-symbol-value sym) val))
    (xppc-record-source-file sym 'variable)
    (setf (xppc-u32-at-address (+ sym ppc::symbol.flags))
          (ash 
           (logior (ash 1 $sym_vbit_special) 
                   (ash (xppc-u32-at-address (+ sym ppc::symbol.flags)) 
                        (- ppc::fixnumshift)))
           ppc::fixnumshift))))


(xppc-copy-faslop $fasl-skip)
(xppc-copy-faslop $fasl-prog1)

(defxppcfaslop $fasl-xintern (s)
  (%xppc-fasl-intern s *package* t))

(defxppcfaslop $fasl-pkg-xintern (s)
  (let* ((addr (%fasl-expr-preserve-epush  s))
         (pkg (xppc-addr->package addr)))
    (%xppc-fasl-intern s pkg t)))

(defxppcfaslop $fasl-xpkg (s)
  (%xppc-fasl-package s t))


(defxppcfaslop $fasl-src (s)
  (%cant-epush s)
  (let* ((path (%fasl-expr s)))
    (setq *xppc-loading-file-source-file* path)))


(defparameter *pef-image-file-type* "APPL")

(defun Xcompile-directory (dir &optional force)
  (dolist (src (directory (merge-pathnames dir "*.lisp")))
    (let* ((fasl (merge-pathnames  *.pfsl-pathname* src)))
      (when (or force
                (not (probe-file fasl))
                (> (file-write-date src)
                   (file-write-date fasl)))
        (compile-file src :target :ppc :output-file fasl :verbose t)))))

(defun Xcompile-level-0 (&optional force)
  (Xcompile-directory "ccl:level-0;" force)
  (Xcompile-directory "ccl:level-0;ppc;" force))

(defun Xload-level-0 (&optional (recompile t))
  (xload-level-0-carbon recompile))

(defun Xload-level-0-carbon (&optional (recompile t))
  (let* ((user-pkg (find-package "USER"))
         (lisp-pkg (find-package "LISP")))
    (when (and user-pkg (not (eq user-pkg (find-package "CL-USER"))))
      (delete-package user-pkg))
    (when (and lisp-pkg (not (eq lisp-pkg (find-package "CL"))))
      (delete-package lisp-pkg)))
  (when recompile
    (setq *.fasl-pathname* (make-pathname :type "cfsl" :defaults nil))
    (setq *.pfsl-pathname* (make-pathname :type "cfsl" :defaults nil))
    (pushnew :carbon-compat *features*)
    
    (Xcompile-level-0 (eq recompile :force)))
  (let* ((*load-verbose* t))
    (apply #'xppcload "ccl:ppc-boot" 
           (append (directory "ccl:level-0;ppc;*.cfsl")
                   (directory "ccl:level-0;*.cfsl")))))


  
