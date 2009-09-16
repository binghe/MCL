(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTableView.h"
; at Sunday July 2,2006 7:31:01 pm.
; 
;         NSTableView.h
;         Application Kit
;         Copyright (c) 1995-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSControl.h>

; #import <AppKit/AppKitDefines.h>

; #import <AppKit/NSDragging.h>

; #import <AppKit/NSUserInterfaceValidation.h>
(defrecord __TvFlags
; #ifdef __BIG_ENDIAN__
   (allowsColumnReordering :UInt32)
   (allowsColumnResizing :UInt32)
   (oldDrawsGridFlag :UInt32)
   (allowsEmptySelection :UInt32)
   (allowsMultipleSelection :UInt32)
   (allowsColumnSelection :UInt32)
   (selectionType :UInt32)
   (changingLayout :UInt32)
   (compareWidthWithSuperview :UInt32)
   (delegateWillDisplayCell :UInt32)
   (delegateShouldEditTableColumn :UInt32)
   (delegateShouldSelectRow :UInt32)
   (delegateShouldSelectTableColumn :UInt32)
   (delegateSelectionShouldChangeInTableView :UInt32)
   (autoresizesAllColumnsToFit :UInt32)
   (dataSourceSetObjectValue :UInt32)
   (selectionPostingDisableCount :UInt32)
   (movedPostingDisableCount :UInt32)
   (refusesFirstResponder :UInt32)
#| 
; #else
   (refusesFirstResponder :UInt32)
   (movedPostingDisableCount :UInt32)
   (selectionPostingDisableCount :UInt32)
   (dataSourceSetObjectValue :UInt32)
   (autoresizesAllColumnsToFit :UInt32)
   (delegateSelectionShouldChangeInTableView :UInt32)
   (delegateShouldSelectTableColumn :UInt32)
   (delegateShouldSelectRow :UInt32)
   (delegateShouldEditTableColumn :UInt32)
   (delegateWillDisplayCell :UInt32)
   (compareWidthWithSuperview :UInt32)
   (changingLayout :UInt32)
   (selectionType :UInt32)
   (allowsColumnSelection :UInt32)
   (allowsMultipleSelection :UInt32)
   (allowsEmptySelection :UInt32)
   (oldDrawsGridFlag :UInt32)
   (allowsColumnResizing :UInt32)
   (allowsColumnReordering :UInt32)
 |#

; #endif

)
(%define-record :_TvFlags (find-record-descriptor :__TVFLAGS))

(defconstant $NSTableViewDropOn 0)
(defconstant $NSTableViewDropAbove 1)
(def-mactype :NSTableViewDropOperation (find-mactype ':SINT32))
;  In drag and drop, used to specify a dropOperation.  For example, given a table with N rows (numbered with row 0 at the top visually), a row of N-1 and operation of NSTableViewDropOn would specify a drop on the last row.  To specify a drop below the last row, one would use a row of N and NSTableViewDropAbove for the operation.

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
;  Grid styles	

(defconstant $NSTableViewGridNone 0)
(defconstant $NSTableViewSolidVerticalGridLineMask 1)
(defconstant $NSTableViewSolidHorizontalGridLineMask 2)

; #endif

#| @INTERFACE 
NSTableView : NSControl <NSUserInterfaceValidations>
{
    
    NSTableHeaderView	*_headerView;
    NSView		*_cornerView;
    NSMutableArray     	*_tableColumns;
    NSCell		*_editingCell;
    id			_delegate;
    id			_dataSource;
    NSSize		_intercellSpacing;
    float		_rowHeight;
    int			_lastSelectedColumn;
    int			_lastSelectedRow;
    int			_editingRow;
    int			_editingColumn;
    NSMutableIndexSet	*_selectedColumns;
    NSMutableIndexSet	*_selectedRows;
    NSImage		*_bodyDragImage;
    NSColor		*_backgroundColor;
    NSColor		*_gridColor;
    float		_dragYPos;
    id			_target;
    SEL                 _action;
    SEL                 _doubleAction;
    NSRect		_rectOfLastColumn;
    int			_lastCachedRectColumn;
    NSRect		_rectOfLastRow;
    int			_lastCachedRectRow;
    _TvFlags            _tvFlags;
    void*               _reserved;
}

- (void)setDataSource:(id)aSource;
- (id)dataSource;
- (void)setDelegate:(id)delegate;
- (id)delegate;
- (void)setHeaderView:(NSTableHeaderView *)headerView;
- (NSTableHeaderView *)headerView;
- (void)setCornerView:(NSView *)cornerView;
- (NSView *)cornerView;
- (void)setAllowsColumnReordering:(BOOL)flag;
- (BOOL)allowsColumnReordering;
- (void)setAllowsColumnResizing:(BOOL)flag;
- (BOOL)allowsColumnResizing;
- (void)setAutoresizesAllColumnsToFit:(BOOL)flag;
- (BOOL)autoresizesAllColumnsToFit;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)setGridStyleMask:(unsigned int)gridType;
- (unsigned int)gridStyleMask;
#endif

- (void)setDrawsGrid:(BOOL)flag;  - (BOOL)drawsGrid;  
- (void)setIntercellSpacing:(NSSize)aSize;
- (NSSize)intercellSpacing;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)setUsesAlternatingRowBackgroundColors:(BOOL)useAlternatingRowColors;
- (BOOL)usesAlternatingRowBackgroundColors;
    #endif

- (void)setBackgroundColor:(NSColor *)color;
- (NSColor *)backgroundColor;

- (void)setGridColor:(NSColor *)color;
- (NSColor *)gridColor;
- (void)setRowHeight:(float)rowHeight;
- (float)rowHeight;

- (NSArray *)tableColumns;
- (int)numberOfColumns;
- (int)numberOfRows;

- (void)addTableColumn:(NSTableColumn *)column;
- (void)removeTableColumn:(NSTableColumn *)column;
- (int)columnWithIdentifier:(id)identifier;
- (NSTableColumn *)tableColumnWithIdentifier:(id)identifier;

- (void)tile;
- (void)sizeToFit;
- (void)sizeLastColumnToFit;
- (void)scrollRowToVisible:(int)row;
- (void)scrollColumnToVisible:(int)column;
- (void)moveColumn:(int)column toColumn:(int)newIndex;

- (void)reloadData;
- (void)noteNumberOfRowsChanged;

- (int)editedColumn;
- (int)editedRow;
- (int)clickedColumn;
- (int)clickedRow;

- (void)setDoubleAction:(SEL)aSelector;
- (SEL)doubleAction;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3


- (void)setSortDescriptors:(NSArray *)array;
- (NSArray *)sortDescriptors;
    
#endif


- (void)setIndicatorImage:(NSImage *)anImage inTableColumn:(NSTableColumn *)tc;
- (NSImage *)indicatorImageInTableColumn:(NSTableColumn *)tc;


- (void)setHighlightedTableColumn:(NSTableColumn *)tc;
- (NSTableColumn *)highlightedTableColumn;



- (void)setVerticalMotionCanBeginDrag:(BOOL)flag;
- (BOOL)verticalMotionCanBeginDrag;

- (NSImage*)dragImageForRows:(NSArray*)dragRows event:(NSEvent*)dragEvent dragImageOffset:(NSPointPointer)dragImageOffset;
    
- (void)setDropRow:(int)row dropOperation:(NSTableViewDropOperation)op;
    

- (void)setAllowsMultipleSelection:(BOOL)flag;
- (BOOL)allowsMultipleSelection;
- (void)setAllowsEmptySelection:(BOOL)flag;
- (BOOL)allowsEmptySelection;
- (void)setAllowsColumnSelection:(BOOL)flag;
- (BOOL)allowsColumnSelection;
- (void)selectAll:(id)sender;
- (void)deselectAll:(id)sender;

- (void)selectColumn:(int)column byExtendingSelection:(BOOL)extend;
- (void)selectRow:(int)row byExtendingSelection:(BOOL)extend;
- (NSEnumerator *)selectedColumnEnumerator;
- (NSEnumerator *)selectedRowEnumerator;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)selectColumnIndexes:(NSIndexSet *)indexes byExtendingSelection:(BOOL)extend;
        - (void)selectRowIndexes:(NSIndexSet *)indexes byExtendingSelection:(BOOL)extend;
        
- (NSIndexSet *)selectedColumnIndexes;
- (NSIndexSet *)selectedRowIndexes;
#endif

- (void)deselectColumn:(int)column;
- (void)deselectRow:(int)row;
- (int)selectedColumn;
- (int)selectedRow;
- (BOOL)isColumnSelected:(int)row;
- (BOOL)isRowSelected:(int)row;
- (int)numberOfSelectedColumns;
- (int)numberOfSelectedRows;



- (NSRect)rectOfColumn:(int)column;
- (NSRect)rectOfRow:(int)row;
- (NSRange)columnsInRect:(NSRect)rect;
- (NSRange)rowsInRect:(NSRect)rect;
- (int)columnAtPoint:(NSPoint)point;
- (int)rowAtPoint:(NSPoint)point;
- (NSRect)frameOfCellAtColumn:(int)column row:(int)row;



- (BOOL)textShouldBeginEditing:(NSText *)textObject;
- (BOOL)textShouldEndEditing:(NSText *)textObject;
- (void)textDidBeginEditing:(NSNotification *)notification;
- (void)textDidEndEditing:(NSNotification *)notification;
- (void)textDidChange:(NSNotification *)notification;


- (void)setAutosaveName:(NSString *)name;
- (NSString *)autosaveName;
- (void)setAutosaveTableColumns:(BOOL)save;
- (BOOL)autosaveTableColumns;


- (void)editColumn:(int)column row:(int)row withEvent:(NSEvent *)theEvent select:(BOOL)select;
- (void)drawRow:(int)row clipRect:(NSRect)rect;
- (void)highlightSelectionInClipRect:(NSRect)rect;
- (void)drawGridInClipRect:(NSRect)rect;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)drawBackgroundInClipRect:(NSRect)clipRect;
#endif

|#
#| @INTERFACE 
NSObject(NSTableViewDelegate)

- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(int)row;
- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(int)row;
- (BOOL)selectionShouldChangeInTableView:(NSTableView *)aTableView;
- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(int)row;
- (BOOL)tableView:(NSTableView *)tableView shouldSelectTableColumn:(NSTableColumn *)tableColumn;

- (void) tableView:(NSTableView*)tableView mouseDownInHeaderOfTableColumn:(NSTableColumn *)tableColumn;
- (void) tableView:(NSTableView*)tableView didClickTableColumn:(NSTableColumn *)tableColumn;
- (void) tableView:(NSTableView*)tableView didDragTableColumn:(NSTableColumn *)tableColumn;

|#
; 
;  * Notifications
;  
(def-mactype :NSTableViewSelectionDidChangeNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSTableViewColumnDidMoveNotification (find-mactype '(:pointer :NSString)))
;  @"NSOldColumn", @"NSNewColumn"
(def-mactype :NSTableViewColumnDidResizeNotification (find-mactype '(:pointer :NSString)))
;  @"NSTableColumn", @"NSOldWidth"
(def-mactype :NSTableViewSelectionIsChangingNotification (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSObject(NSTableViewNotifications)
- (void)tableViewSelectionDidChange:(NSNotification *)notification;
- (void)tableViewColumnDidMove:(NSNotification *)notification;
- (void)tableViewColumnDidResize:(NSNotification *)notification;
- (void)tableViewSelectionIsChanging:(NSNotification *)notification;
|#
#| @INTERFACE 
NSObject(NSTableDataSource)
- (int)numberOfRowsInTableView:(NSTableView *)tableView;
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row;
- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(int)row;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

- (void)tableView:(NSTableView *)tableView sortDescriptorsDidChange:(NSArray *)oldDescriptors;
    
#endif

- (BOOL)tableView:(NSTableView *)tv writeRows:(NSArray*)rows toPasteboard:(NSPasteboard*)pboard;
    
- (NSDragOperation)tableView:(NSTableView*)tv validateDrop:(id <NSDraggingInfo>)info proposedRow:(int)row proposedDropOperation:(NSTableViewDropOperation)op;
    
- (BOOL)tableView:(NSTableView*)tv acceptDrop:(id <NSDraggingInfo>)info row:(int)row dropOperation:(NSTableViewDropOperation)op;
    
|#

(provide-interface "NSTableView")