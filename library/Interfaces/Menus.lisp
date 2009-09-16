(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Menus.h"
; at Sunday July 2,2006 7:24:48 pm.
; 
;      File:       HIToolbox/Menus.h
;  
;      Contains:   Menu Manager Interfaces.
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __MENUS__
; #define __MENUS__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __PROCESSES__
#| #|
#include <HIServicesProcesses.h>
#endif
|#
 |#
; #ifndef __CARBONEVENTSCORE__
#| #|
#include <HIToolboxCarbonEventsCore.h>
#endif
|#
 |#
; #ifndef __EVENTS__

(require-interface "HIToolbox/Events")

; #endif

; #ifndef __HIOBJECT__
#| #|
#include <HIToolboxHIObject.h>
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
;  *  Menu Manager
;  
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Menu Constants                                                                    
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;     A Short Course on Menu Definition Functions
;     
;     A menu definition function is used to implement a custom visual appearance for a menu.
;     Menu definition functions are still supported in Carbon, but the messages sent to a
;     menu definition function in Carbon are different than for a non-Carbon application.
;     
;     In general, Apple recommends using the system menu definition whenever possible.
;     Menu definition functions will continue to be supported, but it is not easy to write
;     a correct menu definition, especially one that attempts to imitate the standard system
;     menu appearance. If you require special features in your menu that the system menu
;     definition does not support, please mail <toolbox@apple.com> and describe your requirements;
;     we would much rather enhance the system menu definition than have you write a custom one.
;     
;     Menu definition functions before Carbon used the following messages:
;     
;         kMenuDrawMsg
;         kMenuChooseMsg
;         kMenuSizeMsg
;         kMenuPopUpMsg
;         kMenuDrawItemMsg
;         kMenuCalcItemMsg
;         kMenuThemeSavvyMsg
;         
;     kMenuChooseMsg and kMenuDrawItemMsg are not supported in Carbon and are not sent to
;     Carbon menu definitions. In Carbon, kMenuChooseMsg is replaced by kMenuFindItemMsg and
;     kMenuHiliteItemMsg. Menu definition functions in Carbon use the following messages:
;     
;         kMenuInitMsg
;         kMenuDisposeMsg
;         kMenuFindItemMsg
;         kMenuHiliteItemMsg
;         kMenuDrawItemsMsg
;         kMenuDrawMsg
;         kMenuSizeMsg
;         kMenuPopUpMsg
;         kMenuCalcItemMsg
;         kMenuThemeSavvyMsg
;         
;     The rest of this documentation will focus on Carbon menu definitions only.
;     
;     Menu Definition Messages
;     
;         Carbon menu definition functions should support the following messages:
;         
;         kMenuInitMsg
;             
;             menuRect        unused
;             hitPt           unused
;             whichItem       OSErr*
;         
;             Sent when a menu is created. This message gives the menu definition an opportunity
;             to initialize its own state. If the menu definition encounters an error while
;             initializing, it should set *whichItem to a non-zero error code; this will cause the
;             Menu Manager to destroy the menu and return an error back from the API that was used
;             to create the menu.
;         
;         kMenuDisposeMsg
;             
;             menuRect        unused
;             hitPt           unused
;             whichItem       unused
;             
;             Sent when a menu is destroyed. This message gives the menu definition an opportunity
;             to destroy its own data.
;             
;         kMenuFindItemMsg
;             
;             menuRect        menu bounds
;             hitPt           point to hit-test
;             whichItem       MDEFFindItemData*
;             
;             Sent when the Menu Manager is displaying a menu and needs to know what item is under
;             the mouse. The whichItem parameter is actually a pointer to a MenuTrackingData structure.
;             On entry, the menu, virtualMenuTop, and virtualMenuBottom fields of this structure are
;             valid. The menu definition should determine which item containst the given point, if any,
;             and fill in the itemUnderMouse, itemSelected, and itemRect fields. If an item is found,
;             the menu definition should always fill in the itemUnderMouse and itemRect fields. The
;             menu definition should only fill in the itemSelected field if the item is available for
;             selection; if it is unavailable (because it is disabled, or for some other reason), the
;             menu definition should set the itemSelected field to zero.
;             
;             The values placed in the itemUnderMouse and itemSelected fields should be less than or
;             equal to the number of items returned by CountMenuItems on this menu.
;             
;             The menu definition should not hilite the found item during this message. The Menu 
;             Manager will send a separate kMenuHiliteItemMsg to request hiliting of the item.
;             
;             If the menu definition supports scrolling, it should scroll the menu during this message,
;             and update the virtualMenuTop and virtualMenuBottom fields of the MenuTrackingData to
;             indicate the menu's new scrolled position.
;             
;             If the menu definition uses QuickDraw to draw while scrolling, it should draw into the
;             current port.
;     
;             If the menu definition uses CoreGraphics to draw while scrolling, it should use the
;             CGContextRef passed in the context field of the MDEFHiliteItemData structure.
;             
;             Menu definitions must use the ScrollMenuImage API, if available, to scroll the menu contents.
;             This API is available in CarbonLib 1.5 and later, and in Mac OS X 10.1 and later. ScrollMenuImage
;             properly supports scrolling the alpha channel in the menu's image data. Use of QuickDraw's
;             ScrollRect API to scroll the menu contents will result in the alpha channel being set to 0xFF
;             (opaque) and the menu will no longer be transparent.
;             
;             The menu definition should not modify the menu field of the MenuTrackingData.
;             
;         kMenuHiliteItemMsg
;         
;             menuRect        menu bounds
;             hitPt           unused
;             whichItem       MDEFHiliteItemData*
;             
;             Sent when the Menu Manager is displaying a menu and needs to hilite a newly selected
;             item. The whichItem parameter is actually a pointer to a MDEFHiliteItemData structure.
;             The menu definition should unhilite the item in the previousItem field, if non-zero,
;             and hilite the item in the newItem field.
;             
;             Menu definitions should use the EraseMenuBackground API to erase the old menu contents
;             before unhiliting a menu item, if the menu definition is using the Appearance Manager's
;             menu drawing APIs. This is necessary because the background of a menu is transparent on
;             Aqua, and if the old hilite is not erased first, it will show through the new unhilited
;             menu background.
;             
;             If the menu definition uses QuickDraw to draw, it should draw into the current port.
;     
;             If the menu definition uses CoreGraphics to draw, it should use the CGContextRef passed
;             in the context field of the MDEFHiliteItemData structure.
;             
;         kMenuDrawItemsMsg
;         
;             menuRect        menu bounds
;             hitPt           unused
;             whichItem       MDEFDrawItemsData*
;             
;             Sent when the Menu Manager is displaying a menu and needs to redraw a portion of the
;             menu. This message is used by the dynamic menu item support code in the Menu Manager;
;             for example, if items five and six in a menu are a dynamic group, the Menu Manager will
;             send a DrawItems message when the group's modifier key is pressed or released to redraw
;             the appropriate item, but no other items in the menu.
;             
;             The whichItem parameter for this message is actually a pointer to a MDEFDrawItemsData
;             structure. The menu definition should redraw the items starting with firstItem and
;             ending with lastItem, inclusive.
;             
;             If the menu definition uses QuickDraw to draw, it should draw into the current port.
;     
;             If the menu definition uses CoreGraphics to draw, it should use the CGContextRef passed
;             in the context field of the MDEFDrawItemsData structure.
;             
;         kMenuDrawMsg
;             
;             menuRect        menu bounds
;             hitPt           unused
;             whichItem       MDEFDrawData*
;             
;             Sent when the Menu Manager is displaying a menu and needs to redraw the entire menu.
;             The whichItem parameter is actually a pointer to a MenuTrackingData structure. On entry,
;             the menu field of this structure is valid. The menu definition should draw the menu and,
;             if it supports scrolling, should also fill in the virtualMenuTop and virtualMenuBottom
;             fields of the structure to indicate the menu's initial unscrolled position; typically, 
;             virtualMenuTop would be set to the same value as the top coordinate of the menu rect,
;             and virtualMenuBottom would be set to virtualMenuTop plus the virtual height of the menu.
;             
;             If the menu definition uses QuickDraw to draw, it should draw into the current port.
;     
;             If the menu definition uses CoreGraphics to draw, it should use the CGContextRef passed
;             in the context field of the MDEFDrawData structure.
;             
;         kMenuSizeMsg
;         
;             menuRect        unused
;             hitPt           maximum width and height of the menu
;             whichItem       unused
;             
;             Sent when the Menu Manager needs to determine the size of a menu. The menu definition
;             should calculate the width and height of the menu and store the sizes into the menu with
;             SetMenuWidth and SetMenuHeight.
;             
;             If the gestaltMenuMgrSendsMenuBoundsToDefProc bit is set in the Menu Manager's Gestalt
;             value, then the hitPt parameter to this message is the maximum width (hitPt.h) and height
;             (hitPt.v) of the menu. The menu definition should ensure that the width and height that it
;             places in the menu do not exceed these values. If the gestalt bit is not set, the menu
;             definition should just use the main GDevice's width and height as constraints on the menu's
;             width and height.
;             
;         kMenuPopUpMsg
;         
;             menuRect        on entry, constraints on the menu's position; on exit, menu bounds
;             hitPt           requested menu location, with swapped coordinates
;             whichItem       on entry, requested initial selection; on exit, virtual menu top
;             
;             Sent when the Menu Manager is about to display a popup menu. The menu definition should
;             calculate the appropriate menu bounds to contain the menu based on the requested menu
;             location and selected item. It should write the menuBounds into the rect given by the
;             menuRect parameter.
;             
;             If the gestaltMenuMgrSendsMenuBoundsToDefProc bit is set in the Menu Manager's Gestalt
;             value, then the menuRect parameter on entry to this message contains a constraint rect,
;             in global coordinates, outside of which the popup menu should not be positioned. The menu
;             definition should take this constraint rect into account as it calculates the menu bounds.
;             If the gestalt bit is not set, the menu definition should use the bounds of the GDevice
;             containing the menu's top left corner as a constraint on the menu's position.
;             
;             The hitPt parameter is a requested location for the top left corner of the menu. The
;             coordinates of this parameter are swapped from their normal order; the h field of the
;             hitPt parameter contains the vertical coordinate, and the v field of hitPt contains
;             the horizontal coordinate.
;             
;             On entry, the whichItem parameter points at a menu item index which is requested to be
;             the initial selection when the menu is displayed. After calculating the menu's bounds,
;             the menu definition should write the menu's virtual top coordinate into the location
;             pointed at by the whichItem parameter. If displaying the menu at the requested location
;             does not require scrolling, the virtual top will be the same as the menu bounds top;
;             if the menu must scroll to fit in the requested location, the virtual top may be different.
;             
;         kMenuCalcItemMsg
;         
;             menuRect        on exit, item bounds
;             hitPt           unused
;             whichItem       the item whose rect to calculate
;             
;             Sent when the Menu Manager needs to know the bounds of a menu item. The menu definition
;             should calculate the size of the item specified by the whichItem parameter, and store 
;             the bounds in the rect specified by the menuRect parameter.
;             
;             Some sample menu definition code provided by Apple has previously shown an implementation
;             of this message that always sets the top left corner of the item bounds to (0,0), regardless
;             of the item's actual position in the menu. For best future compatibility, menu definitions
;             should begin storing an item bounds that gives the item's actual position in the menu based
;             on the menu's current virtual top. For example, if the virtual menu top starts at 20, then
;             the menu definition would calculate an item bounds for the first item that starts at (0,20),
;             an item bounds for the second item that starts at (0,40), and so on. The menu definition
;             should call GetMenuTrackingData to get the menu's current virtual position, and use zero
;             for the menu top if GetMenuTrackingData returns an error.
;             
;         kMenuThemeSavvyMsg
;         
;             menuRect        unused
;             hitPt           unused
;             whichItem       on exit, indicates theme-savvyness of the menu definition
;             
;             Sent by the Menu Manager to determine whether the MDEF uses the Appearance Manager 
;             menu-drawing functions to draw its menu. If it does, the menu definition should return
;             kThemeSavvyMenuResponse in the location pointed to by whichItem. If the menu definition
;             draws its own custom content without using the Appearance Manager menu-drawing functions,
;             it should ignore this message.
;     
;     Low-memory Global Replacements
;     
;         Pre-Carbon menu definitions needed to use several low-memory globals to communicate with the
;         Menu Manager. These globals have all been replaced or made obsolete in Carbon, as follows:
;         
;         MenuDisable
;             
;             MenuDisable is now set automatically by the Menu Manager using the value returned in the
;             itemUnderMouse field of the MenuTrackingData structure passed to kMenuFindItemMsg.
;             
;         TopMenuItem
;         AtMenuBottom
;         
;             TopMenuItem and AtMenuBottom are now set automatically by the Menu Manager using the
;             values returned in the virtualMenuTop and virtualMenuBottom fields of the MenuTrackingData
;             structure passed to kMenuDrawMsg and kMenuFindItemMsg.
;             
;         mbSaveLoc
;     
;             This undocumented low-memory global was used by pre-Carbon menu definitions to store
;             the bounding rect of the currently selected item and to avoid drawing glitches while
;             the menu definition was scrolling the contents of a menu that had submenus. The Menu
;             Manager now automatically sets the selected item bounds using the value returned in
;             the itemRect field of the MenuTrackingData structure passed to kMenuFindItemMsg. In
;             order to correctly support scrolling of menus with submenus, a menu definition should
;             verify, before scrolling the menu contents, that no submenus of the scrolling menu are
;             currently visible. A menu definition can use GetMenuTrackingData to verify this condition,
;             as follows:
;             
;                 Boolean SafeToScroll( MenuRef menuBeingScrolled )
;                 {
;                     MenuTrackingData lastMenuData;
;                     return GetMenuTrackingData( NULL, &lastMenuData ) == noErr
;                            && lastMenuData.menu == menuBeingScrolled;
;                 }
;             
;             If SafeToScroll returns false, the menu definition should not scroll the menu.
; 
;  menu defProc messages 

(defconstant $kMenuDrawMsg 0)
(defconstant $kMenuSizeMsg 2)
(defconstant $kMenuPopUpMsg 3)
(defconstant $kMenuCalcItemMsg 5)
(defconstant $kMenuThemeSavvyMsg 7)             ;  is your MDEF theme-savvy?  If so, return kThemeSavvyMenuResponse in the whichItem parameter

(defconstant $mDrawMsg 0)
(defconstant $mSizeMsg 2)
(defconstant $mPopUpMsg 3)                      ;  position the popup menu rect appropriately 

(defconstant $mCalcItemMsg 5)

; #if CALL_NOT_IN_CARBON
#| 
; 
;    Carbon MDEFs must replace mChooseMsg with the new messages kMenuFindItemMsg and kMenuHiliteItemMsg. 
;    mDrawItemMsg was used by the popup menu control before 8.5, but is no longer used. 
; 

(defconstant $mChooseMsg 1)
(defconstant $mDrawItemMsg 4)
(defconstant $kMenuChooseMsg 1)
(defconstant $kMenuDrawItemMsg 4)
 |#

; #endif  /* CALL_NOT_IN_CARBON */


(defconstant $kThemeSavvyMenuResponse #x7473)   ;  should be returned in *whichItem when handling kMenuThemeSavvyMsg

;  these MDEF messages are only supported in Carbon

(defconstant $kMenuInitMsg 8)
(defconstant $kMenuDisposeMsg 9)
(defconstant $kMenuFindItemMsg 10)
(defconstant $kMenuHiliteItemMsg 11)
(defconstant $kMenuDrawItemsMsg 12)
; 
;  
; 
;    * Proc ID for a normal text menu. This constant is not typically
;    * used.
;    

(defconstant $textMenuProc 0)
; 
;    * Menu item command ID to indicate a hierarchical menu; the item
;    * icon ID is the hierarchical menu ID. This constant is deprecated.
;    * Use SetMenuItemHierarchicalID or SetMenuItemHierarchicalMenu
;    * instead of using this constant.
;    

(defconstant $hMenuCmd 27)
; 
;    * A menu ID used with InsertMenu to insert a menu into the
;    * hierarchical portion of the menubar.
;    

(defconstant $kInsertHierarchicalMenu -1)
; 
;    * The old name for kInsertHierarchicalMenu. This constant is
;    * deprecated.
;    

(defconstant $hierMenu -1)
; 
;    * This value may be passed to InsertMenuItem, InsertMenuItemText,
;    * and InsertMenuItemTextWithCFString to indicate that the new item
;    * should be inserted at the end of the menu. Note that you can also
;    * just call AppendMenu[ItemText][WithCFString].
;    

(defconstant $kHIMenuAppendItem #xFFFF)

(defconstant $noMark 0)                         ;  mark symbol for SetItemMark; other mark symbols are defined in Fonts.h 

;  obsolete menu color table constants

(defconstant $mctAllItems -98)                  ; search for all Items for the given ID
; last color table entry has this in ID field

(defconstant $mctLastIDIndic -99)
;  Constants for use with MacOS 8.0 (Appearance 1.0) and later

(defconstant $kMenuStdMenuProc 63)
(defconstant $kMenuStdMenuBarProc 63)
;  For use with Get/SetMenuItemModifiers

(defconstant $kMenuNoModifiers 0)               ;  Mask for no modifiers

(defconstant $kMenuShiftModifier 1)             ;  Mask for shift key modifier

(defconstant $kMenuOptionModifier 2)            ;  Mask for option key modifier

(defconstant $kMenuControlModifier 4)           ;  Mask for control key modifier
;  Mask for no command key modifier

(defconstant $kMenuNoCommandModifier 8)
;  For use with Get/SetMenuItemIconHandle

(defconstant $kMenuNoIcon 0)                    ;  No icon

(defconstant $kMenuIconType 1)                  ;  Type for ICON

(defconstant $kMenuShrinkIconType 2)            ;  Type for ICON plotted 16 x 16

(defconstant $kMenuSmallIconType 3)             ;  Type for SICN

(defconstant $kMenuColorIconType 4)             ;  Type for cicn

(defconstant $kMenuIconSuiteType 5)             ;  Type for Icon Suite

(defconstant $kMenuIconRefType 6)               ;  Type for Icon Ref

(defconstant $kMenuCGImageRefType 7)            ;  Type for a CGImageRef (Mac OS X only)

(defconstant $kMenuSystemIconSelectorType 8)    ;  Type for an IconRef registered with Icon Services under kSystemIconsCreator (Mac OS X 10.1 and later only)

(defconstant $kMenuIconResourceType 9)          ;  Type for a CFStringRef naming a resource in the main bundle of the process (Mac OS X 10.1 and later only)

;  For use with Get/SetMenuItemKeyGlyph

(defconstant $kMenuNullGlyph 0)                 ;  Null (always glyph 1)

(defconstant $kMenuTabRightGlyph 2)             ;  Tab to the right key (for left-to-right script systems)

(defconstant $kMenuTabLeftGlyph 3)              ;  Tab to the left key (for right-to-left script systems)

(defconstant $kMenuEnterGlyph 4)                ;  Enter key

(defconstant $kMenuShiftGlyph 5)                ;  Shift key

(defconstant $kMenuControlGlyph 6)              ;  Control key

(defconstant $kMenuOptionGlyph 7)               ;  Option key

(defconstant $kMenuSpaceGlyph 9)                ;  Space (always glyph 3) key

(defconstant $kMenuDeleteRightGlyph 10)         ;  Delete to the right key (for right-to-left script systems)

(defconstant $kMenuReturnGlyph 11)              ;  Return key (for left-to-right script systems)

(defconstant $kMenuReturnR2LGlyph 12)           ;  Return key (for right-to-left script systems)

(defconstant $kMenuNonmarkingReturnGlyph 13)    ;  Nonmarking return key

(defconstant $kMenuPencilGlyph 15)              ;  Pencil key

(defconstant $kMenuDownwardArrowDashedGlyph 16) ;  Downward dashed arrow key

(defconstant $kMenuCommandGlyph 17)             ;  Command key

(defconstant $kMenuCheckmarkGlyph 18)           ;  Checkmark key

(defconstant $kMenuDiamondGlyph 19)             ;  Diamond key

(defconstant $kMenuAppleLogoFilledGlyph 20)     ;  Apple logo key (filled)

(defconstant $kMenuParagraphKoreanGlyph 21)     ;  Unassigned (paragraph in Korean)

(defconstant $kMenuDeleteLeftGlyph 23)          ;  Delete to the left key (for left-to-right script systems)

(defconstant $kMenuLeftArrowDashedGlyph 24)     ;  Leftward dashed arrow key

(defconstant $kMenuUpArrowDashedGlyph 25)       ;  Upward dashed arrow key

(defconstant $kMenuRightArrowDashedGlyph 26)    ;  Rightward dashed arrow key

(defconstant $kMenuEscapeGlyph 27)              ;  Escape key

(defconstant $kMenuClearGlyph 28)               ;  Clear key

(defconstant $kMenuLeftDoubleQuotesJapaneseGlyph 29);  Unassigned (left double quotes in Japanese)

(defconstant $kMenuRightDoubleQuotesJapaneseGlyph 30);  Unassigned (right double quotes in Japanese)

(defconstant $kMenuTrademarkJapaneseGlyph 31)   ;  Unassigned (trademark in Japanese)

(defconstant $kMenuBlankGlyph 97)               ;  Blank key

(defconstant $kMenuPageUpGlyph 98)              ;  Page up key

(defconstant $kMenuCapsLockGlyph 99)            ;  Caps lock key

(defconstant $kMenuLeftArrowGlyph 100)          ;  Left arrow key

(defconstant $kMenuRightArrowGlyph 101)         ;  Right arrow key

(defconstant $kMenuNorthwestArrowGlyph 102)     ;  Northwest arrow key

(defconstant $kMenuHelpGlyph 103)               ;  Help key

(defconstant $kMenuUpArrowGlyph 104)            ;  Up arrow key

(defconstant $kMenuSoutheastArrowGlyph 105)     ;  Southeast arrow key

(defconstant $kMenuDownArrowGlyph 106)          ;  Down arrow key

(defconstant $kMenuPageDownGlyph 107)           ;  Page down key

(defconstant $kMenuAppleLogoOutlineGlyph 108)   ;  Apple logo key (outline)

(defconstant $kMenuContextualMenuGlyph 109)     ;  Contextual menu key

(defconstant $kMenuPowerGlyph 110)              ;  Power key

(defconstant $kMenuF1Glyph 111)                 ;  F1 key

(defconstant $kMenuF2Glyph 112)                 ;  F2 key

(defconstant $kMenuF3Glyph 113)                 ;  F3 key

(defconstant $kMenuF4Glyph 114)                 ;  F4 key

(defconstant $kMenuF5Glyph 115)                 ;  F5 key

(defconstant $kMenuF6Glyph 116)                 ;  F6 key

(defconstant $kMenuF7Glyph 117)                 ;  F7 key

(defconstant $kMenuF8Glyph 118)                 ;  F8 key

(defconstant $kMenuF9Glyph 119)                 ;  F9 key

(defconstant $kMenuF10Glyph 120)                ;  F10 key

(defconstant $kMenuF11Glyph 121)                ;  F11 key

(defconstant $kMenuF12Glyph 122)                ;  F12 key

(defconstant $kMenuF13Glyph #x87)               ;  F13 key

(defconstant $kMenuF14Glyph #x88)               ;  F14 key

(defconstant $kMenuF15Glyph #x89)               ;  F15 key

(defconstant $kMenuControlISOGlyph #x8A)        ;  Control key (ISO standard)

(defconstant $kMenuEjectGlyph #x8C)             ;  Eject key (available on Jaguar and later)

; 
;  *  MenuAttributes
;  *  
;  *  Summary:
;  *    Menu attributes control behavior of the entire menu. They are
;  *    used with the Get/ChangeMenuAttributes APIs.
;  

(def-mactype :MenuAttributes (find-mactype ':UInt32))
; 
;    * No column space is allocated for the mark character when this menu
;    * is drawn.
;    

(defconstant $kMenuAttrExcludesMarkColumn 1)
; 
;    * The menu title is automatically disabled when all items are
;    * disabled.
;    

(defconstant $kMenuAttrAutoDisable 4)
; 
;    * The pencil glyph from the Keyboard font (kMenuPencilGlyph) is used
;    * to draw the Control modifier key in menu keyboard equivalents.
;    * This appearance is typically used only by Japanese input method
;    * menus.
;    

(defconstant $kMenuAttrUsePencilGlyph 8)
; 
;    * The menu title is not drawn in the menubar, even when the menu is
;    * inserted in the menubar. Useful for adding command keys that don't
;    * correspond to a visible menu item; menu items with the desired
;    * command keys can be added to the menu and inserted in the menubar
;    * without making the menu visible. This attribute is available in
;    * Mac OS X 10.2 and later.
;    

(defconstant $kMenuAttrHidden 16)
; 
;    * If menu item separators are present at the beginning or end of the
;    * menu, or if multiple contiguous separators are present, the extra
;    * separator items are marked as hidden to avoid extra blank space in
;    * the menu. The menu is examined for extra separators whenever the
;    * menu size is recalculated. This attribute is available in Mac OS X
;    * 10.3 and later.
;    

(defconstant $kMenuAttrCondenseSeparators 32)
; 
;    * Disables automatic caching of the menu image by the Menu Manager.
;    * Automatic caching is provided for all menus that use an HIView to
;    * draw their content. Setting this attribute will prevent the Menu
;    * Manager from caching the menu image; instead, the menu will be
;    * drawn using the standard HIView drawing mechanism each time that
;    * it is displayed. This attribute is available in Mac OS X 10.3 and
;    * later.
;    

(defconstant $kMenuAttrDoNotCacheImage 64)
; 
;    * Disables substitution of command keys from the
;    * NSUserKeyEquivalents dictionary. By default, all menu items are
;    * checked for a match in the dictionary. Note that this attribute,
;    * to be effective, should be added at the time that the menu is
;    * created; once the menu has been searched for user command keys
;    * (which occurs in CalcMenuSize, in GetItemCmd and
;    * GetMenuItemCommandKey, and before command key matching), the
;    * original command keys are replaced by the user command keys and
;    * cannot be retrieved. For this reason, it is also not useful to
;    * clear this attribute; the original command keys cannot be
;    * restored. This attribute is available in Mac OS X 10.3 and later.
;    

(defconstant $kMenuAttrDoNotUseUserCommandKeys #x80)
; 
;  *  MenuItemAttributes
;  *  
;  *  Summary:
;  *    Menu item attributes control behavior of individual menu items.
;  *    They are used with the Get/ChangeMenuItemAttributes APIs.
;  

(def-mactype :MenuItemAttributes (find-mactype ':UInt32))
; 
;    * This item is disabled.
;    

(defconstant $kMenuItemAttrDisabled 1)
; 
;    * This item's icon is disabled.
;    

(defconstant $kMenuItemAttrIconDisabled 2)
; 
;    * Allows the parent item of a submenu to be selectable.
;    

(defconstant $kMenuItemAttrSubmenuParentChoosable 4)
; 
;    * This item changes dynamically based on modifier key state.
;    

(defconstant $kMenuItemAttrDynamic 8)
; 
;    * This item is not part of the same dynamic group as the previous
;    * item.
;    

(defconstant $kMenuItemAttrNotPreviousAlternate 16)
; 
;    * This item is not drawn when the menu is displayed. It is also not
;    * included in command key matching, unless the item also has either
;    * the Dynamic or IncludeInCmdKeyMatching attributes.
;    

(defconstant $kMenuItemAttrHidden 32)
; 
;    * This item is a separator; the text of the item is ignored.
;    

(defconstant $kMenuItemAttrSeparator 64)
; 
;    * This item is a menu section header; it is disabled and
;    * unselectable.
;    

(defconstant $kMenuItemAttrSectionHeader #x80)
; 
;    * Metacharacters in the text of this item (such as the dash) are
;    * ignored.
;    

(defconstant $kMenuItemAttrIgnoreMeta #x100)
; 
;    * This item is recognized by IsMenuKeyEvent when it is passed an
;    * auto-repeat keyboard event.
;    

(defconstant $kMenuItemAttrAutoRepeat #x200)
; 
;    * When MenuEvent and IsMenuKeyEvent compare this item's keyboard
;    * equivalent against a keyboard event, they use the item's virtual
;    * keycode equivalent rather than its character code equivalent.
;    

(defconstant $kMenuItemAttrUseVirtualKey #x400)
; 
;    * This item is drawn in a customized fashion by the application.
;    * Causes custom menu item drawing Carbon events to be sent. This
;    * attribute is available in CarbonLib 1.4 and Mac OS X 10.1, and
;    * later.
;    

(defconstant $kMenuItemAttrCustomDraw #x800)
; 
;    * This item is examined during command key matching by MenuKey,
;    * MenuEvent, and IsMenuKeyEvent. Normally, visible menu items are
;    * included in command key matching, but hidden menu items are
;    * excluded (unless the item also has the Dynamic menu item
;    * attribute). The IncludeInCmdKeyMatching attribute can be used to
;    * force a hidden, non-dynamic menu item to be included in command
;    * key matching when it normally wouldn't. This attribute is
;    * available in CarbonLib 1.6 and Mac OS X 10.2 and later.
;    

(defconstant $kMenuItemAttrIncludeInCmdKeyMatching #x1000)
; 
;    * This item is automatically disabled if, when
;    * kEventCommandUpdateStatus is sent for this item, no handler is
;    * installed or all handlers return eventNotHandledErr. A return
;    * value from any handler of any value other than eventNotHandledErr
;    * will prevent automatic disabling. This attribute is useful for
;    * applications that use kEventCommandUpdateStatus events for all
;    * menu item enabling; previously, an application would need to
;    * install UpdateStatus handlers on its application target to disable
;    * all items in the application that were unnecessary when no
;    * document windows were open. By setting this attribute, all menu
;    * items will be disabled automatically unless specifically enabled
;    * by an UpdateStatus handler on a window, control, or application
;    * target. This attribute is available in Mac OS X 10.3 and later.
;    

(defconstant $kMenuItemAttrAutoDisable #x2000)
; 
;    * During command key matching, the Menu Manager uses a cache of the
;    * available command keys to locate the menu item that matches an
;    * event. Before returning this item, the Menu Manager sends a
;    * kEventMenuEnableItems event to the menu containing the item, and a
;    * kEventCommandUpdateStatus event to each item in the menu, so that
;    * the item can be properly enabled or disabled. For some
;    * applications, updating the item status for each item in the menu
;    * is quite expensive, and also unnecessary since only a single item
;    * actually needs to be updated. Setting this attribute indicates to
;    * the Menu Manager that it only needs to send a
;    * kEventCommandUpdateStatus event to this menu item before returning
;    * it from command key matching; kEventMenuEnableItems will not be
;    * sent to the menu, and no other menu item will receive
;    * kEventCommandUpdateStatus.
;    

(defconstant $kMenuItemAttrUpdateSingleItem #x4000)
; 
;  *  MenuTrackingMode
;  *  
;  *  Summary:
;  *    A menu tracking mode constant is part of the
;  *    kEventMenuBeginTracking and kEventMenuChangeTrackingMode Carbon
;  *    events. It indicates whether menus are being tracked using the
;  *    mouse or keyboard.
;  

(def-mactype :MenuTrackingMode (find-mactype ':UInt32))
; 
;    * Menus are being tracked using the mouse.
;    

(defconstant $kMenuTrackingModeMouse 1)
; 
;    * Menus are being tracked using the keyboard.
;    

(defconstant $kMenuTrackingModeKeyboard 2)
; 
;  *  MenuEventOptions
;  *  
;  *  Summary:
;  *    Menu event options control how the menus are searched for an item
;  *    matching a particular keyboard event. They are used with the
;  *    IsMenuKeyEvent API.
;  

(def-mactype :MenuEventOptions (find-mactype ':UInt32))
; 
;    * Disabled items are examined for a match.
;    

(defconstant $kMenuEventIncludeDisabledItems 1)
; 
;    * Don't hilite the menu title if a match is found.
;    

(defconstant $kMenuEventQueryOnly 2)
; 
;    * Don't look for a match in submenus of the starting menu.
;    

(defconstant $kMenuEventDontCheckSubmenus 4)
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Menu Types                                                                        
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :MenuID (find-mactype ':SInt16))

(def-mactype :MenuItemIndex (find-mactype ':UInt16))

(def-mactype :MenuCommand (find-mactype ':UInt32))

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
(defrecord (MenuInfo :handle)
   (menuID :SInt16)                             ;  in Carbon use Get/SetMenuID
   (menuWidth :SInt16)                          ;  in Carbon use Get/SetMenuWidth
   (menuHeight :SInt16)                         ;  in Carbon use Get/SetMenuHeight
   (menuProc :Handle)                           ;  not supported in Carbon
   (enableFlags :signed-long)                   ;  in Carbon use Enable/DisableMenuItem, IsMenuItemEnable
   (menuData (:string 255))                     ;  in Carbon use Get/SetMenuTitle
)

;type name? (def-mactype :MenuInfo (find-mactype ':MenuInfo))

(def-mactype :MenuPtr (find-mactype '(:pointer :MenuInfo)))

(def-mactype :MenuHandle (find-mactype '(:pointer :MenuPtr)))
 |#

; #else

(def-mactype :MenuRef (find-mactype '(:pointer :OpaqueMenuRef)))
;  MenuHandle is old name for MenuRef

(def-mactype :MenuHandle (find-mactype ':MenuRef))

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */

; 
;    A MenuBarHandle is a handle to a MenuBarHeader. An instance of this structure is returned
;    by the GetMenuBar and GetNewMBar APIs. It is typedef'd to a plain Handle to retain
;    source compatibility with previous versions of this header file.
; 

(def-mactype :MenuBarHandle (find-mactype ':Handle))
; 
;  *  MenuBarHeader
;  *  
;  *  Summary:
;  *    This structure is contained in a MenuBarHandle. It contains a
;  *    list of the non-hierarchical menus that have been inserted into
;  *    the menubar.
;  *  
;  *  Discussion:
;  *    The MenuBarHandle is a dynamically sized object which cannot be
;  *    directly expressed as a C or Pascal structure. First is the
;  *    MenuBarHeader structure, followed by a dynamically sized array of
;  *    MenuBarMenus, one for each menu. This array is followed by the
;  *    HMenuBarHeader, followed by another dynamically sized array of
;  *    HMenuBarMenus, one for each hierarchical menu.
;  
(defrecord MenuBarHeader
                                                ; 
;    * Offset in bytes from the start of the header to the last menu in
;    * the array of MenuBarMenus.
;    
   (lastMenu :UInt16)
                                                ; 
;    * Global coordinate of the right edge of the rightmost menu; unused
;    * in a MenuBarHandle returned by GetMenuBar or GetNewMBar.
;    
   (lastRight :SInt16)
                                                ; 
;    * The MBDF resource ID; unused in a MenuBarHandle returned by
;    * GetMenuBar or GetNewMBar.
;    
   (mbResID :SInt16)
)

;type name? (%define-record :MenuBarHeader (find-record-descriptor ':MenuBarHeader))
; 
;  *  HMenuBarHeader
;  *  
;  *  Summary:
;  *    This structure is contained in a MenuBarHandle. It contains a
;  *    list of the hierarchical menus that have been inserted into the
;  *    menubar with InsertMenu( menu, -1 ).
;  *  
;  *  Discussion:
;  *    The hierarchical portion of the menubar follows the
;  *    non-hierarchical portion in a menubar handle. The hierarchical
;  *    portion begins with the HMenuBarHeader structure, followed by a
;  *    dynamically sized array of HMenuBarMenus.
;  
(defrecord HMenuBarHeader
                                                ; 
;    * Offset in bytes from the start of the header to the last menu in
;    * the array of HMenuBarMenus.
;    
   (lastHMenu :UInt16)
                                                ; 
;    * Saved bits behind the hilited menu title; unused in a
;    * MenuBarHandle returned by GetMenuBar or GetNewMBar.
;    
   (menuTitleBits (:Handle :PixMap))
)

;type name? (%define-record :HMenuBarHeader (find-record-descriptor ':HMenuBarHeader))
; 
;  *  MenuBarMenu
;  *  
;  *  Summary:
;  *    This structure contains a single menu in the menubar. It is an
;  *    element in an array in the MenuBarHeader data strucuture.
;  
(defrecord MenuBarMenu
                                                ; 
;    * A menu in the menubar.
;    
   (menu (:pointer :OpaqueMenuRef))
                                                ; 
;    * The global coordinate of the left edge of the menu title; unused
;    * in a MenuBarHandle returned by GetMenuBar or GetNewMBar.
;    
   (menuLeft :SInt16)
)

;type name? (%define-record :MenuBarMenu (find-record-descriptor ':MenuBarMenu))
; 
;  *  HMenuBarMenu
;  *  
;  *  Summary:
;  *    This structure contains a single hierarchical menu in the
;  *    menubar. It is an element in an array in the HMenuBarHeader data
;  *    strucuture.
;  
(defrecord HMenuBarMenu
                                                ; 
;    * An hierarchical menu in the menubar.
;    
   (menu (:pointer :OpaqueMenuRef))
                                                ; 
;    * This field is currently unused.
;    
   (reserved :SInt16)
)

;type name? (%define-record :HMenuBarMenu (find-record-descriptor ':HMenuBarMenu))
(defrecord MCEntry
   (mctID :SInt16)                              ; menu ID.  ID = 0 is the menu bar
   (mctItem :SInt16)                            ; menu Item. Item = 0 is a title
   (mctRGB1 :RGBColor)                          ; usage depends on ID and Item
   (mctRGB2 :RGBColor)                          ; usage depends on ID and Item
   (mctRGB3 :RGBColor)                          ; usage depends on ID and Item
   (mctRGB4 :RGBColor)                          ; usage depends on ID and Item
   (mctReserved :SInt16)                        ; reserved for internal use
)

;type name? (%define-record :MCEntry (find-record-descriptor ':MCEntry))

(def-mactype :MCEntryPtr (find-mactype '(:pointer :MCEntry)))
(defrecord MCTable
   (contents (:array :MCEntry 1))
)
(def-mactype :MCTablePtr (find-mactype '(:pointer :MCEntry)))

(def-mactype :MCTableHandle (find-mactype '(:handle :MCEntry)))
(defrecord (MenuCRsrc :handle)
   (numEntries :SInt16)                         ; number of entries
   (mcEntryRecs :MCTABLE)                       ; ARRAY [1..numEntries] of MCEntry
)

;type name? (%define-record :MenuCRsrc (find-record-descriptor ':MenuCRsrc))

(def-mactype :MenuCRsrcPtr (find-mactype '(:pointer :MenuCRsrc)))

(def-mactype :MenuCRsrcHandle (find-mactype '(:handle :MenuCRsrc)))

; #if TARGET_OS_WIN32
#|                                              ;  QuickTime 3.0 
(defrecord MenuAccessKeyRec
   (count :SInt16)
   (flags :signed-long)
   (keys (:array :UInt8 1))
)

;type name? (def-mactype :MenuAccessKeyRec (find-mactype ':MenuAccessKeyRec))

(def-mactype :MenuAccessKeyPtr (find-mactype '(:pointer :MenuAccessKeyRec)))

(def-mactype :MenuAccessKeyHandle (find-mactype '(:pointer :MenuAccessKeyPtr)))
; 
;  *  SetMenuItemHotKey()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
 |#

; #endif  /* TARGET_OS_WIN32 */

; 
;  *  MenuTrackingData
;  *  
;  *  Summary:
;  *    The MenuTrackingData structure contains information about a menu
;  *    currently being displayed. It is used with the
;  *    GetMenuTrackingData API.
;  
(defrecord MenuTrackingData
   (menu (:pointer :OpaqueMenuRef))
   (itemSelected :UInt16)
   (itemUnderMouse :UInt16)
   (itemRect :Rect)
   (virtualMenuTop :SInt32)
   (virtualMenuBottom :SInt32)
)

;type name? (%define-record :MenuTrackingData (find-record-descriptor ':MenuTrackingData))

(def-mactype :MenuTrackingDataPtr (find-mactype '(:pointer :MenuTrackingData)))
; 
;  *  MDEFHiliteItemData
;  *  
;  *  Summary:
;  *    The MDEFHiliteItemData structure contains information about which
;  *    menu items should be hilited and unhilited as the user moves
;  *    through the menus. It is used by menu definition functions, which
;  *    receive a pointer to an MDEFHiliteItemData structure as the
;  *    whichItem parameter during kMenuHiliteItemMsg.
;  
(defrecord MDEFHiliteItemData
                                                ; 
;    * The item that was previously selected. It should be redrawn in an
;    * unhilited state. May be zero if no item was previously selected.
;    
   (previousItem :UInt16)
                                                ; 
;    * The item that is now selected. It should be redrawn in a hilited
;    * state. May be zero if no item is now selected.
;    
   (newItem :UInt16)
                                                ; 
;    * A CoreGraphics context that the MDEF should draw into. The Menu
;    * Manager will flush the context after the MDEF has returned.
;    
   (context :pointer)
)

;type name? (%define-record :MDEFHiliteItemData (find-record-descriptor ':MDEFHiliteItemData))

(def-mactype :MDEFHiliteItemDataPtr (find-mactype '(:pointer :MDEFHiliteItemData)))

(%define-record :HiliteMenuItemData (find-record-descriptor ':MDEFHiliteItemData))

(def-mactype :HiliteMenuItemDataPtr (find-mactype ':MDEFHiliteItemDataPtr))
; 
;  *  MDEFDrawData
;  *  
;  *  Summary:
;  *    The MDEFDrawData structure contains information needed to draw a
;  *    menu. It is used by menu definition functions, which receive a
;  *    pointer to an MDEFDrawData structure as the whichItem parameter
;  *    during kMenuDrawMsg.
;  
(defrecord MDEFDrawData
                                                ; 
;    * Information about the menu being drawn. The MDEF should fill in
;    * the virtualMenuTop and virtualMenuBottom fields of this structure
;    * while drawing the menu.
;    
   (trackingData :MenuTrackingData)
                                                ; 
;    * A CoreGraphics context that the MDEF should draw into. The Menu
;    * Manager will flush the context after the MDEF has returned.
;    
   (context :pointer)
)

;type name? (%define-record :MDEFDrawData (find-record-descriptor ':MDEFDrawData))

(def-mactype :MDEFDrawDataPtr (find-mactype '(:pointer :MDEFDrawData)))
; 
;  *  MDEFFindItemData
;  *  
;  *  Summary:
;  *    The MDEFFindItemData structure contains information needed to
;  *    determine which item is currently selected by the user. It is
;  *    used by menu definition functions, which receive a pointer to an
;  *    MDEFDrawData structure as the whichItem parameter during
;  *    kMenuFindItemMsg.
;  
(defrecord MDEFFindItemData
                                                ; 
;    * Information about the menu being drawn. The MDEF should fill in
;    * the itemSelected, itemUnderMouse, and itemRect fields of this
;    * structure after determining which item is at the specified point.
;    
   (trackingData :MenuTrackingData)
                                                ; 
;    * A CoreGraphics context that the MDEF should draw into if it needs
;    * to scroll the menu during the FindItem message. The Menu Manager
;    * will flush the context after the MDEF has returned.
;    
   (context :pointer)
)

;type name? (%define-record :MDEFFindItemData (find-record-descriptor ':MDEFFindItemData))

(def-mactype :MDEFFindItemDataPtr (find-mactype '(:pointer :MDEFFindItemData)))
; 
;  *  MDEFDrawItemsData
;  *  
;  *  Summary:
;  *    The MDEFDrawItemsData structure contains information about which
;  *    menu items to redraw. It is used by menu definition functions,
;  *    which receive a pointer to an MDEFDrawItemsData structure as the
;  *    whichItem parameter during kMenuDrawItemsMsg.
;  
(defrecord MDEFDrawItemsData
                                                ; 
;    * The first item to draw.
;    
   (firstItem :UInt16)
                                                ; 
;    * The last item to draw.
;    
   (lastItem :UInt16)
                                                ; 
;    * Information about the menu's tracking state. The virtualMenuTop
;    * and virtualMenuBottom fields in this structure will be the most
;    * useful in handling the DrawItems message.
;    
   (trackingData (:pointer :MenuTrackingData))
                                                ; 
;    * A CoreGraphics context that the MDEF should draw into. The Menu
;    * Manager will flush the context after the MDEF returns.
;    
   (context :pointer)
)

;type name? (%define-record :MDEFDrawItemsData (find-record-descriptor ':MDEFDrawItemsData))

(def-mactype :MDEFDrawItemsDataPtr (find-mactype '(:pointer :MDEFDrawItemsData)))
; 
;  *  Summary:
;  *    A MenuItemDataFlags value indicates which fields of a
;  *    MenuItemDataRec structure should be used by the
;  *    Copy/SetMenuItemData APIs. All MenuItemDataFlags may be used when
;  *    getting or setting the contents of a menu item; some may also be
;  *    used when getting or setting information about the menu itself,
;  *    if the item index given to Copy/SetMenuItemData is 0.
;  
; 
;    * Set or return the Str255 text of a menu using the
;    * MenuItemDataRec.text field. If getting the text, the text field
;    * must be initialized with a pointer to a Str255 variable before
;    * calling CopyMenuItemData. If both kMenuItemDataText and
;    * kMenuItemCFString are set on entry to CopyMenuItemData, the API
;    * will determine whether the menu text was most recently set using a
;    * Str255 or CFString, and return only that text format; the flags
;    * value for the other format will be cleared. Valid for both menu
;    * items and the menu title (if item number is 0).
;    

(defconstant $kMenuItemDataText 1)
; 
;    * Set or return the mark character of a menu item using the
;    * MenuItemDataRec.mark field. Valid only for menu items.
;    

(defconstant $kMenuItemDataMark 2)
; 
;    * Set or return the command key of a menu item using the
;    * MenuItemDataRec.cmdKey field. Valid only for menu items.
;    

(defconstant $kMenuItemDataCmdKey 4)
; 
;    * Set or return the command key glyph of a menu item using the
;    * MenuItemDataRec.cmdKeyGlyph field. Valid only for menu items.
;    

(defconstant $kMenuItemDataCmdKeyGlyph 8)
; 
;    * Set or return the command key modifiers of a menu item using the
;    * MenuItemDataRec.cmdKeyModifiers field. Valid only for menu items.
;    

(defconstant $kMenuItemDataCmdKeyModifiers 16)
; 
;    * Set or return the QuickDraw text style of a menu item using the
;    * MenuItemDataRec.style field. Valid only for menu items.
;    

(defconstant $kMenuItemDataStyle 32)
; 
;    * Set or return the enable state of a menu using the
;    * MenuItemDataRec.enabled field. Valid for both menu items and the
;    * menu itself (if item number is 0).
;    

(defconstant $kMenuItemDataEnabled 64)
; 
;    * Set or return the enable state of a menu item icon using the
;    * MenuItemDataRec.iconEnabled field. Valid only for menu items.
;    

(defconstant $kMenuItemDataIconEnabled #x80)
; 
;    * Set or return the icon resource ID of a menu item using the
;    * MenuItemDataRec.iconID field. Valid only for menu items.
;    

(defconstant $kMenuItemDataIconID #x100)
; 
;    * Set or return the icon handle of a menu item using the
;    * MenuItemDataRec.iconType and MenuItemDataRec.iconHandle fields.
;    * Both fields must be initialized if setting the icon handle; both
;    * fields will be returned when getting the handle. The iconType
;    * field should contain one of the constants kMenuIconType,
;    * kMenuShrinkIconType, kMenuSmallIconType, kMenuColorIconType,
;    * kMenuIconSuiteType, or kMenuIconRefType. An icon handle may be a
;    * handle to an ICON resource, a SICN resource, a cicn resource, an
;    * IconSuite, or an IconRef. Valid only for menu items.
;    

(defconstant $kMenuItemDataIconHandle #x200)
; 
;    * Set or return the command ID of a menu item using the
;    * MenuItemDataRec.cmdID field. Valid only for menu items.
;    

(defconstant $kMenuItemDataCommandID #x400)
; 
;    * Set or return the text encoding of a menu item using the
;    * MenuItemDataRec.encoding field. Valid only for menu items.
;    

(defconstant $kMenuItemDataTextEncoding #x800)
(defconstant $kMenuItemDataSubmenuID #x1000)
(defconstant $kMenuItemDataSubmenuHandle #x2000)
(defconstant $kMenuItemDataFontID #x4000)
(defconstant $kMenuItemDataRefcon #x8000)
(defconstant $kMenuItemDataAttributes #x10000)
(defconstant $kMenuItemDataCFString #x20000)
; 
;    * Set or return the properties of a menu using the
;    * MenuItemDataRec.properties field. If setting the properties, the
;    * properties field should contain a collection with the new
;    * properties; existing menu properties with the same collection
;    * creator and tag will be replaced by the new properties. If getting
;    * the properties, the properties field should either be set to NULL
;    * or to a valid Collection. If NULL, a new collection is allocated
;    * by the CopyMenuItemData and returned in the properties field. If
;    * not NULL, the entire contents of the collection are replaced by
;    * the properties of the menu. Valid for both menu items and the menu
;    * itself (if item number is 0).
;    

(defconstant $kMenuItemDataProperties #x40000)
; 
;    * Set or return the item indent level of a menu item using the
;    * MenuItemDataRec.indent field. Valid only for menu items.
;    

(defconstant $kMenuItemDataIndent #x80000)
; 
;    * Set or return the virtual key code keyboard equivalent of a menu
;    * item using the MenuItemDataRec.cmdVirtualKey field. Valid only for
;    * menu items. On output, only valid if the item has the
;    * kMenuItemAttrUseVirtualKeyCode attribute.
;    

(defconstant $kMenuItemDataCmdVirtualKey #x100000)
(defconstant $kMenuItemDataAllDataVersionOne #xFFFFF)
(defconstant $kMenuItemDataAllDataVersionTwo #x1FFFFF)

(defconstant $kMenuItemDataAllData #x1FFFFF)

(%define-record :MenuItemDataFlags (find-record-descriptor ':UInt64))
; 
;  *  MenuItemDataRec
;  *  
;  *  Summary:
;  *    The MenuItemDataRec structure is used to get and change aspects
;  *    of a menu item. It is used with the Copy/SetMenuItemData APIs.
;  *  
;  *  Discussion:
;  *    When using this structure with Copy/SetMenuItemData, the caller
;  *    must first set the whichData field to a combination of
;  *    MenuItemDataFlags indicating which specific data should be
;  *    retrieved or set. Some fields also require initialization before
;  *    calling CopyMenuItemData; see the individual MenuItemDataFlags
;  *    documentation for details.
;  
(defrecord MenuItemDataRec
   (whichData :MENUITEMDATAFLAGS)
   (text (:pointer :UInt8))
   (mark :UInt16)
   (cmdKey :UInt16)
   (cmdKeyGlyph :UInt32)
   (cmdKeyModifiers :UInt32)
   (style :UInt8)
   (enabled :Boolean)
   (iconEnabled :Boolean)
   (filler1 :UInt8)
   (iconID :SInt32)
   (iconType :UInt32)
   (iconHandle :Handle)
   (cmdID :UInt32)
   (encoding :UInt32)
   (submenuID :SInt16)
   (submenuHandle (:pointer :OpaqueMenuRef))
   (fontID :SInt32)
   (refcon :UInt32)
   (attr :UInt32)
   (cfText (:pointer :__CFString))
   (properties (:pointer :OpaqueCollection))
   (indent :UInt32)
   (cmdVirtualKey :UInt16)
)

;type name? (%define-record :MenuItemDataRec (find-record-descriptor ':MenuItemDataRec))

(def-mactype :MenuItemDataPtr (find-mactype '(:pointer :MenuItemDataRec)))

(def-mactype :MenuItemID (find-mactype ':UInt32))
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Menu ProcPtrs                                                                     
;                                                                                       
;   All of these procs are considered deprecated.  Developers interested in portability 
;   to Carbon should avoid them entirely, if at all possible.                           
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :MenuDefProcPtr (find-mactype ':pointer)); (short message , MenuRef theMenu , Rect * menuRect , Point hitPt , short * whichItem)

(def-mactype :MenuDefUPP (find-mactype '(:pointer :OpaqueMenuDefProcPtr)))
; 
;  *  NewMenuDefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMenuDefUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMenuDefProcPtr)
() )
; 
;  *  DisposeMenuDefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMenuDefUPP" 
   ((userUPP (:pointer :OpaqueMenuDefProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeMenuDefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMenuDefUPP" 
   ((message :SInt16)
    (theMenu (:pointer :OpaqueMenuRef))
    (menuRect (:pointer :Rect))
    (hitPt :Point)
    (whichItem (:pointer :short))
    (userUPP (:pointer :OpaqueMenuDefProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

(def-mactype :MenuBarDefProcPtr (find-mactype ':pointer)); (short selector , short message , short parameter1 , long parameter2)

(def-mactype :MenuHookProcPtr (find-mactype ':pointer)); (void)

(def-mactype :MBarHookProcPtr (find-mactype ':pointer)); (Rect * menuRect)

(def-mactype :MenuBarDefUPP (find-mactype '(:pointer :OpaqueMenuBarDefProcPtr)))

(def-mactype :MenuHookUPP (find-mactype '(:pointer :OpaqueMenuHookProcPtr)))

(def-mactype :MBarHookUPP (find-mactype '(:pointer :OpaqueMBarHookProcPtr)))
; 
;  *  NewMenuBarDefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  NewMenuHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  NewMBarHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeMenuBarDefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeMenuHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeMBarHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeMenuBarDefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeMenuHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeMBarHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  Summary:
;  *    Types of custom menu definitions.
;  
; 
;    * A custom menu definition using a function pointer based on the
;    * pre-Carbon MDEF model.
;    

(defconstant $kMenuDefProcPtr 0)
; 
;    * A custom menu definition using an HIView subclass. Available in
;    * Mac OS X 10.3 and later.
;    

(defconstant $kMenuDefClassID 1)

(def-mactype :MenuDefType (find-mactype ':UInt32))
; 
;  *  MenuDefSpec
;  *  
;  *  Summary:
;  *    Specifies a custom menu definition.
;  
(defrecord MenuDefSpec
                                                ; 
;    * The type of menu definition: either kMenuDefProcPtr or
;    * kMenuDefClassID. kMenuDefClassID may only be used in Mac OS X 10.3
;    * and later.
;    
   (defType :UInt32)
   (:variant
   (
   (defProc (:pointer :OpaqueMenuDefProcPtr))
   )
   (
   (classID (:pointer :__CFString))
   (initEvent (:pointer :OpaqueEventRef))
   )
   )
)

;type name? (%define-record :MenuDefSpec (find-record-descriptor ':MenuDefSpec))

(def-mactype :MenuDefSpecPtr (find-mactype '(:pointer :MenuDefSpec)))
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Menu Manager Initialization                                                       
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  InitProcMenu()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  InitMenus()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Menu Manipulation                                                                 
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  NewMenu()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewMenu" 
   ((menuID :SInt16)
    (menuTitle (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMenuRef)
() )
; 
;  *  [Mac]GetMenu()
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
; #define MacGetMenu GetMenu

; #endif


(deftrap-inline "_GetMenu" 
   ((resourceID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMenuRef)
() )
; 
;  *  DisposeMenu()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposeMenu" 
   ((theMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CalcMenuSize()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CalcMenuSize" 
   ((theMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CountMItems()
;  *  
;  *  Summary:
;  *    Renamed to CountMenuItems in Carbon
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  CountMenuItems()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.3 and later or as macro/inline
;  

(deftrap-inline "_CountMenuItems" 
   ((theMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt16
() )
;  Routines available in Mac OS 8.5 and later, and on Mac OS 8.1 and later using CarbonLib 1.1 and later
; 
;  *  GetMenuFont()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_GetMenuFont" 
   ((menu (:pointer :OpaqueMenuRef))
    (outFontID (:pointer :SInt16))
    (outFontSize (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetMenuFont()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_SetMenuFont" 
   ((menu (:pointer :OpaqueMenuRef))
    (inFontID :SInt16)
    (inFontSize :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetMenuExcludesMarkColumn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_GetMenuExcludesMarkColumn" 
   ((menu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SetMenuExcludesMarkColumn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_SetMenuExcludesMarkColumn" 
   ((menu (:pointer :OpaqueMenuRef))
    (excludesMark :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RegisterMenuDefinition()
;  *  
;  *  Summary:
;  *    Registers or unregisters a binding between a resource ID and a
;  *    menu definition function.
;  *  
;  *  Discussion:
;  *    In the classic Mac OS Menu Manager, a 'MENU' resource can contain
;  *    an embedded MDEF procID that is used by the Menu Manager as the
;  *    resource ID of an 'MDEF' resource to measure and draw the menu.
;  *    The 'MDEF' resource is loaded by the Menu Manager when you load
;  *    the menu with GetMenu. Since MDEFs can no longer be packaged as
;  *    code resources on Carbon, the procID can no longer refer directly
;  *    to an MDEF resource. However, using RegisterMenuDefinition you
;  *    can instead specify a UniversalProcPtr pointing to code in your
;  *    application code fragment.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inResID:
;  *      An MDEF proc ID, as used in a 'MENU' resource.
;  *    
;  *    inDefSpec:
;  *      Specifies the MenuDefUPP that should be used for menus with the
;  *      given MDEF proc ID. Passing NULL allows you to unregister the
;  *      menu definition that had been associated with the given MDEF
;  *      proc ID.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RegisterMenuDefinition" 
   ((inResID :SInt16)
    (inDefSpec (:pointer :MenuDefSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateNewMenu()
;  *  
;  *  Summary:
;  *    Creates a new, untitled, empty menu.
;  *  
;  *  Discussion:
;  *    CreateNewMenu is preferred over NewMenu because it allows you to
;  *    specify the menu's attributes and it does not require you to
;  *    specify a Str255-based menu title. To set the menu title, you can
;  *    use either SetMenuTitle or SetMenuTitleWithCFString.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenuID:
;  *      The menu ID to use for the new menu. Zero is a valid menu ID in
;  *      Carbon.
;  *    
;  *    inMenuAttributes:
;  *      The menu attributes to use for the new menu.
;  *    
;  *    outMenuRef:
;  *      On exit, contains the new menu.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateNewMenu" 
   ((inMenuID :SInt16)
    (inMenuAttributes :UInt32)
    (outMenuRef (:pointer :MenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateCustomMenu()
;  *  
;  *  Summary:
;  *    Creates a new, untitled, empty menu using a custom menu
;  *    definition function.
;  *  
;  *  Discussion:
;  *    Similar to CreateNewMenu, but also allows you to specify a custom
;  *    menu definition function.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDefSpec:
;  *      Specifies a custom menu definition function. defSpec->defType
;  *      must be kMenuDefProcPtr or, on Mac OS X 10.3 and later,
;  *      kMenuDefClassID.
;  *    
;  *    inMenuID:
;  *      The menu ID to use for the new menu.
;  *    
;  *    inMenuAttributes:
;  *      The menu attributes to use for the new menu.
;  *    
;  *    outMenuRef:
;  *      On exit, contains the new menu.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateCustomMenu" 
   ((inDefSpec (:pointer :MenuDefSpec))
    (inMenuID :SInt16)
    (inMenuAttributes :UInt32)
    (outMenuRef (:pointer :MenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  IsValidMenu()
;  *  
;  *  Summary:
;  *    Determines if a menu is valid.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu to check for validity.
;  *  
;  *  Result:
;  *    Indicates whether the menu is valid.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsValidMenu" 
   ((inMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  GetMenuRetainCount()
;  *  
;  *  Summary:
;  *    Returns the retain count of this menu.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu whose retain count to increment.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuRetainCount" 
   ((inMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  RetainMenu()
;  *  
;  *  Summary:
;  *    Increments the retain count of a menu.
;  *  
;  *  Discussion:
;  *    RetainMenu does not create a new menu. It simply adds one to the
;  *    retain count. If called on a menu that was not created by
;  *    CarbonLib, it will not affect the menu's retain count.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu whose retain count to increment.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RetainMenu" 
   ((inMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ReleaseMenu()
;  *  
;  *  Summary:
;  *    Decrements the retain count of a menu.
;  *  
;  *  Discussion:
;  *    If called on a menu that was not created by CarbonLib, it will
;  *    not affect the menu's retain count.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu whose retain count to decrement. If the retain count
;  *      falls to zero, the menu is destroyed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ReleaseMenu" 
   ((inMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DuplicateMenu()
;  *  
;  *  Summary:
;  *    Creates a new menu that is a copy of another menu.
;  *  
;  *  Discussion:
;  *    Unlike RetainMenu, DuplicateMenu creates an entirely new menu
;  *    that is an exact copy of the original menu. The MDEF for the new
;  *    menu will receive an init message after the menu has been fully
;  *    created.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inSourceMenu:
;  *      The menu to duplicate.
;  *    
;  *    outMenu:
;  *      On exit, a copy of the source menu.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DuplicateMenu" 
   ((inSourceMenu (:pointer :OpaqueMenuRef))
    (outMenu (:pointer :MenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CopyMenuTitleAsCFString()
;  *  
;  *  Summary:
;  *    Returns a CFString containing the title of a menu.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu whose title to return.
;  *    
;  *    outString:
;  *      On exit, a CFString containing the menu's title. This string
;  *      must be released by the caller.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CopyMenuTitleAsCFString" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (outString (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetMenuTitleWithCFString()
;  *  
;  *  Summary:
;  *    Sets the title of a menu to the text contained in a CFString.
;  *  
;  *  Discussion:
;  *    The Menu Manager will either make its own copy or just increment
;  *    the refcount of the CFString before returning from
;  *    SetMenuTitleWithCFString, depending on whether the string is
;  *    mutable or immutable. If the string is mutable, modifying the
;  *    string after calling SetMenuTitleWithCFString will have no effect
;  *    on the menu's actual title. The caller may release the string
;  *    after calling SetMenuTitleWithCFString.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu whose title to set.
;  *    
;  *    inString:
;  *      The string containing the new menu title text.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetMenuTitleWithCFString" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inString (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetMenuTitleIcon()
;  *  
;  *  Summary:
;  *    Sets the title of a menu to be an icon.
;  *  
;  *  Discussion:
;  *    The Menu Manager takes ownership of the supplied icon after this
;  *    call. When a menu with an title icon is disposed, the Menu
;  *    Manager will dispose the icon also; the Menu Manager will also
;  *    dispose of the current title icon when a new text or icon title
;  *    is supplied for a menu. If an IconRef or CGImageRef is specified,
;  *    the Menu Manager will increment its refcount, so you may freely
;  *    release your reference to the icon or image without invalidating
;  *    the Menu Manager's copy. The menubar will be invalidated by this
;  *    call, and redrawn at the next opportunity.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu whose title to set.
;  *    
;  *    inType:
;  *      The type of icon being used to specify the icon title; use
;  *      kMenuNoIcon to remove the icon from the menu title. In Mac OS X
;  *      10.2 and earlier, the supported types are kMenuIconSuiteType
;  *      and kMenuIconRefType; Mac OS X 10.3 also support
;  *      kMenuCGImageRefType.
;  *    
;  *    inIcon:
;  *      The icon; must be NULL if inType is kMenuNoIcon. The supported
;  *      icon formats are IconSuiteRef, IconRef, and in Mac OS X 10.3
;  *      and later, CGImageRef.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetMenuTitleIcon" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inType :UInt32)
    (inIcon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetMenuTitleIcon()
;  *  
;  *  Summary:
;  *    Retrieves the icon, if any, being used as the title of a menu.
;  *  
;  *  Discussion:
;  *    This API does not increment a refcount on the returned icon. The
;  *    caller should not release the icon.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu whose icon title to retrieve.
;  *    
;  *    outType:
;  *      On exit, contains the type of icon being used as the title of
;  *      the menu. Contains kMenuNoIcon if the menu does not have an
;  *      icon title.
;  *    
;  *    outIcon:
;  *      On exit, contains the IconSuiteRef, IconRef, or CGImageRef
;  *      being used as the title of the menu, or NULL if the menu does
;  *      not have an icon title. May be NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuTitleIcon" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (outType (:pointer :UInt32))                ;  can be NULL 
    (outIcon :pointer)                          ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InvalidateMenuSize()
;  *  
;  *  Summary:
;  *    Invalidates the menu size so that it will be recalculated when
;  *    next displayed.
;  *  
;  *  Discussion:
;  *    The pre-Carbon technique for invalidating the menu size was to
;  *    set the width and height to -1. Although this technique still
;  *    works, for best compatibility it's preferable to use the
;  *    InvalidateMenuSize API so that the Menu Manager has explicit
;  *    notification that the menu is invalid.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu whose size to invalidate.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvalidateMenuSize" 
   ((inMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  IsMenuSizeInvalid()
;  *  
;  *  Summary:
;  *    Determines if a menu's size is invalid and should be recalculated.
;  *  
;  *  Discussion:
;  *    The pre-Carbon technique for determining if a menu's size is
;  *    invalid was to check if the width or height was -1. This
;  *    technique is not always reliable on Carbon due to implementation
;  *    changes in the Menu Manager. You should now use IsMenuSizeInvalid
;  *    instead.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu whose size to examine.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsMenuSizeInvalid" 
   ((inMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • MDEF support                                                                      
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  EraseMenuBackground()
;  *  
;  *  Summary:
;  *    Erases a portion of a menu background in preparation for further
;  *    drawing.
;  *  
;  *  Discussion:
;  *    It is necessary to erase the menu background before calling
;  *    DrawThemeMenuBackground because some themes (such as Aqua on Mac
;  *    OS X) draw the menu background using the alpha channel, and if
;  *    the area underneath the menu background is not erased, portions
;  *    of the old image will show through the menu background.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu whose background to erase.
;  *    
;  *    inEraseRect:
;  *      The bounds of the area to erase, in local coordinates to the
;  *      current port.
;  *    
;  *    inContext:
;  *      The CG context to erase. If NULL, EraseMenuBackground will
;  *      create a context based on the current port.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_EraseMenuBackground" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inEraseRect (:pointer :Rect))
    (inContext (:pointer :CGContext))           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  ScrollMenuImage()
;  *  
;  *  Summary:
;  *    Scrolls a portion of the menu image.
;  *  
;  *  Discussion:
;  *    Menus on Mac OS X use an alpha channel, and QuickDraw does not
;  *    support alpha channels. Therefore, scrolling a menu image with
;  *    ScrollRect or other QuickDraw APIs does not work correctly; it
;  *    results in the destruction of the alpha channel data. The
;  *    ScrollMenuImage API uses CoreGraphics to move the menu image,
;  *    preserving the alpha channel.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu whose image to scroll.
;  *    
;  *    inScrollRect:
;  *      The bounds of the rect to scroll.
;  *    
;  *    inHScroll:
;  *      The distance to scroll horizontally.
;  *    
;  *    inVScroll:
;  *      The distance to scroll vertically.
;  *    
;  *    inContext:
;  *      The CG context to erase. If NULL, ScrollMenuImage will create a
;  *      context based on the current port.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ScrollMenuImage" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inScrollRect (:pointer :Rect))
    (inHScroll :signed-long)
    (inVScroll :signed-long)
    (inContext (:pointer :CGContext))           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Menu Item Insertion                                                               
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  [Mac]AppendMenu()
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
; #define MacAppendMenu AppendMenu

; #endif


(deftrap-inline "_AppendMenu" 
   ((menu (:pointer :OpaqueMenuRef))
    (data (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InsertResMenu()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InsertResMenu" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (theType :FourCharCode)
    (afterItem :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AppendResMenu()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AppendResMenu" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (theType :FourCharCode)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]InsertMenuItem()
;  *  
;  *  Summary:
;  *    Inserts a new menu item into a menu, using a Str255 for the item
;  *    text.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theMenu:
;  *      The menu into which to insert the item.
;  *    
;  *    itemString:
;  *      The text of the new item. This string is parsed for the
;  *      meta-characters documented in the Menu Manager chapter of
;  *      Inside Macintosh.
;  *    
;  *    afterItem:
;  *      The menu item after which to insert the item. Pass 0 to insert
;  *      the item at the beginning of the menu. If afterItem is greater
;  *      than the number of items in the menu, the item is inserted at
;  *      the end of the menu.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacInsertMenuItem InsertMenuItem

; #endif


(deftrap-inline "_InsertMenuItem" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (itemString (:pointer :STR255))
    (afterItem :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DeleteMenuItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DeleteMenuItem" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InsertFontResMenu()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InsertFontResMenu" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (afterItem :SInt16)
    (scriptFilter :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InsertIntlResMenu()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InsertIntlResMenu" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (theType :FourCharCode)
    (afterItem :SInt16)
    (scriptFilter :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AppendMenuItemText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_AppendMenuItemText" 
   ((menu (:pointer :OpaqueMenuRef))
    (inString (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InsertMenuItemText()
;  *  
;  *  Summary:
;  *    Inserts a new menu item into a menu, using a Str255 for the item
;  *    text.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    menu:
;  *      The menu into which to insert the item.
;  *    
;  *    inString:
;  *      The text of the new item. This string is not parsed for the
;  *      meta-characters documented in the Menu Manager chapter of
;  *      Inside Macintosh; the new item's text becomes exactly the
;  *      specified text.
;  *    
;  *    afterItem:
;  *      The menu item after which to insert the item. Pass 0 to insert
;  *      the item at the beginning of the menu. If afterItem is greater
;  *      than the number of items in the menu, the item is inserted at
;  *      the end of the menu.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_InsertMenuItemText" 
   ((menu (:pointer :OpaqueMenuRef))
    (inString (:pointer :STR255))
    (afterItem :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CopyMenuItems()
;  *  
;  *  Summary:
;  *    Copies menu items from one menu to another.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inSourceMenu:
;  *      The menu from which to copy items.
;  *    
;  *    inFirstItem:
;  *      The first item to copy.
;  *    
;  *    inNumItems:
;  *      The number of items to copy.
;  *    
;  *    inDestMenu:
;  *      The menu to which to copy items.
;  *    
;  *    inInsertAfter:
;  *      The menu item in the destination menu after which to insert the
;  *      copied items. Pass 0 to insert the items at the beginning of
;  *      the menu. This value of this parameter must not exceed the
;  *      number of items in the destination menu.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CopyMenuItems" 
   ((inSourceMenu (:pointer :OpaqueMenuRef))
    (inFirstItem :UInt16)
    (inNumItems :UInt32)
    (inDestMenu (:pointer :OpaqueMenuRef))
    (inInsertAfter :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DeleteMenuItems()
;  *  
;  *  Summary:
;  *    Deletes multiple menu items.
;  *  
;  *  Discussion:
;  *    This API is more efficient than calling DeleteMenuItem multiple
;  *    times.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu from which to delete items.
;  *    
;  *    inFirstItem:
;  *      The first item to delete.
;  *    
;  *    inNumItems:
;  *      The number of items to delete.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DeleteMenuItems" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inFirstItem :UInt16)
    (inNumItems :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  AppendMenuItemTextWithCFString()
;  *  
;  *  Summary:
;  *    Appends a new menu item with text from a CFString.
;  *  
;  *  Discussion:
;  *    The Menu Manager will either make its own copy or just increment
;  *    the refcount of the CFString before returning from
;  *    AppendMenuItemWithTextCFString, depending on whether the string
;  *    is mutable or immutable. If the string is mutable, modifying the
;  *    string after calling AppendMenuItemTextWithCFString will have no
;  *    effect on the menu item's actual text. The caller may release the
;  *    string after calling AppendMenuItemTextWithCFString.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu to which to append the new item.
;  *    
;  *    inString:
;  *      The text of the new item.
;  *    
;  *    inAttributes:
;  *      The attributes of the new item.
;  *    
;  *    inCommandID:
;  *      The command ID of the new item.
;  *    
;  *    outNewItem:
;  *      On exit, the index of the new item. May be NULL if the caller
;  *      does not need this information.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AppendMenuItemTextWithCFString" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inString (:pointer :__CFString))
    (inAttributes :UInt32)
    (inCommandID :UInt32)
    (outNewItem (:pointer :MENUITEMINDEX))      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InsertMenuItemTextWithCFString()
;  *  
;  *  Summary:
;  *    Inserts a new menu item with text from a CFString.
;  *  
;  *  Discussion:
;  *    The Menu Manager will either make its own copy or just increment
;  *    the refcount of the CFString before returning from
;  *    InsertMenuItemWithCFString, depending on whether the string is
;  *    mutable or immutable. If the string is mutable, modifying the
;  *    string after calling InsertMenuItemWithCFString will have no
;  *    effect on the menu item's actual text. The caller may release the
;  *    string after calling InsertMenuItemWithCFString.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu in which to insert the new item.
;  *    
;  *    inString:
;  *      The text of the new item.
;  *    
;  *    inAfterItem:
;  *      The item after which to insert the new item. Pass 0 to insert
;  *      the item at the beginning of the menu. If inAfterItem is
;  *      greater than the number of items in the menu, the item is
;  *      inserted at the end of the menu.
;  *    
;  *    inAttributes:
;  *      The attributes of the new item.
;  *    
;  *    inCommandID:
;  *      The command ID of the new item.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InsertMenuItemTextWithCFString" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inString (:pointer :__CFString))
    (inAfterItem :UInt16)
    (inAttributes :UInt32)
    (inCommandID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Menu Events                                                                       
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  MenuKey()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MenuKey" 
   ((ch :character)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  MenuSelect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MenuSelect" 
   ((startPt :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  PopUpMenuSelect()
;  *  
;  *  Summary:
;  *    Displays a pop-up menu at a specified location.
;  *  
;  *  Discussion:
;  *    In Mac OS 9 and earlier, PopUpMenuSelect requires that the menu
;  *    be inserted into the menubar using InsertMenu( menuRef,
;  *    kInsertHierarchicalMenu ). CarbonLib 1.1 and later, and Mac OS X,
;  *    do not have this requirement; a menu can be displayed by
;  *    PopUpMenuSelect even if it is not inserted in the menubar.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    menu:
;  *      The menu to display.
;  *    
;  *    top:
;  *      The vertical position, in global coordinates, of the top left
;  *      corner of the selected item when the menu is opened.
;  *    
;  *    left:
;  *      The horizontal position, in global coordinates, of the top left
;  *      corner of the selected item when the menu is opened.
;  *    
;  *    popUpItem:
;  *      The item that should be positioned at the global point
;  *      specified by the top and left parameters. May be zero, in which
;  *      case item one is positioned at the specified global point.
;  *  
;  *  Result:
;  *    A 32-value whose high 16-bit word is the menu ID and whose low
;  *    16-bit word is the index of the menu item that was selected, or
;  *    zero if no item was selected.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PopUpMenuSelect" 
   ((menu (:pointer :OpaqueMenuRef))
    (top :SInt16)
    (left :SInt16)
    (popUpItem :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  MenuChoice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MenuChoice" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  MenuEvent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_MenuEvent" 
   ((inEvent (:pointer :EventRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  IsMenuKeyEvent()
;  *  
;  *  Summary:
;  *    Determines if an event corresponds to a menu command key.
;  *  
;  *  Discussion:
;  *    By default, IsMenuKeyEvent searches the menus in the current menu
;  *    bar and hilites the menu title of the menu containing the
;  *    selected item.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inStartMenu:
;  *      IsMenuKeyEvent searches for matching menu items in this menu
;  *      and all of its submenus. May be NULL to search the current menu
;  *      bar contents.
;  *    
;  *    inEvent:
;  *      The event to match against. Non-keyboard events are ignored.
;  *    
;  *    inOptions:
;  *      Options controlling how to search. Pass kNilOptions for the
;  *      default behavior.
;  *    
;  *    outMenu:
;  *      On exit, the menu containing the matching item. May be NULL.
;  *    
;  *    outMenuItem:
;  *      On exit, the menu item that matched. May be NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsMenuKeyEvent" 
   ((inStartMenu (:pointer :OpaqueMenuRef))
    (inEvent (:pointer :OpaqueEventRef))
    (inOptions :UInt32)
    (outMenu (:pointer :MenuRef))               ;  can be NULL 
    (outMenuItem (:pointer :MENUITEMINDEX))     ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvalidateMenuEnabling()
;  *  
;  *  Summary:
;  *    Causes the menu enable state to be recalculated at the next
;  *    convenient opportunity.
;  *  
;  *  Discussion:
;  *    It is common for state changes in an application (for example,
;  *    selection of text) to cause a change in the enabling of items in
;  *    the application's menu (for example, the Copy menu item might
;  *    become enabled). In a Carbon-event-savvy application, menu items
;  *    are enabled or disabled in response to an
;  *    kEventCommandUpdateStatus event; however, this event is normally
;  *    only sent before a command key press or a click in the menubar.
;  *    You can request an explicit recalculation of a menu's enable
;  *    state with the InvalidateMenuEnabling API. The Carbon Event
;  *    Manager will automatically invalidate the enable state of all
;  *    top-level menus when a user event is dispatched, the user focus
;  *    changes, or the active window changes, so in many cases you will
;  *    not need to explicitly invalidate the menu enabling state.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      A menu to re-enable, or NULL if all menus in the root menu
;  *      should be re-enabled.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvalidateMenuEnabling" 
   ((inMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  Summary:
;  *    Menu dismissal causation constants
;  
; 
;    * The menu was dismissed by the selection of a menu item.
;    

(defconstant $kHIMenuDismissedBySelection 1)
; 
;    * The menu was dismissed because the user canceled menu tracking.
;    

(defconstant $kHIMenuDismissedByUserCancel 2)
; 
;    * The menu was dismissed by a mouse-down somewhere that did not
;    * result in menu item selection.
;    

(defconstant $kHIMenuDismissedByMouseDown 3)
; 
;    * The menu was dismissed by a mouse-up.
;    

(defconstant $kHIMenuDismissedByMouseUp 4)
; 
;    * The menu was dismissed by a keyboard event.
;    

(defconstant $kHIMenuDismissedByKeyEvent 5)
; 
;    * The menu was dismissed because the current application was no
;    * longer frontmost.
;    

(defconstant $kHIMenuDismissedByAppSwitch 6)
; 
;    * The menu was dismissed because menu tracking mode timed out.
;    

(defconstant $kHIMenuDismissedByTimeout 7)
; 
;    * The menu was dismissed by the CancelMenuTracking API.
;    

(defconstant $kHIMenuDismissedByCancelMenuTracking 8)
; 
;    * The menu was dismissed because the active window changed.
;    

(defconstant $kHIMenuDismissedByActivationChange 9)
; 
;    * The menu was dismissed bcause the user focus window changed, or
;    * because keyboard focus was removed from the current process.
;    

(defconstant $kHIMenuDismissedByFocusChange 10)
; 
;  *  CancelMenuTracking()
;  *  
;  *  Summary:
;  *    Cancels a menu tracking session.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRootMenu:
;  *      The root menu of the menu tracking session that should be
;  *      dismissed. For menubar tracking, use the result of AcquireRoot
;  *      menu; for popup menu tracking, use the menu that was passed to
;  *      PopUpMenuSelect.
;  *    
;  *    inImmediate:
;  *      Whether the open menus should disappear immediately or fade out.
;  *    
;  *    inDismissalReason:
;  *      Why the menu is being dismissed; this value will be added to
;  *      the kEventMenuEndTracking event. If zero,
;  *      kHIMenuDismissedByCancelMenuTracking is added to the
;  *      EndTracking event.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CancelMenuTracking" 
   ((inRootMenu (:pointer :OpaqueMenuRef))
    (inImmediate :Boolean)
    (inDismissalReason :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Menu Bar                                                                          
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  GetMBarHeight()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetMBarHeight" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  [Mac]DrawMenuBar()
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
; #define MacDrawMenuBar DrawMenuBar

; #endif


(deftrap-inline "_DrawMenuBar" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvalMenuBar()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InvalMenuBar" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  IsMenuBarInvalid()
;  *  
;  *  Summary:
;  *    Determines if the menubar is invalid and should be redrawn.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    rootMenu:
;  *      The root menu for the menubar to be examined. Pass NULL to
;  *      check the state of the current menubar.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsMenuBarInvalid" 
   ((rootMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  HiliteMenu()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HiliteMenu" 
   ((menuID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetNewMBar()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetNewMBar" 
   ((menuBarID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  GetMenuBar()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetMenuBar" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  SetMenuBar()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetMenuBar" 
   ((mbar :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DuplicateMenuBar()
;  *  
;  *  Summary:
;  *    Duplicates a menubar handle.
;  *  
;  *  Discussion:
;  *    This API should be used in Carbon applications when duplicating a
;  *    handle returned from GetMenuBar or GetNewMBar. You should not use
;  *    Memory Manager APIs (HandToHand, NewHandle, etc) to duplicate
;  *    such a handle. This is necessary in Carbon so that the refcounts
;  *    of the menus in the menubar handle can be incremented when the
;  *    handle is duplicated.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMbar:
;  *      The menubar handle to duplicate.
;  *    
;  *    outMbar:
;  *      On exit, contains the new menubar handle.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DuplicateMenuBar" 
   ((inMbar :Handle)
    (outMbar (:pointer :MENUBARHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DisposeMenuBar()
;  *  
;  *  Summary:
;  *    Releases a menubar handle.
;  *  
;  *  Discussion:
;  *    This API should be used in Carbon applications when releasing a
;  *    handle returned from GetMenuBar or GetNewMBar. You should not use
;  *    DisposeHandle to release such a handle. This is necessary in
;  *    Carbon so that the refcounts of the menus in the menubar handle
;  *    can be decremented when the handle is released.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMbar:
;  *      The menubar handle to release.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeMenuBar" 
   ((inMbar :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetMenuHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetMenuHandle" 
   ((menuID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMenuRef)
() )
; #define GetMenuRef GetMenuHandle
; 
;  *  [Mac]InsertMenu()
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
; #define MacInsertMenu InsertMenu

; #endif


(deftrap-inline "_InsertMenu" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (beforeID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]DeleteMenu()
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
; #define MacDeleteMenu DeleteMenu

; #endif


(deftrap-inline "_DeleteMenu" 
   ((menuID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ClearMenuBar()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ClearMenuBar" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMenuFlash()
;  *  
;  *  Summary:
;  *    Renamed to SetMenuFlashCount in Carbon
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SetMenuFlashCount()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.3 and later or as macro/inline
;  

(deftrap-inline "_SetMenuFlashCount" 
   ((count :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FlashMenuBar()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FlashMenuBar" 
   ((menuID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  These are obsolete because Carbon does not support desk accessories.
; 
;  *  SystemEdit()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SystemMenu()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IsMenuBarVisible()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_IsMenuBarVisible" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  ShowMenuBar()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_ShowMenuBar" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HideMenuBar()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_HideMenuBar" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AcquireRootMenu()
;  *  
;  *  Summary:
;  *    Get the menu whose contents are displayed in the menubar.
;  *  
;  *  Discussion:
;  *    The refcount of the root menu is incremented by this API. The
;  *    caller should release a refcount with ReleaseMenu when it’s done
;  *    with the menu.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AcquireRootMenu" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMenuRef)
() )
; 
;  *  SetRootMenu()
;  *  
;  *  Summary:
;  *    Sets the menu whose contents are displayed in the menubar.
;  *  
;  *  Discussion:
;  *    The refcount of the root menu is incremented by this API. The
;  *    caller may release the menu after calling SetRootMenu.
;  *    
;  *    A root menu should contain one menu item for each top-level menu
;  *    that should be displayed in the menubar. Each menu item should
;  *    have a submenu that was installed with
;  *    SetMenuItemHierarchicalMenu.
;  *    
;  *    SetRootMenu also sets the contents of the hierarchical portion of
;  *    the menulist (the set of menus that were inserted with
;  *    InsertMenu( menu, kInsertHierarchicalMenu). If a menu that was
;  *    returned by AcquireRootMenu is passed to SetRootMenu, the
;  *    hierarchical menulist is changed to include the menus that were
;  *    in the hierarchical menulist when AcquireRootMenu was called. If
;  *    a newly created menu is passed to SetRootMenu, the hierarchical
;  *    menulist is cleared and has no menus in it.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The new root menu.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetRootMenu" 
   ((inMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Menu Item Accessors                                                               
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  CheckItem()
;  *  
;  *  Summary:
;  *    Renamed to CheckMenuItem in Carbon
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  [Mac]CheckMenuItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.3 and later or as macro/inline
;  

; #if TARGET_OS_MAC
; #define MacCheckMenuItem CheckMenuItem

; #endif


(deftrap-inline "_CheckMenuItem" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :SInt16)
    (checked :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMenuItemText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetMenuItemText" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :SInt16)
    (itemString (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMenuItemText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetMenuItemText" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :SInt16)
    (itemString (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetItemMark()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetItemMark" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :SInt16)
    (markChar :character)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetItemMark()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetItemMark" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :SInt16)
    (markChar (:pointer :CHARPARAMETER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetItemCmd()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetItemCmd" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :SInt16)
    (cmdChar :character)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetItemCmd()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetItemCmd" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :SInt16)
    (cmdChar (:pointer :CHARPARAMETER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetItemIcon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetItemIcon" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :SInt16)
    (iconIndex :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  icon is returned in high byte of 16-bit iconIndex 
; 
;  *  GetItemIcon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetItemIcon" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :SInt16)
    (iconIndex (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetItemStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetItemStyle" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :SInt16)
    (chStyle :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetItemStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetItemStyle" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :SInt16)
    (chStyle (:pointer :Style))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  These APIs are not supported in Carbon. Please use EnableMenuItem and 
;  DisableMenuItem (available back through Mac OS 8.5) instead.          
; 
;  *  DisableItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  EnableItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SetMenuItemCommandID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetMenuItemCommandID" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (inCommandID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMenuItemCommandID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetMenuItemCommandID" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (outCommandID (:pointer :MENUCOMMAND))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMenuItemModifiers()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetMenuItemModifiers" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (inModifiers :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMenuItemModifiers()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetMenuItemModifiers" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (outModifiers (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMenuItemIconHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetMenuItemIconHandle" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (inIconType :UInt8)
    (inIconHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMenuItemIconHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetMenuItemIconHandle" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (outIconType (:pointer :UInt8))
    (outIconHandle (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMenuItemTextEncoding()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetMenuItemTextEncoding" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (inScriptID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMenuItemTextEncoding()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetMenuItemTextEncoding" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (outScriptID (:pointer :TEXTENCODING))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMenuItemHierarchicalID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetMenuItemHierarchicalID" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (inHierID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMenuItemHierarchicalID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetMenuItemHierarchicalID" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (outHierID (:pointer :MENUID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMenuItemFontID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetMenuItemFontID" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (inFontID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMenuItemFontID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetMenuItemFontID" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (outFontID (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMenuItemRefCon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetMenuItemRefCon" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (inRefCon :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMenuItemRefCon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetMenuItemRefCon" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (outRefCon (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Please use the menu item property APIs in Carbon.
; 
;  *  SetMenuItemRefCon2()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  
; 
;  *  GetMenuItemRefCon2()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  
; 
;  *  SetMenuItemKeyGlyph()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetMenuItemKeyGlyph" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (inGlyph :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMenuItemKeyGlyph()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetMenuItemKeyGlyph" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :SInt16)
    (outGlyph (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Routines available in Mac OS 8.5 and later (supporting enabling/disabling of > 31 items)
; 
;  *  [Mac]EnableMenuItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

; #if TARGET_OS_MAC
; #define MacEnableMenuItem EnableMenuItem

; #endif


(deftrap-inline "_EnableMenuItem" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisableMenuItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_DisableMenuItem" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  IsMenuItemEnabled()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_IsMenuItemEnabled" 
   ((menu (:pointer :OpaqueMenuRef))
    (item :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  EnableMenuItemIcon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_EnableMenuItemIcon" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisableMenuItemIcon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_DisableMenuItemIcon" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (item :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  IsMenuItemIconEnabled()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_IsMenuItemIconEnabled" 
   ((menu (:pointer :OpaqueMenuRef))
    (item :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SetMenuItemHierarchicalMenu()
;  *  
;  *  Summary:
;  *    Attaches a submenu to a menu item.
;  *  
;  *  Discussion:
;  *    Using SetMenuItemHierarchicalMenu, it is possible to directly
;  *    specify the submenu for a menu item without specifying its menu
;  *    ID. It is not necessary to insert the submenu into the
;  *    hierarchical portion of the menubar, and it is not necessary for
;  *    the submenu to have a unique menu ID; it is recommended that you
;  *    use 0 as the menu ID for the submenu, and identify selections
;  *    from the menu by command ID. The Menu Manager will increment the
;  *    refcount of the submenu that you specify, and the submenu's
;  *    refcount will be decremented automatically when the parent menu
;  *    item is deleted or the parent menu is disposed.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The parent menu.
;  *    
;  *    inItem:
;  *      The parent item.
;  *    
;  *    inHierMenu:
;  *      The submenu. You may pass NULL to remove any existing submenu.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetMenuItemHierarchicalMenu" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :UInt16)
    (inHierMenu (:pointer :OpaqueMenuRef))      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetMenuItemHierarchicalMenu()
;  *  
;  *  Summary:
;  *    Returns the submenu attached to a menu item.
;  *  
;  *  Discussion:
;  *    GetMenuItemHierarchicalMenu will return the submenu attached to a
;  *    menu item regardless of how the submenu was specified. If the
;  *    submenu was specified by menu ID (using SetItemCmd or
;  *    SetMenuItemHierarchicalID), GetMenuItemHierarchicalMenu will
;  *    return the currently installed menu with that ID, if any. The
;  *    only case where GetMenuItemHierarchicalMenu will fail to return
;  *    the item's submenu is when the submenu is specified by menu ID,
;  *    but the submenu is not currently inserted in the menu bar.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The parent menu.
;  *    
;  *    inItem:
;  *      The parent item.
;  *    
;  *    outHierMenu:
;  *      On exit, the item's submenu, or NULL if it does not have one.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuItemHierarchicalMenu" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :UInt16)
    (outHierMenu (:pointer :MenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CopyMenuItemTextAsCFString()
;  *  
;  *  Summary:
;  *    Returns a CFString containing the text of a menu item.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu containing the item.
;  *    
;  *    inItem:
;  *      The item whose text to return.
;  *    
;  *    outString:
;  *      On exit, a CFString containing the item's text. This string
;  *      must be released by the caller.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CopyMenuItemTextAsCFString" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :UInt16)
    (outString (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetMenuItemTextWithCFString()
;  *  
;  *  Summary:
;  *    Sets the text of a menu item to the text contained in a CFString.
;  *  
;  *  Discussion:
;  *    The Menu Manager will either make its own copy or just increment
;  *    the refcount of the CFString before returning from
;  *    SetMenuItemTextWithCFString, depending on whether the string is
;  *    mutable or immutable. If the string is mutable, modifying the
;  *    string after calling SetMenuItemTextWithCFString will have no
;  *    effect on the menu item's actual text. The caller may release the
;  *    string after calling SetMenuItemTextWithCFString.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu containing the item.
;  *    
;  *    inItem:
;  *      The item whose text to return.
;  *    
;  *    inString:
;  *      The string containing the new menu item text.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetMenuItemTextWithCFString" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :UInt16)
    (inString (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetMenuItemIndent()
;  *  
;  *  Summary:
;  *    Gets the indent level of a menu item.
;  *  
;  *  Discussion:
;  *    The indent level of an item is an amount of extra space added to
;  *    the left of the item's icon or checkmark. The level is simply a
;  *    number, starting at zero, which the Menu Manager multiplies by a
;  *    constant to get the indent in pixels. The default indent level is
;  *    zero.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu containing the item.
;  *    
;  *    inItem:
;  *      The item whose indent to retrieve.
;  *    
;  *    outIndent:
;  *      On exit, the indent level of the item.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuItemIndent" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :UInt16)
    (outIndent (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetMenuItemIndent()
;  *  
;  *  Summary:
;  *    Sets the indent level of a menu item.
;  *  
;  *  Discussion:
;  *    The indent level of an item is an amount of extra space added to
;  *    the left of the item's icon or checkmark. The level is simply a
;  *    number, starting at zero, which the Menu Manager multiplies by a
;  *    constant to get the indent in pixels. The default indent level is
;  *    zero.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu containing the item.
;  *    
;  *    inItem:
;  *      The item whose indent to set.
;  *    
;  *    inIndent:
;  *      The new indent level of the item.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetMenuItemIndent" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :UInt16)
    (inIndent :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetMenuItemCommandKey()
;  *  
;  *  Summary:
;  *    Gets the keyboard equivalent of a menu item.
;  *  
;  *  Discussion:
;  *    A menu item's keyboard equivalent may be either a character code
;  *    or a virtual keycode. An item's character code and virtual
;  *    keycode are stored separately and may contain different values,
;  *    but only one is used by the Menu Manager at any given time. When
;  *    requesting a menu item's virtual keycode equivalent, you should
;  *    first check that the item is using a virtual keycode by testing
;  *    the kMenuItemAttrUseVirtualKey attribute for that item. If this
;  *    attribute is not set, the item's virtual keycode is ignored by
;  *    the Menu Manager. Note that zero is a valid virtual keycode, so
;  *    you cannot test the returned keycode against zero to determine if
;  *    the item is using a virtual keycode equivalent. You must test the
;  *    kMenuItemAttrUseVirtualKey attribute.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu containing the item.
;  *    
;  *    inItem:
;  *      The item whose keyboard equivalent to retrieve.
;  *    
;  *    inGetVirtualKey:
;  *      Indicates whether to retrieve the item's character code or
;  *      virtual keycode equivalent.
;  *    
;  *    outKey:
;  *      On exit, the keyboard equivalent of the item.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuItemCommandKey" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :UInt16)
    (inGetVirtualKey :Boolean)
    (outKey (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetMenuItemCommandKey()
;  *  
;  *  Summary:
;  *    Sets the keyboard equivalent of a menu item.
;  *  
;  *  Discussion:
;  *    A menu item's keyboard equivalent may be either a character code
;  *    or a virtual keycode. The character code is always used to draw
;  *    the item's keyboard equivalent in the menu, but either may be
;  *    used for keyboard equivalent matching by MenuEvent and
;  *    IsMenuKeyEvent, depending on whether the
;  *    kMenuItemAttrUseVirtualKey item attribute is set. If
;  *    SetMenuItemCommandKey is used to set the virtual keycode
;  *    equivalent for a menu item, it also automatically sets the
;  *    kMenuItemAttrUseVirtualKey item attribute. To make the menu item
;  *    stop using the virtual keycode equivalent and use the character
;  *    code equivalent instead, use ChangeMenuItemAttributes to clear
;  *    the kMenuItemAttrUseVirtualKey item attribute.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu containing the item.
;  *    
;  *    inItem:
;  *      The item whose keyboard equivalent to set.
;  *    
;  *    inSetVirtualKey:
;  *      Indicates whether to set the item's character code or virtual
;  *      keycode equivalent.
;  *    
;  *    inKey:
;  *      The item's new character code or virtual keycode equivalent.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetMenuItemCommandKey" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :UInt16)
    (inSetVirtualKey :Boolean)
    (inKey :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Menu Item Color Tables                                                            
;                                                                                       
;   Menu color manipulation is considered deprecated with the advent of the Appearance  
;   Manager.  Avoid using these routines if possible                                    
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  DeleteMCEntries()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DeleteMCEntries" 
   ((menuID :SInt16)
    (menuItem :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMCInfo()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetMCInfo" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MCEntry)
() )
; 
;  *  SetMCInfo()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetMCInfo" 
   ((menuCTbl (:Handle :MCEntry))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMCInfo()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposeMCInfo" 
   ((menuCTbl (:Handle :MCEntry))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMCEntry()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetMCEntry" 
   ((menuID :SInt16)
    (menuItem :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :MCEntry)
() )
; 
;  *  SetMCEntries()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetMCEntries" 
   ((numEntries :SInt16)
    (menuCEntries (:pointer :MCEntry))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Properties  (Mac OS 8.5 and later)                                                 
;                                                                                       
;  With the following property APIs, you can attach any piece of data you'd like to a   
;  menu or menu item. Passing zero for the item number parameter indicates you'd like   
;  to attach the data to the menu itself, and not to any specific menu item.            
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kMenuPropertyPersistent 1)        ;  whether this property gets saved when flattening the menu

; 
;  *  GetMenuItemProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_GetMenuItemProperty" 
   ((menu (:pointer :OpaqueMenuRef))
    (item :UInt16)
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (bufferSize :UInt32)
    (actualSize (:pointer :UInt32))
    (propertyBuffer :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetMenuItemPropertySize()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_GetMenuItemPropertySize" 
   ((menu (:pointer :OpaqueMenuRef))
    (item :UInt16)
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (size (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetMenuItemProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_SetMenuItemProperty" 
   ((menu (:pointer :OpaqueMenuRef))
    (item :UInt16)
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (propertySize :UInt32)
    (propertyData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RemoveMenuItemProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MenusLib 8.5 and later
;  

(deftrap-inline "_RemoveMenuItemProperty" 
   ((menu (:pointer :OpaqueMenuRef))
    (item :UInt16)
    (propertyCreator :OSType)
    (propertyTag :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetMenuItemPropertyAttributes()
;  *  
;  *  Summary:
;  *    Gets the attributes of a menu item property.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    menu:
;  *      The menu.
;  *    
;  *    item:
;  *      The menu item.
;  *    
;  *    propertyCreator:
;  *      The creator code of the property.
;  *    
;  *    propertyTag:
;  *      The property tag.
;  *    
;  *    attributes:
;  *      On exit, contains the attributes of the property.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuItemPropertyAttributes" 
   ((menu (:pointer :OpaqueMenuRef))
    (item :UInt16)
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (attributes (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ChangeMenuItemPropertyAttributes()
;  *  
;  *  Summary:
;  *    Changes the attributes of a menu item property.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    menu:
;  *      The menu.
;  *    
;  *    item:
;  *      The menu item.
;  *    
;  *    propertyCreator:
;  *      The creator code of the property.
;  *    
;  *    propertyTag:
;  *      The property tag.
;  *    
;  *    attributesToSet:
;  *      The attributes to add to the menu item property.
;  *    
;  *    attributesToClear:
;  *      The attributes to remove from the menu item property.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ChangeMenuItemPropertyAttributes" 
   ((menu (:pointer :OpaqueMenuRef))
    (item :UInt16)
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (attributesToSet :UInt32)
    (attributesToClear :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Attributes (Carbon and later)                                                     
;                                                                                       
;   Each menu and menu item has attribute flags.                                        
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  GetMenuAttributes()
;  *  
;  *  Summary:
;  *    Gets the attributes of a menu.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    menu:
;  *      The menu.
;  *    
;  *    outAttributes:
;  *      On exit, contains the attributes of the menu.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuAttributes" 
   ((menu (:pointer :OpaqueMenuRef))
    (outAttributes (:pointer :MENUATTRIBUTES))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ChangeMenuAttributes()
;  *  
;  *  Summary:
;  *    Changes the attributes of a menu.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    menu:
;  *      The menu.
;  *    
;  *    setTheseAttributes:
;  *      The attributes to add to the menu.
;  *    
;  *    clearTheseAttributes:
;  *      The attributes to remove from the menu.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ChangeMenuAttributes" 
   ((menu (:pointer :OpaqueMenuRef))
    (setTheseAttributes :UInt32)
    (clearTheseAttributes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetMenuItemAttributes()
;  *  
;  *  Summary:
;  *    Gets the attributes of a menu item.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    menu:
;  *      The menu.
;  *    
;  *    item:
;  *      The menu item.
;  *    
;  *    outAttributes:
;  *      On exit, contains the attributes of the menu item.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuItemAttributes" 
   ((menu (:pointer :OpaqueMenuRef))
    (item :UInt16)
    (outAttributes (:pointer :MENUITEMATTRIBUTES))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ChangeMenuItemAttributes()
;  *  
;  *  Summary:
;  *    Changes the attributes of a menu item.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    menu:
;  *      The menu.
;  *    
;  *    item:
;  *      The menu item.
;  *    
;  *    setTheseAttributes:
;  *      The attributes to add to the menu item.
;  *    
;  *    clearTheseAttributes:
;  *      The attributes to remove from the menu item.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ChangeMenuItemAttributes" 
   ((menu (:pointer :OpaqueMenuRef))
    (item :UInt16)
    (setTheseAttributes :UInt32)
    (clearTheseAttributes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Mass menu item enabling and disabling (Carbon and later)                          
;                                                                                       
;   Useful when rewriting code that modifies the enableFlags field directly.            
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  DisableAllMenuItems()
;  *  
;  *  Summary:
;  *    Disables all items in a menu.
;  *  
;  *  Discussion:
;  *    This API is equivalent to pre-Carbon code that masked the
;  *    enableFlags field of the MenuInfo with 0x01. It disables all
;  *    items (including items past item 31) but does not affect the
;  *    state of the menu title.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theMenu:
;  *      The menu whose items to disable.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisableAllMenuItems" 
   ((theMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  EnableAllMenuItems()
;  *  
;  *  Summary:
;  *    Enables all items in a menu.
;  *  
;  *  Discussion:
;  *    This API is equivalent to pre-Carbon code that or'd the
;  *    enableFlags field of the MenuInfo with 0xFFFFFFFE. It enables all
;  *    items (including items past item 31) but does not affect the
;  *    state of the menu title.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theMenu:
;  *      The menu whose items to enable.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_EnableAllMenuItems" 
   ((theMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MenuHasEnabledItems()
;  *  
;  *  Summary:
;  *    Determines if any items in a menu are enabled.
;  *  
;  *  Discussion:
;  *    This API is equivalent to pre-Carbon code that compared the
;  *    enableFlags field of the MenuInfo with 0. It checks the enable
;  *    state of all items to see if any are enabled, but ignores the
;  *    state of the menu title. It will return true even if the menu
;  *    title is disabled.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theMenu:
;  *      The menu whose items to examine.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_MenuHasEnabledItems" 
   ((theMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Menu tracking status (Carbon and later)                                           
;                                                                                       
;   Get info about the selected menu item during menu tracking. Replaces direct access  
;   to low-mem globals that previously held this info.                                  
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  GetMenuTrackingData()
;  *  
;  *  Summary:
;  *    Gets information about the menu currently selected by the user.
;  *  
;  *  Discussion:
;  *    This API replaces direct access to the low-memory globals
;  *    TopMenuItem, AtMenuBottom, MenuDisable, and mbSaveLoc. It is only
;  *    valid to call this API while menu tracking is occurring. This API
;  *    will most commonly be used by custom MDEFs.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theMenu:
;  *      The menu about which to get tracking information. May be NULL
;  *      to get information about the menu that the user is currently
;  *      selecting. If the menu is not currently open, menuNotFoundErr
;  *      is returned.
;  *    
;  *    outData:
;  *      On exit, contains tracking data about the menu. On CarbonLib,
;  *      the itemRect field is not supported and is always set to an
;  *      empty rect.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuTrackingData" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (outData (:pointer :MenuTrackingData))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetMenuType()
;  *  
;  *  Summary:
;  *    Gets the display type (pulldown, hierarchical, or popup) of a
;  *    menu.
;  *  
;  *  Discussion:
;  *    This API may only be called when the menu is displayed. If the
;  *    menu is not currently open, an error is returned. The display
;  *    type of a menu may vary from one menu tracking session to
;  *    another; for example, the same menu might be displayed as a
;  *    pulldown menu and as a popup menu.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theMenu:
;  *      The menu whose type to get.
;  *    
;  *    outType:
;  *      On exit, the type of the menu. The returned value will be one
;  *      of the ThemeMenuType constants: kThemeMenuTypePullDown, PopUp,
;  *      or Hierarchical. The kThemeMenuTypeInactive bit will never be
;  *      set.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuType" 
   ((theMenu (:pointer :OpaqueMenuRef))
    (outType (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Universal command ID access (Carbon and later)                                    
;                                                                                       
;   These APIs allow you to operate on menu items strictly by command ID, with no       
;   knowledge of a menu item's index.                                                   
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  CountMenuItemsWithCommandID()
;  *  
;  *  Summary:
;  *    Counts the menu items with a specified command ID.
;  *  
;  *  Discussion:
;  *    In CarbonLib 1.0.x and 1.1, this API always returns zero or one;
;  *    it stops after finding the first menu item with the specified
;  *    command ID. In CarbonLib 1.2 and Mac OS X 10.0 and later, it
;  *    counts all menu items with the specified command ID. In Mac OS X
;  *    10.0 and CarbonLib 1.0 through 1.4, this API only searches
;  *    top-level menus (menus visible in the menubar) and submenus of
;  *    top-level menus. It does not search hierarchical menus that are
;  *    inserted in the menubar but are not submenus of a top-level menus
;  *    (for example, it does not search menus that are inserted for use
;  *    in a popup menu control). In Mac OS X 10.1 and CarbonLib 1.5 and
;  *    later, this API also searches inserted hierarchical menus.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu in which to begin searching for items with the
;  *      specified command ID. Pass NULL to hegin searching with the
;  *      root menu. The search will descend into all submenus of this
;  *      menu.
;  *    
;  *    inCommandID:
;  *      The command ID for which to search.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CountMenuItemsWithCommandID" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inCommandID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetIndMenuItemWithCommandID()
;  *  
;  *  Summary:
;  *    Finds a menu item with a specified command ID.
;  *  
;  *  Discussion:
;  *    This API searches the specified menu and its submenus for the
;  *    n'th menu item with the specified command ID. In CarbonLib 1.0.x
;  *    and 1.1, only the first menu item is returned. In CarbonLib 1.2
;  *    and Mac OS X 10.0 and later, this API iterates over all menu
;  *    items with the specified command ID. In Mac OS X 10.0 and
;  *    CarbonLib 1.0 through 1.4, this API only searches top-level menus
;  *    (menus visible in the menubar) and submenus of top-level menus.
;  *    It does not search hierarchical menus that are inserted in the
;  *    menubar but are not submenus of a top-level menus (for example,
;  *    it does not search menus that are inserted for use in a popup
;  *    menu control). In Mac OS X 10.1 and CarbonLib 1.5 and later, this
;  *    API also searches inserted hierarchical menus.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu in which to begin searching for items with the
;  *      specified command ID. Pass NULL to hegin searching with the
;  *      root menu. The search will descend into all submenus of this
;  *      menu.
;  *    
;  *    inCommandID:
;  *      The command ID for which to search.
;  *    
;  *    inItemIndex:
;  *      The 1-based index of the menu item to retrieve. In CarbonLib
;  *      1.0.x and 1.1, this parameter must be 1. In CarbonLib 1.2 and
;  *      Mac OS X 10.0, this parameter may vary from 1 to the number of
;  *      menu items with the specified command ID.
;  *    
;  *    outMenu:
;  *      On exit, the menu containing the menu item with the specified
;  *      command ID.
;  *    
;  *    outIndex:
;  *      On exit, the item index of the menu item with the specified
;  *      command ID.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetIndMenuItemWithCommandID" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inCommandID :UInt32)
    (inItemIndex :UInt32)
    (outMenu (:pointer :MenuRef))               ;  can be NULL 
    (outIndex (:pointer :MENUITEMINDEX))        ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  EnableMenuCommand()
;  *  
;  *  Summary:
;  *    Enables the menu item with a specified command ID.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu in which to begin searching for the item. Pass NULL to
;  *      begin searching with the root menu. The search will descend
;  *      into all submenus of this menu.
;  *    
;  *    inCommandID:
;  *      The command ID of the menu item to be enabled. If more than one
;  *      item has this command ID, only the first will be enabled.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_EnableMenuCommand" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inCommandID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisableMenuCommand()
;  *  
;  *  Summary:
;  *    Disables the menu item with a specified command ID.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu in which to begin searching for the item. Pass NULL to
;  *      begin searching with the root menu. The search will descend
;  *      into all submenus of this menu.
;  *    
;  *    inCommandID:
;  *      The command ID of the menu item to be disabled. If more than
;  *      one item has this command ID, only the first will be disabled.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisableMenuCommand" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inCommandID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  IsMenuCommandEnabled()
;  *  
;  *  Summary:
;  *    Determines if the menu item with a specified command ID is
;  *    enabled.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu in which to begin searching for the item. Pass NULL to
;  *      begin searching with the root menu. The search will descend
;  *      into all submenus of this menu.
;  *    
;  *    inCommandID:
;  *      The command ID of the menu item to examine. If more than one
;  *      item has this command ID, only the first will be examined.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsMenuCommandEnabled" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inCommandID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SetMenuCommandMark()
;  *  
;  *  Summary:
;  *    Locates the menu item with a specified command ID and sets its
;  *    mark character.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu in which to begin searching for the item. Pass NULL to
;  *      begin searching with the root menu. The search will descend
;  *      into all submenus of this menu.
;  *    
;  *    inCommandID:
;  *      The command ID of the menu item to be modified. If more than
;  *      one item has this command ID, only the first will be modified.
;  *    
;  *    inMark:
;  *      The new mark character. Although the type of this parameter is
;  *      UniChar, currently only the low byte of this character will be
;  *      used as the mark character, and it is interpreted using the
;  *      application’s text encoding.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetMenuCommandMark" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inCommandID :UInt32)
    (inMark :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetMenuCommandMark()
;  *  
;  *  Summary:
;  *    Locates the menu item with a specified command ID and returns its
;  *    mark character.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu in which to begin searching for the item. Pass NULL to
;  *      begin searching with the root menu. The search will descend
;  *      into all submenus of this menu.
;  *    
;  *    inCommandID:
;  *      The command ID of the menu item to be examined. If more than
;  *      one item has this command ID, only the first will be examined.
;  *    
;  *    outMark:
;  *      On exit, the menu item's mark character.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuCommandMark" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inCommandID :UInt32)
    (outMark (:pointer :UniChar))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetMenuCommandProperty()
;  *  
;  *  Summary:
;  *    Retrives property data for a menu item with a specified command
;  *    ID.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu in which to begin searching for the item. Pass NULL to
;  *      begin searching with the root menu. The search will descend
;  *      into all submenus of this menu.
;  *    
;  *    inCommandID:
;  *      The command ID of the menu item containing the property. If
;  *      more than one item has this command ID, only the first will be
;  *      used.
;  *    
;  *    inPropertyCreator:
;  *      The property creator.
;  *    
;  *    inPropertyTag:
;  *      The property tag.
;  *    
;  *    inBufferSize:
;  *      The size of the output buffer, in bytes.
;  *    
;  *    outActualSize:
;  *      On exit, contains the actual size of the property data. May be
;  *      NULL if you do not need this information.
;  *    
;  *    inPropertyBuffer:
;  *      The address of a buffer in which to place the property data.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuCommandProperty" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inCommandID :UInt32)
    (inPropertyCreator :OSType)
    (inPropertyTag :OSType)
    (inBufferSize :UInt32)
    (outActualSize (:pointer :ByteCount))       ;  can be NULL 
    (inPropertyBuffer :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetMenuCommandPropertySize()
;  *  
;  *  Summary:
;  *    Retrives the size of property data for a menu item with a
;  *    specified command ID.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu in which to begin searching for the item. Pass NULL to
;  *      begin searching with the root menu. The search will descend
;  *      into all submenus of this menu.
;  *    
;  *    inCommandID:
;  *      The command ID of the menu item containing the property. If
;  *      more than one item has this command ID, only the first will be
;  *      used.
;  *    
;  *    inPropertyCreator:
;  *      The property creator.
;  *    
;  *    inPropertyTag:
;  *      The property tag.
;  *    
;  *    outSize:
;  *      On exit, contains the size of the property data.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuCommandPropertySize" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inCommandID :UInt32)
    (inPropertyCreator :OSType)
    (inPropertyTag :OSType)
    (outSize (:pointer :ByteCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetMenuCommandProperty()
;  *  
;  *  Summary:
;  *    Sets property data for a menu item with a specified command ID.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu in which to begin searching for the item. Pass NULL to
;  *      begin searching with the root menu. The search will descend
;  *      into all submenus of this menu.
;  *    
;  *    inCommandID:
;  *      The command ID of the menu item that will receive the property.
;  *      If more than one item has this command ID, only the first will
;  *      be modified.
;  *    
;  *    inPropertyCreator:
;  *      The property creator.
;  *    
;  *    inPropertyTag:
;  *      The property tag.
;  *    
;  *    inPropertySize:
;  *      The size of the property data, in bytes.
;  *    
;  *    inPropertyData:
;  *      The address of the property data.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetMenuCommandProperty" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inCommandID :UInt32)
    (inPropertyCreator :OSType)
    (inPropertyTag :OSType)
    (inPropertySize :UInt32)
    (inPropertyData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RemoveMenuCommandProperty()
;  *  
;  *  Summary:
;  *    Removes a property from a menu item with a specified command ID.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu in which to begin searching for the item. Pass NULL to
;  *      begin searching with the root menu. The search will descend
;  *      into all submenus of this menu.
;  *    
;  *    inCommandID:
;  *      The command ID of the menu item from which the property will be
;  *      removed. If more than one item has this command ID, only the
;  *      first will be modified.
;  *    
;  *    inPropertyCreator:
;  *      The property creator.
;  *    
;  *    inPropertyTag:
;  *      The property tag.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RemoveMenuCommandProperty" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inCommandID :UInt32)
    (inPropertyCreator :OSType)
    (inPropertyTag :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CopyMenuItemData()
;  *  
;  *  Summary:
;  *    Returns multiple attributes of a menu item at once.
;  *  
;  *  Discussion:
;  *    This function is used to retrieve many attributes of a menu item
;  *    simultaneously; for example, it might be used by a menu
;  *    definition function that needs to know how to draw a menu item.
;  *    It is more efficient to use this function than to use the
;  *    accessor functions for the individual attributes of the menu.
;  *    This function returns a copy of the data in the menu, so any data
;  *    in the MenuItemDataRec that is dynamically allocated (for
;  *    example, the CFString item text) should be released by the caller.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu from which to copy data. If inIsCommandID is true, you
;  *      may pass NULL for this parameter to search for an item in the
;  *      root menu; if inIsCommandID is false, this parameter must be a
;  *      valid MenuRef.
;  *    
;  *    inItem:
;  *      The item or command ID from which to copy data.
;  *    
;  *    inIsCommandID:
;  *      Indicates whether inItem is a MenuItemIndex or MenuCommand. If
;  *      inIsCommandID is true, the inItem parameter is interpreted as a
;  *      menu command ID, and data is copied from the first item in the
;  *      menu with that command ID. If inIsCommandID is false, the
;  *      inItem parameter is interpreted as a menu item index, and data
;  *      is copied for that item in the specified menu.
;  *    
;  *    ioData:
;  *      Data is copied from the item and placed here. On entry, the
;  *      whichData field of this structure should be initialized to
;  *      indicate which data the caller would like returned. Individual
;  *      fields of the MenuItemDataRec structure may require
;  *      pre-initialization also; see the individual MenuItemDataFlags
;  *      documentation for details.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CopyMenuItemData" 
   ((inMenu (:pointer :OpaqueMenuRef))          ;  can be NULL 
    (inItem :UInt32)
    (inIsCommandID :Boolean)
    (ioData (:pointer :MenuItemDataRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetMenuItemData()
;  *  
;  *  Summary:
;  *    Sets multiple attributes of a menu item at once.
;  *  
;  *  Discussion:
;  *    This function is used to set many attributes of a menu item
;  *    simultaneously. It is more efficient to use this function than to
;  *    use the accessor functions for the individual attributes of the
;  *    menu.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu to modify.
;  *    
;  *    inItem:
;  *      The item or command ID to modify.
;  *    
;  *    inIsCommandID:
;  *      Indicates whether inItem is a MenuItemIndex or MenuCommand. If
;  *      inIsCommandID is true, the inItem parameter is interpreted as a
;  *      menu command ID, and the first item in the menu with that
;  *      command ID. is modified. If inIsCommandID is false, the inItem
;  *      parameter is interpreted as a menu item index, and the item
;  *      with that index in the specified menu is modified.
;  *    
;  *    inData:
;  *      The data to set. The caller should set the whichData field of
;  *      this structure to indicate which data should be set. Only the
;  *      fields of the structure corresponding to the non-zero whichData
;  *      flags must be initialized; other fields are ignored.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetMenuItemData" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :UInt32)
    (inIsCommandID :Boolean)
    (inData (:pointer :MenuItemDataRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Dynamic menu item support (available in CarbonLib 1.1 and Mac OS X)               
;                                                                                       
;   Dynamic menu item support allows a menu item to be redrawn while the menu is open   
;   and visible to the user. Carbon contains automatic support for dynamic items based  
;   on keyboard modifier state. If you need to implement your own variable item state   
;   based on other system state, you can use these APIs to implement it.                
;                                                                                       
;   To use the built-in support for dynamic items, you should create a menu containing  
;   several contiguous items with the same command key but different text and modifier  
;   keys. For example, you might have:                                                  
;                                                                                       
;       Close       cmd-W                                                               
;       Close All   cmd-option-W                                                        
;                                                                                       
;   The Menu Manager automatically determines a dynamic menu group using the base       
;   command key of a dynamic menu item ('W' in this case). Only a single item from      
;   a dynamic group is visible at any time; the other items are hidden. The Menu        
;   Manager uses the current keyboard modifiers to determine which item is visible.     
;   It is also possible to have a dynamic menu item group that does not have command    
;   keys, but only modifiers; for example, in the Finder's View menu, the Clean Up      
;   and Clean Up Selection items have no command key, but are a dynamic menu item       
;   group that changes visibility based on the Option modifier key.                     
;                                                                                       
;   In this example, in your MENU resource, you would create the Close and Close All    
;   items and give them each the letter 'W' as the command key; using an associated     
;   xmnu resource, you would specify kMenuOptionModifier as the modifier for the        
;   Close All item. You can do the same thing using InterfacerBuilder and nib-based     
;   menus.                                                                              
;                                                                                       
;   After loading your menu from the resource, you must set the kMenuItemAttrDynamic    
;   flag for each dynamic item. In this example, you would use:                         
;                                                                                       
;       ChangeMenuItemAttributes( menu, kCloseItem, kMenuItemAttrDynamic, 0 );          
;       ChangeMenuItemAttributes( menu, kCloseAllItem, kMenuItemAttrDynamic, 0 );       
;                                                                                       
;   The Menu Manager will now automatically display the correct item depending on       
;   whether the Option key is pressed. The result from MenuSelect will be the item      
;   number of the item that was visible when the menu closed.                           
;                                                                                       
;   Note that:                                                                          
;                                                                                       
;       - If you use InterfacerBuilder, you can set the kMenuItemAttrDynamic attribute  
;         directly in the menu object in the nib, using the Inspector window for the    
;         menu. You don't need to add the attribute after creating the menu.            
;                                                                                       
;       - If your application requires Mac OS X 10.2 or CarbonLib 1.6 or later, you     
;         can also use a version-one-format 'xmnu' resource, which allows settting      
;         the menu item attributes in the 'xmnu'. Using a version one resource, you     
;         can include the kMenuItemAttrDynamic attribute in the resource rather than    
;         adding it after creating the menu.                                            
;                                                                                       
;   If the Menu Manager's built-in support is not sufficient, you can also change the   
;   attributes of an item yourself and use the UpdateInvalidMenuItems API to cause      
;   the menu to redraw. Changes to a menu item (changing text, command key, style,      
;   etc.) that occur while the menu is open will cause the menu item to be invalidated, 
;   but not redrawn. If you need to invalidate the item explicitly yourself, perhaps    
;   because you have a custom MDEF that depends on state not accessed using Menu        
;   Manager APIs, you can use the InvalidateMenuItems API. UpdateInvalidMenuItems will  
;   scan the menu for invalid items and redraw each, clearing its invalid flag          
;   afterwards.                                                                         
;                                                                                       
;   If you need to change menu contents based on modifier key state without using the   
;   built-in support in the Menu Manager, we recommend that you install a Carbon event  
;   handler on your menu for the [kEventClassKeyboard, kEventRawKeyModifiersChanged]    
;   event. Modifier key events are passed to the currently open menu before being sent  
;   to the user focus target.                                                           
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  IsMenuItemInvalid()
;  *  
;  *  Summary:
;  *    Determines if a menu item is invalid and should be redrawn.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu whose item to examine.
;  *    
;  *    inItem:
;  *      The item to examine.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsMenuItemInvalid" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvalidateMenuItems()
;  *  
;  *  Summary:
;  *    Invalidates a group of menu items so that they will be redrawn
;  *    when UpdateInvalidMenuItems is next called.
;  *  
;  *  Discussion:
;  *    Menu items are automatically invalidated when their contents are
;  *    changed using Menu Manager APIs while the menu is open. However,
;  *    you might need to use this API if you have a custom MDEF that
;  *    draws using state not contained in the menu.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu whose items to invalidate.
;  *    
;  *    inFirstItem:
;  *      The first item to invalidate.
;  *    
;  *    inNumItems:
;  *      The number of items to invalidate.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvalidateMenuItems" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inFirstItem :UInt16)
    (inNumItems :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  UpdateInvalidMenuItems()
;  *  
;  *  Summary:
;  *    Redraws the invalid items of an open menu.
;  *  
;  *  Discussion:
;  *    It is not necessary to use UpdateInvalidMenuItems if you are
;  *    using Carbon's built-in support for dynamic items based on
;  *    modifier key state. However, if you are modifying items
;  *    dynamically using your own implementation, you should call
;  *    UpdateInvalidMenuItems after completing your modifications for a
;  *    single menu. It will redraw any items that have been marked as
;  *    invalid, and clear the invalid flag for those items.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      The menu to update.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_UpdateInvalidMenuItems" 
   ((inMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Standard font menu (Carbon and later)                                             
;                                                                                       
;   These APIs allow you to create and use the standard font menu.                      
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kHierarchicalFontMenuOption 1)
; 
;  *  CreateStandardFontMenu()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateStandardFontMenu" 
   ((menu (:pointer :OpaqueMenuRef))
    (afterItem :UInt16)
    (firstHierMenuID :SInt16)
    (options :UInt32)
    (outHierMenuCount (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  UpdateStandardFontMenu()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_UpdateStandardFontMenu" 
   ((menu (:pointer :OpaqueMenuRef))
    (outHierMenuCount (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetFontFamilyFromMenuSelection()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetFontFamilyFromMenuSelection" 
   ((menu (:pointer :OpaqueMenuRef))
    (item :UInt16)
    (outFontFamily (:pointer :FMFontFamily))
    (outStyle (:pointer :FMFONTSTYLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Contextual Menu routines and constants                                            
;   available with Conxtextual Menu extension 1.0 and later                             
; ——————————————————————————————————————————————————————————————————————————————————————
;  Gestalt Selector for classic 68K apps only. 
;  CFM apps should weak link and check the symbols. 

(defconstant $gestaltContextualMenuAttr :|cmnu|)
(defconstant $gestaltContextualMenuUnusedBit 0)
(defconstant $gestaltContextualMenuTrapAvailable 1)
(defconstant $gestaltContextualMenuHasAttributeAndModifierKeys 2);  Contextual Menu Manager supports keyContextualMenuAttributes and keyContextualMenuModifiers 

(defconstant $gestaltContextualMenuHasUnicodeSupport 3);  Contextual Menu Manager supports typeUnicodeText and typeCFStringRef 

; 
;  *  Summary:
;  *    Values indicating what kind of help the application supports
;  
; 
;    * The application does not support any help. The Menu Manager will
;    * put an appropriate help string into the contextual menu and
;    * disable the Help item.
;    

(defconstant $kCMHelpItemNoHelp 0)
; 
;    * The application supports Apple Guide help. The Menu Manager will
;    * put the name of the main Guide file into the contextual menu and
;    * enable the Help item.
;    

(defconstant $kCMHelpItemAppleGuide 1)
; 
;    * The application supports some other form of help. In this case,
;    * the application must also pass a valid string into the
;    * inHelpItemString parameter of ContextualMenuSelect. This string
;    * will be the text of the Help item in the contextual menu, and the
;    * Help item will be enabled.
;    

(defconstant $kCMHelpItemOtherHelp 2)
; 
;    * The application does not support any help. The Menu Manager will
;    * remove the Help item from the contextual menu. This constant is
;    * available in Mac OS X and CarbonLib 1.6, and later; however, in
;    * CarbonLib it is translated to kCMHelpItemNoHelp, and the Help item
;    * is only disabled, not removed.
;    

(defconstant $kCMHelpItemRemoveHelp 3)
; 
;  *  Summary:
;  *    Values indicating what was chosen from a contextual menu
;  
; 
;    * The user did not choose an item from the contextual menu and the
;    * application should do no further processing of the event.
;    

(defconstant $kCMNothingSelected 0)
; 
;    * The user chose one of the application's items from the menu. The
;    * application can examine the outMenuID and outMenuItem parameters
;    * of ContextualMenuSelect to see what the menu selection was, and it
;    * should then handle the selection appropriately.
;    

(defconstant $kCMMenuItemSelected 1)
; 
;    * The user chose the Help item from the menu. The application should
;    * open an Apple Guide database to a section appropriate for the
;    * selection. If the application supports some other form of help, it
;    * should be presented instead.
;    

(defconstant $kCMShowHelpSelected 3)
; 
;  *  Summary:
;  *    AERecord keywords used by the ExamineContext method of a
;  *    Contextual Menu plugin to specify menu item contents.
;  
; 
;    * Specifies the text of an item in a contextual menu. Data for this
;    * parameter can be in one of several formats. In Mac OS 7/8/9.x and
;    * Mac OS X 10.0 and 10.1, typeChar and typeIntlText are supported.
;    * In Mac OS X after 10.1, typeStyledText, typeAEText,
;    * typeUnicodeText, and typeCFStringRef are also supported. If you
;    * provide data as typeCFStringRef, the Contextual Menu Manager will
;    * automatically release the CFStringRef once the menu has been
;    * displayed. If you need the CFStringRef to have a longer timetime,
;    * your plugin should retain the CFStringRef before inserting it into
;    * the AERecord.
;    

(defconstant $keyContextualMenuName :|pnam|)
; 
;    * Specifies the command ID of an item in a contextual menu. Data for
;    * this parameter should be typeLongInteger.
;    

(defconstant $keyContextualMenuCommandID :|cmcd|)
; 
;    * Specifies a contextual menu item with a submenu. Typically used
;    * with AEPutKeyDesc to add an entire AEDesc containing the submenu
;    * as the data for the parameter.
;    

(defconstant $keyContextualMenuSubmenu :|cmsb|)
; 
;    * Specifies the menu item attributes of an item in a contextual
;    * menu. Data for this parameter should be typeLongInteger. Available
;    * in Mac OS X after 10.1.
;    

(defconstant $keyContextualMenuAttributes :|cmat|)
; 
;    * Specifies the modifier keys of an item in a contextual menu (see
;    * kMenuShiftModifier, kMenuControlModifier, etc.) Data for this
;    * parameter should be typeLongInteger. Using this parameter together
;    * with the keyContextualMenuAttributes parameter, it is possible to
;    * create a contextual menu with dynamic items which change according
;    * to the modifier keys pressed by the user. Available in Mac OS X
;    * after 10.1.
;    

(defconstant $keyContextualMenuModifiers :|cmmd|)
; 
;  *  InitContextualMenus()
;  *  
;  *  Summary:
;  *    Adds the current process to the system registry of contextual
;  *    menu clients.
;  *  
;  *  Discussion:
;  *    On Mac OS 8.x and 9.x, your program should call the
;  *    InitContextualMenus function early in your startup code to
;  *    register your application as a contextual menu client. If you do
;  *    not register your program, some system-level functions may
;  *    respond as though your program does not use contextual menus. Not
;  *    registering your program may also cause
;  *    ProcessIsContextualMenuClient to return an incorrect value. On
;  *    Mac OS X, it is not necessary to call InitContextualMenus.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ContextualMenu 1.0 and later
;  

(deftrap-inline "_InitContextualMenus" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  IsShowContextualMenuClick()
;  *  
;  *  Summary:
;  *    Determines whether a particular EventRecord could invoke a
;  *    contextual menu.
;  *  
;  *  Discussion:
;  *    Applications should call IsShowContextualMenuClick when they
;  *    receive non-null events. If IsShowContextualMenuClick returns
;  *    true, your application should generate its own menu and Apple
;  *    Event descriptor (AEDesc), and then call ContextualMenuSelect to
;  *    display and track the contextual menu, and then handle the user's
;  *    choice. Some users may choose to use a two-button mouse with
;  *    their Macintosh computer. This API does not return true for a
;  *    right-click unless the mouse manufacturer has provided driver
;  *    software that returns a control-left click in place of a right
;  *    click. For proper recognition of a right-click gesture, you must
;  *    use the IsShowContextualMenuEvent API.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inEvent:
;  *      The event to examine.
;  *  
;  *  Result:
;  *    Returns true if the application should display a contextual menu,
;  *    false if not.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ContextualMenu 1.0 and later
;  

(deftrap-inline "_IsShowContextualMenuClick" 
   ((inEvent (:pointer :EventRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  IsShowContextualMenuEvent()
;  *  
;  *  Summary:
;  *    Determines whether a particular EventRef could invoke a
;  *    contextual menu.
;  *  
;  *  Discussion:
;  *    This API is similar to IsShowContextualMenuClick, but takes a
;  *    Carbon EventRef as its parameter instead of an EventRecord.
;  *    EventRecords cannot express a right-mouse-click, but EventRefs
;  *    can, so this API will return true for a right- click where
;  *    IsShowContextualMenuClick will not.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inEvent:
;  *      The event to examine.
;  *  
;  *  Result:
;  *    Returns true if the application should display a contextual menu,
;  *    false if not.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsShowContextualMenuEvent" 
   ((inEvent (:pointer :OpaqueEventRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  ContextualMenuSelect()
;  *  
;  *  Summary:
;  *    Displays a contextual menu.
;  *  
;  *  Discussion:
;  *    If IsShowContextualMenuClick returns true, you should call the
;  *    ContextualMenuSelect API after generating your own menu and
;  *    preparing an Apple Event descriptor (AEDesc) that describes the
;  *    item for which your application is displaying a contextual menu.
;  *    This descriptor may contain an object specifier or raw data and
;  *    will be passed to all contextual menu plug-ins. The system will
;  *    add other items before displaying the contextual menu, and it
;  *    will remove those items before returning, leaving the menu in its
;  *    original state. After all the system commands are added, the
;  *    contextual menu is displayed and tracked. If the user selects one
;  *    of the system items, it is handled by the system and the call
;  *    returns as though the user didn't select anything from the menu.
;  *    If the user selects any other item (or no item at all), the Menu
;  *    Manager passes back appropriate values in the parameters
;  *    outUserSelectionType, outMenuID, and outMenuItem. Your
;  *    application should provide visual feedback indicating the item
;  *    that was clicked upon. For example, a click on an icon should
;  *    highlight the icon, while a click on editable text should not
;  *    eliminate the current selection. If the outUserSelectionType
;  *    parameter contains kCMMenuItemSelected, you should look at the
;  *    outMenuID and outMenuItem parameters to determine what menu item
;  *    the user chose and handle it appropriately. If the user selected
;  *    kCMHelpItemSelected, you should open the proper Apple Guide
;  *    sequence or other form of custom help.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inMenu:
;  *      A menu containing application commands to display. The caller
;  *      creates this menu based on the current context, the mouse
;  *      location, and the current selection (if it was the target of
;  *      the mouse). If you pass nil, only system commands will be
;  *      displayed. The menu should be added to the menu list as a
;  *      pop-up menu (using the InsertMenu function).
;  *    
;  *    inGlobalLocation:
;  *      The location (in global coordinates) of the mouse near which
;  *      the menu is to be displayed.
;  *    
;  *    inReserved:
;  *      Reserved for future use. Pass false for this parameter.
;  *    
;  *    inHelpType:
;  *      An identifier specifying the type of help to be provided by the
;  *      application; see kCMHelpItem constants.
;  *    
;  *    inHelpItemString:
;  *      A string containing the text to be displayed for the help menu
;  *      item. This string is unused unless you also pass the constant
;  *      kCMHelpItemOtherHelp in the inHelpType parameter.
;  *    
;  *    inSelection:
;  *      An object specifier for the current selection. This allows he
;  *      system to examine the selection and add special system commands
;  *      accordingly. Passing a value of nil indicates that no selection
;  *      should be examined, and most likely, no special system actions
;  *      will be included.
;  *    
;  *    outUserSelectionType:
;  *      On exit, the value indicates what the user selected from the
;  *      contextual menu; see kCMNothingSelected, kCMMenuItemSelected,
;  *      and kCMShowHelpSelected.
;  *    
;  *    outMenuID:
;  *      On exit, if outUserSelectionType is set to kCMMenuItemSelected,
;  *      the value is set to the menu ID of the chosen item.
;  *    
;  *    outMenuItem:
;  *      On exit, if outUserSelectionType is set to kCMMenuItemSelected,
;  *      the value is set to the menu item chosen.
;  *  
;  *  Result:
;  *    An OSStatus result code. ContextualMenuSelect returns the result
;  *    code userCanceledErr and sets outUserSelectionType to
;  *    kCMNothingSelected to indicate that the user did not select
;  *    anything from the contextual menu and no further processing is
;  *    needed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ContextualMenu 1.0 and later
;  

(deftrap-inline "_ContextualMenuSelect" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inGlobalLocation :Point)
    (inReserved :Boolean)
    (inHelpType :UInt32)
    (inHelpItemString (:pointer :STR255))       ;  can be NULL 
    (inSelection (:pointer :AEDesc))            ;  can be NULL 
    (outUserSelectionType (:pointer :UInt32))
    (outMenuID (:pointer :SInt16))
    (outMenuItem (:pointer :MENUITEMINDEX))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ProcessIsContextualMenuClient()
;  *  
;  *  Summary:
;  *    Determines whether the specified process is a contextual menu
;  *    client.
;  *  
;  *  Discussion:
;  *    On Mac OS 9, this API consults a global table of all processes
;  *    that have registered with the Contextual Menu Manager by calling
;  *    InitContextualMenus. On Mac OS X, this API ignores the inPSN
;  *    parameter and always returns whether the current process is
;  *    registered with the Contextual Menu Manager.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inPSN:
;  *      The process to examine.
;  *  
;  *  Result:
;  *    Whether the specified process (or, on Mac OS X, the current
;  *    process) is registered with the Contextual Menu Manager.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ContextualMenu 1.0 and later
;  

(deftrap-inline "_ProcessIsContextualMenuClient" 
   ((inPSN (:pointer :ProcessSerialNumber))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   Contextual Menu Plugin Interface                                                    
;                                                                                       
;   For Mac OS X 10.1, we support a new type of Contextual Menu Plugin: the CFPlugIn    
;   based plugin.  Each plugin must be in a CFPlugIn in the Contextual Menu Items       
;   folder in one of these paths:                                                       
;       /System/Library/Contextual Menu Items/                                          
;       /Library/Contextual Menu Items/                                                 
;       ~/Library/Contextual Menu Items/                                                
;                                                                                       
;   It must export the following functions using the following interface or a C++       
;   interface inheriting from IUnknown and including similar functions.                 
; ——————————————————————————————————————————————————————————————————————————————————————
;  The Contextual Menu Manager will only load CFPlugIns of type kContextualMenuTypeID 
; #define kContextualMenuTypeID ( CFUUIDGetConstantUUIDWithBytes( NULL,   0x2F, 0x65, 0x22, 0xE9, 0x3E, 0x66, 0x11, 0xD5,   0x80, 0xA7, 0x00, 0x30, 0x65, 0xB3, 0x00, 0xBC ) )
;  2F6522E9-3E66-11D5-80A7-003065B300BC 
;  Contextual Menu Plugins must implement this Contexual Menu Plugin Interface 
; #define kContextualMenuInterfaceID    ( CFUUIDGetConstantUUIDWithBytes( NULL,   0x32, 0x99, 0x7B, 0x62, 0x3E, 0x66, 0x11, 0xD5,   0xBE, 0xAB, 0x00, 0x30, 0x65, 0xB3, 0x00, 0xBC ) )
;  32997B62-3E66-11D5-BEAB-003065B300BC 
; #define CM_IUNKNOWN_C_GUTS    void *_reserved;  SInt32 (*QueryInterface)(void *thisPointer, CFUUIDBytes iid, void ** ppv);    UInt32 (*AddRef)(void *thisPointer);  UInt32 (*Release)(void *thisPointer)
;  The function table for the interface 
(defrecord ContextualMenuInterfaceStruct
#|
   (NIL :cm_iunknown_c_guts)|#
   (ExamineContext (:pointer :callback))        ;(OSStatus (void * thisInstance , const AEDesc * inContext , AEDescList * outCommandPairs))
   (HandleSelection (:pointer :callback))       ;(OSStatus (void * thisInstance , AEDesc * inContext , SInt32 inCommandID))
   (PostMenuCleanup (:pointer :callback))       ;(void (void * thisInstance))
)

;type name? (%define-record :ContextualMenuInterfaceStruct (find-record-descriptor ':ContextualMenuInterfaceStruct))
; 
;  *  CMPluginExamineContext()
;  *  
;  *  Availability:
;  *    Implemented by client
;  

(deftrap-inline "_CMPluginExamineContext" 
   ((thisInstance :pointer)
    (inContext (:pointer :AEDesc))
    (outCommandPairs (:pointer :AEDescList))
   )
   :OSStatus
() )
; 
;  *  CMPluginHandleSelection()
;  *  
;  *  Availability:
;  *    Implemented by client
;  

(deftrap-inline "_CMPluginHandleSelection" 
   ((thisInstance :pointer)
    (inContext (:pointer :AEDesc))
    (inCommandID :SInt32)
   )
   :OSStatus
() )
; 
;  *  CMPluginPostMenuCleanup()
;  *  
;  *  Availability:
;  *    Implemented by client
;  

(deftrap-inline "_CMPluginPostMenuCleanup" 
   ((thisInstance :pointer)
   )
   nil
() )
;  previously in LowMem.h.  This functions return the menu ID of the hilited menu 
; 
;  *  LMGetTheMenu()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetTheMenu" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  newmenu()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  appendmenu()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  insertmenuitem()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  menuselect()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  setmenuitemtext()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  getmenuitemtext()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if OLDROUTINENAMES
#| 
; #define AddResMenu(theMenu, theType) AppendResMenu(theMenu, theType)
; #define InsMenuItem(theMenu, itemString, afterItem) InsertMenuItem(theMenu, itemString, afterItem)
; #define DelMenuItem( theMenu, item ) DeleteMenuItem( theMenu, item )

; #if TARGET_OS_MAC
; #define SetItem MacSetItem
; #define GetItem MacGetItem

; #endif

; #define MacSetItem(theMenu, item, itemString) SetMenuItemText(theMenu, item, itemString)
; #define MacGetItem(theMenu, item, itemString) GetMenuItemText(theMenu, item, itemString)
; #define GetMHandle(menuID) GetMenuHandle(menuID)
; #define DelMCEntries(menuID, menuItem) DeleteMCEntries(menuID, menuItem)
; #define DispMCInfo(menuCTbl) DisposeMCInfo(menuCTbl)

; #if CALL_NOT_IN_CARBON
; #define addresmenu(menu, data) appendresmenu(menu, data)
; #define getitem(menu, item, itemString) getmenuitemtext(menu, item, itemString)
; #define setitem(menu, item, itemString) setmenuitemtext(menu, item, itemString)
; #define insmenuitem(theMenu, itemString, afterItem) insertmenuitem(theMenu, itemString, afterItem)

; #endif

 |#

; #endif  /* OLDROUTINENAMES */

;  Getters 
; 
;  *  GetMenuID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetMenuID" 
   ((menu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetMenuWidth()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetMenuWidth" 
   ((menu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetMenuHeight()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetMenuHeight" 
   ((menu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetMenuTitle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetMenuTitle" 
   ((menu (:pointer :OpaqueMenuRef))
    (title (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :UInt8)
() )
; 
;  *  GetMenuDefinition()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetMenuDefinition" 
   ((menu (:pointer :OpaqueMenuRef))
    (outDefSpec (:pointer :MenuDefSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Setters 
; 
;  *  SetMenuID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetMenuID" 
   ((menu (:pointer :OpaqueMenuRef))
    (menuID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMenuWidth()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetMenuWidth" 
   ((menu (:pointer :OpaqueMenuRef))
    (width :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMenuHeight()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetMenuHeight" 
   ((menu (:pointer :OpaqueMenuRef))
    (height :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMenuTitle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetMenuTitle" 
   ((menu (:pointer :OpaqueMenuRef))
    (title (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetMenuDefinition()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetMenuDefinition" 
   ((menu (:pointer :OpaqueMenuRef))
    (defSpec (:pointer :MenuDefSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )

; #if TARGET_OS_WIN32
#| 
 |#

; #endif  /* TARGET_OS_WIN32 */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __MENUS__ */


(provide-interface "Menus")