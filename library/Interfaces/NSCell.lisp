(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSCell.h"
; at Sunday July 2,2006 7:30:37 pm.
; 
; 	NSCell.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>

; #import <AppKit/NSText.h>

(defconstant $NSAnyType 0)
(defconstant $NSIntType 1)
(defconstant $NSPositiveIntType 2)
(defconstant $NSFloatType 3)
(defconstant $NSPositiveFloatType 4)
(defconstant $NSDoubleType 6)
(defconstant $NSPositiveDoubleType 7)
(def-mactype :_NSCellType (find-mactype ':sint32))

(defconstant $NSNullCellType 0)
(defconstant $NSTextCellType 1)
(defconstant $NSImageCellType 2)
(def-mactype :NSCellType (find-mactype ':SINT32))
(def-mactype :_NSCellAttribute (find-mactype ':sint32))

(defconstant $NSCellDisabled 0)
(defconstant $NSCellState 1)
(defconstant $NSPushInCell 2)
(defconstant $NSCellEditable 3)
(defconstant $NSChangeGrayCell 4)
(defconstant $NSCellHighlighted 5)
(defconstant $NSCellLightsByContents 6)
(defconstant $NSCellLightsByGray 7)
(defconstant $NSChangeBackgroundCell 8)
(defconstant $NSCellLightsByBackground 9)
(defconstant $NSCellIsBordered 10)
(defconstant $NSCellHasOverlappingImage 11)
(defconstant $NSCellHasImageHorizontal 12)
(defconstant $NSCellHasImageOnLeftOrBottom 13)
(defconstant $NSCellChangesContents 14)
(defconstant $NSCellIsInsetButton 15)
(defconstant $NSCellAllowsMixedState 16)
(def-mactype :NSCellAttribute (find-mactype ':SINT32))
(def-mactype :_NSCellImagePosition (find-mactype ':sint32))

(defconstant $NSNoImage 0)
(defconstant $NSImageOnly 1)
(defconstant $NSImageLeft 2)
(defconstant $NSImageRight 3)
(defconstant $NSImageBelow 4)
(defconstant $NSImageAbove 5)
(defconstant $NSImageOverlaps 6)
(def-mactype :NSCellImagePosition (find-mactype ':SINT32))
(def-mactype :_NSCellState (find-mactype ':sint32))

(defconstant $NSMixedState -1)
(defconstant $NSOffState 0)
(defconstant $NSOnState 1)
(def-mactype :NSCellStateValue (find-mactype ':SINT32))
;  ButtonCell highlightsBy and showsStateBy mask 

(defconstant $NSNoCellMask 0)
(defconstant $NSContentsCellMask 1)
(defconstant $NSPushInCellMask 2)
(defconstant $NSChangeGrayCellMask 4)
(defconstant $NSChangeBackgroundCellMask 8)
(def-mactype :_NSControlTint (find-mactype ':sint32))

(defconstant $NSDefaultControlTint 0)           ;  system 'default'

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

(defconstant $NSBlueControlTint 1)
(defconstant $NSGraphiteControlTint 6)
; #endif


(defconstant $NSClearControlTint 7)
(def-mactype :NSControlTint (find-mactype ':SINT32))
(def-mactype :_NSControlSize (find-mactype ':sint32))

(defconstant $NSRegularControlSize 0)
; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

(defconstant $NSSmallControlSize 1)
; #endif


(defconstant $NSMiniControlSize 2)
(def-mactype :NSControlSize (find-mactype ':SINT32))
(defrecord __CFlags
   (state :UInt32)
   (highlighted :UInt32)
   (disabled :UInt32)
   (editable :UInt32)
   (type :SInt32)
   (vCentered :UInt32)
   (hCentered :UInt32)
   (bordered :UInt32)
   (bezeled :UInt32)
   (selectable :UInt32)
   (scrollable :UInt32)
   (continuous :UInt32)
   (actOnMouseDown :UInt32)
   (isLeaf :UInt32)
   (invalidObjectValue :UInt32)
   (invalidFont :UInt32)
   (reserved1 :UInt32)
   (actOnMouseDragged :UInt32)
   (isLoaded :UInt32)
   (noWrap :UInt32)
   (dontActOnMouseUp :UInt32)
   (isWhite :UInt32)
   (useUserKeyEquivalent :UInt32)
   (showsFirstResponder :UInt32)
   (focusRingType :UInt32)
   (wasSelectable :UInt32)
   (hasInvalidObject :UInt32)
   (allowsEditingTextAttributes :UInt32)
   (importsGraphics :UInt32)
   (alignment :nstextalignment)
#|
; Warning: type-size: unknown type NSTEXTALIGNMENT
|#
   (retainCountOverMax :UInt32)
   (retainCount :UInt32)
   (refusesFirstResponder :UInt32)
   (needsHighlightedText :UInt32)
   (reserved2 :UInt32)
   (currentlyEditing :UInt32)
   (allowsMixedState :UInt32)
   (inMixedState :UInt32)
   (sendsActionOnEndEditing :UInt32)
   (inSendAction :UInt32)
   (menuWasSet :UInt32)
   (controlTint :UInt32)
   (controlSize :UInt32)
   (branchImageDisabled :UInt32)
   (drawingInClipTip :UInt32)
   (needsHighlightedTextHint :UInt32)
)
(%define-record :_CFlags (find-record-descriptor :__CFLAGS))
#| @INTERFACE 
NSCell : NSObject <NSCopying, NSCoding>
{
    
    id _contents;
    _CFlags _cFlags;
private
            id _support;
}


+ (BOOL)prefersTrackingUntilMouseUp;


- (id)initTextCell:(NSString *)aString;
- (id)initImageCell:(NSImage *)image;

- (NSView *)controlView;
- (NSCellType)type;
- (void)setType:(NSCellType)aType;
- (int)state;
- (void)setState:(int)value;
- (id)target;
- (void)setTarget:(id)anObject;
- (SEL)action;
- (void)setAction:(SEL)aSelector;
- (int)tag;
- (void)setTag:(int)anInt;
- (NSString*)title;
- (void)setTitle:(NSString*)aString;
- (BOOL)isOpaque;
- (BOOL)isEnabled;
- (void)setEnabled:(BOOL)flag;
- (int)sendActionOn:(int)mask;
- (BOOL)isContinuous;
- (void)setContinuous:(BOOL)flag;
- (BOOL)isEditable;
- (void)setEditable:(BOOL)flag;
- (BOOL)isSelectable;
- (void)setSelectable:(BOOL)flag;
- (BOOL)isBordered;
- (void)setBordered:(BOOL)flag;
- (BOOL)isBezeled;
- (void)setBezeled:(BOOL)flag;
- (BOOL)isScrollable;
- (void)setScrollable:(BOOL)flag;	
- (BOOL)isHighlighted;
- (void)setHighlighted:(BOOL)flag;
- (NSTextAlignment)alignment;
- (void)setAlignment:(NSTextAlignment)mode;
- (BOOL)wraps;
- (void)setWraps:(BOOL)flag;	
- (NSFont *)font;
- (void)setFont:(NSFont *)fontObj;
- (int)entryType;
- (void)setEntryType:(int)aType;
- (BOOL)isEntryAcceptable:(NSString *)aString;
- (void)setFloatingPointFormat:(BOOL)autoRange left:(unsigned)leftDigits right:(unsigned)rightDigits;
- (NSString *)keyEquivalent;
- (void)setFormatter:(NSFormatter *)newFormatter;
- (id)formatter;
- (id)objectValue;
- (void)setObjectValue:(id <NSCopying>)obj;
- (BOOL)hasValidObjectValue;
- (NSString *)stringValue;
- (void)setStringValue:(NSString *)aString;
- (NSComparisonResult)compare:(id)otherCell;
- (int)intValue;
- (void)setIntValue:(int)anInt;
- (float)floatValue;
- (void)setFloatValue:(float)aFloat;
- (double)doubleValue;
- (void)setDoubleValue:(double)aDouble;
- (void)takeIntValueFrom:(id)sender;
- (void)takeFloatValueFrom:(id)sender;
- (void)takeDoubleValueFrom:(id)sender;
- (void)takeStringValueFrom:(id)sender;
- (void)takeObjectValueFrom:(id)sender;
- (NSImage *)image;
- (void)setImage:(NSImage *)image;
- (void) setControlTint:(NSControlTint)controlTint;
- (NSControlTint)controlTint;
- (void)setControlSize:(NSControlSize)size;
- (NSControlSize)controlSize;
- (id)representedObject;
- (void)setRepresentedObject:(id)anObject;
- (int)cellAttribute:(NSCellAttribute)aParameter;
- (void)setCellAttribute:(NSCellAttribute)aParameter to:(int)value;
- (NSRect)imageRectForBounds:(NSRect)theRect;
- (NSRect)titleRectForBounds:(NSRect)theRect;
- (NSRect)drawingRectForBounds:(NSRect)theRect;
- (NSSize)cellSize;
- (NSSize)cellSizeForBounds:(NSRect)aRect;
- (NSColor *)highlightColorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView;
- (void)calcDrawInfo:(NSRect)aRect;
- (NSText *)setUpFieldEditorAttributes:(NSText *)textObj;
- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView;
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView;
- (void)highlight:(BOOL)flag withFrame:(NSRect)cellFrame inView:(NSView *)controlView;
- (int)mouseDownFlags;
- (void)getPeriodicDelay:(float *)delay interval:(float *)interval;
- (BOOL)startTrackingAt:(NSPoint)startPoint inView:(NSView *)controlView;
- (BOOL)continueTracking:(NSPoint)lastPoint at:(NSPoint)currentPoint inView:(NSView *)controlView;
- (void)stopTracking:(NSPoint)lastPoint at:(NSPoint)stopPoint inView:(NSView *)controlView mouseIsUp:(BOOL)flag;
- (BOOL)trackMouse:(NSEvent *)theEvent inRect:(NSRect)cellFrame ofView:(NSView *)controlView untilMouseUp:(BOOL)flag;
- (void)editWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)anObject event:(NSEvent *)theEvent;
- (void)selectWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)anObject start:(int)selStart length:(int)selLength;
- (void)endEditing:(NSText *)textObj;
- (void)resetCursorRect:(NSRect)cellFrame inView:(NSView *)controlView;

- (void)setMenu:(NSMenu *)aMenu;
- (NSMenu *)menu;
- (NSMenu *)menuForEvent:(NSEvent *)event inRect:(NSRect)cellFrame ofView:(NSView *)view;
+ (NSMenu *)defaultMenu;

- (void)setSendsActionOnEndEditing:(BOOL)flag;
- (BOOL)sendsActionOnEndEditing;

|#
#| @INTERFACE 
NSCell(NSKeyboardUI)
- (void)setRefusesFirstResponder:(BOOL)flag;
- (BOOL)refusesFirstResponder;
- (BOOL)acceptsFirstResponder;
- (void)setShowsFirstResponder:(BOOL)showFR;
- (BOOL)showsFirstResponder;
- (void)setMnemonicLocation:(unsigned)location;
- (unsigned)mnemonicLocation;
- (NSString *)mnemonic;
- (void)setTitleWithMnemonic:(NSString *)stringWithAmpersand;
- (void)performClick:(id)sender;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)setFocusRingType:(NSFocusRingType)focusRingType;
- (NSFocusRingType)focusRingType;
+ (NSFocusRingType)defaultFocusRingType;
#endif
|#
#| @INTERFACE 
NSCell(NSCellAttributedStringMethods)
- (NSAttributedString *)attributedStringValue;
- (void)setAttributedStringValue:(NSAttributedString *)obj;

- (BOOL)allowsEditingTextAttributes;
- (void)setAllowsEditingTextAttributes:(BOOL)flag;	
- (BOOL)importsGraphics;
- (void)setImportsGraphics:(BOOL)flag;			
|#
#| @INTERFACE 
NSCell(NSCellMixedState)
- (void)setAllowsMixedState:(BOOL)flag;	
- (BOOL)allowsMixedState;
- (int)nextState;			
- (void)setNextState;			
|#
(def-mactype :NSControlTintDidChangeNotification (find-mactype '(:pointer :NSString)))
;  sent after user changes control tint preference 

(provide-interface "NSCell")