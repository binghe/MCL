(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:kern_control.h"
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
; #ifndef SYS_KERN_CONTROL_H
; #define SYS_KERN_CONTROL_H

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_UNSTABLE
#| #|



#define KEV_CTL_SUBCLASS 	1

#define KEV_CTL_REGISTERED     	1	
#define KEV_CTL_DEREGISTERED   	2	


struct ctl_event_data {
    u_int32_t 	ctl_id;
    u_int32_t 	ctl_unit;
};




#define CTLIOCGCOUNT	_IOR('N', 1, int)	



struct sockaddr_ctl
{
    u_char	sc_len;		
    u_char	sc_family;	
    u_int16_t 	ss_sysaddr; 	
    u_int32_t 	sc_id; 		
    u_int32_t 	sc_unit;	
    u_int32_t 	sc_reserved[5];
};
#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_UNSTABLE


typedef void * kern_ctl_ref;


#define CTL_FLAG_PRIVILEGED	0x1	


#define CTL_DATA_NOWAKEUP	0x1	



struct kern_ctl_reg
{
    
    u_int32_t	ctl_id;			
    u_int32_t	ctl_unit;		
                                        
                                        
                                        
    
    u_int32_t	ctl_flags;		
    u_int32_t	ctl_sendsize;		
    u_int32_t	ctl_recvsize;		

    

    int 	(*ctl_connect)
                    (kern_ctl_ref ctlref, void *userdata);
                                        
                                        

    void 	(*ctl_disconnect)
                    (kern_ctl_ref ctlref, void *userdata);
                                        
                                        
                    
    int 	(*ctl_write)		
                    (kern_ctl_ref ctlref, void *userdata, struct mbuf *m);
                                        
                                        
                                        
    int 	(*ctl_set)		
                    (kern_ctl_ref ctlref, void *userdata, int opt, void *data, size_t len);
                                        
                                        
                                        
                                        
                                        

    int 	(*ctl_get)
                    (kern_ctl_ref ctlref, void *userdata, int opt, void *data, size_t *len);
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        

    
    u_int32_t	ctl_reserved[4];	
};



 
int
ctl_register(struct kern_ctl_reg *userctl, void *userdata, kern_ctl_ref *ctlref);	


 
int 
ctl_deregister(kern_ctl_ref ctlref);	


 
int 
ctl_enqueuedata(kern_ctl_ref ctlref, void *data, size_t len, u_int32_t flags);


 
int 
ctl_enqueuembuf(kern_ctl_ref ctlref, struct mbuf *m, u_int32_t flags);

#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* SYS_KERN_CONTROL_H */


(provide-interface "kern_control")