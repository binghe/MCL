(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vstat.h"
; at Sunday July 2,2006 7:32:16 pm.
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
;  Copyright (c) 1998 Apple Computer, Inc. All Rights Reserved 
; -
;  *	@(#)vstat.h	
;  
; #ifndef _SYS_VSTAT_H_
; #define	_SYS_VSTAT_H_

(require-interface "sys/appleapiopts")

; #warning obsolete header! delete the include from your sources
; #ifdef __APPLE_API_OBSOLETE
#| #|

#include <systime.h>
#include <sysattr.h>

#ifndef_POSIX_SOURCE

struct vstat {
	fsid_t			vst_volid;		
	fsobj_id_t		vst_nodeid;		
	fsobj_type_t		vst_vnodetype;	
	fsobj_tag_t		vst_vnodetag;	
	mode_t	  		vst_mode;		
	nlink_t	  		vst_nlink;		
	uid_t	  		vst_uid;		
	gid_t	  		vst_gid;		
	dev_t			vst_dev;		
	dev_t	  		vst_rdev;		
#ifndef_POSIX_SOURCE
	struct	timespec vst_atimespec;	
	struct	timespec vst_mtimespec;	
	struct	timespec vst_ctimespec;	
#else	time_t	  		vst_atime;		
	long	  		vst_atimensec;	
	time_t	  		vst_mtime;		
	long	  		vst_mtimensec;	
	time_t	  		vst_ctime;		
	long	  		vst_ctimensec;	
#endif	off_t	  		vst_filesize;	
	quad_t	  		vst_blocks;		
	u_int32_t 		vst_blksize;	
	u_int32_t 		vst_flags;		
};

#endif
#endif
|#
 |#
;  __APPLE_API_OBSOLETE 

; #endif /* !_SYS_VSTAT_H_ */


(provide-interface "vstat")