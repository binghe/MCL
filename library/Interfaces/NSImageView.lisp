(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSImageView.h"
; at Sunday July 2,2006 7:30:50 pm.
; 
; 	NSImageView.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSControl.h>

; #import <AppKit/NSImageCell.h>
#| @INTERFACE 
NSImageView : NSControl
{
    
    BOOL _editable;
    id _target;                        SEL _action;                   }


- (NSImage *)image;
- (void)setImage:(NSImage *)newImage;

- (NSImageAlignment)imageAlignment;
- (void)setImageAlignment:(NSImageAlignment)newAlign;
- (NSImageScaling)imageScaling;
- (void)setImageScaling:(NSImageScaling)newScaling;
- (NSImageFrameStyle)imageFrameStyle;
- (void)setImageFrameStyle:(NSImageFrameStyle)newStyle;
- (void)setEditable:(BOOL)yn;
- (BOOL)isEditable;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)setAnimates:(BOOL)flag;
- (BOOL)animates;
#endif

|#

(provide-interface "NSImageView")