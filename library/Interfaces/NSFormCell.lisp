(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSFormCell.h"
; at Sunday July 2,2006 7:30:48 pm.
; 
; 	NSFormCell.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSActionCell.h>
#| @INTERFACE 
NSFormCell : NSActionCell
{
    
    float	_titleWidth;
    id		_titleCell;
    float	_titleEndPoint;
}

- (id)initTextCell:(NSString *)aString;

- (float)titleWidth:(NSSize)aSize;
- (float)titleWidth;
- (void)setTitleWidth:(float)width;
- (NSString *)title;
- (void)setTitle:(NSString *)aString;
- (NSFont *)titleFont;
- (void)setTitleFont:(NSFont *)fontObj;
- (NSTextAlignment)titleAlignment;
- (void)setTitleAlignment:(NSTextAlignment)mode;
- (BOOL)isOpaque;

|#
#| @INTERFACE 
NSFormCell(NSKeyboardUI)
- (void)setTitleWithMnemonic:(NSString *)stringWithAmpersand;
|#
#| @INTERFACE 
NSFormCell(NSFormCellAttributedStringMethods)
- (NSAttributedString *)attributedTitle;
- (void)setAttributedTitle:(NSAttributedString *)obj;
|#

(provide-interface "NSFormCell")