(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSArray.h"
; at Sunday July 2,2006 7:30:35 pm.
; 	NSArray.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSRange.h>
; ***************	Immutable Array		***************
#| @INTERFACE 
NSArray : NSObject <NSCopying, NSMutableCopying, NSCoding>

- (unsigned)count;
- (id)objectAtIndex:(unsigned)index;
    
|#
#| @INTERFACE 
NSArray (NSExtendedArray)

- (NSArray *)arrayByAddingObject:(id)anObject;
- (NSArray *)arrayByAddingObjectsFromArray:(NSArray *)otherArray;
- (NSString *)componentsJoinedByString:(NSString *)separator;
- (BOOL)containsObject:(id)anObject;
- (NSString *)description;
- (NSString *)descriptionWithLocale:(NSDictionary *)locale;
- (NSString *)descriptionWithLocale:(NSDictionary *)locale indent:(unsigned)level;
- (id)firstObjectCommonWithArray:(NSArray *)otherArray;
- (void)getObjects:(id *)objects;
- (void)getObjects:(id *)objects range:(NSRange)range;
- (unsigned)indexOfObject:(id)anObject;
- (unsigned)indexOfObject:(id)anObject inRange:(NSRange)range;
- (unsigned)indexOfObjectIdenticalTo:(id)anObject;
- (unsigned)indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
- (BOOL)isEqualToArray:(NSArray *)otherArray;
- (id)lastObject;
- (NSEnumerator *)objectEnumerator;
- (NSEnumerator *)reverseObjectEnumerator;
- (NSData *)sortedArrayHint;
- (NSArray *)sortedArrayUsingFunction:(int (*)(id, id, void *))comparator context:(void *)context;
- (NSArray *)sortedArrayUsingFunction:(int (*)(id, id, void *))comparator context:(void *)context hint:(NSData *)hint;
- (NSArray *)sortedArrayUsingSelector:(SEL)comparator;
- (NSArray *)subarrayWithRange:(NSRange)range;
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
- (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically;

- (void)makeObjectsPerformSelector:(SEL)aSelector;
- (void)makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument;

|#
#| @INTERFACE 
NSArray (NSArrayCreation)

+ (id)array;
+ (id)arrayWithContentsOfFile:(NSString *)path;
+ (id)arrayWithContentsOfURL:(NSURL *)url;
+ (id)arrayWithObject:(id)anObject;
+ (id)arrayWithObjects:(id)firstObj, ...;
- (id)initWithArray:(NSArray *)array;
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (id)initWithArray:(NSArray *)array copyItems:(BOOL)flag;
#endif
- (id)initWithContentsOfFile:(NSString *)path;
- (id)initWithContentsOfURL:(NSURL *)url;
- (id)initWithObjects:(id *)objects count:(unsigned)count;
- (id)initWithObjects:(id)firstObj, ...;

+ (id)arrayWithArray:(NSArray *)array;
+ (id)arrayWithObjects:(id *)objs count:(unsigned)cnt;

|#
; ***************	Mutable Array		***************
#| @INTERFACE 
NSMutableArray : NSArray

- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(unsigned)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(unsigned)index;
- (void)replaceObjectAtIndex:(unsigned)index withObject:(id)anObject;

|#
#| @INTERFACE 
NSMutableArray (NSExtendedMutableArray)
    
- (void)addObjectsFromArray:(NSArray *)otherArray;
- (void)exchangeObjectAtIndex:(unsigned)idx1 withObjectAtIndex:(unsigned)idx2;
- (void)removeAllObjects;
- (void)removeObject:(id)anObject inRange:(NSRange)range;
- (void)removeObject:(id)anObject;
- (void)removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
- (void)removeObjectIdenticalTo:(id)anObject;
- (void)removeObjectsFromIndices:(unsigned *)indices numIndices:(unsigned)count;
- (void)removeObjectsInArray:(NSArray *)otherArray;
- (void)removeObjectsInRange:(NSRange)range;
- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;
- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;
- (void)setArray:(NSArray *)otherArray;
- (void)sortUsingFunction:(int (*)(id, id, void *))compare context:(void *)context;
- (void)sortUsingSelector:(SEL)comparator;

|#
#| @INTERFACE 
NSMutableArray (NSMutableArrayCreation)

+ (id)arrayWithCapacity:(unsigned)numItems;
- (id)initWithCapacity:(unsigned)numItems;

|#

(provide-interface "NSArray")