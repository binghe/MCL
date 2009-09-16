(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSObjectScripting.h"
; at Sunday July 2,2006 7:30:54 pm.
; 
; 	NSObjectScripting.h
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSObject(NSScripting)

- (NSDictionary *)scriptingProperties;

- (void)setScriptingProperties:(NSDictionary *)properties;

|#

; #endif


(provide-interface "NSObjectScripting")