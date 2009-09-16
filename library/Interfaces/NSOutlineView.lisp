(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSOutlineView.h"
; at Sunday July 2,2006 7:30:55 pm.
; 
;         NSOutlineView.h
;         Application Kit
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSTableView.h>

; #import <AppKit/AppKitDefines.h>
(defrecord __OvFlags
; #ifdef __BIG_ENDIAN__
   (delegateWillDisplayCell :UInt32)
   (delegateShouldEditTableColumn :UInt32)
   (delegateShouldSelectItem :UInt32)
   (delegateShouldSelectTableColumn :UInt32)
   (delegateSelectionShouldChangeInOutlineView :UInt32)
   (delegateShouldCollapseItem :UInt32)
   (delegateShouldExpandItem :UInt32)
   (autoresizesOutlineColumn :UInt32)
   (autoSaveExpandItems :UInt32)
   (enableExpandNotifications :UInt32)
   (delegateWillDisplayOutlineCell :UInt32)
   (removeChildInProgress :UInt32)
   (selectionAdjustmentDisabled :UInt32)
   (autoExpandFlashState :UInt32)
   (compatCollapseForceClearsExpandState :UInt32)
   (_reserved :UInt32)
#| 
; #else
   (_reserved :UInt32)
   (compatCollapseForceClearsExpandState :UInt32)
   (autoExpandFlashState :UInt32)
   (selectionAdjustmentDisabled :UInt32)
   (removeChildInProgress :UInt32)
   (delegateWillDisplayOutlineCell :UInt32)
   (enableExpandNotifications :UInt32)
   (autoSaveExpandItems :UInt32)
   (autoresizesOutlineColumn :UInt32)
   (delegateShouldExpandItem :UInt32)
   (delegateShouldCollapseItem :UInt32)
   (delegateSelectionShouldChangeInOutlineView :UInt32)
   (delegateShouldSelectTableColumn :UInt32)
   (delegateShouldSelectItem :UInt32)
   (delegateShouldEditTableColumn :UInt32)
   (delegateWillDisplayCell :UInt32)
 |#

; #endif

)
(%define-record :_OVFlags (find-record-descriptor :__OVFLAGS))

(defconstant $NSOutlineViewDropOnItemIndex -1)
;  May be used as a valid childIndex of a drop target item.  In this case, the drop will happen directly on the target item.
#| @INTERFACE 
NSOutlineView : NSTableView {
  private
    int			_numberOfRows;
    void		*_Rows;
    void		*_REItemCache;
    void		*_REChildCache;
    int			_REItemCount;
    int			_unused1;
    NSTableColumn	*_outlineTableColumn;
    BOOL                _initedRows;
    BOOL		_indentationMarkerInCell;
    int			_indentationPerLevel;
    NSButtonCell       	*_outlineCell;
    NSRect		_trackingOutlineFrame;
    NSMouseTracker 	*_tracker;
    id 			_NC;
    _OVFlags		_ovFlags;
    id			_ovLock;
    long       		*_indentArray;
    long		_originalWidth;
    id			_expandSet;
    id			_expandSetToExpandItemsInto;
    long       		_indentArraySize;
    NSButtonCell        *_trackingOutlineCell;
    int                 _trackingRow;
    void		*_ovReserved;
}

- (void)setOutlineTableColumn: (NSTableColumn *)outlineTableColumn;
- (NSTableColumn *)outlineTableColumn;

- (BOOL)isExpandable:(id)item;		- (void)expandItem:(id)item expandChildren:(BOOL)expandChildren;
- (void)expandItem:(id)item;		- (void)collapseItem:(id)item collapseChildren:(BOOL)collapseChildren;
- (void)collapseItem:(id)item;		- (void)reloadItem:(id)item reloadChildren:(BOOL)reloadChildren;
- (void)reloadItem:(id)item;		
- (id)itemAtRow:(int)row;
- (int)rowForItem:(id)item;

- (int)levelForItem:(id)item;
- (int)levelForRow:(int)row;
- (BOOL)isItemExpanded:(id)item;
- (void)setIndentationPerLevel:(float)indentationPerLevel;
- (float)indentationPerLevel;
- (void)setIndentationMarkerFollowsCell: (BOOL)drawInCell;
- (BOOL)indentationMarkerFollowsCell;
- (void)setAutoresizesOutlineColumn: (BOOL)resize;
- (BOOL)autoresizesOutlineColumn;

- (void)setDropItem:(id)item dropChildIndex:(int)index;
    
- (BOOL)shouldCollapseAutoExpandedItemsForDeposited:(BOOL)deposited;
    
- (BOOL)autosaveExpandedItems;
- (void)setAutosaveExpandedItems:(BOOL)save;

|#
;  Data Source Note: Specifying nil as the item will refer to the "root" item(s).
#| @INTERFACE 
NSObject(NSOutlineViewDataSource)
- (id)outlineView:(NSOutlineView *)outlineView child:(int)index ofItem:(id)item;
- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item;
- (int)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item;
- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item;
- (void)outlineView:(NSOutlineView *)outlineView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn byItem:(id)item;
- (id)outlineView:(NSOutlineView *)outlineView itemForPersistentObject:(id)object;
- (id)outlineView:(NSOutlineView *)outlineView persistentObjectForItem:(id)item;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

- (void)outlineView:(NSOutlineView *)outlineView sortDescriptorsDidChange:(NSArray *)oldDescriptors;
    
#endif


- (BOOL)outlineView:(NSOutlineView *)olv writeItems:(NSArray*)items toPasteboard:(NSPasteboard*)pboard;
    
- (NSDragOperation)outlineView:(NSOutlineView*)olv validateDrop:(id <NSDraggingInfo>)info proposedItem:(id)item proposedChildIndex:(int)index;
    
- (BOOL)outlineView:(NSOutlineView*)olv acceptDrop:(id <NSDraggingInfo>)info item:(id)item childIndex:(int)index;
    
|#
#| @INTERFACE 
NSObject(NSOutlineViewDelegate)
- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item;
- (BOOL)outlineView:(NSOutlineView *)outlineView shouldEditTableColumn:(NSTableColumn *)tableColumn item:(id)item;
- (BOOL)selectionShouldChangeInOutlineView:(NSOutlineView *)outlineView;
- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item;
- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectTableColumn:(NSTableColumn *)tableColumn;
- (BOOL)outlineView:(NSOutlineView *)outlineView shouldExpandItem:(id)item;
- (BOOL)outlineView:(NSOutlineView *)outlineView shouldCollapseItem:(id)item;
- (void)outlineView:(NSOutlineView *)outlineView willDisplayOutlineCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)outlineView:(NSOutlineView *)outlineView mouseDownInHeaderOfTableColumn:(NSTableColumn *)tableColumn;
- (void)outlineView:(NSOutlineView *)outlineView didClickTableColumn:(NSTableColumn *)tableColumn;
- (void)outlineView:(NSOutlineView *)outlineView didDragTableColumn:(NSTableColumn *)tableColumn;
#endif

|#
;  Notifications 
(def-mactype :NSOutlineViewSelectionDidChangeNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSOutlineViewColumnDidMoveNotification (find-mactype '(:pointer :NSString)))
;  @"NSOldColumn", @"NSNewColumn"
(def-mactype :NSOutlineViewColumnDidResizeNotification (find-mactype '(:pointer :NSString)))
;  @"NSTableColumn", @"NSOldWidth"
(def-mactype :NSOutlineViewSelectionIsChangingNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSOutlineViewItemWillExpandNotification (find-mactype '(:pointer :NSString)))
;  NSObject
(def-mactype :NSOutlineViewItemDidExpandNotification (find-mactype '(:pointer :NSString)))
;  NSObject
(def-mactype :NSOutlineViewItemWillCollapseNotification (find-mactype '(:pointer :NSString)))
;  NSObject
(def-mactype :NSOutlineViewItemDidCollapseNotification (find-mactype '(:pointer :NSString)))
;  NSObject
#| @INTERFACE 
NSObject(NSOutlineViewNotifications)
- (void)outlineViewSelectionDidChange:(NSNotification *)notification;
- (void)outlineViewColumnDidMove:(NSNotification *)notification;
- (void)outlineViewColumnDidResize:(NSNotification *)notification;
- (void)outlineViewSelectionIsChanging:(NSNotification *)notification;
- (void)outlineViewItemWillExpand:(NSNotification *)notification;
- (void)outlineViewItemDidExpand:(NSNotification *)notification;
- (void)outlineViewItemWillCollapse:(NSNotification *)notification;
- (void)outlineViewItemDidCollapse:(NSNotification *)notification;
|#

(provide-interface "NSOutlineView")