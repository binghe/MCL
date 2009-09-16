(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AUComponent.h"
; at Sunday July 2,2006 7:26:52 pm.
; 
;      File:       AUComponent.h
;  
;      Contains:   AudioUnit Interfaces
;  
;      Version:    Mac OS X
;  
;      Copyright:  © 2002 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AUCOMPONENT__
; #define __AUCOMPONENT__

(require-interface "CoreServices/CoreServices")

(require-interface "CoreAudio/CoreAudioTypes")

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
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    ranges
; 

(defconstant $kAudioUnitRange 0)
; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    AudioUnit stuff
; 

(def-mactype :AudioUnit (find-mactype ':ComponentInstance))
; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    AudioUnit component types and subtypes
; 

(defconstant $kAudioUnitType_Output :|auou|)
(defconstant $kAudioUnitSubType_HALOutput :|ahal|)
(defconstant $kAudioUnitSubType_DefaultOutput :|def |)
(defconstant $kAudioUnitSubType_SystemOutput :|sys |)
(defconstant $kAudioUnitSubType_GenericOutput :|genr|)
(defconstant $kAudioUnitType_MusicDevice :|aumu|)
(defconstant $kAudioUnitSubType_DLSSynth :|dls |)
(defconstant $kAudioUnitType_MusicEffect :|aumf|)
(defconstant $kAudioUnitType_FormatConverter :|aufc|)
(defconstant $kAudioUnitSubType_AUConverter :|conv|)
(defconstant $kAudioUnitSubType_Varispeed :|vari|)
(defconstant $kAudioUnitType_Effect :|aufx|)
(defconstant $kAudioUnitSubType_Delay :|dely|)
(defconstant $kAudioUnitSubType_LowPassFilter :|lpas|)
(defconstant $kAudioUnitSubType_HighPassFilter :|hpas|)
(defconstant $kAudioUnitSubType_BandPassFilter :|bpas|)
(defconstant $kAudioUnitSubType_HighShelfFilter :|hshf|)
(defconstant $kAudioUnitSubType_LowShelfFilter :|lshf|)
(defconstant $kAudioUnitSubType_ParametricEQ :|pmeq|)
(defconstant $kAudioUnitSubType_GraphicEQ :|greq|)
(defconstant $kAudioUnitSubType_PeakLimiter :|lmtr|)
(defconstant $kAudioUnitSubType_DynamicsProcessor :|dcmp|)
(defconstant $kAudioUnitSubType_MultiBandCompressor :|mcmp|)
(defconstant $kAudioUnitSubType_MatrixReverb :|mrev|)
(defconstant $kAudioUnitType_Mixer :|aumx|)
(defconstant $kAudioUnitSubType_StereoMixer :|smxr|)
(defconstant $kAudioUnitSubType_3DMixer :|3dmx|)
(defconstant $kAudioUnitSubType_MatrixMixer :|mxmx|)
(defconstant $kAudioUnitType_Panner :|aupn|)
(defconstant $kAudioUnitType_OfflineEffect :|auol|)
(defconstant $kAudioUnitManufacturer_Apple :|appl|)
; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    Render flags
; 
;  these are obsolete, were never implemented:
;     kAudioUnitRenderAction_Accumulate         = (1 << 0),
;     kAudioUnitRenderAction_UseProvidedBuffer   = (1 << 1),

(defconstant $kAudioUnitRenderAction_PreRender 4)
(defconstant $kAudioUnitRenderAction_PostRender 8)
(defconstant $kAudioUnitRenderAction_OutputIsSilence 16);  provides hint on return from Render(): if set the buffer contains all zeroes

(defconstant $kAudioOfflineUnitRenderAction_Preflight 32)
(defconstant $kAudioOfflineUnitRenderAction_Render 64)
(defconstant $kAudioOfflineUnitRenderAction_Complete #x80)

(def-mactype :AudioUnitRenderActionFlags (find-mactype ':UInt32))
; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    Errors
; 

(defconstant $kAudioUnitErr_InvalidProperty -10879)
(defconstant $kAudioUnitErr_InvalidParameter -10878)
(defconstant $kAudioUnitErr_InvalidElement -10877)
(defconstant $kAudioUnitErr_NoConnection -10876)
(defconstant $kAudioUnitErr_FailedInitialization -10875)
(defconstant $kAudioUnitErr_TooManyFramesToProcess -10874)
(defconstant $kAudioUnitErr_IllegalInstrument -10873)
(defconstant $kAudioUnitErr_InstrumentTypeNotFound -10872)
(defconstant $kAudioUnitErr_InvalidFile -10871)
(defconstant $kAudioUnitErr_UnknownFileType -10870)
(defconstant $kAudioUnitErr_FileNotSpecified -10869)
(defconstant $kAudioUnitErr_FormatNotSupported -10868)
(defconstant $kAudioUnitErr_Uninitialized -10867)
(defconstant $kAudioUnitErr_InvalidScope -10866)
(defconstant $kAudioUnitErr_PropertyNotWritable -10865)
(defconstant $kAudioUnitErr_InvalidPropertyValue -10851)
(defconstant $kAudioUnitErr_PropertyNotInUse -10850)
(defconstant $kAudioUnitErr_Initialized -10849) ; returned if the operation cannot be performed because the AU is initialized

(defconstant $kAudioUnitErr_InvalidOfflineRender -10848)
(defconstant $kAudioUnitErr_Unauthorized -10847)
; 
;    same error code but different calling context
;    as kAUGraphErr_CannotDoInCurrentContext  
; 

(defconstant $kAudioUnitErr_CannotDoInCurrentContext -10863)
; 
;    Special note:
;    A value of 0xFFFFFFFF should never be used for a real scope, paramID or element
;    as this value is reserved for use with the AUParameterListener APIs to do wild card searches
;    Apple reserves the range of 0->1024 for Specifying Scopes..., any custom scope values should
;    lie outside of this range.
; 

(def-mactype :AudioUnitPropertyID (find-mactype ':UInt32))

(def-mactype :AudioUnitParameterID (find-mactype ':UInt32))

(def-mactype :AudioUnitScope (find-mactype ':UInt32))

(def-mactype :AudioUnitElement (find-mactype ':UInt32))
; 
;    these are actually not used in the AudioUnit framework, but are used by AudioUnit/AudioUnitCarbonView
;    and AudioToolbox/AudioUnitUtilities.
; 
(defrecord AudioUnitParameter
   (mAudioUnit (:pointer :ComponentInstanceRecord))
   (mParameterID :UInt32)
   (mScope :UInt32)
   (mElement :UInt32)
)

;type name? (%define-record :AudioUnitParameter (find-record-descriptor ':AudioUnitParameter))
(defrecord AudioUnitProperty
   (mAudioUnit (:pointer :ComponentInstanceRecord))
   (mPropertyID :UInt32)
   (mScope :UInt32)
   (mElement :UInt32)
)

;type name? (%define-record :AudioUnitProperty (find-record-descriptor ':AudioUnitProperty))

(def-mactype :AURenderCallback (find-mactype ':pointer)); (void * inRefCon , AudioUnitRenderActionFlags * ioActionFlags , const AudioTimeStamp * inTimeStamp , UInt32 inBusNumber , UInt32 inNumberFrames , AudioBufferList * ioData)

(def-mactype :AudioUnitPropertyListenerProc (find-mactype ':pointer)); (void * inRefCon , AudioUnit ci , AudioUnitPropertyID inID , AudioUnitScope inScope , AudioUnitElement inElement)

(deftrap-inline "_AudioUnitInitialize" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0000 #\, 0x0001 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioUnitUninitialize" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0000 #\, 0x0002 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioUnitGetPropertyInfo" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inID :UInt32)
    (inScope :UInt32)
    (inElement :UInt32)
    (outDataSize (:pointer :UInt32))
    (outWritable (:pointer :Boolean))
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0014 #\, 0x0003 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )
; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    can pass in NULL for outData, to determine how much memory to allocate
;    for variable size properties...
;    ioDataSize must be a pointer to a UInt32 value containing the size of the expected
;    result.  Upon return this value will contain the real size copied.
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 

(deftrap-inline "_AudioUnitGetProperty" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inID :UInt32)
    (inScope :UInt32)
    (inElement :UInt32)
    (outData :pointer)
    (ioDataSize (:pointer :UInt32))
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0014 #\, 0x0004 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioUnitSetProperty" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inID :UInt32)
    (inScope :UInt32)
    (inElement :UInt32)
    (inData :pointer)
    (inDataSize :UInt32)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0014 #\, 0x0005 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioUnitAddPropertyListener" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inID :UInt32)
    (inProc :pointer)
    (inProcRefCon :pointer)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x000C #\, 0x000A #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioUnitRemovePropertyListener" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inID :UInt32)
    (inProc :pointer)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0008 #\, 0x000B #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioUnitAddRenderNotify" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inProc :pointer)
    (inProcRefCon :pointer)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0008 #\, 0x000F #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioUnitRemoveRenderNotify" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inProc :pointer)
    (inProcRefCon :pointer)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0008 #\, 0x0010 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioUnitGetParameter" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inID :UInt32)
    (inScope :UInt32)
    (inElement :UInt32)
    (outValue (:pointer :Float32))
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0010 #\, 0x0006 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioUnitSetParameter" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inID :UInt32)
    (inScope :UInt32)
    (inElement :UInt32)
    (inValue :single-float)
    (inBufferOffsetInFrames :UInt32)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0014 #\, 0x0007 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(defconstant $kParameterEvent_Immediate 1)
(defconstant $kParameterEvent_Ramped 2)

(def-mactype :AUParameterEventType (find-mactype ':UInt32))
(defrecord AudioUnitParameterEvent
   (scope :UInt32)
   (element :UInt32)
   (parameter :UInt32)
   (eventType :UInt32)
   (:variant
   (
   (startBufferOffset :SInt32)
   (durationInFrames :UInt32)
   (startValue :single-float)
   (endValue :single-float)
   )
   (
   (bufferOffset :UInt32)
   (value :single-float)
   )
   )
)

;type name? (%define-record :AudioUnitParameterEvent (find-record-descriptor ':AudioUnitParameterEvent))

(deftrap-inline "_AudioUnitScheduleParameters" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inParameterEvent (:pointer :AudioUnitParameterEvent))
    (inNumParamEvents :UInt32)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0008 #\, 0x0011 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioUnitRender" 
   ((ci (:pointer :ComponentInstanceRecord))
    (ioActionFlags (:pointer :AUDIOUNITRENDERACTIONFLAGS))
    (inTimeStamp (:pointer :AudioTimeStamp))
    (inOutputBusNumber :UInt32)
    (inNumberFrames :UInt32)
    (ioData (:pointer :AudioBufferList))
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0014 #\, 0x000E #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_AudioUnitReset" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inScope :UInt32)
    (inElement :UInt32)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0008 #\, 0x0009 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )
;  UPP call backs 
;  selectors for component calls 

(defconstant $kAudioUnitInitializeSelect 1)
(defconstant $kAudioUnitUninitializeSelect 2)
(defconstant $kAudioUnitGetPropertyInfoSelect 3)
(defconstant $kAudioUnitGetPropertySelect 4)
(defconstant $kAudioUnitSetPropertySelect 5)
(defconstant $kAudioUnitAddPropertyListenerSelect 10)
(defconstant $kAudioUnitRemovePropertyListenerSelect 11)
(defconstant $kAudioUnitAddRenderNotifySelect 15)
(defconstant $kAudioUnitRemoveRenderNotifySelect 16)
(defconstant $kAudioUnitGetParameterSelect 6)
(defconstant $kAudioUnitSetParameterSelect 7)
(defconstant $kAudioUnitScheduleParametersSelect 17)
(defconstant $kAudioUnitRenderSelect 14)
(defconstant $kAudioUnitResetSelect 9)
; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    Define some function pointers for the functions where performance is an issue.
;    Use the kAudioUnitProperty_FastDispatch property to get a function pointer
;    pointing directly to our implementation to avoid the cost of dispatching
;    through the Component Manager.
; 

(def-mactype :AudioUnitGetParameterProc (find-mactype ':pointer)); (void * inComponentStorage , AudioUnitParameterID inID , AudioUnitScope inScope , AudioUnitElement inElement , Float32 * outValue)

(def-mactype :AudioUnitSetParameterProc (find-mactype ':pointer)); (void * inComponentStorage , AudioUnitParameterID inID , AudioUnitScope inScope , AudioUnitElement inElement , Float32 inValue , UInt32 inBufferOffsetInFrames)

(def-mactype :AudioUnitRenderProc (find-mactype ':pointer)); (void * inComponentStorage , AudioUnitRenderActionFlags * ioActionFlags , const AudioTimeStamp * inTimeStamp , UInt32 inOutputBusNumber , UInt32 inNumberFrames , AudioBufferList * ioData)

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

; #endif /* __AUCOMPONENT__ */


(provide-interface "AUComponent")