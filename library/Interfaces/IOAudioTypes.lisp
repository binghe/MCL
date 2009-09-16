(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOAudioTypes.h"
; at Sunday July 2,2006 7:28:25 pm.
; 
;  * Copyright (c) 1998-2000 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  *
;  * The contents of this file constitute Original Code as defined in and
;  * are subject to the Apple Public Source License Version 1.1 (the
;  * "License").  You may not use this file except in compliance with the
;  * License.  Please obtain a copy of the License at
;  * http://www.apple.com/publicsource and read it before using this file.
;  *
;  * This Original Code and all software distributed under the License are
;  * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
;  * License for the specific language governing rights and limitations
;  * under the License.
;  *
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef _IOKIT_IOAUDIOTYPES_H
; #define _IOKIT_IOAUDIOTYPES_H

(require-interface "libkern/OSTypes")

(require-interface "mach/message")

(require-interface "device/device_types")
; !
;  * @enum IOAudioEngineMemory
;  * @abstract Used to identify the type of memory requested by a client process to be mapped into its process space
;  * @discussion This is the parameter to the type field of IOMapMemory when called on an IOAudioEngine.  This is
;  *  only intended for use by the Audio Device API library.
;  * @constant kIOAudioSampleBuffer This requests the IOAudioEngine's sample buffer
;  * @constant kIOAudioStatusBuffer This requests the IOAudioEngine's status buffer.  It's type is IOAudioEngineStatus.
;  * @constant kIOAudioMixBuffer This requests the IOAudioEngine's mix buffer
; 
(def-mactype :_IOAudioEngineMemory (find-mactype ':sint32))

(defconstant $kIOAudioStatusBuffer 0)
(defconstant $kIOAudioSampleBuffer 1)
(defconstant $kIOAudioMixBuffer 2)
(defconstant $kIOAudioBytesInInputBuffer 3)
(defconstant $kIOAudioBytesInOutputBuffer 4)
(def-mactype :IOAudioEngineMemory (find-mactype ':SINT32))
; !
;  * @enum IOAudioEngineCalls
;  * @abstract The set of constants passed to IOAudioEngineUserClient::getExternalMethodForIndex() when making calls
;  *  from the IOAudioFamily user client code.
;  
(def-mactype :_IOAudioEngineCalls (find-mactype ':sint32))

(defconstant $kIOAudioEngineCallRegisterClientBuffer 0)
(defconstant $kIOAudioEngineCallUnregisterClientBuffer 1)
(defconstant $kIOAudioEngineCallGetConnectionID 2)
(defconstant $kIOAudioEngineCallStart 3)
(defconstant $kIOAudioEngineCallStop 4)
(defconstant $kIOAudioEngineCallGetNearestStartTime 5)
(def-mactype :IOAudioEngineCalls (find-mactype ':SINT32))
; ! @defined kIOAudioEngineNumCalls The number of elements in the IOAudioEngineCalls enum. 
(defconstant $kIOAudioEngineNumCalls 6)
; #define kIOAudioEngineNumCalls		6
(def-mactype :_IOAudioEngineTraps (find-mactype ':sint32))

(defconstant $kIOAudioEngineTrapPerformClientIO 0)
(def-mactype :IOAudioEngineTraps (find-mactype ':SINT32))
(def-mactype :_IOAudioEngineNotifications (find-mactype ':sint32))

(defconstant $kIOAudioEngineAllNotifications 0)
(defconstant $kIOAudioEngineStreamFormatChangeNotification 1)
(defconstant $kIOAudioEngineChangeNotification 2)
(defconstant $kIOAudioEngineStartedNotification 3)
(defconstant $kIOAudioEngineStoppedNotification 4)
(defconstant $kIOAudioEnginePausedNotification 5)
(defconstant $kIOAudioEngineResumedNotification 6)
(def-mactype :IOAudioEngineNotifications (find-mactype ':SINT32))
; !
;  * @enum IOAudioEngineState
;  * @abstract Represents the state of an IOAudioEngine
;  * @constant kIOAudioEngineRunning The IOAudioEngine is currently running - it is transferring data to or 
;  *           from the device.
;  * @constant kIOAudioEngineStopped The IOAudioEngine is currently stopped - no activity is occurring.
;  
(def-mactype :_IOAudioEngineState (find-mactype ':sint32))

(defconstant $kIOAudioEngineStopped 0)
(defconstant $kIOAudioEngineRunning 1)
(defconstant $kIOAudioEnginePaused 2)
(defconstant $kIOAudioEngineResumed 3)
(def-mactype :IOAudioEngineState (find-mactype ':SINT32))
; !
;  * @typedef IOAudioEngineStatus
;  * @abstract Shared-memory structure giving audio engine status
;  * @discussion
;  * @field fVersion Indicates version of this structure
;  * @field fCurrentLoopCount Number of times around the ring buffer since the audio engine started
;  * @field fLastLoopTime Timestamp of the last time the ring buffer wrapped
;  * @field fEraseHeadSampleFrame Location of the erase head in sample frames - erased up to but not
;  *        including the given sample frame
;  
(defrecord _IOAudioEngineStatus
   (fVersion :UInt32)
   (fCurrentLoopCount :UInt32)
   (fLastLoopTime :UnsignedWide)
   (fEraseHeadSampleFrame :UInt32)
)
(%define-record :IOAudioEngineStatus (find-record-descriptor :_IOAUDIOENGINESTATUS))
(defconstant $kIOAudioEngineCurrentStatusStructVersion 2)
; #define kIOAudioEngineCurrentStatusStructVersion		2
(defrecord _IOAudioStreamFormat
   (fNumChannels :UInt32)
   (fSampleFormat :UInt32)
   (fNumericRepresentation :UInt32)
   (fBitDepth :UInt8)
   (fBitWidth :UInt8)
   (fAlignment :UInt8)
   (fByteOrder :UInt8)
   (fIsMixable :UInt8)
   (fDriverTag :UInt32)
)
(%define-record :IOAudioStreamFormat (find-record-descriptor :_IOAUDIOSTREAMFORMAT))
(defconstant $kFormatExtensionInvalidVersion 0)
; #define kFormatExtensionInvalidVersion					0
(defconstant $kFormatExtensionCurrentVersion 1)
; #define kFormatExtensionCurrentVersion					1
(defrecord _IOAudioStreamFormatExtension
   (fVersion :UInt32)
   (fFlags :UInt32)
   (fFramesPerPacket :UInt32)
   (fBytesPerPacket :UInt32)
)
(%define-record :IOAudioStreamFormatExtension (find-record-descriptor :_IOAUDIOSTREAMFORMATEXTENSION))
(defconstant $kStreamDataDescriptorInvalidVersion 0)
; #define kStreamDataDescriptorInvalidVersion				0
(defconstant $kStreamDataDescriptorCurrentVersion 1)
; #define kStreamDataDescriptorCurrentVersion				1
(defrecord _IOAudioStreamDataDescriptor
   (fVersion :UInt32)
   (fNumberOfStreams :UInt32)
   (fStreamLength (:array :UInt32 1))
                                                ;  Array with fNumberOfStreams number of entries
)
(%define-record :IOAudioStreamDataDescriptor (find-record-descriptor :_IOAUDIOSTREAMDATADESCRIPTOR))
(defrecord _IOAudioSampleIntervalDescriptor
   (sampleIntervalHi :UInt32)
   (sampleIntervalLo :UInt32)
)
(%define-record :IOAudioSampleIntervalDescriptor (find-record-descriptor :_IOAUDIOSAMPLEINTERVALDESCRIPTOR))
; 	A struct for encapsulating a SMPTE time. The running rate should
; 	be expressed in the AudioTimeStamp's mRateScalar field.
(defrecord _IOAudioSMPTETime
   (fCounter :uint64)
                                                ; 	total number of messages received
   (fType :UInt32)
                                                ; 	the SMPTE type (see constants)
   (fFlags :UInt32)
                                                ; 	flags indicating state (see constants
   (fHours :SInt16)
                                                ; 	number of hours in the full message
   (fMinutes :SInt16)
                                                ; 	number of minutes in the full message
   (fSeconds :SInt16)
                                                ; 	number of seconds in the full message
   (fFrames :SInt16)
                                                ; 	number of frames in the full message
)
(%define-record :IOAudioSMPTETime (find-record-descriptor :_IOAUDIOSMPTETIME))
; 	constants describing SMPTE types (taken from the MTC spec)

(defconstant $kIOAudioSMPTETimeType24 0)
(defconstant $kIOAudioSMPTETimeType25 1)
(defconstant $kIOAudioSMPTETimeType30Drop 2)
(defconstant $kIOAudioSMPTETimeType30 3)
(defconstant $kIOAudioSMPTETimeType2997 4)
(defconstant $kIOAudioSMPTETimeType2997Drop 5)
; 	flags describing a SMPTE time stamp

(defconstant $kIOAudioSMPTETimeValid 1)         ; 	the full time is valid
; 	time is running

(defconstant $kIOAudioSMPTETimeRunning 2)
; 	A struct for encapsulating the parts of a time stamp. The flags
; 	say which fields are valid.
(defrecord _IOAudioTimeStamp
   (fSampleTime :uint64)
                                                ; 	the absolute sample time, was a Float64
   (fHostTime :uint64)
                                                ; 	the host's root timebase's time
   (fRateScalar :uint64)
                                                ; 	the system rate scalar, was a Float64
   (fWordClockTime :uint64)
                                                ; 	the word clock time
   (fSMPTETime :_IOAUDIOSMPTETIME)
                                                ; 	the SMPTE time
   (fFlags :UInt32)
                                                ; 	the flags indicate which fields are valid
   (fReserved :UInt32)
                                                ; 	reserved, pads the structure out to force 8 byte alignment
)
(%define-record :IOAudioTimeStamp (find-record-descriptor :_IOAUDIOTIMESTAMP))
; 	flags for the AudioTimeStamp sturcture

(defconstant $kIOAudioTimeStampSampleTimeValid 1)
(defconstant $kIOAudioTimeStampHostTimeValid 2)
(defconstant $kIOAudioTimeStampRateScalarValid 4)
(defconstant $kIOAudioTimeStampWordClockTimeValid 8)
(defconstant $kIOAudioTimeStampSMPTETimeValid 16)
; 	Some commonly used combinations of timestamp flags

(defconstant $kIOAudioTimeStampSampleHostTimeValid 3)
; !
; * @enum IOAudioStreamDirection
;  * @abstract Represents the direction of an IOAudioStream
;  * @constant kAudioOutput Output buffer
;  * @constant kAudioInput Input buffer
;  
(def-mactype :_IOAudioStreamDirection (find-mactype ':sint32))

(defconstant $kIOAudioStreamDirectionOutput 0)
(defconstant $kIOAudioStreamDirectionInput 1)
(def-mactype :IOAudioStreamDirection (find-mactype ':SINT32))
; !
;  * @defined kIOAudioEngineDefaultMixBufferSampleSize
;  
; #define kIOAudioEngineDefaultMixBufferSampleSize		sizeof(float)
;  The following are for use only by the IOKit.framework audio family code 
; !
;  * @enum IOAudioControlCalls
;  * @abstract The set of constants passed to IOAudioControlUserClient::getExternalMethodForIndex() when making calls
;  *  from the IOAudioFamily user client code.
;  * @constant kIOAudioControlCallSetValue Used to set the value of an IOAudioControl.
;  * @constant kIOAudioControlCallGetValue Used to get the value of an IOAudioControl.
;  
(def-mactype :_IOAudioControlCalls (find-mactype ':sint32))

(defconstant $kIOAudioControlCallSetValue 0)
(defconstant $kIOAudioControlCallGetValue 1)
(def-mactype :IOAudioControlCalls (find-mactype ':SINT32))
; ! @defined kIOAudioControlNumCalls The number of elements in the IOAudioControlCalls enum. 
(defconstant $kIOAudioControlNumCalls 2)
; #define kIOAudioControlNumCalls 	2
; !
;  * @enum IOAudioControlNotifications
;  * @abstract The set of constants passed in the type field of IOAudioControlUserClient::registerNotificaitonPort().
;  * @constant kIOAudioControlValueChangeNotification Used to request value change notifications.
;  * @constant kIOAudioControlRangeChangeNotification Used to request range change notifications.
;  
(def-mactype :_IOAudioControlNotifications (find-mactype ':sint32))

(defconstant $kIOAudioControlValueChangeNotification 0)
(defconstant $kIOAudioControlRangeChangeNotification 1)
(def-mactype :IOAudioControlNotifications (find-mactype ':SINT32))
; !
;  * @struct IOAudioNotificationMessage
;  * @abstract Used in the mach message for IOAudio notifications.
;  * @field messageHeader Standard mach message header
;  * @field ref The param passed to registerNotificationPort() in refCon.
;  
(defrecord _IOAudioNotificationMessage
   (messageHeader :MACH_MSG_HEADER_T)
   (type :UInt32)
   (ref :UInt32)
   (sender :pointer)
)
(%define-record :IOAudioNotificationMessage (find-record-descriptor :_IOAUDIONOTIFICATIONMESSAGE))
(defrecord _IOAudioSampleRate
   (whole :UInt32)
   (fraction :UInt32)
)
(%define-record :IOAudioSampleRate (find-record-descriptor :_IOAUDIOSAMPLERATE))
; #define kNoIdleAudioPowerDown		0xffffffffffffffffULL

(defconstant $kIOAudioPortTypeOutput :|outp|)
(defconstant $kIOAudioPortTypeInput :|inpt|)
(defconstant $kIOAudioPortTypeMixer :|mixr|)
(defconstant $kIOAudioPortTypePassThru :|pass|)
(defconstant $kIOAudioPortTypeProcessing :|proc|)

(defconstant $kIOAudioOutputPortSubTypeInternalSpeaker :|ispk|)
(defconstant $kIOAudioOutputPortSubTypeExternalSpeaker :|espk|)
(defconstant $kIOAudioOutputPortSubTypeHeadphones :|hdpn|)
(defconstant $kIOAudioOutputPortSubTypeLine :|line|)
(defconstant $kIOAudioOutputPortSubTypeSPDIF :|spdf|)
(defconstant $kIOAudioInputPortSubTypeInternalMicrophone :|imic|)
(defconstant $kIOAudioInputPortSubTypeExternalMicrophone :|emic|)
(defconstant $kIOAudioInputPortSubTypeCD :|cd  |)
(defconstant $kIOAudioInputPortSubTypeLine :|line|)
(defconstant $kIOAudioInputPortSubTypeSPDIF :|spdf|)

(defconstant $kIOAudioControlTypeLevel :|levl|)
(defconstant $kIOAudioControlTypeToggle :|togl|)
(defconstant $kIOAudioControlTypeJack :|jack|)
(defconstant $kIOAudioControlTypeSelector :|slct|)

(defconstant $kIOAudioLevelControlSubTypeVolume :|vlme|)
(defconstant $kIOAudioLevelControlSubTypeLFEVolume :|subv|)
(defconstant $kIOAudioLevelControlSubTypePRAMVolume :|pram|)
(defconstant $kIOAudioToggleControlSubTypeMute :|mute|)
(defconstant $kIOAudioToggleControlSubTypeLFEMute :|subm|)
(defconstant $kIOAudioToggleControlSubTypeiSubAttach :|atch|)
(defconstant $kIOAudioSelectorControlSubTypeOutput :|outp|)
(defconstant $kIOAudioSelectorControlSubTypeInput :|inpt|)
(defconstant $kIOAudioSelectorControlSubTypeClockSource :|clck|)
(defconstant $kIOAudioSelectorControlSubTypeDestination :|dest|)
(defconstant $kIOAudioSelectorControlSubTypeChannelNominalLineLevel :|nlev|)

(defconstant $kIOAudioControlUsageOutput :|outp|)
(defconstant $kIOAudioControlUsageInput :|inpt|)
(defconstant $kIOAudioControlUsagePassThru :|pass|)
(defconstant $kIOAudioControlUsageCoreAudioProperty :|prop|)

(defconstant $kIOAudioControlChannelNumberInactive -1)
(defconstant $kIOAudioControlChannelIDAll 0)
(defconstant $kIOAudioControlChannelIDDefaultLeft 1)
(defconstant $kIOAudioControlChannelIDDefaultRight 2)
(defconstant $kIOAudioControlChannelIDDefaultCenter 3)
(defconstant $kIOAudioControlChannelIDDefaultLeftRear 4)
(defconstant $kIOAudioControlChannelIDDefaultRightRear 5)
(defconstant $kIOAudioControlChannelIDDefaultSub 6)

(defconstant $kIOAudioSelectorControlSelectionValueNone :|none|);  Output-specific selection IDs 

(defconstant $kIOAudioSelectorControlSelectionValueInternalSpeaker :|ispk|)
(defconstant $kIOAudioSelectorControlSelectionValueExternalSpeaker :|espk|)
(defconstant $kIOAudioSelectorControlSelectionValueHeadphones :|hdpn|);  Input-specific selection IDs

(defconstant $kIOAudioSelectorControlSelectionValueInternalMicrophone :|imic|)
(defconstant $kIOAudioSelectorControlSelectionValueExternalMicrophone :|emic|)
(defconstant $kIOAudioSelectorControlSelectionValueCD :|cd  |);  Common selection IDs

(defconstant $kIOAudioSelectorControlSelectionValueLine :|line|)
(defconstant $kIOAudioSelectorControlSelectionValueSPDIF :|spdf|)

(defconstant $kIOAudioStreamSampleFormatLinearPCM :|lpcm|)
(defconstant $kIOAudioStreamSampleFormatIEEEFloat :|ieee|)
(defconstant $kIOAudioStreamSampleFormatALaw :|alaw|)
(defconstant $kIOAudioStreamSampleFormatMuLaw :|ulaw|)
(defconstant $kIOAudioStreamSampleFormatMPEG :|mpeg|)
(defconstant $kIOAudioStreamSampleFormatAC3 :|ac-3|)
(defconstant $kIOAudioStreamSampleFormat1937AC3 :|cac3|)
(defconstant $kIOAudioStreamSampleFormat1937MPEG1 :|mpg1|)
(defconstant $kIOAudioStreamSampleFormat1937MPEG2 :|mpg2|)
(defconstant $kIOAudioStreamSampleFormatTimeCode :|time|); 	a stream of IOAudioTimeStamp structures that capture any incoming time code information


(defconstant $kIOAudioStreamNumericRepresentationSignedInt :|sint|)
(defconstant $kIOAudioStreamNumericRepresentationUnsignedInt :|uint|)
(defconstant $kIOAudioStreamNumericRepresentationIEEE754Float :|flot|)

(defconstant $kIOAudioStreamAlignmentLowByte 0)
(defconstant $kIOAudioStreamAlignmentHighByte 1)

(defconstant $kIOAudioStreamByteOrderBigEndian 0)
(defconstant $kIOAudioStreamByteOrderLittleEndian 1)

(defconstant $kIOAudioLevelControlNegativeInfinity #xFFFFFFFF)
;  Device connection types

(defconstant $kIOAudioDeviceTransportTypeBuiltIn :|bltn|)
(defconstant $kIOAudioDeviceTransportTypePCI :|pci |)
(defconstant $kIOAudioDeviceTransportTypeUSB :|usb |)
(defconstant $kIOAudioDeviceTransportTypeFireWire :|1394|)
(defconstant $kIOAudioDeviceTransportTypeNetwork :|ntwk|)
(defconstant $kIOAudioDeviceTransportTypeWireless :|wrls|)
(defconstant $kIOAudioDeviceTransportTypeOther :|othr|)
;  types that go nowhere

(defconstant $OUTPUT_NULL #x100)
(defconstant $INPUT_NULL #x101)
;  Input terminal types

(defconstant $INPUT_UNDEFINED #x200)
(defconstant $INPUT_MICROPHONE #x201)
(defconstant $INPUT_DESKTOP_MICROPHONE #x202)
(defconstant $INPUT_PERSONAL_MICROPHONE #x203)
(defconstant $INPUT_OMNIDIRECTIONAL_MICROPHONE #x204)
(defconstant $INPUT_MICROPHONE_ARRAY #x205)
(defconstant $INPUT_PROCESSING_MICROPHONE_ARRAY #x206)
(defconstant $INPUT_MODEM_AUDIO #x207)
;  Output terminal types

(defconstant $OUTPUT_UNDEFINED #x300)
(defconstant $OUTPUT_SPEAKER #x301)
(defconstant $OUTPUT_HEADPHONES #x302)
(defconstant $OUTPUT_HEAD_MOUNTED_DISPLAY_AUDIO #x303)
(defconstant $OUTPUT_DESKTOP_SPEAKER #x304)
(defconstant $OUTPUT_ROOM_SPEAKER #x305)
(defconstant $OUTPUT_COMMUNICATION_SPEAKER #x306)
(defconstant $OUTPUT_LOW_FREQUENCY_EFFECTS_SPEAKER #x307)
;  Bi-directional terminal types

(defconstant $BIDIRECTIONAL_UNDEFINED #x400)
(defconstant $BIDIRECTIONAL_HANDSET #x401)
(defconstant $BIDIRECTIONAL_HEADSET #x402)
(defconstant $BIDIRECTIONAL_SPEAKERPHONE_NO_ECHO_REDX #x403)
(defconstant $BIDIRECTIONAL_ECHO_SUPPRESSING_SPEAKERPHONE #x404)
(defconstant $BIDIRECTIONAL_ECHO_CANCELING_SPEAKERPHONE #x405)
;  Telephony terminal types

(defconstant $TELEPHONY_UNDEFINED #x500)
(defconstant $TELEPHONY_PHONE_LINE #x501)
(defconstant $TELEPHONY_TELEPHONE #x502)
(defconstant $TELEPHONY_DOWN_LINE_PHONE #x503)
;  External terminal types

(defconstant $EXTERNAL_UNDEFINED #x600)
(defconstant $EXTERNAL_ANALOG_CONNECTOR #x601)
(defconstant $EXTERNAL_DIGITAL_AUDIO_INTERFACE #x602)
(defconstant $EXTERNAL_LINE_CONNECTOR #x603)
(defconstant $EXTERNAL_LEGACY_AUDIO_CONNECTOR #x604)
(defconstant $EXTERNAL_SPDIF_INTERFACE #x605)
(defconstant $EXTERNAL_1394_DA_STREAM #x606)
(defconstant $EXTERNAL_1394_DV_STREAM_SOUNDTRACK #x607)
(defconstant $EXTERNAL_ADAT #x608)
(defconstant $EXTERNAL_TDIF #x609)
(defconstant $EXTERNAL_MADI #x60A)
;  Embedded terminal types

(defconstant $EMBEDDED_UNDEFINED #x700)
(defconstant $EMBEDDED_LEVEL_CALIBRATION_NOISE_SOURCE #x701)
(defconstant $EMBEDDED_EQUALIZATION_NOISE #x702)
(defconstant $EMBEDDED_CD_PLAYER #x703)
(defconstant $EMBEDDED_DAT #x704)
(defconstant $EMBEDDED_DCC #x705)
(defconstant $EMBEDDED_MINIDISK #x706)
(defconstant $EMBEDDED_ANALOG_TAPE #x707)
(defconstant $EMBEDDED_PHONOGRAPH #x708)
(defconstant $EMBEDDED_VCR_AUDIO #x709)
(defconstant $EMBEDDED_VIDEO_DISC_AUDIO #x70A)
(defconstant $EMBEDDED_DVD_AUDIO #x70B)
(defconstant $EMBEDDED_TV_TUNER_AUDIO #x70C)
(defconstant $EMBEDDED_SATELLITE_RECEIVER_AUDIO #x70D)
(defconstant $EMBEDDED_CABLE_TUNER_AUDIO #x70E)
(defconstant $EMBEDDED_DSS_AUDIO #x70F)
(defconstant $EMBEDDED_RADIO_RECEIVER #x710)
(defconstant $EMBEDDED_RADIO_TRANSMITTER #x711)
(defconstant $EMBEDDED_MULTITRACK_RECORDER #x712)
(defconstant $EMBEDDED_SYNTHESIZER #x713)
;  Processing terminal types

(defconstant $PROCESSOR_UNDEFINED #x800)
(defconstant $PROCESSOR_GENERAL #x801)

; #endif /* _IOKIT_IOAUDIOTYPES_H */


(provide-interface "IOAudioTypes")