(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DriverServices.h"
; at Sunday July 2,2006 7:23:22 pm.
; 
;      File:       CarbonCore/DriverServices.h
;  
;      Contains:   Driver Services Interfaces.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __DRIVERSERVICES__
; #define __DRIVERSERVICES__
; #ifndef __CONDITIONALMACROS__
#| #|
#include <CarbonCoreConditionalMacros.h>
#endif
|#
 |#
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __MACERRORS__
#| #|
#include <CarbonCoreMacErrors.h>
#endif
|#
 |#
; #ifndef __MACHINEEXCEPTIONS__

(require-interface "CarbonCore/MachineExceptions")

; #endif

; #ifndef __DEVICES__
#| #|
#include <CarbonCoreDevices.h>
#endif
|#
 |#
; #ifndef __DRIVERSYNCHRONIZATION__
#| #|
#include <CarbonCoreDriverSynchronization.h>
#endif
|#
 |#
; #ifndef __NAMEREGISTRY__
#| #|
#include <CarbonCoreNameRegistry.h>
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
; *****************************************************************
;  *
;  *      Previously in Kernel.h
;  *
;  *****************************************************************
;  Kernel basics

(def-mactype :IOPreparationID (find-mactype '(:pointer :OpaqueIOPreparationID)))

(def-mactype :SoftwareInterruptID (find-mactype '(:pointer :OpaqueSoftwareInterruptID)))

(def-mactype :TaskID (find-mactype '(:pointer :OpaqueTaskID)))

(def-mactype :TimerID (find-mactype '(:pointer :OpaqueTimerID)))
;  Tasking

(def-mactype :ExecutionLevel (find-mactype ':UInt32))

(defconstant $kTaskLevel 0)
(defconstant $kSoftwareInterruptLevel 1)
(defconstant $kAcceptFunctionLevel 2)
(defconstant $kKernelLevel 3)
(defconstant $kSIHAcceptFunctionLevel 4)
(defconstant $kSecondaryInterruptLevel 5)
(defconstant $kHardwareInterruptLevel 6)
(defconstant $kMPTaskLevel 7)

(def-mactype :SoftwareInterruptHandler (find-mactype ':pointer)); (void * p1 , void * p2)

(def-mactype :SecondaryInterruptHandler2 (find-mactype ':pointer)); (void * p1 , void * p2)
; #define kCurrentAddressSpaceID ((AddressSpaceID) -1)
;  Memory System basics
(defrecord LogicalAddressRange
   (address (:pointer :void))
   (count :UInt32)
)

;type name? (%define-record :LogicalAddressRange (find-record-descriptor ':LogicalAddressRange))

(def-mactype :LogicalAddressRangePtr (find-mactype '(:pointer :LogicalAddressRange)))
(defrecord PhysicalAddressRange
   (address (:pointer :void))
   (count :UInt32)
)

;type name? (%define-record :PhysicalAddressRange (find-record-descriptor ':PhysicalAddressRange))

(def-mactype :PhysicalAddressRangePtr (find-mactype '(:pointer :PhysicalAddressRange)))
;  For PrepareMemoryForIO and CheckpointIO

(def-mactype :IOPreparationOptions (find-mactype ':UInt32))

(defconstant $kIOMultipleRanges 1)
(defconstant $kIOLogicalRanges 2)
(defconstant $kIOMinimalLogicalMapping 4)
(defconstant $kIOShareMappingTables 8)
(defconstant $kIOIsInput 16)
(defconstant $kIOIsOutput 32)
(defconstant $kIOCoherentDataPath 64)
(defconstant $kIOTransferIsLogical #x80)
(defconstant $kIOClientIsUserMode #x80)

(def-mactype :IOPreparationState (find-mactype ':UInt32))

(defconstant $kIOStateDone 1)

(defconstant $kInvalidPageAddress -1)
(defrecord AddressRange
   (base :pointer)
   (length :UInt32)
)

;type name? (%define-record :AddressRange (find-record-descriptor ':AddressRange))
;  C's treatment of arrays and array pointers is atypical

(def-mactype :LogicalMappingTablePtr (find-mactype '(:handle :void)))

(def-mactype :PhysicalMappingTablePtr (find-mactype '(:handle :void)))

(def-mactype :AddressRangeTablePtr (find-mactype '(:pointer :AddressRange)))
(defrecord MultipleAddressRange
   (entryCount :UInt32)
   (rangeTable (:pointer :AddressRange))
)

;type name? (%define-record :MultipleAddressRange (find-record-descriptor ':MultipleAddressRange))
; 
;    Separate C definition so that union has a name.  A future version of the interfacer
;    tool will allow a name (that gets thrown out in Pascal and Asm).
; 
(defrecord IOPreparationTable
   (options :UInt32)
   (state :UInt32)
   (preparationID (:pointer :OpaqueIOPreparationID))
   (addressSpace (:pointer :OpaqueMPAddressSpaceID))
   (granularity :UInt32)
   (firstPrepared :UInt32)
   (lengthPrepared :UInt32)
   (mappingEntryCount :UInt32)
   (logicalMapping (:Handle :void))
   (physicalMapping (:Handle :void))
   (:variant
   (
   (range :AddressRange)
   )
   (
   (multipleRanges :MultipleAddressRange)
   )
   )
)

;type name? (%define-record :IOPreparationTable (find-record-descriptor ':IOPreparationTable))

(def-mactype :IOCheckpointOptions (find-mactype ':UInt32))

(defconstant $kNextIOIsInput 1)
(defconstant $kNextIOIsOutput 2)
(defconstant $kMoreIOTransfers 4)
;  For SetProcessorCacheMode

(def-mactype :ProcessorCacheMode (find-mactype ':UInt32))

(defconstant $kProcessorCacheModeDefault 0)
(defconstant $kProcessorCacheModeInhibited 1)
(defconstant $kProcessorCacheModeWriteThrough 2)
(defconstant $kProcessorCacheModeCopyBack 3)
; 
;    For GetPageInformation
;    (Note: if kPageInformationVersion fails, try 0 -- old versions of DSL defined  kPageInformationVersion as 0)
; 

(defconstant $kPageInformationVersion 1)

(def-mactype :PageStateInformation (find-mactype ':UInt32))

(defconstant $kPageIsProtected 1)
(defconstant $kPageIsProtectedPrivileged 2)
(defconstant $kPageIsModified 4)
(defconstant $kPageIsReferenced 8)
(defconstant $kPageIsLockedResident 16)         ;  held and locked resident

(defconstant $kPageIsInMemory 32)
(defconstant $kPageIsShared 64)
(defconstant $kPageIsWriteThroughCached #x80)
(defconstant $kPageIsCopyBackCached #x100)
(defconstant $kPageIsHeldResident #x200)        ;  held resident - use kPageIsLockedResident to check for locked state

(defconstant $kPageIsLocked 16)                 ;  Deprecated

(defconstant $kPageIsResident 32)               ;  Deprecated

(defrecord PageInformation
   (area (:pointer :OpaqueAreaID))
   (count :UInt32)
   (information (:array :UInt32 1))
)

;type name? (%define-record :PageInformation (find-record-descriptor ':PageInformation))

(def-mactype :PageInformationPtr (find-mactype '(:pointer :PageInformation)))
;   Tasks  
; 
;  *  CurrentExecutionLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  CurrentTaskID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  DelayFor()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  InPrivilegedMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
;   Software Interrupts  
; 
;  *  CreateSoftwareInterrupt()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  SendSoftwareInterrupt()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  DeleteSoftwareInterrupt()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
;   Secondary Interrupts  
; 
;  *  CallSecondaryInterruptHandler2()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  QueueSecondaryInterruptHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
;   Timers  
; 
;  *  SetInterruptTimer()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  SetPersistentTimer()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  CancelTimer()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
;   I/O related Operations  
; 
;  *  PrepareMemoryForIO()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  CheckpointIO()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
;   Memory Operations  
; 
;  *  GetPageInformation()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
;   Processor Cache Related  
; 
;  *  SetProcessorCacheMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; *****************************************************************
;  *
;  *      Was in DriverSupport.h or DriverServices.h
;  *
;  *****************************************************************
(defconstant $kAAPLDeviceLogicalAddress "AAPL,address")
; #define kAAPLDeviceLogicalAddress "AAPL,address"

(def-mactype :DeviceLogicalAddressPtr (find-mactype '(:handle :void)))

(defconstant $durationMicrosecond -1)           ;  Microseconds are negative

(defconstant $durationMillisecond 1)            ;  Milliseconds are positive

(defconstant $durationSecond #x3E8)             ;  1000 * durationMillisecond

(defconstant $durationMinute #xEA60)            ;  60 * durationSecond,

(defconstant $durationHour #x36EE80)            ;  60 * durationMinute,

(defconstant $durationDay #x5265C00)            ;  24 * durationHour,

(defconstant $durationNoWait 0)                 ;  don't block

(defconstant $durationForever #x7FFFFFFF)       ;  no time limit


(defconstant $k8BitAccess 0)                    ;  access as 8 bit

(defconstant $k16BitAccess 1)                   ;  access as 16 bit

(defconstant $k32BitAccess 2)                   ;  access as 32 bit


(%define-record :Nanoseconds (find-record-descriptor ':UnsignedWide))
; 
;  *  IOCommandIsComplete()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  GetIOCommandInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  UpdateDeviceActivity()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  BlockCopy()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PoolAllocateResident()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PoolDeallocate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  GetLogicalPageSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  GetDataCacheLineSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  FlushProcessorCache()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  MemAllocatePhysicallyContiguous()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  MemDeallocatePhysicallyContiguous()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  UpTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_UpTime" 
   ((returnArg (:pointer :UnsignedWide))
    
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTimeBaseInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  
; 
;  *  AbsoluteToNanoseconds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_AbsoluteToNanoseconds" 
   ((returnArg (:pointer :UnsignedWide))
    (hi :UInt32)
    (lo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AbsoluteToDuration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_AbsoluteToDuration" 
   ((hi :UInt32)
    (lo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  NanosecondsToAbsolute()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_NanosecondsToAbsolute" 
   ((returnArg (:pointer :UnsignedWide))
    (hi :UInt32)
    (lo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DurationToAbsolute()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_DurationToAbsolute" 
   ((returnArg (:pointer :UnsignedWide))
    (duration :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AddAbsoluteToAbsolute()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_AddAbsoluteToAbsolute" 
   ((returnArg (:pointer :UnsignedWide))
    (hi :UInt32)
    (lo :UInt32)
    (hi :UInt32)
    (lo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SubAbsoluteFromAbsolute()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_SubAbsoluteFromAbsolute" 
   ((returnArg (:pointer :UnsignedWide))
    (hi :UInt32)
    (lo :UInt32)
    (hi :UInt32)
    (lo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AddNanosecondsToAbsolute()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_AddNanosecondsToAbsolute" 
   ((returnArg (:pointer :UnsignedWide))
    (hi :UInt32)
    (lo :UInt32)
    (hi :UInt32)
    (lo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AddDurationToAbsolute()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_AddDurationToAbsolute" 
   ((returnArg (:pointer :UnsignedWide))
    (duration :SInt32)
    (hi :UInt32)
    (lo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SubNanosecondsFromAbsolute()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_SubNanosecondsFromAbsolute" 
   ((returnArg (:pointer :UnsignedWide))
    (hi :UInt32)
    (lo :UInt32)
    (hi :UInt32)
    (lo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SubDurationFromAbsolute()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_SubDurationFromAbsolute" 
   ((returnArg (:pointer :UnsignedWide))
    (duration :SInt32)
    (hi :UInt32)
    (lo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AbsoluteDeltaToNanoseconds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_AbsoluteDeltaToNanoseconds" 
   ((returnArg (:pointer :UnsignedWide))
    (hi :UInt32)
    (lo :UInt32)
    (hi :UInt32)
    (lo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AbsoluteDeltaToDuration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_AbsoluteDeltaToDuration" 
   ((hi :UInt32)
    (lo :UInt32)
    (hi :UInt32)
    (lo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  DurationToNanoseconds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_DurationToNanoseconds" 
   ((returnArg (:pointer :UnsignedWide))
    (theDuration :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NanosecondsToDuration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_NanosecondsToDuration" 
   ((hi :UInt32)
    (lo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  PBQueueInit()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PBQueueCreate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PBQueueDelete()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PBEnqueue()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PBEnqueueLast()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PBDequeue()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PBDequeueFirst()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PBDequeueLast()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  CStrCopy()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PStrCopy()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  CStrNCopy()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PStrNCopy()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  CStrCat()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PStrCat()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  CStrNCat()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PStrNCat()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PStrToCStr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  CStrToPStr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  CStrCmp()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PStrCmp()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  CStrNCmp()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PStrNCmp()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  CStrLen()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  PStrLen()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  DeviceProbe()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  DelayForHardware()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; *****************************************************************
;  *
;  *      Was in Interrupts.h 
;  *
;  *****************************************************************
;   Interrupt types  

(def-mactype :InterruptSetID (find-mactype '(:pointer :OpaqueInterruptSetID)))

(def-mactype :InterruptMemberNumber (find-mactype ':signed-long))
(defrecord InterruptSetMember
   (setID (:pointer :OpaqueInterruptSetID))
   (member :signed-long)
)

;type name? (%define-record :InterruptSetMember (find-record-descriptor ':InterruptSetMember))

(defconstant $kISTChipInterruptSource 0)
(defconstant $kISTOutputDMAInterruptSource 1)
(defconstant $kISTInputDMAInterruptSource 2)
(defconstant $kISTPropertyMemberCount 3)
(defrecord ISTProperty
   (contents (:array :InterruptSetMember 3))
)
(defconstant $kISTPropertyName "driver-ist")
; #define kISTPropertyName    "driver-ist" 

(def-mactype :InterruptReturnValue (find-mactype ':signed-long))

(defconstant $kFirstMemberNumber 1)
(defconstant $kIsrIsComplete 0)
(defconstant $kIsrIsNotComplete -1)
(defconstant $kMemberNumberParent -2)

(def-mactype :InterruptSourceState (find-mactype ':Boolean))

(defconstant $kSourceWasEnabled $true)
(defconstant $kSourceWasDisabled $false)

(def-mactype :InterruptHandler (find-mactype ':pointer)); (InterruptSetMember ISTmember , void * refCon , UInt32 theIntCount)

(def-mactype :InterruptEnabler (find-mactype ':pointer)); (InterruptSetMember ISTmember , void * refCon)

(def-mactype :InterruptDisabler (find-mactype ':pointer)); (InterruptSetMember ISTmember , void * refCon)

(defconstant $kReturnToParentWhenComplete 1)
(defconstant $kReturnToParentWhenNotComplete 2)

(def-mactype :InterruptSetOptions (find-mactype ':UInt32))
;   Interrupt Services  
; 
;  *  CreateInterruptSet()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  InstallInterruptFunctions()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  GetInterruptFunctions()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  ChangeInterruptSetOptions()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  GetInterruptSetOptions()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __DRIVERSERVICES__ */


(provide-interface "DriverServices")