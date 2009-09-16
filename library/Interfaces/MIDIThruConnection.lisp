(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:MIDIThruConnection.h"
; at Sunday July 2,2006 7:27:02 pm.
; 
;  	File:   	CoreMIDI/MIDIThruConnection.h
;  
;  	Contains:   Routines for creating MIDI play-through connections.
;  
;  	Version:	Technology: Mac OS X
;  				Release:	Mac OS X
;  
;  	Copyright:  (c) 2002 by Apple Computer, Inc., all rights reserved.
;  
;  	Bugs?:  	For bug reports, consult the following page on
;  				the World Wide Web:
;  
;  					http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __MIDIThruConnection_h__
; #define __MIDIThruConnection_h__

(require-interface "CoreFoundation/CoreFoundation")

(require-interface "CoreServices/CoreServices")

(require-interface "CoreMIDI/MIDIServices")
;   -----------------------------------------------------------------------------
; !
; 	@header MIDIThruConnection
; 
; 	This header defines functions to create MIDI play-through connections
; 	between the MIDI sources and destinations.  These connections may be
; 	persistent or transitory, owned by a client.
; 	
; 	By using connections instead of doing MIDI Thru operations themselves,
; 	the overhead of moving MIDI messages between the server and the client
; 	for thru-ing is reduced.
; 	
; 	The aim of these functions is to permit as flexible a set of transformations 
; 	as possible while keeping the API and data structures relatively simple.	
; 
;   -----------------------------------------------------------------------------
; !
; 	@typedef		MIDIThruConnectionRef
; 	
; 	@discussion		An opaque reference to a play-through connection.
; 

(def-mactype :MIDIThruConnectionRef (find-mactype '(:pointer :OpaqueMIDIThruConnection)))
; !
; 	@typedef		MIDIValueMap
; 	
; 	@discussion		A custom mapping function to transform MIDI 7-bit values,
; 					as contained in note numbers, velocities, control values,
; 					etc.  y = value[x], where x is the input MIDI value, y the
; 					output.
; 
(defrecord MIDIValueMap
   (value (:array :UInt8 128))
)

;type name? (%define-record :MIDIValueMap (find-record-descriptor ':MIDIValueMap))

(defconstant $kMIDITransform_None 0)            ;  no param

(defconstant $kMIDITransform_FilterOut 1)       ;  filter out event type, no param

(defconstant $kMIDITransform_MapControl 2)      ;  param is remapped control number

(defconstant $kMIDITransform_Add 8)             ;  param is value to add

(defconstant $kMIDITransform_Scale 9)           ;  param is amount to scale by: fixed point bbbb.bbbb bbbb bbbb

(defconstant $kMIDITransform_MinValue 10)
(defconstant $kMIDITransform_MaxValue 11)
(defconstant $kMIDITransform_MapValue 12)       ;  param is index of map in connection's map array


(defconstant $kMIDIThruConnection_MaxEndpoints 8)
;  control types
;  (implementation note: some code tests bits of these values)

(defconstant $kMIDIControlType_7Bit 0)          ;  control numbers may be 0-127

(defconstant $kMIDIControlType_14Bit 1)         ;  control numbers may be 0-31

(defconstant $kMIDIControlType_7BitRPN 2)       ;  control numbers may be 0-16383

(defconstant $kMIDIControlType_14BitRPN 3)
(defconstant $kMIDIControlType_7BitNRPN 4)
(defconstant $kMIDIControlType_14BitNRPN 5)
(defrecord MIDITransform
   (transform :UInt16)
   (param :SInt16)
)

;type name? (%define-record :MIDITransform (find-record-descriptor ':MIDITransform))
;  Note: must order control transforms appropriately -- first, filter out and remap.
;  Further transforms can follow, and will apply to the remapped control number (if any).
;  N.B. All transformations are done using 14-bit control values, so, when doing an add/min/max
;  transform on a 7-bit value, the parameter must be a 14-bit value, e.g. to add n, param
;  must be n << 7.
(defrecord MIDIControlTransform
   (controlType :UInt8)
   (remappedControlType :UInt8)
                                                ;  only used when transform is kMIDITransform_MapControl
   (controlNumber :UInt16)
   (transform :UInt16)
   (param :SInt16)
)

;type name? (%define-record :MIDIControlTransform (find-record-descriptor ':MIDIControlTransform))
;  When filling one of these out, clients can leave uniqueID 0 if the endpoint exists.
;  When when one is provided back to the client, the endpoint may be null if it doesn't
;  exist, but the uniqueID will always be non-zero.
(defrecord MIDIThruConnectionEndpoint
   (endpointRef (:pointer :OpaqueMIDIEndpoint))
   (uniqueID :SInt32)
)

;type name? (%define-record :MIDIThruConnectionEndpoint (find-record-descriptor ':MIDIThruConnectionEndpoint))
(defrecord MIDIThruConnectionParams
   (version :UInt32)
                                                ;  must be 0
   (numSources :UInt32)
   (sources (:array :MIDIThruConnectionEndpoint 8))
   (numDestinations :UInt32)
   (destinations (:array :MIDIThruConnectionEndpoint 8))
                                                ;  map each of the source 16 MIDI channels to channel 0-15 (1-16) or 0xFF to filter out
   (channelMap (:array :UInt8 16))
   (reserved1 (:array :UInt8 2))
                                                ;  must be 0
   (lowNote :UInt8)
   (highNote :UInt8)                            ;  ignored if mapping
                                                ;  if highNote < lowNote, then 0..highNote and lowNote..127
                                                ;  are passed
   (noteNumber :MIDITransform)
   (velocity :MIDITransform)
   (keyPressure :MIDITransform)
   (channelPressure :MIDITransform)
   (programChange :MIDITransform)
   (pitchBend :MIDITransform)
   (filterOutSysEx :UInt8)
   (filterOutMTC :UInt8)
   (filterOutBeatClock :UInt8)
   (filterOutTuneRequest :UInt8)
   (reserved2 (:array :UInt8 3))
                                                ;  must be 0
   (filterOutAllControls :UInt8)
   (numControlTransforms :UInt16)
   (numMaps :UInt16)
   (reserved3 (:array :UInt16 4))
                                                ;  must be 0
                                                ;  remainder of structure is variable-length:
                                                ; 		MIDIControlTransform	controls[];
                                                ; 		MIDIValueMap			maps[];
)

;type name? (%define-record :MIDIThruConnectionParams (find-record-descriptor ':MIDIThruConnectionParams))
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
;  Convenience function to fill the connection structure with default values:
;  no endpoints, no transformations (mostly zeroes except for the channel map).
;  Then just filling in the source and adding one destination will create a simple, 
;  unmodified thru connection.

(deftrap-inline "_MIDIThruConnectionParamsInitialize" 
   ((inConnectionParams (:pointer :MIDIThruConnectionParams))
   )
   nil
() )
;  if inPersistentOwnerID is null, then the connection is marked as owned by the client
;  and will be automatically disposed with the client.  if it is non-null, then it
;  should be a unique identifier, e.g. "com.mycompany.MyCoolProgram".

(deftrap-inline "_MIDIThruConnectionCreate" 
   ((inPersistentOwnerID (:pointer :__CFString))
    (inConnectionParams (:pointer :__CFData))
    (outConnection (:pointer :MIDITHRUCONNECTIONREF))
   )
   :OSStatus
() )

(deftrap-inline "_MIDIThruConnectionDispose" 
   ((connection (:pointer :OpaqueMIDIThruConnection))
   )
   :OSStatus
() )
;  The returned CFDataRef contains a MIDIThruConnectionParams structure; client is responsible
;  for releasing it.

(deftrap-inline "_MIDIThruConnectionGetParams" 
   ((connection (:pointer :OpaqueMIDIThruConnection))
    (outConnectionParams (:pointer :CFDataRef))
   )
   :OSStatus
() )
;  The supplied CFDataRef contains a MIDIThruConnectionParams structure; reference is not consumed.

(deftrap-inline "_MIDIThruConnectionSetParams" 
   ((connection (:pointer :OpaqueMIDIThruConnection))
    (inConnectionParams (:pointer :__CFData))
   )
   :OSStatus
() )
;  the returned CFDataRef is an array of MIDIThruConnectionRef's containing all of the 
;  connections created by the specified owner.

(deftrap-inline "_MIDIThruConnectionFind" 
   ((inPersistentOwnerID (:pointer :__CFString))
    (outConnectionList (:pointer :CFDataRef))
   )
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __MIDIThruConnection_h__ */


(provide-interface "MIDIThruConnection")