(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSSearchFieldCell.h"
; at Sunday July 2,2006 7:30:59 pm.
; 
; 	NSSearchFieldCell.h
; 	Application Kit
; 	Copyright (c) 2003, Apple Computer, Inc.
; 	All rights reserved.
;  

; #import <AppKit/NSTextFieldCell.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
;  Search menu template tags. Special items in the search menu are tagged so when the actual dynamic search menu is constructed, we know which items to show or hide.
(defconstant $NSSearchFieldRecentsTitleMenuItemTag 1000)
; #define	NSSearchFieldRecentsTitleMenuItemTag     1000
;  Title of recents menu group. Hidden if no recents. Also use for separators that my go away with recents
(defconstant $NSSearchFieldRecentsMenuItemTag 1001)
; #define	NSSearchFieldRecentsMenuItemTag          1001
;  Recent items have this tag. Use to indicate location of recents in custom menu if no title specified
(defconstant $NSSearchFieldClearRecentsMenuItemTag 1002)
; #define	NSSearchFieldClearRecentsMenuItemTag     1002
;  The 'Clear Recents' item has this tag. Hidden if no recents
(defconstant $NSSearchFieldNoRecentsMenuItemTag 1003)
; #define	NSSearchFieldNoRecentsMenuItemTag        1003
;  The item describing a lack of recents uses this tag. Hidden if recents
#| @INTERFACE 
NSSearchFieldCell : NSTextFieldCell {
  private
    struct __sfFlags {
	unsigned int sendsWholeSearchString:1;
	unsigned int maximumRecents:8;
	unsigned int cancelVisible:1;
	unsigned int drawSize:2;
	unsigned int disableText:1;
	unsigned int menuTracking:1;
	unsigned int reserved:18;
    } _sfFlags;
    NSButtonCell*   _searchButtonCell;
    NSButtonCell*   _cancelButtonCell;
    NSMenu*         _searchMenuTemplate;
    NSString*       _recentsAutosaveName;
    NSMutableArray* _recentSearches;
    NSMenu*         _searchMenu;
    NSTimer*        _partialStringTimer;
    unsigned int _reserved1;
    unsigned int _reserved2;
    unsigned int _reserved3;
    unsigned int _reserved4;    
}

- (NSButtonCell*) searchButtonCell;
- (void) setSearchButtonCell:(NSButtonCell*)cell;
    
- (NSButtonCell*) cancelButtonCell;
- (void) setCancelButtonCell:(NSButtonCell*)cell;
    
- (void) resetSearchButtonCell;
- (void) resetCancelButtonCell;
    
- (NSRect) searchTextRectForBounds:(NSRect)rect;
- (NSRect) searchButtonRectForBounds:(NSRect)rect;
- (NSRect) cancelButtonRectForBounds:(NSRect)rect;
    
- (void) setSearchMenuTemplate:(NSMenu*)menu;
- (NSMenu*)searchMenuTemplate;
    
- (void) setSendsWholeSearchString:(BOOL)flag;
- (BOOL) sendsWholeSearchString;
    
- (void) setMaximumRecents:(int)maxRecents;
- (int) maximumRecents;
    
- (void) setRecentSearches:(NSArray*)searches;
- (NSArray*) recentSearches;
    
- (void) setRecentsAutosaveName:(NSString*)string;
- (NSString*) recentsAutosaveName;
    
|#

; #endif


(provide-interface "NSSearchFieldCell")