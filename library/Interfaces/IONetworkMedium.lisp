(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IONetworkMedium.h"
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
;  * IONetworkMedium.h
;  *
;  * HISTORY
;  *
;  
; #ifndef _IONETWORKMEDIUM_H
; #define _IONETWORKMEDIUM_H
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(require-interface "net/if_media")
; ! @typedef IOMediumType
;     @discussion A 32-bit value divided into fields which describes
;     a single medium type. 

(def-mactype :IOMediumType (find-mactype ':UInt32))
; ! @defined kIOMediumType
;     @abstract kIOMediumType is a property of IONetworkMedium objects.
;         It is an OSNumber object.
;     @discussion The kIOMediumType property describes the type of
;         medium that this object represents. 
(defconstant $kIOMediumType "Type")
; #define kIOMediumType           "Type"
; ! @defined kIOMediumFlags
;     @abstract kIOMediumFlags is a property of IONetworkMedium objects.
;         It is an OSNumber object.
;     @discussion The kIOMediumFlags property describes a set of
;         attributes assigned to the medium. 
(defconstant $kIOMediumFlags "Flags")
; #define kIOMediumFlags          "Flags"
; ! @defined kIOMediumSpeed
;     @abstract kIOMediumSpeed is a property of IONetworkMedium objects.
;         It is an OSNumber object.
;     @discussion The kIOMediumSpeed property describes the maximum link
;         speed supported by the medium in bits per second. 
(defconstant $kIOMediumSpeed "Speed")
; #define kIOMediumSpeed          "Speed"
; ! @defined kIOMediumIndex
;     @abstract kIOMediumIndex is a property of IONetworkMedium objects.
;         It is an OSNumber object.
;     @discussion The kIOMediumIndex property describes an index assigned
;         by the owner of the medium object. Its interpretation is driver
;         specific. 
(defconstant $kIOMediumIndex "Index")
; #define kIOMediumIndex          "Index"
; ===========================================================================
;  Medium Type (IOMediumType).
; 
;  The medium type is encoded by a 32-bit value. The definitions of
;  the fields and the encoding for each field is adapted from FreeBSD.
; 
;  Bits     Definition
;  -------------------
;   4-0     medium subtype
;   7-5     network type
;  15-8     network specific options
;  19-16    reserved
;  27-20    common options
;  31-28    instance number
;  Ethernet.
; 

(defconstant $kIOMediumEthernet $ifm_ether)
(defconstant $kIOMediumEthernetAuto 32)
(defconstant $kIOMediumEthernetManual 33)
(defconstant $kIOMediumEthernetNone 34)
(defconstant $kIOMediumEthernet10BaseT 35)
(defconstant $kIOMediumEthernet10Base2 36)
(defconstant $kIOMediumEthernet10Base5 37)
(defconstant $kIOMediumEthernet100BaseTX 38)
(defconstant $kIOMediumEthernet100BaseFX 39)
(defconstant $kIOMediumEthernet100BaseT4 40)
(defconstant $kIOMediumEthernet100BaseVG 41)
(defconstant $kIOMediumEthernet100BaseT2 42)
(defconstant $kIOMediumEthernet1000BaseSX 43)
(defconstant $kIOMediumEthernet10BaseSTP 44)
(defconstant $kIOMediumEthernet10BaseFL 45)
(defconstant $kIOMediumEthernet1000BaseLX 46)
(defconstant $kIOMediumEthernet1000BaseCX 47)
(defconstant $kIOMediumEthernet1000BaseTX 48)
(defconstant $kIOMediumEthernetHomePNA1 49)
;  IEEE 802.11 Wireless.
; 

(defconstant $kIOMediumIEEE80211 $ifm_ieee80211)
(defconstant $kIOMediumIEEE80211Auto #x80)
(defconstant $kIOMediumIEEE80211Manual #x81)
(defconstant $kIOMediumIEEE80211None #x82)
(defconstant $kIOMediumIEEE80211FH1 #x83)
(defconstant $kIOMediumIEEE80211FH2 #x84)
(defconstant $kIOMediumIEEE80211DS2 #x85)
(defconstant $kIOMediumIEEE80211DS5 #x86)
(defconstant $kIOMediumIEEE80211DS11 #x87)
(defconstant $kIOMediumIEEE80211DS1 #x88)
(defconstant $kIOMediumIEEE80211OptionAdhoc $ifm_ieee80211_adhoc)
;  Common options.
; 

(defconstant $kIOMediumOptionFullDuplex $ifm_fdx)
(defconstant $kIOMediumOptionHalfDuplex $ifm_hdx)
(defconstant $kIOMediumOptionFlowControl $ifm_flow)
(defconstant $kIOMediumOptionFlag0 $ifm_flag0)
(defconstant $kIOMediumOptionFlag1 $ifm_flag1)
(defconstant $kIOMediumOptionFlag2 $ifm_flag2)
(defconstant $kIOMediumOptionLoopback $ifm_loop)
;  Medium type masks.
; 
; #define kIOMediumSubTypeMask        IFM_TMASK
; #define kIOMediumNetworkTypeMask    IFM_NMASK
; #define kIOMediumOptionsMask        IFM_OMASK
; #define kIOMediumCommonOptionsMask  IFM_GMASK
; #define kIOMediumInstanceShift      IFM_ISHIFT
; #define kIOMediumInstanceMask       IFM_IMASK
;  Medium type field accessors.
; 
(defconstant $IOMediumGetSubType 0)
; #define IOMediumGetSubType(x)       ((x)  & kIOMediumSubTypeMask)
(defconstant $IOMediumGetNetworkType 0)
; #define IOMediumGetNetworkType(x)   ((x)  & kIOMediumNetworkMask)
(defconstant $IOMediumGetInstance 0)
; #define IOMediumGetInstance(x)      (((x) & kIOMediumInstanceMask) >>                                             kIOMediumInstanceShift)
; ===========================================================================
;  Medium flags.
; ===========================================================================
;  Link status bits.
; 

(defconstant $kIONetworkLinkValid $ifm_avalid)  ;  link status is valid

(defconstant $kIONetworkLinkActive $ifm_active) ;  link is up/active.

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#
; ===========================================================================
;  IONetworkMedium class.
; #ifdef KERNEL
#| #|

#include <libkernc++OSObject.h>
#include <libkernc++OSSymbol.h>



class IONetworkMedium : public OSObject
{
    OSDeclareDefaultStructors( IONetworkMedium )

protected:
    IOMediumType      _type;
    UInt32            _flags;
    UInt64            _speed;
    UInt32            _index;
    const OSSymbol *  _name;

    struct ExpansionData { };
    
    ExpansionData *_reserved;




    virtual void free();

public:



    static const OSSymbol * nameForType(IOMediumType type);



    static bool addMedium(OSDictionary *          dict,
                          const IONetworkMedium * medium);



    static void removeMedium(OSDictionary *          dict,
                             const IONetworkMedium * medium);



    static IONetworkMedium * getMediumWithType(const OSDictionary * dict,
                                               IOMediumType         type,
                                               IOMediumType         mask = 0);



    static IONetworkMedium * getMediumWithIndex(const OSDictionary * dict,
                                                UInt32               index,
                                                UInt32               mask = 0);



    virtual bool init(IOMediumType  type,
                      UInt64        speed,
                      UInt32        flags = 0,
                      UInt32        index = 0,
                      const char *  name  = 0);



    static IONetworkMedium * medium(IOMediumType  type,
                                    UInt64        speed,
                                    UInt32        flags = 0,
                                    UInt32        index = 0,
                                    const char *  name  = 0);



    virtual IOMediumType  getType() const;



    virtual UInt64        getSpeed() const;



    virtual UInt32        getFlags() const;



    virtual UInt32        getIndex() const;



    virtual const OSSymbol * getName() const;



    virtual const OSSymbol * getKey() const;



    virtual bool isEqualTo(const IONetworkMedium * medium) const;



    virtual bool isEqualTo(const OSMetaClassBase * obj) const;



    virtual bool serialize(OSSerialize * s) const;

        OSMetaClassDeclareReservedUnused( IONetworkMedium,  0);
    OSMetaClassDeclareReservedUnused( IONetworkMedium,  1);
    OSMetaClassDeclareReservedUnused( IONetworkMedium,  2);
    OSMetaClassDeclareReservedUnused( IONetworkMedium,  3);
};

inline const OSSymbol * IONetworkMedium::getKey() const
{
    return getName();
}

#endif
|#
 |#
;  KERNEL 

; #endif /* !_IONETWORKMEDIUM_H */


(provide-interface "IONetworkMedium")