;;-*- mode: lisp; package: ccl -*-;; Makes choose-file-dialog recognize most text files when :mac-file-type keyword is :TEXT;; and recognize packages in general as if they were files.;; Patch for (R)MCL 5.2 - issue #10 at mcl.googlecode.com;; October 2009. Terje Norderhaug <terje@in-progress.com> ;; License: LLGPL.(in-package :ccl)(eval-when (:load-toplevel :compile-toplevel :execute)  (deftrap-inline "_NavDialogSetFilterTypeIdentifiers"  ; not defined in (R)MCL 5.2    ((inGetFileDialog :NavDialogRef)     (inTypeIdentifiers :CFArrayRef)) ;AVAILABLE_MAC_OS_X_VERSION_10_4_AND_LATER    :OSStatus    () ))(let ((*WARN-IF-REDEFINE-KERNEL* nil)      (*warn-if-redefine* nil))(defun set-default-dialog-creation-options (options &key location windowTitle
                                           actionButtonLabel cancelButtonLabel
                                           savedFileName message (NavNoTypePopup t)
                                           allowMultipleFiles cfarray
                                           dont-confirm-replacement
                                           clientname)
  (let ((res (#_navgetDefaultDialogCreationOptions options)))
    (if (neq res #$noerr)
      (error "navgetdefaultdialogoptions is unhappy")))
  ;; allow only single selection
  (when (not allowMultipleFiles) ;*choose-allow-multiple-files*)
    (rset options :navDialogCreationOptions.OptionFlags
          (logandc2 (rref options :navDialogCreationOptions.OptionFlags)
                    #$kNavAllowMultipleFiles)))
  ;#+ignore
  (rset options :navDialogCreationOptions.OptionFlags    ;; doesn't work
          (logior (rref options :navDialogCreationOptions.OptionFlags)
                  #+ignore #$kNavAllowOpenPackages
                  #$kNavSupportPackages ))
  (when cfarray (setf (pref options :navdialogcreationoptions.popupextension) cfarray))
  (when (and NavNoTypePopup (not cfarray))
    (rset options :navDialogCreationOptions.OptionFlags
          (logior (rref options :navDialogCreationOptions.OptionFlags)
                  #$kNavNoTypePopup)))
  (when dont-confirm-replacement  ;; let caller worry about it?? - the "already exists" alert sometimes fails to draw when timer is running
    (rset options :navDialogOptions.dialogOptionFlags
          (logior (rref options :navDialogOptions.dialogOptionFlags)
                  #$kNavDontConfirmReplacement)))
  (when location
    (setf (pref options :navdialogCreationoptions.location) location))
  (when windowTitle
    (setf (pref options :navdialogCreationoptions.windowTitle) windowTitle))
  (when actionButtonLabel
    (setf (pref options :navdialogCreationoptions.actionbuttonlabel) actionButtonLabel))
  (when cancelButtonLabel
    (setf (pref options :navdialogCreationoptions.cancelButtonLabel) cancelButtonLabel))
  (when savedFileName
    (setf (pref options :navdialogCreationoptions.saveFileName) savedFileName))
  (when message
    (setf (pref options :navdialogCreationoptions.message) message))
  (when clientname 
    (setf (pref options :navdialogCreationoptions.clientname) clientname)))(defun choose-file-dialog (&key directory
                                 mac-file-type
                                 mac-file-creator 
                                 (button-string "Open")
                                 (cancel-button-string "Cancel")
                                 (window-title "Choose a File")
                                 (allow-multiple-files *choose-allow-multiple-files*)
                                 prompt
                                 window-position
                                 FILTER  ;; for CLIM??                                   
                                 &aux (ntypes -1) (offset 0))
  ;(declare (dynamic-extent args))

  (if nil ;(not (osx-p))
    (return-from choose-file-dialog
      (apply 'nav-choose-file-dialog-os9 args)))
  (when directory (setq directory (probe-file directory))) ;; resolve aliases
  (when (or (and directory
                 (pathname-directory directory)
                 (setq directory (directory-namestring directory)))
            (setq directory (choose-file-default-directory)))
    (set-choose-file-default-directory-2 directory)
    )
  ;; something like this to allow looking at OSX .h and .make files
  (when *see-untyped-osx-files* 
    (cond ((and (not (listp mac-file-type))) ;(equalp mac-file-type "TEXT")) ;; i.e just looking for text files 
           (setq mac-file-type (list #.(ff-long-to-ostype 0) "????" :|utxt| mac-file-type)))  ;; aka (ff-long-to-ostype 0)
          ((and (consp mac-file-type)) ;(member "TEXT" mac-file-type :test #'equalp))  ;; for cmd-y
           (setq mac-file-type (list* #.(ff-long-to-ostype 0) "????" :|utxt| mac-file-type)))))
  (if mac-file-type
    (setq ntypes (if (listp mac-file-type) (length mac-file-type) 1)))  
  (let ((size (+ 8 (%ilsl 2 (%imax 1 ntypes))))
        (tphandle)
        retried )
    (with-aedescs (aedesc)
      (rlet ((fsrefptr :fsref))            
        (ae-error (#_aecreatedesc #$typeFSRef fsrefptr (record-length :fsref) aedesc))
        (when directory              
          (make-fsref-from-directory-aedesc aedesc directory))        
        (unwind-protect
          (with-cfstrs-hairy ((window-title window-title) (prompt prompt)(button-string button-string)(cancel-button-string cancel-button-string))
            (setq tphandle (#_newhandle :errchk size))
            (when (%null-ptr-p tphandle)(error "Not enough room for handle size ~s" size))
            (with-dereferenced-handles ((tp tphandle))
              (%put-ostype tp (or mac-file-creator (application-file-creator *application*)) 0) ;; ?? - use dialog options to ignore this - seems to be ignored
              (%put-word tp ntypes 6) 
              (setq offset 8)
              (if (listp mac-file-type)
                (dolist (type mac-file-type)
                  (%put-ostype tp type offset)
                  (setq offset (%i+ offset 4)))
                (%put-ostype tp mac-file-type offset))
              (rlet ((reply :navreplyrecord)
                     (options :navdialogoptions)
                     (the-dialog :ptr))                
                (set-default-dialog-creation-options
                 options :location window-position :windowtitle window-title
                 :actionbuttonlabel button-string :cancelbuttonlabel cancel-button-string
                 ;:savedfilename name 
                 :allowmultiplefiles allow-multiple-files
                 :message prompt 
                 ;:NavNoTypePopup (not format-query-p)
                 )                  
                (let ()
                  (prog () ;hiding-windoids ;; my goodness aren't we old fashioned
                    again
                    (let ((result (#_navcreategetfiledialog
                                   options ;(if (or button-string prompt name) options *null-ptr*) ;dialogoptions                               
                                   (if (or (null mac-file-type)(eq ntypes 0)) *null-ptr* tphandle)
                                   (%null-ptr) ;(if (osx-p) *null-ptr* event-wdef) ;; eventproc - not needed if osx
                                   (%null-ptr) ;; previewproc
                                   (OR FILTER *null-ptr*) ;; filterproc
                                   *my-nav-ud* ; callbackud                                   
                                   the-dialog)))
                      (let ((foo (check-nav-result result retried)))
                        (when (and (eq foo :try-again)(null retried))
                          (setq retried t)
                          (go again)))
                      (WHEN (neq result #$noerr) (throw-cancel :cancel))                      (when (typecase mac-file-type                              ((eql :text) T)                               (string (string= mac-file-type :text))                              (cons (member :text mac-file-type :test #'string=)))                        ; compensate for ostype :text improperly considered equivalent to the UTI "com.apple.traditional-mac-plain-text"                        (#_NavDialogSetFilterTypeIdentifiers                         (%get-ptr the-dialog)                         (create-cfarray '("public.text"))))
                      (when directory
                        (#_navcustomcontrol (%get-ptr the-dialog) #$kNavCtlSetLocation aedesc))                        
                      (with-foreign-window
                        (setq *the-nav-dialog* (%get-ptr the-dialog))                        
                        (setq result (#_navdialogrun *the-nav-dialog*)))
                      (WHEN (neq result #$noerr) (throw-cancel :cancel))
                      #+ignore ;; seems to hang?
                      (let ((action (#_navdialoggetuseraction *the-nav-dialog*)))
                        (when (eq action #$knavUserActionCancel)
                          (remember-nav-folder *the-nav-dialog*)
                          (throw-cancel :cancel)))
                      (let ((res (#_navdialoggetreply *the-nav-dialog* reply)))                        
                        (when (neq res #$noerr)
                          (remember-nav-folder *the-nav-dialog*)
                          (throw-cancel :cancel)))
                      (let ((valid-reply (pref reply navreplyrecord.validrecord)))
                        ;(push valid-reply barf)
                        (when (not valid-reply)
                          (remember-nav-folder *the-nav-dialog*)
                          (#_navdisposereply reply)
                          (throw-cancel :cancel)))
                      (without-interrupts
                       (when *the-nav-dialog* (#_navdialogdispose *the-nav-dialog*))
                       (setq *the-nav-dialog* nil))
                      ))                                    
                  (let ((selection (pref reply navreplyrecord.selection))
                        result)
                    (setq result (parse-doclist selection))
                    (#_navdisposereply reply)
                    (when result
                      (set-choose-file-default-directory-2 
                       (if (consp result)(car result) result)))
                    result)))))           
          (when (and tphandle (not (%null-ptr-p tphandle)))(#_disposehandle tphandle))          
          (SETQ *the-nav-reply* nil)
          (when *the-nav-dialog* (#_navdialogdispose *the-nav-dialog*))
          (setq *the-nav-dialog* nil)
          (nav-dialog-cleanup)            
          )))))) ; end redefine
