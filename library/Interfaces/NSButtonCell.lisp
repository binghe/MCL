(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSButtonCell.h"
; at Sunday July 2,2006 7:30:36 pm.
; 
; 	NSButtonCell.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSActionCell.h>
(def-mactype :_NSButtonType (find-mactype ':sint32))

(defconstant $NSMomentaryLightButton 0)         ;  was NSMomentaryPushButton

(defconstant $NSPushOnPushOffButton 1)
(defconstant $NSToggleButton 2)
(defconstant $NSSwitchButton 3)
(defconstant $NSRadioButton 4)
(defconstant $NSMomentaryChangeButton 5)
(defconstant $NSOnOffButton 6)
(defconstant $NSMomentaryPushInButton 7)        ;  was NSMomentaryLight
;  These constants were accidentally reversed so that NSMomentaryPushButton lit and
;        NSMomentaryLight pushed. These names are now deprecated 

(defconstant $NSMomentaryPushButton 0)
(defconstant $NSMomentaryLight 7)
(def-mactype :NSButtonType (find-mactype ':SINT32))
(def-mactype :_NSBezelStyle (find-mactype ':sint32))

(defconstant $NSRoundedBezelStyle 1)
(defconstant $NSRegularSquareBezelStyle 2)
(defconstant $NSThickSquareBezelStyle 3)
(defconstant $NSThickerSquareBezelStyle 4)
; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

(defconstant $NSDisclosureBezelStyle 5)
; #endif


(defconstant $NSShadowlessSquareBezelStyle 6)
(defconstant $NSCircularBezelStyle 7)
; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

(defconstant $NSTexturedSquareBezelStyle 8)
(defconstant $NSHelpButtonBezelStyle 9)
; #endif

;  this will be obsolete before GM

(defconstant $NSSmallIconButtonBezelStyle 2)
(def-mactype :NSBezelStyle (find-mactype ':SINT32))
(defrecord __BCFlags
; #ifdef __BIG_ENDIAN__
   (pushIn :UInt32)
   (changeContents :UInt32)
   (changeBackground :UInt32)
   (changeGray :UInt32)
   (lightByContents :UInt32)
   (lightByBackground :UInt32)
   (lightByGray :UInt32)
   (drawing :UInt32)
   (bordered :UInt32)
   (imageOverlaps :UInt32)
   (horizontal :UInt32)
   (bottomOrLeft :UInt32)
   (imageAndText :UInt32)
   (imageSizeDiff :UInt32)
   (hasKeyEquivalentInsteadOfImage :UInt32)
   (lastState :UInt32)
   (transparent :UInt32)
   (inset :UInt32)
   (doesNotDimImage :UInt32)
   (gradientType :UInt32)
   (useButtonImageSource :UInt32)
   (alternateMnemonicLocation :UInt32)
#| 
; #else
   (alternateMnemonicLocation :UInt32)
   (useButtonImageSource :UInt32)
   (gradientType :UInt32)
   (doesNotDimImage :UInt32)
   (inset :UInt32)
   (transparent :UInt32)
   (lastState :UInt32)
   (hasKeyEquivalentInsteadOfImage :UInt32)
   (imageSizeDiff :UInt32)
   (imageAndText :UInt32)
   (bottomOrLeft :UInt32)
   (horizontal :UInt32)
   (imageOverlaps :UInt32)
   (bordered :UInt32)
   (drawing :UInt32)
   (lightByGray :UInt32)
   (lightByBackground :UInt32)
   (lightByContents :UInt32)
   (changeGray :UInt32)
   (changeBackground :UInt32)
   (changeContents :UInt32)
   (pushIn :UInt32)
 |#

; #endif

)
(%define-record :_BCFlags (find-record-descriptor :__BCFLAGS))
(defrecord __BCFlags2
; #ifdef __BIG_ENDIAN__
   (keyEquivalentModifierMask :UInt32)
   (reserved :UInt32)
   (bezelStyle2 :UInt32)
   (mouseInside :UInt32)
   (showsBorderOnlyWhileMouseInside :UInt32)
   (bezelStyle :UInt32)
#| 
; #else
   (bezelStyle :UInt32)
   (showsBorderOnlyWhileMouseInside :UInt32)
   (mouseInside :UInt32)
   (bezelStyle2 :UInt32)
   (reserved :UInt32)
   (keyEquivalentModifierMask :UInt32)
 |#

; #endif

)
(%define-record :_BCFlags2 (find-record-descriptor :__BCFLAGS2))
#| @INTERFACE 
NSButtonCell : NSActionCell
{
    
    NSString	       *_altContents;
    id			_sound;
    NSString	       *_keyEquivalent;
    _BCFlags2		_bcFlags2;     unsigned short	_periodicDelay;
    unsigned short	_periodicInterval;
    _BCFlags            _bcFlags;
    NSImage            *_normalImage;
    id                  _alternateImageOrKeyEquivalentFont;
}


- (NSString *)title;
- (void)setTitle:(NSString *)aString;
- (NSString *)alternateTitle;
- (void)setAlternateTitle:(NSString *)aString;
- (NSImage *)alternateImage;
- (void)setAlternateImage:(NSImage *)image;
- (NSCellImagePosition)imagePosition;
- (void)setImagePosition:(NSCellImagePosition)aPosition;
- (int)highlightsBy;
- (void)setHighlightsBy:(int)aType;
- (int)showsStateBy;
- (void)setShowsStateBy:(int)aType;
- (void)setButtonType:(NSButtonType)aType;
- (BOOL)isOpaque;
- (void)setFont:(NSFont *)fontObj;
- (BOOL)isTransparent;
- (void)setTransparent:(BOOL)flag;
- (void)setPeriodicDelay:(float)delay interval:(float)interval;
- (void)getPeriodicDelay:(float *)delay interval:(float *)interval;
- (NSString *)keyEquivalent;
- (void)setKeyEquivalent:(NSString *)aKeyEquivalent;
- (unsigned int)keyEquivalentModifierMask;
- (void)setKeyEquivalentModifierMask:(unsigned int)mask;
- (NSFont *)keyEquivalentFont;
- (void)setKeyEquivalentFont:(NSFont *)fontObj;
- (void)setKeyEquivalentFont:(NSString *)fontName size:(float)fontSize;
- (void)performClick:(id)sender; 
|#
#| @INTERFACE 
NSButtonCell(NSKeyboardUI)
- (void)setTitleWithMnemonic:(NSString *)stringWithAmpersand;
- (void)setAlternateTitleWithMnemonic:(NSString *)stringWithAmpersand;
- (void)setAlternateMnemonicLocation:(unsigned)location;
- (unsigned)alternateMnemonicLocation;
- (NSString *)alternateMnemonic;
|#
;  NSGradientType :
; 
;  A concave gradient is darkest in the top left corner, 
;  a convex gradient is darkest in the bottom right corner.
; 
;  Weak versus strong is how much contrast exists between
;  the colors used in opposite corners
(def-mactype :_NSGradientType (find-mactype ':sint32))

(defconstant $NSGradientNone 0)
(defconstant $NSGradientConcaveWeak 1)
(defconstant $NSGradientConcaveStrong 2)
(defconstant $NSGradientConvexWeak 3)
(defconstant $NSGradientConvexStrong 4)
(def-mactype :NSGradientType (find-mactype ':SINT32))
#| @INTERFACE 
NSButtonCell(NSButtonCellExtensions)
- (NSGradientType)gradientType;
- (void)setGradientType:(NSGradientType)type;

- (void)setImageDimsWhenDisabled:(BOOL)flag;
- (BOOL)imageDimsWhenDisabled;

- (void) setShowsBorderOnlyWhileMouseInside:(BOOL)show;
- (BOOL) showsBorderOnlyWhileMouseInside;

- (void) mouseEntered:(NSEvent*)event;
- (void) mouseExited:(NSEvent*)event;

|#
#| @INTERFACE 
NSButtonCell(NSButtonCellAttributedStringMethods)
- (NSAttributedString *)attributedTitle;
- (void)setAttributedTitle:(NSAttributedString *)obj;
- (NSAttributedString *)attributedAlternateTitle;
- (void)setAttributedAlternateTitle:(NSAttributedString *)obj;
|#
#| @INTERFACE 
NSButtonCell(NSButtonCellBezelStyles)

- (void) setBezelStyle:(NSBezelStyle)bezelStyle;
- (NSBezelStyle)bezelStyle;

|#
#| @INTERFACE 
NSButtonCell (NSButtonCellSoundExtensions)
- (void)setSound:(NSSound *)aSound;
- (NSSound *)sound;
|#

(provide-interface "NSButtonCell")