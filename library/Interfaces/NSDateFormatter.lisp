(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSDateFormatter.h"
; at Sunday July 2,2006 7:30:45 pm.
; 	NSDateFormatter.h
; 	Copyright (c) 1995-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSFormatter.h>
#| @INTERFACE 
NSDateFormatter : NSFormatter {
private
    NSString *_format;
    BOOL _naturalLanguage;
    char _unused[3];
    int _reserved;
}

- (id)initWithDateFormat:(NSString *)format allowNaturalLanguage:(BOOL)flag;
- (NSString *)dateFormat;
- (BOOL)allowsNaturalLanguage;

|#

(provide-interface "NSDateFormatter")