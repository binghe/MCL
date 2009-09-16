(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGError.h"
; at Sunday July 2,2006 7:23:59 pm.
; 
;  *  CGError.h
;  *  CoreGraphics
;  *
;  *  Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
;  *
;  
; #ifndef __CGERROR_H__
(defconstant $__CGERROR_H__ 1)
; #define __CGERROR_H__ 1

(require-interface "CoreGraphics/CGBase")

(require-interface "stdint")
;  Types used for error and error handler 
(def-mactype :_CGError (find-mactype ':sint32))

(defconstant $kCGErrorSuccess 0)
(defconstant $kCGErrorFirst #x3E8)
(defconstant $kCGErrorFailure #x3E8)
(defconstant $kCGErrorIllegalArgument #x3E9)
(defconstant $kCGErrorInvalidConnection #x3EA)
(defconstant $kCGErrorInvalidContext #x3EB)
(defconstant $kCGErrorCannotComplete #x3EC)
(defconstant $kCGErrorNameTooLong #x3ED)
(defconstant $kCGErrorNotImplemented #x3EE)
(defconstant $kCGErrorRangeCheck #x3EF)
(defconstant $kCGErrorTypeCheck #x3F0)
(defconstant $kCGErrorNoCurrentPoint #x3F1)
(defconstant $kCGErrorInvalidOperation #x3F2)
(defconstant $kCGErrorNoneAvailable #x3F3)      ; 	internal errors have taken 1012, 1013, and 1014 

(defconstant $kCGErrorApplicationRequiresNewerSystem #x3F7); 	the application being launched says in it's bundle info that it requires a 
; 	newer version of the system than is currently running. 

(defconstant $kCGErrorApplicationNotPermittedToExecute #x3F8); 	Macintosh Manager is active, and this application is not permitted to run 

(defconstant $kCGErrorApplicationIncorrectExecutableFormatFound #x3FF); 	the application being launched does not have any executable code for the 
; 	current system. 

(defconstant $kCGErrorApplicationIsLaunching #x400)
;  The application is in the process of launching, but hasn't checked in yet.
; 		   Any launch data provided will be given to the application when it does
; 		   check in. 

(defconstant $kCGErrorApplicationAlreadyRunning #x401)
; 	The application being launched was already running ( and had already checked
; 		    in ) and so any launch data provided can not be delivered to in by CPS 

(defconstant $kCGErrorApplicationCanOnlyBeRunInOneSessionAtATime #x402)
; 	The application being launched is incompatible with multiple user sessions,
; 			and is already running in another session by another user. 

(defconstant $kCGErrorLast #x402)

(def-mactype :CGError (find-mactype ':SInt32))

; #endif /* __CGERROR_H__ */


(provide-interface "CGError")