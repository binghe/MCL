(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:raw_ip6.h"
; at Sunday July 2,2006 7:31:25 pm.
; 	$FreeBSD: src/sys/netinet6/raw_ip6.h,v 1.1.2.1 2001/07/03 11:01:55 ume Exp $	
; 	$KAME: raw_ip6.h,v 1.2 2001/05/27 13:28:35 itojun Exp $	
; 
;  * Copyright (C) 2001 WIDE Project.
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
; #ifndef _NETINET6_RAW_IP6_H_
; #define _NETINET6_RAW_IP6_H_

(require-interface "sys/appleapiopts")
; 
;  * ICMPv6 stat is counted separately.  see netinet/icmp6.h
;  
(defrecord rip6stat
   (rip6s_ipackets :U_QUAD_T)
                                                ;  total input packets 
   (rip6s_isum :U_QUAD_T)
                                                ;  input checksum computations 
   (rip6s_badsum :U_QUAD_T)
                                                ;  of above, checksum error 
   (rip6s_nosock :U_QUAD_T)
                                                ;  no matching socket 
   (rip6s_nosockmcast :U_QUAD_T)
                                                ;  of above, arrived as multicast 
   (rip6s_fullsock :U_QUAD_T)
                                                ;  not delivered, input socket full 
   (rip6s_opackets :U_QUAD_T)
                                                ;  total output packets 
)
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE
extern struct rip6stat rip6stat;
#endif#endif
|#
 |#

; #endif


(provide-interface "raw_ip6")