(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AUNTComponent.h"
; at Sunday July 2,2006 7:26:57 pm.
; 
;      File:       AUNTComponent.h
;  
;      Contains:   AudioUnit Version 1 Specific Interfaces
;  
;      Version:    Technology: System 9, X
;                  Release:    Mac OS X
;  
;      Copyright:  © 2002 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AUNTCOMPONENT__
; #define __AUNTCOMPONENT__

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
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    AudioUnit component types and subtypes
; 

(defconstant $kAudioUnitComponentType :|aunt|)
(defconstant $kAudioUnitSubType_Output :|out |)
(defconstant $kAudioUnitID_HALOutput :|ahal|)
(defconstant $kAudioUnitID_DefaultOutput :|def |)
(defconstant $kAudioUnitID_SystemOutput :|sys |)
(defconstant $kAudioUnitID_GenericOutput :|genr|)
(defconstant $kAudioUnitSubType_MusicDevice :|musd|)
(defconstant $kAudioUnitID_DLSSynth :|dls |)
(defconstant $kAudioUnitSubType_SampleRateConverter :|srcv|)
(defconstant $kAudioUnitID_PolyphaseSRC :|poly|)
(defconstant $kAudioUnitSubType_FormatConverter :|fmtc|)
(defconstant $kAudioUnitID_Interleaver :|inlv|)
(defconstant $kAudioUnitID_Deinterleaver :|dnlv|)
(defconstant $kAudioUnitID_AUConverter :|conv|)
(defconstant $kAudioUnitSubType_Effect :|efct|)
(defconstant $kAudioUnitID_MatrixReverb :|mrev|)
(defconstant $kAudioUnitID_Delay :|dely|)
(defconstant $kAudioUnitID_LowPassFilter :|lpas|)
(defconstant $kAudioUnitID_HighPassFilter :|hpas|)
(defconstant $kAudioUnitID_BandPassFilter :|bpas|)
(defconstant $kAudioUnitID_PeakLimiter :|lmtr|)
(defconstant $kAudioUnitID_DynamicsProcessor :|dcmp|)
(defconstant $kAudioUnitSubType_Mixer :|mixr|)
(defconstant $kAudioUnitID_StereoMixer :|smxr|)
(defconstant $kAudioUnitID_3DMixer :|3dmx|)

(def-mactype :AudioUnitRenderCallback (find-mactype ':pointer)); (void * inRefCon , AudioUnitRenderActionFlags inActionFlags , const AudioTimeStamp * inTimeStamp , UInt32 inBusNumber , AudioBuffer * ioData)

(deftrap-inline "_AudioUnitSetRenderNotification" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inProc :pointer)
    (inProcRefCon :pointer)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0008 #\, 0x000C #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioUnitRemoveRenderNotification" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inProc :pointer)
    (inProcRefCon :pointer)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0008 #\, 0x000D #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioUnitRenderSlice" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inActionFlags :UInt32)
    (inTimeStamp (:pointer :AudioTimeStamp))
    (inOutputBusNumber :UInt32)
    (ioData (:pointer :AudioBuffer))
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0010 #\, 0x0008 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )
;  UPP call backs 
;  selectors for component calls 

(defconstant $kAudioUnitSetRenderNotificationSelect 12)
(defconstant $kAudioUnitRemoveRenderNotificationSelect 13)
(defconstant $kAudioUnitRenderSliceSelect 8)

(def-mactype :AudioUnitRenderSliceProc (find-mactype ':pointer)); (void * inComponentStorage , AudioUnitRenderActionFlags inActionFlags , const AudioTimeStamp * inTimeStamp , UInt32 inOutputBusNumber , AudioBuffer * ioData)
; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;     These are the properties that are unique to V1 'aunt' type AudioUnits
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
;  This defines a callback function which renders audio into an input of an AudioUnit
(defrecord AudioUnitInputCallback
   (inputProc :pointer)
   (inputProcRefCon :pointer)
)

;type name? (%define-record :AudioUnitInputCallback (find-record-descriptor ':AudioUnitInputCallback))

(defconstant $kAudioUnitProperty_SetInputCallback 7)

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

; #endif /* __AUNTCOMPONENT__ */


(provide-interface "AUNTComponent")