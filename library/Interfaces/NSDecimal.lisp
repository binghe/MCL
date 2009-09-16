(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSDecimal.h"
; at Sunday July 2,2006 7:30:45 pm.
; 	NSDecimal.h
; 	Copyright (c) 1995-2003, Apple, Inc. All rights reserved.
; 

(require-interface "limits")

; #import <Foundation/NSObjCRuntime.h>
; **************	Type definitions		**********
;  Rounding policies :
;  Original
;     value 1.2  1.21  1.25  1.35  1.27
;  Plain    1.2  1.2   1.3   1.4   1.3
;  Down     1.2  1.2   1.2   1.3   1.2
;  Up       1.2  1.3   1.3   1.4   1.3
;  Bankers  1.2  1.2   1.2   1.4   1.3

(defconstant $NSRoundPlain 0)                   ;  Round up on a tie

(defconstant $NSRoundDown 1)                    ;  Always down == truncate

(defconstant $NSRoundUp 2)                      ;  Always up
;  on a tie round so last digit is even

(defconstant $NSRoundBankers 3)
(def-mactype :NSRoundingMode (find-mactype ':SINT32))

(defconstant $NSCalculationNoError 0)
(defconstant $NSCalculationLossOfPrecision 1)   ;  Result lost precision

(defconstant $NSCalculationUnderflow 2)         ;  Result became 0

(defconstant $NSCalculationOverflow 3)          ;  Result exceeds possible representation

(defconstant $NSCalculationDivideByZero 4)
(def-mactype :NSCalculationError (find-mactype ':SINT32))
(defconstant $NSDecimalMaxSize 8)
; #define NSDecimalMaxSize (8)
;  Give a precision of at least 38 decimal digits, 128 binary positions.
; #define NSDecimalNoScale SHRT_MAX
(defrecord NSDecimal
   (int (:pointer :callback))                   ;(signed _exponent)
   (_length :UInt32)                            ;  length == 0 && isNegative -> NaN
   (_isNegative :UInt32)
   (_isCompact :UInt32)
   (_reserved :UInt32)
   (_mantissa (:array :UInt16 8))
)
#|
BOOL NSDecimalIsNotANumber(const NSDecimal *dcm)
  { return ((dcm->_length == 0) && dcm->_isNegative); 
|#
; **************	Operations		**********

(deftrap-inline "_NSDecimalCopy" 
   ((destination (:pointer :NSDECIMAL))
    (source (:pointer :NSDECIMAL))
   )
   nil
() )

(deftrap-inline "_NSDecimalCompact" 
   ((number (:pointer :NSDECIMAL))
   )
   nil
() )

(deftrap-inline "_NSDecimalCompare" 
   ((leftOperand (:pointer :NSDECIMAL))
    (rightOperand (:pointer :NSDECIMAL))
   )
   :nscomparisonresult
() )
;  NSDecimalCompare:Compares leftOperand and rightOperand.

(deftrap-inline "_NSDecimalRound" 
   ((result (:pointer :NSDECIMAL))
    (number (:pointer :NSDECIMAL))
    (scale :signed-long)
    (roundingMode :SInt32)
   )
   nil
() )
;  Rounds num to the given scale using the given mode.
;  result may be a pointer to same space as num.
;  scale indicates number of significant digits after the decimal point

(deftrap-inline "_NSDecimalNormalize" 
   ((number1 (:pointer :NSDECIMAL))
    (number2 (:pointer :NSDECIMAL))
    (roundingMode :SInt32)
   )
   :SInt32
() )

(deftrap-inline "_NSDecimalAdd" 
   ((result (:pointer :NSDECIMAL))
    (leftOperand (:pointer :NSDECIMAL))
    (rightOperand (:pointer :NSDECIMAL))
    (roundingMode :SInt32)
   )
   :SInt32
() )
;  Exact operations. result may be a pointer to same space as leftOperand or rightOperand

(deftrap-inline "_NSDecimalSubtract" 
   ((result (:pointer :NSDECIMAL))
    (leftOperand (:pointer :NSDECIMAL))
    (rightOperand (:pointer :NSDECIMAL))
    (roundingMode :SInt32)
   )
   :SInt32
() )
;  Exact operations. result may be a pointer to same space as leftOperand or rightOperand

(deftrap-inline "_NSDecimalMultiply" 
   ((result (:pointer :NSDECIMAL))
    (leftOperand (:pointer :NSDECIMAL))
    (rightOperand (:pointer :NSDECIMAL))
    (roundingMode :SInt32)
   )
   :SInt32
() )
;  Exact operations. result may be a pointer to same space as leftOperand or rightOperand

(deftrap-inline "_NSDecimalDivide" 
   ((result (:pointer :NSDECIMAL))
    (leftOperand (:pointer :NSDECIMAL))
    (rightOperand (:pointer :NSDECIMAL))
    (roundingMode :SInt32)
   )
   :SInt32
() )
;  Division could be silently inexact;
;  Exact operations. result may be a pointer to same space as leftOperand or rightOperand

(deftrap-inline "_NSDecimalPower" 
   ((result (:pointer :NSDECIMAL))
    (number (:pointer :NSDECIMAL))
    (power :UInt32)
    (roundingMode :SInt32)
   )
   :SInt32
() )

(deftrap-inline "_NSDecimalMultiplyByPowerOf10" 
   ((result (:pointer :NSDECIMAL))
    (number (:pointer :NSDECIMAL))
    (power :SInt16)
    (roundingMode :SInt32)
   )
   :SInt32
() )

(deftrap-inline "_NSDecimalString" 
   ((dcm (:pointer :NSDECIMAL))
    (locale (:pointer :nsdictionary))
   )
   (:pointer :NSString)
() )

(provide-interface "NSDecimal")