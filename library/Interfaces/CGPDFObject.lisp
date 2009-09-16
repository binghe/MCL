(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGPDFObject.h"
; at Sunday July 2,2006 7:23:54 pm.
;  CoreGraphics - CGPDFObject.h
;  * Copyright (c) 2002-2003 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGPDFOBJECT_H_
; #define CGPDFOBJECT_H_

(require-interface "CoreGraphics/CGBase")

(require-interface "AvailabilityMacros")
;  A type for boolean values. 

(def-mactype :CGPDFBoolean (find-mactype ':UInt8))
;  A type for integer values. 

(def-mactype :int (find-mactype ':signed-long)) ; CGPDFInteger
;  A type for real values. 

(def-mactype :CGPDFReal (find-mactype ':single-float))
;  A type to hold any object. 

(def-mactype :CGPDFObjectRef (find-mactype '(:pointer :CGPDFObject)))
;  An identifier to describe an object's type. 
(def-mactype :CGPDFObjectType (find-mactype ':sint32))

(defconstant $kCGPDFObjectTypeNull 1)
(defconstant $kCGPDFObjectTypeBoolean 2)
(defconstant $kCGPDFObjectTypeInteger 3)
(defconstant $kCGPDFObjectTypeReal 4)
(defconstant $kCGPDFObjectTypeName 5)
(defconstant $kCGPDFObjectTypeString 6)
(defconstant $kCGPDFObjectTypeArray 7)
(defconstant $kCGPDFObjectTypeDictionary 8)
(defconstant $kCGPDFObjectTypeStream 9)

;type name? (def-mactype :CGPDFObjectType (find-mactype ':CGPDFObjectType))
;  Return the type of `object'. 

(deftrap-inline "_CGPDFObjectGetType" 
   ((object (:pointer :CGPDFObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :CGPDFObjectType
() )
;  Get the value of `object'.  If the type of `object' is equal to `type',
;  * then copy the value of `object' to `value' (if it's non-NULL) and return
;  * true.  Otherwise, if the type of `object' is `kCGPDFObjectTypeInteger'
;  * and `type' is equal to `kCGPDFObjectTypeReal', then convert the value of
;  * `object' to floating point and copy the result to `value' (if it's
;  * non-NULL) and return true. Otherwise, return false. 

(deftrap-inline "_CGPDFObjectGetValue" 
   ((object (:pointer :CGPDFObject))
    (type :CGPDFObjectType)
    (value :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )

; #endif	/* CGPDFOBJECT_H_ */


(provide-interface "CGPDFObject")