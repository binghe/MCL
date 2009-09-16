(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSAlert.h"
; at Sunday July 2,2006 7:30:34 pm.
; 
; 	NSAlert.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <AppKit/NSGraphics.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
;  The default alert style is NSAlertWarningStyle.  NSAlertCriticalStyle should be reserved for critical alerts and will cause the icon to be badged with a caution icon.
(def-mactype :NSAlertStyle (find-mactype ':sint32))

(defconstant $NSWarningAlertStyle 0)
(defconstant $NSInformationalAlertStyle 1)
(defconstant $NSCriticalAlertStyle 2)
(def-mactype :NSAlertStyle (find-mactype ':SINT32))
#| @INTERFACE 
NSAlert : NSObject
{
    private
    
    NSTextField *informationField;
    id  first;
    id  second;
    id  third;
    NSArray *buttons;
    NSPanel *panel;
    id  messageField;
    id  imageView;
    NSSize minButtonSize;
    float buttonSpacing;
    float buttonPadding;
    float messagePadding;
    float buttonSpacingMaxX;
    float buttonSpacingY;
    id modalDelegate;
    NSWindow *docWindow;
    SEL didEndSelector;
    SEL didDismissSelector;
    NSImage *unbadgedImage;
    NSSize defaultPanelSize;
    id helpButton;
    id delegate;
    NSAlertStyle alertStyle;
    id helpAnchor;
    BOOL useNSLayout;
    BOOL showsHelp;
    BOOL reserved[2];
    id reserved1;
    id reserved2;
}

+ (NSAlert *)alertWithMessageText:(NSString *)message defaultButton:(NSString *)defaultButton alternateButton:(NSString *)alternateButton otherButton:(NSString *)otherButton informativeTextWithFormat:(NSString *)format, ...;

- (void)setMessageText:(NSString *)messageText;
- (void)setInformativeText:(NSString *)informativeText;

- (NSString *)messageText;
- (NSString *)informativeText;

- (void)setIcon:(NSImage *)icon;
- (NSImage *)icon;

- (NSButton *)addButtonWithTitle:(NSString *)title;
- (NSArray *)buttons;


enum {
	NSAlertFirstButtonReturn	= 1000,
	NSAlertSecondButtonReturn	= 1001,
	NSAlertThirdButtonReturn	= 1002
};



- (void)setShowsHelp:(BOOL)showsHelp;
- (BOOL)showsHelp;

- (void)setHelpAnchor:(NSString *)anchor;
- (NSString *)helpAnchor;

- (void)setAlertStyle:(NSAlertStyle)style;
- (NSAlertStyle)alertStyle;

- (void)setDelegate:(id)delegate;
- (id)delegate;

- (int)runModal;


- (void)beginSheetModalForWindow:(NSWindow *)window modalDelegate:(id)delegate didEndSelector:(SEL)didEndSelector contextInfo:(void *)contextInfo;

- (id)window;

|#
#| @INTERFACE 
NSObject(NSAlertDelegate)
- (BOOL)alertShowHelp:(NSAlert *)alert;
|#

; #endif


(provide-interface "NSAlert")