(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSAffineTransform.h"
; at Sunday July 2,2006 7:30:34 pm.
; 
;         NSAffineTransform.h
;         Application Kit
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>
(defrecord _NSAffineTransformStruct
   (m11 :single-float)
   (m12 :single-float)
   (m21 :single-float)
   (m22 :single-float)
   (tX :single-float)
   (tY :single-float))
(%define-record :NSAffineTransformStruct (find-record-descriptor :_NSAFFINETRANSFORMSTRUCT))
#| @INTERFACE 
NSAffineTransform : NSObject <NSCopying, NSCoding>
{
    private
    NSAffineTransformStruct _transformStruct;
}

+ (NSAffineTransform *)transform;

- (id)initWithTransform:(NSAffineTransform *)transform;

- (void)translateXBy:(float)deltaX yBy:(float)deltaY;

- (void)rotateByDegrees:(float)angle;
- (void)rotateByRadians:(float)angle;

- (void)scaleBy:(float)scale;
- (void)scaleXBy:(float)scaleX yBy:(float)scaleY;

- (void)invert;

- (void)appendTransform:(NSAffineTransform *)transform;
- (void)prependTransform:(NSAffineTransform *)transform;

- (NSPoint)transformPoint:(NSPoint)aPoint;
- (NSSize)transformSize:(NSSize)aSize;
- (NSBezierPath *)transformBezierPath:(NSBezierPath *)aPath;

- (void)set;
- (void)concat;

- (NSAffineTransformStruct)transformStruct;
- (void)setTransformStruct:(NSAffineTransformStruct)transformStruct;

|#

(provide-interface "NSAffineTransform")