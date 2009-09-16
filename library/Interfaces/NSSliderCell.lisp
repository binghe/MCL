(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSSliderCell.h"
; at Sunday July 2,2006 7:31:00 pm.
; 
; 	NSSliderCell.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSActionCell.h>
(def-mactype :_NSTickMarkPosition (find-mactype ':sint32))

(defconstant $NSTickMarkBelow 0)
(defconstant $NSTickMarkAbove 1)
(defconstant $NSTickMarkLeft 1)
(defconstant $NSTickMarkRight 0)
(def-mactype :NSTickMarkPosition (find-mactype ':SINT32))

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

(defconstant $NSLinearSlider 0)
(defconstant $NSCircularSlider 1)
(def-mactype :NSSliderType (find-mactype ':SINT32))

; #endif

#| @INTERFACE 
NSSliderCell : NSActionCell
{
    
    int     _reserved[3];
    int     _numberOfTickMarks;
    double	_altIncValue;
    double	_value;
    double	_maxValue;
    double	_minValue;
    NSRect	_trackRect;
    struct __sliderCellFlags {
        unsigned int weAreVertical:1;
        unsigned int weAreVerticalSet:1;
        unsigned int reserved1:1;
        unsigned int isPressed:1;
        unsigned int allowsTickMarkValuesOnly:1;
        unsigned int tickMarkPosition:1;
        unsigned int sliderType:2;
        unsigned int drawing:1;
        unsigned int reserved2:23;
    } _scFlags;
}


+ (BOOL)prefersTrackingUntilMouseUp;


- (double)minValue;
- (void)setMinValue:(double)aDouble;
- (double)maxValue;
- (void)setMaxValue:(double)aDouble;
- (void)setAltIncrementValue:(double)incValue;
- (double)altIncrementValue;
- (int)isVertical;
- (void)setTitleColor:(NSColor *)newColor;
- (NSColor *)titleColor;
- (void)setTitleFont:(NSFont *)fontObj;
- (NSFont *)titleFont;
- (NSString *)title;
- (void)setTitle:(NSString *)aString;
- (void)setTitleCell:(NSCell *)aCell;
- (id)titleCell;
- (void)setKnobThickness:(float)aFloat;
- (float)knobThickness;
- (NSRect)knobRectFlipped:(BOOL)flipped;
- (void)drawKnob:(NSRect)knobRect;
- (void)drawKnob;
- (void)drawBarInside:(NSRect)aRect flipped:(BOOL)flipped;
- (NSRect)trackRect;	
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void) setSliderType:(NSSliderType)sliderType;
- (NSSliderType)sliderType;
#endif

|#
#| @INTERFACE 
NSSliderCell(NSTickMarkSupport)

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

(provide-interface "NSSliderCell")