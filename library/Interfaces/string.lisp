(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:string.h"
; at Sunday July 2,2006 7:22:59 pm.
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
; 
;  * @OSF_COPYRIGHT@
;  
; 
;  * HISTORY
;  * 
;  * Revision 1.1.1.1  1998/09/22 21:05:51  wsanchez
;  * Import of Mac OS X kernel (~semeria)
;  *
;  * Revision 1.1.1.1  1998/03/07 02:25:35  wsanchez
;  * Import of OSF Mach kernel (~mburg)
;  *
;  * Revision 1.1.4.1  1997/02/21  15:43:21  barbou
;  * 	Removed "size_t" definition, include "types.h" instead.
;  * 	[1997/02/21  15:36:54  barbou]
;  *
;  * Revision 1.1.2.4  1996/10/10  14:13:33  emcmanus
;  * 	Added memmove() prototype.
;  * 	[1996/10/10  14:11:51  emcmanus]
;  * 
;  * Revision 1.1.2.3  1996/10/07  07:20:26  paire
;  * 	Added strncat() prototype, since it is defined in libsa_mach.
;  * 	[96/10/07            paire]
;  * 
;  * Revision 1.1.2.2  1996/10/04  11:36:07  emcmanus
;  * 	Added strspn() prototype, since it is defined in libsa_mach.
;  * 	[1996/10/04  11:31:57  emcmanus]
;  * 
;  * Revision 1.1.2.1  1996/09/17  16:56:15  bruel
;  * 	created for standalone mach servers.
;  * 	[96/09/17            bruel]
;  * 
;  * $EndLog$
;  
; #ifndef	_MACH_STRING_H_
(defconstant $_MACH_STRING_H_ 1)
; #define	_MACH_STRING_H_	1
; #ifdef MACH_KERNEL_PRIVATE
#| #|
#include <types.h>
|#
 |#

; #else

(require-interface "sys/types")

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #ifndef	NULL
; #define NULL	0

; #endif


(deftrap-inline "_memcpy" 
   ((ARGH :pointer)
    (ARGH :pointer)
    (ARG2 :unsigned-long)
   )
   (:pointer :void)
() )

(deftrap-inline "_memmove" 
   ((ARGH :pointer)
    (ARGH :pointer)
    (ARG2 :unsigned-long)
   )
   (:pointer :void)
() )

(deftrap-inline "_memset" 
   ((ARGH :pointer)
    (ARG2 :signed-long)
    (ARG2 :unsigned-long)
   )
   (:pointer :void)
() )

(deftrap-inline "_strlen" 
   ((ARGH (:pointer :char))
   )
   :unsigned-long
() )

(deftrap-inline "_strcpy" 
   ((ARGH (:pointer :char))
    (ARGH (:pointer :char))
   )
   (:pointer :character)
() )

(deftrap-inline "_strncpy" 
   ((ARGH (:pointer :char))
    (ARGH (:pointer :char))
    (ARG2 :unsigned-long)
   )
   (:pointer :character)
() )

(deftrap-inline "_strcat" 
   ((ARGH (:pointer :char))
    (ARGH (:pointer :char))
   )
   (:pointer :character)
() )

(deftrap-inline "_strncat" 
   ((ARGH (:pointer :char))
    (ARGH (:pointer :char))
    (ARG2 :unsigned-long)
   )
   (:pointer :character)
() )

(deftrap-inline "_strcmp" 
   ((ARGH (:pointer :char))
    (ARGH (:pointer :char))
   )
   :signed-long
() )

(deftrap-inline "_strncmp" 
   ((ARGH (:pointer :char))
    (ARGH (:pointer :char))
    (ARG2 :unsigned-long)
   )
   :signed-long
() )

(deftrap-inline "_strchr" 
   ((s (:pointer :char))
    (c :signed-long)
   )
   (:pointer :character)
() )

(deftrap-inline "_strspn" 
   ((ARGH (:pointer :char))
    (ARGH (:pointer :char))
   )
   :unsigned-long
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif	/* _MACH_STRING_H_ */


(provide-interface "string")