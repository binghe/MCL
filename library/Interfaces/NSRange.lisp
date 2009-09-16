(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSRange.h"
; at Sunday July 2,2006 7:30:57 pm.
; 	NSRange.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSValue.h>
(defrecord _NSRange
   (location :UInt32)
   (length :UInt32)
)
(%define-record :NSRange (find-record-descriptor :_NSRANGE))

(def-mactype :NSRangePointer (find-mactype '(:pointer :_NSRANGE)))
#|
NSRange NSMakeRange(unsigned int loc, unsigned int len) {
    NSRange r;
    r.location = loc;
    r.length = len;
    return r;
|#
#|
unsigned int NSMaxRange(NSRange range) {
    return (range.location + range.length);
|#
#|
BOOL NSLocationInRange(unsigned int loc, NSRange range) {
    return (loc - range.location < range.length);
|#
#|
BOOL NSEqualRanges(NSRange range1, NSRange range2) {
    return (range1.location == range2.location && range1.length == range2.length);
|#

(deftrap-inline "_NSUnionRange" 
   ((returnArg (:pointer :_NSRANGE))
    (location :UInt32)
    (length :UInt32)
    (location :UInt32)
    (length :UInt32)
   )
   nil
() )

(deftrap-inline "_NSIntersectionRange" 
   ((returnArg (:pointer :_NSRANGE))
    (location :UInt32)
    (length :UInt32)
    (location :UInt32)
    (length :UInt32)
   )
   nil
() )

(deftrap-inline "_NSStringFromRange" 
   ((location :UInt32)
    (length :UInt32)
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSRangeFromString" 
   ((returnArg (:pointer :_NSRANGE))
    (aString (:pointer :NSString))
   )
   nil
() )
#| @INTERFACE 
NSValue (NSValueRangeExtensions)

+ (NSValue *)valueWithRange:(NSRange)range;
- (NSRange)rangeValue;

|#

(provide-interface "NSRange")