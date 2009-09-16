(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AudioToolbox.h"
; at Sunday July 2,2006 7:26:59 pm.
; 
;      File:       AudioToolbox/AudioToolbox.h
;  
;      Contains:  Umbrella include for AudioToolbox headers.
; 				Also includes CAShow that allows you to print
; 				internal state of an object.
;  
;      Version:    Technology: Mac OS X
;  
;      Copyright:  (c) 2002 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 

(require-interface "AudioToolbox/AudioConverter")

(require-interface "AudioToolbox/AudioFile")

(require-interface "AudioToolbox/AudioFormat")

(require-interface "AudioToolbox/AudioUnitUtilities")

(require-interface "AudioToolbox/AUGraph")

(require-interface "AudioToolbox/AUMIDIController")

(require-interface "AudioToolbox/DefaultAudioOutput")

(require-interface "AudioToolbox/MusicPlayer")
; #ifndef __AudioToolbox_H
; #define __AudioToolbox_H

; #if defined(__cplusplus)
#|
extern "C"
{
#endif
|#
;  prints out the internal state of an object to stdio

(deftrap-inline "_CAShow" 
   ((inObject :pointer)
   )
   nil
() )

(require-interface "stdio")
;  prints out the internal state of an object to the supplied FILE

(deftrap-inline "_CAShowFile" 
   ((inObject :pointer)
    (inFile (:pointer :file))
   )
   nil
() )
;  this will return the name of a sound bank from a sound bank file

(deftrap-inline "_GetNameFromSoundBank" 
   ((inSoundBankRef (:pointer :FSRef))
    (outName (:pointer :CFStringRef))
   )
   :OSStatus
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif // __AudioToolbox_H


(provide-interface "AudioToolbox")