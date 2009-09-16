;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  1 11/16/95 bill New file
;;  (do not edit before this line!!)


;;; ppc-callback-support.lisp
;;;
;;; Support for PPC callbacks

;;; Modification History
;;; fix define-ppc-pascal-function-2 for redefining a pascal-function
;;; handle macho callbacks
;;; --- 5.1 final
;;; add some strange things for carbon
;;; ---------- 4.3.1b1
;;; 03/10/97 bill  A version of the backward-compatible define-ppc-pascal-function
;;;                that actually works.
;;; 03/09/97 gb    define-ppc-pascal-function -> define-ppc-pascal-function-2, backward compat.
;;; 02/23/97 bill  %pascal-functions% now passes the stack-ptr-fixnum to the
;;;                lisp function. This prevents VSP use for lisp functions
;;;                that have no args (cs-overflow-callback makes use of this fact).
;;; -------------  4.0
;;; 10/07/96 bill  #+ppc-target version of defpascal-callback-p
;;;  9/06/96 slh   define-ppc-pascal-function: record 'defpascal (from AlanR)
;;; 07/31/96 bill  new upp-transition-vector function
;;; -------------  MCL-PPC 3.9
;;; 04/03/96 bill  %cons-pfe takes a new, without-interrupts arg.
;;;                define-ppc-pascal-function takes a new, optional without-interrupts
;;;                arg, which it puts into the generated pfe.
;;;                %pascal-functions% is optimized (speed 3) (safety 0) so that
;;;                it won't do event check on entry. It conditionally executes
;;;                it's body without-interrupts according to the pfe.without-interrupts
;;;                value.
;;; 03/25/96 bill  define-ppc-pascal-function takes an optional doc-string arg
;;; 02/22/96 bill *call-universal-proc-slep*, *call-universal-proc-address*
;;; 01/23/96 bill  %fixnum-from-macptr (opposite of %setf-macptr-to-object).
;;; 01/16/96 bill  define-ppc-pascal-function correctly initializes new entries in
;;;                %pascal-functions to NIL. It also doesn't attempt to %svref
;;;                entries that are not vectors.
;;; 11/21/95 bill  New %get-object function. Add one instruction memory access time in %set-object.
;;; 11/10/95 bill  New file
;;;

;;; Universal Procedure Pointer -> Transition Vector = (address, TOC, ...)
;;; The transition vector for our callbacks looks like:
;;;
;;; .SPcallback      ; Subprim that trampolines back to the Lisp
;;; nil-ptr          ; pointer to the nil below
;;; nil              ; for initializing nilreg
;;; index            ; Index in %pascal-functions% of lisp code. Boxed.
;;;
;;; sp-callback uses the nil-ptr value it finds in the TOC register (nilreg)
;;; to load nilreg and get the %pascal-functions% index. Then it
;;; funcalls #'%pascal-functions% with two args, the %pascal-functions% index
;;; and a pointer to the stack frame containing the arguments (tagged as a fixnum).
;;; %pascal-functions% puts the return value in param0.





(eval-when (:compile-toplevel :execute)

;; Callback-Transition-Vector
(defconstant $ctv.spcallback 0)
(defconstant $ctv.toc 4)
(defconstant $ctv.nil 8)
(defconstant $ctv.index 12)
(defconstant ctv.size 16)

(unless (fboundp 'pfe.routine-descriptor)       ; defined in level-2.lisp

; %Pascal-Functions% Entry
(def-accessor-macros %svref
  pfe.routine-descriptor
  pfe.proc-info
  pfe.lisp-function)

)  ; end unless

)  ; end eval-when

;; this sucky thing is for carbon

(defvar defpascal-upp-alist nil) ;; or defpascal-yucklist

(defun add-pascal-upp-alist (name fn)
  (let ((thing (assq name defpascal-upp-alist)))
    (if thing (rplacd thing fn)(push (cons name fn) defpascal-upp-alist))))

; Return as a fixnum the address of the subprim at the given offset
#+ppc-target
(defppclapfunction %get-subprim ((subprim-offset arg_z))
  (ref-global imm0 subprims-base)
  (unbox-fixnum arg_z arg_z)
  (add arg_z imm0 arg_z)
  (blr))


#+ppc-target
(defppclapfunction %get-object ((macptr arg_y) (offset arg_z))
  (check-nargs 2)
  (trap-unless-typecode= arg_y ppc::subtag-macptr)
  (macptr-ptr imm0 arg_y)
  (trap-unless-fixnum arg_z imm1)
  (unbox-fixnum arg_z arg_z)
  (lwzx arg_z arg_z imm0)
  (blr))

;; It would be awfully nice if (setf (%get-long macptr offset)
;;                                   (ash (the fixnum value) ppc::fixnumshift))
;; would do this inline.
#+ppc-target
(defppclapfunction %set-object ((macptr arg_x) (offset arg_y) (value arg_z))
  (check-nargs 3)
  (trap-unless-typecode= arg_x ppc::subtag-macptr)
  (macptr-ptr imm0 arg_x)
  (trap-unless-fixnum arg_y imm1)
  (unbox-fixnum arg_y arg_y)
  (stwx arg_z arg_y imm0)
  (blr))

;; It would be nice if (%setf-macptr macptr (ash (the fixnum value) ppc::fixnumshift))
;; would do this inline.
#+ppc-target
(defppclapfunction %setf-macptr-to-object ((macptr arg_y) (object arg_z))
  (check-nargs 2)
  (trap-unless-typecode= arg_y ppc::subtag-macptr)
  (stw arg_z ppc::macptr.address arg_y)
  (blr))

#| ;; moved to l1-init
(defppclapfunction %fixnum-from-macptr ((macptr arg_z))
  (check-nargs 1)
  (trap-unless-typecode= arg_z ppc::subtag-macptr)
  (lwz imm0 ppc::macptr.address arg_z)
  (trap-unless-lisptag= imm0 ppc::tag-fixnum imm1)
  (mr arg_z imm0)
  (blr))
|#



; This is referenced by the expansion of call-universal-proc
(defparameter *call-universal-proc-slep* nil) ;(get-slep "CallUniversalProc"))

(defparameter *call-universal-proc-address* nil) ; (%resolve-slep-address *call-universal-proc-slep*))

;; whats going on here is that although we may reference calluniversalproc in carbon where noexist
;; we don't actually do it unless 68k stuff is going on - at least I think that's true
;; though we do do calluniversalproc in the kernel - now we don't if carbon.

#|
(defun get-call-universal-proc-address ()
  #+ignore
  (progn
    (setq *call-universal-proc-slep* (get-slep "CallUniversalProc"))
    (setq *call-universal-proc-address* (%Resolve-slep-address *call-universal-proc-slep*)))
  #-ignore
  (error "We don't do calluniversalproc in Carbon/osx"))
|#



(defun cons-routine-descriptor (Transition-vector proc-info &optional (isa #$kPowerPCISA))
  #-carbon-compat
  (#_NewRoutineDescriptor transition-vector proc-info isa)
  #+carbon-compat
  (my-new-routine-descriptor transition-vector proc-info isa))

;(COMPILER-LET ((*dont-use-cfm* nil)) ;; why??


;;  just does what #_newroutinedescriptor does in the normal case nowadays
;; copied from macro build_routine_descriptor in mixedmode.h
;; now all we gotta do is hand code the 2 instances of calluniversalproc in
;; the kernel to match this - one has procinfo 0, other has 6 args
;; this is where the slep calls to memerror and blockmove come from

(defun my-new-routine-descriptor (procptr procinfo isa)  
  (rlet ((routine-record :routinerecord
                         :procinfo procinfo
                         :isa isa
                         :routineflags
                         #.(logior #$kProcDescriptorIsAbsolute			                       
                                   #$kFragmentIsPrepared
                                   #$Kusenativeisa)
                         :reserved1 0
                         :reserved2 0
                         :procdescriptor procptr
                         :SELECTOR 0))
    
    (make-record :routinedescriptor
                 :gomixedmodetrap #xAAFE  ;;mixed mode magic cookie
                 :version #$kRoutineDescriptorVersion
                 :routinedescriptorflags #$kSelectorsAreNotIndexable
                 :selectorinfo 0
                 :routinecount 0
                 :reserved1 0
                 :reserved2 0
                 :routinerecords routine-record
                 )))


(defun %cons-pfe (routine-descriptor proc-info lisp-function sym without-interrupts)
  (vector routine-descriptor proc-info lisp-function sym without-interrupts))


(defparameter *macho-upps* nil)
#+carbon-compat
(defun make-routine-descriptor (index proc-info &optional (isa #$kPowerPCISA) for-whom)
  (if (and for-whom (memq for-whom *macho-upps*))
    (make-routine-descriptor-macho index proc-info isa for-whom)
    (let ((ctv (#_NewPtr ctv.size))) ; should allocate a bunch at a time
      (%set-object ctv 0 (%get-subprim .spcallback))
      (setf (%get-ptr ctv $ctv.toc) (%inc-ptr ctv $ctv.nil))
      (%set-object ctv $ctv.nil nil)
      (%set-object ctv $ctv.index index)
      (if (and for-whom (setq for-whom (cdr (assq for-whom defpascal-upp-alist))))
        (funcall for-whom ctv)
        ;; or my-new-routine-descriptor of same args
        (cons-routine-descriptor ctv proc-info isa)))))

;; )  ;; end compiler-let

(defppclapfunction ctv-proto ()
  (lis rnil 0)  ;; spcallback expects rnil (= rtoc = r2) to point to location containing nil and index
  (ori rnil rnil 0)
  (ba .spcallback)
  (nop)  ;; put nil here
  (nop)) ;; put index here

(defconstant $ctv2.nil 12)
(defconstant $ctv2.index 16)

;; from misc.lisp - with optional arg added - don't need the whole thing
(defun lfun-to-ptr-partial (lfun &optional words-to-copy)
  (unless (functionp lfun)
    (setq lfun (require-type lfun 'function)))
  (let* ((code-vector (uvref lfun 0))
         (words (or words-to-copy (uvsize code-vector)))
         (bytes (* 4 words))
         (ptr (#_NewPtr :errchk bytes)))
    (%copy-ivector-to-ptr code-vector 0 ptr 0 bytes)
    (#_MakeDataExecutable ptr bytes)
    ptr))


;; seems to work now
(defun make-routine-descriptor-macho (index proc-info &optional (isa #$kPowerPCISA) for-whom)
  (declare (ignore proc-info isa))
  (let* ((ctv (lfun-to-ptr-partial (symbol-function 'ctv-proto) 5)))
    (multiple-value-bind (lo-addr hi-addr)(macptr-to-fixnums ctv)
      (declare (fixnum lo-addr hi-addr))
      (setq lo-addr (+ lo-addr $ctv2.nil))
      (when (> lo-addr #xffff)
        (setq lo-addr (logand lo-addr #xffff))
        (setq hi-addr (%i+ hi-addr 1)))
      (let* ((ba-instr #x48000002)  ;; 2 at bottom says branch absolute - else relative!
             (ba-addr (ash (%get-subprim .spcallback) 2)))
        (%put-long ctv (logior ba-instr ba-addr) 8))        
      (%put-word ctv hi-addr 2)
      (%put-word ctv lo-addr 6)
      (%set-object ctv $ctv2.nil  nil)
      (%set-object ctv $ctv2.index index)
      (#_makedataexecutable ctv 20)  ;; ??
      (if (and for-whom (setq for-whom (cdr (assq for-whom defpascal-upp-alist))))
        (funcall for-whom ctv)  ;; call NewxxxUPP with thing created - better be fn that does macho call 
        ;; or my-new-routine-descriptor of same args
        ;; only do above stuff if for-whom!
        (error "confused")))))


  
#|
(defun ppc-pascal-function-template (args-fixnum)
  (with-area-macptr (args-macptr args-fixnum)
    (funcall 'foo args-macptr)))
|#

; (defpascal ...) on the PPC expands into a call to this function.
(defun define-ppc-pascal-function-2 (lisp-function proc-info &optional doc-string (without-interrupts t)
                                                   &aux name routine-descriptor)
  (unless (functionp lisp-function)
    (setq lisp-function (require-type lisp-function 'function)))
  (unless (and (symbolp (setq name (function-name lisp-function)))
               ;Might as well err out now before do any _Newptr's...
               (not (constant-symbol-p name)))
    (report-bad-arg name '(and symbol (not (satisfies constantp)))))
  (let ((len (length %pascal-functions%)))
    (declare (fixnum len))
    (when (boundp name)
      (let ((descriptor (symbol-value name)))
        (dotimes (i len)
          (let ((pfe (%svref %pascal-functions% i)))
            (when (and (vectorp pfe)
                       (eql descriptor (pfe.routine-descriptor pfe)))
              ;; does this work to redefine a pascal function?
              (setq routine-descriptor (make-routine-descriptor i proc-info #$kPowerPCISA name))
              (setf (pfe.routine-descriptor pfe) routine-descriptor)
              #+ignore
              (unless (eql proc-info (pfe.proc-info pfe))
                (setf (pref (pref descriptor :RoutineDescriptor.routineRecords)
                            :RoutineRecord.procInfo)
                      proc-info
                      (pfe.proc-info pfe) proc-info))
              (setf (pfe.without-interrupts pfe) without-interrupts)
              (setf (pfe.lisp-function pfe) lisp-function)
              #+ignore
              (setq routine-descriptor descriptor))))))
    (unless routine-descriptor
      (let ((index (dotimes (i (length %pascal-functions%)
                               (let* ((new-len (+ len 5))
                                      (new-pf (make-array (the fixnum new-len))))
                                 (declare (fixnum new-len))
                                 (dotimes (i len)
                                   (setf (%svref new-pf i) (%svref %pascal-functions% i)))
                                 (do ((i len (1+ i)))
                                     ((>= i new-len))
                                   (declare (fixnum i))
                                   (setf (%svref new-pf i) nil))
                                 (setq %pascal-functions% new-pf)
                                 len))
                     (unless (%svref %pascal-functions% i)
                       (return i)))))
        (setq routine-descriptor 
              #-carbon-compat (make-routine-descriptor index proc-info)
              #+carbon-compat (make-routine-descriptor index proc-info #$kPowerPCISA name))
        (setf (%svref %pascal-functions% index)
              (%cons-pfe routine-descriptor proc-info lisp-function name without-interrupts)))))
  ;(%proclaim-special name)          ; already done by defpascal expansion
  (set name routine-descriptor)
  (record-source-file name 'defpascal)
  (when (and doc-string *save-doc-strings*)
    (set-documentation name 'variable doc-string))
  (when *fasload-print* (format t "~&~S~%" name))
  name)

#+ppc-target
(defun defpascal-callback-p (macptr)
  (let ((v %pascal-functions%))
    (dotimes (i (length v))
      (let ((pfe (%svref v i)))
        (when (and (vectorp pfe)
                   (eql macptr (pfe.routine-descriptor pfe)))
          (return pfe))))))


;; got a problem here
(defun upp-transition-vector (upp)
  #-carbon-compat
  (with-macptrs ((routine-record (pref upp :RoutineDescriptor.RoutineRecords)))
    (pref routine-record :RoutineRecord.procDescriptor))
  #+carbon-compat
  upp)

; This is called by .SPcallback
#+ppc-target
(defun %pascal-functions% (index args-ptr-fixnum)
  (declare (optimize (speed 3) (safety 0)))
  (let* ((pfe (svref %pascal-functions% index))
         (without-interrupts (pfe.without-interrupts pfe))
         (lisp-function (pfe.lisp-function pfe)))
    (if without-interrupts
      (without-interrupts (funcall lisp-function args-ptr-fixnum))
      (funcall lisp-function args-ptr-fixnum))))






