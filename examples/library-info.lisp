;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; library-info.lisp

(in-package "CCL")

#-carbon-compat
(progn

(eval-when (:compile-toplevel :load-toplevel :execute)
  (add-to-shared-library-search-path "CodeFragmentMgr")
  (add-to-shared-library-search-path "PrivateInterfaceLib")
  
  (deftrap "_FragGetConnectionInfo"  ((contextID :unsigned-long)
                                      (connectionID :unsigned-long)
                                      (flag :unsigned-byte)
                                      (info :pointer))
           (:stack :signed-integer)
    (:stack-trap #xAA5A contextID  connectionID flag info (-13 :signed-integer)))
  
  (deftrap "_GetCurrentProcessFragContext" ()
           (:no-trap :unsigned-long)
    (:no-trap))
  )

(defun library-info (libname)
  (%stack-block ((info 140)
                 (nameptr 72))
    (setf (%get-ptr info 24) nameptr)
    (let* ((err (#_FragGetConnectionInfo
                 (#_GetCurrentProcessFragContext)
                 (get-shared-library libname)
                 0
                 info)))
      (declare (fixnum err))
      (if (= err #$noErr)
        (let* ((locator (%inc-ptr info #x14)))
          (case (pref locator :CFragHFSLocator.where)
            (#.#$kDataForkCFragLocator
             (let* ((spec (pref locator :CFragHFSLocator.onDisk.fileSpec)))
               `(:file ,(%path-from-params 
                         (pref spec :fsspec.vrefnum)
                         (pref spec :fsspec.parid)
                         (%inc-ptr spec #.(get-field-offset :FSSpec.name)))
                       ,(pref locator :CFragHFSLocator.onDisk.offset)
                       ,(pref locator :CFragHFSLocator.onDisk.length))))
            (#.#$kMemoryCFragLocator
             `(:memory ,(pref locator :CFragHFSLocator.inMem.address) 
                       ,(pref locator :CFragHFSLocator.inMem.length)))))
        `(:error ,err)))))
)


#| Usage examples:

? (library-info "pmcl-kernel4.1")
(:FILE #1P"lisp:CCL3:pmcl:pmcl-kernel" 0 67506)
? (library-info "StdCLib")
(:FILE #1P"sys:System Folder:Extensions:StdCLibInit" 0 73376)
? (library-info "ThreadsLib")
(:MEMORY #<A Mac Non-zone Pointer #x1A1A50> 15296)

|#
