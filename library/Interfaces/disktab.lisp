(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:disktab.h"
; at Sunday July 2,2006 7:27:40 pm.
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
; 
;  * HISTORY:
;  * 16-Mar-88  John Seamons (jks) at NeXT
;  *	Cleaned up to support standard disk label definitions.
;  *
;  * 24-Feb-88  Mike DeMoney (mike) at NeXT
;  *	Added d_boot0_blkno to indicate logical block number
;  *	of "block 0" boot.  This blkno is in d_secsize sectors.
;  *	Added d_bootfile to indicate the default operating system
;  *	image to be booted by the blk 0 boot.
;  *	Changed d_name and d_type to be char arrays rather than ptrs
;  *	so they are part of label.  This limits length of info in
;  *	/etc/disktab, sorry.
;  
; #ifndef	_SYS_DISKTAB_
; #define	_SYS_DISKTAB_

(require-interface "sys/appleapiopts")
; #ifdef	__APPLE_API_OBSOLETE
#| #|


#ifndefKERNEL
#define DISKTAB		"etcdisktab"
#endif

#define MAXDNMLEN	24	#define MAXMPTLEN	16	#define MAXFSTLEN	8	#define MAXTYPLEN	24	#define NBOOTS		2	#define MAXBFLEN 	24	#define MAXHNLEN 	32	#define NPART		8	
typedef struct partition {
	int	p_base;		
	int	p_size;		
	short	p_bsize;	
	short	p_fsize;	
	char	p_opt;		
	short	p_cpg;		
	short	p_density;	
	char	p_minfree;	
	char	p_newfs;	
	char	p_mountpt[MAXMPTLEN];
	char	p_automnt;	
	char	p_type[MAXFSTLEN];
} partition_t;

typedef struct disktab {
	char	d_name[MAXDNMLEN];	
	char	d_type[MAXTYPLEN];	
	int	d_secsize;		
	int	d_ntracks;		
	int	d_nsectors;		
	int	d_ncylinders;		
	int	d_rpm;			
	short	d_front;		
	short	d_back;			
	short	d_ngroups;		
	short	d_ag_size;		
	short	d_ag_alts;		
	short	d_ag_off;		
	int	d_boot0_blkno[NBOOTS];	
	char	d_bootfile[MAXBFLEN];	
	char	d_hostname[MAXHNLEN];	
	char	d_rootpartition;	
	char	d_rwpartition;		
	partition_t d_partitions[NPART];
} disktab_t;

#ifndefKERNEL
struct	disktab *getdiskbyname(), *getdiskbydev();
#endif

#endif
|#
 |#
;  __APPLE_API_OBSOLETE 

; #endif	/* _SYS_DISKTAB_ */


(provide-interface "disktab")