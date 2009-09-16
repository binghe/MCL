(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSDecimalNumber.h"
; at Sunday July 2,2006 7:30:45 pm.
; 	NSDecimalNumber.h
; 	Copyright (c) 1995-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSValue.h>

; #import <Foundation/NSScanner.h>

; #import <Foundation/NSDecimal.h>

; #import <Foundation/NSDictionary.h>
; **************	Exceptions		**********
(def-mactype :NSDecimalNumberExactnessException (find-mactype '(:pointer :NSString)))
(def-mactype :NSDecimalNumberOverflowException (find-mactype '(:pointer :NSString)))
(def-mactype :NSDecimalNumberUnderflowException (find-mactype '(:pointer :NSString)))
(def-mactype :NSDecimalNumberDivideByZeroException (find-mactype '(:pointer :NSString)))
; **************	Rounding and Exception behavior		**********
#| @PROTOCOL 
NSDecimalNumberBehaviors

- (NSRoundingMode)roundingMode;

- (short)scale;
    
- (NSDecimalNumber *)exceptionDuringOperation:(SEL)operation error:(NSCalculationError)error leftOperand:(NSDecimalNumber *)leftOperand rightOperand:(NSDecimalNumber *)rightOperand;
    
|#
; **************	NSDecimalNumber: the class		**********
#| @INTERFACE 
NSDecimalNumber : NSNumber {
private
    signed   int _exponent:8;
    unsigned int _length:4;
    unsigned int _isNegative:1;
    unsigned int _isCompact:1;
    unsigned int _reserved:1;
    unsigned int _hasExternalRefCount:1;
    unsigned int _refs:16;
    unsigned short _mantissa[0]; 
}

- (id)initWithMantissa:(unsigned long long)mantissa exponent:(short)exponent isNegative:(BOOL)flag;
- (id)initWithDecimal:(NSDecimal)dcm;
- (id)initWithString:(NSString *)numberValue;
- (id)initWithString:(NSString *)numberValue locale:(NSDictionary *)locale;

- (NSString *)descriptionWithLocale:(NSDictionary *)locale;

- (NSDecimal)decimalValue;

+ (NSDecimalNumber *)decimalNumberWithMantissa:(unsigned long long)mantissa exponent:(short)exponent isNegative:(BOOL)flag;
+ (NSDecimalNumber *)decimalNumberWithDecimal:(NSDecimal)dcm;
+ (NSDecimalNumber *)decimalNumberWithString:(NSString *)numberValue;
+ (NSDecimalNumber *)decimalNumberWithString:(NSString *)numberValue locale:(NSDictionary *)locale;

+ (NSDecimalNumber *)zero;
+ (NSDecimalNumber *)one;
+ (NSDecimalNumber *)minimumDecimalNumber;
+ (NSDecimalNumber *)maximumDecimalNumber;
+ (NSDecimalNumber *)notANumber;

- (NSDecimalNumber *)decimalNumberByAdding:(NSDecimalNumber *)decimalNumber;
- (NSDecimalNumber *)decimalNumberByAdding:(NSDecimalNumber *)decimalNumber withBehavior:(id <NSDecimalNumberBehaviors>)behavior;

- (NSDecimalNumber *)decimalNumberBySubtracting:(NSDecimalNumber *)decimalNumber;
- (NSDecimalNumber *)decimalNumberBySubtracting:(NSDecimalNumber *)decimalNumber withBehavior:(id <NSDecimalNumberBehaviors>)behavior;

- (NSDecimalNumber *)decimalNumberByMultiplyingBy:(NSDecimalNumber *)decimalNumber;
- (NSDecimalNumber *)decimalNumberByMultiplyingBy:(NSDecimalNumber *)decimalNumber withBehavior:(id <NSDecimalNumberBehaviors>)behavior;

- (NSDecimalNumber *)decimalNumberByDividingBy:(NSDecimalNumber *)decimalNumber;
- (NSDecimalNumber *)decimalNumberByDividingBy:(NSDecimalNumber *)decimalNumber withBehavior:(id <NSDecimalNumberBehaviors>)behavior;

- (NSDecimalNumber *)decimalNumberByRaisingToPower:(unsigned)power;
- (NSDecimalNumber *)decimalNumberByRaisingToPower:(unsigned)power withBehavior:(id <NSDecimalNumberBehaviors>)behavior;

- (NSDecimalNumber *)decimalNumberByMultiplyingByPowerOf10:(short)power;
- (NSDecimalNumber *)decimalNumberByMultiplyingByPowerOf10:(short)power withBehavior:(id <NSDecimalNumberBehaviors>)behavior;


- (NSDecimalNumber *)decimalNumberByRoundingAccordingToBehavior:(id <NSDecimalNumberBehaviors>)behavior;
    
- (NSComparisonResult)compare:(NSNumber *)decimalNumber;
    
+ (void)setDefaultBehavior:(id <NSDecimalNumberBehaviors>)behavior;

+ (id <NSDecimalNumberBehaviors>)defaultBehavior;
                    
- (const char *)objCType;
        
- (double)doubleValue;
        
|#
; **********	A class for defining common behaviors		******
#| @INTERFACE 
NSDecimalNumberHandler : NSObject <NSDecimalNumberBehaviors, NSCoding> {
  private
    signed int _scale:16;
    unsigned _roundingMode:3;
    unsigned _raiseOnExactness:1;
    unsigned _raiseOnOverflow:1;
    unsigned _raiseOnUnderflow:1;
    unsigned _raiseOnDivideByZero:1;
    unsigned _unused:9;
    void *_reserved2;
    void *_reserved;
}

+ (id)defaultDecimalNumberHandler;
                
- (id)initWithRoundingMode:(NSRoundingMode)roundingMode scale:(short)scale raiseOnExactness:(BOOL)exact raiseOnOverflow:(BOOL)overflow raiseOnUnderflow:(BOOL)underflow raiseOnDivideByZero:(BOOL)divideByZero;

+ (id)decimalNumberHandlerWithRoundingMode:(NSRoundingMode)roundingMode scale:(short)scale raiseOnExactness:(BOOL)exact raiseOnOverflow:(BOOL)overflow raiseOnUnderflow:(BOOL)underflow raiseOnDivideByZero:(BOOL)divideByZero;

|#
; **********	Extensions to other classes		******
#| @INTERFACE 
NSNumber (NSDecimalNumberExtensions)

- (NSDecimal)decimalValue;
    
|#
#| @INTERFACE 
NSScanner (NSDecimalNumberScanning)

- (BOOL)scanDecimal:(NSDecimal *)dcm;

|#

(provide-interface "NSDecimalNumber")