(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:fb_entries.h"
; at Sunday July 2,2006 7:27:51 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
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
; #ifndef _I386_FD_ENTRIES_H_
; #define _I386_FD_ENTRIES_H_

(require-interface "mach/boolean")
;  test for presence of linear framebuffer 

(deftrap-inline "_fb_present" 
   (
   )
   :signed-long
() )
;  initialize framebuffer 

(deftrap-inline "_fb_init" 
   (
   )
   nil
() )
;  prepare for reboot 

(deftrap-inline "_fb_reset" 
   (
   )
   nil
() )

; #endif /* _I386_FD_ENTRIES_H_ */


(provide-interface "fb_entries")