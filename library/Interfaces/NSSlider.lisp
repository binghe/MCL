(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSSlider.h"
; at Sunday July 2,2006 7:31:00 pm.
; 
; 	NSSlider.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSControl.h>

; #import <AppKit/NSSliderCell.h>
#| @INTERFACE 
NSSlider : NSControl

- (double)minValue;
- (void)setMinValue:(double)aDouble;
- (double)maxValue;
- (void)setMaxValue:(double)aDouble;
- (void)setAltIncrementValue:(double)incValue;
- (double)altIncrementValue;
- (void)setTitleCell:(NSCell *)aCell;
- (id)titleCell;
- (void)setTitleColor:(NSColor *)newColor;
- (NSColor *)titleColor;
- (void)setTitleFont:(NSFont *)fontObj;
- (NSFont *)titleFont;
- (NSString *)title;
- (void)setTitle:(NSString *)aString;
- (void)setKnobThickness:(float)aFloat;
- (float)knobThickness;
- (void)setImage:(NSImage *)backgroundImage;
- (NSImage *)image;
- (int)isVertical;
- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent;

|#
#| @INTERFACE 
NSSlider(NSTickMarkSupport)

- (void)setNumberOfTickMarks:(int)count;
- (int)numberOfTickMarks;

- (void)setTickMarkPosition:(NSTickMarkPosition)position;
- (NSTickMarkPosition)tickMarkPosition;

- (void)setAllowsTickMarkValuesOnly:(BOOL)yorn;
- (BOOL)allowsTickMarkValuesOnly;

- (double)tickMarkValueAtIndex:(int)index;

- (NSRect)rectOfTickMarkAtIndex:(int)index;

- (int)indexOfTickMarkAtPoint:(NSPoint)point;

- (double)closestTickMarkValueToValue:(double)value;

|#

(provide-interface "NSSlider")