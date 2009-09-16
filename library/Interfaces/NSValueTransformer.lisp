(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSValueTransformer.h"
; at Sunday July 2,2006 7:31:05 pm.
; 	NSValueTransformer.h
;         Copyright (c) 2002-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
(def-mactype :NSNegateBooleanTransformerName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSIsNilTransformerName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSIsNotNilTransformerName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSUnarchiveFromDataTransformerName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
#| @INTERFACE 
NSValueTransformer : NSObject {
}

+ (void)setValueTransformer:(NSValueTransformer *)transformer forName:(NSString *)name;
+ (NSValueTransformer *)valueTransformerForName:(NSString *)name;
+ (NSArray *)valueTransformerNames;

+ (Class)transformedValueClass;    + (BOOL)allowsReverseTransformation;    
- (id)transformedValue:(id)value;           - (id)reverseTransformedValue:(id)value;    
|#

; #endif


(provide-interface "NSValueTransformer")