(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSClassDescription.h"
; at Sunday July 2,2006 7:30:38 pm.
; 	NSClassDescription.h
; 	Copyright (c) 1995-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSException.h>
#| @INTERFACE 
NSClassDescription : NSObject

+ (void)registerClassDescription:(NSClassDescription *)description forClass:(Class)aClass;
+ (void)invalidateClassDescriptionCache;
+ (NSClassDescription *)classDescriptionForClass:(Class)aClass;

- (NSArray *)attributeKeys;
- (NSArray *)toOneRelationshipKeys;
- (NSArray *)toManyRelationshipKeys;
- (NSString *)inverseForRelationshipKey:(NSString *)relationshipKey;

|#
#| @INTERFACE 
NSObject (NSClassDescriptionPrimitives)

- (NSClassDescription *)classDescription;
- (NSArray *)attributeKeys;
- (NSArray *)toOneRelationshipKeys;
- (NSArray *)toManyRelationshipKeys;
- (NSString *)inverseForRelationshipKey:(NSString *)relationshipKey;

|#
(def-mactype :NSClassDescriptionNeededForClassNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSClassDescription")