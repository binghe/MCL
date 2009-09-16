(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSActionCell.h"
; at Sunday July 2,2006 7:30:34 pm.
; 
;         NSActionCell.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSCell.h>
#| @INTERFACE 
NSActionCell : NSCell
{
    
    int	_tag;        
    id	_target;     
    SEL	_action;     
    id	_controlView;      
}

- (NSView *)controlView;
- (void)setFont:(NSFont *)fontObj;
- (void)setAlignment:(NSTextAlignment)mode;
- (void)setBordered:(BOOL)flag;
- (void)setBezeled:(BOOL)flag;
- (void)setEnabled:(BOOL)flag;
- (void)setFloatingPointFormat:(BOOL)autoRange left:(unsigned int)leftDigits right:(unsigned int)rightDigits;
- (void)setImage:(NSImage *)image;
- (id)target;
- (void)setTarget:(id)anObject;
- (SEL)action;
- (void)setAction:(SEL)aSelector;
- (int)tag;
- (void)setTag:(int)anInt;
- (NSString *)stringValue;
- (int)intValue;
- (float)floatValue;
- (double)doubleValue;
- (void)setObjectValue:(id<NSCopying>)obj;

|#

(provide-interface "NSActionCell")