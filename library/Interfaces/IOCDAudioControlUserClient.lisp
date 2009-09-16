(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOCDAudioControlUserClient.h"
; at Sunday July 2,2006 7:28:38 pm.
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
; #ifndef _IOCDAUDIOCONTROLUSERCLIENT_H
; #define _IOCDAUDIOCONTROLUSERCLIENT_H

(require-interface "IOKit/storage/IOCDTypes")
; 
;  * Audio Control User Client Methods
;  

(defconstant $kIOCDAudioControlMethodGetStatus 0);  IOCDAudioControlUserClient::getStatus()

(defconstant $kIOCDAudioControlMethodGetTOC 1)  ;  IOCDAudioControlUserClient::getTOC()

(defconstant $kIOCDAudioControlMethodGetVolume 2);  IOCDAudioControlUserClient::getVolume()

(defconstant $kIOCDAudioControlMethodSetVolume 3);  IOCDAudioControlUserClient::setVolume()

(defconstant $kIOCDAudioControlMethodPause 4)   ;  IOCDAudioControlUserClient::pause()

(defconstant $kIOCDAudioControlMethodPlay 5)    ;  IOCDAudioControlUserClient::play()

(defconstant $kIOCDAudioControlMethodScan 6)    ;  IOCDAudioControlUserClient::scan()

(defconstant $kIOCDAudioControlMethodStop 7)    ;  IOCDAudioControlUserClient::stop()
;  (total number of methods supported)

(defconstant $kIOCDAudioControlMethodCount 8)

; #endif /* _IOCDAUDIOCONTROLUSERCLIENT_H */


(provide-interface "IOCDAudioControlUserClient")