(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AudioUnitProperties.h"
; at Sunday July 2,2006 7:26:55 pm.
; 
;      File:       AudioUnitProperties.h
;  
;      Contains:   Property constants for AudioUnits
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2001 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AudioUnitProperties
; #define __AudioUnitProperties

(require-interface "AudioUnit/AUComponent")

(require-interface "CoreAudio/CoreAudioTypes")

; #if TARGET_API_MAC_OSX

(require-interface "CoreFoundation/CoreFoundation")

; #endif

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  Properties
;  Apple reserves property values from 0 -> 63999
;  Developers are free to use property IDs above this range at their own discretion
;  Applicable to all AudioUnits in general	(0 -> 999)

(defconstant $kAudioUnitProperty_ClassInfo 0)
(defconstant $kAudioUnitProperty_MakeConnection 1)
(defconstant $kAudioUnitProperty_SampleRate 2)
(defconstant $kAudioUnitProperty_ParameterList 3)
(defconstant $kAudioUnitProperty_ParameterInfo 4)
(defconstant $kAudioUnitProperty_FastDispatch 5)
(defconstant $kAudioUnitProperty_CPULoad 6)     ; kAudioUnitProperty_SetInputCallback			= 7 -> deprecated - see AUNTComponent.h

(defconstant $kAudioUnitProperty_StreamFormat 8)
(defconstant $kAudioUnitProperty_SRCAlgorithm 9)
(defconstant $kAudioUnitProperty_ReverbRoomType 10)
(defconstant $kAudioUnitProperty_BusCount 11)
(defconstant $kAudioUnitProperty_ElementCount 11)
(defconstant $kAudioUnitProperty_Latency 12)
(defconstant $kAudioUnitProperty_SupportedNumChannels 13)
(defconstant $kAudioUnitProperty_MaximumFramesPerSlice 14)
(defconstant $kAudioUnitProperty_SetExternalBuffer 15)
(defconstant $kAudioUnitProperty_ParameterValueStrings 16)
(defconstant $kAudioUnitProperty_MIDIControlMapping 17)
(defconstant $kAudioUnitProperty_GetUIComponentList 18)
(defconstant $kAudioUnitProperty_AudioChannelLayout 19)
(defconstant $kAudioUnitProperty_TailTime 20)
(defconstant $kAudioUnitProperty_BypassEffect 21)
(defconstant $kAudioUnitProperty_LastRenderError 22)
(defconstant $kAudioUnitProperty_SetRenderCallback 23)
(defconstant $kAudioUnitProperty_FactoryPresets 24)
(defconstant $kAudioUnitProperty_ContextName 25)
(defconstant $kAudioUnitProperty_RenderQuality 26)
(defconstant $kAudioUnitProperty_HostCallbacks 27)
(defconstant $kAudioUnitProperty_CurrentPreset 28)
(defconstant $kAudioUnitProperty_InPlaceProcessing 29)
(defconstant $kAudioUnitProperty_ElementName 30)
(defconstant $kAudioUnitProperty_CocoaUI 31)
(defconstant $kAudioUnitProperty_SupportedChannelLayoutTags 32)
(defconstant $kAudioUnitProperty_ParameterValueName 33)
(defconstant $kAudioUnitProperty_ParameterIDName 34)
(defconstant $kAudioUnitProperty_ParameterClumpName 35)
(defconstant $kAudioUnitProperty_PresentPreset 36)
(defconstant $kAudioUnitProperty_UsesInternalReverb #x3ED);  Applicable to MusicDevices				(1000 -> 1999)

(defconstant $kMusicDeviceProperty_InstrumentCount #x3E8)
(defconstant $kMusicDeviceProperty_InstrumentName #x3E9)
(defconstant $kMusicDeviceProperty_GroupOutputBus #x3EA)
(defconstant $kMusicDeviceProperty_SoundBankFSSpec #x3EB)
(defconstant $kMusicDeviceProperty_InstrumentNumber #x3EC)
(defconstant $kMusicDeviceProperty_UsesInternalReverb #x3ED)
(defconstant $kMusicDeviceProperty_MIDIXMLNames #x3EE)
(defconstant $kMusicDeviceProperty_BankName #x3EF)
(defconstant $kMusicDeviceProperty_SoundBankData #x3F0)
(defconstant $kMusicDeviceProperty_PartGroup #x3F2)
(defconstant $kMusicDeviceProperty_StreamFromDisk #x3F3);  Applicable to "output" AudioUnits		(2000 -> 2999)

(defconstant $kAudioOutputUnitProperty_CurrentDevice #x7D0)
(defconstant $kAudioOutputUnitProperty_IsRunning #x7D1)
(defconstant $kAudioOutputUnitProperty_ChannelMap #x7D2); this will also work with AUConverter

(defconstant $kAudioOutputUnitProperty_EnableIO #x7D3)
(defconstant $kAudioOutputUnitProperty_StartTime #x7D4)
(defconstant $kAudioOutputUnitProperty_SetInputCallback #x7D5)
(defconstant $kAudioOutputUnitProperty_HasIO #x7D6);  miscellaneous AudioUnit - specific properties

(defconstant $kAudioUnitProperty_SpatializationAlgorithm #xBB8)
(defconstant $kAudioUnitProperty_SpeakerConfiguration #xBB9)
(defconstant $kAudioUnitProperty_DopplerShift #xBBA)
(defconstant $kAudioUnitProperty_3DMixerRenderingFlags #xBBB)
(defconstant $kAudioUnitProperty_3DMixerDistanceAtten #xBBC)
(defconstant $kAudioUnitProperty_MatrixLevels #xBBE)
(defconstant $kAudioUnitProperty_MeteringMode #xBBF)
(defconstant $kAudioUnitProperty_PannerMode #xBC0)
(defconstant $kAudioUnitProperty_MatrixDimensions #xBC1);  offline unit properties

(defconstant $kAudioOfflineUnitProperty_InputSize #xBCC)
(defconstant $kAudioOfflineUnitProperty_OutputSize #xBCD)
(defconstant $kAudioUnitOfflineProperty_StartOffset #xBCE)
(defconstant $kAudioUnitOfflineProperty_PreflightRequirements #xBCF)
(defconstant $kAudioUnitOfflineProperty_PreflightName #xBD0)
; 
; 	New Property Values:
; 	kAudioUnitProperty_ElementName
; 		Value is a 										CFStringRef
; 		The Host owns a reference to this property value (as with all other CF properties), and 
; 		should release the string retrieved or used when setting.
; 		
; 	kAudioUnitProperty_CocoaUI
; 		Value is a										struct AudioUnitCocoaViewInfo
; 		The Host can determine how big this structure is by querying the size of 
; 		the property (ie. How many alternate UI classes there are for the AU)
; 		Typically, most audio units will provide 1 UI class per unit
; 
; 	kAudioUnitProperty_SupportedChannelLayoutTags		read-only	AudioChannelLayoutTags[kVariableLengthArray]
; 	 	Used with GetProperty to ascertain what an AudioUnit understands about
; 		laying out of channel orders. This will normally return one or more of the specified layout tags.
; 		
; 		When a specific set of layouts are returned, the client then uses the kAudioUnitProperty_AudioChannelLayout
; 		property (with one of those layout tags specified) to set the unit to use that layout. In this case
; 		the client (and the AudioUnit when reporting its AudioChannelLayout) is only expected to have set
; 		an AudioChannelLayout which only sets the layout tag as the valid field.
; 		
; 		Custom Channel Maps:
; 		Some audio units may return the tag:
; 			kAudioChannelLayoutTag_UseChannelDescriptions
; 		
; 		In this case, the host then can look at supported number of channels on that scope
; 		(using the kAudioUnitProperty_SupportedNumChannels), and supply an AudioChannelLayout with the 
; 		kAudioUnitProperty_AudioChannelLayout property to specify the layout, number of channels
; 		and location of each of those channels. This custom channel map MUST have a channel valence
; 		that is supported by the Audio Unit.
; 		
; 		The UseChannelBitmap field is NOT used within the context of the AudioUnit.
; 	
; 	kAudioUnitProperty_AudioChannelLayout				struct AudioChannelLayout read/write
; 		See above for a general description.
; 
; 		The AudioChannelLayout property describes for a given scope/element the order of 
; 		channels within a given stream. This property should be used to set the format
; 		of that scope and element (as it describes not only the number of channels, but
; 		the layout of those channels). Using the _StreamFormat property is generally
; 		not sufficient in this case (as this only describes the number of channels, 
; 		but not either the ordering of channels, whether the rendering is for speakers
; 		or headphones (in the stereo case), and so forth). The 3DMixer is one such example
; 		of an AudioUnit that requires an ACM on its output bus.
; 		
; 		Provisional Support for Channel Layouts:
; 		This property (and some others) may be supported by an AudioUnit but may not
; 		have been set, and doesn't have a reasonable default value. In that case a
; 		call to AudioUnitGetProperty will return the following status:
; 			kAudioUnitErr_PropertyNotInUse
; 			
; 		For eg, imagine that you have an AUConverter unit that can convert between
; 		2 different AudioChannelLayout structures. However, the user has set up this
; 		unit just with calls to the StreamDescription.. ie, the ACM property has never
; 		been set. As there are several differenct ACM versions that can represent a
; 		stream with the same number of channels, there is:
; 			(1) No means for the AUConverter in this case to make a guess
; 			(2) The stream itself may just be a N channel stream and have no surround or
; 				speaker implications.
; 				
; 		Thus the need for this status code. The user can interpret this to mean that the 
; 		property would be valid if it were set, but currently it hasn't been, there is no
; 		reasonable default (or even need for it), so the unit cannot return a sensible 
; 		value for that property.
; 		
; 		For an AudioUnit where the channel layout is not required (but is optional), the
; 		user can call AudioUnitSetProperty with this propertyID and a value of NULL
; 		(size of 0) to clear that setting. 
; 			-	If this call is successful, the unit would
; 		then return kAudioUnitErr_PropertyNotInUse in a consequent attempt to get this
; 		property value, until it is set with a valid value again.
; 			-	If this call is unsuccessful, a typical result code is 
; 		kAudioUnitErr_InvalidPropertyValue - that result can be taken to mean that
; 		the property value cannot be removed
; 		
; 		On those AudioUnits that require a channel layout (which is the typical case 
; 		for an effect unit, for the output of the 3DMixer for example), this "clearing"
; 		call will fail (invalid property value).
; 
; 	kAudioOutputUnitProperty_EnableIO				UInt32 read/write
; 		scope output, element 0 = output
; 		scope input, element 1 = input
; 		output units default to output-only; may disable output or enable input, providing
; 		that the underlying device supports it, with this property. 0=disabled, 1=enabled
; 		using I/O proc.
; 
; 	kAudioOutputUnitProperty_HasIO					UInt32 read-only
; 		scope output, element 0 = output
; 		scope input, element 1 = input
; 		see kAudioOutputUnitProperty_EnableIO
; 		property value is 1 if input or output is enabled on the specified element.
; 	
; 	kAudioOutputUnitProperty_StartTime				AudioOutputUnitStartAtTimeParams, write-only
; 		when this property is set on an output unit, it will cause the next Start request
; 		(but no subsequent Starts) to use AudioDeviceStartAtTime, using the specified timestamp,
; 		passing false for inRequestedStartTimeIsInput.
; 	
; 	kAudioOutputUnitProperty_SetInputCallback		AURenderCallbackStruct, read/write
; 		when an output unit has been enabled for input, this callback can be used to provide
; 		a single callback to the client from the input I/O proc, in order to notify the
; 		client that input is available and may be obtained by calling AudioUnitRender.
; 
; 	kAudioUnitProperty_ParameterValueName			AudioUnitParameterValueName read-only
; 		This property is used with parameters that are marked with the
; 		kAudioUnitParameterFlag_HasName parameter info flag. This indicates that some
; 		(or all) of the values represented by the parameter can and should be
; 		represented by a special display string.
; 		
; 		This is NOT to be confused with kAudioUnitProperty_ParameterValueStrings. That property
; 		is used with parameters that are indexed and is typically used for instance to build
; 		a menu item of choices for one of several parameter values.
; 		
; 		kAudioUnitProperty_ParameterValueName can have a continuous range, and merely states
; 		to the host that if it is displaying those parameter's values, they should request
; 		a name any time any value of the parameter is set when displaying that parameter.
; 		
; 		For instance (a trivial example), a unit may present a gain parameter in a dB scale,
; 		and wish to display its minimum value as "negative infinity". In this case, the AU
; 		will not return names for any parameter value greater than its minimum value - so the host
; 		will then just display the parameter value as is. For values less than or equal to the 
; 		minimum value, the AU will return a string for "negative infinity" which the host can
; 		use to display appropriately.
; 		
; 		A less trivial example might be a parameter that presents its values as seconds. However,
; 		in some situations this value should be better displayed in a SMPTE style of display:
; 			HH:MM:SS:FF
; 		In this case, the AU would return a name for any value of the parameter.
; 		
; 		The GetProperty call is used in the same scope and element as the inParamID 
; 		that is declared in the struct passed in to this property.
; 		
; 		If the *inValue member is NULL, then the AudioUnit should take the current value
; 		of the specified parameter. If the *inValue member is NOT NULL, then the AU should
; 		return the name used for the specified value.
; 		
; 		On exit, the outName may point to a CFStringRef (which if so must be released by the caller).
; 		If the parameter has no special name that should be applied to that parameter value,
; 		then outName will be NULL, and the host should display the parameter value as
; 		appropriate.
; 	
; 	kAudioUnitProperty_ParameterIDName						AudioUnitParameterNameInfo (read)
; 		An AudioUnit returns the full parameter name in the GetParameterInfo struct/property.
; 		In some display situations however, there may only be room for a few characters, and
; 		truncating this full name may give a less than optimal name for the user. Thus, 
; 		this property can be used to ask the AU whether it can supply a truncated name, with
; 		the host suggesting a length (number of characters). If the AU returns a longer
; 		name than the host requests, that name maybe truncated to the requested characters in display.
; 		The AU could return a shorter name than requeseted as well. The AU returns a CFString
; 		that should be released by the host. When using this property, the host asks for
; 		the name in the same scope and element as the AU publishes the parameter.
; 	
; 	kAudioUnitProperty_ParameterClumpName					AudioUnitParameterNameInfo (read)
; 		This works in a similar manner to the ParameterIDName property, except that the inID
; 		value is one of the clumpID's that are returned with the AU's ParameterInfo struct.
; 	
; 	kMusicDeviceProperty_PartGroup							AudioUnitElement (read/write)
; 		AudioUnitElement that is the groupID (The Group Scope's Element) the part is (or should be) 
; 		assigned to. The property is used in the Part Scope, where the element ID is the part
; 		that is being queried (or assigned). This property may in some cases be read only, it may
; 		in some cases only be settable if the AU is uninitialized, or it may be completely dynamic/
; 		These constraints are dependent on the AU's implmentation restrictions, though ideally
; 		this property should be dynamically assignable at any time. The affect of assigning a new
; 		group to a part is undefined (though typically it would be expected that all of the existing
; 		notes would be turned OFF before the re-assignment is made by the AU).
; 		
; 	kAudioUnitProperty_PresentPreset						AUPreset (read/write)
; 		This property replaces the deprecated CurrentPreset property, due to the ambiguity of
; 		ownership of the CFString of the preset name in the older CurrentPreset property. 
; 		With PresentPreset the client of the AU owns the CFString when it retrieves the
; 		preset with PresentPreset and is expected to release this (as with ALL properties 
; 		that retrieve a CF object from an AU)
; 	
; 
;  these properties are superseded by the AudioUnitQuality settings

(defconstant $kAudioUnitSRCAlgorithm_Polyphase :|poly|)
(defconstant $kAudioUnitSRCAlgorithm_MediumQuality :|csrc|)

(defconstant $kReverbRoomType_SmallRoom 0)
(defconstant $kReverbRoomType_MediumRoom 1)
(defconstant $kReverbRoomType_LargeRoom 2)
(defconstant $kReverbRoomType_MediumHall 3)
(defconstant $kReverbRoomType_LargeHall 4)
(defconstant $kReverbRoomType_Plate 8)

(defconstant $kSpatializationAlgorithm_EqualPowerPanning 0)
(defconstant $kSpatializationAlgorithm_SphericalHead 1)
(defconstant $kSpatializationAlgorithm_HRTF 2)
(defconstant $kSpatializationAlgorithm_SoundField 3)
(defconstant $kSpatializationAlgorithm_VectorBasedPanning 4)
(defconstant $kSpatializationAlgorithm_StereoPassThrough 5)
;  These property values are deprecated in favour of the newer AudioChannelLayout
;  structure and its supporting property.
;  The Original kSpeakerConfiguration_5_1 was also incorrectly named...
;  That speaker configuration actually represents a 5 channel stream in the order of
;  L, R, SL, SR, C -> there is no LFE or .1 channel in that stream

(defconstant $kSpeakerConfiguration_HeadPhones 0)
(defconstant $kSpeakerConfiguration_Stereo 1)
(defconstant $kSpeakerConfiguration_Quad 2)
(defconstant $kSpeakerConfiguration_5_0 3)
(defconstant $kSpeakerConfiguration_5_1 3)

(defconstant $k3DMixerRenderingFlags_InterAuralDelay 1)
(defconstant $k3DMixerRenderingFlags_DopplerShift 2)
(defconstant $k3DMixerRenderingFlags_DistanceAttenuation 4)
(defconstant $k3DMixerRenderingFlags_DistanceFilter 8)
(defconstant $k3DMixerRenderingFlags_DistanceDiffusion 16)

(defconstant $kRenderQuality_Max 127)
(defconstant $kRenderQuality_High 96)
(defconstant $kRenderQuality_Medium 64)
(defconstant $kRenderQuality_Low 32)
(defconstant $kRenderQuality_Min 0)

(defconstant $kPannerMode_Normal 0)
(defconstant $kPannerMode_FaderMode 1)

(defconstant $kOfflinePreflight_NotRequired 0)
(defconstant $kOfflinePreflight_Optional 1)
(defconstant $kOfflinePreflight_Required 2)
;  Apple reserves usage of scope IDs from 0 to 1024 for system usage

(defconstant $kAudioUnitScope_Global 0)
(defconstant $kAudioUnitScope_Input 1)
(defconstant $kAudioUnitScope_Output 2)
(defconstant $kAudioUnitScope_Group 3)
(defconstant $kAudioUnitScope_Part 4)
(defrecord AudioUnitConnection
   (sourceAudioUnit (:pointer :ComponentInstanceRecord))
   (sourceOutputNumber :UInt32)
   (destInputNumber :UInt32)
)
(defrecord AURenderCallbackStruct
   (inputProc :pointer)
   (inputProcRefCon :pointer)
)
(defrecord AudioUnitExternalBuffer
   (buffer (:pointer :Byte))
   (size :UInt32)
)
;  if one of these channel valences is -1 and the other is positive:
;  for eg: in == -1, out == 2
;  This means the unit can handle any number of channels on input
;  but provids 2 on output
;  If in and out channels are different negative numbers, then
;  the unit can handle any number of channels in and out:
;  for eg: in == -1, out == -2
;  If both of these valences are -1, then the unit can handle
;  any number of channels in and out PROVIDED they are the same
;  number of channels 
;  for eg: in == -1, out == -1
;  (this is the typical case for an effect unit, and unless the effect unit
;  has channel restrictions, it won't publish this property just for the -1->-1 case
(defrecord AUChannelInfo
   (inChannels :SInt16)
   (outChannels :SInt16)
)
(defrecord AUPreset
   (presetNumber :SInt32)
   (presetName (:pointer :__CFString))
)
;  These strings are used as keys in the AUPreset-"classInfo" dictionary
;  The actual keys are CFStrings to use these keys you define the key as:
;  static const CFStringRef kMyVersionString = CFSTR(kAUPresetVersionKey);
(defconstant $kAUPresetVersionKey "version")
; #define kAUPresetVersionKey 		"version"
(defconstant $kAUPresetTypeKey "type")
; #define kAUPresetTypeKey 			"type"
(defconstant $kAUPresetSubtypeKey "subtype")
; #define kAUPresetSubtypeKey 		"subtype"
(defconstant $kAUPresetManufacturerKey "manufacturer")
; #define kAUPresetManufacturerKey	"manufacturer"
(defconstant $kAUPresetDataKey "data")
; #define kAUPresetDataKey			"data"
(defconstant $kAUPresetNameKey "name")
; #define kAUPresetNameKey			"name"
(defconstant $kAUPresetRenderQualityKey "render-quality")
; #define kAUPresetRenderQualityKey	"render-quality"
(defconstant $kAUPresetCPULoadKey "cpu-load")
; #define kAUPresetCPULoadKey			"cpu-load"
(defconstant $kAUPresetVSTDataKey "vstdata")
; #define kAUPresetVSTDataKey			"vstdata"
(defconstant $kAUPresetElementNameKey "element-name")
; #define kAUPresetElementNameKey		"element-name"
;  this key if present, distinguishes a global preset that is set on the global scope
;  with a part-based preset that is set on the part scope. The value of this key is
;  audio unit defined
(defconstant $kAUPresetPartKey "part")
; #define kAUPresetPartKey			"part"
;  If the host is unable to provide the requested information
;  then it can return the kAudioUnitErr_CannotDoInCurrentContext error code
;  Any of these parameters when called by the AudioUnit can be NULL
;  ie. the AU doesn't want to know about this. 
;  (except for the HostUserData which must be supplied by the AU as given to it when the property was set)

(def-mactype :HostCallback_GetBeatAndTempo (find-mactype ':pointer)); (void * inHostUserData , Float64 * outCurrentBeat , Float64 * outCurrentTempo)

(def-mactype :HostCallback_GetMusicalTimeLocation (find-mactype ':pointer)); (void * inHostUserData , UInt32 * outDeltaSampleOffsetToNextBeat , Float32 * outTimeSig_Numerator , UInt32 * outTimeSig_Denominator , Float64 * outCurrentMeasureDownBeat)
(defrecord HostCallbackInfo
   (hostUserData :pointer)
   (beatAndTempoProc :pointer)
   (musicalTimeLocationProc :pointer)
)
;  mCocoaAUViewBundleLocation - contains the location of the bundle which the host app can then use to locate the bundle
;  mCocoaAUViewClass - contains the names of the classes that implements the required protocol for an AUView
(defrecord AudioUnitCocoaViewInfo
   (mCocoaAUViewBundleLocation (:pointer :__CFURL))
   (mCocoaAUViewClass (:array (POINTER __CFSTRING) 1))
)
(defrecord AudioUnitParameterValueName
   (inParamID :UInt32)
   (inValue (:pointer :Float32))
                                                ; maybe NULL if should translate current parameter value
   (outName (:pointer :__CFString))
                                                ;  see comments for kAudioUnitProperty_ParameterValueName
)
;  AU Developers should *not* use a clumpID of zero - this is a reerved value for system usage

(defconstant $kAudioUnitClumpID_System 0)
;  This is used with the AudioUnitParameterNameInfo.inDesiredLength to signify the full name
;  of the paramter information (like its ClumpName, or a "shortened" parameter name, being requeseted

(defconstant $kAudioUnitParameterName_Full -1)
(defrecord AudioUnitParameterNameInfo
   (inID :UInt32)
   (inDesiredLength :SInt32)
   (outName (:pointer :__CFString))
)
(%define-record :AudioUnitParameterIDName (find-record-descriptor :AUDIOUNITPARAMETERNAMEINFO))
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  Parameters
;  assume kAudioUnitParameterUnit_Generic if not found in this enum

(defconstant $kAudioUnitParameterUnit_Generic 0);  untyped value generally between 0.0 and 1.0 

(defconstant $kAudioUnitParameterUnit_Indexed 1);  takes an integer value (good for menu selections) 

(defconstant $kAudioUnitParameterUnit_Boolean 2);  0.0 means FALSE, non-zero means TRUE 

(defconstant $kAudioUnitParameterUnit_Percent 3);  usually from 0 -> 100, sometimes -50 -> +50 

(defconstant $kAudioUnitParameterUnit_Seconds 4);  absolute or relative time 

(defconstant $kAudioUnitParameterUnit_SampleFrames 5);  one sample frame equals (1.0/sampleRate) seconds 

(defconstant $kAudioUnitParameterUnit_Phase 6)  ;  -180 to 180 degrees 

(defconstant $kAudioUnitParameterUnit_Rate 7)   ;  rate multiplier, for playback speed, etc. (e.g. 2.0 == twice as fast) 

(defconstant $kAudioUnitParameterUnit_Hertz 8)  ;  absolute frequency/pitch in cycles/second 

(defconstant $kAudioUnitParameterUnit_Cents 9)  ;  unit of relative pitch 

(defconstant $kAudioUnitParameterUnit_RelativeSemiTones 10);  useful for coarse detuning 

(defconstant $kAudioUnitParameterUnit_MIDINoteNumber 11);  absolute pitch as defined in the MIDI spec (exact freq may depend on tuning table) 

(defconstant $kAudioUnitParameterUnit_MIDIController 12);  a generic MIDI controller value from 0 -> 127 

(defconstant $kAudioUnitParameterUnit_Decibels 13);  logarithmic relative gain 

(defconstant $kAudioUnitParameterUnit_LinearGain 14);  linear relative gain 

(defconstant $kAudioUnitParameterUnit_Degrees 15);  -180 to 180 degrees, similar to phase but more general (good for 3D coord system) 

(defconstant $kAudioUnitParameterUnit_EqualPowerCrossfade 16);  0 -> 100, crossfade mix two sources according to sqrt(x) and sqrt(1.0 - x) 

(defconstant $kAudioUnitParameterUnit_MixerFaderCurve1 17);  0.0 -> 1.0, pow(x, 3.0) -> linear gain to simulate a reasonable mixer channel fader response 

(defconstant $kAudioUnitParameterUnit_Pan 18)   ;  standard left to right mixer pan 

(defconstant $kAudioUnitParameterUnit_Meters 19);  distance measured in meters 

(defconstant $kAudioUnitParameterUnit_AbsoluteCents 20);  absolute frequency measurement : if f is freq in hertz then 	
;  absoluteCents = 1200 * log2(f / 440) + 6900					

(defconstant $kAudioUnitParameterUnit_Octaves 21);  octaves in relative pitch where a value of 1 is equal to 1200 cents

(defconstant $kAudioUnitParameterUnit_BPM 22)   ;  beats per minute, ie tempo 

(defconstant $kAudioUnitParameterUnit_Beats 23) ;  time relative to tempo, ie. 1.0 at 120 BPM would equal 1/2 a second 

(defconstant $kAudioUnitParameterUnit_Milliseconds 24);  parameter is expressed in milliseconds 

(defconstant $kAudioUnitParameterUnit_Ratio 25) ;  for compression, expansion ratio, etc. 


(def-mactype :AudioUnitParameterUnit (find-mactype ':UInt32))
;  if the "unit" field contains a value not in the enum above, then assume kAudioUnitParameterUnit_Generic
(defrecord AudioUnitParameterInfo

; #if TARGET_API_MAC_OSX
   (name (:array :character 56))
                                                ;  UTF8 encoded C string, may be treated as 56 characters
                                                ;  if kAudioUnitParameterFlag_HasCFNameString not set
   (clumpID :UInt32)
                                                ;  only valid if kAudioUnitParameterFlag_HasClump
   (cfNameString (:pointer :__CFString))
                                                ;  only valid if kAudioUnitParameterFlag_HasCFNameString
#| 
; #else
   (name (:array :character 64))
                                                ;  UTF8 encoded C string
 |#

; #endif

   (unit :UInt32)
   (minValue :single-float)
   (maxValue :single-float)
   (defaultValue :single-float)
   (flags :UInt32)
)
;  flags for AudioUnitParameterInfo
;  Due to some vagaries about the ways in which Parameter's CFNames have been described, it was
;  necessary to add a flag: kAudioUnitParameterFlag_CFNameRelease
;  In normal usage a parameter name is essentially a static object, but sometimes an AU will 
;  generate parameter names dynamically.. As these are expected to be CFStrings, in that case
;  the host should release those names when it is finished with them, but there was no way
;  to communicate this distinction in behaviour.
;  Thus, if an AU will (or could) generate a name dynamically, it should set this flag in the
;  paramter's info.. The host should check for this flag, and if present, release the parameter
;  name when it is finished with it.
;  -------------------------------
;  THESE ARE DEPRECATED AS OF 10.2 - these will eventually be reused, so don't use them!

(defconstant $kAudioUnitParameterFlag_Global 1) ; 	parameter scope is global

(defconstant $kAudioUnitParameterFlag_Input 2)  ; 	parameter scope is input

(defconstant $kAudioUnitParameterFlag_Output 4) ; 	parameter scope is output

(defconstant $kAudioUnitParameterFlag_Group 8)  ; 	parameter scope is group
;  THESE ARE THE VALID RANGES OF PARAMETER FLAGS
;  -------------------------------

(defconstant $kAudioUnitParameterFlag_CFNameRelease 16)
(defconstant $kAudioUnitParameterFlag_HasClump #x100000)
(defconstant $kAudioUnitParameterFlag_HasName #x200000)
(defconstant $kAudioUnitParameterFlag_DisplayLogarithmic #x400000);  indicates that a graphical representation should use a  logarithmic scale

(defconstant $kAudioUnitParameterFlag_IsHighResolution #x800000)
(defconstant $kAudioUnitParameterFlag_NonRealTime #x1000000)
(defconstant $kAudioUnitParameterFlag_CanRamp #x2000000)
(defconstant $kAudioUnitParameterFlag_ExpertMode #x4000000)
(defconstant $kAudioUnitParameterFlag_HasCFNameString #x8000000)
(defconstant $kAudioUnitParameterFlag_IsGlobalMeta #x10000000)
(defconstant $kAudioUnitParameterFlag_IsElementMeta #x20000000)
(defconstant $kAudioUnitParameterFlag_IsReadable #x40000000)
(defconstant $kAudioUnitParameterFlag_IsWritable #x80000000)
;  new for 10.2
(defrecord AudioUnitMIDIControlMapping
   (midiNRPN :UInt16)
   (midiControl :UInt8)
   (scope :UInt8)
   (element :UInt32)
   (parameter :UInt32)
)
;  new for 10.3
(defrecord AudioOutputUnitStartAtTimeParams
                                                ;  see AudioDeviceStartAtTime
   (mTimestamp :AudioTimeStamp)
   (mFlags :UInt32)
)

; #endif // __AudioUnitProperties


(provide-interface "AudioUnitProperties")