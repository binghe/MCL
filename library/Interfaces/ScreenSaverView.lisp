(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ScreenSaverView.h"
; at Sunday July 2,2006 7:31:38 pm.
; 
; 	ScreenSaverView.h
; 	ScreenSaver
; 	Copyright (c) 2000-2, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/AppKit.h>

(require-interface "stdlib")

(require-interface "limits")
#| @INTERFACE 
ScreenSaverView : NSView
{
private
    NSTimer *_animationTimer;
    NSTimeInterval _timeInterval;
    BOOL _isPreview;
    void *_reserved1;
    void *_reserved2;
    void *_reserved3;
}

+ (NSBackingStoreType)backingStoreType;
+ (BOOL)performGammaFade;

- (id)initWithFrame:(NSRect)frame;
- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview;

- (NSTimeInterval)animationTimeInterval;
- (void)setAnimationTimeInterval:(NSTimeInterval)timeInterval;

- (void)startAnimation;
- (void)stopAnimation;
- (BOOL)isAnimating;

- (void)drawRect:(NSRect)rect;
- (void)animateOneFrame;

- (BOOL)hasConfigureSheet;
- (NSWindow*)configureSheet;

- (BOOL)isPreview;

|#
#|
 confused about STATIC __inline__ int SSRandomIntBetween #\( int a #\, int b #\) #\{ int range = b - a < 0 ? b - a - 1 #\: b - a + 1 #\; int value = #\( int #\) #\( range * #\( #\( float #\) random #\( #\) / #\( float #\) LONG_MAX #\) #\) #\; return value == range ? a #\: a + value #\;
|#
#|
 confused about STATIC __inline__ float SSRandomFloatBetween #\( float a #\, float b #\) #\{ return a + #\( b - a #\) * #\( #\( float #\) random #\( #\) / #\( float #\) LONG_MAX #\) #\;
|#
#|
 confused about STATIC __inline__ NSPoint SSRandomPointForSizeWithinRect #\( NSSize size #\, NSRect rect #\) #\{ return NSMakePoint #\( floor #\( SSRandomFloatBetween #\( rect.origin.x #\, rect.origin.x + rect.size.width - size.width #\) #\) #\, floor #\( SSRandomFloatBetween #\( rect.origin.y #\, rect.origin.y + rect.size.height - size.height #\) #\) #\) #\;
|#
#|
 confused about STATIC __inline__ NSRect SSCenteredRectInRect #\( NSRect innerRect #\, NSRect outerRect #\) #\{ innerRect.origin.x = floor #\( #\( outerRect.size.width - innerRect.size.width #\) / 2 #\) #\; innerRect.origin.y = floor #\( #\( outerRect.size.height - innerRect.size.height #\) / 2 #\) #\; return innerRect #\;
|#

(provide-interface "ScreenSaverView")