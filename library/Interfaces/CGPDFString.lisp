(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGPDFString.h"
; at Sunday July 2,2006 7:23:55 pm.
;  CoreGraphics - CGPDFString.h
;  * Copyright (c) 2002-2003 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGPDFSTRING_H_
; #define CGPDFSTRING_H_

(def-mactype :CGPDFStringRef (find-mactype '(:pointer :CGPDFString)))

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreFoundation/CFString")
;  Return the length of `string'. 

(deftrap-inline "_CGPDFStringGetLength" 
   ((string (:pointer :CGPDFString))
   )
   :unsigned-long
() )
;  Return a pointer to the bytes of `string'. 

(deftrap-inline "_CGPDFStringGetBytePtr" 
   ((string (:pointer :CGPDFString))
   )
   (:pointer :UInt8)
() )
;  Return a CFString representing `string' as a "text string".  See Section
;  * 3.8.1 "Text Strings", PDF Reference: Adobe PDF version 1.4 (3rd ed.)
;  * for more information. 

(deftrap-inline "_CGPDFStringCopyTextString" 
   ((string (:pointer :CGPDFString))
   )
   (:pointer :__CFString)
() )

; #endif	/* CGPDFSTRING_H_ */


(provide-interface "CGPDFString")