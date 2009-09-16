(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AEMach.h"
; at Sunday July 2,2006 7:24:28 pm.
; 
;      File:       AE/AEMach.h
;  
;      Contains:   AppleEvent over mach_msg interfaces
;  
;      Version:    AppleEvents-275~1
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AEMACH__
; #define __AEMACH__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __AEDATAMODEL__
#| #|
#include <AEAEDataModel.h>
#endif
|#
 |#

; #if TARGET_RT_MAC_MACHO
#| ; #ifdef __cplusplus
#|
extern "C" {
#endif
|#
|#

(require-interface "mach/message")

#|; #ifdef __cplusplus
#|
}
#endif
|#
 |#

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
; -
;  * AE Mach API --
;  *
;  * AppleEvents on OS X are implemented in terms of mach messages.
;  * To facilitate writing server processes that can send and receive
;  * AppleEvents, the following APIs are provided.
;  *
;  * AppleEvents are directed to a well known port uniquely tied to a
;  * process.  The AE framework will discover this port based on the
;  * keyAddressAttr of the event (as specifed in AECreateAppleEvent by
;  * the target parameter.)  If a port cannot be found,
;  * procNotFound (-600) will be returned on AESend.
;  *
;  * Of note is a new attribute for an AppleEvent, keyReplyPortAttr.
;  * This specifies the mach_port_t to which an AppleEvent reply
;  * should be directed.  By default, replies are sent to the
;  * processes' registered port where they are culled from the normal  
;  * event stream if there is an outstanding AESend + kAEWaitReply.
;  * But it may be desirable for a client to specify their own port to
;  * receive queud replies.
;  *
;  * In the case of AESendMessage with kAEWaitReply specified, an 
;  * anonymous port will be used to block until the reply is received.
;  *
;  * Not supplied is a convenience routine to block a server and
;  * process AppleEvents.  This implementation will be detailed in a
;  * tech note.
;  *
;  * In general, the AppleEvent APIs are thread safe, but the mechanism
;  * of their delivery (AEProcessAppleEvent, AEResumeTheCurrentEvent)
;  * are not.  If you're attemping to write a thread safe server, you
;  * should avoid AppleEvent routines that don't explicitly state their
;  * thread safety.
;  *
;  *

(defconstant $keyReplyPortAttr :|repp|)
;  typeReplyPortAttr was misnamed and is deprecated; use keyReplyPortAttr instead. 

(defconstant $typeReplyPortAttr :|repp|)
; -
;  * Return the mach_port_t that was registered by the AppleEvent
;  * framework for this process.  This port is considered public, and
;  * will be used by other applications to target your process.  You are
;  * free to use this mach_port_t to add to a port set, if and only if,
;  * you are not also using routines from HIToolbox.  In that case,
;  * HIToolbox retains control of this port and AppleEvents are
;  * dispatched through the main event loop.
;  *
; 
;  *  AEGetRegisteredMachPort()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEGetRegisteredMachPort" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :pointer
() )
; -
;  * Decode a mach_msg into an AppleEvent and its related reply.  (The
;  * reply is set up from fields of the event.)  You can call this
;  * routine if you wish to dispatch or handle the event yourself.  To
;  * return a reply to the sender, you should call:
;  *
;  *  AESendMessage(reply, NULL, kAENoReply, kAENormalPriority, kAEDefaultTimeout);
;  *
;  * If this message is a reply, the 'reply' parameter will be
;  * initialized to { typeNull, 0 }, and the 'event' parameter will be
;  * the AppleEvent reply with a event class attribute of
;  * typeAppleEvent, class typeAppleEventReply:
;  *
;  * The contents of the header are invalid after this call.  
;  *
; 
;  *  AEDecodeMessage()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEDecodeMessage" 
   ((header (:pointer :MACH_MSG_HEADER_T))
    (event (:pointer :AppleEvent))
    (reply (:pointer :AppleEvent))              ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; -
;  * Decodes and dispatches an event to an event handler.  Handles
;  * packaging and returning the reply to the sender.
;  *
;  * The contents of the header are invalid after this call.
;  *
; 
;  *  AEProcessMessage()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEProcessMessage" 
   ((header (:pointer :MACH_MSG_HEADER_T))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; -
;  * Send an AppleEvent to a target process.  If the target is the
;  * current process (as specified by using typeProcessSerialNumber of
;  * { 0, kCurrentProcess } it is dispatched directly to the
;  * appropriate event handler in your process and not serialized.
;  *
; 
;  *  AESendMessage()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AESendMessage" 
   ((event (:pointer :AppleEvent))
    (reply (:pointer :AppleEvent))              ;  can be NULL 
    (sendMode :SInt32)
    (timeOutInTicks :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __AEMACH__ */


(provide-interface "AEMach")