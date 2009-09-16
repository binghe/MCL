(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CMApplication.h"
; at Sunday July 2,2006 7:24:22 pm.
; 
;      File:       ColorSync/CMApplication.h
;  
;      Contains:   Color Matching Interfaces
;  
;      Version:    ColorSync-118.2~1
;  
;      Copyright:  © 1992-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CMAPPLICATION__
; #define __CMAPPLICATION__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __CMICCPROFILE__

(require-interface "ColorSync/CMICCProfile")

; #endif

; #ifndef __CMTYPES__
#| #|
#include <ColorSyncCMTypes.h>
#endif
|#
 |#
(defconstant $_DECLARE_CS_QD_API_ 0)
; #define _DECLARE_CS_QD_API_ 0

; #if TARGET_OS_WIN32
#| 
(require-interface "windows")
 |#

; #endif


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

(defconstant $kDefaultCMMSignature :|appl|)
;  Macintosh 68K trap word 

(defconstant $cmTrap #xABEE)
;  PicComment IDs 

(defconstant $cmBeginProfile #xDC)
(defconstant $cmEndProfile #xDD)
(defconstant $cmEnableMatching #xDE)
(defconstant $cmDisableMatching #xDF)
(defconstant $cmComment #xE0)
;  PicComment selectors for cmComment 

(defconstant $cmBeginProfileSel 0)
(defconstant $cmContinueProfileSel 1)
(defconstant $cmEndProfileSel 2)
(defconstant $cmProfileIdentifierSel 3)
;  Defines for version 1.0 CMProfileSearchRecord.fieldMask 

(defconstant $cmMatchCMMType 1)
(defconstant $cmMatchApplProfileVersion 2)
(defconstant $cmMatchDataType 4)
(defconstant $cmMatchDeviceType 8)
(defconstant $cmMatchDeviceManufacturer 16)
(defconstant $cmMatchDeviceModel 32)
(defconstant $cmMatchDeviceAttributes 64)
(defconstant $cmMatchFlags #x80)
(defconstant $cmMatchOptions #x100)
(defconstant $cmMatchWhite #x200)
(defconstant $cmMatchBlack #x400)
;  Defines for version 2.0 CMSearchRecord.searchMask 

(defconstant $cmMatchAnyProfile 0)
(defconstant $cmMatchProfileCMMType 1)
(defconstant $cmMatchProfileClass 2)
(defconstant $cmMatchDataColorSpace 4)
(defconstant $cmMatchProfileConnectionSpace 8)
(defconstant $cmMatchManufacturer 16)
(defconstant $cmMatchModel 32)
(defconstant $cmMatchAttributes 64)
(defconstant $cmMatchProfileFlags #x80)
;  Flags for PostScript-related functions 

(defconstant $cmPS7bit 1)
(defconstant $cmPS8bit 2)
;  Flags for profile embedding functions 

(defconstant $cmEmbedWholeProfile 0)
(defconstant $cmEmbedProfileIdentifier 1)
;  Commands for CMFlattenUPP() 

(defconstant $cmOpenReadSpool 1)
(defconstant $cmOpenWriteSpool 2)
(defconstant $cmReadSpool 3)
(defconstant $cmWriteSpool 4)
(defconstant $cmCloseSpool 5)
;  Commands for CMAccessUPP() 

(defconstant $cmOpenReadAccess 1)
(defconstant $cmOpenWriteAccess 2)
(defconstant $cmReadAccess 3)
(defconstant $cmWriteAccess 4)
(defconstant $cmCloseAccess 5)
(defconstant $cmCreateNewAccess 6)
(defconstant $cmAbortWriteAccess 7)
(defconstant $cmBeginAccess 8)
(defconstant $cmEndAccess 9)
;  Use types for CMGet/SetDefaultProfileByUse() 

(defconstant $cmInputUse :|inpt|)
(defconstant $cmOutputUse :|outp|)
(defconstant $cmDisplayUse :|dply|)
(defconstant $cmProofUse :|pruf|)
;  Union of 1.0 2.0, and 4.0 profile header variants 
(defrecord CMAppleProfileHeader
   (:variant
   (
   (cm1 :CMHeader)
   )
   (
   (cm2 :CM2Header)
   )
   (
   (cm4 :CM4Header)
   )
   )
)

;type name? (%define-record :CMAppleProfileHeader (find-record-descriptor ':CMAppleProfileHeader))
;  CWConcatColorWorld() definitions 
(defrecord CMConcatProfileSet
   (keyIndex :UInt16)                           ;  Zero-based 
   (count :UInt16)                              ;  Min 1 
   (profileSet (:array (POINTER OPAQUECMPROFILEREF) 1));  Variable. Ordered from Source -> Dest 
)

;type name? (%define-record :CMConcatProfileSet (find-record-descriptor ':CMConcatProfileSet))
;  NCWConcatColorWorld() definitions 
(defrecord NCMConcatProfileSpec
   (renderingIntent :UInt32)                    ;  renderingIntent override 
   (transformTag :UInt32)                       ;  transform enumerations defined below 
   (profile (:pointer :OpaqueCMProfileRef))     ;  profile 
)

;type name? (%define-record :NCMConcatProfileSpec (find-record-descriptor ':NCMConcatProfileSpec))
(defrecord NCMConcatProfileSet
   (cmm :OSType)                                ;  e.g. 'KCMS', 'appl', ...  uniquely ids the cmm, or 0000 
   (flags :UInt32)                              ;  specify quality, lookup only, no gamut checking ... 
   (flagsMask :UInt32)                          ;  which bits of 'flags' to use to override profile 
   (profileCount :UInt32)                       ;  how many ProfileSpecs in the following set 
   (profileSpecs (:array :NCMConcatProfileSpec 1));  Variable. Ordered from Source -> Dest 
)

;type name? (%define-record :NCMConcatProfileSet (find-record-descriptor ':NCMConcatProfileSet))

(defconstant $kNoTransform 0)                   ;  Not used 

(defconstant $kUseAtoB 1)                       ;  Use 'A2B*' tag from this profile or equivalent 

(defconstant $kUseBtoA 2)                       ;  Use 'B2A*' tag from this profile or equivalent 

(defconstant $kUseBtoB 3)                       ;  Use 'pre*' tag from this profile or equivalent 
;  For typical device profiles the following synonyms may be useful 

(defconstant $kDeviceToPCS 1)                   ;  Device Dependent to Device Independent 

(defconstant $kPCSToDevice 2)                   ;  Device Independent to Device Dependent 

(defconstant $kPCSToPCS 3)                      ;  Independent, through device's gamut 
;  For renderingIntent in NCMConcatProfileSpec    

(defconstant $kUseProfileIntent #xFFFFFFFF)
;  ColorSync color data types 
(defrecord CMRGBColor
   (red :UInt16)                                ;  0..65535 
   (green :UInt16)
   (blue :UInt16)
)

;type name? (%define-record :CMRGBColor (find-record-descriptor ':CMRGBColor))
(defrecord CMCMYKColor
   (cyan :UInt16)                               ;  0..65535 
   (magenta :UInt16)
   (yellow :UInt16)
   (black :UInt16)
)

;type name? (%define-record :CMCMYKColor (find-record-descriptor ':CMCMYKColor))
(defrecord CMCMYColor
   (cyan :UInt16)                               ;  0..65535 
   (magenta :UInt16)
   (yellow :UInt16)
)

;type name? (%define-record :CMCMYColor (find-record-descriptor ':CMCMYColor))
(defrecord CMHLSColor
   (hue :UInt16)                                ;  0..65535. Fraction of circle. Red at 0 
   (lightness :UInt16)                          ;  0..65535 
   (saturation :UInt16)                         ;  0..65535 
)

;type name? (%define-record :CMHLSColor (find-record-descriptor ':CMHLSColor))
(defrecord CMHSVColor
   (hue :UInt16)                                ;  0..65535. Fraction of circle. Red at 0 
   (saturation :UInt16)                         ;  0..65535 
   (value :UInt16)                              ;  0..65535 
)

;type name? (%define-record :CMHSVColor (find-record-descriptor ':CMHSVColor))
(defrecord CMLabColor
   (L :UInt16)                                  ;  0..65535 maps to 0..100 
   (a :UInt16)                                  ;  0..65535 maps to -128..127.996 
   (b :UInt16)                                  ;  0..65535 maps to -128..127.996 
)

;type name? (%define-record :CMLabColor (find-record-descriptor ':CMLabColor))
(defrecord CMLuvColor
   (L :UInt16)                                  ;  0..65535 maps to 0..100 
   (u :UInt16)                                  ;  0..65535 maps to -128..127.996 
   (v :UInt16)                                  ;  0..65535 maps to -128..127.996 
)

;type name? (%define-record :CMLuvColor (find-record-descriptor ':CMLuvColor))
(defrecord CMYxyColor
   (capY :UInt16)                               ;  0..65535 maps to 0..1 
   (x :UInt16)                                  ;  0..65535 maps to 0..1 
   (y :UInt16)                                  ;  0..65535 maps to 0..1 
)

;type name? (%define-record :CMYxyColor (find-record-descriptor ':CMYxyColor))
(defrecord CMGrayColor
   (gray :UInt16)                               ;  0..65535 
)

;type name? (%define-record :CMGrayColor (find-record-descriptor ':CMGrayColor))
(defrecord CMMultichannel5Color
   (components (:array :UInt8 5))               ;  0..255 
)

;type name? (%define-record :CMMultichannel5Color (find-record-descriptor ':CMMultichannel5Color))
(defrecord CMMultichannel6Color
   (components (:array :UInt8 6))               ;  0..255 
)

;type name? (%define-record :CMMultichannel6Color (find-record-descriptor ':CMMultichannel6Color))
(defrecord CMMultichannel7Color
   (components (:array :UInt8 7))               ;  0..255 
)

;type name? (%define-record :CMMultichannel7Color (find-record-descriptor ':CMMultichannel7Color))
(defrecord CMMultichannel8Color
   (components (:array :UInt8 8))               ;  0..255 
)

;type name? (%define-record :CMMultichannel8Color (find-record-descriptor ':CMMultichannel8Color))
(defrecord CMNamedColor
   (namedColorIndex :UInt32)                    ;  0..a lot 
)

;type name? (%define-record :CMNamedColor (find-record-descriptor ':CMNamedColor))
(defrecord CMColor
   (:variant
   (
   (rgb :CMRGBColor)
   )
   (
   (hsv :CMHSVColor)
   )
   (
   (hls :CMHLSColor)
   )
   (
   (XYZ :CMXYZColor)
   )
   (
   (Lab :CMLabColor)
   )
   (
   (Luv :CMLuvColor)
   )
   (
   (Yxy :CMYxyColor)
   )
   (
   (cmyk :CMCMYKColor)
   )
   (
   (cmy :CMCMYColor)
   )
   (
   (gray :CMGrayColor)
   )
   (
   (mc5 :CMMultichannel5Color)
   )
   (
   (mc6 :CMMultichannel6Color)
   )
   (
   (mc7 :CMMultichannel7Color)
   )
   (
   (mc8 :CMMultichannel8Color)
   )
   (
   (namedColor :CMNamedColor)
   )
   )
)

;type name? (%define-record :CMColor (find-record-descriptor ':CMColor))
;  GetIndexedProfile() search definition 
(defrecord CMProfileSearchRecord
   (header :CMHeader)
   (fieldMask :UInt32)
   (reserved (:array :UInt32 2))
)

;type name? (%define-record :CMProfileSearchRecord (find-record-descriptor ':CMProfileSearchRecord))

(def-mactype :CMProfileSearchRecordPtr (find-mactype '(:pointer :CMProfileSearchRecord)))

(def-mactype :CMProfileSearchRecordHandle (find-mactype '(:handle :CMProfileSearchRecord)))
;  CMNewProfileSearch() search definition 
(defrecord CMSearchRecord
   (CMMType :OSType)
   (profileClass :OSType)
   (dataColorSpace :OSType)
   (profileConnectionSpace :OSType)
   (deviceManufacturer :UInt32)
   (deviceModel :UInt32)
   (deviceAttributes (:array :UInt32 2))
   (profileFlags :UInt32)
   (searchMask :UInt32)
   (filter (:pointer :OpaqueCMProfileFilterProcPtr))
)

;type name? (%define-record :CMSearchRecord (find-record-descriptor ':CMSearchRecord))
;  CMMIterateUPP() structure 
(defrecord CMMInfo
   (dataSize :UInt32)                           ;  Size of this structure - compatibility
   (CMMType :OSType)                            ;  Signature, e.g. 'appl', 'HDM ' or 'KCMS'
   (CMMMfr :OSType)                             ;  Vendor, e.g. 'appl'
   (CMMVersion :UInt32)                         ;  CMM version number
   (ASCIIName (:array :UInt8 32))               ;  pascal string - name
   (ASCIIDesc (:array :UInt8 256))              ;  pascal string - description or copyright
   (UniCodeNameCount :UInt32)                   ;  count of UniChars in following array
   (UniCodeName (:array :UInt16 32))            ;  the name in UniCode chars
   (UniCodeDescCount :UInt32)                   ;  count of UniChars in following array
   (UniCodeDesc (:array :UInt16 256))           ;  the description in UniCode chars
)

;type name? (%define-record :CMMInfo (find-record-descriptor ':CMMInfo))
;  GetCWInfo() structures 
(defrecord CMMInfoRecord
   (CMMType :OSType)
   (CMMVersion :signed-long)
)

;type name? (%define-record :CMMInfoRecord (find-record-descriptor ':CMMInfoRecord))
(defrecord CMCWInfoRecord
   (cmmCount :UInt32)
   (cmmInfo (:array :CMMInfoRecord 2))
)

;type name? (%define-record :CMCWInfoRecord (find-record-descriptor ':CMCWInfoRecord))
;  profile identifier structures 
(defrecord CMProfileIdentifier
   (profileHeader :CM2Header)
   (calibrationDate :CMDateTime)
   (ASCIIProfileDescriptionLen :UInt32)
   (ASCIIProfileDescription (:array :character 1));  variable length 
)

;type name? (%define-record :CMProfileIdentifier (find-record-descriptor ':CMProfileIdentifier))

(def-mactype :CMProfileIdentifierPtr (find-mactype '(:pointer :CMProfileIdentifier)))
;  colorspace masks 

(defconstant $cmColorSpaceSpaceMask 63)
(defconstant $cmColorSpacePremulAlphaMask 64)
(defconstant $cmColorSpaceAlphaMask #x80)
(defconstant $cmColorSpaceSpaceAndAlphaMask #xFF)
(defconstant $cmColorSpacePackingMask #xFF00)
(defconstant $cmColorSpaceEncodingMask #xF0000)
(defconstant $cmColorSpaceReservedMask #xFFF00000)
;  packing formats 

(defconstant $cmNoColorPacking 0)
(defconstant $cmWord5ColorPacking #x500)
(defconstant $cmWord565ColorPacking #x600)
(defconstant $cmLong8ColorPacking #x800)
(defconstant $cmLong10ColorPacking #xA00)
(defconstant $cmAlphaFirstPacking #x1000)
(defconstant $cmOneBitDirectPacking #xB00)
(defconstant $cmAlphaLastPacking 0)
(defconstant $cm8_8ColorPacking #x2800)
(defconstant $cm16_8ColorPacking #x2000)
(defconstant $cm24_8ColorPacking #x2100)
(defconstant $cm32_8ColorPacking #x800)
(defconstant $cm40_8ColorPacking #x2200)
(defconstant $cm48_8ColorPacking #x2300)
(defconstant $cm56_8ColorPacking #x2400)
(defconstant $cm64_8ColorPacking #x2500)
(defconstant $cm32_16ColorPacking #x2600)
(defconstant $cm48_16ColorPacking #x2900)
(defconstant $cm64_16ColorPacking #x2A00)
(defconstant $cm32_32ColorPacking #x2700)
(defconstant $cmLittleEndianPacking #x4000)
(defconstant $cmReverseChannelPacking #x8000)
;  channel encoding format 

(defconstant $cmSRGB16ChannelEncoding #x10000)  ;  used for sRGB64 encoding ( ±3.12 format)

;  general colorspaces 

(defconstant $cmNoSpace 0)
(defconstant $cmRGBSpace 1)
(defconstant $cmCMYKSpace 2)
(defconstant $cmHSVSpace 3)
(defconstant $cmHLSSpace 4)
(defconstant $cmYXYSpace 5)
(defconstant $cmXYZSpace 6)
(defconstant $cmLUVSpace 7)
(defconstant $cmLABSpace 8)
(defconstant $cmReservedSpace1 9)
(defconstant $cmGraySpace 10)
(defconstant $cmReservedSpace2 11)
(defconstant $cmGamutResultSpace 12)
(defconstant $cmNamedIndexedSpace 16)
(defconstant $cmMCFiveSpace 17)
(defconstant $cmMCSixSpace 18)
(defconstant $cmMCSevenSpace 19)
(defconstant $cmMCEightSpace 20)
(defconstant $cmAlphaPmulSpace 64)
(defconstant $cmAlphaSpace #x80)
(defconstant $cmRGBASpace #x81)
(defconstant $cmGrayASpace #x8A)
(defconstant $cmRGBAPmulSpace #xC1)
(defconstant $cmGrayAPmulSpace #xCA)
;  supported CMBitmapColorSpaces - Each of the following is a 
;  combination of a general colospace and a packing formats. 
;  Each can also be or'd with cmReverseChannelPacking. 

(defconstant $cmGray8Space #x280A)
(defconstant $cmGray16Space 10)
(defconstant $cmGray16LSpace #x400A)
(defconstant $cmGrayA16Space #x208A)
(defconstant $cmGrayA32Space #x8A)
(defconstant $cmGrayA32LSpace #x408A)
(defconstant $cmGrayA16PmulSpace #x20CA)
(defconstant $cmGrayA32PmulSpace #xCA)
(defconstant $cmGrayA32LPmulSpace #x40CA)
(defconstant $cmRGB16Space #x501)
(defconstant $cmRGB16LSpace #x4501)
(defconstant $cmRGB565Space #x601)
(defconstant $cmRGB565LSpace #x4601)
(defconstant $cmRGB24Space #x2101)
(defconstant $cmRGB32Space #x801)
(defconstant $cmRGB48Space #x2901)
(defconstant $cmRGB48LSpace #x6901)
(defconstant $cmARGB32Space #x1881)
(defconstant $cmARGB64Space #x3A81)
(defconstant $cmARGB64LSpace #x7A81)
(defconstant $cmRGBA32Space #x881)
(defconstant $cmRGBA64Space #x2A81)
(defconstant $cmRGBA64LSpace #x6A81)
(defconstant $cmARGB32PmulSpace #x18C1)
(defconstant $cmARGB64PmulSpace #x3AC1)
(defconstant $cmARGB64LPmulSpace #x7AC1)
(defconstant $cmRGBA32PmulSpace #x8C1)
(defconstant $cmRGBA64PmulSpace #x2AC1)
(defconstant $cmRGBA64LPmulSpace #x6AC1)
(defconstant $cmCMYK32Space #x802)
(defconstant $cmCMYK64Space #x2A02)
(defconstant $cmCMYK64LSpace #x6A02)
(defconstant $cmHSV32Space #xA03)
(defconstant $cmHLS32Space #xA04)
(defconstant $cmYXY32Space #xA05)
(defconstant $cmXYZ24Space #x2106)
(defconstant $cmXYZ32Space #xA06)
(defconstant $cmXYZ48Space #x2906)
(defconstant $cmXYZ48LSpace #x6906)
(defconstant $cmLUV32Space #xA07)
(defconstant $cmLAB24Space #x2108)
(defconstant $cmLAB32Space #xA08)
(defconstant $cmLAB48Space #x2908)
(defconstant $cmLAB48LSpace #x6908)
(defconstant $cmGamutResult1Space #xB0C)
(defconstant $cmNamedIndexed32Space #x2710)
(defconstant $cmNamedIndexed32LSpace #x6710)
(defconstant $cmMCFive8Space #x2211)
(defconstant $cmMCSix8Space #x2312)
(defconstant $cmMCSeven8Space #x2413)
(defconstant $cmMCEight8Space #x2514)

(def-mactype :CMBitmapColorSpace (find-mactype ':UInt32))
(defrecord CMBitmap
   (image (:pointer :char))
   (width :signed-long)
   (height :signed-long)
   (rowBytes :signed-long)
   (pixelSize :signed-long)
   (space :UInt32)
   (user1 :signed-long)
   (user2 :signed-long)
)

;type name? (%define-record :CMBitmap (find-record-descriptor ':CMBitmap))
;  CMConvertXYZToXYZ() definitions 

(def-mactype :CMChromaticAdaptation (find-mactype ':UInt32))

(defconstant $cmUseDefaultChromaticAdaptation 0)
(defconstant $cmLinearChromaticAdaptation 1)
(defconstant $cmVonKriesChromaticAdaptation 2)
(defconstant $cmBradfordChromaticAdaptation 3)
;  Profile Locations 

(defconstant $CS_MAX_PATH #x100)

(defconstant $cmNoProfileBase 0)
(defconstant $cmFileBasedProfile 1)
(defconstant $cmHandleBasedProfile 2)
(defconstant $cmPtrBasedProfile 3)
(defconstant $cmProcedureBasedProfile 4)
(defconstant $cmPathBasedProfile 5)
(defconstant $cmBufferBasedProfile 6)
(defrecord CMFileLocation
   (spec :FSSpec)
)

;type name? (%define-record :CMFileLocation (find-record-descriptor ':CMFileLocation))
(defrecord CMHandleLocation
   (h :Handle)
)

;type name? (%define-record :CMHandleLocation (find-record-descriptor ':CMHandleLocation))
(defrecord CMPtrLocation
   (p :pointer)
)

;type name? (%define-record :CMPtrLocation (find-record-descriptor ':CMPtrLocation))
(defrecord CMProcedureLocation
   (proc (:pointer :OpaqueCMProfileAccessProcPtr))
   (refCon :pointer)
)

;type name? (%define-record :CMProcedureLocation (find-record-descriptor ':CMProcedureLocation))
(defrecord CMPathLocation
   (path (:array :character 256))
)

;type name? (%define-record :CMPathLocation (find-record-descriptor ':CMPathLocation))
(defrecord CMBufferLocation
   (buffer :pointer)
   (size :UInt32)
)

;type name? (%define-record :CMBufferLocation (find-record-descriptor ':CMBufferLocation))
(defrecord CMProfLoc
   (:variant
   (
   (fileLoc :CMFileLocation)
   )
   (
   (handleLoc :CMHandleLocation)
   )
   (
   (ptrLoc :CMPtrLocation)
   )
   (
   (procLoc :CMProcedureLocation)
   )
   (
   (pathLoc :CMPathLocation)
   )
   (
   (bufferLoc :CMBufferLocation)
   )
   )
)

;type name? (%define-record :CMProfLoc (find-record-descriptor ':CMProfLoc))
(defrecord CMProfileLocation
   (locType :SInt16)
   (u :CMProfLoc)
)

;type name? (%define-record :CMProfileLocation (find-record-descriptor ':CMProfileLocation))

(defconstant $cmOriginalProfileLocationSize 72)
(defconstant $cmCurrentProfileLocationSize #x102)
;  Struct and enums used for Profile iteration 

(defconstant $cmProfileIterateDataVersion1 #x10000)
(defconstant $cmProfileIterateDataVersion2 #x20000);  Added makeAndModel

(defconstant $cmProfileIterateDataVersion3 #x30000);  Added MD5 digest

(defrecord CMProfileIterateData
   (dataVersion :UInt32)                        ;  cmProfileIterateDataVersion2 
   (header :CM2Header)
   (code :SInt16)
   (name (:string 255))
   (location :CMProfileLocation)
   (uniCodeNameCount :UInt32)
   (uniCodeName (:pointer :UniChar))
   (asciiName (:pointer :UInt8))
   (makeAndModel (:pointer :CMMakeAndModel))
   (digest (:pointer :CMProfileMD5))            ;  Derived from the RSA Data Security, Inc. MD5 Message-Digest Algorithm 
)

;type name? (%define-record :CMProfileIterateData (find-record-descriptor ':CMProfileIterateData))
;  Caller-supplied callback function for Profile & CMM iteration 

(def-mactype :CMProfileIterateProcPtr (find-mactype ':pointer)); (CMProfileIterateData * iterateData , void * refCon)

(def-mactype :CMMIterateProcPtr (find-mactype ':pointer)); (CMMInfo * iterateData , void * refCon)

(def-mactype :CMProfileIterateUPP (find-mactype '(:pointer :OpaqueCMProfileIterateProcPtr)))

(def-mactype :CMMIterateUPP (find-mactype '(:pointer :OpaqueCMMIterateProcPtr)))
; 
;  *  NewCMProfileIterateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCMProfileIterateUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCMProfileIterateProcPtr)
() )
; 
;  *  NewCMMIterateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCMMIterateUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCMMIterateProcPtr)
() )
; 
;  *  DisposeCMProfileIterateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCMProfileIterateUPP" 
   ((userUPP (:pointer :OpaqueCMProfileIterateProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCMMIterateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCMMIterateUPP" 
   ((userUPP (:pointer :OpaqueCMMIterateProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeCMProfileIterateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCMProfileIterateUPP" 
   ((iterateData (:pointer :CMProfileIterateData))
    (refCon :pointer)
    (userUPP (:pointer :OpaqueCMProfileIterateProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeCMMIterateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCMMIterateUPP" 
   ((iterateData (:pointer :CMMInfo))
    (refCon :pointer)
    (userUPP (:pointer :OpaqueCMMIterateProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;     Clients can register for notifications of ColorSync preference changes by
;   using the kCMPrefsChangedNotification key. This notification will be sent if the
;    user changes ColorSync preferences such as:
;         the default profile by colors space, (CMSetDefaultProfileBySpace)
;       the default profile by device useage, (CMSetDefaultProfileByUse)
;        or the preferred CMM.
;   See <CMDeviceIntegration.h> for more notifications that can be sent.
; 
; #define kCMPrefsChangedNotification     CFSTR("AppleColorSyncPreferencesChangedNotification")
;  Profile file and element access 
; 
;  *  CMNewProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMNewProfile" 
   ((prof (:pointer :CMPROFILEREF))
    (theProfile (:pointer :CMProfileLocation))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMOpenProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMOpenProfile" 
   ((prof (:pointer :CMPROFILEREF))
    (theProfile (:pointer :CMProfileLocation))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMCloseProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMCloseProfile" 
   ((prof (:pointer :OpaqueCMProfileRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMUpdateProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMUpdateProfile" 
   ((prof (:pointer :OpaqueCMProfileRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMCopyProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMCopyProfile" 
   ((targetProf (:pointer :CMPROFILEREF))
    (targetLocation (:pointer :CMProfileLocation))
    (srcProf (:pointer :OpaqueCMProfileRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMValidateProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMValidateProfile" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (valid (:pointer :Boolean))
    (preferredCMMnotfound (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetProfileLocation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMGetProfileLocation" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (theProfile (:pointer :CMProfileLocation))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NCMGetProfileLocation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
;  

(deftrap-inline "_NCMGetProfileLocation" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (theProfile (:pointer :CMProfileLocation))
    (locationSize (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMFlattenProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMFlattenProfile" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (flags :UInt32)
    (proc (:pointer :OpaqueCMFlattenProcPtr))
    (refCon :pointer)
    (preferredCMMnotfound (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMUnflattenProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  
; 
;  *  CMGetProfileHeader()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMGetProfileHeader" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (header (:pointer :CMAppleProfileHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMSetProfileHeader()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMSetProfileHeader" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (header (:pointer :CMAppleProfileHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMProfileElementExists()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMProfileElementExists" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (tag :OSType)
    (found (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMCountProfileElements()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMCountProfileElements" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (elementCount (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetProfileElement()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMGetProfileElement" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (tag :OSType)
    (elementSize (:pointer :UInt32))
    (elementData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMSetProfileElement()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMSetProfileElement" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (tag :OSType)
    (elementSize :UInt32)
    (elementData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMSetProfileElementSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMSetProfileElementSize" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (tag :OSType)
    (elementSize :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMSetProfileElementReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMSetProfileElementReference" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (elementTag :OSType)
    (referenceTag :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetPartialProfileElement()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMGetPartialProfileElement" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (tag :OSType)
    (offset :UInt32)
    (byteCount (:pointer :UInt32))
    (elementData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMSetPartialProfileElement()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMSetPartialProfileElement" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (tag :OSType)
    (offset :UInt32)
    (byteCount :UInt32)
    (elementData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetIndProfileElementInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMGetIndProfileElementInfo" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (index :UInt32)
    (tag (:pointer :OSType))
    (elementSize (:pointer :UInt32))
    (refs (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetIndProfileElement()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMGetIndProfileElement" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (index :UInt32)
    (elementSize (:pointer :UInt32))
    (elementData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMRemoveProfileElement()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMRemoveProfileElement" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (tag :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetScriptProfileDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMGetScriptProfileDescription" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (name (:pointer :STR255))
    (code (:pointer :SCRIPTCODE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetProfileDescriptions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
;  

(deftrap-inline "_CMGetProfileDescriptions" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (aName (:pointer :char))
    (aCount (:pointer :UInt32))
    (mName (:pointer :STR255))
    (mCode (:pointer :SCRIPTCODE))
    (uName (:pointer :UniChar))
    (uCount (:pointer :UniCharCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMSetProfileDescriptions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
;  

(deftrap-inline "_CMSetProfileDescriptions" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (aName (:pointer :char))
    (aCount :UInt32)
    (mName (:pointer :STR255))
    (mCode :SInt16)
    (uName (:pointer :UniChar))
    (uCount :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMCopyProfileLocalizedStringDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in ColorSyncLib 3.1 and later
;  

(deftrap-inline "_CMCopyProfileLocalizedStringDictionary" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (tag :OSType)
    (theDict (:pointer :CFDictionaryRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMSetProfileLocalizedStringDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in ColorSyncLib 3.1 and later
;  

(deftrap-inline "_CMSetProfileLocalizedStringDictionary" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (tag :OSType)
    (theDict (:pointer :__CFDictionary))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMCopyProfileLocalizedString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in ColorSyncLib 3.1 and later
;  

(deftrap-inline "_CMCopyProfileLocalizedString" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (tag :OSType)
    (reqLocale (:pointer :__CFString))
    (locale (:pointer :CFStringRef))
    (str (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMCopyProfileDescriptionString()
;  *  
;  *  Summary:
;  *    Returns the name of a profile as a CFString.
;  *  
;  *  Discussion:
;  *    If the profile is multi-localized, the best localized name for
;  *    the current process is returned.
;  *  
;  *  Parameters:
;  *    
;  *    prof:
;  *      (in) the profile to query
;  *    
;  *    str:
;  *      (out) returns the name
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMCopyProfileDescriptionString" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (str (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  CMCloneProfileRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMCloneProfileRef" 
   ((prof (:pointer :OpaqueCMProfileRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetProfileRefCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMGetProfileRefCount" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (count (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMProfileModified()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMProfileModified" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (modified (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetProfileMD5()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMGetProfileMD5" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (digest (:pointer :CMProfileMD5))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
;  named Color access functions 
; 
;  *  CMGetNamedColorInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMGetNamedColorInfo" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (deviceChannels (:pointer :UInt32))
    (deviceColorSpace (:pointer :OSType))
    (PCSColorSpace (:pointer :OSType))
    (count (:pointer :UInt32))
    (prefix (:pointer :UInt8))
    (suffix (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetNamedColorValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMGetNamedColorValue" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (name (:pointer :UInt8))
    (deviceColor (:pointer :CMColor))
    (PCSColor (:pointer :CMColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetIndNamedColorValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMGetIndNamedColorValue" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (index :UInt32)
    (deviceColor (:pointer :CMColor))
    (PCSColor (:pointer :CMColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetNamedColorIndex()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMGetNamedColorIndex" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (name (:pointer :UInt8))
    (index (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetNamedColorName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMGetNamedColorName" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (index :UInt32)
    (name (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  General-purpose matching functions 
; 
;  *  NCWNewColorWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_NCWNewColorWorld" 
   ((cw (:pointer :CMWORLDREF))
    (src (:pointer :OpaqueCMProfileRef))
    (dst (:pointer :OpaqueCMProfileRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CWConcatColorWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CWConcatColorWorld" 
   ((cw (:pointer :CMWORLDREF))
    (profileSet (:pointer :CMConcatProfileSet))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CWNewLinkProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CWNewLinkProfile" 
   ((prof (:pointer :CMPROFILEREF))
    (targetLocation (:pointer :CMProfileLocation))
    (profileSet (:pointer :CMConcatProfileSet))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NCWConcatColorWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
;  

(deftrap-inline "_NCWConcatColorWorld" 
   ((cw (:pointer :CMWORLDREF))
    (profileSet (:pointer :NCMConcatProfileSet))
    (proc (:pointer :OpaqueCMConcatCallBackProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NCWNewLinkProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
;  

(deftrap-inline "_NCWNewLinkProfile" 
   ((prof (:pointer :CMPROFILEREF))
    (targetLocation (:pointer :CMProfileLocation))
    (profileSet (:pointer :NCMConcatProfileSet))
    (proc (:pointer :OpaqueCMConcatCallBackProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CWDisposeColorWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
;  

(deftrap-inline "_CWDisposeColorWorld" 
   ((cw (:pointer :OpaqueCMWorldRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CWMatchColors()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
;  

(deftrap-inline "_CWMatchColors" 
   ((cw (:pointer :OpaqueCMWorldRef))
    (myColors (:pointer :CMColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CWCheckColors()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
;  

(deftrap-inline "_CWCheckColors" 
   ((cw (:pointer :OpaqueCMWorldRef))
    (myColors (:pointer :CMColor))
    (count :UInt32)
    (result (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CWMatchBitmap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CWMatchBitmap" 
   ((cw (:pointer :OpaqueCMWorldRef))
    (bitmap (:pointer :CMBitmap))
    (progressProc (:pointer :OpaqueCMBitmapCallBackProcPtr))
    (refCon :pointer)
    (matchedBitmap (:pointer :CMBitmap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CWCheckBitmap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CWCheckBitmap" 
   ((cw (:pointer :OpaqueCMWorldRef))
    (bitmap (:pointer :CMBitmap))
    (progressProc (:pointer :OpaqueCMBitmapCallBackProcPtr))
    (refCon :pointer)
    (resultBitmap (:pointer :CMBitmap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  OpenGL support 

(defconstant $cmTextureRGBtoRGBX8 0)            ;  RGB to 8-bit RGBx texture

; 
;  *  CWFillLookupTexture()
;  *  
;  *  Summary:
;  *    Fills a 3d lookup texture from a colorworld.
;  *  
;  *  Discussion:
;  *    The resulting table is suitable for use in OpenGL to accelerate
;  *    color management in hardware.
;  *  
;  *  Parameters:
;  *    
;  *    cw:
;  *      (in) the colorworld to use
;  *    
;  *    gridPoints:
;  *      (in) number of grid points per channel in the texture
;  *    
;  *    format:
;  *      (in) format of pixels in texture (e.g. cmTextureRGBtoRGBX8)
;  *    
;  *    dataSize:
;  *      (in) size in bytes of texture data to fill
;  *    
;  *    data:
;  *      (in/out) pointer to texture data to fill
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CWFillLookupTexture" 
   ((cw (:pointer :OpaqueCMWorldRef))
    (gridPoints :UInt32)
    (format :UInt32)
    (dataSize :UInt32)
    (data :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
;  Quickdraw-specific matching 

; #if _DECLARE_CS_QD_API_
#| 
; 
;  *  CWMatchPixMap()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
;  

(deftrap-inline "_CWMatchPixMap" 
   ((cw (:pointer :OpaqueCMWorldRef))
    (myPixMap (:pointer :pixmap))
    (progressProc (:pointer :OpaqueCMBitmapCallBackProcPtr))
    (refCon :pointer)
   )
   :signed-long
() )
; 
;  *  CWCheckPixMap()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
;  

(deftrap-inline "_CWCheckPixMap" 
   ((cw (:pointer :OpaqueCMWorldRef))
    (myPixMap (:pointer :pixmap))
    (progressProc (:pointer :OpaqueCMBitmapCallBackProcPtr))
    (refCon :pointer)
    (resultBitMap (:pointer :bitmap))
   )
   :signed-long
() )
; 
;  *  NCMBeginMatching()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_NCMBeginMatching" 
   ((src (:pointer :OpaqueCMProfileRef))
    (dst (:pointer :OpaqueCMProfileRef))
    (myRef (:pointer :CMMATCHREF))
   )
   :signed-long
() )
; 
;  *  CMEndMatching()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMEndMatching" 
   ((myRef (:pointer :OpaqueCMMatchRef))
   )
   nil
() )
; 
;  *  NCMDrawMatchedPicture()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_NCMDrawMatchedPicture" 
   ((myPicture :pichandle)
    (dst (:pointer :OpaqueCMProfileRef))
    (myRect (:pointer :Rect))
   )
   nil
() )
; 
;  *  CMEnableMatchingComment()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMEnableMatchingComment" 
   ((enableIt :Boolean)
   )
   nil
() )
; 
;  *  NCMUseProfileComment()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_NCMUseProfileComment" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (flags :UInt32)
   )
   :signed-long
() )
 |#

; #endif  /* _DECLARE_CS_QD_API_ */


; #if TARGET_OS_WIN32
#| 
; 
;  *  CWMatchHBITMAP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
 |#

; #endif  /* TARGET_OS_WIN32 */

; 
;  *  CMCreateProfileIdentifier()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMCreateProfileIdentifier" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (ident (:pointer :CMProfileIdentifier))
    (size (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  System Profile access 
; 
;  *  CMGetSystemProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMGetSystemProfile" 
   ((prof (:pointer :CMPROFILEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMSetSystemProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMSetSystemProfile" 
   ((profileFileSpec (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NCMSetSystemProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
;  

(deftrap-inline "_NCMSetSystemProfile" 
   ((profLoc (:pointer :CMProfileLocation))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetDefaultProfileBySpace()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
;  

(deftrap-inline "_CMGetDefaultProfileBySpace" 
   ((dataColorSpace :OSType)
    (prof (:pointer :CMPROFILEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMSetDefaultProfileBySpace()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
;  

(deftrap-inline "_CMSetDefaultProfileBySpace" 
   ((dataColorSpace :OSType)
    (prof (:pointer :OpaqueCMProfileRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetProfileByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
;  

(deftrap-inline "_CMGetProfileByAVID" 
   ((theID :UInt32)
    (prof (:pointer :CMPROFILEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMSetProfileByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
;  

(deftrap-inline "_CMSetProfileByAVID" 
   ((theID :UInt32)
    (prof (:pointer :OpaqueCMProfileRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetGammaByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 3.0 and later
;  

(deftrap-inline "_CMGetGammaByAVID" 
   ((theID :UInt32)
    (gamma (:pointer :CMVideoCardGamma))
    (size (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMSetGammaByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 3.0 and later
;  

(deftrap-inline "_CMSetGammaByAVID" 
   ((theID :UInt32)
    (gamma (:pointer :CMVideoCardGamma))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Profile access by Use 
; 
;  *  CMGetDefaultProfileByUse()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 3.0 and later
;  

(deftrap-inline "_CMGetDefaultProfileByUse" 
   ((use :OSType)
    (prof (:pointer :CMPROFILEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMSetDefaultProfileByUse()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 3.0 and later
;  

(deftrap-inline "_CMSetDefaultProfileByUse" 
   ((use :OSType)
    (prof (:pointer :OpaqueCMProfileRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Profile Management 
; 
;  *  CMNewProfileSearch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMNewProfileSearch" 
   ((searchSpec (:pointer :CMSearchRecord))
    (refCon :pointer)
    (count (:pointer :UInt32))
    (searchResult (:pointer :CMPROFILESEARCHREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMUpdateProfileSearch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMUpdateProfileSearch" 
   ((search (:pointer :OpaqueCMProfileSearchRef))
    (refCon :pointer)
    (count (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMDisposeProfileSearch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMDisposeProfileSearch" 
   ((search (:pointer :OpaqueCMProfileSearchRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CMSearchGetIndProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMSearchGetIndProfile" 
   ((search (:pointer :OpaqueCMProfileSearchRef))
    (index :UInt32)
    (prof (:pointer :CMPROFILEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMSearchGetIndProfileFileSpec()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMSearchGetIndProfileFileSpec" 
   ((search (:pointer :OpaqueCMProfileSearchRef))
    (index :UInt32)
    (profileFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMProfileIdentifierFolderSearch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMProfileIdentifierFolderSearch" 
   ((ident (:pointer :CMProfileIdentifier))
    (matchedCount (:pointer :UInt32))
    (searchResult (:pointer :CMPROFILESEARCHREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMProfileIdentifierListSearch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMProfileIdentifierListSearch" 
   ((ident (:pointer :CMProfileIdentifier))
    (profileList (:pointer :CMPROFILEREF))
    (listSize :UInt32)
    (matchedCount (:pointer :UInt32))
    (matchedList (:pointer :CMPROFILEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMIterateColorSyncFolder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
;  

(deftrap-inline "_CMIterateColorSyncFolder" 
   ((proc (:pointer :OpaqueCMProfileIterateProcPtr))
    (seed (:pointer :UInt32))
    (count (:pointer :UInt32))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NCMUnflattenProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
;  

(deftrap-inline "_NCMUnflattenProfile" 
   ((targetLocation (:pointer :CMProfileLocation))
    (proc (:pointer :OpaqueCMFlattenProcPtr))
    (refCon :pointer)
    (preferredCMMnotfound (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Utilities 
; 
;  *  CMGetColorSyncFolderSpec()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMGetColorSyncFolderSpec" 
   ((vRefNum :SInt16)
    (createFolder :Boolean)
    (foundVRefNum (:pointer :short))
    (foundDirID (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

; #if TARGET_OS_WIN32 || TARGET_OS_UNIX
#| 
; 
;  *  CMGetColorSyncFolderPath()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
 |#

; #endif  /* TARGET_OS_WIN32 || TARGET_OS_UNIX */

; 
;  *  CMGetCWInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
;  

(deftrap-inline "_CMGetCWInfo" 
   ((cw (:pointer :OpaqueCMWorldRef))
    (info (:pointer :CMCWInfoRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

; #if TARGET_API_MAC_OS8
#| 
; 
;  *  CMConvertProfile2to1()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  
 |#

; #endif  /* TARGET_API_MAC_OS8 */

; 
;  *  CMGetPreferredCMM()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
;  

(deftrap-inline "_CMGetPreferredCMM" 
   ((cmmType (:pointer :OSType))
    (preferredCMMnotfound (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMIterateCMMInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
;  

(deftrap-inline "_CMIterateCMMInfo" 
   ((proc (:pointer :OpaqueCMMIterateProcPtr))
    (count (:pointer :UInt32))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetColorSyncVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
;  

(deftrap-inline "_CMGetColorSyncVersion" 
   ((version (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMLaunchControlPanel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 3.0 and later
;  

(deftrap-inline "_CMLaunchControlPanel" 
   ((flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  ColorSpace conversion functions 
; 
;  *  CMConvertXYZToLab()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMConvertXYZToLab" 
   ((src (:pointer :CMColor))
    (white (:pointer :CMXYZColor))
    (dst (:pointer :CMColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMConvertLabToXYZ()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMConvertLabToXYZ" 
   ((src (:pointer :CMColor))
    (white (:pointer :CMXYZColor))
    (dst (:pointer :CMColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMConvertXYZToLuv()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMConvertXYZToLuv" 
   ((src (:pointer :CMColor))
    (white (:pointer :CMXYZColor))
    (dst (:pointer :CMColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMConvertLuvToXYZ()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMConvertLuvToXYZ" 
   ((src (:pointer :CMColor))
    (white (:pointer :CMXYZColor))
    (dst (:pointer :CMColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMConvertXYZToYxy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMConvertXYZToYxy" 
   ((src (:pointer :CMColor))
    (dst (:pointer :CMColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMConvertYxyToXYZ()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMConvertYxyToXYZ" 
   ((src (:pointer :CMColor))
    (dst (:pointer :CMColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMConvertRGBToHLS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMConvertRGBToHLS" 
   ((src (:pointer :CMColor))
    (dst (:pointer :CMColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMConvertHLSToRGB()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMConvertHLSToRGB" 
   ((src (:pointer :CMColor))
    (dst (:pointer :CMColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMConvertRGBToHSV()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMConvertRGBToHSV" 
   ((src (:pointer :CMColor))
    (dst (:pointer :CMColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMConvertHSVToRGB()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMConvertHSVToRGB" 
   ((src (:pointer :CMColor))
    (dst (:pointer :CMColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMConvertRGBToGray()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMConvertRGBToGray" 
   ((src (:pointer :CMColor))
    (dst (:pointer :CMColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMConvertXYZToFixedXYZ()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMConvertXYZToFixedXYZ" 
   ((src (:pointer :CMXYZColor))
    (dst (:pointer :CMFixedXYZColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMConvertFixedXYZToXYZ()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
;  

(deftrap-inline "_CMConvertFixedXYZToXYZ" 
   ((src (:pointer :CMFixedXYZColor))
    (dst (:pointer :CMXYZColor))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMConvertXYZToXYZ()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMConvertXYZToXYZ" 
   ((src (:pointer :CMColor))
    (srcIlluminant (:pointer :CMXYZColor))
    (dst (:pointer :CMColor))
    (dstIlluminant (:pointer :CMXYZColor))
    (method :UInt32)
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
;  PS-related 
; 
;  *  CMGetPS2ColorSpace()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMGetPS2ColorSpace" 
   ((srcProf (:pointer :OpaqueCMProfileRef))
    (flags :UInt32)
    (proc (:pointer :OpaqueCMFlattenProcPtr))
    (refCon :pointer)
    (preferredCMMnotfound (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetPS2ColorRenderingIntent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMGetPS2ColorRenderingIntent" 
   ((srcProf (:pointer :OpaqueCMProfileRef))
    (flags :UInt32)
    (proc (:pointer :OpaqueCMFlattenProcPtr))
    (refCon :pointer)
    (preferredCMMnotfound (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetPS2ColorRendering()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMGetPS2ColorRendering" 
   ((srcProf (:pointer :OpaqueCMProfileRef))
    (dstProf (:pointer :OpaqueCMProfileRef))
    (flags :UInt32)
    (proc (:pointer :OpaqueCMFlattenProcPtr))
    (refCon :pointer)
    (preferredCMMnotfound (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMGetPS2ColorRenderingVMSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
;  

(deftrap-inline "_CMGetPS2ColorRenderingVMSize" 
   ((srcProf (:pointer :OpaqueCMProfileRef))
    (dstProf (:pointer :OpaqueCMProfileRef))
    (vmSize (:pointer :UInt32))
    (preferredCMMnotfound (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Profile makers 

(def-mactype :CMLabToLabProcPtr (find-mactype ':pointer)); (float * L , float * a , float * b , void * refcon)
; 
;  *  CMMakeProfile()
;  *  
;  *  Summary:
;  *    Make a display or abstract profile.
;  *  
;  *  Discussion:
;  *    Adds appropriate tags to a profile to make display or abstract
;  *    profile based on an specification dictionary. 
;  *    
;  *    One key in the specification dictionary must be "profileType" 
;  *    which must have a CFString value of "abstractLab", "displayRGB" 
;  *    or "displayID".  It can also contain the keys/values: 
;  *      "description"  CFString (optional) 
;  *      "copyright"    CFString (optional) 
;  *    
;  *    For profileType of "abstractLab", the dictionary 
;  *    should also contain the keys/values: 
;  *      "gridPoints"   CFNumber(SInt32) (should be odd) 
;  *      "proc"         CFNumber(SInt64) 
;  *                     (coerced from a LabToLabProcPtr) 
;  *      "refcon"       CFNumber(SInt64) (optional) 
;  *                     (coerced from a void*) 
;  *    
;  *    For profileType of "displayRGB", the dictionary 
;  *    should also contain the keys/values: 
;  *      "targetGamma"  CFNumber(Float)  (e.g. 1.8)  (optional) 
;  *      "targetWhite"  CFNumber(SInt32) (e.g. 6500) (optional) 
;  *      "gammaR"       CFNumber(Float)  (e.g. 2.5) 
;  *      "gammaG"       CFNumber(Float)  (e.g. 2.5) 
;  *      "gammaB"       CFNumber(Float)  (e.g. 2.5) 
;  *      "tableChans"   CFNumber(SInt32) (1 or 3) (optional) 
;  *      "tableEntries" CFNumber(SInt32) (e.g 16 or 255) (optional) 
;  *      "tableEntrySize" CFNumber(SInt32) (1 or 2) (optional) 
;  *      "tableData"    CFData (lut in RRRGGGBBB order) (optional) 
;  *     either 
;  *      "phosphorRx"   CFNumber(Float) 
;  *      "phosphorRy"   CFNumber(Float) 
;  *      "phosphorGx"   CFNumber(Float) 
;  *      "phosphorGy"   CFNumber(Float) 
;  *      "phosphorBx"   CFNumber(Float) 
;  *      "phosphorBy"   CFNumber(Float) 
;  *      or 
;  *      "phosphorSet"  CFString ("WideRGB", "700/525/450nm", 
;  *                      "P22-EBU", "HDTV", "CCIR709", "sRGB", 
;  *                      "AdobeRGB98" or "Trinitron") 
;  *     either 
;  *      "whitePointx"  CFNumber(Float) 
;  *      "whitePointy"  CFNumber(Float) 
;  *      or 
;  *      "whiteTemp"    CFNumber(SInt32)  (e.g. 5000, 6500, 9300) 
;  *    
;  *    For profileType of "displayID", the dictionary 
;  *    should also contain the keys/values: 
;  *      "targetGamma"  CFNumber(Float)  (e.g. 1.8)  (optional) 
;  *      "targetWhite"  CFNumber(SInt32) (e.g. 6500) (optional) 
;  *      "displayID     CFNumber(SInt32) 
;  *    Optionally, the keys/values for "displayRGB" can be 
;  *    provided to override the valuses from the display.
;  *  
;  *  Parameters:
;  *    
;  *    prof:
;  *      (in) the profile to modify
;  *    
;  *    spec:
;  *      (in) specification dictionary
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMMakeProfile" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (spec (:pointer :__CFDictionary))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __CMAPPLICATION__ */


(provide-interface "CMApplication")