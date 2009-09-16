(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSGraphicsContext.h"
; at Sunday July 2,2006 7:30:49 pm.
; 
;         NSGraphicsContext.h
;         Application Kit
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/AppKitDefines.h>

; #import <Foundation/NSGeometry.h>

; #import <Foundation/NSObject.h>
;  Attributes that can be passed to graphicsContextWithAttributes: method 
(def-mactype :NSGraphicsContextDestinationAttributeName (find-mactype '(:pointer :NSString)))
;  Can be an instance of NSWindow, NSMutableData, or NSURL.
;  Attributes for NSMutableData or NSURL destinations
(def-mactype :NSGraphicsContextRepresentationFormatAttributeName (find-mactype '(:pointer :NSString)))
;  Specifies destination file format
;  Supported file format
(def-mactype :NSGraphicsContextPSFormat (find-mactype '(:pointer :NSString)))
(def-mactype :NSGraphicsContextPDFFormat (find-mactype '(:pointer :NSString)))
(def-mactype :NSImageInterpolation (find-mactype ':sint32))

(defconstant $NSImageInterpolationDefault 0)
(defconstant $NSImageInterpolationNone 1)
(defconstant $NSImageInterpolationLow 2)
(defconstant $NSImageInterpolationHigh 3)
(def-mactype :NSImageInterpolation (find-mactype ':SINT32))
#| @INTERFACE 
NSGraphicsContext : NSObject {
}

+ (NSGraphicsContext *)graphicsContextWithAttributes:(NSDictionary *)attributes;

+ (NSGraphicsContext *)graphicsContextWithWindow:(NSWindow *)window;

+ (NSGraphicsContext *)currentContext;
+ (void)setCurrentContext:(NSGraphicsContext *)context;

+ (BOOL)currentContextDrawingToScreen;

+ (void)saveGraphicsState;
+ (void)restoreGraphicsState;
+ (void)setGraphicsState:(int)gState;

- (NSDictionary *)attributes;

- (BOOL)isDrawingToScreen;

- (void)saveGraphicsState;
- (void)restoreGraphicsState;

- (void)flushGraphics;

- (void *)focusStack;
- (void)setFocusStack:(void *)stack;

- (void *)graphicsPort;

|#
#| @INTERFACE 
NSGraphicsContext(NSGraphicsContext_RenderingOptions)

- (void)setShouldAntialias:(BOOL)antialias;
- (BOOL)shouldAntialias;
- (void)setImageInterpolation:(NSImageInterpolation)interpolation;
- (NSImageInterpolation)imageInterpolation;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2

- (void)setPatternPhase:(NSPoint)phase;
- (NSPoint)patternPhase;

#endif

|#

(provide-interface "NSGraphicsContext")