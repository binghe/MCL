(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ATSFont.h"
; at Sunday July 2,2006 7:23:46 pm.
; 
;      File:       ATS/ATSFont.h
;  
;      Contains:   Public interface to the font access and data management functions of ATS.
;  
;      Version:    ATS-135~1
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __ATSFONT__
; #define __ATSFONT__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __COREFOUNDATION__

(require-interface "CoreFoundation/CoreFoundation")

; #endif

; #ifndef __ATSTYPES__
#| #|
#include <ATSATSTypes.h>
#endif
|#
 |#
; #ifndef __SFNTTYPES__

(require-interface "ATS/SFNTTypes")

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

; #if PRAGMA_ENUM_ALWAYSINT
#| ; #pragma enumsalwaysint on
 |#

; #endif


(defconstant $kATSOptionFlagsDefault 0)
(defconstant $kATSOptionFlagsComposeFontPostScriptName 1);  ATSFontGetPostScriptName 

(defconstant $kATSOptionFlagsUseDataForkAsResourceFork #x100);  ATSFontActivateFromFileSpecification 

(defconstant $kATSOptionFlagsUseResourceFork #x200)
(defconstant $kATSOptionFlagsUseDataFork #x300)

(defconstant $kATSIterationCompleted -980)
(defconstant $kATSInvalidFontFamilyAccess -981)
(defconstant $kATSInvalidFontAccess -982)
(defconstant $kATSIterationScopeModified -983)
(defconstant $kATSInvalidFontTableAccess -984)
(defconstant $kATSInvalidFontContainerAccess -985)
(defconstant $kATSInvalidGlyphAccess -986)
;  Activation Option Flags 

(def-mactype :ATSFontContext (find-mactype ':UInt32))

(defconstant $kATSFontContextUnspecified 0)
(defconstant $kATSFontContextGlobal 1)
(defconstant $kATSFontContextLocal 2)

(defconstant $kATSOptionFlagsProcessSubdirectories 64);  Used by activation/deactivation & iteration 
;  Do not notify after global activation/deactivation 

(defconstant $kATSOptionFlagsDoNotNotify #x80)
;  Iteration Option Flags 

(defconstant $kATSOptionFlagsIterateByPrecedenceMask 32)
(defconstant $kATSOptionFlagsIterationScopeMask #x7000);  Mask option bits 12-14 for iteration scopes 

(defconstant $kATSOptionFlagsDefaultScope 0)
(defconstant $kATSOptionFlagsUnRestrictedScope #x1000)
(defconstant $kATSOptionFlagsRestrictedScope #x2000)

(def-mactype :ATSFontFormat (find-mactype ':UInt32))

(defconstant $kATSFontFormatUnspecified 0)

(def-mactype :ATSFontFamilyApplierFunction (find-mactype ':pointer)); (ATSFontFamilyRef iFamily , void * iRefCon)

(def-mactype :ATSFontApplierFunction (find-mactype ':pointer)); (ATSFontRef iFont , void * iRefCon)

(def-mactype :ATSFontFamilyIterator (find-mactype '(:pointer :ATSFontFamilyIterator_)))

(def-mactype :ATSFontIterator (find-mactype '(:pointer :ATSFontIterator_)))

(defconstant $kATSFontFilterCurrentVersion 0)
(def-mactype :ATSFontFilterSelector (find-mactype ':sint32))

(defconstant $kATSFontFilterSelectorUnspecified 0)
(defconstant $kATSFontFilterSelectorGeneration 3)
(defconstant $kATSFontFilterSelectorFontFamily 7)
(defconstant $kATSFontFilterSelectorFontFamilyApplierFunction 8)
(defconstant $kATSFontFilterSelectorFontApplierFunction 9)

;type name? (def-mactype :ATSFontFilterSelector (find-mactype ':ATSFontFilterSelector))
(defrecord ATSFontFilter
   (version :UInt32)
   (filterSelector :ATSFontFilterSelector)
#|
; Warning: type-size: unknown type ATSFONTFILTERSELECTOR
|#
   (:variant
   (
   (generationFilter :UInt32)
   )
   (
   (fontFamilyFilter :UInt32)
   )
   (
   (fontFamilyApplierFunctionFilter :pointer)
   )
   (
   (fontApplierFunctionFilter :pointer)
   )
   )
)

;type name? (%define-record :ATSFontFilter (find-record-descriptor ':ATSFontFilter))
;  Notification related 

(def-mactype :ATSFontNotificationRef (find-mactype '(:pointer :ATSFontNotificationRef_)))

(def-mactype :ATSFontNotificationInfoRef (find-mactype '(:pointer :ATSFontNotificationInfoRef_)))
; 
;  *  ATSFontNotifyOption
;  *  
;  *  Discussion:
;  *    Options used with ATSFontNotificationSubscribe.  Any of the
;  *    options that follow may be used together in order to alter the
;  *    default behavior of ATS notifications.
;  
(def-mactype :ATSFontNotifyOption (find-mactype ':sint32))
; 
;    * Default behavior of ATSFontNotificationSubscribe.
;    

(defconstant $kATSFontNotifyOptionDefault 0)
; 
;    * Normally applications will only receive ATS notifications while in
;    * the foreground.   If suspended, the notification will be delivered
;    * when then application comes to the foreground.  This is the
;    * default.  You should set this option if you are a server or tool
;    * that performs font management functions and require immediate
;    * notification when something changes.
;    

(defconstant $kATSFontNotifyOptionReceiveWhileSuspended 1)

;type name? (def-mactype :ATSFontNotifyOption (find-mactype ':ATSFontNotifyOption))
; 
;  *  ATSFontNotifyAction
;  *  
;  *  Discussion:
;  *    Used with ATSFontNotify.   The following is a list of actions you
;  *    might wish the ATS server to perform and notify clients if
;  *    appropriate.
;  
(def-mactype :ATSFontNotifyAction (find-mactype ':sint32))
; 
;    * Used after a batch (de)activation of fonts occurs.   Typically the
;    * caller has exercised multiple global (De)Activation calls with the
;    * kATSOptionFlagsDoNotNotify set. Once all calls are completed, one
;    * may use ATSFontNotify with this action to ask ATS to notify all
;    * clients.
;    

(defconstant $kATSFontNotifyActionFontsChanged 1)
; 
;    * The ATS system with the help of the Finder keeps track of changes
;    * to any of the font directories in the system domains ( System,
;    * Local, Network, User, & Classic). However, one may wish to
;    * add/remove fonts to these locations programmatically. This action
;    * is used to let ATS server to rescan these directories and post
;    * notifications if necessary.
;    

(defconstant $kATSFontNotifyActionDirectoriesChanged 2)

;type name? (def-mactype :ATSFontNotifyAction (find-mactype ':ATSFontNotifyAction))
; 
;  *  ATSNotificationCallback
;  *  
;  *  Discussion:
;  *    Callback delivered for ATS notifications.
;  *  
;  *  Parameters:
;  *    
;  *    info:
;  *      Parameter is placed here for future improvements.  Initially
;  *      the contents of this parameter will be NULL.
;  *    
;  *    refCon:
;  *      User data/state to be supplied to callback function
;  

(def-mactype :ATSNotificationCallback (find-mactype ':pointer)); (ATSFontNotificationInfoRef info , void * refCon)
;  ----------------------------------------------------------------------------------------- 
;  Font container                                                                            
;  ----------------------------------------------------------------------------------------- 
; 
;  *  ATSGetGeneration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSGetGeneration" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  ATSFontActivateFromFileSpecification()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontActivateFromFileSpecification" 
   ((iFile (:pointer :FSSpec))
    (iContext :UInt32)
    (iFormat :UInt32)
    (iReserved :pointer)
    (iOptions :UInt32)
    (oContainer (:pointer :ATSFONTCONTAINERREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontActivateFromMemory()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontActivateFromMemory" 
   ((iData (:pointer :void))
    (iLength :UInt32)
    (iContext :UInt32)
    (iFormat :UInt32)
    (iReserved :pointer)
    (iOptions :UInt32)
    (oContainer (:pointer :ATSFONTCONTAINERREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontDeactivate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontDeactivate" 
   ((iContainer :UInt32)
    (iRefCon :pointer)
    (iOptions :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  ----------------------------------------------------------------------------------------- 
;  Font family                                                                               
;  ----------------------------------------------------------------------------------------- 
; 
;  *  ATSFontFamilyApplyFunction()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFamilyApplyFunction" 
   ((iFunction :pointer)
    (iRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontFamilyIteratorCreate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFamilyIteratorCreate" 
   ((iContext :UInt32)
    (iFilter (:pointer :ATSFontFilter))         ;  can be NULL 
    (iRefCon :pointer)
    (iOptions :UInt32)
    (ioIterator (:pointer :ATSFONTFAMILYITERATOR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontFamilyIteratorRelease()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFamilyIteratorRelease" 
   ((ioIterator (:pointer :ATSFONTFAMILYITERATOR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontFamilyIteratorReset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFamilyIteratorReset" 
   ((iContext :UInt32)
    (iFilter (:pointer :ATSFontFilter))         ;  can be NULL 
    (iRefCon :pointer)
    (iOptions :UInt32)
    (ioIterator (:pointer :ATSFONTFAMILYITERATOR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontFamilyIteratorNext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFamilyIteratorNext" 
   ((iIterator (:pointer :ATSFontFamilyIterator_))
    (oFamily (:pointer :ATSFONTFAMILYREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontFamilyFindFromName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFamilyFindFromName" 
   ((iName (:pointer :__CFString))
    (iOptions :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  ATSFontFamilyGetGeneration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFamilyGetGeneration" 
   ((iFamily :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  ATSFontFamilyGetName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFamilyGetName" 
   ((iFamily :UInt32)
    (iOptions :UInt32)
    (oName (:pointer :CFSTRINGREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontFamilyGetEncoding()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFamilyGetEncoding" 
   ((iFamily :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  ----------------------------------------------------------------------------------------- 
;  Font                                                                                      
;  ----------------------------------------------------------------------------------------- 
; 
;  *  ATSFontApplyFunction()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontApplyFunction" 
   ((iFunction :pointer)
    (iRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontIteratorCreate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontIteratorCreate" 
   ((iContext :UInt32)
    (iFilter (:pointer :ATSFontFilter))         ;  can be NULL 
    (iRefCon :pointer)
    (iOptions :UInt32)
    (ioIterator (:pointer :ATSFONTITERATOR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontIteratorRelease()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontIteratorRelease" 
   ((ioIterator (:pointer :ATSFONTITERATOR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontIteratorReset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontIteratorReset" 
   ((iContext :UInt32)
    (iFilter (:pointer :ATSFontFilter))         ;  can be NULL 
    (iRefCon :pointer)
    (iOptions :UInt32)
    (ioIterator (:pointer :ATSFONTITERATOR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontIteratorNext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontIteratorNext" 
   ((iIterator (:pointer :ATSFontIterator_))
    (oFont (:pointer :ATSFONTREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontFindFromName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFindFromName" 
   ((iName (:pointer :__CFString))
    (iOptions :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  ATSFontFindFromPostScriptName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFindFromPostScriptName" 
   ((iName (:pointer :__CFString))
    (iOptions :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  ATSFontFindFromContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFindFromContainer" 
   ((iContainer :UInt32)
    (iOptions :UInt32)
    (iCount :UInt32)
    (ioArray (:pointer :ATSFONTREF))
    (oCount (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontGetGeneration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontGetGeneration" 
   ((iFont :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  ATSFontGetName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontGetName" 
   ((iFont :UInt32)
    (iOptions :UInt32)
    (oName (:pointer :CFSTRINGREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontGetPostScriptName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontGetPostScriptName" 
   ((iFont :UInt32)
    (iOptions :UInt32)
    (oName (:pointer :CFSTRINGREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontGetTableDirectory()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontGetTableDirectory" 
   ((iFont :UInt32)
    (iBufferSize :UInt32)
    (ioBuffer :pointer)
    (oSize (:pointer :ByteCount))               ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontGetTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontGetTable" 
   ((iFont :UInt32)
    (iTag :FourCharCode)
    (iOffset :UInt32)
    (iBufferSize :UInt32)
    (ioBuffer :pointer)
    (oSize (:pointer :ByteCount))               ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontGetHorizontalMetrics()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontGetHorizontalMetrics" 
   ((iFont :UInt32)
    (iOptions :UInt32)
    (oMetrics (:pointer :ATSFontMetrics))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontGetVerticalMetrics()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontGetVerticalMetrics" 
   ((iFont :UInt32)
    (iOptions :UInt32)
    (oMetrics (:pointer :ATSFontMetrics))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  ----------------------------------------------------------------------------------------- 
;  Compatibility                                                                             
;  ----------------------------------------------------------------------------------------- 
; 
;  *  ATSFontFamilyFindFromQuickDrawName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFamilyFindFromQuickDrawName" 
   ((iName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  ATSFontFamilyGetQuickDrawName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontFamilyGetQuickDrawName" 
   ((iFamily :UInt32)
    (oName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontGetFileSpecification()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontGetFileSpecification" 
   ((iFont :UInt32)
    (oFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontGetFontFamilyResource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontGetFontFamilyResource" 
   ((iFont :UInt32)
    (iBufferSize :UInt32)
    (ioBuffer :pointer)
    (oSize (:pointer :ByteCount))               ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  ----------------------------------------------------------------------------------------- 
;  Notification                                                                              
;  ----------------------------------------------------------------------------------------- 
; 
;  *  ATSFontNotify()
;  *  
;  *  Summary:
;  *    Used to alert ATS that an action which may require notification
;  *    to clients has occurred.
;  *  
;  *  Parameters:
;  *    
;  *    action:
;  *      Action that should be taken by the ATS Server
;  *    
;  *    info:
;  *      Any required or optional information that may be required by
;  *      the action taken.
;  *  
;  *  Result:
;  *    noErr Action successfully reported paramErr Invalid action passed
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontNotify" 
   ((action :ATSFontNotifyAction)
    (info :pointer)                             ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontNotificationSubscribe()
;  *  
;  *  Summary:
;  *    Ask the ATS System to notify caller when certain events have
;  *    occurred.  Note that your application must have a CFRunLoop in
;  *    order to receive notifications. Any Appkit or Carbon event loop
;  *    based application will have one by default.
;  *  
;  *  Parameters:
;  *    
;  *    callback:
;  *      Function that will be called by the ATS system whenever an
;  *      event of interest takes place.
;  *    
;  *    options:
;  *      Set the wanted ATSFontNotificationOptions to modify the default
;  *      behavior of ATS Notifications.
;  *    
;  *    iRefcon:
;  *      User data/state which will be passed to the callback funtion
;  *    
;  *    oNotificationRef:
;  *      You may use this reference to un-subscribe to this notification.
;  *  
;  *  Result:
;  *    noErr Subscribed successfully paramErr NULL callback was passed.
;  *    memFullErr Could not allocate enough memory for internal data
;  *    structures.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontNotificationSubscribe" 
   ((callback :pointer)
    (options :ATSFontNotifyOption)
    (iRefcon :pointer)                          ;  can be NULL 
    (oNotificationRef (:pointer :ATSFONTNOTIFICATIONREF));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  ATSFontNotificationUnsubscribe()
;  *  
;  *  Summary:
;  *    Release subscription and stop receiving notifications for a given
;  *    reference.
;  *  
;  *  Parameters:
;  *    
;  *    notificationRef:
;  *      Notification reference for which you want to stop receiving
;  *      notifications. Note, if more than one notification has been
;  *      requested of ATS, you will still receive notifications on those
;  *      requests.
;  *  
;  *  Result:
;  *    noErr Unsubscribed successfully paramErr NULL/invalid
;  *    notificationRef passed
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSFontNotificationUnsubscribe" 
   ((notificationRef (:pointer :ATSFontNotificationRef_))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
;  ----------------------------------------------------------------------------------------- 
;  Font query message hooks                                                                  
;  ----------------------------------------------------------------------------------------- 
; 
;  *  ATSFontQuerySourceContext
;  *  
;  *  Summary:
;  *    A parameter block for client information to be retained by ATS
;  *    and passed back to an ATSFontQueryCallback function.
;  
(defrecord ATSFontQuerySourceContext
                                                ; 
;    * A 32-bit unsigned integer that indicates the version of this
;    * structure. This should be set to 0.
;    
   (version :UInt32)
                                                ; 
;    * A pointer-sized client datum that should be passed back to an
;    * ATSFontQueryCallback function.
;    
   (refCon :pointer)
                                                ; 
;    * The callback used to add a retain to the refCon.
;    
   (retain :pointer)
                                                ; 
;    * The callback used to remove a retain to the refCon.
;    
   (release :pointer)
)

;type name? (%define-record :ATSFontQuerySourceContext (find-record-descriptor ':ATSFontQuerySourceContext))
; 
;  *  ATSFontQueryMessageID
;  *  
;  *  Discussion:
;  *    Constants for ATS font query message types.
;  
(def-mactype :ATSFontQueryMessageID (find-mactype ':sint32))
; 
;    * The message ID for a font request query. The data for a message
;    * with this ID is a flattened CFDictionaryRef with keys and values
;    * as decribed below. A query dictionary may have any or all of these
;    * entries.
;    

(defconstant $kATSQueryActivateFontMessage :|atsa|)

;type name? (def-mactype :ATSFontQueryMessageID (find-mactype ':ATSFontQueryMessageID))
; 
;  *  ATSFontQueryCallback
;  *  
;  *  Summary:
;  *    Callback for receiving font-related queries from ATS.
;  *  
;  *  Parameters:
;  *    
;  *    msgid:
;  *      An ATSFontQueryMessageID that identifies the message type.
;  *    
;  *    data:
;  *      A CFPropertyListRef that represents the query. The content is
;  *      message type-specific.
;  *    
;  *    refCon:
;  *      A pointer-sized client datum that was optionally provided to
;  *      ATSCreateFontQueryRunLoopSource.
;  *  
;  *  Result:
;  *    A CFPropertyListRef that represents the message type-specific
;  *    response to the query. May be NULL.
;  

(def-mactype :ATSFontQueryCallback (find-mactype ':pointer)); (ATSFontQueryMessageID msgid , CFPropertyListRef data , void * refCon)
; 
;  *  ATSCreateFontQueryRunLoopSource()
;  *  
;  *  Summary:
;  *    Creates a CFRunLoopSourceRef that will be used to convey font
;  *    queries from ATS.
;  *  
;  *  Parameters:
;  *    
;  *    queryOrder:
;  *      A CFIndex that specifies the priority of this query receiver
;  *      relative to others. When ATS makes a font query, it will send
;  *      the query to each receiver in priority order, from highest to
;  *      lowest. "Normal" priority is 0.
;  *    
;  *    sourceOrder:
;  *      The order of the created run loop source.
;  *    
;  *    callout:
;  *      A function pointer of type ATSFontQueryCallback that will be
;  *      called to process a font query.
;  *    
;  *    context:
;  *      An ATSFontQuerySourceContext parameter block that provides a
;  *      pointer-sized client datum which will be retained by ATS and
;  *      passed to the callout function. May be NULL.
;  *  
;  *  Result:
;  *    A CFRunLoopSourceRef. To stop receiving queries, invalidate this
;  *    run loop source.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ATSCreateFontQueryRunLoopSource" 
   ((queryOrder :SInt32)
    (sourceOrder :SInt32)
    (callout :pointer)
    (context (:pointer :ATSFontQuerySourceContext));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__CFRunLoopSource)
() )
;  ----------------------------------------------------------------------------------------- 
;  Font request query message content                                                        
;  ----------------------------------------------------------------------------------------- 
;  Keys in a font request query dictionary. 
;  These keys appear in the dictionary for a kATSQueryActivateFontMessage query. 
; 
;  *  kATSQueryClientPID
;  *  
;  *  Discussion:
;  *    The process ID of the application making the query. The
;  *    corresponding value is a CFNumberRef that contains a pid_t.
;  
; #define kATSQueryClientPID              CFSTR("ATS client pid")
; 
;  *  kATSQueryQDFamilyName
;  *  
;  *  Discussion:
;  *    The Quickdraw-style family name of the font being requested, e.g.
;  *    the name passed to GetFNum. The corresponding value is a
;  *    CFStringRef.
;  
; #define kATSQueryQDFamilyName           CFSTR("font family name")
; 
;  *  kATSQueryFontName
;  *  
;  *  Discussion:
;  *    The name of the font being requested. The corresponding value is
;  *    a CFStringRef suitable as an argument to ATSFontFindFromName().
;  *    This should match a candidate font's unique or full name.
;  
; #define kATSQueryFontName               CFSTR("font name")
; 
;  *  kATSQueryFontPostScriptName
;  *  
;  *  Discussion:
;  *    The PostScript name of the font being requested. The
;  *    corresponding value is a CFStringRef suitable as an argument to
;  *    ATSFontFindFromPostScriptName(). This should match either the
;  *    PostScript name derived from the font's FOND resource or its sfnt
;  *    name table, with preference given to the FOND PostScript name.
;  
; #define kATSQueryFontPostScriptName     CFSTR("font PS name")
; 
;  *  kATSQueryFontNameTableEntries
;  *  
;  *  Discussion:
;  *    A descriptor for sfnt name table entries that the requested font
;  *    must have. The corresponding value is a CFArrayRef of
;  *    CFDictionaryRefs that describe name table entries. A font must
;  *    have all of the specified entries to be considered a match.
;  
; #define kATSQueryFontNameTableEntries   CFSTR("font name table entries")
;  Keys in a font raw name descriptor dictionary. 
; 
;  *  kATSFontNameTableCode
;  *  
;  *  Discussion:
;  *    The font name's name code. The corresponding value is a
;  *    CFNumberRef. If missing, assume kFontNoNameCode.
;  
; #define kATSFontNameTableCode           CFSTR("font name code")
; 
;  *  kATSFontNameTablePlatform
;  *  
;  *  Discussion:
;  *    The font name's platform code. The corresponding value is a
;  *    CFNumberRef. If missing, assume kFontNoPlatformCode.
;  
; #define kATSFontNameTablePlatform       CFSTR("font platform code")
; 
;  *  kATSFontNameTableScript
;  *  
;  *  Discussion:
;  *    The font name's script code. The corresponding value is a
;  *    CFNumberRef. If missing, assume kFontNoScriptCode.
;  
; #define kATSFontNameTableScript         CFSTR("font script code")
; 
;  *  kATSFontNameTableLanguage
;  *  
;  *  Discussion:
;  *    The font name's language code. The corresponding value is a
;  *    CFNumberRef. If missing, assume kFontNoLanguageCode.
;  
; #define kATSFontNameTableLanguage       CFSTR("font language code")
; 
;  *  kATSFontNameTableBytes
;  *  
;  *  Discussion:
;  *    The raw bytes of the font name. The corresponding value is a
;  *    CFDataRef that contains the raw name bytes.
;  
; #define kATSFontNameTableBytes          CFSTR("font name table bytes")

; #if PRAGMA_ENUM_ALWAYSINT
#| ; #pragma enumsalwaysint reset
 |#

; #endif

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __ATSFONT__ */


(provide-interface "ATSFont")