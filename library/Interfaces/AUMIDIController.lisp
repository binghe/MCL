(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AUMIDIController.h"
; at Sunday July 2,2006 7:27:00 pm.
; =============================================================================
; 	AUMIDIController.h
; 	
; 	Copyright (c) 2002 Apple Computer, Inc.  All Rights Reserved
; =============================================================================
; #ifndef __AUMIDIController_h__
; #define __AUMIDIController_h__

(require-interface "AudioUnit/AudioUnit")

(require-interface "CoreMIDI/CoreMIDI")

(require-interface "AudioToolbox/AudioUnitUtilities")

(def-mactype :AUMIDIControllerRef (find-mactype '(:pointer :OpaqueAUMIDIController)))
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
; 	inVirtualDestinationName is null to create no virtual destination
; 

(deftrap-inline "_AUMIDIControllerCreate" 
   ((inVirtualDestinationName (:pointer :__CFString))
    (outController (:pointer :AUMIDICONTROLLERREF))
   )
   :OSStatus
() )

(deftrap-inline "_AUMIDIControllerDispose" 
   ((inController (:pointer :OpaqueAUMIDIController))
   )
   :OSStatus
() )

(deftrap-inline "_AUMIDIControllerMapChannelToAU" 
   ((inController (:pointer :OpaqueAUMIDIController))
    (inSourceMIDIChannel :SInt32)
    (inAudioUnit (:pointer :ComponentInstanceRecord))
    (inDestMIDIChannel :SInt32)
    (inCreateDefaultControlMappings :Boolean)
   )
   :OSStatus
() )

(deftrap-inline "_AUMIDIControllerMapEventToParameter" 
   ((inController (:pointer :OpaqueAUMIDIController))
    (inMIDIStatusByte :UInt8)
    (inMIDIControl :UInt16)
    (inParameter (:pointer :AudioUnitParameter))
   )
   :OSStatus
() )
;  this will remove any mapping held by this controller
;  to the specified audio unit - whether those are:
;  (1) default mappings (AUMIDIControllerMapChannelToAU) 
;  (2) custom mappings (AUMIDIControllerMapEventToParameter)
;  Typically, this is done when (and should be done) when an AU no longer
;  should receive MIDI events for its parameters (or the AU is being disposed)

(deftrap-inline "_AUMIDIControllerUnmapAudioUnit" 
   ((inController (:pointer :OpaqueAUMIDIController))
    (inAudioUnit (:pointer :ComponentInstanceRecord))
   )
   :OSStatus
() )
; 
; 	$$$ need description of timestamps in the packets (if any) are treated -- needs
; 	to factor in the AU's latency $$$
; 

(deftrap-inline "_AUMIDIControllerHandleMIDI" 
   ((inController (:pointer :OpaqueAUMIDIController))
    (inMIDIPacketList (:pointer :MIDIPACKETLIST))
   )
   :OSStatus
() )

(deftrap-inline "_AUMIDIControllerConnectSource" 
   ((inController (:pointer :OpaqueAUMIDIController))
    (inSource (:pointer :OpaqueMIDIEndpoint))
   )
   :OSStatus
() )

(deftrap-inline "_AUMIDIControllerDisconnectSource" 
   ((inController (:pointer :OpaqueAUMIDIController))
    (inSource (:pointer :OpaqueMIDIEndpoint))
   )
   :OSStatus
() )
; 
; 	Tells an AUMIDIController to generate an XML description of the control/NRPN 
; 	mapping.  Returns a (local file) URL to the file written.  $$$ If the AUMIDIController
; 	has a virtual destination associated with it, the AUMIDIController will
; 	call MIDIObjectSetNameConfiguration to publish those names as the current
; 	ones for that destination.
; 

(deftrap-inline "_AUMIDIControllerExportXMLNames" 
   ((inController (:pointer :OpaqueAUMIDIController))
    (outXMLFileURL (:pointer :CFURLRef))
   )
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif // __AUMIDIController_h__


(provide-interface "AUMIDIController")