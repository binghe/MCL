(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSScroller.h"
; at Sunday July 2,2006 7:30:59 pm.
; 
; 	NSScroller.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSControl.h>

; #import <AppKit/NSCell.h>
(def-mactype :_NSScrollArrowPosition (find-mactype ':sint32))

(defconstant $NSScrollerArrowsMaxEnd 0)         ;  deprecated 

(defconstant $NSScrollerArrowsMinEnd 1)         ;  deprecated 

(defconstant $NSScrollerArrowsDefaultSetting 0)
(defconstant $NSScrollerArrowsNone 2)
(def-mactype :NSScrollArrowPosition (find-mactype ':SINT32))
(def-mactype :_NSUsableScrollerParts (find-mactype ':sint32))

(defconstant $NSNoScrollerParts 0)
(defconstant $NSOnlyScrollerArrows 1)
(defconstant $NSAllScrollerParts 2)
(def-mactype :NSUsableScrollerParts (find-mactype ':SINT32))
(def-mactype :_NSScrollerPart (find-mactype ':sint32))

(defconstant $NSScrollerNoPart 0)
(defconstant $NSScrollerDecrementPage 1)
(defconstant $NSScrollerKnob 2)
(defconstant $NSScrollerIncrementPage 3)
(defconstant $NSScrollerDecrementLine 4)
(defconstant $NSScrollerIncrementLine 5)
(defconstant $NSScrollerKnobSlot 6)
(def-mactype :NSScrollerPart (find-mactype ':SINT32))
(def-mactype :_NSScrollerArrow (find-mactype ':sint32))

(defconstant $NSScrollerIncrementArrow 0)
(defconstant $NSScrollerDecrementArrow 1)
(def-mactype :NSScrollerArrow (find-mactype ':SINT32))
#| @INTERFACE 
NSScroller : NSControl
{
    
    float               _curValue;
    float               _percent;
    float		_knobSize;
    struct __sFlags2 {
        unsigned int   hitPart:4;
        unsigned int   controlSize:2;
        unsigned int   inMaxEnd:1;
        unsigned int   reserved:25;
    } _sFlags2;
    id                  _target;
    SEL                 _action;
    struct _sFlags {
	unsigned int		isHoriz:1;
        NSScrollArrowPosition	arrowsLoc:2;
        NSUsableScrollerParts	partsUsable:2;
	unsigned int		fine:1;
	unsigned int		needsEnableFlush:1;
	unsigned int		thumbing:1;
	unsigned int		slotDrawn:1;
	unsigned int		knobDrawn:1;
        unsigned int            lit:1;
        unsigned int            knobLit:1;
        unsigned int		reserved:1;
        unsigned int		controlTint:3;
	unsigned int		repeatCount:16;
    } sFlags;
}

+ (float)scrollerWidth;
+ (float)scrollerWidthForControlSize:(NSControlSize)controlSize;

- (void)drawParts;
- (NSRect)rectForPart:(NSScrollerPart)partCode;
- (void)checkSpaceForParts;
- (NSUsableScrollerParts)usableParts;
- (void)setArrowsPosition:(NSScrollArrowPosition)where;
- (NSScrollArrowPosition)arrowsPosition;
- (void)setControlTint:(NSControlTint)controlTint;
- (NSControlTint)controlTint;
- (void)setControlSize:(NSControlSize)controlSize;
- (NSControlSize)controlSize;
- (void)drawArrow:(NSScrollerArrow)whichArrow highlight:(BOOL)flag;
- (void)drawKnob;
- (void)highlight:(BOOL)flag;
- (NSScrollerPart)testPart:(NSPoint)thePoint;
- (void)trackKnob:(NSEvent *)theEvent;
- (void)trackScrollButtons:(NSEvent *)theEvent;
- (NSScrollerPart)hitPart;
- (void)setFloatValue:(float)aFloat knobProportion:(float)percent;
- (float)knobProportion;

|#

(provide-interface "NSScroller")