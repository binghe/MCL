(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSProxy.h"
; at Sunday July 2,2006 7:30:57 pm.
; 	NSProxy.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSProxy <NSObject> {
    Class	isa;
}

+ (id)alloc;
+ (id)allocWithZone:(NSZone *)zone;
+ (Class)class;

- (void)forwardInvocation:(NSInvocation *)invocation;
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel;
- (void)dealloc;
- (NSString *)description;
+ (BOOL)respondsToSelector:(SEL)aSelector;

|#

(provide-interface "NSProxy")