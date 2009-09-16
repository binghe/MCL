(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:cpuid.h"
; at Sunday July 2,2006 7:27:26 pm.
; 
;  * Copyright (c) 2000-2003 Apple Computer, Inc. All rights reserved.
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
;  * @OSF_COPYRIGHT@
;  
; 
;  * x86 CPU identification
;  *
;  
; #ifndef _MACHINE_CPUID_H_
; #define _MACHINE_CPUID_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_PRIVATE
#| #|

#define CPUID_VID_SIZE		12
#define CPUID_VID_INTEL		"GenuineIntel"
#define CPUID_VID_UMC		"UMC UMC UMC "
#define CPUID_VID_AMD		"AuthenticAMD"
#define CPUID_VID_CYRIX		"CyrixInstead"
#define CPUID_VID_NEXTGEN	"NexGenDriven"

#define CPUID_FEATURE_FPU    0x00000001	
#define CPUID_FEATURE_VME    0x00000002	
#define CPUID_FEATURE_DE     0x00000004	
#define CPUID_FEATURE_PSE    0x00000008	
#define CPUID_FEATURE_TSC    0x00000010	
#define CPUID_FEATURE_MSR    0x00000020	
#define CPUID_FEATURE_PAE    0x00000040 
#define CPUID_FEATURE_MCE    0x00000080	
#define CPUID_FEATURE_CX8    0x00000100	
#define CPUID_FEATURE_APIC   0x00000200	
#define CPUID_FEATURE_SEP    0x00000800 
#define CPUID_FEATURE_MTRR   0x00001000	
#define CPUID_FEATURE_PGE    0x00002000	
#define CPUID_FEATURE_MCA    0x00004000	
#define CPUID_FEATURE_CMOV   0x00008000	
#define CPUID_FEATURE_PAT    0x00010000 
#define CPUID_FEATURE_PSE36  0x00020000 
#define CPUID_FEATURE_PSN    0x00040000 
#define CPUID_FEATURE_CLFSH  0x00080000 
#define CPUID_FEATURE_DS     0x00200000 
#define CPUID_FEATURE_ACPI   0x00400000 
#define CPUID_FEATURE_MMX    0x00800000 
#define CPUID_FEATURE_FXSR   0x01000000 
#define CPUID_FEATURE_SSE    0x02000000 
#define CPUID_FEATURE_SSE2   0x04000000 
#define CPUID_FEATURE_SS     0x08000000 
#define CPUID_FEATURE_HTT    0x10000000 
#define CPUID_FEATURE_TM     0x20000000 

#define CPUID_TYPE_OEM		    0x0	
#define CPUID_TYPE_OVERDRIVE	    0x1	
#define CPUID_TYPE_DUAL		    0x2	
#define CPUID_TYPE_RESERVED	    0x3	

#define CPUID_FAMILY_386	    0x3	
#define CPUID_FAMILY_486	    0x4	
#define CPUID_FAMILY_P5		    0x5	
#define CPUID_FAMILY_PPRO	    0x6	
#define CPUID_FAMILY_PENTIUM4       0xF 

#define CPUID_MODEL_I386_DX	    0x0	

#define CPUID_MODEL_I486_DX	    0x0	
#define CPUID_MODEL_I486_DX_S	    0x1	
#define CPUID_MODEL_I486_SX	    0x2	
#define CPUID_MODEL_I486_DX2	    0x3	
#define CPUID_MODEL_I486_SL	    0x4	
#define CPUID_MODEL_I486_SX2	    0x5	
#define CPUID_MODEL_I486_DX2WB	    0x7	
#define CPUID_MODEL_I486_DX4	    0x8	
#define CPUID_MODEL_I486_DX4WB	    0x9	

#define CPUID_MODEL_AM486_DX	    0x1	
#define CPUID_MODEL_AM486_DX2	    0x3	
#define CPUID_MODEL_AM486_DX2WB	    0x7	
#define CPUID_MODEL_AM486_DX4	    0x8	
#define CPUID_MODEL_AM486_DX4WB	    0x9	
#define CPUID_MODEL_AM486_5X86	    0xE	
#define CPUID_MODEL_AM486_5X86WB    0xF	

#define CPUID_MODEL_CYRIX5X86	    0x9	

#define CPUID_MODEL_UMC5SD	    0x1	
#define CPUID_MODEL_UMC5S	    0x2	
#define CPUID_MODEL_UMC486_DX2	    0x3	
#define CPUID_MODEL_UMC486_SX2	    0x5	

#define CPUID_MODEL_P5A		    0x0	
#define CPUID_MODEL_P5		    0x1	
#define CPUID_MODEL_P54		    0x2	
#define CPUID_MODEL_P24T	    0x3	

#define CPUID_MODEL_P6		    0x1	
#define CPUID_MODEL_PII		    0x3	
#define CPUID_MODEL_P65             0x5 
#define CPUID_MODEL_P66             0x6 
#define CPUID_MODEL_P67             0x7 
#define CPUID_MODEL_P68             0x8 
#define CPUID_MODEL_P6A             0xA 
#define CPUID_MODEL_P6B             0xB 

#define CPUID_CACHE_SIZE	16	

#define CPUID_CACHE_NULL	   0x00	
#define CPUID_CACHE_ITLB_4K	   0x01	
#define CPUID_CACHE_ITLB_4M	   0x02	
#define CPUID_CACHE_DTLB_4K	   0x03	
#define CPUID_CACHE_DTLB_4M	   0x04	
#define CPUID_CACHE_ICACHE_8K	   0x06	
#define CPUID_CACHE_ICACHE_16K	   0x08	
#define CPUID_CACHE_DCACHE_8K	   0x0A	
#define CPUID_CACHE_DCACHE_16K	   0x0C	
#define CPUID_CACHE_UCACHE_128K	   0x41	
#define CPUID_CACHE_UCACHE_256K	   0x42	
#define CPUID_CACHE_UCACHE_512K	   0x43	
#define CPUID_CACHE_UCACHE_1M	   0x44	
#define CPUID_CACHE_UCACHE_2M	   0x45	
#define CPUID_CACHE_ITLB_64        0x50 
#define CPUID_CACHE_ITLB_128       0x51 
#define CPUID_CACHE_ITLB_256       0x52 
#define CPUID_CACHE_DTLB_64        0x5B 
#define CPUID_CACHE_DTLB_128       0x5C 
#define CPUID_CACHE_DTLB_256       0x5D 
#define CPUID_CACHE_DCACHE_8K_64   0x66	
#define CPUID_CACHE_DCACHE_16K_64  0x67 
#define CPUID_CACHE_DCACHE_32K_64  0x68 
#define CPUID_CACHE_TRACE_12K      0x70 
#define CPUID_CACHE_TRACE_16K      0x71 
#define CPUID_CACHE_TRACE_32K      0x72 
#define CPUID_CACHE_UCACHE_128K_64 0x79 
#define CPUID_CACHE_UCACHE_256K_64 0x7A 
#define CPUID_CACHE_UCACHE_512K_64 0x7B 
#define CPUID_CACHE_UCACHE_1M_64   0x7C 
#define CPUID_CACHE_UCACHE_256K_32 0x82 
#define CPUID_CACHE_UCACHE_512K_32 0x83 
#define CPUID_CACHE_UCACHE_1M_32   0x84 
#define CPUID_CACHE_UCACHE_2M_32   0x85 

#ifndefASSEMBLER
#include <stdint.h>
#include <machmach_types.h>
#include <kernkern_types.h>
#include <machmachine.h>


static inline void
do_cpuid(uint32_t selector, uint32_t *data)
{
	asm("cpuid"
		: "=a" (data[0]),
		  "=b" (data[1]),
		  "=c" (data[2]),
		  "=d" (data[3])
		: "a"(selector));
}


typedef enum { Lnone, L1I, L1D, L2U, LCACHE_MAX } cache_type_t ; 
typedef struct {
	unsigned char	value;          
	cache_type_t 	type;           
	unsigned int 	size;           
	unsigned int 	linesize;       
#ifdefKERNEL
	char         	*description;   
#endif
} cpuid_cache_desc_t;  

#ifdefKERNEL
#define CACHE_DESC(value,type,size,linesize,text) \
	{ value, type, size, linesize, text }
#else#define CACHE_DESC(value,type,size,linesize,text) \
	{ value, type, size, linesize }
#endif


typedef struct {
	char		cpuid_vendor[16];
	char		cpuid_brand_string[48];

	uint32_t	cpuid_value;
	cpu_type_t	cpuid_type;
	uint8_t		cpuid_family;
	uint8_t		cpuid_model;
	uint8_t		cpuid_extmodel;
	uint8_t		cpuid_extfamily;
	uint8_t		cpuid_stepping;
	uint32_t	cpuid_features;
	uint32_t	cpuid_signature;
	uint8_t   	cpuid_brand; 
	
	uint32_t	cache_size[LCACHE_MAX];
	uint32_t	cache_linesize;

	char            model_string[64];  
	uint8_t		cache_info[64];    

} i386_cpu_info_t;



extern cpu_type_t	cpuid_cputype(int);
extern void		cpuid_cpu_display(char *, int);
extern void		cpuid_features_display(char *, int);
extern char *		cpuid_get_feature_names(uint32_t, char *, unsigned);

extern uint32_t		cpuid_features(void);
extern uint32_t		cpuid_family(void);

extern char *		cpuid_intel_get_model_name(uint8_t, uint8_t,
						   uint8_t, uint32_t);

extern i386_cpu_info_t	*cpuid_info(void);

extern uint32_t		cpuid_feature;	
#endif

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif /* _MACHINE_CPUID_H_ */


(provide-interface "cpuid")