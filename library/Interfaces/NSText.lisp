(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSText.h"
; at Sunday July 2,2006 7:31:02 pm.
; 
; 	NSText.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSView.h>

; #import <AppKit/NSSpellProtocol.h>
;  Various important unicodes 

(defconstant $NSParagraphSeparatorCharacter #x2029)
(defconstant $NSLineSeparatorCharacter #x2028)
(defconstant $NSTabCharacter 9)
(defconstant $NSFormFeedCharacter 12)
(defconstant $NSNewlineCharacter 10)
(defconstant $NSCarriageReturnCharacter 13)
(defconstant $NSEnterCharacter 3)
(defconstant $NSBackspaceCharacter 8)
(defconstant $NSBackTabCharacter 25)
(defconstant $NSDeleteCharacter 127)
(def-mactype :_NSTextAlignment (find-mactype ':sint32))

(defconstant $NSLeftTextAlignment 0)            ;  Visually left aligned 

(defconstant $NSRightTextAlignment 1)           ;  Visually right aligned 

(defconstant $NSCenterTextAlignment 2)
(defconstant $NSJustifiedTextAlignment 3)
(defconstant $NSNaturalTextAlignment 4)         ;  Indicates the default alignment for script 

(def-mactype :NSTextAlignment (find-mactype ':SINT32))
;  Movement codes for movement between fields; these codes are the intValue of the NSTextMovement key in NSTextDidEndEditing notifications, and are used when completions change in the NSTextView method insertCompletion:forPartialWordRange:movement:isFinal:.  Note that the value 0 is used for movements that do not fall under any of the other values, hence NSOtherTextMovement is a more appropriate name than the previous NSIllegalTextMovement.
; 

(defconstant $NSIllegalTextMovement 0)
(defconstant $NSReturnTextMovement 16)
(defconstant $NSTabTextMovement 17)
(defconstant $NSBacktabTextMovement 18)
(defconstant $NSLeftTextMovement 19)
(defconstant $NSRightTextMovement 20)
(defconstant $NSUpTextMovement 21)
; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

(defconstant $NSDownTextMovement 22)
; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

(defconstant $NSCancelTextMovement 23)
; #endif


(defconstant $NSOtherTextMovement 0)
; #endif


#| @INTERFACE 
NSText : NSView <NSChangeSpelling, NSIgnoreMisspelledWords> {
    
    void *_ivars;
}

- (NSString *)string;
- (void)setString:(NSString *)string;

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
- (void)replaceCharactersInRange:(NSRange)range withRTF:(NSData *)rtfData;
- (void)replaceCharactersInRange:(NSRange)range withRTFD:(NSData *)rtfdData;

- (NSData *)RTFFromRange:(NSRange)range;
- (NSData *)RTFDFromRange:(NSRange)range;

- (BOOL)writeRTFDToFile:(NSString *)path atomically:(BOOL)flag;
- (BOOL)readRTFDFromFile:(NSString *)path;

- (id)delegate;
- (void)setDelegate:(id)anObject;

- (BOOL)isEditable;
- (void)setEditable:(BOOL)flag;
- (BOOL)isSelectable;
- (void)setSelectable:(BOOL)flag;
- (BOOL)isRichText;
- (void)setRichText:(BOOL)flag;		
- (BOOL)importsGraphics;
- (void)setImportsGraphics:(BOOL)flag;	
- (void)setBackgroundColor:(NSColor *)color;
- (NSColor *)backgroundColor;
- (void)setDrawsBackground:(BOOL)flag;
- (BOOL)drawsBackground;

- (void)setFont:(NSFont *)obj;
- (NSFont *)font;
- (void)setTextColor:(NSColor *)color;
- (NSColor *)textColor;
- (NSTextAlignment)alignment;
- (void)setAlignment:(NSTextAlignment)mode;

- (void)setFieldEditor:(BOOL)flag; 
- (BOOL)isFieldEditor;

- (void)setTextColor:(NSColor *)color range:(NSRange)range;
- (void)setFont:(NSFont *)font range:(NSRange)range;

- (BOOL)usesFontPanel;
- (void)setUsesFontPanel:(BOOL)flag;

- (NSSize)maxSize;
- (void)setMaxSize:(NSSize)newMaxSize;
- (NSSize)minSize;
- (void)setMinSize:(NSSize)newMinSize;

- (BOOL)isHorizontallyResizable;
- (void)setHorizontallyResizable:(BOOL)flag;
- (BOOL)isVerticallyResizable;
- (void)setVerticallyResizable:(BOOL)flag;

- (void)sizeToFit;

- (void)copy:(id)sender;
- (void)copyFont:(id)sender;
- (void)copyRuler:(id)sender;
- (void)cut:(id)sender;
- (void)delete:(id)sender;
- (void)paste:(id)sender;
- (void)pasteFont:(id)sender;
- (void)pasteRuler:(id)sender;
- (void)selectAll:(id)sender;
- (void)changeFont:(id)sender;
- (void)alignLeft:(id)sender;
- (void)alignRight:(id)sender;
- (void)alignCenter:(id)sender;
- (void)subscript:(id)sender;
- (void)superscript:(id)sender;
- (void)underline:(id)sender;
- (void)unscript:(id)sender;
- (void)showGuessPanel:(id)sender;
- (void)checkSpelling:(id)sender;
- (void)toggleRuler:(id)sender;

- (BOOL)isRulerVisible;

- (NSRange)selectedRange;
- (void)setSelectedRange:(NSRange)range;

- (void)scrollRangeToVisible:(NSRange)range;

|#
#| @INTERFACE 
NSObject(NSTextDelegate)
- (BOOL)textShouldBeginEditing:(NSText *)textObject; 
- (BOOL)textShouldEndEditing:(NSText *)textObject; 
- (void)textDidBeginEditing:(NSNotification *)notification;
- (void)textDidEndEditing:(NSNotification *)notification;
- (void)textDidChange:(NSNotification *)notification; 
|#
;  Notifications 
(def-mactype :NSTextDidBeginEditingNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSTextDidEndEditingNotification (find-mactype '(:pointer :NSString)))
;  userInfo key:  @"NSTextMovement"
(def-mactype :NSTextDidChangeNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSText")