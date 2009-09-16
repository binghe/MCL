(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSColorWell.h"
; at Sunday July 2,2006 7:30:44 pm.
; 
; 	NSColorWell.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSControl.h>
#| @INTERFACE 
NSColorWell : NSControl
{
    
    NSColor *_color;
    id _target;
    SEL _action;
    struct __cwFlags {
	unsigned int        isActive:1;
	unsigned int        isBordered:1;
	unsigned int        cantDraw:1;
	unsigned int        isNotContinuous:1;
	unsigned int	    reservedColorWell:28;
    } _cwFlags;
}

- (void)deactivate;
- (void)activate:(BOOL)exclusive;
- (BOOL)isActive;

- (void)drawWellInside:(NSRect)insideRect;

- (BOOL)isBordered;
- (void)setBordered:(BOOL)flag;

- (void)takeColorFrom:(id)sender;
- (void)setColor:(NSColor *)color;
- (NSColor *)color;

|#

(provide-interface "NSColorWell")