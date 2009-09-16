(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Translation.h"
; at Sunday July 2,2006 7:25:06 pm.
; 
;      File:       HIToolbox/Translation.h
;  
;      Contains:   Translation Manager (Macintosh Easy Open) Interfaces.
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1991-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __TRANSLATION__
; #define __TRANSLATION__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __TRANSLATIONEXTENSIONS__
#| #|
#include <HIToolboxTranslationExtensions.h>
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
; 
;    Carbon clients should use Translation Services. The definitions below will NOT work for Carbon and
;    are only defined for those files that need to build pre-Carbon applications.
; 
;  enumerated types on how a document can be opened

(def-mactype :DocOpenMethod (find-mactype ':SInt16))

(defconstant $domCannot 0)
(defconstant $domNative 1)
(defconstant $domTranslateFirst 2)
(defconstant $domWildcard 3)
;  0L terminated array of OSTypes, or FileTypes
(defrecord TypesBlock
   (contents (:array :OSType 64))
)
(def-mactype :TypesBlockPtr (find-mactype '(:pointer :OSType)))
;  Progress dialog resource ID

(defconstant $kTranslationScrapProgressDialogID -16555)
;  block of data that describes how to translate
(defrecord FileTranslationSpec
   (componentSignature :OSType)
   (translationSystemInfo :pointer)
   (src :FileTypeSpec)
   (dst :FileTypeSpec)
)

;type name? (%define-record :FileTranslationSpec (find-record-descriptor ':FileTranslationSpec))

(def-mactype :FileTranslationSpecArrayPtr (find-mactype '(:pointer :FileTranslationSpec)))

(def-mactype :FileTranslationSpecArrayHandle (find-mactype '(:handle :FileTranslationSpec)))
; 
;  *  GetFileTypesThatAppCanNativelyOpen()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    There is no direct replacement at this time.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in Translation 1.0 and later
;  

(deftrap-inline "_GetFileTypesThatAppCanNativelyOpen" 
   ((appVRefNumHint :SInt16)
    (appSignature :OSType)
    (nativeTypes (:pointer :FILETYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  ExtendFileTypeList()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    Use TranslationCreateWithSourceArray instead.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in Translation 1.0 and later
;  

(deftrap-inline "_ExtendFileTypeList" 
   ((originalTypeList (:pointer :FILETYPE))
    (numberOriginalTypes :SInt16)
    (extendedTypeList (:pointer :FILETYPE))
    (numberExtendedTypes (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  CanDocBeOpened()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    Use the Launch Services API instead.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in Translation 1.0 and later
;  

(deftrap-inline "_CanDocBeOpened" 
   ((targetDocument (:pointer :FSSpec))
    (appVRefNumHint :SInt16)
    (appSignature :OSType)
    (nativeTypes (:pointer :FILETYPE))
    (onlyNative :Boolean)
    (howToOpen (:pointer :DOCOPENMETHOD))
    (howToTranslate (:pointer :FileTranslationSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  GetFileTranslationPaths()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    Use TranslationCreateWithSourceArray instead.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in Translation 1.0 and later
;  

(deftrap-inline "_GetFileTranslationPaths" 
   ((srcDocument (:pointer :FSSpec))
    (dstDocType :OSType)
    (maxResultCount :UInt16)
    (resultBuffer (:pointer :FileTranslationSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :SInt16
() )
; 
;  *  GetPathFromTranslationDialog()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    There is no direct replacement at this time, but all the
;  *    necessary information can be obtained from the Launch Services,
;  *    Translation Services and Uniform Type Identification APIs.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in Translation 1.0 and later
;  

(deftrap-inline "_GetPathFromTranslationDialog" 
   ((theDocument (:pointer :FSSpec))
    (theApplication (:pointer :FSSpec))
    (typeList (:pointer :OSType))
    (howToOpen (:pointer :DOCOPENMETHOD))
    (howToTranslate (:pointer :FileTranslationSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  TranslateFile()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    Use TranslationPerformForFile or TranslationPerformForURL instead.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in Translation 1.0 and later
;  

(deftrap-inline "_TranslateFile" 
   ((sourceDocument (:pointer :FSSpec))
    (destinationDocument (:pointer :FSSpec))
    (howToTranslate (:pointer :FileTranslationSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  GetDocumentKindString()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    Use the Launch Services API instead.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in Translation 1.0 and later
;  

(deftrap-inline "_GetDocumentKindString" 
   ((docVRefNum :SInt16)
    (docType :OSType)
    (docCreator :OSType)
    (kindString (:pointer :Str63))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  GetTranslationExtensionName()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    There is no direct replacement at this time, but
;  *    TranslationCopySourceType and TranslationCopyDestinationType in
;  *    conjunction with UTTypeCopyDescription will provide useful user
;  *    level information.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in Translation 1.0 and later
;  

(deftrap-inline "_GetTranslationExtensionName" 
   ((translationMethod (:pointer :FileTranslationSpec))
    (extensionName (:pointer :STR31))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  GetScrapDataProcPtr
;  

(def-mactype :GetScrapDataProcPtr (find-mactype ':pointer)); (ScrapType requestedFormat , Handle dataH , void * srcDataGetterRefCon)

(def-mactype :GetScrapDataUPP (find-mactype '(:pointer :OpaqueGetScrapDataProcPtr)))
; 
;  *  NewGetScrapDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewGetScrapDataUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   (:pointer :OpaqueGetScrapDataProcPtr)
() )
; 
;  *  DisposeGetScrapDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeGetScrapDataUPP" 
   ((userUPP (:pointer :OpaqueGetScrapDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   nil
() )
; 
;  *  InvokeGetScrapDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeGetScrapDataUPP" 
   ((requestedFormat :FourCharCode)
    (dataH :Handle)
    (srcDataGetterRefCon :pointer)
    (userUPP (:pointer :OpaqueGetScrapDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )

(def-mactype :GetScrapData (find-mactype ':GetScrapDataUPP))
; 
;  *  TranslateScrap()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    Use TranslationPerformForData instead.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in Translation 1.0 and later
;  

(deftrap-inline "_TranslateScrap" 
   ((sourceDataGetter (:pointer :OpaqueGetScrapDataProcPtr))
    (sourceDataGetterRefCon :pointer)
    (destinationFormat :FourCharCode)
    (destinationData :Handle)
    (progressDialogID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __TRANSLATION__ */


(provide-interface "Translation")