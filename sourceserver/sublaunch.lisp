

;;	Change History (most recent first):
;;  2 6/2/97   akh  no change
;;  (do not edit before this line!!)
; sublaunch.lisp
; Copyright 1995 Digitool, Inc.

(in-package :ccl)

; Modification History:
;
; 10/23/96 bill  Use the new form of #_LaunchApplication via the launch-application function.
;                It has the nice property that it doesn't change the default directory.
; -------------  4.0
; 02/08/96 bill  New trap names
;  5/25/95 slh   store-app-param-handle: reuse existing handle
; 11/05/91 gz    Convert to new traps.


(require :processes)

(defun sublaunch (path &optional file (stay-in-background-p nil))
  (launch-application path file stay-in-background-p))

#|  ; Obsolete code
;;; Don't export this one in RSTAR package. It will cause name conflict.
;;; Hai 6/17/93
;(export 'sublaunch)  

;The following three defs were lifted from Leibniz Sources:Defs:Defsys.lisp
(eval-when (:execute :compile-toplevel #-debugged :load-toplevel)
  (require 'lispequ)
  (require 'sysequ)
  (defrecord LaunchStruct
    (pfName :pointer)
    (param :integer)
    (LC :unsigned-integer)                 ; extended parameters:
    (extBlockLen :longint)              ; number of bytes in extension = 6
    (fFlags :integer)                   ; Finder file info flags
    (launchFlags :unsigned-integer)        ; bit 15,14=1 for sublaunch, others reserved
    (reserved :integer)))

(defun sublaunch (path &optional file (stay-in-background-p nil))
  (when file (store-app-param-handle file))
  (rlet ((launch :LaunchStruct))
    (%stack-iopb (pb np)
      ;Get the Finder flags
      (%path-to-iopb path pb :errchk)
      (%put-ostype pb "ERIK" $ioWDProcID)
      (%put-ptr pb (%null-ptr) $ioFileName)
      (#_PBOpenWDSync :errchk pb)
      (#_PBSetVolSync :errchk pb)
      (%put-ptr pb np $ioFileName)
      (%put-long pb 0 $ioDirID)
      (%put-word pb 0 $ioFDirIndex)
      (#_PBGetCatInfoSync :errchk pb)
      (rset launch :LaunchStruct.pfName np)
      (rset launch :LaunchStruct.param 0)
      (rset launch :LaunchStruct.LC #x4C43)
      (rset launch :LaunchStruct.extBlockLen 6)
      ;Copy flags; set bit 6 of low byte to 1 for RO access:
      (rset launch :LaunchStruct.fFlags (%get-signed-word pb $fdFlags))
      (rset launch :LaunchStruct.launchFlags (logior 
                                              #$launchContinue
                                              (if stay-in-background-p #$launchDontSwitch 0)))
      (rset launch :LaunchStruct.reserved 0)
      (let ((err (#_LaunchApplication launch)))
        (when (< err 0)
          (case err                     ; Process Manager errors
            ((-600) (error "No elegible process with specified descriptor"))
            ((-601) (error "Not enough room to launch application w/special requirements"))
            ((-602) (error "Memory mode is 32-bit, but application not 32-bit clean"))
            ((-603) (error "Application made module calls in improper order"))
            ((-604) (error "Hardware configuration not correct for call"))
            ((-605) (error "Application SIZE not big enough for launch"))
            ((-606) (error "Application is background-only, and launch flags disallow this"))
            (t (%err-disp err))))))))

(defun store-app-param-handle (file)
  (with-macptrs ((ploc (%int-to-ptr $appparmhandle)))
    (let ((params (%get-ptr ploc)))
      (when (%null-ptr-p params)
        (%put-ptr ploc (setq params (#_NewHandle :errchk 0))))
      (%stack-iopb (pb np)
        (%path-to-iopb file pb :errchk)
        (%put-ostype pb "ERIK" $ioWDProcID)
        (%put-ptr pb (%null-ptr) $ioFileName)
        (#_PBOpenWDSync :errchk pb)
        (#_SetHandleSize :errchk params (+ 13 (%get-byte np)))
        (with-dereferenced-handle (p params)
          (%put-word p 0 0)
          (%put-word p 1 2)
          (%put-word p (%get-word pb $ioVRefNum) 4)
          (%put-ptr pb np $ioFileName)
          (%put-long pb 0 $ioDirID)
          (%put-word pb 0 $ioFDirIndex)
          (#_PBGetCatInfoSync :errchk pb)
          (%put-ostype p (%get-ostype pb $fdType) 6)
          (%put-word p 0 10)
          (#_BlockMove np (%inc-ptr p 12) (1+ (%get-byte np))))))))

|#  ; end of obsolete code

#|
	Change History (most recent last):
	1	9/28/93	HW	Now it's in RSTAR SourceServer.
|# ;(do not edit past this line!!)
