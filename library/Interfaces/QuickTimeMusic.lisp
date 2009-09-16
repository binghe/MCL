(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QuickTimeMusic.h"
; at Sunday July 2,2006 7:30:09 pm.
; 
;      File:       QuickTime/QuickTimeMusic.h
;  
;      Contains:   QuickTime Interfaces.
;  
;      Version:    QuickTime_6
;  
;      Copyright:  © 1990-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __QUICKTIMEMUSIC__
; #define __QUICKTIMEMUSIC__
; #ifndef __CARBON__
#| #|
#include <CarbonCarbon.h>
#endif
|#
 |#
; #ifndef __IMAGECOMPRESSION__
#| #|
#include <QuickTimeImageCompression.h>
#endif
|#
 |#
; #ifndef __MOVIES__
#| #|
#include <QuickTimeMovies.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

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
; #pragma options align=mac68k

(defconstant $kaiToneDescType :|tone|)
(defconstant $kaiNoteRequestInfoType :|ntrq|)
(defconstant $kaiKnobListType :|knbl|)
(defconstant $kaiKeyRangeInfoType :|sinf|)
(defconstant $kaiSampleDescType :|sdsc|)
(defconstant $kaiSampleInfoType :|smin|)
(defconstant $kaiSampleDataType :|sdat|)
(defconstant $kaiSampleDataQUIDType :|quid|)
(defconstant $kaiInstInfoType :|iinf|)
(defconstant $kaiPictType :|pict|)              ; '©wrt' 

(defconstant $kaiWriterType #xA9777274)         ; '©cpy' 

(defconstant $kaiCopyrightType #xA9637079)
(defconstant $kaiOtherStrType :|str |)
(defconstant $kaiInstrumentRefType :|iref|)
(defconstant $kaiInstGMQualityType :|qual|)
(defconstant $kaiLibraryInfoType :|linf|)
(defconstant $kaiLibraryDescType :|ldsc|)
(defrecord InstLibDescRec
   (libIDName (:string 31))
)

;type name? (%define-record :InstLibDescRec (find-record-descriptor ':InstLibDescRec))
(defrecord InstKnobRec
   (number :signed-long)
   (value :signed-long)
)

;type name? (%define-record :InstKnobRec (find-record-descriptor ':InstKnobRec))

(defconstant $kInstKnobMissingUnknown 0)
(defconstant $kInstKnobMissingDefault 1)
(defrecord InstKnobList
   (knobCount :signed-long)
   (knobFlags :signed-long)
   (knob (:array :InstKnobRec 1))
)

;type name? (%define-record :InstKnobList (find-record-descriptor ':InstKnobList))

(defconstant $kMusicLoopTypeNormal 0)
(defconstant $kMusicLoopTypePalindrome 1)       ;  back & forth


(defconstant $instSamplePreProcessFlag 1)
(defrecord InstSampleDescRec
   (dataFormat :OSType)
   (numChannels :signed-integer)
   (sampleSize :signed-integer)
   (sampleRate :unsigned-long)
   (sampleDataID :signed-integer)
   (offset :signed-long)                        ;  offset within SampleData - this could be just for internal use
   (numSamples :signed-long)                    ;  this could also just be for internal use, we'll see
   (loopType :signed-long)
   (loopStart :signed-long)
   (loopEnd :signed-long)
   (pitchNormal :signed-long)
   (pitchLow :signed-long)
   (pitchHigh :signed-long)
)

;type name? (%define-record :InstSampleDescRec (find-record-descriptor ':InstSampleDescRec))

(def-mactype :AtomicInstrument (find-mactype ':Handle))

(def-mactype :AtomicInstrumentPtr (find-mactype ':pointer))

(defconstant $kQTMIDIComponentType :|midi|)

(defconstant $kOMSComponentSubType :|OMS |)
(defconstant $kFMSComponentSubType :|FMS |)
(defconstant $kMIDIManagerComponentSubType :|mmgr|)
(defconstant $kOSXMIDIComponentSubType :|osxm|)

(def-mactype :QTMIDIComponent (find-mactype ':ComponentInstance))

(defconstant $kMusicPacketPortLost 1)           ;  received when application loses the default input port 

(defconstant $kMusicPacketPortFound 2)          ;  received when application gets it back out from under someone else's claim 

(defconstant $kMusicPacketTimeGap 3)            ;  data[0] = number of milliseconds to keep the MIDI line silent 


(defconstant $kAppleSysexID 17)                 ;  apple sysex is followed by 2-byte command. 0001 is the command for samplesize 

(defconstant $kAppleSysexCmdSampleSize 1)       ;  21 bit number in 3 midi bytes follows sysex ID and 2 cmd bytes 

(defconstant $kAppleSysexCmdSampleBreak 2)      ;  specifies that the sample should break right here 

(defconstant $kAppleSysexCmdAtomicInstrument 16);  contents of atomic instrument handle 

(defconstant $kAppleSysexCmdDeveloper #x7F00)   ;  F0 11 7F 00 ww xx yy zz ... F7 is available for non-Apple developers, where wxyz is unique app signature with 8th bit cleared, unique to developer, and 00 and 7f are reserved 

(defrecord MusicMIDIPacket
   (length :UInt16)
   (reserved :UInt32)                           ;  if length zero, then reserved = above enum 
   (data (:array :UInt8 249))
)

;type name? (%define-record :MusicMIDIPacket (find-record-descriptor ':MusicMIDIPacket))

(def-mactype :MusicMIDISendProcPtr (find-mactype ':pointer)); (ComponentInstance self , long refCon , MusicMIDIPacket * mmp)

(def-mactype :MusicMIDISendUPP (find-mactype '(:pointer :OpaqueMusicMIDISendProcPtr)))

(defconstant $kSynthesizerConnectionFMS 1)      ;  this connection imported from FMS 

(defconstant $kSynthesizerConnectionMMgr 2)     ;  this connection imported from the MIDI Mgr 

(defconstant $kSynthesizerConnectionOMS 4)      ;  this connection imported from OMS 

(defconstant $kSynthesizerConnectionQT 8)       ;  this connection is a QuickTime-only port 

(defconstant $kSynthesizerConnectionOSXMIDI 16) ;  this connection is an OS X CoreMIDI port 
;  lowest five bits are mutually exclusive; combinations reserved for future use.

(defconstant $kSynthesizerConnectionUnavailable #x100);  port exists, but cannot be used just now 

; 
;     The sampleBankFile field of this structure can be used to pass in a pointer to an FSSpec
;     that represents a SoundFont 2 or DLS file (otherwise set it to NULL ).
;     
;     You then pass in a structure with this field set (all other fields should be zero) to
;     NARegisterMusicDevice:
;         - with synthType as kSoftSynthComponentSubType 
;         - with name being used to return to the application the "name" of the synth 
;         that should be used in the synthesiserName field of the ToneDescription structure
;         and is also used to retrieve a particular MusicComponent with the
;         NAGetRegisteredMusicDevice call
;     
;     This call will create a MusicComponent of kSoftSynthComponentSubType, with the specified
;     sound bank as the sample data source.
; 
;     This field requires QuickTime 5.0 or later and should be set to NULL for prior versions.
; 
(defrecord SynthesizerConnections
   (clientID :OSType)
   (inputPortID :OSType)                        ;  terminology death: this port is used to SEND to the midi synth 
   (outputPortID :OSType)                       ;  terminology death: this port receives from a keyboard or other control device 
   (midiChannel :signed-long)                   ;  The system channel; others are configurable (or the nubus slot number) 
   (flags :signed-long)
   (unique :signed-long)                        ;  unique id may be used instead of index, to getinfo and unregister calls 
   (sampleBankFile (:pointer :FSSpec))          ;   see notes above 
   (reserved2 :signed-long)                     ;  should be zero 
)

;type name? (%define-record :SynthesizerConnections (find-record-descriptor ':SynthesizerConnections))
(defrecord QTMIDIPort
   (portConnections :SynthesizerConnections)
   (portName (:string 63))
)

;type name? (%define-record :QTMIDIPort (find-record-descriptor ':QTMIDIPort))
(defrecord QTMIDIPortList
   (portCount :SInt16)
   (port (:array :QTMIDIPort 1))
)

;type name? (%define-record :QTMIDIPortList (find-record-descriptor ':QTMIDIPortList))

(def-mactype :QTMIDIPortListPtr (find-mactype '(:pointer :QTMIDIPortList)))

(def-mactype :QTMIDIPortListHandle (find-mactype '(:handle :QTMIDIPortList)))
; 
;  *  QTMIDIGetMIDIPorts()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTMIDIGetMIDIPorts" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inputPorts (:pointer :QTMIDIPORTLISTHANDLE))
    (outputPorts (:pointer :QTMIDIPORTLISTHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTMIDIUseSendPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTMIDIUseSendPort" 
   ((ci (:pointer :ComponentInstanceRecord))
    (portIndex :signed-long)
    (inUse :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTMIDISendMIDI()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTMIDISendMIDI" 
   ((ci (:pointer :ComponentInstanceRecord))
    (portIndex :signed-long)
    (mp (:pointer :MusicMIDIPacket))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(defconstant $kMusicComponentType :|musi|)
(defconstant $kInstrumentComponentType :|inst|)

(defconstant $kSoftSynthComponentSubType :|ss  |)
(defconstant $kGMSynthComponentSubType :|gm  |)

(def-mactype :MusicComponent (find-mactype ':ComponentInstance))
;  MusicSynthesizerFlags

(defconstant $kSynthesizerDynamicVoice 1)       ;  can assign voices on the fly (else, polyphony is very important 

(defconstant $kSynthesizerUsesMIDIPort 2)       ;  must be patched through MIDI Manager 

(defconstant $kSynthesizerMicrotone 4)          ;  can play microtonal scales 

(defconstant $kSynthesizerHasSamples 8)         ;  synthesizer has some use for sampled data 

(defconstant $kSynthesizerMixedDrums 16)        ;  any part can play drum parts, total = instrument parts 

(defconstant $kSynthesizerSoftware 32)          ;  implemented in main CPU software == uses cpu cycles 

(defconstant $kSynthesizerHardware 64)          ;  is a hardware device (such as nubus, or maybe DSP?) 

(defconstant $kSynthesizerDynamicChannel #x80)  ;  can move any part to any channel or disable each part. (else we assume it lives on all channels in masks) 

(defconstant $kSynthesizerHogsSystemChannel #x100);  can be channelwise dynamic, but always responds on its system channel 

(defconstant $kSynthesizerHasSystemChannel #x200);  has some "system channel" notion to distinguish it from multiple instances of the same device (GM devices dont) 

(defconstant $kSynthesizerSlowSetPart #x400)    ;  SetPart() and SetPartInstrumentNumber() calls do not have rapid response, may glitch notes 

(defconstant $kSynthesizerOffline #x1000)       ;  can enter an offline synthesis mode 

(defconstant $kSynthesizerGM #x4000)            ;  synth is a GM device 

(defconstant $kSynthesizerDLS #x8000)           ;  synth supports DLS level 1 
;  synth supports extremely baroque, nonstandard, and proprietary "apple game sprockets" localization parameter set 

(defconstant $kSynthesizerSoundLocalization #x10000)
; 
;  * Note that these controller numbers
;  * are _not_ identical to the MIDI controller numbers.
;  * These are _signed_ 8.8 values, and the LSB's are
;  * always sent to a MIDI device. Controllers 32-63 are
;  * reserved (for MIDI, they are LSB's for 0-31, but we
;  * always send both).
;  *
;  * The full range, therefore, is -128.00 to 127.7f.
;  *
;  * _Excepting_ _volume_, all controls default to zero.
;  *
;  * Pitch bend is specified in fractional semitones! No
;  * more "pitch bend range" nonsense. You can bend as far
;  * as you want, any time you want.
;  

(def-mactype :MusicController (find-mactype ':SInt32))

(defconstant $kControllerModulationWheel 1)
(defconstant $kControllerBreath 2)
(defconstant $kControllerFoot 4)
(defconstant $kControllerPortamentoTime 5)      ;  time in 8.8 seconds, portamento on/off is omitted, 0 time = 'off' 

(defconstant $kControllerVolume 7)              ;  main volume control 

(defconstant $kControllerBalance 8)
(defconstant $kControllerPan 10)                ;  0 - "default", 1 - n: positioned in output 1-n (incl fractions) 

(defconstant $kControllerExpression 11)         ;  secondary volume control 

(defconstant $kControllerLever1 16)             ;  general purpose controllers 

(defconstant $kControllerLever2 17)             ;  general purpose controllers 

(defconstant $kControllerLever3 18)             ;  general purpose controllers 

(defconstant $kControllerLever4 19)             ;  general purpose controllers 

(defconstant $kControllerLever5 80)             ;  general purpose controllers 

(defconstant $kControllerLever6 81)             ;  general purpose controllers 

(defconstant $kControllerLever7 82)             ;  general purpose controllers 

(defconstant $kControllerLever8 83)             ;  general purpose controllers 

(defconstant $kControllerPitchBend 32)          ;  positive & negative semitones, with 8 bits fraction, same units as transpose controllers

(defconstant $kControllerAfterTouch 33)         ;  aka channel pressure 

(defconstant $kControllerPartTranspose 40)      ;  identical to pitchbend, for overall part xpose 

(defconstant $kControllerTuneTranspose 41)      ;  another pitchbend, for "song global" pitch offset 

(defconstant $kControllerPartVolume 42)         ;  another volume control, passed right down from note allocator part volume 

(defconstant $kControllerTuneVolume 43)         ;  another volume control, used for "song global" volume - since we share one synthesizer across multiple tuneplayers

(defconstant $kControllerSustain 64)            ;  boolean - positive for on, 0 or negative off 

(defconstant $kControllerPortamento 65)         ;  boolean

(defconstant $kControllerSostenuto 66)          ;  boolean 

(defconstant $kControllerSoftPedal 67)          ;  boolean 

(defconstant $kControllerReverb 91)
(defconstant $kControllerTremolo 92)
(defconstant $kControllerChorus 93)
(defconstant $kControllerCeleste 94)
(defconstant $kControllerPhaser 95)
(defconstant $kControllerEditPart 113)          ;  last 16 controllers 113-128 and above are global controllers which respond on part zero 

(defconstant $kControllerMasterTune 114)
(defconstant $kControllerMasterTranspose 114)   ;  preferred

(defconstant $kControllerMasterVolume 115)
(defconstant $kControllerMasterCPULoad 116)
(defconstant $kControllerMasterPolyphony 117)
(defconstant $kControllerMasterFeatures 118)
;  ID's of knobs supported by the QuickTime Music Synthesizer built into QuickTime

(defconstant $kQTMSKnobStartID #x2000000)
(defconstant $kQTMSKnobVolumeAttackTimeID #x2000001)
(defconstant $kQTMSKnobVolumeDecayTimeID #x2000002)
(defconstant $kQTMSKnobVolumeSustainLevelID #x2000003)
(defconstant $kQTMSKnobVolumeRelease1RateID #x2000004)
(defconstant $kQTMSKnobVolumeDecayKeyScalingID #x2000005)
(defconstant $kQTMSKnobVolumeReleaseTimeID #x2000006)
(defconstant $kQTMSKnobVolumeLFODelayID #x2000007)
(defconstant $kQTMSKnobVolumeLFORampTimeID #x2000008)
(defconstant $kQTMSKnobVolumeLFOPeriodID #x2000009)
(defconstant $kQTMSKnobVolumeLFOShapeID #x200000A)
(defconstant $kQTMSKnobVolumeLFODepthID #x200000B)
(defconstant $kQTMSKnobVolumeOverallID #x200000C)
(defconstant $kQTMSKnobVolumeVelocity127ID #x200000D)
(defconstant $kQTMSKnobVolumeVelocity96ID #x200000E)
(defconstant $kQTMSKnobVolumeVelocity64ID #x200000F)
(defconstant $kQTMSKnobVolumeVelocity32ID #x2000010)
(defconstant $kQTMSKnobVolumeVelocity16ID #x2000011);  Pitch related knobs

(defconstant $kQTMSKnobPitchTransposeID #x2000012)
(defconstant $kQTMSKnobPitchLFODelayID #x2000013)
(defconstant $kQTMSKnobPitchLFORampTimeID #x2000014)
(defconstant $kQTMSKnobPitchLFOPeriodID #x2000015)
(defconstant $kQTMSKnobPitchLFOShapeID #x2000016)
(defconstant $kQTMSKnobPitchLFODepthID #x2000017)
(defconstant $kQTMSKnobPitchLFOQuantizeID #x2000018);  Stereo related knobs

(defconstant $kQTMSKnobStereoDefaultPanID #x2000019)
(defconstant $kQTMSKnobStereoPositionKeyScalingID #x200001A)
(defconstant $kQTMSKnobPitchLFOOffsetID #x200001B)
(defconstant $kQTMSKnobExclusionGroupID #x200001C);  Misc knobs, late additions

(defconstant $kQTMSKnobSustainTimeID #x200001D)
(defconstant $kQTMSKnobSustainInfiniteID #x200001E)
(defconstant $kQTMSKnobVolumeLFOStereoID #x200001F)
(defconstant $kQTMSKnobVelocityLowID #x2000020)
(defconstant $kQTMSKnobVelocityHighID #x2000021)
(defconstant $kQTMSKnobVelocitySensitivityID #x2000022)
(defconstant $kQTMSKnobPitchSensitivityID #x2000023)
(defconstant $kQTMSKnobVolumeLFODepthFromWheelID #x2000024)
(defconstant $kQTMSKnobPitchLFODepthFromWheelID #x2000025);  Volume Env again

(defconstant $kQTMSKnobVolumeExpOptionsID #x2000026);  Env1

(defconstant $kQTMSKnobEnv1AttackTimeID #x2000027)
(defconstant $kQTMSKnobEnv1DecayTimeID #x2000028)
(defconstant $kQTMSKnobEnv1SustainLevelID #x2000029)
(defconstant $kQTMSKnobEnv1SustainTimeID #x200002A)
(defconstant $kQTMSKnobEnv1SustainInfiniteID #x200002B)
(defconstant $kQTMSKnobEnv1ReleaseTimeID #x200002C)
(defconstant $kQTMSKnobEnv1ExpOptionsID #x200002D);  Env2

(defconstant $kQTMSKnobEnv2AttackTimeID #x200002E)
(defconstant $kQTMSKnobEnv2DecayTimeID #x200002F)
(defconstant $kQTMSKnobEnv2SustainLevelID #x2000030)
(defconstant $kQTMSKnobEnv2SustainTimeID #x2000031)
(defconstant $kQTMSKnobEnv2SustainInfiniteID #x2000032)
(defconstant $kQTMSKnobEnv2ReleaseTimeID #x2000033)
(defconstant $kQTMSKnobEnv2ExpOptionsID #x2000034);  Pitch Env

(defconstant $kQTMSKnobPitchEnvelopeID #x2000035)
(defconstant $kQTMSKnobPitchEnvelopeDepthID #x2000036);  Filter

(defconstant $kQTMSKnobFilterKeyFollowID #x2000037)
(defconstant $kQTMSKnobFilterTransposeID #x2000038)
(defconstant $kQTMSKnobFilterQID #x2000039)
(defconstant $kQTMSKnobFilterFrequencyEnvelopeID #x200003A)
(defconstant $kQTMSKnobFilterFrequencyEnvelopeDepthID #x200003B)
(defconstant $kQTMSKnobFilterQEnvelopeID #x200003C)
(defconstant $kQTMSKnobFilterQEnvelopeDepthID #x200003D);  Reverb Threshhold

(defconstant $kQTMSKnobReverbThresholdID #x200003E)
(defconstant $kQTMSKnobVolumeAttackVelScalingID #x200003F)
(defconstant $kQTMSKnobLastIDPlus1 #x2000040)

(defconstant $kControllerMaximum #x7FFF)        ;  +01111111.11111111 
;  -10000000.00000000 

(defconstant $kControllerMinimum #xFFFF8000)
(defrecord SynthesizerDescription
   (synthesizerType :OSType)                    ;  synthesizer type (must be same as component subtype) 
   (name (:string 31))                          ;  text name of synthesizer type 
   (flags :UInt32)                              ;  from the above enum 
   (voiceCount :UInt32)                         ;  maximum polyphony 
   (partCount :UInt32)                          ;  maximum multi-timbrality (and midi channels) 
   (instrumentCount :UInt32)                    ;  non gm, built in (rom) instruments only 
   (modifiableInstrumentCount :UInt32)          ;  plus n-more are user modifiable 
   (channelMask :UInt32)                        ;  (midi device only) which channels device always uses 
   (drumPartCount :UInt32)                      ;  maximum multi-timbrality of drum parts 
   (drumCount :UInt32)                          ;  non gm, built in (rom) drumkits only 
   (modifiableDrumCount :UInt32)                ;  plus n-more are user modifiable 
   (drumChannelMask :UInt32)                    ;  (midi device only) which channels device always uses 
   (outputCount :UInt32)                        ;  number of audio outputs (usually two) 
   (latency :UInt32)                            ;  response time in µSec 
   (controllers (:array :UInt32 4))             ;  array of 128 bits 
   (gmInstruments (:array :UInt32 4))           ;  array of 128 bits 
   (gmDrums (:array :UInt32 4))                 ;  array of 128 bits 
)

;type name? (%define-record :SynthesizerDescription (find-record-descriptor ':SynthesizerDescription))
;  constant to use to specify dynamic voicing 

(defconstant $kVoiceCountDynamic -1)
(defrecord ToneDescription
   (synthesizerType :OSType)                    ;  synthesizer type 
   (synthesizerName (:string 31))               ;  name of instantiation of synth 
   (instrumentName (:string 31))                ;  preferred name for human use 
   (instrumentNumber :signed-long)              ;  inst-number used if synth-name matches 
   (gmNumber :signed-long)                      ;  Best matching general MIDI number 
)

;type name? (%define-record :ToneDescription (find-record-descriptor ':ToneDescription))

(defconstant $kFirstGMInstrument 1)
(defconstant $kLastGMInstrument #x80)
(defconstant $kFirstGSInstrument #x81)
(defconstant $kLastGSInstrument #x3FFF)
(defconstant $kFirstDrumkit #x4000)             ;  (first value is "no drum". instrument numbers from 16384->16384+128 are drumkits, and for GM they are _defined_ drumkits! 

(defconstant $kLastDrumkit #x4080)
(defconstant $kFirstROMInstrument #x8000)
(defconstant $kLastROMInstrument #xFFFF)
(defconstant $kFirstUserInstrument #x10000)
(defconstant $kLastUserInstrument #x1FFFF)
;  InstrumentMatch

(defconstant $kInstrumentMatchSynthesizerType 1)
(defconstant $kInstrumentMatchSynthesizerName 2)
(defconstant $kInstrumentMatchName 4)
(defconstant $kInstrumentMatchNumber 8)
(defconstant $kInstrumentMatchGMNumber 16)
(defconstant $kInstrumentMatchGSNumber 32)
;  KnobFlags

(defconstant $kKnobBasic 8)                     ;  knob shows up in certain simplified lists of knobs 

(defconstant $kKnobReadOnly 16)                 ;  knob value cannot be changed by user or with a SetKnob call 

(defconstant $kKnobInterruptUnsafe 32)          ;  only alter this knob from foreground task time (may access toolbox) 

(defconstant $kKnobKeyrangeOverride 64)         ;  knob can be overridden within a single keyrange (software synth only) 

(defconstant $kKnobGroupStart #x80)             ;  knob is first in some logical group of knobs 

(defconstant $kKnobFixedPoint8 #x400)
(defconstant $kKnobFixedPoint16 #x800)          ;  One of these may be used at a time. 

(defconstant $kKnobTypeNumber 0)
(defconstant $kKnobTypeGroupName #x1000)        ;  "knob" is really a group name for display purposes 

(defconstant $kKnobTypeBoolean #x2000)          ;  if range is greater than 1, its a multi-checkbox field 

(defconstant $kKnobTypeNote #x3000)             ;  knob range is equivalent to MIDI keys 

(defconstant $kKnobTypePan #x4000)              ;  range goes left/right (lose this? ) 

(defconstant $kKnobTypeInstrument #x5000)       ;  knob value = reference to another instrument number 

(defconstant $kKnobTypeSetting #x6000)          ;  knob value is 1 of n different things (eg, fm algorithms) popup menu 

(defconstant $kKnobTypeMilliseconds #x7000)     ;  knob is a millisecond time range 

(defconstant $kKnobTypePercentage #x8000)       ;  knob range is displayed as a Percentage 

(defconstant $kKnobTypeHertz #x9000)            ;  knob represents frequency 
;  momentary trigger push button 

(defconstant $kKnobTypeButton #xA000)

(defconstant $kUnknownKnobValue #x7FFFFFFF)     ;  a knob with this value means, we don't know it. 

(defconstant $kDefaultKnobValue #x7FFFFFFE)     ;  used to SET a knob to its default value. 

(defrecord KnobDescription
   (name (:string 63))
   (lowValue :signed-long)
   (highValue :signed-long)
   (defaultValue :signed-long)                  ;  a default instrument is made of all default values 
   (flags :signed-long)
   (knobID :signed-long)
)

;type name? (%define-record :KnobDescription (find-record-descriptor ':KnobDescription))
(defrecord GCInstrumentData
   (tone :ToneDescription)
   (knobCount :signed-long)
   (knob (:array :signed-long 1))
)

;type name? (%define-record :GCInstrumentData (find-record-descriptor ':GCInstrumentData))

(def-mactype :GCInstrumentDataPtr (find-mactype '(:pointer :GCInstrumentData)))

(def-mactype :GCInstrumentDataHandle (find-mactype '(:handle :GCInstrumentData)))
(defrecord InstrumentAboutInfo
   (p (:Handle :Picture))
   (author (:string 255))
   (copyright (:string 255))
   (other (:string 255))
)

;type name? (%define-record :InstrumentAboutInfo (find-record-descriptor ':InstrumentAboutInfo))

(defconstant $notImplementedMusicErr #x8000F7E9)
(defconstant $cantSendToSynthesizerErr #x8000F7E8)
(defconstant $cantReceiveFromSynthesizerErr #x8000F7E7)
(defconstant $illegalVoiceAllocationErr #x8000F7E6)
(defconstant $illegalPartErr #x8000F7E5)
(defconstant $illegalChannelErr #x8000F7E4)
(defconstant $illegalKnobErr #x8000F7E3)
(defconstant $illegalKnobValueErr #x8000F7E2)
(defconstant $illegalInstrumentErr #x8000F7E1)
(defconstant $illegalControllerErr #x8000F7E0)
(defconstant $midiManagerAbsentErr #x8000F7DF)
(defconstant $synthesizerNotRespondingErr #x8000F7DE)
(defconstant $synthesizerErr #x8000F7DD)
(defconstant $illegalNoteChannelErr #x8000F7DC)
(defconstant $noteChannelNotAllocatedErr #x8000F7DB)
(defconstant $tunePlayerFullErr #x8000F7DA)
(defconstant $tuneParseErr #x8000F7D9)

(defconstant $kGetAtomicInstNoExpandedSamples 1)
(defconstant $kGetAtomicInstNoOriginalSamples 2)
(defconstant $kGetAtomicInstNoSamples 3)
(defconstant $kGetAtomicInstNoKnobList 4)
(defconstant $kGetAtomicInstNoInstrumentInfo 8)
(defconstant $kGetAtomicInstOriginalKnobList 16);  return even those that are set to default

(defconstant $kGetAtomicInstAllKnobs 32)
; 
;    For non-gm instruments, instrument number of tone description == 0
;    If you want to speed up while running, slam the inst num with what Get instrument number returns
;    All missing knobs are slammed to the default value
; 

(defconstant $kSetAtomicInstKeepOriginalInstrument 1)
(defconstant $kSetAtomicInstShareAcrossParts 2) ;  inst disappears when app goes away

(defconstant $kSetAtomicInstCallerTosses 4)     ;  the caller isn't keeping a copy around (for NASetAtomicInstrument)

(defconstant $kSetAtomicInstCallerGuarantees 8) ;  the caller guarantees a copy is around

(defconstant $kSetAtomicInstInterruptSafe 16)   ;  dont move memory at this time (but process at next task time)
;  perform no further preprocessing because either 1)you know the instrument is digitally clean, or 2) you got it from a GetPartAtomic

(defconstant $kSetAtomicInstDontPreprocess #x80)

(defconstant $kInstrumentNamesModifiable 1)
(defconstant $kInstrumentNamesBoth 2)
; 
;  * Structures specific to the GenericMusicComponent
;  

(defconstant $kGenericMusicComponentSubtype :|gene|)
(defrecord GenericKnobDescription
   (kd :KnobDescription)
   (hw1 :signed-long)                           ;  driver defined 
   (hw2 :signed-long)                           ;  driver defined 
   (hw3 :signed-long)                           ;  driver defined 
   (settingsID :signed-long)                    ;  resource ID list for boolean and popup names 
)

;type name? (%define-record :GenericKnobDescription (find-record-descriptor ':GenericKnobDescription))
(defrecord GenericKnobDescriptionList
   (knobCount :signed-long)
   (knob (:array :GenericKnobDescription 1))
)

;type name? (%define-record :GenericKnobDescriptionList (find-record-descriptor ':GenericKnobDescriptionList))

(def-mactype :GenericKnobDescriptionListPtr (find-mactype '(:pointer :GenericKnobDescriptionList)))

(def-mactype :GenericKnobDescriptionListHandle (find-mactype '(:handle :GenericKnobDescriptionList)))
;  knobTypes for MusicDerivedSetKnob 

(defconstant $kGenericMusicKnob 1)
(defconstant $kGenericMusicInstrumentKnob 2)
(defconstant $kGenericMusicDrumKnob 3)
(defconstant $kGenericMusicGlobalController 4)

(defconstant $kGenericMusicResFirst 0)
(defconstant $kGenericMusicResMiscStringList 1) ;  STR# 1: synth name, 2:about author,3:aboutcopyright,4:aboutother 

(defconstant $kGenericMusicResMiscLongList 2)   ;  Long various params, see list below 

(defconstant $kGenericMusicResInstrumentList 3) ;  NmLs of names and shorts, categories prefixed by '¥¥' 

(defconstant $kGenericMusicResDrumList 4)       ;  NmLs of names and shorts 

(defconstant $kGenericMusicResInstrumentKnobDescriptionList 5);  Knob 

(defconstant $kGenericMusicResDrumKnobDescriptionList 6);  Knob 

(defconstant $kGenericMusicResKnobDescriptionList 7);  Knob 

(defconstant $kGenericMusicResBitsLongList 8)   ;  Long back to back bitmaps of controllers, gminstruments, and drums 

(defconstant $kGenericMusicResModifiableInstrumentHW 9);  Shrt same as the hw shorts trailing the instrument names, a shortlist 

(defconstant $kGenericMusicResGMTranslation 10) ;  Long 128 long entries, 1 for each gm inst, of local instrument numbers 1-n (not hw numbers) 

(defconstant $kGenericMusicResROMInstrumentData 11);  knob lists for ROM instruments, so the knob values may be known 

(defconstant $kGenericMusicResAboutPICT 12)     ;  picture for aboutlist. must be present for GetAbout call to work 

(defconstant $kGenericMusicResLast 13)
;  elements of the misc long list 

(defconstant $kGenericMusicMiscLongFirst 0)
(defconstant $kGenericMusicMiscLongVoiceCount 1)
(defconstant $kGenericMusicMiscLongPartCount 2)
(defconstant $kGenericMusicMiscLongModifiableInstrumentCount 3)
(defconstant $kGenericMusicMiscLongChannelMask 4)
(defconstant $kGenericMusicMiscLongDrumPartCount 5)
(defconstant $kGenericMusicMiscLongModifiableDrumCount 6)
(defconstant $kGenericMusicMiscLongDrumChannelMask 7)
(defconstant $kGenericMusicMiscLongOutputCount 8)
(defconstant $kGenericMusicMiscLongLatency 9)
(defconstant $kGenericMusicMiscLongFlags 10)
(defconstant $kGenericMusicMiscLongFirstGMHW 11);  number to add to locate GM main instruments 

(defconstant $kGenericMusicMiscLongFirstGMDrumHW 12);  number to add to locate GM drumkits 

(defconstant $kGenericMusicMiscLongFirstUserHW 13);  First hw number of user instruments (presumed sequential) 

(defconstant $kGenericMusicMiscLongLast 14)
(defrecord GCPart
   (hwInstrumentNumber :signed-long)            ;  internal number of recalled instrument 
   (controller (:array :SInt16 128))            ;  current values for all controllers 
   (volume :signed-long)                        ;  ctrl 7 is special case 
   (polyphony :signed-long)
   (midiChannel :signed-long)                   ;  1-16 if in use 
   (id :GCInstrumentData)                       ;  ToneDescription & knoblist, uncertain length 
)

;type name? (%define-record :GCPart (find-record-descriptor ':GCPart))
; 
;  * Calls specific to the GenericMusicComponent
;  

(defconstant $kMusicGenericRange #x100)
(defconstant $kMusicDerivedRange #x200)
; 
;  * Flags in GenericMusicConfigure call
;  

(defconstant $kGenericMusicDoMIDI 1)            ;  implement normal MIDI messages for note, controllers, and program changes 0-127 

(defconstant $kGenericMusicBank0 2)             ;  implement instrument bank changes on controller 0 

(defconstant $kGenericMusicBank32 4)            ;  implement instrument bank changes on controller 32 

(defconstant $kGenericMusicErsatzMIDI 8)        ;  construct MIDI packets, but send them to the derived component 

(defconstant $kGenericMusicCallKnobs 16)        ;  call the derived component with special knob format call 

(defconstant $kGenericMusicCallParts 32)        ;  call the derived component with special part format call 

(defconstant $kGenericMusicCallInstrument 64)   ;  call MusicDerivedSetInstrument for MusicSetInstrument calls 

(defconstant $kGenericMusicCallNumber #x80)     ;  call MusicDerivedSetPartInstrumentNumber for MusicSetPartInstrumentNumber calls, & don't send any C0 or bank stuff 

(defconstant $kGenericMusicCallROMInstrument #x100);  call MusicSetInstrument for MusicSetPartInstrumentNumber for "ROM" instruments, passing params from the ROMi resource 
;  indicates that when a new instrument is recalled, all knobs are reset to DEFAULT settings. True for GS modules 

(defconstant $kGenericMusicAllDefaults #x200)

(def-mactype :MusicOfflineDataProcPtr (find-mactype ':pointer)); (Ptr SoundData , long numBytes , long myRefCon)

(def-mactype :MusicOfflineDataUPP (find-mactype '(:pointer :OpaqueMusicOfflineDataProcPtr)))
(defrecord OfflineSampleType
   (numChannels :UInt32)                        ; number of channels,  ie mono = 1
   (sampleRate :UInt32)                         ; sample rate in Apples Fixed point representation
   (sampleSize :UInt16)                         ; number of bits in sample
)

;type name? (%define-record :OfflineSampleType (find-record-descriptor ':OfflineSampleType))
(defrecord InstrumentInfoRecord
   (instrumentNumber :signed-long)              ;  instrument number (if 0, name is a catagory)
   (flags :signed-long)                         ;  show in picker, etc.
   (toneNameIndex :signed-long)                 ;  index in toneNames (1 based)
   (itxtNameAtomID :signed-long)                ;  index in itxtNames (itxt/name by index)
)

;type name? (%define-record :InstrumentInfoRecord (find-record-descriptor ':InstrumentInfoRecord))
(defrecord InstrumentInfoList
   (recordCount :signed-long)
   (toneNames :Handle)                          ;  name from tone description
   (itxtNames :Handle)                          ;  itxt/name atoms for instruments
   (info (:array :InstrumentInfoRecord 1))
)

;type name? (%define-record :InstrumentInfoList (find-record-descriptor ':InstrumentInfoList))

(def-mactype :InstrumentInfoListPtr (find-mactype '(:pointer :InstrumentInfoList)))

(def-mactype :InstrumentInfoListHandle (find-mactype '(:handle :InstrumentInfoList)))
; 
;  *  MusicGetDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetDescription" 
   ((mc (:pointer :ComponentInstanceRecord))
    (sd (:pointer :SynthesizerDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetPart()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetPart" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (midiChannel (:pointer :long))
    (polyphony (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicSetPart()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicSetPart" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (midiChannel :signed-long)
    (polyphony :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicSetPartInstrumentNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicSetPartInstrumentNumber" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (instrumentNumber :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

; #if OLDROUTINENAMES
#| 
; #define MusicSetInstrumentNumber(ci,part,instrumentNumber) MusicSetPartInstrumentNumber(ci, part,instrumentNumber)
 |#

; #endif

; 
;  *  MusicGetPartInstrumentNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetPartInstrumentNumber" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicStorePartInstrument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicStorePartInstrument" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (instrumentNumber :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetPartAtomicInstrument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetPartAtomicInstrument" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (ai (:pointer :ATOMICINSTRUMENT))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicSetPartAtomicInstrument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicSetPartAtomicInstrument" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (aiP :pointer)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetPartKnob()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetPartKnob" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (knobID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicSetPartKnob()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicSetPartKnob" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (knobID :signed-long)
    (knobValue :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetKnob()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetKnob" 
   ((mc (:pointer :ComponentInstanceRecord))
    (knobID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicSetKnob()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicSetKnob" 
   ((mc (:pointer :ComponentInstanceRecord))
    (knobID :signed-long)
    (knobValue :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetPartName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetPartName" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (name (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicSetPartName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicSetPartName" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (name (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicFindTone()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicFindTone" 
   ((mc (:pointer :ComponentInstanceRecord))
    (td (:pointer :ToneDescription))
    (libraryIndexOut (:pointer :long))
    (fit (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicPlayNote()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicPlayNote" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (pitch :signed-long)
    (velocity :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicResetPart()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicResetPart" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicSetPartController()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicSetPartController" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (controllerNumber :SInt32)
    (controllerValue :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

; #if OLDROUTINENAMES
#| 
; #define MusicSetController(ci,part,controllerNumber,controllerValue) MusicSetPartController(ci, part,controllerNumber,controllerValue)
 |#

; #endif

; 
;  *  MusicGetPartController()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetPartController" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (controllerNumber :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetMIDIProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetMIDIProc" 
   ((mc (:pointer :ComponentInstanceRecord))
    (midiSendProc (:pointer :MUSICMIDISENDUPP))
    (refCon (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicSetMIDIProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicSetMIDIProc" 
   ((mc (:pointer :ComponentInstanceRecord))
    (midiSendProc (:pointer :OpaqueMusicMIDISendProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetInstrumentNames()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetInstrumentNames" 
   ((mc (:pointer :ComponentInstanceRecord))
    (modifiableInstruments :signed-long)
    (instrumentNames (:pointer :Handle))
    (instrumentCategoryLasts (:pointer :Handle))
    (instrumentCategoryNames (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetDrumNames()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetDrumNames" 
   ((mc (:pointer :ComponentInstanceRecord))
    (modifiableInstruments :signed-long)
    (instrumentNumbers (:pointer :Handle))
    (instrumentNames (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetMasterTune()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetMasterTune" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicSetMasterTune()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicSetMasterTune" 
   ((mc (:pointer :ComponentInstanceRecord))
    (masterTune :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetInstrumentAboutInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetInstrumentAboutInfo" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (iai (:pointer :InstrumentAboutInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetDeviceConnection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetDeviceConnection" 
   ((mc (:pointer :ComponentInstanceRecord))
    (index :signed-long)
    (id1 (:pointer :long))
    (id2 (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicUseDeviceConnection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicUseDeviceConnection" 
   ((mc (:pointer :ComponentInstanceRecord))
    (id1 :signed-long)
    (id2 :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetKnobSettingStrings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetKnobSettingStrings" 
   ((mc (:pointer :ComponentInstanceRecord))
    (knobIndex :signed-long)
    (isGlobal :signed-long)
    (settingsNames (:pointer :Handle))
    (settingsCategoryLasts (:pointer :Handle))
    (settingsCategoryNames (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetMIDIPorts()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetMIDIPorts" 
   ((mc (:pointer :ComponentInstanceRecord))
    (inputPortCount (:pointer :long))
    (outputPortCount (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicSendMIDI()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicSendMIDI" 
   ((mc (:pointer :ComponentInstanceRecord))
    (portIndex :signed-long)
    (mp (:pointer :MusicMIDIPacket))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicStartOffline()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicStartOffline" 
   ((mc (:pointer :ComponentInstanceRecord))
    (numChannels (:pointer :UInt32))
    (sampleRate (:pointer :UnsignedFixed))
    (sampleSize (:pointer :UInt16))
    (dataProc (:pointer :OpaqueMusicOfflineDataProcPtr))
    (dataProcRefCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicSetOfflineTimeTo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicSetOfflineTimeTo" 
   ((mc (:pointer :ComponentInstanceRecord))
    (newTimeStamp :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetInstrumentKnobDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetInstrumentKnobDescription" 
   ((mc (:pointer :ComponentInstanceRecord))
    (knobIndex :signed-long)
    (mkd (:pointer :KnobDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetDrumKnobDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetDrumKnobDescription" 
   ((mc (:pointer :ComponentInstanceRecord))
    (knobIndex :signed-long)
    (mkd (:pointer :KnobDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetKnobDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetKnobDescription" 
   ((mc (:pointer :ComponentInstanceRecord))
    (knobIndex :signed-long)
    (mkd (:pointer :KnobDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGetInfoText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetInfoText" 
   ((mc (:pointer :ComponentInstanceRecord))
    (selector :signed-long)
    (textH (:pointer :Handle))
    (styleH (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(defconstant $kGetInstrumentInfoNoBuiltIn 1)
(defconstant $kGetInstrumentInfoMidiUserInst 2)
(defconstant $kGetInstrumentInfoNoIText 4)
; 
;  *  MusicGetInstrumentInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGetInstrumentInfo" 
   ((mc (:pointer :ComponentInstanceRecord))
    (getInstrumentInfoFlags :signed-long)
    (infoListH (:pointer :INSTRUMENTINFOLISTHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicTask" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicSetPartInstrumentNumberInterruptSafe()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicSetPartInstrumentNumberInterruptSafe" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (instrumentNumber :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicSetPartSoundLocalization()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicSetPartSoundLocalization" 
   ((mc (:pointer :ComponentInstanceRecord))
    (part :signed-long)
    (data :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGenericConfigure()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGenericConfigure" 
   ((mc (:pointer :ComponentInstanceRecord))
    (mode :signed-long)
    (flags :signed-long)
    (baseResID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGenericGetPart()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGenericGetPart" 
   ((mc (:pointer :ComponentInstanceRecord))
    (partNumber :signed-long)
    (part (:pointer :GCPart))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGenericGetKnobList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGenericGetKnobList" 
   ((mc (:pointer :ComponentInstanceRecord))
    (knobType :signed-long)
    (gkdlH (:pointer :GENERICKNOBDESCRIPTIONLISTHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicGenericSetResourceNumbers()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicGenericSetResourceNumbers" 
   ((mc (:pointer :ComponentInstanceRecord))
    (resourceIDH :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicDerivedMIDISend()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicDerivedMIDISend" 
   ((mc (:pointer :ComponentInstanceRecord))
    (packet (:pointer :MusicMIDIPacket))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicDerivedSetKnob()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicDerivedSetKnob" 
   ((mc (:pointer :ComponentInstanceRecord))
    (knobType :signed-long)
    (knobNumber :signed-long)
    (knobValue :signed-long)
    (partNumber :signed-long)
    (p (:pointer :GCPart))
    (gkd (:pointer :GenericKnobDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicDerivedSetPart()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicDerivedSetPart" 
   ((mc (:pointer :ComponentInstanceRecord))
    (partNumber :signed-long)
    (p (:pointer :GCPart))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicDerivedSetInstrument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicDerivedSetInstrument" 
   ((mc (:pointer :ComponentInstanceRecord))
    (partNumber :signed-long)
    (p (:pointer :GCPart))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicDerivedSetPartInstrumentNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicDerivedSetPartInstrumentNumber" 
   ((mc (:pointer :ComponentInstanceRecord))
    (partNumber :signed-long)
    (p (:pointer :GCPart))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicDerivedSetMIDI()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicDerivedSetMIDI" 
   ((mc (:pointer :ComponentInstanceRecord))
    (midiProc (:pointer :OpaqueMusicMIDISendProcPtr))
    (refcon :signed-long)
    (midiChannel :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicDerivedStorePartInstrument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicDerivedStorePartInstrument" 
   ((mc (:pointer :ComponentInstanceRecord))
    (partNumber :signed-long)
    (p (:pointer :GCPart))
    (instrumentNumber :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicDerivedOpenResFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicDerivedOpenResFile" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MusicDerivedCloseResFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicDerivedCloseResFile" 
   ((mc (:pointer :ComponentInstanceRecord))
    (resRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; --------------------------
;     Types
; --------------------------

(defconstant $kNoteRequestNoGM 1)               ;  don't degrade to a GM synth 

(defconstant $kNoteRequestNoSynthType 2)        ;  don't degrade to another synth of same type but different name 

(defconstant $kNoteRequestSynthMustMatch 4)     ;  synthType must be a match, including kGMSynthComponentSubType 


(defconstant $kNoteRequestSpecifyMIDIChannel #x80)

(def-mactype :NoteAllocator (find-mactype ':ComponentInstance))
; 
;     The midiChannelAssignment field of this structure is used to assign a MIDI channel 
;     when a NoteChannel is created from a NoteRequest.
;     A value of 0 indicates a MIDI channel has *not* been assigned
;     A value of (kNoteRequestSpecifyMIDIChannel | 1->16) is a MIDI channel assignment
; 
;     This field requires QuickTime 5.0 or later and should be set to 0 for prior versions.
; 

(def-mactype :NoteRequestMIDIChannel (find-mactype ':UInt8))
(defrecord NoteRequestInfo
   (flags :UInt8)                               ;  1: dont accept GM match, 2: dont accept same-synth-type match 
   (midiChannelAssignment :UInt8)               ;  (kNoteRequestSpecifyMIDIChannel | 1->16) as MIDI Channel assignement or zero - see notes above  
   (polyphony :signed-integer)                  ;  Maximum number of voices 
   (typicalPolyphony :signed-long)              ;  Hint for level mixing 
)

;type name? (%define-record :NoteRequestInfo (find-record-descriptor ':NoteRequestInfo))
(defrecord NoteRequest
   (info :NoteRequestInfo)
   (tone :ToneDescription)
)

;type name? (%define-record :NoteRequest (find-record-descriptor ':NoteRequest))

(def-mactype :NoteChannel (find-mactype ':signed-long))

(defconstant $kPickDontMix 1)                   ;  dont mix instruments with drum sounds 

(defconstant $kPickSameSynth 2)                 ;  only allow the same device that went in, to come out 

(defconstant $kPickUserInsts 4)                 ;  show user insts in addition to ROM voices 

(defconstant $kPickEditAllowEdit 8)             ;  lets user switch over to edit mode 

(defconstant $kPickEditAllowPick 16)            ;  lets the user switch over to pick mode 

(defconstant $kPickEditSynthGlobal 32)          ;  edit the global knobs of the synth 

(defconstant $kPickEditControllers 64)          ;  edit the controllers of the notechannel 


(defconstant $kNoteAllocatorComponentType :|nota|)
; --------------------------------
;     Note Allocator Prototypes
; --------------------------------
; 
;  *  NARegisterMusicDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NARegisterMusicDevice" 
   ((na (:pointer :ComponentInstanceRecord))
    (synthType :OSType)
    (name (:pointer :STR31))
    (connections (:pointer :SynthesizerConnections))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAUnregisterMusicDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAUnregisterMusicDevice" 
   ((na (:pointer :ComponentInstanceRecord))
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAGetRegisteredMusicDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAGetRegisteredMusicDevice" 
   ((na (:pointer :ComponentInstanceRecord))
    (index :signed-long)
    (synthType (:pointer :OSType))
    (name (:pointer :STR31))
    (connections (:pointer :SynthesizerConnections))
    (mc (:pointer :MUSICCOMPONENT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NASaveMusicConfiguration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NASaveMusicConfiguration" 
   ((na (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NANewNoteChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NANewNoteChannel" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteRequest (:pointer :NoteRequest))
    (outChannel (:pointer :NOTECHANNEL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NADisposeNoteChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NADisposeNoteChannel" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAGetNoteChannelInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAGetNoteChannelInfo" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (index (:pointer :long))
    (part (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAPrerollNoteChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAPrerollNoteChannel" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAUnrollNoteChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAUnrollNoteChannel" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NASetNoteChannelVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NASetNoteChannelVolume" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (volume :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAResetNoteChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAResetNoteChannel" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAPlayNote()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAPlayNote" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (pitch :signed-long)
    (velocity :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NASetController()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NASetController" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (controllerNumber :signed-long)
    (controllerValue :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NASetKnob()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NASetKnob" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (knobNumber :signed-long)
    (knobValue :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAFindNoteChannelTone()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAFindNoteChannelTone" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (td (:pointer :ToneDescription))
    (instrumentNumber (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NASetInstrumentNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NASetInstrumentNumber" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (instrumentNumber :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

; #if OLDROUTINENAMES
#| 
; #define NASetNoteChannelInstrument(ci, noteChannel,instrumentNumber ) NASetInstrumentNumber(ci, noteChannel,instrumentNumber)
; #define NASetInstrument(ci, noteChannel,instrumentNumber ) NASetInstrumentNumber(ci, noteChannel,instrumentNumber)
 |#

; #endif

; 
;  *  NAPickInstrument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAPickInstrument" 
   ((na (:pointer :ComponentInstanceRecord))
    (filterProc (:pointer :OpaqueModalFilterProcPtr))
    (prompt (:pointer :UInt8))
    (sd (:pointer :ToneDescription))
    (flags :UInt32)
    (refCon :signed-long)
    (reserved1 :signed-long)
    (reserved2 :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAPickArrangement()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAPickArrangement" 
   ((na (:pointer :ComponentInstanceRecord))
    (filterProc (:pointer :OpaqueModalFilterProcPtr))
    (prompt (:pointer :UInt8))
    (zero1 :signed-long)
    (zero2 :signed-long)
    (t (:Handle :TrackType))
    (songName (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAStuffToneDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAStuffToneDescription" 
   ((na (:pointer :ComponentInstanceRecord))
    (gmNumber :signed-long)
    (td (:pointer :ToneDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NACopyrightDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NACopyrightDialog" 
   ((na (:pointer :ComponentInstanceRecord))
    (p (:Handle :Picture))
    (author (:pointer :UInt8))
    (copyright (:pointer :UInt8))
    (other (:pointer :UInt8))
    (title (:pointer :UInt8))
    (filterProc (:pointer :OpaqueModalFilterProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     kNADummyOneSelect = 29
;     kNADummyTwoSelect = 30
; 
; 
;  *  NAGetIndNoteChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAGetIndNoteChannel" 
   ((na (:pointer :ComponentInstanceRecord))
    (index :signed-long)
    (nc (:pointer :NOTECHANNEL))
    (seed (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAGetMIDIPorts()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAGetMIDIPorts" 
   ((na (:pointer :ComponentInstanceRecord))
    (inputPorts (:pointer :QTMIDIPORTLISTHANDLE))
    (outputPorts (:pointer :QTMIDIPORTLISTHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAGetNoteRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAGetNoteRequest" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (nrOut (:pointer :NoteRequest))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NASendMIDI()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NASendMIDI" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (mp (:pointer :MusicMIDIPacket))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAPickEditInstrument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAPickEditInstrument" 
   ((na (:pointer :ComponentInstanceRecord))
    (filterProc (:pointer :OpaqueModalFilterProcPtr))
    (prompt (:pointer :UInt8))
    (refCon :signed-long)
    (nc :signed-long)
    (ai :Handle)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NANewNoteChannelFromAtomicInstrument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NANewNoteChannelFromAtomicInstrument" 
   ((na (:pointer :ComponentInstanceRecord))
    (instrument :pointer)
    (flags :signed-long)
    (outChannel (:pointer :NOTECHANNEL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NASetAtomicInstrument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NASetAtomicInstrument" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (instrument :pointer)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAGetKnob()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAGetKnob" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (knobNumber :signed-long)
    (knobValue (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NATask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NATask" 
   ((na (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NASetNoteChannelBalance()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NASetNoteChannelBalance" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (balance :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NASetInstrumentNumberInterruptSafe()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NASetInstrumentNumberInterruptSafe" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (instrumentNumber :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NASetNoteChannelSoundLocalization()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NASetNoteChannelSoundLocalization" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (data :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NAGetController()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NAGetController" 
   ((na (:pointer :ComponentInstanceRecord))
    (noteChannel :signed-long)
    (controllerNumber :signed-long)
    (controllerValue (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(defconstant $kTuneQueueDepth 8)                ;  Deepest you can queue tune segments 

(defrecord TuneStatus
   (tune (:pointer :UInt32))                    ;  currently playing tune 
   (tunePtr (:pointer :UInt32))                 ;  position within currently playing piece 
   (time :signed-long)                          ;  current tune time 
   (queueCount :SInt16)                         ;  how many pieces queued up? 
   (queueSpots :SInt16)                         ;  How many more tunepieces can be queued 
   (queueTime :signed-long)                     ;  How much time is queued up? (can be very inaccurate) 
   (reserved (:array :signed-long 3))
)

;type name? (%define-record :TuneStatus (find-record-descriptor ':TuneStatus))

(def-mactype :TuneCallBackProcPtr (find-mactype ':pointer)); (const TuneStatus * status , long refCon)

(def-mactype :TunePlayCallBackProcPtr (find-mactype ':pointer)); (unsigned long * event , long seed , long refCon)

(def-mactype :TuneCallBackUPP (find-mactype '(:pointer :OpaqueTuneCallBackProcPtr)))

(def-mactype :TunePlayCallBackUPP (find-mactype '(:pointer :OpaqueTunePlayCallBackProcPtr)))

(def-mactype :TunePlayer (find-mactype ':ComponentInstance))

(defconstant $kTunePlayerComponentType :|tune|)
; 
;  *  TuneSetHeader()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneSetHeader" 
   ((tp (:pointer :ComponentInstanceRecord))
    (header (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneGetTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneGetTimeBase" 
   ((tp (:pointer :ComponentInstanceRecord))
    (tb (:pointer :TIMEBASE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneSetTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneSetTimeScale" 
   ((tp (:pointer :ComponentInstanceRecord))
    (scale :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneGetTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneGetTimeScale" 
   ((tp (:pointer :ComponentInstanceRecord))
    (scale (:pointer :TIMESCALE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneGetIndexedNoteChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneGetIndexedNoteChannel" 
   ((tp (:pointer :ComponentInstanceRecord))
    (i :signed-long)
    (nc (:pointer :NOTECHANNEL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Values for when to start. 

(defconstant $kTuneStartNow 1)                  ;  start after buffer is implied 

(defconstant $kTuneDontClipNotes 2)             ;  allow notes to finish their durations outside sample 

(defconstant $kTuneExcludeEdgeNotes 4)          ;  dont play notes that start at end of tune 

(defconstant $kTuneQuickStart 8)                ;  Leave all the controllers where they are, ignore start time 

(defconstant $kTuneLoopUntil 16)                ;  loop a queued tune if there's nothing else in the queue

(defconstant $kTunePlayDifference 32)           ;  by default, the tune difference is skipped

(defconstant $kTunePlayConcurrent 64)           ;  dont block the next tune sequence with this one

(defconstant $kTuneStartNewMaster #x4000)
; 
;  *  TuneQueue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneQueue" 
   ((tp (:pointer :ComponentInstanceRecord))
    (tune (:pointer :UInt32))
    (tuneRate :signed-long)
    (tuneStartPosition :UInt32)
    (tuneStopPosition :UInt32)
    (queueFlags :UInt32)
    (callBackProc (:pointer :OpaqueTuneCallBackProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneInstant()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneInstant" 
   ((tp (:pointer :ComponentInstanceRecord))
    (tune (:pointer :UInt32))
    (tunePosition :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneGetStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneGetStatus" 
   ((tp (:pointer :ComponentInstanceRecord))
    (status (:pointer :TuneStatus))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Values for stopping. 

(defconstant $kTuneStopFade 1)                  ;  do a quick, synchronous fadeout 

(defconstant $kTuneStopSustain 2)               ;  don't silece notes 

(defconstant $kTuneStopInstant 4)               ;  silence notes fast (else, decay them) 

(defconstant $kTuneStopReleaseChannels 8)       ;  afterwards, let the channels go 

; 
;  *  TuneStop()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneStop" 
   ((tp (:pointer :ComponentInstanceRecord))
    (stopFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneSetVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneSetVolume" 
   ((tp (:pointer :ComponentInstanceRecord))
    (volume :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneGetVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneGetVolume" 
   ((tp (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TunePreroll()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TunePreroll" 
   ((tp (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneUnroll()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneUnroll" 
   ((tp (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneSetNoteChannels()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneSetNoteChannels" 
   ((tp (:pointer :ComponentInstanceRecord))
    (count :UInt32)
    (noteChannelList (:pointer :NOTECHANNEL))
    (playCallBackProc (:pointer :OpaqueTunePlayCallBackProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneSetPartTranspose()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneSetPartTranspose" 
   ((tp (:pointer :ComponentInstanceRecord))
    (part :UInt32)
    (transpose :signed-long)
    (velocityShift :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneGetNoteAllocator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneGetNoteAllocator" 
   ((tp (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentInstanceRecord)
() )
; 
;  *  TuneSetSofter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneSetSofter" 
   ((tp (:pointer :ComponentInstanceRecord))
    (softer :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneTask" 
   ((tp (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneSetBalance()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneSetBalance" 
   ((tp (:pointer :ComponentInstanceRecord))
    (balance :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneSetSoundLocalization()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneSetSoundLocalization" 
   ((tp (:pointer :ComponentInstanceRecord))
    (data :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneSetHeaderWithSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneSetHeaderWithSize" 
   ((tp (:pointer :ComponentInstanceRecord))
    (header (:pointer :UInt32))
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  flags for part mix. 

(defconstant $kTuneMixMute 1)                   ;  disable a part 

(defconstant $kTuneMixSolo 2)                   ;  if any parts soloed, play only soloed parts 

; 
;  *  TuneSetPartMix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneSetPartMix" 
   ((tp (:pointer :ComponentInstanceRecord))
    (partNumber :UInt32)
    (volume :signed-long)
    (balance :signed-long)
    (mixFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TuneGetPartMix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TuneGetPartMix" 
   ((tp (:pointer :ComponentInstanceRecord))
    (partNumber :UInt32)
    (volumeOut (:pointer :long))
    (balanceOut (:pointer :long))
    (mixFlagsOut (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(def-mactype :MusicOpWord (find-mactype ':UInt32))

(def-mactype :MusicOpWordPtr (find-mactype '(:pointer :UInt32)))
;     QuickTime Music Track Event Formats:
; 
;     At this time, QuickTime music tracks support 5 different event types -- REST events,
;     short NOTE events, short CONTROL events, short GENERAL events, Long NOTE events, 
;     long CONTROL events, and variable GENERAL events.
;  
;         ¥ REST Event (4 bytes/event):
;     
;             (0 0 0) (5-bit UNUSED) (24-bit Rest Duration)
;         
;         ¥ÊShort NOTE Events (4 bytes/event):
;     
;             (0 0 1) (5-bit Part) (6-bit Pitch) (7-bit Volume) (11-bit Duration)
;         
;             where:  Pitch is offset by 32 (Actual pitch = pitch field + 32)
; 
;         ¥ÊShort CONTROL Events (4 bytes/event):
;     
;             (0 1 0) (5-bit Part) (8-bit Controller) (1-bit UNUSED) (1-bit Sign) (7-bit MSB) (7-bit LSB)
;                                                                          ( or 15-bit Signed Value)
;         ¥ Short GENERAL Event (4 bytes/event):
;     
;             (0 1 1) (1-bit UNUSED) (12-bit Sub-Type) (16-bit Value)
;     
;         ¥ Long NOTE Events (8 bytes/event):
;     
;             (1 0 0 1) (12-bit Part) (1-bit UNUSED) (7-bit Pitch) (1-bit UNUSED) (7-bit Volume)
;             (1 0) (8-bit UNUSED) (22-bit Duration)
;         
;         ¥ÊLong CONTROL Event (8 bytes/event):
;         
;             (1 0 1 0) (12-bit Part) (16-bit Value MSB) 
;             (1 0) (14-bit Controller) (16-bit Value LSB)
;     
;         ¥ÊLong KNOB Event (8 bytes/event):
;     
;             (1 0 1 1) (12-bit Sub-Type) (16-bit Value MSB)
;             (1 0) (14-bit KNOB) (16-bit Value LSB)
;     
;         ¥ÊVariable GENERAL Length Events (N bytes/event):
;     
;             (1 1 1 1) (12-bit Sub-Type) (16-bit Length)
;                 :
;             (32-bit Data values)
;                 :
;             (1 1) (14-bit UNUSED) (16-bit Length)
;     
;             where:  Length field is the number of LONG words in the record.
;                     Lengths include the first and last long words (Minimum length = 2)
;                 
;     The following event type values have not been used yet and are reserved for 
;     future expansion:
;         
;         ¥ (1 0 0 0)     (8 bytes/event)
;         ¥ (1 1 0 0)     (N bytes/event)
;         ¥ (1 1 0 1)     (N bytes/event)
;         ¥ (1 1 1 0)     (N bytes/event)
;         
;     For all events, the following generalizations apply:
;     
;         -   All duration values are specified in Millisecond units.
;         -   Pitch values are intended to map directly to the MIDI key numbers.
;         -   Controllers from 0 to 127 correspond to the standard MIDI controllers.
;             Controllers greater than 127 correspond to other controls (i.e., Pitch Bend, 
;             Key Pressure, and Channel Pressure).    
; 
;  Defines for the implemented music event data fields

(defconstant $kRestEventType 0)                 ;  lower 3-bits 

(defconstant $kNoteEventType 1)                 ;  lower 3-bits 

(defconstant $kControlEventType 2)              ;  lower 3-bits 

(defconstant $kMarkerEventType 3)               ;  lower 3-bits 

(defconstant $kUndefined1EventType 8)           ;  4-bits 

(defconstant $kXNoteEventType 9)                ;  4-bits 

(defconstant $kXControlEventType 10)            ;  4-bits 

(defconstant $kKnobEventType 11)                ;  4-bits 

(defconstant $kUndefined2EventType 12)          ;  4-bits 

(defconstant $kUndefined3EventType 13)          ;  4-bits 

(defconstant $kUndefined4EventType 14)          ;  4-bits 

(defconstant $kGeneralEventType 15)             ;  4-bits 

(defconstant $kXEventLengthBits 2)              ;  2 bits: indicates 8-byte event record 

(defconstant $kGeneralEventLengthBits 3)        ;  2 bits: indicates variable length event record 

(defconstant $kEventLen 1)                      ;  length of events in long words 

(defconstant $kXEventLen 2)
(defconstant $kRestEventLen 1)                  ;  length of events in long words 

(defconstant $kNoteEventLen 1)
(defconstant $kControlEventLen 1)
(defconstant $kMarkerEventLen 1)
(defconstant $kXNoteEventLen 2)
(defconstant $kXControlEventLen 2)
(defconstant $kGeneralEventLen 2)               ;  2 or more, however 
;  Universal Event Defines

(defconstant $kEventLengthFieldPos 30)          ;  by looking at these two bits of the 1st or last word         

(defconstant $kEventLengthFieldWidth 2)         ;  of an event you can determine the event length                
;  length field: 0 & 1 => 1 long; 2 => 2 longs; 3 => variable length 

(defconstant $kEventTypeFieldPos 29)            ;  event type field for short events 

(defconstant $kEventTypeFieldWidth 3)           ;  short type is 3 bits 

(defconstant $kXEventTypeFieldPos 28)           ;  event type field for extended events 

(defconstant $kXEventTypeFieldWidth 4)          ;  extended type is 4 bits 

(defconstant $kEventPartFieldPos 24)
(defconstant $kEventPartFieldWidth 5)
(defconstant $kXEventPartFieldPos 16)           ;  in the 1st long word 

(defconstant $kXEventPartFieldWidth 12)         ;  Rest Events

(defconstant $kRestEventDurationFieldPos 0)
(defconstant $kRestEventDurationFieldWidth 24)
(defconstant $kRestEventDurationMax #xFFFFFF)   ;  Note Events

(defconstant $kNoteEventPitchFieldPos 18)
(defconstant $kNoteEventPitchFieldWidth 6)
(defconstant $kNoteEventPitchOffset 32)         ;  add to value in pitch field to get actual pitch 

(defconstant $kNoteEventVolumeFieldPos 11)
(defconstant $kNoteEventVolumeFieldWidth 7)
(defconstant $kNoteEventVolumeOffset 0)         ;  add to value in volume field to get actual volume 

(defconstant $kNoteEventDurationFieldPos 0)
(defconstant $kNoteEventDurationFieldWidth 11)
(defconstant $kNoteEventDurationMax #x7FF)
(defconstant $kXNoteEventPitchFieldPos 0)       ;  in the 1st long word 

(defconstant $kXNoteEventPitchFieldWidth 16)
(defconstant $kXNoteEventDurationFieldPos 0)    ;  in the 2nd long word 

(defconstant $kXNoteEventDurationFieldWidth 22)
(defconstant $kXNoteEventDurationMax #x3FFFFF)
(defconstant $kXNoteEventVolumeFieldPos 22)     ;  in the 2nd long word 

(defconstant $kXNoteEventVolumeFieldWidth 7)    ;  Control Events

(defconstant $kControlEventControllerFieldPos 16)
(defconstant $kControlEventControllerFieldWidth 8)
(defconstant $kControlEventValueFieldPos 0)
(defconstant $kControlEventValueFieldWidth 16)
(defconstant $kXControlEventControllerFieldPos 0);  in the 2nd long word 

(defconstant $kXControlEventControllerFieldWidth 16)
(defconstant $kXControlEventValueFieldPos 0)    ;  in the 1st long word 

(defconstant $kXControlEventValueFieldWidth 16) ;  Knob Events

(defconstant $kKnobEventValueHighFieldPos 0)    ;  1st long word 

(defconstant $kKnobEventValueHighFieldWidth 16)
(defconstant $kKnobEventKnobFieldPos 16)        ;  2nd long word 

(defconstant $kKnobEventKnobFieldWidth 14)
(defconstant $kKnobEventValueLowFieldPos 0)     ;  2nd long word 

(defconstant $kKnobEventValueLowFieldWidth 16)  ;  Marker Events

(defconstant $kMarkerEventSubtypeFieldPos 16)
(defconstant $kMarkerEventSubtypeFieldWidth 8)
(defconstant $kMarkerEventValueFieldPos 0)
(defconstant $kMarkerEventValueFieldWidth 16)   ;  General Events

(defconstant $kGeneralEventSubtypeFieldPos 16)  ;  in the last long word 

(defconstant $kGeneralEventSubtypeFieldWidth 14)
(defconstant $kGeneralEventLengthFieldPos 0)    ;  in the 1st & last long words 

(defconstant $kGeneralEventLengthFieldWidth 16)

; #if TARGET_RT_LITTLE_ENDIAN
#| 
(defconstant $kEndMarkerValue 96)
 |#

; #else

(defconstant $kEndMarkerValue #x60000000)

; #endif  /* TARGET_RT_LITTLE_ENDIAN */

;  macros for extracting various fields from the QuickTime event records
; #define qtma_MASK(bitWidth)             ((1L << (bitWidth)) - 1)
; #define qtma_EXT(val, pos, width)       ((EndianU32_BtoN(val) >> (pos)) & qtma_MASK(width))
; #define qtma_EventLengthForward(xP,ulen)            {                                                   unsigned long _ext;                                 unsigned long *lP = (unsigned long *)(xP);          _ext = qtma_EXT(*lP, kEventLengthFieldPos, kEventLengthFieldWidth);         if (_ext != 3) {                                    ulen = (_ext < 2) ? 1 : 2;                  } else {                                            ulen = (unsigned short)qtma_EXT(*lP, kGeneralEventLengthFieldPos, kGeneralEventLengthFieldWidth);             if (ulen < 2) {                                     ulen = lP[1];                               }                                           }                                           }
; #define qtma_EventLengthBackward(xP,ulen)           {                                                   unsigned long _ext;                             unsigned long *lP = (unsigned long *)(xP);         _ext = qtma_EXT(*lP, kEventLengthFieldPos, kEventLengthFieldWidth);             if (_ext != 3) {                                    ulen = (_ext < 2) ? 1 : 2;                  } else {                                            ulen = (unsigned short)qtma_EXT(*lP, kGeneralEventLengthFieldPos, kGeneralEventLengthFieldWidth);                   if (ulen < 2) {                                     ulen = lP[-1];                              }                                           }                                           }
(defconstant $qtma_EventType 0)
; #define qtma_EventType(x)               ((qtma_EXT(x, kEventTypeFieldPos, kEventTypeFieldWidth) > 3) ? qtma_EXT(x, kXEventTypeFieldPos, kXEventTypeFieldWidth) : qtma_EXT(x, kEventTypeFieldPos, kEventTypeFieldWidth))
(defconstant $qtma_RestDuration 0)
; #define qtma_RestDuration(x)            (qtma_EXT(x, kRestEventDurationFieldPos, kRestEventDurationFieldWidth))
(defconstant $qtma_Part 0)
; #define qtma_Part(x)                    (qtma_EXT(x, kEventPartFieldPos, kEventPartFieldWidth))
; #define qtma_XPart(m, l)                (qtma_EXT(m, kXEventPartFieldPos, kXEventPartFieldWidth))
(defconstant $qtma_NotePitch 0)
; #define qtma_NotePitch(x)               (qtma_EXT(x, kNoteEventPitchFieldPos, kNoteEventPitchFieldWidth) + kNoteEventPitchOffset)
(defconstant $qtma_NoteVolume 0)
; #define qtma_NoteVolume(x)              (qtma_EXT(x, kNoteEventVolumeFieldPos, kNoteEventVolumeFieldWidth) + kNoteEventVolumeOffset)
(defconstant $qtma_NoteDuration 0)
; #define qtma_NoteDuration(x)            (qtma_EXT(x, kNoteEventDurationFieldPos, kNoteEventDurationFieldWidth))
; #define qtma_NoteVelocity qtma_NoteVolume
; #define qtma_XNotePitch(m, l)           (qtma_EXT(m, kXNoteEventPitchFieldPos, kXNoteEventPitchFieldWidth))
; #define qtma_XNoteVolume(m, l)          (qtma_EXT(l, kXNoteEventVolumeFieldPos, kXNoteEventVolumeFieldWidth))
; #define qtma_XNoteDuration(m, l)        (qtma_EXT(l, kXNoteEventDurationFieldPos, kXNoteEventDurationFieldWidth))
; #define qtma_XNoteVelocity qtma_XNoteVolume
(defconstant $qtma_ControlController 0)
; #define qtma_ControlController(x)       (qtma_EXT(x, kControlEventControllerFieldPos, kControlEventControllerFieldWidth))
(defconstant $qtma_ControlValue 0)
; #define qtma_ControlValue(x)            (qtma_EXT(x, kControlEventValueFieldPos, kControlEventValueFieldWidth))
; #define qtma_XControlController(m, l)   (qtma_EXT(l, kXControlEventControllerFieldPos, kXControlEventControllerFieldWidth))
; #define qtma_XControlValue(m, l)        (qtma_EXT(m, kXControlEventValueFieldPos, kXControlEventValueFieldWidth))
(defconstant $qtma_MarkerSubtype 0)
; #define qtma_MarkerSubtype(x)           (qtma_EXT(x,kMarkerEventSubtypeFieldPos,kMarkerEventSubtypeFieldWidth))
(defconstant $qtma_MarkerValue 0)
; #define qtma_MarkerValue(x)             (qtma_EXT(x, kMarkerEventValueFieldPos, kMarkerEventValueFieldWidth))
; #define qtma_KnobValue(m,l)                ((qtma_EXT(m,kKnobEventValueHighFieldPos,kKnobEventValueHighFieldWidth) << 16)                                        | (qtma_EXT(l,kKnobEventValueLowFieldPos,kKnobEventValueLowFieldWidth)))
; #define qtma_KnobKnob(m,l)              (qtma_EXT(l,kKnobEventKnobFieldPos,kKnobEventKnobFieldWidth))
; #define qtma_GeneralSubtype(m,l)        (qtma_EXT(l,kGeneralEventSubtypeFieldPos,kGeneralEventSubtypeFieldWidth))
; #define qtma_GeneralLength(m,l)           (qtma_EXT(m,kGeneralEventLengthFieldPos,kGeneralEventLengthFieldWidth))
; #define qtma_StuffRestEvent(x, duration) (     x =    (kRestEventType << kEventTypeFieldPos)           |  ((long)(duration) << kRestEventDurationFieldPos),        x = EndianU32_NtoB(x) )
; #define qtma_StuffNoteEvent(x, part, pitch, volume, duration) (     x =     (kNoteEventType << kEventTypeFieldPos)          |   ((long)(part) << kEventPartFieldPos)            |   (((long)(pitch) - kNoteEventPitchOffset) << kNoteEventPitchFieldPos)            |   (((long)(volume) - kNoteEventVolumeOffset) << kNoteEventVolumeFieldPos)         |   ((long)(duration) << kNoteEventDurationFieldPos),     x = EndianU32_NtoB(x) )
; #define qtma_StuffControlEvent(x, part, control, value) (     x =     (kControlEventType << kEventTypeFieldPos)                   |   ((long)(part) << kEventPartFieldPos)                        |   ((long)(control) << kControlEventControllerFieldPos)        |   ((long)((value) & qtma_MASK(kControlEventValueFieldWidth)) << kControlEventValueFieldPos),     x = EndianU32_NtoB(x) )
; #define qtma_StuffMarkerEvent(x, markerType, markerValue) (     x =     (kMarkerEventType << kEventTypeFieldPos)            |   ((long)(markerType) << kMarkerEventSubtypeFieldPos)         |   ((long)(markerValue) << kMarkerEventValueFieldPos),     x = EndianU32_NtoB(x) )
; #define qtma_StuffXNoteEvent(w1, w2, part, pitch, volume, duration) (     w1 =    (kXNoteEventType << kXEventTypeFieldPos)                    |   ((long)(part) << kXEventPartFieldPos)                       |   ((long)(pitch) << kXNoteEventPitchFieldPos),            w1 = EndianU32_NtoB(w1),                                        w2 =     (kXEventLengthBits << kEventLengthFieldPos)                |   ((long)(duration) << kXNoteEventDurationFieldPos)           |   ((long)(volume) << kXNoteEventVolumeFieldPos),          w2 = EndianU32_NtoB(w2) )
; #define qtma_StuffXControlEvent(w1, w2, part, control, value) (         w1 =    (kXControlEventType << kXEventTypeFieldPos)                     |   ((long)(part) << kXEventPartFieldPos)                           |   ((long)((value) & qtma_MASK(kXControlEventValueFieldWidth)) << kXControlEventValueFieldPos),     w1 = EndianU32_NtoB(w1),                                            w2 =    (kXEventLengthBits << kEventLengthFieldPos)                     |   ((long)(control) << kXControlEventControllerFieldPos),      w2 = EndianU32_NtoB(w2) )
; #define qtma_StuffKnobEvent(w1, w2, part, knob, value) (     w1 =    (kKnobEventType << kXEventTypeFieldPos)                         |   ((long)(part) << kXEventPartFieldPos)                           |   ((long)(value >> 16) << kKnobEventValueLowFieldPos),        w1 = EndianU32_NtoB(w1),                                            w2 =    (kXEventLengthBits << kEventLengthFieldPos)                     |   ((long)(knob) << kKnobEventKnobFieldPos)                        |   ((long)(value & 0xFFFF) << kKnobEventValueLowFieldPos),     w2 = EndianU32_NtoB(w2) )
; #define qtma_StuffGeneralEvent(w1,w2,part,subType,length) (     w1 =    (kGeneralEventType << kXEventTypeFieldPos)                      |   ((long)(part) << kXEventPartFieldPos)                           |   ((long)(length) << kGeneralEventLengthFieldPos),            w1 = EndianU32_NtoB(w1),                                            w2 = (kGeneralEventLengthBits << kEventLengthFieldPos)                  |   ((long)(subType) << kGeneralEventSubtypeFieldPos)               |   ((long)(length) << kGeneralEventLengthFieldPos),            w2 = EndianU32_NtoB(w2) )
; #define qtma_NeedXGeneralEvent(length)   (((unsigned long)(length)) > (unsigned long)0xffff)
;  General Event Defined Types

(defconstant $kGeneralEventNoteRequest 1)       ;  Encapsulates NoteRequest data structure 

(defconstant $kGeneralEventPartKey 4)
(defconstant $kGeneralEventTuneDifference 5)    ;  Contains a standard sequence, with end marker, for the tune difference of a sequence piece (halts QuickTime 2.0 Music) 

(defconstant $kGeneralEventAtomicInstrument 6)  ;  Encapsulates AtomicInstrument record 

(defconstant $kGeneralEventKnob 7)              ;  knobID/knobValue pairs; smallest event is 4 longs 

(defconstant $kGeneralEventMIDIChannel 8)       ;  used in tune header, one longword identifies the midi channel it originally came from 

(defconstant $kGeneralEventPartChange 9)        ;  used in tune sequence, one longword identifies the tune part which can now take over this part's note channel (similar to program change) (halts QuickTime 2.0 Music)

(defconstant $kGeneralEventNoOp 10)             ;  guaranteed to do nothing and be ignored. (halts QuickTime 2.0 Music) 

(defconstant $kGeneralEventUsedNotes 11)        ;  four longwords specifying which midi notes are actually used, 0..127 msb to lsb 

(defconstant $kGeneralEventPartMix 12)          ;  three longwords: Fixed volume, long balance, long flags 

;  Marker Event Defined Types       // marker is 60 ee vv vv in hex, where e = event type, and v = value

(defconstant $kMarkerEventEnd 0)                ;  marker type 0 means: value 0 - stop, value != 0 - ignore

(defconstant $kMarkerEventBeat 1)               ;  value 0 = single beat; anything else is 65536ths-of-a-beat (quarter note)

(defconstant $kMarkerEventTempo 2)              ;  value same as beat marker, but indicates that a tempo event should be computed (based on where the next beat or tempo marker is) and emitted upon export


(defconstant $kCurrentlyNativeEndian 1)
(defconstant $kCurrentlyNotNativeEndian 2)
;  UPP call backs 
; 
;  *  NewMusicMIDISendUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMusicMIDISendUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMusicMIDISendProcPtr)
() )
; 
;  *  NewMusicOfflineDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMusicOfflineDataUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMusicOfflineDataProcPtr)
() )
; 
;  *  NewTuneCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewTuneCallBackUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTuneCallBackProcPtr)
() )
; 
;  *  NewTunePlayCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewTunePlayCallBackUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTunePlayCallBackProcPtr)
() )
; 
;  *  DisposeMusicMIDISendUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMusicMIDISendUPP" 
   ((userUPP (:pointer :OpaqueMusicMIDISendProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMusicOfflineDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMusicOfflineDataUPP" 
   ((userUPP (:pointer :OpaqueMusicOfflineDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeTuneCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeTuneCallBackUPP" 
   ((userUPP (:pointer :OpaqueTuneCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeTunePlayCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeTunePlayCallBackUPP" 
   ((userUPP (:pointer :OpaqueTunePlayCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeMusicMIDISendUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMusicMIDISendUPP" 
   ((self (:pointer :ComponentInstanceRecord))
    (refCon :signed-long)
    (mmp (:pointer :MusicMIDIPacket))
    (userUPP (:pointer :OpaqueMusicMIDISendProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeMusicOfflineDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMusicOfflineDataUPP" 
   ((SoundData :pointer)
    (numBytes :signed-long)
    (myRefCon :signed-long)
    (userUPP (:pointer :OpaqueMusicOfflineDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeTuneCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeTuneCallBackUPP" 
   ((status (:pointer :TuneStatus))
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueTuneCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeTunePlayCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeTunePlayCallBackUPP" 
   ((event (:pointer :UInt32))
    (seed :signed-long)
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueTunePlayCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  selectors for component calls 

(defconstant $kQTMIDIGetMIDIPortsSelect 1)
(defconstant $kQTMIDIUseSendPortSelect 2)
(defconstant $kQTMIDISendMIDISelect 3)
(defconstant $kMusicGetDescriptionSelect 1)
(defconstant $kMusicGetPartSelect 2)
(defconstant $kMusicSetPartSelect 3)
(defconstant $kMusicSetPartInstrumentNumberSelect 4)
(defconstant $kMusicGetPartInstrumentNumberSelect 5)
(defconstant $kMusicStorePartInstrumentSelect 6)
(defconstant $kMusicGetPartAtomicInstrumentSelect 9)
(defconstant $kMusicSetPartAtomicInstrumentSelect 10)
(defconstant $kMusicGetPartKnobSelect 16)
(defconstant $kMusicSetPartKnobSelect 17)
(defconstant $kMusicGetKnobSelect 18)
(defconstant $kMusicSetKnobSelect 19)
(defconstant $kMusicGetPartNameSelect 20)
(defconstant $kMusicSetPartNameSelect 21)
(defconstant $kMusicFindToneSelect 22)
(defconstant $kMusicPlayNoteSelect 23)
(defconstant $kMusicResetPartSelect 24)
(defconstant $kMusicSetPartControllerSelect 25)
(defconstant $kMusicGetPartControllerSelect 26)
(defconstant $kMusicGetMIDIProcSelect 27)
(defconstant $kMusicSetMIDIProcSelect 28)
(defconstant $kMusicGetInstrumentNamesSelect 29)
(defconstant $kMusicGetDrumNamesSelect 30)
(defconstant $kMusicGetMasterTuneSelect 31)
(defconstant $kMusicSetMasterTuneSelect 32)
(defconstant $kMusicGetInstrumentAboutInfoSelect 34)
(defconstant $kMusicGetDeviceConnectionSelect 35)
(defconstant $kMusicUseDeviceConnectionSelect 36)
(defconstant $kMusicGetKnobSettingStringsSelect 37)
(defconstant $kMusicGetMIDIPortsSelect 38)
(defconstant $kMusicSendMIDISelect 39)
(defconstant $kMusicStartOfflineSelect 41)
(defconstant $kMusicSetOfflineTimeToSelect 42)
(defconstant $kMusicGetInstrumentKnobDescriptionSelect 43)
(defconstant $kMusicGetDrumKnobDescriptionSelect 44)
(defconstant $kMusicGetKnobDescriptionSelect 45)
(defconstant $kMusicGetInfoTextSelect 46)
(defconstant $kMusicGetInstrumentInfoSelect 47)
(defconstant $kMusicTaskSelect 49)
(defconstant $kMusicSetPartInstrumentNumberInterruptSafeSelect 50)
(defconstant $kMusicSetPartSoundLocalizationSelect 51)
(defconstant $kMusicGenericConfigureSelect #x100)
(defconstant $kMusicGenericGetPartSelect #x101)
(defconstant $kMusicGenericGetKnobListSelect #x102)
(defconstant $kMusicGenericSetResourceNumbersSelect #x103)
(defconstant $kMusicDerivedMIDISendSelect #x200)
(defconstant $kMusicDerivedSetKnobSelect #x201)
(defconstant $kMusicDerivedSetPartSelect #x202)
(defconstant $kMusicDerivedSetInstrumentSelect #x203)
(defconstant $kMusicDerivedSetPartInstrumentNumberSelect #x204)
(defconstant $kMusicDerivedSetMIDISelect #x205)
(defconstant $kMusicDerivedStorePartInstrumentSelect #x206)
(defconstant $kMusicDerivedOpenResFileSelect #x207)
(defconstant $kMusicDerivedCloseResFileSelect #x208)
(defconstant $kNARegisterMusicDeviceSelect 0)
(defconstant $kNAUnregisterMusicDeviceSelect 1)
(defconstant $kNAGetRegisteredMusicDeviceSelect 2)
(defconstant $kNASaveMusicConfigurationSelect 3)
(defconstant $kNANewNoteChannelSelect 4)
(defconstant $kNADisposeNoteChannelSelect 5)
(defconstant $kNAGetNoteChannelInfoSelect 6)
(defconstant $kNAPrerollNoteChannelSelect 7)
(defconstant $kNAUnrollNoteChannelSelect 8)
(defconstant $kNASetNoteChannelVolumeSelect 11)
(defconstant $kNAResetNoteChannelSelect 12)
(defconstant $kNAPlayNoteSelect 13)
(defconstant $kNASetControllerSelect 14)
(defconstant $kNASetKnobSelect 15)
(defconstant $kNAFindNoteChannelToneSelect 16)
(defconstant $kNASetInstrumentNumberSelect 17)
(defconstant $kNAPickInstrumentSelect 18)
(defconstant $kNAPickArrangementSelect 19)
(defconstant $kNAStuffToneDescriptionSelect 27)
(defconstant $kNACopyrightDialogSelect 28)
(defconstant $kNAGetIndNoteChannelSelect 31)
(defconstant $kNAGetMIDIPortsSelect 33)
(defconstant $kNAGetNoteRequestSelect 34)
(defconstant $kNASendMIDISelect 35)
(defconstant $kNAPickEditInstrumentSelect 36)
(defconstant $kNANewNoteChannelFromAtomicInstrumentSelect 37)
(defconstant $kNASetAtomicInstrumentSelect 38)
(defconstant $kNAGetKnobSelect 40)
(defconstant $kNATaskSelect 41)
(defconstant $kNASetNoteChannelBalanceSelect 42)
(defconstant $kNASetInstrumentNumberInterruptSafeSelect 43)
(defconstant $kNASetNoteChannelSoundLocalizationSelect 44)
(defconstant $kNAGetControllerSelect 45)
(defconstant $kTuneSetHeaderSelect 4)
(defconstant $kTuneGetTimeBaseSelect 5)
(defconstant $kTuneSetTimeScaleSelect 6)
(defconstant $kTuneGetTimeScaleSelect 7)
(defconstant $kTuneGetIndexedNoteChannelSelect 8)
(defconstant $kTuneQueueSelect 10)
(defconstant $kTuneInstantSelect 11)
(defconstant $kTuneGetStatusSelect 12)
(defconstant $kTuneStopSelect 13)
(defconstant $kTuneSetVolumeSelect 16)
(defconstant $kTuneGetVolumeSelect 17)
(defconstant $kTunePrerollSelect 18)
(defconstant $kTuneUnrollSelect 19)
(defconstant $kTuneSetNoteChannelsSelect 20)
(defconstant $kTuneSetPartTransposeSelect 21)
(defconstant $kTuneGetNoteAllocatorSelect 23)
(defconstant $kTuneSetSofterSelect 24)
(defconstant $kTuneTaskSelect 25)
(defconstant $kTuneSetBalanceSelect 26)
(defconstant $kTuneSetSoundLocalizationSelect 27)
(defconstant $kTuneSetHeaderWithSizeSelect 28)
(defconstant $kTuneSetPartMixSelect 29)
(defconstant $kTuneGetPartMixSelect 30)
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __QUICKTIMEMUSIC__ */


(provide-interface "QuickTimeMusic")