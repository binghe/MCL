(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFHTTPMessage.h"
; at Sunday July 2,2006 7:23:40 pm.
; 
;      File:       CFNetwork/CFHTTPMessage.h
;  
;      Contains:   CoreFoundation Network socket streams header
;  
;      Version:    CFNetwork-71.2~1
;  
;      Copyright:  © 2001-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CFHTTPMESSAGE__
; #define __CFHTTPMESSAGE__
; #ifndef __CFSTRING__

(require-interface "CoreFoundation/CFString")

; #endif

; #ifndef __CFURL__

(require-interface "CoreFoundation/CFURL")

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
; 
;  *  kCFHTTPVersion1_0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFHTTPVersion1_0 (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
; 
;  *  kCFHTTPVersion1_1
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFHTTPVersion1_1 (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
; 
;  *  kCFHTTPAuthenticationSchemeBasic
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFHTTPAuthenticationSchemeBasic (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; 
;  *  kCFHTTPAuthenticationSchemeDigest
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFHTTPAuthenticationSchemeDigest (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  Currently unsupported 

(def-mactype :CFHTTPMessageRef (find-mactype '(:pointer :__CFHTTPMessage)))
; 
;  *  CFHTTPMessageGetTypeID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :UInt32
() )
; 
;  *  CFHTTPMessageCreateRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageCreateRequest" 
   ((allocator (:pointer :__CFAllocator))
    (requestMethod (:pointer :__CFString))
    (url (:pointer :__CFURL))
    (httpVersion (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :__CFHTTPMessage)
() )
;  Pass NULL to use the standard description for the given status code, as found in RFC 2616
; 
;  *  CFHTTPMessageCreateResponse()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageCreateResponse" 
   ((allocator (:pointer :__CFAllocator))
    (statusCode :signed-long)
    (statusDescription (:pointer :__CFString))
    (httpVersion (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :__CFHTTPMessage)
() )
;  Creates an empty request or response, which you can then append bytes to via CFHTTPMessageAppendBytes().  The HTTP header information will be parsed out as the bytes are appended.
; 
;  *  CFHTTPMessageCreateEmpty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageCreateEmpty" 
   ((allocator (:pointer :__CFAllocator))
    (isRequest :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :__CFHTTPMessage)
() )
; 
;  *  CFHTTPMessageCreateCopy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageCreateCopy" 
   ((allocator (:pointer :__CFAllocator))
    (message (:pointer :__CFHTTPMessage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :__CFHTTPMessage)
() )
;  Whether the message is a response or a request
; 
;  *  CFHTTPMessageIsRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageIsRequest" 
   ((message (:pointer :__CFHTTPMessage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
; 
;  *  CFHTTPMessageCopyVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageCopyVersion" 
   ((message (:pointer :__CFHTTPMessage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :__CFString)
() )
; 
;  *  CFHTTPMessageCopyBody()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageCopyBody" 
   ((message (:pointer :__CFHTTPMessage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :__CFData)
() )
; 
;  *  CFHTTPMessageSetBody()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageSetBody" 
   ((message (:pointer :__CFHTTPMessage))
    (bodyData (:pointer :__CFData))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  CFHTTPMessageCopyHeaderFieldValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageCopyHeaderFieldValue" 
   ((message (:pointer :__CFHTTPMessage))
    (headerField (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :__CFString)
() )
; 
;  *  CFHTTPMessageCopyAllHeaderFields()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageCopyAllHeaderFields" 
   ((message (:pointer :__CFHTTPMessage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :__CFDictionary)
() )
; 
;  *  CFHTTPMessageSetHeaderFieldValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageSetHeaderFieldValue" 
   ((message (:pointer :__CFHTTPMessage))
    (headerField (:pointer :__CFString))
    (value (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
;  The following function appends the given bytes to the message given (parsing out any control information if appropriate).  Returns FALSE if a parsing error occurs while processing the new data.
; 
;  *  CFHTTPMessageAppendBytes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageAppendBytes" 
   ((message (:pointer :__CFHTTPMessage))
    (newBytes (:pointer :UInt8))
    (numBytes :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
;  Whether further header data is expected by the message
; 
;  *  CFHTTPMessageIsHeaderComplete()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageIsHeaderComplete" 
   ((message (:pointer :__CFHTTPMessage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
; 
;  *  CFHTTPMessageCopySerializedMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageCopySerializedMessage" 
   ((request (:pointer :__CFHTTPMessage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :__CFData)
() )
; *******************
;  Request functions 
; *******************
; 
;  *  CFHTTPMessageCopyRequestURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageCopyRequestURL" 
   ((request (:pointer :__CFHTTPMessage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :__CFURL)
() )
; 
;  *  CFHTTPMessageCopyRequestMethod()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageCopyRequestMethod" 
   ((request (:pointer :__CFHTTPMessage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :__CFString)
() )
;  Tries to modify request to contain the authentication information 
;    requested by authenticationFailureResponse (which presumably is a 
;    401 or 407 response).  Returns TRUE if successful; FALSE otherwise 
;    (leaving request unmodified).  If authenticationScheme is NULL, the 
;    strongest supported scheme listed in failedResponse will be used. 
; 
;  *  CFHTTPMessageAddAuthentication()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageAddAuthentication" 
   ((request (:pointer :__CFHTTPMessage))
    (authenticationFailureResponse (:pointer :__CFHTTPMessage))
    (username (:pointer :__CFString))
    (password (:pointer :__CFString))
    (authenticationScheme (:pointer :__CFString))
    (forProxy :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
; ********************
;  Response functions 
; ********************
; 
;  *  CFHTTPMessageGetResponseStatusCode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageGetResponseStatusCode" 
   ((response (:pointer :__CFHTTPMessage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :UInt32
() )
; 
;  *  CFHTTPMessageCopyResponseStatusLine()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPMessageCopyResponseStatusLine" 
   ((response (:pointer :__CFHTTPMessage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :__CFString)
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __CFHTTPMESSAGE__ */


(provide-interface "CFHTTPMessage")