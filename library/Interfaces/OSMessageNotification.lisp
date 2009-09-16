(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OSMessageNotification.h"
; at Sunday July 2,2006 7:24:15 pm.
; 
;  * Copyright (c) 1998-2000 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * The contents of this file constitute Original Code as defined in and
;  * are subject to the Apple Public Source License Version 1.1 (the
;  * "License").  You may not use this file except in compliance with the
;  * License.  Please obtain a copy of the License at
;  * http://www.apple.com/publicsource and read it before using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
;  * License for the specific language governing rights and limitations
;  * under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; 
;  * Copyright (c) 1999 Apple Computer, Inc.  All rights reserved. 
;  *
;  * HISTORY
;  *
;  
; #ifndef	__OS_OSMESSAGENOTIFICATION_H
; #define __OS_OSMESSAGENOTIFICATION_H
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(require-interface "mach/mach_types")

(require-interface "IOKit/IOReturn")

(defconstant $kFirstIOKitNotificationType 100)
(defconstant $kIOServicePublishNotificationType 100)
(defconstant $kIOServiceMatchedNotificationType 101)
(defconstant $kIOServiceTerminatedNotificationType 102)
(defconstant $kIOAsyncCompletionNotificationType #x96)
(defconstant $kIOServiceMessageNotificationType #xA0)
(defconstant $kLastIOKitNotificationType #xC7)

(defconstant $kOSNotificationMessageID 53)
(defconstant $kOSAsyncCompleteMessageID 57)
(defconstant $kMaxAsyncArgs 16)

(defconstant $kIOAsyncReservedIndex 0)
(defconstant $kIOAsyncReservedCount 1)
(defconstant $kIOAsyncCalloutFuncIndex 1)
(defconstant $kIOAsyncCalloutRefconIndex 2)
(defconstant $kIOAsyncCalloutCount 3)
(defconstant $kIOMatchingCalloutFuncIndex 1)
(defconstant $kIOMatchingCalloutRefconIndex 2)
(defconstant $kIOMatchingCalloutCount 3)
(defconstant $kIOInterestCalloutFuncIndex 1)
(defconstant $kIOInterestCalloutRefconIndex 2)
(defconstant $kIOInterestCalloutServiceIndex 3)
(defconstant $kIOInterestCalloutCount 4)

(defconstant $kOSAsyncRefCount 8)
(defconstant $kOSAsyncRefSize 32)
(defrecord OSAsyncReference
   (contents (:array :UInt32 8))
)
(defrecord OSNotificationHeader
   (size :UInt32)
                                                ;  content size 
   (type :UInt32)
   (reference :OSASYNCREFERENCE)
   (content (:array :UInt8 0))
)
(defrecord IOServiceInterestContent
   (messageType :UInt32)
   (messageArgument (:array :pointer 1))
)
(defrecord IOAsyncCompletionContent
   (result :signed-long)
   (args (:array :pointer 0))
)
; #ifndef __cplusplus

;type name? (%define-record :OSNotificationHeader (find-record-descriptor ':OSNotificationHeader))

;type name? (%define-record :IOServiceInterestContent (find-record-descriptor ':IOServiceInterestContent))

;type name? (%define-record :IOAsyncCompletionContent (find-record-descriptor ':IOAsyncCompletionContent))

; #endif

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /*  __OS_OSMESSAGENOTIFICATION_H */


(provide-interface "OSMessageNotification")