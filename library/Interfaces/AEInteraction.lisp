(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AEInteraction.h"
; at Sunday July 2,2006 7:25:01 pm.
; 
;      File:       HIToolbox/AEInteraction.h
;  
;      Contains:   AppleEvent functions that deal with Events and interacting with user
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
; #ifndef __AEINTERACTION__
; #define __AEINTERACTION__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __NOTIFICATION__
#| #|
#include <HIToolboxNotification.h>
#endif
|#
 |#
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
; *************************************************************************
;   AppleEvent callbacks. 
; *************************************************************************

(def-mactype :AEIdleProcPtr (find-mactype ':pointer)); (EventRecord * theEvent , long * sleepTime , RgnHandle * mouseRgn)

(def-mactype :AEFilterProcPtr (find-mactype ':pointer)); (EventRecord * theEvent , long returnID , long transactionID , const AEAddressDesc * sender)

(def-mactype :AEIdleUPP (find-mactype '(:pointer :OpaqueAEIdleProcPtr)))

(def-mactype :AEFilterUPP (find-mactype '(:pointer :OpaqueAEFilterProcPtr)))
; *************************************************************************
;   The next couple of calls are basic routines used to create, send,
;   and process AppleEvents. 
; *************************************************************************
; 
;  *  AESend()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AESend" 
   ((theAppleEvent (:pointer :AppleEvent))
    (reply (:pointer :AppleEvent))
    (sendMode :SInt32)
    (sendPriority :SInt16)
    (timeOutInTicks :signed-long)
    (idleProc (:pointer :OpaqueAEIdleProcPtr))  ;  can be NULL 
    (filterProc (:pointer :OpaqueAEFilterProcPtr));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEProcessAppleEvent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEProcessAppleEvent" 
   ((theEventRecord (:pointer :EventRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  
;  Note: during event processing, an event handler may realize that it is likely
;  to exceed the client's timeout limit. Passing the reply to this
;  routine causes a wait event to be generated that asks the client
;  for more time. 
; 
; 
;  *  AEResetTimer()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEResetTimer" 
   ((reply (:pointer :AppleEvent))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *************************************************************************
;   The following three calls are used to allow applications to behave
;   courteously when a user interaction such as a dialog box is needed. 
; *************************************************************************

(def-mactype :AEInteractAllowed (find-mactype ':SInt8))

(defconstant $kAEInteractWithSelf 0)
(defconstant $kAEInteractWithLocal 1)
(defconstant $kAEInteractWithAll 2)
; 
;  *  AEGetInteractionAllowed()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEGetInteractionAllowed" 
   ((level (:pointer :AEINTERACTALLOWED))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AESetInteractionAllowed()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AESetInteractionAllowed" 
   ((level :SInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEInteractWithUser()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEInteractWithUser" 
   ((timeOutInTicks :signed-long)
    (nmReqPtr (:pointer :NMREC))
    (idleProc (:pointer :OpaqueAEIdleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *************************************************************************
;  The following four calls are available for applications which need more
;  sophisticated control over when and how events are processed. Applications
;  which implement multi-session servers or which implement their own
;  internal event queueing will probably be the major clients of these
;  routines. They can be called from within a handler to prevent the AEM from
;  disposing of the AppleEvent when the handler returns. They can be used to
;  asynchronously process the event (as MacApp does).
; *************************************************************************
; 
;  *  AESuspendTheCurrentEvent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AESuspendTheCurrentEvent" 
   ((theAppleEvent (:pointer :AppleEvent))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  
;  Note: The following routine tells the AppleEvent manager that processing
;  is either about to resume or has been completed on a previously suspended
;  event. The procPtr passed in as the dispatcher parameter will be called to
;  attempt to redispatch the event. Several constants for the dispatcher
;  parameter allow special behavior. They are:
;     - kAEUseStandardDispatch means redispatch as if the event was just
;       received, using the standard AppleEvent dispatch mechanism.
;     - kAENoDispatch means ignore the parameter.
;       Use this in the case where the event has been handled and no
;       redispatch is needed.
;     - non nil means call the routine which the dispatcher points to.
; 
;  Constants for Refcon in AEResumeTheCurrentEvent with kAEUseStandardDispatch 

(defconstant $kAEDoNotIgnoreHandler 0)
(defconstant $kAEIgnoreAppPhacHandler 1)        ;  available only in vers 1.0.1 and greater 

(defconstant $kAEIgnoreAppEventHandler 2)       ;  available only in vers 1.0.1 and greater 

(defconstant $kAEIgnoreSysPhacHandler 4)        ;  available only in vers 1.0.1 and greater 

(defconstant $kAEIgnoreSysEventHandler 8)       ;  available only in vers 1.0.1 and greater 

(defconstant $kAEIngoreBuiltInEventHandler 16)  ;  available only in vers 1.0.1 and greater 
;  available only in vers 1.0.1 and greater 

(defconstant $kAEDontDisposeOnResume #x80000000)
;  Constants for AEResumeTheCurrentEvent 

(defconstant $kAENoDispatch 0)                  ;  dispatch parameter to AEResumeTheCurrentEvent takes a pointer to a dispatch 
;  table, or one of these two constants 

(defconstant $kAEUseStandardDispatch #xFFFFFFFF)
; 
;  *  AEResumeTheCurrentEvent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEResumeTheCurrentEvent" 
   ((theAppleEvent (:pointer :AppleEvent))
    (reply (:pointer :AppleEvent))
    (dispatcher (:pointer :OpaqueAEEventHandlerProcPtr));  can be NULL 
    (handlerRefcon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEGetTheCurrentEvent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AEGetTheCurrentEvent" 
   ((theAppleEvent (:pointer :AppleEvent))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AESetTheCurrentEvent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AESetTheCurrentEvent" 
   ((theAppleEvent (:pointer :AppleEvent))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *************************************************************************
;   AppleEvent callbacks. 
; *************************************************************************
; 
;  *  NewAEIdleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewAEIdleUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueAEIdleProcPtr)
() )
; 
;  *  NewAEFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewAEFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueAEFilterProcPtr)
() )
; 
;  *  DisposeAEIdleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeAEIdleUPP" 
   ((userUPP (:pointer :OpaqueAEIdleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeAEFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeAEFilterUPP" 
   ((userUPP (:pointer :OpaqueAEFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeAEIdleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeAEIdleUPP" 
   ((theEvent (:pointer :EventRecord))
    (sleepTime (:pointer :long))
    (mouseRgn (:pointer :RGNHANDLE))
    (userUPP (:pointer :OpaqueAEIdleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeAEFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeAEFilterUPP" 
   ((theEvent (:pointer :EventRecord))
    (returnID :signed-long)
    (transactionID :signed-long)
    (sender (:pointer :AEADDRESSDESC))
    (userUPP (:pointer :OpaqueAEFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __AEINTERACTION__ */


(provide-interface "AEInteraction")