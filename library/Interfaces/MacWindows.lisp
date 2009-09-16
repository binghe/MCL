(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:MacWindows.h"
; at Sunday July 2,2006 7:24:54 pm.
; 
;      File:       HIToolbox/MacWindows.h
;  
;      Contains:   Window Manager Interfaces
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1997-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __MACWINDOWS__
; #define __MACWINDOWS__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __APPEARANCE__
#| #|
#include <HIToolboxAppearance.h>
#endif
|#
 |#
; #ifndef __DRAG__
#| #|
#include <HIToolboxDrag.h>
#endif
|#
 |#
; #ifndef __EVENTS__
#| #|
#include <HIToolboxEvents.h>
#endif
|#
 |#
; #ifndef __MENUS__
#| #|
#include <HIToolboxMenus.h>
#endif
|#
 |#
; #ifndef __HITOOLBAR__
#| #|
#include <HIToolboxHIToolbar.h>
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
;  Current documentation for the Mac OS Window Manager is available on the web:                         
;   <http://developer.apple.com/techpubs/macos8/HumanInterfaceToolbox/WindowManager/windowmanager.html> 
;                                                                                                       
; ——————————————————————————————————————————————————————————————————————————————————————
;  • HIWindowRef                                                                        
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :HIWindowRef (find-mactype ':WindowRef))
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Property Types                                                                     
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :PropertyCreator (find-mactype ':OSType))

(def-mactype :PropertyTag (find-mactype ':OSType))
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Classes                                                                     
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  WindowClass
;  *  
;  *  Summary:
;  *    The types of windows provided by the Window Manager.
;  *  
;  *  Discussion:
;  *    The class of a window determines several aspects of the window:
;  *    its appearance, its initial window attributes, its initial window
;  *    group, and its initial modality. All of these except for the
;  *    window's appearance may be changed later using other Window
;  *    Manager APIs.
;  

(def-mactype :WindowClass (find-mactype ':UInt32))
; 
;    * An alert window is used when the application needs the user's
;    * attention immediately. On Mac OS 9 and earlier, a visible alert
;    * window will prevent the user from switching to any other
;    * application. Use kThemeBrushAlertBackgroundActive to draw the
;    * background of alert windows. Alert windows are initially placed in
;    * the modal window group, given a modality of
;    * kWindowModalityAppModal, and given an activation scope of
;    * kWindowActivationScopeAll. Available in Mac OS 8.5 and later.
;    

(defconstant $kAlertWindowClass 1)
; 
;    * Similar to kAlertWindowClass, but provides a window that is
;    * movable and that allows switching to other applications. Generally
;    * you should use this window class rather than kAlertWindowClass.
;    * Use kThemeBrushAlertBackgroundActive to draw the background of
;    * movable alert windows. Movable alert windows are initially placed
;    * in the modal window group, given a modality of
;    * kWindowModalityAppModal, and given an activation scope of
;    * kWindowActivationScopeAll. Available in Mac OS 8.5 and later.
;    

(defconstant $kMovableAlertWindowClass 2)
; 
;    * A modal window is used to display a dialog (but not an alert; use
;    * kAlertWindowClass for alerts). On Mac OS 9 and earlier, a visible
;    * modal window will prevent the user from switching to any other
;    * application. Use kThemeBrushDialogBackgroundActive to draw the
;    * background of modal windows. Modal windows are initially placed in
;    * the modal window group, given a modality of
;    * kWindowModalityAppModal, and given an activation scope of
;    * kWindowActivationScopeAll. Available in Mac OS 8.5 and later.
;    

(defconstant $kModalWindowClass 3)
; 
;    * Similar to kModalWindowClass, but provides a window that is
;    * movable and that allows switching to other applications. Generally
;    * you should use this window class rather than kModalWindowClass. If
;    * you are using CarbonLib 1.3 or later, or Mac OS X, use
;    * kThemeBrushMovableModalBackground to draw the background of
;    * movable modal windows; on earlier versions of CarbonLib, or for
;    * non-Carbon programming, use kThemeBrushDialogBackgroundActive.
;    * Movable modal windows are initially placed in the modal window
;    * group, given a modality of kWindowModalityAppModal, and given an
;    * activation scope of kWindowActivationScopeAll. Available in Mac OS
;    * 8.5 and later.
;    

(defconstant $kMovableModalWindowClass 4)
; 
;    * A floating window is layered above all application windows except
;    * for alert and modal windows. It is commonly used for palette
;    * windows, inspectors, and other accessory (non-document) windows.
;    * Use kThemeBrushUtilityWindowBackgroundActive or
;    * kThemeBrushDocumentWindowBackground to draw the background of
;    * floating windows. Floating windows are initially placed in the
;    * floating window group, given a modality of kWindowModalityNone,
;    * and given an activation scope of
;    * kWindowActivationScopeIndependent. Available in Mac OS 8.6 and
;    * later.
;    

(defconstant $kFloatingWindowClass 5)
; 
;    * A document window is used for normal application document windows.
;    * Use kThemeBrushDocumentWindowBackground or your own custom drawing
;    * to draw the background of a document window. Document windows are
;    * initially placed in the document window group, given a modality of
;    * kWindowModalityNone, and given an activation scope of
;    * kWindowActivationScopeAll. Available in Mac OS 8.5 and later.
;    

(defconstant $kDocumentWindowClass 6)
; 
;    * A utility window is similar to a floating window, but it floats
;    * above the windows of all applications rather than just above the
;    * windows of the application that creates it. Use
;    * kThemeBrushUtilityWindowBackgroundActive or
;    * kThemeBrushDocumentWindowBackground to draw the background of
;    * utility windows. Utility windows are initially placed in the
;    * utility window group, given a modality of kWindowModalityNone, and
;    * given an activation scope of kWindowActivationScopeIndependent.
;    * Available in CarbonLib 1.1 and later, and in Mac OS X.
;    

(defconstant $kUtilityWindowClass 8)
; 
;    * A help window is used to display help tags. It has no window
;    * frame. Typically you should use the Help Manager to display help
;    * tags, rather than creating a help tag window yourself. Help
;    * windows are initially placed in the help window group, given a
;    * modality of kWindowModalityNone, and given an activation scope of
;    * kWindowActivationScopeNone. Available in CarbonLib 1.1 and later,
;    * and in Mac OS X.
;    

(defconstant $kHelpWindowClass 10)
; 
;    * A sheet window is used to display a dialog that is attached
;    * directly to its parent window, rather than being a independent
;    * window. A sheet dialog only prevents interaction with its parent
;    * window; the user may still interact with other windows in the same
;    * application. Use kThemeBrushSheetBackgroundOpaque to draw an
;    * opaque background for sheet windows, or
;    * kThemeBrushSheetBackgroundTransparent to draw a transparent
;    * background (the transparent brush is only available in Mac OS X
;    * 10.1 and later). Sheet windows are initially placed in the
;    * document window group, given a modality of kWindowModalityNone,
;    * and given an activation scope of kWindowActivationScopeAll.
;    * Available in CarbonLib 1.3 and later, and in Mac OS X; in
;    * CarbonLib, a sheet window is actually a movable-modal window,
;    * which blocks user interaction with all windows of the application.
;    

(defconstant $kSheetWindowClass 11)
; 
;    * A toolbar window is used to display a palette of controls. It is
;    * similar to a floating window, and like a floating window is
;    * layered above all application windows except for alert and modal
;    * windows, but is layered beneath floating windows. Use
;    * kThemeBrushToolbarBackground to draw the background of a toolbar
;    * window in Mac OS X or later; CarbonLib does not currently support
;    * kThemeBrushToolbarBackground. Floating windows are initially
;    * placed in the toolbar window group, given a modality of
;    * kWindowModalityNone, and given an activation scope of
;    * kWindowActivationScopeNone. Available in CarbonLib 1.1 and later,
;    * and Mac OS X.
;    

(defconstant $kToolbarWindowClass 12)
; 
;    * A plain window has a single-pixel window frame.
;    * kThemeBrushDocumentWindowBackground,
;    * kThemeBrushDialogBackgroundActive, and application-specific custom
;    * drawing are all commonly used to draw the background of a plain
;    * window. Plain windows are initially placed in the document window
;    * group, given a modality of kWindowModalityNone, and given an
;    * activation scope of kWindowActivationScopeAll. Available in
;    * CarbonLib 1.2.5 and later, and Mac OS X.
;    

(defconstant $kPlainWindowClass 13)
; 
;    * An overlay window is a completely transparent window positioned
;    * above all other windows. Overlay windows are intended as a
;    * replacement for the pre-Carbon practice of drawing directly into
;    * the window manager port; by creating a full-screen overlay window
;    * and drawing into it, you can draw over any window in any
;    * application without disturbing the contents of the windows
;    * underneath your drawing. After creating an overlay window, you
;    * should use CGContextClearRect to clear the overlay window's alpha
;    * channel to zero; this ensures the initial transparancy of the
;    * window. You must use CoreGraphics to draw into an overlay window
;    * to preserve the transparency of the window. Overlay windows are
;    * initially placed in the overlay window group, given a modality of
;    * kWindowModalityNone, and given an activation scope of
;    * kWindowActivationScopeNone. Available in Mac OS X.
;    

(defconstant $kOverlayWindowClass 14)
; 
;    * A sheet alert window is similar to a sheet window, but is intended
;    * to display an alert rather than a dialog. On Mac OS X, the
;    * appearance of a sheet window and a sheet alert window is currently
;    * identical, but in CarbonLib a sheet alert window has a different
;    * appearance from a sheet window. Use
;    * kThemeBrushSheetBackgroundOpaque to draw an opaque background for
;    * sheet alert windows, or kThemeBrushSheetBackgroundTransparent to
;    * draw a transparent background (the transparent brush is only
;    * available in Mac OS X 10.1 and later). Sheet alert windows are
;    * initially placed in the document window group, given a modality of
;    * kWindowModalityNone, and given an activation scope of
;    * kWindowActivationScopeAll. Available in CarbonLib 1.3 and later,
;    * and in Mac OS X 10.1 and later; in CarbonLib, a sheet alert window
;    * is actually a movable alert window, which blocks user interaction
;    * with all windows of the application.
;    

(defconstant $kSheetAlertWindowClass 15)
; 
;    * A alternate plain window is similar to a plain window but has a
;    * solid black shadow on its right and bottom sides. It is rarely
;    * used in modern Mac OS applications.
;    * kThemeBrushDocumentWindowBackground,
;    * kThemeBrushDialogBackgroundActive, and application-specific custom
;    * drawing are all commonly used to draw the background of an
;    * alternate plain window. Alternate plain windows are initially
;    * placed in the document window group, given a modality of
;    * kWindowModalityNone, and given an activation scope of
;    * kWindowActivationScopeAll. Available in CarbonLib 1.3 and later,
;    * and Mac OS X 10.1 and later.
;    

(defconstant $kAltPlainWindowClass 16)
; 
;    * A simple window is the simplest possible window; it has no window
;    * frame and its entire content is drawn by the application. Use any
;    * theme brush or your own custom drawing to draw the background of a
;    * simple window. Simple windows are initially placed in the document
;    * window group, given a modality of kWindowModalityNone, and given
;    * an activation scope of kWindowActivationScopeAll. Available in
;    * CarbonLib 1.5 and later, and Mac OS X 10.1 and later.
;    

(defconstant $kSimpleWindowClass 18)
; 
;    * A drawer window is used when implementing a drawer user interface,
;    * in which the drawer window slides out from underneath a document
;    * window. Use kThemeBrushDrawerBackground or
;    * kThemeBrushDocumentWindowBackground to draw the background of
;    * drawer windows. Drawer windows are initially placed in the
;    * document window group, given a modality of kWindowModalityNone,
;    * and given an activation scope of kWindowActivationScopeAll. Drawer
;    * windows should always be created using the Compositing window
;    * attribute. Available in Mac OS X 10.2 or later.
;    

(defconstant $kDrawerWindowClass 20)
; 
;    * Not an actual window class, but a meta-constant that is used with
;    * GetFrontWindowOfClass, FindWindowOfClass, and GetNextWindowOfClass
;    * to indicate that there should be no restriction on the class of
;    * the returned window. Also used with GetWindowGroupOfClass to get
;    * the root window group.
;    

(defconstant $kAllWindowClasses #xFFFFFFFF)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Attributes                                                                  
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :WindowAttributes (find-mactype ':UInt32))
; 
;  *  Summary:
;  *    Window attributes
;  
; 
;    * A constant with value zero; the lack of any attributes.
;    

(defconstant $kWindowNoAttributes 0)
; 
;    * This window has a close box. Available for windows of
;    * kDocumentWindowClass, kFloatingWindowClass, and
;    * kUtilityWindowClass.
;    

(defconstant $kWindowCloseBoxAttribute 1)
; 
;    * This window changes width when zooming. Available for windows of
;    * kDocumentWindowClass, kFloatingWindowClass, and
;    * kUtilityWindowClass.
;    

(defconstant $kWindowHorizontalZoomAttribute 2)
; 
;    * This window changes height when zooming. Available for windows of
;    * kDocumentWindowClass, kFloatingWindowClass, and
;    * kUtilityWindowClass.
;    

(defconstant $kWindowVerticalZoomAttribute 4)
; 
;    * This window changes both width and height when zooming. Available
;    * for windows of kDocumentWindowClass, kFloatingWindowClass, and
;    * kUtilityWindowClass.
;    

(defconstant $kWindowFullZoomAttribute 6)
; 
;    * This window has a collapse box. Available for windows of
;    * kDocumentWindowClass and, on Mac OS 9, kFloatingWindowClass and
;    * kUtilityWindowClass; not available for windows of
;    * kFloatingWindowClass or kUtilityWindowClass on Mac OS X.
;    

(defconstant $kWindowCollapseBoxAttribute 8)
; 
;    * This window can be resized. Available for windows of
;    * kDocumentWindowClass, kMovableModalWindowClass,
;    * kFloatingWindowClass, kUtilityWindowClass, and kSheetWindowClass.
;    

(defconstant $kWindowResizableAttribute 16)
; 
;    * This window has a vertical titlebar on the side of the window.
;    * Available for windows of kFloatingWindowClass and
;    * kUtilityWindowClass.
;    

(defconstant $kWindowSideTitlebarAttribute 32)
; 
;    * This window has a toolbar button. Available for windows of
;    * kDocumentWindowClass on Mac OS X.
;    

(defconstant $kWindowToolbarButtonAttribute 64)
; 
;    * This window uses the Metal appearance. Available for document
;    * windows on Mac OS X 10.2 and later, and for floating windows on
;    * Mac OS X 10.3 and later. Drawers can also be metal, but
;    * dynamically adjust their appearance based on their parent window's
;    * appearance; it is not necessary to specify this attribute for a
;    * metal drawer.
;    

(defconstant $kWindowMetalAttribute #x100)
; 
;    * This window does not participate in window cycling invoked by
;    * cmd-~ or the "Focus on Window" hotkey defined in the Keyboards
;    * preference pane. Available for all windows on Mac OS X 10.2 and
;    * later.
;    

(defconstant $kWindowDoesNotCycleAttribute #x8000)
; 
;    * This window receives no update events. Available for all windows.
;    

(defconstant $kWindowNoUpdatesAttribute #x10000)
; 
;    * This window receives no activate events. Available for all windows.
;    

(defconstant $kWindowNoActivatesAttribute #x20000)
; 
;    * This window receives mouse events even for areas of the window
;    * that are transparent (have an alpha channel component of zero).
;    * Available for windows of kOverlayWindowClass on Mac OS X 10.0 and
;    * 10.1, and available for all windows on Mac OS X 10.2 and later.
;    

(defconstant $kWindowOpaqueForEventsAttribute #x40000)
; 
;    * This window uses composited drawing. This means that the entire
;    * window is comprised of HIViews, and can be treated thusly. This
;    * attribute must be specified at window creation, and cannot be
;    * changed later with ChangeWindowAttributes. Available on Mac OS X
;    * 10.2 and later.
;    

(defconstant $kWindowCompositingAttribute #x80000)
; 
;    * This window has no shadow. Available for all windows on Mac OS X.
;    * This attribute is automatically given to windows of
;    * kOverlayWindowClass.
;    

(defconstant $kWindowNoShadowAttribute #x200000)
; 
;    * This window is automatically hidden on suspend and shown on
;    * resume. Available for all windows. This attribute is automatically
;    * given to windows of kFloatingWindowClass, kHelpWindowClass, and
;    * kToolbarWindowClass.
;    

(defconstant $kWindowHideOnSuspendAttribute #x1000000)
; 
;    * This window is marked so that the window server will drag the
;    * window automatically. Your application should not call DragWindow
;    * for this window, else it would confuse the heck out of the drag
;    * (it would fight with the window server for control). This is
;    * available on Mac OS X 10.3 or later.
;    

(defconstant $kWindowAsyncDragAttribute #x800000)
; 
;    * This window has the standard Carbon window event handler
;    * installed. Available for all windows.
;    

(defconstant $kWindowStandardHandlerAttribute #x2000000)
; 
;    * This window is automatically hidden during fullscreen mode (when
;    * the menubar is invisible) and shown afterwards. Available for all
;    * windows. This attribute is automatically given to windows of
;    * kUtilityWindowClass.
;    

(defconstant $kWindowHideOnFullScreenAttribute #x4000000)
; 
;    * This window is added to the standard Window menu. Available for
;    * windows of kDocumentWindowClass. This attribute is automatically
;    * given to windows of kDocumentWindowClass.
;    

(defconstant $kWindowInWindowMenuAttribute #x8000000)
; 
;    * This window supports live resizing. Available for all windows on
;    * Mac OS X.
;    

(defconstant $kWindowLiveResizeAttribute #x10000000)
; 
;    * This window never receives mouse events, even in areas that are
;    * opaque. Instead, clicks on the window will be passed through to
;    * windows beneath it. Available for all windows on Mac OS X 10.2 and
;    * later.
;    

(defconstant $kWindowIgnoreClicksAttribute #x20000000)
; 
;    * This window will not be repositioned by the default
;    * kEventWindowConstrain handler in response to changes in monitor
;    * size, Dock position, and so on. Available for all windows on Mac
;    * OS X 10.1 and later, and CarbonLib 1.6 and later.
;    

(defconstant $kWindowNoConstrainAttribute #x80000000)
; 
;    * The minimum set of window attributes commonly used by document
;    * windows.
;    

(defconstant $kWindowStandardDocumentAttributes 31)
; 
;    * The minimum set of window attributes commonly used by floating
;    * windows.
;    

(defconstant $kWindowStandardFloatingAttributes 9)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Definition Type                                                             
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kWindowDefProcType :|WDEF|)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Mac OS 7.5 Window Definition Resource IDs                                          
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kStandardWindowDefinition 0)      ;  for document windows and dialogs

(defconstant $kRoundWindowDefinition 1)         ;  old da-style window

(defconstant $kFloatingWindowDefinition 124)    ;  for floating windows

; ——————————————————————————————————————————————————————————————————————————————————————
;  • Variant Codes                                                                      
; ——————————————————————————————————————————————————————————————————————————————————————
;  for use with kStandardWindowDefinition 

(defconstant $kDocumentWindowVariantCode 0)
(defconstant $kModalDialogVariantCode 1)
(defconstant $kPlainDialogVariantCode 2)
(defconstant $kShadowDialogVariantCode 3)
(defconstant $kMovableModalDialogVariantCode 5)
(defconstant $kAlertVariantCode 7)
(defconstant $kMovableAlertVariantCode 9)       ;  for use with kFloatingWindowDefinition 

(defconstant $kSideFloaterVariantCode 8)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • DefProc IDs                                                                        
; ——————————————————————————————————————————————————————————————————————————————————————
;  classic ids 

(defconstant $documentProc 0)
(defconstant $dBoxProc 1)
(defconstant $plainDBox 2)
(defconstant $altDBoxProc 3)
(defconstant $noGrowDocProc 4)
(defconstant $movableDBoxProc 5)
(defconstant $zoomDocProc 8)
(defconstant $zoomNoGrow 12)                    ;  floating window defproc ids 

(defconstant $floatProc #x7C1)
(defconstant $floatGrowProc #x7C3)
(defconstant $floatZoomProc #x7C5)
(defconstant $floatZoomGrowProc #x7C7)
(defconstant $floatSideProc #x7C9)
(defconstant $floatSideGrowProc #x7CB)
(defconstant $floatSideZoomProc #x7CD)
(defconstant $floatSideZoomGrowProc #x7CF)

; #if CALL_NOT_IN_CARBON
#|                                              ;  The rDocProc (rounded WDEF, ala calculator) is not supported in Carbon.

(defconstant $rDocProc 16)
 |#

; #endif  /* CALL_NOT_IN_CARBON */

;  Resource IDs for theme-savvy window defprocs 

(defconstant $kWindowDocumentDefProcResID 64)
(defconstant $kWindowDialogDefProcResID 65)
(defconstant $kWindowUtilityDefProcResID 66)
(defconstant $kWindowUtilitySideTitleDefProcResID 67)
(defconstant $kWindowSheetDefProcResID 68)
(defconstant $kWindowSimpleDefProcResID 69)
(defconstant $kWindowSheetAlertDefProcResID 70)
;  Proc IDs for theme-savvy windows 

(defconstant $kWindowDocumentProc #x400)
(defconstant $kWindowGrowDocumentProc #x401)
(defconstant $kWindowVertZoomDocumentProc #x402)
(defconstant $kWindowVertZoomGrowDocumentProc #x403)
(defconstant $kWindowHorizZoomDocumentProc #x404)
(defconstant $kWindowHorizZoomGrowDocumentProc #x405)
(defconstant $kWindowFullZoomDocumentProc #x406)
(defconstant $kWindowFullZoomGrowDocumentProc #x407)
;  Proc IDs for theme-savvy dialogs 

(defconstant $kWindowPlainDialogProc #x410)
(defconstant $kWindowShadowDialogProc #x411)
(defconstant $kWindowModalDialogProc #x412)
(defconstant $kWindowMovableModalDialogProc #x413)
(defconstant $kWindowAlertProc #x414)
(defconstant $kWindowMovableAlertProc #x415)
;  procIDs available from Mac OS 8.1 (Appearance 1.0.1) forward 

(defconstant $kWindowMovableModalGrowProc #x416)
;  Proc IDs for top title bar theme-savvy floating windows 

(defconstant $kWindowFloatProc #x421)
(defconstant $kWindowFloatGrowProc #x423)
(defconstant $kWindowFloatVertZoomProc #x425)
(defconstant $kWindowFloatVertZoomGrowProc #x427)
(defconstant $kWindowFloatHorizZoomProc #x429)
(defconstant $kWindowFloatHorizZoomGrowProc #x42B)
(defconstant $kWindowFloatFullZoomProc #x42D)
(defconstant $kWindowFloatFullZoomGrowProc #x42F)
;  Proc IDs for side title bar theme-savvy floating windows 

(defconstant $kWindowFloatSideProc #x431)
(defconstant $kWindowFloatSideGrowProc #x433)
(defconstant $kWindowFloatSideVertZoomProc #x435)
(defconstant $kWindowFloatSideVertZoomGrowProc #x437)
(defconstant $kWindowFloatSideHorizZoomProc #x439)
(defconstant $kWindowFloatSideHorizZoomGrowProc #x43B)
(defconstant $kWindowFloatSideFullZoomProc #x43D)
(defconstant $kWindowFloatSideFullZoomGrowProc #x43F)
;  Proc IDs for sheet windows 

(defconstant $kWindowSheetProc #x440)           ;  available in Mac OS X and CarbonLib 1.3 

(defconstant $kWindowSheetAlertProc #x460)      ;  available in Mac OS X 10.1 and CarbonLib 1.3 

; 
;  *  Discussion:
;  *    Window defproc IDs for simple windows
;  
;  Proc IDs for simple windows 
; 
;    * A window that has no structure region; the content covers the
;    * entire window.
;    

(defconstant $kWindowSimpleProc #x450)
; 
;    * A window that has a 1-pixel black frame as its structure.
;    

(defconstant $kWindowSimpleFrameProc #x451)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • System 7 Window Positioning Constants                                              
;                                                                                       
;  Passed into StandardAlert and used in ‘WIND’, ‘DLOG’, and ‘ALRT’ templates           
;  StandardAlert uses zero to specify the default position. Other calls use zero to     
;  specify “no position”.  Do not pass these constants to RepositionWindow.  Do not     
;  store these constants in the BasicWindowDescription of a ‘wind’ resource.            
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kWindowNoPosition 0)
(defconstant $kWindowDefaultPosition 0)         ;  used by StandardAlert

(defconstant $kWindowCenterMainScreen #x280A)
(defconstant $kWindowAlertPositionMainScreen #x300A)
(defconstant $kWindowStaggerMainScreen #x380A)
(defconstant $kWindowCenterParentWindow #xA80A)
(defconstant $kWindowAlertPositionParentWindow #xB00A)
(defconstant $kWindowStaggerParentWindow #xB80A)
(defconstant $kWindowCenterParentWindowScreen #x680A)
(defconstant $kWindowAlertPositionParentWindowScreen #x700A)
(defconstant $kWindowStaggerParentWindowScreen #x780A)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Positioning Methods                                                         
;                                                                                       
;  Positioning methods passed to RepositionWindow.                                      
;  Do not use them in WIND, ALRT, DLOG templates.                                       
;  Do not confuse these constants with the constants above                              
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  WindowPositionMethod
;  *  
;  *  Summary:
;  *    Positioning methods usable with RepositionWindow.
;  *  
;  *  Discussion:
;  *    These constants are for use solely with the RepositionWindow API.
;  *    They should not be used in 'WIND', 'ALRT', or 'DLOG' resources.
;  

(def-mactype :WindowPositionMethod (find-mactype ':UInt32))
; 
;    * Centers the window on the main screen.
;    

(defconstant $kWindowCenterOnMainScreen 1)
; 
;    * Centers the window on its parent window. The parent window must be
;    * different from the positioned window.
;    

(defconstant $kWindowCenterOnParentWindow 2)
; 
;    * Centers the window on the screen containing the largest portion of
;    * its parent window. On Mac OS X 10.3 and later, the parent window
;    * may be the same as the positioned window. On CarbonLib and earlier
;    * versions of Mac OS X, the parent window must be different from the
;    * positioned window.
;    

(defconstant $kWindowCenterOnParentWindowScreen 3)
; 
;    * Cascades the window on the main screen.
;    

(defconstant $kWindowCascadeOnMainScreen 4)
; 
;    * Cascades the window on its parent window. The parent window must
;    * be different from the positioned window.
;    

(defconstant $kWindowCascadeOnParentWindow 5)
; 
;    * Cascades the window on the screen containing the largest portion
;    * of its parent window. On Mac OS X 10.3 and later, the parent
;    * window may be the same as the positioned window. On CarbonLib and
;    * earlier versions of Mac OS X, the parent window must be different
;    * from the positioned window.
;    

(defconstant $kWindowCascadeOnParentWindowScreen 6)
; 
;    * Cascades the window on the screen containing the largest portion
;    * of its parent window, starting below and to the right of its
;    * parent window. The parent window must be different from the
;    * positioned window. Available in Mac OS X 10.2 and CarbonLib 1.6
;    * and later.
;    

(defconstant $kWindowCascadeStartAtParentWindowScreen 10)
; 
;    * Puts the window into the alert position on the main screen.
;    

(defconstant $kWindowAlertPositionOnMainScreen 7)
; 
;    * Puts the window into the alert position on its parent window. The
;    * parent window must be different from the positioned window.
;    

(defconstant $kWindowAlertPositionOnParentWindow 8)
; 
;    * Puts the window into the alert position on the screen containing
;    * the largest portion of its parent window. On Mac OS X 10.3 and
;    * later, the parent window may be the same as the positioned window.
;    * On CarbonLib and earlier versions of Mac OS X, the parent window
;    * must be different from the positioned window.
;    

(defconstant $kWindowAlertPositionOnParentWindowScreen 9)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • GetWindowRegion Types                                                              
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :WindowRegionCode (find-mactype ':UInt16))
;  Region values to pass into GetWindowRegion & GetWindowBounds. All regions are reported in global coordinates. 

(defconstant $kWindowTitleBarRgn 0)
(defconstant $kWindowTitleTextRgn 1)
(defconstant $kWindowCloseBoxRgn 2)
(defconstant $kWindowZoomBoxRgn 3)
(defconstant $kWindowDragRgn 5)
(defconstant $kWindowGrowRgn 6)
(defconstant $kWindowCollapseBoxRgn 7)
(defconstant $kWindowTitleProxyIconRgn 8)       ;  Mac OS 8.5 forward

(defconstant $kWindowStructureRgn 32)
(defconstant $kWindowContentRgn 33)             ;  Content area of the window; empty when the window is collapsed

(defconstant $kWindowUpdateRgn 34)              ;  Carbon forward

(defconstant $kWindowOpaqueRgn 35)              ;  Mac OS X: Area of window considered to be opaque. Only valid for windows with alpha channels.

(defconstant $kWindowGlobalPortRgn 40)          ;  Carbon forward - bounds of the window’s port in global coordinates; not affected by CollapseWindow

;  GetWindowRegionRec - a pointer to this is passed in WDEF param for kWindowMsgGetRegion
(defrecord GetWindowRegionRec
   (winRgn (:pointer :OpaqueRgnHandle))
   (regionCode :UInt16)
)

;type name? (%define-record :GetWindowRegionRec (find-record-descriptor ':GetWindowRegionRec))

(def-mactype :GetWindowRegionPtr (find-mactype '(:pointer :GetWindowRegionRec)))

(def-mactype :GetWindowRegionRecPtr (find-mactype '(:pointer :GetWindowRegionRec)))
; ——————————————————————————————————————————————————————————————————————————————————————
;  • WDEF Message Types                                                                 
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;    SetupWindowProxyDragImageRec - setup the proxy icon drag image
;    Both regions are allocated and disposed by the Window Manager.
;    The GWorld is disposed of by the Window Manager, but the WDEF must allocate
;    it.  See Technote on Drag Manager 1.1 additions for more information and sample code for
;    setting up drag images.
; 
(defrecord SetupWindowProxyDragImageRec
   (imageGWorld (:pointer :OpaqueGrafPtr))      ;  locked GWorld containing the drag image - output - can be NULL
   (imageRgn (:pointer :OpaqueRgnHandle))       ;  image clip region, contains the portion of the image which gets blitted to screen - preallocated output - if imageGWorld is NULL, this is ignored
   (outlineRgn (:pointer :OpaqueRgnHandle))     ;  the outline region used on shallow monitors - preallocated output - must always be non-empty
)

;type name? (%define-record :SetupWindowProxyDragImageRec (find-record-descriptor ':SetupWindowProxyDragImageRec))
;  MeasureWindowTitleRec - a pointer to this is passed in WDEF param for kWindowMsgMeasureTitle
(defrecord MeasureWindowTitleRec
                                                ;  output parameters (filled in by the WDEF)
   (fullTitleWidth :SInt16)                     ;  text + proxy icon width
   (titleTextWidth :SInt16)                     ;  text width
                                                ;  input parameters
   (isUnicodeTitle :Boolean)
   (unused :Boolean)                            ;  future use
)

;type name? (%define-record :MeasureWindowTitleRec (find-record-descriptor ':MeasureWindowTitleRec))

(def-mactype :MeasureWindowTitleRecPtr (find-mactype '(:pointer :MeasureWindowTitleRec)))
; 
;    GetGrowImageRegionRec - generate a region to be xored during GrowWindow and ResizeWindow.
;    This is passed along with a kWindowMsgGetGrowImageRegion message. On input, the growRect
;    parameter is the window's new bounds in global coordinates. The growImageRegion parameter
;    will be allocated and disposed automatically; the window definition should alter the 
;    region appropriately.
; 
(defrecord GetGrowImageRegionRec
   (growRect :Rect)
   (growImageRegion (:pointer :OpaqueRgnHandle))
)

;type name? (%define-record :GetGrowImageRegionRec (find-record-descriptor ':GetGrowImageRegionRec))
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Standard Window Kinds                                                              
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $dialogKind 2)
(defconstant $userKind 8)
(defconstant $kDialogWindowKind 2)
(defconstant $kApplicationWindowKind 8)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • FindWindow Result Codes                                                            
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :WindowPartCode (find-mactype ':SInt16))

(defconstant $inDesk 0)
(defconstant $inNoWindow 0)
(defconstant $inMenuBar 1)
(defconstant $inSysWindow 2)
(defconstant $inContent 3)
(defconstant $inDrag 4)
(defconstant $inGrow 5)
(defconstant $inGoAway 6)
(defconstant $inZoomIn 7)
(defconstant $inZoomOut 8)
(defconstant $inCollapseBox 11)                 ;  Mac OS 8.0 forward

(defconstant $inProxyIcon 12)                   ;  Mac OS 8.5 forward

(defconstant $inToolbarButton 13)               ;  Mac OS X forward

(defconstant $inStructure 15)                   ;  Mac OS X 10.1 forward

; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Definition Hit Test Result Codes                                            
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :WindowDefPartCode (find-mactype ':SInt16))

(defconstant $wNoHit 0)
(defconstant $wInContent 1)
(defconstant $wInDrag 2)
(defconstant $wInGrow 3)
(defconstant $wInGoAway 4)
(defconstant $wInZoomIn 5)
(defconstant $wInZoomOut 6)
(defconstant $wInCollapseBox 9)                 ;  Mac OS 8.0 forward

(defconstant $wInProxyIcon 10)                  ;  Mac OS 8.5 forward

(defconstant $wInToolbarButton 11)              ;  Mac OS X forward

(defconstant $wInStructure 13)                  ;  Mac OS X 10.1 forward

; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Definition Messages                                                         
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kWindowMsgDraw 0)
(defconstant $kWindowMsgHitTest 1)
(defconstant $kWindowMsgCalculateShape 2)
(defconstant $kWindowMsgInitialize 3)
(defconstant $kWindowMsgCleanUp 4)
(defconstant $kWindowMsgDrawGrowOutline 5)
(defconstant $kWindowMsgDrawGrowBox 6)
;  Messages available from Mac OS 8.0 forward

(defconstant $kWindowMsgGetFeatures 7)
(defconstant $kWindowMsgGetRegion 8)
;  Messages available from Mac OS 8.5 forward

(defconstant $kWindowMsgDragHilite 9)           ;  parameter boolean indicating on or off

(defconstant $kWindowMsgModified 10)            ;  parameter boolean indicating saved (false) or modified (true)

(defconstant $kWindowMsgDrawInCurrentPort 11)   ;  same as kWindowMsgDraw, but must draw in current port

(defconstant $kWindowMsgSetupProxyDragImage 12) ;  parameter pointer to SetupWindowProxyDragImageRec

(defconstant $kWindowMsgStateChanged 13)        ;  something about the window's state has changed

(defconstant $kWindowMsgMeasureTitle 14)        ;  measure and return the ideal title width

;  Messages only available in Carbon

(defconstant $kWindowMsgGetGrowImageRegion 19)  ;  get region to xor during grow/resize. parameter pointer to GetGrowImageRegionRec.

;  old names

(defconstant $wDraw 0)
(defconstant $wHit 1)
(defconstant $wCalcRgns 2)
(defconstant $wNew 3)
(defconstant $wDispose 4)
(defconstant $wGrow 5)
(defconstant $wDrawGIcon 6)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • State-changed Flags for kWindowMsgStateChanged                                     
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kWindowStateTitleChanged 1)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Feature Bits                                                                
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kWindowCanGrow 1)
(defconstant $kWindowCanZoom 2)
(defconstant $kWindowCanCollapse 4)
(defconstant $kWindowIsModal 8)
(defconstant $kWindowCanGetWindowRegion 16)
(defconstant $kWindowIsAlert 32)
(defconstant $kWindowHasTitleBar 64)
;  Feature bits available from Mac OS 8.5 forward

(defconstant $kWindowSupportsDragHilite #x80)   ;  window definition supports kWindowMsgDragHilite

(defconstant $kWindowSupportsModifiedBit #x100) ;  window definition supports kWindowMsgModified

(defconstant $kWindowCanDrawInCurrentPort #x200);  window definition supports kWindowMsgDrawInCurrentPort

(defconstant $kWindowCanSetupProxyDragImage #x400);  window definition supports kWindowMsgSetupProxyDragImage

(defconstant $kWindowCanMeasureTitle #x800)     ;  window definition supports kWindowMsgMeasureTitle

(defconstant $kWindowWantsDisposeAtProcessDeath #x1000);  window definition wants a Dispose message for windows still extant during ExitToShell

(defconstant $kWindowSupportsGetGrowImageRegion #x2000);  window definition will calculate the grow image region manually.

(defconstant $kWindowDefSupportsColorGrafPort #x40000002)
;  Feature bits for post MacOS 10.0
;  Window doesn't need an alpha channel. Saves memory.

(defconstant $kWindowIsOpaque #x4000)
; 
;    THIS CONSTANT IS GOING AWAY. IT IS NAMED INCORRECTLY. USE THE GETGROWIMAGE CONSTANT ABOVE INSTEAD.
;    DO YOU HEAR ME! AM I YELLING LOUD ENOUGH?!
; 

(defconstant $kWindowSupportsSetGrowImageRegion #x2000)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Desktop Pattern Resource ID                                                        
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $deskPatID 16)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Color Part Codes                                                            
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $wContentColor 0)
(defconstant $wFrameColor 1)
(defconstant $wTextColor 2)
(defconstant $wHiliteColor 3)
(defconstant $wTitleBarColor 4)
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Region Dragging Constants                                                         
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kMouseUpOutOfSlop #x80008000)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Color Table                                                                 
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord (WinCTab :handle)
   (wCSeed :signed-long)                        ;  reserved 
   (wCReserved :SInt16)                         ;  reserved 
   (ctSize :SInt16)                             ;  usually 4 for windows 
   (ctTable (:array :ColorSpec 5))
)

;type name? (%define-record :WinCTab (find-record-descriptor ':WinCTab))

(def-mactype :WCTabPtr (find-mactype '(:pointer :WinCTab)))

(def-mactype :WCTabHandle (find-mactype '(:handle :WinCTab)))
; ——————————————————————————————————————————————————————————————————————————————————————
;  • WindowRecord                                                                       
; ——————————————————————————————————————————————————————————————————————————————————————

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
;type name? (def-mactype :WindowRecord (find-mactype ':WindowRecord))

(def-mactype :WindowPeek (find-mactype '(:pointer :WindowRecord)))
(defrecord WindowRecord
   (port :GrafPort)                             ;  in Carbon use GetWindowPort
   (windowKind :SInt16)                         ;  in Carbon use Get/SetWindowKind
   (visible :Boolean)                           ;  in Carbon use Hide/ShowWindow, ShowHide, IsWindowVisible
   (hilited :Boolean)                           ;  in Carbon use HiliteWindow, IsWindowHilited
   (goAwayFlag :Boolean)                        ;  in Carbon use ChangeWindowAttributes
   (spareFlag :Boolean)                         ;  in Carbon use ChangeWindowAttributes
   (strucRgn (:pointer :OpaqueRgnHandle))       ;  in Carbon use GetWindowRegion
   (contRgn (:pointer :OpaqueRgnHandle))        ;  in Carbon use GetWindowRegion
   (updateRgn (:pointer :OpaqueRgnHandle))      ;  in Carbon use GetWindowRegion
   (windowDefProc :Handle)                      ;  not supported in Carbon 
   (dataHandle :Handle)                         ;  not supported in Carbon 
   (titleHandle (:Handle :UInt8))               ;  in Carbon use Get/SetWTitle 
   (titleWidth :SInt16)                         ;  in Carbon use GetWindowRegion 
   (controlList :Handle)                        ;  in Carbon use GetRootControl 
   (nextWindow :WindowPeek)                     ;  in Carbon use GetNextWindow 
   (windowPic (:Handle :Picture))               ;  in Carbon use Get/SetWindowPic 
   (refCon :signed-long)                        ;  in Carbon use Get/SetWRefCon
)
 |#

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */

; ——————————————————————————————————————————————————————————————————————————————————————
;  • Color WindowRecord                                                                 
; ——————————————————————————————————————————————————————————————————————————————————————

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
;type name? (def-mactype :CWindowRecord (find-mactype ':CWindowRecord))

(def-mactype :CWindowPeek (find-mactype '(:pointer :CWindowRecord)))
(defrecord CWindowRecord
   (port :CGrafPort)                            ;  in Carbon use GetWindowPort
   (windowKind :SInt16)                         ;  in Carbon use Get/SetWindowKind    
   (visible :Boolean)                           ;  in Carbon use Hide/ShowWindow, ShowHide, IsWindowVisible     
   (hilited :Boolean)                           ;  in Carbon use HiliteWindow, IsWindowHilited
   (goAwayFlag :Boolean)                        ;  in Carbon use ChangeWindowAttributes   
   (spareFlag :Boolean)                         ;  in Carbon use ChangeWindowAttributes   
   (strucRgn (:pointer :OpaqueRgnHandle))       ;  in Carbon use GetWindowRegion  
   (contRgn (:pointer :OpaqueRgnHandle))        ;  in Carbon use GetWindowRegion  
   (updateRgn (:pointer :OpaqueRgnHandle))      ;  in Carbon use GetWindowRegion  
   (windowDefProc :Handle)                      ;  not supported in Carbon 
   (dataHandle :Handle)                         ;  not supported in Carbon 
   (titleHandle (:Handle :UInt8))               ;  in Carbon use Get/SetWTitle 
   (titleWidth :SInt16)                         ;  in Carbon use GetWindowRegion 
   (controlList :Handle)                        ;  in Carbon use GetRootControl 
   (nextWindow :CWindowPeek)                    ;  in Carbon use GetNextWindow 
   (windowPic (:Handle :Picture))               ;  in Carbon use Get/SetWindowPic     
   (refCon :signed-long)                        ;  in Carbon use Get/SetWRefCon      
)
 |#

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */

; ——————————————————————————————————————————————————————————————————————————————————————
;  • AuxWinHandle                                                                       
; ——————————————————————————————————————————————————————————————————————————————————————

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
;type name? (def-mactype :AuxWinRec (find-mactype ':AuxWinRec))

(def-mactype :AuxWinPtr (find-mactype '(:pointer :AuxWinRec)))

(def-mactype :AuxWinHandle (find-mactype '(:pointer :AuxWinPtr)))
(defrecord (AuxWinRec :handle)
   (awNext :AuxWinHandle)                       ;  handle to next AuxWinRec, not supported in Carbon
   (awOwner (:pointer :OpaqueWindowPtr))        ;  not supported in Carbon
   (awCTable (:Handle :ColorTable))             ;  color table for this window, use  Get/SetWindowContentColor in Carbon
   (reserved :Handle)                           ;  not supported in Carbon
   (awFlags :signed-long)                       ;  reserved for expansion, not supported in Carbon
   (awReserved (:Handle :ColorTable))           ;  reserved for expansion, not supported in Carbon
   (awRefCon :signed-long)                      ;  user constant, in Carbon use Get/SetWindowProperty if you need more refCons
)
 |#

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */

; ——————————————————————————————————————————————————————————————————————————————————————
;   • BasicWindowDescription                                                            
;                                                                                       
;   Contains statically-sized basic attributes of the window, for storage in a          
;   collection item.                                                                    
; ——————————————————————————————————————————————————————————————————————————————————————
;  constants for the version field

(defconstant $kWindowDefinitionVersionOne 1)
(defconstant $kWindowDefinitionVersionTwo 2)
;  constants for the stateflags bit field 

(defconstant $kWindowIsCollapsedState 1)
(defrecord BasicWindowDescription
   (descriptionSize :UInt32)                    ;  sizeof(BasicWindowDescription)
   (windowContentRect :Rect)                    ;  location on screen
   (windowZoomRect :Rect)                       ;  location on screen when zoomed out
   (windowRefCon :UInt32)                       ;  the refcon - __avoid saving stale pointers here__  
   (windowStateFlags :UInt32)                   ;  window state bit flags
   (windowPositionMethod :UInt32)               ;  method last used by RepositionWindow to position the window (if any)
   (windowDefinitionVersion :UInt32)
   (:variant
   (
   (windowDefProc :SInt16)                      ;  defProc and variant
   (windowHasCloseBox :Boolean)
   )
   (
   (windowClass :UInt32)                        ;  the class
   (windowAttributes :UInt32)                   ;  the attributes
   )
   )
)

;type name? (%define-record :BasicWindowDescription (find-record-descriptor ':BasicWindowDescription))
;   the window manager stores the default collection items using these IDs

(defconstant $kStoredWindowSystemTag :|appl|)   ;  Only Apple collection items will be of this tag

(defconstant $kStoredBasicWindowDescriptionID :|sbas|);  BasicWindowDescription

(defconstant $kStoredWindowPascalTitleID :|s255|);  pascal title string

(defconstant $kStoredWindowTitleCFStringID :|cfst|);  CFString title string

; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Class Ordering                                                              
;                                                                                       
;   Special cases for the “behind” parameter in window creation calls.                  
; ——————————————————————————————————————————————————————————————————————————————————————
(defconstant $kFirstWindowOfClass -1)
; #define kFirstWindowOfClass             ((WindowRef)(-1))
(defconstant $kLastWindowOfClass 0)
; #define kLastWindowOfClass              ((WindowRef)0)
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Zoom Information Handle                                                            
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord (WStateData :handle)
   (userState :Rect)                            ; user zoom state
   (stdState :Rect)                             ; standard zoom state
)

;type name? (%define-record :WStateData (find-record-descriptor ':WStateData))

(def-mactype :WStateDataPtr (find-mactype '(:pointer :WStateData)))

(def-mactype :WStateDataHandle (find-mactype '(:handle :WStateData)))
; ——————————————————————————————————————————————————————————————————————————————————————
;  • MixedMode & ProcPtrs                                                               
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :WindowDefProcPtr (find-mactype ':pointer)); (short varCode , WindowRef window , short message , long param)

(def-mactype :DeskHookProcPtr (find-mactype ':pointer)); (Boolean mouseClick , EventRecord * theEvent)

(def-mactype :WindowPaintProcPtr (find-mactype ':pointer)); (GDHandle device , GrafPtr qdContext , WindowRef window , RgnHandle inClientPaintRgn , RgnHandle outSystemPaintRgn , void * refCon)

(def-mactype :WindowDefUPP (find-mactype '(:pointer :OpaqueWindowDefProcPtr)))

(def-mactype :DeskHookUPP (find-mactype '(:pointer :OpaqueDeskHookProcPtr)))

(def-mactype :WindowPaintUPP (find-mactype '(:pointer :OpaqueWindowPaintProcPtr)))
; 
;  *  NewWindowDefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewWindowDefUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowDefProcPtr)
() )
; 
;  *  NewDeskHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  NewWindowPaintUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewWindowPaintUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPaintProcPtr)
() )
; 
;  *  DisposeWindowDefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeWindowDefUPP" 
   ((userUPP (:pointer :OpaqueWindowDefProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDeskHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeWindowPaintUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeWindowPaintUPP" 
   ((userUPP (:pointer :OpaqueWindowPaintProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeWindowDefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeWindowDefUPP" 
   ((varCode :SInt16)
    (window (:pointer :OpaqueWindowPtr))
    (message :SInt16)
    (param :signed-long)
    (userUPP (:pointer :OpaqueWindowDefProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  InvokeDeskHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeWindowPaintUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeWindowPaintUPP" 
   ((device (:Handle :GDEVICE))
    (qdContext (:pointer :OpaqueGrafPtr))
    (window (:pointer :OpaqueWindowPtr))
    (inClientPaintRgn (:pointer :OpaqueRgnHandle))
    (outSystemPaintRgn (:pointer :OpaqueRgnHandle))
    (refCon :pointer)
    (userUPP (:pointer :OpaqueWindowPaintProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Definition Spec.  Used in Carbon to specify the code that defines a window. 
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kWindowDefProcPtr 0)              ;  raw proc-ptr based access

(defconstant $kWindowDefObjectClass 1)          ;  event-based definition (Carbon 1.1 or later)

(defconstant $kWindowDefProcID 2)               ;  explicit proc ID; overrides the window class default proc ID

(defconstant $kWindowDefHIView 3)               ;  this window uses a view as its frame, not a WDEF


(def-mactype :WindowDefType (find-mactype ':UInt32))
(defrecord WindowDefSpec
   (defType :UInt32)
   (:variant
   (
   (defProc (:pointer :OpaqueWindowDefProcPtr))
   )
   (
   (classRef :pointer)
   )
   (
   (procID :SInt16)
   )
   (
   (rootView :pointer)
   )
                                                ;  ControlRef
   )
)

;type name? (%define-record :WindowDefSpec (find-record-descriptor ':WindowDefSpec))

(def-mactype :WindowDefSpecPtr (find-mactype '(:pointer :WindowDefSpec)))
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Creation & Persistence                                                      
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  GetNewCWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetNewCWindow" 
   ((windowID :SInt16)
    (wStorage :pointer)
    (behind (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  NewWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewWindow" 
   ((wStorage :pointer)
    (boundsRect (:pointer :Rect))
    (title (:pointer :STR255))
    (visible :Boolean)
    (theProc :SInt16)
    (behind (:pointer :OpaqueWindowPtr))
    (goAwayFlag :Boolean)
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  GetNewWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetNewWindow" 
   ((windowID :SInt16)
    (wStorage :pointer)
    (behind (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  NewCWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewCWindow" 
   ((wStorage :pointer)
    (boundsRect (:pointer :Rect))
    (title (:pointer :STR255))
    (visible :Boolean)
    (procID :SInt16)
    (behind (:pointer :OpaqueWindowPtr))
    (goAwayFlag :Boolean)
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  DisposeWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposeWindow" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]CloseWindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;    Routines available from Mac OS 8.5 forward
;    or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
; 
; 
;  *  CreateNewWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_CreateNewWindow" 
   ((windowClass :UInt32)
    (attributes :UInt32)
    (contentBounds (:pointer :Rect))
    (outWindow (:pointer :WindowRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Routines available from Mac OS 8.5 forward
;  Create a window from a ‘wind’ resource
; 
;  *  CreateWindowFromResource()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_CreateWindowFromResource" 
   ((resID :SInt16)
    (outWindow (:pointer :WindowRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  window persistence
; 
;  *  StoreWindowIntoCollection()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_StoreWindowIntoCollection" 
   ((window (:pointer :OpaqueWindowPtr))
    (collection (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateWindowFromCollection()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_CreateWindowFromCollection" 
   ((collection (:pointer :OpaqueCollection))
    (outWindow (:pointer :WindowRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  window refcounting
; 
;  *  GetWindowOwnerCount()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowOwnerCount" 
   ((window (:pointer :OpaqueWindowPtr))
    (outCount (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CloneWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_CloneWindow" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowRetainCount()
;  *  
;  *  Summary:
;  *    Returns the retain count of a window.
;  *  
;  *  Discussion:
;  *    This API is equivalent to GetWindowOwnerCount. For consistency
;  *    with CoreFoundation and Carbon Events, it is preferred over
;  *    GetWindowOwnerCount. Both APIs will continue to be supported.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose retain count to retrieve.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowRetainCount" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  RetainWindow()
;  *  
;  *  Summary:
;  *    Increments the retain count of a window.
;  *  
;  *  Discussion:
;  *    This API is equivalent to CloneWindow. For consistency with
;  *    CoreFoundation and Carbon Events, it is preferred over
;  *    CloneWindow. Both APIs will continue to be supported.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose retain count to increment.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RetainWindow" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ReleaseWindow()
;  *  
;  *  Summary:
;  *    Decrements the retain count of a window, and destroys the window
;  *    if the retain count falls to zero.
;  *  
;  *  Discussion:
;  *    This API is equivalent to DisposeWindow. For consistency with
;  *    CoreFoundation and Carbon Events, it is preferred over
;  *    DisposeWindow. Both APIs will continue to be supported.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose retain count to decrement.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ReleaseWindow" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Custom Windows                                                                     
; ——————————————————————————————————————————————————————————————————————————————————————
;  Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
; 
;  *  CreateCustomWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateCustomWindow" 
   ((def (:pointer :WindowDefSpec))
    (windowClass :UInt32)
    (attributes :UInt32)
    (contentBounds (:pointer :Rect))
    (outWindow (:pointer :WindowRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ReshapeCustomWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ReshapeCustomWindow" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RegisterWindowDefinition()
;  *  
;  *  Summary:
;  *    Registers or unregisters a binding between a resource ID and a
;  *    window definition function.
;  *  
;  *  Discussion:
;  *    In the Mac OS 8.x Window Manager, a 'WIND' resource can contain
;  *    an embedded WDEF procID that is used by the Window Manager as the
;  *    resource ID of an 'WDEF' resource to lay out and draw the window.
;  *    The 'WDEF' resource is loaded by the Window Manager when you load
;  *    the menu with GetNewWindow. Since WDEFs can no longer be packaged
;  *    as code resources on Carbon, the procID can no longer refer
;  *    directly to a WDEF resource. However, using
;  *    RegisterWindowDefinition you can instead specify a
;  *    UniversalProcPtr pointing to code in your application code
;  *    fragment. RegisterWindowDefinition is available when linking to
;  *    CarbonLib 1.1 forward.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inResID:
;  *      A WDEF proc ID, as used in a 'WIND' resource.
;  *    
;  *    inDefSpec:
;  *      Specifies the WindowDefUPP that should be used for windows with
;  *      the given WDEF proc ID. Passing NULL allows you to unregister
;  *      the window definition that had been associated with the given
;  *      WDEF proc ID.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RegisterWindowDefinition" 
   ((inResID :SInt16)
    (inDefSpec (:pointer :WindowDefSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window part tracking                                                               
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;    Routines available from Mac OS 8.5 forward
;         (or from Mac OS 8.6 forward when linking to CarbonLib 1.1 forward)
; 
; 
;  *  GetWindowWidgetHilite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowWidgetHilite" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outHilite (:pointer :WINDOWDEFPARTCODE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Metainformation Accessors                                                   
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  IsValidWindowClass()
;  *  
;  *  Summary:
;  *    Indicates whether a window class is supported by the Window
;  *    Manager.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inClass:
;  *      The window class.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsValidWindowClass" 
   ((inClass :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
; 
;  *  GetAvailableWindowAttributes()
;  *  
;  *  Summary:
;  *    Returns the window attributes that are valid for a window class.
;  *  
;  *  Discussion:
;  *    This API is useful because some window classes support different
;  *    attributes on different platforms (for example, floating windows
;  *    can have collapse boxes on 9, but not on X), and the Window
;  *    Manager will return an error if you attempt to create a window
;  *    with attributes that aren't supported for the requested window
;  *    class. You can use this API to remove attributes that are not
;  *    supported by the current platform before calling CreateNewWindow.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inClass:
;  *      The window class.
;  *  
;  *  Result:
;  *    The window attributes that are supported for the specified window
;  *    class.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetAvailableWindowAttributes" 
   ((inClass :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :UInt32
() )
; 
;    Routines available from Mac OS 8.5 forward
;    or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
; 
; 
;  *  GetWindowClass()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowClass" 
   ((window (:pointer :OpaqueWindowPtr))
    (outClass (:pointer :WINDOWCLASS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowAttributes()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowAttributes" 
   ((window (:pointer :OpaqueWindowPtr))
    (outAttributes (:pointer :WINDOWATTRIBUTES))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    Routines available from Mac OS 9.0 forward
;    or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
; 
; 
;  *  ChangeWindowAttributes()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ChangeWindowAttributes" 
   ((window (:pointer :OpaqueWindowPtr))
    (setTheseAttributes :UInt32)
    (clearTheseAttributes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
;     WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
;     
;     SetWindowClass will disappear at some point in the future. Instead of SetWindowClass,
;     you should use SetWindowGroup to move a window into the group of the desired
;     class. This API is very dangerous in that is actually does change the class
;     of the window, but class was meant to be an immutable property of the window.
;     At the very least, this API will be modified to only change the layer of the
;     window to match the layer that the specified class normally lives in. Consider
;     yourself warned!
;     
;     WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
;     WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
; 
; 
;  *  SetWindowClass()
;  *  
;  *  Summary:
;  *    Changes the window class of a window.
;  *  
;  *  Discussion:
;  *    SetWindowClass changes the class of a window. It also changes the
;  *    window's z-order so that it is grouped with other windows of the
;  *    same class. It does not change the visual appearance of the
;  *    window. In CarbonLib, SetWindowClass may not be used to change a
;  *    non-utility window to have utility window class, or to make a
;  *    utility window have non-utility class. SetWindowClass is
;  *    available from CarbonLib 1.1 forward.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose class to change.
;  *    
;  *    inWindowClass:
;  *      The new window class.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowClass" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inWindowClass :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HIWindowChangeClass()
;  *  
;  *  Summary:
;  *    Changes the window look and feel of an existing window on the fly.
;  *  
;  *  Discussion:
;  *    HIWindowChangeClass changes the class of a window. Unlike
;  *    SetWindowClass, this call effectively changes the look and
;  *    behavior of the window all at once. Because SetWindowClass
;  *    already existed and had certain behaviour, we could not change it
;  *    to behave the way HIWindowChangeClass does. 
;  *    
;  *    This function can convert a window between document, floating,
;  *    utility, and movable modal window classes only. It cannot change
;  *    a window into a plain window, for example.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose class to change.
;  *    
;  *    inWindowClass:
;  *      The new window class.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIWindowChangeClass" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inWindowClass :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Window Flushing                                                                   
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  HIWindowFlush()
;  *  
;  *  Summary:
;  *    Flushes any dirty areas a window might have.
;  *  
;  *  Discussion:
;  *    This routine allows you to manually flush dirty areas of a window
;  *    to the screen. In the past, one would use QDFlushPortBuffer, but
;  *    as we move away from grafports, that type of stuff doesn't make
;  *    much sense these days. This is the preferred routine to flush
;  *    window buffers in Mac OS X 10.3 and beyond.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to flush.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIWindowFlush" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Window Modality                                                                   
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  WindowModality
;  *  
;  

(def-mactype :WindowModality (find-mactype ':UInt32))
; 
;    * A window does not prevent interaction with any other window in the
;    * system.
;    

(defconstant $kWindowModalityNone 0)
; 
;    * A window prevents interaction with all other windows in the
;    * system. Only available in CarbonLib. Mapped to
;    * kWindowModalityAppModal in Mac OS X.
;    

(defconstant $kWindowModalitySystemModal 1)
; 
;    * A window prevents interaction with other windows in the same
;    * process.
;    

(defconstant $kWindowModalityAppModal 2)
; 
;    * A window prevents interaction with a single other window.
;    

(defconstant $kWindowModalityWindowModal 3)
; 
;  *  SetWindowModality()
;  *  
;  *  Summary:
;  *    Sets the modality of a window.
;  *  
;  *  Discussion:
;  *    The modality of a window is used by the Carbon event manager to
;  *    automatically determine appropriate event handling.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose modality to set.
;  *    
;  *    inModalKind:
;  *      The new modality for the window.
;  *    
;  *    inUnavailableWindow:
;  *      If the window is becoming window-modal, this parameter
;  *      specifies the window to which the inWindow parameter is modal.
;  *      The unavailableWindow will not be available while inWindow is
;  *      in window-modal state.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowModality" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inModalKind :UInt32)
    (inUnavailableWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowModality()
;  *  
;  *  Summary:
;  *    Retrieves the modality of a window.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose modality to retrieve.
;  *    
;  *    outModalKind:
;  *      On exit, contains the modality of the window.
;  *    
;  *    outUnavailableWindow:
;  *      On exit, if the window is window-modal, contains the target
;  *      window of the specified window's modality.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowModality" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outModalKind (:pointer :WINDOWMODALITY))
    (outUnavailableWindow (:pointer :WindowRef));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HIWindowIsDocumentModalTarget()
;  *  
;  *  Summary:
;  *    Determines if a window is currently the target window of another
;  *    document modal window, such as a sheet.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window in question.
;  *    
;  *    outOwner:
;  *      If inWindow is the target of a document modal window, outOwner
;  *      is set to the document modal window on exit. If this function
;  *      does not return true, outOwner is undefined. You may pass NULL
;  *      if you don't want the owner's window ref.
;  *  
;  *  Result:
;  *    A boolean result. A true result indicates that inWindow is
;  *    currently the target of a document modal window.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIWindowIsDocumentModalTarget" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outOwner (:pointer :HIWINDOWREF))          ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Floating Windows                                                                   
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;    Routines available from Mac OS 8.6 forward
;    or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
; 
; 
;  *  ShowFloatingWindows()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_ShowFloatingWindows" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HideFloatingWindows()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_HideFloatingWindows" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  AreFloatingWindowsVisible()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_AreFloatingWindowsVisible" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Groups                                                                      
;                                                                                       
;  The Window Group API allows the creation and management of groups of windows,        
;  allowing control of the z-order, activation, and positioning of the windows.         
;  Internally to the Window Manager, each of the standard window tiers (document,       
;  toolbar, floating, modal, utility, help, and overlay) is implemented as a window     
;  group; you can access the window group for a class with GetWindowGroupOfClass.       
;  You can create your own window groups, if you would like your windows to float,      
;  for example, above the floating window layer but below the modal layer. It is        
;  also possible to create more complex hierarchical arrangements of window groups.     
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :WindowGroupRef (find-mactype '(:pointer :OpaqueWindowGroupRef)))
;  may be passed as the "behindWindow" parameter to NewCWindow and SendBehind
(defconstant $kFirstWindowOfGroup -1)
; #define kFirstWindowOfGroup             ((WindowRef)(-1))
; #define kLastWindowOfGroup              ((WindowRef)NULL)
;  may be passed as the "behindGroup" parameter to SendWindowGroupBehind
(defconstant $kFirstWindowGroup -1)
; #define kFirstWindowGroup               ((WindowGroupRef)(-1))
; #define kLastWindowGroup                ((WindowGroupRef)NULL)
; 
;  *  WindowGroupAttributes
;  *  
;  *  Summary:
;  *    These are attributes that may be applied to a window group.
;  

(def-mactype :WindowGroupAttributes (find-mactype ':UInt32))
; 
;    * Makes the group behave somewhat as a layer of windows that move
;    * together. When any window in the group is brought to the front of
;    * the group, the entire group will also be brought to the front of
;    * the containing group's child hierarchy.
;    

(defconstant $kWindowGroupAttrSelectAsLayer 1)
; 
;    * The positions of the contents of this group with respect to each
;    * other cannot be changed. When one item moves, all other items are
;    * moved simultaneously.
;    

(defconstant $kWindowGroupAttrMoveTogether 2)
; 
;    * The z-order of the contents of this group with respect to each
;    * other cannot be changed. When one item changes z-order, all other
;    * items are moved simultaneously. For purposes of z-ordering, the
;    * group and all its subgroups are effectively treated as if they
;    * were a single window in the parent group of this group.
;    

(defconstant $kWindowGroupAttrLayerTogether 4)
; 
;    * The active state of the windows in this group is shared. The
;    * windows in the group are activated or deactivated according to the
;    * activation scope of the group, but when any window in the group
;    * changes activation, all other windows change to match.
;    

(defconstant $kWindowGroupAttrSharedActivation 8)
; 
;    * When any window in this group is collapsed, all other windows in
;    * this group are hidden. All subgroups of this group are also
;    * examined for the HideOnCollapse attribute, and any windows of any
;    * subgroup with this attribute are also hidden. All windows will be
;    * shown again when the collapsed window is expanded.
;    

(defconstant $kWindowGroupAttrHideOnCollapse 16)
; 
;  *  WindowActivationScope
;  *  
;  *  Discussion:
;  *    Every window has a WindowActivationScope. It defines how windows
;  *    are activated by the Window Manager with respect to other windows
;  *    in the window’s group and in the current process.
;  

(def-mactype :WindowActivationScope (find-mactype ':UInt32))
; 
;    * Windows with this scope are never activated by the Window Manager.
;    * This should be used when the window’s visual state does not change
;    * based on activation (for example, tooltip windows), or when the
;    * client wishes to manually control all activation. The window owner
;    * is free to explicitly activate windows using the ActivateWindow
;    * and DeactivateWindow APIs.
;    

(defconstant $kWindowActivationScopeNone 0)
; 
;    * Windows with this scope are always active if visible. Windows with
;    * this scope are unaffected by the activation state of other
;    * windows. This activation scope is automatically used by floating
;    * windows.
;    

(defconstant $kWindowActivationScopeIndependent 1)
; 
;    * Windows with this scope are activated relative to other windows
;    * with the same scope in the current process. Only one window with
;    * this scope can be active in the entire process. This activation
;    * scope is automatically used by document and dialog windows.
;    

(defconstant $kWindowActivationScopeAll 2)
; 
;  *  Summary:
;  *    These are constants that can be used for the inNextGroup
;  *    parameter to GetWindowGroupSibling.
;  
; 
;    * Indicates that GetWindowGroupSibling should return the next deeper
;    * sibling group in the z-order.
;    

(defconstant $kNextWindowGroup $true)
; 
;    * Indicates that GetWindowGroupSibling should return the next higher
;    * sibling group in the z-order.
;    

(defconstant $kPreviousWindowGroup $false)
; 
;  *  WindowGroupContentOptions
;  *  
;  *  Discussion:
;  *    Window group contents options are used to control what group
;  *    content is counted or returned by the CountWindowGroupContents
;  *    and GetWindowGroupContents APIs.
;  

(def-mactype :WindowGroupContentOptions (find-mactype ':UInt32))
; 
;    * Indicates that Count/GetWindowGroupContents should return the
;    * windows in a group. If this option is not set, these APIs return
;    * the groups in a group.
;    

(defconstant $kWindowGroupContentsReturnWindows 1)
; 
;    * Indicates that Count/GetWindowGroupContents should include the
;    * contents of groups contained by the specified group. If this
;    * option is not set, these APIs only return information about the
;    * specified group’s contents.
;    

(defconstant $kWindowGroupContentsRecurse 2)
; 
;    * Indicates that Count/GetWindowGroupContents should only include
;    * visible windows. Only valid when kWindowGroupContentsReturnWindows
;    * is specified.
;    

(defconstant $kWindowGroupContentsVisible 4)
; ----------------------------------------------------------------------------------
;   • Group creation, destruction, and refcounting                                  
; ----------------------------------------------------------------------------------
; 
;  *  CreateWindowGroup()
;  *  
;  *  Summary:
;  *    Creates a new window group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inAttributes:
;  *      Attributes for the new window group.
;  *    
;  *    outGroup:
;  *      On exit, contains the new window group.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateWindowGroup" 
   ((inAttributes :UInt32)
    (outGroup (:pointer :WINDOWGROUPREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RetainWindowGroup()
;  *  
;  *  Summary:
;  *    Increments the refcount of a window group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose refcount to increment.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RetainWindowGroup" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ReleaseWindowGroup()
;  *  
;  *  Summary:
;  *    Releases a refcount on a window group. If the refcount goes to
;  *    zero, the group is destroyed, and a refcount is released from all
;  *    contained objects.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose refcount to decrement.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ReleaseWindowGroup" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowGroupRetainCount()
;  *  
;  *  Summary:
;  *    Returns the refcount of a window group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose refcount to return.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowGroupRetainCount" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :UInt32
() )
; 
;  *  GetWindowGroupOfClass()
;  *  
;  *  Summary:
;  *    Gets the window group in which windows of a given class are
;  *    placed.
;  *  
;  *  Discussion:
;  *    The Window Manager uses window groups internally to manage the
;  *    ordering of windows of different classes. In some cases, multiple
;  *    classes are placed within the same group; for example, windows
;  *    from all of the modal and alert window classes are placed into
;  *    the same modal window group. The refcount of the group returned
;  *    by this API is not incremented, and the caller does not need to
;  *    release the reference.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    windowClass:
;  *      The class whose window group to retrieve. You may pass
;  *      kAllWindowClasses to retrieve the root window group.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowGroupOfClass" 
   ((windowClass :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowGroupRef)
() )
; ----------------------------------------------------------------------------------
;   • Group name, attributes, and level                                             
; ----------------------------------------------------------------------------------
; 
;  *  SetWindowGroupName()
;  *  
;  *  Summary:
;  *    Sets the name of a window group.
;  *  
;  *  Discussion:
;  *    The name of a window group is never displayed to the user.
;  *    However, it is displayed by debugging functions such as
;  *    DebugPrintWindowGroup. This can be very useful when debugging the
;  *    structure of your window groups.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose name to set.
;  *    
;  *    inName:
;  *      The name of the group.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowGroupName" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
    (inName (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CopyWindowGroupName()
;  *  
;  *  Summary:
;  *    Returns a copy of the name of a window group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose name to retrieve.
;  *    
;  *    outName:
;  *      On exit, contains the name of the group. It is the caller's
;  *      responsibility to release the name.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CopyWindowGroupName" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
    (outName (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowGroupAttributes()
;  *  
;  *  Summary:
;  *    Retrieves the attributes of a window group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose attributes to retrieve.
;  *    
;  *    outAttributes:
;  *      On exit, the group’s attributes.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowGroupAttributes" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
    (outAttributes (:pointer :WINDOWGROUPATTRIBUTES))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ChangeWindowGroupAttributes()
;  *  
;  *  Summary:
;  *    Changes the attributes of a window group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose attributes to change.
;  *    
;  *    setTheseAttributes:
;  *      The attributes to set.
;  *    
;  *    clearTheseAttributes:
;  *      The attributes to clear.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ChangeWindowGroupAttributes" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
    (setTheseAttributes :UInt32)
    (clearTheseAttributes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetWindowGroupLevel()
;  *  
;  *  Summary:
;  *    Sets the CoreGraphics window group level of windows in a group.
;  *  
;  *  Discussion:
;  *    CoreGraphics windows (used to implement all windows in Carbon and
;  *    Cocoa applications on Mac OS X) are divided into layers specified
;  *    by a window level. Standard window levels are listed in
;  *    <CoreGraphics/CGWindowLevel.h>. By default, a new window group
;  *    has a window level of kCGNormalWindowLevel. When a window is
;  *    placed into a window group, its window level is determined by the
;  *    window level of its "base group". This is the containing group
;  *    that is a child of the root group. For example, if group A is a
;  *    child of the root group, and group B is a child of group A, and
;  *    window C is in group B, then window C's base group is group A,
;  *    and group A's window level determines the level of window C.
;  *    SetWindowGroupLevel only allows changing the window level of
;  *    groups that are children of the root group. It returns paramErr
;  *    for other groups, since a group that is not a child of the root
;  *    group is not a base group and changing its level has no effect.
;  *    Changing the level of a group also changes the level of all
;  *    windows currently contained by the group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The window group whose level to change.
;  *    
;  *    inLevel:
;  *      The new level for the windows in this group.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowGroupLevel" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
    (inLevel :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowGroupLevel()
;  *  
;  *  Summary:
;  *    Gets the CoreGraphics window group level of windows in a group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The window group whose level to return.
;  *    
;  *    outLevel:
;  *      On exit, contains the window level of the windows in this group.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowGroupLevel" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
    (outLevel (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;   • Group z-ordering                                                              
; ----------------------------------------------------------------------------------
; 
;  *  SendWindowGroupBehind()
;  *  
;  *  Summary:
;  *    Changes the z-order of a group, if the group does not have the
;  *    kWindowGroupAttributeLayerTogether attribute set.
;  *  
;  *  Discussion:
;  *    SendWindowGroupBehind currently requires that the group being
;  *    moved and the behindGroup have the same parent group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose z-order to change.
;  *    
;  *    behindGroup:
;  *      The group behind which to position the specified group.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SendWindowGroupBehind" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
    (behindGroup (:pointer :OpaqueWindowGroupRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;   • Group containment hierarchy manipulation                                      
; ----------------------------------------------------------------------------------
; 
;  *  GetWindowGroup()
;  *  
;  *  Summary:
;  *    Gets the window group that contains a window.
;  *  
;  *  Discussion:
;  *    The refcount of the group returned by this API is not
;  *    incremented, and the caller does not need to release the
;  *    reference.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose containing group to retrieve.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowGroup" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowGroupRef)
() )
; 
;  *  SetWindowGroup()
;  *  
;  *  Summary:
;  *    Sets the window group that contains a window.
;  *  
;  *  Discussion:
;  *    The window’s z-order relative to windows in the current process
;  *    may also be changed by this API. If the new window group is
;  *    z-ordered above the window’s current group, the window will be
;  *    placed at the end of the new group. If the new window group is
;  *    z-ordered below the window’s current group, the window will be
;  *    placed at the top of the new group. You may not place a window
;  *    directly into the root group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose group to change.
;  *    
;  *    inNewGroup:
;  *      The new containing group.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowGroup" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inNewGroup (:pointer :OpaqueWindowGroupRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  IsWindowContainedInGroup()
;  *  
;  *  Summary:
;  *    Indicates whether a window is contained within a group or any of
;  *    its subgroups.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose containment to examine.
;  *    
;  *    inGroup:
;  *      The group that might contain the window.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsWindowContainedInGroup" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inGroup (:pointer :OpaqueWindowGroupRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  GetWindowGroupParent()
;  *  
;  *  Summary:
;  *    Gets the window group that contains a group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose containing group to retrieve.
;  *    
;  *    outGroup:
;  *      On exit, the containing window group of the group. The group’s
;  *      refcount is not incremented by this API, and the caller does
;  *      not need to release the reference.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowGroupParent" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowGroupRef)
() )
; 
;  *  SetWindowGroupParent()
;  *  
;  *  Summary:
;  *    Sets the window group that contains a group.
;  *  
;  *  Discussion:
;  *    SetWindowGroupParent currently requires that the group have no
;  *    windows in it.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose containing group to change.
;  *    
;  *    inNewGroup:
;  *      The new containing group.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowGroupParent" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
    (inNewGroup (:pointer :OpaqueWindowGroupRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowGroupSibling()
;  *  
;  *  Summary:
;  *    Returns the next or previous group of a window group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose sibling to return.
;  *    
;  *    inNextGroup:
;  *      True to return the next sibling, false to return the previous
;  *      sibling.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowGroupSibling" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
    (inNextGroup :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowGroupRef)
() )
; 
;  *  GetWindowGroupOwner()
;  *  
;  *  Summary:
;  *    Returns the window that owns a window group, or NULL if none.
;  *  
;  *  Discussion:
;  *    A window may own one or more window groups. The windows in an
;  *    owned window group will always be z-ordered above the owner
;  *    window. Whenever the owner window changes z-order, the windows in
;  *    the groups owned by the window will be moved also.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose owner to retrieve.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowGroupOwner" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  SetWindowGroupOwner()
;  *  
;  *  Summary:
;  *    Sets the window that owns a window group.
;  *  
;  *  Discussion:
;  *    The group and the window must have the same parent group.
;  *    SetWindowGroupOwner currently requires that the group have no
;  *    windows in it.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose owner to set.
;  *    
;  *    inWindow:
;  *      The group's new owner.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowGroupOwner" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
    (inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;   • Inspection of group contents                                                  
; ----------------------------------------------------------------------------------
; 
;  *  CountWindowGroupContents()
;  *  
;  *  Summary:
;  *    Counts the windows or groups contained in a group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose contents to count.
;  *    
;  *    inOptions:
;  *      Specifies how to count the group’s contents.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CountWindowGroupContents" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
    (inOptions :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetWindowGroupContents()
;  *  
;  *  Summary:
;  *    Retrieves the windows or groups contained in a group.
;  *  
;  *  Discussion:
;  *    The windows or groups returned by this API will be placed into
;  *    the output buffer in z-order, from highest to lowest.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose contents to retrieve.
;  *    
;  *    inOptions:
;  *      Specifies which content to retrieve.
;  *    
;  *    inAllowedItems:
;  *      The number of items that will fit in the output buffer.
;  *    
;  *    outNumItems:
;  *      On exit, the number of items that were returned. May be NULL.
;  *    
;  *    outItems:
;  *      On entry, points to enough memory to hold inAllowedSize
;  *      WindowRefs or WindowGroupRefs. On exit, contains *outNumItems
;  *      WindowRefs or WindowGroupRefs.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowGroupContents" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
    (inOptions :UInt32)
    (inAllowedItems :UInt32)
    (outNumItems (:pointer :ItemCount))         ;  can be NULL 
    (outItems :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetIndexedWindow()
;  *  
;  *  Summary:
;  *    Retrieves a specified window from a group.
;  *  
;  *  Discussion:
;  *    GetIndexedWindow is provided as an easier way to get a particular
;  *    window from a group than using GetWindowGroupContents. If you
;  *    only need to retrieve, say, the last window in a group, it is
;  *    easier and more efficient to use GetIndexedWindow. If you need to
;  *    retrieve all the windows in a group, it is more efficient to use
;  *    GetWindowGroupContents.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group containing the window to retrieve.
;  *    
;  *    inIndex:
;  *      The index of the window. This parameter may range from 1 to
;  *      CountWindowGroupContents( inGroup,
;  *      kWindowGroupContentsReturnWindows | inOptions );
;  *    
;  *    inOptions:
;  *      Indicates how to locate the specified window.
;  *      kWindowGroupContentsReturnWindows is implied by this API and
;  *      does not need to be explicitly specified.
;  *    
;  *    outWindow:
;  *      On exit, the window at the specified index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetIndexedWindow" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
    (inIndex :UInt32)
    (inOptions :UInt32)
    (outWindow (:pointer :WindowRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowIndex()
;  *  
;  *  Summary:
;  *    Retrieves the z-order index of a window inside a group.
;  *  
;  *  Discussion:
;  *    The z-order index of a window is its relative position in z-order
;  *    inside a group. The index ranges from 1 to the number of windows
;  *    in the group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose z-order index to retrieve.
;  *    
;  *    inStartGroup:
;  *      The group on which to base the z-order index. This should be
;  *      either the containing group of the window, or NULL. If NULL,
;  *      this API returns the z-order index of the window across the
;  *      entire process.
;  *    
;  *    inOptions:
;  *      Indicates how to enumerate the specified window.
;  *      kWindowGroupContentsReturnWindows is implied by this API and
;  *      does not need to be explicitly specified.
;  *    
;  *    outIndex:
;  *      On exit, contains the window’s z-order index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowIndex" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inStartGroup (:pointer :OpaqueWindowGroupRef))
    (inOptions :UInt32)
    (outIndex (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;   • Window activation                                                             
; ----------------------------------------------------------------------------------
; 
;  *  ActiveNonFloatingWindow()
;  *  
;  *  Summary:
;  *    Returns the window, among all windows with activation scope of
;  *    kWindowActivationScopeAll, that is considered active.
;  *  
;  *  Discussion:
;  *    The Mac OS 8.5 Window Manager introduced the
;  *    FrontNonFloatingWindow API, which was designed to return the
;  *    window that should be considered active by the application. With
;  *    the advent of window groups, it is now possible to have a window
;  *    that looks active (is highlighted, and accepts keyboard input)
;  *    but to have other non-floating windows grouped above the active
;  *    window. The ActiveNonFloatingWindow API returns the active window
;  *    regardless of where it is positioned in the z-order. Most code
;  *    that currently uses FrontNonFloatingWindow or
;  *    GetFrontWindowOfClass(kDocumentClass) to get the active window
;  *    should use ActiveNonFloatingWindow instead.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ActiveNonFloatingWindow" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  IsWindowActive()
;  *  
;  *  Summary:
;  *    Indicates whether a window is active.
;  *  
;  *  Discussion:
;  *    The active state of a window is simply determined by whether its
;  *    window frame is drawn using an active appearance. This does not
;  *    indicate whether the window has keyboard focus. To get the window
;  *    with keyboard focus, use GetUserFocusWindow().
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose active state to retrieve.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsWindowActive" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  ActivateWindow()
;  *  
;  *  Summary:
;  *    Activates or deactivates a window.
;  *  
;  *  Discussion:
;  *    Window activation consists of two steps: hiliting the window
;  *    frame and sending an activate event to the window. ActivateWindow
;  *    handles both of these steps and also updates internal Window
;  *    Manager state. If you just need to hilite the window frame, you
;  *    may use HiliteWindow. If you need to send an activate event, you
;  *    should always use ActivateWindow rather than creating and sending
;  *    the event yourself.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to activate or deactivate.
;  *    
;  *    inActivate:
;  *      Whether to activate or deactivate the window.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ActivateWindow" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inActivate :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowActivationScope()
;  *  
;  *  Summary:
;  *    Retrieves a window’s activation scope.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose activation scope to retrieve.
;  *    
;  *    outScope:
;  *      On exit, the window’s activation scope.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowActivationScope" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outScope (:pointer :WINDOWACTIVATIONSCOPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetWindowActivationScope()
;  *  
;  *  Summary:
;  *    Sets a window’s activation scope.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose activation scope to set.
;  *    
;  *    inScope:
;  *      The new activation scope.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowActivationScope" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inScope :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;   • Debugging Utilities                                                           
; ----------------------------------------------------------------------------------
; 
;  *  DebugPrintWindowGroup()
;  *  
;  *  Summary:
;  *    Prints the contents of a window group to stdout.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGroup:
;  *      The group whose contents to print.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DebugPrintWindowGroup" 
   ((inGroup (:pointer :OpaqueWindowGroupRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DebugPrintAllWindowGroups()
;  *  
;  *  Summary:
;  *    Prints the full window group hierarchy, starting at the root
;  *    group.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DebugPrintAllWindowGroups" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ----------------------------------------------------------------------------------
;   • ThemeBrush and ThemeTextColor support                                         
; ----------------------------------------------------------------------------------
; 
;  *  SetThemeWindowBackground()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetThemeWindowBackground" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inBrush :SInt16)
    (inUpdate :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetThemeTextColorForWindow()
;  *  
;  *  Summary:
;  *    Sets a text color which contrasts with a theme brush.
;  *  
;  *  Discussion:
;  *    SetThemeTextColorForWindow sets a text color in the specified
;  *    window's port which contrasts with the specified brush and also
;  *    matches the inActive parameter. Only a subset of the theme
;  *    brushes have theme text colors: currently (as of Mac OS 9 and Mac
;  *    OS X 10.1), the Alert, Dialog, ModelessDialog, and Notification
;  *    brushes have corresponding text colors. For any other brush,
;  *    SetThemeTextColorForWindow returns themeNoAppropriateBrushErr and
;  *    does not modify the text color.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose text color to change.
;  *    
;  *    inActive:
;  *      Whether the text color should indicate an active or inactive
;  *      state.
;  *    
;  *    inDepth:
;  *      The bit depth of the window's port.
;  *    
;  *    inColorDev:
;  *      Whether the window's port is color or black&white.
;  *  
;  *  Result:
;  *    An operating system result code, including
;  *    themeNoAppropriateBrushErr if the specified theme brush does not
;  *    have a corresponding theme text color.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_SetThemeTextColorForWindow" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inActive :Boolean)
    (inDepth :SInt16)
    (inColorDev :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Background Image                                                                   
; ——————————————————————————————————————————————————————————————————————————————————————
;  SetWinColor is not available in Carbon.
; 
;  *  SetWinColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
;  SetDeskCPat is not available in Carbon.
; 
;  *  SetDeskCPat()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;    Routines available from Mac OS 8.5 forward
;    or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
; 
; 
;  *  SetWindowContentColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_SetWindowContentColor" 
   ((window (:pointer :OpaqueWindowPtr))
    (color (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowContentColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowContentColor" 
   ((window (:pointer :OpaqueWindowPtr))
    (color (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Routines available from Mac OS 8.5 forward
; 
;  *  GetWindowContentPattern()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowContentPattern" 
   ((window (:pointer :OpaqueWindowPtr))
    (outPixPat (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetWindowContentPattern()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_SetWindowContentPattern" 
   ((window (:pointer :OpaqueWindowPtr))
    (pixPat (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Routines available from Mac OS 9.0 forward

(def-mactype :WindowPaintProcOptions (find-mactype ':UInt32))

(defconstant $kWindowPaintProcOptionsNone 0)
; 
;  *  InstallWindowContentPaintProc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 9.0 and later
;  

(deftrap-inline "_InstallWindowContentPaintProc" 
   ((window (:pointer :OpaqueWindowPtr))
    (paintProc (:pointer :OpaqueWindowPaintProcPtr))
    (options :UInt32)
    (refCon :pointer)                           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Scrolling Routines                                                                 
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :ScrollWindowOptions (find-mactype ':UInt32))

(defconstant $kScrollWindowNoOptions 0)
(defconstant $kScrollWindowInvalidate 1)        ;  add the exposed area to the window’s update region
;  erase the exposed area using the background color/pattern of the window’s grafport

(defconstant $kScrollWindowEraseToPortBackground 2)
;  Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
; 
;  *  ScrollWindowRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ScrollWindowRect" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inScrollRect (:pointer :Rect))
    (inHPixels :SInt16)
    (inVPixels :SInt16)
    (inOptions :UInt32)
    (outExposedRgn (:pointer :OpaqueRgnHandle)) ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ScrollWindowRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ScrollWindowRegion" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inScrollRgn (:pointer :OpaqueRgnHandle))
    (inHPixels :SInt16)
    (inVPixels :SInt16)
    (inOptions :UInt32)
    (outExposedRgn (:pointer :OpaqueRgnHandle)) ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Low-Level Region & Painting Routines                                               
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  ClipAbove()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ClipAbove" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  SaveOld/DrawNew are not available in Carbon.  Use ReshapeCustomWindow instead.
; 
;  *  SaveOld()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  DrawNew()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PaintOne()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PaintOne" 
   ((window (:pointer :OpaqueWindowPtr))        ;  can be NULL 
    (clobberedRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PaintBehind()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PaintBehind" 
   ((startWindow (:pointer :OpaqueWindowPtr))   ;  can be NULL 
    (clobberedRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CalcVis()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CalcVis" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CalcVisBehind()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CalcVisBehind" 
   ((startWindow (:pointer :OpaqueWindowPtr))   ;  can be NULL 
    (clobberedRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CheckUpdate()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CheckUpdate" 
   ((theEvent (:pointer :EventRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window List                                                                        
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  [Mac]FindWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacFindWindow FindWindow

; #endif


(deftrap-inline "_FindWindow" 
   ((thePoint :Point)
    (window (:pointer :WindowRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  FrontWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FrontWindow" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  BringToFront()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_BringToFront" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SendBehind()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SendBehind" 
   ((window (:pointer :OpaqueWindowPtr))
    (behindWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SelectWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SelectWindow" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    Routines available from Mac OS 8.6 forward
;    or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
; 
; 
;  *  FrontNonFloatingWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_FrontNonFloatingWindow" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
;  Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
; 
;  *  GetNextWindowOfClass()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetNextWindowOfClass" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inWindowClass :UInt32)
    (mustBeVisible :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  GetFrontWindowOfClass()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetFrontWindowOfClass" 
   ((inWindowClass :UInt32)
    (mustBeVisible :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  FindWindowOfClass()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FindWindowOfClass" 
   ((where (:pointer :Point))
    (inWindowClass :UInt32)
    (outWindow (:pointer :WindowRef))
    (outWindowPart (:pointer :WINDOWPARTCODE))  ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  Summary:
;  *    Options for the CreateStandardWindowMenu API.
;  
; 
;    * Requests the standard window menu include a Rotate Windows menu
;    * item. Available in Mac OS X 10.2.
;    

(defconstant $kWindowMenuIncludeRotate 1)
; 
;  *  CreateStandardWindowMenu()
;  *  
;  *  Discussion:
;  *    Creates a standard Window menu for your application. You can call
;  *    this to create a window menu for your application. Once you have
;  *    the menu, you need to insert it in your menu bar (typically at
;  *    the end of your menu list) with a call to InsertMenu. To register
;  *    a window to be tracked by this menu, you either create your
;  *    window with CreateNewWindow, passing the
;  *    kWindowInWindowMenuAttribute, or you can use
;  *    ChangeWindowAttributes after the window is created. The Toolbox
;  *    takes care of acting on the standard items such as zoom and
;  *    minimize, as well as bringing selected windows to the front. All
;  *    you need to do is install it and register your windows and the
;  *    Toolbox does the rest.
;  *    
;  *    You may also add your own menu items to the standard window menu.
;  *    To do this, we recommend that you use the
;  *    GetIndMenuItemWithCommandID API to locate one of the standard
;  *    menu items in the menu which is immediately above or below the
;  *    location where you wish to insert your items. Then insert your
;  *    items relative to the position of the standard menu item. Do not
;  *    attempt to search the menu items yourself without calling
;  *    GetIndMenuItemWithCommandID; in Mac OS X 10.2,
;  *    CreateStandardWindowMenu returns an initially empty menu which is
;  *    populated later when the menu is displayed or when
;  *    GetIndMenuItemWithCommandID is called, so you will find no items
;  *    in the menu unless you first call GetIndMenuItemWithCommandID.
;  *    
;  *    There is a known bug in all versions of CarbonLib which causes
;  *    the Zoom, Collapse, and Uncollapse menu items in the standard
;  *    window menu to be non-functional for windows created by the
;  *    Dialog Manager. To work around this bug, you can install your own
;  *    event handlers on the dialog window for kEventWindowZoom,
;  *    kEventWindowCollapse, and kEventWindowExpand, and handle the
;  *    event by calling the appropriate Window Manager API.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inOptions:
;  *      Requests optional behavior of the standard window menu. Mac OS
;  *      X 10.2 supports the kWindowMenuIncludeRotate option; in earlier
;  *      versions of Mac OS X, and in CarbonLib, you must pass zero for
;  *      this parameter.
;  *    
;  *    outMenu:
;  *      Receives a new menu reference which contains the standard
;  *      window menu items and commands.
;  *  
;  *  Result:
;  *    An operating system status code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateStandardWindowMenu" 
   ((inOptions :UInt32)
    (outMenu (:pointer :MenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetWindowAlternateTitle()
;  *  
;  *  Discussion:
;  *    This API sets an alternate title for a window. The alternate
;  *    title overrides what is displayed in the Window menu. If you do
;  *    not set an alternate title, the normal window title is used. You
;  *    would normally use this if the window title was not expressive
;  *    enough to be used in the Window menu (or similar text-only
;  *    situation).
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to set the alternate title.
;  *    
;  *    inTitle:
;  *      The alternate title for the window. Passing NULL for this
;  *      parameter will remove any alternate title that might be present.
;  *  
;  *  Result:
;  *    An operating system status code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowAlternateTitle" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inTitle (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CopyWindowAlternateTitle()
;  *  
;  *  Discussion:
;  *    This API gets the alternate title for a window. See the
;  *    discussion of SetWindowAlternateTitle for more info.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to get the alternate title from.
;  *    
;  *    outTitle:
;  *      Receives the alternate title for the window. If the window does
;  *      not have an alternate title, NULL will be returned in outTitle.
;  *  
;  *  Result:
;  *    An operating system status code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CopyWindowAlternateTitle" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outTitle (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Misc Low-Level stuff                                                               
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  InitWindows()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
;   The window manager port does not exist in Carbon.   
;   We are investigating replacement technologies.      
; 
;  *  GetWMgrPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  GetCWMgrPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;    Routines available from Mac OS 8.5 forward
;    or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
; 
; 
;  *  IsValidWindowPtr()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_IsValidWindowPtr" 
   ((possibleWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; #define IsValidWindowRef IsValidWindowPtr
; 
;    Routines available from Mac OS 8.6 forward
;    InitFloatingWindows is not available in Carbon;
;    window ordering is always active for Carbon clients
; 
; 
;  *  InitFloatingWindows()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Various & Sundry Window Accessors                                                  
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  HiliteWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HiliteWindow" 
   ((window (:pointer :OpaqueWindowPtr))
    (fHilite :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetWRefCon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetWRefCon" 
   ((window (:pointer :OpaqueWindowPtr))
    (data :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetWRefCon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetWRefCon" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetWindowPic()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetWindowPic" 
   ((window (:pointer :OpaqueWindowPtr))
    (pic (:Handle :Picture))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetWindowPic()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetWindowPic" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :Picture)
() )
; 
;  *  GetWVariant()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetWVariant" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
;  Routines available from Mac OS 8.0 (Appearance 1.0) forward
; 
;  *  GetWindowFeatures()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetWindowFeatures" 
   ((window (:pointer :OpaqueWindowPtr))
    (outFeatures (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetWindowRegion" 
   ((window (:pointer :OpaqueWindowPtr))
    (inRegionCode :UInt16)
    (ioWinRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowStructureWidths()
;  *  
;  *  Summary:
;  *    Returns the width of the structure region on each edge of a
;  *    window.
;  *  
;  *  Discussion:
;  *    The structure widths are the difference between the content
;  *    region and the structure region on each edge of a window. For
;  *    example, if the left edge of the structure region is at x=100,
;  *    and the left edge of the content region is at x=110, then the
;  *    structure width for the left side of the window is 10 pixels.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window for which to get structure widths.
;  *    
;  *    outRect:
;  *      On exit, contains the width of the structure region on each
;  *      side of the window; the left field of the rectangle contains
;  *      the structure width on the left side of the window, the top
;  *      field contains the width on the top side, and so on.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowStructureWidths" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HIWindowChangeFeatures()
;  *  
;  *  Summary:
;  *    Changes the window features on the fly.
;  *  
;  *  Discussion:
;  *    HIWindowChangeFeatures changes the features of a window. This
;  *    should only be used by custom window definitions.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to modify.
;  *    
;  *    inSetThese:
;  *      The feature bits to set.
;  *    
;  *    inClearThese:
;  *      The feature bits to clear.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIWindowChangeFeatures" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inSetThese :UInt64)
    (inClearThese :UInt64)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Update Events                                                                      
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;    These aren't present in Carbon. Please use the InvalWindowRect, etc. routines
;    below instead.
; 
; 
;  *  InvalRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  InvalRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  ValidRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  ValidRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  BeginUpdate()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_BeginUpdate" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  EndUpdate()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_EndUpdate" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    Routines available from Mac OS 8.5 forward
;    or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
; 
; 
;  *  InvalWindowRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_InvalWindowRgn" 
   ((window (:pointer :OpaqueWindowPtr))
    (region (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InvalWindowRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_InvalWindowRect" 
   ((window (:pointer :OpaqueWindowPtr))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ValidWindowRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_ValidWindowRgn" 
   ((window (:pointer :OpaqueWindowPtr))
    (region (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ValidWindowRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_ValidWindowRect" 
   ((window (:pointer :OpaqueWindowPtr))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • DrawGrowIcon                                                                       
;                                                                                       
;   DrawGrowIcon is deprecated from Mac OS 8.0 forward.  Theme-savvy window defprocs    
;   include the grow box in the window frame.                                           
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  DrawGrowIcon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DrawGrowIcon" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Titles                                                                      
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  SetWTitle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetWTitle" 
   ((window (:pointer :OpaqueWindowPtr))
    (title (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetWTitle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetWTitle" 
   ((window (:pointer :OpaqueWindowPtr))
    (title (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetWindowTitleWithCFString()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowTitleWithCFString" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inString (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CopyWindowTitleAsCFString()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CopyWindowTitleAsCFString" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outString (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Proxies                                                                     
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  SetWindowProxyFSSpec()
;  *  
;  *  Summary:
;  *    Set the proxy icon for a window using an FSSpec to an existing
;  *    file system object (volume, folder, or file).
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window whose proxy icon to set.
;  *    
;  *    inFile:
;  *      The file system object that the window represents. The window’s
;  *      proxy icon is determined by asking Icon Services for the icon
;  *      of this object.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_SetWindowProxyFSSpec" 
   ((window (:pointer :OpaqueWindowPtr))
    (inFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowProxyFSSpec()
;  *  
;  *  Summary:
;  *    Returns the FSSpec used to determine the proxy icon for a window.
;  *  
;  *  Discussion:
;  *    This API will return noErr and a valid FSSpec if the window’s
;  *    proxy icon has been specified using the SetWindowProxyFSSpec or
;  *    SetWindowProxyAlias APIs. If the window has no proxy icon, or if
;  *    the icon was specified with another SetWindowProxy API, then an
;  *    error will be returned.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window whose proxy icon FSSpec to return.
;  *    
;  *    outFile:
;  *      On exit, contains the window’s proxy icon FSSpec.
;  *  
;  *  Result:
;  *    noErr if the window’s proxy icon FSSpec has been returned;
;  *    errWindowDoesNotHaveProxy if the window does not have a proxy
;  *    icon, or if the proxy icon was specified by IconRef or
;  *    type/creator rather than by FSSpec or alias. Other operating
;  *    system error codes may also be returned.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowProxyFSSpec" 
   ((window (:pointer :OpaqueWindowPtr))
    (outFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetWindowProxyAlias()
;  *  
;  *  Summary:
;  *    Sets the proxy icon for a window using an AliasHandle to an
;  *    existing file system object (volume, folder, or file).
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose proxy icon to set.
;  *    
;  *    inAlias:
;  *      The file system object that the window represents. The window’s
;  *      proxy icon is determined by asking Icon Services for the icon
;  *      of this object. The Window Manager copies the alias data; the
;  *      caller may dispose of the alias after SetWindowProxyAlias
;  *      returns.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_SetWindowProxyAlias" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inAlias (:Handle :AliasRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowProxyAlias()
;  *  
;  *  Summary:
;  *    Returns the alias used to determine the proxy icon for a window.
;  *  
;  *  Discussion:
;  *    This API will return noErr and a valid alias if the window’s
;  *    proxy icon has been specified using the SetWindowProxyFSSpec or
;  *    SetWindowProxyAlias APIs. If the window has no proxy icon, or if
;  *    the icon was specified with another SetWindowProxy API, then an
;  *    error will be returned.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window whose proxy icon alias to return.
;  *    
;  *    alias:
;  *      On exit, contains the window’s proxy icon alias.
;  *  
;  *  Result:
;  *    noErr if the window’s proxy icon alias has been returned;
;  *    errWindowDoesNotHaveProxy if the window does not have a proxy
;  *    icon, or if the proxy icon was specified by IconRef or
;  *    type/creator rather than by FSSpec or alias. Other operating
;  *    system error codes may also be returned.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowProxyAlias" 
   ((window (:pointer :OpaqueWindowPtr))
    (alias (:pointer :ALIASHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetWindowProxyCreatorAndType()
;  *  
;  *  Summary:
;  *    Sets the proxy icon for a window using a file type and creator.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window whose proxy icon to set.
;  *    
;  *    fileCreator:
;  *      The creator code for the file system object that the window
;  *      represents. The window’s proxy icon is determined by asking
;  *      Icon Services for the icon corresponding to the specified
;  *      creator code and file type, on the specified volume.
;  *    
;  *    fileType:
;  *      The file type for the file system object that the window
;  *      represents.
;  *    
;  *    vRefNum:
;  *      The volume reference number for the volume containing the file
;  *      system object that the window represents. You may pass
;  *      kOnSystemDisk for this parameter if you don't know which volume
;  *      will hold the file system object.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_SetWindowProxyCreatorAndType" 
   ((window (:pointer :OpaqueWindowPtr))
    (fileCreator :OSType)
    (fileType :OSType)
    (vRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowProxyIcon()
;  *  
;  *  Summary:
;  *    Returns the proxy icon of a window.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window whose proxy icon to return.
;  *    
;  *    outIcon:
;  *      On exit, contains the window’s proxy icon.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowProxyIcon" 
   ((window (:pointer :OpaqueWindowPtr))
    (outIcon (:pointer :ICONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetWindowProxyIcon()
;  *  
;  *  Summary:
;  *    Sets a window’s proxy icon.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window whose proxy icon to set.
;  *    
;  *    icon:
;  *      The proxy icon. The Window Manager retains the IconRef; the
;  *      caller may release the IconRef after SetWindowProxyIcon returns.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_SetWindowProxyIcon" 
   ((window (:pointer :OpaqueWindowPtr))
    (icon (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RemoveWindowProxy()
;  *  
;  *  Summary:
;  *    Removes a window’s proxy icon.
;  *  
;  *  Discussion:
;  *    When removing the proxy icon, the Window Manager also releases
;  *    the alias or IconRef, if any, that was used to specify the proxy
;  *    icon.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window whose proxy icon to remove.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_RemoveWindowProxy" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  BeginWindowProxyDrag()
;  *  
;  *  Summary:
;  *    Creates a new drag reference that can be used to drag a window’s
;  *    proxy icon.
;  *  
;  *  Discussion:
;  *    This API is used by applications that need to add their own drag
;  *    flavors to the drag reference used for a proxy icon drag. Such an
;  *    application would call BeginWindowProxyDrag to create the drag
;  *    reference, add its own flavors, call
;  *    TrackWindowProxyFromExistingDrag to track the proxy icon drag,
;  *    and then EndWindowProxyDrag to release the drag
;  *    reference.
;  *    
;  *    An application which does not need to add its own drag flavors to
;  *    the drag reference can simply call TrackWindowProxyDrag.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window whose proxy icon to drag.
;  *    
;  *    outNewDrag:
;  *      On exit, contains the drag reference for the proxy icon.
;  *    
;  *    outDragOutlineRgn:
;  *      On entry, should be a valid RgnHandle; on exit, the region has
;  *      been updated with an outline of the proxy icon drag image. This
;  *      region should be passed to TrackWindowProxyFromExistingDrag;
;  *      the application may modify it first.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_BeginWindowProxyDrag" 
   ((window (:pointer :OpaqueWindowPtr))
    (outNewDrag (:pointer :DRAGREFERENCE))
    (outDragOutlineRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  EndWindowProxyDrag()
;  *  
;  *  Summary:
;  *    Releases a drag reference created by BeginWindowProxyDrag.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window whose proxy icon drag reference to release.
;  *    
;  *    theDrag:
;  *      The drag reference to release.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_EndWindowProxyDrag" 
   ((window (:pointer :OpaqueWindowPtr))
    (theDrag (:pointer :OpaqueDragRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TrackWindowProxyFromExistingDrag()
;  *  
;  *  Summary:
;  *    Tracks the drag of a window proxy icon.
;  *  
;  *  Discussion:
;  *    This API is used by applications that need to add their own drag
;  *    flavors to the drag reference used for a proxy icon drag. Such an
;  *    application would call BeginWindowProxyDrag to create the drag
;  *    reference, add its own flavors, call
;  *    TrackWindowProxyFromExistingDrag to track the proxy icon drag,
;  *    and then EndWindowProxyDrag to release the drag
;  *    reference.
;  *    
;  *    An application which does not need to add its own drag flavors to
;  *    the drag reference can simply call TrackWindowProxyDrag.
;  *    
;  *    A proxy icon may only be dragged if the window represented by the
;  *    proxy icon is not modifed (as indicated by the IsWindowModified
;  *    API). This restriction is imposed because a proxy icon is a
;  *    representation of a physical file system object, and dragging the
;  *    proxy icon may result in the Finder making a copy of the file
;  *    system object. If the window is modified, then it contains user
;  *    data that has not yet been saved to disk; making a copy of the
;  *    file system object would result in a stale copy that did not
;  *    contain the user’s current data.
;  *    
;  *    By default, all newly created windows are considered to be dirty.
;  *    The application must call SetWindowModified( window, false )
;  *    before the proxy icon will be draggable.
;  *    
;  *    In Mac OS X 10.3 and later, the proxy icon is also draggable in
;  *    dirty windows if the proxy icon was provided using the
;  *    SetWindowProxyIcon or SetWindowProxyCreatorAndType APIs. Dragging
;  *    is allowed in this case because the window does not represent an
;  *    actual file system object, and therefore there is no risk of user
;  *    data loss.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window whose proxy icon to drag.
;  *    
;  *    startPt:
;  *      The point in global coordinates where the drag originated. This
;  *      is generally the location of the mouse click in the proxy icon.
;  *    
;  *    drag:
;  *      The proxy icon drag reference.
;  *    
;  *    inDragOutlineRgn:
;  *      The outline of the proxy icon drag image, as returned by
;  *      BeginWindowProxyDrag.
;  *  
;  *  Result:
;  *    errUserWantsToDragWindow if the user’s mouse movements indicated
;  *    that the user actually wants to drag the window instead of the
;  *    proxy icon (in this case the application should call DragWindow);
;  *    windowWrongStateErr if the window was modified and therefore the
;  *    proxy icon could not be dragged; noErr if the drag succeeded;
;  *    userCanceledErr if the user canceled the drag. Other operating
;  *    system result codes may also be returned.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_TrackWindowProxyFromExistingDrag" 
   ((window (:pointer :OpaqueWindowPtr))
    (startPt :Point)
    (drag (:pointer :OpaqueDragRef))
    (inDragOutlineRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TrackWindowProxyDrag()
;  *  
;  *  Summary:
;  *    Tracks the drag of a window proxy icon.
;  *  
;  *  Discussion:
;  *    A proxy icon may only be dragged if the window represented by the
;  *    proxy icon is not modifed (as indicated by the IsWindowModified
;  *    API). This restriction is imposed because a proxy icon is a
;  *    representation of a physical file system object, and dragging the
;  *    proxy icon may result in the Finder making a copy of the file
;  *    system object. If the window is modified, then it contains user
;  *    data that has not yet been saved to disk; making a copy of the
;  *    file system object would result in a stale copy that did not
;  *    contain the user’s current data.
;  *    
;  *    By default, all newly created windows are considered to be
;  *    modified. The application must call SetWindowModified( window,
;  *    false ) before the proxy icon will be draggable.
;  *    
;  *    In Mac OS X 10.3 and later, the proxy icon is also draggable in
;  *    dirty windows if the proxy icon was provided using the
;  *    SetWindowProxyIcon or SetWindowProxyCreatorAndType APIs. Dragging
;  *    is allowed in this case because the window does not represent an
;  *    actual file system object, and therefore there is no risk of user
;  *    data loss.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window whose proxy icon to drag.
;  *    
;  *    startPt:
;  *      The point in global coordinates where the drag originated. This
;  *      is generally the location of the mouse click in the proxy icon.
;  *  
;  *  Result:
;  *    errUserWantsToDragWindow if the user’s mouse movements indicated
;  *    that the user actually wants to drag the window instead of the
;  *    proxy icon (in this case the application should call DragWindow);
;  *    windowWrongStateErr if the window was modified and therefore the
;  *    proxy icon could not be dragged; noErr if the drag succeeded;
;  *    userCanceledErr if the user canceled the drag. Other operating
;  *    system result codes may also be returned.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_TrackWindowProxyDrag" 
   ((window (:pointer :OpaqueWindowPtr))
    (startPt :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  IsWindowModified()
;  *  
;  *  Summary:
;  *    Returns whether the window is considered to have unsaved content.
;  *  
;  *  Discussion:
;  *    By default, all newly created windows are considered to be
;  *    modified. The application must call SetWindowModified( window,
;  *    false ) to mark the window as unmodified. Until the window is
;  *    marked as unmodified, the proxy icon will not be draggable.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window whose modified state to return.
;  *  
;  *  Result:
;  *    true if the window has unsaved changes, or false if not.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_IsWindowModified" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SetWindowModified()
;  *  
;  *  Summary:
;  *    Sets whether the window is considered to have unsaved content.
;  *  
;  *  Discussion:
;  *    By default, all newly created windows are considered to be
;  *    modified. The application must call SetWindowModified( window,
;  *    false ) to mark the window as unmodified. Until the window is
;  *    marked as unmodified, the proxy icon will not be draggable.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window whose modified state to return.
;  *    
;  *    modified:
;  *      Whether the window has unsaved changes.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_SetWindowModified" 
   ((window (:pointer :OpaqueWindowPtr))
    (modified :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  IsWindowPathSelectClick()
;  *  
;  *  Summary:
;  *    Indicates whether an EventRecord describing a click on a window’s
;  *    title should cause a path selection menu to be displayed.
;  *  
;  *  Discussion:
;  *    Windows that have a proxy icon provided using an FSSpec or alias
;  *    can support a path selection menu, which displays the file system
;  *    path to the object, one menu item per directory. Making a
;  *    selection from this item will automatically open the
;  *    corresponding object in the Finder.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window on which the click occurred.
;  *    
;  *    event:
;  *      The event. IsWindowPathSelectClick will only return true for
;  *      mouseDown events.
;  *  
;  *  Result:
;  *    true if the click should cause a path selection menu to be
;  *    displayed, or false if not. If this API returns true, the
;  *    application should call the WindowPathSelect API.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_IsWindowPathSelectClick" 
   ((window (:pointer :OpaqueWindowPtr))
    (event (:pointer :EventRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  IsWindowPathSelectEvent()
;  *  
;  *  Summary:
;  *    Indicates whether a Carbon event describing a click on a window’s
;  *    title should cause a path selection menu to be displayed.
;  *  
;  *  Discussion:
;  *    Windows that have a proxy icon provided using an FSSpec or alias
;  *    can support a path selection menu, which displays the file system
;  *    path to the object, one menu item per directory. Making a
;  *    selection from this item will automatically open the
;  *    corresponding object in the Finder.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window on which the click occurred.
;  *    
;  *    inEvent:
;  *      The event. In CarbonLib and in Mac OS X 10.2 and earlier,
;  *      IsWindowPathSelectEvent only returned true for
;  *      kEventClassMouse/ kEventMouseDown events. In Mac OS X 10.3 and
;  *      later, IsWindowPathSelectEvent returns true for any event that
;  *      has suitable kEventParamMouseLocation and
;  *      kEventParamKeyModifiers parameters.
;  *  
;  *  Result:
;  *    true if the click should cause a path selection menu to be
;  *    displayed, or false if not. If this API returns true, the
;  *    application should call the WindowPathSelect API.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsWindowPathSelectEvent" 
   ((window (:pointer :OpaqueWindowPtr))
    (inEvent (:pointer :OpaqueEventRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  WindowPathSelect()
;  *  
;  *  Summary:
;  *    Displays a path selection menu for a window that has a proxy icon.
;  *  
;  *  Discussion:
;  *    If the application passes NULL for the menu parameter, and the
;  *    user selects an item from the path selection menu, the Window
;  *    Manager will automatically request the Finder to display that
;  *    item, and in CarbonLib 1.3.1 and later and Mac OS X, will also
;  *    make the Finder be the active application.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window for which to display the path selection menu.
;  *    
;  *    menu:
;  *      The menu to display. If you pass NULL, the Window Manager
;  *      automatically creates a suitable menu based on the window’s
;  *      proxy icon.
;  *    
;  *    outMenuResult:
;  *      On exit, the menu ID and menu item index of the selected item;
;  *      the menu ID is in the high 16 bits of the result, and the menu
;  *      item index is in the low 16 bits.
;  *  
;  *  Result:
;  *    noErr if the user selected an item from the menu; userCanceledErr
;  *    if the user closed the menu without making a selection. Other
;  *    operating system result codes may be returned.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_WindowPathSelect" 
   ((window (:pointer :OpaqueWindowPtr))
    (menu (:pointer :OpaqueMenuRef))            ;  can be NULL 
    (outMenuResult (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • HiliteWindowFrameForDrag                                                          
;                                                                                       
;   If you call ShowDragHilite and HideDragHilite, you don’t need to use this routine.  
;   If you implement custom drag hiliting, you should call HiliteWindowFrameForDrag     
;   when the drag is tracking inside a window with drag-hilited content.                
; ——————————————————————————————————————————————————————————————————————————————————————
;  Routines available from Mac OS 8.5 forward
; 
;  *  HiliteWindowFrameForDrag()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_HiliteWindowFrameForDrag" 
   ((window (:pointer :OpaqueWindowPtr))
    (hilited :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Transitions                                                                 
;                                                                                       
;   TransitionWindow displays a window with accompanying animation and sound.           
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  WindowTransitionEffect
;  *  
;  *  Summary:
;  *    Visual effects that are provided by TransitionWindow
;  

(def-mactype :WindowTransitionEffect (find-mactype ':UInt32))
; 
;    * Finder-like zoom rectangles. Use with TransitionWindow and Show or
;    * Hide transition actions
;    

(defconstant $kWindowZoomTransitionEffect 1)
; 
;    * Zoom in/out from parent. Use with TransitionWindowAndParent and
;    * Show or Hide transition actions. Available in Mac OS X, and in
;    * CarbonLib 1.5 and later.
;    

(defconstant $kWindowSheetTransitionEffect 2)
; 
;    * Slide the window into its new position. Use with TransitionWindow
;    * and Move or Resize transition actions. Available in Mac OS X, and
;    * in CarbonLib 1.5 and later.
;    

(defconstant $kWindowSlideTransitionEffect 3)
; 
;    * Fade the window into or out of visibility. Use with the Show or
;    * Hide transition actions. Available in Mac OS X 10.3 and later.
;    

(defconstant $kWindowFadeTransitionEffect 4)
; 
;    * Use the Genie effect that the Dock uses to minimize or maximize a
;    * window to show or hide the window. Use with the Show or Hide
;    * transition actions. Available in Mac OS X 10.3 and later.
;    

(defconstant $kWindowGenieTransitionEffect 5)
; 
;  *  WindowTransitionAction
;  *  
;  *  Summary:
;  *    Modifications to window state that are provided by
;  *    TransitionWindow
;  

(def-mactype :WindowTransitionAction (find-mactype ':UInt32))
; 
;    * Shows the window. Use with the Zoom, Sheet, Fade, or Genie
;    * transition effects. For the Zoom, Sheet, and Genie effects, the
;    * inRect parameter is the global coordinates from which to start the
;    * animation; if inRect is NULL, the animation begins at the center
;    * of the window. The Fade effect does not use the inRect parameter.
;    

(defconstant $kWindowShowTransitionAction 1)
; 
;    * Hides the window. Use with the Zoom, Sheet, Fade, or Genie
;    * transition effects. For the Zoom, Sheet, and Genie effects, the
;    * inRect parameter is the global coordinates at which to end the
;    * animation; if inRect is NULL, the animation ends at the center of
;    * the window. The Fade effect does not use the inRect parameter.
;    

(defconstant $kWindowHideTransitionAction 2)
; 
;    * Moves the window. Use with the Slide transition effect. The inRect
;    * parameter is the global coordinates of the window's new structure
;    * bounds; inRect must be non-NULL. Available in Mac OS X, and in
;    * CarbonLib 1.5 and later.
;    

(defconstant $kWindowMoveTransitionAction 3)
; 
;    * Resizes the window. Use with the Slide transition effect. The
;    * inRect parameter is the global coordinates of the window's new
;    * structure bounds; inRect must be non-NULL. Available in Mac OS X,
;    * and in CarbonLib 1.5 and later.
;    

(defconstant $kWindowResizeTransitionAction 4)
; 
;  *  TransitionWindow()
;  *  
;  *  Summary:
;  *    Shows, hides, moves, or resizes a window with appropriate
;  *    animation and sound.
;  *  
;  *  Discussion:
;  *    In Mac OS X 10.3 and later, this API sends
;  *    kEventWindowTransitionStarted and kEventWindowTransitionCompleted
;  *    Carbon events to the transitioning window at the start and end of
;  *    the transition.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window on which to act.
;  *    
;  *    inEffect:
;  *      The type of visual effect to use. TransitionWindow supports the
;  *      Zoom and Slide transition effects. The Slide effect is
;  *      supported on Mac OS X and in CarbonLib 1.5 and later.
;  *    
;  *    inAction:
;  *      The action to take on the window. TransitionWindow supports the
;  *      Show, Hide, Move, and Resize actions. The Move and Resize
;  *      actions are supported on Mac OS X and in CarbonLib 1.5 and
;  *      later.
;  *    
;  *    inRect:
;  *      A screen rect in global coordinates. The interpretation of the
;  *      rect is dependent on the transition action; see the
;  *      documentation for each action for details. May be NULL for some
;  *      transition actions.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_TransitionWindow" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inEffect :UInt32)
    (inAction :UInt32)
    (inRect (:pointer :Rect))                   ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TransitionWindowAndParent()
;  *  
;  *  Summary:
;  *    Shows or hides a window, potentially also moving a second window,
;  *    with appropriate animation and sound.
;  *  
;  *  Discussion:
;  *    In Mac OS X 10.3 and later, this API sends
;  *    kEventWindowTransitionStarted and kEventWindowTransitionCompleted
;  *    Carbon events to the transitioning window at the start and end of
;  *    the transition.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window on which to act.
;  *    
;  *    inParentWindow:
;  *      The window to which the primary window is related.
;  *    
;  *    inEffect:
;  *      The type of visual effect to use. TransitionWindowAndParent
;  *      supports the Sheet transition effect.
;  *    
;  *    inAction:
;  *      The action to take on the window. TransitionWindowAndParent
;  *      supports the Show and Hide actions.
;  *    
;  *    inRect:
;  *      A screen rect in global coordinates. The interpretation of the
;  *      rect is dependent on the transition action; see the
;  *      documentation for each action for details. May be NULL for some
;  *      transition actions.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TransitionWindowAndParent" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inParentWindow (:pointer :OpaqueWindowPtr))
    (inEffect :UInt32)
    (inAction :UInt32)
    (inRect (:pointer :Rect))                   ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TransitionWindowOptions
;  *  
;  *  Summary:
;  *    Extensible parameter block for the TransitionWindowWithOptions
;  *    API.
;  
(defrecord TransitionWindowOptions
                                                ; 
;    * The structure version. You must put 0 in this field.
;    
   (version :UInt32)
                                                ; 
;    * The duration of the fade, in seconds. For use with the Sheet,
;    * Slide, Fade, and Genie transition effects; ignored for other
;    * effects. You may pass 0 to use the default duration. The effect is
;    * not guaranteed to last precisely this long, but should be a close
;    * approximation.
;    
   (duration :double-float)
                                                ; 
;    * For use with kWindowSheetTransitionEffect. This is the parent
;    * window of the sheet.
;    
   (window (:pointer :OpaqueWindowPtr))
                                                ; 
;    * This value will be sent as the kEventParamUserData parameter for
;    * the kEventWindowTransitionStarted and
;    * kEventWindowTransitionCompleted events.
;    
   (userData :pointer)
)

;type name? (%define-record :TransitionWindowOptions (find-record-descriptor ':TransitionWindowOptions))
; 
;  *  TransitionWindowWithOptions()
;  *  
;  *  Summary:
;  *    Transitions a window from one state to another with appropriate
;  *    animation and sound.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window that should be transitioned.
;  *    
;  *    inEffect:
;  *      The type of visual effect to use.
;  *    
;  *    inAction:
;  *      The action to take on the window.
;  *    
;  *    inBounds:
;  *      A screen rect in global coordinates. The interpretation of the
;  *      rect is dependent on the transition action; see the
;  *      documentation for each action for details. May be NULL for some
;  *      transition actions.
;  *    
;  *    inAsync:
;  *      Whether the transition should run synchronously or
;  *      asynchronously. If inAsync is true, TransitionWindow will
;  *      return immediately, and the transition will run using an event
;  *      loop timer. You must run your event loop for the transition to
;  *      occur. If inAsync is false, TransitionWindow will block until
;  *      the transition is completed. In either case, the
;  *      kEventWindowTransitionStarted and
;  *      kEventWindowTransitionCompleted Carbon events will be sent to
;  *      the transitioning window at the start and end of the transition.
;  *    
;  *    inOptions:
;  *      Extra options that are required for some transitions. This
;  *      parameter may be NULL if the specific transition effect does
;  *      not require extra information.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TransitionWindowWithOptions" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inEffect :UInt32)
    (inAction :UInt32)
    (inBounds (:pointer :HIRECT))               ;  can be NULL 
    (inAsync :Boolean)
    (inOptions (:pointer :TransitionWindowOptions));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Positioning                                                                 
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  [Mac]MoveWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacMoveWindow MoveWindow

; #endif


(deftrap-inline "_MoveWindow" 
   ((window (:pointer :OpaqueWindowPtr))
    (hGlobal :SInt16)
    (vGlobal :SInt16)
    (front :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SizeWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SizeWindow" 
   ((window (:pointer :OpaqueWindowPtr))
    (w :SInt16)
    (h :SInt16)
    (fUpdate :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  Note: bBox can only be NULL when linking to CarbonLib 1.0 forward 
; 
;  *  GrowWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GrowWindow" 
   ((window (:pointer :OpaqueWindowPtr))
    (startPt :Point)
    (bBox (:pointer :Rect))                     ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  DragWindow()
;  *  
;  *  Summary:
;  *    Allows the user to drag a window to a different position.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window to drag.
;  *    
;  *    startPt:
;  *      The point in global coordinates where the mouse was clicked on
;  *      the window.
;  *    
;  *    boundsRect:
;  *      A rect in global coordinates outside of which the window cannot
;  *      move. May be NULL in CarbonLib and Mac OS X, to indicate that
;  *      there are no restrictions on window movement. This parameter is
;  *      ignored by CarbonLib and Mac OS X 10.0 through 10.2; it is
;  *      obeyed in Mac OS X 10.3 and later.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DragWindow" 
   ((window (:pointer :OpaqueWindowPtr))
    (startPt :Point)
    (boundsRect (:pointer :Rect))               ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ZoomWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ZoomWindow" 
   ((window (:pointer :OpaqueWindowPtr))
    (partCode :SInt16)
    (front :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Collapsing/Expanding                                                        
; ——————————————————————————————————————————————————————————————————————————————————————
;  Routines available from Mac OS 8.0 (Appearance 1.0) forward
; 
;  *  IsWindowCollapsable()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_IsWindowCollapsable" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  IsWindowCollapsed()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_IsWindowCollapsed" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  CollapseWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_CollapseWindow" 
   ((window (:pointer :OpaqueWindowPtr))
    (collapse :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CollapseAllWindows()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_CollapseAllWindows" 
   ((collapse :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Routines available on Mac OS X
; 
;  *  CreateQDContextForCollapsedWindowDockTile()
;  *  
;  *  Discussion:
;  *    Creates and returns a CGrafPtr for a collapsed window's tile in
;  *    the dock. You can use this port to draw into your window's dock
;  *    tile with Quickdraw. You **MUST** call
;  *    ReleaseQDContextForCollapsedWindowDockTile and NOT DisposePort
;  *    when using this API, as it maintains more state than just the
;  *    port. If you call DisposePort, you may leak system resources.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to create the dock tile port for. If this window is
;  *      not collapsed, an error is returned.
;  *    
;  *    outContext:
;  *      The Quickdraw port for you to use to draw into. If you wish to
;  *      use CoreGraphics (Quartz) drawing, call CreateCGContextForPort
;  *      with this port to obtain a CGContext.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateQDContextForCollapsedWindowDockTile" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outContext (:pointer :CGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ReleaseQDContextForCollapsedWindowDockTile()
;  *  
;  *  Discussion:
;  *    Releases a port and other state created by the
;  *    CreateQDContextForCollapsedWindowDockTile API. You MUST call this
;  *    instead of DisposePort directly, or you may leak system resources.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window you created the port for. If this window is not
;  *      collapsed, an error is returned.
;  *    
;  *    inContext:
;  *      The Quickdraw context to dispose.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ReleaseQDContextForCollapsedWindowDockTile" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inContext (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  UpdateCollapsedWindowDockTile()
;  *  
;  *  Discussion:
;  *    Automatically updates the image of a particular window in the
;  *    dock to the current contents of the window. Use this for periodic
;  *    updates, etc. Do not use this for animation purposes, if you want
;  *    animation, use the above create/release drawing context APIs.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to update the dock tile for. If this window is not
;  *      collapsed, an error is returned.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_UpdateCollapsedWindowDockTile" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetWindowDockTileMenu()
;  *  
;  *  Summary:
;  *    Sets the menu that is displayed by a window's dock tile.
;  *  
;  *  Discussion:
;  *    When a window's dock tile menu is right-clicked or
;  *    control-clicked, the Dock will always automatically display a
;  *    menu containing a Close menu item that closes the window. If the
;  *    application wants to add other additional menu items, it can use
;  *    the SetWindowDockTileMenu API to provide those items. The items
;  *    in the specified menu will be combined with the standard items
;  *    provided by the Dock.
;  *    
;  *    Before the menu is actually displayed, it will receive
;  *    kEventMenuPopulate, kEventMenuOpening, and kEventMenuEnableItems
;  *    Carbon events, so any event handlers for these events may update
;  *    the menu appropriately for the current state of the
;  *    application.
;  *    
;  *    The application should set a command ID for each menu item in the
;  *    dock tile menu, and when that item is chosen, a
;  *    kEventCommandProcess Carbon event containing the item's command
;  *    ID will be sent to the window's event target (and from there to
;  *    the application, if the window does not handle the
;  *    event).
;  *    
;  *    This API increments the refcount of the specified menu.
;  *    
;  *    The toolbox provides a default handler for the
;  *    kEventWindowGetDockTileMenu event that returns the menu specified
;  *    by the SetWindowDockTileMenu API.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window for which to set the dock tile menu.
;  *    
;  *    inMenu:
;  *      The menu to display, or NULL to remove the current dock tile
;  *      menu.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowDockTileMenu" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inMenu (:pointer :OpaqueMenuRef))          ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowDockTileMenu()
;  *  
;  *  Summary:
;  *    Returns the menu that is displayed by a window's dock tile.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Result:
;  *    The application's dock tile menu, or NULL if none.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowDockTileMenu" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueMenuRef)
() )
; 
;    Routines available from Mac OS 8.5 forward
;    or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
; 
; 
;  *  GetWindowBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowBounds" 
   ((window (:pointer :OpaqueWindowPtr))
    (regionCode :UInt16)
    (globalBounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetWindowResizeLimits()
;  *  
;  *  Summary:
;  *    Sets the minimum and maximum content sizes for a window.
;  *  
;  *  Discussion:
;  *    The minimum and maximum sizes are obeyed by ResizeWindow and
;  *    GrowWindow. The default Carbon event handler installed for all
;  *    windows will return these sizes in response to
;  *    kEventWindowGetMinimumSize and kEventWindowGetMaximumSize events.
;  *    When a window is first created, its minimum and maximum sizes are
;  *    set to reasonable values (which may change from one system
;  *    release to the next).
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose minimum and maximum sizes to set.
;  *    
;  *    inMinLimits:
;  *      The new minimum size for the content region of the window. Pass
;  *      NULL if you don't want to set a minimum size.
;  *    
;  *    inMaxLimits:
;  *      The new maximum size for the content region of the window. Pass
;  *      NULL if you don't want to set a maximum size.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowResizeLimits" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inMinLimits (:pointer :HISIZE))            ;  can be NULL 
    (inMaxLimits (:pointer :HISIZE))            ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowResizeLimits()
;  *  
;  *  Summary:
;  *    Returns the minimum and maximum content sizes for a window.
;  *  
;  *  Discussion:
;  *    GetWindowResizeLimits returns the minimum and maximum sizes that
;  *    were set by SetWindowResizeLimits. Note that it does not send
;  *    kEventWindowGetMinimumSize or kEventWindowGetMaximumSize Carbon
;  *    events to get these sizes; it simply retrieves the sizes from the
;  *    WindowRef. It is entirely possible (and quite likely) that a
;  *    given window will have event handlers for the
;  *    kEventWindowGetMinimum/MaximumSize events that will modify or
;  *    override the sizes in the WindowRef; therefore, to accurately
;  *    determine the desired minimum and maximum sizes, you should send
;  *    kEventWindowGetMinimum/MaximumSize Carbon events rather than
;  *    using this API.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose minimum and maximum sizes to retrieve.
;  *    
;  *    outMinLimits:
;  *      On exit, contains the minimum size of the window's content
;  *      region. Pass NULL if you don't want this information.
;  *    
;  *    outMaxLimits:
;  *      On exit, contains the maximum size of the window's content
;  *      region. Pass NULL if you don't want this information.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowResizeLimits" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outMinLimits (:pointer :HISIZE))           ;  can be NULL 
    (outMaxLimits (:pointer :HISIZE))           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  ResizeWindow()
;  *  
;  *  Summary:
;  *    Handles all user interaction while a window is being resized.
;  *  
;  *  Discussion:
;  *    The ResizeWindow function moves either an outline of the window's
;  *    edges (on Mac OS 9.x and earlier) or the actual window (on Mac OS
;  *    X) around the screen, following the user’s cursor movements, and
;  *    handles all user interaction until the mouse button is released.
;  *    Unlike the GrowWindow API, there is no need to follow this call
;  *    with a call to the function SizeWindow, because once the mouse
;  *    button is released, ResizeWindow resizes the window if the user
;  *    has changed the window size. Once the resizing is complete,
;  *    ResizeWindow draws the window in the new size. Your application
;  *    should call the ResizeWindow function instead of the earlier
;  *    Window Manager APIs SizeWindow and GrowWindow. Some windows may
;  *    allow themselves to be resized from any corner or edge, not just
;  *    the bottom right, and as a result, when the user resizes the
;  *    window, the window may move on the screen and not merely change
;  *    size. ResizeWindow informs your application of the new window
;  *    bounds, so that your application can respond to any changes in
;  *    the window’s position.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to be resized.
;  *    
;  *    inStartPoint:
;  *      The point, in global coordinates, at which the original
;  *      mouse-down occurred.
;  *    
;  *    inSizeConstraints:
;  *      The limits on the vertical and horizontal measurements of the
;  *      content rectangle, in pixels. Although this parameter is typed
;  *      as a Rect, the four numbers in the structure represent limits,
;  *      not screen coordinates. The top, left, bottom, and right fields
;  *      of the structure specify the minimum vertical measurement
;  *      (top), the minimum horizontal measurement (left), the maximum
;  *      vertical measurement (bottom), and the maximum horizontal
;  *      measurement (right). The minimum dimensions should be large
;  *      enough to allow a manageable rectangle; 64 pixels on a side is
;  *      typical. The maximum dimensions can be no greater than 32,767.
;  *      You can pass NULL to allow the user to resize the window to any
;  *      size that is contained onscreen.
;  *    
;  *    outNewContentRect:
;  *      On exit, the structure contains the new dimensions of the
;  *      window’s content region, in global coordinates. On Mac OS 9.x
;  *      and earlier, you must pass a non-NULL value in this parameter;
;  *      in Carbon, you may pass NULL if you do not need the window’s
;  *      new dimensions.
;  *  
;  *  Result:
;  *    Returns true if the window changed size, or false if not.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_ResizeWindow" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inStartPoint :Point)
    (inSizeConstraints (:pointer :Rect))        ;  can be NULL 
    (outNewContentRect (:pointer :Rect))        ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    Routines available from Mac OS 8.5 forward,
;    or from Mac OS 8.1 forward when linking to CarbonLib 1.0.2 forward
; 
; 
;  *  SetWindowBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_SetWindowBounds" 
   ((window (:pointer :OpaqueWindowPtr))
    (regionCode :UInt16)
    (globalBounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RepositionWindow()
;  *  
;  *  Summary:
;  *    Positions a window according in one of the standard window
;  *    locations.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window to position.
;  *    
;  *    parentWindow:
;  *      For some positioning methods, the new location for the
;  *      positioned window will be calculated based on the parent
;  *      window’s position. On Mac OS X 10.3 and later, some positioning
;  *      methods allow this parameter to be the same as the window
;  *      parameter; CarbonLib and earlier versions of Mac OS X require
;  *      that it be different from the window parameter. See the
;  *      WindowPositionMethod documentation for details on which methods
;  *      allow the parent to be the same as the positioned window.
;  *    
;  *    method:
;  *      The window positioning method. This should be one of the
;  *      WindowPositionMethod constants.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_RepositionWindow" 
   ((window (:pointer :OpaqueWindowPtr))
    (parentWindow (:pointer :OpaqueWindowPtr))
    (method :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MoveWindowStructure()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_MoveWindowStructure" 
   ((window (:pointer :OpaqueWindowPtr))
    (hGlobal :SInt16)
    (vGlobal :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    Routines available from Mac OS 8.5 forward,
;    or from Mac OS 8.6 forward when linking to CarbonLib 1.1 forward
; 
;  Routines available from Mac OS 8.5 forward
; 
;  *  IsWindowInStandardState()
;  *  
;  *  Summary:
;  *    Determines whether a window is currently zoomed in to the user
;  *    state or zoomed out to the standard state.
;  *  
;  *  Discussion:
;  *    IsWindowInStandardState compares the window’s current dimensions
;  *    to those given by the inIdealSize parameter to determine if the
;  *    window is currently in its standard (zoomed-out) state. Your
;  *    application may use IsWindowInStandardState to decide whether a
;  *    user’s click of the zoom box is a request to zoom in to the user
;  *    state or out to the standard state. Your application may also use
;  *    IsWindowInStandardState to determine the size and position of the
;  *    standard state that the Window Manager would calculate for a
;  *    window, given a specified ideal size; this value is returned in
;  *    the outIdealStandardState parameter.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window for which to determine the zoom state.
;  *    
;  *    inIdealSize:
;  *      The ideal width and height of the window’s content region,
;  *      regardless of the actual screen device dimensions. If you set
;  *      idealSize to NULL, IsWindowInStandardState examines the
;  *      dimensions stored in the stdState field of the WStateData
;  *      structure attached to the window.
;  *    
;  *    outIdealStandardState:
;  *      On exit, contains the global coordinates for the content region
;  *      of the window in its standard state, based on the data supplied
;  *      in the inIdealSize parameter. You may pass NULL if you do not
;  *      need this information.
;  *  
;  *  Result:
;  *    Returns true if the window is currently in its standard
;  *    (zoomed-out) state, or false if the window is a non-zoomed-out
;  *    state.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_IsWindowInStandardState" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inIdealSize (:pointer :Point))             ;  can be NULL 
    (outIdealStandardState (:pointer :Rect))    ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  ZoomWindowIdeal()
;  *  
;  *  Summary:
;  *    Zooms a window in accordance with human interface guidelines.
;  *  
;  *  Discussion:
;  *    Applications should use the ZoomWindowIdeal API instead of the
;  *    older ZoomWindow API. When your application calls
;  *    ZoomWindowIdeal, it automatically conforms to the human interface
;  *    guidelines for determining a window’s standard state: the window
;  *    is moved as little as possible when switching between user and
;  *    standard states, the window is zoomed to the screen that contains
;  *    the largest portion of the window, and the window is positioned
;  *    in its zoomed-out size to avoid the Dock on Mac OS X. The
;  *    ZoomWindowIdeal API calculates a window’s ideal standard state
;  *    and updates a window’s ideal user state independently of the
;  *    WStateData structure. Previously, the window definition function
;  *    was responsible for updating the user state, but because it
;  *    relies upon the WStateData structure, the window definition
;  *    function is unaware of the ideal standard state and can no longer
;  *    track the window’s zoom state reliably. The Window Manager
;  *    provides the GetWindowIdealUserState and SetWindowIdealUserState
;  *    APIs to access a window's current ideal user state, previously
;  *    recorded by ZoomWindowIdeal.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to be zoomed.
;  *    
;  *    inPartCode:
;  *      The direction of the zoom, either inZoomIn or inZoomOut. The
;  *      value passed in this parameter should generally be determined
;  *      by calling IsWindowInStandardState; if IsWindowInStandardState
;  *      returns true, pass inZoomIn, otherwise pass inZoomOut.
;  *    
;  *    ioIdealSize:
;  *      When you specify inZoomIn in the inPartCode parameter, this
;  *      parameter is unused on entry; you pass a pointer to a Point
;  *      structure, but do not fill the structure with data. On exit,
;  *      the Point contains the new height and width of the window’s
;  *      content region, and ZoomWindowIdeal restores the previous ideal
;  *      user state. When you specify inZoomOut in the inPartCode
;  *      parameter, you pass the ideal height and width of the window’s
;  *      content region in the Point structure. On return, the Point
;  *      contains the new height and width of the window’s content
;  *      region; ZoomWindowIdeal saves the current user state of the
;  *      window and zooms the window to its ideal size for the standard
;  *      state.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_ZoomWindowIdeal" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inPartCode :SInt16)
    (ioIdealSize (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowIdealUserState()
;  *  
;  *  Summary:
;  *    Returns the bounds of a window’s content region in its user
;  *    (zoomed-in) state.
;  *  
;  *  Discussion:
;  *    Traditionally, the user (zoomed-in) state of a window has been
;  *    stored in the WStateData structure attached to a window. This
;  *    field is updated by the window definition when the user clicks on
;  *    the zoom box and the window definition determines that the window
;  *    is currently not zoomed out. When determining whether the window
;  *    is zoomed out, however, the window definition can only look at
;  *    the standard state stored in the WStateData field. With the
;  *    introduction of the ZoomWindowIdeal API, there is a new basis for
;  *    determining whether a window is zoomed out: the window’s ideal
;  *    size. The window definition does not have access to the window’s
;  *    ideal size, and therefore cannot accurately determine whether a
;  *    window that is zoomed with ZoomWindowIdeal is in its user state
;  *    or standard state; therefore, the user state that the window
;  *    definition stores in the WStateData is also unreliable. The
;  *    ZoomWindowIdeal API therefore stores the window’s user state
;  *    before zooming out in a new location, which is accessed using the
;  *    GetWindowIdealUserState API. The GetWindowIdealUserState API
;  *    returns the window’s user state most recently recorded by
;  *    ZoomWindowIdeal.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose ideal user state you wish to retrieve.
;  *    
;  *    outUserState:
;  *      On exit, contains the global coordinates of the window’s
;  *      content region when zoomed in. On Mac OS X 10.1 and earlier,
;  *      and CarbonLib 1.5 and earlier, the window’s ideal user state is
;  *      an empty rect with coordinates (0,0,0,0) if the window has
;  *      never been zoomed out; you should check for an empty rect and
;  *      use GetWindowBounds with the kWindowContentRgn selector to
;  *      determine the window’s current content region. On later
;  *      versions of Mac OS X and CarbonLib, GetWindowIdealUserState
;  *      automatically returns the window’s current content bounds if
;  *      the window has not yet been zoomed.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowIdealUserState" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outUserState (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetWindowIdealUserState()
;  *  
;  *  Summary:
;  *    Sets the bounds of a window’s content region in its user
;  *    (zoomed-in) state.
;  *  
;  *  Discussion:
;  *    The window’s ideal user state is used by the ZoomWindowIdeal API
;  *    when zooming in. The ideal user state is ignored by the
;  *    ZoomWindow API.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose ideal user state to set.
;  *    
;  *    inUserState:
;  *      The global coordinates of the window’s content region in its
;  *      ideal user state.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_SetWindowIdealUserState" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inUserState (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Routines available in CarbonLib 1.1 and later
; 
;  *  GetWindowGreatestAreaDevice()
;  *  
;  *  Summary:
;  *    Returns the graphics device with the greatest area of
;  *    intersection with a specified window region.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to compare against.
;  *    
;  *    inRegion:
;  *      The window region to compare against.
;  *    
;  *    outGreatestDevice:
;  *      On exit, the graphics device with the greatest intersection.
;  *      May be NULL.
;  *    
;  *    outGreatestDeviceRect:
;  *      On exit, the bounds of the graphics device with the greatest
;  *      intersection. May be NULL. If the device with the greatest
;  *      intersection also contains the menu bar, the device rect will
;  *      exclude the menu bar area.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowGreatestAreaDevice" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inRegion :UInt16)
    (outGreatestDevice (:pointer :GDHANDLE))    ;  can be NULL 
    (outGreatestDeviceRect (:pointer :Rect))    ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  WindowConstrainOptions
;  *  
;  

(def-mactype :WindowConstrainOptions (find-mactype ':UInt32))
; 
;    * The window may be resized if necessary to make it fit onscreen.
;    

(defconstant $kWindowConstrainMayResize 1)
; 
;    * The window will be moved even if it doesn't fit entirely onscreen.
;    

(defconstant $kWindowConstrainMoveRegardlessOfFit 2)
; 
;    * Allow partial intersection of the specified window region with the
;    * screen, instead of requiring total intersection.
;    

(defconstant $kWindowConstrainAllowPartial 4)
; 
;    * Only calculate the new window bounds; don't actually move the
;    * window.
;    

(defconstant $kWindowConstrainCalcOnly 8)
; 
;    * Use TransitionWindow with kWindowSlideTransitionEffect to move
;    * windows onscreen. Available in Mac OS X 10.2.
;    

(defconstant $kWindowConstrainUseTransitionWindow 16)
; 
;    * The most common options: don't resize the window, move the window
;    * regardless of fit to the screen, require total intersection of the
;    * specified window region with the screen, and do actually move the
;    * window.
;    

(defconstant $kWindowConstrainStandardOptions 2)
; 
;  *  ConstrainWindowToScreen()
;  *  
;  *  Summary:
;  *    Moves and resizes a window so that it's contained entirely on a
;  *    single screen.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindowRef:
;  *      The window to constrain.
;  *    
;  *    inRegionCode:
;  *      The window region to constrain.
;  *    
;  *    inOptions:
;  *      Flags controlling how the window is constrained.
;  *    
;  *    inScreenRect:
;  *      A rectangle, in global coordinates, in which to constrain the
;  *      window. May be NULL. If NULL, the window is constrained to the
;  *      screen with the greatest intersection with the specified window
;  *      region.
;  *    
;  *    outStructure:
;  *      On exit, contains the new structure bounds of the window, in
;  *      global coordinates. May be NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ConstrainWindowToScreen" 
   ((inWindowRef (:pointer :OpaqueWindowPtr))
    (inRegionCode :UInt16)
    (inOptions :UInt32)
    (inScreenRect (:pointer :Rect))             ;  can be NULL 
    (outStructure (:pointer :Rect))             ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetAvailableWindowPositioningBounds()
;  *  
;  *  Summary:
;  *    Returns the available window positioning bounds on the given
;  *    screen (i.e., the screen rect minus the MenuBar and Dock if
;  *    located on that screen).
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDevice:
;  *      The device for which to find the available bounds.
;  *    
;  *    outAvailableRect:
;  *      On exit, contains the available bounds for the given device.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetAvailableWindowPositioningBounds" 
   ((inDevice (:Handle :GDEVICE))
    (outAvailableRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetAvailableWindowPositioningRegion()
;  *  
;  *  Summary:
;  *    Returns the available window positioning region on the given
;  *    screen (i.e., the screen rect minus the MenuBar and Dock if
;  *    located on that screen).
;  *  
;  *  Discussion:
;  *    GetAvailableWindowPositionRegion differs from
;  *    GetAvailableWindowPositioningBounds in that the Bounds API
;  *    removes the entire area that may theoretically be covered by the
;  *    Dock, even if the the Dock does not currently reach from edge to
;  *    edge of the device on which it is positioned. The Region API
;  *    includes the area at the sides of the Dock that is not covered by
;  *    the Dock in the available region.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDevice:
;  *      The device for which to find the available bounds.
;  *    
;  *    ioRgn:
;  *      On entry, contains a preallocated RgnHandle. On exit, the
;  *      RgnHandle has been modified to contain the available region for
;  *      the given device.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetAvailableWindowPositioningRegion" 
   ((inDevice (:Handle :GDEVICE))
    (ioRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Visibility                                                                  
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  HideWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HideWindow" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]ShowWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacShowWindow ShowWindow

; #endif


(deftrap-inline "_ShowWindow" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ShowHide()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ShowHide" 
   ((window (:pointer :OpaqueWindowPtr))
    (showFlag :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]IsWindowVisible()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

; #if TARGET_OS_MAC
; #define MacIsWindowVisible IsWindowVisible

; #endif


(deftrap-inline "_IsWindowVisible" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;   ——————————————————————————————————————————————————————————————————————————————————————
;     • Latent window visibility
;   ——————————————————————————————————————————————————————————————————————————————————————
; 
; 
;  *  WindowLatentVisibility
;  *  
;  *  Summary:
;  *    Reasons why a window is currently invisible when ordinarily it
;  *    would be visible.
;  

(def-mactype :WindowLatentVisibility (find-mactype ':UInt32))
; 
;    * Window is a floater and floating windows are hidden
;    

(defconstant $kWindowLatentVisibleFloater 1)
; 
;    * Window has HideOnSuspend and we are suspended
;    

(defconstant $kWindowLatentVisibleSuspend 2)
; 
;    * Window has HideOnFullScreen and we are full-screen
;    

(defconstant $kWindowLatentVisibleFullScreen 4)
; 
;    * Window's process is hidden
;    

(defconstant $kWindowLatentVisibleAppHidden 8)
; 
;    * Window is in an owned group and the owner was collapsed
;    

(defconstant $kWindowLatentVisibleCollapsedOwner 16)
; 
;    * Window is in a HideOnCollapse group and another window in the
;    * group was collapsed
;    

(defconstant $kWindowLatentVisibleCollapsedGroup 32)
; 
;  *  IsWindowLatentVisible()
;  *  
;  *  Summary:
;  *    Indicates whether a window is visible onscreen and also whether
;  *    it is latently visible but not currently onscreen.
;  *  
;  *  Discussion:
;  *    All windows are either onscreen or offscreen. A window that is
;  *    offscreen may still be latently visible; this occurs, for
;  *    example, when a floating window is hidden as an application is
;  *    suspended. The floating window is not visible onscreen, but it is
;  *    latently visible and is only hidden due to the suspended state of
;  *    the application; when the application becomes active again, the
;  *    floating window will be placed back onscreen.
;  *    IsWindowLatentVisible may be used to determine both the window's
;  *    onscreen/offscreen status and its latent visibility (if the
;  *    window is offscreen).
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose visibility to return.
;  *    
;  *    outLatentVisible:
;  *      If the window is onscreen, the latent visibility is zero. If
;  *      the window is offscreen, this parameter is used to return the
;  *      latent visibility flags of the window. If any of the flags are
;  *      set, then the window is latently visible.
;  *  
;  *  Result:
;  *    Indicates whether the window is currently onscreen.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsWindowLatentVisible" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outLatentVisible (:pointer :WINDOWLATENTVISIBILITY));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;     • Sheets
;     
;     Sheets are a new user interface object in Mac OS X. A sheet is a modal alert or dialog,
;     but unlike a traditional alert or dialog window (which is visually separate from the
;     frontmost document window), a sheet appears to be attached to its parent window; it
;     moves and z-orders simultaneously with its parent. Furthermore, sheets on Mac OS X
;     use a new type of modality called window modality. A traditional alert or dialog is
;     app-modal; it prevents user interaction with all other windows in the current application.
;     A sheet is window-modal; it only prevents user interaction with its parent window, and
;     events continue to flow to other windows in the application.
;     
;     • Sheet Event Handling
;     
;     Implementing a sheet window in your application generally requires some modifications
;     to your event-handling code. A traditional app-modal window is implemented using a modal
;     event loop; your application starts a new event loop (either by processing events itself,
;     or by calling ModalDialog), which does not return back to your application's main event
;     loop until the app-modal window has closed.
;     
;     Starting a new event loop doesn't work with sheets, because typically the modal event loop
;     will only handle events destined for the sheet, and not events for other windows, but
;     a sheet only blocks events for its parent window, and your application must still handle
;     events for the rest of its windows as normal. Therefore, you will usually not use a modal
;     event loop to handle events in a sheet. Rather, you will show the sheet window, and then
;     return directly back to your main event loop. The Carbon Event Manager automatically 
;     prevents events from reaching the sheet's parent window; events in your application's
;     other windows are still returned to you via WaitNextEvent or your application's Carbon
;     event handlers, where you can process them as normal.
;     
;     You have several choices for handling events in the sheet itself. A sheet is, at the most
;     basic level, simply another window in your application, and you can use any of the standard
;     event-handling APIs to receive events in the sheet. For example, you can:
;     
;         -   receive events in the sheet via WaitNextEvent, and handle them directly in your
;             main event loop
;             
;         -   create the sheet using Dialog Manager APIs, and use IsDialogEvent and DialogSelect
;             to handle events in the sheet
;             
;         -   install Carbon event handlers on the sheet, and respond to events in your handlers
;     
;     Which approach you choose is up to you.
;     
;     • Sheets in CarbonLib
;     
;     The sheet window class, sheet WDEF procIDs, and ShowSheetWindow, HideSheetWindow, and
;     GetSheetWindowParent APIs are implemented in CarbonLib starting with version 1.3. However,
;     since Mac OS 8 and 9 do not traditionally support a window-modal user interface, sheet
;     windows are displayed as app-modal windows by CarbonLib. From your application's perspective,
;     event handling for a sheet in CarbonLib is the same as event handling for a sheet on X;
;     ShowSheetWindow still returns immediately, and your application should still return back
;     to its main event loop and be prepared to handle events in other windows. On CarbonLib,
;     your application will simply never receive any user input in any of your other windows;
;     since the sheet has application modality, the Carbon Event Manager will discard events
;     in any windows other than the sheet.
;     
;     • Creating a Sheet
;     
;     A sheet is just a normal window with a special window class: kSheetWindowClass or
;     kSheetAlertWindowClass. As such, it can be created in any of the ways you might create
;     a window: NewWindow, NewCWindow, CreateNewWindow, GetNewWindow, GetNewCWindow, 
;     CreateWindowFromCollection, CreateWindowFromResource, CreateWindowFromNib, NewDialog,
;     NewColorDialog, NewFeaturesDialog, or GetNewDialog.
;     
;     The Window Manager defines two window classes and two WDEF procIDs for sheets:
;         
;         -   kSheetWindowClass and kSheetAlertWindowClass
;         -   kWindowSheetProc and kWindowSheetAlertProc
;         
;     The window classes may be used with CreateNewWindow, CreateWindowFromCollection, and
;     CreateWindowFromResource; the WDEF procIDs may be used with NewWindow, NewCWindow, NewDialog,
;     NewColorDialog, NewFeaturesDialog, and in 'WDEF' and 'DLOG' resources.
;     
;     Mac OS X 10.0 only supports kSheetWindowClass and kWindowSheetProc;
;     it does not support kSheetAlertWindowClass or kWindowSheetAlertProc. The latter window
;     class and procID were added in CarbonLib 1.3 and Mac OS X 10.1. A new window class and
;     procID were necessary for CarbonLib support because
;     sheets can be used for both alerts ("Do you want to save changes before closing this
;     window?") and dialogs (a Navigation Services PutFile dialog). On Mac OS X, sheet windows
;     have the same appearance when used for either an alert or a dialog, but on Mac OS 8 and 9,
;     alert windows have a different appearance from dialog windows. Two separate window classes
;     are necessary for CarbonLib to know whether to display a sheet using a movable alert or a
;     movable dialog window. Therefore, it is recommended that you use kSheetAlertWindowClass when
;     creating a sheet window that will be used to display an alert, although this is not required.
;     
;     • Displaying a Sheet
;     
;     A sheet is made visible by calling the ShowSheetWindow API. This API shows the sheet,
;     using whatever visual effects are appropriate for the platform, and then returns immediately.
;     On Mac OS X, it creates a window group and places the sheet and its parent window into the
;     group; it also marks the sheet as window-modal. On CarbonLib, it marks the sheet as app-modal
;     but does not create a window group.
;     
;     On Mac OS X, before the sheet window is actually made visible, ShowSheetWindow sends a 
;     kEventWindowDrawContent event to the sheet window, asking it to draw its content into the
;     window's offscreen buffer. The sheet must handle this event, or its content area will be
;     blank after the sheet becomes visible.
;     
;     In some cases, this handler is automatically provided for you:
;     
;         -   If you create your sheet window using the Dialog Manager, the Dialog Manager
;             automatically installs a handler for this event that calls DrawDialog, so you
;             don't need to install the handler yourself.
;             
;         -   If you install the standard Carbon window event handler on your sheet window
;             (using kWindowStandardHandlerAttribute or InstallStandardEventHandler), the
;             standard handler automatically handles this event and calls DrawControls.
;             
;     Typically, your event handling code (whether it uses WaitNextEvent, the Dialog Manager,
;     or Carbon event handlers) will receive and respond to events in the sheet until the
;     user does something that should cause the sheet to close. This might be clicking in an
;     OK or Cancel button, for example. At that time, your event handling code must call either
;     HideSheetWindow or DetachSheetWindow. The sheet window will hide, but will not be destroyed,
;     so you can use it again later if you want.
;     
;     • Closing a sheet
;     
;     A sheet is normally hidden by calling the HideSheetWindow API. HideSheetWindow provides the
;     visual effects of zooming the sheet back into the parent window's title bar and moving the
;     parent window back to its original position. In Mac OS X 10.3 and later, the DetachSheetWindow
;     API is also available. DetachSheetWindow ungroups the sheet from its parent, releases the
;     retain count acquired by ShowSheetWindow on the parent window, and removes all event handlers
;     installed by ShowSheetWindow, but does not hide the sheet window; an application would typically
;     call DetachSheetWindow and then HideWindow to hide the sheet window without the sheet closing
;     animation. This may be useful if, for example, the sheet were being used to ask if changes to
;     a modified document should be saved; if the user chooses "Don’t Save", then the application
;     could use DetachSheetWindow and then hide both the sheet and the document immediately, so that
;     the document closes as quickly as possible without taking time for the closing animation.
;     The Navigation Services Save Changes dialog does this automatically.
;     
;     You _must_ call either HideSheetWindow or DetachSheetWindow before destroying a sheet that has
;     been shown with ShowSheetWindow. You may not simply dispose of a sheet window without first using
;     Hide or DetachSheetWindow; doing so will leave an extra refcount on the parent window, and will
;     leave the parent window still embedded in the sheet window group.
;     
;     • Sheet Transparency
;     
;     Sheets should be transparent so that the user can see some of the document content behind
;     the sheet and remember the context in which the sheet was displayed. In Mac OS X 10.1, 
;     a sheet is made transparent by using the kThemeBrushSheetBackgroundTransparent constant for
;     the sheet window’s theme background brush. In Mac OS X 10.2 and later, sheets are only
;     transparent if this brush is used and if the sheet window uses compositing mode (enabled by
;     setting the kWindowCompositingAttribute window attribute when the sheet window is created).
; 
; 
;  *  ShowSheetWindow()
;  *  
;  *  Summary:
;  *    Shows a sheet window using appropriate visual effects.
;  *  
;  *  Discussion:
;  *    ShowSheetWindow is implemented in both CarbonLib 1.3 and Mac OS
;  *    X. Since Mac OS 9 does not use a window-modal user interface for
;  *    alerts and dialogs, ShowSheetWindow in CarbonLib does not bind
;  *    the sheet to the parent window in the same way that it does on
;  *    Mac OS X; instead, it shows the sheet like a standard
;  *    movable-modal dialog window. Sheet windows must use the window
;  *    classes kSheetWindowClass or kSheetAlertWindowClass to get the
;  *    right appearance on both platforms. 
;  *    
;  *    Note that ShowSheetWindow will increment the retain count of the
;  *    parent window. The retain count is decremented by HideSheetWindow
;  *    and DetachSheetWindow. You must call one of those APIs before
;  *    destroying the sheet window. 
;  *    
;  *    On Mac OS X, ShowSheetWindow sets the modality of the sheet
;  *    window to kWindowModalityWindowModal.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inSheet:
;  *      The sheet window to show.
;  *    
;  *    inParentWindow:
;  *      The sheet's parent window.
;  *  
;  *  Result:
;  *    An operating system result code. ShowSheetWindow checks for the
;  *    following error conditions, and returns paramErr if any occur:
;  *    the sheet window must have a window class of kSheetWindowClass or
;  *    kSheetAlertWindowClass; the sheet and parent windows must not be
;  *    the same window; the sheet must not have a parent window already;
;  *    and the parent window must not already be the target of a sheet.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ShowSheetWindow" 
   ((inSheet (:pointer :OpaqueWindowPtr))
    (inParentWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HideSheetWindow()
;  *  
;  *  Summary:
;  *    Hides a sheet window using appropriate visual effects.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inSheet:
;  *      The sheet window to hide.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HideSheetWindow" 
   ((inSheet (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DetachSheetWindow()
;  *  
;  *  Summary:
;  *    Detaches a sheet window from its parent window without affecting
;  *    the visibility or position of the sheet or its parent.
;  *  
;  *  Discussion:
;  *    This API may be useful if you want to hide a sheet window without
;  *    an animation effect. To do that, use DetachSheetWindow to detach
;  *    the sheet from the parent, and then use HideWindow to hide the
;  *    sheet, or DisposeWindow to destroy the sheet.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inSheet:
;  *      The sheet to detach.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DetachSheetWindow" 
   ((inSheet (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  GetSheetWindowParent()
;  *  
;  *  Summary:
;  *    Returns the parent window of a sheet.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inSheet:
;  *      The sheet window whose parent to retrieve.
;  *    
;  *    outParentWindow:
;  *      On exit, contains the parent window of the sheet.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetSheetWindowParent" 
   ((inSheet (:pointer :OpaqueWindowPtr))
    (outParentWindow (:pointer :WindowRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;     • Drawers
;     
;     Drawers are supported in Carbon by Mac OS X 10.2 and later. To create and use a drawer:
;     
;         -   Create a window using kDrawerWindowClass. You must also use compositing mode with
;             drawers; this mode is enabled by passing kWindowCompositingAttribute to CreateNewWindow.
;             
;         -   Either install the standard window event handler on the drawer window, or use
;             your own Carbon event or WaitNextEvent code to handle user interaction with the
;             drawer. If you do not use the standard window event handler, you should call
;             ResizeWindow in response to clicks on the grow region of the drawer if you want
;             the drawer to be resizable.
;             
;         -   Set the drawer's parent window with the SetDrawerParent function. The parent is
;             the window on which the drawer will open.
;             
;         -   Optionally, install a Carbon event handler on the drawer or the drawer's parent
;             window for the kEventWindowDrawerOpening/Opened/Closing/Closed events, to be notified
;             when the drawer has started or finished opening or closing.
;         
;         -   Optionally, set the drawer's preferred edge on the parent window with the
;             SetDrawerPreferredEdge function. If you do not set a preferred edge, the drawer
;             opens on the parent's left side on a left-to-right system, or on the parent's right
;             side on a right-to-left system.
;             
;         -   Optionally, set the drawer's offsets with the SetDrawerOffsets function. The offsets
;             control the amount of inset between the edge of the parent's content area and the edge
;             of the drawer's structure. If you do not set any offsets, the drawer's edges are flush
;             with the edges of the parent's content.
;             
;         -   Optionally, set the drawer's minimum and maximum sizes with the SetWindowResizeLimits
;             function. Or, install a Carbon event handler on the drawer to handle the kEventWindow-
;             GetMinimumSize and kEventWindowGetMaximumSize events. The drawer's minimum and maximum
;             sizes control how small or large it will resize together with the parent. If you do not
;             set resize limits, the drawer will be capable of resizing to default small and large
;             limits.
;         
;         -   Call ToggleDrawer to open or close the drawer, or use OpenDrawer or CloseDrawer if
;             you require more control over how the drawer opens or closes.
; 
; 
;  *  Summary:
;  *    Indicates the parent window edge on which a drawer will be shown.
;  
; 
;    * This constant is typically used with the OpenDrawer API; it
;    * indicates that the drawer should be opened on whatever edge of the
;    * parent window has previously been set as the drawer's preferred
;    * edge.
;    

(defconstant $kWindowEdgeDefault 0)
; 
;    * The drawer should open on the top edge of the parent window.
;    

(defconstant $kWindowEdgeTop 1)
; 
;    * The drawer should open on the left edge of the parent window.
;    

(defconstant $kWindowEdgeLeft 2)
; 
;    * The drawer should open on the bottom edge of the parent window.
;    

(defconstant $kWindowEdgeBottom 4)
; 
;    * The drawer should open on the right edge of the parent window.
;    

(defconstant $kWindowEdgeRight 8)
; 
;  *  Summary:
;  *    Indicates the current state of a drawer window.
;  
; 
;    * The drawer is opening, but is not yet fully open.
;    

(defconstant $kWindowDrawerOpening 1)
; 
;    * The drawer is fully open.
;    

(defconstant $kWindowDrawerOpen 2)
; 
;    * The drawer is closing, but is not yet fully closed.
;    

(defconstant $kWindowDrawerClosing 3)
; 
;    * The drawer is fully closed.
;    

(defconstant $kWindowDrawerClosed 4)

(def-mactype :WindowDrawerState (find-mactype ':UInt32))
; 
;  *  GetDrawerPreferredEdge()
;  *  
;  *  Summary:
;  *    Returns the preferred parent window edge of a drawer.
;  *  
;  *  Discussion:
;  *    Drawers start out with a preferred parent window edge of
;  *    kWindowEdgeDefault. On left-to-right systems, the default edge is
;  *    the left edge of the parent window; on right-to-left systems, the
;  *    default edge is the right edge. You can set the preferred edge
;  *    with SetDrawerPreferredEdge. If there's not enough room on the
;  *    preferred edge, the drawer will automatically switch to the
;  *    opposite edge.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawerWindow:
;  *      The drawer window whose preferred edge to retrieve.
;  *  
;  *  Result:
;  *    The preferred edge of the drawer window.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDrawerPreferredEdge" 
   ((inDrawerWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )
; 
;  *  SetDrawerPreferredEdge()
;  *  
;  *  Summary:
;  *    Sets the preferred parent window edge of a drawer.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawerWindow:
;  *      The drawer window whose preferred edge to set.
;  *    
;  *    inEdge:
;  *      The preferred edge of the drawer window. Note that although the
;  *      WindowEdge enumeration has values appropriate for a bitfield,
;  *      the current implementation does not support receiving more than
;  *      one edge bit in this parameter. You can also pass
;  *      kWindowEdgeDefault to allow the Window Manager to pick an edge.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDrawerPreferredEdge" 
   ((inDrawerWindow (:pointer :OpaqueWindowPtr))
    (inEdge :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  GetDrawerCurrentEdge()
;  *  
;  *  Summary:
;  *    Returns the current parent window edge on which a drawer is
;  *    displayed.
;  *  
;  *  Discussion:
;  *    If the drawer window is currently visible, this API returns the
;  *    parent window edge on which the drawer is displayed. If the
;  *    drawer is not visible, this API determines on which edge of the
;  *    parent window the drawer should be displayed, given the current
;  *    size of the drawer, position of the parent, and preferred edge
;  *    for the drawer.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawerWindow:
;  *      The drawer window whose current edge to retrieve.
;  *  
;  *  Result:
;  *    The current edge of the drawer window.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDrawerCurrentEdge" 
   ((inDrawerWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )
; 
;  *  GetDrawerState()
;  *  
;  *  Summary:
;  *    Returns the current state of a drawer: opening, open, closing, or
;  *    closed.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawerWindow:
;  *      The drawer window whose state to retrieve.
;  *  
;  *  Result:
;  *    The current state of the drawer window.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDrawerState" 
   ((inDrawerWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )
; 
;  *  GetDrawerParent()
;  *  
;  *  Summary:
;  *    Returns the parent window of a drawer.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawerWindow:
;  *      The drawer window whose parent window to retrieve.
;  *  
;  *  Result:
;  *    The drawer's parent window, or NULL if the drawer has no assigned
;  *    parent.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDrawerParent" 
   ((inDrawerWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  SetDrawerParent()
;  *  
;  *  Summary:
;  *    Sets the parent window of a drawer.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawerWindow:
;  *      The drawer window whose parent window to set.
;  *    
;  *    inParent:
;  *      The drawer's new parent window, or NULL if the drawer should
;  *      have no parent.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDrawerParent" 
   ((inDrawerWindow (:pointer :OpaqueWindowPtr))
    (inParent (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  kWindowOffsetUnchanged
;  *  
;  *  Discussion:
;  *    Pass this value to SetDrawerOffsets to indicate that an existing
;  *    offset should not be changed.
;  
(defconstant $kWindowOffsetUnchanged -1.0)
; #define kWindowOffsetUnchanged          ((float)(-1.0))
; 
;  *  SetDrawerOffsets()
;  *  
;  *  Summary:
;  *    Sets the offsets from the beginning and end of the parent window
;  *    to the beginning and end of the drawer window.
;  *  
;  *  Discussion:
;  *    The drawer offsets control the positioning of the drawer relative
;  *    to its parent window. When a drawer is first created, its offsets
;  *    are zero. When a drawer is positioned, it is initially given a
;  *    height or width equal to the height or width of the content area
;  *    of the parent to which it is attached. If a drawer is opening on
;  *    the left side of its parent, for example, the drawer's height
;  *    will be the height of the parent's content area. In this case,
;  *    the top side of the drawer window is called the leading edge of
;  *    the drawer, and the bottom side of the drawer window is called
;  *    the trailing edge of the drawer. The drawer's size is then
;  *    adjusted by the leading and trailing offsets. The leading edge of
;  *    the drawer is moved inward by an amount equal to the leading
;  *    offset, and the trailing edge is moved inward by an amount equal
;  *    to the trailing offset. For example, if the leading and trailing
;  *    offsets are five and fifteen, then the top edge of a left-opening
;  *    drawer will be five pixels inside the top edge of the parent
;  *    window's content area, and the bottom edge of the drawer will be
;  *    fifteen pixels inside the bottom edge of the parent's content
;  *    area.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawerWindow:
;  *      The drawer window whose offsets to change.
;  *    
;  *    inLeadingOffset:
;  *      The new leading offset, in pixels. Pass kWindowOffsetUnchanged
;  *      if you don't want to change the leading offset.
;  *    
;  *    inTrailingOffset:
;  *      The new trailing offset, in pixels. Pass kWindowOffsetUnchanged
;  *      if you don't want to change the trailing offset.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDrawerOffsets" 
   ((inDrawerWindow (:pointer :OpaqueWindowPtr))
    (inLeadingOffset :single-float)
    (inTrailingOffset :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  GetDrawerOffsets()
;  *  
;  *  Summary:
;  *    Returns the offsets from the beginning and end of the parent
;  *    window to the beginning and end of the drawer window.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawerWindow:
;  *      The drawer window whose offsets to retrieve.
;  *    
;  *    outLeadingOffset:
;  *      On exit, contains the drawer's leading offset. Pass NULL if you
;  *      don't need this information returned.
;  *    
;  *    outTrailingOffset:
;  *      On exit, contains the drawer's trailing offset. Pass NULL if
;  *      you don't need this information returned.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDrawerOffsets" 
   ((inDrawerWindow (:pointer :OpaqueWindowPtr))
    (outLeadingOffset (:pointer :float))        ;  can be NULL 
    (outTrailingOffset (:pointer :float))       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  ToggleDrawer()
;  *  
;  *  Summary:
;  *    Toggles a drawer from open to closed, or vice versa.
;  *  
;  *  Discussion:
;  *    ToggleDrawer opens the drawer if it is closed, opening, or
;  *    closing. If the drawer is open, it closes the drawer.
;  *    
;  *    ToggleDrawer attemps to open the drawer on its preferred edge,
;  *    but if there is not enough room on that edge, it will try the
;  *    opposite edge instead. If there is insufficient room on either
;  *    edge, the drawer will open on the preferred edge but may extend
;  *    offscreen, under the Dock, or under the menubar.
;  *    
;  *    The opening or closing of the drawer is performed asynchronously;
;  *    ToggleDrawer installs an event loop timer that opens or closes
;  *    the drawer after ToggleDrawer returns to the caller. Therefore,
;  *    the caller must be running its event loop for the drawer to open
;  *    or close. To open or close the drawer synchronously, use the
;  *    OpenDrawer or CloseDrawer APIs.
;  *    
;  *    ToggleDrawer retains the drawer window while the drawer is
;  *    opening or closing, and releases it when the drawer is fully
;  *    opened or closed.
;  *    
;  *    ToggleDrawer sends the kEventWindowDrawerOpening,
;  *    kEventWindowDrawerOpened, kEventWindowDrawerClosing, and
;  *    kEventWindowDrawerClosed events as the drawer opens or closes.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawerWindow:
;  *      The drawer window to open or close.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ToggleDrawer" 
   ((inDrawerWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  OpenDrawer()
;  *  
;  *  Summary:
;  *    Opens a drawer on a specified parent window edge.
;  *  
;  *  Discussion:
;  *    OpenDrawer may open the drawer either synchronously or
;  *    asynchronously, depending on the value of the inAsync parameter.
;  *    If inAsync is true, OpenDrawer installs an event loop timer that
;  *    opens the drawer after OpenDrawer returns to the caller;
;  *    therefore, the caller must be running its event loop for the
;  *    drawer to open. If inAsync is false, OpenDrawer opens the drawer
;  *    completely before returning to the caller.
;  *    
;  *    OpenDrawer retains the drawer window while the drawer is opening,
;  *    and releases it when the drawer is fully open.
;  *    
;  *    OpenDrawer sends the kEventWindowDrawerOpening event to the
;  *    drawer, the drawer's parent, and the application before opening
;  *    the drawer. If an event handler for this event returns
;  *    userCanceledErr, OpenDrawer will return immediately without
;  *    opening the drawer. OpenDrawer sends the kEventWindowDrawerOpened
;  *    event to the drawer, the drawer's parent, and the application
;  *    after the drawer has finished opening.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawerWindow:
;  *      The drawer window to open.
;  *    
;  *    inEdge:
;  *      The parent window edge on which to open the drawer. Pass
;  *      kWindowEdgeDefault to use the drawer's preferred edge. If there
;  *      is not enough room on the preferred edge, OpenDrawer will try
;  *      the opposite edge instead. If there is insufficient room on
;  *      either edge, the drawer will open on the preferred edge but may
;  *      extend offscreen, under the Dock, or under the menubar.
;  *    
;  *    inAsync:
;  *      Whether to open the drawer synchronously (the drawer is
;  *      entirely opened before the function call returns) or
;  *      asynchronously (the drawer opens using an event loop timer
;  *      after the function call returns).
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OpenDrawer" 
   ((inDrawerWindow (:pointer :OpaqueWindowPtr))
    (inEdge :UInt32)
    (inAsync :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  CloseDrawer()
;  *  
;  *  Summary:
;  *    Closes a drawer.
;  *  
;  *  Discussion:
;  *    CloseDrawer may close the drawer either synchronously or
;  *    asynchronously, depending on the value of the inAsync parameter.
;  *    If inAsync is true, CloseDrawer installs an event loop timer that
;  *    closes the drawer after CloseDrawer returns to the caller;
;  *    therefore, the caller must be running its event loop for the
;  *    drawer to close. If inAsync is false, CloseDrawer closes the
;  *    drawer completely before returning to the caller.
;  *    
;  *    CloseDrawer retains the drawer window while the drawer is
;  *    closing, and releases it when the drawer is fully closed.
;  *    
;  *    CloseDrawer sends the kEventWindowDrawerClosing event to the
;  *    drawer, the drawer's parent, and the application before closing
;  *    the drawer. If an event handler for this event returns
;  *    userCanceledErr, CloseDrawer will return immediately without
;  *    closing the drawer. CloseDrawer sends the
;  *    kEventWindowDrawerClosed event to the drawer, the drawer's
;  *    parent, and the application after the drawer has finished closing.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawerWindow:
;  *      The drawer window to close.
;  *    
;  *    inAsync:
;  *      Whether to close the drawer synchronously (the drawer is
;  *      entirely closed before the function call returns) or
;  *      asynchronously (the drawer closes using an event loop timer
;  *      after the function call returns).
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CloseDrawer" 
   ((inDrawerWindow (:pointer :OpaqueWindowPtr))
    (inAsync :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Disabling Screen Redraw                                                            
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;    disable and enable screen updates for changes to the current application’s windows
;    (OS X only)
; 
; 
;  *  DisableScreenUpdates()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisableScreenUpdates" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  EnableScreenUpdates()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_EnableScreenUpdates" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Toolbars                                                                    
; ——————————————————————————————————————————————————————————————————————————————————————
; #define _SetWindowToolbar SetWindowToolbar
; 
;  *  SetWindowToolbar()
;  *  
;  *  Discussion:
;  *    Sets the toolbar for a window. If any other toolbar is currently
;  *    bound to the window, it is released. This API does NOT add the
;  *    toolbar button to the window, your application must set the
;  *    attribute itself.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to add the toolbar to.
;  *    
;  *    inToolbar:
;  *      The toolbar to add.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowToolbar" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inToolbar (:pointer :OpaqueHIObjectRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; #define _GetWindowToolbar GetWindowToolbar
; 
;  *  GetWindowToolbar()
;  *  
;  *  Discussion:
;  *    Gets the toolbar of a window, if any.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to add the toolbar to.
;  *    
;  *    outToolbar:
;  *      The toolbar. You do not own the toolbar reference returned by
;  *      this function. Do not release it! It is possible for the
;  *      toolbar returned to be NULL, indicating there is no toolbar
;  *      associated with this window. ••• NOTE: May need to change the
;  *      release strategy here.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowToolbar" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outToolbar (:pointer :HITOOLBARREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; #define _ShowHideWindowToolbar ShowHideWindowToolbar
; 
;  *  ShowHideWindowToolbar()
;  *  
;  *  Discussion:
;  *    Shows or hides a window's toolbar. Optionally, you can ask for
;  *    the transition to be animated or not. Typically, you would not
;  *    need to call this other than to set up your window accordingly.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to show or hide the toolbar for.
;  *    
;  *    inShow:
;  *      Pass true to show the toolbar, false to hide it.
;  *    
;  *    inAnimate:
;  *      Pass true to animate the transition, false to do it quickly and
;  *      without fanfare.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ShowHideWindowToolbar" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inShow :Boolean)
    (inAnimate :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; #define _IsWindowToolbarVisible IsWindowToolbarVisible
; 
;  *  IsWindowToolbarVisible()
;  *  
;  *  Discussion:
;  *    Returns whether the toolbar (if any) attached to a window is
;  *    visible. If the window has no toolbar, false is returned.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window test the toolbar visiblity for.
;  *  
;  *  Result:
;  *    A boolean result indicating whether the toolbar is visible (true)
;  *    or not (false).
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsWindowToolbarVisible" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Boolean
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Transparency                                                                
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  SetWindowAlpha()
;  *  
;  *  Discussion:
;  *    Alters the overall alpha of a window, making the entire window
;  *    (including window frame) either more or less transparent. The
;  *    alpha is expressed as a floating point value from 0.0 (completely
;  *    transparent) to 1.0 (completely opaque).
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose alpha to modify.
;  *    
;  *    inAlpha:
;  *      The new alpha value.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetWindowAlpha" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inAlpha :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowAlpha()
;  *  
;  *  Discussion:
;  *    Returns the current overall alpha value for a window. The alpha
;  *    is expressed as a floating point value from 0.0 (completely
;  *    transparent) to 1.0 (completely opaque).
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose alpha to return.
;  *    
;  *    outAlpha:
;  *      On exit, contains the window's current alpha value.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowAlpha" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outAlpha (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Properties                                                                  
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;    Routines available from Mac OS 8.5 forward
;    or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
; 
; 
;  *  GetWindowProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowProperty" 
   ((window (:pointer :OpaqueWindowPtr))
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (bufferSize :UInt32)
    (actualSize (:pointer :UInt32))             ;  can be NULL 
    (propertyBuffer :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetWindowPropertySize()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_GetWindowPropertySize" 
   ((window (:pointer :OpaqueWindowPtr))
    (creator :OSType)
    (tag :OSType)
    (size (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetWindowProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_SetWindowProperty" 
   ((window (:pointer :OpaqueWindowPtr))
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (propertySize :UInt32)
    (propertyBuffer :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RemoveWindowProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in WindowsLib 8.5 and later
;  

(deftrap-inline "_RemoveWindowProperty" 
   ((window (:pointer :OpaqueWindowPtr))
    (propertyCreator :OSType)
    (propertyTag :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward

(defconstant $kWindowPropertyPersistent 1)      ;  whether this property gets saved when flattening the window 

; 
;  *  GetWindowPropertyAttributes()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowPropertyAttributes" 
   ((window (:pointer :OpaqueWindowPtr))
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (attributes (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ChangeWindowPropertyAttributes()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ChangeWindowPropertyAttributes" 
   ((window (:pointer :OpaqueWindowPtr))
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (attributesToSet :UInt32)
    (attributesToClear :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Utilities                                                                          
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  PinRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PinRect" 
   ((theRect (:pointer :Rect))
    (thePt :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetGrayRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetGrayRgn" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Part Tracking                                                               
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  TrackBox()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TrackBox" 
   ((window (:pointer :OpaqueWindowPtr))
    (thePt :Point)
    (partCode :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  TrackGoAway()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TrackGoAway" 
   ((window (:pointer :OpaqueWindowPtr))
    (thePt :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Region Dragging                                                                    
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  DragGrayRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DragGrayRgn" 
   ((theRgn (:pointer :OpaqueRgnHandle))
    (startPt :Point)
    (limitRect (:pointer :Rect))
    (slopRect (:pointer :Rect))
    (axis :SInt16)
    (actionProc (:pointer :OpaqueDragGrayRgnProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  DragTheRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DragTheRgn" 
   ((theRgn (:pointer :OpaqueRgnHandle))
    (startPt :Point)
    (limitRect (:pointer :Rect))
    (slopRect (:pointer :Rect))
    (axis :SInt16)
    (actionProc (:pointer :OpaqueDragGrayRgnProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • GetAuxWin                                                                         
;                                                                                       
;   GetAuxWin is not available in Carbon                                                
; ——————————————————————————————————————————————————————————————————————————————————————

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
; 
;  *  GetAuxWin()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
 |#

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */

; ——————————————————————————————————————————————————————————————————————————————————————
;  • C Glue                                                                             
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  setwtitle()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  trackgoaway()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  findwindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  getwtitle()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  growwindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  newwindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  newcwindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  pinrect()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  trackbox()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  draggrayrgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  dragwindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Window Accessors                                                                   
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  GetWindowGoAwayFlag()
;  *  
;  *  Discussion:
;  *    use GetWindowAttributes in Carbon
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  
; 
;  *  GetWindowSpareFlag()
;  *  
;  *  Discussion:
;  *    use GetWindowAttributes in Carbon
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  
; 
;  *  GetWindowList()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
;  

(deftrap-inline "_GetWindowList" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  GetWindowPort()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_GetWindowPort" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueGrafPtr)
() )
; 
;  *  GetWindowStructurePort()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetWindowStructurePort" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :OpaqueGrafPtr)
() )
; 
;  *  GetWindowKind()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_GetWindowKind" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  IsWindowHilited()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_IsWindowHilited" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  IsWindowUpdatePending()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_IsWindowUpdatePending" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  [Mac]GetNextWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later or as macro/inline
;  

; #if TARGET_OS_MAC
; #define MacGetNextWindow GetNextWindow

; #endif


(deftrap-inline "_GetNextWindow" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  GetPreviousWindow()
;  *  
;  *  Summary:
;  *    Returns the window above a given window in the window list.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window above this window is returned.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetPreviousWindow" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  GetWindowStandardState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_GetWindowStandardState" 
   ((window (:pointer :OpaqueWindowPtr))
    (rect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Rect)
() )
; 
;  *  GetWindowUserState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_GetWindowUserState" 
   ((window (:pointer :OpaqueWindowPtr))
    (rect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Rect)
() )
; 
;  *  SetWindowKind()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_SetWindowKind" 
   ((window (:pointer :OpaqueWindowPtr))
    (kind :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetWindowStandardState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_SetWindowStandardState" 
   ((window (:pointer :OpaqueWindowPtr))
    (rect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetWindowUserState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_SetWindowUserState" 
   ((window (:pointer :OpaqueWindowPtr))
    (rect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPortWindowPort()
;  *  
;  *  Discussion:
;  *    set the current QuickDraw port to the port associated with the
;  *    window
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_SetPortWindowPort" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetWindowPortBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_GetWindowPortBounds" 
   ((window (:pointer :OpaqueWindowPtr))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Rect)
() )
; 
;  *  GetWindowFromPort()
;  *  
;  *  Discussion:
;  *    Needed to ‘cast up’ to a WindowRef from a GrafPtr
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_GetWindowFromPort" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
;  old accessors
; 
;  *  GetWindowDataHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  SetWindowDataHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  GetWindowZoomFlag()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  GetWindowStructureRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  GetWindowContentRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  GetWindowUpdateRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  GetWindowTitleWidth()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; ——————————————————————————————————————————————————————————————————————————————————————————————————
;  Obsolete symbolic names                                                                          
; ——————————————————————————————————————————————————————————————————————————————————————————————————

(defconstant $kWindowGroupAttrSelectable 1)
(defconstant $kWindowGroupAttrPositionFixed 2)
(defconstant $kWindowGroupAttrZOrderFixed 4)
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __MACWINDOWS__ */


(provide-interface "MacWindows")