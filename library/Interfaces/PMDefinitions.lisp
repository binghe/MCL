(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PMDefinitions.h"
; at Sunday July 2,2006 7:24:42 pm.
; 
;      File:       PrintCore/PMDefinitions.h
;  
;      Contains:   Carbon Printing Manager Interfaces.
;  
;      Version:    PrintingCore-129~1
;  
;      Copyright:  © 1998-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __PMDEFINITIONS__
; #define __PMDEFINITIONS__
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
;  Printing objects 

(def-mactype :PMObject (find-mactype '(:pointer :void)))

(def-mactype :PMDialog (find-mactype '(:pointer :OpaquePMDialog)))

(def-mactype :PMPrintSettings (find-mactype '(:pointer :OpaquePMPrintSettings)))

(def-mactype :PMPageFormat (find-mactype '(:pointer :OpaquePMPageFormat)))

(def-mactype :PMPrintContext (find-mactype '(:pointer :OpaquePMPrintContext)))

(def-mactype :PMPrintSession (find-mactype '(:pointer :OpaquePMPrintSession)))

(def-mactype :PMPrinter (find-mactype '(:pointer :OpaquePMPrinter)))

(def-mactype :PMServer (find-mactype '(:pointer :OpaquePMServer)))

(def-mactype :PMPreset (find-mactype '(:pointer :OpaquePMPreset)))

(def-mactype :PMPaper (find-mactype '(:pointer :OpaquePMPaper)))

(defconstant $kPMCancel #x80)                   ;  user hit cancel button in dialog 

; #define kPMNoData           NULL        /* for general use */
; #define kPMDontWantSize     NULL        /* for parameters which return size information */
; #define kPMDontWantData     NULL        /* for parameters which return data */
; #define kPMDontWantBoolean  NULL        /* for parameters which take a boolean reference */
; #define kPMNoReference      NULL        /* for parameters which take an address pointer */
;  for parameters which take a PrintSettings reference 
; #define kPMNoPrintSettings              ((PMPrintSettings)NULL)
;  for parameters which take a PageFormat reference 
; #define kPMNoPageFormat                 ((PMPageFormat)NULL)
;  for parameters which take a Server reference 
; #define kPMServerLocal                  ((PMServer)NULL)

(def-mactype :PMDestinationType (find-mactype ':UInt16))

(defconstant $kPMDestinationInvalid 0)
(defconstant $kPMDestinationPrinter 1)
(defconstant $kPMDestinationFile 2)
(defconstant $kPMDestinationFax 3)
(defconstant $kPMDestinationPreview 4)
; #define kPMDestinationTypeDefault       kPMDestinationPrinter

(def-mactype :PMTag (find-mactype ':UInt32))
;  common tags 

(defconstant $kPMCurrentValue :|curr|)          ;  current setting or value 

(defconstant $kPMDefaultValue :|dflt|)          ;  default setting or value 

(defconstant $kPMMinimumValue :|minv|)          ;  the minimum setting or value 

(defconstant $kPMMaximumValue :|maxv|)          ;  the maximum setting or value 
;  profile tags 

(defconstant $kPMSourceProfile :|srcp|)         ;  source profile 
;  resolution tags 

(defconstant $kPMMinRange :|mnrg|)              ;  Min range supported by a printer 

(defconstant $kPMMaxRange :|mxrg|)              ;  Max range supported by a printer 

(defconstant $kPMMinSquareResolution :|mins|)   ;  Min with X and Y resolution equal 

(defconstant $kPMMaxSquareResolution :|maxs|)   ;  Max with X and Y resolution equal 

(defconstant $kPMDefaultResolution :|dftr|)     ;  printer default resolution 


(def-mactype :PMOrientation (find-mactype ':UInt16))

(defconstant $kPMPortrait 1)
(defconstant $kPMLandscape 2)
(defconstant $kPMReversePortrait 3)             ;  will revert to kPortrait for current drivers 

(defconstant $kPMReverseLandscape 4)            ;  will revert to kLandscape for current drivers 

;  Printer states 

(def-mactype :PMPrinterState (find-mactype ':UInt16))

(defconstant $kPMPrinterIdle 3)
(defconstant $kPMPrinterProcessing 4)
(defconstant $kPMPrinterStopped 5)

(defconstant $kSizeOfTPrint 120)                ;  size of old TPrint record 


(def-mactype :PMColorMode (find-mactype ':UInt16))

(defconstant $kPMBlackAndWhite 1)
(defconstant $kPMGray 2)
(defconstant $kPMColor 3)
(defconstant $kPMColorModeDuotone 4)            ;  2 channels 

(defconstant $kPMColorModeSpecialColor 5)       ;  to allow for special colors such as metalic, light cyan, etc. 


(def-mactype :PMColorSpaceModel (find-mactype ':UInt32))

(defconstant $kPMUnknownColorSpaceModel 0)
(defconstant $kPMGrayColorSpaceModel 1)
(defconstant $kPMRGBColorSpaceModel 2)
(defconstant $kPMCMYKColorSpaceModel 3)
(defconstant $kPMDevNColorSpaceModel 4)
(defconstant $kPMColorSpaceModelCount 4)
; #define kPMColorSpaceModelCount 4   /* total number of color space models supported */
;  Constants to define the ColorSync Intents. These intents may be used 
;  to set an intent part way through a page or for an entire document. 

(def-mactype :PMColorSyncIntent (find-mactype ':UInt32))

(defconstant $kPMColorIntentUndefined 0)        ;  User or application have not declared an intent, use the printer's default. 

(defconstant $kPMColorIntentAutomatic 1)        ;  Automatically match for photos and graphics anywhere on the page. 

(defconstant $kPMColorIntentPhoto 2)            ;  Use Photographic (cmPerceptual) intent for all contents. 

(defconstant $kPMColorIntentBusiness 4)         ;  Use Business Graphics (cmSaturation) intent for all contents. 

(defconstant $kPMColorIntentRelColor 8)         ;  Use Relative Colormetrics (Logo Colors) for the page. 

(defconstant $kPMColorIntentAbsColor 16)        ;  Use absolute colormetric for the page. 

(defconstant $kPMColorIntentUnused #xFFE0)      ;  Remaining bits unused at this time. 

;  Print quality modes "standard options" 

(def-mactype :PMQualityMode (find-mactype ':UInt32))

(defconstant $kPMQualityLowest 0)               ;  Absolute lowest print quality 

(defconstant $kPMQualityInkSaver 1)             ;  Saves ink but may be slower 

(defconstant $kPMQualityDraft 4)                ;  Print at highest speed, ink used is secondary consideration 

(defconstant $kPMQualityNormal 8)               ;  Print in printers "general usage" mode for good balance between quality and speed 

(defconstant $kPMQualityPhoto 11)               ;  Optimize quality of photos on the page. Speed is not a concern 

(defconstant $kPMQualityBest 13)                ;  Get best quality output for all objects and photos. 

(defconstant $kPMQualityHighest 15)             ;  Absolute highest quality attained from a printers 

;  Constants for our "standard" paper types 

(def-mactype :PMPaperType (find-mactype ':UInt32))

(defconstant $kPMPaperTypeUnknown 0)            ;  Not sure yet what paper type we have. 

(defconstant $kPMPaperTypePlain 1)              ;  Plain paper 

(defconstant $kPMPaperTypeCoated 2)             ;  Has a special coating for sharper images and text 

(defconstant $kPMPaperTypePremium 3)            ;  Special premium coated paper 

(defconstant $kPMPaperTypeGlossy 4)             ;  High gloss special coating 

(defconstant $kPMPaperTypeTransparency 5)       ;  Used for overheads 

(defconstant $kPMPaperTypeTShirt 6)             ;  Used to iron on t-shirts 

;  Scaling alignment: 

(def-mactype :PMScalingAlignment (find-mactype ':UInt16))

(defconstant $kPMScalingPinTopLeft 1)
(defconstant $kPMScalingPinTopRight 2)
(defconstant $kPMScalingPinBottomLeft 3)
(defconstant $kPMScalingPinBottomRight 4)
(defconstant $kPMScalingCenterOnPaper 5)
(defconstant $kPMScalingCenterOnImgArea 6)
;  Duplex binding directions: 

(def-mactype :PMDuplexBinding (find-mactype ':UInt16))

(defconstant $kPMDuplexBindingLeftRight 1)
(defconstant $kPMDuplexBindingTopDown 2)
;  Layout directions: 

(def-mactype :PMLayoutDirection (find-mactype ':UInt16))
;  Horizontal-major directions: 

(defconstant $kPMLayoutLeftRightTopBottom 1)    ;  English reading direction. 

(defconstant $kPMLayoutLeftRightBottomTop 2)
(defconstant $kPMLayoutRightLeftTopBottom 3)
(defconstant $kPMLayoutRightLeftBottomTop 4)    ;  Vertical-major directions: 

(defconstant $kPMLayoutTopBottomLeftRight 5)
(defconstant $kPMLayoutTopBottomRightLeft 6)
(defconstant $kPMLayoutBottomTopLeftRight 7)
(defconstant $kPMLayoutBottomTopRightLeft 8)
;  Page borders: 

(def-mactype :PMBorderType (find-mactype ':UInt16))

(defconstant $kPMBorderSingleHairline 1)
(defconstant $kPMBorderDoubleHairline 2)
(defconstant $kPMBorderSingleThickline 3)
(defconstant $kPMBorderDoubleThickline 4)
;  Useful Constants for PostScript Injection 

(defconstant $kPSPageInjectAllPages -1)         ;  specifies to inject on all pages 

(defconstant $kPSInjectionMaxDictSize 5)        ;  maximum size of a dictionary used for PSInjection 

;  PostScript Injection values for kPSInjectionPlacementKey 

(def-mactype :PSInjectionPlacement (find-mactype ':UInt16))

(defconstant $kPSInjectionBeforeSubsection 1)
(defconstant $kPSInjectionAfterSubsection 2)
(defconstant $kPSInjectionReplaceSubsection 3)
;  PostScript Injection values for kPSInjectionSectionKey 

(def-mactype :PSInjectionSection (find-mactype ':SInt32))
;  Job 

(defconstant $kInjectionSectJob 1)              ;  CoverPage 

(defconstant $kInjectionSectCoverPage 2)
;  PostScript Injection values for kPSInjectionSubSectionKey 

(def-mactype :PSInjectionSubsection (find-mactype ':SInt32))

(defconstant $kInjectionSubPSAdobe 1)           ;  %!PS-Adobe           

(defconstant $kInjectionSubPSAdobeEPS 2)        ;  %!PS-Adobe-3.0 EPSF-3.0    

(defconstant $kInjectionSubBoundingBox 3)       ;  BoundingBox          

(defconstant $kInjectionSubEndComments 4)       ;  EndComments          

(defconstant $kInjectionSubOrientation 5)       ;  Orientation          

(defconstant $kInjectionSubPages 6)             ;  Pages            

(defconstant $kInjectionSubPageOrder 7)         ;  PageOrder          

(defconstant $kInjectionSubBeginProlog 8)       ;  BeginProlog          

(defconstant $kInjectionSubEndProlog 9)         ;  EndProlog          

(defconstant $kInjectionSubBeginSetup 10)       ;  BeginSetup          

(defconstant $kInjectionSubEndSetup 11)         ;  EndSetup             

(defconstant $kInjectionSubBeginDefaults 12)    ;  BeginDefaults       

(defconstant $kInjectionSubEndDefaults 13)      ;  EndDefaults          

(defconstant $kInjectionSubDocFonts 14)         ;  DocumentFonts       

(defconstant $kInjectionSubDocNeededFonts 15)   ;  DocumentNeededFonts       

(defconstant $kInjectionSubDocSuppliedFonts 16) ;  DocumentSuppliedFonts  

(defconstant $kInjectionSubDocNeededRes 17)     ;  DocumentNeededResources    

(defconstant $kInjectionSubDocSuppliedRes 18)   ;  DocumentSuppliedResources

(defconstant $kInjectionSubDocCustomColors 19)  ;  DocumentCustomColors     

(defconstant $kInjectionSubDocProcessColors 20) ;  DocumentProcessColors  

(defconstant $kInjectionSubPlateColor 21)       ;  PlateColor          

(defconstant $kInjectionSubPageTrailer 22)      ;  PageTrailer           

(defconstant $kInjectionSubTrailer 23)          ;  Trailer              

(defconstant $kInjectionSubEOF 24)              ;  EOF                 

(defconstant $kInjectionSubBeginFont 25)        ;  BeginFont          

(defconstant $kInjectionSubEndFont 26)          ;  EndFont              

(defconstant $kInjectionSubBeginResource 27)    ;  BeginResource       

(defconstant $kInjectionSubEndResource 28)      ;  EndResource          

(defconstant $kInjectionSubPage 29)             ;  Page               

(defconstant $kInjectionSubBeginPageSetup 30)   ;  BeginPageSetup        

(defconstant $kInjectionSubEndPageSetup 31)     ;  EndPageSetup          


(def-mactype :PMPPDDomain (find-mactype ':UInt16))

(defconstant $kAllPPDDomains 1)
(defconstant $kSystemPPDDomain 2)
(defconstant $kLocalPPDDomain 3)
(defconstant $kNetworkPPDDomain 4)
(defconstant $kUserPPDDomain 5)
(defconstant $kCUPSPPDDomain 6)
;  Description types 
; #define kPMPPDDescriptionType           CFSTR("PMPPDDescriptionType")
;  Document format strings 
; #define kPMDocumentFormatDefault        CFSTR("com.apple.documentformat.default")
; #define kPMDocumentFormatPDF            CFSTR("application/pdf")
; #define kPMDocumentFormatPICT           CFSTR("application/vnd.apple.printing-pict")
; #define kPMDocumentFormatPICTPS         CFSTR("application/vnd.apple.printing-pict-ps")
; #define kPMDocumentFormatPICTPSwPSNormalizer  CFSTR("application/vnd.apple.printing-pict-ps-viapsnormalizer")
; #define kPMDocumentFormatPostScript     CFSTR("application/postscript")
;  Graphic context strings 
; #define kPMGraphicsContextDefault       CFSTR("com.apple.graphicscontext.default")
; #define kPMGraphicsContextQuickdraw     CFSTR("com.apple.graphicscontext.quickdraw")
; #define kPMGraphicsContextCoreGraphics  CFSTR("com.apple.graphicscontext.coregraphics")
;  Data format strings 
; #define kPMDataFormatPS                 kPMDocumentFormatPostScript
; #define kPMDataFormatPDF                kPMDocumentFormatPDF
; #define kPMDataFormatPICT               kPMDocumentFormatPICT
; #define kPMDataFormatPICTwPS            kPMDocumentFormatPICTPS
;  PostScript Injection Dictionary Keys 
; #define kPSInjectionSectionKey          CFSTR("section")
; #define kPSInjectionSubSectionKey       CFSTR("subsection")
; #define kPSInjectionPageKey             CFSTR("page")
; #define kPSInjectionPlacementKey        CFSTR("place")
; #define kPSInjectionPostScriptKey       CFSTR("psdata")
;  PDF Workflow Keys 
; #define kPDFWorkFlowItemURLKey          CFSTR("itemURL")
; #define kPDFWorkflowForlderURLKey       CFSTR("folderURL")
; #define kPDFWorkflowDisplayNameKey      CFSTR("displayName")
; #define kPDFWorkflowItemsKey            CFSTR("items")
;  OSStatus return codes 

(defconstant $kPMNoError 0)
(defconstant $kPMGeneralError -30870)
(defconstant $kPMOutOfScope -30871)             ;  an API call is out of scope 

(defconstant $kPMInvalidParameter -50)          ;  a required parameter is missing or invalid 

(defconstant $kPMNoDefaultPrinter -30872)       ;  no default printer selected 

(defconstant $kPMNotImplemented -30873)         ;  this API call is not supported 

(defconstant $kPMNoSuchEntry -30874)            ;  no such entry 

(defconstant $kPMInvalidPrintSettings -30875)   ;  the printsettings reference is invalid 

(defconstant $kPMInvalidPageFormat -30876)      ;  the pageformat reference is invalid 

(defconstant $kPMValueOutOfRange -30877)        ;  a value passed in is out of range 
;  the lock value was ignored 

(defconstant $kPMLockIgnored -30878)

(defconstant $kPMInvalidPrintSession -30879)    ;  the print session is invalid 

(defconstant $kPMInvalidPrinter -30880)         ;  the printer reference is invalid 

(defconstant $kPMObjectInUse -30881)            ;  the object is in use 
;  the preset is invalid 

(defconstant $kPMInvalidPreset -30882)

(defconstant $kPMPrintAllPages -1)

(defconstant $kPMUnlocked $false)
(defconstant $kPMLocked $true)
(defrecord PMRect
   (top :double-float)
   (left :double-float)
   (bottom :double-float)
   (right :double-float)
)

;type name? (%define-record :PMRect (find-record-descriptor ':PMRect))
(defrecord PMResolution
   (hRes :double-float)
   (vRes :double-float)
)

;type name? (%define-record :PMResolution (find-record-descriptor ':PMResolution))
(defrecord PMLanguageInfo
   (level (:string 32))
   (version (:string 32))
   (release (:string 32))
)

;type name? (%define-record :PMLanguageInfo (find-record-descriptor ':PMLanguageInfo))

(%define-record :PMPaperMargins (find-record-descriptor ':PMRect))
; #pragma options align=reset

; #endif /* __PMDEFINITIONS__ */


(provide-interface "PMDefinitions")