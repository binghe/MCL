(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:keysock.h"
; at Sunday July 2,2006 7:30:16 pm.
; 	$KAME: keysock.h,v 1.7 2000/03/25 07:24:14 sumikawa Exp $	
; 
;  * Copyright (C) 1995, 1996, 1997, and 1998 WIDE Project.
;  * All rights reserved.
;  *
;  * Redistribution and use in source and binary forms, with or without
;  * modification, are permitted provided that the following conditions
;  * are met:
;  * 1. Redistributions of source code must retain the above copyright
;  *    notice, this list of conditions and the following disclaimer.
;  * 2. Redistributions in binary form must reproduce the above copyright
;  *    notice, this list of conditions and the following disclaimer in the
;  *    documentation and/or other materials provided with the distribution.
;  * 3. Neither the name of the project nor the names of its contributors
;  *    may be used to endorse or promote products derived from this software
;  *    without specific prior written permission.
;  *
;  * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
;  * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;  * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
;  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
;  * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;  * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
;  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
;  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
;  * SUCH DAMAGE.
;  
; #ifndef _NETKEY_KEYSOCK_H_
; #define _NETKEY_KEYSOCK_H_

(require-interface "sys/appleapiopts")
;  statistics for pfkey socket 
(defrecord pfkeystat
                                                ;  kernel -> userland 
   (out_total :U_QUAD_T)
                                                ;  # of total calls 
   (out_bytes :U_QUAD_T)
                                                ;  total bytecount 
   (out_msgtype (:array :U_QUAD_T 256))
#|
; Warning: type-size: unknown type u_quad_t
|#
                                                ;  message type histogram 
   (out_invlen :U_QUAD_T)
                                                ;  invalid length field 
   (out_invver :U_QUAD_T)
                                                ;  invalid version field 
   (out_invmsgtype :U_QUAD_T)
                                                ;  invalid message type field 
   (out_tooshort :U_QUAD_T)
                                                ;  msg too short 
   (out_nomem :U_QUAD_T)
                                                ;  memory allocation failure 
   (out_dupext :U_QUAD_T)
                                                ;  duplicate extension 
   (out_invexttype :U_QUAD_T)
                                                ;  invalid extension type 
   (out_invsatype :U_QUAD_T)
                                                ;  invalid sa type 
   (out_invaddr :U_QUAD_T)
                                                ;  invalid address extension 
                                                ;  userland -> kernel 
   (in_total :U_QUAD_T)
                                                ;  # of total calls 
   (in_bytes :U_QUAD_T)
                                                ;  total bytecount 
   (in_msgtype (:array :U_QUAD_T 256))
#|
; Warning: type-size: unknown type u_quad_t
|#
                                                ;  message type histogram 
   (in_msgtarget (:array :U_QUAD_T 3))
#|
; Warning: type-size: unknown type u_quad_t
|#
                                                ;  one/all/registered 
   (in_nomem :U_QUAD_T)
                                                ;  memory allocation failure 
                                                ;  others 
   (sockerr :U_QUAD_T)
                                                ;  # of socket related errors 
)
(defconstant $KEY_SENDUP_ONE 0)
; #define KEY_SENDUP_ONE		0
(defconstant $KEY_SENDUP_ALL 1)
; #define KEY_SENDUP_ALL		1
(defconstant $KEY_SENDUP_REGISTERED 2)
; #define KEY_SENDUP_REGISTERED	2
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE
struct keycb {
	struct rawcb kp_raw;	
	int kp_promisc;		
	int kp_registered;	
};

extern struct pfkeystat pfkeystat;

#ifdef__APPLE__
extern int key_output __P((struct mbuf *, struct socket* so));
#elseextern int key_output __P((struct mbuf *, ...));
#endifextern int key_usrreq __P((struct socket *,
	int, struct mbuf *, struct mbuf *, struct mbuf *));

extern int key_sendup __P((struct socket *, struct sadb_msg *, u_int, int));
extern int key_sendup_mbuf __P((struct socket *, struct mbuf *, int));
#endif
#endif
|#
 |#
;  KERNEL 

; #endif /*_NETKEY_KEYSOCK_H_*/


(provide-interface "keysock")