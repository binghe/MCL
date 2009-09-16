(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebKitErrors.h"
; at Sunday July 2,2006 7:32:18 pm.
; 	
;     WebKitErrors.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 
(def-mactype :WebKitErrorDomain (find-mactype '(:pointer :NSString)))
(def-mactype :WebKitErrorMIMETypeKey (find-mactype '(:pointer :NSString)))
(def-mactype :WebKitErrorPlugInNameKey (find-mactype '(:pointer :NSString)))
(def-mactype :WebKitErrorPlugInPageURLStringKey (find-mactype '(:pointer :NSString)))
; !
;     @enum
;     @abstract Policy errors
;     @constant WebKitErrorCannotShowMIMEType
;     @constant WebKitErrorCannotShowURL
;     @constant WebKitErrorFrameLoadInterruptedByPolicyChange
; 

(defconstant $WebKitErrorCannotShowMIMEType 100)
(defconstant $WebKitErrorCannotShowURL 101)
(defconstant $WebKitErrorFrameLoadInterruptedByPolicyChange 102)
; !
;     @enum
;     @abstract Plug-in and java errors
;     @constant WebKitErrorCannotFindPlugin
;     @constant WebKitErrorCannotLoadPlugin
;     @constant WebKitErrorJavaUnavailable
; 

(defconstant $WebKitErrorCannotFindPlugin #xC8)
(defconstant $WebKitErrorCannotLoadPlugin #xC9)
(defconstant $WebKitErrorJavaUnavailable #xCA)
(provide-interface "WebKitErrors")