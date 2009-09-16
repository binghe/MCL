(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vfp.h"
; at Sunday July 2,2006 7:25:21 pm.
; 
;      File:       vecLib/vfp.h
;  
;      Contains:   MathLib style functions for vectors
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
; #ifndef __VFP__
; #define __VFP__
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

; #if defined(__ppc__) || defined(__i386__)
#| 
; #if defined(__VEC__) || defined(__SSE__)
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;                                                                                 
;     A collection of numerical functions designed to facilitate a wide         
;     range of numerical programming for the Altivec Programming model.       
;                                                                                 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ[ Computational Functions]ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;                                                                                 
;     vdivf        C = A Ö B                                                          
;     vsqrtf       B = ÃA                                                         
;     vrsqrtf      B = 1/ÃA                                                       
;                                                                                 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vdivf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vdivf" 
   ((A :vfloat)
    (B :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vsqrtf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vsqrtf" 
   ((X :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vrsqrtf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vrsqrtf" 
   ((X :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ[ Exponential Functions]ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;                                                                                 
;     vexpf       B = Exp(A)                                                      
;     vexpm1f     ExpM1(x) = Exp(x) - 1.  But, for small enough arguments,        
;                 ExpM1(x) is expected to be more accurate than Exp(x) - 1.       
;     vlogf       B = Log(A)                                                      
;     vlog1pf     Log1P = Log(1 + x). But, for small enough arguments,            
;                 Log1P is expected to be more accurate than Log(1 + x).          
;     vlogbf      Extracts the exponent of its argument, as a signed integral     
;                 value. A subnormal argument is treated as though it were first  
;                 normalized. Thus:                                               
;                 1   <=   x * 2^(-logb(x))   <   2                           
;     vscalbf     Computes x * 2^n efficently.  This is not normally done by      
;                 computing 2^n explicitly.                                       
;                                                                                 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vexpf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vexpf" 
   ((X :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vexpm1f()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vexpm1f" 
   ((X :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vlogf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vlogf" 
   ((X :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vlog1pf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vlog1pf" 
   ((X :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vlogbf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vlogbf" 
   ((X :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vscalbf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vscalbf" 
   ((X :vfloat)
    (n :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ[ Auxiliary Functions]ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;                                                                                 
;     vfabf           Absolute value is part of the programming model, however    
;                     completeness it is included in the library.                 
;     vcopysignf      Produces a value with the magnitude of its first argument   
;                     and sign of its second argument.  NOTE: the order of the    
;                     arguments matches the recommendation of the IEEE 754        
;                     floating point standard,  which is opposite from the SANE   
;                     copysign function.                                          
;     vnextafterf     Computes the next representable value after 'x' in the      
;                     direction of 'y'.  if x == y, then y is returned.           
;                                                                                 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vfabf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vfabf" 
   ((v :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vcopysignf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vcopysignf" 
   ((arg2 :vfloat)
    (arg1 :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vnextafterf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vnextafterf" 
   ((x :vfloat)
    (y :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ[ Inquiry Functions]ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;                                                                                 
;     vclassifyf      Returns one of the FP_Å values.                             
;     vsignbitf       Non-zero if and only if the sign of the argument x is       
;                     negative.  This includes, NaNs, infinities and zeros.       
;                                                                                 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vclassifyf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vclassifyf" 
   ((arg :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vsignbitf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vsignbitf" 
   ((arg :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ[ Transcendental Functions]ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;                                                                                 
;     vsinf           B = Sin(A).                                                 
;     vcosf           B = Cos(A).                                                 
;     vtanf           B = Tan(A).                                                 
;                                                                                 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vsinf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vsinf" 
   ((arg :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vcosf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vcosf" 
   ((arg :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vtanf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vtanf" 
   ((arg :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ[ Trigonometric Functions]ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;                                                                                 
;     vasinf      result is in [-pi/2,pi/2].                                      
;     vacosf      result is in [0,pi].                                            
;     vatanf      result is in [-pi/2,pi/2].                                      
;     vatan2f     Computes the arc tangent of y/x in [-pi,pi] using the sign of   
;                 both arguments to determine the quadrant of the computed value. 
;                                                                                 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vasinf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vasinf" 
   ((arg :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vacosf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vacosf" 
   ((arg :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vatanf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vatanf" 
   ((arg :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vatan2f()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vatan2f" 
   ((arg1 :vfloat)
    (arg2 :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ[ Hyperbolic Functions]ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;                                                                                 
;     vsinhf      Sine Hyperbolic.                                                
;     vcoshf      Cosine Hyperbolic.                                              
;     vtanhf      Tangent Hyperbolic.                                             
;     vasinhf     Arcsine Hyperbolic.
;     vacoshf     Arccosine Hyperbolic.
;     vatanhf     Atctangent Hyperbolic.
;                                                                                 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vsinhf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vsinhf" 
   ((X :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vcoshf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vcoshf" 
   ((X :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vtanhf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vtanhf" 
   ((X :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vasinhf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vasinhf" 
   ((X :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vacoshf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vacoshf" 
   ((X :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vatanhf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vatanhf" 
   ((X :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ[ Remainder Functions]ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;                                                                                 
;     vfmodf          B = X mod Y.                                                
;     vremainderf     IEEE 754 floating point standard for remainder.             
;     vremquof        SANE remainder.  It stores into 'quotient' the 7 low-order  
;                     bits of the integer quotient x/y, such that:                
;                     -127 <= quotient <= 127.                                
;                                                                                 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vfmodf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vfmodf" 
   ((X :vfloat)
    (Y :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vremainderf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vremainderf" 
   ((X :vfloat)
    (Y :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vremquof()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vremquof" 
   ((X :vfloat)
    (Y :vfloat)
    (QUO (:pointer :vuint32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ[ Power Functions]ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;                                                                                 
;     vipowf          Returns x raised to the integer power of y.                 
;     vpowf           Returns x raised to the power of y.  Result is more         
;                     accurate than using exp(log(x)*y).                          
;                                                                                 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vipowf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vipowf" 
   ((X :vfloat)
    (Y :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
;  *  vpowf()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vpowf" 
   ((X :vfloat)
    (Y :vfloat)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vfloat
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Useful                                                                      
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vtablelookup()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vtablelookup" 
   ((Index_Vect :vsint32)
    (Table (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )

; #endif  /* defined(__VEC__) || defined(__SSE__) */

 |#

; #endif  /* defined(__ppc__) || defined(__i386__) */

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __VFP__ */


(provide-interface "vfp")