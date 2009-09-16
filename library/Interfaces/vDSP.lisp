(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vDSP.h"
; at Sunday July 2,2006 7:25:21 pm.
; 
;      File:       vecLib/vDSP.h
;  
;      Contains:   AltiVec DSP Interfaces
;  
;      Version:    vecLib-151~21
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __VDSP__
; #define __VDSP__
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
; #pragma options align=mac68k
(defrecord DSPComplex
   (real :single-float)
   (imag :single-float)
)

;type name? (%define-record :DSPComplex (find-record-descriptor ':DSPComplex))
(defrecord DSPSplitComplex
   (realp (:pointer :float))
   (imagp (:pointer :float))
)

;type name? (%define-record :DSPSplitComplex (find-record-descriptor ':DSPSplitComplex))
(defrecord DSPDoubleComplex
   (real :double-float)
   (imag :double-float)
)

;type name? (%define-record :DSPDoubleComplex (find-record-descriptor ':DSPDoubleComplex))
(defrecord DSPDoubleSplitComplex
   (realp (:pointer :double))
   (imagp (:pointer :double))
)

;type name? (%define-record :DSPDoubleSplitComplex (find-record-descriptor ':DSPDoubleSplitComplex))

(def-mactype :FFTSetup (find-mactype '(:pointer :OpaqueFFTSetup)))

(def-mactype :FFTSetupD (find-mactype '(:pointer :OpaqueFFTSetupD)))

(def-mactype :FFTDirection (find-mactype ':SInt32))

(defconstant $kFFTDirection_Forward 1)
(defconstant $kFFTDirection_Inverse -1)

(def-mactype :FFTRadix (find-mactype ':SInt32))

(defconstant $kFFTRadix2 0)
(defconstant $kFFTRadix3 1)
(defconstant $kFFTRadix5 2)
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     The criteria to invoke the PowerPC vector implementation is subject to     
;     change and become less restrictive in the future.                          
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Functions create_fftsetup and destroy_fftsetup.
;               create_fftsetupD and destroy_fftsetupD.
;               
;     create_fftsetup will allocate memory and setup a weight array used by      
;     the FFT. The call destroy_fftsetup will free the array.                    
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  create_fftsetup()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_create_fftsetup" 
   ((log2n :UInt32)
    (radix :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueFFTSetup)
() )
; 
;  *  destroy_fftsetup()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_destroy_fftsetup" 
   ((setup (:pointer :OpaqueFFTSetup))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  create_fftsetupD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_create_fftsetupD" 
   ((log2n :UInt32)
    (radix :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueFFTSetupD)
() )
; 
;  *  destroy_fftsetupD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_destroy_fftsetupD" 
   ((setup (:pointer :OpaqueFFTSetupD))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Functions ctoz and ztoc.
;               ctozD and ztocD.
;     
;     ctoz converts a complex array to a complex-split array
;     ztoc converts a complex-split array to a complex array
;     
;     Criteria to invoke PowerPC vector code:    
;         1. size > 3
;         2. strideC = 2
;         3. strideZ = 1
;         4. C is 16-byte aligned and Z.realp and Z.imagp are 16-byte aligned.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  ctoz()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_ctoz" 
   ((C (:pointer :DSPComplex))
    (strideC :SInt32)
    (Z (:pointer :DSPSplitComplex))
    (strideZ :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ztoc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_ztoc" 
   ((Z (:pointer :DSPSplitComplex))
    (strideZ :SInt32)
    (C (:pointer :DSPComplex))
    (strideC :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ctozD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ctozD" 
   ((C (:pointer :DSPDoubleComplex))
    (strideC :SInt32)
    (Z (:pointer :DSPDoubleSplitComplex))
    (strideZ :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  ztocD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ztocD" 
   ((Z (:pointer :DSPDoubleSplitComplex))
    (strideZ :SInt32)
    (C (:pointer :DSPDoubleComplex))
    (strideC :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Functions fft_zip and fft_zipt 
;               fft_zipD and fft_ziptD
;               
;     In-place Split Complex Fourier Transform with or without temporary memory.
;             
;       Criteria to invoke PowerPC vector code:    
;         
;         1. ioData.realp and ioData.imagp must be 16-byte aligned.
;         2. stride = 1
;         3. 2 <= log2n <= 20
;         4. bufferTemp.realp and bufferTemp.imagp must be 16-byte aligned.
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.  The size of temporary memory for each part
;       is the lower value of 4*n and 16k.  Direction can be either
;       kFFTDirection_Forward or kFFTDirection_Inverse.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  fft_zip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft_zip" 
   ((setup (:pointer :OpaqueFFTSetup))
    (ioData (:pointer :DSPSplitComplex))
    (stride :SInt32)
    (log2n :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft_zipt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft_zipt" 
   ((setup (:pointer :OpaqueFFTSetup))
    (ioData (:pointer :DSPSplitComplex))
    (stride :SInt32)
    (bufferTemp (:pointer :DSPSplitComplex))
    (log2n :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft_zipD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft_zipD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (ioData (:pointer :DSPDoubleSplitComplex))
    (stride :SInt32)
    (log2n :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fft_ziptD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft_ziptD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (ioData (:pointer :DSPDoubleSplitComplex))
    (stride :SInt32)
    (bufferTemp (:pointer :DSPDoubleSplitComplex))
    (log2n :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;      Functions fft_zop and fft_zopt
;                fft_zopD and fft_zoptD
;      
;      Out-of-place Split Complex Fourier Transform with or without temporary
;      memory
;             
;       Criteria to invoke PowerPC vector code:  
;         
;         1. signal.realp and signal.imagp must be 16-byte aligned.
;         2. signalStride = 1
;         3. result.realp and result.imagp must be 16-byte aligned.
;         4. strideResult = 1
;         5. 2 <= log2n <= 20
;         6. bufferTemp.realp and bufferTemp.imagp must be 16-byte aligned.
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.  The size of temporary memory for each part
;       is the lower value of 4*n and 16k.  Direction can be either
;       kFFTDirection_Forward or kFFTDirection_Inverse.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  fft_zop()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft_zop" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResult :SInt32)
    (log2n :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft_zopt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft_zopt" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResult :SInt32)
    (bufferTemp (:pointer :DSPSplitComplex))
    (log2n :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft_zopD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft_zopD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStride :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResult :SInt32)
    (log2n :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fft_zoptD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft_zoptD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStride :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResult :SInt32)
    (bufferTemp (:pointer :DSPDoubleSplitComplex))
    (log2n :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Functions fft_zrip and fft_zript
;               fft_zripD and fft_zriptD
;               
;     In-Place Real Fourier Transform with or without temporary memory,
;     split Complex Format
;             
;       Criteria to invoke PowerPC vector code:    
;         1. ioData.realp and ioData.imagp must be 16-byte aligned.
;         2. stride = 1
;         3. 3 <= log2n <= 13
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.  The size of temporary memory for each part
;       is the lower value of 4*n and 16k.  Direction can be either
;       kFFTDirection_Forward or kFFTDirection_Inverse.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  fft_zrip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft_zrip" 
   ((setup (:pointer :OpaqueFFTSetup))
    (ioData (:pointer :DSPSplitComplex))
    (stride :SInt32)
    (log2n :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft_zript()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft_zript" 
   ((setup (:pointer :OpaqueFFTSetup))
    (ioData (:pointer :DSPSplitComplex))
    (stride :SInt32)
    (bufferTemp (:pointer :DSPSplitComplex))
    (log2n :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft_zripD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft_zripD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (ioData (:pointer :DSPDoubleSplitComplex))
    (stride :SInt32)
    (log2n :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fft_zriptD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft_zriptD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (ioData (:pointer :DSPDoubleSplitComplex))
    (stride :SInt32)
    (bufferTemp (:pointer :DSPDoubleSplitComplex))
    (log2n :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Functions fft_zrop and fft_zropt
;               fft_zropD and fft_zroptD
;               
;     Out-of-Place Real Fourier Transform with or without temporary memory,
;     split Complex Format
;             
;       Criteria to invoke PowerPC vector code:  
;         1. signal.realp and signal.imagp must be 16-byte aligned.
;         2. signalStride = 1
;         3. result.realp and result.imagp must be be 16-byte aligned.
;         4. strideResult = 1
;         5. 3 <= log2n <= 13
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.  The size of temporary memory for each part
;       is the lower value of 4*n and 16k.  Direction can be either
;       kFFTDirection_Forward or kFFTDirection_Inverse.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  fft_zrop()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft_zrop" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResult :SInt32)
    (log2n :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft_zropt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft_zropt" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResult :SInt32)
    (bufferTemp (:pointer :DSPSplitComplex))
    (log2n :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft_zropD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft_zropD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStride :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResult :SInt32)
    (log2n :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fft_zroptD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft_zroptD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStride :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResult :SInt32)
    (bufferTemp (:pointer :DSPDoubleSplitComplex))
    (log2n :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Functions fft2d_zip and fft2d_zipt
;               fft2d_zipD and fft2d_ziptD
;               
;     In-place two dimensional Split Complex Fourier Transform with or without
;     temporary memory
;             
;       Criteria to invoke PowerPC vector code:  
;         1. ioData.realp and ioData.imagp must be 16-byte aligned.
;         2. strideInRow = 1;
;         3. strideInCol must be a multiple of 4
;         4. 2 <= log2nInRow <= 12
;         5. 2 <= log2nInCol <= 12
;         6. bufferTemp.realp and bufferTemp.imagp must be 16-byte aligned.
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.  The size of temporary memory for each part
;       is the lower value of 4*n and 16k.  ( log2n = log2nInRow + log2nInCol ) 
;       Direction can be either kFFTDirection_Forward or kFFTDirection_Inverse.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  fft2d_zip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft2d_zip" 
   ((setup (:pointer :OpaqueFFTSetup))
    (ioData (:pointer :DSPSplitComplex))
    (strideInRow :SInt32)
    (strideInCol :SInt32)
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft2d_zipt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft2d_zipt" 
   ((setup (:pointer :OpaqueFFTSetup))
    (ioData (:pointer :DSPSplitComplex))
    (strideInRow :SInt32)
    (strideInCol :SInt32)
    (bufferTemp (:pointer :DSPSplitComplex))
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft2d_zipD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft2d_zipD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (ioData (:pointer :DSPDoubleSplitComplex))
    (strideInRow :SInt32)
    (strideInCol :SInt32)
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fft2d_ziptD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft2d_ziptD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (ioData (:pointer :DSPDoubleSplitComplex))
    (strideInRow :SInt32)
    (strideInCol :SInt32)
    (bufferTemp (:pointer :DSPDoubleSplitComplex))
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Functions fft2d_zop and fft2d_zopt
;               fft2d_zopD and fft2d_zoptD
;               
;     Out-of-Place two dimemsional Split Complex Fourier Transform with or
;     without temporary memory
;             
;       Criteria to invoke PowerPC vector code:  
;         
;         1. signal.realp and signal.imagp must be 16-byte aligned.
;         2. signalStrideInRow = 1;
;         3. signalStrideInCol must be a multiple of 4
;         4. result.realp and result.imagp must be 16-byte aligned.
;         5. strideResultInRow = 1;
;         6. strideResultInCol must be a multiple of 4
;         7. 2 <= log2nInRow <= 12
;         8. 2 <= log2nInCol <= 12
;         9. bufferTemp.realp and bufferTemp.imagp must be 16-byte aligned.
; 
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.  The size of temporary memory for each part
;       is the lower value of 4*n and 16k.  ( log2n = log2nInRow + log2nInCol ) 
;       Direction can be either kFFTDirection_Forward or kFFTDirection_Inverse.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  fft2d_zop()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft2d_zop" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStrideInRow :SInt32)
    (signalStrideInCol :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResultInRow :SInt32)
    (strideResultInCol :SInt32)
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft2d_zopt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft2d_zopt" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStrideInRow :SInt32)
    (signalStrideInCol :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResultInRow :SInt32)
    (strideResultInCol :SInt32)
    (bufferTemp (:pointer :DSPSplitComplex))
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft2d_zopD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft2d_zopD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStrideInRow :SInt32)
    (signalStrideInCol :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResultInRow :SInt32)
    (strideResultInCol :SInt32)
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fft2d_zoptD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft2d_zoptD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStrideInRow :SInt32)
    (signalStrideInCol :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResultInRow :SInt32)
    (strideResultInCol :SInt32)
    (bufferTemp (:pointer :DSPDoubleSplitComplex))
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Functions fft2d_zrip and fft2d_zript
;               fft2d_zripD and fft2d_zriptD
;               
;     In-place two dimensional Real Fourier Transform with or without temporary
;     memory, Split Complex Format
;             
;       Criteria to invoke PowerPC vector code:  
;         1. ioData.realp and ioData.imagp must be 16-byte aligned.
;         2. strideInRow = 1;
;         3. strideInCol must be a multiple of 4
;         4. 3 <= log2nInRow <= 12
;         5. 3 <= log2nInCol <= 13
;         6. bufferTemp.realp and bufferTemp.imagp must be 16-byte aligned.
; 
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.  The size of temporary memory for each part
;       is the lower value of 4*n and 16k.  ( log2n = log2nInRow + log2nInCol ) 
;       Direction can be either kFFTDirection_Forward or kFFTDirection_Inverse.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  fft2d_zrip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft2d_zrip" 
   ((setup (:pointer :OpaqueFFTSetup))
    (ioData (:pointer :DSPSplitComplex))
    (strideInRow :SInt32)
    (strideInCol :SInt32)
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft2d_zript()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft2d_zript" 
   ((setup (:pointer :OpaqueFFTSetup))
    (ioData (:pointer :DSPSplitComplex))
    (strideInRow :SInt32)
    (strideInCol :SInt32)
    (bufferTemp (:pointer :DSPSplitComplex))
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (direction :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft2d_zripD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft2d_zripD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (strideInRow :SInt32)
    (strideInCol :SInt32)
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fft2d_zriptD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft2d_zriptD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (strideInRow :SInt32)
    (strideInCol :SInt32)
    (bufferTemp (:pointer :DSPDoubleSplitComplex))
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Functions fft2d_zrop and fft2d_zropt
;               fft2d_zropD and fft2d_zroptD
;               
;     Out-of-Place Two-Dimemsional Real Fourier Transform with or without
;     temporary memory, Split Complex Format
;             
;       Criteria to invoke PowerPC vector code:  
;         1. signal.realp and signal.imagp must be 16-byte aligned.
;         2. signalStrideInRow = 1;
;         3. signalStrideInCol must be a multiple of 4
;         4. result.realp and result.imagp must be 16-byte aligned.
;         5. strideResultInRow = 1;
;         6. strideResultInCol must be a multiple of 4
;         7. 3 <= log2nInRow <= 12
;         8. 3 <= log2nInCol <= 13
;         9. bufferTemp.realp and bufferTemp.imagp must be 16-byte aligned.
; 
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.  The size of temporary memory for each part
;       is the lower value of 4*n and 16k.  ( log2n = log2nInRow + log2nInCol ) 
;       Direction can be either kFFTDirection_Forward or kFFTDirection_Inverse.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  fft2d_zrop()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft2d_zrop" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStrideInRow :SInt32)
    (signalStrideInCol :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResultInRow :SInt32)
    (strideResultInCol :SInt32)
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft2d_zropt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_fft2d_zropt" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStrideInRow :SInt32)
    (signalStrideInCol :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResultInRow :SInt32)
    (strideResultInCol :SInt32)
    (bufferTemp (:pointer :DSPSplitComplex))
    (log2nInCol :UInt32)
    (log2nInRow :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  fft2d_zropD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft2d_zropD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (ioData (:pointer :DSPDoubleSplitComplex))
    (Kr :SInt32)
    (Kc :SInt32)
    (ioData2 (:pointer :DSPDoubleSplitComplex))
    (Ir :SInt32)
    (Ic :SInt32)
    (log2nc :UInt32)
    (log2nr :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fft2d_zroptD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft2d_zroptD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (ioData (:pointer :DSPDoubleSplitComplex))
    (Kr :SInt32)
    (Kc :SInt32)
    (ioData2 (:pointer :DSPDoubleSplitComplex))
    (Ir :SInt32)
    (Ic :SInt32)
    (temp (:pointer :DSPDoubleSplitComplex))
    (log2nc :UInt32)
    (log2nr :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ________________________________________________________________________________
;       Functions fftm_zip and fftm_zipt
;                 fftm_zipD and fftm_ziptD
;                 
;       In-Place multiple One_Dimensional Complex Fourier Transform with or 
;       without temporary memory, Split Complex Format
;       
;          Criteria to invoke PowerPC vector code:
;             1. signal.realp and signal.imagp must be 16-byte aligned.
;             2. signalStride = 1;
;             3. fftStride must be a multiple of 4
;             4. 2 <= log2n <= 12
;             5. temp.realp and temp.imagp must be 16-byte aligned.
;          
;          If any of the above criteria are not satisfied, the PowerPC scalar code
;          implementation will be used.
; ________________________________________________________________________________
; 
; 
;  *  fftm_zip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zip" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fftm_zipt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zipt" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (temp (:pointer :DSPSplitComplex))
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fftm_zipD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zipD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fftm_ziptD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_ziptD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (temp (:pointer :DSPDoubleSplitComplex))
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ________________________________________________________________________________
;       Functions fftm_zop and fftm_zopt
;                 fftm_zopD and fftm_zoptD
;                 
;       Out-Of-Place multiple One_Dimensional Complex Fourier Transform with or 
;       without temporary memory, Split Complex Format
;       
;          Criteria to invoke PowerPC vector code:
;             1. signal.realp and signal.imagp must be 16-byte aligned.
;             2. signalStride = 1;
;             3. fftStride must be a multiple of 4
;             4. result.realp and result.imagp must be 16-byte aligned.
;             5. resultStride = 1;
;             6. rfftStride must be a multiple of 4
;             7. 2 <= log2n <= 12
;             8. temp.realp and temp.imagp must be 16-byte aligned.
;         
;         If any of the above criteria are not satisfied, the PowerPC scalar code
;         implementation will be used.
; ________________________________________________________________________________
; 
; 
;  *  fftm_zop()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zop" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (result (:pointer :DSPSplitComplex))
    (resultStride :SInt32)
    (rfftStride :SInt32)
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fftm_zopt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zopt" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (result (:pointer :DSPSplitComplex))
    (resultStride :SInt32)
    (rfftStride :SInt32)
    (temp (:pointer :DSPSplitComplex))
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fftm_zopD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zopD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (resultStride :SInt32)
    (rfftStride :SInt32)
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fftm_zoptD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zoptD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (resultStride :SInt32)
    (rfftStride :SInt32)
    (temp (:pointer :DSPDoubleSplitComplex))
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ________________________________________________________________________________
;       Functions fftm_zrip and fftm_zript
;                 fftm_zripD and fftm_zriptD
;                 
;       In-Place multiple One_Dimensional Real Fourier Transform with or 
;       without temporary memory, Split Complex Format
;       
;          Criteria to invoke PowerPC vector code:
;             1. signal.realp and signal.imagp must be 16-byte aligned.
;             2. signalStride = 1;
;             3. fftStride must be a multiple of 4
;             4. 3 <= log2n <= 13
;             5. temp.realp and temp.imagp must be 16-byte aligned.
;         If any of the above criteria are not satisfied, the PowerPC scalar code
;         implementation will be used.
; ________________________________________________________________________________
; 
; 
;  *  fftm_zrip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zrip" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fftm_zript()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zript" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (temp (:pointer :DSPSplitComplex))
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fftm_zripD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zripD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fftm_zriptD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zriptD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (temp (:pointer :DSPDoubleSplitComplex))
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ________________________________________________________________________________
;       Functions fftm_zrop and fftm_zropt
;                 fftm_zropD and fftm_zroptD
;                 
;       Out-Of-Place multiple One_Dimensional Real Fourier Transform with or 
;       without temporary memory, Split Complex Format
;       
;          Criteria to invoke PowerPC vector code:
;             1. signal.realp and signal.imagp must be 16-byte aligned.
;             2. signalStride = 1;
;             3. fftStride must be a multiple of 4
;             4. result.realp and result.imagp must be 16-byte aligned.
;             5. resultStride = 1;
;             6. rfftStride must be a multiple of 4
;             7. 3 <= log2n <= 13
;             8. temp.realp and temp.imagp must be 16-byte aligned.
;          
;          If any of the above criteria are not satisfied, the PowerPC scalar code
;          implementation will be used.
; ________________________________________________________________________________
; 
; 
;  *  fftm_zrop()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zrop" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (result (:pointer :DSPSplitComplex))
    (resultStride :SInt32)
    (rfftStride :SInt32)
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fftm_zropt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zropt" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (result (:pointer :DSPSplitComplex))
    (resultStride :SInt32)
    (rfftStride :SInt32)
    (temp (:pointer :DSPSplitComplex))
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fftm_zropD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zropD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (resultStride :SInt32)
    (rfftStride :SInt32)
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fftm_zroptD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fftm_zroptD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (signal (:pointer :DSPDoubleSplitComplex))
    (signalStride :SInt32)
    (fftStride :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (resultStride :SInt32)
    (rfftStride :SInt32)
    (temp (:pointer :DSPDoubleSplitComplex))
    (log2n :UInt32)
    (numFFT :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ________________________________________________________________________________
;       Functions fft3_zop and fft5_zop
;                 fft3_zopD and fft5_zopD
;                 
;       Out-Of-Place One_Dimensional Complex Fourier Transform in base-3 and 
;       base-5 with or without temporary memory, Split Complex Format 
;       
;          Criteria to invoke PowerPC vector code:
;             1. signal.realp and signal.imagp must be 16-byte aligned.
;             2. signalStride = 1;
;             3. result.realp and result.imagp must be 16-byte aligned.
;             4. resultStride = 1;
;             5. 3 <= log2n 
;          
;          If any of the above criteria are not satisfied, the PowerPC scalar code
;          implementation will be used.
; ________________________________________________________________________________
; 
; 
;  *  fft3_zop()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft3_zop" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (result (:pointer :DSPSplitComplex))
    (resultStride :SInt32)
    (log2n :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fft5_zop()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft5_zop" 
   ((setup (:pointer :OpaqueFFTSetup))
    (signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (result (:pointer :DSPSplitComplex))
    (resultStride :SInt32)
    (log2n :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fft3_zopD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft3_zopD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (ioData (:pointer :DSPDoubleSplitComplex))
    (K :SInt32)
    (ioData2 (:pointer :DSPDoubleSplitComplex))
    (L :SInt32)
    (log2n :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  fft5_zopD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_fft5_zopD" 
   ((setup (:pointer :OpaqueFFTSetupD))
    (ioData (:pointer :DSPDoubleSplitComplex))
    (K :SInt32)
    (ioData2 (:pointer :DSPDoubleSplitComplex))
    (L :SInt32)
    (log2n :UInt32)
    (flag :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function conv
;              convD
;              
;     Floating Point Convolution and Correlation in Single and Double Precision
;       
;       Criteria to invoke PowerPC vector code:  
;         1. signal and result must have relative alignement.
;         2. 4 <= lenFilter <= 256
;         3. lenResult > 36
;         4. signalStride = 1
;         5. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.  strideFilter can be positive for
;       correlation or negative for convolution.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  conv()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_conv" 
   ((signal (:pointer :float))
    (signalStride :SInt32)
    (filter (:pointer :float))
    (strideFilter :SInt32)
    (result (:pointer :float))
    (strideResult :SInt32)
    (lenResult :SInt32)
    (lenFilter :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  convD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_convD" 
   ((signal (:pointer :double))
    (signalStride :SInt32)
    (filter (:pointer :double))
    (strideFilter :SInt32)
    (result (:pointer :double))
    (strideResult :SInt32)
    (lenResult :SInt32)
    (lenFilter :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; _______________________________________________________________________________
;      Functions f3x3, f5x5, and imgfir
;                f3x3D, f5x5D and imgfirD
;                
;      Filter, 3x3, 5x5, MxN Single and Double Precision Convolution
;      
;        Criteria to invoke PowerPC vector code:
;          1. signal, filter, and result must have relative alignment and
;             be 16-byte aligned.
;          2. for f3x3, NC >= 18
;          3. for f5x5, NC >= 20
;          4. for imgfir, NC >= 20
;        
;        If any of the above criteria are not satisfied, the PowerPC scalar code
;        implementation will be used.
; _______________________________________________________________________________
; 
; 
;  *  f3x3()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_f3x3" 
   ((signal (:pointer :float))
    (rowStride :SInt32)
    (colStride :SInt32)
    (filter (:pointer :float))
    (result (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  f3x3D()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_f3x3D" 
   ((signal (:pointer :double))
    (rowStride :SInt32)
    (colStride :SInt32)
    (filter (:pointer :double))
    (result (:pointer :double))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  f5x5()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_f5x5" 
   ((signal (:pointer :float))
    (rowStride :SInt32)
    (colStride :SInt32)
    (filter (:pointer :float))
    (result (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  f5x5D()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_f5x5D" 
   ((signal (:pointer :double))
    (rowStride :SInt32)
    (colStride :SInt32)
    (filter (:pointer :double))
    (result (:pointer :double))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  imgfir()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_imgfir" 
   ((signal (:pointer :float))
    (numRow :SInt32)
    (numCol :SInt32)
    (filter (:pointer :float))
    (result (:pointer :float))
    (fnumRow :SInt32)
    (fnumCol :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  imgfirD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_imgfirD" 
   ((signal (:pointer :double))
    (numRow :SInt32)
    (numCol :SInt32)
    (filter (:pointer :double))
    (result (:pointer :double))
    (fnumRow :SInt32)
    (fnumCol :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; _______________________________________________________________________________
;      Function mtrans
;               mtransD
;               
;      Single and Double Precision Matrix Transpose
;      
;        Criteria to invoke PowerPC vector code:
;          1. a = c
;          2. a and c must be 16-byte aligned.
;          3. M must be a multiple of 8.
;        
;        If any of the above criteria are not satisfied, the PowerPC scalar code
;        implementation will be used.
; _______________________________________________________________________________
; 
; 
;  *  mtrans()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_mtrans" 
   ((a (:pointer :float))
    (aStride :SInt32)
    (c (:pointer :float))
    (cStride :SInt32)
    (M :SInt32)
    (N :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  mtransD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_mtransD" 
   ((a (:pointer :double))
    (aStride :SInt32)
    (c (:pointer :double))
    (cStride :SInt32)
    (M :SInt32)
    (N :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; _______________________________________________________________________________
;       Function mmul
;                mmulD
;                
;       Single and Double Precision Matrix Multiply
;       
;         Criteria to invoke PowerPC vector code:
;           1. a, b, c must be 16-byte aligned.
;           2. M >= 8.
;           3. N >= 32.
;           4. P is a multiple of 8.
;         
;         If any of the above criteria are not satisfied, the PowerPC scalar code
;         implementation will be used.
; _______________________________________________________________________________
; 
; 
;  *  mmul()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_mmul" 
   ((a (:pointer :float))
    (aStride :SInt32)
    (b (:pointer :float))
    (bStride :SInt32)
    (c (:pointer :float))
    (cStride :SInt32)
    (M :SInt32)
    (N :SInt32)
    (P :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  mmulD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_mmulD" 
   ((a (:pointer :double))
    (aStride :SInt32)
    (b (:pointer :double))
    (bStride :SInt32)
    (c (:pointer :double))
    (cStride :SInt32)
    (M :SInt32)
    (N :SInt32)
    (P :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; _______________________________________________________________________________
;       Function zmma, zmms, zmsm, and zmmul
;                zmmaD, zmmsD, zmsmD, and zmmulD
;                
;       Single and Double Precision Complex Split Matrix mul/add, mul/sub, sub/mul, 
;                                                        and mul
;       
;         Criteria to invoke PowerPC vector code:
;           1. a, b, c, and d must be 16-byte aligned.
;           2. N is a multiple of 4.
;           3. P is a multiple of 4.
;           4. I, J, K, L = 1;
;           
;        If any of the above criteria are not satisfied, the PowerPC scalar code
;        implementation will be used.
; _______________________________________________________________________________
; 
; 
;  *  zmma()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zmma" 
   ((a (:pointer :DSPSplitComplex))
    (i :SInt32)
    (b (:pointer :DSPSplitComplex))
    (j :SInt32)
    (c (:pointer :DSPSplitComplex))
    (k :SInt32)
    (d (:pointer :DSPSplitComplex))
    (l :SInt32)
    (M :SInt32)
    (N :SInt32)
    (P :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  zmmaD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zmmaD" 
   ((a (:pointer :DSPDoubleSplitComplex))
    (i :SInt32)
    (b (:pointer :DSPDoubleSplitComplex))
    (j :SInt32)
    (c (:pointer :DSPDoubleSplitComplex))
    (k :SInt32)
    (d (:pointer :DSPDoubleSplitComplex))
    (l :SInt32)
    (M :SInt32)
    (N :SInt32)
    (P :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  zmms()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zmms" 
   ((a (:pointer :DSPSplitComplex))
    (i :SInt32)
    (b (:pointer :DSPSplitComplex))
    (j :SInt32)
    (c (:pointer :DSPSplitComplex))
    (k :SInt32)
    (d (:pointer :DSPSplitComplex))
    (l :SInt32)
    (M :SInt32)
    (N :SInt32)
    (P :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  zmmsD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zmmsD" 
   ((a (:pointer :DSPDoubleSplitComplex))
    (i :SInt32)
    (b (:pointer :DSPDoubleSplitComplex))
    (j :SInt32)
    (c (:pointer :DSPDoubleSplitComplex))
    (k :SInt32)
    (d (:pointer :DSPDoubleSplitComplex))
    (l :SInt32)
    (M :SInt32)
    (N :SInt32)
    (P :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  zmsm()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zmsm" 
   ((a (:pointer :DSPSplitComplex))
    (i :SInt32)
    (b (:pointer :DSPSplitComplex))
    (j :SInt32)
    (c (:pointer :DSPSplitComplex))
    (k :SInt32)
    (d (:pointer :DSPSplitComplex))
    (l :SInt32)
    (M :SInt32)
    (N :SInt32)
    (P :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  zmsmD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zmsmD" 
   ((a (:pointer :DSPDoubleSplitComplex))
    (i :SInt32)
    (b (:pointer :DSPDoubleSplitComplex))
    (j :SInt32)
    (c (:pointer :DSPDoubleSplitComplex))
    (k :SInt32)
    (d (:pointer :DSPDoubleSplitComplex))
    (l :SInt32)
    (M :SInt32)
    (N :SInt32)
    (P :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  zmmul()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zmmul" 
   ((a (:pointer :DSPSplitComplex))
    (i :SInt32)
    (b (:pointer :DSPSplitComplex))
    (j :SInt32)
    (c (:pointer :DSPSplitComplex))
    (k :SInt32)
    (M :SInt32)
    (N :SInt32)
    (P :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  zmmulD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zmmulD" 
   ((a (:pointer :DSPDoubleSplitComplex))
    (i :SInt32)
    (b (:pointer :DSPDoubleSplitComplex))
    (j :SInt32)
    (c (:pointer :DSPDoubleSplitComplex))
    (k :SInt32)
    (M :SInt32)
    (N :SInt32)
    (P :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function vadd
;              vaddD
;     
;     Floating Point Add in Single and Double Precision
;     
;       Criteria to invoke PowerPC vector code:  
;         1. input1 and input2 and result are all relatively aligned.
;         2. size >= 8
;         3. stride1 = 1
;         4. stride2 = 1
;         5. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vadd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vadd" 
   ((input1 (:pointer :float))
    (stride1 :SInt32)
    (input2 (:pointer :float))
    (stride2 :SInt32)
    (result (:pointer :float))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vaddD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_vaddD" 
   ((input1 (:pointer :double))
    (stride1 :SInt32)
    (input2 (:pointer :double))
    (stride2 :SInt32)
    (result (:pointer :double))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function vsub
;              vsubD
;              
;      Floating Point Substract in Single and Double Precision
;       
;       Criteria to invoke PowerPC vector code:  
;         1. input1 and input2 and result are all relatively aligned.
;         2. size >= 8
;         3. stride1 = 1
;         4. stride2 = 1
;         5. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vsub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vsub" 
   ((input1 (:pointer :float))
    (stride1 :SInt32)
    (input2 (:pointer :float))
    (stride2 :SInt32)
    (result (:pointer :float))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vsubD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_vsubD" 
   ((input1 (:pointer :double))
    (stride1 :SInt32)
    (input2 (:pointer :double))
    (stride2 :SInt32)
    (result (:pointer :double))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function vmul
;              vmulD
;              
;     Floating Point Multiply in Single and Double Precision
;     
;       Criteria to invoke PowerPC vector code:  
;         1. input1 and input2 and result must be all relatively aligned.
;         2. size >= 8
;         3. stride1 = 1
;         4. stride2 = 1
;         5. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vmul()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vmul" 
   ((input1 (:pointer :float))
    (stride1 :SInt32)
    (input2 (:pointer :float))
    (stride2 :SInt32)
    (result (:pointer :float))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vmulD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_vmulD" 
   ((input1 (:pointer :double))
    (stride1 :SInt32)
    (input2 (:pointer :double))
    (stride2 :SInt32)
    (result (:pointer :double))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function vsmul
;              vsmulD
;     
;     Floating Point - Scalar Multiply in Single and Double Precision
;     
;       Criteria to invoke PowerPC vector code:  
;         1. input1 and result are all relatively aligned.
;         2. size >= 8
;         3. stride1 = 1
;         5. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vsmul()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vsmul" 
   ((input1 (:pointer :float))
    (stride1 :SInt32)
    (input2 (:pointer :float))
    (result (:pointer :float))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vsmulD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_vsmulD" 
   ((input1 (:pointer :double))
    (stride1 :SInt32)
    (input2 (:pointer :double))
    (result (:pointer :double))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function vsq
;              vsqD
;     
;     Floating Point Square in Single and Double Precision
;       
;       Criteria to invoke PowerPC vector code:  
;         1. input and result are relatively aligned.
;         2. size >= 8
;         3. strideInput = 1
;         4. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vsq()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vsq" 
   ((input (:pointer :float))
    (strideInput :SInt32)
    (result (:pointer :float))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vsqD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_vsqD" 
   ((input (:pointer :double))
    (strideInput :SInt32)
    (result (:pointer :double))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function vssq
;              vssqD
;              
;     Floating Point Signed Square in Single and Double Precision
;       
;       Criteria to invoke PowerPC vector code:  
;         1. input and result must be all relatively aligned.
;         2. size >= 8
;         3. strideInput = 1
;         4. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vssq()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vssq" 
   ((input (:pointer :float))
    (strideInput :SInt32)
    (result (:pointer :float))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vssqD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_vssqD" 
   ((input (:pointer :double))
    (strideInput :SInt32)
    (result (:pointer :double))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function dotpr
;              dotprD
;     
;     Floating Point Dot product in Single and Double Precision
;     
;       Criteria to invoke PowerPC vector code:  
;         1. input1 and input2 are relatively aligned.
;         2. size >= 20
;         3. stride1 = 1
;         4. stride2 = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  dotpr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_dotpr" 
   ((input1 (:pointer :float))
    (stride1 :SInt32)
    (input2 (:pointer :float))
    (stride2 :SInt32)
    (result (:pointer :float))
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  dotprD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_dotprD" 
   ((input1 (:pointer :double))
    (stride1 :SInt32)
    (input2 (:pointer :double))
    (stride2 :SInt32)
    (result (:pointer :double))
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function vam
;              vamD
;              
;     Floating Point vadd and Multiply in Single and Double Precision
;     
;       Criteria to invoke PowerPC vector code:  
;         1. input1, input2, input_3 and result are all relatively aligned.
;         2. size >= 8
;         3. stride1 = 1
;         4. stride2 = 1
;         5. stride_3 = 1
;         6. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  vam()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_vam" 
   ((input1 (:pointer :float))
    (stride1 :SInt32)
    (input2 (:pointer :float))
    (stride2 :SInt32)
    (input3 (:pointer :float))
    (stride3 :SInt32)
    (result (:pointer :float))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  vamD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_vamD" 
   ((input1 (:pointer :double))
    (stride1 :SInt32)
    (input2 (:pointer :double))
    (stride2 :SInt32)
    (input3 (:pointer :double))
    (stride3 :SInt32)
    (result (:pointer :double))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function zconv
;              zconvD
;                 
;     Split Complex Convolution and Correlation in Single and Double Precision
;       
;       Criteria to invoke PowerPC vector code:  
;         1. signal->realp, signal->imagp, result->realp, result->imagp
;            must be relatively aligned.
;         2. 4 <= lenFilter <= 128
;         3. lenResult > 20
;         4. signalStride = 1
;         5. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.  strideFilter can be positive for correlation
;       or negative for convolution
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  zconv()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_zconv" 
   ((signal (:pointer :DSPSplitComplex))
    (signalStride :SInt32)
    (filter (:pointer :DSPSplitComplex))
    (strideFilter :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResult :SInt32)
    (lenResult :SInt32)
    (lenFilter :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  zconvD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zconvD" 
   ((signal (:pointer :DSPDoubleSplitComplex))
    (signalStride :SInt32)
    (filter (:pointer :DSPDoubleSplitComplex))
    (strideFilter :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResult :SInt32)
    (lenResult :SInt32)
    (lenFilter :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function zvadd
;              zvaddD
;     
;     Split Complex vadd in Single and Double Precision
;       
;       Criteria to invoke PowerPC vector code:  
;         1. input1.realp, input1.imagp, input2.realp, input2.imagp,
;            result.realp, result.imagp must be all relatively aligned.
;         2. size >= 8
;         3. stride1 = 1
;         4. stride2 = 1
;         5. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  zvadd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_zvadd" 
   ((input1 (:pointer :DSPSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :DSPSplitComplex))
    (stride2 :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  zvaddD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zvaddD" 
   ((input1 (:pointer :DSPDoubleSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :DSPDoubleSplitComplex))
    (stride2 :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function zvsub
;              zvsubD
;              
;     Split Complex Substract in Single and Double Precision
;       
;       Criteria to invoke PowerPC vector code:  
;         1. input1.realp, input1.imagp, input2.realp, input2.imagp,
;            result.realp, result.imagp must be all relatively aligned.
;         2. size >= 8
;         3. stride1 = 1
;         4. stride2 = 1
;         5. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  zvsub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_zvsub" 
   ((input1 (:pointer :DSPSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :DSPSplitComplex))
    (stride2 :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  zvsubD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zvsubD" 
   ((input1 (:pointer :DSPDoubleSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :DSPDoubleSplitComplex))
    (stride2 :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function zvmul
;              zvmulD
;              
;     Split Complex Multiply in Single and Double Precision
;       
;       Criteria to invoke PowerPC vector code:  
;         1. input1.realp, input1.imagp, input2.realp, input2.imagp,
;            result.realp, result.imagp must be all relatively aligned.
;         2. size >= 8
;         3. stride1 = 1
;         4. stride2 = 1
;         5. strideResult = 1
; 
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.  The conjugate value can be 1 or -1.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  zvmul()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_zvmul" 
   ((input1 (:pointer :DSPSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :DSPSplitComplex))
    (stride2 :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
    (conjugate :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  zvmulD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zvmulD" 
   ((input1 (:pointer :DSPDoubleSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :DSPDoubleSplitComplex))
    (stride2 :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
    (conjugate :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function zdotpr
;              zdotprD
;              
;     Split Complex Dot product in Single and Double Precision
;     
;       Criteria to invoke PowerPC vector code:  
;         1. input1.realp, input1.imagp, input2.realp, input2.imagp are all
;            relatively aligned.
;         2. size >= 20
;         3. stride1 = 1
;         4. stride2 = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  zdotpr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_zdotpr" 
   ((input1 (:pointer :DSPSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :DSPSplitComplex))
    (stride2 :SInt32)
    (result (:pointer :DSPSplitComplex))
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  zdotprD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zdotprD" 
   ((input1 (:pointer :DSPDoubleSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :DSPDoubleSplitComplex))
    (stride2 :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function zidotpr
;              zidotprD
;              
;     Split Complex Inner Dot product in Single and Double Precision
;     
;       Criteria to invoke PowerPC vector code:  
;         1. input1.realp, input1.imagp, input2.realp, input2.imagp must be
;            all relatively aligned.
;         2. size >= 20
;         3. stride1 = 1
;         4. stride2 = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  zidotpr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_zidotpr" 
   ((input1 (:pointer :DSPSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :DSPSplitComplex))
    (stride2 :SInt32)
    (result (:pointer :DSPSplitComplex))
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  zidotprD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zidotprD" 
   ((input1 (:pointer :DSPDoubleSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :DSPDoubleSplitComplex))
    (stride2 :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function zrdotpr
;              zrdotprD
;                 
;     Split Complex - Real Dot product in Single and Double Precision
;       
;       Criteria to invoke PowerPC vector code:  
;         1. input1.realp, input1.imagp, input2 are must be relatively aligned.
;         2. size >= 16
;         3. stride1 = 1
;         4. stride2 = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  zrdotpr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_zrdotpr" 
   ((input1 (:pointer :DSPSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :float))
    (stride2 :SInt32)
    (result (:pointer :DSPSplitComplex))
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  zrdotprD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zrdotprD" 
   ((input1 (:pointer :DSPDoubleSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :double))
    (stride2 :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function zvcma
;              zvcmaD
;              
;     Split Complex Conjugate Multiply And vadd in Single and Double Precision
;     
;       Criteria to invoke PowerPC vector code:  
;         1. input1.realp, input1.imagp, input2.realp, input2.imagp,
;           input_3.realp, input_3.imagp, result.realp, result.imagp
;           must be all relatively aligned.
;         2. size >= 8
;         3. stride1 = 1
;         4. stride2 = 1
;         5. stride_3 = 1
;         6. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  zvcma()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_zvcma" 
   ((input1 (:pointer :DSPSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :DSPSplitComplex))
    (stride2 :SInt32)
    (input3 (:pointer :DSPSplitComplex))
    (stride3 :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  zvcmaD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zvcmaD" 
   ((input1 (:pointer :DSPDoubleSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :DSPDoubleSplitComplex))
    (stride2 :SInt32)
    (input3 (:pointer :DSPDoubleSplitComplex))
    (stride3 :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function zrvadd
;              zrvaddD
;              
;     Split Complex - Real Add in Single and Double Precision
;       
;       Criteria to invoke PowerPC vector code:  
;         1. input1.realp, input1.imagp, input2, result.realp, result.imagp
;            are all relatively aligned.
;         2. size >= 8
;         3. stride1 = 1
;         4. stride2 = 1
;         5. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  zrvadd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_zrvadd" 
   ((input1 (:pointer :DSPSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :float))
    (stride2 :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  zrvaddD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zrvaddD" 
   ((input1 (:pointer :DSPDoubleSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :double))
    (stride2 :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function zrvsub
;              zrvsubD
;                 
;     Split Complex - Real Substract in Single and Double Precision
;     
;       Criteria to invoke PowerPC vector code:  
;         1. input1.realp, input1.imagp, input2, result.realp, result.imagp
;            must be all relatively aligned.
;         2. size >= 8
;         3. stride1 = 1
;         4. stride2 = 1
;         5. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  zrvsub()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_zrvsub" 
   ((input1 (:pointer :DSPSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :float))
    (stride2 :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  zrvsubD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zrvsubD" 
   ((input1 (:pointer :DSPDoubleSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :double))
    (stride2 :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     Function zrvmul
;              zrvmulD
;              
;     Split Complex - Real Multiply
;     
;       Criteria to invoke PowerPC vector code:  
;         1. input1.realp, input1.imagp, input2, result.realp, result.imagp
;            must be all relatively aligned.
;         2. size >= 8
;         3. stride1 = 1
;         4. stride2 = 1
;         5. strideResult = 1
;       
;       If any of the above criteria are not satisfied, the PowerPC scalar code
;       implementation will be used.
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  zrvmul()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in vecLib.framework
;  *    CarbonLib:        not in Carbon, but vecLib is compatible with CarbonLib
;  *    Non-Carbon CFM:   in vecLib 1.0 and later
;  

(deftrap-inline "_zrvmul" 
   ((input1 (:pointer :DSPSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :float))
    (stride2 :SInt32)
    (result (:pointer :DSPSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  zrvmulD()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in vecLib.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_zrvmulD" 
   ((input1 (:pointer :DSPDoubleSplitComplex))
    (stride1 :SInt32)
    (input2 (:pointer :double))
    (stride2 :SInt32)
    (result (:pointer :DSPDoubleSplitComplex))
    (strideResult :SInt32)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; #ifndef USE_NON_APPLE_STANDARD_DATATYPES
(defconstant $USE_NON_APPLE_STANDARD_DATATYPES 1)
; #define USE_NON_APPLE_STANDARD_DATATYPES 1

; #endif  /* !defined(USE_NON_APPLE_STANDARD_DATATYPES) */


; #if USE_NON_APPLE_STANDARD_DATATYPES

(defconstant $FFT_FORWARD 1)
(defconstant $FFT_INVERSE -1)

(defconstant $FFT_RADIX2 0)
(defconstant $FFT_RADIX3 1)
(defconstant $FFT_RADIX5 2)

(%define-record :COMPLEX (find-record-descriptor ':DSPComplex))

(%define-record :COMPLEX_SPLIT (find-record-descriptor ':DSPSplitComplex))

(%define-record :DOUBLE_COMPLEX (find-record-descriptor ':DSPDoubleComplex))

(%define-record :DOUBLE_COMPLEX_SPLIT (find-record-descriptor ':DSPDoubleSplitComplex))

; #endif  /* USE_NON_APPLE_STANDARD_DATATYPES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __VDSP__ */


(provide-interface "vDSP")