(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:bulkmem.h"
; at Sunday July 2,2006 7:27:15 pm.
; 
;  * Definitions for bulk memory services
;  *
;  * bulkmem.h 1.12 2000/06/12 21:55:41
;  *
;  * The contents of this file are subject to the Mozilla Public License
;  * Version 1.1 (the "License"); you may not use this file except in
;  * compliance with the License. You may obtain a copy of the License
;  * at http://www.mozilla.org/MPL/
;  *
;  * Software distributed under the License is distributed on an "AS IS"
;  * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
;  * the License for the specific language governing rights and
;  * limitations under the License. 
;  *
;  * The initial developer of the original code is David A. Hinds
;  * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
;  * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
;  *
;  * Contributor:  Apple Computer, Inc.  Portions © 2003 Apple Computer, 
;  * Inc. All rights reserved.
;  *
;  * Alternatively, the contents of this file may be used under the
;  * terms of the GNU Public License version 2 (the "GPL"), in which
;  * case the provisions of the GPL are applicable instead of the
;  * above.  If you wish to allow the use of your version of this file
;  * only under the terms of the GPL and not to allow others to use
;  * your version of this file under the MPL, indicate your decision by
;  * deleting the provisions above and replace them with the notice and
;  * other provisions required by the GPL.  If you do not delete the
;  * provisions above, a recipient may use your version of this file
;  * under either the MPL or the GPL.
;  * bulkmem.h 1.3 1995/05/27 04:49:49
;  
; #ifndef _LINUX_BULKMEM_H
; #define _LINUX_BULKMEM_H
;  For GetFirstRegion and GetNextRegion 
(defrecord region_info_t
   (Attributes :UInt32)
   (CardOffset :UInt32)
   (RegionSize :UInt32)
   (AccessSpeed :UInt32)
   (BlockSize :UInt32)
   (PartMultiple :UInt32)
   (JedecMfr :UInt8)
   (JedecInfo :UInt8)
   (next :memory_handle_t)
#|
; Warning: type-size: unknown type MEMORY_HANDLE_T
|#
)
(defconstant $REGION_TYPE 1)
; #define REGION_TYPE		0x0001
(defconstant $REGION_TYPE_CM 0)
; #define REGION_TYPE_CM		0x0000
(defconstant $REGION_TYPE_AM 1)
; #define REGION_TYPE_AM		0x0001
(defconstant $REGION_PREFETCH 8)
; #define REGION_PREFETCH		0x0008
(defconstant $REGION_CACHEABLE 16)
; #define REGION_CACHEABLE	0x0010
(defconstant $REGION_BAR_MASK 57344)
; #define REGION_BAR_MASK		0xe000
(defconstant $REGION_BAR_SHIFT 13)
; #define REGION_BAR_SHIFT	13
;  For OpenMemory 
(defrecord open_mem_t
   (Attributes :UInt32)
   (Offset :UInt32)
)
;  Attributes for OpenMemory 
(defconstant $MEMORY_TYPE 1)
; #define MEMORY_TYPE		0x0001
(defconstant $MEMORY_TYPE_CM 0)
; #define MEMORY_TYPE_CM		0x0000
(defconstant $MEMORY_TYPE_AM 1)
; #define MEMORY_TYPE_AM		0x0001
(defconstant $MEMORY_EXCLUSIVE 2)
; #define MEMORY_EXCLUSIVE	0x0002
(defconstant $MEMORY_PREFETCH 8)
; #define MEMORY_PREFETCH		0x0008
(defconstant $MEMORY_CACHEABLE 16)
; #define MEMORY_CACHEABLE	0x0010
(defconstant $MEMORY_BAR_MASK 57344)
; #define MEMORY_BAR_MASK		0xe000
(defconstant $MEMORY_BAR_SHIFT 13)
; #define MEMORY_BAR_SHIFT	13
(defrecord eraseq_entry_t
   (Handle :memory_handle_t)
#|
; Warning: type-size: unknown type MEMORY_HANDLE_T
|#
   (State :UInt8)
   (Size :UInt32)
   (Offset :UInt32)
   (Optional :pointer)
)
(defrecord eraseq_hdr_t
   (QueueEntryCnt :signed-long)
   (QueueEntryArray (:pointer :ERASEQ_ENTRY_T))
)
(defconstant $ERASE_QUEUED 0)
; #define ERASE_QUEUED		0x00
; #define ERASE_IN_PROGRESS(n)	(((n) > 0) && ((n) < 0x80))
(defconstant $ERASE_IDLE 255)
; #define ERASE_IDLE		0xff
(defconstant $ERASE_PASSED 224)
; #define ERASE_PASSED		0xe0
(defconstant $ERASE_FAILED 225)
; #define ERASE_FAILED		0xe1
(defconstant $ERASE_MISSING 128)
; #define ERASE_MISSING		0x80
(defconstant $ERASE_MEDIA_WRPROT 132)
; #define ERASE_MEDIA_WRPROT	0x84
(defconstant $ERASE_NOT_ERASABLE 133)
; #define ERASE_NOT_ERASABLE	0x85
(defconstant $ERASE_BAD_OFFSET 193)
; #define ERASE_BAD_OFFSET	0xc1
(defconstant $ERASE_BAD_TECH 194)
; #define ERASE_BAD_TECH		0xc2
(defconstant $ERASE_BAD_SOCKET 195)
; #define ERASE_BAD_SOCKET	0xc3
(defconstant $ERASE_BAD_VCC 196)
; #define ERASE_BAD_VCC		0xc4
(defconstant $ERASE_BAD_VPP 197)
; #define ERASE_BAD_VPP		0xc5
(defconstant $ERASE_BAD_SIZE 198)
; #define ERASE_BAD_SIZE		0xc6
;  For CopyMemory 
(defrecord copy_op_t
   (Attributes :UInt32)
   (SourceOffset :UInt32)
   (DestOffset :UInt32)
   (Count :UInt32)
)
;  For ReadMemory and WriteMemory 
(defrecord mem_op_t
   (Attributes :UInt32)
   (Offset :UInt32)
   (Count :UInt32)
)
(defconstant $MEM_OP_BUFFER 1)
; #define MEM_OP_BUFFER		0x01
(defconstant $MEM_OP_BUFFER_USER 0)
; #define MEM_OP_BUFFER_USER	0x00
(defconstant $MEM_OP_BUFFER_KERNEL 1)
; #define MEM_OP_BUFFER_KERNEL	0x01
(defconstant $MEM_OP_DISABLE_ERASE 2)
; #define MEM_OP_DISABLE_ERASE	0x02
(defconstant $MEM_OP_VERIFY 4)
; #define MEM_OP_VERIFY		0x04
;  For RegisterMTD 
(defrecord mtd_reg_t
   (Attributes :UInt32)
   (Offset :UInt32)
   (MediaID :UInt32)
)
; 
;  *  Definitions for MTD requests
;  
(defrecord mtd_request_t
   (SrcCardOffset :UInt32)
   (DestCardOffset :UInt32)
   (TransferLength :UInt32)
   (Function :UInt32)
   (MediaID :UInt32)
   (Status :UInt32)
   (Timeout :UInt32)
)
;  Fields in MTD Function 
(defconstant $MTD_REQ_ACTION 3)
; #define MTD_REQ_ACTION		0x003
(defconstant $MTD_REQ_ERASE 0)
; #define MTD_REQ_ERASE		0x000
(defconstant $MTD_REQ_READ 1)
; #define MTD_REQ_READ		0x001
(defconstant $MTD_REQ_WRITE 2)
; #define MTD_REQ_WRITE		0x002
(defconstant $MTD_REQ_COPY 3)
; #define MTD_REQ_COPY		0x003
(defconstant $MTD_REQ_NOERASE 4)
; #define MTD_REQ_NOERASE		0x004
(defconstant $MTD_REQ_VERIFY 8)
; #define MTD_REQ_VERIFY		0x008
(defconstant $MTD_REQ_READY 16)
; #define MTD_REQ_READY		0x010
(defconstant $MTD_REQ_TIMEOUT 32)
; #define MTD_REQ_TIMEOUT		0x020
(defconstant $MTD_REQ_LAST 64)
; #define MTD_REQ_LAST		0x040
(defconstant $MTD_REQ_FIRST 128)
; #define MTD_REQ_FIRST		0x080
(defconstant $MTD_REQ_KERNEL 256)
; #define MTD_REQ_KERNEL		0x100
;  Status codes 
(defconstant $MTD_WAITREQ 0)
; #define MTD_WAITREQ	0x00
(defconstant $MTD_WAITTIMER 1)
; #define MTD_WAITTIMER	0x01
(defconstant $MTD_WAITRDY 2)
; #define MTD_WAITRDY	0x02
(defconstant $MTD_WAITPOWER 3)
; #define MTD_WAITPOWER	0x03
; 
;  *  Definitions for MTD helper functions
;  
;  For MTDModifyWindow 
(defrecord mtd_mod_win_t
   (Attributes :UInt32)
   (AccessSpeed :UInt32)
   (CardOffset :UInt32)
)
;  For MTDSetVpp 
(defrecord mtd_vpp_req_t
   (Vpp1 :UInt8)
   (Vpp2 :UInt8))
;  For MTDRDYMask 
(defrecord mtd_rdy_req_t
   (Mask :UInt32)
)
(def-mactype :mtd_helper (find-mactype ':sint32))

(defconstant $MTDRequestWindow 0)
(defconstant $MTDModifyWindow 1)
(defconstant $MTDReleaseWindow 2)
(defconstant $MTDSetVpp 3)
(defconstant $MTDRDYMask 4)
; #ifdef IN_CARD_SERVICES
#| #|
extern int MTDHelperEntry(int func, void *a1, void *a2);
|#
 |#

; #else

(deftrap-inline "_MTDHelperEntry" 
   ((func :signed-long)
#| |...|  ;; What should this do?
    |#
   )
   :signed-long
() )

; #endif


; #endif /* _LINUX_BULKMEM_H */


(provide-interface "bulkmem")