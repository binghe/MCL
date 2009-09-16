;; -*- Mode:lisp; Package:CCL; -*-

;;	Change History (most recent first):
;;  3 10/17/95 akh  no more advise restore-lisp-pointers
;;  2 5/18/95  slh  find-ff-trap and add-ff-trap dont die if *ff-traps* is nil
;;  (do not edit before this line!!)

;
; new-traps.lisp - non-level-1 trap & interface functions
; Copyright 1995 Digitool, Inc.

; Modification History
;

;; pass args from single-float records without consing
; fix spread-range-args to descend to base-types - in case we ever use it
;; -----5.2b4
;; remove kludge from expand-ff-trap
; ---- 5.2b2
; export *dont-use-cfm*
; add :sint8 and :uint8 to *type-keys* and *character-types*
;; ---- 5.2b1
; fix expand-ff-trap2 for one case of :long => :word,  :word
;; 12/27/05 handle traps not in carbon, add macho stuff
; fix has-range-arg and spread-range-args
; fix expand-ff-trap for :errchk and new interfaces where all traps are deftrap-inline,  deal with e.g. (#_invertrgn :ptr rgn)
;;  and (#_offsetrgn rgn :long xxx) => (#_offsetrgn rgn (point-h xxx)(point-v xxx))
; ------ 5.1 final
; 10/03/03 change boolean true from -1 to 1 in ff-type-coerced-args
; 09/15/03 akh expand-ff-trap deals with pointers spread
; ------- 5.0 final
; 09/02/99 akh ff-long-to-ostype from Terje N. - old one was truly brain dead
; --------- 4.3f1c1
; 05/02/96 bill  expand-ff-trap expands the old way if its string arg is NIL.
; -------------  MCL-PPC 3.9
; 03/11/96 bill  expand-ff-trap uses *memerror-traps* & *reserror-traps* to determine what code to
;                generate for error checking.
;                It also takes a new library arg specifying the shared library to look in for the trap.
;                deftrap-inline respects the new syntax for specifying shared library names.
;                It passes the shared library and the macro environment to expand-ff-trap.
; 03/06/96 bill  Get rid of misplaced bold fonts.
;                expand-ff-trap signals an error for too few as well as too many args,
;                and the error message is more informative.
;                Type check trap args. To do this, expand-ff-trap takes a new environment arg.
; 03/01/96 bill  expand-ff-trap generates (ff-call-slep ...) instead of (ppc-ff-call ...)
; 12/27/95 gb    inline-trap stuff #-ppc-target.
; 11/31/95 bill  expand-ff-trap no longer wraps VALUES around the generated code.
;                Doing so prevented the compiler from realizing that it could
;                stack cons pointer return values.
; 11/30/95 slh   recognize :check-error too
; 11/13/95 bill  expand-ff-trap no longer complains about "no implementation" for the ppc target.
; 11/09/95 gb    expand-ff-trap: _MemError returns an OSErr
; 11/08/95 bill  (require-trap #_memerror)
; 11/02/95 bill  expand-ff-trap generates (ppc-ff-call ...) if (ppc-target-p) is true.
;                It also converts args & results slightly differently for that case.
;                Change = to EQL in a few places so that it will inline.
;  6/09/05 slh   clear trap array after using it; no ime lap!
;  5/25/95 slh   new interfaces-2 mods.
;  5/16/95 slh   find-ff-trap, add-ff-trap, convert-ff-traps
;  5/10/95 slh   created from a file by Alan Ruttenberg & Mike Travers

(in-package :ccl)


(defmethod make-load-form ((macho-ep macho-entry-point) &optional env)
  (declare (ignore env))
  `(load-macho-entry-point ,(macho.name macho-ep) ,(macho.framework macho-ep)))


(declaim (special *ff-trap-pointer* *ff-trap-pointer-size*))

(defvar *ff-trap-save-pointer-array* nil
  "If we do a save-world, this gets the contents of the trap pointer to be restored in the next launch")

(defvar *variable-names-macro-arglists-shouldnt-use* '(t))

(defun bad-variable-name-replacement (name)
  (intern (format nil "VARIABLE-NAMED-~A" (string name)) 'traps))

#+ignore
(defun make-ff-trapwords (words)
  "This gets stored in the fasl file, as part of the load-time-value form. We add a couple of words per
   discussion with gb, so that the return address of the jsr doesn't pollute our argument stack."
  (let ((words `(10271 ; spop d4
                 ,@words
                 12036 20085))) ; spush d4 / rts
    (make-array (length words) :element-type '(unsigned-byte 16) :initial-contents words)))

;; calculate the pointer we are going to give to ff-call
#+ignore
(defmacro inline-trap-offset (name trapwords)
  `(%inc-ptr *ff-trap-pointer* (the fixnum (%car (load-time-value (register-fftrap ',name ,trapwords))))))

(defparameter *memerror-traps*
  (mapcar #'(lambda (x) (intern (string-upcase x) 'traps))
          '("_NewEmptyHandle" "_NewEmptyHandleSys" "_HLock" "_HUnlock" "_HPurge" "_HNoPurge"
            "_HLockHI" "_ReserveMem" "_ReserveMemSys"
            "_SetApplLimit"
            "_NewHandle" "_NewHandleSys" "_NewHandleClear" "_NewHandleSysClear"
            "_HandleZone""_RecoverHandle" "_RecoverHandleSys"
            "_NewPtr" "_NewPtrSys" "_NewPtrClear" "_NewPtrSysClear"
            "_PtrZone"
            "_MoveHHi" "_DisposePtr" "_SetPtrSize" "_DisposeHandle" "_SetHandleSize" "_ReallocateHandle"
            "_EmptyHandle" "_HSetRBit" "_HClrRBit" "_MoreMasters")))

(defparameter *reserror-traps*
  (mapcar #'(lambda (x) (intern (string-upcase x) 'traps))
          '("_RsrcZoneInit" "_CloseResFile" "_CreateResFile" "_OpenResFile" "_UseResFile"
            "_CountTypes" "_Count1Types" "_GetIndType" "_Get1IndType"
            "_CountResources" "_Count1Resources" "_GetIndResource" "_Get1IndResource"
            "_GetResource" "_Get1Resource" "_GetNamedResource" "_Get1NamedResource"
            "_LoadResource" "_ReleaseResource" "_DetachResource"
            "_UniqueID" "_Unique1ID" "_GetResAttrs"
            "_GetResInfo" "_SetResInfo" "_AddResource" "_GetResourceSizeOnDisk" "_GetMaxResourceSize"
            "_RsrcMapEntry" "_SetResAttrs" "_ChangedResource" "_RemoveResource" "_UpdateResFile"
            "_WriteResource" "_SetResPurge" "_GetResFileAttrs" "_SetResFileAttrs"
            "_OpenRFPerm" "_RGetResource" "_HOpenResFile" "_HOpenResFile" "_HCreateResFile" "_HCreateResFile"
            "_FSpOpenResFile" "_FSpCreateResFile"
            "_ReadPartialResource" "_WritePartialResource"
            "_SetResourceSize" "_SizeResource" "_MaxSizeRsrc" "_RmveResource")))

(defparameter *type-keys* '(:ptr :pointer :address :handle :long :word :unsigned-long :signed-long :sint32 :uint32
                            :signed-integer :signed-word :unsigned-word :unsigned-integer :sint16 :uint16
                            :char :character :sint8 :uint8 :single-float :double-float))

(defparameter *long-types* '(:long :unsigned-long :signed-long :point :sint32 :uint32))
(defparameter *word-types* '(:word :signed-integer :signed-word :unsigned-word :unsigned-integer :sint16 :uint16))
(defparameter *pointer-types* '(:ptr :pointer :handle :address))
(defparameter *character-types* '(:char :character :sint8 uint8))

(defun deftrap-type-match (a b)
  (let ((want-type (second b)))
    (or (eq a want-type)
        (cond ((memq a *pointer-types*) ;(:ptr :pointer :handle :address))  ;; oodles more
               (or (memq want-type *pointer-types*)(consp want-type))) 
              ((and (memq a *long-types*) (memq want-type *long-types*)))
              ((and (memq a *word-types*) (memq want-type *word-types*)))
              ((and (memq a *character-types*)(memq want-type *character-types*)))
              (t nil))))) ;"type mismatch ~S ~S" a want-type)))))

;; put this in level-2? - done
#+ignore
(defmacro with-stack-single-floats ((&rest vars) &body body &environment env)
  (multiple-value-bind (body decls) (parse-body body env)
    `(let* (,@(mapcar #'(lambda (v) `(,v  0.0s0)) vars))
       ,@decls
       (declare (single-float ,@vars)) 
       (declare (dynamic-extent ,@vars))
       ,@body)))

;; records whose contents are all single-floats 
(defparameter *single-float-contents-types* '(:cgrect :cgpoint :cgsize :ATSURGBAlphaColor :CGAffineTransform :nsrect :nspoint :nsSize))

(defun expand-ff-trap2 (name passed-args inlines inline-args return-type &optional can-errcheck? string library env)
  (cond ((member-if #'keywordp passed-args)
         (let ((had-errchk (member-if #'(lambda (arg)
                                          (memq arg *error-check-keywords*))
                                      passed-args))
               (preamble nil)
               (rdesc nil)
               (get-floats nil)
               (float-args nil))
           #+ignore ;; let expand-ff-trap deal with error more gracefully
           (when (and had-errchk (not can-errcheck?))
             (cerror "d" ":errchk not allowed for trap ~S" name))
           (when had-errchk 
             (setq passed-args (remove (car had-errchk) passed-args)))
           (when (member-if #'keywordp passed-args)
             (let ((res-args nil)
                   (n 0) did-it)
               (do ((x passed-args (cdr x)))
                   ((null x))
                 (setq did-it nil)
                 (cond ((and (keywordp (car x))(or (memq (car x) *long-types*)(memq (car x) *type-keys*)))
                        (let ((inline-arg (nth n inline-args)))
                          (if (not (deftrap-type-match (car x) inline-arg)) 
                            (cond ((and (memq (car x) *long-types*)(memq (cadr inline-arg) *word-types*))
                                   (let ((next-inline (nth (1+ N) inline-args)))                                     
                                     (cond 
                                      ((memq (cadr next-inline) *word-types*)
                                       (let* ((g0 (gensym))
                                              (g1 (gensym))
                                              (g2 (gensym))
                                              (let-args `((,g0 ,(second x))
                                                          (,g1 (point-h ,g0))
                                                          (,g2 (point-v ,g0)))))
                                         (setq preamble (nconc preamble let-args))
                                         (push g1 res-args)
                                         (push g2 res-args)                                           
                                         (setq did-it t)
                                         (incf n)  ;; <<
                                         (setq x (cdr x))
                                         ))
                                      (t (error "Type mismatch for argument ~s to trap ~A. Should be ~s, ~S provided."
                                                (car inline-arg) name (cadr inline-arg) (car x))))))
                                  (t (error "Type mismatch for argument ~s to trap ~A. Should be ~s, ~S provided."
                                            (car inline-arg) name (cadr inline-arg) (car x))))
                            (progn (setq x (cdr x))
                                   ))))
                       ((and (keywordp (car x)) (setq rdesc (find-record-descriptor (car x) nil)))
                        (let* ((field-types (find-base-field-types rdesc)))                          
                          (cond 
                           #+ignore
                           ((memq (car x) *single-float-contents-types*)
                            (let* ((accessors (find-base-accessors rdesc))
                                   (g0 (gensym))
                                   (let-args `((,g0 ,(second x)))))
                              (dolist (accessor accessors)
                                (let ((gen (gensym)))
                                  (setq get-floats (nconc get-floats `((%get-single-float ,g0 (get-field-offset ,accessor) ,gen))))
                                  (push gen res-args)
                                  (push gen float-args)
                                  ))
                              (setq preamble (nconc preamble let-args))
                              (setq did-it t)
                              (setq n (+ n (1- (length accessors))))
                              (setq x (cdr x)))
                            ;(cerror "a" "b")
                            )
                           ;; or maybe this?? instead of above
                           ((memq :single-float field-types)
                            (let* ((accessors (find-base-accessors rdesc))
                                   (g0 (gensym))
                                   (let-args `((,g0 ,(second x)))))
                              (dolist (accessor accessors)
                                (let ((gen (gensym)))
                                  (cond ((eq (car field-types) :single-float)
                                         (setq get-floats (nconc get-floats `((%get-single-float ,g0 (get-field-offset ,accessor) ,gen))))
                                         (push gen float-args))
                                        (t (setq let-args (nconc let-args `((,gen (pref ,g0 ,accessor)))))))
                                  (push gen res-args)
                                  (setq field-types (cdr field-types))))
                              (setq preamble (nconc preamble let-args))
                              (setq did-it t)
                              (setq n (+ n (1- (length accessors))))
                              (setq x (cdr x))))                                  
                           ((<= (length field-types)(- (length inline-args) n))
                            (do ((fts field-types (cdr fts))
                                 (inlines (nthcdr n inline-args)(cdr inlines)))
                                ((null fts))
                              (when (not (deftrap-type-match (car fts)(car inlines)))(error "hooey")))
                            (let* ((accessors (find-base-accessors rdesc))
                                   (g0 (gensym))
                                   (let-args `((,g0 ,(second x)))))
                              (dolist (accessor accessors)
                                (let ((gen (gensym)))
                                  (setq let-args (nconc let-args `((,gen (pref ,g0 ,accessor)))))
                                  (push gen res-args)))
                              ;(cerror "a" "b")
                              (setq preamble (nconc preamble let-args))
                              (setq did-it t)
                              (setq n (+ n (1- (length accessors))))
                              (setq x (cdr x))))))))
                          
                 (if (null x)(return))
                 (if (not did-it)(push (car x) res-args))
                 (incf n))             
               (setq passed-args (nreverse res-args))))
           ;(cerror "e" "f")
           (if had-errchk (setq passed-args (append passed-args (list :errchk))))  ;; we like :errchk last
           (let ((the-call
                  (expand-ff-trap name passed-args inlines inline-args return-type can-errcheck? string library env)))
             (if (not preamble) the-call
                 (if (not float-args)
                   `(let* ,preamble ,the-call)
                   `(let* ,preamble
                      (with-stack-single-floats ,(nreverse float-args)
                        ,@get-floats
                        ,the-call)))))))
        
        (t (expand-ff-trap name passed-args inlines inline-args return-type can-errcheck? string library env))))

(defun find-base-field-types (record-desc)
  (let* ((fields (record-descriptor-fields record-desc))
         (types nil))
    (dotimes (i (length fields))
      (let ((field-type (field-descriptor-type (elt fields i))))
        (if (memq field-type *type-keys*)
          (setq types (nconc types (list field-type)))
          (let ((sub-desc (find-record-descriptor field-type nil)))
            (cond (sub-desc
                   (let ((sub-types (find-base-field-types sub-desc)))
                     (setq types (nconc types sub-types))))
                  (t (error "Unknown type or record ~S" field-type)))))))
    types))

(defun find-base-accessors (record-desc &optional thing-name)
  (let ((name (or thing-name (record-descriptor-name record-desc)))
        (fields (record-descriptor-fields record-desc))
        (accessors nil))
    (dotimes (i (length fields))
      (let* ((field (elt fields i))
             (field-type (field-descriptor-type field))) 
        (if (memq field-type *type-keys*)
          (setq accessors (nconc accessors (list (make-keyword (%str-cat (string name) "." (string (field-descriptor-name field)))))))
          (let ((sub-desc (find-record-descriptor field-type nil)))
            (cond (sub-desc
                   (let* ((sub-desc-name (field-descriptor-name field)) 
                          (sub-accessors (find-base-accessors sub-desc sub-desc-name)))
                     ;(print sub-desc-name)
                     (do ((x sub-accessors (cdr x)))
                         ((null x))
                       (rplaca x (make-keyword (%str-cat (string name) "." (string (car x))))))
                     (setq accessors (append accessors sub-accessors))))
                  (t (error "Unknown type or record ~S" field-type)))))))
    accessors))
          
    
    
   

(defparameter *dont-use-cfm* t)
(export '*dont-use-cfm*)

;this function does the expansion of a trap call inside code.
(defun expand-ff-trap (name passed-args inlines inline-args return-type &optional can-errcheck? string library env &aux c? do-memerr?)
  "To summarize, we add the ff-traps pointer with with the car of the ff-trap entry (so
   that we can update it at load time). Then call the trap.
   Args come in in the form which the pascal reader gives them to us, i.e. as pairs of   name and mactype. Return-type is a mactype as well."
  (declare (ignore-if-unused inlines c?))
  #+ignore
  (when (eq (car inlines) :c) (setq c? t inlines (cdr inlines)))
    
  (let* ((ppc-target-p (ppc-target-p))
         (c-type-coercion? t)) ;(if ppc-target-p t c?)))
    #+ignore
    (when (and (null inlines) (not ppc-target-p))
      (format t "~&;; Warning: Trap ~a has no defined implementation~&" name)
      (return-from expand-ff-trap `(error "Trap ~a has no defined-implementation" ',name)))
    
    (when (member :no-errchk passed-args)
      (setq passed-args (remove :no-errchk passed-args)))

    (when (member-if #'(lambda (arg)
                         (memq arg *error-check-keywords*))
                     passed-args)
      (setq passed-args (remove-if #'(lambda (arg) (memq arg *error-check-keywords*)) passed-args))
      (setq do-memerr? t))

    (when (and (not can-errcheck?) do-memerr?)
      (format t "~&;; :errchk keyword wrongly found in ~a. Ignoring.~&" name))
    
    (let ((passed-length (length passed-args))
          (inline-length (length inline-args)))
      (declare (fixnum passed-length inline-length))
      (when (> passed-length inline-length)
        (error "Too many args in trap call:~%~a" `(,name ,@passed-args)))
      (when (< passed-length inline-length)
        (error "Too few args in trap call:~%~a" `(,name ,@passed-args))))

    (let* ((constants-checked
            (mapcar #'(lambda (arg trap-arg &aux ct-check)
                        (if (and (constantp arg)                                 
                                 (setq ct-check
                                       (mactype-ct-type-check 
                                        (find-arg-mactype (cadr trap-arg)))))                            
                          (if (funcall ct-check (eval arg))
                            t
                            (error "Argument ~s (~s) to trap ~a is not of type ~s"
                                   arg (car trap-arg) name (cadr trap-arg)))
                          nil))
                    passed-args inline-args))
           (arg-vars (mapcar #'(lambda (x) (declare (ignore x)) (gensym)) passed-args))
           (rt-type-check-code (expand-trap-rt-type-check constants-checked
                                                          (mapcar #'(lambda (var trap-arg)
                                                                      (cons var (cadr trap-arg)))
                                                                  arg-vars inline-args)
                                                          env))
           (inside-args (if rt-type-check-code arg-vars passed-args))
           (PREAMBLE)
           get-floats
           float-args
           (type-coerced-args (ff-type-coerced-args inside-args inline-args c-type-coercion?)))
      (when (has-range-arg inline-args)
        (multiple-value-setq (preamble type-coerced-args inline-args float-args get-floats)
          (spread-range-args type-coerced-args inline-args)))
      (LET ((form (if (and ppc-target-p string)
                    (let ((slep (if *dont-use-cfm* ; (not (gethash string (shared-library-entry-points)))) 
                                  nil
                                  (get-shared-library-entry-point string nil nil t))))
                      (when (and nil slep (not (slep.address slep)))  ;; <<
                        (let ((addr (ignore-errors (resolve-slep-address slep))))
                          (when (null addr)   ;; there were some bad sleps left over from another era?
                            ;(print (list 'cow string slep))
                            (setf (gethash string *shared-library-entry-points*) nil)
                            (setq slep nil))))
                      (let ((out-return-type (if return-type
                                               (let ((mactype (find-mactype return-type nil)))
                                                 (cond (mactype
                                                        (mactype=>ppc-ff-call-type mactype))
                                                       (t
                                                        (let* ((record-desc (find-record-descriptor return-type nil))
                                                               (length (if record-desc (record-descriptor-length record-desc))))
                                                          ;; sort of a special case for #_findscriptrun which returns :scriptrunstatus which is a "record" of 2 bytes
                                                          ;; but the hack for record returns will screw this up!
                                                          (if (eq length 2)
                                                            (progn 
                                                              (setq return-type :sint16)
                                                              (mactype=>ppc-ff-call-type :sint16))
                                                            (if (eq length 4)
                                                              (progn 
                                                                (setq return-type :sint32)
                                                                (mactype=>ppc-ff-call-type :sint32))
                                                                ;; let it error
                                                              (find-mactype return-type))))))) 
                                               :void)))
                        (if (not slep)
                          ;; why do we get a double-float result when it should be single-float?? (#_cgrectgetmaxx 1.0s0 1.0s0 2.0s0 2.0s0) - fixed
                          ;; can also say (#_cgrectgetmaxx :cgpoint foo :cgsize bar) => (#_cgrectgetmaxx (pref foo :cgpoint.x)(pref foo :cgpoint.y)(pref bar :cgsize.width)(pref bar :cgsize.height))
                          ;; or (#_cgrectgetmaxx :cgrect blitz) => (#_cgrectgetmaxx (pref blitz :cgrect.origin.x)(pref blitz :cgrect.origin.y) (pref blitz :cgrect.size.width) ...)
                          `(ppc-ff-call (macho-address ,(get-macho-entry-point string))
                                        ,@(ppc-ff-keywordized-arglist type-coerced-args inline-args)
                                        ,out-return-type)                       
                          `(ff-call-slep ,(get-shared-library-entry-point string library)
                                         ,@(ppc-ff-keywordized-arglist type-coerced-args inline-args)
                                         ,out-return-type))))
                    (error "shouldn't")
                    #+ignore
                    (let ((trapwords (make-ff-trapwords inlines)))
                      `(ff-call (inline-trap-offset ,name ,trapwords)
                                ,@(ff-keywordized-arglist type-coerced-args inline-args c?)
                                ,(if return-type (if c? :d0 (mactype-ff-type (find-mactype return-type))) :novalue)
                                ))
                    )))
        ;(cerror "a" "b")
        (when preamble
          (if (not float-args)
            (setq form `(let ,preamble
                          ,form))
            (setq form `(let* ,preamble
                          (with-stack-single-floats ,float-args
                            ,@get-floats
                            ,form)))))
        (when return-type
          (setq form
                (if c-type-coercion? 
                  (coerced-c-result form return-type ppc-target-p)
                  (coerced-pascal-result form return-type))))
        (when rt-type-check-code ;; this is now broken I think - actually always was brain damaged - usually/always NIL
          (setq form `(let ,(mapcar 'list arg-vars passed-args)
                        (declare (dynamic-extent ,@arg-vars))
                        ,@rt-type-check-code ,form)))
        (if do-memerr?
          (cond ((memq name *memerror-traps*)
                 `(memerror-check ,form))
                ((memq name *reserror-traps*)
                 `(reserror-check ,form))
                (t `(errchk ,form)))
          form)))))

;; this no longer applicable?
(defun has-range-arg (x)
  (dolist (arg x nil)
    (let ((type (second arg)))
      (if (and (not (consp type))(not (find-mactype type nil)) (find-record-descriptor type nil))
        (return t)))))

(defun spread-range-args (passed-args inline-args)
  (let ((preamble nil)
        (passed-out)
        (inline-out)
        float-args
        get-floats)
    (dotimes (i (length passed-args))
      (let* ((arg (nth i passed-args))
             (inline-arg (nth i inline-args))
             (type (second inline-arg))
             )
        (if (or (consp type)(find-mactype type nil))
          (progn
            (setq inline-out (nconc inline-out (list inline-arg)))
            (setq passed-out (nconc passed-out (list arg))))
          (let ((desc (find-record-descriptor type nil)))
            (if (not desc)(error "confused"))
            (when desc
              (let* ((field-types (find-base-field-types desc))
                     (accessors (find-base-accessors desc)))
                (cond 
                 ((memq :single-float field-types) ;(memq type *single-float-contents-types*)
                  (let ((v (gensym)))
                    (setq preamble (nconc preamble `((,v ,arg))))
                    (dolist (field-type field-types)                      
                      (let ((gen (gensym))
                            (field-accessor (car accessors)))
                        (setq inline-out (nconc inline-out (list `(foo ,field-type))))
                        (setq passed-out (nconc passed-out (list gen)))
                        (cond ((eq field-type :single-float)                               
                               (setq get-floats (nconc get-floats `((%get-single-float ,v (get-field-offset ,field-accessor) ,gen))))
                               (push gen float-args))
                              (t (setq preamble (nconc preamble `((,gen (pref ,v ,field-accessor)))))))
                      (setq accessors (cdr accessors))))))                     
                 (t 
                  (let ((v (gensym)))
                    (setq preamble (nconc preamble `((,v ,arg))))
                    (dolist (field-type field-types)
                      (let ((field-accessor (car accessors)))
                        (setq inline-out (nconc inline-out (list `(foo ,field-type))))  
                        (setq passed-out (nconc passed-out (list `(pref ,v ,field-accessor)))))
                      (setq accessors (cdr accessors))))))))))))
      
    ;(cerror "a" "b")
    (values preamble passed-out inline-out (nreverse float-args) get-floats)))
  
; Uh, A) this is undoubtedly defined elsewhere and B) isn't reentrant.
#|
;; and is much worse than that if the keyword ain't already there!!!
(defvar *ff-ostype-string* (make-string 4 :element-type 'base-character))

(defun ff-long-to-ostype (long)
  (let ((string *ff-ostype-string*))
    (setf (aref string 0) (%code-char (ldb (byte 8 24) long)))
    (let ((rest (logand long #xffffff)))
      (declare (fixnum rest))
      (declare (optimize (speed 3) (safety 0)))
      (setf (aref string 1) (%code-char (ldb (byte 8 16) rest)))
      (setf (aref string 2) (%code-char (ldb (byte 8 8) rest)))
      (setf (aref string 3) (%code-char (ldb (byte 8 0) rest))))
    (intern string :keyword)))
|#
; UH, this is more sensible
(defun ff-long-to-ostype (long)
  (rlet ((ptr :ostype long))
    (%get-ostype ptr)))
         
;; in C, everything is returned in d0. I assume that shorter elements will be returned 
;; intact by ff-call. I need only to worry about pointer and character types.
(defun coerced-c-result (return-arg return-type &optional dont-convert-pointers)
  (let ((it-be (case (mactype-name (find-mactype return-type))
                 ((:ptr :pointer) (if dont-convert-pointers return-arg `(%int-to-ptr ,return-arg)))
                 (:character `(code-char ,return-arg))
                 (:boolean `(not (eql ,return-arg 0)))
                 (:ostype `(ff-long-to-ostype ,return-arg))
                 (otherwise return-arg))))
    (assert it-be () "Didn't find a ff-type for ~a" return-type)
    it-be))

;; In pascal, I need to worry about functions which return 8 bit values,
;; since the 8 bits will be in the top word of the 
(defun coerced-pascal-result (return-arg return-type)
  (case (mactype-name (find-mactype return-type))
    (:character `(code-char (ash ,return-arg -8)))
    (:boolean `(not (eql (ash ,return-arg -8) 0)))
    (:unsigned-byte `(ldb (byte 8 8) ,return-arg))
    (:signed-byte (let ((temp (gensym)))
                    `(let ((,temp (ldb (byte 8 8) ,return-arg)))
                       (if (> ,temp 128) (- ,temp 256) ,temp))))
    (otherwise return-arg)))

#+ignore
(defun ff-keywordized-arglist (passed-args inline-args c?)
  (loop for (nil type) in (if c? (reverse inline-args) inline-args)
        for passed in (if c? (reverse passed-args) passed-args)
        for ff-argtype = (or (mactype-ff-type (find-mactype type)) :ptr)        ; slh added (or .. ptr)
        do (when (and c? (unless (eq ff-argtype :ptr) (setq ff-argtype :long))))
        collect ff-argtype collect passed))

(defun ppc-ff-keywordized-arglist (passed-args inline-args)
  (loop for (nil type) in inline-args
        for passed in passed-args
        for ff-argtype = (let ((mt (find-mactype type nil)))
                           (if mt (mactype=>ppc-ff-call-type mt)
                               (error "unknown type ~S" type)
                               ;(return-from ppc-ff-keywordized-arglist (keywordized-arglist-hairy passed-args inline-args))
                               ))
        collect ff-argtype collect passed))               
               

(defun ff-type-coerced-args (args inline-args c?)
  (loop for arg in args
        for (nil rawtype) in inline-args
        for type = (find-mactype rawtype nil)
        collect 
        (if (and type (eql (mactype-record-size type) 1))
          (case (mactype-name type)
            (:unsigned-byte (if c? arg `(ash (logand #xff ,arg) 8)))
            (:boolean `(if ,arg 1 0))          ; #$true #$false -- changing -1 to 1 busts something? seems OK
            (:signed-byte (if c? arg
                              (let ((temp (gensym)))
                                `(let ((,temp (ldb (byte 8 0) ,arg)))
                                   (if (> ,temp 128) 
                                     (- (ash ,temp 8) #xffff)
                                     (ash ,temp 8))))))
            (:character (if c? `(char-code ,arg) `(ash (char-code ,arg) 8)))
            (otherwise arg))
          arg)))

(defun can-do-errcheck-keyword? (name args return-type inlines)
  (declare (ignore name args return-type))
  (or (null inlines) (not (eq (car inlines) :c))))

;; The source is translated into this macro unless there is an aptimized translator


(defmacro deftrap-inline (name args return-type inlines &key allow-errchk?)
  (multiple-value-bind (name string-spec) (make-trap-symbol name)
    (multiple-value-bind (string library) (trap-string-and-library string-spec t)
      (loop for argspec in args
            do 
            (when (memq (car argspec) *variable-names-macro-arglists-shouldnt-use*)
              (setf (car argspec) (bad-variable-name-replacement (car argspec)))))
      (let ((env-var (gensym))
            (args-var (gensym)))
        `(progn
           (setf (gethash ',name %trap-strings%) ',string-spec)
           (defmacro ,name (&environment ,env-var &rest ,args-var)
             (declare (ignore-if-unused errchk?))
             (expand-ff-trap2 ',name ,args-var 
                             ',inlines ',args ',return-type ,allow-errchk? ,string ,library ,env-var)))))))

;;****************************************************************
;; Save and load world...
;; The strategy is to save the pointer to an array when save-world, and restore the pointer 
;; from the array when we restart a world. I was going to use a resource, except I didn't know
;; how to add the resource to only the newly saved word.
;;
;; we have a timing issue here here. If system code uses traps stored in the ff-pointer
;; during the restart sequence then we have to make it an early priority to set this up.
;; I'm not sure how to make this happen early enough.

; now called from kill-lisp-pointers on 68K; not used at all on PPC.



#|
(advise restore-lisp-pointers (initialize-ff-traps-pointer)
        :when :before)

; Do this in save-application, it's not necessary for just quitting
;(pushnew 'save-trap-pointer-to-array *lisp-cleanup-functions*)

(advise record-descriptor-storage
        (when (eq (car values) :handle)
          (warn "Relying on ~A records to have a default storage type of :handle is not recommended." (record-descriptor-name (car arglist))))
        :when :after
        :name :interfaces-2)
|#

; End of new-traps.lisp
