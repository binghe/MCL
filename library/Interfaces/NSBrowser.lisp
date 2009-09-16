(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSBrowser.h"
; at Sunday July 2,2006 7:30:36 pm.
; 
; 	NSBrowser.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSControl.h>
(defconstant $NSAppKitVersionNumberWithContinuousScrollingBrowser 680.0)
; #define NSAppKitVersionNumberWithContinuousScrollingBrowser 680.0
(defconstant $NSAppKitVersionNumberWithColumnResizingBrowser 685.0)
; #define NSAppKitVersionNumberWithColumnResizingBrowser      685.0
(defrecord __Brflags
; #ifdef __BIG_ENDIAN__
   (allowsMultipleSelection :UInt32)
   (allowsBranchSelection :UInt32)
   (reuseColumns :UInt32)
   (isTitled :UInt32)
   (titleFromPrevious :UInt32)
   (separateColumns :UInt32)
   (delegateImplementsWillDisplayCell :UInt32)
   (delegateSetsTitles :UInt32)
   (delegateSelectsCellsByString :UInt32)
   (delegateDoesNotCreateRowsInMatrix :UInt32)
   (delegateValidatesColumns :UInt32)
   (acceptArrowKeys :UInt32)
   (dontDrawTitles :UInt32)
   (sendActionOnArrowKeys :UInt32)
   (prohibitEmptySel :UInt32)
   (hasHorizontalScroller :UInt32)
   (time :UInt32)
   (allowsIncrementalSearching :UInt32)
   (delegateSelectsCellsByRow :UInt32)
   (disableCompositing :UInt32)
   (refusesFirstResponder :UInt32)
   (acceptsFirstMouse :UInt32)
   (actionNeedsToBeSent :UInt32)
   (usesSmallSizeTitleFont :UInt32)
   (usesSmallScrollers :UInt32)
   (prefersAllColumnUserResizing :UInt32)
   (firstVisibleCalculationDisabled :UInt32)
#| 
; #else
   (firstVisibleCalculationDisabled :UInt32)
   (prefersAllColumnUserResizing :UInt32)
   (usesSmallScrollers :UInt32)
   (usesSmallSizeTitleFont :UInt32)
   (actionNeedsToBeSent :UInt32)
   (acceptsFirstMouse :UInt32)
   (refusesFirstResponder :UInt32)
   (disableCompositing :UInt32)
   (delegateSelectsCellsByRow :UInt32)
   (allowsIncrementalSearching :UInt32)
   (time :UInt32)
   (hasHorizontalScroller :UInt32)
   (prohibitEmptySel :UInt32)
   (sendActionOnArrowKeys :UInt32)
   (dontDrawTitles :UInt32)
   (acceptArrowKeys :UInt32)
   (delegateValidatesColumns :UInt32)
   (delegateDoesNotCreateRowsInMatrix :UInt32)
   (delegateSelectsCellsByString :UInt32)
   (delegateSetsTitles :UInt32)
   (delegateImplementsWillDisplayCell :UInt32)
   (separateColumns :UInt32)
   (titleFromPrevious :UInt32)
   (isTitled :UInt32)
   (reuseColumns :UInt32)
   (allowsBranchSelection :UInt32)
   (allowsMultipleSelection :UInt32)
 |#

; #endif

)
(%define-record :_Brflags (find-record-descriptor :__BRFLAGS))

(def-mactype :NSBrowserAuxiliaryOpaque (find-mactype ':NSBrowserAuxiliary))

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
(def-mactype :_NSBrowserColumnResizingType (find-mactype ':sint32))

(defconstant $NSBrowserNoColumnResizing 0)      ;  Column sizes are fixed and set by developer.     

(defconstant $NSBrowserAutoColumnResizing 1)    ;  No user resizing. Columns grow as window grows.  

(defconstant $NSBrowserUserColumnResizing 2)    ;  Columns fixed as window grows.  User can resize. 

(def-mactype :NSBrowserColumnResizingType (find-mactype ':SINT32))

; #endif

#| @INTERFACE 
NSBrowser : NSControl
{
    
    id                  _target;
    SEL                 _action;
    id                  _delegate;
    SEL                 _doubleAction;
    Class               _matrixClass;
    id                  _cellPrototype;
    NSSize		_columnSize;
    short		_numberOfVisibleColumns;
    short		_minColumnWidth;
    short		_firstVisibleColumn;
    short		_maxVisibleColumns;
    NSMutableArray	*_titles;
    NSString		*_pathSeparator;
    NSMutableArray	*_columns;
    NSBrowserAuxiliaryOpaque *_brAuxiliaryStorage;
    NSString		*_firstColumnTitle;
    NSScroller		*_scroller;
    _Brflags            _brflags;
}

+ (Class)cellClass;

- (void)loadColumnZero;
- (BOOL)isLoaded;

- (void)setDoubleAction:(SEL)aSelector;
- (SEL)doubleAction;
- (void)setMatrixClass:(Class)factoryId;
- (Class)matrixClass;
- (void)setCellClass:(Class)factoryId;
- (void)setCellPrototype:(NSCell *)aCell;
- (id)cellPrototype;
- (void)setDelegate:(id)anObject;
- (id)delegate;
- (void)setReusesColumns:(BOOL)flag;
- (BOOL)reusesColumns;

- (void)setHasHorizontalScroller:(BOOL)flag;
- (BOOL)hasHorizontalScroller;
- (void)setSeparatesColumns:(BOOL)flag;
- (BOOL)separatesColumns;
- (void)setTitled:(BOOL)flag;
- (BOOL)isTitled;
- (void)setMinColumnWidth:(float)columnWidth;
- (float)minColumnWidth;

- (void)setMaxVisibleColumns:(int)columnCount;
- (int)maxVisibleColumns;
    
- (void)setAllowsMultipleSelection:(BOOL)flag;
- (BOOL)allowsMultipleSelection;
- (void)setAllowsBranchSelection:(BOOL)flag;
- (BOOL)allowsBranchSelection;
- (void)setAllowsEmptySelection:(BOOL)flag;
- (BOOL)allowsEmptySelection;
- (void)setTakesTitleFromPreviousColumn:(BOOL)flag;
- (BOOL)takesTitleFromPreviousColumn;

- (void)setAcceptsArrowKeys:(BOOL)flag;
- (BOOL)acceptsArrowKeys;
- (void)setSendsActionOnArrowKeys:(BOOL)flag;
- (BOOL)sendsActionOnArrowKeys;

- (void)setTitle:(NSString *)aString ofColumn:(int)column;
- (NSString *)titleOfColumn:(int)column;
- (void)setPathSeparator:(NSString *)newString;
- (NSString *)pathSeparator;
- (BOOL)setPath:(NSString *)path;
- (NSString *)path;
- (NSString *)pathToColumn:(int)column;
- (int)selectedColumn;
- (id)selectedCell;
- (id)selectedCellInColumn:(int)column;
- (NSArray *)selectedCells;
- (void)selectRow:(int)row inColumn:(int)column;
- (int)selectedRowInColumn:(int)column;

- (void)reloadColumn:(int)column;
- (void)validateVisibleColumns;
- (void)scrollColumnsRightBy:(int)shiftAmount;
- (void)scrollColumnsLeftBy:(int)shiftAmount;
- (void)scrollColumnToVisible:(int)column;

- (void)setLastColumn:(int)column;
- (int)lastColumn;
- (void)addColumn;
- (int)numberOfVisibleColumns;
- (int)firstVisibleColumn;
- (int)lastVisibleColumn;
- (int)columnOfMatrix:(NSMatrix *)matrix;
- (NSMatrix *)matrixInColumn:(int)column;
- (id)loadedCellAtRow:(int)row column:(int)col;
- (void)selectAll:(id)sender;
- (void)tile;
- (void)doClick:(id)sender;
- (void)doDoubleClick:(id)sender;
- (BOOL)sendAction;

- (NSRect)titleFrameOfColumn:(int)column;
- (void)drawTitleOfColumn:(int)column inRect:(NSRect)aRect;
- (float)titleHeight;
- (NSRect)frameOfColumn:(int)column;
- (NSRect)frameOfInsideOfColumn:(int)column;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

- (float)columnWidthForColumnContentWidth:(float)columnContentWidth;
- (float)columnContentWidthForColumnWidth:(float)columnWidth;
    
#endif


#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

- (void)setColumnResizingType:(NSBrowserColumnResizingType)columnResizingType;
- (NSBrowserColumnResizingType)columnResizingType;
    
- (void)setPrefersAllColumnUserResizing:(BOOL)prefersAllColumnResizing;
- (BOOL)prefersAllColumnUserResizing;
    
- (void)setWidth:(float)columnWidth ofColumn:(int)columnIndex;
- (float)widthOfColumn:(int)column;
    
- (void)setColumnsAutosaveName:(NSString *)name;
- (NSString *)columnsAutosaveName;
    
+ (void)removeSavedColumnsWithAutosaveName:(NSString *)name;
        

#endif


- (void)displayColumn:(int)column;

- (void)displayAllColumns;

- (void)scrollViaScroller:(NSScroller *)sender;

- (void)updateScroller;

|#
; 
;  * Notifications
;  
(def-mactype :NSBrowserColumnConfigurationDidChangeNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Object   : browser - the browser whose column sizes need to be persisted.
;  UserInfo : No user info.
#| @INTERFACE 
NSObject(NSBrowserDelegate)

- (int)browser:(NSBrowser *)sender numberOfRowsInColumn:(int)column;
- (void)browser:(NSBrowser *)sender createRowsForColumn:(int)column inMatrix:(NSMatrix *)matrix;

- (void)browser:(NSBrowser *)sender willDisplayCell:(id)cell atRow:(int)row column:(int)column;

- (NSString *)browser:(NSBrowser *)sender titleOfColumn:(int)column;
- (BOOL)browser:(NSBrowser *)sender selectCellWithString:(NSString *)title inColumn:(int)column;
- (BOOL)browser:(NSBrowser *)sender selectRow:(int)row inColumn:(int)column;
- (BOOL)browser:(NSBrowser *)sender isColumnValid:(int)column;
- (void)browserWillScroll:(NSBrowser *)sender;
- (void)browserDidScroll:(NSBrowser *)sender;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3


- (float)browser:(NSBrowser *)browser shouldSizeColumn:(int)columnIndex forUserResize:(BOOL)forUserResize toWidth:(float)suggestedWidth;
        
- (float)browser:(NSBrowser *)browser sizeToFitWidthOfColumn:(int)columnIndex;
        
- (void)browserColumnConfigurationDidChange:(NSNotification *)notification;
        
#endif

|#

(provide-interface "NSBrowser")