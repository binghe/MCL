(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSMethodSignature.h"
; at Sunday July 2,2006 7:30:53 pm.
; 	NSMethodSignature.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSMethodSignature : NSObject {
    private
    const char	*_types;
    int		_nargs;
    unsigned	_sizeofParams;
    unsigned	_returnValueLength;
    void	*_parmInfoP;
    int		*_fixup;
    void	*_reserved;
}

- (unsigned)numberOfArguments;
- (const char *)getArgumentTypeAtIndex:(unsigned)index;

- (unsigned)frameLength;

- (BOOL)isOneway;

- (const char *)methodReturnType;
- (unsigned)methodReturnLength;

|#

(provide-interface "NSMethodSignature")