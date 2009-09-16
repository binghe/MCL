(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTypesetter.h"
; at Sunday July 2,2006 7:31:03 pm.
;  
; 	NSTypesetter.h
; 	Copyright (c) 1994-2003, Apple Computer, Inc.  All rights reserved. 
; 
; 	A concrete class to lay glyphs out in horizontal or vertical boxes	
; 

; #import <Foundation/NSObject.h>

; #import <AppKit/NSFont.h>

; #import <AppKit/NSText.h>	/* For NSTextAlignment */

; #import <AppKit/NSLayoutManager.h>
#| @INTERFACE 
NSTypesetter : NSObject {
    unsigned _reserved[2];
}


+ (id)sharedSystemTypesetter;


- (void)layoutGlyphsInLayoutManager:(NSLayoutManager *)layoutManager startingAtGlyphIndex:(unsigned)startGlyphIndex maxNumberOfLineFragments:(unsigned)maxNumLines nextGlyphIndex:(unsigned *)nextGlyph;


+ (NSSize)printingAdjustmentInLayoutManager:(NSLayoutManager *)layoutMgr forNominallySpacedGlyphRange:(NSRange)nominallySpacedGlyphsRange packedGlyphs:(const unsigned char *)packedGlyphs count:(unsigned)packedGlyphsCount;

- (float)baselineOffsetInLayoutManager:(NSLayoutManager *)layoutMgr glyphIndex:(unsigned)glyphIndex;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
+ (NSTypesetterBehavior)defaultTypesetterBehavior;
+ (id)sharedSystemTypesetterForBehavior:(NSTypesetterBehavior)theBehavior;
#endif
|#
(def-mactype :_NSLayoutStatus (find-mactype ':sint32))

(defconstant $NSLayoutNotDone 0)
(defconstant $NSLayoutDone 1)
(defconstant $NSLayoutCantFit 2)
(defconstant $NSLayoutOutOfGlyphs 3)
(def-mactype :NSLayoutStatus (find-mactype ':SINT32))
;  Determines how to lay a glyph out in relation to a previous glyph 
(def-mactype :_NSGlyphLayoutMode (find-mactype ':sint32))

(defconstant $NSGlyphLayoutAtAPoint 0)
(defconstant $NSGlyphLayoutAgainstAPoint 1)
(defconstant $NSGlyphLayoutWithPrevious 2)
(def-mactype :NSGlyphLayoutMode (find-mactype ':SINT32))
;  Layout direction 
(def-mactype :_NSLayoutDirection (find-mactype ':sint32))

(defconstant $NSLayoutLeftToRight 0)
(defconstant $NSLayoutRightToLeft 1)
(def-mactype :NSLayoutDirection (find-mactype ':SINT32))
; #define NSBaselineNotSet -1.0
(defconstant $NumGlyphsToGetEachTime 20)
; #define NumGlyphsToGetEachTime 20

(def-mactype :_NSPositionOfGlyphMethod (find-mactype ':pointer)); (NSFont * obj , SEL sel , NSGlyph cur , NSGlyph prev , BOOL * isNominal)
;  Cache structure used inside NSSimpleHorizontalTypesetter.
; 
(defrecord _NSTypesetterGlyphInfo
   (curLocation :_NSPOINT)
                                                ;  Location (relative to the baseline) for laying this glyph out 
   (extent :single-float)
                                                ;  Required space from curLocation to lay this glyph out; -1.0 if not set 
   (belowBaseline :single-float)
                                                ;  Distance from baseline to bottom of the line fragment required for all the glyphs so far, including this one (positive if baseline is above the bottom of the line fragment) 
   (aboveBaseline :single-float)
                                                ;  Distance from baseline to top of the line fragment required for all the glyphs so far, including this one (positive if baseline is below the top of the line fragment) 
   (glyphCharacterIndex :UInt32)
                                                ;  ...and its char index 
   (font (:pointer :nsfont))
                                                ;  ...and its font 
   (attachmentSize :_NSSIZE)
                                                ;  Size of the character if it's an attachment; otherwise meaningless 
   (defaultPositioning :UInt32)
                                                ;  This block needs to be "show"ed 
   (dontShow :UInt32)
                                                ;  Don't show this glyph 
   (isAttachment :UInt32)
                                                ;  Whether the glyph is an attachment 
)
(%define-record :NSTypesetterGlyphInfo (find-record-descriptor :_NSTYPESETTERGLYPHINFO))
;  Glyphs 0..curGlyphIndex-1 are valid in here 
;  Use this to access glyphs
; 
; #define NSGlyphInfoAtIndex(IX) ((NSTypesetterGlyphInfo *)((void *)glyphs + (sizeOfGlyphInfo * IX)))
;  A concrete class that does simple left-to-right typesetting with some support for non-spacing marks.
; 
#| @INTERFACE 
NSSimpleHorizontalTypesetter : NSTypesetter {

    
    NSLayoutManager *layoutManager;	
    NSTextStorage *textStorage;		

    
    unsigned firstGlyphIndex;		
    unsigned curGlyphIndex; 		
    unsigned firstInvalidGlyphIndex;	

    
    NSTypesetterGlyphInfo *glyphs;	
    NSGlyph *glyphCache;
    NSGlyphInscription *glyphInscriptionCache;
    unsigned *glyphCharacterIndexCache;
    BOOL *glyphElasticCache;

    NSSize glyphLocationOffset;		

    float curMaxGlyphLocation;		
    unsigned lastFixedGlyphIndex;	
    unsigned sizeOfGlyphInfo;

    
    NSGlyph curGlyph;
    NSGlyphInscription curGlyphInscription;
    unsigned curCharacterIndex;
private	
    unsigned previousGlyph;		
    unsigned previousBaseGlyphIndex;	
    unsigned previousBaseGlyph;		
    NSFont *previousFont;		
    float curGlyphOffset;		
    BOOL curGlyphOffsetOutOfDate;	
    BOOL curGlyphIsAControlGlyph;
    BOOL containerBreakAfterCurGlyph;   
    BOOL wrapAfterCurGlyph;		
    float curSpaceAfter;		
    float previousSpaceAfter;
    NSGlyphLayoutMode glyphLayoutMode;	
    float curGlyphExtentAboveLocation;	
    float curGlyphExtentBelowLocation;
    NSLayoutDirection curLayoutDirection;
    NSTextAlignment curTextAlignment;	

    
public
    NSFont *curFont;			
    NSRect curFontBoundingBox;		
    BOOL curFontIsFixedPitch;		
    NSPoint curFontAdvancement;		
    _NSPositionOfGlyphMethod curFontPositionOfGlyphMethod;	
private
    NSDictionary *attrs;	       	
    NSRange attrsRange;			
    float curBaselineOffset;		
    float curMinBaselineDistance;	
    float curMaxBaselineDistance;	
    int curSuperscript;			
    NSParagraphStyle *curParaStyle;	
    NSTextContainer *curContainer;
    unsigned curContainerIndex;
    float curContainerLineFragmentPadding;
    BOOL curContainerIsSimpleRectangular;	
    NSSize curContainerSize;		
    float curMinLineHeight;		
    float curMaxLineHeight;		
    
    
    NSString *textString;		

    
    unsigned capacityOfGlyphs;		

    BOOL busy;	

    struct {
	unsigned _glyphPostLay:1;
	unsigned _fragPostLay:1;
	unsigned _useItal:1;
        unsigned _curFontIsDefaultFace:1;
        unsigned _tabState:2;
        unsigned _tabType:2;
        unsigned _tabEOL:1;
	unsigned reserved:23;
    } _tsFlags;

public
    
    unsigned char *glyphBidiLevelCache;
    unsigned char curBidiLevel;		
    
private
    unsigned char previousBidiLevel;
    unsigned char _reservedChars[2];
    unsigned _reserved2[6];
}

+ (id)sharedInstance; 


- (NSLayoutManager *)currentLayoutManager;
- (NSTextContainer *)currentContainer;
- (NSParagraphStyle *)currentParagraphStyle;
- (NSTextStorage *)currentTextStorage;
- (NSTypesetterGlyphInfo *)baseOfTypesetterGlyphInfo;
- (unsigned)sizeOfTypesetterGlyphInfo;
- (unsigned)capacityOfTypesetterGlyphInfo;
- (unsigned)firstGlyphIndexOfCurrentLineFragment;


- (void)layoutGlyphsInLayoutManager:(NSLayoutManager *)layoutManager startingAtGlyphIndex:(unsigned)startGlyphIndex maxNumberOfLineFragments:(unsigned)maxNumLines nextGlyphIndex:(unsigned *)nextGlyph;


- (NSLayoutStatus)layoutGlyphsInHorizontalLineFragment:(NSRect *)lineFragmentRect baseline:(float *)baseline;


- (void)clearGlyphCache;
- (void)fillAttributesCache;
- (void)clearAttributesCache;


- (unsigned)growGlyphCaches:(unsigned)desiredCapacity fillGlyphInfo:(BOOL)fillGlyphInfo;


- (void)updateCurGlyphOffset;


- (void)insertGlyph:(NSGlyph)glyph atGlyphIndex:(unsigned)glyphIndex characterIndex:(unsigned)charIndex;

- (NSLayoutStatus)layoutControlGlyphForLineFragment:(NSRect)lineFrag;
- (void)layoutTab;

- (void)breakLineAtIndex:(unsigned)location;
- (unsigned)glyphIndexToBreakLineByHyphenatingWordAtIndex:(unsigned)charIndex;
- (unsigned)glyphIndexToBreakLineByWordWrappingAtIndex:(unsigned)charIndex;
- (void)layoutTab;
- (NSLayoutStatus)layoutControlGlyphForLineFragment:(NSRect)lineFrag;

- (void)fullJustifyLineAtGlyphIndex:(unsigned)glyphIndexForLineBreak;

|#
;  These methods can be OPTIONALLY implemented by subclasses of NSSimpleHorizontalTypesetter.
; 
#| @INTERFACE 
NSSimpleHorizontalTypesetter(NSTypesetterSubclassExtensions)


- (void)typesetterLaidOneGlyph:(NSTypesetterGlyphInfo *)gl;


- (void) willSetLineFragmentRect:(NSRect *)aRect forGlyphRange:(NSRange)aRange usedRect:(NSRect *)bRect;

|#

(provide-interface "NSTypesetter")