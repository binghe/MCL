(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vBigNum.h"
; at Sunday July 2,2006 7:25:20 pm.
; 
;      File:       vecLib/vBigNum.h
;  
;      Contains:   Algebraic and logical operations on large operands.
;  
;      Version:    vecLib-151~21
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __VBIGNUM__
; #define __VBIGNUM__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; 
; #ifndef __VECLIBTYPES__
; #include <vecLib/vecLibTypes.h>
; #endif
; 
; 

(require-interface "vecLibTypes")

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #pragma options align=mac68k

; #if defined(__ppc__) || defined(__i386__)
#| 
; ***********************************************************************************
; *                                                                                   *
; *  This library provides a set of subroutines for basic algebraic and some logical  *
; *  operations performed on operands with the following sizes:                       *
; *                                                                                   *
; *            128 - bits                                                             *
; *            256 - bits                                                             *
; *            512 - bits                                                             *
; *           1024 - bits                                                             *
; *                                                                                   *
; *  Following basic and algebraic operations are included:                           *
; *                                                                                   *
; *            Addition                                                               *
; *            Subtraction                                                            *
; *            Multiplication                                                         *
; *            Division                                                               *
; *            Mod                                                                    *
; *            Shift Right                                                            *
; *            Shift Right Arithmatic                                                 *
; *            Shift Left                                                             *
; *            Rotate Right                                                           *
; *            Rotate Left                                                            *
; *                                                                                   *
; *                                                                                   *
; ***********************************************************************************
; **********************************************************************************
; *   Following abbreviations are used in the names of functions in this library:    *
; *                                                                                  *
; *      v            Vector                                                         *
; *      U            Unsigned                                                       *
; *      S            Signed                                                         *
; *      128          128  - bit                                                     *
; *      256          256  - bit                                                     *
; *      512          512  - bit                                                     *
; *      1024         1024 - bit                                                     *
; *      Add          Addition, modular arithmetic                                   *
; *      AddS         Addition with Saturation                                       *
; *      Sub          Subtraction, modular arithmetic                                *
; *      SubS         Subtraction with Saturation                                    *
; *      Multiply     Multiplication                                                 *
; *      Divide       Division                                                       *
; *      Half         Half (multiplication, width of result is the same as width of  *
; *                      operands)                                                   *                         
; *      Full         Full (multiplication, width of result is twice width of each   *
; *                      operand)                                                    *
; *                                                                                  *
; *      Mod          Modular operation                                              *
; *      Neg          Negate a number                                                *
; *      A            Algebraic                                                      *
; *      LL           Logical Left                                                   *
; *      LR           Logical Right                                                  *
; *      Shift        Shift                                                          *
; *      Rotate       Rotation                                                       *
; *                                                                                  *
; **********************************************************************************
; ***********************************************************************************
; *                                                                                   *
; *  A few explanations for the choices made in naming, passing arguments, and        *
; *  various functions.                                                               *
; *                                                                                   *
; *      1) Names for the functions are made compatible with the names used in the    *
; *      vBasicOps library. The format of the names are the same and include a        *
; *      designation to show a vector operation, then a symbol for the type of data   *
; *      (signed or unsigned), followed by the size of operands, then the operation   *
; *      performed.                                                                   *
; *                                                                                   *
; *      2) Note that the logical and arithmetic shiftLeft operation are the same.    *
; *                                                                                   *
; *      3) Rotate operation is performed on unsigned and signed numbers.             *
; *                                                                                   *
; ***********************************************************************************
; ***********************************************************************************
; *                                                                                   *
; *  Following are a set of structures for vector data types and scalar data types    *
; *                                                                                   *
; ***********************************************************************************

; #if defined(__ppc__) && defined(__VEC__)
(defrecord vU128
   (:variant
   (
   (v :vuint32)
   )
   (
   (v1 :vuint32)
   )
   (
   (MSW :UInt32)
   (d2 :UInt32)
   (d3 :UInt32)
   (LSW :UInt32)
   )
   )
)

;type name? (def-mactype :vU128 (find-mactype ':vU128))
(defrecord vS128
   (:variant
   (
   (v :vuint32)
   )
   (
   (v1 :vuint32)
   )
   (
   (long (:pointer :callback))                  ;(signed MSW)
   (d2 :UInt32)
   (d3 :UInt32)
   (LSW :UInt32)
   )
   )
)

;type name? (def-mactype :vS128 (find-mactype ':vS128))
(defrecord vU256
   (:variant
   (
   (v (:array :vuint32 2))
   )
   (
   (v1 :vuint32)
   (v2 :vuint32)
   )
   (
   (MSW :UInt32)
   (d2 :UInt32)
   (d3 :UInt32)
   (d4 :UInt32)
   (d5 :UInt32)
   (d6 :UInt32)
   (d7 :UInt32)
   (LSW :UInt32)
   )
   )
)

;type name? (def-mactype :vU256 (find-mactype ':vU256))
(defrecord vS256
   (:variant
   (
   (v (:array :vuint32 2))
   )
   (
   (v1 :vuint32)
   (v2 :vuint32)
   )
   (
   (long (:pointer :callback))                  ;(signed MSW)
   (d2 :UInt32)
   (d3 :UInt32)
   (d4 :UInt32)
   (d5 :UInt32)
   (d6 :UInt32)
   (d7 :UInt32)
   (LSW :UInt32)
   )
   )
)

;type name? (def-mactype :vS256 (find-mactype ':vS256))
(defrecord vU512
   (:variant
   (
   (v (:array :vuint32 4))
   )
   (
   (v1 :vuint32)
   (v2 :vuint32)
   (v3 :vuint32)
   (v4 :vuint32)
   )
   (
   (MSW :UInt32)
   (d2 :UInt32)
   (d3 :UInt32)
   (d4 :UInt32)
   (d5 :UInt32)
   (d6 :UInt32)
   (d7 :UInt32)
   (d8 :UInt32)
   (d9 :UInt32)
   (d10 :UInt32)
   (d11 :UInt32)
   (d12 :UInt32)
   (d13 :UInt32)
   (d14 :UInt32)
   (d15 :UInt32)
   (LSW :UInt32)
   )
   )
)

;type name? (def-mactype :vU512 (find-mactype ':vU512))
(defrecord vS512
   (:variant
   (
   (v (:array :vuint32 4))
   )
   (
   (v1 :vuint32)
   (v2 :vuint32)
   (v3 :vuint32)
   (v4 :vuint32)
   )
   (
   (long (:pointer :callback))                  ;(signed MSW)
   (d2 :UInt32)
   (d3 :UInt32)
   (d4 :UInt32)
   (d5 :UInt32)
   (d6 :UInt32)
   (d7 :UInt32)
   (d8 :UInt32)
   (d9 :UInt32)
   (d10 :UInt32)
   (d11 :UInt32)
   (d12 :UInt32)
   (d13 :UInt32)
   (d14 :UInt32)
   (d15 :UInt32)
   (LSW :UInt32)
   )
   )
)

;type name? (def-mactype :vS512 (find-mactype ':vS512))
(defrecord vU1024
   (:variant
   (
   (v (:array :vuint32 8))
   )
   (
   (v1 :vuint32)
   (v2 :vuint32)
   (v3 :vuint32)
   (v4 :vuint32)
   (v5 :vuint32)
   (v6 :vuint32)
   (v7 :vuint32)
   (v8 :vuint32)
   )
   (
   (MSW :UInt32)
   (d2 :UInt32)
   (d3 :UInt32)
   (d4 :UInt32)
   (d5 :UInt32)
   (d6 :UInt32)
   (d7 :UInt32)
   (d8 :UInt32)
   (d9 :UInt32)
   (d10 :UInt32)
   (d11 :UInt32)
   (d12 :UInt32)
   (d13 :UInt32)
   (d14 :UInt32)
   (d15 :UInt32)
   (d16 :UInt32)
   (d17 :UInt32)
   (d18 :UInt32)
   (d19 :UInt32)
   (d20 :UInt32)
   (d21 :UInt32)
   (d22 :UInt32)
   (d23 :UInt32)
   (d24 :UInt32)
   (d25 :UInt32)
   (d26 :UInt32)
   (d27 :UInt32)
   (d28 :UInt32)
   (d29 :UInt32)
   (d30 :UInt32)
   (d31 :UInt32)
   (LSW :UInt32)
   )
   )
)

;type name? (def-mactype :vU1024 (find-mactype ':vU1024))
(defrecord vS1024
   (:variant
   (
   (v (:array :vuint32 8))
   )
   (
   (v1 :vuint32)
   (v2 :vuint32)
   (v3 :vuint32)
   (v4 :vuint32)
   (v5 :vuint32)
   (v6 :vuint32)
   (v7 :vuint32)
   (v8 :vuint32)
   )
   (
   (long (:pointer :callback))                  ;(signed MSW)
   (d2 :UInt32)
   (d3 :UInt32)
   (d4 :UInt32)
   (d5 :UInt32)
   (d6 :UInt32)
   (d7 :UInt32)
   (d8 :UInt32)
   (d9 :UInt32)
   (d10 :UInt32)
   (d11 :UInt32)
   (d12 :UInt32)
   (d13 :UInt32)
   (d14 :UInt32)
   (d15 :UInt32)
   (d16 :UInt32)
   (d17 :UInt32)
   (d18 :UInt32)
   (d19 :UInt32)
   (d20 :UInt32)
   (d21 :UInt32)
   (d22 :UInt32)
   (d23 :UInt32)
   (d24 :UInt32)
   (d25 :UInt32)
   (d26 :UInt32)
   (d27 :UInt32)
   (d28 :UInt32)
   (d29 :UInt32)
   (d30 :UInt32)
   (d31 :UInt32)
   (LSW :UInt32)
   )
   )
)

;type name? (def-mactype :vS1024 (find-mactype ':vS1024))

; #elif defined(__i386__) && defined(__SSE__)
(defrecord vU128
   (:variant
   (
   (v :vuint32)
   )
   (
   (v1 :vuint32)
   )
   (
   (LSW :UInt32)                                ; MSW;
   (d3 :UInt32)                                 ; d2;
   (d2 :UInt32)                                 ; d3;
   (MSW :UInt32)                                ; LSW;
   )
   )
)

;type name? (def-mactype :vU128 (find-mactype ':vU128))
(defrecord vS128
   (:variant
   (
   (v :vuint32)
   )
   (
   (v1 :vuint32)
   )
   (
   (long (:pointer :callback))                  ;(signed LSW)
                                                ; MSW;
   (d3 :UInt32)                                 ; d2;
   (d2 :UInt32)                                 ; d3;
   (MSW :UInt32)                                ; LSW;
   )
   )
)

;type name? (def-mactype :vS128 (find-mactype ':vS128))
(defrecord vU256
   (:variant
   (
   (v (:array :vuint32 2))
   )
   (
   (v2 :vuint32)
   (v1 :vuint32)
   )
   (
   (LSW :UInt32)                                ; MSW;
   (d7 :UInt32)                                 ; d2;
   (d6 :UInt32)                                 ; d3;
   (d5 :UInt32)                                 ; d4;
   (d4 :UInt32)                                 ; d5;
   (d3 :UInt32)                                 ; d6;
   (d2 :UInt32)                                 ; d7;
   (MSW :UInt32)                                ; LSW;
   )
   )
)

;type name? (def-mactype :vU256 (find-mactype ':vU256))
(defrecord vS256
   (:variant
   (
   (v (:array :vuint32 2))
   )
   (
   (v2 :vuint32)
   (v1 :vuint32)
   )
   (
   (long (:pointer :callback))                  ;(signed LSW)
                                                ; MSW;
   (d7 :UInt32)                                 ; d2;
   (d6 :UInt32)                                 ; d3;
   (d5 :UInt32)                                 ; d4;
   (d4 :UInt32)                                 ; d5;
   (d3 :UInt32)                                 ; d6;
   (d2 :UInt32)                                 ; d7;
   (MSW :UInt32)                                ; LSW;
   )
   )
)

;type name? (def-mactype :vS256 (find-mactype ':vS256))
(defrecord vU512
   (:variant
   (
   (v (:array :vuint32 4))
   )
   (
   (v4 :vuint32)
   (v3 :vuint32)
   (v2 :vuint32)
   (v1 :vuint32)
   )
   (
   (LSW :UInt32)                                ; MSB;
   (d15 :UInt32)                                ; d2;
   (d14 :UInt32)                                ; d3;
   (d13 :UInt32)                                ; d4;
   (d12 :UInt32)                                ; d5;
   (d11 :UInt32)                                ; d6;
   (d10 :UInt32)                                ; d7;
   (d9 :UInt32)                                 ; d8;
   (d8 :UInt32)                                 ; d9;
   (d7 :UInt32)                                 ; d10;
   (d6 :UInt32)                                 ; d11;
   (d5 :UInt32)                                 ; d12;
   (d4 :UInt32)                                 ; d13;
   (d3 :UInt32)                                 ; d14;
   (d2 :UInt32)                                 ; d15;
   (MSW :UInt32)                                ; LSB;
   )
   )
)

;type name? (def-mactype :vU512 (find-mactype ':vU512))
(defrecord vS512
   (:variant
   (
   (v (:array :vuint32 4))
   )
   (
   (v4 :vuint32)
   (v3 :vuint32)
   (v2 :vuint32)
   (v1 :vuint32)
   )
   (
   (long (:pointer :callback))                  ;(signed LSW)
                                                ; MSW;
   (d15 :UInt32)                                ; d2;
   (d14 :UInt32)                                ; d3;
   (d13 :UInt32)                                ; d4;
   (d12 :UInt32)                                ; d5;
   (d11 :UInt32)                                ; d6;
   (d10 :UInt32)                                ; d7;
   (d9 :UInt32)                                 ; d8;
   (d8 :UInt32)                                 ; d9;
   (d7 :UInt32)                                 ; d10;
   (d6 :UInt32)                                 ; d11;
   (d5 :UInt32)                                 ; d12;
   (d4 :UInt32)                                 ; d13;
   (d3 :UInt32)                                 ; d14;
   (d2 :UInt32)                                 ; d15;
   (MSW :UInt32)                                ; LSW;
   )
   )
)

;type name? (def-mactype :vS512 (find-mactype ':vS512))
(defrecord vU1024
   (:variant
   (
   (v (:array :vuint32 8))
   )
   (
   (v8 :vuint32)
   (v7 :vuint32)
   (v6 :vuint32)
   (v5 :vuint32)
   (v4 :vuint32)
   (v3 :vuint32)
   (v2 :vuint32)
   (v1 :vuint32)
   )
   (
   (LSW :UInt32)                                ; MSW;
   (d31 :UInt32)                                ; d2;
   (d30 :UInt32)                                ; d3;
   (d29 :UInt32)                                ; d4;
   (d28 :UInt32)                                ; d5;
   (d27 :UInt32)                                ; d6;
   (d26 :UInt32)                                ; d7;
   (d25 :UInt32)                                ; d8;
   (d24 :UInt32)                                ; d9;
   (d23 :UInt32)                                ; d10;
   (d22 :UInt32)                                ; d11;
   (d21 :UInt32)                                ; d12;
   (d20 :UInt32)                                ; d13;
   (d19 :UInt32)                                ; d14;
   (d18 :UInt32)                                ; d15;
   (d17 :UInt32)                                ; d16;
   (d16 :UInt32)                                ; d17;
   (d15 :UInt32)                                ; d18;
   (d14 :UInt32)                                ; d19;
   (d13 :UInt32)                                ; d20;
   (d12 :UInt32)                                ; d21;
   (d11 :UInt32)                                ; d22;
   (d10 :UInt32)                                ; d23;
   (d9 :UInt32)                                 ; d24;
   (d8 :UInt32)                                 ; d25;
   (d7 :UInt32)                                 ; d26;
   (d6 :UInt32)                                 ; d27;
   (d5 :UInt32)                                 ; d28;
   (d4 :UInt32)                                 ; d29;
   (d3 :UInt32)                                 ; d30;
   (d2 :UInt32)                                 ; d31;
   (MSW :UInt32)                                ; LSW;
   )
   )
)

;type name? (def-mactype :vU1024 (find-mactype ':vU1024))
(defrecord vS1024
   (:variant
   (
   (v (:array :vuint32 8))
   )
   (
   (v8 :vuint32)
   (v7 :vuint32)
   (v6 :vuint32)
   (v5 :vuint32)
   (v4 :vuint32)
   (v3 :vuint32)
   (v2 :vuint32)
   (v1 :vuint32)
   )
   (
   (long (:pointer :callback))                  ;(signed LSW)
                                                ; MSW;
   (d31 :UInt32)                                ; d2;
   (d30 :UInt32)                                ; d3;
   (d29 :UInt32)                                ; d4;
   (d28 :UInt32)                                ; d5;
   (d27 :UInt32)                                ; d6;
   (d26 :UInt32)                                ; d7;
   (d25 :UInt32)                                ; d8;
   (d24 :UInt32)                                ; d9;
   (d23 :UInt32)                                ; d10;
   (d22 :UInt32)                                ; d11;
   (d21 :UInt32)                                ; d12;
   (d20 :UInt32)                                ; d13;
   (d19 :UInt32)                                ; d14;
   (d18 :UInt32)                                ; d15;
   (d17 :UInt32)                                ; d16;
   (d16 :UInt32)                                ; d17;
   (d15 :UInt32)                                ; d18;
   (d14 :UInt32)                                ; d19;
   (d13 :UInt32)                                ; d20;
   (d12 :UInt32)                                ; d21;
   (d11 :UInt32)                                ; d22;
   (d10 :UInt32)                                ; d23;
   (d9 :UInt32)                                 ; d24;
   (d8 :UInt32)                                 ; d25;
   (d7 :UInt32)                                 ; d26;
   (d6 :UInt32)                                 ; d27;
   (d5 :UInt32)                                 ; d28;
   (d4 :UInt32)                                 ; d29;
   (d3 :UInt32)                                 ; d30;
   (d2 :UInt32)                                 ; d31;
   (MSW :UInt32)                                ; LSW;
   )
   )
)

;type name? (def-mactype :vS1024 (find-mactype ':vS1024))

; #endif  /*  */


; #if defined(__VEC__) || defined(__SSE__)
; ***********************************************************************************
; *                                                                                   *
; *                                Division operations                                *
; *                                                                                   *
; ***********************************************************************************
; 
;  *  vU256Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU256Divide" 
   ((numerator (:pointer :vU256))
    (divisor (:pointer :vU256))
    (result (:pointer :vU256))
    (remainder (:pointer :vU256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS256Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS256Divide" 
   ((numerator (:pointer :vS256))
    (divisor (:pointer :vS256))
    (result (:pointer :vS256))
    (remainder (:pointer :vS256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU512Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU512Divide" 
   ((numerator (:pointer :vU512))
    (divisor (:pointer :vU512))
    (result (:pointer :vU512))
    (remainder (:pointer :vU512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS512Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS512Divide" 
   ((numerator (:pointer :vS512))
    (divisor (:pointer :vS512))
    (result (:pointer :vS512))
    (remainder (:pointer :vS512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU1024Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU1024Divide" 
   ((numerator (:pointer :vU1024))
    (divisor (:pointer :vU1024))
    (result (:pointer :vU1024))
    (remainder (:pointer :vU1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS1024Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS1024Divide" 
   ((numerator (:pointer :vS1024))
    (divisor (:pointer :vS1024))
    (result (:pointer :vS1024))
    (remainder (:pointer :vS1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ***********************************************************************************
; *                                                                                   *
; *                              Multiply operations                                  *
; *                                                                                   *
; ***********************************************************************************
; 
;  *  vU128FullMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU128FullMultiply" 
   ((a (:pointer :vU128))
    (b (:pointer :vU128))
    (result (:pointer :vU256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS128FullMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS128FullMultiply" 
   ((a (:pointer :vS128))
    (b (:pointer :vS128))
    (result (:pointer :vS256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU256FullMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU256FullMultiply" 
   ((a (:pointer :vU256))
    (b (:pointer :vU256))
    (result (:pointer :vU512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS256FullMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS256FullMultiply" 
   ((a (:pointer :vS256))
    (b (:pointer :vS256))
    (result (:pointer :vS512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU512FullMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU512FullMultiply" 
   ((a (:pointer :vU512))
    (b (:pointer :vU512))
    (result (:pointer :vU1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS512FullMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS512FullMultiply" 
   ((a (:pointer :vS512))
    (b (:pointer :vS512))
    (result (:pointer :vS1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU256HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU256HalfMultiply" 
   ((a (:pointer :vU256))
    (b (:pointer :vU256))
    (result (:pointer :vU256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS256HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS256HalfMultiply" 
   ((a (:pointer :vS256))
    (b (:pointer :vS256))
    (result (:pointer :vS256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU512HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU512HalfMultiply" 
   ((a (:pointer :vU512))
    (b (:pointer :vU512))
    (result (:pointer :vU512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS512HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS512HalfMultiply" 
   ((a (:pointer :vS512))
    (b (:pointer :vS512))
    (result (:pointer :vS512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU1024HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU1024HalfMultiply" 
   ((a (:pointer :vU1024))
    (b (:pointer :vU1024))
    (result (:pointer :vU1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS1024HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS1024HalfMultiply" 
   ((a (:pointer :vS1024))
    (b (:pointer :vS1024))
    (result (:pointer :vS1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ***********************************************************************************
; *                                                                                   *
; *                             Subtraction operations                                *
; *                                                                                   *
; ***********************************************************************************
; 
;  *  vU256Sub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU256Sub" 
   ((a (:pointer :vU256))
    (b (:pointer :vU256))
    (result (:pointer :vU256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS256Sub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS256Sub" 
   ((a (:pointer :vS256))
    (b (:pointer :vS256))
    (result (:pointer :vS256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU256SubS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU256SubS" 
   ((a (:pointer :vU256))
    (b (:pointer :vU256))
    (result (:pointer :vU256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS256SubS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS256SubS" 
   ((a (:pointer :vS256))
    (b (:pointer :vS256))
    (result (:pointer :vS256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU512Sub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU512Sub" 
   ((a (:pointer :vU512))
    (b (:pointer :vU512))
    (result (:pointer :vU512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS512Sub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS512Sub" 
   ((a (:pointer :vS512))
    (b (:pointer :vS512))
    (result (:pointer :vS512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU512SubS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU512SubS" 
   ((a (:pointer :vU512))
    (b (:pointer :vU512))
    (result (:pointer :vU512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS512SubS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS512SubS" 
   ((a (:pointer :vS512))
    (b (:pointer :vS512))
    (result (:pointer :vS512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU1024Sub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU1024Sub" 
   ((a (:pointer :vU1024))
    (b (:pointer :vU1024))
    (result (:pointer :vU1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS1024Sub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS1024Sub" 
   ((a (:pointer :vS1024))
    (b (:pointer :vS1024))
    (result (:pointer :vS1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU1024SubS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU1024SubS" 
   ((a (:pointer :vU1024))
    (b (:pointer :vU1024))
    (result (:pointer :vU1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS1024SubS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS1024SubS" 
   ((a (:pointer :vS1024))
    (b (:pointer :vS1024))
    (result (:pointer :vS1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ***********************************************************************************
; *                                                                                   *
; *                                Negate operations                                  *
; *                                                                                   *
; ***********************************************************************************
; 
;  *  vU256Neg()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU256Neg" 
   ((a (:pointer :vU256))
    (result (:pointer :vU256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS256Neg()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS256Neg" 
   ((a (:pointer :vS256))
    (result (:pointer :vS256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU512Neg()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU512Neg" 
   ((a (:pointer :vU512))
    (result (:pointer :vU512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS512Neg()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS512Neg" 
   ((a (:pointer :vS512))
    (result (:pointer :vS512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU1024Neg()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU1024Neg" 
   ((a (:pointer :vU1024))
    (result (:pointer :vU1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS1024Neg()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS1024Neg" 
   ((a (:pointer :vS1024))
    (result (:pointer :vS1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ***********************************************************************************
; *                                                                                   *
; *                                Addition operations                                *
; *                                                                                   *
; ***********************************************************************************
; 
;  *  vU256Add()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU256Add" 
   ((a (:pointer :vU256))
    (b (:pointer :vU256))
    (result (:pointer :vU256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS256Add()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS256Add" 
   ((a (:pointer :vS256))
    (b (:pointer :vS256))
    (result (:pointer :vS256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU256AddS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU256AddS" 
   ((a (:pointer :vU256))
    (b (:pointer :vU256))
    (result (:pointer :vU256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS256AddS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS256AddS" 
   ((a (:pointer :vS256))
    (b (:pointer :vS256))
    (result (:pointer :vS256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU512Add()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU512Add" 
   ((a (:pointer :vU512))
    (b (:pointer :vU512))
    (result (:pointer :vU512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS512Add()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS512Add" 
   ((a (:pointer :vS512))
    (b (:pointer :vS512))
    (result (:pointer :vS512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU512AddS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU512AddS" 
   ((a (:pointer :vU512))
    (b (:pointer :vU512))
    (result (:pointer :vU512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS512AddS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS512AddS" 
   ((a (:pointer :vS512))
    (b (:pointer :vS512))
    (result (:pointer :vS512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU1024Add()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU1024Add" 
   ((a (:pointer :vU1024))
    (b (:pointer :vU1024))
    (result (:pointer :vU1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS1024Add()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS1024Add" 
   ((a (:pointer :vS1024))
    (b (:pointer :vS1024))
    (result (:pointer :vS1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU1024AddS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU1024AddS" 
   ((a (:pointer :vU1024))
    (b (:pointer :vU1024))
    (result (:pointer :vU1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS1024AddS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS1024AddS" 
   ((a (:pointer :vS1024))
    (b (:pointer :vS1024))
    (result (:pointer :vS1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ***********************************************************************************
; *                                                                                   *
; *                                   Mod operations                                  *
; *                                                                                   *
; ***********************************************************************************
; 
;  *  vU256Mod()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU256Mod" 
   ((numerator (:pointer :vU256))
    (divisor (:pointer :vU256))
    (remainder (:pointer :vU256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS256Mod()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS256Mod" 
   ((numerator (:pointer :vS256))
    (divisor (:pointer :vS256))
    (remainder (:pointer :vS256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU512Mod()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU512Mod" 
   ((numerator (:pointer :vU512))
    (divisor (:pointer :vU512))
    (remainder (:pointer :vU512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS512Mod()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS512Mod" 
   ((numerator (:pointer :vS512))
    (divisor (:pointer :vS512))
    (remainder (:pointer :vS512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vU1024Mod()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU1024Mod" 
   ((numerator (:pointer :vU1024))
    (divisor (:pointer :vU1024))
    (remainder (:pointer :vU1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vS1024Mod()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS1024Mod" 
   ((numerator (:pointer :vS1024))
    (divisor (:pointer :vS1024))
    (remainder (:pointer :vS1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ***********************************************************************************
; *                                                                                   *
; *                                Shift operations                                   *
; *                                                                                   *
; ***********************************************************************************
; 
;  *  vLL256Shift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vLL256Shift" 
   ((a (:pointer :vU256))
    (shiftAmount :UInt32)
    (result (:pointer :vU256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vLL512Shift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vLL512Shift" 
   ((a (:pointer :vU512))
    (shiftAmount :UInt32)
    (result (:pointer :vU512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vLL1024Shift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vLL1024Shift" 
   ((a (:pointer :vU1024))
    (shiftAmount :UInt32)
    (result (:pointer :vU1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vLR256Shift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vLR256Shift" 
   ((a (:pointer :vU256))
    (shiftAmount :UInt32)
    (result (:pointer :vU256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vLR512Shift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vLR512Shift" 
   ((a (:pointer :vU512))
    (shiftAmount :UInt32)
    (result (:pointer :vU512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vLR1024Shift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vLR1024Shift" 
   ((a (:pointer :vU1024))
    (shiftAmount :UInt32)
    (result (:pointer :vU1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vA256Shift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vA256Shift" 
   ((a (:pointer :vS256))
    (shiftAmount :UInt32)
    (result (:pointer :vS256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vA512Shift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vA512Shift" 
   ((a (:pointer :vS512))
    (shiftAmount :UInt32)
    (result (:pointer :vS512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vA1024Shift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vA1024Shift" 
   ((a (:pointer :vS1024))
    (shiftAmount :UInt32)
    (result (:pointer :vS1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ***********************************************************************************
; *                                                                                   *
; *                                  Rotate operations                                *
; *                                                                                   *
; ***********************************************************************************
; 
;  *  vL256Rotate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vL256Rotate" 
   ((a (:pointer :vU256))
    (rotateAmount :UInt32)
    (result (:pointer :vU256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vL512Rotate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vL512Rotate" 
   ((a (:pointer :vU512))
    (rotateAmount :UInt32)
    (result (:pointer :vU512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vL1024Rotate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vL1024Rotate" 
   ((a (:pointer :vU1024))
    (rotateAmount :UInt32)
    (result (:pointer :vU1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vR256Rotate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vR256Rotate" 
   ((a (:pointer :vU256))
    (rotateAmount :UInt32)
    (result (:pointer :vU256))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vR512Rotate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vR512Rotate" 
   ((a (:pointer :vU512))
    (rotateAmount :UInt32)
    (result (:pointer :vU512))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vR1024Rotate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vR1024Rotate" 
   ((a (:pointer :vU1024))
    (rotateAmount :UInt32)
    (result (:pointer :vU1024))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

; #endif  /* defined(__VEC__) || defined(__SSE__) */

 |#

; #endif  /* defined(__ppc__) || defined(__i386__) */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __VBIGNUM__ */


(provide-interface "vBigNum")