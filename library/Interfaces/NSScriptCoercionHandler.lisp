(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSScriptCoercionHandler.h"
; at Sunday July 2,2006 7:30:58 pm.
; 	NSScriptCoercionHandler.h
; 	Copyright (c) 1997-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSScriptCoercionHandler : NSObject {
    private
    void *_coercers;
}

+ (NSScriptCoercionHandler *)sharedCoercionHandler;

- (id)coerceValue:(id)value toClass:(Class)toClass;

- (void)registerCoercer:(id)coercer selector:(SEL)selector toConvertFromClass:(Class)fromClass toClass:(Class)toClass;
    
|#

(provide-interface "NSScriptCoercionHandler")