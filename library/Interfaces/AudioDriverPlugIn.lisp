(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AudioDriverPlugIn.h"
; at Sunday July 2,2006 7:26:58 pm.
; 
;      File:       CoreAudio/AudioDriverPlugIn.h
; 
;      Contains:   API for the CFBundle an IOAudio driver can specify for the HAL to use
;                  to provide implemenation for device specific properties.
; 
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
; 
;      Copyright:  (c) 1985-2003 by Apple Computer, Inc., all rights reserved.
; 
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
; 
;                      http://developer.apple.com/bugreporter/
; 
; 

; #if !defined(__AudioDriverPlugIn_h__)
; #define __AudioDriverPlugIn_h__
; =============================================================================
; 	Includes
; =============================================================================

(require-interface "CoreAudio/AudioHardware")

(require-interface "IOKit/IOKitLib")

; #if PRAGMA_ENUM_ALWAYSINT
#| ; #pragma enumsalwaysint off
 |#

; #endif


; #if defined(__cplusplus)
#|
extern "C"
{
#endif
|#
; =============================================================================
; 	Theory of Operation
; 
; 	IOAudio family drivers can specify a CFBundle in order to implement device
; 	specific properties on behalf of the HAL. The CFBundle provides routines
; 	for opening and closing the device as well as the property management
; 	routines. The mechanism by which the driver specifies which CFBundle
; 	to load is defined by the IOAudio driver family in IOKit. The following
; 	routines are loaded by name from the CFBundle.
; =============================================================================
; =============================================================================
; 	Types
; =============================================================================
; -----------------------------------------------------------------------------
; 	AudioDriverPlugInDevicePropertyChangedProc
; 
; 	A plug-in calls this routine to notify the HAL's implementation that
; 	one of it's device's properties has changed. From there, the HAL will notify
; 	the client listeners. The address of the specific routine is supplied
; 	to the plug-in when it is opened.
; -----------------------------------------------------------------------------

(def-mactype :AudioDriverPlugInDevicePropertyChangedProc (find-mactype ':pointer)); (AudioDeviceID inDevice , UInt32 inChannel , Boolean isInput , AudioDevicePropertyID inPropertyID)
; -----------------------------------------------------------------------------
; 	AudioDriverPlugInDevicePropertyChangedProc
; 
; 	A plug-in calls this routine to notify the HAL's implementation that
; 	one of it's stream's properties has changed. From there, the HAL will notify
; 	the client listeners. The address of the specific routine is supplied
; 	to the plug-in when it is opened.
; -----------------------------------------------------------------------------

(def-mactype :AudioDriverPlugInStreamPropertyChangedProc (find-mactype ':pointer)); (AudioDeviceID inDevice , io_object_t inIOAudioStream , UInt32 inChannel , AudioDevicePropertyID inPropertyID)
; -----------------------------------------------------------------------------
; 	AudioDriverPlugInHostInfo
; 
; 	This structure provides the plug-in with all the info it needs
; 	with respect to communicating with the HAL's implementation.
; -----------------------------------------------------------------------------
(defrecord AudioDriverPlugInHostInfo
   (mDeviceID :UInt32)
   (mIOAudioDevice :pointer)
   (mIOAudioEngine :pointer)
   (mDevicePropertyChangedProc :pointer)
   (mStreamPropertyChangedProc :pointer)
)

;type name? (%define-record :AudioDriverPlugInHostInfo (find-record-descriptor ':AudioDriverPlugInHostInfo))
; =============================================================================
; 	Life Cycle Management
; =============================================================================

(deftrap-inline "_AudioDriverPlugInOpen" 
   ((inHostInfo (:pointer :AudioDriverPlugInHostInfo))
   )
   :OSStatus
() )

(deftrap-inline "_AudioDriverPlugInClose" 
   ((inDevice :UInt32)
   )
   :OSStatus
() )
; =============================================================================
; 	Property Management
; 
; 	Accessing all the properties of a device requires specific knowledge
; 	of how the device works. Therefore, it is necessary to provide a
; 	mechanism for the driver to implement those properties through the HAL.
; 	
; 	The following routines all correspond to the semantics described for
; 	their companion routines in CoreAudio/AudioHardware.h.
; =============================================================================

(deftrap-inline "_AudioDriverPlugInDeviceGetPropertyInfo" 
   ((inDevice :UInt32)
    (inChannel :UInt32)
    (isInput :Boolean)
    (inPropertyID :UInt32)
    (outSize (:pointer :UInt32))
    (outWritable (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_AudioDriverPlugInDeviceGetProperty" 
   ((inDevice :UInt32)
    (inChannel :UInt32)
    (isInput :Boolean)
    (inPropertyID :UInt32)
    (ioPropertyDataSize (:pointer :UInt32))
    (outPropertyData :pointer)
   )
   :OSStatus
() )

(deftrap-inline "_AudioDriverPlugInDeviceSetProperty" 
   ((inDevice :UInt32)
    (inWhen (:pointer :AudioTimeStamp))
    (inChannel :UInt32)
    (isInput :Boolean)
    (inPropertyID :UInt32)
    (inPropertyDataSize :UInt32)
    (inPropertyData :pointer)
   )
   :OSStatus
() )

(deftrap-inline "_AudioDriverPlugInStreamGetPropertyInfo" 
   ((inDevice :UInt32)
    (inIOAudioStream :pointer)
    (inChannel :UInt32)
    (inPropertyID :UInt32)
    (outSize (:pointer :UInt32))
    (outWritable (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_AudioDriverPlugInStreamGetProperty" 
   ((inDevice :UInt32)
    (inIOAudioStream :pointer)
    (inChannel :UInt32)
    (inPropertyID :UInt32)
    (ioPropertyDataSize (:pointer :UInt32))
    (outPropertyData :pointer)
   )
   :OSStatus
() )

(deftrap-inline "_AudioDriverPlugInStreamSetProperty" 
   ((inDevice :UInt32)
    (inIOAudioStream :pointer)
    (inWhen (:pointer :AudioTimeStamp))
    (inChannel :UInt32)
    (inPropertyID :UInt32)
    (inPropertyDataSize :UInt32)
    (inPropertyData :pointer)
   )
   :OSStatus
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #if PRAGMA_ENUM_ALWAYSINT
#| ; #pragma enumsalwaysint reset
 |#

; #endif


; #endif


(provide-interface "AudioDriverPlugIn")