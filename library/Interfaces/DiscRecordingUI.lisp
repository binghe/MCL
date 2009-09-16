(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DiscRecordingUI.h"
; at Sunday July 2,2006 7:27:39 pm.
; 
;      File:       DiscRecordingUI/DiscRecordingUI.h
;  
;      Contains:   DiscRecordingUI interfaces.
;  
;       Version:   Technology: Mac OS X
;                  Release:    Mac OS X
;  
;     Copyright:   (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifdef __OBJC__
#| #|

#import <DiscRecordingUIDRSetupPanel.h>
#import <DiscRecordingUIDRBurnSetupPanel.h>
#import <DiscRecordingUIDREraseSetupPanel.h>

#import <DiscRecordingUIDRBurnProgressPanel.h>
#import <DiscRecordingUIDREraseProgressPanel.h>

#import <DiscRecordingUIDiscRecordingUIResources.h>

|#
 |#

; #else
; #ifndef _H_DiscRecordingUI
; #define _H_DiscRecordingUI

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifndef _H_DRBurnSession

(require-interface "DiscRecordingUI/DRBurnSession")

; #endif

; #ifndef _H_DREraseSession

(require-interface "DiscRecordingUI/DREraseSession")

; #endif


; #endif


; #endif /* _H_DiscRecordingUI */


(provide-interface "DiscRecordingUI")