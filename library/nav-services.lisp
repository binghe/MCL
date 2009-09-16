(in-package :ccl)
;;  choose-new-file-dialog - user can provide format-query-p nil as another way to say no format popup
;; ------ 5.2b6
;; fiddle with get-popup-selection
;; ----- 5.2b5
;; put back remove-keywords - some folks use it
;; ----- 5.2b4
;; choose-new-file-dialog and choose-new-directory-dialog - :prompt default is NIL. chosse-new-directory-dialog - format-list is nil
;; ----- 5.2b1
;; add stuff to do external-format with nav popup, choose-new-file-dialog returns second value of external-format if chosen
;; fix window-title for choose-new-file-dialog, choose-directory-dialog uses #_navcreatechoosefolderdialog 
;; get rid of the old-choose things - nav-choose-xxx => choose-xxx, don't use event-wdef in choose-file-dialog and choose-new-file-dialog if OSX
;; another change to event-wdef, remove unused stuff from parse-doclist2
;; defpascal event-wdef and nav-choose... fix for timer problem - better but not perfect
;; add :|utxt| to possible types
;; ------ 5.1 final
;; no change
;; ------ 5.1b4
;; nav-choose-new-file-dialog, nav-choose-file-dialog - reduce scope of with-foreign-window for no particular reason
;; put back with-port in nav-choose-directory-dialog - NO DONT
;; ------- 5.1b3
;; add nav-dialog-cleanup for some stuff that is messed up on osx
;; add dont-confirm-replacement keyword to choose-new-file-dialog and choose-new-directory-dialog  - because the resulting dialog sometimes screws up when timer is enabled
;; use with-cfstrs-hairy, remove some old junk
;; ss  stop nav-choose-file-dialog from crashing when mac-file-type nil
;; fix event-wdef when cancel to get default directory right on OSX without breaking OS9, use #_navcreatgetfiledialog on OSX
;; -------- 5.1b2
;; 03/21/04 lose with-port 
;; forget with-foreign-window - no dont
;; no more special case (not (osx-p)) in event-wdef
;; nav-choose-file-dialog adds in file-types of 0 and ???? for all requested types not just "TEXT"
;; twiddles in create-cfstr
;; parse-doclist2 more careful with name&type
;; maybe fix so can set the default directory when using navcreatemumbledialog
;; nav-choose-new-file-dialog does long/unicode pathnames, use new event-wdef
;; use fsrefs where possible
;; -------- 5.0 final
;; 01/06/03 akh event-wdef ignores error when cancel tries to set default directory - may error on OSX
;;  when the chosen thing is an alias to a folder
;; --- 5.0b3
;; 12/20/02 akh also tolerate file type "????" in some cases.
;; ------ 4.4b5
;; clear reply record for NavPutFile
;; forget restoring-dead-keys - busted on Jaguar and doesn't seem to be needed anyway
;; forget fsref for now
;; parse-doclist gets an exists arg - nil from choose-new-file, also want-dir arg passed on to %path-from-fsref
;; ------- 4.4b4
;; akh nav-choose-file-dialog tolerates 0 mac-file-type in some cases
;; -------- 4.4b3
;; akh use probe-file instead of full-pathname to resolve aliases
;;----------------- 4.4b2
;; 06/25/02 akh trying to look at *see-untyped-osx-files*
;; 06/13/01 akh see advise
;;---------- 4.4b1
;; 04/30/01 akh fix calls to aecreatedesc for osx
;; 03/12/01 akh tweak def-ccl-pointers for carbon-compat so NavigationLib not added to search-path
;; carbon goo for aedesc 
;;; 4.3.1b1
;; 02/19/00 akh - lose all this upp stuff - never needed in the first place??
;; 12/26/99 akh add function nav-services-available-p
;; 08/08/99 akh add setting default dir to event-wdef when cancel
;; ---------- 4.3f1c1
;; 07/12/99 akh set-default-dialog-options takes keyword :clientname
;; ----------- 4.3b3
;; 04/04/99 akh don't set default-directory unless it's really a directory
;; ------------- 4.3b1
;; 03/01/99 akh change to avoid compiler-warnings if use new keys - no mo advise of the choosers
;; 02/21/98 akh add allow-multiple-files keyword to nav-choose-file-dialog, defaults to  *choose-allow-multiple-files*
;; 02/19/99 akh fix so if nav-services not available we don't pass thru new keywords to old functions
;; 02/19/99 akh more enhancements from Toomas Altosaar - esp extended-reply see below
;; 02/18/99 akh more options  :window-title etal - from Toomas Altosaar 
;; 02/18/99 akh added nav-choose-new-directory-dialog
;; 02/16/99 akh some defense against errors of one sort or another, try making room on memfull
;; 02/15/99 akh disallow multiple files (from David L.), disallow unadvising the choose-xx fns
;; 02/14/99 akh ignore-errors in case Navigationlib not there
;; 02/08/99 akh do plug name into dialog in choose-new-file-dialog 
;; 02/10/99 akh no mo hiding-windoids


;; Copyright 1999-2001 Digitool, Inc.
#|
The user now has the possibilty to supply two new keywords to
choose-new-file-dialog:

1). :extended-reply-p (default value is nil)
If set to t it indicates that more details from the reply record passed to
navigational services will be returned from the call to
choose-new-file-dialog. If t then a second value is returned - a (key-value
pair list) that can be analyzed using (getf place indicator). The key-value
list looks like:

(:REPLACING-P NIL :STATIONERY-P NIL :TRANSLATION-NEEDED-P NIL
:FILE-TRANSLATION :NOT-IMPLEMENTED-YET :KEYSCRIPT 0)

as per

http://developer.apple.com/techpubs/macos8/Files/NavigationServices/ProgWithNavS
rvcs1.1/NavSvcs.22.html#pgfId=35605


2). :format-query-p (default value is nil)
If set to t causes a popup menu to be included in the dialog to enable
document format selection. The boolean value returned can be read from the
key-value list with the key as :STATIONERY-P. If format-query-p is called
with a value of t but extended-reply-p is unspecified or nil, then an
extended reply is still returned as a second value.
|#
(in-package :traps)
#-interfaces-3
(eval-when (:compile-toplevel :load-toplevel :execute)
(deftrap-inline "_NavChooseFile" 
      ((defaultLocation (:pointer :aedesc))
       (reply (:pointer :navreplyrecord))
       (dialogOptions (:pointer :navdialogoptions))
       (eventProc :pointer) (previewProc :pointer)
       (filterProc :pointer) (typeList (:handle :navtypelist))
       (callBackUD :pointer)) 
  :signed-integer
   () )

(deftrap-inline "_NavChooseFolder" 
      ((defaultLocation (:pointer :aedesc)) 
       (reply (:pointer :navreplyrecord)) 
       (dialogOptions (:pointer :navdialogoptions))
       (eventProc :pointer) 
       (filterProc :pointer) 
       (callBackUD :pointer)) 
  :signed-integer
   () )

(deftrap-inline "_NavPutFile" 
      ((defaultLocation (:pointer :aedesc))
       (reply (:pointer :navreplyrecord)) (dialogOptions (:pointer :navdialogoptions))
       (eventProc :pointer) (fileType :ostype)
       (fileCreator :ostype) 
       (callBackUD :pointer)) 
  :signed-integer
   () )
)


(in-package :ccl)
(eval-when (:compile-toplevel :execute)
  (ignore-errors (add-to-shared-library-search-path "NavigationLib" t)))

(defvar *nav-services-available* nil)
;; P.S. navservices sucks with the version of the lib that I have with OS 7.6.
;;      Choose-new-file-dialog crashes and choose-file-dialog only shows files with creator :ccl2

(defun nav-services-available-p ()
  t)

(defvar *my-nav-ud* 999)  ;; sometimes (old interfaces) supposed to be :long, sometime supposed to be :pointer
(def-ccl-pointers nav-avail ()
  (setq *nav-services-available* t)
  (let ()
    ;(setq *nav-services-available* nil)
    #+carbon-compat (setq *my-nav-ud* (%null-ptr)) ; ??
    #-carbon-compat (setq *my-nav-ud* (%null-ptr)) ; huh
    
    ))




(defvar *event-ptr* nil)
(defvar *choose-allow-multiple-files* nil)  ; should export this
(export '(*choose-allow-multiple-files*) (find-package :ccl))


(eval-when (:compile-toplevel :execute)  ; from choose-file-dialogs
(defmacro restoring-dead-keys (&body body)
  `(progn ,@body))
#|
    (let ((dead-state (gensym)))
      `(let ((,dead-state (get-dead-keys-state)))
         (unwind-protect
           (progn ,@body)
           (set-dead-keys ,dead-state)))))
|#

  ;; because windoids in the nwo seem to mess up sfgetfile and friends
  #|
  (defmacro hiding-windoids (&body body)
    (let ((the-windoids (gensym)))
      `(let ((,the-windoids nil))
         (unwind-protect
           (progn
             (map-windoids #'(lambda (w)(window-hide w)(push w ,the-windoids)))
             (progn ,@body))
           (dolist (w ,the-windoids)
             (window-show w))))))
  |#
)

#|

(defrecord NavReplyRecord 
   (version :unsigned-integer)
   (validRecord :boolean)                       ;   open/save: true if the user confirmed a selection, false on cancel  
   (replacing :boolean)                         ;   save: true if the user is overwriting an existing object for save  
   (isStationery :boolean)                      ;   save: true if the user wants to save an object as stationery  
   (translationNeeded :boolean)                 ;   save: translation is 'needed', open: translation 'has taken place'  
   (selection :aedesc)                          ;   open/save: list of AppleEvent descriptors of the chosen object(s)  
   (keyScript :signed-integer)                  ;   open/save: script in which the name of each item in 'selection' is to be displayed  
   (fileTranslation (:handle :filetranslationspec));   open/save: list of file translation specs of the chosen object(s), if translation is needed  
   (reserved1 :unsigned-long)
   (reserved (:array :character 231 :packed))
   )
(deftrap-inline "_NavChooseFile" 
      ((defaultLocation (:pointer :aedesc)) (reply (:pointer :navreplyrecord))
       (dialogOptions (:pointer :navdialogoptions)) (eventProc :pointer) (previewProc :pointer) 
       (filterProc :pointer) (typeList (:handle :navtypelist)) (callBackUD :unsigned-long)) 
      :signed-integer
   () )

(defrecord NavTypeList 
   (componentSignature :ostype)
   (reserved :signed-integer)
   (osTypeCount :signed-integer)
   (OSType (:array :ostype 1))
   )

(defrecord NavDialogOptions 
   (version :unsigned-integer)
   (dialogOptionFlags :unsigned-long)           ;   option flags for affecting the dialog's behavior  
   (location :point)                            ;   top-left location of the dialog, or (-1,-1) for default position  
   (clientName (:string 255))
   (windowTitle (:string 255))
   (actionButtonLabel (:string 255))            ;   label of the default button (or null string for default)  
   (cancelButtonLabel (:string 255))            ;   label of the cancel button (or null string for default)  
   (savedFileName (:string 255))                ;   default name for text box in ê (or null string for default)  
   (message (:string 255))                      ;   custom message prompt (or null string for default)  
   (preferenceKey :unsigned-long)               ;   a key for to managing preferences for using multiple utility dialogs  
   (popupExtension :handle)                     ;   extended popup menu items, an array of NavMenuItemSpecs  
   (reserved (:array :character 494 :packed))
   )
|#



#|
(defun set-default-dialog-options (options)
  (#_navgetDefaultDialogOptions options)
  ;; allow only single selection
  (when (not *choose-allow-multiple-files*)
    (rset options :navDialogOptions.dialogOptionFlags
          (logandc2 (rref options :navDialogOptions.dialogOptionFlags)
                    #$kNavAllowMultipleFiles))))
|#

(defun set-default-dialog-options (options &key location windowTitle
                                           actionButtonLabel cancelButtonLabel
                                           savedFileName message (NavNoTypePopup t)
                                           allowMultipleFiles
                                           dont-confirm-replacement
                                           clientname)
  (let ((res (#_navgetDefaultDialogOptions options)))
    (if (neq res #$noerr)
      (error "navgetdefaultdialogoptions is unhappy")))
  ;; allow only single selection
  (when (not allowMultipleFiles) ;*choose-allow-multiple-files*)
    (rset options :navDialogOptions.dialogOptionFlags
          (logandc2 (rref options :navDialogOptions.dialogOptionFlags)
                    #$kNavAllowMultipleFiles)))
  (when NavNoTypePopup
    (rset options :navDialogOptions.dialogOptionFlags
          (logior (rref options :navDialogOptions.dialogOptionFlags)
                  #$kNavNoTypePopup)))
  (when dont-confirm-replacement  ;; let caller worry about it?? - the "already exists" alert sometimes fails to draw when timer is running
    (rset options :navDialogOptions.dialogOptionFlags
          (logior (rref options :navDialogOptions.dialogOptionFlags)
                  #$kNavDontConfirmReplacement)))
  
  (when location
    (setf (pref options :navdialogoptions.location) location))
  (when windowTitle
    (setf (pref options :navdialogoptions.windowTitle) windowTitle))
  (when actionButtonLabel
    (setf (pref options :navdialogoptions.actionbuttonlabel) actionButtonLabel))
  (when cancelButtonLabel
    (setf (pref options :navdialogoptions.cancelButtonLabel) cancelButtonLabel))
  (when savedFileName
    (setf (pref options :navdialogoptions.savedFileName) savedFileName))
  (when message
    (setf (pref options :navdialogoptions.message) message))
  (when clientname 
    (setf (pref options :navdialogoptions.clientname) clientname)))

#|
(defrecord NavDialogCreationOptions 
   (version :unsigned-integer)
   (optionFlags :unsigned-long)
   (location :point)
   (clientName :pointer)
   (windowTitle :pointer)
   (actionButtonLabel :pointer)
   (cancelButtonLabel :pointer)
   (saveFileName :pointer)
   (message :pointer)
   (preferenceKey :unsigned-long)
   (popupExtension :pointer)
   (modality :unsigned-long)
   (parentWindow (:pointer :windowrecord))
   (reserved (:array :character 16 :packed))
   )
|#

;; N.B. strings must be cfstrings
(defun set-default-dialog-creation-options (options &key location windowTitle
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
  #+ignore
  (rset options :navDialogCreationOptions.OptionFlags    ;; doesn't work
          (logior (rref options :navDialogCreationOptions.OptionFlags)
                  #$kNavAllowOpenPackages
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
    (setf (pref options :navdialogCreationoptions.clientname) clientname)))

(defvar *see-untyped-osx-files* t)

(defglobal *the-nav-reply* nil)
(defglobal *the-nav-dialog* nil)

#+ignore  ;; since OS9 support is gonzo
(defun nav-choose-file-dialog-os9 (&key directory
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
  
  ;(declare (ignore mac-file-creator))
  ;(declare (ignore button-string)) ;; put in actionbuttonlabel in dialogoptions
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
           (setq mac-file-type (list #.(ff-long-to-ostype 0) "????" :|utxt|  mac-file-type)))  ;; aka (ff-long-to-ostype 0)
          ((and (consp mac-file-type)) ;(member "TEXT" mac-file-type :test #'equalp))  ;; for cmd-y
           (setq mac-file-type (list* #.(ff-long-to-ostype 0) "????" :|utxt| mac-file-type)))))
  (if mac-file-type
    (setq ntypes (if (listp mac-file-type) (length mac-file-type) 1)))
  (progn ;restoring-dead-keys
    (let ((size (+ 8 (%ilsl 2 (%imax 1 ntypes))))
          (tphandle)
          retried)
      (with-aedescs (aedesc)
        (rlet ((fsrefptr :fsref))
          (ae-error (#_aecreatedesc #$typeFSRef fsrefptr (record-length :fsref) aedesc))
          (when directory             
            (make-fsref-from-directory-aedesc aedesc directory))          
          (unwind-protect
            (progn ;with-port %original-temp-port%  ;; work around OSX problem that I do not understand -- has problem gone away ??
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
                       (options :navdialogoptions))
                  (set-default-dialog-options
                   options  :location window-position :windowtitle window-title
                   :actionbuttonlabel button-string 
                   :cancelbuttonlabel cancel-button-string
                   ;:navnotypepopup nil
                   :message prompt
                   :allowMultipleFiles allow-multiple-files)
                  (unwind-protect
                    (with-foreign-window
                      (prog () ;hiding-windoids ;; my goodness aren't we old fashioned
                        again
                        (let ((result (#_navchoosefile (if directory aedesc *null-ptr*)
                                       ;; navgetfile will do the pop up but fat lotta good it does for accesssing OSX .h files
                                       ;; need translators - thanks a bunch, MPW pukes too.
                                       reply 
                                       options ;(if button-string options *null-ptr*) ;dialogoptions
                                       event-wdef ;(or *event-ptr* *null-ptr*) ;eventproc
                                       *null-ptr* ;previewproc
                                       (OR FILTER *null-ptr*) ;filterproc
                                       (if (or (null mac-file-type)(eq ntypes 0)) *null-ptr* tphandle) 
                                       *my-nav-ud*))) ; callbackud
                          (let ((foo (check-nav-result result retried)))
                            (when (and (eq foo :try-again)(null retried))
                              (setq retried t)
                              (go again)))
                          (when (eq result #$noerr)
                            (unless (pref reply navreplyrecord.validrecord)
                              (throw-cancel :cancel))
                            (let ((selection (pref reply navreplyrecord.selection))
                                  result)
                              (setq result (parse-doclist selection))
                              (when result
                                (set-choose-file-default-directory-2 
                                 (if (consp result)(car result) result)))
                              (return result))))))
                    ;; is this kosher given a stack allocated replyrecord??????
                    (#_navdisposereply reply)))))
            (when (and tphandle (not (%null-ptr-p tphandle)))(#_disposehandle tphandle))))))))


(defun choose-file-dialog (&key directory
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
                      (WHEN (neq result #$noerr) (throw-cancel :cancel))
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
          )))))

(defun check-nav-result (result &optional retried)
  (unless (eq result #$noerr)
    (if (eq result -128) ;; cancelled 
      (throw-cancel :cancel)
      (progn
        (when (and (eq result #$memFullErr)(not retried)) ;; out of memory ?
          (let ()
            (if t  ;; pick a random number
              (let ((new (#_newptr 50000)))
                (when (not (%null-ptr-p new))
                  (#_disposeptr new)
                  (return-from check-nav-result :try-again)))
              (return-from check-nav-result :try-again))))
        (error "Navigation services returned ~S" result)))))

(defun parse-doclist (doclist &optional  want-dir)
  (declare (ignore-if-unused  want-dir))  
  (let ((result nil))    
    (rlet ((items :signed-long)
           (aekeyword :ostype)
           (actual-type :ostype)
           (my-fsref :fsref)
           (actual-size :signed-long))      
      (ae-error-str "trying to count the items in navreply" 
        (#_AECountItems doclist items))
      (dotimes (i (%get-signed-long items))          
        (ae-error-str "trying to get an item in navreply"
          (#_AEGetNthPtr doclist (+ i 1) #$typeFSRef aekeyword actual-type my-fsref 
           (record-length :fsref) actual-size))          
        (let* ((path (%path-from-fsref my-fsref want-dir)))
          (push path result)))
      (if (eq (length result) 1) (car result) result))))


;; called from choose-new-file-dialog
(defun parse-doclist2 (reply)
  #|The name is stored in the reply record itself, as a CFString. The field 
name is saveFileName, and it exist where the record version is 2 or 
later. (pref reply :navreplyrecord.savefilename) |#
  (let ((doclist (pref reply :navreplyrecord.selection)))
    (rlet ((aekeyword :ostype)
           (actual-type :ostype)
           (my-fsref :fsref)
           (actual-size :signed-long))        
      ;(when reply (print  (get-cfstr (pref reply :navreplyrecord.savefilename))))      
      (ae-error-str "trying to get an item in navreply"
        (#_AEGetNthPtr doclist 1 #$typeFSRef aekeyword actual-type my-fsref 
         (record-length :fsref) actual-size))
      ;; thats the parent - the one and only fsref
      (let* ((dir-path (%path-from-fsref my-fsref t))
             (cfstr (pref reply :navreplyrecord.savefilename)))
        (multiple-value-bind (name type)
                             (%std-name-and-type (get-cfstr cfstr)) ;; ??
          (make-pathname :directory (pathname-directory dir-path)
                         :name name :type type :defaults nil))))))


#|
(deftrap-inline "_NavPutFile" 
      ((defaultLocation (:pointer :aedesc))
       (reply (:pointer :navreplyrecord)) 
       (dialogOptions (:pointer :navdialogoptions))
       (eventProc :pointer)
       (fileType :ostype) 
       (fileCreator :ostype) 
       (callBackUD :unsigned-long)) 
  :signed-integer
   () )
|#
#|
(defrecord NavDialogOptions 
   (version :unsigned-integer)
   (dialogOptionFlags :unsigned-long)           ;   option flags for affecting the dialog's behavior  
   (location :point)                            ;   top-left location of the dialog, or (-1,-1) for default position  
   (clientName (:string 255))
   (windowTitle (:string 255))
   (actionButtonLabel (:string 255))            ;   label of the default button (or null string for default)  
   (cancelButtonLabel (:string 255))            ;   label of the cancel button (or null string for default)  
   (savedFileName (:string 255))                ;   default name for text box in NavPutFile (or null string for default)  
   (message (:string 255))                      ;   custom message prompt (or null string for default)  
   (preferenceKey :unsigned-long)               ;   a key for to managing preferences for using multiple utility dialogs  
   (popupExtension :handle)                     ;   extended popup menu items, an array of NavMenuItemSpecs  
   (reserved (:array :character 494 :packed))
   )
|#

(defglobal *nav-popup-index* nil)



(defun create-cfarray (strings)
  (require-type strings 'list)
  (let* ((num (length strings))
         (idx 0))
    (%stack-block ((res (+ 4 (* 4 num))))
      (dolist (str strings)
        (let ((strcf (create-cfstr2 str (#_newptr 4))))
          (%put-ptr res strcf idx)
          (incf idx 4)))
      (%put-ptr res (%null-ptr) (* num 4))
      (#_cfarraycreate (%null-ptr) res num (%null-ptr)))))

(defparameter *save-as-types*
    '( ("Unicode (UTF16)" . :utf-16)
       ("Unicode (UTF8)"  . :utf-8)
       ("Unix line endings" . :unix)))

(defparameter *save-as-cfarray* nil)

(defun setup-cfarray ()
    (setq *save-as-cfarray* (create-cfarray (mapcar #'car *save-as-types*))))

(def-ccl-pointers setcf ()
  (setup-cfarray))

(eval-when (:compile-toplevel :load-toplevel :execute)   
  (pushnew 'setup-cfarray *lisp-startup-functions*)) 

;; mac-file-type arg if :text pop-up says MCL Lisp source file (from plst resource), if :???? says Default
;; if :CCL2 or :barf says CCL Document

(defun choose-new-file-dialog (&key directory
                                    (prompt nil) ;"New File NameÉ")
                                    (button-string "Save")
                                    (mac-file-type :CCL2)  ;; was :TEXT, :ccl2 makes it say "CCL Document" vs "MCL Lisp source file" 
                                    (mac-file-creator (application-file-creator *application*))
                                    (cancel-button-string "Cancel")
                                    (window-title "Choose a New File")
                                    (format-list *save-as-cfarray* format-list-sup)  ;; array to use in format-popup
                                    window-position
                                    name
                                    extended-reply-p ;user requests more details - returns a second value (key-value pair list)
                                    (format-query-p nil query-p-sup) ; mostly ignored
                                    dont-confirm-replacement ;; omit the already-exists alert
                                    &aux retried)
  
  (when (and directory (null name))
    ;(setq name (mac-file-namestring (file-namestring directory)))
    (setq name (file-namestring directory))
    (when (and (stringp name)(eq (length name) 0))(setq name nil))
    (setq directory (directory-namestring (full-pathname directory)))
    (when (and (stringp directory) (eq (length directory) 0))(setq directory nil))
    )
  (when (and query-p-sup (null format-query-p)(null format-list-sup)) ;;  format-query-p nil another way to say no format popup
    (setq format-list nil))
  (when directory (setq directory (probe-file directory))) ; resolve aliases
  (when (or (and directory
                 (pathname-directory directory)
                 (setq directory (directory-namestring directory)))
            (setq directory (choose-file-default-directory)))
    (set-choose-file-default-directory-2 directory)
    )
  
  (with-cfstrs-hairy ((window-title window-title)(cancel-button-string cancel-button-string)(button-string button-string)(name name)(prompt prompt))
    (with-aedescs (aedesc)
      (rlet ((options :navdialogCreationoptions)
             (fsrefptr :fsref))        
        (set-default-dialog-creation-options
         options :location window-position :windowtitle window-title
         :actionbuttonlabel button-string :cancelbuttonlabel cancel-button-string
         :cfarray format-list
         :dont-confirm-replacement dont-confirm-replacement
         :savedfilename name :message prompt :NavNoTypePopup (not format-query-p))        
        (ae-error (#_aecreatedesc #$typeFsref fsrefptr (record-length :fsref) aedesc))
        (when directory             
          (make-fsref-from-directory-aedesc aedesc directory)
          )
        (let ()
          (unwind-protect
            (progn ;with-port %original-temp-port% ;; see above                                       
              (rlet ((the-dialog :pointer)
                     (reply :navreplyrecord))
                ;(put-external-scrap)
                (prog nil
                  again
                  (let ((result (#_navcreateputfiledialog 
                                 ;; options gets out of mem error - fixed
                                 options ;(if (or button-string prompt name) options *null-ptr*) ;dialogoptions                               
                                 mac-file-type
                                 mac-file-creator
                                 (if format-list event-wdef *null-ptr*)  ;; don't need event-wdef
                                 *my-nav-ud* ; callbackud
                                 the-dialog)))
                    (let ((foo (check-nav-result result retried)))
                      (when (and (eq foo :try-again)(null retried))
                        (setq retried t)
                        (go again)))
                    (when (neq result #$noerr)
                      (throw-cancel :cancel))
                    (when directory
                      (#_navcustomcontrol (%get-ptr the-dialog) #$kNavCtlSetLocation aedesc))
                    (with-foreign-window
                      (setq *nav-popup-index* nil)
                      (setq *the-nav-dialog* (%get-ptr the-dialog))  ;; better be modal
                      (setq result (#_navdialogrun (%get-ptr the-dialog))))
                    (WHEN (neq result #$noerr) (throw-cancel :cancel))
                    #+ignore ;; does this hang when timer?
                    (let ((action (#_navdialoggetuseraction *the-nav-dialog*)))
                      (when (eq action #$knavUserActionCancel)
                        (remember-nav-folder *the-nav-dialog*)
                        (throw-cancel :cancel)))
                    (let ((res (#_navdialoggetreply *the-nav-dialog* reply)))
                      (when (neq res #$noerr) ;; hqppens when cancelled
                        (remember-nav-folder *the-nav-dialog*)
                        (throw-cancel :cancel)))
                    (let ((valid-reply (pref reply navreplyrecord.validrecord)))
                      ;(push valid-reply barf)
                      (when (not valid-reply) ;; never happens?
                        (remember-nav-folder *the-nav-dialog*)                        
                        (#_navdisposereply reply)
                        (throw-cancel :cancel)))
                    (without-interrupts
                     (when *the-nav-dialog* (#_navdialogdispose *the-nav-dialog*))
                     (setq *the-nav-dialog* nil))
                   ))
                (let ((result (parse-doclist2 reply))
                      (extended-results))
                  (when result
                    (set-choose-file-default-directory-2
                     (if (consp result)(car result) result)))
                  ;;; Extended reply - turn on if user asked for format-query-p
                  (setq extended-reply-p (or extended-reply-p format-query-p))
                  (when extended-reply-p
                    (push (pref reply navreplyrecord.keyScript) extended-results)
                    (push :keyScript extended-results)
                    (push :not-implemented-yet extended-results)
                    (push :file-translation extended-results)
                    (push (pref reply navreplyrecord.translationNeeded) extended-results)
                    (push :translation-Needed-p extended-results)
                    (push (pref reply navreplyrecord.isStationery) extended-results)
                    (push :stationery-p extended-results)
                    (push (pref reply navreplyrecord.replacing) extended-results)
                    (push :replacing-p extended-results))
                  (#_navdisposereply reply)
                  (if extended-reply-p
                    (values result extended-results)
                    (if (and format-list *nav-popup-index*)
                      (values result (cdr (elt *save-as-types* *nav-popup-index*)))
                      result)))))
            (SETQ *the-nav-reply* nil)
            (when *the-nav-dialog* (#_navdialogdispose *the-nav-dialog*))
            (setq *the-nav-dialog* nil)
            (nav-dialog-cleanup)
            ))))))

(defun nav-dialog-cleanup ()
  (when t ;(osx-p) 
    (#_drawmenubar) ;; else sometimes menubar doesn't get redrawn till much later
    (let ((w *selected-window*))
      (when w  ;; else selection if any in front window may be screwed up
        (view-deactivate-event-handler w)
        (view-activate-event-handler w)))))



(defun make-fsref-from-directory-aedesc (aedesc directory)
  (when (not (pathnamep directory)) (setq directory (pathname directory)))
  (%stack-block ((fsrefptr (record-length :fsref)))
    (make-fsref-from-path-simple directory fsrefptr)    
    ;; I hope it copies the data -seems to
    (errchk (#_AEReplaceDescData #$typeFSref fsrefptr (record-length :fsref) aedesc))))


(defun set-choose-file-default-directory-2 (path)
  (setq path (full-pathname path))
  (if (not (directory-pathname-p path))
    (setq path (directory-namestring path))) 
  (if (directory-exists-p path)
    (setq *last-choose-file-directory* path)))

#|
(deftrap-inline "_NavChooseFolder" 
      ((defaultLocation (:pointer :aedesc)) 
       (reply (:pointer :navreplyrecord)) 
       (dialogOptions (:pointer :navdialogoptions))
       (eventProc :pointer) 
       (filterProc :pointer) 
       (callBackUD :unsigned-long)) 
  :signed-integer
   () )
|#

#|
(defun choose-directory-dialog (&key directory
                                         (button-string "Choose")
                                         (cancel-button-string "Cancel")
                                         (window-title "Choose a Folder")
                                         prompt
                                         window-position
                                         name  ;; I don't think this buys anything here?
                                         &aux retried)  
  
  ;(declare (ignore button-string prompt)) ;; put in actionbuttonlabel in dialogoptions
  (when directory (setq directory (probe-file directory)))
  (when (or (and directory
                 (pathname-directory directory)
                 (setq directory (directory-namestring directory)))
            (setq directory (choose-file-default-directory)))
    (set-choose-file-default-directory-2 directory)
    )  
  (progn ;restoring-dead-keys    
   (with-aedescs (aedesc)
     (rlet ((reply :navreplyrecord)
            (options :navdialogoptions)
            (fsrefptr :fsref))
       (ae-error (#_aecreatedesc #$typeFSRef fsrefptr (record-length :fsref) aedesc))       
       (set-default-dialog-options
        options :location window-position :windowtitle window-title
        :actionbuttonlabel button-string :cancelbuttonlabel cancel-button-string
        :savedfilename name :message prompt)
       (when directory          
         (make-fsref-from-directory-aedesc aedesc directory))
       (unwind-protect
         (with-foreign-window
           (progn ;with-port %original-temp-port%  ;; see above
             (prog () ;hiding-windoids
               (put-external-scrap)
               again
               (let ((result (#_navchoosefolder (if directory aedesc *null-ptr*) ;; defaultlocation
                              reply 
                              options ;*null-ptr* ;dialogoptions
                              event-wdef ;(or *event-ptr* *null-ptr*) ;*null-ptr* ;eventproc
                              (%null-ptr) ; filterproc
                              *my-nav-ud*))) ; callbackud
                 (let ((foo (check-nav-result result retried)))
                   (when (and (eq foo :try-again)(null retried))
                     (setq retried t)
                     (go again)))
                 (when (eq result #$noerr)
                   (unless (pref reply navreplyrecord.validrecord)
                     (throw-cancel :cancel))                  
                   (let ((selection (pref reply navreplyrecord.selection))
                         (result))
                     (setq result (parse-doclist selection t))
                     (when result
                       (set-choose-file-default-directory-2 
                        (if (consp result)(car result) result)))
                     (return result)))))))
         (#_navdisposereply reply)
         (nav-dialog-cleanup))))))
|#

(defun choose-directory-dialog (&key directory
                                     (button-string "Choose")
                                     (cancel-button-string "Cancel")
                                     (window-title "Choose a Folder")
                                     prompt
                                     window-position
                                     name  ;; I don't think this buys anything here?
                                     &aux retried)
  (when directory (setq directory (probe-file directory)))
  (when (or (and directory
                 (pathname-directory directory)
                 (setq directory (directory-namestring directory)))
            (setq directory (choose-file-default-directory)))
    (set-choose-file-default-directory-2 directory)
    )
  (with-aedescs (aedesc)      
    (rlet ((reply :navreplyrecord)
           (options :navdialogcreationoptions)
           (fsrefptr :fsref)
           (the-dialog :ptr))
      (ae-error (#_aecreatedesc #$typeFSRef fsrefptr (record-length :fsref) aedesc))
      (with-cfstrs-hairy ((window-title window-title) (prompt prompt)(button-string button-string)(cancel-button-string cancel-button-string))
        (set-default-dialog-creation-options
         options :location window-position :windowtitle window-title
         :actionbuttonlabel button-string :cancelbuttonlabel cancel-button-string
         :savedfilename name :message prompt)
        (when directory          
          (make-fsref-from-directory-aedesc aedesc directory))
        (unwind-protect
          (prog () 
            again
            (let ((result (#_navcreatechoosefolderdialog 
                           options ;*null-ptr* ;dialogoptions
                           (%null-ptr)  ;(if (osx-p) *null-ptr* event-wdef) 
                           (%null-ptr) ; filterproc
                           *my-nav-ud*
                           the-dialog))) ; callbackud
              (let ((foo (check-nav-result result retried)))
                (when (and (eq foo :try-again)(null retried))
                  (setq retried t)
                  (go again)))
              (when (neq result #$noerr)(throw-cancel :cancel))
              (when directory
                (#_navcustomcontrol (%get-ptr the-dialog) #$kNavCtlSetLocation aedesc))
              (with-foreign-window
                (setq *the-nav-dialog* (%get-ptr the-dialog))                        
                (setq result (#_navdialogrun *the-nav-dialog*)))
              (WHEN (neq result #$noerr) (throw-cancel :cancel))
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
              (let ((selection (pref reply navreplyrecord.selection))
                    (result))
                (setq result (parse-doclist selection t))
                (#_navdisposereply reply)
                (when result
                  (set-choose-file-default-directory-2 
                   (if (consp result)(car result) result)))
                (return result))))
          (setq *the-nav-reply* nil)
          (when *the-nav-dialog* (#_navdialogdispose *the-nav-dialog*))
          (setq *the-nav-dialog* nil)
          (nav-dialog-cleanup))))))

#|
(deftrap-inline "_NavNewFolder" 
      ((defaultLocation (:pointer :aedesc)) 
       (reply (:pointer :navreplyrecord)) 
       (dialogOptions (:pointer :navdialogoptions)) 
       (eventProc :pointer) 
       (callBackUD :unsigned-long)) 
  :signed-integer
   () )
|#


;; or ?? - we like this better I think
(defun choose-new-directory-dialog (&key directory
                                             (prompt nil) ;"New Folder Name...")
                                             (button-string "Create")
                                             (window-title "Create Folder")
                                             name
                                             cancel-button-string
                                             dont-confirm-replacement
                                             window-position)
  (let ((result (choose-new-file-dialog :directory directory :prompt prompt :button-string button-string
                                            :window-title window-title
                                            :window-position window-position
                                            :dont-confirm-replacement dont-confirm-replacement
                                            :cancel-button-string cancel-button-string
                                            :format-list nil
                                            :name name
                                            )))
    (make-pathname :directory (namestring (if (consp result)(car result) result)) :defaults nil)))


#|
;; not used anymore - is for OS9
(defun path-from-aedesc (aedesc)
  (let ((size (record-length :fsspec)))
   (%stack-block ((ptr size :clear t))
     (ae-error (#_aegetdescdata aedesc ptr size))          ; 
     (%path-from-fsspec ptr)))) 
|#

#|
(defparameter *keywords-unsupported-in-old-choose*  
  '(:window-title :window-position :cancel-button-string :extended-reply-p :format-query-p :name
    :allow-multiple-files))

(defparameter *keywords-unsupported-in-old-choose-dir*  
  '(:window-title :window-position :cancel-button-string :extended-reply-p :format-query-p :name    
    :button-string :prompt))



|#

;; borrowed from clim
(defun remove-keywords (list keywords)
  (macrolet ((remove-keywords-1 (name-var predicate-form)
	       `(let ((head nil)
		      (tail nil))
		  (do ()
		      ((null list))
		    (let ((,name-var (pop list))
			  (value (pop list)))
		      (unless ,predicate-form
			(setq tail (setq head (list ,name-var value)))
			(return))))
		  (do ()
		      ((null list) head)
		    (let ((,name-var (pop list))
			  (value (pop list)))
		      (unless ,predicate-form
			(setq tail (setf (cddr tail) (list ,name-var value)))))))))
    (cond ((null list) nil)
	  ((null keywords) list)
	  ;; Special case: use EQ instead of MEMBER when only one keyword is supplied.
	  ((null (cdr keywords))
	   (let ((keyword (car keywords)))
	     (remove-keywords-1 name (eq name keyword))))
	  (t
	   (remove-keywords-1 name (member name keywords))))))


 
#+ignore       
(defparameter *choose-file-alist*
  '((choose-file-dialog . old-choose-file-dialog)
    (choose-new-file-dialog . old-choose-new-file-dialog)
    (choose-directory-dialog . old-choose-directory-dialog) 
    (choose-new-directory-dialog . old-choose-new-directory-dialog)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; the stuff to make the dialogs movable


;; this business makes the nav-xxx dialogs movable and updates windows newly exposed as needed.
;; I dont know what would happen if a GC was going on but neither can
;; I imagine why a gc would be going on


#+carbon-compat  ;; this sucks
;(add-pascal-upp-alist 'event-wdef #'(lambda (procptr)(#_newnaveventupp procptr)))

(add-pascal-upp-alist-macho 'event-wdef "NewNavEventUPP")


#| ;; old one
(defpascal event-wdef (:word callbackselector :ptr callbackparms :ptr callbackud) ;#+carbon-compat :ptr #-carbon-compat :long callbackud)   ;; callbackud was :long
  (when (and (eq callbackselector #$knavCBcancel)(eql callbackud *my-nav-ud* ))    
    (with-aedescs (aedesc)
      (if  t ;(not (osx-p))
        (rlet ((fsptr :fsspec))        
          (let ((size (record-length :fsspec)))
            (ae-error (#_aecreatedesc #$typeFSS fsptr size aedesc)))        
          (#_NavCustomControl (pref callbackparms :navcbrec.context) #$kNavCtlGetLocation aedesc) 
          (ignore-errors 
           ;; will error on osx if the chosen thing is an alias to a folder - don't know why
           (let ((path (path-from-aedesc aedesc)))            
             (set-choose-file-default-directory-2 path))))
        (rlet ((fsptr :fsref)
               (fsptr2 :fsref))        
          (let ((size (record-length :fsref)))
            (ae-error (#_aecreatedesc #$typeFsref fsptr size aedesc))        
            (#_NavCustomControl (pref callbackparms :navcbrec.context) #$kNavCtlGetLocation aedesc)
            (ae-error (#_aegetdescdata aedesc fsptr2 size))          
            (let ((path (%path-from-fsref fsptr2))) ;; this pukes
              (set-choose-file-default-directory-2 path)))))))
      
  (when (and (eql callbackud *my-nav-ud*)
             (eq callbackselector #$kNavCBEvent) ;; update or idle or something
             )
    (with-macptrs ((the-data  (pref callbackparms :navcbrec.eventdata))
                   (the-event (rref the-data :eventdata.event))
                   the-wptr)
      (let* ((what (rref the-event :eventrecord.what)))
        (when (eq what #$UpdateEvt)
          (%setf-macptr the-wptr (rref the-event :eventrecord.message)) ;; is that the wptr
          ;; well I'll be darned it seems to work
          (let* ((the-window (window-object the-wptr)))
            (when the-window
              (window-update-event-handler the-window)))
          )))))
|#

#|
(defpascal event-wdef (:word callbackselector :ptr callbackparms :ptr callbackud) ;#+carbon-compat :ptr #-carbon-compat :long callbackud)   ;; callbackud was :long
  (let-globally ((*no-scheduling* t)) ;; doesn't fix the problem??
    ;(let ((did-deact (when (and *the-timer* (%i> *timer-count* 0)) 
    ;                   (progn (#_SetEventLoopTimerNextFireTIme (%get-ptr *the-timer*) *event-delay-forever*) t))))  ;; now no bug if *timer-count* > 1
    (when (eql callbackud *my-nav-ud*)      
      (when (and (eq callbackselector #$knavCBcancel)) ; (eql callbackud *my-nav-ud* ))
        (setq *the-nav-reply* :cancelled)
        )    
      (when (and (not (osx-p))
                 ;(eql callbackud *my-nav-ud*)
                 (eq callbackselector #$kNavCBEvent) ;; update or idle or something
                 )
        (with-macptrs ((the-data  (pref callbackparms :navcbrec.eventdata))
                       (the-event (rref the-data :eventdata.event))
                       the-wptr)
          (let* ((what (rref the-event :eventrecord.what)))
            (when (eq what #$UpdateEvt)
              (%setf-macptr the-wptr (rref the-event :eventrecord.message)) ;; is that the wptr
              ;; well I'll be darned it seems to work
              (let* ((the-window (window-object the-wptr)))
                (when the-window
                  (window-update-event-handler the-window)))))))
      (unless (eq *the-nav-reply* :cancelled)      
        ;; or #$kNavCBUserAction ??
        (when (and (or #|(eq callbackselector #$kNavCBAccept)|# (eq callbackselector #$kNavCBTerminate))
                   ;(eql callbackud *my-nav-ud*)
                   (eql (pref callbackparms :navcbrec.context) *the-nav-dialog*))
          (setq *the-nav-reply* :done)
         ))
      ;(when did-deact (#_SetEventLoopTimerNextFireTIme (%get-ptr *the-timer*) *event-loop-initial-fire-time*))
      )))
|#

#|
(defun get-popup-selection (callbackparms)
  (with-macptrs ((the-param (pref callbackparms :NavCBRec.eventData.eventDataParms.param)))
    ;; its a ptr to a navmenuitemspec - the menutype is an index - except it's an ostype
    (let ((phoo (pref the-param :navmenuitemspec.menutype)))
      (if (neq phoo :TEXT)
        (when (symbolp phoo)
          (let* ((name (symbol-name phoo)))
            (when (eq (length name) 4)
              (let ((idx (char-code (char name 3))))
                (when (< idx (length *save-as-types*))                  
                  (setq *nav-popup-index* idx))))))))))
|#



(defun get-popup-selection (callbackparms)
  (with-macptrs ((the-param (pref callbackparms :NavCBRec.eventData.eventDataParms.param)))
    ;; its a ptr to a navmenuitemspec - the menutype is an index - except it's an ostype
    (let ((phoo (pref the-param :navmenuitemspec.menutype)))
      (setq *nav-popup-index*
            (if (neq phoo :CCL2)
              (let ((name (pref the-param :navmenuitemspec.menuitemname))
                    (idx 0))                
                (dolist (x *save-as-types* nil)
                  (when (string= (car x) name)(return idx))
                  (incf idx))))))))

(defpascal event-wdef (:word callbackselector :ptr callbackparms :ptr callbackud) ;#+carbon-compat :ptr #-carbon-compat :long callbackud)   ;; callbackud was :long
  (progn ;let-globally ((*no-scheduling* t)) ;; doesn't fix the problem??
    ;(let ((did-deact (when (and *the-timer* (%i> *timer-count* 0)) 
    ;                   (progn (#_SetEventLoopTimerNextFireTIme (%get-ptr *the-timer*) *event-delay-forever*) t))))  ;; now no bug if *timer-count* > 1
    
    (when (eql callbackud *my-nav-ud*)      
      (cond 
       ((eq callbackselector #$knavCBPopupMenuSelect)
        (get-popup-selection callbackparms))
       (nil ;(not (osx-p))         
        (when (and (eq callbackselector #$knavCBcancel)) ; (eql callbackud *my-nav-ud* ))
          (setq *the-nav-reply* :cancelled)
          )    
        (when (and (not (osx-p))
                   ;(eql callbackud *my-nav-ud*)
                   (eq callbackselector #$kNavCBEvent) ;; update or idle or something
                   )
          (with-macptrs (;(the-data  (pref callbackparms :navcbrec.eventdata))
                         (the-event (pref callbackparms navcbrec.eventdata.eventdataparms.event)) ;     :eventdata.event))
                         the-wptr)
            (let* ((what (rref the-event :eventrecord.what)))
              (when (eq what #$UpdateEvt)
                (%setf-macptr the-wptr (rref the-event :eventrecord.message)) ;; is that the wptr
                ;; well I'll be darned it seems to work
                (let* ((the-window (window-object the-wptr)))
                  (when the-window
                    (window-update-event-handler the-window)))))))
        (unless (eq *the-nav-reply* :cancelled)      
          ;; or #$kNavCBUserAction ??
          (when (and (or #|(eq callbackselector #$kNavCBAccept)|# (eq callbackselector #$kNavCBTerminate))
                     ;(eql callbackud *my-nav-ud*)
                     (eql (pref callbackparms :navcbrec.context) *the-nav-dialog*))
            (setq *the-nav-reply* :done)
            ))
        ;(when did-deact (#_SetEventLoopTimerNextFireTIme (%get-ptr *the-timer*) *event-loop-initial-fire-time*))
        )))))




(defun remember-nav-folder (nav-dialog)
  (with-aedescs (aedesc)
    (if nil ;(not (osx-p))
      (rlet ((fsptr :fsspec))        
        (let ((size (record-length :fsspec)))
          (ae-error (#_aecreatedesc #$typeFSS fsptr size aedesc)))        
        (#_NavCustomControl nav-dialog #$kNavCtlGetLocation aedesc) 
        (ignore-errors 
         ;; will error on osx if the chosen thing is an alias to a folder - don't know why
         (let ((path (path-from-aedesc aedesc)))           
           (set-choose-file-default-directory-2 path))))
      (rlet ((fsref :fsref))
        (let ((size (record-length :fsref)))
          (ae-error (#_aecreatedesc #$typeFSref fsref size aedesc))
          ;; works for nav-choose-new-file-dialog on OSX
          ;; not for nav-choose-file-dialog - do we need to use #_navcreate... in that case too - seems so
          (#_NavCustomControl nav-dialog #$kNavCtlGetLocation aedesc)
          (ae-error (#_aegetdescdata aedesc fsref size))            
          (ignore-errors 
           (let ((path (%path-from-fsref fsref t))) 
             (set-choose-file-default-directory-2 path))))))))



#| tests
(choose-new-file-dialog
 :directory "new.lisp"
 :prompt "Prompt message goes here ..."
 :button-string "Create File"
 :mac-file-type :text
 :mac-file-creator (application-file-creator *application*)
 :cancel-button-string "Stop Button"
 :window-title "Create a New File"
 :window-position (make-point 30 120))

(choose-file-dialog
 :directory "ccl:Library;"
 :button-string "Hi!"
 :window-title "This window has a title"
 :cancel-button-string "Stop Now!"
 :prompt "The prompt sentence goes here ..."
 :window-position (make-point 30 100))

(choose-directory-dialog
 :directory "ccl:Library;dialog-macros.lisp"
 :prompt "Prompt message goes here ..."
 :button-string "This one!"
 :cancel-button-string "Bad choice"
 :window-title "This window has a title"
 :window-position (make-point 30 120))

(choose-new-file-dialog
 :directory "new.lisp"
 :prompt "Prompt message goes here ..."
 :button-string "Create File"
 :mac-file-type :text
 :mac-file-creator (application-file-creator *application*)
 :cancel-button-string "Stop Button"
 :window-title "Create a New File"
 :window-position (make-point 30 120)
 :format-query-p t
 :extended-reply-p t
 )
|#







                  