(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Sound.h"
; at Sunday July 2,2006 7:25:07 pm.
; 
;      File:       CarbonSound/Sound.h
;  
;      Contains:   Sound Manager Interfaces.
;  
;      Version:    CarbonSound-94~4
;  
;      Copyright:  © 1986-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __SOUND__
; #define __SOUND__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __DIALOGS__
#| #|
#include <HIToolboxDialogs.h>
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
; 
;                         * * *  N O T E  * * *
; 
;     This file has been updated to include Sound Manager 3.3 interfaces.
; 
;     Some of the Sound Manager 3.0 interfaces were not put into the InterfaceLib
;     that originally shipped with the PowerMacs. These missing functions and the
;     new 3.3 interfaces have been released in the SoundLib library for PowerPC
;     developers to link with. The runtime library for these functions are
;     installed by the Sound Manager. The following functions are found in SoundLib.
; 
;         GetCompressionInfo(), GetSoundPreference(), SetSoundPreference(),
;         UnsignedFixedMulDiv(), SndGetInfo(), SndSetInfo(), GetSoundOutputInfo(),
;         SetSoundOutputInfo(), GetCompressionName(), SoundConverterOpen(),
;         SoundConverterClose(), SoundConverterGetBufferSizes(), SoundConverterBeginConversion(),
;         SoundConverterConvertBuffer(), SoundConverterEndConversion(),
;         AudioGetBass(), AudioGetInfo(), AudioGetMute(), AudioGetOutputDevice(),
;         AudioGetTreble(), AudioGetVolume(), AudioMuteOnEvent(), AudioSetBass(),
;         AudioSetMute(), AudioSetToDefaults(), AudioSetTreble(), AudioSetVolume(),
;         OpenMixerSoundComponent(), CloseMixerSoundComponent(), SoundComponentAddSource(),
;         SoundComponentGetInfo(), SoundComponentGetSource(), SoundComponentGetSourceData(),
;         SoundComponentInitOutputDevice(), SoundComponentPauseSource(),
;         SoundComponentPlaySourceBuffer(), SoundComponentRemoveSource(),
;         SoundComponentSetInfo(), SoundComponentSetOutput(), SoundComponentSetSource(),
;         SoundComponentStartSource(), SoundComponentStopSource(),
;         ParseAIFFHeader(), ParseSndHeader(), SoundConverterGetInfo(), SoundConverterSetInfo()
; 
; 
;     Interfaces for Sound Driver, !!! OBSOLETE and NOT SUPPORTED !!!
; 
;     These items are no longer defined, but appear here so that someone
;     searching the interfaces might find them. If you are using one of these
;     items, you must change your code to support the Sound Manager.
; 
;         swMode, ftMode, ffMode
;         FreeWave, FFSynthRec, Tone, SWSynthRec, Wave, FTSoundRec
;         SndCompletionProcPtr
;         StartSound, StopSound, SoundDone
;         SetSoundVol, GetSoundVol
; 
; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    constants
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
(defconstant $twelfthRootTwo 1.05946309435)
; #define twelfthRootTwo 1.05946309435

(defconstant $soundListRsrc :|snd |)            ; Resource type used by Sound Manager

(defconstant $kSoundCodecInfoResourceType :|snfo|); Resource type holding codec information (optional public component resource)


(defconstant $kSimpleBeepID 1)                  ; reserved resource ID for Simple Beep


(defconstant $rate48khz #xBB800000)             ; 48000.00000 in fixed-point

(defconstant $rate44khz #xAC440000)             ; 44100.00000 in fixed-point

(defconstant $rate32khz #x7D000000)             ; 32000.00000 in fixed-point

(defconstant $rate22050hz #x56220000)           ; 22050.00000 in fixed-point

(defconstant $rate22khz #x56EE8BA3)             ; 22254.54545 in fixed-point

(defconstant $rate16khz #x3E800000)             ; 16000.00000 in fixed-point

(defconstant $rate11khz #x2B7745D1)             ; 11127.27273 in fixed-point

(defconstant $rate11025hz #x2B110000)           ; 11025.00000 in fixed-point

(defconstant $rate8khz #x1F400000)              ;  8000.00000 in fixed-point

; synthesizer numbers for SndNewChannel

(defconstant $sampledSynth 5)                   ; sampled sound synthesizer


; #if CALL_NOT_IN_CARBON
#| 
(defconstant $squareWaveSynth 1)                ; square wave synthesizer

(defconstant $waveTableSynth 3)                 ; wave table synthesizer
; old Sound Manager MACE synthesizer numbers

(defconstant $MACE3snthID 11)
(defconstant $MACE6snthID 13)
 |#

; #endif  /* CALL_NOT_IN_CARBON */


(defconstant $kMiddleC 60)                      ; MIDI note value for middle C


(defconstant $kNoVolume 0)                      ; setting for no sound volume

(defconstant $kFullVolume #x100)                ; 1.0, setting for full hardware output volume


(defconstant $stdQLength #x80)

(defconstant $dataOffsetFlag #x8000)
; only for Sound Manager 3.0 or later

(defconstant $kUseOptionalOutputDevice -1)

(defconstant $notCompressed 0)                  ; compression ID's

(defconstant $fixedCompression -1)              ; compression ID for fixed-sized compression
; compression ID for variable-sized compression

(defconstant $variableCompression -2)

(defconstant $twoToOne 1)
(defconstant $eightToThree 2)
(defconstant $threeToOne 3)
(defconstant $sixToOne 4)
(defconstant $sixToOnePacketSize 8)
(defconstant $threeToOnePacketSize 16)

(defconstant $stateBlockSize 64)
(defconstant $leftOverBlockSize 32)

(defconstant $firstSoundFormat 1)               ; general sound format

(defconstant $secondSoundFormat 2)              ; special sampled sound format (HyperCard)


; #if CALL_NOT_IN_CARBON
#| 
(defconstant $dbBufferReady 1)                  ; double buffer is filled

(defconstant $dbLastBuffer 4)                   ; last double buffer to play

 |#

; #endif  /* CALL_NOT_IN_CARBON */


(defconstant $sysBeepDisable 0)                 ; SysBeep() enable flags

(defconstant $sysBeepEnable 1)                  ; if bit set, make alert sounds synchronous

(defconstant $sysBeepSynchronous 2)

(defconstant $unitTypeNoSelection #xFFFF)       ; unitTypes for AudioSelection.unitType

(defconstant $unitTypeSeconds 0)

(defconstant $stdSH 0)                          ; Standard sound header encode value

(defconstant $extSH #xFF)                       ; Extended sound header encode value

(defconstant $cmpSH #xFE)                       ; Compressed sound header encode value

; command numbers for SndDoCommand and SndDoImmediate

(defconstant $nullCmd 0)
(defconstant $quietCmd 3)
(defconstant $flushCmd 4)
(defconstant $reInitCmd 5)
(defconstant $waitCmd 10)
(defconstant $pauseCmd 11)
(defconstant $resumeCmd 12)
(defconstant $callBackCmd 13)
(defconstant $syncCmd 14)
(defconstant $availableCmd 24)
(defconstant $versionCmd 25)
(defconstant $volumeCmd 46)                     ; sound manager 3.0 or later only

(defconstant $getVolumeCmd 47)                  ; sound manager 3.0 or later only

(defconstant $clockComponentCmd 50)             ; sound manager 3.2.1 or later only

(defconstant $getClockComponentCmd 51)          ; sound manager 3.2.1 or later only

(defconstant $scheduledSoundCmd 52)             ; sound manager 3.3 or later only

(defconstant $linkSoundComponentsCmd 53)        ; sound manager 3.3 or later only

(defconstant $soundCmd 80)
(defconstant $bufferCmd 81)
(defconstant $rateMultiplierCmd 86)
(defconstant $getRateMultiplierCmd 87)

; #if CALL_NOT_IN_CARBON
#|                                              ; command numbers for SndDoCommand and SndDoImmediate that are not available for use in Carbon 

(defconstant $initCmd 1)
(defconstant $freeCmd 2)
(defconstant $totalLoadCmd 26)
(defconstant $loadCmd 27)
(defconstant $freqDurationCmd 40)
(defconstant $restCmd 41)
(defconstant $freqCmd 42)
(defconstant $ampCmd 43)
(defconstant $timbreCmd 44)
(defconstant $getAmpCmd 45)
(defconstant $waveTableCmd 60)
(defconstant $phaseCmd 61)
(defconstant $rateCmd 82)
(defconstant $continueCmd 83)
(defconstant $doubleBufferCmd 84)
(defconstant $getRateCmd 85)
(defconstant $sizeCmd 90)                       ; obsolete command

(defconstant $convertCmd 91)                    ; obsolete MACE command

 |#

; #endif  /* CALL_NOT_IN_CARBON */


; #if OLDROUTINENAMES
#|                                              ; channel initialization parameters

(defconstant $waveInitChannelMask 7)
(defconstant $waveInitChannel0 4)               ; wave table only, Sound Manager 2.0 and earlier

(defconstant $waveInitChannel1 5)               ; wave table only, Sound Manager 2.0 and earlier

(defconstant $waveInitChannel2 6)               ; wave table only, Sound Manager 2.0 and earlier

(defconstant $waveInitChannel3 7)               ; wave table only, Sound Manager 2.0 and earlier

(defconstant $initChan0 4)                      ; obsolete spelling

(defconstant $initChan1 5)                      ; obsolete spelling

(defconstant $initChan2 6)                      ; obsolete spelling

(defconstant $initChan3 7)                      ; obsolete spelling


(defconstant $outsideCmpSH 0)                   ; obsolete MACE constant

(defconstant $insideCmpSH 1)                    ; obsolete MACE constant

(defconstant $aceSuccess 0)                     ; obsolete MACE constant

(defconstant $aceMemFull 1)                     ; obsolete MACE constant

(defconstant $aceNilBlock 2)                    ; obsolete MACE constant

(defconstant $aceBadComp 3)                     ; obsolete MACE constant

(defconstant $aceBadEncode 4)                   ; obsolete MACE constant

(defconstant $aceBadDest 5)                     ; obsolete MACE constant

(defconstant $aceBadCmd 6)                      ; obsolete MACE constant

 |#

; #endif  /* OLDROUTINENAMES */


(defconstant $initChanLeft 2)                   ; left stereo channel

(defconstant $initChanRight 3)                  ; right stereo channel

(defconstant $initNoInterp 4)                   ; no linear interpolation

(defconstant $initNoDrop 8)                     ; no drop-sample conversion

(defconstant $initMono #x80)                    ; monophonic channel

(defconstant $initStereo #xC0)                  ; stereo channel

(defconstant $initMACE3 #x300)                  ; MACE 3:1

(defconstant $initMACE6 #x400)                  ; MACE 6:1

(defconstant $initPanMask 3)                    ; mask for right/left pan values

(defconstant $initSRateMask 48)                 ; mask for sample rate values

(defconstant $initStereoMask #xC0)              ; mask for mono/stereo values

(defconstant $initCompMask #xFF00)              ; mask for compression IDs

; Get&Set Sound Information Selectors

(defconstant $siActiveChannels :|chac|)         ; active channels

(defconstant $siActiveLevels :|lmac|)           ; active meter levels

(defconstant $siAGCOnOff :|agc |)               ; automatic gain control state

(defconstant $siAsync :|asyn|)                  ; asynchronous capability

(defconstant $siAVDisplayBehavior :|avdb|)
(defconstant $siChannelAvailable :|chav|)       ; number of channels available

(defconstant $siCompressionAvailable :|cmav|)   ; compression types available

(defconstant $siCompressionFactor :|cmfa|)      ; current compression factor

(defconstant $siCompressionHeader :|cmhd|)      ; return compression header

(defconstant $siCompressionNames :|cnam|)       ; compression type names available

(defconstant $siCompressionParams :|evaw|)      ; compression parameters

(defconstant $siCompressionSampleRate :|cprt|)  ;  SetInfo only: compressor's sample rate

(defconstant $siCompressionChannels :|cpct|)    ;  SetInfo only: compressor's number of channels

(defconstant $siCompressionOutputSampleRate :|cort|);  GetInfo only: only implemented by compressors that have differing in and out rates 

(defconstant $siCompressionInputRateList :|crtl|);  GetInfo only: only implemented by compressors that only take certain input rates 

(defconstant $siCompressionType :|comp|)        ; current compression type

(defconstant $siCompressionConfiguration :|ccfg|); compression extensions

(defconstant $siContinuous :|cont|)             ; continous recording

(defconstant $siDecompressionParams :|wave|)    ; decompression parameters

(defconstant $siDecompressionConfiguration :|dcfg|); decompression extensions

(defconstant $siDeviceBufferInfo :|dbin|)       ; size of interrupt buffer

(defconstant $siDeviceConnected :|dcon|)        ; input device connection status

(defconstant $siDeviceIcon :|icon|)             ; input device icon

(defconstant $siDeviceName :|name|)             ; input device name

(defconstant $siEQSpectrumBands :|eqsb|)        ;  number of spectrum bands

(defconstant $siEQSpectrumLevels :|eqlv|)       ;  gets spectum meter levels

(defconstant $siEQSpectrumOnOff :|eqlo|)        ;  turn on/off spectum meter levels

(defconstant $siEQSpectrumResolution :|eqrs|)   ;  set the resolution of the FFT, 0 = low res (<=16 bands), 1 = high res (16-64 bands)

(defconstant $siEQToneControlGain :|eqtg|)      ;  set the bass and treble gain

(defconstant $siEQToneControlOnOff :|eqtc|)     ;  turn on equalizer attenuation

(defconstant $siHardwareBalance :|hbal|)
(defconstant $siHardwareBalanceSteps :|hbls|)
(defconstant $siHardwareBass :|hbas|)
(defconstant $siHardwareBassSteps :|hbst|)
(defconstant $siHardwareBusy :|hwbs|)           ; sound hardware is in use

(defconstant $siHardwareFormat :|hwfm|)         ; get hardware format

(defconstant $siHardwareMute :|hmut|)           ; mute state of all hardware

(defconstant $siHardwareMuteNoPrefs :|hmnp|)    ; mute state of all hardware, but don't store in prefs 

(defconstant $siHardwareTreble :|htrb|)
(defconstant $siHardwareTrebleSteps :|hwts|)
(defconstant $siHardwareVolume :|hvol|)         ; volume level of all hardware

(defconstant $siHardwareVolumeSteps :|hstp|)    ; number of volume steps for hardware

(defconstant $siHeadphoneMute :|pmut|)          ; mute state of headphones

(defconstant $siHeadphoneVolume :|pvol|)        ; volume level of headphones

(defconstant $siHeadphoneVolumeSteps :|hdst|)   ; number of volume steps for headphones

(defconstant $siInputAvailable :|inav|)         ; input sources available

(defconstant $siInputGain :|gain|)              ; input gain

(defconstant $siInputSource :|sour|)            ; input source selector

(defconstant $siInputSourceNames :|snam|)       ; input source names

(defconstant $siLevelMeterOnOff :|lmet|)        ; level meter state

(defconstant $siModemGain :|mgai|)              ; modem input gain

(defconstant $siMonitorAvailable :|mnav|)
(defconstant $siMonitorSource :|mons|)
(defconstant $siNumberChannels :|chan|)         ; current number of channels

(defconstant $siOptionsDialog :|optd|)          ; display options dialog

(defconstant $siOSTypeInputSource :|inpt|)      ; input source by OSType

(defconstant $siOSTypeInputAvailable :|inav|)   ; list of available input source OSTypes

(defconstant $siOutputDeviceName :|onam|)       ; output device name

(defconstant $siPlayThruOnOff :|plth|)          ; playthrough state

(defconstant $siPostMixerSoundComponent :|psmx|); install post-mixer effect

(defconstant $siPreMixerSoundComponent :|prmx|) ; install pre-mixer effect

(defconstant $siQuality :|qual|)                ; quality setting

(defconstant $siRateMultiplier :|rmul|)         ; throttle rate setting

(defconstant $siRecordingQuality :|qual|)       ; recording quality

(defconstant $siSampleRate :|srat|)             ; current sample rate

(defconstant $siSampleRateAvailable :|srav|)    ; sample rates available

(defconstant $siSampleSize :|ssiz|)             ; current sample size

(defconstant $siSampleSizeAvailable :|ssav|)    ; sample sizes available

(defconstant $siSetupCDAudio :|sucd|)           ; setup sound hardware for CD audio

(defconstant $siSetupModemAudio :|sumd|)        ; setup sound hardware for modem audio

(defconstant $siSlopeAndIntercept :|flap|)      ; floating point variables for conversion

(defconstant $siSoundClock :|sclk|)
(defconstant $siUseThisSoundClock :|sclc|)      ; sdev uses this to tell the mixer to use his sound clock

(defconstant $siSpeakerMute :|smut|)            ; mute state of all built-in speaker

(defconstant $siSpeakerVolume :|svol|)          ; volume level of built-in speaker

(defconstant $siSSpCPULoadLimit :|3dll|)
(defconstant $siSSpLocalization :|3dif|)
(defconstant $siSSpSpeakerSetup :|3dst|)
(defconstant $siStereoInputGain :|sgai|)        ; stereo input gain

(defconstant $siSubwooferMute :|bmut|)          ; mute state of sub-woofer

(defconstant $siTerminalType :|ttyp|)           ;  usb terminal type 

(defconstant $siTwosComplementOnOff :|twos|)    ; two's complement state

(defconstant $siVendorProduct :|vpro|)          ;  vendor and product ID 

(defconstant $siVolume :|volu|)                 ; volume level of source

(defconstant $siVoxRecordInfo :|voxr|)          ; VOX record parameters

(defconstant $siVoxStopInfo :|voxs|)            ; VOX stop parameters

(defconstant $siWideStereo :|wide|)             ; wide stereo setting

(defconstant $siSupportedExtendedFlags :|exfl|) ; which flags are supported in Extended sound data structures

(defconstant $siRateConverterRollOffSlope :|rcdb|); the roll-off slope for the rate converter's filter, in whole dB as a long this value is a long whose range is from 20 (worst quality/fastest performance) to 90 (best quality/slowest performance)

(defconstant $siOutputLatency :|olte|)          ; latency of sound output component

(defconstant $siHALAudioDeviceID :|hlid|)       ; audio device id

(defconstant $siHALAudioDeviceUniqueID :|huid|) ; audio device unique id

(defconstant $siClientAcceptsVBR :|cvbr|)       ; client handles VBR

(defconstant $siSourceIsExhausted :|srcx|)      ; the ultimate source of data has run out (keep asking, but when you get nothing, that's it)

(defconstant $siMediaContextID :|uuid|)         ; media context id -- UUID 

(defconstant $siCompressionMaxPacketSize :|cmxp|); maximum compressed packet size for current configuration -- unsigned long 

(defconstant $siAudioCodecPropertyValue :|spva|); audio codec property value -- SoundAudioCodecPropertyRequestParams* 

(defconstant $siAudioCodecPropertyInfo :|spin|) ; audio codec property info -- SoundAudioCodecPropertyRequestParams* 


(defconstant $siCloseDriver :|clos|)            ; reserved for internal use only

(defconstant $siInitializeDriver :|init|)       ; reserved for internal use only

(defconstant $siPauseRecording :|paus|)         ; reserved for internal use only

(defconstant $siUserInterruptProc :|user|)      ; reserved for internal use only

;  input source Types

(defconstant $kInvalidSource #xFFFFFFFF)        ; this source may be returned from GetInfo if no other source is the monitored source

(defconstant $kNoSource :|none|)                ; no source selection

(defconstant $kCDSource :|cd  |)                ; internal CD player input

(defconstant $kExtMicSource :|emic|)            ; external mic input

(defconstant $kSoundInSource :|sinj|)           ; sound input jack

(defconstant $kRCAInSource :|irca|)             ; RCA jack input

(defconstant $kTVFMTunerSource :|tvfm|)
(defconstant $kDAVInSource :|idav|)             ; DAV analog input

(defconstant $kIntMicSource :|imic|)            ; internal mic input

(defconstant $kMediaBaySource :|mbay|)          ; media bay input

(defconstant $kModemSource :|modm|)             ; modem input (internal modem on desktops, PCI input on PowerBooks)

(defconstant $kPCCardSource :|pcm |)            ; PC Card pwm input

(defconstant $kZoomVideoSource :|zvpc|)         ; zoom video input

(defconstant $kDVDSource :|dvda|)               ;  DVD audio input

(defconstant $kMicrophoneArray :|mica|)         ;  microphone array

; Sound Component Types and Subtypes

(defconstant $kNoSoundComponentType :|****|)
(defconstant $kSoundComponentType :|sift|)      ; component type

(defconstant $kSoundComponentPPCType :|nift|)   ; component type for PowerPC code

(defconstant $kRate8SubType :|ratb|)            ; 8-bit rate converter

(defconstant $kRate16SubType :|ratw|)           ; 16-bit rate converter

(defconstant $kConverterSubType :|conv|)        ; sample format converter

(defconstant $kSndSourceSubType :|sour|)        ; generic source component

(defconstant $kMixerType :|mixr|)
(defconstant $kMixer8SubType :|mixb|)           ; 8-bit mixer

(defconstant $kMixer16SubType :|mixw|)          ; 16-bit mixer

(defconstant $kSoundInputDeviceType :|sinp|)    ; sound input component

(defconstant $kWaveInSubType :|wavi|)           ; Windows waveIn

(defconstant $kWaveInSnifferSubType :|wisn|)    ; Windows waveIn sniffer

(defconstant $kSoundOutputDeviceType :|sdev|)   ; sound output component

(defconstant $kClassicSubType :|clas|)          ; classic hardware, i.e. Mac Plus

(defconstant $kASCSubType :|asc |)              ; Apple Sound Chip device

(defconstant $kDSPSubType :|dsp |)              ; DSP device

(defconstant $kAwacsSubType :|awac|)            ; Another of Will's Audio Chips device

(defconstant $kGCAwacsSubType :|awgc|)          ; Awacs audio with Grand Central DMA

(defconstant $kSingerSubType :|sing|)           ; Singer (via Whitney) based sound

(defconstant $kSinger2SubType :|sng2|)          ; Singer 2 (via Whitney) for Acme

(defconstant $kWhitSubType :|whit|)             ; Whit sound component for PrimeTime 3

(defconstant $kSoundBlasterSubType :|sbls|)     ; Sound Blaster for CHRP

(defconstant $kWaveOutSubType :|wavo|)          ; Windows waveOut

(defconstant $kWaveOutSnifferSubType :|wosn|)   ; Windows waveOut sniffer

(defconstant $kDirectSoundSubType :|dsnd|)      ; Windows DirectSound

(defconstant $kDirectSoundSnifferSubType :|dssn|); Windows DirectSound sniffer

(defconstant $kUNIXsdevSubType :|un1x|)         ; UNIX base sdev

(defconstant $kUSBSubType :|usb |)              ; USB device

(defconstant $kBlueBoxSubType :|bsnd|)          ; Blue Box sound component

(defconstant $kHALCustomComponentSubType :|halx|); Registered by the HAL output component ('hal!') for each HAL output device

(defconstant $kSoundCompressor :|scom|)
(defconstant $kSoundDecompressor :|sdec|)
(defconstant $kAudioComponentType :|adio|)      ; Audio components and sub-types

(defconstant $kAwacsPhoneSubType :|hphn|)
(defconstant $kAudioVisionSpeakerSubType :|telc|)
(defconstant $kAudioVisionHeadphoneSubType :|telh|)
(defconstant $kPhilipsFaderSubType :|tvav|)
(defconstant $kSGSToneSubType :|sgs0|)
(defconstant $kSoundEffectsType :|snfx|)        ; sound effects type

(defconstant $kEqualizerSubType :|eqal|)        ; frequency equalizer

(defconstant $kSSpLocalizationSubType :|snd3|)
; Format Types

(defconstant $kSoundNotCompressed :|NONE|)      ; sound is not compressed

(defconstant $k8BitOffsetBinaryFormat :|raw |)  ; 8-bit offset binary

(defconstant $k16BitBigEndianFormat :|twos|)    ; 16-bit big endian

(defconstant $k16BitLittleEndianFormat :|sowt|) ; 16-bit little endian

(defconstant $kFloat32Format :|fl32|)           ; 32-bit floating point

(defconstant $kFloat64Format :|fl64|)           ; 64-bit floating point

(defconstant $k24BitFormat :|in24|)             ; 24-bit integer

(defconstant $k32BitFormat :|in32|)             ; 32-bit integer

(defconstant $k32BitLittleEndianFormat :|23ni|) ; 32-bit little endian integer 

(defconstant $kMACE3Compression :|MAC3|)        ; MACE 3:1

(defconstant $kMACE6Compression :|MAC6|)        ; MACE 6:1

(defconstant $kCDXA4Compression :|cdx4|)        ; CD/XA 4:1

(defconstant $kCDXA2Compression :|cdx2|)        ; CD/XA 2:1

(defconstant $kIMACompression :|ima4|)          ; IMA 4:1

(defconstant $kULawCompression :|ulaw|)         ; µLaw 2:1

(defconstant $kALawCompression :|alaw|)         ; aLaw 2:1

(defconstant $kMicrosoftADPCMFormat #x6D730002) ; Microsoft ADPCM - ACM code 2

(defconstant $kDVIIntelIMAFormat #x6D730011)    ; DVI/Intel IMA ADPCM - ACM code 17

(defconstant $kMicrosoftGSMCompression #x6D730031); Microsoft GSM 6.10 - ACM code 49

(defconstant $kDVAudioFormat :|dvca|)           ; DV Audio

(defconstant $kQDesignCompression :|QDMC|)      ; QDesign music

(defconstant $kQDesign2Compression :|QDM2|)     ; QDesign2 music

(defconstant $kQUALCOMMCompression :|Qclp|)     ; QUALCOMM PureVoice

(defconstant $kOffsetBinary :|raw |)            ; for compatibility

(defconstant $kTwosComplement :|twos|)          ; for compatibility

(defconstant $kLittleEndianFormat :|sowt|)      ; for compatibility

(defconstant $kMPEGLayer3Format #x6D730055)     ; MPEG Layer 3, CBR only (pre QT4.1)

(defconstant $kFullMPEGLay3Format :|.mp3|)      ; MPEG Layer 3, CBR & VBR (QT4.1 and later)

(defconstant $kVariableDurationDVAudioFormat :|vdva|); Variable Duration DV Audio

(defconstant $kMPEG4AudioFormat :|mp4a|)

; #if TARGET_RT_LITTLE_ENDIAN
#| 
(defconstant $k16BitNativeEndianFormat :|sowt|)
(defconstant $k16BitNonNativeEndianFormat :|twos|)
 |#

; #else

(defconstant $k16BitNativeEndianFormat :|twos|)
(defconstant $k16BitNonNativeEndianFormat :|sowt|)

; #endif  /* TARGET_RT_LITTLE_ENDIAN */

; Features Flags

(defconstant $k8BitRawIn 1)                     ; data description

(defconstant $k8BitTwosIn 2)
(defconstant $k16BitIn 4)
(defconstant $kStereoIn 8)
(defconstant $k8BitRawOut #x100)
(defconstant $k8BitTwosOut #x200)
(defconstant $k16BitOut #x400)
(defconstant $kStereoOut #x800)
(defconstant $kReverse #x10000)                 ;   function description

(defconstant $kRateConvert #x20000)
(defconstant $kCreateSoundSource #x40000)
(defconstant $kVMAwareness #x200000)            ;  component will hold its memory

(defconstant $kHighQuality #x400000)            ;   performance description

(defconstant $kNonRealTime #x800000)
; 'snfo' Resource Feature Flags

(defconstant $kSoundCodecInfoFixedCompression 1);  has fixed compression format

(defconstant $kSoundCodecInfoVariableCompression 2);  has variable compression format

(defconstant $kSoundCodecInfoHasRestrictedInputRates 4);  compressor has restricted set of input sample rates

(defconstant $kSoundCodecInfoCanChangeOutputRate 8);  compressor may output a different sample rate than it receives

(defconstant $kSoundCodecInfoRequiresExternalFraming 16);  format requires external framing information during decode/encode
;  audio packets can vary in duration

(defconstant $kSoundCodecInfoVariableDuration 32)
; SoundComponentPlaySourceBuffer action flags

(defconstant $kSourcePaused 1)
(defconstant $kPassThrough #x10000)
(defconstant $kNoSoundComponentChain #x20000)
; SoundParamBlock flags, usefull for OpenMixerSoundComponent

(defconstant $kNoMixing 1)                      ; don't mix source

(defconstant $kNoSampleRateConversion 2)        ; don't convert sample rate (i.e. 11 kHz -> 22 kHz)

(defconstant $kNoSampleSizeConversion 4)        ; don't convert sample size (i.e. 16 -> 8)

(defconstant $kNoSampleFormatConversion 8)      ; don't convert sample format (i.e. 'twos' -> 'raw ')

(defconstant $kNoChannelConversion 16)          ; don't convert stereo/mono

(defconstant $kNoDecompression 32)              ; don't decompress (i.e. 'MAC3' -> 'raw ')

(defconstant $kNoVolumeConversion 64)           ; don't apply volume

(defconstant $kNoRealtimeProcessing #x80)       ; won't run at interrupt time

(defconstant $kScheduledSource #x100)           ; source is scheduled

(defconstant $kNonInterleavedBuffer #x200)      ; buffer is not interleaved samples

(defconstant $kNonPagingMixer #x400)            ; if VM is on, use the non-paging mixer

(defconstant $kSoundConverterMixer #x800)       ; the mixer is to be used by the SoundConverter

(defconstant $kPagingMixer #x1000)              ; the mixer is to be used as a paging mixer when VM is on

(defconstant $kVMAwareMixer #x2000)             ; passed to the output device when the SM is going to deal with VM safety
; SoundComponentData record is actually an ExtendedSoundComponentData

(defconstant $kExtendedSoundData #x4000)
; SoundParamBlock quality settings
; use interpolation in rate conversion

(defconstant $kBestQuality 1)
; useful bit masks

(defconstant $kInputMask #xFF)                  ; masks off input bits

(defconstant $kOutputMask #xFF00)               ; masks off output bits

(defconstant $kOutputShift 8)                   ; amount output bits are shifted

(defconstant $kActionMask #xFF0000)             ; masks off action bits

(defconstant $kSoundComponentBits #xFFFFFF)
; audio atom types

(defconstant $kAudioFormatAtomType :|frma|)
(defconstant $kAudioEndianAtomType :|enda|)
(defconstant $kAudioVBRAtomType :|vbra|)
(defconstant $kAudioTerminatorAtomType 0)
; siAVDisplayBehavior types

(defconstant $kAVDisplayHeadphoneRemove 0)      ;  monitor does not have a headphone attached

(defconstant $kAVDisplayHeadphoneInsert 1)      ;  monitor has a headphone attached

(defconstant $kAVDisplayPlainTalkRemove 2)      ;  monitor either sending no input through CPU input port or unable to tell if input is coming in

(defconstant $kAVDisplayPlainTalkInsert 3)      ;  monitor sending PlainTalk level microphone source input through sound input port

; Audio Component constants
; Values for whichChannel parameter

(defconstant $audioAllChannels 0)               ; All channels (usually interpreted as both left and right)

(defconstant $audioLeftChannel 1)               ; Left channel

(defconstant $audioRightChannel 2)              ; Right channel
; Values for mute parameter

(defconstant $audioUnmuted 0)                   ; Device is unmuted

(defconstant $audioMuted 1)                     ; Device is muted
; Capabilities flags definitions

(defconstant $audioDoesMono 1)                  ; Device supports mono output

(defconstant $audioDoesStereo 2)                ; Device supports stereo output
; Device supports independent software control of each channel

(defconstant $audioDoesIndependentChannels 4)
; Sound Input Qualities

(defconstant $siCDQuality :|cd  |)              ; 44.1kHz, stereo, 16 bit

(defconstant $siBestQuality :|best|)            ; 22kHz, mono, 8 bit

(defconstant $siBetterQuality :|betr|)          ; 22kHz, mono, MACE 3:1

(defconstant $siGoodQuality :|good|)            ; 22kHz, mono, MACE 6:1

(defconstant $siNoneQuality :|none|)            ; settings don't match any quality for a get call


(defconstant $siDeviceIsConnected 1)            ; input device is connected and ready for input

(defconstant $siDeviceNotConnected 0)           ; input device is not connected

(defconstant $siDontKnowIfConnected -1)         ; can't tell if input device is connected

(defconstant $siReadPermission 0)               ; permission passed to SPBOpenDevice

(defconstant $siWritePermission 1)              ; permission passed to SPBOpenDevice

; flags that SoundConverterFillBuffer will return

(defconstant $kSoundConverterDidntFillBuffer 1) ; set if the converter couldn't completely satisfy a SoundConverterFillBuffer request
; set if the converter had left over data after completely satisfying a SoundConverterFillBuffer call

(defconstant $kSoundConverterHasLeftOverData 2)
;  flags for extendedFlags fields of ExtendedSoundComponentData, ExtendedSoundParamBlock, and ExtendedScheduledSoundHeader

(defconstant $kExtendedSoundSampleCountNotValid 1);  set if sampleCount of SoundComponentData isn't meaningful; use buffer size instead

(defconstant $kExtendedSoundBufferSizeValid 2)  ;  set if bufferSize field is valid

(defconstant $kExtendedSoundFrameSizesValid 4)  ;  set if frameSizesArray is valid (will be nil if all sizes are common and kExtendedSoundCommonFrameSizeValid is set

(defconstant $kExtendedSoundCommonFrameSizeValid 8);  set if all audio frames have the same size and the commonFrameSize field is valid

(defconstant $kExtendedSoundExtensionsValid 16) ;  set if pointer to extensions array is valid
;  set if buffer flags field is valid

(defconstant $kExtendedSoundBufferFlagsValid 32)
;  flags passed in bufferFlags/bufferFlagsMask extended fields if kExtendedSoundBufferFlagsValid extended flag is set

(defconstant $kExtendedSoundBufferIsDiscontinuous 1);  buffer is discontinuous with previous buffer
;  buffer is first buffer

(defconstant $kExtendedSoundBufferIsFirstBuffer 2)
; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    typedefs
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
(defrecord SndCommand
   (cmd :UInt16)
   (param1 :SInt16)
   (param2 :signed-long)
)

;type name? (%define-record :SndCommand (find-record-descriptor ':SndCommand))

;type name? (def-mactype :SndChannel (find-mactype ':SndChannel))

(def-mactype :SndChannelPtr (find-mactype '(:pointer :SndChannel)))

(def-mactype :SndCallBackProcPtr (find-mactype ':pointer)); (SndChannelPtr chan , SndCommand * cmd)

(def-mactype :SndCallBackUPP (find-mactype '(:pointer :OpaqueSndCallBackProcPtr)))
(defrecord SndChannel
   (nextChan (:pointer :SndChannel))
   (firstMod :pointer)                          ;  reserved for the Sound Manager 
   (callBack (:pointer :OpaqueSndCallBackProcPtr))
   (userInfo :signed-long)
   (wait :signed-long)                          ;  The following is for internal Sound Manager use only.
   (cmdInProgress :SndCommand)
   (flags :SInt16)
   (qLength :SInt16)
   (qHead :SInt16)
   (qTail :SInt16)
   (queue (:array :SndCommand 128))
)
; 
;  *  NewSndCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSndCallBackUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSndCallBackProcPtr)
() )
; 
;  *  DisposeSndCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSndCallBackUPP" 
   ((userUPP (:pointer :OpaqueSndCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSndCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSndCallBackUPP" 
   ((chan (:pointer :SNDCHANNEL))
    (cmd (:pointer :SndCommand))
    (userUPP (:pointer :OpaqueSndCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; MACE structures
(defrecord StateBlock
   (stateVar (:array :SInt16 64))
)

;type name? (%define-record :StateBlock (find-record-descriptor ':StateBlock))

(def-mactype :StateBlockPtr (find-mactype '(:pointer :StateBlock)))
(defrecord LeftOverBlock
   (count :UInt32)
   (sampleArea (:array :SInt8 32))
)

;type name? (%define-record :LeftOverBlock (find-record-descriptor ':LeftOverBlock))

(def-mactype :LeftOverBlockPtr (find-mactype '(:pointer :LeftOverBlock)))
(defrecord ModRef
   (modNumber :UInt16)
   (modInit :signed-long)
)

;type name? (%define-record :ModRef (find-record-descriptor ':ModRef))
(defrecord SndListResource
   (format :SInt16)
   (numModifiers :SInt16)
   (modifierPart (:array :ModRef 1))
   (numCommands :SInt16)
   (commandPart (:array :SndCommand 1))
   (dataPart (:array :UInt8 1))
)

;type name? (%define-record :SndListResource (find-record-descriptor ':SndListResource))

(def-mactype :SndListPtr (find-mactype '(:pointer :SndListResource)))

(def-mactype :SndListHandle (find-mactype '(:handle :SndListResource)))

(def-mactype :SndListHndl (find-mactype ':SndListHandle))
; HyperCard sound resource format
(defrecord Snd2ListResource
   (format :SInt16)
   (refCount :SInt16)
   (numCommands :SInt16)
   (commandPart (:array :SndCommand 1))
   (dataPart (:array :UInt8 1))
)

;type name? (%define-record :Snd2ListResource (find-record-descriptor ':Snd2ListResource))

(def-mactype :Snd2ListPtr (find-mactype '(:pointer :Snd2ListResource)))

(def-mactype :Snd2ListHandle (find-mactype '(:handle :Snd2ListResource)))

(def-mactype :Snd2ListHndl (find-mactype ':Snd2ListHandle))
(defrecord SoundHeader
   (samplePtr :pointer)                         ; if NIL then samples are in sampleArea
   (length :UInt32)                             ; length of sound in bytes
   (sampleRate :UInt32)                         ; sample rate for this sound
   (loopStart :UInt32)                          ; start of looping portion
   (loopEnd :UInt32)                            ; end of looping portion
   (encode :UInt8)                              ; header encoding
   (baseFrequency :UInt8)                       ; baseFrequency value
   (sampleArea (:array :UInt8 1))               ; space for when samples follow directly
)

;type name? (%define-record :SoundHeader (find-record-descriptor ':SoundHeader))

(def-mactype :SoundHeaderPtr (find-mactype '(:pointer :SoundHeader)))
(defrecord CmpSoundHeader
   (samplePtr :pointer)                         ; if nil then samples are in sample area
   (numChannels :UInt32)                        ; number of channels i.e. mono = 1
   (sampleRate :UInt32)                         ; sample rate in Apples Fixed point representation
   (loopStart :UInt32)                          ; loopStart of sound before compression
   (loopEnd :UInt32)                            ; loopEnd of sound before compression
   (encode :UInt8)                              ; data structure used , stdSH, extSH, or cmpSH
   (baseFrequency :UInt8)                       ; same meaning as regular SoundHeader
   (numFrames :UInt32)                          ; length in frames ( packetFrames or sampleFrames )
   (AIFFSampleRate :Float80)                    ; IEEE sample rate
   (markerChunk :pointer)                       ; sync track
   (format :OSType)                             ; data format type, was futureUse1
   (futureUse2 :UInt32)                         ; reserved by Apple
   (stateVars (:pointer :StateBlock))           ; pointer to State Block
   (leftOverSamples (:pointer :LeftOverBlock))  ; used to save truncated samples between compression calls
   (compressionID :SInt16)                      ; 0 means no compression, non zero means compressionID
   (packetSize :UInt16)                         ; number of bits in compressed sample packet
   (snthID :UInt16)                             ; resource ID of Sound Manager snth that contains NRT C/E
   (sampleSize :UInt16)                         ; number of bits in non-compressed sample
   (sampleArea (:array :UInt8 1))               ; space for when samples follow directly
)

;type name? (%define-record :CmpSoundHeader (find-record-descriptor ':CmpSoundHeader))

(def-mactype :CmpSoundHeaderPtr (find-mactype '(:pointer :CmpSoundHeader)))
(defrecord ExtSoundHeader
   (samplePtr :pointer)                         ; if nil then samples are in sample area
   (numChannels :UInt32)                        ; number of channels,  ie mono = 1
   (sampleRate :UInt32)                         ; sample rate in Apples Fixed point representation
   (loopStart :UInt32)                          ; same meaning as regular SoundHeader
   (loopEnd :UInt32)                            ; same meaning as regular SoundHeader
   (encode :UInt8)                              ; data structure used , stdSH, extSH, or cmpSH
   (baseFrequency :UInt8)                       ; same meaning as regular SoundHeader
   (numFrames :UInt32)                          ; length in total number of frames
   (AIFFSampleRate :Float80)                    ; IEEE sample rate
   (markerChunk :pointer)                       ; sync track
   (instrumentChunks :pointer)                  ; AIFF instrument chunks
   (AESRecording :pointer)
   (sampleSize :UInt16)                         ; number of bits in sample
   (futureUse1 :UInt16)                         ; reserved by Apple
   (futureUse2 :UInt32)                         ; reserved by Apple
   (futureUse3 :UInt32)                         ; reserved by Apple
   (futureUse4 :UInt32)                         ; reserved by Apple
   (sampleArea (:array :UInt8 1))               ; space for when samples follow directly
)

;type name? (%define-record :ExtSoundHeader (find-record-descriptor ':ExtSoundHeader))

(def-mactype :ExtSoundHeaderPtr (find-mactype '(:pointer :ExtSoundHeader)))
(defrecord SoundHeaderUnion
   (:variant
   (
   (stdHeader :SoundHeader)
   )
   (
   (cmpHeader :CmpSoundHeader)
   )
   (
   (extHeader :ExtSoundHeader)
   )
   )
)

;type name? (%define-record :SoundHeaderUnion (find-record-descriptor ':SoundHeaderUnion))
(defrecord ConversionBlock
   (destination :SInt16)
   (unused :SInt16)
   (inputPtr (:pointer :CmpSoundHeader))
   (outputPtr (:pointer :CmpSoundHeader))
)

;type name? (%define-record :ConversionBlock (find-record-descriptor ':ConversionBlock))

(def-mactype :ConversionBlockPtr (find-mactype '(:pointer :ConversionBlock)))
;  ScheduledSoundHeader flags

(defconstant $kScheduledSoundDoScheduled 1)
(defconstant $kScheduledSoundDoCallBack 2)
(defconstant $kScheduledSoundExtendedHdr 4)
(defrecord ScheduledSoundHeader
   (u :SoundHeaderUnion)
   (flags :signed-long)
   (reserved :SInt16)
   (callBackParam1 :SInt16)
   (callBackParam2 :signed-long)
   (startTime :TimeRecord)
)

;type name? (%define-record :ScheduledSoundHeader (find-record-descriptor ':ScheduledSoundHeader))

(def-mactype :ScheduledSoundHeaderPtr (find-mactype '(:pointer :ScheduledSoundHeader)))
(defrecord ExtendedScheduledSoundHeader
   (u :SoundHeaderUnion)
   (flags :signed-long)
   (reserved :SInt16)
   (callBackParam1 :SInt16)
   (callBackParam2 :signed-long)
   (startTime :TimeRecord)
   (recordSize :signed-long)
   (extendedFlags :signed-long)
   (bufferSize :signed-long)
   (frameCount :signed-long)                    ;  number of audio frames
   (frameSizesArray (:pointer :long))           ;  pointer to array of longs with frame sizes in bytes
   (commonFrameSize :signed-long)               ;  size of each frame if common
   (extensionsPtr :pointer)                     ; pointer to set of classic atoms (size,type,data,...)
   (extensionsSize :signed-long)                ; size of extensions data (extensionsPtr)
   (bufferFlags :UInt32)                        ; set or cleared flags
   (bufferFlagsMask :UInt32)                    ; which flags are valid
)

;type name? (%define-record :ExtendedScheduledSoundHeader (find-record-descriptor ':ExtendedScheduledSoundHeader))

(def-mactype :ExtendedScheduledSoundHeaderPtr (find-mactype '(:pointer :ExtendedScheduledSoundHeader)))
(defrecord SMStatus
   (smMaxCPULoad :SInt16)
   (smNumChannels :SInt16)
   (smCurCPULoad :SInt16)
)

;type name? (%define-record :SMStatus (find-record-descriptor ':SMStatus))

(def-mactype :SMStatusPtr (find-mactype '(:pointer :SMStatus)))
(defrecord SCStatus
   (scStartTime :UInt32)
   (scEndTime :UInt32)
   (scCurrentTime :UInt32)
   (scChannelBusy :Boolean)
   (scChannelDisposed :Boolean)
   (scChannelPaused :Boolean)
   (scUnused :Boolean)
   (scChannelAttributes :UInt32)
   (scCPULoad :signed-long)
)

;type name? (%define-record :SCStatus (find-record-descriptor ':SCStatus))

(def-mactype :SCStatusPtr (find-mactype '(:pointer :SCStatus)))
(defrecord AudioSelection
   (unitType :signed-long)
   (selStart :UInt32)
   (selEnd :UInt32)
)

;type name? (%define-record :AudioSelection (find-record-descriptor ':AudioSelection))

(def-mactype :AudioSelectionPtr (find-mactype '(:pointer :AudioSelection)))

; #if CALL_NOT_IN_CARBON
#| 
(defrecord SndDoubleBuffer
   (dbNumFrames :signed-long)
   (dbFlags :signed-long)
   (dbUserInfo (:array :signed-long 2))
   (dbSoundData (:array :SInt8 1))
)

;type name? (def-mactype :SndDoubleBuffer (find-mactype ':SndDoubleBuffer))

(def-mactype :SndDoubleBufferPtr (find-mactype '(:pointer :SndDoubleBuffer)))

(def-mactype :SndDoubleBackProcPtr (find-mactype ':pointer)); (SndChannelPtr channel , SndDoubleBufferPtr doubleBufferPtr)

(def-mactype :SndDoubleBackUPP (find-mactype '(:pointer :OpaqueSndDoubleBackProcPtr)))
; 
;  *  NewSndDoubleBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeSndDoubleBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeSndDoubleBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
(defrecord SndDoubleBufferHeader
   (dbhNumChannels :SInt16)
   (dbhSampleSize :SInt16)
   (dbhCompressionID :SInt16)
   (dbhPacketSize :SInt16)
   (dbhSampleRate :UInt32)
   (dbhBufferPtr (:array :SndDoubleBufferPtr 2))
   (dbhDoubleBack :SndDoubleBackUPP)
)

;type name? (def-mactype :SndDoubleBufferHeader (find-mactype ':SndDoubleBufferHeader))

(def-mactype :SndDoubleBufferHeaderPtr (find-mactype '(:pointer :SndDoubleBufferHeader)))
(defrecord SndDoubleBufferHeader2
   (dbhNumChannels :SInt16)
   (dbhSampleSize :SInt16)
   (dbhCompressionID :SInt16)
   (dbhPacketSize :SInt16)
   (dbhSampleRate :UInt32)
   (dbhBufferPtr (:array :SndDoubleBufferPtr 2))
   (dbhDoubleBack :SndDoubleBackUPP)
   (dbhFormat :OSType)
)

;type name? (def-mactype :SndDoubleBufferHeader2 (find-mactype ':SndDoubleBufferHeader2))

(def-mactype :SndDoubleBufferHeader2Ptr (find-mactype '(:pointer :SndDoubleBufferHeader2)))
 |#

; #endif  /* CALL_NOT_IN_CARBON */

(defrecord SoundInfoList
   (count :SInt16)
   (infoHandle :Handle)
)

;type name? (%define-record :SoundInfoList (find-record-descriptor ':SoundInfoList))

(def-mactype :SoundInfoListPtr (find-mactype '(:pointer :SoundInfoList)))
(defrecord SoundComponentData
   (flags :signed-long)
   (format :OSType)
   (numChannels :SInt16)
   (sampleSize :SInt16)
   (sampleRate :UInt32)
   (sampleCount :signed-long)
   (buffer (:pointer :Byte))
   (reserved :signed-long)
)

;type name? (%define-record :SoundComponentData (find-record-descriptor ':SoundComponentData))

(def-mactype :SoundComponentDataPtr (find-mactype '(:pointer :SoundComponentData)))
(defrecord ExtendedSoundComponentData
   (desc :SoundComponentData)                   ; description of sound buffer
   (recordSize :signed-long)                    ; size of this record in bytes
   (extendedFlags :signed-long)                 ; flags for extended record
   (bufferSize :signed-long)                    ; size of buffer in bytes
   (frameCount :signed-long)                    ; number of audio frames
   (frameSizesArray (:pointer :long))           ; pointer to array of longs with frame sizes in bytes
   (commonFrameSize :signed-long)               ; size of each frame if common
   (extensionsPtr :pointer)                     ; pointer to set of classic atoms (size,type,data,...)
   (extensionsSize :signed-long)                ; size of extensions data (extensionsPtr)
   (bufferFlags :UInt32)                        ; set or cleared flags
   (bufferFlagsMask :UInt32)                    ; which flags are valid
)

;type name? (%define-record :ExtendedSoundComponentData (find-record-descriptor ':ExtendedSoundComponentData))

(def-mactype :ExtendedSoundComponentDataPtr (find-mactype '(:pointer :ExtendedSoundComponentData)))

;type name? (def-mactype :SoundParamBlock (find-mactype ':SoundParamBlock))

(def-mactype :SoundParamBlockPtr (find-mactype '(:pointer :SoundParamBlock)))

(def-mactype :SoundParamProcPtr (find-mactype ':pointer)); (SoundParamBlockPtr * pb)

(def-mactype :SoundParamUPP (find-mactype '(:pointer :OpaqueSoundParamProcPtr)))
(defrecord SoundParamBlock
   (recordSize :signed-long)                    ; size of this record in bytes
   (desc :SoundComponentData)                   ; description of sound buffer
   (rateMultiplier :UInt32)                     ; rate multiplier to apply to sound
   (leftVolume :SInt16)                         ; volumes to apply to sound
   (rightVolume :SInt16)
   (quality :signed-long)                       ; quality to apply to sound
   (filter (:pointer :ComponentInstanceRecord)) ; filter to apply to sound
   (moreRtn (:pointer :OpaqueSoundParamProcPtr)); routine to call to get more data
   (completionRtn (:pointer :OpaqueSoundParamProcPtr)); routine to call when buffer is complete
   (refCon :signed-long)                        ; user refcon
   (result :SInt16)                             ; result
)
(defrecord ExtendedSoundParamBlock
   (pb :SOUNDPARAMBLOCK)                        ; classic SoundParamBlock except recordSize == sizeof(ExtendedSoundParamBlock)
   (reserved :SInt16)
   (extendedFlags :signed-long)                 ; flags
   (bufferSize :signed-long)                    ; size of buffer in bytes
   (frameCount :signed-long)                    ; number of audio frames
   (frameSizesArray (:pointer :long))           ; pointer to array of longs with frame sizes in bytes
   (commonFrameSize :signed-long)               ; size of each frame if common
   (extensionsPtr :pointer)                     ; pointer to set of classic atoms (size,type,data,...)
   (extensionsSize :signed-long)                ; size of extensions data (extensionsPtr)
   (bufferFlags :UInt32)                        ; set or cleared flags
   (bufferFlagsMask :UInt32)                    ; which flags are valid
)

;type name? (%define-record :ExtendedSoundParamBlock (find-record-descriptor ':ExtendedSoundParamBlock))

(def-mactype :ExtendedSoundParamBlockPtr (find-mactype '(:pointer :ExtendedSoundParamBlock)))
(defrecord CompressionInfo
   (recordSize :signed-long)
   (format :OSType)
   (compressionID :SInt16)
   (samplesPerPacket :UInt16)
   (bytesPerPacket :UInt16)
   (bytesPerFrame :UInt16)
   (bytesPerSample :UInt16)
   (futureUse1 :UInt16)
)

;type name? (%define-record :CompressionInfo (find-record-descriptor ':CompressionInfo))

(def-mactype :CompressionInfoPtr (find-mactype '(:pointer :CompressionInfo)))

(def-mactype :CompressionInfoHandle (find-mactype '(:handle :CompressionInfo)))
; variables for floating point conversion
(defrecord SoundSlopeAndInterceptRecord
   (slope :double-float)
   (intercept :double-float)
   (minClip :double-float)
   (maxClip :double-float)
)

;type name? (%define-record :SoundSlopeAndInterceptRecord (find-record-descriptor ':SoundSlopeAndInterceptRecord))

(def-mactype :SoundSlopeAndInterceptPtr (find-mactype '(:pointer :SoundSlopeAndInterceptRecord)))
; private thing to use as a reference to a Sound Converter

(def-mactype :SoundConverter (find-mactype '(:pointer :OpaqueSoundConverter)))
; callback routine to provide data to the Sound Converter

(def-mactype :SoundConverterFillBufferDataProcPtr (find-mactype ':pointer)); (SoundComponentDataPtr * data , void * refCon)

(def-mactype :SoundConverterFillBufferDataUPP (find-mactype '(:pointer :OpaqueSoundConverterFillBufferDataProcPtr)))
; private thing to use as a reference to a Sound Source

(def-mactype :SoundSource (find-mactype '(:pointer :OpaqueSoundSource)))

(def-mactype :SoundSourcePtr (find-mactype '(:handle :OpaqueSoundSource)))
(defrecord SoundComponentLink
   (description :ComponentDescription)          ; Describes the sound component
   (mixerID (:pointer :OpaqueSoundSource))      ; Reserved by Apple
   (linkID (:pointer :SoundSource))             ; Reserved by Apple
)

;type name? (%define-record :SoundComponentLink (find-record-descriptor ':SoundComponentLink))

(def-mactype :SoundComponentLinkPtr (find-mactype '(:pointer :SoundComponentLink)))
(defrecord AudioInfo
   (capabilitiesFlags :signed-long)             ; Describes device capabilities
   (reserved :signed-long)                      ; Reserved by Apple
   (numVolumeSteps :UInt16)                     ; Number of significant increments between min and max volume
)

;type name? (%define-record :AudioInfo (find-record-descriptor ':AudioInfo))

(def-mactype :AudioInfoPtr (find-mactype '(:pointer :AudioInfo)))
(defrecord AudioFormatAtom
   (size :signed-long)                          ;  = sizeof(AudioFormatAtom)
   (atomType :OSType)                           ;  = kAudioFormatAtomType
   (format :OSType)
)

;type name? (%define-record :AudioFormatAtom (find-record-descriptor ':AudioFormatAtom))

(def-mactype :AudioFormatAtomPtr (find-mactype '(:pointer :AudioFormatAtom)))
(defrecord AudioEndianAtom
   (size :signed-long)                          ;  = sizeof(AudioEndianAtom)
   (atomType :OSType)                           ;  = kAudioEndianAtomType
   (littleEndian :SInt16)
)

;type name? (%define-record :AudioEndianAtom (find-record-descriptor ':AudioEndianAtom))

(def-mactype :AudioEndianAtomPtr (find-mactype '(:pointer :AudioEndianAtom)))
(defrecord AudioTerminatorAtom
   (size :signed-long)                          ;  = sizeof(AudioTerminatorAtom)
   (atomType :OSType)                           ;  = kAudioTerminatorAtomType
)

;type name? (%define-record :AudioTerminatorAtom (find-record-descriptor ':AudioTerminatorAtom))

(def-mactype :AudioTerminatorAtomPtr (find-mactype '(:pointer :AudioTerminatorAtom)))
(defrecord LevelMeterInfo
   (numChannels :SInt16)                        ;  mono or stereo source
   (leftMeter :UInt8)                           ;  0-255 range
   (rightMeter :UInt8)                          ;  0-255 range
)

;type name? (%define-record :LevelMeterInfo (find-record-descriptor ':LevelMeterInfo))

(def-mactype :LevelMeterInfoPtr (find-mactype '(:pointer :LevelMeterInfo)))
(defrecord EQSpectrumBandsRecord
   (count :SInt16)
   (frequency (:pointer :UInt32))               ;  pointer to array of frequencies
)

;type name? (%define-record :EQSpectrumBandsRecord (find-record-descriptor ':EQSpectrumBandsRecord))

(def-mactype :EQSpectrumBandsRecordPtr (find-mactype '(:pointer :EQSpectrumBandsRecord)))

(defconstant $kSoundAudioCodecPropertyWritableFlag 1)
(defrecord SoundAudioCodecPropertyRequestParams
   (propertyClass :UInt32)
   (propertyID :UInt32)
   (propertyDataSize :UInt32)                   ;  out -- GetPropertyInfo, in/out -- GetProperty, in -- SetProperty
   (propertyData :pointer)                      ;  in -- GetPropertyInfo, GetProperty, SetProperty
   (propertyRequestFlags :UInt32)               ;  out -- GetPropertyInfo
   (propertyDataType :UInt32)                   ;  out -- GetPropertyInfo, often 0
   (propertyRequestResult :signed-long)         ;  out -- GetPropertyInfo, GetProperty, SetProperty
)

;type name? (%define-record :SoundAudioCodecPropertyRequestParams (find-record-descriptor ':SoundAudioCodecPropertyRequestParams))
;  Sound Input Structures

;type name? (def-mactype :SPB (find-mactype ':SPB))

(def-mactype :SPBPtr (find-mactype '(:pointer :SPB)))
; user procedures called by sound input routines

(def-mactype :SIInterruptProcPtr (find-mactype ':pointer)); (SPBPtr inParamPtr , Ptr dataBuffer , short peakAmplitude , long sampleSize)

(def-mactype :SICompletionProcPtr (find-mactype ':pointer)); (SPBPtr inParamPtr)

(def-mactype :SIInterruptUPP (find-mactype '(:pointer :OpaqueSIInterruptProcPtr)))

(def-mactype :SICompletionUPP (find-mactype '(:pointer :OpaqueSICompletionProcPtr)))
; Sound Input Parameter Block
(defrecord SPB
   (inRefNum :signed-long)                      ; reference number of sound input device
   (count :UInt32)                              ; number of bytes to record
   (milliseconds :UInt32)                       ; number of milliseconds to record
   (bufferLength :UInt32)                       ; length of buffer in bytes
   (bufferPtr :pointer)                         ; buffer to store sound data in
   (completionRoutine (:pointer :OpaqueSICompletionProcPtr)); completion routine
   (interruptRoutine (:pointer :OpaqueSIInterruptProcPtr)); interrupt routine
   (userLong :signed-long)                      ; user-defined field
   (error :SInt16)                              ; error
   (unused1 :signed-long)                       ; reserved - must be zero
)
; 
;  *  NewSoundParamUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSoundParamUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSoundParamProcPtr)
() )
; 
;  *  NewSoundConverterFillBufferDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSoundConverterFillBufferDataUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSoundConverterFillBufferDataProcPtr)
() )
; 
;  *  NewSIInterruptUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSIInterruptUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSIInterruptProcPtr)
() )
; 
;  *  NewSICompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSICompletionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSICompletionProcPtr)
() )
; 
;  *  DisposeSoundParamUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSoundParamUPP" 
   ((userUPP (:pointer :OpaqueSoundParamProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSoundConverterFillBufferDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSoundConverterFillBufferDataUPP" 
   ((userUPP (:pointer :OpaqueSoundConverterFillBufferDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSIInterruptUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSIInterruptUPP" 
   ((userUPP (:pointer :OpaqueSIInterruptProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSICompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSICompletionUPP" 
   ((userUPP (:pointer :OpaqueSICompletionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSoundParamUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSoundParamUPP" 
   ((pb (:pointer :SOUNDPARAMBLOCKPTR))
    (userUPP (:pointer :OpaqueSoundParamProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeSoundConverterFillBufferDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSoundConverterFillBufferDataUPP" 
   ((data (:pointer :SOUNDCOMPONENTDATAPTR))
    (refCon :pointer)
    (userUPP (:pointer :OpaqueSoundConverterFillBufferDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeSIInterruptUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSIInterruptUPP" 
   ((inParamPtr (:pointer :SPB))
    (dataBuffer :pointer)
    (peakAmplitude :SInt16)
    (sampleSize :signed-long)
    (userUPP (:pointer :OpaqueSIInterruptProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSICompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSICompletionUPP" 
   ((inParamPtr (:pointer :SPB))
    (userUPP (:pointer :OpaqueSICompletionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

(def-mactype :FilePlayCompletionProcPtr (find-mactype ':pointer)); (SndChannelPtr chan)

(def-mactype :FilePlayCompletionUPP (find-mactype '(:pointer :OpaqueFilePlayCompletionProcPtr)))
; 
;  *  NewFilePlayCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeFilePlayCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeFilePlayCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;    prototypes
;   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
;  Sound Manager routines 
; 
;  *  SysBeep()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SysBeep" 
   ((duration :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SndDoCommand()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SndDoCommand" 
   ((chan (:pointer :SNDCHANNEL))
    (cmd (:pointer :SndCommand))
    (noWait :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SndDoImmediate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SndDoImmediate" 
   ((chan (:pointer :SNDCHANNEL))
    (cmd (:pointer :SndCommand))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SndNewChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SndNewChannel" 
   ((chan (:pointer :SNDCHANNELPTR))
    (synth :SInt16)
    (init :signed-long)
    (userRoutine (:pointer :OpaqueSndCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SndDisposeChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SndDisposeChannel" 
   ((chan (:pointer :SNDCHANNEL))
    (quietNow :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SndPlay()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SndPlay" 
   ((chan (:pointer :SNDCHANNEL))
    (sndHandle (:Handle :SndListResource))
    (async :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

; #if OLDROUTINENAMES
#| 
; 
;  *  SndAddModifier()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
 |#

; #endif  /* OLDROUTINENAMES */

; 
;  *  SndControl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
;  Sound Manager 2.0 and later, uses _SoundDispatch 
; 
;  *  SndSoundManagerVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SndSoundManagerVersion" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :NumVersion
() )
; 
;  *  SndStartFilePlay()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SndPauseFilePlay()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SndStopFilePlay()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SndChannelStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SndChannelStatus" 
   ((chan (:pointer :SNDCHANNEL))
    (theLength :SInt16)
    (theStatus (:pointer :SCStatus))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SndManagerStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SndManagerStatus" 
   ((theLength :SInt16)
    (theStatus (:pointer :SMStatus))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SndGetSysBeepState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SndGetSysBeepState" 
   ((sysBeepState (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SndSetSysBeepState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SndSetSysBeepState" 
   ((sysBeepState :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SndPlayDoubleBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
;  MACE compression routines, uses _SoundDispatch 
; 
;  *  MACEVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  Comp3to1()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  Exp1to3()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  Comp6to1()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  Exp1to6()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
;  Sound Manager 3.0 and later calls, uses _SoundDispatch 
; 
;  *  GetSysBeepVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetSysBeepVolume" 
   ((level (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetSysBeepVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetSysBeepVolume" 
   ((level :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDefaultOutputVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetDefaultOutputVolume" 
   ((level (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDefaultOutputVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetDefaultOutputVolume" 
   ((level :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetSoundHeaderOffset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetSoundHeaderOffset" 
   ((sndHandle (:Handle :SndListResource))
    (offset (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  UnsignedFixedMulDiv()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_UnsignedFixedMulDiv" 
   ((value :UInt32)
    (multiplier :UInt32)
    (divisor :UInt32)
   )
   :UInt32
() )
; 
;  *  GetCompressionInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_GetCompressionInfo" 
   ((compressionID :SInt16)
    (format :OSType)
    (numChannels :SInt16)
    (sampleSize :SInt16)
    (cp (:pointer :CompressionInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetSoundPreference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SetSoundPreference" 
   ((theType :OSType)
    (name (:pointer :STR255))
    (settings :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetSoundPreference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_GetSoundPreference" 
   ((theType :OSType)
    (name (:pointer :STR255))
    (settings :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  OpenMixerSoundComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_OpenMixerSoundComponent" 
   ((outputDescription (:pointer :SoundComponentData))
    (outputFlags :signed-long)
    (mixerComponent (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CloseMixerSoundComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_CloseMixerSoundComponent" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Sound Manager 3.1 and later calls, uses _SoundDispatch 
; 
;  *  SndGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.1 and later
;  

(deftrap-inline "_SndGetInfo" 
   ((chan (:pointer :SNDCHANNEL))
    (selector :OSType)
    (infoPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SndSetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.1 and later
;  

(deftrap-inline "_SndSetInfo" 
   ((chan (:pointer :SNDCHANNEL))
    (selector :OSType)
    (infoPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetSoundOutputInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.1 and later
;  

(deftrap-inline "_GetSoundOutputInfo" 
   ((outputDevice (:pointer :ComponentRecord))
    (selector :OSType)
    (infoPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetSoundOutputInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.1 and later
;  

(deftrap-inline "_SetSoundOutputInfo" 
   ((outputDevice (:pointer :ComponentRecord))
    (selector :OSType)
    (infoPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Sound Manager 3.2 and later calls, uses _SoundDispatch 
; 
;  *  GetCompressionName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.2 and later
;  

(deftrap-inline "_GetCompressionName" 
   ((compressionType :OSType)
    (compressionName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SoundConverterOpen()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.2 and later
;  

(deftrap-inline "_SoundConverterOpen" 
   ((inputFormat (:pointer :SoundComponentData))
    (outputFormat (:pointer :SoundComponentData))
    (sc (:pointer :SOUNDCONVERTER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SoundConverterClose()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.2 and later
;  

(deftrap-inline "_SoundConverterClose" 
   ((sc (:pointer :OpaqueSoundConverter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SoundConverterGetBufferSizes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.2 and later
;  

(deftrap-inline "_SoundConverterGetBufferSizes" 
   ((sc (:pointer :OpaqueSoundConverter))
    (inputBytesTarget :UInt32)
    (inputFrames (:pointer :UInt32))
    (inputBytes (:pointer :UInt32))
    (outputBytes (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SoundConverterBeginConversion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.2 and later
;  

(deftrap-inline "_SoundConverterBeginConversion" 
   ((sc (:pointer :OpaqueSoundConverter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SoundConverterConvertBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.2 and later
;  

(deftrap-inline "_SoundConverterConvertBuffer" 
   ((sc (:pointer :OpaqueSoundConverter))
    (inputPtr :pointer)
    (inputFrames :UInt32)
    (outputPtr :pointer)
    (outputFrames (:pointer :UInt32))
    (outputBytes (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SoundConverterEndConversion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.2 and later
;  

(deftrap-inline "_SoundConverterEndConversion" 
   ((sc (:pointer :OpaqueSoundConverter))
    (outputPtr :pointer)
    (outputFrames (:pointer :UInt32))
    (outputBytes (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Sound Manager 3.3 and later calls, uses _SoundDispatch 
; 
;  *  SoundConverterGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.3 and later
;  

(deftrap-inline "_SoundConverterGetInfo" 
   ((sc (:pointer :OpaqueSoundConverter))
    (selector :OSType)
    (infoPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SoundConverterSetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.3 and later
;  

(deftrap-inline "_SoundConverterSetInfo" 
   ((sc (:pointer :OpaqueSoundConverter))
    (selector :OSType)
    (infoPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Sound Manager 3.6 and later calls, uses _SoundDispatch 
; 
;  *  SoundConverterFillBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in SoundLib 3.6 and later
;  

(deftrap-inline "_SoundConverterFillBuffer" 
   ((sc (:pointer :OpaqueSoundConverter))
    (fillBufferDataUPP (:pointer :OpaqueSoundConverterFillBufferDataProcPtr))
    (fillBufferDataRefCon :pointer)
    (outputBuffer :pointer)
    (outputBufferByteSize :UInt32)
    (bytesWritten (:pointer :UInt32))
    (framesWritten (:pointer :UInt32))
    (outputFlags (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SoundManagerGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in SoundLib 3.6 and later
;  

(deftrap-inline "_SoundManagerGetInfo" 
   ((selector :OSType)
    (infoPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SoundManagerSetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in SoundLib 3.6 and later
;  

(deftrap-inline "_SoundManagerSetInfo" 
   ((selector :OSType)
    (infoPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   Sound Component Functions
;    basic sound component functions
; 
; 
;  *  SoundComponentInitOutputDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SoundComponentInitOutputDevice" 
   ((ti (:pointer :ComponentInstanceRecord))
    (actions :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SoundComponentSetSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SoundComponentSetSource" 
   ((ti (:pointer :ComponentInstanceRecord))
    (sourceID (:pointer :OpaqueSoundSource))
    (source (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SoundComponentGetSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SoundComponentGetSource" 
   ((ti (:pointer :ComponentInstanceRecord))
    (sourceID (:pointer :OpaqueSoundSource))
    (source (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SoundComponentGetSourceData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SoundComponentGetSourceData" 
   ((ti (:pointer :ComponentInstanceRecord))
    (sourceData (:pointer :SOUNDCOMPONENTDATAPTR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SoundComponentSetOutput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SoundComponentSetOutput" 
   ((ti (:pointer :ComponentInstanceRecord))
    (requested (:pointer :SoundComponentData))
    (actual (:pointer :SOUNDCOMPONENTDATAPTR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  junction methods for the mixer, must be called at non-interrupt level
; 
;  *  SoundComponentAddSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SoundComponentAddSource" 
   ((ti (:pointer :ComponentInstanceRecord))
    (sourceID (:pointer :SoundSource))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SoundComponentRemoveSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SoundComponentRemoveSource" 
   ((ti (:pointer :ComponentInstanceRecord))
    (sourceID (:pointer :OpaqueSoundSource))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  info methods
; 
;  *  SoundComponentGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SoundComponentGetInfo" 
   ((ti (:pointer :ComponentInstanceRecord))
    (sourceID (:pointer :OpaqueSoundSource))
    (selector :OSType)
    (infoPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SoundComponentSetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SoundComponentSetInfo" 
   ((ti (:pointer :ComponentInstanceRecord))
    (sourceID (:pointer :OpaqueSoundSource))
    (selector :OSType)
    (infoPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  control methods
; 
;  *  SoundComponentStartSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SoundComponentStartSource" 
   ((ti (:pointer :ComponentInstanceRecord))
    (count :SInt16)
    (sources (:pointer :SoundSource))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SoundComponentStopSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SoundComponentStopSource" 
   ((ti (:pointer :ComponentInstanceRecord))
    (count :SInt16)
    (sources (:pointer :SoundSource))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SoundComponentPauseSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SoundComponentPauseSource" 
   ((ti (:pointer :ComponentInstanceRecord))
    (count :SInt16)
    (sources (:pointer :SoundSource))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SoundComponentPlaySourceBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_SoundComponentPlaySourceBuffer" 
   ((ti (:pointer :ComponentInstanceRecord))
    (sourceID (:pointer :OpaqueSoundSource))
    (pb (:pointer :SOUNDPARAMBLOCK))
    (actions :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  selectors for component calls 

(defconstant $kSoundComponentInitOutputDeviceSelect 1)
(defconstant $kSoundComponentSetSourceSelect 2)
(defconstant $kSoundComponentGetSourceSelect 3)
(defconstant $kSoundComponentGetSourceDataSelect 4)
(defconstant $kSoundComponentSetOutputSelect 5)
(defconstant $kSoundComponentAddSourceSelect #x101)
(defconstant $kSoundComponentRemoveSourceSelect #x102)
(defconstant $kSoundComponentGetInfoSelect #x103)
(defconstant $kSoundComponentSetInfoSelect #x104)
(defconstant $kSoundComponentStartSourceSelect #x105)
(defconstant $kSoundComponentStopSourceSelect #x106)
(defconstant $kSoundComponentPauseSourceSelect #x107)
(defconstant $kSoundComponentPlaySourceBufferSelect #x108)
; Audio Components
; Volume is described as a value between 0 and 1, with 0 indicating minimum
;   volume and 1 indicating maximum volume; if the device doesn't support
;   software control of volume, then a value of unimpErr is returned, indicating
;   that these functions are not supported by the device
; 
; 
;  *  AudioGetVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  
; 
;  *  AudioSetVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  
; If the device doesn't support software control of mute, then a value of unimpErr is
; returned, indicating that these functions are not supported by the device.
; 
;  *  AudioGetMute()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  
; 
;  *  AudioSetMute()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  
; AudioSetToDefaults causes the associated device to reset its volume and mute values
; (and perhaps other characteristics, e.g. attenuation) to "factory default" settings
; 
;  *  AudioSetToDefaults()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  
; This routine is required; it must be implemented by all audio components
; 
;  *  AudioGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  
; 
;  *  AudioGetBass()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  
; 
;  *  AudioSetBass()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  
; 
;  *  AudioGetTreble()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  
; 
;  *  AudioSetTreble()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  
; 
;  *  AudioGetOutputDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  
; This is routine is private to the AudioVision component.  It enables the watching of the mute key.
; 
;  *  AudioMuteOnEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(defconstant $kDelegatedSoundComponentSelectors #x100)
;  Sound Input Manager routines, uses _SoundDispatch 
; 
;  *  SPBVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBVersion" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :NumVersion
() )
; 
;  *  SndRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SndRecord" 
   ((filterProc (:pointer :OpaqueModalFilterProcPtr))
    (corner :Point)
    (quality :OSType)
    (sndHandle (:pointer :SndListHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SndRecordToFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SPBSignInDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBSignInDevice" 
   ((deviceRefNum :SInt16)
    (deviceName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SPBSignOutDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBSignOutDevice" 
   ((deviceRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SPBGetIndexedDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBGetIndexedDevice" 
   ((count :SInt16)
    (deviceName (:pointer :STR255))
    (deviceIconHandle (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SPBOpenDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBOpenDevice" 
   ((deviceName (:pointer :STR255))
    (permission :SInt16)
    (inRefNum (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SPBCloseDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBCloseDevice" 
   ((inRefNum :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SPBRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBRecord" 
   ((inParamPtr (:pointer :SPB))
    (asynchFlag :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SPBRecordToFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SPBPauseRecording()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBPauseRecording" 
   ((inRefNum :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SPBResumeRecording()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBResumeRecording" 
   ((inRefNum :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SPBStopRecording()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBStopRecording" 
   ((inRefNum :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SPBGetRecordingStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBGetRecordingStatus" 
   ((inRefNum :signed-long)
    (recordingStatus (:pointer :short))
    (meterLevel (:pointer :short))
    (totalSamplesToRecord (:pointer :UInt32))
    (numberOfSamplesRecorded (:pointer :UInt32))
    (totalMsecsToRecord (:pointer :UInt32))
    (numberOfMsecsRecorded (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SPBGetDeviceInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBGetDeviceInfo" 
   ((inRefNum :signed-long)
    (infoType :OSType)
    (infoData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SPBSetDeviceInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBSetDeviceInfo" 
   ((inRefNum :signed-long)
    (infoType :OSType)
    (infoData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SPBMillisecondsToBytes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBMillisecondsToBytes" 
   ((inRefNum :signed-long)
    (milliseconds (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SPBBytesToMilliseconds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SPBBytesToMilliseconds" 
   ((inRefNum :signed-long)
    (byteCount (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetupSndHeader()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetupSndHeader" 
   ((sndHandle (:Handle :SndListResource))
    (numChannels :SInt16)
    (sampleRate :UInt32)
    (sampleSize :SInt16)
    (compressionType :OSType)
    (baseNote :SInt16)
    (numBytes :UInt32)
    (headerLen (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetupAIFFHeader()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetupAIFFHeader" 
   ((fRefNum :SInt16)
    (numChannels :SInt16)
    (sampleRate :UInt32)
    (sampleSize :SInt16)
    (compressionType :OSType)
    (numBytes :UInt32)
    (numFrames :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Sound Input Manager 1.1 and later calls, uses _SoundDispatch 
; 
;  *  ParseAIFFHeader()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_ParseAIFFHeader" 
   ((fRefNum :SInt16)
    (sndInfo (:pointer :SoundComponentData))
    (numFrames (:pointer :UInt32))
    (dataOffset (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ParseSndHeader()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SoundLib 3.0 and later
;  

(deftrap-inline "_ParseSndHeader" 
   ((sndHandle (:Handle :SndListResource))
    (sndInfo (:pointer :SoundComponentData))
    (numFrames (:pointer :UInt32))
    (dataOffset (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

; #if TARGET_API_MAC_CARBON
;   Only to be used if you are writing a sound input component; this 
;   is the param block for a read request from the SoundMgr to the   
;   sound input component.  Not to be confused with the SPB struct   
;   above, which is the param block for a read request from an app   
;   to the SoundMgr.                                                 

;type name? (def-mactype :SndInputCmpParam (find-mactype ':SndInputCmpParam))

(def-mactype :SndInputCmpParamPtr (find-mactype '(:pointer :SndInputCmpParam)))

(def-mactype :SICCompletionProcPtr (find-mactype ':pointer)); (SndInputCmpParamPtr SICParmPtr)
(defrecord SndInputCmpParam
   (ioCompletion :pointer)                      ;  completion routine [pointer]
   (ioInterrupt :pointer)                       ;  interrupt routine [pointer]
   (ioResult :SInt16)                           ;  I/O result code [word]
   (pad :SInt16)
   (ioReqCount :UInt32)
   (ioActCount :UInt32)
   (ioBuffer :pointer)
   (ioMisc :pointer)
)
; 
;  *  SndInputReadAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SndInputReadAsync" 
   ((self (:pointer :ComponentInstanceRecord))
    (SICParmPtr (:pointer :SNDINPUTCMPPARAM))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SndInputReadSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SndInputReadSync" 
   ((self (:pointer :ComponentInstanceRecord))
    (SICParmPtr (:pointer :SNDINPUTCMPPARAM))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SndInputPauseRecording()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SndInputPauseRecording" 
   ((self (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SndInputResumeRecording()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SndInputResumeRecording" 
   ((self (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SndInputStopRecording()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SndInputStopRecording" 
   ((self (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SndInputGetStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SndInputGetStatus" 
   ((self (:pointer :ComponentInstanceRecord))
    (recordingStatus (:pointer :short))
    (totalSamplesToRecord (:pointer :UInt32))
    (numberOfSamplesRecorded (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SndInputGetDeviceInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SndInputGetDeviceInfo" 
   ((self (:pointer :ComponentInstanceRecord))
    (infoType :OSType)
    (infoData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SndInputSetDeviceInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SndInputSetDeviceInfo" 
   ((self (:pointer :ComponentInstanceRecord))
    (infoType :OSType)
    (infoData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SndInputInitHardware()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SndInputInitHardware" 
   ((self (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  selectors for component calls 

(defconstant $kSndInputReadAsyncSelect 1)
(defconstant $kSndInputReadSyncSelect 2)
(defconstant $kSndInputPauseRecordingSelect 3)
(defconstant $kSndInputResumeRecordingSelect 4)
(defconstant $kSndInputStopRecordingSelect 5)
(defconstant $kSndInputGetStatusSelect 6)
(defconstant $kSndInputGetDeviceInfoSelect 7)
(defconstant $kSndInputSetDeviceInfoSelect 8)
(defconstant $kSndInputInitHardwareSelect 9)

; #endif  /* TARGET_API_MAC_CARBON */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __SOUND__ */


(provide-interface "Sound")