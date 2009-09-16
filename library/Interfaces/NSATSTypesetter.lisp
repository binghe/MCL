(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSATSTypesetter.h"
; at Sunday July 2,2006 7:30:35 pm.
; 
;         NSTypographicTypesetter.h
;         Application Kit
;         Copyright (c) 2002-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <CoreFoundation/CFCharacterSet.h> // for UTF32Char

; #import <AppKit/NSTypesetter.h>

; #import <AppKit/NSParagraphStyle.h>

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
#| @INTERFACE 
NSATSTypesetter : NSTypesetter {

    NSAttributedString *attributedString; 
    NSRange paragraphGlyphRange; 
    NSRange paragraphSeparatorGlyphRange; 
    float lineFragmentPadding; 

    NSLayoutManager *layoutManager;
    NSArray *textContainers;


    NSTextContainer *currentTextContainer;
    unsigned int currentTextContainerIndex;
    NSSize currentTextContainerSize;


    NSParagraphStyle *currentParagraphStyle;

private
    void *_atsReserved[8];
    void *_private;
}


- (BOOL)usesFontLeading;
- (void)setUsesFontLeading:(BOOL)flag;
- (NSTypesetterBehavior)typesetterBehavior;
- (void)setTypesetterBehavior:(NSTypesetterBehavior)behavior;
- (float)hyphenationFactor;
- (void)setHyphenationFactor:(float)factor;

- (float)lineFragmentPadding;
- (void)setLineFragmentPadding:(float)padding;

- (NSFont *)substituteFontForFont:(NSFont *)originalFont;

- (NSTextTab *)textTabForGlyphLocation:(float)glyphLocation writingDirection:(NSWritingDirection)direction maxLocation:(float)maxLocation;

- (BOOL)bidiProcessingEnabled;
- (void)setBidiProcessingEnabled:(BOOL)flag; 
- (void)setAttributedString:(NSAttributedString *)attrString; - (NSAttributedString *)attributedString;
- (void)setParagraphGlyphRange:(NSRange)paragraphRange separatorGlyphRange:(NSRange)paragraphSeparatorRange;
- (NSRange)paragraphGlyphRange;
- (NSRange)paragraphSeparatorGlyphRange;

- (unsigned int)layoutParagraphAtPoint:(NSPoint *)lineFragmentOrigin; 
- (float)lineSpacingAfterGlyphAtIndex:(unsigned)glyphIndex withProposedLineFragmentRect:(NSRect)rect;
- (float)paragraphSpacingBeforeGlyphAtIndex:(unsigned)glyphIndex withProposedLineFragmentRect:(NSRect)rect;
- (float)paragraphSpacingAfterGlyphAtIndex:(unsigned)glyphIndex withProposedLineFragmentRect:(NSRect)rect;


+ (id)sharedTypesetter;

- (NSLayoutManager *)layoutManager;
- (NSTextContainer *)currentTextContainer;

- (void)setHardInvalidation:(BOOL)flag forGlyphRange:(NSRange)glyphRange;

- (void)getLineFragmentRect:(NSRect *)lineFragmentRect usedRect:(NSRect *)lineFragmentUsedRect forParagraphSeparatorGlyphRange:(NSRange)paragraphSeparatorGlyphRange atProposedOrigin:(NSPoint)lineOrigin;
|#
;  NSLayoutPhaseInterface declares various subclass override points that are invoked if implemented 
#| @INTERFACE 
NSATSTypesetter (NSLayoutPhaseInterface)
- (void)willSetLineFragmentRect:(NSRect *)lineRect forGlyphRange:(NSRange)glyphRange usedRect:(NSRect *)usedRect baselineOffset:(float *)baselineOffset;

- (BOOL)shouldBreakLineByWordBeforeCharacterAtIndex:(unsigned)charIndex;
- (BOOL)shouldBreakLineByHyphenatingBeforeCharacterAtIndex:(unsigned)charIndex;

- (float)hyphenationFactorForGlyphAtIndex:(unsigned)glyphIndex;
- (UTF32Char)hyphenCharacterForGlyphAtIndex:(unsigned)glyphIndex;

- (NSRect)boundingBoxForControlGlyphAtIndex:(unsigned)glyphIndex forTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(NSRect)proposedRect glyphPosition:(NSPoint)glyphPosition characterIndex:(unsigned)charIndex;
|#
;  NSGlyphStorageInterface declares all primitives interfacing to the glyph storage (usually NSLayoutManager). By overriding all the methods, you can implement an NSATSTypesetter subclass that interacts with custom glyph storage. 
#| @INTERFACE 
NSATSTypesetter (NSGlyphStorageInterface)
- (NSRange)characterRangeForGlyphRange:(NSRange)glyphRange actualGlyphRange:(NSRangePointer)actualGlyphRange;
- (NSRange)glyphRangeForCharacterRange:(NSRange)charRange actualCharacterRange:(NSRangePointer)actualCharRange;

- (unsigned)getGlyphsInRange:(NSRange)glyphsRange glyphs:(NSGlyph *)glyphBuffer characterIndexes:(unsigned *)charIndexBuffer glyphInscriptions:(NSGlyphInscription *)inscribeBuffer elasticBits:(BOOL *)elasticBuffer;

- (NSRect)lineFragmentRectForProposedRect:(NSRect)proposedRect remainingRect:(NSRectPointer)remainingRect;

- (void)setLineFragmentRect:(NSRect)fragmentRect forGlyphRange:(NSRange)glyphRange usedRect:(NSRect)usedRect baselineOffset:(float)baselineOffset;
- (void)substituteGlyphsInRange:(NSRange)glyphRange withGlyphs:(NSGlyph *)glyphs;
- (void)insertGlyph:(NSGlyph)glyph atGlyphIndex:(unsigned)glyphIndex characterIndex:(unsigned)characterIndex;
- (void)deleteGlyphsInRange:(NSRange)glyphRange;
- (void)setNotShownAttribute:(BOOL)flag forGlyphRange:(NSRange)glyphRange;
- (void)setDrawsOutsideLineFragment:(BOOL)flag forGlyphRange:(NSRange)glyphRange;
- (void)setLocation:(NSPoint)location withAdvancements:(const float *)advancements forStartOfGlyphRange:(NSRange)glyphRange;
- (void)setAttachmentSize:(NSSize)attachmentSize forGlyphRange:(NSRange)glyphRange;
- (void)setBidiLevels:(const uint8_t *)levels forGlyphRange:(NSRange)glyphRange;
|#

; #endif /* MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED */


(provide-interface "NSATSTypesetter")