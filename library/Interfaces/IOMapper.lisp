(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOMapper.h"
; at Sunday July 2,2006 7:29:29 pm.
; 
;  * Copyright (c) 1998-2003 Apple Computer, Inc. All rights reserved.
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
; #ifndef __IOKIT_IOMAPPER_H
; #define __IOKIT_IOMAPPER_H

(require-interface "sys/cdefs")

(require-interface "IOKit/IOTypes")

(require-interface "mach/vm_types")
;  These are C accessors to the system mapper for non-IOKit clients

(deftrap-inline "_IOMapperIOVMFree" 
   ((addr :ppnum_t)
    (pages :UInt32)
   )
   :void
() )

(deftrap-inline "_IOMapperInsertPPNPages" 
   ((addr :ppnum_t)
    (offset :UInt32)
    (pageList (:pointer :ppnum_t))
    (pageCount :UInt32)
   )
   :void
() )

(deftrap-inline "_IOMapperInsertUPLPages" 
   ((addr :ppnum_t)
    (offset :UInt32)
    (pageList (:pointer :upl_page_info_t))
    (pageCount :UInt32)
   )
   :void
() )

; #if __cplusplus
#| |#

(require-interface "IOKit/IOService")

#||#

(require-interface "IOKit/IOMemoryDescriptor")

#|
#|class OSData;
|#
#|
 confused about CLASS IOMapper #\: public IOService #\{ OSDeclareAbstractStructors #\( IOMapper #\) #\;;  Give the platform expert access to setMapperRequired();
 friend class IOPlatformExpert #\; private #\: enum SystemMapperState #\{ kNoMapper = 0 #\, kUnknown = 1 #\, kHasMapper = 2 #\,;  Any other value is pointer to a live mapper
 kWaitMask = 3 #\, #\} #\; protected #\: void * fTable #\; ppnum_t fTablePhys #\; IOItemCount fTableSize #\; OSData * fTableHandle #\; bool fIsSystem #\; virtual bool start #\( IOService * provider #\) #\; virtual void free #\( #\) #\; static void setMapperRequired #\( bool hasMapper #\) #\; static void waitForSystemMapper #\( #\) #\; virtual bool initHardware #\( IOService * provider #\) = 0 #\; virtual bool allocTable #\( IOByteCount size #\) #\; public #\:;  Static routines capable of allocating tables that are physically
;  contiguous in real memory space.
 static OSData * NewARTTable #\( IOByteCount size #\, void ** virtAddrP #\, ppnum_t * physAddrP #\) #\; static void FreeARTTable #\( OSData * handle #\, IOByteCount size #\) #\;;  To get access to the system mapper IOMapper::gSystem 
 static IOMapper * gSystem #\; virtual ppnum_t iovmAlloc #\( IOItemCount pages #\) = 0 #\; virtual void iovmFree #\( ppnum_t addr #\, IOItemCount pages #\) = 0 #\; virtual void iovmInsert #\( ppnum_t addr #\, IOItemCount offset #\, ppnum_t page #\) = 0 #\; virtual void iovmInsert #\( ppnum_t addr #\, IOItemCount offset #\, ppnum_t * pageList #\, IOItemCount pageCount #\) #\; virtual void iovmInsert #\( ppnum_t addr #\, IOItemCount offset #\, upl_page_info_t * pageList #\, IOItemCount pageCount #\) #\; static void checkForSystemMapper #\( #\) #\{ if #\( #\( vm_address_t #\) gSystem & kWaitMask #\) waitForSystemMapper #\( #\) #\; #\} #\;;  Function will panic if the given address is not found in a valid
;  iovm mapping.
 virtual addr64_t mapAddr #\( IOPhysicalAddress addr #\) = 0 #\; private #\: OSMetaClassDeclareReservedUnused #\( IOMapper #\, 0 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 1 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 2 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 3 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 4 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 5 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 6 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 7 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 8 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 9 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 10 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 11 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 12 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 13 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 14 #\) #\; OSMetaClassDeclareReservedUnused #\( IOMapper #\, 15 #\) #\;
|#
 |#

; #endif /* __cplusplus */


; #endif /* !__IOKIT_IOMAPPER_H */


(provide-interface "IOMapper")