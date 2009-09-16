; -*- Mode:Lisp; Package:CCL; -*-

;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;Foreign function support. New & improved!
;
;This file needs a full CCL to compile (uses setf, defstruct, probably doesn't
; need to).

; Modification History
;
; akh fix %float2x !
; ------- 4.4b5
; no go if OSX re (%currenta5)
; akh 01/10/02 akh lose lots of %i+ and %i- in case memory size is bignum
;; --------- 4.4b2 - but forget it for 4.4  (%currenta5) -  maybe works with 4.3.1
; 3/27/96 bill  PPC versions of %x2float and friends.
; 3/26/96 bill  Use :check-error for #_DisposePtr again (it works now).
;               (#_FlushCodeCache) -> (flush-code-cache), which executes the trap from the emulator
;               PPC version of %put-double & %get-double
; 3/22/96 slh   ppc-ified (from Dylan)
; 1/23/96 slh   ff-string: say 'base-character
; 8/25/95 slh   export deffcfun-881
;04/04/94 bill deffcfun-881 to handle linking to C code compiled with the -mc68881 option
;------------- 3.0d13
;03/29/93 bill put in a couple of $sp-clrcache's just to be safe
;03/17/93 bill :preserve-initial-image keyword to ff-load.
;              Support for it in ff-save-env & ff-restore-env
;------------- 2.0
;10/17/94 kab  changed ffenv-seg-ptrs to be a simple vector instead of list.
;              more compact representation of ffenv-a5-abs-refs
;              more compact representation of ffenv-entries
;10/06/94 kab  speed up (AppLex loads in 6 minutes instead of 18 minutes):
;                use stream-reader for faster file reads.
;                change *ff-id-names* to a hash table instead of an alist.
;                record named entries and segments in equal hash tables and
;                  do name lookups there rather than by alist search using
;                  string=.
;                various small performance tweaks.
;------------- 2.0.2
;--- kab, 10/6/94: There were some bug fixes and Creole enhancements made by
;--- Moon, gz, and I in the interim period that were not recorded here.
;------------- ???
;08/24/91 gb   wimpy new trap syntax.
;07/21/91 gb   wimpy defconstants, declaim.
;07/01/91 bill %store-cstr renamed to %put-cstring and moved to l1-utils
;------------- 2.0b2
;04/25/91 bill pushnew on *save-exit-functions* & *restore-lisp-functions*
;03/11/91 bill Moon's fix to defffun-aux.
;03/22/91 alice ff-parseobj - from gary
;----------------- 2.0b1
;08/08/90 gb  first cut at 2.0 version.
;2/16/89  don't wipe out internal names (needs further study)
;10/21/88 jaj force offsets to modules to be even.  Warn on duplicate entries.
;----------------------------------Version 1.0 of FFI--------------------------
;6/17/88 gb  changes to support dumping environments
;2/25/88 cfry merge in of GZ fixes of 2/24/88
;2/22/88 cfry renamed arg of dispose-ffenv from env to ffenv.
;           ffload args renamed entry-points -> entry-names,
;            library-entry-points -> library-entry-names
;            name -> ffenv-name
;            ff-lookup-entry added and exported. ff-lookup unexported. It is
;             now considered an internal function.
;2/18/88  cfry modified defffun-aux so that a COMPILED closure will always
;         be made, since an interpreted one fails with %put-ptr/%get-ptr
;2/3/88    cfry removed defconstant bin_data which was redundant
;               added (require 'subprims)
; 01/14/87 gz  Support :return-block in ff-call.
;              Added :full-long, :double, :extended result types in defffun.
; 12/29/87 gz  Added :char result-type in defffun.  Hair up language-dependent
;              defaulting to allow MPW C-style float passing (extended if by
;              value, double if by address!).
; 12/22/87 gz  removed #+/-bccl conditionalizations, uses of level-2 macros.
;              Should now compile in a block-compiled CCL.
; 11/30/87 gz  New.

(in-package :ccl)
(provide :ff)

#-ppc-target
(eval-when (eval compile)
  (require 'lap)
  (require 'lapmacros)
  )

(export '(ff-load defffun deffcfun deffcfun-881 deffpfun dispose-ffenv ff-lookup-entry
          ff-call))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      The loader                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when (eval compile)

(defmacro ff-datap (flags) `(%ilogbitp 0 ,flags))
(defmacro ff-prefixp (flags) `(%ilogbitp 0 ,flags))
(defmacro ff-longp (flags) `(%ilogbitp 3 ,flags))
(defmacro ff-externp (flags) `(%ilogbitp 3 ,flags))
(defmacro ff-partialp (flags) `(%ilogbitp 3 ,flags))
(defmacro ff-mainp (flags) `(%ilogbitp 4 ,flags))
(defmacro ff-repeatp (flags) `(%ilogbitp 4 ,flags))
(defmacro ff-8bitp (flags) `(%ilogbitp 5 ,flags))
(defmacro ff-16bitp (flags) `(%ilogbitp 4 ,flags))
(defmacro ff-pcrelp (flags) `(%ilogbitp 6 ,flags))
(defmacro ff-a5relp (flags) `(%ilogbitp 7 ,flags))

;;; 16bitp or a5relp
(defconstant +ff-16bit-ref-mask+ (logior (ash 1 4) (ash 1 7)))

(defmacro ff-crefp (flags) `(%ilogbitp 8 ,flags))

(defmacro ff-seg-name (seg) `(car ,seg))     ;Name or NIL if internal
(defmacro ff-seg-modules (seg) `(cdr ,seg)) ;Modules in segment.
(defmacro ff-cons-seg (name) `(cons ,name nil))

(defmacro ff-entry-name (e) `(car ,e))      ;Name if external, NIL if internal
(defmacro ff-entry-offset (e) `(cadr ,e))   ;Offset in module
(defmacro ff-entry-place (e) `(caddr ,e))  ;The module
(defmacro ff-entry-jslot (e) `(cdddr ,e))   ;Jslot (while linking)
(defmacro cons-ff-entry (name offset module jslot) `(list* ,name ,offset ,module ,jslot))
(defmacro find-ff-entry (id entries) `(assq ,id ,entries))

(defmacro ff-module-contents (m) `(car ,m))   ;Contents vector
(defmacro ff-module-refs (m) `(cadr ,m))      ;List of references
(defmacro ff-module-segment (m) `(caddr ,m))  ;Segment # or NIL if data (while linking)
(defmacro ff-module-offset (m) `(cdddr ,m))   ;Offset in segment (while linking)
(defmacro cons-ff-module (contents) `(list* ,contents nil nil nil))

(defmacro ff-ref-entry (r) `(car ,r))    ;What's being referenced (an entry or an ext name)
(defmacro ff-ref-flags (r) `(cadr ,r))   ;Flag bits (computed, A5, PC, 32/16/8)
(defmacro ff-ref-offsets (r) `(cddr ,r)) ;Offsets in module to where the ref is.
(defmacro cons-ff-ref (entry flags offsets) `(list* ,entry ,flags ,offsets))

(defmacro with-delayed-pop (var &body body)
  `(setq ,var (prog1 (%cdr ,var) ,@body)))

(defmacro badarg (&rest forms) `(values (%badarg ,@forms)))

(defconstant $omf-pad 0)
(defconstant $omf-first 1)
(defconstant $omf-last 2)
(defconstant $omf-comment 3)
(defconstant $omf-dictionary 4)
(defconstant $omf-module 5)
(defconstant $omf-entrypoint 6)
(defconstant $omf-size 7)
(defconstant $omf-contents 8)
(defconstant $omf-reference 9)
(defconstant $omf-computed-reference 10)

(defconstant $omf-filename 11)
(defconstant $omf-source-statement 12)
(defconstant $omf-module-begin 13)
(defconstant $omf-module-end 14)
(defconstant $omf-block-begin 15)
(defconstant $omf-block-end 16)
(defconstant $omf-localid 17)
(defconstant $omf-local-label 18)
(defconstant $omf-local-type 19)
(defconstant $omf-localid2 20)

)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Use stream-reader to speed up reading the file.
;;; Use various tricks to reduce the number of special variable
;;; references to get the stream variables.
;;;
;;; *ff-objfile*
;;;    The file-stream currently being read from.
;;;
;;; *ff-objfile-reader*
;;;    The stream-reader function for *ff-objfile*.
;;;
;;; *ff-objfile-reader-arg*
;;;    The argument to the stream-reader function.

(declaim (special *ff-objfile* *ff-objfile-reader* *ff-objfile-reader-arg*))

(eval-when (eval compile)

;;; These macros expand into the corresponding global variables.
;;; These macros are lexically shadowed by with-ff-objfile.
(defmacro ff-objfile () '*ff-objfile*)
(defmacro ff-objfile-reader () '*ff-objfile-reader*)
(defmacro ff-objfile-reader-arg () '*ff-objfile-reader-arg*)

;;; Bind the stream-reader variables.
(defmacro with-ff-objfile-reader (&body body)
  `(multiple-value-bind (*ff-objfile-reader* *ff-objfile-reader-arg*)
                        (stream-reader (ff-objfile))
     ,@body))

;;; Establish a context in which there are lexical variables bound to
;;; the global stream variables, with the macros for referencing the
;;; stream variables shadowed by local macros that expand into references
;;; to the lexical variables.  Thus, the body forms reference the stream
;;; variables via lexicals with the specials only read once.  This macro
;;; can be safely nested; presumably the compiler will optimize away any
;;; unnecessary extra bindings.
(defmacro with-ff-objfile (&body body)
  (let ((reader (gensym))
        (arg (gensym))
        (file (gensym)))
    `(let ((,reader (ff-objfile-reader))
           (,arg (ff-objfile-reader-arg))
           (,file (ff-objfile)))
       (declare (ignorable ,reader ,arg ,file))
       (macrolet ((ff-objfile-reader () ',reader)
                  (ff-objfile-reader-arg () ',arg)
                  (ff-objfile () ',file))
         ,@body))))

(defmacro ff-byte ()
  `(funcall (ff-objfile-reader) (ff-objfile-reader-arg)))

(defmacro ff-recpos ()
  '(- (file-position (ff-objfile)) 2))
  
(defmacro ff-word ()
  `(with-ff-objfile
     (%i+ (%ilsl 8 (ff-byte)) (ff-byte))))
  
(defmacro ff-signed-word  ()
  `(let ((n (ff-word)))
     (if (%i< n #x8000) n (%i- n #x10000))))

(defmacro ff-signed-long ()
  `(with-ff-objfile
     (+ (ash (ff-signed-word) 16) (ff-word))))
)

(defun ff-filepos ()
  (file-position (ff-objfile)))
  
(defun ff-skip-record ()
  (with-ff-objfile
    (ff-byte)
    (file-position (ff-objfile) (+ (ff-recpos) (ff-word)))))
  
(defun ff-string ()
  (with-ff-objfile
    (let* ((count (ff-byte))
           (str (make-string count :element-type  'base-character)))
      (dotimes (i count str)
        (declare (fixnum i))
        (setf (schar str i) (%code-char (ff-byte)))))))

(eval-when (eval compile) (defmacro ff-dbmsg (&rest args) (declare (ignore args))))

(defvar *ffenvs* () "List of all loaded ffenv's")

(defstruct (ffenv (:predicate nil) (:copier nil))
  a5ptr		;a5 value of this env (unboxed)
  entries	;alist of (name . jtab-address)
  name		;user-assigned name
  data-offset	;Offset from a5ptr to top of the block (negative)
  jtab-offset	;Offset from a5ptr to end of the block (positive)
  seg-ptrs	;list of segment pointers
  a5-abs-refs   ;list of (a5-offset-referenced flags . a5-offset-references)
                ;These are turned into absolute refs when restoring an image
  initial-image ; saved image as initially loaded
)

(defun dispose-ffenv (ffenv)
  (dolist (e *ffenvs* (return-from dispose-ffenv nil))
    (when (or (eq ffenv e)
              (eq ffenv (ffenv-a5ptr e))
              (equal ffenv (ffenv-name e)))
      (return (setq ffenv e))))
  (without-interrupts
    (setq *ffenvs* (delete ffenv *ffenvs*))
    (when (ffenv-a5ptr ffenv)
      (#_DisposePtr (%inc-ptr (ffenv-a5ptr ffenv) (ffenv-data-offset ffenv)))
      (setf (ffenv-a5ptr ffenv) nil))
    (let ((ptrs (ffenv-seg-ptrs ffenv)))
      (dotimes (i (length ptrs))
        (let ((ptr (svref ptrs i)))
          (when ptr
            (#_DisposePtr ptr)
            (setf (svref ptrs i) nil))))))
  t)

; This (ff-lookup) is supposed to be internal (check the documentation).
; Note that it no longer returns absolute mac pointers.
; It is used -only- to implement deff?fun.
(defun ff-lookup (name &aux a)
  (setq name (ensure-simple-string (string name)))
  (dolist (env *ffenvs* (error "There is no foreign entry point named ~S" name))
    (when (setf a (ff-find-name name (ffenv-entries env)))
      (return (values a env)))))

(defun ff-lookup-entry (entry-name &aux a)
  "Returns a pointer to the entry point and the a5 pointer for the env that
   entry-name was found in. If no entry with entry-name exists, return NIL."
  (setq entry-name (ensure-simple-string (string entry-name)))
  (dolist (env *ffenvs* (values nil nil))
    (when (setf a (ff-find-name entry-name (ffenv-entries env)))
      (return (values (%cdr a) (ffenv-a5ptr env))))))

;Creole---this definition added
(defun ff-lookup-env (ffenv-name)
  (dolist (env *ffenvs* nil)
    (when (equal ffenv-name (ffenv-name env))
      (return env))))

(declaim (special *ff-data-modules* *ff-main* *ff-a5-abs-refs*))
(declaim (special *ff-segments* *ff-named-segments*))
(declaim (special *ff-entries* *ff-named-entries*))

(eval-when (:load-toplevel :execute)
  (fmakunbound 'ff-load))

(defun ff-load (file[s] &key ffenv-name replace
                             libraries entry-names library-entry-names preserve-initial-image)
  (when (osx-p) (error "FF-LOAD does not work on OSX"))
  (when (and replace (null ffenv-name)) (error "Must give :FFENV-NAME to specify :REPLACE"))
  (when ffenv-name
    (dolist (env *ffenvs*)
      (when (equal ffenv-name (ffenv-name env))
        (unless replace (return-from ff-load env))
        (return (setq replace env)))))
  (let* ((*ff-segments* ())
         (*ff-named-segments* (make-hash-table :test 'equal :rehash-size 4.0))
         (*ff-data-modules* ())
         (*ff-entries* ())
         (*ff-named-entries* (make-hash-table :test 'equal :rehash-size 4.0))
         (*ff-main* nil)
         (*ff-a5-abs-refs* nil)
         (active ()) ent)
    (if (listp file[s])
      (dolist (file file[s]) (ff-readobj file))
      (ff-readobj file[s]))
    (when (null entry-names)
      (dolist (ent *ff-entries*) (when (ff-entry-name ent) (push ent active))))
    (dolist (file libraries) (ff-readobj file))
    (dolist (name entry-names)
      (if (null (setq ent (gethash (ensure-simple-string name) *ff-named-entries*)))
        (cerror "Ignore this name." "There is no entry point named ~S" name)
        (push ent active)))
    (dolist (name library-entry-names)
      (if (null (setq ent (gethash (ensure-simple-string name) *ff-named-entries*)))
        (cerror "Ignore this name." "There is no entry point named ~S" name)
        (push ent active)))
    (let ((env (ff-linkobj ffenv-name active)))
      (when replace (dispose-ffenv replace))
      (when preserve-initial-image
        (setf (ffenv-initial-image env) (ff-save-env env t)))
      env)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(declaim (special *ff-obj-segments* *ff-obj-entries* *ff-obj-data-modules*
                    *ff-objfile*))

(defun ff-readobj (file &aux val)
  (let* ((*ff-obj-segments* ())
         (*ff-obj-data-modules* ())
         (*ff-obj-entries* ()))
    (with-open-file (*ff-objfile* file :element-type '(unsigned-byte 8))
      (with-ff-objfile-reader
        (with-ff-objfile
          (unless (eq (ff-byte) $omf-first)
            (error "~S is not an MPW object file" *ff-objfile*))
          (ff-byte)
          (unless (<= 1 (setq val (ff-word)) 3)
            (cerror "Try reading it anyway"
                    "Unknown Object File version (~S) in ~S"
                    val *ff-objfile*))
          (ff-parseobj))))
    (dolist (seg *ff-obj-segments*)
      (let ((name (ff-seg-name seg)))
        (if (and name (setq val (gethash name *ff-named-segments*)))
          (setf (ff-seg-modules val)
                (nconc (ff-seg-modules val) (ff-seg-modules seg)))
          (progn
            (setq *ff-segments* (nconc *ff-segments* (list seg)))
            (when name (setf (gethash name *ff-named-segments*) seg))))))
    (do ((head nil)
         (tail *ff-obj-entries*))
        ((null tail))
      (let* ((ent (%car tail))
             (name (ff-entry-name ent)))
        (block update-done
          (when name
            (cond ((null (setq val (gethash name *ff-named-entries*)))
                   (setf (gethash name *ff-named-entries*) ent))
                  ;Should handle merging of data entries, for fortran.
                  ;;Creole---added the following code to do just that (for duplicated C++ vtables)
                  ((do ((place (ff-entry-place ent))
                        (head nil tail)
                        (tail *ff-obj-data-modules* (%cdr tail)))
                       ((null tail) nil)
                     (when (eql place (%car tail))
                       (setf tail (%cdr tail))
                       (if (null head)
                         (setf *ff-obj-data-modules* tail)
                         (setf (%cdr head) tail))
                       (return t)))
                   (warn "Removed duplicate data definition for ~S" (ff-entry-name ent))
                   (setf tail (%cdr tail))
                   (if (null head)
                     (setf *ff-obj-entries* tail)
                     (setf (%cdr head) tail))
                   ;; ff-deidify-entry may have already "snapped the link"
                   (labels ((fix-module (mod)
                              (dolist (ref (ff-module-refs mod))
                                (if (ff-crefp (ff-ref-flags ref))
                                  (let ((x (ff-ref-entry ref)))
                                    (when (eq (car x) ent)
                                      (setf (car x) val))
                                    (when (eq (cdr x) ent)
                                      (setf (cdr x) val)))
                                  (when (eq (ff-ref-entry ref) ent)
                                    (setf (ff-ref-entry ref) val))))))
                     (dolist (seg *ff-obj-segments*)
                       (mapc #'fix-module (ff-seg-modules seg)))
                     (mapc #'fix-module *ff-obj-data-modules*))
                   (return-from update-done))
                  (t
                   (warn "Duplicate definition for ~S" name))))
          (setf head tail tail (%cdr tail)))))
    (setq *ff-entries* (nconc *ff-entries* *ff-obj-entries*))
    (setq *ff-data-modules* (nconc *ff-data-modules* *ff-obj-data-modules*))))

(declaim (special *ff-data-module* *ff-code-module* *ff-id-names*))

(eval-when (eval compile)
(defmacro name-from-id (id)
  `(gethash ,id *ff-id-names*))
(defmacro initial-id-names ()
  '(make-hash-table :test 'eq :rehash-size 4.0))
(defmacro record-id->name-mapping (id str)
  `(setf (gethash ,id *ff-id-names*) ,str))
)

(defun ff-parseobj ()
  (with-ff-objfile
    (let* ((*ff-data-module* ())
           (*ff-code-module* ())
           (*ff-id-names* (initial-id-names))
           opcode)
      (loop
        (case (setq opcode (ff-byte))
          (#.$omf-pad
           nil)
          (#.$omf-last 
           (return nil))
          (#.$omf-comment 
           (ff-read-comment))
          (#.$omf-dictionary 
           (ff-read-dictionary))
          (#.$omf-module 
           (ff-read-module))
          (#.$omf-entrypoint 
           (ff-read-entry))
          (#.$omf-size 
           (ff-read-size))
          (#.$omf-contents 
           (ff-read-contents))
          (#.$omf-reference 
           (ff-read-reference))
          (#.$omf-computed-reference 
           (ff-read-computed-reference))
          ((#.$omf-filename 
            #.$omf-module-end)
           (ff-byte) (ff-word) (ff-word) (ff-word) nil)
          ((#.$omf-source-statement
            #.$omf-module-begin
            #.$omf-block-begin
            #.$omf-localid
            #.$omf-local-label
            #.$omf-local-type
            #.$omf-localid2) 
           (ff-skip-record) nil)
          (#.$omf-block-end 
           (ff-byte) (ff-word) (ff-word) (ff-word) (ff-word) (ff-word) nil)
          (t (error "Unknown opcode (~S) in ~S" opcode *ff-objfile*))))
      (setq *ff-obj-segments* (nreverse *ff-obj-segments*))
      (dolist (seg *ff-obj-segments*)
        (setf (ff-seg-name seg) (name-from-id (ff-seg-name seg)))
        (setf (ff-seg-modules seg) (ff-deidify (ff-seg-modules seg))))
      (setq *ff-obj-data-modules* (ff-deidify *ff-obj-data-modules*))
      (dolist (e *ff-obj-entries*)
        (setf (ff-entry-name e)
              ;(and (ff-entry-jslot e) ;externalp
              ;     (or (name-from-id (ff-entry-name e))
              ;         (error "Unnamed public entry")))
              (or (name-from-id (ff-entry-name e))
                  (if (ff-entry-jslot e) (error "Unnamed public entry"))))
        (setf (ff-entry-jslot e) nil)))))

(defun ff-deidify (modules &aux id)
  (dolist (mod modules)
    (dolist (ref (ff-module-refs mod))
      (if (fixnump (setq id (ff-ref-entry ref)))
        (setf (ff-ref-entry ref) (ff-deidify-entry id))
        (progn
          (rplaca id (ff-deidify-entry (car id)))
          (rplacd id (ff-deidify-entry (cdr id))))))
    (setf (ff-module-refs mod) (nreverse (ff-module-refs mod))))
  (nreverse modules))

(defun ff-deidify-entry (id)
  (or (find-ff-entry id *ff-obj-entries*)
      (name-from-id id)
      (error "Reference to an unnamed external entry")))

(defun ff-read-comment ()
  (with-ff-objfile
    (ff-dbmsg "~&COMMENT")
    (ff-byte)
    (dotimes (i (- (ff-word) 4)) (declare (fixnum i)) (ff-byte))))

(defun ff-read-dictionary ()
  (with-ff-objfile
    (let* ((flags (ff-byte))
           (recsz (- (ff-word) 6))
           (id (ff-word))
           (prefix ())
           str)
      (when (ff-prefixp flags)
        (setq prefix (ff-string) recsz (- recsz (length prefix) 1)))
      (ff-dbmsg "~&DICTIONARY[Prefix ~S]" prefix)
      (do () ((not (%i> recsz 0))
              (unless (%izerop recsz) (error "Bad dictionary record")))
        (setq str (ff-string) recsz (- recsz (length str) 1))
        (when prefix (setq str (%str-cat prefix str)))
        (unless (%izerop (length str))
          (ff-dbmsg "~&    ~S -> ~S" id str)
          (record-id->name-mapping id str))
        (setq id (1+ id))))))

(defun ff-read-module ()
  (let* ((flags (ff-byte)))
    (if (ff-datap flags)
      (ff-read-data-module flags)
      (ff-read-code-module flags))))

(defun ff-read-code-module (flags)
  (let* ((id (ff-word))
         (segid (ff-word))
         (seg (assq segid *ff-obj-segments*))
         mod)
    (when (null seg) (push (setq seg (ff-cons-seg segid)) *ff-obj-segments*))
    (setq mod (cons-ff-module nil))
    (ff-dbmsg "~&CODE-MODULE #~S in seg# ~S" id segid)
    (push mod (ff-seg-modules seg))
    (setq *ff-code-module* mod)
    (ff-new-entry flags id 0)))

(defun ff-read-data-module (flags)
  (let* ((id (ff-word))
         (size (ff-word))
         mod)
    (setq mod (cons-ff-module (and (not (%izerop size))
                                   (make-array size
                                               :element-type '(unsigned-byte 8)
                                               :initial-element 0))))
    (ff-dbmsg "~&DATA-MODULE ~S size=~S" mod size)
    (push mod *ff-obj-data-modules*)
    (setq *ff-data-module* mod)
    (ff-new-entry flags id 0)))

(defun ff-read-entry ()
  (with-ff-objfile
    (ff-new-entry (ff-byte) (ff-word) (ff-signed-long))))

(defun ff-new-entry (flags id offset)
  (when (and (ff-datap flags) (ff-mainp flags)) ;main data
    (when *ff-main* (error "Can't have more than one main data module."))
    (setq *ff-main* *ff-data-module*))
  (push
   (cons-ff-entry id
                  offset
                  (if (ff-datap flags) *ff-data-module* *ff-code-module*)
                  (ff-externp flags))
   *ff-obj-entries*)
  (ff-dbmsg "~&~A-ENTRY #~S @~S" (if (ff-datap flags) "DATA" "CODE") id offset)
  )

(defun ff-read-size ()
  (with-ff-objfile
    (ff-new-size (ff-byte) (ff-signed-long))))

(defun ff-new-size (flags size)  ;Returns the vector
  (let* ((mod (if (ff-datap flags) *ff-data-module* *ff-code-module*))
         (vec (ff-module-contents mod))
         (vlen (length vec)))
    (if (%i< vlen size)
      (let ((newvec (make-array size
                                :element-type '(unsigned-byte 8))))
        (dotimes (i vlen (setf (ff-module-contents mod) newvec))
          (declare (fixnum i))
          (setf (aref newvec i) (aref vec i))))
      vec)))

(defun ff-read-contents ()
  (with-ff-objfile
    (let* ((flags (ff-byte))
           (end-pos (+ (ff-recpos) (ff-word)))
           (offset (if (ff-partialp flags) (ff-signed-long) 0))
           (repeat (if (ff-repeatp flags) (ff-word) 1))
           (data-size (- end-pos (ff-filepos)))
           (vec (ff-new-size flags (+ offset (* repeat data-size)))))
      (ff-dbmsg t "~&~A-CONTENTS offset=~S repeat=~S size=~S"
                (if (ff-datap flags) "DATA" "CODE")
                offset repeat data-size)
      (let ((idx offset))
        (dotimes (i data-size)
          (declare (fixnum i))
          (setf (aref vec idx) (ff-byte))
          (setq idx (+ idx 1)))
        (dotimes (i (1- repeat))
          (declare (fixnum i))
          (dotimes (j data-size)
            (declare (fixnum j))
            (setf (aref vec (+ idx j)) (aref vec (+ offset j))))
          (setq idx (+ idx data-size)))))))

(defun ff-read-reference ()
  (with-ff-objfile
    (ff-new-reference (ff-byte) (- (ff-word) 6) (ff-word))))

(defun ff-read-computed-reference ()
  (with-ff-objfile
    (ff-new-reference (%ilogior2 #x100 (ff-byte))
                      (- (ff-word) 8)
                      (cons (ff-word) (ff-word)))))

(defun ff-new-reference (flags len id)
  (with-ff-objfile
    (let* ((module (if (ff-datap flags) *ff-data-module* *ff-code-module*))
           (offsets ()))
      (if (ff-longp flags)
        (dotimes (i (%ilsr 2 len)) (declare (fixnum i)) (push (ff-signed-long) offsets))
        (dotimes (i (%ilsr 1 len)) (declare (fixnum i)) (push (ff-signed-word) offsets)))
      (ff-dbmsg "~&REFs to #~S (flags=#x~X): ~S" id flags offsets)
      (setf (ff-module-refs module)
            (cons (cons-ff-ref id flags offsets) (ff-module-refs module))))))

(defun ff-find-name (name vector)
  (declare (simple-vector vector))
  (declare (optimize (speed 3) (safety 0)))
  (dotimes (i (length vector))
    (let* ((entry (svref vector i))
           (ename (%car entry)))
      (when (and ename (string= ename name))
        (return entry)))))

#-carbon-compat
(progn

(defvar *get-fp0-68k*)

(def-ccl-pointers init-ff-68k-code ()
  (setq *get-fp0-68k*
        (word-list-to-ptr '(8303 4       ; (%lap-words '((move.l (sp 4) atemp0) 
                            -3568 29696  ;               (fmove.d fp0 @atemp0)
                            8287         ;               (move.l sp@+ atemp0)
                            22607        ;               (add ($ 4) sp)
                            20176        ;               (jmp @atemp0)))
                            ))))

)  ; end of #+ppc-target progn

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Creole---changes made by KAB below here are marked "kab" (not "Creole")

(defun ff-linkobj (name active &aux (sdata 0) (sjtab 34) ptr env)
  (dolist (seg *ff-segments*)
    (dolist (mod (ff-seg-modules seg)) (setf (ff-module-segment mod) seg)))
  (dolist (mod *ff-data-modules*) (setf (ff-module-segment mod) nil))
  (when *ff-main* (ff-mark-module *ff-main* +ff-16bit-ref-mask+))       ; --- kab: default assumption
  (dolist (ent active)
    (when (ff-module-segment (ff-entry-place ent))
      (setf (ff-entry-jslot ent) t))
    (ff-mark-module (ff-entry-place ent) +ff-16bit-ref-mask+))          ; --- kab: default assumption
  ;Assign code offsets, flush unref'd code modules/segments
  ;--- kab: order code modules, 16bit ref'd first
  (do ((segs *ff-segments*) (psegs ()))
      ((null segs) (setf *ff-segments* psegs))
    (with-delayed-pop segs
      (let* ((seg (%car segs))
             (modules (ff-order-modules (ff-seg-modules seg)))
             (offset 0))
          (when modules
            (dolist (mod modules)
              (setf (ff-module-offset mod) offset)
              ;;force event offset
              (setq offset (%ilogand2 -2 (+ 1 (+ offset (length (ff-module-contents mod)))))))
            (setf (ff-seg-modules seg) modules)
            (setf (ff-seg-name seg) offset)
            (setf psegs (%rplacd segs psegs))))))
  ;Assign data offsets, flush unref'd data modules
  ;--- kab: order data modules, 16bit ref'd first
  (flet ((compute-module-offset (module sdata)
           ;;Creole--- add code to ensure sdata is 0 mod 4 
           (setf sdata (%ilogand2 -4 (- sdata (length (ff-module-contents module)))))
           (setf (ff-module-offset module) sdata)))
    (when *ff-main*
      (setf sdata (compute-module-offset *ff-main* sdata)))
    (dolist (mod (setf *ff-data-modules* (ff-order-modules *ff-data-modules*)))
      (setf sdata (compute-module-offset mod sdata))))
  ;Assign jtab offsets, flush non-jtab entries, absolutivify entry offsets.
  (do* ((entries *ff-entries*) (pents ()) ent pos)
       ((null (setq ent (%car entries))) (setq *ff-entries* pents))
    (with-delayed-pop entries
      (when (setq pos (ff-module-offset (ff-entry-place ent)))
        (setf (ff-entry-offset ent) (+ pos (ff-entry-offset ent)))
        (setf (ff-entry-place ent) (ff-module-segment (ff-entry-place ent)))
        (when (ff-entry-jslot ent)
          (setf (ff-entry-jslot ent) sjtab)
          (setq sjtab (+ sjtab 8))
          (setq pents (%rplacd entries pents))))))
  (setq sjtab (- sjtab 2))
  ;Go for it!
  (unwind-protect
    (let (a5ptr ptrs)
      (do* ((segs *ff-segments* (%cdr segs)) seg) ((null (setq seg (%car segs))))
        (%rplaca seg (#_NewPtr :errchk (ff-seg-name seg)))
        (ff-fill-code seg)
        (setq ptrs (%rplacd seg ptrs)))
      (setq ptr (#_NewPtr :errchk (- sjtab sdata)))
      (setq a5ptr (%int-to-ptr (- (%ptr-to-int ptr) sdata)))
      (#_BlockMove (%currentA5) a5ptr 32) ;GrafGlobals etc.
      (ff-fill-data a5ptr)
      (ff-fill-jtab a5ptr)
      (dolist (ent active)
        (%rplacd ent
                 (%inc-ptr a5ptr (or (ff-entry-jslot ent)
                                     (ff-entry-offset ent)))))
      (setq env (make-ffenv :a5ptr a5ptr
                            :entries (coerce active 'simple-vector)
                            :name name
                            :data-offset sdata
                            :jtab-offset sjtab
                            :seg-ptrs (coerce ptrs 'simple-vector)
                            :a5-abs-refs (ff-compress-a5-abs-refs *ff-a5-abs-refs*)))
      (push env *ffenvs*))
    (without-interrupts
     (unless (and env (eq env (%car *ffenvs*)))
       (when ptr (#_DisposePtr ptr))
       (dolist (seg *ff-segments*)
         (unless (fixnump (ff-seg-name seg))
           (#_DisposePtr (ff-seg-name seg)))))))
  #-ppc-target (%primitive $sp-clrcache :acc)
  #+ppc-target (flush-code-cache)
  env)

;;; --- kab: new code.
;;; Sort the list of modules such that those which are referenced using a 16bit
;;; offset are placed before those which are not, discarding unreferenced modules.
;;; The module-offset contains the reference information (see ff-mark-module), which
;;; is nil (indicating not referenced) or an integer whose value is the result of
;;; logioring together the reference flags of all entries that reference the module.
(defun ff-order-modules (modules)
  (do ((16bit ())
       (other ()))
      ((null modules) (nconc 16bit other))
    (with-delayed-pop modules
      (let ((flags (ff-module-offset (%car modules))))
        (cond ((null flags))            ; unref'd, so discard
              ((or (ff-16bitp flags) (ff-a5relp flags))
               (setf 16bit (%rplacd modules 16bit)))
              (t
               (setf other (%rplacd modules other))))))))


(defun ff-mark-module (mod rflags &aux seg e eseg flags)
  (if (setf flags (ff-module-offset mod))
    ;--- kab: merge reference flags, so that ff-order-modules can later
    ;    figure out which modules are referred to via 16bit offsets.
    (setf (ff-module-offset mod) (logior flags rflags))
    (progn
      (setf (ff-module-offset mod) rflags)
      (setq seg (ff-module-segment mod))
      (dolist (ref (ff-module-refs mod))
        (setq e (ff-ref-entry ref) flags (ff-ref-flags ref))
        (if (ff-crefp flags) ;Computed ref
          (progn
            (unless (eq (ff-module-segment (ff-entry-place (car e)))
                        (ff-module-segment (ff-entry-place (cdr e))))
              (error "Bad computed reference"))
            (rplaca e (ff-mark-entry (car e) flags))    ; --- kab: pass along flags
            (rplacd e (ff-mark-entry (cdr e) flags)))   ; --- kab: pass along flags
          (progn
            (setf (ff-ref-entry ref) (setq e (ff-mark-entry e flags)))          ; --- kab: pass along flags
            (when (and (not (ff-entry-jslot e))
                       (setq eseg (ff-module-segment (ff-entry-place e)))
                       (or (not (eq seg eseg)) (ff-a5relp flags)))
              (when (ff-pcrelp flags)
                (error "Improper PC-relative reference"))
              (setf (ff-entry-jslot e) t))))))))

(defun ff-mark-entry (e flags)          ; --- kab: added flags argument
  (when (stringp e)
    (setq e (or (gethash e *ff-named-entries*)
                (error "Reference to undefined entry point ~S" e))))
  (ff-mark-module (ff-entry-place e) flags)     ; --- kab: pass along flags
  e)

(defun ff-fill-code (seg &aux ptr modptr ent flags pcflag epos rpos eseg rptr)
  (setq ptr (ff-seg-name seg))
  (dolist (mod (ff-seg-modules seg))
    (setq modptr (%inc-ptr ptr (ff-module-offset mod)))
    (when (setq rptr (ff-module-contents mod))
      (dotimes (i (length rptr))
        (declare (fixnum i))
        (%put-byte modptr (aref rptr i) i)))
    (dolist (ref (ff-module-refs mod))
      (setq ent (ff-ref-entry ref) flags (ff-ref-flags ref) pcflag flags)
      (cond ((ff-crefp flags)
             (setq epos (- (ff-entry-offset (car ent))
                           (ff-entry-offset (cdr ent)))))
            ((null (setq eseg (ff-entry-place ent)))
             (setq epos (ff-entry-offset ent)))
            ((ff-a5relp flags)
             (setq epos (ff-entry-jslot ent)))
            ((eq seg eseg)
             (setq epos (- (ff-entry-offset ent) (ff-module-offset mod)))
             (setq pcflag t))
            (t (setq epos (ff-entry-jslot ent))
               (setq pcflag nil)))
      (dolist (roffset (ff-ref-offsets ref))
        (setq rptr (%inc-ptr modptr roffset) rpos epos)
        (if (null pcflag)
          (%put-word rptr
                     (%ilogior2 #o55 (%ilogand2 #o177700 (%get-word rptr -2)))
                     -2)
            (when (eq pcflag t)
              (unless (ff-pcrelp flags)
                (%put-word rptr
                           (%ilogior2 #o72 (%ilogand2 #o177700 (%get-word rptr -2)))
                           -2))
              (setq rpos (- rpos roffset))))
        (add-ref rptr rpos flags)))))

(defun ff-fill-data (ptr &aux modptr vect ent flags epos modoffset)
  (dolist (mod *ff-data-modules*)
    (setq modptr (%inc-ptr ptr (setq modoffset (ff-module-offset mod))))
    (when (setq vect (ff-module-contents mod))
      (dotimes (i (length vect))
        (declare (fixnum i))
        (%put-byte modptr (aref vect i) i)))
    (dolist (ref (ff-module-refs mod))
      (setq ent (ff-ref-entry ref) flags (ff-ref-flags ref))
      (if (ff-crefp flags)
        (setq epos (- (ff-entry-offset (car ent))
                      (ff-entry-offset (cdr ent))))
        (progn
          (setq epos (or (ff-entry-jslot ent) (ff-entry-offset ent)))
          (unless (ff-a5relp flags) 
            (push (list* epos flags (mapcar #'(lambda (offset) (+ offset modoffset))
                                            (ff-ref-offsets ref)))
                  *ff-a5-abs-refs*)
            (setq epos (+ (%ptr-to-int ptr) epos)))))
      (dolist (roffset (ff-ref-offsets ref))
        (add-ref (%inc-ptr modptr roffset) epos flags)))))

(defun ff-fill-jtab (ptr)
  (dolist (e *ff-entries*)
    (let ((pos (ff-entry-jslot e)))
      (%put-long ptr #x4EF9 (- pos 2))
      (%put-long ptr (+ (%ptr-to-int (ff-seg-name (ff-entry-place e))) (ff-entry-offset e))
                 (+ pos 2)))))

(defun add-ref (ptr value flags)
  (cond ((ff-8bitp flags)
         (setq value (%i+ (%get-signed-byte ptr) value))
         (unless (%i< (integer-length value) 8)
           (cerror "Truncate to fit"
                   "Offset #x~X too large to fit in a byte" value))
         (%put-byte ptr value))
        ((ff-16bitp flags)
         (setq value (%i+ (%get-signed-word ptr) value))
         (unless (%i< (integer-length value) 16)
           (cerror "Truncate to fit"
                   "Offset #x~X too large to fit in a word" value))
         (%put-word ptr value))
        (t ;32 bit offset => 68020, so can afford to be a bit slow here...
         (setq value (+ (ash (%get-signed-word ptr) 16) (%get-word ptr 2) value))
         (unless (< (integer-length value) 32)
           (cerror "Truncate to fit"
                   "Offset #x~X too large to fit in a longword" value))
         (%put-word ptr (%ilogand2 #xFFFF (ash value -16)))
         (%put-word ptr (logand #xFFFF value) 2))))

(defun subtract-ref (ptr value flags)
  ;used by ff-save-env
  (cond ((ff-8bitp flags)
         (setq value (%i- (%get-signed-byte ptr) value))
         (%put-byte ptr value))
        ((ff-16bitp flags)
         (setq value (%i- (%get-signed-word ptr) value))
         (%put-word ptr value))
        (t ;32 bit offset => 68020, so can afford to be a bit slow here...
         (setq value (- (+ (ash (%get-signed-word ptr) 16) (%get-word ptr 2)) value))
         (%put-word ptr (%ilogand2 #xFFFF (ash value -16)))
         (%put-word ptr (logand #xFFFF value) 2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 DEFFFUN                                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when (eval compile)
  (defconstant ff-format-types '(:long :word
                                 :double :extended
                                 :ptr :lisp-ref
                                 :cstring :pstring
                                 ;;Creole--next two items added
                                 ;; :c-boolean because C and Pascal have incompatible Boolean representations
                                 ;; :c-char because C passes it as a long while Pascal passes it as a word
                                 :c-boolean :c-char))
  (defconstant ff-pass-types '(:by-value :by-address :by-reference))
  (defconstant ff-result-types '(:full-long :float :double :extended :char :long :word :ptr :novalue :none :void
                                 ;;Creole--next three items added
                                 :c-boolean :c-char :cstring))
  (defmacro push* (&rest args &aux (var (car (last args))))
    `(setq ,var (list* ,@args)))
)

(defun ff-format-type-p (spec)
  (or (memq spec '#.ff-format-types)
      (and (consp spec)
           (memq (%car spec) '(:cstring :pstring :Creole))   ;Creole--one item added to this list
           (consp (%cdr spec))
           (null (%cdr (%cdr spec))))))

(defun ff-result-loc-p (spec)
  (or (memq spec '(:stack :d0 :d1 :d2 :d3 :d4 :d5 :d6 :d7 :a0 :a1 :a2 :a3 :a4))
      (and (consp spec)
           (dolist (sub spec t)
             (unless (memq sub '(:d0 :d1 :d2 :d3 :d4 :d5 :d6 :d7 :a0 :a1 :a2 :a3 :a4))
               (return nil))))))

(defvar *ff-defaults* nil)

(setf (getf *ff-defaults* :c)
      '((:reverse-args t) ;defspec
        ((:d0 :d1 :a0) :long)       ;result spec
        ;argspecs
        ((or integer character) :by-value)
        ((or integer character) :long)
        (string :by-address)
        (string :cstring)
        (float :extended :by-value)
        (float :double :by-address)
        (float :double :by-reference)
        ;;Creole---next line added for Creole
        (<Creole-object> (:Creole <Creole-object>) :by-value)
        ))

(setf (getf *ff-defaults* :pascal)
      '( ()          ;defspec
         (:stack)    ;result spec
         ;argspecs
         ((or integer character) :by-value)
         ((or integer character) :word)
         (string :by-address)
         (string :pstring)
         (float :extended :by-address)
         (float :extended :by-reference)
         ;;Creole---next line added for Creole
         (<Creole-object> (:Creole <Creole-object>) :by-value)
         ))

(defmacro defffun (defspec argspecs &rest resultspec)
  (defffun-aux defspec argspecs resultspec nil))
(defmacro deffcfun (defspec argspecs &rest resultspec)
  (defffun-aux defspec argspecs resultspec (getf *ff-defaults* :c)))
(defmacro deffcfun-881 (defspec argspecs &rest resultspec)
  (defffun-aux defspec argspecs resultspec (getf *ff-defaults* :c) t))
(defmacro deffpfun (defspec argspecs &rest resultspec)
  (defffun-aux defspec argspecs resultspec (getf *ff-defaults* :pascal)))

(defun defffun-aux (defspec argspecs resultspec language &optional fpu-p &aux fname
                     entry
                     (check-args t)
                     reverse-args
                     result-type
                     result-loc
                     fp0-result-p
                     (virtual nil)      ;Creole---this variable added
                     )
  (if (symbolp defspec)
    (setq fname defspec defspec nil)
    (setq fname (pop defspec)))
  (setq entry (pop defspec))
  (setq defspec (append (pop language) defspec))
  (do* ((specs defspec) spec) ((null specs))
    (setq spec (pop specs))
    (cond ((eq spec :check-args)
           (setq check-args (eval (pop specs))))
          ((eq spec :reverse-args)
           (setq reverse-args (eval (pop specs))))
          ((eq spec :language)
           (setq language (pop specs))
           (when (symbolp language)
             (setq language (getf *ff-defaults* language)))
           (setq specs (append (pop language) specs)))
          ;;Creole---the following clause added
          ((eq spec :virtual)
           (setq virtual (pop specs)))
          (t (badarg spec '(member :check-args :reverse-args :language)))))
  (unless reverse-args (setq argspecs (reverse argspecs)))
  (if (and fpu-p
           (setq fp0-result-p
                 (and (null (cdr resultspec))
                      (or (memq (car resultspec) '(:double :extended float double-float long-float))))))
    (setq result-type :novalue
          result-loc :stack)
    (dolist (spec resultspec)
      (cond ((ff-result-loc-p spec)
             (when (and result-loc (not (equal result-loc spec)))
               (ff-incompat-err result-loc spec))
             (setq result-loc spec))
            ((or (memq spec '#.ff-result-types)
                 ;;Creole--this form and enclosing OR added
                 (and (consp spec) (eq (%car spec) :creole)))
             (when (memq spec '(:none :void)) (setq spec :novalue))
             (when (and result-type (not (equal result-type spec)))
               (ff-incompat-err result-type spec))
             (setq result-type spec))
            (t (badarg spec 
	               `(or (member ,@'#.ff-result-types) (satisfies ff-result-loc-p )))))))
  (dolist (spec (pop language))
    (cond ((and (not result-loc) (ff-result-loc-p spec))
           (setq result-loc spec))
          ((and (not result-type) (or (memq spec '#.ff-result-types)
                                      ;;Creole--this form and enclosing OR added
                                      (and (consp spec) (eq (%car spec) :creole))))
           (when (memq spec '(:none :void)) (setq spec :novalue))
           (setq result-type spec))))
  (when (null result-type)
    (setq result-type (cond ((null result-loc) :novalue)
                            ((memq result-loc '(:a0 :a1 :a2 :a3 :a4)) :ptr)
                            (t :long))))
  (when (and (null result-loc) (neq result-type :novalue))
    (error "Value location not specified"))
  (when (eq result-type :float) (setq result-type :extended))
  (if (memq result-type '(:double :extended))
    (unless (or (eq result-loc :stack) (consp result-loc))
      (error "Invalid value location ~S for ~S result" result-loc result-type))
    (when (consp result-loc) (setq result-loc (car result-loc))))
  (let* ((form (list 'progn))
         arglist
         (entryvar (make-symbol "ENTRY"))
         (entrycons (gensym))
         (envvar (gensym))
         (a5var (make-symbol "A5"))
         (argnum (if reverse-args 0 (1+ (length argspecs))))
         (*ff-arglist* nil)
         (*ff-outer* form)
         (*ff-prolog* nil)
         (*ff-epilog* nil)
         (*ff-stackblock* nil))
    (declare (special *ff-outer* *ff-arglist* *ff-prolog* *ff-epilog* *ff-stackblock*))
    (unless (eq result-type :novalue)
      (setq *ff-arglist* (list (if (eq result-loc :stack)
                                 (cond ((eq result-type :char) :word)
                                       ((eq result-type :full-long) :long)
                                       ((eq result-type :double) ''(:long :long)) 
                                       ((eq result-type :extended) ''(:word :long :long))
                                       (t result-type))
                                 (if (consp result-loc) `',result-loc
                                     ;Creole---begin Creole addition
                                     (if (and (consp result-type) (eq (%car result-type) :Creole))
                                         (if (eq result-loc :d0)
                                             `',result-type
                                             (error "consistency check failed: Creole result-loc is ~S instead of :D0" result-loc))
                                         ;Creole---end Creole addition
                                         result-loc
                                         );Creole---close paren added
                                         )))))
    (push* :a5 a5var *ff-arglist*)
    (when (memq result-type '(:double :extended))
      (let ((retblk (make-symbol "RETURN-BLOCK"))
            (retsize (if (eq result-type :double) 8 12)))
        (push `(,retblk ,retsize) *ff-stackblock*)
        (push* :return-block retblk *ff-arglist*)))
    (dolist (arg argspecs)
      (let* (lisp-type pass-type format (check-arg check-args))
        (if (atom arg)
          (setq lisp-type arg arg nil)
          (setq lisp-type (pop arg)))
        (dolist (flag arg)
          (cond ((ff-format-type-p flag)
                 (when (and format (not (equal format flag)))
                   (ff-incompat-err format flag))
                 (setq format flag))
                ((memq flag '#.ff-pass-types)
                 (when (and pass-type (not (equal pass-type flag)))
                   (ff-incompat-err pass-type flag))
                 (setq pass-type flag))
                ((eq flag :check-arg) (setq check-arg t))
                ((eq flag :no-check-arg) (setq check-arg nil))
                (t (error "Unknown flag ~S" flag))))
        (dolist (spec language)
          (when (and format pass-type) (return))
          (when (subtypep lisp-type (car spec))
            (let* (fformat ftype)
              (dolist (flag (cdr spec))
                (cond ((ff-format-type-p flag) (setq fformat flag))
                      ((memq flag '#.ff-pass-types) (setq ftype flag))))
              (when (and (null format)
                         (or (null pass-type)
                             (null ftype)
                             (eq pass-type ftype)))
                (setq format fformat))
              (when (and (null pass-type)
                         (or (null format)
                             (null fformat)
                             (eq format fformat)))
                (setq pass-type ftype)))))
        (unless format
          (error "No predefined argument format for ~S" lisp-type))
        (unless pass-type
          (setq pass-type (if (or (memq format '(:long :word :ptr :lisp-ref
                                                 ;;Creole--next item added
                                                 :c-boolean))
                                  ;Creole---this form and enclosing OR added
                                  (and (consp format) (eq (%car format) ':Creole)))
                            :by-value :by-address)))
        (setq argnum (if reverse-args (1+ argnum) (1- argnum)))
        (setq arg (make-symbol (%str-cat "ARG" (%integer-to-string argnum))))
        (push arg arglist)
        (if (eq pass-type :by-value)
          (push-by-value format lisp-type arg fpu-p)
          (push-by-address format lisp-type arg (eq pass-type :by-reference) fpu-p))
        (when (and check-arg (not (subtypep t lisp-type)))
          (push `(setq ,arg (require-type ,arg ',lisp-type)) *ff-prolog*))))
    (when reverse-args (setq arglist (nreverse arglist)))
    (when *ff-stackblock*
      (setq *ff-outer* `(%stack-block ,*ff-stackblock* ,*ff-outer*)))
    ;;Creole---virtual stuff in next line added
    (let ((call `(ff-call ,(if virtual `(:virtual ,@virtual) entryvar) ,@*ff-arglist*)))
      (cond ((eq result-type :char)
             (setq call `(%code-char ,call)))
            ;;Creole--start addition
            ((eq result-type :c-char)
             (setq call `(%code-char ,call)))
            ((eq result-type :c-boolean)
             ;;--- define-creole-function-1 depends on the peculiar code structure here
             ;; Can't just check (/= boolean 0) because only the low 8 bits are significant
             ;; This doesn't inline logtest, and boolean might not be a fixnum anyway if
             ;; C left some high-order bits on.  Complain to me later if it's too slow.
             (setq call `((lambda (boolean) (logtest #xFF boolean)) ,call)))
            ((eq result-type :cstring)
             ;;--- define-creole-function-1 depends on the peculiar code structure here
             (setq call `((lambda (address) 
                            (unless (zerop address)     ; null C string becomes Lisp nil
                              (%get-cstring (%int-to-ptr address))))
                          ,call)))
            ;;Creole--end addition
            ((eq result-type :full-long)
             (setq call `(%get-long ,call)))
            ((eq result-type :double)
             (setq call `(%copy-float ,call)))
            ((eq result-type :extended)
             (setq call
                   (if (eq result-loc :stack)
                     `(%get-x2float ,call)
                     `(%get-x2float (%inc-ptr ,call 2))))))
      (unless (eq result-loc :stack)
        (cond ((eq result-type :word)
               (setq call `(%word-to-int ,call)))
              ((and (eq result-type :long)
                    (memq result-loc '(:a0 :a1 :a2 :a3 :a4)))
               (setq call `(%ptr-to-int ,call)))
              ((and (eq result-type :ptr)
                    (not (memq result-loc '(:a0 :a1 :a2 :a3 :a4))))
               (setq call `(%int-to-ptr ,call)))))
      (when fp0-result-p
        (setq call `(progn ,call (%get-fp0))))
      (%rplacd form (nconc *ff-prolog*
                           (list `(prog1
                                    ,call
                                    ,@*ff-epilog*)))))
    ;;Creole---begin Creole addition
    (if virtual
      ;; normal and virtual cases must use same operator => multiple-value-bind
      `(multiple-value-bind (,envvar) (ff-lookup-env ',entry)
         (defun ,fname ,arglist
           (let ((,a5var (ffenv-a5ptr ,envvar)))
             ,*ff-outer*)))
      ;;Creole---end Creole addition
      `(multiple-value-bind (,entrycons ,envvar) (ff-lookup ,entry)      
         (defun ,fname ,arglist
           (let ((,entryvar (%cdr ,entrycons))
                 (,a5var (ffenv-a5ptr ,envvar)))
             ,*ff-outer*)))
      );Creole---close parenthesis added
    ))

(defun push-by-value (format lisp-type arg &optional fpu-p)
  (declare (special *ff-stackblock* *ff-prolog* *ff-epilog* *ff-outer* *ff-arglist*))
  (cond ((or (eq format :long) (eq format :word))
         (cond ((subtypep lisp-type 'fixnum)
                (push* format arg *ff-arglist*))
               ((subtypep lisp-type 'character)
                (push* format `(%char-code ,arg) *ff-arglist*))
               (t 
                (if (eq format :long)
                  (push* :long arg *ff-arglist*)
                  (push* :word arg *ff-arglist*)))))
        ;;Creole--start addition
        ((eq format :c-boolean)
         (push* :long `(if ,arg 1 0) *ff-arglist*))
        ((eq format :c-char)
         (push* :long `(%char-code ,arg) *ff-arglist*))
        ;;Creole--end addition
        ((eq format :double)
         (push* :ptr `(%get-ptr ,arg 4) :ptr `(%get-ptr ,arg) *ff-arglist*))
        ((eq format :extended)
         (if fpu-p
           (let ((ptr (gensym)))
             (push `(,ptr 12) *ff-stackblock*)
             (push `(%float2x12 ,arg ,ptr) *ff-prolog*)
	     (push* :ptr `(%get-ptr ,ptr 8) :ptr `(%get-ptr ,ptr 4)
	            :ptr `(%get-ptr ,ptr) *ff-arglist*))
	   (let ((ptr (gensym)))
             (push `(,ptr 10) *ff-stackblock*)
             (push `(%float2x ,arg ,ptr) *ff-prolog*)
	     (push* :ptr `(%get-ptr ,ptr 6) :ptr `(%get-ptr ,ptr 2)
	            :word `(%get-word ,ptr) *ff-arglist*))))
        ((eq format :ptr) (push* :ptr arg *ff-arglist*))
        ((eq format :lisp-ref)
         (let ((ptr (gensym)))
           (push* :ptr ptr *ff-arglist*)
           (setq *ff-outer* `(%vreflet ((,ptr ,arg)) ,*ff-outer*))))
        ;;Creole---this clause added for Creole
        ((and (consp format) (eq (%car format) :Creole))
         (push* format arg *ff-arglist*))
        (t (ff-incompat-err :by-value format))))

(defun push-by-address (format lisp-type arg ref-p &optional fpu-p &aux (ptr (gensym)))
  (declare (special *ff-stackblock* *ff-prolog* *ff-epilog* *ff-outer* *ff-arglist*))
  (when (and ref-p (eq format :pstring)) (setq format '(:pstring 255)))
  (cond ((eq format :long)
         (when ref-p (ff-incompat-err :by-reference format))
         (push `(,ptr 4) *ff-stackblock*)
         (push (cond ((subtypep lisp-type 'fixnum)
                      `(%put-long ,ptr ,arg))
                     ((subtypep lisp-type 'character)
                      `(%put-long ,ptr (%char-code ,arg)))
                     (t `(%put-long-value ,ptr ,arg))) *ff-prolog*))
        ((eq format :word)
         (when ref-p (ff-incompat-err :by-reference format))
         (push `(,ptr 2) *ff-stackblock*)
         (push (cond ((subtypep lisp-type 'fixnum)
                      `(%put-word ,ptr ,arg))
                     ((subtypep lisp-type 'character)
                      `(%put-word ,ptr (%char-code ,arg)))
                     (t `(%put-word ,ptr ,arg))) *ff-prolog*))
        ;;Creole--start addition
        ((eq format :c-boolean)
         (when ref-p (ff-incompat-err :by-reference format))
         (push `(,ptr 4) *ff-stackblock*)
         (push `(%put-long ,ptr (if ,arg 1 0)) *ff-prolog*))
        ((eq format :c-char)
         (when ref-p (ff-incompat-err :by-reference format))
         (push `(,ptr 4) *ff-stackblock*)
         (push `(%put-long ,ptr (%char-code ,arg)) *ff-prolog*))
        ;;Creole--end addition
        ((or (eq format :ptr) (eq format :lisp-ref))
         (when ref-p (ff-incompat-err :by-reference format))
         (when (eq format :lisp-ref)
           (let ((vptr (gensym)))
             (setq *ff-outer* `(%vreflet ((,vptr ,arg)) ,*ff-outer*))
             (setq arg vptr)))
         (push `(,ptr 4) *ff-stackblock*)
         (push `(%put-ptr ,ptr ,arg) *ff-prolog*))
        ((eq format :double)
         (push `(,ptr 8) *ff-stackblock*)
         (push `(%put-double ,arg ,ptr) *ff-prolog*)
         (when ref-p
           (push `(%get-double ,ptr ,arg) *ff-epilog*)))
        ((eq format :extended)
         (when fpu-p (error "Don't handle FPU yet."))
         (push `(,ptr 10) *ff-stackblock*)
         (push `(%float2x ,arg ,ptr) *ff-prolog*)
         (when ref-p (push `(%x2float ,ptr ,arg) *ff-epilog*)))
        ((or (eq format :pstring)
             (and (consp format) (eq (%car format) :pstring)))
         (if (eq format :pstring)
           (setq *ff-outer* `(%vstack-block (,ptr (1+ (length ,arg))) ,*ff-outer*))
           (push `(,ptr (1+ ,(%car (%cdr format)))) *ff-stackblock*))
         (push `(%store-pstr ,arg ,ptr ,@(and (neq format :pstring) (%cdr format)))
               *ff-prolog*)
         (when ref-p (push `(%restore-pstr ,ptr ,arg) *ff-epilog*)))
        ((or (eq format :cstring)
             (and (consp format) (eq (%car format) :cstring)))
         (if (eq format :cstring)
           (setq *ff-outer* `(%vstack-block (,ptr (1+ ;;Creole---added check for nil (becomes null string)
                                                   (if (null ,arg) 0 (length ,arg)))) ,*ff-outer*))
           (push `(,ptr (1+ ,(%car (%cdr format)))) *ff-stackblock*))
         (push ;;Creole---added check for nil (becomes null string)
               `(if (null ,arg)
                  (%put-byte ,ptr 0)
                  (%put-cstring ,ptr ,arg ,@(and (neq format :cstring) `(0 ,@(%cdr format)))))
               *ff-prolog*)
         (when ref-p (push `(%restore-cstr ,ptr ,arg) *ff-epilog*)))
        ;;Creole---
        (t
         (error "I don't know what to do here!!")))
  (push* :ptr ptr *ff-arglist*))

(defun ff-incompat-err (x y)
  (error "Incompatible flags ~S and ~S" x y))

;;;;;;;;;;;;;;;;;;;;  Runtime support ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun %put-long-value (ptr datum)
  (cond ((bignump datum)
         (%put-word ptr (logand (ash datum -16) #xFFFF))
         (%put-word ptr (logand datum #xFFFF) 2))
        (t (when (characterp datum) (setq datum (%char-code datum)))
           (%put-long ptr datum))))



;Umpteenth version of %put-string...
(defun %store-pstr (string ptr &optional len &aux (slen (length string)) (pos 0) data offset)
  (when (or (%i> slen 255) (and len (%i> slen len)))
    (error "String too big to fit in record"))
  (while (multiple-value-setq (data offset) (displaced-array-p string))
    (setq string data pos (+ pos offset)))
  (dotimes (i slen)
    (declare (fixnum i))
    (%put-byte ptr (%char-code (schar string (%i+ pos i))) (%i+ i 1)))
  (%put-byte ptr slen)
  ptr)

(defun %restore-pstr (ptr string &aux (plen (%get-byte ptr)) (pos 0) data offset)
  (unless (eq plen (length string)) (adjust-array string plen))
  (while (multiple-value-setq (data offset) (displaced-array-p string))
    (setq string data pos (%i+ pos offset)))
  (dotimes (i plen)
    (declare (fixnum i))
    (setf (schar string i) (%code-char (%get-byte ptr (%i+ i 1))))))
 

(defun %restore-cstr (ptr string &aux (plen 0) (pos 0) data offset)
  (do* () ((%izerop (%get-byte ptr plen)) nil) (setq plen (%i+ plen 1)))
  (unless (eq plen (length string)) (adjust-array string plen))
  (while (multiple-value-setq (data offset) (displaced-array-p string))
    (setq string data pos (%i+ pos offset)))
  (dotimes (i plen)
    (declare (fixnum i))
    (setf (schar string (%i+ pos i)) (%code-char (%get-byte ptr i)))))

#-ppc-target
(progn

(defun %float2x (float ptr)
  (lap-inline ()
    (:variable float ptr)
    (sub.l ($ $t_dfloat) arg_y)
    (move.l arg_y atemp0)
    (fmove.d @atemp0 fp0)
    (begin_csarea)
    (lea (sp -12) sp)
    (move.l sp atemp1)
    (begin_csarea)
    (fmove.x fp0 @atemp1)
    (move.l acc atemp0)  ;return ptr
    (jsr_subprim $sp-macptrptr)
    (move.w atemp1@+ atemp0@+)
    (add.w ($ 2) atemp1)
    (move.l atemp1@+ atemp0@+)
    (move.l atemp1@+ @atemp0)
    (spop_discard_csarea)))

(defun %x2float (ptr float)
  (lap-inline ()
    (:variable ptr float)
    (move.l arg_y atemp0)
    (jsr_subprim $sp-macptrptr)
    (begin_csarea)
    (move.l (atemp0 6) -@sp)
    (move.l (atemp0 2) -@sp)
    (clr.w -@sp)
    (move.w @atemp0 -@sp)
    (move.l sp atemp1)
    (begin_csarea)
    (FMOVE.X @atemp1 FP0);(dc.w #xF211 #x4800)
    (fmove.d fp0 @atemp1);(dc.w #xF211 #x7400)
    (move.l acc atemp0)  ;return float
    (jsr_subprim $sp-macptrptr)
    (move.l atemp1@+ atemp0@+)
    (move.l atemp1@+ @atemp0)
    (spop_discard_csarea)))

(defun %get-x2float (ptr)
  (%stack-block ((double 8))
    (%copy-float (%x2float ptr double))))

; Copies the full 12 bytes of an extended to a pointer.
(defun %float2x12 (float ptr)
  (lap-inline ()
    (:variable float ptr)
    (sub.l ($ $t_dfloat) arg_y)
    (move.l arg_y atemp0)
    (fmove.d @atemp0 fp0)
    (begin_csarea)
    (lea (sp -12) sp)
    (move.l sp atemp1)
    (begin_csarea)
    (fmove.x fp0 @atemp1)
    (move.l acc atemp0)  ;return ptr
    (jsr_subprim $sp-macptrptr)
    (move.l atemp1@+ atemp0@+)
    (move.l atemp1@+ atemp0@+)
    (move.l atemp1@+ @atemp0)
    (spop_discard_csarea)))

; This needs to be uninterruptable until the FMOVE.D instruction.
; Otherwise FP0 might be clobberred.
(defun %get-fp0 ()
  (declare (optimize (speed 3) (safety 0)))     ; prevent event processing at entry
  (%stack-block ((double 8))
    (lap-inline ()
      (:variable double)
      (move.l (varg double) atemp0)
      (move.l (atemp0 $macptr.ptr) atemp0)
      (FMOVE.D fp0 @atemp0))
    (%copy-float double)))

(defun %put-double (flt ptr)
  (old-lap-inline ()
    (move.l (varg ptr) atemp0)
    (jsr_subprim $sp-macptrptr)
    (move.l (varg flt) atemp1)
    (sub ($ $t_dfloat) atemp1)
    (move.l atemp1@+ atemp0@+)
    (move.l @atemp1 @atemp0)
    (move.l nilreg acc)))

; Sounds like a bad idea to me ...
(defun %get-double (ptr flt)
  (old-lap-inline ()
    (move.l (varg ptr) atemp0)
    (jsr_subprim $sp-macptrptr)
    (move.l (varg flt) atemp1)
    (sub ($ $t_dfloat) atemp1)
    (move.l atemp0@+ atemp1@+)
    (move.l @atemp0 @atemp1)
    (move.l nilreg acc)))

) ; #-ppc-target


#+ppc-target
(progn

#| ;; aargh
(defun %float2x (float ptr)
  (with-macptrs ((float-ptr 8))
    (%put-double float float-ptr)
    (#_dtox80 float-ptr ptr))
  ptr)
|#

(defun %float2x (float ptr)
  (rlet ((float-ptr :double-float)) ; (ccl::with-macptrs ((ccl::float-ptr 8))
    (%put-double-float float-ptr float)
    (#_dtox80 float-ptr ptr))
  ptr)

(eval-when (:compile-toplevel :execute)
  ; For %make-dfloat
  (require "NUMBER-MACROS" "ccl:compiler;ppc;number-macros"))

(defun %x2float (ptr float-ptr)
  (let ((float (%make-dfloat)))
    (declare (dynamic-extent float))
    (%x2float-internal ptr float)
    (%put-double float float-ptr))
  float-ptr)

(defun %get-x2float (ptr)
  (%x2float-internal ptr (%make-dfloat)))

(defun %x2float-internal (ptr float)
  (%setf-double-float float (#_x80tod ptr))
  (%df-check-exception-1 '%x2float ptr)
  float)

; Copies the full 12 bytes of an extended to a pointer.
(defun %float2x12 (float ptr)
  (%float2x float ptr)
  (setf (%get-word ptr 10) (%get-word ptr 8)
        (%get-word ptr 8) (%get-word ptr 6)
        (%get-word ptr 6) (%get-word ptr 4)
        (%get-word ptr 4) (%get-word ptr 2)
        (%get-word ptr 2) 0)
  ptr)

; This needs to be uninterruptable until the FMOVE.D instruction in *get-fp0-68k*.
; Otherwise FP0 might be clobberred.
; The *get-fp0-68K* code will get an illegal instruction trap
; unless a 68K FPU emulator is installed. But then the user 68881 code
; can't be running on a PPC unless that is so, so we're not in trouble.

(defun %get-fp0 ()
  (declare (optimize (speed 3) (safety 0)))
  (without-interrupts
   (%stack-block ((double 8))
     (ff-call *get-fp0-68K* :ptr double)
     (%copy-float double))))

(defun %put-double (flt ptr)
  (%copy-ivector-to-ptr flt (* 4 ppc::double-float.value-cell) ptr 0 8))

; Sounds like a bad idea to me ...
(defun %get-double (ptr flt)
  (%copy-ptr-to-ivector ptr 0 flt (* 4 ppc::double-float.value-cell) 8))

) ; #+ppc-target
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 FF-CALL, the function.                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;This definition must match the compiler!
;The compiler must match this definition!
;The compiler and this definition must match!
;This definition and the compiler must match!
;This definition is in L1-APRIMS!
#|

          

|#



;;;Support for dumplisp

(defun %ptr-to-ivector (p)
  (let* ((psize (#_GetPtrSize p))
         (v (make-array psize :element-type '(unsigned-byte 8))))
    (dotimes (i psize v)
      (declare (fixnum i))
      (setf (aref v i) (%get-byte p i)))))

(defun %ivector-to-ptr (v &optional (p (#_NewPtr (length v))))
  (dotimes (i (length v) p)
    (declare (fixnum i))
    (%put-byte p (aref v i) i)))

;;; Compute a more compact representation of the a5 abs refs data, which
;;; is collected as a list with entries of the form
;;;   (a5-offset-referenced flags . a5-offset-references)
;;;
;;; Compressed representation is a simple-vector with 4 elements per logical entry,
;;; with each logical entry being for a specific flags value (it turns out that
;;; the number of distinct flag values is very small, so factoring them out of the
;;; uncompressed form is very beneficial).
;;;
;;; Each logical entry contains the following items:
;;;  0: flags value for this entry
;;;  1: smallest a5-offset-referenced value with the indicated flags
;;;  2: 8bit vector delta table, with the base being #1.
;;;  3: simple-vector of offset references for the corresponding entries in #2.
;;;
;;; For AppLex (1.0b4r11, a large program) this compression saved about 150K.
;;;
;;; --- kab, 10/17/94: The delta table could be further compressed by putting
;;; --- two 4bit values per 8bit element when possible, since the deltas tend
;;; --- to be small.  Also, it might be that all deltas will be 0 mod(2) or
;;; --- maybe even 0 mod(4), which would allow more compression because more
;;; --- deltas could be packed into 4 bits.  The added complexity didn't seem
;;; --- worth the benefit (less than 3K for AppLex 1.0b4r11).
(eval-when (compile eval)
(defconstant +compressed-a5-abs-ref-16bit-entry+ 254)
(defconstant +compressed-a5-abs-ref-32bit-entry+ 255)
(defconstant +compressed-a5-abs-ref-8bit-entry-max+ +compressed-a5-abs-ref-16bit-entry+)
(defconstant +compressed-a5-abs-ref-16bit-entry-max+ 65536)
)

(defun ff-compress-a5-abs-refs (refs)
  (let ((flag-alist ()))
    ;; Factor out flags, and split entries with multiple offset references.
    (dolist (entry refs)
      (destructuring-bind (refd flags . refs) entry
        (let ((flag-entry (assoc flags flag-alist)))
          (when (null flag-entry)
            (setf flag-entry (list flags))
            (push flag-entry flag-alist))
          (dolist (ref refs) (push (cons refd ref) (cdr flag-entry))))))
    (do* ((flag-count (length flag-alist))
          (result (make-array (* 4 flag-count)))
          (entries flag-alist (cdr entries))
          (index 0 (+ index 4)))
         ((null entries) result)
      (destructuring-bind (flags . refs) (car entries)
        (setf (svref result index) flags)       ; flags
        (setf refs (sort refs #'< :key #'car))
        (setf (svref result (+ index 1)) (caar refs))   ; base
        (do* ((count (length refs))
              (refs-table (make-array count))
              (refd-table (make-array count
                                      :element-type '(unsigned-byte 8)
                                      :fill-pointer 0
                                      :adjustable t))
              (base (caar refs) (caar refs))
              (refs refs (cdr refs))
              (refs-table-index 0 (1+ refs-table-index)))
             ((null refs)
              (setf (svref result (+ index 2)) (copy-seq refd-table))
              (setf (svref result (+ index 3)) refs-table))
          (destructuring-bind (refd . ref) (car refs)
            (setf (svref refs-table refs-table-index) ref)
            (let ((delta (- refd base)))
              (cond ((< delta +compressed-a5-abs-ref-8bit-entry-max+)
                     (vector-push-extend delta refd-table))
                    ((< delta +compressed-a5-abs-ref-16bit-entry-max+)
                     (vector-push-extend +compressed-a5-abs-ref-16bit-entry+ refd-table)
                     (vector-push-extend (logand #xFF delta) refd-table)
                     (vector-push-extend (ash delta -8) refd-table))
                    (t
                     (vector-push-extend +compressed-a5-abs-ref-32bit-entry+ refd-table)
                     (vector-push-extend (logand #xFF delta) refd-table)
                     (vector-push-extend (logand #xFF (ash delta -8)) refd-table)
                     (vector-push-extend (logand #xFF (ash delta -16)) refd-table)
                     (vector-push-extend (logand #xFF (ash delta -24)) refd-table)))))
          )))))

;;; For mapping over the compressed representation.
(eval-when (compile eval)
(defmacro do-a5-abs-refs ((reference flags roffset) refs &body body)
  (let ((rdata (gensym))
        (index (gensym))
        (end (gensym))
        (flag-data (gensym))
        (refd (gensym))
        (refd-table (gensym))
        (refd-index (gensym))
        (ref-table (gensym))
        (ref-index (gensym))
        (ref-end (gensym))
        (delta (gensym)))
    `(do* ((,rdata ,refs)
           (,index 0 (+ ,index 4))
           (,end (length ,rdata)))
          ((<= ,end ,index))
       (do* ((,flag-data (svref ,rdata ,index))
             (,refd (svref ,rdata (1+ ,index)))
             (,refd-table (svref ,rdata (+ ,index 2)))
             (,refd-index 0)
             (,ref-table (svref ,rdata (+ ,index 3)))
             (,ref-index 0 (1+ ,ref-index))
             (,ref-end (length ,ref-table)))
            ((<= ,ref-end ,ref-index))
         (let ((,delta (aref ,refd-table ,refd-index)))
           (cond ((< ,delta +compressed-a5-abs-ref-8bit-entry-max+)
                  (incf ,refd-index 1))
                 ((= ,delta +compressed-a5-abs-ref-16bit-entry+)
                  (setf ,delta (logior (aref ,refd-table (+ ,refd-index 1))
                                       (ash (aref ,refd-table (+ ,refd-index 2)) 8)))
                  (incf ,refd-index 3))
                 ((= ,delta +compressed-a5-abs-ref-32bit-entry+)
                  (setf ,delta (logior (aref ,refd-table (+ ,refd-index 1))
                                       (ash (aref ,refd-table (+ ,refd-index 2)) 8)
                                       (ash (aref ,refd-table (+ ,refd-index 3)) 16)
                                       (ash (aref ,refd-table (+ ,refd-index 4)) 24)))
                  (incf ,refd-index 5))
                 (t
                  (error "Can't happen!")))
           (setf ,refd (+ ,refd ,delta))
           (let ((,flags ,flag-data)
                 (,reference ,refd)
                 (,roffset (svref ,ref-table ,ref-index)))
             ,@body))))))
)

(defun copy-ffenv (e)
  (setq e (require-type e 'ffenv))
  (let ((copy (copy-uvector e)))
    (setf (ffenv-entries copy) (copy-uvector (ffenv-entries e))
          (ffenv-seg-ptrs copy) (copy-uvector (ffenv-seg-ptrs e)))
    copy))

; aint right yet
(defun ff-save-env (e &optional make-copy-p)
  ; <<< this part is from old world order <<<
  (unless make-copy-p
    (let ((initial-image (ffenv-initial-image e)))
      (when initial-image
        (let ((initial-entries (ffenv-entries initial-image))
              (entries (ffenv-entries e)))
          ;(declare (list initial-entries))
          (dotimes  (i (length entries))
            (let ((entry (svref entries i))
                  (initial-entry (svref initial-entries i)))
              (declare (cons entry))
              (declare (cons initial-entry))
              (unless (eq (car entry) (car initial-entry))
                (error "Mismatch between entry & initial-entry"))
              (setf (cdr entry) (cdr initial-entry)))))        
        (let ((seg-ptrs (ffenv-seg-ptrs e))
              (initial-seg-ptrs (ffenv-seg-ptrs initial-image)))
          (unless (eql (length seg-ptrs) (length initial-seg-ptrs))
            (error "Length mismatch between ffenv and initial-image"))
          (dotimes (i (length seg-ptrs))
            (setf (svref seg-ptrs i)(svref initial-seg-ptrs i))))
        (let ((a5-world (%inc-ptr (ffenv-a5ptr e) (ffenv-data-offset e))))
          (setf (ffenv-a5ptr e) (ffenv-a5ptr initial-image))
          (#_DisposePtr :check-error a5-world))
        (return-from ff-save-env e))))
  (let* ((e (if make-copy-p (copy-ffenv e) e))
         (a5ptr (ffenv-a5ptr e))
         (entries (ffenv-entries e))
         (data-offset (ffenv-data-offset e))
         (jtab-offset (ffenv-jtab-offset e))
         (seg-ptrs (ffenv-seg-ptrs e))
         (nsegs (length seg-ptrs))
         (seg-starts (make-array nsegs))
         (seg-ends (make-array nsegs))
         (njtab-entries (floor (- jtab-offset 32) 8)))
    ;;Restore absolute a5 refs to unitialized state
    (let ((a5int (%ptr-to-int a5ptr)))
      (do-a5-abs-refs (referenced flags roffset)
                      (ffenv-a5-abs-refs e)
        (subtract-ref (%inc-ptr a5ptr roffset)
                      (+ a5int referenced)
                      flags)))
    (let ((start nil))
      (dotimes (i nsegs)
        (let ((seg (svref seg-ptrs i)))
          (setf (aref seg-starts i) (setq start (%ptr-to-int seg)))
          (setf (aref seg-ends i) (+ start (#_GetPtrSize seg))))))
    (ff-unload-jtab a5ptr njtab-entries nsegs seg-starts seg-ends)
    (dotimes (i nsegs)
      (let ((seg (svref seg-ptrs i)))
        (setf (svref seg-ptrs i) (%ptr-to-ivector seg))
        (#_DisposePtr :check-error seg)))
    (let ((a5-fixnum (%ptr-to-int a5ptr)))
      (dotimes (i (length entries))
        (let ((entry (svref entries i)))
          (%rplacd entry (- (%ptr-to-int (%cdr entry)) a5-fixnum)))))
    (let ((a5-world (%inc-ptr a5ptr data-offset)))
      (setf (ffenv-a5ptr e) (%ptr-to-ivector a5-world))
      (#_DisposePtr :check-error a5-world))
    t))

(defun ff-restore-env (e)
  (let* ((a5ptr (ffenv-a5ptr e))
         (entries (ffenv-entries e))
         (data-offset (ffenv-data-offset e))
         (jtab-offset (ffenv-jtab-offset e))
         (seg-ptrs (ffenv-seg-ptrs e))
         (njtab-entries (floor (- jtab-offset 32) 8)))
    (dotimes (i (length seg-ptrs))
      (let ((seg (svref seg-ptrs i)))
        (setf (svref seg-ptrs i) (%ivector-to-ptr seg))))
    (let ((a5-world (%ivector-to-ptr a5ptr)))
      (setq a5ptr (setf (ffenv-a5ptr e) (%inc-ptr a5-world (- data-offset)))))
    (dotimes (i (length entries))
      (let ((entry (svref entries i)))
        (%rplacd entry (%inc-ptr a5ptr (cdr entry)))))
    (ff-reload-jtab a5ptr njtab-entries seg-ptrs)
    ;;Recalculate absolute a5 refs
    (let ((a5int (%ptr-to-int a5ptr)))
      (do-a5-abs-refs (referenced flags roffset)
                      (ffenv-a5-abs-refs e)
        (add-ref (%inc-ptr a5ptr roffset)
                 (+ a5int referenced)
                 flags)))
    (%put-ptr a5ptr (%get-ptr (%currentA5))) ; Amen.
    #-ppc-target (%primitive $sp-clrcache :acc)
    #+ppc-target (flush-code-cache)
    t))

(defun ff-unload-jtab (a5ptr njtab nsegs starts ends)
  (let ((addr (%inc-ptr a5ptr 36))
        (target nil))
    (dotimes (i njtab)
      (declare (fixnum i))
      (setq target (%get-long addr))
      (dotimes (j nsegs #-bccl (error "Bug - can't find jump target #x~x" target))
        (declare (fixnum j))
        (when (and (>= target (aref starts j))
                   (< target (aref ends j)))
          (%put-word addr j)
          (%put-word addr (- target (aref starts j)) 2)
          (return)))
      (setq addr (%inc-ptr addr 8)))))
      
(defun ff-reload-jtab  (a5ptr njtab seg-ptrs)
  (let ((addr (%inc-ptr a5ptr 36)))
    (dotimes (i njtab)
      (declare (fixnum i))
      (%put-ptr addr (%inc-ptr (svref seg-ptrs (%get-word addr)) (%get-word addr 2)))
      (setq addr (%inc-ptr addr 8)))))

(defun ff-save-envs ()
  (dolist (env *ffenvs*)
    (ff-save-env env)))

(defun ff-restore-envs ()
  (dolist (env *ffenvs*)
    (ff-restore-env env)))

(pushnew 'ff-save-envs *save-exit-functions*)
(pushnew 'ff-restore-envs *restore-lisp-functions*)

;;;    1  10/20/94  kab          1.9d079
