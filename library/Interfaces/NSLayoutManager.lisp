(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSLayoutManager.h"
; at Sunday July 2,2006 7:30:51 pm.
; 
;         NSLayoutManager.h
;         Application Kit
;         Copyright (c) 1994-2003, Apple Computer, Inc.
;         All rights reserved.
; 
;  An NSLayoutManager stores glyphs, attributes, and layout information generated from a NSTextStorage by a NSTextLayout.  It can map between ranges of unichars in the NSTextStorage and ranges of glyphs within itself.  It understands and keeps track of two types of range invalidation.  A character range can need glyphs generated for it or it can need its glyphs laid out.  
;  When a NSLayoutManager is asked for information which would require knowledge of glyphs or layout which is not currently available, the NSLayoutManager must cause the appropriate recalculation to be done.

; #import <Foundation/NSObject.h>

; #import <AppKit/NSFont.h>

; #import <AppKit/NSImageCell.h>

; #import <AppKit/NSGlyphGenerator.h>
;  These glyph attributes are used only inside the glyph generation machinery, but must be shared between components.
(def-mactype :_NSGlyphAttribute (find-mactype ':sint32))

(defconstant $NSGlyphAttributeSoft 0)
(defconstant $NSGlyphAttributeElastic 1)
; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2

(defconstant $NSGlyphAttributeBidiLevel 2)
; #endif


(defconstant $NSGlyphAttributeInscribe 5)
;  The inscribe attribute of a glyph determines how it is laid out relative to the previous glyph.

(defconstant $NSGlyphInscribeBase 0)
(defconstant $NSGlyphInscribeBelow 1)
(defconstant $NSGlyphInscribeAbove 2)
(defconstant $NSGlyphInscribeOverstrike 3)
(defconstant $NSGlyphInscribeOverBelow 4)
(def-mactype :NSGlyphInscription (find-mactype ':SINT32))
;  The typesetting behavior (compatibility setting) values.
; 

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2

(defconstant $NSTypesetterLatestBehavior -1)
(defconstant $NSTypesetterOriginalBehavior 0)   ;  Mac OS X ver 10.0 and 10.1 (uses NSSimpleHorizontalTypesetter)

(defconstant $NSTypesetterBehavior_10_2_WithCompatibility 1);  10.2 with backward compatibility layout (uses new ATS-based typestter)

(defconstant $NSTypesetterBehavior_10_2 2)
(defconstant $NSTypesetterBehavior_10_3 3)
(def-mactype :NSTypesetterBehavior (find-mactype ':SINT32))

; #endif

#| @INTERFACE 
NSLayoutManager : NSObject <NSCoding, NSGlyphStorage> {

  

  private
    NSTextStorage *_textStorage;
    NSGlyphGenerator *_glyphGenerator;
    NSTypesetter *_typesetter;

    NSMutableArray *_textContainers;
    NSStorage *_containerUsedRects;

    NSStorage *_glyphs;
    NSRunStorage *_containerRuns;
    NSRunStorage *_fragmentRuns;
    NSRunStorage *_glyphLocations;
    NSRunStorage *_glyphRotationRuns;
    
    NSRect _extraLineFragmentRect;
    NSRect _extraLineFragmentUsedRect;
    NSTextContainer *_extraLineFragmentContainer;

    NSSortedArray *_glyphHoles;
    NSSortedArray *_layoutHoles;

    struct __lmFlags {
        unsigned int containersAreFull:1;
        unsigned int glyphsMightDrawOutsideLines:1;
        unsigned int backgroundLayoutEnabled:1;
        unsigned int resizingInProgress:1;
        unsigned int allowScreenFonts:1;
        unsigned int cachedRectArrayInUse:1;
        unsigned int displayInvalidationInProgress:1;
        unsigned int insertionPointNeedsUpdate:1;
        unsigned int layoutManagerInDirtyList:1;
        unsigned int usingGlyphCache:1;
        unsigned int showInvisibleCharacters:1;
        unsigned int showControlCharacters:1;
        unsigned int delegateRespondsToDidInvalidate:1;
        unsigned int delegateRespondsToDidComplete:1;
        unsigned int glyphFormat:2;
        unsigned int textStorageRespondsToIsEditing:1;
        unsigned int notifyEditedInProgress:1;
        unsigned int containersChanged:1;
        unsigned int isGeneratingGlyphs:1;
        unsigned int hasNonGeneratedGlyphData:1;
        unsigned int loggedBGLayoutException:1;
        unsigned int isLayoutRequestedFromSubthread:1;
        unsigned int defaultAttachmentScaling:2;
        unsigned int isInUILayoutMode:1;
        unsigned int seenRightToLeft:1;
        unsigned int ignoresAntialiasThreshold:1;
        unsigned int needToFlushGlyph:1;

        unsigned int _pad:3;
    } _lmFlags;

    id _delegate;

        unsigned short _textViewResizeDisableStack;
    unsigned short _displayInvalidationDisableStack;
    NSRange _deferredDisplayCharRange;

        NSTextView *_firstTextView;

        NSRect *_cachedRectArray;
    unsigned _cachedRectArrayCapacity;

        char *_glyphBuffer;
    unsigned _glyphBufferSize;

        NSRange _cachedLocationNominalGlyphRange;
    unsigned _cachedLocationGlyphIndex;
    NSPoint _cachedLocation;

        NSRange _cachedFontCharRange;
    NSFont *_cachedFont;

        unsigned _firstUnlaidGlyphIndex;
    unsigned _firstUnlaidCharIndex;

        NSBox *_rulerAccView;
    id _rulerAccViewAlignmentButtons;
    id _rulerAccViewSpacing;
    NSTabWell *_rulerAccViewLeftTabWell;
    NSTabWell *_rulerAccViewRightTabWell;
    NSTabWell *_rulerAccViewCenterTabWell;
    NSTabWell *_rulerAccViewDecimalTabWell;
    id _rulerAccViewStyles;
    id _rulerAccViewReserved;

    NSRange _newlyFilledGlyphRange;

    void *_extraData;
}



- (id)init;
    


- (NSTextStorage *)textStorage;
- (void)setTextStorage:(NSTextStorage *)textStorage;
    
- (void)replaceTextStorage:(NSTextStorage *)newTextStorage;
    
- (NSTypesetter *)typesetter;
- (void)setTypesetter:(NSTypesetter *)typesetter;
    
- (id)delegate;
- (void)setDelegate:(id)delegate;
    


- (NSArray *)textContainers;

- (void)addTextContainer:(NSTextContainer *)container;
    - (void)insertTextContainer:(NSTextContainer *)container atIndex:(unsigned)index;
    - (void)removeTextContainerAtIndex:(unsigned)index;
    
- (void)textContainerChangedGeometry:(NSTextContainer *)container;
    
- (void)textContainerChangedTextView:(NSTextContainer *)container;
    


- (void)invalidateGlyphsForCharacterRange:(NSRange)charRange changeInLength:(int)delta actualCharacterRange:(NSRangePointer)actualCharRange;
    
- (void)invalidateLayoutForCharacterRange:(NSRange)charRange isSoft:(BOOL)flag actualCharacterRange:(NSRangePointer)actualCharRange;
    
- (void)invalidateDisplayForGlyphRange:(NSRange)glyphRange;
- (void)invalidateDisplayForCharacterRange:(NSRange)charRange;
    


- (void)textStorage:(NSTextStorage *)str edited:(unsigned)editedMask range:(NSRange)newCharRange changeInLength:(int)delta invalidatedRange:(NSRange)invalidatedCharRange;
    


- (void)setBackgroundLayoutEnabled:(BOOL)flag;
- (BOOL)backgroundLayoutEnabled;
    
- (void)setShowsInvisibleCharacters:(BOOL)flag;
- (BOOL)showsInvisibleCharacters;
    
- (void)setShowsControlCharacters:(BOOL)flag;
- (BOOL)showsControlCharacters;
    
- (void)setHyphenationFactor:(float)factor;
- (float)hyphenationFactor;
    
- (void)setDefaultAttachmentScaling:(NSImageScaling)scaling;
- (NSImageScaling)defaultAttachmentScaling;
    



- (void)insertGlyph:(NSGlyph)glyph atGlyphIndex:(unsigned)glyphIndex characterIndex:(unsigned)charIndex;
    
- (void)replaceGlyphAtIndex:(unsigned)glyphIndex withGlyph:(NSGlyph)newGlyph;
    
- (void)deleteGlyphsInRange:(NSRange)glyphRange;
    
- (void)setCharacterIndex:(unsigned)charIndex forGlyphAtIndex:(unsigned)glyphIndex;
    


- (unsigned)numberOfGlyphs;
    
- (NSGlyph)glyphAtIndex:(unsigned)glyphIndex;
- (NSGlyph)glyphAtIndex:(unsigned)glyphIndex isValidIndex:(BOOL *)isValidIndex;
- (BOOL)isValidGlyphIndex:(unsigned)glyphIndex;
        

- (unsigned)getGlyphs:(NSGlyph *)glyphArray range:(NSRange)glyphRange;
    
- (unsigned)characterIndexForGlyphAtIndex:(unsigned)glyphIndex;
    



- (void)setIntAttribute:(int)attributeTag value:(int)val forGlyphAtIndex:(unsigned)glyphIndex;
    

- (int)intAttribute:(int)attributeTag forGlyphAtIndex:(unsigned)glyphIndex;
    



- (void)setTextContainer:(NSTextContainer *)container forGlyphRange:(NSRange)glyphRange;
    
- (void)setLineFragmentRect:(NSRect)fragmentRect forGlyphRange:(NSRange)glyphRange usedRect:(NSRect)usedRect;
    
- (void)setExtraLineFragmentRect:(NSRect)fragmentRect usedRect:(NSRect)usedRect textContainer:(NSTextContainer *)container;
    
- (void)setDrawsOutsideLineFragment:(BOOL)flag forGlyphAtIndex:(unsigned)glyphIndex;
    
- (void)setLocation:(NSPoint)location forStartOfGlyphRange:(NSRange)glyphRange;
    
- (void)setNotShownAttribute:(BOOL)flag forGlyphAtIndex:(unsigned)glyphIndex;
    
- (void)setAttachmentSize:(NSSize)attachmentSize forGlyphRange:(NSRange)glyphRange;
   
- (NSTextContainer *)textContainerForGlyphAtIndex:(unsigned)glyphIndex effectiveRange:(NSRangePointer)effectiveGlyphRange;
    
- (NSRect)usedRectForTextContainer:(NSTextContainer *)container;
    
- (NSRect)lineFragmentRectForGlyphAtIndex:(unsigned)glyphIndex effectiveRange:(NSRangePointer)effectiveGlyphRange;
    
- (NSRect)lineFragmentUsedRectForGlyphAtIndex:(unsigned)glyphIndex effectiveRange:(NSRangePointer)effectiveGlyphRange;
    
- (NSSize)attachmentSizeForGlyphAtIndex:(unsigned)glyphIndex;
    
- (NSRect)extraLineFragmentRect;
- (NSRect)extraLineFragmentUsedRect;
- (NSTextContainer *)extraLineFragmentTextContainer;
    
- (BOOL)drawsOutsideLineFragmentForGlyphAtIndex:(unsigned) glyphIndex;
    
- (NSPoint)locationForGlyphAtIndex:(unsigned)glyphIndex;
    
- (BOOL)notShownAttributeForGlyphAtIndex:(unsigned) glyphIndex;
    



- (NSRange)glyphRangeForCharacterRange:(NSRange)charRange actualCharacterRange:(NSRangePointer)actualCharRange;
    
- (NSRange)characterRangeForGlyphRange:(NSRange)glyphRange actualGlyphRange:(NSRangePointer)actualGlyphRange;
    

- (NSRange)glyphRangeForTextContainer:(NSTextContainer *)container;
    
- (NSRange)rangeOfNominallySpacedGlyphsContainingIndex:(unsigned)glyphIndex;
    
- (NSRectArray)rectArrayForCharacterRange:(NSRange)charRange withinSelectedCharacterRange:(NSRange)selCharRange inTextContainer:(NSTextContainer *)container rectCount:(unsigned *)rectCount;
- (NSRectArray)rectArrayForGlyphRange:(NSRange)glyphRange withinSelectedGlyphRange:(NSRange)selGlyphRange inTextContainer:(NSTextContainer *)container rectCount:(unsigned *)rectCount;
        
- (NSRect)boundingRectForGlyphRange:(NSRange)glyphRange inTextContainer:(NSTextContainer *)container;
    
- (NSRange)glyphRangeForBoundingRect:(NSRect)bounds inTextContainer:(NSTextContainer *)container;
- (NSRange)glyphRangeForBoundingRectWithoutAdditionalLayout:(NSRect)bounds inTextContainer:(NSTextContainer *)container;
    
- (unsigned)glyphIndexForPoint:(NSPoint)point inTextContainer:(NSTextContainer *)container fractionOfDistanceThroughGlyph:(float *)partialFraction;
- (unsigned)glyphIndexForPoint:(NSPoint)point inTextContainer:(NSTextContainer *)container;
- (float)fractionOfDistanceThroughGlyphForPoint:(NSPoint)point inTextContainer:(NSTextContainer *)container;
        
- (void)getFirstUnlaidCharacterIndex:(unsigned *)charIndex glyphIndex:(unsigned *)glyphIndex;
- (unsigned)firstUnlaidCharacterIndex;
- (unsigned)firstUnlaidGlyphIndex;
        


- (BOOL)usesScreenFonts;
- (void)setUsesScreenFonts:(BOOL)flag;
    
- (NSFont *)substituteFontForFont:(NSFont *)originalFont;
    

- (NSDictionary *)temporaryAttributesAtCharacterIndex:(unsigned)charIndex effectiveRange:(NSRangePointer)effectiveCharRange;
- (void)setTemporaryAttributes:(NSDictionary *)attrs forCharacterRange:(NSRange)charRange;
- (void)addTemporaryAttributes:(NSDictionary *)attrs forCharacterRange:(NSRange)charRange;
- (void)removeTemporaryAttribute:(NSString *)name forCharacterRange:(NSRange)charRange;



#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (unsigned)getGlyphsInRange:(NSRange)glyphsRange glyphs:(NSGlyph *)glyphBuffer characterIndexes:(unsigned *)charIndexBuffer glyphInscriptions:(NSGlyphInscription *)inscribeBuffer elasticBits:(BOOL *)elasticBuffer bidiLevels:(unsigned char *)bidiLevelBuffer;
#endif
- (unsigned)getGlyphsInRange:(NSRange)glyphsRange glyphs:(NSGlyph *)glyphBuffer characterIndexes:(unsigned *)charIndexBuffer glyphInscriptions:(NSGlyphInscription *)inscribeBuffer elasticBits:(BOOL *)elasticBuffer;


#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (NSTypesetterBehavior)typesetterBehavior;
- (void)setTypesetterBehavior:(NSTypesetterBehavior)theBehavior;

- (float)defaultLineHeightForFont:(NSFont *)theFont;
#endif
|#
#| @INTERFACE 
NSLayoutManager (NSTextViewSupport)



- (NSArray *)rulerMarkersForTextView:(NSTextView *)view paragraphStyle:(NSParagraphStyle *)style ruler:(NSRulerView *)ruler;
- (NSView *)rulerAccessoryViewForTextView:(NSTextView *)view paragraphStyle:(NSParagraphStyle *)style ruler:(NSRulerView *)ruler enabled:(BOOL)isEnabled;
    


- (BOOL)layoutManagerOwnsFirstResponderInWindow:(NSWindow *)window;
    
- (NSTextView *)firstTextView;

- (NSTextView *)textViewForBeginningOfSelection;
    


- (void)drawBackgroundForGlyphRange:(NSRange)glyphsToShow atPoint:(NSPoint)origin;
- (void)drawGlyphsForGlyphRange:(NSRange)glyphsToShow atPoint:(NSPoint)origin;
    
- (void)showPackedGlyphs:(char *)glyphs length:(unsigned)glyphLen glyphRange:(NSRange)glyphRange atPoint:(NSPoint)point font:(NSFont *)font color:(NSColor *)color printingAdjustment:(NSSize)printingAdjustment;
    
- (void)showAttachmentCell:(NSCell *)cell inRect:(NSRect)rect characterIndex:(unsigned)attachmentIndex;
   
- (void)drawUnderlineForGlyphRange:(NSRange)glyphRange underlineType:(int)underlineVal baselineOffset:(float)baselineOffset lineFragmentRect:(NSRect)lineRect lineFragmentGlyphRange:(NSRange)lineGlyphRange containerOrigin:(NSPoint)containerOrigin;
- (void)underlineGlyphRange:(NSRange)glyphRange underlineType:(int)underlineVal lineFragmentRect:(NSRect)lineRect lineFragmentGlyphRange:(NSRange)lineGlyphRange containerOrigin:(NSPoint)containerOrigin;
    
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)drawStrikethroughForGlyphRange:(NSRange)glyphRange strikethroughType:(int)strikethroughVal baselineOffset:(float)baselineOffset lineFragmentRect:(NSRect)lineRect lineFragmentGlyphRange:(NSRange)lineGlyphRange containerOrigin:(NSPoint)containerOrigin;
- (void)strikethroughGlyphRange:(NSRange)glyphRange strikethroughType:(int)strikethroughVal lineFragmentRect:(NSRect)lineRect lineFragmentGlyphRange:(NSRange)lineGlyphRange containerOrigin:(NSPoint)containerOrigin;
    #endif

|#
#| @INTERFACE 
NSObject (NSLayoutManagerDelegate)

- (void)layoutManagerDidInvalidateLayout:(NSLayoutManager *)sender;
    
- (void)layoutManager:(NSLayoutManager *)layoutManager didCompleteLayoutForTextContainer:(NSTextContainer *)textContainer atEnd:(BOOL)layoutFinishedFlag;
    
|#

(provide-interface "NSLayoutManager")