(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGDirectDisplay.h"
; at Sunday July 2,2006 7:23:59 pm.
; 
;  *  CGDirectDisplay.h
;  *  CoreGraphics
;  *
;  *  Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
;  *
;  
; #ifndef __CGDIRECT_DISPLAY_H__
(defconstant $__CGDIRECT_DISPLAY_H__ 1)
; #define __CGDIRECT_DISPLAY_H__ 1

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreGraphics/CGGeometry")

(require-interface "CoreGraphics/CGError")

(require-interface "CoreGraphics/CGContext")

(require-interface "CoreFoundation/CoreFoundation")

(require-interface "stdint")

(require-interface "AvailabilityMacros")
; 
;  * The following construct is present to avoid problems with some Apple tools.
;  * API in this module is not available in Mac OS Classic variations!
;  
; #ifndef __MACOS_CLASSIC__

(require-interface "mach/boolean")
#| 
; #else

;type name? (def-mactype :boolean_t (find-mactype ':signed-long))
 |#

; #endif


(def-mactype :CGDirectDisplayID (find-mactype '(:pointer :_CGDirectDisplayID)))

(def-mactype :CGDirectPaletteRef (find-mactype '(:pointer :_CGDirectPaletteRef)))

(def-mactype :CGDisplayCount (find-mactype ':UInt32))

(def-mactype :CGTableCount (find-mactype ':UInt32))

(def-mactype :CGDisplayCoord (find-mactype ':SInt32))

(def-mactype :CGByteValue (find-mactype ':UInt8))

(def-mactype :CGOpenGLDisplayMask (find-mactype ':UInt32))

(def-mactype :CGBeamPosition (find-mactype ':UInt32))

(def-mactype :CGMouseDelta (find-mactype ':SInt32))

(def-mactype :CGRefreshRate (find-mactype ':double-float))

(def-mactype :CGCaptureOptions (find-mactype ':UInt32))

(def-mactype :CGDisplayErr (find-mactype ':SInt32))
; #define CGDisplayNoErr kCGErrorSuccess
(defconstant $kCGNullDirectDisplay 0)
; #define kCGNullDirectDisplay ((CGDirectDisplayID)0)
;  Returns the display ID of the current main display 

(deftrap-inline "_CGMainDisplayID" 
   (
   )
   (:pointer :_CGDirectDisplayID)
() )
; #define kCGDirectMainDisplay CGMainDisplayID()
; 
;  * Mechanisms used to find screen IDs
;  * An array length (maxDisplays) and array of CGDirectDisplayIDs are passed in.
;  * Up to maxDisplays of the array are filled in with the displays meeting the
;  * specified criteria.  The actual number of displays filled in is returned in
;  * dspyCnt.
;  *
;  * If the dspys array is NULL, maxDisplays is ignored, and *dspyCnt is filled
;  * in with the number of displays meeting the function's requirements.
;  

(deftrap-inline "_CGGetDisplaysWithPoint" 
   ((x :single-float)
    (y :single-float)
    (maxDisplays :UInt32)
    (dspys (:pointer :CGDirectDisplayID))
    (dspyCnt (:pointer :CGDISPLAYCOUNT))
   )
   :SInt32
() )

(deftrap-inline "_CGGetDisplaysWithRect" 
   (  ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
    (maxDisplays :UInt32)
    (dspys (:pointer :CGDirectDisplayID))
    (dspyCnt (:pointer :CGDISPLAYCOUNT))
   )
   :SInt32
() )

(deftrap-inline "_CGGetDisplaysWithOpenGLDisplayMask" 
   ((mask :UInt32)
    (maxDisplays :UInt32)
    (dspys (:pointer :CGDirectDisplayID))
    (dspyCnt (:pointer :CGDISPLAYCOUNT))
   )
   :SInt32
() )
; 
;  * Get lists of displays.  Use this to determine display IDs
;  *
;  * If the activeDspys array is NULL, maxDisplays is ignored, and *dspyCnt is filled
;  * in with the number of displays meeting the function's requirements.
;  *
;  * The first display returned in the list is the main display,
;  * the one with the menu bar.
;  * When mirroring, this will be the largest drawable display in the mirror,
;  * set, or if all are the same size, the one with the deepest pixel depth.
;  

(deftrap-inline "_CGGetActiveDisplayList" 
   ((maxDisplays :UInt32)
    (activeDspys (:pointer :CGDirectDisplayID))
    (dspyCnt (:pointer :CGDISPLAYCOUNT))
   )
   :SInt32
() )
; 
;  * With hardware mirroring, a display may be on-line,
;  * but not necessarily active, or drawable.
;  * Programs which manipulate display settings such as the
;  * palette or gamma tables need access to all displays in use,
;  * including hardware mirrors which are not drawable.
;  

(deftrap-inline "_CGGetOnlineDisplayList" 
   ((maxDisplays :UInt32)
    (onlineDspys (:pointer :CGDirectDisplayID))
    (dspyCnt (:pointer :CGDISPLAYCOUNT))
   )
   :SInt32
() )
;  Map a display to an OpenGL display mask; returns 0 on invalid display 

(deftrap-inline "_CGDisplayIDToOpenGLDisplayMask" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :UInt32
() )
; 
;  * Map an OpenGL display mask to a display.
;  * Returns kCGNullDirectDisplay if a bit doesn't
;  * match a display.
;  * Passing in multiple bits results in an arbitrary match. 
;  

(deftrap-inline "_CGOpenGLDisplayMaskToDisplayID" 
   ((mask :UInt32)
   )
   (:pointer :_CGDirectDisplayID)
() )
;  Return screen size and origin in global coords; Empty rect if display is invalid 

(deftrap-inline "_CGDisplayBounds" 
   ((returnArg (:pointer :CGRect))
    (display (:pointer :_CGDirectDisplayID))
   )
   nil
() )

(deftrap-inline "_CGDisplayPixelsWide" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :unsigned-long
() )

(deftrap-inline "_CGDisplayPixelsHigh" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :unsigned-long
() )
; 
;  * Display mode selection
;  * Display modes are represented as CFDictionaries
;  * All dictionaries and arrays returned via these mechanisms are
;  * owned by the framework and should not be released.  The framework
;  * will not release them out from under your application.
;  *
;  * Values associated with the following keys are CFNumber types.
;  * With CFNumberGetValue(), use kCFNumberLongType for best results.
;  * kCGDisplayRefreshRate encodes a double value, so to get the fractional
;  * refresh rate use kCFNumberDoubleType.
;  
; 
;  * Keys used in mode dictionaries.  Source C strings shown won't change.
;  * Some CFM environments cannot import data variables, and so
;  * the definitions are provided directly.
;  *
;  * These keys are used only within the scope of the mode dictionaries,
;  * so further uniquing, as by prefix, of the source string is not needed.
;  
; #define kCGDisplayWidth				CFSTR("Width")
; #define kCGDisplayHeight			CFSTR("Height")
; #define kCGDisplayMode				CFSTR("Mode")
; #define kCGDisplayBitsPerPixel			CFSTR("BitsPerPixel")
; #define kCGDisplayBitsPerSample			CFSTR("BitsPerSample")
; #define kCGDisplaySamplesPerPixel		CFSTR("SamplesPerPixel")
; #define kCGDisplayRefreshRate			CFSTR("RefreshRate")
; #define kCGDisplayModeUsableForDesktopGUI	CFSTR("UsableForDesktopGUI")
; #define kCGDisplayIOFlags			CFSTR("IOFlags")
; #define kCGDisplayBytesPerRow			CFSTR("kCGDisplayBytesPerRow")
; 
;  * Keys to describe optional properties of display modes.
;  *
;  * The key will only be present if the property applies,
;  * and will be associated with a value of kCFBooleanTrue.
;  * Keys not relevant to a particular display mode will not
;  * appear in the mode dictionary.
;  *
;  * These strings must remain unchanged in future releases, of course.
;  
;  Set if display mode doesn't need a confirmation dialog to be set 
; #define kCGDisplayModeIsSafeForHardware		CFSTR("kCGDisplayModeIsSafeForHardware")
;  The following keys reflect interesting bits of the IOKit display mode flags 
; #define kCGDisplayModeIsInterlaced		CFSTR("kCGDisplayModeIsInterlaced") 
; #define kCGDisplayModeIsStretched		CFSTR("kCGDisplayModeIsStretched")
; #define kCGDisplayModeIsTelevisionOutput	CFSTR("kCGDisplayModeIsTelevisionOutput" )
; 
;  * Return a CFArray of CFDictionaries describing all display modes.
;  * Returns NULL if the display is invalid.
;  

(deftrap-inline "_CGDisplayAvailableModes" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   (:pointer :__CFArray)
() )
; 
;  * Try to find a display mode of specified depth with dimensions equal or greater than
;  * specified.
;  * If no depth match is found, try for the next larger depth with dimensions equal or greater
;  * than specified.  If no luck, then just return the current mode.
;  *
;  * exactmatch, if not NULL, is set to 'true' if an exact match in width, height, and depth is found,
;  * and 'false' otherwise.
;  *
;  * CGDisplayBestModeForParametersAndRefreshRateWithProperty searches the list, looking for
;  * display modes with the specified property.  The property should be one of:
;  *	kCGDisplayModeIsSafeForHardware;
;  *	kCGDisplayModeIsInterlaced;
;  *	kCGDisplayModeIsStretched;
;  *	kCGDisplayModeIsTelevisionOutput
;  *	
;  * Returns NULL if display is invalid.
;  

(deftrap-inline "_CGDisplayBestModeForParameters" 
   ((display (:pointer :_CGDirectDisplayID))
    (bitsPerPixel :unsigned-long)
    (width :unsigned-long)
    (height :unsigned-long)
    (exactMatch (:pointer :boolean_t))
   )
   (:pointer :__CFDictionary)
() )

(deftrap-inline "_CGDisplayBestModeForParametersAndRefreshRate" 
   ((display (:pointer :_CGDirectDisplayID))
    (bitsPerPixel :unsigned-long)
    (width :unsigned-long)
    (height :unsigned-long)
    (refresh :double-float)
    (exactMatch (:pointer :boolean_t))
   )
   (:pointer :__CFDictionary)
() )

(deftrap-inline "_CGDisplayBestModeForParametersAndRefreshRateWithProperty" 
   ((display (:pointer :_CGDirectDisplayID))
    (bitsPerPixel :unsigned-long)
    (width :unsigned-long)
    (height :unsigned-long)
    (refresh :double-float)
    (property (:pointer :__CFString))
    (exactMatch (:pointer :boolean_t))
   )
   (:pointer :__CFDictionary)
() )
; 
;  * Return a CFDictionary describing the current display mode.
;  * Returns NULL if display is invalid.
;  

(deftrap-inline "_CGDisplayCurrentMode" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   (:pointer :__CFDictionary)
() )
; 
;  * Switch display mode.  Note that after switching, 
;  * display parameters and addresses may change.
;  * The selected display mode persists for the life of the program, and automatically
;  * reverts to the permanent setting made by Preferences when the program terminates.
;  * The mode dictionary passed in must be a dictionary vended by other CGDirectDisplay
;  * APIs such as CGDisplayBestModeForParameters() and CGDisplayAvailableModes().
;  *
;  * The mode dictionary passed in must be a dictionary vended by other CGDirectDisplay
;  * APIs such as CGDisplayBestModeForParameters() and CGDisplayAvailableModes().
;  *
;  * When changing display modes of displays in a mirroring set, other displays in
;  * the mirroring set will be set to a display mode capable of mirroring the bounds
;  * of the largest display being explicitly set. 
;  

(deftrap-inline "_CGDisplaySwitchToMode" 
   ((display (:pointer :_CGDirectDisplayID))
    (mode (:pointer :__CFDictionary))
   )
   :SInt32
() )
;  Query parameters for current mode 

(deftrap-inline "_CGDisplayBitsPerPixel" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :unsigned-long
() )

(deftrap-inline "_CGDisplayBitsPerSample" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :unsigned-long
() )

(deftrap-inline "_CGDisplaySamplesPerPixel" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :unsigned-long
() )

(deftrap-inline "_CGDisplayBytesPerRow" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :unsigned-long
() )
; 
;  * Set a display gamma/transfer function from a formula specifying
;  * min and max values and a gamma for each channel.
;  * Gamma values must be greater than 0.0.
;  * To get an antigamma of 1.6, one would specify a value of (1.0 / 1.6)
;  * Min values must be greater than or equal to 0.0 and less than 1.0.
;  * Max values must be greater than 0.0 and less than or equal to 1.0.
;  * Out of range values, or Max greater than or equal to Min result
;  * in a kCGSRangeCheck error.
;  *
;  * Values are computed by sampling a function for a range of indices from 0 through 1:
;  *	value = Min + ((Max - Min) * pow(index, Gamma))
;  * The resulting values are converted to a machine specific format
;  * and loaded into hardware.
;  

(def-mactype :CGGammaValue (find-mactype ':single-float))

(deftrap-inline "_CGSetDisplayTransferByFormula" 
   ((display (:pointer :_CGDirectDisplayID))
    (redMin :single-float)
    (redMax :single-float)
    (redGamma :single-float)
    (greenMin :single-float)
    (greenMax :single-float)
    (greenGamma :single-float)
    (blueMin :single-float)
    (blueMax :single-float)
    (blueGamma :single-float)
   )
   :SInt32
() )

(deftrap-inline "_CGGetDisplayTransferByFormula" 
   ((display (:pointer :_CGDirectDisplayID))
    (redMin (:pointer :CGGAMMAVALUE))
    (redMax (:pointer :CGGAMMAVALUE))
    (redGamma (:pointer :CGGAMMAVALUE))
    (greenMin (:pointer :CGGAMMAVALUE))
    (greenMax (:pointer :CGGAMMAVALUE))
    (greenGamma (:pointer :CGGAMMAVALUE))
    (blueMin (:pointer :CGGAMMAVALUE))
    (blueMax (:pointer :CGGAMMAVALUE))
    (blueGamma (:pointer :CGGAMMAVALUE))
   )
   :SInt32
() )
; 
;  * Returns the capacity, or nunber of entries, in the camma table for the specified
;  * display.  If 'display' is invalid, returns 0.
;  

(deftrap-inline "_CGDisplayGammaTableCapacity" 
   ((display (:pointer :_CGDirectDisplayID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
; 
;  * Set a display gamma/transfer function using tables of data for each channel.
;  * Values within each table should have values in the range of 0.0 through 1.0.
;  * The same table may be passed in for red, green, and blue channels. 'tableSize'
;  * indicates the number of entries in each table.
;  * The tables are interpolated as needed to generate the number of samples needed
;  * by hardware.
;  

(deftrap-inline "_CGSetDisplayTransferByTable" 
   ((display (:pointer :_CGDirectDisplayID))
    (tableSize :UInt32)
    (redTable (:pointer :CGGAMMAVALUE))
    (greenTable (:pointer :CGGAMMAVALUE))
    (blueTable (:pointer :CGGAMMAVALUE))
   )
   :SInt32
() )
; 
;  * Get transfer tables.  Capacity should contain the number of samples each
;  * array can hold, and *sampleCount is filled in with the number of samples
;  * actually copied in.
;  

(deftrap-inline "_CGGetDisplayTransferByTable" 
   ((display (:pointer :_CGDirectDisplayID))
    (capacity :UInt32)
    (redTable (:pointer :CGGAMMAVALUE))
    (greenTable (:pointer :CGGAMMAVALUE))
    (blueTable (:pointer :CGGAMMAVALUE))
    (sampleCount (:pointer :CGTableCount))
   )
   :SInt32
() )
;  As a convenience, allow setting of the gamma table by byte values 

(deftrap-inline "_CGSetDisplayTransferByByteTable" 
   ((display (:pointer :_CGDirectDisplayID))
    (tableSize :UInt32)
    (redTable (:pointer :CGBYTEVALUE))
    (greenTable (:pointer :CGBYTEVALUE))
    (blueTable (:pointer :CGBYTEVALUE))
   )
   :SInt32
() )
;  Restore gamma tables of system displays to the user's ColorSync specified values 

(deftrap-inline "_CGDisplayRestoreColorSyncSettings" 
   (
   )
   :void
() )
; 
;  * Options used with CGDisplayCaptureWithOptions and CGCaptureAllDisplaysWithOptions
;  

(defconstant $kCGCaptureNoOptions 0)            ;  Default behavior 
;  Disables fill with black on display capture 

(defconstant $kCGCaptureNoFill 1)
;  Display capture and release 

(deftrap-inline "_CGDisplayIsCaptured" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :signed-long
() )

(deftrap-inline "_CGDisplayCapture" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :SInt32
() )

(deftrap-inline "_CGDisplayCaptureWithOptions" 
   ((display (:pointer :_CGDirectDisplayID))
    (options :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_CGDisplayRelease" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :SInt32
() )
; 
;  * Capture all displays; this has the nice effect of providing an immersive
;  * environment, and preventing other apps from trying to adjust themselves
;  * to display changes only needed by your app.
;  

(deftrap-inline "_CGCaptureAllDisplays" 
   (
   )
   :SInt32
() )

(deftrap-inline "_CGCaptureAllDisplaysWithOptions" 
   ((options :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
;  * Release all captured displays, and restore the display modes to the
;  * user's preferences.  May be used in conjunction with CGDisplayCapture()
;  * or CGCaptureAllDisplays().
;  

(deftrap-inline "_CGReleaseAllDisplays" 
   (
   )
   :SInt32
() )
; 
;  * Returns CoreGraphics raw shield window ID or NULL if not shielded
;  * This value may be used with drawing surface APIs.
;  

(deftrap-inline "_CGShieldingWindowID" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   (:pointer :void)
() )
; 
;  * Returns the window level used for the shield window.
;  * This value may be used with Cocoa windows to position the
;  * Cocoa window in the same window level as the shield window.
;  

(deftrap-inline "_CGShieldingWindowLevel" 
   (
   )
   :SInt32
() )
; 
;  * Returns base address of display or NULL for an invalid display.
;  * If the display has not been captured, the returned address may refer
;  * to read-only memory.
;  

(deftrap-inline "_CGDisplayBaseAddress" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   (:pointer :void)
() )
; 
;  * return address for X,Y in screen coordinates;
;  *	(0,0) represents the upper left corner of the display.
;  * returns NULL for an invalid display or out of bounds coordinates
;  * If the display has not been captured, the returned address may refer
;  * to read-only memory.
;  

(deftrap-inline "_CGDisplayAddressForPosition" 
   ((display (:pointer :_CGDirectDisplayID))
    (x :SInt32)
    (y :SInt32)
   )
   (:pointer :void)
() )
;  Mouse Cursor controls 

(deftrap-inline "_CGDisplayHideCursor" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :SInt32
() )
;  increments hide cursor count 

(deftrap-inline "_CGDisplayShowCursor" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :SInt32
() )
;  decrements hide cursor count  
; 
;  * Move the cursor to the specified point relative to the display origin
;  * (the upper left corner of the display).  Returns CGDisplayNoErr on success.
;  * No events are generated as a result of this move.
;  * Points that would lie outside the desktop are clipped to the desktop.
;  

(deftrap-inline "_CGDisplayMoveCursorToPoint" 
   ((display (:pointer :_CGDirectDisplayID))
    (x :single-float)
    (y :single-float)
   )
   :SInt32
() )
; 
;  * Report the mouse position change associated with the last mouse move event
;  * recieved by this application.
;  

(deftrap-inline "_CGGetLastMouseDelta" 
   ((deltaX (:pointer :CGMOUSEDELTA))
    (deltaY (:pointer :CGMOUSEDELTA))
   )
   :void
() )
;  Palette controls (8 bit pseudocolor only) 
; 
;  * Returns TRUE if the current display mode supports palettes.
;  * Display must not be a hardware mirror of another, and should
;  * have a depth of 8 bits per pixel for this to return TRUE.
;  

(deftrap-inline "_CGDisplayCanSetPalette" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :signed-long
() )
; 
;  * Set a palette.  The current gamma function is applied to the palette
;  * elements before being loaded into hardware.  The display must not be
;  * a hardware mirror of another, and should have a depth of 8 bits per pixel.
;  * Setting the palette on the active, or primary display in a hardware
;  * mirroring set affects all displays in that set.
;  

(deftrap-inline "_CGDisplaySetPalette" 
   ((display (:pointer :_CGDirectDisplayID))
    (palette (:pointer :_CGDirectPaletteRef))
   )
   :SInt32
() )
; 
;  * Wait until the beam position is outside the range specified by upperScanLine and lowerScanLine.
;  * Note that if upperScanLine and lowerScanLine encompass the entire display height,
;  * the function returns an error.
;  * lowerScanLine must be greater than or equal to upperScanLine.
;  *
;  * Some display systems may not conventional video vertical and horizontal sweep in painting.
;  * These displays report a kCGDisplayRefreshRate of 0 in the CFDictionaryRef returned by
;  * CGDisplayCurrentMode().  On such displays, this function returns at once.
;  *
;  * Some drivers may not implement support for this mechanism.
;  * On such displays, this function returns at once.
;  *
;  * Returns CGDisplayNoErr on success, and an error if display or upperScanLine and
;  * lowerScanLine are invalid.
;  *
;  * The app should set the values of upperScanLine and lowerScanLine to allow enough lead time
;  * for the drawing operation to complete.  A common strategy is to wait for the beam to pass
;  * the bottom of the drawing area, allowing almost a full vertical sweep period to perform drawing.
;  * To do this, set upperScanLine to 0, and set lowerScanLine to the bottom of the bounding box:
;  *	lowerScanLine = (CGBeamPosition)(cgrect.origin.y + cgrect.size.height);
;  *
;  * IOKit may implement this as a spin-loop on the beam position call used for CGDisplayBeamPosition().
;  * On such system the function is CPU bound, and subject to all the usual scheduling pre-emption.
;  * In particular, attempting to wait for the beam to hit a specific scanline may be an exercise in frustration.
;  *
;  * These functions are advisary in nature, and depend on IOKit and hardware specific drivers to implement
;  * support. If you need extremely precise timing, or access to vertical blanking interrupts,
;  * you should consider writing a device driver to tie into hardware-specific capabilities.
;  

(deftrap-inline "_CGDisplayWaitForBeamPositionOutsideLines" 
   ((display (:pointer :_CGDirectDisplayID))
    (upperScanLine :UInt32)
    (lowerScanLine :UInt32)
   )
   :SInt32
() )
; 
;  * Returns the current beam position on the display.  If display is invalid,
;  * or the display does not implement conventional video vertical and horizontal
;  * sweep in painting, or the driver does not implement this functionality, 0 is returned.
;  

(deftrap-inline "_CGDisplayBeamPosition" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   :UInt32
() )
; 
;  * Obtain a CGContextRef suitable for drawing to a captured display.
;  *
;  * Returns a drawing context suitable for use on the display device.
;  * The context is owned by the device, and should not be released by
;  * the caller.
;  *
;  * The context remains valid while the display is captured, and the
;  * display configuration is unchanged.  Releasing the captured display
;  * or reconfiguring the display invalidates the drawing context.
;  *
;  * An application may register a display reconfiguration callback to determine
;  * when the display configuration is changing via CGRegisterDisplayReconfigurationProc().
;  * 
;  * After a display configuration change, or on capturing a display, call this
;  * function to obtain a current drawing context.
;  *
;  * If the display has not been captured, this function returns NULL.
;  

(deftrap-inline "_CGDisplayGetDrawingContext" 
   ((display (:pointer :_CGDirectDisplayID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :CGContext)
() )

; #endif /* __CGDIRECT_DISPLAY_H__ */


(provide-interface "CGDirectDisplay")