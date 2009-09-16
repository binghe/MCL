(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IONetworkUserClient.h"
; at Sunday July 2,2006 7:29:33 pm.
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
;  * Copyright (c) 1999 Apple Computer, Inc.  All rights reserved. 
;  *
;  * HISTORY
;  *
;  
; #ifndef _IONETWORKUSERCLIENT_H
; #define _IONETWORKUSERCLIENT_H
;  IONetworkUserClient type ID.
; 
(defconstant $kIONetworkUserClientTypeID 4278190081)
; #define kIONetworkUserClientTypeID   0xff000001
(defconstant $kIONUCType 4278190081)
; #define kIONUCType                   0xff000001  // FIXME
;  IONetworkUserClient call structure definitions.
; 

(defconstant $kIONUCResetNetworkDataIndex 0)
(defconstant $kIONUCResetNetworkDataInputs 1)
; #define kIONUCResetNetworkDataInputs           1
(defconstant $kIONUCResetNetworkDataOutputs 0)
; #define kIONUCResetNetworkDataOutputs          0
; #define kIONUCResetNetworkDataFlags            kIOUCScalarIScalarO

(defconstant $kIONUCWriteNetworkDataIndex 1)
(defconstant $kIONUCWriteNetworkDataInput0 4294967295)
; #define kIONUCWriteNetworkDataInput0           0xffffffff
(defconstant $kIONUCWriteNetworkDataInput1 4294967295)
; #define kIONUCWriteNetworkDataInput1           0xffffffff
; #define kIONUCWriteNetworkDataFlags            kIOUCScalarIStructI

(defconstant $kIONUCReadNetworkDataIndex 2)
(defconstant $kIONUCReadNetworkDataInputs 1)
; #define kIONUCReadNetworkDataInputs            1
(defconstant $kIONUCReadNetworkDataOutputs 4294967295)
; #define kIONUCReadNetworkDataOutputs           0xffffffff
; #define kIONUCReadNetworkDataFlags             kIOUCScalarIStructO

(defconstant $kIONUCGetNetworkDataCapacityIndex 3)
(defconstant $kIONUCGetNetworkDataCapacityInputs 1)
; #define kIONUCGetNetworkDataCapacityInputs     1
(defconstant $kIONUCGetNetworkDataCapacityOutputs 1)
; #define kIONUCGetNetworkDataCapacityOutputs    1
; #define kIONUCGetNetworkDataCapacityFlags      kIOUCScalarIScalarO

(defconstant $kIONUCGetNetworkDataHandleIndex 4)
(defconstant $kIONUCGetNetworkDataHandleInputs 4294967295)
; #define kIONUCGetNetworkDataHandleInputs       0xffffffff
(defconstant $kIONUCGetNetworkDataHandleOutputs 4294967295)
; #define kIONUCGetNetworkDataHandleOutputs      0xffffffff
; #define kIONUCGetNetworkDataHandleFlags        kIOUCStructIStructO

(defconstant $kIONUCLastIndex 5)
; #ifdef KERNEL
#| #|

#include <IOKitIOUserClient.h>

class IONetworkInterface;



class IONetworkUserClient : public IOUserClient
{
    OSDeclareDefaultStructors( IONetworkUserClient )

protected:
    IONetworkInterface *   _owner;
    task_t                 _task;
    IOExternalMethod       _methods[kIONUCLastIndex];



    virtual void free();

public:



    static IONetworkUserClient * withTask(task_t owningTask);



    virtual bool start(IOService * provider);



    virtual IOReturn clientClose();



    virtual IOReturn clientDied();



    virtual IOExternalMethod * getExternalMethodForIndex(UInt32 index);

protected:



    virtual IOReturn resetNetworkData(OSSymbol * key);



    virtual IOReturn writeNetworkData(OSSymbol *   key,
                                      void *       srcBuffer,
                                      IOByteCount  srcBufferSize);



    virtual IOReturn readNetworkData(OSSymbol *    key,
                                     void *        dstBuffer,
                                     IOByteCount * dstBufferSize);



    virtual IOReturn getNetworkDataCapacity(OSSymbol * key,
                                            UInt32 *   capacity);



    virtual IOReturn getNetworkDataHandle(char *         name,
                                          OSSymbol **    handle,
                                          IOByteCount    nameSize,
                                          IOByteCount *  handleSizeP);



    virtual IOReturn setProperties(OSObject * properties);



    virtual IOService * getService();
};

#endif
|#
 |#
;  KERNEL 

; #endif /* !_IONETWORKUSERCLIENT_H */


(provide-interface "IONetworkUserClient")