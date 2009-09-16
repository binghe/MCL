(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ss.h"
; at Sunday July 2,2006 7:31:57 pm.
; 
;  * ss.h 1.28 2000/06/12 21:55:40
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
;  
; #ifndef _LINUX_SS_H
; #define _LINUX_SS_H
;  For RegisterCallback 
(defrecord ss_callback_t
   (handler (:pointer :callback))               ;(void (void * info , u_int events))
   (info :pointer)
)
;  Definitions for card status flags for GetStatus 
(defconstant $SS_WRPROT 1)
; #define SS_WRPROT	0x0001
(defconstant $SS_CARDLOCK 2)
; #define SS_CARDLOCK	0x0002
(defconstant $SS_EJECTION 4)
; #define SS_EJECTION	0x0004
(defconstant $SS_INSERTION 8)
; #define SS_INSERTION	0x0008
(defconstant $SS_BATDEAD 16)
; #define SS_BATDEAD	0x0010
(defconstant $SS_BATWARN 32)
; #define SS_BATWARN	0x0020
(defconstant $SS_READY 64)
; #define SS_READY	0x0040
(defconstant $SS_DETECT 128)
; #define SS_DETECT	0x0080
(defconstant $SS_POWERON 256)
; #define SS_POWERON	0x0100
(defconstant $SS_GPI 512)
; #define SS_GPI		0x0200
(defconstant $SS_STSCHG 1024)
; #define SS_STSCHG	0x0400
(defconstant $SS_CARDBUS 2048)
; #define SS_CARDBUS	0x0800
(defconstant $SS_3VCARD 4096)
; #define SS_3VCARD	0x1000
(defconstant $SS_XVCARD 8192)
; #define SS_XVCARD	0x2000
(defconstant $SS_PENDING 16384)
; #define SS_PENDING	0x4000
;  for InquireSocket 
(defrecord socket_cap_t
   (features :UInt32)
   (irq_mask :UInt32)
   (map_size :UInt32)
   (pci_irq :uint8)
   (cardbus :uint8)
; #ifdef __MACOSX__
   (bridge_nub (:pointer :IOPCIDevice))
   (pccard_nub (:pointer :IOPCCardBridge))
   (cardbus_nub (:array :pointer 8))
#| 
; #else
   (cb_bus (:pointer :pci_bus))
   (bus (:pointer :bus_operations))
 |#

; #endif

)
;  InquireSocket capabilities 
(defconstant $SS_CAP_PAGE_REGS 1)
; #define SS_CAP_PAGE_REGS	0x0001
(defconstant $SS_CAP_VIRTUAL_BUS 2)
; #define SS_CAP_VIRTUAL_BUS	0x0002
(defconstant $SS_CAP_MEM_ALIGN 4)
; #define SS_CAP_MEM_ALIGN	0x0004
(defconstant $SS_CAP_STATIC_MAP 8)
; #define SS_CAP_STATIC_MAP	0x0008
(defconstant $SS_CAP_PCCARD 16384)
; #define SS_CAP_PCCARD		0x4000
(defconstant $SS_CAP_CARDBUS 32768)
; #define SS_CAP_CARDBUS		0x8000
;  for GetSocket, SetSocket 
(defrecord socket_state_t
   (flags :UInt32)
   (csc_mask :UInt32)
   (Vcc :uint8)
   (Vpp :uint8)
   (io_irq :uint8)
)
;  Socket configuration flags 
(defconstant $SS_PWR_AUTO 16)
; #define SS_PWR_AUTO	0x0010
(defconstant $SS_IOCARD 32)
; #define SS_IOCARD	0x0020
(defconstant $SS_RESET 64)
; #define SS_RESET	0x0040
(defconstant $SS_DMA_MODE 128)
; #define SS_DMA_MODE	0x0080
(defconstant $SS_SPKR_ENA 256)
; #define SS_SPKR_ENA	0x0100
(defconstant $SS_OUTPUT_ENA 512)
; #define SS_OUTPUT_ENA	0x0200
;  Flags for I/O port and memory windows 
(defconstant $MAP_ACTIVE 1)
; #define MAP_ACTIVE	0x01
(defconstant $MAP_16BIT 2)
; #define MAP_16BIT	0x02
(defconstant $MAP_AUTOSZ 4)
; #define MAP_AUTOSZ	0x04
(defconstant $MAP_0WS 8)
; #define MAP_0WS		0x08
(defconstant $MAP_WRPROT 16)
; #define MAP_WRPROT	0x10
(defconstant $MAP_ATTRIB 32)
; #define MAP_ATTRIB	0x20
(defconstant $MAP_USE_WAIT 64)
; #define MAP_USE_WAIT	0x40
(defconstant $MAP_PREFETCH 128)
; #define MAP_PREFETCH	0x80
;  Use this just for bridge windows 
(defconstant $MAP_IOSPACE 32)
; #define MAP_IOSPACE	0x20
(defrecord pccard_io_map
   (map :uint8)
   (flags :uint8)
   (speed :UInt16)
   (start :UInt16)
   (stop :UInt16))
(defrecord pccard_mem_map
   (map :uint8)
   (flags :uint8)
   (speed :UInt16)
   (sys_start :UInt32)
   (sys_stop :UInt32)
   (card_start :UInt32)
)
(defrecord cb_bridge_map
   (map :uint8)
   (flags :uint8)
   (start :UInt32)
   (stop :UInt32))
(def-mactype :ss_service (find-mactype ':sint32))

(defconstant $SS_RegisterCallback 0)
(defconstant $SS_InquireSocket 1)
(defconstant $SS_GetStatus 2)
(defconstant $SS_GetSocket 3)
(defconstant $SS_SetSocket 4)
(defconstant $SS_GetIOMap 5)
(defconstant $SS_SetIOMap 6)
(defconstant $SS_GetMemMap 7)
(defconstant $SS_SetMemMap 8)
(defconstant $SS_GetBridge 9)
(defconstant $SS_SetBridge 10)
(defconstant $SS_ProcSetup 11)

; #endif /* _LINUX_SS_H */


(provide-interface "ss")