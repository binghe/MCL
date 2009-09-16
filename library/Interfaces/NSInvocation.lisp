(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSInvocation.h"
; at Sunday July 2,2006 7:30:50 pm.
; 	NSInvocation.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

(require-interface "stdbool")
(def-mactype :_NSObjCValueType (find-mactype ':sint32))

(defconstant $NSObjCNoType 0)
(defconstant $NSObjCVoidType 118)
(defconstant $NSObjCCharType 99)
(defconstant $NSObjCShortType 115)
(defconstant $NSObjCLongType 108)
(defconstant $NSObjCLonglongType 113)
(defconstant $NSObjCFloatType 102)
(defconstant $NSObjCDoubleType 100)
; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

(defconstant $NSObjCBoolType 66)
; #endif


(defconstant $NSObjCSelectorType 58)
(defconstant $NSObjCObjectType 64)
(defconstant $NSObjCStructType 123)
(defconstant $NSObjCPointerType 94)
(defconstant $NSObjCStringType 42)
(defconstant $NSObjCArrayType 91)
(defconstant $NSObjCUnionType 40)
(defconstant $NSObjCBitfield 98)

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

; #endif

(defrecord NSObjCValue
   (_NSObjCValueType (:pointer :callback))      ;(enum type)
   (:variant
   (
   (charValue :character)
   )
   (
   (shortValue :SInt16)
   )
   (
   (longValue :signed-long)
   )
   (
   (long (:pointer :callback))                  ;(long longlongValue)

   )
   (
   (floatValue :single-float)
   )
   (
   (doubleValue :double-float)
   )
   (
   (boolValue :Boolean)
   )
   (
   (selectorValue :SEL)
   )
   (
   (objectValue :UInt32)
   )
   (
   (pointerValue :pointer)
   )
   (
   (structLocation :pointer)
   )
   (
   (cStringLocation (:pointer :char))
   )
   )
)
#| @INTERFACE 
NSInvocation : NSObject <NSCoding> {
    private
    NSObjCValue	returnValue;
    void	*argumentFrame;
    NSMethodSignature	*signature;
    NSMutableArray	*container;
    unsigned 	retainedArgs:1;
    unsigned	isInvalid:1;
    unsigned	signatureValid:1;
    unsigned	retainedRet:1;
    unsigned	externalArgFrame:1;
    unsigned	unused:3;
    unsigned	refCount:24;
    void	*reserved;
}

+ (NSInvocation *)invocationWithMethodSignature:(NSMethodSignature *)sig;

- (SEL)selector;
- (void)setSelector:(SEL)selector;

- (id)target;
- (void)setTarget:(id)target;

- (void)retainArguments;
- (BOOL)argumentsRetained;

- (void)getReturnValue:(void *)retLoc;
- (void)setReturnValue:(void *)retLoc;

- (void)getArgument:(void *)argumentLocation atIndex:(int)index;
- (void)setArgument:(void *)argumentLocation atIndex:(int)index;

- (NSMethodSignature *)methodSignature;

- (void)invoke;
- (void)invokeWithTarget:(id)target;

|#

(provide-interface "NSInvocation")