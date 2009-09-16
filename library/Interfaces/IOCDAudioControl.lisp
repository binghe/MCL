(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOCDAudioControl.h"
; at Sunday July 2,2006 7:28:38 pm.
; 
;  * Copyright (c) 1998-2003 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * This file contains Original Code and/or Modifications of Original Code
;  * as defined in and that are subject to the Apple Public Source License
;  * Version 2.0 (the 'License'). You may not use this file except in
;  * compliance with the License. Please obtain a copy of the License at
;  * http://www.opensource.apple.com/apsl/ and read it before using this
;  * file.
;  * 
;  * The Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
;  * Please see the License for the specific language governing rights and
;  * limitations under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; !
;  * @header IOCDAudioControl
;  * @abstract
;  * This header contains the IOCDAudioControl class definition.
;  
; #ifndef	_IOCDAUDIOCONTROL_H
; #define	_IOCDAUDIOCONTROL_H
; !
;  * @defined kIOCDAudioControlClass
;  * @abstract
;  * kIOCDAudioControlClass is the name of the IOCDAudioControl class.
;  * @discussion
;  * kIOCDAudioControlClass is the name of the IOCDAudioControl class.
;  
(defconstant $kIOCDAudioControlClass "IOCDAudioControl")
; #define kIOCDAudioControlClass "IOCDAudioControl"
; #ifdef KERNEL
#| #|
#ifdef__cplusplus



#include <IOKitstorageIOCDBlockStorageDriver.h>



class IOCDAudioControl : public IOService
{
    OSDeclareDefaultStructors(IOCDAudioControl)

protected:

    struct ExpansionData {  };
    ExpansionData * _expansionData;

    

    virtual IOReturn newUserClient( task_t          task,
                                    void *          security,
                                    UInt32          type,
                                    IOUserClient ** object ); 

public:

    

    virtual IOReturn getStatus(CDAudioStatus * status);

    

    virtual CDTOC * getTOC(void);

    

    virtual IOReturn getVolume(UInt8 * left, UInt8 * right);

    

    virtual IOReturn setVolume(UInt8 left, UInt8 right);

    

    virtual IOReturn pause(bool pause);

    

    virtual IOReturn play(CDMSF timeStart, CDMSF timeStop);

    

    virtual IOReturn scan(CDMSF timeStart, bool reverse);

    
    
    virtual IOReturn stop();

    

    virtual IOCDBlockStorageDriver * getProvider() const;

    OSMetaClassDeclareReservedUnused(IOCDAudioControl,  0);
    OSMetaClassDeclareReservedUnused(IOCDAudioControl,  1);
    OSMetaClassDeclareReservedUnused(IOCDAudioControl,  2);
    OSMetaClassDeclareReservedUnused(IOCDAudioControl,  3);
    OSMetaClassDeclareReservedUnused(IOCDAudioControl,  4);
    OSMetaClassDeclareReservedUnused(IOCDAudioControl,  5);
    OSMetaClassDeclareReservedUnused(IOCDAudioControl,  6);
    OSMetaClassDeclareReservedUnused(IOCDAudioControl,  7);
};

#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* !_IOCDAUDIOCONTROL_H */


(provide-interface "IOCDAudioControl")