(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOCFURLAccess.h"
; at Sunday July 2,2006 7:28:42 pm.
; #ifndef __IOKIT_IOCFURLACCESS_H
; #define __IOKIT_IOCFURLACCESS_H

(require-interface "CoreFoundation/CoreFoundation")

(deftrap-inline "_IOURLCreatePropertyFromResource" 
   ((alloc (:pointer :__CFAllocator))
    (url (:pointer :__CFURL))
    (property (:pointer :__CFString))
    (errorCode (:pointer :SInt32))
   )
   (:pointer :void)
() )

(deftrap-inline "_IOURLCreateDataAndPropertiesFromResource" 
   ((alloc (:pointer :__CFAllocator))
    (url (:pointer :__CFURL))
    (resourceData (:pointer :CFDataRef))
    (properties (:pointer :CFDictionaryRef))
    (desiredProperties (:pointer :__CFArray))
    (errorCode (:pointer :SInt32))
   )
   :Boolean
() )

(deftrap-inline "_IOURLWriteDataAndPropertiesToResource" 
   ((url (:pointer :__CFURL))
    (dataToWrite (:pointer :__CFData))
    (propertiesToWrite (:pointer :__CFDictionary))
    (errorCode (:pointer :SInt32))
   )
   :Boolean
() )
; #define kIOURLFileExists		CFSTR("kIOURLFileExists")
; #define kIOURLFileDirectoryContents	CFSTR("kIOURLFileDirectoryContents")
; #define kIOURLFileLength		CFSTR("kIOURLFileLength")
; #define kIOURLFileLastModificationTime	CFSTR("kIOURLFileLastModificationTime")
; #define kIOURLFilePOSIXMode		CFSTR("kIOURLFilePOSIXMode")
; #define kIOURLFileOwnerID		CFSTR("kIOURLFileOwnerID")
;  Common error codes; this list is expected to grow 

(defconstant $kIOURLUnknownError -10)
(defconstant $kIOURLUnknownSchemeError -11)
(defconstant $kIOURLResourceNotFoundError -12)
(defconstant $kIOURLResourceAccessViolationError -13)
(defconstant $kIOURLRemoteHostUnavailableError -14)
(defconstant $kIOURLImproperArgumentsError -15)
(defconstant $kIOURLUnknownPropertyKeyError -16)
(defconstant $kIOURLPropertyKeyUnavailableError -17)
(defconstant $kIOURLTimeoutError -18)
(def-mactype :IOURLError (find-mactype ':SINT32))

; #endif /* __IOKIT_IOCFURLACCESS_H */


(provide-interface "IOCFURLAccess")