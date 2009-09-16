(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ABSearchElement.h"
; at Sunday July 2,2006 7:25:19 pm.
; 
;   ABSearchElement.h
;   AddressBook Framework
; 
;   Copyright (c) 2002-2003 Apple Computer. All rights reserved.
; 

; #import <Foundation/Foundation.h>

; #import <AddressBook/ABTypedefs.h>

; #import <AddressBook/ABGlobals.h>
;  ================================================================================
; 	interface ABSearchElement : NSObject
;  ================================================================================
;  Use -[ABPerson searchElementForProperty:...] and -[ABGroup searchElementForProperty:...] to create
;  search element on ABPerson and ABGroup.
#| @INTERFACE 
ABSearchElement : NSObject

+ (ABSearchElement *)searchElementForConjunction:(ABSearchConjunction)conjuction children:(NSArray *)children;
            
- (BOOL)matchesRecord:(ABRecord *)record;
        
|#

(provide-interface "ABSearchElement")