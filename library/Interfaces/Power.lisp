(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Power.h"
; at Sunday July 2,2006 7:23:32 pm.
; 
;      File:       OSServices/Power.h
;  
;      Contains:   Power Manager Interfaces.
;  
;      Version:    OSServices-62.7~16
;  
;      Copyright:  © 1990-2003 by Apple Computer, Inc.  All rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __POWER__
; #define __POWER__
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
; #ifndef __MULTIPROCESSING__
#| #|
#include <CarbonCoreMultiprocessing.h>
#endif
|#
 |#
; #ifndef __NAMEREGISTRY__
#| #|
#include <CarbonCoreNameRegistry.h>
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
;  Bit positions for ModemByte 

(defconstant $modemOnBit 0)
(defconstant $ringWakeUpBit 2)
(defconstant $modemInstalledBit 3)
(defconstant $ringDetectBit 4)
(defconstant $modemOnHookBit 5)
;  masks for ModemByte 

(defconstant $modemOnMask 1)
(defconstant $ringWakeUpMask 4)
(defconstant $modemInstalledMask 8)
(defconstant $ringDetectMask 16)
(defconstant $modemOnHookMask 32)
;  bit positions for BatteryByte 

(defconstant $chargerConnBit 0)
(defconstant $hiChargeBit 1)
(defconstant $chargeOverFlowBit 2)
(defconstant $batteryDeadBit 3)
(defconstant $batteryLowBit 4)
(defconstant $connChangedBit 5)
;  masks for BatteryByte 

(defconstant $chargerConnMask 1)
(defconstant $hiChargeMask 2)
(defconstant $chargeOverFlowMask 4)
(defconstant $batteryDeadMask 8)
(defconstant $batteryLowMask 16)
(defconstant $connChangedMask 32)
;  bit positions for SoundMixerByte 

(defconstant $MediaBaySndEnBit 0)
(defconstant $PCISndEnBit 1)
(defconstant $ZVSndEnBit 2)
(defconstant $PCCardSndEnBit 3)
;  masks for SoundMixerByte 

(defconstant $MediaBaySndEnMask 1)
(defconstant $PCISndEnMask 2)
(defconstant $ZVSndEnMask 4)
(defconstant $PCCardSndEnMask 8)
;  commands to SleepQRec sleepQProc 

(defconstant $kSleepRequest 1)
(defconstant $kSleepDemand 2)
(defconstant $kSleepWakeUp 3)
(defconstant $kSleepRevoke 4)
(defconstant $kSleepUnlock 4)
(defconstant $kSleepDeny 5)                     ;  A non-zero value clients can use to deny requests

(defconstant $kSleepNow 6)
(defconstant $kDozeDemand 7)
(defconstant $kDozeWakeUp 8)
(defconstant $kDozeRequest 9)                   ;  additional messages for Power Mgr 2.0

(defconstant $kEnterStandby 10)                 ;  Idle Queue Only

(defconstant $kEnterRun 11)                     ;  Idle Queue Only

(defconstant $kSuspendRequest 12)
(defconstant $kSuspendDemand 13)
(defconstant $kSuspendRevoke 14)
(defconstant $kSuspendWakeUp 15)
(defconstant $kGetPowerLevel 16)
(defconstant $kSetPowerLevel 17)
(defconstant $kDeviceInitiatedWake 18)
(defconstant $kWakeToDoze 19)
(defconstant $kDozeToFullWakeUp 20)
(defconstant $kGetPowerInfo 21)
(defconstant $kGetWakeOnNetInfo 22)
(defconstant $kSuspendWakeToDoze 23)
(defconstant $kEnterIdle 24)                    ;  Idle Queue Only

(defconstant $kStillIdle 25)                    ;  Idle Queue Only

(defconstant $kExitIdle 26)                     ;  Idle Queue Only

;  depreciated commands to SleepQRec sleepQProc 

(defconstant $sleepRequest 1)
(defconstant $sleepDemand 2)
(defconstant $sleepWakeUp 3)
(defconstant $sleepRevoke 4)
(defconstant $sleepUnlock 4)
(defconstant $sleepDeny 5)
(defconstant $sleepNow 6)
(defconstant $dozeDemand 7)
(defconstant $dozeWakeUp 8)
(defconstant $dozeRequest 9)
(defconstant $enterStandby 10)
(defconstant $enterRun 11)
(defconstant $suspendRequestMsg 12)
(defconstant $suspendDemandMsg 13)
(defconstant $suspendRevokeMsg 14)
(defconstant $suspendWakeUpMsg 15)
(defconstant $getPowerLevel 16)
(defconstant $setPowerLevel 17)
;  Power Handler func messages 

(def-mactype :PowerLevel (find-mactype ':UInt32))
;  Power levels corresponding to PCI Bus Power Management Interface Spec (PMIS) 

(defconstant $kPMDevicePowerLevel_On 0)         ;  fully-powered 'On' state (D0 state)    

(defconstant $kPMDevicePowerLevel_D1 1)         ;  not used by Apple system SW         

(defconstant $kPMDevicePowerLevel_D2 2)         ;  not used by Apple system SW         

(defconstant $kPMDevicePowerLevel_Off 3)        ;  main PCI bus power 'Off', but PCI standby power available (D3cold state) 

;  PowerHandlerProc definition 

(def-mactype :PowerHandlerProcPtr (find-mactype ':pointer)); (UInt32 message , void * param , UInt32 refCon , RegEntryID * regEntryID)

(def-mactype :PowerHandlerUPP (find-mactype '(:pointer :OpaquePowerHandlerProcPtr)))
; 
;  *  NewPowerHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposePowerHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokePowerHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;    Use kIdleQueueDeviceType as the deviceType argument to AddDevicePowerHandler() to get the
;    handler into the idle queue instead of the device sleep queue.
; 
(defconstant $kIdleQueueDeviceType "idle-queue")
; #define kIdleQueueDeviceType    "idle-queue"
;  PCI power management support

(defconstant $kUseDefaultMinimumWakeTime 0)     ;  Defaults to 5 minutes

(defconstant $kPowerSummaryVersion 1)           ;  Version of PowerSummary structure.

(defconstant $kDevicePowerInfoVersion 1)        ;  Version of DevicePowerInfo structure.

;  PowerSummary flags
;  PCI power off is allowed.

(defconstant $kPCIPowerOffAllowed 1)
;  DevicePowerInfo flags

(defconstant $kDevicePCIPowerOffAllowed 1)      ;  PCI power off is allowed for device.

(defconstant $kDeviceSupportsPMIS 2)            ;  Device supports Power Mgt Interface Spec.

(defconstant $kDeviceCanAssertPMEDuringSleep 4) ;  Device can assert PME# during sleep.

(defconstant $kDeviceUsesCommonLogicPower 8)    ;  Device uses common-logic power

(defconstant $kDeviceDriverPresent 16)          ;  Driver present for device.
;  Driver installed a power handler.

(defconstant $kDeviceDriverSupportsPowerMgt 32)
(defrecord DevicePowerInfo
   (version :UInt32)                            ;  Version of this structure.
   (regID :RegEntryID)                          ;  RegEntryID for device.
   (flags :UInt32)                              ;  Flags
   (minimumWakeTime :UInt32)                    ;  Minimum seconds before sleeping again.
   (sleepPowerNeeded :UInt32)                   ;  Milliwatts needed in the sleep state.
)

;type name? (%define-record :DevicePowerInfo (find-record-descriptor ':DevicePowerInfo))
(defrecord PowerSummary
   (version :UInt32)                            ;  Version of this structure.
   (flags :UInt32)                              ;  Flags
   (sleepPowerAvailable :UInt32)                ;  Milliwatts available during sleep.
   (sleepPowerNeeded :UInt32)                   ;  Milliwatts needed during sleep.
   (minimumWakeTime :UInt32)                    ;  Minimum seconds before sleeping again.
   (deviceCount :UInt32)                        ;  Number of device power info records.
   (devices (:array :DevicePowerInfo 1))        ;  Array of device power info records.
)

;type name? (%define-record :PowerSummary (find-record-descriptor ':PowerSummary))
;  SleepQRec.sleepQFlags 

(defconstant $noCalls 1)
(defconstant $noRequest 2)
(defconstant $slpQType 16)
(defconstant $sleepQType 16)
;  Power Mgt Apple Event types and errors 
;  power mgt class

(defconstant $kAEMacPowerMgtEvt :|pmgt|)        ;  event ids

(defconstant $kAEMacToWake :|wake|)
(defconstant $kAEMacLowPowerSaveData :|pmsd|)
(defconstant $kAEMacEmergencySleep :|emsl|)
(defconstant $kAEMacEmergencyShutdown :|emsd|)
; 
;    These are result values returned by a Power Handler when queries
;    by the Power Mgr if the device which that Power Handler represents
;    woke the machine.
; 

(defconstant $kDeviceDidNotWakeMachine 0)       ;  device did NOT wake machine

(defconstant $kDeviceRequestsFullWake 1)        ;  device did wake machine and requests full wakeup

(defconstant $kDeviceRequestsWakeToDoze 2)      ;  device did wake machine and requests partial wakeup

;  bits in bitfield returned by PMFeatures 

(defconstant $hasWakeupTimer 0)                 ;  1=wakeup timer is supported                    

(defconstant $hasSharedModemPort 1)             ;  1=modem port shared by SCC and internal modem       

(defconstant $hasProcessorCycling 2)            ;  1=processor cycling is supported                

(defconstant $mustProcessorCycle 3)             ;  1=processor cycling should not be turned off          

(defconstant $hasReducedSpeed 4)                ;  1=processor can be started up at reduced speed        

(defconstant $dynamicSpeedChange 5)             ;  1=processor speed can be switched dynamically       

(defconstant $hasSCSIDiskMode 6)                ;  1=SCSI Disk Mode is supported                 

(defconstant $canGetBatteryTime 7)              ;  1=battery time can be calculated                

(defconstant $canWakeupOnRing 8)                ;  1=can wakeup when the modem detects a ring          

(defconstant $hasDimmingSupport 9)              ;  1=has dimming support built in (DPMS standby by default)   

(defconstant $hasStartupTimer 10)               ;  1=startup timer is supported                    

(defconstant $hasChargeNotification 11)         ;  1=client can determine of charge connect status change notifications available 

(defconstant $hasDimSuspendSupport 12)          ;  1=supports dimming LCD and CRT to DPMS suspend state     

(defconstant $hasWakeOnNetActivity 13)          ;  1=hardware supports wake on network activity          

(defconstant $hasWakeOnLid 14)                  ;  1=hardware can wake when opened                   

(defconstant $canPowerOffPCIBus 15)             ;  1=hardware can power off PCI bus during sleep if cards allow 

(defconstant $hasDeepSleep 16)                  ;  1=hardware supports deep sleep (hibernation) mode   

(defconstant $hasSleep 17)                      ;  1=hardware supports normal (PowerBook-like) sleep   

(defconstant $supportsServerModeAPIs 18)        ;  1=hardware supports server mode API routines          

(defconstant $supportsUPSIntegration 19)        ;  1=hardware support UPS integration and reporting      

(defconstant $hasAggressiveIdling 20)           ;  1=Power Manager only resets OverallAct on UsrActvity     

(defconstant $supportsIdleQueue 21)             ;  1=Power Manager supports the idle queue              

;  bits in bitfield returned by GetIntModemInfo and set by SetIntModemState 

(defconstant $hasInternalModem 0)               ;  1=internal modem installed               

(defconstant $intModemRingDetect 1)             ;  1=internal modem has detected a ring          

(defconstant $intModemOffHook 2)                ;  1=internal modem is off hook               

(defconstant $intModemRingWakeEnb 3)            ;  1=wakeup on ring is enabled                 

(defconstant $extModemSelected 4)               ;  1=external modem selected             

(defconstant $modemSetBit 15)                   ;  1=set bit, 0=clear bit (SetIntModemState)   

;  bits in BatteryInfo.flags                                    
;  ("chargerConnected" doesn't mean the charger is plugged in)  

(defconstant $batteryInstalled 7)               ;  1=battery is currently connected             

(defconstant $batteryCharging 6)                ;  1=battery is being charged               

(defconstant $chargerConnected 5)               ;  1=charger is connected to the PowerBook         

(defconstant $upsConnected 4)                   ;  1=there is a UPS connected               

(defconstant $upsIsPowerSource 3)               ;  1=UPS is source of power                


(defconstant $HDPwrQType #x4844)                ;  'HD' hard disk spindown queue element type     

(defconstant $PMgrStateQType #x504D)            ;  'PM' Power Manager state queue element type       

;  client notification bits in PMgrQueueElement.pmNotifyBits 

(defconstant $pmSleepTimeoutChanged 0)
(defconstant $pmSleepEnableChanged 1)
(defconstant $pmHardDiskTimeoutChanged 2)
(defconstant $pmHardDiskSpindownChanged 3)
(defconstant $pmDimmingTimeoutChanged 4)
(defconstant $pmDimmingEnableChanged 5)
(defconstant $pmDiskModeAddressChanged 6)
(defconstant $pmProcessorCyclingChanged 7)
(defconstant $pmProcessorSpeedChanged 8)
(defconstant $pmWakeupTimerChanged 9)
(defconstant $pmStartupTimerChanged 10)
(defconstant $pmHardDiskPowerRemovedbyUser 11)
(defconstant $pmChargeStatusChanged 12)
(defconstant $pmPowerLevelChanged 13)
(defconstant $pmWakeOnNetActivityChanged 14)

(defconstant $pmSleepTimeoutChangedMask 1)
(defconstant $pmSleepEnableChangedMask 2)
(defconstant $pmHardDiskTimeoutChangedMask 4)
(defconstant $pmHardDiskSpindownChangedMask 8)
(defconstant $pmDimmingTimeoutChangedMask 16)
(defconstant $pmDimmingEnableChangedMask 32)
(defconstant $pmDiskModeAddressChangedMask 64)
(defconstant $pmProcessorCyclingChangedMask #x80)
(defconstant $pmProcessorSpeedChangedMask #x100)
(defconstant $pmWakeupTimerChangedMask #x200)
(defconstant $pmStartupTimerChangedMask #x400)
(defconstant $pmHardDiskPowerRemovedbyUserMask #x800)
(defconstant $pmChargeStatusChangedMask #x1000)
(defconstant $pmPowerLevelChangedMask #x2000)
(defconstant $pmWakeOnNetActivityChangedMask #x4000)
;  System Activity Selectors 
;  Notes:  The IdleActivity selector is not available unless the hasAggressiveIdling PMFeatures bit is set. 
;          Use IdleActivity where you used to use OverallAct if necessary.  OverallAct will only            
;          delay power cycling if it's enabled, and will delay sleep by a small amount when                 
;          hasAggressiveIdling is set.  Don't use IdleActivity unless hasAggressiveIdling is set; when      
;          hasAggressiveIdling is not set, the use of IdleActivity is undefined, and well do different      
;          things depending on which Power Manager is currently running.                                    

(defconstant $OverallAct 0)                     ;  Delays idle sleep by small amount                 

(defconstant $UsrActivity 1)                    ;  Delays idle sleep and dimming by timeout time          

(defconstant $NetActivity 2)                    ;  Delays idle sleep and power cycling by small amount         

(defconstant $HDActivity 3)                     ;  Delays hard drive spindown and idle sleep by small amount  

(defconstant $IdleActivity 4)                   ;  Delays idle sleep by timeout time                 

;  Storage Media sleep mode defines 

(defconstant $kMediaModeOn 0)                   ;  Media active (Drive spinning and at full power)    

(defconstant $kMediaModeStandBy 1)              ;  Media standby (not implemented)    

(defconstant $kMediaModeSuspend 2)              ;  Media Idle (not implemented)   

(defconstant $kMediaModeOff 3)                  ;  Media Sleep (Drive not spinning and at min power, max recovery time)   


(defconstant $kMediaPowerCSCode 70)
;  definitions for HDQueueElement.hdFlags   

(defconstant $kHDQueuePostBit 0)                ;  1 = call this routine on the second pass     

(defconstant $kHDQueuePostMask 1)
(defrecord ActivityInfo
   (ActivityType :SInt16)                       ;  Type of activity to be fetched.  Same as UpdateSystemActivity Selectors 
   (ActivityTime :UInt32)                       ;  Time of last activity (in ticks) of specified type. 
)

;type name? (%define-record :ActivityInfo (find-record-descriptor ':ActivityInfo))
;  information returned by GetScaledBatteryInfo 
(defrecord BatteryInfo
   (flags :UInt8)                               ;  misc flags (see below)                  
   (warningLevel :UInt8)                        ;  scaled warning level (0-255)               
   (reserved :UInt8)                            ;  reserved for internal use             
   (batteryLevel :UInt8)                        ;  scaled battery level (0-255)               
)

;type name? (%define-record :BatteryInfo (find-record-descriptor ':BatteryInfo))

(def-mactype :ModemByte (find-mactype ':SInt8))

(def-mactype :BatteryByte (find-mactype ':SInt8))

(def-mactype :SoundMixerByte (find-mactype ':SInt8))

(def-mactype :PMResultCode (find-mactype ':signed-long))

;type name? (def-mactype :SleepQRec (find-mactype ':SleepQRec))

(def-mactype :SleepQRecPtr (find-mactype '(:pointer :SleepQRec)))

;type name? (def-mactype :HDQueueElement (find-mactype ':HDQueueElement))

;type name? (def-mactype :PMgrQueueElement (find-mactype ':PMgrQueueElement))

(def-mactype :SleepQProcPtr (find-mactype ':pointer)); (long message , SleepQRecPtr qRecPtr)

(def-mactype :HDSpindownProcPtr (find-mactype ':pointer)); (HDQueueElement * theElement)

(def-mactype :PMgrStateChangeProcPtr (find-mactype ':pointer)); (PMgrQueueElement * theElement , long stateBits)

(def-mactype :SleepQUPP (find-mactype '(:pointer :OpaqueSleepQProcPtr)))

(def-mactype :HDSpindownUPP (find-mactype '(:pointer :OpaqueHDSpindownProcPtr)))

(def-mactype :PMgrStateChangeUPP (find-mactype '(:pointer :OpaquePMgrStateChangeProcPtr)))
(defrecord SleepQRec
   (sleepQLink (:pointer :SleepQRec))           ;  pointer to next queue element          
   (sleepQType :SInt16)                         ;  queue element type (must be SleepQType)       
   (sleepQProc (:pointer :OpaqueSleepQProcPtr)) ;  pointer to sleep universal proc ptr         
   (sleepQFlags :SInt16)                        ;  flags                       
)
(defrecord HDQueueElement
   (hdQLink (:pointer :HDQueueElement))         ;  pointer to next queue element          
   (hdQType :SInt16)                            ;  queue element type (must be HDPwrQType)       
   (hdFlags :SInt16)                            ;  miscellaneous flags                   
   (hdProc (:pointer :OpaqueHDSpindownProcPtr)) ;  pointer to routine to call           
   (hdUser :signed-long)                        ;  user-defined (variable storage, etc.)   
)
(defrecord PMgrQueueElement
   (pmQLink (:pointer :PMgrQueueElement))       ;  pointer to next queue element          
   (pmQType :SInt16)                            ;  queue element type (must be PMgrStateQType)    
   (pmFlags :SInt16)                            ;  miscellaneous flags                   
   (pmNotifyBits :signed-long)                  ;  bitmap of which changes to be notified for 
   (pmProc (:pointer :OpaquePMgrStateChangeProcPtr));  pointer to routine to call           
   (pmUser :signed-long)                        ;  user-defined (variable storage, etc.)   
)
(defrecord BatteryTimeRec
   (expectedBatteryTime :UInt32)                ;  estimated battery time remaining (seconds) 
   (minimumBatteryTime :UInt32)                 ;  minimum battery time remaining (seconds)     
   (maximumBatteryTime :UInt32)                 ;  maximum battery time remaining (seconds)     
   (timeUntilCharged :UInt32)                   ;  time until battery is fully charged (seconds)
)

;type name? (%define-record :BatteryTimeRec (find-record-descriptor ':BatteryTimeRec))
(defrecord WakeupTime
   (wakeTime :UInt32)                           ;  wakeup time (same format as current time)   
   (wakeEnabled :Boolean)                       ;  1=enable wakeup timer, 0=disable wakeup timer  
   (filler :SInt8)
)

;type name? (%define-record :WakeupTime (find-record-descriptor ':WakeupTime))
(defrecord StartupTime
   (startTime :UInt32)                          ;  startup time (same format as current time)     
   (startEnabled :Boolean)                      ;  1=enable startup timer, 0=disable startup timer    
   (filler :SInt8)
)

;type name? (%define-record :StartupTime (find-record-descriptor ':StartupTime))
;  PowerSource version

(defconstant $kVersionOnePowerSource 1)
(defconstant $kVersionTwoPowerSource 2)
(defconstant $kCurrentPowerSourceVersion 2)
;  PowerSourceAttrs bits

(defconstant $bSourceIsBattery 0)               ;  power source is battery

(defconstant $bSourceIsAC 1)                    ;  power source is AC

(defconstant $bSourceCanBeCharged 2)            ;  power source can be charged

(defconstant $bSourceIsUPS 3)                   ;  power source is UPS. NOTE: software should set bSourceIsBattery and bSourceIsAC also, as appropriate

(defconstant $bSourceProvidesWarnLevels 4)      ;  power source provides low power and dead battery warning levels

(defconstant $kSourceIsBatteryMask 1)
(defconstant $kSourceIsACMask 2)
(defconstant $kSourceCanBeChargedMask 4)
(defconstant $kSourceIsUPSMask 8)
(defconstant $kSourceProvidesWarnLevelsMask 16)
;  PowerSourceFlags bits

(defconstant $bSourceIsAvailable 0)             ;  power source is installed

(defconstant $bSourceIsCharging 1)              ;  power source being charged

(defconstant $bChargerIsAttached 2)             ;  a charger is connected

(defconstant $kSourceIsAvailableMask 1)
(defconstant $kSourceIsChargingMask 2)
(defconstant $kChargerIsAttachedMask 4)
;  Power Capacity Types

(defconstant $kCapacityIsActual 0)              ;  current capacity is expessed as actual capacity in same units as max

(defconstant $kCapacityIsPercentOfMax 1)        ;  current capacity is expressed as a percentage of maximumCapacity

;  Net Activity Wake Options

(defconstant $kConfigSupportsWakeOnNetBit 0)
(defconstant $kWakeOnNetAdminAccessesBit 1)
(defconstant $kWakeOnAllNetAccessesBit 2)
(defconstant $kUnmountServersBeforeSleepingBit 3)
(defconstant $kConfigSupportsWakeOnNetMask 1)
(defconstant $kWakeOnNetAdminAccessesMask 2)
(defconstant $kWakeOnAllNetAccessesMask 4)
(defconstant $kUnmountServersBeforeSleepingMask 8)
;  Power Source capacity usage types

(defconstant $kCurrentCapacityIsActualValue 0)  ;  currentCapacity is a real value in same units as maxCapacity

(defconstant $kCurrentCapacityIsPercentOfMax 1) ;  currentCapacity is expressed as a percentage of maxCapacity.


(def-mactype :PowerSourceID (find-mactype ':SInt16))
(defrecord PowerSourceParamBlock
   (sourceID :SInt16)                           ;  unique id assigned by Power Mgr
   (sourceCapacityUsage :UInt16)                ;  how currentCapacity is used
   (sourceVersion :UInt32)                      ;  version of this record
   (sourceAttr :UInt32)                         ;  attribute flags (see below)
   (sourceState :UInt32)                        ;  state flags (see below)
   (currentCapacity :UInt32)                    ;  current capacity, in
                                                ;    milliwatts or %
   (maxCapacity :UInt32)                        ;  full capacity, in milliwatts
   (timeRemaining :UInt32)                      ;  time left to deplete, 
                                                ;    in milliwatt-hours
   (timeToFullCharge :UInt32)                   ;  time to charge, 
                                                ;    in milliwatt-hours
   (voltage :UInt32)                            ;  voltage in millivolts
   (current :SInt32)                            ;  current in milliamperes 
                                                ;   (negative if consuming, 
                                                ;    positive if charging)
   (lowWarnLevel :UInt32)                       ;  low warning level in milliwatts (or % if sourceCapacityUsage is %)
   (deadWarnLevel :UInt32)                      ;  dead warning level in milliwatts (or % if sourceCapacityUsage is %)
   (reserved (:array :UInt32 16))               ;  for future expansion
)

;type name? (%define-record :PowerSourceParamBlock (find-record-descriptor ':PowerSourceParamBlock))

(def-mactype :PowerSourceParamBlockPtr (find-mactype '(:pointer :PowerSourceParamBlock)))
; 
;  *  DisableWUTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisableWUTime" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetWUTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetWUTime" 
   ((wuTime :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetWUTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetWUTime" 
   ((wuTime (:pointer :long))
    (wuFlag (:pointer :Byte))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  BatteryStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_BatteryStatus" 
   ((status (:pointer :Byte))
    (power (:pointer :Byte))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ModemStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ModemStatus" 
   ((status (:pointer :Byte))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  IdleUpdate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_IdleUpdate" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetCPUSpeed()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetCPUSpeed" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  EnableIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_EnableIdle" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisableIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisableIdle" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SleepQInstall()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SleepQInstall" 
   ((qRecPtr (:pointer :SLEEPQREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SleepQRemove()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SleepQRemove" 
   ((qRecPtr (:pointer :SLEEPQREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AOn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AOn" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AOnIgnoreModem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AOnIgnoreModem" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  BOn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_BOn" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AOff()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AOff" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  BOff()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_BOff" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  Public Power Management API  
; 
;  *  PMSelectorCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_PMSelectorCount" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  PMFeatures()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_PMFeatures" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetSleepTimeout()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_GetSleepTimeout" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt8
() )
; 
;  *  SetSleepTimeout()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_SetSleepTimeout" 
   ((timeout :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetHardDiskTimeout()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_GetHardDiskTimeout" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt8
() )
; 
;  *  SetHardDiskTimeout()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_SetHardDiskTimeout" 
   ((timeout :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HardDiskPowered()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_HardDiskPowered" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SpinDownHardDisk()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_SpinDownHardDisk" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  IsSpindownDisabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_IsSpindownDisabled" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SetSpindownDisable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_SetSpindownDisable" 
   ((setDisable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HardDiskQInstall()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_HardDiskQInstall" 
   ((theElement (:pointer :HDQUEUEELEMENT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HardDiskQRemove()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_HardDiskQRemove" 
   ((theElement (:pointer :HDQUEUEELEMENT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetScaledBatteryInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_GetScaledBatteryInfo" 
   ((whichBattery :SInt16)
    (theInfo (:pointer :BatteryInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AutoSleepControl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_AutoSleepControl" 
   ((enableSleep :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetIntModemInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_GetIntModemInfo" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  SetIntModemState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_SetIntModemState" 
   ((theState :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MaximumProcessorSpeed()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_MaximumProcessorSpeed" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  MinimumProcessorSpeed()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_MinimumProcessorSpeed" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :SInt16
() )
; 
;  *  CurrentProcessorSpeed()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_CurrentProcessorSpeed" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  FullProcessorSpeed()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_FullProcessorSpeed" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SetProcessorSpeed()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_SetProcessorSpeed" 
   ((fullSpeed :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  GetSCSIDiskModeAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_GetSCSIDiskModeAddress" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetSCSIDiskModeAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_SetSCSIDiskModeAddress" 
   ((scsiAddress :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetWakeupTimer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_GetWakeupTimer" 
   ((theTime (:pointer :WakeupTime))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetWakeupTimer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_SetWakeupTimer" 
   ((theTime (:pointer :WakeupTime))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  IsProcessorCyclingEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_IsProcessorCyclingEnabled" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  EnableProcessorCycling()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_EnableProcessorCycling" 
   ((enable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  BatteryCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_BatteryCount" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetBatteryVoltage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_GetBatteryVoltage" 
   ((whichBattery :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GetBatteryTimes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_GetBatteryTimes" 
   ((whichBattery :SInt16)
    (theTimes (:pointer :BatteryTimeRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetDimmingTimeout()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_GetDimmingTimeout" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt8
() )
; 
;  *  SetDimmingTimeout()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_SetDimmingTimeout" 
   ((timeout :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DimmingControl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_DimmingControl" 
   ((enableSleep :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  IsDimmingControlDisabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_IsDimmingControlDisabled" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  IsAutoSlpControlDisabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_IsAutoSlpControlDisabled" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  PMgrStateQInstall()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_PMgrStateQInstall" 
   ((theElement (:pointer :PMGRQUEUEELEMENT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PMgrStateQRemove()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_PMgrStateQRemove" 
   ((theElement (:pointer :PMGRQUEUEELEMENT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  UpdateSystemActivity()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_UpdateSystemActivity" 
   ((activity :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DelaySystemIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_DelaySystemIdle" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetStartupTimer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_GetStartupTimer" 
   ((theTime (:pointer :StartupTime))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetStartupTimer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_SetStartupTimer" 
   ((theTime (:pointer :StartupTime))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetLastActivity()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
;  

(deftrap-inline "_GetLastActivity" 
   ((theActivity (:pointer :ActivityInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetSoundMixerState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.1 and later
;  

(deftrap-inline "_GetSoundMixerState" 
   ((theSoundMixerByte (:pointer :SOUNDMIXERBYTE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetSoundMixerState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.1 and later
;  

(deftrap-inline "_SetSoundMixerState" 
   ((theSoundMixerByte (:pointer :SOUNDMIXERBYTE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDimSuspendState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.1 and later
;  

(deftrap-inline "_GetDimSuspendState" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SetDimSuspendState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in PowerMgrLib 1.1 and later
;  

(deftrap-inline "_SetDimSuspendState" 
   ((dimSuspendState :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetCoreProcessorTemperature()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
;  
; 
;  *  GetWakeOnNetworkOptions()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
;  
; 
;  *  SetWakeOnNetworkOptions()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
;  
; 
;  *  AddPowerSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
;  
; 
;  *  RemovePowerSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
;  
; 
;  *  UpdatePowerSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
;  
; 
;  *  IsServerModeEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
;  
; 
;  *  EnableServerMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
;  
;  
;    NumBatteriesInstalled is different from BatteryCount in that it
;    indicates how many batteries are actually available at the time
;    it is called (including UPS batteries). BatteryCount shows a 
;    static number of batteries a machine is capable of holding which does NOT
;    include UPS batteries. So, while a desktop might show a BatteryCount
;    of zero, its NumBatteriesInstalled value might be 1 or more if a UPS
;    is attached. 
; 
; 
;  *  NumBatteriesInstalled()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
;  
;  Power Handler Management 
; 
;  *  IsPCIPowerOffDisabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
;  
; 
;  *  EnablePCIPowerOff()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
;  
; 
;  *  AddDevicePowerHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
;  
; 
;  *  RemoveDevicePowerHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
;  
; 
;  *  RemoveDevicePowerHandlerForProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
;  
; 
;  *  GetDevicePowerLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
;  
; 
;  *  SetDevicePowerLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
;  
; 
;  *  NewSleepQUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSleepQUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSleepQProcPtr)
() )
; 
;  *  NewHDSpindownUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewHDSpindownUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueHDSpindownProcPtr)
() )
; 
;  *  NewPMgrStateChangeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewPMgrStateChangeUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaquePMgrStateChangeProcPtr)
() )
; 
;  *  DisposeSleepQUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSleepQUPP" 
   ((userUPP (:pointer :OpaqueSleepQProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeHDSpindownUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeHDSpindownUPP" 
   ((userUPP (:pointer :OpaqueHDSpindownProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposePMgrStateChangeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposePMgrStateChangeUPP" 
   ((userUPP (:pointer :OpaquePMgrStateChangeProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSleepQUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSleepQUPP" 
   ((message :signed-long)
    (qRecPtr (:pointer :SLEEPQREC))
    (userUPP (:pointer :OpaqueSleepQProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  InvokeHDSpindownUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeHDSpindownUPP" 
   ((theElement (:pointer :HDQUEUEELEMENT))
    (userUPP (:pointer :OpaqueHDSpindownProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokePMgrStateChangeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokePMgrStateChangeUPP" 
   ((theElement (:pointer :PMGRQUEUEELEMENT))
    (stateBits :signed-long)
    (userUPP (:pointer :OpaquePMgrStateChangeProcPtr))
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

; #endif /* __POWER__ */


(provide-interface "Power")