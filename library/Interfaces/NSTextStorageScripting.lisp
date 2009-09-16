(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTextStorageScripting.h"
; at Sunday July 2,2006 7:31:02 pm.
; 
;         NSTextStorageScripting.h
;         AppKit Framework
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSTextStorage.h>
#| @INTERFACE 
NSTextStorage (Scripting)

- (NSArray *)attributeRuns;
- (void)setAttributeRuns:(NSArray *)attributeRuns;

- (NSArray *)paragraphs;
- (void)setParagraphs:(NSArray *)paragraphs;

- (NSArray *)words;
- (void)setWords:(NSArray *)words;

- (NSArray *)characters;
- (void)setCharacters:(NSArray *)characters;

- (NSFont *)font;
- (void)setFont:(NSFont *)font;

- (NSColor *)foregroundColor;
- (void)setForegroundColor:(NSColor *)color;

|#

(provide-interface "NSTextStorageScripting")