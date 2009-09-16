

;;	Change History (most recent first):
;;  2 6/2/97   akh  def.-fred-commands conditional
;;  1 10/21/95 bill Newly checked in
;;  (do not edit before this line!!)
;;; processes.lisp
;;;
;;; Enough process stuff to select AppleLink and get back with the keyboard

;;; Copyright ©1993-1995, Apple Computer, Inc.
;;; Permission given to use and modify this code as long as this
;;; copyright notice is preseved.

;;; Author: Bill St. Clair
;;; 
;;; If you want control-shift-x to select different applications for different values of X.
;;; then do (pushnew :add-process-key-bindings *features*) before loading this file.
;;; Then control-shift-x will launch the app if it isn't already active, instead of
;;; the usual behavior of control-shift-X in Fred.
;;; control-shift-command makes MCL come to the front when another
;;; application is active

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;;
;;; launch-application uses fsrefs, fix get-creator-path though still uses fsspec
;; ------ 5.2b6
;;; small change for new headers
;;; put select-mcl-eventhook inside #+:add-process-key-bindings
;;; use %path-to-fsspec
;;; ---- 5.1 final
;;; pbdtgetapplsync
;;; ------ 4.3f1c1
;;; 10/23/96 bill launch-application takes new optional args: file-or-files-to-open, stay-in-background-p
;;; ------------- 4.0
;;; 10/20/95 bill find-process coerces its signature arg to a keyword.
;;;               Added to "ccl:examples;"
;;;               select-anarchy
;;; 05/08/95 bill m-s-n selects NetScape
;;; 06/25/93 bill ensure-application-active
;;;

(in-package :ccl)

;(require :appleevent-toolkit)           ; for launch-application's 'odoc' event

; Prevent compiler warnings
#+ignore
(eval-when (:compile-toplevel :execute)
  (declaim (ftype (function (*)) send-appleevent create-odoc create-psn-target)))

(defmacro with-processInfoRec (sym &body body)
  (let ((name (gensym))
        (fsspec (gensym)))
    `(rlet ((,sym :ProcessInfoRec)
            (,name (string 32))
            (,fsSpec :FSSpec))
       (setf (pref ,sym processInfoRec.processInfoLength) (record-length :processInfoRec)
             (pref ,sym processInfoRec.processName) ,name
             (pref ,sym processInfoRec.processAppSpec) ,fsSpec)
       ,@body)))  

#|
(defun launch-application (filename &optional file-or-files-to-open stay-in-background-p)
  (rlet ((fsspec :FSSpec))
    (rlet ((pb :launchParamBlockRec
               :launchBlockID #$extendedBlock
               :launchEPBLength #$extendedBlockLen
               :launchControlFlags (+ #$launchContinue
                                      #$launchNoFileFlags
                                      (if stay-in-background-p #$launchDontSwitch 0))
               :launchAppSpec fsspec
               :launchAppParameters (%null-ptr)))
      (%path-to-fsspec filename fsspec :quiet)
      #+old
      (with-pstrs ((name (mac-namestring (probe-file filename))))
        (#_FSMakeFSSpec 0 0 name fsspec))
      (rletz ((params :AppParameters
                      :eventRefCon 0
                      :messageLength 0))
        (when file-or-files-to-open
          ; It would be nice to put the 'odoc' event here directly,
          ; but I can't find any information about flattenning an AppleEvent
          ; into a high-level event. -Bill
          (setf (pref params :AppParameters.what) #$nullEvent
                (pref pb :launchParamBlockRec.launchAppParameters) params))
        (without-interrupts             ; don't let the app start up until we've sent the AppleEvent
         (when (eql 0 (#_LaunchApplication pb))
           (when file-or-files-to-open
             (with-aedescs (ae target reply)
               (create-psn-target target
                                  (pref pb :launchParamBlockRec.launchProcessSN.highLongOfPSN)
                                  (pref pb :launchParamBlockRec.launchProcessSN.lowLongOfPSN))
               (create-odoc ae target (if (atom file-or-files-to-open)
                                        (list file-or-files-to-open)
                                        file-or-files-to-open))
               (send-appleevent ae reply)))
           filename))))))
|#

(defun launch-application (filename &optional doc-paths stay-in-background-p)
  (if (and doc-paths (not (consp doc-paths)))(setq doc-paths (list doc-paths)))
  (let ((result nil)
        (ndocs (length doc-paths)))
    (declare (fixnum ndocs))
    (rlet ((fsref :FSref)
           (launchspec :LSlaunchFSRefSpec
                       :appref fsref))
      (let* ((*alias-resolution-policy* :quiet)
             (res (path-to-fsref filename fsref)))
        (when res
          (%stack-block ((refs (* ndocs (record-length :fsref))))
            (cond
             ((null doc-paths)
              (setf (pref launchspec :LSlaunchFSRefSpec.itemrefs) (%null-ptr)))
             (t (let ((offset 0))
                  (declare (fixnum offset))
                  (setf (pref launchspec :LSlaunchFSRefSpec.itemrefs) refs)
                  (dolist (doc doc-paths) 
                    (let ((res (path-to-fsref doc (%inc-ptr refs offset))))
                      (if res 
                        (incf offset (record-length :fsref))
                        (decf ndocs)))))))
            (setf (pref launchspec :LSlaunchFSRefSpec.numdocs) ndocs)
            (setf (pref launchspec :lsLaunchFSRefspec.passthruparams) (%null-ptr))
            (setf (pref launchspec :LSLaunchFSRefspec.launchflags) 
                  (logior #$kLSLaunchDefaults (if stay-in-background-p (logior #$kLSLaunchDontAddToRecents #$kLSLaunchDontSwitch) 0)))  ;; ??
            (setf (pref launchspec :LSLaunchFSRefspec.asyncRefCon)(%null-ptr))
            (let ((err (#_LSOpenFromRefSpec launchspec (%null-ptr))))
              (if (eq err #$noerr)
                (setq result filename)))))))
    result))

;; #_LSFindApplicationForInfo
; Given a four-character creator code, finds the most recent application.
; Searches the mounted devices in the order mounted (same as the Finder?)
; until it finds one.
(defun get-creator-path (creator)
  (let ((devs (directory "*:")))
    ;; "network:" may not exist
    (setq devs (remove-if #'(lambda (foo)(not (probe-file foo)))  devs)) 
    (dolist (vrefnum (sort (mapcar 'volume-number devs) #'>))
      (rlet ((pb :DTPBRec
                 :ioNamePtr (%null-ptr)
                 :ioVRefnum vrefnum)
             (fsspec :fsspec))
        (when (eql 0 (#_PBDTGetPath pb))
          (setf (rref pb :DTPBRec.ioNamePtr)
                (%inc-ptr fsspec (get-field-offset :fsspec.name))
                (pref pb :DTPBRec.ioIndex) 0
                (pref pb :DTPBRec.ioFileCreator) creator)
          (when (eql 0 (#_PBDTGetAPPLSync pb))
            (setf (pref fsspec :fsspec.vRefnum) vrefnum
                  (pref fsspec :fsspec.parID) (pref pb :DTPBRec.ioAPPLParID))
            (return (%path-from-fsspec fsspec))))))))

#| ;; finds some random one - from 5 years ago
(defun get-creator-path (creator)
  (rlet ((fsref :fsref))
    (let ((err (#_LSFindApplicationForInfo
                creator
                (%null-ptr)  ;; bundleID
                (%null-ptr)  ;; name
                fsref
                (%null-ptr))))
      (when (eq err #$noerr)
        (%path-from-fsref fsref)))))
|#
                               
(defun launch-creator (creator)
  (let ((file (get-creator-path creator)))
    (when file
      (launch-application file))))

; From IM VI p. 29-11
(defun find-process (signature &optional psn)
  (setq signature (make-keyword signature))
  (unless psn (setq psn  (make-record :processSerialNumber)))
  (with-processInfoRec infoRec
    (setf (pref psn :processSerialNumber.highLongOfPSN) 0
          (pref psn :processSerialNumber.lowLongOfPSN) 0)
    (loop
      (unless (eql (#_GetNextProcess psn) #$noErr) (return nil))
      (when (and (eql (#_getProcessInformation psn infoRec) #$noErr)
                 (or (%equal-ostype infoRec :APPL
                                    (get-field-offset :processInfoRec.processType))
                     (%equal-ostype infoRec :FNDR
                                    (get-field-offset :processInfoRec.processType)))
                 (%equal-ostype infoRec signature
                                (get-field-offset :processInfoRec.processSignature)))
        (return psn)))))
                 
(defun select-process (creator &optional (launch? t))
  (rlet ((psn :processSerialNumber))
    (if (find-process creator psn)
      (#_setFrontProcess psn)
      (unless (and launch? (launch-creator creator))
        (ed-beep)))))

(defun ensure-application-active (creator)
  (if (find-process creator)
    t
    (let* ((foreground *foreground*)
           (filename (launch-creator creator)))
      (when (and filename foreground)
        (loop
          (event-dispatch)
          (unless *foreground* (return)))
        (select-mcl))
      filename)))

(defun select-finder (&optional ignore)
  (declare (ignore ignore))
  (select-process :MACS nil))

(defun select-mcl ()
  (rlet ((psn :processSerialNumber))
    (#_getCurrentProcess psn)
    (#_setFrontProcess psn)))

#+:add-process-key-bindings
(progn

(def-fred-command (:control :shift #\F) select-finder)

(defun select-applelink (&optional ignore)
  (declare (ignore ignore))
  (select-process :GEOL))

(def-fred-command (:control :shift #\A) select-applelink)

(defun select-macx (&optional ignore)
  (declare (ignore ignore))
  (select-process :|MacX|))
(def-fred-command (:control :shift #\X) select-macx)

(defun select-techmail (&optional ignore)
  (declare (ignore ignore))
  (select-process :MITM))
(def-fred-command (:control :shift #\T) select-techmail)

(defun select-Eudora (&optional ignore)
  (declare (ignore ignore))
  (select-process :|CSOm|))
(def-fred-command (:control :shift #\E) select-eudora)

(defun select-instant-update (&optional ignore)
  (declare (ignore ignore))
  (select-process :IUA0))
(def-fred-command (:control :shift #\I) select-instant-update)

(defun select-mpw (&optional ignore)
  (declare (ignore ignore))
  (select-process :|MPS\ |))
(def-fred-command (:control :shift #\M) select-mpw)

(defun select-zterm (&optional ignore)
  (declare (ignore ignore))
  (select-process :\zTRM))
(def-fred-command (:control :shift #\Z) select-zterm)

(defun select-msword (&optional ignore)
  (declare (ignore ignore))
  (select-process :MSWD))
(def-fred-command (:control :shift #\W) select-msword)

(defun select-think-reference (&optional ignore)
  (declare (ignore ignore))
  (select-process :|DanR|))
(def-fred-command (:control :shift #\R) select-think-reference)

(defun select-filemaker-pro (&optional ignore)
  (declare (ignore ignore))
  (select-process :|FMPR|))
(def-fred-command (:control :shift #\D) select-filemaker-pro)

(defun select-netscape (&optional ignore)
  (declare (ignore ignore))
  (select-process :|MOSS|))
(def-fred-command (:control :shift #\N) select-netscape)

(defun select-anarchie (&optional ignore)
  (declare (ignore ignore))
  (select-process :|Arch|))
(def-fred-command (:control :shift #\K) select-anarchie)

(defun select-mcl-eventhook (&rest ignore)
  (declare (ignore ignore))
  (unless *foreground*
    (let ((*current-event* nil))
      (makunbound '*current-event*)
      (when (and (control-key-p) (option-key-p) (command-key-p))
        (select-mcl))))
  nil)

(push 'select-mcl-eventhook *eventhook*)
)

(provide :processes)
