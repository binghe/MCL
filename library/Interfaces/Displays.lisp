(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Displays.h"
; at Sunday July 2,2006 7:24:33 pm.
; 
;      File:       QD/Displays.h
;  
;      Contains:   Display Manager Interfaces.
;  
;      Version:    Quickdraw-150~1
;  
;      Copyright:  © 1993-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __DISPLAYS__
; #define __DISPLAYS__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __VIDEO__
#| #|
#include <QDVideo.h>
#endif
|#
 |#
; #ifndef __CMAPPLICATION__
#| #|
#include <ColorSyncCMApplication.h>
#endif
|#
 |#
; #ifndef __APPLEEVENTS__
#| #|
#include <AEAppleEvents.h>
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

(def-mactype :DMProcessInfoPtr (find-mactype '(:pointer :void)))

(def-mactype :DMModalFilterUPP (find-mactype '(:pointer :void)))
;  AppleEvents Core Suite 

(defconstant $kAESystemConfigNotice :|cnfg|)    ;  Core Suite types 

(defconstant $kAEDisplayNotice :|dspl|)
(defconstant $kAEDisplaySummary :|dsum|)
(defconstant $keyDMConfigVersion :|dmcv|)
(defconstant $keyDMConfigFlags :|dmcf|)
(defconstant $keyDMConfigReserved :|dmcr|)
(defconstant $keyDisplayID :|dmid|)
(defconstant $keyDisplayComponent :|dmdc|)
(defconstant $keyDisplayDevice :|dmdd|)
(defconstant $keyDisplayFlags :|dmdf|)
(defconstant $keyDisplayMode :|dmdm|)
(defconstant $keyDisplayModeReserved :|dmmr|)
(defconstant $keyDisplayReserved :|dmdr|)
(defconstant $keyDisplayMirroredId :|dmmi|)
(defconstant $keyDeviceFlags :|dddf|)
(defconstant $keyDeviceDepthMode :|dddm|)
(defconstant $keyDeviceRect :|dddr|)
(defconstant $keyPixMapRect :|dpdr|)
(defconstant $keyPixMapHResolution :|dphr|)
(defconstant $keyPixMapVResolution :|dpvr|)
(defconstant $keyPixMapPixelType :|dppt|)
(defconstant $keyPixMapPixelSize :|dpps|)
(defconstant $keyPixMapCmpCount :|dpcc|)
(defconstant $keyPixMapCmpSize :|dpcs|)
(defconstant $keyPixMapAlignment :|dppa|)
(defconstant $keyPixMapResReserved :|dprr|)
(defconstant $keyPixMapReserved :|dppr|)
(defconstant $keyPixMapColorTableSeed :|dpct|)
(defconstant $keySummaryMenubar :|dsmb|)
(defconstant $keySummaryChanges :|dsch|)
(defconstant $keyDisplayOldConfig :|dold|)
(defconstant $keyDisplayNewConfig :|dnew|)

(defconstant $dmOnlyActiveDisplays $true)
(defconstant $dmAllDisplays $false)
;  DMSendDependentNotification notifyClass 

(defconstant $kDependentNotifyClassShowCursor :|shcr|);  When display mgr shows a hidden cursor during an unmirror 

(defconstant $kDependentNotifyClassDriverOverride :|ndrv|);  When a driver is overridden 

(defconstant $kDependentNotifyClassDisplayMgrOverride :|dmgr|);  When display manager is upgraded 

(defconstant $kDependentNotifyClassProfileChanged :|prof|);  When DMSetProfileByAVID is called 

;  Switch Flags 

(defconstant $kNoSwitchConfirmBit 0)            ;  Flag indicating that there is no need to confirm a switch to this mode 

(defconstant $kDepthNotAvailableBit 1)          ;  Current depth not available in new mode 

(defconstant $kShowModeBit 3)                   ;  Show this mode even though it requires a confirm. 

(defconstant $kModeNotResizeBit 4)              ;  Do not use this mode to resize display (for cards that mode drives a different connector). 

(defconstant $kNeverShowModeBit 5)              ;  This mode should not be shown in the user interface. 

;     Summary Change Flags (sticky bits indicating an operation was performed)
;     For example, moving a display then moving it back will still set the kMovedDisplayBit.
; 

(defconstant $kBeginEndConfigureBit 0)
(defconstant $kMovedDisplayBit 1)
(defconstant $kSetMainDisplayBit 2)
(defconstant $kSetDisplayModeBit 3)
(defconstant $kAddDisplayBit 4)
(defconstant $kRemoveDisplayBit 5)
(defconstant $kNewDisplayBit 6)
(defconstant $kDisposeDisplayBit 7)
(defconstant $kEnabledDisplayBit 8)
(defconstant $kDisabledDisplayBit 9)
(defconstant $kMirrorDisplayBit 10)
(defconstant $kUnMirrorDisplayBit 11)
;  Notification Messages for extended call back routines 

(defconstant $kDMNotifyRequestConnectionProbe 0);  Like kDMNotifyRequestDisplayProbe only not for smart displays (used in wake before all busses are awake) 

(defconstant $kDMNotifyInstalled 1)             ;  At install time 

(defconstant $kDMNotifyEvent 2)                 ;  Post change time 

(defconstant $kDMNotifyRemoved 3)               ;  At remove time 

(defconstant $kDMNotifyPrep 4)                  ;  Pre change time 

(defconstant $kDMNotifyExtendEvent 5)           ;  Allow registrees to extend apple event before it is sent 

(defconstant $kDMNotifyDependents 6)            ;  Minor notification check without full update 

(defconstant $kDMNotifySuspendConfigure 7)      ;  Temporary end of configuration 

(defconstant $kDMNotifyResumeConfigure 8)       ;  Resume configuration 

(defconstant $kDMNotifyRequestDisplayProbe 9)   ;  Request smart displays re-probe (used in sleep and hot plugging) 

(defconstant $kDMNotifyDisplayWillSleep 10)     ;  Mac OS X only 

(defconstant $kDMNotifyDisplayDidWake 11)       ;  Mac OS X only 
;  Notification Flags 

(defconstant $kExtendedNotificationProc #x10000)
;  types for notifyType 

(defconstant $kFullNotify 0)                    ;  This is the appleevent whole nine yards notify 

(defconstant $kFullDependencyNotify 1)          ;  Only sends to those who want to know about interrelated functionality (used for updating UI) 

;  DisplayID/DeviceID constants 

(defconstant $kDummyDeviceID #xFF)              ;  This is the ID of the dummy display, used when the last ÒrealÓ display is disabled.

(defconstant $kInvalidDisplayID 0)              ;  This is the invalid ID

(defconstant $kFirstDisplayID #x100)
;  bits for panelListFlags 

(defconstant $kAllowDuplicatesBit 0)
;  bits for nameFlags 

(defconstant $kSuppressNumberBit 0)
(defconstant $kSuppressNumberMask 1)
(defconstant $kForceNumberBit 1)
(defconstant $kForceNumberMask 2)
(defconstant $kSuppressNameBit 2)
(defconstant $kSuppressNameMask 4)
;  DMGetNameByAVID masks

(defconstant $kDMSupressNumbersMask 1)          ;  Supress the numbers and return only names

(defconstant $kDMForceNumbersMask 2)            ;  Force numbers to always be shown (even on single display configs)
;  Supress the names and return only numbers.

(defconstant $kDMSupressNameMask 4)
;  Constants for fidelity checks 

(defconstant $kNoFidelity 0)
(defconstant $kMinimumFidelity 1)
(defconstant $kDefaultFidelity #x1F4)           ;  I'm just picking a number for Apple default panels and engines

(defconstant $kDefaultManufacturerFidelity #x3E8);  I'm just picking a number for Manufacturer's panels and engines (overrides apple defaults)


(defconstant $kAnyPanelType 0)                  ;  Pass to DMNewEngineList for list of all panels (as opposed to specific types)

(defconstant $kAnyEngineType 0)                 ;  Pass to DMNewEngineList for list of all engines

(defconstant $kAnyDeviceType 0)                 ;  Pass to DMNewDeviceList for list of all devices

(defconstant $kAnyPortType 0)                   ;  Pass to DMNewDevicePortList for list of all devices

;  portListFlags for DM_NewDevicePortList 
;  Should offline devices be put into the port list (such as dummy display) 

(defconstant $kPLIncludeOfflineDevicesBit 0)
;  confirmFlags for DMConfirmConfiguration 

(defconstant $kForceConfirmBit 0)               ;  Force a confirm dialog 

(defconstant $kForceConfirmMask 1)
;  Flags for displayModeFlags 

(defconstant $kDisplayModeListNotPreferredBit 0)
(defconstant $kDisplayModeListNotPreferredMask 1)
;  Flags for itemFlags 

(defconstant $kComponentListNotPreferredBit 0)
(defconstant $kComponentListNotPreferredMask 1)

(defconstant $kDisplayTimingInfoVersionZero 1)
(defconstant $kDisplayTimingInfoReservedCountVersionZero 16)
(defconstant $kDisplayModeEntryVersionZero 0)   ;  displayModeVersion - original version

(defconstant $kDisplayModeEntryVersionOne 1)    ;  displayModeVersion - added displayModeOverrideInfo


(defconstant $kMakeAndModelReservedCount 4)     ;  Number of reserved fields

;  Display Gestalt for DMDisplayGestalt

(defconstant $kDisplayGestaltDisplayCommunicationAttr :|comm|)
(defconstant $kDisplayGestaltForbidI2CMask 1)   ;  Some displays have firmware problems if they get I2C communication.  If this bit is set, then I2C communication is forbidden

(defconstant $kDisplayGestaltUseI2CPowerMask 2) ;  Some displays require I2C power settings (most use DPMS).

(defconstant $kDisplayGestaltCalibratorAttr :|cali|)
(defconstant $kDisplayGestaltBrightnessAffectsGammaMask 1);  Used by default calibrator (should we show brightness panel) 
;  Currently not used by color sync

(defconstant $kDisplayGestaltViewAngleAffectsGammaMask 2)

(def-mactype :DMFidelityType (find-mactype ':UInt32))
; 
;    AVID is an ID for ports and devices the old DisplayID type
;     is carried on for compatibility
; 

(def-mactype :DMListType (find-mactype '(:pointer :void)))

(def-mactype :DMListIndexType (find-mactype ':UInt32))

(%define-record :AVPowerStateRec (find-record-descriptor ':VDPowerStateRec))

(def-mactype :AVPowerStatePtr (find-mactype '(:pointer :VDPowerStateRec)))
(defrecord DMDisplayTimingInfoRec
   (timingInfoVersion :UInt32)
   (timingInfoAttributes :UInt32)               ;  Flags 
   (timingInfoRelativeQuality :SInt32)          ;  quality of the timing 
   (timingInfoRelativeDefault :SInt32)          ;  relative default of the timing 
   (timingInfoReserved (:array :UInt32 16))     ;  Reserved 
)

;type name? (%define-record :DMDisplayTimingInfoRec (find-record-descriptor ':DMDisplayTimingInfoRec))

(def-mactype :DMDisplayTimingInfoPtr (find-mactype '(:pointer :DMDisplayTimingInfoRec)))
(defrecord DMComponentListEntryRec
   (itemID :UInt32)                             ;  DisplayID Manager
   (itemComponent (:pointer :ComponentRecord))  ;  Component Manager
   (itemDescription :ComponentDescription)      ;  We can always construct this if we use something beyond the compontent mgr.
   (itemClass :FourCharCode)                    ;  Class of group to put this panel (eg geometry/color/etc for panels, brightness/contrast for engines, video out/sound/etc for devices)
   (itemFidelity :UInt32)                       ;  How good is this item for the specified search?
   (itemSubClass :FourCharCode)                 ;  Subclass of group to put this panel.  Can use to do sub-grouping (eg volume for volume panel and mute panel)
   (itemSort :Point)                            ;  Set to 0 - future to sort the items in a sub group.
   (itemFlags :UInt32)                          ;  Set to 0 (future expansion)
   (itemReserved :FourCharCode)                 ;  What kind of code does the itemReference point to  (right now - kPanelEntryTypeComponentMgr only)
   (itemFuture1 :UInt32)                        ;  Set to 0 (future expansion - probably an alternate code style)
   (itemFuture2 :UInt32)                        ;  Set to 0 (future expansion - probably an alternate code style)
   (itemFuture3 :UInt32)                        ;  Set to 0 (future expansion - probably an alternate code style)
   (itemFuture4 :UInt32)                        ;  Set to 0 (future expansion - probably an alternate code style)
)

;type name? (%define-record :DMComponentListEntryRec (find-record-descriptor ':DMComponentListEntryRec))

(def-mactype :DMComponentListEntryPtr (find-mactype '(:pointer :DMComponentListEntryRec)))
;  ¥¥¥ Move AVLocationRec to AVComponents.i AFTER AVComponents.i is created
(defrecord AVLocationRec
   (locationConstant :UInt32)                   ;  Set to 0 (future expansion - probably an alternate code style)
)

;type name? (%define-record :AVLocationRec (find-record-descriptor ':AVLocationRec))

(def-mactype :AVLocationPtr (find-mactype '(:pointer :AVLocationRec)))
(defrecord DMDepthInfoRec
   (depthSwitchInfo (:pointer :VDSwitchInfoRec));  This is the switch mode to choose this timing/depth 
   (depthVPBlock (:pointer :VPBlock))           ;  VPBlock (including size, depth and format) 
   (depthFlags :UInt32)                         ;  VDVideoParametersInfoRec.csDepthFlags  
   (depthReserved1 :UInt32)                     ;  Reserved 
   (depthReserved2 :UInt32)                     ;  Reserved 
)

;type name? (%define-record :DMDepthInfoRec (find-record-descriptor ':DMDepthInfoRec))

(def-mactype :DMDepthInfoPtr (find-mactype '(:pointer :DMDepthInfoRec)))
(defrecord DMDepthInfoBlockRec
   (depthBlockCount :UInt32)                    ;  How many depths are there? 
   (depthVPBlock (:pointer :DMDepthInfoRec))    ;  Array of DMDepthInfoRec 
   (depthBlockFlags :UInt32)                    ;  Reserved 
   (depthBlockReserved1 :UInt32)                ;  Reserved 
   (depthBlockReserved2 :UInt32)                ;  Reserved 
)

;type name? (%define-record :DMDepthInfoBlockRec (find-record-descriptor ':DMDepthInfoBlockRec))

(def-mactype :DMDepthInfoBlockPtr (find-mactype '(:pointer :DMDepthInfoBlockRec)))
(defrecord DMDisplayModeListEntryRec
   (displayModeFlags :UInt32)
   (displayModeSwitchInfo (:pointer :VDSwitchInfoRec))
   (displayModeResolutionInfo (:pointer :VDResolutionInfoRec))
   (displayModeTimingInfo (:pointer :VDTimingInfoRec))
   (displayModeDepthBlockInfo (:pointer :DMDepthInfoBlockRec));  Information about all the depths
   (displayModeVersion :UInt32)                 ;  What version is this record (now kDisplayModeEntryVersionOne)
   (displayModeName (:pointer :UInt8))          ;  Name of the timing mode
   (displayModeDisplayInfo (:pointer :DMDisplayTimingInfoRec));  Information from the display.
)

;type name? (%define-record :DMDisplayModeListEntryRec (find-record-descriptor ':DMDisplayModeListEntryRec))

(def-mactype :DMDisplayModeListEntryPtr (find-mactype '(:pointer :DMDisplayModeListEntryRec)))
(defrecord DependentNotifyRec
   (notifyType :FourCharCode)                   ;  What type was the engine that made the change (may be zero)
   (notifyClass :FourCharCode)                  ;  What class was the change (eg geometry, color etc)
   (notifyPortID :UInt32)                       ;  Which device was touched (kInvalidDisplayID -> all or none)
   (notifyComponent (:pointer :ComponentInstanceRecord));  What engine did it (may be 0)?
   (notifyVersion :UInt32)                      ;  Set to 0 (future expansion)
   (notifyFlags :UInt32)                        ;  Set to 0 (future expansion)
   (notifyReserved :UInt32)                     ;  Set to 0 (future expansion)
   (notifyFuture :UInt32)                       ;  Set to 0 (future expansion)
)

;type name? (%define-record :DependentNotifyRec (find-record-descriptor ':DependentNotifyRec))

(def-mactype :DependentNotifyPtr (find-mactype '(:pointer :DependentNotifyRec)))
(defrecord DMMakeAndModelRec
   (manufacturer :FourCharCode)
   (model :UInt32)
   (serialNumber :UInt32)
   (manufactureDate :UInt32)
   (makeReserved (:array :UInt32 4))
)

;type name? (%define-record :DMMakeAndModelRec (find-record-descriptor ':DMMakeAndModelRec))

(def-mactype :DMMakeAndModelPtr (find-mactype '(:pointer :DMMakeAndModelRec)))
;  DMNewDisplayList displayListIncludeFlags

(defconstant $kIncludeOnlineActiveDisplaysMask 1)
(defconstant $kIncludeOnlineDisabledDisplaysMask 2)
(defconstant $kIncludeOfflineDisplaysMask 4)
(defconstant $kIncludeOfflineDummyDisplaysMask 8)
(defconstant $kIncludeHardwareMirroredDisplaysMask 16)
;  modeListFlags for DMNewDisplayModeList 

(defconstant $kDMModeListIncludeAllModesMask 1) ;  Include all timing modes not _explicitly_ excluded (see other bits)

(defconstant $kDMModeListIncludeOfflineModesMask 2)
(defconstant $kDMModeListExcludeDriverModesMask 4);  Exclude old-style timing modes (cscGetNextResolution/kDisplayModeIDFindFirstResolution modes)

(defconstant $kDMModeListExcludeDisplayModesMask 8);  Exclude timing modes that come from the display (always arbritrary timing modes)

(defconstant $kDMModeListExcludeCustomModesMask 16);  Exclude custom modes that came neither from the driver or display (need a better name)

(defconstant $kDMModeListPreferStretchedModesMask 32);  Prefer modes that are stretched over modes that are letterboxed when setting kDisplayModeListNotPreferredBit
;  Prefer modes that are safe over modes that are not when setting kDisplayModeListNotPreferredBit

(defconstant $kDMModeListPreferSafeModesMask 64)
;  DMNewDisplayList displayListFlags
(defrecord DisplayListEntryRec
   (displayListEntryGDevice (:Handle :GDEVICE))
   (displayListEntryDisplayID :UInt32)
   (displayListEntryIncludeFlags :UInt32)       ;  Reason this entry was included
   (displayListEntryReserved1 :UInt32)
   (displayListEntryReserved2 :UInt32)          ;  Zero
   (displayListEntryReserved3 :UInt32)          ;  Zero
   (displayListEntryReserved4 :UInt32)          ;  Zero
   (displayListEntryReserved5 :UInt32)          ;  Zero
)

;type name? (%define-record :DisplayListEntryRec (find-record-descriptor ':DisplayListEntryRec))

(def-mactype :DisplayListEntryPtr (find-mactype '(:pointer :DisplayListEntryRec)))
(defrecord DMProfileListEntryRec
   (profileRef (:pointer :OpaqueCMProfileRef))
   (profileReserved1 :pointer)                  ;  Reserved
   (profileReserved2 :pointer)                  ;  Reserved
   (profileReserved3 :pointer)                  ;  Reserved
)

;type name? (%define-record :DMProfileListEntryRec (find-record-descriptor ':DMProfileListEntryRec))

(def-mactype :DMProfileListEntryPtr (find-mactype '(:pointer :DMProfileListEntryRec)))

(def-mactype :DMNotificationProcPtr (find-mactype ':pointer)); (AppleEvent * theEvent)

(def-mactype :DMExtendedNotificationProcPtr (find-mactype ':pointer)); (void * userData , short theMessage , void * notifyData)

(def-mactype :DMComponentListIteratorProcPtr (find-mactype ':pointer)); (void * userData , DMListIndexType itemIndex , DMComponentListEntryPtr componentInfo)

(def-mactype :DMDisplayModeListIteratorProcPtr (find-mactype ':pointer)); (void * userData , DMListIndexType itemIndex , DMDisplayModeListEntryPtr displaymodeInfo)

(def-mactype :DMProfileListIteratorProcPtr (find-mactype ':pointer)); (void * userData , DMListIndexType itemIndex , DMProfileListEntryPtr profileInfo)

(def-mactype :DMDisplayListIteratorProcPtr (find-mactype ':pointer)); (void * userData , DMListIndexType itemIndex , DisplayListEntryPtr displaymodeInfo)

(def-mactype :DMNotificationUPP (find-mactype '(:pointer :OpaqueDMNotificationProcPtr)))

(def-mactype :DMExtendedNotificationUPP (find-mactype '(:pointer :OpaqueDMExtendedNotificationProcPtr)))

(def-mactype :DMComponentListIteratorUPP (find-mactype '(:pointer :OpaqueDMComponentListIteratorProcPtr)))

(def-mactype :DMDisplayModeListIteratorUPP (find-mactype '(:pointer :OpaqueDMDisplayModeListIteratorProcPtr)))

(def-mactype :DMProfileListIteratorUPP (find-mactype '(:pointer :OpaqueDMProfileListIteratorProcPtr)))

(def-mactype :DMDisplayListIteratorUPP (find-mactype '(:pointer :OpaqueDMDisplayListIteratorProcPtr)))
; 
;  *  NewDMNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDMNotificationUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDMNotificationProcPtr)
() )
; 
;  *  NewDMExtendedNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDMExtendedNotificationUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDMExtendedNotificationProcPtr)
() )
; 
;  *  NewDMComponentListIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDMComponentListIteratorUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDMComponentListIteratorProcPtr)
() )
; 
;  *  NewDMDisplayModeListIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDMDisplayModeListIteratorUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDMDisplayModeListIteratorProcPtr)
() )
; 
;  *  NewDMProfileListIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDMProfileListIteratorUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDMProfileListIteratorProcPtr)
() )
; 
;  *  NewDMDisplayListIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDMDisplayListIteratorUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDMDisplayListIteratorProcPtr)
() )
; 
;  *  DisposeDMNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDMNotificationUPP" 
   ((userUPP (:pointer :OpaqueDMNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDMExtendedNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDMExtendedNotificationUPP" 
   ((userUPP (:pointer :OpaqueDMExtendedNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDMComponentListIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDMComponentListIteratorUPP" 
   ((userUPP (:pointer :OpaqueDMComponentListIteratorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDMDisplayModeListIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDMDisplayModeListIteratorUPP" 
   ((userUPP (:pointer :OpaqueDMDisplayModeListIteratorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDMProfileListIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDMProfileListIteratorUPP" 
   ((userUPP (:pointer :OpaqueDMProfileListIteratorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDMDisplayListIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDMDisplayListIteratorUPP" 
   ((userUPP (:pointer :OpaqueDMDisplayListIteratorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDMNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDMNotificationUPP" 
   ((theEvent (:pointer :AppleEvent))
    (userUPP (:pointer :OpaqueDMNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDMExtendedNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDMExtendedNotificationUPP" 
   ((userData :pointer)
    (theMessage :SInt16)
    (notifyData :pointer)
    (userUPP (:pointer :OpaqueDMExtendedNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDMComponentListIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDMComponentListIteratorUPP" 
   ((userData :pointer)
    (itemIndex :UInt32)
    (componentInfo (:pointer :DMComponentListEntryRec))
    (userUPP (:pointer :OpaqueDMComponentListIteratorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDMDisplayModeListIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDMDisplayModeListIteratorUPP" 
   ((userData :pointer)
    (itemIndex :UInt32)
    (displaymodeInfo (:pointer :DMDisplayModeListEntryRec))
    (userUPP (:pointer :OpaqueDMDisplayModeListIteratorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDMProfileListIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDMProfileListIteratorUPP" 
   ((userData :pointer)
    (itemIndex :UInt32)
    (profileInfo (:pointer :DMProfileListEntryRec))
    (userUPP (:pointer :OpaqueDMProfileListIteratorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDMDisplayListIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDMDisplayListIteratorUPP" 
   ((userData :pointer)
    (itemIndex :UInt32)
    (displaymodeInfo (:pointer :DisplayListEntryRec))
    (userUPP (:pointer :OpaqueDMDisplayListIteratorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DMDisplayGestalt()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DisplayLib 2.1 and later
;  
; 
;  *  DMUseScreenPrefs()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DisplayLib 2.1 and later
;  
; 
;  *  DMSuspendConfigure()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DisplayLib 2.1 and later
;  
; 
;  *  DMResumeConfigure()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DisplayLib 2.1 and later
;  
; 
;  *  DMSetGammaByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DisplayLib 2.1 and later
;  
; 
;  *  DMGetGammaByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DisplayLib 2.1 and later
;  
; 
;  *  DMGetMakeAndModelByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DisplayLib 2.1 and later
;  
; 
;  *  DMNewDisplayList()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DisplayLib 2.1 and later
;  
; 
;  *  DMGetIndexedDisplayFromList()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DisplayLib 2.1 and later
;  
; 
;  *  DMNewProfileListByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DisplayLib 2.1 and later
;  
; 
;  *  DMGetIndexedProfileFromList()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DisplayLib 2.1 and later
;  
; 
;  *  DMGetFirstScreenDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMGetFirstScreenDevice" 
   ((activeOnly :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :GDEVICE)
() )
; 
;  *  DMGetNextScreenDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMGetNextScreenDevice" 
   ((theDevice (:Handle :GDEVICE))
    (activeOnly :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :GDEVICE)
() )
; 
;  *  DMDrawDesktopRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMDrawDesktopRect" 
   ((globalRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DMDrawDesktopRegion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMDrawDesktopRegion" 
   ((globalRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DMBeginConfigureDisplays()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMBeginConfigureDisplays" 
   ((displayState (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMEndConfigureDisplays()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMEndConfigureDisplays" 
   ((displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMAddDisplay()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMAddDisplay" 
   ((newDevice (:Handle :GDEVICE))
    (driver :SInt16)
    (mode :UInt32)
    (reserved :UInt32)
    (displayID :UInt32)
    (displayComponent (:pointer :ComponentRecord))
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMMoveDisplay()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMMoveDisplay" 
   ((moveDevice (:Handle :GDEVICE))
    (x :SInt16)
    (y :SInt16)
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMDisableDisplay()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMDisableDisplay" 
   ((disableDevice (:Handle :GDEVICE))
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMEnableDisplay()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMEnableDisplay" 
   ((enableDevice (:Handle :GDEVICE))
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMRemoveDisplay()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMRemoveDisplay" 
   ((removeDevice (:Handle :GDEVICE))
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMSetMainDisplay()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMSetMainDisplay" 
   ((newMainDevice (:Handle :GDEVICE))
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMSetDisplayMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMSetDisplayMode" 
   ((theDevice (:Handle :GDEVICE))
    (mode :UInt32)
    (depthMode (:pointer :UInt32))
    (reserved :UInt32)
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMCheckDisplayMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMCheckDisplayMode" 
   ((theDevice (:Handle :GDEVICE))
    (mode :UInt32)
    (depthMode :UInt32)
    (switchFlags (:pointer :UInt32))
    (reserved :UInt32)
    (modeOk (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetDeskRegion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMGetDeskRegion" 
   ((desktopRegion (:pointer :RGNHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMRegisterNotifyProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMRegisterNotifyProc" 
   ((notificationProc (:pointer :OpaqueDMNotificationProcPtr))
    (whichPSN (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMRemoveNotifyProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMRemoveNotifyProc" 
   ((notificationProc (:pointer :OpaqueDMNotificationProcPtr))
    (whichPSN (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMQDIsMirroringCapable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_DMQDIsMirroringCapable" 
   ((qdIsMirroringCapable (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMCanMirrorNow()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_DMCanMirrorNow" 
   ((canMirrorNow (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMIsMirroringOn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_DMIsMirroringOn" 
   ((isMirroringOn (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMMirrorDevices()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_DMMirrorDevices" 
   ((gD1 (:Handle :GDEVICE))
    (gD2 (:Handle :GDEVICE))
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMUnmirrorDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_DMUnmirrorDevice" 
   ((gDevice (:Handle :GDEVICE))
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetNextMirroredDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_DMGetNextMirroredDevice" 
   ((gDevice (:Handle :GDEVICE))
    (mirroredDevice (:pointer :GDHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMBlockMirroring()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_DMBlockMirroring" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMUnblockMirroring()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_DMUnblockMirroring" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetDisplayMgrA5World()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  
; 
;  *  DMGetDisplayIDByGDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_DMGetDisplayIDByGDevice" 
   ((displayDevice (:Handle :GDEVICE))
    (displayID (:pointer :DISPLAYIDTYPE))
    (failToMain :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetGDeviceByDisplayID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_DMGetGDeviceByDisplayID" 
   ((displayID :UInt32)
    (displayDevice (:pointer :GDHANDLE))
    (failToMain :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMSetDisplayComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMSetDisplayComponent" 
   ((theDevice (:Handle :GDEVICE))
    (displayComponent (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetDisplayComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMGetDisplayComponent" 
   ((theDevice (:Handle :GDEVICE))
    (displayComponent (:pointer :COMPONENT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMNewDisplay()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_DMNewDisplay" 
   ((newDevice (:pointer :GDHANDLE))
    (driverRefNum :SInt16)
    (mode :UInt32)
    (reserved :UInt32)
    (displayID :UInt32)
    (displayComponent (:pointer :ComponentRecord))
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMDisposeDisplay()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_DMDisposeDisplay" 
   ((disposeDevice (:Handle :GDEVICE))
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMResolveDisplayComponents()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DMResolveDisplayComponents" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMRegisterExtendedNotifyProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib 2.0 and later
;  

(deftrap-inline "_DMRegisterExtendedNotifyProc" 
   ((notifyProc (:pointer :OpaqueDMExtendedNotificationProcPtr))
    (notifyUserData :pointer)
    (nofifyOnFlags :UInt16)
    (whichPSN (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMRemoveExtendedNotifyProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib 2.0 and later
;  

(deftrap-inline "_DMRemoveExtendedNotifyProc" 
   ((notifyProc (:pointer :OpaqueDMExtendedNotificationProcPtr))
    (notifyUserData :pointer)
    (whichPSN (:pointer :void))
    (removeFlags :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMNewAVPanelList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMNewAVPanelList" 
   ((displayID :UInt32)
    (panelType :FourCharCode)
    (minimumFidelity :UInt32)
    (panelListFlags :UInt32)
    (reserved :UInt32)
    (thePanelCount (:pointer :DMLISTINDEXTYPE))
    (thePanelList (:pointer :DMLISTTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMNewAVEngineList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMNewAVEngineList" 
   ((displayID :UInt32)
    (engineType :FourCharCode)
    (minimumFidelity :UInt32)
    (engineListFlags :UInt32)
    (reserved :UInt32)
    (engineCount (:pointer :DMLISTINDEXTYPE))
    (engineList (:pointer :DMLISTTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMNewAVDeviceList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMNewAVDeviceList" 
   ((deviceType :FourCharCode)
    (deviceListFlags :UInt32)
    (reserved :UInt32)
    (deviceCount (:pointer :DMLISTINDEXTYPE))
    (deviceList (:pointer :DMLISTTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMNewAVPortListByPortType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMNewAVPortListByPortType" 
   ((subType :FourCharCode)
    (portListFlags :UInt32)
    (reserved :UInt32)
    (devicePortCount (:pointer :DMLISTINDEXTYPE))
    (theDevicePortList (:pointer :DMLISTTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetIndexedComponentFromList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMGetIndexedComponentFromList" 
   ((panelList (:pointer :void))
    (itemIndex :UInt32)
    (reserved :UInt32)
    (listIterator (:pointer :OpaqueDMComponentListIteratorProcPtr))
    (userData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMDisposeList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib 2.0 and later
;  

(deftrap-inline "_DMDisposeList" 
   ((panelList (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetNameByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMGetNameByAVID" 
   ((theID :UInt32)
    (nameFlags :UInt32)
    (name (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMNewAVIDByPortComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMNewAVIDByPortComponent" 
   ((thePortComponent (:pointer :ComponentRecord))
    (portKind :FourCharCode)
    (reserved :UInt32)
    (newID (:pointer :AVIDType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetPortComponentByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMGetPortComponentByAVID" 
   ((thePortID :UInt32)
    (thePortComponent (:pointer :COMPONENT))
    (theDesciption (:pointer :ComponentDescription))
    (thePortKind (:pointer :ResType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMSendDependentNotification()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib 2.0 and later
;  

(deftrap-inline "_DMSendDependentNotification" 
   ((notifyType :FourCharCode)
    (notifyClass :FourCharCode)
    (displayID :UInt32)
    (notifyComponent (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMDisposeAVComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMDisposeAVComponent" 
   ((theAVComponent (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMSaveScreenPrefs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMSaveScreenPrefs" 
   ((reserved1 :UInt32)
    (saveFlags :UInt32)
    (reserved2 :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMNewAVIDByDeviceComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMNewAVIDByDeviceComponent" 
   ((theDeviceComponent (:pointer :ComponentRecord))
    (portKind :FourCharCode)
    (reserved :UInt32)
    (newID (:pointer :DISPLAYIDTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMNewAVPortListByDeviceAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMNewAVPortListByDeviceAVID" 
   ((theID :UInt32)
    (minimumFidelity :UInt32)
    (portListFlags :UInt32)
    (reserved :UInt32)
    (devicePortCount (:pointer :DMLISTINDEXTYPE))
    (theDevicePortList (:pointer :DMLISTTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetDeviceComponentByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMGetDeviceComponentByAVID" 
   ((theDeviceID :UInt32)
    (theDeviceComponent (:pointer :COMPONENT))
    (theDesciption (:pointer :ComponentDescription))
    (theDeviceKind (:pointer :ResType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMNewDisplayModeList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMNewDisplayModeList" 
   ((displayID :UInt32)
    (modeListFlags :UInt32)
    (reserved :UInt32)
    (thePanelCount (:pointer :DMLISTINDEXTYPE))
    (thePanelList (:pointer :DMLISTTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetIndexedDisplayModeFromList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMGetIndexedDisplayModeFromList" 
   ((panelList (:pointer :void))
    (itemIndex :UInt32)
    (reserved :UInt32)
    (listIterator (:pointer :OpaqueDMDisplayModeListIteratorProcPtr))
    (userData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetGraphicInfoByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMGetGraphicInfoByAVID" 
   ((theID :UInt32)
    (theAVPcit (:pointer :PICHANDLE))
    (theAVIconSuite (:pointer :Handle))
    (theAVLocation (:pointer :AVLocationRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetAVPowerState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMGetAVPowerState" 
   ((theID :UInt32)
    (getPowerState (:pointer :VDPowerStateRec))
    (reserved1 :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMSetAVPowerState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMSetAVPowerState" 
   ((theID :UInt32)
    (setPowerState (:pointer :VDPowerStateRec))
    (powerFlags :UInt32)
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetDeviceAVIDByPortAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMGetDeviceAVIDByPortAVID" 
   ((portAVID :UInt32)
    (deviceAVID (:pointer :AVIDType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetEnableByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMGetEnableByAVID" 
   ((theAVID :UInt32)
    (isAVIDEnabledNow (:pointer :Boolean))
    (canChangeEnableNow (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMSetEnableByAVID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMSetEnableByAVID" 
   ((theAVID :UInt32)
    (doEnable :Boolean)
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMGetDisplayMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
;  

(deftrap-inline "_DMGetDisplayMode" 
   ((theDevice (:Handle :GDEVICE))
    (switchInfo (:pointer :VDSwitchInfoRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DMConfirmConfiguration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DisplayLib 2.1 and later
;  

(deftrap-inline "_DMConfirmConfiguration" 
   ((filterProc (:pointer :void))
    (confirmFlags :UInt32)
    (reserved :UInt32)
    (displayState :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __DISPLAYS__ */


(provide-interface "Displays")