(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Appearance.h"
; at Sunday July 2,2006 7:24:50 pm.
; 
;      File:       HIToolbox/Appearance.h
;  
;      Contains:   Appearance Manager Interfaces.
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1994-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __APPEARANCE__
; #define __APPEARANCE__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __COLLECTIONS__
#| #|
#include <CarbonCoreCollections.h>
#endif
|#
 |#
; #ifndef __PROCESSES__
#| #|
#include <HIServicesProcesses.h>
#endif
|#
 |#
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Appearance Manager constants, etc.                                               
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Appearance Manager Apple Events (1.1 and later)              

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

(defconstant $kAppearanceEventClass :|appr|)    ;  Event Class 

(defconstant $kAEAppearanceChanged :|thme|)     ;  Appearance changed (e.g. platinum to hi-tech) 

(defconstant $kAESystemFontChanged :|sysf|)     ;  system font changed 

(defconstant $kAESmallSystemFontChanged :|ssfn|);  small system font changed 

(defconstant $kAEViewsFontChanged :|vfnt|)      ;  views font changed 

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Appearance Manager file types                                                    
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeDataFileType :|thme|)       ;  file type for theme files 

(defconstant $kThemePlatinumFileType :|pltn|)   ;  file type for platinum appearance 

(defconstant $kThemeCustomThemesFileType :|scen|);  file type for user themes 

(defconstant $kThemeSoundTrackFileType :|tsnd|)
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Appearance Manager Supported Themes                                              
;  Use CopyThemeIdentifier to get the current theme ID                              
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; #define kThemeAppearancePlatinum       CFSTR( "com.apple.theme.appearance.platinum" )
; #define kThemeAppearanceAqua         CFSTR( "com.apple.theme.appearance.aqua" )
; #define kThemeAppearanceAquaBlue     CFSTR( "com.apple.theme.appearance.aqua.blue" )
; #define kThemeAppearanceAquaGraphite    CFSTR( "com.apple.theme.appearance.aqua.graphite" )
; 
;  *  AppearancePartCode
;  *  
;  *  Summary:
;  *    These are part codes returned by a few of the hit testing
;  *    Appearance APIs. Many of the Control Manager's ControlPartCodes
;  *    are based on these part codes.
;  

(def-mactype :AppearancePartCode (find-mactype ':SInt16))
; 
;    * This represents the lack of a part. It will be returned when the
;    * Appearance Manager's hit testing logic determines that the input
;    * point is not in any part of the widget.
;    

(defconstant $kAppearancePartMetaNone 0)
; 
;    * This represents a widget which is not currently clickable because
;    * it is disabled.
;    

(defconstant $kAppearancePartMetaDisabled #xFE)
; 
;    * This represents a widget which is inactive, presumably because it
;    * is in a window that is inactive.
;    

(defconstant $kAppearancePartMetaInactive #xFF)
; 
;    * The part of a widget which indicates the widget's value. Scroll
;    * bar thumbs and slider thumbs are the two main examples.
;    

(defconstant $kAppearancePartIndicator #x81)
; 
;    * The part of a widget which moves its value visually upward. Scroll
;    * bar up arrows are the main example.
;    

(defconstant $kAppearancePartUpButton 20)
; 
;    * The part of a widget which moves its value visually downward.
;    * Scroll bar down arrows are the main example.
;    

(defconstant $kAppearancePartDownButton 21)
; 
;    * The part of a widget which moves its value visually leftward.
;    * Scroll bar left arrows are the main example.
;    

(defconstant $kAppearancePartLeftButton 20)
; 
;    * The part of a widget which moves its value visually rightward.
;    * Scroll bar right arrows are the main example.
;    

(defconstant $kAppearancePartRightButton 21)
; 
;    * The part of a widget which moves its value visually upward one
;    * whole page. Scroll bar page up areas are the main example.
;    

(defconstant $kAppearancePartPageUpArea 22)
; 
;    * The part of a widget which moves its value visually downward one
;    * whole page. Scroll bar page down areas are the main example.
;    

(defconstant $kAppearancePartPageDownArea 23)
; 
;    * The part of a widget which moves its value visually leftward one
;    * whole page. Scroll bar page left areas are the main example.
;    

(defconstant $kAppearancePartPageLeftArea 22)
; 
;    * The part of a widget which moves its value visually rightward one
;    * whole page. Scroll bar page right areas are the main example.
;    

(defconstant $kAppearancePartPageRightArea 23)
; 
;  *  AppearanceRegionCode
;  *  
;  *  Summary:
;  *    These are region codes used by a few of window-related Appearance
;  *    APIs. Many of the Window Manager's WindowRegionCodes are based on
;  *    these region codes.
;  

(def-mactype :AppearanceRegionCode (find-mactype ':UInt16))

(defconstant $kAppearanceRegionTitleBar 0)
(defconstant $kAppearanceRegionTitleText 1)
(defconstant $kAppearanceRegionCloseBox 2)
(defconstant $kAppearanceRegionZoomBox 3)
(defconstant $kAppearanceRegionDrag 5)
(defconstant $kAppearanceRegionGrow 6)
(defconstant $kAppearanceRegionCollapseBox 7)
(defconstant $kAppearanceRegionTitleProxyIcon 8);  Mac OS 8.5 forward

(defconstant $kAppearanceRegionStructure 32)
(defconstant $kAppearanceRegionContent 33)      ;  Content area of the window; empty when the window is collapsed


(defconstant $kThemeBrushDialogBackgroundActive 1);  use with kModalWindowClass 

(defconstant $kThemeBrushDialogBackgroundInactive 2);  use with kModalWindowClass 

(defconstant $kThemeBrushAlertBackgroundActive 3);  use with kAlertWindowClass and kMovableAlertWindowClass 

(defconstant $kThemeBrushAlertBackgroundInactive 4);  use with kAlertWindowClass and kMovableAlertWindowClass 

(defconstant $kThemeBrushModelessDialogBackgroundActive 5);  use with kDocumentWindowClass 

(defconstant $kThemeBrushModelessDialogBackgroundInactive 6);  use with kDocumentWindowClass 

(defconstant $kThemeBrushUtilityWindowBackgroundActive 7);  use with kFloatingWindowClass and kUtilityWindowClass 

(defconstant $kThemeBrushUtilityWindowBackgroundInactive 8);  use with kFloatingWindowClass and kUtilityWindowClass 

(defconstant $kThemeBrushListViewSortColumnBackground 9);  Finder list views 

(defconstant $kThemeBrushListViewBackground 10)
(defconstant $kThemeBrushIconLabelBackground 11)
(defconstant $kThemeBrushListViewSeparator 12)
(defconstant $kThemeBrushChasingArrows 13)
(defconstant $kThemeBrushDragHilite 14)
(defconstant $kThemeBrushDocumentWindowBackground 15);  use with kDocumentWindowClass 

(defconstant $kThemeBrushFinderWindowBackground 16)
;  Brushes introduced in Appearance 1.1 (Mac OS 8.5) and later 

(defconstant $kThemeBrushScrollBarDelimiterActive 17)
(defconstant $kThemeBrushScrollBarDelimiterInactive 18)
(defconstant $kThemeBrushFocusHighlight 19)
(defconstant $kThemeBrushPopupArrowActive 20)
(defconstant $kThemeBrushPopupArrowPressed 21)
(defconstant $kThemeBrushPopupArrowInactive 22)
(defconstant $kThemeBrushAppleGuideCoachmark 23)
(defconstant $kThemeBrushIconLabelBackgroundSelected 24)
(defconstant $kThemeBrushStaticAreaFill 25)
(defconstant $kThemeBrushActiveAreaFill 26)
(defconstant $kThemeBrushButtonFrameActive 27)
(defconstant $kThemeBrushButtonFrameInactive 28)
(defconstant $kThemeBrushButtonFaceActive 29)
(defconstant $kThemeBrushButtonFaceInactive 30)
(defconstant $kThemeBrushButtonFacePressed 31)
(defconstant $kThemeBrushButtonActiveDarkShadow 32)
(defconstant $kThemeBrushButtonActiveDarkHighlight 33)
(defconstant $kThemeBrushButtonActiveLightShadow 34)
(defconstant $kThemeBrushButtonActiveLightHighlight 35)
(defconstant $kThemeBrushButtonInactiveDarkShadow 36)
(defconstant $kThemeBrushButtonInactiveDarkHighlight 37)
(defconstant $kThemeBrushButtonInactiveLightShadow 38)
(defconstant $kThemeBrushButtonInactiveLightHighlight 39)
(defconstant $kThemeBrushButtonPressedDarkShadow 40)
(defconstant $kThemeBrushButtonPressedDarkHighlight 41)
(defconstant $kThemeBrushButtonPressedLightShadow 42)
(defconstant $kThemeBrushButtonPressedLightHighlight 43)
(defconstant $kThemeBrushBevelActiveLight 44)
(defconstant $kThemeBrushBevelActiveDark 45)
(defconstant $kThemeBrushBevelInactiveLight 46)
(defconstant $kThemeBrushBevelInactiveDark 47)
;  Brushes introduced in Appearance 1.1.1 (Mac OS 9.0) and later 

(defconstant $kThemeBrushNotificationWindowBackground 48)
;  Brushes introduced in Carbon 

(defconstant $kThemeBrushMovableModalBackground 49);  use with kMovableModalWindowClass; available in Mac OS X, and CarbonLib 1.3 and later 

(defconstant $kThemeBrushSheetBackgroundOpaque 50);  use with kSheetWindowClass and kSheetAlertWindowClass; available in Mac OS X, and CarbonLib 1.3 and later 

(defconstant $kThemeBrushDrawerBackground 51)   ;  use with kDrawerWindowClass; available in Mac OS X, and CarbonLib 1.3 and later 

(defconstant $kThemeBrushToolbarBackground 52)  ;  use with kToolbarWindowClass; available in Mac OS X, and CarbonLib 1.6 and later 

(defconstant $kThemeBrushSheetBackgroundTransparent 53);  use with kSheetWindowClass and kSheetAlertWindowClass; available in Mac OS X 10.1 and CarbonLib 1.6, and later 

(defconstant $kThemeBrushMenuBackground 54)     ;  available in Mac OS X 10.1 and CarbonLib 1.6, and later 

(defconstant $kThemeBrushMenuBackgroundSelected 55);  available in Mac OS X 10.1 and CarbonLib 1.6, and later 

;  Appearance X or later theme brush compatibility synonyms 

(defconstant $kThemeBrushSheetBackground 50)
;  These values are meta-brushes, specific colors that do not       
;  change from theme to theme. You can use them instead of using    
;  direct RGB values.                                               

(defconstant $kThemeBrushBlack -1)
(defconstant $kThemeBrushWhite -2)
(defconstant $kThemeBrushPrimaryHighlightColor -3);  available in Mac OS 10.1 and CarbonLib 1.6, and later

(defconstant $kThemeBrushSecondaryHighlightColor -4);  available in Mac OS 10.1 and CarbonLib 1.6, and later
;  available in Mac OS 10.2 and later

(defconstant $kThemeBrushAlternatePrimaryHighlightColor -5)

(def-mactype :ThemeBrush (find-mactype ':SInt16))

(defconstant $kThemeTextColorDialogActive 1)
(defconstant $kThemeTextColorDialogInactive 2)
(defconstant $kThemeTextColorAlertActive 3)
(defconstant $kThemeTextColorAlertInactive 4)
(defconstant $kThemeTextColorModelessDialogActive 5)
(defconstant $kThemeTextColorModelessDialogInactive 6)
(defconstant $kThemeTextColorWindowHeaderActive 7)
(defconstant $kThemeTextColorWindowHeaderInactive 8)
(defconstant $kThemeTextColorPlacardActive 9)
(defconstant $kThemeTextColorPlacardInactive 10)
(defconstant $kThemeTextColorPlacardPressed 11)
(defconstant $kThemeTextColorPushButtonActive 12)
(defconstant $kThemeTextColorPushButtonInactive 13)
(defconstant $kThemeTextColorPushButtonPressed 14)
(defconstant $kThemeTextColorBevelButtonActive 15)
(defconstant $kThemeTextColorBevelButtonInactive 16)
(defconstant $kThemeTextColorBevelButtonPressed 17)
(defconstant $kThemeTextColorPopupButtonActive 18)
(defconstant $kThemeTextColorPopupButtonInactive 19)
(defconstant $kThemeTextColorPopupButtonPressed 20)
(defconstant $kThemeTextColorIconLabel 21)
(defconstant $kThemeTextColorListView 22)
;  Text Colors available in Appearance 1.0.1 or later 

(defconstant $kThemeTextColorDocumentWindowTitleActive 23)
(defconstant $kThemeTextColorDocumentWindowTitleInactive 24)
(defconstant $kThemeTextColorMovableModalWindowTitleActive 25)
(defconstant $kThemeTextColorMovableModalWindowTitleInactive 26)
(defconstant $kThemeTextColorUtilityWindowTitleActive 27)
(defconstant $kThemeTextColorUtilityWindowTitleInactive 28)
(defconstant $kThemeTextColorPopupWindowTitleActive 29)
(defconstant $kThemeTextColorPopupWindowTitleInactive 30)
(defconstant $kThemeTextColorRootMenuActive 31)
(defconstant $kThemeTextColorRootMenuSelected 32)
(defconstant $kThemeTextColorRootMenuDisabled 33)
(defconstant $kThemeTextColorMenuItemActive 34)
(defconstant $kThemeTextColorMenuItemSelected 35)
(defconstant $kThemeTextColorMenuItemDisabled 36)
(defconstant $kThemeTextColorPopupLabelActive 37)
(defconstant $kThemeTextColorPopupLabelInactive 38)
;  Text colors available in Appearance 1.1 or later 

(defconstant $kThemeTextColorTabFrontActive 39)
(defconstant $kThemeTextColorTabNonFrontActive 40)
(defconstant $kThemeTextColorTabNonFrontPressed 41)
(defconstant $kThemeTextColorTabFrontInactive 42)
(defconstant $kThemeTextColorTabNonFrontInactive 43)
(defconstant $kThemeTextColorIconLabelSelected 44)
(defconstant $kThemeTextColorBevelButtonStickyActive 45)
(defconstant $kThemeTextColorBevelButtonStickyInactive 46)
;  Text colors available in Appearance 1.1.1 or later 

(defconstant $kThemeTextColorNotification 47)
;  Text colors only available later than OS X 10.1.3 

(defconstant $kThemeTextColorSystemDetail 48)
;  These values are specific colors that do not change from             
;  theme to theme. You can use them instead of using direct RGB values. 

(defconstant $kThemeTextColorBlack -1)
(defconstant $kThemeTextColorWhite -2)

(def-mactype :ThemeTextColor (find-mactype ':SInt16))
;  States to draw primitives: disabled, active, and pressed (hilited) 

(defconstant $kThemeStateInactive 0)
(defconstant $kThemeStateActive 1)
(defconstant $kThemeStatePressed 2)
(defconstant $kThemeStateRollover 6)
(defconstant $kThemeStateUnavailable 7)
(defconstant $kThemeStateUnavailableInactive 8)
;  obsolete name 

(defconstant $kThemeStateDisabled 0)

(defconstant $kThemeStatePressedUp 2)           ;  draw with up pressed     (increment/decrement buttons) 

(defconstant $kThemeStatePressedDown 3)         ;  draw with down pressed (increment/decrement buttons) 


(def-mactype :ThemeDrawState (find-mactype ':UInt32))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Theme cursor selectors available in Appearance 1.1 or later                      
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  

(defconstant $kThemeArrowCursor 0)
(defconstant $kThemeCopyArrowCursor 1)
(defconstant $kThemeAliasArrowCursor 2)
(defconstant $kThemeContextualMenuArrowCursor 3)
(defconstant $kThemeIBeamCursor 4)
(defconstant $kThemeCrossCursor 5)
(defconstant $kThemePlusCursor 6)
(defconstant $kThemeWatchCursor 7)              ;  Can Animate 

(defconstant $kThemeClosedHandCursor 8)
(defconstant $kThemeOpenHandCursor 9)
(defconstant $kThemePointingHandCursor 10)
(defconstant $kThemeCountingUpHandCursor 11)    ;  Can Animate 

(defconstant $kThemeCountingDownHandCursor 12)  ;  Can Animate 

(defconstant $kThemeCountingUpAndDownHandCursor 13);  Can Animate 

(defconstant $kThemeSpinningCursor 14)          ;  Can Animate 

(defconstant $kThemeResizeLeftCursor 15)
(defconstant $kThemeResizeRightCursor 16)
(defconstant $kThemeResizeLeftRightCursor 17)
(defconstant $kThemeNotAllowedCursor 18)        ;  available on Mac OS X 10.2 and later 
; 
;    * Available in Mac OS X 10.3 or later.
;    

(defconstant $kThemeResizeUpCursor 19)
; 
;    * Available in Mac OS X 10.3 or later.
;    

(defconstant $kThemeResizeDownCursor 20)
; 
;    * Available in Mac OS X 10.3 or later.
;    

(defconstant $kThemeResizeUpDownCursor 21)
; 
;    * A special cursor to indicate that letting up the mouse will cause
;    * a dragged item to go away. When the item goes away, a poof cloud
;    * animation should occur. This cursor should be updated dynamically
;    * dependeding on whether the mouse up action will remove the item.
;    * Available in Mac OS X 10.3 or later.
;    

(defconstant $kThemePoofCursor 22)

(def-mactype :ThemeCursor (find-mactype ':UInt32))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Theme menu bar drawing states                                                    
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeMenuBarNormal 0)
(defconstant $kThemeMenuBarSelected 1)

(def-mactype :ThemeMenuBarState (find-mactype ':UInt16))
;  attributes 

(defconstant $kThemeMenuSquareMenuBar 1)
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Theme menu drawing states                                                        
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeMenuActive 0)
(defconstant $kThemeMenuSelected 1)
(defconstant $kThemeMenuDisabled 3)

(def-mactype :ThemeMenuState (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  MenuType: add kThemeMenuTypeInactive to menu type for DrawThemeMenuBackground if entire  
;  menu is inactive                                                                         
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeMenuTypePullDown 0)
(defconstant $kThemeMenuTypePopUp 1)
(defconstant $kThemeMenuTypeHierarchical 2)
(defconstant $kThemeMenuTypeInactive #x100)

(def-mactype :ThemeMenuType (find-mactype ':UInt16))

(defconstant $kThemeMenuItemPlain 0)
(defconstant $kThemeMenuItemHierarchical 1)     ;  item has hierarchical arrow

(defconstant $kThemeMenuItemScrollUpArrow 2)    ;  for scrollable menus, indicates item is scroller

(defconstant $kThemeMenuItemScrollDownArrow 3)
(defconstant $kThemeMenuItemAtTop #x100)        ;  indicates item is being drawn at top of menu

(defconstant $kThemeMenuItemAtBottom #x200)     ;  indicates item is being drawn at bottom of menu

(defconstant $kThemeMenuItemHierBackground #x400);  item is within a hierarchical menu

(defconstant $kThemeMenuItemPopUpBackground #x800);  item is within a popped up menu

(defconstant $kThemeMenuItemHasIcon #x8000)     ;  add into non-arrow type when icon present

(defconstant $kThemeMenuItemNoBackground #x4000);  don't draw the menu background while drawing this item (Mac OS X only)


(def-mactype :ThemeMenuItemType (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Theme Backgrounds                                                                        
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  

(defconstant $kThemeBackgroundTabPane 1)
(defconstant $kThemeBackgroundPlacard 2)
(defconstant $kThemeBackgroundWindowHeader 3)
(defconstant $kThemeBackgroundListViewWindowHeader 4)
(defconstant $kThemeBackgroundSecondaryGroupBox 5)
; 
;    * A special theme brush for drawing metal backgrounds. Currently,
;    * this brush only works with HIThemeApplyBackground.
;    

(defconstant $kThemeBackgroundMetal 6)

(def-mactype :ThemeBackgroundKind (find-mactype ':UInt32))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Theme Collection tags for Get/SetTheme                                                   
;                                                                                           
;   X ALERT: Please note that Get/SetTheme are severely neutered under Mac OS X at present. 
;            The first group of tags below are available to get under both 9 and X. The     
;            second group is 9 only. None of the tags can be used in SetTheme on X, as it   
;            is completely inert on X, and will return unimpErr.                            
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeNameTag :|name|)            ;  Str255

(defconstant $kThemeVariantNameTag :|varn|)     ;  Str255

(defconstant $kThemeVariantBaseTintTag :|tint|) ;  RGBColor (10.1 and later)

(defconstant $kThemeHighlightColorTag :|hcol|)  ;  RGBColor

(defconstant $kThemeScrollBarArrowStyleTag :|sbar|);  ThemeScrollBarArrowStyle

(defconstant $kThemeScrollBarThumbStyleTag :|sbth|);  ThemeScrollBarThumbStyle

(defconstant $kThemeSoundsEnabledTag :|snds|)   ;  Boolean

(defconstant $kThemeDblClickCollapseTag :|coll|);  Boolean


(defconstant $kThemeAppearanceFileNameTag :|thme|);  Str255

(defconstant $kThemeSystemFontTag :|lgsf|)      ;  Str255

(defconstant $kThemeSmallSystemFontTag :|smsf|) ;  Str255

(defconstant $kThemeViewsFontTag :|vfnt|)       ;  Str255

(defconstant $kThemeViewsFontSizeTag :|vfsz|)   ;  SInt16

(defconstant $kThemeDesktopPatternNameTag :|patn|);  Str255

(defconstant $kThemeDesktopPatternTag :|patt|)  ;  <variable-length data> (flattened pattern)

(defconstant $kThemeDesktopPictureNameTag :|dpnm|);  Str255

(defconstant $kThemeDesktopPictureAliasTag :|dpal|);  <alias handle>

(defconstant $kThemeDesktopPictureAlignmentTag :|dpan|);  UInt32 (see the Picture Alignments below)

(defconstant $kThemeHighlightColorNameTag :|hcnm|);  Str255

(defconstant $kThemeExamplePictureIDTag :|epic|);  SInt16

(defconstant $kThemeSoundTrackNameTag :|sndt|)  ;  Str255

(defconstant $kThemeSoundMaskTag :|smsk|)       ;  UInt32

(defconstant $kThemeUserDefinedTag :|user|)     ;  Boolean (this should _always_ be true if present - used by Control Panel).

(defconstant $kThemeSmoothFontEnabledTag :|smoo|);  Boolean

(defconstant $kThemeSmoothFontMinSizeTag :|smos|);  UInt16 (must be >= 12 and <= 24)

;  Picture Aligmnents that might be reported in the data for kThemeDesktopPictureAlignmentTag

(defconstant $kTiledOnScreen 1)                 ;  draws picture repeatedly

(defconstant $kCenterOnScreen 2)                ;  "actual size", shows pattern on sides or clips picture if necessary

(defconstant $kFitToScreen 3)                   ;  shrinks if necessary

(defconstant $kFillScreen 4)                    ;  messes up aspect ratio if necessary

(defconstant $kUseBestGuess 5)                  ;  heuristically determines the best way to display the picture based on picture and monitor sizes

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Theme Control Settings                                                                   
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeCheckBoxClassicX 0)         ;  check box with an 'X'

(defconstant $kThemeCheckBoxCheckMark 1)        ;  check box with a real check mark


(def-mactype :ThemeCheckBoxStyle (find-mactype ':UInt16))

(defconstant $kThemeScrollBarArrowsSingle 0)    ;  single arrow on each end

(defconstant $kThemeScrollBarArrowsLowerRight 1);  double arrows only on right or bottom


(def-mactype :ThemeScrollBarArrowStyle (find-mactype ':UInt16))

(defconstant $kThemeScrollBarThumbNormal 0)     ;  normal, classic thumb size

(defconstant $kThemeScrollBarThumbProportional 1);  proportional thumbs


(def-mactype :ThemeScrollBarThumbStyle (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Font constants                                                                           
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  Summary:
;  *    A ThemeFontID value is a virtual font ID which can be passed to
;  *    one of the Appearance Manager's text-related routines. Within
;  *    those routines, the ThemeFontID is mapped into the appropriate
;  *    real font (or fonts), size, and style based on the system
;  *    appearance (Platinum on Mac OS 9, Aqua on Mac OS X), the string
;  *    to be rendered (if any), the language/ script that the app is
;  *    running in, and possibly other factors. The ThemeFontIDs allow
;  *    you to get the correct text appearance for the platform your app
;  *    is currently running on.
;  
; 
;    * The font used to draw most interface elements. If you can't find a
;    * more appropriate font from the list below, you should use this
;    * one. This font is suitable for drawing titles on most custom
;    * widgets/buttons, as well as most static text in dialogs and
;    * windows.
;    

(defconstant $kThemeSystemFont 0)
; 
;    * The font used to draw interface elements when space is at a
;    * premium. It draws a slightly smaller font compared to
;    * kThemeSystemFont.
;    

(defconstant $kThemeSmallSystemFont 1)
; 
;    * Identical to kThemeSmallSystemFont, except it draws bolded (or
;    * otherwise emphasized in some fashion appropriate to your
;    * application's language/script).
;    

(defconstant $kThemeSmallEmphasizedSystemFont 2)
; 
;    * The font used to draw file and folder names in Finder windows or
;    * other browsable lists.
;    

(defconstant $kThemeViewsFont 3)                ;  The following ID's are only available with MacOS X or CarbonLib 1.3 and later
; 
;    * Identical to kThemeSystemFont, except it draws bolded (or
;    * otherwise emphasized in some fashion appropriate to your
;    * application's language/script). Only available on Mac OS X or
;    * CarbonLib 1.3 or later.
;    

(defconstant $kThemeEmphasizedSystemFont 4)
; 
;    * An analog to the Script Manager's notion of the Application Font.
;    * This font is a suitable default choice for your application's
;    * document-style text editing areas. Only available on Mac OS X or
;    * CarbonLib 1.3 or later.
;    

(defconstant $kThemeApplicationFont 5)
; 
;    * Generally smaller than kThemeSmallSystemFont, this font is
;    * appropriate for drawing text labels next to image content that
;    * reinforces the text's meaning (such as on a bevel button). Only
;    * available on Mac OS X or CarbonLib 1.3 or later.
;    

(defconstant $kThemeLabelFont 6)
; 
;    * The font used to draw menu titles in the menu bar. Only available
;    * on Mac OS X or CarbonLib 1.3 or later.
;    

(defconstant $kThemeMenuTitleFont 100)
; 
;    * The font used to draw menu items in the menus. Only available on
;    * Mac OS X or CarbonLib 1.3 or later.
;    

(defconstant $kThemeMenuItemFont 101)
; 
;    * The font used to draw menu item marks in the menus. Only available
;    * on Mac OS X or CarbonLib 1.3 or later.
;    

(defconstant $kThemeMenuItemMarkFont 102)
; 
;    * The font used to draw menu item command key equivalents in the
;    * menus. Only available on Mac OS X or CarbonLib 1.3 or later.
;    

(defconstant $kThemeMenuItemCmdKeyFont 103)
; 
;    * The font used to draw text in most window title bars. Only
;    * available on Mac OS X or CarbonLib 1.3 or later.
;    

(defconstant $kThemeWindowTitleFont 104)
; 
;    * The font used to draw text labels on push buttons. Only available
;    * on Mac OS X or CarbonLib 1.3 or later.
;    

(defconstant $kThemePushButtonFont 105)
; 
;    * The font used to draw text in utility window title bars. Only
;    * available on Mac OS X or CarbonLib 1.3 or later.
;    

(defconstant $kThemeUtilityWindowTitleFont 106)
; 
;    * The font used to draw the first (and most important) message of an
;    * alert window. Only available on Mac OS X or CarbonLib 1.3 or later.
;    

(defconstant $kThemeAlertHeaderFont 107)
(defconstant $kThemeSystemFontDetail 7)
(defconstant $kThemeSystemFontDetailEmphasized 8)
; 
;    * Unlike the other ThemeFontIDs, this one doesn't map to a font
;    * appropriate to your application's language or script. It maps
;    * directly to the font, size, and style of the current Quickdraw
;    * port. This allows you to get somewhat customized behavior out of
;    * the APIs which take ThemeFontIDs. Note, however, that
;    * kThemeCurrentPortFont does not (and will never) support all
;    * Quickdraw styles on all platforms; in particular, outline and
;    * shadow style are not supported on Mac OS X. Additionally,
;    * kThemeCurrentPortFont is not (and will never be) completely
;    * unicode savvy; use of kThemeCurrentPortFont may result in errors
;    * having to do with the current port's font not being appropriate
;    * for rendering or measuring all glyphs in a given unicode string.
;    * Because of overhead associated with gathering Quickdraw font
;    * information and converting it to the native font format on Mac OS
;    * X, use of kThemeCurrentPortFont may slow down your text drawing
;    * and measuring significantly compared to other ThemeFontIDs.
;    * Instead of using kThemeCurrentPortFont, your application will
;    * probably be better served by using one of the other ThemeFontIDs;
;    * use kThemeCurrentPortFont only as a last resort. Only available on
;    * Mac OS X or CarbonLib 1.3 or later.
;    

(defconstant $kThemeCurrentPortFont #xC8)
; 
;    * The font used to draw the label of a toolbar item. Available in
;    * Mac OS X 10.2 or later.
;    

(defconstant $kThemeToolbarFont 108)
; 
;    * The appropriate system font for mini-sized controls. Available in
;    * Mac OS X 10.3 or later.
;    

(defconstant $kThemeMiniSystemFont 109)
;  This is the total of the PUBLIC ThemeFontIDs!

(defconstant $kPublicThemeFontCount 20)

(def-mactype :ThemeFontID (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Tab constants                                                                            
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeTabNonFront 0)
(defconstant $kThemeTabNonFrontPressed 1)
(defconstant $kThemeTabNonFrontInactive 2)
(defconstant $kThemeTabFront 3)
(defconstant $kThemeTabFrontInactive 4)
(defconstant $kThemeTabNonFrontUnavailable 5)
(defconstant $kThemeTabFrontUnavailable 6)

(def-mactype :ThemeTabStyle (find-mactype ':UInt16))

(defconstant $kThemeTabNorth 0)
(defconstant $kThemeTabSouth 1)
(defconstant $kThemeTabEast 2)
(defconstant $kThemeTabWest 3)

(def-mactype :ThemeTabDirection (find-mactype ':UInt16))
; 
;  *  Summary:
;  *    Deprecated tab height and overlap constants.
;  *  
;  *  Discussion:
;  *    These constants have been deprecated in favor of theme metrics.
;  *    Please do not use them anymore. These constants will be removed
;  *    in the next major release of OS X.
;  
; 
;    * Deprecated. Use kThemeMetricSmallTabHeight.
;    

(defconstant $kThemeSmallTabHeight 16)
; 
;    * Deprecated. Use kThemeMetricLargeTabHeight.
;    

(defconstant $kThemeLargeTabHeight 21)
; 
;    * Deprecated. Use kThemeMetricTabFrameOverlap.
;    

(defconstant $kThemeTabPaneOverlap 3)
; 
;    * Deprecated. Use kThemeMetricSmallTabHeight and
;    * kThemeMetricSmallTabFrameOverlap.
;    

(defconstant $kThemeSmallTabHeightMax 19)
; 
;    * Deprecated. Use metric kThemeMetricLargeTabHeight and
;    * kThemeMetricTabFrameOverlap.
;    

(defconstant $kThemeLargeTabHeightMax 24)
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Track kinds                                                                              
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeMediumScrollBar 0)
(defconstant $kThemeSmallScrollBar 1)
(defconstant $kThemeMediumSlider 2)
(defconstant $kThemeMediumProgressBar 3)
(defconstant $kThemeMediumIndeterminateBar 4)
(defconstant $kThemeRelevanceBar 5)
(defconstant $kThemeSmallSlider 6)
(defconstant $kThemeLargeProgressBar 7)
(defconstant $kThemeLargeIndeterminateBar 8)
; 
;  *  Discussion:
;  *    New TThemeTrackKinds on Mac OS X 10.3 and later. Not all of them
;  *    are implemented.
;  
; 
;    * Not implemented. Will return paramErr if used.
;    

(defconstant $kThemeMiniScrollBar 9)
; 
;    * A miniature version of the slider.
;    

(defconstant $kThemeMiniSlider 10)
; 
;    * Not implemented. Will return paramErr if used.
;    

(defconstant $kThemeMiniProgressBar 11)
; 
;    * Not implemented. Will return paramErr if used.
;    

(defconstant $kThemeMiniIndeterminateBar 12)

(def-mactype :ThemeTrackKind (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Track enable states                                                                      
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  track states 

(defconstant $kThemeTrackActive 0)
(defconstant $kThemeTrackDisabled 1)
(defconstant $kThemeTrackNothingToScroll 2)
(defconstant $kThemeTrackInactive 3)

(def-mactype :ThemeTrackEnableState (find-mactype ':UInt8))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Track pressed states                                                                     
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  press states (ignored unless track is active) 

(defconstant $kThemeLeftOutsideArrowPressed 1)
(defconstant $kThemeLeftInsideArrowPressed 2)
(defconstant $kThemeLeftTrackPressed 4)
(defconstant $kThemeThumbPressed 8)
(defconstant $kThemeRightTrackPressed 16)
(defconstant $kThemeRightInsideArrowPressed 32)
(defconstant $kThemeRightOutsideArrowPressed 64)
(defconstant $kThemeTopOutsideArrowPressed 1)
(defconstant $kThemeTopInsideArrowPressed 2)
(defconstant $kThemeTopTrackPressed 4)
(defconstant $kThemeBottomTrackPressed 16)
(defconstant $kThemeBottomInsideArrowPressed 32)
(defconstant $kThemeBottomOutsideArrowPressed 64)

(def-mactype :ThemeTrackPressState (find-mactype ':UInt8))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Thumb directions                                                                         
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  thumb direction 

(defconstant $kThemeThumbPlain 0)
(defconstant $kThemeThumbUpward 1)
(defconstant $kThemeThumbDownward 2)

(def-mactype :ThemeThumbDirection (find-mactype ':UInt8))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Track attributes                                                                         
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  Discussion:
;  *    Theme track attributes control the look of the track elements as
;  *    drawn by the DrawThemeTrackFoo as well as the region returned by
;  *    GetThemeTrackFoo.
;  
; 
;    * The track is drawn horizontally.
;    

(defconstant $kThemeTrackHorizontal 1)
; 
;    * The track progresses from right to left.
;    

(defconstant $kThemeTrackRightToLeft 2)
; 
;    * The track's thumb should be drawn.
;    

(defconstant $kThemeTrackShowThumb 4)
; 
;    * The provided thumbRgn should be drawn opaque, not as a ghost.
;    

(defconstant $kThemeTrackThumbRgnIsNotGhost 8)
; 
;    * The track scroll bar doesn't have arrows.  This attribute
;    * currently has no effect
;    

(defconstant $kThemeTrackNoScrollBarArrows 16)
; 
;    * The thumb has focus.  This attribute currently has effect only on
;    * sliders.  Available only in Mac OS X after 10.1.
;    

(defconstant $kThemeTrackHasFocus 32)

(def-mactype :ThemeTrackAttributes (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Track info block                                                                         
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
(defrecord ScrollBarTrackInfo
   (viewsize :SInt32)                           ;  current view range size 
   (pressState :UInt8)                          ;  pressed parts state 
)

;type name? (%define-record :ScrollBarTrackInfo (find-record-descriptor ':ScrollBarTrackInfo))
(defrecord SliderTrackInfo
   (thumbDir :UInt8)                            ;  thumb direction 
   (pressState :UInt8)                          ;  pressed parts state 
)

;type name? (%define-record :SliderTrackInfo (find-record-descriptor ':SliderTrackInfo))
(defrecord ProgressTrackInfo
   (phase :UInt8)                               ;  phase for indeterminate progress 
)

;type name? (%define-record :ProgressTrackInfo (find-record-descriptor ':ProgressTrackInfo))
(defrecord ThemeTrackDrawInfo
   (kind :UInt16)                               ;  what kind of track this info is for 
   (bounds :Rect)                               ;  track basis rectangle 
   (min :SInt32)                                ;  min track value 
   (max :SInt32)                                ;  max track value 
   (value :SInt32)                              ;  current thumb value 
   (reserved :UInt32)
   (attributes :UInt16)                         ;  various track attributes 
   (enableState :UInt8)                         ;  enable state 
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

;type name? (%define-record :ThemeTrackDrawInfo (find-record-descriptor ':ThemeTrackDrawInfo))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  ThemeWindowAttributes                                                                    
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeWindowHasGrow 1)            ;  can the size of the window be changed by the user? 

(defconstant $kThemeWindowHasHorizontalZoom 8)  ;  window can zoom only horizontally 

(defconstant $kThemeWindowHasVerticalZoom 16)   ;  window can zoom only vertically 

(defconstant $kThemeWindowHasFullZoom 24)       ;  window zooms in all directions 

(defconstant $kThemeWindowHasCloseBox 32)       ;  window has a close box 

(defconstant $kThemeWindowHasCollapseBox 64)    ;  window has a collapse box 

(defconstant $kThemeWindowHasTitleText #x80)    ;  window has a title/title icon 

(defconstant $kThemeWindowIsCollapsed #x100)    ;  window is in the collapsed state 

(defconstant $kThemeWindowHasDirty #x200)

(def-mactype :ThemeWindowAttributes (find-mactype ':UInt32))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Window Types Supported by the Appearance Manager                                         
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeDocumentWindow 0)
(defconstant $kThemeDialogWindow 1)
(defconstant $kThemeMovableDialogWindow 2)
(defconstant $kThemeAlertWindow 3)
(defconstant $kThemeMovableAlertWindow 4)
(defconstant $kThemePlainDialogWindow 5)
(defconstant $kThemeShadowDialogWindow 6)
(defconstant $kThemePopupWindow 7)
(defconstant $kThemeUtilityWindow 8)
(defconstant $kThemeUtilitySideWindow 9)
(defconstant $kThemeSheetWindow 10)
(defconstant $kThemeDrawerWindow 11)

(def-mactype :ThemeWindowType (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Window Widgets Supported by the Appearance Manager                                       
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeWidgetCloseBox 0)
(defconstant $kThemeWidgetZoomBox 1)
(defconstant $kThemeWidgetCollapseBox 2)
(defconstant $kThemeWidgetDirtyCloseBox 6)
;  Old/Obsolete name to be removed

(defconstant $kThemeWidgetABox 3)
(defconstant $kThemeWidgetBBox 4)
(defconstant $kThemeWidgetBOffBox 5)

(def-mactype :ThemeTitleBarWidget (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Popup arrow orientations                                                                 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeArrowLeft 0)
(defconstant $kThemeArrowDown 1)
(defconstant $kThemeArrowRight 2)
(defconstant $kThemeArrowUp 3)

(def-mactype :ThemeArrowOrientation (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Popup arrow sizes                                                                        
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeArrow3pt 0)
(defconstant $kThemeArrow5pt 1)
(defconstant $kThemeArrow7pt 2)
(defconstant $kThemeArrow9pt 3)

(def-mactype :ThemePopupArrowSize (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Grow box directions                                                                      
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeGrowLeft 1)                 ;  can grow to the left 

(defconstant $kThemeGrowRight 2)                ;  can grow to the right 

(defconstant $kThemeGrowUp 4)                   ;  can grow up 
;  can grow down 

(defconstant $kThemeGrowDown 8)

(def-mactype :ThemeGrowDirection (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Button kinds                                                                             
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  Discussion:
;  *    ThemeButtonKinds
;  
; 
;    * Dynamically-sized push button kind. Prior to Mac OS X 10.3 all
;    * push button sizes could be determined dynamically: either they
;    * were smaller than normal size and therefore small or they were
;    * normal size. This constant will never describe a mini push button,
;    * regardless of associated bounds. Please use the explicitly-sized
;    * kThemePushButton{Normal,Small,Mini} constants.
;    

(defconstant $kThemePushButton 0)
(defconstant $kThemeCheckBox 1)
(defconstant $kThemeRadioButton 2)
; 
;    * Bevel button (obsolete)
;    

(defconstant $kThemeBevelButton 3)
; 
;    * Popup button without text (no label). See ThemeButtonAdornment for
;    * glyphs. The arrow button theme name is somewhat confusing. This is
;    * the primitive used to draw the control known as the disclosure
;    * button.
;    

(defconstant $kThemeArrowButton 4)
; 
;    * Dynamically-sized popup button kind. Prior to Mac OS X 10.3 all
;    * popup button sizes could be determined dynamically: either they
;    * were smaller than normal size and therefore small or they were
;    * normal size. This constant will never describe a mini popup
;    * button, regardless of associated bounds. Please use the
;    * explicitly-sized kThemePopupButton{Normal,Small,Mini} constants.
;    

(defconstant $kThemePopupButton 5)
(defconstant $kThemeDisclosureButton 6)
; 
;    * Increment/decrement buttons (no label). This is the primitive used
;    * to draw the LittleArrows control.
;    

(defconstant $kThemeIncDecButton 7)
; 
;    * Small-shadow bevel button
;    

(defconstant $kThemeSmallBevelButton 8)
; 
;    * Med-shadow bevel button
;    

(defconstant $kThemeMediumBevelButton 3)
; 
;    * Large-shadow bevel button
;    

(defconstant $kThemeLargeBevelButton 9)
; 
;    * Sort button for top of a list. This is the theme primitive used to
;    * draw the top of the columns in the data browser.
;    

(defconstant $kThemeListHeaderButton 10)
(defconstant $kThemeRoundButton 11)
(defconstant $kThemeLargeRoundButton 12)
(defconstant $kThemeSmallCheckBox 13)
(defconstant $kThemeSmallRadioButton 14)
(defconstant $kThemeRoundedBevelButton 15)
(defconstant $kThemeComboBox 16)
(defconstant $kThemeComboBoxSmall 17)
; 
;  *  Discussion:
;  *    New ThemeButtonKinds available on Mac OS X 10.3 and later.
;  

(defconstant $kThemeComboBoxMini 18)
(defconstant $kThemeMiniCheckBox 19)
(defconstant $kThemeMiniRadioButton 20)
; 
;    * This is the primitive used to draw the small variant of the
;    * LittleArrows control.
;    

(defconstant $kThemeIncDecButtonSmall 21)
; 
;    * This is the primitive used to draw the mini variant of the
;    * LittleArrows control.
;    

(defconstant $kThemeIncDecButtonMini 22)
; 
;    * The arrow button theme name is somewhat confusing. This is the
;    * primitive used to draw the small variant of the control known as
;    * the disclosure button.
;    

(defconstant $kThemeArrowButtonSmall 23)
; 
;    * The arrow button theme name is somewhat confusing. This is the
;    * primitive used to draw the mini variant of the control known as
;    * the disclosure button.
;    

(defconstant $kThemeArrowButtonMini 24)
; 
;    * Explicitly-sized normal push button kind. Prior to Mac OS X 10.3
;    * all push button sizes could be determined dynamically: either they
;    * were smaller than normal size and therefore small or they were
;    * normal size. Using this constant, an explicitly-sized normal push
;    * button can be specified.
;    

(defconstant $kThemePushButtonNormal 25)
; 
;    * Explicitly-sized small push button kind. Prior to Mac OS X 10.3
;    * all push button sizes could be determined dynamically: either they
;    * were smaller than normal size and therefore small or they were
;    * normal size. Using this constant, an explicitly-sized small push
;    * button can be specified.
;    

(defconstant $kThemePushButtonSmall 26)
; 
;    * Explicitly-sized mini push button kind. Prior to Mac OS X 10.3 all
;    * push button sizes could be determined dynamically: either they
;    * were smaller than normal size and therefore small or they were
;    * normal size. Since a mini variant was introduced in Mac OS X 10.3,
;    * smaller than normal size is can also mean mini. To avoid confusion
;    * with existing code, the mini variant will never be implicitly
;    * determined and must be explicity requested with the
;    * kThemePushButtonMini constant.
;    

(defconstant $kThemePushButtonMini 27)
; 
;    * Explicitly-sized normal popup button kind. Prior to Mac OS X 10.3
;    * all popup button sizes could be determined dynamically: either
;    * they were smaller than normal size and therefore small or they
;    * were normal size. Using this constant, an explicitly-sized normal
;    * popup button can be specified.
;    

(defconstant $kThemePopupButtonNormal 28)
; 
;    * Explicitly-sized small popup button kind. Prior to Mac OS X 10.3
;    * all popup button sizes could be determined dynamically: either
;    * they were smaller than normal size and therefore small or they
;    * were normal size. Using this constant, an explicitly-sized small
;    * popup button can be specified.
;    

(defconstant $kThemePopupButtonSmall 29)
; 
;    * Explicitly-sized mini popup button kind. Prior to Mac OS X 10.3
;    * all popup button sizes could be determined dynamically: either
;    * they were smaller than normal size and therefore small or they
;    * were normal size. Since a mini variant was introduced in Mac OS X
;    * 10.3, smaller than normal size is can also mean mini. To avoid
;    * confusion with existing code, the mini variant will never be
;    * implicitly determined and must be explicity requested with the
;    * kThemePopupButtonMini constant.
;    

(defconstant $kThemePopupButtonMini 30)
; 
;  *  Discussion:
;  *    These are legacy synonyms for previously defined
;  *    ThemeButtonKinds. Please use the modern constant names.
;  

(defconstant $kThemeNormalCheckBox 1)
(defconstant $kThemeNormalRadioButton 2)

(def-mactype :ThemeButtonKind (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Common button values                                                                     
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeButtonOff 0)
(defconstant $kThemeButtonOn 1)
(defconstant $kThemeButtonMixed 2)
(defconstant $kThemeDisclosureRight 0)
(defconstant $kThemeDisclosureDown 1)
(defconstant $kThemeDisclosureLeft 2)

(def-mactype :ThemeButtonValue (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Button adornment types                                                                   
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeAdornmentNone 0)
(defconstant $kThemeAdornmentDefault 1)         ;  if set, draw default ornamentation ( for push button and generic well ) 

(defconstant $kThemeAdornmentFocus 4)           ;  if set, draw focus 

(defconstant $kThemeAdornmentRightToLeft 16)    ;  if set, draw right to left label 

(defconstant $kThemeAdornmentDrawIndicatorOnly 32);  if set, don't draw or erase label ( radio, check, disclosure ) 

(defconstant $kThemeAdornmentHeaderButtonLeftNeighborSelected 64);  if set, draw the left border of the button as selected ( list header button only ) 

(defconstant $kThemeAdornmentHeaderButtonRightNeighborSelected #x80);  if set, draw the right border of the button ( list header button only ) 

(defconstant $kThemeAdornmentHeaderButtonSortUp #x100);  if set, draw the sort indicator pointing upward ( list header button only ) 

(defconstant $kThemeAdornmentHeaderMenuButton #x200);  if set, draw as a header menu button ( list header button only ) 

(defconstant $kThemeAdornmentHeaderButtonNoShadow #x400);  if set, draw the non-shadow area of the button ( list header button only ) 

(defconstant $kThemeAdornmentHeaderButtonShadowOnly #x800);  if set, draw the only the shadow area of the button ( list header button only ) 

(defconstant $kThemeAdornmentNoShadow #x400)    ;  old name 

(defconstant $kThemeAdornmentShadowOnly #x800)  ;  old name 

(defconstant $kThemeAdornmentArrowLeftArrow 64) ;  If set, draw a left arrow on the arrow button 

(defconstant $kThemeAdornmentArrowDownArrow #x80);  If set, draw a down arrow on the arrow button 

(defconstant $kThemeAdornmentArrowDoubleArrow #x100);  If set, draw a double arrow on the arrow button 
;  If set, draw a up arrow on the arrow button 

(defconstant $kThemeAdornmentArrowUpArrow #x200)

(def-mactype :ThemeButtonAdornment (find-mactype ':UInt16))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Button drawing info block                                                                
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
(defrecord ThemeButtonDrawInfo
   (state :UInt32)
   (value :UInt16)
   (adornment :UInt16)
)

;type name? (%define-record :ThemeButtonDrawInfo (find-record-descriptor ':ThemeButtonDrawInfo))

(def-mactype :ThemeButtonDrawInfoPtr (find-mactype '(:pointer :ThemeButtonDrawInfo)))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Sound Support                                                                            
;                                                                                           
;   X ALERT: Please note that none of the theme sound APIs currently function on X.         
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Sound classes                                                                            
;                                                                                           
;  You can use the constants below to set what sounds are active using the SetTheme API.    
;  Use these with the kThemeSoundMask tag.                                                  
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeNoSounds 0)
(defconstant $kThemeWindowSoundsMask 1)
(defconstant $kThemeMenuSoundsMask 2)
(defconstant $kThemeControlSoundsMask 4)
(defconstant $kThemeFinderSoundsMask 8)
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Drag Sounds                                                                              
;                                                                                           
;  Drag sounds are looped for the duration of the drag.                                     
;                                                                                           
;  Call BeginThemeDragSound at the start of the drag.                                       
;  Call EndThemeDragSound when the drag has finished.                                       
;                                                                                           
;  Note that in order to maintain a consistent user experience, only one drag sound may     
;  occur at a time.  The sound should be attached to a mouse action, start after the        
;  mouse goes down and stop when the mouse is released.                                     
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeDragSoundNone 0)
(defconstant $kThemeDragSoundMoveWindow :|wmov|)
(defconstant $kThemeDragSoundGrowWindow :|wgro|)
(defconstant $kThemeDragSoundMoveUtilWindow :|umov|)
(defconstant $kThemeDragSoundGrowUtilWindow :|ugro|)
(defconstant $kThemeDragSoundMoveDialog :|dmov|)
(defconstant $kThemeDragSoundMoveAlert :|amov|)
(defconstant $kThemeDragSoundMoveIcon :|imov|)
(defconstant $kThemeDragSoundSliderThumb :|slth|)
(defconstant $kThemeDragSoundSliderGhost :|slgh|)
(defconstant $kThemeDragSoundScrollBarThumb :|sbth|)
(defconstant $kThemeDragSoundScrollBarGhost :|sbgh|)
(defconstant $kThemeDragSoundScrollBarArrowDecreasing :|sbad|)
(defconstant $kThemeDragSoundScrollBarArrowIncreasing :|sbai|)
(defconstant $kThemeDragSoundDragging :|drag|)

(def-mactype :ThemeDragSoundKind (find-mactype ':OSType))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  State-change sounds                                                      
;                                                                           
;  State-change sounds are played asynchonously as a one-shot.              
;                                                                           
;  Call PlayThemeSound to play the sound.  The sound will play              
;  asynchronously until complete, then stop automatically.                  
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kThemeSoundNone 0)
(defconstant $kThemeSoundMenuOpen :|mnuo|)      ;  menu sounds 

(defconstant $kThemeSoundMenuClose :|mnuc|)
(defconstant $kThemeSoundMenuItemHilite :|mnui|)
(defconstant $kThemeSoundMenuItemRelease :|mnus|)
(defconstant $kThemeSoundWindowClosePress :|wclp|);  window sounds 

(defconstant $kThemeSoundWindowCloseEnter :|wcle|)
(defconstant $kThemeSoundWindowCloseExit :|wclx|)
(defconstant $kThemeSoundWindowCloseRelease :|wclr|)
(defconstant $kThemeSoundWindowZoomPress :|wzmp|)
(defconstant $kThemeSoundWindowZoomEnter :|wzme|)
(defconstant $kThemeSoundWindowZoomExit :|wzmx|)
(defconstant $kThemeSoundWindowZoomRelease :|wzmr|)
(defconstant $kThemeSoundWindowCollapsePress :|wcop|)
(defconstant $kThemeSoundWindowCollapseEnter :|wcoe|)
(defconstant $kThemeSoundWindowCollapseExit :|wcox|)
(defconstant $kThemeSoundWindowCollapseRelease :|wcor|)
(defconstant $kThemeSoundWindowDragBoundary :|wdbd|)
(defconstant $kThemeSoundUtilWinClosePress :|uclp|);  utility window sounds 

(defconstant $kThemeSoundUtilWinCloseEnter :|ucle|)
(defconstant $kThemeSoundUtilWinCloseExit :|uclx|)
(defconstant $kThemeSoundUtilWinCloseRelease :|uclr|)
(defconstant $kThemeSoundUtilWinZoomPress :|uzmp|)
(defconstant $kThemeSoundUtilWinZoomEnter :|uzme|)
(defconstant $kThemeSoundUtilWinZoomExit :|uzmx|)
(defconstant $kThemeSoundUtilWinZoomRelease :|uzmr|)
(defconstant $kThemeSoundUtilWinCollapsePress :|ucop|)
(defconstant $kThemeSoundUtilWinCollapseEnter :|ucoe|)
(defconstant $kThemeSoundUtilWinCollapseExit :|ucox|)
(defconstant $kThemeSoundUtilWinCollapseRelease :|ucor|)
(defconstant $kThemeSoundUtilWinDragBoundary :|udbd|)
(defconstant $kThemeSoundWindowOpen :|wopn|)    ;  window close and zoom action 

(defconstant $kThemeSoundWindowClose :|wcls|)
(defconstant $kThemeSoundWindowZoomIn :|wzmi|)
(defconstant $kThemeSoundWindowZoomOut :|wzmo|)
(defconstant $kThemeSoundWindowCollapseUp :|wcol|)
(defconstant $kThemeSoundWindowCollapseDown :|wexp|)
(defconstant $kThemeSoundWindowActivate :|wact|)
(defconstant $kThemeSoundUtilWindowOpen :|uopn|)
(defconstant $kThemeSoundUtilWindowClose :|ucls|)
(defconstant $kThemeSoundUtilWindowZoomIn :|uzmi|)
(defconstant $kThemeSoundUtilWindowZoomOut :|uzmo|)
(defconstant $kThemeSoundUtilWindowCollapseUp :|ucol|)
(defconstant $kThemeSoundUtilWindowCollapseDown :|uexp|)
(defconstant $kThemeSoundUtilWindowActivate :|uact|)
(defconstant $kThemeSoundDialogOpen :|dopn|)
(defconstant $kThemeSoundDialogClose :|dlgc|)
(defconstant $kThemeSoundAlertOpen :|aopn|)
(defconstant $kThemeSoundAlertClose :|altc|)
(defconstant $kThemeSoundPopupWindowOpen :|pwop|)
(defconstant $kThemeSoundPopupWindowClose :|pwcl|)
(defconstant $kThemeSoundButtonPress :|btnp|)   ;  button 

(defconstant $kThemeSoundButtonEnter :|btne|)
(defconstant $kThemeSoundButtonExit :|btnx|)
(defconstant $kThemeSoundButtonRelease :|btnr|)
(defconstant $kThemeSoundDefaultButtonPress :|dbtp|);  default button 

(defconstant $kThemeSoundDefaultButtonEnter :|dbte|)
(defconstant $kThemeSoundDefaultButtonExit :|dbtx|)
(defconstant $kThemeSoundDefaultButtonRelease :|dbtr|)
(defconstant $kThemeSoundCancelButtonPress :|cbtp|);  cancel button 

(defconstant $kThemeSoundCancelButtonEnter :|cbte|)
(defconstant $kThemeSoundCancelButtonExit :|cbtx|)
(defconstant $kThemeSoundCancelButtonRelease :|cbtr|)
(defconstant $kThemeSoundCheckboxPress :|chkp|) ;  checkboxes 

(defconstant $kThemeSoundCheckboxEnter :|chke|)
(defconstant $kThemeSoundCheckboxExit :|chkx|)
(defconstant $kThemeSoundCheckboxRelease :|chkr|)
(defconstant $kThemeSoundRadioPress :|radp|)    ;  radio buttons 

(defconstant $kThemeSoundRadioEnter :|rade|)
(defconstant $kThemeSoundRadioExit :|radx|)
(defconstant $kThemeSoundRadioRelease :|radr|)
(defconstant $kThemeSoundScrollArrowPress :|sbap|);  scroll bars 

(defconstant $kThemeSoundScrollArrowEnter :|sbae|)
(defconstant $kThemeSoundScrollArrowExit :|sbax|)
(defconstant $kThemeSoundScrollArrowRelease :|sbar|)
(defconstant $kThemeSoundScrollEndOfTrack :|sbte|)
(defconstant $kThemeSoundScrollTrackPress :|sbtp|)
(defconstant $kThemeSoundSliderEndOfTrack :|slte|);  sliders 

(defconstant $kThemeSoundSliderTrackPress :|sltp|)
(defconstant $kThemeSoundBalloonOpen :|blno|)   ;  help balloons 

(defconstant $kThemeSoundBalloonClose :|blnc|)
(defconstant $kThemeSoundBevelPress :|bevp|)    ;  Bevel buttons 

(defconstant $kThemeSoundBevelEnter :|beve|)
(defconstant $kThemeSoundBevelExit :|bevx|)
(defconstant $kThemeSoundBevelRelease :|bevr|)
(defconstant $kThemeSoundLittleArrowUpPress :|laup|);  Little Arrows 

(defconstant $kThemeSoundLittleArrowDnPress :|ladp|)
(defconstant $kThemeSoundLittleArrowEnter :|lare|)
(defconstant $kThemeSoundLittleArrowExit :|larx|)
(defconstant $kThemeSoundLittleArrowUpRelease :|laur|)
(defconstant $kThemeSoundLittleArrowDnRelease :|ladr|)
(defconstant $kThemeSoundPopupPress :|popp|)    ;  Popup Buttons 

(defconstant $kThemeSoundPopupEnter :|pope|)
(defconstant $kThemeSoundPopupExit :|popx|)
(defconstant $kThemeSoundPopupRelease :|popr|)
(defconstant $kThemeSoundDisclosurePress :|dscp|);  Disclosure Buttons 

(defconstant $kThemeSoundDisclosureEnter :|dsce|)
(defconstant $kThemeSoundDisclosureExit :|dscx|)
(defconstant $kThemeSoundDisclosureRelease :|dscr|)
(defconstant $kThemeSoundTabPressed :|tabp|)    ;  Tabs 

(defconstant $kThemeSoundTabEnter :|tabe|)
(defconstant $kThemeSoundTabExit :|tabx|)
(defconstant $kThemeSoundTabRelease :|tabr|)
(defconstant $kThemeSoundDragTargetHilite :|dthi|);  drag manager 

(defconstant $kThemeSoundDragTargetUnhilite :|dtuh|)
(defconstant $kThemeSoundDragTargetDrop :|dtdr|)
(defconstant $kThemeSoundEmptyTrash :|ftrs|)    ;  finder 

(defconstant $kThemeSoundSelectItem :|fsel|)
(defconstant $kThemeSoundNewItem :|fnew|)
(defconstant $kThemeSoundReceiveDrop :|fdrp|)
(defconstant $kThemeSoundCopyDone :|fcpd|)
(defconstant $kThemeSoundResolveAlias :|fral|)
(defconstant $kThemeSoundLaunchApp :|flap|)
(defconstant $kThemeSoundDiskInsert :|dski|)
(defconstant $kThemeSoundDiskEject :|dske|)
(defconstant $kThemeSoundFinderDragOnIcon :|fdon|)
(defconstant $kThemeSoundFinderDragOffIcon :|fdof|)

(def-mactype :ThemeSoundKind (find-mactype ':OSType))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Window Metrics                                                                           
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   Window metrics are used by the Appearance manager to fill in the blanks necessary to    
;   draw windows. If a value is not appropriate for the type of window, be sure to fill in  
;   the slot in the structure with zero.    For the popupTabOffset parameter, you can pass a
;   real value based on the left edge of the window. This value might be interpreted in a   
;   different manner when depending on the value of the popupTabPosition field. The values  
;   you can pass into popupTabPosition are:                                                 
;                                                                                           
;   kThemePopupTabNormalPosition                                                            
;       Starts the tab left edge at the position indicated by the popupTabOffset field.     
;                                                                                           
;   kThemePopupTabCenterOnWindow                                                            
;       tells us to ignore the offset field and instead simply center the width of the      
;       handle on the window.                                                               
;                                                                                           
;   kThemePopupTabCenterOnOffset                                                            
;       tells us to center the width of the handle around the value passed in offset.       
;                                                                                           
;   The Appearance Manager will try its best to accomodate the requested placement, but may 
;   move the handle slightly to make it fit correctly.                                      
;                                                                                           

(defconstant $kThemePopupTabNormalPosition 0)
(defconstant $kThemePopupTabCenterOnWindow 1)
(defconstant $kThemePopupTabCenterOnOffset 2)
(defrecord ThemeWindowMetrics
   (metricSize :UInt16)                         ;  should be always be sizeof( ThemeWindowMetrics )
   (titleHeight :SInt16)
   (titleWidth :SInt16)
   (popupTabOffset :SInt16)
   (popupTabWidth :SInt16)
   (popupTabPosition :UInt16)
)

;type name? (%define-record :ThemeWindowMetrics (find-record-descriptor ':ThemeWindowMetrics))

(def-mactype :ThemeWindowMetricsPtr (find-mactype '(:pointer :ThemeWindowMetrics)))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Theme Metrics                                                                            
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  Discussion:
;  *    Theme metrics allow you to find out sizes of things in the
;  *    current environment, such as how wide a scroll bar is, etc.
;  
; 
;    * The width (or height if horizontal) of a scroll bar.
;    

(defconstant $kThemeMetricScrollBarWidth 0)
; 
;    * The width (or height if horizontal) of a small scroll bar.
;    

(defconstant $kThemeMetricSmallScrollBarWidth 1)
; 
;    * The height of the non-label part of a check box control.
;    

(defconstant $kThemeMetricCheckBoxHeight 2)
; 
;    * The height of the non-label part of a radio button control.
;    

(defconstant $kThemeMetricRadioButtonHeight 3)
; 
;    * The amount of white space surrounding the text Rect of the text
;    * inside of an Edit Text control.  If you select all of the text in
;    * an Edit Text control, you can see the white space. The metric is
;    * the number of pixels, per side, that the text Rect is outset to
;    * create the whitespace Rect.
;    

(defconstant $kThemeMetricEditTextWhitespace 4)
; 
;    * The thickness of the Edit Text frame that surrounds the whitespace
;    * Rect (that is surrounding the text Rect). The metric is the number
;    * of pixels, per side, that the frame Rect is outset from the
;    * whitespace Rect.
;    

(defconstant $kThemeMetricEditTextFrameOutset 5)
; 
;    * The number of pixels that the list box frame is outset from the
;    * content of the list box.
;    

(defconstant $kThemeMetricListBoxFrameOutset 6)
; 
;    * This is a deprecated metric.  Don't use it.  It used to describe
;    * how far the focus rect used to draw from a control, but control
;    * focus drawing no longer uses this information to draw its focus.
;    

(defconstant $kThemeMetricFocusRectOutset 7)
; 
;    * The thickness of the frame drawn by DrawThemeGenericWell.
;    

(defconstant $kThemeMetricImageWellThickness 8)
; 
;    * The number of pixels a scrollbar should overlap (actually
;    * underlap) any bounding box which surrounds it and scrollable
;    * content. This also includes the window frame when a scrolbar is
;    * along an edge of the window.
;    

(defconstant $kThemeMetricScrollBarOverlap 9)
; 
;    * The height of the large tab of a tab control.
;    

(defconstant $kThemeMetricLargeTabHeight 10)
; 
;    * The width of the caps (end pieces) of the large tabs of a tab
;    * control.
;    

(defconstant $kThemeMetricLargeTabCapsWidth 11)
; 
;    * The amount to add to the tab height (kThemeMetricLargeTabHeight)
;    * to find out the rectangle height to use with the various Tab
;    * drawing primitives. This amount is also the amount that each tab
;    * overlaps the tab pane.
;    

(defconstant $kThemeMetricTabFrameOverlap 12)
; 
;    * If less than zero, this indicates that the text should be centered
;    * on each tab. If greater than zero, the text should be justified
;    * (according to the system script direction) and the amount is the
;    * offset from the appropriate edge at which the text should start
;    * drawing.
;    

(defconstant $kThemeMetricTabIndentOrStyle 13)
; 
;    * The amount of space that every tab's drawing rectangle overlaps
;    * the one on either side of it.
;    

(defconstant $kThemeMetricTabOverlap 14)
; 
;    * The height of the small tab of a tab control.  This includes the
;    * pixels that overlap the tab pane and/or tab pane bar.
;    

(defconstant $kThemeMetricSmallTabHeight 15)
; 
;    * The width of the caps (end pieces) of the small tabs of a tab
;    * control.
;    

(defconstant $kThemeMetricSmallTabCapsWidth 16)
; 
;    * The height and the width of the push button control.
;    

(defconstant $kThemeMetricPushButtonHeight 19)
; 
;    * The height of the list header field of the data browser control.
;    

(defconstant $kThemeMetricListHeaderHeight 20)
; 
;    * The height of a disclosure triangle control.  This triangle is the
;    * not the center of the disclosure button, but its own control.
;    

(defconstant $kThemeMetricDisclosureTriangleHeight 25)
; 
;    * The width of a disclosure triangle control.
;    

(defconstant $kThemeMetricDisclosureTriangleWidth 26)
; 
;    * The height of a little arrows control.
;    

(defconstant $kThemeMetricLittleArrowsHeight 27)
; 
;    * The width of a little arrows control.
;    

(defconstant $kThemeMetricLittleArrowsWidth 28)
; 
;    * The height of a popup button control.
;    

(defconstant $kThemeMetricPopupButtonHeight 30)
; 
;    * The height of a small popup button control.
;    

(defconstant $kThemeMetricSmallPopupButtonHeight 31)
; 
;    * The height of the large progress bar, not including its shadow.
;    

(defconstant $kThemeMetricLargeProgressBarThickness 32)
; 
;    * This metric is not used.
;    

(defconstant $kThemeMetricPullDownHeight 33)
; 
;    * This metric is not used.
;    

(defconstant $kThemeMetricSmallPullDownHeight 34)
; 
;    * The height of the window grow box control.
;    

(defconstant $kThemeMetricResizeControlHeight 38)
; 
;    * The width of the window grow box control.
;    

(defconstant $kThemeMetricSmallResizeControlHeight 39)
; 
;    * The height of the horizontal slider control.
;    

(defconstant $kThemeMetricHSliderHeight 41)
; 
;    * The height of the tick marks for a horizontal slider control.
;    

(defconstant $kThemeMetricHSliderTickHeight 42)
; 
;    * The width of the vertical slider control.
;    

(defconstant $kThemeMetricVSliderWidth 45)
; 
;    * The width of the tick marks for a vertical slider control.
;    

(defconstant $kThemeMetricVSliderTickWidth 46)
; 
;    * The height of the title bar widgets (grow, close, and zoom boxes)
;    * for a document window.
;    

(defconstant $kThemeMetricTitleBarControlsHeight 49)
; 
;    * The width of the non-label part of a check box control.
;    

(defconstant $kThemeMetricCheckBoxWidth 50)
; 
;    * The width of the non-label part of a radio button control.
;    

(defconstant $kThemeMetricRadioButtonWidth 52)
; 
;    * The height of the normal bar, not including its shadow.
;    

(defconstant $kThemeMetricNormalProgressBarThickness 58)
; 
;    * The number of pixels of shadow depth drawn below the progress bar.
;    

(defconstant $kThemeMetricProgressBarShadowOutset 59)
; 
;    * The number of pixels of shadow depth drawn below the small
;    * progress bar.
;    

(defconstant $kThemeMetricSmallProgressBarShadowOutset 60)
; 
;    * The number of pixels that the content of a primary group box is
;    * from the bounds of the control.
;    

(defconstant $kThemeMetricPrimaryGroupBoxContentInset 61)
; 
;    * The number of pixels that the content of a secondary group box is
;    * from the bounds of the control.
;    

(defconstant $kThemeMetricSecondaryGroupBoxContentInset 62)
; 
;    * Width allocated to draw the mark character in a menu.
;    

(defconstant $kThemeMetricMenuMarkColumnWidth 63)
; 
;    * Width allocated for the mark character in a menu item when the
;    * menu has kMenuAttrExcludesMarkColumn.
;    

(defconstant $kThemeMetricMenuExcludedMarkColumnWidth 64)
; 
;    * Indent into the interior of the mark column at which the mark
;    * character is drawn.
;    

(defconstant $kThemeMetricMenuMarkIndent 65)
; 
;    * Whitespace at the leading edge of menu item text.
;    

(defconstant $kThemeMetricMenuTextLeadingEdgeMargin 66)
; 
;    * Whitespace at the trailing edge of menu item text.
;    

(defconstant $kThemeMetricMenuTextTrailingEdgeMargin 67)
; 
;    * Width per indent level (set by SetMenuItemIndent) of a menu item.
;    

(defconstant $kThemeMetricMenuIndentWidth 68)
; 
;    * Whitespace at the trailing edge of a menu icon (if the item also
;    * has text).
;    

(defconstant $kThemeMetricMenuIconTrailingEdgeMargin 69)
; 
;  *  Discussion:
;  *    The following metrics are only available in OS X.
;  
; 
;    * The height of a disclosure button.
;    

(defconstant $kThemeMetricDisclosureButtonHeight 17)
; 
;    * The height and the width of the round button control.
;    

(defconstant $kThemeMetricRoundButtonSize 18)
; 
;    * The height of the non-label part of a small check box control.
;    

(defconstant $kThemeMetricSmallCheckBoxHeight 21)
; 
;    * The width of a disclosure button.
;    

(defconstant $kThemeMetricDisclosureButtonWidth 22)
; 
;    * The height of a small disclosure button.
;    

(defconstant $kThemeMetricSmallDisclosureButtonHeight 23)
; 
;    * The width of a small disclosure button.
;    

(defconstant $kThemeMetricSmallDisclosureButtonWidth 24)
; 
;    * The height (or width if vertical) of a pane splitter.
;    

(defconstant $kThemeMetricPaneSplitterHeight 29)
; 
;    * The height of the small push button control.
;    

(defconstant $kThemeMetricSmallPushButtonHeight 35)
; 
;    * The height of the non-label part of a small radio button control.
;    

(defconstant $kThemeMetricSmallRadioButtonHeight 36)
; 
;    * The height of the relevance indicator control.
;    

(defconstant $kThemeMetricRelevanceIndicatorHeight 37)
; 
;    * The height and the width of the large round button control.
;    

(defconstant $kThemeMetricLargeRoundButtonSize 40)
; 
;    * The height of the small, horizontal slider control.
;    

(defconstant $kThemeMetricSmallHSliderHeight 43)
; 
;    * The height of the tick marks for a small, horizontal slider
;    * control.
;    

(defconstant $kThemeMetricSmallHSliderTickHeight 44)
; 
;    * The width of the small, vertical slider control.
;    

(defconstant $kThemeMetricSmallVSliderWidth 47)
; 
;    * The width of the tick marks for a small, vertical slider control.
;    

(defconstant $kThemeMetricSmallVSliderTickWidth 48)
; 
;    * The width of the non-label part of a small check box control.
;    

(defconstant $kThemeMetricSmallCheckBoxWidth 51)
; 
;    * The width of the non-label part of a small radio button control.
;    

(defconstant $kThemeMetricSmallRadioButtonWidth 53)
; 
;    * The minimum width of the thumb of a small, horizontal slider
;    * control.
;    

(defconstant $kThemeMetricSmallHSliderMinThumbWidth 54)
; 
;    * The minimum width of the thumb of a small, vertical slider control.
;    

(defconstant $kThemeMetricSmallVSliderMinThumbHeight 55)
; 
;    * The offset of the tick marks from the appropriate side of a small
;    * horizontal slider control.
;    

(defconstant $kThemeMetricSmallHSliderTickOffset 56)
; 
;    * The offset of the tick marks from the appropriate side of a small
;    * vertical slider control.
;    

(defconstant $kThemeMetricSmallVSliderTickOffset 57)
; 
;  *  Discussion:
;  *    The following metrics are only available in Mac OS X 10.3 and
;  *    later.
;  

(defconstant $kThemeMetricComboBoxLargeBottomShadowOffset 70)
(defconstant $kThemeMetricComboBoxLargeRightShadowOffset 71)
(defconstant $kThemeMetricComboBoxSmallBottomShadowOffset 72)
(defconstant $kThemeMetricComboBoxSmallRightShadowOffset 73)
(defconstant $kThemeMetricComboBoxLargeDisclosureWidth 74)
(defconstant $kThemeMetricComboBoxSmallDisclosureWidth 75)
(defconstant $kThemeMetricRoundTextFieldContentInsetLeft 76)
(defconstant $kThemeMetricRoundTextFieldContentInsetRight 77)
(defconstant $kThemeMetricRoundTextFieldContentInsetBottom 78)
(defconstant $kThemeMetricRoundTextFieldContentInsetTop 79)
(defconstant $kThemeMetricRoundTextFieldContentHeight 80)
(defconstant $kThemeMetricComboBoxMiniBottomShadowOffset 81)
(defconstant $kThemeMetricComboBoxMiniDisclosureWidth 82)
(defconstant $kThemeMetricComboBoxMiniRightShadowOffset 83)
(defconstant $kThemeMetricLittleArrowsMiniHeight 84)
(defconstant $kThemeMetricLittleArrowsMiniWidth 85)
(defconstant $kThemeMetricLittleArrowsSmallHeight 86)
(defconstant $kThemeMetricLittleArrowsSmallWidth 87)
(defconstant $kThemeMetricMiniCheckBoxHeight 88)
(defconstant $kThemeMetricMiniCheckBoxWidth 89)
(defconstant $kThemeMetricMiniDisclosureButtonHeight 90)
(defconstant $kThemeMetricMiniDisclosureButtonWidth 91)
(defconstant $kThemeMetricMiniHSliderHeight 92)
(defconstant $kThemeMetricMiniHSliderMinThumbWidth 93)
(defconstant $kThemeMetricMiniHSliderTickHeight 94)
(defconstant $kThemeMetricMiniHSliderTickOffset 95)
(defconstant $kThemeMetricMiniPopupButtonHeight 96)
(defconstant $kThemeMetricMiniPullDownHeight 97)
(defconstant $kThemeMetricMiniPushButtonHeight 98)
(defconstant $kThemeMetricMiniRadioButtonHeight 99)
(defconstant $kThemeMetricMiniRadioButtonWidth 100)
(defconstant $kThemeMetricMiniTabCapsWidth 101)
(defconstant $kThemeMetricMiniTabFrameOverlap 102)
(defconstant $kThemeMetricMiniTabHeight 103)
(defconstant $kThemeMetricMiniTabOverlap 104)
(defconstant $kThemeMetricMiniVSliderMinThumbHeight 105)
(defconstant $kThemeMetricMiniVSliderTickOffset 106)
(defconstant $kThemeMetricMiniVSliderTickWidth 107)
(defconstant $kThemeMetricMiniVSliderWidth 108)
(defconstant $kThemeMetricRoundTextFieldContentInsetWithIconLeft 109)
(defconstant $kThemeMetricRoundTextFieldContentInsetWithIconRight 110)
(defconstant $kThemeMetricRoundTextFieldMiniContentHeight 111)
(defconstant $kThemeMetricRoundTextFieldMiniContentInsetBottom 112)
(defconstant $kThemeMetricRoundTextFieldMiniContentInsetLeft 113)
(defconstant $kThemeMetricRoundTextFieldMiniContentInsetRight 114)
(defconstant $kThemeMetricRoundTextFieldMiniContentInsetTop 115)
(defconstant $kThemeMetricRoundTextFieldMiniContentInsetWithIconLeft 116)
(defconstant $kThemeMetricRoundTextFieldMiniContentInsetWithIconRight 117)
(defconstant $kThemeMetricRoundTextFieldSmallContentHeight 118)
(defconstant $kThemeMetricRoundTextFieldSmallContentInsetBottom 119)
(defconstant $kThemeMetricRoundTextFieldSmallContentInsetLeft 120)
(defconstant $kThemeMetricRoundTextFieldSmallContentInsetRight 121)
(defconstant $kThemeMetricRoundTextFieldSmallContentInsetTop 122)
(defconstant $kThemeMetricRoundTextFieldSmallContentInsetWithIconLeft 123)
(defconstant $kThemeMetricRoundTextFieldSmallContentInsetWithIconRight 124)
(defconstant $kThemeMetricSmallTabFrameOverlap 125)
(defconstant $kThemeMetricSmallTabOverlap 126)
; 
;    * The height of a small pane splitter. Should only be used in a
;    * window with thick borders, like a metal window.
;    

(defconstant $kThemeMetricSmallPaneSplitterHeight 127)

(def-mactype :ThemeMetric (find-mactype ':UInt32))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Drawing State                                                                            
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(def-mactype :ThemeDrawingState (find-mactype '(:pointer :OpaqueThemeDrawingState)))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Callback procs                                                                           
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(def-mactype :ThemeTabTitleDrawProcPtr (find-mactype ':pointer)); (const Rect * bounds , ThemeTabStyle style , ThemeTabDirection direction , SInt16 depth , Boolean isColorDev , UInt32 userData)

(def-mactype :ThemeEraseProcPtr (find-mactype ':pointer)); (const Rect * bounds , UInt32 eraseData , SInt16 depth , Boolean isColorDev)

(def-mactype :ThemeButtonDrawProcPtr (find-mactype ':pointer)); (const Rect * bounds , ThemeButtonKind kind , const ThemeButtonDrawInfo * info , UInt32 userData , SInt16 depth , Boolean isColorDev)

(def-mactype :WindowTitleDrawingProcPtr (find-mactype ':pointer)); (const Rect * bounds , SInt16 depth , Boolean colorDevice , UInt32 userData)

(def-mactype :ThemeIteratorProcPtr (find-mactype ':pointer)); (ConstStr255Param inFileName , SInt16 resID , Collection inThemeSettings , void * inUserData)

(def-mactype :ThemeTabTitleDrawUPP (find-mactype '(:pointer :OpaqueThemeTabTitleDrawProcPtr)))

(def-mactype :ThemeEraseUPP (find-mactype '(:pointer :OpaqueThemeEraseProcPtr)))

(def-mactype :ThemeButtonDrawUPP (find-mactype '(:pointer :OpaqueThemeButtonDrawProcPtr)))

(def-mactype :WindowTitleDrawingUPP (find-mactype '(:pointer :OpaqueWindowTitleDrawingProcPtr)))

(def-mactype :ThemeIteratorUPP (find-mactype '(:pointer :OpaqueThemeIteratorProcPtr)))
; 
;  *  NewThemeTabTitleDrawUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewThemeTabTitleDrawUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueThemeTabTitleDrawProcPtr)
() )
; 
;  *  NewThemeEraseUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewThemeEraseUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueThemeEraseProcPtr)
() )
; 
;  *  NewThemeButtonDrawUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewThemeButtonDrawUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueThemeButtonDrawProcPtr)
() )
; 
;  *  NewWindowTitleDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewWindowTitleDrawingUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowTitleDrawingProcPtr)
() )
; 
;  *  NewThemeIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewThemeIteratorUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueThemeIteratorProcPtr)
() )
; 
;  *  DisposeThemeTabTitleDrawUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeThemeTabTitleDrawUPP" 
   ((userUPP (:pointer :OpaqueThemeTabTitleDrawProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeThemeEraseUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeThemeEraseUPP" 
   ((userUPP (:pointer :OpaqueThemeEraseProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeThemeButtonDrawUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeThemeButtonDrawUPP" 
   ((userUPP (:pointer :OpaqueThemeButtonDrawProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeWindowTitleDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeWindowTitleDrawingUPP" 
   ((userUPP (:pointer :OpaqueWindowTitleDrawingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeThemeIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeThemeIteratorUPP" 
   ((userUPP (:pointer :OpaqueThemeIteratorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeThemeTabTitleDrawUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeThemeTabTitleDrawUPP" 
   ((bounds (:pointer :Rect))
    (style :UInt16)
    (direction :UInt16)
    (depth :SInt16)
    (isColorDev :Boolean)
    (userData :UInt32)
    (userUPP (:pointer :OpaqueThemeTabTitleDrawProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeThemeEraseUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeThemeEraseUPP" 
   ((bounds (:pointer :Rect))
    (eraseData :UInt32)
    (depth :SInt16)
    (isColorDev :Boolean)
    (userUPP (:pointer :OpaqueThemeEraseProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeThemeButtonDrawUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeThemeButtonDrawUPP" 
   ((bounds (:pointer :Rect))
    (kind :UInt16)
    (info (:pointer :ThemeButtonDrawInfo))
    (userData :UInt32)
    (depth :SInt16)
    (isColorDev :Boolean)
    (userUPP (:pointer :OpaqueThemeButtonDrawProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeWindowTitleDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeWindowTitleDrawingUPP" 
   ((bounds (:pointer :Rect))
    (depth :SInt16)
    (colorDevice :Boolean)
    (userData :UInt32)
    (userUPP (:pointer :OpaqueWindowTitleDrawingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeThemeIteratorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeThemeIteratorUPP" 
   ((inFileName (:pointer :STR255))
    (resID :SInt16)
    (inThemeSettings (:pointer :OpaqueCollection))
    (inUserData :pointer)
    (userUPP (:pointer :OpaqueThemeIteratorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Menu Drawing callbacks                                                           
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(def-mactype :MenuTitleDrawingProcPtr (find-mactype ':pointer)); (const Rect * inBounds , SInt16 inDepth , Boolean inIsColorDevice , SInt32 inUserData)

(def-mactype :MenuItemDrawingProcPtr (find-mactype ':pointer)); (const Rect * inBounds , SInt16 inDepth , Boolean inIsColorDevice , SInt32 inUserData)

(def-mactype :MenuTitleDrawingUPP (find-mactype '(:pointer :OpaqueMenuTitleDrawingProcPtr)))

(def-mactype :MenuItemDrawingUPP (find-mactype '(:pointer :OpaqueMenuItemDrawingProcPtr)))
; 
;  *  NewMenuTitleDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMenuTitleDrawingUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMenuTitleDrawingProcPtr)
() )
; 
;  *  NewMenuItemDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMenuItemDrawingUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMenuItemDrawingProcPtr)
() )
; 
;  *  DisposeMenuTitleDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMenuTitleDrawingUPP" 
   ((userUPP (:pointer :OpaqueMenuTitleDrawingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMenuItemDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMenuItemDrawingUPP" 
   ((userUPP (:pointer :OpaqueMenuItemDrawingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeMenuTitleDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMenuTitleDrawingUPP" 
   ((inBounds (:pointer :Rect))
    (inDepth :SInt16)
    (inIsColorDevice :Boolean)
    (inUserData :SInt32)
    (userUPP (:pointer :OpaqueMenuTitleDrawingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeMenuItemDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMenuItemDrawingUPP" 
   ((inBounds (:pointer :Rect))
    (inDepth :SInt16)
    (inIsColorDevice :Boolean)
    (inUserData :SInt32)
    (userUPP (:pointer :OpaqueMenuItemDrawingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   Appearance Manager APIs                                                         
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Registering Appearance-Savvy Applications 
; 
;  *  RegisterAppearanceClient()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_RegisterAppearanceClient" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  UnregisterAppearanceClient()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_UnregisterAppearanceClient" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  IsAppearanceClient()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_IsAppearanceClient" 
   ((process (:pointer :ProcessSerialNumber))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; ****************************************************************************
;     NOTES ON THEME BRUSHES
;     Theme brushes can be either colors or patterns, depending on the theme.
;     Because of this, you should be prepared to handle the case where a brush
;     is a pattern and save and restore the pnPixPat and bkPixPat fields of
;     your GrafPorts when saving the fore and back colors. Also, since patterns
;     in bkPixPat override the background color of the window, you should use
;     BackPat to set your background pattern to a normal white pattern. This
;     will ensure that you can use RGBBackColor to set your back color to white,
;     call EraseRect and get the expected results.
; ****************************************************************************
; 
;  *  SetThemePen()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetThemePen" 
   ((inBrush :SInt16)
    (inDepth :SInt16)
    (inIsColorDevice :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetThemeBackground()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetThemeBackground" 
   ((inBrush :SInt16)
    (inDepth :SInt16)
    (inIsColorDevice :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetThemeTextColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetThemeTextColor" 
   ((inColor :SInt16)
    (inDepth :SInt16)
    (inIsColorDevice :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetThemeWindowBackground() has moved to MacWindows.h
;  
;  Window Placards, Headers and Frames 
; 
;  *  DrawThemeWindowHeader()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeWindowHeader" 
   ((inRect (:pointer :Rect))
    (inState :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeWindowListViewHeader()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeWindowListViewHeader" 
   ((inRect (:pointer :Rect))
    (inState :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemePlacard()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemePlacard" 
   ((inRect (:pointer :Rect))
    (inState :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeEditTextFrame()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeEditTextFrame" 
   ((inRect (:pointer :Rect))
    (inState :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeListBoxFrame()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeListBoxFrame" 
   ((inRect (:pointer :Rect))
    (inState :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Keyboard Focus Drawing 
; 
;  *  DrawThemeFocusRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeFocusRect" 
   ((inRect (:pointer :Rect))
    (inHasFocus :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Dialog Group Boxes and Separators 
; 
;  *  DrawThemePrimaryGroup()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemePrimaryGroup" 
   ((inRect (:pointer :Rect))
    (inState :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeSecondaryGroup()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeSecondaryGroup" 
   ((inRect (:pointer :Rect))
    (inState :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeSeparator()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeSeparator" 
   ((inRect (:pointer :Rect))
    (inState :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ BEGIN APPEARANCE 1.0.1 ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  The following Appearance Manager APIs are only available 
;  in Appearance 1.0.1 or later                             
; 
;  *  DrawThemeModelessDialogFrame()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeModelessDialogFrame" 
   ((inRect (:pointer :Rect))
    (inState :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeGenericWell()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeGenericWell" 
   ((inRect (:pointer :Rect))
    (inState :UInt32)
    (inFillCenter :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeFocusRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeFocusRegion" 
   ((inRegion (:pointer :OpaqueRgnHandle))
    (inHasFocus :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  IsThemeInColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_IsThemeInColor" 
   ((inDepth :SInt16)
    (inIsColorDevice :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  IMPORTANT: GetThemeAccentColors will only work in the platinum theme. Any other theme will 
;  most likely return an error 
; 
;  *  GetThemeAccentColors()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetThemeAccentColors" 
   ((outColors (:pointer :CTABHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeMenuBarBackground()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeMenuBarBackground" 
   ((inBounds (:pointer :Rect))
    (inState :UInt16)
    (inAttributes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeMenuTitle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeMenuTitle" 
   ((inMenuBarRect (:pointer :Rect))
    (inTitleRect (:pointer :Rect))
    (inState :UInt16)
    (inAttributes :UInt32)
    (inTitleProc (:pointer :OpaqueMenuTitleDrawingProcPtr));  can be NULL 
    (inTitleData :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeMenuBarHeight()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetThemeMenuBarHeight" 
   ((outHeight (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeMenuBackground()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeMenuBackground" 
   ((inMenuRect (:pointer :Rect))
    (inMenuType :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeMenuBackgroundRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetThemeMenuBackgroundRegion" 
   ((inMenuRect (:pointer :Rect))
    (menuType :UInt16)
    (region (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeMenuItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeMenuItem" 
   ((inMenuRect (:pointer :Rect))
    (inItemRect (:pointer :Rect))
    (inVirtualMenuTop :SInt16)
    (inVirtualMenuBottom :SInt16)
    (inState :UInt16)
    (inItemType :UInt16)
    (inDrawProc (:pointer :OpaqueMenuItemDrawingProcPtr));  can be NULL 
    (inUserData :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeMenuSeparator()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawThemeMenuSeparator" 
   ((inItemRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeMenuSeparatorHeight()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetThemeMenuSeparatorHeight" 
   ((outHeight (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeMenuItemExtra()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetThemeMenuItemExtra" 
   ((inItemType :UInt16)
    (outHeight (:pointer :SInt16))
    (outWidth (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeMenuTitleExtra()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetThemeMenuTitleExtra" 
   ((outWidth (:pointer :SInt16))
    (inIsSquished :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ BEGIN APPEARANCE 1.1 ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ THEME SWITCHING ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;                                                                                                   
;   X ALERT: Please note that Get/SetTheme are severely neutered under Mac OS X at present.         
;            See the note above regarding what collection tags are supported under X.               
; 
;  *  GetTheme()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetTheme" 
   ((ioCollection (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetTheme()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_SetTheme" 
   ((ioCollection (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  IterateThemes()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_IterateThemes" 
   ((inProc (:pointer :OpaqueThemeIteratorProcPtr))
    (inUserData :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ TABS ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  DrawThemeTabPane()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemeTabPane" 
   ((inRect (:pointer :Rect))
    (inState :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeTab()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemeTab" 
   ((inRect (:pointer :Rect))
    (inStyle :UInt16)
    (inDirection :UInt16)
    (labelProc (:pointer :OpaqueThemeTabTitleDrawProcPtr));  can be NULL 
    (userData :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeTabRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeTabRegion" 
   ((inRect (:pointer :Rect))
    (inStyle :UInt16)
    (inDirection :UInt16)
    (ioRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ CURSORS ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  SetThemeCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_SetThemeCursor" 
   ((inCursor :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetAnimatedThemeCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_SetAnimatedThemeCursor" 
   ((inCursor :UInt32)
    (inAnimationStep :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ CONTROL STYLE SETTINGS ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  GetThemeScrollBarThumbStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeScrollBarThumbStyle" 
   ((outStyle (:pointer :THEMESCROLLBARTHUMBSTYLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeScrollBarArrowStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeScrollBarArrowStyle" 
   ((outStyle (:pointer :THEMESCROLLBARARROWSTYLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeCheckBoxStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeCheckBoxStyle" 
   ((outStyle (:pointer :THEMECHECKBOXSTYLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ FONTS/TEXT ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  UseThemeFont()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_UseThemeFont" 
   ((inFontID :UInt16)
    (inScript :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeFont()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeFont" 
   ((inFontID :UInt16)
    (inScript :SInt16)
    (outFontName (:pointer :STR255))            ;  can be NULL 
    (outFontSize (:pointer :SInt16))
    (outStyle (:pointer :Style))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeTextBox()
;  *  
;  *  Summary:
;  *    Draws text into the area you specify.
;  *  
;  *  Discussion:
;  *    DrawThemeTextBox allows you to draw theme-savvy (ie. Aqua-savvy
;  *    on Mac OS X) text. It is unicode savvy (although only partially
;  *    so under CarbonLib), and allows you to customize certain text
;  *    rendering characteristics such as the font, wrapping behavior,
;  *    and justification. The text is drawn into the CGContextRef you
;  *    provide, or into the current Quickdraw port if no CGContextRef is
;  *    provided. None of DrawThemeTextBox's parameters imply a color, so
;  *    you must set up the desired text color separately before calling
;  *    DrawThemeTextBox. If you provide a CGContextRef, its fill color
;  *    will be used to draw the text. If you do not provide a
;  *    CGContextRef, a color based on the current Quickdraw port's
;  *    foreground color and the grayishTextOr mode (if set) will be used
;  *    to draw the text.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inString:
;  *      A CFStringRef containing the unicode characters you wish to
;  *      render. You MUST NOT pass in a CFStringRef that was allocated
;  *      with any of the "NoCopy" CFString creation APIs; a string
;  *      created with a "NoCopy" API has transient storage which is
;  *      incompatible with DrawThemeTextBox's caches.
;  *    
;  *    inFontID:
;  *      The ThemeFontID describing the font you'd like to render the
;  *      text with. See the discussion of ThemeFontIDs elsewhere in this
;  *      header.
;  *    
;  *    inState:
;  *      The ThemeDrawState describing the the state of the interface
;  *      element you are drawing the text for. If, for example, you are
;  *      drawing text for an inactive window, you would pass
;  *      kThemeStateInactive. The ThemeDrawState is generally only used
;  *      to determine the shadow characteristics for the text on Mac OS
;  *      X. Note that the ThemeDrawState does NOT imply a color. It is
;  *      NOT used as a mechanism for graying the text. If you wish to
;  *      draw grayed text, you must set up the desired gray color and
;  *      apply it to either the current Quickdraw port or the
;  *      CGContextRef as appropriate.
;  *    
;  *    inWrapToWidth:
;  *      A Boolean indicating whether you want to draw multiple lines of
;  *      text wrapped to a bounding box. False indicates that only one
;  *      line of text should be drawn without any sort of wrapping.
;  *    
;  *    inBoundingBox:
;  *      The rectangle (in coordinates relative to the current Quickdraw
;  *      port) describing the area to draw the text within. The first
;  *      line of text will be top-justified to this rectangle. Wrapping
;  *      (if desired) will happen at the horizontal extent of this
;  *      rectangle. Regardless of the amount of text in your
;  *      CFStringRef, all drawn text will be clipped to this rectangle.
;  *    
;  *    inJust:
;  *      The horizontal justification you would like for your text. You
;  *      can use one of the standard justification constants from
;  *      TextEdit.h.
;  *    
;  *    inContext:
;  *      The CGContextRef into which you would like to draw the text. On
;  *      Mac OS X, all text drawing happens in CGContextRefs; if you
;  *      pass NULL, a transient CGContextRef will be allocated and
;  *      deallocated for use within the single API call. Relying on the
;  *      system behavior if transiently creating CGContextRefs may
;  *      result in performance problems. On Mac OS 9, the CGContextRef
;  *      parameter is ignored.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DrawThemeTextBox" 
   ((inString (:pointer :__CFString))
    (inFontID :UInt16)
    (inState :UInt32)
    (inWrapToWidth :Boolean)
    (inBoundingBox (:pointer :Rect))
    (inJust :SInt16)
    (inContext :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TruncateThemeText()
;  *  
;  *  Summary:
;  *    Truncates text to fit within the width you specify.
;  *  
;  *  Discussion:
;  *    TruncateThemeText alters a unicode string to fit within a width
;  *    that you specify. It is unicode savvy (although only partially so
;  *    under CarbonLib), and makes its calculations (and any subsequent
;  *    string alteration) based on the font and state you specify. If
;  *    the string needs to be truncated, it will be reduced to the
;  *    maximum number of characters which (with the addition of an
;  *    ellipsis character) fits within the specified width.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inString:
;  *      A CFMutableStringRef containing the unicode characters you wish
;  *      to truncate. On output, inString may have been altered to fit
;  *      within the specified width. You MUST NOT pass in a CFStringRef
;  *      that was allocated with any of the "NoCopy" CFString creation
;  *      APIs (see note in DrawThemeTextBox above).
;  *    
;  *    inFontID:
;  *      The ThemeFontID to use for text measurements. See the
;  *      discussion of ThemeFontIDs elsewhere in this header.
;  *    
;  *    inState:
;  *      The ThemeDrawState which matches the state you will ultimately
;  *      render the string width. This may affect text measurement
;  *      during truncation, so you should be sure the value you pass to
;  *      TruncateThemeText matches the value you will eventually use for
;  *      drawing.
;  *    
;  *    inPixelWidthLimit:
;  *      The maximum width (in pixels) that the resulting truncated
;  *      string may have.
;  *    
;  *    inTruncWhere:
;  *      A TruncCode indicating where you would like truncation to occur.
;  *    
;  *    outTruncated:
;  *      On output, this Boolean value indicates whether the string was
;  *      truncated. True means the string was truncated. False means the
;  *      string was not (and did not need to be) truncated.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TruncateThemeText" 
   ((inString (:pointer :__CFString))
    (inFontID :UInt16)
    (inState :UInt32)
    (inPixelWidthLimit :SInt16)
    (inTruncWhere :SInt16)
    (outTruncated (:pointer :Boolean))          ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeTextDimensions()
;  *  
;  *  Summary:
;  *    Tells you the height, width, and baseline for a string.
;  *  
;  *  Discussion:
;  *    GetThemeTextDimensions measures the given string using a font and
;  *    state you specify. It always reports the actual height and
;  *    baseline. It sometimes reports the actual width (see below). It
;  *    can measure a string that wraps. It is unicode savvy (although
;  *    only partially so under CarbonLib).
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inString:
;  *      A CFStringRef containing the unicode characters you wish to
;  *      measure. You MUST NOT pass in a CFStringRef that was allocated
;  *      with any of the "NoCopy" CFString creation APIs (see note in
;  *      DrawThemeTextBox above).
;  *    
;  *    inFontID:
;  *      The ThemeFontID describing the font you'd like to measure the
;  *      text with. See the discussion of ThemeFontIDs elsewhere in this
;  *      header.
;  *    
;  *    inState:
;  *      The ThemeDrawState which matches the state you will ultimately
;  *      render the string width. This may affect text measurement, so
;  *      you should be sure the value you pass to TruncateThemeText
;  *      matches the value you will eventually use for drawing.
;  *    
;  *    inWrapToWidth:
;  *      A Boolean indicating whether you want the measurements based on
;  *      wrapping the text to a specific width. If you pass true, you
;  *      must specify the desired width in ioBounds->h.
;  *    
;  *    ioBounds:
;  *      On output, ioBounds->v contains the height of the text. If you
;  *      pass false to inWrapToWidth, ioBounds->h will contain the width
;  *      of the text on output. If you pass true to inWrapToWidth,
;  *      ioBounds->h must (on input) contain the desired width for
;  *      wrapping; on output, ioBounds->h contains the same value you
;  *      specified on input.
;  *    
;  *    outBaseline:
;  *      On output, outBaseline contains the offset (in Quickdraw space)
;  *      from the bottom edge of the last line of text to the baseline
;  *      of the first line of text. outBaseline will generally be a
;  *      negative value. On Mac OS X 10.2 and later, you may pass NULL
;  *      if you don't want this information.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetThemeTextDimensions" 
   ((inString (:pointer :__CFString))
    (inFontID :UInt16)
    (inState :UInt32)
    (inWrapToWidth :Boolean)
    (ioBounds (:pointer :Point))
    (outBaseline (:pointer :SInt16))            ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeTextShadowOutset()
;  *  
;  *  Summary:
;  *    Tells you the amount of space taken up by the shadow for a given
;  *    font/state combination.
;  *  
;  *  Discussion:
;  *    GetThemeTextShadowOutset passes back the maximum amount of space
;  *    the shadow will take up for text drawn in the specified font and
;  *    state. While GetThemeTextDimensions tells you how much space is
;  *    taken up by the character glyphs themselves, it does not
;  *    incorporate the font/state shadow into its calculations. If you
;  *    need to know how much total space including the shadow will be
;  *    taken up, call GetThemeTextDimensions followed by
;  *    GetThemeTextShadowOutset.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inFontID:
;  *      The ThemeFontID describing the font you'd like the shadow
;  *      characteristics of. Font and state both determine the amount of
;  *      shadow that will be used on rendered text. See the discussion
;  *      of ThemeFontIDs elsewhere in this header.
;  *    
;  *    inState:
;  *      The ThemeDrawState which matches the state you'd like the
;  *      shadow characteristics of. Font and state both determine the
;  *      amount of shadow that will be used on rendered text.
;  *    
;  *    outOutset:
;  *      On output, outOutset contains the amount of space the shadow
;  *      will take up beyond each edge of the text bounding rectangle
;  *      returned by GetThemeTextDimensions. The fields of outOutset
;  *      will either be positive values or zero.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetThemeTextShadowOutset" 
   ((inFontID :UInt16)
    (inState :UInt32)
    (outOutset (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ TRACKS ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  DrawThemeTrack()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemeTrack" 
   ((drawInfo (:pointer :ThemeTrackDrawInfo))
    (rgnGhost (:pointer :OpaqueRgnHandle))      ;  can be NULL 
    (eraseProc (:pointer :OpaqueThemeEraseProcPtr));  can be NULL 
    (eraseData :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HitTestThemeTrack()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_HitTestThemeTrack" 
   ((drawInfo (:pointer :ThemeTrackDrawInfo))
    (mousePoint :Point)
    (partHit (:pointer :APPEARANCEPARTCODE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  GetThemeTrackBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeTrackBounds" 
   ((drawInfo (:pointer :ThemeTrackDrawInfo))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeTrackThumbRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeTrackThumbRgn" 
   ((drawInfo (:pointer :ThemeTrackDrawInfo))
    (thumbRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeTrackDragRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeTrackDragRect" 
   ((drawInfo (:pointer :ThemeTrackDrawInfo))
    (dragRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeTrackTickMarks()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemeTrackTickMarks" 
   ((drawInfo (:pointer :ThemeTrackDrawInfo))
    (numTicks :UInt32)
    (eraseProc (:pointer :OpaqueThemeEraseProcPtr));  can be NULL 
    (eraseData :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeTrackThumbPositionFromOffset()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeTrackThumbPositionFromOffset" 
   ((drawInfo (:pointer :ThemeTrackDrawInfo))
    (thumbOffset :Point)
    (relativePosition (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeTrackThumbPositionFromRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeTrackThumbPositionFromRegion" 
   ((drawInfo (:pointer :ThemeTrackDrawInfo))
    (thumbRgn (:pointer :OpaqueRgnHandle))
    (relativePosition (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeTrackLiveValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeTrackLiveValue" 
   ((drawInfo (:pointer :ThemeTrackDrawInfo))
    (relativePosition :SInt32)
    (value (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ SCROLLBAR ARROWS ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  DrawThemeScrollBarArrows()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemeScrollBarArrows" 
   ((bounds (:pointer :Rect))
    (enableState :UInt8)
    (pressState :UInt8)
    (isHoriz :Boolean)
    (trackBounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeScrollBarTrackRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeScrollBarTrackRect" 
   ((bounds (:pointer :Rect))
    (enableState :UInt8)
    (pressState :UInt8)
    (isHoriz :Boolean)
    (trackBounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HitTestThemeScrollBarArrows()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_HitTestThemeScrollBarArrows" 
   ((scrollBarBounds (:pointer :Rect))
    (enableState :UInt8)
    (pressState :UInt8)
    (isHoriz :Boolean)
    (ptHit :Point)
    (trackBounds (:pointer :Rect))
    (partcode (:pointer :APPEARANCEPARTCODE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ WINDOWS ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  GetThemeWindowRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeWindowRegion" 
   ((flavor :UInt16)
    (contRect (:pointer :Rect))
    (state :UInt32)
    (metrics (:pointer :ThemeWindowMetrics))
    (attributes :UInt32)
    (winRegion :UInt16)
    (rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeWindowFrame()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemeWindowFrame" 
   ((flavor :UInt16)
    (contRect (:pointer :Rect))
    (state :UInt32)
    (metrics (:pointer :ThemeWindowMetrics))
    (attributes :UInt32)
    (titleProc (:pointer :OpaqueWindowTitleDrawingProcPtr));  can be NULL 
    (titleData :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeTitleBarWidget()
;  *  
;  *  Summary:
;  *    Draws the requested theme title bar widget.
;  *  
;  *  Discussion:
;  *    DrawThemeTitleBarWidget renders the requested theme title bar
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
;  *    flavor:
;  *      A valid ThemeWindowtype describing the type of theme window for
;  *      which you would like to draw a widget.
;  *    
;  *    contRect:
;  *      A rectangle describing the window's content area.  The widget
;  *      is drawn relative to the content rectangle of the window, so
;  *      this parameter does not describe the actual widget bounds, it
;  *      describes the window's content rectangle.
;  *    
;  *    state:
;  *      A valid ThemeDrawState which describes the state of the window
;  *      for which the widget is to be drawn.
;  *    
;  *    metrics:
;  *      A pointer to a set of valid ThemeWindowMetrics.  At this time,
;  *      none of the fields of the metrics are pertinent to the widgets,
;  *      so the only important field is the metricSize field to mark the
;  *      structure as valid.
;  *    
;  *    attributes:
;  *      A valid ThemeWindowAttributes set which describes the window
;  *      for which the widget is to be drawn.
;  *    
;  *    widget:
;  *      A valid ThemeTitleBarWidget set which describes which widget to
;  *      draw.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemeTitleBarWidget" 
   ((flavor :UInt16)
    (contRect (:pointer :Rect))
    (state :UInt32)
    (metrics (:pointer :ThemeWindowMetrics))
    (attributes :UInt32)
    (widget :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeWindowRegionHit()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeWindowRegionHit" 
   ((flavor :UInt16)
    (inContRect (:pointer :Rect))
    (state :UInt32)
    (metrics (:pointer :ThemeWindowMetrics))
    (inAttributes :UInt32)
    (inPoint :Point)
    (outRegionHit (:pointer :APPEARANCEREGIONCODE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  DrawThemeScrollBarDelimiters()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemeScrollBarDelimiters" 
   ((flavor :UInt16)
    (inContRect (:pointer :Rect))
    (state :UInt32)
    (attributes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ BUTTONS ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  DrawThemeButton()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemeButton" 
   ((inBounds (:pointer :Rect))
    (inKind :UInt16)
    (inNewInfo (:pointer :ThemeButtonDrawInfo))
    (inPrevInfo (:pointer :ThemeButtonDrawInfo));  can be NULL 
    (inEraseProc (:pointer :OpaqueThemeEraseProcPtr));  can be NULL 
    (inLabelProc (:pointer :OpaqueThemeButtonDrawProcPtr));  can be NULL 
    (inUserData :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeButtonRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeButtonRegion" 
   ((inBounds (:pointer :Rect))
    (inKind :UInt16)
    (inNewInfo (:pointer :ThemeButtonDrawInfo))
    (outRegion (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeButtonContentBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeButtonContentBounds" 
   ((inBounds (:pointer :Rect))
    (inKind :UInt16)
    (inDrawInfo (:pointer :ThemeButtonDrawInfo))
    (outBounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeButtonBackgroundBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeButtonBackgroundBounds" 
   ((inBounds (:pointer :Rect))
    (inKind :UInt16)
    (inDrawInfo (:pointer :ThemeButtonDrawInfo))
    (outBounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ INTERFACE SOUNDS ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;                                                                                                   
;   X ALERT: Please note that the sound APIs do not work on Mac OS X at present.                    
; 
;  *  PlayThemeSound()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_PlayThemeSound" 
   ((kind :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  BeginThemeDragSound()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_BeginThemeDragSound" 
   ((kind :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  EndThemeDragSound()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_EndThemeDragSound" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ PRIMITIVES ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  DrawThemeTickMark()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemeTickMark" 
   ((bounds (:pointer :Rect))
    (state :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeChasingArrows()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemeChasingArrows" 
   ((bounds (:pointer :Rect))
    (index :UInt32)
    (state :UInt32)
    (eraseProc (:pointer :OpaqueThemeEraseProcPtr));  can be NULL 
    (eraseData :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemePopupArrow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemePopupArrow" 
   ((bounds (:pointer :Rect))
    (orientation :UInt16)
    (size :UInt16)
    (state :UInt32)
    (eraseProc (:pointer :OpaqueThemeEraseProcPtr));  can be NULL 
    (eraseData :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeStandaloneGrowBox()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemeStandaloneGrowBox" 
   ((origin :Point)
    (growDirection :UInt16)
    (isSmall :Boolean)
    (state :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DrawThemeStandaloneNoGrowBox()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DrawThemeStandaloneNoGrowBox" 
   ((origin :Point)
    (growDirection :UInt16)
    (isSmall :Boolean)
    (state :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeStandaloneGrowBoxBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeStandaloneGrowBoxBounds" 
   ((origin :Point)
    (growDirection :UInt16)
    (isSmall :Boolean)
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ DRAWING STATE ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  The following routines help you save and restore the drawing state in a theme-savvy manner. With 
;  these weapons in your arsenal, there is no grafport you cannot tame. Use ThemeGetDrawingState to 
;  get the current drawing settings for the current port. It will return an opaque object for you   
;  to pass into SetThemeDrawingState later on. When you are finished with the state, call the       
;  DisposeThemeDrawingState routine. You can alternatively pass true into the inDisposeNow          
;  parameter of the SetThemeDrawingState routine.  You can use this routine to copy the drawing     
;  state from one port to another as well.                                                          
;                                                                                                   
;  As of this writing (Mac OS 9.1 and Mac OS X), Get/SetThemeDrawingState will save and restore     
;  this data in the port:                                                                           
;                                                                                                   
;       pen size                                                                                    
;       pen location                                                                                
;       pen mode                                                                                    
;       pen Pattern and PixPat                                                                      
;       background Pattern and PixPat                                                               
;       RGB foreground and background colors                                                        
;       text mode                                                                                   
;       pattern origin                                                                              
;                                                                                                   
;  Get/SetThemeDrawingState may save and restore additional port state in the future, but you can   
;  rely on them to always save at least this port state.                                            
; 
;  *  NormalizeThemeDrawingState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_NormalizeThemeDrawingState" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeDrawingState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeDrawingState" 
   ((outState (:pointer :THEMEDRAWINGSTATE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetThemeDrawingState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_SetThemeDrawingState" 
   ((inState (:pointer :OpaqueThemeDrawingState))
    (inDisposeNow :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DisposeThemeDrawingState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_DisposeThemeDrawingState" 
   ((inState (:pointer :OpaqueThemeDrawingState))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ MISCELLANEOUS ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  ApplyThemeBackground is used to set up the background for embedded controls  
;  It is normally called by controls that are embedders. The standard controls  
;  call this API to ensure a correct background for the current theme. You pass 
;  in the same rectangle you would if you were calling the drawing primitive.   
; 
;  *  ApplyThemeBackground()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_ApplyThemeBackground" 
   ((inKind :UInt32)
    (bounds (:pointer :Rect))
    (inState :UInt32)
    (inDepth :SInt16)
    (inColorDev :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetThemeTextColorForWindow() has moved to MacWindows.h
;  
; 
;  *  IsValidAppearanceFileType()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_IsValidAppearanceFileType" 
   ((fileType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  GetThemeBrushAsColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeBrushAsColor" 
   ((inBrush :SInt16)
    (inDepth :SInt16)
    (inColorDev :Boolean)
    (outColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetThemeTextColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
;  

(deftrap-inline "_GetThemeTextColor" 
   ((inColor :SInt16)
    (inDepth :SInt16)
    (inColorDev :Boolean)
    (outColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ BEGIN CARBON ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  GetThemeMetric()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetThemeMetric" 
   ((inMetric :UInt32)
    (outMetric (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CopyThemeIdentifier()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CopyThemeIdentifier" 
   ((outIdentifier (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Obsolete symbolic names                                                                          
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Obsolete error codes - use the new ones, s'il vous plait / kudasai 

(defconstant $appearanceBadBrushIndexErr -30560);  pattern index invalid 

(defconstant $appearanceProcessRegisteredErr -30561)
(defconstant $appearanceProcessNotRegisteredErr -30562)
(defconstant $appearanceBadTextColorIndexErr -30563)
(defconstant $appearanceThemeHasNoAccents -30564)
(defconstant $appearanceBadCursorIndexErr -30565)

(defconstant $kThemeActiveDialogBackgroundBrush 1)
(defconstant $kThemeInactiveDialogBackgroundBrush 2)
(defconstant $kThemeActiveAlertBackgroundBrush 3)
(defconstant $kThemeInactiveAlertBackgroundBrush 4)
(defconstant $kThemeActiveModelessDialogBackgroundBrush 5)
(defconstant $kThemeInactiveModelessDialogBackgroundBrush 6)
(defconstant $kThemeActiveUtilityWindowBackgroundBrush 7)
(defconstant $kThemeInactiveUtilityWindowBackgroundBrush 8)
(defconstant $kThemeListViewSortColumnBackgroundBrush 9)
(defconstant $kThemeListViewBackgroundBrush 10)
(defconstant $kThemeIconLabelBackgroundBrush 11)
(defconstant $kThemeListViewSeparatorBrush 12)
(defconstant $kThemeChasingArrowsBrush 13)
(defconstant $kThemeDragHiliteBrush 14)
(defconstant $kThemeDocumentWindowBackgroundBrush 15)
(defconstant $kThemeFinderWindowBackgroundBrush 16)

(defconstant $kThemeActiveScrollBarDelimiterBrush 17)
(defconstant $kThemeInactiveScrollBarDelimiterBrush 18)
(defconstant $kThemeFocusHighlightBrush 19)
(defconstant $kThemeActivePopupArrowBrush 20)
(defconstant $kThemePressedPopupArrowBrush 21)
(defconstant $kThemeInactivePopupArrowBrush 22)
(defconstant $kThemeAppleGuideCoachmarkBrush 23)

(defconstant $kThemeActiveDialogTextColor 1)
(defconstant $kThemeInactiveDialogTextColor 2)
(defconstant $kThemeActiveAlertTextColor 3)
(defconstant $kThemeInactiveAlertTextColor 4)
(defconstant $kThemeActiveModelessDialogTextColor 5)
(defconstant $kThemeInactiveModelessDialogTextColor 6)
(defconstant $kThemeActiveWindowHeaderTextColor 7)
(defconstant $kThemeInactiveWindowHeaderTextColor 8)
(defconstant $kThemeActivePlacardTextColor 9)
(defconstant $kThemeInactivePlacardTextColor 10)
(defconstant $kThemePressedPlacardTextColor 11)
(defconstant $kThemeActivePushButtonTextColor 12)
(defconstant $kThemeInactivePushButtonTextColor 13)
(defconstant $kThemePressedPushButtonTextColor 14)
(defconstant $kThemeActiveBevelButtonTextColor 15)
(defconstant $kThemeInactiveBevelButtonTextColor 16)
(defconstant $kThemePressedBevelButtonTextColor 17)
(defconstant $kThemeActivePopupButtonTextColor 18)
(defconstant $kThemeInactivePopupButtonTextColor 19)
(defconstant $kThemePressedPopupButtonTextColor 20)
(defconstant $kThemeIconLabelTextColor 21)
(defconstant $kThemeListViewTextColor 22)

(defconstant $kThemeActiveDocumentWindowTitleTextColor 23)
(defconstant $kThemeInactiveDocumentWindowTitleTextColor 24)
(defconstant $kThemeActiveMovableModalWindowTitleTextColor 25)
(defconstant $kThemeInactiveMovableModalWindowTitleTextColor 26)
(defconstant $kThemeActiveUtilityWindowTitleTextColor 27)
(defconstant $kThemeInactiveUtilityWindowTitleTextColor 28)
(defconstant $kThemeActivePopupWindowTitleColor 29)
(defconstant $kThemeInactivePopupWindowTitleColor 30)
(defconstant $kThemeActiveRootMenuTextColor 31)
(defconstant $kThemeSelectedRootMenuTextColor 32)
(defconstant $kThemeDisabledRootMenuTextColor 33)
(defconstant $kThemeActiveMenuItemTextColor 34)
(defconstant $kThemeSelectedMenuItemTextColor 35)
(defconstant $kThemeDisabledMenuItemTextColor 36)
(defconstant $kThemeActivePopupLabelTextColor 37)
(defconstant $kThemeInactivePopupLabelTextColor 38)

(defconstant $kAEThemeSwitch :|thme|)           ;  Event ID's: Theme Switched 


(defconstant $kThemeNoAdornment 0)
(defconstant $kThemeDefaultAdornment 1)
(defconstant $kThemeFocusAdornment 4)
(defconstant $kThemeRightToLeftAdornment 16)
(defconstant $kThemeDrawIndicatorOnly 32)

(defconstant $kThemeBrushPassiveAreaFill 25)

(defconstant $kThemeMetricCheckBoxGlyphHeight 2)
(defconstant $kThemeMetricRadioButtonGlyphHeight 3)
(defconstant $kThemeMetricDisclosureButtonSize 17)
(defconstant $kThemeMetricBestListHeaderHeight 20)
(defconstant $kThemeMetricSmallProgressBarThickness 58);  obsolete 

(defconstant $kThemeMetricProgressBarThickness 32);  obsolete 


(defconstant $kThemeScrollBar 0)
(defconstant $kThemeSlider 2)
(defconstant $kThemeProgressBar 3)
(defconstant $kThemeIndeterminateBar 4)
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __APPEARANCE__ */


(provide-interface "Appearance")