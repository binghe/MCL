(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:FindByContent.h"
; at Sunday July 2,2006 7:24:43 pm.
; 
;      File:       FindByContent/FindByContent.h
;  
;      Contains:   Public search interface for the Find by Content shared library
;  
;      Version:    FindByContent-62~14
;  
;      Copyright:  © 1997-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __FINDBYCONTENT__
; #define __FINDBYCONTENT__
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

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #pragma options align=mac68k
; 
;    ***************************************************************************
;    Language constants used with FBCIndexItemsInLanguages: these numbers are bits
;    in a 64-bit array that consists of two UInt32 words.  In the current implementation
;    the low word is always 0, so values for the high word are given.  If both UInt32
;    words are 0, the default value of kDefaultLanguagesHighWord is used.
;    ***************************************************************************
; 
;  These are the new names for the language constants
;  languages that use the Roman character mapping

(defconstant $kFBCenglishHighWord #x80000000)
(defconstant $kFBCdutchHighWord #x40000000)     ;  also Afrikaans

(defconstant $kFBCgermanHighWord #x20000000)
(defconstant $kFBCswedishHighWord #x10000000)   ;  also Norwegian

(defconstant $kFBCdanishHighWord #x8000000)
(defconstant $kFBCspanishHighWord #x4000000)    ;  also Catalan

(defconstant $kFBCportugueseHighWord #x2000000)
(defconstant $kFBCitalianHighWord #x1000000)
(defconstant $kFBCfrenchHighWord #x800000)
(defconstant $kFBCromanHighWord #x400000)       ;  other languages using Roman alphabet
;  Languages that use other mappings

(defconstant $kFBCicelandicHighWord #x200000)   ;  also Faroese

(defconstant $kFBChebrewHighWord #x100000)      ;  also Yiddish

(defconstant $kFBCarabicHighWord #x80000)       ;  also Farsi, Urdu

(defconstant $kFBCcenteuroHighWord #x40000)     ;  Central European languages not using Cyrillic

(defconstant $kFBCcroatianHighWord #x20000)
(defconstant $kFBCturkishHighWord #x10000)
(defconstant $kFBCromanianHighWord #x8000)
(defconstant $kFBCgreekHighWord #x4000)
(defconstant $kFBCcyrillicHighWord #x2000)      ;  all languages using Cyrillic

(defconstant $kFBCdevanagariHighWord #x1000)
(defconstant $kFBCgujuratiHighWord #x800)
(defconstant $kFBCgurmukhiHighWord #x400)
(defconstant $kFBCjapaneseHighWord #x200)
(defconstant $kFBCkoreanHighWord #x100)         ;  sum of first 9

(defconstant $kFBCdefaultLanguagesHighWord #xFF800000)
; A new error, needs to be moved to MacErrors.h

(defconstant $kFBCnotAllFoldersSearchable -30533)
; 
;    ***************************************************************************
;    Phase values
;    These values are passed to the client's callback function to indicate what
;    the FBC code is doing.  They are meaningless in OS X.
;    ***************************************************************************
; 
;  indexing phases

(defconstant $kFBCphIndexing 0)
(defconstant $kFBCphFlushing 1)
(defconstant $kFBCphMerging 2)
(defconstant $kFBCphMakingIndexAccessor 3)
(defconstant $kFBCphCompacting 4)
(defconstant $kFBCphIndexWaiting 5)             ;  access phases

(defconstant $kFBCphSearching 6)
(defconstant $kFBCphMakingAccessAccessor 7)
(defconstant $kFBCphAccessWaiting 8)            ;  summarization

(defconstant $kFBCphSummarizing 9)              ;  indexing or access

(defconstant $kFBCphIdle 10)
(defconstant $kFBCphCanceling 11)

(defconstant $kFBCsummarizationFailed -30533)
; 
;    ***************************************************************************
;    Pointer types
;    These point to memory allocated by the FBC shared library, and must be deallocated
;    by calls that are defined below.
;    ***************************************************************************
; 
;  A collection of state information for searching

(def-mactype :FBCSearchSession (find-mactype '(:pointer :OpaqueFBCSearchSession)))
;  An object containing summary information, from which summary text can be obtained

(def-mactype :FBCSummaryRef (find-mactype '(:pointer :OpaqueFBCSummaryRef)))
;  An ordinary C string (used for hit/doc terms)

(def-mactype :FBCWordItem (find-mactype '(:pointer :character)))
;  An array of WordItems

(def-mactype :FBCWordList (find-mactype '(:handle :character)))
; 
;    ***************************************************************************
;    Callback function type for progress reporting and cancelation during
;    searching and indexing.  The client's callback function should call
;    WaitNextEvent; a "sleep" value of 1 is suggested.  If the callback function
;    wants to cancel the current operation (indexing, search, or doc-terms
;    retrieval) it should return true.
;    ***************************************************************************
; 

(def-mactype :FBCCallbackProcPtr (find-mactype ':pointer)); (UInt16 phase , float percentDone , void * data)

(def-mactype :FBCCallbackUPP (find-mactype '(:pointer :OpaqueFBCCallbackProcPtr)))
; 
;  *  NewFBCCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewFBCCallbackUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueFBCCallbackProcPtr)
() )
; 
;  *  DisposeFBCCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeFBCCallbackUPP" 
   ((userUPP (:pointer :OpaqueFBCCallbackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeFBCCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeFBCCallbackUPP" 
   ((phase :UInt16)
    (percentDone :single-float)
    (data :pointer)
    (userUPP (:pointer :OpaqueFBCCallbackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    ***************************************************************************
;    Set the callback function for progress reporting and cancelation during
;    searching and indexing.
;    ***************************************************************************
; 
; 
;  *  FBCSetSessionCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FBCSetSessionCallback" 
   ((searchSession (:pointer :OpaqueFBCSearchSession))
    (fn (:pointer :OpaqueFBCCallbackProcPtr))
    (data :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
;       OS X DEPRECATED, use FBCSetSessionCallback
; 
;  *  FBCSetCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCSetCallback" 
   ((fn (:pointer :OpaqueFBCCallbackProcPtr))
    (data :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    ***************************************************************************
;    Callback function type for hit testing during searching
;    ***************************************************************************
; 

(def-mactype :FBCHitTestProcPtr (find-mactype ':pointer)); (const FSRef * theFile , void * data)

(def-mactype :FBCHitTestUPP (find-mactype '(:pointer :OpaqueFBCHitTestProcPtr)))
; 
;  *  NewFBCHitTestUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewFBCHitTestUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueFBCHitTestProcPtr)
() )
; 
;  *  DisposeFBCHitTestUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeFBCHitTestUPP" 
   ((userUPP (:pointer :OpaqueFBCHitTestProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  InvokeFBCHitTestUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeFBCHitTestUPP" 
   ((theFile (:pointer :FSRef))
    (data :pointer)
    (userUPP (:pointer :OpaqueFBCHitTestProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Boolean
() )
; 
;    ***************************************************************************
;    Set the hit-testing function for searches.
;    ***************************************************************************
; 
; 
;  *  FBCSetSessionHitTest()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCSetSessionHitTest" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (fn (:pointer :OpaqueFBCHitTestProcPtr))
    (data :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;    ***************************************************************************
;    Set the amount of heap space to reserve for the client's use when FBC
;    allocates memory.
;    ***************************************************************************
; 
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCSetHeapReservation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCSetHeapReservation" 
   ((bytes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    ***************************************************************************
;    Find out whether a volume is indexed.
;    ***************************************************************************
; 
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCVolumeIsIndexed()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCVolumeIsIndexed" 
   ((theVRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    ***************************************************************************
;    Find out whether a volume is remote.
;    ***************************************************************************
; 
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCVolumeIsRemote()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCVolumeIsRemote" 
   ((theVRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    ***************************************************************************
;    Find out the date & time of an index's last completed  update.
;    ***************************************************************************
; 
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCVolumeIndexTimeStamp()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCVolumeIndexTimeStamp" 
   ((theVRefNum :SInt16)
    (timeStamp (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    ***************************************************************************
;    Find out the physical size of an index.
;    ***************************************************************************
; 
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCVolumeIndexPhysicalSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCVolumeIndexPhysicalSize" 
   ((theVRefNum :SInt16)
    (size (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    ***************************************************************************
;    Create & configure a search session
;    ***************************************************************************
; 
; 
;  *  FBCCreateSearchSession()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCCreateSearchSession" 
   ((searchSession (:pointer :FBCSEARCHSESSION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FBCCloneSearchSession()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCCloneSearchSession" 
   ((original (:pointer :OpaqueFBCSearchSession))
    (clone (:pointer :FBCSEARCHSESSION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCAddAllVolumesToSession()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCAddAllVolumesToSession" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (includeRemote :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCSetSessionVolumes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCSetSessionVolumes" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (vRefNums (:pointer :SInt16))
    (numVolumes :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCAddVolumeToSession()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCAddVolumeToSession" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (vRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCRemoveVolumeFromSession()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCRemoveVolumeFromSession" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (vRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCGetSessionVolumeCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCGetSessionVolumeCount" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (count (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCGetSessionVolumes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCGetSessionVolumes" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (vRefNums (:pointer :SInt16))
    (numVolumes (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    ***************************************************************************
;    Execute a search
;    ***************************************************************************
; 
; 
;  *  FBCDoQuerySearch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCDoQuerySearch" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (queryText (:pointer :char))
    (targetDirs (:pointer :FSSpec))
    (numTargets :UInt32)
    (maxHits :UInt32)
    (maxHitWords :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FBCDoCFStringSearch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FBCDoCFStringSearch" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (queryString (:pointer :__CFString))
    (targetDirs (:pointer :FSSpec))
    (numTargets :UInt32)
    (maxHits :UInt32)
    (maxHitWords :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FBCDoExampleSearch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCDoExampleSearch" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (exampleHitNums (:pointer :UInt32))
    (numExamples :UInt32)
    (targetDirs (:pointer :FSSpec))
    (numTargets :UInt32)
    (maxHits :UInt32)
    (maxHitWords :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  OS X DEPRECATED, use FBCBlindExampleSearchWithCallback to be able to cancel
; 
;  *  FBCBlindExampleSearch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCBlindExampleSearch" 
   ((examples (:pointer :FSSpec))
    (numExamples :UInt32)
    (targetDirs (:pointer :FSSpec))
    (numTargets :UInt32)
    (maxHits :UInt32)
    (maxHitWords :UInt32)
    (allIndexes :Boolean)
    (includeRemote :Boolean)
    (theSession (:pointer :FBCSEARCHSESSION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FBCBlindExampleSearchWithCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FBCBlindExampleSearchWithCallback" 
   ((examples (:pointer :FSSpec))
    (numExamples :UInt32)
    (targetDirs (:pointer :FSSpec))
    (numTargets :UInt32)
    (maxHits :UInt32)
    (maxHitWords :UInt32)
    (allIndexes :Boolean)
    (includeRemote :Boolean)
    (theSession (:pointer :FBCSEARCHSESSION))
    (callback (:pointer :OpaqueFBCCallbackProcPtr))
    (callbackData :pointer)
    (userHitTest (:pointer :OpaqueFBCHitTestProcPtr))
    (userHitTestData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;    ***************************************************************************
;    Get information about hits [wrapper for THitItem C++ API]
;    ***************************************************************************
; 
; 
;  *  FBCGetHitCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCGetHitCount" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (count (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FBCGetHitDocument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCGetHitDocument" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (hitNumber :UInt32)
    (theDocument (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FBCGetHitDocumentRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FBCGetHitDocumentRef" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (hitNumber :UInt32)
    (theDocument (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FBCGetHitScore()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCGetHitScore" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (hitNumber :UInt32)
    (score (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    ***************************************************************************
;    Summarize text
;    ***************************************************************************
; 
; 
;  *  FBCSummarize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCSummarize" 
   ((inBuf :pointer)
    (inLength :UInt32)
    (outBuf :pointer)
    (outLength (:pointer :UInt32))
    (numSentences (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FBCSummarizeCFString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FBCSummarizeCFString" 
   ((inString (:pointer :__CFString))
    (outString (:pointer :CFStringRef))
    (numSentences (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FBCGetSummaryOfCFString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FBCGetSummaryOfCFString" 
   ((inString (:pointer :__CFString))
    (summary (:pointer :FBCSUMMARYREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FBCGetSummarySentenceCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FBCGetSummarySentenceCount" 
   ((summary (:pointer :OpaqueFBCSummaryRef))
    (numSentences (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FBCGetSummarySentences()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FBCGetSummarySentences" 
   ((summary (:pointer :OpaqueFBCSummaryRef))
    (outString (:pointer :CFStringRef))
    (numSentences (:pointer :UInt32))
    (paragraphs :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FBCDisposeSummary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FBCDisposeSummary" 
   ((summary (:pointer :OpaqueFBCSummaryRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;    ***************************************************************************
;    Deallocate hit lists and search sessions
;    ***************************************************************************
; 
; 
;  *  FBCReleaseSessionHits()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCReleaseSessionHits" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FBCDestroySearchSession()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCDestroySearchSession" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    ***************************************************************************
;    Index one or more files and/or folders
;    ***************************************************************************
; 
;       OS X DEPRECATED (will be removed from OS X exports in a future release)
; 
;  *  FBCIndexItems()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   in FindByContent 9.0 and later
;  

(deftrap-inline "_FBCIndexItems" 
   ((theItems (:pointer :FSSpec))
    (itemCount :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FBCIndexItemsInLanguages()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FBCIndexItemsInLanguages" 
   ((theItems (:pointer :FSSpec))
    (itemCount :UInt32)
    (languageHighBits :UInt32)
    (languageLowBits :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    ***************************************************************************
;    (OS X only) Given a folder, find the folder that contains the index file
;    of the given index
;    ***************************************************************************
; 
; 
;  *  FBCFindIndexFileFolderForFolder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FBCFindIndexFileFolderForFolder" 
   ((inFolder (:pointer :FSRef))
    (outFolder (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    ***************************************************************************
;    (OS X only) Given a folder, delete the index file that indexes it
;    ***************************************************************************
; 
; 
;  *  FBCDeleteIndexFileForFolder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FBCDeleteIndexFileForFolder" 
   ((folder (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    ***************************************************************************
;    The following are deprecated and obsolete for both OS X and OS 9
;    ***************************************************************************
; 
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCGetMatchedWords()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCGetMatchedWords" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (hitNumber :UInt32)
    (wordCount (:pointer :UInt32))
    (list (:pointer :FBCWORDLIST))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCGetTopicWords()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCGetTopicWords" 
   ((theSession (:pointer :OpaqueFBCSearchSession))
    (hitNumber :UInt32)
    (wordCount (:pointer :UInt32))
    (list (:pointer :FBCWORDLIST))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;       OS X DEPRECATED, NO-OP (will be removed from OS X exports in a future release)
; 
;  *  FBCDestroyWordList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FindByContent 8.5 and later
;  

(deftrap-inline "_FBCDestroyWordList" 
   ((theList (:Handle :character))
    (wordCount :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  These names are deprecated, use the new ones above
;  languages that use the Roman character mapping

(defconstant $englishHighWord #x80000000)
(defconstant $dutchHighWord #x40000000)         ;  also Afrikaans

(defconstant $germanHighWord #x20000000)
(defconstant $swedishHighWord #x10000000)       ;  also Norwegian

(defconstant $danishHighWord #x8000000)
(defconstant $spanishHighWord #x4000000)        ;  also Catalan

(defconstant $portugueseHighWord #x2000000)
(defconstant $italianHighWord #x1000000)
(defconstant $frenchHighWord #x800000)
(defconstant $romanHighWord #x400000)           ;  other languages using Roman alphabet
;  Languages that use other mappings

(defconstant $icelandicHighWord #x200000)       ;  also Faroese

(defconstant $hebrewHighWord #x100000)          ;  also Yiddish

(defconstant $arabicHighWord #x80000)           ;  also Farsi, Urdu

(defconstant $centeuroHighWord #x40000)         ;  Central European languages not using Cyrillic

(defconstant $croatianHighWord #x20000)
(defconstant $turkishHighWord #x10000)
(defconstant $romanianHighWord #x8000)
(defconstant $greekHighWord #x4000)
(defconstant $cyrillicHighWord #x2000)          ;  all languages using Cyrillic

(defconstant $devanagariHighWord #x1000)
(defconstant $gujuratiHighWord #x800)
(defconstant $gurmukhiHighWord #x400)
(defconstant $japaneseHighWord #x200)
(defconstant $koreanHighWord #x100)
(defconstant $kDefaultLanguagesHighWord #xFF800000);  sum of first 9

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __FINDBYCONTENT__ */


(provide-interface "FindByContent")