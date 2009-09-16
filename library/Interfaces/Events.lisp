(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Events.h"
; at Sunday July 2,2006 7:24:48 pm.
; 
;      File:       HIToolbox/Events.h
;  
;      Contains:   Event Manager Interfaces.
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __EVENTS__
; #define __EVENTS__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
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

(def-mactype :EventKind (find-mactype ':UInt16))

(def-mactype :EventMask (find-mactype ':UInt16))

(defconstant $nullEvent 0)
(defconstant $mouseDown 1)
(defconstant $mouseUp 2)
(defconstant $keyDown 3)
(defconstant $keyUp 4)
(defconstant $autoKey 5)
(defconstant $updateEvt 6)
(defconstant $diskEvt 7)                        ;  Not sent in Carbon. See kEventClassVolume in CarbonEvents.h

(defconstant $activateEvt 8)
(defconstant $osEvt 15)
(defconstant $kHighLevelEvent 23)

(defconstant $mDownMask 2)                      ;  mouse button pressed

(defconstant $mUpMask 4)                        ;  mouse button released

(defconstant $keyDownMask 8)                    ;  key pressed

(defconstant $keyUpMask 16)                     ;  key released

(defconstant $autoKeyMask 32)                   ;  key repeatedly held down

(defconstant $updateMask 64)                    ;  window needs updating

(defconstant $diskMask #x80)                    ;  disk inserted

(defconstant $activMask #x100)                  ;  activate/deactivate window

(defconstant $highLevelEventMask #x400)         ;  high-level events (includes AppleEvents)

(defconstant $osMask #x8000)                    ;  operating system events (suspend, resume)

(defconstant $everyEvent #xFFFF)                ;  all of the above


(defconstant $charCodeMask #xFF)
(defconstant $keyCodeMask #xFF00)
(defconstant $adbAddrMask #xFF0000)
(defconstant $osEvtMessageMask #xFF000000)
;  OS event messages.  Event (sub)code is in the high byte of the message field.

(defconstant $mouseMovedMessage #xFA)
(defconstant $suspendResumeMessage 1)

(defconstant $resumeFlag 1)                     ;  Bit 0 of message indicates resume vs suspend


; #if CALL_NOT_IN_CARBON
#|                                              ;   convertClipboardFlag is not ever set under Carbon. This is because scrap conversion is  
;   not tied to suspend/resume events any longer. Your application should instead use the   
;   scrap promise mechanism and fulfill scrap requests only when your promise keeper proc   
;   is called. If you need to know if the scrap has changed, you can cache the last         
;   ScrapRef you received and compare it with the current ScrapRef                          

(defconstant $convertClipboardFlag 2)           ;  Bit 1 in resume message indicates clipboard change

 |#

; #endif  /* CALL_NOT_IN_CARBON */

; 
;     CARBON ALERT! BATTLESTATIONS!
;     
;     The EventModifiers bits defined here are also used in the newer Carbon Event
;     key modifiers parameters. There are two main differences:
;     
;     1)  The Carbon key modifiers parameter is a UInt32, not a UInt16. Never try to
;         extract the key modifiers parameter from a Carbon Event into an EventModifiers
;         type. You will probably get your stack trashed.
;     2)  The Carbon key modifiers is just that: key modifiers. That parameter will
;         never contain the button state bit.
; 

(def-mactype :EventModifiers (find-mactype ':UInt16))
;  modifiers 

(defconstant $activeFlagBit 0)                  ;  activate? (activateEvt and mouseDown)

(defconstant $btnStateBit 7)                    ;  state of button?

(defconstant $cmdKeyBit 8)                      ;  command key down?

(defconstant $shiftKeyBit 9)                    ;  shift key down?

(defconstant $alphaLockBit 10)                  ;  alpha lock down?

(defconstant $optionKeyBit 11)                  ;  option key down?

(defconstant $controlKeyBit 12)                 ;  control key down?

(defconstant $rightShiftKeyBit 13)              ;  right shift key down?

(defconstant $rightOptionKeyBit 14)             ;  right Option key down?

(defconstant $rightControlKeyBit 15)            ;  right Control key down?


(defconstant $activeFlag 1)
(defconstant $btnState #x80)
(defconstant $cmdKey #x100)
(defconstant $shiftKey #x200)
(defconstant $alphaLock #x400)
(defconstant $optionKey #x800)
(defconstant $controlKey #x1000)
(defconstant $rightShiftKey #x2000)
(defconstant $rightOptionKey #x4000)
(defconstant $rightControlKey #x8000)
;  MacRoman character codes

(defconstant $kNullCharCode 0)
(defconstant $kHomeCharCode 1)
(defconstant $kEnterCharCode 3)
(defconstant $kEndCharCode 4)
(defconstant $kHelpCharCode 5)
(defconstant $kBellCharCode 7)
(defconstant $kBackspaceCharCode 8)
(defconstant $kTabCharCode 9)
(defconstant $kLineFeedCharCode 10)
(defconstant $kVerticalTabCharCode 11)
(defconstant $kPageUpCharCode 11)
(defconstant $kFormFeedCharCode 12)
(defconstant $kPageDownCharCode 12)
(defconstant $kReturnCharCode 13)
(defconstant $kFunctionKeyCharCode 16)
(defconstant $kCommandCharCode 17)              ;  glyph available only in system fonts

(defconstant $kCheckCharCode 18)                ;  glyph available only in system fonts

(defconstant $kDiamondCharCode 19)              ;  glyph available only in system fonts

(defconstant $kAppleLogoCharCode 20)            ;  glyph available only in system fonts

(defconstant $kEscapeCharCode 27)
(defconstant $kClearCharCode 27)
(defconstant $kLeftArrowCharCode 28)
(defconstant $kRightArrowCharCode 29)
(defconstant $kUpArrowCharCode 30)
(defconstant $kDownArrowCharCode 31)
(defconstant $kSpaceCharCode 32)
(defconstant $kDeleteCharCode 127)
(defconstant $kBulletCharCode #xA5)
(defconstant $kNonBreakingSpaceCharCode #xCA)
;  useful Unicode code points

(defconstant $kShiftUnicode #x21E7)             ;  Unicode UPWARDS WHITE ARROW

(defconstant $kControlUnicode #x2303)           ;  Unicode UP ARROWHEAD

(defconstant $kOptionUnicode #x2325)            ;  Unicode OPTION KEY

(defconstant $kCommandUnicode #x2318)           ;  Unicode PLACE OF INTEREST SIGN

(defconstant $kPencilUnicode #x270E)            ;  Unicode LOWER RIGHT PENCIL; actually pointed left until Mac OS X 10.3

(defconstant $kPencilLeftUnicode #xF802)        ;  Unicode LOWER LEFT PENCIL; available in Mac OS X 10.3 and later

(defconstant $kCheckUnicode #x2713)             ;  Unicode CHECK MARK

(defconstant $kDiamondUnicode #x25C6)           ;  Unicode BLACK DIAMOND

(defconstant $kBulletUnicode #x2022)            ;  Unicode BULLET

(defconstant $kAppleLogoUnicode #xF8FF)         ;  Unicode APPLE LOGO

(defrecord EventRecord
   (what :UInt16)
   (message :UInt32)
   (when :UInt32)
   (where :Point)
   (modifiers :UInt16)
)

;type name? (%define-record :EventRecord (find-record-descriptor ':EventRecord))

(def-mactype :FKEYProcPtr (find-mactype ':pointer)); (void)

(def-mactype :FKEYUPP (find-mactype '(:pointer :OpaqueFKEYProcPtr)))
; 
;  *  NewFKEYUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeFKEYUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeFKEYUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  GetMouse()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetMouse" 
   ((mouseLoc (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  Button()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Button" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  StillDown()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StillDown" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  WaitMouseUp()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_WaitMouseUp" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  KeyTranslate()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_KeyTranslate" 
   ((transData :pointer)
    (keycode :UInt16)
    (state (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetCaretTime()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetCaretTime" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  
;     QuickTime 3.0 supports GetKeys() on unix and win32
;     But, on little endian machines you will have to be
;     careful about bit numberings and/or use a KeyMapByteArray
;     instead.
; 

; #if TARGET_API_MAC_OS8
#| 
(defrecord KeyMap
   (contents (:array :UInt32 4))
)
 |#

; #else
(defrecord KeyMap
   (contents (:array :signed-long 4))
)
; #endif  /* TARGET_API_MAC_OS8 */

(defrecord KeyMapByteArray
   (contents (:array :UInt8 16))
)
; 
;  *  GetKeys()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetKeys" 
   ((theKeys (:pointer :KEYMAP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  Obsolete event types & masks 

(defconstant $networkEvt 10)
(defconstant $driverEvt 11)
(defconstant $app1Evt 12)
(defconstant $app2Evt 13)
(defconstant $app3Evt 14)
(defconstant $app4Evt 15)
(defconstant $networkMask #x400)
(defconstant $driverMask #x800)
(defconstant $app1Mask #x1000)
(defconstant $app2Mask #x2000)
(defconstant $app3Mask #x4000)
(defconstant $app4Mask #x8000)
(defrecord EvQEl
   (qLink (:pointer :QElem))
   (qType :SInt16)
   (evtQWhat :UInt16)                           ;  this part is identical to the EventRecord as defined above 
   (evtQMessage :UInt32)
   (evtQWhen :UInt32)
   (evtQWhere :Point)
   (evtQModifiers :UInt16)
)

;type name? (%define-record :EvQEl (find-record-descriptor ':EvQEl))

(def-mactype :EvQElPtr (find-mactype '(:pointer :EvQEl)))

(def-mactype :GetNextEventFilterProcPtr (find-mactype ':pointer)); (EventRecord * theEvent , Boolean * result)

(def-mactype :GetNextEventFilterUPP (find-mactype '(:pointer :OpaqueGetNextEventFilterProcPtr)))
; 
;  *  NewGetNextEventFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeGetNextEventFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeGetNextEventFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  

(def-mactype :GNEFilterUPP (find-mactype ':GetNextEventFilterUPP))
; 
;  *  GetDblTime()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetDblTime" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  SetEventMask()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetEventMask" 
   ((value :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetEvQHdr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PPostEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  GetNextEvent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetNextEvent" 
   ((eventMask :UInt16)
    (theEvent (:pointer :EventRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  WaitNextEvent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_WaitNextEvent" 
   ((eventMask :UInt16)
    (theEvent (:pointer :EventRecord))
    (sleep :UInt32)
    (mouseRgn (:pointer :OpaqueRgnHandle))      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  EventAvail()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_EventAvail" 
   ((eventMask :UInt16)
    (theEvent (:pointer :EventRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  PostEvent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PostEvent" 
   ((eventNum :UInt16)
    (eventMsg :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;     For Carbon, use EventAvail, TickCount, GetGlobalMouse,
;     GetKeys, or GetCurrentKeyModifiers instead of
;     OSEventAvail, and use GetNextEvent or WaitNextEvent
;     instead of GetOSEvent.
; 
; 
;  *  OSEventAvail()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  GetOSEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  FlushEvents()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FlushEvents" 
   ((whichMask :UInt16)
    (stopMask :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SystemClick()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SystemTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SystemEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if OLDROUTINENAMES
#| 
; #define KeyTrans(transData, keycode, state) KeyTranslate(transData, keycode, state)
 |#

; #endif  /* OLDROUTINENAMES */

; 
;     GetGlobalMouse, GetCurrentKeyModifiers, and CheckEventQueueForUserCancel
;     are only available as part of the Carbon API.
; 
; 
;  *  GetGlobalMouse()
;  *  
;  *  Summary:
;  *    Returns the position of the mouse in global coordinates.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    globalMouse:
;  *      On exit, contains the mouse position in global coordinates.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetGlobalMouse" 
   ((globalMouse (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetCurrentKeyModifiers()
;  *  
;  *  Summary:
;  *    Returns the current hardware keyboard modifier state.
;  *  
;  *  Discussion:
;  *    In most cases, you should not use GetCurrentKeyModifiers, but
;  *    should use the GetCurrentEventKeyModifiers function instead.
;  *    GetCurrentEventKeyModifiers is much faster than
;  *    GetCurrentKeyModifiers because it returns the locally cached
;  *    modifier state; GetCurrentKeyModifiers must get the modifier
;  *    state from the window server, which is slower. Using
;  *    GetCurrentKeyModifiers also can prevent your application from
;  *    being operated by remote posting of events, since the hardware
;  *    input device is not actually changing state in that case. Most
;  *    commonly, you might need to use GetCurrentKeyModifiers when your
;  *    application is not the active application (as determined by the
;  *    Process Manager function GetFrontProcess). In that case, the
;  *    cached modifier state returned by GetCurrentEventKeyModifiers is
;  *    not valid because modifier-changed events are not flowing to your
;  *    application, and you must use GetCurrentKeyModifiers to determine
;  *    the current hardware state.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Result:
;  *    The hardware state of the keyboard modifiers. The format of the
;  *    return value is the same as the modifiers field of an EventRecord
;  *    (but only includes keyboard modifiers and not the other modifier
;  *    flags included in an EventRecord).
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetCurrentKeyModifiers" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  CheckEventQueueForUserCancel()
;  *  
;  *  Summary:
;  *    Determines if there is a cancel event in the main thread's event
;  *    queue.
;  *  
;  *  Discussion:
;  *    This API supports two cancel events: Escape and Cmd-Period. The
;  *    cancel event itself, as well as mouse or keyboard events in front
;  *    of the cancel event in the event queue, will be removed from the
;  *    queue.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CheckEventQueueForUserCancel" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  KeyScript()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_KeyScript" 
   ((code :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  IsCmdChar()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_IsCmdChar" 
   ((event (:pointer :EventRecord))
    (test :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  
;     LowMem accessor functions previously in LowMem.h
; 
; 
;  *  LMGetKeyThresh()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetKeyThresh" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  LMSetKeyThresh()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetKeyThresh" 
   ((value :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetKeyRepThresh()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetKeyRepThresh" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  LMSetKeyRepThresh()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetKeyRepThresh" 
   ((value :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetKbdLast()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetKbdLast" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt8
() )
; 
;  *  LMSetKbdLast()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetKbdLast" 
   ((value :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetKbdType()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetKbdType" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt8
() )
; 
;  *  LMSetKbdType()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetKbdType" 
   ((value :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __EVENTS__ */


(provide-interface "Events")