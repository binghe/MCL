(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSStringDrawing.h"
; at Sunday July 2,2006 7:31:01 pm.
; 
;         NSStringDrawing.h
;         Copyright (c) 1994-2003, Apple Computer, Inc.  All rights reserved.
; 
;         Methods to deal with NSString drawing, measuring
;    
; 

; #import <Foundation/NSString.h>

; #import <AppKit/NSAttributedString.h>
#| @INTERFACE 
NSString(NSStringDrawing)

- (NSSize)sizeWithAttributes:(NSDictionary *)attrs;
- (void)drawAtPoint:(NSPoint)point withAttributes:(NSDictionary *)attrs;
- (void)drawInRect:(NSRect)rect withAttributes:(NSDictionary *)attrs;

|#
#| @INTERFACE 
NSAttributedString(NSStringDrawing)

- (NSSize)size;
- (void)drawAtPoint:(NSPoint)point;
- (void)drawInRect:(NSRect)rect;

|#

(provide-interface "NSStringDrawing")