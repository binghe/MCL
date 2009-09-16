(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DefaultAudioOutput.h"
; at Sunday July 2,2006 7:27:03 pm.
; =============================================================================
; 	DefaultAudioOutput.h
; 	
; 	Public interface to the default audio output AudioUnit.
; 	
; 	Copyright (c) 2000 Apple Computer, Inc.  All Rights Reserved
; =============================================================================
; #ifndef __DefaultAudioOutput_h__
; #define __DefaultAudioOutput_h__

(require-interface "AudioUnit/AudioUnit")
;  open an instance of a default audio output unit (it can be closed with CloseComponent)
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(deftrap-inline "_OpenDefaultAudioOutput" 
   ((outUnit (:pointer :AUDIOUNIT))
   )
   :OSStatus
() )

(deftrap-inline "_OpenSystemSoundAudioOutput" 
   ((outUnit (:pointer :AUDIOUNIT))
   )
   :OSStatus
() )
;  for system sounds like alerts, modems, etc.
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif // __DefaultAudioOutput_h__


(provide-interface "DefaultAudioOutput")