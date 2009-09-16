(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:loadable_fs.h"
; at Sunday July 2,2006 7:30:18 pm.
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
; 	@(#)loadable_fs.h	2.0	26/06/90	(c) 1990 NeXT	
;  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
;  *
;  * W I L L    D R A S T I C A L L Y   C H A N G E   S O O N 
;  * U S E   A T  Y O U R   O W N  R I S K
;  *
;  * XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 
;  
;  * loadable_fs.h - message struct for loading and initializing loadable
;  *		   file systems.
;  
; #ifndef	_SYS_LOADABLE_FS_
; #define _SYS_LOADABLE_FS_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_UNSTABLE
#| #|

#define FS_DIR_LOCATION		"SystemLibraryFilesystems"
#define FS_DIR_SUFFIX		".fs"
#define FS_UTIL_SUFFIX		".util"
#define FS_OPEN_SUFFIX		".openfs.tiff"
#define FS_CLOSED_SUFFIX	".fs.tiff"
#define FS_NAME_SUFFIX		".name"
#define FS_LABEL_SUFFIX		".label"


#define FSUC_PROBE		'p'	
	 

#define FSUC_PROBEFORINIT	'P'	
	 

#define FSUC_MOUNT		'm'	
	 

#define FSUC_REPAIR		'r'	 
	

#define FSUC_INITIALIZE		'i'	
	 

#define FSUC_UNMOUNT		'u'	
	 


#define FSUC_MOUNT_FORCE	'M'	

#define FSUR_RECOGNIZED		(-1)	
#define FSUR_UNRECOGNIZED	(-2)	
#define FSUR_IO_SUCCESS		(-3)	
#define FSUR_IO_FAIL		(-4)	
#define FSUR_IO_UNCLEAN		(-5)	
#define FSUR_INVAL		(-6)	
#define FSUR_LOADERR		(-7)	
#define FSUR_INITRECOGNIZED	(-8)	


#define DEVICE_READONLY		"readonly"
#define DEVICE_WRITABLE		"writable"

#define DEVICE_REMOVABLE	"removable"
#define DEVICE_FIXED		"fixed"


#define MNTOPT_FS		"filesystem=" 
#define MNTOPT_REMOVABLE	"removable"

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif	/* _SYS_LOADABLE_FS_ */


(provide-interface "loadable_fs")