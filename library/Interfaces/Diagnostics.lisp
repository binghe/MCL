(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Diagnostics.h"
; at Sunday July 2,2006 7:27:31 pm.
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
;  * @OSF_FREE_COPYRIGHT@
;  
; 
;  * @APPLE_FREE_COPYRIGHT@
;  
; 
;  * Here are the Diagnostic interface interfaces
;  * Lovingly crafted by Bill Angell using traditional methods
; 
; #ifndef _DIAGNOSTICS_H_
; #define _DIAGNOSTICS_H_
; #ifndef __ppc__

; #error This file is only useful on PowerPC.

; #endif


(require-interface "ppc/savearea")

(deftrap-inline "_diagCall" 
   ((save (:pointer :struct))
   )
   :signed-long
() )
(defconstant $diagSCnum 24576)
; #define diagSCnum 0x00006000
(defconstant $dgAdjTB 0)
; #define dgAdjTB 0
(defconstant $dgLRA 1)
; #define dgLRA 1
(defconstant $dgpcpy 2)
; #define dgpcpy 2
(defconstant $dgreset 3)
; #define dgreset 3
(defconstant $dgtest 4)
; #define dgtest 4
(defconstant $dgBMphys 5)
; #define dgBMphys 5
(defconstant $dgUnMap 6)
; #define dgUnMap 6
(defconstant $dgBootScreen 7)
; #define dgBootScreen 7
(defconstant $dgFlush 8)
; #define dgFlush 8
(defconstant $dgAlign 9)
; #define dgAlign 9
(defconstant $dgprw 10)
; #define dgprw 10
(defconstant $dgmck 11)
; #define dgmck 11
(defconstant $dg64 12)
; #define dg64 12
(defconstant $dgProbeRead 13)
; #define dgProbeRead 13
(defconstant $dgCPNull 14)
; #define dgCPNull 14
(defconstant $dgPerfMon 15)
; #define dgPerfMon 15
(defconstant $dgMapPage 16)
; #define dgMapPage 16
(defconstant $dgScom 17)
; #define dgScom 17
(defrecord diagWork
                                                ;  Diagnostic work area 
   (dgLock :uint32)
                                                ;  Lock if needed 
   (dgFlags :uint32)
                                                ;  Flags 
; #define enaExpTrace 0x00000001
; #define enaExpTraceb 31
; #define enaUsrFCall 0x00000002
; #define enaUsrFCallb 30
; #define enaUsrPhyMp 0x00000004
; #define enaUsrPhyMpb 29
; #define enaDiagSCs  0x00000008
; #define enaDiagSCsb  28
; #define enaDiagDM  0x00000010
; #define enaDiagSDMb  27
; #define enaDiagEM  0x00000020
; #define enaDiagEMb  26
; #define enaDiagTrap  0x00000040
; #define enaDiagTrapb  25
; #define enaNotifyEM  0x00000080
; #define enaNotifyEMb  24
                                                ;  Suppress lock checks 
; #define disLkType 0x80000000
; #define disLktypeb 0
; #define disLkThread 0x40000000
; #define disLkThreadb 1
; #define disLkNmSimp	0x20000000
; #define disLkNmSimpb 2
; #define disLkMyLck 0x10000000
; #define disLkMyLckb 3
   (dgMisc0 :uint32)
   (dgMisc1 :uint32)
   (dgMisc2 :uint32)
   (dgMisc3 :uint32)
   (dgMisc4 :uint32)
   (dgMisc5 :uint32)
)
(defrecord scomcomm
   (scomcpu :UInt16)
                                                ;  CPU number 
   (scomfunc :UInt16)
                                                ;  0 = read; 1 = write 
   (scomreg :uint32)
                                                ;  SCOM register 
   (scomstat :uint64_t)
                                                ;  returned status 
   (scomdata :uint64_t)
                                                ;  input for write,  output for read 
)
(%define-record :dgWork (find-record-descriptor ':diagWork))

(deftrap-inline "_diagTrap" 
   ((* (:pointer :struct))
    (int :uint32)
   )
   :signed-long
() )

; #endif /* _DIAGNOSTICS_H_ */


(provide-interface "Diagnostics")