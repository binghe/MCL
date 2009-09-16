(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSProgressIndicator.h"
; at Sunday July 2,2006 7:30:57 pm.
; 
;         NSProgressIndicator.h
;         Application Kit
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSView.h>

; #import <AppKit/NSCell.h>

; #import <Foundation/NSDate.h>

(def-mactype :_NSProgressIndicatorThreadInfo (find-mactype ':__NSProgressIndicatorThreadInfo))
; ================================================================================
; 	NSprogressIndicator can support any size (for both determinate and indeterminate).
; 	But to get the best result the height of a progress indicator should be as follow:
; 
;            	    with bezel    without bezel
; 	small		10		8	
; 	regular		14		12	
; 	large		18		16
; 	Aqua		12		12
(def-mactype :_NSProgressIndicatorThickness (find-mactype ':sint32))

(defconstant $NSProgressIndicatorPreferredThickness 14)
(defconstant $NSProgressIndicatorPreferredSmallThickness 10)
(defconstant $NSProgressIndicatorPreferredLargeThickness 18)
(defconstant $NSProgressIndicatorPreferredAquaThickness 12)
(def-mactype :NSProgressIndicatorThickness (find-mactype ':SINT32))

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
(def-mactype :_NSProgressIndicatorStyle (find-mactype ':sint32))

(defconstant $NSProgressIndicatorBarStyle 0)
(defconstant $NSProgressIndicatorSpinningStyle 1)
(def-mactype :NSProgressIndicatorStyle (find-mactype ':SINT32))

; #endif

; ================================================================================
; 	NSProgressIndicator interface
; 
#| @INTERFACE 
NSProgressIndicator : NSView
{
private
    
    BOOL		_isBezeled;		    BOOL		_isIndeterminate;	    BOOL		_threadedAnimation;
    
    double		_minimum;		    double		_maximum;		    
    
    double		_value;			    
    int			_animationIndex;
    NSTimeInterval	_animationDelay;	
    id			_timer;

    id			_animationThreadLock;
    
    id		_cachedImage;
    id		_cachedImageLock;

    volatile struct __progressIndicatorFlags {
        unsigned int isSpinning:1;
        unsigned int isVector:1;
        unsigned int isLocked:1;
        unsigned int controlTint:3;
        unsigned int controlSize:2;
	unsigned int style:1;
        unsigned int _delayedStartup:1;
        unsigned int _orderOutForResize:1;
        unsigned int _lastImageIndex:4;
 	unsigned int hideWhenStopped:1;
        unsigned int RESERVED:16;
    } _progressIndicatorFlags;

    
    void		*_NSProgressIndicatorReserved1;
}

	

- (BOOL)isIndeterminate;				
- (void)setIndeterminate:(BOOL)flag;

- (BOOL)isBezeled;
- (void)setBezeled:(BOOL)flag;

- (NSControlTint)controlTint;
- (void)setControlTint:(NSControlTint)tint;

- (NSControlSize)controlSize;
- (void)setControlSize:(NSControlSize)size;

	

- (double)doubleValue;
- (void)setDoubleValue:(double)doubleValue;

- (void)incrementBy:(double)delta;			
- (double)minValue;
- (double)maxValue;
- (void)setMinValue:(double)newMinimum;
- (void)setMaxValue:(double)newMaximum;

	

- (NSTimeInterval)animationDelay;			- (void)setAnimationDelay:(NSTimeInterval)delay;	
- (BOOL)usesThreadedAnimation;				- (void)setUsesThreadedAnimation:(BOOL)threadedAnimation;

- (void)startAnimation:(id)sender;
- (void)stopAnimation:(id)sender;

- (void)animate:(id)sender;				

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (void) setStyle: (NSProgressIndicatorStyle) style;
- (NSProgressIndicatorStyle) style;

- (void) sizeToFit;

- (BOOL) isDisplayedWhenStopped;
- (void) setDisplayedWhenStopped: (BOOL) isDisplayed;
#endif

|#

(provide-interface "NSProgressIndicator")