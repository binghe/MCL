(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTableHeaderView.h"
; at Sunday July 2,2006 7:31:01 pm.
; 
;         NSTableHeaderView.h
;         Application Kit
;         Copyright (c) 1995-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSView.h>
#| @INTERFACE 
NSTableHeaderView : NSView
{
    
    NSTableView			*_tableView;
    int				_resizedColumn;
    int				_draggedColumn;
    int				_pressedColumn;
    NSImage			*_headerDragImage;
    float			_draggedDistance;
    BOOL			_isColumnResizing;
    BOOL			_showHandCursorFired;
    BOOL			_reserved3;
    BOOL			_reserved4;
    BOOL			_skipDrawingSeparator;
    id				_reserved;
}

- (void)setTableView:(NSTableView *)tableView;
- (NSTableView *)tableView;
- (int)draggedColumn;
- (float)draggedDistance;
- (int)resizedColumn;
- (NSRect)headerRectOfColumn:(int)column;
- (int)columnAtPoint:(NSPoint)point;

|#

(provide-interface "NSTableHeaderView")