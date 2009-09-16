(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSToolbarItem.h"
; at Sunday July 2,2006 7:31:03 pm.
; 
; 	NSToolbarItem.h
; 	Application Kit
; 	Copyright (c) 2000-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/Foundation.h>

; #import <AppKit/NSUserInterfaceValidation.h>

; #import <AppKit/NSText.h>

; #import <AppKit/NSToolbar.h>
#| @INTERFACE 
NSToolbarItem : NSObject <NSCopying, NSValidatedUserInterfaceItem> {
private
    NSToolbar *		_toolbar;
    NSImage *		_image;
    NSString *		_itemIdentifier;
    
    NSString *		_label;
    NSTextAlignment	_labelAlignment;
    NSString *		_paletteLabel;
    
    NSString *		_toolTip;
    NSMenuItem *	_menuItemRep;
    int			_tag;
    
    struct __tbiFlags {
	unsigned int viewRespondsToIsEnabled:1;
	unsigned int viewRespondsToSetEnabled:1;
	unsigned int viewRespondsToTag:1;
	unsigned int viewRespondsToSetTag:1;
	unsigned int viewRespondsToAction:1;
	unsigned int viewRespondsToSetAction:1;
	unsigned int viewRespondsToTarget:1;
	unsigned int viewRespondsToSetTarget:1;
        unsigned int viewRespondsToImage:1;
        unsigned int viewRespondsToSetImage:1;
	unsigned int isEnabled:1;
	unsigned int isUserRemovable:1;
	unsigned int menuHasBeenSet:1;
        unsigned int menuRepIsDefault:1;
        unsigned int viewHasBeenLoaded:1;
        unsigned int drawingForDragImage:1;
        unsigned int isCustomItemType:1;
	unsigned int hasValidatedAutoModeConfiguration:1;
	unsigned int useAutoModeConfiguration:1;
	unsigned int RESERVED:13;
    } _tbiFlags;
    NSArray *		_allPossibleLabelsToFit;
        
    id			_itemViewer;
    NSView *		_view;
    NSSize		_minSize;
    NSSize		_maxSize;
}

- (id)initWithItemIdentifier:(NSString *)itemIdentifier;
    

- (NSString *)itemIdentifier;
- (NSToolbar *)toolbar;
    


- (void)setLabel:(NSString *)label;
- (NSString *)label;
    

- (void)setPaletteLabel:(NSString *)paletteLabel;
- (NSString *)paletteLabel;
    

- (void)setToolTip:(NSString*)toolTip;
- (NSString *)toolTip;
    

- (void)setMenuFormRepresentation:(NSMenuItem *)menuItem;
- (NSMenuItem *)menuFormRepresentation;
    

- (void)setTag:(int)tag;  
- (int)tag;
    

- (void)setTarget:(id)target;
- (id)target;
    

- (void)setAction:(SEL)action;
- (SEL)action;
    

- (void)setEnabled:(BOOL)enabled;
- (BOOL)isEnabled;
    

- (void)setImage:(NSImage*)image;
- (NSImage *)image;
    

- (void)setView:(NSView *)view;
- (NSView *)view;
    

- (void)setMinSize:(NSSize)size;
- (NSSize)minSize;
    

- (void)setMaxSize:(NSSize)size;
- (NSSize)maxSize;
    


- (void)validate;
    



- (BOOL)allowsDuplicatesInToolbar;
     

|#
#| @INTERFACE 
NSObject (NSToolbarItemValidation)
- (BOOL)validateToolbarItem:(NSToolbarItem *)theItem;
    

|#
;  standard toolbar item identifiers 
(def-mactype :NSToolbarSeparatorItemIdentifier (find-mactype '(:pointer :NSString)))
(def-mactype :NSToolbarSpaceItemIdentifier (find-mactype '(:pointer :NSString)))
(def-mactype :NSToolbarFlexibleSpaceItemIdentifier (find-mactype '(:pointer :NSString)))
(def-mactype :NSToolbarShowColorsItemIdentifier (find-mactype '(:pointer :NSString)))
;  Shows the color panel.
(def-mactype :NSToolbarShowFontsItemIdentifier (find-mactype '(:pointer :NSString)))
;  Shows the font panel.
(def-mactype :NSToolbarCustomizeToolbarItemIdentifier (find-mactype '(:pointer :NSString)))
;  Puts the current toolbar into customize mode.
(def-mactype :NSToolbarPrintItemIdentifier (find-mactype '(:pointer :NSString)))
;  Sends printDocument: to firstResponder, but you can change this in toolbarWillAddItem: if you need to do so.

(provide-interface "NSToolbarItem")