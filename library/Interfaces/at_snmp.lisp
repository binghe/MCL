(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:at_snmp.h"
; at Sunday July 2,2006 7:26:40 pm.
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
; #ifndef _NETAT_AT_SNMP_H_
; #define _NETAT_AT_SNMP_H_

(require-interface "sys/appleapiopts")
(defconstant $MAX_PHYS_ADDR_SIZE 6)
; #define MAX_PHYS_ADDR_SIZE	6	/* maximum physical addr size */
(defconstant $MAX_IFS 25)
; #define	MAX_IFS			25	/* max # interfaces */
(defconstant $IF_NAME_SIZE 6)
; #define	IF_NAME_SIZE		6	/* max name length of I/F name */
(defconstant $DDP_ADDR_SIZE 3)
; #define DDP_ADDR_SIZE		3
; #define	ZONE_SIZE		NBP_NVE_STR_SIZE
; #define	OBJECT_SIZE   		NBP_NVE_STR_SIZE
; #define	TYPE_SIZE     		NBP_NVE_STR_SIZE
(defconstant $PORT_DESC_SIZE 50)
; #define PORT_DESC_SIZE		50
(defconstant $UPDATE_IF_CHANGED 1)
; #define UPDATE_IF_CHANGED	1	/* for ioctls  */
(defconstant $UPDATE_UNCONDITIONAL 2)
; #define UPDATE_UNCONDITIONAL 2
#|
; Warning: type-size: unknown type SNMPNBPTABLE_T
|#
#|
; Warning: type-size: unknown type SNMPNBPENTRY_T
|#
(defconstant $SNMP_NBP_HEADER_SIZE 0)
; #define SNMP_NBP_HEADER_SIZE	(sizeof(snmpNbpTable_t) - sizeof(snmpNbpEntry_t))
(defrecord snmpIfCfg
   (ifc_aarpSize :UInt16)
                                                ;  AARP table size for this I/F 
   (ifc_addrSize :UInt16)
                                                ;  Mac address size in bytes 
   (ifc_type :UInt16)
                                                ;  port type 
   (ifc_start :UInt16)
                                                ;  net range start 
   (ifc_end :UInt16)
                                                ;  net range end 
   (ifc_ddpAddr :AT_ADDR)
                                                ;  ddp address of port 
   (ifc_status :UInt16)
                                                ;  port status 
   (ifc_netCfg :UInt16)
   (ifc_zoneCfg :UInt16)
   (ifc_zoneName :AT_NVESTR)
   (ifc_index :UInt16)
   (ifc_name (:array :character 6))
                                                ;  I/F name (e.g. ent0 
)
(%define-record :snmpIfCfg_t (find-record-descriptor :SNMPIFCFG))
(defrecord snmpCfg
   (pad :signed-long)
                                                ;  pad for UPDATE flag when ioctl issued 
   (cfg_flags :UInt32)
                                                ;  at_state flags 
   (cfg_ifCnt :signed-long)
                                                ;  # I/F's up 
   (cfg_ifCfg (:array :SNMPIFCFG 25))
)
(%define-record :snmpCfg_t (find-record-descriptor :SNMPCFG))
(defrecord snmpAarpEnt
   (ap_ddpAddr :AT_ADDR)
   (ap_physAddr (:array :UInt8 6))
)
(%define-record :snmpAarpEnt_t (find-record-descriptor :SNMPAARPENT))
(defrecord snmpAarp
                                                ;  aarp info for 1 I/F 
   (at_time :signed-long)
                                                ;  the time() we got this table 
   (at_ifno :signed-long)
                                                ;  the (SNMP) I/F number of this table 
   (at_maxSize :signed-long)
                                                ;  allocated size of as_table in entries 
   (at_usedSize :signed-long)
                                                ;  size of at_table used portion 
   (at_table (:pointer :SNMPAARPENT_T))
)
(%define-record :snmpAarp_t (find-record-descriptor :SNMPAARP))
(defrecord snmpFlags
   (lap_changed :signed-long)
                                                ;  set when any I/F state changes 
   (rtmpAdded :signed-long)
                                                ;  set when rtmp entry ADDED 
   (zipAdded :signed-long)
                                                ;  set when zip entry ADDED 
)
(%define-record :snmpFlags_t (find-record-descriptor :SNMPFLAGS))
(defrecord snmpNbpEntry
   (nbpe_object :AT_NVESTR)
   (nbpe_type :AT_NVESTR)
)
(%define-record :snmpNbpEntry_t (find-record-descriptor :SNMPNBPENTRY))
(defrecord snmpNbpTable
   (nbpt_entries :signed-long)
   (nbpt_zone :AT_NVESTR)
   (nbpt_table (:array :SNMPNBPENTRY 1))
)
(%define-record :snmpNbpTable_t (find-record-descriptor :SNMPNBPTABLE))
(defrecord snmpStats
                                                ;  ddp group 
   (dd_outReq :UInt32)
   (dd_outShort :UInt32)
   (dd_outLong :UInt32)
   (dd_inTotal :UInt32)
   (dd_fwdReq :UInt32)
   (dd_inLocal :UInt32)
   (dd_noHandler :UInt32)
   (dd_noRoutes :UInt32)
   (dd_tooShort :UInt32)
   (dd_tooLong :UInt32)
   (dd_inBcastErr :UInt32)
   (dd_shortErr :UInt32)
   (dd_hopCount :UInt32)
   (dd_checkSum :UInt32)
                                                ;  ATEcho group 
   (ec_echoReq :UInt32)
   (ec_echoReply :UInt32)
)
(%define-record :snmpStats_t (find-record-descriptor :SNMPSTATS))
(defconstant $SNMP_TYPE_OTHER 1)
; #define  SNMP_TYPE_OTHER		1
(defconstant $SNMP_TYPE_LOCAL 2)
; #define  SNMP_TYPE_LOCAL		2
(defconstant $SNMP_TYPE_ETHER1 3)
; #define  SNMP_TYPE_ETHER1		3
(defconstant $SNMP_TYPE_ETHER2 4)
; #define  SNMP_TYPE_ETHER2		4
(defconstant $SNMP_TYPE_TOKEN 5)
; #define  SNMP_TYPE_TOKEN		5
(defconstant $SNMP_TYPE_IP 6)
; #define  SNMP_TYPE_IP			6	
(defconstant $SNMP_TYPE_SERIALPPP 7)
; #define  SNMP_TYPE_SERIALPPP	7
(defconstant $SNMP_TYPE_SERIALNONSTD 8)
; #define  SNMP_TYPE_SERIALNONSTD	8
(defconstant $SNMP_TYPE_VIRTUAL 9)
; #define  SNMP_TYPE_VIRTUAL		9
(defconstant $SNMP_CFG_CONFIGURED 1)
; #define  SNMP_CFG_CONFIGURED	1
(defconstant $SNMP_CFG_GARNERED 2)
; #define  SNMP_CFG_GARNERED		2
(defconstant $SNMP_CFG_GUESSED 3)
; #define  SNMP_CFG_GUESSED		3
(defconstant $SNMP_CFG_UNCONFIG 4)
; #define  SNMP_CFG_UNCONFIG		4
(defconstant $SNMP_OBJ_TYPE_AARP 256)
; #define  SNMP_OBJ_TYPE_AARP		0x0100
(defconstant $SNMP_OBJ_TYPE_ECHO 512)
; #define  SNMP_OBJ_TYPE_ECHO		0x0200
(defconstant $SNMP_OBJ_TYPE_PORT 768)
; #define  SNMP_OBJ_TYPE_PORT		0x0300
(defconstant $SNMP_OBJ_TYPE_DDP 1024)
; #define  SNMP_OBJ_TYPE_DDP		0x0400
(defconstant $SNMP_OBJ_TYPE_RTMP 1280)
; #define  SNMP_OBJ_TYPE_RTMP		0x0500
(defconstant $SNMP_OBJ_TYPE_ZIP 1536)
; #define  SNMP_OBJ_TYPE_ZIP 		0x0600
(defconstant $SNMP_OBJ_TYPE_NBP 1792)
; #define  SNMP_OBJ_TYPE_NBP 		0x0700
(defconstant $SNMP_OBJ_TYPE_MASK 3840)
; #define  SNMP_OBJ_TYPE_MASK		0x0f00
(defconstant $AARPIFINDEX 2)
; #define  AARPIFINDEX			2 + SNMP_OBJ_TYPE_AARP
(defconstant $AARPNETADDRESS 3)
; #define  AARPNETADDRESS			3 + SNMP_OBJ_TYPE_AARP
(defconstant $AARPPHYSADDRESS 4)
; #define  AARPPHYSADDRESS		4 + SNMP_OBJ_TYPE_AARP
(defconstant $ATECHOREPLIES 6)
; #define  ATECHOREPLIES			6 + SNMP_OBJ_TYPE_AARP
(defconstant $ATECHOREQUESTS 7)
; #define  ATECHOREQUESTS			7 + SNMP_OBJ_TYPE_AARP
(defconstant $ATPORTDESCR 8)
; #define  ATPORTDESCR			8 + SNMP_OBJ_TYPE_PORT
(defconstant $ATPORTIFINDEX 10)
; #define  ATPORTIFINDEX			10 + SNMP_OBJ_TYPE_PORT
(defconstant $ATPORTINDEX 11)
; #define  ATPORTINDEX			11 + SNMP_OBJ_TYPE_PORT
(defconstant $ATPORTNETADDRESS 12)
; #define  ATPORTNETADDRESS		12 + SNMP_OBJ_TYPE_PORT
(defconstant $ATPORTNETCONFIG 13)
; #define  ATPORTNETCONFIG		13 + SNMP_OBJ_TYPE_PORT
(defconstant $ATPORTNETEND 14)
; #define  ATPORTNETEND			14 + SNMP_OBJ_TYPE_PORT
(defconstant $ATPORTNETSTART 15)
; #define  ATPORTNETSTART			15 + SNMP_OBJ_TYPE_PORT
(defconstant $ATPORTSTATUS 16)
; #define  ATPORTSTATUS			16 + SNMP_OBJ_TYPE_PORT
(defconstant $ATPORTTYPE 18)
; #define  ATPORTTYPE			 	18 + SNMP_OBJ_TYPE_PORT
(defconstant $ATPORTZONE 19)
; #define  ATPORTZONE			 	19 + SNMP_OBJ_TYPE_PORT
(defconstant $ATPORTZONECONFIG 20)
; #define  ATPORTZONECONFIG		20 + SNMP_OBJ_TYPE_PORT
(defconstant $DDPBROADCASTERRORS 21)
; #define  DDPBROADCASTERRORS		21 + SNMP_OBJ_TYPE_DDP
(defconstant $DDPCHECKSUMERRORS 22)
; #define  DDPCHECKSUMERRORS		22 + SNMP_OBJ_TYPE_DDP
(defconstant $DDPFORWREQUESTS 23)
; #define  DDPFORWREQUESTS		23 + SNMP_OBJ_TYPE_DDP
(defconstant $DDPHOPCOUNTERRORS 24)
; #define  DDPHOPCOUNTERRORS		24 + SNMP_OBJ_TYPE_DDP
(defconstant $DDPINLOCALDATAGRAMS 25)
; #define  DDPINLOCALDATAGRAMS	25 + SNMP_OBJ_TYPE_DDP
(defconstant $DDPINRECEIVES 26)
; #define  DDPINRECEIVES			26 + SNMP_OBJ_TYPE_DDP
(defconstant $DDPNOPROTOCOLHANDLERS 27)
; #define  DDPNOPROTOCOLHANDLERS	27 + SNMP_OBJ_TYPE_DDP
(defconstant $DDPOUTLONGS 28)
; #define  DDPOUTLONGS			28 + SNMP_OBJ_TYPE_DDP
(defconstant $DDPOUTNOROUTES 29)
; #define  DDPOUTNOROUTES			29 + SNMP_OBJ_TYPE_DDP
(defconstant $DDPOUTREQUESTS 30)
; #define  DDPOUTREQUESTS			30 + SNMP_OBJ_TYPE_DDP
(defconstant $DDPOUTSHORTS 31)
; #define  DDPOUTSHORTS			31 + SNMP_OBJ_TYPE_DDP
(defconstant $DDPSHORTDDPERRORS 32)
; #define  DDPSHORTDDPERRORS		32 + SNMP_OBJ_TYPE_DDP
(defconstant $DDPTOOLONGERRORS 33)
; #define  DDPTOOLONGERRORS		33 + SNMP_OBJ_TYPE_DDP
(defconstant $DDPTOOSHORTERRORS 34)
; #define  DDPTOOSHORTERRORS		34 + SNMP_OBJ_TYPE_DDP
(defconstant $KIPBCASTADDR 35)
; #define  KIPBCASTADDR			35 
(defconstant $KIPCORE 36)
; #define  KIPCORE			 	36
(defconstant $KIPENTRY 37)
; #define  KIPENTRY			 	37
(defconstant $KIPHOPCOUNT 38)
; #define  KIPHOPCOUNT			38
(defconstant $KIPNETEND 39)
; #define  KIPNETEND			 	39
(defconstant $KIPNETSTART 40)
; #define  KIPNETSTART			40
(defconstant $KIPNEXTHOP 41)
; #define  KIPNEXTHOP			 	41
(defconstant $KIPSHARE 42)
; #define  KIPSHARE			 	42
(defconstant $KIPSTATE 43)
; #define  KIPSTATE			 	43
(defconstant $KIPTABLE 44)
; #define  KIPTABLE			 	44
(defconstant $KIPTYPE 45)
; #define  KIPTYPE			 	45
(defconstant $LLAPCOLLISIONS 46)
; #define  LLAPCOLLISIONS			46
(defconstant $LLAPDEFERS 47)
; #define  LLAPDEFERS			 	47
(defconstant $LLAPENTRY 48)
; #define  LLAPENTRY			 	48
(defconstant $LLAPFCSERRORS 49)
; #define  LLAPFCSERRORS			49 
(defconstant $LLAPIFINDEX 50)
; #define  LLAPIFINDEX			50 
(defconstant $LLAPINERRORS 51)
; #define  LLAPINERRORS			51 
(defconstant $LLAPINLENGTHERRORS 52)
; #define  LLAPINLENGTHERRORS		52 
(defconstant $LLAPINNOHANDLERS 53)
; #define  LLAPINNOHANDLERS		53
(defconstant $LLAPINPKTS 54)
; #define  LLAPINPKTS			 	54
(defconstant $LLAPNODATAERRORS 55)
; #define  LLAPNODATAERRORS		55
(defconstant $LLAPOUTPKTS 56)
; #define  LLAPOUTPKTS			56
(defconstant $LLAPRANDOMCTSERRORS 57)
; #define  LLAPRANDOMCTSERRORS	57
(defconstant $NBPINDEX 60)
; #define  NBPINDEX			 	60 + SNMP_OBJ_TYPE_NBP
(defconstant $NBPOBJECT 61)
; #define  NBPOBJECT			 	61 + SNMP_OBJ_TYPE_NBP
(defconstant $NBPSTATE 62)
; #define  NBPSTATE			 	62 + SNMP_OBJ_TYPE_NBP
(defconstant $NBPTABLE 63)
; #define  NBPTABLE			 	63 + SNMP_OBJ_TYPE_NBP
(defconstant $NBPTYPE 64)
; #define  NBPTYPE			 	64 + SNMP_OBJ_TYPE_NBP
(defconstant $NBPZONE 65)
; #define  NBPZONE			 	65 + SNMP_OBJ_TYPE_NBP
(defconstant $RTMPHOPS 67)
; #define  RTMPHOPS			 	67 + SNMP_OBJ_TYPE_RTMP
(defconstant $RTMPNEXTHOP 68)
; #define  RTMPNEXTHOP			68 + SNMP_OBJ_TYPE_RTMP
(defconstant $RTMPPORT 69)
; #define  RTMPPORT			 	69 + SNMP_OBJ_TYPE_RTMP
(defconstant $RTMPRANGEEND 70)
; #define  RTMPRANGEEND			70 + SNMP_OBJ_TYPE_RTMP
(defconstant $RTMPRANGESTART 71)
; #define  RTMPRANGESTART			71 + SNMP_OBJ_TYPE_RTMP
(defconstant $RTMPSTATE 72)
; #define  RTMPSTATE			 	72 + SNMP_OBJ_TYPE_RTMP
(defconstant $RTMPTYPE 74)
; #define  RTMPTYPE			 	74 + SNMP_OBJ_TYPE_RTMP
(defconstant $ZIPZONEINDEX 77)
; #define  ZIPZONEINDEX			77 + SNMP_OBJ_TYPE_ZIP
(defconstant $ZIPZONENAME 78)
; #define  ZIPZONENAME			78 + SNMP_OBJ_TYPE_ZIP
(defconstant $ZIPZONENETEND 79)
; #define  ZIPZONENETEND			79 + SNMP_OBJ_TYPE_ZIP
(defconstant $ZIPZONENETSTART 80)
; #define  ZIPZONENETSTART		80 + SNMP_OBJ_TYPE_ZIP
(defconstant $ZIPZONESTATE 81)
; #define  ZIPZONESTATE			81 + SNMP_OBJ_TYPE_ZIP
; #define SNMP_TYPE(var,type)	 ((var & SNMP_OBJ_TYPE_MASK) == type)	

; #endif /* _NETAT_AT_SNMP_H_ */


(provide-interface "at_snmp")