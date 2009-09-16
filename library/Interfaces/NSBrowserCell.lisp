(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSBrowserCell.h"
; at Sunday July 2,2006 7:30:36 pm.
; 
; 	NSBrowserCell.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSCell.h>
#| @INTERFACE 
NSBrowserCell : NSCell

+ (NSImage *)branchImage;
+ (NSImage *)highlightedBranchImage;

- (NSColor *)highlightColorInView:(NSView *)controlView;

- (BOOL)isLeaf;
- (void)setLeaf:(BOOL)flag;
- (BOOL)isLoaded;
- (void)setLoaded:(BOOL)flag;
- (void)reset;
- (void)set;
- (void)setImage:(NSImage *)image;
- (NSImage *)image;
- (void)setAlternateImage:(NSImage *)newAltImage;
- (NSImage *)alternateImage;

|#

(provide-interface "NSBrowserCell")