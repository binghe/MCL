(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DiscRecordingContent.h"
; at Sunday July 2,2006 7:27:37 pm.
; 
;      File:       DiscRecordingContent/DiscRecordingContent.h
;  
;      Contains:   DiscRecordingContent interfaces.
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
; #ifndef _H_DiscRecordingContent
; #define _H_DiscRecordingContent

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifndef _H_DRContentFolder

(require-interface "DiscRecordingContent/DRContentFolder")

; #endif

; #ifndef _H_DRContentFile

(require-interface "DiscRecordingContent/DRContentFile")

; #endif

; #ifndef _H_DRContentProperties

(require-interface "DiscRecordingContent/DRContentProperties")

; #endif

; #ifndef _H_DRContentTrack

(require-interface "DiscRecordingContent/DRContentTrack")

; #endif

; #ifdef __OBJC__
#| #|
#import <DiscRecordingContentDRFile.h>
#import <DiscRecordingContentDRFolder.h>
#import <DiscRecordingContentDRFSObject.h>
#import <DiscRecordingContentDRTrack_ContentSupport.h>
#endif
|#
 |#

; #endif /* _H_DiscRecordingContent */


(provide-interface "DiscRecordingContent")