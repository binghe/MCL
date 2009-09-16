(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSBox.h"
; at Sunday July 2,2006 7:30:36 pm.
; 
; 	NSBox.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSView.h>
(def-mactype :_NSTitlePosition (find-mactype ':sint32))

(defconstant $NSNoTitle 0)
(defconstant $NSAboveTop 1)
(defconstant $NSAtTop 2)
(defconstant $NSBelowTop 3)
(defconstant $NSAboveBottom 4)
(defconstant $NSAtBottom 5)
(defconstant $NSBelowBottom 6)
(def-mactype :NSTitlePosition (find-mactype ':SINT32))

(defconstant $NSBoxPrimary 0)                   ;  default

(defconstant $NSBoxSecondary 1)
(defconstant $NSBoxSeparator 2)
(defconstant $NSBoxOldStyle 3)                  ;  use border type

(def-mactype :NSBoxType (find-mactype ':SINT32))
#| @INTERFACE 
NSBox : NSView
{
    
    id                  _titleCell;
    id                  _contentView;
    NSSize              _offsets;
    NSRect              _borderRect;
    NSRect              _titleRect;
    struct __bFlags {
	NSBorderType	borderType:2;
	NSTitlePosition	titlePosition:3;
	unsigned int	transparent:1;
        unsigned int	boxType:2;
        unsigned int	needsTile:1;
        unsigned int	_RESERVED:23;
    } _bFlags;
    id			_unused;
}

- (NSBorderType)borderType;
- (NSTitlePosition)titlePosition;
- (void)setBorderType:(NSBorderType)aType;
- (void)setBoxType:(NSBoxType)boxType;
- (NSBoxType)boxType;
- (void)setTitlePosition:(NSTitlePosition)aPosition;
- (NSString *)title;
- (void)setTitle:(NSString *)aString;
- (NSFont *)titleFont;
- (void)setTitleFont:(NSFont *)fontObj;
- (NSRect)borderRect;
- (NSRect)titleRect;
- (id)titleCell;
- (void)sizeToFit;
- (NSSize)contentViewMargins;
- (void)setContentViewMargins:(NSSize)offsetSize;
- (void)setFrameFromContentFrame:(NSRect)contentFrame;
- (id)contentView;
- (void)setContentView:(NSView *)aView;

|#
#| @INTERFACE 
NSBox(NSKeyboardUI)
- (void)setTitleWithMnemonic:(NSString *)stringWithAmpersand;
|#

(provide-interface "NSBox")