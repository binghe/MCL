(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSSegmentedCell.h"
; at Sunday July 2,2006 7:30:59 pm.
; 
; 	NSSegmentedCell.h
; 	Application Kit
; 	Copyright (c) 2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSGeometry.h>

; #import <AppKit/NSActionCell.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

(defconstant $NSSegmentSwitchTrackingSelectOne 0);  only one button can be selected

(defconstant $NSSegmentSwitchTrackingSelectAny 1);  any button can be selected

(defconstant $NSSegmentSwitchTrackingMomentary 2);  only selected while tracking

(def-mactype :NSSegmentSwitchTracking (find-mactype ':SINT32))
#| @INTERFACE 
NSSegmentedCell : NSActionCell {
  private
    NSMutableArray* _segmentItems;
    int             _selectedSegment;
    int             _keySegment;
    NSRect          _lastBounds;
    struct {
	unsigned int trackingMode:3;
	unsigned int trimmedLabels:1;
    unsigned int drawing:1;
    unsigned int reserved:27;
    } _seFlags;
    unsigned int    _reserved1;
    unsigned int    _reserved2;
    unsigned int    _reserved3;
    unsigned int    _reserved4;
}


- (void)setSegmentCount:(int)count;
- (int)segmentCount;


- (void)setSelectedSegment:(int)selectedSegment;
- (int)selectedSegment;


- (void)makeNextSegmentKey;
- (void)makePreviousSegmentKey;

- (void)setTrackingMode:(NSSegmentSwitchTracking)trackingMode;
- (NSSegmentSwitchTracking)trackingMode;




- (void)setWidth:(float)width forSegment:(int)segment;
- (float)widthForSegment:(int)segment;

- (void)setImage:(NSImage *)image forSegment:(int)segment;
- (NSImage *)imageForSegment:(int)segment;

- (void)setLabel:(NSString *)label forSegment:(int)segment;
- (NSString *)labelForSegment:(int)segment;

- (void)setSelected:(BOOL)selected forSegment:(int)segment;
- (BOOL)isSelectedForSegment:(int)segment;

- (void)setEnabled:(BOOL)enabled forSegment:(int)segment;
- (BOOL)isEnabledForSegment:(int)segment;

- (void)setMenu:(NSMenu *)menu forSegment:(int)segment;
- (NSMenu *)menuForSegment:(int)segment;

- (void)setToolTip:(NSString *)toolTip forSegment:(int)segment;
- (NSString *)toolTipForSegment:(int)segment;

- (void)setTag:(int)tag forSegment:(int)segment;
- (int)tagForSegment:(int)segment;


- (void)drawSegment:(int)segment inFrame:(NSRect)frame withView:(NSView *)controlView;

|#

; #endif


(provide-interface "NSSegmentedCell")