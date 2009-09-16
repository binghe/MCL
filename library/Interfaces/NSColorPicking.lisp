(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSColorPicking.h"
; at Sunday July 2,2006 7:30:44 pm.
; 
; 	NSColorPicking.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @PROTOCOL 
NSColorPickingDefault


- (id)initWithPickerMask:(int)mask colorPanel:(NSColorPanel *)owningColorPanel;
- (NSImage *)provideNewButtonImage;
- (void)insertNewButtonImage:(NSImage *)newButtonImage in:(NSButtonCell *)buttonCell;
- (void)viewSizeChanged:(id)sender;
- (void)alphaControlAddedOrRemoved:(id)sender;
- (void)attachColorList:(NSColorList *)colorList;
- (void)detachColorList:(NSColorList *)colorList;
- (void)setMode:(int)mode;   

|#
#| @PROTOCOL 
NSColorPickingCustom


- (BOOL)supportsMode:(int)mode;   
- (int)currentMode;
- (NSView *)provideNewView:(BOOL)initialRequest;  - (void)setColor:(NSColor *)newColor;

|#

(provide-interface "NSColorPicking")