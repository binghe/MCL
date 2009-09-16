(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:winscard.h"
; at Sunday July 2,2006 7:30:32 pm.
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
; *****************************************************************
; 
; 	MUSCLE SmartCard Development ( http://www.linuxnet.com )
; 	    Title  : winscard.h
; 	    Package: pcsc lite
;             Author : David Corcoran
;             Date   : 7/27/99
;  	    License: Copyright (C) 1999 David Corcoran
; 	             <corcoran@linuxnet.com>
;             Purpose: This handles smartcard reader communications. 
; 	            
; 
; *******************************************************************
; #ifndef __winscard_h__
; #define __winscard_h__
; #ifndef __APPLE__
#| #|
#include <pcsclite.h>
|#
 |#

; #else

(require-interface "PCSC/pcsclite")

; #endif

; #ifdef __cplusplus
#| #|
extern "C"
{
#endif
|#
 |#

(deftrap-inline "_SCardEstablishContext" 
   ((dwScope :UInt32)
    (pvReserved1 :pointer)
    (pvReserved2 :pointer)
    (phContext (:pointer :long))
   )
   :signed-long
() )

(deftrap-inline "_SCardReleaseContext" 
   ((hContext :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_SCardSetTimeout" 
   ((hContext :signed-long)
    (dwTimeout :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_SCardConnect" 
   ((hContext :signed-long)
    (szReader (:pointer :char))
    (dwShareMode :UInt32)
    (dwPreferredProtocols :UInt32)
    (phCard (:pointer :long))
    (pdwActiveProtocol (:pointer :UInt32))
   )
   :signed-long
() )

(deftrap-inline "_SCardReconnect" 
   ((hCard :signed-long)
    (dwShareMode :UInt32)
    (dwPreferredProtocols :UInt32)
    (dwInitialization :UInt32)
    (pdwActiveProtocol (:pointer :UInt32))
   )
   :signed-long
() )

(deftrap-inline "_SCardDisconnect" 
   ((hCard :signed-long)
    (dwDisposition :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_SCardBeginTransaction" 
   ((hCard :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_SCardEndTransaction" 
   ((hCard :signed-long)
    (dwDisposition :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_SCardCancelTransaction" 
   ((hCard :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_SCardStatus" 
   ((hCard :signed-long)
    (mszReaderNames (:pointer :char))
    (pcchReaderLen (:pointer :UInt32))
    (pdwState (:pointer :UInt32))
    (pdwProtocol (:pointer :UInt32))
    (pbAtr (:pointer :UInt8))
    (pcbAtrLen (:pointer :UInt32))
   )
   :signed-long
() )

(deftrap-inline "_SCardGetStatusChange" 
   ((hContext :signed-long)
    (dwTimeout :UInt32)
    (rgReaderStates :lpscard_readerstate_a)
    (cReaders :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_SCardControl" 
   ((hCard :signed-long)
    (pbSendBuffer (:pointer :UInt8))
    (cbSendLength :UInt32)
    (pbRecvBuffer (:pointer :UInt8))
    (pcbRecvLength (:pointer :UInt32))
   )
   :signed-long
() )

(deftrap-inline "_SCardTransmit" 
   ((hCard :signed-long)
    (pioSendPci :lpcscard_io_request)
    (pbSendBuffer (:pointer :UInt8))
    (cbSendLength :UInt32)
    (pioRecvPci :lpscard_io_request)
    (pbRecvBuffer (:pointer :UInt8))
    (pcbRecvLength (:pointer :UInt32))
   )
   :signed-long
() )

(deftrap-inline "_SCardListReaderGroups" 
   ((hContext :signed-long)
    (mszGroups (:pointer :char))
    (pcchGroups (:pointer :UInt32))
   )
   :signed-long
() )

(deftrap-inline "_SCardListReaders" 
   ((hContext :signed-long)
    (mszGroups (:pointer :char))
    (mszReaders (:pointer :char))
    (pcchReaders (:pointer :UInt32))
   )
   :signed-long
() )

(deftrap-inline "_SCardCancel" 
   ((hContext :signed-long)
   )
   :signed-long
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif


(provide-interface "winscard")