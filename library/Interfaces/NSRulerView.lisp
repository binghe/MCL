(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSRulerView.h"
; at Sunday July 2,2006 7:30:58 pm.
; 
;         NSRulerView.h
;         Application Kit
;         Copyright (c) 1994-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSView.h>

(defconstant $NSHorizontalRuler 0)
(defconstant $NSVerticalRuler 1)
(def-mactype :NSRulerOrientation (find-mactype ':SINT32))
#| @INTERFACE 
NSRulerView : NSView {
  
  private
    NSScrollView *_scrollView;
    NSRulerOrientation _orientation;

    NSString *_units;
    float _originOffset;

    float _ruleThickness;
    float _thicknessForMarkers;
    float _thicknessForAccessoryView;

    NSView *_clientView;
    NSMutableArray *_markers;
    NSView *_accessoryView;

        NSDictionary *_cachedHashDict;
    float _cachedDocViewToRulerConversion;

        NSPoint _cachedContentBoundsOrigin;

        NSRulerMarker *_draggingMarker;

    void *_reservedRulerView1;
}



+ (void)registerUnitWithName:(NSString *)unitName abbreviation:(NSString *)abbreviation unitToPointsConversionFactor:(float)conversionFactor stepUpCycle:(NSArray *)stepUpCycle stepDownCycle:(NSArray *)stepDownCycle;



- (id)initWithScrollView:(NSScrollView *)scrollView orientation:(NSRulerOrientation)orientation;
    


- (void)setScrollView:(NSScrollView *)scrollView;
- (NSScrollView *)scrollView;
    
- (void)setOrientation:(NSRulerOrientation)orientation;
- (NSRulerOrientation)orientation;
    



- (float)baselineLocation;
    
- (float)requiredThickness;
    
- (void)setRuleThickness:(float)thickness;
- (float)ruleThickness;
    
- (void)setReservedThicknessForMarkers:(float)thickness;
- (float)reservedThicknessForMarkers;
    
- (void)setReservedThicknessForAccessoryView:(float)thickness;
- (float)reservedThicknessForAccessoryView;
    


- (void)setMeasurementUnits:(NSString *)unitName;
- (NSString *)measurementUnits;
    
- (void)setOriginOffset:(float)offset;
- (float)originOffset;
    


- (void)setClientView:(NSView *)client;
- (NSView *)clientView;

- (void)setMarkers:(NSArray *)markers;
- (void)addMarker:(NSRulerMarker *)marker;
- (void)removeMarker:(NSRulerMarker *)marker;
- (NSArray *)markers;
    
- (BOOL)trackMarker:(NSRulerMarker *)marker withMouseEvent:(NSEvent *)event;
    
- (void)setAccessoryView:(NSView *)accessory;
- (NSView *)accessoryView;
    
- (void)moveRulerlineFromLocation:(float)oldLocation toLocation:(float)newLocation;



- (void)invalidateHashMarks;
    
- (void)drawHashMarksAndLabelsInRect:(NSRect)rect;
    
- (void)drawMarkersInRect:(NSRect)rect;
    


- (BOOL)isFlipped;
    
|#
;  This informal protocol defines the communication between a ruler and its client view during mouse tracking.
#| @INTERFACE 
NSView (NSRulerMarkerClientViewDelegation)

- (BOOL)rulerView:(NSRulerView *)ruler shouldMoveMarker:(NSRulerMarker *)marker;
    
- (float)rulerView:(NSRulerView *)ruler willMoveMarker:(NSRulerMarker *)marker toLocation:(float)location;
    
- (void)rulerView:(NSRulerView *)ruler didMoveMarker:(NSRulerMarker *)marker;
    
- (BOOL)rulerView:(NSRulerView *)ruler shouldRemoveMarker:(NSRulerMarker *)marker;
    
- (void)rulerView:(NSRulerView *)ruler didRemoveMarker:(NSRulerMarker *)marker;
    
- (BOOL)rulerView:(NSRulerView *)ruler shouldAddMarker:(NSRulerMarker *)marker;
    
- (float)rulerView:(NSRulerView *)ruler willAddMarker:(NSRulerMarker *)marker atLocation:(float)location;
    
- (void)rulerView:(NSRulerView *)ruler didAddMarker:(NSRulerMarker *)marker;
    
- (void)rulerView:(NSRulerView *)ruler handleMouseDown:(NSEvent *)event;
    
- (void)rulerView:(NSRulerView *)ruler willSetClientView:(NSView *)newClient;
    
|#

(provide-interface "NSRulerView")