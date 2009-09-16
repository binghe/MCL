(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGPDFPage.h"
; at Sunday July 2,2006 7:23:54 pm.
;  CoreGraphics - CGPDFPage.h
;  * Copyright (c) 2001-2003 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGPDFPAGE_H_
; #define CGPDFPAGE_H_

(def-mactype :CGPDFPageRef (find-mactype '(:pointer :CGPDFPage)))

(require-interface "CoreGraphics/CGAffineTransform")

(require-interface "CoreGraphics/CGPDFDictionary")

(require-interface "CoreGraphics/CGPDFDocument")

(require-interface "AvailabilityMacros")
(def-mactype :CGPDFBox (find-mactype ':sint32))

(defconstant $kCGPDFMediaBox 0)
(defconstant $kCGPDFCropBox 1)
(defconstant $kCGPDFBleedBox 2)
(defconstant $kCGPDFTrimBox 3)
(defconstant $kCGPDFArtBox 4)

;type name? (def-mactype :CGPDFBox (find-mactype ':CGPDFBox))
;  Equivalent to `CFRetain(page)', except it doesn't crash (as CFRetain
;  * does) if `page' is NULL. 

(deftrap-inline "_CGPDFPageRetain" 
   ((page (:pointer :CGPDFPage))
   )
   (:pointer :CGPDFPage)
() )
;  Equivalent to `CFRelease(page)', except it doesn't crash (as CFRelease
;  * does) if `page' is NULL. 

(deftrap-inline "_CGPDFPageRelease" 
   ((page (:pointer :CGPDFPage))
   )
   nil
() )
;  Return the document of `page'. 

(deftrap-inline "_CGPDFPageGetDocument" 
   ((page (:pointer :CGPDFPage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :CGPDFDocument)
() )
;  Return the page number of `page'. 

(deftrap-inline "_CGPDFPageGetPageNumber" 
   ((page (:pointer :CGPDFPage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :unsigned-long
() )
;  Return the rectangle associated with `box' in `page'.  This is the value
;  * of the corresponding entry (such as /MediaBox, /ArtBox, and so on) in
;  * the page's dictionary. 

(deftrap-inline "_CGPDFPageGetBoxRect" 
   ((returnArg (:pointer :CGRect))
    (page (:pointer :CGPDFPage))
    (box :CGPDFBox)
   )
   nil
() )
;  Return the rotation angle (in degrees) of `page'.  This is the value of
;  * the /Rotate entry in the page's dictionary. 

(deftrap-inline "_CGPDFPageGetRotationAngle" 
   ((page (:pointer :CGPDFPage))
   )
   :signed-long
() )
;  Return a transform mapping the box specified by `box' to `rect' as
;  * follows:
;  *   - Compute the effective rect by intersecting the rect associated with
;  *     `box' and the /MediaBox entry of the page.
;  *   - Rotate the effective rect according to the page's /Rotate entry.
;  *   - Center the resulting rect on `rect'.  If `rotation' is non-zero,
;  *     then the rect will rotated clockwise by `rotation' degrees.
;  *     `rotation' must be a multiple of 90.
;  *   - Scale the rect down, if necessary, so that it coincides with the
;  *     edges of `rect'.  If `preserveAspectRatio' is true, then the final
;  *     rect will coincide with the edges of `rect' only in the more
;  *     restrictive dimension. 

(deftrap-inline "_CGPDFPageGetDrawingTransform" 
   ((returnArg (:pointer :CGAFFINETRANSFORM))
    (page (:pointer :CGPDFPage))
    (box :CGPDFBox)
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
    (rotate :signed-long)
    (preserveAspectRatio :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
;  Return the dictionary of `page'. 

(deftrap-inline "_CGPDFPageGetDictionary" 
   ((page (:pointer :CGPDFPage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :CGPDFDictionary)
() )
;  Return the CFTypeID for CGPDFPageRefs. 

(deftrap-inline "_CGPDFPageGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )

; #endif	/* CGPDFPAGE_H_ */


(provide-interface "CGPDFPage")