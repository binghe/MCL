(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSAttributedString.h"
; at Sunday July 2,2006 7:30:35 pm.
; 	
; 	NSAttributedString.h
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
; 	This file defines Application Kit extensions to NSAttributedString and NSMutableAttributedString.
; 

; #import <Foundation/NSAttributedString.h>

; #import <AppKit/NSFontManager.h>

; #import <AppKit/NSText.h>

; #import <AppKit/AppKitDefines.h>
;  Predefined character attributes for text. If the key is not in the dictionary, then use the default values as described below.
; 
(def-mactype :NSFontAttributeName (find-mactype '(:pointer :NSString)))
;  NSFont, default Helvetica 12 
(def-mactype :NSParagraphStyleAttributeName (find-mactype '(:pointer :NSString)))
;  NSParagraphStyle, default defaultParagraphStyle 
(def-mactype :NSForegroundColorAttributeName (find-mactype '(:pointer :NSString)))
;  NSColor, default blackColor 
(def-mactype :NSUnderlineStyleAttributeName (find-mactype '(:pointer :NSString)))
;  int, default 0: no underline 
(def-mactype :NSSuperscriptAttributeName (find-mactype '(:pointer :NSString)))
;  int, default 0 
(def-mactype :NSBackgroundColorAttributeName (find-mactype '(:pointer :NSString)))
;  NSColor, default nil: no background 
(def-mactype :NSAttachmentAttributeName (find-mactype '(:pointer :NSString)))
;  NSTextAttachment, default nil 
(def-mactype :NSLigatureAttributeName (find-mactype '(:pointer :NSString)))
;  int, default 1: default ligatures, 0: no ligatures, 2: all ligatures 
(def-mactype :NSBaselineOffsetAttributeName (find-mactype '(:pointer :NSString)))
;  float, in points; offset from baseline, default 0 
(def-mactype :NSKernAttributeName (find-mactype '(:pointer :NSString)))
;  float, amount to modify default kerning, if 0, kerning off 
(def-mactype :NSLinkAttributeName (find-mactype '(:pointer :NSString)))
;  ??? id <NSTextLink>; link 
(def-mactype :NSStrokeWidthAttributeName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  float, in percent of font point size, default 0: no stroke; positive for stroke alone, negative for stroke and fill (a typical value for outlined text would be 3.0) 
(def-mactype :NSStrokeColorAttributeName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  NSColor, default nil: same as foreground color 
(def-mactype :NSUnderlineColorAttributeName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  NSColor, default nil: same as foreground color 
(def-mactype :NSStrikethroughStyleAttributeName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  int, default 0: no strikethrough 
(def-mactype :NSStrikethroughColorAttributeName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  NSColor, default nil: same as foreground color 
(def-mactype :NSShadowAttributeName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  NSShadow, default nil: no shadow 
(def-mactype :NSObliquenessAttributeName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  float; skew to be applied to glyphs, default 0: no skew 
(def-mactype :NSExpansionAttributeName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  float; log of expansion factor to be applied to glyphs, default 0: no expansion 
(def-mactype :NSCursorAttributeName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  NSCursor, default IBeamCursor 
(def-mactype :NSToolTipAttributeName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  NSString, default nil: no tooltip 
;  An integer value.  The value is interpreted as Apple Type Services kCharacterShapeType selector + 1.
;  * default is 0 (disable). 1 is kTraditionalCharactersSelector and so on.
;  * Refer to <ATS/SFNTLayoutTypes.h>
;  
(def-mactype :NSCharacterShapeAttributeName (find-mactype '(:pointer :NSString)))

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
;  An NSGlyphInfo object.  This provides a means to override the standard glyph generation.  NSLayoutManager will assign the glyph specified by this glyph info to the entire attribute range, provided that its contents match the specified base string, and that the specified glyph is available in the font specified by NSFontAttributeName.
; 
(def-mactype :NSGlyphInfoAttributeName (find-mactype '(:pointer :NSString)))

; #endif

;  This defines currently supported values for NSUnderlineStyleAttributeName and NSStrikethroughAttributeName, as of Mac OS X version 10.3.  The style, pattern, and optionally by-word mask are or'd together to produce the value.  The previous constants are still supported, but deprecated (except for NSUnderlineByWordMask); including NSUnderlineStrikethroughMask in the underline style will still produce a strikethrough, but that is deprecated in favor of setting NSStrikethroughStyleAttributeName using the values described here.
; 

(defconstant $NSUnderlineStyleNone 0)
(defconstant $NSUnderlineStyleSingle 1)
(defconstant $NSUnderlineStyleThick 2)
(defconstant $NSUnderlineStyleDouble 9)

(defconstant $NSUnderlinePatternSolid 0)
(defconstant $NSUnderlinePatternDot #x100)
(defconstant $NSUnderlinePatternDash #x200)
(defconstant $NSUnderlinePatternDashDot #x300)
(defconstant $NSUnderlinePatternDashDotDot #x400)
(def-mactype :NSUnderlineByWordMask (find-mactype ':UInt32))
;  Values returned for the @"DocumentType" key in the document attributes dictionary when reading text documents. Note that other values are possible, and this set might grow in the future.
; 
(def-mactype :NSPlainTextDocumentType (find-mactype '(:pointer :NSString)))
(def-mactype :NSRTFTextDocumentType (find-mactype '(:pointer :NSString)))
(def-mactype :NSRTFDTextDocumentType (find-mactype '(:pointer :NSString)))
(def-mactype :NSMacSimpleTextDocumentType (find-mactype '(:pointer :NSString)))
(def-mactype :NSHTMLTextDocumentType (find-mactype '(:pointer :NSString)))
(def-mactype :NSDocFormatTextDocumentType (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSWordMLTextDocumentType (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
#| @INTERFACE 
NSAttributedString (NSAttributedStringKitAdditions)

- (NSDictionary *)fontAttributesInRange:(NSRange)range; 
- (NSDictionary *)rulerAttributesInRange:(NSRange)range; 

- (BOOL)containsAttachments;


- (unsigned)lineBreakBeforeIndex:(unsigned)location withinRange:(NSRange)aRange;
#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (unsigned)lineBreakByHyphenatingBeforeIndex:(unsigned)location withinRange:(NSRange)aRange;
#endif
- (NSRange)doubleClickAtIndex:(unsigned)location;
- (unsigned)nextWordFromIndex:(unsigned)location forward:(BOOL)isForward;


+ (NSArray *)textUnfilteredFileTypes;
+ (NSArray *)textUnfilteredPasteboardTypes;
+ (NSArray *)textFileTypes;
+ (NSArray *)textPasteboardTypes;


- (id)initWithPath:(NSString *)path documentAttributes:(NSDictionary **)dict;
- (id)initWithURL:(NSURL *)url documentAttributes:(NSDictionary **)dict;
- (id)initWithRTF:(NSData *)data documentAttributes:(NSDictionary **)dict;
- (id)initWithRTFD:(NSData *)data documentAttributes:(NSDictionary **)dict;
- (id)initWithRTFDFileWrapper:(NSFileWrapper *)wrapper documentAttributes:(NSDictionary **)dict;
- (id)initWithHTML:(NSData *)data documentAttributes:(NSDictionary **)dict;
- (id)initWithHTML:(NSData *)data baseURL:(NSURL *)base documentAttributes:(NSDictionary **)dict;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (id)initWithDocFormat:(NSData *)data documentAttributes:(NSDictionary **)dict;
- (id)initWithHTML:(NSData *)data options:(NSDictionary *)options documentAttributes:(NSDictionary **)dict;
    #endif


- (NSData *)RTFFromRange:(NSRange)range documentAttributes:(NSDictionary *)dict;
- (NSData *)RTFDFromRange:(NSRange)range documentAttributes:(NSDictionary *)dict;
- (NSFileWrapper *)RTFDFileWrapperFromRange:(NSRange)range documentAttributes:(NSDictionary *)dict;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (NSData *)docFormatFromRange:(NSRange)range documentAttributes:(NSDictionary *)dict;
#endif

|#
#| @INTERFACE 
NSMutableAttributedString (NSMutableAttributedStringKitAdditions)


- (BOOL)readFromURL:(NSURL *)url options:(NSDictionary *)options documentAttributes:(NSDictionary **)dict;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (BOOL)readFromData:(NSData *)data options:(NSDictionary *)options documentAttributes:(NSDictionary **)dict;
#endif


- (void)superscriptRange:(NSRange)range; 
- (void)subscriptRange:(NSRange)range; 
- (void)unscriptRange:(NSRange)range; 
- (void)applyFontTraits:(NSFontTraitMask)traitMask range:(NSRange)range; 
- (void)setAlignment:(NSTextAlignment)alignment range:(NSRange)range;


- (void)fixAttributesInRange:(NSRange)range; 
- (void)fixFontAttributeInRange:(NSRange)range; 
- (void)fixParagraphStyleAttributeInRange:(NSRange)range; 
- (void)fixAttachmentAttributeInRange:(NSRange)range; 

|#
;  Deprecated constants previously used for underline style.
; 

(defconstant $NSNoUnderlineStyle 0)
(defconstant $NSSingleUnderlineStyle 1)
(def-mactype :NSUnderlineStrikethroughMask (find-mactype ':UInt32))

(provide-interface "NSAttributedString")