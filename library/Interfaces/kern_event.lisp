(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:kern_event.h"
; at Sunday July 2,2006 7:30:14 pm.
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
;  Copyright (c) 1998, 1999 Apple Computer, Inc. All Rights Reserved 
; #ifndef SYS_KERN_EVENT_H
; #define SYS_KERN_EVENT_H

(require-interface "sys/appleapiopts")

(require-interface "sys/ioccom")

(require-interface "sys/sys_domain")
(defconstant $KEVENTS_ON 1)
; #define KEVENTS_ON  1
(defconstant $KEV_SNDSPACE 4096)
; #define KEV_SNDSPACE (4 * 1024)
(defconstant $KEV_RECVSPACE 8192)
; #define KEV_RECVSPACE (8 * 1024)
(defconstant $KEV_ANY_VENDOR 0)
; #define KEV_ANY_VENDOR    0
(defconstant $KEV_ANY_CLASS 0)
; #define KEV_ANY_CLASS     0
(defconstant $KEV_ANY_SUBCLASS 0)
; #define KEV_ANY_SUBCLASS  0
; 
;  * Vendor Code
;  
(defconstant $KEV_VENDOR_APPLE 1)
; #define KEV_VENDOR_APPLE	1
; 
;  * Definition of top-level classifications
;  
(defconstant $KEV_NETWORK_CLASS 1)
; #define KEV_NETWORK_CLASS 1
(defconstant $KEV_IOKIT_CLASS 2)
; #define KEV_IOKIT_CLASS   2
(defconstant $KEV_SYSTEM_CLASS 3)
; #define KEV_SYSTEM_CLASS  3
(defrecord kern_event_msg
   (total_size :UInt32)                         ;  Size of entire event msg 
   (vendor_code :UInt32)                        ;  For non-Apple extensibility 
   (kev_class :UInt32)
                                                ;  Layer of event source 
   (kev_subclass :UInt32)                       ;  Component within layer    
   (id :UInt32)
                                                ;  Monotonically increasing value  
   (event_code :UInt32)                         ;  unique code 
   (event_data (:array :UInt32 1))              ;  One or more data longwords      
)
(defconstant $KEV_MSG_HEADER_SIZE 24)
; #define KEV_MSG_HEADER_SIZE   (6 * sizeof(u_long))
(defrecord kev_request
   (vendor_code :UInt32)
   (kev_class :UInt32)
   (kev_subclass :UInt32)
)
; #define SIOCGKEVID	_IOR('e', 1, u_long)
; #define SIOCSKEVFILT	_IOW('e', 2, struct kev_request)
; #define SIOCGKEVFILT    _IOR('e', 3, struct kev_request)
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_UNSTABLE

#define N_KEV_VECTORS     5

struct kev_d_vectors {

     u_long	data_length;	
     void	*data_ptr;    
};     


struct kev_msg {
     u_long	       vendor_code;     
     u_long	       kev_class;	
     u_long	       kev_subclass;    
     u_long	       event_code;      
     struct kev_d_vectors  dv[N_KEV_VECTORS];      
};

int  kev_post_msg(struct kev_msg *event);

#endif
#ifdef__APPLE_API_PRIVATE

LIST_HEAD(kern_event_head, kern_event_pcb);

struct  kern_event_pcb {
     LIST_ENTRY(kern_event_pcb) ev_link;     
     struct  socket *ev_socket;     
     u_long	    vendor_code_filter;
     u_long	    class_filter;
     u_long	    subclass_filter;
};

#define sotoevpcb(so)   ((struct kern_event_pcb *)((so)->so_pcb))

#endif
#endif
|#
 |#

; #endif


(provide-interface "kern_event")