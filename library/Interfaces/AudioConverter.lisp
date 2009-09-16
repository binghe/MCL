(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AudioConverter.h"
; at Sunday July 2,2006 7:26:58 pm.
; 
;      File:       AudioToolbox/AudioConverter.h
; 
;      Contains:   API for translating between audio data formats.
; 
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
; 
;      Copyright:  (c) 1985-2001 by Apple Computer, Inc., all rights reserved.
; 
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
; 
;                      http://developer.apple.com/bugreporter/
; 
; 

; #if !defined(__AudioConverter_h__)
; #define __AudioConverter_h__
; =============================================================================
; 	Includes
; =============================================================================

(require-interface "CoreAudio/CoreAudioTypes")

; #if defined(__cplusplus)
#|
extern "C"
{
#endif
|#
; =============================================================================
; 	Theory of Operation
; =============================================================================
; =============================================================================
; 	Types specific to the Audio Converter API
; =============================================================================

(def-mactype :AudioConverterRef (find-mactype '(:pointer :OpaqueAudioConverter)))

(def-mactype :AudioConverterPropertyID (find-mactype ':UInt32))
; =============================================================================
; 	Standard Properties
; =============================================================================

(defconstant $kAudioConverterPropertyMinimumInputBufferSize :|mibs|); 	a UInt32 that indicates the size in bytes of the smallest
; 	buffer of input data that can be supplied via the
; 	AudioConverterInputProc or as the input to
; 	AudioConverterConvertBuffer

(defconstant $kAudioConverterPropertyMinimumOutputBufferSize :|mobs|); 	a UInt32 that indicates the size in bytes of the smallest
; 	buffer of output data that can be supplied to
; 	AudioConverterFillBuffer or as the output to
; 	AudioConverterConvertBuffer

(defconstant $kAudioConverterPropertyMaximumInputBufferSize :|xibs|); 	a UInt32 that indicates the size in bytes of the largest
; 	buffer of input data that will be requested from the AudioConverterInputProc.
;  This is mostly useful for variable bit rate compressed data.
;  This will be equal to 0xFFFFFFFF if the maximum value depends on what 
;  is requested from the output, which is usually the case for constant bit rate formats.

(defconstant $kAudioConverterPropertyMaximumInputPacketSize :|xips|); 	a UInt32 that indicates the size in bytes of the largest
; 	single packet of data in the input format.
;  This is mostly useful for variable bit rate compressed data (decoders).

(defconstant $kAudioConverterPropertyMaximumOutputPacketSize :|xops|); 	a UInt32 that indicates the size in bytes of the largest
; 	single packet of data in the output format.
;  This is mostly useful for variable bit rate compressed data (encoders).

(defconstant $kAudioConverterPropertyCalculateInputBufferSize :|cibs|); 	a UInt32 that on input holds a size in bytes
; 	that is desired for the output data. On output,
; 	it will hold the size in bytes of the input buffer
; 	required to generate that much output data. Note
; 	that some converters cannot do this calculation.

(defconstant $kAudioConverterPropertyCalculateOutputBufferSize :|cobs|); 	a UInt32 that on input holds a size in bytes
; 	that is desired for the input data. On output,
; 	it will hold the size in bytes of the output buffer
; 	required to hold the output data that will be generated.
; 	Note that some converters cannot do this calculation.

(defconstant $kAudioConverterPropertyInputCodecParameters :|icdp|); 	The value of this property varies from format to format
; 	and is considered private to the format. It is treated
; 	as a buffer of untyped data.

(defconstant $kAudioConverterPropertyOutputCodecParameters :|ocdp|); 	The value of this property varies from format to format
; 	and is considered private to the format. It is treated
; 	as a buffer of untyped data.

(defconstant $kAudioConverterSampleRateConverterAlgorithm :|srci|);  DEPRECATED : please use kAudioConverterSampleRateConverterQuality instead
; 
; 	An OSType that specifies the sample rate converter to use
; 	(as defined in AudioUnit/AudioUnitProperties.h -- for now only Apple SRC's can be used)

(defconstant $kAudioConverterSampleRateConverterQuality :|srcq|); 	A UInt32 that specifies rendering quality of the sample rate converter
;   (see enum constants below)

(defconstant $kAudioConverterCodecQuality :|cdqu|); 	A UInt32 that specifies rendering quality of a codec
;   (see enum constants below)

(defconstant $kAudioConverterPrimeMethod :|prmm|);  a UInt32 specifying priming method (usually for sample-rate converter)
;  see explanation for struct AudioConverterPrimeInfo below
;  along with enum constants

(defconstant $kAudioConverterPrimeInfo :|prim|) ;   A pointer to AudioConverterPrimeInfo (see explanation for struct AudioConverterPrimeInfo below)

(defconstant $kAudioConverterChannelMap :|chmp|);  An array of SInt32's.  The size of the array is the number of output
;  channels, and each element specifies which input channel's
;  data is routed to that output channel (using a 0-based index
;  of the input channels), or -1 if no input channel is to be
;  routed to that output channel.  The default behavior is as follows.
;  I = number of input channels, O = number of output channels.
;  When I > O, the first O inputs are routed to the first O outputs,
;  and the remaining puts discarded.  When O > I, the first I inputs are 
;  routed to the first O outputs, and the remaining outputs are zeroed.

(defconstant $kAudioConverterDecompressionMagicCookie :|dmgc|);  A void * pointing to memory set up by the caller. Required by some
;  formats in order to decompress the input data.

(defconstant $kAudioConverterCompressionMagicCookie :|cmgc|);  A void * pointing to memory set up by the caller. Returned by the 
;  converter so that it may be stored along with the output data.
;  It can then be passed back to the converter for decompression
;  at a later time.

(defconstant $kAudioConverterEncodeBitRate :|brat|); 	A UInt32 containing the number of bits per second to aim
; 	for when encoding data. This property is only relevant to
; 	encoders.

(defconstant $kAudioConverterEncodeAdjustableSampleRate :|ajsr|); 	For encoders where the AudioConverter was created with an output sample rate of zero, 
;   and the codec can do rate conversion on its input, this provides a way to set the output sample rate.
; 	The property value is a Float64

(defconstant $kAudioConverterInputChannelLayout :|icl |);   The property value is an AudioChannelLayout.	

(defconstant $kAudioConverterOutputChannelLayout :|ocl |);   The property value is an AudioChannelLayout.	

(defconstant $kAudioConverterApplicableEncodeBitRates :|aebr|);   The property value is an array of AudioValueRange describing applicable bit rates based on current settings.

(defconstant $kAudioConverterAvailableEncodeBitRates :|vebr|);   The property value is an array of AudioValueRange describing available bit rates based on the input format.
;   You can get all available bit rates from the AudioFormat API.

(defconstant $kAudioConverterApplicableEncodeSampleRates :|aesr|);   The property value is an array of AudioValueRange describing applicable sample rates based on current settings.

(defconstant $kAudioConverterAvailableEncodeSampleRates :|vesr|);   The property value is an array of AudioValueRange describing available sample rates based on the input format.
;   You can get all available sample rates from the AudioFormat API.

(defconstant $kAudioConverterAvailableEncodeChannelLayoutTags :|aecl|);   The property value is an array of AudioChannelLayoutTags for the format and number of
;   channels specified in the input format going to the encoder. 

(defconstant $kAudioConverterCurrentOutputStreamDescription :|acod|);  Returns the current completely specified output AudioStreamBasicDescription.
;  For example when encoding to AAC, your original output stream description will not have been 
;  completely filled out.

(defconstant $kAudioConverterCurrentInputStreamDescription :|acid|);  Returns the current completely specified input AudioStreamBasicDescription.

;  constants to be used with kAudioConverterSampleRateConverterQuality

(defconstant $kAudioConverterQuality_Max 127)
(defconstant $kAudioConverterQuality_High 96)
(defconstant $kAudioConverterQuality_Medium 64)
(defconstant $kAudioConverterQuality_Low 32)
(defconstant $kAudioConverterQuality_Min 0)
;  constants to be used with kAudioConverterPrimeMethod

(defconstant $kConverterPrimeMethod_Pre 0)      ;  primes with leading + trailing input frames

(defconstant $kConverterPrimeMethod_Normal 1)   ;  only primes with trailing (zero latency)
;  leading frames are assumed to be silence

(defconstant $kConverterPrimeMethod_None 2)     ;  acts in "latency" mode
;  both leading and trailing frames assumed to be silence

;  Priming method and AudioConverterPrimeInfo
; 
;   When using AudioConverterFillBuffer() (either single call or series of calls),
;   some conversions (particularly involving sample-rate conversion)
;   ideally require a certain number of input frames previous to the normal
;   start input frame and beyond the end of the last expected input frame
;   in order to yield high-quality results.
; 
; 	leadingFrames
; 		specifies the number of leading (previous) input frames
; 		(relative to the normal/desired start input frame) required by the converter
; 		to perform a high quality conversion.
; 		If using kConverterPrimeMethod_Pre the client should "pre-seek"
; 		the input stream provided through the input proc by "leadingFrames"
; 		If no frames are available previous to the desired input start frame
; 		(because, for example, the desired start frame is at the very beginning
; 		of available audio) then provide "leadingFrames" worth of initial zero frames
; 		in the input proc.  Do not "pre-seek" in the default case of kConverterPrimeMethod_Normal
; 		or when using kConverterPrimeMethod_None.
; 		 
; 
; 	trailingFrames
; 		specifies the number of trailing input frames
; 		(past the normal/expected end input frame) required by the converter
; 		to perform a high quality conversion.  The client should be prepared
; 		to provide this number of additional input frames except when using
; 		kConverterPrimeMethod_None.
; 		If no more frames of input are available in the input stream
; 		(because, for example, the desired end frame is at the end of an audio file),
; 		then zero (silent) trailing frames will be synthesized for the client. 
; 
; 	The very first call to AudioConverterFillBuffer() or first call after AudioConverterReset()
; 	will request additional input frames approximately equal to:
; 			kConverterPrimeMethod_Pre		: leadingFrames + trailingFrames
; 			kConverterPrimeMethod_Normal	: trailingFrames
; 			kConverterPrimeMethod_None		: 0
; 	beyond that normally expected in the input proc callback(s) to fullfil
; 	this first AudioConverterFillBuffer() request.  Thus, in effect, the first input proc
; 	callback(s) may provide not only the leading frames, but also may "read ahead"
; 	by an additional number of trailing frames depending on the prime method.
; 	kConverterPrimeMethod_None is useful in a real-time application processing
; 	live input, in which case trailingFrames (relative to input sample rate) 
; 	of through latency will be seen at the beginning of the output of the AudioConverter.  In other
; 	real-time applications such as DAW systems, it may be possible to provide these initial extra
; 	audio frames since they are stored on disk or in memory somewhere and kConverterPrimeMethod_Pre
;   may be preferable.  The default method is kConverterPrimeMethod_Normal, which requires no
;   pre-seeking of the input stream and generates no latency at the output.
; 	
(defrecord AudioConverterPrimeInfo
   (leadingFrames :UInt32)
   (trailingFrames :UInt32)
)
; =============================================================================
; 	Errors
; =============================================================================

(defconstant $kAudioConverterErr_FormatNotSupported :|fmt?|)
(defconstant $kAudioConverterErr_OperationNotSupported #x6F703F3F);  'op??', integer used because of trigraph

(defconstant $kAudioConverterErr_PropertyNotSupported :|prop|)
(defconstant $kAudioConverterErr_InvalidInputSize :|insz|)
(defconstant $kAudioConverterErr_InvalidOutputSize :|otsz|);  e.g. byte size is not a multiple of the frame size

(defconstant $kAudioConverterErr_UnspecifiedError :|what|)
(defconstant $kAudioConverterErr_BadPropertySizeError :|!siz|)
(defconstant $kAudioConverterErr_RequiresPacketDescriptionsError :|!pkd|)
(defconstant $kAudioConverterErr_InputSampleRateOutOfRange :|!isr|)
(defconstant $kAudioConverterErr_OutputSampleRateOutOfRange :|!osr|)
; =============================================================================
; 	Routines
; =============================================================================
; -----------------------------------------------------------------------------
; 	AudioConverterNew
; 
; 	This routine is called to create a new AudioConverter.
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioConverterNew" 
   ((inSourceFormat (:pointer :AudioStreamBasicDescription))
    (inDestinationFormat (:pointer :AudioStreamBasicDescription))
    (outAudioConverter (:pointer :AUDIOCONVERTERREF))
   )
   :OSStatus
() )
; -----------------------------------------------------------------------------
; 	AudioConverterDispose
; 
; 	This routine is called to destroy an AudioConverter.
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioConverterDispose" 
   ((inAudioConverter (:pointer :OpaqueAudioConverter))
   )
   :OSStatus
() )
; -----------------------------------------------------------------------------
; 	AudioConverterReset
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioConverterReset" 
   ((inAudioConverter (:pointer :OpaqueAudioConverter))
   )
   :OSStatus
() )
; -----------------------------------------------------------------------------
; 	AudioConverterGetPropertyInfo
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioConverterGetPropertyInfo" 
   ((inAudioConverter (:pointer :OpaqueAudioConverter))
    (inPropertyID :UInt32)
    (outSize (:pointer :UInt32))
    (outWritable (:pointer :Boolean))
   )
   :OSStatus
() )
; -----------------------------------------------------------------------------
; 	AudioConverterGetProperty
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioConverterGetProperty" 
   ((inAudioConverter (:pointer :OpaqueAudioConverter))
    (inPropertyID :UInt32)
    (ioPropertyDataSize (:pointer :UInt32))
    (outPropertyData :pointer)
   )
   :OSStatus
() )
; -----------------------------------------------------------------------------
; 	AudioConverterSetProperty
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioConverterSetProperty" 
   ((inAudioConverter (:pointer :OpaqueAudioConverter))
    (inPropertyID :UInt32)
    (inPropertyDataSize :UInt32)
    (inPropertyData :pointer)
   )
   :OSStatus
() )
; -----------------------------------------------------------------------------
; 	AudioConverterDataProc
; 		ioDataSize: on input, the minimum amount of data the converter would
; 		like in order to fulfill its current FillBuffer request.  On output,
; 		the number of bytes actually being provided for input, or 0 if there
; 		is no more input.
; -----------------------------------------------------------------------------

(def-mactype :AudioConverterInputDataProc (find-mactype ':pointer)); (AudioConverterRef inAudioConverter , UInt32 * ioDataSize , void ** outData , void * inUserData)
; -----------------------------------------------------------------------------
; 	AudioConverterFillBuffer
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioConverterFillBuffer" 
   ((inAudioConverter (:pointer :OpaqueAudioConverter))
    (inInputDataProc :pointer)
    (inInputDataProcUserData :pointer)
    (ioOutputDataSize (:pointer :UInt32))
    (outOutputData :pointer)
   )
   :OSStatus
() )
; -----------------------------------------------------------------------------
; 	AudioConverterConvertBuffer
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioConverterConvertBuffer" 
   ((inAudioConverter (:pointer :OpaqueAudioConverter))
    (inInputDataSize :UInt32)
    (inInputData :pointer)
    (ioOutputDataSize (:pointer :UInt32))
    (outOutputData :pointer)
   )
   :OSStatus
() )
; -----------------------------------------------------------------------------
; 	AudioConverterComplexInputDataProc
; 
; 	ioData - provided by the converter, must be filled out by the callback
; -----------------------------------------------------------------------------

(def-mactype :AudioConverterComplexInputDataProc (find-mactype ':pointer)); (AudioConverterRef inAudioConverter , UInt32 * ioNumberDataPackets , AudioBufferList * ioData , AudioStreamPacketDescription ** outDataPacketDescription , void * inUserData)
; -----------------------------------------------------------------------------
; 	AudioConverterFillComplexBuffer
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioConverterFillComplexBuffer" 
   ((inAudioConverter (:pointer :OpaqueAudioConverter))
    (inInputDataProc :pointer)
    (inInputDataProcUserData :pointer)
    (ioOutputDataPacketSize (:pointer :UInt32))
    (outOutputData (:pointer :AudioBufferList))
    (outPacketDescription (:pointer :AudioStreamPacketDescription))
   )
   :OSStatus
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif


(provide-interface "AudioConverter")