(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTabView.h"
; at Sunday July 2,2006 7:31:02 pm.
; 
;         NSTabView.h
;         Application Kit
;         Copyright (c) 2000-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSView.h>

; #import <AppKit/NSCell.h>
(defconstant $NSAppKitVersionNumberWithDirectionalTabs 631.0)
; #define NSAppKitVersionNumberWithDirectionalTabs 631.0
(def-mactype :_NSTabViewType (find-mactype ':sint32))

(defconstant $NSTopTabsBezelBorder 0)           ;  the default

(defconstant $NSLeftTabsBezelBorder 1)
(defconstant $NSBottomTabsBezelBorder 2)
(defconstant $NSRightTabsBezelBorder 3)
(defconstant $NSNoTabsBezelBorder 4)
(defconstant $NSNoTabsLineBorder 5)
(defconstant $NSNoTabsNoBorder 6)
(def-mactype :NSTabViewType (find-mactype ':SINT32))
#| @INTERFACE 
NSTabView : NSView
{
    private
    	
    	
    
    id	_tabViewItems;                          	    NSTabViewItem	*_selectedTabViewItem;		    NSFont		*_font;				    NSTabViewType	_tabViewType;
    BOOL		_allowTruncatedLabels;
    id                  _delegate;

    	

    BOOL		_tabViewUnusedBOOL1;
    
    BOOL		_drawsBackground;		    NSTabViewItem	*_pressedTabViewItem;		    int			_endTabWidth;			    int			_maxOverlap;			    int			_tabHeight;			    NSTabViewItem	*_tabViewItemWithKeyView;	    NSView 		*_originalNextKeyView;		    struct __NSTabViewDelegateRespondTo {
        unsigned int shouldSelectTabViewItem:1;
        unsigned int willSelectTabViewItem:1;
        unsigned int didSelectTabViewItem:1;
        unsigned int didChangeNumberOfTabViewItems:1;
        unsigned int reserved:28;
    } _delegateRespondTo;
    
    struct __NSTabViewFlags {
        unsigned int needsLayout:1;
        unsigned int controlTint:3;	        unsigned int controlSize:2;	        unsigned int wiringNibConnections:1;
        unsigned int wiringInteriorLastKeyView:1;
        unsigned int originalNextKeyViewChanged:1;
	unsigned int liveResizeSkippedResetToolTips:1;
        unsigned int reserved:22;
    } _flags;

    	
    
    NSTabViewItem 	*_focusedTabViewItem;			
    void		*_tabViewUnused2;
}

	

- (void)selectTabViewItem:(NSTabViewItem *)tabViewItem;
- (void)selectTabViewItemAtIndex:(int)index;				- (void)selectTabViewItemWithIdentifier:(id)identifier;			- (void)takeSelectedTabViewItemFromSender:(id)sender;			
	

- (void)selectFirstTabViewItem:(id)sender;
- (void)selectLastTabViewItem:(id)sender;
- (void)selectNextTabViewItem:(id)sender;
- (void)selectPreviousTabViewItem:(id)sender;

	

- (NSTabViewItem *)selectedTabViewItem;					- (NSFont *)font;							- (NSTabViewType)tabViewType;
- (NSArray *)tabViewItems;
- (BOOL)allowsTruncatedLabels;
- (NSSize)minimumSize;							- (BOOL)drawsBackground;  						- (NSControlTint)controlTint;
- (NSControlSize)controlSize;

	

- (void)setFont:(NSFont *)font;
- (void)setTabViewType:(NSTabViewType)tabViewType;
- (void)setAllowsTruncatedLabels:(BOOL)allowTruncatedLabels;
- (void)setDrawsBackground:(BOOL)flag;  					- (void)setControlTint:(NSControlTint)controlTint;
- (void)setControlSize:(NSControlSize)controlSize;

	

- (void)addTabViewItem:(NSTabViewItem *)tabViewItem;				- (void)insertTabViewItem:(NSTabViewItem *)tabViewItem atIndex:(int)index;	- (void)removeTabViewItem:(NSTabViewItem *)tabViewItem;				
	

- (void)setDelegate:(id)anObject;
- (id)delegate;

	

- (NSTabViewItem *)tabViewItemAtPoint:(NSPoint)point;			
	

- (NSRect)contentRect;							
	

- (int)numberOfTabViewItems;
- (int)indexOfTabViewItem:(NSTabViewItem *)tabViewItem;			- (NSTabViewItem *)tabViewItemAtIndex:(int)index;			- (int)indexOfTabViewItemWithIdentifier:(id)identifier;			
|#
; ================================================================================
; 	NSTabViewDelegate protocol
; ================================================================================
#| @INTERFACE 
NSObject(NSTabViewDelegate)
- (BOOL)tabView:(NSTabView *)tabView shouldSelectTabViewItem:(NSTabViewItem *)tabViewItem;
- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(NSTabViewItem *)tabViewItem;
- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem;
- (void)tabViewDidChangeNumberOfTabViewItems:(NSTabView *)TabView;
|#

(provide-interface "NSTabView")