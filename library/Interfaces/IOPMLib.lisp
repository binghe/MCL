(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOPMLib.h"
; at Sunday July 2,2006 7:29:41 pm.
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

(require-interface "CoreFoundation/CFArray")

(require-interface "IOKit/IOKitLib")

(require-interface "IOKit/pwr_mgt/IOPMLibDefs")

(require-interface "IOKit/pwr_mgt/IOPMKeys")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; !
; @header IOPMLib.h
;     IOPMLib provides access to common power management facilites, like initiating 
;     system sleep, getting current idle timer values, registering for sleep/wake notifications, 
;     and preventing system sleep.
; 
; !
; @function IOPMFindPowerManagement
; @abstract Finds the Root Power Domain IOService.
; @param master_device_port  Caller gets this from IOMasterPort.
; @result Returns a representation of the Root Domain or zero if request failed.
;  

(deftrap-inline "_IOPMFindPowerManagement" 
   ((master_device_port :pointer)
   )
   :pointer
() )
; !
;     @function IOPMSetAggressiveness
;     @abstract Sets one of the aggressiveness factors in IOKit Power Management.
;     @param fb  Representation of the Root Power Domain from IOPMFindPowerManagement.
;      @param type Specifies which aggressiveness factor is being set.
;      @param type New value of the aggressiveness factor.
;      @result Returns kIOReturnSuccess or an error condition if request failed.
;      

(deftrap-inline "_IOPMSetAggressiveness" 
   ((fb :pointer)
    (type :UInt32)
    (aggressiveness :UInt32)
   )
   :signed-long
() )
; !
; @function IOPMGetAggressiveness
; @abstract Retrieves the current value of one of the aggressiveness factors in IOKit Power Management.
; @param fb  Representation of the Root Power Domain from IOPMFindPowerManagement.
; @param type Specifies which aggressiveness factor is being retrieved.
; @param type Points to where to store the retrieved value of the aggressiveness factor.
; @result Returns kIOReturnSuccess or an error condition if request failed.
;      

(deftrap-inline "_IOPMGetAggressiveness" 
   ((fb :pointer)
    (type :UInt32)
    (aggressiveness (:pointer :UInt32))
   )
   :signed-long
() )
; !
;         @function IORegisterApp
;         @abstract Connects the caller to an IOService for the purpose of receiving power state
;              change notifications for the device controlled by the IOService.
;         @discussion IORegisterApp requires that the IOService of interest implement an IOUserClient. If you're interested
;             in receiving power state notifications from a device without an IOUserClient, try using
;             IOServiceAddInterestNotification with interest type gIOGeneralInterest instead.
;         @param refcon Data returned on power state change notifications and not used by
;              the kernel.
;         @param theDriver  Representation of the IOService, probably from IOServiceGetMatchingService.
;         @param thePortRef Pointer to a port on which the caller will receive power state change notifications.
;         The port is allocated by the calling application.
;         @param callback  A c-function which is called during the notification.
;         @param notifier  Pointer to a notifier which the application has no use for but must be part of a subsequent
;             call to IODeregisterApp.
;         @result Returns a representation of the IOService or zero if request failed.
;              

(deftrap-inline "_IORegisterApp" 
   ((refcon :pointer)
    (theDriver :pointer)
    (thePortRef (:pointer :IONotificationPortRef))
    (callback :pointer)
    (notifier (:pointer :io_object_t))
   )
   :pointer
() )
; !
;     @function IORegisterForSystemPower
;     @abstract Connects the caller to the Root Power Domain  IOService for the purpose of receiving
;      Sleep, Wake, ShutDown, PowerUp notifications for the System.
;     @param refcon Data returned on power state change notifications and not used by
;          the kernel.
;     @param thePortRef Pointer to a port on which the caller will receive power state change notifications.
;         The port is allocated by this function.
;     @param callback  A c-function which is called during the notification.
;     @param notifier  Pointer to a notifier which the application has no use for but must be part of a subsequent
;         call to IODeregisterForSystemPower.
;     @result Returns a representation of the Root Power Domain IOService or zero if request failed.
;          

(deftrap-inline "_IORegisterForSystemPower" 
   ((refcon :pointer)
    (thePortRef (:pointer :IONotificationPortRef))
    (callback :pointer)
    (notifier (:pointer :io_object_t))
   )
   :pointer
() )
; !
; @function IODeregisterApp
; @abstract Disconnects the caller from an IOService after receiving power state
;      change notifications from the IOService.
; @param notifier  An object from IORegisterApp.
; @result Returns kIOReturnSuccess or an error condition if request failed.
;      

(deftrap-inline "_IODeregisterApp" 
   ((notifier (:pointer :io_object_t))
   )
   :signed-long
() )
; !
; @function IODeregisterForSystemPower.
; @abstract Disconnects the caller from the Root Power Domain IOService after receiving
;      system power state change notifications.
; @param notifier  An object from IORegisterForSystemPower.
; @result Returns kIOReturnSuccess or an error condition if request failed.
;      

(deftrap-inline "_IODeregisterForSystemPower" 
   ((notifier (:pointer :io_object_t))
   )
   :signed-long
() )
; !
; @function IOAllowPowerChange
; @abstract The caller acknowledges notification of a power state change on a device
;      it is interested in.
; @param kernelPort  Port used to communicate to the kernel,  from IORegisterApp or
;      IORegisterForSystemPower.
; @param notificationID A copy of the notification ID which came as part of the power
;      state change notification being acknowledged.
; @result Returns kIOReturnSuccess or an error condition if request failed.
;      

(deftrap-inline "_IOAllowPowerChange" 
   ((kernelPort :pointer)
    (notificationID :signed-long)
   )
   :signed-long
() )
; !
; @function IOCancelPowerChange
; @abstract The caller negatively acknowledges notification of a power state change on a device
;      it is interested in.  This prevents the state change.
; @param kernelPort  Port used to communicate to the kernel,  from IORegisterApp or
;      IORegisterForSystemPower.
; @param notificationID A copy of the notification ID which came as part of the power
;      state change notification being acknowledged.
; @result Returns kIOReturnSuccess or an error condition if request failed.
;      

(deftrap-inline "_IOCancelPowerChange" 
   ((kernelPort :pointer)
    (notificationID :signed-long)
   )
   :signed-long
() )
; !
; @function IOPMSleepEnabled
; @abstract Tells whether the system supports full sleep, or just doze
; @result Returns true if the system supports sleep, false if some hardware prevents full sleep.
;      

(deftrap-inline "_IOPMSleepEnabled" 
   (
   )
   :signed-long
() )
; !
; @function IOPMSleepSystem
; @abstract Request that the system initiate sleep.
; @param fb  Port used to communicate to the kernel,  from IOPMFindPowerManagement.
; @result Returns kIOReturnSuccess or an error condition if request failed.
;      

(deftrap-inline "_IOPMSleepSystem" 
   ((fb :pointer)
   )
   :signed-long
() )
; !
; @function IOPMCopyBatteryInfo
; @abstract Request raw battery data from the system.
; @discussion For almost all purposes, developers should use the richer IOPowerSources API (with change notifications) instead of using IOPMCopyBatteryInfo.
; @param masterPort The master port obtained from IOMasterPort(). Pass kIOMasterPortDefault to look up the default master port.
; @param info A CFArray of CFDictionaries containing raw battery data.
; @result Returns kIOReturnSuccess or an error condition if request failed.
;      

(deftrap-inline "_IOPMCopyBatteryInfo" 
   ((masterPort :pointer)
    (info (:pointer :CFArrayRef))
   )
   :signed-long
() )
; ! @function IOPMSchedulePowerEvent
;     @abstract Schedule the machine to wake from sleep, power on, go to sleep, or shutdown. 
;     @discussion This event will be added to the system's queue of power events and stored persistently on disk. 
;         The sleep and shutdown events present a graphical warning and allow a console user to cancel the event.
;         Must be called as root.
;     @param time_to_wake Date and time that the system will power on/off.
;     @param my_id A CFStringRef identifying the calling app by CFBundleIdentifier. May be NULL.
;     @param type The type of power on you desire, either wake from sleep or power on. Choose from:
;                 CFSTR(kIOPMAutoWake) == wake machine, CFSTR(kIOPMAutoPowerOn) == power on machine, 
;                 CFSTR(kIOPMAutoWakeOrPowerOn) == wake(if asleep) or power on(if off),
;                 CFSTR(kIOPMAutoSleep) == sleep machine, CFSTR(kIOPMAutoShutdown) == power off machine.
;     @result kIOReturnSuccess on success, otherwise on failure
; 

(deftrap-inline "_IOPMSchedulePowerEvent" 
   ((time_to_wake (:pointer :__CFDate))
    (my_id (:pointer :__CFString))
    (type (:pointer :__CFString))
   )
   :signed-long
() )
; ! @function IOPMCancelScheduledPowerEvent
;     @abstract Cancel a previously scheduled power event.
;     @discussion Arguments mirror those to IOPMSchedulePowerEvent. All arguments must match the original arguments 
;         from when the power on was scheduled.
;         Must be called as root.
;     @param time_to_wake Cancel entry with this date and time.
;     @param my_id Cancel entry with this name.
;     @param type Type to cancel
;     @result kIOReturnSuccess on success, otherwise on failure
; 

(deftrap-inline "_IOPMCancelScheduledPowerEvent" 
   ((time_to_wake (:pointer :__CFDate))
    (my_id (:pointer :__CFString))
    (type (:pointer :__CFString))
   )
   :signed-long
() )
; ! @function IOPMCopyScheduledPowerEvents
;     @abstract List all scheduled system power events
;     @discussion Returns a CFArray of CFDictionaries of power events. Each CFDictionary 
;         contains keys for CFSTR(kIOPMPowerEventTimeKey), CFSTR(kIOPMPowerEventAppNameKey), 
;         and CFSTR(kIOPMPowerEventTypeKey).
;     @result A CFArray of CFDictionaries of power events. 
;         The CFArray must be released by the caller. 
;         NULL if there are no scheduled events.
; 

(deftrap-inline "_IOPMCopyScheduledPowerEvents" 
   (
   )
   (:pointer :__CFArray)
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

(provide-interface "IOPMLib")