(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOAudioDefines.h"
; at Sunday July 2,2006 7:28:26 pm.
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
; #ifndef _IOAUDIODEFINES_H
; #define _IOAUDIODEFINES_H
(defconstant $kIOAudioDeviceClassName "IOAudioDevice")
; #define kIOAudioDeviceClassName		"IOAudioDevice"
(defconstant $kIOAudioEngineClassName "IOAudioEngine")
; #define kIOAudioEngineClassName		"IOAudioEngine"
(defconstant $kIOAudioStreamClassName "IOAudioStream")
; #define kIOAudioStreamClassName		"IOAudioStream"
(defconstant $kIOAudioPortClassName "IOAudioPort")
; #define kIOAudioPortClassName		"IOAudioPort"
(defconstant $kIOAudioControlClassName "IOAudioControl")
; #define kIOAudioControlClassName	"IOAudioControl"
; !
;  * @defined kIOAudioSampleRateKey
;  * @abstract The key in the IORegistry for the IOAudioEngine sample rate attribute
;  * @discussion This value is represented as an integer in samples per second.
;  
(defconstant $kIOAudioSampleRateKey "IOAudioSampleRate")
; #define kIOAudioSampleRateKey				"IOAudioSampleRate"
(defconstant $kIOAudioSampleRateWholeNumberKey "IOAudioSampleRateWholeNumber")
; #define kIOAudioSampleRateWholeNumberKey	"IOAudioSampleRateWholeNumber"
(defconstant $kIOAudioSampleRateFractionKey "IOAudioSampleRateFraction")
; #define kIOAudioSampleRateFractionKey		"IOAudioSampleRateFraction"
; *****
;  *
;  * IOAudioDevice  defines
;  *
;  ****
; !
;  * @defined kIOAudioDeviceNameKey
;  * @abstract The key in the IORegistry for the IOAudioDevice name attribute.
;  
(defconstant $kIOAudioDeviceNameKey "IOAudioDeviceName")
; #define kIOAudioDeviceNameKey				"IOAudioDeviceName"
(defconstant $kIOAudioDeviceShortNameKey "IOAudioDeviceShortName")
; #define kIOAudioDeviceShortNameKey			"IOAudioDeviceShortName"
; !
;  * @defined kIOAudioDeviceManufacturerNameKey
;  * @abstract The key in the IORegistry for the IOAudioDevice manufacturer name attribute.
;  
(defconstant $kIOAudioDeviceManufacturerNameKey "IOAudioDeviceManufacturerName")
; #define kIOAudioDeviceManufacturerNameKey	"IOAudioDeviceManufacturerName"
(defconstant $kIOAudioDeviceLocalizedBundleKey "IOAudioDeviceLocalizedBundle")
; #define kIOAudioDeviceLocalizedBundleKey	"IOAudioDeviceLocalizedBundle"
(defconstant $kIOAudioDeviceTransportTypeKey "IOAudioDeviceTransportType")
; #define kIOAudioDeviceTransportTypeKey		"IOAudioDeviceTransportType"
(defconstant $kIOAudioDeviceConfigurationAppKey "IOAudioDeviceConfigurationApplication")
; #define kIOAudioDeviceConfigurationAppKey	"IOAudioDeviceConfigurationApplication"
; ****
;  *
;  * IOAudioEngine defines
;  *
;  ****
; !
;  * @defined kIOAudioEngineStateKey
;  * @abstract The key in the IORegistry for the IOAudioEngine state atrribute
;  * @discussion The value for this key may be one of: "Running", "Stopped" or "Paused".  Currently the "Paused"
;  *  state is unimplemented.
;  
(defconstant $kIOAudioEngineStateKey "IOAudioEngineState")
; #define kIOAudioEngineStateKey		"IOAudioEngineState"
; !
;  * @defined kIOAudioEngineOutputSampleLatencyKey
;  * @abstract The key in the IORegistry for the IOAudioEngine output sample latency key
;  * @discussion 
;  
(defconstant $kIOAudioEngineOutputSampleLatencyKey "IOAudioEngineOutputSampleLatency")
; #define kIOAudioEngineOutputSampleLatencyKey		"IOAudioEngineOutputSampleLatency"
; !
;  * @defined kIOAudioStreamSampleLatencyKey
;  * @abstract The key in the IORegistry for the IOAudioStream output sample latency key
;  * @discussion Tells the HAL how much latency is on a particular stream.  If two streams
;  * on the same engine have different latencies (e.g. one is analog, one is digital), then
;  * set this property on both streams to inform the HAL of the latency differences.  Alternately,
;  * you can set the engine latency, and just include the latency additional to that for the particular
;  * stream.  The HAL will add the engine and stream latency numbers together to get the total latency.
;  
(defconstant $kIOAudioStreamSampleLatencyKey "IOAudioStreamSampleLatency")
; #define kIOAudioStreamSampleLatencyKey				"IOAudioStreamSampleLatency"
(defconstant $kIOAudioEngineInputSampleLatencyKey "IOAudioEngineInputSampleLatency")
; #define kIOAudioEngineInputSampleLatencyKey			"IOAudioEngineInputSampleLatency"
(defconstant $kIOAudioEngineSampleOffsetKey "IOAudioEngineSampleOffset")
; #define kIOAudioEngineSampleOffsetKey				"IOAudioEngineSampleOffset"
(defconstant $kIOAudioEngineNumSampleFramesPerBufferKey "IOAudioEngineNumSampleFramesPerBuffer")
; #define kIOAudioEngineNumSampleFramesPerBufferKey	"IOAudioEngineNumSampleFramesPerBuffer"
(defconstant $kIOAudioEngineCoreAudioPlugInKey "IOAudioEngineCoreAudioPlugIn")
; #define kIOAudioEngineCoreAudioPlugInKey			"IOAudioEngineCoreAudioPlugIn"
(defconstant $kIOAudioEngineNumActiveUserClientsKey "IOAudioEngineNumActiveUserClients")
; #define kIOAudioEngineNumActiveUserClientsKey		"IOAudioEngineNumActiveUserClients"
(defconstant $kIOAudioEngineUserClientActiveKey "IOAudioEngineUserClientActive")
; #define kIOAudioEngineUserClientActiveKey			"IOAudioEngineUserClientActive"
(defconstant $kIOAudioEngineGlobalUniqueIDKey "IOAudioEngineGlobalUniqueID")
; #define kIOAudioEngineGlobalUniqueIDKey				"IOAudioEngineGlobalUniqueID"
(defconstant $kIOAudioEngineDescriptionKey "IOAudioEngineDescription")
; #define kIOAudioEngineDescriptionKey				"IOAudioEngineDescription"
; !
;  * @defined kIOAudioEngineFullChannelNamesKey
;  * @abstract The key in the IORegistry for the IOAudioEngine's dictionary of fully constructed names for each channel keyed by the device channel
;  * @discussion 
;  
(defconstant $kIOAudioEngineFullChannelNamesKey "IOAudioEngineChannelNames")
; #define	kIOAudioEngineFullChannelNamesKey			"IOAudioEngineChannelNames"
; !
;  * @defined kIOAudioEngineFullChannelNamesKey
;  * @abstract The key in the IORegistry for the IOAudioEngine's dictionary of category names for each channel keyed by the device channel
;  * @discussion 
;  
(defconstant $kIOAudioEngineFullChannelCategoryNamesKey "IOAudioEngineChannelCategoryNames")
; #define	kIOAudioEngineFullChannelCategoryNamesKey	"IOAudioEngineChannelCategoryNames"
; !
;  * @defined kIOAudioEngineFullChannelNamesKey
;  * @abstract The key in the IORegistry for the IOAudioEngine's dictionary of number names for each channel keyed by the device channel
;  * @discussion 
;  
(defconstant $kIOAudioEngineFullChannelNumberNamesKey "IOAudioEngineChannelNumberNames")
; #define	kIOAudioEngineFullChannelNumberNamesKey		"IOAudioEngineChannelNumberNames"
(defconstant $kIOAudioEngineFlavorKey "IOAudioEngineFlavor")
; #define kIOAudioEngineFlavorKey						"IOAudioEngineFlavor"
; ****
;  *
;  * IOAudioStream defines
;  *
;  ****
(defconstant $kIOAudioStreamIDKey "IOAudioStreamID")
; #define kIOAudioStreamIDKey					"IOAudioStreamID"
(defconstant $kIOAudioStreamDescriptionKey "IOAudioStreamDescription")
; #define kIOAudioStreamDescriptionKey		"IOAudioStreamDescription"
(defconstant $kIOAudioStreamNumClientsKey "IOAudioStreamNumClients")
; #define kIOAudioStreamNumClientsKey			"IOAudioStreamNumClients"
; !
;  * @defined kIOAudioStreamDirectionKey
;  * @abstract The key in the IORegistry for the IOAudioStream direction attribute.
;  * @discussion The value for this key may be either "Output" or "Input".
;  
(defconstant $kIOAudioStreamDirectionKey "IOAudioStreamDirection")
; #define kIOAudioStreamDirectionKey				"IOAudioStreamDirection"
(defconstant $kIOAudioStreamStartingChannelIDKey "IOAudioStreamStartingChannelID")
; #define kIOAudioStreamStartingChannelIDKey		"IOAudioStreamStartingChannelID"
(defconstant $kIOAudioStreamStartingChannelNumberKey "IOAudioStreamStartingChannelNumber")
; #define kIOAudioStreamStartingChannelNumberKey	"IOAudioStreamStartingChannelNumber"
(defconstant $kIOAudioStreamAvailableKey "IOAudioStreamAvailable")
; #define kIOAudioStreamAvailableKey				"IOAudioStreamAvailable"
(defconstant $kIOAudioStreamFormatKey "IOAudioStreamFormat")
; #define kIOAudioStreamFormatKey					"IOAudioStreamFormat"
(defconstant $kIOAudioStreamAvailableFormatsKey "IOAudioStreamAvailableFormats")
; #define kIOAudioStreamAvailableFormatsKey		"IOAudioStreamAvailableFormats"
(defconstant $kIOAudioStreamNumChannelsKey "IOAudioStreamNumChannels")
; #define kIOAudioStreamNumChannelsKey			"IOAudioStreamNumChannels"
(defconstant $kIOAudioStreamSampleFormatKey "IOAudioStreamSampleFormat")
; #define kIOAudioStreamSampleFormatKey			"IOAudioStreamSampleFormat"
(defconstant $kIOAudioStreamNumericRepresentationKey "IOAudioStreamNumericRepresentation")
; #define kIOAudioStreamNumericRepresentationKey	"IOAudioStreamNumericRepresentation"
(defconstant $kIOAudioStreamFormatFlagsKey "IOAudioStreamFormatFlags")
; #define kIOAudioStreamFormatFlagsKey			"IOAudioStreamFormatFlags"
(defconstant $kIOAudioStreamFramesPerPacketKey "IOAudioStreamFramesPerPacket")
; #define kIOAudioStreamFramesPerPacketKey		"IOAudioStreamFramesPerPacket"
(defconstant $kIOAudioStreamBytesPerPacketKey "IOAudioStreamBytesPerPacket")
; #define kIOAudioStreamBytesPerPacketKey			"IOAudioStreamBytesPerPacket"
(defconstant $kIOAudioStreamBitDepthKey "IOAudioStreamBitDepth")
; #define kIOAudioStreamBitDepthKey				"IOAudioStreamBitDepth"
(defconstant $kIOAudioStreamBitWidthKey "IOAudioStreamBitWidth")
; #define kIOAudioStreamBitWidthKey				"IOAudioStreamBitWidth"
(defconstant $kIOAudioStreamAlignmentKey "IOAudioStreamAlignment")
; #define kIOAudioStreamAlignmentKey				"IOAudioStreamAlignment"
(defconstant $kIOAudioStreamByteOrderKey "IOAudioStreamByteOrder")
; #define kIOAudioStreamByteOrderKey				"IOAudioStreamByteOrder"
(defconstant $kIOAudioStreamIsMixableKey "IOAudioStreamIsMixable")
; #define kIOAudioStreamIsMixableKey				"IOAudioStreamIsMixable"
(defconstant $kIOAudioStreamMinimumSampleRateKey "IOAudioStreamMinimumSampleRate")
; #define kIOAudioStreamMinimumSampleRateKey		"IOAudioStreamMinimumSampleRate"
(defconstant $kIOAudioStreamMaximumSampleRateKey "IOAudioStreamMaximumSampleRate")
; #define kIOAudioStreamMaximumSampleRateKey		"IOAudioStreamMaximumSampleRate"
(defconstant $kIOAudioStreamDriverTagKey "IOAudioStreamDriverTag")
; #define kIOAudioStreamDriverTagKey				"IOAudioStreamDriverTag"
(defconstant $kIOAudioStreamTerminalTypeKey "IOAudioStreamTerminalType")
; #define kIOAudioStreamTerminalTypeKey			"IOAudioStreamTerminalType"
; ****
;  *
;  * IOAudioPort defines
;  *
;  ****
; !
;  * @defined kIOAudioPortTypeKey
;  * @abstract The key in the IORegistry for the IOAudioPort type attribute.
;  * @discussion This is a driver-defined text attribute that may contain any type.
;  *  Common types are defined as: "Speaker", "Headphones", "Microphone", "CD", "Line", "Digital", "Mixer", "PassThru".
;  
(defconstant $kIOAudioPortTypeKey "IOAudioPortType")
; #define kIOAudioPortTypeKey			"IOAudioPortType"
; !
;  * @defined kIOAudioPortSubTypeKey
;  * @abstract The key in the IORegistry for the IOAudioPort subtype attribute.
;  * @discussion The IOAudioPort subtype is a driver-defined text attribute designed to complement the type
;  *  attribute.
;  
(defconstant $kIOAudioPortSubTypeKey "IOAudioPortSubType")
; #define kIOAudioPortSubTypeKey		"IOAudioPortSubType"
; !
;  * @defined kIOAudioPortNameKey
;  * @abstract The key in the IORegistry for the IOAudioPort name attribute.
;  
(defconstant $kIOAudioPortNameKey "IOAudioPortName")
; #define kIOAudioPortNameKey			"IOAudioPortName"
; ****
;  *
;  * IOAudioControl defines
;  *
;  ****
; !
;  * @defined kIOAudioControlTypeKey
;  * @abstract The key in the IORegistry for the IOAudioCntrol type attribute.
;  * @discussion The value of this text attribute may be defined by the driver, however system-defined
;  *  types recognized by the upper-level software are "Level", "Mute", "Selector".
;  
(defconstant $kIOAudioControlTypeKey "IOAudioControlType")
; #define kIOAudioControlTypeKey		"IOAudioControlType"
(defconstant $kIOAudioControlSubTypeKey "IOAudioControlSubType")
; #define kIOAudioControlSubTypeKey	"IOAudioControlSubType"
(defconstant $kIOAudioControlUsageKey "IOAudioControlUsage")
; #define kIOAudioControlUsageKey		"IOAudioControlUsage"
(defconstant $kIOAudioControlIDKey "IOAudioControlID")
; #define kIOAudioControlIDKey		"IOAudioControlID"
; !
;  * @defined kIOAudioControlChannelIDKey
;  * @abstract The key in the IORegistry for the IOAudioControl channel ID attribute
;  * @discussion The value for this key is an integer which may be driver defined.  Default values for
;  *  common channel types are provided in the following defines.
;  
(defconstant $kIOAudioControlChannelIDKey "IOAudioControlChannelID")
; #define kIOAudioControlChannelIDKey		"IOAudioControlChannelID"
(defconstant $kIOAudioControlChannelNumberKey "IOAudioControlChannelNumber")
; #define kIOAudioControlChannelNumberKey			"IOAudioControlChannelNumber"
(defconstant $kIOAudioControlCoreAudioPropertyIDKey "IOAudioControlCoreAudioPropertyID")
; #define kIOAudioControlCoreAudioPropertyIDKey	"IOAudioControlCoreAudioPropertyID"
; !
;  * @defined kIOAudioControlChannelNameKey
;  * @abstract The key in the IORegistry for the IOAudioControl name attribute.
;  * @discussion This name should be a human-readable name for the channel(s) represented by the port.
;  *  *** NOTE *** We really need to make all of the human-readable attributes that have potential to
;  *  be used in a GUI localizable.  There will need to be localized strings in the kext bundle matching
;  *  the text.
;  
(defconstant $kIOAudioControlChannelNameKey "IOAudioControlChannelName")
; #define kIOAudioControlChannelNameKey		"IOAudioControlChannelName"
; !
;  * @defined kIOAudioControlChannelNameAll
;  * @abstract The value for the kIOAudioControlChannelNameKey in the IORegistry representing
;  *  the channel name for all channels.
;  
(defconstant $kIOAudioControlChannelNameAll "All Channels")
; #define kIOAudioControlChannelNameAll		"All Channels"
; !
;  * @defined kIOAudioControlChannelNameLeft
;  * @abstract The value for the kIOAudioControlChannelNameKey in the IORegistry representing
;  *  the channel name for the left channel.
;  
(defconstant $kIOAudioControlChannelNameLeft "Left")
; #define kIOAudioControlChannelNameLeft		"Left"
; !
;  * @defined kIOAudioControlChannelNameRight
;  * @abstract The value for the kIOAudioControlChannelNameKey in the IORegistry representing
;  *  the channel name for the right channel.
;  
(defconstant $kIOAudioControlChannelNameRight "Right")
; #define kIOAudioControlChannelNameRight		"Right"
; !
;  * @defined kIOAudioControlChannelNameCenter
;  * @abstract The value for the kIOAudioControlChannelNameKey in the IORegistry representing
;  *  the channel name for the center channel.
;  
(defconstant $kIOAudioControlChannelNameCenter "Center")
; #define kIOAudioControlChannelNameCenter	"Center"
; !
;  * @defined kIOAudioControlChannelNameLeftRear
;  * @abstract The value for the kIOAudioControlChannelNameKey in the IORegistry representing
;  *  the channel name for the left rear channel.
;  
(defconstant $kIOAudioControlChannelNameLeftRear "LeftRear")
; #define kIOAudioControlChannelNameLeftRear	"LeftRear"
; !
;  * @defined kIOAudioControlChannelNameRightRear
;  * @abstract The value for the kIOAudioControlChannelNameKey in the IORegistry representing
;  *  the channel name for the right rear channel.
;  
(defconstant $kIOAudioControlChannelNameRightRear "RightRear")
; #define kIOAudioControlChannelNameRightRear	"RightRear"
; !
;  * @defined kIOAudioControlChannelNameSub
;  * @abstract The value for the kIOAudioControlChannelNameKey in the IORegistry representing
;  *  the channel name for the sub/LFE channel.
;  
(defconstant $kIOAudioControlChannelNameSub "Sub")
; #define kIOAudioControlChannelNameSub		"Sub"
; !
;  * @defined kIOAudioControlValueKey
;  * @abstract The key in the IORegistry for the IOAudioControl value attribute.
;  * @discussion The value returned by this key is a 32-bit integer representing the current value of the IOAudioControl.
;  
(defconstant $kIOAudioControlValueKey "IOAudioControlValue")
; #define kIOAudioControlValueKey				"IOAudioControlValue"
; !
;  * @defined kIOAudioControlValueIsReadOnlyKey
;  * @abstract The key in the IORegistry for the IOAudioControl value-is-read-only attribute.
;  * @discussion The value returned by this key is a 32-bit integer but the value doesn't have any direct meaning.
;  *  Instead, the presence of this key indicates that the value for the control is read-only
;  
(defconstant $kIOAudioControlValueIsReadOnlyKey "IOAudioControlValueIsReadOnly")
; #define kIOAudioControlValueIsReadOnlyKey	"IOAudioControlValueIsReadOnly"
; !
;  * @defined kIOAudioLevelControlMinValueKey
;  * @abstract The key in the IORegistry for the IOAudioControl minimum value attribute.
;  * @discussion The value returned by this key is a 32-bit integer representing the minimum value for the IOAudioControl.
;  *  This is currently only valid for Level controls or other driver-defined controls that have a minimum and maximum
;  *  value.
;  
(defconstant $kIOAudioLevelControlMinValueKey "IOAudioLevelControlMinValue")
; #define kIOAudioLevelControlMinValueKey		"IOAudioLevelControlMinValue"
; !
;  * @defined kIOAudioLevelControlMaxValueKey
;  * @abstract The key in the IORegistry for the IOAudioControl maximum value attribute.
;  * @discussion The value returned by this key is a 32-bit integer representing the maximum value for the IOAudioControl.
;  *  This is currently only valid for Level controls or other driver-defined controls that have a minimum and maximum
;  *  value.
;  
(defconstant $kIOAudioLevelControlMaxValueKey "IOAudioLevelControlMaxValue")
; #define kIOAudioLevelControlMaxValueKey		"IOAudioLevelControlMaxValue"
; !
;  * @defined kIOAudioLevelControlMinDBKey
;  * @abstract The key in the IORgistry for the IOAudioControl minimum db value attribute.
;  * @discussion The value returned by this key is a fixed point value in 16.16 format represented as a 32-bit
;  *  integer.  It represents the minimum value in db for the IOAudioControl.  This value matches the minimum
;  *  value attribute.  This is currently valid for Level controls or other driver-defined controls that have a
;  *  minimum and maximum db value.
;  
(defconstant $kIOAudioLevelControlMinDBKey "IOAudioLevelControlMinDB")
; #define kIOAudioLevelControlMinDBKey		"IOAudioLevelControlMinDB"
; !
;  * @defined kIOAudioLevelControlMaxDBKey
;  * @abstract The key in the IORgistry for the IOAudioControl maximum db value attribute.
;  * @discussion The value returned by this key is a fixed point value in 16.16 format represented as a 32-bit
;  *  integer.  It represents the maximum value in db for the IOAudioControl.  This value matches the maximum
;  *  value attribute.  This is currently valid for Level controls or other driver-defined controls that have a
;  *  minimum and maximum db value.
;  
(defconstant $kIOAudioLevelControlMaxDBKey "IOAudioLevelControlMaxDB")
; #define kIOAudioLevelControlMaxDBKey		"IOAudioLevelControlMaxDB"
(defconstant $kIOAudioLevelControlRangesKey "IOAudioLevelControlRanges")
; #define kIOAudioLevelControlRangesKey		"IOAudioLevelControlRanges"
(defconstant $kIOAudioSelectorControlAvailableSelectionsKey "IOAudioSelectorControlAvailableSelections")
; #define kIOAudioSelectorControlAvailableSelectionsKey	"IOAudioSelectorControlAvailableSelections"
(defconstant $kIOAudioSelectorControlSelectionValueKey "IOAudioSelectorControlSelectionValue")
; #define kIOAudioSelectorControlSelectionValueKey		"IOAudioSelectorControlSelectionValue"
(defconstant $kIOAudioSelectorControlSelectionDescriptionKey "IOAudioSelectorControlSelectionDescriptionKey")
; #define kIOAudioSelectorControlSelectionDescriptionKey	"IOAudioSelectorControlSelectionDescriptionKey"

; #endif /* _IOAUDIODEFINES_H */


(provide-interface "IOAudioDefines")