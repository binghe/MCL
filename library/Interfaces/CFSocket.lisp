(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFSocket.h"
; at Sunday July 2,2006 7:22:52 pm.
; 	CFSocket.h
; 	Copyright (c) 1999-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFSOCKET__)
(defconstant $__COREFOUNDATION_CFSOCKET__ 1)
; #define __COREFOUNDATION_CFSOCKET__ 1

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFData")

(require-interface "CoreFoundation/CFString")

(require-interface "CoreFoundation/CFRunLoop")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
;  __cplusplus 

; #if defined(__WIN32__)
#| 
(require-interface "winsock")

(def-mactype :CFSocketNativeHandle (find-mactype ':SOCKET))
 |#

; #else

(def-mactype :CFSocketNativeHandle (find-mactype ':signed-long))

; #endif


(def-mactype :CFSocketRef (find-mactype '(:pointer :__CFSocket)))
;  A CFSocket contains a native socket within a structure that can 
; be used to read from the socket in the background and make the data
; thus read available using a runloop source.  The callback used for
; this may be of three types, as specified by the callBackTypes
; argument when creating the CFSocket.
; 
; If kCFSocketReadCallBack is used, then data will not be
; automatically read, but the callback will be called when data
; is available to be read, or a new child socket is waiting to be
; accepted.
;     
; If kCFSocketAcceptCallBack is used, then new child sockets will be
; accepted and passed to the callback, with the data argument being
; a pointer to a CFSocketNativeHandle.  This is usable only with
; connection rendezvous sockets.
; 
; If kCFSocketDataCallBack is used, then data will be read in chunks
; in the background and passed to the callback, with the data argument
; being a CFDataRef.
; 
; These three types are mutually exclusive, but any one of them may
; have kCFSocketConnectCallBack added to it, if the socket will be
; used to connect in the background.  Connect in the background occurs
; if CFSocketConnectToAddress is called with a negative timeout
; value, in which case the call returns immediately, and a
; kCFSocketConnectCallBack is generated when the connect finishes.
; In this case the data argument is either NULL, or a pointer to
; an SInt32 error code if the connect failed.  kCFSocketConnectCallBack
; will never be sent more than once for a given socket.
; 
; The callback types may also have kCFSocketWriteCallBack added to
; them, if large amounts of data are to be sent rapidly over the 
; socket and notification is desired when there is space in the
; kernel buffers so that the socket is writable again.  
; 
; With a connection-oriented socket, if the connection is broken from the
; other end, then one final kCFSocketReadCallBack or kCFSocketDataCallBack 
; will occur.  In the case of kCFSocketReadCallBack, the underlying socket 
; will have 0 bytes available to read.  In the case of kCFSocketDataCallBack,
; the data argument will be a CFDataRef of length 0.
; 
; There are socket flags that may be set to control whether callbacks of 
; a given type are automatically reenabled after they are triggered, and 
; whether the underlying native socket will be closed when the CFSocket
; is invalidated.  By default read, accept, and data callbacks are 
; automatically reenabled; write callbacks are not, and connect callbacks
; may not be, since they are sent once only.  Be careful about automatically
; reenabling read and write callbacks, since this implies that the 
; callbacks will be sent repeatedly if the socket remains readable or
; writable respectively.  Be sure to set these flags only for callbacks
; that your CFSocket actually possesses; the result of setting them for
; other callback types is undefined.
; 
; Individual callbacks may also be enabled and disabled manually, whether 
; they are automatically reenabled or not.  If they are not automatically 
; reenabled, then they will need to be manually reenabled when the callback 
; is ready to be received again (and not sooner).  Even if they are 
; automatically reenabled, there may be occasions when it will be useful
; to be able to manually disable them temporarily and then reenable them.
; Be sure to enable and disable only callbacks that your CFSocket actually
; possesses; the result of enabling and disabling other callback types is
; undefined.
; 
; By default the underlying native socket will be closed when the CFSocket 
; is invalidated, but it will not be if kCFSocketCloseOnInvalidate is 
; turned off.  This can be useful in order to destroy a CFSocket but 
; continue to use the underlying native socket.  The CFSocket must 
; still be invalidated when it will no longer be used.  Do not in 
; either case close the underlying native socket without invalidating 
; the CFSocket.
; 
; Addresses are stored as CFDatas containing a struct sockaddr
; appropriate for the protocol family; make sure that all fields are
; filled in properly when passing in an address.  
; 
; 

(defconstant $kCFSocketSuccess 0)
(defconstant $kCFSocketError -1)
(defconstant $kCFSocketTimeout -2)
(def-mactype :CFSocketError (find-mactype ':SINT32))
(defrecord CFSocketSignature
   (protocolFamily :SInt32)
   (socketType :SInt32)
   (protocol :SInt32)
   (address (:pointer :__CFData))
)

(defconstant $kCFSocketNoCallBack 0)
(defconstant $kCFSocketReadCallBack 1)
(defconstant $kCFSocketAcceptCallBack 2)
(defconstant $kCFSocketDataCallBack 3)
; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

(defconstant $kCFSocketConnectCallBack 4)
; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

; #endif


(defconstant $kCFSocketWriteCallBack 8)
; #endif


(def-mactype :CFSocketCallBackType (find-mactype ':SINT32))

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  Socket flags 

(defconstant $kCFSocketAutomaticallyReenableReadCallBack 1)
(defconstant $kCFSocketAutomaticallyReenableAcceptCallBack 2)
(defconstant $kCFSocketAutomaticallyReenableDataCallBack 3)
(defconstant $kCFSocketAutomaticallyReenableWriteCallBack 8)
(defconstant $kCFSocketCloseOnInvalidate #x80)

; #endif


(def-mactype :CFSocketCallBack (find-mactype ':pointer)); (CFSocketRef s , CFSocketCallBackType type , CFDataRef address , const void * data , void * info)
;  If the callback wishes to keep hold of address or data after the point that it returns, then it must copy them. 
(defrecord CFSocketContext
   (version :SInt32)
   (info :pointer)
   (retain (:pointer :callback))                ;(void * (const void * info))
   (release (:pointer :callback))               ;(void (const void * info))
   (copyDescription (:pointer :callback))       ;(CFStringRef (const void * info))
)

(deftrap-inline "_CFSocketGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFSocketCreate" 
   ((allocator (:pointer :__CFAllocator))
    (protocolFamily :SInt32)
    (socketType :SInt32)
    (protocol :SInt32)
    (callBackTypes :UInt32)
    (callout :pointer)
    (context (:pointer :CFSOCKETCONTEXT))
   )
   (:pointer :__CFSocket)
() )

(deftrap-inline "_CFSocketCreateWithNative" 
   ((allocator (:pointer :__CFAllocator))
    (sock :signed-long)
    (callBackTypes :UInt32)
    (callout :pointer)
    (context (:pointer :CFSOCKETCONTEXT))
   )
   (:pointer :__CFSocket)
() )

(deftrap-inline "_CFSocketCreateWithSocketSignature" 
   ((allocator (:pointer :__CFAllocator))
    (signature (:pointer :CFSOCKETSIGNATURE))
    (callBackTypes :UInt32)
    (callout :pointer)
    (context (:pointer :CFSOCKETCONTEXT))
   )
   (:pointer :__CFSocket)
() )

(deftrap-inline "_CFSocketCreateConnectedToSocketSignature" 
   ((allocator (:pointer :__CFAllocator))
    (signature (:pointer :CFSOCKETSIGNATURE))
    (callBackTypes :UInt32)
    (callout :pointer)
    (context (:pointer :CFSOCKETCONTEXT))
    (timeout :double-float)
   )
   (:pointer :__CFSocket)
() )
;  CFSocketCreateWithSignature creates a socket of the requested type and binds its address (using CFSocketSetAddress) to the requested address.  If this fails, it returns NULL.  CFSocketCreateConnectedToSignature creates a socket suitable for connecting to the requested type and address, and connects it (using CFSocketConnectToAddress).  If this fails, it returns NULL. 

(deftrap-inline "_CFSocketSetAddress" 
   ((s (:pointer :__CFSocket))
    (address (:pointer :__CFData))
   )
   :SInt32
() )

(deftrap-inline "_CFSocketConnectToAddress" 
   ((s (:pointer :__CFSocket))
    (address (:pointer :__CFData))
    (timeout :double-float)
   )
   :SInt32
() )

(deftrap-inline "_CFSocketInvalidate" 
   ((s (:pointer :__CFSocket))
   )
   nil
() )

(deftrap-inline "_CFSocketIsValid" 
   ((s (:pointer :__CFSocket))
   )
   :Boolean
() )

(deftrap-inline "_CFSocketCopyAddress" 
   ((s (:pointer :__CFSocket))
   )
   (:pointer :__CFData)
() )

(deftrap-inline "_CFSocketCopyPeerAddress" 
   ((s (:pointer :__CFSocket))
   )
   (:pointer :__CFData)
() )

(deftrap-inline "_CFSocketGetContext" 
   ((s (:pointer :__CFSocket))
    (context (:pointer :CFSOCKETCONTEXT))
   )
   nil
() )

(deftrap-inline "_CFSocketGetNative" 
   ((s (:pointer :__CFSocket))
   )
   :signed-long
() )

(deftrap-inline "_CFSocketCreateRunLoopSource" 
   ((allocator (:pointer :__CFAllocator))
    (s (:pointer :__CFSocket))
    (order :SInt32)
   )
   (:pointer :__CFRunLoopSource)
() )

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

(deftrap-inline "_CFSocketGetSocketFlags" 
   ((s (:pointer :__CFSocket))
   )
   :UInt32
() )

(deftrap-inline "_CFSocketSetSocketFlags" 
   ((s (:pointer :__CFSocket))
    (flags :UInt32)
   )
   nil
() )

(deftrap-inline "_CFSocketDisableCallBacks" 
   ((s (:pointer :__CFSocket))
    (callBackTypes :UInt32)
   )
   nil
() )

(deftrap-inline "_CFSocketEnableCallBacks" 
   ((s (:pointer :__CFSocket))
    (callBackTypes :UInt32)
   )
   nil
() )

; #endif

;  For convenience, a function is provided to send data using the socket with a timeout.  The timeout will be used only if the specified value is positive.  The address should be left NULL if the socket is already connected. 

(deftrap-inline "_CFSocketSendData" 
   ((s (:pointer :__CFSocket))
    (address (:pointer :__CFData))
    (data (:pointer :__CFData))
    (timeout :double-float)
   )
   :SInt32
() )
;  Generic name registry functionality (CFSocketRegisterValue, 
; CFSocketCopyRegisteredValue) allows the registration of any property
; list type.  Functions specific to CFSockets (CFSocketRegisterSocketData,
; CFSocketCopyRegisteredSocketData) register a CFData containing the
; components of a socket signature (protocol family, socket type,
; protocol, and address).  In each function the nameServerSignature
; may be NULL, or any component of it may be 0, to use default values
; (TCP, INADDR_LOOPBACK, port as set).  Name registration servers might
; not allow registration with other than TCP and INADDR_LOOPBACK.
; The actual address of the server responding to a query may be obtained
; by using the nameServerAddress argument.  This address, the address
; returned by CFSocketCopyRegisteredSocketSignature, and the value
; returned by CFSocketCopyRegisteredValue must (if non-null) be released
; by the caller.  CFSocketUnregister removes any registration associated
; with the specified name.
; 

(deftrap-inline "_CFSocketRegisterValue" 
   ((nameServerSignature (:pointer :CFSOCKETSIGNATURE))
    (timeout :double-float)
    (name (:pointer :__CFString))
    (value (:pointer :void))
   )
   :SInt32
() )

(deftrap-inline "_CFSocketCopyRegisteredValue" 
   ((nameServerSignature (:pointer :CFSOCKETSIGNATURE))
    (timeout :double-float)
    (name (:pointer :__CFString))
    (value (:pointer :CFPROPERTYLISTREF))
    (nameServerAddress (:pointer :CFDATAREF))
   )
   :SInt32
() )

(deftrap-inline "_CFSocketRegisterSocketSignature" 
   ((nameServerSignature (:pointer :CFSOCKETSIGNATURE))
    (timeout :double-float)
    (name (:pointer :__CFString))
    (signature (:pointer :CFSOCKETSIGNATURE))
   )
   :SInt32
() )

(deftrap-inline "_CFSocketCopyRegisteredSocketSignature" 
   ((nameServerSignature (:pointer :CFSOCKETSIGNATURE))
    (timeout :double-float)
    (name (:pointer :__CFString))
    (signature (:pointer :CFSOCKETSIGNATURE))
    (nameServerAddress (:pointer :CFDATAREF))
   )
   :SInt32
() )

(deftrap-inline "_CFSocketUnregister" 
   ((nameServerSignature (:pointer :CFSOCKETSIGNATURE))
    (timeout :double-float)
    (name (:pointer :__CFString))
   )
   :SInt32
() )

(deftrap-inline "_CFSocketSetDefaultNameRegistryPortNumber" 
   ((port :UInt16)
   )
   nil
() )

(deftrap-inline "_CFSocketGetDefaultNameRegistryPortNumber" 
   (
   )
   :UInt16
() )
;  Constants used in name registry server communications 
(def-mactype :kCFSocketCommandKey (find-mactype ':CFStringRef))
(def-mactype :kCFSocketNameKey (find-mactype ':CFStringRef))
(def-mactype :kCFSocketValueKey (find-mactype ':CFStringRef))
(def-mactype :kCFSocketResultKey (find-mactype ':CFStringRef))
(def-mactype :kCFSocketErrorKey (find-mactype ':CFStringRef))
(def-mactype :kCFSocketRegisterCommand (find-mactype ':CFStringRef))
(def-mactype :kCFSocketRetrieveCommand (find-mactype ':CFStringRef))

; #if defined(__cplusplus)
#|
}
#endif
|#
;  __cplusplus 

; #endif /* ! __COREFOUNDATION_CFSOCKET__ */


(provide-interface "CFSocket")