(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IONetworkData.h"
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
;  * Copyright (c) 1998 Apple Computer, Inc.  All rights reserved. 
;  *
;  * IONetworkData.h
;  *
;  * HISTORY
;  * 21-Apr-1999      Joe Liu (jliu) created.
;  *
;  
; #ifndef _IONETWORKDATA_H
; #define _IONETWORKDATA_H
; #define IONetworkParameter IONetworkData  // FIXME
; ! @enum An enumeration of constants that describe access types.
;     @constant kIONetworkDataAccessTypeRead  Read access.
;     @constant kIONetworkDataAccessTypeWrite Write access.
;     @constant kIONetworkDataAccessTypeReset Reset access.
;     @constant kIONetworkDataAccessTypeSerialize Serialization access. 

(defconstant $kIONetworkDataAccessTypeRead 1)
(defconstant $kIONetworkDataAccessTypeWrite 2)
(defconstant $kIONetworkDataAccessTypeReset 4)
(defconstant $kIONetworkDataAccessTypeSerialize 8)
(defconstant $kIONetworkDataAccessTypeMask #xFF)
; ! @define kIONetworkDataBasicAccessTypes
;     @discussion The default access types supported by an IONetworkData
;     object. Allow read() and serialize(). 
(defconstant $kIONetworkDataBasicAccessTypes 9)
; #define kIONetworkDataBasicAccessTypes        (kIONetworkDataAccessTypeRead | kIONetworkDataAccessTypeSerialize)
; ! @enum An enumeration of the type of data buffers that can be
;     managed by an IONetworkData object.
;     @constant kIONetworkDataBufferTypeInternal An internal data buffer
;               allocated by the init() method.
;     @constant kIONetworkDataBufferTypeExternal An external (persistent) data
;               buffer.
;     @constant kIONetworkDataBufferTypeNone No data buffer. The only useful 
;               action perfomed by an IONetworkData object with this buffer type 
;               is to call the access notification handler. 

(defconstant $kIONetworkDataBufferTypeInternal 0)
(defconstant $kIONetworkDataBufferTypeExternal 1)
(defconstant $kIONetworkDataBufferTypeNone 2)
; ! @defined kIONetworkDataBytes
;     @abstract kIONetworkDataBytes is a property of IONetworkData objects.
;         It has an OSData value.
;     @discussion The kIONetworkDataBytes property is an OSData that describes
;         the data buffer of an IONetworkData object. This property is present
;         only if kIONetworkDataAccessTypeSerialize access is supported. 
(defconstant $kIONetworkDataBytes "Data")
; #define kIONetworkDataBytes             "Data"
; ! @defined kIONetworkDataAccessTypes
;     @abstract kIONetworkDataAccessTypes is a property of IONetworkData
;         objects. It has an OSNumber value.
;     @discussion The kIONetworkDataAccessTypes property is an OSNumber that
;         describes the supported access types of an IONetworkData object. 
(defconstant $kIONetworkDataAccessTypes "Access Types")
; #define kIONetworkDataAccessTypes       "Access Types"
; ! @defined kIONetworkDataSize
;     @abstract kIONetworkDataSize is a property of IONetworkData
;         objects. It has an OSNumber value.
;     @discussion The kIONetworkDataSize property is an OSNumber that
;         describes the size of the data buffer of an IONetworkData object. 
(defconstant $kIONetworkDataSize "Size")
; #define kIONetworkDataSize              "Size"
; #ifdef KERNEL
#| #|

#include <libkernc++OSSymbol.h>
#include <libkernc++OSSerialize.h>




class IONetworkData : public OSObject
{
    OSDeclareDefaultStructors( IONetworkData )

public:



    typedef IOReturn (*Action)(void *           target,
                               void *           param,
                               IONetworkData *  data,
                               UInt32           accessType,
                               void *           buffer,
                               UInt32 *         bufferSize,
                               UInt32           offset);

protected:
    const OSSymbol *  _key;            UInt32            _access;         void *            _buffer;         UInt32            _bufType;        UInt32            _size;           void *            _tapTarget;      Action            _tapAction;      void *            _tapParam;   
    struct ExpansionData { };
    
    ExpansionData *	_reserved;




    virtual void free();



    virtual bool writeBytes(const void * srcBuffer,
                            UInt32       srcBufferSize,
                            UInt32       writeOffset = 0);



    virtual bool readBytes(void *   dstBuffer,
                           UInt32 * dstBufferSize,
                           UInt32   readOffset = 0) const;



    virtual bool clearBuffer();

public:



    static IONetworkData *
           withInternalBuffer(const char * name,
                              UInt32       bufferSize,
                              UInt32       accessTypes = 
                                           kIONetworkDataBasicAccessTypes,
                              void *       target = 0,
                              Action       action = 0,
                              void *       param  = 0);



    static IONetworkData *
           withExternalBuffer(const char * name,
                              UInt32       bufferSize,
                              void *       externalBuffer,
                              UInt32       accessTypes =
                                           kIONetworkDataBasicAccessTypes,
                              void *       target = 0,
                              Action       action = 0,
                              void *       param  = 0);



    static IONetworkData * withNoBuffer(const char * name,
                                        UInt32       bufferSize,
                                        UInt32       accessTypes,
                                        void *       target,
                                        Action       action,
                                        void *       param = 0);



    virtual bool init(const char * name,
                      UInt32       bufferType,
                      UInt32       bufferSize,
                      void *       externalBuffer = 0,
                      UInt32       accessTypes    =
                                   kIONetworkDataBasicAccessTypes,
                      void *       target         = 0,
                      Action       action         = 0,
                      void *       param          = 0);



    virtual void setAccessTypes(UInt32 types);



    virtual void setNotificationTarget(void *  target,
                                       Action  action,
                                       void *  param = 0);



    virtual const void *     getBuffer() const;



    virtual UInt32           getBufferType() const;



    virtual UInt32           getAccessTypes() const;



    virtual void *           getNotificationTarget() const;



    virtual Action           getNotificationAction() const;



    virtual void *           getNotificationParameter() const;



    virtual const OSSymbol * getKey() const;



    virtual UInt32           getSize() const;



    virtual IOReturn reset();



    virtual IOReturn read(void *   dstBuffer,
                          UInt32 * dstBufferSize,
                          UInt32   readOffset = 0);



    virtual IOReturn write(void *  srcBuffer,
                           UInt32  srcBufferSize,
                           UInt32  writeOffset = 0);



    virtual bool serialize(OSSerialize * s) const;

        OSMetaClassDeclareReservedUnused( IONetworkData,  0);
    OSMetaClassDeclareReservedUnused( IONetworkData,  1);
    OSMetaClassDeclareReservedUnused( IONetworkData,  2);
    OSMetaClassDeclareReservedUnused( IONetworkData,  3);
};

#endif
|#
 |#
;  KERNEL 

; #endif /* !_IONETWORKDATA_H */


(provide-interface "IONetworkData")