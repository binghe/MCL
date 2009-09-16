(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:MusicDevice.h"
; at Sunday July 2,2006 7:26:54 pm.
; 
;      File:       MusicDevice.h
;  
;      Contains:   MusicDevice Interfaces
;  
;      Version:    Mac OS X
;  
;      Copyright:  © 2000-2002 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __MUSICDEVICE__
; #define __MUSICDEVICE__

(require-interface "CoreServices/CoreServices")

(require-interface "AudioUnit/AUComponent")

(require-interface "CoreAudio/CoreAudio")

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
;    A music device can control far more independent instruments than the 16 channels of MIDI
;    through the use of the extended APIs. AudioUnitSetParameter is used with the kAudioUnitScope_Group
;    to use this extended control facilities. See documentation for further details.
; 
; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    ranges
; 

(defconstant $kMusicDeviceRange #x100)
; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    MusicDevice types and structures
; 

(def-mactype :MusicDeviceInstrumentID (find-mactype ':UInt32))
;  this is normally used for packing in MIDI note params (note number, velocity)
(defrecord MusicDeviceStdNoteParams
   (argCount :UInt32)                           ;  should be 2
   (mPitch :single-float)
   (mVelocity :single-float)
)

;type name? (%define-record :MusicDeviceStdNoteParams (find-record-descriptor ':MusicDeviceStdNoteParams))
(defrecord NoteParamsControlValue
   (mID :UInt32)
   (mValue :single-float)
)

;type name? (%define-record :NoteParamsControlValue (find-record-descriptor ':NoteParamsControlValue))
; 
;    This is the official structure that should be used as the
;    const MusicDeviceNoteParams  *inParams
;    argument with MusicDeviceStartNote
; 
; 
;    This argument has 2 flavours
;    (1) MusicDeviceStdNoteParams
;     - where argCount is 2, and the first argument is pitch (defined as 0 < 128 MIDI NoteNum), 
;     the second velocity (0 < 128)
; 
; 
;    (2) ExtendedNoteParams
;     - where argCount is 2 + the number of contained NoteParamsControlValue structures
;    - so the size of the mControls array is (argCount - 2)
; 
(defrecord MusicDeviceNoteParams
   (argCount :UInt32)
   (mPitch :single-float)
   (mVelocity :single-float)
   (mControls (:array :NoteParamsControlValue 1)); arbitrary lengh
)

;type name? (%define-record :MusicDeviceNoteParams (find-record-descriptor ':MusicDeviceNoteParams))
; 
;    The instrumentID that is passed in to the MusicDeviceStartNote can specify a specific intrument ID.
;    The constant kMusicNoteEvent_UseGroupInstrument can alternatively be passed to use the 
;    current instrument defined for that group. In MIDI this is the typical usage of a bank
;    and patch set for a specific channel where all notes that start on that channel use that instrument.
; 

(defconstant $kMusicNoteEvent_UseGroupInstrument #xFFFFFFFF)

(def-mactype :MusicDeviceGroupID (find-mactype ':UInt32))

(def-mactype :NoteInstanceID (find-mactype ':UInt32))

(def-mactype :MusicDeviceComponent (find-mactype ':ComponentInstance))

(deftrap-inline "_MusicDeviceMIDIEvent" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inStatus :UInt32)
    (inData1 :UInt32)
    (inData2 :UInt32)
    (inOffsetSampleFrame :UInt32)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0010 #\, 0x0101 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_MusicDeviceSysEx" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inData (:pointer :UInt8))
    (inLength :UInt32)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0008 #\, 0x0102 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_MusicDevicePrepareInstrument" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inInstrument :UInt32)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0004 #\, 0x0103 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_MusicDeviceReleaseInstrument" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inInstrument :UInt32)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0004 #\, 0x0104 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_MusicDeviceStartNote" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inInstrument :UInt32)
    (inGroupID :UInt32)
    (outNoteInstanceID (:pointer :NOTEINSTANCEID))
    (inOffsetSampleFrame :UInt32)
    (inParams (:pointer :MusicDeviceNoteParams))
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x0014 #\, 0x0105 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )

(deftrap-inline "_MusicDeviceStopNote" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inGroupID :UInt32)
    (inNoteInstanceID :UInt32)
    (inOffsetSampleFrame :UInt32)
   )                                            ; FIVEWORDINLINE
#|
 confused about ( 0x2F3C #\, 0x000C #\, 0x0106 #\, 0x7000 #\, 0xA82A #\)
|#
   :signed-long
() )
;  UPP call backs 
;  selectors for component calls 

(defconstant $kMusicDeviceMIDIEventSelect #x101)
(defconstant $kMusicDeviceSysExSelect #x102)
(defconstant $kMusicDevicePrepareInstrumentSelect #x103)
(defconstant $kMusicDeviceReleaseInstrumentSelect #x104)
(defconstant $kMusicDeviceStartNoteSelect #x105)
(defconstant $kMusicDeviceStopNoteSelect #x106)

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

; #endif /* __MUSICDEVICE__ */


(provide-interface "MusicDevice")