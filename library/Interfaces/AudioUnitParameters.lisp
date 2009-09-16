(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AudioUnitParameters.h"
; at Sunday July 2,2006 7:26:56 pm.
; 
;      File:       AudioUnitParameters.h
;  
;      Contains:   Parameter constants for Apple AudioUnits
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2002 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AudioUnitParameters
; #define __AudioUnitParameters
;  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; The following specifies the equivalent parameterID's for the Group Scope for the standard
; MIDI Controllers. The list is not exhaustive, but represents a recommended set of 
; parameters in Group Scope (and their corresponding MIDI messages) that should be supported
; 
; ParameterID ranges on the Group Scope from 0 < 512 are reserved for usage when Mapping MIDI 
; controllers
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

(defconstant $kAUGroupParameterID_Volume 7)     ;  value 0 < 128

(defconstant $kAUGroupParameterID_Sustain 64)   ;  value 0-63 (off), 64-127 (on)

(defconstant $kAUGroupParameterID_AllNotesOff 123);  value ignored

(defconstant $kAUGroupParameterID_ModWheel 1)   ;  value 0 < 128

(defconstant $kAUGroupParameterID_PitchBend #xE0);  value -8192 - 8191

(defconstant $kAUGroupParameterID_AllSoundOff 120);  value ignored

(defconstant $kAUGroupParameterID_ResetAllControllers 121);  value ignored

(defconstant $kAUGroupParameterID_Pan 10)       ;  value 0 < 128

(defconstant $kAUGroupParameterID_Foot 4)       ;  value 0 < 128

(defconstant $kAUGroupParameterID_ChannelPressure #xD0);  value 0 < 128

(defconstant $kAUGroupParameterID_KeyPressure #xA0);  values 0 < 128

(defconstant $kAUGroupParameterID_Expression 11);  value 0 < 128

(defconstant $kAUGroupParameterID_DataEntry 6)  ;  value 0 < 128

(defconstant $kAUGroupParameterID_Volume_LSB 39);  value 0 < 128

(defconstant $kAUGroupParameterID_ModWheel_LSB 33);  value 0 < 128

(defconstant $kAUGroupParameterID_Pan_LSB 42)   ;  value 0 < 128

(defconstant $kAUGroupParameterID_Foot_LSB 36)  ;  value 0 < 128

(defconstant $kAUGroupParameterID_Expression_LSB 43);  value 0 < 128

(defconstant $kAUGroupParameterID_DataEntry_LSB 38);  value 0 < 128

(defconstant $kAUGroupParameterID_KeyPressure_FirstKey #x100);  value 0 < 128

(defconstant $kAUGroupParameterID_KeyPressure_LastKey #x17F);  value 0 < 128

;  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; A special note on kAUGroupParameterID_KeyPressure (Polyphonic Aftertouch)
; 	Publish this (0xA0) to say you support polyphonic key pressure.
; 	Polyphonic key pressure is not a single control; it is a control for each of the 128
; 		MIDI key numbers.
; 	The key pressure values pairs actualy values are to be get or set in the following parameter range
; 		ParameterID: 256-383
; 		Thus to set/get the value of Poly Key pressure add kAUGroupParameterID_KeyPressure_FirstKey (256)
; 		to the MIDI key number - this becomes the parameter ID
; 		The pressure Value is 0 < 128
; 	Thus to get/set by key value you take the MIDI key number (0 - 127) and add/subtract to/from:
; 		kAUGroupParameterID_KeyPressure_FirstKey
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
;  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; The following file specifies the parameter IDs for the various audio units that apple ships,
; allowing code to directly interact with these parameters without first discovering them
; through the AUParameterInfo mechanism (see AudioUnitProperties.h)
; 
; Each parameter listed below is preceeded by a comment that indicates:
;     // Scope, UnitOfMeasurement, minValue, maxValue, defaultValue
;     
; See AudioUnitProperties for additional information that a parameter may report
; 
; When displaying to the user information about a parameter an application SHOULD ALWAYS
; get the parameter information from the AudioUnit itself
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
;  Effects units
;  Some parameters of effects units are dependent on the sample rate of the audio unit
;  (ie. the maximum value is typically the Nyquist limit, or half the sample rate)
;  Parameters for the BandpassFilter Unit
;  Global, Hz, 20->(SampleRate/2), 5000

(defconstant $kBandpassParam_CenterFrequency 0) ;  Global, Cents, 100->12000, 600

(defconstant $kBandpassParam_Bandwidth 1)
;  Parameters of the AUHipass Unit
;  Global, Hz, 10->(SampleRate/2), 6900

(defconstant $kHipassParam_CutoffFrequency 0)   ;  Global, dB, -20->40, 0

(defconstant $kHipassParam_Resonance 1)
;  Parameters of the AULowpass Unit
;  Global, Hz, 10->(SampleRate/2), 6900

(defconstant $kLowPassParam_CutoffFrequency 0)  ;  Global, dB, -20->40, 0

(defconstant $kLowPassParam_Resonance 1)
;  Parameters of the AUHighShelfFilter
;  Global, Hz, 10000->(SampleRate/2), 10000

(defconstant $kHighShelfParam_CutOffFrequency 0);  Global, dB, -40->40, 0

(defconstant $kHighShelfParam_Gain 1)
;  Parameters of the AULowShelfFilter
;  Global, Hz, 10->200, 80

(defconstant $kAULowShelfParam_CutoffFrequency 0);  Global, dB, -40->40, 0

(defconstant $kAULowShelfParam_Gain 1)
;  Parameters of the AUParametricEQ
;  Global, Hz, 20->(SampleRate/2), 2000

(defconstant $kParametricEQParam_CenterFreq 0)  ;  Global, Hz, 0.1->20, 1.0

(defconstant $kParametricEQParam_Q 1)           ;  Global, dB, -20->20, 0

(defconstant $kParametricEQParam_Gain 2)
;  Parameters of the AUMatrixReverb
;  Global, EqPow CrossFade, 0->100, 100

(defconstant $kReverbParam_DryWetMix 0)         ;  Global, EqPow CrossFade, 0->100, 50

(defconstant $kReverbParam_SmallLargeMix 1)     ;  Global, Secs, 0.005->0.020, 0.06

(defconstant $kReverbParam_SmallSize 2)         ;  Global, Secs, 0.4->10.0, 3.07

(defconstant $kReverbParam_LargeSize 3)         ;  Global, Secs, 0.001->0.03, 0.025

(defconstant $kReverbParam_PreDelay 4)          ;  Global, Secs, 0.001->0.1, 0.035

(defconstant $kReverbParam_LargeDelay 5)        ;  Global, Genr, 0->1, 0.28

(defconstant $kReverbParam_SmallDensity 6)      ;  Global, Genr, 0->1, 0.82

(defconstant $kReverbParam_LargeDensity 7)      ;  Global, Genr, 0->1, 0.3

(defconstant $kReverbParam_LargeDelayRange 8)   ;  Global, Genr, 0.1->1, 0.96

(defconstant $kReverbParam_SmallBrightness 9)   ;  Global, Genr, 0.1->1, 0.49

(defconstant $kReverbParam_LargeBrightness 10)  ;  Global, Genr, 0->1 0.5

(defconstant $kReverbParam_SmallDelayRange 11)  ;  Global, Hz, 0.001->2.0, 1.0

(defconstant $kReverbParam_ModulationRate 12)   ;  Global, Genr, 0.0 -> 1.0, 0.2

(defconstant $kReverbParam_ModulationDepth 13)
;  Parameters for the Delay Unit
;  Global, EqPow Crossfade, 0->100, 50

(defconstant $kDelayParam_WetDryMix 0)          ;  Global, Secs, 0->2, 1

(defconstant $kDelayParam_DelayTime 1)          ;  Global, Percent, -100->100, 50

(defconstant $kDelayParam_Feedback 2)           ;  Global, Hz, 10->(SampleRate/2), 15000

(defconstant $kDelayParam_LopassCutoff 3)
;  Parameters for the AUPeakLimiter
;  Global, Secs, 0.001->0.03, 0.012

(defconstant $kLimiterParam_AttackTime 0)       ;  Global, Secs, 0.001->0.06, 0.024

(defconstant $kLimiterParam_DecayTime 1)        ;  Global, dB, -40->40, 0

(defconstant $kLimiterParam_PreGain 2)
;  Parameters for the AUDynamicsProcessor
;  Global, dB, -40->20, -20

(defconstant $kDynamicsProcessorParam_Threshold 0);  Global, rate, 0.1->40.0, 5

(defconstant $kDynamicsProcessorParam_HeadRoom 1);  Global, rate, 1->50.0, 2

(defconstant $kDynamicsProcessorParam_ExpansionRatio 2);  Global, dB

(defconstant $kDynamicsProcessorParam_ExpansionThreshold 3);  Global, secs, 0.0001->0.2, 0.001

(defconstant $kDynamicsProcessorParam_AttackTime 4);  Global, secs, 0.01->3, 0.05

(defconstant $kDynamicsProcessorParam_ReleaseTime 5);  Global, dB, -40->40, 0

(defconstant $kDynamicsProcessorParam_MasterGain 6);  Global, dB, read-only parameter

(defconstant $kDynamicsProcessorParam_CompressionAmount #x3E8)
;  Parameters for the AUMultibandCompressor

(defconstant $kMultibandCompressorParam_Pregain 0)
(defconstant $kMultibandCompressorParam_Postgain 1)
(defconstant $kMultibandCompressorParam_Crossover1 2)
(defconstant $kMultibandCompressorParam_Crossover2 3)
(defconstant $kMultibandCompressorParam_Crossover3 4)
(defconstant $kMultibandCompressorParam_Threshold1 5)
(defconstant $kMultibandCompressorParam_Threshold2 6)
(defconstant $kMultibandCompressorParam_Threshold3 7)
(defconstant $kMultibandCompressorParam_Threshold4 8)
(defconstant $kMultibandCompressorParam_Headroom1 9)
(defconstant $kMultibandCompressorParam_Headroom2 10)
(defconstant $kMultibandCompressorParam_Headroom3 11)
(defconstant $kMultibandCompressorParam_Headroom4 12)
(defconstant $kMultibandCompressorParam_AttackTime 13)
(defconstant $kMultibandCompressorParam_ReleaseTime 14)
(defconstant $kMultibandCompressorParam_EQ1 15)
(defconstant $kMultibandCompressorParam_EQ2 16)
(defconstant $kMultibandCompressorParam_EQ3 17)
(defconstant $kMultibandCompressorParam_EQ4 18) ;  read-only parameters

(defconstant $kMultibandCompressorParam_CompressionAmount1 #x3E8)
(defconstant $kMultibandCompressorParam_CompressionAmount2 #x7D0)
(defconstant $kMultibandCompressorParam_CompressionAmount3 #xBB8)
(defconstant $kMultibandCompressorParam_CompressionAmount4 #xFA0)
;  Parameters for the AUVarispeed

(defconstant $kVarispeedParam_PlaybackRate 0)
(defconstant $kVarispeedParam_PlaybackCents 1)
;  Mixer Units
;  Parameters for the 3DMixer AudioUnit
;  Input, Degrees, -180->180, 0

(defconstant $k3DMixerParam_Azimuth 0)          ;  Input, Degrees, -90->90, 0

(defconstant $k3DMixerParam_Elevation 1)        ;  Input, Metres, 0->10000, 1

(defconstant $k3DMixerParam_Distance 2)         ;  Input/Output, dB, -120->20, 0

(defconstant $k3DMixerParam_Gain 3)             ;  Input, rate scaler	0.5 -> 2.0

(defconstant $k3DMixerParam_PlaybackRate 4)     ;  read-only

(defconstant $k3DMixerParam_PreAveragePower #x3E8)
(defconstant $k3DMixerParam_PrePeakHoldLevel #x7D0)
(defconstant $k3DMixerParam_PostAveragePower #xBB8)
(defconstant $k3DMixerParam_PostPeakHoldLevel #xFA0)
;  Parameters for the Stereo Mixer AudioUnit
;  Input/Output, Mixer Fader Curve, 0->1, 1

(defconstant $kStereoMixerParam_Volume 0)       ;  Input, Pan, 0->1, 0.5

(defconstant $kStereoMixerParam_Pan 1)          ;  read-only

(defconstant $kStereoMixerParam_PreAveragePower #x3E8)
(defconstant $kStereoMixerParam_PrePeakHoldLevel #x7D0)
(defconstant $kStereoMixerParam_PostAveragePower #xBB8)
(defconstant $kStereoMixerParam_PostPeakHoldLevel #xFA0)
;  Parameters for the Matrix Mixer AudioUnit

(defconstant $kMatrixMixerParam_Volume 0)
(defconstant $kMatrixMixerParam_Enable 1)       ;  read-only
;  these report level in dB, as do the other mixers

(defconstant $kMatrixMixerParam_PreAveragePower #x3E8)
(defconstant $kMatrixMixerParam_PrePeakHoldLevel #x7D0)
(defconstant $kMatrixMixerParam_PostAveragePower #xBB8)
(defconstant $kMatrixMixerParam_PostPeakHoldLevel #xFA0);  these report linear levels - for "expert" use only.

(defconstant $kMatrixMixerParam_PreAveragePowerLinear #x1388)
(defconstant $kMatrixMixerParam_PrePeakHoldLevelLinear #x1770)
(defconstant $kMatrixMixerParam_PostAveragePowerLinear #x1B58)
(defconstant $kMatrixMixerParam_PostPeakHoldLevelLinear #x1F40)
;  Output Units
;  Parameters for the HAL Output Unit (and Default and System Output units)
;  Global, LinearGain, 0->1, 1

(defconstant $kHALOutputParam_Volume 14)
;  Music Device
;  Parameters for the DLSMusicDevice Unit - defined and reported in the global scope
;  Global, Cents, -1200, 1200, 0

(defconstant $kMusicDeviceParam_Tuning 0)       ;  Global, dB, -120->40, 0

(defconstant $kMusicDeviceParam_Volume 1)       ;  Global, dB, -120->40, 0

(defconstant $kMusicDeviceParam_ReverbVolume 2)
;  The music device does NOT currently report parameters in the GroupScope
;  but a parameter value can get set (not get) that corresponds to 
;  controller values that are defined by the MIDI specification
;  This includes the specified MIDI Controller values (for eg. Volume, Mod Wheel, etc)
;  as well as the MIDI status messages (such as PitchWheel 0xE0, ChannelPressure 0xD0 - make sure
;  you pass in zero for the "channel part" when using these as parameterID - to distinguish this 
;  from 0-127 values for midi controllers that will take up the first byte) and the MIDI RPN control messages.
;  Remember, the elementID represents the group or channel number... You can use of course, MusicDeviceMIDIEvent to
;  send a MIDI formatted control command to the device.
;  Using AudioUnitParameterSet with this protocol is done as follows:
; 	scope == kAudioUnitScope_Group
; 	element == groupID -> in MIDI equivalent to channel number 0->15, 
; 			but this is not a limitation of the MusicDevice and values greater than 15 can be specified
; 	paramID == midi controller value (0->127), (status bytes corresponding to pitch bend, channel pressure)
; 	value == typically the range associated with the corresponding MIDI message	(7 bit, 0->127)
; 			pitch bend is specified as a 14 bit value
;  See MusicDevice.h for more comments about using the extended control semantics of this component.	

; #endif //__AudioUnitParameters


(provide-interface "AudioUnitParameters")