(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ABRecord.h"
; at Sunday July 2,2006 7:25:19 pm.
; 
;   ABRecord.h
;   AddressBook Framework
; 
;   Copyright (c) 2002-2003 Apple Computer. All rights reserved.
; 

; #import <Foundation/Foundation.h>
;  ================================================================================
; 	interface ABRecord
;  ================================================================================
;  ABRecord represents a row in the AddressBook database
#| @INTERFACE 
ABRecord : NSObject
{
private
    NSString            *_UIDString;
    NSMutableDictionary *_changedProperties;
    NSMutableDictionary *_temporaryCache;
    unsigned int         _hash;
}
- (id)valueForProperty:(NSString *)property;
            
- (BOOL)setValue:(id)value forProperty:(NSString *)property;
            
- (BOOL)removeValueForProperty:(NSString *)property;
                
|#
;  ================================================================================
; 	interface ABRecord(ABRecord_Convenience)
;  ================================================================================
#| @INTERFACE 
ABRecord(ABRecord_Convenience)

- (NSString *)uniqueId;
        
|#

(provide-interface "ABRecord")