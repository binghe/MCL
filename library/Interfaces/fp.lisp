(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:fp.h"
; at Sunday July 2,2006 7:23:25 pm.
; 
;      File:       CarbonCore/fp.h
;  
;      Contains:   FPCE Floating-Point Definitions and Declarations.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1987-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __FP__
; #define __FP__
; #ifndef __CONDITIONALMACROS__
#| #|
#include <CarbonCoreConditionalMacros.h>
#endif
|#
 |#
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#

(require-interface "math")
; *******************************************************************************
; *                                                                               *
; *    A collection of numerical functions designed to facilitate a wide          *
; *    range of numerical programming as required by C9X.                         *
; *                                                                               *
; *    The <fp.h> declares many functions in support of numerical programming.    *
; *    It provides a superset of <math.h> and <SANE.h> functions.  Some           *
; *    functionality previously found in <SANE.h> and not in the FPCE <fp.h>      *
; *    can be found in this <fp.h> under the heading "__NOEXTENSIONS__".          *
; *                                                                               *
; *    All of these functions are IEEE 754 aware and treat exceptions, NaNs,      *
; *    positive and negative zero and infinity consistent with the floating-      *
; *    point standard.                                                            *
; *                                                                               *
; *******************************************************************************

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
; *******************************************************************************
; *                                                                               *
; *                            Efficient types                                    *
; *                                                                               *
; *    float_t         Most efficient type at least as wide as float              *
; *    double_t        Most efficient type at least as wide as double             *
; *                                                                               *
; *      CPU            float_t(bits)                double_t(bits)               *
; *    --------        -----------------            -----------------             *
; *    PowerPC          float(32)                    double(64)                   *
; *    68K              long double(80/96)           long double(80/96)           *
; *    x86              double(64)                   double(64)                   *
; *                                                                               *
; *******************************************************************************

; #if (defined(__MWERKS__) && defined(__cmath__)) || (TARGET_RT_MAC_MACHO && defined(__MATH__))
#|                                              ;  these types were already defined in math.h 
 |#

; #else

; #if TARGET_CPU_PPC

(def-mactype :float_t (find-mactype ':single-float))

(def-mactype :double_t (find-mactype ':double-float))
#| 
; #elif TARGET_CPU_68K

;type name? (def-mactype :double (find-mactype ':signed-long)); float_t

;type name? (def-mactype :double (find-mactype ':signed-long)); double_t

; #elif TARGET_CPU_X86

(def-mactype :float_t (find-mactype ':double-float))

(def-mactype :double_t (find-mactype ':double-float))

; #elif TARGET_CPU_MIPS

(def-mactype :float_t (find-mactype ':double-float))

(def-mactype :double_t (find-mactype ':double-float))

; #elif TARGET_CPU_ALPHA

(def-mactype :float_t (find-mactype ':double-float))

(def-mactype :double_t (find-mactype ':double-float))

; #elif TARGET_CPU_SPARC

(def-mactype :float_t (find-mactype ':double-float))

(def-mactype :double_t (find-mactype ':double-float))
 |#

; #else

; #error unsupported CPU

; #endif  /*  */

; *******************************************************************************
; *                                                                               *
; *                              Define some constants.                           *
; *                                                                               *
; *    HUGE_VAL            IEEE 754 value of infinity.                            *
; *    INFINITY            IEEE 754 value of infinity.                            *
; *    NAN                 A generic NaN (Not A Number).                          *
; *    DECIMAL_DIG         Satisfies the constraint that the conversion from      *
; *                        double to decimal and back is the identity function.   *
; *                                                                               *
; *******************************************************************************

; #if TARGET_OS_MAC

; #if !TARGET_RT_MAC_MACHO
; #define   HUGE_VAL                __inf()
; #define   INFINITY                __inf()
; #define   NAN                     nan("255")

; #endif

#| 
; #else
; #define     NAN                     sqrt(-1)
 |#

; #endif


; #if TARGET_CPU_PPC
(defconstant $DECIMAL_DIG 17)
; #define      DECIMAL_DIG              17 /* does not exist for double-double */
#| 
; #elif TARGET_CPU_68K
; #define      DECIMAL_DIG              21
 |#

; #endif      


; #endif  /* (defined(__MWERKS__) && defined(__cmath__)) || (TARGET_RT_MAC_MACHO && defined(__MATH__)) */

;  MSL or math.h already defines these 

; #if (!defined(__MWERKS__) || !defined(__cmath__)) && (!TARGET_RT_MAC_MACHO || !defined(__MATH__))
; *******************************************************************************
; *                                                                               *
; *                            Trigonometric functions                            *
; *                                                                               *
; *   acos        result is in [0,pi].                                            *
; *   asin        result is in [-pi/2,pi/2].                                      *
; *   atan        result is in [-pi/2,pi/2].                                      *
; *   atan2       Computes the arc tangent of y/x in [-pi,pi] using the sign of   *
; *               both arguments to determine the quadrant of the computed value. *
; *                                                                               *
; *******************************************************************************
; 
;  *  cos()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_cos" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  sin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_sin" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  tan()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_tan" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  acos()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_acos" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  asin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_asin" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  atan()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_atan" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  atan2()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_atan2" 
   ((y :double-float)
    (x :double-float)
   )
   :double-float
() )
; *******************************************************************************
; *                                                                               *
; *                              Hyperbolic functions                             *
; *                                                                               *
; *******************************************************************************
; 
;  *  cosh()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_cosh" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  sinh()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_sinh" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  tanh()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_tanh" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  acosh()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_acosh" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  asinh()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_asinh" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  atanh()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_atanh" 
   ((x :double-float)
   )
   :double-float
() )
; *******************************************************************************
; *                                                                               *
; *                              Exponential functions                            *
; *                                                                               *
; *   expm1       expm1(x) = exp(x) - 1.  But, for small enough arguments,        *
; *               expm1(x) is expected to be more accurate than exp(x) - 1.       *
; *   frexp       Breaks a floating-point number into a normalized fraction       *
; *               and an integral power of 2.  It stores the integer in the       *
; *               object pointed by *exponent.                                    *
; *   ldexp       Multiplies a floating-point number by an integer power of 2.    *
; *   log1p       log1p = log(1 + x). But, for small enough arguments,            *
; *               log1p is expected to be more accurate than log(1 + x).          *
; *   logb        Extracts the exponent of its argument, as a signed integral     *
; *               value. A subnormal argument is treated as though it were first  *
; *               normalized. Thus:                                               *
; *                                  1   <=   x * 2^(-logb(x))   <   2            *
; *   modf        Returns fractional part of x as function result and returns     *
; *               integral part of x via iptr. Note C9X uses double not double_t. *
; *   scalb       Computes x * 2^n efficently.  This is not normally done by      *
; *               computing 2^n explicitly.                                       *
; *                                                                               *
; *******************************************************************************
; 
;  *  exp()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_exp" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  expm1()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_expm1" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  exp2()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_exp2" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  frexp()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_frexp" 
   ((x :double-float)
    (exponent (:pointer :int))
   )
   :double-float
() )
; 
;  *  ldexp()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_ldexp" 
   ((x :double-float)
    (n :signed-long)
   )
   :double-float
() )
; 
;  *  log()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_log" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  log2()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_log2" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  log1p()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_log1p" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  log10()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_log10" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  logb()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_logb" 
   ((x :double-float)
   )
   :double-float
() )

; #if !TYPE_LONGDOUBLE_IS_DOUBLE
#| 
; 
;  *  modfl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_modfl" 
   ((x :signed-long)
    (iptrl (:pointer :long))
   )
   :double-float
() )
 |#

; #endif  /* !TYPE_LONGDOUBLE_IS_DOUBLE */

; 
;  *  modf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_modf" 
   ((x :double-float)
    (iptr (:pointer :double_t))
   )
   :double-float
() )
; 
;  *  modff()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_modff" 
   ((x :single-float)
    (iptrf (:pointer :float))
   )
   :single-float
() )
; 
;     Note: For compatiblity scalb(x,n) has n of type
;             int  on Mac OS X 
;             long on Mac OS
; 

(def-mactype :_scalb_n_type (find-mactype ':signed-long))
; 
;  *  scalb()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_scalb" 
   ((x :double-float)
    (n :signed-long)
   )
   :double-float
() )
; *******************************************************************************
; *                                                                               *
; *                     Power and absolute value functions                        *
; *                                                                               *
; *   hypot       Computes the square root of the sum of the squares of its       *
; *               arguments, without undue overflow or underflow.                 *
; *   pow         Returns x raised to the power of y.  Result is more accurate    *
; *               than using exp(log(x)*y).                                       *
; *                                                                               *
; *******************************************************************************
; 
;  *  fabs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_fabs" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  hypot()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_hypot" 
   ((x :double-float)
    (y :double-float)
   )
   :double-float
() )
; 
;  *  pow()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 2.0 and later
;  

(deftrap-inline "_pow" 
   ((x :double-float)
    (y :double-float)
   )
   :double-float
() )
; 
;  *  sqrt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_sqrt" 
   ((x :double-float)
   )
   :double-float
() )
; *******************************************************************************
; *                                                                               *
; *                        Gamma and Error functions                              *
; *                                                                               *
; *   erf         The error function.                                             *
; *   erfc        Complementary error function.                                   *
; *   gamma       The gamma function.                                             *
; *   lgamma      Computes the base-e logarithm of the absolute value of          *
; *               gamma of its argument x, for x > 0.                             *
; *                                                                               *
; *******************************************************************************
; 
;  *  erf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_erf" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  erfc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_erfc" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  gamma()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_gamma" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  lgamma()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_lgamma" 
   ((x :double-float)
   )
   :double-float
() )
; *******************************************************************************
; *                                                                               *
; *                        Nearest integer functions                              *
; *                                                                               *
; *   rint        Rounds its argument to an integral value in floating point      *
; *               format, honoring the current rounding direction.                *
; *                                                                               *
; *   nearbyint   Differs from rint only in that it does not raise the inexact    *
; *               exception. It is the nearbyint function recommended by the      *
; *               IEEE floating-point standard 854.                               *
; *                                                                               *
; *   rinttol     Rounds its argument to the nearest long int using the current   *
; *               rounding direction.  NOTE: if the rounded value is outside      *
; *               the range of long int, then the result is undefined.            *
; *                                                                               *
; *   round       Rounds the argument to the nearest integral value in floating   *
; *               point format similar to the Fortran "anint" function. That is:  *
; *               add half to the magnitude and chop.                             *
; *                                                                               *
; *   roundtol    Similar to the Fortran function nint or to the Pascal round.    *
; *               NOTE: if the rounded value is outside the range of long int,    *
; *               then the result is undefined.                                   *
; *                                                                               *
; *   trunc       Computes the integral value, in floating format, nearest to     *
; *               but no larger in magnitude than its argument.   NOTE: on 68K    *
; *               compilers when using -elems881, trunc must return an int        *
; *                                                                               *
; *******************************************************************************
; 
;  *  ceil()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_ceil" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  floor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_floor" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  rint()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_rint" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  nearbyint()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_nearbyint" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  rinttol()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_rinttol" 
   ((x :double-float)
   )
   :SInt32
() )
; 
;  *  round()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_round" 
   ((x :double-float)
   )
   :double-float
() )
; 
;  *  roundtol()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_roundtol" 
   ((round :double-float)
   )
   :SInt32
() )
; 
;     Note: For compatiblity trunc(x) has a return type of
;             int       for classic 68K with FPU enabled
;             double_t  everywhere else
; 

; #if TARGET_RT_MAC_68881
#| 
(def-mactype :_trunc_return_type (find-mactype ':signed-long))
 |#

; #else

(def-mactype :_trunc_return_type (find-mactype ':double-float))

; #endif  /* TARGET_RT_MAC_68881 */

; 
;  *  trunc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_trunc" 
   ((x :double-float)
   )
   :double-float
() )
; *******************************************************************************
; *                                                                               *
; *                            Remainder functions                                *
; *                                                                               *
; *   remainder       IEEE 754 floating point standard for remainder.             *
; *   remquo          SANE remainder.  It stores into 'quotient' the 7 low-order  *
; *                   bits of the integer quotient x/y, such that:                *
; *                       -127 <= quotient <= 127.                                *
; *                                                                               *
; *******************************************************************************
; 
;  *  fmod()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_fmod" 
   ((x :double-float)
    (y :double-float)
   )
   :double-float
() )
; 
;  *  remainder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_remainder" 
   ((x :double-float)
    (y :double-float)
   )
   :double-float
() )
; 
;  *  remquo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_remquo" 
   ((x :double-float)
    (y :double-float)
    (quo (:pointer :int))
   )
   :double-float
() )
; *******************************************************************************
; *                                                                               *
; *                             Auxiliary functions                               *
; *                                                                               *
; *   copysign        Produces a value with the magnitude of its first argument   *
; *                   and sign of its second argument.  NOTE: the order of the    *
; *                   arguments matches the recommendation of the IEEE 754        *
; *                   floating point standard,  which is opposite from the SANE   *
; *                   copysign function.                                          *
; *                                                                               *
; *   nan             The call 'nan("n-char-sequence")' returns a quiet NaN       *
; *                   with content indicated through tagp in the selected         *
; *                   data type format.                                           *
; *                                                                               *
; *   nextafter       Computes the next representable value after 'x' in the      *
; *                   direction of 'y'.  if x == y, then y is returned.           *
; *                                                                               *
; *******************************************************************************
; 
;  *  copysign()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_copysign" 
   ((x :double-float)
    (y :double-float)
   )
   :double-float
() )
; 
;  *  nan()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_nan" 
   ((tagp (:pointer :char))
   )
   :double-float
() )
; 
;  *  nanf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_nanf" 
   ((tagp (:pointer :char))
   )
   :single-float
() )
; 
;  *  nanl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_nanl" 
   ((tagp (:pointer :char))
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double nanl(const char *tagp) { return (long double) nan(tagp); }
  
|#
 |#

; #else
; #define nanl(tagp) ((long double) nan(tagp))

; #endif


; #endif

; 
;  *  nextafterd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_nextafterd" 
   ((x :double-float)
    (y :double-float)
   )
   :double-float
() )
; 
;  *  nextafterf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_nextafterf" 
   ((x :single-float)
    (y :single-float)
   )
   :single-float
() )
; 
;  *  nextafterl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_nextafterl" 
   ((x :signed-long)
    (y :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double nextafterl(long double x, long double y) { return (long double) nextafterd((double)(x),(double)(y)); }
  
|#
 |#

; #else
; #define nextafterl(x, y) ((long double) nextafterd((double)(x),(double)(y)))

; #endif


; #endif

; 
;  *  __fpclassifyd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "___fpclassifyd" 
   ((x :double-float)
   )
   :SInt32
() )
; 
;  *  __fpclassifyf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "___fpclassifyf" 
   ((x :single-float)
   )
   :SInt32
() )
; 
;  *  __fpclassify()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "___fpclassify" 
   ((x :signed-long)
   )
   :SInt32
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long __fpclassify(long double x) { return __fpclassifyd((double)(x)); }
  
|#
 |#

; #else
; #define __fpclassify(x) (__fpclassifyd((double)(x)))

; #endif


; #endif

; 
;  *  __isnormald()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "___isnormald" 
   ((x :double-float)
   )
   :SInt32
() )
; 
;  *  __isnormalf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "___isnormalf" 
   ((x :single-float)
   )
   :SInt32
() )
; 
;  *  __isnormal()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "___isnormal" 
   ((x :signed-long)
   )
   :SInt32
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long __isnormal(long double x) { return __isnormald((double)(x)); }
  
|#
 |#

; #else
; #define __isnormal(x) (__isnormald((double)(x)))

; #endif


; #endif

; 
;  *  __isfinited()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "___isfinited" 
   ((x :double-float)
   )
   :SInt32
() )
; 
;  *  __isfinitef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "___isfinitef" 
   ((x :single-float)
   )
   :SInt32
() )
; 
;  *  __isfinite()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "___isfinite" 
   ((x :signed-long)
   )
   :SInt32
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long __isfinite(long double x) { return __isfinited((double)(x)); }
  
|#
 |#

; #else
; #define __isfinite(x) (__isfinited((double)(x)))

; #endif


; #endif

; 
;  *  __isnand()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "___isnand" 
   ((x :double-float)
   )
   :SInt32
() )
; 
;  *  __isnanf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "___isnanf" 
   ((x :single-float)
   )
   :SInt32
() )
; 
;  *  __isnan()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "___isnan" 
   ((x :signed-long)
   )
   :SInt32
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long __isnan(long double x) { return __isnand((double)(x)); }
  
|#
 |#

; #else
; #define __isnan(x) (__isnand((double)(x)))

; #endif


; #endif

; 
;  *  __signbitd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "___signbitd" 
   ((x :double-float)
   )
   :SInt32
() )
; 
;  *  __signbitf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "___signbitf" 
   ((x :single-float)
   )
   :SInt32
() )
; 
;  *  __signbit()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "___signbit" 
   ((x :signed-long)
   )
   :SInt32
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long __signbit(long double x) { return __signbitd((double)(x)); }
  
|#
 |#

; #else
; #define __signbit(x) (__signbitd((double)(x)))

; #endif


; #endif

; 
;  *  __inf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "___inf" 
   (
   )
   :double-float
() )
; *******************************************************************************
; *                                                                               *
; *                              Inquiry macros                                   *
; *                                                                               *
; *   fpclassify      Returns one of the FP_Å values.                             *
; *   isnormal        Non-zero if and only if the argument x is normalized.       *
; *   isfinite        Non-zero if and only if the argument x is finite.           *
; *   isnan           Non-zero if and only if the argument x is a NaN.            *
; *   signbit         Non-zero if and only if the sign of the argument x is       *
; *                   negative.  This includes, NaNs, infinities and zeros.       *
; *                                                                               *
; *******************************************************************************
; #define      fpclassify(x)    ( ( sizeof ( x ) == sizeof(double) ) ?                                         __fpclassifyd  ( x ) :                                                           ( sizeof ( x ) == sizeof(float) ) ?                                          __fpclassifyf ( x ) :                                                          __fpclassify  ( x ) )
; #define      isnormal(x)      ( ( sizeof ( x ) == sizeof(double) ) ?                                         __isnormald ( x ) :                                                              ( sizeof ( x ) == sizeof(float) ) ?                                          __isnormalf ( x ) :                                                            __isnormal  ( x ) )
; #define      isfinite(x)      ( ( sizeof ( x ) == sizeof(double) ) ?                                         __isfinited ( x ) :                                                              ( sizeof ( x ) == sizeof(float) ) ?                                          __isfinitef ( x ) :                                                            __isfinite  ( x ) )
; #define      isnan(x)         ( ( sizeof ( x ) == sizeof(double) ) ?                                         __isnand ( x ) :                                                                 ( sizeof ( x ) == sizeof(float) ) ?                                          __isnanf ( x ) :                                                               __isnan  ( x ) )
; #define      signbit(x)       ( ( sizeof ( x ) == sizeof(double) ) ?                                         __signbitd ( x ) :                                                               ( sizeof ( x ) == sizeof(float) ) ?                                          __signbitf ( x ) :                                                             __signbit  ( x ) )
; *******************************************************************************
; *                                                                               *
; *                      Max, Min and Positive Difference                         *
; *                                                                               *
; *   fdim        Determines the 'positive difference' between its arguments:     *
; *               { x - y, if x > y }, { +0, if x <= y }.  If one argument is     *
; *               NaN, then fdim returns that NaN.  if both arguments are NaNs,   *
; *               then fdim returns the first argument.                           *
; *                                                                               *
; *   fmax        Returns the maximum of the two arguments.  Corresponds to the   *
; *               max function in FORTRAN.  NaN arguments are treated as missing  *
; *               data.  If one argument is NaN and the other is a number, then   *
; *               the number is returned.  If both are NaNs then the first        *
; *               argument is returned.                                           *
; *                                                                               *
; *   fmin        Returns the minimum of the two arguments.  Corresponds to the   *
; *               min function in FORTRAN.  NaN arguments are treated as missing  *
; *               data.  If one argument is NaN and the other is a number, then   *
; *               the number is returned.  If both are NaNs then the first        *
; *               argument is returned.                                           *
; *                                                                               *
; *******************************************************************************
; 
;  *  fdim()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_fdim" 
   ((x :double-float)
    (y :double-float)
   )
   :double-float
() )
; 
;  *  fmax()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_fmax" 
   ((x :double-float)
    (y :double-float)
   )
   :double-float
() )
; 
;  *  fmin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_fmin" 
   ((x :double-float)
    (y :double-float)
   )
   :double-float
() )

; #endif /* (defined(__MWERKS__) && defined(__cmath__)) || (TARGET_RT_MAC_MACHO && defined(__MATH__)) */

; ******************************************************************************
; *                                Constants                                     *
; ******************************************************************************
; 
;  *  pi
;  *
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  
(def-mactype :pi (find-mactype ':double_t))     ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
; *******************************************************************************
; *                                                                               *
; *                              Non NCEG extensions                              *
; *                                                                               *
; *******************************************************************************
; #ifndef __NOEXTENSIONS__
; *******************************************************************************
; *                                                                               *
; *                              Financial functions                              *
; *                                                                               *
; *   compound        Computes the compound interest factor "(1 + rate)^periods"  *
; *                   more accurately than the straightforward computation with   *
; *                   the Power function.  This is SANE's compound function.      *
; *                                                                               *
; *   annuity         Computes the present value factor for an annuity            *
; *                   "(1 - (1 + rate)^(-periods)) /rate" more accurately than    *
; *                   the straightforward computation with the Power function.    *
; *                   This is SANE's annuity function.                            *
; *                                                                               *
; *******************************************************************************
; 
;  *  compound()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_compound" 
   ((rate :double-float)
    (periods :double-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :double-float
() )
; 
;  *  annuity()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_annuity" 
   ((rate :double-float)
    (periods :double-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :double-float
() )
; *******************************************************************************
; *                                                                               *
; *                              Random function                                  *
; *                                                                               *
; *   randomx         A pseudorandom number generator.  It uses the iteration:    *
; *                               (7^5*x)mod(2^31-1)                              *
; *                                                                               *
; *******************************************************************************
; 
;  *  randomx()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_randomx" 
   ((x (:pointer :double_t))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :double-float
() )
; ******************************************************************************
; *                              Relational operator                             *
; ******************************************************************************
;       relational operator      

(def-mactype :relop (find-mactype ':SInt16))

(defconstant $GREATERTHAN 0)
(defconstant $LESSTHAN 1)
(defconstant $EQUALTO 2)
(defconstant $UNORDERED 3)

; #if !defined(__MWERKS__) || !defined(__cmath__)
; 
;  *  relation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_relation" 
   ((x :double-float)
    (y :double-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )

; #endif /* !defined(__MWERKS__) || !defined(__cmath__) */

; *******************************************************************************
; *                                                                               *
; *                         Binary to decimal conversions                         *
; *                                                                               *
; *   SIGDIGLEN   Significant decimal digits.                                     *
; *                                                                               *
; *   decimal     A record which provides an intermediate unpacked form for       *
; *               programmers who wish to do their own parsing of numeric input   *
; *               or formatting of numeric output.                                *
; *                                                                               *
; *   decform     Controls each conversion to a decimal string.  The style field  *
; *               is either FLOATDECIMAL or FIXEDDECIMAL. If FLOATDECIMAL, the    *
; *               value of the field digits is the number of significant digits.  *
; *               If FIXEDDECIMAL value of the field digits is the number of      *
; *               digits to the right of the decimal point.                       *
; *                                                                               *
; *   num2dec     Converts a double_t to a decimal record using a decform.        *
; *   dec2num     Converts a decimal record d to a double_t value.                *
; *   dec2str     Converts a decform and decimal to a string using a decform.     *
; *   str2dec     Converts a string to a decimal struct.                          *
; *   dec2d       Similar to dec2num except a double is returned (68k only).      *
; *   dec2f       Similar to dec2num except a float is returned.                  *
; *   dec2s       Similar to dec2num except a short is returned.                  *
; *   dec2l       Similar to dec2num except a long is returned.                   *
; *                                                                               *
; *******************************************************************************

; #if TARGET_CPU_PPC
(defconstant $SIGDIGLEN 36)
; #define SIGDIGLEN      36  
#| 
; #elif TARGET_CPU_68K
; #define SIGDIGLEN      20

; #elif TARGET_CPU_X86
; #define SIGDIGLEN      20
 |#

; #endif

(defconstant $DECSTROUTLEN 80)
; #define      DECSTROUTLEN   80               /* max length for dec2str output */
(defconstant $FLOATDECIMAL 0)
; #define      FLOATDECIMAL   ((char)(0))
(defconstant $FIXEDDECIMAL 1)
; #define      FIXEDDECIMAL   ((char)(1))
(defrecord decimal
   (sgn :character)                             ;  sign 0 for +, 1 for - 
   (unused :character)
   (exp :SInt16)                                ;  decimal exponent 
   (length :UInt8)
   (text (:array :UInt8 36))                    ;  significant digits 
   (unused :UInt8)
)

;type name? (%define-record :decimal (find-record-descriptor ':decimal))
(defrecord decform
   (style :character)                           ;   FLOATDECIMAL or FIXEDDECIMAL 
   (unused :character)
   (digits :SInt16)
)

;type name? (%define-record :decform (find-record-descriptor ':decform))
; 
;  *  num2dec()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_num2dec" 
   ((f (:pointer :decform))
    (x :double-float)
    (d (:pointer :decimal))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  dec2num()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_dec2num" 
   ((d (:pointer :decimal))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :double-float
() )
; 
;  *  dec2str()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_dec2str" 
   ((f (:pointer :decform))
    (d (:pointer :decimal))
    (s (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  str2dec()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_str2dec" 
   ((s (:pointer :char))
    (ix (:pointer :short))
    (d (:pointer :decimal))
    (vp (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  dec2f()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_dec2f" 
   ((d (:pointer :decimal))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :single-float
() )
; 
;  *  dec2s()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_dec2s" 
   ((d (:pointer :decimal))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  dec2l()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later
;  

(deftrap-inline "_dec2l" 
   ((d (:pointer :decimal))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; *******************************************************************************
; *                                                                               *
; *                         68k-only Transfer Function Prototypes                 *
; *                                                                               *
; *******************************************************************************

; #endif  /* !defined(__NOEXTENSIONS__) */

; *******************************************************************************
; *                                                                               *
; *                         PowerPC-only Function Prototypes                      *
; *                                                                               *
; *******************************************************************************

; #if TARGET_CPU_PPC
; #ifndef __MWERKS__  /* Metrowerks does not support double double */
; 
;  *  cosl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_cosl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double cosl(long double x) { return (long double) cos((double)(x)); }
  
|#
 |#

; #else
; #define cosl(x) ((long double) cos((double)(x)))

; #endif


; #endif

; 
;  *  sinl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_sinl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double sinl(long double x) { return (long double) sin((double)(x)); }
  
|#
 |#

; #else
; #define sinl(x) ((long double) sin((double)(x)))

; #endif


; #endif

; 
;  *  tanl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_tanl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double tanl(long double x) { return (long double) tan((double)(x)); }
  
|#
 |#

; #else
; #define tanl(x) ((long double) tan((double)(x)))

; #endif


; #endif

; 
;  *  acosl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_acosl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double acosl(long double x) { return (long double) acos((double)(x)); }
  
|#
 |#

; #else
; #define acosl(x) ((long double) acos((double)(x)))

; #endif


; #endif

; 
;  *  asinl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_asinl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double asinl(long double x) { return (long double) asin((double)(x)); }
  
|#
 |#

; #else
; #define asinl(x) ((long double) asin((double)(x)))

; #endif


; #endif

; 
;  *  atanl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_atanl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double atanl(long double x) { return (long double) atan((double)(x)); }
  
|#
 |#

; #else
; #define atanl(x) ((long double) atan((double)(x)))

; #endif


; #endif

; 
;  *  atan2l()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_atan2l" 
   ((y :signed-long)
    (x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double atan2l(long double y, long double x) { return (long double) atan2((double)(y), (double)(x)); }
  
|#
 |#

; #else
; #define atan2l(y, x) ((long double) atan2((double)(y), (double)(x)))

; #endif


; #endif

; 
;  *  coshl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_coshl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double coshl(long double x) { return (long double) cosh((double)(x)); }
  
|#
 |#

; #else
; #define coshl(x) ((long double) cosh((double)(x)))

; #endif


; #endif

; 
;  *  sinhl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_sinhl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double sinhl(long double x) { return (long double) sinh((double)(x)); }
  
|#
 |#

; #else
; #define sinhl(x) ((long double) sinh((double)(x)))

; #endif


; #endif

; 
;  *  tanhl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_tanhl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double tanhl(long double x) { return (long double) tanh((double)(x)); }
  
|#
 |#

; #else
; #define tanhl(x) ((long double) tanh((double)(x)))

; #endif


; #endif

; 
;  *  acoshl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_acoshl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double acoshl(long double x) { return (long double) acosh((double)(x)); }
  
|#
 |#

; #else
; #define acoshl(x) ((long double) acosh((double)(x)))

; #endif


; #endif

; 
;  *  asinhl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_asinhl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double asinhl(long double x) { return (long double) asinh((double)(x)); }
  
|#
 |#

; #else
; #define asinhl(x) ((long double) asinh((double)(x)))

; #endif


; #endif

; 
;  *  atanhl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_atanhl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double atanhl(long double x) { return (long double) atanh((double)(x)); }
  
|#
 |#

; #else
; #define atanhl(x) ((long double) atanh((double)(x)))

; #endif


; #endif

; 
;  *  expl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_expl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double expl(long double x) { return (long double) exp((double)(x)); }
  
|#
 |#

; #else
; #define expl(x) ((long double) exp((double)(x)))

; #endif


; #endif

; 
;  *  expm1l()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_expm1l" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double expm1l(long double x) { return (long double) expm1((double)(x)); }
  
|#
 |#

; #else
; #define expm1l(x) ((long double) expm1((double)(x)))

; #endif


; #endif

; 
;  *  exp2l()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_exp2l" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double exp2l(long double x) { return (long double) exp2((double)(x)); }
  
|#
 |#

; #else
; #define exp2l(x) ((long double) exp2((double)(x)))

; #endif


; #endif

; 
;  *  frexpl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_frexpl" 
   ((x :signed-long)
    (exponent (:pointer :int))
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double frexpl(long double x, int *exponent) { return (long double) frexp((double)(x), (exponent)); }
  
|#
 |#

; #else
; #define frexpl(x, exponent) ((long double) frexp((double)(x), (exponent)))

; #endif


; #endif

; 
;  *  ldexpl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_ldexpl" 
   ((x :signed-long)
    (n :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double ldexpl(long double x, int n) { return (long double) ldexp((double)(x), (n)); }
  
|#
 |#

; #else
; #define ldexpl(x, n) ((long double) ldexp((double)(x), (n)))

; #endif


; #endif

; 
;  *  logl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_logl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double logl(long double x) { return (long double) log((double)(x)); }
  
|#
 |#

; #else
; #define logl(x) ((long double) log((double)(x)))

; #endif


; #endif

; 
;  *  log1pl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_log1pl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double log1pl(long double x) { return (long double) log1p((double)(x)); }
  
|#
 |#

; #else
; #define log1pl(x) ((long double) log1p((double)(x)))

; #endif


; #endif

; 
;  *  log10l()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_log10l" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double log10l(long double x) { return (long double) log10((double)(x)); }
  
|#
 |#

; #else
; #define log10l(x) ((long double) log10((double)(x)))

; #endif


; #endif

; 
;  *  log2l()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_log2l" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double log2l(long double x) { return (long double) log2((double)(x)); }
  
|#
 |#

; #else
; #define log2l(x) ((long double) log2((double)(x)))

; #endif


; #endif

; 
;  *  logbl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_logbl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double logbl(long double x) { return (long double) logb((double)(x)); }
  
|#
 |#

; #else
; #define logbl(x) ((long double) logb((double)(x)))

; #endif


; #endif

; 
;  *  scalbl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_scalbl" 
   ((x :signed-long)
    (n :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double scalbl(long double x, long n) { return (long double) scalb((double)(x), (n)); }
  
|#
 |#

; #else
; #define scalbl(x, n) ((long double) scalb((double)(x), (n)))

; #endif


; #endif

; 
;  *  fabsl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_fabsl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double fabsl(long double x) { return (long double) fabs((double)(x)); }
  
|#
 |#

; #else
; #define fabsl(x) ((long double) fabs((double)(x)))

; #endif


; #endif

; 
;  *  hypotl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_hypotl" 
   ((x :signed-long)
    (y :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double hypotl(long double x, long double y) { return (long double) hypot((double)(x), (double)(y)); }
  
|#
 |#

; #else
; #define hypotl(x, y) ((long double) hypot((double)(x), (double)(y)))

; #endif


; #endif

; 
;  *  powl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_powl" 
   ((x :signed-long)
    (y :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double powl(long double x, long double y) { return (long double) pow((double)(x), (double)(y)); }
  
|#
 |#

; #else
; #define powl(x, y) ((long double) pow((double)(x), (double)(y)))

; #endif


; #endif

; 
;  *  sqrtl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_sqrtl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double sqrtl(long double x) { return (long double) sqrt((double)(x)); }
  
|#
 |#

; #else
; #define sqrtl(x) ((long double) sqrt((double)(x)))

; #endif


; #endif

; 
;  *  erfl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_erfl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double erfl(long double x) { return (long double) erf((double)(x)); }
  
|#
 |#

; #else
; #define erfl(x) ((long double) erf((double)(x)))

; #endif


; #endif

; 
;  *  erfcl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_erfcl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double erfcl(long double x) { return (long double) erfc((double)(x)); }
  
|#
 |#

; #else
; #define erfcl(x) ((long double) erfc((double)(x)))

; #endif


; #endif

; 
;  *  gammal()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_gammal" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double gammal(long double x) { return (long double) gamma((double)(x)); }
  
|#
 |#

; #else
; #define gammal(x) ((long double) gamma((double)(x)))

; #endif


; #endif

; 
;  *  lgammal()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_lgammal" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double lgammal(long double x) { return (long double) lgamma((double)(x)); }
  
|#
 |#

; #else
; #define lgammal(x) ((long double) lgamma((double)(x)))

; #endif


; #endif

; 
;  *  ceill()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 2.0 and later or as macro/inline
;  

(deftrap-inline "_ceill" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double ceill(long double x) { return (long double) ceil((double)(x)); }
  
|#
 |#

; #else
; #define ceill(x) ((long double) ceil((double)(x)))

; #endif


; #endif

; 
;  *  floorl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_floorl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double floorl(long double x) { return (long double) floor((double)(x)); }
  
|#
 |#

; #else
; #define floorl(x) ((long double) floor((double)(x)))

; #endif


; #endif

; 
;  *  rintl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_rintl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double rintl(long double x) { return (long double) rint((double)(x)); }
  
|#
 |#

; #else
; #define rintl(x) ((long double) rint((double)(x)))

; #endif


; #endif

; 
;  *  nearbyintl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_nearbyintl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double nearbyintl(long double x) { return (long double) nearbyint((double)(x)); }
  
|#
 |#

; #else
; #define nearbyintl(x) ((long double) nearbyint((double)(x)))

; #endif


; #endif

; 
;  *  rinttoll()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_rinttoll" 
   ((x :signed-long)
   )
   :SInt32
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long rinttoll(long double x) { return rinttol((double)(x)); }
  
|#
 |#

; #else
; #define rinttoll(x) (rinttol((double)(x)))

; #endif


; #endif

; 
;  *  roundl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_roundl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double roundl(long double x) { return (long double) round((double)(x)); }
  
|#
 |#

; #else
; #define roundl(x) ((long double) round((double)(x)))

; #endif


; #endif

; 
;  *  roundtoll()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_roundtoll" 
   ((x :signed-long)
   )
   :SInt32
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long roundtoll(long double x) { return roundtol((double)(x)); }
  
|#
 |#

; #else
; #define roundtoll(x) (roundtol((double)(x)))

; #endif


; #endif

; 
;  *  truncl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_truncl" 
   ((x :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double truncl(long double x) { return (long double) trunc((double)(x)); }
  
|#
 |#

; #else
; #define truncl(x) ((long double) trunc((double)(x)))

; #endif


; #endif

; 
;  *  remainderl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_remainderl" 
   ((x :signed-long)
    (y :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double remainderl(long double x, long double y) { return (long double) remainder((double)(x), (double)(y)); }
  
|#
 |#

; #else
; #define remainderl(x, y) ((long double) remainder((double)(x), (double)(y)))

; #endif


; #endif

; 
;  *  remquol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_remquol" 
   ((x :signed-long)
    (y :signed-long)
    (quo (:pointer :int))
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double remquol(long double x, long double y, int *quo) { return (long double) remquo((double)(x), (double)(y), (quo)); }
  
|#
 |#

; #else
; #define remquol(x, y, quo) ((long double) remquo((double)(x), (double)(y), (quo)))

; #endif


; #endif

; 
;  *  copysignl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_copysignl" 
   ((x :signed-long)
    (y :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double copysignl(long double x, long double y) { return (long double) copysign((double)(x), (double)(y)); }
  
|#
 |#

; #else
; #define copysignl(x, y) ((long double) copysign((double)(x), (double)(y)))

; #endif


; #endif

; 
;  *  fdiml()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_fdiml" 
   ((x :signed-long)
    (y :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double fdiml(long double x, long double y) { return (long double) fdim((double)(x), (double)(y)); }
  
|#
 |#

; #else
; #define fdiml(x, y) ((long double) fdim((double)(x), (double)(y)))

; #endif


; #endif

; 
;  *  fmaxl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_fmaxl" 
   ((x :signed-long)
    (y :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double fmaxl(long double x, long double y) { return (long double) fmax((double)(x), (double)(y)); }
  
|#
 |#

; #else
; #define fmaxl(x, y) ((long double) fmax((double)(x), (double)(y)))

; #endif


; #endif

; 
;  *  fminl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_fminl" 
   ((x :signed-long)
    (y :signed-long)
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double fminl(long double x, long double y) { return (long double) fmin((double)(x), (double)(y)); }
  
|#
 |#

; #else
; #define fminl(x, y) ((long double) fmin((double)(x), (double)(y)))

; #endif


; #endif


; #endif /* __MWERKS__ */

; #ifndef __NOEXTENSIONS__
; 
;  *  relationl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_relationl" 
   ((x :signed-long)
    (y :signed-long)
   )
   :SInt16
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline relop relationl(long double x, long double y) { return relation((double)(x), (double)(y)); }
  
|#
 |#

; #else
; #define relationl(x, y) (relation((double)(x), (double)(y)))

; #endif


; #endif

; 
;  *  num2decl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_num2decl" 
   ((f (:pointer :decform))
    (x :signed-long)
    (d (:pointer :decimal))
   )
   nil
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline void num2decl(const decform *f, long double x, decimal *d) { num2dec((f), (double)(x), (d)); }
  
|#
 |#

; #else
; #define num2decl(f, x, d) (num2dec((f), (double)(x), (d)))

; #endif


; #endif

; 
;  *  dec2numl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_dec2numl" 
   ((d (:pointer :decimal))
   )
   :double-float
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline long double dec2numl(const decimal *d) { return (long double) dec2num(d); }
  
|#
 |#

; #else
; #define dec2numl(d) ((long double) dec2num(d))

; #endif


; #endif


; #endif  /* !defined(__NOEXTENSIONS__) */


; #endif  /* TARGET_CPU_PPC */

; #ifndef __NOEXTENSIONS__
;     
;         MathLib v2 has two new transfer functions: x80tod and dtox80.  They can 
;         be used to directly transform 68k 80-bit extended data types to double
;         and back for PowerPC based machines without using the functions
;         x80told or ldtox80.  Double rounding may occur. 
;     
; 
;  *  x80tod()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 2.0 and later
;  

(deftrap-inline "_x80tod" 
   ((x80 (:pointer :EXTENDED80))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :double-float
() )
; 
;  *  dtox80()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 2.0 and later
;  

(deftrap-inline "_dtox80" 
   ((x (:pointer :double))
    (x80 (:pointer :EXTENDED80))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

; #if __cplusplus && TYPE_LONGDOUBLE_IS_DOUBLE
#| 
; #define x80told       __inline_x80told
; #define ldtox80        __inline_ldtox80
 |#

; #endif

; 
;  *  x80told()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_x80told" 
   ((x80 (:pointer :EXTENDED80))
    (x (:pointer :long))
   )
   nil
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline void x80told(const extended80 *x80, long double *x) { *(x) = (long double) x80tod(x80); }
  
|#
 |#

; #else
; #define x80told(x80, x) (*(x) = (long double) x80tod(x80))

; #endif


; #endif

; 
;  *  ldtox80()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
;  

(deftrap-inline "_ldtox80" 
   ((x (:pointer :long))
    (x80 (:pointer :EXTENDED80))
   )
   nil
() )

; #if TYPE_LONGDOUBLE_IS_DOUBLE
; #ifdef __cplusplus
#| #|
    inline void ldtox80(const long double *x, extended80 *x80) { double d = (double) *(x); dtox80(&d, (x80)); }
  
|#
 |#

; #else
; #define ldtox80(x, x80) do { double d = (double) *(x); dtox80(&d, (x80)); } while (false)

; #endif


; #endif


; #endif  /* !defined(__NOEXTENSIONS__) */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __FP__ */


(provide-interface "fp")