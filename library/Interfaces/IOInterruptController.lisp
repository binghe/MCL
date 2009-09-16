(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOInterruptController.h"
; at Sunday July 2,2006 7:28:45 pm.
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
;  *  DRI: Josh de Cesare
;  *  
;  
; #ifndef _IOKIT_IOINTERRUPTCONTROLLER_H
; #define _IOKIT_IOINTERRUPTCONTROLLER_H

(require-interface "IOKit/IOLocks")

(require-interface "IOKit/IOService")

(require-interface "IOKit/IOInterrupts")

#|class IOSharedInterruptController;
|#
(defrecord IOInterruptVector
   (interruptActive :character)
   (interruptDisabledSoft :character)
   (interruptDisabledHard :character)
   (interruptRegistered :character)
   (interruptLock (:pointer :IOLock))
   (nub (:pointer :ioservice))
   (source :signed-long)
   (target :pointer)
   (handler :pointer)
   (refCon :pointer)
   (sharedController (:pointer :iosharedinterruptcontroller))
)

;type name? (%define-record :IOInterruptVector (find-record-descriptor ':IOInterruptVector))
#|
 confused about CLASS IOInterruptController #\: public IOService #\{ OSDeclareAbstractStructors #\( IOInterruptController #\) #\; protected #\: IOInterruptVector * vectors #\; IOSimpleLock * controllerLock #\; struct ExpansionData #\{ #\} #\; ExpansionData * reserved #\; public #\: virtual IOReturn registerInterrupt #\( IOService * nub #\, int source #\, void * target #\, IOInterruptHandler handler #\, void * refCon #\) #\; virtual IOReturn unregisterInterrupt #\( IOService * nub #\, int source #\) #\; virtual IOReturn getInterruptType #\( IOService * nub #\, int source #\, int * interruptType #\) #\; virtual IOReturn enableInterrupt #\( IOService * nub #\, int source #\) #\; virtual IOReturn disableInterrupt #\( IOService * nub #\, int source #\) #\; virtual IOReturn causeInterrupt #\( IOService * nub #\, int source #\) #\; virtual IOInterruptAction getInterruptHandlerAddress #\( void #\) #\; virtual IOReturn handleInterrupt #\( void * refCon #\, IOService * nub #\, int source #\) #\;;  Methods to be overridden for simplifed interrupt controller subclasses.
 virtual bool vectorCanBeShared #\( long vectorNumber #\, IOInterruptVector * vector #\) #\; virtual void initVector #\( long vectorNumber #\, IOInterruptVector * vector #\) #\; virtual int getVectorType #\( long vectorNumber #\, IOInterruptVector * vector #\) #\; virtual void disableVectorHard #\( long vectorNumber #\, IOInterruptVector * vector #\) #\; virtual void enableVector #\( long vectorNumber #\, IOInterruptVector * vector #\) #\; virtual void causeVector #\( long vectorNumber #\, IOInterruptVector * vector #\) #\; OSMetaClassDeclareReservedUnused #\( IOInterruptController #\, 0 #\) #\; OSMetaClassDeclareReservedUnused #\( IOInterruptController #\, 1 #\) #\; OSMetaClassDeclareReservedUnused #\( IOInterruptController #\, 2 #\) #\; OSMetaClassDeclareReservedUnused #\( IOInterruptController #\, 3 #\) #\; OSMetaClassDeclareReservedUnused #\( IOInterruptController #\, 4 #\) #\; OSMetaClassDeclareReservedUnused #\( IOInterruptController #\, 5 #\) #\;
|#
#|
 confused about CLASS IOSharedInterruptController #\: public IOInterruptController #\{ OSDeclareDefaultStructors #\( IOSharedInterruptController #\) #\; private #\: IOService * provider #\; int numVectors #\; int vectorsRegistered #\; int vectorsEnabled #\; volatile long controllerDisabled #\; bool sourceIsLevel #\; struct ExpansionData #\{ #\} #\; ExpansionData * reserved #\; public #\: virtual IOReturn initInterruptController #\( IOInterruptController * parentController #\, OSData * parentSource #\) #\; virtual IOReturn registerInterrupt #\( IOService * nub #\, int source #\, void * target #\, IOInterruptHandler handler #\, void * refCon #\) #\; virtual IOReturn unregisterInterrupt #\( IOService * nub #\, int source #\) #\; virtual IOReturn getInterruptType #\( IOService * nub #\, int source #\, int * interruptType #\) #\; virtual IOReturn enableInterrupt #\( IOService * nub #\, int source #\) #\; virtual IOReturn disableInterrupt #\( IOService * nub #\, int source #\) #\; virtual IOInterruptAction getInterruptHandlerAddress #\( void #\) #\; virtual IOReturn handleInterrupt #\( void * refCon #\, IOService * nub #\, int source #\) #\; OSMetaClassDeclareReservedUnused #\( IOSharedInterruptController #\, 0 #\) #\; OSMetaClassDeclareReservedUnused #\( IOSharedInterruptController #\, 1 #\) #\; OSMetaClassDeclareReservedUnused #\( IOSharedInterruptController #\, 2 #\) #\; OSMetaClassDeclareReservedUnused #\( IOSharedInterruptController #\, 3 #\) #\;
|#

; #endif /* ! _IOKIT_IOINTERRUPTCONTROLLER_H */


(provide-interface "IOInterruptController")