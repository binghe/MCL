(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSScreen.h"
; at Sunday July 2,2006 7:30:58 pm.
; 
; 	NSScreen.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>

; #import <AppKit/NSGraphics.h>

(def-mactype :NSScreenAuxiliaryOpaque (find-mactype ':NSScreenAuxiliary))
#| @INTERFACE 
NSScreen : NSObject {

private
    NSRect _frame;
    NSWindowDepth _depth;
    int _screenNumber;
    NSScreenAuxiliaryOpaque *_auxiliaryStorage;
}

+ (NSArray *)screens;		
+ (NSScreen *)mainScreen;	
+ (NSScreen *)deepestScreen;

- (NSWindowDepth)depth;
- (NSRect)frame;
- (NSRect)visibleFrame;
- (NSDictionary *)deviceDescription;

- (const NSWindowDepth *)supportedWindowDepths; 

|#

(provide-interface "NSScreen")