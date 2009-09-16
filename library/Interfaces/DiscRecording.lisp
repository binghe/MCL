(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DiscRecording.h"
; at Sunday July 2,2006 7:27:34 pm.
; 
;      File:       DiscRecording/DiscRecording.h
;  
;      Contains:   DiscRecording interfaces.
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
; #ifndef _H_DiscRecording
; #define _H_DiscRecording

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef _H_DiscRecordingEngine

(require-interface "DiscRecordingEngine/DiscRecordingEngine")

; #endif

; #ifndef _H_DiscRecordingContent

(require-interface "DiscRecordingContent/DiscRecordingContent")

; #endif


; #endif /* _H_DiscRecording */


(provide-interface "DiscRecording")