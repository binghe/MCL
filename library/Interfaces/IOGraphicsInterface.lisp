(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOGraphicsInterface.h"
; at Sunday July 2,2006 7:29:14 pm.
; 
;  * Copyright (c) 1999-2000 Apple Computer, Inc. All rights reserved.
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
; #ifndef _IOKIT_IOGRAPHICSINTERFACE_H
; #define _IOKIT_IOGRAPHICSINTERFACE_H
; #ifdef KERNEL
#| #|
#define NO_CFPLUGIN	1
#endif
|#
 |#
; #ifndef NO_CFPLUGIN

(require-interface "IOKit/IOCFPlugIn")

; #endif /* ! NO_CFPLUGIN */

(defconstant $IOGA_COMPAT 1)
; #define IOGA_COMPAT	1

(require-interface "IOKit/graphics/IOGraphicsInterfaceTypes")
; #define kIOGraphicsAcceleratorTypeID				(CFUUIDGetConstantUUIDWithBytes(NULL,		                                0xAC, 0xCF, 0x00, 0x00,	                                0x00, 0x00,		                                0x00, 0x00,		                                0x00, 0x00,		                                0x00, 0x0a, 0x27, 0x89, 0x90, 0x4e))
;  IOGraphicsAcceleratorType objects must implement the
;  IOGraphicsAcceleratorInterface
; #define kIOGraphicsAcceleratorInterfaceID			(CFUUIDGetConstantUUIDWithBytes(NULL, 		                                0x67, 0x66, 0xE9, 0x4A,	                                0x00, 0x00,		                                0x00, 0x00,		                                0x00, 0x00,		                                0x00, 0x0a, 0x27, 0x89, 0x90, 0x4e))
;  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 

(def-mactype :IOBlitAccumulatePtr (find-mactype ':pointer)); (void * thisPointer , SInt32 a , SInt32 b , SInt32 c , SInt32 d , SInt32 e , SInt32 f)
; #ifdef IOGA_COMPAT

(def-mactype :IOBlitProcPtr (find-mactype ':pointer)); (void * thisPointer , IOOptionBits options , IOBlitType type , IOBlitSourceDestType sourceDestType , IOBlitOperation * operation , void * source , void * destination , IOBlitCompletionToken * completionToken)

; #endif


(def-mactype :IOBlitterPtr (find-mactype ':pointer)); (void * thisPointer , IOOptionBits options , IOBlitType type , IOBlitSourceType sourceType , IOBlitOperation * operation , void * source)
;  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
; #ifndef NO_CFPLUGIN
(defrecord IOGraphicsAcceleratorInterfaceStruct
#|
   (NIL :iunknown_c_guts)|#
#|
   (NIL :iocfpluginbase)|#
   (Reset (:pointer :callback))                 ;(IOReturn (void * thisPointer , IOOptionBits options))
   (CopyCapabilities (:pointer :callback))      ;(IOReturn (void * thisPointer , FourCharCode select , CFTypeRef * capabilities))
; #ifdef IOGA_COMPAT
   (GetBlitProc (:pointer :callback))           ;(IOReturn (void * thisPointer , IOOptionBits options , IOBlitType type , IOBlitSourceDestType sourceDestType , IOBlitProcPtr * blitProc))
#| 
; #else
   (__gaInterfaceReserved0 :pointer)
 |#

; #endif

   (Flush (:pointer :callback))                 ;(IOReturn (void * thisPointer , IOOptionBits options))
; #ifdef IOGA_COMPAT
   (WaitForCompletion (:pointer :callback))     ;(IOReturn (void * thisPointer , IOOptionBits options , IOBlitCompletionToken completionToken))
#| 
; #else
   (__gaInterfaceReserved1 :pointer)
 |#

; #endif

   (Synchronize (:pointer :callback))           ;(IOReturn (void * thisPointer , UInt32 options , UInt32 x , UInt32 y , UInt32 w , UInt32 h))
   (GetBeamPosition (:pointer :callback))       ;(IOReturn (void * thisPointer , IOOptionBits options , SInt32 * position))
   (AllocateSurface (:pointer :callback))       ;(IOReturn (void * thisPointer , IOOptionBits options , IOBlitSurface * surface , void * cgsSurfaceID))
   (FreeSurface (:pointer :callback))           ;(IOReturn (void * thisPointer , IOOptionBits options , IOBlitSurface * surface))
   (LockSurface (:pointer :callback))           ;(IOReturn (void * thisPointer , IOOptionBits options , IOBlitSurface * surface , vm_address_t * address))
   (UnlockSurface (:pointer :callback))         ;(IOReturn (void * thisPointer , IOOptionBits options , IOBlitSurface * surface , IOOptionBits * swapFlags))
   (SwapSurface (:pointer :callback))           ;(IOReturn (void * thisPointer , IOOptionBits options , IOBlitSurface * surface , IOOptionBits * swapFlags))
   (SetDestination (:pointer :callback))        ;(IOReturn (void * thisPointer , IOOptionBits options , IOBlitSurface * surface))
   (GetBlitter (:pointer :callback))            ;(IOReturn (void * thisPointer , IOOptionBits options , IOBlitType type , IOBlitSourceType sourceType , IOBlitterPtr * blitter))
   (WaitComplete (:pointer :callback))          ;(IOReturn (void * thisPointer , IOOptionBits options))
   (__gaInterfaceReserved (:array :pointer 24))
)
(%define-record :IOGraphicsAcceleratorInterface (find-record-descriptor :IOGRAPHICSACCELERATORINTERFACESTRUCT))

; #endif /* ! NO_CFPLUGIN */

;  Helper function for plugin use 

(deftrap-inline "_IOAccelFindAccelerator" 
   ((framebuffer :pointer)
    (pAccelerator (:pointer :io_service_t))
    (pFramebufferIndex (:pointer :UInt32))
   )
   :signed-long
() )
;  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 

; #endif /* !_IOKIT_IOGRAPHICSINTERFACE_H */


(provide-interface "IOGraphicsInterface")