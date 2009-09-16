(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WSTypes.h"
; at Sunday July 2,2006 7:23:41 pm.
; 
;      File:       WebServicesCore/WSTypes.h
;  
;      Contains:   WebServicesCore Method Invocation API
;  
;      Version:    WebServices-15~51
;  
;      Copyright:  © 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __WSTYPES__
; #define __WSTYPES__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; 
;     WSTypes
;  
; 
;     WebServicesCore error codes
;  

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


(defconstant $errWSInternalError -65793)        ;  An internal framework error 

(defconstant $errWSTransportError -65794)       ;  A network error occured 

(defconstant $errWSParseError -65795)           ;  The server response wasn't valid XML 
;  The invocation timed out 

(defconstant $errWSTimeoutError -65796)
; 
;  *  WSTypeID
;  *  
;  *  Discussion:
;  *    Internally, WebServicesCore uses the following enumeration when
;  *    serializing between CoreFoundation and XML types. Because CFTypes
;  *    are defined at runtime, it isn't always possible to produce a
;  *    static mapping to a particular CFTypeRef.  This enum and
;  *    associated API allows for static determination of the expected
;  *    serialization.
;  
(def-mactype :WSTypeID (find-mactype ':sint32))
; 
;    * No mapping is known for this type
;    

(defconstant $eWSUnknownType 0)
; 
;    * CFNullRef
;    

(defconstant $eWSNullType 1)
; 
;    * CFBooleanRef
;    

(defconstant $eWSBooleanType 2)
; 
;    * CFNumberRef for 8, 16, 32 bit integers
;    

(defconstant $eWSIntegerType 3)
; 
;    * CFNumberRef for long double real numbers
;    

(defconstant $eWSDoubleType 4)
; 
;    * CFStringRef
;    

(defconstant $eWSStringType 5)
; 
;    * CFDateRef
;    

(defconstant $eWSDateType 6)
; 
;    * CFDataRef
;    

(defconstant $eWSDataType 7)
; 
;    * CFArrayRef
;    

(defconstant $eWSArrayType 8)
; 
;    * CFDictionaryRef
;    

(defconstant $eWSDictionaryType 9)

;type name? (def-mactype :WSTypeID (find-mactype ':WSTypeID))

(def-mactype :WSClientContextRetainCallBackProcPtr (find-mactype ':pointer)); (void * info)

(def-mactype :WSClientContextReleaseCallBackProcPtr (find-mactype ':pointer)); (void * info)

(def-mactype :WSClientContextCopyDescriptionCallBackProcPtr (find-mactype ':pointer)); (void * info)
; 
;  *  WSClientContext
;  *  
;  *  Discussion:
;  *    Several calls in WebServicesCore take a callback with an optional
;  *    context pointer.  The context is copied and the info pointer
;  *    retained.  When the callback is made, the info pointer is passed
;  *    to the callback.
;  
(defrecord WSClientContext
                                                ; 
;    * set to zero (0)
;    
   (version :SInt32)
                                                ; 
;    * info pointer to be passed to the callback
;    
   (info :pointer)
                                                ; 
;    * callback made on the info pointer. This field may be NULL.
;    
   (retain :pointer)
                                                ; 
;    * callback made on the info pointer. This field may be NULL.
;    
   (release :pointer)
                                                ; 
;    * callback made on the info pointer. This field may be NULL.
;    
   (copyDescription :pointer)
)

;type name? (%define-record :WSClientContext (find-record-descriptor ':WSClientContext))
; 
;     Web Service protocol types.  These constant strings specify the type
;     of web service method invocation created.  These are passed to
;     WSMethodInvocationCreate.
; 
;     For information on these service types, see:
; 
;     XML-RPC:    <http://www.xml-rpc.com/spec/>
;     SOAP 1.1:   <http://www.w3.org/TR/SOAP/>
;     SOAP 1.2:   <http://www.w3.org/2002/ws/>
; 
(def-mactype :kWSXMLRPCProtocol (find-mactype ':CFStringRef))
(def-mactype :kWSSOAP1999Protocol (find-mactype ':CFStringRef))
(def-mactype :kWSSOAP2001Protocol (find-mactype ':CFStringRef))
; 
;  *  WSGetWSTypeIDFromCFType()
;  *  
;  *  Discussion:
;  *    Returns the WSTypeID associated with CFTypeRef.  There is not a
;  *    one to one mapping between CFTypeID and WSTypesID therefore an
;  *    actual instance of a CFType must be passed.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Parameters:
;  *    
;  *    ref:
;  *      a CFTypeRef object
;  *  
;  *  Result:
;  *    the WSTypeID used in serializing the object.  If no WSTypeID
;  *    matches, eWSUnknownType is returned.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_WSGetWSTypeIDFromCFType" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :WSTypeID
() )
; 
;  *  WSGetCFTypeIDFromWSTypeID()
;  *  
;  *  Discussion:
;  *    Returns the CFTypeID that is associated with a given WSTypeID. 
;  *    CFTypeIDs are only valid during a particular instance of a
;  *    process and should not be used as static values.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Parameters:
;  *    
;  *    typeID:
;  *      a WSTypeID constant
;  *  
;  *  Result:
;  *    a CFTypeID, or 0 if not found
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_WSGetCFTypeIDFromWSTypeID" 
   ((typeID :WSTypeID)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )

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

; #endif /* __WSTYPES__ */


(provide-interface "WSTypes")