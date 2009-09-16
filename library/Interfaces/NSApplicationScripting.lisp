(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSApplicationScripting.h"
; at Sunday July 2,2006 7:30:35 pm.
; 
;         NSApplicationScripting.h
;         AppKit Framework
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSApplication.h>
#| @INTERFACE 
NSApplication(NSScripting)

- (NSArray *)orderedDocuments;

- (NSArray *)orderedWindows;

|#
#| @INTERFACE 
NSObject(NSApplicationScriptingDelegation)

- (BOOL)application:(NSApplication *)sender delegateHandlesKey:(NSString *)key;

|#

(provide-interface "NSApplicationScripting")