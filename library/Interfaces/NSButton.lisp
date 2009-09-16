(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSButton.h"
; at Sunday July 2,2006 7:30:36 pm.
; 
; 	NSButton.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSControl.h>

; #import <AppKit/NSButtonCell.h>
#| @INTERFACE 
NSButton : NSControl

- (NSString *)title;
- (void)setTitle:(NSString *)aString;
- (NSString *)alternateTitle;
- (void)setAlternateTitle:(NSString *)aString;
- (NSImage *)image;
- (void)setImage:(NSImage *)image;
- (NSImage *)alternateImage;
- (void)setAlternateImage:(NSImage *)image;
- (NSCellImagePosition)imagePosition;
- (void)setImagePosition:(NSCellImagePosition)aPosition;
- (void)setButtonType:(NSButtonType)aType;
- (int)state;
- (void)setState:(int)value;
- (BOOL)isBordered;
- (void)setBordered:(BOOL)flag;
- (BOOL)isTransparent;
- (void)setTransparent:(BOOL)flag;
- (void)setPeriodicDelay:(float)delay interval:(float)interval;
- (void)getPeriodicDelay:(float *)delay interval:(float *)interval;
- (NSString *)keyEquivalent;
- (void)setKeyEquivalent:(NSString *)charCode;
- (unsigned int)keyEquivalentModifierMask;
- (void)setKeyEquivalentModifierMask:(unsigned int)mask;
- (void)highlight:(BOOL)flag;
- (BOOL)performKeyEquivalent:(NSEvent *)key;

|#
#| @INTERFACE 
NSButton(NSKeyboardUI)
- (void)setTitleWithMnemonic:(NSString *)stringWithAmpersand;
|#
#| @INTERFACE 
NSButton(NSButtonAttributedStringMethods)
- (NSAttributedString *)attributedTitle;
- (void)setAttributedTitle:(NSAttributedString *)aString;
- (NSAttributedString *)attributedAlternateTitle;
- (void)setAttributedAlternateTitle:(NSAttributedString *)obj;
|#
#| @INTERFACE 
NSButton(NSButtonBezelStyles)
- (void) setBezelStyle:(NSBezelStyle)bezelStyle;
- (NSBezelStyle)bezelStyle;
|#
#| @INTERFACE 
NSButton(NSButtonMixedState)
- (void)setAllowsMixedState:(BOOL)flag;
- (BOOL)allowsMixedState;
- (void)setNextState;
|#
#| @INTERFACE 
NSButton(NSButtonBorder)
- (void) setShowsBorderOnlyWhileMouseInside:(BOOL)show;
- (BOOL) showsBorderOnlyWhileMouseInside;
|#
#| @INTERFACE 
NSButton (NSButtonSoundExtensions)
- (void)setSound:(NSSound *)aSound;
- (NSSound *)sound;
|#

(provide-interface "NSButton")