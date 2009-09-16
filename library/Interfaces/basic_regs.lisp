(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:basic_regs.h"
; at Sunday July 2,2006 7:27:08 pm.
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
;  Copyright (c) 1996 NeXT Software, Inc.  All rights reserved.
;  *
;  *	File:	architecture/ppc/basic_regs.h
;  *	Author:	Doug Mitchell, NeXT Software, Inc.
;  *
;  *	Basic ppc registers.
;  *
;  * HISTORY
;  * 22-May-97  Umesh Vaishampayan  (umeshv@apple.com)
;  	Updated to match MPCFPE32B/AD 1/97 REV. 1 
;  * 29-Dec-96  Umesh Vaishampayan  (umeshv@NeXT.com)
;  *	Ported from m98k.
;  * 05-Nov-92  Doug Mitchell at NeXT
;  *	Created.
;  
; #ifndef _ARCH_PPC_BASIC_REGS_H_
; #define _ARCH_PPC_BASIC_REGS_H_

(require-interface "architecture/ppc/reg_help")

(require-interface "architecture/ppc/macro_help")

; #if !defined(__ASSEMBLER__)
; 
;  * Number of General Purpose registers.
;  
(defconstant $PPC_NGP_REGS 32)
; #define PPC_NGP_REGS	32
; 
;  * Common half-word used in Machine State Register and in 
;  * various exception frames. Defined as a macro because the compiler
;  * will align a struct to a word boundary when used inside another struct.
;  
; #define MSR_BITS							   	unsigned	ee:BIT_WIDTH(15),	/* external intr enable    */ 			pr:BIT_WIDTH(14),	/* problem state	   */ 			fp:BIT_WIDTH(13),	/* floating point avail	   */ 			me:BIT_WIDTH(12),	/* machine check enable	   */ 			fe0:BIT_WIDTH(11),	/* fp exception mode 0	   */ 			se:BIT_WIDTH(10),	/* single step enable	   */ 			be:BIT_WIDTH(9),	/* branch trace enable	   */ 			fe1:BIT_WIDTH(8),	/* fp exception mode 0	   */ 			rsvd1:BIT_WIDTH(7),	/* reserved		   */ 			ip:BIT_WIDTH(6),	/* interrupt prefix	   */ 			ir:BIT_WIDTH(5),	/* instruction relocate	   */ 			dr:BIT_WIDTH(4),	/* data relocate	   */ 			rsvd2:BITS_WIDTH(3,2),	/* reserved		   */ 			ri:BIT_WIDTH(1),	/* recoverable exception   */ 			le:BIT_WIDTH(0)		/* Little-endian mode	   */
; 
;  * Machine state register.
;  * Read and written via get_msr() and set_msr() inlines, below.
;  
(defrecord msr_t
   (rsvd3 :UInt32)                              ;(: BITS_WIDTH (31 , 19))
                                                ;  reserved
                                                ;(pow : BIT_WIDTH (18))
                                                ;  Power management enable
                                                ;(rsvd0 : BIT_WIDTH (17))
                                                ;  reserved
                                                ;(ile : BIT_WIDTH (16))
                                                ;  exception little endian
#|
   (NIL :msr_bits)|#
                                                ;  see above
)
; 
;  * Data Storage Interrupt Status Register (DSISR)
;  
(defrecord dsisr_t
   (dse (:pointer :callback))                   ;(UInt32 colon15)
                                                ;  direct-store error
   (tnf (:pointer :callback))                   ;(UInt32 colon1)
                                                ;  translation not found
#|
   (NIL :UInt32)|#
   (pe (:pointer :callback))                    ;(UInt32 colon6)
                                                ;  protection error
   (dsr (:pointer :callback))                   ;(UInt32 colon15)
                                                ;  lwarx/stwcx to direct-store
   (rw (:pointer :callback))                    ;(UInt32 colon4)
                                                ;  1 => store, 0 => load
#|
   (NIL :UInt32)|#
   (dab (:pointer :callback))                   ;(UInt32 colon3)
                                                ;  data address bkpt (601)
   (ssf (:pointer :callback))                   ;(UInt32 colon12)
                                                ;  seg table search failed
#|
   (NIL :UInt32)|#
)
; 
;  * Instruction Storage Interrupt Status Register (really SRR1)
;  
(defrecord isisr_t #|
   (NIL :UInt32)|#
   (tnf (:pointer :callback))                   ;(UInt32 colon7)
                                                ;  translation not found
#|
   (NIL :UInt32)|#
   (dse (:pointer :callback))                   ;(UInt32 colon0)
                                                ;  direct-store fetch error
   (pe (:pointer :callback))                    ;(UInt32 colon13)
                                                ;  protection error
#|
   (NIL :UInt32)|#
   (ssf (:pointer :callback))                   ;(UInt32 colon15)
                                                ;  seg table search failed
#|
   (NIL :UInt32)|#
#|
   (NIL :msr_bits)|#
)
; 
;  * Alignment Interrupt Status Register (really DSISR)
;  * NOTE: bit numbers in field *names* are in IBM'ese (0 is MSB).
;  * FIXME: Yuck!!! Double Yuck!!!
;  
(defrecord aisr_t #|
   (NIL :UInt32)|#
   (ds3031 (:pointer :callback))                ;(UInt32 colon3)
                                                ;  bits 30:31 if DS form
#|
   (NIL :UInt32)|#
   (x2930 (:pointer :callback))                 ;(UInt32 colon14)
                                                ;  bits 29:30 if X form
   (x25 (:pointer :callback))                   ;(UInt32 colon10)
                                                ;  bit 25 if X form or
                                                ;  bit 5 if D or DS form
   (x2124 (:pointer :callback))                 ;(UInt32 colon15)
                                                ;  bits 21:24 if X form or
                                                ;  bits 1:4 if D or DS form
   (all615 (:pointer :callback))                ;(UInt32 colon14)
                                                ;  bits 6:15 of instr
#|
   (NIL :msr_bits)|#
)
; 
;  * Program Interrupt Status Register (really SRR1)
;  
(defrecord pisr_t #|
   (NIL :UInt32)|#
   (fpee (:pointer :callback))                  ;(UInt32 colon2)
                                                ;  floating pt enable exception
   (ill (:pointer :callback))                   ;(UInt32 colon9)
                                                ;  illegal instruction
   (priv (:pointer :callback))                  ;(UInt32 colon15)
                                                ;  privileged instruction
   (trap (:pointer :callback))                  ;(UInt32 colon10)
                                                ;  trap program interrupt
   (subseq (:pointer :callback))                ;(UInt32 colon12)
                                                ;  1 => SRR0 points to
                                                ;  subsequent instruction
#|
   (NIL :msr_bits)|#
)
; 
;  * Condition register. May not be useful in C, let's see...
;  
(defrecord cr_t
   (lt :UInt32)                                 ;(: BIT_WIDTH (31))
                                                ;  negative
                                                ;(gt : BIT_WIDTH (30))
                                                ;  positive
                                                ;(eq : BIT_WIDTH (29))
                                                ;  equal to zero
                                                ;(so : BIT_WIDTH (28))
                                                ;  summary overflow
                                                ;(fx : BIT_WIDTH (27))
                                                ;  floating point exception
                                                ;(fex : BIT_WIDTH (26))
                                                ;  fp enabled exception
                                                ;(vx : BIT_WIDTH (25))
                                                ;  fp invalid operation
                                                ;     exception
                                                ;(ox : BIT_WIDTH (24))
                                                ;  fp overflow exception
                                                ;(rsvd : BITS_WIDTH (23 , 0))
                                                ;  reserved
)
; 
;  * Abstract values representing fe0:fe1.
;  * See get_fp_exc_mode(), below.
;  

(defconstant $FEM_IGNORE_EXCEP 0)               ;  ignore exceptions

(defconstant $FEM_IMPR_NONREC 1)                ;  imprecise nonrecoverable

(defconstant $FEM_IMPR_RECOV 2)                 ;  imprecise recoverable

(defconstant $FEM_PRECISE 3)
(def-mactype :fp_exc_mode_t (find-mactype ':SINT32))
; 
;  * Special purpose registers.
;  
; 
;  * Processor version register (special purpose register pvr).
;  
(defrecord pvr_t
   (version :UInt32)                            ;(: BITS_WIDTH (31 , 16))
                                                ;(revision : BITS_WIDTH (15 , 0))
)
; 
;  * Fixed point exception register (special purpose register xer)
;  
(defrecord xer_t
   (so :UInt32)                                 ;(: BIT_WIDTH (31))
                                                ;  summary overflow
                                                ;(ov : BIT_WIDTH (30))
                                                ;  overflow
                                                ;(ca : BIT_WIDTH (29))
                                                ;  carry
                                                ;(rsvd1 : BITS_WIDTH (28 , 7))
                                                ;  reserved
                                                ;(byte_count : BITS_WIDTH (6 , 0))
)
; 
;  * Inlines and macros to manipulate the above registers.
;  
; 
;  * Get/set machine state register.
;  
#|
 confused about STATIC __inline__ msr_t get_msr #\( #\) #\{ msr_t __msr_tmp #\; __asm__ volatile #\( "mfmsr %0  /* mfmsr */" #\: "=r" #\( __msr_tmp #\) #\) #\; return __msr_tmp #\;
|#
#|
 confused about STATIC __inline__ void set_msr #\( msr_t msr #\) #\{ __asm__ volatile #\( "mtmsr %0 /* mtmsr */ " #\: #\: "r" #\( msr #\) #\) #\;
|#
;  
;  * Determine current fp_exc_mode_t given prog_mode.
;  
#|
 confused about STATIC __inline__ fp_exc_mode_t get_fp_exc_mode #\( pmr_t pmr #\) #\{ if #\( pmr.fe0 #\) return pmr.fe1 ? FEM_PRECISE #\: FEM_IMPR_RECOV #\; else return pmr.fe1 ? FEM_IMPR_NONREC #\: FEM_IGNORE_EXCEP #\;
|#
; 
;  * Software definitions for special purpose registers.
;  * The same register is used as per_cpu data pointer and
;  * vector base register. This requires that the vector
;  * table be the first item in the per_cpu table.
;  
; #define SR_EXCEPTION_TMP_LR	sprg0
; #define SR_EXCEPTION_TMP_CR	sprg1
; #define SR_EXCEPTION_TMP_AT	sprg2
; #define SR_PER_CPU_DATA		sprg3
; #define SR_VBR			sprg3
; 
;  * Get/set special purpose registers.
;  *
;  * GET_SPR - get SPR by name.
;  *
;  * Example usage:
;  *
;  *   {
;  *	xer_t	some_xer;
;  *
;  *	some_xer = GET_SPR(xer_t, xer);
;  *	...
;  *   }
;  *
;  * This is a strange one. We're creating a list of C expressions within
;  * a set of curlies; the last expression ("__spr_tmp;") is the return value
;  * of the statement created by the curlies.
;  *
;  
; #define GET_SPR(type, spr)					({									unsigned	__spr_tmp;					__asm__ volatile ("mfspr %0, " STRINGIFY(spr) : "=r" (__spr_tmp));					*(type *)&__spr_tmp;					})
;  
;  * Example usage of SET_SPR:
;  *
;  *   {
;  *	xer_t some_xer;
;  *
;  *	...set up some_xer...
;  *	SET_SPR(xer, some_xer);
;  *   }
;  
; #define	SET_SPR(spr, val)					MACRO_BEGIN								__typeof__ (val) __spr_tmp = (val);				__asm__ volatile ("mtspr "STRINGIFY(spr) ", %0" : : "r" (__spr_tmp));					MACRO_END
; 
;  * Fully synchronize instruction stream.
;  
#|
 confused about STATIC __inline__ void ppc_sync #\( #\) #\{ __asm__ volatile #\( "sync         /* sync */" #\: #\: #\) #\;
|#

; #endif /* ! __ASSEMBLER__ */


; #endif /* _ARCH_PPC_BASIC_REGS_H_ */


(provide-interface "basic_regs")