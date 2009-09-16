(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSHost.h"
; at Sunday July 2,2006 7:30:49 pm.
; 	NSHost.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSHost : NSObject {
private
    NSArray 	*names;
    NSArray 	*addresses;
    void	*reserved;
}

+ (NSHost *)currentHost;
+ (NSHost *)hostWithName:(NSString *)name;
+ (NSHost *)hostWithAddress:(NSString *)address;

+ (void)setHostCacheEnabled:(BOOL)flag;
+ (BOOL)isHostCacheEnabled;
+ (void)flushHostCache;

- (BOOL)isEqualToHost:(NSHost *)aHost;

- (NSString *)name;	- (NSArray *)names;	
- (NSString *)address;	- (NSArray *)addresses;	
|#

(provide-interface "NSHost")