(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:cistpl.h"
; at Sunday July 2,2006 7:27:22 pm.
; 
;  * cistpl.h 1.34 2000/06/19 23:18:12
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
; #ifndef _LINUX_CISTPL_H
; #define _LINUX_CISTPL_H
(defconstant $CISTPL_NULL 0)
; #define CISTPL_NULL		0x00
(defconstant $CISTPL_DEVICE 1)
; #define CISTPL_DEVICE		0x01
(defconstant $CISTPL_LONGLINK_CB 2)
; #define CISTPL_LONGLINK_CB	0x02
(defconstant $CISTPL_INDIRECT 3)
; #define CISTPL_INDIRECT		0x03
(defconstant $CISTPL_CONFIG_CB 4)
; #define CISTPL_CONFIG_CB	0x04
(defconstant $CISTPL_CFTABLE_ENTRY_CB 5)
; #define CISTPL_CFTABLE_ENTRY_CB	0x05
(defconstant $CISTPL_LONGLINK_MFC 6)
; #define CISTPL_LONGLINK_MFC	0x06
(defconstant $CISTPL_BAR 7)
; #define CISTPL_BAR		0x07
(defconstant $CISTPL_PWR_MGMNT 8)
; #define CISTPL_PWR_MGMNT	0x08
(defconstant $CISTPL_EXTDEVICE 9)
; #define CISTPL_EXTDEVICE	0x09
(defconstant $CISTPL_CHECKSUM 16)
; #define CISTPL_CHECKSUM		0x10
(defconstant $CISTPL_LONGLINK_A 17)
; #define CISTPL_LONGLINK_A	0x11
(defconstant $CISTPL_LONGLINK_C 18)
; #define CISTPL_LONGLINK_C	0x12
(defconstant $CISTPL_LINKTARGET 19)
; #define CISTPL_LINKTARGET	0x13
(defconstant $CISTPL_NO_LINK 20)
; #define CISTPL_NO_LINK		0x14
(defconstant $CISTPL_VERS_1 21)
; #define CISTPL_VERS_1		0x15
(defconstant $CISTPL_ALTSTR 22)
; #define CISTPL_ALTSTR		0x16
(defconstant $CISTPL_DEVICE_A 23)
; #define CISTPL_DEVICE_A		0x17
(defconstant $CISTPL_JEDEC_C 24)
; #define CISTPL_JEDEC_C		0x18
(defconstant $CISTPL_JEDEC_A 25)
; #define CISTPL_JEDEC_A		0x19
(defconstant $CISTPL_CONFIG 26)
; #define CISTPL_CONFIG		0x1a
(defconstant $CISTPL_CFTABLE_ENTRY 27)
; #define CISTPL_CFTABLE_ENTRY	0x1b
(defconstant $CISTPL_DEVICE_OC 28)
; #define CISTPL_DEVICE_OC	0x1c
(defconstant $CISTPL_DEVICE_OA 29)
; #define CISTPL_DEVICE_OA	0x1d
(defconstant $CISTPL_DEVICE_GEO 30)
; #define CISTPL_DEVICE_GEO	0x1e
(defconstant $CISTPL_DEVICE_GEO_A 31)
; #define CISTPL_DEVICE_GEO_A	0x1f
(defconstant $CISTPL_MANFID 32)
; #define CISTPL_MANFID		0x20
(defconstant $CISTPL_FUNCID 33)
; #define CISTPL_FUNCID		0x21
(defconstant $CISTPL_FUNCE 34)
; #define CISTPL_FUNCE		0x22
(defconstant $CISTPL_SWIL 35)
; #define CISTPL_SWIL		0x23
(defconstant $CISTPL_END 255)
; #define CISTPL_END		0xff
;  Layer 2 tuples 
(defconstant $CISTPL_VERS_2 64)
; #define CISTPL_VERS_2		0x40
(defconstant $CISTPL_FORMAT 65)
; #define CISTPL_FORMAT		0x41
(defconstant $CISTPL_GEOMETRY 66)
; #define CISTPL_GEOMETRY		0x42
(defconstant $CISTPL_BYTEORDER 67)
; #define CISTPL_BYTEORDER	0x43
(defconstant $CISTPL_DATE 68)
; #define CISTPL_DATE		0x44
(defconstant $CISTPL_BATTERY 69)
; #define CISTPL_BATTERY		0x45
(defconstant $CISTPL_FORMAT_A 71)
; #define CISTPL_FORMAT_A		0x47
;  Layer 3 tuples 
(defconstant $CISTPL_ORG 70)
; #define CISTPL_ORG		0x46
(defconstant $CISTPL_SPCL 144)
; #define CISTPL_SPCL		0x90
(defrecord cistpl_longlink_t
   (addr :UInt32)
)
(defrecord cistpl_checksum_t
   (addr :UInt16)
   (len :UInt16)
   (sum :UInt8)
)
(defconstant $CISTPL_MAX_FUNCTIONS 8)
; #define CISTPL_MAX_FUNCTIONS	8
(defconstant $CISTPL_MFC_ATTR 0)
; #define CISTPL_MFC_ATTR		0x00
(defconstant $CISTPL_MFC_COMMON 1)
; #define CISTPL_MFC_COMMON	0x01
(defrecord cistpl_longlink_mfc_t
   (nfn :UInt8)
   (space :UInt8)
   (addr :UInt32)
)
(defconstant $CISTPL_MAX_ALTSTR_STRINGS 4)
; #define CISTPL_MAX_ALTSTR_STRINGS	4
(defrecord cistpl_altstr_t
   (ns :UInt8)
   (ofs (:array :UInt8 4))
   (str (:array :character 254))
)
(defconstant $CISTPL_DTYPE_NULL 0)
; #define CISTPL_DTYPE_NULL	0x00
(defconstant $CISTPL_DTYPE_ROM 1)
; #define CISTPL_DTYPE_ROM	0x01
(defconstant $CISTPL_DTYPE_OTPROM 2)
; #define CISTPL_DTYPE_OTPROM	0x02
(defconstant $CISTPL_DTYPE_EPROM 3)
; #define CISTPL_DTYPE_EPROM	0x03
(defconstant $CISTPL_DTYPE_EEPROM 4)
; #define CISTPL_DTYPE_EEPROM	0x04
(defconstant $CISTPL_DTYPE_FLASH 5)
; #define CISTPL_DTYPE_FLASH	0x05
(defconstant $CISTPL_DTYPE_SRAM 6)
; #define CISTPL_DTYPE_SRAM	0x06
(defconstant $CISTPL_DTYPE_DRAM 7)
; #define CISTPL_DTYPE_DRAM	0x07
(defconstant $CISTPL_DTYPE_FUNCSPEC 13)
; #define CISTPL_DTYPE_FUNCSPEC	0x0d
(defconstant $CISTPL_DTYPE_EXTEND 14)
; #define CISTPL_DTYPE_EXTEND	0x0e
(defconstant $CISTPL_MAX_DEVICES 4)
; #define CISTPL_MAX_DEVICES	4
(defrecord cistpl_device_t
   (ndev :UInt8)
   (type :UInt8)
   (wp :UInt8)
   (speed :UInt32)
   (size :UInt32)
)
(defconstant $CISTPL_DEVICE_MWAIT 1)
; #define CISTPL_DEVICE_MWAIT	0x01
(defconstant $CISTPL_DEVICE_3VCC 2)
; #define CISTPL_DEVICE_3VCC	0x02
(defrecord cistpl_device_o_t
   (flags :UInt8)
   (device :CISTPL_DEVICE_T)
)
(defconstant $CISTPL_VERS_1_MAX_PROD_STRINGS 4)
; #define CISTPL_VERS_1_MAX_PROD_STRINGS	4
(defrecord cistpl_vers_1_t
   (major :UInt8)
   (minor :UInt8)
   (ns :UInt8)
   (ofs (:array :UInt8 4))
   (str (:array :character 254))
)
(defrecord cistpl_jedec_t
   (nid :UInt8)
   (mfr :UInt8)
   (info :UInt8)
)
(defrecord cistpl_manfid_t
   (manf :UInt16)
   (card :UInt16)
)
(defconstant $CISTPL_FUNCID_MULTI 0)
; #define CISTPL_FUNCID_MULTI	0x00
(defconstant $CISTPL_FUNCID_MEMORY 1)
; #define CISTPL_FUNCID_MEMORY	0x01
(defconstant $CISTPL_FUNCID_SERIAL 2)
; #define CISTPL_FUNCID_SERIAL	0x02
(defconstant $CISTPL_FUNCID_PARALLEL 3)
; #define CISTPL_FUNCID_PARALLEL	0x03
(defconstant $CISTPL_FUNCID_FIXED 4)
; #define CISTPL_FUNCID_FIXED	0x04
(defconstant $CISTPL_FUNCID_VIDEO 5)
; #define CISTPL_FUNCID_VIDEO	0x05
(defconstant $CISTPL_FUNCID_NETWORK 6)
; #define CISTPL_FUNCID_NETWORK	0x06
(defconstant $CISTPL_FUNCID_AIMS 7)
; #define CISTPL_FUNCID_AIMS	0x07
(defconstant $CISTPL_FUNCID_SCSI 8)
; #define CISTPL_FUNCID_SCSI	0x08
; #ifdef __MACOSX__
(defconstant $CISTPL_FUNCID_SECURITY 9)
; #define CISTPL_FUNCID_SECURITY	0x09
(defconstant $CISTPL_FUNCID_INSTRUMENT 10)
; #define CISTPL_FUNCID_INSTRUMENT 0x0a
(defconstant $CISTPL_FUNCID_MAX_ID 10)
; #define CISTPL_FUNCID_MAX_ID	0x0a
(defconstant $CISTPL_FUNCID_VENDOR 254)
; #define CISTPL_FUNCID_VENDOR	0xfe
(defconstant $CISTPL_FUNCID_INVALID 255)
; #define CISTPL_FUNCID_INVALID	0xff

; #endif

(defconstant $CISTPL_SYSINIT_POST 1)
; #define CISTPL_SYSINIT_POST	0x01
(defconstant $CISTPL_SYSINIT_ROM 2)
; #define CISTPL_SYSINIT_ROM	0x02
(defrecord cistpl_funcid_t
   (func :UInt8)
   (sysinit :UInt8)
)
(defrecord cistpl_funce_t
   (type :UInt8)
   (data (:array :UInt8 0))
)
; ======================================================================
; 
;     Modem Function Extension Tuples
; 
; ======================================================================
(defconstant $CISTPL_FUNCE_SERIAL_IF 0)
; #define CISTPL_FUNCE_SERIAL_IF		0x00
(defconstant $CISTPL_FUNCE_SERIAL_CAP 1)
; #define CISTPL_FUNCE_SERIAL_CAP		0x01
(defconstant $CISTPL_FUNCE_SERIAL_SERV_DATA 2)
; #define CISTPL_FUNCE_SERIAL_SERV_DATA	0x02
(defconstant $CISTPL_FUNCE_SERIAL_SERV_FAX 3)
; #define CISTPL_FUNCE_SERIAL_SERV_FAX	0x03
(defconstant $CISTPL_FUNCE_SERIAL_SERV_VOICE 4)
; #define CISTPL_FUNCE_SERIAL_SERV_VOICE	0x04
(defconstant $CISTPL_FUNCE_SERIAL_CAP_DATA 5)
; #define CISTPL_FUNCE_SERIAL_CAP_DATA	0x05
(defconstant $CISTPL_FUNCE_SERIAL_CAP_FAX 6)
; #define CISTPL_FUNCE_SERIAL_CAP_FAX	0x06
(defconstant $CISTPL_FUNCE_SERIAL_CAP_VOICE 7)
; #define CISTPL_FUNCE_SERIAL_CAP_VOICE	0x07
(defconstant $CISTPL_FUNCE_SERIAL_IF_DATA 8)
; #define CISTPL_FUNCE_SERIAL_IF_DATA	0x08
(defconstant $CISTPL_FUNCE_SERIAL_IF_FAX 9)
; #define CISTPL_FUNCE_SERIAL_IF_FAX	0x09
(defconstant $CISTPL_FUNCE_SERIAL_IF_VOICE 10)
; #define CISTPL_FUNCE_SERIAL_IF_VOICE	0x0a
;  UART identification 
(defconstant $CISTPL_SERIAL_UART_8250 0)
; #define CISTPL_SERIAL_UART_8250		0x00
(defconstant $CISTPL_SERIAL_UART_16450 1)
; #define CISTPL_SERIAL_UART_16450	0x01
(defconstant $CISTPL_SERIAL_UART_16550 2)
; #define CISTPL_SERIAL_UART_16550	0x02
(defconstant $CISTPL_SERIAL_UART_8251 3)
; #define CISTPL_SERIAL_UART_8251		0x03
(defconstant $CISTPL_SERIAL_UART_8530 4)
; #define CISTPL_SERIAL_UART_8530		0x04
(defconstant $CISTPL_SERIAL_UART_85230 5)
; #define CISTPL_SERIAL_UART_85230	0x05
;  UART capabilities 
(defconstant $CISTPL_SERIAL_UART_SPACE 1)
; #define CISTPL_SERIAL_UART_SPACE	0x01
(defconstant $CISTPL_SERIAL_UART_MARK 2)
; #define CISTPL_SERIAL_UART_MARK		0x02
(defconstant $CISTPL_SERIAL_UART_ODD 4)
; #define CISTPL_SERIAL_UART_ODD		0x04
(defconstant $CISTPL_SERIAL_UART_EVEN 8)
; #define CISTPL_SERIAL_UART_EVEN		0x08
(defconstant $CISTPL_SERIAL_UART_5BIT 1)
; #define CISTPL_SERIAL_UART_5BIT		0x01
(defconstant $CISTPL_SERIAL_UART_6BIT 2)
; #define CISTPL_SERIAL_UART_6BIT		0x02
(defconstant $CISTPL_SERIAL_UART_7BIT 4)
; #define CISTPL_SERIAL_UART_7BIT		0x04
(defconstant $CISTPL_SERIAL_UART_8BIT 8)
; #define CISTPL_SERIAL_UART_8BIT		0x08
(defconstant $CISTPL_SERIAL_UART_1STOP 16)
; #define CISTPL_SERIAL_UART_1STOP	0x10
(defconstant $CISTPL_SERIAL_UART_MSTOP 32)
; #define CISTPL_SERIAL_UART_MSTOP	0x20
(defconstant $CISTPL_SERIAL_UART_2STOP 64)
; #define CISTPL_SERIAL_UART_2STOP	0x40
(defrecord cistpl_serial_t
   (uart_type :UInt8)
   (uart_cap_0 :UInt8)
   (uart_cap_1 :UInt8)
)
(defrecord cistpl_modem_cap_t
   (flow :UInt8)
   (cmd_buf :UInt8)
   (rcv_buf_0 :UInt8)
   (rcv_buf_1 :UInt8)
   (rcv_buf_2 :UInt8)
   (xmit_buf_0 :UInt8)
   (xmit_buf_1 :UInt8)
   (xmit_buf_2 :UInt8))
(defconstant $CISTPL_SERIAL_MOD_103 1)
; #define CISTPL_SERIAL_MOD_103		0x01
(defconstant $CISTPL_SERIAL_MOD_V21 2)
; #define CISTPL_SERIAL_MOD_V21		0x02
(defconstant $CISTPL_SERIAL_MOD_V23 4)
; #define CISTPL_SERIAL_MOD_V23		0x04
(defconstant $CISTPL_SERIAL_MOD_V22 8)
; #define CISTPL_SERIAL_MOD_V22		0x08
(defconstant $CISTPL_SERIAL_MOD_212A 16)
; #define CISTPL_SERIAL_MOD_212A		0x10
(defconstant $CISTPL_SERIAL_MOD_V22BIS 32)
; #define CISTPL_SERIAL_MOD_V22BIS	0x20
(defconstant $CISTPL_SERIAL_MOD_V26 64)
; #define CISTPL_SERIAL_MOD_V26		0x40
(defconstant $CISTPL_SERIAL_MOD_V26BIS 128)
; #define CISTPL_SERIAL_MOD_V26BIS	0x80
(defconstant $CISTPL_SERIAL_MOD_V27BIS 1)
; #define CISTPL_SERIAL_MOD_V27BIS	0x01
(defconstant $CISTPL_SERIAL_MOD_V29 2)
; #define CISTPL_SERIAL_MOD_V29		0x02
(defconstant $CISTPL_SERIAL_MOD_V32 4)
; #define CISTPL_SERIAL_MOD_V32		0x04
(defconstant $CISTPL_SERIAL_MOD_V32BIS 8)
; #define CISTPL_SERIAL_MOD_V32BIS	0x08
(defconstant $CISTPL_SERIAL_MOD_V34 16)
; #define CISTPL_SERIAL_MOD_V34		0x10
(defconstant $CISTPL_SERIAL_ERR_MNP2_4 1)
; #define CISTPL_SERIAL_ERR_MNP2_4	0x01
(defconstant $CISTPL_SERIAL_ERR_V42_LAPM 2)
; #define CISTPL_SERIAL_ERR_V42_LAPM	0x02
(defconstant $CISTPL_SERIAL_CMPR_V42BIS 1)
; #define CISTPL_SERIAL_CMPR_V42BIS	0x01
(defconstant $CISTPL_SERIAL_CMPR_MNP5 2)
; #define CISTPL_SERIAL_CMPR_MNP5		0x02
(defconstant $CISTPL_SERIAL_CMD_AT1 1)
; #define CISTPL_SERIAL_CMD_AT1		0x01
(defconstant $CISTPL_SERIAL_CMD_AT2 2)
; #define CISTPL_SERIAL_CMD_AT2		0x02
(defconstant $CISTPL_SERIAL_CMD_AT3 4)
; #define CISTPL_SERIAL_CMD_AT3		0x04
(defconstant $CISTPL_SERIAL_CMD_MNP_AT 8)
; #define CISTPL_SERIAL_CMD_MNP_AT	0x08
(defconstant $CISTPL_SERIAL_CMD_V25BIS 16)
; #define CISTPL_SERIAL_CMD_V25BIS	0x10
(defconstant $CISTPL_SERIAL_CMD_V25A 32)
; #define CISTPL_SERIAL_CMD_V25A		0x20
(defconstant $CISTPL_SERIAL_CMD_DMCL 64)
; #define CISTPL_SERIAL_CMD_DMCL		0x40
(defrecord cistpl_data_serv_t
   (max_data_0 :UInt8)
   (max_data_1 :UInt8)
   (modulation_0 :UInt8)
   (modulation_1 :UInt8)
   (error_control :UInt8)
   (compression :UInt8)
   (cmd_protocol :UInt8)
   (escape :UInt8)
   (encrypt :UInt8)
   (misc_features :UInt8)
   (ccitt_code (:array :UInt8 0))
)
(defrecord cistpl_fax_serv_t
   (max_data_0 :UInt8)
   (max_data_1 :UInt8)
   (modulation :UInt8)
   (encrypt :UInt8)
   (features_0 :UInt8)
   (features_1 :UInt8)
   (ccitt_code (:array :UInt8 0))
)
(defrecord cistpl_voice_serv_t
   (max_data_0 :UInt8)
   (max_data_1 :UInt8)
)
; ======================================================================
; 
;     LAN Function Extension Tuples
; 
; ======================================================================
(defconstant $CISTPL_FUNCE_LAN_TECH 1)
; #define CISTPL_FUNCE_LAN_TECH		0x01
(defconstant $CISTPL_FUNCE_LAN_SPEED 2)
; #define CISTPL_FUNCE_LAN_SPEED		0x02
(defconstant $CISTPL_FUNCE_LAN_MEDIA 3)
; #define CISTPL_FUNCE_LAN_MEDIA		0x03
(defconstant $CISTPL_FUNCE_LAN_NODE_ID 4)
; #define CISTPL_FUNCE_LAN_NODE_ID	0x04
(defconstant $CISTPL_FUNCE_LAN_CONNECTOR 5)
; #define CISTPL_FUNCE_LAN_CONNECTOR	0x05
;  LAN technologies 
(defconstant $CISTPL_LAN_TECH_ARCNET 1)
; #define CISTPL_LAN_TECH_ARCNET		0x01
(defconstant $CISTPL_LAN_TECH_ETHERNET 2)
; #define CISTPL_LAN_TECH_ETHERNET	0x02
(defconstant $CISTPL_LAN_TECH_TOKENRING 3)
; #define CISTPL_LAN_TECH_TOKENRING	0x03
(defconstant $CISTPL_LAN_TECH_LOCALTALK 4)
; #define CISTPL_LAN_TECH_LOCALTALK	0x04
(defconstant $CISTPL_LAN_TECH_FDDI 5)
; #define CISTPL_LAN_TECH_FDDI		0x05
(defconstant $CISTPL_LAN_TECH_ATM 6)
; #define CISTPL_LAN_TECH_ATM		0x06
(defconstant $CISTPL_LAN_TECH_WIRELESS 7)
; #define CISTPL_LAN_TECH_WIRELESS	0x07
(defrecord cistpl_lan_tech_t
   (tech :UInt8)
)
(defrecord cistpl_lan_speed_t
   (speed :UInt32)
)
;  LAN media definitions 
(defconstant $CISTPL_LAN_MEDIA_UTP 1)
; #define CISTPL_LAN_MEDIA_UTP		0x01
(defconstant $CISTPL_LAN_MEDIA_STP 2)
; #define CISTPL_LAN_MEDIA_STP		0x02
(defconstant $CISTPL_LAN_MEDIA_THIN_COAX 3)
; #define CISTPL_LAN_MEDIA_THIN_COAX	0x03
(defconstant $CISTPL_LAN_MEDIA_THICK_COAX 4)
; #define CISTPL_LAN_MEDIA_THICK_COAX	0x04
(defconstant $CISTPL_LAN_MEDIA_FIBER 5)
; #define CISTPL_LAN_MEDIA_FIBER		0x05
(defconstant $CISTPL_LAN_MEDIA_900MHZ 6)
; #define CISTPL_LAN_MEDIA_900MHZ		0x06
(defconstant $CISTPL_LAN_MEDIA_2GHZ 7)
; #define CISTPL_LAN_MEDIA_2GHZ		0x07
(defconstant $CISTPL_LAN_MEDIA_5GHZ 8)
; #define CISTPL_LAN_MEDIA_5GHZ		0x08
(defconstant $CISTPL_LAN_MEDIA_DIFF_IR 9)
; #define CISTPL_LAN_MEDIA_DIFF_IR	0x09
(defconstant $CISTPL_LAN_MEDIA_PTP_IR 10)
; #define CISTPL_LAN_MEDIA_PTP_IR		0x0a
(defrecord cistpl_lan_media_t
   (media :UInt8)
)
(defrecord cistpl_lan_node_id_t
   (nb :UInt8)
   (id (:array :UInt8 16))
)
(defrecord cistpl_lan_connector_t
   (code :UInt8)
)
; ======================================================================
; 
;     IDE Function Extension Tuples
; 
; ======================================================================
(defconstant $CISTPL_IDE_INTERFACE 1)
; #define CISTPL_IDE_INTERFACE		0x01
(defrecord cistpl_ide_interface_t
   (interface :UInt8)
)
;  First feature byte 
(defconstant $CISTPL_IDE_SILICON 4)
; #define CISTPL_IDE_SILICON		0x04
(defconstant $CISTPL_IDE_UNIQUE 8)
; #define CISTPL_IDE_UNIQUE		0x08
(defconstant $CISTPL_IDE_DUAL 16)
; #define CISTPL_IDE_DUAL			0x10
;  Second feature byte 
(defconstant $CISTPL_IDE_HAS_SLEEP 1)
; #define CISTPL_IDE_HAS_SLEEP		0x01
(defconstant $CISTPL_IDE_HAS_STANDBY 2)
; #define CISTPL_IDE_HAS_STANDBY		0x02
(defconstant $CISTPL_IDE_HAS_IDLE 4)
; #define CISTPL_IDE_HAS_IDLE		0x04
(defconstant $CISTPL_IDE_LOW_POWER 8)
; #define CISTPL_IDE_LOW_POWER		0x08
(defconstant $CISTPL_IDE_REG_INHIBIT 16)
; #define CISTPL_IDE_REG_INHIBIT		0x10
(defconstant $CISTPL_IDE_HAS_INDEX 32)
; #define CISTPL_IDE_HAS_INDEX		0x20
(defconstant $CISTPL_IDE_IOIS16 64)
; #define CISTPL_IDE_IOIS16		0x40
(defrecord cistpl_ide_feature_t
   (feature1 :UInt8)
   (feature2 :UInt8)
)
(defconstant $CISTPL_FUNCE_IDE_IFACE 1)
; #define CISTPL_FUNCE_IDE_IFACE		0x01
(defconstant $CISTPL_FUNCE_IDE_MASTER 2)
; #define CISTPL_FUNCE_IDE_MASTER		0x02
(defconstant $CISTPL_FUNCE_IDE_SLAVE 3)
; #define CISTPL_FUNCE_IDE_SLAVE		0x03
; ======================================================================
; 
;     Configuration Table Entries
; 
; ======================================================================
(defconstant $CISTPL_BAR_SPACE 7)
; #define CISTPL_BAR_SPACE	0x07
(defconstant $CISTPL_BAR_SPACE_IO 16)
; #define CISTPL_BAR_SPACE_IO	0x10
(defconstant $CISTPL_BAR_PREFETCH 32)
; #define CISTPL_BAR_PREFETCH	0x20
(defconstant $CISTPL_BAR_CACHEABLE 64)
; #define CISTPL_BAR_CACHEABLE	0x40
(defconstant $CISTPL_BAR_1MEG_MAP 128)
; #define CISTPL_BAR_1MEG_MAP	0x80
(defrecord cistpl_bar_t
   (attr :UInt8)
   (size :UInt32)
)
(defrecord cistpl_config_t
   (last_idx :UInt8)
   (base :UInt32)
   (rmask (:array :UInt32 4))
   (subtuples :UInt8)
)
;  These are bits in the 'present' field, and indices in 'param' 
(defconstant $CISTPL_POWER_VNOM 0)
; #define CISTPL_POWER_VNOM	0
(defconstant $CISTPL_POWER_VMIN 1)
; #define CISTPL_POWER_VMIN	1
(defconstant $CISTPL_POWER_VMAX 2)
; #define CISTPL_POWER_VMAX	2
(defconstant $CISTPL_POWER_ISTATIC 3)
; #define CISTPL_POWER_ISTATIC	3
(defconstant $CISTPL_POWER_IAVG 4)
; #define CISTPL_POWER_IAVG	4
(defconstant $CISTPL_POWER_IPEAK 5)
; #define CISTPL_POWER_IPEAK	5
(defconstant $CISTPL_POWER_IDOWN 6)
; #define CISTPL_POWER_IDOWN	6
(defconstant $CISTPL_POWER_HIGHZ_OK 1)
; #define CISTPL_POWER_HIGHZ_OK	0x01
(defconstant $CISTPL_POWER_HIGHZ_REQ 2)
; #define CISTPL_POWER_HIGHZ_REQ	0x02
(defrecord cistpl_power_t
   (present :UInt8)
   (flags :UInt8)
   (param (:array :UInt32 7))
)
(defrecord cistpl_timing_t
   (wait :UInt32)
   (waitscale :UInt32)
   (ready :UInt32)
   (rdyscale :UInt32)
   (reserved :UInt32)
   (rsvscale :UInt32))
(defconstant $CISTPL_IO_LINES_MASK 31)
; #define CISTPL_IO_LINES_MASK	0x1f
(defconstant $CISTPL_IO_8BIT 32)
; #define CISTPL_IO_8BIT		0x20
(defconstant $CISTPL_IO_16BIT 64)
; #define CISTPL_IO_16BIT		0x40
(defconstant $CISTPL_IO_RANGE 128)
; #define CISTPL_IO_RANGE		0x80
(defconstant $CISTPL_IO_MAX_WIN 16)
; #define CISTPL_IO_MAX_WIN	16
(defrecord cistpl_io_t
   (flags :UInt8)
   (nwin :UInt8)
   (base :UInt32)
   (len :UInt32)
)
(defrecord cistpl_irq_t
   (IRQInfo1 :UInt32)
   (IRQInfo2 :UInt32)
)
(defconstant $CISTPL_MEM_MAX_WIN 8)
; #define CISTPL_MEM_MAX_WIN	8
(defrecord cistpl_mem_t
   (flags :UInt8)
   (nwin :UInt8)
   (len :UInt32)
   (card_addr :UInt32)
   (host_addr :UInt32)
)
(defconstant $CISTPL_CFTABLE_DEFAULT 1)
; #define CISTPL_CFTABLE_DEFAULT		0x0001
(defconstant $CISTPL_CFTABLE_BVDS 2)
; #define CISTPL_CFTABLE_BVDS		0x0002
(defconstant $CISTPL_CFTABLE_WP 4)
; #define CISTPL_CFTABLE_WP		0x0004
(defconstant $CISTPL_CFTABLE_RDYBSY 8)
; #define CISTPL_CFTABLE_RDYBSY		0x0008
(defconstant $CISTPL_CFTABLE_MWAIT 16)
; #define CISTPL_CFTABLE_MWAIT		0x0010
(defconstant $CISTPL_CFTABLE_AUDIO 2048)
; #define CISTPL_CFTABLE_AUDIO		0x0800
(defconstant $CISTPL_CFTABLE_READONLY 4096)
; #define CISTPL_CFTABLE_READONLY		0x1000
(defconstant $CISTPL_CFTABLE_PWRDOWN 8192)
; #define CISTPL_CFTABLE_PWRDOWN		0x2000
; #ifdef __MACOSX__
(defconstant $CISTPL_CFTABLE_IF_PRESENT 32768)
; #define CISTPL_CFTABLE_IF_PRESENT	0x8000

; #endif

(defrecord cistpl_cftable_entry_t
   (index :UInt8)
   (flags :UInt16)
   (interface :UInt8)
   (vcc :CISTPL_POWER_T)
   (vpp1 :CISTPL_POWER_T)
   (vpp2 :CISTPL_POWER_T)
   (timing :CISTPL_TIMING_T)
   (io :CISTPL_IO_T)
   (irq :CISTPL_IRQ_T)
   (mem :CISTPL_MEM_T)
   (subtuples :UInt8)
)
(defconstant $CISTPL_CFTABLE_MASTER 256)
; #define CISTPL_CFTABLE_MASTER		0x000100
(defconstant $CISTPL_CFTABLE_INVALIDATE 512)
; #define CISTPL_CFTABLE_INVALIDATE	0x000200
(defconstant $CISTPL_CFTABLE_VGA_PALETTE 1024)
; #define CISTPL_CFTABLE_VGA_PALETTE	0x000400
(defconstant $CISTPL_CFTABLE_PARITY 2048)
; #define CISTPL_CFTABLE_PARITY		0x000800
(defconstant $CISTPL_CFTABLE_WAIT 4096)
; #define CISTPL_CFTABLE_WAIT		0x001000
(defconstant $CISTPL_CFTABLE_SERR 8192)
; #define CISTPL_CFTABLE_SERR		0x002000
(defconstant $CISTPL_CFTABLE_FAST_BACK 16384)
; #define CISTPL_CFTABLE_FAST_BACK	0x004000
(defconstant $CISTPL_CFTABLE_BINARY_AUDIO 65536)
; #define CISTPL_CFTABLE_BINARY_AUDIO	0x010000
(defconstant $CISTPL_CFTABLE_PWM_AUDIO 131072)
; #define CISTPL_CFTABLE_PWM_AUDIO	0x020000
(defrecord cistpl_cftable_entry_cb_t
   (index :UInt8)
   (flags :UInt32)
   (vcc :CISTPL_POWER_T)
   (vpp1 :CISTPL_POWER_T)
   (vpp2 :CISTPL_POWER_T)
   (io :UInt8)
   (irq :CISTPL_IRQ_T)
   (mem :UInt8)
   (subtuples :UInt8)
)
(defrecord cistpl_device_geo_t
   (ngeo :UInt8)
   (buswidth :UInt8)
   (erase_block :UInt32)
   (read_block :UInt32)
   (write_block :UInt32)
   (partition :UInt32)
   (interleave :UInt32)
)
(defrecord cistpl_vers_2_t
   (vers :UInt8)
   (comply :UInt8)
   (dindex :UInt16)
   (vspec8 :UInt8)
   (vspec9 :UInt8)
   (nhdr :UInt8)
   (vendor :UInt8)
   (info :UInt8)   (str (:array :character 244))
)
(defrecord cistpl_org_t
   (data_org :UInt8)
   (desc (:array :character 30))
)
(defconstant $CISTPL_ORG_FS 0)
; #define CISTPL_ORG_FS		0x00
(defconstant $CISTPL_ORG_APPSPEC 1)
; #define CISTPL_ORG_APPSPEC	0x01
(defconstant $CISTPL_ORG_XIP 2)
; #define CISTPL_ORG_XIP		0x02
(defrecord cistpl_format_t
   (type :UInt8)
   (edc :UInt8)
   (offset :UInt32)
   (length :UInt32)
)
(defconstant $CISTPL_FORMAT_DISK 0)
; #define CISTPL_FORMAT_DISK	0x00
(defconstant $CISTPL_FORMAT_MEM 1)
; #define CISTPL_FORMAT_MEM	0x01
(defconstant $CISTPL_EDC_NONE 0)
; #define CISTPL_EDC_NONE		0x00
(defconstant $CISTPL_EDC_CKSUM 1)
; #define CISTPL_EDC_CKSUM	0x01
(defconstant $CISTPL_EDC_CRC 2)
; #define CISTPL_EDC_CRC		0x02
(defconstant $CISTPL_EDC_PCC 3)
; #define CISTPL_EDC_PCC		0x03
(defrecord cisparse_t
   (:variant
   (
   (device :CISTPL_DEVICE_T)
   )
   (
   (checksum :CISTPL_CHECKSUM_T)
   )
   (
   (longlink :CISTPL_LONGLINK_T)
   )
   (
   (longlink_mfc :CISTPL_LONGLINK_MFC_T)
   )
   (
   (version_1 :CISTPL_VERS_1_T)
   )
   (
   (altstr :CISTPL_ALTSTR_T)
   )
   (
   (jedec :CISTPL_JEDEC_T)
   )
   (
   (manfid :CISTPL_MANFID_T)
   )
   (
   (funcid :CISTPL_FUNCID_T)
   )
   (
   (funce :CISTPL_FUNCE_T)
   )
   (
   (bar :CISTPL_BAR_T)
   )
   (
   (config :CISTPL_CONFIG_T)
   )
   (
   (cftable_entry :CISTPL_CFTABLE_ENTRY_T)
   )
   (
   (cftable_entry_cb :CISTPL_CFTABLE_ENTRY_CB_T)
   )
   (
   (device_geo :CISTPL_DEVICE_GEO_T)
   )
   (
   (vers_2 :CISTPL_VERS_2_T)
   )
   (
   (org :CISTPL_ORG_T)
   )
   (
   (format :CISTPL_FORMAT_T)
   )
   )
)
(defrecord tuple_t
   (Attributes :UInt32)
   (DesiredTuple :cisdata_t)
#|
; Warning: type-size: unknown type CISDATA_T
|#
   (Flags :UInt32)
                                                ;  internal use 
   (LinkOffset :UInt32)
                                                ;  internal use 
   (CISOffset :UInt32)
                                                ;  internal use 
   (TupleCode :cisdata_t)
#|
; Warning: type-size: unknown type CISDATA_T
|#
   (TupleLink :cisdata_t)
#|
; Warning: type-size: unknown type CISDATA_T
|#
   (TupleOffset :cisdata_t)
#|
; Warning: type-size: unknown type CISDATA_T
|#
   (TupleDataMax :cisdata_t)
#|
; Warning: type-size: unknown type CISDATA_T
|#
   (TupleDataLen :cisdata_t)
#|
; Warning: type-size: unknown type CISDATA_T
|#
   (TupleData (:pointer :cisdata_t))
)
;  Special cisdata_t value 
(defconstant $RETURN_FIRST_TUPLE 255)
; #define RETURN_FIRST_TUPLE	0xff
;  Attributes for tuple calls 
(defconstant $TUPLE_RETURN_LINK 1)
; #define TUPLE_RETURN_LINK	0x01
(defconstant $TUPLE_RETURN_COMMON 2)
; #define TUPLE_RETURN_COMMON	0x02
;  For ValidateCIS 
(defrecord cisinfo_t
   (Chains :UInt32)
)
(defconstant $CISTPL_MAX_CIS_SIZE 512)
; #define CISTPL_MAX_CIS_SIZE	0x200
;  For ReplaceCIS 
(defrecord cisdump_t
   (Length :UInt32)
   (Data (:array :cisdata_t 512))
#|
; Warning: type-size: unknown type cisdata_t
|#
)

; #endif /* LINUX_CISTPL_H */


(provide-interface "cistpl")