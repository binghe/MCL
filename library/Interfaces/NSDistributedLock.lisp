(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSDistributedLock.h"
; at Sunday July 2,2006 7:30:46 pm.
; 	NSDistributedLock.h
; 	Copyright (c) 1995-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSDistributedLock : NSObject {
private
    void *_priv;
}

+ (NSDistributedLock *)lockWithPath:(NSString *)path;  

- (id)initWithPath:(NSString *)path;

- (BOOL)tryLock;
- (void)unlock;
- (void)breakLock;
- (NSDate *)lockDate;

|#

(provide-interface "NSDistributedLock")