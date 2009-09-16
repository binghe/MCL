(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOPM.h"
; at Sunday July 2,2006 7:26:36 pm.
; 
;  * Copyright (c) 1998-2000 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * The contents of this file constitute Original Code as defined in and
;  * are subject to the Apple Public Source License Version 1.1 (the
;  * "License").  You may not use this file except in compliance with the
;  * License.  Please obtain a copy of the License at
;  * http://www.apple.com/publicsource and read it before using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
;  * License for the specific language governing rights and limitations
;  * under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef _IOKIT_IOPM_H
; #define _IOKIT_IOPM_H
(defconstant $IOPMMaxPowerStates 10)
; #define IOPMMaxPowerStates 10

(def-mactype :IOPMPowerFlags (find-mactype ':UInt32))
;  following  bits are used in the input and output power fields

(defconstant $kIOPMClockNormal 4)
(defconstant $kIOPMClockRunning 8)
(defconstant $kIOPMAuxPowerOn 32)               ;  used only between root and root parent

(defconstant $kIOPMPagingAvailable 32)          ;  used only between paging plexus and its children

(defconstant $kIOPMPassThrough #x100)
(defconstant $kIOPMDoze #x400)
(defconstant $kIOPMSoftSleep #x400)             ;  old usage, replaced by kIOPMDoze

(defconstant $kIOPMSleep 1)
(defconstant $kIOPMRestart #x80)                ;  following  bits are used in the capabilites field and the power fields

(defconstant $kIOPMPowerOn 2)
(defconstant $kIOPMPreventSystemSleep 16)
(defconstant $kIOPMPreventIdleSleep 64)         ;  following  bits are used in the capabilites field

(defconstant $kIOPMNotAttainable 1)             ;  used between a driver and its policy-maker

(defconstant $kIOPMChildClamp #x80)             ;  used internally in a power domain parent

(defconstant $kIOPMChildClamp2 #x200)           ;  used internally in a power domain parent

(defconstant $kIOPMDeviceUsable #x8000)
(defconstant $kIOPMMaxPerformance #x4000)
(defconstant $kIOPMContextRetained #x2000)
(defconstant $kIOPMConfigRetained #x1000)
(defconstant $kIOPMSleepCapability 4)
(defconstant $kIOPMRestartCapability #x80)
(defconstant $kIOPMNotPowerManaged #x800)       ;  this is an error return rather than a bit

(defconstant $kIOPMStaticPowerValid #x800)      ;  therefore this bit safely overloads it

(defconstant $kIOPMCapabilitiesMask #xF086)

(defconstant $IOPMNotAttainable 1)
(defconstant $IOPMPowerOn 2)
(defconstant $IOPMClockNormal 4)
(defconstant $IOPMClockRunning 8)
(defconstant $IOPMAuxPowerOn 32)
(defconstant $IOPMDeviceUsable #x8000)
(defconstant $IOPMMaxPerformance #x4000)
(defconstant $IOPMContextRetained #x2000)
(defconstant $IOPMConfigRetained #x1000)
(defconstant $IOPMNotPowerManaged #x800)
(defconstant $IOPMPagingAvailable 32)
(defconstant $IOPMSoftSleep #x400)

(defconstant $kIOPMNextHigherState 1)
(defconstant $kIOPMHighestState 2)
(defconstant $kIOPMNextLowerState 3)
(defconstant $kIOPMLowestState 4)

(defconstant $IOPMNextHigherState 1)
(defconstant $IOPMHighestState 2)
(defconstant $IOPMNextLowerState 3)
(defconstant $IOPMLowestState 4)
;  commands on power managment command queue

(defconstant $kIOPMBroadcastAggressiveness 1)
(defconstant $kIOPMUnidleDevice 2)
;  special value means "power consumption unknown"

(defconstant $kIOPMUnknown #xFFFF)
;  Power events

(defconstant $kClamshellClosedEventMask 1)      ;  User closed lid

(defconstant $kDockingBarEventMask 2)           ;  OBSOLETE

(defconstant $kACPlugEventMask 4)               ;  User plugged or unplugged adapter

(defconstant $kFrontPanelButtonEventMask 8)     ;  User hit the front panel button
;  Battery status has changed

(defconstant $kBatteryStatusEventMask 16)
;  Power commands issued to root domain

(defconstant $kIOPMSleepNow 1)                  ;  put machine to sleep now

(defconstant $kIOPMAllowSleep 2)                ;  allow idle sleep

(defconstant $kIOPMPreventSleep 4)              ;  do not allow idle sleep

(defconstant $kIOPMPowerButton 8)               ;  power button was pressed

(defconstant $kIOPMClamshellClosed 16)          ;  clamshell was closed

(defconstant $kIOPMPowerEmergency 32)           ;  battery dangerously low

(defconstant $kIOPMDisableClamshell 64)         ;  do not sleep on clamshell closure

(defconstant $kIOPMEnableClamshell #x80)        ;  sleep on clamshell closure

(defconstant $kIOPMProcessorSpeedChange #x100)  ;  change the processor speed
;  system dangerously hot

(defconstant $kIOPMOverTemp #x200)
;  Return codes
;  PUBLIC power management features
;  NOTE: this is a direct port from classic, some of these bits
;        are obsolete but are included for completeness

(defconstant $kPMHasWakeupTimerMask 1)          ;  1=wake timer is supported

(defconstant $kPMHasSharedModemPortMask 2)      ;  Not used

(defconstant $kPMHasProcessorCyclingMask 4)     ;  1=processor cycling supported

(defconstant $kPMMustProcessorCycleMask 8)      ;  Not used

(defconstant $kPMHasReducedSpeedMask 16)        ;  1=supports reduced processor speed

(defconstant $kPMDynamicSpeedChangeMask 32)     ;  1=supports changing processor speed on the fly

(defconstant $kPMHasSCSIDiskModeMask 64)        ;  1=supports using machine as SCSI drive

(defconstant $kPMCanGetBatteryTimeMask #x80)    ;  1=battery time can be calculated

(defconstant $kPMCanWakeupOnRingMask #x100)     ;  1=machine can wake on modem ring

(defconstant $kPMHasDimmingSupportMask #x200)   ;  1=has monitor dimming support

(defconstant $kPMHasStartupTimerMask #x400)     ;  1=can program startup timer

(defconstant $kPMHasChargeNotificationMask #x800);  1=client can determine charger status/get notifications

(defconstant $kPMHasDimSuspendSupportMask #x1000);  1=can dim diplay to DPMS ('off') state

(defconstant $kPMHasWakeOnNetActivityMask #x2000);  1=supports waking upon receipt of net packet

(defconstant $kPMHasWakeOnLidMask #x4000)       ;  1=can wake upon lid/case opening

(defconstant $kPMCanPowerOffPCIBusMask #x8000)  ;  1=can remove power from PCI bus on sleep

(defconstant $kPMHasDeepSleepMask #x10000)      ;  1=supports deep (hibernation) sleep

(defconstant $kPMHasSleepMask #x20000)          ;  1=machine support low power sleep (ala powerbooks)

(defconstant $kPMSupportsServerModeAPIMask #x40000);  1=supports reboot on AC resume for unexpected power loss
;  1=supports incorporating UPS devices into power source calcs

(defconstant $kPMHasUPSIntegrationMask #x80000)
;  PRIVATE power management features
;  NOTE: this is a direct port from classic, some of these bits
;        are obsolete but are included for completeness.

(defconstant $kPMHasExtdBattInfoMask 1)         ;  Not used

(defconstant $kPMHasBatteryIDMask 2)            ;  Not used

(defconstant $kPMCanSwitchPowerMask 4)          ;  Not used 

(defconstant $kPMHasCelsiusCyclingMask 8)       ;  Not used

(defconstant $kPMHasBatteryPredictionMask 16)   ;  Not used

(defconstant $kPMHasPowerLevelsMask 32)         ;  Not used

(defconstant $kPMHasSleepCPUSpeedMask 64)       ;  Not used

(defconstant $kPMHasBtnIntHandlersMask #x80)    ;  1=supports individual button interrupt handlers

(defconstant $kPMHasSCSITermPowerMask #x100)    ;  1=supports SCSI termination power switch

(defconstant $kPMHasADBButtonHandlersMask #x200);  1=supports button handlers via ADB

(defconstant $kPMHasICTControlMask #x400)       ;  1=supports ICT control

(defconstant $kPMHasLegacyDesktopSleepMask #x800);  1=supports 'doze' style sleep

(defconstant $kPMHasDeepIdleMask #x1000)        ;  1=supports Idle2 in hardware

(defconstant $kPMOpenLidPreventsSleepMask #x2000);  1=open case prevent machine from sleeping

(defconstant $kPMClosedLidCausesSleepMask #x4000);  1=case closed (clamshell closed) causes sleep

(defconstant $kPMHasFanControlMask #x8000)      ;  1=machine has software-programmable fan/thermostat controls

(defconstant $kPMHasThermalControlMask #x10000) ;  1=machine supports thermal monitoring

(defconstant $kPMHasVStepSpeedChangeMask #x20000);  1=machine supports processor voltage/clock change
;  1=machine doesn't generate pmu env ints, we must poll instead 

(defconstant $kPMEnvironEventsPolledMask #x40000)
;  DEFAULT public and private features for machines whose device tree
;  does NOT contain this information (pre-Core99).
;  For Cuda-based Desktops
; #define kStdDesktopPMFeatures   kPMHasWakeupTimerMask         |                                kPMHasProcessorCyclingMask    |                                kPMHasDimmingSupportMask      |                                kPMHasStartupTimerMask        |                                kPMSupportsServerModeAPIMask  |                                kPMHasUPSIntegrationMask
; #define kStdDesktopPrivPMFeatures  kPMHasExtdBattInfoMask     |                                   kPMHasICTControlMask       |                                   kPMHasLegacyDesktopSleepMask
(defconstant $kStdDesktopNumBatteries 0)
; #define kStdDesktopNumBatteries 0
;  For Wallstreet (PowerBook G3 Series 1998)
; #define kWallstreetPMFeatures   kPMHasWakeupTimerMask         |                                kPMHasProcessorCyclingMask    |                                kPMHasReducedSpeedMask        |                                kPMDynamicSpeedChangeMask     |                                kPMHasSCSIDiskModeMask        |                                kPMCanGetBatteryTimeMask      |                                kPMHasDimmingSupportMask      |                                kPMHasChargeNotificationMask  |                                kPMHasDimSuspendSupportMask   |                                kPMHasSleepMask
; #define kWallstreetPrivPMFeatures  kPMHasExtdBattInfoMask      |                                   kPMHasBatteryIDMask         |                                   kPMCanSwitchPowerMask       |                                   kPMHasADBButtonHandlersMask |                                   kPMHasSCSITermPowerMask     |                                   kPMHasICTControlMask        |                                   kPMClosedLidCausesSleepMask |                                   kPMEnvironEventsPolledMask
; #define kStdPowerBookPMFeatures      kWallstreetPMFeatures
; #define kStdPowerBookPrivPMFeatures  kWallstreetPrivPMFeatures
(defconstant $kStdPowerBookNumBatteries 2)
; #define kStdPowerBookNumBatteries 2
;  For 101 (PowerBook G3 Series 1999)
; #define k101PMFeatures          kPMHasWakeupTimerMask         |                                kPMHasProcessorCyclingMask    |                                kPMHasReducedSpeedMask        |                                kPMDynamicSpeedChangeMask     |                                kPMHasSCSIDiskModeMask        |                                kPMCanGetBatteryTimeMask      |                                kPMHasDimmingSupportMask      |                                kPMHasChargeNotificationMask  |                                kPMHasDimSuspendSupportMask   |                                kPMHasSleepMask               |                                kPMHasUPSIntegrationMask
; #define k101PrivPMFeatures      kPMHasExtdBattInfoMask        |                                kPMHasBatteryIDMask           |                                kPMCanSwitchPowerMask         |                                kPMHasADBButtonHandlersMask   |                                kPMHasSCSITermPowerMask       |                                kPMHasICTControlMask          |                                kPMClosedLidCausesSleepMask   |                                kPMEnvironEventsPolledMask
(defconstant $IOPMNoErr 0)
; #define IOPMNoErr		0	// normal return
;  returned by powerStateWillChange and powerStateDidChange:
(defconstant $IOPMAckImplied 0)
; #define IOPMAckImplied		0	// acknowledgement of power state change is implied
(defconstant $IOPMWillAckLater 1)
; #define IOPMWillAckLater	1	// acknowledgement of power state change will come later
;  returned by requestDomainState
(defconstant $IOPMBadSpecification 4)
; #define IOPMBadSpecification	4	// unrecognized specification parameter
(defconstant $IOPMNoSuchState 5)
; #define IOPMNoSuchState		5	// no power state matches search specification
(defconstant $IOPMCannotRaisePower 6)
; #define IOPMCannotRaisePower	6	// a device cannot change its power for some reason
;  returned by changeStateTo
(defconstant $IOPMParameterError 7)
; #define IOPMParameterError	7	// requested state doesn't exist
(defconstant $IOPMNotYetInitialized 8)
; #define IOPMNotYetInitialized	8	// device not yet fully hooked into power management "graph"
;  used by Root Domain UserClient

(defconstant $kPMGeneralAggressiveness 0)
(defconstant $kPMMinutesToDim 1)
(defconstant $kPMMinutesToSpinDown 2)
(defconstant $kPMMinutesToSleep 3)
(defconstant $kPMEthernetWakeOnLANSettings 4)
(defconstant $kPMSetProcessorSpeed 5)
(defconstant $kPMPowerSource 6)
; #define kMaxType kPMEthernetWakeOnLANSettings
;  SetAggressiveness values for the kPMPowerSource aggressiveness type

(defconstant $kIOPMInternalPower 1)
(defconstant $kIOPMExternalPower 2)
(defconstant $kAppleClamshellStateKey "AppleClamshellState")
; #define kAppleClamshellStateKey           "AppleClamshellState"
(defconstant $kIOREMSleepEnabledKey "REMSleepEnabled")
; #define kIOREMSleepEnabledKey             "REMSleepEnabled"
;  Strings for deciphering the dictionary returned from IOPMCopyBatteryInfo
(defconstant $kIOBatteryInfoKey "IOBatteryInfo")
; #define kIOBatteryInfoKey		"IOBatteryInfo"
(defconstant $kIOBatteryCurrentChargeKey "Current")
; #define kIOBatteryCurrentChargeKey	"Current"
(defconstant $kIOBatteryCapacityKey "Capacity")
; #define kIOBatteryCapacityKey		"Capacity"
(defconstant $kIOBatteryFlagsKey "Flags")
; #define kIOBatteryFlagsKey		"Flags"
(defconstant $kIOBatteryVoltageKey "Voltage")
; #define kIOBatteryVoltageKey		"Voltage"
(defconstant $kIOBatteryAmperageKey "Amperage")
; #define kIOBatteryAmperageKey		"Amperage"

(defconstant $kIOBatteryInstalled 4)
(defconstant $kIOBatteryCharge 2)
(defconstant $kIOBatteryChargerConnect 1)
;  Private power management message indicating battery data has changed
;  Indicates new data resides in the IORegistry
; #define kIOPMMessageBatteryStatusHasChanged         iokit_family_msg(sub_iokit_pmu, 0x100)
;  Apple private Legacy messages for re-routing AutoWake and AutoPower messages to the PMU
;  through newer user space IOPMSchedulePowerEvent API
; #define kIOPMUMessageLegacyAutoWake                 iokit_family_msg(sub_iokit_pmu, 0x200)
; #define kIOPMUMessageLegacyAutoPower            	iokit_family_msg(sub_iokit_pmu, 0x210)
;  These flags are deprecated. Use the version with the kIOPM prefix below.

(defconstant $kACInstalled 1)
(defconstant $kBatteryCharging 2)
(defconstant $kBatteryInstalled 4)
(defconstant $kUPSInstalled 8)
(defconstant $kBatteryAtWarn 16)
(defconstant $kBatteryDepleted 32)
(defconstant $kACnoChargeCapability 64)         ;  AC adapter cannot charge battery

(defconstant $kRawLowBattery #x80)              ;  used only by  Platform Expert
;  set by Platfm Expert, chk'd by Pwr Plugin};

(defconstant $kForceLowSpeed #x100)
;  For use with IOPMPowerSource bFlags
(defconstant $IOPM_POWER_SOURCE_REV 2)
; #define IOPM_POWER_SOURCE_REV   2

(defconstant $kIOPMACInstalled 1)
(defconstant $kIOPMBatteryCharging 2)
(defconstant $kIOPMBatteryInstalled 4)
(defconstant $kIOPMUPSInstalled 8)
(defconstant $kIOPMBatteryAtWarn 16)
(defconstant $kIOPMBatteryDepleted 32)
(defconstant $kIOPMACnoChargeCapability 64)     ;  AC adapter cannot charge battery

(defconstant $kIOPMRawLowBattery #x80)          ;  used only by  Platform Expert

(defconstant $kIOPMForceLowSpeed #x100)         ;  set by Platfm Expert, chk'd by Pwr Plugin

(defconstant $kIOPMClosedClamshell #x200)       ;  set by PMU - reflects state of the clamshell
;  used only by Platform Expert

(defconstant $kIOPMClamshellStateOnWake #x400)
;  **********************************************
;  Internal power management data structures
;  **********************************************

; #if KERNEL && __cplusplus
#| 
#|class IOService;
|#

(defconstant $kIOPowerEmergencyLevel #x3E8)

(defconstant $kIOPMSubclassPolicy 0)
(defconstant $kIOPMSuperclassPolicy1 1)
(defrecord stateChangeNote
   (stateFlags :UInt32)
   (stateNum :UInt32)
   (powerRef :pointer)
)

;type name? (def-mactype :stateChangeNote (find-mactype ':stateChangeNote))
(defrecord IOPowerStateChangeNotification
   (powerRef :pointer)
   (returnValue :UInt32)
   (stateNumber :UInt32)
   (stateFlags :UInt32)
)

;type name? (def-mactype :IOPowerStateChangeNotification (find-mactype ':IOPowerStateChangeNotification))

(def-mactype :sleepWakeNote (find-mactype ':IOPowerStateChangeNotification))

(deftrap-inline "_IOPMRegisterDevice" 
   ((ARGH (:pointer :char))
    (ARGH (:pointer :ioservice))
   )
   nil
() )
 |#

; #endif /* KERNEL && __cplusplus */


; #endif /* ! _IOKIT_IOPM_H */


(provide-interface "IOPM")