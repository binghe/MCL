(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:powermac.h"
; at Sunday July 2,2006 7:31:16 pm.
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
; #ifndef _PEXPERT_PPC_POWERMAC_H_
; #define _PEXPERT_PPC_POWERMAC_H_
; #ifndef ASSEMBLER

(require-interface "mach/ppc/vm_types")

(require-interface "pexpert/pexpert")

(require-interface "pexpert/protos")

(require-interface "pexpert/ppc/boot")
;  prototypes 

(deftrap-inline "_PE_find_scc" 
   (
   )
   :UInt32
() )
;  Some useful typedefs for accessing control registers 

(def-mactype :v_u_char (find-mactype ':UInt8))

(def-mactype :v_u_short (find-mactype ':UInt16))

(def-mactype :v_u_int (find-mactype ':UInt32))

(def-mactype :v_u_long (find-mactype ':UInt32))
;  And some useful defines for reading 'volatile' structures,
;  * don't forget to be be careful about sync()s and eieio()s
;  
; #define reg8(reg) (*(v_u_char *)reg)
; #define reg16(reg) (*(v_u_short *)reg)
; #define reg32(reg) (*(v_u_int *)reg)
;  Non-cached version of bcopy 

(deftrap-inline "_bcopy_nc" 
   ((from (:pointer :char))
    (to (:pointer :char))
    (size :signed-long)
   )
   nil
() )

; #endif /* ASSEMBLER */


; #endif /* _PEXPERT_PPC_POWERMAC_H_ */


(provide-interface "powermac")