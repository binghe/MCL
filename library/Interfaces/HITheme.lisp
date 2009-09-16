(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:HITheme.h"
; at Sunday July 2,2006 7:24:59 pm.
; 
;      File:       HIToolbox/HITheme.h
;  
;      Contains:   Private interfaces for HITheme
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1994-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __HITHEME__
; #define __HITHEME__
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
; #ifndef __HISHAPE__
#| #|
#include <HIToolboxHIShape.h>
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
;  -------------------------------------------------------------------------- 
;   HIThemeOrientation information                                            
;  -------------------------------------------------------------------------- 
; 
;  
; 
;    * The passed context has an origin at the top left. This is the
;    * default of a context passed to you by HIToolbox.
;    

(defconstant $kHIThemeOrientationNormal 0)
; 
;    * The passed context has an origin at the bottom left. This is the
;    * default for a context you create.
;    

(defconstant $kHIThemeOrientationInverted 1)

(def-mactype :HIThemeOrientation (find-mactype ':UInt32))
;  -------------------------------------------------------------------------- 
;   Splitter types                                                            
;  -------------------------------------------------------------------------- 
; 
;  
; 
;    * Draw the splitter with its normal appearance.
;    

(defconstant $kHIThemeSplitterAdornmentNone 0)
; 
;    * Draw the splitter with its metal appearance.
;    

(defconstant $kHIThemeSplitterAdornmentMetal 1)

(def-mactype :HIThemeSplitterAdornment (find-mactype ':UInt32))
;  -------------------------------------------------------------------------- 
;   Window Grow Box                                                           
;  -------------------------------------------------------------------------- 
; 
;  
; 
;    * The grow box corner for a window that has no scroll bars.
;    

(defconstant $kHIThemeGrowBoxKindNormal 0)
; 
;    * The grow box corner for a window that has no grow box. This sounds
;    * paradoxical, but this type of grow box, formerly known as the
;    * "NoGrowBox" is used to fill in the corner left blank by the
;    * intersection of a horizontal and a vertical scroll bar.
;    

(defconstant $kHIThemeGrowBoxKindNone 1)

(def-mactype :HIThemeGrowBoxKind (find-mactype ':UInt32))
; 
;  
; 
;    * Draw the grow box for normal windows.
;    

(defconstant $kHIThemeGrowBoxSizeNormal 0)
; 
;    * Draw the smaller grow box for utility or floating windows.
;    

(defconstant $kHIThemeGrowBoxSizeSmall 1)

(def-mactype :HIThemeGrowBoxSize (find-mactype ':UInt32))
;  -------------------------------------------------------------------------- 
;   Tab Drawing size                                                          
;  -------------------------------------------------------------------------- 
; 
;  
; 
;    * No tab adornments are to be drawn.
;    

(defconstant $kHIThemeTabAdornmentNone 0)
; 
;    * A focus ring is to be drawn around the tab.
;    
;  to match button focus adornment 

(defconstant $kHIThemeTabAdornmentFocus 4)

(def-mactype :HIThemeTabAdornment (find-mactype ':UInt32))
; 
;  *  Summary:
;  *    These values are similar to kControlSize constants for
;  *    convenience.
;  
; 
;    * The tabs are normal (large) sized.
;    

(defconstant $kHIThemeTabSizeNormal 0)
; 
;    * The tabs are drawn as the small variant.
;    

(defconstant $kHIThemeTabSizeSmall 1)
; 
;    * The tabs are drawn as the mini variant.
;    

(defconstant $kHIThemeTabSizeMini 3)

(def-mactype :HIThemeTabSize (find-mactype ':UInt32))
; 
;  
; 
;    * The group box is drawn with the primary variant.
;    

(defconstant $kHIThemeGroupBoxKindPrimary 0)
; 
;    * The group box is drawn with the secondary variant.
;    

(defconstant $kHIThemeGroupBoxKindSecondary 1)
; 
;    * The group box is drawn with the primary variant. This group box
;    * draws opaque. This does not match the Mac OS X 10.3 appearance
;    * 100%, as the boxes should be transparent, but draws this way for
;    * the sake of compatibility. Please update to use the newer
;    * transparent variant.
;    

(defconstant $kHIThemeGroupBoxKindPrimaryOpaque 3)
; 
;    * The group box is drawn with the secondary variant. This group box
;    * draws opaque. This does not match the Mac OS X 10.3 appearance
;    * 100%, as the boxes should be transparent, but draws this way for
;    * the sake of compatibility. Please update to use the newer
;    * transparent variant.
;    

(defconstant $kHIThemeGroupBoxKindSecondaryOpaque 4)

(def-mactype :HIThemeGroupBoxKind (find-mactype ':UInt32))
; 
;  
; 
;    * A header drawn above window content that has no top border of its
;    * own. (i.e. the same as the status bar in an icon view Finder
;    * window).
;    

(defconstant $kHIThemeHeaderKindWindow 0)
; 
;    * A header drawn above window content that has a top border of its
;    * own. (i.e. the same as the status bar in an list view Finder
;    * window).
;    

(defconstant $kHIThemeHeaderKindList 1)

(def-mactype :HIThemeHeaderKind (find-mactype ':UInt32))
; 
;  
; 
;    * The default sized square text field (like Edit Text).
;    

(defconstant $kHIThemeFrameTextFieldSquare 0)
(defconstant $kHIThemeFrameListBox 1)

(def-mactype :HIThemeFrameKind (find-mactype ':UInt32))
; 
;  
; 
;    * Indicates that a menu title should be drawn in a condensed
;    * appearance. This constant is used in the
;    * HIThemeMenuTitleDrawInfo.attributes field.
;    

(defconstant $kHIThemeMenuTitleDrawCondensed 1)
;  -------------------------------------------------------------------------- 
;   DrawInfo                                                                  
;  -------------------------------------------------------------------------- 
; 
;  *  HIScrollBarTrackInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to scroll bar drawing and measuring
;  *    theme APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIScrollBarTrackInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeTrackEnableState for the scroll bar to be drawn.
;    
   (enableState :UInt8)
                                                ; 
;    * The ThemeTrackPressState for the scroll bar to be drawn.
;    
   (pressState :UInt8)
                                                ; 
;    * The view range size.
;    
   (viewsize :single-float)
)

;type name? (%define-record :HIScrollBarTrackInfo (find-record-descriptor ':HIScrollBarTrackInfo))
; 
;  *  HIThemeTrackDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to track drawing and measuring theme
;  *    APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3, but based on legacy TrackDrawInfo.
;  
(defrecord HIThemeTrackDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)                            ;  current version is 0 
                                                ; 
;    * The ThemeTrackKind of the track being drawn or measured.
;    
   (kind :UInt16)                               ;  what kind of track this info is for 
                                                ; 
;    * An HIRect describing the bounds of the button being drawn or
;    * measured.
;    
   (bounds :CGRect)                             ;  track basis rectangle 
                                                ; 
;    * The minimum allowable value for the track being drawn or measured.
;    
   (min :SInt32)                                ;  min track value 
                                                ; 
;    * The maximum allowable value for the track being drawn or measured.
;    
   (max :SInt32)                                ;  max track value 
                                                ; 
;    * The value for the track being drawn or measured.
;    
   (value :SInt32)                              ;  current thumb value 
                                                ; 
;    * Leave this reserved field set to 0.
;    
   (reserved :UInt32)
                                                ; 
;    * A set of ThemeTrackAttributes for the track to be drawn or
;    * measured.
;    
   (attributes :UInt16)                         ;  various track attributes 
                                                ; 
;    * A ThemeTrackEnableState describing the state of the track to be
;    * drawn or measured.
;    
   (enableState :UInt8)                         ;  enable state 
                                                ; 
;    * Leave this reserved field set to 0.
;    
   (filler1 :UInt8)
   (:variant
   (
   (scrollbar :ScrollBarTrackInfo)
   )
   (
   (slider :SliderTrackInfo)
   )
   (
   (progress :ProgressTrackInfo)
   )
   )
)

;type name? (%define-record :HIThemeTrackDrawInfo (find-record-descriptor ':HIThemeTrackDrawInfo))
; 
;  *  HIThemeAnimationTimeInfo
;  *  
;  *  Summary:
;  *    Time parameters passed to button drawing and measuring theme APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeAnimationTimeInfo
                                                ; 
;    * The CFAbsoluteTime of the beginning of the animation of the
;    * button.  This only applies to buttons that animate -- currently
;    * only kThemePushButton.  All other buttons will ignore this field. 
;    * If there is to be no animation, set this field to 0.
;    
   (start :double-float)
                                                ; 
;    * The CFAbsoluteTime of the current animation frame of the button. 
;    * This only applies to buttons that animate -- currently only
;    * kThemePushButton.  All other buttons will ignore this field.  If
;    * there is to be no animation, set this field to 0.
;    
   (current :double-float)
)

;type name? (%define-record :HIThemeAnimationTimeInfo (find-record-descriptor ':HIThemeAnimationTimeInfo))
; 
;  *  HIThemeAnimationFrameInfo
;  *  
;  *  Summary:
;  *    Frame parameters passed to button drawing and measuring theme
;  *    APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeAnimationFrameInfo
                                                ; 
;    * The index of the frame of the animation to draw. If the index is
;    * greater that the maximum number of animation frames, it will be
;    * modded to calculate which frame to draw.
;    
   (index :UInt32)
)

;type name? (%define-record :HIThemeAnimationFrameInfo (find-record-descriptor ':HIThemeAnimationFrameInfo))
; 
;  *  HIThemeButtonDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to button drawing and measuring theme
;  *    APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeButtonDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState of the button being drawn or measured.
;    
   (state :UInt32)
                                                ; 
;    * A ThemeButtonKind indicating the type of button to be drawn.
;    
   (kind :UInt16)
                                                ; 
;    * The ThemeButtonValue of the button being drawn or measured.
;    
   (value :UInt16)
                                                ; 
;    * The ThemeButtonAdornment(s) with which the button is being drawn
;    * or measured.
;    
   (adornment :UInt16)
   (:variant
   (
   (time :HIThemeAnimationTimeInfo)
   )
   (
   (frame :HIThemeAnimationFrameInfo)
   )
   )
)

;type name? (%define-record :HIThemeButtonDrawInfo (find-record-descriptor ':HIThemeButtonDrawInfo))

(def-mactype :HIThemeButtonDrawInfoPtr (find-mactype '(:pointer :HIThemeButtonDrawInfo)))
; 
;  *  HIThemeSplitterDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to splitter drawing and measuring theme
;  *    APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeSplitterDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState of the splitter being drawn or measured.
;    
   (state :UInt32)
                                                ; 
;    * The HIThemeSplitterAdornments of the splitter being drawn or
;    * measured.
;    
   (adornment :UInt32)
)

;type name? (%define-record :HIThemeSplitterDrawInfo (find-record-descriptor ':HIThemeSplitterDrawInfo))

(def-mactype :HIThemeSplitterDrawInfoPtr (find-mactype '(:pointer :HIThemeSplitterDrawInfo)))
; 
;  *  HIThemeTabDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to tab drawing and measuring theme APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeTabDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * A ThemeTabStyle describing the style of the tab to be drawn.
;    
   (style :UInt16)
                                                ; 
;    * A ThemeTabDirection describing the side on which the tab is being
;    * drawn.
;    
   (direction :UInt16)
                                                ; 
;    * An HIThemeTabSize indicating what size of tab to draw.
;    
   (size :UInt32)
                                                ; 
;    * An HIThemeTabAdornment describing any additional adornments that
;    * are to be drawn on the tab.
;    
   (adornment :UInt32)                          ;  various tab attributes 
)

;type name? (%define-record :HIThemeTabDrawInfo (find-record-descriptor ':HIThemeTabDrawInfo))
; 
;  *  HIThemeMenuDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to menu drawing and measuring theme
;  *    APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeMenuDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * A ThemeMenuType indicating which type of menu is to be drawn.
;    
   (menuType :UInt16)
)

;type name? (%define-record :HIThemeMenuDrawInfo (find-record-descriptor ':HIThemeMenuDrawInfo))

(def-mactype :HIThemeMenuDrawInfoPtr (find-mactype '(:pointer :HIThemeMenuDrawInfo)))
; 
;  *  HIThemeMenuItemDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to menu item drawing and measuring
;  *    theme APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeMenuItemDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * A ThemeMenuItemType indicating what type of menu item is to be
;    * drawn.
;    
   (itemType :UInt16)
                                                ; 
;    * The ThemeMenuState of the menu item to be drawn.
;    
   (state :UInt16)
)

;type name? (%define-record :HIThemeMenuItemDrawInfo (find-record-descriptor ':HIThemeMenuItemDrawInfo))

(def-mactype :HIThemeMenuItemDrawInfoPtr (find-mactype '(:pointer :HIThemeMenuItemDrawInfo)))
; 
;  *  HIThemeFrameDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to frame drawing and measuring theme
;  *    APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeFrameDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The HIThemeFrameKind of the frame to be drawn.
;    
   (kind :UInt32)
                                                ; 
;    * The ThemeDrawState of the frame to be drawn.
;    
   (state :UInt32)
                                                ; 
;    * A Boolean indicating whether the frame is to be drawn with focus
;    * or without.
;    
   (isFocused :Boolean)
)

;type name? (%define-record :HIThemeFrameDrawInfo (find-record-descriptor ':HIThemeFrameDrawInfo))

(def-mactype :HIThemeFrameDrawInfoPtr (find-mactype '(:pointer :HIThemeFrameDrawInfo)))
; 
;  *  HIThemeGroupBoxDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to group box drawing and measuring
;  *    theme APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeGroupBoxDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState for the group box to be drawn.
;    
   (state :UInt32)
                                                ; 
;    * An HIThemeGroupBoxKind indicating which type of group box is to be
;    * drawn.
;    
   (kind :UInt32)
)

;type name? (%define-record :HIThemeGroupBoxDrawInfo (find-record-descriptor ':HIThemeGroupBoxDrawInfo))

(def-mactype :HIThemeGroupBoxDrawInfoPtr (find-mactype '(:pointer :HIThemeGroupBoxDrawInfo)))
; 
;  *  HIThemeGrabberDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to grabber drawing and measuring theme
;  *    APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeGrabberDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState for the grabber to be drawn.
;    
   (state :UInt32)
)

;type name? (%define-record :HIThemeGrabberDrawInfo (find-record-descriptor ':HIThemeGrabberDrawInfo))

(def-mactype :HIThemeGrabberDrawInfoPtr (find-mactype '(:pointer :HIThemeGrabberDrawInfo)))
; 
;  *  HIThemePlacardDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to placard drawing and measuring theme
;  *    APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemePlacardDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState for the placard to be drawn.
;    
   (state :UInt32)
)

;type name? (%define-record :HIThemePlacardDrawInfo (find-record-descriptor ':HIThemePlacardDrawInfo))

(def-mactype :HIThemePlacardDrawInfoPtr (find-mactype '(:pointer :HIThemePlacardDrawInfo)))
; 
;  *  HIThemeHeaderDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to header drawing and measuring theme
;  *    APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeHeaderDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState for the header to be drawn.
;    
   (state :UInt32)
                                                ; 
;    * The HIThemeHeaderKind for the header to be drawn.
;    
   (kind :UInt32)
)

;type name? (%define-record :HIThemeHeaderDrawInfo (find-record-descriptor ':HIThemeHeaderDrawInfo))

(def-mactype :HIThemeHeaderDrawInfoPtr (find-mactype '(:pointer :HIThemeHeaderDrawInfo)))
; 
;  *  HIThemeMenuBarDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to HIThemeDrawMenuBarBackground.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeMenuBarDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeMenuBarState for the menu bar to be drawn.
;    
   (state :UInt16)
                                                ; 
;    * The attributes of the menu bar to be drawn.
;    
   (attributes :UInt32)
)

;type name? (%define-record :HIThemeMenuBarDrawInfo (find-record-descriptor ':HIThemeMenuBarDrawInfo))

(def-mactype :HIThemeMenuBarDrawInfoPtr (find-mactype '(:pointer :HIThemeMenuBarDrawInfo)))
; 
;  *  HIThemeMenuTitleDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to HIThemeDrawMenuTitle.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeMenuTitleDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeMenuState for the menu title to be drawn.
;    
   (state :UInt16)
                                                ; 
;    * The attributes of the menu title to be drawn. Must be either 0 or
;    * kHIThemeMenuTitleDrawCondensed.
;    
   (attributes :UInt32)
                                                ; 
;    * The border space between the menu title rect and the menu title
;    * text when the menu title spacing is being condensed. This field is
;    * only observed by the Appearance Manager when the attributes field
;    * contains kHIThemeMenuTitleDrawCondensed. The valid values for this
;    * field range from the value returned by GetThemeMenuTitleExtra(
;    * &extra, false ) to the value returned by GetThemeMenuTitleExtra(
;    * &extra, true ). You may pass 0 in this field to use the minimum
;    * condensed title extra.
;    
   (condensedTitleExtra :single-float)
)

;type name? (%define-record :HIThemeMenuTitleDrawInfo (find-record-descriptor ':HIThemeMenuTitleDrawInfo))

(def-mactype :HIThemeMenuTitleDrawInfoPtr (find-mactype '(:pointer :HIThemeMenuTitleDrawInfo)))
; 
;  *  HIThemeTabPaneDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to tab pane drawing and measuring theme
;  *    APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeTabPaneDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState for the tab pane to be drawn.
;    
   (state :UInt32)
                                                ; 
;    * A ThemeTabDirection describing on which side of the pane the tabs
;    * will be drawn.
;    
   (direction :UInt16)
                                                ; 
;    * An HIThemeTabSize indicating what size of tab pane to draw.
;    
   (size :UInt32)
)

;type name? (%define-record :HIThemeTabPaneDrawInfo (find-record-descriptor ':HIThemeTabPaneDrawInfo))

(def-mactype :HIThemeTabPaneDrawInfoPtr (find-mactype '(:pointer :HIThemeTabPaneDrawInfo)))
; 
;  *  HIThemeTickMarkDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to tick mark drawing and measuring
;  *    theme APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeTickMarkDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState for the tick mark to be drawn.
;    
   (state :UInt32)
)

;type name? (%define-record :HIThemeTickMarkDrawInfo (find-record-descriptor ':HIThemeTickMarkDrawInfo))

(def-mactype :HIThemeTickMarkDrawInfoPtr (find-mactype '(:pointer :HIThemeTickMarkDrawInfo)))
; 
;  *  HIThemeWindowDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to window drawing and measuring theme
;  *    APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3, but based on legacy ThemeWindowMetrics.
;  
(defrecord HIThemeWindowDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * A ThemeDrawState which describes the state of the window to be
;    * drawn.
;    
   (state :UInt32)
                                                ; 
;    * A ThemeWindowType specifying the type of window to be drawn.
;    
   (windowType :UInt16)
                                                ; 
;    * The ThemeWindowAttributes describing the window to be drawn.
;    
   (attributes :UInt32)
                                                ; 
;    * The height of the title of the window.
;    
   (titleHeight :single-float)
                                                ; 
;    * The width of the title of the window.
;    
   (titleWidth :single-float)
)

;type name? (%define-record :HIThemeWindowDrawInfo (find-record-descriptor ':HIThemeWindowDrawInfo))

(def-mactype :HIThemeWindowDrawInfoPtr (find-mactype '(:pointer :HIThemeWindowDrawInfo)))
; 
;  *  HIThemeWindowWidgetDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to window widget drawing and measuring
;  *    theme APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3, but based on legacy ThemeWindowMetrics.
;  
(defrecord HIThemeWindowWidgetDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * A ThemeDrawState which describes the state of the widget to be
;    * drawn.
;    
   (widgetState :UInt32)
                                                ; 
;    * A ThemeTitleBarWidget specifying the type of window widget to be
;    * drawn.
;    
   (widgetType :UInt16)
                                                ; 
;    * A ThemeDrawState which describes the state of the window for which
;    * the widget is to be drawn.
;    
   (windowState :UInt32)
                                                ; 
;    * A ThemeWindowType specifying the type of window to be drawn.
;    
   (windowType :UInt16)
                                                ; 
;    * The ThemeWindowAttributes describing the window to be drawn.
;    
   (attributes :UInt32)
                                                ; 
;    * The height of the title of the window.
;    
   (titleHeight :single-float)
                                                ; 
;    * The width of the title of the window.
;    
   (titleWidth :single-float)
)

;type name? (%define-record :HIThemeWindowWidgetDrawInfo (find-record-descriptor ':HIThemeWindowWidgetDrawInfo))

(def-mactype :HIThemeWindowWidgetDrawInfoPtr (find-mactype '(:pointer :HIThemeWindowWidgetDrawInfo)))
; 
;  *  HIThemeSeparatorDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to separator drawing and measuring
;  *    theme APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeSeparatorDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState for the separator to be drawn.
;    
   (state :UInt32)
)

;type name? (%define-record :HIThemeSeparatorDrawInfo (find-record-descriptor ':HIThemeSeparatorDrawInfo))

(def-mactype :HIThemeSeparatorDrawInfoPtr (find-mactype '(:pointer :HIThemeSeparatorDrawInfo)))
; 
;  *  HIThemeScrollBarDelimitersDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to separator drawing and measuring
;  *    theme APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeScrollBarDelimitersDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState for the separator to be drawn.
;    
   (state :UInt32)
                                                ; 
;    * A ThemeWindowType specifying the type of window for which to draw
;    * the delimiters.
;    
   (windowType :UInt16)
                                                ; 
;    * The ThemeWindowAttributes of the window for which the scroll bar
;    * delimters are to be drawn.
;    
   (attributes :UInt32)
)

;type name? (%define-record :HIThemeScrollBarDelimitersDrawInfo (find-record-descriptor ':HIThemeScrollBarDelimitersDrawInfo))

(def-mactype :HIThemeScrollBarDelimitersDrawInfoPtr (find-mactype '(:pointer :HIThemeScrollBarDelimitersDrawInfo)))
; 
;  *  HIThemeChasingArrowsDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to chasing arrows drawing and measuring
;  *    theme APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeChasingArrowsDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState for the chasing arrows to be drawn.
;    
   (state :UInt32)
                                                ; 
;    * A UInt32 used to calculate which frame of the chasing arrow
;    * animation is to be drawn.
;    
   (index :UInt32)
)

;type name? (%define-record :HIThemeChasingArrowsDrawInfo (find-record-descriptor ':HIThemeChasingArrowsDrawInfo))

(def-mactype :HIThemeChasingArrowsDrawInfoPtr (find-mactype '(:pointer :HIThemeChasingArrowsDrawInfo)))
; 
;  *  HIThemePopupArrowDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to popup arrow drawing and measuring
;  *    theme APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemePopupArrowDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState for the popup arrow to be drawn.
;    
   (state :UInt32)
                                                ; 
;    * A ThemeArrowOrientation for the orientation of the popup arrow to
;    * be drawn.
;    
   (orientation :UInt16)
                                                ; 
;    * A ThemePopupArrowSize for the size of the popup arrow to be drawn.
;    
   (size :UInt16)
)

;type name? (%define-record :HIThemePopupArrowDrawInfo (find-record-descriptor ':HIThemePopupArrowDrawInfo))

(def-mactype :HIThemePopupArrowDrawInfoPtr (find-mactype '(:pointer :HIThemePopupArrowDrawInfo)))
; 
;  *  HIThemeGrowBoxDrawInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to grow box drawing and measuring theme
;  *    APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3.
;  
(defrecord HIThemeGrowBoxDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState for the grow box to be drawn.
;    
   (state :UInt32)
                                                ; 
;    * A ThemeGrowBoxKind indicating in which kind of grow box to draw.
;    
   (kind :UInt32)
                                                ; 
;    * A ThemeGrowDirection indicating in which direction the window will
;    * grow.
;    
   (direction :UInt16)
                                                ; 
;    * An HIThemeGrowBoxSize describing the size of the grow box to draw.
;    
   (size :UInt32)
)

;type name? (%define-record :HIThemeGrowBoxDrawInfo (find-record-descriptor ':HIThemeGrowBoxDrawInfo))

(def-mactype :HIThemeGrowBoxDrawInfoPtr (find-mactype '(:pointer :HIThemeGrowBoxDrawInfo)))
; 
;  *  HIThemeBackgroundDrawInfo
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3, but based on legacy TrackDrawInfo.
;  
(defrecord HIThemeBackgroundDrawInfo
                                                ; 
;    * The version of this data structure.  Currently, it is always 0.
;    
   (version :UInt32)
                                                ; 
;    * The ThemeDrawState of the background to be drawn. Currently,
;    * HIThemeDrawBackground backgrounds do not have state, so this field
;    * has no meaning. Set it to kThemeStateActive.
;    
   (state :UInt32)
                                                ; 
;    * The ThemeBackgroundKind with which to fill the background.
;    
   (kind :UInt32)
)

;type name? (%define-record :HIThemeBackgroundDrawInfo (find-record-descriptor ':HIThemeBackgroundDrawInfo))

(def-mactype :HIThemeBackgroundDrawInfoPtr (find-mactype '(:pointer :HIThemeBackgroundDrawInfo)))
;  -------------------------------------------------------------------------- 
;   Buttons                                                                   
;  -------------------------------------------------------------------------- 
; 
;  *  HIThemeDrawButton()
;  *  
;  *  Summary:
;  *    Draw a themed button.
;  *  
;  *  Discussion:
;  *    This generic button drawing theme primitive draws not just a push
;  *    button, but all of the kinds of buttons described by
;  *    ThemeButtonKind.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inBounds:
;  *      The HIRect in which to draw.  Note that this API may draw
;  *      outside of its bounds.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeButtonDrawInfo describing the button that will be
;  *      drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *    
;  *    outLabelRect:
;  *      A pointer to an HIRect into which to put the bounds of the
;  *      label rect.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawButton" 
   ((inBounds (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeButtonDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
    (outLabelRect (:pointer :HIRECT))           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetButtonShape()
;  *  
;  *  Summary:
;  *    Get a shape of a themed button.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inBounds:
;  *      The HIRect in which to draw.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeButtonDrawInfo describing the button that will be
;  *      drawn.
;  *    
;  *    outShape:
;  *      A pointer to an HIShapeRef which will be set to the shape of
;  *      the button. Needs to be released by caller.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetButtonShape" 
   ((inBounds (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeButtonDrawInfo))
    (outShape (:pointer :HISHAPEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetButtonContentBounds()
;  *  
;  *  Summary:
;  *    Get the bounds of a themed button's content.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inBounds:
;  *      An HIRect indicating where the button is to be drawn.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeButtonDrawInfo describing the button that will be
;  *      drawn.
;  *    
;  *    outBounds:
;  *      A pointer to an HIRect in which will be returned the rectangle
;  *      of the button content bounds.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetButtonContentBounds" 
   ((inBounds (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeButtonDrawInfo))
    (outBounds (:pointer :HIRECT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetButtonBackgroundBounds()
;  *  
;  *  Summary:
;  *    Get the bounds of the background of a themed button.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inBounds:
;  *      An HIRect indicating where the button is to be drawn.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeButtonDrawInfo describing the button that will be
;  *      drawn.
;  *    
;  *    outBounds:
;  *      A pointer to an HIRect in which will be returned the rectangle
;  *      of the button background bounds.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetButtonBackgroundBounds" 
   ((inBounds (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeButtonDrawInfo))
    (outBounds (:pointer :HIRECT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawChasingArrows()
;  *  
;  *  Summary:
;  *    Draw themed chasing arrows.
;  *  
;  *  Discussion:
;  *    Draw a frame from the chasing arrows animation.  The animation
;  *    frame is based on a modulo value calculated from the index.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inBounds:
;  *      An HIRect indicating where the chasing arrows are to be drawn.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeChasingArrowsDrawInfo describing the chasing arrows
;  *      to be drawn or measured.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawChasingArrows" 
   ((inBounds (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeChasingArrowsDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawPopupArrow()
;  *  
;  *  Summary:
;  *    Draws a themed popup arrow.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inBounds:
;  *      The HIRect in which to draw.
;  *    
;  *    inDrawInfo:
;  *      An HIThemePopupArrowDrawInfo describing the popup arrow to be
;  *      drawn or measured.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawPopupArrow" 
   ((inBounds (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemePopupArrowDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
;  -------------------------------------------------------------------------- 
;   Menus                                                                     
;  -------------------------------------------------------------------------- 
; 
;  *  HIThemeDrawMenuBarBackground()
;  *  
;  *  Summary:
;  *    Draws the menu bar background for a given area.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inBounds:
;  *      The HIRect in which to draw.
;  *    
;  *    inDrawInfo:
;  *      The HIThemeMenuBarDrawInfo of the menu bar to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawMenuBarBackground" 
   ((inBounds (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeMenuBarDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawMenuTitle()
;  *  
;  *  Summary:
;  *    Draws the menu title background for a menu.
;  *  
;  *  Discussion:
;  *    This API draws the background of a menu title. It does not draw
;  *    the menu title text; it is the caller's responsibility to draw
;  *    the text after this API has returned. The text should be drawn
;  *    into the bounds returned in the outLabelRect parameter; the
;  *    caller should ensure that the text is not drawn outside of those
;  *    bounds, either by truncating or clipping the text.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenuBarRect:
;  *      An HIRect indicating the bounds of the whole menu bar for which
;  *      the menu title is to be drawn.
;  *    
;  *    inTitleRect:
;  *      An HIRect for the bounds of the menu title to be drawn.
;  *    
;  *    inDrawInfo:
;  *      The HIThemeMenuTitleDrawInfo of the menu title to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *    
;  *    outLabelRect:
;  *      On exit, contains the bounds in which the menu title text
;  *      should be drawn. May be NULL if you don't need this information.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawMenuTitle" 
   ((inMenuBarRect (:pointer :HIRECT))
    (inTitleRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeMenuTitleDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
    (outLabelRect (:pointer :HIRECT))           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawMenuBackground()
;  *  
;  *  Summary:
;  *    Draws the theme menu background in a rectangle.  This API may
;  *    draw outside of the specified rectangle.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenuRect:
;  *      An HIRect indicating the bounds of the whole menu for which the
;  *      background is to be drawn.
;  *    
;  *    inMenuDrawInfo:
;  *      An HIThemeMenuDrawInfo describing the menu to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawMenuBackground" 
   ((inMenuRect (:pointer :HIRECT))
    (inMenuDrawInfo (:pointer :HIThemeMenuDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawMenuItem()
;  *  
;  *  Summary:
;  *    Draws a themed menu item.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenuRect:
;  *      An HIRect indicating the bounds of the whole menu for which the
;  *      menu item is to be drawn.
;  *    
;  *    inItemRect:
;  *      An HIRect for the bounds of the menu item to be drawn.
;  *    
;  *    inItemDrawInfo:
;  *      An HIThemeMenuItemDrawInfo describing the drawing
;  *      characteristics of the menu item to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *    
;  *    outContentRect:
;  *      An HIRect that will be filled with the rectangle describing
;  *      where the menu item content is to be drawn.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawMenuItem" 
   ((inMenuRect (:pointer :HIRECT))
    (inItemRect (:pointer :HIRECT))
    (inItemDrawInfo (:pointer :HIThemeMenuItemDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
    (outContentRect (:pointer :HIRECT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawMenuSeparator()
;  *  
;  *  Summary:
;  *    Draws a themed menu separator.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenuRect:
;  *      An HIRect indicating the bounds of the whole menu for which the
;  *      menu separator is to be drawn.
;  *    
;  *    inItemRect:
;  *      An HIRect for the bounds of the menu separator to be drawn.
;  *    
;  *    inItemDrawInfo:
;  *      An HIThemeMenuItemDrawInfo describing the drawing
;  *      characteristics of the menu item to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawMenuSeparator" 
   ((inMenuRect (:pointer :HIRECT))
    (inItemRect (:pointer :HIRECT))
    (inItemDrawInfo (:pointer :HIThemeMenuItemDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetMenuBackgroundShape()
;  *  
;  *  Summary:
;  *    Gets the shape of the background for a themed menu.
;  *  
;  *  Discussion:
;  *    This shape can extend outside of the bounds of the specified
;  *    rectangle.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenuRect:
;  *      An HIRect indicating the bounds of the menu for which the menu
;  *      background is to be drawn.
;  *    
;  *    inMenuDrawInfo:
;  *      An HIThemeMenuDrawInfo describing the menu to be measured.
;  *    
;  *    outShape:
;  *      A valid HIShape that will be cleared and filled with the shape
;  *      of the menu background.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetMenuBackgroundShape" 
   ((inMenuRect (:pointer :HIRECT))
    (inMenuDrawInfo (:pointer :HIThemeMenuDrawInfo))
    (outShape (:pointer :HISHAPEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
;  -------------------------------------------------------------------------- 
;   Tabs                                                                      
;  -------------------------------------------------------------------------- 
; 
;  *  HIThemeDrawTabPane()
;  *  
;  *  Summary:
;  *    Draws a themed tab pane.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect in which to draw the pane.
;  *    
;  *    inDrawInfo:
;  *      The HIThemeTabPaneDrawInfo of the tab pane to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawTabPane" 
   ((inRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeTabPaneDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawTab()
;  *  
;  *  Summary:
;  *    Draw a themed tab.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect in which to draw.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeTabDrawInfo describing the tab to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *    
;  *    outLabelRect:
;  *      An HIRect into which to put the bounds of the label rect.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawTab" 
   ((inRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeTabDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
    (outLabelRect (:pointer :HIRECT))           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetTabPaneDrawShape()
;  *  
;  *  Summary:
;  *    Gets the shape of the draw area relative to the full bounds of
;  *    the tab+pane.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect for which to get the shape.
;  *    
;  *    inDirection:
;  *      A ThemeTabDirection describing on which side of the pane the
;  *      tabs will be drawn.
;  *    
;  *    inTabSize:
;  *      An HIThemeTabSize indicating what size of tab pane to draw.
;  *    
;  *    outShape:
;  *      A pointer to an HIShapeRef which will be set to the shape of
;  *      the draw area. Needs to be released by caller.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetTabPaneDrawShape" 
   ((inRect (:pointer :HIRECT))
    (inDirection :UInt16)
    (inTabSize :UInt32)
    (outShape (:pointer :HISHAPEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetTabPaneContentShape()
;  *  
;  *  Summary:
;  *    Gets the shape of the content area relative to the full bounds of
;  *    the tab+pane.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect for which to get the shape.
;  *    
;  *    inDirection:
;  *      A ThemeTabDirection describing on which side of the pane the
;  *      tabs will be drawn.
;  *    
;  *    inTabSize:
;  *      An HIThemeTabSize indicating what size of tab pane to draw.
;  *    
;  *    outShape:
;  *      A pointer to an HIShapeRef which will be set to the shape of
;  *      the draw content. Needs to be released by caller.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetTabPaneContentShape" 
   ((inRect (:pointer :HIRECT))
    (inDirection :UInt16)
    (inTabSize :UInt32)
    (outShape (:pointer :HISHAPEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetTabDrawShape()
;  *  
;  *  Summary:
;  *    Gets the shape of the tab drawing area relative to the full
;  *    bounds of the tab+pane.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect for which to get the shape.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeTabDrawInfo describing the tab that will be drawn.
;  *    
;  *    outShape:
;  *      A pointer to an HIShapeRef which will be set to the shape of
;  *      the tab drawing area. Needs to be released by caller.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetTabDrawShape" 
   ((inRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeTabDrawInfo))
    (outShape (:pointer :HISHAPEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetTabShape()
;  *  
;  *  Summary:
;  *    Gets the shape for a themed tab.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      An HIRect indicating the entire tabs area for which the tab
;  *      shape is to be retrieved.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeTabDrawInfo describing the tab that will be drawn.
;  *    
;  *    outShape:
;  *      A pointer to an HIShapeRef which will be set to the shape of
;  *      the tab. Needs to be released by caller.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetTabShape" 
   ((inRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeTabDrawInfo))
    (outShape (:pointer :HISHAPEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
;  -------------------------------------------------------------------------- 
;   Text                                                                      
;  -------------------------------------------------------------------------- 
; 
;  
; 
;    * Don't truncate the measured or drawn text.
;    

(defconstant $kHIThemeTextTruncationNone 0)
; 
;    * During measure or draw, if the text will not fit within the
;    * available bounds, truncate the text in the middle of the last
;    * visible line.
;    

(defconstant $kHIThemeTextTruncationMiddle 1)
; 
;    * During measure or draw, if the text will not fit within the
;    * available bounds, truncate the text at the end of the last visible
;    * line.
;    

(defconstant $kHIThemeTextTruncationEnd 2)

(def-mactype :HIThemeTextTruncation (find-mactype ':UInt32))
; 
;  
; 
;    * The text will be drawn flush with the left side of the bounding
;    * box.
;    

(defconstant $kHIThemeTextHorizontalFlushLeft 0)
; 
;    * The text will be centered within the bounding box.
;    

(defconstant $kHIThemeTextHorizontalFlushCenter 1)
; 
;    * The text will be drawn flush with the right side of the bounding
;    * box.
;    

(defconstant $kHIThemeTextHorizontalFlushRight 2)

(def-mactype :HIThemeTextHorizontalFlush (find-mactype ':UInt32))
; 
;  
; 
;    * Draw the text vertically flush with the top of the box
;    

(defconstant $kHIThemeTextVerticalFlushTop 0)
; 
;    * Vertically center the text
;    

(defconstant $kHIThemeTextVerticalFlushCenter 1)
; 
;    * Draw the text vertically flush with the bottom of the box
;    

(defconstant $kHIThemeTextVerticalFlushBottom 2)

(def-mactype :HIThemeTextVerticalFlush (find-mactype ':UInt32))
; 
;  

(defconstant $kHIThemeTextBoxOptionNone 0)
(defconstant $kHIThemeTextBoxOptionStronglyVertical 2)

(def-mactype :HIThemeTextBoxOptions (find-mactype ':UInt32))

(defconstant $kHIThemeTextInfoVersionZero 0)
; 
;  *  HIThemeTextInfo
;  *  
;  *  Summary:
;  *    Drawing parameters passed to text drawing and measuring theme
;  *    APIs.
;  *  
;  *  Discussion:
;  *    New in Mac OS X 10.3, this structure is used for measuring and
;  *    drawing text with the HIThemeGetTextDimensions and
;  *    HIThemeDrawTextBox APIs. If truncationPosition is
;  *    kHIThemeTextTruncationNone, the other fields with the truncation
;  *    prefix are ignored.
;  
(defrecord HIThemeTextInfo
                                                ; 
;    * The version of this data structure. Currently, it is always 0.
;    
   (version :UInt32)                            ;  current version is 0 
                                                ; 
;    * The theme draw state in which to draw the string.
;    
   (state :UInt32)
                                                ; 
;    * The font in which to draw the string.
;    
   (fontID :UInt16)
                                                ; 
;    * The horizontal flushness of the text. One of the
;    * kHIThemeTextHorizontalFlush[Left/Center/Right] constants. When
;    * this structure is used for HIThemeGetTextDimensions, this field
;    * has no effect on the returned dimensions. However, providing the
;    * same flushness that will be used with a subsequent draw will
;    * trigger a performance optimization.
;    
   (horizontalFlushness :UInt32)                ;  kHIThemeTextHorizontalFlush[Left/Center/Right] 
                                                ; 
;    * The vertical flushness of the text. One of the
;    * kHIThemeTextVerticalFlush[Top/Center/Bottom] constants. When this
;    * paramblock is used for HIThemeGetTextDimensions, this field has no
;    * effect on the returned dimensions. However, providing the same
;    * flushness that will be used with a subsequent draw will trigger a
;    * performance optimization.
;    
   (verticalFlushness :UInt32)                  ;  kHIThemeTextVerticalFlush[Top/Center/Bottom] 
                                                ; 
;    * Currently, the only option available is for strongly vertical text
;    * with the kThemeTextBoxOptionStronglyVertical option bit.
;    
   (options :UInt32)                            ;  includes kHIThemeTextBoxOptionStronglyVertical 
                                                ; 
;    * Specifies where truncation should occur. If this field is
;    * kHIThemeTruncationNone, no truncation will occur, and all fields
;    * with the truncation prefix will be ignored.
;    
   (truncationPosition :UInt32)                 ;  kHIThemeTextTruncation[None/Middle/End], If none the following field is ignored 
                                                ; 
;    * The maximum number of lines to measure or draw before truncation
;    * occurs. Ignored if truncationPosition is kHIThemeTruncationNone.
;    
   (truncationMaxLines :UInt32)                 ;  the maximum number of lines before truncation occurs 
                                                ; 
;    * On output, if the text has been truncated, this is set to true. If
;    * the text fit completely within the parameters specified and the
;    * text was not truncated, this is set to false.
;    
   (truncationHappened :Boolean)                ;  on output, whether truncation needed to happen 
)

;type name? (%define-record :HIThemeTextInfo (find-record-descriptor ':HIThemeTextInfo))
; 
;  *  HIThemeGetTextDimensions()
;  *  
;  *  Summary:
;  *    Get text dimensions of a string
;  *  
;  *  Discussion:
;  *    This allows you to get various dimension characteristics of a
;  *    string bound to certain criteria that you specify. It allows you
;  *    to get the absolute bounds of a string laid out in a single line,
;  *    or the bounds of a string constrained to a given width.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inString:
;  *      The string to measure.
;  *    
;  *    inWidth:
;  *      The width to constrain the text before wrapping. If inWidth is
;  *      0, the text will not wrap and will be laid out as a single
;  *      line. If inWidth is not 0, the text will wrap at the given
;  *      width and the measurements will be returned from the multi line
;  *      layout.
;  *    
;  *    inTextInfo:
;  *      The HIThemeTextInfo parameter block specifying additional
;  *      options for flushness and truncation. The truncationHappened
;  *      field is the only field that will be written to by this API
;  *      (and the reason for inTextInfo not being const).
;  *    
;  *    outWidth:
;  *      On output, will contain the width of the string. This width may
;  *      be smaller than the constrain inWidth parameter if the text has
;  *      wrapped. It will return the true bounding width of the layout.
;  *      Can be NULL.
;  *    
;  *    outHeight:
;  *      On output, will contain the height of the string. Can be NULL.
;  *    
;  *    outBaseline:
;  *      On output, will contain the baseline of the string. This is the
;  *      delta from the top of the text to the baseline of the first
;  *      line. Can be NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetTextDimensions" 
   ((inString (:pointer :__CFString))
    (inWidth :single-float)
    (inTextInfo (:pointer :HIThemeTextInfo))
    (outWidth (:pointer :float))                ;  can be NULL 
    (outHeight (:pointer :float))               ;  can be NULL 
    (outBaseline (:pointer :float))             ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawTextBox()
;  *  
;  *  Summary:
;  *    Draw the string into the given bounding box
;  *  
;  *  Discussion:
;  *    Draw the string into the bounding box given. You can specify
;  *    options such as truncation and justification as well as
;  *    determining whether the text was truncated when it was drawn.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inString:
;  *      The string to draw.
;  *    
;  *    inBounds:
;  *      The HIRect that bounds where the text is to be drawn
;  *    
;  *    inTextInfo:
;  *      The HIThemeTextInfo parameter block specifying additional
;  *      options for truncation and flushness. You can control the
;  *      number of lines drawn by specifying a truncation of
;  *      kHIThemeTextTruncationMiddle or kHIThemeTextTruncationEnd for
;  *      the truncationPosition field and then specifying a maximum
;  *      number of lines to draw before truncation occurs in the
;  *      truncationMaxLines field. The truncationHappened field is the
;  *      only field that will be written to by this API (and the reason
;  *      for inTextInfo not being const).
;  *    
;  *    inContext:
;  *      The CGContextRef into which to draw the text.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawTextBox" 
   ((inString (:pointer :__CFString))
    (inBounds (:pointer :HIRECT))
    (inTextInfo (:pointer :HIThemeTextInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
;  -------------------------------------------------------------------------- 
;   Tracks                                                                    
;  -------------------------------------------------------------------------- 
; 
;  *  HIThemeDrawTrack()
;  *  
;  *  Summary:
;  *    Draw a themed track item.
;  *  
;  *  Discussion:
;  *    Used to draw any tracked element including sliders and scroll
;  *    bars.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawInfo:
;  *      An HIThemeTrackDrawInfo describing the track that will be drawn.
;  *    
;  *    inGhostRect:
;  *      An HIRect describing the location of the ghost indicator to be
;  *      drawn. Generally, this should be NULL and the control using
;  *      this primitive should support live feeback.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawTrack" 
   ((inDrawInfo (:pointer :HIThemeTrackDrawInfo))
    (inGhostRect (:pointer :HIRECT))            ;  can be NULL 
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawTrackTickMarks()
;  *  
;  *  Summary:
;  *    Draws the tick marks for a slider track.
;  *  
;  *  Discussion:
;  *    This primitive only draws evenly distributed tick marks. 
;  *    Internally, it calls HIThemeDrawTickMark to do the actual tick
;  *    mark drawing, and any custom (non-even distribution) drawing of
;  *    tick marks should be done with HIThemeDrawTickMark.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawInfo:
;  *      An HIThemeTrackDrawInfo describing the track tick marks that
;  *      will be drawn.
;  *    
;  *    inNumTicks:
;  *      A value indicating the number of tick marks to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawTrackTickMarks" 
   ((inDrawInfo (:pointer :HIThemeTrackDrawInfo))
    (inNumTicks :UInt32)
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawTickMark()
;  *  
;  *  Summary:
;  *    Draws a single tick mark.
;  *  
;  *  Discussion:
;  *    This primitive draws a single tick mark and can be used to draw
;  *    custom tick marks that are not easily drawn by
;  *    HIThemeDrawTrackTickMarks, which only draws evenly distributed
;  *    tick marks.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inBounds:
;  *      The HIRect in which to draw.
;  *    
;  *    inDrawInfo:
;  *      The HIThemeTickMarkDrawInfo of the tick mark to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawTickMark" 
   ((inBounds (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeTickMarkDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetTrackThumbShape()
;  *  
;  *  Summary:
;  *    Get the thumb shape of a themed track.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawInfo:
;  *      An HIThemeTrackDrawInfo describing the track to be measured.
;  *    
;  *    outThumbShape:
;  *      A pointer to an HIShapeRef which will be set to the shape of
;  *      the themed track's thumb. Needs to be released by caller.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetTrackThumbShape" 
   ((inDrawInfo (:pointer :HIThemeTrackDrawInfo))
    (outThumbShape (:pointer :HISHAPEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeHitTestTrack()
;  *  
;  *  Summary:
;  *    Hit test the themed track.
;  *  
;  *  Discussion:
;  *    Returns true if the track was hit and fills in outPartHit. 
;  *    Otherwise, returns false.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawInfo:
;  *      An HIThemeTabDrawInfo describing the tab that will be drawn.
;  *    
;  *    inMousePoint:
;  *      An HIPoint which will be location basis for the test.
;  *    
;  *    outPartHit:
;  *      A pointer to a ControlPartCode that will be filled with the
;  *      part hit by the incoming point.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeHitTestTrack" 
   ((inDrawInfo (:pointer :HIThemeTrackDrawInfo))
    (inMousePoint (:pointer :HIPOINT))
    (outPartHit (:pointer :ControlPartCode))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  *  HIThemeGetTrackBounds()
;  *  
;  *  Summary:
;  *    Gets the track bounds of a themed track.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawInfo:
;  *      An HIThemeTrackDrawInfo describing the tab that will be drawn.
;  *    
;  *    outBounds:
;  *      A pointer to an HIRect in which will be returned the rectangle
;  *      of the track bounds.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetTrackBounds" 
   ((inDrawInfo (:pointer :HIThemeTrackDrawInfo))
    (outBounds (:pointer :HIRECT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetTrackPartBounds()
;  *  
;  *  Summary:
;  *    Returns measurements for the bounds of the a track part,
;  *    according to the specifics of that track as specified in the
;  *    incoming draw info record.
;  *  
;  *  Discussion:
;  *    HIThemeGetTrackPartBounds allows you to get the boundaries of
;  *    individual pieces of a track's theme layout.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawInfo:
;  *      An HIThemeTrackDrawInfo describing the track to be measured.
;  *    
;  *    inPartCode:
;  *      A ControlPartCode describing which part to measure.  A list of
;  *      available ControlPartCodes can be retrieved using
;  *      HIThemeGetTrackPartBounds.
;  *    
;  *    outPartBounds:
;  *      The bounds of the specified part relative to the start
;  *      rectangle specified in inDrawInfo.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetTrackPartBounds" 
   ((inDrawInfo (:pointer :HIThemeTrackDrawInfo))
    (inPartCode :SInt16)
    (outPartBounds (:pointer :HIRECT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetTrackParts()
;  *  
;  *  Summary:
;  *    Counts the number of parts that make up a track.  Optionally
;  *    returns an array of ControlPartCodes that describe each of the
;  *    counted parts.
;  *  
;  *  Discussion:
;  *    HIThemeGetTrackParts allows you to count the number of parts that
;  *    make up a track.  This is useful if you need to iterate through
;  *    the parts of a track and get information about them, i.e. using
;  *    HIThemeGetTrackPartBounds.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawInfo:
;  *      An HIThemeTrackDrawInfo describing the track to be measured.
;  *    
;  *    outNumberOfParts:
;  *      A pointer to a UInt32 in which to return the number of counted
;  *      parts.
;  *    
;  *    inMaxParts:
;  *      The maximum number of ControlPartCodes that can be copied into
;  *      the supplied ioPartsBuffer.  This value is ignored if
;  *      ioPartsBuffer is NULL.
;  *    
;  *    ioPartsBuffer:
;  *      An pointer to an array into which HIThemeGetTrackPartBounds
;  *      will copy ControlPartCodes that describe each of the counted
;  *      parts.  This pointer can be NULL if you are just counting parts.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetTrackParts" 
   ((inDrawInfo (:pointer :HIThemeTrackDrawInfo))
    (outNumberOfParts (:pointer :UInt32))
    (inMaxParts :UInt32)
    (ioPartsBuffer (:pointer :ControlPartCode))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetTrackDragRect()
;  *  
;  *  Summary:
;  *    Get the rectangle of the drag area of a themed track.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawInfo:
;  *      An HIThemeTrackDrawInfo describing the track to be measured.
;  *    
;  *    outDragRect:
;  *      A pointer to an HIRect in which will be returned the rectangle
;  *      of the drag area of the track.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetTrackDragRect" 
   ((inDrawInfo (:pointer :HIThemeTrackDrawInfo))
    (outDragRect (:pointer :HIRECT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetTrackThumbPositionFromOffset()
;  *  
;  *  Summary:
;  *    Get the track's relative thumb position based on the offset.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawInfo:
;  *      An HIThemeTrackDrawInfo describing the track to be measured.
;  *    
;  *    inThumbOffset:
;  *      An HIPoint describing the position of the thumb as an offset
;  *      from the track bounds.
;  *    
;  *    outRelativePosition:
;  *      On output, the track-relative position calculated from the
;  *      thumb offset.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetTrackThumbPositionFromOffset" 
   ((inDrawInfo (:pointer :HIThemeTrackDrawInfo))
    (inThumbOffset (:pointer :HIPOINT))
    (outRelativePosition (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetTrackThumbPositionFromBounds()
;  *  
;  *  Summary:
;  *    Get the themed track thumb position from its bounds.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawInfo:
;  *      A pointer to an HIThemeTrackDrawInfo describing the track to be
;  *      measured.
;  *    
;  *    inThumbBounds:
;  *      The bounds of the thumb from which the postion is to be
;  *      calculated.
;  *    
;  *    outRelativePosition:
;  *      On output, the track-relative position calculated from the
;  *      thumb location.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetTrackThumbPositionFromBounds" 
   ((inDrawInfo (:pointer :HIThemeTrackDrawInfo))
    (inThumbBounds (:pointer :HIRECT))
    (outRelativePosition (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetTrackLiveValue()
;  *  
;  *  Summary:
;  *    Get the themed track live value.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrawInfo:
;  *      An HIThemeTrackDrawInfo describing the track to be measured.
;  *    
;  *    inRelativePosition:
;  *      An HIPoint describing the position of the thumb as an offset
;  *      from the track bounds.
;  *    
;  *    outValue:
;  *      On output, the track value as calculated from the relative
;  *      postion of the thumb.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetTrackLiveValue" 
   ((inDrawInfo (:pointer :HIThemeTrackDrawInfo))
    (inRelativePosition :single-float)
    (outValue (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetScrollBarTrackRect()
;  *  
;  *  Summary:
;  *    Gets the rectangle of the tracking area of a themed scroll bar.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inBounds:
;  *      An HIRect indicating the area in which the scroll bar will be
;  *      drawn.
;  *    
;  *    inTrackInfo:
;  *      An HIScrollBarTrackInfo for the scroll bar to be drawn.
;  *      Currently, only the pressState and enableState fields are used.
;  *    
;  *    inIsHoriz:
;  *      A Boolean where true means that the scroll bar is to be
;  *      horizontal and false means that the scroll bar is to be
;  *      vertical.
;  *    
;  *    outTrackBounds:
;  *      A pointer to an HIRect in which will be returned the rectangle
;  *      of the track area of the scroll bar.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetScrollBarTrackRect" 
   ((inBounds (:pointer :HIRECT))
    (inTrackInfo (:pointer :HIScrollBarTrackInfo))
    (inIsHoriz :Boolean)
    (outTrackBounds (:pointer :HIRECT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeHitTestScrollBarArrows()
;  *  
;  *  Summary:
;  *    Hit test the theme scroll bar arrows to determine where the hit
;  *    occurred.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inScrollBarBounds:
;  *      An HIRect indicating the bounds of the scroll bar that will be
;  *      hit tested.
;  *    
;  *    inTrackInfo:
;  *      An HIScrollBarTrackInfo for the scroll bar to be drawn.
;  *      Currently, only the version, pressState and enableState fields
;  *      are used.
;  *    
;  *    inIsHoriz:
;  *      A Boolean where true means that the scroll bar is to be
;  *      horizontal and false means that the scroll bar is to be
;  *      vertical.
;  *    
;  *    inPtHit:
;  *      An HIPoint indicating where the control was hit and which will
;  *      be used for hit testing.
;  *    
;  *    outTrackBounds:
;  *      A pointer to an HIRect in which will be returned the rectangle
;  *      of the track area of the scroll bar.  Can be NULL.
;  *    
;  *    outPartCode:
;  *      A pointer to a ControlPartCode in which the part code of the
;  *      hit part will be returned.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeHitTestScrollBarArrows" 
   ((inScrollBarBounds (:pointer :HIRECT))
    (inTrackInfo (:pointer :HIScrollBarTrackInfo))
    (inIsHoriz :Boolean)
    (inPtHit (:pointer :HIPOINT))
    (outTrackBounds (:pointer :HIRECT))
    (outPartCode (:pointer :ControlPartCode))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  *  HIThemeDrawScrollBarDelimiters()
;  *  
;  *  Summary:
;  *    Draw themed scroll bar delimiters.
;  *  
;  *  Discussion:
;  *    Draws the grow lines delimiting the scroll bar areas.  Does not
;  *    draw the size box.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inContRect:
;  *      An HIRect indicating the rectangle of the content area of the
;  *      window to be drawn.
;  *    
;  *    inDrawInfo:
;  *      The HIThemeScrollBarDelimitersDrawInfo of the delimiters to be
;  *      drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawScrollBarDelimiters" 
   ((inContRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeScrollBarDelimitersDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
;  -------------------------------------------------------------------------- 
;   Windows                                                                   
;  -------------------------------------------------------------------------- 
; 
;  *  HIThemeDrawWindowFrame()
;  *  
;  *  Summary:
;  *    Draws a themed window frame.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inContRect:
;  *      An HIRect indicating the rectangle of the content area of the
;  *      window to be drawn.
;  *    
;  *    inDrawInfo:
;  *      The HIThemeWindowDrawInfo of the window frame to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *    
;  *    outTitleRect:
;  *      A pointer to an HIRect into which to put the bounds of the
;  *      title rect.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawWindowFrame" 
   ((inContRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeWindowDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
    (outTitleRect (:pointer :HIRECT))           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawTitleBarWidget()
;  *  
;  *  Summary:
;  *    Draws the requested theme title bar widget.
;  *  
;  *  Discussion:
;  *    HIThemeDrawTitleBarWidget renders the requested theme title bar
;  *    widget in the proper location of a window.  A common
;  *    misconception when using this API is that the client must specify
;  *    the exact location of the widget in the window. The widget will
;  *    locate itself in the window based relative to the content rect
;  *    passed in content rectangle -- the contRect parameter.  Another
;  *    common problem is to ignore the window's attributes.  The
;  *    attributes must be set up properly to describe the window for
;  *    which the widget is to be drawn.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inContRect:
;  *      A rectangle describing the window's content area.  The widget
;  *      is drawn relative to the content rectangle of the window, so
;  *      this parameter does not describe the actual widget bounds, it
;  *      describes the window's content rectangle.
;  *    
;  *    inDrawInfo:
;  *      The HIThemeWindowWidgetDrawInfo of the window widget to be
;  *      drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawTitleBarWidget" 
   ((inContRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeWindowWidgetDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawGrowBox()
;  *  
;  *  Summary:
;  *    Draws a theme grow box.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inOrigin:
;  *      The origin from which to draw the grow box.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeGrowBoxDrawInfo describing the grow box to be drawn
;  *      or measured.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawGrowBox" 
   ((inOrigin (:pointer :HIPOINT))
    (inDrawInfo (:pointer :HIThemeGrowBoxDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetGrowBoxBounds()
;  *  
;  *  Summary:
;  *    Gets the bounds for a grow box.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inOrigin:
;  *      The origin from which to draw the grow box.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeGrowBoxDrawInfo describing the grow box to be drawn
;  *      or measured. The state field is ignored.
;  *    
;  *    outBounds:
;  *      A pointer to an HIRect in which will be returned the rectangle
;  *      of the standalone grow box bounds.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetGrowBoxBounds" 
   ((inOrigin (:pointer :HIPOINT))
    (inDrawInfo (:pointer :HIThemeGrowBoxDrawInfo))
    (outBounds (:pointer :HIRECT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetWindowShape()
;  *  
;  *  Summary:
;  *    Obtains the specified window shape.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inContRect:
;  *      An HIRect indicating the rectangle of the content area of the
;  *      window to be drawn.
;  *    
;  *    inDrawInfo:
;  *      The HIThemeWindowDrawInfo of the window frame to be measured.
;  *    
;  *    inWinRegion:
;  *      A WindowRegionCode indicating the desired region for which to
;  *      return the shape.
;  *    
;  *    outShape:
;  *      A pointer to an HIShapeRef which will be set to the shape of
;  *      the requested window region. Needs to be released by caller.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetWindowShape" 
   ((inContRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeWindowDrawInfo))
    (inWinRegion :UInt16)
    (outShape (:pointer :HISHAPEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeGetWindowRegionHit()
;  *  
;  *  Summary:
;  *    Get the window region hit in a themed window.
;  *  
;  *  Discussion:
;  *    Not that this call does not return a region, but a region code.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inContRect:
;  *      An HIRect indicating the rectangle of the content area of the
;  *      window to be drawn.
;  *    
;  *    inDrawInfo:
;  *      The HIThemeWindowDrawInfo of the window frame to be measured.
;  *    
;  *    inPoint:
;  *      An HIPoint against which the test will occur.
;  *    
;  *    outRegionHit:
;  *      The output WindowRegionCode of hit window region.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeGetWindowRegionHit" 
   ((inContRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeWindowDrawInfo))
    (inPoint (:pointer :HIPOINT))
    (outRegionHit (:pointer :WINDOWREGIONCODE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  -------------------------------------------------------------------------- 
;   Miscellaneous                                                             
;  -------------------------------------------------------------------------- 
; 
;  *  HIThemeDrawFrame()
;  *  
;  *  Summary:
;  *    Draws a variety of frames frame.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect in which to draw.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeFrameDrawInfo describing the frame to be drawn or
;  *      measured.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawFrame" 
   ((inRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeFrameDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawGroupBox()
;  *  
;  *  Summary:
;  *    Draws a themed primary group box.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect in which to draw.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeGroupBoxDrawInfo describing the group box to be drawn
;  *      or measured.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawGroupBox" 
   ((inRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeGroupBoxDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawGenericWell()
;  *  
;  *  Summary:
;  *    Draws a themed generic well.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect in which to draw.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeButtonDrawInfo that describes attributes of the well
;  *      to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawGenericWell" 
   ((inRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeButtonDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawPaneSplitter()
;  *  
;  *  Summary:
;  *    Draws a themed pane splitter.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect in which to draw.
;  *    
;  *    inDrawInfo:
;  *      The HIThemeSplitterDrawInfo of the pane splitter to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawPaneSplitter" 
   ((inRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeSplitterDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawGrabber()
;  *  
;  *  Summary:
;  *    Draws a themed grabber.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect in which to draw.
;  *    
;  *    inDrawInfo:
;  *      The HIThemeGrabberDrawInfo of the grabber to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawGrabber" 
   ((inRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeGrabberDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawPlacard()
;  *  
;  *  Summary:
;  *    Draws a themed placard.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect in which to draw.
;  *    
;  *    inDrawInfo:
;  *      The HIThemePlacardDrawInfo of the placard to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawPlacard" 
   ((inRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemePlacardDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawHeader()
;  *  
;  *  Summary:
;  *    Draws a themed window header in the specified rectangle.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect in which to draw.
;  *    
;  *    inDrawInfo:
;  *      The HIThemeHeaderDrawInfo of the window frame to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawHeader" 
   ((inRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeHeaderDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawFocusRect()
;  *  
;  *  Summary:
;  *    Draws a themed focus rectangle in the specified rectangle.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect in which to draw.
;  *    
;  *    inHasFocus:
;  *      A Boolean indicating whether there is to be focus or not.  If
;  *      there is no focus, the focus area will be erased instead of
;  *      drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawFocusRect" 
   ((inRect (:pointer :HIRECT))
    (inHasFocus :Boolean)
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawSeparator()
;  *  
;  *  Summary:
;  *    Draw a themed separator element.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect in which to draw.
;  *    
;  *    inDrawInfo:
;  *      The HIThemeSeparatorDrawInfo of the window frame to be drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawSeparator" 
   ((inRect (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeSeparatorDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeApplyBackground()
;  *  
;  *  Summary:
;  *    Apply a themed background to a rectangle.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inBounds:
;  *      An HIRect for the background.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeBackgroundDrawInfo describing the background to be
;  *      drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeApplyBackground" 
   ((inBounds (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeBackgroundDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  HIThemeDrawBackground()
;  *  
;  *  Summary:
;  *    Draw a themed background for a rectangle.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inBounds:
;  *      An HIRect indicating the bounds to fill with the background.
;  *      For background that need pattern continuity, such as
;  *      kThemeBackgroundMetal, this rectangle is the full bounds of the
;  *      rectangle for which the filling is to occur. If drawing a
;  *      sub-rectangle of that background, set the clip and draw the
;  *      full rectangle. This routine has been optimized to not perform
;  *      calculations on the non-clip part of the drawing bounds.
;  *      CURRENTLY, THIS API ONLY WORKS WITH kThemeBackgroundMetal.
;  *    
;  *    inDrawInfo:
;  *      An HIThemeBackgroundDrawInfo describing the background to be
;  *      drawn.
;  *    
;  *    inContext:
;  *      The CG context in which the drawing is to be done.
;  *    
;  *    inOrientation:
;  *      An HIThemeOrientation that describes the orientation of the
;  *      passed in context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIThemeDrawBackground" 
   ((inBounds (:pointer :HIRECT))
    (inDrawInfo (:pointer :HIThemeBackgroundDrawInfo))
    (inContext (:pointer :CGContext))
    (inOrientation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __HITHEME__ */


(provide-interface "HITheme")