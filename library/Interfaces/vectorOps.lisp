(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vectorOps.h"
; at Sunday July 2,2006 7:25:21 pm.
; 
;      File:       vecLib/vectorOps.h
;  
;      Contains:   vector and matrix functions for AltiVec
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
; #ifndef __VECTOROPS__
; #define __VECTOROPS__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#

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
; 
; -------------------------------------------------------------------------------------
;                                                                                                                                                                   
;  This section is a collection of Basic Linear Algebra Subprograms (BLAS), which   
;  use AltiVec technology for their implementations. The functions are grouped into 
;  three categories (called levels), as follows:                                    
;                                                                                   
;     1) Vector-scalar linear algebra subprograms                                   
;     2) Matrix-vector linear algebra subprograms                                   
;     3) Matrix operations                                                          
;                                                                                   
;  Following is a list of subprograms and a short description of each one.          
; -------------------------------------------------------------------------------------
; 
; #ifdef __VEC__
#| #|



extern long 
vIsamax(
  long                 count,
  const vector float   x[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern long 
vIsamin(
  long                 count,
  const vector float   x[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern long 
vIsmax(
  long                 count,
  const vector float   x[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern long 
vIsmin(
  long                 count,
  const vector float   x[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern float 
vSasum(
  long                 count,
  const vector float   x[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern float 
vSsum(
  long                 count,
  const vector float   x[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern void 
vSaxpy(
  long                 n,
  float                alpha,
  const vector float   x[],
  vector float         y[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern void 
vScopy(
  long                 n,
  const vector float   x[],
  vector float         y[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;





extern float 
vSdot(
  long                 n,
  const vector float   x[],
  const vector float   y[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;





extern void 
vSnaxpy(
  long                 n,
  long                 m,
  const vector float   a[],
  const vector float   x[],
  vector float         y[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern void 
vSndot(
  long                 n,
  long                 m,
  float                s[],
  long                 isw,
  const vector float   x[],
  const vector float   y[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern float 
vSnrm2(
  long                 count,
  const vector float   x[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern float 
vSnorm2(
  long                 count,
  const vector float   x[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern void 
vSrot(
  long           n,
  vector float   x[],
  vector float   y[],
  float          c,
  float          s)                                           AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern void 
vSscal(
  long           n,
  float          alpha,
  vector float   x[])                                         AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern void 
vSswap(
  long           n,
  vector float   x[],
  vector float   y[])                                         AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern void 
vSyax(
  long                 n,
  float                alpha,
  const vector float   x[],
  vector float         y[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern void 
vSzaxpy(
  long                 n,
  float                alpha,
  const vector float   x[],
  const vector float   yY[],
  vector float         z[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;








extern void 
vSgemv(
  char                 forma,
  long                 m,
  long                 n,
  float                alpha,
  const vector float   a[],
  const vector float   x[],
  float                beta,
  vector float         y[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;







extern void 
vSgemx(
  long                 m,
  long                 n,
  float                alpha,
  const vector float   a[],
  const vector float   x[],
  vector float         y[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern void 
vSgemtx(
  long                 m,
  long                 n,
  float                alpha,
  const vector float   a[],
  const vector float   x[],
  vector float         y[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;









extern void 
vSgeadd(
  long                 height,
  long                 width,
  const vector float   a[],
  char                 forma,
  const vector float   b[],
  char                 formb,
  vector float         c[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern void 
vSgesub(
  long                 height,
  long                 width,
  const vector float   a[],
  char                 forma,
  const vector float   b[],
  char                 formb,
  vector float         c[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern void 
vSgemul(
  long                 l,
  long                 m,
  long                 n,
  const vector float   a[],
  char                 forma,
  const vector float   b[],
  char                 formb,
  vector float         matrix[])                              AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;






extern void 
vSgemm(
  long                 l,
  long                 m,
  long                 n,
  const vector float   a[],
  char                 forma,
  const vector float   b[],
  char                 formb,
  vector float         c[],
  float                alpha,
  float                beta,
  vector float         matrix[])                              AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;







extern void 
vSgetmi(
  long           size,
  vector float   x[])                                         AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;







extern void 
vSgetmo(
  long                 height,
  long                 width,
  const vector float   x[],
  vector float         y[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;







extern void 
vSgevv(
  long                 l,
  long                 n,
  const vector float   a[],
  const vector float   b[],
  vector float         m[])                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;


#endif
|#
 |#
;  defined(__VEC__) 
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __VECTOROPS__ */


(provide-interface "vectorOps")