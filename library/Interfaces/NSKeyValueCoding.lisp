(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSKeyValueCoding.h"
; at Sunday July 2,2006 7:30:51 pm.
; 
; 	NSKeyValueCoding.h
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSArray.h>

; #import <Foundation/NSDictionary.h>
;  The exception that is thrown when a key value coding operation fails.  The exception's user info dictionary will contain at least two entries:
;  @"NSTargetObjectUserInfoKey": the receiver of the failed KVC message.
;  @"NSUnknownUserInfoKey": the key that was used in the failed KVC message.
(def-mactype :NSUndefinedKeyException (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSObject(NSKeyValueCoding)

+ (BOOL)accessInstanceVariablesDirectly;

- (id)valueForKey:(NSString *)key;

#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (void)setValue:(id)value forKey:(NSString *)key;

- (BOOL)validateValue:(id *)ioValue forKey:(NSString *)inKey error:(NSError **)outError;

- (NSMutableArray *)mutableArrayValueForKey:(NSString *)key;

#endif

- (id)valueForKeyPath:(NSString *)keyPath;
- (void)setValue:(id)value forKeyPath:(NSString *)keyPath;
#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (BOOL)validateValue:(id *)ioValue forKeyPath:(NSString *)inKeyPath error:(NSError **)outError;
- (NSMutableArray *)mutableArrayValueForKeyPath:(NSString *)keyPath;
#endif

#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (id)valueForUndefinedKey:(NSString *)key;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

- (void)setNilValueForKey:(NSString *)key;

-(NSDictionary *)dictionaryWithValuesForKeys:(NSArray *)keys;

- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues;

#endif

+ (BOOL)useStoredAccessor;
- (id)storedValueForKey:(NSString *)key;
- (void)takeStoredValue:(id)value forKey:(NSString *)key;

|#

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
#| @INTERFACE 
NSArray(NSKeyValueCoding)

- (id)valueForKey:(NSString *)key;

- (void)setValue:(id)value forKey:(NSString *)key;

|#

; #endif

#| @INTERFACE 
NSDictionary(NSKeyValueCoding)

- (id)valueForKey:(NSString *)key;

|#

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
#| @INTERFACE 
NSMutableDictionary(NSKeyValueCoding)

- (void)setValue:(id)value forKey:(NSString *)key;

|#

; #endif

#| @INTERFACE 
NSObject(NSDeprecatedKeyValueCoding)

- (void)takeValue:(id)value forKey:(NSString *)key;
- (void)takeValue:(id)value forKeyPath:(NSString *)keyPath;
- (id)handleQueryWithUnboundKey:(NSString *)key;
- (void)handleTakeValue:(id)value forUnboundKey:(NSString *)key;
- (void)unableToSetNilForKey:(NSString *)key;
- (NSDictionary *)valuesForKeys:(NSArray *)keys;
- (void)takeValuesFromDictionary:(NSDictionary *)properties;

|#

(provide-interface "NSKeyValueCoding")