(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTimer.h"
; at Sunday July 2,2006 7:31:03 pm.
; 	NSTimer.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSDate.h>
#| @INTERFACE 
NSTimer : NSObject

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (id)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(id)ui repeats:(BOOL)rep;
#endif

- (void)fire;

- (NSDate *)fireDate;
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (void)setFireDate:(NSDate *)date;
#endif

- (NSTimeInterval)timeInterval;

- (void)invalidate;
- (BOOL)isValid;

- (id)userInfo;

|#

(provide-interface "NSTimer")