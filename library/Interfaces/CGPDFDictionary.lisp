(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGPDFDictionary.h"
; at Sunday July 2,2006 7:23:54 pm.
;  CoreGraphics - CGPDFDictionary.h
;  * Copyright (c) 2002-2003 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGPDFDICTIONARY_H_
; #define CGPDFDICTIONARY_H_

(def-mactype :CGPDFDictionaryRef (find-mactype '(:pointer :CGPDFDictionary)))

(require-interface "CoreGraphics/CGPDFArray")

(require-interface "CoreGraphics/CGPDFObject")

(require-interface "CoreGraphics/CGPDFStream")

(require-interface "CoreGraphics/CGPDFString")

(require-interface "AvailabilityMacros")
;  Return the number of entries in `dictionary'. 

(deftrap-inline "_CGPDFDictionaryGetCount" 
   ((dict (:pointer :CGPDFDictionary))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :unsigned-long
() )
;  Look up the object associated with `key' in `dict' and return the result
;  * in `value'. Return true on success; false otherwise. 

(deftrap-inline "_CGPDFDictionaryGetObject" 
   ((dict (:pointer :CGPDFDictionary))
    (key (:pointer :char))
    (value (:pointer :CGPDFOBJECTREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Look up the object associated with `key' in `dict' and, if it's a
;  * boolean, return the result in `value'.  Return true on success; false
;  * otherwise. 

(deftrap-inline "_CGPDFDictionaryGetBoolean" 
   ((dict (:pointer :CGPDFDictionary))
    (key (:pointer :char))
    (value (:pointer :CGPDFBOOLEAN))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Look up the object associated with `key' in `dict' and, if it's an
;  * integer, return the result in `value'.  Return true on success; false
;  * otherwise. 

(deftrap-inline "_CGPDFDictionaryGetInteger" 
   ((dict (:pointer :CGPDFDictionary))
    (key (:pointer :char))
    (value (:pointer :cgpdfinteger))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Look up the object associated with `key' in `dict' and, if it's a number
;  * (real or integer), return the result in `value'.  Return true on
;  * success; false otherwise. 

(deftrap-inline "_CGPDFDictionaryGetNumber" 
   ((dict (:pointer :CGPDFDictionary))
    (key (:pointer :char))
    (value (:pointer :CGPDFREAL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Look up the object associated with `key' in `dict' and, if it's a name,
;  * return the result in `value'.  Return true on success; false
;  * otherwise. 

(deftrap-inline "_CGPDFDictionaryGetName" 
   ((dict (:pointer :CGPDFDictionary))
    (key (:pointer :char))
    (value (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Look up the object associated with `key' in `dict' and, if it's a
;  * string, return the result in `value'.  Return true on success; false
;  * otherwise. 

(deftrap-inline "_CGPDFDictionaryGetString" 
   ((dict (:pointer :CGPDFDictionary))
    (key (:pointer :char))
    (value (:pointer :CGPDFSTRINGREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Look up the object associated with `key' in `dict' and, if it's an
;  * array, return the result in `value'.  Return true on success; false
;  * otherwise. 

(deftrap-inline "_CGPDFDictionaryGetArray" 
   ((dict (:pointer :CGPDFDictionary))
    (key (:pointer :char))
    (value (:pointer :CGPDFARRAYREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Look up the object associated with `key' in `dict' and, if it's a
;  * dictionary, return the result in `value'.  Return true on success; false
;  * otherwise. 

(deftrap-inline "_CGPDFDictionaryGetDictionary" 
   ((dict (:pointer :CGPDFDictionary))
    (key (:pointer :char))
    (value (:pointer :CGPDFDictionaryRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Look up the object associated with `key' in `dict' and, if it's a
;  * stream, return the result in `value'. Return true on success; false
;  * otherwise. 

(deftrap-inline "_CGPDFDictionaryGetStream" 
   ((dict (:pointer :CGPDFDictionary))
    (key (:pointer :char))
    (value (:pointer :CGPDFSTREAMREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  The callback for `CGPDFDictionaryApplyFunction'.  `key' is the current
;  * key, `value' is the value for `key', and `info' is the parameter passed
;  * to `CGPDFDictionaryApplyFunction'. 

(def-mactype :CGPDFDictionaryApplierFunction (find-mactype ':pointer)); (const char * key , CGPDFObjectRef value , void * info)
;  Enumerate all of the keys in `dict', calling `function' once for each
;  * key/value pair.  Passes the current key, the associated value, and
;  * `info' to `function'. 

(deftrap-inline "_CGPDFDictionaryApplyFunction" 
   ((dict (:pointer :CGPDFDictionary))
    (function :pointer)
    (info :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :void
() )

; #endif	/* CGPDFDICTIONARY_H_ */


(provide-interface "CGPDFDictionary")