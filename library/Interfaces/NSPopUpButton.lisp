(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPopUpButton.h"
; at Sunday July 2,2006 7:30:56 pm.
; 
;         NSPopUpButton.h
;         Application Kit
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSButton.h>

; #import <AppKit/NSMenuItemCell.h>

; #import <AppKit/NSMenuItem.h>
#| @INTERFACE 
NSPopUpButton : NSButton {
    
    private
    struct __pbFlags {
        unsigned int needsPullsDownFromTemplate:1;          unsigned int RESERVED:31;
    } _pbFlags;
}

- (id)initWithFrame:(NSRect)buttonFrame pullsDown:(BOOL)flag;

- (void)setMenu:(NSMenu *)menu;
- (NSMenu *)menu;

- (void)setPullsDown:(BOOL)flag;
- (BOOL)pullsDown;
    
- (void)setAutoenablesItems:(BOOL)flag;
- (BOOL)autoenablesItems;

- (void)setPreferredEdge:(NSRectEdge)edge;
- (NSRectEdge)preferredEdge;
    
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

|#
;  Notifications 
(def-mactype :NSPopUpButtonWillPopUpNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSPopUpButton")