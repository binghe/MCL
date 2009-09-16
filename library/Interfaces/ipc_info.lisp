(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ipc_info.h"
; at Sunday July 2,2006 7:26:01 pm.
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
; 
;  * HISTORY
;  * 
;  * Revision 1.1.1.1  1998/09/22 21:05:45  wsanchez
;  * Import of Mac OS X kernel (~semeria)
;  *
;  * Revision 1.1.1.1  1998/03/07 02:26:17  wsanchez
;  * Import of OSF Mach kernel (~mburg)
;  *
;  * Revision 1.2.13.2  1995/01/06  19:52:40  devrcs
;  * 	mk6 CR668 - 1.3b26 merge
;  * 	64bit cleanup
;  * 	[1994/10/14  03:43:35  dwm]
;  *
;  * Revision 1.2.13.1  1994/09/23  02:45:18  ezf
;  * 	change marker to not FREE
;  * 	[1994/09/22  21:44:05  ezf]
;  * 
;  * Revision 1.2.3.3  1993/09/09  16:07:52  jeffc
;  * 	CR9745 - Delete message accepted notifications
;  * 	[1993/09/03  20:45:48  jeffc]
;  * 
;  * Revision 1.2.3.2  1993/06/09  02:44:43  gm
;  * 	Added to OSF/1 R1.3 from NMK15.0.
;  * 	[1993/06/02  21:19:04  jeffc]
;  * 
;  * Revision 1.2  1993/04/19  16:41:20  devrcs
;  * 	ansi C conformance changes
;  * 	[1993/02/02  18:56:50  david]
;  * 
;  * Revision 1.1  1992/09/30  02:32:34  robert
;  * 	Initial revision
;  * 
;  * $EndLog$
;  
;  CMU_HIST 
; 
;  * Revision 2.5.4.2  92/04/08  15:45:00  jeffreyh
;  * 	Back out Mainline changes. Revert back to revision 2.5.
;  * 	[92/04/07  10:29:40  jeffreyh]
;  * 
;  * Revision 2.5  91/05/14  17:03:28  mrt
;  * 	Correcting copyright
;  * 
;  * Revision 2.4  91/02/05  17:37:50  mrt
;  * 	Changed to new Mach copyright
;  * 	[91/02/01  17:28:30  mrt]
;  * 
;  * Revision 2.3  91/01/08  15:19:05  rpd
;  * 	Moved ipc_info_bucket_t to mach_debug/hash_info.h.
;  * 	[91/01/02            rpd]
;  * 
;  * Revision 2.2  90/06/02  15:00:28  rpd
;  * 	Created for new IPC.
;  * 	[90/03/26  23:45:14  rpd]
;  * 
;  
;  CMU_ENDHIST 
;  
;  * Mach Operating System
;  * Copyright (c) 1991,1990 Carnegie Mellon University
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
;  *	File:	mach_debug/ipc_info.h
;  *	Author:	Rich Draves
;  *	Date:	March, 1990
;  *
;  *	Definitions for the IPC debugging interface.
;  
; #ifndef	_MACH_DEBUG_IPC_INFO_H_
; #define _MACH_DEBUG_IPC_INFO_H_

(require-interface "mach/boolean")

(require-interface "mach/port")

(require-interface "mach/machine/vm_types")
; 
;  *	Remember to update the mig type definitions
;  *	in mach_debug_types.defs when adding/removing fields.
;  
(defrecord ipc_info_space
   (iis_genno_mask :UInt32)
                                                ;  generation number mask 
   (iis_table_size :UInt32)
                                                ;  size of table 
   (iis_table_next :UInt32)
                                                ;  next possible size of table 
   (iis_tree_size :UInt32)
                                                ;  size of tree 
   (iis_tree_small :UInt32)
                                                ;  # of small entries in tree 
   (iis_tree_hash :UInt32)
                                                ;  # of hashed entries in tree 
)
(%define-record :ipc_info_space_t (find-record-descriptor :IPC_INFO_SPACE))
(defrecord ipc_info_name
   (iin_name :mach_port_name_t)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
                                                ;  port name, including gen number 
                                                ; boolean_t
   (iin_collision :signed-long)
                                                ;  collision at this entry? 
   (iin_type :mach_port_type_t)
#|
; Warning: type-size: unknown type MACH_PORT_TYPE_T
|#
                                                ;  straight port type 
   (iin_urefs :mach_port_urefs_t)
#|
; Warning: type-size: unknown type MACH_PORT_UREFS_T
|#
                                                ;  user-references 
   (iin_object :UInt32)
                                                ;  object pointer 
   (iin_next :UInt32)
                                                ;  marequest/next in free list 
   (iin_hash :UInt32)
                                                ;  hash index 
)
(%define-record :ipc_info_name_t (find-record-descriptor :IPC_INFO_NAME))

(def-mactype :ipc_info_name_array_t (find-mactype '(:pointer :IPC_INFO_NAME)))
(defrecord ipc_info_tree_name
   (iitn_name :IPC_INFO_NAME)
   (iitn_lchild :mach_port_name_t)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
                                                ;  name of left child 
   (iitn_rchild :mach_port_name_t)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
                                                ;  name of right child 
)
(%define-record :ipc_info_tree_name_t (find-record-descriptor :IPC_INFO_TREE_NAME))

(def-mactype :ipc_info_tree_name_array_t (find-mactype '(:pointer :IPC_INFO_TREE_NAME)))

; #endif	/* _MACH_DEBUG_IPC_INFO_H_ */


(provide-interface "ipc_info")