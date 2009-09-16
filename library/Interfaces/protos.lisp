(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:protos.h"
; at Sunday July 2,2006 7:31:17 pm.
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
; #ifndef _PEXPERT_I386_PROTOS_H
; #define _PEXPERT_I386_PROTOS_H
; ------------------------------------------------------------------------
;  x86 IN/OUT I/O inline functions.
; 
;  IN :  inb, inw, inl
;        IN(port)
; 
;  OUT:  outb, outw, outl
;        OUT(port, data)

(def-mactype :i386_ioport_t (find-mactype ':UInt16))
; #define __IN(s, u) static __inline__ unsigned u in##s(i386_ioport_t port) {     unsigned u data;     asm volatile (         "in" #s " %1,%0"         : "=a" (data)         : "d" (port));     return (data); }
; #define __OUT(s, u) static __inline__ void out##s(i386_ioport_t port, unsigned u data) {     asm volatile (         "out" #s " %1,%0"         :         : "d" (port), "a" (data)); }
#|
 confused about __IN __IN #\( w #\, short #\) __IN #\( l #\, long #\) __OUT #\( b #\, char #\) __OUT #\( w #\, short #\) __OUT #\( l #\, long #\) extern void cninit #\( void #\)
|#

(deftrap-inline "_bcopy" 
   ((from :pointer)
    (to :pointer)
    (size :signed-long)
   )
   nil
() )

(deftrap-inline "_sprintf" 
   ((str (:pointer :char))
    (format (:pointer :char))
#| |...|  ;; What should this do?
    |#
   )
   :signed-long
() )
; ------------------------------------------------------------------------
;  from osfmk/console/panic_dialog.c

(deftrap-inline "_panic_ui_initialize" 
   ((clut (:pointer :UInt8))
   )
   nil
() )
; ------------------------------------------------------------------------
;  from osfmk/i386/AT386/video_console.c

(deftrap-inline "_vc_progress_initialize" 
   ((desc :pointer)
    (data (:pointer :UInt8))
    (clut (:pointer :UInt8))
   )
   nil
() )

(deftrap-inline "_vc_display_icon" 
   ((desc :pointer)
    (data (:pointer :UInt8))
   )
   nil
() )

; #endif /* _PEXPERT_I386_PROTOS_H */


(provide-interface "protos")