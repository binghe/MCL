(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:message.h"
; at Sunday July 2,2006 7:24:13 pm.
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
; 
;  * @OSF_COPYRIGHT@
;  
;  
;  * Mach Operating System
;  * Copyright (c) 1991,1990,1989,1988,1987 Carnegie Mellon University
;  * All Rights Reserved.
;  * 
;  * Permission to use, copy, modify and distribute this software and its
;  * documentation is hereby granted, provided that both the copyright
;  * notice and this permission notice appear in all copies of the
;  * software, derivative works or modified versions, and any portions
;  * thereof, and that both notices appear in supporting documentation.
;  * 
;  * CARNEGIE MELLON ALLOWS FREE USE OF THIS SOFTWARE IN ITS "AS IS"
;  * CONDITION.  CARNEGIE MELLON DISCLAIMS ANY LIABILITY OF ANY KIND FOR
;  * ANY DAMAGES WHATSOEVER RESULTING FROM THE USE OF THIS SOFTWARE.
;  * 
;  * Carnegie Mellon requests users of this software to return to
;  * 
;  *  Software Distribution Coordinator  or  Software.Distribution@CS.CMU.EDU
;  *  School of Computer Science
;  *  Carnegie Mellon University
;  *  Pittsburgh PA 15213-3890
;  * 
;  * any improvements or extensions that they make and grant Carnegie Mellon
;  * the rights to redistribute these changes.
;  
; 
;  
; 
;  *	File:	mach/message.h
;  *
;  *	Mach IPC message and primitive function definitions.
;  
; #ifndef	_MACH_MESSAGE_H_
; #define _MACH_MESSAGE_H_
; #ifdef	MACH_KERNEL
#| #|

#define TypeCheck 1
#define _MIG_KERNEL_SPECIFIC_CODE_ 1
#endif
|#
 |#
;  MACH_KERNEL 
;  static templates are slower and bigger 
;  #define UseStaticTemplates 0 

(require-interface "sys/appleapiopts")

(require-interface "stdint")

(require-interface "mach/port")

(require-interface "mach/boolean")

(require-interface "mach/kern_return")

(require-interface "mach/machine/vm_types")
; 
;  *  The timeout mechanism uses mach_msg_timeout_t values,
;  *  passed by value.  The timeout units are milliseconds.
;  *  It is controlled with the MACH_SEND_TIMEOUT
;  *  and MACH_RCV_TIMEOUT options.
;  

(def-mactype :mach_msg_timeout_t (find-mactype ':UInt32))
; 
;  *  The value to be used when there is no timeout.
;  *  (No MACH_SEND_TIMEOUT/MACH_RCV_TIMEOUT option.)
;  
(defconstant $MACH_MSG_TIMEOUT_NONE 0)
; #define MACH_MSG_TIMEOUT_NONE		((mach_msg_timeout_t) 0)
; 
;  *  The kernel uses MACH_MSGH_BITS_COMPLEX as a hint.  It it isn't on, it
;  *  assumes the body of the message doesn't contain port rights or OOL
;  *  data.  The field is set in received messages.  A user task must
;  *  use caution in interpreting the body of a message if the bit isn't
;  *  on, because the mach_msg_type's in the body might "lie" about the
;  *  contents.  If the bit isn't on, but the mach_msg_types
;  *  in the body specify rights or OOL data, the behavior is undefined.
;  *  (Ie, an error may or may not be produced.)
;  *
;  *  The value of MACH_MSGH_BITS_REMOTE determines the interpretation
;  *  of the msgh_remote_port field.  It is handled like a msgt_name.
;  *
;  *  The value of MACH_MSGH_BITS_LOCAL determines the interpretation
;  *  of the msgh_local_port field.  It is handled like a msgt_name.
;  *
;  *  MACH_MSGH_BITS() combines two MACH_MSG_TYPE_* values, for the remote
;  *  and local fields, into a single value suitable for msgh_bits.
;  *
;  *  MACH_MSGH_BITS_CIRCULAR should be zero; is is used internally.
;  *
;  *  The unused bits should be zero and are reserved for the kernel
;  *  or for future interface expansion.
;  
(defconstant $MACH_MSGH_BITS_ZERO 0)
; #define MACH_MSGH_BITS_ZERO		0x00000000
(defconstant $MACH_MSGH_BITS_REMOTE_MASK 255)
; #define MACH_MSGH_BITS_REMOTE_MASK	0x000000ff
(defconstant $MACH_MSGH_BITS_LOCAL_MASK 65280)
; #define MACH_MSGH_BITS_LOCAL_MASK	0x0000ff00
(defconstant $MACH_MSGH_BITS_COMPLEX 2147483648)
; #define MACH_MSGH_BITS_COMPLEX		0x80000000U
(defconstant $MACH_MSGH_BITS_USER 2147549183)
; #define MACH_MSGH_BITS_USER             0x8000ffffU
(defconstant $MACH_MSGH_BITS_CIRCULAR 1073741824)
; #define	MACH_MSGH_BITS_CIRCULAR		0x40000000	/* internal use only */
(defconstant $MACH_MSGH_BITS_USED 3221291007)
; #define	MACH_MSGH_BITS_USED		0xc000ffffU
(defconstant $MACH_MSGH_BITS_PORTS_MASK 65535)
; #define	MACH_MSGH_BITS_PORTS_MASK						(MACH_MSGH_BITS_REMOTE_MASK|MACH_MSGH_BITS_LOCAL_MASK)
; #define MACH_MSGH_BITS(remote, local)						((remote) | ((local) << 8))
; #define	MACH_MSGH_BITS_REMOTE(bits)						((bits) & MACH_MSGH_BITS_REMOTE_MASK)
; #define	MACH_MSGH_BITS_LOCAL(bits)						(((bits) & MACH_MSGH_BITS_LOCAL_MASK) >> 8)
; #define	MACH_MSGH_BITS_PORTS(bits)						((bits) & MACH_MSGH_BITS_PORTS_MASK)
; #define	MACH_MSGH_BITS_OTHER(bits)						((bits) &~ MACH_MSGH_BITS_PORTS_MASK)
; 
;  *  Every message starts with a message header.
;  *  Following the message header are zero or more pairs of
;  *  type descriptors (mach_msg_type_t/mach_msg_type_long_t) and
;  *  data values.  The size of the message must be specified in bytes,
;  *  and includes the message header, type descriptors, inline
;  *  data, and inline pointer for out-of-line data.
;  *
;  *  The msgh_remote_port field specifies the destination of the message.
;  *  It must specify a valid send or send-once right for a port.
;  *
;  *  The msgh_local_port field specifies a "reply port".  Normally,
;  *  This field carries a send-once right that the receiver will use
;  *  to reply to the message.  It may carry the values MACH_PORT_NULL,
;  *  MACH_PORT_DEAD, a send-once right, or a send right.
;  *
;  *  The msgh_seqno field carries a sequence number associated with the
;  *  received-from port.  A port's sequence number is incremented every
;  *  time a message is received from it.  In sent messages, the field's
;  *  value is ignored.
;  *
;  *  The msgh_id field is uninterpreted by the message primitives.
;  *  It normally carries information specifying the format
;  *  or meaning of the message.
;  

(def-mactype :mach_msg_bits_t (find-mactype ':UInt32))

(def-mactype :mach_msg_size_t (find-mactype ':UInt32))

(def-mactype :mach_msg_id_t (find-mactype ':signed-long))
; #define MACH_MSG_SIZE_NULL (mach_msg_size_t *) 0

(def-mactype :mach_msg_type_name_t (find-mactype ':UInt32))
(defconstant $MACH_MSG_TYPE_MOVE_RECEIVE 16)
; #define MACH_MSG_TYPE_MOVE_RECEIVE	16	/* Must hold receive rights */
(defconstant $MACH_MSG_TYPE_MOVE_SEND 17)
; #define MACH_MSG_TYPE_MOVE_SEND		17	/* Must hold send rights */
(defconstant $MACH_MSG_TYPE_MOVE_SEND_ONCE 18)
; #define MACH_MSG_TYPE_MOVE_SEND_ONCE	18	/* Must hold sendonce rights */
(defconstant $MACH_MSG_TYPE_COPY_SEND 19)
; #define MACH_MSG_TYPE_COPY_SEND		19	/* Must hold send rights */
(defconstant $MACH_MSG_TYPE_MAKE_SEND 20)
; #define MACH_MSG_TYPE_MAKE_SEND		20	/* Must hold receive rights */
(defconstant $MACH_MSG_TYPE_MAKE_SEND_ONCE 21)
; #define MACH_MSG_TYPE_MAKE_SEND_ONCE	21	/* Must hold receive rights */
(defconstant $MACH_MSG_TYPE_COPY_RECEIVE 22)
; #define MACH_MSG_TYPE_COPY_RECEIVE	22	/* Must hold receive rights */

(def-mactype :mach_msg_copy_options_t (find-mactype ':UInt32))
(defconstant $MACH_MSG_PHYSICAL_COPY 0)
; #define MACH_MSG_PHYSICAL_COPY		0
(defconstant $MACH_MSG_VIRTUAL_COPY 1)
; #define MACH_MSG_VIRTUAL_COPY   	1
(defconstant $MACH_MSG_ALLOCATE 2)
; #define MACH_MSG_ALLOCATE		2
(defconstant $MACH_MSG_OVERWRITE 3)
; #define MACH_MSG_OVERWRITE		3
; #ifdef  MACH_KERNEL
#| #|
#define MACH_MSG_KALLOC_COPY_T		4
#endif
|#
 |#
;  MACH_KERNEL 

(def-mactype :mach_msg_descriptor_type_t (find-mactype ':UInt32))
(defconstant $MACH_MSG_PORT_DESCRIPTOR 0)
; #define MACH_MSG_PORT_DESCRIPTOR 		0
(defconstant $MACH_MSG_OOL_DESCRIPTOR 1)
; #define MACH_MSG_OOL_DESCRIPTOR  		1
(defconstant $MACH_MSG_OOL_PORTS_DESCRIPTOR 2)
; #define MACH_MSG_OOL_PORTS_DESCRIPTOR 		2
(defconstant $MACH_MSG_OOL_VOLATILE_DESCRIPTOR 3)
; #define MACH_MSG_OOL_VOLATILE_DESCRIPTOR  	3
(defrecord mach_msg_type_descriptor_t
   (pad1 :pointer)
   (pad2 :UInt32)
   (pad3 :UInt32)
   (type :UInt32)
)
(defrecord mach_msg_port_descriptor_t
   (name :pointer)
   (pad1 :UInt32)
   (pad2 :UInt32)
   (disposition :UInt32)
   (type :UInt32)
)
(defrecord mach_msg_ool_descriptor_t
   (address :pointer)
   (size :UInt32)
   (deallocate :signed-long)
   (copy :UInt32)
   (pad1 :UInt32)
   (type :UInt32)
)
(defrecord mach_msg_ool_ports_descriptor_t
   (address :pointer)
   (count :UInt32)
   (deallocate :signed-long)
   (copy :UInt32)
   (disposition :UInt32)
   (type :UInt32)
)
(defrecord mach_msg_descriptor_t
   (:variant
   (
   (port :MACH_MSG_PORT_DESCRIPTOR_T)
   )
   (
   (out_of_line :MACH_MSG_OOL_DESCRIPTOR_T)
   )
   (
   (ool_ports :MACH_MSG_OOL_PORTS_DESCRIPTOR_T)
   )
   (
   (type :MACH_MSG_TYPE_DESCRIPTOR_T)
   )
   )
)
(defrecord mach_msg_body_t
   (msgh_descriptor_count :UInt32)
)
; #define MACH_MSG_BODY_NULL (mach_msg_body_t *) 0
; #define MACH_MSG_DESCRIPTOR_NULL (mach_msg_descriptor_t *) 0
(defrecord mach_msg_header_t
   (msgh_bits :UInt32)
   (msgh_size :UInt32)
   (msgh_remote_port :pointer)
   (msgh_local_port :pointer)
   (msgh_reserved :UInt32)
   (msgh_id :signed-long)
)
; #define MACH_MSG_NULL (mach_msg_header_t *) 0
(defrecord mach_msg_base_t
   (header :MACH_MSG_HEADER_T)
   (body :MACH_MSG_BODY_T)
)

(def-mactype :mach_msg_trailer_type_t (find-mactype ':UInt32))
(defconstant $MACH_MSG_TRAILER_FORMAT_0 0)
; #define	MACH_MSG_TRAILER_FORMAT_0	0

(def-mactype :mach_msg_trailer_size_t (find-mactype ':UInt32))
(defrecord mach_msg_trailer_t
   (msgh_trailer_type :UInt32)
   (msgh_trailer_size :UInt32)
)
#|
; Warning: type-size: unknown type MACH_PORT_SEQNO_T
|#
(defrecord mach_msg_seqno_trailer_t
   (msgh_trailer_type :UInt32)
   (msgh_trailer_size :UInt32)
   (msgh_seqno :mach_port_seqno_t)
)
(defrecord security_token_t   (val (:array :UInt32 2))
)
#|
; Warning: type-size: unknown type MACH_PORT_SEQNO_T
|#
(defrecord mach_msg_security_trailer_t
   (msgh_trailer_type :UInt32)
   (msgh_trailer_size :UInt32)
   (msgh_seqno :mach_port_seqno_t)
   (msgh_sender :SECURITY_TOKEN_T)
)
(defrecord audit_token_t   (val (:array :UInt32 8))
)
#|
; Warning: type-size: unknown type MACH_PORT_SEQNO_T
|#
(defrecord mach_msg_audit_trailer_t
   (msgh_trailer_type :UInt32)
   (msgh_trailer_size :UInt32)
   (msgh_seqno :mach_port_seqno_t)
   (msgh_sender :SECURITY_TOKEN_T)
   (msgh_audit :AUDIT_TOKEN_T)
)
; #define MACH_MSG_TRAILER_MINIMUM_SIZE  sizeof(mach_msg_trailer_t)
; 
;  * These values can change from release to release - but clearly
;  * code cannot request additional trailer elements one was not
;  * compiled to understand.  Therefore, it is safe to use this
;  * constant when the same module specified the receive options.
;  * Otherwise, you run the risk that the options requested by
;  * another module may exceed the local modules notion of
;  * MAX_TRAILER_SIZE.
;  

(%define-record :mach_msg_max_trailer_t (find-record-descriptor ':mach_msg_audit_trailer_t))
; #define MAX_TRAILER_SIZE sizeof(mach_msg_max_trailer_t)
; 
;  * Legacy requirements keep us from ever updating these defines (even
;  * when the format_0 trailers gain new option data fields in the future).
;  * Therefore, they shouldn't be used going forward.  Instead, the sizes
;  * should be compared against the specific element size requested using
;  * REQUESTED_TRAILER_SIZE.
;  

(%define-record :mach_msg_format_0_trailer_t (find-record-descriptor ':mach_msg_security_trailer_t))
; #define MACH_MSG_TRAILER_FORMAT_0_SIZE sizeof(mach_msg_format_0_trailer_t)
; #define   KERNEL_SECURITY_TOKEN_VALUE  { {0, 1} }
(%define-record :KERNEL_SECURITY_TOKEN (find-record-descriptor ':security_token_t))
; #define   KERNEL_AUDIT_TOKEN_VALUE  { {0, 0, 0, 0, 0, 0, 0, 0} }
(%define-record :KERNEL_AUDIT_TOKEN (find-record-descriptor ':audit_token_t))

(def-mactype :mach_msg_options_t (find-mactype ':signed-long))
(defrecord mach_msg_empty_send_t
   (header :MACH_MSG_HEADER_T)
)
(defrecord mach_msg_empty_rcv_t
   (header :MACH_MSG_HEADER_T)
   (trailer :MACH_MSG_TRAILER_T)
)
(defrecord mach_msg_empty_t
   (:variant
   (
   (send :MACH_MSG_EMPTY_SEND_T)
   )
   (
   (rcv :MACH_MSG_EMPTY_RCV_T)
   )
   )
)
;  utility to round the message size - will become machine dependent 
; #define round_msg(x)	(((mach_msg_size_t)(x) + sizeof (natural_t) - 1) & 				~(sizeof (natural_t) - 1))
; 
;  *  There is no fixed upper bound to the size of Mach messages.
;  
; #define	MACH_MSG_SIZE_MAX	((mach_msg_size_t) ~0)
; #ifdef __APPLE_API_OBSOLETE
#| #|

#define MACH_MSGH_KIND_NORMAL		0x00000000
#define MACH_MSGH_KIND_NOTIFICATION	0x00000001
#define msgh_kind			msgh_seqno
#define mach_msg_kind_t			mach_port_seqno_t
#endif
|#
 |#
;  __APPLE_API_OBSOLETE 
; 
;  *  The msgt_number field specifies the number of data elements.
;  *  The msgt_size field specifies the size of each data element, in bits.
;  *  The msgt_name field specifies the type of each data element.
;  *  If msgt_inline is TRUE, the data follows the type descriptor
;  *  in the body of the message.  If msgt_inline is FALSE, then a pointer
;  *  to the data should follow the type descriptor, and the data is
;  *  sent out-of-line.  In this case, if msgt_deallocate is TRUE,
;  *  then the out-of-line data is moved (instead of copied) into the message.
;  *  If msgt_longform is TRUE, then the type descriptor is actually
;  *  a mach_msg_type_long_t.
;  *
;  *  The actual amount of inline data following the descriptor must
;  *  a multiple of the word size.  For out-of-line data, this is a
;  *  pointer.  For inline data, the supplied data size (calculated
;  *  from msgt_number/msgt_size) is rounded up.  This guarantees
;  *  that type descriptors always fall on word boundaries.
;  *
;  *  For port rights, msgt_size must be 8*sizeof(mach_port_t).
;  *  If the data is inline, msgt_deallocate should be FALSE.
;  *  The msgt_unused bit should be zero.
;  *  The msgt_name, msgt_size, msgt_number fields in
;  *  a mach_msg_type_long_t should be zero.
;  

(def-mactype :mach_msg_type_size_t (find-mactype ':UInt32))

(def-mactype :mach_msg_type_number_t (find-mactype ':UInt32))
; 
;  *  Values received/carried in messages.  Tells the receiver what
;  *  sort of port right he now has.
;  *
;  *  MACH_MSG_TYPE_PORT_NAME is used to transfer a port name
;  *  which should remain uninterpreted by the kernel.  (Port rights
;  *  are not transferred, just the port name.)
;  
(defconstant $MACH_MSG_TYPE_PORT_NONE 0)
; #define MACH_MSG_TYPE_PORT_NONE		0
(defconstant $MACH_MSG_TYPE_PORT_NAME 15)
; #define MACH_MSG_TYPE_PORT_NAME		15
; #define MACH_MSG_TYPE_PORT_RECEIVE	MACH_MSG_TYPE_MOVE_RECEIVE
; #define MACH_MSG_TYPE_PORT_SEND		MACH_MSG_TYPE_MOVE_SEND
; #define MACH_MSG_TYPE_PORT_SEND_ONCE	MACH_MSG_TYPE_MOVE_SEND_ONCE
(defconstant $MACH_MSG_TYPE_LAST 22)
; #define MACH_MSG_TYPE_LAST		22		/* Last assigned */
; 
;  *  A dummy value.  Mostly used to indicate that the actual value
;  *  will be filled in later, dynamically.
;  
; #define MACH_MSG_TYPE_POLYMORPHIC	((mach_msg_type_name_t) -1)
; 
;  *	Is a given item a port type?
;  
; #define MACH_MSG_TYPE_PORT_ANY(x)				(((x) >= MACH_MSG_TYPE_MOVE_RECEIVE) &&			 ((x) <= MACH_MSG_TYPE_MAKE_SEND_ONCE))
; #define	MACH_MSG_TYPE_PORT_ANY_SEND(x)				(((x) >= MACH_MSG_TYPE_MOVE_SEND) &&			 ((x) <= MACH_MSG_TYPE_MAKE_SEND_ONCE))
; #define	MACH_MSG_TYPE_PORT_ANY_RIGHT(x)				(((x) >= MACH_MSG_TYPE_MOVE_RECEIVE) &&			 ((x) <= MACH_MSG_TYPE_MOVE_SEND_ONCE))

(def-mactype :mach_msg_option_t (find-mactype ':signed-long))
(defconstant $MACH_MSG_OPTION_NONE 0)
; #define MACH_MSG_OPTION_NONE	0x00000000
(defconstant $MACH_SEND_MSG 1)
; #define	MACH_SEND_MSG		0x00000001
(defconstant $MACH_RCV_MSG 2)
; #define	MACH_RCV_MSG		0x00000002
(defconstant $MACH_RCV_LARGE 4)
; #define MACH_RCV_LARGE		0x00000004
(defconstant $MACH_SEND_TIMEOUT 16)
; #define MACH_SEND_TIMEOUT	0x00000010
(defconstant $MACH_SEND_INTERRUPT 64)
; #define MACH_SEND_INTERRUPT	0x00000040	/* libmach implements */
(defconstant $MACH_SEND_CANCEL 128)
; #define MACH_SEND_CANCEL	0x00000080
(defconstant $MACH_SEND_ALWAYS 65536)
; #define MACH_SEND_ALWAYS	0x00010000	/* internal use only */
(defconstant $MACH_SEND_TRAILER 131072)
; #define MACH_SEND_TRAILER	0x00020000	
(defconstant $MACH_RCV_TIMEOUT 256)
; #define MACH_RCV_TIMEOUT	0x00000100
(defconstant $MACH_RCV_NOTIFY 512)
; #define MACH_RCV_NOTIFY		0x00000200
(defconstant $MACH_RCV_INTERRUPT 1024)
; #define MACH_RCV_INTERRUPT	0x00000400	/* libmach implements */
(defconstant $MACH_RCV_OVERWRITE 4096)
; #define MACH_RCV_OVERWRITE	0x00001000
;  
;  * NOTE: a 0x00------ RCV mask implies to ask for
;  * a MACH_MSG_TRAILER_FORMAT_0 with 0 Elements, 
;  * which is equivalent to a mach_msg_trailer_t.
;  
(defconstant $MACH_RCV_TRAILER_NULL 0)
; #define MACH_RCV_TRAILER_NULL   0
(defconstant $MACH_RCV_TRAILER_SEQNO 1)
; #define MACH_RCV_TRAILER_SEQNO  1
(defconstant $MACH_RCV_TRAILER_SENDER 2)
; #define MACH_RCV_TRAILER_SENDER 2
(defconstant $MACH_RCV_TRAILER_AUDIT 3)
; #define MACH_RCV_TRAILER_AUDIT  3
; #define MACH_RCV_TRAILER_TYPE(x)     (((x) & 0xf) << 28) 
; #define MACH_RCV_TRAILER_ELEMENTS(x) (((x) & 0xf) << 24)  
(defconstant $MACH_RCV_TRAILER_MASK 4278190080)
; #define MACH_RCV_TRAILER_MASK 	     ((0xff << 24))
; #define GET_RCV_ELEMENTS(y) (((y) >> 24) & 0xf)
; #define REQUESTED_TRAILER_SIZE(y) 					((mach_msg_trailer_size_t)					 ((GET_RCV_ELEMENTS(y) == MACH_RCV_TRAILER_NULL) ?		  sizeof(mach_msg_trailer_t) :					  ((GET_RCV_ELEMENTS(y) == MACH_RCV_TRAILER_SEQNO) ?		   sizeof(mach_msg_seqno_trailer_t) :				  ((GET_RCV_ELEMENTS(y) == MACH_RCV_TRAILER_SENDER) ?		   sizeof(mach_msg_security_trailer_t) :			   sizeof(mach_msg_audit_trailer_t)))))
; 
;  *  Much code assumes that mach_msg_return_t == kern_return_t.
;  *  This definition is useful for descriptive purposes.
;  *
;  *  See <mach/error.h> for the format of error codes.
;  *  IPC errors are system 4.  Send errors are subsystem 0;
;  *  receive errors are subsystem 1.  The code field is always non-zero.
;  *  The high bits of the code field communicate extra information
;  *  for some error codes.  MACH_MSG_MASK masks off these special bits.
;  

(def-mactype :mach_msg_return_t (find-mactype ':signed-long))
(defconstant $MACH_MSG_SUCCESS 0)
; #define MACH_MSG_SUCCESS		0x00000000
(defconstant $MACH_MSG_MASK 15872)
; #define	MACH_MSG_MASK			0x00003e00
;  All special error code bits defined below. 
(defconstant $MACH_MSG_IPC_SPACE 8192)
; #define	MACH_MSG_IPC_SPACE		0x00002000
;  No room in IPC name space for another capability name. 
(defconstant $MACH_MSG_VM_SPACE 4096)
; #define	MACH_MSG_VM_SPACE		0x00001000
;  No room in VM address space for out-of-line memory. 
(defconstant $MACH_MSG_IPC_KERNEL 2048)
; #define	MACH_MSG_IPC_KERNEL		0x00000800
;  Kernel resource shortage handling an IPC capability. 
(defconstant $MACH_MSG_VM_KERNEL 1024)
; #define	MACH_MSG_VM_KERNEL		0x00000400
;  Kernel resource shortage handling out-of-line memory. 
(defconstant $MACH_SEND_IN_PROGRESS 268435457)
; #define MACH_SEND_IN_PROGRESS		0x10000001
;  Thread is waiting to send.  (Internal use only.) 
(defconstant $MACH_SEND_INVALID_DATA 268435458)
; #define MACH_SEND_INVALID_DATA		0x10000002
;  Bogus in-line data. 
(defconstant $MACH_SEND_INVALID_DEST 268435459)
; #define MACH_SEND_INVALID_DEST		0x10000003
;  Bogus destination port. 
(defconstant $MACH_SEND_TIMED_OUT 268435460)
; #define MACH_SEND_TIMED_OUT		0x10000004
;  Message not sent before timeout expired. 
(defconstant $MACH_SEND_INTERRUPTED 268435463)
; #define MACH_SEND_INTERRUPTED		0x10000007
;  Software interrupt. 
(defconstant $MACH_SEND_MSG_TOO_SMALL 268435464)
; #define MACH_SEND_MSG_TOO_SMALL		0x10000008
;  Data doesn't contain a complete message. 
(defconstant $MACH_SEND_INVALID_REPLY 268435465)
; #define MACH_SEND_INVALID_REPLY		0x10000009
;  Bogus reply port. 
(defconstant $MACH_SEND_INVALID_RIGHT 268435466)
; #define MACH_SEND_INVALID_RIGHT		0x1000000a
;  Bogus port rights in the message body. 
(defconstant $MACH_SEND_INVALID_NOTIFY 268435467)
; #define MACH_SEND_INVALID_NOTIFY	0x1000000b
;  Bogus notify port argument. 
(defconstant $MACH_SEND_INVALID_MEMORY 268435468)
; #define MACH_SEND_INVALID_MEMORY	0x1000000c
;  Invalid out-of-line memory pointer. 
(defconstant $MACH_SEND_NO_BUFFER 268435469)
; #define MACH_SEND_NO_BUFFER		0x1000000d
;  No message buffer is available. 
(defconstant $MACH_SEND_TOO_LARGE 268435470)
; #define MACH_SEND_TOO_LARGE		0x1000000e
;  Send is too large for port 
(defconstant $MACH_SEND_INVALID_TYPE 268435471)
; #define MACH_SEND_INVALID_TYPE		0x1000000f
;  Invalid msg-type specification. 
(defconstant $MACH_SEND_INVALID_HEADER 268435472)
; #define MACH_SEND_INVALID_HEADER	0x10000010
;  A field in the header had a bad value. 
(defconstant $MACH_SEND_INVALID_TRAILER 268435473)
; #define MACH_SEND_INVALID_TRAILER	0x10000011
;  The trailer to be sent does not match kernel format. 
(defconstant $MACH_SEND_INVALID_RT_OOL_SIZE 268435477)
; #define MACH_SEND_INVALID_RT_OOL_SIZE	0x10000015
;  compatibility: no longer a returned error 
(defconstant $MACH_RCV_IN_PROGRESS 268451841)
; #define MACH_RCV_IN_PROGRESS		0x10004001
;  Thread is waiting for receive.  (Internal use only.) 
(defconstant $MACH_RCV_INVALID_NAME 268451842)
; #define MACH_RCV_INVALID_NAME		0x10004002
;  Bogus name for receive port/port-set. 
(defconstant $MACH_RCV_TIMED_OUT 268451843)
; #define MACH_RCV_TIMED_OUT		0x10004003
;  Didn't get a message within the timeout value. 
(defconstant $MACH_RCV_TOO_LARGE 268451844)
; #define MACH_RCV_TOO_LARGE		0x10004004
;  Message buffer is not large enough for inline data. 
(defconstant $MACH_RCV_INTERRUPTED 268451845)
; #define MACH_RCV_INTERRUPTED		0x10004005
;  Software interrupt. 
(defconstant $MACH_RCV_PORT_CHANGED 268451846)
; #define MACH_RCV_PORT_CHANGED		0x10004006
;  compatibility: no longer a returned error 
(defconstant $MACH_RCV_INVALID_NOTIFY 268451847)
; #define MACH_RCV_INVALID_NOTIFY		0x10004007
;  Bogus notify port argument. 
(defconstant $MACH_RCV_INVALID_DATA 268451848)
; #define MACH_RCV_INVALID_DATA		0x10004008
;  Bogus message buffer for inline data. 
(defconstant $MACH_RCV_PORT_DIED 268451849)
; #define MACH_RCV_PORT_DIED		0x10004009
;  Port/set was sent away/died during receive. 
(defconstant $MACH_RCV_IN_SET 268451850)
; #define	MACH_RCV_IN_SET			0x1000400a
;  compatibility: no longer a returned error 
(defconstant $MACH_RCV_HEADER_ERROR 268451851)
; #define	MACH_RCV_HEADER_ERROR		0x1000400b
;  Error receiving message header.  See special bits. 
(defconstant $MACH_RCV_BODY_ERROR 268451852)
; #define	MACH_RCV_BODY_ERROR		0x1000400c
;  Error receiving message body.  See special bits. 
(defconstant $MACH_RCV_INVALID_TYPE 268451853)
; #define	MACH_RCV_INVALID_TYPE		0x1000400d
;  Invalid msg-type specification in scatter list. 
(defconstant $MACH_RCV_SCATTER_SMALL 268451854)
; #define	MACH_RCV_SCATTER_SMALL		0x1000400e
;  Out-of-line overwrite region is not large enough 
(defconstant $MACH_RCV_INVALID_TRAILER 268451855)
; #define MACH_RCV_INVALID_TRAILER	0x1000400f
;  trailer type or number of trailer elements not supported 
(defconstant $MACH_RCV_IN_PROGRESS_TIMED 268451857)
; #define MACH_RCV_IN_PROGRESS_TIMED      0x10004011
;  Waiting for receive with timeout. (Internal use only.) 
; 
;  *	Routine:	mach_msg_overwrite
;  *	Purpose:
;  *		Send and/or receive a message.  If the message operation
;  *		is interrupted, and the user did not request an indication
;  *		of that fact, then restart the appropriate parts of the
;  *		operation silently (trap version does not restart).
;  *
;  *		Distinct send and receive buffers may be specified.  If
;  *		no separate receive buffer is specified, the msg parameter
;  *		will be used for both send and receive operations.
;  *
;  *		In addition to a distinct receive buffer, that buffer may
;  *		already contain scatter control information to direct the
;  *		receiving of the message.
;  
; #ifdef __APPLE_API_PRIVATE
#| #|
extern mach_msg_return_t	mach_msg_overwrite_trap(
					mach_msg_header_t *msg,
					mach_msg_option_t option,
					mach_msg_size_t send_size,
					mach_msg_size_t rcv_size,
					mach_port_name_t rcv_name,
					mach_msg_timeout_t timeout,
					mach_port_name_t notify,
					mach_msg_header_t *rcv_msg,
					mach_msg_size_t rcv_limit);
#endif
|#
 |#
;  __APPLE_API_PRIVATE 

(deftrap-inline "_mach_msg_overwrite" 
   ((msg (:pointer :MACH_MSG_HEADER_T))
    (option :signed-long)
    (send_size :UInt32)
    (rcv_size :UInt32)
    (rcv_name :mach_port_name_t)
    (timeout :UInt32)
    (notify :mach_port_name_t)
    (rcv_msg (:pointer :MACH_MSG_HEADER_T))
    (rcv_limit :UInt32)
   )
   :signed-long
() )
; 
;  *	Routine:	mach_msg
;  *	Purpose:
;  *		Send and/or receive a message.  If the message operation
;  *		is interrupted, and the user did not request an indication
;  *		of that fact, then restart the appropriate parts of the
;  *		operation silently (trap version does not restart).
;  
; #ifdef __APPLE_API_PRIVATE 
#| #|
extern mach_msg_return_t	mach_msg_trap(
					mach_msg_header_t *msg,
					mach_msg_option_t option,
					mach_msg_size_t send_size,
					mach_msg_size_t rcv_size,
					mach_port_name_t rcv_name,
					mach_msg_timeout_t timeout,
					mach_port_name_t notify);
#endif
|#
 |#
;  __APPLE_API_PRIVATE 

(deftrap-inline "_mach_msg" 
   ((msg (:pointer :MACH_MSG_HEADER_T))
    (option :signed-long)
    (send_size :UInt32)
    (rcv_size :UInt32)
    (rcv_name :mach_port_name_t)
    (timeout :UInt32)
    (notify :mach_port_name_t)
   )
   :signed-long
() )

; #endif	/* _MACH_MESSAGE_H_ */


(provide-interface "message")