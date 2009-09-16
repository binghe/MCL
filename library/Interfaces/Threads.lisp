(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Threads.h"
; at Sunday July 2,2006 7:23:27 pm.
; 
;      File:       CarbonCore/Threads.h
;  
;      Contains:   Thread Manager Interfaces.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1991-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __THREADS__
; #define __THREADS__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __MIXEDMODE__
#| #|
#include <CarbonCoreMixedMode.h>
#endif
|#
 |#
; #ifndef __MACERRORS__
#| #|
#include <CarbonCoreMacErrors.h>
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
;  Thread states

(def-mactype :ThreadState (find-mactype ':UInt16))

(defconstant $kReadyThreadState 0)
(defconstant $kStoppedThreadState 1)
(defconstant $kRunningThreadState 2)
;  Error codes have been moved to Errors.(pah)
;  Thread environment characteristics

(def-mactype :ThreadTaskRef (find-mactype '(:pointer :void)))
;  Thread characteristics

(def-mactype :ThreadStyle (find-mactype ':UInt32))

(defconstant $kCooperativeThread 1)
(defconstant $kPreemptiveThread 2)
;  Thread identifiers

(def-mactype :ThreadID (find-mactype ':UInt32))

(defconstant $kNoThreadID 0)
(defconstant $kCurrentThreadID 1)
(defconstant $kApplicationThreadID 2)
;  Options when creating a thread

(def-mactype :ThreadOptions (find-mactype ':UInt32))

(defconstant $kNewSuspend 1)
(defconstant $kUsePremadeThread 2)
(defconstant $kCreateIfNeeded 4)
(defconstant $kFPUNotNeeded 8)
(defconstant $kExactMatchThread 16)
;  Information supplied to the custom scheduler
(defrecord SchedulerInfoRec
   (InfoRecSize :UInt32)
   (CurrentThreadID :UInt32)
   (SuggestedThreadID :UInt32)
   (InterruptedCoopThreadID :UInt32)
)

;type name? (%define-record :SchedulerInfoRec (find-record-descriptor ':SchedulerInfoRec))

(def-mactype :SchedulerInfoRecPtr (find-mactype '(:pointer :SchedulerInfoRec)))
; 
;     The following ProcPtrs cannot be interchanged with UniversalProcPtrs because
;     of differences between 680x0 and PowerPC runtime architectures with regard to
;     the implementation of the Thread Manager.
;  

(def-mactype :voidPtr (find-mactype '(:pointer :void)))
;  Prototype for thread's entry (main) routine

(def-mactype :ThreadEntryProcPtr (find-mactype ':pointer)); (void * threadParam)
;  Prototype for custom thread scheduler routine

(def-mactype :ThreadSchedulerProcPtr (find-mactype ':pointer)); (SchedulerInfoRecPtr schedulerInfo)
;  Prototype for custom thread switcher routine

(def-mactype :ThreadSwitchProcPtr (find-mactype ':pointer)); (ThreadID threadBeingSwitched , void * switchProcParam)
;  Prototype for thread termination notification routine

(def-mactype :ThreadTerminationProcPtr (find-mactype ':pointer)); (ThreadID threadTerminated , void * terminationProcParam)
;  Prototype for debugger NewThread notification

(def-mactype :DebuggerNewThreadProcPtr (find-mactype ':pointer)); (ThreadID threadCreated)
;  Prototype for debugger DisposeThread notification

(def-mactype :DebuggerDisposeThreadProcPtr (find-mactype ':pointer)); (ThreadID threadDeleted)
;  Prototype for debugger schedule notification

(def-mactype :DebuggerThreadSchedulerProcPtr (find-mactype ':pointer)); (SchedulerInfoRecPtr schedulerInfo)

(def-mactype :ThreadEntryUPP (find-mactype '(:pointer :OpaqueThreadEntryProcPtr)))

(def-mactype :ThreadSchedulerUPP (find-mactype '(:pointer :OpaqueThreadSchedulerProcPtr)))

(def-mactype :ThreadSwitchUPP (find-mactype '(:pointer :OpaqueThreadSwitchProcPtr)))

(def-mactype :ThreadTerminationUPP (find-mactype '(:pointer :OpaqueThreadTerminationProcPtr)))

(def-mactype :DebuggerNewThreadUPP (find-mactype '(:pointer :OpaqueDebuggerNewThreadProcPtr)))

(def-mactype :DebuggerDisposeThreadUPP (find-mactype '(:pointer :OpaqueDebuggerDisposeThreadProcPtr)))

(def-mactype :DebuggerThreadSchedulerUPP (find-mactype '(:pointer :OpaqueDebuggerThreadSchedulerProcPtr)))
; 
;  *  NewThreadEntryUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewThreadEntryUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueThreadEntryProcPtr)
() )
; 
;  *  NewThreadSchedulerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewThreadSchedulerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueThreadSchedulerProcPtr)
() )
; 
;  *  NewThreadSwitchUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewThreadSwitchUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueThreadSwitchProcPtr)
() )
; 
;  *  NewThreadTerminationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewThreadTerminationUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueThreadTerminationProcPtr)
() )
; 
;  *  NewDebuggerNewThreadUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDebuggerNewThreadUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDebuggerNewThreadProcPtr)
() )
; 
;  *  NewDebuggerDisposeThreadUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDebuggerDisposeThreadUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDebuggerDisposeThreadProcPtr)
() )
; 
;  *  NewDebuggerThreadSchedulerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDebuggerThreadSchedulerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDebuggerThreadSchedulerProcPtr)
() )
; 
;  *  DisposeThreadEntryUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeThreadEntryUPP" 
   ((userUPP (:pointer :OpaqueThreadEntryProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeThreadSchedulerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeThreadSchedulerUPP" 
   ((userUPP (:pointer :OpaqueThreadSchedulerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeThreadSwitchUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeThreadSwitchUPP" 
   ((userUPP (:pointer :OpaqueThreadSwitchProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeThreadTerminationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeThreadTerminationUPP" 
   ((userUPP (:pointer :OpaqueThreadTerminationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDebuggerNewThreadUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDebuggerNewThreadUPP" 
   ((userUPP (:pointer :OpaqueDebuggerNewThreadProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDebuggerDisposeThreadUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDebuggerDisposeThreadUPP" 
   ((userUPP (:pointer :OpaqueDebuggerDisposeThreadProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDebuggerThreadSchedulerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDebuggerThreadSchedulerUPP" 
   ((userUPP (:pointer :OpaqueDebuggerThreadSchedulerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeThreadEntryUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeThreadEntryUPP" 
   ((threadParam :pointer)
    (userUPP (:pointer :OpaqueThreadEntryProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :void)
() )
; 
;  *  InvokeThreadSchedulerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeThreadSchedulerUPP" 
   ((schedulerInfo (:pointer :SchedulerInfoRec))
    (userUPP (:pointer :OpaqueThreadSchedulerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  InvokeThreadSwitchUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeThreadSwitchUPP" 
   ((threadBeingSwitched :UInt32)
    (switchProcParam :pointer)
    (userUPP (:pointer :OpaqueThreadSwitchProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeThreadTerminationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeThreadTerminationUPP" 
   ((threadTerminated :UInt32)
    (terminationProcParam :pointer)
    (userUPP (:pointer :OpaqueThreadTerminationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDebuggerNewThreadUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDebuggerNewThreadUPP" 
   ((threadCreated :UInt32)
    (userUPP (:pointer :OpaqueDebuggerNewThreadProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDebuggerDisposeThreadUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDebuggerDisposeThreadUPP" 
   ((threadDeleted :UInt32)
    (userUPP (:pointer :OpaqueDebuggerDisposeThreadProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDebuggerThreadSchedulerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDebuggerThreadSchedulerUPP" 
   ((schedulerInfo (:pointer :SchedulerInfoRec))
    (userUPP (:pointer :OpaqueDebuggerThreadSchedulerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;    Thread Manager function pointers (TPP):
;    on classic 68k use raw function pointers (same as UPP's)
;    on classic PowerPC, use raw function pointers
;    on classic PowerPC with OPAQUE_UPP_TYPES=1, use UPP's
;    on CFM-68K, use UPP's
;    on Carbon, use UPP's
; 
;  use UPP's

(def-mactype :ThreadEntryTPP (find-mactype ':ThreadEntryUPP))

(def-mactype :ThreadSchedulerTPP (find-mactype ':ThreadSchedulerUPP))

(def-mactype :ThreadSwitchTPP (find-mactype ':ThreadSwitchUPP))

(def-mactype :ThreadTerminationTPP (find-mactype ':ThreadTerminationUPP))

(def-mactype :DebuggerNewThreadTPP (find-mactype ':DebuggerNewThreadUPP))

(def-mactype :DebuggerDisposeThreadTPP (find-mactype ':DebuggerDisposeThreadUPP))

(def-mactype :DebuggerThreadSchedulerTPP (find-mactype ':DebuggerThreadSchedulerUPP))
; 
;  *  NewThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_NewThread" 
   ((threadStyle :UInt32)
    (threadEntry (:pointer :OpaqueThreadEntryProcPtr))
    (threadParam :pointer)
    (stackSize :signed-long)
    (options :UInt32)
    (threadResult :pointer)                     ;  can be NULL 
    (threadMade (:pointer :THREADID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetThreadScheduler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_SetThreadScheduler" 
   ((threadScheduler (:pointer :OpaqueThreadSchedulerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetThreadSwitcher()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_SetThreadSwitcher" 
   ((thread :UInt32)
    (threadSwitcher (:pointer :OpaqueThreadSwitchProcPtr))
    (switchProcParam :pointer)
    (inOrOut :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetThreadTerminator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_SetThreadTerminator" 
   ((thread :UInt32)
    (threadTerminator (:pointer :OpaqueThreadTerminationProcPtr))
    (terminationProcParam :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDebuggerNotificationProcs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_SetDebuggerNotificationProcs" 
   ((notifyNewThread (:pointer :OpaqueDebuggerNewThreadProcPtr))
    (notifyDisposeThread (:pointer :OpaqueDebuggerDisposeThreadProcPtr))
    (notifyThreadScheduler (:pointer :OpaqueDebuggerThreadSchedulerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CreateThreadPool()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_CreateThreadPool" 
   ((threadStyle :UInt32)
    (numToCreate :SInt16)
    (stackSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetFreeThreadCount()   *** DEPRECATED ***
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_GetFreeThreadCount" 
   ((threadStyle :UInt32)
    (freeCount (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  GetSpecificFreeThreadCount()   *** DEPRECATED ***
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_GetSpecificFreeThreadCount" 
   ((threadStyle :UInt32)
    (stackSize :signed-long)
    (freeCount (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  GetDefaultThreadStackSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_GetDefaultThreadStackSize" 
   ((threadStyle :UInt32)
    (stackSize (:pointer :SIZE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ThreadCurrentStackSpace()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_ThreadCurrentStackSpace" 
   ((thread :UInt32)
    (freeStack (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DisposeThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_DisposeThread" 
   ((threadToDump :UInt32)
    (threadResult :pointer)
    (recycleThread :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  YieldToThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_YieldToThread" 
   ((suggestedThread :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  YieldToAnyThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_YieldToAnyThread" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  [Mac]GetCurrentThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

; #if TARGET_OS_MAC
; #define MacGetCurrentThread GetCurrentThread

; #endif


(deftrap-inline "_GetCurrentThread" 
   ((currentThreadID (:pointer :THREADID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetThreadState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_GetThreadState" 
   ((threadToGet :UInt32)
    (threadState (:pointer :THREADSTATE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetThreadState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_SetThreadState" 
   ((threadToSet :UInt32)
    (newState :UInt16)
    (suggestedThread :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetThreadStateEndCritical()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_SetThreadStateEndCritical" 
   ((threadToSet :UInt32)
    (newState :UInt16)
    (suggestedThread :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ThreadBeginCritical()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_ThreadBeginCritical" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ThreadEndCritical()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_ThreadEndCritical" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetThreadCurrentTaskRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_GetThreadCurrentTaskRef" 
   ((threadTRef (:pointer :THREADTASKREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetThreadStateGivenTaskRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_GetThreadStateGivenTaskRef" 
   ((threadTRef (:pointer :void))
    (threadToGet :UInt32)
    (threadState (:pointer :THREADSTATE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetThreadReadyGivenTaskRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
;  

(deftrap-inline "_SetThreadReadyGivenTaskRef" 
   ((threadTRef (:pointer :void))
    (threadToSet :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __THREADS__ */


(provide-interface "Threads")