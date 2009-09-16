;;;-*- Mode: Lisp; Package: CCL -*-

;; $Log: vreg.lisp,v $
;; Revision 1.2  2002/11/18 05:37:08  gtbyers
;; Add CVS log marker
;;
;;	Change History (most recent first):
;;  3 10/14/95 gb   Don't remember.
;;  2 10/6/95  gb   Delete some unused things.
;;  (do not edit before this line!!)


; 02/13/97 bill  from Gary: *lcell-freelist* and *lreg-freelist* are now defvar'd, not defloadvar'd.
; 02/01/97 gb lcells, lregs.
; ---- 4.0
; 06/13/96 gb typo in WITH-FP-TARGET; add WITH-CRF-TARGET.
; ---- 3.9
; 03/10/96 gb FP temps
; 01/10/96 gb less bignum consing with temp reg masks.
; 12/27/95 gb split ppc-node-reg-p off from ENSURING-NODE-TARGET.
; 11/11/95 gb support for ENSURING-NODE-TARGET mechanism.

(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (ccl::require "PPC-ARCH"))

(in-package "CCL")

(defvar *logical-register-counter* -1)

(defvar *lreg-freelist* (%cons-pool))

(defstruct (lreg
            (:print-function print-lreg)
            (:constructor %make-lreg))
  (value nil :type t)                   ; physical reg or frame address or ...
  (id (incf (the fixnum *logical-register-counter*)) :type fixnum)                   ; for printing
  (class 0 :type fixnum)                ; target storage class: GPR, FPR, CRF ...
  (mode 0 :type fixnum)                 ; mode (:u8, :address, etc)
  (type 0 :type fixnum)                 ; type
  (defs () :type list)                  ; list of vinsns which assign to this reg
  (refs () :type list)                  ; list of vinsns which reference this vreg
  (conflicts () :type list)             ; other lregs which can't map to the same physical reg
  (wired t :type boolean)               ; when true, targeted value must be preserved.
)

(defun free-lreg (l)
  (without-interrupts                   ; explicitly
   (let* ((p *lreg-freelist*))
     (setf (lreg-value l) (pool.data p)
           (pool.data p) l)
     nil)))

(defun alloc-lreg ()
  (let* ((p *lreg-freelist*))
    (without-interrupts 
     (let* ((l (pool.data p)))
       (when l 
         (setf (pool.data p) (lreg-value l))
         (setf (lreg-defs l) nil
               (lreg-refs l) nil
               (lreg-conflicts l) nil
               (lreg-id l) (incf *logical-register-counter*)
               (lreg-wired l) t)
         l)))))

(defun make-lreg (value class mode type wired)
  (let* ((l (alloc-lreg)))
    (cond (l
           (setf (lreg-value l) value
                 (lreg-class l) class
                 (lreg-type l) type
                 (lreg-mode l) mode
                 (lreg-wired l) wired)           
           l)
          (t (%make-lreg :value value :class class :type type :mode mode :wired wired)))))
 

(defun print-lreg (l s d)
  (declare (ignore d))
  (print-unreadable-object (l s :type t)
    (format s "~d" (lreg-id l))
    (let* ((value (lreg-value l))
           (class (lreg-class l)))
      (format s " ~a "
              (case class
                (#.ppc::hard-reg-class-fpr "FPR")
                (#.ppc::hard-reg-class-gpr "GPR")
                (#.ppc::hard-reg-class-crf "CRF")
                (t  (format nil "class ~d" class))))
      (when value
        (format s (if (lreg-wired l) "[~s]" "{~s}") value)))))

(defvar *lcell-freelist* (%cons-pool))
(defvar *next-lcell-id* -1)

(defstruct (lcell 
            (:print-function print-lcell)
            (:constructor %make-lcell (kind parent width attributes info)))
  (kind :node)         ; for printing
  (id (incf (the fixnum *next-lcell-id*)) :type fixnum)                          ; 
  (parent nil)                          ; backpointer to unique parent
  (children nil)                        ; list of children
  (width 4)                             ; size in bytes or NIL if deleted
  (offset nil)                          ; sum of ancestor's widths or 0, NIL if deleted
  (refs nil)                            ; vinsns which load/store into this cell
  (attributes 0 :type fixnum)           ; bitmask
  (info nil))                           ; whatever

(defun print-lcell (c s d)
  (declare (ignore d))
  (print-unreadable-object (c s :type t)
    (format s "~d" (lcell-id c))
    (let* ((offset (lcell-offset c)))
      (when offset
        (format s "@#x~x" offset)))))

(defun free-lcell (c)
  (without-interrupts                   ; explicitly
   (let* ((p *lcell-freelist*))
     (setf (lcell-kind c) (pool.data p)
           (pool.data p) c)
     nil)))

(defun alloc-lcell (kind parent width attributes info)
  (let* ((p *lcell-freelist*))
    (without-interrupts 
     (let* ((c (pool.data p)))
       (when c 
         (setf (pool.data p) (lcell-kind c))
         (setf (lcell-kind c) kind
               (lcell-parent c) parent
               (lcell-width c) width
               (lcell-attributes c) (the fixnum attributes)
               (lcell-info c) info
               (lcell-offset c) nil
               (lcell-refs c) nil
               (lcell-children c) nil
               (lcell-id c) (incf *next-lcell-id*))
         c)))))

(defun make-lcell (kind parent width attributes info)
  (let* ((c (or (alloc-lcell kind parent width attributes info)
                (%make-lcell kind parent width attributes info))))
    (when parent (push c (lcell-children parent)))
    c))
 
; Recursively calculate, but don't cache (or pay attention to previously calculated offsets) 
(defun calc-lcell-offset (c)
  (if c
    (let* ((p (lcell-parent c)))
      (if (null p)
        0
        (+ (calc-lcell-offset p) (or (lcell-width p) 0))))
    0))

; A cell's "depth" is its offset + its width
(defun calc-lcell-depth (c)
  (if c 
    (+ (calc-lcell-offset c) (or (lcell-width c) 0))
    0))

; I don't know why "compute" means "memoize", but it does.
(defun compute-lcell-offset (c)
  (or (lcell-offset c)
      (setf (lcell-offset c)
            (let* ((p (lcell-parent c)))
              (if (null p)
                0
                (+ (compute-lcell-offset p) (or (lcell-width p) 0)))))))

(defun compute-lcell-depth (c)
  (if c
    (+ (compute-lcell-offset c) (or (lcell-width c) 0))
    0))



                    

(defparameter *spec-class-storage-class-alist*
  `((:lisp . ,ppc::storage-class-lisp)
    (:imm . ,ppc::storage-class-imm)
    (:wordptr . ,ppc::storage-class-wordptr)
    (:u8 . ,ppc::storage-class-u8)
    (:s8 . ,ppc::storage-class-s8)
    (:u16 . ,ppc::storage-class-u16)
    (:s16 . ,ppc::storage-class-s16)
    (:u32 . ,ppc::storage-class-u32)
    (:s32 . ,ppc::storage-class-s32)
    (:address . ,ppc::storage-class-address)
    (:single-float . ,ppc::storage-class-single-float)
    (:double-float . ,ppc::storage-class-double-float)
    (:pc . ,ppc::storage-class-pc)
    (:locative . ,ppc::storage-class-locative)
    (:crf . ,ppc::storage-class-crf)
    (:crbit . ,ppc::storage-class-crbit)
    (:crfbit . ,ppc::storage-class-crfbit)
    (t . nil)))
    
(defun spec-class->storage-class (class-name)
  (or (cdr (assoc class-name *spec-class-storage-class-alist* :test #'eq))
      (error "Unknown storage-class specifier: ~s" class-name)))

(defmacro make-mask (&rest weights)
  `(logior ,@(mapcar #'(lambda (w) `(ash 1 ,w)) weights)))

(defconstant ppc-temp-node-regs 
  (make-mask ppc::temp0
             ppc::temp1
             ppc::temp2
             ppc::temp3
             ppc::arg_x
             ppc::arg_y
             ppc::arg_z))

(defconstant ppc-nonvolatile-node-regs
  (make-mask ppc::save0
             ppc::save1
             ppc::save2
             ppc::save3
             ppc::save4
             ppc::save5
             ppc::save6
             ppc::save7))


(defconstant ppc-node-regs (logior ppc-temp-node-regs ppc-nonvolatile-node-regs))

(defconstant ppc-imm-regs (make-mask
                            ppc::imm0
                            ppc::imm1
                            ppc::imm2
                            ppc::imm3
                            ppc::imm4))

(defconstant ppc-temp-fp-regs (1- (ash 1 ppc::fp14)))
                               
(defconstant ppc-cr-fields
  (make-mask 0 (ash 4 -2) (ash 8 -2) (ash 12 -2) (ash 16 -2) (ash 20 -2) (ash 24 -2) (ash 28 -2)))

(defparameter *ppc-node-temps* ppc-temp-node-regs)
(defparameter *ppc-imm-temps* ppc-imm-regs)
(defparameter *ppc-crf-temps* ppc-cr-fields)
(defparameter *ppc-fp-temps* ppc-temp-fp-regs)

(defun ppc-use-node-temp (n)
  (declare (fixnum n))
  (if (logbitp n ppc-temp-node-regs)
    (setq *ppc-node-temps* (logand *ppc-node-temps* (lognot (ash 1 n)))))
  n)

(defun ppc-use-imm-temp (n)
  (declare (fixnum n))
  (setq *ppc-imm-temps* (logand *ppc-imm-temps* (lognot (ash 1 n))))
  n)

(defun ppc-use-crf-temp (n)
  (declare (fixnum n))
  (setq *ppc-crf-temps* (logand *ppc-crf-temps* (lognot (ash 1 (ash n -2)))))
  n)

(defun ppc-select-node-temp ()
  (let* ((mask *ppc-node-temps*))
    (dotimes (bit 32 (error "Bug: ran out of node temp registers."))
      (when (logbitp bit mask)
        (setq *ppc-node-temps* (bitclr bit mask))
        (return bit)))))

(defun ppc-select-imm-temp (&optional (mode-name :u32))
  (let* ((mask *ppc-imm-temps*))
    (dotimes (bit 32 (error "Bug: ran out of imm temp registers."))
      (when (logbitp bit mask)
        (setq *ppc-imm-temps* (bitclr bit mask))
        (return (ppc::set-regspec-mode bit (ppc-gpr-mode-name-value mode-name)))))))

(defun ppc-available-imm-temp (mask &optional (mode-name :u32))
  (dotimes (bit 32 (error "Bug: ran out of imm temp registers."))
    (when (logbitp bit mask)
      (return (ppc::set-regspec-mode bit (ppc-gpr-mode-name-value mode-name))))))

(defun ppc-available-node-temp (mask)
  (dotimes (bit 32 (error "Bug: ran out of node temp registers."))
    (when (logbitp bit mask)
      (return bit))))

(defun ppc-available-fp-temp (mask &optional (mode-name :double-float))
  (dotimes (bit 32 (error "Bug: ran out of node fp registers."))
    (when (logbitp bit mask)
      (let* ((mode (if (eq mode-name :double-float) 
                     ppc::hard-reg-class-fpr-mode-double
                     ppc::hard-reg-class-fpr-mode-single)))
        (return (ppc::make-hard-fp-reg bit mode))))))


(defun ppc-node-reg-p (reg)
  (and (= (ppc::hard-regspec-class reg) ppc::hard-reg-class-gpr)
       (logbitp (the fixnum (ppc::hard-regspec-value reg))
                ppc-node-regs)))
    
(defun ppc-ensure-node-target (reg)
  (if (ppc-node-reg-p reg)
    reg
    (ppc-available-node-temp *ppc-node-temps*)))


(defun ppc-select-crf-temp ()
  (let* ((mask *ppc-crf-temps*))
    (dotimes (bit 8 (error "Bug: ran out of CR fields."))
      (declare (fixnum bit))
      (when (logbitp bit mask)
        (setq *ppc-crf-temps* (bitclr bit mask))
        (return (ppc::make-hard-crf-reg (the fixnum (ash bit 2))))))))


(defparameter *ppc-mode-name-value-alist*
  '((:lisp . 0)
    (:u32 . 1)
    (:s32 . 2)
    (:u16 . 3)
    (:s16 . 4)
    (:u8 . 5)
    (:s8 . 6)
    (:address . 7)))

(defun ppc-gpr-mode-name-value (name)
  (or (cdr (assq name *ppc-mode-name-value-alist*))
      (error "Unknown gpr mode name: ~s" name)))

(defvar *ppc-reg-class-members*
  (vector
   ppc-node-regs
   (logior ppc-node-regs ppc-imm-regs)
   ppc-imm-regs
   ppc-imm-regs
   ppc-imm-regs
   ppc-imm-regs
   ppc-imm-regs
   ppc-imm-regs
   ppc-imm-regs))
   
   
(defun vreg-ok-for-storage-class (vreg sclass)
  (declare (ignore vreg sclass))
  t)



(defparameter *vreg-specifier-constant-constraints*
  `((:u8const . ,(specifier-type '(unsigned-byte 8)))
    (:u16const . ,(specifier-type '(unsigned-byte 16)))
    (:u32const . ,(specifier-type '(unsigned-byte 32)))
    (:s8const . ,(specifier-type '(signed-byte 8)))
    (:s16const . ,(specifier-type '(signed-byte 16)))
    (:s32const . ,(specifier-type '(signed-byte 32)))
    (:lcell . ,(specifier-type 'lcell))))

(defun match-vreg-value (vreg value)
  (declare (ignore-if-unused vreg value))
  ;(format t "~&vreg = ~s, value = ~s" vreg value)
  t)

(defun match-vreg-constraint (constraint vreg template valvect n)
  (let* ((res&args (vinsn-template-results&args template))
         (target (cadr constraint))
         (matchspec (assq target res&args))
         (matchpos (if matchspec (position matchspec res&args))))
    (unless matchpos
      (warn "Unknown template vreg name ~s in constraint ~s." target constraint))
    (unless (< matchpos n)
      (warn "Forward-referenced vreg name ~s in constraint ~s." target constraint))
    (let* ((target-val (svref valvect matchpos)))
      (unless (ecase (car constraint) (:eq (eq vreg target-val)) (:ne (neq vreg target-val)))
        (warn "~& use of vreg ~s conflicts with value already assigned ~
               to ~s wrt constraint ~s ." vreg (car matchspec) constraint)))))


  
(defun match-vreg (vreg spec vinsn vp n)
  (declare (fixnum n))
  (let* ((class (if (atom spec) spec (car spec)))
         (value (if (atom spec) nil (cadr spec)))
         (template (vinsn-template vinsn))
         (result-p (< n (the fixnum (length (vinsn-template-result-vreg-specs template))))))
    (let* ((spec-class (assoc class *spec-class-storage-class-alist* :test #'eq)))
      (if spec-class
        (let* ((vreg-value (ppc::hard-regspec-value vreg)))
          (if (typep vreg 'fixnum) 
            (setq vreg vreg-value)
            (if (typep vreg 'lreg)
              (if result-p
                (pushnew vinsn (lreg-defs vreg))
                (pushnew vinsn (lreg-refs vreg)))
              (error "Bad vreg: ~s" vreg)))
          (case class
            (:crf (ppc-use-crf-temp vreg-value))
            ((:u8 :s8 :u16 :s16 :u32 :s32 :address) (ppc-use-imm-temp vreg-value))
            (:imm
             (if (logbitp vreg-value ppc-imm-regs)
               (ppc-use-imm-temp vreg-value)
               (ppc-use-node-temp vreg-value)))
            (:lisp (ppc-use-node-temp vreg-value)))
          (unless (or (eq class 't) (vreg-ok-for-storage-class vreg class))
            (warn "~s was expected to have storage class matching specifier ~s" class))
          (when value
            (if (atom value)
              (match-vreg-value vreg-value value)
              (match-vreg-constraint value vreg-value template vp n))))
        (if (eq class :label)
          (progn
            (unless (typep vreg 'vinsn-label)
              (error "Label expected, found ~s." vreg))
            (push vinsn (vinsn-label-refs vreg)))
          (let* ((ctype (cdr (assoc class *vreg-specifier-constant-constraints* :test #'eq))))
            (unless ctype (error "Unknown vreg constraint : ~s ." class))
            (unless (ctypep vreg ctype)
              (error "~S : value doesn't match constraint ~s in template for ~s ." vreg class (vinsn-template-name template)))))))
    vreg))
    
(ccl::provide "VREG")
