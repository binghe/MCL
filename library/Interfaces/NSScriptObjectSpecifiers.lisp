(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSScriptObjectSpecifiers.h"
; at Sunday July 2,2006 7:30:58 pm.
; 
; 	NSScriptObjectSpecifiers.h
; 	Copyright (c) 1997-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>
;  Error codes for specific problems evaluating specifiers

(defconstant $NSNoSpecifierError 0)
(defconstant $NSNoTopLevelContainersSpecifierError 1);  Someone called evaluate with nil.

(defconstant $NSContainerSpecifierError 2)      ;  Error evaluating container specifier.

(defconstant $NSUnknownKeySpecifierError 3)     ;  Receivers do not understand the key.

(defconstant $NSInvalidIndexSpecifierError 4)   ;  Index out of bounds

(defconstant $NSInternalSpecifierError 5)       ;  Other internal error
;  Attempt made to perform an unsuppported opweration on some key

(defconstant $NSOperationNotSupportedForKeySpecifierError 6)

(defconstant $NSPositionAfter 0)
(defconstant $NSPositionBefore 1)
(defconstant $NSPositionBeginning 2)
(defconstant $NSPositionEnd 3)
(defconstant $NSPositionReplace 4)
(def-mactype :NSInsertionPosition (find-mactype ':SINT32))

(defconstant $NSRelativeAfter 0)
(defconstant $NSRelativeBefore 1)
(def-mactype :NSRelativePosition (find-mactype ':SINT32))

(defconstant $NSIndexSubelement 0)
(defconstant $NSEverySubelement 1)
(defconstant $NSMiddleSubelement 2)
(defconstant $NSRandomSubelement 3)
(defconstant $NSNoSubelement 4)                 ;  Only valid for the end subelement

(def-mactype :NSWhoseSubelementIdentifier (find-mactype ':SINT32))
;  This class represents a specifier to a set of objects.  It can be evaluated to return the objects it specifiers.  This abstract superclass is subclassed for each type of specifier.
;  A specifier always accesses a specific property of an object or array of objects.  The object accessed is called the container (or container).  When object specifiers are nested the container[s] are described by the container specifier.  When an object specifier has no container specifier, the container objects must be supplied explicitly.
;  Object specifiers can be nested.  The child retains its container specifier.
#| @INTERFACE 
NSScriptObjectSpecifier : NSObject <NSCoding> {
    private
    NSScriptObjectSpecifier *_container;
    NSScriptObjectSpecifier *_child;
    NSString *_key;
    unsigned long _keyCode;
    NSScriptClassDescription *_containerClassDescription;
    BOOL _containerIsObjectBeingTested;
    BOOL _containerIsRangeContainerObject;
    char _padding[2];
    int _error;
}

- (id)initWithContainerSpecifier:(NSScriptObjectSpecifier *)container key:(NSString *)property;
    
- (id)initWithContainerClassDescription:(NSScriptClassDescription *)classDesc containerSpecifier:(NSScriptObjectSpecifier *)container key:(NSString *)property;
    
- (NSScriptObjectSpecifier *)childSpecifier;
- (void)setChildSpecifier:(NSScriptObjectSpecifier *)child;
    
- (NSScriptObjectSpecifier *)containerSpecifier;
- (void)setContainerSpecifier:(NSScriptObjectSpecifier *)subRef;
     
- (BOOL)containerIsObjectBeingTested;
- (void)setContainerIsObjectBeingTested:(BOOL)flag;
    - (BOOL)containerIsRangeContainerObject;
- (void)setContainerIsRangeContainerObject:(BOOL)flag;
        
- (NSString *)key;
- (void)setKey:(NSString *)key;
    
- (NSScriptClassDescription *)containerClassDescription;
- (void)setContainerClassDescription:(NSScriptClassDescription *)classDesc;
- (NSScriptClassDescription *)keyClassDescription;

- (int *)indicesOfObjectsByEvaluatingWithContainer:(id)container count:(int *)count;
        - (id)objectsByEvaluatingWithContainers:(id)containers;
- (id)objectsByEvaluatingSpecifier;

- (int)evaluationErrorNumber;
- (void)setEvaluationErrorNumber:(int)error;

- (NSScriptObjectSpecifier *)evaluationErrorSpecifier;

|#
#| @INTERFACE 
NSObject (NSScriptObjectSpecifiers)

- (NSScriptObjectSpecifier *)objectSpecifier;
    
- (NSArray *)indicesOfObjectsByEvaluatingObjectSpecifier:(NSScriptObjectSpecifier *)specifier;
    
|#
;  An Index specifiers return the object at the specified index for the specifier's property.  A negative index counts from the end of the array.
#| @INTERFACE 
NSIndexSpecifier : NSScriptObjectSpecifier {
    private
    int _index;
}

- (id)initWithContainerClassDescription:(NSScriptClassDescription *)classDesc containerSpecifier:(NSScriptObjectSpecifier *)container key:(NSString *)property index:(int)index;

- (int)index;
- (void)setIndex:(int)index;

|#
;  A Middle specifier returns the middle object from the objects for the specifier's property.  If there are an even number of objects it returns the object before the midpoint.
#| @INTERFACE 
NSMiddleSpecifier : NSScriptObjectSpecifier {}

|#

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  A Name specifier returns the object with the specified name.
#| @INTERFACE 
NSNameSpecifier : NSScriptObjectSpecifier {
    private
    NSString *_name;
}

- (id)initWithContainerClassDescription:(NSScriptClassDescription *)classDesc containerSpecifier:(NSScriptObjectSpecifier *)container key:(NSString *)property name:(NSString *)name;

- (NSString *)name;
- (void)setName:(NSString *)name;

|#

; #endif

#| @INTERFACE 
NSPositionalSpecifier : NSObject {
    private
    NSScriptObjectSpecifier *_specifier;
    NSInsertionPosition _unadjustedPosition;
    NSScriptClassDescription *_insertionClassDescription;
    void *_moreVars;
    void *_reserved0;
}

- (id)initWithPosition:(NSInsertionPosition)position objectSpecifier:(NSScriptObjectSpecifier *)specifier;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (void)setInsertionClassDescription:(NSScriptClassDescription *)classDescription;

#endif

- (void)evaluate;

- (id)insertionContainer;

- (NSString *)insertionKey;

- (int)insertionIndex;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (BOOL)insertionReplaces;

#endif

|#
;  This returns all the objects for the specifier's property.  This is used for accessing singular properties as well as for the "Every" specifier type for plural properties.
#| @INTERFACE 
NSPropertySpecifier : NSScriptObjectSpecifier {}

|#
;  A Random specifier returns an object chosen at random from the objects for the specifier's property.
#| @INTERFACE 
NSRandomSpecifier : NSScriptObjectSpecifier {}

|#
;  A Range specifier returns a contiguous subset of the objects for the specifier's property.
#| @INTERFACE 
NSRangeSpecifier : NSScriptObjectSpecifier {
    private
    NSScriptObjectSpecifier *_startSpec;
    NSScriptObjectSpecifier *_endSpec;
}

- (id)initWithContainerClassDescription:(NSScriptClassDescription *)classDesc containerSpecifier:(NSScriptObjectSpecifier *)container key:(NSString *)property startSpecifier:(NSScriptObjectSpecifier *)startSpec endSpecifier:(NSScriptObjectSpecifier *)endSpec;

- (NSScriptObjectSpecifier *)startSpecifier;
- (void)setStartSpecifier:(NSScriptObjectSpecifier *)startSpec;

- (NSScriptObjectSpecifier *)endSpecifier;
- (void)setEndSpecifier:(NSScriptObjectSpecifier *)endSpec;

|#
#| @INTERFACE 
NSRelativeSpecifier : NSScriptObjectSpecifier {
    private
    NSRelativePosition _relativePosition;
    NSScriptObjectSpecifier *_baseSpecifier;
}

- (id)initWithContainerClassDescription:(NSScriptClassDescription *)classDesc containerSpecifier:(NSScriptObjectSpecifier *)container key:(NSString *)property relativePosition:(NSRelativePosition)relPos baseSpecifier:(NSScriptObjectSpecifier *)baseSpecifier;

- (NSRelativePosition)relativePosition;
- (void)setRelativePosition:(NSRelativePosition)relPos;

- (NSScriptObjectSpecifier *)baseSpecifier;
- (void)setBaseSpecifier:(NSScriptObjectSpecifier *)baseSpecifier;
    
|#

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  A Unique ID specifier returns the object with the specified ID.
#| @INTERFACE 
NSUniqueIDSpecifier : NSScriptObjectSpecifier {
    private
    id _uniqueID;
}

- (id)initWithContainerClassDescription:(NSScriptClassDescription *)classDesc containerSpecifier:(NSScriptObjectSpecifier *)container key:(NSString *)property uniqueID:(id)uniqueID;

- (id)uniqueID;
- (void)setUniqueID:(id)uniqueID;

|#

; #endif

;  A Qualified specifier uses a qualifier and another object specifier to get a subset of the objects for the specifier's property.  The other object specifier is evaluated for each object using that object as the container and the objects that result are tested with the qualifier.  An example makes this easier to understand.
;  Take the specifier "paragraphs where color of third word is blue".
;  This would result in an NSWhoseSpecifier where:
;      property name = "paragraphs"
;      other specifier = Index specifier with property "words" and index 3
;      qualifier = key value qualifier for key "color" and value [NSColor blueColor]
;  The "subelement" stuff is to support stuff like "the first word whose..."
#| @INTERFACE 
NSWhoseSpecifier : NSScriptObjectSpecifier {
    private
    NSScriptWhoseTest *_test;
    NSWhoseSubelementIdentifier _startSubelementIdentifier;
    int _startSubelementIndex;
    NSWhoseSubelementIdentifier _endSubelementIdentifier;
    int _endSubelementIndex;
}

- (id)initWithContainerClassDescription:(NSScriptClassDescription *)classDesc containerSpecifier:(NSScriptObjectSpecifier *)container key:(NSString *)property test:(NSScriptWhoseTest *)test;

- (NSScriptWhoseTest *)test;
- (void)setTest:(NSScriptWhoseTest *)test;


- (NSWhoseSubelementIdentifier)startSubelementIdentifier;
- (void)setStartSubelementIdentifier:(NSWhoseSubelementIdentifier)subelement;

- (int)startSubelementIndex;
- (void)setStartSubelementIndex:(int)index;
    
- (NSWhoseSubelementIdentifier)endSubelementIdentifier;
- (void)setEndSubelementIdentifier:(NSWhoseSubelementIdentifier)subelement;

- (int)endSubelementIndex;
- (void)setEndSubelementIndex:(int)index;
    
|#

(provide-interface "NSScriptObjectSpecifiers")