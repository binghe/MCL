(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ABPerson.h"
; at Sunday July 2,2006 7:25:19 pm.
; 
;   ABPerson.h
;   AddressBook Framework
; 
;   Copyright (c) 2002-2003 Apple Computer. All rights reserved.
; 

; #import <AddressBook/ABRecord.h>

; #import <AddressBook/ABTypedefs.h>
;  ================================================================================
;       interface ABPerson
;  ================================================================================
;  ABPerson is a subclass of ABRecord and represents a person.See ABGlobals.h for
;  a list of built-in properties
#| @INTERFACE 
ABPerson : ABRecord

- (NSArray *)parentGroups;
        
|#
;  ================================================================================
;       interface ABPerson(ABPerson_Properties)
;  ================================================================================
;  This section deals with adding/removing properties on people
#| @INTERFACE 
ABPerson (ABPerson_Properties)

+ (int)addPropertiesAndTypes:(NSDictionary *)properties;
                    
+ (int)removeProperties:(NSArray *)properties;
        
+ (NSArray *)properties;
    
+ (ABPropertyType)typeOfProperty:(NSString*)property;
        
|#
;  ================================================================================
;       interface ABPerson(ABPerson_Searching)
;  ================================================================================
;  This section deals with creating search elements to search groups
#| @INTERFACE 
ABPerson (ABPerson_Searching)
+ (ABSearchElement *)searchElementForProperty:(NSString*)property
                                        label:(NSString*)label
                                          key:(NSString*)key
                                        value:(id)value
                                   comparison:(ABSearchComparison)comparison;
                                    
|#
;  ================================================================================
;       interface ABPerson(ABPerson_vCard)
;  ================================================================================
;  This section deals with vCards
#| @INTERFACE 
ABPerson (ABPerson_vCard)
- (id)initWithVCardRepresentation:(NSData *)vCardData;
        
- (NSData *)vCardRepresentation;
    
|#

(provide-interface "ABPerson")