(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPopUpButtonCell.h"
; at Sunday July 2,2006 7:30:56 pm.
; 
;         NSPopUpButtonCell.h
;         Application Kit
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSMenuItemCell.h>

; #import <AppKit/NSMenuItem.h>

(defconstant $NSPopUpNoArrow 0)
(defconstant $NSPopUpArrowAtCenter 1)
(defconstant $NSPopUpArrowAtBottom 2)
(def-mactype :NSPopUpArrowPosition (find-mactype ':SINT32))
#| @INTERFACE 
NSPopUpButtonCell : NSMenuItemCell {
    
    private
    NSMenu *_menu;
    int _selectedIndex;
    struct __pbcFlags {
        unsigned int pullsDown:1;
        unsigned int preferredEdge:3;
        unsigned int menuIsAttached:1;
        unsigned int usesItemFromMenu:1;
        unsigned int altersStateOfSelectedItem:1;
        unsigned int decoding:1;
        unsigned int arrowPosition:2;
        unsigned int ignoreMenuLayout:1;
        unsigned int drawing:1;
        unsigned int RESERVED:20;
    } _pbcFlags;
}

- (id)initTextCell:(NSString *)stringValue pullsDown:(BOOL)pullDown;

- (void)setMenu:(NSMenu *)menu;
- (NSMenu *)menu;

- (void)setPullsDown:(BOOL)flag;
- (BOOL)pullsDown;
    
- (void)setAutoenablesItems:(BOOL)flag;
- (BOOL)autoenablesItems;

- (void)setPreferredEdge:(NSRectEdge)edge;
- (NSRectEdge)preferredEdge;
    
- (void)setUsesItemFromMenu:(BOOL)flag;
- (BOOL)usesItemFromMenu;
    
- (void)setAltersStateOfSelectedItem:(BOOL)flag;
- (BOOL)altersStateOfSelectedItem;
    
- (void)addItemWithTitle:(NSString *)title;
- (void)addItemsWithTitles:(NSArray *)itemTitles;
- (void)insertItemWithTitle:(NSString *)title atIndex:(int)index;

- (void)removeItemWithTitle:(NSString *)title;
- (void)removeItemAtIndex:(int)index;
- (void)removeAllItems;


- (NSArray *)itemArray;
- (int)numberOfItems;

- (int)indexOfItem:(id <NSMenuItem>)item;
- (int)indexOfItemWithTitle:(NSString *)title;
- (int)indexOfItemWithTag:(int)tag;
- (int)indexOfItemWithRepresentedObject:(id)obj;
- (int)indexOfItemWithTarget:(id)target andAction:(SEL)actionSelector;

- (id <NSMenuItem>)itemAtIndex:(int)index;
- (id <NSMenuItem>)itemWithTitle:(NSString *)title;
- (id <NSMenuItem>)lastItem;


- (void)selectItem:(id <NSMenuItem>)item;
- (void)selectItemAtIndex:(int)index;
- (void)selectItemWithTitle:(NSString *)title;
- (void)setTitle:(NSString *)aString;

- (id <NSMenuItem>)selectedItem;
- (int)indexOfSelectedItem;
- (void)synchronizeTitleAndSelectedItem;


- (NSString *)itemTitleAtIndex:(int)index;
- (NSArray *)itemTitles;
- (NSString *)titleOfSelectedItem;

- (void)attachPopUpWithFrame:(NSRect)cellFrame inView:(NSView *)controlView;
- (void)dismissPopUp;
- (void)performClickWithFrame:(NSRect)frame inView:(NSView *)controlView;

- (NSPopUpArrowPosition)arrowPosition;
- (void)setArrowPosition:(NSPopUpArrowPosition)position;

- (id <NSCopying>)objectValue;
- (void)setObjectValue:(id <NSCopying>)obj;

|#
;  Notifications 
(def-mactype :NSPopUpButtonCellWillPopUpNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSPopUpButtonCell")