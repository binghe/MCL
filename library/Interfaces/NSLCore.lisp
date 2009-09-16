(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSLCore.h"
; at Sunday July 2,2006 7:23:37 pm.
; 
;      File:       NSLCore/NSLCore.h
;  
;      Contains:   Interface to API for using the NSL Manager
;  
;      Version:    NSLCore-97~1
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __NSLCORE__
; #define __NSLCORE__
; #ifndef __CARBONCORE__
#| #|
#include <CarbonCoreCarbonCore.h>
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

(defconstant $kNSLMinSystemVersion #x900)       ;  equivalent to 9.0

(defconstant $kNSLMinOTVersion #x130)           ;  equivalent to 1.3


(defconstant $kNSLDefaultListSize #x100)        ;  default list size for service and protocol lists


(defconstant $kNSLURLDelimiter 44)              ;  delimits URL's within memory buffers

; #define    kNSLErrorNoErr              {noErr, kNSLNoContext}      /* an initializer for the NSLError struct */

(defconstant $kNSLNoContext 0)                  ;  the default context for NSLError structs

(defrecord NSLError
   (theErr :SInt32)
   (theContext :UInt32)
)

;type name? (%define-record :NSLError (find-record-descriptor ':NSLError))

(def-mactype :NSLErrorPtr (find-mactype '(:pointer :NSLError)))
;  Constants to use with NSLPrepareRequest
;  kNSLDuplicateSearchInProgress is not strictly an error.  The client is free to ignore
;  this result, and nothing bad will happen if it does.  It is
;  informational only.

(defconstant $kNSLDuplicateSearchInProgress 100)
(defconstant $kNSLUserCanceled -128)            ;  User hit cancel from the NSLStandardGetURL dialog 
;  Invalid enumeratorRef  

(defconstant $kNSLInvalidEnumeratorRef 0)       ;  this is not an error; it is the equiv to a NULL ptr


(def-mactype :NSLSearchState (find-mactype ':UInt16))
;  State codes for notifiers.

(defconstant $kNSLSearchStateBufferFull 1)
(defconstant $kNSLSearchStateOnGoing 2)
(defconstant $kNSLSearchStateComplete 3)
(defconstant $kNSLSearchStateStalled 4)
(defconstant $kNSLWaitingForContinue 5)

(def-mactype :NSLEventCode (find-mactype ':UInt32))
;  Event codes

(defconstant $kNSLServicesLookupDataEvent 6)
(defconstant $kNSLNeighborhoodLookupDataEvent 7)
(defconstant $kNSLNewDataEvent 8)
(defconstant $kNSLContinueLookupEvent 9)

(def-mactype :NSLClientRef (find-mactype ':UInt32))

(def-mactype :NSLRequestRef (find-mactype ':UInt32))

(def-mactype :NSLOneBasedIndex (find-mactype ':UInt32))

(def-mactype :NSLPath (find-mactype '(:pointer :character)))

(def-mactype :NSLServiceType (find-mactype '(:pointer :character)))

(def-mactype :NSLServicesList (find-mactype ':Handle))

(def-mactype :NSLNeighborhood (find-mactype '(:pointer :UInt8)))
; 
;    cstring which is a comma delimited list of protocols which can be used to
;    create a NSLProtocolList internally
; 
;  the async information block for client<->manager interaction
(defrecord NSLClientAsyncInfo
   (clientContextPtr :pointer)                  ;  set by the client for its own use
   (mgrContextPtr :pointer)                     ;  set by NSL mgr; ptr to request object ptr
   (resultBuffer (:pointer :char))
   (bufferLen :signed-long)
   (maxBufferSize :signed-long)
   (startTime :UInt32)                          ;  when the search starts, to use with maxSearchTime to determine time-out condition
   (intStartTime :UInt32)                       ;  used with alertInterval
   (maxSearchTime :UInt32)                      ;  total time for search, in ticks (0 == no time limit)
   (alertInterval :UInt32)                      ;  call client's notifier or return, every this many ticks ( 0 == don't use this param)
   (totalItems :UInt32)                         ;  total number of tuples currently in buffer
   (alertThreshold :UInt32)                     ;  call client's notifier or return, every this many items found ( 0 == don't use this param)
   (searchState :UInt16)
   (searchResult :NSLError)
   (searchDataType :UInt32)                     ;  this is a data type code which allows the client's asyncNotifier to properly
                                                ;  handle the data in resultBuffer.
)

;type name? (%define-record :NSLClientAsyncInfo (find-record-descriptor ':NSLClientAsyncInfo))

(def-mactype :NSLClientAsyncInfoPtr (find-mactype '(:pointer :NSLClientAsyncInfo)))
;  the async information block plugin<->manager interaction
(defrecord NSLPluginAsyncInfo
   (mgrContextPtr :pointer)                     ;  set by NSL mgr; ptr to request object ptr
   (pluginContextPtr :pointer)                  ;  set/used by individual plugins
   (pluginPtr :pointer)                         ;  ptr to the plugin object waiting for continue lookup call
   (resultBuffer (:pointer :char))              ;  set by plugin to point at data
   (bufferLen :signed-long)
   (maxBufferSize :signed-long)
   (maxSearchTime :UInt32)                      ;  total time for search, in ticks (0 == no time limit)
   (reserved1 :UInt32)
   (reserved2 :UInt32)
   (reserved3 :UInt32)
   (clientRef :UInt32)
   (requestRef :UInt32)
   (searchState :UInt16)
   (searchResult :SInt32)
)

;type name? (%define-record :NSLPluginAsyncInfo (find-record-descriptor ':NSLPluginAsyncInfo))

(def-mactype :NSLPluginAsyncInfoPtr (find-mactype '(:pointer :NSLPluginAsyncInfo)))
;  the manager asynchronous notifier routine.

(def-mactype :NSLMgrNotifyProcPtr (find-mactype ':pointer)); (NSLPluginAsyncInfo * thePluginAsyncInfo)
;  the client asynchronous notifier routine.

(def-mactype :NSLClientNotifyProcPtr (find-mactype ':pointer)); (NSLClientAsyncInfo * theClientAsyncInfo)

(def-mactype :NSLMgrNotifyUPP (find-mactype '(:pointer :OpaqueNSLMgrNotifyProcPtr)))

(def-mactype :NSLClientNotifyUPP (find-mactype '(:pointer :OpaqueNSLClientNotifyProcPtr)))
; 
;  *  NewNSLMgrNotifyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewNSLMgrNotifyUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueNSLMgrNotifyProcPtr)
() )
; 
;  *  NewNSLClientNotifyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewNSLClientNotifyUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueNSLClientNotifyProcPtr)
() )
; 
;  *  DisposeNSLMgrNotifyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeNSLMgrNotifyUPP" 
   ((userUPP (:pointer :OpaqueNSLMgrNotifyProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeNSLClientNotifyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeNSLClientNotifyUPP" 
   ((userUPP (:pointer :OpaqueNSLClientNotifyProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeNSLMgrNotifyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeNSLMgrNotifyUPP" 
   ((thePluginAsyncInfo (:pointer :NSLPluginAsyncInfo))
    (userUPP (:pointer :OpaqueNSLMgrNotifyProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeNSLClientNotifyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeNSLClientNotifyUPP" 
   ((theClientAsyncInfo (:pointer :NSLClientAsyncInfo))
    (userUPP (:pointer :OpaqueNSLClientNotifyProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    this struct is a format for dealing with our internal data representation.  Typed data will be contiguous chunk of
;    memory, with the first 4 bytes being a data "descriptor".
; 
(defrecord NSLTypedData
   (dataType :UInt32)
   (lengthOfData :UInt32)
                                                ;   void*                           theData; 
)

;type name? (%define-record :NSLTypedData (find-record-descriptor ':NSLTypedData))

(def-mactype :NSLTypedDataPtr (find-mactype '(:pointer :NSLTypedData)))
(defconstant $kNSLDataType "NSL_")
; #define kNSLDataType                'NSL_'
; 
;    This is just a header at the beginning of a handle that stores our list of service types.
;    Each service type is a pascal string, so each service type starts after the end of the
;    previous one.
; 
(defrecord NSLServicesListHeader
   (numServices :UInt32)
   (logicalLen :UInt32)                         ;  length of all usable data in handle
                                                ;   Ptr                             firstService; 
)

;type name? (%define-record :NSLServicesListHeader (find-record-descriptor ':NSLServicesListHeader))

(def-mactype :NSLServicesListHeaderPtr (find-mactype '(:pointer :NSLServicesListHeader)))
;  some defs for common protocols
(defconstant $kSLPProtocolType "SLP")
; #define    kSLPProtocolType                    "SLP"
(defconstant $kDNSProtocolType "DNS")
; #define   kDNSProtocolType                    "DNS"
(defconstant $kLDAPProtocolType "LDAP")
; #define   kLDAPProtocolType                   "LDAP"
(defconstant $kNBPProtocolType "NBP")
; #define kNBPProtocolType                 "NBP"
(defconstant $kNSLDirectoryServiceProtocolType "DirService")
; #define kNSLDirectoryServiceProtocolType  "DirService"
; 
;    general information from a plug-in.  Includes supported protocols, data types and services,
;    as well as an info/comment string describing the function of the plug-in in human-readable
;    form.  The offsets point to the beginning of each list of data returned, and the protocol
;    data offset is the startOfData member of the struct
; 
(defrecord NSLPluginData
   (reserved1 :signed-long)
   (reserved2 :signed-long)
   (reserved3 :signed-long)
   (supportsRegistration :Boolean)
   (isPurgeable :Boolean)
   (totalLen :UInt16)                           ;  length of everything, including header
   (dataTypeOffset :UInt16)
   (serviceListOffset :UInt16)
   (protocolListOffset :UInt16)
   (commentStringOffset :UInt16)
                                                ;   char*                           startOfData; 
                                                ;  protocol data is first on the list
)

;type name? (%define-record :NSLPluginData (find-record-descriptor ':NSLPluginData))

(def-mactype :NSLPluginDataPtr (find-mactype '(:pointer :NSLPluginData)))
; 
;   -----------------------------------------------------------------------------
;     Finding out if the library is present and getting its version
;   -----------------------------------------------------------------------------
; 
; 
;  *  NSLLibraryVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLLibraryVersion" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; #ifdef __cplusplus
#| #|
     inline pascal Boolean NSLLibraryPresent() { return NSLLibraryVersion != (void*)kUnresolvedCFragSymbolAddress; }
    
|#
 |#

; #else
; #define NSLLibraryPresent()     ((NSLLibraryVersion != (void*)kUnresolvedCFragSymbolAddress))

; #endif

; 
;   -----------------------------------------------------------------------------
;     High level API calls: the following two calls are ALL an application needs
;     to register/deregister its service.
;     If you use these, you don't need to make any of the other calls to NSLAPI 
;     (including NSLOpenNavigationAPI) 
;   -----------------------------------------------------------------------------
; 
;  <--- error code from registration 
;  ---> urlToRegister is a null terminated url that has only legal characters defined for URLs.  Use HexEncodeText to encode
;           portions of the url that have illegal characters 
;  ---> neighborhoodToRegisterIn is an optional parameter for explicitly defining a neighborhood to register in.
;             If parameter is NULL, then the plugins will determine where to register the service 
; 
;  *  NSLStandardRegisterURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLStandardRegisterURL" 
   ((returnArg (:pointer :NSLError))
    (urlToRegister (:pointer :character))
    (neighborhoodToRegisterIn (:pointer :UInt8));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  <--- error code from registration 
;  ---> urlToRegister is a null terminated url that has only legal characters defined for URLs.  Use HexEncodeText to encode
;           portions of the url that have illegal characters 
;  ---> neighborhoodToDeregisterIn is an optional parameter for explicitly defining a neighborhood to register in.
;             If parameter is NULL, then the plugins will determine where to register the service 
; 
;  *  NSLStandardDeregisterURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLStandardDeregisterURL" 
   ((returnArg (:pointer :NSLError))
    (urlToDeregister (:pointer :character))
    (neighborhoodToDeregisterIn (:pointer :UInt8));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; -----------------------------------------------------------------------------
; 
;  *  NSLHexEncodeText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLHexEncodeText" 
   ((rawText (:pointer :char))
    (rawTextLen :UInt16)
    (newTextBuffer (:pointer :char))
    (newTextBufferLen (:pointer :UInt16))
    (textChanged (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NSLHexDecodeText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLHexDecodeText" 
   ((encodedText (:pointer :char))
    (encodedTextLen :UInt16)
    (decodedTextBuffer (:pointer :char))
    (decodedTextBufferLen (:pointer :UInt16))
    (textChanged (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;   -----------------------------------------------------------------------------
;     Basic API Utility calls: sufficient to create, and parse data structures
;   -----------------------------------------------------------------------------
; 
; 
;  *  NSLMakeNewServicesList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLMakeNewServicesList" 
   ((initialServiceList (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  NSLAddServiceToServicesList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLAddServiceToServicesList" 
   ((returnArg (:pointer :NSLError))
    (serviceList :Handle)
    (serviceType (:pointer :character))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NSLDisposeServicesList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLDisposeServicesList" 
   ((theList :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     The name reflects the name of the Neighborhood, i.e. "apple.com." or "AppleTalk Zone One".
;     The protocolList is a comma delimited list of protocols that the Neighborhood might exist in.
;     If the user passes in NULL, then all protocols will be queried.  The result must be disposed
;     of by the user by calling NSLFreeNeighborhood.
; 
; 
;  *  NSLMakeNewNeighborhood()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLMakeNewNeighborhood" 
   ((name (:pointer :char))
    (protocolList (:pointer :char))             ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :UInt8)
() )
;  creates an exact copy of an existing neighborhood 
; 
;  *  NSLCopyNeighborhood()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLCopyNeighborhood" 
   ((neighborhood (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :UInt8)
() )
; 
;  *  NSLFreeNeighborhood()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLFreeNeighborhood" 
   ((neighborhood (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :UInt8)
() )
; 
;  *  NSLGetNameFromNeighborhood()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLGetNameFromNeighborhood" 
   ((neighborhood (:pointer :UInt8))
    (name (:pointer :char))
    (length (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    create a block of formatted data, pointed to by newDataPtr.  This will be used
;    in calls (typically request-related calls) for plug-ins that handle the NSL data type.
; 
; 
;  *  NSLMakeServicesRequestPB()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLMakeServicesRequestPB" 
   ((serviceList :Handle)
    (newDataPtr (:pointer :NSLTYPEDDATAPTR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  releases any storage created with MakeXXXPB calls, associated with TypedData.
; 
;  *  NSLFreeTypedDataPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLFreeTypedDataPtr" 
   ((nslTypeData (:pointer :NSLTypedData))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :NSLTypedData)
() )
; 
;    utility function that returns whether a url was found, a pointer to the beginning
;    of the url, and the length of the URL.
; 
; 
;  *  NSLGetNextUrl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLGetNextUrl" 
   ((infoPtr (:pointer :NSLClientAsyncInfo))
    (urlPtr (:pointer :char))
    (urlLength (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    utility function that returns whether a Neighborhood was found, a pointer to the beginning
;    of the Neighborhood, and the length of the Neighborhood.
; 
; 
;  *  NSLGetNextNeighborhood()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLGetNextNeighborhood" 
   ((infoPtr (:pointer :NSLClientAsyncInfo))
    (neighborhood (:pointer :NSLNEIGHBORHOOD))
    (neighborhoodLength (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    NSLErrorToString:    convert a numeric error code to its string equivalent.  Caller must
;                         have allocated sufficient space to store both strings.  (Max 255 chars each)
;                                 
;                         The errorString parameter will return a textual explanation of what is wrong,
;                         while the solutionString returns a possible solution to get around the problem
; 
; 
;  *  NSLErrorToString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLErrorToString" 
   ((theErr (:pointer :NSLError))
    (errorString (:pointer :char))
    (solutionString (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;   -----------------------------------------------------------------------------
;     Basic API calls: sufficient to create simple requests, and receive answers
;   -----------------------------------------------------------------------------
; 
; 
;  *  NSLOpenNavigationAPI()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLOpenNavigationAPI" 
   ((newRef (:pointer :NSLCLIENTREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NSLCloseNavigationAPI()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLCloseNavigationAPI" 
   ((theClient :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     NSLPrepareRequest:  creates an NSLRequestRef, sets up some internal data
;     notifier is an NSLClientNotifyUPP that will be called when data is available, when the lookup has
;     completed, or if an error occurs.  When the notifier is called, the cookie will be the NSLRequestRef.
;     If notifier is NULL, then the NSLManager will assume that the request is made synchronously.  This
;     should only be used while in a separate thread, so that the client app can still process events, etc.
;     
;     contextPtr is a void* which is passed as the contextPtr argument when the notifier is called.  
;     
;     upon exit:
;     1) ref will contain a pointer to a NSLRequestRef which must be passed to all other functions
;     which require a NSLRequestRef.
;     2) infoPtr will point to a newly created ClientAsycnInfoPtr which will be disposed by the manager when the search is completed
;     NOTE: Only one search can be running at a time per clientRef.
; 
; 
;  *  NSLPrepareRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLPrepareRequest" 
   ((returnArg (:pointer :NSLError))
    (notifier (:pointer :OpaqueNSLClientNotifyProcPtr))
    (contextPtr :pointer)
    (theClient :UInt32)
    (ref (:pointer :NSLREQUESTREF))
    (bufPtr (:pointer :char))
    (bufLen :UInt32)
    (infoPtr (:pointer :NSLCLIENTASYNCINFOPTR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    NSLStartNeighborhoodLookup: looking for neighborhoods associated with or neighboring a particular neighborhood
;     Passing in NULL for neighborhood will generate a list of a default neighborhood(s)
;    
; 
; 
;  *  NSLStartNeighborhoodLookup()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLStartNeighborhoodLookup" 
   ((returnArg (:pointer :NSLError))
    (ref :UInt32)
    (neighborhood (:pointer :UInt8))
    (asyncInfo (:pointer :NSLClientAsyncInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    NSLStartServicesLookup: starts looking for entities if the specified type in the specified neighborhood
;    
; 
; 
;  *  NSLStartServicesLookup()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLStartServicesLookup" 
   ((returnArg (:pointer :NSLError))
    (ref :UInt32)
    (neighborhood (:pointer :UInt8))
    (requestData (:pointer :NSLTypedData))
    (asyncInfo (:pointer :NSLClientAsyncInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  NSLContinueLookup:  continues a paused/outstanding lookup
; 
;  *  NSLContinueLookup()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLContinueLookup" 
   ((returnArg (:pointer :NSLError))
    (asyncInfo (:pointer :NSLClientAsyncInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  NSLCancelRequest: cancels an ongoing search
; 
;  *  NSLCancelRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLCancelRequest" 
   ((returnArg (:pointer :NSLError))
    (ref :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    NSLDeleteRequest: deletes info associated with this ref.  The ClientAsyncInfoPtr will no longer be valid
;     This must be called when the client is no longer using this requestRef.
; 
; 
;  *  NSLDeleteRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLDeleteRequest" 
   ((returnArg (:pointer :NSLError))
    (ref :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;   -----------------------------------------------------------------------------
;    Utility API calls: use these accessors to manipulate NSL's typed data
;   -----------------------------------------------------------------------------
; 
;  NSLParseServicesRequestPB provides the inverse of NSLMakeRequestPB, filling out the offsets found within newDataPtr
;  <--- returns an OSStatus if any errors occur parsing the data 
;  <--- newDataPtr is the construct passed to the plugin 
;  ---> serviceListPtr is the address of a pointer which will be set to point at the portion of the newDataPtr that holds the serviceList to be searched 
;  ---> serviceListLen is the length of the serviceListPtr data pointed to by serviceListPtr 
; 
;  *  NSLParseServicesRequestPB()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.0 and later
;  

(deftrap-inline "_NSLParseServicesRequestPB" 
   ((newDataPtr (:pointer :NSLTypedData))
    (serviceListPtr (:pointer :char))
    (serviceListLen (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  NSLParseServiceRegistrationPB provides for breaking apart a registration request from a client to a plugin 
;  <--- returns an OSStatus if any errors occur parsing the data 
;  <--- newDataPtr is the construct passed to the plugin 
;  ---> neighborhoodPtr gets set to point at the portion of the newDataPtr that contains the neighborhood 
;  ---> neighborhoodLen is the length of the neighborhood pointed to by neighborhoodPtr 
;  ---> urlPtr is the address of a pointer which will be set to point at the portion of the newDataPtr that holds the url to be registered 
;  ---> urlLen is the length of the url data pointed to by urlPtr 
; 
;  *  NSLParseServiceRegistrationPB()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLParseServiceRegistrationPB" 
   ((newDataPtr (:pointer :NSLTypedData))
    (neighborhoodPtr (:pointer :NSLNEIGHBORHOOD))
    (neighborhoodLen (:pointer :UInt16))
    (urlPtr (:pointer :char))
    (urlLen (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  NSLGetErrorStringsFromResource is obsolete in X.  It will ignore the fileSpecPtr 
;  and errorResID parameters and return the standard error strings. 
;  NSLGetErrorStringsFromResource makes a basic assumption: 
;  errorString and solutionString both point to valid memory of at least 256 bytes! 
;  <--- returns an OSStatus if any errors occur 
;  ---> theErr is an OSStatus to be matched against a resource list of errors 
;  ---> fileSpecPtr is a FSSpecPtr to the resource containing the list of errors 
;  ---> errorResID is the resourceID of the NSLI resource of the list of errors 
;  <--> errorString is a pointer to valid memory of at least 256 bytes which will be filled out by the error portion of the error string 
;  <--> solutionString is a pointer to valid memory of at least 256 bytes which will be filled out by the solution portion of the error string 
; 
;  *  NSLGetErrorStringsFromResource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLGetErrorStringsFromResource" 
   ((theErr :SInt32)
    (fileSpecPtr (:pointer :FSSpec))
    (errorResID :SInt16)
    (errorString (:pointer :char))
    (solutionString (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  <--- Returns true if given service is in the given service list 
;  ---> serviceList is a valid NSLServicesList containing information about services to be searched 
;  ---> svcToFind is an NSLServiceType of a particular service to check if it is in the serviceList 
; 
;  *  NSLServiceIsInServiceList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLServiceIsInServiceList" 
   ((serviceList :Handle)
    (svcToFind (:pointer :character))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  <--- returns an OSStatus if any errors occur parsing the data 
;  ---> svcString is the address of a pointer which will be set to point at the portion of theURL that holds the serviceType of theURL 
;  ---> svcLen is the length of the serviceType pointed to by svcString 
; 
;  *  NSLGetServiceFromURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLGetServiceFromURL" 
   ((theURL (:pointer :char))
    (svcString (:pointer :char))
    (svcLen (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  <--- returns the length of a Neighborhood data structure 
;  ---> neighborhood is a valid NSLNeighborhood 
; 
;  *  NSLGetNeighborhoodLength()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLGetNeighborhoodLength" 
   ((neighborhood (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;   -------------------------------------------------------------------------------------
;    Utility API calls: use these routines to separate plugin threads from client threads
;   -------------------------------------------------------------------------------------
; 
;  this routine works the same as the Thread manager's routine NewThread, except 
;  that the thread is added to the NSL manager's thread list. 
; 
;  *  NSLNewThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLNewThread" 
   ((threadStyle :UInt32)
    (threadEntry :pointer)
    (threadParam :pointer)
    (stackSize :signed-long)
    (options :UInt32)
    (threadResult :pointer)
    (threadMade (:pointer :THREADID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  this routine works the same as the Thread manager's routine DisposeThread, except 
;  that the thread is removed from the NSL manager's thread list. 
; 
;  *  NSLDisposeThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLDisposeThread" 
   ((threadToDump :UInt32)
    (threadResult :pointer)
    (recycleThread :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

; #if OLDROUTINENAMES
#| 
(%define-record :ClientAsyncInfo (find-record-descriptor ':NSLClientAsyncInfo))

(%define-record :PluginAsyncInfo (find-record-descriptor ':NSLPluginAsyncInfo))

(%define-record :TypedData (find-record-descriptor ':NSLTypedData))

(%define-record :PluginData (find-record-descriptor ':NSLPluginData))

(def-mactype :ClientAsyncInfoPtr (find-mactype ':NSLClientAsyncInfoPtr))

(def-mactype :PluginAsyncInfoPtr (find-mactype ':NSLPluginAsyncInfoPtr))

(def-mactype :TypedDataPtr (find-mactype ':NSLTypedDataPtr))

(def-mactype :PluginDataPtr (find-mactype ':NSLPluginDataPtr))
 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __NSLCORE__ */


(provide-interface "NSLCore")