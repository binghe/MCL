(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSScanner.h"
; at Sunday July 2,2006 7:30:58 pm.
; 	NSScanner.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSScanner : NSObject <NSCopying>

- (NSString *)string;
- (unsigned)scanLocation;
- (void)setScanLocation:(unsigned)pos;
- (void)setCharactersToBeSkipped:(NSCharacterSet *)set;
- (void)setCaseSensitive:(BOOL)flag;
- (void)setLocale:(NSDictionary *)dict;

|#
#| @INTERFACE 
NSScanner (NSExtendedScanner)

- (NSCharacterSet *)charactersToBeSkipped;
- (BOOL)caseSensitive;
- (NSDictionary *)locale;

- (BOOL)scanInt:(int *)value;
- (BOOL)scanHexInt:(unsigned *)value;		
- (BOOL)scanLongLong:(long long *)value;
- (BOOL)scanFloat:(float *)value;
- (BOOL)scanDouble:(double *)value;
- (BOOL)scanString:(NSString *)string intoString:(NSString **)value;
- (BOOL)scanCharactersFromSet:(NSCharacterSet *)set intoString:(NSString **)value;

- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)value;
- (BOOL)scanUpToCharactersFromSet:(NSCharacterSet *)set intoString:(NSString **)value;

- (BOOL)isAtEnd;

- (id)initWithString:(NSString *)string;
+ (id)scannerWithString:(NSString *)string;
+ (id)localizedScannerWithString:(NSString *)string;

|#

(provide-interface "NSScanner")