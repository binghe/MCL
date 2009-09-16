(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSEnumerator.h"
; at Sunday July 2,2006 7:30:46 pm.
; 	NSEnumerator.h
; 	Copyright (c) 1995-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
; ***************	Abstract Enumerator	***************
#| @INTERFACE 
NSEnumerator : NSObject

- (id)nextObject;

|#
#| @INTERFACE 
NSEnumerator (NSExtendedEnumerator)

- (NSArray *)allObjects;

|#

(provide-interface "NSEnumerator")