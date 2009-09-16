(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DiscRecordingEngine.h"
; at Sunday July 2,2006 7:27:34 pm.
; 
;      File:       DiscRecordingEngine/DiscRecordingEngine.h
;  
;      Contains:   DiscRecordingEngine interfaces.
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef _H_DiscRecordingEngine
; #define _H_DiscRecordingEngine

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifndef _H_DRCoreBurn

(require-interface "DiscRecordingEngine/DRCoreBurn")

; #endif

; #ifndef _H_DRCoreDevice
#| #|
#include <DiscRecordingEngineDRCoreDevice.h>
#endif
|#
 |#
; #ifndef _H_DRCoreErase

(require-interface "DiscRecordingEngine/DRCoreErase")

; #endif

; #ifndef _H_DRCoreStatus

(require-interface "DiscRecordingEngine/DRCoreStatus")

; #endif

; #ifndef _H_DRCoreErrors

(require-interface "DiscRecordingEngine/DRCoreErrors")

; #endif

; #ifndef _H_DRCoreNotifications

(require-interface "DiscRecordingEngine/DRCoreNotifications")

; #endif

; #ifndef _H_DRCoreObject
#| #|
#include <DiscRecordingEngineDRCoreObject.h>
#endif
|#
 |#
; #ifndef _H_DRCoreTrack
#| #|
#include <DiscRecordingEngineDRCoreTrack.h>
#endif
|#
 |#
; #ifdef __OBJC__
#| #|
#import <DiscRecordingEngineDRBurn.h>
#import <DiscRecordingEngineDRDevice.h>
#import <DiscRecordingEngineDRMSF.h>
#import <DiscRecordingEngineDRMSFFormatter.h>
#import <DiscRecordingEngineDRErase.h>
#import <DiscRecordingEngineDRNotificationCenter.h>
#import <DiscRecordingEngineDRStatus.h>
#import <DiscRecordingEngineDRTrack.h>
#endif
|#
 |#
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(deftrap-inline "_DRGetVersion" 
   (
   )
   :NumVersion
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _H_DiscRecordingEngine */


(provide-interface "DiscRecordingEngine")