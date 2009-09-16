(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOI2CInterface.h"
; at Sunday July 2,2006 7:29:26 pm.
; 
;  * Copyright (c) 1998-2000 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * The contents of this file constitute Original Code as defined in and
;  * are subject to the Apple Public Source License Version 1.1 (the
;  * "License").  You may not use this file except in compliance with the
;  * License.  Please obtain a copy of the License at
;  * http://www.apple.com/publicsource and read it before using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
;  * License for the specific language governing rights and limitations
;  * under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef _IOKIT_IOI2CINTERFACE_H
; #define _IOKIT_IOI2CINTERFACE_H
;  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 

;type name? (def-mactype :IOI2CRequest (find-mactype ':IOI2CRequest))

;type name? (def-mactype :IOI2CBuffer (find-mactype ':IOI2CBuffer))

(def-mactype :IOI2CRequestCompletion (find-mactype ':pointer)); (IOI2CRequest * request)
;  IOI2CRequest.sendTransactionType, IOI2CRequest.replyTransactionType

(defconstant $kIOI2CNoTransactionType 0)
(defconstant $kIOI2CSimpleTransactionType 1)
(defconstant $kIOI2CDDCciReplyTransactionType 2)
(defconstant $kIOI2CCombinedTransactionType 3)
;  IOI2CRequest.commFlags

(defconstant $kIOI2CUseSubAddressCommFlag 2)
; !
;  * @struct IOI2CRequest
;  * @abstract A structure defining an I2C bus transaction.
;  * @discussion This structure is used to request an I2C transaction consisting of a send (write) to and reply (read) from a device, either of which is optional, to be carried out atomically on an I2C bus.
;  * @field __reservedA Set to zero.
;  * @field result The result of the transaction. Common errors are kIOReturnNoDevice if there is no device responding at the given address, kIOReturnUnsupportedMode if the type of transaction is unsupported on the requested bus.
;  * @field completion A completion routine to be executed when the request completes. If NULL is passed, the request is synchronous, otherwise it may execute asynchronously.
;  * @field commFlags Flags that modify the I2C transaction type. The following flags are defined:<br>
;         kIOI2CUseSubAddressCommFlag Transaction includes a subaddress.<br>
;  * @field minReplyDelay Minimum delay as absolute time between send and reply transactions.
;  * @field sendAddress I2C address to write.
;  * @field sendSubAddress I2C subaddress to write.
;  * @field __reservedB Set to zero.
;  * @field sendTransactionType The following types of transaction are defined for the send part of the request:<br>
;         kIOI2CNoTransactionType No send transaction to perform. <br>
;         kIOI2CSimpleTransactionType Simple I2C message. <br>
;         kIOI2CCombinedTransactionType Combined format I2C R/~W transaction. <br>
;  * @field sendBuffer Pointer to the send buffer.
;  * @field sendBytes Number of bytes to send. Set to actual bytes sent on completion of the request.
;  * @field replyAddress I2C Address from which to read.
;  * @field replySubAddress I2C Address from which to read.
;  * @field __reservedC Set to zero.
;  * @field replyTransactionType The following types of transaction are defined for the reply part of the request:<br>
;         kIOI2CNoTransactionType No reply transaction to perform. <br>
;         kIOI2CSimpleTransactionType Simple I2C message. <br>
;         kIOI2CDDCciReplyTransactionType DDC/ci message (with embedded length). See VESA DDC/ci specification. <br>
;         kIOI2CCombinedTransactionType Combined format I2C R/~W transaction. <br>
;  * @field replyBuffer Pointer to the reply buffer.
;  * @field replyBytes Max bytes to reply (size of replyBuffer). Set to actual bytes received on completion of the request.
;  * @field __reservedD Set to zero.
;  
(defrecord IOI2CRequest
   (__reservedA :uint64)
   (result :signed-long)
   (completion :pointer)
   (commFlags :UInt32)
   (minReplyDelay :uint64_t)
   (sendAddress :UInt8)
   (sendSubAddress :UInt8)
   (__reservedB (:array :UInt8 2))
   (sendTransactionType :UInt32)
   (sendBuffer :vm_address_t)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
   (sendBytes :UInt32)
   (replyAddress :UInt8)
   (replySubAddress :UInt8)
   (__reservedC (:array :UInt8 2))
   (replyTransactionType :UInt32)
   (replyBuffer :vm_address_t)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
   (replyBytes :UInt32)
   (__reservedD (:array :UInt32 16))
)
;  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
(defconstant $kIOI2CInterfaceClassName "IOI2CInterface")
; #define kIOI2CInterfaceClassName	"IOI2CInterface"
(defconstant $kIOI2CInterfaceIDKey "IOI2CInterfaceID")
; #define kIOI2CInterfaceIDKey		"IOI2CInterfaceID"
(defconstant $kIOI2CBusTypeKey "IOI2CBusType")
; #define kIOI2CBusTypeKey		"IOI2CBusType"
(defconstant $kIOI2CTransactionTypesKey "IOI2CTransactionTypes")
; #define kIOI2CTransactionTypesKey	"IOI2CTransactionTypes"
(defconstant $kIOI2CSupportedCommFlagsKey "IOI2CSupportedCommFlags")
; #define kIOI2CSupportedCommFlagsKey	"IOI2CSupportedCommFlags"
(defconstant $kIOFBI2CInterfaceInfoKey "IOFBI2CInterfaceInfo")
; #define kIOFBI2CInterfaceInfoKey	"IOFBI2CInterfaceInfo"
(defconstant $kIOFBI2CInterfaceIDsKey "IOFBI2CInterfaceIDs")
; #define kIOFBI2CInterfaceIDsKey		"IOFBI2CInterfaceIDs"
;  kIOI2CBusTypeKey values

(defconstant $kIOI2CBusTypeI2C 1)
; !
;  * @struct IOI2CBusTiming
;  * @abstract A structure defining low level timing for an I2C bus.
;  * @discussion This structure is used to specify timeouts and pulse widths for an I2C bus implementation.
;  * @field bitTimeout Maximum time a slave can delay (by pulling the clock line low) a single bit response.
;  * @field byteTimeout Maximum time a slave can delay (by pulling the clock line low) the first bit of a byte response.
;  * @field acknowledgeTimeout Maximum time to wait for a slave to respond with an ACK after writing a byte.
;  * @field startTimeout Maximum time to wait for a slave to respond after a start signal.
;  * @field riseFallTime Time to wait after any change in output signal.
;  * @field __reservedA Set to zero.
;  
(defrecord IOI2CBusTiming
   (bitTimeout :UnsignedWide)
   (byteTimeout :UnsignedWide)
   (acknowledgeTimeout :UnsignedWide)
   (startTimeout :UnsignedWide)
   (holdTime :UnsignedWide)
   (riseFallTime :UnsignedWide)
   (__reservedA (:array :UInt32 8))
)

;type name? (%define-record :IOI2CBusTiming (find-record-descriptor ':IOI2CBusTiming))
; #ifndef KERNEL
;  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
;  options for IOFBCopyI2CInterfaceForBus()

(defconstant $kIOI2CBusNumberMask #xFF)
; ! @function IOFBGetI2CInterfaceCount
;     @abstract Returns a count of I2C interfaces available associated with an IOFramebuffer instance.
;     @discussion Returns a count of I2C interfaces available associated with an IOFramebuffer instance.
;     @param framebuffer The io_service_t of an IOFramebuffer instance. CoreGraphics will provide this for a CGDisplay with the CGDisplayIOServicePort() call.
;     @param count Interface count is returned.
;     @result An IOReturn code. 

(deftrap-inline "_IOFBGetI2CInterfaceCount" 
   ((framebuffer :pointer)
    (count (:pointer :IOITEMCOUNT))
   )
   :signed-long
() )
; ! @function IOFBCopyI2CInterfaceForBus
;     @abstract Returns an instance of an I2C bus interface, associated with an IOFramebuffer instance / bus index pair.
;     @discussion Some graphics devices will allow access to an I2C bus routed through a display connector in order to control external devices on that bus. This function returns an instance of an I2C bus interface, associated with an IOFramebuffer instance / bus index pair. The number of I2C buses is available from the IOFBGetI2CInterfaceCount() call. The interface may be used with the IOI2CInterfaceOpen/Close/SendRequest() calls to carry out I2C transactions on that bus. Not all graphics devices support this functionality.
;     @param bus The zero based index of the bus on the requested framebuffer.
;     @param interface The interface instance is returned. The caller should release this instance with IOObjectRelease().
;     @result An IOReturn code. 

(deftrap-inline "_IOFBCopyI2CInterfaceForBus" 
   ((framebuffer :pointer)
    (bus :UInt32)
    (interface (:pointer :io_service_t))
   )
   :signed-long
() )

(def-mactype :IOI2CConnectRef (find-mactype '(:pointer :IOI2CConnect)))
;  struct IOI2CConnect is opaque 

(deftrap-inline "_IOI2CCopyInterfaceForID" 
   ((identifier (:pointer :void))
    (interface (:pointer :io_service_t))
   )
   :signed-long
() )
; ! @function IOI2CInterfaceOpen
;     @abstract Opens an instance of an I2C bus interface, allowing I2C requests to be made.
;     @discussion An instance of an I2C bus interface, obtained by IOFBCopyI2CInterfaceForBus, is opened with this function allowing I2C requests to be made.
;     @param interface An I2C bus interface (see IOFBCopyI2CInterfaceForBus). The interface may be released after this call is made.
;     @param options Pass kNilOptions.
;     @param connect The opaque IOI2CConnectRef is returned, for use with IOI2CSendRequest() and IOI2CInterfaceClose().
;     @result An IOReturn code. 

(deftrap-inline "_IOI2CInterfaceOpen" 
   ((interface :pointer)
    (options :UInt32)
    (connect (:pointer :IOI2CCONNECTREF))
   )
   :signed-long
() )
; ! @function IOI2CInterfaceClose
;     @abstract Closes an IOI2CConnectRef.
;     @discussion Frees the resources associated with an IOI2CConnectRef.
;     @param connect The opaque IOI2CConnectRef returned by IOI2CInterfaceOpen().
;     @param options Pass kNilOptions.
;     @result An IOReturn code. 

(deftrap-inline "_IOI2CInterfaceClose" 
   ((connect (:pointer :IOI2CConnect))
    (options :UInt32)
   )
   :signed-long
() )
; ! @function IOI2CSendRequest
;     @abstract Carries out the I2C transaction specified by an IOI2CRequest structure.
;     @discussion Frees the resources associated with an IOI2CConnectRef.
;     @param connect The opaque IOI2CConnectRef returned by IOI2CInterfaceOpen().
;     @param options Pass kNilOptions.
;     @param request Pass a pointer to a IOI2CRequest structure describing the request. If an asynchronous request (with a non-NULL completion routine) the request structure must be valid for the life of the request.
;     @result An IOReturn code reflecting only the result of starting the transaction. If the result of IOI2CSendRequest() is kIOReturnSuccess, the I2C transaction result is returned in the result field of the request structure. 

(deftrap-inline "_IOI2CSendRequest" 
   ((connect (:pointer :IOI2CConnect))
    (options :UInt32)
    (request (:pointer :IOI2CREQUEST))
   )
   :signed-long
() )
#| 
; #else
;  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
#|
 confused about CLASS IOI2CInterface #\: public IOService #\{ OSDeclareDefaultStructors #\( IOI2CInterface #\) protected #\: UInt64 fID #\; public #\: IOReturn newUserClient #\( task_t owningTask #\, void * security_id #\, UInt32 type #\, IOUserClient ** handler #\) #\; bool registerI2C #\( UInt64 id #\) #\; virtual IOReturn startIO #\( IOI2CRequest * request #\) = 0 #\;
|#
;  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 |#

; #endif /* KERNEL */


; #endif /* ! _IOKIT_IOI2CINTERFACE_H */


(provide-interface "IOI2CInterface")