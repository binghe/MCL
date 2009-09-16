(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:system.h"
; at Sunday July 2,2006 7:25:43 pm.
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
; #ifndef __IOKIT_SYSTEM_H
; #define __IOKIT_SYSTEM_H

(require-interface "sys/cdefs")

(require-interface "mach/mach_types")

(require-interface "mach/mach_interface")

(require-interface "mach/etap")

(require-interface "mach/etap_events")

(require-interface "stdarg")

; #if KERNEL_PRIVATE
#| |#

(require-interface "IOKit/assert")

#||#

(require-interface "kern/cpu_data")

#||#

(require-interface "kern/thread")

#||#

(require-interface "kern/thread_act")

#||#

(require-interface "vm/pmap")

#||#

(require-interface "vm/vm_kern")

#||#

(require-interface "kern/kalloc")

#||#

(require-interface "kern/task")

#||#

(require-interface "kern/time_out")

#||#

(require-interface "kern/sched_prim")

#||#

(require-interface "machine/spl")

#||#

(require-interface "kern/lock")

#||#

(require-interface "kern/queue")

#||#

(require-interface "kern/ipc_mig")

#|
 |#

; #endif /* KERNEL_PRIVATE */


(deftrap-inline "_bcmp" 
   ((ARGH :pointer)
    (ARGH :pointer)
    (ARG2 :unsigned-long)
   )
   :signed-long
() )

(deftrap-inline "_bcopy" 
   ((ARGH :pointer)
    (ARGH :pointer)
    (ARG2 :unsigned-long)
   )
   nil
() )

(deftrap-inline "_bzero" 
   ((ARGH :pointer)
    (ARG2 :unsigned-long)
   )
   nil
() )

(deftrap-inline "_memcmp" 
   ((ARGH :pointer)
    (ARGH :pointer)
    (ARG2 :unsigned-long)
   )
   :signed-long
() )

(deftrap-inline "__doprnt" 
   ((format (:pointer :char))
    (arg (:pointer :VA_LIST))
    (putc (:pointer :callback))                 ;(void (char))

    (radix :signed-long)
   )
   nil
() )

(deftrap-inline "_sscanf" 
   ((input (:pointer :char))
    (fmt (:pointer :char))
#| |...|  ;; What should this do?
    |#
   )
   :signed-long
() )

(deftrap-inline "_sprintf" 
   ((s (:pointer :char))
    (format (:pointer :char))
#| |...|  ;; What should this do?
    |#
   )
   :signed-long
() )

(deftrap-inline "_strtol" 
   ((ARGH (:pointer :char))
    (ARGH (:pointer :char))
    (ARG2 :signed-long)
   )
   :SInt32
() )

(deftrap-inline "_strtoul" 
   ((ARGH (:pointer :char))
    (ARGH (:pointer :char))
    (ARG2 :signed-long)
   )
   :UInt32
() )

(deftrap-inline "_strtoq" 
   ((returnArg (:pointer :wide))
    (ARGH (:pointer :char))
    (ARGH (:pointer :char))
    (ARG2 :signed-long)
   )
   nil
() )

(deftrap-inline "_strtouq" 
   ((returnArg (:pointer :UnsignedWide))
    (ARGH (:pointer :char))
    (ARGH (:pointer :char))
    (ARG2 :signed-long)
   )
   nil
() )
; #ifdef __GNUC__
#| #|
volatile
#endif
|#
 |#

(deftrap-inline "_panic" 
   ((msg (:pointer :char))
#| |...|  ;; What should this do?
    |#
   )
   nil
() )
; 
;  
; 
;  * Really need a set of interfaces from osfmk/pexpert components to do
;  * all that is required to prepare an I/O from a cache management point
;  * of view.
;  * osfmk/ppc/cache.s
;  

(deftrap-inline "_invalidate_icache" 
   ((addr :UInt32)
    (cnt :UInt32)
    (phys :signed-long)
   )
   nil
() )

(deftrap-inline "_flush_dcache" 
   ((addr :UInt32)
    (count :UInt32)
    (phys :signed-long)
   )
   nil
() )

(deftrap-inline "_invalidate_icache64" 
   ((addr :addr64_t)
    (cnt :UInt32)
    (phys :signed-long)
   )
   nil
() )

(deftrap-inline "_flush_dcache64" 
   ((addr :addr64_t)
    (count :UInt32)
    (phys :signed-long)
   )
   nil
() )

; #endif /* !__IOKIT_SYSTEM_H */


(provide-interface "system")