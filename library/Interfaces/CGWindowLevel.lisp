(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGWindowLevel.h"
; at Sunday July 2,2006 7:24:21 pm.
; 
;  *  CGWindowLevel.h
;  *  CoreGraphics
;  *
;  *  Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
;  *
;  
; #ifndef __CGWINDOWLEVEL_H__
(defconstant $__CGWINDOWLEVEL_H__ 1)
; #define __CGWINDOWLEVEL_H__ 1

(require-interface "CoreGraphics/CGBase")

(require-interface "stdint")
; 
;  * Windows may be assigned to a particular level. When assigned to a level,
;  * the window is ordered relative to all other windows in that level.
;  * Windows with a higher level are sorted in front of windows with a lower
;  * level.
;  *
;  * A common set of window levels is defined here for use within higher
;  * level frameworks.  The levels are accessed via a key and function,
;  * so that levels may be changed or adjusted in future releases without
;  * breaking binary compatability.
;  

(def-mactype :CGWindowLevel (find-mactype ':SInt32))

(def-mactype :CGWindowLevelKey (find-mactype ':SInt32))
(def-mactype :_CGCommonWindowLevelKey (find-mactype ':sint32))

(defconstant $kCGBaseWindowLevelKey 0)
(defconstant $kCGMinimumWindowLevelKey 1)
(defconstant $kCGDesktopWindowLevelKey 2)
(defconstant $kCGBackstopMenuLevelKey 3)
(defconstant $kCGNormalWindowLevelKey 4)
(defconstant $kCGFloatingWindowLevelKey 5)
(defconstant $kCGTornOffMenuWindowLevelKey 6)
(defconstant $kCGDockWindowLevelKey 7)
(defconstant $kCGMainMenuWindowLevelKey 8)
(defconstant $kCGStatusWindowLevelKey 9)
(defconstant $kCGModalPanelWindowLevelKey 10)
(defconstant $kCGPopUpMenuWindowLevelKey 11)
(defconstant $kCGDraggingWindowLevelKey 12)
(defconstant $kCGScreenSaverWindowLevelKey 13)
(defconstant $kCGMaximumWindowLevelKey 14)
(defconstant $kCGOverlayWindowLevelKey 15)
(defconstant $kCGHelpWindowLevelKey 16)
(defconstant $kCGUtilityWindowLevelKey 17)
(defconstant $kCGDesktopIconWindowLevelKey 18)
(defconstant $kCGCursorWindowLevelKey 19)
(defconstant $kCGAssistiveTechHighWindowLevelKey 20);  Internal bookkeeping; must be last 

(defconstant $kCGNumberOfWindowLevelKeys 21)

(deftrap-inline "_CGWindowLevelForKey" 
   ((key :SInt32)
   )
   :SInt32
() )
;  number of levels above kCGMaximumWindowLevel reserved for internal use 
(defconstant $kCGNumReservedWindowLevels 16)
; #define kCGNumReservedWindowLevels	(16)
;  Definitions of older constant values as calls 
; #define kCGBaseWindowLevel		CGWindowLevelForKey(kCGBaseWindowLevelKey)	/* LONG_MIN */
; #define kCGMinimumWindowLevel 		CGWindowLevelForKey(kCGMinimumWindowLevelKey)	/* (kCGBaseWindowLevel + 1) */
; #define kCGDesktopWindowLevel		CGWindowLevelForKey(kCGDesktopWindowLevelKey)	/* kCGMinimumWindowLevel */
; #define kCGDesktopIconWindowLevel		CGWindowLevelForKey(kCGDesktopIconWindowLevelKey)	/* kCGMinimumWindowLevel + 20 */
; #define kCGBackstopMenuLevel		CGWindowLevelForKey(kCGBackstopMenuLevelKey)	/* -20 */
; #define kCGNormalWindowLevel		CGWindowLevelForKey(kCGNormalWindowLevelKey)	/* 0 */
; #define kCGFloatingWindowLevel		CGWindowLevelForKey(kCGFloatingWindowLevelKey)	/* 3 */
; #define kCGTornOffMenuWindowLevel	CGWindowLevelForKey(kCGTornOffMenuWindowLevelKey)	/* 3 */
; #define kCGDockWindowLevel		CGWindowLevelForKey(kCGDockWindowLevelKey)	/* 20 */
; #define kCGMainMenuWindowLevel		CGWindowLevelForKey(kCGMainMenuWindowLevelKey)	/* 24 */
; #define kCGStatusWindowLevel		CGWindowLevelForKey(kCGStatusWindowLevelKey)	/* 25 */
; #define kCGModalPanelWindowLevel	CGWindowLevelForKey(kCGModalPanelWindowLevelKey)	/* 8 */
; #define kCGPopUpMenuWindowLevel		CGWindowLevelForKey(kCGPopUpMenuWindowLevelKey)	/* 101 */
; #define kCGDraggingWindowLevel		CGWindowLevelForKey(kCGDraggingWindowLevelKey)	/* 500 */
; #define kCGScreenSaverWindowLevel	CGWindowLevelForKey(kCGScreenSaverWindowLevelKey)	/* 1000 */
; #define kCGCursorWindowLevel		CGWindowLevelForKey(kCGCursorWindowLevelKey)	/* 2000 */
; #define kCGOverlayWindowLevel		CGWindowLevelForKey(kCGOverlayWindowLevelKey)	/* 102 */
; #define kCGHelpWindowLevel		CGWindowLevelForKey(kCGHelpWindowLevelKey)	/* 102 */
; #define kCGUtilityWindowLevel		CGWindowLevelForKey(kCGUtilityWindowLevelKey)	/* 19 */
; #define kCGAssistiveTechHighWindowLevel		CGWindowLevelForKey(kCGAssistiveTechHighWindowLevelKey)	/* 1500 */
; #define kCGMaximumWindowLevel 		CGWindowLevelForKey(kCGMaximumWindowLevelKey)	/* LONG_MAX - kCGNumReservedWindowLevels */

; #endif /* __CGWINDOWLEVEL_H__ */


(provide-interface "CGWindowLevel")