(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:wintypes.h"
; at Sunday July 2,2006 7:32:18 pm.
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
; *****************************************************************
; 
; 	MUSCLE SmartCard Development ( http://www.linuxnet.com )
; 	    Title  : wintypes.h
; 	    Package: pcsc lite
;             Author : David Corcoran
;             Date   : 7/27/99
; 	    License: Copyright (C) 1999 David Corcoran
; 	             <corcoran@linuxnet.com>
;             Purpose: This keeps a list of Windows(R) types.
; 	            
; *******************************************************************
; #ifndef __wintypes_h__
; #define __wintypes_h__
; #ifdef __cplusplus
#| #|
extern "C"
{
#endif
|#
 |#
; #ifndef BYTE

;type name? (def-mactype :BYTE (find-mactype ':UInt8))

; #endif


(def-mactype :UCHAR (find-mactype ':UInt8))

(def-mactype :PUCHAR (find-mactype '(:pointer :UInt8)))

(def-mactype :USHORT (find-mactype ':UInt16))
; #ifndef __COREFOUNDATION_CFPLUGINCOM__
#| #|
	typedef unsigned long ULONG;
	typedef void *LPVOID;
	typedef short BOOL;
#endif
|#
 |#

(def-mactype :PULONG (find-mactype '(:pointer :UInt32)))

(def-mactype :LPCVOID (find-mactype '(:pointer :void)))

(def-mactype :DWORD (find-mactype ':UInt32))

(def-mactype :PDWORD (find-mactype '(:pointer :UInt32)))

;type name? (def-mactype :WORD (find-mactype ':UInt16))
;  H. Bragstad Schlumberger 

;type name? (def-mactype :LONG (find-mactype ':signed-long))

(def-mactype :RESPONSECODE (find-mactype ':signed-long))

(def-mactype :LPCSTR (find-mactype '(:pointer :character)))

(def-mactype :LPCBYTE (find-mactype '(:pointer :unsigned-byte)))

(def-mactype :LPBYTE (find-mactype '(:pointer :unsigned-byte)))

(def-mactype :LPDWORD (find-mactype '(:pointer :UInt32)))

(def-mactype :LPSTR (find-mactype '(:pointer :character)))

(def-mactype :LPTSTR (find-mactype '(:pointer :character)))

(def-mactype :LPCWSTR (find-mactype '(:pointer :character)))
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif


(provide-interface "wintypes")