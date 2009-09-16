(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGPSConverter.h"
; at Sunday July 2,2006 7:24:19 pm.
;  CoreGraphics - CGPSConverter.h
;  * Copyright (c) 2003 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGPSCONVERTER_H_
; #define CGPSCONVERTER_H_

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreGraphics/CGDataConsumer")

(require-interface "CoreGraphics/CGDataProvider")

(require-interface "CoreFoundation/CFDictionary")

(require-interface "CoreFoundation/CFString")

(require-interface "AvailabilityMacros")

(def-mactype :CGPSConverterRef (find-mactype '(:pointer :CGPSConverter)))
;  CGPSConverter callbacks.
;  *
;  * `version' is the version number of the structure passed in as a
;  * parameter to the converter creation functions. The structure defined
;  * below is version 0.
;  *
;  * `beginDocument', if non-NULL, is called at the beginning of the
;  * conversion of the PostScript document.
;  *
;  * `endDocument', if non-NULL, is called at the end of conversion of the
;  * PostScript document.
;  *
;  * `beginPage', if non-NULL, is called at the start of the conversion of
;  * each page in the PostScript document.
;  *
;  * `endPage', if non-NULL, is called at the end of the conversion of each
;  * page in the PostScript document.
;  *
;  * `noteProgress', if non-NULL, is called periodically during the
;  * conversion to indicate that conversion is proceeding.
;  *
;  * `noteMessage', if non-NULL, is called to pass any messages that might
;  * result during the conversion.
;  *
;  * `releaseInfo', if non-NULL, is called when the converter is
;  * deallocated. 

(def-mactype :CGPSConverterBeginDocumentCallback (find-mactype ':pointer)); (void * info)

(def-mactype :CGPSConverterEndDocumentCallback (find-mactype ':pointer)); (void * info , bool success)

(def-mactype :CGPSConverterBeginPageCallback (find-mactype ':pointer)); (void * info , size_t pageNumber , CFDictionaryRef pageInfo)

(def-mactype :CGPSConverterEndPageCallback (find-mactype ':pointer)); (void * info , size_t pageNumber , CFDictionaryRef pageInfo)

(def-mactype :CGPSConverterProgressCallback (find-mactype ':pointer)); (void * info)

(def-mactype :CGPSConverterMessageCallback (find-mactype ':pointer)); (void * info , CFStringRef message)

(def-mactype :CGPSConverterReleaseInfoCallback (find-mactype ':pointer)); (void * info)
(defrecord CGPSConverterCallbacks
   (version :UInt32)
   (beginDocument :pointer)
   (endDocument :pointer)
   (beginPage :pointer)
   (endPage :pointer)
   (noteProgress :pointer)
   (noteMessage :pointer)
   (releaseInfo :pointer)
)

;type name? (%define-record :CGPSConverterCallbacks (find-record-descriptor ':CGPSConverterCallbacks))
;  Create a CGPSConverter, using `callbacks' to populate its callback
;  * table. Each callback will be supplied the `info' value when called. 

(deftrap-inline "_CGPSConverterCreate" 
   ((info :pointer)
    (callbacks (:pointer :CGPSConverterCallbacks))
    (options (:pointer :__CFDictionary))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :CGPSConverter)
() )
;  Use `converter' to convert PostScript data to PDF data.  The PostScript
;  * data is supplied by `provider'; the resulting PDF is written to
;  * `consumer'.  Returns true if the conversion succeeded; false
;  * otherwise. 

(deftrap-inline "_CGPSConverterConvert" 
   ((converter (:pointer :CGPSConverter))
    (provider (:pointer :CGDataProvider))
    (consumer (:pointer :CGDataConsumer))
    (options (:pointer :__CFDictionary))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Tell the `converter' to abort conversion at the next possible
;  * opportunity. 

(deftrap-inline "_CGPSConverterAbort" 
   ((converter (:pointer :CGPSConverter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Return true if `converter' is currently converting data. 

(deftrap-inline "_CGPSConverterIsConverting" 
   ((converter (:pointer :CGPSConverter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Return the CFTypeID of the CGPSConverter class. 

(deftrap-inline "_CGPSConverterGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )

; #endif /* CGPSCONVERTER_H_ */


(provide-interface "CGPSConverter")