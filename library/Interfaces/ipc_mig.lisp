(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ipc_mig.h"
; at Sunday July 2,2006 7:30:08 pm.
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
; #ifndef	_IPC_MIG_H_
; #define	_IPC_MIG_H_

(require-interface "mach/mig")

(require-interface "mach/message")

(require-interface "sys/kdebug")
; 
;  * Define the trace points for MIG-generated calls.  One traces the input parameters
;  * to MIG called things, another traces the outputs, and one traces bad message IDs.
;  
; #ifdef _MIG_TRACE_PARAMETERS_
#| #|

#define __BeforeRcvCallTrace(msgid,arg1,arg2,arg3,arg4)				      \
	KERNEL_DEBUG_CONSTANT(KDBG_MIGCODE(msgid) | DBG_FUNC_START,		      \
			      (unsigned int)(arg1),				      \
			      (unsigned int)(arg2),				      \
			      (unsigned int)(arg3),				      \
			      (unsigned int)(arg4),				      \
			      (unsigned int)(0));

#define __AfterRcvCallTrace(msgid,arg1,arg2,arg3,arg4)				      \
	KERNEL_DEBUG_CONSTANT(KDBG_MIGCODE(msgid) | DBG_FUNC_END,		      \
			      (unsigned int)(arg1),				      \
			      (unsigned int)(arg2),				      \
			      (unsigned int)(arg3),				      \
			      (unsigned int)(arg4),				      \
			      (unsigned int)(0));

#define __BeforeSimpleCallTrace(msgid,arg1,arg2,arg3,arg4)			      \
	KERNEL_DEBUG_CONSTANT(KDBG_MIGCODE(msgid) | DBG_FUNC_START,		      \
			      (unsigned int)(arg1),				      \
			      (unsigned int)(arg2),				      \
			      (unsigned int)(arg3),				      \
			      (unsigned int)(arg4),				      \
			      (unsigned int)(0));

#define __AfterSimpleCallTrace(msgid,arg1,arg2,arg3,arg4)			      \
	KERNEL_DEBUG_CONSTANT(KDBG_MIGCODE(msgid) | DBG_FUNC_END,		      \
			      (unsigned int)(arg1),				      \
			      (unsigned int)(arg2),				      \
			      (unsigned int)(arg3),				      \
			      (unsigned int)(arg4),				      \
			      (unsigned int)(0));

|#
 |#

; #else /* !_MIG_TRACE_PARAMETERS_ */
; #define	__BeforeRcvRpc(msgid, _NAME_)						      	KERNEL_DEBUG_CONSTANT(KDBG_MIGCODE(msgid) | DBG_FUNC_START,		      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0));
; #define	__AfterRcvRpc(msgid, _NAME_)						      	KERNEL_DEBUG_CONSTANT(KDBG_MIGCODE(msgid) | DBG_FUNC_END,		      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0));
; #define	__BeforeRcvSimple(msgid, _NAME_)					      	KERNEL_DEBUG_CONSTANT(KDBG_MIGCODE(msgid) | DBG_FUNC_START,		      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0));
; #define	__AfterRcvSimple(msgid, _NAME_)						      	KERNEL_DEBUG_CONSTANT(KDBG_MIGCODE(msgid) | DBG_FUNC_END,		      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0));

; #endif /* !_MIG_TRACE_PARAMETERS_ */

; #define _MIG_MSGID_INVALID(msgid)						      	KERNEL_DEBUG_CONSTANT(MACHDBG_CODE(DBG_MACH_MSGID_INVALID, (msgid)),          			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0),				      			      (unsigned int)(0))
;  Send a message from the kernel 

(deftrap-inline "_mach_msg_send_from_kernel" 
   ((msg (:pointer :MACH_MSG_HEADER_T))
    (send_size :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_mach_msg_rpc_from_kernel" 
   ((msg (:pointer :MACH_MSG_HEADER_T))
    (send_size :UInt32)
    (rcv_size :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_mach_msg_receive_continue" 
   (
   )
   nil
() )

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_EVOLVING
#| #|


typedef struct mig_object {
			IMIGObjectVtbl		*pVtbl; 
			mach_port_t		port;	 
} mig_object_data_t;



typedef struct mig_notify_object {
			IMIGNotifyObjectVtbl	*pVtbl; 
			mach_port_t		port;	 
} mig_notify_object_data_t;

#endif
|#
 |#
;  __APPLE_API_EVOLVING 

; #endif	/* _IPC_MIG_H_ */


(provide-interface "ipc_mig")