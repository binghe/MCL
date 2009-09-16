(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:UTCUtils.h"
; at Sunday July 2,2006 7:23:09 pm.
; 
;      File:       CarbonCore/UTCUtils.h
;  
;      Contains:   Interface for UTC to Local Time conversion and 64 Bit Clock routines
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __UTCUTILS__
; #define __UTCUTILS__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __MACERRORS__

(require-interface "CarbonCore/MacErrors")

; #endif


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
;  Options for Set & Get DateTime Routines 

(defconstant $kUTCDefaultOptions 0)
;  64 Bit Clock Typedefs 
(defrecord UTCDateTime
   (highSeconds :UInt16)
   (lowSeconds :UInt32)
   (fraction :UInt16)
)

;type name? (%define-record :UTCDateTime (find-record-descriptor ':UTCDateTime))

(def-mactype :UTCDateTimePtr (find-mactype '(:pointer :UTCDateTime)))

(def-mactype :UTCDateTimeHandle (find-mactype '(:handle :UTCDateTime)))
(defrecord LocalDateTime
   (highSeconds :UInt16)
   (lowSeconds :UInt32)
   (fraction :UInt16)
)

;type name? (%define-record :LocalDateTime (find-record-descriptor ':LocalDateTime))

(def-mactype :LocalDateTimePtr (find-mactype '(:pointer :LocalDateTime)))

(def-mactype :LocalDateTimeHandle (find-mactype '(:handle :LocalDateTime)))
;  Classic 32 bit clock conversion routines 
; 
;  *  ConvertLocalTimeToUTC()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in UTCUtils 1.0 and later
;  

(deftrap-inline "_ConvertLocalTimeToUTC" 
   ((localSeconds :UInt32)
    (utcSeconds (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ConvertUTCToLocalTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in UTCUtils 1.0 and later
;  

(deftrap-inline "_ConvertUTCToLocalTime" 
   ((utcSeconds :UInt32)
    (localSeconds (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  64 bit clock conversion routines 
; 
;  *  ConvertUTCToLocalDateTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in UTCUtils 1.0 and later
;  

(deftrap-inline "_ConvertUTCToLocalDateTime" 
   ((utcDateTime (:pointer :UTCDateTime))
    (localDateTime (:pointer :LocalDateTime))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ConvertLocalToUTCDateTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in UTCUtils 1.0 and later
;  

(deftrap-inline "_ConvertLocalToUTCDateTime" 
   ((localDateTime (:pointer :LocalDateTime))
    (utcDateTime (:pointer :UTCDateTime))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Getter and Setter Clock routines using 64 Bit values 
; 
;  *  GetUTCDateTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in UTCUtils 1.0 and later
;  

(deftrap-inline "_GetUTCDateTime" 
   ((utcDateTime (:pointer :UTCDateTime))
    (options :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetUTCDateTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in UTCUtils 1.0 and later
;  

(deftrap-inline "_SetUTCDateTime" 
   ((utcDateTime (:pointer :UTCDateTime))
    (options :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetLocalDateTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in UTCUtils 1.0 and later
;  

(deftrap-inline "_GetLocalDateTime" 
   ((localDateTime (:pointer :LocalDateTime))
    (options :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetLocalDateTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in UTCUtils 1.0 and later
;  

(deftrap-inline "_SetLocalDateTime" 
   ((localDateTime (:pointer :LocalDateTime))
    (options :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __UTCUTILS__ */


(provide-interface "UTCUtils")