(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSScriptCommandDescription.h"
; at Sunday July 2,2006 7:30:58 pm.
; 	NSScriptCommandDescription.h
; 	Copyright (c) 1997-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSScriptCommandDescription : NSObject <NSCoding> {
    private
    NSString *_suiteName;
    NSString *_commandName;
    unsigned long _appleEventCode;
    unsigned long _appleEventClassCode;
    NSString *_commandClassName;
    NSString *_returnType;
    NSDictionary *_arguments;
    unsigned long _resultAppleEventCode;
}

- (id)initWithSuiteName:(NSString *)suiteName commandName:(NSString *)commandName dictionary:(NSDictionary *)commandDefDict;

- (NSString *)suiteName;
- (NSString *)commandName;
- (unsigned long)appleEventCode;
- (unsigned long)appleEventClassCode;

- (NSString *)commandClassName;

- (NSString *)returnType;
- (unsigned long)appleEventCodeForReturnType;

- (NSArray *)argumentNames;
- (NSString *)typeForArgumentWithName:(NSString *)argName;
- (BOOL)isOptionalArgumentWithName:(NSString *)argName;
- (unsigned long)appleEventCodeForArgumentWithName:(NSString *)argName;

- (NSScriptCommand *)createCommandInstance;
- (NSScriptCommand *)createCommandInstanceWithZone:(NSZone *)zone;

|#

(provide-interface "NSScriptCommandDescription")