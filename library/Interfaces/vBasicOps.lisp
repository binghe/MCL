(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vBasicOps.h"
; at Sunday July 2,2006 7:25:19 pm.
; 
;      File:       vecLib/vBasicOps.h
;  
;      Contains:   Basic Algebraic Operations for AltiVec
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
; #ifndef __VBASICOPS__
; #define __VBASICOPS__
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
;   This section is a collection of algebraic functions that uses the AltiVec       
;   instruction set, and is designed to facilitate vector processing in             
;   mathematical programming. Following table indicates which functions are covered
;   by AltiVec instruction set and which ones are performed by vBasicOps library:
; 
; Legend:
;     H/W   = Hardware
;     LIB  = vBasicOps Library
;     NRel  = Next Release of vBasicOps Library
;     N/A   = Not Applicable
; 
; +---------------+-----+-----+-----+-----+-----+-----+-----+-----+------+------+
; | Data Type/    | U8  | S8  | U16 | S16 | U32 | S32 | U64 | S64 | U128 | S128 |
; | Function      |     |     |     |     |     |     |     |     |      |      |
; +---------------+-----+-----+-----+-----+-----+-----+-----+-----+------+------+
; |    Add        | H/W | H/W | H/W | H/W | H/W | H/W | LIB | LIB | LIB  |  LIB |
; +---------------+-----+-----+-----+-----+-----+-----+-----+-----+------+------+
; |    AddS       | H/W | H/W | H/W | H/W | H/W | H/W | LIB | LIB | LIB  | LIB  |
; +---------------+-----+-----+-----+-----+-----+-----+-----+-----+------+------+
; |    Sub        | H/W | H/W | H/W | H/W | H/W | H/W | LIB | LIB | LIB  | LIB  |
; +---------------+-----+-----+-----+-----+-----+-----+-----+-----+------+------+
; |    SubS       | H/W | H/W | H/W | H/W | H/W | H/W | LIB | LIB | LIB  | LIB  |
; +---------------+-----+-----+-----+-----+-----+-----+-----+-----+------+------+
; |  Mul(Half)    | LIB | LIB | LIB | LIB | LIB | LIB | LIB | LIB | LIB  | LIB  |
; +---------------+-----+-----+-----+-----+-----+-----+-----+-----+------+------+
; |Mul Even (Full)| H/W | H/W | H/W | H/W | LIB | LIB | LIB | LIB |  N/A |  N/A |
; +---------------+-----+-----+-----+-----+-----+-----+-----+-----+------+------+
; |Mul Odd  (Full)| H/W | H/W | H/W | H/W | LIB | LIB | LIB | LIB |  N/A |  N/A |
; +---------------+-----+-----+-----+-----+-----+-----+-----+-----+------+------+
; |    Divide     | LIB | LIB | LIB | LIB | LIB | LIB | LIB |NRel | LIB  | LIB  |
; +---------------+-----+-----+-----+-----+-----+-----+-----+-----+------+------+
; |    Shift      | H/W | H/W | H/W | H/W | H/W | H/W | LIB | LIB | LIB  | LIB  |
; +---------------+-----+-----+-----+-----+-----+-----+-----+-----+------+------+
; |    Rotate     | H/W | H/W | H/W | H/W | H/W | H/W | LIB | LIB | LIB  | LIB  |
; +---------------+-----+-----+-----+-----+-----+-----+-----+-----+------+------+
; 
; 
; 
; Following is a short description of functions in this section:
;                                                                          
;       Add:      It takes two vectors of data elements and adds each element         
;                 of the second vector to the corresponding element of the first      
;                 vector and puts the result in the associated data element of the    
;                 destination register.
; 
;       Subtract: It takes two vectors of data elements and subtracts each element    
;                 of the second vector from the corresponding element of the first    
;                 vector and puts the result in the associated data element of the    
;                 destination register.
; 
;       Multiply: It takes two vectors of data elements and multiplies each element   
;                 of the first vector by the corresponding element of the second      
;                 vector and puts the result in the associated data element of the    
;                 destination register. 
; 
;       Divide:   It takes two vectors of data elements and divides each element      
;                 of the first vector by the corresponding element of the second      
;                 vector and puts the result in the associated data element of the    
;                 destination register. A pointer is passed to the function to get   
;                 the remainder.
; 
;       Shift:    It takes a vector of two 64-bit data elements or one 128-bit
;                 data element and shifts it to right or left, in a logical or 
;                 algebraic manner, using a shift factor that is passed as an
;                 arguement to the function.
; 
;       Rotate:   It takes a vector of two 64-bit data elements or one 128-bit
;                 data element and rotates it to right or left, using a shift 
;                factor that is passed as an arguement to the function.
; 
; 
;    Following abbreviations are used in the names of functions in this section:   
;                                                                                  
;       v            Vector                                                        
;       U            Unsigned                                                      
;       S            Signed                                                        
;       8            8-bit                                                         
;       16           16-bit                                                        
;       32           32-bit                                                        
;       64           64-bit                                                        
;       128          128-bit                                                       
;       Add          Addition                                                      
;       AddS         Addition with Saturation                                      
;       Sub          Subtraction                                                   
;       SubS         Subtraction with Saturation                                   
;       Mul          Multiplication                                                
;       Divide       Division                                                      
;       Half         Half (multiplication, width of result is the same as width of 
;                       operands)                                                  
;       Full         Full (multiplication, width of result is twice width of each  
;                       operand)                                                   
;       Even         Multiplication is performed on EVEN data elements of vector   
;                       (Please note that Big endian is used. So the left-most     
;                       data element is labled as element 0)                       
;       Odd          Multiplication is performed on ODD  data elements of vector.  
;       A            Algebraic      
;       LL           Logical Left     
;       LR           Logical Right     
;       Shift        Shift by one factor     
;       Shift2       Shift by two factors( only apply to 64 bit operation )     
;       Rotate       Rotate by one factor     
;       Rotate2      Rotate by two factors( only apply to 64 bit operation )     
;                                                                                  
; 
; 
;  *  vU8Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU8Divide" 
   ((vN :vuint8)
    (vD :vuint8)
    (vRemainder (:pointer :vuint8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint8
() )
; 
;  *  vS8Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS8Divide" 
   ((vN :vsint8)
    (vD :vsint8)
    (vRemainder (:pointer :vsint8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint8
() )
; 
;  *  vU16Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU16Divide" 
   ((vN :vuint16)
    (vD :vuint16)
    (vRemainder (:pointer :vuint16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint16
() )
; 
;  *  vS16Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS16Divide" 
   ((vN :vsint16)
    (vD :vsint16)
    (vRemainder (:pointer :vsint16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint16
() )
; 
;  *  vU32Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU32Divide" 
   ((vN :vuint32)
    (vD :vuint32)
    (vRemainder (:pointer :vuint32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vS32Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS32Divide" 
   ((vN :vsint32)
    (vD :vsint32)
    (vRemainder (:pointer :vsint32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vU64Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU64Divide" 
   ((vN :vuint32)
    (vD :vuint32)
    (vRemainder (:pointer :vuint32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vS64Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS64Divide" 
   ((vN :vsint32)
    (vD :vsint32)
    (vRemainder (:pointer :vsint32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vU128Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU128Divide" 
   ((vN :vuint32)
    (vD :vuint32)
    (vRemainder (:pointer :vuint32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vS128Divide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS128Divide" 
   ((vN :vsint32)
    (vD :vsint32)
    (vRemainder (:pointer :vsint32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vU8HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU8HalfMultiply" 
   ((vA :vuint8)
    (vB :vuint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint8
() )
; 
;  *  vS8HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS8HalfMultiply" 
   ((vA :vsint8)
    (vB :vsint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint8
() )
; 
;  *  vU16HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU16HalfMultiply" 
   ((vA :vuint16)
    (vB :vuint16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint16
() )
; 
;  *  vS16HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS16HalfMultiply" 
   ((vA :vsint16)
    (vB :vsint16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint16
() )
; 
;  *  vU32HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU32HalfMultiply" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vS32HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS32HalfMultiply" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vU32FullMulEven()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU32FullMulEven" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vU32FullMulOdd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU32FullMulOdd" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vS32FullMulEven()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS32FullMulEven" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vS32FullMulOdd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS32FullMulOdd" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vU64FullMulEven()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU64FullMulEven" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vU64FullMulOdd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU64FullMulOdd" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vU64HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU64HalfMultiply" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vS64HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS64HalfMultiply" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vS64FullMulEven()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS64FullMulEven" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vS64FullMulOdd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS64FullMulOdd" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vU128HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU128HalfMultiply" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vS128HalfMultiply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS128HalfMultiply" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vU64Sub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU64Sub" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vU64SubS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU64SubS" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vU128Sub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU128Sub" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vU128SubS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU128SubS" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vS64Sub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS64Sub" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vS128Sub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS128Sub" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vS64SubS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS64SubS" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vS128SubS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS128SubS" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vU64Add()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU64Add" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vU64AddS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU64AddS" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vU128Add()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU128Add" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vU128AddS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vU128AddS" 
   ((vA :vuint32)
    (vB :vuint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vS64Add()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS64Add" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vS64AddS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS64AddS" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vS128Add()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS128Add" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vS128AddS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vS128AddS" 
   ((vA :vsint32)
    (vB :vsint32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vsint32
() )
; 
;  *  vLL64Shift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vLL64Shift" 
   ((vA :vuint32)
    (vShiftFactor :vuint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vA64Shift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vA64Shift" 
   ((vA :vuint32)
    (vShiftFactor :vuint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vLR64Shift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vLR64Shift" 
   ((vA :vuint32)
    (vShiftFactor :vuint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vLL64Shift2()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vLL64Shift2" 
   ((vA :vuint32)
    (vShiftFactor :vuint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vA64Shift2()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vA64Shift2" 
   ((vA :vuint32)
    (vShiftFactor :vuint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vLR64Shift2()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vLR64Shift2" 
   ((vA :vuint32)
    (vShiftFactor :vuint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vA128Shift()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vA128Shift" 
   ((vA :vuint32)
    (vShiftFactor :vuint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vL64Rotate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vL64Rotate" 
   ((vA :vuint32)
    (vRotateFactor :vuint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vR64Rotate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vR64Rotate" 
   ((vA :vuint32)
    (vRotateFactor :vuint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vL64Rotate2()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vL64Rotate2" 
   ((vA :vuint32)
    (vRotateFactor :vuint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vR64Rotate2()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vR64Rotate2" 
   ((vA :vuint32)
    (vRotateFactor :vuint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vL128Rotate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vL128Rotate" 
   ((vA :vuint32)
    (vRotateFactor :vuint8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :vuint32
() )
; 
;  *  vR128Rotate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vR128Rotate" 
   ((vA :vuint32)
    (vRotateFactor :vuint8)
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

; #endif /* __VBASICOPS__ */


(provide-interface "vBasicOps")