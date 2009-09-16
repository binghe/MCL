(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSColorPanel.h"
; at Sunday July 2,2006 7:30:38 pm.
; 
; 	NSColorPanel.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSPanel.h>

; #import <AppKit/NSApplication.h>

(defconstant $NSGrayModeColorPanel 0)
(defconstant $NSRGBModeColorPanel 1)
(defconstant $NSCMYKModeColorPanel 2)
(defconstant $NSHSBModeColorPanel 3)
(defconstant $NSCustomPaletteModeColorPanel 4)
(defconstant $NSColorListModeColorPanel 5)
(defconstant $NSWheelModeColorPanel 6)
; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2

; #endif


(defconstant $NSCrayonModeColorPanel 7)
; #endif



(defconstant $NSColorPanelGrayModeMask 1)
(defconstant $NSColorPanelRGBModeMask 2)
(defconstant $NSColorPanelCMYKModeMask 4)
(defconstant $NSColorPanelHSBModeMask 8)
(defconstant $NSColorPanelCustomPaletteModeMask 16)
(defconstant $NSColorPanelColorListModeMask 32)
(defconstant $NSColorPanelWheelModeMask 64)
; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2

(defconstant $NSColorPanelCrayonModeMask #x80)
; #endif


(defconstant $NSColorPanelAllModesMask #xFFFF)
#| @INTERFACE 
NSColorPanel : NSPanel
{
    
    id			_colorSwatch;
    id			_reserved1;
    id			_colorWell;
    NSMutableArray     *_pickersWithLoadedViews;
    id			_magnifyButton;
    id			_middleView;
    id			_opacitySlider;
    id			_opacityText;
    id			_opacityView;
    id			_modalButtons;
    id			_pickerView;
    id			_customViewsList;
    id			_customPickerList;
    id			_currViewObject;
    id			_boxAboveSwatch;
    id			_target;
    id			_accessoryView;
    SEL			_action;
    NSSize		_minColorPanelSize;
    NSSize		_maxColorPanelSize;
    NSSize		_reserved2;
    NSSize		_reserved3;
    id			_resizeDimple;
    BOOL		_reserved5;
    BOOL		_reserved6;
    BOOL		_reserved7;
    BOOL		_ignoreConstraints;
    BOOL		_continuous;
    BOOL		_allowColorSetting;
    BOOL		_stillInitializing;
    id			_opacityTextController;
}

+ (NSColorPanel *)sharedColorPanel;
+ (BOOL)sharedColorPanelExists;
+ (BOOL)dragColor:(NSColor *)color withEvent:(NSEvent *)theEvent fromView:(NSView *)sourceView;
+ (void)setPickerMask:(int)mask;
+ (void)setPickerMode:(int)mode;

- (void)setAccessoryView:(NSView *)aView;
- (NSView *)accessoryView;
- (void)setContinuous:(BOOL)flag;
- (BOOL)isContinuous;
- (void)setShowsAlpha:(BOOL)flag;
- (BOOL)showsAlpha;
- (void)setMode:(int)mode;
- (int)mode;
- (void)setColor:(NSColor *)color;
- (NSColor *)color;
- (float)alpha;
- (void)setAction:(SEL)aSelector;
- (void)setTarget:(id)anObject;
- (void)attachColorList:(NSColorList *)colorList;
- (void)detachColorList:(NSColorList *)colorList;
|#
#| @INTERFACE 
NSApplication(NSColorPanel)
- (void)orderFrontColorPanel:(id)sender;
|#
#| @INTERFACE 
NSObject(NSColorPanelResponderMethod)
- (void)changeColor:(id)sender;
|#
;  Notifications 
(def-mactype :NSColorPanelColorDidChangeNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSColorPanel")