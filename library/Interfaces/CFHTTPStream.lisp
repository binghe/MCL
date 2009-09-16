(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFHTTPStream.h"
; at Sunday July 2,2006 7:23:40 pm.
; 
;      File:       CFNetwork/CFHTTPStream.h
;  
;      Contains:   CoreFoundation Network HTTP streams header
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
; #ifndef __CFHTTPSTREAM__
; #define __CFHTTPSTREAM__
; #ifndef __CFSTREAM__

(require-interface "CoreFoundation/CFStream")

; #endif

; #ifndef __CFHTTPMESSAGE__
#| #|
#include <CFNetworkCFHTTPMessage.h>
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

; #if PRAGMA_ENUM_ALWAYSINT
#| ; #pragma enumsalwaysint on
 |#

; #endif

; 
;  *  kCFStreamErrorDomainHTTP
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFStreamErrorDomainHTTP (find-mactype ':SInt32)); AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
(def-mactype :CFStreamErrorHTTP (find-mactype ':sint32))

(defconstant $kCFStreamErrorHTTPParseFailure -1)
(defconstant $kCFStreamErrorHTTPRedirectionLoop -2)
(defconstant $kCFStreamErrorHTTPBadURL -3)

;type name? (def-mactype :CFStreamErrorHTTP (find-mactype ':CFStreamErrorHTTP))
;  Value is a CFHTTPMessage with 0 bytes data. 
; 
;  *  kCFStreamPropertyHTTPResponseHeader
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFStreamPropertyHTTPResponseHeader (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
;  Value is the CFURL from the final request; will only differ from the URL in the original request if an autoredirection has occurred. 
; 
;  *  kCFStreamPropertyHTTPFinalURL
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFStreamPropertyHTTPFinalURL (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; ************************************
; Set-able properties on HTTP streams 
; ************************************
;  HTTP proxy information is set the same way as SOCKS proxies (see CFSocketStream.h).
;    Call CFReadStreamSetProperty() passing an HTTP stream and the property kCFStreamPropertyHTTPProxy.  
;    The value should be a CFDictionary that includes at least one Host/Port pair from the keys below.  
;    The dictionary returned by SystemConfiguration.framework can also be passed directly as the value 
; 
;  *  kCFStreamPropertyHTTPProxy
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFStreamPropertyHTTPProxy (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; 
;  *  kCFStreamPropertyHTTPProxyHost
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFStreamPropertyHTTPProxyHost (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  matches kSCPropNetProxiesHTTPProxy; value should be a CFString
; 
;  *  kCFStreamPropertyHTTPProxyPort
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFStreamPropertyHTTPProxyPort (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  matches kSCPropNetProxiesHTTPPort; value should be a CFNumber 
; 
;  *  kCFStreamPropertyHTTPSProxyHost
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFStreamPropertyHTTPSProxyHost (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  matches kSCPropNetProxiesHTTPSProxy; value should be a CFString 
; 
;  *  kCFStreamPropertyHTTPSProxyPort
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFStreamPropertyHTTPSProxyPort (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  matches kSCPropNetProxiesHTTPSPort; value should be a CFNumber 
;  Value should be a CFBoolean 
; 
;  *  kCFStreamPropertyHTTPShouldAutoredirect
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFStreamPropertyHTTPShouldAutoredirect (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  Value should be a CFBoolean.  If this property is set to true, an HTTP stream will look for an appropriate extant persistent connection to use, and if it finds none, will try to create one.  
; 
;  *  kCFStreamPropertyHTTPAttemptPersistentConnection
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFStreamPropertyHTTPAttemptPersistentConnection (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  Value is a CFNumber; this property can only be retrieved, not set.  The number returned is the number of bytes from the body of the request that have been written to the underlying socket 
; 
;  *  kCFStreamPropertyHTTPRequestBytesWrittenCount
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kCFStreamPropertyHTTPRequestBytesWrittenCount (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; *******************
;  Creation routines 
; *******************
;  Creates a read stream for the response to the given request; when the stream is opened,
;   it will begin transmitting the request.  The bytes returned are the pure body bytes; the response header has been parsed off.
;   To retrieve the response header, ask for kCFStreamPropertyHTTPResponseHeader, above, any time after the first bytes arrive on 
;   the stream (or when stream end is reported, if there are no data bytes).
; 
; 
;  *  CFReadStreamCreateForHTTPRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFReadStreamCreateForHTTPRequest" 
   ((alloc (:pointer :__CFAllocator))
    (request (:pointer :__CFHTTPMessage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :__CFReadStream)
() )
;  Creates a read stream for the response to the given requestHeaders plus requestBody.  Use in preference to
;   CFReadStreamCreateForHTTPRequest() when the body of the request is larger than you wish to be resident in memory.  Note that 
;   because streams cannot be reset, read streams created this way cannot have autoredirection enabled.  If the Content-Length 
;   header is set in requestHeaders, it is assumed that the caller got the length right and that requestBody will report 
;   end-of-stream after precisely Content-Length bytes have been read from it.  If the Content-Length header is not set, the 
;   chunked transfer-encoding will be added to requestHeaders, and bytes read from requestBody will be transmitted chunked.
;   The body of requestHeaders is ignored.
; 
; 
;  *  CFReadStreamCreateForStreamedHTTPRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFReadStreamCreateForStreamedHTTPRequest" 
   ((alloc (:pointer :__CFAllocator))
    (requestHeaders (:pointer :__CFHTTPMessage))
    (requestBody (:pointer :__CFReadStream))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__CFReadStream)
() )
;  Deprecated - Use the properties kCFStreamPropertyHTTPShouldAutoredirect and kCFStreamPropertyHTTPProxy above instead 
; 
;  *  CFHTTPReadStreamSetRedirectsAutomatically()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPReadStreamSetRedirectsAutomatically" 
   ((httpStream (:pointer :__CFReadStream))
    (shouldAutoRedirect :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  CFHTTPReadStreamSetProxy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CFHTTPReadStreamSetProxy" 
   ((httpStream (:pointer :__CFReadStream))
    (proxyHost (:pointer :__CFString))
    (proxyPort :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )

; #if PRAGMA_ENUM_ALWAYSINT
#| ; #pragma enumsalwaysint reset
 |#

; #endif

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __CFHTTPSTREAM__ */


(provide-interface "CFHTTPStream")