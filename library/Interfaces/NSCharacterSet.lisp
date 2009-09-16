(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSCharacterSet.h"
; at Sunday July 2,2006 7:30:38 pm.
; 	NSCharacterSet.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <CoreFoundation/CFCharacterSet.h>

; #import <Foundation/NSObject.h>

; #import <Foundation/NSRange.h>

; #import <Foundation/NSString.h>

(defconstant $NSOpenStepUnicodeReservedBase #xF400)
#| @INTERFACE 
NSCharacterSet : NSObject <NSCopying, NSMutableCopying, NSCoding>

+ (NSCharacterSet *)controlCharacterSet;
+ (NSCharacterSet *)whitespaceCharacterSet;
+ (NSCharacterSet *)whitespaceAndNewlineCharacterSet;
+ (NSCharacterSet *)decimalDigitCharacterSet;
+ (NSCharacterSet *)letterCharacterSet;
+ (NSCharacterSet *)lowercaseLetterCharacterSet;
+ (NSCharacterSet *)uppercaseLetterCharacterSet;
+ (NSCharacterSet *)nonBaseCharacterSet;
+ (NSCharacterSet *)alphanumericCharacterSet;
+ (NSCharacterSet *)decomposableCharacterSet;
+ (NSCharacterSet *)illegalCharacterSet;
+ (NSCharacterSet *)punctuationCharacterSet;
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
+ (NSCharacterSet *)capitalizedLetterCharacterSet;
#endif
#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
+ (NSCharacterSet *)symbolCharacterSet;
#endif

+ (NSCharacterSet *)characterSetWithRange:(NSRange)aRange;
+ (NSCharacterSet *)characterSetWithCharactersInString:(NSString *)aString;
+ (NSCharacterSet *)characterSetWithBitmapRepresentation:(NSData *)data;
+ (NSCharacterSet *)characterSetWithContentsOfFile:(NSString *)fName;

- (BOOL)characterIsMember:(unichar)aCharacter;
- (NSData *)bitmapRepresentation;
- (NSCharacterSet *)invertedSet;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (BOOL)longCharacterIsMember:(UTF32Char)theLongChar;

- (BOOL)isSupersetOfSet:(NSCharacterSet *)theOtherSet;
- (BOOL)hasMemberInPlane:(uint8_t)thePlane;
#endif
|#
#| @INTERFACE 
NSMutableCharacterSet : NSCharacterSet <NSCopying, NSMutableCopying>

- (void)addCharactersInRange:(NSRange)aRange;
- (void)removeCharactersInRange:(NSRange)aRange;
- (void)addCharactersInString:(NSString *)aString;
- (void)removeCharactersInString:(NSString *)aString;
- (void)formUnionWithCharacterSet:(NSCharacterSet *)otherSet;
- (void)formIntersectionWithCharacterSet:(NSCharacterSet *)otherSet;
- (void)invert;

|#

(provide-interface "NSCharacterSet")