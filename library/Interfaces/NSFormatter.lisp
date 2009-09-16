(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSFormatter.h"
; at Sunday July 2,2006 7:30:48 pm.
; 	NSFormatter.h
; 	Copyright (c) 1995-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSRange.h>
#| @INTERFACE 
NSFormatter : NSObject <NSCopying, NSCoding>

- (NSString *)stringForObjectValue:(id)obj;

- (NSAttributedString *)attributedStringForObjectValue:(id)obj withDefaultAttributes:(NSDictionary *)attrs;

- (NSString *)editingStringForObjectValue:(id)obj;

- (BOOL)getObjectValue:(id *)obj forString:(NSString *)string errorDescription:(NSString **)error;

- (BOOL)isPartialStringValid:(NSString *)partialString newEditingString:(NSString **)newString errorDescription:(NSString **)error;
    
- (BOOL)isPartialStringValid:(NSString **)partialStringPtr proposedSelectedRange:(NSRangePointer)proposedSelRangePtr originalString:(NSString *)origString originalSelectedRange:(NSRange)origSelRange errorDescription:(NSString **)error;

|#

(provide-interface "NSFormatter")