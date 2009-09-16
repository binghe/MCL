(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOGraphicsTypes.h"
; at Sunday July 2,2006 7:27:50 pm.
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
; #ifndef _IOKIT_IOGRAPHICSTYPES_H
; #define _IOKIT_IOGRAPHICSTYPES_H

(require-interface "IOKit/IOTypes")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
(defconstant $IOGRAPHICSTYPES_REV 6)
; #define IOGRAPHICSTYPES_REV	6

(def-mactype :IOIndex (find-mactype ':SInt32))

(def-mactype :IOSelect (find-mactype ':UInt32))

(def-mactype :IOFixed1616 (find-mactype ':UInt32))

(def-mactype :IODisplayVendorID (find-mactype ':UInt32))

(def-mactype :IODisplayProductID (find-mactype ':UInt32))

(def-mactype :IODisplayModeID (find-mactype ':SInt32))
;  This is the ID given to a programmable timing used at boot time

(defconstant $kIODisplayModeIDBootProgrammable #xFFFFFFFB);  Lowest (unsigned) DisplayModeID reserved by Apple

(defconstant $kIODisplayModeIDReservedBase #x80000000)

(defconstant $kIOMaxPixelBits 64)
(defrecord IOPixelEncoding
   (contents (:array :character 64))
)                                               ;  Common Apple pixel formats
(defconstant $IO1BitIndexedPixels "P")
; #define IO1BitIndexedPixels	"P"
(defconstant $IO2BitIndexedPixels "PP")
; #define IO2BitIndexedPixels	"PP"
(defconstant $IO4BitIndexedPixels "PPPP")
; #define IO4BitIndexedPixels	"PPPP"
(defconstant $IO8BitIndexedPixels "PPPPPPPP")
; #define IO8BitIndexedPixels	"PPPPPPPP"
(defconstant $IO16BitDirectPixels "-RRRRRGGGGGBBBBB")
; #define IO16BitDirectPixels	"-RRRRRGGGGGBBBBB"
(defconstant $IO32BitDirectPixels "--------RRRRRRRRGGGGGGGGBBBBBBBB")
; #define IO32BitDirectPixels	"--------RRRRRRRRGGGGGGGGBBBBBBBB"
;  other possible pixel formats
(defconstant $IOYUV422Pixels "Y4U2V2")
; #define IOYUV422Pixels		"Y4U2V2"
(defconstant $IO8BitOverlayPixels "O8")
; #define IO8BitOverlayPixels	"O8"
;  page flipping
(defconstant $IOPagedPixels "Page1")
; #define IOPagedPixels		"Page1"
(defconstant $IO_SampleTypeAlpha "A")
; #define IO_SampleTypeAlpha	'A'
(defconstant $IO_SampleTypeSkip "-")
; #define IO_SampleTypeSkip	'-'
;  Info about a pixel format

(defconstant $kIOCLUTPixels 0)
(defconstant $kIOFixedCLUTPixels 1)
(defconstant $kIORGBDirectPixels 2)
(defconstant $kIOMonoDirectPixels 3)
(defconstant $kIOMonoInverseDirectPixels 4)
; !
;  * @struct IOPixelInformation
;  * @abstract A structure defining the format of a framebuffer.
;  * @discussion This structure is used by IOFramebuffer to define the format of the pixels.
;  * @field bytesPerRow The number of bytes per row.
;  * @field bytesPerPlane Not used.
;  * @field bitsPerPixel The number of bits per pixel, including unused bits and alpha.
;  * @field pixelType One of kIOCLUTPixels (indexed pixels with changeable CLUT), kIORGBDirectPixels (direct pixels).
;  * @field componentCount One for indexed pixels, three for direct pixel formats.
;  * @field bitsPerComponent Number of bits per component in each pixel.
;  * @field componentMasks Mask of the bits valid for each component of the pixel - in R, G, B order for direct pixels.
;  * @field pixelFormat String description of the pixel format - IO32BitDirectPixels, IO16BitDirectPixels etc.
;  * @field flags None defined - set to zero.
;  * @field activeWidth Number of pixels visible per row.
;  * @field activeHeight Number of visible pixel rows.
;  * @field reserved Set to zero.
;  
(defrecord IOPixelInformation
   (bytesPerRow :UInt32)
   (bytesPerPlane :UInt32)
   (bitsPerPixel :UInt32)
   (pixelType :UInt32)
   (componentCount :UInt32)
   (bitsPerComponent :UInt32)
   (componentMasks (:array :UInt32 16))
   (pixelFormat :IOPIXELENCODING)
   (flags :UInt32)
   (activeWidth :UInt32)
   (activeHeight :UInt32)
   (reserved (:array :UInt32 2))
)

;type name? (%define-record :IOPixelInformation (find-record-descriptor ':IOPixelInformation))
;  ID for industry standard display timings

(def-mactype :IOAppleTimingID (find-mactype ':UInt32))
; !
;  * @struct IODisplayModeInformation
;  * @abstract A structure defining the format of a framebuffer.
;  * @discussion This structure is used by IOFramebuffer to define the format of the pixels.
;  * @field nominalWidth Number of pixels visible per row.
;  * @field nominalHeight Number of visible pixel rows.
;  * @field refreshRate Refresh rate in fixed point 16.16.
;  * @field maxDepthIndex Highest depth index available in this display mode.
;  * @field flags Flags for the mode, including: <br>
;     kDisplayModeInterlacedFlag mode is interlaced. <br>
;     kDisplayModeSimulscanFlag mode is available on multiple display connections. <br>
;     kDisplayModeNotPresetFlag mode is not a factory preset for the display (geometry may need correction). <br>
;     kDisplayModeStretchedFlag mode is stretched/distorted to match the display aspect ratio. <br>
;  * @field reserved Set to zero.
;  
(defrecord IODisplayModeInformation
   (nominalWidth :UInt32)
   (nominalHeight :UInt32)
   (refreshRate :UInt32)
   (maxDepthIndex :SInt32)
   (flags :UInt32)
   (reserved (:array :UInt32 4))
)

;type name? (%define-record :IODisplayModeInformation (find-record-descriptor ':IODisplayModeInformation))
;  flags

(defconstant $kDisplayModeSafetyFlags 7)
(defconstant $kDisplayModeAlwaysShowFlag 8)
(defconstant $kDisplayModeNeverShowFlag #x80)
(defconstant $kDisplayModeNotResizeFlag 16)
(defconstant $kDisplayModeRequiresPanFlag 32)
(defconstant $kDisplayModeInterlacedFlag 64)
(defconstant $kDisplayModeSimulscanFlag #x100)
(defconstant $kDisplayModeBuiltInFlag #x400)
(defconstant $kDisplayModeNotPresetFlag #x200)
(defconstant $kDisplayModeStretchedFlag #x800)
(defconstant $kDisplayModeNotGraphicsQualityFlag #x1000)
(defconstant $kDisplayModeTelevisionFlag #x100000)

(defconstant $kDisplayModeValidFlag 1)
(defconstant $kDisplayModeSafeFlag 2)
(defconstant $kDisplayModeDefaultFlag 4)
;  Framebuffer info - obsolete
(defrecord IOFramebufferInformation
   (baseAddress :UInt32)
   (activeWidth :UInt32)
   (activeHeight :UInt32)
   (bytesPerRow :UInt32)
   (bytesPerPlane :UInt32)
   (bitsPerPixel :UInt32)
   (pixelType :UInt32)
   (flags :UInt32)
   (reserved (:array :UInt32 4))
)

;type name? (%define-record :IOFramebufferInformation (find-record-descriptor ':IOFramebufferInformation))
;  flags

(defconstant $kFramebufferSupportsCopybackCache #x10000)
(defconstant $kFramebufferSupportsWritethruCache #x20000)
(defconstant $kFramebufferSupportsGammaCorrection #x40000)
(defconstant $kFramebufferDisableAltivecAccess #x80000)
;  Aperture is an index into supported pixel formats for a mode & depth

(def-mactype :IOPixelAperture (find-mactype ':SInt32))

(defconstant $kIOFBSystemAperture 0)
; // CLUTs

(def-mactype :IOColorComponent (find-mactype ':UInt16))
; !
;  * @struct IOColorEntry
;  * @abstract A structure defining one entry of a color lookup table.
;  * @discussion This structure is used by IOFramebuffer to define an entry of a color lookup table.
;  * @field index Number of pixels visible per row.
;  * @field red Value of red component 0-65535.
;  * @field green Value of green component 0-65535.
;  * @field blue Value of blue component 0-65535.
;  
(defrecord IOColorEntry
   (index :UInt16)
   (red :UInt16)
   (green :UInt16)
   (blue :UInt16)
)

;type name? (%define-record :IOColorEntry (find-record-descriptor ':IOColorEntry))
;  options (masks)

(defconstant $kSetCLUTByValue 1)                ;  else at index

(defconstant $kSetCLUTImmediately 2)            ;  else at VBL

(defconstant $kSetCLUTWithLuminance 4)          ;  else RGB

; // Controller attributes

(defconstant $kIOPowerAttribute :|powr|)
(defconstant $kIOHardwareCursorAttribute :|crsr|)
(defconstant $kIOMirrorAttribute :|mirr|)
(defconstant $kIOMirrorDefaultAttribute :|mrdf|)
(defconstant $kIOCapturedAttribute :|capd|)
(defconstant $kIOCursorControlAttribute :|crsc|)
(defconstant $kIOSystemPowerAttribute :|spwr|)
(defconstant $kIOVRAMSaveAttribute :|vrsv|)
(defconstant $kIODeferCLUTSetAttribute :|vclt|)
;  values for kIOMirrorAttribute

(defconstant $kIOMirrorIsPrimary #x80000000)
(defconstant $kIOMirrorHWClipped #x40000000)
;  values for kIOMirrorDefaultAttribute

(defconstant $kIOMirrorDefault 1)
(defconstant $kIOMirrorForced 2)
; // Display mode timing information
(defrecord IODetailedTimingInformationV1
                                                ;  from EDID defn
   (pixelClock :UInt32)
                                                ;  Hertz
   (horizontalActive :UInt32)
                                                ;  pixels
   (horizontalBlanking :UInt32)
                                                ;  pixels
   (horizontalBorder :UInt32)
                                                ;  pixels
   (horizontalSyncOffset :UInt32)
                                                ;  pixels
   (horizontalSyncWidth :UInt32)
                                                ;  pixels
   (verticalActive :UInt32)
                                                ;  lines
   (verticalBlanking :UInt32)
                                                ;  lines
   (verticalBorder :UInt32)
                                                ;  lines
   (verticalSyncOffset :UInt32)
                                                ;  lines
   (verticalSyncWidth :UInt32)
                                                ;  lines
)

;type name? (%define-record :IODetailedTimingInformationV1 (find-record-descriptor ':IODetailedTimingInformationV1))
; !
;  * @struct IODetailedTimingInformationV2
;  * @abstract A structure defining the detailed timing information of a display mode.
;  * @discussion This structure is used by IOFramebuffer to define detailed timing information for a display mode. The VESA EDID document has more information.
;  * @field __reservedA Set to zero.
;  * @field scalerFlags If the mode is scaled, kIOScaleStretchToFit may be set to allow stretching.
;  * @field horizontalScaled If the mode is scaled, sets the size of the image before scaling.
;  * @field verticalScaled If the mode is scaled, sets the size of the image before scaling.
;  * @field signalConfig kIOAnalogSetupExpected set if display expects a blank-to-black setup or pedestal.  See VESA signal standards.
;  * @field signalLevels One of:<br>
;     kIOAnalogSignalLevel_0700_0300 0.700 - 0.300 V p-p.<br>
;     kIOAnalogSignalLevel_0714_0286 0.714 - 0.286 V p-p.<br>
;     kIOAnalogSignalLevel_1000_0400 1.000 - 0.400 V p-p.<br>
;     kIOAnalogSignalLevel_0700_0000 0.700 - 0.000 V p-p.<br>
;  * @field pixelClock Pixel clock frequency in Hz.
;  * @field minPixelClock Minimum pixel clock frequency in Hz, with error.
;  * @field maxPixelClock Maximum pixel clock frequency in Hz, with error.
;  * @field horizontalActive Pixel clocks per line.
;  * @field horizontalBlanking Blanking clocks per line.
;  * @field horizontalSyncOffset First clock of horizontal sync.
;  * @field horizontalSyncPulseWidth Width of horizontal sync.
;  * @field verticalActive Number of lines per frame.
;  * @field verticalBlanking Blanking lines per frame.
;  * @field verticalSyncOffset First line of vertical sync.
;  * @field verticalSyncPulseWidth Height of vertical sync.
;  * @field horizontalBorderLeft First clock of horizontal border or zero.
;  * @field horizontalBorderRight Last clock of horizontal border or zero.
;  * @field verticalBorderTop First line of vertical border or zero.
;  * @field verticalBorderBottom Last line of vertical border or zero.
;  * @field horizontalSyncConfig kIOSyncPositivePolarity for positive polarity horizontal sync (0 for negative).
;  * @field horizontalSyncLevel Zero.
;  * @field verticalSyncConfig kIOSyncPositivePolarity for positive polarity vertical sync (0 for negative).
;  * @field verticalSyncLevel Zero.
;  * @field __reservedB Reserved set to zero.
;  
(defrecord IODetailedTimingInformationV2
   (__reservedA (:array :UInt32 5))
                                                ;  Init to 0
   (scalerFlags :UInt32)
   (horizontalScaled :UInt32)
   (verticalScaled :UInt32)
   (signalConfig :UInt32)
   (signalLevels :UInt32)
   (pixelClock :uint64)
                                                ;  Hz
   (minPixelClock :uint64)
                                                ;  Hz - With error what is slowest actual clock
   (maxPixelClock :uint64)
                                                ;  Hz - With error what is fasted actual clock
   (horizontalActive :UInt32)
                                                ;  pixels
   (horizontalBlanking :UInt32)
                                                ;  pixels
   (horizontalSyncOffset :UInt32)
                                                ;  pixels
   (horizontalSyncPulseWidth :UInt32)
                                                ;  pixels
   (verticalActive :UInt32)
                                                ;  lines
   (verticalBlanking :UInt32)
                                                ;  lines
   (verticalSyncOffset :UInt32)
                                                ;  lines
   (verticalSyncPulseWidth :UInt32)
                                                ;  lines
   (horizontalBorderLeft :UInt32)
                                                ;  pixels
   (horizontalBorderRight :UInt32)
                                                ;  pixels
   (verticalBorderTop :UInt32)
                                                ;  lines
   (verticalBorderBottom :UInt32)
                                                ;  lines
   (horizontalSyncConfig :UInt32)
   (horizontalSyncLevel :UInt32)
                                                ;  Future use (init to 0)
   (verticalSyncConfig :UInt32)
   (verticalSyncLevel :UInt32)
                                                ;  Future use (init to 0)
   (__reservedB (:array :UInt32 8))
                                                ;  Init to 0
)

;type name? (%define-record :IODetailedTimingInformationV2 (find-record-descriptor ':IODetailedTimingInformationV2))

(%define-record :IODetailedTimingInformation (find-record-descriptor ':IODetailedTimingInformationV2))
(defrecord IOTimingInformation
   (appleTimingID :UInt32)
                                                ;  kIOTimingIDXXX const
   (flags :UInt32)
   (:variant
   (
   (v1 :IODetailedTimingInformationV1)
   )
   (
   (v2 :IODetailedTimingInformationV2)
   )
   )
)

;type name? (%define-record :IOTimingInformation (find-record-descriptor ':IOTimingInformation))
;  IOTimingInformation flags

(defconstant $kIODetailedTimingValid #x80000000)
(defconstant $kIOScalingInfoValid #x40000000)
;  scalerFlags

(defconstant $kIOScaleStretchToFit 1)
(defrecord IOFBDisplayModeDescription
   (info :IODisplayModeInformation)
   (timingInfo :IOTimingInformation)
)

;type name? (%define-record :IOFBDisplayModeDescription (find-record-descriptor ':IOFBDisplayModeDescription))
; !
;  * @struct IODisplayTimingRange
;  * @abstract A structure defining the limits and attributes of a display or framebuffer.
;  * @discussion This structure is used to define the limits for modes programmed as detailed timings by the OS. The VESA EDID is useful background information for many of these fields. A data property with this structure under the key kIOFBTimingRangeKey in a framebuffer will allow the OS to program detailed timings that fall within its range.
;  * @field __reservedA Set to zero.
;  * @field version Set to zero.
;  * @field __reservedB Set to zero.
;  * @field minPixelClock minimum pixel clock frequency in range, in Hz.
;  * @field minPixelClock maximum pixel clock frequency in range, in Hz.
;  * @field maxPixelError largest variation between specified and actual pixel clock frequency, in Hz.
;  * @field supportedSyncFlags mask of supported sync attributes. The following are defined:<br>
;     kIORangeSupportsSeparateSyncs - digital separate syncs.<br>
;     kIORangeSupportsSyncOnGreen - sync on green.<br>
;     kIORangeSupportsCompositeSync - composite sync.<br>
;     kIORangeSupportsVSyncSerration - vertical sync has serration and equalization pulses.<br>
;  * @field supportedSignalLevels mask of possible signal levels. The following are defined:<br>
;     kIORangeSupportsSignal_0700_0300 0.700 - 0.300 V p-p.<br>
;     kIORangeSupportsSignal_0714_0286 0.714 - 0.286 V p-p.<br>
;     kIORangeSupportsSignal_1000_0400 1.000 - 0.400 V p-p.<br>
;     kIORangeSupportsSignal_0700_0000 0.700 - 0.000 V p-p.<br>
;  * @field __reservedC Set to zero.
;  * @field minFrameRate minimum frame rate (vertical refresh frequency) in range, in Hz.
;  * @field maxFrameRate maximum frame rate (vertical refresh frequency) in range, in Hz.
;  * @field minLineRate minimum line rate (horizontal refresh frequency) in range, in Hz.
;  * @field maxLineRate maximum line rate (horizontal refresh frequency) in range, in Hz.
;  * @field maxHorizontalTotal maximum clocks in horizontal line (active + blanking).
;  * @field maxVerticalTotal maximum lines in vertical frame (active + blanking).
;  * @field __reservedD Set to zero.
;  * @field charSizeHorizontalActive horizontalActive must be a multiple of charSizeHorizontalActive.
;  * @field charSizeHorizontalBlanking horizontalBlanking must be a multiple of charSizeHorizontalBlanking.
;  * @field charSizeHorizontalSyncOffset horizontalSyncOffset must be a multiple of charSizeHorizontalSyncOffset.
;  * @field charSizeHorizontalSyncPulse horizontalSyncPulse must be a multiple of charSizeHorizontalSyncPulse.
;  * @field charSizeVerticalActive verticalActive must be a multiple of charSizeVerticalActive.
;  * @field charSizeVerticalBlanking verticalBlanking must be a multiple of charSizeVerticalBlanking.
;  * @field charSizeVerticalSyncOffset verticalSyncOffset must be a multiple of charSizeVerticalSyncOffset.
;  * @field charSizeVerticalSyncPulse verticalSyncPulse must be a multiple of charSizeVerticalSyncPulse.
;  * @field charSizeHorizontalBorderLeft horizontalBorderLeft must be a multiple of charSizeHorizontalBorderLeft.
;  * @field charSizeHorizontalBorderRight horizontalBorderRight must be a multiple of charSizeHorizontalBorderRight.
;  * @field charSizeVerticalBorderTop verticalBorderTop must be a multiple of charSizeVerticalBorderTop.
;  * @field charSizeVerticalBorderBottom verticalBorderBottom must be a multiple of charSizeVerticalBorderBottom.
;  * @field charSizeHorizontalTotal (horizontalActive + horizontalBlanking) must be a multiple of charSizeHorizontalTotal.
;  * @field charSizeVerticalTotal (verticalActive + verticalBlanking) must be a multiple of charSizeVerticalTotal.
;  * @field __reservedE Set to zero.
;  * @field minHorizontalActiveClocks minimum value of horizontalActive.
;  * @field maxHorizontalActiveClocks maximum value of horizontalActive.
;  * @field minHorizontalBlankingClocks minimum value of horizontalBlanking.
;  * @field maxHorizontalBlankingClocks maximum value of horizontalBlanking.
;  * @field minHorizontalSyncOffsetClocks minimum value of horizontalSyncOffset.
;  * @field maxHorizontalSyncOffsetClocks maximum value of horizontalSyncOffset.
;  * @field minHorizontalPulseWidthClocks minimum value of horizontalPulseWidth.
;  * @field maxHorizontalPulseWidthClocks maximum value of horizontalPulseWidth.
;  * @field minVerticalActiveClocks minimum value of verticalActive.
;  * @field maxVerticalActiveClocks maximum value of verticalActive.
;  * @field minVerticalBlankingClocks minimum value of verticalBlanking.
;  * @field maxVerticalBlankingClocks maximum value of verticalBlanking.
;  * @field minVerticalSyncOffsetClocks minimum value of verticalSyncOffset.
;  * @field maxVerticalSyncOffsetClocks maximum value of verticalSyncOffset.
;  * @field minVerticalPulseWidthClocks minimum value of verticalPulseWidth.
;  * @field maxVerticalPulseWidthClocks maximum value of verticalPulseWidth.
;  * @field minHorizontalBorderLeft minimum value of horizontalBorderLeft.
;  * @field maxHorizontalBorderLeft maximum value of horizontalBorderLeft.
;  * @field minHorizontalBorderRight minimum value of horizontalBorderRight.
;  * @field maxHorizontalBorderRight maximum value of horizontalBorderRight.
;  * @field minVerticalBorderTop minimum value of verticalBorderTop.
;  * @field maxVerticalBorderTop maximum value of verticalBorderTop.
;  * @field minVerticalBorderBottom minimum value of verticalBorderBottom.
;  * @field maxVerticalBorderBottom maximum value of verticalBorderBottom.
;  * @field __reservedF Set to zero.
;  
(defrecord IODisplayTimingRange
   (__reservedA (:array :UInt32 2))
                                                ;  Init to 0
   (version :UInt32)
                                                ;  Init to 0
   (__reservedB (:array :UInt32 5))
                                                ;  Init to 0
   (minPixelClock :uint64)
                                                ;  Min dot clock in Hz
   (maxPixelClock :uint64)
                                                ;  Max dot clock in Hz
   (maxPixelError :UInt32)
                                                ;  Max dot clock error
   (supportedSyncFlags :UInt32)
   (supportedSignalLevels :UInt32)
   (__reservedC (:array :UInt32 1))
                                                ;  Init to 0
   (minFrameRate :UInt32)
                                                ;  Hz
   (maxFrameRate :UInt32)
                                                ;  Hz
   (minLineRate :UInt32)
                                                ;  Hz
   (maxLineRate :UInt32)
                                                ;  Hz
   (maxHorizontalTotal :UInt32)
                                                ;  Clocks - Maximum total (active + blanking)
   (maxVerticalTotal :UInt32)
                                                ;  Clocks - Maximum total (active + blanking)
   (__reservedD (:array :UInt32 2))
                                                ;  Init to 0
   (charSizeHorizontalActive :UInt8)
   (charSizeHorizontalBlanking :UInt8)
   (charSizeHorizontalSyncOffset :UInt8)
   (charSizeHorizontalSyncPulse :UInt8)
   (charSizeVerticalActive :UInt8)
   (charSizeVerticalBlanking :UInt8)
   (charSizeVerticalSyncOffset :UInt8)
   (charSizeVerticalSyncPulse :UInt8)
   (charSizeHorizontalBorderLeft :UInt8)
   (charSizeHorizontalBorderRight :UInt8)
   (charSizeVerticalBorderTop :UInt8)
   (charSizeVerticalBorderBottom :UInt8)
   (charSizeHorizontalTotal :UInt8)
                                                ;  Character size for active + blanking
   (charSizeVerticalTotal :UInt8)
                                                ;  Character size for active + blanking
   (__reservedE :UInt16)
                                                ;  Reserved (Init to 0)
   (minHorizontalActiveClocks :UInt32)
   (maxHorizontalActiveClocks :UInt32)
   (minHorizontalBlankingClocks :UInt32)
   (maxHorizontalBlankingClocks :UInt32)
   (minHorizontalSyncOffsetClocks :UInt32)
   (maxHorizontalSyncOffsetClocks :UInt32)
   (minHorizontalPulseWidthClocks :UInt32)
   (maxHorizontalPulseWidthClocks :UInt32)
   (minVerticalActiveClocks :UInt32)
   (maxVerticalActiveClocks :UInt32)
   (minVerticalBlankingClocks :UInt32)
   (maxVerticalBlankingClocks :UInt32)
   (minVerticalSyncOffsetClocks :UInt32)
   (maxVerticalSyncOffsetClocks :UInt32)
   (minVerticalPulseWidthClocks :UInt32)
   (maxVerticalPulseWidthClocks :UInt32)
   (minHorizontalBorderLeft :UInt32)
   (maxHorizontalBorderLeft :UInt32)
   (minHorizontalBorderRight :UInt32)
   (maxHorizontalBorderRight :UInt32)
   (minVerticalBorderTop :UInt32)
   (maxVerticalBorderTop :UInt32)
   (minVerticalBorderBottom :UInt32)
   (maxVerticalBorderBottom :UInt32)
   (__reservedF (:array :UInt32 8))
                                                ;  Init to 0
)

;type name? (%define-record :IODisplayTimingRange (find-record-descriptor ':IODisplayTimingRange))
;  supportedSignalLevels

(defconstant $kIORangeSupportsSignal_0700_0300 1)
(defconstant $kIORangeSupportsSignal_0714_0286 2)
(defconstant $kIORangeSupportsSignal_1000_0400 4)
(defconstant $kIORangeSupportsSignal_0700_0000 8);  supportedSyncFlags

(defconstant $kIORangeSupportsSeparateSyncs 1)
(defconstant $kIORangeSupportsSyncOnGreen 2)
(defconstant $kIORangeSupportsCompositeSync 4)
(defconstant $kIORangeSupportsVSyncSerration 8) ;  signalConfig
;  Do not set.  Mac OS does not currently support arbitrary digital timings

(defconstant $kIODigitalSignal 1)
(defconstant $kIOAnalogSetupExpected 2)
;  signalLevels for analog

(defconstant $kIOAnalogSignalLevel_0700_0300 0)
(defconstant $kIOAnalogSignalLevel_0714_0286 1)
(defconstant $kIOAnalogSignalLevel_1000_0400 2)
(defconstant $kIOAnalogSignalLevel_0700_0000 3)
;  horizontalSyncConfig and verticalSyncConfig

(defconstant $kIOSyncPositivePolarity 1)
; !
;  * @struct IODisplayScalerInformation
;  * @abstract A structure defining the scaling capabilities of a framebuffer.
;  * @discussion This structure is used to define the limits for modes programmed as detailed timings by the OS. A data property with this structure under the key kIOFBScalerInfoKey in a framebuffer will allow the OS to program detailed timings that are scaled to a displays native resolution.
;  * @field __reservedA Set to zero.
;  * @field version Set to zero.
;  * @field __reservedB Set to zero.
;  * @field scalerFeatures Mask of scaling features. The following are defined:<br>
;     kIOScaleStretchOnly If set the framebuffer can only provide stretched scaling with non-square pixels, without borders.<br>
;     kIOScaleCanUpSamplePixels If set framebuffer can scale up from a smaller number of source pixels to a larger native timing (eg. 640x480 pixels on a 1600x1200 timing).<br>
;     kIOScaleCanDownSamplePixels
;     kIOScaleCanDownSamplePixels If set framebuffer can scale down from a larger number of source pixels to a smaller native timing (eg. 1600x1200 pixels on a 640x480 timing).<br>
;  * @field maxHorizontalPixels Maximum number of horizontal source pixels (horizontalScaled).<br>
;  * @field maxVerticalPixels Maximum number of vertical source pixels (verticalScaled).<br>
;  * @field __reservedC Set to zero.
;  
(defrecord IODisplayScalerInformation
   (__reservedA (:array :UInt32 1))
                                                ;  Init to 0
   (version :UInt32)
                                                ;  Init to 0
   (__reservedB (:array :UInt32 2))
                                                ;  Init to 0
   (scalerFeatures :UInt32)
   (maxHorizontalPixels :UInt32)
   (maxVerticalPixels :UInt32)
   (__reservedC (:array :UInt32 5))
                                                ;  Init to 0
)

;type name? (%define-record :IODisplayScalerInformation (find-record-descriptor ':IODisplayScalerInformation))
;  scalerFeatures 

(defconstant $kIOScaleStretchOnly 1)
(defconstant $kIOScaleCanUpSamplePixels 2)
(defconstant $kIOScaleCanDownSamplePixels 4)
; // Connections

(defconstant $kOrConnections #xFFFFFFE)
(defconstant $kAndConnections #xFFFFFFD)

(defconstant $kConnectionFlags :|flgs|)
(defconstant $kConnectionSyncEnable :|sync|)
(defconstant $kConnectionSyncFlags :|sycf|)
(defconstant $kConnectionSupportsAppleSense :|asns|)
(defconstant $kConnectionSupportsLLDDCSense :|lddc|)
(defconstant $kConnectionSupportsHLDDCSense :|hddc|)
(defconstant $kConnectionEnable :|enab|)
(defconstant $kConnectionChanged :|chng|)
(defconstant $kConnectionPower :|powr|)
(defconstant $kConnectionPostWake :|pwak|)
(defconstant $kConnectionDisplayParameterCount :|pcnt|)
(defconstant $kConnectionDisplayParameters :|parm|)
(defconstant $kConnectionOverscan :|oscn|)
(defconstant $kConnectionVideoBest :|vbst|)
;  kConnectionFlags values

(defconstant $kIOConnectionBuiltIn #x800)
;  kConnectionSyncControl values

(defconstant $kIOHSyncDisable 1)
(defconstant $kIOVSyncDisable 2)
(defconstant $kIOCSyncDisable 4)
(defconstant $kIONoSeparateSyncControl 64)
(defconstant $kIOTriStateSyncs #x80)
(defconstant $kIOSyncOnBlue 8)
(defconstant $kIOSyncOnGreen 16)
(defconstant $kIOSyncOnRed 32)
(defconstant $IO_DISPLAY_CAN_FILL 64)
; #define IO_DISPLAY_CAN_FILL		0x00000040
(defconstant $IO_DISPLAY_CAN_BLIT 32)
; #define IO_DISPLAY_CAN_BLIT		0x00000020
(defconstant $IO_24BPP_TRANSFER_TABLE_SIZE 256)
; #define IO_24BPP_TRANSFER_TABLE_SIZE	256
(defconstant $IO_15BPP_TRANSFER_TABLE_SIZE 256)
; #define IO_15BPP_TRANSFER_TABLE_SIZE	256
(defconstant $IO_8BPP_TRANSFER_TABLE_SIZE 256)
; #define IO_8BPP_TRANSFER_TABLE_SIZE	256
(defconstant $IO_12BPP_TRANSFER_TABLE_SIZE 256)
; #define IO_12BPP_TRANSFER_TABLE_SIZE	256
(defconstant $IO_2BPP_TRANSFER_TABLE_SIZE 256)
; #define IO_2BPP_TRANSFER_TABLE_SIZE	256
(defconstant $STDFB_BM256_TO_BM38_MAP_SIZE 256)
; #define STDFB_BM256_TO_BM38_MAP_SIZE	256
(defconstant $STDFB_BM38_TO_BM256_MAP_SIZE 256)
; #define STDFB_BM38_TO_BM256_MAP_SIZE	256
(defconstant $STDFB_BM38_TO_256_WITH_LOGICAL_SIZE 320)
; #define STDFB_BM38_TO_256_WITH_LOGICAL_SIZE		(STDFB_BM38_TO_BM256_MAP_SIZE + (256/sizeof(int)))
(defconstant $STDFB_4BPS_TO_5BPS_MAP_SIZE 16)
; #define STDFB_4BPS_TO_5BPS_MAP_SIZE	16
(defconstant $STDFB_5BPS_TO_4BPS_MAP_SIZE 32)
; #define STDFB_5BPS_TO_4BPS_MAP_SIZE	32
;  connection types for IOServiceOpen

(defconstant $kIOFBServerConnectType 0)
(defconstant $kIOFBSharedConnectType 1)
;  options for IOServiceRequestProbe()

(defconstant $kIOFBUserRequestProbe 1)
(defrecord IOGPoint
   (x :SInt16)
   (y :SInt16)
)

;type name? (%define-record :IOGPoint (find-record-descriptor ':IOGPoint))
(defrecord IOGSize
   (width :SInt16)
   (height :SInt16)
)

;type name? (%define-record :IOGSize (find-record-descriptor ':IOGSize))
(defrecord IOGBounds
   (minx :SInt16)
   (maxx :SInt16)
   (miny :SInt16)
   (maxy :SInt16)
)

;type name? (%define-record :IOGBounds (find-record-descriptor ':IOGBounds))

; #if !defined(__Point__) && !defined(BINTREE_H) && !defined(__MACTYPES__)
#| 
; #define __Point__

;type name? (%define-record :Point (find-record-descriptor ':IOGPoint))
 |#

; #endif


; #if !defined(__Bounds__) && !defined(BINTREE_H) && !defined(__MACTYPES__)
#| 
; #define __Bounds__

(%define-record :Bounds (find-record-descriptor ':IOGBounds))
 |#

; #endif

;  cursor description

(defconstant $kTransparentEncoding 0)
(defconstant $kInvertingEncoding 1)

(defconstant $kTransparentEncodingShift 0)
(defconstant $kTransparentEncodedPixel 1)
(defconstant $kInvertingEncodingShift 2)
(defconstant $kInvertingEncodedPixel 4)

(defconstant $kHardwareCursorDescriptorMajorVersion 1)
(defconstant $kHardwareCursorDescriptorMinorVersion 0)
; !
;  * @struct IOHardwareCursorDescriptor
;  * @abstract A structure defining the format of a hardware cursor.
;  * @discussion This structure is used by IOFramebuffer to define the format of a hardware cursor.
;  * @field majorVersion Set to kHardwareCursorDescriptorMajorVersion.
;  * @field minorVersion Set to kHardwareCursorDescriptorMinorVersion.
;  * @field height Maximum size of the cursor.
;  * @field width Maximum size of the cursor.
;  * @field bitDepth Number bits per pixel, or a QD/QT pixel type, for example kIO8IndexedPixelFormat, kIO32ARGBPixelFormat.
;  * @field maskBitDepth Unused.
;  * @field numColors Number of colors for indexed pixel types.
;  * @field colorEncodings An array pointer specifying the pixel values corresponding to the indices into the color table, for indexed pixel types.
;  * @field flags None defined, set to zero.
;  * @field supportedSpecialEncodings Mask of supported special pixel values, eg. kTransparentEncodedPixel, kInvertingEncodedPixel.
;  * @field specialEncodings Array of pixel values for each supported special encoding.
;  
(defrecord IOHardwareCursorDescriptor
   (majorVersion :UInt16)
   (minorVersion :UInt16)
   (height :UInt32)
   (width :UInt32)
   (bitDepth :UInt32)
                                                ;  bits per pixel, or a QD/QT pixel type
   (maskBitDepth :UInt32)
                                                ;  unused
   (numColors :UInt32)
                                                ;  number of colors in the colorMap. ie. 
   (colorEncodings (:pointer :UInt32))
   (flags :UInt32)
   (supportedSpecialEncodings :UInt32)
   (specialEncodings (:array :UInt32 16))
)

;type name? (%define-record :IOHardwareCursorDescriptor (find-record-descriptor ':IOHardwareCursorDescriptor))
;  interrupt types

(defconstant $kIOFBVBLInterruptType :|vbl |)
(defconstant $kIOFBHBLInterruptType :|hbl |)
(defconstant $kIOFBFrameInterruptType :|fram|)  ;  Demand to check configuration (Hardware unchanged)

(defconstant $kIOFBConnectInterruptType :|dci |);  Demand to rebuild (Hardware has reinitialized on dependent change)

(defconstant $kIOFBChangedInterruptType :|chng|);  Demand to remove framebuffer (Hardware not available on dependent change -- but must not buserror)

(defconstant $kIOFBOfflineInterruptType :|remv|);  Notice that hardware is available (after being removed)

(defconstant $kIOFBOnlineInterruptType :|add |)
;  IOAppleTimingID's

(defconstant $kIOTimingIDInvalid 0)             ;   Not a standard timing 

(defconstant $kIOTimingIDApple_FixedRateLCD 42) ;   Lump all fixed-rate LCDs into one category.

(defconstant $kIOTimingIDApple_512x384_60hz #x82);   512x384  (60 Hz) Rubik timing. 

(defconstant $kIOTimingIDApple_560x384_60hz #x87);   560x384  (60 Hz) Rubik-560 timing. 

(defconstant $kIOTimingIDApple_640x480_67hz #x8C);   640x480  (67 Hz) HR timing. 

(defconstant $kIOTimingIDApple_640x400_67hz #x91);   640x400  (67 Hz) HR-400 timing. 

(defconstant $kIOTimingIDVESA_640x480_60hz #x96);   640x480  (60 Hz) VGA timing. 

(defconstant $kIOTimingIDVESA_640x480_72hz #x98);   640x480  (72 Hz) VGA timing. 

(defconstant $kIOTimingIDVESA_640x480_75hz #x9A);   640x480  (75 Hz) VGA timing. 

(defconstant $kIOTimingIDVESA_640x480_85hz #x9E);   640x480  (85 Hz) VGA timing. 

(defconstant $kIOTimingIDGTF_640x480_120hz #x9F);   640x480  (120 Hz) VESA Generalized Timing Formula 

(defconstant $kIOTimingIDApple_640x870_75hz #xA0);   640x870  (75 Hz) FPD timing.

(defconstant $kIOTimingIDApple_640x818_75hz #xA5);   640x818  (75 Hz) FPD-818 timing.

(defconstant $kIOTimingIDApple_832x624_75hz #xAA);   832x624  (75 Hz) GoldFish timing.

(defconstant $kIOTimingIDVESA_800x600_56hz #xB4);   800x600  (56 Hz) SVGA timing. 

(defconstant $kIOTimingIDVESA_800x600_60hz #xB6);   800x600  (60 Hz) SVGA timing. 

(defconstant $kIOTimingIDVESA_800x600_72hz #xB8);   800x600  (72 Hz) SVGA timing. 

(defconstant $kIOTimingIDVESA_800x600_75hz #xBA);   800x600  (75 Hz) SVGA timing. 

(defconstant $kIOTimingIDVESA_800x600_85hz #xBC);   800x600  (85 Hz) SVGA timing. 

(defconstant $kIOTimingIDVESA_1024x768_60hz #xBE);  1024x768  (60 Hz) VESA 1K-60Hz timing. 

(defconstant $kIOTimingIDVESA_1024x768_70hz #xC8);  1024x768  (70 Hz) VESA 1K-70Hz timing. 

(defconstant $kIOTimingIDVESA_1024x768_75hz #xCC);  1024x768  (75 Hz) VESA 1K-75Hz timing (very similar to kIOTimingIDApple_1024x768_75hz). 

(defconstant $kIOTimingIDVESA_1024x768_85hz #xD0);  1024x768  (85 Hz) VESA timing. 

(defconstant $kIOTimingIDApple_1024x768_75hz #xD2);  1024x768  (75 Hz) Apple 19" RGB. 

(defconstant $kIOTimingIDApple_1152x870_75hz #xDC);  1152x870  (75 Hz) Apple 21" RGB. 

(defconstant $kIOTimingIDAppleNTSC_ST #xE6)     ;   512x384  (60 Hz, interlaced, non-convolved). 

(defconstant $kIOTimingIDAppleNTSC_FF #xE8)     ;   640x480  (60 Hz, interlaced, non-convolved). 

(defconstant $kIOTimingIDAppleNTSC_STconv #xEA) ;   512x384  (60 Hz, interlaced, convolved). 

(defconstant $kIOTimingIDAppleNTSC_FFconv #xEC) ;   640x480  (60 Hz, interlaced, convolved). 

(defconstant $kIOTimingIDApplePAL_ST #xEE)      ;   640x480  (50 Hz, interlaced, non-convolved). 

(defconstant $kIOTimingIDApplePAL_FF #xF0)      ;   768x576  (50 Hz, interlaced, non-convolved). 

(defconstant $kIOTimingIDApplePAL_STconv #xF2)  ;   640x480  (50 Hz, interlaced, convolved). 

(defconstant $kIOTimingIDApplePAL_FFconv #xF4)  ;   768x576  (50 Hz, interlaced, convolved). 

(defconstant $kIOTimingIDVESA_1280x960_75hz #xFA);  1280x960  (75 Hz) 

(defconstant $kIOTimingIDVESA_1280x960_60hz #xFC);  1280x960  (60 Hz) 

(defconstant $kIOTimingIDVESA_1280x960_85hz #xFE);  1280x960  (85 Hz) 

(defconstant $kIOTimingIDVESA_1280x1024_60hz #x104);  1280x1024 (60 Hz) 

(defconstant $kIOTimingIDVESA_1280x1024_75hz #x106);  1280x1024 (75 Hz) 

(defconstant $kIOTimingIDVESA_1280x1024_85hz #x10C);  1280x1024 (85 Hz) 

(defconstant $kIOTimingIDVESA_1600x1200_60hz #x118);  1600x1200 (60 Hz) VESA timing. 

(defconstant $kIOTimingIDVESA_1600x1200_65hz #x11A);  1600x1200 (65 Hz) VESA timing. 

(defconstant $kIOTimingIDVESA_1600x1200_70hz #x11C);  1600x1200 (70 Hz) VESA timing. 

(defconstant $kIOTimingIDVESA_1600x1200_75hz #x11E);  1600x1200 (75 Hz) VESA timing (pixel clock is 189.2 Mhz dot clock). 

(defconstant $kIOTimingIDVESA_1600x1200_80hz #x120);  1600x1200 (80 Hz) VESA timing (pixel clock is 216>? Mhz dot clock) - proposed only. 

(defconstant $kIOTimingIDVESA_1600x1200_85hz #x121);  1600x1200 (85 Hz) VESA timing (pixel clock is 229.5 Mhz dot clock). 

(defconstant $kIOTimingIDVESA_1792x1344_60hz #x128);  1792x1344 (60 Hz) VESA timing (204.75 Mhz dot clock). 

(defconstant $kIOTimingIDVESA_1792x1344_75hz #x12A);  1792x1344 (75 Hz) VESA timing (261.75 Mhz dot clock). 

(defconstant $kIOTimingIDVESA_1856x1392_60hz #x12C);  1856x1392 (60 Hz) VESA timing (218.25 Mhz dot clock). 

(defconstant $kIOTimingIDVESA_1856x1392_75hz #x12E);  1856x1392 (75 Hz) VESA timing (288 Mhz dot clock). 

(defconstant $kIOTimingIDVESA_1920x1440_60hz #x130);  1920x1440 (60 Hz) VESA timing (234 Mhz dot clock). 

(defconstant $kIOTimingIDVESA_1920x1440_75hz #x132);  1920x1440 (75 Hz) VESA timing (297 Mhz dot clock). 

(defconstant $kIOTimingIDSMPTE240M_60hz #x190)  ;  60Hz V, 33.75KHz H, interlaced timing, 16:9 aspect, typical resolution of 1920x1035. 

(defconstant $kIOTimingIDFilmRate_48hz #x19A)   ;  48Hz V, 25.20KHz H, non-interlaced timing, typical resolution of 640x480. 

(defconstant $kIOTimingIDSony_1600x1024_76hz #x1F4);  1600x1024 (76 Hz) Sony timing (pixel clock is 170.447 Mhz dot clock). 

(defconstant $kIOTimingIDSony_1920x1080_60hz #x1FE);  1920x1080 (60 Hz) Sony timing (pixel clock is 159.84 Mhz dot clock). 

(defconstant $kIOTimingIDSony_1920x1080_72hz #x208);  1920x1080 (72 Hz) Sony timing (pixel clock is 216.023 Mhz dot clock). 

(defconstant $kIOTimingIDSony_1920x1200_76hz #x21C);  1900x1200 (76 Hz) Sony timing (pixel clock is 243.20 Mhz dot clock). 

(defconstant $kIOTimingIDApple_0x0_0hz_Offline #x226);  Indicates that this timing will take the display off-line and remove it from the system. 

;  framebuffer property keys
(defconstant $kIOFramebufferInfoKey "IOFramebufferInformation")
; #define kIOFramebufferInfoKey		"IOFramebufferInformation"
(defconstant $kIOFBWidthKey "IOFBWidth")
; #define kIOFBWidthKey			"IOFBWidth"
(defconstant $kIOFBHeightKey "IOFBHeight")
; #define kIOFBHeightKey			"IOFBHeight"
(defconstant $kIOFBRefreshRateKey "IOFBRefreshRate")
; #define kIOFBRefreshRateKey		"IOFBRefreshRate"
(defconstant $kIOFBFlagsKey "IOFBFlags")
; #define kIOFBFlagsKey			"IOFBFlags"
(defconstant $kIOFBBytesPerRowKey "IOFBBytesPerRow")
; #define kIOFBBytesPerRowKey		"IOFBBytesPerRow"
(defconstant $kIOFBBytesPerPlaneKey "IOFBBytesPerPlane")
; #define kIOFBBytesPerPlaneKey		"IOFBBytesPerPlane"
(defconstant $kIOFBBitsPerPixelKey "IOFBBitsPerPixel")
; #define kIOFBBitsPerPixelKey		"IOFBBitsPerPixel"
(defconstant $kIOFBComponentCountKey "IOFBComponentCount")
; #define kIOFBComponentCountKey		"IOFBComponentCount"
(defconstant $kIOFBBitsPerComponentKey "IOFBBitsPerComponent")
; #define kIOFBBitsPerComponentKey	"IOFBBitsPerComponent"
(defconstant $kIOFBDetailedTimingsKey "IOFBDetailedTimings")
; #define kIOFBDetailedTimingsKey		"IOFBDetailedTimings"
(defconstant $kIOFBTimingRangeKey "IOFBTimingRange")
; #define kIOFBTimingRangeKey		"IOFBTimingRange"
(defconstant $kIOFBScalerInfoKey "IOFBScalerInfo")
; #define kIOFBScalerInfoKey		"IOFBScalerInfo"
(defconstant $kIOFBCursorInfoKey "IOFBCursorInfo")
; #define kIOFBCursorInfoKey		"IOFBCursorInfo"
(defconstant $kIOFBHostAccessFlagsKey "IOFBHostAccessFlags")
; #define kIOFBHostAccessFlagsKey		"IOFBHostAccessFlags"
(defconstant $kIOFBMemorySizeKey "IOFBMemorySize")
; #define kIOFBMemorySizeKey		"IOFBMemorySize"
(defconstant $kIOFBProbeOptionsKey "IOFBProbeOptions")
; #define kIOFBProbeOptionsKey		"IOFBProbeOptions"
(defconstant $kIOFBGammaWidthKey "IOFBGammaWidth")
; #define kIOFBGammaWidthKey		"IOFBGammaWidth"
(defconstant $kIOFBGammaCountKey "IOFBGammaCount")
; #define kIOFBGammaCountKey		"IOFBGammaCount"
(defconstant $kIOFBCLUTDeferKey "IOFBCLUTDefer")
; #define kIOFBCLUTDeferKey		"IOFBCLUTDefer"
;  diagnostic keys
(defconstant $kIOFBConfigKey "IOFBConfig")
; #define kIOFBConfigKey			"IOFBConfig"
(defconstant $kIOFBModesKey "IOFBModes")
; #define kIOFBModesKey			"IOFBModes"
(defconstant $kIOFBModeIDKey "ID")
; #define kIOFBModeIDKey			"ID"
(defconstant $kIOFBModeDMKey "DM")
; #define kIOFBModeDMKey			"DM"
(defconstant $kIOFBModeTMKey "TM")
; #define kIOFBModeTMKey			"TM"
(defconstant $kIOFBModeAIDKey "AID")
; #define kIOFBModeAIDKey			"AID"
(defconstant $kIOFBModeDFKey "DF")
; #define kIOFBModeDFKey			"DF"
;  display property keys
(defconstant $kIODisplayEDIDKey "IODisplayEDID")
; #define kIODisplayEDIDKey		"IODisplayEDID"
(defconstant $kIODisplayLocationKey "IODisplayLocation")
; #define kIODisplayLocationKey		"IODisplayLocation"		// CFString
(defconstant $kIODisplayConnectFlagsKey "IODisplayConnectFlags")
; #define kIODisplayConnectFlagsKey	"IODisplayConnectFlags"		// CFNumber
(defconstant $kIODisplayHasBacklightKey "IODisplayHasBacklight")
; #define kIODisplayHasBacklightKey	"IODisplayHasBacklight"		// CFBoolean
(defconstant $kIODisplayIsDigitalKey "IODisplayIsDigital")
; #define kIODisplayIsDigitalKey		"IODisplayIsDigital"		// CFBoolean
(defconstant $kDisplayBundleKey "DisplayBundle")
; #define kDisplayBundleKey		"DisplayBundle"
(defconstant $kAppleDisplayTypeKey "AppleDisplayType")
; #define kAppleDisplayTypeKey		"AppleDisplayType"
(defconstant $kAppleSenseKey "AppleSense")
; #define kAppleSenseKey			"AppleSense"

(defconstant $kDisplayVendorIDUnknown :|unkn|)
(defconstant $kDisplayProductIDGeneric #x717)
(defconstant $kDisplayVendorID "DisplayVendorID")
; #define kDisplayVendorID		"DisplayVendorID"	 // CFNumber
(defconstant $kDisplayProductID "DisplayProductID")
; #define kDisplayProductID		"DisplayProductID"	 // CFNumber
(defconstant $kDisplaySerialNumber "DisplaySerialNumber")
; #define kDisplaySerialNumber		"DisplaySerialNumber"	 // CFNumber
(defconstant $kDisplaySerialString "DisplaySerialString")
; #define kDisplaySerialString		"DisplaySerialString"	 // CFString
(defconstant $kDisplayWeekOfManufacture "DisplayWeekManufacture")
; #define kDisplayWeekOfManufacture	"DisplayWeekManufacture" // CFNumber
(defconstant $kDisplayYearOfManufacture "DisplayYearManufacture")
; #define kDisplayYearOfManufacture	"DisplayYearManufacture" // CFNumber
;  CFDictionary of language-locale keys, name values
;  eg. "en"="Color LCD", "en-GB"="Colour LCD"
(defconstant $kDisplayProductName "DisplayProductName")
; #define kDisplayProductName		"DisplayProductName"
;  all CFNumber or CFArray of CFNumber (floats)
(defconstant $kDisplayWhitePointX "DisplayWhitePointX")
; #define kDisplayWhitePointX		"DisplayWhitePointX"
(defconstant $kDisplayWhitePointY "DisplayWhitePointY")
; #define kDisplayWhitePointY		"DisplayWhitePointY"
(defconstant $kDisplayRedPointX "DisplayRedPointX")
; #define kDisplayRedPointX		"DisplayRedPointX"
(defconstant $kDisplayRedPointY "DisplayRedPointY")
; #define kDisplayRedPointY		"DisplayRedPointY"
(defconstant $kDisplayGreenPointX "DisplayGreenPointX")
; #define kDisplayGreenPointX		"DisplayGreenPointX"
(defconstant $kDisplayGreenPointY "DisplayGreenPointY")
; #define kDisplayGreenPointY		"DisplayGreenPointY"
(defconstant $kDisplayBluePointX "DisplayBluePointX")
; #define kDisplayBluePointX		"DisplayBluePointX"
(defconstant $kDisplayBluePointY "DisplayBluePointY")
; #define kDisplayBluePointY		"DisplayBluePointY"
(defconstant $kDisplayWhiteGamma "DisplayWhiteGamma")
; #define kDisplayWhiteGamma		"DisplayWhiteGamma"
(defconstant $kDisplayRedGamma "DisplayRedGamma")
; #define kDisplayRedGamma		"DisplayRedGamma"
(defconstant $kDisplayGreenGamma "DisplayGreenGamma")
; #define kDisplayGreenGamma		"DisplayGreenGamma"
(defconstant $kDisplayBlueGamma "DisplayBlueGamma")
; #define kDisplayBlueGamma		"DisplayBlueGamma"
;  Display gamma
(defconstant $kDisplayGammaChannels "DisplayGammaChannels")
; #define kDisplayGammaChannels		"DisplayGammaChannels" 	  // CFNumber 1 or 3 channel count
(defconstant $kDisplayGammaEntryCount "DisplayGammaEntryCount")
; #define kDisplayGammaEntryCount		"DisplayGammaEntryCount"  // CFNumber 1-based count of entries per channel
(defconstant $kDisplayGammaEntrySize "DisplayGammaEntrySize")
; #define kDisplayGammaEntrySize		"DisplayGammaEntrySize"	  // CFNumber size in bytes of each table entry
(defconstant $kDisplayGammaTable "DisplayGammaTable")
; #define kDisplayGammaTable		"DisplayGammaTable" 	  // CFData
;  CFBoolean
(defconstant $kDisplayBrightnessAffectsGamma "DisplayBrightnessAffectsGamma")
; #define kDisplayBrightnessAffectsGamma	"DisplayBrightnessAffectsGamma"
(defconstant $kDisplayViewAngleAffectsGamma "DisplayViewAngleAffectsGamma")
; #define kDisplayViewAngleAffectsGamma	"DisplayViewAngleAffectsGamma"
;  CFData
(defconstant $kDisplayCSProfile "DisplayCSProfile")
; #define kDisplayCSProfile		"DisplayCSProfile"
;  CFNumber
(defconstant $kDisplayHorizontalImageSize "DisplayHorizontalImageSize")
; #define kDisplayHorizontalImageSize	"DisplayHorizontalImageSize"
(defconstant $kDisplayVerticalImageSize "DisplayVerticalImageSize")
; #define kDisplayVerticalImageSize	"DisplayVerticalImageSize"
;  Pixel description
;  CFBoolean
(defconstant $kDisplayFixedPixelFormat "DisplayFixedPixelFormat")
; #define kDisplayFixedPixelFormat	"DisplayFixedPixelFormat"

(defconstant $kDisplaySubPixelLayoutUndefined 0)
(defconstant $kDisplaySubPixelLayoutRGB 1)
(defconstant $kDisplaySubPixelLayoutBGR 2)
(defconstant $kDisplaySubPixelLayoutQuadGBL 3)
(defconstant $kDisplaySubPixelLayoutQuadGBR 4)
(defconstant $kDisplaySubPixelConfigurationUndefined 0)
(defconstant $kDisplaySubPixelConfigurationDelta 1)
(defconstant $kDisplaySubPixelConfigurationStripe 2)
(defconstant $kDisplaySubPixelConfigurationStripeOffset 3)
(defconstant $kDisplaySubPixelConfigurationQuad 4)
(defconstant $kDisplaySubPixelShapeUndefined 0)
(defconstant $kDisplaySubPixelShapeRound 1)
(defconstant $kDisplaySubPixelShapeSquare 2)
(defconstant $kDisplaySubPixelShapeRectangular 3)
(defconstant $kDisplaySubPixelShapeOval 4)
(defconstant $kDisplaySubPixelShapeElliptical 5)
;  CFNumbers
(defconstant $kDisplaySubPixelLayout "DisplaySubPixelLayout")
; #define kDisplaySubPixelLayout		"DisplaySubPixelLayout"
(defconstant $kDisplaySubPixelConfiguration "DisplaySubPixelConfiguration")
; #define kDisplaySubPixelConfiguration	"DisplaySubPixelConfiguration"
(defconstant $kDisplaySubPixelShape "DisplaySubPixelShape")
; #define kDisplaySubPixelShape		"DisplaySubPixelShape"
;  Display parameters
(defconstant $kIODisplayParametersKey "IODisplayParameters")
; #define kIODisplayParametersKey		"IODisplayParameters"
(defconstant $kIODisplayGUIDKey "IODisplayGUID")
; #define kIODisplayGUIDKey		"IODisplayGUID"
(defconstant $kIODisplayValueKey "value")
; #define kIODisplayValueKey		"value"
(defconstant $kIODisplayMinValueKey "min")
; #define kIODisplayMinValueKey		"min"
(defconstant $kIODisplayMaxValueKey "max")
; #define kIODisplayMaxValueKey		"max"
(defconstant $kIODisplayBrightnessKey "brightness")
; #define kIODisplayBrightnessKey		"brightness"
(defconstant $kIODisplayContrastKey "contrast")
; #define kIODisplayContrastKey		"contrast"
(defconstant $kIODisplayHorizontalPositionKey "horizontal-position")
; #define kIODisplayHorizontalPositionKey	"horizontal-position"
(defconstant $kIODisplayHorizontalSizeKey "horizontal-size")
; #define kIODisplayHorizontalSizeKey	"horizontal-size"
(defconstant $kIODisplayVerticalPositionKey "vertical-position")
; #define kIODisplayVerticalPositionKey	"vertical-position"
(defconstant $kIODisplayVerticalSizeKey "vertical-size")
; #define kIODisplayVerticalSizeKey	"vertical-size"
(defconstant $kIODisplayTrapezoidKey "trapezoid")
; #define kIODisplayTrapezoidKey		"trapezoid"
(defconstant $kIODisplayPincushionKey "pincushion")
; #define kIODisplayPincushionKey		"pincushion"
(defconstant $kIODisplayParallelogramKey "parallelogram")
; #define kIODisplayParallelogramKey	"parallelogram"
(defconstant $kIODisplayRotationKey "rotation")
; #define kIODisplayRotationKey		"rotation"
(defconstant $kIODisplayTheatreModeKey "theatre-mode")
; #define kIODisplayTheatreModeKey	"theatre-mode"
(defconstant $kIODisplayTheatreModeWindowKey "theatre-mode-window")
; #define kIODisplayTheatreModeWindowKey	"theatre-mode-window"
(defconstant $kIODisplayOverscanKey "oscn")
; #define kIODisplayOverscanKey		"oscn"
(defconstant $kIODisplayVideoBestKey "vbst")
; #define kIODisplayVideoBestKey		"vbst"
(defconstant $kIODisplayParametersCommitKey "commit")
; #define kIODisplayParametersCommitKey	"commit"
(defconstant $kIODisplayParametersDefaultKey "defaults")
; #define kIODisplayParametersDefaultKey	"defaults"
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* ! _IOKIT_IOGRAPHICSTYPES_H */


(provide-interface "IOGraphicsTypes")