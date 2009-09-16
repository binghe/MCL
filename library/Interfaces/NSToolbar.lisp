(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSToolbar.h"
; at Sunday July 2,2006 7:31:03 pm.
; 
; 	NSToolbar.h
; 	Application Kit
; 	Copyright (c) 2000-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/Foundation.h>

; #import <AppKit/AppKitDefines.h>

(defconstant $NSToolbarDisplayModeDefault 0)
(defconstant $NSToolbarDisplayModeIconAndLabel 1)
(defconstant $NSToolbarDisplayModeIconOnly 2)
(defconstant $NSToolbarDisplayModeLabelOnly 3)
(def-mactype :NSToolbarDisplayMode (find-mactype ':SINT32))

(defconstant $NSToolbarSizeModeDefault 0)
(defconstant $NSToolbarSizeModeRegular 1)
(defconstant $NSToolbarSizeModeSmall 2)
(def-mactype :NSToolbarSizeMode (find-mactype ':SINT32))
#| @INTERFACE 
NSToolbar : NSObject {
private
    NSString *			_toolbarIdentifier;

    NSMutableArray *		_currentItems;
    NSMutableArray *		_currentItemIdentifiers;

    NSDictionary *		_initPListDatabase;
    id				_initPListTarget; 
    
    NSString *			_selectedItemIdentifier;
    int				_tbReserved1;

    id				_delegate;
    NSWindow *			_window;
    id				_configPalette;
    id 				_toolbarView;
    int				_notifPostEnabledCount;
    
    struct __tbFlags {
	unsigned int allowsUserCustomization:1;
	unsigned int autosavesUsingIdentifier:1;
	unsigned int initialConfigurationDone:1;
	unsigned int shouldHideAfterCustomization:1;
        unsigned int delegateDefaultItemIdentifiers:1;
        unsigned int delegateAllowedItemIdentifiers:1;
        unsigned int delegateItemWithItemIdentifier:1;
	unsigned int delegateNotificationsEnabled:1;
        unsigned int prefersToBeShown:1;
        unsigned int loadItemsImmediately:1;
        unsigned int currentItemsContainsPlaceholder:1;
        unsigned int customizationPanelIsRunning:1;
        unsigned int usesCustomSheetWidth:1;
        unsigned int clickAndDragPerformsCustomization:1;
        unsigned int showsNoContextMenu:1;
        unsigned int firstMoveableItemIndex:6;
        unsigned int keyboardLoopNeedsUpdating:1;
        unsigned int showHideDuringConfigurationChangeDisabled:1;
	unsigned int displayMode:2;
	unsigned int sizeMode:2;
	unsigned int delegateSelectableItemIdentifiers:1;
	unsigned int RESERVED:4;
    } _tbFlags;

    int				_customizationSheetWidth;
    void *			_tbReserved;
}

- (id)initWithIdentifier:(NSString *)identifier;
    

- (void)insertItemWithItemIdentifier:(NSString *)itemIdentifier atIndex:(int)index;
- (void)removeItemAtIndex:(int)index;
    

- (void)setDelegate:(id)delegate;
- (id)delegate;
    

- (void)setVisible:(BOOL)shown;
- (BOOL)isVisible;
    

- (void)runCustomizationPalette:(id)sender;
- (BOOL)customizationPaletteIsRunning;
    



- (void)setDisplayMode:(NSToolbarDisplayMode)displayMode;
- (NSToolbarDisplayMode)displayMode;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)setSelectedItemIdentifier:(NSString *)itemIdentifier;
- (NSString *)selectedItemIdentifier;
    
#endif

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (void)setSizeMode:(NSToolbarSizeMode)sizeMode;
- (NSToolbarSizeMode)sizeMode;
#endif

- (void)setAllowsUserCustomization:(BOOL)allowCustomization;
- (BOOL)allowsUserCustomization;
    

       

- (NSString *)identifier;
    

- (NSArray *)items;
    

- (NSArray *)visibleItems;
    



- (void)setAutosavesConfiguration:(BOOL)flag;
- (BOOL)autosavesConfiguration;
    

- (void)setConfigurationFromDictionary:(NSDictionary *)configDict;
- (NSDictionary *)configurationDictionary;
    



- (void)validateVisibleItems;
    

|#
#| @INTERFACE 
NSObject (NSToolbarDelegate)

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag;
    
    
- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar;
    

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar;
    

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar;
    
#endif

|#
#| @INTERFACE 
NSObject (NSToolbarNotifications)

- (void)toolbarWillAddItem: (NSNotification *)notification;
    

- (void)toolbarDidRemoveItem: (NSNotification *)notification;
    

|#
;  Notifications 
(def-mactype :NSToolbarWillAddItemNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSToolbarDidRemoveItemNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSToolbar")