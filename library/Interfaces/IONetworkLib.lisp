(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IONetworkLib.h"
; at Sunday July 2,2006 7:29:32 pm.
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
; 
;  * HISTORY
;  *
;  
; #ifndef _IONETWORKLIB_H
; #define _IONETWORKLIB_H

(require-interface "IOKit/IOKitLib")

(require-interface "IOKit/network/IONetworkData")

(require-interface "IOKit/network/IONetworkMedium")

(require-interface "IOKit/network/IONetworkStats")

(require-interface "IOKit/network/IOEthernetStats")

(require-interface "IOKit/network/IONetworkUserClient")

(def-mactype :IONDHandle (find-mactype ':UInt32))
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; ! @function IONetworkOpen
;     @abstract Open a connection to an IONetworkInterface object.
;     An IONetworkUserClient object is created to manage the connection. 

(deftrap-inline "_IONetworkOpen" 
   ((obj :pointer)
    (con (:pointer :io_connect_t))
   )
   :signed-long
() )
; ! @function IONetworkClose
;     @abstract Close the connection to an IONetworkInterface object. 

(deftrap-inline "_IONetworkClose" 
   ((con :pointer)
   )
   :signed-long
() )
; ! @function IONetworkWriteData
;     @abstract Write to the buffer of a network data object.
;     @param conObject The connection object.
;     @param dataHandle The handle of a network data object.
;     @param srcBuf The data to write is taken from this buffer.
;     @param inSize The size of the source buffer.
;     @result kIOReturnSuccess on success, or an error code otherwise. 

(deftrap-inline "_IONetworkWriteData" 
   ((conObj :pointer)
    (dataHandle :UInt32)
    (srcBuf (:pointer :UInt8))
    (inSize :UInt32)
   )
   :signed-long
() )
; ! @function IONetworkReadData
;     @abstract Read the buffer of a network data object.
;     @param conObject The connection object.
;     @param dataHandle The handle of a network data object.
;     @param destBuf The buffer where the data read shall be written to.
;     @param inOutSizeP Pointer to an integer that the caller must initialize
;            to contain the size of the buffer. This function will overwrite
;            it with the actual number of bytes written to the buffer.
;     @result kIOReturnSuccess on success, or an error code otherwise. 

(deftrap-inline "_IONetworkReadData" 
   ((conObj :pointer)
    (dataHandle :UInt32)
    (destBuf (:pointer :UInt8))
    (inOutSizeP (:pointer :UInt32))
   )
   :signed-long
() )
; ! @function IONetworkResetData
;     @abstract Fill the buffer of a network data object with zeroes.
;     @param conObject The connection object.
;     @param dataHandle The handle of a network data object.
;     @result kIOReturnSuccess on success, or an error code otherwise. 

(deftrap-inline "_IONetworkResetData" 
   ((conObject :pointer)
    (dataHandle :UInt32)
   )
   :signed-long
() )
; ! @function IONetworkGetDataCapacity
;     @abstract Get the capacity (in bytes) of a network data object.
;     @param con The connection object.
;     @param dataHandle The handle of a network data object.
;     @param capacityP Upon success, the capacity is written to this address.
;     @result kIOReturnSuccess on success, or an error code otherwise. 

(deftrap-inline "_IONetworkGetDataCapacity" 
   ((conObject :pointer)
    (dataHandle :UInt32)
    (capacityP (:pointer :UInt32))
   )
   :signed-long
() )
; ! @function IONetworkGetDataHandle
;     @abstract Get the handle of a network data object with the given name.
;     @param con The connection object.
;     @param dataName The name of the network data object.
;     @param dataHandleP Upon success, the handle is written to this address.
;     @result kIOReturnSuccess on success, or an error code otherwise. 

(deftrap-inline "_IONetworkGetDataHandle" 
   ((conObject :pointer)
    (dataName (:pointer :char))
    (dataHandleP (:pointer :IONDHANDLE))
   )
   :signed-long
() )
; ! @function IONetworkSetPacketFiltersMask
;     @abstract Set the packet filters for a given filter group.
;     @discussion A network controller may support a number of packets filters
;     that can accept or reject a type of packet seen on the network. A filter
;     group identifies a set of related filters, such as all filters that will
;     allow a packet to pass upstream based on the destination address encoded
;     within the packet. This function allows an user-space program to set the
;     filtering performed by a given filter group.
;     @param connect The connection object returned from IONetworkOpen(). 
;     @param filterGroup The name of the packet filter group.
;     @param filtersMask A mask of filters to set.
;     @param options No options are currently defined.
;     @result An IOReturn error code. 

(deftrap-inline "_IONetworkSetPacketFiltersMask" 
   ((connect :pointer)
    (filterGroup (:pointer :IO_NAME_T))
    (filtersMask :UInt32)
    (options :UInt32)
   )
   :signed-long
() )
; ! @enum IONetworkPacketFilterOptions
;     @constant kIONetworkSupportedPacketFilters Indicate the filters that are
;     supported by the hardware. 

(defconstant $kIONetworkSupportedPacketFilters 1)
; ! @function IONetworkGetPacketFiltersMask
;     @abstract Get the packet filters for a given filter group.
;     @discussion A network controller may support a number of packets filters
;     that can accept or reject a type of packet seen on the network. A filter
;     group identifies a set of related filters, such as all filters that will
;     allow a packet to pass upstream based on the destination address encoded
;     within the packet. This function allows an user-space program to get the
;     filtering performed by a given filter group.
;     @param connect The connection object returned from IONetworkOpen(). 
;     @param filterGroup The name of the packet filter group.
;     @param filters Pointer to the return value containing a mask of
;     packet filters.
;     @param options kIONetworkSupportedPacketFilters may be set to fetch the
;     filters that are supported by the hardware.
;     @result An IOReturn error code. 

(deftrap-inline "_IONetworkGetPacketFiltersMask" 
   ((connect :pointer)
    (filterGroup (:pointer :IO_NAME_T))
    (filtersMask (:pointer :UInt32))
    (options :UInt32)
   )
   :signed-long
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* !_IONETWORKLIB_H */


(provide-interface "IONetworkLib")