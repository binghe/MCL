(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ABMultiValue.h"
; at Sunday July 2,2006 7:23:06 pm.
; 
;   ABMultiValue.h
;   AddressBook Framework
; 
;   Copyright (c) 2002-2003 Apple Computer, Inc. All rights reserved.
; 

; #import <Foundation/Foundation.h>

; #import <AddressBook/ABTypedefs.h>
;  ================================================================================
; 	interface ABMutableMultiValue
;  ================================================================================
;  Represents values of type ABMultiXXXXXProperty. All values in an ABMultiValue must be of the same type
;  (kABMultiStringProperty: all values must be strings....)
; 
;  In case your application needs to store away a reference to a specific value/label pair uses the identifier.
;  Index won't work in this case because any client can add/remove/reorder a multivalue making your index
;  point to the wrong pair. Identifiers are unique Ids.
; 
#| @INTERFACE 
ABMultiValue : NSObject <NSCopying, NSMutableCopying>
{
protected
    NSMutableArray      *_identifiers;
    NSMutableArray      *_labels;
    NSMutableArray      *_values;
    NSString            *_primaryIdentifier;
}

- (unsigned int)count;
    
- (id)valueAtIndex:(unsigned int)index;
        
- (NSString *)labelAtIndex:(unsigned int)index;
        
- (NSString *)identifierAtIndex:(unsigned int)index;
        
- (unsigned int)indexForIdentifier:(NSString *)identifier;
        
- (NSString *)primaryIdentifier;
    
- (ABPropertyType)propertyType;
            
|#
;  ================================================================================
; 	interface ABMutableMultiValue
;  ================================================================================
;  Mutable variant of ABMultiValue
#| @INTERFACE 
ABMutableMultiValue : ABMultiValue

- (NSString *)addValue:(id)value withLabel:(NSString *)label;
                    
- (NSString *)insertValue:(id)value withLabel:(NSString *)label atIndex:(unsigned int)index;
                    
- (BOOL)removeValueAndLabelAtIndex:(unsigned int)index;
        
- (BOOL)replaceValueAtIndex:(unsigned int)index withValue:(id)value;
        
- (BOOL)replaceLabelAtIndex:(unsigned int)index withLabel:(NSString*)label;
        
- (BOOL)setPrimaryIdentifier:(NSString *)identifier;
            
|#

(provide-interface "ABMultiValue")