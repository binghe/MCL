(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:URLAccess.h"
; at Sunday July 2,2006 7:25:16 pm.
; 
;      File:       SecurityHI/URLAccess.h
;  
;      Contains:   URL Access Interfaces.
;  
;      Version:    SecurityHI-90~157
;  
;      Copyright:  © 1994-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __URLACCESS__
; #define __URLACCESS__
; #ifndef __HITOOLBOX__
#| #|
#include <HIToolboxHIToolbox.h>
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
;  Data structures and types 

(def-mactype :URLReference (find-mactype '(:pointer :OpaqueURLReference)))

(def-mactype :URLOpenFlags (find-mactype ':UInt32))

(defconstant $kURLReplaceExistingFlag 1)
(defconstant $kURLBinHexFileFlag 2)             ;  Binhex before uploading if necessary

(defconstant $kURLExpandFileFlag 4)             ;  Use StuffIt engine to expand file if necessary

(defconstant $kURLDisplayProgressFlag 8)
(defconstant $kURLDisplayAuthFlag 16)           ;  Display auth dialog if guest connection fails

(defconstant $kURLUploadFlag 32)                ;  Do an upload instead of a download

(defconstant $kURLIsDirectoryHintFlag 64)       ;  Hint: the URL is a directory

(defconstant $kURLDoNotTryAnonymousFlag #x80)   ;  Don't try to connect anonymously before getting logon info

(defconstant $kURLDirectoryListingFlag #x100)   ;  Download the directory listing, not the whole directory

(defconstant $kURLExpandAndVerifyFlag #x200)    ;  Expand file and then verify using signature resource

(defconstant $kURLNoAutoRedirectFlag #x400)     ;  Do not automatically redirect to new URL

(defconstant $kURLDebinhexOnlyFlag #x800)       ;  Do not use Stuffit Expander - just internal debinhex engine

(defconstant $kURLDoNotDeleteOnErrorFlag #x1000);  Do not delete the downloaded file if an error or abort occurs.
;  This flag applies to downloading only and should be used if
;  interested in later resuming the download.

(defconstant $kURLResumeDownloadFlag #x2000)    ;  The passed in file is partially downloaded, attempt to resume
;  it.  Currently works for HTTP only.  If no FSSpec passed in,
;  this flag will be ignored. Overriden by kURLReplaceExistingFlag. 
;  reserved for Apple internal use

(defconstant $kURLReservedFlag #x80000000)

(def-mactype :URLState (find-mactype ':UInt32))

(defconstant $kURLNullState 0)
(defconstant $kURLInitiatingState 1)
(defconstant $kURLLookingUpHostState 2)
(defconstant $kURLConnectingState 3)
(defconstant $kURLResourceFoundState 4)
(defconstant $kURLDownloadingState 5)
(defconstant $kURLDataAvailableState 21)
(defconstant $kURLTransactionCompleteState 6)
(defconstant $kURLErrorOccurredState 7)
(defconstant $kURLAbortingState 8)
(defconstant $kURLCompletedState 9)
(defconstant $kURLUploadingState 10)

(def-mactype :URLEvent (find-mactype ':UInt32))

(defconstant $kURLInitiatedEvent 1)
(defconstant $kURLResourceFoundEvent 4)
(defconstant $kURLDownloadingEvent 5)
(defconstant $kURLAbortInitiatedEvent 8)
(defconstant $kURLCompletedEvent 9)
(defconstant $kURLErrorOccurredEvent 7)
(defconstant $kURLDataAvailableEvent 21)
(defconstant $kURLTransactionCompleteEvent 6)
(defconstant $kURLUploadingEvent 10)
(defconstant $kURLSystemEvent 29)
(defconstant $kURLPercentEvent 30)
(defconstant $kURLPeriodicEvent 31)
(defconstant $kURLPropertyChangedEvent 32)

(def-mactype :URLEventMask (find-mactype ':UInt32))

(defconstant $kURLInitiatedEventMask 1)
(defconstant $kURLResourceFoundEventMask 8)
(defconstant $kURLDownloadingMask 16)
(defconstant $kURLUploadingMask #x200)
(defconstant $kURLAbortInitiatedMask #x80)
(defconstant $kURLCompletedEventMask #x100)
(defconstant $kURLErrorOccurredEventMask 64)
(defconstant $kURLDataAvailableEventMask #x100000)
(defconstant $kURLTransactionCompleteEventMask 32)
(defconstant $kURLSystemEventMask #x10000000)
(defconstant $kURLPercentEventMask #x20000000)
(defconstant $kURLPeriodicEventMask #x40000000)
(defconstant $kURLPropertyChangedEventMask #x80000000)
(defconstant $kURLAllBufferEventsMask #x100020)
(defconstant $kURLAllNonBufferEventsMask #xE00003D1)
(defconstant $kURLAllEventsMask #xFFFFFFFF)
(defrecord URLCallbackInfo
   (version :UInt32)
   (urlRef (:pointer :OpaqueURLReference))
   (property (:pointer :char))
   (currentSize :UInt32)
   (systemEvent (:pointer :EventRecord))
)

;type name? (%define-record :URLCallbackInfo (find-record-descriptor ':URLCallbackInfo))
;  authentication type flags

(defconstant $kUserNameAndPasswordFlag 1)
(defconstant $kURLURL "URLString")
; #define kURLURL                         "URLString"
(defconstant $kURLResourceSize "URLResourceSize")
; #define kURLResourceSize                "URLResourceSize"
(defconstant $kURLLastModifiedTime "URLLastModifiedTime")
; #define kURLLastModifiedTime            "URLLastModifiedTime"
(defconstant $kURLMIMEType "URLMIMEType")
; #define kURLMIMEType                    "URLMIMEType"
(defconstant $kURLFileType "URLFileType")
; #define kURLFileType                    "URLFileType"
(defconstant $kURLFileCreator "URLFileCreator")
; #define kURLFileCreator                 "URLFileCreator"
(defconstant $kURLCharacterSet "URLCharacterSet")
; #define kURLCharacterSet                "URLCharacterSet"
(defconstant $kURLResourceName "URLResourceName")
; #define kURLResourceName                "URLResourceName"
(defconstant $kURLHost "URLHost")
; #define kURLHost                        "URLHost"
(defconstant $kURLAuthType "URLAuthType")
; #define kURLAuthType                    "URLAuthType"
(defconstant $kURLUserName "URLUserName")
; #define kURLUserName                    "URLUserName"
(defconstant $kURLPassword "URLPassword")
; #define kURLPassword                    "URLPassword"
(defconstant $kURLStatusString "URLStatusString")
; #define kURLStatusString                "URLStatusString"
(defconstant $kURLIsSecure "URLIsSecure")
; #define kURLIsSecure                    "URLIsSecure"
(defconstant $kURLCertificate "URLCertificate")
; #define kURLCertificate                 "URLCertificate"
(defconstant $kURLTotalItems "URLTotalItems")
; #define kURLTotalItems                  "URLTotalItems"
(defconstant $kURLConnectTimeout "URLConnectTimeout")
; #define kURLConnectTimeout              "URLConnectTimeout"
;  http and https properties
(defconstant $kURLHTTPRequestMethod "URLHTTPRequestMethod")
; #define kURLHTTPRequestMethod           "URLHTTPRequestMethod"
(defconstant $kURLHTTPRequestHeader "URLHTTPRequestHeader")
; #define kURLHTTPRequestHeader           "URLHTTPRequestHeader"
(defconstant $kURLHTTPRequestBody "URLHTTPRequestBody")
; #define kURLHTTPRequestBody             "URLHTTPRequestBody"
(defconstant $kURLHTTPRespHeader "URLHTTPRespHeader")
; #define kURLHTTPRespHeader              "URLHTTPRespHeader"
(defconstant $kURLHTTPUserAgent "URLHTTPUserAgent")
; #define kURLHTTPUserAgent               "URLHTTPUserAgent"
(defconstant $kURLHTTPRedirectedURL "URLHTTPRedirectedURL")
; #define kURLHTTPRedirectedURL           "URLHTTPRedirectedURL"
(defconstant $kURLSSLCipherSuite "URLSSLCipherSuite")
; #define kURLSSLCipherSuite              "URLSSLCipherSuite"
; 
;  *  URLGetURLAccessVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLGetURLAccessVersion" 
   ((returnVers (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )

; #if TARGET_RT_MAC_CFM
; #ifdef __cplusplus
#| #|
    inline pascal Boolean URLAccessAvailable() { return ((URLGetURLAccessVersion != (void*)kUnresolvedCFragSymbolAddress) ); }
|#
 |#

; #else
; #define URLAccessAvailable()    ((URLGetURLAccessVersion != (void*)kUnresolvedCFragSymbolAddress) )

; #endif

#| 
; #elif TARGET_RT_MAC_MACHO
;  URL Access is always available on OS X 
; #ifdef __cplusplus
#|
    inline pascal Boolean URLAccessAvailable() { return true; }
|#

; #else
; #define URLAccessAvailable()    (true)

; #endif

 |#

; #endif  /*  */


(def-mactype :URLNotifyProcPtr (find-mactype ':pointer)); (void * userContext , URLEvent event , URLCallbackInfo * callbackInfo)

(def-mactype :URLSystemEventProcPtr (find-mactype ':pointer)); (void * userContext , EventRecord * event)

(def-mactype :URLNotifyUPP (find-mactype '(:pointer :OpaqueURLNotifyProcPtr)))

(def-mactype :URLSystemEventUPP (find-mactype '(:pointer :OpaqueURLSystemEventProcPtr)))
; 
;  *  NewURLNotifyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewURLNotifyUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueURLNotifyProcPtr)
() )
; 
;  *  NewURLSystemEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewURLSystemEventUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueURLSystemEventProcPtr)
() )
; 
;  *  DisposeURLNotifyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeURLNotifyUPP" 
   ((userUPP (:pointer :OpaqueURLNotifyProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeURLSystemEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeURLSystemEventUPP" 
   ((userUPP (:pointer :OpaqueURLSystemEventProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeURLNotifyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeURLNotifyUPP" 
   ((userContext :pointer)
    (event :UInt32)
    (callbackInfo (:pointer :URLCallbackInfo))
    (userUPP (:pointer :OpaqueURLNotifyProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InvokeURLSystemEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeURLSystemEventUPP" 
   ((userContext :pointer)
    (event (:pointer :EventRecord))
    (userUPP (:pointer :OpaqueURLSystemEventProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLSimpleDownload()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLSimpleDownload" 
   ((url (:pointer :char))
    (destination (:pointer :FSSpec))            ;  can be NULL 
    (destinationHandle :Handle)                 ;  can be NULL 
    (openFlags :UInt32)
    (eventProc (:pointer :OpaqueURLSystemEventProcPtr));  can be NULL 
    (userContext :pointer)                      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLDownload()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLDownload" 
   ((urlRef (:pointer :OpaqueURLReference))
    (destination (:pointer :FSSpec))            ;  can be NULL 
    (destinationHandle :Handle)                 ;  can be NULL 
    (openFlags :UInt32)
    (eventProc (:pointer :OpaqueURLSystemEventProcPtr));  can be NULL 
    (userContext :pointer)                      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLSimpleUpload()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLSimpleUpload" 
   ((url (:pointer :char))
    (source (:pointer :FSSpec))
    (openFlags :UInt32)
    (eventProc (:pointer :OpaqueURLSystemEventProcPtr));  can be NULL 
    (userContext :pointer)                      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLUpload()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLUpload" 
   ((urlRef (:pointer :OpaqueURLReference))
    (source (:pointer :FSSpec))
    (openFlags :UInt32)
    (eventProc (:pointer :OpaqueURLSystemEventProcPtr));  can be NULL 
    (userContext :pointer)                      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLNewReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLNewReference" 
   ((url (:pointer :char))
    (urlRef (:pointer :URLREFERENCE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLDisposeReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLDisposeReference" 
   ((urlRef (:pointer :OpaqueURLReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLOpen()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLOpen" 
   ((urlRef (:pointer :OpaqueURLReference))
    (fileSpec (:pointer :FSSpec))               ;  can be NULL 
    (openFlags :UInt32)
    (notifyProc (:pointer :OpaqueURLNotifyProcPtr));  can be NULL 
    (eventRegister :UInt32)
    (userContext :pointer)                      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLAbort()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLAbort" 
   ((urlRef (:pointer :OpaqueURLReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLGetDataAvailable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLGetDataAvailable" 
   ((urlRef (:pointer :OpaqueURLReference))
    (dataSize (:pointer :SIZE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLGetBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLGetBuffer" 
   ((urlRef (:pointer :OpaqueURLReference))
    (buffer :pointer)
    (bufferSize (:pointer :SIZE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLReleaseBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLReleaseBuffer" 
   ((urlRef (:pointer :OpaqueURLReference))
    (buffer :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLGetProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLGetProperty" 
   ((urlRef (:pointer :OpaqueURLReference))
    (property (:pointer :char))
    (propertyBuffer :pointer)
    (bufferSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLGetPropertySize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLGetPropertySize" 
   ((urlRef (:pointer :OpaqueURLReference))
    (property (:pointer :char))
    (propertySize (:pointer :SIZE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLSetProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLSetProperty" 
   ((urlRef (:pointer :OpaqueURLReference))
    (property (:pointer :char))
    (propertyBuffer :pointer)
    (bufferSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLGetCurrentState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLGetCurrentState" 
   ((urlRef (:pointer :OpaqueURLReference))
    (state (:pointer :URLSTATE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLGetError()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLGetError" 
   ((urlRef (:pointer :OpaqueURLReference))
    (urlError (:pointer :OSStatus))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLIdle" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  URLGetFileInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
;  

(deftrap-inline "_URLGetFileInfo" 
   ((fName (:pointer :UInt8))
    (fType (:pointer :OSType))
    (fCreator (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __URLACCESS__ */


(provide-interface "URLAccess")