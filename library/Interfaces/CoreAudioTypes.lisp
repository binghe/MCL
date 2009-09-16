(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CoreAudioTypes.h"
; at Sunday July 2,2006 7:26:52 pm.
; =============================================================================
;      File:       CoreAudio/CoreAudioTypes.h
; 
;      Contains:   definitions of basic types used in the Core Audio APIs
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
; =============================================================================

; #if !defined(__CoreAudioTypes_h__)
; #define __CoreAudioTypes_h__
; 	TargetConditionals.h has the definitions of some basic platform constants

(require-interface "TargetConditionals")
; 	MacTypes.h has the definitions of basic types like UInt32 and Float64

; #if	TARGET_OS_MAC && TARGET_RT_MAC_MACHO
#| |#

(require-interface "CoreServices/../Frameworks/CarbonCore.framework/Headers/MacTypes")

#|
 |#

; #else

(require-interface "MacTypes")

; #endif


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
; 	This structure holds a pair of numbers representing a continuous range of values
(defrecord AudioValueRange
   (mMinimum :double-float)
   (mMaximum :double-float)
)

;type name? (%define-record :AudioValueRange (find-record-descriptor ':AudioValueRange))
; 	This structure holds the buffers necessary for translation operations
(defrecord AudioValueTranslation
   (mInputData :pointer)
   (mInputDataSize :UInt32)
   (mOutputData :pointer)
   (mOutputDataSize :UInt32)
)

;type name? (%define-record :AudioValueTranslation (find-record-descriptor ':AudioValueTranslation))
; 	The following two structures are used to wrap up buffers of audio data
; 	when passing them around in API calls.
(defrecord AudioBuffer
   (mNumberChannels :UInt32)
                                                ; 	number of interleaved channels in the buffer
   (mDataByteSize :UInt32)
                                                ; 	the size of the buffer pointed to by mData
   (mData :pointer)
                                                ; 	the pointer to the buffer
)

;type name? (%define-record :AudioBuffer (find-record-descriptor ':AudioBuffer))
(defrecord AudioBufferList
   (mNumberBuffers :UInt32)
   (mBuffers (:array :AudioBuffer 1))
)

;type name? (%define-record :AudioBufferList (find-record-descriptor ':AudioBufferList))
; 	This structure encapsulates all the information for describing
; 	the basic properties of a stream of audio data. This structure
; 	is sufficient to describe any constant bit rate format that 
; 	has chanels that are the same size. Extensions are required
; 	for variable bit rate data and for constant bit rate data where
; 	the channels have unequal sizes. However, where applicable,
; 	the appropriate fields will be filled out correctly for these
; 	kinds of formats (the extra data is provided via separate
; 	properties). In all fields, a value of 0 indicates that the
; 	field is either unknown, not applicable or otherwise is
; 	inapproprate for the format and should be ignored. Note that
; 	0 is still a valid value for most formats the mFormatFlags field.
;  	a Frame is one sample across all channels.
;  	in non-interleaved audio, the per frame fields identify one channel.
;  	in interleaved audio, the per frame fields identify the set of n channels.
;  	in uncompressed audio, a Packet is one frame, (FramesPerPacket == 1).
;  	in compressed audio, a Packet is an indivisible chunk of compressed data, 
;  	for example an AAC packet will contain 1024 sample frames
(defrecord AudioStreamBasicDescription
   (mSampleRate :double-float)
                                                ; 	the native sample rate of the audio stream
   (mFormatID :UInt32)
                                                ; 	the specific encoding type of audio stream
   (mFormatFlags :UInt32)
                                                ; 	flags specific to each format
   (mBytesPerPacket :UInt32)
                                                ; 	the number of bytes in a packet
   (mFramesPerPacket :UInt32)
                                                ; 	the number of frames in each packet
   (mBytesPerFrame :UInt32)
                                                ; 	the number of bytes in a frame
   (mChannelsPerFrame :UInt32)
                                                ; 	the number of channels in each frame
   (mBitsPerChannel :UInt32)
                                                ; 	the number of bits in each channel
   (mReserved :UInt32)
                                                ; 	reserved, pads the structure out to force 8 byte alignment
)

;type name? (%define-record :AudioStreamBasicDescription (find-record-descriptor ':AudioStreamBasicDescription))
; 	constants for use in AudioStreamBasicDescriptions

(defconstant $kAudioStreamAnyRate 0)            ; 	the format can use any sample rate (usually because it does
; 	its own rate conversion). Note that this constant can only
; 	appear in listings of supported descriptions. It should never
; 	appear in the current description as a device must always
; 	have a "current" nominal sample rate.

; 	Format IDs

(defconstant $kAudioFormatLinearPCM :|lpcm|)    ; 	linear PCM data, uses standard flags

(defconstant $kAudioFormatAC3 :|ac-3|)          ; 	AC-3, has no flags

(defconstant $kAudioFormat60958AC3 :|cac3|)     ; 	AC-3 packaged for transport over an IEC 60958 compliant digital audio interface, uses standard flags

(defconstant $kAudioFormatMPEG :|mpeg|)         ; 	MPEG-1 or MPEG-2, has no flags

(defconstant $kAudioFormatAppleIMA4 :|ima4|)    ; 	Apple's implementation of IMA 4:1 ADPCM encoding, has no flags

(defconstant $kAudioFormatMPEG4AAC :|aac |)     ; 	MPEG-4 AAC, the flags field contains the MPEG-4 audio object type constant indicating the specific kind of data

(defconstant $kAudioFormatMPEG4CELP :|celp|)    ; 	MPEG-4 CELP, the flags field contains the MPEG-4 audio object type constant indicating the specific kind of data

(defconstant $kAudioFormatMPEG4HVXC :|hvxc|)    ; 	MPEG-4 HVXC, the flags field contains the MPEG-4 audio object type constant indicating the specific kind of data

(defconstant $kAudioFormatMPEG4TwinVQ :|twvq|)  ; 	MPEG-4 TwinVQ, the flags field contains the MPEG-4 audio object type constant indicating the specific kind of data

(defconstant $kAudioFormatMACE3 :|MAC3|)        ; 	MACE 3:1

(defconstant $kAudioFormatMACE6 :|MAC6|)        ; 	MACE 6:1

(defconstant $kAudioFormatULaw :|ulaw|)         ; 	µLaw 2:1

(defconstant $kAudioFormatALaw :|alaw|)         ; 	aLaw 2:1

(defconstant $kAudioFormatQDesign :|QDMC|)      ; 	QDesign music

(defconstant $kAudioFormatQDesign2 :|QDM2|)     ; 	QDesign2 music

(defconstant $kAudioFormatQUALCOMM :|Qclp|)     ; 	QUALCOMM PureVoice

(defconstant $kAudioFormatMPEGLayer3 :|.mp3|)   ; 	MPEG Layer 3, CBR & VBR (QT4.1 and later)

(defconstant $kAudioFormatDVAudio :|dvca|)      ; 	DV Audio

(defconstant $kAudioFormatVariableDurationDVAudio :|vdva|); 	Variable Duration DV Audio

(defconstant $kAudioFormatTimeCode :|time|)     ; 	a stream of IOAudioTimeStamps that describe the timing of the audio data, the format flags are the same as the IOAudioTimeStamp flags, see <IOKit/audio/IOAudioTypes.h> for the definition of IOAudioTimeStamp

(defconstant $kAudioFormatMIDIStream :|midi|)   ; 	describes a stream that contains a MIDIPacketList. The Time Stamps associated in the MIDIPacketList are sample offsets in this stream. The Sample Rate is used to describe how time is passed in this kind of stream and an AudioUnit that receives or generates this stream can use this SampleRate, the number of frames it is rendering and the sample offsets within the MIDIPacketList to define the time for any MIDI event within this list.

(defconstant $kAudioFormatParameterValueStream :|apvs|);   a format that describes a "side-chain" of Float32 data that can be fed or generated by an AudioUnit and is used to send a high density of parameter value control information. An AU will typically run a ParameterValueStream at either the sample rate of the AudioUnit's audio data, or some integer divisor of this (say a half or a third of the sample rate of the audio). The Sample Rate of the ASBD would describe this relationship

; 	These flags are used in the mFormatFlags field of AudioStreamBasicDescription.
;  Typically, when an ASBD is being used, the fields describe the complete layout of the sample data in the
;  buffers that are represented by this description - where typically those buffers are represented by an
;  AudioBuffer that is contained in an AudioBufferList
;  However, when an ASBD has the kAudioFormatFlagIsNonInterleaved flag, the AudioBufferList has a different
;  structure and semantic. In this case, the ASBD fields will describe the format of ONE of the AudioBuffers
;  that are contained in the list, AND each AudioBuffer in the list is determined to have a single (mono) channel
;  of audio data. Then, the ASBD's mChannelsPerFrame will indicate the total number of AudioBuffers that are 
;  contained within the AudioBufferList - where each buffer contains one channel. This is used primarily with
;  the AudioUnit (and AudioConverter) representation of this list - and typically won't be found in the AudioHardware usage of 
;  this structure.
; 	standard flags

(defconstant $kAudioFormatFlagIsFloat 1)        ; 	set for floating point, clear for integer

(defconstant $kAudioFormatFlagIsBigEndian 2)    ; 	set for big endian, clear for little

(defconstant $kAudioFormatFlagIsSignedInteger 4); 	set for signed integer, clear for unsigned integer, only valid if kAudioFormatFlagIsFloat is clear

(defconstant $kAudioFormatFlagIsPacked 8)       ; 	set if the sample bits are packed as closely together as possible, clear if they are high or low aligned within the channel

(defconstant $kAudioFormatFlagIsAlignedHigh 16) ; 	set if the sample bits are placed into the high bits of the channel, clear for low bit placement, only valid if kAudioFormatFlagIsPacked is clear

(defconstant $kAudioFormatFlagIsNonInterleaved 32); 	set if the samples for each channel are located contiguously and the channels are layed out end to end, clear if the samples for each frame are layed out contiguously and the frames layed out end to end

(defconstant $kAudioFormatFlagsAreAllClear #x80000000); 	set if all the flags would be clear in order to preserve 0 as the wild card value
; 	linear PCM flags

(defconstant $kLinearPCMFormatFlagIsFloat 1)
(defconstant $kLinearPCMFormatFlagIsBigEndian 2)
(defconstant $kLinearPCMFormatFlagIsSignedInteger 4)
(defconstant $kLinearPCMFormatFlagIsPacked 8)
(defconstant $kLinearPCMFormatFlagIsAlignedHigh 16)
(defconstant $kLinearPCMFormatFlagIsNonInterleaved 32)
(defconstant $kLinearPCMFormatFlagsAreAllClear #x80000000)
; 	Some commonly used combinations of format flags

; #if	TARGET_RT_BIG_ENDIAN

(defconstant $kAudioFormatFlagsNativeEndian 2)
#| 
; #else

(defconstant $kAudioFormatFlagsNativeEndian 0)
 |#

; #endif


(defconstant $kAudioFormatFlagsNativeFloatPacked 9)
; 	Routines for manipulating format flags
; #define TestAudioFormatNativeEndian(f)	((f.mFormatID == kAudioFormatLinearPCM) && ((f.mFormatFlags & kAudioFormatFlagIsBigEndian) == kAudioFormatFlagsNativeEndian))

; #if defined(__cplusplus)
#|
	inline bool	IsAudioFormatNativeEndian(const AudioStreamBasicDescription& f) { return (f.mFormatID == kAudioFormatLinearPCM) && ((f.mFormatFlags & kAudioFormatFlagIsBigEndian) == kAudioFormatFlagsNativeEndian); }
#endif
|#
; 	This struct is used to describe the packet layout of stream data
; 	where the size of each packet may not be the same or if there is
; 	extraneous data between audio data packets.
(defrecord AudioStreamPacketDescription
   (mStartOffset :SInt64)
                                                ;  the number of bytes from the start of the buffer to the beginning of the packet
   (mVariableFramesInPacket :UInt32)
                                                ;  number of frames in the packet for variable frame formats. 
                                                ;  For formats with constant frames per packet such as MP3 or AAC, mVariableFramesInPacket must be set to zero.
   (mDataByteSize :UInt32)
                                                ;  the length of the packet in bytes
)

;type name? (%define-record :AudioStreamPacketDescription (find-record-descriptor ':AudioStreamPacketDescription))
; 	A struct for encapsulating a SMPTE time. The running rate should
; 	be expressed in the AudioTimeStamp's mRateScalar field.
(defrecord SMPTETime
   (mCounter :UInt64)
                                                ; 	total number of messages received
   (mType :UInt32)
                                                ; 	the SMPTE type (see constants)
   (mFlags :UInt32)
                                                ; 	flags indicating state (see constants
   (mHours :SInt16)
                                                ; 	number of hours in the full message
   (mMinutes :SInt16)
                                                ; 	number of minutes in the full message
   (mSeconds :SInt16)
                                                ; 	number of seconds in the full message
   (mFrames :SInt16)
                                                ; 	number of frames in the full message
)

;type name? (%define-record :SMPTETime (find-record-descriptor ':SMPTETime))
; 	constants describing SMPTE types (taken from the MTC spec)

(defconstant $kSMPTETimeType24 0)
(defconstant $kSMPTETimeType25 1)
(defconstant $kSMPTETimeType30Drop 2)
(defconstant $kSMPTETimeType30 3)
(defconstant $kSMPTETimeType2997 4)
(defconstant $kSMPTETimeType2997Drop 5)
; 	flags describing a SMPTE time stamp

(defconstant $kSMPTETimeValid 1)                ; 	the full time is valid
; 	time is running

(defconstant $kSMPTETimeRunning 2)
; 	A struct for encapsulating the parts of a time stamp. The flags
; 	say which fields are valid.
(defrecord AudioTimeStamp
   (mSampleTime :double-float)
                                                ; 	the absolute sample time
   (mHostTime :UInt64)
                                                ; 	the host's root timebase's time
   (mRateScalar :double-float)
                                                ; 	the system rate scalar
   (mWordClockTime :UInt64)
                                                ; 	the word clock time
   (mSMPTETime :SMPTETime)
                                                ; 	the SMPTE time
   (mFlags :UInt32)
                                                ; 	the flags indicate which fields are valid
   (mReserved :UInt32)
                                                ; 	reserved, pads the structure out to force 8 byte alignment
)

;type name? (%define-record :AudioTimeStamp (find-record-descriptor ':AudioTimeStamp))
; 	flags for the AudioTimeStamp sturcture

(defconstant $kAudioTimeStampSampleTimeValid 1)
(defconstant $kAudioTimeStampHostTimeValid 2)
(defconstant $kAudioTimeStampRateScalarValid 4)
(defconstant $kAudioTimeStampWordClockTimeValid 8)
(defconstant $kAudioTimeStampSMPTETimeValid 16)
; 	Some commonly used combinations of timestamp flags

(defconstant $kAudioTimeStampSampleHostTimeValid 3)
;  AudioClassDescription is used to describe codecs installed on the system.
(defrecord AudioClassDescription
   (mType :OSType)
   (mSubType :OSType)
   (mManufacturer :OSType)
)

;type name? (%define-record :AudioClassDescription (find-record-descriptor ':AudioClassDescription))
; 	typedefs used for describing channel layouts

(def-mactype :AudioChannelLabel (find-mactype ':UInt32))

(def-mactype :AudioChannelLayoutTag (find-mactype ':UInt32))
; 	An AudioChannelDescription contains information describing a single channel	
(defrecord AudioChannelDescription
   (mChannelLabel :UInt32)
                                                ; 	see constants below
   (mChannelFlags :UInt32)
                                                ; 	flags that control the interpretation of the coordinates, see constants below
   (mCoordinates (:array :single-float 3))
                                                ; 	coordinates that specify the precise location of a speaker
)

;type name? (%define-record :AudioChannelDescription (find-record-descriptor ':AudioChannelDescription))
;  The AudioChannelLayout struct is used to specify channel layouts in files and hardware.
(defrecord AudioChannelLayout
   (mChannelLayoutTag :UInt32)
                                                ; 	see constants below
   (mChannelBitmap :UInt32)
                                                ; 	if non zero, then represents a channel bitmap.
   (mNumberChannelDescriptions :UInt32)
                                                ; 	the number of channel descriptions
   (mChannelDescriptions (:array :AudioChannelDescription 1))
                                                ; 	actual dimension is mNumberChannelDescriptions
)

;type name? (%define-record :AudioChannelLayout (find-record-descriptor ':AudioChannelLayout))
;  These are for use in the mChannelLabel field of struct AudioChannelDescription
;  These channel labels attempt to list all labels in common use.
;  Due to the ambiguities in channel labeling by various groups, 
;  there may be some overlap or duplication in the labels below.
;  Use the label which most clearly describes what you mean.
;  WAVE files seem to follow the USB spec for the channel flags.
;  A channel map lets you put these channels in any order, however a WAVE file only supports 
;  labels 1-18 and if present, they must be in the order given below. 
;  The integer values for the labels below match the bit position of the label 
;  in the USB bitmap and thus also the WAVE file bitmap.

(defconstant $kAudioChannelLabel_Unknown #xFFFFFFFF);  unknown or unspecified other use

(defconstant $kAudioChannelLabel_Unused 0)      ;  channel is present, but has no intended use or destination

(defconstant $kAudioChannelLabel_UseCoordinates 100);  channel is described by the mCoordinates fields.

(defconstant $kAudioChannelLabel_Left 1)
(defconstant $kAudioChannelLabel_Right 2)
(defconstant $kAudioChannelLabel_Center 3)
(defconstant $kAudioChannelLabel_LFEScreen 4)
(defconstant $kAudioChannelLabel_LeftSurround 5);  WAVE: "Back Left"

(defconstant $kAudioChannelLabel_RightSurround 6);  WAVE: "Back Right"

(defconstant $kAudioChannelLabel_LeftCenter 7)
(defconstant $kAudioChannelLabel_RightCenter 8)
(defconstant $kAudioChannelLabel_CenterSurround 9);  WAVE: "Back Center" or plain "Rear Surround"

(defconstant $kAudioChannelLabel_LeftSurroundDirect 10);  WAVE: "Side Left"

(defconstant $kAudioChannelLabel_RightSurroundDirect 11);  WAVE: "Side Right"

(defconstant $kAudioChannelLabel_TopCenterSurround 12)
(defconstant $kAudioChannelLabel_VerticalHeightLeft 13);  WAVE: "Top Front Left"

(defconstant $kAudioChannelLabel_VerticalHeightCenter 14);  WAVE: "Top Front Center"

(defconstant $kAudioChannelLabel_VerticalHeightRight 15);  WAVE: "Top Front Right"

(defconstant $kAudioChannelLabel_TopBackLeft 16)
(defconstant $kAudioChannelLabel_TopBackCenter 17)
(defconstant $kAudioChannelLabel_TopBackRight 18)
(defconstant $kAudioChannelLabel_RearSurroundLeft 33)
(defconstant $kAudioChannelLabel_RearSurroundRight 34)
(defconstant $kAudioChannelLabel_LeftWide 35)
(defconstant $kAudioChannelLabel_RightWide 36)
(defconstant $kAudioChannelLabel_LFE2 37)
(defconstant $kAudioChannelLabel_LeftTotal 38)  ;  matrix encoded 4 channels

(defconstant $kAudioChannelLabel_RightTotal 39) ;  matrix encoded 4 channels

(defconstant $kAudioChannelLabel_HearingImpaired 40)
(defconstant $kAudioChannelLabel_Narration 41)
(defconstant $kAudioChannelLabel_Mono 42)
(defconstant $kAudioChannelLabel_DialogCentricMix 43)
(defconstant $kAudioChannelLabel_CenterSurroundDirect 44);  back center, non diffuse		
;  first order ambisonic channels

(defconstant $kAudioChannelLabel_Ambisonic_W #xC8)
(defconstant $kAudioChannelLabel_Ambisonic_X #xC9)
(defconstant $kAudioChannelLabel_Ambisonic_Y #xCA)
(defconstant $kAudioChannelLabel_Ambisonic_Z #xCB);  Mid/Side Recording

(defconstant $kAudioChannelLabel_MS_Mid #xCC)
(defconstant $kAudioChannelLabel_MS_Side #xCD)  ;  X-Y Recording

(defconstant $kAudioChannelLabel_XY_X #xCE)
(defconstant $kAudioChannelLabel_XY_Y #xCF)     ;  other

(defconstant $kAudioChannelLabel_HeadphonesLeft #x12D)
(defconstant $kAudioChannelLabel_HeadphonesRight #x12E)
(defconstant $kAudioChannelLabel_ClickTrack #x130)
(defconstant $kAudioChannelLabel_ForeignLanguage #x131);  generic discrete channel

(defconstant $kAudioChannelLabel_Discrete #x190);  numbered discrete channel

(defconstant $kAudioChannelLabel_Discrete_0 #x10000)
(defconstant $kAudioChannelLabel_Discrete_1 #x10001)
(defconstant $kAudioChannelLabel_Discrete_2 #x10002)
(defconstant $kAudioChannelLabel_Discrete_3 #x10003)
(defconstant $kAudioChannelLabel_Discrete_4 #x10004)
(defconstant $kAudioChannelLabel_Discrete_5 #x10005)
(defconstant $kAudioChannelLabel_Discrete_6 #x10006)
(defconstant $kAudioChannelLabel_Discrete_7 #x10007)
(defconstant $kAudioChannelLabel_Discrete_8 #x10008)
(defconstant $kAudioChannelLabel_Discrete_9 #x10009)
(defconstant $kAudioChannelLabel_Discrete_10 #x1000A)
(defconstant $kAudioChannelLabel_Discrete_11 #x1000B)
(defconstant $kAudioChannelLabel_Discrete_12 #x1000C)
(defconstant $kAudioChannelLabel_Discrete_13 #x1000D)
(defconstant $kAudioChannelLabel_Discrete_14 #x1000E)
(defconstant $kAudioChannelLabel_Discrete_15 #x1000F)
(defconstant $kAudioChannelLabel_Discrete_65535 #x1FFFF)
;  These are for use in the mChannelBitmap field of struct AudioChannelLayout

(defconstant $kAudioChannelBit_Left 1)
(defconstant $kAudioChannelBit_Right 2)
(defconstant $kAudioChannelBit_Center 4)
(defconstant $kAudioChannelBit_LFEScreen 8)
(defconstant $kAudioChannelBit_LeftSurround 16) ;  WAVE: "Back Left"

(defconstant $kAudioChannelBit_RightSurround 32);  WAVE: "Back Right"

(defconstant $kAudioChannelBit_LeftCenter 64)
(defconstant $kAudioChannelBit_RightCenter #x80)
(defconstant $kAudioChannelBit_CenterSurround #x100);  WAVE: "Back Center"

(defconstant $kAudioChannelBit_LeftSurroundDirect #x200);  WAVE: "Side Left"

(defconstant $kAudioChannelBit_RightSurroundDirect #x400);  WAVE: "Side Right"

(defconstant $kAudioChannelBit_TopCenterSurround #x800)
(defconstant $kAudioChannelBit_VerticalHeightLeft #x1000);  WAVE: "Top Front Left"

(defconstant $kAudioChannelBit_VerticalHeightCenter #x2000);  WAVE: "Top Front Center"

(defconstant $kAudioChannelBit_VerticalHeightRight #x4000);  WAVE: "Top Front Right"

(defconstant $kAudioChannelBit_TopBackLeft #x8000)
(defconstant $kAudioChannelBit_TopBackCenter #x10000)
(defconstant $kAudioChannelBit_TopBackRight #x20000)
;  these are used in the mChannelFlags field of struct AudioChannelDescription
;  Only one of the following two coordinate flags should be set. 
;  If neither is set, then there is no speaker coordinate info.

(defconstant $kAudioChannelFlags_RectangularCoordinates 1);  channel is specified by cartesian coordinates of speaker position

(defconstant $kAudioChannelFlags_SphericalCoordinates 2);  channel is specified by spherical coordinates of speaker position
;  If set, units are in meters. If unset, units are relative to the unit cube or sphere.

(defconstant $kAudioChannelFlags_Meters 4)
;  these are indices for acessing the mCoordinates array in struct AudioChannelDescription
;  if kChannelFlags_RectangularCoordinates is set.

(defconstant $kAudioChannelCoordinates_LeftRight 0);  negative left, positive right

(defconstant $kAudioChannelCoordinates_BackFront 1);  negative back, positive front

(defconstant $kAudioChannelCoordinates_DownUp 2);  negative below ground level, 0 = ground level, positive above ground level
;  if kChannelFlags_SphericalCoordinates is set. Coordinates specified as on a compass.

(defconstant $kAudioChannelCoordinates_Azimuth 0);  in degrees. zero is front center, + is right, - is left.

(defconstant $kAudioChannelCoordinates_Elevation 1);  in degrees. +90 is zenith, zero is horizontal, -90 is nadir.

(defconstant $kAudioChannelCoordinates_Distance 2);  units defined by flags

;  Some channel abbreviations used below:
;  L - left 
;  R - right
;  C - center
;  Ls - left surround
;  Rs - right surround
;  Cs - center surround
;  Rls - rear left surround
;  Rrs - rear right surround
;  Lw - left wide
;  Rw - right wide
;  Lsd - left surround direct
;  Rsd - right surround direct
;  Lc - left center
;  Rc - right center
;  Ts - top surround
;  Vhl - vertical height left
;  Vhc - vertical height center
;  Vhr - vertical height right
;  Lt - left matrix total. for matrix encoded stereo.
;  Rt - right matrix total. for matrix encoded stereo.
;  The low 16 bits of the layout tag gives the number of channels. 
;  AudioChannelLayoutTag_GetNumberOfChannels() is a macro to obtain the number of channels.
;  EXCEPT FOR kAudioChannelLayoutTag_UseChannelDescriptions and kAudioChannelLayoutTag_UseChannelBitmap
; #define AudioChannelLayoutTag_GetNumberOfChannels(layoutTag) ((UInt32)((layoutTag) & 0x0000FFFF))
;  these are used in the mChannelLayoutTag field of struct AudioChannelLayout
; 	General layouts

(defconstant $kAudioChannelLayoutTag_UseChannelDescriptions 0);  use the array of AudioChannelDescriptions to define the mapping.

(defconstant $kAudioChannelLayoutTag_UseChannelBitmap #x10000);  use the bitmap to define the mapping.

(defconstant $kAudioChannelLayoutTag_Mono #x640001);  a standard mono stream

(defconstant $kAudioChannelLayoutTag_Stereo #x650002);  a standard stereo stream (L R) - implied playback

(defconstant $kAudioChannelLayoutTag_StereoHeadphones #x660002);  a standard stereo stream (L R) - implied headphone playbac

(defconstant $kAudioChannelLayoutTag_MatrixStereo #x670002);  a matrix encoded stereo stream (Lt, Rt)

(defconstant $kAudioChannelLayoutTag_MidSide #x680002);  mid/side recording

(defconstant $kAudioChannelLayoutTag_XY #x690002);  coincident mic pair (often 2 figure 8's)

(defconstant $kAudioChannelLayoutTag_Binaural #x6A0002);  binaural stereo (left, right)

(defconstant $kAudioChannelLayoutTag_Ambisonic_B_Format #x6B0004);  W, X, Y, Z

(defconstant $kAudioChannelLayoutTag_Quadraphonic #x6C0004);  front left, front right, back left, back right

(defconstant $kAudioChannelLayoutTag_Pentagonal #x6D0005);  left, right, rear left, rear right, center

(defconstant $kAudioChannelLayoutTag_Hexagonal #x6E0006);  left, right, rear left, rear right, center, rear

(defconstant $kAudioChannelLayoutTag_Octagonal #x6F0008);  front left, front right, rear left, rear right, 
;  front center, rear center, side left, side right

(defconstant $kAudioChannelLayoutTag_Cube #x700008);  left, right, rear left, rear right
;  top left, top right, top rear left, top rear right
; 	MPEG defined layouts

(defconstant $kAudioChannelLayoutTag_MPEG_1_0 #x640001); 	C

(defconstant $kAudioChannelLayoutTag_MPEG_2_0 #x650002); 	L R

(defconstant $kAudioChannelLayoutTag_MPEG_3_0_A #x710003); 	L R C

(defconstant $kAudioChannelLayoutTag_MPEG_3_0_B #x720003); 	C L R

(defconstant $kAudioChannelLayoutTag_MPEG_4_0_A #x730004); 	L R C Cs

(defconstant $kAudioChannelLayoutTag_MPEG_4_0_B #x740004); 	C L R Cs

(defconstant $kAudioChannelLayoutTag_MPEG_5_0_A #x750005); 	L R C Ls Rs

(defconstant $kAudioChannelLayoutTag_MPEG_5_0_B #x760005); 	L R Ls Rs C

(defconstant $kAudioChannelLayoutTag_MPEG_5_0_C #x770005); 	L C R Ls Rs

(defconstant $kAudioChannelLayoutTag_MPEG_5_0_D #x780005); 	C L R Ls Rs

(defconstant $kAudioChannelLayoutTag_MPEG_5_1_A #x790006); 	L R C LFE Ls Rs

(defconstant $kAudioChannelLayoutTag_MPEG_5_1_B #x7A0006); 	L R Ls Rs C LFE

(defconstant $kAudioChannelLayoutTag_MPEG_5_1_C #x7B0006); 	L C R Ls Rs LFE

(defconstant $kAudioChannelLayoutTag_MPEG_5_1_D #x7C0006); 	C L R Ls Rs LFE

(defconstant $kAudioChannelLayoutTag_MPEG_6_1_A #x7D0007); 	L R C LFE Ls Rs Cs

(defconstant $kAudioChannelLayoutTag_MPEG_7_1_A #x7E0008); 	L R C LFE Ls Rs Lc Rc

(defconstant $kAudioChannelLayoutTag_MPEG_7_1_B #x7F0008); 	C Lc Rc L R Ls Rs LFE    (doc: IS-13818-7 MPEG2-AAC)

(defconstant $kAudioChannelLayoutTag_MPEG_7_1_C #x800008); 	L R C LFE Ls R Rls Rrs

(defconstant $kAudioChannelLayoutTag_Emagic_Default_7_1 #x810008); 	L R Ls Rs C LFE Lc Rc

(defconstant $kAudioChannelLayoutTag_SMPTE_DTV #x820008); 	L R C LFE Ls Rs Lt Rt
; 		(kAudioChannelLayoutTag_ITU_5_1 plus a matrix encoded stereo mix)
; 	ITU defined layouts

(defconstant $kAudioChannelLayoutTag_ITU_1_0 #x640001); 	C 

(defconstant $kAudioChannelLayoutTag_ITU_2_0 #x650002); 	L R 

(defconstant $kAudioChannelLayoutTag_ITU_2_1 #x830003); 	L R Cs

(defconstant $kAudioChannelLayoutTag_ITU_2_2 #x840004); 	L R Ls Rs

(defconstant $kAudioChannelLayoutTag_ITU_3_0 #x710003); 	L R C

(defconstant $kAudioChannelLayoutTag_ITU_3_1 #x730004); 	L R C Cs

(defconstant $kAudioChannelLayoutTag_ITU_3_2 #x750005); 	L R C Ls Rs

(defconstant $kAudioChannelLayoutTag_ITU_3_2_1 #x790006); 	L R C LFE Ls Rs

(defconstant $kAudioChannelLayoutTag_ITU_3_4_1 #x800008); 	L R C LFE Ls Rs Rls Rrs
;  DVD defined layouts

(defconstant $kAudioChannelLayoutTag_DVD_0 #x640001);  C (mono)

(defconstant $kAudioChannelLayoutTag_DVD_1 #x650002);  L R

(defconstant $kAudioChannelLayoutTag_DVD_2 #x830003);  L R Cs

(defconstant $kAudioChannelLayoutTag_DVD_3 #x840004);  L R Ls Rs

(defconstant $kAudioChannelLayoutTag_DVD_4 #x850003);  L R LFE

(defconstant $kAudioChannelLayoutTag_DVD_5 #x860004);  L R LFE Cs

(defconstant $kAudioChannelLayoutTag_DVD_6 #x870005);  L R LFE Ls Rs

(defconstant $kAudioChannelLayoutTag_DVD_7 #x710003);  L R C

(defconstant $kAudioChannelLayoutTag_DVD_8 #x730004);  L R C Cs

(defconstant $kAudioChannelLayoutTag_DVD_9 #x750005);  L R C Ls Rs

(defconstant $kAudioChannelLayoutTag_DVD_10 #x880004);  L R C LFE

(defconstant $kAudioChannelLayoutTag_DVD_11 #x890005);  L R C LFE Cs

(defconstant $kAudioChannelLayoutTag_DVD_12 #x790006);  L R C LFE Ls Rs
;  13 through 17 are duplicates of 8 through 12. 

(defconstant $kAudioChannelLayoutTag_DVD_13 #x730004);  L R C Cs

(defconstant $kAudioChannelLayoutTag_DVD_14 #x750005);  L R C Ls Rs

(defconstant $kAudioChannelLayoutTag_DVD_15 #x880004);  L R C LFE

(defconstant $kAudioChannelLayoutTag_DVD_16 #x890005);  L R C LFE Cs

(defconstant $kAudioChannelLayoutTag_DVD_17 #x790006);  L R C LFE Ls Rs

(defconstant $kAudioChannelLayoutTag_DVD_18 #x8A0005);  L R Ls Rs LFE

(defconstant $kAudioChannelLayoutTag_DVD_19 #x760005);  L R Ls Rs C

(defconstant $kAudioChannelLayoutTag_DVD_20 #x7A0006);  L R Ls Rs C LFE
;  These layouts are recommended for AudioUnit usage
;  These are the symmetrical layouts

(defconstant $kAudioChannelLayoutTag_AudioUnit_4 #x6C0004)
(defconstant $kAudioChannelLayoutTag_AudioUnit_5 #x6D0005)
(defconstant $kAudioChannelLayoutTag_AudioUnit_6 #x6E0006)
(defconstant $kAudioChannelLayoutTag_AudioUnit_8 #x6F0008);  These are the surround-based layouts

(defconstant $kAudioChannelLayoutTag_AudioUnit_5_0 #x760005);  L R Ls Rs C

(defconstant $kAudioChannelLayoutTag_AudioUnit_6_0 #x8B0006);  L R Ls Rs C Cs

(defconstant $kAudioChannelLayoutTag_AudioUnit_7_0 #x8C0007);  L R Ls Rs C Rls Rrs

(defconstant $kAudioChannelLayoutTag_AudioUnit_5_1 #x790006);  L R C LFE Ls Rs 

(defconstant $kAudioChannelLayoutTag_AudioUnit_6_1 #x7D0007);  L R C LFE Ls Rs Cs

(defconstant $kAudioChannelLayoutTag_AudioUnit_7_1 #x800008);  L R C LFE Ls Rs Rls Rrs

(defconstant $kAudioChannelLayoutTag_AAC_Quadraphonic #x6C0004);  L R Ls Rs

(defconstant $kAudioChannelLayoutTag_AAC_4_0 #x740004);  C L R Cs	

(defconstant $kAudioChannelLayoutTag_AAC_5_0 #x780005);  C L R Ls Rs

(defconstant $kAudioChannelLayoutTag_AAC_5_1 #x7C0006);  C L R Ls Rs Lfe

(defconstant $kAudioChannelLayoutTag_AAC_6_0 #x8D0006);  C L R Ls Rs Cs				

(defconstant $kAudioChannelLayoutTag_AAC_6_1 #x8E0007);  C L R Ls Rs Cs Lfe

(defconstant $kAudioChannelLayoutTag_AAC_7_0 #x8F0007);  C L R Ls Rs Rls Rrs			

(defconstant $kAudioChannelLayoutTag_AAC_7_1 #x7F0008);  C Lc Rc L R Ls Rs Lfe

(defconstant $kAudioChannelLayoutTag_AAC_Octagonal #x900008);  C L R Ls Rs Rls Rrs Cs                            

(defconstant $kAudioChannelLayoutTag_TMH_10_2_std #x910010);  L R C Vhc Lsd Rsd Ls Rs Vhl Vhr Lw Rw Csd Cs LFE1 LFE2                           
;  TMH_10_2_std plus: Lc Rc HI VI Haptic                            

(defconstant $kAudioChannelLayoutTag_TMH_10_2_full #x920015)

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


(provide-interface "CoreAudioTypes")