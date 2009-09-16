(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGPDFArray.h"
; at Sunday July 2,2006 7:23:54 pm.
;  CoreGraphics - CGPDFArray.h
;  * Copyright (c) 2002-2003 Apple Computer, Inc. (unpublished)
;  * All rights reserved.
;  
; #ifndef CGPDFARRAY_H_
; #define CGPDFARRAY_H_

(def-mactype :CGPDFArrayRef (find-mactype '(:pointer :CGPDFArray)))

(require-interface "CoreGraphics/CGPDFDictionary")

(require-interface "CoreGraphics/CGPDFObject")

(require-interface "CoreGraphics/CGPDFStream")

(require-interface "CoreGraphics/CGPDFString")
;  Return the number of items in `array'. 

(deftrap-inline "_CGPDFArrayGetCount" 
   ((array (:pointer :CGPDFArray))
   )
   :unsigned-long
() )
;  Look up the object at `index' in `array' and return the result in
;  * `value'. Return true on success; false otherwise. 

(deftrap-inline "_CGPDFArrayGetObject" 
   ((array (:pointer :CGPDFArray))
    (index :unsigned-long)
    (value (:pointer :CGPDFOBJECTREF))
   )
   :Boolean
() )
;  Look up the object at `index' in `array' and, if it's a null, return
;  * true; otherwise, return false. 

(deftrap-inline "_CGPDFArrayGetNull" 
   ((array (:pointer :CGPDFArray))
    (index :unsigned-long)
   )
   :Boolean
() )
;  Look up the object at `index' in `array' and, if it's a boolean, return
;  * the result in `value'.  Return true on success; false otherwise. 

(deftrap-inline "_CGPDFArrayGetBoolean" 
   ((array (:pointer :CGPDFArray))
    (index :unsigned-long)
    (value (:pointer :CGPDFBOOLEAN))
   )
   :Boolean
() )
;  Look up the object at `index' in `array' and, if it's an integer, return
;  * the result in `value'.  Return true on success; false otherwise. 

(deftrap-inline "_CGPDFArrayGetInteger" 
   ((array (:pointer :CGPDFArray))
    (index :unsigned-long)
    (value (:pointer :cgpdfinteger))
   )
   :Boolean
() )
;  Look up the object at `index' in `array' and, if it's a number (real or
;  * integer), return the result in `value'.  Return true on success; false
;  * otherwise. 

(deftrap-inline "_CGPDFArrayGetNumber" 
   ((array (:pointer :CGPDFArray))
    (index :unsigned-long)
    (value (:pointer :CGPDFREAL))
   )
   :Boolean
() )
;  Look up the object at `index' in `array' and, if it's a name, return the
;  * result in `value'.  Return true on success; false otherwise. 

(deftrap-inline "_CGPDFArrayGetName" 
   ((array (:pointer :CGPDFArray))
    (index :unsigned-long)
    (value (:pointer :char))
   )
   :Boolean
() )
;  Look up the object at `index' in `array' and, if it's a string, return
;  * the result in `value'.  Return true on success; false otherwise. 

(deftrap-inline "_CGPDFArrayGetString" 
   ((array (:pointer :CGPDFArray))
    (index :unsigned-long)
    (value (:pointer :CGPDFSTRINGREF))
   )
   :Boolean
() )
;  Look up the object at `index' in `array' and, if it's an array, return
;  * it in `value'.  Return true on success; false otherwise. 

(deftrap-inline "_CGPDFArrayGetArray" 
   ((array (:pointer :CGPDFArray))
    (index :unsigned-long)
    (value (:pointer :CGPDFARRAYREF))
   )
   :Boolean
() )
;  Look up the object at `index' in `array' and, if it's a dictionary,
;  * return it in `value'.  Return true on success; false otherwise. 

(deftrap-inline "_CGPDFArrayGetDictionary" 
   ((array (:pointer :CGPDFArray))
    (index :unsigned-long)
    (value (:pointer :CGPDFDictionaryRef))
   )
   :Boolean
() )
;  Look up the object at `index' in `array' and, if it's a stream, return
;  * it in `value'.  Return true on success; false otherwise. 

(deftrap-inline "_CGPDFArrayGetStream" 
   ((array (:pointer :CGPDFArray))
    (index :unsigned-long)
    (value (:pointer :CGPDFSTREAMREF))
   )
   :Boolean
() )

; #endif	/* CGPDFARRAY_H_ */


(provide-interface "CGPDFArray")