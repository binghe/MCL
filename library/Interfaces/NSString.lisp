(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSString.h"
; at Sunday July 2,2006 7:31:01 pm.
; 	NSString.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

(def-mactype :unichar (find-mactype ':UInt16))

; #import <limits.h>

; #import <Foundation/NSObject.h>

; #import <Foundation/NSRange.h>

; #import <stdarg.h>
(def-mactype :NSParseErrorException (find-mactype '(:pointer :NSString)))
;  raised by -propertyList
(defconstant $NSMaximumStringLength 2147483646)
; #define NSMaximumStringLength	(INT_MAX-1)
;  These options apply to the various search/find and comparison methods (except where noted).
; 

(defconstant $NSCaseInsensitiveSearch 1)
(defconstant $NSLiteralSearch 2)                ;  Exact character-by-character equivalence 

(defconstant $NSBackwardsSearch 4)              ;  Search from end of source string 

(defconstant $NSAnchoredSearch 8)               ;  Search is limited to start (or end, if NSBackwardsSearch) of source string 

(defconstant $NSNumericSearch 64)               ;  Added in 10.2; Numbers within strings are compared using numeric value, that is, Foo2.txt < Foo7.txt < Foo25.txt; only applies to compare methods, not find 

;  Note that in addition to the values explicitly listed below, NSStringEncoding supports encodings provided by CFString.
; See CFStringEncodingExt.h for a list of these encodings.
; See CFString.h for functions which convert between NSStringEncoding and CFStringEncoding.
; 

(def-mactype :NSStringEncoding (find-mactype ':UInt32))

(defconstant $NSASCIIStringEncoding 1)          ;  0..127 only 

(defconstant $NSNEXTSTEPStringEncoding 2)
(defconstant $NSJapaneseEUCStringEncoding 3)
(defconstant $NSUTF8StringEncoding 4)
(defconstant $NSISOLatin1StringEncoding 5)
(defconstant $NSSymbolStringEncoding 6)
(defconstant $NSNonLossyASCIIStringEncoding 7)
(defconstant $NSShiftJISStringEncoding 8)
(defconstant $NSISOLatin2StringEncoding 9)
(defconstant $NSUnicodeStringEncoding 10)
(defconstant $NSWindowsCP1251StringEncoding 11) ;  Cyrillic; same as AdobeStandardCyrillic 

(defconstant $NSWindowsCP1252StringEncoding 12) ;  WinLatin1 

(defconstant $NSWindowsCP1253StringEncoding 13) ;  Greek 

(defconstant $NSWindowsCP1254StringEncoding 14) ;  Turkish 

(defconstant $NSWindowsCP1250StringEncoding 15) ;  WinLatin2 

(defconstant $NSISO2022JPStringEncoding 21)     ;  ISO 2022 Japanese encoding for e-mail 

(defconstant $NSMacOSRomanStringEncoding 30)
(defconstant $NSProprietaryStringEncoding #x10000);  Installation-specific encoding 

(def-mactype :NSCharacterConversionException (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSString : NSObject <NSCopying, NSMutableCopying, NSCoding>

- (unsigned int)length;			
- (unichar)characterAtIndex:(unsigned)index;

|#
#| @INTERFACE 
NSString (NSStringExtensionMethods)

- (void)getCharacters:(unichar *)buffer;
- (void)getCharacters:(unichar *)buffer range:(NSRange)aRange;

- (NSString *)substringFromIndex:(unsigned)from;
- (NSString *)substringToIndex:(unsigned)to;
- (NSString *)substringWithRange:(NSRange)range;

- (NSComparisonResult)compare:(NSString *)string;
- (NSComparisonResult)compare:(NSString *)string options:(unsigned)mask;
- (NSComparisonResult)compare:(NSString *)string options:(unsigned)mask range:(NSRange)compareRange;
- (NSComparisonResult)compare:(NSString *)string options:(unsigned)mask range:(NSRange)compareRange locale:(NSDictionary *)dict;
- (NSComparisonResult)caseInsensitiveCompare:(NSString *)string;
- (NSComparisonResult)localizedCompare:(NSString *)string;
- (NSComparisonResult)localizedCaseInsensitiveCompare:(NSString *)string;

- (BOOL)isEqualToString:(NSString *)aString;

- (BOOL)hasPrefix:(NSString *)aString;
- (BOOL)hasSuffix:(NSString *)aString;
- (NSRange)rangeOfString:(NSString *)aString;
- (NSRange)rangeOfString:(NSString *)aString options:(unsigned)mask;
- (NSRange)rangeOfString:(NSString *)aString options:(unsigned)mask range:(NSRange)searchRange;

- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)aSet;
- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)aSet options:(unsigned int)mask;
- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)aSet options:(unsigned int)mask range:(NSRange)searchRange;

- (NSRange)rangeOfComposedCharacterSequenceAtIndex:(unsigned)index;

- (NSString *)stringByAppendingString:(NSString *)aString;
- (NSString *)stringByAppendingFormat:(NSString *)format, ...;

- (double)doubleValue;
- (float)floatValue;
- (int)intValue;

- (NSArray *)componentsSeparatedByString:(NSString *)separator;

- (NSString *)commonPrefixWithString:(NSString *)aString options:(unsigned)mask;

- (NSString *)uppercaseString;
- (NSString *)lowercaseString;
- (NSString *)capitalizedString;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (NSString *)stringByTrimmingCharactersInSet:(NSCharacterSet *)set;
- (NSString *)stringByPaddingToLength:(unsigned)newLength withString:(NSString *)padString startingAtIndex:(unsigned)padIndex;
#endif

- (void)getLineStart:(unsigned *)startPtr end:(unsigned *)lineEndPtr contentsEnd:(unsigned *)contentsEndPtr forRange:(NSRange)range;
- (NSRange)lineRangeForRange:(NSRange)range;

#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (void)getParagraphStart:(unsigned *)startPtr end:(unsigned *)parEndPtr contentsEnd:(unsigned *)contentsEndPtr forRange:(NSRange)range;
- (NSRange)paragraphRangeForRange:(NSRange)range;
#endif

- (NSString *)description;

- (unsigned)hash;

- (NSStringEncoding)fastestEncoding;
- (NSStringEncoding)smallestEncoding;

- (NSData *)dataUsingEncoding:(NSStringEncoding)encoding allowLossyConversion:(BOOL)lossy;
- (NSData *)dataUsingEncoding:(NSStringEncoding)encoding;

- (BOOL)canBeConvertedToEncoding:(NSStringEncoding)encoding;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (NSString *)decomposedStringWithCanonicalMapping;
- (NSString *)precomposedStringWithCanonicalMapping;
- (NSString *)decomposedStringWithCompatibilityMapping;
- (NSString *)precomposedStringWithCompatibilityMapping;
#endif

- (const char *)UTF8String;	

- (const char *)cString;		- (const char *)lossyCString;
- (unsigned)cStringLength;		- (void)getCString:(char *)bytes;	- (void)getCString:(char *)bytes maxLength:(unsigned)maxLength;		- (void)getCString:(char *)bytes maxLength:(unsigned)maxLength range:(NSRange)aRange remainingRange:(NSRangePointer)leftoverRange;	+ (NSStringEncoding)defaultCStringEncoding;	

- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
- (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically; 
+ (const NSStringEncoding *)availableStringEncodings;
+ (NSString *)localizedNameOfStringEncoding:(NSStringEncoding)encoding;


+ (id)string;
+ (id)stringWithString:(NSString *)string;
+ (id)stringWithCharacters:(const unichar *)characters length:(unsigned)length;
+ (id)stringWithCString:(const char *)bytes length:(unsigned)length;
+ (id)stringWithCString:(const char *)bytes;
+ (id)stringWithUTF8String:(const char *)bytes;
+ (id)stringWithFormat:(NSString *)format, ...;
+ (id)stringWithContentsOfFile:(NSString *)path;
+ (id)stringWithContentsOfURL:(NSURL *)url;
+ (id)localizedStringWithFormat:(NSString *)format, ...;

- (id)init;
- (id)initWithCharactersNoCopy:(unichar *)characters length:(unsigned)length freeWhenDone:(BOOL)freeBuffer;	
- (id)initWithCharacters:(const unichar *)characters length:(unsigned)length;
- (id)initWithBytes:(const void *)bytes length:(unsigned)len encoding:(NSStringEncoding)encoding;
#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (id)initWithBytesNoCopy:(void *)bytes length:(unsigned)len encoding:(NSStringEncoding)encoding freeWhenDone:(BOOL)freeBuffer;	
#endif
- (id)initWithUTF8String:(const char *)bytes;
- (id)initWithString:(NSString *)aString;
- (id)initWithFormat:(NSString *)format, ...;
- (id)initWithFormat:(NSString *)format arguments:(va_list)argList;
- (id)initWithFormat:(NSString *)format locale:(NSDictionary *)dict, ...;
- (id)initWithFormat:(NSString *)format locale:(NSDictionary *)dict arguments:(va_list)argList;
- (id)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding;
- (id)initWithContentsOfFile:(NSString *)path;
- (id)initWithContentsOfURL:(NSURL *)url;

- (id)initWithCStringNoCopy:(char *)bytes length:(unsigned)length freeWhenDone:(BOOL)freeBuffer;	
- (id)initWithCString:(const char *)bytes length:(unsigned)length;	
- (id)initWithCString:(const char *)bytes;				

|#
#| @INTERFACE 
NSMutableString : NSString

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;

|#
#| @INTERFACE 
NSMutableString (NSMutableStringExtensionMethods)

- (void)insertString:(NSString *)aString atIndex:(unsigned)loc;
- (void)deleteCharactersInRange:(NSRange)range;
- (void)appendString:(NSString *)aString;
- (void)appendFormat:(NSString *)format, ...;
- (void)setString:(NSString *)aString;

+ (id)stringWithCapacity:(unsigned)capacity;
- (id)initWithCapacity:(unsigned)capacity;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (unsigned int)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(unsigned)opts range:(NSRange)searchRange;
#endif

|#
#| @INTERFACE 
NSString (NSExtendedStringPropertyListParsing)
    
- (id)propertyList;
- (NSDictionary *)propertyListFromStringsFileFormat;

|#
;  ***	The rest of this file is bookkeeping stuff that has to
;    ***	be here (for now). Don't use this stuff, don't refer to it.
; 

; #if !defined(_OBJC_UNICHAR_H_)
; #define _OBJC_UNICHAR_H_

; #endif

(defconstant $NS_UNICHAR_IS_EIGHT_BIT 0)
; #define NS_UNICHAR_IS_EIGHT_BIT 0
#| @INTERFACE 
NSSimpleCString : NSString {
protected
    char *bytes;
    unsigned int numBytes;
}
|#
#| @INTERFACE 
NSConstantString : NSSimpleCString
|#
(def-mactype :_NSConstantStringClassReference (find-mactype '(:pointer :void)))

(provide-interface "NSString")