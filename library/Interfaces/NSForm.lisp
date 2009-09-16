(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSForm.h"
; at Sunday July 2,2006 7:30:48 pm.
; 
; 	NSForm.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSMatrix.h>
#| @INTERFACE 
 NSForm : NSMatrix

- (int)indexOfSelectedItem;
- (void)setEntryWidth:(float)width;
- (void)setInterlineSpacing:(float)spacing;
- (void)setBordered:(BOOL)flag;
- (void)setBezeled:(BOOL)flag;
- (void)setTitleAlignment:(NSTextAlignment)mode;
- (void)setTextAlignment:(int)mode;
- (void)setTitleFont:(NSFont *)fontObj;
- (void)setTextFont:(NSFont *)fontObj;
- (id)cellAtIndex:(int)index;
- (void)drawCellAtIndex:(int)index;
- (NSFormCell *)addEntry:(NSString *)title;
- (NSFormCell *)insertEntry:(NSString *)title atIndex:(int)index;
- (void)removeEntryAtIndex:(int)index;
- (int)indexOfCellWithTag:(int)aTag;
- (void)selectTextAtIndex:(int)index;
- (void)setFrameSize:(NSSize)newSize;

|#

(provide-interface "NSForm")