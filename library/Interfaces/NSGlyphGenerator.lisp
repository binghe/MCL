(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSGlyphGenerator.h"
; at Sunday July 2,2006 7:30:49 pm.
; 
;         NSGlyphGenerator.h
;         Application Kit
;         Copyright (c) 1993-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <Foundation/NSAttributedString.h>

; #import <AppKit/NSFont.h> // for NSGlyph

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  NSGlyphStorage layout options 

(defconstant $NSShowControlGlyphs 1)            ;  if set, generates displayable glyphs for control chars

(defconstant $NSShowInvisibleGlyphs 2)          ;  if set, generates displayable glyphs for invisible chars
;  if set, generates bidi levels

(defconstant $NSWantsBidiLevels 4)
#| @PROTOCOL 
NSGlyphStorage
- (void)insertGlyphs:(const NSGlyph *)glyphs length:(unsigned int)length forStartingGlyphAtIndex:(unsigned int)glyphIndex characterIndex:(unsigned int)charIndex;

- (void)setIntAttribute:(int)attributeTag value:(int)val forGlyphAtIndex:(unsigned)glyphIndex;

- (NSAttributedString *)attributedString;
- (unsigned int)layoutOptions;
|#
#| @INTERFACE 
NSGlyphGenerator : NSObject
- (void)generateGlyphsForGlyphStorage:(id <NSGlyphStorage>)glyphStorage desiredNumberOfCharacters:(unsigned int)nChars glyphIndex:(unsigned int *)glyphIndex characterIndex:(unsigned int *)charIndex;

+ (id) sharedGlyphGenerator;
|#

; #endif /* MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED */


(provide-interface "NSGlyphGenerator")