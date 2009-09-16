(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOADBLib.h"
; at Sunday July 2,2006 7:28:17 pm.
; 
;  * Copyright (c) 1998-2000 Apple Computer, Inc. All rights reserved.
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
(defconstant $kNumADBMethods 4)
; #define kNumADBMethods 4

(defconstant $kADBReadDevice 0)
(defconstant $kADBWriteDevice 1)
(defconstant $kADBClaimDevice 2)
(defconstant $kADBReleaseDevice 3)
; #ifndef KERNEL

(require-interface "IOKit/IOKitLib")

(deftrap-inline "_IOPMFindADBController" 
   ((ARG2 :pointer)
   )
   :pointer
() )

(deftrap-inline "_IOPMClaimADBDevice" 
   ((ARG2 :pointer)
    (long :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_IOPMReleaseADBDevice" 
   ((ARG2 :pointer)
    (long :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_IOPMReadADBDevice" 
   ((ARG2 :pointer)
    (long :UInt32)
    (long :UInt32)
    (* (:pointer :UInt8))
    (* (:pointer :UInt32))
   )
   :signed-long
() )

(deftrap-inline "_IOPMWriteADBDevice" 
   ((ARG2 :pointer)
    (long :UInt32)
    (long :UInt32)
    (* (:pointer :UInt8))
    (long :UInt32)
   )
   :signed-long
() )

; #endif


(provide-interface "IOADBLib")