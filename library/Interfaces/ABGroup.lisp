(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ABGroup.h"
; at Sunday July 2,2006 7:23:06 pm.
; 
;   ABGroup.h
;   AddressBook Framework
; 
;   Copyright (c) 2002-2003 Apple Computer. All rights reserved.
; 

; #import <AddressBook/ABRecord.h>

; #import <AddressBook/ABTypedefs.h>
;  ================================================================================
;       interface ABGroup
;  ================================================================================
;  ABGroup is a subclass of ABRecord. It represents a group of people or other groups
;  No recursions allowed
#| @INTERFACE 
ABGroup : ABRecord
{
private
    NSMutableArray *_members;
    NSMutableArray *_subgroups;
}

- (NSArray *)members;
        
- (BOOL)addMember:(ABPerson *)person;
            
- (BOOL)removeMember:(ABPerson *)person;
            
- (NSArray *)subgroups;
        
- (BOOL)addSubgroup:(ABGroup *)group;
                
- (BOOL)removeSubgroup:(ABGroup *)group;
            
- (NSArray *)parentGroups;
        
- (BOOL)setDistributionIdentifier:(NSString *)identifier forProperty:(NSString *)property person:(ABPerson *)person;
                        
- (NSString *)distributionIdentifierForProperty:(NSString *)property person:(ABPerson *)person;
            
|#
;  ================================================================================
;       interface ABGroup(ABGroup_Properties)
;  ================================================================================
;  This section deals with adding/removing properties on groups
#| @INTERFACE 
ABGroup (ABGroup_Properties)

+ (int)addPropertiesAndTypes:(NSDictionary *)properties;
                    
+ (int)removeProperties:(NSArray *)properties;
        
+ (NSArray *)properties;
    
+ (ABPropertyType)typeOfProperty:(NSString*)property;
        
|#
;  ================================================================================
;       interface ABGroup(ABGroup_Searching)
;  ================================================================================
;  This section deals with creating search elements to search groups
#| @INTERFACE 
ABGroup (ABGroup_Searching)
+ (ABSearchElement *)searchElementForProperty:(NSString*)property
                                        label:(NSString*)label
                                          key:(NSString*)key
                                        value:(id)value
                                   comparison:(ABSearchComparison)comparison;
                                    
|#

(provide-interface "ABGroup")