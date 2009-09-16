(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DirServicesCustom.h"
; at Sunday July 2,2006 7:27:33 pm.
; 
;  * Copyright (c) 2002 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * This file contains Original Code and/or Modifications of Original Code
;  * as defined in and that are subject to the Apple Public Source License
;  * Version 2.0 (the 'License'). You may not use this file except in
;  * compliance with the License. Please obtain a copy of the License at
;  * http://www.opensource.apple.com/apsl/ and read it before using this
;  * file.
;  * 
;  * The Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
;  * Please see the License for the specific language governing rights and
;  * limitations under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; !
;  * @header DirServicesCustom
;  * To be deprecated.
;  
; #ifndef __DirServicesCustom_h__
(defconstant $__DirServicesCustom_h__ 1)
; #define __DirServicesCustom_h__	1

(require-interface "DirServicesTypes")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; -------------------------------------------------------------------------
;  register custom allocate/deallocate routines MacOS 8.x Applications Only

(deftrap-inline "_dsRegisterCustomMemory" 
   ((inDirReference :UInt32)
    (inCustomAllocate :pointer)
    (inCustomDeAllocate :pointer)
    (inClientData (:pointer :void))
   )
   :sint32
() )

(deftrap-inline "_dsGetCustomAllocate" 
   ((inDirReference :UInt32)
    (outCustomAllocate (:pointer :FPCUSTOMALLOCATE))
    (outCustomDeAllocate (:pointer :FPCUSTOMDEALLOCATE))
    (outClientData (:pointer :TCLIENTDATA))
   )
   :sint32
() )

(deftrap-inline "_dsUnRegisterCustomMemory" 
   ((inDirReference :UInt32)
    (inCustomAllocate :pointer)
    (inCustomDeAllocate :pointer)
    (inClientData (:pointer :void))
   )
   :sint32
() )
; ------------------------------------------------------------
;  register custom thread routines MacOS 8.x Applications Only

(deftrap-inline "_dsRegisterCustomThread" 
   ((inDirReference :UInt32)
    (inCustomBlock :pointer)
    (inCustomUnBlock :pointer)
    (inCustomYield :pointer)
    (inClientData (:pointer :void))
   )
   :sint32
() )

(deftrap-inline "_dsGetCustomThread" 
   ((inDirReference :UInt32)
    (outCustomBlock (:pointer :FPCUSTOMTHREADBLOCK))
    (outCustomUnBlock (:pointer :FPCUSTOMTHREADUNBLOCK))
    (outCustomYield (:pointer :FPCUSTOMTHREADYIELD))
    (outClientData (:pointer :TCLIENTDATA))
   )
   :sint32
() )

(deftrap-inline "_dsUnRegisterCustomThread" 
   ((inDirReference :UInt32)
    (inCustomBlock :pointer)
    (inCustomUnBlock :pointer)
    (inCustomYield :pointer)
    (inClientData (:pointer :void))
   )
   :sint32
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif


(provide-interface "DirServicesCustom")