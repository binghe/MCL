(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:machine_cpu.h"
; at Sunday July 2,2006 7:30:24 pm.
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
; #ifndef _I386_MACHINE_CPU_H_
; #define _I386_MACHINE_CPU_H_

(require-interface "mach/mach_types")

(require-interface "mach/boolean")

(require-interface "kern/kern_types")

(require-interface "pexpert/pexpert")

(deftrap-inline "_cpu_machine_init" 
   (
   )
   :void
() )

(deftrap-inline "_cpu_register" 
   ((ARGH (:pointer :int))
   )
   :signed-long
() )

(deftrap-inline "_cpu_start" 
   ((ARG2 :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_cpu_doshutdown" 
   (
   )
   :void
() )

(deftrap-inline "_cpu_sleep" 
   (
   )
   :void
() )

(deftrap-inline "_cpu_signal_handler" 
   ((regs (:pointer :struct))
   )
   :void
() )
#|
void cpu_pause(void)
{
	asm volatile( "rep; nop" );
|#

; #endif /* _I386_MACHINE_CPU_H_ */


(provide-interface "machine_cpu")