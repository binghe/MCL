(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOCDMediaBSDClient.h"
; at Sunday July 2,2006 7:28:40 pm.
; 
;  * Copyright (c) 1998-2003 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * This file contains Original Code and/or Modifications of Original Code
;  * as defined in and that are subject to the Apple Public Source License
;  * Version 2.0 (the 'License'). You may not use this file except in
;  * compliance with the License. Please obtain a copy of the License at
;  * http://www.opensource.apple.com/apsl/ and read it before using this
;  * file.
;  * 
;  * The Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
;  * Please see the License for the specific language governing rights and
;  * limitations under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef _IOCDMEDIABSDCLIENT_H
; #define _IOCDMEDIABSDCLIENT_H

(require-interface "sys/ioctl")

(require-interface "sys/types")

(require-interface "IOKit/storage/IOCDTypes")
; 
;  * Definitions
;  *
;  * ioctl                        description
;  * ---------------------------- ------------------------------------------------
;  * DKIOCCDREAD                  see IOCDMedia::readCD()           in IOCDMedia.h
;  * DKIOCCDREADTOC               see IOCDMedia::readTOC()          in IOCDMedia.h
;  *
;  * DKIOCCDREADDISCINFO          see IOCDMedia::readDiscInfo()     in IOCDMedia.h
;  * DKIOCCDREADTRACKINFO         see IOCDMedia::readTrackInfo()    in IOCDMedia.h
;  *
;  * DKIOCCDREADISRC              see IOCDMedia::readISRC()         in IOCDMedia.h
;  * DKIOCCDREADMCN               see IOCDMedia::readMCN()          in IOCDMedia.h
;  *
;  * DKIOCCDGETSPEED              see IOCDMedia::getSpeed()         in IOCDMedia.h
;  * DKIOCCDSETSPEED              see IOCDMedia::setSpeed()         in IOCDMedia.h
;  *
;  *         in /System/Library/Frameworks/Kernel.framework/Headers/IOKit/storage/
;  
(defrecord dk_cd_read_t
   (offset :u_int64_t)
   (sectorArea :UInt8)
   (sectorType :UInt8)
   (reserved0080 (:array :UInt8 6))             ;  reserved, clear to zero 
   (bufferLength :UInt32)                       ;  actual length on return 
   (buffer :pointer)
)
(defrecord dk_cd_read_isrc_t
   (isrc :CDISRC)
   (track :UInt8)
   (reserved0112 (:array :UInt8 2))             ;  reserved, clear to zero 
)
(defrecord dk_cd_read_mcn_t
   (mcn :CDMCN)
   (reserved0112 (:array :UInt8 2))             ;  reserved, clear to zero 
)
(defrecord dk_cd_read_toc_t
   (format :UInt8)
   (formatAsTime :UInt8)
   (reserved0016 (:array :UInt8 5))             ;  reserved, clear to zero 
   (:variant
   (
   (session :UInt8)
   )
   (
   (track :UInt8)
   )
   )
   (reserved0064 (:array :UInt8 2))             ;  reserved, clear to zero 
   (bufferLength :UInt16)                       ;  actual length on return 
   (buffer :pointer)
)
(defrecord dk_cd_read_disc_info_t   (reserved0000 (:array :UInt8 10))            ;  reserved, clear to zero 
   (bufferLength :UInt16)                       ;  actual length on return 
   (buffer :pointer)
)
(defrecord dk_cd_read_track_info_t   (reserved0000 (:array :UInt8 4))             ;  reserved, clear to zero 
   (address :UInt32)
   (addressType :UInt8)
   (reserved0072 (:array :UInt8 1))             ;  reserved, clear to zero 
   (bufferLength :UInt16)                       ;  actual length on return 
   (buffer :pointer)
)
; #define DKIOCCDREAD          _IOWR('d', 96, dk_cd_read_t)
; #define DKIOCCDREADISRC      _IOWR('d', 97, dk_cd_read_isrc_t)
; #define DKIOCCDREADMCN       _IOWR('d', 98, dk_cd_read_mcn_t)
; #define DKIOCCDGETSPEED      _IOR('d', 99, u_int16_t)
; #define DKIOCCDSETSPEED      _IOW('d', 99, u_int16_t)
; #define DKIOCCDREADTOC       _IOWR('d', 100, dk_cd_read_toc_t)
; #define DKIOCCDREADDISCINFO  _IOWR('d', 101, dk_cd_read_disc_info_t)
; #define DKIOCCDREADTRACKINFO _IOWR('d', 102, dk_cd_read_track_info_t)

; #endif /* !_IOCDMEDIABSDCLIENT_H */


(provide-interface "IOCDMediaBSDClient")