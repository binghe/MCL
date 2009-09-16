(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Multiprocessing.h"
; at Sunday July 2,2006 7:23:19 pm.
; 
;      File:       CarbonCore/Multiprocessing.h
;  
;      Contains:   Multiprocessing interfaces
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1995-2003 DayStar Digital, Inc.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; 
;    ===========================================================================================
;    *** WARNING: You must properly check the availability of MP services before calling them!
;    See the section titled "Checking API Availability".
;    ===========================================================================================
; 
; #ifndef __MULTIPROCESSING__
; #define __MULTIPROCESSING__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
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
; #pragma options align=power
; 
;    ===========================================================================================
;    This is the header file for version 2.2 of the Mac OS multiprocessing support.  This version
;    has been totally reimplemented and has significant new services.  The main goal of the
;    reimplementation has been to transfer task management into the core operating system to provide
;    much more reliable and more efficient operation, including on single processor machines.
;    The memory management has also been massively improved, it is much faster and wastes much
;    less space.  New services include POSIX style per-task storage, timers with millisecond and
;    microsecond resolutions, memory allocation at a specified alignment, and system pageable
;    and RAM resident memory pools.  See the MP API documentation for details.
;    The old "DayStar" debugging services (whose names began with an underscore) have been
;    removed from this header.  A very few are still implemented for binary compatibility, or in
;    cases where they happened to be exposed inappropriately.  (E.g. _MPIsFullyInitialized must
;    be called to see if the MP API is ReallyTrulyª usable.)  New code and recompiles of old
;    code should avoid use of these defunct services, except for _MPIsFullyInitialized.
;    ===========================================================================================
; 
; 
;    ===========================================================================================
;    The following services are from the original MP API and remain supported in version 2.0:
;     MPProcessors
;     MPCreateTask
;     MPTerminateTask
;     MPCurrentTaskID
;     MPYield
;     MPExit
;     MPCreateQueue
;     MPDeleteQueue
;     MPNotifyQueue
;     MPWaitOnQueue
;     MPCreateSemaphore
;     MPCreateBinarySemaphore     (In C only, a macro that calls MPCreateSemaphore.)
;     MPDeleteSemaphore
;     MPSignalSemaphore
;     MPWaitOnSemaphore
;     MPCreateCriticalRegion
;     MPDeleteCriticalRegion
;     MPEnterCriticalRegion
;     MPExitCriticalRegion
;     MPAllocate                  (Deprecated, use MPAllocateAligned for new builds.)
;     MPFree
;     MPBlockCopy
;     MPLibraryIsLoaded           (In C only, a macro.)
;     _MPIsFullyInitialized       (See comments about checking for MP API availability.)
;    ===========================================================================================
; 
; 
;    ===========================================================================================
;    The following services are new in version 2.0:
;     MPProcessorsScheduled
;     MPSetTaskWeight
;     MPTaskIsPreemptive
;     MPAllocateTaskStorageIndex
;     MPDeallocateTaskStorageIndex
;     MPSetTaskStorageValue
;     MPGetTaskStorageValue
;     MPSetQueueReserve
;     MPCreateEvent
;     MPDeleteEvent
;     MPSetEvent
;     MPWaitForEvent
;     UpTime
;     DurationToAbsolute
;     AbsoluteToDuration
;     MPDelayUntil
;     MPCreateTimer
;     MPDeleteTimer
;     MPSetTimerNotify
;     MPArmTimer
;     MPCancelTimer
;     MPSetExceptionHandler
;     MPThrowException
;     MPDisposeTaskException
;     MPExtractTaskState
;     MPSetTaskState
;     MPRegisterDebugger
;     MPUnregisterDebugger
;     MPAllocateAligned           (Preferred over MPAllocate.)
;     MPGetAllocatedBlockSize
;     MPBlockClear
;     MPDataToCode
;     MPRemoteCall                (Preferred over _MPRPC.)
;    ===========================================================================================
; 
; 
;    ===========================================================================================
;    The following services are new in version 2.1:
;     MPCreateNotification
;     MPDeleteNotification
;     MPModifyNotification
;     MPCauseNotification
;     MPGetNextTaskID
;     MPGetNextCpuID
;    ===========================================================================================
; 
; 
;    ===========================================================================================
;    The following services are "unofficial" extensions to the original API.  They are not in
;    the multiprocessing API documentation, but were in previous versions of this header.  They
;    remain supported in version 2.0.  They may not be supported in other environments.
;     _MPRPC                      (Deprecated, use MPRemoteCall for new builds.)
;     _MPAllocateSys              (Deprecated, use MPAllocateAligned for new builds.)
;     _MPTaskIsToolboxSafe
;     _MPLibraryVersion
;     _MPLibraryIsCompatible
;    ===========================================================================================
; 
; 
;    ===========================================================================================
;    The following services were in previous versions of this header for "debugging only" use.
;    They are NOT implemented in version 2.0.  For old builds they can be accessed by defining
;    the symbol MPIncludeDefunctServices to have a nonzero value.
;     _MPInitializePrintf
;     _MPPrintf
;     _MPDebugStr
;     _MPStatusPString
;     _MPStatusCString
;    ===========================================================================================
; 
; 
;    ¤
;    ===========================================================================================
;    General Types and Constants
;    ===========================
; 
(defconstant $MPCopyrightNotice "Copyright © 1995-2000 Apple Computer, Inc.\\n")
; #define MPCopyrightNotice       "Copyright © 1995-2000 Apple Computer, Inc.\n"
(defconstant $MPLibraryName "MPLibrary")
; #define MPLibraryName "MPLibrary"
; #define MPLibraryCName MPLibraryName
(defconstant $MPLibraryPName "\\p")
; #define MPLibraryPName "\p" MPLibraryName
(defconstant $MP_API_Version "2.3")
; #define MP_API_Version "2.3"

(defconstant $MPLibrary_MajorVersion 2)         ;  ! When these change be sure to update the build versions

(defconstant $MPLibrary_MinorVersion 3)         ;  !  used in the startup check in MPInitializeAPI!

(defconstant $MPLibrary_Release 1)
(defconstant $MPLibrary_DevelopmentRevision 1)

(def-mactype :MPProcessID (find-mactype '(:pointer :OpaqueMPProcessID)))

(def-mactype :MPTaskID (find-mactype '(:pointer :OpaqueMPTaskID)))

(def-mactype :MPQueueID (find-mactype '(:pointer :OpaqueMPQueueID)))

(def-mactype :MPSemaphoreID (find-mactype '(:pointer :OpaqueMPSemaphoreID)))

(def-mactype :MPCriticalRegionID (find-mactype '(:pointer :OpaqueMPCriticalRegionID)))

(def-mactype :MPTimerID (find-mactype '(:pointer :OpaqueMPTimerID)))

(def-mactype :MPEventID (find-mactype '(:pointer :OpaqueMPEventID)))

(def-mactype :MPAddressSpaceID (find-mactype '(:pointer :OpaqueMPAddressSpaceID)))

(def-mactype :MPNotificationID (find-mactype '(:pointer :OpaqueMPNotificationID)))

(def-mactype :MPCoherenceID (find-mactype '(:pointer :OpaqueMPCoherenceID)))

(def-mactype :MPCpuID (find-mactype '(:pointer :OpaqueMPCpuID)))

(def-mactype :MPAreaID (find-mactype '(:pointer :OpaqueMPAreaID)))

(def-mactype :MPConsoleID (find-mactype '(:pointer :OpaqueMPConsoleID)))

(def-mactype :MPOpaqueID (find-mactype '(:pointer :OpaqueMPOpaqueID)))
;  Values for MPOpaqueIDClass.

(defconstant $kOpaqueAnyID 0)
(defconstant $kOpaqueProcessID 1)
(defconstant $kOpaqueTaskID 2)
(defconstant $kOpaqueTimerID 3)
(defconstant $kOpaqueQueueID 4)
(defconstant $kOpaqueSemaphoreID 5)
(defconstant $kOpaqueCriticalRegionID 6)
(defconstant $kOpaqueCpuID 7)
(defconstant $kOpaqueAddressSpaceID 8)
(defconstant $kOpaqueEventID 9)
(defconstant $kOpaqueCoherenceID 10)
(defconstant $kOpaqueAreaID 11)
(defconstant $kOpaqueNotificationID 12)
(defconstant $kOpaqueConsoleID 13)

(def-mactype :MPOpaqueIDClass (find-mactype ':UInt32))

(defconstant $kMPNoID $kinvalidid)              ;  New code should use kInvalidID everywhere.


(def-mactype :MPTaskOptions (find-mactype ':UInt32))

(def-mactype :TaskStorageIndex (find-mactype ':UInt32))

(def-mactype :TaskStorageValue (find-mactype ':UInt32))

(def-mactype :MPSemaphoreCount (find-mactype ':UInt32))

(def-mactype :MPTaskWeight (find-mactype ':UInt32))

(def-mactype :MPEventFlags (find-mactype ':UInt32))

(def-mactype :MPExceptionKind (find-mactype ':UInt32))

(def-mactype :MPTaskStateKind (find-mactype ':UInt32))

(def-mactype :MPPageSizeClass (find-mactype ':UInt32))

(defconstant $kDurationImmediate 0)
(defconstant $kDurationForever #x7FFFFFFF)
(defconstant $kDurationMillisecond 1)
(defconstant $kDurationMicrosecond -1)
; 
;    ¤
;    ===========================================================================================
;    Process/Processor Services
;    ==========================
; 
; 
;  *  MPProcessors()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPProcessors" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  The physical total.
; 
;  *  MPProcessorsScheduled()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPProcessorsScheduled" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  Those currently in use.
; 
;    ¤
;    ===========================================================================================
;    Tasking Services
;    ================
; 
;  For MPCreateTask options

(defconstant $kMPCreateTaskSuspendedMask 1)
(defconstant $kMPCreateTaskTakesAllExceptionsMask 2)
(defconstant $kMPCreateTaskNotDebuggableMask 4)
(defconstant $kMPCreateTaskValidOptionsMask 7)
;  -------------------------------------------------------------------------------------------

(def-mactype :TaskProc (find-mactype ':pointer)); (void * parameter)
; 
;  *  MPCreateTask()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPCreateTask" 
   ((entryPoint :pointer)
    (parameter :pointer)
    (stackSize :UInt32)
    (notifyQueue (:pointer :OpaqueMPQueueID))
    (terminationParameter1 :pointer)
    (terminationParameter2 :pointer)
    (options :UInt32)
    (task (:pointer :MPTASKID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPTerminateTask()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPTerminateTask" 
   ((task (:pointer :OpaqueMPTaskID))
    (terminationStatus :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPSetTaskWeight()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPSetTaskWeight" 
   ((task (:pointer :OpaqueMPTaskID))
    (weight :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPTaskIsPreemptive()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPTaskIsPreemptive" 
   ((taskID (:pointer :OpaqueMPTaskID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  May be kInvalidID.
; 
;  *  MPExit()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPExit" 
   ((status :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MPYield()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPYield" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MPCurrentTaskID()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPCurrentTaskID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMPTaskID)
() )
; 
;  *  MPSetTaskType()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.3 and later
;  

(deftrap-inline "_MPSetTaskType" 
   ((task (:pointer :OpaqueMPTaskID))
    (taskType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
;  -------------------------------------------------------------------------------------------
; 
;    ---------------------------------------------------
;    ! The task storage services are new in version 2.0.
; 
; 
;  *  MPAllocateTaskStorageIndex()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPAllocateTaskStorageIndex" 
   ((index (:pointer :TASKSTORAGEINDEX))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPDeallocateTaskStorageIndex()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPDeallocateTaskStorageIndex" 
   ((index :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPSetTaskStorageValue()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPSetTaskStorageValue" 
   ((index :UInt32)
    (value :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPGetTaskStorageValue()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPGetTaskStorageValue" 
   ((index :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;    ¤
;    ===========================================================================================
;    Synchronization Services
;    ========================
; 
; 
;  *  MPCreateQueue()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPCreateQueue" 
   ((queue (:pointer :MPQUEUEID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPDeleteQueue()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPDeleteQueue" 
   ((queue (:pointer :OpaqueMPQueueID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPNotifyQueue()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPNotifyQueue" 
   ((queue (:pointer :OpaqueMPQueueID))
    (param1 :pointer)
    (param2 :pointer)
    (param3 :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPWaitOnQueue()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPWaitOnQueue" 
   ((queue (:pointer :OpaqueMPQueueID))
    (param1 :pointer)
    (param2 :pointer)
    (param3 :pointer)
    (timeout :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPSetQueueReserve()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPSetQueueReserve" 
   ((queue (:pointer :OpaqueMPQueueID))
    (count :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  -------------------------------------------------------------------------------------------
; 
;  *  MPCreateSemaphore()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPCreateSemaphore" 
   ((maximumValue :UInt32)
    (initialValue :UInt32)
    (semaphore (:pointer :MPSEMAPHOREID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPDeleteSemaphore()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPDeleteSemaphore" 
   ((semaphore (:pointer :OpaqueMPSemaphoreID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPSignalSemaphore()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPSignalSemaphore" 
   ((semaphore (:pointer :OpaqueMPSemaphoreID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPWaitOnSemaphore()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPWaitOnSemaphore" 
   ((semaphore (:pointer :OpaqueMPSemaphoreID))
    (timeout :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #define MPCreateBinarySemaphore(semaphore)              MPCreateSemaphore ( 1, 1, (semaphore) )
;  -------------------------------------------------------------------------------------------
; 
;  *  MPCreateCriticalRegion()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPCreateCriticalRegion" 
   ((criticalRegion (:pointer :MPCRITICALREGIONID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPDeleteCriticalRegion()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPDeleteCriticalRegion" 
   ((criticalRegion (:pointer :OpaqueMPCriticalRegionID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPEnterCriticalRegion()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPEnterCriticalRegion" 
   ((criticalRegion (:pointer :OpaqueMPCriticalRegionID))
    (timeout :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPExitCriticalRegion()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPExitCriticalRegion" 
   ((criticalRegion (:pointer :OpaqueMPCriticalRegionID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  -------------------------------------------------------------------------------------------
; 
;  *  MPCreateEvent()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPCreateEvent" 
   ((event (:pointer :MPEVENTID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPDeleteEvent()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPDeleteEvent" 
   ((event (:pointer :OpaqueMPEventID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPSetEvent()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPSetEvent" 
   ((event (:pointer :OpaqueMPEventID))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPWaitForEvent()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPWaitForEvent" 
   ((event (:pointer :OpaqueMPEventID))
    (flags (:pointer :MPEVENTFLAGS))
    (timeout :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    ¤
;    ===========================================================================================
;    Notification Services (API)
;    =====================
; 
; 
;  *  MPCreateNotification()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.1 and later
;  

(deftrap-inline "_MPCreateNotification" 
   ((notificationID (:pointer :MPNOTIFICATIONID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPDeleteNotification()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.1 and later
;  

(deftrap-inline "_MPDeleteNotification" 
   ((notificationID (:pointer :OpaqueMPNotificationID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPModifyNotification()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.1 and later
;  

(deftrap-inline "_MPModifyNotification" 
   ((notificationID (:pointer :OpaqueMPNotificationID))
    (anID (:pointer :OpaqueMPOpaqueID))
    (notifyParam1 :pointer)
    (notifyParam2 :pointer)
    (notifyParam3 :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPModifyNotificationParameters()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.3 and later
;  

(deftrap-inline "_MPModifyNotificationParameters" 
   ((notificationID (:pointer :OpaqueMPNotificationID))
    (kind :UInt32)
    (notifyParam1 :pointer)
    (notifyParam2 :pointer)
    (notifyParam3 :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  MPCauseNotification()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.1 and later
;  

(deftrap-inline "_MPCauseNotification" 
   ((notificationID (:pointer :OpaqueMPNotificationID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    ¤
;    ===========================================================================================
;    Timer Services
;    ==============
; 
; 
;    --------------------------------------------
;    ! The timer services are new in version 2.0.
; 
;  For MPArmTimer options

(defconstant $kMPPreserveTimerIDMask 1)
(defconstant $kMPTimeIsDeltaMask 2)
(defconstant $kMPTimeIsDurationMask 4)
; 
;  *  MPDelayUntil()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPDelayUntil" 
   ((expirationTime (:pointer :ABSOLUTETIME))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPDelayUntilSys()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPLibrary 2.1 and later
;  
; 
;  *  MPCreateTimer()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPCreateTimer" 
   ((timerID (:pointer :MPTIMERID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPDeleteTimer()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPDeleteTimer" 
   ((timerID (:pointer :OpaqueMPTimerID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPSetTimerNotify()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPSetTimerNotify" 
   ((timerID (:pointer :OpaqueMPTimerID))
    (anID (:pointer :OpaqueMPOpaqueID))
    (notifyParam1 :pointer)
    (notifyParam2 :pointer)
    (notifyParam3 :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPArmTimer()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPArmTimer" 
   ((timerID (:pointer :OpaqueMPTimerID))
    (expirationTime (:pointer :ABSOLUTETIME))
    (options :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPCancelTimer()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPCancelTimer" 
   ((timerID (:pointer :OpaqueMPTimerID))
    (timeRemaining (:pointer :ABSOLUTETIME))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    ¤
;    ===========================================================================================
;    Memory Services
;    ===============
; 
;  Maximum allocation request size is 1GB.

(defconstant $kMPMaxAllocSize #x40000000)
;  Values for the alignment parameter to MPAllocateAligned.

(defconstant $kMPAllocateDefaultAligned 0)
(defconstant $kMPAllocate8ByteAligned 3)
(defconstant $kMPAllocate16ByteAligned 4)
(defconstant $kMPAllocate32ByteAligned 5)
(defconstant $kMPAllocate1024ByteAligned 10)
(defconstant $kMPAllocate4096ByteAligned 12)
(defconstant $kMPAllocateMaxAlignment 16)       ;  Somewhat arbitrary limit on expectations.

(defconstant $kMPAllocateAltiVecAligned 4)      ;  The P.C. name.

(defconstant $kMPAllocateVMXAligned 4)          ;  The older, common name.

(defconstant $kMPAllocateVMPageAligned #xFE)    ;  Pseudo value, converted at runtime.

(defconstant $kMPAllocateInterlockAligned #xFF) ;  Pseudo value, converted at runtime.

;  Values for the options parameter to MPAllocateAligned.

(defconstant $kMPAllocateClearMask 1)           ;  Zero the allocated block.

(defconstant $kMPAllocateGloballyMask 2)        ;  Allocate from the globally visible pool.

(defconstant $kMPAllocateResidentMask 4)        ;  Allocate from the RAM-resident pool.

(defconstant $kMPAllocateNoGrowthMask 16)       ;  Do not attempt to grow the pool.

(defconstant $kMPAllocateNoCreateMask 32)       ;  Do not attempt to create the pool if it doesn't exist yet.

;  -------------------------------------------------------------------------------------------
; 
;  *  MPAllocateAligned()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPAllocateAligned" 
   ((size :UInt32)
    (alignment :UInt8)
    (options :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :void)
() )
;  ! MPAllocateAligned is new in version 2.0.
; 
;  *  MPAllocate()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPAllocate" 
   ((size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :void)
() )
;  Use MPAllocateAligned instead.
; 
;  *  MPFree()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPFree" 
   ((object (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MPGetAllocatedBlockSize()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPGetAllocatedBlockSize" 
   ((object (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  -------------------------------------------------------------------------------------------
; 
;  *  MPBlockCopy()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "_MPBlockCopy" 
   ((source (:pointer :void))
    (destination (:pointer :void))
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MPBlockClear()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPBlockClear" 
   ((address (:pointer :void))
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  ! MPBlockClear is new in version 2.0.
; 
;  *  MPDataToCode()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPDataToCode" 
   ((address (:pointer :void))
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  ! MPDataToCode is new in version 2.0.
; 
;    ¤
;    ===========================================================================================
;    Exception/Debugging Services
;    ============================
; 
; 
;    -------------------------------------------------------------------------------------------
;    *** Important Note ***
;    ----------------------
;    
;    The functions MPExtractTaskState and MPSetTaskState infer the size of the "info" buffer
;    from the "kind" parameter.  A given value for MPTaskStateKind will always refer to a
;    single specific physical buffer layout.  Should new register sets be added, or the size
;    or number of any registers change, new values of MPTaskStateKind will be introduced to
;    refer to the new buffer layouts.
;    
;    The following types for the buffers are in MachineExceptions. The correspondence between
;    MPTaskStateKind values and MachineExceptions types is:
;    
;         kMPTaskStateRegisters               -> RegisterInformation
;         kMPTaskStateFPU                     -> FPUInformation
;         kMPTaskStateVectors                 -> VectorInformation
;         kMPTaskStateMachine                 -> MachineInformation
;         kMPTaskState32BitMemoryException    -> ExceptionInfo for old-style 32-bit memory exceptions
;    
;     For reference, on PowerPC the MachineExceptions types contain:
;    
;         RegisterInformation -> The GPRs, 32 values of 64 bits each.
;         FPUInformation      -> The FPRs plus FPSCR, 32 values of 64 bits each, one value of
;                                 32 bits.
;         VectorInformation   -> The AltiVec vector registers plus VSCR and VRSave, 32 values
;                                 of 128 bits each, one value of 128 bits, and one 32 bit value.
;         MachineInformation  -> The CTR, LR, PC, each of 64 bits.  The CR, XER, MSR, MQ,
;                                 exception kind, and DSISR, each of 32 bits.  The 64 bit DAR.
;         ExceptionInfo       -> Only memory exceptions are specified, 4 fields of 32 bits each.
;                                 Note that this type only covers memory exceptions on 32-bit CPUs!
;    The following types are declared here:
;         kMPTaskStateTaskInfo                -> MPTaskInfo
; 
;  Values for the TaskStateKind to MPExtractTaskState and MPSetTaskState.

(defconstant $kMPTaskStateRegisters 0)          ;  The task general registers.

(defconstant $kMPTaskStateFPU 1)                ;  The task floating point registers

(defconstant $kMPTaskStateVectors 2)            ;  The task vector registers

(defconstant $kMPTaskStateMachine 3)            ;  The task machine registers

(defconstant $kMPTaskState32BitMemoryException 4);  The task memory exception information for 32-bit CPUs.

(defconstant $kMPTaskStateTaskInfo 5)           ;  Static and dynamic information about the task.

;  Option bits and numbers for MPDisposeTaskException.

(defconstant $kMPTaskPropagate 0)               ;  The exception is propagated.

(defconstant $kMPTaskResumeStep 1)              ;  The task is resumed and single step is enabled.

(defconstant $kMPTaskResumeBranch 2)            ;  The task is resumed and branch stepping is enabled.

(defconstant $kMPTaskResumeMask 0)              ;  The task is resumed.

(defconstant $kMPTaskPropagateMask 1)           ;  The exception is propagated.

(defconstant $kMPTaskResumeStepMask 2)          ;  The task is resumed and single step is enabled.
;  The task is resumed and branch stepping is enabled.

(defconstant $kMPTaskResumeBranchMask 4)
;  For kMPTaskStateTaskInfo, the task's runState

(defconstant $kMPTaskBlocked 0)                 ;  Task is blocked (queued on resource)

(defconstant $kMPTaskReady 1)                   ;  Task is runnable

(defconstant $kMPTaskRunning 2)                 ;  Task is running

;  For kMPTaskStateTaskInfo, the version of the MPTaskInfo structure requested.

(defconstant $kMPTaskInfoVersion 3)
(defrecord MPTaskInfoVersion2
   (version :UInt32)                            ;  Version 2 of the data structure requested
   (name :OSType)                               ;  Task name
   (queueName :OSType)                          ;  Task's queue owner name
   (runState :UInt16)                           ;  Running, ready, blocked
   (lastCPU :UInt16)                            ;  Address of CPU where task previously ran
   (weight :UInt32)                             ;  Processing weight: 1 - 10,000
   (processID (:pointer :OpaqueMPProcessID))    ;  Owning process ID
   (cpuTime :UnsignedWide)                      ;  Accumulated task time
   (schedTime :UnsignedWide)                    ;  Time when last scheduled
   (creationTime :UnsignedWide)                 ;  Time when task created
   (codePageFaults :UInt32)                     ;  Page faults from code execution
   (dataPageFaults :UInt32)                     ;  Page faults from data access
   (preemptions :UInt32)                        ;  Number of times task was preempted
   (cpuID (:pointer :OpaqueMPCpuID))            ;  ID of CPU where task previously ran
)

;type name? (%define-record :MPTaskInfoVersion2 (find-record-descriptor ':MPTaskInfoVersion2))
(defrecord MPTaskInfo
   (version :UInt32)                            ;  Version 3 of the data structure requested
   (name :OSType)                               ;  Task name
   (queueName :OSType)                          ;  Task's queue owner name
   (runState :UInt16)                           ;  Running, ready, blocked
   (lastCPU :UInt16)                            ;  Address of CPU where task previously ran
   (weight :UInt32)                             ;  Processing weight: 1 - 10,000
   (processID (:pointer :OpaqueMPProcessID))    ;  Owning process ID
   (cpuTime :UnsignedWide)                      ;  Accumulated task time
   (schedTime :UnsignedWide)                    ;  Time when last scheduled
   (creationTime :UnsignedWide)                 ;  Time when task created
   (codePageFaults :UInt32)                     ;  Page faults from code execution
   (dataPageFaults :UInt32)                     ;  Page faults from data access
   (preemptions :UInt32)                        ;  Number of times task was preempted
   (cpuID (:pointer :OpaqueMPCpuID))            ;  ID of CPU where task previously ran.
   (blockedObject (:pointer :OpaqueMPOpaqueID)) ;  ID of blocked object.
   (spaceID (:pointer :OpaqueMPAddressSpaceID)) ;  Address space ID of this task.
   (stackBase (:pointer :void))                 ;  Base of stack (lowest address).
   (stackLimit (:pointer :void))                ;  Stack limit (highest address).
   (stackCurr (:pointer :void))                 ;  Current stack address.
)

;type name? (%define-record :MPTaskInfo (find-record-descriptor ':MPTaskInfo))
; 
;     Upon a task exception, the following message is sent to the designated queue:
;       1. The MPTaskID, 
;       2. The exception kind. These are enumerated in the interfaces header MachineExceptions.h 
;       3. N/A
; 
;  -------------------------------------------------------------------------------------------
; 
;  *  MPSetExceptionHandler()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPSetExceptionHandler" 
   ((task (:pointer :OpaqueMPTaskID))
    (exceptionQ (:pointer :OpaqueMPQueueID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPDisposeTaskException()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPDisposeTaskException" 
   ((task (:pointer :OpaqueMPTaskID))
    (action :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPExtractTaskState()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPExtractTaskState" 
   ((task (:pointer :OpaqueMPTaskID))
    (kind :UInt32)
    (info :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPSetTaskState()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPSetTaskState" 
   ((task (:pointer :OpaqueMPTaskID))
    (kind :UInt32)
    (info :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPThrowException()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPThrowException" 
   ((task (:pointer :OpaqueMPTaskID))
    (kind :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  -------------------------------------------------------------------------------------------

(def-mactype :MPDebuggerLevel (find-mactype ':UInt32))

(defconstant $kMPLowLevelDebugger 0)            ;  MacsBug-like

(defconstant $kMPMidLevelDebugger #x10000000)   ;  Jasik-like

(defconstant $kMPHighLevelDebugger #x20000000)  ;  Metrowerks-like

; 
;  *  MPRegisterDebugger()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPRegisterDebugger" 
   ((queue (:pointer :OpaqueMPQueueID))
    (level :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MPUnregisterDebugger()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPUnregisterDebugger" 
   ((queue (:pointer :OpaqueMPQueueID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    ¤
;    ===========================================================================================
;    Remote Call Services
;    ====================
; 

(def-mactype :MPRemoteProcedure (find-mactype ':pointer)); (void * parameter)

(def-mactype :MPRemoteContext (find-mactype ':UInt8))

(defconstant $kMPAnyRemoteContext 0)
(defconstant $kMPOwningProcessRemoteContext 1)
(defconstant $kMPInterruptRemoteContext 2)
(defconstant $kMPAsyncInterruptRemoteContext 3)
; 
;  *  MPRemoteCall()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 2.0 and later
;  

(deftrap-inline "_MPRemoteCall" 
   ((remoteProc :pointer)
    (parameter :pointer)
    (context :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :void)
() )
;  ! MPRemoteCall is new in version 2.0.
; 
;    ¤
;    ===========================================================================================
;    Checking API Availability
;    =========================
; 
; 
;    ===========================================================================================
;    *** WARNING: You must properly check the availability of MP services before calling them!
;    ===========================================================================================
;    
;    Checking for the availability of the MP API is rather ugly.  This is a historical problem,
;    caused by the original implementation letting itself get prepared when it really wasn't
;    usable and complicated by some important clients then depending on weak linking to "work".
;    (And further complicated by CFM not supporting "deferred" imports, which is how many
;    programmers think weak imports work.)
;    
;    The end result is that the MP API library may get prepared by CFM but be totally unusable.
;    This means that if you import from the MP API library, you cannot simply check for a
;    resolved import to decide if MP services are available.  Worse, if you explicitly prepare
;    the MP API library you cannot assume that a noErr result from GetSharedLibrary means that
;    MP services are available.
;    
;    ¥ If you import from the MP API library you MUST:
;    
;         Use the MPLibraryIsLoaded macro (or equivalent code in languages other than C) to tell
;         if the MP API services are available.  It is not sufficient to simply check that an
;         imported symbol is resolved as is commonly done for other libraries.  The macro expands
;         to the expression:
;    
;             ( ( (UInt32)_MPIsFullyInitialized != (UInt32)kUnresolvedCFragSymbolAddress ) &&
;               ( _MPIsFullyInitialized () ) )
;    
;         This checks if the imported symbol _MPIsFullyInitialized is resolved and if resolved
;         calls it.  Both parts must succeed for the MP API services to be available.
;    
;    ¥ If you explicitly prepare the MP API library you MUST:
;    
;         Use code similar to the following example to tell if the MP API services are available.
;         It is not sufficient to depend on just a noErr result from GetSharedLibrary.
;    
;             OSErr                       err;
;             Boolean                     mpIsAvailable           = false;
;             CFragConnectionID           connID                  = kInvalidID;
;             MPIsFullyInitializedProc    mpIsFullyInitialized    = NULL;
;    
;             err = GetSharedLibrary  ( "\pMPLibrary", kCompiledCFragArch, kReferenceCFrag,
;                                       &connID, NULL, NULL );
;    
;             if ( err == noErr ) {
;                 err = FindSymbol    ( connID, "\p_MPIsFullyInitialized",
;                                       (Ptr *) &mpIsFullyInitialized, NULL );
;             }
;    
;             if ( err == noErr ) {
;                 mpIsAvailable = (* mpIsFullyInitialized) ();
;             }
;    
;    ===========================================================================================
; 
; 
;  *  _MPIsFullyInitialized()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "__MPIsFullyInitialized" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )

(def-mactype :MPIsFullyInitializedProc (find-mactype ':pointer)); (void)
(defconstant $kMPUnresolvedCFragSymbolAddress 0)
; #define kMPUnresolvedCFragSymbolAddress 0
; #define MPLibraryIsLoaded()                 ( ( (UInt32)_MPIsFullyInitialized != (UInt32)kMPUnresolvedCFragSymbolAddress ) &&                 ( _MPIsFullyInitialized () ) )
; 
;    ¤
;    ===========================================================================================
;    Miscellaneous Services
;    ======================
; 
; 
;  *  _MPLibraryVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "__MPLibraryVersion" 
   ((versionCString (:pointer :char))
    (major (:pointer :UInt32))
    (minor (:pointer :UInt32))
    (release (:pointer :UInt32))
    (revision (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    ¤
;    ===========================================================================================
;    Unofficial Services
;    ===================
; 
; 
;    ===========================================================================================
;    *** WARNING ***
;    These services are not part of the officially documented multiprocessing API.  They may not
;    be avaliable in future versions of Mac OS multiprocessing support, or in environments that
;    have a different underlying OS architecture such as Mac OS on top of a microkernel, the
;    Mac OS Blue Box under Mac OS X, native MP support in Mac OS X, etc.
;    ===========================================================================================
; 

; #if CALL_NOT_IN_CARBON
#| 
; 
;  *  _MPAllocateSys()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  
;  Use MPAllocateAligned instead.
; 
;  *  _MPRPC()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  
;  Use _MPRemoteCall instead.
; 
;  *  _MPTaskIsToolboxSafe()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  
 |#

; #endif  /* CALL_NOT_IN_CARBON */

; 
;  *  _MPLibraryIsCompatible()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MPLibrary 1.0 and later
;  

(deftrap-inline "__MPLibraryIsCompatible" 
   ((versionCString (:pointer :char))
    (major :UInt32)
    (minor :UInt32)
    (release :UInt32)
    (revision :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; #define MPRPC                   _MPRPC
; #define MPTaskIsToolboxSafe     _MPTaskIsToolboxSafe
; 
;    ¤
;    ===========================================================================================
;    Defunct Services
;    ================
; 

; #if CALL_NOT_IN_CARBON
#| ; #ifndef MPIncludeDefunctServices
; #define MPIncludeDefunctServices 0

; #endif  /* !defined(MPIncludeDefunctServices) */


; #if MPIncludeDefunctServices
; 
;  *  _MPDebugStr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPLibraryObsolete 1.0 and later
;  
; 
;  *  _MPStatusPString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPLibraryObsolete 1.0 and later
;  
; 
;  *  _MPStatusCString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPLibraryObsolete 1.0 and later
;  
|#

(require-interface "stdarg")

#|
(def-mactype :MPPrintfHandler (find-mactype ':pointer)); (MPTaskID taskID , const char * format , va_list args)
; 
;  *  _MPInitializePrintf()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPLibraryObsolete 1.0 and later
;  
; 
;  *  _MPPrintf()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPLibraryObsolete 1.0 and later
;  

; #endif  /* MPIncludeDefunctServices */

 |#

; #endif  /* CALL_NOT_IN_CARBON */

;  ===========================================================================================
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __MULTIPROCESSING__ */


(provide-interface "Multiprocessing")