(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSWindowScripting.h"
; at Sunday July 2,2006 7:31:06 pm.
; 
;         NSWindowScripting.h
;         AppKit Framework
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSWindow.h>
#| @INTERFACE 
NSWindow(NSScripting)

- (BOOL)hasCloseBox;
- (BOOL)hasTitleBar;
- (BOOL)isFloatingPanel;
- (BOOL)isMiniaturizable;
- (BOOL)isModalPanel;
- (BOOL)isResizable;
- (BOOL)isZoomable;
- (int)orderedIndex;

- (void)setIsMiniaturized:(BOOL)flag;
- (void)setIsVisible:(BOOL)flag;
- (void)setIsZoomed:(BOOL)flag;
- (void)setOrderedIndex:(int)index;

- (id)handleCloseScriptCommand:(NSCloseCommand *)command;
- (id)handlePrintScriptCommand:(NSScriptCommand *)command;
- (id)handleSaveScriptCommand:(NSScriptCommand *)command;

|#

(provide-interface "NSWindowScripting")