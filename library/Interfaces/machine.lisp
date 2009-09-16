(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:machine.h"
; at Sunday July 2,2006 7:24:02 pm.
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
;  * Mach Operating System
;  * Copyright (c) 1991,1990,1989,1988,1987 Carnegie Mellon University
;  * All Rights Reserved.
;  * 
;  * Permission to use, copy, modify and distribute this software and its
;  * documentation is hereby granted, provided that both the copyright
;  * notice and this permission notice appear in all copies of the
;  * software, derivative works or modified versions, and any portions
;  * thereof, and that both notices appear in supporting documentation.
;  * 
;  * CARNEGIE MELLON ALLOWS FREE USE OF THIS SOFTWARE IN ITS "AS IS"
;  * CONDITION.  CARNEGIE MELLON DISCLAIMS ANY LIABILITY OF ANY KIND FOR
;  * ANY DAMAGES WHATSOEVER RESULTING FROM THE USE OF THIS SOFTWARE.
;  * 
;  * Carnegie Mellon requests users of this software to return to
;  * 
;  *  Software Distribution Coordinator  or  Software.Distribution@CS.CMU.EDU
;  *  School of Computer Science
;  *  Carnegie Mellon University
;  *  Pittsburgh PA 15213-3890
;  * 
;  * any improvements or extensions that they make and grant Carnegie Mellon
;  * the rights to redistribute these changes.
;  
; 	File:	machine.h
;  *	Author:	Avadis Tevanian, Jr.
;  *	Date:	1986
;  *
;  *	Machine independent machine abstraction.
;  
; #ifndef	_MACH_MACHINE_H_
; #define _MACH_MACHINE_H_

(require-interface "sys/appleapiopts")

(require-interface "mach/machine/vm_types")

(require-interface "mach/boolean")
; 
;  *	For each host, there is a maximum possible number of
;  *	cpus that may be available in the system.  This is the
;  *	compile-time constant NCPUS, which is defined in cpus.h.
;  *
;  *	In addition, there is a machine_slot specifier for each
;  *	possible cpu in the system.
;  
(defrecord machine_info
   (major_version :signed-long)
                                                ;  kernel major version id 
   (minor_version :signed-long)
                                                ;  kernel minor version id 
   (max_cpus :signed-long)
                                                ;  max number of cpus compiled 
   (avail_cpus :signed-long)
                                                ;  number actually available 
   (memory_size :UInt32)
                                                ;  size of memory in bytes 
)

(def-mactype :machine_info_t (find-mactype '(:pointer :machine_info)))

(%define-record :machine_info_data_t (find-record-descriptor ':machine_info))
;  bogus 

(def-mactype :cpu_type_t (find-mactype ':signed-long))

(def-mactype :cpu_subtype_t (find-mactype ':signed-long))
(defconstant $CPU_STATE_MAX 4)
; #define CPU_STATE_MAX		4
(defconstant $CPU_STATE_USER 0)
; #define CPU_STATE_USER		0
(defconstant $CPU_STATE_SYSTEM 1)
; #define CPU_STATE_SYSTEM	1
(defconstant $CPU_STATE_IDLE 2)
; #define CPU_STATE_IDLE		2
(defconstant $CPU_STATE_NICE 3)
; #define CPU_STATE_NICE		3
; #ifdef	KERNEL_PRIVATE
#| #|
#ifdef  __APPLE_API_UNSTABLE

struct machine_slot {
integer_t	is_cpu;		
	cpu_type_t	cpu_type;	
	cpu_subtype_t	cpu_subtype;	
integer_t	running;	
	integer_t	cpu_ticks[CPU_STATE_MAX];
	integer_t	clock_freq;	
};

typedef struct machine_slot	*machine_slot_t;
typedef struct machine_slot	machine_slot_data_t;	

extern struct machine_info	machine_info;
extern struct machine_slot	machine_slot[];

#endif
#endif
|#
 |#
;  KERNEL_PRIVATE 
; 
;  *	Machine types known by all.
;  
; #define CPU_TYPE_ANY		((cpu_type_t) -1)
(defconstant $CPU_TYPE_VAX 1)
; #define CPU_TYPE_VAX		((cpu_type_t) 1)
;  skip				((cpu_type_t) 2)	
;  skip				((cpu_type_t) 3)	
;  skip				((cpu_type_t) 4)	
;  skip				((cpu_type_t) 5)	
(defconstant $CPU_TYPE_MC680x0 6)
; #define	CPU_TYPE_MC680x0	((cpu_type_t) 6)
(defconstant $CPU_TYPE_I386 7)
; #define CPU_TYPE_I386		((cpu_type_t) 7)
;  skip CPU_TYPE_MIPS		((cpu_type_t) 8)	
;  skip 			((cpu_type_t) 9)	
(defconstant $CPU_TYPE_MC98000 10)
; #define CPU_TYPE_MC98000	((cpu_type_t) 10)
(defconstant $CPU_TYPE_HPPA 11)
; #define CPU_TYPE_HPPA           ((cpu_type_t) 11)
;  skip CPU_TYPE_ARM		((cpu_type_t) 12)	
(defconstant $CPU_TYPE_MC88000 13)
; #define CPU_TYPE_MC88000	((cpu_type_t) 13)
(defconstant $CPU_TYPE_SPARC 14)
; #define CPU_TYPE_SPARC		((cpu_type_t) 14)
(defconstant $CPU_TYPE_I860 15)
; #define CPU_TYPE_I860		((cpu_type_t) 15)
;  skip	CPU_TYPE_ALPHA		((cpu_type_t) 16)	
;  skip				((cpu_type_t) 17)	
(defconstant $CPU_TYPE_POWERPC 18)
; #define CPU_TYPE_POWERPC		((cpu_type_t) 18)
; 
;  *	Machine subtypes (these are defined here, instead of in a machine
;  *	dependent directory, so that any program can get all definitions
;  *	regardless of where is it compiled).
;  
; 
;  *	Object files that are hand-crafted to run on any
;  *	implementation of an architecture are tagged with
;  *	CPU_SUBTYPE_MULTIPLE.  This functions essentially the same as
;  *	the "ALL" subtype of an architecture except that it allows us
;  *	to easily find object files that may need to be modified
;  *	whenever a new implementation of an architecture comes out.
;  *
;  *	It is the responsibility of the implementor to make sure the
;  *	software handles unsupported implementations elegantly.
;  
; #define	CPU_SUBTYPE_MULTIPLE		((cpu_subtype_t) -1)
(defconstant $CPU_SUBTYPE_LITTLE_ENDIAN 0)
; #define CPU_SUBTYPE_LITTLE_ENDIAN	((cpu_subtype_t) 0)
(defconstant $CPU_SUBTYPE_BIG_ENDIAN 1)
; #define CPU_SUBTYPE_BIG_ENDIAN		((cpu_subtype_t) 1)
; 
;  *	VAX subtypes (these do *not* necessary conform to the actual cpu
;  *	ID assigned by DEC available via the SID register).
;  
(defconstant $CPU_SUBTYPE_VAX_ALL 0)
; #define	CPU_SUBTYPE_VAX_ALL	((cpu_subtype_t) 0) 
(defconstant $CPU_SUBTYPE_VAX780 1)
; #define CPU_SUBTYPE_VAX780	((cpu_subtype_t) 1)
(defconstant $CPU_SUBTYPE_VAX785 2)
; #define CPU_SUBTYPE_VAX785	((cpu_subtype_t) 2)
(defconstant $CPU_SUBTYPE_VAX750 3)
; #define CPU_SUBTYPE_VAX750	((cpu_subtype_t) 3)
(defconstant $CPU_SUBTYPE_VAX730 4)
; #define CPU_SUBTYPE_VAX730	((cpu_subtype_t) 4)
(defconstant $CPU_SUBTYPE_UVAXI 5)
; #define CPU_SUBTYPE_UVAXI	((cpu_subtype_t) 5)
(defconstant $CPU_SUBTYPE_UVAXII 6)
; #define CPU_SUBTYPE_UVAXII	((cpu_subtype_t) 6)
(defconstant $CPU_SUBTYPE_VAX8200 7)
; #define CPU_SUBTYPE_VAX8200	((cpu_subtype_t) 7)
(defconstant $CPU_SUBTYPE_VAX8500 8)
; #define CPU_SUBTYPE_VAX8500	((cpu_subtype_t) 8)
(defconstant $CPU_SUBTYPE_VAX8600 9)
; #define CPU_SUBTYPE_VAX8600	((cpu_subtype_t) 9)
(defconstant $CPU_SUBTYPE_VAX8650 10)
; #define CPU_SUBTYPE_VAX8650	((cpu_subtype_t) 10)
(defconstant $CPU_SUBTYPE_VAX8800 11)
; #define CPU_SUBTYPE_VAX8800	((cpu_subtype_t) 11)
(defconstant $CPU_SUBTYPE_UVAXIII 12)
; #define CPU_SUBTYPE_UVAXIII	((cpu_subtype_t) 12)
; 
;  * 	680x0 subtypes
;  *
;  * The subtype definitions here are unusual for historical reasons.
;  * NeXT used to consider 68030 code as generic 68000 code.  For
;  * backwards compatability:
;  * 
;  *	CPU_SUBTYPE_MC68030 symbol has been preserved for source code
;  *	compatability.
;  *
;  *	CPU_SUBTYPE_MC680x0_ALL has been defined to be the same
;  *	subtype as CPU_SUBTYPE_MC68030 for binary comatability.
;  *
;  *	CPU_SUBTYPE_MC68030_ONLY has been added to allow new object
;  *	files to be tagged as containing 68030-specific instructions.
;  
(defconstant $CPU_SUBTYPE_MC680x0_ALL 1)
; #define	CPU_SUBTYPE_MC680x0_ALL		((cpu_subtype_t) 1)
(defconstant $CPU_SUBTYPE_MC68030 1)
; #define CPU_SUBTYPE_MC68030		((cpu_subtype_t) 1) /* compat */
(defconstant $CPU_SUBTYPE_MC68040 2)
; #define CPU_SUBTYPE_MC68040		((cpu_subtype_t) 2) 
(defconstant $CPU_SUBTYPE_MC68030_ONLY 3)
; #define	CPU_SUBTYPE_MC68030_ONLY	((cpu_subtype_t) 3)
; 
;  *	I386 subtypes.
;  
(defconstant $CPU_SUBTYPE_I386_ALL 3)
; #define	CPU_SUBTYPE_I386_ALL	((cpu_subtype_t) 3)
(defconstant $CPU_SUBTYPE_386 3)
; #define CPU_SUBTYPE_386		((cpu_subtype_t) 3)
(defconstant $CPU_SUBTYPE_486 4)
; #define CPU_SUBTYPE_486		((cpu_subtype_t) 4)
; #define CPU_SUBTYPE_486SX	((cpu_subtype_t) 4 + 128)
(defconstant $CPU_SUBTYPE_586 5)
; #define CPU_SUBTYPE_586		((cpu_subtype_t) 5)
; #define CPU_SUBTYPE_INTEL(f, m)	((cpu_subtype_t) (f) + ((m) << 4))
; #define CPU_SUBTYPE_PENT	CPU_SUBTYPE_INTEL(5, 0)
; #define CPU_SUBTYPE_PENTPRO	CPU_SUBTYPE_INTEL(6, 1)
; #define CPU_SUBTYPE_PENTII_M3	CPU_SUBTYPE_INTEL(6, 3)
; #define CPU_SUBTYPE_PENTII_M5	CPU_SUBTYPE_INTEL(6, 5)
; #define CPU_SUBTYPE_INTEL_FAMILY(x)	((x) & 15)
(defconstant $CPU_SUBTYPE_INTEL_FAMILY_MAX 15)
; #define CPU_SUBTYPE_INTEL_FAMILY_MAX	15
; #define CPU_SUBTYPE_INTEL_MODEL(x)	((x) >> 4)
(defconstant $CPU_SUBTYPE_INTEL_MODEL_ALL 0)
; #define CPU_SUBTYPE_INTEL_MODEL_ALL	0
; 
;  *	Mips subtypes.
;  
(defconstant $CPU_SUBTYPE_MIPS_ALL 0)
; #define	CPU_SUBTYPE_MIPS_ALL	((cpu_subtype_t) 0)
(defconstant $CPU_SUBTYPE_MIPS_R2300 1)
; #define CPU_SUBTYPE_MIPS_R2300	((cpu_subtype_t) 1)
(defconstant $CPU_SUBTYPE_MIPS_R2600 2)
; #define CPU_SUBTYPE_MIPS_R2600	((cpu_subtype_t) 2)
(defconstant $CPU_SUBTYPE_MIPS_R2800 3)
; #define CPU_SUBTYPE_MIPS_R2800	((cpu_subtype_t) 3)
(defconstant $CPU_SUBTYPE_MIPS_R2000a 4)
; #define CPU_SUBTYPE_MIPS_R2000a	((cpu_subtype_t) 4)	/* pmax */
(defconstant $CPU_SUBTYPE_MIPS_R2000 5)
; #define CPU_SUBTYPE_MIPS_R2000	((cpu_subtype_t) 5)
(defconstant $CPU_SUBTYPE_MIPS_R3000a 6)
; #define CPU_SUBTYPE_MIPS_R3000a	((cpu_subtype_t) 6)	/* 3max */
(defconstant $CPU_SUBTYPE_MIPS_R3000 7)
; #define CPU_SUBTYPE_MIPS_R3000	((cpu_subtype_t) 7)
; 
;  *	MC98000 (PowerPC) subtypes
;  
(defconstant $CPU_SUBTYPE_MC98000_ALL 0)
; #define	CPU_SUBTYPE_MC98000_ALL	((cpu_subtype_t) 0)
(defconstant $CPU_SUBTYPE_MC98601 1)
; #define CPU_SUBTYPE_MC98601	((cpu_subtype_t) 1)
; 
;  *	HPPA subtypes for Hewlett-Packard HP-PA family of
;  *	risc processors. Port by NeXT to 700 series. 
;  
(defconstant $CPU_SUBTYPE_HPPA_ALL 0)
; #define	CPU_SUBTYPE_HPPA_ALL		((cpu_subtype_t) 0)
(defconstant $CPU_SUBTYPE_HPPA_7100 0)
; #define CPU_SUBTYPE_HPPA_7100		((cpu_subtype_t) 0) /* compat */
(defconstant $CPU_SUBTYPE_HPPA_7100LC 1)
; #define CPU_SUBTYPE_HPPA_7100LC		((cpu_subtype_t) 1)
; 
;  *	MC88000 subtypes.
;  
(defconstant $CPU_SUBTYPE_MC88000_ALL 0)
; #define	CPU_SUBTYPE_MC88000_ALL	((cpu_subtype_t) 0)
(defconstant $CPU_SUBTYPE_MC88100 1)
; #define CPU_SUBTYPE_MC88100	((cpu_subtype_t) 1)
(defconstant $CPU_SUBTYPE_MC88110 2)
; #define CPU_SUBTYPE_MC88110	((cpu_subtype_t) 2)
; 
;  *	SPARC subtypes
;  
(defconstant $CPU_SUBTYPE_SPARC_ALL 0)
; #define	CPU_SUBTYPE_SPARC_ALL		((cpu_subtype_t) 0)
; 
;  *	I860 subtypes
;  
(defconstant $CPU_SUBTYPE_I860_ALL 0)
; #define CPU_SUBTYPE_I860_ALL	((cpu_subtype_t) 0)
(defconstant $CPU_SUBTYPE_I860_860 1)
; #define CPU_SUBTYPE_I860_860	((cpu_subtype_t) 1)
; 
;  *	PowerPC subtypes
;  
(defconstant $CPU_SUBTYPE_POWERPC_ALL 0)
; #define CPU_SUBTYPE_POWERPC_ALL		((cpu_subtype_t) 0)
(defconstant $CPU_SUBTYPE_POWERPC_601 1)
; #define CPU_SUBTYPE_POWERPC_601		((cpu_subtype_t) 1)
(defconstant $CPU_SUBTYPE_POWERPC_602 2)
; #define CPU_SUBTYPE_POWERPC_602		((cpu_subtype_t) 2)
(defconstant $CPU_SUBTYPE_POWERPC_603 3)
; #define CPU_SUBTYPE_POWERPC_603		((cpu_subtype_t) 3)
(defconstant $CPU_SUBTYPE_POWERPC_603e 4)
; #define CPU_SUBTYPE_POWERPC_603e	((cpu_subtype_t) 4)
(defconstant $CPU_SUBTYPE_POWERPC_603ev 5)
; #define CPU_SUBTYPE_POWERPC_603ev	((cpu_subtype_t) 5)
(defconstant $CPU_SUBTYPE_POWERPC_604 6)
; #define CPU_SUBTYPE_POWERPC_604		((cpu_subtype_t) 6)
(defconstant $CPU_SUBTYPE_POWERPC_604e 7)
; #define CPU_SUBTYPE_POWERPC_604e	((cpu_subtype_t) 7)
(defconstant $CPU_SUBTYPE_POWERPC_620 8)
; #define CPU_SUBTYPE_POWERPC_620		((cpu_subtype_t) 8)
(defconstant $CPU_SUBTYPE_POWERPC_750 9)
; #define CPU_SUBTYPE_POWERPC_750		((cpu_subtype_t) 9)
(defconstant $CPU_SUBTYPE_POWERPC_7400 10)
; #define CPU_SUBTYPE_POWERPC_7400	((cpu_subtype_t) 10)
(defconstant $CPU_SUBTYPE_POWERPC_7450 11)
; #define CPU_SUBTYPE_POWERPC_7450	((cpu_subtype_t) 11)
; #ifndef _OPEN_SOURCE_
(defconstant $CPU_SUBTYPE_POWERPC_Max 10)
; #define CPU_SUBTYPE_POWERPC_Max		((cpu_subtype_t) 10)
(defconstant $CPU_SUBTYPE_POWERPC_SCVger 11)
; #define CPU_SUBTYPE_POWERPC_SCVger	((cpu_subtype_t) 11)

; #endif

(defconstant $CPU_SUBTYPE_POWERPC_970 100)
; #define CPU_SUBTYPE_POWERPC_970		((cpu_subtype_t) 100)

; #endif	/* _MACH_MACHINE_H_ */


(provide-interface "machine")