(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:cs_types.h"
; at Sunday July 2,2006 7:27:26 pm.
; 
;  * cs_types.h 1.18 2000/06/12 21:55:40
;  *
;  * The contents of this file are subject to the Mozilla Public License
;  * Version 1.1 (the "License"); you may not use this file except in
;  * compliance with the License. You may obtain a copy of the License
;  * at http://www.mozilla.org/MPL/
;  *
;  * Software distributed under the License is distributed on an "AS IS"
;  * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
;  * the License for the specific language governing rights and
;  * limitations under the License. 
;  *
;  * The initial developer of the original code is David A. Hinds
;  * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
;  * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
;  *
;  * Contributor:  Apple Computer, Inc.  Portions © 2003 Apple Computer, 
;  * Inc. All rights reserved.
;  *
;  * Alternatively, the contents of this file may be used under the
;  * terms of the GNU Public License version 2 (the "GPL"), in which
;  * case the provisions of the GPL are applicable instead of the
;  * above.  If you wish to allow the use of your version of this file
;  * only under the terms of the GPL and not to allow others to use
;  * your version of this file under the MPL, indicate your decision by
;  * deleting the provisions above and replace them with the notice and
;  * other provisions required by the GPL.  If you do not delete the
;  * provisions above, a recipient may use your version of this file
;  * under either the MPL or the GPL.
;  
; #ifndef _LINUX_CS_TYPES_H
; #define _LINUX_CS_TYPES_H
; #ifdef __linux__
#| #|
#ifdef__KERNEL__
#include <linuxtypes.h>
#else#include <systypes.h>
#endif#endif
|#
 |#

(def-mactype :socket_t (find-mactype ':UInt16))

(def-mactype :ioaddr_t (find-mactype ':UInt16))
; #ifdef __MACOSX__

(def-mactype :cs_event_t (find-mactype ':UInt32))
#| 
; #else

(def-mactype :event_t (find-mactype ':UInt32))
 |#

; #endif


(def-mactype :cisdata_t (find-mactype ':UInt8))

(def-mactype :page_t (find-mactype ':UInt16))

(def-mactype :client_handle_t (find-mactype '(:pointer :client_t)))

(def-mactype :window_handle_t (find-mactype '(:pointer :window_t)))

(def-mactype :memory_handle_t (find-mactype '(:pointer :region_t)))

(def-mactype :eraseq_handle_t (find-mactype '(:pointer :eraseq_t)))
; #ifndef DEV_NAME_LEN
(defconstant $DEV_NAME_LEN 32)
; #define DEV_NAME_LEN 32

; #endif

(defrecord dev_info_t
   (contents (:array :character 32))
)
; #endif /* _LINUX_CS_TYPES_H */


(provide-interface "cs_types")