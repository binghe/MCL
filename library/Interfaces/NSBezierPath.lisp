(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSBezierPath.h"
; at Sunday July 2,2006 7:30:35 pm.
; 
;         NSBezierPath.h
;         Application Kit
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>

; #import <AppKit/NSFont.h>

(defconstant $NSButtLineCapStyle 0)
(defconstant $NSRoundLineCapStyle 1)
(defconstant $NSSquareLineCapStyle 2)
(def-mactype :NSLineCapStyle (find-mactype ':SINT32))

(defconstant $NSMiterLineJoinStyle 0)
(defconstant $NSRoundLineJoinStyle 1)
(defconstant $NSBevelLineJoinStyle 2)
(def-mactype :NSLineJoinStyle (find-mactype ':SINT32))

(defconstant $NSNonZeroWindingRule 0)
(defconstant $NSEvenOddWindingRule 1)
(def-mactype :NSWindingRule (find-mactype ':SINT32))

(defconstant $NSMoveToBezierPathElement 0)
(defconstant $NSLineToBezierPathElement 1)
(defconstant $NSCurveToBezierPathElement 2)
(defconstant $NSClosePathBezierPathElement 3)
(def-mactype :NSBezierPathElement (find-mactype ':SINT32))
#| @INTERFACE 
NSBezierPath : NSObject <NSCopying, NSCoding>
{
    private
    int _state;
    int _segmentCount;
    int _segmentMax;
    struct PATHSEGMENT *_head;
    int _lastSubpathIndex;
    int _elementCount;
    float _lineWidth;
    NSRect _bounds;
    NSRect _controlPointBounds;
    unsigned char _flags;
    float _miterLimit;
    float _flatness;
    float *_dashedLinePattern;
    unsigned int _dashedLineCount;
    float _dashedLinePhase;
}


+ (NSBezierPath *)bezierPath;
+ (NSBezierPath *)bezierPathWithRect:(NSRect)rect;
+ (NSBezierPath *)bezierPathWithOvalInRect:(NSRect)rect;


+ (void)fillRect:(NSRect)rect;
+ (void)strokeRect:(NSRect)rect;
+ (void)clipRect:(NSRect)rect;
+ (void)strokeLineFromPoint:(NSPoint)point1 toPoint:(NSPoint)point2;
+ (void)drawPackedGlyphs:(const char *)packedGlyphs atPoint:(NSPoint)point;


+ (void)setDefaultMiterLimit:(float)limit;
+ (float)defaultMiterLimit;
+ (void)setDefaultFlatness:(float)flatness;
+ (float)defaultFlatness;

+ (void)setDefaultWindingRule:(NSWindingRule)windingRule;
+ (NSWindingRule)defaultWindingRule;
+ (void)setDefaultLineCapStyle:(NSLineCapStyle)lineCapStyle;
+ (NSLineCapStyle)defaultLineCapStyle;
+ (void)setDefaultLineJoinStyle:(NSLineJoinStyle)lineJoinStyle;
+ (NSLineJoinStyle)defaultLineJoinStyle;
+ (void)setDefaultLineWidth:(float)lineWidth;
+ (float)defaultLineWidth;


- (void)moveToPoint:(NSPoint)point;
- (void)lineToPoint:(NSPoint)point;
- (void)curveToPoint:(NSPoint)endPoint
       controlPoint1:(NSPoint)controlPoint1
       controlPoint2:(NSPoint)controlPoint2;
- (void)closePath;

- (void)removeAllPoints;


- (void)relativeMoveToPoint:(NSPoint)point;
- (void)relativeLineToPoint:(NSPoint)point;
- (void)relativeCurveToPoint:(NSPoint)endPoint
	       controlPoint1:(NSPoint)controlPoint1
	       controlPoint2:(NSPoint)controlPoint2;


- (float)lineWidth;
- (void)setLineWidth:(float)lineWidth;
- (NSLineCapStyle)lineCapStyle;
- (void)setLineCapStyle:(NSLineCapStyle)lineCapStyle;
- (NSLineJoinStyle)lineJoinStyle;
- (void)setLineJoinStyle:(NSLineJoinStyle)lineJoinStyle;
- (NSWindingRule)windingRule;
- (void)setWindingRule:(NSWindingRule)windingRule;
- (float)miterLimit;
- (void)setMiterLimit:(float)miterLimit;
- (float)flatness;
- (void)setFlatness:(float)flatness;
- (void)getLineDash:(float *)pattern count:(int *)count phase:(float *)phase;
- (void)setLineDash:(const float *)pattern count:(int)count phase:(float)phase;


- (void)stroke;
- (void)fill;
- (void)addClip;
- (void)setClip;


- (NSBezierPath *)bezierPathByFlatteningPath;
- (NSBezierPath *)bezierPathByReversingPath;


- (void)transformUsingAffineTransform:(NSAffineTransform *)transform;


- (BOOL)isEmpty;
- (NSPoint)currentPoint;
- (NSRect)controlPointBounds;
- (NSRect)bounds;


- (int)elementCount;

- (NSBezierPathElement)elementAtIndex:(int)index
		     associatedPoints:(NSPointArray)points;
- (NSBezierPathElement)elementAtIndex:(int)index;
- (void)setAssociatedPoints:(NSPointArray)points atIndex:(int)index;


- (void)appendBezierPath:(NSBezierPath *)path;
- (void)appendBezierPathWithRect:(NSRect)rect;
- (void)appendBezierPathWithPoints:(NSPointArray)points count:(int)count;
- (void)appendBezierPathWithOvalInRect:(NSRect)rect;
- (void)appendBezierPathWithArcWithCenter:(NSPoint)center radius:(float)radius
			       startAngle:(float)startAngle
				 endAngle:(float)endAngle
				clockwise:(BOOL)clockwise;
- (void)appendBezierPathWithArcWithCenter:(NSPoint)center radius:(float)radius
			       startAngle:(float)startAngle
				 endAngle:(float)endAngle;
- (void)appendBezierPathWithArcFromPoint:(NSPoint)point1
				 toPoint:(NSPoint)point2
				  radius:(float)radius;
- (void)appendBezierPathWithGlyph:(NSGlyph)glyph inFont:(NSFont *)font;
- (void)appendBezierPathWithGlyphs:(NSGlyph *)glyphs count:(int)count
			    inFont:(NSFont *)font;
- (void)appendBezierPathWithPackedGlyphs:(const char *)packedGlyphs;

- (BOOL)containsPoint:(NSPoint)point;

- (BOOL)cachesBezierPath;
- (void)setCachesBezierPath:(BOOL)flag;

|#

(provide-interface "NSBezierPath")