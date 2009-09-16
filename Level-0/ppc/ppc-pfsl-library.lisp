;;;-*- Mode: Lisp; Package: CCL -*-

; ppc-pfsl-library.lisp
; Copyright 1997 Digitool, Inc. The 'tool rules!

; level-0 support for pfsl-libraries.
; This stuff is necessary to load a pfsl-library created
; by "ccl:xdump;pfsl-library.lisp".

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;;
;;; (compiler-let ((*dont-use-cfm* nil))
;;; ----- 5.1 final
;;; As far as I know most of this file is an experiment that didn't work, hence mostly ignored
;;; ------ 5.0 final
;;; pbopensync -> pbhopensync - egads
;;;;; -------4.4b5
;;; 04/24/97 bill  New file
;;;

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; To do
;;;
;;; Make it work in level-0
;;;

#-ppc-target
(eval-when (:compile-toplevel :execute :load-toplevel)
  (error "This file does not work in 68K MCL"))

(eval-when (:compile-toplevel :execute)

(require "PFSL-LIBRARY-ENV" "ccl:xdump;pfsl-library-env")

)

#+ignore
(eval-when (:compile-toplevel :execute)

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

(defvar *dont-use-cfm*)

#+ignore
(compiler-let ((*dont-use-cfm* nil))

; Can't call traps in level-0, so we make functions out of the ones we need
;(define-l0-trap-function "HOpenResFile" vrefnum dirid filename permission)
;(define-l0-trap-function "Get1Resource" restype id)
;(define-l0-trap-function "HGetState" handle)
;(define-l0-trap-function "HLock" handle)
;(define-l0-trap-function "HUnlock" handle)
;(define-l0-trap-function "CloseResFile" refnum)
;(define-l0-trap-function "NewPtrClear" size)
;(define-l0-trap-function "DisposePtr" ptr)
;(define-l0-trap-function "FSMakeFSSpec" vrefnum dirid filename spec)
;(define-l0-trap-function "GetDiskFragment" fileSpec offset length fragName loadFlags connID mainAddr errMessage)
(define-l0-trap-function "PBHOpenSync" pb)  ;; these used in nfasload.lisp
(define-l0-trap-function "PBGetEOFSync" pb)
(define-l0-trap-function "PBCloseSync" pb)
(define-l0-trap-function "PBReadSync" pb)
(define-l0-trap-function "PBSetFPosSync" pb)

)

#+ignore   ; Moved to "ccl:level-0;nfasload.lisp"
(progn

(unless (eql (length *fasl-dispatch-table*) 50)
  (let ((table (make-array 50)))
    (dotimes (i 48)
      (setf (%svref table i) (%svref *fasl-dispatch-table* i)))
    (setq *fasl-dispatch-table* table)
    nil))

(setf (%svref *fasl-dispatch-table* $fasl-library-pointer)
      #'(lambda (s)
          (setf (faslstate.faslval s)
                (pfsl-shared-library-offset s))))

(setf (%svref *fasl-dispatch-table* $fasl-provide)
      #'(lambda (s)
          (provide (%fasl-expr s))))

)

; The base address of the currently open pfsl library.
(defvar *pfsl-library-base* nil)

; This is a pfsl-library ivect describing the currently loading pfsl-library
(defvar *pfsl-library* nil)

(defvar *pfsl-libraries* nil)

(defun *pfsl-libraries* ()
  (or *pfsl-libraries*
      (setq *pfsl-libraries* (make-hash-table :test 'equal))))

(defun %cons-pfsl-library (name pathname area &optional start end)
  (%istruct 'pfsl-library name pathname area start end))

#+ignore
(defun get-pfsl-library (library-name &optional path)
  (let ((truename (and path (probe-file path))))
    (when (or (null path) truename)
      (dolist (pfsl-library (gethash library-name (*pfsl-libraries*)))
        (when (or (null path) (equalp path (pfsl-library.pathname pfsl-library)))
          (return pfsl-library))))))
#+ignore
(defun set-pfsl-library (library-name path &optional (pfsl-library nil pfsl-library-p))
  (unless pfsl-library-p
    (setq pfsl-library path))
  (push pfsl-library (gethash library-name (*pfsl-libraries*)))
  pfsl-library)

; This really should walk memory before close-connection and replace references to
; the shared library with dummys.
#+ignore
(defun close-pfsl-library (pfsl-library)
  (unless (eq (type-of pfsl-library) 'pfsl-library)
    (error "~s is not a pfsl-library" pfsl-library))
  (let ((area (pfsl-library.area pfsl-library))
        (name (pfsl-library.name pfsl-library)))
    (when area
      (setf (pfsl-library.area pfsl-library) nil)
      (close-connection (%get-long area ppc::area.owner))
      (delete-gc-area area))
    (setf (gethash name (*pfsl-libraries*))
          (delete pfsl-library (gethash name (*pfsl-libraries*)) :test 'eq))))

#+ignore
(defun pfsl-shared-library-offset (s)
  (let ((offset (%fasl-read-long s)))
    (declare (fixnum offset))
    (cond ((eql 0 offset) 
           (multiple-value-setq (*pfsl-library-base* *pfsl-library*)
             (let ((filename (or (and (fboundp 'boundp)
                                      (boundp '*load-pathname*)
                                      *load-pathname*)
                                 (%get-ptr (faslstate.fasliopb s) $iofilename))))       ; This is used at level-0 time
               (open-pfsl-shared-library (%fasl-expr s) filename))))
          ((eql 1 offset)
           (let ((pfsl-library *pfsl-library*))
             (when pfsl-library
               (setf (pfsl-library.end pfsl-library) (list :end)))))
          ((null *pfsl-library-base*)
           (error "No open pfsl library"))
          (t (let ((add-offset #'(lambda (&lap 0)
                                   (ppc-lap-function add-offset ((base arg_y) (offset arg_z))
                                                     (unbox-fixnum imm0 offset)
                                                     (svref imm1 macptr.ptr base)
                                                     (add arg_z imm1 imm0)
                                                     (blr)))))
               (funcall add-offset *pfsl-library-base* offset))))))

#+ignore
(defun open-pfsl-shared-library (library-name path)
  (multiple-value-bind (offset length) (find-cfrg library-name path)
    (unless offset
      (error "Library ~s in ~s is not in the file's data fork"
             library-name path))
    (multiple-value-bind (connID mainAddr)
                         (get-disk-fragment library-name path
                                            :offset offset
                                            :length length)
      (let* ((offset (%get-long mainAddr))
             (length (%get-long mainAddr 4)))
        (%incf-ptr mainAddr (- offset))
        (let ((area (add-new-gc-area mainAddr (%inc-ptr mainAddr length) ppc::area-readonly))
              (full-path (unless (macptrp path) (truename path)))
              pfsl-library)
          (setf (%get-long area ppc::area.owner) connID)
          (setq pfsl-library (%cons-pfsl-library library-name full-path area (list :start)))
          (set-pfsl-library library-name full-path pfsl-library)
          (values mainAddr pfsl-library))))))

#+ignore
(defun close-pfsl-shared-library (library-name &optional path)
  (let ((pfsl-library (get-pfsl-library library-name path)))
    (if pfsl-library
      (close-pfsl-library pfsl-library)
      (error "Can't find pfsl-library named ~s" library-name))))

; Find the given cfrg and return its offset & length in the file.
; The third value is the error number if the first two are nil,
; or NIL if the only error was that the given library-name could
; not be found in the cfrg resource.
#+ignore
(defun find-cfrg (library-name path)
  (let ((refnum
         (if (macptrp path)
           (HOpenResFile 0 0 path #$fsRdPerm)
           (with-pstrs ((p (mac-namestring path)))
             (HOpenResFile 0 0 p #$fsRdPerm)))))
    (if (< refnum 0)
      (values nil nil refnum)
      (unwind-protect
        (let ((h (Get1Resource :|cfrg| 0))
              (library-name-length (length library-name)))
          (if (or (%null-ptr-p h)
                  (not (eql $cfrg-version (href h cfrg-header.version))))
            (values nil nil #$resNotFound)
            (let ((locked-p (%ilogbitp 7 (HGetState h))))
              (unwind-protect
                (progn
                  (unless locked-p (HLock h))
                  (with-macptrs ((p (%get-ptr h)))
                    (let ((count (pref p :cfrg-header.fragment-descriptor-count)))
                      (%incf-ptr p (get-field-offset :cfrg-header.descriptors))
                      (dotimes (i count)
                        (when (and (eql $kPowerPC-long 
                                        (%get-long p (get-field-offset :fragment-descriptor.code-type)))
                                   (eql #$kFullLib (pref p :fragment-descriptor.update-level))
                                   (eql #$kOnDiskFlat (pref p :fragment-descriptor.fragment-location))
                                   (with-macptrs ((name (%inc-ptr p (1+ (get-field-offset :fragment-descriptor.name)))))
                                     (and (eql library-name-length (%get-byte name -1))
                                          (dotimes (i library-name-length t)
                                            (unless (eql (char-code (aref library-name i))
                                                         (%get-byte name i))
                                              (return nil))))))
                          (return (values (pref p :fragment-descriptor.fragment-offset)
                                          (pref p :fragment-descriptor.fragment-length))))
                        (%incf-ptr p (pref p :fragment-descriptor.record-length))))))
                ; unwind-protect cleanup
                (unless locked-p (HUnlock h))))))
        ; unwind-protect cleanup
        (CloseResFile refnum)))))
              

; open-pfsl-shared-library should eventually support versions.
; Here's the documentation of the version comparison algorithm
#|

if (Definition.Current == Implementation.Current)
	return(kLibAndAppAreCompatible);
else if (Definition.Current > Implementation.Current)
	/*definition version is newer than implementation version*/
	if (Definition.OldestImp <= Implementation.Current)
		return(kImplAndDefAreCompatible);
	else
		return(kImplIsTooOld);
else
	/*definition version is older than implementation version*/
	if (Implementation.OldestDef <= Definition.Current)
		return(kImplAndDefAreCompatible);
	else
		return(kDefIsTooOld);

|#

; This moves here from ppc-callback-support
(defppclapfunction %setf-macptr-to-object ((macptr arg_y) (object arg_z))
  (check-nargs 2)
  (trap-unless-typecode= arg_y ppc::subtag-macptr)
  (stw arg_z ppc::macptr.address arg_y)
  (blr))

; This moves here from ppc-callback-support
(defppclapfunction %set-object ((macptr arg_x) (offset arg_y) (value arg_z))
  (check-nargs 3)
  (trap-unless-typecode= arg_x ppc::subtag-macptr)
  (macptr-ptr imm0 arg_x)
  (trap-unless-fixnum arg_y imm1)
  (unbox-fixnum arg_y arg_y)
  (stwx arg_z arg_y imm0)
  (blr))

; This moves here from ppc-callback-support
(defppclapfunction %get-object ((macptr arg_y) (offset arg_z))
  (check-nargs 2)
  (trap-unless-typecode= arg_y ppc::subtag-macptr)
  (macptr-ptr imm0 arg_y)
  (trap-unless-fixnum arg_z imm1)
  (unbox-fixnum arg_z arg_z)
  (lwzx arg_z arg_z imm0)
  (blr))

; This moves here from ppc-stack-groups
(defppclapfunction %get-kernel-global-from-offset ((offset arg_z))
  (check-nargs 1)
  (unbox-fixnum imm0 offset)
  (lwzx arg_z imm0 rnil)
  (blr))

; It would be nice to just call the kernel version of this,
; add_area and new_area in "ccl:pmcl;gc.c", but they are not exported.
#+ignore
(defun add-new-gc-area (low-addr high-addr code)
  (let ((area (NewPtrClear ppc::area.size))
        (ndwords (ash (- (%ptr-to-int high-addr) (%ptr-to-int low-addr)) -3)))
    (when (%null-ptr-p area)
      (error "Couldn't allocate area"))
    (setf (%get-ptr area ppc::area.low) low-addr
          (%get-ptr area ppc::area.high) high-addr
          (%get-ptr area ppc::area.active) (if (eql code ppc::area-dynamic) low-addr high-addr)
          (%get-long area ppc::area.ndwords) ndwords)
    (%set-object area ppc::area.code code)
    (with-macptrs (all-areas before before-before)
      (without-interrupts
       (%setf-macptr-to-object all-areas (%get-kernel-global 'all-areas))
       (%setf-macptr before all-areas)
       (loop
         (%setf-macptr before (%get-ptr before ppc::area.succ))
         (let ((before-code (%get-object before ppc::area.code)))
           (when (or (>= code before-code)
                     (eql before all-areas))
             (return))))
       (%setf-macptr before-before (%get-ptr before ppc::area.pred))
       (setf (%get-ptr area ppc::area.pred) before-before
             (%get-ptr area ppc::area.succ) before
             (%get-ptr before-before ppc::area.succ) area
             (%get-ptr before ppc::area.pred) area)))
    area))

; Don't delete the initial empty area or you'll lose bad
#+ignore
(defun delete-gc-area (area)
  (with-macptrs (all-areas an-area)
    (%setf-macptr-to-object all-areas (%get-kernel-global 'all-areas))
    (%setf-macptr an-area (%get-ptr all-areas ppc::area.succ))
    (loop
      (when (eql an-area all-areas)
        (error "Couldn't find area ~s" area))
      (when (eql area an-area)
        (with-macptrs ((pred (%get-ptr area ppc::area.pred))
                       (succ (%get-ptr area ppc::area.succ)))
          (setf (%get-ptr pred ppc::area.succ) succ
                (%get-ptr succ ppc::area.pred) pred)
          (DisposePtr area)
          (return nil)))
      (%setf-macptr an-area (%get-ptr an-area ppc::area.succ)))))

; This function belongs in "ccl:level-0; get-shared-library;l0-cfm-support",
; except you can't call "traps" from level-0.
#+ignore
(defun get-disk-fragment
       (library-name
        pathname
        &key
        (load-flags #$kFindLib)         ; of #$kLoadLib or #$kLoadNewCopy
        (offset 0)
        (length #$kWholeFork)
        (error-p t))
  (if (not (cfm-exists-p))
    (when error-p
      (error "Can't find library ~s since CFM does not exist" library-name))
    (rlet ((connID :long)
           (mainAddr :ptr)
           (errName (:string 255))
           (fsspec :fsspec))
      (if (macptrp pathname)
        (errchk (FSMakeFSSpec 0 0 pathname fsspec))
        (with-pstrs ((nameptr (mac-namestring pathname)))
          (errchk (FSMakeFSSpec 0 0 nameptr fsspec))))
      (with-pstrs ((libName library-name))
        (let ((error
               (GetDiskFragment fsspec offset length libName load-flags connID mainAddr errName)))
          (if (eql error 0)
            (values (%get-long connID) (%get-ptr mainAddr))
            (if (eql load-flags #$kFindLib)
              (get-disk-fragment library-name
                                 pathname
                                 :load-flags #$kLoadLib
                                 :offset offset
                                 :length length
                                 :error-p error-p)
              (let ((error-name (if (string=pstr library-name errName)
                                  library-name
                                  (%get-string errName))))
                (if error-p
                  (error "Can't open shared library ~s.~%GetDiskFragment error number ~s"
                         error-name error)
                  (values nil nil error error-name))))))))))

#+moved-to-nfasload.lisp
; Patch %fasload to notify us of when it starts and stops processing faslops
; Eventually, this code will be merged into MCL.
(defun %fasload (string &optional (table *fasl-dispatch-table*)
                        start-faslops-function
                        stop-faslops-function)
; WITH-PSTRS now calls something called BYTE-LENGTH.
; Presumably, %vect-byte-size isn't good enough for it...
  #|
  (%stack-block ((name 256))
    (let* ((len (length string)))
      (declare (fixnum len))
      (dotimes (i len (setf (%get-byte name) len))
        (setf (%get-byte name (the fixnum (1+ i))) (char-code (schar string i)))))
  |#
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
      (%stack-block ((pb $IOFLSTBLK)
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
                     (if (and (eql #$noErr (setq err (PBOpenSync pb)))
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
                          (if (or (> version (+ #xff00 $fasl-vers))
                                  (< version (+ #xff00 $fasl-min-vers)))
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
