(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSCachedImageRep.h"
; at Sunday July 2,2006 7:30:37 pm.
; 
; 	NSCachedImageRep.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSImageRep.h>

; #import <AppKit/NSGraphics.h>
#| @INTERFACE 
NSCachedImageRep : NSImageRep {
    
    NSPoint _origin;
    NSWindow *_window;
    void *_cache;
}


- (id)initWithWindow:(NSWindow *)win rect:(NSRect)rect;


- (id)initWithSize:(NSSize)size depth:(NSWindowDepth)depth separate:(BOOL)flag alpha:(BOOL)alpha;

- (NSWindow *)window;
- (NSRect)rect;

|#

(provide-interface "NSCachedImageRep")