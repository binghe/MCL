(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AudioOutputUnit.h"
; at Sunday July 2,2006 7:26:53 pm.
; 
;      File:       AudioOutputUnit.h
;  
;      Contains:   AudioOutputUnit Interfaces
;  
;      Version:    Technology: System 9, X
;                  Release:    Mac OS X
;  
;      Copyright:  © 2000-2002 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AUDIOOUTPUTUNIT__
; #define __AUDIOOUTPUTUNIT__

(require-interface "AudioUnit/AUComponent")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

; #if PRAGMA_IMPORT
#| ; #pragma import on
 |#

; #endif


; #if PRAGMA_STRUCT_ALIGN
#| ; #pragma options align=mac68k
 |#

; #elif PRAGMA_STRUCT_PACKPUSH
#| ; #pragma pack(push, 2)
 |#

; #elif PRAGMA_STRUCT_PACK
#| ; #pragma pack(2)
 |#

; #endif

; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    ranges
; 

(defconstant $kAudioOutputUnitRange #x200)
; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;     Start/stop methods for audio output units
; 

(deftrap-inline "_AudioOutputUnitStart" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0000 #\, 0x0201 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioOutputUnitStop" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0000 #\, 0x0202 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )
;  UPP call backs 
;  selectors for component calls 

(defconstant $kAudioOutputUnitStartSelect #x201)
(defconstant $kAudioOutputUnitStopSelect #x202)

; #if PRAGMA_STRUCT_ALIGN
#| ; #pragma options align=reset
 |#

; #elif PRAGMA_STRUCT_PACKPUSH
#| ; #pragma pack(pop)
 |#

; #elif PRAGMA_STRUCT_PACK
#| ; #pragma pack()
 |#

; #endif

; #ifdef PRAGMA_IMPORT_OFF
#| #|
#pragma import off
|#
 |#

; #elif PRAGMA_IMPORT
#| ; #pragma import reset
 |#

; #endif

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __AUDIOOUTPUTUNIT__ */


(provide-interface "AudioOutputUnit")