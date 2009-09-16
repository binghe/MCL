(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ev.h"
; at Sunday July 2,2006 7:27:45 pm.
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
;  Copyright (c) 1998 Apple Computer, Inc. All rights reserved 
; #ifndef _SYS_EV_H_
; #define _SYS_EV_H_

(require-interface "sys/appleapiopts")

(require-interface "sys/queue")
(defrecord eventreq
   (er_type :signed-long)
; #define EV_FD 1    // file descriptor
   (er_handle :signed-long)
   (er_data :pointer)
   (er_rcnt :signed-long)
   (er_wcnt :signed-long)
   (er_ecnt :signed-long)
   (er_eventbits :signed-long)
; #define EV_RE  1
; #define EV_WR  2
; #define EV_EX  4
; #define EV_RM  8
; #define EV_MASK 0xf
)

(def-mactype :er_t (find-mactype '(:pointer :eventreq)))
(defconstant $EV_RBYTES 256)
; #define EV_RBYTES 0x100
(defconstant $EV_WBYTES 512)
; #define EV_WBYTES 0x200
(defconstant $EV_RWBYTES 768)
; #define EV_RWBYTES (EV_RBYTES|EV_WBYTES)
(defconstant $EV_RCLOSED 1024)
; #define EV_RCLOSED 0x400
(defconstant $EV_RCONN 2048)
; #define EV_RCONN   0x800
(defconstant $EV_WCLOSED 4096)
; #define EV_WCLOSED 0x1000
(defconstant $EV_WCONN 8192)
; #define EV_WCONN   0x2000
(defconstant $EV_OOB 16384)
; #define EV_OOB     0x4000
(defconstant $EV_FIN 32768)
; #define EV_FIN     0x8000
(defconstant $EV_RESET 65536)
; #define EV_RESET   0x10000
(defconstant $EV_TIMEOUT 131072)
; #define EV_TIMEOUT 0x20000
(defconstant $EV_DMASK 4294967040)
; #define EV_DMASK   0xffffff00
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE

struct eventqelt {
  TAILQ_ENTRY(eventqelt)  ee_slist;
  TAILQ_ENTRY(eventqelt)  ee_plist;
  struct eventreq  ee_req;
  struct proc *    ee_proc;
  u_int            ee_flags;
#define EV_QUEUED 1
  u_int            ee_eventmask;
  struct socket   *ee_sp;
};

#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* _SYS_EV_H_ */


(provide-interface "ev")