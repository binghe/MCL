(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSDate.h"
; at Sunday July 2,2006 7:30:45 pm.
; 	NSDate.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

(def-mactype :NSTimeInterval (find-mactype ':double-float))
(defconstant $NSTimeIntervalSince1970 9.783072E+8)
; #define NSTimeIntervalSince1970  978307200.0
#| @INTERFACE 
NSDate : NSObject <NSCopying, NSCoding>

- (NSTimeInterval)timeIntervalSinceReferenceDate;

|#
#| @INTERFACE 
NSDate (NSExtendedDate)

- (NSTimeInterval)timeIntervalSinceDate:(NSDate *)anotherDate;
- (NSTimeInterval)timeIntervalSinceNow;
- (NSTimeInterval)timeIntervalSince1970;

- (id)addTimeInterval:(NSTimeInterval)seconds;

- (NSDate *)earlierDate:(NSDate *)anotherDate;
- (NSDate *)laterDate:(NSDate *)anotherDate;
- (NSComparisonResult)compare:(NSDate *)other;

- (NSString *)description;
- (BOOL)isEqualToDate:(NSDate *)otherDate;

+ (NSTimeInterval)timeIntervalSinceReferenceDate;
    
|#
#| @INTERFACE 
NSDate (NSDateCreation)

+ (id)date;
    
+ (id)dateWithTimeIntervalSinceNow:(NSTimeInterval)secs;    
+ (id)dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)secs;
+ (id)dateWithTimeIntervalSince1970:(NSTimeInterval)secs;

+ (id)distantFuture;
+ (id)distantPast;

- (id)init;
- (id)initWithTimeIntervalSinceReferenceDate:(NSTimeInterval)secsToBeAdded;
- (id)initWithTimeInterval:(NSTimeInterval)secsToBeAdded sinceDate:(NSDate *)anotherDate;
- (id)initWithTimeIntervalSinceNow:(NSTimeInterval)secsToBeAddedToNow;

|#

(provide-interface "NSDate")