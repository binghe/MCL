(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:cs.h"
; at Sunday July 2,2006 7:27:26 pm.
; 
;  * cs.h 1.71 2000/08/29 00:54:20
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
; #ifndef _LINUX_CS_H
; #define _LINUX_CS_H
;  For AccessConfigurationRegister 
(defrecord conf_reg_t
   (Function :UInt8)
   (Action :UInt32)
   (Offset :OFF_T)
   (Value :UInt32)
)
;  Actions 
(defconstant $CS_READ 1)
; #define CS_READ		1
(defconstant $CS_WRITE 2)
; #define CS_WRITE	2
;  for AdjustResourceInfo 
(defrecord adjust_t
   (Action :UInt32)
   (Resource :UInt32)
   (Attributes :UInt32)
   (:variant
   (
   (Base :UInt32)
   (Size :UInt32)
   )
   (
   (BasePort :ioaddr_t)
#|
; Warning: type-size: unknown type IOADDR_T
|#
   (NumPorts :ioaddr_t)
#|
; Warning: type-size: unknown type IOADDR_T
|#
   (IOAddrLines :UInt32)
   )
   (
   (IRQ :UInt32)
   )
   )
)
; #ifdef __MACOSX__
; #define CS_ADJUST_FAKE_HANDLE ((void *)0x12345678)

; #endif

;  Action field 
(defconstant $REMOVE_MANAGED_RESOURCE 1)
; #define REMOVE_MANAGED_RESOURCE		1
(defconstant $ADD_MANAGED_RESOURCE 2)
; #define ADD_MANAGED_RESOURCE		2
(defconstant $GET_FIRST_MANAGED_RESOURCE 3)
; #define GET_FIRST_MANAGED_RESOURCE	3
(defconstant $GET_NEXT_MANAGED_RESOURCE 4)
; #define GET_NEXT_MANAGED_RESOURCE	4
;  Resource field 
(defconstant $RES_MEMORY_RANGE 1)
; #define RES_MEMORY_RANGE		1
(defconstant $RES_IO_RANGE 2)
; #define RES_IO_RANGE			2
(defconstant $RES_IRQ 3)
; #define RES_IRQ				3
;  Attribute field 
(defconstant $RES_IRQ_TYPE 3)
; #define RES_IRQ_TYPE			0x03
(defconstant $RES_IRQ_TYPE_EXCLUSIVE 0)
; #define RES_IRQ_TYPE_EXCLUSIVE		0
(defconstant $RES_IRQ_TYPE_TIME 1)
; #define RES_IRQ_TYPE_TIME		1
(defconstant $RES_IRQ_TYPE_DYNAMIC 2)
; #define RES_IRQ_TYPE_DYNAMIC		2
(defconstant $RES_IRQ_CSC 4)
; #define RES_IRQ_CSC			0x04
(defconstant $RES_SHARED 8)
; #define RES_SHARED			0x08
(defconstant $RES_RESERVED 16)
; #define RES_RESERVED			0x10
(defconstant $RES_ALLOCATED 32)
; #define RES_ALLOCATED			0x20
(defconstant $RES_REMOVED 64)
; #define RES_REMOVED			0x40
(defrecord servinfo_t
   (Signature (:array :character 2))
   (Count :UInt32)
   (Revision :UInt32)
   (CSLevel :UInt32)
   (VendorString (:pointer :char))
)
(defrecord event_callback_args_t
   (client_handle :client_handle_t)
#|
; Warning: type-size: unknown type CLIENT_HANDLE_T
|#
   (info :pointer)
   (mtdrequest :pointer)
   (buffer :pointer)
   (misc :pointer)
   (client_data :pointer)
   (bus (:pointer :bus_operations))
)
;  for GetConfigurationInfo 
(defrecord config_info_t
   (Function :UInt8)
   (Attributes :UInt32)
   (Vcc :UInt32)
   (Vpp1 :UInt32)
   (Vpp2 :UInt32)
   (IntType :UInt32)
   (ConfigBase :UInt32)
   (Status :UInt8)
   (Pin :UInt8)
   (Copy :UInt8)
   (Option :UInt8)
   (ExtStatus :UInt8)
   (Present :UInt32)
   (CardValues :UInt32)
   (AssignedIRQ :UInt32)
   (IRQAttributes :UInt32)
   (BasePort1 :ioaddr_t)
#|
; Warning: type-size: unknown type IOADDR_T
|#
   (NumPorts1 :ioaddr_t)
#|
; Warning: type-size: unknown type IOADDR_T
|#
   (Attributes1 :UInt32)
   (BasePort2 :ioaddr_t)
#|
; Warning: type-size: unknown type IOADDR_T
|#
   (NumPorts2 :ioaddr_t)
#|
; Warning: type-size: unknown type IOADDR_T
|#
   (Attributes2 :UInt32)
   (IOAddrLines :UInt32)
; #ifdef __MACOSX__
   (PCCardNub :pointer)
   (CardBusNub :pointer)
                                                ;  per function

; #endif

)
;  For CardValues field 
(defconstant $CV_OPTION_VALUE 1)
; #define CV_OPTION_VALUE		0x01
(defconstant $CV_STATUS_VALUE 2)
; #define CV_STATUS_VALUE		0x02
(defconstant $CV_PIN_REPLACEMENT 4)
; #define CV_PIN_REPLACEMENT	0x04
(defconstant $CV_COPY_VALUE 8)
; #define CV_COPY_VALUE		0x08
(defconstant $CV_EXT_STATUS 16)
; #define CV_EXT_STATUS		0x10
;  For GetFirst/NextClient 
(defrecord client_req_t
   (Socket :socket_t)
#|
; Warning: type-size: unknown type SOCKET_T
|#
   (Attributes :UInt32)
)
(defconstant $CLIENT_THIS_SOCKET 1)
; #define CLIENT_THIS_SOCKET	0x01
;  For RegisterClient 
(defrecord client_reg_t
   (dev_info (:pointer :dev_info_t))
   (Attributes :UInt32)
   (EventMask :UInt32)
; #ifdef __MACOSX__
   (event_handler (:pointer :callback))         ;(int (cs_event_t event , int priority , event_callback_args_t *))
#| 
; #else
   (event_handler (:pointer :callback))         ;(int (event_t event , int priority , event_callback_args_t *))
 |#

; #endif

   (event_callback_args :EVENT_CALLBACK_ARGS_T)
   (Version :UInt32)
)
;  ModifyConfiguration 
(defrecord modconf_t
   (Attributes :UInt32)
   (Vcc :UInt32)
   (Vpp1 :UInt32)
   (Vpp2 :UInt32))
;  Attributes for ModifyConfiguration 
(defconstant $CONF_IRQ_CHANGE_VALID 256)
; #define CONF_IRQ_CHANGE_VALID	0x100
(defconstant $CONF_VCC_CHANGE_VALID 512)
; #define CONF_VCC_CHANGE_VALID	0x200
(defconstant $CONF_VPP1_CHANGE_VALID 1024)
; #define CONF_VPP1_CHANGE_VALID	0x400
(defconstant $CONF_VPP2_CHANGE_VALID 2048)
; #define CONF_VPP2_CHANGE_VALID	0x800
;  For RequestConfiguration 
(defrecord config_req_t
   (Attributes :UInt32)
   (Vcc :UInt32)
   (Vpp1 :UInt32)
   (Vpp2 :UInt32)
   (IntType :UInt32)
   (ConfigBase :UInt32)
   (Status :UInt8)
   (Pin :UInt8)
   (Copy :UInt8)
   (ExtStatus :UInt8)
   (ConfigIndex :UInt8)
   (Present :UInt32)
)
;  Attributes for RequestConfiguration 
(defconstant $CONF_ENABLE_IRQ 1)
; #define CONF_ENABLE_IRQ		0x01
(defconstant $CONF_ENABLE_DMA 2)
; #define CONF_ENABLE_DMA		0x02
(defconstant $CONF_ENABLE_SPKR 4)
; #define CONF_ENABLE_SPKR	0x04
(defconstant $CONF_VALID_CLIENT 256)
; #define CONF_VALID_CLIENT	0x100
;  IntType field 
(defconstant $INT_MEMORY 1)
; #define INT_MEMORY		0x01
(defconstant $INT_MEMORY_AND_IO 2)
; #define INT_MEMORY_AND_IO	0x02
(defconstant $INT_CARDBUS 4)
; #define INT_CARDBUS		0x04
;  For RequestIO and ReleaseIO 
(defrecord io_req_t
   (BasePort1 :ioaddr_t)
#|
; Warning: type-size: unknown type IOADDR_T
|#
   (NumPorts1 :ioaddr_t)
#|
; Warning: type-size: unknown type IOADDR_T
|#
   (Attributes1 :UInt32)
   (BasePort2 :ioaddr_t)
#|
; Warning: type-size: unknown type IOADDR_T
|#
   (NumPorts2 :ioaddr_t)
#|
; Warning: type-size: unknown type IOADDR_T
|#
   (Attributes2 :UInt32)
   (IOAddrLines :UInt32)
)
;  Attributes for RequestIO and ReleaseIO 
(defconstant $IO_SHARED 1)
; #define IO_SHARED		0x01
(defconstant $IO_FIRST_SHARED 2)
; #define IO_FIRST_SHARED		0x02
(defconstant $IO_FORCE_ALIAS_ACCESS 4)
; #define IO_FORCE_ALIAS_ACCESS	0x04
(defconstant $IO_DATA_PATH_WIDTH 24)
; #define IO_DATA_PATH_WIDTH	0x18
(defconstant $IO_DATA_PATH_WIDTH_8 0)
; #define IO_DATA_PATH_WIDTH_8	0x00
(defconstant $IO_DATA_PATH_WIDTH_16 8)
; #define IO_DATA_PATH_WIDTH_16	0x08
(defconstant $IO_DATA_PATH_WIDTH_AUTO 16)
; #define IO_DATA_PATH_WIDTH_AUTO	0x10
;  For RequestIRQ and ReleaseIRQ 
(defrecord irq_req_t
   (Attributes :UInt32)
   (AssignedIRQ :UInt32)
   (IRQInfo1 :UInt32)
   (IRQInfo2 :UInt32)
   (Handler :pointer)
   (Instance :pointer)
)
;  Attributes for RequestIRQ and ReleaseIRQ 
(defconstant $IRQ_TYPE 3)
; #define IRQ_TYPE			0x03
(defconstant $IRQ_TYPE_EXCLUSIVE 0)
; #define IRQ_TYPE_EXCLUSIVE		0x00
(defconstant $IRQ_TYPE_TIME 1)
; #define IRQ_TYPE_TIME			0x01
(defconstant $IRQ_TYPE_DYNAMIC_SHARING 2)
; #define IRQ_TYPE_DYNAMIC_SHARING	0x02
(defconstant $IRQ_FORCED_PULSE 4)
; #define IRQ_FORCED_PULSE		0x04
(defconstant $IRQ_FIRST_SHARED 8)
; #define IRQ_FIRST_SHARED		0x08
(defconstant $IRQ_HANDLE_PRESENT 16)
; #define IRQ_HANDLE_PRESENT		0x10
(defconstant $IRQ_PULSE_ALLOCATED 256)
; #define IRQ_PULSE_ALLOCATED		0x100
;  Bits in IRQInfo1 field 
(defconstant $IRQ_MASK 15)
; #define IRQ_MASK		0x0f
(defconstant $IRQ_NMI_ID 1)
; #define IRQ_NMI_ID		0x01
(defconstant $IRQ_IOCK_ID 2)
; #define IRQ_IOCK_ID		0x02
(defconstant $IRQ_BERR_ID 4)
; #define IRQ_BERR_ID		0x04
(defconstant $IRQ_VEND_ID 8)
; #define IRQ_VEND_ID		0x08
(defconstant $IRQ_INFO2_VALID 16)
; #define IRQ_INFO2_VALID		0x10
(defconstant $IRQ_LEVEL_ID 32)
; #define IRQ_LEVEL_ID		0x20
(defconstant $IRQ_PULSE_ID 64)
; #define IRQ_PULSE_ID		0x40
(defconstant $IRQ_SHARE_ID 128)
; #define IRQ_SHARE_ID		0x80
(defrecord eventmask_t
   (Attributes :UInt32)
   (EventMask :UInt32)
)
(defconstant $CONF_EVENT_MASK_VALID 1)
; #define CONF_EVENT_MASK_VALID	0x01
;  Configuration registers present 
(defconstant $PRESENT_OPTION 1)
; #define PRESENT_OPTION		0x001
(defconstant $PRESENT_STATUS 2)
; #define PRESENT_STATUS		0x002
(defconstant $PRESENT_PIN_REPLACE 4)
; #define PRESENT_PIN_REPLACE	0x004
(defconstant $PRESENT_COPY 8)
; #define PRESENT_COPY		0x008
(defconstant $PRESENT_EXT_STATUS 16)
; #define PRESENT_EXT_STATUS	0x010
(defconstant $PRESENT_IOBASE_0 32)
; #define PRESENT_IOBASE_0	0x020
(defconstant $PRESENT_IOBASE_1 64)
; #define PRESENT_IOBASE_1	0x040
(defconstant $PRESENT_IOBASE_2 128)
; #define PRESENT_IOBASE_2	0x080
(defconstant $PRESENT_IOBASE_3 256)
; #define PRESENT_IOBASE_3	0x100
(defconstant $PRESENT_IOSIZE 512)
; #define PRESENT_IOSIZE		0x200
;  For GetMemPage, MapMemPage 
(defrecord memreq_t
   (CardOffset :UInt32)
   (Page :page_t)
#|
; Warning: type-size: unknown type PAGE_T
|#
)
;  For ModifyWindow 
(defrecord modwin_t
   (Attributes :UInt32)
   (AccessSpeed :UInt32)
)
;  For RequestWindow 
(defrecord win_req_t
   (Attributes :UInt32)
   (Base :UInt32)
   (Size :UInt32)
   (AccessSpeed :UInt32)
)
;  Attributes for RequestWindow 
(defconstant $WIN_ADDR_SPACE 1)
; #define WIN_ADDR_SPACE		0x0001
(defconstant $WIN_ADDR_SPACE_MEM 0)
; #define WIN_ADDR_SPACE_MEM	0x0000
(defconstant $WIN_ADDR_SPACE_IO 1)
; #define WIN_ADDR_SPACE_IO	0x0001
(defconstant $WIN_MEMORY_TYPE 2)
; #define WIN_MEMORY_TYPE		0x0002
(defconstant $WIN_MEMORY_TYPE_CM 0)
; #define WIN_MEMORY_TYPE_CM	0x0000
(defconstant $WIN_MEMORY_TYPE_AM 2)
; #define WIN_MEMORY_TYPE_AM	0x0002
(defconstant $WIN_ENABLE 4)
; #define WIN_ENABLE		0x0004
(defconstant $WIN_DATA_WIDTH 24)
; #define WIN_DATA_WIDTH		0x0018
(defconstant $WIN_DATA_WIDTH_8 0)
; #define WIN_DATA_WIDTH_8	0x0000
(defconstant $WIN_DATA_WIDTH_16 8)
; #define WIN_DATA_WIDTH_16	0x0008
(defconstant $WIN_DATA_WIDTH_32 16)
; #define WIN_DATA_WIDTH_32	0x0010
(defconstant $WIN_PAGED 32)
; #define WIN_PAGED		0x0020
(defconstant $WIN_SHARED 64)
; #define WIN_SHARED		0x0040
(defconstant $WIN_FIRST_SHARED 128)
; #define WIN_FIRST_SHARED	0x0080
(defconstant $WIN_USE_WAIT 256)
; #define WIN_USE_WAIT		0x0100
(defconstant $WIN_STRICT_ALIGN 512)
; #define WIN_STRICT_ALIGN	0x0200
(defconstant $WIN_MAP_BELOW_1MB 1024)
; #define WIN_MAP_BELOW_1MB	0x0400
(defconstant $WIN_PREFETCH 2048)
; #define WIN_PREFETCH		0x0800
(defconstant $WIN_CACHEABLE 4096)
; #define WIN_CACHEABLE		0x1000
(defconstant $WIN_BAR_MASK 57344)
; #define WIN_BAR_MASK		0xe000
(defconstant $WIN_BAR_SHIFT 13)
; #define WIN_BAR_SHIFT		13
;  Attributes for RegisterClient 
(defconstant $INFO_MASTER_CLIENT 1)
; #define INFO_MASTER_CLIENT	0x01
(defconstant $INFO_IO_CLIENT 2)
; #define INFO_IO_CLIENT		0x02
(defconstant $INFO_MTD_CLIENT 4)
; #define INFO_MTD_CLIENT		0x04
(defconstant $INFO_MEM_CLIENT 8)
; #define INFO_MEM_CLIENT		0x08
(defconstant $MAX_NUM_CLIENTS 3)
; #define MAX_NUM_CLIENTS		3
(defconstant $INFO_CARD_SHARE 16)
; #define INFO_CARD_SHARE		0x10
(defconstant $INFO_CARD_EXCL 32)
; #define INFO_CARD_EXCL		0x20
(defrecord cs_status_t
   (Function :UInt8)
; #ifdef __MACOSX__
   (CardState :cs_event_t)
#|
; Warning: type-size: unknown type CS_EVENT_T
|#
   (SocketState :cs_event_t)
#|
; Warning: type-size: unknown type CS_EVENT_T
|#
#| 
; #else
   (CardState (:pointer :void))
   (SocketState (:pointer :void))
 |#

; #endif

)
(defrecord error_info_t
   (func :signed-long)
   (retcode :signed-long)
)
;  Special stuff for binding drivers to sockets 
(defrecord bind_req_t
   (Socket :socket_t)
#|
; Warning: type-size: unknown type SOCKET_T
|#
   (Function :UInt8)
   (dev_info (:pointer :dev_info_t))
)
;  Flag to bind to all functions 
(defconstant $BIND_FN_ALL 255)
; #define BIND_FN_ALL	0xff
(defrecord mtd_bind_t
   (Socket :socket_t)
#|
; Warning: type-size: unknown type SOCKET_T
|#
   (Attributes :UInt32)
   (CardOffset :UInt32)
   (dev_info (:pointer :dev_info_t))
)
;  Events 
(defconstant $CS_EVENT_PRI_LOW 0)
; #define CS_EVENT_PRI_LOW		0
(defconstant $CS_EVENT_PRI_HIGH 1)
; #define CS_EVENT_PRI_HIGH		1
(defconstant $CS_EVENT_WRITE_PROTECT 1)
; #define CS_EVENT_WRITE_PROTECT		0x000001
(defconstant $CS_EVENT_CARD_LOCK 2)
; #define CS_EVENT_CARD_LOCK		0x000002
(defconstant $CS_EVENT_CARD_INSERTION 4)
; #define CS_EVENT_CARD_INSERTION		0x000004
(defconstant $CS_EVENT_CARD_REMOVAL 8)
; #define CS_EVENT_CARD_REMOVAL		0x000008
(defconstant $CS_EVENT_BATTERY_DEAD 16)
; #define CS_EVENT_BATTERY_DEAD		0x000010
(defconstant $CS_EVENT_BATTERY_LOW 32)
; #define CS_EVENT_BATTERY_LOW		0x000020
(defconstant $CS_EVENT_READY_CHANGE 64)
; #define CS_EVENT_READY_CHANGE		0x000040
(defconstant $CS_EVENT_CARD_DETECT 128)
; #define CS_EVENT_CARD_DETECT		0x000080
(defconstant $CS_EVENT_RESET_REQUEST 256)
; #define CS_EVENT_RESET_REQUEST		0x000100
(defconstant $CS_EVENT_RESET_PHYSICAL 512)
; #define CS_EVENT_RESET_PHYSICAL		0x000200
(defconstant $CS_EVENT_CARD_RESET 1024)
; #define CS_EVENT_CARD_RESET		0x000400
(defconstant $CS_EVENT_REGISTRATION_COMPLETE 2048)
; #define CS_EVENT_REGISTRATION_COMPLETE	0x000800
(defconstant $CS_EVENT_RESET_COMPLETE 4096)
; #define CS_EVENT_RESET_COMPLETE		0x001000
(defconstant $CS_EVENT_PM_SUSPEND 8192)
; #define CS_EVENT_PM_SUSPEND		0x002000
(defconstant $CS_EVENT_PM_RESUME 16384)
; #define CS_EVENT_PM_RESUME		0x004000
(defconstant $CS_EVENT_INSERTION_REQUEST 32768)
; #define CS_EVENT_INSERTION_REQUEST	0x008000
(defconstant $CS_EVENT_EJECTION_REQUEST 65536)
; #define CS_EVENT_EJECTION_REQUEST	0x010000
(defconstant $CS_EVENT_MTD_REQUEST 131072)
; #define CS_EVENT_MTD_REQUEST		0x020000
(defconstant $CS_EVENT_ERASE_COMPLETE 262144)
; #define CS_EVENT_ERASE_COMPLETE		0x040000
(defconstant $CS_EVENT_REQUEST_ATTENTION 524288)
; #define CS_EVENT_REQUEST_ATTENTION	0x080000
(defconstant $CS_EVENT_CB_DETECT 1048576)
; #define CS_EVENT_CB_DETECT		0x100000
(defconstant $CS_EVENT_3VCARD 2097152)
; #define CS_EVENT_3VCARD			0x200000
(defconstant $CS_EVENT_XVCARD 4194304)
; #define CS_EVENT_XVCARD			0x400000
; #ifdef __MACOSX__
(defconstant $CS_EVENT_EJECTION_COMPLETE 8388608)
; #define CS_EVENT_EJECTION_COMPLETE	0x800000

; #endif

;  Return codes 
(defconstant $CS_SUCCESS 0)
; #define CS_SUCCESS		0x00
(defconstant $CS_BAD_ADAPTER 1)
; #define CS_BAD_ADAPTER		0x01
(defconstant $CS_BAD_ATTRIBUTE 2)
; #define CS_BAD_ATTRIBUTE	0x02
(defconstant $CS_BAD_BASE 3)
; #define CS_BAD_BASE		0x03
(defconstant $CS_BAD_EDC 4)
; #define CS_BAD_EDC		0x04
(defconstant $CS_BAD_IRQ 6)
; #define CS_BAD_IRQ		0x06
(defconstant $CS_BAD_OFFSET 7)
; #define CS_BAD_OFFSET		0x07
(defconstant $CS_BAD_PAGE 8)
; #define CS_BAD_PAGE		0x08
(defconstant $CS_READ_FAILURE 9)
; #define CS_READ_FAILURE		0x09
(defconstant $CS_BAD_SIZE 10)
; #define CS_BAD_SIZE		0x0a
(defconstant $CS_BAD_SOCKET 11)
; #define CS_BAD_SOCKET		0x0b
(defconstant $CS_BAD_TYPE 13)
; #define CS_BAD_TYPE		0x0d
(defconstant $CS_BAD_VCC 14)
; #define CS_BAD_VCC		0x0e
(defconstant $CS_BAD_VPP 15)
; #define CS_BAD_VPP		0x0f
(defconstant $CS_BAD_WINDOW 17)
; #define CS_BAD_WINDOW		0x11
(defconstant $CS_WRITE_FAILURE 18)
; #define CS_WRITE_FAILURE	0x12
(defconstant $CS_NO_CARD 20)
; #define CS_NO_CARD		0x14
(defconstant $CS_UNSUPPORTED_FUNCTION 21)
; #define CS_UNSUPPORTED_FUNCTION	0x15
(defconstant $CS_UNSUPPORTED_MODE 22)
; #define CS_UNSUPPORTED_MODE	0x16
(defconstant $CS_BAD_SPEED 23)
; #define CS_BAD_SPEED		0x17
(defconstant $CS_BUSY 24)
; #define CS_BUSY			0x18
(defconstant $CS_GENERAL_FAILURE 25)
; #define CS_GENERAL_FAILURE	0x19
(defconstant $CS_WRITE_PROTECTED 26)
; #define CS_WRITE_PROTECTED	0x1a
(defconstant $CS_BAD_ARG_LENGTH 27)
; #define CS_BAD_ARG_LENGTH	0x1b
(defconstant $CS_BAD_ARGS 28)
; #define CS_BAD_ARGS		0x1c
(defconstant $CS_CONFIGURATION_LOCKED 29)
; #define CS_CONFIGURATION_LOCKED	0x1d
(defconstant $CS_IN_USE 30)
; #define CS_IN_USE		0x1e
(defconstant $CS_NO_MORE_ITEMS 31)
; #define CS_NO_MORE_ITEMS	0x1f
(defconstant $CS_OUT_OF_RESOURCE 32)
; #define CS_OUT_OF_RESOURCE	0x20
(defconstant $CS_BAD_HANDLE 33)
; #define CS_BAD_HANDLE		0x21
(defconstant $CS_BAD_TUPLE 64)
; #define CS_BAD_TUPLE		0x40
; MACOSX #ifdef __KERNEL__
; #ifdef KERNEL
#| #|




typedef int (*ss_entry_t)(u_int sock, u_int cmd, void *arg);
#ifdef__MACOSX__
extern int register_ss_entry(int ssock, int esock, ss_entry_t entry);
#elseextern int register_ss_entry(int nsock, ss_entry_t entry);
#endifextern void unregister_ss_entry(ss_entry_t entry);



enum service {
    AccessConfigurationRegister, AddSocketServices,
    AdjustResourceInfo, CheckEraseQueue, CloseMemory, CopyMemory,
    DeregisterClient, DeregisterEraseQueue, GetCardServicesInfo,
    GetClientInfo, GetConfigurationInfo, GetEventMask,
    GetFirstClient, GetFirstPartion, GetFirstRegion, GetFirstTuple,
    GetNextClient, GetNextPartition, GetNextRegion, GetNextTuple,
    GetStatus, GetTupleData, MapLogSocket, MapLogWindow, MapMemPage,
    MapPhySocket, MapPhyWindow, ModifyConfiguration, ModifyWindow,
    OpenMemory, ParseTuple, ReadMemory, RegisterClient,
    RegisterEraseQueue, RegisterMTD, RegisterTimer,
    ReleaseConfiguration, ReleaseExclusive, ReleaseIO, ReleaseIRQ,
    ReleaseSocketMask, ReleaseWindow, ReplaceSocketServices,
    RequestConfiguration, RequestExclusive, RequestIO, RequestIRQ,
    RequestSocketMask, RequestWindow, ResetCard, ReturnSSEntry,
    SetEventMask, SetRegion, ValidateCIS, VendorSpecific,
    WriteMemory, BindDevice, BindMTD, ReportError,
    SuspendCard, ResumeCard, EjectCard, InsertCard, ReplaceCIS,
    GetFirstWindow, GetNextWindow, GetMemPage
};

#ifdefIN_CARD_SERVICES
extern int CardServices(int func, void *a1, void *a2, void *a3);
#else#ifndef__MACOSX__  
extern int CardServices(int func, ...);
#endif#endif
#ifdef__BEOS__
#define SS_MODULE_NAME(s)	("bussespcmcia" s "v1")
#define MTD_MODULE_NAME(s)	("bussespcmcia" s "v1")
#define CS_CLIENT_MODULE_NAME	"bus_managerspcmcia_csclientv1"
typedef struct cs_client_module_info {
    bus_manager_info	binfo;
    int (*_CardServices)(int, ...);
    int (*_MTDHelperEntry)(int, ...);
    void (*_add_timer)(struct timer_list *);
    void (*_del_timer)(struct timer_list *);
} cs_client_module_info;
#define CS_SOCKET_MODULE_NAME "bus_managerspcmcia_cssocketv1"
typedef struct cs_socket_module_info {
    bus_manager_info	binfo;
    int (*_register_ss_entry)(int, ss_entry_t);
    void (*_unregister_ss_entry)(ss_entry_t);
    void (*_add_timer)(struct timer_list *);
    void (*_del_timer)(struct timer_list *);
    int (*register_resource)(int, u_long, u_long);
    int (*release_resource)(int, u_long, u_long);
    int (*check_resource)(int, u_long, u_long);
} cs_socket_module_info;
#endif
#endif
|#
 |#
;  __KERNEL__ 

; #endif /* _LINUX_CS_H */


(provide-interface "cs")