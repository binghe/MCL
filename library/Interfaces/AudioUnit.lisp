(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AudioUnit.h"
; at Sunday July 2,2006 7:26:52 pm.
; 
;      File:      AudioUnit/AudioUnit.h
;  
;      Contains:  Umbrella include for AudioUnit definitions
;  
;      Version:   Technology: Mac OS X
;  
;      Copyright: (c) 2002 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AUDIOUNIT__
; #define __AUDIOUNIT__
;  This is the main AudioUnit specification

(require-interface "AudioUnit/AUComponent")

(require-interface "AudioUnit/AudioOutputUnit")

(require-interface "AudioUnit/MusicDevice")

(require-interface "AudioUnit/AudioUnitProperties")

(require-interface "AudioUnit/AudioUnitParameters")

(require-interface "AudioUnit/AudioUnitCarbonView")

(require-interface "AudioUnit/AudioCodec")
;  This file relies on AUComponent.h
;  and contains the differences of Version 1 API

(require-interface "AudioUnit/AUNTComponent")

; #endif /* __AUDIOUNIT__ */


(provide-interface "AudioUnit")