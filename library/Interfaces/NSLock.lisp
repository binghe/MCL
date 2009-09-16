(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSLock.h"
; at Sunday July 2,2006 7:30:51 pm.
; 	NSLock.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @PROTOCOL 
NSLocking

- (void)lock;
- (void)unlock;

|#
#| @INTERFACE 
NSLock : NSObject <NSLocking> {
private
    void *_priv;
}

- (BOOL)tryLock;
- (BOOL)lockBeforeDate:(NSDate *)limit;

|#
#| @INTERFACE 
NSConditionLock : NSObject <NSLocking> {
private
    void *_priv;
}

- (id)initWithCondition:(int)condition;

- (int)condition;
- (void)lockWhenCondition:(int)condition;
- (BOOL)tryLock;
- (BOOL)tryLockWhenCondition:(int)condition;
- (void)unlockWithCondition:(int)condition;
- (BOOL)lockBeforeDate:(NSDate *)limit;
- (BOOL)lockWhenCondition:(int)condition beforeDate:(NSDate *)limit;

|#
#| @INTERFACE 
NSRecursiveLock : NSObject <NSLocking> {
private
    void *_priv;
}

- (BOOL)tryLock;
- (BOOL)lockBeforeDate:(NSDate *)limit;

|#

(provide-interface "NSLock")