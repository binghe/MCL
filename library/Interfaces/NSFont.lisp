(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSFont.h"
; at Sunday July 2,2006 7:30:48 pm.
; 
; 	NSFont.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSString.h>

; #import <Foundation/NSGeometry.h>

; #import <AppKit/AppKitDefines.h>

; #import <AppKit/NSCell.h>

(def-mactype :NSGlyph (find-mactype ':UInt32))

(defconstant $NSControlGlyph #xFFFFFF)
(defconstant $NSNullGlyph 0)
(def-mactype :_NSGlyphRelation (find-mactype ':sint32))

(defconstant $NSGlyphBelow 1)
(defconstant $NSGlyphAbove 2)
(def-mactype :NSGlyphRelation (find-mactype ':SINT32))
;  These are values that tell us how to extract glyphs from a font for making a multi-byte (or single byte) array of glyphs for passing to an interpreter, such as the window server, which expects a big-endian multi-byte stream (i.e., packed glyphs") instead of a pure NSGlyph stream.
; 
(def-mactype :_NSMultibyteGlyphPacking (find-mactype ':sint32))

(defconstant $NSOneByteGlyphPacking 0)
(defconstant $NSJapaneseEUCGlyphPacking 1)
(defconstant $NSAsciiWithDoubleByteEUCGlyphPacking 2)
(defconstant $NSTwoByteGlyphPacking 3)
(defconstant $NSFourByteGlyphPacking 4)
(defconstant $NSNativeShortGlyphPacking 5)
(def-mactype :NSMultibyteGlyphPacking (find-mactype ':SINT32))
(def-mactype :NSFontIdentityMatrix (find-mactype '(:pointer :float)))
#| @INTERFACE 
NSFont : NSObject <NSCopying, NSCoding> {

    NSString *_name;
    float _size;
    void *_reservedFont1;
    struct __fFlags {
      
	unsigned int isScreenFont:1;
	unsigned int _systemFontType:4;
	unsigned int _RESERVED:8;
	unsigned int _matrixIsIdentity:1;
	unsigned int _matrixIsFlipped:1;
	unsigned int _hasStyle:1;
    } _fFlags;
    unsigned short _reservedFont2;
}

+ (NSFont *)fontWithName:(NSString *)fontName size:(float)fontSize;
+ (NSFont *)fontWithName:(NSString *)fontName matrix:(const float *)fontMatrix;
+ (void)useFont:(NSString *)fontName;


+ (NSFont *)userFontOfSize:(float)fontSize;	+ (NSFont *)userFixedPitchFontOfSize:(float)fontSize; + (void)setUserFont:(NSFont *)aFont;	+ (void)setUserFixedPitchFont:(NSFont *)aFont; 

+ (NSFont *)systemFontOfSize:(float)fontSize;	+ (NSFont *)boldSystemFontOfSize:(float)fontSize; + (NSFont *)labelFontOfSize:(float)fontSize; 
+ (float) systemFontSize;	+ (float) smallSystemFontSize;	+ (float) labelFontSize;	
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
+ (float)systemFontSizeForControlSize:(NSControlSize)controlSize;
#endif


+ (NSFont *)titleBarFontOfSize:(float)fontSize;
+ (NSFont *)menuFontOfSize:(float)fontSize;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
+ (NSFont *)menuBarFontOfSize:(float)fontSize;
#endif
+ (NSFont *)messageFontOfSize:(float)fontSize;
+ (NSFont *)paletteFontOfSize:(float)fontSize;
+ (NSFont *)toolTipsFontOfSize:(float)fontSize;
+ (NSFont *)controlContentFontOfSize:(float)fontSize;

- (float)pointSize;
- (NSString *)fontName;
- (NSString *)familyName;
- (NSString *)displayName;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (NSFontDescriptor *)fontDescriptor;
#endif


- (const float *)matrix;
- (void)set;
- (float)widthOfString:(NSString *)string;
- (NSFont *)screenFont;
- (NSFont *)printerFont;

- (BOOL)isBaseFont; 

- (NSRect)boundingRectForFont;
- (float) defaultLineHeightForFont; - (NSRect)boundingRectForGlyph:(NSGlyph)aGlyph;
- (NSSize)advancementForGlyph:(NSGlyph)ag;
- (NSDictionary *)afmDictionary; - (BOOL)glyphIsEncoded:(NSGlyph)aGlyph;

+ (NSArray *)preferredFontNames;
+ (void)setPreferredFontNames:(NSArray *)fontNameArray;

- (NSSize) maximumAdvancement; - (NSStringEncoding) mostCompatibleStringEncoding;

- (unsigned) numberOfGlyphs;	
- (float) underlinePosition;	
- (float) underlineThickness;	
- (float) italicAngle;	
- (float) capHeight;	
- (float) xHeight;
- (float) ascender;
- (float) descender;
- (BOOL) isFixedPitch;
- (NSString *) encodingScheme;
- (NSGlyph) glyphWithName:(NSString *)aName;




- (NSPoint)positionOfGlyph:(NSGlyph)curGlyph precededByGlyph:(NSGlyph)prevGlyph isNominal:(BOOL *)nominal;


- (int) positionsForCompositeSequence:(NSGlyph *)someGlyphs numberOfGlyphs:(int)numGlyphs pointArray:(NSPointArray)points;


- (NSPoint)positionOfGlyph:(NSGlyph)curGlyph struckOverGlyph:(NSGlyph)prevGlyph metricsExist:(BOOL *)exist;


- (NSPoint)positionOfGlyph:(NSGlyph)aGlyph struckOverRect:(NSRect)aRect metricsExist:(BOOL *)exist;


- (NSPoint)positionOfGlyph:(NSGlyph)aGlyph forCharacter:(unichar)aChar struckOverRect:(NSRect)aRect;


- (NSPoint)positionOfGlyph:(NSGlyph)thisGlyph withRelation:(NSGlyphRelation)rel toBaseGlyph:(NSGlyph)baseGlyph totalAdvancement:(NSSizePointer)adv metricsExist:(BOOL *)exist;


- (NSMultibyteGlyphPacking) glyphPacking;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (NSCharacterSet *)coveredCharacterSet;
#endif
|#
;  Take a buffer of NSGlyphs, of some given length, and a packing type, and a place to put some packed glyphs.  Pack up the NSGlyphs according to the NSMultibyteGlyphPacking, null-terminate the bytes, and then put them into the output buffer.  Return the count of bytes output, including the null-terminator.  The output buffer (packedGlyphs) provided by the caller is guaranteed to be at least "count*4+1" bytes long.
; 

(deftrap-inline "_NSConvertGlyphsToPackedGlyphs" 
   ((glBuf (:pointer :NSGLYPH))
    (count :signed-long)
    (packing :SInt32)
    (packedGlyphs (:pointer :char))
   )
   :signed-long
() )
;  These are the strings that are available in the "afmDictionary".  For other things, use "afmFileContents".  The floating point values (e.g., ascender, cap height) can be converted to floating point via NSString's "floatValue" method.
; 
(def-mactype :NSAFMFamilyName (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMFontName (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMFormatVersion (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMFullName (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMNotice (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMVersion (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMWeight (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMEncodingScheme (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMCharacterSet (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMCapHeight (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMXHeight (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMAscender (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMDescender (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMUnderlinePosition (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMUnderlineThickness (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMItalicAngle (find-mactype '(:pointer :NSString)))
(def-mactype :NSAFMMappingScheme (find-mactype '(:pointer :NSString)))

(provide-interface "NSFont")