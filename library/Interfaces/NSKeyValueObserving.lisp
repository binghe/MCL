(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSKeyValueObserving.h"
; at Sunday July 2,2006 7:30:51 pm.
; 
; 	NSKeyValueObserving.h
; 	Copyright (c) 2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSArray.h>

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

(defconstant $NSKeyValueObservingOptionNew 1)
(defconstant $NSKeyValueObservingOptionOld 2)

(def-mactype :NSKeyValueObservingOptions (find-mactype ':UInt32))

(defconstant $NSKeyValueChangeSetting 1)
(defconstant $NSKeyValueChangeInsertion 2)
(defconstant $NSKeyValueChangeRemoval 3)
(defconstant $NSKeyValueChangeReplacement 4)
(def-mactype :NSKeyValueChange (find-mactype ':SINT32))
(def-mactype :NSKeyValueChangeKindKey (find-mactype '(:pointer :NSString)))
(def-mactype :NSKeyValueChangeNewKey (find-mactype '(:pointer :NSString)))
(def-mactype :NSKeyValueChangeOldKey (find-mactype '(:pointer :NSString)))
(def-mactype :NSKeyValueChangeIndexesKey (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSObject(NSKeyValueObserving)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;

|#
#| @INTERFACE 
NSObject(NSKeyValueObserverRegistration)

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

|#
#| @INTERFACE 
NSArray(NSKeyValueObserverRegistration)

- (void)addObserver:(NSObject *)observer toObjectsAtIndexes:(NSIndexSet *)indexes forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)removeObserver:(NSObject *)observer fromObjectsAtIndexes:(NSIndexSet *)indexes forKeyPath:(NSString *)keyPath;

|#
#| @INTERFACE 
NSObject(NSKeyValueObserverNotification)

- (void)willChangeValueForKey:(NSString *)key;
- (void)didChangeValueForKey:(NSString *)key;

- (void)willChange:(NSKeyValueChange)change valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key;
- (void)didChange:(NSKeyValueChange)change valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key;

|#
#| @INTERFACE 
NSObject(NSKeyValueObservingCustomization)

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key;

+ (void)setKeys:(NSArray *)keys triggerChangeNotificationsForDependentKey:(NSString *)dependentKey;

- (void)setObservationInfo:(void *)observationInfo;
- (void *)observationInfo;

|#

; #endif


(provide-interface "NSKeyValueObserving")