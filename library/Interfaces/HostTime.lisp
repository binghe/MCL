(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:HostTime.h"
; at Sunday July 2,2006 7:26:55 pm.
; 
;      File:       CoreAudio/HostTime.h
; 
;      Contains:   Routines for accessing the host's time base
; 
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
; 
;      Copyright:  (c) 1985-2003 by Apple Computer, Inc., all rights reserved.
; 
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
; 
;                      http://developer.apple.com/bugreporter/
; 
; 

; #if !defined(__HostTime_h__)
; #define __HostTime_h__
; =============================================================================
; 	Includes
; =============================================================================

(require-interface "CoreAudio/CoreAudioTypes")

; #if PRAGMA_ENUM_ALWAYSINT
#| ; #pragma enumsalwaysint off
 |#

; #endif


; #if defined(__cplusplus)
#|
extern "C"
{
#endif
|#
; -----------------------------------------------------------------------------
; 	AudioGetCurrentHostTime
; 
; 	Retrieve the current host time value.
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioGetCurrentHostTime" 
   ((ARG2 (:nil :nil))
   )
   :UInt64
() )
; -----------------------------------------------------------------------------
; 	AudioGetHostClockFrequency
; 
; 	Retrieve the number of ticks per second of the host clock.
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioGetHostClockFrequency" 
   ((ARG2 (:nil :nil))
   )
   :double-float
() )
; -----------------------------------------------------------------------------
; 	AudioGetHostClockMinimumTimeDelta
; 
; 	Retrieve the smallest number of ticks difference between two succeeding
; 	values of the host clock. For instance, if this value is 5 and
; 	the first value of the host clock is X then the next time after X
; 	will be at greater than or equal X+5.
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioGetHostClockMinimumTimeDelta" 
   ((ARG2 (:nil :nil))
   )
   :UInt32
() )
; -----------------------------------------------------------------------------
; 	AudioConvertHostTimeToNanos
; 
; 	Convert the given host time to a time in Nanoseconds.
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioConvertHostTimeToNanos" 
   ((inHostTime :UInt64)
   )
   :UInt64
() )
; -----------------------------------------------------------------------------
; 	AudioConvertNanosToHostTime
; 
; 	Convert the given Nanoseconds time to a time in the host clock's
; 	time base.
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioConvertNanosToHostTime" 
   ((inNanos :UInt64)
   )
   :UInt64
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #if PRAGMA_ENUM_ALWAYSINT
#| ; #pragma enumsalwaysint reset
 |#

; #endif


; #endif


(provide-interface "HostTime")