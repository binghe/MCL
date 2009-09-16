(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:boot_info.h"
; at Sunday July 2,2006 7:27:10 pm.
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
;  * @OSF_COPYRIGHT@
;  
; 
;  * HISTORY
;  * 
;  * Revision 1.1.1.1  1998/09/22 21:05:31  wsanchez
;  * Import of Mac OS X kernel (~semeria)
;  *
;  * Revision 1.1.1.1  1998/03/07 02:25:45  wsanchez
;  * Import of OSF Mach kernel (~mburg)
;  *
;  * Revision 1.2.16.4  1996/01/09  19:21:29  devrcs
;  * 	Added bootstrap map for alpha.
;  * 	This probably should be moved to some MD include file.
;  * 	It's not really machine dependent, just a different
;  * 	way of doing things.
;  * 	[1995/12/01  19:49:04  jfraser]
;  *
;  * 	Merged '64-bit safe' changes from DEC alpha port.
;  * 	[1995/11/21  18:08:36  jfraser]
;  *
;  * Revision 1.2.16.3  1995/01/06  19:50:04  devrcs
;  * 	mk6 CR668 - 1.3b26 merge
;  * 	Added region_desc structure;
;  * 	[1994/10/14  03:42:28  dwm]
;  * 
;  * Revision 1.2.16.2  1994/09/23  02:34:18  ezf
;  * 	change marker to not FREE
;  * 	[1994/09/22  21:39:03  ezf]
;  * 
;  * Revision 1.2.16.1  1994/06/13  20:49:19  dlb
;  * 	Merge MK6 and NMK17
;  * 	[1994/06/13  20:24:22  dlb]
;  * 
;  * Revision 1.2.14.1  1994/02/08  11:01:06  bernadat
;  * 	Checked in NMK16_1 changes
;  * 	[94/02/04            bernadat]
;  * 
;  * Revision 1.2.12.1  1993/12/23  08:56:06  bernadat
;  * 	Added COFF_F.
;  * 	[93/11/29            bernadat]
;  * 
;  * Revision 1.2.3.2  1993/06/24  16:14:07  gm
;  * 	CR9371: Moved here from default_pager.
;  * 	[1993/06/24  16:08:52  gm]
;  * 
;  * Revision 1.2.3.2  1993/06/09  02:10:53  gm
;  * 	Added to OSF/1 R1.3 from NMK15.0.
;  * 	[1993/06/02  20:41:54  gm]
;  * 
;  * Revision 1.2  1993/04/19  16:31:50  devrcs
;  * 	Added ROSE support: we need several symbol table entries since ROSE
;  * 	can have up to 3 symbol section.
;  * 	[93/03/24            bruel]
;  * 
;  * 	Use free copyright
;  * 	[1993/03/03  12:12:37  bernadat]
;  * 
;  * 	Fixed History Revision Comments
;  * 	[93/02/24            bernadat]
;  * 
;  * 	Created for external default pager.
;  * 	[1993/02/09  15:40:42  bruel]
;  * 
;  * $EndLog$
;  
;  CMU_HIST 
; 
;  * Revision 2.2  92/01/03  20:19:42  dbg
;  * 	Created.
;  * 	[91/09/06            dbg]
;  * 
;  
;  CMU_ENDHIST 
; 
;  
;  
;  * Mach Operating System
;  * Copyright (c) 1991 Carnegie Mellon University
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
; #ifndef	_MACH_BOOT_INFO_H_
; #define	_MACH_BOOT_INFO_H_

(require-interface "mach/machine/vm_types")

(require-interface "mach/vm_prot")

(require-interface "mach/boolean")
; 
;  * The boot loader uses several instances of the following structure to
;  * provide a description of the bootstrap task virtual address space,
;  * consisting of memory regions that need to be mapped from physical pages
;  * filled by the boot loader, or regions that need to be allocated in the
;  * new address space.
;  
(defrecord region_desc
   (addr :UInt32)
                                                ;  virtual address 
   (offset :UInt32)
                                                ;  offset within object 
   (size :UInt32)
                                                ;  size 
   (prot :signed-long)
                                                ;  protection 
   (mapped :signed-long)
                                                ;  mapped or zero-filled 
)
; #ifdef 	__alpha
#| #|
typedef  long physaddr_t;
#define NBOOT_REGIONS	5

#define TEXT	0
#define DATA	1
#define BSS	2
#define STACK	3
#define SYMS	4

struct bootstrap_map {
	physaddr_t  boot_location;
	long	boot_size;
	long	boot_entry;
	long	boot_gp_value;
	long	boot_region_count;
	struct region_desc boot_regions[NBOOT_REGIONS];
};

#endif
|#
 |#
;  __alpha 
(defconstant $BOOT_INFO_COMPAT 1)
; #define	BOOT_INFO_COMPAT	1

; #if	BOOT_INFO_COMPAT
; 
;  * Old compat code for makeboot produced images
;  
; 
;  * Structure of Mach kernel boot file.
;  

(require-interface "mach/machine/vm_types")
; 
;  *	A Mach kernel boot file consists of the Mach
;  *	kernel image and the bootstrap image, glued
;  *	together.
;  *
;  *	The first part of the file is a normal executable
;  *	(bootable) file: a.out, coff, or whatever.  The
;  *	text and data sizes are set to include the entire
;  *	file.  (Some machines do not allow a zero-length
;  *	data segment).
;  *
;  *	The rest of the file sits where the kernel BSS
;  *	should be.  A boot_info record describes the
;  *	sizes of the next 3 sections.  Following this
;  *	are the kernel symbol table, the bootstrap image
;  *	(including its symbol table), and the loader
;  *	information for the bootstrap image.  Each
;  *	of these sections is padded to an integer (4-byte)
;  *	boundary.
;  *
;  *	When the file is loaded into memory, the kernel
;  *	text and data segments are at their normal locations.
;  *
;  *	The boot_info structure appears at the start of
;  *	the bss (at 'edata[]'):
;  
(defrecord boot_info
   (sym_size :UInt32)
                                                ;  size of kernel symbols 
   (boot_size :UInt32)
                                                ;  size of bootstrap image 
   (load_info_size :UInt32)
                                                ;  size of loader information
; 						   for bootstrap image 
)
; 
;  *	The 3 sections must be moved out of BSS for the kernel to run:
;  *
;  *	The kernel symbol table follows the BSS (at 'end[]').
;  *
;  *	The bootstrap image is on the first page boundary (machine page
;  *	size) following the kernel symbol table.
;  *
;  *	The loader information immediately follows the bootstrap image.
;  
; 
;  *	Loader information for bootstrap image:
;  
(defconstant $AOUT_F 1)
; #define AOUT_F 1
(defconstant $ROSE_F 2)
; #define ROSE_F 2
(defconstant $COFF_F 3)
; #define COFF_F 3
(defrecord loader_info
   (format :signed-long)                        ;  symbol table format (A.OUT or ROSE) 
   (text_start :UInt32)
                                                ;  text start in memory 
   (text_size :UInt32)
                                                ;  text size 
   (text_offset :UInt32)
                                                ;  text offset in file 
   (data_start :UInt32)
                                                ;  data+bss start in memory 
   (data_size :UInt32)
                                                ;  data size 
   (data_offset :UInt32)
                                                ;  data offset in file 
   (bss_size :UInt32)
                                                ;  BSS size 
   (str_offset :UInt32)                         ;  strings table offset in file 
   (str_size :UInt32)                           ;  strings table size 
   (sym_offset (:array :UInt32 4))
                                                ;  symbol table offset in file 
   (sym_size (:array :UInt32 4))
                                                ;  symbol table size 
   (entry_1 :UInt32)
                                                ;  2 words for entry address 
   (entry_2 :UInt32)
)
(defconstant $EX_NOT_EXECUTABLE 6000)
; #define	EX_NOT_EXECUTABLE	6000

; #endif	/* BOOT_INFO_COMPAT */


; #endif	/* _MACH_BOOT_INFO_H_ */


(provide-interface "boot_info")