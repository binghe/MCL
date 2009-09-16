(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSGeometry.h"
; at Sunday July 2,2006 7:30:48 pm.
; 	NSGeometry.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSValue.h>

; #import <Foundation/NSCoder.h>
(defrecord _NSPoint
   (x :single-float)
   (y :single-float)
)
(%define-record :NSPoint (find-record-descriptor :_NSPOINT))

(def-mactype :NSPointPointer (find-mactype '(:pointer :_NSPOINT)))

(def-mactype :NSPointArray (find-mactype '(:pointer :_NSPOINT)))
(defrecord _NSSize
   (width :single-float)
                                                ;  should never be negative 
   (height :single-float)
                                                ;  should never be negative 
)
(%define-record :NSSize (find-record-descriptor :_NSSIZE))

(def-mactype :NSSizePointer (find-mactype '(:pointer :_NSSIZE)))

(def-mactype :NSSizeArray (find-mactype '(:pointer :_NSSIZE)))
(defrecord _NSRect
   (origin :_NSPOINT)
   (size :_NSSIZE)
)
(%define-record :NSRect (find-record-descriptor :_NSRECT))

(def-mactype :NSRectPointer (find-mactype '(:pointer :_NSRECT)))

(def-mactype :NSRectArray (find-mactype '(:pointer :_NSRECT)))
(def-mactype :_NSRectEdge (find-mactype ':sint32))

(defconstant $NSMinXEdge 0)
(defconstant $NSMinYEdge 1)
(defconstant $NSMaxXEdge 2)
(defconstant $NSMaxYEdge 3)
(def-mactype :NSRectEdge (find-mactype ':SINT32))
(%define-record :NSZeroPoint (find-record-descriptor ':NSPoint))
(%define-record :NSZeroSize (find-record-descriptor ':NSSize))
(%define-record :NSZeroRect (find-record-descriptor ':NSRect))
#|
NSPoint NSMakePoint(float x, float y) {
    NSPoint p;
    p.x = x;
    p.y = y;
    return p;
|#
#|
NSSize NSMakeSize(float w, float h) {
    NSSize s;
    s.width = w;
    s.height = h;
    return s;
|#
#|
NSRect NSMakeRect(float x, float y, float w, float h) {
    NSRect r;
    r.origin.x = x;
    r.origin.y = y;
    r.size.width = w;
    r.size.height = h;
    return r;
|#
#|
float NSMaxX(NSRect aRect) {
    return (aRect.origin.x + aRect.size.width);
|#
#|
float NSMaxY(NSRect aRect) {
    return (aRect.origin.y + aRect.size.height);
|#
#|
float NSMidX(NSRect aRect) {
    return (aRect.origin.x + aRect.size.width / 2.0);
|#
#|
float NSMidY(NSRect aRect) {
    return (aRect.origin.y + aRect.size.height / 2.0);
|#
#|
float NSMinX(NSRect aRect) {
    return (aRect.origin.x);
|#
#|
float NSMinY(NSRect aRect) {
    return (aRect.origin.y);
|#
#|
float NSWidth(NSRect aRect) {
    return (aRect.size.width);
|#
#|
float NSHeight(NSRect aRect) {
    return (aRect.size.height);
|#

(deftrap-inline "_NSEqualPoints" 
   ((X :single-float)
    (Y :single-float)
    (X :single-float)
    (Y :single-float)
   )
   :Boolean
() )

(deftrap-inline "_NSEqualSizes" 
   ((width :single-float)
    (height :single-float)
    (width :single-float)
    (height :single-float)
   )
   :Boolean
() )

(deftrap-inline "_NSEqualRects" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   :Boolean
() )

(deftrap-inline "_NSIsEmptyRect" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   :Boolean
() )

(deftrap-inline "_NSInsetRect" 
   ((returnArg (:pointer :_NSRECT))
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
    (dX :single-float)
    (dY :single-float)
   )
   nil
() )

(deftrap-inline "_NSIntegralRect" 
   ((returnArg (:pointer :_NSRECT))
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSUnionRect" 
   ((returnArg (:pointer :_NSRECT))
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSIntersectionRect" 
   ((returnArg (:pointer :_NSRECT))
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   nil
() )

(deftrap-inline "_NSOffsetRect" 
   ((returnArg (:pointer :_NSRECT))
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
    (dX :single-float)
    (dY :single-float)
   )
   nil
() )

(deftrap-inline "_NSDivideRect" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
    (slice (:pointer :NSRect))
    (rem (:pointer :NSRect))
    (amount :single-float)
    (edge :SInt32)
   )
   nil
() )

(deftrap-inline "_NSPointInRect" 
   ((X :single-float)
    (Y :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   :Boolean
() )

(deftrap-inline "_NSMouseInRect" 
   ((X :single-float)
    (Y :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
    (flipped :Boolean)
   )
   :Boolean
() )

(deftrap-inline "_NSContainsRect" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   :Boolean
() )

(deftrap-inline "_NSIntersectsRect" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
      ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   :Boolean
() )

(deftrap-inline "_NSStringFromPoint" 
   ((X :single-float)
    (Y :single-float)
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSStringFromSize" 
   ((width :single-float)
    (height :single-float)
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSStringFromRect" 
   (  ;  :_nspoint
    (X :single-float)
    (Y :single-float)  ;  :_nssize
    (width :single-float)
    (height :single-float)
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSPointFromString" 
   ((returnArg (:pointer :_NSPOINT))
    (aString (:pointer :NSString))
   )
   nil
() )

(deftrap-inline "_NSSizeFromString" 
   ((returnArg (:pointer :_NSSIZE))
    (aString (:pointer :NSString))
   )
   nil
() )

(deftrap-inline "_NSRectFromString" 
   ((returnArg (:pointer :_NSRECT))
    (aString (:pointer :NSString))
   )
   nil
() )
#| @INTERFACE 
NSValue (NSValueGeometryExtensions)

+ (NSValue *)valueWithPoint:(NSPoint)point;
+ (NSValue *)valueWithSize:(NSSize)size;
+ (NSValue *)valueWithRect:(NSRect)rect;

- (NSPoint)pointValue;
- (NSSize)sizeValue;
- (NSRect)rectValue;

|#
#| @INTERFACE 
NSCoder (NSGeometryCoding)

- (void)encodePoint:(NSPoint)point;
- (NSPoint)decodePoint;

- (void)encodeSize:(NSSize)size;
- (NSSize)decodeSize;

- (void)encodeRect:(NSRect)rect;
- (NSRect)decodeRect;

|#

(provide-interface "NSGeometry")