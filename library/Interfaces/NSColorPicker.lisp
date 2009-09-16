(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSColorPicker.h"
; at Sunday July 2,2006 7:30:44 pm.
; 
; 	NSColorPicker.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSColorPicking.h>
#| @INTERFACE 
NSColorPicker : NSObject <NSColorPickingDefault>
{
    
    id _imageObject;
    NSColorPanel *_colorPanel;
    NSString *_buttonToolTip;
}
- (id)initWithPickerMask:(int)mask colorPanel:(NSColorPanel *)owningColorPanel;
- (NSColorPanel *)colorPanel;
- (NSImage *)provideNewButtonImage;
- (void)insertNewButtonImage:(NSImage *)newButtonImage in:(NSButtonCell *)buttonCell;
- (void)viewSizeChanged:(id)sender;
- (void)attachColorList:(NSColorList *)colorList;
- (void)detachColorList:(NSColorList *)colorList;
- (void)setMode:(int)mode;

|#

(provide-interface "NSColorPicker")