(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AXError.h"
; at Sunday July 2,2006 7:24:40 pm.
; 
;  *  AXError.h
;  *
;  *  Copyright (c) 2002 Apple Computer, Inc. All rights reserved.
;  *
;  
; #ifndef __AXERROR__
; #define __AXERROR__
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(require-interface "CoreFoundation/CoreFoundation")

(defconstant $kAXErrorSuccess 0)
(defconstant $kAXErrorFailure -25200)
(defconstant $kAXErrorIllegalArgument -25201)
(defconstant $kAXErrorInvalidUIElement -25202)
(defconstant $kAXErrorInvalidUIElementObserver -25203)
(defconstant $kAXErrorCannotComplete -25204)
(defconstant $kAXErrorAttributeUnsupported -25205)
(defconstant $kAXErrorActionUnsupported -25206)
(defconstant $kAXErrorNotificationUnsupported -25207)
(defconstant $kAXErrorNotImplemented -25208)
(defconstant $kAXErrorNotificationAlreadyRegistered -25209)
(defconstant $kAXErrorNotificationNotRegistered -25210)
(defconstant $kAXErrorAPIDisabled -25211)
(defconstant $kAXErrorNoValue -25212)
(defconstant $kAXErrorParameterizedAttributeUnsupported -25213)

(def-mactype :AXError (find-mactype ':SInt32))
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif // __AXERROR__


(provide-interface "AXError")