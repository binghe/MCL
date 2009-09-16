(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSScriptKeyValueCoding.h"
; at Sunday July 2,2006 7:30:58 pm.
; 
; 	NSScriptKeyValueCoding.h
; 	Copyright (c) 1997-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>
(def-mactype :NSOperationNotSupportedForKeyException (find-mactype '(:pointer :NSString)))
;  This exception can be raised by KVC methods that want to explicitly disallow certain manipulations or accesses.  For instance, a setKey: method for a read-only key can raise this exception.
#| @INTERFACE 
NSObject(NSScriptKeyValueCoding)

- (id)valueAtIndex:(unsigned)index inPropertyWithKey:(NSString *)key;
        
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (id)valueWithName:(NSString *)name inPropertyWithKey:(NSString *)key;
        
- (id)valueWithUniqueID:(id)uniqueID inPropertyWithKey:(NSString *)key;
        
#endif

- (void)replaceValueAtIndex:(unsigned)index inPropertyWithKey:(NSString *)key withValue:(id)value;
- (void)insertValue:(id)value atIndex:(unsigned)index inPropertyWithKey:(NSString *)key;
- (void)removeValueAtIndex:(unsigned)index fromPropertyWithKey:(NSString *)key;
                        
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (void)insertValue:(id)value inPropertyWithKey:(NSString *)key;

#endif

- (id)coerceValue:(id)value forKey:(NSString *)key;
            
|#

(provide-interface "NSScriptKeyValueCoding")