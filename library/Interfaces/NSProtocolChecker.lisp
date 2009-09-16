(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSProtocolChecker.h"
; at Sunday July 2,2006 7:30:57 pm.
; 	NSProtocolChecker.h
; 	Copyright (c) 1995-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSProxy.h>

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSProtocolChecker : NSProxy

- (Protocol *)protocol;
- (NSObject *)target;

|#
#| @INTERFACE 
NSProtocolChecker (NSProtocolCheckerCreation)

+ (id)protocolCheckerWithTarget:(NSObject *)anObject protocol:(Protocol *)aProtocol;
- (id)initWithTarget:(NSObject *)anObject protocol:(Protocol *)aProtocol;

|#

(provide-interface "NSProtocolChecker")