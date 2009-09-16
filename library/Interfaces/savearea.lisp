(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:savearea.h"
; at Sunday July 2,2006 7:27:31 pm.
; 
;  * Copyright (c) 2000-2002 Apple Computer, Inc. All rights reserved.
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
; #ifndef _PPC_SAVEAREA_H_
; #define _PPC_SAVEAREA_H_
; #ifndef ASSEMBLER

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_PRIVATE
#| #|

#ifdefMACH_KERNEL_PRIVATE
#include <stdint.h>
#include <machvm_types.h>

#pragma pack(4)							
typedef struct savearea_comm {





                                                
	addr64_t		save_prev;					
	addr64_t		sac_next;					
	addr64_t		sac_prev;					
	unsigned int	save_level;					
	unsigned int	save_01C;

												
	unsigned int	save_time[2];				
	struct thread_activation	*save_act;		
    unsigned int	save_02c;
	uint64_t		sac_vrswap;					
	unsigned int	save_flags;					
	unsigned int	sac_flags;					
    
                                                
	uint64_t		save_misc0;					
	uint64_t		save_misc1;					
	unsigned int	sac_alloc;					
    unsigned int	save_054;
    unsigned int	save_misc2;
    unsigned int	save_misc3;

												
} savearea_comm;
#pragma pack()
#endif
#ifdefBSD_KERNEL_PRIVATE
typedef struct savearea_comm {
	unsigned int	save_000[24];
} savearea_comm;
#endif
#ifdefined(MACH_KERNEL_PRIVATE) || defined(BSD_KERNEL_PRIVATE)

 
#pragma pack(4)							
typedef struct savearea {

	savearea_comm	save_hdr;					

	unsigned int	save_060[8];				

                                                
	uint64_t	 	save_r0;
	uint64_t	 	save_r1;
	uint64_t	 	save_r2;
	uint64_t	 	save_r3;
                                                
	uint64_t	 	save_r4;
	uint64_t	 	save_r5;
	uint64_t	 	save_r6;
	uint64_t	 	save_r7;
                                                
	uint64_t	 	save_r8;
	uint64_t	 	save_r9;
	uint64_t	 	save_r10;
	uint64_t	 	save_r11;
                                                
	uint64_t	 	save_r12;
	uint64_t	 	save_r13;
	uint64_t	 	save_r14;
	uint64_t	 	save_r15;
                                                
	uint64_t	 	save_r16;
	uint64_t	 	save_r17;
	uint64_t	 	save_r18;
	uint64_t	 	save_r19;
                                                
	uint64_t	 	save_r20;
	uint64_t	 	save_r21;
	uint64_t	 	save_r22;
	uint64_t	 	save_r23;
                                                
	uint64_t	 	save_r24;
	uint64_t	 	save_r25;
	uint64_t	 	save_r26;	
	uint64_t	 	save_r27;
                                                
	uint64_t	 	save_r28;
	uint64_t		save_r29;
	uint64_t	 	save_r30;
	uint64_t	 	save_r31;
                                                
	uint64_t	 	save_srr0;
 	uint64_t	 	save_srr1;
	uint64_t	 	save_xer;
	uint64_t	 	save_lr;
                                                
	uint64_t	 	save_ctr;
	uint64_t	 	save_dar;
	unsigned int	save_cr;
	unsigned int 	save_dsisr;
	unsigned int	save_exception; 
	unsigned int	save_vrsave;
                                                
	unsigned int	save_vscr[4];
	unsigned int	save_fpscrpad;
	unsigned int	save_fpscr;
    unsigned int	save_1d8[2];
                                                
	unsigned int	save_1E0[8];
                                                
    uint32_t        save_pmc[8]; 
    uint64_t        save_mmcr0;					
    uint64_t        save_mmcr1;
    uint64_t        save_mmcr2;

	unsigned int	save_238[2];
												
	unsigned int	save_instr[16];				
												
} savearea;
#pragma pack()



 
#pragma pack(4)							
typedef struct savearea_fpu {

	savearea_comm	save_hdr;					

	unsigned int	save_060[8];				
												
	double			save_fp0;
	double			save_fp1;
	double			save_fp2;
	double			save_fp3;

	double			save_fp4;
	double			save_fp5;
	double			save_fp6;
	double			save_fp7;

	double			save_fp8;
	double			save_fp9;
	double			save_fp10;
	double			save_fp11;
	
	double			save_fp12;
	double			save_fp13;
	double			save_fp14;
	double			save_fp15;
	
	double			save_fp16;
	double			save_fp17;
	double			save_fp18;
	double			save_fp19;

	double			save_fp20;
	double			save_fp21;
	double			save_fp22;
	double			save_fp23;
	
	double			save_fp24;
	double			save_fp25;
	double			save_fp26;
	double			save_fp27;
	
	double			save_fp28;
	double			save_fp29;
	double			save_fp30;
	double			save_fp31;
												
	unsigned int	save_180[8];
	unsigned int	save_1A0[8];
	unsigned int	save_1C0[8];
	unsigned int	save_1E0[8];
	unsigned int	save_200[8];
	unsigned int	save_220[8];
	unsigned int	save_240[8];
	unsigned int	save_260[8];

												
} savearea_fpu;
#pragma pack()

	


 
#pragma pack(4)							
typedef struct savearea_vec {

	savearea_comm	save_hdr;					

	unsigned int	save_060[7];				
	unsigned int	save_vrvalid;				

												
	unsigned int	save_vr0[4];
	unsigned int	save_vr1[4];
	unsigned int	save_vr2[4];
	unsigned int	save_vr3[4];
	unsigned int	save_vr4[4];
	unsigned int	save_vr5[4];
	unsigned int	save_vr6[4];
	unsigned int	save_vr7[4];
	unsigned int	save_vr8[4];
	unsigned int	save_vr9[4];
	unsigned int	save_vr10[4];
	unsigned int	save_vr11[4];
	unsigned int	save_vr12[4];
	unsigned int	save_vr13[4];
	unsigned int	save_vr14[4];
	unsigned int	save_vr15[4];
	unsigned int	save_vr16[4];
	unsigned int	save_vr17[4];
	unsigned int	save_vr18[4];
	unsigned int	save_vr19[4];
	unsigned int	save_vr20[4];
	unsigned int	save_vr21[4];
	unsigned int	save_vr22[4];
	unsigned int	save_vr23[4];
	unsigned int	save_vr24[4];
	unsigned int	save_vr25[4];
	unsigned int	save_vr26[4];
	unsigned int	save_vr27[4];
	unsigned int	save_vr28[4];
	unsigned int	save_vr29[4];
	unsigned int	save_vr30[4];
	unsigned int	save_vr31[4];

												
} savearea_vec;
#pragma pack()
#endif

#ifdefMACH_KERNEL_PRIVATE

#pragma pack(4)							
struct Saveanchor {



	unsigned int			savelock;		
    int						saveRSVD4;		
	addr64_t				savepoolfwd;	
	addr64_t				savepoolbwd;	
	volatile addr64_t		savefree;		
	volatile unsigned int	savefreecnt;	
	volatile int			saveadjust;		
	volatile int			saveinuse;		
	volatile int			savetarget;		
	int						savemaxcount;	
	unsigned int			saveRSVD034[3];	


};
#pragma pack()


#define sac_cnt		(4096  sizeof(savearea))	
#define sac_empty	(0xFFFFFFFF << (32 - sac_cnt))	
#define sac_perm	0x40000000				
#define sac_permb	1						

#define LocalSaveTarget	(((8 + sac_cnt - 1)  sac_cnt) * sac_cnt)	
#define LocalSaveMin	(LocalSaveTarget  2)	
#define LocalSaveMax	(LocalSaveTarget * 2)	

#define FreeListMin		(2 * LocalSaveTarget * NCPUS)	
#define SaveLowHysteresis	LocalSaveTarget	
#define SaveHighHysteresis	FreeListMin		
#define InitialSaveAreas 	(2 * FreeListMin)	
#define InitialSaveTarget	FreeListMin		
#define InitialSaveBloks	(InitialSaveAreas + sac_cnt - 1)  sac_cnt	
#define BackPocketSaveBloks	8				

void			save_queue(ppnum_t);		
addr64_t		save_get_init(void);		
struct savearea	*save_get(void);			
reg64_t			save_get_phys_32(void);		
reg64_t			save_get_phys_64(void);		
struct savearea	*save_alloc(void);			
struct savearea	*save_cpv(addr64_t);		
void			save_ret(struct savearea *);	
void			save_ret_wMSR(struct savearea *, reg64_t);	
void			save_ret_phys(reg64_t);		
void			save_adjust(void);			
struct savearea_comm	*save_trim_free(void);	
int				save_recover(void);			
void 			savearea_init(vm_offset_t addr);	


#endif
#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif /* ndef ASSEMBLER */

(defconstant $SAVattach 2147483648)
; #define SAVattach	0x80000000				/* Savearea has valid context */
(defconstant $SAVrststk 65536)
; #define SAVrststk	0x00010000				/* Indicates that the current stack should be reset to empty */
(defconstant $SAVsyscall 131072)
; #define SAVsyscall	0x00020000				/* Indicates that the savearea is associated with a syscall */
(defconstant $SAVredrive 262144)
; #define SAVredrive	0x00040000				/* Indicates that the low-level fault handler associated */
(defconstant $SAVredriveb 13)
; #define SAVredriveb	13						/* Indicates that the low-level fault handler associated */
(defconstant $SAVinstrument 524288)
; #define	SAVinstrument 0x00080000			/* Indicates that we should return instrumentation data */
(defconstant $SAVinstrumentb 12)
; #define	SAVinstrumentb 12					/* Indicates that we should return instrumentation data */
(defconstant $SAVtype 65280)
; #define SAVtype		0x0000FF00				/* Shows type of savearea */
(defconstant $SAVtypeshft 8)
; #define SAVtypeshft	8						/* Shift to position type */
(defconstant $SAVempty 134)
; #define SAVempty	0x86					/* Savearea is on free list */
(defconstant $SAVgeneral 1)
; #define SAVgeneral	0x01					/* Savearea contains general context */
(defconstant $SAVfloat 2)
; #define SAVfloat	0x02					/* Savearea contains floating point context */
(defconstant $SAVvector 3)
; #define SAVvector	0x03					/* Savearea contains vector context */

; #endif /* _PPC_SAVEAREA_H_ */


(provide-interface "savearea")