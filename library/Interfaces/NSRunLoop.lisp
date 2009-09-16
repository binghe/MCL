(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSRunLoop.h"
; at Sunday July 2,2006 7:30:58 pm.
; 	NSRunLoop.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSDate.h>

; #import <CoreFoundation/CFRunLoop.h>
(def-mactype :NSDefaultRunLoopMode (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSRunLoop : NSObject {
private
    void	*_rl;
    void	*_dperf;
    void	*_perft;
    void	*_ports;
    id          _winMessagePort;
    void	*_reserved[6];
}

+ (NSRunLoop *)currentRunLoop;
- (NSString *)currentMode;
- (CFRunLoopRef)getCFRunLoop;

- (void)addTimer:(NSTimer *)timer forMode:(NSString *)mode;

- (void)addPort:(NSPort *)aPort forMode:(NSString *)mode;
- (void)removePort:(NSPort *)aPort forMode:(NSString *)mode;

- (NSDate *)limitDateForMode:(NSString *)mode;
- (void)acceptInputForMode:(NSString *)mode beforeDate:(NSDate *)limitDate;

|#
#| @INTERFACE 
NSRunLoop (NSRunLoopConveniences)

- (void)run; 
- (void)runUntilDate:(NSDate *)limitDate;
- (BOOL)runMode:(NSString *)mode beforeDate:(NSDate *)limitDate;

- (void)configureAsServer;

|#
; *************** 	Delayed perform	 *****************
#| @INTERFACE 
NSObject (NSDelayedPerforming)

- (void)performSelector:(SEL)aSelector withObject:(id)anArgument afterDelay:(NSTimeInterval)delay inModes:(NSArray *)modes;
- (void)performSelector:(SEL)aSelector withObject:(id)anArgument afterDelay:(NSTimeInterval)delay;
+ (void)cancelPreviousPerformRequestsWithTarget:(id)aTarget selector:(SEL)aSelector object:(id)anArgument;
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
+ (void)cancelPreviousPerformRequestsWithTarget:(id)aTarget;
#endif

|#
#| @INTERFACE 
NSRunLoop (NSOrderedPerform)

- (void)performSelector:(SEL)aSelector target:(id)target argument:(id)arg order:(unsigned)order modes:(NSArray *)modes;
- (void)cancelPerformSelector:(SEL)aSelector target:(id)target argument:(id)arg;
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (void)cancelPerformSelectorsWithTarget:(id)target;
#endif

|#

(provide-interface "NSRunLoop")