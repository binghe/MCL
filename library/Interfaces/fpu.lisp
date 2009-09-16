(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:fpu.h"
; at Sunday July 2,2006 7:24:05 pm.
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
;  * Copyright (c) 1992 NeXT Computer, Inc.
;  *
;  * Intel386 Family:	Floating Point unit.
;  *
;  * HISTORY
;  *
;  * 5 October 1992 ? at NeXT
;  *	Added names to previously unamed fields in the mantissa.
;  *
;  * 5 April 1992 ? at NeXT
;  *	Created.
;  
; 
;  * Data register.
;  
(defrecord fp_data_reg
   (mant :UInt16)
   (mant1 :UInt16)                              ;(: 16)
                                                ;(mant2 : 16)
                                                ;(mant3 : 16)
   (exp :UInt16)                                ;(: 15)
                                                ;(sign : 1)
)
(%define-record :fp_data_reg_t (find-record-descriptor :FP_DATA_REG))
; 
;  * Data register stack.
;  
(defrecord fp_stack
   (ST (:array :FP_DATA_REG 8))
)
(%define-record :fp_stack_t (find-record-descriptor :FP_STACK))
; 
;  * Register stack tag word.
;  
(defrecord fp_tag
   (tag0 :UInt16)                               ;(: 2)
                                                ;(tag1 : 2)
                                                ;(tag2 : 2)
                                                ;(tag3 : 2)
                                                ;(tag4 : 2)
                                                ;(tag5 : 2)
                                                ;(tag6 : 2)
                                                ;(tag7 : 2)
(defconstant $FP_TAG_VALID 0)
; #define FP_TAG_VALID		0
(defconstant $FP_TAG_ZERO 1)
; #define FP_TAG_ZERO		1
(defconstant $FP_TAG_SPEC 2)
; #define FP_TAG_SPEC		2
(defconstant $FP_TAG_EMPTY 3)
; #define FP_TAG_EMPTY		3
)
(%define-record :fp_tag_t (find-record-descriptor :FP_TAG))
; 
;  * Status word.
;  
(defrecord fp_status
   (invalid :UInt16)                            ;(: 1)
                                                ;(denorm : 1)
                                                ;(zdiv : 1)
                                                ;(ovrfl : 1)
                                                ;(undfl : 1)
                                                ;(precis : 1)
                                                ;(stkflt : 1)
                                                ;(errsumm : 1)
                                                ;(c0 : 1)
                                                ;(c1 : 1)
                                                ;(c2 : 1)
                                                ;(tos : 3)
                                                ;(c3 : 1)
                                                ;(busy : 1)
)
(%define-record :fp_status_t (find-record-descriptor :FP_STATUS))
; 
;  * Control word.
;  
(defrecord fp_control
   (invalid :UInt16)                            ;(: 1)
                                                ;(denorm : 1)
                                                ;(zdiv : 1)
                                                ;(ovrfl : 1)
                                                ;(undfl : 1)
                                                ;(precis : 1)
                                                ;(: 2)
                                                ;(pc : 2)
(defconstant $FP_PREC_24B 0)
; #define FP_PREC_24B		0
(defconstant $FP_PREC_53B 2)
; #define	FP_PREC_53B		2
(defconstant $FP_PREC_64B 3)
; #define FP_PREC_64B		3
                                                ;(rc : 2)
(defconstant $FP_RND_NEAR 0)
; #define FP_RND_NEAR		0
(defconstant $FP_RND_DOWN 1)
; #define FP_RND_DOWN		1
(defconstant $FP_RND_UP 2)
; #define FP_RND_UP		2
(defconstant $FP_CHOP 3)
; #define FP_CHOP			3
                                                ; inf
                                                ;(: 1)
                                                ;(: 3)
)
(%define-record :fp_control_t (find-record-descriptor :FP_CONTROL))

(require-interface "architecture/i386/sel")
; 
;  * Floating point 'environment'
;  * used by FSTENV/FLDENV instructions.
;  
(defrecord fp_env
   (control :FP_CONTROL)
   (colon9 :UInt16)
   (status :FP_STATUS)
   (colon1 :UInt16)
   (tag :FP_TAG)
   (colon6 :UInt16)
   (ip :UInt32)
   (cs :SEL)
   (opcode :UInt16)
   (dp :UInt32)
   (ds :SEL)
   (colon5 :UInt16)
)
(%define-record :fp_env_t (find-record-descriptor :FP_ENV))
; 
;  * Floating point state
;  * used by FSAVE/FRSTOR instructions.
;  
(defrecord fp_state
   (environ :FP_ENV)
   (stack :FP_STACK)
)
(%define-record :fp_state_t (find-record-descriptor :FP_STATE))

(provide-interface "fpu")