(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QDPictToCGContext.h"
; at Sunday July 2,2006 7:24:30 pm.
; 
;      File:       QD/QDPictToCGContext.h
;  
;      Contains:   API to draw Quickdraw PICTs into CoreGraphics context
;  
;      Version:    Quickdraw-150~1
;  
;      Copyright:  © 2001-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __QDPICTTOCGCONTEXT__
; #define __QDPICTTOCGCONTEXT__
; #ifndef __CGCONTEXT__

(require-interface "CoreGraphics/CGContext")

; #endif


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

(def-mactype :QDPictRef (find-mactype '(:pointer :QDPict)))
; 
;     Note: QuickDraw picture data typically comes in two forms: a PICT resource
;     that begins the picture header data at the beginning of the resource and PICT
;     files that begin with 512 bytes of arbitrary data, followed by
;     the picture header data. For this reason, the routines that create a QDPictRef
;     attempt to find the picture header data beginning at either the first byte
;     of the data provided or at byte 513 of the data provided.
;     
;     Additionally the Picture Bounds must not be an empty rect.
; 
;  Create a QDPict reference, using `provider' to obtain the QDPict's data. 
;  * It is assumed that either the first byte or the 513th byte of data
;  * in the file referenced by the URL is the first byte of the
;  * picture header. If the URL does not begin PICT data at one
;  * of these places in the data fork then the QDPictRef returned will be NULL.
; 
; 
;  *  QDPictCreateWithProvider()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDPictCreateWithProvider" 
   ((provider (:pointer :CGDataProvider))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :QDPict)
() )
;  Create a QDPict reference from `url'. 
;  * It is assumed that either the first byte or the 513th byte of data
;  * in the file referenced by the URL is the first byte of the
;  * picture header. If the URL does not begin PICT data at one
;  * of these places in the data fork then the QDPictRef returned will be NULL.
; 
; 
;  *  QDPictCreateWithURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDPictCreateWithURL" 
   ((url (:pointer :__CFURL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :QDPict)
() )
;  Increment the retain count of `pictRef' and return it.  All 
;  * pictRefs are created with an initial retain count of 1. 
; 
;  *  QDPictRetain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDPictRetain" 
   ((pictRef (:pointer :QDPict))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :QDPict)
() )
;  Decrement the retain count of `pictRef'.  If the retain count reaches 0,
;  * then free it and any associated resources. 
; 
;  *  QDPictRelease()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDPictRelease" 
   ((pictRef (:pointer :QDPict))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
;  Return the Picture Bounds of the QuickDraw picture represented by `pictRef'. This
;     rectangle is in the default user space with one unit = 1/72 inch.
; 
; 
;  *  QDPictGetBounds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDPictGetBounds" 
   ((returnArg (:pointer :CGRect))
    (pictRef (:pointer :QDPict))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
;  Return the resolution of the QuickDraw picture represented by `pictRef'.
;     This data, together with the CGRect returned by QDPictGetBounds, can be
;     used to compute the size of the picture in pixels, which is what QuickDraw
;     really records into pictures.
; 
; 
;  *  QDPictGetResolution()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDPictGetResolution" 
   ((pictRef (:pointer :QDPict))
    (xRes (:pointer :float))
    (yRes (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
;  Draw `pictRef' in the rectangular area specified by `rect'.
;  * The PICT bounds of the page is scaled, if necessary, to fit into
;  * `rect'. To get unscaled results, supply a rect the size of the rect
;  * returned by QDPictGetBounds.
; 
; 
;  *  QDPictDrawToCGContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDPictDrawToCGContext" 
   ((ctx (:pointer :CGContext))
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
    (pictRef (:pointer :QDPict))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __QDPICTTOCGCONTEXT__ */


(provide-interface "QDPictToCGContext")