;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: nfasload.lisp,v $
;;  Revision 1.7  2006/02/03 19:54:12  alice
;;  ; all the define-l0-mumble things are now elsewhere
;;
;;  Revision 1.6  2004/01/23 20:57:29  alice
;;  lose fasl version check for the moment
;;
;;  Revision 1.5  2003/12/08 09:09:43  gtbyers
;;  Write ";;;Loading" messages to console during cold load.
;;
;;  18 1/22/97 akh  probably no change
;;  17 6/7/96  akh  couple of declare optimize
;;  12 11/15/95 slh not sure
;;  11 11/14/95 akh fix %fasload and %fasl-set-file-pos to make loading fasl-concatenated files work.
;;  7 11/1/95  akh  %fasl-copystr - dont use array-element-type - not there for ppc
;;  6 10/26/95 akh  damage control
;;  6 10/26/95 gb   in PPC version of $fasl-ivec: fix call to %ALLOC-MISC.
;;                  call %MAKE-CODE-EXECUTABLE when subtag = subtag-code-vector
;;
;;  4 10/23/95 akh  more specific about string types
;;  (do not edit before this line!!)


; Modification History

; pkg-arg accepts character - dietz tests - oops doesn't boot
; ----- 5.2b6
; all the define-l0-mumble things are now elsewhere
; ------- 5.1 final
; 01/22/04 lose fasl-version check for the moment
; 12/07/01 fix call to pbsetfpossync
; long time ago - akh use define-l0-trap-function to avoid the disastrous trap emulator
; 06.08/99 akh make pb be length of :hparamblockrec
;-------- 4.3.1b1
; 02/20/00 akh use pbhopensync vs pbopensync - gotta clear the pb too
; 01/13/99 from slh - fixes for long lists
; 05/05/97 bill  %fasload binds *pfsl-library-base* & *pfsl-library*.
;                It also takes two new optional args: start-faslops-function & stop-faslops-function
;                $fasl-library-pointer, $fasl-provide
; -------------  4.1
; 03/22/96 bill  $fasl-timm for PPC
; 03/08/96 bill  In %initialize-htab, say (eql 1 (gcd ...)) instead of (= 0 (gcd ...))
;                Compare with 1 so it terminates. Use EQL because it's faster.
; 01/04/96 bill  #_PBxxx -> #_PBxxxSync
; 12/11/95 gb    make-array :initial-element nil in %initialize-htab (Bill) .
; 11/13/95 slh   %fasload: advance pos in block-reading loop
; 11/06/95 gb    #+ppc-target remember to set %toplevel-function to nil 
; 11/06/95 bill  bootstrapping eval for new trap make-load-form output
; 10/16/95 gb    less consing; $fasl-arch; explicit element type in make-string call.

(eval-when (:compile-toplevel :execute)

(require "FASLENV" "ccl:xdump;faslenv")
(require "PPC-LAPMACROS" "ccl:compiler;ppc;ppc-lapmacros")


(defconstant $primsizes (make-array 23
                                    :element-type 'fixnum
                                    :initial-contents
                                    '(41 61 97 149 223 337 509 769 887 971 1153 1559 1733
                                      2609 2801 3917 5879 8819 13229 19843 24989 29789 32749)))
(defconstant $hprimes (make-array 8 
                                  :element-type '(unsigned-byte 16)
                                  :initial-contents '(5 7 11 13 17 19 23 29)))

; Symbol hash tables: (htvec . (hcount . hlimit))

(defmacro htvec (htab) `(%car ,htab))
(defmacro htcount (htab) `(%cadr ,htab))
(defmacro htlimit (htab) `(%cddr ,htab))
)

(defun PBGetEOFSync (pb)
  (ppc-ff-call (%kernel-import ppc::kernel-import-PBGetEOFSync)
               :address pb
               :signed-halfword))

(defun PBCloseSync (pb)
  (ppc-ff-call (%kernel-import ppc::kernel-import-PBCloseSync)
               :address pb
               :signed-halfword))

(defun PBReadSync (pb)
  (ppc-ff-call (%kernel-import ppc::kernel-import-PBReadSync)
               :address pb
               :signed-halfword))

(defun PBSetFPosSync (pb)
  (ppc-ff-call (%kernel-import ppc::kernel-import-PBSetFPosSync)
               :address pb
               :signed-halfword))

(defun PBHOpenSync (pb)
  (ppc-ff-call (%kernel-import ppc::kernel-import-PBHOpenSync)
               :address pb
               :signed-halfword))



#+ignore
(eval-when (:compile-toplevel :execute)
;; from ppc-pfsl-library
(defmacro define-l0-trap-function (trap-string &rest arg-names)
  (let* ((upcase-name (string-upcase (string trap-string)))
         (trap-function-name (intern upcase-name))
         (trap-var-name (intern (concatenate 'base-string "*" upcase-name "*")))
         (trap-name (intern (concatenate 'base-string "_" upcase-name) 'traps))
         (expansion (let ((*compile-file-truename* nil))        ; expand normally
                      (macroexpand `(require-trap ,trap-name ,@arg-names)))))
    (unless (eq (first expansion) 'ff-call-slep)
      (error "Trap call didn't expand into ff-call-slep"))
    (setf (second expansion) `(,trap-var-name))
    `(progn
       (defvar ,trap-var-name nil)
       (defun ,trap-var-name ()
         (or ,trap-var-name
             (setq ,trap-var-name (get-slep ,trap-string))))
       (defun ,trap-function-name ,arg-names ,expansion))))

)

; Can't call traps in level-0, so we make functions out of the ones we need

#+ignore ;; - all elsewhere now
(compiler-let ((*dont-use-cfm* nil))

;(define-l0-trap-function "PBSetFPosSync" pb) ;; not needed
;(define-l0-trap-function "PBReadSync" pb)
;(define-l0-trap-function "PBHOpenSync" pb)  ;; already there
;(define-l0-trap-function "PBGetEOFSync" pb) ;; already there
;(define-l0-trap-function "PBCloseSync" pb) ;; already there
) 


(eval-when (:execute :compile-toplevel)
  (assert (= 52 numfaslops)))

(defvar *fasl-dispatch-table* #52(%bad-fasl))

(defun %bad-fasl (s)
  (error "bad opcode in FASL file ~s" (faslstate.faslfname s)))

(defun %cant-epush (s)
  (if (faslstate.faslepush s)
    (%bad-fasl s)))

(defun %epushval (s val)
  (setf (faslstate.faslval s) val)
  (when (faslstate.faslepush s)
    (setf (svref (faslstate.faslevec s) (faslstate.faslecnt s)) val)
    (incf (the fixnum (faslstate.faslecnt s))))
  val)

(defun %fasl-read-buffer (s)
  (let* ((pb (faslstate.fasliopb s))
         (buffer (faslstate.iobuffer s))
         (bufptr (%get-ptr buffer)))
    (declare (dynamic-extent bufptr)
             (type macptr buffer bufptr pb))
    (%setf-macptr bufptr (%inc-ptr buffer 4))
    (setf (%get-ptr buffer) bufptr)
    (setf (%get-long pb $iobytecount) $fasl-buf-len)
    (setf (%get-ptr pb $iobuffer) bufptr)
    (setf (%get-word pb $ioPosMode) $fsatmark)
    (PBReadSync  pb)
    (if (= (the fixnum (setf (faslstate.bufcount s)
                             (%get-unsigned-long pb $ioNumDone)))
           0)
      (%err-disp (%get-signed-word pb $ioResult)))))
 
(defun %fasl-read-byte (s)
  (loop
    (let* ((buffer (faslstate.iobuffer s))
           (bufptr (%get-ptr buffer)))
      (declare (dynamic-extent bufptr)
               (type macptr buffer bufptr))
      (if (>= (the fixnum (decf (the fixnum (faslstate.bufcount s))))
              0)
        (return
         (prog1
           (%get-unsigned-byte bufptr)
           (setf (%get-ptr buffer)
                 (%incf-ptr bufptr))))
        (%fasl-read-buffer s)))))

(defun %fasl-read-word (s)
  (the fixnum 
    (logior (the fixnum (ash (the fixnum (%fasl-read-byte s)) 8))
            (the fixnum (%fasl-read-byte s)))))

; The LAP here's to avoid calling ASH.
#-ppc-target
(defun %fasl-read-long (s)
  (lap-inline ((%fasl-read-word s) (%fasl-read-word s))
    (getint arg_y)
    (swap arg_y)
    (clr.w arg_y)
    (getint arg_z)
    (swap arg_z)
    (clr.w arg_z)
    (swap arg_z)
    (or.l arg_y arg_z)
    (jsr_subprim $sp-mkulong)))

; This does something much like what COMPOSE-DIGIT does (in the PPC/CMU-bignum
; code), only we HOPE that compose-digit disappears REAL SOON
#+ppc-target
(progn
  (defppclapfunction %compose-unsigned-fullword ((high arg_y) (low arg_z))
    (rlwinm imm0 low (- 32 ppc::fixnumshift) 16 31)
    (rlwimi imm0 high (- 16 ppc::fixnumshift) 0 15)
    ; Now have an unsigned fullword in imm0.  Box it.
    (clrrwi. imm1 imm0 (- ppc::least-significant-bit ppc::nfixnumtagbits))
    (box-fixnum arg_z imm0)             ; assume no high bits set.
    (beqlr+)
    (ba .SPbox-unsigned))

  
  (defppclapfunction %compose-signed-fixnum ((high arg_y) (low arg_z))
    (rlwinm imm0 low (- 32 ppc::fixnumshift) 16 31)
    (rlwimi imm0 high (- 16 ppc::fixnumshift) 0 15)
    ; Now have an unsigned fullword in imm0.  Box it.
    (box-fixnum arg_z imm0)
    (blr))

  (defun %fasl-read-long (s)
    (%compose-unsigned-fullword (%fasl-read-word s) (%fasl-read-word s)))
)


(defun %fasl-read-size (s)
  (let* ((size (%fasl-read-byte s)))
    (declare (integer size))
    (when (= size #xFF)
      (setq size (%fasl-read-word s))
      (if (= size #xFFFF)
        (setq size (%fasl-read-long s))))
    size))

(defun %fasl-read-n-bytes (s ivector byte-offset n)
  (declare (fixnum byte-offset n))
  (do* ()
       ((= n 0))
    (let* ((count (faslstate.bufcount s))
           (buffer (faslstate.iobuffer s))
           (bufptr (%get-ptr buffer))
           (nthere (if (< count n) count n)))
      (declare (dynamic-extent bufptr)
               (type macptr buffer bufptr)
               (fixnum count nthere))
      (if (= nthere 0)
        (%fasl-read-buffer s)
        (progn
          (decf n nthere)
          (decf (the fixnum (faslstate.bufcount s)) nthere)
          (%copy-ptr-to-ivector bufptr 0 ivector byte-offset nthere)
          (incf byte-offset nthere)
          (setf (%get-ptr buffer)
                (%incf-ptr bufptr nthere)))))))
        

(defun %fasl-readstr (s extended-p)
  (declare (fixnum subtype))
  (let* ((nbytes (%fasl-read-size s))
         (copy t)
         (n (if extended-p (ash nbytes -1) nbytes))
         (str (faslstate.faslstr s)))
    (declare (fixnum n nbytes))
    (if extended-p
      (setq str (make-string n :element-type 'extended-character))
      (if (> n (length str))
        (setq str (make-string n :element-type 'base-character))
        (setq copy nil)))
    (%fasl-read-n-bytes s str 0 nbytes)
    (values str n copy)))

(defun %fasl-copystr (str len)
  ; IS THIS OK?
  (declare (fixnum len))
  (let* ((new (if (base-string-p str)
                (make-string len :element-type 'base-character)
                (make-string len :element-type 'extended-character))))
    (declare (optimize (speed 3)(safety 0)))
    (dotimes (i len new)
      (setf (schar new i) (schar str i)))))

(defun %fasl-dispatch (s op)
  (declare (fixnum op))
  (setf (faslstate.faslepush s) (logbitp $fasl-epush-bit op))
  ;(format t "~& dispatch: op = ~d" (logand op (lognot (ash 1 $fasl-epush-bit))))
  (funcall (svref (faslstate.fasldispatch s) (logand op (lognot (ash 1 $fasl-epush-bit)))) 
           s))

(defun %fasl-expr (s)
  (%fasl-dispatch s (%fasl-read-byte s))
  (faslstate.faslval s))

(defun %fasl-expr-preserve-epush (s)
  (let* ((epush (faslstate.faslepush s))
         (val (%fasl-expr s)))
    (setf (faslstate.faslepush s) epush)
    val))

(defun %fasl-make-symbol (s extended-p)
  (declare (fixnum subtype))
  (let* ((n (%fasl-read-size s))
         (str (if extended-p
                (make-string (the fixnum (ash n -1)) :element-type 'extended-character)
                (make-string n :element-type 'base-character))))
    (declare (fixnum n))
    (%fasl-read-n-bytes s str 0 n)
    (%epushval s (make-symbol str))))

(defun %fasl-intern (s package extended-p)
  (multiple-value-bind (str len new-p) (%fasl-readstr s extended-p)
    (without-interrupts
     (multiple-value-bind (symbol access internal-offset external-offset)
                          (%find-symbol str len package)
       (unless access
         (unless new-p (setq str (%fasl-copystr str len)))
         (setq symbol (%add-symbol str package internal-offset external-offset)))
       (%epushval s symbol)))))

(defun %find-pkg (name &optional (len (length name)))
  (declare (fixnum len)
           (optimize (speed 3) (safety 0)))
  (dolist (p %all-packages%)
    (if (dolist (pkgname (pkg.names p))
          (when (and (= (length pkgname) len)
                     (dotimes (i len t)
                       ;; Aref: allow non-simple strings
                       (unless (eq (aref name i) (schar pkgname i))
                         (return))))
            (return t)))
      (return p))))

#-ppc-target
(defun pkg-arg (thing &optional deleted-ok)
  (let* ((xthing (if (symbolp thing) (symbol-name thing) thing)))
    (if (uvectorp xthing)
      (let* ((subtype (%vect-subtype xthing)))
        (declare (fixnum subtype))
        (cond ((= subtype $v_pkg)
               (if (or deleted-ok (pkg.names xthing))
                 xthing
                 (error "~S is a deleted package ." thing)))
              ((or (= subtype $v_sstr)
                   (= subtype $v_xstr))
               (or (%find-pkg xthing)
                   (%kernel-restart $xnopkg xthing)))
              (t (report-bad-arg thing 'simple-string))))
      (report-bad-arg thing 'simple-string))))

#+ppc-target
(defun pkg-arg (thing &optional deleted-ok)
  (let* ((xthing (if (symbolp thing) (symbol-name thing) thing)))
    (let* ((typecode (ppc-typecode xthing)))
        (declare (fixnum typecode))
        (cond ((= typecode ppc::subtag-package)
               (if (or deleted-ok (pkg.names xthing))
                 xthing
                 (error "~S is a deleted package ." thing)))
              ((or (= typecode ppc::subtag-simple-base-string)
                   (= typecode ppc::subtag-simple-general-string))
               (or (%find-pkg xthing)
                   (%kernel-restart $xnopkg xthing)))
              (t (report-bad-arg thing 'simple-string))))))

(defun %fasl-package (s extended-p)
  (multiple-value-bind (str len new-p) (%fasl-readstr s extended-p)
    (let* ((p (%find-pkg str len)))
      (%epushval s (or p (%kernel-restart $XNOPKG (if new-p str (%fasl-copystr str len))))))))

(defun %fasl-listX (s dotp)
  (let* ((len (%fasl-read-word s)))
    (declare (fixnum len))
    (let* ((val (%epushval s (cons nil nil)))
           (tail val))
      (declare (type cons val tail))
      (setf (car val) (%fasl-expr s))
      (dotimes (i len)
          (setf (cdr tail) (setq tail (cons (%fasl-expr s) nil))))
      (if dotp
        (setf (cdr tail) (%fasl-expr s)))
      (setf (faslstate.faslval s) val))))

#-ppc-target
(defun %fasl-lfv-lfun (s lfv)
  (%epushval s (lap-inline (lfv) (add.l ($ ($lfv_lfun)) acc))))

(deffaslop $fasl-noop (s)
  (%cant-epush s))

(deffaslop $fasl-etab-alloc (s)
  (%cant-epush s)
  (setf (faslstate.faslevec s) (make-array (the fixnum (%fasl-read-long s)))
        (faslstate.faslecnt s) 0))

#+ppc-target
(deffaslop $fasl-arch (s)
  (%cant-epush s)
  (let* ((arch (%fasl-expr s)))
    (declare (fixnum arch))
    (unless (= arch 1) (error "Not a PPC fasl file : ~s" (faslstate.faslfname s)))))

(deffaslop $fasl-eref (s)
  (let* ((idx (%fasl-read-word s)))     ; 16 bit limit ? why ?
    (declare (fixnum idx))
    (if (>= idx (the fixnum (faslstate.faslecnt s)))
      (%bad-fasl s))
    (%epushval s (svref (faslstate.faslevec s) idx))))

(deffaslop $fasl-lfuncall (s)
  (let* ((fun (%fasl-expr-preserve-epush s)))
    ;(break "fun = ~s" fun)
     (%epushval s (funcall fun))))

(deffaslop $fasl-globals (s)
  (setf (faslstate.faslgsymbols s) (%fasl-expr s)))

(deffaslop $fasl-char (s)
  (%epushval s (code-char (%fasl-read-byte s))))

#-ppc-target
(deffaslop $fasl-fixnum (s)
  (%epushval s (lap-inline ((%fasl-read-long s))
                 (jsr_subprim $sp-getXlong)
                 (mkint acc))))

#+ppc-target
(deffaslop $fasl-fixnum (s)
  (%epushval
   s
    (%compose-signed-fixnum (%fasl-read-word s) (%fasl-read-word s))))



#-ppc-target
(deffaslop $fasl-float (s)
  (%stack-block ((p 4))
    (setf (%get-long p) (%fasl-read-long s))
    (%epushval s (lap-inline ((%fasl-read-long s))
                   (:variable p)
                   (jsr_subprim $sp-getulong)
                   (move.l (varg p) atemp0)
                   (move.l (atemp0 $macptr.ptr) atemp0)
                   (move.l @atemp0 arg_y)
                   (jsr_subprim $sp-makefloat)))))

#+ppc-target
(deffaslop $fasl-float (s)
  ;; A double-float is a 3-element "misc" object on the PPC.
  ;; Element 0 is always 0 and exists solely to keep elements 1 and 2
  ;; aligned on a 64-bit boundary.
  (let* ((df (%alloc-misc ppc::double-float.element-count
                          ppc::subtag-double-float)))
    (setf (%misc-ref df ppc::double-float.value-cell)
          (%fasl-read-long s))
    (setf (%misc-ref df ppc::double-float.val-low-cell)
          (%fasl-read-long s))
    (%epushval s df)))

(deffaslop $fasl-str (s)
  (let* ((n (%fasl-read-size s))
         (str (make-string (the fixnum n) :element-type 'base-character)))
    (%epushval s str)
    (%fasl-read-n-bytes s str 0 n)))

(deffaslop $fasl-word-fixnum (s)
  (%epushval s (%word-to-int (%fasl-read-word s))))

(deffaslop $fasl-mksym (s)
  (%fasl-make-symbol s nil))

(deffaslop $fasl-intern (s)
  (%fasl-intern s *package* nil))

(deffaslop $fasl-pkg-intern (s)
  (let* ((pkg (%fasl-expr-preserve-epush s)))
    #+paranoia
    (setq pkg (pkg-arg pkg))
    (%fasl-intern s pkg nil)))

(deffaslop $fasl-pkg (s)
  (%fasl-package s nil))

(deffaslop $fasl-cons (s)
  (let* ((cons (%epushval s (cons nil nil))))
    (declare (type cons cons))
    (setf (car cons) (%fasl-expr s)
          (cdr cons) (%fasl-expr s))
    (setf (faslstate.faslval s) cons)))

(deffaslop $fasl-list (s)
  (%fasl-listX s nil))

(deffaslop $fasl-list* (s)
  (%fasl-listX s t))

(deffaslop $fasl-nil (s)
  (%epushval s nil))

#-ppc-target
(deffaslop $fasl-timm (s)
  (%epushval s (lap-inline ((%fasl-read-long s))
                 (jsr_subprim $sp-getXlong)
                 #+paranoid
                 (if# (ne (ttagp $t_imm acc da))
                   (#_Debugger)))))

#+ppc-target
(deffaslop $fasl-timm (s)
  (rlet ((p :long))
    (setf (%get-long p) (%fasl-read-long s))
    (%epushval s (%get-unboxed-ptr p))))

; N/A on PPC
#-ppc-target
(deffaslop $fasl-lfun (s)
  (%fasl-lfv-lfun s (%fasl-expr-preserve-epush s)))

; N/A on PPC
#-ppc-target
(deffaslop $fasl-eref-lfun (s)
  (%fasl-lfv-lfun s (svref (faslstate.faslevec s) (%fasl-read-word s))))

(deffaslop $fasl-symfn (s)
  (%epushval s (%function (%fasl-expr-preserve-epush s))))
    
(deffaslop $fasl-eval (s)
  (%epushval s (eval (%fasl-expr-preserve-epush s))))

; For bootstrapping. The real version is cheap-eval in l1-readloop
(when (not (fboundp 'eval))
  (defun eval (form)
    (if (and (listp form)
             (let ((f (%car form)))
               (and (symbolp f)
                    (functionp (fboundp f)))))
      (apply (%car form) (%cdr form))
      (error "Can't eval yet: ~s" form)
      ;(bug "Can't eval yet:")
      )))

;; Aside from other tagging details, the PPC wants an element count
;; (from which it'll derive the size-in-bytes); the 68K wants the
;; size in bytes.
#-ppc-target
(deffaslop $fasl-ivec (s)
  (let* ((subtype (%fasl-read-byte s))
         (size-in-bytes (%fasl-read-size s))
         (vector (lap-inline (subtype size-in-bytes)
                   (getint arg_y)
                   (getint arg_z)
                   (jsr_subprim $sp-allocvect)
                   (move.l atemp0 acc))))
    (%epushval s vector)
    (%fasl-read-n-bytes s vector 0 size-in-bytes)
    vector))

#+ppc-target
(deffaslop $fasl-ivec (s)
  (let* ((subtag (%fasl-read-byte s))
         (element-count (%fasl-read-size s))
         (size-in-bytes (ppc-subtag-bytes subtag element-count))
         (vector (%alloc-misc element-count subtag)))
    (declare (fixnum subtag element-count size-in-bytes))
    (%epushval s vector)
    (%fasl-read-n-bytes s vector 0 size-in-bytes)
    (when (= subtag ppc::subtag-code-vector)
      (%make-code-executable vector))
    vector))

#-ppc-target
(deffaslop $fasl-gvec (s)
  (let* ((subtype (%fasl-read-byte s))
         (n (%fasl-read-size s))
         (vector (%make-uvector n subtype)))
    (declare (fixnum n))
    (%epushval s vector)
    (dotimes (i n (setf (faslstate.faslval s) vector))
      (setf (%svref vector i) (%fasl-expr s)))))

#+ppc-target
(deffaslop $fasl-gvec (s)
  (let* ((subtype (%fasl-read-byte s))
         (n (%fasl-read-size s))
         (vector (%alloc-misc n subtype)))
    (declare (fixnum n))
    (%epushval s vector)
    (dotimes (i n (setf (faslstate.faslval s) vector))
      (setf (%svref vector i) (%fasl-expr s)))))



#-ppc-target    
(deffaslop $fasl-nlfvec (s)
  (let* ((size-in-bytes (%fasl-read-size s))
         (lfv (lap-inline (size-in-bytes)
                (move.l ($ $v_nlfunv) arg_y)
                (getint arg_z)
                (jsr_subprim $sp-allocvect)
                (clr.w (atemp0 $lfv_attrib))    ; Paranoia. Does $SP-ALLOCVECT do this ? Yes.
                (move.l atemp0 acc))))
    (declare (fixnum size-in-bytes))
    (%epushval s lfv)
    (%fasl-read-n-bytes s lfv 0 size-in-bytes)
    (let* ((attr (uvref lfv 0)))
      (declare (fixnum attr))
      (when (logbitp $lfatr-immmap-bit attr)
        (let* ((endptr (- size-in-bytes (if (logbitp $lfatr-slfunv-bit attr) (1+ 8) (1+ 4))))
               (imm-byte-offset 2))
          (declare (fixnum endptr imm-byte-offset))
          (flet ((vector-u8-ref (v byte-offset)
                   (lap-inline (v byte-offset 0)
                     (move.l arg_x atemp0)
                     (getint arg_y)
                     (move.b (atemp0 arg_y.l $v_data) acc)
                     (mkint acc)))
                 (vector-lisp-add (v byte-offset new)
                   (lap-inline (v byte-offset new)
                     (move.l arg_x atemp0)
                     (getint arg_y)
                     (add.l acc (atemp0 arg_y.l $v_data)))))
            (declare (inline vector-u8-ref vector-lisp-add))
            (loop
              (let* ((disp-byte (vector-u8-ref lfv endptr)))
                (declare (fixnum disp-byte))
                (when (= 0 disp-byte) (return))
                (decf endptr)
                (let* ((disp (if (logbitp 7 disp-byte)
                               (logior (the fixnum (ash (the fixnum (vector-u8-ref lfv endptr)) 8))
                                       (the fixnum (logand (the fixnum (+ disp-byte disp-byte)) #xff)))
                               (the fixnum (+ disp-byte disp-byte)))))
                  (declare (fixnum disp))
                  (if (logbitp 7 disp-byte) (decf endptr))
                  (incf imm-byte-offset disp)
                  (let* ((nextimm (%fasl-expr s)))
                    ;(format t "~& next immediate = ~s" nextimm)
                    (vector-lisp-add lfv imm-byte-offset nextimm))))))))
      (lap-inline (lfv) (add.l ($ $lfv_lfun) arg_z) (jsr_subprim $flush_code_cache))
      (setf (faslstate.faslval s) lfv))))
          
(deffaslop $fasl-xchar (s)
  (%epushval s (code-char (%fasl-read-word s))))
    
(deffaslop $fasl-mkxsym (s)
  (%fasl-make-symbol s t))

(deffaslop $fasl-defun (s)
  (%cant-epush s)
  (%defun (%fasl-expr s) (%fasl-expr s)))

(deffaslop $fasl-macro (s)
  (%cant-epush s)
  (%macro (%fasl-expr s) (%fasl-expr s)))

(deffaslop $fasl-defconstant (s)
  (%cant-epush s)
  (%defconstant (%fasl-expr s) (%fasl-expr s) (%fasl-expr s)))

(deffaslop $fasl-defparameter (s)
  (%cant-epush s)
  (let* ((sym (%fasl-expr s))
         (val (%fasl-expr s)))
    (%defvar sym (%fasl-expr s))
    (set sym val)))

; (defvar var)
(deffaslop $fasl-defvar (s)
  (%cant-epush s)
  (%defvar (%fasl-expr s)))

; (defvar var initfom doc)
(deffaslop $fasl-defvar-init (s)
  (%cant-epush s)
  (let* ((sym (%fasl-expr s))
         (val (%fasl-expr s)))
    (unless (%defvar sym (%fasl-expr s))
      (set sym val))))

(deffaslop $fasl-skip (s)
  (%fasl-expr s)
  (%fasl-expr s))

(deffaslop $fasl-prog1 (s)
  (let* ((val (%fasl-expr s)))
    (%fasl-expr s)
    (setf (faslstate.faslval s) val)))

(deffaslop $fasl-xintern (s)
  (%fasl-intern s *package* t))

(deffaslop $fasl-pkg-xintern (s)
  (let* ((pkg (%fasl-expr-preserve-epush s)))
    #+paranoia
    (setq pkg (pkg-arg pkg))
    (%fasl-intern s pkg t)))

(deffaslop $fasl-xpkg (s)
  (%fasl-package s t))

(deffaslop $fasl-src (s)
  (%cant-epush s)
  (let* ((source-file (%fasl-expr s)))
    ;(format t "~& source-file = ~s" source-file)
    (setq *loading-file-source-file* source-file)))

#|
(deffaslop $fasl-library-pointer (s)
  (setf (faslstate.faslval s)
        (pfsl-shared-library-offset s)))
|#

(defvar *modules* nil)

; Bootstrapping version
(defun provide (module-name)
  (push module-name *modules*))

(deffaslop $fasl-provide (s)
  (provide (%fasl-expr s)))

(deffaslop $fasl-xlist (s)
  (%fasl-listxl s nil))

(deffaslop $fasl-xlist* (s)
  (%fasl-listxl s t))

(defun %fasl-listX (s dotp)
  (%fasl-list s dotp (%fasl-read-word s)))

(defun %fasl-listxl (s dotp)
  (%fasl-list s dotp (%fasl-read-long s)))

(defun %fasl-list (s dotp len)
  (declare (fixnum len))
  (let* ((val (%epushval s (cons nil nil)))
         (tail val))
    (declare (type cons val tail))
    (setf (car val) (%fasl-expr s))
    (dotimes (i len)
      (setf (cdr tail) (setq tail (cons (%fasl-expr s) nil))))
    (if dotp
      (setf (cdr tail) (%fasl-expr s)))
    (setf (faslstate.faslval s) val)))    


;;; The loader itself

(defun %fasl-set-file-pos (s new)
  (let* ((pb (faslstate.fasliopb s))
         (posoffset (%get-long pb $ioposoffset)))
    (if (>= (decf posoffset new) 0)
      (let* ((count (faslstate.bufcount s)))
        (if (>= (decf count posoffset ) 0)
          (progn
            (setf (faslstate.bufcount s) posoffset)
            (incf (%get-long (faslstate.iobuffer s)) count)
            (return-from %fasl-set-file-pos nil)))))
    (progn
      (setf (%get-long pb $ioPosOffset) new
            (%get-word pb $ioPosMode) $fsFromStart)
      (setf (faslstate.bufcount s) 0)
      (let ((res (PBSetFPosSync pb)))
        (unless (eql res #$noerr)
          (error (format nil "~d" res)))))))
      ;(PBSetFPosSync :errchk pb))))

(defun %fasl-get-file-pos (s)
  (- (%get-long (faslstate.fasliopb s) $ioposoffset) (faslstate.bufcount s)))


(defparameter *%fasload-verbose* t)

(defun %fasload (string &optional (table *fasl-dispatch-table*)
                        start-faslops-function
                        stop-faslops-function)
  
  (when (and *%fasload-verbose*
             (not *load-verbose*))
    (write-string-to-file-descriptor ";;;Loading ")
    (write-string-to-file-descriptor string :newline t))
  (with-pstrs ((name string)) ; there is a bootstrapping version of byte length now
    (let* ((s (%istruct
               'faslstate
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil)))
      (declare (dynamic-extent s))
      (setf (faslstate.faslfname s) string)
      (setf (faslstate.fasldispatch s) table)
      (setf (faslstate.faslversion s) 0)
      (%stack-block ((pb #.(record-length :hparamblockrec) :clear t)
                     (buffer (+ 4 $fasl-buf-len)))
        (setf (faslstate.fasliopb s) pb
              (faslstate.iobuffer s) buffer)
        (let* ((old %parse-string%))
          (setq %parse-string% nil)    ;  mark as in use
          (setf (faslstate.oldfaslstr s) old
                (faslstate.faslstr s) (or old (make-string 255 :element-type 'base-character)))
          
          (flet ((%fasl-open (s)
                   (let* ((ok nil)
                          (pb (faslstate.fasliopb s))
                          (err #$noErr))
                     (setf (%get-ptr pb $iofilename) name
                           (%get-long pb $ioCompletion) 0
                           (%get-byte pb $ioFileType) 0
                           (%get-word pb $ioVrefNum) 0
                           (%get-byte pb $ioPermssn) $fsrdperm
                           (%get-long pb $ioOwnBuf) 0)
                     (if (and (eql #$noErr (setq err (PBHOpenSync pb)))                              
                              (eql #$noErr (setq err (PBGetEOFSync pb))))
                       (if (< (the fixnum (%get-long pb $ioLEOF)) 4)
                         (setq err $xnotfasl)
                         (progn
                           (setf (faslstate.bufcount s) 0
                                 (%get-long pb $ioposoffset) 0)
                           (let* ((signature (%fasl-read-word s)))
                             (declare (fixnum signature))
                             (if (= signature $fasl-file-id)
                               (setq ok t)
                               (if (= signature $fasl-file-id1)
                                 (progn
                                   (%fasl-set-file-pos s (%fasl-read-long s))
                                   (setq ok t))
                                 (setq err $xnotfasl)))))))
                     (unless (eql err #$noErr) (setf (faslstate.faslerr s) err))
                     ok)))
            (unwind-protect
              (when (%fasl-open s)
                (let* ((nblocks (%fasl-read-word s))
                       (*pfsl-library-base* nil)
                       (*pfsl-library* nil))
                  (declare (fixnum nblocks))
                  (declare (special *pfsl-library-base* *pfsl-library*))
                  (unless (= nblocks 0)
                    (let* ((pos (%fasl-get-file-pos s)))
                      (dotimes (i nblocks)
                        (%fasl-set-file-pos s pos)
                        (%fasl-set-file-pos s (%fasl-read-long s))
                        (incf pos 8)
                        (when start-faslops-function (funcall start-faslops-function s))
                        (let* ((version (%fasl-read-word s)))
                          (declare (fixnum version))
                          (if (and nil (or (> version (+ #xff00 $fasl-vers)) ;; I dont care
                                  (< version (+ #xff00 $fasl-min-vers))))
                            (%err-disp (if (>= version #xff00) $xfaslvers $xnotfasl))
                            (progn
                              (setf (faslstate.faslversion s) version)
                              (%fasl-read-word s) 
                              (%fasl-read-word s)       ; Ignore kernel version stuff
                              (setf (faslstate.faslevec s) nil
                                    (faslstate.faslecnt s) 0)
                              (do* ((op (%fasl-read-byte s) (%fasl-read-byte s)))
                                   ((= op $faslend))
                                (declare (fixnum op))
                                (%fasl-dispatch s op))
                              (when stop-faslops-function (funcall stop-faslops-function s))
                              ))))))))
              (setq %parse-string% (faslstate.oldfaslstr s))
              (PBCloseSync pb))
            (let* ((err (faslstate.faslerr s)))
              (if err
                (values nil err)
                (values t nil)))))))))


(defun %new-package-hashtable (size)
  (%initialize-htab (cons nil (cons 0 0)) size))

(defun %initialize-htab (htab size)
  (declare (fixnum size))
  ; Ensure that "size" is relatively prime to all secondary hash values.
  ; If it's small enough, pick the next highest known prime out of the
  ; "primsizes" array.  Otherwize, iterate through all all of "hprimes"
  ; until we find something relatively prime to all of them.
  (setq size
        (if (> size 32749)
          (do* ((nextsize (logior 1 size) (+ nextsize 2)))
               ()
            (declare (fixnum nextsize))
            (when (dotimes (i 8 t)
                    (unless (eql 1 (gcd nextsize (uvref #.$hprimes i)))
                      (return)))
              (return nextsize)))
          (dotimes (i (the fixnum (length #.$primsizes)))
            (let* ((psize (uvref #.$primsizes i)))
              (declare (fixnum psize))
              (if (>= psize size) 
                (return psize))))))
  (setf (htvec htab) (make-array size :initial-element nil))
  (setf (htcount htab) 0)
  (setf (htlimit htab) (the fixnum (- size (the fixnum (ash size -3)))))
  htab)

(defun %resize-htab (htab)
  (declare (optimize (speed 3) (safety 0)))
  (without-interrupts
   (let* ((old-vector (htvec htab))
          (old-len (length old-vector)))
     (declare (fixnum old-len)
              (simple-vector old-vector))
     (let* ((nsyms 0))
       (declare (fixnum nsyms))
       (dovector (s old-vector)
         (and s (symbolp s) (incf nsyms)))
       (%initialize-htab htab 
                         (the fixnum (+ 
                                      (the fixnum 
                                        (+ nsyms (the fixnum (ash nsyms -2))))
                                      2)))
       (let* ((new-vector (htvec htab))
              (nnew 0))
         (declare (fixnum nnew)
                  (simple-vector new-vector))
         (dotimes (i old-len (setf (htcount htab) nnew))
           (let* ((s (svref old-vector i)))
             (when s
               (setf (svref old-vector i) nil)       ; in case old-vector was static
               (if (symbolp s)
                 (let* ((pname (symbol-name s)))
                   (setf (svref 
                          new-vector 
                          (nth-value 
                           2
                           (%get-htab-symbol 
                            pname
                            (length pname)
                            htab)))
                         s)
                   (incf nnew))))))
         htab)))))


#-ppc-target
(defun %pname-hash (str len)
  (lap-inline ()
    (:variable str len)
    (move.l (varg str) atemp0)
    (move.l (varg len) da)
    (getint da)
    (move.l ($ 0) arg_z)
    (move.l ($ 0) arg_y)
    (vsubtypep ($ $v_xstr) atemp0 db)
    (add ($ $v_data) atemp0)
    (if# eq
      (dbfloop da
        (rol.l ($ 5) arg_z)
        (move.w atemp0@+ arg_y)
        (eor.l arg_y arg_z))
      else#
      (dbfloop da
        (rol.l ($ 5) arg_z)
        (move.b atemp0@+ arg_y)
        (eor.l arg_y arg_z)))
    (lsl.l ($ 5) arg_z)
    (lsr.l ($ (- 5 $fixnumshift)) arg_z)))

#+ppc-target
(defppclapfunction %pname-hash ((str arg_y) (len arg_z))
  (let ((nextw imm1)
        (accum imm0)
        (offset imm2)
        (tag imm3))
    (extract-subtag tag str)
    (cmpwi cr1 tag ppc::subtag-simple-general-string)
    (cmpwi cr0 len 0)
    (li offset ppc::misc-data-offset)
    (li accum 0)
    (beqlr- cr0)
    (if (:cr1 :eq)
      (progn
        @loop16
        (cmpwi cr1 len '1)
        (subi len len '1)
        (lhzx nextw str offset)
        (addi offset offset 2)
        (rotlwi accum accum 5)
        (xor accum accum nextw)
        (bne cr1 @loop16)
        (slwi accum accum 5)
        (srwi arg_z accum (- 5 ppc::fixnumshift))
        (blr)))
    @loop8
    (cmpwi cr1 len '1)
    (subi len len '1)
    (lbzx nextw str offset)
    (addi offset offset 1)
    (rotlwi accum accum 5)
    (xor accum accum nextw)
    (bne cr1 @loop8)
    (slwi accum accum 5)
    (srwi arg_z accum (- 5 ppc::fixnumshift))
    (blr)))
    
        
(defun hash-pname (str len)
  (declare (optimize (speed 3) (safety 0)))
  (let* ((primary (%pname-hash str len)))
    (declare (fixnum primary))
    (values primary (aref (the (simple-array (unsigned-byte 16) (8)) $hprimes) (logand primary 7)))))


    


(defun %get-hashed-htab-symbol (str len htab primary secondary)
  (declare (optimize (speed 3) (safety 0))
           (fixnum primary secondary len))
  (let* ((vec (htvec htab))
         (vlen (length vec)))
    (declare (fixnum vlen))
    (do* ((idx (fast-mod primary vlen) (+ i secondary))
          (i idx (if (>= idx vlen) (- idx vlen) idx))
          (elt (svref vec i) (svref vec i)))
         ((null elt) (values nil nil i))
      (declare (fixnum i idx))
      (when (and elt (symbolp elt))
        (let* ((pname (symbol-name elt)))
          (if (and 
               (= (the fixnum (length pname)) len)
               (dotimes (j len t)
                 (unless (eq (aref str j) (schar pname j))
                   (return))))
            (return (values t (%symptr->symbol elt) i))))))))

(defun %get-htab-symbol (string len htab)
  (declare (optimize (speed 3) (safety 0)))
  (multiple-value-bind (p s) (hash-pname string len)
    (%get-hashed-htab-symbol string len htab p s)))

(defun %find-symbol (string len package)
  (declare (optimize (speed 3) (safety 0)))
  (multiple-value-bind (found-p sym internal-offset)
                       (%get-htab-symbol string len (pkg.itab package))
    (if found-p
      (values sym :internal internal-offset nil)
      (multiple-value-bind (found-p sym external-offset)
                           (%get-htab-symbol string len (pkg.etab package))
        (if found-p
          (values sym :external internal-offset external-offset)
          (dolist (p (pkg.used package) (values nil nil internal-offset external-offset))
            (multiple-value-bind (found-p sym)
                                 (%get-htab-symbol string len (pkg.etab p))
              (when found-p
                (return (values sym :inherited internal-offset external-offset))))))))))
          
(defun %htab-add-symbol (symbol htab idx)
  (declare (optimize (speed 3) (safety 0)))
  (setf (svref (htvec htab) idx) (%symbol->symptr symbol))
  (if (>= (incf (the fixnum (htcount htab)))
          (the fixnum (htlimit htab)))
    (%resize-htab htab))
  symbol)

(defun %set-symbol-package (symbol package-or-nil)
  (declare (optimize (speed 3) (safety 0)))
  (let* ((old-pp (%symbol-package-plist symbol)))
    (if (consp old-pp)
      (setf (car old-pp) package-or-nil)
      (%set-symbol-package-plist symbol package-or-nil))))

(defun %insert-symbol (symbol package internal-idx external-idx &optional force-export)
  (let* ((package-plist (%symbol-package-plist symbol))
         (keyword-package (eq package *keyword-package*)))
    ; Set home package
    (if package-plist
      (if (listp package-plist)
        (unless (%car package-plist) (%rplaca package-plist package)))
      (%set-symbol-package-plist symbol package))
    (if (or force-export keyword-package)
      (progn
        (%htab-add-symbol symbol (pkg.etab package) external-idx)
        (if keyword-package
          ;(define-constant symbol symbol)
          (progn
            (%set-sym-value symbol symbol)
            (%symbol-bits symbol 
                          (logior (ash 1 $sym_vbit_special) 
                                  (ash 1 $sym_vbit_const)
                                  (the fixnum (%symbol-bits symbol)))))))
      (%htab-add-symbol symbol (pkg.itab package) internal-idx))
    symbol))

; PNAME must be a simple string!
(defun %add-symbol (pname package internal-idx external-idx &optional force-export)
  (let* ((sym (make-symbol pname)))
    (%insert-symbol sym package internal-idx external-idx force-export)))


; The initial %toplevel-function% sets %toplevel-function% to NIL;
; if the %fasload call fails, the lisp should exit (instead of repeating
; the process endlessly ...

#-ppc-target
(defvar %toplevel-function%
  #'(lambda ()
      (declare (special *x68k-cold-load-functions*)) 
      (setq %toplevel-function% nil)   ; should get reset by l1-boot.
      (dolist (f (prog1 *x68k-cold-load-functions* (setq *x68k-cold-load-functions* nil)))
        (funcall f))
      (%fasload "level-1.fasl")
     
  ))

#+PPC-target
(defvar %toplevel-function%
  #'(lambda ()
      (declare (special *xppc-cold-load-functions*))
      (setq %toplevel-function% nil)   ; should get reset by l1-boot.
     (dolist (f (prog1 *xppc-cold-load-functions* (setq *xppc-cold-load-functions* nil)))
        (funcall f))
      #-carbon-compat
      (%fasload "level-1.pfsl")
      #+carbon-compat
      (%fasload "level-1.cfsl")))

