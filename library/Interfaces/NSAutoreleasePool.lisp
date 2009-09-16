(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSAutoreleasePool.h"
; at Sunday July 2,2006 7:30:35 pm.
; 	NSAutoreleasePool.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSAutoreleasePool : NSObject {
private
    void	*_token;
    void	*_reserved3;
    void	*_reserved2;
    void	*_reserved;
}

+ (void)addObject:(id)anObject;

- (void)addObject:(id)anObject;

|#

(provide-interface "NSAutoreleasePool")