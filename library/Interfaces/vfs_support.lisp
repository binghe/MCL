(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vfs_support.h"
; at Sunday July 2,2006 7:32:12 pm.
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
;  * Copyright (c) 1998 Apple Computer, Inc.  All rights reserved.
;  *
;  *  File:  vfs/vfs_support.h
;  *
;  *	Prototypes for the default vfs routines. A VFS plugin can use these
;  *	functions in case it does not want to implement all. These functions
;  *	take care of releasing locks and free up memory that they are
;  *	supposed to.
;  *
;  * HISTORY
;  *  18-Aug-1998 Umesh Vaishampayan (umeshv@apple.com)
;  *      Created. 
;  
; #ifndef	_VFS_VFS_SUPPORT_H_
; #define	_VFS_VFS_SUPPORT_H_

(require-interface "sys/param")

(require-interface "sys/systm")

(require-interface "sys/namei")

(require-interface "sys/resourcevar")

(require-interface "sys/kernel")

(require-interface "sys/file")

(require-interface "sys/stat")

(require-interface "sys/buf")

(require-interface "sys/proc")

(require-interface "sys/conf")

(require-interface "sys/mount")

(require-interface "sys/vnode")

(require-interface "sys/malloc")

(require-interface "sys/dirent")

(require-interface "vm/vm_pageout")

(deftrap-inline "_nop_create" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_create" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_whiteout" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_whiteout" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_mknod" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_mknod" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_mkcomplex" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_mkcomplex" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_open" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_open" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_close" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_close" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_access" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_access" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_getattr" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_getattr" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_setattr" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_setattr" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_getattrlist" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_getattrlist" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_setattrlist" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_setattrlist" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_read" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_read" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_write" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_write" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_lease" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_lease" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_ioctl" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_ioctl" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_select" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_select" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_exchange" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_exchange" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_revoke" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_revoke" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_mmap" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_mmap" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_fsync" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_fsync" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_seek" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_seek" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_remove" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_remove" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_link" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_link" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_rename" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_rename" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_mkdir" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_mkdir" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_rmdir" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_rmdir" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_symlink" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_symlink" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_readdir" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_readdir" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_readdirattr" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_readdirattr" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_readlink" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_readlink" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_abortop" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_abortop" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_inactive" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_inactive" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_reclaim" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_reclaim" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_lock" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_lock" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_unlock" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_unlock" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_bmap" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_bmap" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_strategy" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_strategy" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_print" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_print" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_islocked" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_islocked" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_pathconf" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_pathconf" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_advlock" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_advlock" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_blkatoff" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_blkatoff" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_valloc" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_valloc" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_reallocblks" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_reallocblks" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_vfree" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_vfree" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_truncate" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_truncate" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_allocate" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_allocate" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_update" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_update" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_pgrd" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_pgrd" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_pgwr" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_pgwr" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_bwrite" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_bwrite" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_pagein" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_pagein" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_pageout" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_pageout" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_devblocksize" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_devblocksize" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_searchfs" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_searchfs" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_copyfile" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_copyfile" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_blktooff" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_blktooff" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_offtoblk" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_offtoblk" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_nop_cmap" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

(deftrap-inline "_err_cmap" 
   ((ap (:pointer :struct))
   )
   :signed-long
() )

; #endif	/* _VFS_VFS_SUPPORT_H_ */


(provide-interface "vfs_support")