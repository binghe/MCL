(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AEDataModel.h"
; at Sunday July 2,2006 7:24:24 pm.
; 
;      File:       AE/AEDataModel.h
;  
;      Contains:   AppleEvent Data Model Interfaces.
;  
;      Version:    AppleEvents-275~1
;  
;      Copyright:  © 1996-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AEDATAMODEL__
; #define __AEDATAMODEL__
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
;  Apple event descriptor types 

(defconstant $typeBoolean :|bool|)
(defconstant $typeChar :|TEXT|)
;  Preferred numeric Apple event descriptor types 

(defconstant $typeSInt16 :|shor|)
(defconstant $typeSInt32 :|long|)
(defconstant $typeUInt32 :|magn|)
(defconstant $typeSInt64 :|comp|)
(defconstant $typeIEEE32BitFloatingPoint :|sing|)
(defconstant $typeIEEE64BitFloatingPoint :|doub|)
(defconstant $type128BitFloatingPoint :|ldbl|)
(defconstant $typeDecimalStruct :|decm|)
;  Non-preferred Apple event descriptor types 

(defconstant $typeSMInt :|shor|)
(defconstant $typeShortInteger :|shor|)
(defconstant $typeInteger :|long|)
(defconstant $typeLongInteger :|long|)
(defconstant $typeMagnitude :|magn|)
(defconstant $typeComp :|comp|)
(defconstant $typeSMFloat :|sing|)
(defconstant $typeShortFloat :|sing|)
(defconstant $typeFloat :|doub|)
(defconstant $typeLongFloat :|doub|)
(defconstant $typeExtended :|exte|)
;  More Apple event descriptor types 

(defconstant $typeAEList :|list|)
(defconstant $typeAERecord :|reco|)
(defconstant $typeAppleEvent :|aevt|)
(defconstant $typeEventRecord :|evrc|)
(defconstant $typeTrue :|true|)
(defconstant $typeFalse :|fals|)
(defconstant $typeAlias :|alis|)
(defconstant $typeEnumerated :|enum|)
(defconstant $typeType :|type|)
(defconstant $typeAppParameters :|appa|)
(defconstant $typeProperty :|prop|)
(defconstant $typeFSS :|fss |)
(defconstant $typeFSRef :|fsrf|)
(defconstant $typeFileURL :|furl|)
(defconstant $typeKeyword :|keyw|)
(defconstant $typeSectionH :|sect|)
(defconstant $typeWildCard :|****|)
(defconstant $typeApplSignature :|sign|)
(defconstant $typeQDRectangle :|qdrt|)
(defconstant $typeFixed :|fixd|)
(defconstant $typeProcessSerialNumber :|psn |)
(defconstant $typeApplicationURL :|aprl|)
(defconstant $typeNull :|null|)                 ;  null or nonexistent data 

;  New addressing modes for MacOS X 

(defconstant $typeKernelProcessID :|kpid|)
(defconstant $typeMachPort :|port|)
;  Targeting applications by bundle ID is only available in Mac OS X 10.3 or later. 

(defconstant $typeApplicationBundleID :|bund|)
;  Keywords for Apple event attributes 

(defconstant $keyTransactionIDAttr :|tran|)
(defconstant $keyReturnIDAttr :|rtid|)
(defconstant $keyEventClassAttr :|evcl|)
(defconstant $keyEventIDAttr :|evid|)
(defconstant $keyAddressAttr :|addr|)
(defconstant $keyOptionalKeywordAttr :|optk|)
(defconstant $keyTimeoutAttr :|timo|)
(defconstant $keyInteractLevelAttr :|inte|)     ;  this attribute is read only - will be set in AESend 

(defconstant $keyEventSourceAttr :|esrc|)       ;  this attribute is read only - returned as typeShortInteger 

(defconstant $keyMissedKeywordAttr :|miss|)     ;  this attribute is read only 

(defconstant $keyOriginalAddressAttr :|from|)   ;  new in 1.0.1 

(defconstant $keyAcceptTimeoutAttr :|actm|)     ;  new for Mac OS X 

(defconstant $keyReplyRequestedAttr :|repq|)    ;  Was a reply requested for this event - returned as typeBoolean 

;  These bits are specified in the keyXMLDebuggingAttr (an SInt32) 

(defconstant $kAEDebugPOSTHeader 1)             ;  headers of the HTTP post we sent - typeChar 

(defconstant $kAEDebugReplyHeader 2)            ;  headers returned by the server 

(defconstant $kAEDebugXMLRequest 4)             ;  the XML request we sent 

(defconstant $kAEDebugXMLResponse 8)            ;  the XML reply from the server 
;  everything! 

(defconstant $kAEDebugXMLDebugAll #xFFFFFFFF)
;  These values can be added as a parameter to the direct object of a
;    SOAP message to specify the serialization schema.  If not
;    specified, kSOAP1999Schema is the default. These should be added as
;    typeType. 

(defconstant $kSOAP1999Schema :|ss99|)
(defconstant $kSOAP2001Schema :|ss01|)
;  outgoing event attributes 

(defconstant $keyUserNameAttr :|unam|)
(defconstant $keyUserPasswordAttr :|pass|)      ;  not sent with the event 

(defconstant $keyDisableAuthenticationAttr :|auth|);  When present and with a non zero value (that is, false, or integer 0), 
;  AESend will not authenticate the user.  If not present, or with a non-zero
;  value, AESend will prompt for authentication information from the user if the interaction level allows. 

(defconstant $keyXMLDebuggingAttr :|xdbg|)      ;  a bitfield of specifying which XML debugging data is to be returned with the event 
;  Event class / id 

(defconstant $kAERPCClass :|rpc |)              ;  for outgoing XML events 

(defconstant $kAEXMLRPCScheme :|RPC2|)          ;  event ID: event should be sent to an XMLRPC endpoint 

(defconstant $kAESOAPScheme :|SOAP|)            ;  event ID: event should be sent to a SOAP endpoint 

(defconstant $kAESharedScriptHandler :|wscp|)   ;  event ID: handler for incoming XML requests 
;  these parameters exist as part of the direct object of the event for both incoming and outgoing requests 

(defconstant $keyRPCMethodName :|meth|)         ;  name of the method to call 

(defconstant $keyRPCMethodParam :|parm|)        ;  the list (or structure) of parameters 

(defconstant $keyRPCMethodParamOrder :|/ord|)   ;  if a structure, the order of parameters (a list) 
;  when keyXMLDebugginAttr so specifies, these additional parameters will be part of the reply. 

(defconstant $keyAEPOSTHeaderData :|phed|)      ;  what we sent to the server 

(defconstant $keyAEReplyHeaderData :|rhed|)     ;  what the server sent to us 

(defconstant $keyAEXMLRequestData :|xreq|)      ;  what we sent to the server 

(defconstant $keyAEXMLReplyData :|xrep|)        ;  what the server sent to us 
;  additional parameters that can be specified in the direct object of the event 

(defconstant $keyAdditionalHTTPHeaders :|ahed|) ;  list of additional HTTP headers (a list of 2 element lists) 

(defconstant $keySOAPAction :|sact|)            ;  the SOAPAction header (required for SOAP messages) 

(defconstant $keySOAPMethodNameSpace :|mspc|)   ;  Optional namespace (defaults to m:) 

(defconstant $keySOAPMethodNameSpaceURI :|mspu|);  Required namespace URI 

(defconstant $keySOAPSchemaVersion :|ssch|)     ;  Optional XML Schema version, defaults to kSOAP1999Schama 

;  
;    When serializing AERecords as SOAP structures, it is possible
;    to specify the namespace and type of the structure.  To do this,
;    add a keySOAPStructureMetaData record to the top level of the
;    record to be serialized.  If present, this will be used to specify
;    the structure namespace.  This will produce a structure elment that
;    looks like:
; 
;     <myStruct
;         xmlns:myNamespace="http://myUri.org/xsd",
;         xsi:type="myNamespace:MyStructType">
;         ...
;     </myStruct>
; 
; 

(defconstant $keySOAPStructureMetaData :|/smd|)
(defconstant $keySOAPSMDNamespace :|ssns|)      ;  "myNamespace"

(defconstant $keySOAPSMDNamespaceURI :|ssnu|)   ;  "http://myUri.org/xsd"

(defconstant $keySOAPSMDType :|sstp|)           ;  "MyStructType"

;  
;  * Web Services Proxy support.  Available only on Mac OS X 10.2 or later.
;  * These constants should be added as attributes on the event that is
;  * being sent (not part of the direct object.)
;  
;  Automatically configure the proxy based on System Configuration 

(defconstant $kAEUseHTTPProxyAttr :|xupr|)      ;  a typeBoolean.  Defaults to true.
;  manually specify the proxy host and port. 

(defconstant $kAEHTTPProxyPortAttr :|xhtp|)     ;  a typeSInt32

(defconstant $kAEHTTPProxyHostAttr :|xhth|)     ;  a typeChar

; 
;  * Web Services SOCKS support.  kAEUseSocksAttr is a boolean that
;  * specifies whether to automatically configure SOCKS proxies by
;  * querying System Configuration.
;  

(defconstant $kAESocks4Protocol 4)
(defconstant $kAESocks5Protocol 5)

(defconstant $kAEUseSocksAttr :|xscs|)          ;  a typeBoolean.  Defaults to true.
;  This attribute specifies a specific SOCKS protocol to be used 

(defconstant $kAESocksProxyAttr :|xsok|)        ;  a typeSInt32
;  if version >= 4 

(defconstant $kAESocksHostAttr :|xshs|)         ;  a typeChar

(defconstant $kAESocksPortAttr :|xshp|)         ;  a typeSInt32

(defconstant $kAESocksUserAttr :|xshu|)         ;  a typeChar
;  if version >= 5 

(defconstant $kAESocksPasswordAttr :|xshw|)     ;  a typeChar

;   Constants used for specifying the factoring of AEDescLists. 

(defconstant $kAEDescListFactorNone 0)
(defconstant $kAEDescListFactorType 4)
(defconstant $kAEDescListFactorTypeAndSize 8)
;  Constants used creating an AppleEvent 
;  Constant for the returnID param of AECreateAppleEvent 

(defconstant $kAutoGenerateReturnID -1)         ;  AECreateAppleEvent will generate a session-unique ID 
;  Constant for transaction ID’s 

(defconstant $kAnyTransactionID 0)              ;  no transaction is in use 

;  Apple event manager data types 

(def-mactype :DescType (find-mactype ':FourCharCode))

(def-mactype :AEKeyword (find-mactype ':FourCharCode))

; #if OPAQUE_TOOLBOX_STRUCTS

(def-mactype :AEDataStorageType (find-mactype '(:pointer :OpaqueAEDataStorageType)))
#| 
; #else

(def-mactype :AEDataStorageType (find-mactype ':pointer))
 |#

; #endif  /* OPAQUE_TOOLBOX_STRUCTS */


(def-mactype :AEDataStorage (find-mactype '(:handle :OpaqueAEDataStorageType)))
(defrecord AEDesc
   (descriptorType :FourCharCode)
   (dataHandle (:Handle :OpaqueAEDataStorageType))
)

;type name? (%define-record :AEDesc (find-record-descriptor ':AEDesc))

(def-mactype :AEDescPtr (find-mactype '(:pointer :AEDesc)))
(defrecord AEKeyDesc
   (descKey :FourCharCode)
   (descContent :AEDesc)
)

;type name? (%define-record :AEKeyDesc (find-record-descriptor ':AEKeyDesc))
;  a list of AEDesc's is a special kind of AEDesc 

(%define-record :AEDescList (find-record-descriptor ':AEDesc))
;  AERecord is a list of keyworded AEDesc's 

(%define-record :AERecord (find-record-descriptor ':AEDesc))
;  an AEDesc which contains address data 

(%define-record :AEAddressDesc (find-record-descriptor ':AEDesc))
;  an AERecord that contains an AppleEvent, and related data types 

(%define-record :AppleEvent (find-record-descriptor ':AEDesc))

(def-mactype :AppleEventPtr (find-mactype '(:pointer :AEDesc)))

(def-mactype :AEReturnID (find-mactype ':SInt16))

(def-mactype :AETransactionID (find-mactype ':SInt32))

(def-mactype :AEEventClass (find-mactype ':FourCharCode))

(def-mactype :AEEventID (find-mactype ':FourCharCode))

(def-mactype :AEArrayType (find-mactype ':SInt8))

(defconstant $kAEDataArray 0)
(defconstant $kAEPackedArray 1)
(defconstant $kAEDescArray 3)
(defconstant $kAEKeyDescArray 4)

(defconstant $kAEHandleArray 2)
(defrecord AEArrayData
   (:variant
   (
   (kAEDataArray (:array :SInt16 1))
   )
   (
   (kAEPackedArray (:array :character 1))
   )
   (
   (kAEHandleArray (:array :Handle 1))
   )
   (
   (kAEDescArray (:array :AEDesc 1))
   )
   (
   (kAEKeyDescArray (:array :AEKeyDesc 1))
   )
   )
)

;type name? (%define-record :AEArrayData (find-record-descriptor ':AEArrayData))

(def-mactype :AEArrayDataPointer (find-mactype '(:pointer :AEArrayData)))
; *************************************************************************
;   These constants are used by AEMach and AEInteraction APIs.  They are not
;   strictly part of the data format, but are declared here due to layering.
; *************************************************************************

(def-mactype :AESendPriority (find-mactype ':SInt16))

(defconstant $kAENormalPriority 0)              ;  post message at the end of the event queue 

(defconstant $kAEHighPriority 1)                ;  post message at the front of the event queue (same as nAttnMsg) 


(def-mactype :AESendMode (find-mactype ':SInt32))

(defconstant $kAENoReply 1)                     ;  sender doesn't want a reply to event 

(defconstant $kAEQueueReply 2)                  ;  sender wants a reply but won't wait 

(defconstant $kAEWaitReply 3)                   ;  sender wants a reply and will wait 

(defconstant $kAEDontReconnect #x80)            ;  don't reconnect if there is a sessClosedErr from PPCToolbox 

(defconstant $kAEWantReceipt #x200)             ;  (nReturnReceipt) sender wants a receipt of message 

(defconstant $kAENeverInteract 16)              ;  server should not interact with user 

(defconstant $kAECanInteract 32)                ;  server may try to interact with user 

(defconstant $kAEAlwaysInteract 48)             ;  server should always interact with user where appropriate 

(defconstant $kAECanSwitchLayer 64)             ;  interaction may switch layer 

(defconstant $kAEDontRecord #x1000)             ;  don't record this event - available only in vers 1.0.1 and greater 

(defconstant $kAEDontExecute #x2000)            ;  don't send the event for recording - available only in vers 1.0.1 and greater 

(defconstant $kAEProcessNonReplyEvents #x8000)  ;  allow processing of non-reply events while awaiting synchronous AppleEvent reply 

;  Constants for timeout durations 

(defconstant $kAEDefaultTimeout -1)             ;  timeout value determined by AEM 
;  wait until reply comes back, however long it takes 

(defconstant $kNoTimeOut -2)
; *************************************************************************
;   These calls are used to set up and modify the coercion dispatch table.
; *************************************************************************

(def-mactype :AECoerceDescProcPtr (find-mactype ':pointer)); (const AEDesc * fromDesc , DescType toType , long handlerRefcon , AEDesc * toDesc)

(def-mactype :AECoercePtrProcPtr (find-mactype ':pointer)); (DescType typeCode , const void * dataPtr , Size dataSize , DescType toType , long handlerRefcon , AEDesc * result)

(def-mactype :AECoerceDescUPP (find-mactype '(:pointer :OpaqueAECoerceDescProcPtr)))

(def-mactype :AECoercePtrUPP (find-mactype '(:pointer :OpaqueAECoercePtrProcPtr)))
; 
;  *  NewAECoerceDescUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewAECoerceDescUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueAECoerceDescProcPtr)
() )
; 
;  *  NewAECoercePtrUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewAECoercePtrUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueAECoercePtrProcPtr)
() )
; 
;  *  DisposeAECoerceDescUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeAECoerceDescUPP" 
   ((userUPP (:pointer :OpaqueAECoerceDescProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeAECoercePtrUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeAECoercePtrUPP" 
   ((userUPP (:pointer :OpaqueAECoercePtrProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeAECoerceDescUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeAECoerceDescUPP" 
   ((fromDesc (:pointer :AEDesc))
    (toType :FourCharCode)
    (handlerRefcon :signed-long)
    (toDesc (:pointer :AEDesc))
    (userUPP (:pointer :OpaqueAECoerceDescProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeAECoercePtrUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeAECoercePtrUPP" 
   ((typeCode :FourCharCode)
    (dataPtr :pointer)
    (dataSize :signed-long)
    (toType :FourCharCode)
    (handlerRefcon :signed-long)
    (result (:pointer :AEDesc))
    (userUPP (:pointer :OpaqueAECoercePtrProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  a AECoercionHandlerUPP is by default a AECoerceDescUPP.  If you are registering a 
;     Ptr based coercion handler you will have to add a cast to AECoerceDescUPP from 
;     your AECoercePtrUPP type.  A future release of the interfaces will fix this by
;     introducing seperate Desc and Ptr coercion handler installation/remove/query routines. 

(def-mactype :AECoercionHandlerUPP (find-mactype ':AECoerceDescUPP))
; 
;  *  AEInstallCoercionHandler()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEInstallCoercionHandler" 
   ((fromType :FourCharCode)
    (toType :FourCharCode)
    (handler (:pointer :OpaqueAECoerceDescProcPtr))
    (handlerRefcon :signed-long)
    (fromTypeIsDesc :Boolean)
    (isSysHandler :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AERemoveCoercionHandler()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AERemoveCoercionHandler" 
   ((fromType :FourCharCode)
    (toType :FourCharCode)
    (handler (:pointer :OpaqueAECoerceDescProcPtr))
    (isSysHandler :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEGetCoercionHandler()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEGetCoercionHandler" 
   ((fromType :FourCharCode)
    (toType :FourCharCode)
    (handler (:pointer :AECOERCIONHANDLERUPP))
    (handlerRefcon (:pointer :long))
    (fromTypeIsDesc (:pointer :Boolean))
    (isSysHandler :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *************************************************************************
;   The following calls provide for a coercion interface.
; *************************************************************************
; 
;  *  AECoercePtr()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AECoercePtr" 
   ((typeCode :FourCharCode)
    (dataPtr :pointer)
    (dataSize :signed-long)
    (toType :FourCharCode)
    (result (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AECoerceDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AECoerceDesc" 
   ((theAEDesc (:pointer :AEDesc))
    (toType :FourCharCode)
    (result (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *************************************************************************
;  The following calls apply to any AEDesc. Every 'result' descriptor is
;  created for you, so you will be responsible for memory management
;  (including disposing) of the descriptors so created.  
; *************************************************************************
;  because AEDescs are opaque under Carbon, this AEInitializeDesc provides a
;    'clean' way of initializating them to be empty. 
; 
;  *  AEInitializeDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEInitializeDesc" 
   ((desc (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; #ifdef __cplusplus
#| #|
    inline void AEInitializeDescInline(AEDesc* d) { d->descriptorType = typeNull; d->dataHandle = NULL; };
|#
 |#

; #else
; #define AEInitializeDescInline(__d) do { AEDesc* d = __d; d->descriptorType = typeNull; d->dataHandle = NULL; } while (0)

; #endif

; 
;  *  AECreateDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AECreateDesc" 
   ((typeCode :FourCharCode)
    (dataPtr :pointer)
    (dataSize :signed-long)
    (result (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEDisposeDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEDisposeDesc" 
   ((theAEDesc (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEDuplicateDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEDuplicateDesc" 
   ((theAEDesc (:pointer :AEDesc))
    (result (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  * Create an AEDesc with memory "borrowed" from the application. The
;  * data passed in *must* be immutable and not freed until the Dispose
;  * callback is made.
;  * The dispose callback may be made at any time, including during the
;  * creation of the descriptor.
;  * If possible, the descriptor will be copied to the address space of
;  * any recipient process using virtual memory APIs and avoid an
;  * actual memory copy.
;  

(def-mactype :AEDisposeExternalProcPtr (find-mactype ':pointer)); (const void * dataPtr , Size dataLength , long refcon)

(def-mactype :AEDisposeExternalUPP (find-mactype '(:pointer :OpaqueAEDisposeExternalProcPtr)))
; 
;  *  AECreateDescFromExternalPtr()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AECreateDescFromExternalPtr" 
   ((descriptorType :OSType)
    (dataPtr :pointer)
    (dataLength :signed-long)
    (disposeCallback (:pointer :OpaqueAEDisposeExternalProcPtr))
    (disposeRefcon :signed-long)
    (theDesc (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; *************************************************************************
;   The following calls apply to AEDescList. Since AEDescList is a subtype of
;   AEDesc, the calls in the previous section can also be used for AEDescList.
;   All list and array indices are 1-based. If the data was greater than
;   maximumSize in the routines below, then actualSize will be greater than
;   maximumSize, but only maximumSize bytes will actually be retrieved.
; *************************************************************************
; 
;  *  AECreateList()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AECreateList" 
   ((factoringPtr :pointer)
    (factoredSize :signed-long)
    (isRecord :Boolean)
    (resultList (:pointer :AEDescList))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AECountItems()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AECountItems" 
   ((theAEDescList (:pointer :AEDescList))
    (theCount (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEPutPtr()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEPutPtr" 
   ((theAEDescList (:pointer :AEDescList))
    (index :signed-long)
    (typeCode :FourCharCode)
    (dataPtr :pointer)
    (dataSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEPutDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEPutDesc" 
   ((theAEDescList (:pointer :AEDescList))
    (index :signed-long)
    (theAEDesc (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEGetNthPtr()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEGetNthPtr" 
   ((theAEDescList (:pointer :AEDescList))
    (index :signed-long)
    (desiredType :FourCharCode)
    (theAEKeyword (:pointer :AEKEYWORD))        ;  can be NULL 
    (typeCode (:pointer :DESCTYPE))             ;  can be NULL 
    (dataPtr :pointer)
    (maximumSize :signed-long)
    (actualSize (:pointer :SIZE))               ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEGetNthDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEGetNthDesc" 
   ((theAEDescList (:pointer :AEDescList))
    (index :signed-long)
    (desiredType :FourCharCode)
    (theAEKeyword (:pointer :AEKEYWORD))        ;  can be NULL 
    (result (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AESizeOfNthItem()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AESizeOfNthItem" 
   ((theAEDescList (:pointer :AEDescList))
    (index :signed-long)
    (typeCode (:pointer :DESCTYPE))             ;  can be NULL 
    (dataSize (:pointer :SIZE))                 ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEGetArray()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEGetArray" 
   ((theAEDescList (:pointer :AEDescList))
    (arrayType :SInt8)
    (arrayPtr (:pointer :AEArrayData))
    (maximumSize :signed-long)
    (itemType (:pointer :DESCTYPE))
    (itemSize (:pointer :SIZE))
    (itemCount (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEPutArray()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEPutArray" 
   ((theAEDescList (:pointer :AEDescList))
    (arrayType :SInt8)
    (arrayPtr (:pointer :AEArrayData))
    (itemType :FourCharCode)
    (itemSize :signed-long)
    (itemCount :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEDeleteItem()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEDeleteItem" 
   ((theAEDescList (:pointer :AEDescList))
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *************************************************************************
;  The following calls apply to AERecord. Since AERecord is a subtype of
;  AEDescList, the calls in the previous sections can also be used for
;  AERecord an AERecord can be created by using AECreateList with isRecord
;  set to true. 
; *************************************************************************
; ************************************************************************
;  AERecords can have an abitrary descriptorType.  This allows you to
;  check if desc is truly an AERecord
; ***********************************************************************
; 
;  *  AECheckIsRecord()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AECheckIsRecord" 
   ((theDesc (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;   Note: The following #defines map “key” calls on AERecords into “param” calls on 
;   AppleEvents.  Although no errors are currently returned if AERecords are 
;   passed to “param” calls and AppleEvents to “key” calls, the behavior of 
;   this type of API-mixing is not explicitly documented in Inside Macintosh.  
;   It just happens that the “key” calls have the same functionality as their 
;   “param” counterparts.  Since none of the “key” calls are currently available 
;   in the PowerPC IntefaceLib, the #defines exploit the fact that “key” and 
;   “param” routines can be used interchangeably, and makes sure that every 
;   invocation of a “key” API becomes an invocation of a “param” API.
; 
; #define AEPutKeyPtr(theAERecord, theAEKeyword, typeCode, dataPtr, dataSize)     AEPutParamPtr((theAERecord), (theAEKeyword), (typeCode), (dataPtr), (dataSize))
; #define AEPutKeyDesc(theAERecord, theAEKeyword, theAEDesc)     AEPutParamDesc((theAERecord), (theAEKeyword), (theAEDesc))
; #define AEGetKeyPtr(theAERecord, theAEKeyword, desiredType, typeCode, dataPtr, maxSize, actualSize)     AEGetParamPtr((theAERecord), (theAEKeyword), (desiredType), (typeCode), (dataPtr), (maxSize), (actualSize))
; #define AEGetKeyDesc(theAERecord, theAEKeyword, desiredType, result)     AEGetParamDesc((theAERecord), (theAEKeyword), (desiredType), (result))
; #define AESizeOfKeyDesc(theAERecord, theAEKeyword, typeCode, dataSize)     AESizeOfParam((theAERecord), (theAEKeyword), (typeCode), (dataSize))
; #define AEDeleteKeyDesc(theAERecord, theAEKeyword)     AEDeleteParam((theAERecord), (theAEKeyword))
; *************************************************************************
;   The following calls create and manipulate the AppleEvent data type.
; *************************************************************************
; 
;  *  AECreateAppleEvent()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AECreateAppleEvent" 
   ((theAEEventClass :FourCharCode)
    (theAEEventID :FourCharCode)
    (target (:pointer :AEADDRESSDESC))          ;  can be NULL 
    (returnID :SInt16)
    (transactionID :SInt32)
    (result (:pointer :AppleEvent))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *************************************************************************
;   The following calls are used to pack and unpack parameters from records
;   of type AppleEvent. Since AppleEvent is a subtype of AERecord, the calls
;   in the previous sections can also be used for variables of type
;   AppleEvent. The next six calls are in fact identical to the six calls
;   for AERecord.
; *************************************************************************
; 
;  *  AEPutParamPtr()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEPutParamPtr" 
   ((theAppleEvent (:pointer :AppleEvent))
    (theAEKeyword :FourCharCode)
    (typeCode :FourCharCode)
    (dataPtr :pointer)
    (dataSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEPutParamDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEPutParamDesc" 
   ((theAppleEvent (:pointer :AppleEvent))
    (theAEKeyword :FourCharCode)
    (theAEDesc (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEGetParamPtr()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEGetParamPtr" 
   ((theAppleEvent (:pointer :AppleEvent))
    (theAEKeyword :FourCharCode)
    (desiredType :FourCharCode)
    (actualType (:pointer :DESCTYPE))           ;  can be NULL 
    (dataPtr :pointer)
    (maximumSize :signed-long)
    (actualSize (:pointer :SIZE))               ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEGetParamDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEGetParamDesc" 
   ((theAppleEvent (:pointer :AppleEvent))
    (theAEKeyword :FourCharCode)
    (desiredType :FourCharCode)
    (result (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AESizeOfParam()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AESizeOfParam" 
   ((theAppleEvent (:pointer :AppleEvent))
    (theAEKeyword :FourCharCode)
    (typeCode (:pointer :DESCTYPE))             ;  can be NULL 
    (dataSize (:pointer :SIZE))                 ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEDeleteParam()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEDeleteParam" 
   ((theAppleEvent (:pointer :AppleEvent))
    (theAEKeyword :FourCharCode)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *************************************************************************
;  The following calls also apply to type AppleEvent. Message attributes are
;  far more restricted, and can only be accessed through the following 5
;  calls. The various list and record routines cannot be used to access the
;  attributes of an event. 
; *************************************************************************
; 
;  *  AEGetAttributePtr()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEGetAttributePtr" 
   ((theAppleEvent (:pointer :AppleEvent))
    (theAEKeyword :FourCharCode)
    (desiredType :FourCharCode)
    (typeCode (:pointer :DESCTYPE))             ;  can be NULL 
    (dataPtr :pointer)
    (maximumSize :signed-long)
    (actualSize (:pointer :SIZE))               ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEGetAttributeDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEGetAttributeDesc" 
   ((theAppleEvent (:pointer :AppleEvent))
    (theAEKeyword :FourCharCode)
    (desiredType :FourCharCode)
    (result (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AESizeOfAttribute()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AESizeOfAttribute" 
   ((theAppleEvent (:pointer :AppleEvent))
    (theAEKeyword :FourCharCode)
    (typeCode (:pointer :DESCTYPE))             ;  can be NULL 
    (dataSize (:pointer :SIZE))                 ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEPutAttributePtr()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEPutAttributePtr" 
   ((theAppleEvent (:pointer :AppleEvent))
    (theAEKeyword :FourCharCode)
    (typeCode :FourCharCode)
    (dataPtr :pointer)
    (dataSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEPutAttributeDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEPutAttributeDesc" 
   ((theAppleEvent (:pointer :AppleEvent))
    (theAEKeyword :FourCharCode)
    (theAEDesc (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *************************************************************************
;  AppleEvent Serialization Support
; 
;     AESizeOfFlattenedDesc, AEFlattenDesc, AEUnflattenDesc
;     
;     These calls will work for all AppleEvent data types and between different
;     versions of the OS (including between Mac OS 9 and X)
;     
;     Basic types, AEDesc, AEList and AERecord are OK, but AppleEvent records
;     themselves may not be reliably flattened for storage.
; *************************************************************************
; 
;    AEFlattenDesc
;    Returns the amount of buffer space needed to flatten the
;    AEDesc. Call this before AEFlattenDesc to make sure your
;    buffer has enough room for the operation.
; 
; 
;  *  AESizeOfFlattenedDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AESizeOfFlattenedDesc" 
   ((theAEDesc (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;    AEFlattenDesc
;    Fills a buffer with a flattened representation of the
;    AEDesc and returns the amount of buffer used in actualSize.
;    If bufferSize was too small it returns errAEBufferTooSmall
;    (-1741) and does not fill in any of the buffer. The resulting
;    buffer is only useful with an AEUnflattenDesc call.
;    
;    Note: if you pass a NULL buffer pointer it returns noErr but
;    fills in the actualSize field anyway.
; 
; 
;  *  AEFlattenDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEFlattenDesc" 
   ((theAEDesc (:pointer :AEDesc))
    (buffer :pointer)
    (bufferSize :signed-long)
    (actualSize (:pointer :SIZE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    AEUnflattenDesc
;    Allocates an AEDesc (given a Null Desc) given a flattened
;    data buffer. It assumes it was given a good buffer filled
;    in by AEFlattenDesc. It returns paramErr if it discovers
;    something fishy about the buffer.
; 
; 
;  *  AEUnflattenDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEUnflattenDesc" 
   ((buffer :pointer)
    (result (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; *************************************************************************
;  The following calls are necessary to deal with opaque data in AEDescs, because the
;  traditional way of dealing with a basic AEDesc has been to dereference the dataHandle
;  directly.  This is not supported under Carbon.
; *************************************************************************
; 
;         AEGetDescData no longer supports automatic coercion. If you'd like to
;         coerce the descriptor use AECoerceDesc.
;     
; 
;  *  AEGetDescData()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_AEGetDescData" 
   ((theAEDesc (:pointer :AEDesc))
    (dataPtr :pointer)
    (maximumSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEGetDescDataSize()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_AEGetDescDataSize" 
   ((theAEDesc (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  AEReplaceDescData()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_AEReplaceDescData" 
   ((typeCode :FourCharCode)
    (dataPtr :pointer)
    (dataSize :signed-long)
    (theAEDesc (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  * Retrieve a range of bytes from an AEDesc.  This obviates the need
;  * to retrieve the entire data from the event using AEGetDescData.
;  * This is only valid for data type AEDescs.  If the requested length
;  * and offset are such that they do not fit entirely with the data of the
;  * desc, errAEBufferTooSmall is returned.
;  
; 
;  *  AEGetDescDataRange()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEGetDescDataRange" 
   ((dataDesc (:pointer :AEDesc))
    (buffer :pointer)
    (offset :signed-long)
    (length :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; *************************************************************************
;   A AEEventHandler is installed to process an AppleEvent 
; *************************************************************************

(def-mactype :AEEventHandlerProcPtr (find-mactype ':pointer)); (const AppleEvent * theAppleEvent , AppleEvent * reply , long handlerRefcon)

(def-mactype :AEEventHandlerUPP (find-mactype '(:pointer :OpaqueAEEventHandlerProcPtr)))
; 
;  *  NewAEDisposeExternalUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewAEDisposeExternalUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueAEDisposeExternalProcPtr)
() )
; 
;  *  NewAEEventHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewAEEventHandlerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueAEEventHandlerProcPtr)
() )
; 
;  *  DisposeAEDisposeExternalUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeAEDisposeExternalUPP" 
   ((userUPP (:pointer :OpaqueAEDisposeExternalProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  DisposeAEEventHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeAEEventHandlerUPP" 
   ((userUPP (:pointer :OpaqueAEEventHandlerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeAEDisposeExternalUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeAEDisposeExternalUPP" 
   ((dataPtr :pointer)
    (dataLength :signed-long)
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueAEDisposeExternalProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  InvokeAEEventHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeAEEventHandlerUPP" 
   ((theAppleEvent (:pointer :AppleEvent))
    (reply (:pointer :AppleEvent))
    (handlerRefcon :signed-long)
    (userUPP (:pointer :OpaqueAEEventHandlerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __AEDATAMODEL__ */


(provide-interface "AEDataModel")