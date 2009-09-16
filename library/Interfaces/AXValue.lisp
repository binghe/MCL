(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AXValue.h"
; at Sunday July 2,2006 7:24:41 pm.
; 
;  *  AXValue.h
;  *  Accessibility
;  *
;  *  Copyright (c) 2002 Apple Computer, Inc. All rights reserved.
;  *
;  
; #ifndef __AXVALUE__
; #define __AXVALUE__

(require-interface "AvailabilityMacros")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(require-interface "CoreServices/CoreServices")

(require-interface "CoreFoundation/CoreFoundation")
;  Types from CoreGraphics.h 

(defconstant $kAXValueCGPointType 1)
(defconstant $kAXValueCGSizeType 2)
(defconstant $kAXValueCGRectType 3)             ;  Types from CFBase.h 

(defconstant $kAXValueCFRangeType 4)            ;  Other 

(defconstant $kAXValueIllegalType 0)
(def-mactype :AXValueType (find-mactype ':SINT32))

(def-mactype :AXValueRef (find-mactype '(:pointer :__AXValue)))

(deftrap-inline "_AXValueGetTypeID" 
   ((ARG2 (:nil :nil))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )

(deftrap-inline "_AXValueCreate" 
   ((theType :SInt32)
    (valuePtr :pointer)
   )
   (:pointer :__AXValue)
() )

(deftrap-inline "_AXValueGetType" 
   ((value (:pointer :__AXValue))
   )
   :SInt32
() )

(deftrap-inline "_AXValueGetValue" 
   ((value (:pointer :__AXValue))
    (theType :SInt32)
    (valuePtr :pointer)
   )
   :Boolean
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif // __AXVALUE__


(provide-interface "AXValue")