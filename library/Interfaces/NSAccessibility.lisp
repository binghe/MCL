(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSAccessibility.h"
; at Sunday July 2,2006 7:30:34 pm.
; 
; 	NSAccessibility.h
; 	Application Kit
; 	Copyright (c) 2001-2002, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/AppKitDefines.h>

; #import <AppKit/NSErrors.h>

; #import <Foundation/NSGeometry.h>

; #import <Foundation/NSObject.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
; 
;  Accessibility Informal Protocol
; 
#| @INTERFACE 
NSObject (NSAccessibility)

- (NSArray *)accessibilityAttributeNames;
- (id)accessibilityAttributeValue:(NSString *)attribute;
- (BOOL)accessibilityIsAttributeSettable:(NSString *)attribute;
- (void)accessibilitySetValue:(id)value forAttribute:(NSString *)attribute;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (NSArray *)accessibilityParameterizedAttributeNames;
- (id)accessibilityAttributeValue:(NSString *)attribute forParameter:(id)parameter;
#endif

- (NSArray *)accessibilityActionNames;
- (NSString *)accessibilityActionDescription:(NSString *)action;
- (void)accessibilityPerformAction:(NSString *)action;

- (BOOL)accessibilityIsIgnored;

- (id)accessibilityHitTest:(NSPoint)point;

- (id)accessibilityFocusedUIElement;

|#
;  error signaling for bad setter value or bad parameter.

(deftrap-inline "_NSAccessibilityRaiseBadArgumentException" 
   ((element :UInt32)
    (attribute (:pointer :NSString))
    (value :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  Ignored UIElements Utilities
; 

(deftrap-inline "_NSAccessibilityUnignoredAncestor" 
   ((element :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_NSAccessibilityUnignoredDescendant" 
   ((element :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_NSAccessibilityUnignoredChildren" 
   ((originalChildren (:pointer :nsarray))
   )
   (:pointer :nsarray)
() )

(deftrap-inline "_NSAccessibilityUnignoredChildrenForOnlyChild" 
   ((originalChild :UInt32)
   )
   (:pointer :nsarray)
() )
; 
;  Posting Notifications
; 
;  Posts a notification about element to anyone registered on element.

(deftrap-inline "_NSAccessibilityPostNotification" 
   ((element :UInt32)
    (notification (:pointer :NSString))
   )
   nil
() )
; 
;  Exception Constants
; 
;  name for accessibility exception - declared in NSErrors.h
;  APPKIT_EXTERN NSString *NSAccessibilityException;
;  userInfo key for error codes in accessibility exceptions
(def-mactype :NSAccessibilityErrorCodeExceptionInfo (find-mactype '(:pointer :NSString)))
; 
;  Accessibility Constants
; 
;  standard attributes
(def-mactype :NSAccessibilityRoleAttribute (find-mactype '(:pointer :NSString)))
; (NSString *) - type, non-localized (e.g. radioButton)
(def-mactype :NSAccessibilityRoleDescriptionAttribute (find-mactype '(:pointer :NSString)))
; (NSString *) - user readable role (e.g. "radio button")
(def-mactype :NSAccessibilitySubroleAttribute (find-mactype '(:pointer :NSString)))
; (NSString *) - type, non-localized (e.g. closeButton)
(def-mactype :NSAccessibilityHelpAttribute (find-mactype '(:pointer :NSString)))
; (NSString *) - instance description (e.g. a tool tip) 
(def-mactype :NSAccessibilityTitleAttribute (find-mactype '(:pointer :NSString)))
; (NSString *) - annotation (e.g. text of a push button)
(def-mactype :NSAccessibilityValueAttribute (find-mactype '(:pointer :NSString)))
; (id)         - element's value
(def-mactype :NSAccessibilityMinValueAttribute (find-mactype '(:pointer :NSString)))
; (id)         - element's min value
(def-mactype :NSAccessibilityMaxValueAttribute (find-mactype '(:pointer :NSString)))
; (id)         - element's max value
(def-mactype :NSAccessibilityEnabledAttribute (find-mactype '(:pointer :NSString)))
; (NSNumber *) - (boolValue) responds to user?
(def-mactype :NSAccessibilityFocusedAttribute (find-mactype '(:pointer :NSString)))
; (NSNumber *) - (boolValue) has keyboard focus?
(def-mactype :NSAccessibilityParentAttribute (find-mactype '(:pointer :NSString)))
; (id)         - element containing you
(def-mactype :NSAccessibilityChildrenAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - elements you contain
(def-mactype :NSAccessibilityWindowAttribute (find-mactype '(:pointer :NSString)))
; (id)         - UIElement for the containing window
(def-mactype :NSAccessibilitySelectedChildrenAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - child elements which are selected
(def-mactype :NSAccessibilityVisibleChildrenAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - child elements which are visible
(def-mactype :NSAccessibilityPositionAttribute (find-mactype '(:pointer :NSString)))
; (NSValue *)  - (pointValue) position in screen coords
(def-mactype :NSAccessibilitySizeAttribute (find-mactype '(:pointer :NSString)))
; (NSValue *)  - (sizeValue) size
(def-mactype :NSAccessibilityContentsAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - main elements
(def-mactype :NSAccessibilityPreviousContentsAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - main elements
(def-mactype :NSAccessibilityNextContentsAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - main elements
;  text specific attributes
(def-mactype :NSAccessibilitySelectedTextAttribute (find-mactype '(:pointer :NSString)))
; (NSString *) - selected text
(def-mactype :NSAccessibilitySelectedTextRangeAttribute (find-mactype '(:pointer :NSString)))
; (NSValue *)  - (rangeValue) range of selected text
(def-mactype :NSAccessibilityNumberOfCharactersAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (NSNumber *) - number of characters
(def-mactype :NSAccessibilityVisibleCharacterRangeAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (NSValue *)  - (rangeValue) range of visible text
;  parameterized text specific attributes
(def-mactype :NSAccessibilityLineForIndexParameterizedAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (NSNumber *) - line# for char index; param:(NSNumber *)
(def-mactype :NSAccessibilityRangeForLineParameterizedAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (NSValue *)  - (rangeValue) range of line; param:(NSNumber *)
(def-mactype :NSAccessibilityStringForRangeParameterizedAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (NSString *) - substring; param:(NSValue * - rangeValue) 
(def-mactype :NSAccessibilityRangeForPositionParameterizedAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (NSValue *)  - (rangeValue) composed char range; param:(NSValue * - pointValue)
(def-mactype :NSAccessibilityRangeForIndexParameterizedAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (NSValue *)  - (rangeValue) composed char range; param:(NSNumber *)
(def-mactype :NSAccessibilityBoundsForRangeParameterizedAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (NSValue *)  - (rectValue) bounds of text; param:(NSValue * - rangeValue)
(def-mactype :NSAccessibilityRTFForRangeParameterizedAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (NSData *)   - rtf for text; param:(NSValue * - rangeValue)
(def-mactype :NSAccessibilityStyleRangeForIndexParameterizedAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (NSValue *)  - (rangeValue) extent of style run; param:(NSNumber *)
;  window specific attributes
(def-mactype :NSAccessibilityMainAttribute (find-mactype '(:pointer :NSString)))
; (NSNumber *) - (boolValue) is it the main window?
(def-mactype :NSAccessibilityMinimizedAttribute (find-mactype '(:pointer :NSString)))
; (NSNumber *) - (boolValue) is window minimized?
(def-mactype :NSAccessibilityCloseButtonAttribute (find-mactype '(:pointer :NSString)))
; (id) - UIElement for close box (or nil)
(def-mactype :NSAccessibilityZoomButtonAttribute (find-mactype '(:pointer :NSString)))
; (id) - UIElement for zoom box (or nil)
(def-mactype :NSAccessibilityMinimizeButtonAttribute (find-mactype '(:pointer :NSString)))
; (id) - UIElement for miniaturize box (or nil)
(def-mactype :NSAccessibilityToolbarButtonAttribute (find-mactype '(:pointer :NSString)))
; (id) - UIElement for toolbar box (or nil)
(def-mactype :NSAccessibilityProxyAttribute (find-mactype '(:pointer :NSString)))
; (id) - UIElement for title's icon (or nil)
(def-mactype :NSAccessibilityGrowAreaAttribute (find-mactype '(:pointer :NSString)))
; (id) - UIElement for grow box (or nil)
(def-mactype :NSAccessibilityModalAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (NSNumber *) - (boolValue) is the window modal
(def-mactype :NSAccessibilityDefaultButtonAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (id) - UIElement for default button
(def-mactype :NSAccessibilityCancelButtonAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (id) - UIElement for cancel button
;  application specific attributes
(def-mactype :NSAccessibilityMenuBarAttribute (find-mactype '(:pointer :NSString)))
; (id)         - UIElement for the menu bar
(def-mactype :NSAccessibilityWindowsAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - UIElements for the windows
(def-mactype :NSAccessibilityFrontmostAttribute (find-mactype '(:pointer :NSString)))
; (NSNumber *) - (boolValue) is the app active?
(def-mactype :NSAccessibilityHiddenAttribute (find-mactype '(:pointer :NSString)))
; (NSNumber *) - (boolValue) is the app hidden?
(def-mactype :NSAccessibilityMainWindowAttribute (find-mactype '(:pointer :NSString)))
; (id)         - UIElement for the main window.
(def-mactype :NSAccessibilityFocusedWindowAttribute (find-mactype '(:pointer :NSString)))
; (id)         - UIElement for the key window.
(def-mactype :NSAccessibilityFocusedUIElementAttribute (find-mactype '(:pointer :NSString)))
; (id)         - Currently focused UIElement.
;  misc attributes
(def-mactype :NSAccessibilityHeaderAttribute (find-mactype '(:pointer :NSString)))
; (id)         - UIElement for header.
(def-mactype :NSAccessibilityEditedAttribute (find-mactype '(:pointer :NSString)))
; (NSNumber *) - (boolValue) is it dirty?
(def-mactype :NSAccessibilityTabsAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - UIElements for tabs
(def-mactype :NSAccessibilityTitleUIElementAttribute (find-mactype '(:pointer :NSString)))
; (id)         - UIElement for the title
(def-mactype :NSAccessibilityHorizontalScrollBarAttribute (find-mactype '(:pointer :NSString)))
; (id)       - UIElement for the horizontal scroller
(def-mactype :NSAccessibilityVerticalScrollBarAttribute (find-mactype '(:pointer :NSString)))
; (id)         - UIElement for the vertical scroller
(def-mactype :NSAccessibilityOverflowButtonAttribute (find-mactype '(:pointer :NSString)))
; (id)         - UIElement for overflow
(def-mactype :NSAccessibilityIncrementButtonAttribute (find-mactype '(:pointer :NSString)))
; (id)         - UIElement for increment
(def-mactype :NSAccessibilityDecrementButtonAttribute (find-mactype '(:pointer :NSString)))
; (id)         - UIElement for decrement
(def-mactype :NSAccessibilityFilenameAttribute (find-mactype '(:pointer :NSString)))
; (NSString *) - filename
(def-mactype :NSAccessibilityExpandedAttribute (find-mactype '(:pointer :NSString)))
; (NSNumber *) - (boolValue) in expanded state?
(def-mactype :NSAccessibilitySelectedAttribute (find-mactype '(:pointer :NSString)))
; (NSNumber *) - (boolValue) is selected?
(def-mactype :NSAccessibilitySplittersAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - UIElements for splitters
(def-mactype :NSAccessibilityDocumentAttribute (find-mactype '(:pointer :NSString)))
; (NSString *) - url for open document
(def-mactype :NSAccessibilityOrientationAttribute (find-mactype '(:pointer :NSString)))
; (NSString *) - NSAccessibilityXXXOrientationValue
(def-mactype :NSAccessibilityVerticalOrientationValue (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityHorizontalOrientationValue (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityColumnTitlesAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - UIElements for titles
(def-mactype :NSAccessibilitySearchButtonAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (id)         - UIElement for search field search btn
(def-mactype :NSAccessibilitySearchMenuAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (id)         - UIElement for search field menu
(def-mactype :NSAccessibilityClearButtonAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; (id)         - UIElement for search field clear btn
;  table/outline view attributes
(def-mactype :NSAccessibilityRowsAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - UIElements for rows
(def-mactype :NSAccessibilityVisibleRowsAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - UIElements for visible rows
(def-mactype :NSAccessibilitySelectedRowsAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - UIElements for selected rows
(def-mactype :NSAccessibilityColumnsAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - UIElements for columns
(def-mactype :NSAccessibilityVisibleColumnsAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - UIElements for visible columns
(def-mactype :NSAccessibilitySelectedColumnsAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - UIElements for selected columns
(def-mactype :NSAccessibilitySortDirectionAttribute (find-mactype '(:pointer :NSString)))
; (???)
;  outline attributes
(def-mactype :NSAccessibilityDisclosingAttribute (find-mactype '(:pointer :NSString)))
; (NSNumber *) - (boolValue) is diclosing rows?
(def-mactype :NSAccessibilityDisclosedRowsAttribute (find-mactype '(:pointer :NSString)))
; (NSArray *)  - UIElements for disclosed rows
(def-mactype :NSAccessibilityDisclosedByRowAttribute (find-mactype '(:pointer :NSString)))
; (id)         - UIElement for disclosing row
;  actions
(def-mactype :NSAccessibilityPressAction (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityIncrementAction (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityDecrementAction (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityConfirmAction (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityPickAction (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityCancelAction (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSAccessibilityRaiseAction (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  focus notifications
(def-mactype :NSAccessibilityMainWindowChangedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityFocusedWindowChangedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityFocusedUIElementChangedNotification (find-mactype '(:pointer :NSString)))
;  application notifications
(def-mactype :NSAccessibilityApplicationActivatedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityApplicationDeactivatedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityApplicationHiddenNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityApplicationShownNotification (find-mactype '(:pointer :NSString)))
;  window notifications
(def-mactype :NSAccessibilityWindowCreatedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityWindowMovedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityWindowResizedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityWindowMiniaturizedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityWindowDeminiaturizedNotification (find-mactype '(:pointer :NSString)))
;  drawer & sheet notifications
(def-mactype :NSAccessibilityDrawerCreatedNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSAccessibilitySheetCreatedNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  element notifications
(def-mactype :NSAccessibilityValueChangedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityUIElementDestroyedNotification (find-mactype '(:pointer :NSString)))
;  roles
(def-mactype :NSAccessibilityUnknownRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityButtonRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityRadioButtonRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityCheckBoxRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilitySliderRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityTabGroupRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityTextFieldRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityStaticTextRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityTextAreaRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityScrollAreaRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityPopUpButtonRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityMenuButtonRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityTableRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityApplicationRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityGroupRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityRadioGroupRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityListRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityScrollBarRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityValueIndicatorRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityImageRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityMenuBarRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityMenuRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityMenuItemRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityColumnRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityRowRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityToolbarRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityBusyIndicatorRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityProgressIndicatorRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityWindowRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityDrawerRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilitySystemWideRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityOutlineRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityIncrementorRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityBrowserRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityComboBoxRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilitySplitGroupRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilitySplitterRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityColorWellRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityGrowAreaRole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilitySheetRole (find-mactype '(:pointer :NSString)))
;  subroles
(def-mactype :NSAccessibilityUnknownSubrole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityCloseButtonSubrole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityZoomButtonSubrole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityMinimizeButtonSubrole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityToolbarButtonSubrole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityTableRowSubrole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityOutlineRowSubrole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilitySecureTextFieldSubrole (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityStandardWindowSubrole (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSAccessibilityDialogSubrole (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSAccessibilitySystemDialogSubrole (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSAccessibilityFloatingWindowSubrole (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSAccessibilitySystemFloatingWindowSubrole (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSAccessibilityIncrementArrowSubrole (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSAccessibilityDecrementArrowSubrole (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSAccessibilityIncrementPageSubrole (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSAccessibilityDecrementPageSubrole (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSAccessibilitySearchFieldSubrole (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER

; #endif


(provide-interface "NSAccessibility")