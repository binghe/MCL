(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CMDeviceIntegration.h"
; at Sunday July 2,2006 7:24:23 pm.
; 
;      File:       ColorSync/CMDeviceIntegration.h
;  
;      Contains:   Color Management Device Interfaces
;  
;      Version:    ColorSync-118.2~1
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CMDEVICEINTEGRATION__
; #define __CMDEVICEINTEGRATION__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __CMAPPLICATION__
#| #|
#include <ColorSyncCMApplication.h>
#endif
|#
 |#
; #ifndef __CMICCPROFILE__
#| #|
#include <ColorSyncCMICCProfile.h>
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
; 
;     The current versions of the data structure
;     containing information on registered devices.
; 

(defconstant $cmDeviceInfoVersion1 #x10000)
(defconstant $cmDeviceProfileInfoVersion1 #x10000)
(defconstant $cmDeviceProfileInfoVersion2 #x20000)

(defconstant $cmCurrentDeviceInfoVersion #x10000)
(defconstant $cmCurrentProfileInfoVersion #x10000)
; 
;     Certain APIs require a device ID or profile ID.  
;     In some cases, a "default ID" can be used.
; 

(defconstant $cmDefaultDeviceID 0)
(defconstant $cmDefaultProfileID 0)
; 
;     Possible values for device states accessible by the
;     CMGetDeviceState() and CMSetDeviceState() APIs.
; 

(defconstant $cmDeviceStateDefault 0)
(defconstant $cmDeviceStateOffline 1)
(defconstant $cmDeviceStateBusy 2)
(defconstant $cmDeviceStateForceNotify #x80000000)
(defconstant $cmDeviceStateDeviceRsvdBits #xFF0000)
(defconstant $cmDeviceStateAppleRsvdBits #xFF00FFFF)
; 
;     Possible values for flags passed to the
;     CMIterateDeviceProfiles() API.
;     
;     "Factory" profiles are registered via the
;     CMSetDeviceFactoryProfiles() API.
;     
;     "Custom" profiles are those which are meant to take
;     the place of the factory profiles, as a result of
;     customization or calibration.  These profiles are
;     registered via the CMSetDeviceProfiles() API.
;     
;     To retrieve all of the the former for all devices,
;     use cmIterateFactoryDeviceProfiles as the flags
;     value when calling CMIterateDeviceProfiles().
;     
;     To retrieve only the latter for all devices, use
;     the cmIterateCustomDeviceProfiles, as the flags
;     value when calling CMIterateDeviceProfiles().
;     
;     To get the profiles in use for all devices, use
;     cmIterateCurrentDeviceProfiles as the flags value.
;     This will replace the factory profiles with any
;     overrides, yielding the currently used set.
;     
;     To get all profiles, without replacement, use
;     cmIterateAllDeviceProfiles. 
; 

(defconstant $cmIterateFactoryDeviceProfiles 1)
(defconstant $cmIterateCustomDeviceProfiles 2)
(defconstant $cmIterateCurrentDeviceProfiles 3)
(defconstant $cmIterateAllDeviceProfiles 4)
(defconstant $cmIterateDeviceProfilesMask 15)
; 
;     Errors returned by CMDeviceIntegration APIs
; 

(defconstant $cmDeviceDBNotFoundErr -4227)      ;  Prefs not found/loaded 

(defconstant $cmDeviceAlreadyRegistered -4228)  ;  Re-registration of device 

(defconstant $cmDeviceNotRegistered -4229)      ;  Device not found 

(defconstant $cmDeviceProfilesNotFound -4230)   ;  Profiles not found 
;  CoreFoundation failure 

(defconstant $cmInternalCFErr -4231)
; 
;    Clients can register for notifications of device changes:
;       DeviceRegistered      a new device was registered
;       DeviceUnregistered    a device was unregistered
;       DeviceOnline          change to Online as a result of CMSetDeviceState
;       DeviceOffline         change to Offline as a result of CMSetDeviceState
;       DeviceState           other change to a device state
;       DefaultDevice         default device for a device class changed
;       DeviceProfiles        change to a device's profiles
;       DefaultDeviceProfile  The default profile for any device changed
; 
; #define kCMDeviceRegisteredNotification     CFSTR("CMDeviceRegisteredNotification")
; #define kCMDeviceUnregisteredNotification   CFSTR("CMDeviceUnregisteredNotification")
; #define kCMDeviceOnlineNotification         CFSTR("CMDeviceOnlineNotification")
; #define kCMDeviceOfflineNotification        CFSTR("CMDeviceOfflineNotification")
; #define kCMDeviceStateNotification          CFSTR("CMDeviceStateNotification")
; #define kCMDefaultDeviceNotification        CFSTR("CMDefaultDeviceNotification")
; #define kCMDeviceProfilesNotification       CFSTR("CMDeviceProfilesNotification")
; #define kCMDefaultDeviceProfileNotification CFSTR("CMDefaultDeviceProfileNotification")
; 
;     Device state data.
; 

(def-mactype :CMDeviceState (find-mactype ':UInt32))
; 
;     A CMDeviceID must be unique within a device's class.
; 

(def-mactype :CMDeviceID (find-mactype ':UInt32))
; 
;     A CMDeviceProfileID must only be unique per device.
; 

(def-mactype :CMDeviceProfileID (find-mactype ':UInt32))
; 
;     DeviceClass type.
; 

(defconstant $cmScannerDeviceClass :|scnr|)
(defconstant $cmCameraDeviceClass :|cmra|)
(defconstant $cmDisplayDeviceClass :|mntr|)
(defconstant $cmPrinterDeviceClass :|prtr|)
(defconstant $cmProofDeviceClass :|pruf|)

(def-mactype :CMDeviceClass (find-mactype ':OSType))
; 
;     CMDeviceScope
;     Structure specifying a device's or a device setting's scope.
; 
(defrecord CMDeviceScope
   (deviceUser (:pointer :__CFString))          ;  kCFPreferencesCurrentUser | _AnyUser 
   (deviceHost (:pointer :__CFString))          ;  kCFPreferencesCurrentHost | _AnyHost 
)

;type name? (%define-record :CMDeviceScope (find-record-descriptor ':CMDeviceScope))

(%define-record :CMDeviceProfileScope (find-record-descriptor ':CMDeviceScope))
; 
;     CMDeviceInfo
;     Structure containing information on a given device.
; 
(defrecord CMDeviceInfo
   (dataVersion :UInt32)                        ;  cmDeviceInfoVersion1 
   (deviceClass :OSType)                        ;  device class 
   (deviceID :UInt32)                           ;  device ID 
   (deviceScope :CMDeviceScope)                 ;  device's scope 
   (deviceState :UInt32)                        ;  Device State flags 
   (defaultProfileID :UInt32)                   ;  Can change 
   (deviceName (:pointer :CFDictionaryRef))     ;  Ptr to storage for CFDictionary of 
                                                ;  localized device names (could be nil) 
   (profileCount :UInt32)                       ;  Count of registered profiles 
   (reserved :UInt32)                           ;  Reserved for use by ColorSync 
)

;type name? (%define-record :CMDeviceInfo (find-record-descriptor ':CMDeviceInfo))

(def-mactype :CMDeviceInfoPtr (find-mactype '(:pointer :CMDeviceInfo)))
; 
;     CMDeviceProfileInfo
;     Structure containing information on a device profile.
; 
(defrecord CMDeviceProfileInfo
   (dataVersion :UInt32)                        ;  cmDeviceProfileInfoVersion1 
   (profileID :UInt32)                          ;  The identifier for this profile 
   (profileLoc :CMProfileLocation)              ;  The profile's location 
   (profileName (:pointer :__CFDictionary))     ;  CFDictionary of localized profile names 
   (reserved :UInt32)                           ;  Reserved for use by ColorSync 
)

;type name? (%define-record :CMDeviceProfileInfo (find-record-descriptor ':CMDeviceProfileInfo))
(defrecord NCMDeviceProfileInfo
   (dataVersion :UInt32)                        ;  cmDeviceProfileInfoVersion2 
   (profileID :UInt32)                          ;  The identifier for this profile 
   (profileLoc :CMProfileLocation)              ;  The profile's location 
   (profileName (:pointer :__CFDictionary))     ;  CFDictionary of localized profile names 
   (profileScope :CMDeviceScope)                ;  The scope this profile applies to 
   (reserved :UInt32)                           ;  Reserved for use by ColorSync 
)

;type name? (%define-record :NCMDeviceProfileInfo (find-record-descriptor ':NCMDeviceProfileInfo))
; 
;     CMDeviceProfileArray
;     Structure containing the profiles for a device.
; 
(defrecord CMDeviceProfileArray
   (profileCount :UInt32)                       ;  Count of profiles in array 
   (profiles (:array :CMDeviceProfileInfo 1))   ;  The profile info records 
)

;type name? (%define-record :CMDeviceProfileArray (find-record-descriptor ':CMDeviceProfileArray))

(def-mactype :CMDeviceProfileArrayPtr (find-mactype '(:pointer :CMDeviceProfileArray)))
; 
;     Caller-supplied iterator functions
; 

(def-mactype :CMIterateDeviceInfoProcPtr (find-mactype ':pointer)); (const CMDeviceInfo * deviceInfo , void * refCon)

(def-mactype :CMIterateDeviceProfileProcPtr (find-mactype ':pointer)); (const CMDeviceInfo * deviceInfo , const NCMDeviceProfileInfo * profileInfo , void * refCon)
; 
;     Device Registration
; 
; 
;  *  CMRegisterColorDevice()
;  *  
;  *  Summary:
;  *    Registers a device with ColorSync
;  *  
;  *  Discussion:
;  *    For a device to be recognized by ColorSync it needs to register
;  *    itself via this API.  After calling this API, the
;  *    CMSetDeviceFactoryProfiles API should be called to specify the
;  *    initial modes and profiles for the device. Registration need only
;  *    happen once, when the device is installed.
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to add
;  *    
;  *    deviceID:
;  *      (in) Device id to add
;  *    
;  *    deviceName:
;  *      (in) Dictionary containing localized names
;  *    
;  *    deviceScope:
;  *      (in) Scope where information should be stored
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMRegisterColorDevice" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
    (deviceName (:pointer :__CFDictionary))
    (deviceScope (:pointer :CMDeviceScope))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMUnregisterColorDevice()
;  *  
;  *  Summary:
;  *    Unregisters a device with ColorSync
;  *  
;  *  Discussion:
;  *    When a device is no longer to be used on a system (as opposed to
;  *    just being offline), it should be unregistered. If a device is
;  *    temporariy shut down or disconnected it need not be unregistered
;  *    unless the device driver knows that it will not be used (e.g.
;  *    being deinstalled) or cannot access the device profiles without
;  *    the device.
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to remove
;  *    
;  *    deviceID:
;  *      (in) Device id to remove
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMUnregisterColorDevice" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;     Default Device accessors
; 
; 
;  *  CMSetDefaultDevice()
;  *  
;  *  Summary:
;  *    Specifeis the default device of a class
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to modify
;  *    
;  *    deviceID:
;  *      (in) Device id to make default
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMSetDefaultDevice" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMGetDefaultDevice()
;  *  
;  *  Summary:
;  *    Returns the default device of a class
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to query
;  *    
;  *    deviceID:
;  *      (out) Returns default device for class
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMGetDefaultDevice" 
   ((deviceClass :OSType)
    (deviceID (:pointer :CMDEVICEID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;     Device Profile Registration & Access
; 
; 
;  *  CMSetDeviceFactoryProfiles()
;  *  
;  *  Summary:
;  *    Registers a device's factory profiles with ColorSync
;  *  
;  *  Discussion:
;  *    This API establishes the profiles used by a particular device for
;  *    it's various modes. It is meant to be called once, right after
;  *    device registration to notify ColorSync of the device's profiles.
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to modify
;  *    
;  *    deviceID:
;  *      (in) Device id to modify
;  *    
;  *    defaultProfID:
;  *      (in) The id of the default profile
;  *    
;  *    deviceProfiles:
;  *      (in) List of profile IDs, names, and locations
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMSetDeviceFactoryProfiles" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
    (defaultProfID :UInt32)
    (deviceProfiles (:pointer :CMDeviceProfileArray))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMGetDeviceFactoryProfiles()
;  *  
;  *  Summary:
;  *    Returns all the device's factory profiles
;  *  
;  *  Discussion:
;  *    This API allows the caller to retrieve the original profiles for
;  *    a device. These may differ from the profiles currently in use for
;  *    that device in the case where factory profiles have been
;  *    overriden with custom profiles.
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to query
;  *    
;  *    deviceID:
;  *      (in) Device id to query (can be cmDefaultDeviceID)
;  *    
;  *    defaultProfID:
;  *      (out) Returns id of default mode (optional)
;  *    
;  *    arraySize:
;  *      (in/out) Size of buffer passed in / Returns size of array in
;  *      bytes
;  *    
;  *    deviceProfiles:
;  *      (out) Returns list of profile IDs, names, and locations
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMGetDeviceFactoryProfiles" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
    (defaultProfID (:pointer :CMDEVICEPROFILEID));  can be NULL 
    (arraySize (:pointer :UInt32))
    (deviceProfiles (:pointer :CMDeviceProfileArray))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMSetDeviceProfiles()
;  *  
;  *  Summary:
;  *    Specifies custom overide profiles for a device
;  *  
;  *  Discussion:
;  *    This API provides a way to overide the factory profiles of a
;  *    device for a particular mode or modes. To set custom profiles,
;  *    the profileScope and deviceProfiles params must be valid. To
;  *    remove all custom profiles of a device, pass in nil for the
;  *    profileScope and deviceProfiles parameters.
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to change
;  *    
;  *    deviceID:
;  *      (in) Device id to change (can be cmDefaultDeviceID)
;  *    
;  *    profileScope:
;  *      (in) Scope where information should be stored (or nil to remove
;  *      all)
;  *    
;  *    deviceProfiles:
;  *      (in) Profiles to set (or nil to remove all)
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMSetDeviceProfiles" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
    (profileScope (:pointer :CMDEVICEPROFILESCOPE));  can be NULL 
    (deviceProfiles (:pointer :CMDeviceProfileArray));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMGetDeviceProfiles()
;  *  
;  *  Summary:
;  *    Returns all the device's current profiles
;  *  
;  *  Discussion:
;  *    This API allows the caller to retrieve the current profiles for a
;  *    device.
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to query
;  *    
;  *    deviceID:
;  *      (in) Device id to query (can be cmDefaultDeviceID)
;  *    
;  *    arraySize:
;  *      (in/out) Size of buffer passed in / Returns size of array in
;  *      bytes
;  *    
;  *    deviceProfiles:
;  *      (out) Returns list of profile IDs, names, and locations
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMGetDeviceProfiles" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
    (arraySize (:pointer :UInt32))
    (deviceProfiles (:pointer :CMDeviceProfileArray))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMSetDeviceDefaultProfileID()
;  *  
;  *  Summary:
;  *    Specifies a device's default profile mode
;  *  
;  *  Discussion:
;  *    This API allows the caller to change the default profile ID for a
;  *    device. The initial default is established when
;  *    CMSetDeviceFactoryProfiles is called.
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to modify
;  *    
;  *    deviceID:
;  *      (in) Device id to modify (can be cmDefaultDeviceID)
;  *    
;  *    defaultProfID:
;  *      (in) New device default
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMSetDeviceDefaultProfileID" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
    (defaultProfID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMGetDeviceDefaultProfileID()
;  *  
;  *  Summary:
;  *    Returns the default profile ID for a device
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to query
;  *    
;  *    deviceID:
;  *      (in) Device id to query (can be cmDefaultDeviceID)
;  *    
;  *    defaultProfID:
;  *      (out) Returns id of default profile
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMGetDeviceDefaultProfileID" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
    (defaultProfID (:pointer :CMDEVICEPROFILEID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMSetDeviceProfile()
;  *  
;  *  Summary:
;  *    Specifies a custom overide profile for a device
;  *  
;  *  Discussion:
;  *    This API provides a way to change one of the profiles used by a
;  *    device for a particular mode. It can be called after device
;  *    registration by calibration applications to reset a device's
;  *    profile from its factory default to a custom calibrated profile.
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to modify
;  *    
;  *    deviceID:
;  *      (in) Device id to modify (can be cmDefaultDeviceID)
;  *    
;  *    profileScope:
;  *      (in) Scope where information should be stored
;  *    
;  *    profileID:
;  *      (in) Profile id to modify (can be cmDefaultProfileID)
;  *    
;  *    profileLoc:
;  *      (in) New profile location
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMSetDeviceProfile" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
    (profileScope (:pointer :CMDEVICEPROFILESCOPE))
    (profileID :UInt32)
    (profileLoc (:pointer :CMProfileLocation))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMGetDeviceProfile()
;  *  
;  *  Summary:
;  *    Returns the location of the current profile for a given device
;  *    class, device ID, and profile ID
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to query
;  *    
;  *    deviceID:
;  *      (in) Device id to query (can be cmDefaultDeviceID)
;  *    
;  *    profileID:
;  *      (in) Profile id to query (can be cmDefaultDeviceID)
;  *    
;  *    profileLoc:
;  *      (out) Returns profile location
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMGetDeviceProfile" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
    (profileID :UInt32)
    (profileLoc (:pointer :CMProfileLocation))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;     Other Device State/Info accessors
; 
; 
;  *  CMSetDeviceState()
;  *  
;  *  Summary:
;  *    Specifies the state of a device
;  *  
;  *  Discussion:
;  *    This API provides access for the device management layer to
;  *    update the state of a particular device. For example, a device
;  *    can be offline, busy, calibrated, etc. The state data passed in
;  *    replaces the old state data with the new value.
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to modify
;  *    
;  *    deviceID:
;  *      (in) Device id to modify (can be cmDefaultDeviceID)
;  *    
;  *    deviceState:
;  *      (in) New device state
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMSetDeviceState" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
    (deviceState :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMGetDeviceState()
;  *  
;  *  Summary:
;  *    Returns the state of a device.
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to query
;  *    
;  *    deviceID:
;  *      (in) Device id to query (can be cmDefaultDeviceID)
;  *    
;  *    deviceState:
;  *      (out) Returns device state
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMGetDeviceState" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
    (deviceState (:pointer :CMDEVICESTATE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMGetDeviceInfo()
;  *  
;  *  Summary:
;  *    Returns information about a device.
;  *  
;  *  Discussion:
;  *    This API returns information about a registered device. If, on
;  *    input, deviceInfo->deviceName is nil then the name is not
;  *    returned. If the caller wants the device name dictionary
;  *    returned, then the caller should provide in
;  *    deviceInfo->deviceName the address where this API should store
;  *    the CFDictionaryRef. The caller is responsible for disposing of
;  *    the name dictionary.
;  *  
;  *  Parameters:
;  *    
;  *    deviceClass:
;  *      (in) Device class to query
;  *    
;  *    deviceID:
;  *      (in) Device id to query (can be cmDefaultDeviceID)
;  *    
;  *    deviceInfo:
;  *      (in/out) Returns device information
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMGetDeviceInfo" 
   ((deviceClass :OSType)
    (deviceID :UInt32)
    (deviceInfo (:pointer :CMDeviceInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;     Device Info & Profile Iterators
; 
; 
;  *  CMIterateColorDevices()
;  *  
;  *  Summary:
;  *    Returns information about all devices to a callback procedure.
;  *  
;  *  Discussion:
;  *    This API allows the caller to get device information about all
;  *    registered color devices.  If provided, the supplied proceedure
;  *    will be called once for each registered device, passing in the
;  *    device info and the supplied refcon. If the caller passes in a
;  *    pointer to a seed value that is the same as the current seed
;  *    value, then the callback proc is not called.
;  *  
;  *  Parameters:
;  *    
;  *    proc:
;  *      (in) Client callback proc (optional)
;  *    
;  *    seed:
;  *      (in/out) seed value (optional)
;  *    
;  *    count:
;  *      (out) Returns count of devices (optional)
;  *    
;  *    refCon:
;  *      (in) Passed to callback proc (optional)
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMIterateColorDevices" 
   ((proc :pointer)
    (seed (:pointer :UInt32))                   ;  can be NULL 
    (count (:pointer :UInt32))                  ;  can be NULL 
    (refCon :pointer)                           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  CMIterateDeviceProfiles()
;  *  
;  *  Summary:
;  *    Returns information about profiles of all devices to a callback
;  *    procedure.
;  *  
;  *  Discussion:
;  *    This API allows the caller to get device information about
;  *    profiles of all registered color devices.  If provided, the
;  *    supplied proceedure will be called once for each registered
;  *    device, passing in the device info, the profile info and the
;  *    supplied refcon. If the caller passes in a pointer to a seed
;  *    value that is the same as the current seed value, then the
;  *    callback proc is not called.
;  *  
;  *  Parameters:
;  *    
;  *    proc:
;  *      (in) Client callback proc (optional)
;  *    
;  *    seed:
;  *      (in/out) seed value (optional)
;  *    
;  *    count:
;  *      (out) Returns count of devices (optional)
;  *    
;  *    flags:
;  *      (in) Options for which set of profiles are to be iterated. It
;  *      can have the following possible values:
;  *      cmIterateFactoryDeviceProfiles, cmIterateCustomDeviceProfiles,
;  *      cmIterateCurrentDeviceProfiles, cmIterateAllDeviceProfiles or
;  *      0. The flag value 0 behaves like cmIterateCurrentDeviceProfiles.
;  *    
;  *    refCon:
;  *      (in) Passed to callback proc (optional)
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMIterateDeviceProfiles" 
   ((proc :pointer)
    (seed (:pointer :UInt32))                   ;  can be NULL 
    (count (:pointer :UInt32))                  ;  can be NULL 
    (flags :UInt32)
    (refCon :pointer)                           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __CMDEVICEINTEGRATION__ */


(provide-interface "CMDeviceIntegration")