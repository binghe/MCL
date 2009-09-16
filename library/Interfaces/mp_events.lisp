(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mp_events.h"
; at Sunday July 2,2006 7:30:31 pm.
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
; #ifndef __AT386_MP_EVENTS__
; #define	__AT386_MP_EVENTS__
;  Interrupt types 
; #ifndef ASSEMBLER

(defconstant $MP_TLB_FLUSH 0)
(defconstant $MP_CLOCK 1)
(defconstant $MP_KDP 2)
(defconstant $MP_KDB 3)
(defconstant $MP_AST 4)
(defconstant $MP_SOFTCLOCK 5)
(defconstant $MP_RENDEZVOUS 6)
(defconstant $MP_IDLE 7)
(defconstant $MP_UNIDLE 8)
(defconstant $MP_LAST 9)
(def-mactype :mp_event_t (find-mactype ':SINT32))
; #define MP_EVENT_NAME_DECL()	char *mp_event_name[] = {		"MP_TLB_FLUSH",			"MP_CLOCK",			"MP_KDP",			"MP_KDB",			"MP_AST",			"MP_SOFTCLOCK",			"MP_RENDEZVOUS",		"MP_IDLE",			"MP_UNIDLE",			"MP_LAST"		}

(defconstant $SYNC 0)
(defconstant $ASYNC 1)
(def-mactype :mp_sync_t (find-mactype ':SINT32))

(deftrap-inline "_i386_signal_cpu" 
   ((cpu :signed-long)
    (event :SInt32)
    (mode :SInt32)
   )
   nil
() )

(deftrap-inline "_i386_signal_cpus" 
   ((event :SInt32)
    (mode :SInt32)
   )
   nil
() )

(deftrap-inline "_i386_active_cpus" 
   (
   )
   :signed-long
() )

; #endif


; #endif


(provide-interface "mp_events")