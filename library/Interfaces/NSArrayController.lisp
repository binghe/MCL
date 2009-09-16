(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSArrayController.h"
; at Sunday July 2,2006 7:30:35 pm.
; 
; 	NSArrayController.h
; 	Application Kit
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
;  

; #import <AppKit/NSObjectController.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
#| @INTERFACE 
NSArrayController : NSObjectController {
private
	void *_reserved5;
	void *_reserved6;
	void *_reserved7;
    struct __arrayControllerFlags {
        unsigned int _avoidsEmptySelection:1;
        unsigned int _preservesSelection:1;
        unsigned int _selectsInsertedObjects:1;
        unsigned int _refreshesAllModelObjects:1;
        unsigned int _filterRestrictsInsertion:1;
        unsigned int _overridesArrangeObjects:1;
        unsigned int _explicitlyCannotInsert:1;
        unsigned int _generatedEmptyArray:1;
        unsigned int _isObservingKeyPathsThroughArrangedObjects:1;
        unsigned int _reservedArrayController:23;
    } _arrayControllerFlags;
    NSArray *_sortDescriptors;
    NSMutableIndexSet *_selectionIndexes;
    unsigned int _observedIndexHint;
    NSMutableArray *_objects;
    NSMutableArray *_selectedObjects;
    NSArray *_arrangedObjects;
}

- (void)rearrangeObjects;    - (void)setSortDescriptors:(NSArray *)sortDescriptors;
- (NSArray *)sortDescriptors;
- (NSArray *)arrangeObjects:(NSArray *)objects;    - (id)arrangedObjects;     

- (void)setAvoidsEmptySelection:(BOOL)flag;    - (BOOL)avoidsEmptySelection;
- (void)setPreservesSelection:(BOOL)flag;    - (BOOL)preservesSelection;
- (void)setSelectsInsertedObjects:(BOOL)flag;    - (BOOL)selectsInsertedObjects;

- (BOOL)setSelectionIndexes:(NSIndexSet *)indexes;    - (NSIndexSet *)selectionIndexes;
- (BOOL)setSelectionIndex:(unsigned int)index;
- (unsigned int)selectionIndex;
- (BOOL)addSelectionIndexes:(NSIndexSet *)indexes;
- (BOOL)removeSelectionIndexes:(NSIndexSet *)indexes;

- (BOOL)setSelectedObjects:(NSArray *)objects;
- (NSArray *)selectedObjects;
- (BOOL)addSelectedObjects:(NSArray *)objects;
- (BOOL)removeSelectedObjects:(NSArray *)objects;

- (void)insert:(id)sender;
- (BOOL)canInsert;    - (void)selectNext:(id)sender;
- (void)selectPrevious:(id)sender;
- (BOOL)canSelectNext;
- (BOOL)canSelectPrevious;

- (void)addObject:(id)object;    - (void)addObjects:(NSArray *)objects;
- (void)insertObject:(id)object atArrangedObjectIndex:(unsigned int)index;    - (void)insertObjects:(NSArray *)objects atArrangedObjectIndexes:(NSIndexSet *)indexes;
- (void)removeObjectAtArrangedObjectIndex:(unsigned int)index;    - (void)removeObjectsAtArrangedObjectIndexes:(NSIndexSet *)indexes;
- (void)removeObject:(id)object;    - (void)removeObjects:(NSArray *)objects;

|#

; #endif


(provide-interface "NSArrayController")