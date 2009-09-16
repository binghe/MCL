(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSScriptWhoseTests.h"
; at Sunday July 2,2006 7:30:59 pm.
; 	NSScriptWhoseTests.h
; 	Copyright (c) 1997-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

(defconstant $NSEqualToComparison 0)
(defconstant $NSLessThanOrEqualToComparison 1)
(defconstant $NSLessThanComparison 2)
(defconstant $NSGreaterThanOrEqualToComparison 3)
(defconstant $NSGreaterThanComparison 4)
(defconstant $NSBeginsWithComparison 5)
(defconstant $NSEndsWithComparison 6)
(defconstant $NSContainsComparison 7)
(def-mactype :NSTestComparisonOperation (find-mactype ':SINT32))
#| @INTERFACE 
NSScriptWhoseTest : NSObject <NSCoding> {}

- (BOOL)isTrue;

|#
#| @INTERFACE 
NSLogicalTest : NSScriptWhoseTest {
    private
    int _operator;
    id _subTests;
}

- (id)initAndTestWithTests:(NSArray *)subTests;
- (id)initOrTestWithTests:(NSArray *)subTests;
- (id)initNotTestWithTest:(NSScriptWhoseTest *)subTest;

|#
;  Given a comparison operator selector and an object specifier and either another object specifier or an actual value object this class can perform the test.
;  The specifiers are evaluated normally (using the top-level container stack) before the comparison operator is evaluated.  If _object1 or _object2 is nil, the objectBeingTested is used.
#| @INTERFACE 
NSSpecifierTest : NSScriptWhoseTest {
    private
    NSTestComparisonOperation _comparisonOperator;
    NSScriptObjectSpecifier *_object1;
    id _object2;
}

- (id)initWithObjectSpecifier:(NSScriptObjectSpecifier *)obj1 comparisonOperator:(NSTestComparisonOperation)compOp testObject:(id)obj2;

|#
#| @INTERFACE 
NSObject (NSComparisonMethods)
- (BOOL)isEqualTo:(id)object;
    - (BOOL)isLessThanOrEqualTo:(id)object;
    - (BOOL)isLessThan:(id)object;
    - (BOOL)isGreaterThanOrEqualTo:(id)object;
    - (BOOL)isGreaterThan:(id)object;
    - (BOOL)isNotEqualTo:(id)object;
    - (BOOL)doesContain:(id)object;
        - (BOOL)isLike:(NSString *)object;
            - (BOOL)isCaseInsensitiveLike:(NSString *)object;
|#
#| @INTERFACE 
NSObject (NSScriptingComparisonMethods)



- (BOOL)scriptingIsEqualTo:(id)object;
- (BOOL)scriptingIsLessThanOrEqualTo:(id)object;
- (BOOL)scriptingIsLessThan:(id)object;
- (BOOL)scriptingIsGreaterThanOrEqualTo:(id)object;
- (BOOL)scriptingIsGreaterThan:(id)object;

- (BOOL)scriptingBeginsWith:(id)object;
- (BOOL)scriptingEndsWith:(id)object;
- (BOOL)scriptingContains:(id)object;

|#

(provide-interface "NSScriptWhoseTests")