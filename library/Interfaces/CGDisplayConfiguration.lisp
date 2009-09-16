(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGDisplayConfiguration.h"
; at Sunday July 2,2006 7:24:01 pm.
; 
;  *  CGDisplayConfiguration.h
;  *  CoreGraphics
;  *
;  *  Copyright (c) 2002 Apple Computer, Inc. All rights reserved.
;  *
;  
; #ifndef __CGDISPLAY_CONFIGURATION_H__
(defconstant $__CGDISPLAY_CONFIGURATION_H__ 1)
; #define __CGDISPLAY_CONFIGURATION_H__ 1

(require-interface "IOKit/IOKitLib")

(require-interface "CoreGraphics/CGDirectDisplay")

(require-interface "AvailabilityMacros")
; 
;  * Display reconfiguration process.
;  * Call CGBeginDisplayConfiguration to start.
;  * Make all desired changes, for all displays.
;  * Commit the changes using CGPerformDisplayConfiguration(), or cancel with
;  * CGCancelDisplayConfiguration()
;  *
;  * The resulting layout will be adjusted so as to remove gaps or overlaps from
;  * the requested layout, if needed.
;  

(def-mactype :CGDisplayConfigRef (find-mactype '(:pointer :_CGDisplayConfigRef)))
;  Get a new CGDisplayConfigRef 

(deftrap-inline "_CGBeginDisplayConfiguration" 
   ((pConfigRef (:pointer :CGDISPLAYCONFIGREF))
   )
   :SInt32
() )
; 
;  * Set the origin point for a display
;  *
;  * Note that setting the origin of a display which is mirroring
;  * another display will remove that display from any mirroring set.
;  *
;  * Any display whose origin is not explicitly set in a reconfiguration
;  * will be repositioned to a location as close as possible to it's
;  * current location without overlapping or leaving a gap between displays.
;  *
;  * The actual position a display is placed at will be as close as possible
;  * to the requested location without overlapping or leaving a gap between
;  * displays.
;  

(deftrap-inline "_CGConfigureDisplayOrigin" 
   ((configRef (:pointer :_CGDisplayConfigRef))
    (display (:pointer :_CGDirectDisplayID))
    (x :SInt32)
    (y :SInt32)
   )
   :SInt32
() )
; 
;  * Set the display mode
;  *
;  * The mode dictionary passed in must be a dictionary vended by other CGDirectDisplay
;  * APIs such as CGDisplayBestModeForParameters() and CGDisplayAvailableModes().
;  *
;  * When changing display modes of displays in a mirroring set, other displays in
;  * the mirroring set whose mode is not explicitly changed will be set to a display
;  * mode capable of mirroring the bounds of the largest display being explicitly set. 
;  

(deftrap-inline "_CGConfigureDisplayMode" 
   ((configRef (:pointer :_CGDisplayConfigRef))
    (display (:pointer :_CGDirectDisplayID))
    (mode (:pointer :__CFDictionary))
   )
   :SInt32
() )
; 
;  * Make a display a mirror of masterDisplay.
;  *
;  * Use a CGDirectDisplayID of kCGNullDirectDisplay for the masterDisplay to disable
;  * mirroring.
;  * Use a CGDirectDisplayID of CGMainDisplayID() for the masterDisplay to mirror
;  * the main display.
;  *
;  * Mirroring requests will be filled with hardware mirroring when possible,
;  * at the device driver's choice.  Displays will be matted as appropriate,
;  * using either hardware or software matte generation, again at the device driver's choice.
;  *
;  * Note that when hardware mirroring is in effect, the device driver may bind the hardware
;  * accelerator, drawing engine, and 3D engine to any one of the displays in the hardware
;  * mirroring set.  That display will become the active display for drawing purposes in that
;  * hardware mirroring set.  Use CGDisplayPrimaryDisplay() to determine the correct display
;  * device to process drawing operations in a hardware mirroring set.
;  *
;  * An app that uses CGGetActiveDisplayList() to determine the proper displays to draw to
;  * (All Carbon and Cocoa apps using windows and/or DrawSprocket fall into this class)
;  * will automatically get the correct behavior.
;  

(deftrap-inline "_CGConfigureDisplayMirrorOfDisplay" 
   ((configRef (:pointer :_CGDisplayConfigRef))
    (display (:pointer :_CGDirectDisplayID))
    (masterDisplay (:pointer :_CGDirectDisplayID))
   )
   :SInt32
() )
;  Cancel a reconfiguration operation, discarding the configRef 

(deftrap-inline "_CGCancelDisplayConfiguration" 
   ((configRef (:pointer :_CGDisplayConfigRef))
   )
   :SInt32
() )
; 
;  * Perform the requested reconfigurations and discard the configRef
;  *
;  * A configuration change can apply for the life of an app, the life of a login session, or
;  * permanently. If a request is made to make a change permanent, and the change
;  * cannot be supported by the Aqua UI (resolution and pixel depth constraints apply),
;  * then the configuration  change is demoted to lasting the session.
;  *
;  * A permanent configuration change also becomes the current session's
;  * configuration.
;  *
;  * When the system reverts confgurations at app termination, the
;  * configuration always reverts to the session or permanent configuration setting.
;  *
;  * When the system reverts confgurations at session termination, the
;  * configuration always reverts to the permanent configuration setting.
;  *
;  * This operation may fail if:
;  *     An unsupported display mode is requested
;  *     Another app is running in full-screen mode
;  *
;  

(defconstant $kCGConfigureForAppOnly 0)
(defconstant $kCGConfigureForSession 1)
(defconstant $kCGConfigurePermanently 2)

(def-mactype :CGConfigureOption (find-mactype ':UInt32))

(deftrap-inline "_CGCompleteDisplayConfiguration" 
   ((configRef (:pointer :_CGDisplayConfigRef))
    (option :UInt32)
   )
   :SInt32
() )
;  Restore the permanent display configuration from the user's display preferences settings 

(deftrap-inline "_CGRestorePermanentDisplayConfiguration" 
   (
   )
   :void
() )
; 
;  * Applications may want to register for notifications of display changes.
;  *
;  * Display changes are reported via a callback mechanism.
;  *
;  * Callbacks are invoked when the app is listening for events,
;  * on the event processing thread, or from within the display
;  * reconfiguration function when in the program that is driving the
;  * reconfiguration.
;  *
;  * Callbacks should avoid attempting to change display configurations,
;  * and should not raise exceptions or perform a non-local return such as
;  * calling longjmp().
;  *
;  * Before display reconfiguration, a callback fires to inform
;  * applications of a pending configuration change. The callback runs
;  * once for each on-line display.  The flags passed in are set to
;  * kCGDisplayBeginConfigurationFlag.  This callback does not
;  * carry other per-display information, as details of how a
;  * reconfiguration affects a particular device rely on device-specific
;  * behaviors which may not be exposed by a device driver.
;  *
;  * After display reconfiguration, at the time the callback function
;  * is invoked, all display state reported by CoreGraphics, QuickDraw,
;  * and the Carbon Display Manager API will be up to date.  This callback
;  * runs after the Carbon Display Manager notification callbacks.
;  * The callback runs once for each added, removed, and currently
;  * on-line display.  Note that in the case of removed displays, calls into
;  * the CoreGraphics API with the removed display ID will fail.
;  

(defconstant $kCGDisplayBeginConfigurationFlag 1);  Set in pre-reconfiguration callback 

(defconstant $kCGDisplayMovedFlag 2)            ;  post-reconfiguration callback flag 

(defconstant $kCGDisplaySetMainFlag 4)          ;  post-reconfiguration callback flag 

(defconstant $kCGDisplaySetModeFlag 8)          ;  post-reconfiguration callback flag 

(defconstant $kCGDisplayAddFlag 16)             ;  post-reconfiguration callback flag 

(defconstant $kCGDisplayRemoveFlag 32)          ;  post-reconfiguration callback flag 

(defconstant $kCGDisplayEnabledFlag #x100)      ;  post-reconfiguration callback flag 

(defconstant $kCGDisplayDisabledFlag #x200)     ;  post-reconfiguration callback flag 

(defconstant $kCGDisplayMirrorFlag #x400)       ;  post-reconfiguration callback flag 
;  post-reconfiguration callback flag 

(defconstant $kCGDisplayUnMirrorFlag #x800)

(def-mactype :CGDisplayChangeSummaryFlags (find-mactype ':UInt32))

(def-mactype :CGDisplayReconfigurationCallBack (find-mactype ':pointer)); (CGDirectDisplayID display , CGDisplayChangeSummaryFlags flags , void * userInfo)
; 
;  * Register and remove a display reconfiguration callback procedure
;  * The userInfo argument is passed back to the callback procedure each time
;  * it is invoked.
;  

(deftrap-inline "_CGDisplayRegisterReconfigurationCallback" 
   ((proc :pointer)
    (userInfo :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_CGDisplayRemoveReconfigurationCallback" 
   ((proc :pointer)
    (userInfo :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
;  * These APIs allow applications and higher level frameworks
;  * such as DrawSprocket to determine interesting properties
;  * of displays, such as if a display is built-in, if a display
;  * is the main display, if a display is being mirrored, which
;  * display in a hardware mirror set is bound to the graphics
;  * accelerator (important for games!) and so on.
;  *
;  * An app that uses CGGetActiveDisplayList() to determine the
;  * proper displays to draw to (All Carbon and Cocoa apps using
;  * windows and/or DrawSprocket fall into this class) will
;  * automatically get the correct behavior without using these APIs.
;  * These APIs are primarily of interest to specialized applications
;  * such as movie players, integrated TV/video graphics utilities,
;  * and similar specialized applications.
;  
;  True if the display is connected, awake, and drawable 

(deftrap-inline "_CGDisplayIsActive" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :signed-long
() )
;  True if the display is asleep and therefore not drawable 

(deftrap-inline "_CGDisplayIsAsleep" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :signed-long
() )
; 
;  * True if the display is valid, with a monitor connected
;  * (support for hot plugging of monitors)
;  

(deftrap-inline "_CGDisplayIsOnline" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :signed-long
() )
;  True if the display is the current main display 

(deftrap-inline "_CGDisplayIsMain" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :signed-long
() )
;  True if the display is built in, such as the internal display in portables 

(deftrap-inline "_CGDisplayIsBuiltin" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :signed-long
() )
;  True if the display is in a mirroring set 

(deftrap-inline "_CGDisplayIsInMirrorSet" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :signed-long
() )
;  True if the display is always in a mirroring set, and cannot be unmirrored 

(deftrap-inline "_CGDisplayIsAlwaysInMirrorSet" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :signed-long
() )
;  True if the display is in a hardware mirroring set 

(deftrap-inline "_CGDisplayIsInHWMirrorSet" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :signed-long
() )
;  Returns display being mirrored, or kCGNullDirectDisplay if master or unmirrored 

(deftrap-inline "_CGDisplayMirrorsDisplay" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   (:pointer :_CGDirectDisplayID)
() )
;  True if the display is using OpenGL acceleration 

(deftrap-inline "_CGDisplayUsesOpenGLAcceleration" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :signed-long
() )
; 
;  * Returns the display bound to the hardware accelerator in a HW mirror set,
;  * or 'display' if software mirrored or unmirrored
;  

(deftrap-inline "_CGDisplayPrimaryDisplay" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   (:pointer :_CGDirectDisplayID)
() )
; 
;  * Returns the logical unit, vendor ID, vendor model number,
;  * and serial number for a display
;  

(deftrap-inline "_CGDisplayUnitNumber" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :UInt32
() )

(deftrap-inline "_CGDisplayVendorNumber" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :UInt32
() )

(deftrap-inline "_CGDisplayModelNumber" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :UInt32
() )

(deftrap-inline "_CGDisplaySerialNumber" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :UInt32
() )
;  Returns the IOKit service port for a display device 

(deftrap-inline "_CGDisplayIOServicePort" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :pointer
() )
; 
;  * Returns the size of the specified display in millimeters.
;  *
;  * If 'display' is not a valid display ID, the size returned has a width and height of 0.
;  *
;  * If EDID data for the display device is not available, the size is estimated based on
;  * the device width and height in pixels from CGDisplayBounds(), with an assumed resolution
;  * of 2.835 pixels/mm, or 72 DPI, a reasonable guess for displays predating EDID support.
;  

(deftrap-inline "_CGDisplayScreenSize" 
   ((returnArg (:pointer :CGSize))
    (display (:pointer :_CGDirectDisplayID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

; #endif /* __CGDISPLAY_CONFIGURATION_H__ */


(provide-interface "CGDisplayConfiguration")