(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:TypeSelect.h"
; at Sunday July 2,2006 7:25:06 pm.
; 
;      File:       HIToolbox/TypeSelect.h
;  
;      Contains:   TypeSelect Utilties
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __TYPESELECT__
; #define __TYPESELECT__
; #ifndef __EVENTS__
#| #|
#include <HIToolboxEvents.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #pragma options align=mac68k

(def-mactype :TSCode (find-mactype ':SInt16))

(defconstant $tsPreviousSelectMode -1)
(defconstant $tsNormalSelectMode 0)
(defconstant $tsNextSelectMode 1)
(defrecord TypeSelectRecord
   (tsrLastKeyTime :UInt32)
   (tsrScript :SInt16)
   (tsrKeyStrokes (:string 63))
)

;type name? (%define-record :TypeSelectRecord (find-record-descriptor ':TypeSelectRecord))

(def-mactype :IndexToStringProcPtr (find-mactype ':pointer)); (short item , ScriptCode * itemsScript , StringPtr * itemsStringPtr , void * yourDataPtr)

(def-mactype :IndexToStringUPP (find-mactype '(:pointer :OpaqueIndexToStringProcPtr)))
; 
;  *  TypeSelectClear()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TypeSelectClear" 
   ((tsr (:pointer :TypeSelectRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;         Long ago the implementation of TypeSelectNewKey had a bug that
;         required the high word of D0 to be zero or the function did not work.
;         Although fixed now, we are continuing to clear the high word
;         just in case someone tries to run on an older system.
;     
; 
;  *  TypeSelectNewKey()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TypeSelectNewKey" 
   ((theEvent (:pointer :EventRecord))
    (tsr (:pointer :TypeSelectRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  TypeSelectFindItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TypeSelectFindItem" 
   ((tsr (:pointer :TypeSelectRecord))
    (listSize :SInt16)
    (selectMode :SInt16)
    (getStringProc (:pointer :OpaqueIndexToStringProcPtr))
    (yourDataPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  TypeSelectCompare()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TypeSelectCompare" 
   ((tsr (:pointer :TypeSelectRecord))
    (testStringScript :SInt16)
    (testStringPtr (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  NewIndexToStringUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewIndexToStringUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueIndexToStringProcPtr)
() )
; 
;  *  DisposeIndexToStringUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeIndexToStringUPP" 
   ((userUPP (:pointer :OpaqueIndexToStringProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeIndexToStringUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeIndexToStringUPP" 
   ((item :SInt16)
    (itemsScript (:pointer :SCRIPTCODE))
    (itemsStringPtr (:pointer :StringPtr))
    (yourDataPtr :pointer)
    (userUPP (:pointer :OpaqueIndexToStringProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __TYPESELECT__ */


(provide-interface "TypeSelect")