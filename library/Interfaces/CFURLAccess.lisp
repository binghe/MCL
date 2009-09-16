(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFURLAccess.h"
; at Sunday July 2,2006 7:23:03 pm.
; 	CFURLAccess.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFURLACCESS__)
(defconstant $__COREFOUNDATION_CFURLACCESS__ 1)
; #define __COREFOUNDATION_CFURLACCESS__ 1

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFArray")

(require-interface "CoreFoundation/CFData")

(require-interface "CoreFoundation/CFDictionary")

(require-interface "CoreFoundation/CFString")

(require-interface "CoreFoundation/CFURL")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
;  Attempts to read the data and properties for the given URL.  If
; only interested in one of the resourceData and properties, pass NULL
; for the other.  If properties is non-NULL and desiredProperties is
; NULL, then all properties are fetched.  Returns success or failure;
; note that as much work as possible is done even if false is returned.
; So for instance if one property is not available, the others are
; fetched anyway. errorCode is set to 0 on success, and some other
; value on failure.  If non-NULL, it is the caller 's responsibility
; to release resourceData and properties.
; 
;     Apple reserves for its use all negative error code values; these
; values represent errors common to any scheme.  Scheme-specific error
; codes should be positive, non-zero, and should be used only if one of
; the predefined Apple error codes does not apply.  Error codes should
; be publicized and documented with the scheme-specific properties.
; 

(deftrap-inline "_CFURLCreateDataAndPropertiesFromResource" 
   ((alloc (:pointer :__CFAllocator))
    (url (:pointer :__CFURL))
    (resourceData (:pointer :CFDATAREF))
    (properties (:pointer :CFDICTIONARYREF))
    (desiredProperties (:pointer :__CFArray))
    (errorCode (:pointer :SInt32))
   )
   :Boolean
() )
;  Attempts to write the given data and properties to the given URL.
; If dataToWrite is NULL, only properties are written out (use
; CFURLDestroyResource() to delete a resource).  Properties not present
; in propertiesToWrite are left unchanged, hence if propertiesToWrite
; is NULL or empty, the URL's properties are not changed at all.
; Returns success or failure; errorCode is set as for
; CFURLCreateDataAndPropertiesFromResource(), above.
; 

(deftrap-inline "_CFURLWriteDataAndPropertiesToResource" 
   ((url (:pointer :__CFURL))
    (dataToWrite (:pointer :__CFData))
    (propertiesToWrite (:pointer :__CFDictionary))
    (errorCode (:pointer :SInt32))
   )
   :Boolean
() )
;  Destroys the resource indicated by url. 
;  Returns success or failure; errorCode set as above. 

(deftrap-inline "_CFURLDestroyResource" 
   ((url (:pointer :__CFURL))
    (errorCode (:pointer :SInt32))
   )
   :Boolean
() )
;  Convenience method which calls through to CFURLCreateDataAndPropertiesFromResource(). 
;  Returns NULL on error and sets errorCode accordingly. 

(deftrap-inline "_CFURLCreatePropertyFromResource" 
   ((alloc (:pointer :__CFAllocator))
    (url (:pointer :__CFURL))
    (property (:pointer :__CFString))
    (errorCode (:pointer :SInt32))
   )
   (:pointer :void)
() )
;  Common error codes; this list is expected to grow 

(defconstant $kCFURLUnknownError -10)
(defconstant $kCFURLUnknownSchemeError -11)
(defconstant $kCFURLResourceNotFoundError -12)
(defconstant $kCFURLResourceAccessViolationError -13)
(defconstant $kCFURLRemoteHostUnavailableError -14)
(defconstant $kCFURLImproperArgumentsError -15)
(defconstant $kCFURLUnknownPropertyKeyError -16)
(defconstant $kCFURLPropertyKeyUnavailableError -17)
(defconstant $kCFURLTimeoutError -18)
(def-mactype :CFURLError (find-mactype ':SINT32))
;  Property keys 
(def-mactype :kCFURLFileExists (find-mactype ':CFStringRef))
(def-mactype :kCFURLFileDirectoryContents (find-mactype ':CFStringRef))
(def-mactype :kCFURLFileLength (find-mactype ':CFStringRef))
(def-mactype :kCFURLFileLastModificationTime (find-mactype ':CFStringRef))
(def-mactype :kCFURLFilePOSIXMode (find-mactype ':CFStringRef))
(def-mactype :kCFURLFileOwnerID (find-mactype ':CFStringRef))
(def-mactype :kCFURLHTTPStatusCode (find-mactype ':CFStringRef))
(def-mactype :kCFURLHTTPStatusLine (find-mactype ':CFStringRef))
;  The value of kCFURLFileExists is a CFBoolean 
;  The value of kCFURLFileDirectoryContents is a CFArray containing CFURLs.  An empty array means the directory exists, but is empty 
;  The value of kCFURLFileLength is a CFNumber giving the file's length in bytes 
;  The value of kCFURLFileLastModificationTime is a CFDate 
;  The value of kCFURLFilePOSIXMode is a CFNumber as given in stat.h 
;  The value of kCFURLFileOwnerID is a CFNumber representing the owner's uid 
;  Properties for the http: scheme.  Except for the common error codes, above, errorCode will be set to the HTTP response status code upon failure.  Any HTTP header name can also be used as a property 
;  The value of kCFURLHTTPStatusCode is a CFNumber 
;  The value of kCFURLHTTPStatusLine is a CFString 

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* !__COREFOUNDATION_CFURLACCESS__ */


(provide-interface "CFURLAccess")