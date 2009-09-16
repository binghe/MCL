(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothInternal.h"
; at Sunday July 2,2006 7:28:33 pm.
; 
; 	File:		BluetoothInternal.h
; 	Contains:	Internal types and macros needed by public kernel APIs.
; 	Copyright:	© 2003 by Apple Computer, Inc. All rights reserved.
; 
; #pragma once
(def-mactype :IOBluetoothHCIControllerConfigState (find-mactype ':sint32))

(defconstant $kIOBluetoothHCIControllerConfigStateOnline 0);  Controller is configured and ready for clients

(defconstant $kIOBluetoothHCIControllerConfigStateKernelSetupPending 1);  New controller - kernel setup in progress

(defconstant $kIOBluetoothHCIControllerConfigStateDaemonSetupPending 2);  New controller - daemon setup in progress

(defconstant $kIOBluetoothHCIControllerConfigStateDaemonSetupComplete 3);  New controller - daemon setup complete

(defconstant $kIOBluetoothHCIControllerConfigStateResetPending 4);  HCI reset has been issued

(defconstant $kIOBluetoothHCIControllerConfigStateKernelPostResetSetupPending 5);  HCI reset complete - kernel setup in progress

(defconstant $kIOBluetoothHCIControllerConfigStateDaemonPostResetSetupPending 6);  HCI reset complete - daemon setup in progress

(defconstant $kIOBluetoothHCIControllerConfigStateDaemonPostResetSetupComplete 7);  HCI reset complete - daemon setup complete

(defconstant $kIOBluetoothHCIControllerConfigStateUninitialized 8)
(def-mactype :IOBluetoothHCIControllerConfigState (find-mactype ':SINT32))

(def-mactype :IOBluetoothHCIControllerPowerOptions (find-mactype ':UInt32))

(defconstant $kIOBluetoothHCIControllerPowerOptionPowerOffSupported 1)
(defconstant $kIOBluetoothHCIControllerPowerOptionWakeFromExistingConnectionSupported 2)
(defconstant $kIOBluetoothHCIControllerPowerOptionWakeFromNewConnectionSupported 4)
(def-mactype :IOBluetoothHCIControllerSleepOptions (find-mactype ':sint32))

(defconstant $kIOBluetoothHCIControllerAllowWakeFromExistingConnection 1)
(defconstant $kIOBluetoothHCIControllerAllowWakeFromNewConnection 2)
; #define HCI_CONTROLLER_POWER_OFF_SUPPORTED( _controllerPowerOptions )	( ( _controllerPowerOptions & kIOBluetoothHCIControllerPowerOptionPowerOffSupported ) == kIOBluetoothHCIControllerPowerOptionPowerOffSupported )
; #define HCI_CONTROLLER_SLEEP_SUPPORTED( _controllerPowerOptions )		( ( _controllerPowerOptions &			( kIOBluetoothHCIControllerPowerOptionWakeFromExistingConnectionSupported |			  kIOBluetoothHCIControllerPowerOptionWakeFromNewConnectionSupported ) ) != 0 )
(def-mactype :IOBluetoothHCIControllerInternalPowerState (find-mactype ':sint32))

(defconstant $kIOBluetoothHCIControllerInternalPowerStateOff 0)
(defconstant $kIOBluetoothHCIControllerInternalPowerStateOn 1)
(defconstant $kIOBluetoothHCIControllerInternalPowerStateSleep 2)
(def-mactype :IOBluetoothHCIControllerInternalPowerState (find-mactype ':SINT32))

(def-mactype :IOBluetoothHCIControllerFeatureFlags (find-mactype ':UInt32))

(defconstant $kIOBluetoothHCIControllerFeatureFlagSerializeCommands #x10000000)
(defconstant $kIOBluetoothHCIControllerFeatureFlagVendorCommandFlowControl 1)

(provide-interface "IOBluetoothInternal")