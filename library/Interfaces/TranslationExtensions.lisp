(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:TranslationExtensions.h"
; at Sunday July 2,2006 7:25:05 pm.
; 
;      File:       HIToolbox/TranslationExtensions.h
;  
;      Contains:   Macintosh Easy Open Translation Extension Interfaces.
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1993-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __TRANSLATIONEXTENSIONS__
; #define __TRANSLATIONEXTENSIONS__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
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
;    Translation Extensions are no longer supported. Carbon clients interested in extending translations
;    should use filter services as described in TranslationServices.h.  The definitions below will NOT work
;    for Carbon and are only defined for those files that need to build pre-Carbon applications.
; 

(defconstant $kSupportsFileTranslation 1)
(defconstant $kSupportsScrapTranslation 2)
(defconstant $kTranslatorCanGenerateFilename 4)
; ****************************************************************************************
;  better names for 4-char codes

(def-mactype :FileType (find-mactype ':OSType))

(def-mactype :ScrapType (find-mactype ':FourCharCode))
; ****************************************************************************************

(def-mactype :TranslationAttributes (find-mactype ':UInt32))

(defconstant $taDstDocNeedsResourceFork 1)
(defconstant $taDstIsAppTranslation 2)
; ****************************************************************************************
(defrecord FileTypeSpec
   (format :OSType)
   (hint :signed-long)
   (flags :UInt32)                              ;  taDstDocNeedsResourceFork, taDstIsAppTranslation
   (catInfoType :OSType)
   (catInfoCreator :OSType)
)

;type name? (%define-record :FileTypeSpec (find-record-descriptor ':FileTypeSpec))
(defrecord FileTranslationList
   (modDate :UInt32)
   (groupCount :UInt32)
                                                ;  conceptual declarations:
                                                ;     unsigned long group1SrcCount;
                                                ;     unsigned long group1SrcEntrySize = sizeof(FileTypeSpec);
                                                ;   FileTypeSpec  group1SrcTypes[group1SrcCount]
                                                ;   unsigned long group1DstCount;
                                                ;   unsigned long group1DstEntrySize = sizeof(FileTypeSpec);
                                                ;   FileTypeSpec  group1DstTypes[group1DstCount]
)

;type name? (%define-record :FileTranslationList (find-record-descriptor ':FileTranslationList))

(def-mactype :FileTranslationListPtr (find-mactype '(:pointer :FileTranslationList)))

(def-mactype :FileTranslationListHandle (find-mactype '(:handle :FileTranslationList)))
; ****************************************************************************************
(defrecord ScrapTypeSpec
   (format :FourCharCode)
   (hint :signed-long)
)

;type name? (%define-record :ScrapTypeSpec (find-record-descriptor ':ScrapTypeSpec))
(defrecord ScrapTranslationList
   (modDate :UInt32)
   (groupCount :UInt32)
                                                ;  conceptual declarations:
                                                ;     unsigned long     group1SrcCount;
                                                ;     unsigned long     group1SrcEntrySize = sizeof(ScrapTypeSpec);
                                                ;   ScrapTypeSpec     group1SrcTypes[group1SrcCount]
                                                ;   unsigned long     group1DstCount;
                                                ;     unsigned long     group1DstEntrySize = sizeof(ScrapTypeSpec);
                                                ;   ScrapTypeSpec     group1DstTypes[group1DstCount]
)

;type name? (%define-record :ScrapTranslationList (find-record-descriptor ':ScrapTranslationList))

(def-mactype :ScrapTranslationListPtr (find-mactype '(:pointer :ScrapTranslationList)))

(def-mactype :ScrapTranslationListHandle (find-mactype '(:handle :ScrapTranslationList)))
; ******************************************************************************************
; 
;     definition of callbacks to update progress dialog
; 
; ******************************************************************************************

(def-mactype :TranslationRefNum (find-mactype ':signed-long))
; ******************************************************************************************
; 
;     This routine sets the advertisement in the top half of the progress dialog.
;     It is called once at the beginning of your DoTranslateFile routine.
; 
;     Enter   :   refNum          Translation reference supplied to DoTranslateFile.
;                 advertisement   A handle to the picture to display.  This must be non-purgable.
;                                 Before returning from DoTranslateFile, you should dispose
;                                 of the memory.  (Normally, it is in the temp translation heap
;                                 so it is cleaned up for you.)
; 
;     Exit    :   returns         noErr, paramErr, or memFullErr
; 
; ******************************************************************************************
; 
;  *  SetTranslationAdvertisement()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    There is no direct replacement at this time.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 thru 1.0.2
;  *    Non-Carbon CFM:   in Translation 1.0 and later
;  

(deftrap-inline "_SetTranslationAdvertisement" 
   ((refNum :signed-long)
    (advertisement (:Handle :Picture))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; ******************************************************************************************
; 
;     This routine updates the progress bar in the progress dialog.
;     It is called repeatedly from within your DoTranslateFile routine.
;     It should be called often, so that the user will get feedback if
;     he tries to cancel.
; 
;     Enter   :   refNum      translation reference supplied to DoTranslateFile.
;                 progress    percent complete (0-100)
; 
;     Exit    :   canceled    TRUE if the user clicked the Cancel button, FALSE otherwise
; 
;     Return  :   noErr, paramErr, or memFullErr
; 
; ******************************************************************************************
; 
;  *  UpdateTranslationProgress()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    There is no direct replacement at this time.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 thru 1.0.2
;  *    Non-Carbon CFM:   in Translation 1.0 and later
;  

(deftrap-inline "_UpdateTranslationProgress" 
   ((refNum :signed-long)
    (percentDone :SInt16)
    (canceled (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; ******************************************************************************************
; 
;     Component Manager component selectors for translation extension routines
; 
; ******************************************************************************************

(defconstant $kTranslateGetFileTranslationList 0)
(defconstant $kTranslateIdentifyFile 1)
(defconstant $kTranslateTranslateFile 2)
(defconstant $kTranslateGetTranslatedFilename 3)
(defconstant $kTranslateGetScrapTranslationList 10)
(defconstant $kTranslateIdentifyScrap 11)
(defconstant $kTranslateTranslateScrap 12)
(defconstant $kTranslateGetScrapTranslationListConsideringData 13)
; ******************************************************************************************
; 
;     routines which implement translation extensions
; 
; ******************************************************************************************

(def-mactype :DoGetFileTranslationListProcPtr (find-mactype ':pointer)); (ComponentInstance self , FileTranslationListHandle translationList)

(def-mactype :DoIdentifyFileProcPtr (find-mactype ':pointer)); (ComponentInstance self , const FSSpec * theDocument , FileType * docType)

(def-mactype :DoTranslateFileProcPtr (find-mactype ':pointer)); (ComponentInstance self , TranslationRefNum refNum , const FSSpec * sourceDocument , FileType srcType , long srcTypeHint , const FSSpec * dstDoc , FileType dstType , long dstTypeHint)

(def-mactype :DoGetTranslatedFilenameProcPtr (find-mactype ':pointer)); (ComponentInstance self , FileType dstType , long dstTypeHint , FSSpec * theDocument)

(def-mactype :DoGetScrapTranslationListProcPtr (find-mactype ':pointer)); (ComponentInstance self , ScrapTranslationListHandle list)

(def-mactype :DoIdentifyScrapProcPtr (find-mactype ':pointer)); (ComponentInstance self , const void * dataPtr , Size dataLength , ScrapType * dataFormat)

(def-mactype :DoTranslateScrapProcPtr (find-mactype ':pointer)); (ComponentInstance self , TranslationRefNum refNum , const void * srcDataPtr , Size srcDataLength , ScrapType srcType , long srcTypeHint , Handle dstData , ScrapType dstType , long dstTypeHint)
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __TRANSLATIONEXTENSIONS__ */


(provide-interface "TranslationExtensions")