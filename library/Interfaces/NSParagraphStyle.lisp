(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSParagraphStyle.h"
; at Sunday July 2,2006 7:30:55 pm.
; 
;         NSParagraphStyle.h
;         Copyright (c) 1994-2003, Apple Computer, Inc.  All rights reserved.
; 
; 	NSParagraphStyle and NSMutableParagraphStyle hold paragraph style information
; 	NSTextTab holds information about a single tab stop
; 

; #import <Foundation/NSObject.h>

; #import <AppKit/NSText.h>
(def-mactype :_NSTextTabType (find-mactype ':sint32))

(defconstant $NSLeftTabStopType 0)
(defconstant $NSRightTabStopType 1)
(defconstant $NSCenterTabStopType 2)
(defconstant $NSDecimalTabStopType 3)
(def-mactype :NSTextTabType (find-mactype ':SINT32))
(def-mactype :_NSLineBreakMode (find-mactype ':sint32))
;  What to do with long lines 

(defconstant $NSLineBreakByWordWrapping 0)      ;  Wrap at word boundaries, default 

(defconstant $NSLineBreakByCharWrapping 1)      ;  Wrap at character boundaries 

(defconstant $NSLineBreakByClipping 2)          ;  Simply clip 

(defconstant $NSLineBreakByTruncatingHead 3)    ;  Truncate at head of line: "...wxyz" 

(defconstant $NSLineBreakByTruncatingTail 4)    ;  Truncate at tail of line: "abcd..." 
;  Truncate middle of line:  "ab...yz" 

(defconstant $NSLineBreakByTruncatingMiddle 5)
(def-mactype :NSLineBreakMode (find-mactype ':SINT32))
(def-mactype :_NSWritingDirection (find-mactype ':sint32))

(defconstant $NSWritingDirectionLeftToRight 0)  ;  Left to right writing direction 
;  Right to left writing direction 

(defconstant $NSWritingDirectionRightToLeft 1)
(def-mactype :NSWritingDirection (find-mactype ':SINT32))

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  An attribute for NSTextTab options.  The value is NSCharacterSet.  The character set is used to determine the tab column terminating character.  The tab itself and newline characters are implied even if non-existent in the character set.
; 
(def-mactype :NSTabColumnTerminatorsAttributeName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER

; #endif /* MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED */

#| @INTERFACE 
NSTextTab : NSObject <NSCopying, NSCoding> {
    
    struct {
	NSTextAlignment alignment:4;
        unsigned int refCount:24;
        unsigned int unused:4;
    } _flags;
    float _location;
    void *_reserved;
}

#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (id)initWithTextAlignment:(NSTextAlignment)alignment location:(float)loc options:(NSDictionary *)options;

- (NSTextAlignment)alignment;
- (NSDictionary *)options;
#endif 
- (id)initWithType:(NSTextTabType)type location:(float)loc;
- (float)location;
- (NSTextTabType)tabStopType;
|#
#| @INTERFACE 
NSParagraphStyle : NSObject <NSCopying, NSMutableCopying, NSCoding> {
    
    float _lineSpacing;
    float _paragraphSpacing;
    float _headIndent;
    float _tailIndent;
    float _firstLineHeadIndent;
    float _minimumLineHeight;
    float _maximumLineHeight;
    NSArray *_tabStops;
    struct {
	NSTextAlignment alignment:4;
        NSLineBreakMode lineBreakMode:4;
        unsigned int tabStopsIsMutable:1;
        unsigned int isNaturalDirection:1;
        unsigned int rightToLeftDirection:1;
        unsigned int fixedMultiple:2;
        unsigned int refCount:19;
    } _flags;
    float _defaultTabInterval;
    void *_extraData;
}

+ (NSParagraphStyle *)defaultParagraphStyle;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
+ (NSWritingDirection)defaultWritingDirectionForLanguage:(NSString *)languageName;  #endif

- (float)lineSpacing;		
- (float)paragraphSpacing; 	
- (NSTextAlignment)alignment;


   
- (float)headIndent;		
- (float)tailIndent;		
- (float)firstLineHeadIndent;	
- (NSArray *)tabStops;		

- (float)minimumLineHeight;	
- (float)maximumLineHeight;	 

- (NSLineBreakMode)lineBreakMode;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (NSWritingDirection)baseWritingDirection;
#endif

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (float)lineHeightMultiple;	
- (float)paragraphSpacingBefore;
- (float)defaultTabInterval;	 
#endif

|#
#| @INTERFACE 
NSMutableParagraphStyle : NSParagraphStyle

- (void)setLineSpacing:(float)aFloat;
- (void)setParagraphSpacing:(float)aFloat;
- (void)setAlignment:(NSTextAlignment)alignment;
- (void)setFirstLineHeadIndent:(float)aFloat;
- (void)setHeadIndent:(float)aFloat;
- (void)setTailIndent:(float)aFloat;
- (void)setLineBreakMode:(NSLineBreakMode)mode;
- (void)setMinimumLineHeight:(float)aFloat;
- (void)setMaximumLineHeight:(float)aFloat;
- (void)addTabStop:(NSTextTab *)anObject;
- (void)removeTabStop:(NSTextTab *)anObject;
- (void)setTabStops:(NSArray *)array;
- (void)setParagraphStyle:(NSParagraphStyle *)obj;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (void)setBaseWritingDirection:(NSWritingDirection)writingDirection;
#endif
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)setLineHeightMultiple:(float)aFloat;
- (void)setParagraphSpacingBefore:(float)aFloat;
- (void)setDefaultTabInterval:(float)aFloat;
#endif
|#

(provide-interface "NSParagraphStyle")