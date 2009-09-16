(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AudioUnitUtilities.h"
; at Sunday July 2,2006 7:27:00 pm.
; =============================================================================
; 	AudioUnitUtilities.h
; 		
; 	Copyright (c) 2002-2003 Apple Computer, Inc.  All Rights Reserved
; =============================================================================
;  Utilities for use of AudioUnit clients - higher-level functions.
; #ifndef __AudioUnitUtilities_h__
; #define __AudioUnitUtilities_h__

(require-interface "AudioUnit/AudioUnit")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
;  ============================================================================= 

(defconstant $kAUParameterListener_AnyParameter #xFFFFFFFF)

(def-mactype :AUParameterListenerRef (find-mactype '(:pointer :AUListenerBase)))
;  opaque
;  old-style listener, may not be passed to new functions

(def-mactype :AUEventListenerRef (find-mactype ':AUParameterListenerRef))
;  new-style listener, can be passed to both old and new functions

(def-mactype :AUParameterListenerProc (find-mactype ':pointer)); (void * inRefCon , void * inObject , const AudioUnitParameter * inParameter , Float32 inValue)
;  ============================================================================= 

(deftrap-inline "_AUListenerCreate" 
   ((inProc :pointer)
    (inRefCon :pointer)
    (inRunLoop (:pointer :__CFRunLoop))
    (inRunLoopMode (:pointer :__CFString))
    (inNotificationInterval :single-float)
    (outListener (:pointer :AUParameterListenerRef))
   )
   :OSStatus
() )

(deftrap-inline "_AUListenerDispose" 
   ((inListener (:pointer :AUListenerBase))
   )
   :OSStatus
() )

(deftrap-inline "_AUListenerAddParameter" 
   ((inListener (:pointer :AUListenerBase))
    (inObject :pointer)
    (inParameter (:pointer :AudioUnitParameter))
   )
   :OSStatus
() )

(deftrap-inline "_AUListenerRemoveParameter" 
   ((inListener (:pointer :AUListenerBase))
    (inObject :pointer)
    (inParameter (:pointer :AudioUnitParameter))
   )
   :OSStatus
() )

(deftrap-inline "_AUParameterSet" 
   ((inSendingListener (:pointer :AUListenerBase))
    (inSendingObject :pointer)
    (inParameter (:pointer :AudioUnitParameter))
    (inValue :single-float)
    (inBufferOffsetInFrames :UInt32)
   )
   :OSStatus
() )

(deftrap-inline "_AUParameterListenerNotify" 
   ((inSendingListener (:pointer :AUListenerBase))
    (inSendingObject :pointer)
    (inParameter (:pointer :AudioUnitParameter))
   )
   :OSStatus
() )
;  ============================================================================= 
; 
; 	The AUEventListener* API's extend the above AUParameterListener* API's above
; 	by adding the semantic of events other than parameter changes, which are
; 	delivered serially to the listener interspersed with parameter changes,
; 	preserving the time order of the events and parameter changes.
; 

(def-mactype :AudioUnitEventType (find-mactype ':UInt32))

(defconstant $kAudioUnitEvent_ParameterValueChange 0)
(defconstant $kAudioUnitEvent_BeginParameterChangeGesture 1)
(defconstant $kAudioUnitEvent_EndParameterChangeGesture 2)
(defconstant $kAudioUnitEvent_PropertyChange 3)
(defrecord AudioUnitEvent
   (mEventType :UInt32)
   (:variant
   (
   (mParameter :AudioUnitParameter)
   )
                                                ;  for parameter value change, begin and end gesture
   (
   (mProperty :AudioUnitProperty)
   )
                                                ;  for using this mechanism for property change notifications
   )
)

(def-mactype :AUEventListenerProc (find-mactype ':pointer)); (void * inCallbackRefCon , void * inObject , const AudioUnitEvent * inEvent , UInt64 inEventHostTime , Float32 inParameterValue)

(deftrap-inline "_AUEventListenerCreate" 
   ((inProc :pointer)
    (inCallbackRefCon :pointer)
    (inRunLoop (:pointer :__CFRunLoop))
    (inRunLoopMode (:pointer :__CFString))
    (inNotificationInterval :single-float)
                                                ;  seconds
    (inValueChangeGranularity :single-float)
                                                ;  seconds
    (outListener (:pointer :AUEVENTLISTENERREF))
   )
   :OSStatus
() )
;  use AUListenerDispose
;  may use AUListenerAddParameter and AUListenerRemoveParameter with AUEventListerRef's,
;  in addition to AUEventListenerAddEventType / AUEventListenerRemoveEventType
;  inNotificationInterval: this is the minimum time interval at which the receiving runloop will
; 		be woken up and the event listener proc called
;  inValueChangeGranularity: determines how parameter value changes occuring within this interval
; 		are queued; when an event follows a previous one by a smaller time interval than
; 		the granularity, then the listener will only be notified for the second parameter change.
;  Examples:
; 	[1] a UI receiver: inNotificationInterval 100 ms, inValueChangeGranularity 100 ms
; 		User interfaces almost never care about previous values, only the current one,
; 		and don't wish to perform redraws too often.
; 	[2] an automation recorder: inNotificationInterval 200 ms, inValueChangeGranularity 10 ms
; 		Automation systems typically wish to record events with a high degree of timing precision,
; 		but do not need to be woken up for each event.
;  In case [1], the listener will be called within 100 ms (the notification interval) of an event.
;  It will only receive one notification for any number of value 
;  changes to the parameter concerned, occurring within a 100 ms window (the granularity).
;  In case [2], the listener will be received within 200 ms (the notification interval) of an event
;  It can receive more than one notification per parameter,
;  for the last of each group of value changes occurring within a 10 ms window (the granularity).
;  In both cases, thread scheduling latencies may result in more events being delivered to the listener
;  callback than the theoretical maximum (notification interval / granularity).

(deftrap-inline "_AUEventListenerAddEventType" 
   ((inListener (:pointer :AUListenerBase))
    (inObject :pointer)
    (inEvent (:pointer :AUDIOUNITEVENT))
   )
   :OSStatus
() )
;  inEvent can specify creation of a listener for
; 		- a parameter change
; 		- a parameter change begin/end gesture
; 		- a property change
;  i.e., all types of AudioUnitEvents

(deftrap-inline "_AUEventListenerRemoveEventType" 
   ((inListener (:pointer :AUListenerBase))
    (inObject :pointer)
    (inEvent (:pointer :AUDIOUNITEVENT))
   )
   :OSStatus
() )

(deftrap-inline "_AUEventListenerNotify" 
   ((inSendingListener (:pointer :AUListenerBase))
    (inSendingObject :pointer)
    (inEvent (:pointer :AUDIOUNITEVENT))
   )
   :OSStatus
() )
;  ============================================================================= 

(deftrap-inline "_AUParameterValueFromLinear" 
   ((inLinearValue :single-float)
                                                ;  0-1
    (inParameter (:pointer :AudioUnitParameter))
   )
   :single-float
() )

(deftrap-inline "_AUParameterValueToLinear" 
   ((inParameterValue :single-float)
    (inParameter (:pointer :AudioUnitParameter))
   )
   :single-float
() )
;  returns 0-1

(deftrap-inline "_AUParameterFormatValue" 
   ((inParameterValue :double-float)
    (inParameter (:pointer :AudioUnitParameter))
    (inTextBuffer (:pointer :char))
    (inDigits :UInt32)
   )
   (:pointer :character)
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif


(provide-interface "AudioUnitUtilities")