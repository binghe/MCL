(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSImageCell.h"
; at Sunday July 2,2006 7:30:50 pm.
; 
; 	NSImageCell.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSCell.h>

(defconstant $NSScaleProportionally 0)          ;  Fit proportionally

(defconstant $NSScaleToFit 1)                   ;  Forced fit (distort if necessary)
;  Don't scale (clip)

(defconstant $NSScaleNone 2)
(def-mactype :NSImageScaling (find-mactype ':SINT32))

(defconstant $NSImageAlignCenter 0)
(defconstant $NSImageAlignTop 1)
(defconstant $NSImageAlignTopLeft 2)
(defconstant $NSImageAlignTopRight 3)
(defconstant $NSImageAlignLeft 4)
(defconstant $NSImageAlignBottom 5)
(defconstant $NSImageAlignBottomLeft 6)
(defconstant $NSImageAlignBottomRight 7)
(defconstant $NSImageAlignRight 8)
(def-mactype :NSImageAlignment (find-mactype ':SINT32))

(defconstant $NSImageFrameNone 0)
(defconstant $NSImageFramePhoto 1)
(defconstant $NSImageFrameGrayBezel 2)
(defconstant $NSImageFrameGroove 3)
(defconstant $NSImageFrameButton 4)
(def-mactype :NSImageFrameStyle (find-mactype ':SINT32))
#| @INTERFACE 
NSImageCell : NSCell <NSCopying, NSCoding>
{
    
    id _controlView;      
    struct __ICFlags {
        unsigned int _unused:22;
        unsigned int _animates:1;
        unsigned int _align:4;
        unsigned int _scale:2;
        unsigned int _style:3;
    } _icFlags;
    struct _NSImageCellAnimationState *_animationState;
    NSImage *_scaledImage;
}

- (NSImageAlignment)imageAlignment;
- (void)setImageAlignment:(NSImageAlignment)newAlign;
- (NSImageScaling)imageScaling;
- (void)setImageScaling:(NSImageScaling)newScaling;
- (NSImageFrameStyle)imageFrameStyle;
- (void)setImageFrameStyle:(NSImageFrameStyle)newStyle;

|#

(provide-interface "NSImageCell")