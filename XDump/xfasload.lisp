;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  5 10/26/95 akh  damage control
;;  5 10/26/95 gb   forms at bottom of file copy boot to lisp-8 data fork.
;;  2 10/13/95 bill ccl3.0x25
;;  (do not edit before this line!!)


(in-package "CCL")

;; 11/15/95 slh   compile-directory: force arg
;; 10/13/95 bill  *x68k-dynamic-space-size* doubles to 512K


(eval-when (:compile-toplevel :execute)
(require "FASLENV" "ccl:xdump;faslenv")




(defmacro defx68kfaslop (n arglist &body body)
  `(setf (svref *x68k-fasl-dispatch-table* ,n)
         #'(lambda ,arglist ,@body)))

(defmacro x68k-copy-faslop (n)
  `(let* ((n ,n))
     (setf (svref *x68k-fasl-dispatch-table* n)
           (svref *fasl-dispatch-table* n))))
)

(defrecord dumpheader
  (:d_version :long)
  (:d_timestamp :long)
  (:d_flags :word)

  (:d_nrs_start :long)
  (:d_nrs_end :long)
  (:d_nrsdisp :long)

  (:d_vcells_start :long)               ; lowvcell in saved image.
  (:d_vcells_end :long)                 ; end of vcells in saved image.
  (:d_vcells_disp :long)

  (:d_fcells_start :long)               ; lowfcell in saved image.
  (:d_fcells_end :long)                 ; end of vcells in saved image.
  (:d_fcells_disp :long)

  (:d_slfuns_start :long)               ; start of swappable lfun table
  (:d_slfuns_end :long)                 ; end of swappable lfun table
  (:d_slfuns_disp :long)

  (:d_gspace_start :long)
  (:d_gspace_end :long)
  (:d_dynamic_gspace_disp :long)

  (:d_ispace_start :long)
  (:d_ispace_end :long)
  (:d_dynamic_ispace_disp :long)

  (:d_static_gspace_start :long)        ; saved gspace_start,
  (:d_static_gspace_end :long)          ; gspace_end,
  (:d_static_gspace_disp :long)

  (:d_static_ispace_start :long)        ; ispace_start,
  (:d_static_ispace_end :long)          ; ispace_end (from static space).
  (:d_static_ispace_disp :long)

  (:d_nrsfilepos :long)                 ; image file position of nilreg-relative symbols
  (:d_maxslfunlen :long)                ; physical length of largest slfun vector.
  (:d_ifilepos :long)                   ; image file position of dumped ispace
  (:d_ifilelen :long)                   ; length of (uncompressed) ispace
  (:d_lzwifilelen :long)                ; compressed ispace length
  (:d_gfilepos :long)                   ; image file position of dumped gspace
  (:d_gfilelen :long)                   ; length of (uncompressed) gspace
  (:d_lzwgfilelen :long)                ; compressed gspace length
  (:d_sifilepos :long)                  ; image file position of dumped (static) ispace.
  (:d_sifilelen :long)                  ; length of (uncompressed) static ispace.
  (:d_lzwsifilelen :long)               ; compressed static ispace length
  (:d_sgfilepos :long)                  ; image file position of dumped (static) gspace
  (:d_sgfilelen :long)                  ; length of (uncompressed) static gspace
  (:d_lzwsgfilelen :long)               ; compressed static gspace length
  (:d_miscwfilepos :long)               ; image file position of "miscellaneous a5 words"
  (:d_miscwfilenum :word)               ; # misc a5 word blocks
  (:d_misclfilepos :long)               ; image file position of "miscellaneous a5 longs"
  (:d_misclfilenum :word)               ; # misc a5 long blocks
  (:d_nil :long)                        ; address of nil {t, nilsym}
  (:d_nil_disp :long)
  (:d_t	(:array :unsigned-byte 48))     ; two physical symbols, t and nilsym.
  (:d_vcellfilepos :long)               ; address of (nilreg-relative) value cells
  (:d_fcellfilepos :long)               ; address of (nilreg-relative) function cells
  (:d_fappunb :long)                    ; unbound fn, for symbol compression.
  (:d_slfunfilepos :long)               ; address of swappable lfun table
  (:d_slfunvfilepos :long)              ; start of slfunvs on disk
  (:d_slfunvfileend :long)              ; end of slfunvs on disk
  (:d_dynamicheaderpos :long)           ; where dynamic space header starts, if it's disjoint.
  (:d_packages (:array :long 7)))

(defparameter *x68k-fasl-dispatch-table* (make-array (length *fasl-dispatch-table*)
                                                     :initial-element #'%bad-fasl))

(defun x68k-u32-ref (bytev byte-offset)
  (lap-inline (bytev byte-offset)
    (move.l arg_y atemp0)
    (getint arg_z)
    (move.l (atemp0 arg_z.l $v_data) arg_z)
    (jsr_subprim $sp-mkulong)))

(defun (setf x68k-u32-ref) (new bytev byte-offset)
  (lap-inline ()
    (:variable new bytev byte-offset)
    (move.l (varg new) arg_z)
    (jsr_subprim $sp-getXlong)
    (move.l (varg bytev) atemp0)
    (move.l (varg byte-offset) arg_y)
    (getint arg_y)
    (move.l acc (atemp0 arg_y.l $v_data)))
  new)

(defun x68k-u16-ref (bytev byte-offset)
  (lap-inline (byte-offset bytev 0)
    (move.l arg_y atemp0)
    (getint arg_x)
    (move.w (atemp0 arg_x.l $v_data) arg_z)
    (mkint arg_z)))

(defun (setf x68k-u16-ref) (new bytev byte-offset)
  (lap-inline (new bytev byte-offset)
    (getint arg_z)
    (getint arg_x)
    (move.l arg_y atemp0)
    (move.w arg_x (atemp0 arg_z.l $v_data)))
  new)

(defun x68k-u8-ref (bytev byte-offset)
  (uvref bytev byte-offset))

(defun (setf x68k-u8-ref) (new bytev byte-offset)
  (setf (uvref bytev byte-offset) new))

(defun untagged-addr (addr)
  (declare (fixnum addr))
  (logand (lognot 7) addr))

(defparameter *x68k-spaces* nil)
(defparameter *x68k-image-file* nil)

(defstruct x68k-space
  (vaddr 0)
  (size (ash 1 18))
  (lowptr 0)
  (highptr (ash 1 18))
  (data nil))

; :constructor ... :constructor ... <gasp> ... must remember ... :constructor

(defun init-x68k-space (vaddr size)
  (let* ((space (make-x68k-space :vaddr vaddr
                                 :size size
                                 :highptr size
                                 :data (make-array size 
                                                   :element-type '(unsigned-byte 8)))))
    (push space *x68k-spaces*)
    space))


(defparameter *x68k-nilreg-space-address* #x10000)
(defparameter *x68k-dynamic-space-address* #x100000)
(defparameter *x68k-dynamic-space-size* (ash 1 19))
(defparameter *x68k-nil* (+ *x68k-nilreg-space-address* $t_cons))
(defparameter *x68k-T* (+ *x68k-nil* $t_val))
(defparameter *x68k-nilsym* (+ *x68k-nil* $nil_val))
(defparameter %x68k-unbound-function% (+ *x68k-dynamic-space-address* $t_cons))
(defparameter *x68k-dynamic-heap* nil)
(defparameter *x68k-nilreg-space* nil)
(defparameter *x68k-symbols* nil)
(defparameter *x68k-package-alist* nil)         ; maps real package to clone
(defparameter *x68k-aliased-package-addresses* nil)     ; cloned package to address
(defparameter *x68k-cold-load-functions* nil)
(defparameter *x68k-fcell-refs* nil)    ; function cells referenced, for warnings
(defparameter *x68k-vcell-refs* nil)    ; value cells, for warnings
(defparameter *x68k-loading-file-source-file* nil)

(defun x68k-lookup-symbol (sym)
  (gethash (%symbol->symptr sym) *x68k-symbols*))

(defun (setf x68k-lookup-symbol) (addr sym)
  (setf (gethash (%symbol->symptr sym) *x68k-symbols*) addr))

(defun x68k-lookup-address (address)
  (declare (fixnum address))
  (dolist (space *x68k-spaces* (error "Address #x~8,'0x not found in defined address spaces ." address))
    (let* ((vaddr (x68k-space-vaddr space)))
      (declare (fixnum vaddr))
      (if (and (<= vaddr address)
               (< address (the fixnum (+ vaddr (the fixnum (x68k-space-size space))))))
        (return (values (x68k-space-data space) (the fixnum (- address vaddr))))))))

(defun x68k-u32-at-address (address)
  (multiple-value-bind (v o) (x68k-lookup-address address)
    (x68k-u32-ref v o)))

(defun (setf x68k-u32-at-address) (new address)
  (multiple-value-bind (v o) (x68k-lookup-address address)
    (setf (x68k-u32-ref v o) new)))

(defun x68k-u16-at-address (address)
  (multiple-value-bind (v o) (x68k-lookup-address address)
    (x68k-u16-ref v o)))

(defun (setf x68k-u16-at-address) (new address)
  (multiple-value-bind (v o) (x68k-lookup-address address)
    (setf (x68k-u16-ref v o) new)))

(defun x68k-u8-at-address (address)
  (multiple-value-bind (v o) (x68k-lookup-address address)
    (x68k-u8-ref v o)))

(defun (setf x68k-u8-at-address) (new address)
  (multiple-value-bind (v o) (x68k-lookup-address address)
    (setf (x68k-u8-ref v o) new)))


(defun x68k-immval (imm)
  (if (typep imm 'fixnum)
    (ash imm $fixnumshift)
    (%address-of imm)))

(defun x68k-more-space (space)
  (error "Left as an exercise - ~s" space))

(defun x68k-alloc-gspace (space tag nbytes)
  (declare (fixnum tag nbytes))
  (setq nbytes (logand (lognot 7) (the fixnum (+ nbytes 7))))
  (let* ((gfree (x68k-space-lowptr space)))
    (declare (fixnum gfree))
    (if (> nbytes (the fixnum (- (the fixnum (x68k-space-highptr space)) gfree)))
      (x68k-more-space space))
    (setf (x68k-space-lowptr space) (the fixnum (+ gfree nbytes)))
    (let* ((offset (+ gfree tag)))
      (declare (fixnum offset))
      (values 
       (the fixnum (+ (the fixnum (x68k-space-vaddr space)) offset))
       (x68k-space-data space)
       offset))))

(defun x68k-make-cons (space car cdr)
  (multiple-value-bind (cell-addr data offset) (x68k-alloc-gspace space $t_cons 8)
    (declare (fixnum cell-addr offset))
    (setf (x68k-u32-ref data (the fixnum (+ offset $_car))) car)
    (setf (x68k-u32-ref data (the fixnum (+ offset $_cdr))) cdr)
    cell-addr))

(defun x68k-make-gvector (space subtype len)
  (declare (fixnum subtype len))
  (multiple-value-bind (cell-addr data offset) (x68k-alloc-gspace space $t_vector (* 4 (1+ len)))
    (declare (fixnum cell-addr offset))
    (let* ((ncells (logior 1 len)))     ; round up to odd number
      (declare (fixnum ncells))
      (do* ((val (logior (ash subtype $header-subtype-shift)  $header-nibble (ash (ash len 2) $header-vector-length-shift)) *x68k-nil*)
            (i 0 (1+ i))
            (p (+ offset $vec.header) (+ p 4)))
           ((> i ncells) cell-addr)
        (declare (fixnum i p))
        (setf (x68k-u32-ref data p) val)))))

(defun x68k-package->addr (p)
  (or (cdr (assq (or (cdr (assq p *x68k-package-alist*)) 
                     (error "Package ~s not cloned ." p))
                 *x68k-aliased-package-addresses*))
      (error "Cloned package ~s: no assigned address . " p)))

(defun x68k-addr->package (a)
  (or (car (rassoc (or (car (rassoc a *x68k-aliased-package-addresses* :test #'eq))
                       (error "Address ~d: no cloned package ." a))
                   *x68k-package-alist*))
      (error "Package at address ~d not cloned ." a)))

(defun x68k-make-symbol (space pname-address &optional (package-address *x68k-nil*))
  (let* ((cell-addr (x68k-alloc-gspace space $t_symbol $sym_size)))
    (multiple-value-bind (data offset) (x68k-lookup-address cell-addr)
      (declare (fixnum offset))
      (setf (x68k-u32-ref data (- offset $t_symbol)) $symbol-header)
      (setf (x68k-u16-ref data (+ offset $sym.bits)) 0)
      (setf (x68k-u32-ref data (+ offset $sym.pname)) pname-address)
      (setf (x68k-u32-ref data (+ offset $sym.gvalue)) (x68k-immval (%unbound-marker-8)))
      (setf (x68k-u32-ref data (+ offset $sym.package-plist)) package-address)
      (setf (x68k-u16-ref data (+ offset $sym.fapply)) $jsr_absl)
      (setf (x68k-u32-ref data (+ offset $sym.entrypt)) %x68k-unbound-function%)
      ;(break "Made symbol at #x~x (#x~x)" cell-addr offset)
      cell-addr)))

; No importing or shadowing can (easily) happen during the cold load; a symbol is present
; in no package other than its home package.
; This -just- finds or adds the symbol in the "clone" package's itab/etab.
; Somebody else has to copy the symbol to the image ...
(defun x68k-intern (symbol)
  (let* ((pname (symbol-name symbol))
         (namelen (length pname))
         (package (symbol-package symbol))
         (clone (cdr (assq package *x68k-package-alist*))))
    (unless (nth-value 1 (%find-package-symbol pname clone namelen))    ; already there
      (without-interrupts
       (let* ((htab (if (%get-htab-symbol pname namelen (pkg.etab package)) 
                      (pkg.etab clone) 
                      (pkg.itab clone))))
         (%htab-add-symbol symbol htab (nth-value 2 (%get-htab-symbol pname namelen htab))))))
    t))
     
    
(defun x68k-alloc-ispace (space tag nbytes)
  (declare (fixnum tag nbytes))
  (setq nbytes (logand (lognot 7) (the fixnum (+ nbytes 7))))
  (let* ((ifree (x68k-space-highptr space)))
    (declare (fixnum ifree))
    (if (> nbytes (the fixnum (- ifree (the fixnum (x68k-space-lowptr space)))))
      (x68k-more-space space))
    (setf (x68k-space-highptr space) (the fixnum (- ifree nbytes)))
    (let* ((offset (+ (the fixnum (x68k-space-highptr space)) tag)))
      (declare (fixnum offset))
      (values (the fixnum (+ (the fixnum (x68k-space-vaddr space)) offset))
              (x68k-space-data space)
              offset))))

(defun x68k-make-dfloat (space high low)
  (multiple-value-bind (dfloat-addr v o) (x68k-alloc-ispace space $t_dfloat 8)
    (declare (fixnum dfloat-addr o))
    (setf (x68k-u32-ref v (the fixnum (+ o $floathi))) high)
    (setf (x68k-u32-ref v (the fixnum (+ o (+ 4 $floathi)))) low)
    (if (= $header-nibble (the fixnum (logand high $header-nibble-mask)))
      (let* ((guard-addr (x68k-alloc-ispace space 0 8)))
        (declare (fixnum guard-addr))
        (setf (x68k-u32-at-address guard-addr) #x7fffffff)   ; $header-dfloat-guard
        (setf (x68k-u32-at-address (the fixnum (+ 4 guard-addr))) #x7fffffff)))
    dfloat-addr))
        
(defun x68k-make-ivector (space subtype nbytes)
  (declare (fixnum subtype nbytes))
  (let* ((addr (x68k-alloc-ispace space $t_vector (the fixnum (+ nbytes 4)))))
    (declare (fixnum addr))
    (setf (x68k-u32-at-address (the fixnum (- addr $t_vector)))
          (logior $header-nibble 
                  (ash subtype $header-subtype-shift) 
                  (the fixnum (ash nbytes $header-vector-length-shift))))
    addr))


(defun x68k-%svref (addr i)
  (declare (fixnum addr i))
  (if (= (the fixnum (logand addr $typemask)) $t_vector)
    (multiple-value-bind (v offset) (x68k-lookup-address addr)
      (declare (fixnum offset))
      (x68k-u32-ref v (the fixnum (+ offset (the fixnum (+ $v_data (the fixnum (ash i 2))))))))
    (error "Not a vector: #x~x" addr)))

(defun (setf x68k-%svref) (new addr i)
  (declare (fixnum addr i))
  (if (= (the fixnum (logand addr $typemask)) $t_vector)
    (multiple-value-bind (v offset) (x68k-lookup-address addr)
      (declare (fixnum offset))
      (setf (x68k-u32-ref v (the fixnum (+ offset (the fixnum (+ $v_data (the fixnum (ash i 2))))))) new))
    (error "Not a vector: #x~x" addr)))

(defun x68k-car (addr)
  (declare (fixnum addr))
  (if (= (the fixnum (logand addr $typemask)) $t_cons)
    (multiple-value-bind (v offset) (x68k-lookup-address addr)
      (declare (fixnum offset))
      (x68k-u32-ref v (the fixnum (+ offset $_car))))
    (error "Not a list: #x~x" addr)))

(defun (setf x68k-car) (new addr)
  (declare (fixnum addr))
  (if (= (the fixnum (logand addr $typemask)) $t_cons)
    (multiple-value-bind (v offset) (x68k-lookup-address addr)
      (declare (fixnum offset))
      (setf (x68k-u32-ref v (the fixnum (+ offset $_car))) new))
    (error "Not a list: #x~x" addr)))

(defun x68k-cdr (addr)
  (declare (fixnum addr))
  (if (= (the fixnum (logand addr $typemask)) $t_cons)
    (multiple-value-bind (v offset) (x68k-lookup-address addr)
      (declare (fixnum offset))
      (x68k-u32-ref v (the fixnum (+ offset $_cdr))))
    (error "Not a list: #x~x" addr)))

(defun (setf x68k-cdr) (new addr)
  (declare (fixnum addr))
  (if (= (the fixnum (logand addr $typemask)) $t_cons)
    (multiple-value-bind (v offset) (x68k-lookup-address addr)
      (declare (fixnum offset))
      (setf (x68k-u32-ref v (the fixnum (+ offset $_cdr))) new))
    (error "Not a list: #x~x" addr)))

(defun x68k-list-length (addr)
  (if (= addr *x68k-nil*)
    0
    (1+ (x68k-list-length (x68k-cdr addr)))))

(defun x68k-symbol-value (addr)
  (declare (fixnum addr))
  (if (= (the fixnum (logand addr $typemask)) $t_symbol)
    (multiple-value-bind (v offset) (x68k-lookup-address addr)
      (declare (fixnum offset))
      (x68k-u32-ref v (the fixnum (+ offset $sym.gvalue))))
    (error "Not a symbol: #x~x" addr)))
  
(defun x68k-symbol-name (addr)
  (declare (fixnum addr))
  (if (= addr *x68k-nil*) (incf addr $nil_val))
  (if (= (the fixnum (logand addr $typemask)) $t_symbol)
    (multiple-value-bind (v offset) (x68k-lookup-address addr)
      (declare (fixnum offset))
      (x68k-u32-ref v (the fixnum (+ offset $sym.pname))))
    (error "Not a symbol: #x~x" addr)))

(defun (setf x68k-symbol-value) (new addr)
  (if (= (the fixnum (logand addr $typemask)) $t_symbol)
    (multiple-value-bind (v offset) (x68k-lookup-address addr)
      (declare (fixnum offset))
      (setf (x68k-u32-ref v (the fixnum (+ offset $sym.gvalue))) new))
    (error "Not a symbol: #x~x" addr)))

(defun x68k-set (sym val)
  (check-type sym symbol)
  (check-type val integer)
  (let* ((symaddr (x68k-lookup-symbol sym)))
    (unless symaddr (error "Symbol address not found: ~s ." sym))
    (setf (x68k-symbol-value symaddr) val)))

(defun x68k-fset (addr def)
  (if (= (the fixnum (logand addr $typemask)) $t_symbol)
    (multiple-value-bind (v offset) (x68k-lookup-address addr)
      (declare (fixnum offset))
      (setf (x68k-u16-ref v (the fixnum (+ offset $sym.fapply)))
            (if (= $t_lfun (the fixnum (logand def $typemask)))
              $jmp_absl
              $jsr_absl))
      (setf (x68k-u32-ref v (the fixnum (+ offset $sym.entrypt))) def))
    (error "Not a symbol: #x~x" addr)))

(defun x68k-symbol-plist (addr)
  (let* ((plist-addr (+ addr $sym.package-plist))
         (package-plist (x68k-u32-at-address plist-addr)))
    (declare (fixnum plist-addr package-plist))
    (if (and (not (= package-plist *x68k-nil*))
             (= $t_cons (the fixnum (logand package-plist $typemask))))
      (x68k-cdr package-plist)
      *x68k-nil*)))

(defun (setf x68k-symbol-plist) (new addr)
  (declare (fixnum new addr))
  (let* ((plist-addr (+ addr $sym.package-plist))
         (package-plist (x68k-u32-at-address plist-addr)))
    (declare (fixnum plist-addr package-plist))
    (if (and (not (= package-plist *x68k-nil*))
             (= $t_cons (the fixnum (logand package-plist $typemask))))
      (warn "Symbol at #x~x  (~s) : plist already set." addr (x68k-get-string (x68k-symbol-name addr)) )
      (setf (x68k-u32-at-address plist-addr)
            (x68k-make-cons *x68k-dynamic-heap* package-plist new)))
    new))
      
  
; This handles constants set to themselves.
; Unless PRESERVE-CONSTANTNESS is true, the symbol's $sym_vbit_const bit is cleared.
;  (This is done because the kernel tries to call EQUALP if constants are "redefined", and
;   EQUALP may not be defined early enough.)
(defun x68k-copy-symbol (symbol &optional (space *x68k-dynamic-heap*) (preserve-constantness (keywordp symbol)))
  (or (x68k-lookup-symbol symbol)
      (let* ((pname (symbol-name symbol))
             (home-package (symbol-package symbol))
             (addr (x68k-make-symbol space
                                     (x68k-save-string pname nil (length pname))
                                     (if home-package 
                                       (x68k-package->addr home-package)
                                       *x68k-nil*))))
        (declare (fixnum addr))
        (x68k-intern symbol)
        (let* ((bits (logandc2 (%symbol-bits symbol) (ash 1 $sym_vbit_typeppred))))
          (setf (x68k-u16-at-address (the fixnum (+ addr $sym.bits))) 
                (if preserve-constantness
                  bits
                  (logand (lognot (ash 1 $sym_vbit_const)) bits))))
        (if (and (constantp symbol)
                 (eq (symbol-value symbol) symbol))
          (setf (x68k-symbol-value addr) addr))
        (setf (x68k-lookup-symbol symbol) addr))))



; Write a list to dynamic space.  No detection of circularity or structure sharing.
; The cdr of the final cons can be nil (treated as *x68k-nil*.)
; All cars must be addresses.

(defun x68k-save-list (l)
  (if (atom l)
    (or l *x68k-nil*)
    (x68k-make-cons *x68k-dynamic-heap* (car l) (x68k-save-list (cdr l)))))

(defun x68k-save-string (str &optional extended-p (n (length str)))
  (declare (fixnum n))
  (let* ((subtype (if extended-p $v_xstr $v_sstr))
         (addr (x68k-make-ivector
                *x68k-dynamic-heap* 
                subtype 
                (if extended-p (the fixnum (ash n 1)) n))))
    (declare (fixnum subtype))
    (multiple-value-bind (v offset) (x68k-lookup-address addr)
      (if extended-p
        (do* ((p (+ offset $v_data) (+ 2 p))
              (i 0 (1+ i)))
             ((= i n) str)
          (declare (fixnum i n p))
          (setf (x68k-u16-ref v p) (char-code (schar str i))))
        (do* ((p (+ offset $v_data) (1+ p))
              (i 0 (1+ i)))
             ((= i n) str)
          (declare (fixnum i p))
          (setf (x68k-u8-ref v p) (char-code (schar str i)))))
        addr)))

; Read a string from fasl file, save it to dynamic-space.
(defun %x68k-fasl-readstr (s extended-p)
  (multiple-value-bind (str n new-p) (%fasl-readstr s extended-p)
    (declare (fixnum n subtype))
    (values (x68k-save-string str extended-p n) str n new-p)))


(defun x68k-clone-packages (packages)
  (let* ((alist (mapcar #'(lambda (p)
                            (cons p
                                  (%gvector $v_pkg 
                                            (cons (make-array (length (car (uvref p 0)))) (cons 0 (cddr (uvref p 0))))   ; itab
                                            (cons (make-array (length (car (uvref p 1)))) (cons 0 (cddr (uvref p 1))))   ; etab
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
(defun x68k-assign-aliased-package-addresses (alist)
  (let* ((addr-alist (mapcar #'(lambda (pair)
                                 (let* ((p (cdr pair))
                                        (v (x68k-make-gvector *x68k-dynamic-heap* $v_pkg (uvsize p))))
                                   (setf (x68k-%svref v pkg.names)
                                         (x68k-save-list (mapcar #'(lambda (n) (x68k-save-string n))
                                                                 (pkg.names p))))
                                   (cons p v)))
                             alist)))
    (flet ((clone->addr (clone)
             (or (cdr (assq clone addr-alist)) (error "cloned package ~S not found ." clone))))
      (dolist (pair addr-alist addr-alist)
        (let* ((p (car pair))
               (v (cdr pair)))
          (setf (x68k-%svref v pkg.used)
                (x68k-save-list (mapcar #'clone->addr (pkg.used p)))
                (x68k-%svref v pkg.used-by)
                (x68k-save-list (mapcar #'clone->addr (pkg.used-by p)))))))))


(defun x68k-init-spaces (nrs)
  (dolist (sym nrs)
    (let* ((pname (symbol-name sym)))
      (setf (x68k-lookup-symbol sym) 
            (x68k-make-symbol *x68k-dynamic-heap* (x68k-save-string pname nil (length pname)))))))


; Nilreg-relative symbols.

(defparameter *x68k-nrs* '(t (nil) %err-disp cmain eval apply-evaluated-function error
                           %defun %defvar %defconstant %macro %kernel-restart
                           *package* *interrupt-level* :allow-other-keys %toplevel-catch%
                           %toplevel-function% (%pascal-functions%) (*all-metered-functions*)
                           (*%dynvfp%* . 0) (*%dynvlimit%* . 0) %unbound-function% *foreground*
                           (*background-sleep-ticks*) (*foreground-sleep-ticks*) (*window-update-wptr*)
                           *gc-event-status-bits* (*pre-gc-hook*) (*post-gc-hook*) (%handlers%)
                           %parse-string% %all-packages% *keyword-package* (%saved-method-var%)
                           (%finalization-alist%) (*current-stack-group*)))

(defun xfasload (pathnames)
  (dolist (path pathnames)
    (multiple-value-bind (*load-pathname* *load-truename* source-file) (find-load-file (merge-pathnames path))
      (unless *load-truename*
        (return (signal-file-error $err-no-file path)))
      (setq path *load-truename*)
      (unless (eq (mac-file-type path) :fasl)
        (error "~S is not a FASL file ." path))
      (let* ((*readtable* *readtable*)
             (*package* *ccl-package*)   ; maybe just *package*
             (*loading-files* (cons path *loading-files*))
             (*x68k-loading-file-source-file* nil)
             (*loading-file-source-file* (namestring source-file)))
        (when *load-verbose*
            (format t "~&;Loading ~S..." *load-pathname*)
            (force-output))
        (multiple-value-bind (winp err) (%fasload (mac-namestring path) *x68k-fasl-dispatch-table*)
          (if (not winp) (%err-disp err)))))))

(defun x68k-check-symbols ()
  (maphash #'(lambda (sym addr)
               (unless (evenp (x68k-list-length (x68k-symbol-plist addr)))
                 (error "Bad symbol-plist: ~s" sym))
               (let* ((pname (x68k-u32-at-address (+ addr (if sym $sym.pname
                                                              (+ $sym.pname
                                                                 $nil_val))))))
                 (declare (fixnum pname))
                 (unless (= $t_vector (the fixnum (logand pname $typemask)))
                   (error " bad tag on symbol pname ~s." sym))
                 (let* ((pname-header (x68k-u32-at-address (- pname $t_vector))))
                   (declare (fixnum pname-header))
                   (unless (and (= (logand $header-nibble-mask pname-header) $header-nibble)
                                (= $v_sstr (logand (1- (ash 1 $v_bits)) (ash pname-header (- $header-subtype-shift)))))
                     (error " bad header on symbol pname ~s." sym))))
               (let* ((pkg (symbol-package sym)))
                 (when pkg
                   (let* ((alias (cdr (assq pkg *x68k-package-alist*))))
                     (unless alias (error "No package alias for ~s ." pkg))
                     (unless (nth-value 1 (%find-package-symbol (symbol-name sym) alias))
                       (error "~S not present in aliased package." sym))
                     (let* ((sym-pkg (x68k-u32-at-address (+ addr (if sym $sym.package-plist
                                                                      (+ $sym.package-plist
                                                                         $nil_val))))))
                       (declare (fixnum sym-pkg))
                       (if (and (not (= *x68k-nil* sym-pkg))
                                (= $t_cons (the fixnum (logand sym-pkg $typemask))))
                         (setq sym-pkg (x68k-car sym-pkg)))
                       (unless (= sym-pkg (cdr (assq alias *x68k-aliased-package-addresses*)))
                         (if (= sym-pkg *x68k-nil*)
                           (error "symbol home package not set in image: ~s." sym)
                           (error "~s : in wrong home package." sym))))))))
           *x68k-symbols*))

; Should do something to give this a boost ...
(defun x68k-write-byte-vector (stream v start n)
  (declare (fixnum start n))
  (declare (type (simple-array (unsigned-byte 8) (*)) v))
  (declare (optimize (speed 3) (safety 0)))
  (do* ((i 0 (1+ i))
        (p start (1+ p)))
       ((= i n) n)
    (declare (fixnum i p))
    (write-byte (aref v p) stream)))

(defun x68k-dump-image (image-name)
  (with-open-file (*x68k-image-file* image-name
                                     :direction :output
                                     :if-does-not-exist :create
                                     :if-exists :supersede
                                     :element-type '(unsigned-byte 8))
    (let* ((header (make-record (:dumpheader :clear t)))
           (headerpos 18))
      (dotimes (i headerpos) (write-byte 0 *x68k-image-file*))         ; leave space for file header
      (rset header :dumpheader.d_version -1)  ;(%get-long (%currentA5) $verslong))
      (rset header :dumpheader.d_flags 1)   ; (ash 1 $d_swap_image)
      (rset header :dumpheader.d_gspace_start (x68k-space-vaddr *x68k-dynamic-heap*))
      (rset header :dumpheader.d_gspace_end (+ (x68k-space-vaddr *x68k-dynamic-heap*)
                                               (x68k-space-lowptr *x68k-dynamic-heap*)))
      (rset header :dumpheader.d_ispace_start (+ (x68k-space-vaddr *x68k-dynamic-heap*)
                                                 (x68k-space-highptr *x68k-dynamic-heap*)))
      (rset header :dumpheader.d_ispace_end (+ (x68k-space-vaddr *x68k-dynamic-heap*)
                                               (x68k-space-size *x68k-dynamic-heap*)))
      (rset header :dumpheader.d_nil *x68k-nil*)
      ; For no good reason, T and NILSYM aren't considered nilreg-relative-symbols.
      (rset header :dumpheader.d_nrs_start (+ *x68k-nil* (- (+ $sym_size $nil_val) $t_symbol)))
      (rset header :dumpheader.d_nrs_end (+ (+ *x68k-nil* (- (+ $sym_size $nil_val) $t_symbol)) (* $sym_size (length (cddr *x68k-nrs*)))))
 
      (rset header :dumpheader.d_fappunb %x68k-unbound-function%)
      (with-macptrs ((p (%inc-ptr header (get-field-offset :dumpheader.d_t))))
        (do* ((v (x68k-space-data *x68k-nilreg-space*))
              (i 0 (1+ i))
              (j (- (+ $t_cons $t_val) $t_symbol) (1+ j)))
             ((= i (* 2 $sym_size)))
          (declare (fixnum i j))
          (setf (%get-byte p i) (aref v j))))

      (dotimes (i (record-length :dumpheader)) (write-byte 0 *x68k-image-file*))
      (let* ((ispace-pos (file-position *x68k-image-file*))
             (heap-data (x68k-space-data *x68k-dynamic-heap*)))
        (x68k-write-byte-vector *x68k-image-file* 
                                heap-data 
                                (x68k-space-highptr *x68k-dynamic-heap*) 
                                (- (x68k-space-size *x68k-dynamic-heap*)
                                   (x68k-space-highptr *x68k-dynamic-heap*)))
         (let* ((gspace-pos (file-position *x68k-image-file*)))
           (x68k-write-byte-vector *x68k-image-file* heap-data 0 (x68k-space-lowptr *x68k-dynamic-heap*))
           (let* ((nrs-pos (file-position *x68k-image-file*)))
             (x68k-write-byte-vector *x68k-image-file* 
                                     (x68k-space-data *x68k-nilreg-space*)
                                     (+ 8 (* 2 $sym_size))      ; skip nil, t, nilsym
                                     (- (x68k-space-lowptr *x68k-nilreg-space*)
                                        (+ 8 (* 2 $sym_size))))
             (rset header :dumpheader.d_nrsfilepos nrs-pos)
; This is obsolete.
             (rset header :dumpheader.d_vcellfilepos nrs-pos)
             (rset header :dumpheader.d_fcellfilepos nrs-pos)
             (rset header :dumpheader.d_vcells_start (+ *x68k-nil* -4))
             (rset header :dumpheader.d_vcells_end (+ *x68k-nil* -4))
             (rset header :dumpheader.d_fcells_start (+ (- (%get-long (%currentA5) $fcells_start) (%address-of nil)) 
                                                        *x68k-nil*))
             (rset header :dumpheader.d_fcells_end (+ (- (%get-long (%currentA5) $fcells_start) (%address-of nil)) 
                                                      *x68k-nil*))
; This isn't.
             (rset header :dumpheader.d_gfilelen (- nrs-pos gspace-pos))
             (rset header :dumpheader.d_gfilepos gspace-pos)
             (rset header :dumpheader.d_ifilelen (- gspace-pos ispace-pos))
             (rset header :dumpheader.d_ifilepos ispace-pos))))
      (file-position *x68k-image-file* headerpos)
      (dotimes (i (record-length :dumpheader))
        (write-byte (%get-byte header i) *x68k-image-file*))
      (file-position *x68k-image-file* 0)
      (let* ((fileheader (make-array headerpos :element-type '(unsigned-byte 8))))
        (setf (x68k-u32-ref fileheader 0) #xABBADABB)
        (setf (x68k-u16-ref fileheader 4) #xAD00)
        (setf (x68k-u32-ref fileheader 6) (- (rref header :dumpheader.d_vcells_end) (rref header :dumpheader.d_vcells_start)))
        (setf (x68k-u32-ref fileheader 10) (- (rref header :dumpheader.d_nrs_end) (rref header :dumpheader.d_fcells_start)))
        (setf (x68k-u32-ref fileheader 14) headerpos)
        (dotimes (i headerpos) (write-byte (aref fileheader i) *x68k-image-file*))))))

(defun x68k-save-htab (htab)
  (let* ((htvec (car htab))
         (len (length htvec))
         (xvec (x68k-make-gvector *x68k-dynamic-heap* $v_genv len))
         (deleted-marker $undefined))
    (dotimes (i len)
      (let* ((s (%svref htvec i)))
        (setf (x68k-%svref xvec i)
              (if s
                (if (symbolp s) (x68k-lookup-symbol s) deleted-marker)
                *x68k-nil*))))
    (x68k-make-cons 
     *x68k-dynamic-heap* 
     xvec 
     (x68k-make-cons
      *x68k-dynamic-heap*
      (x68k-immval (cadr htab))
      (x68k-immval (cddr htab))))))

(defun x68k-finalize-packages ()
  (dolist (pair *x68k-aliased-package-addresses*)
    (let* ((p (car pair))
           (q (cdr pair)))
      (setf (x68k-%svref q pkg.etab) (x68k-save-htab (pkg.etab p)))
      (setf (x68k-%svref q pkg.itab) (x68k-save-htab (pkg.itab p))))))

(defun x68k-get-string (address)
    (multiple-value-bind (v o) (x68k-lookup-address address)
      (let* ((header (x68k-u32-ref v (+ o $vec.header)))
             (len (ash header (- $header-vector-length-shift)))
             (str (make-string len :element-type 'base-character))
             (p (+ o $v_data)))
        (dotimes (i len str)
          (setf (schar str i) (code-char (x68k-u8-ref v (+ p i))))))))

(defun x68k-note-undefined-references ()
  (let* ((unbound-vcells nil)
         (undefined-fcells nil))
    (dolist (vcell *x68k-vcell-refs*)
      (declare (fixnum vcell))
      (when (= (the fixnum (x68k-u32-at-address (the fixnum (+ vcell $sym.gvalue))))
               $undefined)
        (push vcell unbound-vcells)))
    (dolist (fcell *x68k-fcell-refs*)
      (declare (fixnum fcell))
      (when (= (the fixnum (x68k-u32-at-address (the fixnum (+ fcell $sym.entrypt))))
               %x68k-unbound-function%)
        (push fcell undefined-fcells)))
    (flet ((x68k-symbol-name-string (addr) (x68k-get-string (x68k-symbol-name addr))))
      (when undefined-fcells
        (warn "Function names referenced but not defined: ~a" (mapcar #'x68k-symbol-name-string undefined-fcells)))
      (when unbound-vcells
        (warn "Variable names referenced but not defined: ~a" (mapcar #'x68k-symbol-name-string unbound-vcells))))))
  
(defun x68kload (output-file &rest pathnames)
  (let* ((*x68k-symbols* (make-hash-table :test #'eq))
         (*x68k-spaces* nil)
         (*x68k-nilreg-space* (init-x68k-space *x68k-nilreg-space-address*
                                        (+ 8    ; cons: *x68k-nil*
                                           (* $sym_size (length *x68k-nrs*)))))
         (*x68k-dynamic-heap* (init-x68k-space *x68k-dynamic-space-address* *x68k-dynamic-space-size*))
         (*x68k-package-alist* (x68k-clone-packages %all-packages%))
         (*x68k-cold-load-functions* nil)
         (*x68k-loading-file-source-file* nil)
         (*x68k-vcell-refs* nil)
         (*x68k-fcell-refs* nil)
         (*x68k-aliased-package-addresses* nil))
    ; Make NIL.
    (x68k-make-cons *x68k-nilreg-space* *x68k-nil* *x68k-nil*)
    ; %unbound-function% happens to be the first thing in the dynamic heap.
    (x68k-make-cons *x68k-dynamic-heap* (x68k-immval (car %unbound-function%)) *x68k-nil*)
    (setq *x68k-aliased-package-addresses* (x68k-assign-aliased-package-addresses *x68k-package-alist*))
    (dolist (pair *x68k-nrs*)
      (let* ((val-p (consp pair))
             (val (if val-p (or (cdr pair) *x68k-nil*)))
             (sym (if val-p (car pair) pair)))
        (x68k-copy-symbol sym *x68k-nilreg-space* t)
        (when val-p (x68k-set sym val))))
    ; This could be a little less ... procedural.
    (x68k-set '*package* (x68k-package->addr *ccl-package*))
    (x68k-set '*keyword-package* (x68k-package->addr *keyword-package*))
    (x68k-set '*interrupt-level* (x68k-immval -1))
    (x68k-set '%all-packages% (x68k-save-list (mapcar #'cdr *x68k-aliased-package-addresses*)))
    (x68k-set '%unbound-function% %x68k-unbound-function%)
    (x68k-set '%parse-string% (x68k-make-ivector *x68k-dynamic-heap* $v_sstr 255))
    (x68k-set '*gc-event-status-bits* (x68k-immval (logand (lognot 3) *gc-event-status-bits*)))
    (x68k-set '*foreground* (x68k-lookup-symbol t))
    (x68k-set '%toplevel-catch% (x68k-copy-symbol :toplevel))
    (xfasload pathnames)
    (x68k-check-symbols)                ; Make sure interned symbols are.
    (when (= (x68k-symbol-value (x68k-lookup-symbol '%toplevel-function%))
             $undefined)
      (warn "~S not set in loading ~S ." '%toplevel-function pathnames))
    (setf (x68k-symbol-value (x68k-copy-symbol '*x68k-cold-load-functions*))
          (x68k-save-list (setq *x68k-cold-load-functions*
                                (nreverse *x68k-cold-load-functions*))))
    (x68k-note-undefined-references)
    (x68k-finalize-packages)
    (x68k-dump-image output-file)))



;;; The xloader

(x68k-copy-faslop $fasl-noop)
(x68k-copy-faslop $fasl-etab-alloc)
(x68k-copy-faslop $fasl-eref)

; Should error if epush bit set, else push on *68k-cold-load-functions* or something.
(defx68kfaslop $fasl-lfuncall (s)
  (let* ((fun (%fasl-expr-preserve-epush s)))
    (when (faslstate.faslepush s)
      (error "Can't call function for value : ~s" fun))
    (push fun *x68k-cold-load-functions*)))

(x68k-copy-faslop $fasl-globals)        ; what the hell did this ever do ?

; fasl-char: maybe epush, return 32-bit representation of BASE-CHARACTER

(defx68kfaslop $fasl-char (s)
  (%epushval s (x68k-immval (code-char (%fasl-read-byte s)))))

(defx68kfaslop $fasl-fixnum (s)
  (%epushval s (x68k-immval (lap-inline ((%fasl-read-long s))
                 (jsr_subprim $sp-getXlong)
                 (mkint acc)))))

(defx68kfaslop $fasl-float (s)
  (%epushval s (x68k-make-dfloat *x68k-dynamic-heap* (%fasl-read-long s) (%fasl-read-long s))))

(defx68kfaslop $fasl-str (s)
  (let* ((n (%fasl-read-size s))
         (str (x68k-make-ivector *x68k-dynamic-heap* $v_sstr n)))
    (%epushval s str)
    (multiple-value-bind (v o) (x68k-lookup-address str)
      (%fasl-read-n-bytes s v (+ o  $v_data) n)
      str)))

(defx68kfaslop $fasl-word-fixnum (s)
  (%epushval s (x68k-immval (%word-to-int (%fasl-read-word s)))))

(defun %x68k-fasl-make-symbol (s extended-p)
  (declare (fixnum subtype))
  (%epushval s (x68k-make-symbol *x68k-dynamic-heap* (%x68k-fasl-readstr s extended-p))))

(defx68kfaslop $fasl-mksym (s)
  (%x68k-fasl-make-symbol s nil))

(defun %x68k-fasl-intern (s package extended-p)
  (multiple-value-bind (str len new-p) (%fasl-readstr s extended-p)
    (without-interrupts
     (multiple-value-bind (cursym access internal external) (%find-symbol str len package)
       (unless access
         (unless new-p (setq str (%fasl-copystr str len)))
         (setq cursym (%add-symbol str package internal external)))
       ; cursym now exists in the load-time world; make sure that it exists
       ; (and is properly "interned" in the world we're making as well)
       (%epushval s (x68k-copy-symbol cursym))))))

(defx68kfaslop $fasl-intern (s)
  (%x68k-fasl-intern s *package* nil))

(defx68kfaslop $fasl-pkg-intern (s)
  (let* ((addr (%fasl-expr-preserve-epush  s))
         (pkg (x68k-addr->package addr)))
    (%x68k-fasl-intern s pkg nil)))

(defun %x68k-fasl-package (s extended-p)
  (multiple-value-bind (str len new-p) (%fasl-readstr s extended-p)
    (let* ((p (%find-pkg str len)))
      (%epushval s (x68k-package->addr (or p (%kernel-restart $XNOPKG (if new-p str (%fasl-copystr str len)))))))))

(defx68kfaslop $fasl-pkg (s)
  (%x68k-fasl-package s nil))

(defx68kfaslop $fasl-cons (s)
  (let* ((cons (%epushval s (x68k-make-cons *x68k-dynamic-heap* *x68k-nil* *x68k-nil*))))
    (setf (x68k-car cons) (%fasl-expr s)
          (x68k-cdr cons) (%fasl-expr s))
    (setf (faslstate.faslval s) cons)))
    
(defun %x68k-fasl-listX (s dotp)
  (let* ((len (%fasl-read-word s)))
    (declare (fixnum len))
    (let* ((val (%epushval s (x68k-make-cons *x68k-dynamic-heap* *x68k-nil* *x68k-nil*)))
           (tail val))
      (setf (x68k-car val) (%fasl-expr s))
      (dotimes (i len)
        (setf (x68k-cdr tail) (setq tail (x68k-make-cons *x68k-dynamic-heap* (%fasl-expr s) *x68k-nil*))))
      (if dotp
        (setf (x68k-cdr tail) (%fasl-expr s)))
      (setf (faslstate.faslval s) val))))

(defx68kfaslop $fasl-list (s)
  (%x68k-fasl-listX s nil))

(defx68kfaslop $fasl-list* (s)
  (%x68k-fasl-listX s t))

(defx68kfaslop $fasl-nil (s)
  (%epushval s *x68k-nil*))

(defx68kfaslop $fasl-timm (s)
  (let* ((val (%fasl-read-long s)))
    #+paranoid (unless (= (logand $typemask val) $t_imm) 
                 (error "Bug: expected immediate-tagged object, got ~s ." val))
    (%epushval s val)))

(defun %x68k-lfv-lfun (s lfv)
  (%epushval s (+ lfv $lfv_lfun)))

(defx68kfaslop $fasl-lfun (s)
  (%x68k-lfv-lfun s (%fasl-expr-preserve-epush s)))

(defx68kfaslop $fasl-eref-lfun (s)
  (%x68k-lfv-lfun s (svref (faslstate.faslevec s) (%fasl-read-word s))))

(defx68kfaslop $fasl-symfn (s)
  (let* ((symaddr (%fasl-expr-preserve-epush s)))
    (if (= $jmp_absl (the fixnum (x68k-u16-at-address (+ symaddr $sym.fapply))))
      (%epushval s (x68k-u32-at-address (+ symaddr $sym.entrypt)))
      (error "symbol at #x~x is unfbound . " symaddr))))

(defx68kfaslop $fasl-eval (s)
  (let* ((expr (%fasl-expr-preserve-epush s)))
    (error "Can't evaluate expression ~s in cold load ." expr)
    (%epushval s (eval expr))))         ; could maybe evaluate symbols, constants ...

(defx68kfaslop $fasl-ivec (s)
  (let* ((subtype (%fasl-read-byte s))
         (size-in-bytes (%fasl-read-size s))
         (vector (x68k-make-ivector *x68k-dynamic-heap* subtype size-in-bytes)))
    (%epushval s vector)
    (multiple-value-bind (v o) (x68k-lookup-address vector)
      (%fasl-read-n-bytes s v (+ o  $v_data) size-in-bytes)
      vector)))

(defx68kfaslop $fasl-gvec (s)
  (let* ((subtype (%fasl-read-byte s))
         (n (%fasl-read-size s))
         (vector (x68k-make-gvector *x68k-dynamic-heap* subtype n)))
    (declare (fixnum n))
    (%epushval s vector)
    (dotimes (i n (setf (faslstate.faslval s) vector))
      (setf (x68k-%svref vector i) (%fasl-expr s)))))

(defun x68k-note-cell-ref (loc imm)
  (declare (fixnum loc imm))
  (if (= loc $sym.fapply)
    (pushnew imm *x68k-fcell-refs*)
    (if (= loc $sym.gvalue)
      (pushnew imm *x68k-vcell-refs*)))
  (the fixnum (+ loc imm)))

(defx68kfaslop $fasl-nlfvec (s)
  (let* ((size-in-bytes (%fasl-read-size s)))
    (declare (fixnum size-in-bytes))
    (multiple-value-bind (lfv vector offset) (x68k-alloc-gspace *x68k-dynamic-heap* $t_vector (the fixnum (+ size-in-bytes 4)))
      (declare (fixnum offset))
      (setf (x68k-u32-ref vector (the fixnum (+ offset $vec.header)))
            (logior (logior $header-nibble (ash $v_nlfunv $header-subtype-shift))
                    (the fixnum (ash size-in-bytes $header-vector-length-shift))))
      (%epushval s lfv)
      (let* ((lfp (+ offset $v_data)))
        (declare (fixnum lfp))
        (%fasl-read-n-bytes s vector lfp size-in-bytes)
        (let* ((attr (x68k-u16-ref vector lfp)))
          (declare (fixnum attr))
          (when (logbitp $lfatr-immmap-bit attr)
            (let* ((endptr (+ lfp (- size-in-bytes (if (logbitp $lfatr-slfunv-bit attr) (1+ 8) (1+ 4))))))
              (declare (fixnum endptr imm-byte-offset))
              (incf lfp 2)
              (loop
                (let* ((disp-byte (x68k-u8-ref vector endptr)))
                  (declare (fixnum disp-byte))
                  (when (= 0 disp-byte) (return))
                  (decf endptr)
                  (let* ((disp (if (logbitp 7 disp-byte)
                                 (logior (the fixnum (ash (the fixnum (x68k-u8-ref vector endptr)) 8))
                                         (the fixnum (logand (the fixnum (+ disp-byte disp-byte)) #xff)))
                                 (the fixnum (+ disp-byte disp-byte)))))
                    (declare (fixnum disp))
                    (if (logbitp 7 disp-byte) (decf endptr))
                    (incf lfp disp)
                    (setf (x68k-u32-ref vector lfp) (x68k-note-cell-ref (x68k-u32-ref vector lfp) (%fasl-expr s))))))))
          (setf (faslstate.faslval s) lfv))))))

(defun x68k-lfun-name (lf)
  (x68k-lfv-name (+ lf $lf_lfunv)))

(defun x68k-lfv-name (lfv)
  (multiple-value-bind (vector offset) (x68k-lookup-address lfv)
    (declare (fixnum offset))
    (let* ((header (x68k-u32-ref vector (the fixnum (+ offset $vec.header))))
           (size-in-bytes (ash header (- $header-vector-length-shift))))
      (declare (fixnum size-in-bytes))      
      (let* ((attr (x68k-u16-ref vector (the fixnum (+ offset $v_data)))))
        (declare (fixnum attr))
        (when (and (not (logbitp $lfatr-noname-bit attr))
                   (logbitp $lfatr-immmap-bit attr))
          (let* ((endptr (+ offset $v_data (- size-in-bytes (if (logbitp $lfatr-slfunv-bit attr) 8 4))))
                 (imm-byte-offset (+ offset $v_data 2)))
            (declare (fixnum endptr imm-byte-offset))
            (loop
              (let* ((disp-byte (x68k-u8-ref vector (decf endptr))))
                (declare (fixnum disp-byte))
                (when (= 0 disp-byte) (return (x68k-u32-ref vector imm-byte-offset)))
                (let* ((disp (if (logbitp 7 disp-byte)
                               (logior (the fixnum (ash (the fixnum (x68k-u8-ref vector (decf endptr))) 8))
                                       (the fixnum (logand (the fixnum (+ disp-byte disp-byte)) #xff)))
                               (the fixnum (+ disp-byte disp-byte)))))
                  (declare (fixnum disp))
                  (incf imm-byte-offset disp))))))))))
      
(defun x68k-record-source-file (symaddr indicator)
  (when (or (eq indicator 'function)
            (eq indicator 'variable))
    (let* ((keyaddr (x68k-copy-symbol 'bootstrapping-source-files))
           (pathaddr (or *x68k-loading-file-source-file*
                         (if *loading-file-source-file*
                           (setq *x68k-loading-file-source-file* (x68k-save-string *loading-file-source-file*))))))
      (when pathaddr
        (let* ((keyval (if (eq indicator 'function)
                         (x68k-make-cons *x68k-dynamic-heap* pathaddr *x68k-nil*)
                         (x68k-make-cons *x68k-dynamic-heap*
                                         (x68k-make-cons *x68k-dynamic-heap*
                                                         (x68k-make-cons *x68k-dynamic-heap* (x68k-copy-symbol indicator) pathaddr)
                                                         *x68k-nil*)
                                         *x68k-nil*))))
          (setf (x68k-symbol-plist symaddr) (x68k-make-cons *x68k-dynamic-heap* keyaddr keyval)))))))

(defx68kfaslop $fasl-xchar (s)
  (%epushval s (x68k-immval (code-char (%fasl-read-word s)))))

(defx68kfaslop $fasl-mkxsym (s)
  (%x68k-fasl-make-symbol s t))

(defx68kfaslop $fasl-defun (s)
  (%cant-epush s)
  (let* ((fun (%fasl-expr s))
         (doc (%fasl-expr s)))
    (declare (ignore doc))
    (let* ((sym (x68k-lfun-name fun)))
      (x68k-record-source-file sym 'function)
      (x68k-fset sym fun))))

(defx68kfaslop $fasl-macro (s)
  (%cant-epush s)
  (let* ((fun (%fasl-expr s))
         (doc (%fasl-expr s)))
    (declare (ignore doc))
    (let* ((sym (x68k-lfun-name fun)))
      (x68k-record-source-file sym 'function)
      (x68k-fset sym (x68k-make-cons *x68k-dynamic-heap* #x4EADDFE8 fun)))))

(defx68kfaslop $fasl-defconstant (s)
  (%cant-epush s)
  (let* ((sym (%fasl-expr s))
         (val (%fasl-expr s))
         (doc (%fasl-expr s)))
    (declare (ignore doc))              ; could push it on some vcell somewhere.
    (x68k-record-source-file sym 'variable)
    (setf (x68k-symbol-value sym) val)
    (setf (x68k-u8-at-address (+ sym $sym.vbits))
          (logior (ash 1 $sym_bit_special) 
                  (ash 1 $sym_bit_const) 
                  (x68k-u8-at-address (+ sym $sym.vbits))))))

(defx68kfaslop $fasl-defparameter (s)
  (%cant-epush s)
  (let* ((sym (%fasl-expr s))
         (val (%fasl-expr s))
         (doc (%fasl-expr s)))
    (declare (ignore doc))              ; could push it on some vcell somewhere.
    (x68k-record-source-file sym 'variable)
    (setf (x68k-symbol-value sym) val)
    (setf (x68k-u8-at-address (+ sym $sym.vbits))
          (logior (ash 1 $sym_bit_special) 
                  (x68k-u8-at-address (+ sym $sym.vbits))))))

(defx68kfaslop $fasl-defvar (s)
  (%cant-epush s)
  (let* ((sym (%fasl-expr s)))
    (x68k-record-source-file sym 'variable)
    (setf (x68k-u8-at-address (+ sym $sym.vbits))
          (logior (ash 1 $sym_bit_special) 
                  (x68k-u8-at-address (+ sym $sym.vbits))))))

(defx68kfaslop $fasl-defvar-init (s)
  (%cant-epush s)
  (let* ((sym (%fasl-expr s))
         (val (%fasl-expr s))
         (doc (%fasl-expr s)))
    (declare (ignore doc))              ; could push it on some vcell somewhere.
    (when (= $undefined (x68k-symbol-value sym))
      (setf (x68k-symbol-value sym) val))
    (x68k-record-source-file sym 'variable)
    (setf (x68k-u8-at-address (+ sym $sym.vbits))
          (logior (ash 1 $sym_bit_special) 
                  (x68k-u8-at-address (+ sym $sym.vbits))))))


(x68k-copy-faslop $fasl-skip)
(x68k-copy-faslop $fasl-prog1)

(defx68kfaslop $fasl-xintern (s)
  (%x68k-fasl-intern s *package* t))

(defx68kfaslop $fasl-pkg-xintern (s)
  (let* ((addr (%fasl-expr-preserve-epush  s))
         (pkg (x68k-addr->package addr)))
    (%x68k-fasl-intern s pkg t)))

(defx68kfaslop $fasl-xpkg (s)
  (%x68k-fasl-package s t))


(defx68kfaslop $fasl-src (s)
  (%cant-epush s)
  (let* ((path (%fasl-expr s)))
    (setq *x68k-loading-file-source-file* path)))



#|
(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))
  (load "ccl:xdump;xfasload"))

(defun compile-directory (dir &optional force)
  (dolist (src (directory (merge-pathnames dir "*.lisp")))
    (let* ((fasl (merge-pathnames  *.fasl-pathname* src)))
      (unless (and (not force)
                   (probe-file fasl)
                   (> (file-write-date fasl)
                      (file-write-date src)))
        (compile-file src :output-file fasl :verbose t)))))

(defun update-directory (dir)
  (dolist (src (directory (merge-pathnames dir "*.lisp")))
    (let* ((fasl (merge-pathnames  *.fasl-pathname* src)))
      (unless (and (probe-file fasl)
                   (> (file-write-date fasl)
                      (file-write-date src)))
        (compile-file src :output-file fasl :verbose t :load t)))))

(compile-directory "ccl:level-0;" t)
(compile-directory "ccl:level-0;68k;" t)

(compile-directory "ccl:level-0;")
(compile-directory "ccl:level-0;68k;")

(let* ((*load-verbose* t))
  (apply #'x68kload "ccl:boot" (directory "ccl:level-0;**;*.fasl")))

; One typically wants to remember to do this:
(copy-file "ccl:boot" "ccl:lisp-8"
           :fork :data
           :if-exists :supersede)

|#
