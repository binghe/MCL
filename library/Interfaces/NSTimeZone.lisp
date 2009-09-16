(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTimeZone.h"
; at Sunday July 2,2006 7:31:03 pm.
; 	NSTimeZone.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSTimeZone : NSObject <NSCopying, NSCoding>

- (NSString *)name;
- (NSData *)data;

- (int)secondsFromGMTForDate:(NSDate *)aDate;
- (NSString *)abbreviationForDate:(NSDate *)aDate;
- (BOOL)isDaylightSavingTimeForDate:(NSDate *)aDate;

|#
#| @INTERFACE 
NSTimeZone (NSExtendedTimeZone)

+ (NSTimeZone *)systemTimeZone;
+ (void)resetSystemTimeZone;

+ (NSTimeZone *)defaultTimeZone;
+ (void)setDefaultTimeZone:(NSTimeZone *)aTimeZone;

+ (NSTimeZone *)localTimeZone;

+ (NSArray *)knownTimeZoneNames;

+ (NSDictionary *)abbreviationDictionary;

- (int)secondsFromGMT;
- (NSString *)abbreviation;
- (BOOL)isDaylightSavingTime;

- (NSString *)description;

- (BOOL)isEqualToTimeZone:(NSTimeZone *)aTimeZone;

|#
#| @INTERFACE 
NSTimeZone (NSTimeZoneCreation)


+ (id)timeZoneWithName:(NSString *)tzName;
+ (id)timeZoneWithName:(NSString *)tzName data:(NSData *)aData;

- (id)initWithName:(NSString *)tzName;
- (id)initWithName:(NSString *)tzName data:(NSData *)aData;

+ (id)timeZoneForSecondsFromGMT:(int)seconds;

+ (id)timeZoneWithAbbreviation:(NSString *)abbreviation;

|#

(provide-interface "NSTimeZone")