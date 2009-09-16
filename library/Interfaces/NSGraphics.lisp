(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSGraphics.h"
; at Sunday July 2,2006 7:30:49 pm.
; 
; 	NSGraphics.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSGeometry.h> 

; #import <AppKit/AppKitDefines.h>
; === CONSTANTS ===
;  operation types for composite operators 
;  Constants moved from dpsOpenStep.h 
(def-mactype :_NSCompositingOperation (find-mactype ':sint32))

(defconstant $NSCompositeClear 0)
(defconstant $NSCompositeCopy 1)
(defconstant $NSCompositeSourceOver 2)
(defconstant $NSCompositeSourceIn 3)
(defconstant $NSCompositeSourceOut 4)
(defconstant $NSCompositeSourceAtop 5)
(defconstant $NSCompositeDestinationOver 6)
(defconstant $NSCompositeDestinationIn 7)
(defconstant $NSCompositeDestinationOut 8)
(defconstant $NSCompositeDestinationAtop 9)
(defconstant $NSCompositeXOR 10)
(defconstant $NSCompositePlusDarker 11)
(defconstant $NSCompositeHighlight 12)
(defconstant $NSCompositePlusLighter 13)
(def-mactype :NSCompositingOperation (find-mactype ':SINT32))
;  types of window backing store 
(def-mactype :_NSBackingStoreType (find-mactype ':sint32))

(defconstant $NSBackingStoreRetained 0)
(defconstant $NSBackingStoreNonretained 1)
(defconstant $NSBackingStoreBuffered 2)
(def-mactype :NSBackingStoreType (find-mactype ':SINT32))
;  ways to order windows 
(def-mactype :_NSWindowOrderingMode (find-mactype ':sint32))

(defconstant $NSWindowAbove 1)
(defconstant $NSWindowBelow -1)
(defconstant $NSWindowOut 0)
(def-mactype :NSWindowOrderingMode (find-mactype ':SINT32))
;  order in which to draw focus ring - above or below graphic or just draw ring 

(defconstant $NSFocusRingOnly 0)
(defconstant $NSFocusRingBelow 1)
(defconstant $NSFocusRingAbove 2)
(def-mactype :NSFocusRingPlacement (find-mactype ':SINT32))

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
;  used by NSView and NSCell to configure if and how the control should draw its focus ring 
(def-mactype :_NSFocusRingType (find-mactype ':sint32))

(defconstant $NSFocusRingTypeDefault 0)
(defconstant $NSFocusRingTypeNone 1)
(defconstant $NSFocusRingTypeExterior 2)
(def-mactype :NSFocusRingType (find-mactype ':SINT32))

; #endif

;  Predefined colorspace names.
; 
(def-mactype :NSCalibratedWhiteColorSpace (find-mactype '(:pointer :NSString)))
;  1.0 == white 
(def-mactype :NSCalibratedBlackColorSpace (find-mactype '(:pointer :NSString)))
;  1.0 == black 
(def-mactype :NSCalibratedRGBColorSpace (find-mactype '(:pointer :NSString)))
(def-mactype :NSDeviceWhiteColorSpace (find-mactype '(:pointer :NSString)))
;  1.0 == white 
(def-mactype :NSDeviceBlackColorSpace (find-mactype '(:pointer :NSString)))
;  1.0 == black 
(def-mactype :NSDeviceRGBColorSpace (find-mactype '(:pointer :NSString)))
(def-mactype :NSDeviceCMYKColorSpace (find-mactype '(:pointer :NSString)))
(def-mactype :NSNamedColorSpace (find-mactype '(:pointer :NSString)))
;  Used for "catalog" colors 
(def-mactype :NSPatternColorSpace (find-mactype '(:pointer :NSString)))
(def-mactype :NSCustomColorSpace (find-mactype '(:pointer :NSString)))
;  Used to indicate a custom gstate in images 
;  NSWindowDepth defines the values used in setting window depth limits. "0" indicates default depth. Window depths should not be made persistent as they will not be the same across systems. Use the functions NSBPSFromDepth(), NSColorSpaceFromDepth(), NSBitsPerPixelFromDepth(), and NSPlanarFromDepth() to extract info from an NSWindowDepth. Use NSBestDepth() to compute window depths. NSBestDepth() will try to accomodate all the parameters (match or better); if there are multiple matches, it gives the closest, with matching colorSpace first, then bps, then planar, then bpp. bpp is "bits per pixel"; 0 indicates default (same as the number of bits per plane, either bps or bps * NSNumberOfColorComponents()); other values maybe used as hints to provide backing stores of different configuration; for instance, 8 bit color. exactMatch is optional and indicates whether all the parameters matched exactly.
; 

(def-mactype :NSWindowDepth (find-mactype ':signed-long))

(deftrap-inline "_NSBestDepth" 
   ((colorSpace (:pointer :NSString))
    (bps :signed-long)
    (bpp :signed-long)
    (planar :Boolean)
    (exactMatch (:pointer :bool))
   )
   :signed-long
() )

(deftrap-inline "_NSPlanarFromDepth" 
   ((depth :signed-long)
   )
   :Boolean
() )

(deftrap-inline "_NSColorSpaceFromDepth" 
   ((depth :signed-long)
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSBitsPerSampleFromDepth" 
   ((depth :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_NSBitsPerPixelFromDepth" 
   ((depth :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_NSNumberOfColorComponents" 
   ((colorSpaceName (:pointer :NSString))
   )
   :signed-long
() )

(deftrap-inline "_NSAvailableWindowDepths" 
   (
   )
   (:pointer :signed-long)
() )
;  0 terminated 
;  Standard gray values for the 2-bit deep grayscale colorspace.
; 
(def-mactype :NSWhite (find-mactype ':float))
(def-mactype :NSLightGray (find-mactype ':float))
(def-mactype :NSDarkGray (find-mactype ':float))
(def-mactype :NSBlack (find-mactype ':float))
;  Keys for deviceDescription dictionaries.
; 
(def-mactype :NSDeviceResolution (find-mactype '(:pointer :NSString)))
;  NSValue containing NSSize, basically dpi 
(def-mactype :NSDeviceColorSpaceName (find-mactype '(:pointer :NSString)))
;  NSString 
(def-mactype :NSDeviceBitsPerSample (find-mactype '(:pointer :NSString)))
;  NSValue containing int 
(def-mactype :NSDeviceIsScreen (find-mactype '(:pointer :NSString)))
;  "YES" or not there 
(def-mactype :NSDeviceIsPrinter (find-mactype '(:pointer :NSString)))
;  "YES" or not there 
(def-mactype :NSDeviceSize (find-mactype '(:pointer :NSString)))
;  NSValue containing NSSize 
;  Graphics functions
; 

(deftrap-inline "_NSRectFill" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSRectFillList" 
   ((rects (:pointer :NSRect))
    (count :signed-long)
   )
   nil
() )

(deftrap-inline "_NSRectFillListWithGrays" 
   ((rects (:pointer :NSRect))
    (grays (:pointer :float))
    (num :signed-long)
   )
   nil
() )

(deftrap-inline "_NSRectFillListWithColors" 
   ((rects (:pointer :NSRect))
    (colors (:pointer :nscolor))
    (num :signed-long)
   )
   nil
() )

(deftrap-inline "_NSRectFillUsingOperation" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
    (op :SInt32)
   )
   nil
() )

(deftrap-inline "_NSRectFillListUsingOperation" 
   ((rects (:pointer :NSRect))
    (count :signed-long)
    (op :SInt32)
   )
   nil
() )

(deftrap-inline "_NSRectFillListWithColorsUsingOperation" 
   ((rects (:pointer :NSRect))
    (colors (:pointer :nscolor))
    (num :signed-long)
    (op :SInt32)
   )
   nil
() )

(deftrap-inline "_NSFrameRect" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSFrameRectWithWidth" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
    (frameWidth :single-float)
   )
   nil
() )

(deftrap-inline "_NSFrameRectWithWidthUsingOperation" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
    (frameWidth :single-float)
    (op :SInt32)
   )
   nil
() )

(deftrap-inline "_NSRectClip" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSRectClipList" 
   ((rects (:pointer :NSRect))
    (count :signed-long)
   )
   nil
() )

(deftrap-inline "_NSDrawTiledRects" 
   ((returnArg (:pointer :_NSRECT))
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
    (sides (:pointer :NSRectEdge))
    (grays (:pointer :float))
    (count :signed-long)
   )
   nil
() )

(deftrap-inline "_NSDrawGrayBezel" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSDrawGroove" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSDrawWhiteBezel" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSDrawButton" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSEraseRect" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSReadPixel" 
   ((X :single-float)
    (Y :single-float)
   )
   (:pointer :nscolor)
() )

(deftrap-inline "_NSDrawBitmap" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
    (width :signed-long)
    (height :signed-long)
    (bps :signed-long)
    (spp :signed-long)
    (bpp :signed-long)
    (bpr :signed-long)
    (isPlanar :Boolean)
    (hasAlpha :Boolean)
    (colorSpaceName (:pointer :NSString))
    (data (:pointer :UInt8))
   )
   nil
() )

(deftrap-inline "_NSCopyBits" 
   ((srcGState :signed-long)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
    (X :single-float)
    (Y :single-float)
   )
   nil
() )

(deftrap-inline "_NSHighlightRect" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSBeep" 
   (
   )
   nil
() )

(deftrap-inline "_NSCountWindows" 
   ((count (:pointer :int))
   )
   nil
() )

(deftrap-inline "_NSWindowList" 
   ((size :signed-long)
    (list (:pointer :int))
   )
   nil
() )

(deftrap-inline "_NSCountWindowsForContext" 
   ((context :signed-long)
    (count (:pointer :int))
   )
   nil
() )

(deftrap-inline "_NSWindowListForContext" 
   ((context :signed-long)
    (size :signed-long)
    (list (:pointer :int))
   )
   nil
() )
;  gets performance stats about window server memory usage 

(deftrap-inline "_NSGetWindowServerMemory" 
   ((context :signed-long)
    (virtualMemory (:pointer :int))
    (windowBackingMemory (:pointer :int))
    (windowDumpString (:pointer :NSString))
   )
   :signed-long
() )

(deftrap-inline "_NSDrawColorTiledRects" 
   ((returnArg (:pointer :_NSRECT))
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
    (sides (:pointer :NSRectEdge))
    (colors (:pointer :nscolor))
    (count :signed-long)
   )
   nil
() )

(deftrap-inline "_NSDrawDarkBezel" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSDrawLightBezel" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSDottedFrameRect" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSDrawWindowBackground" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSSetFocusRingStyle" 
   ((placement :SInt32)
   )
   nil
() )
;  Disable and reenable screen updates.  
; ** NSDisableScreenUpdates prevents drawing for all windows belonging to the calling  
; ** process from being flushed to the screen.  This function permits operations on 
; ** multiple windows to appear atomic to the user, and is particularly useful for parent
; ** and child windows.  Note that this function should be used with care for short 
; ** operations only as the system will only allow updates to be disabled for a short 
; ** time (currently one second) before automatically reenabling updates.
; ** NSEnableScreenUpdates reenables drawing that was previously disabled by 
; ** NSDisableScreenUpdates.  Multiple calls stack.
; 

(deftrap-inline "_NSDisableScreenUpdates" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_NSEnableScreenUpdates" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
;  Runs one of the standard system animation effects (display and sound).
; ** 'centerLocation' represents the center, in screen coordinates, to show the effect.
; ** 'size' specifies how big the effect should be.  Use NSZeroSize to get the default size.
; ** 'animationDelegate' is optionally, an object that wants to know when the effect has completed.
; ** 'didEndSelector' will be invoked in the animationDelegate when the animation has completed.
; **  
; ** The didEndSelector should have the following signature:
; ** 	- (void)animationEffectDidEnd:(void *)contextInfo;
; 
(def-mactype :_NSAnimationEffect (find-mactype ':sint32))
;  The default effect used to indicate removal of an item from a collection, 
;  such as toolbar (indicates removal, without destroying the underlying data).

(defconstant $NSAnimationEffectDisappearingItemDefault 0);  An effect showing a puff of smoke.

(defconstant $NSAnimationEffectPoof 10)
(def-mactype :NSAnimationEffect (find-mactype ':SINT32))

; #endif


(deftrap-inline "_NSShowAnimationEffect" 
   ((animationEffect :SInt32)
    (X :single-float)
    (Y :single-float)
    (width :single-float)
    (height :single-float)
    (animationDelegate :UInt32)
    (didEndSelector (:pointer :SEL))
    (contextInfo :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(provide-interface "NSGraphics")