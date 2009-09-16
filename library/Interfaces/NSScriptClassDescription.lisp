(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSScriptClassDescription.h"
; at Sunday July 2,2006 7:30:58 pm.
; 
; 	NSScriptClassDescription.h
; 	Copyright (c) 1997-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSClassDescription.h>
#| @INTERFACE 
NSScriptClassDescription : NSClassDescription {
    private
    NSString *_suiteName;
    NSString *_className;
    unsigned long _appleEventCode;
    NSString *_superclassName;
    NSDictionary *_attributes;
    NSDictionary *_toOneRelationships;
    NSDictionary *_toManyRelationships;
    NSDictionary *_supportedCommands;
    void *_privateVars;
}

- (id)initWithSuiteName:(NSString *)suiteName className:(NSString *)className dictionary:(NSDictionary *)dict;

- (NSString *)suiteName;
- (NSString *)className;

- (NSScriptClassDescription *)superclassDescription;

- (unsigned long)appleEventCode;

- (BOOL)matchesAppleEventCode:(unsigned long)code;
    
- (BOOL)supportsCommand:(NSScriptCommandDescription *)commandDef;
    
- (SEL)selectorForCommand:(NSScriptCommandDescription *)commandDef;
    
- (NSString *)typeForKey:(NSString *)key;
- (NSScriptClassDescription *)classDescriptionForKey:(NSString *)key;
- (unsigned long)appleEventCodeForKey:(NSString *)key;
- (BOOL)isReadOnlyKey:(NSString *)key;
    - (NSString *)keyWithAppleEventCode:(unsigned long)code;
    
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (NSString *)defaultSubcontainerAttributeKey;

- (BOOL)isLocationRequiredToCreateForKey:(NSString *)toManyRelationshipKey;

#endif

|#
#| @INTERFACE 
NSObject(NSScriptClassDescription)

- (NSString *)className;
- (unsigned long)classCode;

|#

(provide-interface "NSScriptClassDescription")