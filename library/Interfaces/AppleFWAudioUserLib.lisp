(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AppleFWAudioUserLib.h"
; at Sunday July 2,2006 7:25:40 pm.
; --------------------------------------------------------------------------------
; 
; 	File:		AppleFWAudioUserLib.h
; 
; 	Contains:	User lib for FireWire 61883 (Audio Sub Unit, Music Sub Unit,mLAN) Audio devices.
; 
; 	Technology:	OS X
; 
; 	DRI:		Matthew Xavier Mora	mxmora@apple.com
; 	ALTERNATE:	laupmanis
; 
; --------------------------------------------------------------------------------

(require-interface "Carbon/Carbon")

(require-interface "IOKit/firewire/IOFireWireFamilyCommon")

(require-interface "FWAUserLib/AppleFWAudioUserClientCommon")

(def-mactype :FWARef (find-mactype '(:pointer :OpaqueRef)))

; #if __cplusplus
#| 
; Gag EXTERN "C"  {
 |#

; #endif

;  Device identification

(def-mactype :FWADeviceID (find-mactype ':UInt32))
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  API

(deftrap-inline "_FWACountDevices" 
   ((deviceNodeIDArray (:pointer :UInt16))
    (deviceCount (:pointer :UInt16))
   )
   :SInt32
() )

(deftrap-inline "_FWAOpen" 
   ((nodeID :UInt32)
    (outRef (:pointer :FWAREF))
   )
   :SInt32
() )

(deftrap-inline "_FWAClose" 
   ((inRef (:pointer :OpaqueRef))
   )
   :SInt32
() )

(deftrap-inline "_FWARead" 
   ((inRef (:pointer :OpaqueRef))
    (inAddress :UInt8)
    (inSubAddress :UInt8)
    (inDataSize :UInt32)
    (inDataPtr :pointer)
   )
   :SInt32
() )

(deftrap-inline "_FWAWrite" 
   ((inRef (:pointer :OpaqueRef))
    (inAddress :UInt8)
    (inSubAddress :UInt8)
    (inDataSize :UInt32)
    (inDataPtr :pointer)
   )
   :SInt32
() )
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  mLan support

(deftrap-inline "_FWAGetNodeID" 
   ((inRef (:pointer :OpaqueRef))
    (outNodeID (:pointer :UInt32))
    (outGeneration (:pointer :UInt32))
   )
   :SInt32
() )

(deftrap-inline "_FWAGetGUID" 
   ((inRef (:pointer :OpaqueRef))
    (guid (:pointer :UInt64))
   )
   :SInt32
() )

(deftrap-inline "_FWAGetMacGUID" 
   ((inRef (:pointer :OpaqueRef))
    (guid (:pointer :UInt64))
   )
   :SInt32
() )

(deftrap-inline "_FWAReadQuadlet" 
   ((inRef (:pointer :OpaqueRef))
    (address (:pointer (:pointer :FWADDRESSSTRUCT)))
    (outData (:pointer :UInt32))
   )
   :SInt32
() )

(deftrap-inline "_FWAReadBlock" 
   ((inRef (:pointer :OpaqueRef))
    (address (:pointer (:pointer :FWADDRESSSTRUCT)))
    (size (:pointer :UInt32))
    (outData (:pointer :UInt8))
   )
   :SInt32
() )

(deftrap-inline "_FWAExecuteAVC" 
   ((inRef (:pointer :OpaqueRef))
    (cmd (:pointer :UInt8))
    (cmdSize :UInt32)
    (response (:pointer :UInt8))
    (responseSize (:pointer :UInt32))
   )
   :SInt32
() )

(deftrap-inline "_FWAWriteQuadlet" 
   ((inRef (:pointer :OpaqueRef))
    (address (:pointer (:pointer :FWADDRESSSTRUCT)))
    (data :UInt32)
   )
   :SInt32
() )

(deftrap-inline "_FWAWriteBlock" 
   ((inRef (:pointer :OpaqueRef))
    (address (:pointer (:pointer :FWADDRESSSTRUCT)))
    (size :UInt32)
    (data (:pointer :UInt8))
   )
   :SInt32
() )

(deftrap-inline "_FWACreateMIDIStream" 
   ((inRef (:pointer :OpaqueRef))
    (midiIO :UInt32)
    (bufSizeInBytes :UInt32)
    (buf :pointer)
    (sequenceNum :UInt32)
    (midiStreamRef (:pointer :UInt32))
   )
   :SInt32
() )

(deftrap-inline "_FWADisposeMIDIStream" 
   ((inRef (:pointer :OpaqueRef))
    (midiStreamRef :UInt32)
   )
   :SInt32
() )

(deftrap-inline "_FWAWriteMIDIData" 
   ((inRef (:pointer :OpaqueRef))
    (midiStreamRef :UInt32)
    (writeMsgLength :UInt32)
    (buf (:pointer :UInt8))
   )
   :SInt32
() )

(deftrap-inline "_FWAReadMIDIData" 
   ((inRef (:pointer :OpaqueRef))
    (midiStreamRef :UInt32)
    (buf (:pointer :FWAMIDIREADBUF))
   )
   :SInt32
() )
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  V2 stuff

(deftrap-inline "_FWAGetCycleTimeOffset" 
   ((inRef (:pointer :OpaqueRef))
    (cycleTimeOffset (:pointer :UInt32))
   )
   :SInt32
() )

(deftrap-inline "_FWASetCycleTimeOffset" 
   ((inRef (:pointer :OpaqueRef))
    (cycleTimeOffset :UInt32)
   )
   :SInt32
() )

(deftrap-inline "_FWAGetVendorID" 
   ((inRef (:pointer :OpaqueRef))
    (vendorID (:pointer :UInt32))
   )
   :SInt32
() )

(deftrap-inline "_FWAGetDeviceName" 
   ((inRef (:pointer :OpaqueRef))
    (name (:pointer :char))
   )
   :SInt32
() )

(deftrap-inline "_FWAGetVendorName" 
   ((inRef (:pointer :OpaqueRef))
    (name (:pointer :char))
   )
   :SInt32
() )

(deftrap-inline "_FWAIsMIDICapable" 
   ((inRef (:pointer :OpaqueRef))
    (supportsMIDI (:pointer :bool))
   )
   :SInt32
() )

(deftrap-inline "_FWAGetNumMIDIInputPlugs" 
   ((inRef (:pointer :OpaqueRef))
    (plugs (:pointer :UInt32))
   )
   :SInt32
() )

(deftrap-inline "_FWAGetNumMIDIOutputPlugs" 
   ((inRef (:pointer :OpaqueRef))
    (plugs (:pointer :UInt32))
   )
   :SInt32
() )

(deftrap-inline "_FWASetNumMIDIInputPlugs" 
   ((inRef (:pointer :OpaqueRef))
    (plugs :UInt32)
   )
   :SInt32
() )

(deftrap-inline "_FWASetNumMIDIOutputPlugs" 
   ((inRef (:pointer :OpaqueRef))
    (plugs :UInt32)
   )
   :SInt32
() )

(deftrap-inline "_FWAGetNumAudioInputPlugs" 
   ((inRef (:pointer :OpaqueRef))
    (plugs (:pointer :UInt32))
   )
   :SInt32
() )

(deftrap-inline "_FWAGetNumAudioOutputPlugs" 
   ((inRef (:pointer :OpaqueRef))
    (plugs (:pointer :UInt32))
   )
   :SInt32
() )

(deftrap-inline "_FWACreateAudioStream" 
   ((inRef (:pointer :OpaqueRef))
    (audioIO :UInt32)
    (audioStreamRef (:pointer :UInt32))
    (sequenceNum (:pointer :UInt32))
   )
   :SInt32
() )
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  V3

(deftrap-inline "_FWADisposeAudioStream" 
   ((inRef (:pointer :OpaqueRef))
    (audioStreamRef :UInt32)
   )
   :SInt32
() )

(deftrap-inline "_FWAGetDeviceSampleRate" 
   ((inRef (:pointer :OpaqueRef))
    (rate (:pointer :UInt32))
   )
   :SInt32
() )

(deftrap-inline "_FWAGetDeviceSendMode" 
   ((inRef (:pointer :OpaqueRef))
    (mode (:pointer :UInt32))
   )
   :SInt32
() )

(deftrap-inline "_FWAGetDeviceStatus" 
   ((inRef (:pointer :OpaqueRef))
    (outData :pointer)
    (inSize :UInt32)
   )
   :SInt32
() )

(deftrap-inline "_FWAGetDeviceStreamInfo" 
   ((inRef (:pointer :OpaqueRef))
    (audioStreamRef :UInt32)
    (numInput (:pointer :UInt32))
    (inputIsochChan (:pointer :UInt32))
    (numOutput (:pointer :UInt32))
    (outputIsochChan (:pointer :UInt32))
   )
   :SInt32
() )
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  Async methods added for MIDI

(deftrap-inline "_FWAInitAEvntSource" 
   ((inRef (:pointer :OpaqueRef))
    (source (:pointer :CFRunLoopSourceRef))
    (refcon :pointer)
   )
   :SInt32
() )

(deftrap-inline "_CreateAsyncWakePort" 
   ((inRef (:pointer :OpaqueRef))
    (notifyPort (:pointer :mach_port_t))
   )
   :SInt32
() )

(deftrap-inline "_FWAGetAEvntSource" 
   ((inRef (:pointer :OpaqueRef))
   )
   (:pointer :__CFRunLoopSource)
() )

(deftrap-inline "_FWAWriteMIDIDataAsync" 
   ((inRef (:pointer :OpaqueRef))
    (midiStreamRef :UInt32)
    (writeMsgLength :UInt32)
    (callback :pointer)
    (refCon :pointer)
   )
   :SInt32
() )

(deftrap-inline "_FWAReadMIDIDataAsync" 
   ((inRef (:pointer :OpaqueRef))
    (midiStreamRef :UInt32)
    (readBufSize :UInt32)
    (callback :pointer)
    (refCon :pointer)
   )
   :SInt32
() )
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  V4

(deftrap-inline "_FWASetDeviceStreamInfo" 
   ((inRef (:pointer :OpaqueRef))
    (audioStreamRef :UInt32)
    (numInput :UInt32)
    (inputIsochChan :UInt32)
    (numOutput :UInt32)
    (outputIsochChan :UInt32)
    (update :Boolean)
   )
   :SInt32
() )

; #if __cplusplus
#| 
 |#

; #endif


(provide-interface "AppleFWAudioUserLib")