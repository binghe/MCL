(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:setjmp.h"
; at Sunday July 2,2006 7:22:57 pm.
; 
;  * Copyright (c) 2000-2002 Apple Computer, Inc. All rights reserved.
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
;  Copyright (c) 1992 NeXT Computer, Inc.  All rights reserved.
;  *
;  *	File:	setjmp.h
;  *
;  *	Declaration of setjmp routines and data structures.
;  
; #ifndef _BSD_I386_SETJMP_H
; #define _BSD_I386_SETJMP_H

(require-interface "sys/cdefs")

(require-interface "i386/signal")
(defrecord jmp_buf
   (contents (:array :sigcontext 1))
)
#|
; Warning: type-size: unknown type sigcontext
|#
#|
; Warning: type-size: unknown type SIGCONTEXT
|#
(defconstant $_JBLEN 1)
; #define _JBLEN ((sizeof(struct sigcontext)) / sizeof(int))
(defrecord sigjmp_buf
   (contents (:array :signed-long 2))
)
#|
 confused about __P #\( #\( jmp_buf env #\) #\)
|#
#|
 confused about __P #\( #\( jmp_buf env #\, int val #\) #\)
|#
; #ifndef _ANSI_SOURCE
#|
 confused about __P #\( #\( sigjmp_buf env #\, int val #\) #\)
|#
#|
 confused about __P #\( #\( sigjmp_buf env #\, int val #\) #\)
|#

; #endif /* _ANSI_SOURCE  */


; #if !defined(_ANSI_SOURCE) && !defined(_POSIX_SOURCE)
#|
 confused about __P #\( #\( jmp_buf env #\) #\)
|#
#|
 confused about __P #\( #\( jmp_buf #\, int val #\) #\)
|#
#|
 confused about __P #\( #\( void #\) #\)
|#

; #endif /* neither ANSI nor POSIX */


; #endif /* !_BSD_I386_SETJMP_H */


(provide-interface "setjmp")