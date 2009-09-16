(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ImageCompression.h"
; at Sunday July 2,2006 7:28:01 pm.
; 
;      File:       QuickTime/ImageCompression.h
;  
;      Contains:   QuickTime Image Compression Interfaces.
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
; #ifndef __IMAGECOMPRESSION__
; #define __IMAGECOMPRESSION__
; #ifndef __CARBON__
#| #|
#include <CarbonCarbon.h>
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
(defrecord MatrixRecord
   (matrix (:array :signed-long 9))
)

;type name? (%define-record :MatrixRecord (find-record-descriptor ':MatrixRecord))

(def-mactype :MatrixRecordPtr (find-mactype '(:pointer :MatrixRecord)))

(defconstant $kRawCodecType :|raw |)
(defconstant $kCinepakCodecType :|cvid|)
(defconstant $kGraphicsCodecType :|smc |)
(defconstant $kAnimationCodecType :|rle |)
(defconstant $kVideoCodecType :|rpza|)
(defconstant $kComponentVideoCodecType :|yuv2|)
(defconstant $kJPEGCodecType :|jpeg|)
(defconstant $kMotionJPEGACodecType :|mjpa|)
(defconstant $kMotionJPEGBCodecType :|mjpb|)
(defconstant $kSGICodecType :|.SGI|)
(defconstant $kPlanarRGBCodecType :|8BPS|)
(defconstant $kMacPaintCodecType :|PNTG|)
(defconstant $kGIFCodecType :|gif |)
(defconstant $kPhotoCDCodecType :|kpcd|)
(defconstant $kQuickDrawGXCodecType :|qdgx|)
(defconstant $kAVRJPEGCodecType :|avr |)
(defconstant $kOpenDMLJPEGCodecType :|dmb1|)
(defconstant $kBMPCodecType :|WRLE|)
(defconstant $kWindowsRawCodecType :|WRAW|)
(defconstant $kVectorCodecType :|path|)
(defconstant $kQuickDrawCodecType :|qdrw|)
(defconstant $kWaterRippleCodecType :|ripl|)
(defconstant $kFireCodecType :|fire|)
(defconstant $kCloudCodecType :|clou|)
(defconstant $kH261CodecType :|h261|)
(defconstant $kH263CodecType :|h263|)
(defconstant $kDVCNTSCCodecType :|dvc |)        ;  DV - NTSC and DVCPRO NTSC (available in QuickTime 6.0 or later)
;  NOTE: kDVCProNTSCCodecType is deprecated.  
;  Use kDVCNTSCCodecType instead -- as far as the codecs are concerned, 
;  the two data formats are identical.

(defconstant $kDVCPALCodecType :|dvcp|)
(defconstant $kDVCProPALCodecType :|dvpp|)      ;  available in QuickTime 6.0 or later

(defconstant $kDVCPro50NTSCCodecType :|dv5n|)
(defconstant $kDVCPro50PALCodecType :|dv5p|)
(defconstant $kDVCPro100NTSCCodecType :|dv1n|)
(defconstant $kDVCPro100PALCodecType :|dv1p|)
(defconstant $kBaseCodecType :|base|)
(defconstant $kFLCCodecType :|flic|)
(defconstant $kTargaCodecType :|tga |)
(defconstant $kPNGCodecType :|png |)
(defconstant $kTIFFCodecType :|tiff|)           ;  NOTE: despite what might seem obvious from the two constants
;  below and their names, they really are correct. 'yuvu' really 
;  does mean signed, and 'yuvs' really does mean unsigned. Really. 

(defconstant $kComponentVideoSigned :|yuvu|)
(defconstant $kComponentVideoUnsigned :|yuvs|)
(defconstant $kCMYKCodecType :|cmyk|)
(defconstant $kMicrosoftVideo1CodecType :|msvc|)
(defconstant $kSorensonCodecType :|SVQ1|)
(defconstant $kSorenson3CodecType :|SVQ3|)      ;  available in QuickTime 5 and later

(defconstant $kIndeo4CodecType :|IV41|)
(defconstant $kMPEG4VisualCodecType :|mp4v|)
(defconstant $k64ARGBCodecType :|b64a|)
(defconstant $k48RGBCodecType :|b48r|)
(defconstant $k32AlphaGrayCodecType :|b32a|)
(defconstant $k16GrayCodecType :|b16g|)
(defconstant $kMpegYUV420CodecType :|myuv|)
(defconstant $kYUV420CodecType :|y420|)
(defconstant $kSorensonYUV9CodecType :|syv9|)
(defconstant $k422YpCbCr8CodecType :|2vuy|)     ;  Component Y'CbCr 8-bit 4:2:2  

(defconstant $k444YpCbCr8CodecType :|v308|)     ;  Component Y'CbCr 8-bit 4:4:4  

(defconstant $k4444YpCbCrA8CodecType :|v408|)   ;  Component Y'CbCrA 8-bit 4:4:4:4 

(defconstant $k422YpCbCr16CodecType :|v216|)    ;  Component Y'CbCr 10,12,14,16-bit 4:2:2

(defconstant $k422YpCbCr10CodecType :|v210|)    ;  Component Y'CbCr 10-bit 4:2:2 

(defconstant $k444YpCbCr10CodecType :|v410|)    ;  Component Y'CbCr 10-bit 4:4:4 

(defconstant $k4444YpCbCrA8RCodecType :|r408|)  ;  Component Y'CbCrA 8-bit 4:4:4:4, rendering format. full range alpha, zero biased yuv

(defconstant $kJPEG2000CodecType :|mjp2|)
(defconstant $kPixletCodecType :|pxlt|)
;  one source effects 

(defconstant $kBlurImageFilterType :|blur|)
(defconstant $kSharpenImageFilterType :|shrp|)
(defconstant $kEdgeDetectImageFilterType :|edge|)
(defconstant $kEmbossImageFilterType :|embs|)
(defconstant $kConvolveImageFilterType :|genk|)
(defconstant $kAlphaGainImageFilterType :|gain|)
(defconstant $kRGBColorBalanceImageFilterType :|rgbb|)
(defconstant $kHSLColorBalanceImageFilterType :|hslb|)
(defconstant $kColorSyncImageFilterType :|sync|)
(defconstant $kFilmNoiseImageFilterType :|fmns|)
(defconstant $kSolarizeImageFilterType :|solr|)
(defconstant $kColorTintImageFilterType :|tint|)
(defconstant $kLensFlareImageFilterType :|lens|)
(defconstant $kBrightnessContrastImageFilterType :|brco|)
;  two source effects 

(defconstant $kAlphaCompositorTransitionType :|blnd|)
(defconstant $kCrossFadeTransitionType :|dslv|)
(defconstant $kChannelCompositeEffectType :|chan|)
(defconstant $kChromaKeyTransitionType :|ckey|)
(defconstant $kImplodeTransitionType :|mplo|)
(defconstant $kExplodeTransitionType :|xplo|)
(defconstant $kGradientTransitionType :|matt|)
(defconstant $kPushTransitionType :|push|)
(defconstant $kSlideTransitionType :|slid|)
(defconstant $kWipeTransitionType :|smpt|)
(defconstant $kIrisTransitionType :|smp2|)
(defconstant $kRadialTransitionType :|smp3|)
(defconstant $kMatrixTransitionType :|smp4|)
(defconstant $kZoomTransitionType :|zoom|)
;  three source effects 

(defconstant $kTravellingMatteEffectType :|trav|)
;  Supported by QTNewGWorld in QuickTime 4.0 and later 

(defconstant $kCMYKPixelFormat :|cmyk|)         ;  CMYK, 8-bit 

(defconstant $k64ARGBPixelFormat :|b64a|)       ;  ARGB, 16-bit big-endian samples 

(defconstant $k48RGBPixelFormat :|b48r|)        ;  RGB, 16-bit big-endian samples 

(defconstant $k32AlphaGrayPixelFormat :|b32a|)  ;  AlphaGray, 16-bit big-endian samples 

(defconstant $k16GrayPixelFormat :|b16g|)       ;  Grayscale, 16-bit big-endian samples 

(defconstant $k422YpCbCr8PixelFormat :|2vuy|)   ;  Component Y'CbCr 8-bit 4:2:2, ordered Cb Y'0 Cr Y'1 

;  Supported by QTNewGWorld in QuickTime 4.1.2 and later 

(defconstant $k4444YpCbCrA8PixelFormat :|v408|) ;  Component Y'CbCrA 8-bit 4:4:4:4, ordered Cb Y' Cr A 

(defconstant $k4444YpCbCrA8RPixelFormat :|r408|);  Component Y'CbCrA 8-bit 4:4:4:4, rendering format. full range alpha, zero biased yuv, ordered A Y' Cb Cr 

;  Supported by QTNewGWorld in QuickTime 6.0 and later 

(defconstant $kYUV420PixelFormat :|y420|)       ;  Planar Component Y'CbCr 8-bit 4:2:0.  PixMap baseAddr points to a big-endian PlanarPixmapInfoYUV420 struct; see ImageCodec.i. 

;  These are the bits that are set in the Component flags, and also in the codecInfo struct. 

(defconstant $codecInfoDoes1 1)                 ;  codec can work with 1-bit pixels 

(defconstant $codecInfoDoes2 2)                 ;  codec can work with 2-bit pixels 

(defconstant $codecInfoDoes4 4)                 ;  codec can work with 4-bit pixels 

(defconstant $codecInfoDoes8 8)                 ;  codec can work with 8-bit pixels 

(defconstant $codecInfoDoes16 16)               ;  codec can work with 16-bit pixels 

(defconstant $codecInfoDoes32 32)               ;  codec can work with 32-bit pixels 

(defconstant $codecInfoDoesDither 64)           ;  codec can do ditherMode 

(defconstant $codecInfoDoesStretch #x80)        ;  codec can stretch to arbitrary sizes 

(defconstant $codecInfoDoesShrink #x100)        ;  codec can shrink to arbitrary sizes 

(defconstant $codecInfoDoesMask #x200)          ;  codec can mask to clipping regions 

(defconstant $codecInfoDoesTemporal #x400)      ;  codec can handle temporal redundancy 

(defconstant $codecInfoDoesDouble #x800)        ;  codec can stretch to double size exactly 

(defconstant $codecInfoDoesQuad #x1000)         ;  codec can stretch to quadruple size exactly 

(defconstant $codecInfoDoesHalf #x2000)         ;  codec can shrink to half size 

(defconstant $codecInfoDoesQuarter #x4000)      ;  codec can shrink to quarter size 

(defconstant $codecInfoDoesRotate #x8000)       ;  codec can rotate on decompress 

(defconstant $codecInfoDoesHorizFlip #x10000)   ;  codec can flip horizontally on decompress 

(defconstant $codecInfoDoesVertFlip #x20000)    ;  codec can flip vertically on decompress 

(defconstant $codecInfoHasEffectParameterList #x40000);  codec implements get effects parameter list call, once was codecInfoDoesSkew 

(defconstant $codecInfoDoesBlend #x80000)       ;  codec can blend on decompress 

(defconstant $codecInfoDoesWarp #x100000)       ;  codec can warp arbitrarily on decompress 

(defconstant $codecInfoDoesRecompress #x200000) ;  codec can recompress image without accumulating errors 

(defconstant $codecInfoDoesSpool #x400000)      ;  codec can spool image data 
;  codec can data rate constrain 

(defconstant $codecInfoDoesRateConstrain #x800000)

(defconstant $codecInfoDepth1 1)                ;  compressed data at 1 bpp depth available 

(defconstant $codecInfoDepth2 2)                ;  compressed data at 2 bpp depth available 

(defconstant $codecInfoDepth4 4)                ;  compressed data at 4 bpp depth available 

(defconstant $codecInfoDepth8 8)                ;  compressed data at 8 bpp depth available 

(defconstant $codecInfoDepth16 16)              ;  compressed data at 16 bpp depth available 

(defconstant $codecInfoDepth32 32)              ;  compressed data at 32 bpp depth available 

(defconstant $codecInfoDepth24 64)              ;  compressed data at 24 bpp depth available 

(defconstant $codecInfoDepth33 #x80)            ;  compressed data at 1 bpp monochrome depth  available 

(defconstant $codecInfoDepth34 #x100)           ;  compressed data at 2 bpp grayscale depth available 

(defconstant $codecInfoDepth36 #x200)           ;  compressed data at 4 bpp grayscale depth available 

(defconstant $codecInfoDepth40 #x400)           ;  compressed data at 8 bpp grayscale depth available 

(defconstant $codecInfoStoresClut #x800)        ;  compressed data can have custom cluts 

(defconstant $codecInfoDoesLossless #x1000)     ;  compressed data can be stored in lossless format 
;  compressed data is sensitive to out of sequence decoding 

(defconstant $codecInfoSequenceSensitive #x2000)
;  input sequence flags

(defconstant $codecFlagUseImageBuffer 1)        ;  decompress

(defconstant $codecFlagUseScreenBuffer 2)       ;  decompress

(defconstant $codecFlagUpdatePrevious 4)        ;  compress

(defconstant $codecFlagNoScreenUpdate 8)        ;  decompress

(defconstant $codecFlagWasCompressed 16)        ;  compress

(defconstant $codecFlagDontOffscreen 32)        ;  decompress

(defconstant $codecFlagUpdatePreviousComp 64)   ;  compress

(defconstant $codecFlagForceKeyFrame #x80)      ;  compress

(defconstant $codecFlagOnlyScreenUpdate #x100)  ;  decompress

(defconstant $codecFlagLiveGrab #x200)          ;  compress

(defconstant $codecFlagDiffFrame #x200)         ;  decompress

(defconstant $codecFlagDontUseNewImageBuffer #x400);  decompress

(defconstant $codecFlagInterlaceUpdate #x800)   ;  decompress

(defconstant $codecFlagCatchUpDiff #x1000)      ;  decompress

(defconstant $codecFlagSupportDisable #x2000)   ;  decompress
;  decompress

(defconstant $codecFlagReenable #x4000)
;  output sequence flags

(defconstant $codecFlagOutUpdateOnNextIdle #x200)
(defconstant $codecFlagOutUpdateOnDataSourceChange #x400)
(defconstant $codecFlagSequenceSensitive #x800)
(defconstant $codecFlagOutUpdateOnTimeChange #x1000)
(defconstant $codecFlagImageBufferNotSourceImage #x2000)
(defconstant $codecFlagUsedNewImageBuffer #x4000)
(defconstant $codecFlagUsedImageBuffer #x8000)
;  The minimum data size for spooling in or out data 

(defconstant $codecMinimumDataSize #x8000)

(defconstant $compressorComponentType :|imco|)  ;  the type for "Components" which compress images 

(defconstant $decompressorComponentType :|imdc|);  the type for "Components" which decompress images 


(def-mactype :CompressorComponent (find-mactype ':Component))

(def-mactype :DecompressorComponent (find-mactype ':Component))

(def-mactype :CodecComponent (find-mactype ':Component))
(defconstant $anyCodec 0)
; #define anyCodec                ((CodecComponent)0)
; #define bestSpeedCodec          ((CodecComponent)-1)
; #define bestFidelityCodec       ((CodecComponent)-2)
; #define bestCompressionCodec    ((CodecComponent)-3)

(def-mactype :CodecType (find-mactype ':OSType))

(def-mactype :CodecFlags (find-mactype ':UInt16))

(def-mactype :CodecQ (find-mactype ':UInt32))

(defconstant $codecLosslessQuality #x400)
(defconstant $codecMaxQuality #x3FF)
(defconstant $codecMinQuality 0)
(defconstant $codecLowQuality #x100)
(defconstant $codecNormalQuality #x200)
(defconstant $codecHighQuality #x300)
;  shield cursor 

(defconstant $codecLockBitsShieldCursor 1)

(defconstant $codecCompletionSource 1)          ;  asynchronous codec is done with source data 

(defconstant $codecCompletionDest 2)            ;  asynchronous codec is done with destination data 

(defconstant $codecCompletionDontUnshield 4)    ;  on dest complete don't unshield cursor 

(defconstant $codecCompletionWentOffscreen 8)   ;  codec used offscreen buffer 

(defconstant $codecCompletionUnlockBits 16)     ;  on dest complete, call ICMSequenceUnlockBits 

(defconstant $codecCompletionForceChainFlush 32);  ICM needs to flush the whole chain 
;  codec decided to drop this frame 

(defconstant $codecCompletionDropped 64)

(defconstant $codecProgressOpen 0)
(defconstant $codecProgressUpdatePercent 1)
(defconstant $codecProgressClose 2)

(def-mactype :ICMDataProcPtr (find-mactype ':pointer)); (Ptr * dataP , long bytesNeeded , long refcon)

(def-mactype :ICMFlushProcPtr (find-mactype ':pointer)); (Ptr data , long bytesAdded , long refcon)

(def-mactype :ICMCompletionProcPtr (find-mactype ':pointer)); (OSErr result , short flags , long refcon)

(def-mactype :ICMProgressProcPtr (find-mactype ':pointer)); (short message , Fixed completeness , long refcon)

(def-mactype :StdPixProcPtr (find-mactype ':pointer)); (PixMap * src , Rect * srcRect , MatrixRecord * matrix , short mode , RgnHandle mask , PixMap * matte , Rect * matteRect , short flags)

(def-mactype :QDPixProcPtr (find-mactype ':pointer)); (PixMap * src , Rect * srcRect , MatrixRecord * matrix , short mode , RgnHandle mask , PixMap * matte , Rect * matteRect , short flags)

(def-mactype :ICMAlignmentProcPtr (find-mactype ':pointer)); (Rect * rp , long refcon)

(def-mactype :ICMCursorShieldedProcPtr (find-mactype ':pointer)); (const Rect * r , void * refcon , long flags)

(def-mactype :ICMMemoryDisposedProcPtr (find-mactype ':pointer)); (Ptr memoryBlock , void * refcon)

(def-mactype :ICMCursorNotify (find-mactype '(:pointer :void)))

(def-mactype :ICMConvertDataFormatProcPtr (find-mactype ':pointer)); (void * refCon , long flags , Handle desiredFormat , Handle sourceDataFormat , void * srcData , long srcDataSize , void ** dstData , long * dstDataSize)

(def-mactype :ICMDataUPP (find-mactype '(:pointer :OpaqueICMDataProcPtr)))

(def-mactype :ICMFlushUPP (find-mactype '(:pointer :OpaqueICMFlushProcPtr)))

(def-mactype :ICMCompletionUPP (find-mactype '(:pointer :OpaqueICMCompletionProcPtr)))

(def-mactype :ICMProgressUPP (find-mactype '(:pointer :OpaqueICMProgressProcPtr)))

(def-mactype :StdPixUPP (find-mactype '(:pointer :OpaqueStdPixProcPtr)))

(def-mactype :QDPixUPP (find-mactype '(:pointer :OpaqueQDPixProcPtr)))

(def-mactype :ICMAlignmentUPP (find-mactype '(:pointer :OpaqueICMAlignmentProcPtr)))

(def-mactype :ICMCursorShieldedUPP (find-mactype '(:pointer :OpaqueICMCursorShieldedProcPtr)))

(def-mactype :ICMMemoryDisposedUPP (find-mactype '(:pointer :OpaqueICMMemoryDisposedProcPtr)))

(def-mactype :ICMConvertDataFormatUPP (find-mactype '(:pointer :OpaqueICMConvertDataFormatProcPtr)))

(def-mactype :ImageSequence (find-mactype ':signed-long))

(def-mactype :ImageSequenceDataSource (find-mactype ':signed-long))

(def-mactype :ImageTranscodeSequence (find-mactype ':signed-long))

(def-mactype :ImageFieldSequence (find-mactype ':signed-long))
(defrecord ICMProgressProcRecord
   (progressProc (:pointer :OpaqueICMProgressProcPtr))
   (progressRefCon :signed-long)
)

;type name? (%define-record :ICMProgressProcRecord (find-record-descriptor ':ICMProgressProcRecord))

(def-mactype :ICMProgressProcRecordPtr (find-mactype '(:pointer :ICMProgressProcRecord)))
(defrecord ICMCompletionProcRecord
   (completionProc (:pointer :OpaqueICMCompletionProcPtr))
   (completionRefCon :signed-long)
)

;type name? (%define-record :ICMCompletionProcRecord (find-record-descriptor ':ICMCompletionProcRecord))

(def-mactype :ICMCompletionProcRecordPtr (find-mactype '(:pointer :ICMCompletionProcRecord)))
(defrecord ICMDataProcRecord
   (dataProc (:pointer :OpaqueICMDataProcPtr))
   (dataRefCon :signed-long)
)

;type name? (%define-record :ICMDataProcRecord (find-record-descriptor ':ICMDataProcRecord))

(def-mactype :ICMDataProcRecordPtr (find-mactype '(:pointer :ICMDataProcRecord)))
(defrecord ICMFlushProcRecord
   (flushProc (:pointer :OpaqueICMFlushProcPtr))
   (flushRefCon :signed-long)
)

;type name? (%define-record :ICMFlushProcRecord (find-record-descriptor ':ICMFlushProcRecord))

(def-mactype :ICMFlushProcRecordPtr (find-mactype '(:pointer :ICMFlushProcRecord)))
(defrecord ICMAlignmentProcRecord
   (alignmentProc (:pointer :OpaqueICMAlignmentProcPtr))
   (alignmentRefCon :signed-long)
)

;type name? (%define-record :ICMAlignmentProcRecord (find-record-descriptor ':ICMAlignmentProcRecord))

(def-mactype :ICMAlignmentProcRecordPtr (find-mactype '(:pointer :ICMAlignmentProcRecord)))
(defrecord DataRateParams
   (dataRate :signed-long)
   (dataOverrun :signed-long)
   (frameDuration :signed-long)
   (keyFrameRate :signed-long)
   (minSpatialQuality :UInt32)
   (minTemporalQuality :UInt32)
)

;type name? (%define-record :DataRateParams (find-record-descriptor ':DataRateParams))

(def-mactype :DataRateParamsPtr (find-mactype '(:pointer :DataRateParams)))
(defrecord (ImageDescription :handle)
   (idSize :signed-long)                        ;  total size of ImageDescription including extra data ( CLUTs and other per sequence data ) 
   (cType :OSType)                              ;  what kind of codec compressed this data 
   (resvd1 :signed-long)                        ;  reserved for Apple use 
   (resvd2 :SInt16)                             ;  reserved for Apple use 
   (dataRefIndex :SInt16)                       ;  set to zero  
   (version :SInt16)                            ;  which version is this data 
   (revisionLevel :SInt16)                      ;  what version of that codec did this 
   (vendor :signed-long)                        ;  whose  codec compressed this data 
   (temporalQuality :UInt32)                    ;  what was the temporal quality factor  
   (spatialQuality :UInt32)                     ;  what was the spatial quality factor 
   (width :SInt16)                              ;  how many pixels wide is this data 
   (height :SInt16)                             ;  how many pixels high is this data 
   (hRes :signed-long)                          ;  horizontal resolution 
   (vRes :signed-long)                          ;  vertical resolution 
   (dataSize :signed-long)                      ;  if known, the size of data for this image descriptor 
   (frameCount :SInt16)                         ;  number of frames this description applies to 
   (name (:string 31))                          ;  name of codec ( in case not installed )  
   (depth :SInt16)                              ;  what depth is this data (1-32) or ( 33-40 grayscale ) 
   (clutID :SInt16)                             ;  clut id or if 0 clut follows  or -1 if no clut 
)

;type name? (%define-record :ImageDescription (find-record-descriptor ':ImageDescription))

(def-mactype :ImageDescriptionPtr (find-mactype '(:pointer :ImageDescription)))

(def-mactype :ImageDescriptionHandle (find-mactype '(:handle :ImageDescription)))
(defrecord CodecInfo
   (typeName (:string 31))                      ;  name of the codec type i.e.: 'Apple Image Compression' 
   (version :SInt16)                            ;  version of the codec data that this codec knows about 
   (revisionLevel :SInt16)                      ;  revision level of this codec i.e: 0x00010001 (1.0.1) 
   (vendor :signed-long)                        ;  Maker of this codec i.e: 'appl' 
   (decompressFlags :signed-long)               ;  codecInfo flags for decompression capabilities 
   (compressFlags :signed-long)                 ;  codecInfo flags for compression capabilities 
   (formatFlags :signed-long)                   ;  codecInfo flags for compression format details 
   (compressionAccuracy :UInt8)                 ;  measure (1-255) of accuracy of this codec for compress (0 if unknown) 
   (decompressionAccuracy :UInt8)               ;  measure (1-255) of accuracy of this codec for decompress (0 if unknown) 
   (compressionSpeed :UInt16)                   ;  ( millisecs for compressing 320x240 on base mac II) (0 if unknown)  
   (decompressionSpeed :UInt16)                 ;  ( millisecs for decompressing 320x240 on mac II)(0 if unknown)  
   (compressionLevel :UInt8)                    ;  measure (1-255) of compression level of this codec (0 if unknown)  
   (resvd :UInt8)                               ;  pad 
   (minimumHeight :SInt16)                      ;  minimum height of image (block size) 
   (minimumWidth :SInt16)                       ;  minimum width of image (block size) 
   (decompressPipelineLatency :SInt16)          ;  in milliseconds ( for asynchronous codecs ) 
   (compressPipelineLatency :SInt16)            ;  in milliseconds ( for asynchronous codecs ) 
   (privateData :signed-long)
)

;type name? (%define-record :CodecInfo (find-record-descriptor ':CodecInfo))
(defrecord CodecNameSpec
   (codec (:pointer :ComponentRecord))
   (cType :OSType)
   (typeName (:string 31))
   (name :Handle)
)

;type name? (%define-record :CodecNameSpec (find-record-descriptor ':CodecNameSpec))
(defrecord CodecNameSpecList
   (count :SInt16)
   (list (:array :CodecNameSpec 1))
)

;type name? (%define-record :CodecNameSpecList (find-record-descriptor ':CodecNameSpecList))

(def-mactype :CodecNameSpecListPtr (find-mactype '(:pointer :CodecNameSpecList)))

(defconstant $defaultDither 0)
(defconstant $forceDither 1)
(defconstant $suppressDither 2)
(defconstant $useColorMatching 4)

(defconstant $callStdBits 1)
(defconstant $callOldBits 2)
(defconstant $noDefaultOpcodes 4)

(defconstant $graphicsModeStraightAlpha #x100)
(defconstant $graphicsModePreWhiteAlpha #x101)
(defconstant $graphicsModePreBlackAlpha #x102)
(defconstant $graphicsModeComposition #x103)
(defconstant $graphicsModeStraightAlphaBlend #x104)
(defconstant $graphicsModePreMulColorAlpha #x105)
(defconstant $graphicsModePerComponentAlpha #x110)

(defconstant $evenField1ToEvenFieldOut 1)
(defconstant $evenField1ToOddFieldOut 2)
(defconstant $oddField1ToEvenFieldOut 4)
(defconstant $oddField1ToOddFieldOut 8)
(defconstant $evenField2ToEvenFieldOut 16)
(defconstant $evenField2ToOddFieldOut 32)
(defconstant $oddField2ToEvenFieldOut 64)
(defconstant $oddField2ToOddFieldOut #x80)
;  Flags for ICMFrameTimeRecord.flags 

(defconstant $icmFrameTimeHasVirtualStartTimeAndDuration 1)
(defrecord ICMFrameTimeRecord
   (value :wide)                                ;  frame time
   (scale :signed-long)                         ;  timescale of value/duration fields
   (base :pointer)                              ;  timebase
   (duration :signed-long)                      ;  duration frame is to be displayed (0 if unknown)
   (rate :signed-long)                          ;  rate of timebase relative to wall-time
   (recordSize :signed-long)                    ;  total number of bytes in ICMFrameTimeRecord
   (frameNumber :signed-long)                   ;  number of frame, zero if not known
   (flags :signed-long)
   (virtualStartTime :wide)                     ;  conceptual start time
   (virtualDuration :signed-long)               ;  conceptual duration
)

;type name? (%define-record :ICMFrameTimeRecord (find-record-descriptor ':ICMFrameTimeRecord))

(def-mactype :ICMFrameTimePtr (find-mactype '(:pointer :ICMFrameTimeRecord)))
; #ifndef __QTUUID__
(defconstant $__QTUUID__ 1)
; #define __QTUUID__ 1
;  QuickTime flavor of universally unique identifier (uuid)
(defrecord QTUUID
   (data1 :UInt32)
   (data2 :UInt16)
   (data3 :UInt16)
   (data4 (:array :UInt8 8))
)

;type name? (%define-record :QTUUID (find-record-descriptor ':QTUUID))

(%define-record :QTMediaContextID (find-record-descriptor ':QTUUID))

; #endif  /* !defined(__QTUUID__) */

; 
;  *  NewICMDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewICMDataUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueICMDataProcPtr)
() )
; 
;  *  NewICMFlushUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewICMFlushUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueICMFlushProcPtr)
() )
; 
;  *  NewICMCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewICMCompletionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueICMCompletionProcPtr)
() )
; 
;  *  NewICMProgressUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewICMProgressUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueICMProgressProcPtr)
() )
; 
;  *  NewStdPixUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewStdPixUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueStdPixProcPtr)
() )
; 
;  *  NewQDPixUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDPixUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDPixProcPtr)
() )
; 
;  *  NewICMAlignmentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewICMAlignmentUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueICMAlignmentProcPtr)
() )
; 
;  *  NewICMCursorShieldedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewICMCursorShieldedUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueICMCursorShieldedProcPtr)
() )
; 
;  *  NewICMMemoryDisposedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewICMMemoryDisposedUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueICMMemoryDisposedProcPtr)
() )
; 
;  *  NewICMConvertDataFormatUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewICMConvertDataFormatUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueICMConvertDataFormatProcPtr)
() )
; 
;  *  DisposeICMDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeICMDataUPP" 
   ((userUPP (:pointer :OpaqueICMDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeICMFlushUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeICMFlushUPP" 
   ((userUPP (:pointer :OpaqueICMFlushProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeICMCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeICMCompletionUPP" 
   ((userUPP (:pointer :OpaqueICMCompletionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeICMProgressUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeICMProgressUPP" 
   ((userUPP (:pointer :OpaqueICMProgressProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeStdPixUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeStdPixUPP" 
   ((userUPP (:pointer :OpaqueStdPixProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDPixUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDPixUPP" 
   ((userUPP (:pointer :OpaqueQDPixProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeICMAlignmentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeICMAlignmentUPP" 
   ((userUPP (:pointer :OpaqueICMAlignmentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeICMCursorShieldedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeICMCursorShieldedUPP" 
   ((userUPP (:pointer :OpaqueICMCursorShieldedProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeICMMemoryDisposedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeICMMemoryDisposedUPP" 
   ((userUPP (:pointer :OpaqueICMMemoryDisposedProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeICMConvertDataFormatUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeICMConvertDataFormatUPP" 
   ((userUPP (:pointer :OpaqueICMConvertDataFormatProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeICMDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeICMDataUPP" 
   ((dataP (:pointer :Ptr))
    (bytesNeeded :signed-long)
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueICMDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeICMFlushUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeICMFlushUPP" 
   ((data :pointer)
    (bytesAdded :signed-long)
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueICMFlushProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeICMCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeICMCompletionUPP" 
   ((result :SInt16)
    (flags :SInt16)
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueICMCompletionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeICMProgressUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeICMProgressUPP" 
   ((message :SInt16)
    (completeness :signed-long)
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueICMProgressProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeStdPixUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeStdPixUPP" 
   ((src (:pointer :PixMap))
    (srcRect (:pointer :Rect))
    (matrix (:pointer :MatrixRecord))
    (mode :SInt16)
    (mask (:pointer :OpaqueRgnHandle))
    (matte (:pointer :PixMap))
    (matteRect (:pointer :Rect))
    (flags :SInt16)
    (userUPP (:pointer :OpaqueStdPixProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDPixUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDPixUPP" 
   ((src (:pointer :PixMap))
    (srcRect (:pointer :Rect))
    (matrix (:pointer :MatrixRecord))
    (mode :SInt16)
    (mask (:pointer :OpaqueRgnHandle))
    (matte (:pointer :PixMap))
    (matteRect (:pointer :Rect))
    (flags :SInt16)
    (userUPP (:pointer :OpaqueQDPixProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeICMAlignmentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeICMAlignmentUPP" 
   ((rp (:pointer :Rect))
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueICMAlignmentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeICMCursorShieldedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeICMCursorShieldedUPP" 
   ((r (:pointer :Rect))
    (refcon :pointer)
    (flags :signed-long)
    (userUPP (:pointer :OpaqueICMCursorShieldedProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeICMMemoryDisposedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeICMMemoryDisposedUPP" 
   ((memoryBlock :pointer)
    (refcon :pointer)
    (userUPP (:pointer :OpaqueICMMemoryDisposedProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeICMConvertDataFormatUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeICMConvertDataFormatUPP" 
   ((refCon :pointer)
    (flags :signed-long)
    (desiredFormat :Handle)
    (sourceDataFormat :Handle)
    (srcData :pointer)
    (srcDataSize :signed-long)
    (dstData :pointer)
    (dstDataSize (:pointer :long))
    (userUPP (:pointer :OpaqueICMConvertDataFormatProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CodecManagerVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CodecManagerVersion" 
   ((version (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCodecNameList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetCodecNameList" 
   ((list (:pointer :CODECNAMESPECLISTPTR))
    (showAll :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DisposeCodecNameList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeCodecNameList" 
   ((list (:pointer :CodecNameSpecList))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCodecInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetCodecInfo" 
   ((info (:pointer :CodecInfo))
    (cType :OSType)
    (codec (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMaxCompressionSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMaxCompressionSize" 
   ((src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (colorDepth :SInt16)
    (quality :UInt32)
    (cType :OSType)
    (codec (:pointer :ComponentRecord))
    (size (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCSequenceMaxCompressionSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetCSequenceMaxCompressionSize" 
   ((seqID :signed-long)
    (src (:Handle :PixMap))
    (size (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCompressionTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetCompressionTime" 
   ((src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (colorDepth :SInt16)
    (cType :OSType)
    (codec (:pointer :ComponentRecord))
    (spatialQuality (:pointer :CODECQ))
    (temporalQuality (:pointer :CODECQ))
    (compressTime (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CompressImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompressImage" 
   ((src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (quality :UInt32)
    (cType :OSType)
    (desc (:Handle :ImageDescription))
    (data :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FCompressImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_FCompressImage" 
   ((src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (colorDepth :SInt16)
    (quality :UInt32)
    (cType :OSType)
    (codec (:pointer :ComponentRecord))
    (ctable (:Handle :ColorTable))
    (flags :UInt16)
    (bufferSize :signed-long)
    (flushProc (:pointer :ICMFlushProcRecord))
    (progressProc (:pointer :ICMProgressProcRecord))
    (desc (:Handle :ImageDescription))
    (data :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DecompressImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DecompressImage" 
   ((data :pointer)
    (desc (:Handle :ImageDescription))
    (dst (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
    (mode :SInt16)
    (mask (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FDecompressImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_FDecompressImage" 
   ((data :pointer)
    (desc (:Handle :ImageDescription))
    (dst (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (matrix (:pointer :MatrixRecord))
    (mode :SInt16)
    (mask (:pointer :OpaqueRgnHandle))
    (matte (:Handle :PixMap))
    (matteRect (:pointer :Rect))
    (accuracy :UInt32)
    (codec (:pointer :ComponentRecord))
    (bufferSize :signed-long)
    (dataProc (:pointer :ICMDataProcRecord))
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CompressSequenceBegin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompressSequenceBegin" 
   ((seqID (:pointer :IMAGESEQUENCE))
    (src (:Handle :PixMap))
    (prev (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (prevRect (:pointer :Rect))
    (colorDepth :SInt16)
    (cType :OSType)
    (codec (:pointer :ComponentRecord))
    (spatialQuality :UInt32)
    (temporalQuality :UInt32)
    (keyFrameRate :signed-long)
    (ctable (:Handle :ColorTable))
    (flags :UInt16)
    (desc (:Handle :ImageDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CompressSequenceFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompressSequenceFrame" 
   ((seqID :signed-long)
    (src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (flags :UInt16)
    (data :pointer)
    (dataSize (:pointer :long))
    (similarity (:pointer :UInt8))
    (asyncCompletionProc (:pointer :ICMCompletionProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DecompressSequenceBegin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DecompressSequenceBegin" 
   ((seqID (:pointer :IMAGESEQUENCE))
    (desc (:Handle :ImageDescription))
    (port (:pointer :OpaqueGrafPtr))
    (gdh (:Handle :GDEVICE))
    (srcRect (:pointer :Rect))
    (matrix (:pointer :MatrixRecord))
    (mode :SInt16)
    (mask (:pointer :OpaqueRgnHandle))
    (flags :UInt16)
    (accuracy :UInt32)
    (codec (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DecompressSequenceBeginS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DecompressSequenceBeginS" 
   ((seqID (:pointer :IMAGESEQUENCE))
    (desc (:Handle :ImageDescription))
    (data :pointer)
    (dataSize :signed-long)
    (port (:pointer :OpaqueGrafPtr))
    (gdh (:Handle :GDEVICE))
    (srcRect (:pointer :Rect))
    (matrix (:pointer :MatrixRecord))
    (mode :SInt16)
    (mask (:pointer :OpaqueRgnHandle))
    (flags :UInt16)
    (accuracy :UInt32)
    (codec (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DecompressSequenceFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DecompressSequenceFrame" 
   ((seqID :signed-long)
    (data :pointer)
    (inFlags :UInt16)
    (outFlags (:pointer :CODECFLAGS))
    (asyncCompletionProc (:pointer :ICMCompletionProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DecompressSequenceFrameS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DecompressSequenceFrameS" 
   ((seqID :signed-long)
    (data :pointer)
    (dataSize :signed-long)
    (inFlags :UInt16)
    (outFlags (:pointer :CODECFLAGS))
    (asyncCompletionProc (:pointer :ICMCompletionProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DecompressSequenceFrameWhen()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DecompressSequenceFrameWhen" 
   ((seqID :signed-long)
    (data :pointer)
    (dataSize :signed-long)
    (inFlags :UInt16)
    (outFlags (:pointer :CODECFLAGS))
    (asyncCompletionProc (:pointer :ICMCompletionProcRecord))
    (frameTime (:pointer :ICMFrameTimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceFlush()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceFlush" 
   ((seqID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDSequenceMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetDSequenceMatrix" 
   ((seqID :signed-long)
    (matrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDSequenceMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GetDSequenceMatrix" 
   ((seqID :signed-long)
    (matrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDSequenceMatte()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetDSequenceMatte" 
   ((seqID :signed-long)
    (matte (:Handle :PixMap))
    (matteRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDSequenceMask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetDSequenceMask" 
   ((seqID :signed-long)
    (mask (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDSequenceTransferMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetDSequenceTransferMode" 
   ((seqID :signed-long)
    (mode :SInt16)
    (opColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDSequenceDataProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetDSequenceDataProc" 
   ((seqID :signed-long)
    (dataProc (:pointer :ICMDataProcRecord))
    (bufferSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDSequenceAccuracy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetDSequenceAccuracy" 
   ((seqID :signed-long)
    (accuracy :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDSequenceSrcRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetDSequenceSrcRect" 
   ((seqID :signed-long)
    (srcRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDSequenceFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_SetDSequenceFlags" 
   ((seqID :signed-long)
    (flags :signed-long)
    (flagsMask :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

(defconstant $codecDSequenceDisableOverlaySurface 32)
(defconstant $codecDSequenceSingleField 64)
(defconstant $codecDSequenceBidirectionalPrediction #x80)
(defconstant $codecDSequenceFlushInsteadOfDirtying #x100)
(defconstant $codecDSequenceEnableSubPixelPositioning #x200)

(def-mactype :CodecComponentPtr (find-mactype '(:handle :ComponentRecord)))

(def-mactype :CodecComponentHandle (find-mactype '(:pointer :CodecComponentPtr)))
;  selectors for ICMSequenceGet/SetInfo

(defconstant $kICMSequenceTaskWeight :|twei|)   ;  data is pointer to UInt32

(defconstant $kICMSequenceTaskName :|tnam|)     ;  data is pointer to OSType

(defconstant $kICMSequenceUserPreferredCodecs :|punt|);  data is pointer to CodecComponentHandle

; 
;  *  ICMSequenceGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_ICMSequenceGetInfo" 
   ((seqID :signed-long)
    (which :OSType)
    (data :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICMSequenceSetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_ICMSequenceSetInfo" 
   ((seqID :signed-long)
    (which :OSType)
    (data :pointer)
    (dataSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDSequenceImageBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetDSequenceImageBuffer" 
   ((seqID :signed-long)
    (gworld (:pointer :GWORLDPTR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDSequenceScreenBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetDSequenceScreenBuffer" 
   ((seqID :signed-long)
    (gworld (:pointer :GWORLDPTR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetCSequenceQuality()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetCSequenceQuality" 
   ((seqID :signed-long)
    (spatialQuality :UInt32)
    (temporalQuality :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetCSequencePrev()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetCSequencePrev" 
   ((seqID :signed-long)
    (prev (:Handle :PixMap))
    (prevRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetCSequenceFlushProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetCSequenceFlushProc" 
   ((seqID :signed-long)
    (flushProc (:pointer :ICMFlushProcRecord))
    (bufferSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetCSequenceKeyFrameRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetCSequenceKeyFrameRate" 
   ((seqID :signed-long)
    (keyFrameRate :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCSequenceKeyFrameRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetCSequenceKeyFrameRate" 
   ((seqID :signed-long)
    (keyFrameRate (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCSequencePrevBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetCSequencePrevBuffer" 
   ((seqID :signed-long)
    (gworld (:pointer :GWORLDPTR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceBusy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceBusy" 
   ((seqID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceEnd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceEnd" 
   ((seqID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceEquivalentImageDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceEquivalentImageDescription" 
   ((seqID :signed-long)
    (newDesc (:Handle :ImageDescription))
    (equivalent (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceEquivalentImageDescriptionS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_CDSequenceEquivalentImageDescriptionS" 
   ((seqID :signed-long)
    (newDesc (:Handle :ImageDescription))
    (equivalent (:pointer :Boolean))
    (canSwitch (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ReplaceDSequenceImageDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_ReplaceDSequenceImageDescription" 
   ((seqID :signed-long)
    (newDesc (:Handle :ImageDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCompressedImageSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetCompressedImageSize" 
   ((desc (:Handle :ImageDescription))
    (data :pointer)
    (bufferSize :signed-long)
    (dataProc (:pointer :ICMDataProcRecord))
    (dataSize (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetSimilarity()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetSimilarity" 
   ((src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (desc (:Handle :ImageDescription))
    (data :pointer)
    (similarity (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

(defconstant $kImageDescriptionSampleFormat :|idfm|);  image description extension describing sample format

(defconstant $kImageDescriptionClassicAtomFormat :|atom|);  sample contains classic atom structure (ie, GX codec and Curve codec)

(defconstant $kImageDescriptionQTAtomFormat :|qtat|);  sample contains QT atom structure

(defconstant $kImageDescriptionEffectDataFormat :|fxat|);  sample describes an effect (as QTAtoms)

(defconstant $kImageDescriptionPrivateDataFormat :|priv|);  sample is in a private codec specific format

(defconstant $kImageDescriptionAlternateCodec :|subs|);  image description extension containing the OSType of a substitute codec should the main codec not be available

(defconstant $kImageDescriptionColorSpace :|cspc|);  image description extension containing an OSType naming the native pixel format of an image (only used for pixel formats not supported by classic Color QuickDraw)

; 
;  *  GetImageDescriptionCTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetImageDescriptionCTable" 
   ((desc (:Handle :ImageDescription))
    (ctable (:pointer :CTABHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetImageDescriptionCTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetImageDescriptionCTable" 
   ((desc (:Handle :ImageDescription))
    (ctable (:Handle :ColorTable))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetImageDescriptionExtension()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetImageDescriptionExtension" 
   ((desc (:Handle :ImageDescription))
    (extension (:pointer :Handle))
    (idType :signed-long)
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AddImageDescriptionExtension()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddImageDescriptionExtension" 
   ((desc (:Handle :ImageDescription))
    (extension :Handle)
    (idType :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveImageDescriptionExtension()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_RemoveImageDescriptionExtension" 
   ((desc (:Handle :ImageDescription))
    (idType :signed-long)
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CountImageDescriptionExtensionType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CountImageDescriptionExtensionType" 
   ((desc (:Handle :ImageDescription))
    (idType :signed-long)
    (count (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetNextImageDescriptionExtensionType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetNextImageDescriptionExtensionType" 
   ((desc (:Handle :ImageDescription))
    (idType (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FindCodec()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_FindCodec" 
   ((cType :OSType)
    (specCodec (:pointer :ComponentRecord))
    (compressor (:pointer :COMPRESSORCOMPONENT))
    (decompressor (:pointer :DECOMPRESSORCOMPONENT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CompressPicture()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompressPicture" 
   ((srcPicture (:Handle :Picture))
    (dstPicture (:Handle :Picture))
    (quality :UInt32)
    (cType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FCompressPicture()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_FCompressPicture" 
   ((srcPicture (:Handle :Picture))
    (dstPicture (:Handle :Picture))
    (colorDepth :SInt16)
    (ctable (:Handle :ColorTable))
    (quality :UInt32)
    (doDither :SInt16)
    (compressAgain :SInt16)
    (progressProc (:pointer :ICMProgressProcRecord))
    (cType :OSType)
    (codec (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CompressPictureFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompressPictureFile" 
   ((srcRefNum :SInt16)
    (dstRefNum :SInt16)
    (quality :UInt32)
    (cType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FCompressPictureFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_FCompressPictureFile" 
   ((srcRefNum :SInt16)
    (dstRefNum :SInt16)
    (colorDepth :SInt16)
    (ctable (:Handle :ColorTable))
    (quality :UInt32)
    (doDither :SInt16)
    (compressAgain :SInt16)
    (progressProc (:pointer :ICMProgressProcRecord))
    (cType :OSType)
    (codec (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetPictureFileHeader()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetPictureFileHeader" 
   ((refNum :SInt16)
    (frame (:pointer :Rect))
    (header (:pointer :OpenCPicParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DrawPictureFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DrawPictureFile" 
   ((refNum :SInt16)
    (frame (:pointer :Rect))
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DrawTrimmedPicture()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DrawTrimmedPicture" 
   ((srcPicture (:Handle :Picture))
    (frame (:pointer :Rect))
    (trimMask (:pointer :OpaqueRgnHandle))
    (doDither :SInt16)
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DrawTrimmedPictureFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DrawTrimmedPictureFile" 
   ((srcRefnum :SInt16)
    (frame (:pointer :Rect))
    (trimMask (:pointer :OpaqueRgnHandle))
    (doDither :SInt16)
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  MakeThumbnailFromPicture()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MakeThumbnailFromPicture" 
   ((picture (:Handle :Picture))
    (colorDepth :SInt16)
    (thumbnail (:Handle :Picture))
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  MakeThumbnailFromPictureFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MakeThumbnailFromPictureFile" 
   ((refNum :SInt16)
    (colorDepth :SInt16)
    (thumbnail (:Handle :Picture))
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  MakeThumbnailFromPixMap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MakeThumbnailFromPixMap" 
   ((src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (colorDepth :SInt16)
    (thumbnail (:Handle :Picture))
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  TrimImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TrimImage" 
   ((desc (:Handle :ImageDescription))
    (inData :pointer)
    (inBufferSize :signed-long)
    (dataProc (:pointer :ICMDataProcRecord))
    (outData :pointer)
    (outBufferSize :signed-long)
    (flushProc (:pointer :ICMFlushProcRecord))
    (trimRect (:pointer :Rect))
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ConvertImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ConvertImage" 
   ((srcDD (:Handle :ImageDescription))
    (srcData :pointer)
    (colorDepth :SInt16)
    (ctable (:Handle :ColorTable))
    (accuracy :UInt32)
    (quality :UInt32)
    (cType :OSType)
    (codec (:pointer :ComponentRecord))
    (dstDD (:Handle :ImageDescription))
    (dstData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCompressedPixMapInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetCompressedPixMapInfo" 
   ((pix (:pointer :PixMap))
    (desc (:pointer :IMAGEDESCRIPTIONHANDLE))
    (data (:pointer :Ptr))
    (bufferSize (:pointer :long))
    (dataProc (:pointer :ICMDataProcRecord))
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetCompressedPixMapInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetCompressedPixMapInfo" 
   ((pix (:pointer :PixMap))
    (desc (:Handle :ImageDescription))
    (data :pointer)
    (bufferSize :signed-long)
    (dataProc (:pointer :ICMDataProcRecord))
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  StdPix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_StdPix" 
   ((src (:pointer :PixMap))
    (srcRect (:pointer :Rect))
    (matrix (:pointer :MatrixRecord))
    (mode :SInt16)
    (mask (:pointer :OpaqueRgnHandle))
    (matte (:pointer :PixMap))
    (matteRect (:pointer :Rect))
    (flags :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TransformRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TransformRgn" 
   ((matrix (:pointer :MatrixRecord))
    (rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; **********
;     preview stuff
; **********
; 
;  *  SFGetFilePreview()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  SFPGetFilePreview()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  StandardGetFilePreview()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  CustomGetFilePreview()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  MakeFilePreview()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MakeFilePreview" 
   ((resRefNum :SInt16)
    (progress (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AddFilePreview()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddFilePreview" 
   ((resRefNum :SInt16)
    (previewType :OSType)
    (previewData :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
(defrecord (PreviewResourceRecord :handle)
   (modDate :UInt32)
   (version :SInt16)
   (resType :OSType)
   (resID :SInt16)
)

;type name? (%define-record :PreviewResourceRecord (find-record-descriptor ':PreviewResourceRecord))

(def-mactype :PreviewResourcePtr (find-mactype '(:pointer :PreviewResourceRecord)))

(def-mactype :PreviewResource (find-mactype '(:handle :PreviewResourceRecord)))
; 
;  *  AlignScreenRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AlignScreenRect" 
   ((rp (:pointer :Rect))
    (alignmentProc (:pointer :ICMAlignmentProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AlignWindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AlignWindow" 
   ((wp (:pointer :OpaqueWindowPtr))
    (front :Boolean)
    (alignmentRect (:pointer :Rect))
    (alignmentProc (:pointer :ICMAlignmentProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DragAlignedWindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DragAlignedWindow" 
   ((wp (:pointer :OpaqueWindowPtr))
    (startPt :Point)
    (boundsRect (:pointer :Rect))
    (alignmentRect (:pointer :Rect))
    (alignmentProc (:pointer :ICMAlignmentProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DragAlignedGrayRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DragAlignedGrayRgn" 
   ((theRgn (:pointer :OpaqueRgnHandle))
    (startPt :Point)
    (boundsRect (:pointer :Rect))
    (slopRect (:pointer :Rect))
    (axis :SInt16)
    (actionProc (:pointer :RoutineDescriptor))
    (alignmentRect (:pointer :Rect))
    (alignmentProc (:pointer :ICMAlignmentProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetCSequenceDataRateParams()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetCSequenceDataRateParams" 
   ((seqID :signed-long)
    (params (:pointer :DataRateParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetCSequenceFrameNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetCSequenceFrameNumber" 
   ((seqID :signed-long)
    (frameNumber :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetCSequencePreferredPacketSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetCSequencePreferredPacketSize" 
   ((seqID :signed-long)
    (preferredPacketSizeInBytes :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewImageGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewImageGWorld" 
   ((gworld (:pointer :GWORLDPTR))
    (idh (:Handle :ImageDescription))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCSequenceDataRateParams()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetCSequenceDataRateParams" 
   ((seqID :signed-long)
    (params (:pointer :DataRateParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCSequenceFrameNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetCSequenceFrameNumber" 
   ((seqID :signed-long)
    (frameNumber (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetBestDeviceRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetBestDeviceRect" 
   ((gdh (:pointer :GDHandle))
    (rp (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetSequenceProgressProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetSequenceProgressProc" 
   ((seqID :signed-long)
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GDHasScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GDHasScale" 
   ((gdh (:Handle :GDEVICE))
    (depth :SInt16)
    (scale (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GDGetScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GDGetScale" 
   ((gdh (:Handle :GDEVICE))
    (scale (:pointer :Fixed))
    (flags (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GDSetScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GDSetScale" 
   ((gdh (:Handle :GDEVICE))
    (scale :signed-long)
    (flags :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICMShieldSequenceCursor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ICMShieldSequenceCursor" 
   ((seqID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICMDecompressComplete()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ICMDecompressComplete" 
   ((seqID :signed-long)
    (err :SInt16)
    (flag :SInt16)
    (completionRtn (:pointer :ICMCompletionProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ICMDecompressCompleteS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ICMDecompressCompleteS" 
   ((seqID :signed-long)
    (err :SInt16)
    (flag :SInt16)
    (completionRtn (:pointer :ICMCompletionProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICMSequenceLockBits()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ICMSequenceLockBits" 
   ((seqID :signed-long)
    (dst (:pointer :PixMap))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICMSequenceUnlockBits()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ICMSequenceUnlockBits" 
   ((seqID :signed-long)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

(defconstant $kICMPixelFormatIsPlanarMask 15)   ;  these bits in formatFlags indicate how many planes there are; they're 0 if chunky

(defconstant $kICMPixelFormatIsIndexed 16)
(defconstant $kICMPixelFormatIsSupportedByQD 32)
(defconstant $kICMPixelFormatIsMonochrome 64)
(defconstant $kICMPixelFormatHasAlphaChannel #x80)
(defrecord ICMPixelFormatInfo
   (size :signed-long)                          ;  caller MUST fill this in with sizeof(ICMPixelFormatInfo) before calling ICMGet/SetPixelFormatInfo
   (formatFlags :UInt32)
   (bitsPerPixel (:array :SInt16 14))           ;  list each plane's bits per pixel separately if planar
                                                ;  new field for QuickTime 4.1
   (defaultGammaLevel :signed-long)
                                                ;  new fields for QuickTime 6.0
   (horizontalSubsampling (:array :SInt16 14))  ;  per plane; use 1 if plane is not subsampled
   (verticalSubsampling (:array :SInt16 14))    ;  per plane; use 1 if plane is not subsampled
                                                ;  new fields for QuickTime 6.5
   (cmpCount :SInt16)                           ;  for use in PixMap.cmpCount
   (cmpSize :SInt16)                            ;  for use in PixMap.cmpSize
)

;type name? (%define-record :ICMPixelFormatInfo (find-record-descriptor ':ICMPixelFormatInfo))

(def-mactype :ICMPixelFormatInfoPtr (find-mactype '(:pointer :ICMPixelFormatInfo)))
;  IMPORTANT: Fill in theInfo->size with sizeof(ICMPixelFormatInfo) before calling ICMGetPixelFormatInfo 
; 
;  *  ICMGetPixelFormatInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ICMGetPixelFormatInfo" 
   ((PixelFormat :OSType)
    (theInfo (:pointer :ICMPixelFormatInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  IMPORTANT: Fill in theInfo->size with sizeof(ICMPixelFormatInfo) before calling ICMSetPixelFormatInfo 
; 
;  *  ICMSetPixelFormatInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ICMSetPixelFormatInfo" 
   ((PixelFormat :OSType)
    (theInfo (:pointer :ICMPixelFormatInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

(defconstant $kICMGetChainUltimateParent 0)
(defconstant $kICMGetChainParent 1)
(defconstant $kICMGetChainChild 2)
(defconstant $kICMGetChainUltimateChild 3)
; 
;  *  ICMSequenceGetChainMember()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ICMSequenceGetChainMember" 
   ((seqID :signed-long)
    (retSeqID (:pointer :IMAGESEQUENCE))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDSequenceTimeCode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetDSequenceTimeCode" 
   ((seqID :signed-long)
    (timeCodeFormat :pointer)
    (timeCodeTime :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceNewMemory()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceNewMemory" 
   ((seqID :signed-long)
    (data (:pointer :Ptr))
    (dataSize :signed-long)
    (dataUse :signed-long)
    (memoryGoneProc (:pointer :OpaqueICMMemoryDisposedProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceDisposeMemory()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceDisposeMemory" 
   ((seqID :signed-long)
    (data :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceNewDataSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceNewDataSource" 
   ((seqID :signed-long)
    (sourceID (:pointer :IMAGESEQUENCEDATASOURCE))
    (sourceType :OSType)
    (sourceInputNumber :signed-long)
    (dataDescription :Handle)
    (transferProc (:pointer :OpaqueICMConvertDataFormatProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceDisposeDataSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceDisposeDataSource" 
   ((sourceID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceSetSourceData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceSetSourceData" 
   ((sourceID :signed-long)
    (data :pointer)
    (dataSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceChangedSourceData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceChangedSourceData" 
   ((sourceID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceSetSourceDataQueue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceSetSourceDataQueue" 
   ((sourceID :signed-long)
    (dataQueue (:pointer :QHdr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceGetDataSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceGetDataSource" 
   ((seqID :signed-long)
    (sourceID (:pointer :IMAGESEQUENCEDATASOURCE))
    (sourceType :OSType)
    (sourceInputNumber :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PtInDSequenceData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PtInDSequenceData" 
   ((seqID :signed-long)
    (data :pointer)
    (dataSize :signed-long)
    (where :Point)
    (hit (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HitTestDSequenceData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_HitTestDSequenceData" 
   ((seqID :signed-long)
    (data :pointer)
    (dataSize :signed-long)
    (where :Point)
    (hit (:pointer :long))
    (hitFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetGraphicsImporterForFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetGraphicsImporterForFile" 
   ((theFile (:pointer :FSSpec))
    (gi (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetGraphicsImporterForDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetGraphicsImporterForDataRef" 
   ((dataRef :Handle)
    (dataRefType :OSType)
    (gi (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

(defconstant $kDontUseValidateToFindGraphicsImporter 1)
; 
;  *  GetGraphicsImporterForFileWithFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetGraphicsImporterForFileWithFlags" 
   ((theFile (:pointer :FSSpec))
    (gi (:pointer :ComponentInstance))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetGraphicsImporterForDataRefWithFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetGraphicsImporterForDataRefWithFlags" 
   ((dataRef :Handle)
    (dataRefType :OSType)
    (gi (:pointer :ComponentInstance))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTGetFileNameExtension()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTGetFileNameExtension" 
   ((fileName (:pointer :UInt8))
    (fileType :OSType)
    (extension (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ImageTranscodeSequenceBegin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageTranscodeSequenceBegin" 
   ((its (:pointer :IMAGETRANSCODESEQUENCE))
    (srcDesc (:Handle :ImageDescription))
    (destType :OSType)
    (dstDesc (:pointer :IMAGEDESCRIPTIONHANDLE))
    (data :pointer)
    (dataSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ImageTranscodeSequenceEnd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageTranscodeSequenceEnd" 
   ((its :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ImageTranscodeFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageTranscodeFrame" 
   ((its :signed-long)
    (srcData :pointer)
    (srcDataSize :signed-long)
    (dstData :pointer)
    (dstDataSize (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ImageTranscodeDisposeFrameData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageTranscodeDisposeFrameData" 
   ((its :signed-long)
    (dstData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceInvalidate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceInvalidate" 
   ((seqID :signed-long)
    (invalRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CDSequenceSetTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CDSequenceSetTimeBase" 
   ((seqID :signed-long)
    (base :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ImageFieldSequenceBegin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageFieldSequenceBegin" 
   ((ifs (:pointer :IMAGEFIELDSEQUENCE))
    (desc1 (:Handle :ImageDescription))
    (desc2 (:Handle :ImageDescription))
    (descOut (:Handle :ImageDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ImageFieldSequenceExtractCombine()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageFieldSequenceExtractCombine" 
   ((ifs :signed-long)
    (fieldFlags :signed-long)
    (data1 :pointer)
    (dataSize1 :signed-long)
    (data2 :pointer)
    (dataSize2 :signed-long)
    (outputData :pointer)
    (outDataSize (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ImageFieldSequenceEnd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageFieldSequenceEnd" 
   ((ifs :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

(defconstant $kICMTempThenAppMemory #x1000)
(defconstant $kICMAppThenTempMemory #x2000)
; 
;  *  QTNewGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTNewGWorld" 
   ((offscreenGWorld (:pointer :GWORLDPTR))
    (PixelFormat :OSType)
    (boundsRect (:pointer :Rect))
    (cTable (:Handle :ColorTable))
    (aGDevice (:Handle :GDEVICE))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTNewGWorldFromPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_QTNewGWorldFromPtr" 
   ((gw (:pointer :GWORLDPTR))
    (pixelFormat :OSType)
    (boundsRect (:pointer :Rect))
    (cTable (:Handle :ColorTable))
    (aGDevice (:Handle :GDEVICE))
    (flags :UInt32)
    (baseAddr :pointer)
    (rowBytes :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTUpdateGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTUpdateGWorld" 
   ((offscreenGWorld (:pointer :GWORLDPTR))
    (PixelFormat :OSType)
    (boundsRect (:pointer :Rect))
    (cTable (:Handle :ColorTable))
    (aGDevice (:Handle :GDEVICE))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  MakeImageDescriptionForPixMap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MakeImageDescriptionForPixMap" 
   ((pixmap (:Handle :PixMap))
    (idh (:pointer :IMAGEDESCRIPTIONHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  MakeImageDescriptionForEffect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MakeImageDescriptionForEffect" 
   ((effectType :OSType)
    (idh (:pointer :IMAGEDESCRIPTIONHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTGetPixelSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTGetPixelSize" 
   ((PixelFormat :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  QTGetPixelFormatDepthForImageDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTGetPixelFormatDepthForImageDescription" 
   ((PixelFormat :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :SInt16
() )
; 
;  *  QTGetPixMapPtrRowBytes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_QTGetPixMapPtrRowBytes" 
   ((pm (:pointer :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  QTGetPixMapHandleRowBytes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_QTGetPixMapHandleRowBytes" 
   ((pm (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  QTSetPixMapPtrRowBytes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_QTSetPixMapPtrRowBytes" 
   ((pm (:pointer :PixMap))
    (rowBytes :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSetPixMapHandleRowBytes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_QTSetPixMapHandleRowBytes" 
   ((pm (:Handle :PixMap))
    (rowBytes :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

(defconstant $kQTUsePlatformDefaultGammaLevel 0);  When decompressing into this PixMap, gamma-correct to the platform's standard gamma. 

(defconstant $kQTUseSourceGammaLevel -1)        ;  When decompressing into this PixMap, don't perform gamma-correction. 

(defconstant $kQTCCIR601VideoGammaLevel #x23333);  2.2, standard television video gamma.

; 
;  *  QTGetPixMapPtrGammaLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_QTGetPixMapPtrGammaLevel" 
   ((pm (:pointer :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTSetPixMapPtrGammaLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_QTSetPixMapPtrGammaLevel" 
   ((pm (:pointer :PixMap))
    (gammaLevel :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTGetPixMapHandleGammaLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_QTGetPixMapHandleGammaLevel" 
   ((pm (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTSetPixMapHandleGammaLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_QTSetPixMapHandleGammaLevel" 
   ((pm (:Handle :PixMap))
    (gammaLevel :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTGetPixMapPtrRequestedGammaLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_QTGetPixMapPtrRequestedGammaLevel" 
   ((pm (:pointer :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTSetPixMapPtrRequestedGammaLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_QTSetPixMapPtrRequestedGammaLevel" 
   ((pm (:pointer :PixMap))
    (requestedGammaLevel :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTGetPixMapHandleRequestedGammaLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_QTGetPixMapHandleRequestedGammaLevel" 
   ((pm (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTSetPixMapHandleRequestedGammaLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_QTSetPixMapHandleRequestedGammaLevel" 
   ((pm (:Handle :PixMap))
    (requestedGammaLevel :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QuadToQuadMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_QuadToQuadMatrix" 
   ((source (:pointer :Fixed))
    (dest (:pointer :Fixed))
    (map (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

(defconstant $identityMatrixType 0)             ;  result if matrix is identity 

(defconstant $translateMatrixType 1)            ;  result if matrix translates 

(defconstant $scaleMatrixType 2)                ;  result if matrix scales 

(defconstant $scaleTranslateMatrixType 3)       ;  result if matrix scales and translates 

(defconstant $linearMatrixType 4)               ;  result if matrix is general 2 x 2 

(defconstant $linearTranslateMatrixType 5)      ;  result if matrix is general 2 x 2 and translates 

(defconstant $perspectiveMatrixType 6)          ;  result if matrix is general 3 x 3 


(def-mactype :MatrixFlags (find-mactype ':UInt16))
; 
;  *  GetMatrixType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMatrixType" 
   ((m (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  CopyMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CopyMatrix" 
   ((m1 (:pointer :MatrixRecord))
    (m2 (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  EqualMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_EqualMatrix" 
   ((m1 (:pointer :MatrixRecord))
    (m2 (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SetIdentityMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetIdentityMatrix" 
   ((matrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TranslateMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TranslateMatrix" 
   ((m (:pointer :MatrixRecord))
    (deltaH :signed-long)
    (deltaV :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RotateMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_RotateMatrix" 
   ((m (:pointer :MatrixRecord))
    (degrees :signed-long)
    (aboutX :signed-long)
    (aboutY :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ScaleMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ScaleMatrix" 
   ((m (:pointer :MatrixRecord))
    (scaleX :signed-long)
    (scaleY :signed-long)
    (aboutX :signed-long)
    (aboutY :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SkewMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SkewMatrix" 
   ((m (:pointer :MatrixRecord))
    (skewX :signed-long)
    (skewY :signed-long)
    (aboutX :signed-long)
    (aboutY :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TransformFixedPoints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TransformFixedPoints" 
   ((m (:pointer :MatrixRecord))
    (fpt (:pointer :FixedPoint))
    (count :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  TransformPoints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TransformPoints" 
   ((mp (:pointer :MatrixRecord))
    (pt1 (:pointer :Point))
    (count :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  TransformFixedRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TransformFixedRect" 
   ((m (:pointer :MatrixRecord))
    (fr (:pointer :FixedRect))
    (fpp (:pointer :FixedPoint))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  TransformRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TransformRect" 
   ((m (:pointer :MatrixRecord))
    (r (:pointer :Rect))
    (fpp (:pointer :FixedPoint))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InverseMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_InverseMatrix" 
   ((m (:pointer :MatrixRecord))
    (im (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  ConcatMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ConcatMatrix" 
   ((a (:pointer :MatrixRecord))
    (b (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RectMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_RectMatrix" 
   ((matrix (:pointer :MatrixRecord))
    (srcRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MapMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MapMatrix" 
   ((matrix (:pointer :MatrixRecord))
    (fromRect (:pointer :Rect))
    (toRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CompAdd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompAdd" 
   ((src (:pointer :wide))
    (dst (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CompSub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompSub" 
   ((src (:pointer :wide))
    (dst (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CompNeg()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompNeg" 
   ((dst (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CompShift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompShift" 
   ((src (:pointer :wide))
    (shift :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CompMul()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompMul" 
   ((src1 :signed-long)
    (src2 :signed-long)
    (dst (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CompDiv()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompDiv" 
   ((numerator (:pointer :wide))
    (denominator :signed-long)
    (remainder (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  CompFixMul()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompFixMul" 
   ((compSrc (:pointer :wide))
    (fixSrc :signed-long)
    (compDst (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CompMulDiv()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompMulDiv" 
   ((co (:pointer :wide))
    (mul :signed-long)
    (divisor :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CompMulDivTrunc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompMulDivTrunc" 
   ((co (:pointer :wide))
    (mul :signed-long)
    (divisor :signed-long)
    (remainder (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CompCompare()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompCompare" 
   ((a (:pointer :wide))
    (minusb (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  CompSquareRoot()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CompSquareRoot" 
   ((src (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  FixMulDiv()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_FixMulDiv" 
   ((src :signed-long)
    (mul :signed-long)
    (divisor :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  UnsignedFixMulDiv()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_UnsignedFixMulDiv" 
   ((src :signed-long)
    (mul :signed-long)
    (divisor :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FracSinCos()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_FracSinCos" 
   ((degree :signed-long)
    (cosOut (:pointer :Fract))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FixExp2()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_FixExp2" 
   ((src :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FixLog2()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_FixLog2" 
   ((src :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FixPow()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_FixPow" 
   ((base :signed-long)
    (exp :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(def-mactype :GraphicsImportComponent (find-mactype ':ComponentInstance))

(defconstant $GraphicsImporterComponentType :|grip|)
;  Component flags for Graphics Importer components 

(defconstant $graphicsImporterIsBaseImporter 1)
(defconstant $graphicsImporterCanValidateFile #x200)
(defconstant $graphicsImporterSubTypeIsFileExtension #x1000)
(defconstant $graphicsImporterHasMIMEList #x4000)
(defconstant $graphicsImporterUsesImageDecompressor #x800000)
;  Atom types for QuickTime Image files 

(defconstant $quickTimeImageFileImageDescriptionAtom :|idsc|)
(defconstant $quickTimeImageFileImageDataAtom :|idat|)
(defconstant $quickTimeImageFileMetaDataAtom :|meta|)
(defconstant $quickTimeImageFileColorSyncProfileAtom :|iicc|)
;  Flags for GraphicsImportDoesDrawAllPixels 

(defconstant $graphicsImporterDrawsAllPixels 0)
(defconstant $graphicsImporterDoesntDrawAllPixels 1)
(defconstant $graphicsImporterDontKnowIfDrawAllPixels 2)
;  Flags for GraphicsImportSetFlags 

(defconstant $kGraphicsImporterDontDoGammaCorrection 1)
(defconstant $kGraphicsImporterTrustResolutionFromFile 2)
(defconstant $kGraphicsImporterEnableSubPixelPositioning 4);  set this flag (*before* calling GraphicsImportGetColorSyncProfile) if you do matching yourself 

(defconstant $kGraphicsImporterDontUseColorMatching 8)
;  Flags for GraphicsImportCreateCGImage 

(defconstant $kGraphicsImportCreateCGImageUsingCurrentSettings 1)

(defconstant $kGraphicsExportGroup :|expo|)
(defconstant $kGraphicsExportFileType :|ftyp|)
(defconstant $kGraphicsExportMIMEType :|mime|)
(defconstant $kGraphicsExportExtension :|ext |)
(defconstant $kGraphicsExportDescription :|desc|)
;  User data types for layers of Photoshop files 

(defconstant $kQTPhotoshopLayerMode :|lmod|)    ;  OSType 

(defconstant $kQTPhotoshopLayerOpacity :|lopa|) ;  UInt8, 0 = transparent .. 255 = opaque 

(defconstant $kQTPhotoshopLayerClipping :|lclp|);  UInt8, 0 = base, 1 = non-base 

(defconstant $kQTPhotoshopLayerFlags :|lflg|)   ;  UInt8 
; '©lnm' 

(defconstant $kQTPhotoshopLayerName #xA96C6E6D) ;  Text 

(defconstant $kQTPhotoshopLayerUnicodeName :|luni|);  Unicode characters, not terminated 

;  User data returned by graphics importers to suggest intended use for indexed images 

(defconstant $kQTIndexedImageType :|nth?|)      ;  1 or more OSTypes, such as the following values: 

(defconstant $kQTIndexedImageIsThumbnail :|n=th|);  The image at this index is a thumbnail. 

(defconstant $kQTIndexedImageIsLayer :|n=ly|)   ;  The image at this index is a layer. 

(defconstant $kQTIndexedImageIsPage :|n=pg|)    ;  The image at this index is a page. 

(defconstant $kQTIndexedImageIsMultiResolution :|n=rs|);  The image at this index is one of several identical images at different resolutions. 

;  Other user data types returned by graphics importers 

(defconstant $kQTTIFFUserDataPrefix #x74690000) ;  Added to some tag values in TIFF IFDs to generate user data codes.  (0x7469 is 'ti'.) 
;  For example, YCbCrPositioning is tag 0x0213, so its user data code is 0x74690213. 

(defconstant $kQTTIFFExifUserDataPrefix #x65780000);  Added to tag values in Exif IFDs to generate user data codes.  (0x6578 is 'ex'.) 
;  For example, DateTimeOriginal is tag 0x9003, so its user data code is 0x65789003. 

(defconstant $kQTTIFFExifGPSUserDataPrefix #x67700000);  Added to tag values in Exif GPS IFDs to generate user data codes.  (0x6770 is 'gp'.) 
;  For example, GPSAltitude is tag 0x0006, so its user data code is 0x6770006. 

(defconstant $kQTAlphaMode :|almo|)             ;  UInt32; eg, graphicsModeStraightAlpha or graphicsModePreBlackAlpha 

(defconstant $kQTAlphaModePreMulColor :|almp|)  ;  RGBColor; used if kQTAlphaMode is graphicsModePreMulColorAlpha 

(defconstant $kUserDataIPTC :|iptc|)
;  Found in TIFF and Exif JPEG files 

(defconstant $kQTTIFFUserDataOrientation #x74690112);  1 SHORT 

(defconstant $kQTTIFFUserDataTransferFunction #x7469012D);  n SHORTs 

(defconstant $kQTTIFFUserDataWhitePoint #x7469013E);  2 RATIONALs 

(defconstant $kQTTIFFUserDataPrimaryChromaticities #x7469013F);  6 RATIONALs 

(defconstant $kQTTIFFUserDataTransferRange #x74690156);  6 SHORTs 

(defconstant $kQTTIFFUserDataYCbCrPositioning #x74690213);  1 SHORT 

(defconstant $kQTTIFFUserDataReferenceBlackWhite #x74690214);  n LONGs 

;  Found in GeoTIFF files; defined in the GeoTIFF 1.0 spec 

(defconstant $kQTTIFFUserDataModelPixelScale #x7469830E);  3 DOUBLEs 

(defconstant $kQTTIFFUserDataModelTransformation #x746985D8);  16 DOUBLEs 

(defconstant $kQTTIFFUserDataModelTiepoint #x74698482);  n DOUBLEs 

(defconstant $kQTTIFFUserDataGeoKeyDirectory #x746987AF);  n SHORTs 

(defconstant $kQTTIFFUserDataGeoDoubleParams #x746987B0);  n DOUBLEs 

(defconstant $kQTTIFFUserDataGeoAsciiParams #x746987B1);  n ASCIIs 

(defconstant $kQTTIFFUserDataIntergraphMatrix #x74698480);  16 or 17 DOUBLEs 

;  Found in Exif TIFF and Exif JPEG files; defined in the Exif 2.1 spec 

(defconstant $kQTExifUserDataExifVersion #x65789000);  4 bytes (import only) 

(defconstant $kQTExifUserDataFlashPixVersion #x6578A000);  4 bytes 

(defconstant $kQTExifUserDataColorSpace #x6578A001);  1 SHORT 

(defconstant $kQTExifUserDataComponentsConfiguration #x65789101);  4 bytes 

(defconstant $kQTExifUserDataCompressedBitsPerPixel #x65789102);  1 RATIONAL 

(defconstant $kQTExifUserDataPixelXDimension #x6578A002);  1 SHORT or LONG 

(defconstant $kQTExifUserDataPixelYDimension #x6578A003);  1 SHORT or LONG 

(defconstant $kQTExifUserDataMakerNote #x6578927C);  n bytes 

(defconstant $kQTExifUserDataUserComment #x6578928C);  n bytes 

(defconstant $kQTExifUserDataRelatedSoundFile #x6578A004);  13 ASCIIs

(defconstant $kQTExifUserDataDateTimeOriginal #x65789003);  20 ASCIIs 

(defconstant $kQTExifUserDataDateTimeDigitized #x65789004);  20 ASCIIs 

(defconstant $kQTExifUserDataSubSecTime #x65789290);  n ASCIIs 

(defconstant $kQTExifUserDataSubSecTimeOriginal #x65789291);  n ASCIIs 

(defconstant $kQTExifUserDataSubSecTimeDigitized #x65789292);  n ASCIIs 

(defconstant $kQTExifUserDataExposureTime #x6578829A);  1 RATIONAL 

(defconstant $kQTExifUserDataFNumber #x6578829D);  1 RATIONAL 

(defconstant $kQTExifUserDataExposureProgram #x65788822);  1 SHORT 

(defconstant $kQTExifUserDataSpectralSensitivity #x65788824);  n ASCIIs 

(defconstant $kQTExifUserDataISOSpeedRatings #x65788827);  n SHORTs 

(defconstant $kQTExifUserDataShutterSpeedValue #x65789201);  1 SIGNED RATIONAL 

(defconstant $kQTExifUserDataApertureValue #x65789202);  1 RATIONAL 

(defconstant $kQTExifUserDataBrightnessValue #x65789203);  1 SIGNED RATIONAL 

(defconstant $kQTExifUserDataExposureBiasValue #x65789204);  1 SIGNED RATIONAL 

(defconstant $kQTExifUserDataMaxApertureValue #x65789205);  1 RATIONAL 

(defconstant $kQTExifUserDataSubjectDistance #x65789206);  1 RATIONAL 

(defconstant $kQTExifUserDataMeteringMode #x65789207);  1 SHORT 

(defconstant $kQTExifUserDataLightSource #x65789208);  1 SHORT 

(defconstant $kQTExifUserDataFlash #x65789209)  ;  1 SHORT 

(defconstant $kQTExifUserDataFocalLength #x6578920A);  1 RATIONAL 

(defconstant $kQTExifUserDataFlashEnergy #x6578A20B);  1 RATIONAL 

(defconstant $kQTExifUserDataFocalPlaneXResolution #x6578A20E);  1 RATIONAL 

(defconstant $kQTExifUserDataFocalPlaneYResolution #x6578A20F);  1 RATIONAL 

(defconstant $kQTExifUserDataFocalPlaneResolutionUnit #x6578A210);  1 SHORT 

(defconstant $kQTExifUserDataSubjectLocation #x6578A214);  1 SHORT 

(defconstant $kQTExifUserDataExposureIndex #x6578A215);  1 RATIONAL 

(defconstant $kQTExifUserDataSensingMethod #x6578A217);  1 SHORT 

(defconstant $kQTExifUserDataFileSource #x6578A300);  1 UNDEFINED 

(defconstant $kQTExifUserDataSceneType #x6578A301);  1 UNDEFINED 

;  Found in some Exif TIFF and Exif JPEG files; defined in the Exif 2.1 spec 
;  Note: these were wrong in the QuickTime 6.0 headers -- the high two bytes were 0x677 instead of 0x6770. 

(defconstant $kQTExifUserDataGPSVersionID #x67700000);  4 BYTEs 

(defconstant $kQTExifUserDataGPSLatitudeRef #x67700001);  2 ASCIIs

(defconstant $kQTExifUserDataGPSLatitude #x67700002);  3 RATIONALs 

(defconstant $kQTExifUserDataGPSLongitudeRef #x67700003);  2 ASCIIs 

(defconstant $kQTExifUserDataGPSLongitude #x67700004);  3 RATIONALs 

(defconstant $kQTExifUserDataGPSAltitudeRef #x67700005);  1 BYTE 

(defconstant $kQTExifUserDataGPSAltitude #x67700006);  1 RATIONAL 

(defconstant $kQTExifUserDataGPSTimeStamp #x67700007);  3 RATIONALs 

(defconstant $kQTExifUserDataGPSSatellites #x67700008);  n ASCIIs 

(defconstant $kQTExifUserDataGPSStatus #x67700009);  2 ASCIIs 

(defconstant $kQTExifUserDataGPSMeasureMode #x6770000A);  2 ASCIIs 

(defconstant $kQTExifUserDataGPSDOP #x6770000B) ;  1 RATIONAL 

(defconstant $kQTExifUserDataGPSSpeedRef #x6770000C);  2 ASCIIs 

(defconstant $kQTExifUserDataGPSSpeed #x6770000D);  1 RATIONAL 

(defconstant $kQTExifUserDataGPSTrackRef #x6770000E);  2 ASCIIs 

(defconstant $kQTExifUserDataGPSTrack #x6770000F);  1 RATIONAL 

(defconstant $kQTExifUserDataGPSImgDirectionRef #x67700010);  2 ASCIIs 

(defconstant $kQTExifUserDataGPSImgDirection #x67700011);  1 RATIONAL 

(defconstant $kQTExifUserDataGPSMapDatum #x67700012);  n ASCII 

(defconstant $kQTExifUserDataGPSDestLatitudeRef #x67700013);  2 ASCIIs 

(defconstant $kQTExifUserDataGPSDestLatitude #x67700014);  3 RATIONALs 

(defconstant $kQTExifUserDataGPSDestLongitudeRef #x67700015);  2 ASCIIs 

(defconstant $kQTExifUserDataGPSDestLongitude #x67700016);  3 RATIONALs 

(defconstant $kQTExifUserDataGPSDestBearingRef #x67700017);  2 ASCIIs 

(defconstant $kQTExifUserDataGPSDestBearing #x67700018);  1 RATIONAL 

(defconstant $kQTExifUserDataGPSDestDistanceRef #x67700019);  2 ASCIIs 

(defconstant $kQTExifUserDataGPSDestDistance #x6770001A);  1 RATIONAL 

; * These are GraphicsImport procedures *
; 
;  *  GraphicsImportSetDataReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSetDataReference" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataReType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetDataReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetDataReference" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef (:pointer :Handle))
    (dataReType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetDataFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSetDataFile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetDataFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetDataFile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetDataHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSetDataHandle" 
   ((ci (:pointer :ComponentInstanceRecord))
    (h :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetDataHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetDataHandle" 
   ((ci (:pointer :ComponentInstanceRecord))
    (h (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetImageDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetImageDescription" 
   ((ci (:pointer :ComponentInstanceRecord))
    (desc (:pointer :IMAGEDESCRIPTIONHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetDataOffsetAndSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetDataOffsetAndSize" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offset (:pointer :UInt32))
    (size (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportReadData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportReadData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataPtr :pointer)
    (dataOffset :UInt32)
    (dataSize :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetClip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSetClip" 
   ((ci (:pointer :ComponentInstanceRecord))
    (clipRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetClip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetClip" 
   ((ci (:pointer :ComponentInstanceRecord))
    (clipRgn (:pointer :RGNHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetSourceRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSetSourceRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (sourceRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetSourceRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetSourceRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (sourceRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetNaturalBounds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetNaturalBounds" 
   ((ci (:pointer :ComponentInstanceRecord))
    (naturalBounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportDraw()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportDraw" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSetGWorld" 
   ((ci (:pointer :ComponentInstanceRecord))
    (port (:pointer :OpaqueGrafPtr))
    (gd (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetGWorld" 
   ((ci (:pointer :ComponentInstanceRecord))
    (port (:pointer :CGrafPtr))
    (gd (:pointer :GDHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSetMatrix" 
   ((ci (:pointer :ComponentInstanceRecord))
    (matrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetMatrix" 
   ((ci (:pointer :ComponentInstanceRecord))
    (matrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetBoundsRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSetBoundsRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetBoundsRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetBoundsRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSaveAsPicture()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSaveAsPicture" 
   ((ci (:pointer :ComponentInstanceRecord))
    (fss (:pointer :FSSpec))
    (scriptTag :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetGraphicsMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSetGraphicsMode" 
   ((ci (:pointer :ComponentInstanceRecord))
    (graphicsMode :signed-long)
    (opColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetGraphicsMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetGraphicsMode" 
   ((ci (:pointer :ComponentInstanceRecord))
    (graphicsMode (:pointer :long))
    (opColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetQuality()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSetQuality" 
   ((ci (:pointer :ComponentInstanceRecord))
    (quality :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetQuality()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetQuality" 
   ((ci (:pointer :ComponentInstanceRecord))
    (quality (:pointer :CODECQ))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSaveAsQuickTimeImageFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSaveAsQuickTimeImageFile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (fss (:pointer :FSSpec))
    (scriptTag :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetDataReferenceOffsetAndLimit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSetDataReferenceOffsetAndLimit" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offset :UInt32)
    (limit :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetDataReferenceOffsetAndLimit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetDataReferenceOffsetAndLimit" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offset (:pointer :UInt32))
    (limit (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetAliasedDataReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetAliasedDataReference" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef (:pointer :Handle))
    (dataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportValidate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportValidate" 
   ((ci (:pointer :ComponentInstanceRecord))
    (valid (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetMetaData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetMetaData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (userData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetMIMETypeList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetMIMETypeList" 
   ((ci (:pointer :ComponentInstanceRecord))
    (qtAtomContainerPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportDoesDrawAllPixels()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportDoesDrawAllPixels" 
   ((ci (:pointer :ComponentInstanceRecord))
    (drawsAllPixels (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetAsPicture()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetAsPicture" 
   ((ci (:pointer :ComponentInstanceRecord))
    (picture (:pointer :PICHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportExportImageFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportExportImageFile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (fileType :OSType)
    (fileCreator :OSType)
    (fss (:pointer :FSSpec))
    (scriptTag :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetExportImageTypeList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetExportImageTypeList" 
   ((ci (:pointer :ComponentInstanceRecord))
    (qtAtomContainerPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportDoExportImageFileDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportDoExportImageFileDialog" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inDefaultSpec (:pointer :FSSpec))
    (prompt (:pointer :UInt8))
    (filterProc (:pointer :OpaqueModalFilterYDProcPtr))
    (outExportedType (:pointer :OSType))
    (outExportedSpec (:pointer :FSSpec))
    (outScriptTag (:pointer :SCRIPTCODE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetExportSettingsAsAtomContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetExportSettingsAsAtomContainer" 
   ((ci (:pointer :ComponentInstanceRecord))
    (qtAtomContainerPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetExportSettingsFromAtomContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSetExportSettingsFromAtomContainer" 
   ((ci (:pointer :ComponentInstanceRecord))
    (qtAtomContainer :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetProgressProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportSetProgressProc" 
   ((ci (:pointer :ComponentInstanceRecord))
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetProgressProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImportGetProgressProc" 
   ((ci (:pointer :ComponentInstanceRecord))
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetImageCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportGetImageCount" 
   ((ci (:pointer :ComponentInstanceRecord))
    (imageCount (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetImageIndex()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportSetImageIndex" 
   ((ci (:pointer :ComponentInstanceRecord))
    (imageIndex :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetImageIndex()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportGetImageIndex" 
   ((ci (:pointer :ComponentInstanceRecord))
    (imageIndex (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetDataOffsetAndSize64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportGetDataOffsetAndSize64" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offset (:pointer :wide))
    (size (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportReadData64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportReadData64" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataPtr :pointer)
    (dataOffset (:pointer :wide))
    (dataSize :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetDataReferenceOffsetAndLimit64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportSetDataReferenceOffsetAndLimit64" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offset (:pointer :wide))
    (limit (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetDataReferenceOffsetAndLimit64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportGetDataReferenceOffsetAndLimit64" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offset (:pointer :wide))
    (limit (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetDefaultMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportGetDefaultMatrix" 
   ((ci (:pointer :ComponentInstanceRecord))
    (defaultMatrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetDefaultClip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportGetDefaultClip" 
   ((ci (:pointer :ComponentInstanceRecord))
    (defaultRgn (:pointer :RGNHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetDefaultGraphicsMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportGetDefaultGraphicsMode" 
   ((ci (:pointer :ComponentInstanceRecord))
    (defaultGraphicsMode (:pointer :long))
    (defaultOpColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetDefaultSourceRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportGetDefaultSourceRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (defaultSourceRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetColorSyncProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportGetColorSyncProfile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (profile (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetDestRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportSetDestRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (destRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetDestRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportGetDestRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (destRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportSetFlags" 
   ((ci (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsImportGetFlags" 
   ((ci (:pointer :ComponentInstanceRecord))
    (flags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  2 private selectors 
; 
;  *  GraphicsImportGetBaseDataOffsetAndSize64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0.2 and later
;  *    Windows:          in qtmlClient.lib 5.0.2 and later
;  

(deftrap-inline "_GraphicsImportGetBaseDataOffsetAndSize64" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offset (:pointer :wide))
    (size (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSetImageIndexToThumbnail()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_GraphicsImportSetImageIndexToThumbnail" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )

; #if TARGET_API_MAC_OSX
; 
;  *  GraphicsImportCreateCGImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GraphicsImportCreateCGImage" 
   ((ci (:pointer :ComponentInstanceRecord))
    (imageRefOut (:pointer :CGIMAGEREF))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )

; #endif  /* TARGET_API_MAC_OSX */

; 
;  *  GraphicsImportSaveAsPictureToDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_GraphicsImportSaveAsPictureToDataRef" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportSaveAsQuickTimeImageFileToDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_GraphicsImportSaveAsQuickTimeImageFileToDataRef" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportExportImageFileToDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_GraphicsImportExportImageFileToDataRef" 
   ((ci (:pointer :ComponentInstanceRecord))
    (fileType :OSType)
    (fileCreator :OSType)
    (dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportDoExportImageFileToDataRefDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_GraphicsImportDoExportImageFileToDataRefDialog" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inDataRef :Handle)
    (inDataRefType :OSType)
    (prompt (:pointer :__CFString))
    (filterProc (:pointer :OpaqueModalFilterYDProcPtr))
    (outExportedType (:pointer :OSType))
    (outDataRef (:pointer :Handle))
    (outDataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )

; #if TARGET_API_MAC_OSX
;  NOTE: If the source override ColorSync profile is NULL, then the image's ColorSync profile may be used if available, otherwise a generic ColorSync profile may be used. 
; 
;  *  GraphicsImportSetOverrideSourceColorSyncProfileRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GraphicsImportSetOverrideSourceColorSyncProfileRef" 
   ((ci (:pointer :ComponentInstanceRecord))
    (newOverrideSourceProfileRef (:pointer :OpaqueCMProfileRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetOverrideSourceColorSyncProfileRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GraphicsImportGetOverrideSourceColorSyncProfileRef" 
   ((ci (:pointer :ComponentInstanceRecord))
    (outOverrideSourceProfileRef (:pointer :CMPROFILEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
;  NOTE: If the destination ColorSync profile is NULL, then a generic ColorSync profile may be used. 
; 
;  *  GraphicsImportSetDestinationColorSyncProfileRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GraphicsImportSetDestinationColorSyncProfileRef" 
   ((ci (:pointer :ComponentInstanceRecord))
    (newDestinationProfileRef (:pointer :OpaqueCMProfileRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImportGetDestinationColorSyncProfileRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GraphicsImportGetDestinationColorSyncProfileRef" 
   ((ci (:pointer :ComponentInstanceRecord))
    (destinationProfileRef (:pointer :CMPROFILEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )

; #endif  /* TARGET_API_MAC_OSX */

; 
;  *  GraphicsImportWillUseColorMatching()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_GraphicsImportWillUseColorMatching" 
   ((ci (:pointer :ComponentInstanceRecord))
    (outWillMatch (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )

; #if TARGET_API_MAC_OSX
;  This convenience API is implemented by the base graphics importer for format-specific importers. 
; 
;  *  GraphicsImportGetGenericColorSyncProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GraphicsImportGetGenericColorSyncProfile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (pixelFormat :OSType)
    (reservedSetToNULL :pointer)
    (flags :UInt32)
    (genericColorSyncProfileOut (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )

; #endif  /* TARGET_API_MAC_OSX */

;  Format-specific importers that implement GetColorSyncProfile and that want the base graphics 
;    importer to automatically support ColorSync matching should:
;    (a) implement GraphicsImportSetReturnGenericColorSyncProfile; when it is called, set an internal flag
;    (b) change GraphicsImportGetColorSyncProfile so that, if this internal flag is set,
;        when the source image file contains a profile 
;        and the kGraphicsImporterDontUseColorMatching flag is NOT set,
;        it returns a generic profile of the appropriate colorspace instead.
;    Other importers should *not* implement GraphicsImportSetReturnGenericColorSyncProfile. 
;  WARNING: Applications should not call this API; it is internal graphics importer plumbing.
;    Set kGraphicsImporterDontUseColorMatching instead. 
; 
;  *  GraphicsImportSetReturnGenericColorSyncProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_GraphicsImportSetReturnGenericColorSyncProfile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (returnGenericProfilesUnlessDontMatchFlagSet :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
;  WARNING: Applications should not call this API; it is internal graphics importer plumbing. 
; 
;  *  GraphicsImportGetReturnGenericColorSyncProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_GraphicsImportGetReturnGenericColorSyncProfile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (returnGenericProfilesUnlessDontMatchFlagSet (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )

(def-mactype :GraphicsExportComponent (find-mactype ':ComponentInstance))

(defconstant $GraphicsExporterComponentType :|grex|)
(defconstant $kBaseGraphicsExporterSubType :|base|)
;  Component flags for Graphics Exporter components 

(defconstant $graphicsExporterIsBaseExporter 1)
(defconstant $graphicsExporterCanTranscode 2)
(defconstant $graphicsExporterUsesImageCompressor 4)
(defrecord QTResolutionSettings
   (horizontalResolution :signed-long)
   (verticalResolution :signed-long)
)

;type name? (%define-record :QTResolutionSettings (find-record-descriptor ':QTResolutionSettings))
(defrecord QTTargetDataSize
   (targetDataSize :UInt32)
)

;type name? (%define-record :QTTargetDataSize (find-record-descriptor ':QTTargetDataSize))
(defrecord QTThumbnailSettings
   (enableThumbnail :signed-long)               ;  a thoroughly padded Boolean
   (maxThumbnailWidth :signed-long)             ;  set to zero to let someone else decide
   (maxThumbnailHeight :signed-long)            ;  set to zero to let someone else decide
)

;type name? (%define-record :QTThumbnailSettings (find-record-descriptor ':QTThumbnailSettings))

(defconstant $kQTResolutionSettings :|reso|)
(defconstant $kQTTargetDataSize :|dasz|)
(defconstant $kQTDontRecompress :|dntr|)
(defconstant $kQTInterlaceStyle :|ilac|)
(defconstant $kQTColorSyncProfile :|iccp|)
(defconstant $kQTThumbnailSettings :|thum|)
(defconstant $kQTEnableExif :|exif|)            ;  UInt8 (boolean)

(defconstant $kQTMetaData :|meta|)

(defconstant $kQTTIFFCompressionMethod :|tifc|) ;  UInt32

(defconstant $kQTTIFFCompression_None 1)
(defconstant $kQTTIFFCompression_PackBits #x8005)
(defconstant $kQTTIFFLittleEndian :|tife|)      ;  UInt8 (boolean)


(defconstant $kQTPNGFilterPreference :|pngf|)   ;  UInt32

(defconstant $kQTPNGFilterBestForColorType :|bflt|)
(defconstant $kQTPNGFilterNone 0)
(defconstant $kQTPNGFilterSub 1)
(defconstant $kQTPNGFilterUp 2)
(defconstant $kQTPNGFilterAverage 3)
(defconstant $kQTPNGFilterPaeth 4)
(defconstant $kQTPNGFilterAdaptivePerRow :|aflt|)
(defconstant $kQTPNGInterlaceStyle :|ilac|)     ;  UInt32

(defconstant $kQTPNGInterlaceNone 0)
(defconstant $kQTPNGInterlaceAdam7 1)

(defconstant $kQTJPEGQuantizationTables :|jpqt|)
(defconstant $kQTJPEGHuffmanTables :|jpht|)
; * These are GraphicsExport procedures *
;  To use: set the input and output (and other settings as desired) and call GEDoExport. 
; 
;  *  GraphicsExportDoExport()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportDoExport" 
   ((ci (:pointer :ComponentInstanceRecord))
    (actualSizeWritten (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Used for internal communication between the base and format-specific graphics exporter: 
; 
;  *  GraphicsExportCanTranscode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportCanTranscode" 
   ((ci (:pointer :ComponentInstanceRecord))
    (canTranscode (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportDoTranscode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportDoTranscode" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportCanUseCompressor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportCanUseCompressor" 
   ((ci (:pointer :ComponentInstanceRecord))
    (canUseCompressor (:pointer :Boolean))
    (codecSettingsAtomContainerPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportDoUseCompressor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportDoUseCompressor" 
   ((ci (:pointer :ComponentInstanceRecord))
    (codecSettingsAtomContainer :pointer)
    (outDesc (:pointer :IMAGEDESCRIPTIONHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportDoStandaloneExport()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportDoStandaloneExport" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Queries applications can make of a format-specific graphics exporter: 
; 
;  *  GraphicsExportGetDefaultFileTypeAndCreator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetDefaultFileTypeAndCreator" 
   ((ci (:pointer :ComponentInstanceRecord))
    (fileType (:pointer :OSType))
    (fileCreator (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetDefaultFileNameExtension()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetDefaultFileNameExtension" 
   ((ci (:pointer :ComponentInstanceRecord))
    (fileNameExtension (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetMIMETypeList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetMIMETypeList" 
   ((ci (:pointer :ComponentInstanceRecord))
    (qtAtomContainerPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  (1 unused selector) 
;  Graphics exporter settings: 
; 
;  *  GraphicsExportRequestSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportRequestSettings" 
   ((ci (:pointer :ComponentInstanceRecord))
    (filterProc (:pointer :OpaqueModalFilterYDProcPtr))
    (yourDataProc :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetSettingsFromAtomContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetSettingsFromAtomContainer" 
   ((ci (:pointer :ComponentInstanceRecord))
    (qtAtomContainer :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetSettingsAsAtomContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetSettingsAsAtomContainer" 
   ((ci (:pointer :ComponentInstanceRecord))
    (qtAtomContainerPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetSettingsAsText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetSettingsAsText" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theText (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Graphics exporters may implement some or none of the following: 
; 
;  *  GraphicsExportSetDontRecompress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetDontRecompress" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dontRecompress :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetDontRecompress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetDontRecompress" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dontRecompress (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetInterlaceStyle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetInterlaceStyle" 
   ((ci (:pointer :ComponentInstanceRecord))
    (interlaceStyle :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInterlaceStyle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInterlaceStyle" 
   ((ci (:pointer :ComponentInstanceRecord))
    (interlaceStyle (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetMetaData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetMetaData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (userData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetMetaData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetMetaData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (userData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetTargetDataSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetTargetDataSize" 
   ((ci (:pointer :ComponentInstanceRecord))
    (targetDataSize :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetTargetDataSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetTargetDataSize" 
   ((ci (:pointer :ComponentInstanceRecord))
    (targetDataSize (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetCompressionMethod()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetCompressionMethod" 
   ((ci (:pointer :ComponentInstanceRecord))
    (compressionMethod :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetCompressionMethod()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetCompressionMethod" 
   ((ci (:pointer :ComponentInstanceRecord))
    (compressionMethod (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetCompressionQuality()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetCompressionQuality" 
   ((ci (:pointer :ComponentInstanceRecord))
    (spatialQuality :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetCompressionQuality()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetCompressionQuality" 
   ((ci (:pointer :ComponentInstanceRecord))
    (spatialQuality (:pointer :CODECQ))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetResolution()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetResolution" 
   ((ci (:pointer :ComponentInstanceRecord))
    (horizontalResolution :signed-long)
    (verticalResolution :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetResolution()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetResolution" 
   ((ci (:pointer :ComponentInstanceRecord))
    (horizontalResolution (:pointer :Fixed))
    (verticalResolution (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetDepth()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetDepth" 
   ((ci (:pointer :ComponentInstanceRecord))
    (depth :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetDepth()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetDepth" 
   ((ci (:pointer :ComponentInstanceRecord))
    (depth (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  (2 unused selectors) 
; 
;  *  GraphicsExportSetColorSyncProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetColorSyncProfile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (colorSyncProfile :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetColorSyncProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetColorSyncProfile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (colorSyncProfile (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Always implemented by the base graphics exporter: 
; 
;  *  GraphicsExportSetProgressProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetProgressProc" 
   ((ci (:pointer :ComponentInstanceRecord))
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetProgressProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetProgressProc" 
   ((ci (:pointer :ComponentInstanceRecord))
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Sources for the input image: 
; 
;  *  GraphicsExportSetInputDataReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetInputDataReference" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
    (desc (:Handle :ImageDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputDataReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInputDataReference" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef (:pointer :Handle))
    (dataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetInputFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetInputFile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theFile (:pointer :FSSpec))
    (desc (:Handle :ImageDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInputFile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetInputHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetInputHandle" 
   ((ci (:pointer :ComponentInstanceRecord))
    (h :Handle)
    (desc (:Handle :ImageDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInputHandle" 
   ((ci (:pointer :ComponentInstanceRecord))
    (h (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetInputPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetInputPtr" 
   ((ci (:pointer :ComponentInstanceRecord))
    (p :pointer)
    (size :UInt32)
    (desc (:Handle :ImageDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInputPtr" 
   ((ci (:pointer :ComponentInstanceRecord))
    (p (:pointer :Ptr))
    (size (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetInputGraphicsImporter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetInputGraphicsImporter" 
   ((ci (:pointer :ComponentInstanceRecord))
    (grip (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputGraphicsImporter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInputGraphicsImporter" 
   ((ci (:pointer :ComponentInstanceRecord))
    (grip (:pointer :GRAPHICSIMPORTCOMPONENT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetInputPicture()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetInputPicture" 
   ((ci (:pointer :ComponentInstanceRecord))
    (picture (:Handle :Picture))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputPicture()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInputPicture" 
   ((ci (:pointer :ComponentInstanceRecord))
    (picture (:pointer :PICHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetInputGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetInputGWorld" 
   ((ci (:pointer :ComponentInstanceRecord))
    (gworld (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInputGWorld" 
   ((ci (:pointer :ComponentInstanceRecord))
    (gworld (:pointer :GWORLDPTR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetInputPixmap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetInputPixmap" 
   ((ci (:pointer :ComponentInstanceRecord))
    (pixmap (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputPixmap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInputPixmap" 
   ((ci (:pointer :ComponentInstanceRecord))
    (pixmap (:pointer :PIXMAPHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Only applicable when the input is a data reference, file, handle or ptr: 
; 
;  *  GraphicsExportSetInputOffsetAndLimit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetInputOffsetAndLimit" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offset :UInt32)
    (limit :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputOffsetAndLimit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInputOffsetAndLimit" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offset (:pointer :UInt32))
    (limit (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Used by format-specific graphics exporters when transcoding: 
; 
;  *  GraphicsExportMayExporterReadInputData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportMayExporterReadInputData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (mayReadInputData (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputDataSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInputDataSize" 
   ((ci (:pointer :ComponentInstanceRecord))
    (size (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportReadInputData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportReadInputData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataPtr :pointer)
    (dataOffset :UInt32)
    (dataSize :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Used by format-specific graphics exporters, especially when doing standalone export: 
; 
;  *  GraphicsExportGetInputImageDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInputImageDescription" 
   ((ci (:pointer :ComponentInstanceRecord))
    (desc (:pointer :IMAGEDESCRIPTIONHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputImageDimensions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInputImageDimensions" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dimensions (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputImageDepth()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetInputImageDepth" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inputDepth (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportDrawInputImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportDrawInputImage" 
   ((ci (:pointer :ComponentInstanceRecord))
    (gw (:pointer :OpaqueGrafPtr))
    (gd (:Handle :GDEVICE))
    (srcRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Destinations for the output image: 
; 
;  *  GraphicsExportSetOutputDataReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetOutputDataReference" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetOutputDataReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetOutputDataReference" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef (:pointer :Handle))
    (dataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetOutputFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetOutputFile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetOutputFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetOutputFile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetOutputHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetOutputHandle" 
   ((ci (:pointer :ComponentInstanceRecord))
    (h :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetOutputHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetOutputHandle" 
   ((ci (:pointer :ComponentInstanceRecord))
    (h (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetOutputOffsetAndMaxSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetOutputOffsetAndMaxSize" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offset :UInt32)
    (maxSize :UInt32)
    (truncateFile :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetOutputOffsetAndMaxSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetOutputOffsetAndMaxSize" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offset (:pointer :UInt32))
    (maxSize (:pointer :UInt32))
    (truncateFile (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetOutputFileTypeAndCreator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetOutputFileTypeAndCreator" 
   ((ci (:pointer :ComponentInstanceRecord))
    (fileType :OSType)
    (fileCreator :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetOutputFileTypeAndCreator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetOutputFileTypeAndCreator" 
   ((ci (:pointer :ComponentInstanceRecord))
    (fileType (:pointer :OSType))
    (fileCreator (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Used by format-specific graphics exporters: 
; 
;  *  GraphicsExportWriteOutputData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportWriteOutputData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataPtr :pointer)
    (dataSize :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetOutputMark()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportSetOutputMark" 
   ((ci (:pointer :ComponentInstanceRecord))
    (mark :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetOutputMark()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportGetOutputMark" 
   ((ci (:pointer :ComponentInstanceRecord))
    (mark (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportReadOutputData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GraphicsExportReadOutputData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataPtr :pointer)
    (dataOffset :UInt32)
    (dataSize :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Allows embedded thumbnail creation, if supported. 
; 
;  *  GraphicsExportSetThumbnailEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0.2 and later
;  *    Windows:          in qtmlClient.lib 5.0.2 and later
;  

(deftrap-inline "_GraphicsExportSetThumbnailEnabled" 
   ((ci (:pointer :ComponentInstanceRecord))
    (enableThumbnail :Boolean)
    (maxThumbnailWidth :signed-long)
    (maxThumbnailHeight :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetThumbnailEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0.2 and later
;  *    Windows:          in qtmlClient.lib 5.0.2 and later
;  

(deftrap-inline "_GraphicsExportGetThumbnailEnabled" 
   ((ci (:pointer :ComponentInstanceRecord))
    (thumbnailEnabled (:pointer :Boolean))
    (maxThumbnailWidth (:pointer :long))
    (maxThumbnailHeight (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
;  Allows export of Exif files, if supported.  This disables Exif-incompatible settings such as grayscale JPEG and compressed TIFF, and enables export of Exif metadata. 
; 
;  *  GraphicsExportSetExifEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0.2 and later
;  *    Windows:          in qtmlClient.lib 5.0.2 and later
;  

(deftrap-inline "_GraphicsExportSetExifEnabled" 
   ((ci (:pointer :ComponentInstanceRecord))
    (enableExif :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetExifEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0.2 and later
;  *    Windows:          in qtmlClient.lib 5.0.2 and later
;  

(deftrap-inline "_GraphicsExportGetExifEnabled" 
   ((ci (:pointer :ComponentInstanceRecord))
    (exifEnabled (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )

; #if TARGET_API_MAC_OSX
; 
;  *  GraphicsExportSetInputCGImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GraphicsExportSetInputCGImage" 
   ((ci (:pointer :ComponentInstanceRecord))
    (imageRef (:pointer :CGImage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputCGImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GraphicsExportGetInputCGImage" 
   ((ci (:pointer :ComponentInstanceRecord))
    (imageRefOut (:pointer :CGIMAGEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportSetInputCGBitmapContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GraphicsExportSetInputCGBitmapContext" 
   ((ci (:pointer :ComponentInstanceRecord))
    (bitmapContextRef (:pointer :CGContext))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetInputCGBitmapContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GraphicsExportGetInputCGBitmapContext" 
   ((ci (:pointer :ComponentInstanceRecord))
    (bitmapContextRefOut (:pointer :CGContextRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )

; #endif  /* TARGET_API_MAC_OSX */

; 
;  *  GraphicsExportSetFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GraphicsExportSetFlags" 
   ((ci (:pointer :ComponentInstanceRecord))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsExportGetFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GraphicsExportGetFlags" 
   ((ci (:pointer :ComponentInstanceRecord))
    (flagsOut (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )

(def-mactype :ImageTranscoderComponent (find-mactype ':ComponentInstance))

(defconstant $ImageTranscodererComponentType :|imtc|)
; * These are ImageTranscoder procedures *
; 
;  *  ImageTranscoderBeginSequence()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageTranscoderBeginSequence" 
   ((itc (:pointer :ComponentInstanceRecord))
    (srcDesc (:Handle :ImageDescription))
    (dstDesc (:pointer :IMAGEDESCRIPTIONHANDLE))
    (data :pointer)
    (dataSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageTranscoderConvert()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageTranscoderConvert" 
   ((itc (:pointer :ComponentInstanceRecord))
    (srcData :pointer)
    (srcDataSize :signed-long)
    (dstData :pointer)
    (dstDataSize (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageTranscoderDisposeData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageTranscoderDisposeData" 
   ((itc (:pointer :ComponentInstanceRecord))
    (dstData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageTranscoderEndSequence()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageTranscoderEndSequence" 
   ((itc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

; #if (MAC_OS_X_VERSION_MAX_ALLOWED == MAC_OS_X_VERSION_10_2) || !defined(kComponentPropertyListenerCollectionContextVersion)
;  MixedMode ProcInfo constants for component property calls 

(defconstant $uppCallComponentGetComponentPropertyInfoProcInfo #x3FFF0)
(defconstant $uppCallComponentGetComponentPropertyProcInfo #x3FFF0)
(defconstant $uppCallComponentSetComponentPropertyProcInfo #xFFF0)
(defconstant $uppCallComponentAddComponentPropertyListenerProcInfo #xFFF0)
(defconstant $uppCallComponentRemoveComponentPropertyListenerProcInfo #xFFF0)
;  == CallComponentGetComponentPropertyInfo flags == 

(defconstant $kComponentPropertyFlagCanSetLater 1)
(defconstant $kComponentPropertyFlagCanSetNow 2)
(defconstant $kComponentPropertyFlagCanGetLater 4)
(defconstant $kComponentPropertyFlagCanGetNow 8)
(defconstant $kComponentPropertyFlagHasExtendedInfo 16)
(defconstant $kComponentPropertyFlagValueMustBeReleased 32)
(defconstant $kComponentPropertyFlagValueIsCFTypeRef 64)
(defconstant $kComponentPropertyFlagGetBufferMustBeInitialized #x80)
(defconstant $kComponentPropertyFlagWillNotifyListeners #x100)

(def-mactype :ComponentPropertyClass (find-mactype ':OSType))

(def-mactype :ComponentPropertyID (find-mactype ':OSType))

(def-mactype :ComponentValueType (find-mactype ':OSType))

(def-mactype :ComponentValuePtr (find-mactype '(:pointer :void)))

(def-mactype :ConstComponentValuePtr (find-mactype '(:pointer :void)))
;  == standard property class constants == 

(defconstant $kComponentPropertyClassPropertyInfo :|pnfo|);  property info class 
;  property info property IDs 

(defconstant $kComponentPropertyInfoList :|list|);  array of ComponentPropertyInfo (CFData), one for each property 

(defconstant $kComponentPropertyCacheSeed :|seed|);  property cache seed value 

(defconstant $kComponentPropertyCacheFlags :|flgs|);  see kComponentPropertyCache flags 

(defconstant $kComponentPropertyExtendedInfo :|meta|);  CFDictionary with extended property information

;  values for kComponentPropertyClassPropertyInfo/kComponentPropertyCacheFlags standard component property 

(defconstant $kComponentPropertyCacheFlagNotPersistent 1);  property metadata should not be saved in persistent cache
;  property metadata should not cached at all

(defconstant $kComponentPropertyCacheFlagIsDynamic 2)
(defrecord ComponentPropertyInfo
   (propClass :OSType)
   (propID :OSType)
   (propType :OSType)
   (propSize :UInt32)
   (propFlags :UInt32)
)

;type name? (%define-record :ComponentPropertyInfo (find-record-descriptor ':ComponentPropertyInfo))

; #endif  /* #MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED */ 

;  == "QT" prefixed Component Property calls == 

(def-mactype :QTComponentPropertyListenerProcPtr (find-mactype ':pointer)); (ComponentInstance inComponent , ComponentPropertyClass inPropClass , ComponentPropertyID inPropID , void * inUserData)

(def-mactype :QTComponentPropertyListenerUPP (find-mactype '(:pointer :OpaqueQTComponentPropertyListenerProcPtr)))
; 
;  *  QTGetComponentPropertyInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTGetComponentPropertyInfo" 
   ((inComponent (:pointer :ComponentInstanceRecord))
    (inPropClass :OSType)
    (inPropID :OSType)
    (outPropType (:pointer :COMPONENTVALUETYPE));  can be NULL 
    (outPropValueSize (:pointer :ByteCount))    ;  can be NULL 
    (outPropertyFlags (:pointer :UInt32))       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  QTGetComponentProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTGetComponentProperty" 
   ((inComponent (:pointer :ComponentInstanceRecord))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inPropValueSize :UInt32)
    (outPropValueAddress (:pointer :void))
    (outPropValueSizeUsed (:pointer :ByteCount));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  QTSetComponentProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTSetComponentProperty" 
   ((inComponent (:pointer :ComponentInstanceRecord))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inPropValueSize :UInt32)
    (inPropValueAddress (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  QTAddComponentPropertyListener()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTAddComponentPropertyListener" 
   ((inComponent (:pointer :ComponentInstanceRecord))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inDispatchProc (:pointer :OpaqueQTComponentPropertyListenerProcPtr))
    (inUserData :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  QTRemoveComponentPropertyListener()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTRemoveComponentPropertyListener" 
   ((inComponent (:pointer :ComponentInstanceRecord))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inDispatchProc (:pointer :OpaqueQTComponentPropertyListenerProcPtr))
    (inUserData :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
;  == "QT" prefixed Component Property Listener helpers == 

(def-mactype :QTComponentPropertyListenersRef (find-mactype ':CFTypeRef))

;type name? (def-mactype :QTComponentPropertyListenerCollectionContext (find-mactype ':QTComponentPropertyListenerCollectionContext))

(def-mactype :QTComponentPropertyListenerFilterProcPtr (find-mactype ':pointer)); (QTComponentPropertyListenersRef inCollection , const QTComponentPropertyListenerCollectionContext * inCollectionContext , ComponentInstance inNotifier , ComponentPropertyClass inPropClass , ComponentPropertyID inPropID , QTComponentPropertyListenerUPP inListenerCallbackProc , const void * inListenerProcRefCon , const void * inFilterProcRefCon)

(def-mactype :QTComponentPropertyListenerFilterUPP (find-mactype '(:pointer :OpaqueQTComponentPropertyListenerFilterProcPtr)))
(defconstant $kQTComponentPropertyListenerCollectionContextVersion 1)
; #define kQTComponentPropertyListenerCollectionContextVersion 1
(defrecord QTComponentPropertyListenerCollectionContext
   (version :UInt32)                            ;  struct version 
   (filterProcUPP (:pointer :OpaqueQTComponentPropertyListenerFilterProcPtr))
   (filterProcData :pointer)
)
; 
;  *  NewQTComponentPropertyListenerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTComponentPropertyListenerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :OpaqueQTComponentPropertyListenerProcPtr)
() )
; 
;  *  NewQTComponentPropertyListenerFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTComponentPropertyListenerFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :OpaqueQTComponentPropertyListenerFilterProcPtr)
() )
; 
;  *  DisposeQTComponentPropertyListenerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTComponentPropertyListenerUPP" 
   ((userUPP (:pointer :OpaqueQTComponentPropertyListenerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  *  DisposeQTComponentPropertyListenerFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTComponentPropertyListenerFilterUPP" 
   ((userUPP (:pointer :OpaqueQTComponentPropertyListenerFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  *  InvokeQTComponentPropertyListenerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTComponentPropertyListenerUPP" 
   ((inComponent (:pointer :ComponentInstanceRecord))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inUserData :pointer)
    (userUPP (:pointer :OpaqueQTComponentPropertyListenerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  *  InvokeQTComponentPropertyListenerFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTComponentPropertyListenerFilterUPP" 
   ((inCollection (:pointer :void))
    (inCollectionContext (:pointer :QTCOMPONENTPROPERTYLISTENERCOLLECTIONCONTEXT))
    (inNotifier (:pointer :ComponentInstanceRecord))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inListenerCallbackProc (:pointer :OpaqueQTComponentPropertyListenerProcPtr))
    (inListenerProcRefCon :pointer)
    (inFilterProcRefCon :pointer)
    (userUPP (:pointer :OpaqueQTComponentPropertyListenerFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  *  QTComponentPropertyListenerCollectionCreate()
;  *  
;  *  Summary:
;  *    Create a collection to use with the functions
;  *    ComponentPropertyListenerCollectionAddListener,
;  *    ComponentPropertyListenerCollectionRemoveListener,
;  *    ComponentPropertyListenerCollectionNotifyListeners,
;  *    ComponentPropertyListenerCollectionIsEmpty, and
;  *    ComponentPropertyListenerCollectionHasListenersForProperty.
;  *  
;  *  Parameters:
;  *    
;  *    outCollection:
;  *      Returns the new, empty, listener collection.
;  *    
;  *    inAllocator:
;  *      Allocator used to create the collection and it's contents.
;  *    
;  *    inContext:
;  *      The listener collection context. May be NULL.  A copy of the
;  *      contents of the structure is made, so a pointer to a structure
;  *      on the stack can be passed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTComponentPropertyListenerCollectionCreate" 
   ((inAllocator (:pointer :__CFAllocator))     ;  can be NULL 
    (inContext (:pointer :QTCOMPONENTPROPERTYLISTENERCOLLECTIONCONTEXT));  can be NULL 
    (outCollection (:pointer :QTCOMPONENTPROPERTYLISTENERSREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  QTComponentPropertyListenerCollectionAddListener()
;  *  
;  *  Summary:
;  *    Add a listener callback for the specified property class and ID
;  *    to a property listener collection.
;  *  
;  *  Parameters:
;  *    
;  *    inCollection:
;  *      The property listener collection.
;  *    
;  *    inPropClass:
;  *      The property class.
;  *    
;  *    inPropID:
;  *      The property ID.
;  *    
;  *    inListenerProc:
;  *      The property listener callback function.
;  *    
;  *    inListenerProcRefCon:
;  *      The data parameter to pass to the listener callback function.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTComponentPropertyListenerCollectionAddListener" 
   ((inCollection (:pointer :void))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inListenerProc (:pointer :OpaqueQTComponentPropertyListenerProcPtr))
    (inListenerProcRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  QTComponentPropertyListenerCollectionRemoveListener()
;  *  
;  *  Summary:
;  *    Remove a listener callback for the specified property class and
;  *    ID from a property listener collection.
;  *  
;  *  Parameters:
;  *    
;  *    inCollection:
;  *      The property listener collection.
;  *    
;  *    inPropClass:
;  *      The property class.
;  *    
;  *    inPropID:
;  *      The property ID.
;  *    
;  *    inListenerProc:
;  *      The property listener callback function.
;  *    
;  *    inListenerProcRefCon:
;  *      The data parameter to pass to the listener callback function.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTComponentPropertyListenerCollectionRemoveListener" 
   ((inCollection (:pointer :void))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inListenerProc (:pointer :OpaqueQTComponentPropertyListenerProcPtr))
    (inListenerProcRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  QTComponentPropertyListenerCollectionNotifyListeners()
;  *  
;  *  Summary:
;  *    Call all listener callbacks in the collection registered for the
;  *    specified property class and ID.
;  *  
;  *  Discussion:
;  *    If the "filterProcUPP" in the collection's context is non-NULL,
;  *    the filter function will be called before each registered
;  *    listener that matches the specified property class and ID. If the
;  *    filter function return false, the listener proc will not be
;  *    called. This is intended to allow a component to change the
;  *    calling semantics (call another thread, etc), to use a different
;  *    listener callback signature, etc.
;  *  
;  *  Parameters:
;  *    
;  *    inCollection:
;  *      The property listener collection.
;  *    
;  *    inNotifier:
;  *      The calling ComponentInstance.
;  *    
;  *    inPropClass:
;  *      The property class.
;  *    
;  *    inPropID:
;  *      The property ID.
;  *    
;  *    inFilterProcRefCon:
;  *      The data parameter to pass to the filter function.
;  *    
;  *    inFlags:
;  *      Flags.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTComponentPropertyListenerCollectionNotifyListeners" 
   ((inCollection (:pointer :void))
    (inNotifier (:pointer :ComponentInstanceRecord))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inFilterProcRefCon :pointer)               ;  can be NULL 
    (inFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  QTComponentPropertyListenerCollectionIsEmpty()
;  *  
;  *  Summary:
;  *    Return true if the listener collection is empty.
;  *  
;  *  Parameters:
;  *    
;  *    inCollection:
;  *      The property listener collection.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTComponentPropertyListenerCollectionIsEmpty" 
   ((inCollection (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  *  QTComponentPropertyListenerCollectionHasListenersForProperty()
;  *  
;  *  Summary:
;  *    Returns true if there are any listeners registered for the
;  *    specified property class and ID.
;  *  
;  *  Parameters:
;  *    
;  *    inCollection:
;  *      The property listener collection.
;  *    
;  *    inPropClass:
;  *      The property class.
;  *    
;  *    inPropID:
;  *      The property ID.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTComponentPropertyListenerCollectionHasListenersForProperty" 
   ((inCollection (:pointer :void))
    (inPropClass :OSType)
    (inPropID :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  DRM properties

(defconstant $kQTPropertyClass_DRM :|drm |)

(defconstant $kQTDRMPropertyID_InteractWithUser :|shui|);  Boolean*

(defconstant $kQTDRMPropertyID_IsProtected :|prot|);  Boolean*

(defconstant $kQTDRMPropertyID_IsAuthorized :|auth|);  Boolean*

;  UPP call backs 
;  selectors for component calls 

(defconstant $kGraphicsImportSetDataReferenceSelect 1)
(defconstant $kGraphicsImportGetDataReferenceSelect 2)
(defconstant $kGraphicsImportSetDataFileSelect 3)
(defconstant $kGraphicsImportGetDataFileSelect 4)
(defconstant $kGraphicsImportSetDataHandleSelect 5)
(defconstant $kGraphicsImportGetDataHandleSelect 6)
(defconstant $kGraphicsImportGetImageDescriptionSelect 7)
(defconstant $kGraphicsImportGetDataOffsetAndSizeSelect 8)
(defconstant $kGraphicsImportReadDataSelect 9)
(defconstant $kGraphicsImportSetClipSelect 10)
(defconstant $kGraphicsImportGetClipSelect 11)
(defconstant $kGraphicsImportSetSourceRectSelect 12)
(defconstant $kGraphicsImportGetSourceRectSelect 13)
(defconstant $kGraphicsImportGetNaturalBoundsSelect 14)
(defconstant $kGraphicsImportDrawSelect 15)
(defconstant $kGraphicsImportSetGWorldSelect 16)
(defconstant $kGraphicsImportGetGWorldSelect 17)
(defconstant $kGraphicsImportSetMatrixSelect 18)
(defconstant $kGraphicsImportGetMatrixSelect 19)
(defconstant $kGraphicsImportSetBoundsRectSelect 20)
(defconstant $kGraphicsImportGetBoundsRectSelect 21)
(defconstant $kGraphicsImportSaveAsPictureSelect 22)
(defconstant $kGraphicsImportSetGraphicsModeSelect 23)
(defconstant $kGraphicsImportGetGraphicsModeSelect 24)
(defconstant $kGraphicsImportSetQualitySelect 25)
(defconstant $kGraphicsImportGetQualitySelect 26)
(defconstant $kGraphicsImportSaveAsQuickTimeImageFileSelect 27)
(defconstant $kGraphicsImportSetDataReferenceOffsetAndLimitSelect 28)
(defconstant $kGraphicsImportGetDataReferenceOffsetAndLimitSelect 29)
(defconstant $kGraphicsImportGetAliasedDataReferenceSelect 30)
(defconstant $kGraphicsImportValidateSelect 31)
(defconstant $kGraphicsImportGetMetaDataSelect 32)
(defconstant $kGraphicsImportGetMIMETypeListSelect 33)
(defconstant $kGraphicsImportDoesDrawAllPixelsSelect 34)
(defconstant $kGraphicsImportGetAsPictureSelect 35)
(defconstant $kGraphicsImportExportImageFileSelect 36)
(defconstant $kGraphicsImportGetExportImageTypeListSelect 37)
(defconstant $kGraphicsImportDoExportImageFileDialogSelect 38)
(defconstant $kGraphicsImportGetExportSettingsAsAtomContainerSelect 39)
(defconstant $kGraphicsImportSetExportSettingsFromAtomContainerSelect 40)
(defconstant $kGraphicsImportSetProgressProcSelect 41)
(defconstant $kGraphicsImportGetProgressProcSelect 42)
(defconstant $kGraphicsImportGetImageCountSelect 43)
(defconstant $kGraphicsImportSetImageIndexSelect 44)
(defconstant $kGraphicsImportGetImageIndexSelect 45)
(defconstant $kGraphicsImportGetDataOffsetAndSize64Select 46)
(defconstant $kGraphicsImportReadData64Select 47)
(defconstant $kGraphicsImportSetDataReferenceOffsetAndLimit64Select 48)
(defconstant $kGraphicsImportGetDataReferenceOffsetAndLimit64Select 49)
(defconstant $kGraphicsImportGetDefaultMatrixSelect 50)
(defconstant $kGraphicsImportGetDefaultClipSelect 51)
(defconstant $kGraphicsImportGetDefaultGraphicsModeSelect 52)
(defconstant $kGraphicsImportGetDefaultSourceRectSelect 53)
(defconstant $kGraphicsImportGetColorSyncProfileSelect 54)
(defconstant $kGraphicsImportSetDestRectSelect 55)
(defconstant $kGraphicsImportGetDestRectSelect 56)
(defconstant $kGraphicsImportSetFlagsSelect 57)
(defconstant $kGraphicsImportGetFlagsSelect 58)
(defconstant $kGraphicsImportGetBaseDataOffsetAndSize64Select 61)
(defconstant $kGraphicsImportSetImageIndexToThumbnailSelect 62)
(defconstant $kGraphicsImportCreateCGImageSelect 63)
(defconstant $kGraphicsImportSaveAsPictureToDataRefSelect 64)
(defconstant $kGraphicsImportSaveAsQuickTimeImageFileToDataRefSelect 65)
(defconstant $kGraphicsImportExportImageFileToDataRefSelect 66)
(defconstant $kGraphicsImportDoExportImageFileToDataRefDialogSelect 67)
(defconstant $kGraphicsImportSetOverrideSourceColorSyncProfileRefSelect 68)
(defconstant $kGraphicsImportGetOverrideSourceColorSyncProfileRefSelect 69)
(defconstant $kGraphicsImportSetDestinationColorSyncProfileRefSelect 70)
(defconstant $kGraphicsImportGetDestinationColorSyncProfileRefSelect 71)
(defconstant $kGraphicsImportWillUseColorMatchingSelect 72)
(defconstant $kGraphicsImportGetGenericColorSyncProfileSelect 73)
(defconstant $kGraphicsImportSetReturnGenericColorSyncProfileSelect 74)
(defconstant $kGraphicsImportGetReturnGenericColorSyncProfileSelect 75)
(defconstant $kGraphicsExportDoExportSelect 1)
(defconstant $kGraphicsExportCanTranscodeSelect 2)
(defconstant $kGraphicsExportDoTranscodeSelect 3)
(defconstant $kGraphicsExportCanUseCompressorSelect 4)
(defconstant $kGraphicsExportDoUseCompressorSelect 5)
(defconstant $kGraphicsExportDoStandaloneExportSelect 6)
(defconstant $kGraphicsExportGetDefaultFileTypeAndCreatorSelect 7)
(defconstant $kGraphicsExportGetDefaultFileNameExtensionSelect 8)
(defconstant $kGraphicsExportGetMIMETypeListSelect 9)
(defconstant $kGraphicsExportRequestSettingsSelect 11)
(defconstant $kGraphicsExportSetSettingsFromAtomContainerSelect 12)
(defconstant $kGraphicsExportGetSettingsAsAtomContainerSelect 13)
(defconstant $kGraphicsExportGetSettingsAsTextSelect 14)
(defconstant $kGraphicsExportSetDontRecompressSelect 15)
(defconstant $kGraphicsExportGetDontRecompressSelect 16)
(defconstant $kGraphicsExportSetInterlaceStyleSelect 17)
(defconstant $kGraphicsExportGetInterlaceStyleSelect 18)
(defconstant $kGraphicsExportSetMetaDataSelect 19)
(defconstant $kGraphicsExportGetMetaDataSelect 20)
(defconstant $kGraphicsExportSetTargetDataSizeSelect 21)
(defconstant $kGraphicsExportGetTargetDataSizeSelect 22)
(defconstant $kGraphicsExportSetCompressionMethodSelect 23)
(defconstant $kGraphicsExportGetCompressionMethodSelect 24)
(defconstant $kGraphicsExportSetCompressionQualitySelect 25)
(defconstant $kGraphicsExportGetCompressionQualitySelect 26)
(defconstant $kGraphicsExportSetResolutionSelect 27)
(defconstant $kGraphicsExportGetResolutionSelect 28)
(defconstant $kGraphicsExportSetDepthSelect 29)
(defconstant $kGraphicsExportGetDepthSelect 30)
(defconstant $kGraphicsExportSetColorSyncProfileSelect 33)
(defconstant $kGraphicsExportGetColorSyncProfileSelect 34)
(defconstant $kGraphicsExportSetProgressProcSelect 35)
(defconstant $kGraphicsExportGetProgressProcSelect 36)
(defconstant $kGraphicsExportSetInputDataReferenceSelect 37)
(defconstant $kGraphicsExportGetInputDataReferenceSelect 38)
(defconstant $kGraphicsExportSetInputFileSelect 39)
(defconstant $kGraphicsExportGetInputFileSelect 40)
(defconstant $kGraphicsExportSetInputHandleSelect 41)
(defconstant $kGraphicsExportGetInputHandleSelect 42)
(defconstant $kGraphicsExportSetInputPtrSelect 43)
(defconstant $kGraphicsExportGetInputPtrSelect 44)
(defconstant $kGraphicsExportSetInputGraphicsImporterSelect 45)
(defconstant $kGraphicsExportGetInputGraphicsImporterSelect 46)
(defconstant $kGraphicsExportSetInputPictureSelect 47)
(defconstant $kGraphicsExportGetInputPictureSelect 48)
(defconstant $kGraphicsExportSetInputGWorldSelect 49)
(defconstant $kGraphicsExportGetInputGWorldSelect 50)
(defconstant $kGraphicsExportSetInputPixmapSelect 51)
(defconstant $kGraphicsExportGetInputPixmapSelect 52)
(defconstant $kGraphicsExportSetInputOffsetAndLimitSelect 53)
(defconstant $kGraphicsExportGetInputOffsetAndLimitSelect 54)
(defconstant $kGraphicsExportMayExporterReadInputDataSelect 55)
(defconstant $kGraphicsExportGetInputDataSizeSelect 56)
(defconstant $kGraphicsExportReadInputDataSelect 57)
(defconstant $kGraphicsExportGetInputImageDescriptionSelect 58)
(defconstant $kGraphicsExportGetInputImageDimensionsSelect 59)
(defconstant $kGraphicsExportGetInputImageDepthSelect 60)
(defconstant $kGraphicsExportDrawInputImageSelect 61)
(defconstant $kGraphicsExportSetOutputDataReferenceSelect 62)
(defconstant $kGraphicsExportGetOutputDataReferenceSelect 63)
(defconstant $kGraphicsExportSetOutputFileSelect 64)
(defconstant $kGraphicsExportGetOutputFileSelect 65)
(defconstant $kGraphicsExportSetOutputHandleSelect 66)
(defconstant $kGraphicsExportGetOutputHandleSelect 67)
(defconstant $kGraphicsExportSetOutputOffsetAndMaxSizeSelect 68)
(defconstant $kGraphicsExportGetOutputOffsetAndMaxSizeSelect 69)
(defconstant $kGraphicsExportSetOutputFileTypeAndCreatorSelect 70)
(defconstant $kGraphicsExportGetOutputFileTypeAndCreatorSelect 71)
(defconstant $kGraphicsExportWriteOutputDataSelect 72)
(defconstant $kGraphicsExportSetOutputMarkSelect 73)
(defconstant $kGraphicsExportGetOutputMarkSelect 74)
(defconstant $kGraphicsExportReadOutputDataSelect 75)
(defconstant $kGraphicsExportSetThumbnailEnabledSelect 76)
(defconstant $kGraphicsExportGetThumbnailEnabledSelect 77)
(defconstant $kGraphicsExportSetExifEnabledSelect 78)
(defconstant $kGraphicsExportGetExifEnabledSelect 79)
(defconstant $kGraphicsExportSetInputCGImageSelect 80)
(defconstant $kGraphicsExportGetInputCGImageSelect 81)
(defconstant $kGraphicsExportSetInputCGBitmapContextSelect 82)
(defconstant $kGraphicsExportGetInputCGBitmapContextSelect 83)
(defconstant $kGraphicsExportSetFlagsSelect 84)
(defconstant $kGraphicsExportGetFlagsSelect 85)
(defconstant $kImageTranscoderBeginSequenceSelect 1)
(defconstant $kImageTranscoderConvertSelect 2)
(defconstant $kImageTranscoderDisposeDataSelect 3)
(defconstant $kImageTranscoderEndSequenceSelect 4)
(defconstant $kQTGetComponentPropertyInfoSelect -11)
(defconstant $kQTGetComponentPropertySelect -12)
(defconstant $kQTSetComponentPropertySelect -13)
(defconstant $kQTAddComponentPropertyListenerSelect -14)
(defconstant $kQTRemoveComponentPropertyListenerSelect -15)
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __IMAGECOMPRESSION__ */


(provide-interface "ImageCompression")