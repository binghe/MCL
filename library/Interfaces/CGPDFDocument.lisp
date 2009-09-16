(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGPDFDocument.h"
; at Sunday July 2,2006 7:23:53 pm.
;  CoreGraphics - CGPDFDocument.h
;  * Copyright (c) 2000-2003 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGPDFDOCUMENT_H_
; #define CGPDFDOCUMENT_H_

(def-mactype :CGPDFDocumentRef (find-mactype '(:pointer :CGPDFDocument)))

(require-interface "CoreGraphics/CGDataProvider")

(require-interface "CoreGraphics/CGGeometry")

(require-interface "CoreGraphics/CGPDFPage")

(require-interface "CoreFoundation/CFURL")
;  Create a PDF document, using `provider' to obtain the document's
;  * data. 

(deftrap-inline "_CGPDFDocumentCreateWithProvider" 
   ((provider (:pointer :CGDataProvider))
   )
   (:pointer :CGPDFDocument)
() )
;  Create a PDF document from `url'. 

(deftrap-inline "_CGPDFDocumentCreateWithURL" 
   ((url (:pointer :__CFURL))
   )
   (:pointer :CGPDFDocument)
() )
;  Equivalent to `CFRetain(document)', except it doesn't crash (as CFRetain
;  * does) if `document' is NULL. 

(deftrap-inline "_CGPDFDocumentRetain" 
   ((document (:pointer :CGPDFDocument))
   )
   (:pointer :CGPDFDocument)
() )
;  Equivalent to `CFRelease(document)', except it doesn't crash (as
;  * CFRelease does) if `document' is NULL. 

(deftrap-inline "_CGPDFDocumentRelease" 
   ((document (:pointer :CGPDFDocument))
   )
   nil
() )
;  Return the major and minor version numbers of `document'. 

(deftrap-inline "_CGPDFDocumentGetVersion" 
   ((document (:pointer :CGPDFDocument))
    (majorVersion (:pointer :INT))
    (minorVersion (:pointer :INT))
   )
   nil
() )
;  Return true if the PDF file associated with `document' is encrypted;
;  * false otherwise.  If the PDF file is encrypted, then a password must be
;  * supplied before certain operations are enabled; different passwords may
;  * enable different operations. 

(deftrap-inline "_CGPDFDocumentIsEncrypted" 
   ((document (:pointer :CGPDFDocument))
   )
   :Boolean
() )
;  Use `password' to decrypt `document' and grant permission for certain
;  * operations.  Returns true if `password' is a valid password; false
;  * otherwise. 

(deftrap-inline "_CGPDFDocumentUnlockWithPassword" 
   ((document (:pointer :CGPDFDocument))
    (password (:pointer :char))
   )
   :Boolean
() )
;  Return true if `document' is unlocked; false otherwise.  A document is
;  * unlocked if it isn't encrypted, or if it is encrypted and a valid password
;  * was previously specified with CGPDFDocumentUnlockWithPassword. 

(deftrap-inline "_CGPDFDocumentIsUnlocked" 
   ((document (:pointer :CGPDFDocument))
   )
   :Boolean
() )
;  Return true if `document' allows printing; false otherwise.  Typically,
;  * this function returns false only if the document is encrypted and the
;  * document's current password doesn't grant permission to perform
;  * printing. 

(deftrap-inline "_CGPDFDocumentAllowsPrinting" 
   ((document (:pointer :CGPDFDocument))
   )
   :Boolean
() )
;  Return true if `document' allows copying; false otherwise.  Typically,
;  * this function returns false only if the document is encrypted and the
;  * document's current password doesn't grant permission to perform
;  * copying. 

(deftrap-inline "_CGPDFDocumentAllowsCopying" 
   ((document (:pointer :CGPDFDocument))
   )
   :Boolean
() )
;  Return the number of pages in `document'. 

(deftrap-inline "_CGPDFDocumentGetNumberOfPages" 
   ((document (:pointer :CGPDFDocument))
   )
   :unsigned-long
() )
;  Return the page corresponding to `pageNumber', or NULL if no such page
;  * exists in the document.  Pages are numbered starting at 1. 

(deftrap-inline "_CGPDFDocumentGetPage" 
   ((document (:pointer :CGPDFDocument))
    (pageNumber :unsigned-long)
   )
   (:pointer :CGPDFPage)
() )
;  Return the document catalog of `document'. 

(deftrap-inline "_CGPDFDocumentGetCatalog" 
   ((document (:pointer :CGPDFDocument))
   )
   (:pointer :CGPDFDictionary)
() )
;  Return the CFTypeID for CGPDFDocumentRefs. 

(deftrap-inline "_CGPDFDocumentGetTypeID" 
   (
   )
   :UInt32
() )
;  The following functions are deprecated in favor of the CGPDFPage API. 
;  DEPRECATED; return the media box of page number `page' in `document'. 

(deftrap-inline "_CGPDFDocumentGetMediaBox" 
   ((returnArg (:pointer :CGRect))
    (document (:pointer :CGPDFDocument))
    (page :signed-long)
   )
   nil
() )
;  DEPRECATED; return the crop box of page number `page' in `document'. 

(deftrap-inline "_CGPDFDocumentGetCropBox" 
   ((returnArg (:pointer :CGRect))
    (document (:pointer :CGPDFDocument))
    (page :signed-long)
   )
   nil
() )
;  DEPRECATED; return the bleed box of page number `page' in `document'. 

(deftrap-inline "_CGPDFDocumentGetBleedBox" 
   ((returnArg (:pointer :CGRect))
    (document (:pointer :CGPDFDocument))
    (page :signed-long)
   )
   nil
() )
;  DEPRECATED; return the trim box of page number `page' in `document'. 

(deftrap-inline "_CGPDFDocumentGetTrimBox" 
   ((returnArg (:pointer :CGRect))
    (document (:pointer :CGPDFDocument))
    (page :signed-long)
   )
   nil
() )
;  DEPRECATED; return the art box of page number `page' in `document'. 

(deftrap-inline "_CGPDFDocumentGetArtBox" 
   ((returnArg (:pointer :CGRect))
    (document (:pointer :CGPDFDocument))
    (page :signed-long)
   )
   nil
() )
;  DEPRECATED; return the rotation angle (in degrees) of page number `page'
;  * in `document'. 

(deftrap-inline "_CGPDFDocumentGetRotationAngle" 
   ((document (:pointer :CGPDFDocument))
    (page :signed-long)
   )
   :signed-long
() )

; #endif	/* CGPDFDOCUMENT_H_ */


(provide-interface "CGPDFDocument")