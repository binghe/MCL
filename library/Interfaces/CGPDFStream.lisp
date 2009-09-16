(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGPDFStream.h"
; at Sunday July 2,2006 7:23:55 pm.
;  CoreGraphics - CGPDFStream.h
;  * Copyright (c) 2002-2003 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGPDFSTREAM_H_
; #define CGPDFSTREAM_H_

(def-mactype :CGPDFStreamRef (find-mactype '(:pointer :CGPDFStream)))
(def-mactype :CGPDFDataFormat (find-mactype ':sint32))

(defconstant $CGPDFDataFormatRaw 0)
(defconstant $CGPDFDataFormatJPEGEncoded 1)

;type name? (def-mactype :CGPDFDataFormat (find-mactype ':CGPDFDataFormat))

(require-interface "CoreGraphics/CGPDFDictionary")

(require-interface "CoreGraphics/CGPDFStream")

(require-interface "CoreFoundation/CFData")
;  Return the dictionary of `stream'. 

(deftrap-inline "_CGPDFStreamGetDictionary" 
   ((stream (:pointer :CGPDFStream))
   )
   (:pointer :CGPDFDictionary)
() )
;  Return the data of `stream'. 

(deftrap-inline "_CGPDFStreamCopyData" 
   ((stream (:pointer :CGPDFStream))
    (format (:pointer :CGPDFDataFormat))
   )
   (:pointer :__CFData)
() )

; #endif	/* CGPDFSTREAM_H_ */


(provide-interface "CGPDFStream")