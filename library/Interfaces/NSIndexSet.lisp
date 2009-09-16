(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSIndexSet.h"
; at Sunday July 2,2006 7:30:50 pm.
; 	NSIndexSet.h
; 	Copyright (c) 2002-2003, Apple, Inc. All rights reserved.
; 
;  Class for managing set of indexes. The set of valid indexes are 0 .. NSNotFound - 1; trying to use indexes outside this range is an error.  NSIndexSet uses NSNotFound as a return value in cases where the queried index doesn't exist in the set; for instance, when you ask firstIndex and there are no indexes; or when you ask for indexGreaterThanIndex: on the last index, and so on.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSRange.h>

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
#| @INTERFACE 
NSIndexSet : NSObject <NSCopying, NSMutableCopying, NSCoding> {
protected       struct {
        unsigned int _isEmpty:1;
        unsigned int _hasSingleRange:1;
        unsigned int _cacheValid:1;
        unsigned int _reservedArrayBinderController:29;
    } _indexSetFlags;
    union {
        struct {
            NSRange _range;
        } _singleRange;
        struct {
            void *_data;
            void *_reserved;
        } _multipleRanges;
    } _internal;
}

+ (id)indexSet;
+ (id)indexSetWithIndex:(unsigned int)value;
+ (id)indexSetWithIndexesInRange:(NSRange)range;

- (id)init;
- (id)initWithIndex:(unsigned int)value;
- (id)initWithIndexesInRange:(NSRange)range;   - (id)initWithIndexSet:(NSIndexSet *)indexSet;   
- (BOOL)isEqualToIndexSet:(NSIndexSet *)indexSet;

- (unsigned int)count;


- (unsigned int)firstIndex;
- (unsigned int)lastIndex;
- (unsigned int)indexGreaterThanIndex:(unsigned int)value;
- (unsigned int)indexLessThanIndex:(unsigned int)value;
- (unsigned int)indexGreaterThanOrEqualToIndex:(unsigned int)value;
- (unsigned int)indexLessThanOrEqualToIndex:(unsigned int)value;


- (unsigned int)getIndexes:(unsigned int *)indexBuffer maxCount:(unsigned int)bufferSize inIndexRange:(NSRangePointer)range;

- (BOOL)containsIndex:(unsigned int)value;
- (BOOL)containsIndexesInRange:(NSRange)range;
- (BOOL)containsIndexes:(NSIndexSet *)indexSet;

- (BOOL)intersectsIndexesInRange:(NSRange)range;

|#
#| @INTERFACE 
NSMutableIndexSet : NSIndexSet {
    void *_reserved;
}

- (void)addIndexes:(NSIndexSet *)indexSet;
- (void)removeIndexes:(NSIndexSet *)indexSet;
- (void)removeAllIndexes;
- (void)addIndex:(unsigned int)value;
- (void)removeIndex:(unsigned int)value;
- (void)addIndexesInRange:(NSRange)range;
- (void)removeIndexesInRange:(NSRange)range;


- (void)shiftIndexesStartingAtIndex:(unsigned int)index by:(int)delta;   

|#

; #endif


(provide-interface "NSIndexSet")