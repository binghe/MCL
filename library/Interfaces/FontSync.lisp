(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:FontSync.h"
; at Sunday July 2,2006 7:24:33 pm.
; 
;      File:       QD/FontSync.h
;  
;      Contains:   Public interface for FontSync
;  
;      Version:    Quickdraw-150~1
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __FONTSYNC__
; #define __FONTSYNC__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __FONTS__
#| #|
#include <QDFonts.h>
#endif
|#
 |#
; #ifndef __SFNTTYPES__
#| #|
#include <ATSSFNTTypes.h>
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
; #pragma options align=power
;  Matching Options 

(def-mactype :FNSMatchOptions (find-mactype ':UInt32))

(defconstant $kFNSMatchNames 1)                 ;  font names must match 

(defconstant $kFNSMatchTechnology 2)            ;  scaler technology must match 

(defconstant $kFNSMatchGlyphs 4)                ;  glyph data must match 

(defconstant $kFNSMatchEncodings 8)             ;  cmaps must match 

(defconstant $kFNSMatchQDMetrics 16)            ;  QuickDraw Text metrics must match 

(defconstant $kFNSMatchATSUMetrics 32)          ;  ATSUI metrics (incl. vertical) must match 

(defconstant $kFNSMatchKerning 64)              ;  kerning data must match 

(defconstant $kFNSMatchWSLayout #x80)           ;  WorldScript layout tables must match 

(defconstant $kFNSMatchAATLayout #x100)         ;  AAT (incl. OpenType) layout tables must match 

(defconstant $kFNSMatchPrintEncoding #x200)     ;  PostScript font and glyph names and re-encoding vector must match 

(defconstant $kFNSMissingDataNoMatch #x80000000);  treat missing data as mismatch 

(defconstant $kFNSMatchAll #xFFFFFFFF)          ;  everything must match 

(defconstant $kFNSMatchDefaults 0)              ;  use global default match options 

; 
;  *  FNSMatchDefaultsGet()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSMatchDefaultsGet" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  Version control 

(def-mactype :FNSObjectVersion (find-mactype ':UInt32))

(defconstant $kFNSVersionDontCare 0)
(defconstant $kFNSCurSysInfoVersion 1)
;  No features defined yet.

(def-mactype :FNSFeatureFlags (find-mactype ':UInt32))
; 
;    The FontSync library version number is binary-coded decimal:
;    8 bits of major version, 4 minor version and 4 bits revision.
; 
(defrecord FNSSysInfo
   (iSysInfoVersion :UInt32)                    ;  fill this in before calling FNSSysInfoGet
   (oFeatures :UInt32)
   (oCurRefVersion :UInt32)
   (oMinRefVersion :UInt32)
   (oCurProfileVersion :UInt32)
   (oMinProfileVersion :UInt32)
   (oFontSyncVersion :UInt16)
)

;type name? (%define-record :FNSSysInfo (find-record-descriptor ':FNSSysInfo))
; 
;  *  FNSSysInfoGet()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSSysInfoGet" 
   ((ioInfo (:pointer :FNSSysInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  FontSync References 

(def-mactype :FNSFontReference (find-mactype '(:pointer :OpaqueFNSFontReference)))
; 
;  *  FNSReferenceGetVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceGetVersion" 
   ((iReference (:pointer :OpaqueFNSFontReference))
    (oVersion (:pointer :FNSOBJECTVERSION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSReferenceDispose()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceDispose" 
   ((iReference (:pointer :OpaqueFNSFontReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSReferenceMatch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceMatch" 
   ((iReference1 (:pointer :OpaqueFNSFontReference))
    (iReference2 (:pointer :OpaqueFNSFontReference))
    (iOptions :UInt32)
    (oFailedMatchOptions (:pointer :FNSMATCHOPTIONS));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSReferenceFlattenedSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceFlattenedSize" 
   ((iReference (:pointer :OpaqueFNSFontReference))
    (oFlattenedSize (:pointer :ByteCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSReferenceFlatten()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceFlatten" 
   ((iReference (:pointer :OpaqueFNSFontReference))
    (oFlatReference :pointer)                   ;  can be NULL 
    (oFlattenedSize (:pointer :ByteCount))      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSReferenceUnflatten()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceUnflatten" 
   ((iFlatReference :pointer)
    (iFlattenedSize :UInt32)
    (oReference (:pointer :FNSFONTREFERENCE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  FontSync Profiles 

(defconstant $kFNSCreatorDefault 0)
(defconstant $kFNSProfileFileType :|fnsp|)

(def-mactype :FNSFontProfile (find-mactype '(:pointer :OpaqueFNSFontProfile)))
; 
;  *  FNSProfileCreate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSProfileCreate" 
   ((iFile (:pointer :FSSpec))
    (iCreator :FourCharCode)
    (iEstNumRefs :UInt32)
    (iDesiredVersion :UInt32)
    (oProfile (:pointer :FNSFONTPROFILE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSProfileOpen()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSProfileOpen" 
   ((iFile (:pointer :FSSpec))
    (iOpenForWrite :Boolean)
    (oProfile (:pointer :FNSFONTPROFILE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSProfileCreateWithFSRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FNSProfileCreateWithFSRef" 
   ((iParentDirectory (:pointer :FSRef))
    (iNameLength :UInt32)
    (iName (:pointer :UniChar))
    (iCreator :FourCharCode)
    (iEstNumRefs :UInt32)
    (iDesiredVersion :UInt32)
    (oProfile (:pointer :FNSFONTPROFILE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  FNSProfileOpenWithFSRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FNSProfileOpenWithFSRef" 
   ((iFile (:pointer :FSRef))
    (iOpenForWrite :Boolean)
    (oProfile (:pointer :FNSFONTPROFILE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  FNSProfileGetVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSProfileGetVersion" 
   ((iProfile (:pointer :OpaqueFNSFontProfile))
    (oVersion (:pointer :FNSOBJECTVERSION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSProfileCompact()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSProfileCompact" 
   ((iProfile (:pointer :OpaqueFNSFontProfile))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSProfileClose()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSProfileClose" 
   ((iProfile (:pointer :OpaqueFNSFontProfile))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSProfileAddReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSProfileAddReference" 
   ((iProfile (:pointer :OpaqueFNSFontProfile))
    (iReference (:pointer :OpaqueFNSFontReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSProfileRemoveReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSProfileRemoveReference" 
   ((iProfile (:pointer :OpaqueFNSFontProfile))
    (iReference (:pointer :OpaqueFNSFontReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSProfileRemoveIndReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSProfileRemoveIndReference" 
   ((iProfile (:pointer :OpaqueFNSFontProfile))
    (iIndex :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSProfileClear()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSProfileClear" 
   ((iProfile (:pointer :OpaqueFNSFontProfile))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSProfileCountReferences()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSProfileCountReferences" 
   ((iProfile (:pointer :OpaqueFNSFontProfile))
    (oCount (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSProfileGetIndReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSProfileGetIndReference" 
   ((iProfile (:pointer :OpaqueFNSFontProfile))
    (iWhichReference :UInt32)
    (oReference (:pointer :FNSFONTREFERENCE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSProfileMatchReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSProfileMatchReference" 
   ((iProfile (:pointer :OpaqueFNSFontProfile))
    (iReference (:pointer :OpaqueFNSFontReference))
    (iMatchOptions :UInt32)
    (iOutputSize :UInt32)
    (oIndices (:pointer :UInt32))               ;  can be NULL 
    (oNumMatches (:pointer :ItemCount))         ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Mapping to and from Font Objects 
; 
;  *  FNSReferenceCreate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceCreate" 
   ((iFont :UInt32)
    (iDesiredVersion :UInt32)
    (oReference (:pointer :FNSFONTREFERENCE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSReferenceMatchFonts()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceMatchFonts" 
   ((iReference (:pointer :OpaqueFNSFontReference))
    (iMatchOptions :UInt32)
    (iOutputSize :UInt32)
    (oFonts (:pointer :FMFONT))                 ;  can be NULL 
    (oNumMatches (:pointer :ItemCount))         ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Mapping to and from Font Families 
; 
;  *  FNSReferenceCreateFromFamily()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceCreateFromFamily" 
   ((iFamily :SInt16)
    (iStyle :SInt16)
    (iDesiredVersion :UInt32)
    (oReference (:pointer :FNSFONTREFERENCE))   ;  can be NULL 
    (oActualStyle (:pointer :FMFONTSTYLE))      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSReferenceMatchFamilies()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceMatchFamilies" 
   ((iReference (:pointer :OpaqueFNSFontReference))
    (iMatchOptions :UInt32)
    (iOutputSize :UInt32)
    (oFonts (:pointer :FMFontFamilyInstance))   ;  can be NULL 
    (oNumMatches (:pointer :ItemCount))         ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  UI Support 
; 
;  *  FNSReferenceGetFamilyInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceGetFamilyInfo" 
   ((iReference (:pointer :OpaqueFNSFontReference))
    (oFamilyName (:pointer :STR255))            ;  can be NULL 
    (oFamilyNameScript (:pointer :SCRIPTCODE))  ;  can be NULL 
    (oActualStyle (:pointer :FMFONTSTYLE))      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSReferenceCountNames()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceCountNames" 
   ((iReference (:pointer :OpaqueFNSFontReference))
    (oNameCount (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSReferenceGetIndName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceGetIndName" 
   ((iReference (:pointer :OpaqueFNSFontReference))
    (iFontNameIndex :UInt32)
    (iMaximumNameLength :UInt32)
    (oName :pointer)                            ;  can be NULL 
    (oActualNameLength (:pointer :ByteCount))   ;  can be NULL 
    (oFontNameCode (:pointer :FONTNAMECODE))    ;  can be NULL 
    (oFontNamePlatform (:pointer :FONTPLATFORMCODE));  can be NULL 
    (oFontNameScript (:pointer :FONTSCRIPTCODE));  can be NULL 
    (oFontNameLanguage (:pointer :FONTLANGUAGECODE));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSReferenceFindName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSReferenceFindName" 
   ((iReference (:pointer :OpaqueFNSFontReference))
    (iFontNameCode :UInt32)
    (iFontNamePlatform :UInt32)
    (iFontNameScript :UInt32)
    (iFontNameLanguage :UInt32)
    (iMaximumNameLength :UInt32)
    (oName :pointer)                            ;  can be NULL 
    (oActualNameLength (:pointer :ByteCount))   ;  can be NULL 
    (oFontNameIndex (:pointer :ItemCount))      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Miscellany 
; 
;  *  FNSEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
;  

(deftrap-inline "_FNSEnabled" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __FONTSYNC__ */


(provide-interface "FontSync")