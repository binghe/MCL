(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSAppleScriptExtensions.h"
; at Sunday July 2,2006 7:30:35 pm.
; 
; 	NSAppleScriptExtensions.h
; 	Application Kit
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSAppleScript.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
#| @INTERFACE 
NSAppleScript(NSExtensions)

- (NSAttributedString *)richTextSource;

|#

; #endif


(provide-interface "NSAppleScriptExtensions")