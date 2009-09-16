(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AudioHardwarePlugIn.h"
; at Sunday July 2,2006 7:26:59 pm.
; 
;      File:       CoreAudio/AudioHardwarePlugIn.h
; 
;      Contains:   API for the CFPlugIn that implements an audio driver for the HAL
;                  from user space.
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

; #if !defined(__AudioHardwarePlugIn_h__)
; #define __AudioHardwarePlugIn_h__
; =============================================================================
; 	Includes
; =============================================================================

(require-interface "CoreAudio/AudioHardware")

(require-interface "CoreFoundation/CFPlugIn")

; #if COREFOUNDATION_CFPLUGINCOM_SEPARATE

(require-interface "CoreFoundation/CFPlugInCOM")

; #endif


(require-interface "CoreFoundation/CFRunLoop")

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
; 	Types
; =============================================================================

;type name? (def-mactype :AudioHardwarePlugInInterface (find-mactype ':AudioHardwarePlugInInterface))

(def-mactype :AudioHardwarePlugInRef (find-mactype '(:handle :AudioHardwarePlugInInterface)))
; =============================================================================
; 	Constants
; =============================================================================
; #define kAudioHardwarePlugInTypeID 	CFUUIDGetConstantUUIDWithBytes(NULL, 0xF8, 0xBB, 0x1C, 0x28, 0xBA, 0xE8, 0x11, 0xD6, 0x9C, 0x31, 0x00, 0x03, 0x93, 0x15, 0xCD, 0x46)
;  F8BB1C28-BAE8-11D6-9C31-00039315CD46 
; #define kAudioHardwarePlugInInterfaceID 	CFUUIDGetConstantUUIDWithBytes(NULL, 0xFA, 0xFC, 0xAF, 0xC3, 0xBA, 0xE8, 0x11, 0xD6, 0xB4, 0xA8, 0x00, 0x03, 0x93, 0x15, 0xCD, 0x46)
;  FAFCAFC3-BAE8-11D6-B4A8-00039315CD46 
; #define kAudioHardwarePlugInInterface2ID 	CFUUIDGetConstantUUIDWithBytes(NULL, 0x5D, 0x80, 0xCB, 0x6C, 0x48, 0x4F, 0x11, 0xD7, 0x85, 0x71, 0x00, 0x0A, 0x95, 0x77, 0x12, 0x82)
;  5D80CB6C-484F-11D7-8571-000A95771282 
; =============================================================================
; 	AudioHardwarePlugInInterface
; 
; 	This is the CFPlugIn interface presented by a HAL plug-in. The HAL will
; 	create only one instance of each interface. This instance is responsible
; 	for providing all required services on behalf of as many devices of the
; 	kind it implements.
; 
; 	The Initialize method is called to allow the plug-in to set itself up.
; 	At this time any devices of it's kind and their streams can be presented
; 	to the system using AudioHardwareDevicesCreated and AudioHardwareStreamsCreated.
; 	The plug-in is also responsible for managing it's own notifications, and
; 	may install any CFRunLoopSources it needs using AudioHardwaerAddRunLoopSource
; 	at this time as well.
; 
; 	Teardown is called when the HAL is unloading itself and the plug-in should
; 	dispose of any devices and streams it has created using AudioHardwareDevicesDied
; 	and AudioHardareStreamsDied.
; 
; 	The rest of the methods in this interface correspond to the semantics
; 	of their similarly named counterparts in <CoreAudio/AudioHardware.h>.
; 	The HAL basically passes these calls directly to the plug-in in this fashion.
; 
; 	Plug-ins do not have to manage device or stream property listener procs. Instead,
; 	a plug-in can call AudioHardwareDevicePropertyChanged or AudioHardwareStreamPropertyChanged
; 	and the HAL will take care of calling all the appropriate listeners.
; =============================================================================
(defrecord AudioHardwarePlugInInterface
                                                ; 	IUnknown stuff
#|
   (NIL :iunknown_c_guts)|#
                                                ; 	Construction/Destruction
   (Initialize (:pointer :callback))            ;(OSStatus (AudioHardwarePlugInRef inSelf))
   (Teardown (:pointer :callback))              ;(OSStatus (AudioHardwarePlugInRef inSelf))
                                                ; 	IO Management
   (DeviceAddIOProc (:pointer :callback))       ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioDeviceID inDevice , AudioDeviceIOProc inProc , void * inClientData))
   (DeviceRemoveIOProc (:pointer :callback))    ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioDeviceID inDevice , AudioDeviceIOProc inProc))
   (DeviceStart (:pointer :callback))           ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioDeviceID inDevice , AudioDeviceIOProc inProc))
   (DeviceStop (:pointer :callback))            ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioDeviceID inDevice , AudioDeviceIOProc inProc))
   (DeviceRead (:pointer :callback))            ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioDeviceID inDevice , const AudioTimeStamp * inStartTime , AudioBufferList * outData))
                                                ; 	Time Management
   (DeviceGetCurrentTime (:pointer :callback))  ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioDeviceID inDevice , AudioTimeStamp * outTime))
   (DeviceTranslateTime (:pointer :callback))   ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioDeviceID inDevice , const AudioTimeStamp * inTime , AudioTimeStamp * outTime))
                                                ; 	Device Property Management
   (DeviceGetPropertyInfo (:pointer :callback)) ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioDeviceID inDevice , UInt32 inChannel , Boolean isInput , AudioDevicePropertyID inPropertyID , UInt32 * outSize , Boolean * outWritable))
   (DeviceGetProperty (:pointer :callback))     ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioDeviceID inDevice , UInt32 inChannel , Boolean isInput , AudioDevicePropertyID inPropertyID , UInt32 * ioPropertyDataSize , void * outPropertyData))
   (DeviceSetProperty (:pointer :callback))     ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioDeviceID inDevice , const AudioTimeStamp * inWhen , UInt32 inChannel , Boolean isInput , AudioDevicePropertyID inPropertyID , UInt32 inPropertyDataSize , const void * inPropertyData))
                                                ; 	Stream Property Management
   (StreamGetPropertyInfo (:pointer :callback)) ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioStreamID inStream , UInt32 inChannel , AudioDevicePropertyID inPropertyID , UInt32 * outSize , Boolean * outWritable))
   (StreamGetProperty (:pointer :callback))     ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioStreamID inStream , UInt32 inChannel , AudioDevicePropertyID inPropertyID , UInt32 * ioPropertyDataSize , void * outPropertyData))
   (StreamSetProperty (:pointer :callback))     ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioStreamID inStream , const AudioTimeStamp * inWhen , UInt32 inChannel , AudioDevicePropertyID inPropertyID , UInt32 inPropertyDataSize , const void * inPropertyData))
                                                ; 	Version 2 Methods
   (DeviceStartAtTime (:pointer :callback))     ;(OSStatus (AudioHardwarePlugInRef inSelf , AudioDeviceID inDevice , AudioDeviceIOProc inProc , AudioTimeStamp * ioRequestedStartTime , UInt32 inFlags))
   (DeviceGetNearestStartTime (:pointer :callback));(OSStatus (AudioHardwarePlugInRef inSelf , AudioDeviceID inDevice , AudioTimeStamp * ioRequestedStartTime , UInt32 inFlags))
)

(defconstant $kAudioHardwarePropertyProcessIsMaster :|mast|); 	A UInt32 where 1 means this process contains the master
; 	instance of the HAL. The master instance of the HAL is
; 	the only instance in which the plug-ins should restore their
; 	device's settings when the device is first presented to
; 	the system. 

; =============================================================================
; 	Plug-In Support Routines
; 	
; 	These are routines that plug-ins have to call in order to interface
; 	with the HAL properly.
; =============================================================================

(deftrap-inline "_AudioHardwareAddRunLoopSource" 
   ((inRunLoopSource (:pointer :__CFRunLoopSource))
   )
   :OSStatus
() )

(deftrap-inline "_AudioHardwareRemoveRunLoopSource" 
   ((inRunLoopSource (:pointer :__CFRunLoopSource))
   )
   :OSStatus
() )

(deftrap-inline "_AudioHardwareClaimAudioDeviceID" 
   ((inOwner (:Handle :AUDIOHARDWAREPLUGININTERFACE))
    (outAudioDeviceID (:pointer :AUDIODEVICEID))
   )
   :OSStatus
() )

(deftrap-inline "_AudioHardwareDevicesCreated" 
   ((inOwner (:Handle :AUDIOHARDWAREPLUGININTERFACE))
    (inNumberDevices :UInt32)
    (inAudioDeviceIDs (:pointer :AUDIODEVICEID))
   )
   :OSStatus
() )

(deftrap-inline "_AudioHardwareDevicesDied" 
   ((inOwner (:Handle :AUDIOHARDWAREPLUGININTERFACE))
    (inNumberDevices :UInt32)
    (inAudioDeviceIDs (:pointer :AUDIODEVICEID))
   )
   :OSStatus
() )

(deftrap-inline "_AudioHardwareDevicePropertyChanged" 
   ((inOwner (:Handle :AUDIOHARDWAREPLUGININTERFACE))
    (inDeviceID :UInt32)
    (inChannel :UInt32)
    (isInput :Boolean)
    (inPropertyID :UInt32)
   )
   :OSStatus
() )

(deftrap-inline "_AudioHardwareClaimAudioStreamID" 
   ((inOwner (:Handle :AUDIOHARDWAREPLUGININTERFACE))
    (inOwningDeviceID :UInt32)
    (outAudioStreamID (:pointer :AUDIOSTREAMID))
   )
   :OSStatus
() )

(deftrap-inline "_AudioHardwareStreamsCreated" 
   ((inOwner (:Handle :AUDIOHARDWAREPLUGININTERFACE))
    (inOwningDeviceID :UInt32)
    (inNumberStreams :UInt32)
    (inAudioStreamIDs (:pointer :AUDIOSTREAMID))
   )
   :OSStatus
() )

(deftrap-inline "_AudioHardwareStreamsDied" 
   ((inOwner (:Handle :AUDIOHARDWAREPLUGININTERFACE))
    (inOwningDeviceID :UInt32)
    (inNumberStreams :UInt32)
    (inAudioStreamIDs (:pointer :AUDIOSTREAMID))
   )
   :OSStatus
() )

(deftrap-inline "_AudioHardwareStreamPropertyChanged" 
   ((inOwner (:Handle :AUDIOHARDWAREPLUGININTERFACE))
    (inOwningDeviceID :UInt32)
    (inStreamID :UInt32)
    (inChannel :UInt32)
    (inPropertyID :UInt32)
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


(provide-interface "AudioHardwarePlugIn")