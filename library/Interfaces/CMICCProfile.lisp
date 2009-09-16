(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CMICCProfile.h"
; at Sunday July 2,2006 7:24:22 pm.
; 
;      File:       ColorSync/CMICCProfile.h
;  
;      Contains:   ICC Profile Format Definitions
;  
;      Version:    ColorSync-118.2~1
;  
;      Copyright:  © 1994-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CMICCPROFILE__
; #define __CMICCPROFILE__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k
;  ICC Profile version constants  

(defconstant $cmICCProfileVersion4 #x4000000)
(defconstant $cmICCProfileVersion2 #x2000000)
(defconstant $cmICCProfileVersion21 #x2100000)
(defconstant $cmCS2ProfileVersion #x2000000)
(defconstant $cmCS1ProfileVersion #x100)        ;  ColorSync 1.0 profile version 

;  Current Major version number 

(defconstant $cmProfileMajorVersionMask #xFF000000)
(defconstant $cmCurrentProfileMajorVersion #x2000000)
;  magic cookie number for anonymous file ID 

(defconstant $cmMagicNumber :|acsp|)
; **********************************************************************
; ************** ColorSync 2.0 profile specification *******************
; **********************************************************************
; *** flags field  ***

(defconstant $cmICCReservedFlagsMask #xFFFF)    ;  these bits of the flags field are defined and reserved by ICC 

(defconstant $cmEmbeddedMask 1)                 ;  if bit 0 is 0 then not embedded profile, if 1 then embedded profile 

(defconstant $cmEmbeddedUseMask 2)              ;  if bit 1 is 0 then ok to use anywhere, if 1 then ok to use as embedded profile only 

(defconstant $cmCMSReservedFlagsMask #xFFFF0000);  these bits of the flags field are defined and reserved by CMS vendor 

(defconstant $cmQualityMask #x30000)            ;  if bits 16-17 is 0 then normal, if 1 then draft, if 2 then best 

(defconstant $cmInterpolationMask #x40000)      ;  if bit 18 is 0 then interpolation, if 1 then lookup only 

(defconstant $cmGamutCheckingMask #x80000)      ;  if bit 19 is 0 then create gamut checking info, if 1 then no gamut checking info 

;  copyright-protection flag options 

(defconstant $cmEmbeddedProfile 0)              ;  0 is not embedded profile, 1 is embedded profile 

(defconstant $cmEmbeddedUse 1)                  ;  0 is to use anywhere, 1 is to use as embedded profile only 

;  speed and quality flag options 

(defconstant $cmNormalMode 0)                   ;  it uses the least significent two bits in the high word of flag 

(defconstant $cmDraftMode 1)                    ;  it should be evaulated like this: right shift 16 bits first, mask off the 

(defconstant $cmBestMode 2)                     ;  high 14 bits, and then compare with the enum to determine the option value 

; *** deviceAttributes fields ***
;  deviceAttributes[0] is defined by and reserved for device vendors 
;  deviceAttributes[1] is defined by and reserved for ICC 
;  The following bits of deviceAttributes[1] are currently defined 

(defconstant $cmReflectiveTransparentMask 1)    ;  if bit 0 is 0 then reflective media, if 1 then transparency media 

(defconstant $cmGlossyMatteMask 2)              ;  if bit 1 is 0 then glossy, if 1 then matte 

;  device/media attributes element values  

(defconstant $cmReflective 0)                   ;  if bit 0 is 0 then reflective media, if 1 then transparency media 

(defconstant $cmGlossy 1)                       ;  if bit 1 is 0 then glossy, if 1 then matte 

; *** renderingIntent field ***

(defconstant $cmPerceptual 0)                   ;  Photographic images 

(defconstant $cmRelativeColorimetric 1)         ;  Logo Colors 

(defconstant $cmSaturation 2)                   ;  Business graphics 

(defconstant $cmAbsoluteColorimetric 3)         ;  Logo Colors 

;  data type element values 

(defconstant $cmAsciiData 0)
(defconstant $cmBinaryData 1)
;  screen encodings  

(defconstant $cmPrtrDefaultScreens 0)           ;  Use printer default screens.  0 is false, 1 is ture 

(defconstant $cmLinesPer 1)                     ;  0 is LinesPerCm, 1 is LinesPerInch 

;  2.0 tag type information 

(defconstant $cmNumHeaderElements 10)
;  public tags 

(defconstant $cmAToB0Tag :|A2B0|)
(defconstant $cmAToB1Tag :|A2B1|)
(defconstant $cmAToB2Tag :|A2B2|)
(defconstant $cmBlueColorantTag :|bXYZ|)
(defconstant $cmBlueTRCTag :|bTRC|)
(defconstant $cmBToA0Tag :|B2A0|)
(defconstant $cmBToA1Tag :|B2A1|)
(defconstant $cmBToA2Tag :|B2A2|)
(defconstant $cmCalibrationDateTimeTag :|calt|)
(defconstant $cmChromaticAdaptationTag :|chad|)
(defconstant $cmCharTargetTag :|targ|)
(defconstant $cmCopyrightTag :|cprt|)
(defconstant $cmDeviceMfgDescTag :|dmnd|)
(defconstant $cmDeviceModelDescTag :|dmdd|)
(defconstant $cmGamutTag :|gamt|)
(defconstant $cmGrayTRCTag :|kTRC|)
(defconstant $cmGreenColorantTag :|gXYZ|)
(defconstant $cmGreenTRCTag :|gTRC|)
(defconstant $cmLuminanceTag :|lumi|)
(defconstant $cmMeasurementTag :|meas|)
(defconstant $cmMediaBlackPointTag :|bkpt|)
(defconstant $cmMediaWhitePointTag :|wtpt|)
(defconstant $cmNamedColorTag :|ncol|)
(defconstant $cmNamedColor2Tag :|ncl2|)
(defconstant $cmPreview0Tag :|pre0|)
(defconstant $cmPreview1Tag :|pre1|)
(defconstant $cmPreview2Tag :|pre2|)
(defconstant $cmProfileDescriptionTag :|desc|)
(defconstant $cmProfileSequenceDescTag :|pseq|)
(defconstant $cmPS2CRD0Tag :|psd0|)
(defconstant $cmPS2CRD1Tag :|psd1|)
(defconstant $cmPS2CRD2Tag :|psd2|)
(defconstant $cmPS2CRD3Tag :|psd3|)
(defconstant $cmPS2CSATag :|ps2s|)
(defconstant $cmPS2RenderingIntentTag :|ps2i|)
(defconstant $cmRedColorantTag :|rXYZ|)
(defconstant $cmRedTRCTag :|rTRC|)
(defconstant $cmScreeningDescTag :|scrd|)
(defconstant $cmScreeningTag :|scrn|)
(defconstant $cmTechnologyTag :|tech|)
(defconstant $cmUcrBgTag :|bfd |)
(defconstant $cmViewingConditionsDescTag :|vued|)
(defconstant $cmViewingConditionsTag :|view|)
;  custom tags 

(defconstant $cmPS2CRDVMSizeTag :|psvm|)
(defconstant $cmVideoCardGammaTag :|vcgt|)
(defconstant $cmMakeAndModelTag :|mmod|)
(defconstant $cmProfileDescriptionMLTag :|dscm|)
(defconstant $cmNativeDisplayInfoTag :|ndin|)
;  public type signatures 

(defconstant $cmSigCrdInfoType :|crdi|)
(defconstant $cmSigCurveType :|curv|)
(defconstant $cmSigDataType :|data|)
(defconstant $cmSigDateTimeType :|dtim|)
(defconstant $cmSigLut16Type :|mft2|)
(defconstant $cmSigLut8Type :|mft1|)
(defconstant $cmSigMeasurementType :|meas|)
(defconstant $cmSigMultiFunctA2BType :|mAB |)
(defconstant $cmSigMultiFunctB2AType :|mBA |)
(defconstant $cmSigNamedColorType :|ncol|)
(defconstant $cmSigNamedColor2Type :|ncl2|)
(defconstant $cmSigParametricCurveType :|para|)
(defconstant $cmSigProfileDescriptionType :|desc|)
(defconstant $cmSigProfileSequenceDescType :|pseq|)
(defconstant $cmSigScreeningType :|scrn|)
(defconstant $cmSigS15Fixed16Type :|sf32|)
(defconstant $cmSigSignatureType :|sig |)
(defconstant $cmSigTextType :|text|)
(defconstant $cmSigU16Fixed16Type :|uf32|)
(defconstant $cmSigU1Fixed15Type :|uf16|)
(defconstant $cmSigUInt8Type :|ui08|)
(defconstant $cmSigUInt16Type :|ui16|)
(defconstant $cmSigUInt32Type :|ui32|)
(defconstant $cmSigUInt64Type :|ui64|)
(defconstant $cmSigUcrBgType :|bfd |)
(defconstant $cmSigUnicodeTextType :|utxt|)
(defconstant $cmSigViewingConditionsType :|view|)
(defconstant $cmSigXYZType :|XYZ |)
;  custom type signatures 

(defconstant $cmSigPS2CRDVMSizeType :|psvm|)
(defconstant $cmSigVideoCardGammaType :|vcgt|)
(defconstant $cmSigMakeAndModelType :|mmod|)
(defconstant $cmSigNativeDisplayInfoType :|ndin|)
(defconstant $cmSigMultiLocalizedUniCodeType :|mluc|)
;  technology tag descriptions 

(defconstant $cmTechnologyDigitalCamera :|dcam|)
(defconstant $cmTechnologyFilmScanner :|fscn|)
(defconstant $cmTechnologyReflectiveScanner :|rscn|)
(defconstant $cmTechnologyInkJetPrinter :|ijet|)
(defconstant $cmTechnologyThermalWaxPrinter :|twax|)
(defconstant $cmTechnologyElectrophotographicPrinter :|epho|)
(defconstant $cmTechnologyElectrostaticPrinter :|esta|)
(defconstant $cmTechnologyDyeSublimationPrinter :|dsub|)
(defconstant $cmTechnologyPhotographicPaperPrinter :|rpho|)
(defconstant $cmTechnologyFilmWriter :|fprn|)
(defconstant $cmTechnologyVideoMonitor :|vidm|)
(defconstant $cmTechnologyVideoCamera :|vidc|)
(defconstant $cmTechnologyProjectionTelevision :|pjtv|)
(defconstant $cmTechnologyCRTDisplay :|CRT |)
(defconstant $cmTechnologyPMDisplay :|PMD |)
(defconstant $cmTechnologyAMDisplay :|AMD |)
(defconstant $cmTechnologyPhotoCD :|KPCD|)
(defconstant $cmTechnologyPhotoImageSetter :|imgs|)
(defconstant $cmTechnologyGravure :|grav|)
(defconstant $cmTechnologyOffsetLithography :|offs|)
(defconstant $cmTechnologySilkscreen :|silk|)
(defconstant $cmTechnologyFlexography :|flex|)
;  Measurement type encodings 
;  Measurement Flare 

(defconstant $cmFlare0 0)
(defconstant $cmFlare100 1)
;  Measurement Geometry 

(defconstant $cmGeometryUnknown 0)
(defconstant $cmGeometry045or450 1)
(defconstant $cmGeometry0dord0 2)
;  Standard Observer    

(defconstant $cmStdobsUnknown 0)
(defconstant $cmStdobs1931TwoDegrees 1)
(defconstant $cmStdobs1964TenDegrees 2)
;  Standard Illuminant 

(defconstant $cmIlluminantUnknown 0)
(defconstant $cmIlluminantD50 1)
(defconstant $cmIlluminantD65 2)
(defconstant $cmIlluminantD93 3)
(defconstant $cmIlluminantF2 4)
(defconstant $cmIlluminantD55 5)
(defconstant $cmIlluminantA 6)
(defconstant $cmIlluminantEquiPower 7)
(defconstant $cmIlluminantF8 8)
;  Spot Function Value 

(defconstant $cmSpotFunctionUnknown 0)
(defconstant $cmSpotFunctionDefault 1)
(defconstant $cmSpotFunctionRound 2)
(defconstant $cmSpotFunctionDiamond 3)
(defconstant $cmSpotFunctionEllipse 4)
(defconstant $cmSpotFunctionLine 5)
(defconstant $cmSpotFunctionSquare 6)
(defconstant $cmSpotFunctionCross 7)
;  Color Space Signatures 

(defconstant $cmXYZData :|XYZ |)
(defconstant $cmLabData :|Lab |)
(defconstant $cmLuvData :|Luv |)
(defconstant $cmYCbCrData :|YCbr|)
(defconstant $cmYxyData :|Yxy |)
(defconstant $cmRGBData :|RGB |)
(defconstant $cmSRGBData :|sRGB|)
(defconstant $cmGrayData :|GRAY|)
(defconstant $cmHSVData :|HSV |)
(defconstant $cmHLSData :|HLS |)
(defconstant $cmCMYKData :|CMYK|)
(defconstant $cmCMYData :|CMY |)
(defconstant $cmMCH5Data :|MCH5|)
(defconstant $cmMCH6Data :|MCH6|)
(defconstant $cmMCH7Data :|MCH7|)
(defconstant $cmMCH8Data :|MCH8|)
(defconstant $cm3CLRData :|3CLR|)
(defconstant $cm4CLRData :|4CLR|)
(defconstant $cm5CLRData :|5CLR|)
(defconstant $cm6CLRData :|6CLR|)
(defconstant $cm7CLRData :|7CLR|)
(defconstant $cm8CLRData :|8CLR|)
(defconstant $cm9CLRData :|9CLR|)
(defconstant $cm10CLRData :|ACLR|)
(defconstant $cm11CLRData :|BCLR|)
(defconstant $cm12CLRData :|CCLR|)
(defconstant $cm13CLRData :|DCLR|)
(defconstant $cm14CLRData :|ECLR|)
(defconstant $cm15CLRData :|FCLR|)
(defconstant $cmNamedData :|NAME|)
;  profileClass enumerations 

(defconstant $cmInputClass :|scnr|)
(defconstant $cmDisplayClass :|mntr|)
(defconstant $cmOutputClass :|prtr|)
(defconstant $cmLinkClass :|link|)
(defconstant $cmAbstractClass :|abst|)
(defconstant $cmColorSpaceClass :|spac|)
(defconstant $cmNamedColorClass :|nmcl|)
;  platform enumerations 

(defconstant $cmMacintosh :|APPL|)
(defconstant $cmMicrosoft :|MSFT|)
(defconstant $cmSolaris :|SUNW|)
(defconstant $cmSiliconGraphics :|SGI |)
(defconstant $cmTaligent :|TGNT|)
;  parametric curve type enumerations 

(defconstant $cmParametricType0 0)              ;  Y = X^gamma 

(defconstant $cmParametricType1 1)              ;  Y = (aX+b)^gamma     [X>=-b/a],  Y = 0    [X<-b/a] 

(defconstant $cmParametricType2 2)              ;  Y = (aX+b)^gamma + c [X>=-b/a],  Y = c    [X<-b/a] 

(defconstant $cmParametricType3 3)              ;  Y = (aX+b)^gamma     [X>=d],     Y = cX   [X<d]    

(defconstant $cmParametricType4 4)              ;  Y = (aX+b)^gamma + e [X>=d],     Y = cX+f [X<d]    

;  ColorSync 1.0 elements 

(defconstant $cmCS1ChromTag :|chrm|)
(defconstant $cmCS1TRCTag :|trc |)
(defconstant $cmCS1NameTag :|name|)
(defconstant $cmCS1CustTag :|cust|)
;  General element data types 
(defrecord CMDateTime
   (year :UInt16)
   (month :UInt16)
   (dayOfTheMonth :UInt16)
   (hours :UInt16)
   (minutes :UInt16)
   (seconds :UInt16)
)

;type name? (%define-record :CMDateTime (find-record-descriptor ':CMDateTime))
(defrecord CMFixedXYColor
   (x :signed-long)
   (y :signed-long)
)

;type name? (%define-record :CMFixedXYColor (find-record-descriptor ':CMFixedXYColor))
(defrecord CMFixedXYZColor
   (X :signed-long)
   (Y :signed-long)
   (Z :signed-long)
)

;type name? (%define-record :CMFixedXYZColor (find-record-descriptor ':CMFixedXYZColor))

(def-mactype :CMXYZComponent (find-mactype ':UInt16))
(defrecord CMXYZColor
   (X :UInt16)
   (Y :UInt16)
   (Z :UInt16)
)

;type name? (%define-record :CMXYZColor (find-record-descriptor ':CMXYZColor))
;  Typedef for Profile MD5 message digest 
;  Derived from the RSA Data Security, Inc. MD5 Message-Digest Algorithm 
(defrecord CMProfileMD5
   (contents (:array :UInt8 16))
)
(def-mactype :CMProfileMD5Ptr (find-mactype '(:pointer :CMProfileMD5)))
; 
;  *  CMProfileMD5AreEqual()
;  *  
;  *  Availability:       available as macro/inline
;  
; #ifdef __cplusplus
#| #|
  inline Boolean CMProfileMD5AreEqual(CMProfileMD5 a, CMProfileMD5 b)
  {
    return  ((long*)a)[0]==((long*)b)[0] && ((long*)a)[1]==((long*)b)[1] &&
         ((long*)a)[2]==((long*)b)[2] && ((long*)a)[3]==((long*)b)[3];
  }
|#
 |#

; #else
; #define CMProfileMD5AreEqual(a, b) (    ((long*)a)[0]==((long*)b)[0] && ((long*)a)[1]==((long*)b)[1] &&   ((long*)a)[2]==((long*)b)[2] && ((long*)a)[3]==((long*)b)[3])

; #endif

(defrecord CM2Header
   (size :UInt32)                               ;  This is the total size of the Profile 
   (CMMType :OSType)                            ;  CMM signature,  Registered with CS2 consortium  
   (profileVersion :UInt32)                     ;  Version of CMProfile format 
   (profileClass :OSType)                       ;  input, display, output, devicelink, abstract, or color conversion profile type 
   (dataColorSpace :OSType)                     ;  color space of data 
   (profileConnectionSpace :OSType)             ;  profile connection color space 
   (dateTime :CMDateTime)                       ;  date and time of profile creation 
   (CS2profileSignature :OSType)                ;  'acsp' constant ColorSync 2.0 file ID 
   (platform :OSType)                           ;  primary profile platform, Registered with CS2 consortium 
   (flags :UInt32)                              ;  profile flags 
   (deviceManufacturer :OSType)                 ;  Registered with ICC consortium 
   (deviceModel :UInt32)                        ;  Registered with ICC consortium 
   (deviceAttributes (:array :UInt32 2))        ;  Attributes[0] is for device vendors, [1] is for ICC 
   (renderingIntent :UInt32)                    ;  preferred rendering intent of tagged object 
   (white :CMFixedXYZColor)                     ;  profile illuminant 
   (creator :OSType)                            ;  profile creator 
   (reserved (:array :character 44))            ;  reserved for future use 
)

;type name? (%define-record :CM2Header (find-record-descriptor ':CM2Header))
(defrecord CM4Header
   (size :UInt32)                               ;  This is the total size of the Profile 
   (CMMType :OSType)                            ;  CMM signature,  Registered with CS2 consortium  
   (profileVersion :UInt32)                     ;  Version of CMProfile format 
   (profileClass :OSType)                       ;  input, display, output, devicelink, abstract, or color conversion profile type 
   (dataColorSpace :OSType)                     ;  color space of data 
   (profileConnectionSpace :OSType)             ;  profile connection color space 
   (dateTime :CMDateTime)                       ;  date and time of profile creation 
   (CS2profileSignature :OSType)                ;  'acsp' constant ColorSync 2.0 file ID 
   (platform :OSType)                           ;  primary profile platform, Registered with CS2 consortium 
   (flags :UInt32)                              ;  profile flags 
   (deviceManufacturer :OSType)                 ;  Registered with ICC consortium 
   (deviceModel :UInt32)                        ;  Registered with ICC consortium 
   (deviceAttributes (:array :UInt32 2))        ;  Attributes[0] is for device vendors, [1] is for ICC 
   (renderingIntent :UInt32)                    ;  preferred rendering intent of tagged object 
   (white :CMFixedXYZColor)                     ;  profile illuminant 
   (creator :OSType)                            ;  profile creator 
   (digest :CMProfileMD5)                       ;  Profile message digest 
   (reserved (:array :character 28))            ;  reserved for future use 
)

;type name? (%define-record :CM4Header (find-record-descriptor ':CM4Header))
(defrecord CMTagRecord
   (tag :OSType)                                ;  Registered with CS2 consortium 
   (elementOffset :UInt32)                      ;  Relative to start of CMProfile 
   (elementSize :UInt32)
)

;type name? (%define-record :CMTagRecord (find-record-descriptor ':CMTagRecord))
(defrecord CMTagElemTable
   (count :UInt32)
   (tagList (:array :CMTagRecord 1))            ;  variable size, determined by count 
)

;type name? (%define-record :CMTagElemTable (find-record-descriptor ':CMTagElemTable))
(defrecord CM2Profile
   (header :CM2Header)
   (tagTable :CMTagElemTable)
   (elemData (:array :character 1))             ;  variable size data for tagged element storage 
)

;type name? (%define-record :CM2Profile (find-record-descriptor ':CM2Profile))

(def-mactype :CM2ProfilePtr (find-mactype '(:pointer :CM2Profile)))

(def-mactype :CM2ProfileHandle (find-mactype '(:handle :CM2Profile)))
;  Tag Type Definitions 
(defrecord CMAdaptationMatrixType
   (typeDescriptor :OSType)                     ;  'sf32' = cmSigS15Fixed16Type 
   (reserved :UInt32)                           ;  fill with 0x00 
   (adaptationMatrix (:array :signed-long 9))   ;  fixed size of nine matrix entries 
)

;type name? (%define-record :CMAdaptationMatrixType (find-record-descriptor ':CMAdaptationMatrixType))
(defrecord CMCurveType
   (typeDescriptor :OSType)                     ;  'curv' = cmSigCurveType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (countValue :UInt32)                         ;  number of entries in table that follows 
   (data (:array :UInt16 1))                    ;  variable size, determined by countValue 
)

;type name? (%define-record :CMCurveType (find-record-descriptor ':CMCurveType))
(defrecord CMDataType
   (typeDescriptor :OSType)                     ;  'data' = cmSigDataType
   (reserved :UInt32)                           ;  fill with 0x00 
   (dataFlag :UInt32)                           ;  0 = ASCII, 1 = binary 
   (data (:array :character 1))                 ;  variable size, determined by tag element size 
)

;type name? (%define-record :CMDataType (find-record-descriptor ':CMDataType))
(defrecord CMDateTimeType
   (typeDescriptor :OSType)                     ;  'dtim' = cmSigDateTimeType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (dateTime :CMDateTime)                       ;  
)

;type name? (%define-record :CMDateTimeType (find-record-descriptor ':CMDateTimeType))
(defrecord CMLut16Type
   (typeDescriptor :OSType)                     ;  'mft2' = cmSigLut16Type 
   (reserved :UInt32)                           ;  fill with 0x00 
   (inputChannels :UInt8)                       ;  Number of input channels 
   (outputChannels :UInt8)                      ;  Number of output channels 
   (gridPoints :UInt8)                          ;  Number of clutTable grid points 
   (reserved2 :UInt8)                           ;  fill with 0x00 
   (matrix (:array :signed-long 9))             ;  
   (inputTableEntries :UInt16)                  ;  Number of entries in 1-D input luts 
   (outputTableEntries :UInt16)                 ;  Number of entries in 1-D output luts 
   (inputTable (:array :UInt16 1))              ;  variable size, determined by inputChannels*inputTableEntries 

; #if 0 /* NOTE: Field offsets are variable from here on. */
                                                ;  NOTE: Field offsets are variable from here on. 
#|                                              ;  In order to correctly reflect the actual format of this tag, some of the fields in 
                                                ;  this structure have been removed because they follow an array field of variable size. 
                                                ;  As a result, the size of this structure has changed from previous versions of this interface. 
                                                ;  Code that relies on sizeof(CMLut16Type) should be changed. 
   (CLUT (:array :UInt16 :UNKNOWN))             ;  variable size, determined by (gridPoints^inputChannels)*outputChannels 
   (outputTable (:array :UInt16 :UNKNOWN))      ;  variable size, determined by outputChannels*outputTableEntries 
 |#

; #endif

)

;type name? (%define-record :CMLut16Type (find-record-descriptor ':CMLut16Type))
(defrecord CMLut8Type
   (typeDescriptor :OSType)                     ;  'mft1' = cmSigLut8Type 
   (reserved :UInt32)                           ;  fill with 0x00 
   (inputChannels :UInt8)                       ;  Number of input channels 
   (outputChannels :UInt8)                      ;  Number of output channels 
   (gridPoints :UInt8)                          ;  Number of clutTable grid points 
   (reserved2 :UInt8)                           ;  fill with 0x00 
   (matrix (:array :signed-long 9))             ;  
   (inputTable (:array :UInt8 1))               ;  variable size, determined by inputChannels*256 

; #if 0 /* NOTE: Field offsets are variable from here on. */
                                                ;  NOTE: Field offsets are variable from here on. 
#|                                              ;  In order to correctly reflect the actual format of this tag, some of the fields in 
                                                ;  this structure have been removed because they follow an array field of variable size. 
                                                ;  As a result, the size of this structure has changed from previous versions of this interface. 
                                                ;  Code that relies on sizeof(CMLut8Type) should be changed. 
   (CLUT (:array :UInt8 :UNKNOWN))              ;  variable size, determined by (gridPoints^inputChannels)*outputChannels 
   (outputTable (:array :UInt8 :UNKNOWN))       ;  variable size, determined by outputChannels*256 
 |#

; #endif

)

;type name? (%define-record :CMLut8Type (find-record-descriptor ':CMLut8Type))
(defrecord CMMultiFunctLutType
   (typeDescriptor :OSType)                     ;  'mAB ' = cmSigMultiFunctA2BType or 'mBA ' = cmSigMultiFunctB2AType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (inputChannels :UInt8)                       ;  Number of input channels 
   (outputChannels :UInt8)                      ;  Number of output channels 
   (reserved2 :UInt16)                          ;  fill with 0x00 
   (offsetBcurves :UInt32)                      ;  offset to first "B" curve 
   (offsetMatrix :UInt32)                       ;  offset to 3x4 matrix 
   (offsetMcurves :UInt32)                      ;  offset to first "M" curve 
   (offsetCLUT :UInt32)                         ;  offset to multi-dimensional LUT of type CMMultiFunctCLUTType 
   (offsetAcurves :UInt32)                      ;  offset to first "A" curve 
   (data (:array :UInt8 1))                     ;  variable size 
)

;type name? (%define-record :CMMultiFunctLutType (find-record-descriptor ':CMMultiFunctLutType))

(%define-record :CMMultiFunctLutA2BType (find-record-descriptor ':CMMultiFunctLutType))

(%define-record :CMMultiFunctLutB2AType (find-record-descriptor ':CMMultiFunctLutType))
(defrecord CMMultiFunctCLUTType
   (gridPoints (:array :UInt8 16))              ;  grigpoints for each input channel dimension (remaining are 0) 
   (entrySize :UInt8)                           ;  bytes per lut enrty (1 or 2) 
   (reserved (:array :UInt8 3))                 ;  fill with 0x00 
   (data (:array :UInt8 1))                     ;  variable size, determined by above 
)

;type name? (%define-record :CMMultiFunctCLUTType (find-record-descriptor ':CMMultiFunctCLUTType))
(defrecord CMMeasurementType
   (typeDescriptor :OSType)                     ;  'meas' = cmSigMeasurementType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (standardObserver :UInt32)                   ;  cmStdobsUnknown, cmStdobs1931TwoDegrees, cmStdobs1964TenDegrees 
   (backingXYZ :CMFixedXYZColor)                ;  absolute XYZ values of backing 
   (geometry :UInt32)                           ;  cmGeometryUnknown, cmGeometry045or450 (0/45), cmGeometry0dord0 (0/d or d/0) 
   (flare :UInt32)                              ;  cmFlare0, cmFlare100 
   (illuminant :UInt32)                         ;  cmIlluminantUnknown, cmIlluminantD50, ... 
)

;type name? (%define-record :CMMeasurementType (find-record-descriptor ':CMMeasurementType))
(defrecord CMNamedColorType
   (typeDescriptor :OSType)                     ;  'ncol' = cmSigNamedColorType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (vendorFlag :UInt32)                         ;  
   (count :UInt32)                              ;  count of named colors in array that follows 
   (prefixName (:array :UInt8 1))               ;  variable size, max = 32 

; #if 0 /* NOTE: Field offsets are variable from here on. */
                                                ;  NOTE: Field offsets are variable from here on. 
#|                                              ;  In order to correctly reflect the actual format of this tag, some of the fields in 
                                                ;  this structure have been removed because they follow an array field of variable size. 
                                                ;  As a result, the size of this structure has changed from previous versions of this interface. 
                                                ;  Code that relies on sizeof(CMNamedColorType) should be changed. 
   (suffixName (:array :UInt8 :UNKNOWN))        ;  variable size, max = 32 
   (rootName (:array :UInt8 :UNKNOWN))          ;  variable size, max = 32 
   (colorCoords (:array :UInt8 :UNKNOWN))       ;  variable size 
                                                ;  variable size 
 |#

; #endif

)

;type name? (%define-record :CMNamedColorType (find-record-descriptor ':CMNamedColorType))
(defrecord CMNamedColor2EntryType
   (rootName (:array :UInt8 32))                ;  32 byte field.  7 bit ASCII null terminated 
   (PCSColorCoords (:array :UInt16 3))          ;  Lab or XYZ color 
   (DeviceColorCoords (:array :UInt16 1))       ;  variable size 
)

;type name? (%define-record :CMNamedColor2EntryType (find-record-descriptor ':CMNamedColor2EntryType))
(defrecord CMNamedColor2Type
   (typeDescriptor :OSType)                     ;  'ncl2' = cmSigNamedColor2Type 
   (reserved :UInt32)                           ;  fill with 0x00 
   (vendorFlag :UInt32)                         ;  lower 16 bits reserved for ICC use 
   (count :UInt32)                              ;  count of named colors in array that follows 
   (deviceChannelCount :UInt32)                 ;  number of device channels, 0 indicates no device value available 
   (prefixName (:array :UInt8 32))              ;  Fixed 32 byte size.  7 bit ASCII null terminated 
   (suffixName (:array :UInt8 32))              ;  Fixed 32 byte size.  7 bit ASCII null terminated 
   (data (:array :character 1))                 ;  variable size data for CMNamedColor2EntryType 
)

;type name? (%define-record :CMNamedColor2Type (find-record-descriptor ':CMNamedColor2Type))
(defrecord CMNativeDisplayInfo
   (dataSize :UInt32)                           ;  Size of this structure 
   (redPhosphor :CMFixedXYColor)                ;  Phosphors - native cromaticity values of the display  
   (greenPhosphor :CMFixedXYColor)
   (bluePhosphor :CMFixedXYColor)
   (whitePoint :CMFixedXYColor)
   (redGammaValue :signed-long)                 ;  Gammas - native gamma values of the display 
   (greenGammaValue :signed-long)
   (blueGammaValue :signed-long)
                                                ;   Gamma tables - if if gammaChannels is not zero, 
                                                ;   native gamma tables are preferred over values 
                                                ;   redGammaValue, greenGammaValue, blueGammaValue 
   (gammaChannels :UInt16)                      ;  # of gamma channels (1 or 3) 
   (gammaEntryCount :UInt16)                    ;  1-based number of entries per channel 
   (gammaEntrySize :UInt16)                     ;  size in bytes of each entry 
   (gammaData (:array :character 1))            ;  variable size, determined by channels*entryCount*entrySize 
)

;type name? (%define-record :CMNativeDisplayInfo (find-record-descriptor ':CMNativeDisplayInfo))
(defrecord CMNativeDisplayInfoType
   (typeDescriptor :OSType)                     ;  'ndin' = cmSigNativeDisplayInfoType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (nativeDisplayInfo :CMNativeDisplayInfo)     ;  data of type CMNativeDisplayInfo 
)

;type name? (%define-record :CMNativeDisplayInfoType (find-record-descriptor ':CMNativeDisplayInfoType))
(defrecord CMParametricCurveType
   (typeDescriptor :OSType)                     ;  'para' = cmSigParametricCurveType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (functionType :UInt16)                       ;  cmParametricType0, cmParametricType1, etc. 
   (reserved2 :UInt16)                          ;  fill with 0x00 
   (value (:array :signed-long 1))              ;  variable size, determined by functionType 
)

;type name? (%define-record :CMParametricCurveType (find-record-descriptor ':CMParametricCurveType))
(defrecord CMTextDescriptionType
   (typeDescriptor :OSType)                     ;  'desc' = cmSigProfileDescriptionType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (ASCIICount :UInt32)                         ;  Count of bytes (including null terminator)  
   (ASCIIName (:array :UInt8 2))                ;  variable size, determined by ASCIICount.  7 bit ASCII null terminated 

; #if 0 /* NOTE: Field offsets are variable from here on. */
                                                ;  NOTE: Field offsets are variable from here on. 
#|                                              ;  In order to correctly reflect the actual format of this tag, some of the fields in 
                                                ;  this structure have been removed because they follow an array field of variable size. 
                                                ;  As a result, the size of this structure has changed from previous versions of this interface. 
                                                ;  Code that relies on sizeof(CMTextDescriptionType) should be changed. 
   (UniCodeCode :UInt32)                        ;  Unused 
   (UniCodeCount :UInt32)                       ;  Count of 2-byte characters (including null terminator) 
   (UniCodeName (:array :UInt8 :UNKNOWN))       ;  variable size, determined by UniCodeCount 
   (ScriptCodeCode :SInt16)                     ;  Mac-defined script code 
   (ScriptCodeCount :UInt8)                     ;  Count of bytes (including null terminator) 
   (ScriptCodeName (:array :UInt8 :UNKNOWN))    ;  variable size, determined by ScriptCodeCount 
 |#

; #endif

)

;type name? (%define-record :CMTextDescriptionType (find-record-descriptor ':CMTextDescriptionType))
(defrecord CMTextType
   (typeDescriptor :OSType)                     ;  'text' = cmSigTextType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (text (:array :UInt8 1))                     ;  variable size, determined by tag element size 
)

;type name? (%define-record :CMTextType (find-record-descriptor ':CMTextType))
(defrecord CMUnicodeTextType
   (typeDescriptor :OSType)                     ;  'utxt' = cmSigUnicodeTextType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (text (:array :UInt16 1))                    ;  variable size, determined by tag element size  
)

;type name? (%define-record :CMUnicodeTextType (find-record-descriptor ':CMUnicodeTextType))
(defrecord CMScreeningChannelRec
   (frequency :signed-long)
   (angle :signed-long)
   (spotFunction :UInt32)
)

;type name? (%define-record :CMScreeningChannelRec (find-record-descriptor ':CMScreeningChannelRec))
(defrecord CMScreeningType
   (typeDescriptor :OSType)                     ;  'scrn' = cmSigScreeningType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (screeningFlag :UInt32)                      ;  bit 0 : use printer default screens, bit 1 : inch/cm 
   (channelCount :UInt32)                       ;  
   (channelInfo (:array :CMScreeningChannelRec 1));  variable size, determined by channelCount 
)

;type name? (%define-record :CMScreeningType (find-record-descriptor ':CMScreeningType))
(defrecord CMSignatureType
   (typeDescriptor :OSType)                     ;  'sig ' = cmSigSignatureType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (signature :OSType)
)

;type name? (%define-record :CMSignatureType (find-record-descriptor ':CMSignatureType))
(defrecord CMS15Fixed16ArrayType
   (typeDescriptor :OSType)                     ;  'sf32' = cmSigS15Fixed16Type 
   (reserved :UInt32)                           ;  fill with 0x00 
   (value (:array :signed-long 1))              ;  variable size, determined by tag element size 
)

;type name? (%define-record :CMS15Fixed16ArrayType (find-record-descriptor ':CMS15Fixed16ArrayType))
(defrecord CMU16Fixed16ArrayType
   (typeDescriptor :OSType)                     ;  'uf32' = cmSigU16Fixed16Type 
   (reserved :UInt32)                           ;  fill with 0x00 
   (value (:array :UInt32 1))                   ;  variable size, determined by tag element size 
)

;type name? (%define-record :CMU16Fixed16ArrayType (find-record-descriptor ':CMU16Fixed16ArrayType))
(defrecord CMUInt8ArrayType
   (typeDescriptor :OSType)                     ;  'ui08' = cmSigUInt8Type 
   (reserved :UInt32)                           ;  fill with 0x00 
   (value (:array :UInt8 1))                    ;  variable size, determined by tag element size 
)

;type name? (%define-record :CMUInt8ArrayType (find-record-descriptor ':CMUInt8ArrayType))
(defrecord CMUInt16ArrayType
   (typeDescriptor :OSType)                     ;  'ui16' = cmSigUInt16Type 
   (reserved :UInt32)                           ;  fill with 0x00 
   (value (:array :UInt16 1))                   ;  variable size, determined by tag element size 
)

;type name? (%define-record :CMUInt16ArrayType (find-record-descriptor ':CMUInt16ArrayType))
(defrecord CMUInt32ArrayType
   (typeDescriptor :OSType)                     ;  'ui32' = cmSigUInt32Type 
   (reserved :UInt32)                           ;  fill with 0x00 
   (value (:array :UInt32 1))                   ;  variable size, determined by tag element size 
)

;type name? (%define-record :CMUInt32ArrayType (find-record-descriptor ':CMUInt32ArrayType))
(defrecord CMUInt64ArrayType
   (typeDescriptor :OSType)                     ;  'ui64' = cmSigUInt64Type 
   (reserved :UInt32)                           ;  fill with 0x00 
   (value (:array :UInt32 1))                   ;  variable size, determined by tag element size 
)

;type name? (%define-record :CMUInt64ArrayType (find-record-descriptor ':CMUInt64ArrayType))
(defrecord CMViewingConditionsType
   (typeDescriptor :OSType)                     ;  'view' = cmSigViewingConditionsType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (illuminant :CMFixedXYZColor)                ;  absolute XYZs of illuminant  in cd/m^2 
   (surround :CMFixedXYZColor)                  ;  absolute XYZs of surround in cd/m^2 
   (stdIlluminant :UInt32)                      ;  see definitions of std illuminants 
)

;type name? (%define-record :CMViewingConditionsType (find-record-descriptor ':CMViewingConditionsType))
(defrecord CMXYZType
   (typeDescriptor :OSType)                     ;  'XYZ ' = cmSigXYZType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (XYZ (:array :CMFixedXYZColor 1))            ;  variable size, determined by tag element size 
)

;type name? (%define-record :CMXYZType (find-record-descriptor ':CMXYZType))
(defrecord CMProfileSequenceDescType
   (typeDescriptor :OSType)                     ;  'pseq' = cmProfileSequenceDescTag 
   (reserved :UInt32)                           ;  fill with 0x00 
   (count :UInt32)                              ;  Number of descriptions 
   (data (:array :character 1))                 ;  variable size data explained in ICC spec 
)

;type name? (%define-record :CMProfileSequenceDescType (find-record-descriptor ':CMProfileSequenceDescType))
(defrecord CMUcrBgType
   (typeDescriptor :OSType)                     ;  'bfd ' = cmSigUcrBgType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (ucrCount :UInt32)                           ;  Number of UCR entries 
   (ucrValues (:array :UInt16 1))               ;  variable size, determined by ucrCount 

; #if 0 /* NOTE: Field offsets are variable from here on. */
                                                ;  NOTE: Field offsets are variable from here on. 
#|                                              ;  In order to correctly reflect the actual format of this tag, some of the fields in 
                                                ;  this structure have been removed because they follow an array field of variable size. 
                                                ;  As a result, the size of this structure has changed from previous versions of this interface. 
                                                ;  Code that relies on sizeof(CMUcrBgType) should be changed. 
   (bgCount :UInt32)                            ;  Number of BG entries 
   (bgValues (:array :UInt16 :UNKNOWN))         ;  variable size, determined by bgCount 
   (ucrbgASCII (:array :UInt8 :UNKNOWN))        ;  null terminated ASCII string 
 |#

; #endif

)

;type name? (%define-record :CMUcrBgType (find-record-descriptor ':CMUcrBgType))
;  Private Tag Type Definitions 
(defrecord CMIntentCRDVMSize
   (renderingIntent :signed-long)               ;  rendering intent 
   (VMSize :UInt32)                             ;  VM size taken up by the CRD 
)

;type name? (%define-record :CMIntentCRDVMSize (find-record-descriptor ':CMIntentCRDVMSize))
(defrecord CMPS2CRDVMSizeType
   (typeDescriptor :OSType)                     ;  'psvm' = cmSigPS2CRDVMSizeType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (count :UInt32)                              ;  number of intent entries 
   (intentCRD (:array :CMIntentCRDVMSize 1))    ;  variable size, determined by count 
)

;type name? (%define-record :CMPS2CRDVMSizeType (find-record-descriptor ':CMPS2CRDVMSizeType))

(defconstant $cmVideoCardGammaTableType 0)
(defconstant $cmVideoCardGammaFormulaType 1)
(defrecord CMVideoCardGammaTable
   (channels :UInt16)                           ;  # of gamma channels (1 or 3) 
   (entryCount :UInt16)                         ;  1-based number of entries per channel 
   (entrySize :UInt16)                          ;  size in bytes of each entry 
   (data (:array :character 1))                 ;  variable size, determined by channels*entryCount*entrySize 
)

;type name? (%define-record :CMVideoCardGammaTable (find-record-descriptor ':CMVideoCardGammaTable))
(defrecord CMVideoCardGammaFormula
   (redGamma :signed-long)                      ;  must be > 0.0 
   (redMin :signed-long)                        ;  must be > 0.0 and < 1.0 
   (redMax :signed-long)                        ;  must be > 0.0 and < 1.0 
   (greenGamma :signed-long)                    ;  must be > 0.0 
   (greenMin :signed-long)                      ;  must be > 0.0 and < 1.0 
   (greenMax :signed-long)                      ;  must be > 0.0 and < 1.0 
   (blueGamma :signed-long)                     ;  must be > 0.0 
   (blueMin :signed-long)                       ;  must be > 0.0 and < 1.0 
   (blueMax :signed-long)                       ;  must be > 0.0 and < 1.0 
)

;type name? (%define-record :CMVideoCardGammaFormula (find-record-descriptor ':CMVideoCardGammaFormula))
(defrecord CMVideoCardGamma
   (tagType :UInt32)
   (:variant
   (
   (table :CMVideoCardGammaTable)
   )
   (
   (formula :CMVideoCardGammaFormula)
   )
   )
)

;type name? (%define-record :CMVideoCardGamma (find-record-descriptor ':CMVideoCardGamma))
(defrecord CMVideoCardGammaType
   (typeDescriptor :OSType)                     ;  'vcgt' = cmSigVideoCardGammaType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (gamma :CMVideoCardGamma)
)

;type name? (%define-record :CMVideoCardGammaType (find-record-descriptor ':CMVideoCardGammaType))
(defrecord CMMakeAndModel
   (manufacturer :OSType)
   (model :UInt32)
   (serialNumber :UInt32)
   (manufactureDate :UInt32)
   (reserved1 :UInt32)                          ;  fill with 0x00 
   (reserved2 :UInt32)                          ;  fill with 0x00 
   (reserved3 :UInt32)                          ;  fill with 0x00 
   (reserved4 :UInt32)                          ;  fill with 0x00 
)

;type name? (%define-record :CMMakeAndModel (find-record-descriptor ':CMMakeAndModel))
(defrecord CMMakeAndModelType
   (typeDescriptor :OSType)                     ;  'mmod' = cmSigMakeAndModelType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (makeAndModel :CMMakeAndModel)
)

;type name? (%define-record :CMMakeAndModelType (find-record-descriptor ':CMMakeAndModelType))
(defrecord CMMultiLocalizedUniCodeEntryRec
   (languageCode (:array :character 2))         ;  language code from ISO-639 
   (regionCode (:array :character 2))           ;  region code from ISO-3166 
   (textLength :UInt32)                         ;  the length in bytes of the string 
   (textOffset :UInt32)                         ;  the offset from the start of tag in bytes 
)

;type name? (%define-record :CMMultiLocalizedUniCodeEntryRec (find-record-descriptor ':CMMultiLocalizedUniCodeEntryRec))
(defrecord CMMultiLocalizedUniCodeType
   (typeDescriptor :OSType)                     ;  'mluc' = cmSigMultiLocalizedUniCodeType 
   (reserved :UInt32)                           ;  fill with 0x00 
   (entryCount :UInt32)                         ;  1-based number of name records that follow 
   (entrySize :UInt32)                          ;  size in bytes of name records that follow 
                                                ;  variable-length data for storage of CMMultiLocalizedUniCodeEntryRec 
                                                ;  variable-length data for storage of Unicode strings
)

;type name? (%define-record :CMMultiLocalizedUniCodeType (find-record-descriptor ':CMMultiLocalizedUniCodeType))
; **********************************************************************
; ************** ColorSync 1.0 profile specification *******************
; **********************************************************************

(defconstant $cmGrayResponse 0)
(defconstant $cmRedResponse 1)
(defconstant $cmGreenResponse 2)
(defconstant $cmBlueResponse 3)
(defconstant $cmCyanResponse 4)
(defconstant $cmMagentaResponse 5)
(defconstant $cmYellowResponse 6)
(defconstant $cmUcrResponse 7)
(defconstant $cmBgResponse 8)
(defconstant $cmOnePlusLastResponse 9)
;  Device types 

(defconstant $cmMonitorDevice :|mntr|)
(defconstant $cmScannerDevice :|scnr|)
(defconstant $cmPrinterDevice :|prtr|)
(defrecord CMIString
   (theScript :SInt16)
   (theString (:string 63))
)

;type name? (%define-record :CMIString (find-record-descriptor ':CMIString))
;  Profile options 

(defconstant $cmPerceptualMatch 0)              ;  Default. For photographic images 

(defconstant $cmColorimetricMatch 1)            ;  Exact matching when possible 

(defconstant $cmSaturationMatch 2)              ;  For solid colors 

;  Profile flags 

(defconstant $cmNativeMatchingPreferred 1)      ;  Default to native not preferred 

(defconstant $cmTurnOffCache 2)                 ;  Default to turn on CMM cache 


(def-mactype :CMMatchOption (find-mactype ':signed-long))

(def-mactype :CMMatchFlag (find-mactype ':signed-long))
(defrecord CMHeader
   (size :UInt32)
   (CMMType :OSType)
   (applProfileVersion :UInt32)
   (dataType :OSType)
   (deviceType :OSType)
   (deviceManufacturer :OSType)
   (deviceModel :UInt32)
   (deviceAttributes (:array :UInt32 2))
   (profileNameOffset :UInt32)
   (customDataOffset :UInt32)
   (flags :signed-long)
   (options :signed-long)
   (white :CMXYZColor)
   (black :CMXYZColor)
)

;type name? (%define-record :CMHeader (find-record-descriptor ':CMHeader))
(defrecord CMProfileChromaticities
   (red :CMXYZColor)
   (green :CMXYZColor)
   (blue :CMXYZColor)
   (cyan :CMXYZColor)
   (magenta :CMXYZColor)
   (yellow :CMXYZColor)
)

;type name? (%define-record :CMProfileChromaticities (find-record-descriptor ':CMProfileChromaticities))
(defrecord CMProfileResponse
   (counts (:array :UInt16 9))
   (data (:array :UInt16 1))                    ;  Variable size 
)

;type name? (%define-record :CMProfileResponse (find-record-descriptor ':CMProfileResponse))
(defrecord CMProfile
   (header :CMHeader)
   (profile :CMProfileChromaticities)
   (response :CMProfileResponse)
   (profileName :CMIString)
   (customData (:array :character 1))           ;  Variable size 
)

;type name? (%define-record :CMProfile (find-record-descriptor ':CMProfile))

(def-mactype :CMProfilePtr (find-mactype '(:pointer :CMProfile)))

(def-mactype :CMProfileHandle (find-mactype '(:handle :CMProfile)))
; #pragma options align=reset

; #endif /* __CMICCPROFILE__ */


(provide-interface "CMICCProfile")