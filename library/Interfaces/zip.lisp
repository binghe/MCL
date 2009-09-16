(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:zip.h"
; at Sunday July 2,2006 7:32:19 pm.
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
;  *
;  * ORIGINS: 82
;  *
;  * (C) COPYRIGHT Apple Computer, Inc. 1992-1996
;  * All Rights Reserved
;  *
;  
; #ifndef _NETAT_ZIP_H_
; #define	_NETAT_ZIP_H_

(require-interface "sys/appleapiopts")
;  Definitions for ZIP, per AppleTalk Zone Information Protocol
;  * documentation from `Inside AppleTalk', July 14, 1986.
;  
;  ZIP packet types 
(defconstant $ZIP_QUERY 1)
; #define ZIP_QUERY         	1  	/* ZIP zone query packet */
(defconstant $ZIP_REPLY 2)
; #define ZIP_REPLY           	2  	/* ZIP query reply packet */
(defconstant $ZIP_TAKEDOWN 3)
; #define ZIP_TAKEDOWN        	3  	/* ZIP takedown packet */
(defconstant $ZIP_BRINGUP 4)
; #define ZIP_BRINGUP        	4  	/* ZIP bringup packet */
(defconstant $ZIP_GETNETINFO 5)
; #define ZIP_GETNETINFO		5	/* ZIP DDP get net info packet */
(defconstant $ZIP_NETINFO_REPLY 6)
; #define	ZIP_NETINFO_REPLY	6	/* ZIP GetNetInfo Reply */
(defconstant $ZIP_NOTIFY 7)
; #define ZIP_NOTIFY		7	/* Notification of zone name change */
(defconstant $ZIP_EXTENDED_REPLY 8)
; #define ZIP_EXTENDED_REPLY	8	/* ZIP extended query reply packet */ 
(defconstant $ZIP_GETMYZONE 7)
; #define ZIP_GETMYZONE    	7  	/* ZIP ATP get my zone packet */
(defconstant $ZIP_GETZONELIST 8)
; #define ZIP_GETZONELIST    	8  	/* ZIP ATP get zone list packet */
(defconstant $ZIP_GETLOCALZONES 9)
; #define	ZIP_GETLOCALZONES	9	/* ZIP ATP get cable list packet*/
(defconstant $ZIP_HDR_SIZE 2)
; #define ZIP_HDR_SIZE		2
(defconstant $ZIP_DATA_SIZE 584)
; #define	ZIP_DATA_SIZE		584
(defconstant $ZIP_MAX_ZONE_LENGTH 32)
; #define ZIP_MAX_ZONE_LENGTH	32	/* Max length for a Zone Name */
(defrecord at_zip
   (command :UInt8)
   (flags :UInt8)
   (data (:array :character 584))
)
(%define-record :at_zip_t (find-record-descriptor :AT_ZIP))
; #define	 ZIP_ZIP(c)	((at_zip_t *)(&((at_ddp_t *)(c))->data[0]))
(defrecord at_x_zip_t
   (command :character)
   (flags :character)
   (cable_range_start :ua_short)
   (cable_range_end :ua_short)
   (data (:array :UInt8 1))
)
(defconstant $ZIP_X_HDR_SIZE 6)
; #define	ZIP_X_HDR_SIZE	6
;  flags for ZipNetInfoReply packet 
(defconstant $ZIP_ZONENAME_INVALID 128)
; #define	ZIP_ZONENAME_INVALID	0x80
(defconstant $ZIP_USE_BROADCAST 64)
; #define	ZIP_USE_BROADCAST	0x40
(defconstant $ZIP_ONE_ZONE 32)
; #define	ZIP_ONE_ZONE		0x20
(defconstant $ZIP_NETINFO_RETRIES 3)
; #define	ZIP_NETINFO_RETRIES	3
; #define	ZIP_TIMER_INT		HZ	/* HZ defined in param.h */
;  ZIP control codes 
(defconstant $ZIP_ONLINE 1)
; #define	ZIP_ONLINE		1
(defconstant $ZIP_LATE_ROUTER 2)
; #define ZIP_LATE_ROUTER		2
(defconstant $ZIP_NO_ROUTER 3)
; #define	ZIP_NO_ROUTER		3
; #define ZIP_RE_AARP		-1

; #endif /* _NETAT_ZIP_H_ */


(provide-interface "zip")