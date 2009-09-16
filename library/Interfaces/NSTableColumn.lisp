(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTableColumn.h"
; at Sunday July 2,2006 7:31:01 pm.
; 
;         NSTableColumn.h
;         Application Kit
;         Copyright (c) 1995-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSTableColumn : NSObject <NSCoding>
{
    
    id		_identifier;
    float	_width;
    float	_minWidth;
    float	_maxWidth;
    NSTableView *_tableView;
    NSCell	*_headerCell;
    NSCell	*_dataCell;
    struct __colFlags {
        unsigned int	isResizable:1;
        unsigned int	isEditable:1;
        unsigned int	resizedPostingDisableCount:8;
        unsigned int    canUseReorderResizeImageCache:1;
        unsigned int	RESERVED:21;
    } _cFlags;
    void 	*_tcAuxiliaryStorage;
}

- (id)initWithIdentifier:(id)identifier;

- (void)setIdentifier:(id)identifier;
- (id)identifier;
- (void)setTableView:(NSTableView *)tableView;
- (NSTableView *)tableView;
- (void)setWidth:(float)width;
- (float)width;
- (void)setMinWidth:(float)minWidth;
- (float)minWidth;
- (void)setMaxWidth:(float)maxWidth;
- (float)maxWidth;

- (void)setHeaderCell:(NSCell *)cell;
- (id)headerCell;
    
- (void)setDataCell:(NSCell *)cell;
- (id)dataCell;
- (id)dataCellForRow:(int)row;
        
- (void)setResizable:(BOOL)flag;
- (BOOL)isResizable;
- (void)setEditable:(BOOL)flag;
- (BOOL)isEditable;
- (void)sizeToFit;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

- (void)setSortDescriptorPrototype:(NSSortDescriptor *)sortDescriptor;
- (NSSortDescriptor *)sortDescriptorPrototype;
    
#endif


|#

(provide-interface "NSTableColumn")