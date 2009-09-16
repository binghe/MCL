(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSSet.h"
; at Sunday July 2,2006 7:31:00 pm.
; 	NSSet.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
; ***************	Immutable Set	***************
#| @INTERFACE 
NSSet : NSObject <NSCopying, NSMutableCopying, NSCoding>

- (unsigned)count;
- (id)member:(id)object;
- (NSEnumerator *)objectEnumerator;

|#
#| @INTERFACE 
NSSet (NSExtendedSet)

- (NSArray *)allObjects;
- (id)anyObject;
- (BOOL)containsObject:(id)anObject;
- (NSString *)description;
- (NSString *)descriptionWithLocale:(NSDictionary *)locale;
- (BOOL)intersectsSet:(NSSet *)otherSet;
- (BOOL)isEqualToSet:(NSSet *)otherSet;
- (BOOL)isSubsetOfSet:(NSSet *)otherSet;

- (void)makeObjectsPerformSelector:(SEL)aSelector;
- (void)makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument;

|#
#| @INTERFACE 
NSSet (NSSetCreation)

+ (id)set;
+ (id)setWithArray:(NSArray *)array;
+ (id)setWithObject:(id)object;
+ (id)setWithObjects:(id)firstObj, ...;
- (id)initWithArray:(NSArray *)array;
- (id)initWithObjects:(id *)objects count:(unsigned)count;
- (id)initWithObjects:(id)firstObj, ...;
- (id)initWithSet:(NSSet *)set;
- (id)initWithSet:(NSSet *)set copyItems:(BOOL)flag;

+ (id)setWithSet:(NSSet *)set;
+ (id)setWithObjects:(id *)objs count:(unsigned)cnt;

|#
; ***************	Mutable Set	***************
#| @INTERFACE 
NSMutableSet : NSSet

- (void)addObject:(id)object;
- (void)removeObject:(id)object;

|#
#| @INTERFACE 
NSMutableSet (NSExtendedMutableSet)

- (void)addObjectsFromArray:(NSArray *)array;
- (void)intersectSet:(NSSet *)otherSet;
- (void)minusSet:(NSSet *)otherSet;
- (void)removeAllObjects;
- (void)unionSet:(NSSet *)otherSet;

- (void)setSet:(NSSet *)otherSet;

|#
#| @INTERFACE 
NSMutableSet (NSMutableSetCreation)

+ (id)setWithCapacity:(unsigned)numItems;
- (id)initWithCapacity:(unsigned)numItems;
    
|#
; ***************	Counted Set	***************
#| @INTERFACE 
NSCountedSet : NSMutableSet {
    private
    void *_table;
    void *_reserved;
}

- (id)initWithCapacity:(unsigned)numItems; 
- (id)initWithArray:(NSArray *)array;
- (id)initWithSet:(NSSet *)set;

- (unsigned)countForObject:(id)object;

- (NSEnumerator *)objectEnumerator;
- (void)addObject:(id)object;
- (void)removeObject:(id)object;

|#

(provide-interface "NSSet")