(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:MultiprocessingInfo.h"
; at Sunday July 2,2006 7:23:28 pm.
; 
;      File:       CarbonCore/MultiprocessingInfo.h
;  
;      Contains:   Multiprocessing Information interfaces
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
;    ==========================================================================================================================
;    *** WARNING: You must properly check the availability of MP services before calling them!
;    See the section titled "Checking API Availability".
;    ==========================================================================================================================
; 
; #ifndef __MULTIPROCESSINGINFO__
; #define __MULTIPROCESSINGINFO__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __MULTIPROCESSING__
#| #|
#include <CarbonCoreMultiprocessing.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=power
; 
;    ==========================================================================================================================
;    This is the header file for version 2.3 of the Mac OS multiprocessing information support. 
;    ==========================================================================================================================
; 
; 
;    ==========================================================================================================================
;    The following services are new in version 2.1:
;     MPGetNextTaskID
;     MPGetNextCpuID
;    ==========================================================================================================================
; 
; 
;    ==========================================================================================================================
;    The following services are new in version 2.2:
;     MPGetPageSizeClasses
;     MPGetPageSize
;     MPGetNextAreaID
;    ==========================================================================================================================
; 
; 
;    ==========================================================================================================================
;    The following services are new in version 2.3:
;     MPGetNextCoherenceID
;     MPGetNextProcessID
;     MPGetNextAddressSpaceID
;     MPGetNextQueueID
;     MPGetNextSemaphoreID
;     MPGetNextCriticalRegionID
;     MPGetNextTimerID
;     MPGetNextEventID
;     MPGetNextNotificationID
;     MPGetNextConsoleID
;    ==========================================================================================================================
; 
; 
;    ¤
;    ==========================================================================================================================
;    Page size Services
;    ==================
; 
; 
;  *  MPGetPageSizeClasses()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
;  The number of page size classes, 1 to n.
;  -------------------------------------------------------------------------------------------
; 
;  *  MPGetPageSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
;  The page size in bytes.
; 
;    ¤
;    ==========================================================================================================================
;    ID Iterator Services
;    ==========================
; 
; 
;  *  MPGetNextCoherenceID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetNextCpuID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetNextProcessID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetNextAddressSpaceID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetNextTaskID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetNextQueueID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetNextSemaphoreID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetNextCriticalRegionID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetNextTimerID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetNextEventID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetNextNotificationID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetNextAreaID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetNextConsoleID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
;  -------------------------------------------------------------------------------------------
; 
;  *  MPGetNextID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;    ¤
;    ==========================================================================================================================
;    Object Information Services
;    ===========================
; 
; 
;    ----------------------------------------------------------------------------------------------
;    ! The implementation of MPGetObjectInfo assumes that all info records are in 4 byte multiples.
; 
;  The version of the MPAreaInfo structure requested.

(defconstant $kMPQueueInfoVersion #x40001)
(defconstant $kMPSemaphoreInfoVersion #x50001)
(defconstant $kMPEventInfoVersion #x90001)
(defconstant $kMPCriticalRegionInfoVersion #x60001)
(defconstant $kMPNotificationInfoVersion #xC0001)
(defconstant $kMPAddressSpaceInfoVersion #x80001)
(defrecord MPQueueInfo
   (version :UInt32)                            ;  Version of the data structure requested
   (processID (:pointer :OpaqueMPProcessID))    ;  Owning process ID
   (queueName :OSType)                          ;  Queue name
   (nWaiting :UInt32)
   (waitingTaskID (:pointer :OpaqueMPTaskID))   ;  First waiting task.
   (nMessages :UInt32)
   (nReserved :UInt32)
   (p1 :pointer)                                ;  First message parameters...
   (p2 :pointer)
   (p3 :pointer)
)

;type name? (%define-record :MPQueueInfo (find-record-descriptor ':MPQueueInfo))
(defrecord MPSemaphoreInfo
   (version :UInt32)                            ;  Version of the data structure requested
   (processID (:pointer :OpaqueMPProcessID))    ;  Owning process ID
   (semaphoreName :OSType)                      ;  Semaphore name
   (nWaiting :UInt32)
   (waitingTaskID (:pointer :OpaqueMPTaskID))   ;  First waiting task.
   (maximum :UInt32)
   (count :UInt32)
)

;type name? (%define-record :MPSemaphoreInfo (find-record-descriptor ':MPSemaphoreInfo))
(defrecord MPEventInfo
   (version :UInt32)                            ;  Version of the data structure requested
   (processID (:pointer :OpaqueMPProcessID))    ;  Owning process ID
   (eventName :OSType)                          ;  Event name
   (nWaiting :UInt32)
   (waitingTaskID (:pointer :OpaqueMPTaskID))   ;  First waiting task.
   (events :UInt32)
)

;type name? (%define-record :MPEventInfo (find-record-descriptor ':MPEventInfo))
(defrecord MPCriticalRegionInfo
   (version :UInt32)                            ;  Version of the data structure requested
   (processID (:pointer :OpaqueMPProcessID))    ;  Owning process ID
   (regionName :OSType)                         ;  Critical region name
   (nWaiting :UInt32)
   (waitingTaskID (:pointer :OpaqueMPTaskID))   ;  First waiting task.
   (owningTask (:pointer :OpaqueMPTaskID))
   (count :UInt32)
)

;type name? (%define-record :MPCriticalRegionInfo (find-record-descriptor ':MPCriticalRegionInfo))
(defrecord MPNotificationInfo
   (version :UInt32)                            ;  Version of the data structure requested
   (processID (:pointer :OpaqueMPProcessID))    ;  Owning process ID
   (notificationName :OSType)                   ;  Notification name
   (queueID (:pointer :OpaqueMPQueueID))        ;  Queue to notify.
   (p1 :pointer)
   (p2 :pointer)
   (p3 :pointer)
   (eventID (:pointer :OpaqueMPEventID))        ;  Event to set.
   (events :UInt32)
   (semaphoreID (:pointer :OpaqueMPSemaphoreID));  Sempahore to signal.   
)

;type name? (%define-record :MPNotificationInfo (find-record-descriptor ':MPNotificationInfo))
(defrecord MPAddressSpaceInfo
   (version :UInt32)                            ;  Version of the data structure requested
   (processID (:pointer :OpaqueMPProcessID))    ;  Owning process ID
   (groupID (:pointer :OpaqueMPCoherenceID))    ;  Related coherence group.
   (nTasks :UInt32)                             ;  Number of tasks in this space.
   (vsid (:array :UInt32 16))                   ;  Segment register VSIDs.
)

;type name? (%define-record :MPAddressSpaceInfo (find-record-descriptor ':MPAddressSpaceInfo))
;  *** We should put the task info call here instead of in MPExtractTaskState.
; 
;  *  MPGetQueueInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetSemaphoreInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetEventInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetCriticalRegionInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetNotificationInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
; 
;  *  MPGetAddressSpaceInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
;  
;  ==========================================================================================================================
; #pragma options align=reset

; #endif /* __MULTIPROCESSINGINFO__ */


(provide-interface "MultiprocessingInfo")