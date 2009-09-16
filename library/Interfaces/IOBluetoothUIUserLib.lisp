(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothUIUserLib.h"
; at Sunday July 2,2006 7:28:34 pm.
; 
; 	File:		IOBluetoothUIUserLib.h
; 	Contains:	Library to allow user-side clients to use Bluetooth UI C API's.
; 	Copyright:	й 2002 by Apple Computer, Inc. All rights reserved.
; 
; #pragma once

(require-interface "IOBluetooth/IOBluetoothUserLib")

(def-mactype :IOBluetoothDeviceSelectorControllerRef (find-mactype '(:pointer :OpaqueIOBluetoothObjectRef)))

(def-mactype :IOBluetoothPairingControllerRef (find-mactype '(:pointer :OpaqueIOBluetoothObjectRef)))

(def-mactype :IOBluetoothServiceBrowserControllerRef (find-mactype '(:pointer :OpaqueIOBluetoothObjectRef)))
;  Common UI functions

; #if 0
#| ; #pragma mark -
; #pragma mark ее Bluetooth Service Browser Controller ее
 |#

; #endif

; !
;   @enum IOBluetoothServiceBrowserControllerOptions
;   @discussion Option values to customize the behavior of an IOBluetoothServiceBrowserController object.
;   @constant kIOBluetoothServiceBrowserControllerOptionsNone - no options set.
;   @constant kIOBluetoothServiceBrowserControllerOptionsAutoStartInquiry - automatically start an inquiry when the panel is diaplayed.
;   
; 

(def-mactype :IOBluetoothServiceBrowserControllerOptions (find-mactype ':UInt32))

(defconstant $kIOBluetoothServiceBrowserControllerOptionsNone 0)
(defconstant $kIOBluetoothServiceBrowserControllerOptionsAutoStartInquiry 1)
(defconstant $kIOBluetoothServiceBrowserControllerOptionsDisconnectWhenDone 2)

(defconstant $kIOBluetoothUISuccess -1000)      ;  Same as NSRunStoppedResponse
;  Same as NSRunAbortedResponse

(defconstant $kIOBluetoothUIUserCanceledErr -1001)
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothServiceBrowserControllerCreate
; 	@abstract	
; 	@param						
; 	@result		
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothServiceBrowserControllerCreate" 
   ((inOptions :UInt32)
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothServiceBrowserControllerBrowseDevices
; 	@abstract	
; 	@param						
; 	@result		
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothServiceBrowserControllerBrowseDevices" 
   ((outRecord (:pointer :IOBLUETOOTHSDPSERVICERECORDREF))
    (inOptions :UInt32)
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothServiceBrowserControllerSetOptions
; 	@abstract	
; 	@param						
; 	@result		
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothServiceBrowserControllerSetOptions" 
   ((controller (:pointer :OpaqueIOBluetoothObjectRef))
    (inOptions :UInt32)
   )
   :void
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothServiceBrowserControllerDiscover
; 	@abstract	
; 	@param						
; 	@result		
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothServiceBrowserControllerDiscover" 
   ((controller (:pointer :OpaqueIOBluetoothObjectRef))
    (outRecord (:pointer :IOBLUETOOTHSDPSERVICERECORDREF))
   )
   :signed-long
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothServiceBrowserControllerDiscoverWithDeviceAttributes
; 	@abstract	
; 	@param						
; 	@result		
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothServiceBrowserControllerDiscoverWithDeviceAttributes" 
   ((controller (:pointer :OpaqueIOBluetoothObjectRef))
    (outRecord (:pointer :IOBLUETOOTHSDPSERVICERECORDREF))
    (deviceAttributes (:pointer :IOBLUETOOTHDEVICESEARCHATTRIBUTES))
    (serviceArray (:pointer :__CFArray))
   )
   :signed-long
() )

; #if 0
#| ; #pragma mark -
; #pragma mark ее Bluetooth Pairing Controller ее
 |#

; #endif

; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothGetPairingController
; 	@abstract	
; 	@param						
; 	@result		
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothGetPairingController" 
   ((ARG2 (:NIL :NIL))
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothPairingControllerRunPanelWithAttributes
; 	@abstract	
; 	@param						
; 	@result		
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothPairingControllerRunPanelWithAttributes" 
   ((pairingController (:pointer :OpaqueIOBluetoothObjectRef))
    (attributes (:pointer :IOBLUETOOTHDEVICESEARCHATTRIBUTES))
   )
   :void
() )

; #if 0
#| ; #pragma mark -
; #pragma mark ее Bluetooth Device Selector Controller ее
 |#

; #endif

; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothGetDeviceSelectorController
; 	@abstract	
; 	@param						
; 	@result		
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothGetDeviceSelectorController" 
   ((ARG2 (:NIL :NIL))
   )
   (:pointer :OpaqueIOBluetoothObjectRef)
() )
; --------------------------------------------------------------------------------------------------------------------------
; !	@function	IOBluetoothDeviceSelectorRunPanelWithAttributes
; 	@abstract	
; 	@param						
; 	@result		
; 	@discussion	
; 

(deftrap-inline "_IOBluetoothDeviceSelectorRunPanelWithAttributes" 
   ((deviceSelector (:pointer :OpaqueIOBluetoothObjectRef))
    (attributes (:pointer :IOBLUETOOTHDEVICESEARCHATTRIBUTES))
   )
   (:pointer :__CFArray)
() )

; #if 0
#| ; #pragma mark -
; #pragma mark ее Other functions ее
 |#

; #endif


(deftrap-inline "_IOBluetoothValidateHardware" 
   ((cancelButtonTitle (:pointer :__CFString))
   )                                            ; AVAILABLE_BLUETOOTH_VERSION_1_1_AND_LATER
   :signed-long
() )

(provide-interface "IOBluetoothUIUserLib")