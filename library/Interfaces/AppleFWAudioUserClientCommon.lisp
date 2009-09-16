(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AppleFWAudioUserClientCommon.h"
; at Sunday July 2,2006 7:25:39 pm.
; --------------------------------------------------------------------------------
; 
; 	File:		AppleFWAudioUserClientCommon.h
; 
; 	Contains:	A common file to keep the API in sync with the User and Kernel side of the code
; 
; 	Technology:	OS X
; 
; 	DRI:		Matthew Xavier Mora	mxmora@apple.com
; 	ALTERNATE:	
; 
; --------------------------------------------------------------------------------
; #ifndef _AppleFWAudioUserClientCommon_H
; #define _AppleFWAudioUserClientCommon_H
(defconstant $kMIDIInputClientBufferSize 128)
; #define kMIDIInputClientBufferSize 		(4 * 32)
(defconstant $kMIDIOutputClientBufferSize 128)
; #define kMIDIOutputClientBufferSize 	(4 * 32)
(defconstant $kMIDIInputRingBufferSize 1024)
; #define kMIDIInputRingBufferSize 		(1 * 1024)
(defconstant $kMIDIOutputRingBufferSize 1024)
; #define kMIDIOutputRingBufferSize		(1 * 1024) 

(defconstant $kMIDIStreamOut 0)
(defconstant $kMIDIStreamIn 1)
(defrecord FWAMIDIReadBuffer
   (bufSize :UInt32)
   (mrBuf (:array :UInt32 128))
)
(%define-record :FWAMIDIReadBuf (find-record-descriptor :FWAMIDIREADBUFFER))
(def-mactype :kFWADeviceStatusCurrentVersion (find-mactype ':UInt32)); =
(defrecord FWADeviceStatus
   (version :UInt32)
   (sampleCounter :UInt32)
   (inputSampleFrame :UInt32)
   (outputSampleFrame :UInt32)
   (inputClipSampleFrame :UInt32)
   (outputClipSampleFrame :UInt32)
   (meterData (:array :UInt32 1))
                                                ; numInputChannels + numInputChannels
)
(%define-record :FWADeviceStatusRec (find-record-descriptor :FWADEVICESTATUS))

(def-mactype :FWADeviceStatusRecPtr (find-mactype '(:POINTER :FWADEVICESTATUS)))

(defconstant $kFWAudioMaxNameSize 64)
(defconstant $kReadBlockInParamCount 3)
(defconstant $kReadBlockOutParamCount #xFFFFFFFF)
(defconstant $kWriteQuadletInParamCount 3)
(defconstant $kWriteQuadletOutParamCount 0)
(defconstant $kWriteBlockInParamCount 4)
(defconstant $kWriteBlockOutParamCount 0)
(defconstant $kReadQuadletInParamCount 2)
(defconstant $kReadQuadletOutParamCount 1)
(defconstant $kGetCycleTimeOffsetInParamCount 0)
(defconstant $kGetCycleTimeOffsetOutParamCount 1)
(defconstant $kSetCycleTimeOffsetInParamCount 1)
(defconstant $kSetCycleTimeOffsetOutParamCount 0)
(defconstant $kGetDeviceNameInParamCount 0)
(defconstant $kGetDeviceNameOutParamCount #xFFFFFFFF)
(defconstant $kGetVendorNameInParamCount 0)
(defconstant $kGetVendorNameOutParamCount #xFFFFFFFF)
(defconstant $kIsMIDICapableInParamCount 0)
(defconstant $kIsMIDICapableOutParamCount 1)
(defconstant $kGetNumMIDIInputPlugsInParamCount 0)
(defconstant $kGetNumMIDIInputPlugsOutParamCount 1)
(defconstant $kGetNumMIDIOutputPlugsInParamCount 0)
(defconstant $kGetNumMIDIOutputPlugsOutParamCount 1)
(defconstant $kSetNumMIDIInputPlugsInParamCount 1)
(defconstant $kSetNumMIDIInputPlugsOutParamCount 0)
(defconstant $kSetNumMIDIOutputPlugsInParamCount 1)
(defconstant $kSetNumMIDIOutputPlugsOutParamCount 0)
(defconstant $kGetNumAudioInputPlugsInParamCount 0)
(defconstant $kGetNumAudioInputPlugsOutParamCount 1)
(defconstant $kGetNumAudioOutputPlugsInParamCount 0)
(defconstant $kGetNumAudioOutputPlugsOutParamCount 1)
(defconstant $kCreateAudioStreamInParamCount 1)
(defconstant $kCreateAudioStreamOutParamCount 2)
(defconstant $kDisposeAudioStreamInParamCount 1)
(defconstant $kDisposeAudioStreamOutParamCount 0)
(defconstant $kGetDeviceSampleRateInParamCount 0)
(defconstant $kGetDeviceSampleRateOutParamCount 1)
(defconstant $kGetDeviceSendModeInParamCount 0)
(defconstant $kGetDeviceSendModeOutParamCount 1)
(defconstant $kGetDeviceStatusInParamCount 1)
(defconstant $kGetDeviceStatusOutParamCount #xFFFFFFFF)
(defconstant $kGetDeviceStreamInfoInParamCount 1)
(defconstant $kGetDeviceStreamInfoOutParamCount 4)
(defconstant $kSetDeviceStreamInfoInParamCount 6)
(defconstant $kSetDeviceStreamInfoOutParamCount 0);  Index into our API

(defconstant $kFWAOpenIndex 0)
(defconstant $kFWACloseIndex 1)
(defconstant $kFWAGetCycleTimeOffset 2)
(defconstant $kFWASetCycleTimeOffset 3)
(defconstant $kFWAGetNodeID 4)
(defconstant $kFWAGetGUID 5)
(defconstant $kFWAReadQuadlet 6)
(defconstant $kFWAReadBlock 7)
(defconstant $kFWAExecuteAVC 8)
(defconstant $kFWAWriteQuadlet 9)
(defconstant $kFWAWriteBlock 10)
(defconstant $kFWAGetMacGUID 11)
(defconstant $kFWACreateMIDIStream 12)
(defconstant $kFWADisposeMIDIStream 13)
(defconstant $kFWAWriteMIDIData 14)
(defconstant $kFWAReadMIDIData 15)
(defconstant $kFWAIsMIDICapable 16)
(defconstant $kFWAGetVendorID 17)
(defconstant $kFWAGetDeviceName 18)
(defconstant $kFWAGetVendorName 19)
(defconstant $kFWAGetNumMIDIInputPlugs 20)
(defconstant $kFWAGetNumMIDIOutputPlugs 21)
(defconstant $kFWASetNumMIDIInputPlugs 22)
(defconstant $kFWASetNumMIDIOutputPlugs 23)
(defconstant $kFWAGetNumAudioInputPlugs 24)
(defconstant $kFWAGetNumAudioOutputPlugs 25)
(defconstant $kFWACreateAudioStream 26)
(defconstant $kFWADisposeAudioStream 27)
(defconstant $kFWAGetDeviceSampleRate 28)
(defconstant $kFWAGetDeviceSendMode 29)
(defconstant $kFWAGetDeviceStatus 30)
(defconstant $kFWAGetDeviceStreamInfo 31)       ;  V4   -----------------------

(defconstant $kFWASetDeviceStreamInfo 32)       ;   -----------------------
;  Keep kFWANumberFWAMethods last!!

(defconstant $kFWANumberFWAMethods 33)
;  Index into our Async API

(defconstant $kFWASetAsyncPort 0)
(defconstant $kWriteMIDIAsync 1)
(defconstant $kReadMIDIAsync 2)                 ;   -----------------------
;  Keep kFWANumberAsyncFWAMethods last!!

(defconstant $kFWANumberAsyncFWAMethods 3)

; #endif /*_AppleFWAudioUserClientCommon_H */


(provide-interface "AppleFWAudioUserClientCommon")