(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSSortDescriptor.h"
; at Sunday July 2,2006 7:31:00 pm.
; 
; 	NSSortDescriptor.h
; 	Foundation
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSArray.h>

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
#| @INTERFACE 
NSSortDescriptor : NSObject <NSCoding, NSCopying> {
private
    struct __sortDescriptorFlags {
        unsigned int _ascending:1;
        unsigned int _reservedSortDescriptor:31;
    } _sortDescriptorFlags;
    NSString *_key;
    SEL _selector;
    NSString *_selectorName;
}

- (id)initWithKey:(NSString *)key ascending:(BOOL)ascending;
- (id)initWithKey:(NSString *)key ascending:(BOOL)ascending selector:(SEL)selector;

- (NSString *)key;
- (BOOL)ascending;
- (SEL)selector;

- (NSComparisonResult)compareObject:(id)object1 toObject:(id)object2;    - (id)reversedSortDescriptor;    
|#
#| @INTERFACE 
NSArray (NSSortDescriptorSorting)

- (NSArray *)sortedArrayUsingDescriptors:(NSArray *)sortDescriptors;    
|#
#| @INTERFACE 
NSMutableArray (NSSortDescriptorSorting)

- (void)sortUsingDescriptors:(NSArray *)sortDescriptors;    
|#

; #endif


(provide-interface "NSSortDescriptor")