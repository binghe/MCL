(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSMatrix.h"
; at Sunday July 2,2006 7:30:51 pm.
; 
; 	NSMatrix.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSControl.h>
;  Matrix Constants 
(def-mactype :_NSMatrixMode (find-mactype ':sint32))

(defconstant $NSRadioModeMatrix 0)
(defconstant $NSHighlightModeMatrix 1)
(defconstant $NSListModeMatrix 2)
(defconstant $NSTrackModeMatrix 3)
(def-mactype :NSMatrixMode (find-mactype ':SINT32))
(defrecord __MFlags
; #ifdef __BIG_ENDIAN__
   (highlightMode :UInt32)
   (radioMode :UInt32)
   (listMode :UInt32)
   (allowEmptySel :UInt32)
   (autoscroll :UInt32)
   (selectionByRect :UInt32)
   (drawsCellBackground :UInt32)
   (drawsBackground :UInt32)
   (autosizeCells :UInt32)
   (drawingAncestor :UInt32)
   (tabKeyTraversesCells :UInt32)
   (tabKeyTraversesCellsExplicitlySet :UInt32)
   (allowsIncrementalSearching :UInt32)
   (currentlySelectingCell :UInt32)
   (onlySetKeyCell :UInt32)
   (changingSelectionWithKeyboard :UInt32)
   (dontScroll :UInt32)
   (refusesFirstResponder :UInt32)
   (useSimpleTrackingMode :UInt32)
   (checkForSimpleTrackingMode :UInt32)
   (liveResizeImageCacheingEnabled :UInt32)
   (hasCachedSubclassIsSafeForLiveResize :UInt32)
   (subclassIsSafeForLiveResize :UInt32)
   (tmpAllowNonVisibleCellsToBecomeFirstResponder :UInt32)
   (needsRedrawBeforeFirstLiveResizeCache :UInt32)
   (reservedMatrix :UInt32)
#| 
; #else
   (reservedMatrix :UInt32)
   (needsRedrawBeforeFirstLiveResizeCache :UInt32)
   (tmpAllowNonVisibleCellsToBecomeFirstResponder :UInt32)
   (subclassIsSafeForLiveResize :UInt32)
   (hasCachedSubclassIsSafeForLiveResize :UInt32)
   (liveResizeImageCacheingEnabled :UInt32)
   (checkForSimpleTrackingMode :UInt32)
   (useSimpleTrackingMode :UInt32)
   (refusesFirstResponder :UInt32)
   (dontScroll :UInt32)
   (changingSelectionWithKeyboard :UInt32)
   (onlySetKeyCell :UInt32)
   (currentlySelectingCell :UInt32)
   (allowsIncrementalSearching :UInt32)
   (tabKeyTraversesCellsExplicitlySet :UInt32)
   (tabKeyTraversesCells :UInt32)
   (drawingAncestor :UInt32)
   (autosizeCells :UInt32)
   (drawsBackground :UInt32)
   (drawsCellBackground :UInt32)
   (selectionByRect :UInt32)
   (autoscroll :UInt32)
   (allowEmptySel :UInt32)
   (listMode :UInt32)
   (radioMode :UInt32)
   (highlightMode :UInt32)
 |#

; #endif

)
(%define-record :_MFlags (find-record-descriptor :__MFLAGS))
#| @INTERFACE 
NSMatrix : NSControl
{
    
    id                  _target;
    SEL                 _action;
    SEL                 _doubleAction;
    SEL                 _errorAction;
    id                  _delegate;
    id                  _selectedCell;
    int                 _selectedRow;
    int                 _selectedCol;
    int                 _numRows;
    int                 _numCols;
    NSSize              _cellSize;
    NSSize              _intercell;
    id                  _font;
    id                  _protoCell;
    id                  _cellClass;
    NSColor             *_backgroundColor;
    void	        *_private;
    NSMutableArray	*_cells;
    _MFlags              _mFlags;
}


- (id)initWithFrame:(NSRect)frameRect;
- (id)initWithFrame:(NSRect)frameRect mode:(int)aMode prototype:(NSCell *)aCell numberOfRows:(int)rowsHigh numberOfColumns:(int)colsWide;
- (id)initWithFrame:(NSRect)frameRect mode:(int)aMode cellClass:(Class)factoryId numberOfRows:(int)rowsHigh numberOfColumns:(int)colsWide;


- (void)setCellClass:(Class)factoryId;
- (Class)cellClass;
- (id)prototype;
- (void)setPrototype:(NSCell *)aCell;
- (NSCell *)makeCellAtRow:(int)row column:(int)col;
- (NSMatrixMode)mode;
- (void)setMode:(NSMatrixMode)aMode;
- (void)setAllowsEmptySelection:(BOOL)flag;
- (BOOL)allowsEmptySelection;
- (void)sendAction:(SEL)aSelector to:(id)anObject forAllCells:(BOOL)flag;
- (NSArray *)cells;
- (void)sortUsingSelector:(SEL)comparator;
- (void)sortUsingFunction:(int (*)(id, id, void *))compare context:(void *)context;
- (id)selectedCell;
- (NSArray *)selectedCells;
- (int)selectedRow;
- (int)selectedColumn;
- (void)setSelectionByRect:(BOOL)flag;
- (BOOL)isSelectionByRect;
- (void)setSelectionFrom:(int)startPos to:(int)endPos anchor:(int)anchorPos highlight:(BOOL)lit;
- (void)deselectSelectedCell;
- (void)deselectAllCells;
- (void)selectCellAtRow:(int)row column:(int)col;
- (void)selectAll:(id)sender;
- (BOOL)selectCellWithTag:(int)anInt;
- (NSSize)cellSize;
- (void)setCellSize:(NSSize)aSize;
- (NSSize)intercellSpacing;
- (void)setIntercellSpacing:(NSSize)aSize;
- (void)setScrollable:(BOOL)flag;
- (void)setBackgroundColor:(NSColor *)color;
- (NSColor *)backgroundColor;
- (void)setCellBackgroundColor:(NSColor *)color;
- (NSColor *)cellBackgroundColor;
- (void)setDrawsCellBackground:(BOOL)flag;
- (BOOL)drawsCellBackground;
- (void)setDrawsBackground:(BOOL)flag;
- (BOOL)drawsBackground;
- (void)setState:(int)value atRow:(int)row column:(int)col;
- (void)getNumberOfRows:(int *)rowCount columns:(int *)colCount;
- (int)numberOfRows;
- (int)numberOfColumns;
- (id)cellAtRow:(int)row column:(int)col;
- (NSRect)cellFrameAtRow:(int)row column:(int)col;
- (BOOL)getRow:(int *)row column:(int *)col ofCell:(NSCell *)aCell;
- (BOOL)getRow:(int *)row column:(int *)col forPoint:(NSPoint)aPoint;
- (void)renewRows:(int)newRows columns:(int)newCols;
- (void)putCell:(NSCell *)newCell atRow:(int)row column:(int)col;
- (void)addRow;
- (void)addRowWithCells:(NSArray *)newCells;
- (void)insertRow:(int)row;
- (void)insertRow:(int)row withCells:(NSArray *)newCells;
- (void)removeRow:(int)row;
- (void)addColumn;
- (void)addColumnWithCells:(NSArray *)newCells;
- (void)insertColumn:(int)column;
- (void)insertColumn:(int)column withCells:(NSArray *)newCells;
- (void)removeColumn:(int)col;
- (id)cellWithTag:(int)anInt;
- (SEL)doubleAction;
- (void)setDoubleAction:(SEL)aSelector;
- (void)setAutosizesCells:(BOOL)flag;
- (BOOL)autosizesCells;
- (void)sizeToCells;
- (void)setValidateSize:(BOOL)flag;
- (void)drawCellAtRow:(int)row column:(int)col;
- (void)highlightCell:(BOOL)flag atRow:(int)row column:(int)col;

- (void)setAutoscroll:(BOOL)flag;
- (BOOL)isAutoscroll;
- (void)scrollCellToVisibleAtRow:(int)row column:(int)col;
- (int)mouseDownFlags;
- (void)mouseDown:(NSEvent *)theEvent;
- (BOOL)performKeyEquivalent:(NSEvent *)theEvent;
- (BOOL)sendAction;
- (void)sendDoubleAction;
- (id)delegate;
- (void)setDelegate:(id)anObject;
- (BOOL)textShouldBeginEditing:(NSText *)textObject;
- (BOOL)textShouldEndEditing:(NSText *)textObject;
- (void)textDidBeginEditing:(NSNotification *)notification;
- (void)textDidEndEditing:(NSNotification *)notification;
- (void)textDidChange:(NSNotification *)notification;
- (void)selectText:(id)sender;
- (id)selectTextAtRow:(int)row column:(int)col;
- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent;
- (void)resetCursorRects;
- (void)setToolTip:(NSString *)toolTipString forCell:(NSCell *)cell;
- (NSString *)toolTipForCell:(NSCell *)cell;
|#
#| @INTERFACE 
NSMatrix(NSKeyboardUI)
- (void)setTabKeyTraversesCells:(BOOL)flag;
- (BOOL)tabKeyTraversesCells;
- (void)setKeyCell:(NSCell *)keyCell;
- (id)keyCell;
|#

(provide-interface "NSMatrix")