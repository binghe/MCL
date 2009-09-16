(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOFWUtils.h"
; at Sunday July 2,2006 7:29:13 pm.
; 
;  *  IOFWUtils.h
;  *  IOFireWireFamily
;  *
;  *  Created by Niels on Fri Aug 16 2002.
;  *  Copyright (c) 2002 Apple Computer, Inc. All rights reserved.
;  *
;  

; #import <IOKit/IOTypes.h>
; //////////////////////////////////////////////////////////////////////////////
; 
;  Useful FireWire utility functions.
; 
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(deftrap-inline "_FWComputeCRC16" 
   ((pQuads (:pointer :UInt32))
    (numQuads :UInt32)
   )
   :UInt16
() )

(deftrap-inline "_FWUpdateCRC16" 
   ((crc16 :UInt16)
    (quad :UInt32)
   )
   :UInt16
() )

(deftrap-inline "_AddFWCycleTimeToFWCycleTime" 
   ((cycleTime1 :UInt32)
    (cycleTime2 :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_SubtractFWCycleTimeFromFWCycleTime" 
   ((cycleTime1 :UInt32)
    (cycleTime2 :UInt32)
   )
   :UInt32
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

(provide-interface "IOFWUtils")