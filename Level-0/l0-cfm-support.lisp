;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 2/13/97  akh  #+ppc-target for byte-length
;;  9 9/4/96   akh  targetize architecture in get-shared-library?
;;  2 11/9/95  bill Temporarily nuke close-connection
;;  1 11/9/95  bill New file
;;  (do not edit before this line!!)


; l0-cfm-support.lisp
; Copyright 1995-1999 Digitool, Inc.
; Support for the Code Fragment Manager

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;
;; get-macho-entry-point has optional framework arg
;; ----- 5.2b1
;; add macho-entry-point
;; -------- 5.1 final
;;; 08/28/04 no change
;;; 07/21/04 resolve-slep-address - try harder if symbol not found in the library we thought it was in.
;;; -------- 5.1b2
;;; add CoreGraphics to lazy-shared-libraries
;;; lose mathlib-sld if carbon
;;; --- 4.4b5
;;; 03/10/02 add "Apple;Carbon;Multimedia" to lazy-shared-libraries fer OSX
;;; 02/19/02 add "SpeechRecognitionLib" to *lazy-shared-libraries* for pre carbon
;;; 06/14/01 see get-shared-library re OSX
;;; ------- 4.4b1
;;; 04/15/01 akh see resolve-slep-address re classic problem
;;; 12/23/00 akh dont call (interfacelib-sld) if carbon
;;; akh dont use libname in load-shared-library-entry-point - it changes from day to day
;;;       add "MPLibrary" and "NavigationLib" to lazy-shared-libraries
;;; 07/04/98 akh   add-to-shared-library-search-path: if second arg (optional) is :check will error if not found
;;; 02/06/97 akh   define byte-length iff undefined
;;; 01/17/97 bill  Add "AppleGuideGlueLib" to *lazy-shared-libraries*
;;; 12/26/96 bill  Make close-connection work on the 68K.
;;; -------------  4.0
;;; 06/03/96 bill  Remove some obsolete comments.
;;; -------------  MCL-PPC 3.9
;;; 03/22/96 bill  reincarnate close-connection in a form that works in level 0.
;;;                reload-shared-library
;;; 03/22/96 bill  %kernel-import & %get-unboxed-ptr no longer store unboxed data in arg_z
;;; 03/11/96 bill  improve get-shared-library's error message.
;;; 03/08 96 bill  initialize-shared-libraries unconditionally calls clear-shared-library-caches
;;;                (I'm paranoid).
;;; 03/06/96 bill  Add more libraries to *lazy-shared-libraries*
;;; 03/05/96 bill  add "ObjectSupportLib", "QuickTimeLib", "DragLib", "TelephoneLib",
;;;                "ProcessMgrSupport", "Translation", "ColorPickerLib", "SpeechLib"
;;;                to *lazy-shared-libraries*
;;;                get-shared-library no longer conses the error-name return value if
;;;                it is the same as the library-name parameter.
;;; 03/01/96 bill  resolve-slep-address passes library-name to get-frag-symbol which uses
;;;                it to generate a better error message.
;;; 02/18/96 bill  *lazy-shared-libraries*, map-over-fixed-and-lazy-shared-libraries
;;;                This gives us a way to add automatically searched shared libraries
;;;                without always opening them.
;;; 01/17/96 bill  shared-library-search-path-entry, add-to-shared-library-search-path,
;;;                remove-from-shared-library-search-path
;;;


; offset is a fixnum, one of the ppc::kernel-import-xxx.
; Returns that kernel import, a fixnum.
#+ppc-target
(defppclapfunction %kernel-import ((offset arg_z))
  (ref-global imm0 kernel-imports)
  (unbox-fixnum imm1 arg_z)
  (lwzx arg_z imm0 imm1)
  (blr))

#+ppc-target
(defppclapfunction %get-unboxed-ptr ((macptr arg_z))
  (macptr-ptr imm0 arg_z)
  (lwz arg_z 0 imm0)
  (blr))

(defvar *cfm-exists-p* :unknown)

(defun cfm-exists-p ()
  (let ((answer *cfm-exists-p*))
    (if (neq answer :unknown)
      answer
      (setq *cfm-exists-p*
            ; Can't call gestalt yet on ppc since expanding it calls cfm-exists-p
            #+ppc-target t
            #-ppc-target (rlet ((res :longint))
                           (and (eql 0 (#_Gestalt #$GestaltCFMAttr res))

                               (logbitp #$GestaltCFMPresent (%get-long res))))))))



; Bootstrapping. Real version is in l1-aprims.
; Called by expansion of with-pstrs
#+ppc-target
(defun byte-length (string &optional script start end)
    (declare (ignore script))
    (when (or start end)
      (error "Don't support start or end args yet"))
    (if (base-string-p string)
      (length string)
      (error "Don't support non base-string yet.")))

; returns four values:
; 1) connection-id or NIL if error and error-p is nil
; 2) main-address
; 3) error-number or NIL if no error
; 4) error-message or NIL if no error
(defun get-shared-library
       (library-name
        &key
        (architecture #+ppc-target #$kPowerPCCFragArch #-ppc-target #$kMotorola68KArch)   ; or #$kMotorola68KArch
        (load-flags #$kFindCFrag)         ; of #$kLoadLib or #$kLoadNewCopy
        (error-p t))
  (if (not (cfm-exists-p))
    (when error-p
      (error "Can't find library ~s since CFM does not exist" library-name))
    (rlet ((connID :long)
           (mainAddr :ptr)
           (errName (:string 255)))
      ;; rumour has it that kfindlib sometimes no work on OSX and I dunno why we do it anyway
      (when (and ;(fboundp 'osx-p)
                 ;(osx-p)                 
                 (eql load-flags #$kfindCfrag))
        (setq load-flags #$kReferenceCFrag))
        
      (with-pstrs ((libName library-name))
        (let ((error
               #-ppc-target
               (#_GetSharedLibrary libName architecture load-flags connID mainAddr errName)
               #+ppc-target
               (ppc-ff-call (%kernel-import ppc::kernel-import-GetSharedLibrary)
                            :address libName
                            :unsigned-fullword architecture       ; an OSTYPE
                            :unsigned-fullword load-flags
                            :address connID
                            :address mainAddr
                            :address errName
                            :signed-halfword)))
          (if (eql error 0)
            (values (%get-long connID) (%get-ptr mainAddr))
            (if (eql load-flags #$kFindCFrag)
              (get-shared-library library-name
                                  :architecture architecture
                                  :load-flags #$kReferenceCFrag
                                  :error-p error-p)
              (let ((error-name (if (string=pstr library-name errName)
                                  library-name
                                  (%get-string errName))))
                (if error-p
                  (error "Can't open shared library ~s.~%GetSharedLibrary error number ~s"
                         error-name error)
                  (values nil nil error error-name))))))))))

(defun string=pstr (string pstr)
  (let ((len (length string)))
    (declare (fixnum length))
    (and (eql len (%get-unsigned-byte pstr 0))
         (dotimes (i len t)
           (declare (fixnum i))
           (unless (eql (char-code (aref string i)) (%get-unsigned-byte pstr (1+ i)))
             (return nil))))))

(defun close-connection (connection-id &optional error-p)
  (unless (cfm-exists-p)
    (error "Attempt to close a CFM connection when there is no CFM present"))
  (rlet ((connID :long))
    (setf (%get-long connID) connection-id)
    ; The ff-call-slep is done explicitly here since xload-level-0 can't fasload make-load-form forms
    (let ((error #+ppc-target
                 (ff-call-slep (get-slep "CloseConnection")   ; (#_CloseConnection connID)
                               :address connID
                               :signed-halfword)
                 #-ppc-target
                 (#_CloseConnection connID)))
      (unless (eql error 0)
        (if error-p
          (error "CloseConnection error number ~s" error)
          error)))))

; Look up a symbol in a code fragment.
; Returns three values:
; 1) Address (a fixnum) or NIL if error-p is NIL and there was an error
; 2) class (a fixnum)
; 3) error-code or NIL if no error
(defun get-frag-symbol (connection-id symbol-name &optional (error-p t) library-name)
  (unless (cfm-exists-p)
    (error "How did you get a connection ID when CFM does not exist?"))
  (rlet ((symAddr :pointer)
         (symClass :byte))
    (with-pstrs ((symName symbol-name))
      (let ((error
             #-ppc-target
             (#_FindSymbol connection-id symName symAddr symClass)
             #+ppc-target
             (ppc-ff-call (%kernel-import ppc::kernel-import-FindSymbol)
                          :unsigned-fullword connection-id
                          :address symName
                          :address symAddr
                          :address symClass
                          :signed-halfword)))
        (if (eql error 0)
          (values #-ppc-target
                  (%get-ptr symAddr)
                  #+ppc-target
                  (%get-unboxed-ptr symAddr)
                  (%get-unsigned-byte symClass))
          (if error-p
            (error "Can't find ~s in shared library ~s.~%FindSymbol error number ~s"
                   symbol-name (or library-name connection-id) error)
            (values nil nil error)))))))

; shared-library-descriptor
; Should eventually track version numbers.
(def-accessor-macros %svref
  nil                                   ; 'shared-library-descriptor
  sld.connID
  sld.name)

; shared-library-entry-point
(def-accessor-macros %svref
  nil                                   ; 'shared-library-entry-point
  slep.address
  slep.sld
  slep.name)

(defun %cons-shared-library-descriptor (connID name)
  (%istruct 'shared-library-descriptor connID name))

(defun shared-library-descriptor-p (x)
  (istruct-typep x 'shared-library-descriptor))

(defun %cons-shared-library-entry-point (address sld name)
  (%istruct 'shared-library-entry-point address sld name))

(defun shared-library-entry-point-p (x)
  (istruct-typep x 'shared-library-entry-point))

; macho-entry-point

(def-accessor-macros %svref
  nil                                   ; 'macho-entry-point
  macho.address
  (macho.foo macho.framework)
  macho.name)

(defun %cons-macho-entry-point (address framework name)
  (%istruct 'macho-entry-point address framework name))

(defun macho-entry-point-p (x)
  (istruct-typep x 'macho-entry-point))


;;; All the (defvar *x* ...) (defun *x* ...) stuff is because
;;; you can't initialize a variable to an evaluated form at level-0 time

; name => shared-library-descriptor
(defvar *shared-libraries* nil)         ; initialize-shared-library sets it

(defun shared-libraries ()
  (or *shared-libraries*
      (setq *shared-libraries*
            (make-hash-table :test 'equal))))

; name => list of shared-library-entry-point's
(defvar *shared-library-entry-points* nil)

(defun shared-library-entry-points ()
  (or *shared-library-entry-points*
      (setq *shared-library-entry-points*
            ; Don't be tempted to make this weak.
            ; It maps a string to a list of slep's.
            ; The list is not held on to by anybody else.
            (make-hash-table :test 'equal))))

(defvar *macho-entry-points* nil)

(defun macho-entry-points ()
  (or *macho-entry-points*
      (setq *macho-entry-points*
            (make-hash-table :test 'equal))))

#|
(defun get-shared-library-descriptor (name &optional (warn-p t) nil-if-error-p)
  (or (gethash name (shared-libraries))
      ; Will need to do something about the architecture parameter here
      ; when we support 68K shared libraries.
      ; Also need to do something about version numbers
      (let ((connID (get-shared-library name :error-p (if (eq warn-p :check) t nil))))
        (unless connID
          (when warn-p
            (warn "Can't find shared library: ~s" name))
          (when nil-if-error-p (return-from get-shared-library-descriptor nil)))
        (setf (gethash name *shared-libraries*)
              (%cons-shared-library-descriptor connID name)))))
|#

(defun get-shared-library-descriptor (name &optional (warn-p t) nil-if-error-p)
  (or (gethash name (shared-libraries))
      ; Will need to do something about the architecture parameter here
      ; when we support 68K shared libraries.
      ; Also need to do something about version numbers
      (let ((connID (get-shared-library name :error-p nil)))
        (unless connID
          (when warn-p
            (warn "Can't find shared library: ~s" name))
          (when nil-if-error-p (return-from get-shared-library-descriptor nil)))
        (setf (gethash name *shared-libraries*)
              (%cons-shared-library-descriptor connID name)))))

(defun resolve-shared-library-connID (sld &optional (error-p t))
  (unless (shared-library-descriptor-p sld)
    (setq sld (require-type sld 'shared-library-descriptor)))
  (or (sld.connID sld)
      (setf (sld.connID sld) (get-shared-library (sld.name sld) :error-p error-p))))

(defvar *InterfaceLib-sld* nil)

(defun InterfaceLib-sld ()
  (or *InterfaceLib-sld*
      (setq *InterfaceLib-sld*
            (get-shared-library-descriptor "InterfaceLib"))))

(defvar *carbonLib-sld* nil)
(defun carbonLib-sld ()
  (or *carbonlib-sld*
      (progn 
        (setq *carbonlib-sld*
              (get-shared-library-descriptor "CarbonLib")))))

(defvar *MathLib-sld* nil)

(defun MathLib-sld ()
  (or *MathLib-sld*
      (setq *MathLib-sld*
            (get-shared-library-descriptor "MathLib"))))

(defvar *shared-library-search-path* nil)

(defun shared-library-search-path ()
  (or *shared-library-search-path*
      (setq *shared-library-search-path*
            ;; this doesn't work when carbon-compat for carbonlib-sld - nope it works
            
            #+carbon-compat ;; dont think we need MathLib here 
            (list (carbonlib-sld)  #-carbon-compat (MathLib-sld))       ; MathLib doesn't exist in Carbon.
            #-carbon-compat
            (list (InterfaceLib-sld) (MathLib-sld)))))

(defun shared-library-search-path-entry (library-name &optional (search-path (shared-library-search-path)))
  (dolist (sld search-path)
    (when (equal library-name (sld.name sld))
      (return sld))))


;; if second arg is :check then you will get an error somewhere along the line if not found or some other problem
(defun add-to-shared-library-search-path (library-name &optional nil-if-error-p)
  (let ((sld
         (or (shared-library-search-path-entry library-name)
             (let ((sld (get-shared-library-descriptor library-name nil nil-if-error-p)))
               (when sld
                 (setq *shared-library-search-path*
                       (nconc *shared-library-search-path* (list sld)))
                 sld)))))
    (if (eq nil-if-error-p :check)
      (cond ((null sld)
             (get-shared-library library-name :error-p t))
            ((null (sld.connID sld))
             ;; it's possible that the thing didn't exist 2 hours ago but it does now.
             (resolve-shared-library-connid sld t)
             sld)
            (t sld))
      sld)))

#|
(defun add-to-shared-library-search-path (library-name &optional nil-if-error-p)
  (let ((sld
         (or (shared-library-search-path-entry library-name)
             (let ((sld (get-shared-library-descriptor library-name (if (eq nil-if-error-p :check) :check nil) nil-if-error-p)))
               (when sld
                 (setq *shared-library-search-path*
                       (nconc *shared-library-search-path* (list sld)))
                 sld)))))
    (if (eq nil-if-error-p :check)
      (if (or (null sld)(null (sld.connID sld)))
        (error "Can't find shared library: ~s" library-name)
        sld)
      sld)))
|#

(defun remove-from-shared-library-search-path (library-name)
  (setq *shared-library-search-path*
        (delete library-name *shared-library-search-path*
                :test 'equal
                :key #'(lambda (x) (sld.name x)))))

; These will be searched if an entry point can't be found in *shared-library-search-path*
; This currently lists all the shared libraries that I could find in
; 'cfrg' resources in system files with all the system extensions I know of installed.
; The commented out ones had no entry points that were also trap names and not
; found in another library that seemed more like the interface library.
(defparameter *lazy-shared-libraries*
  '( "InterfaceLib"
    "AppleScriptLib"
    "ObjectSupportLib"
    "QuickTimeLib"
    "DragLib"
    "MPLibrary"
    "NavigationLib"
    "TelephoneLib"                      ; GeoPort?
    "Translation"
    "ColorPickerLib"
    "SpeechLib"
    "AOCELib"
    "QuickDrawGXLib"
    "ColorSync"
    "PowerMgrLib"
    "XTNDInterface"                     ; I didn't find any traps in this one
    "AppleGuideGlueLib"
    "OTClientLib"       ;; new ones not in libraries above any more if ever were
    "OTUtilityLib"
    "OTClientUtilLib"
    "OTInetClientLib"
    "OpenTransportSupport"
    "SpeechRecognitionLib"
    #+carbon-compat
    "Apple;Carbon;Multimedia"
    ;#+carbon-compat
    ;"CoreGraphics"  ;; not on 10.2.1
    ; "CarbonFrameworkLib"  ;; not in 10.2.1
    "CoreFoundationLib"  ;; on OS9 - not OSX
    #+carbon-compat  ;; below few from ericsc- maybe OSX only?
    "DiscRecordingLib" ;; osx only - not in 10.1.5 nor 10.2.1
    #+carbon-compat
    "OpenGLLib"    ;; osx only - not in 10.1.5 nor 10.2.1
    #+carbon-compat
    "StdCLib"
    #+carbon-compat
    "vecLib"
    #-carbon-compat
    "AppearanceLib"
    #|
    ; These libraries' public (trap) entry points are in one of the libraries above
    "Apple Guide"
    "GXGraphicsLib"
    "Graphics Accelerator"
    "OTATalkClientLib"
    "OTATalkSharedLib"
    "OTATalkConfigLib"
    "OTInetClientLib"
    "OTGlobalLib"
    "OTUtilityLib"
    "OTConfigLib"
    "OTConfigScanLib"
    "OTClientUtilLib"
    "OTNtvUtilLib"
    "OTNativeClientLib"
    "OTClientLib"
    "OTStreamUnixLib"
    "OTXTILib"
    "OTPortScanLib"
    "OTKernelUtilLib"
    "OTKernelContextLib"
    "OTKernelLib"
    "OTModl$sc"
    "OTModl$log"
    ; These libraries were in a 'cfrg' resource but were not found by #_GetSharedLibrary
    "Roman"
    "AppleTalk"
    |#
    ))

(defun map-over-fixed-and-lazy-shared-libraries (function)
  (let ((search-path (shared-library-search-path)))
    (dolist (library search-path) (funcall function library))
    (dolist (library-name *lazy-shared-libraries*)
      (unless (shared-library-search-path-entry library-name search-path)
        (let ((sld (add-to-shared-library-search-path library-name t)))
          (when sld
            (funcall function sld)))))))

(defvar *delayed-search-sld* nil)

(defun delayed-search-sld ()
  (or *delayed-search-sld*
      (setq *delayed-search-sld*
            (%cons-shared-library-descriptor nil nil))))

; slds can be a shared-library-descriptor or a list of them
(defun get-shared-library-entry-point (name &optional slds (warn-p t) nil-if-not-found-p)
  (flet ((new-slep (address sld name)
           (car (push (%cons-shared-library-entry-point address sld name)
                      (gethash name *shared-library-entry-points*)))))
    (if (listp slds)
      (block nil
        (flet ((mapper (sld)
                 (let ((slep (get-shared-library-entry-point name sld nil t)))
                   (when slep (return slep)))))
          (declare (dynamic-extent #'mapper))
          (if slds
            (mapc #'mapper slds)
            (map-over-fixed-and-lazy-shared-libraries #'mapper))
          (when warn-p
            (warn "Can't find entry point ~s in the shared library search path"
                  name))
          (unless nil-if-not-found-p
            (new-slep nil (delayed-search-sld) name))))
      (let ((sleps (gethash name (shared-library-entry-points))))
        ; Can't call require-type at level-0 time
        (unless (shared-library-descriptor-p slds)
          (setq slds (require-type slds 'shared-library-descriptor)))
        (or
         (dolist (slep sleps)
           (when (or (eq slds (slep.sld slep))
                     (and (eq (slep.sld slep) (delayed-search-sld))
                          (memq slds (shared-library-search-path))))
             (return slep)))
         ; Maybe we should check the symbol class here too.
         (let* ((connID (resolve-shared-library-connID slds nil))
                (address (and connID (get-frag-symbol (sld.connID slds) name nil))))
           (unless (or address (not warn-p))
             (warn "Can't find entry point ~s in shared library ~s"
                   name (sld.name slds)))
           (when (or address (not nil-if-not-found-p))
             (new-slep address slds name))))))))

(defun get-macho-entry-point (name &optional framework)
  (or (gethash name (macho-entry-points))
      (setf (gethash name *macho-entry-points*) (%cons-macho-entry-point nil framework name))))

; A shorter name for testing
(defun get-slep (name &rest options)
  (declare (dynamic-extent options))
  (apply 'get-shared-library-entry-point name options))

; This is called at fasload time so don't warn
(defun load-shared-library-entry-point (slep-name &optional sld-name)
  (declare (ignore sld-name))
  (let ((res
         (get-shared-library-entry-point
          slep-name
          nil
          #|
             (if sld-name
             (get-shared-library-descriptor sld-name nil)
                nil)|#
          nil)))
    #+carbon-compat
    (when (and nil (fboundp 'warn))
      (when (eq (slep.sld res) *interfacelib-sld*)
        (warn "~S is in InterfaceLib" slep-name)))
    res))

(defun load-macho-entry-point (name &optional framework)
  (let ((res (get-macho-entry-point name)))
    (setf (macho.framework res) framework)   ;; put a tentative framework name here?
    (setf (macho.address res) nil)
    res))

; This is part of the trap expansion, so it needs to be inline.
; Eventually, we'll put the slep in its own address slot,
; ppc-ff-call that directly, and make the ppc-ff-call subprim
; check for a fixnum and call back if not.
; The % is here since it doesn't type-check the slep arg
; I'd rather (declaim (inline %resolve-slep-addres)) and write
; it as a function, but proclaim doesn't exist in level-0.
(defmacro %resolve-slep-address (slep)
  (let ((slep-sym (gensym)))
    `(let ((,slep-sym ,slep))
       (or (slep.address ,slep-sym)
           (resolve-slep-address ,slep-sym)))))
;; try harder if symbol not found in the library we thought it was in.
;; called from .spffcallslep
(defun resolve-slep-address (slep)
  ;; avoiding event-check here works around a classic problem that occurs the first time MCL is launched the first time it does MenuSelect- 
  ;; I don't understand why the classic problem exists nor why this fixes it, but other than that ...
  (declare (optimize (speed 3)(safety 0)))
  (unless (shared-library-entry-point-p slep)
    (setq slep (require-type slep 'shared-library-entry-point)))
  (or (slep.address slep)
      (let ((sld (slep.sld slep))
            (name (slep.name slep))
            (address nil))
        (if (and (neq sld (delayed-search-sld))
                 (setq address (get-frag-symbol (resolve-shared-library-connID sld) name NIL (sld.name sld)))) ;; <<
          (setf (slep.address slep) address)          
          (dolist (sld (shared-library-search-path)
                       (error "Can't find entry point ~s in shared library search path"
                              name))
            (let ((connID (resolve-shared-library-connID sld nil)))
              (when connID
                (let ((address (get-frag-symbol connID name nil)))
                  (when address
                    (setf (slep.sld slep) sld)          ; Now we know which library it's in
                    (return (setf (slep.address slep) address)))))))))))

; Called by restore-lisp-pointers

(defun initialize-shared-libraries ()
  (clear-shared-library-caches)
  (cfm-exists-p)
  #+ignore
  (when *shared-library-entry-points*
    (maphash #'(lambda (name sleps)
                 (declare (ignore name))
                 (dolist (slep sleps)
                   (resolve-slep-address slep)))
             *shared-library-entry-points*))
  )


; The very last thing that kill-lisp-pointers calls.
; Hence, don't call any traps here.
(defun clear-shared-library-caches ()
  (setq *cfm-exists-p* :unknown)
  (setq *shared-library-search-path* nil)
  (when *shared-libraries*
    (maphash #'(lambda (name sld)
                 (declare (ignore name))
                 (setf (sld.connID sld) nil))
             *shared-libraries*))
  (when *shared-library-entry-points*
    (maphash #'(lambda (name sleps)
                 (declare (ignore name))
                 (dolist (slep sleps)
                   ; (setf (slep.sld slep) (delayed-search-sld))  ;; could do that if really think sleps may move
                   (setf (slep.address slep) nil)))
             *shared-library-entry-points*))
  (when *macho-entry-points*
    (maphash #'(lambda (name macho)
                 (declare (ignore name))
                 (setf (macho.address macho) nil))
             *macho-entry-points*)))

; This is useful when a change is made to a shared library file.
; reloading that shared library will cause it to be released from
; memory and reloaded from the file.
(defun reload-shared-library (library-name)
  (let ((library (if (typep library-name 'shared-library-descriptor)
                   library-name
                   (gethash library-name (shared-libraries)))))
    (when library
      (without-interrupts
       (maphash #'(lambda (name sleps)
                    (declare (ignore name))
                    (dolist (slep sleps)
                      (when (eq library (slep.sld slep))
                        (setf (slep.address slep) nil))))
                *shared-library-entry-points*)
       (let ((connID (sld.connID library)))
         (when connID
           (setf (sld.connID library) nil)
           (close-connection connID t)))))))
