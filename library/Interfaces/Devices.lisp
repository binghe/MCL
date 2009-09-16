(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Devices.h"
; at Sunday July 2,2006 7:23:22 pm.
; 
;      File:       CarbonCore/Devices.h
;  
;      Contains:   Device Manager Interfaces.
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
; #ifndef __DEVICES__
; #define __DEVICES__
; #ifndef __OSUTILS__
#| #|
#include <CarbonCoreOSUtils.h>
#endif
|#
 |#
; #ifndef __FILES__
#| #|
#include <CarbonCoreFiles.h>
#endif
|#
 |#
; #ifndef __NAMEREGISTRY__

(require-interface "CarbonCore/NameRegistry")

; #endif

; #ifndef __CODEFRAGMENTS__
#| #|
#include <CarbonCoreCodeFragments.h>
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

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #pragma options align=mac68k
;  Values of the 'message' parameter to a Chooser device package 

(defconstant $chooserInitMsg 11)                ;  the user selected this device package 

(defconstant $newSelMsg 12)                     ;  the user made new device selections 

(defconstant $fillListMsg 13)                   ;  fill the device list with choices 

(defconstant $getSelMsg 14)                     ;  mark one or more choices as selected 

(defconstant $selectMsg 15)                     ;  the user made a selection 

(defconstant $deselectMsg 16)                   ;  the user canceled a selection 

(defconstant $terminateMsg 17)                  ;  allows device package to clean up 

(defconstant $buttonMsg 19)                     ;  the user selected a button 

;  Values of the 'caller' parameter to a Chooser device package 

(defconstant $chooserID 1)
;  Values of the 'message' parameter to a Monitor 'mntr' 

(defconstant $initMsg 1)                        ; initialization

(defconstant $okMsg 2)                          ; user clicked OK button

(defconstant $cancelMsg 3)                      ; user clicked Cancel button

(defconstant $hitMsg 4)                         ; user clicked control in Options dialog

(defconstant $nulMsg 5)                         ; periodic event

(defconstant $updateMsg 6)                      ; update event

(defconstant $activateMsg 7)                    ; not used

(defconstant $deactivateMsg 8)                  ; not used

(defconstant $keyEvtMsg 9)                      ; keyboard event

(defconstant $superMsg 10)                      ; show superuser controls

(defconstant $normalMsg 11)                     ; show only normal controls

(defconstant $startupMsg 12)                    ; code has been loaded

;  control codes for DeskAccessories 

(defconstant $goodbye -1)                       ;  heap being reinitialized 

(defconstant $killCode 1)                       ;  KillIO requested 

(defconstant $accEvent 64)                      ;  handle an event 

(defconstant $accRun 65)                        ;  time for periodic action 

(defconstant $accCursor 66)                     ;  change cursor shape 

(defconstant $accMenu 67)                       ;  handle menu item 

(defconstant $accUndo 68)                       ;  handle undo command 

(defconstant $accCut 70)                        ;  handle cut command 

(defconstant $accCopy 71)                       ;  handle copy command 

(defconstant $accPaste 72)                      ;  handle paste command 

(defconstant $accClear 73)                      ;  handle clear command 

;  Control/Status Call Codes 
;  drvStsCode, ejectCode and tgBuffCode are now defined in Disks.h/p/a 
;  miscellaneous Device Manager constants 

(defconstant $ioInProgress 1)                   ;  predefined value of ioResult while I/O is pending 

(defconstant $aRdCmd 2)                         ;  low byte of ioTrap for Read calls 

(defconstant $aWrCmd 3)                         ;  low byte of ioTrap for Write calls 

(defconstant $asyncTrpBit 10)                   ;  trap word modifier 

(defconstant $noQueueBit 9)                     ;  trap word modifier 

;  flags used in the driver header and device control entry 

(defconstant $dReadEnable 0)                    ;  set if driver responds to read requests 

(defconstant $dWritEnable 1)                    ;  set if driver responds to write requests 

(defconstant $dCtlEnable 2)                     ;  set if driver responds to control requests 

(defconstant $dStatEnable 3)                    ;  set if driver responds to status requests 

(defconstant $dNeedGoodBye 4)                   ;  set if driver needs time for performing periodic tasks 

(defconstant $dNeedTime 5)                      ;  set if driver needs time for performing periodic tasks 

(defconstant $dNeedLock 6)                      ;  set if driver must be locked in memory as soon as it is opened 


(defconstant $dNeedLockMask #x4000)             ;  set if driver must be locked in memory as soon as it is opened 

(defconstant $dNeedTimeMask #x2000)             ;  set if driver needs time for performing periodic tasks 

(defconstant $dNeedGoodByeMask #x1000)          ;  set if driver needs to be called before the application heap is initialized 

(defconstant $dStatEnableMask #x800)            ;  set if driver responds to status requests 

(defconstant $dCtlEnableMask #x400)             ;  set if driver responds to control requests 

(defconstant $dWritEnableMask #x200)            ;  set if driver responds to write requests 

(defconstant $dReadEnableMask #x100)            ;  set if driver responds to read requests 

;  run-time flags used in the device control entry 

(defconstant $dVMImmuneBit 0)                   ;  driver does not need VM protection 

(defconstant $dOpened 5)                        ;  driver is open 

(defconstant $dRAMBased 6)                      ;  dCtlDriver is a handle (1) or pointer (0) 

(defconstant $drvrActive 7)                     ;  driver is currently processing a request 


(defconstant $dVMImmuneMask 1)                  ;  driver does not need VM protection 

(defconstant $dOpenedMask 32)                   ;  driver is open 

(defconstant $dRAMBasedMask 64)                 ;  dCtlDriver is a handle (1) or pointer (0) 

(defconstant $drvrActiveMask #x80)              ;  driver is currently processing a request 

(defrecord DRVRHeader
   (drvrFlags :SInt16)
   (drvrDelay :SInt16)
   (drvrEMask :SInt16)
   (drvrMenu :SInt16)
   (drvrOpen :SInt16)
   (drvrPrime :SInt16)
   (drvrCtl :SInt16)
   (drvrStatus :SInt16)
   (drvrClose :SInt16)
   (drvrName (:array :UInt8 1))
)

;type name? (%define-record :DRVRHeader (find-record-descriptor ':DRVRHeader))

(def-mactype :DRVRHeaderPtr (find-mactype '(:pointer :DRVRHeader)))

(def-mactype :DRVRHeaderHandle (find-mactype '(:handle :DRVRHeader)))
;   The NDRV Driver IO Entry Point and Commands 

(def-mactype :UnitNumber (find-mactype ':UInt16))

(def-mactype :DriverOpenCount (find-mactype ':UInt32))

(def-mactype :DriverRefNum (find-mactype ':SInt16))

(def-mactype :DriverFlags (find-mactype ':SInt16))

(def-mactype :IOCommandCode (find-mactype ':UInt32))

(defconstant $kOpenCommand 0)
(defconstant $kCloseCommand 1)
(defconstant $kReadCommand 2)
(defconstant $kWriteCommand 3)
(defconstant $kControlCommand 4)
(defconstant $kStatusCommand 5)
(defconstant $kKillIOCommand 6)
(defconstant $kInitializeCommand 7)             ;  init driver and device

(defconstant $kFinalizeCommand 8)               ;  shutdown driver and device

(defconstant $kReplaceCommand 9)                ;  replace an old driver

(defconstant $kSupersededCommand 10)            ;  prepare to be replaced by a new driver

(defconstant $kSuspendCommand 11)               ;  prepare driver to go to sleep

(defconstant $kResumeCommand 12)                ;  wake up sleeping driver

;  one more IOCommandCode

(defconstant $kPowerManagementCommand 13)       ;  power management command, supercedes kSuspendCommand and kResumeCommand


(def-mactype :AddressSpaceID (find-mactype ':MPAddressSpaceID))

(def-mactype :IOCommandID (find-mactype '(:pointer :OpaqueIOCommandID)))
; 
;  *  HigherDriverVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  VerifyFragmentAsDriver()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  GetDriverMemoryFragment()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  GetDriverDiskFragment()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  GetNamedDriverDiskFragment()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 2.0 and later
;  
; 
;  *  InstallDriverFromFragment()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  InstallDriverFromFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  InstallDriverFromMemory()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  InstallDriverFromResource()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 2.0 and later
;  
; 
;  *  InstallDriverFromDisk()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  FindDriversForDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  FindDriverForDeviceFromFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 2.0 and later
;  
; 
;  *  FindDriverCandidates()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  FindDriverCandidatesDetailed()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 2.0 and later
;  
; 
;  *  ScanDriverCandidates()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  ScanDriverCandidatesDetailed()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 2.0 and later
;  
; 
;  *  CompareFileCandToPropCand()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 2.0 and later
;  
; 
;  *  GetCompatibleProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 2.0 and later
;  
; 
;  *  CompatibleDriverNames()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 2.0 and later
;  
; 
;  *  GetDriverForDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  InstallDriverForDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  GetDriverInformation()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  GetDriverDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 2.0 and later
;  
; 
;  *  GetNamedDriverDescFromFSSpec()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 2.0 and later
;  
; 
;  *  SetDriverClosureMemory()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  ReplaceDriverWithFragment()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  OpenInstalledDriver()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  RenameDriver()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  RemoveDriver()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  LookupDrivers()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  HighestUnitNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  DriverGestaltOn()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  DriverGestaltOff()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  DriverGestaltIsOn()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverLoaderLib 1.0 and later
;  
; 
;  *  PBOpenSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBOpenAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBOpenImmed()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBCloseSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBCloseSync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCloseAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBCloseAsync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCloseImmed()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBReadSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBReadSync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBReadAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBReadAsync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBReadImmed()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBWriteSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBWriteSync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBWriteAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBWriteAsync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBWriteImmed()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;     PBWaitIOComplete is a friendly way for applications to monitor
;     a pending asynchronous I/O operation in power-managed and
;     preemptive multitasking systems.
;  
; 
;  *  PBWaitIOComplete()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBWaitIOComplete" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
    (timeout :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  AddDrive and GetDrvQHdr are now defined in Disks.h/p/a 
; 
;  *  GetDCtlEntry()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;     SetChooserAlert used to simply set a bit in a low-mem global
;     to tell the Chooser not to display its warning message when
;     the printer is changed. However, under MultiFinder and System 7,
;     this low-mem is swapped out when a layer change occurs, and the
;     Chooser never sees the change. It is obsolete, and completely
;     unsupported on the PowerPC. 68K apps can still call it if they
;     wish.
;     
;     pascal Boolean SetChooserAlert(Boolean f);
; 
; 
; 
;  *  DriverInstall()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  DriverInstallReserveMem()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;   Note: DrvrInstall() is no longer supported, becuase it never really worked anyways.
;         There will soon be a DriverInstall() which does the right thing.
; 
;         DrvrRemove has been renamed to DriverRemove.  But, InterfaceLib for PowerPC
;         still exports DrvrRemove, so a macro is used to map the new name to old.
; 
; 
; 
;  *  DrvrRemove()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; #define DriverRemove(refNum) DrvrRemove(refNum)
; 
;     Shim mechnanism only exist in Maxwell world.  A Shim is a translation layer
;     and looks like a DRVR. 
; 

(def-mactype :ShimEntryPoint (find-mactype ':pointer)); (Ptr paramBlock , Ptr refcon)
; 
;  *  DriverInstallShim()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  DriverRemoveShim()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  DriverReturnShimRefcon()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  IOShimCommandIsComplete()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  [Mac]OpenDriver()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  [Mac]CloseDriver()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  Control()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  Status()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  KillIO()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  Fetch()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  Stash()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  IODone()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  PBControlSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBControlAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBControlImmed()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBStatusSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBStatusAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBStatusImmed()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBKillIOSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBKillIOAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBKillIOImmed()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  OpenDeskAcc()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  CloseDeskAcc()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  opendeskacc()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  opendriver()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;     The PBxxx() routines are obsolete.  
;     
;     Use the PBxxxSync(), PBxxxAsync(), or PBxxxImmed version instead.
; 
; #define PBControl(pb, async) ((async) ? PBControlAsync(pb) : PBControlSync(pb))
; #define PBStatus(pb, async) ((async) ? PBStatusAsync(pb) : PBStatusSync(pb))
; #define PBKillIO(pb, async) ((async) ? PBKillIOAsync(pb) : PBKillIOSync(pb))
; #define PBOpen(pb, async) ((async) ? PBOpenAsync(pb) : PBOpenSync(pb))
; #define PBClose(pb, async) ((async) ? PBCloseAsync(pb) : PBCloseSync(pb))
; #define PBRead(pb, async) ((async) ? PBReadAsync(pb) : PBReadSync(pb))
; #define PBWrite(pb, async) ((async) ? PBWriteAsync(pb) : PBWriteSync(pb))
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __DEVICES__ */


(provide-interface "Devices")