(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFPropertyList.h"
; at Sunday July 2,2006 7:22:48 pm.
; 	CFPropertyList.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFPROPERTYLIST__)
(defconstant $__COREFOUNDATION_CFPROPERTYLIST__ 1)
; #define __COREFOUNDATION_CFPROPERTYLIST__ 1

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFData")

(require-interface "CoreFoundation/CFString")

(require-interface "CoreFoundation/CFStream")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(defconstant $kCFPropertyListImmutable 0)
(defconstant $kCFPropertyListMutableContainers 1)
(defconstant $kCFPropertyListMutableContainersAndLeaves 2)
(def-mactype :CFPropertyListMutabilityOptions (find-mactype ':SINT32))
; 
; 	Creates a property list object from its XML description; xmlData should
; 	be the raw bytes of that description, possibly the contents of an XML
; 	file. Returns NULL if the data cannot be parsed; if the parse fails
; 	and errorString is non-NULL, a human-readable description of the failure
; 	is returned in errorString. It is the caller's responsibility to release
; 	either the returned object or the error string, whichever is applicable.
; 

(deftrap-inline "_CFPropertyListCreateFromXMLData" 
   ((allocator (:pointer :__CFAllocator))
    (xmlData (:pointer :__CFData))
    (mutabilityOption :UInt32)
    (errorString (:pointer :CFSTRINGREF))
   )
   (:pointer :void)
() )
; 
; 	Returns the XML description of the given object; propertyList must
; 	be one of the supported property list types, and (for composite types
; 	like CFArray and CFDictionary) must not contain any elements that
; 	are not themselves of a property list type. If a non-property list
; 	type is encountered, NULL is returned. The returned data is
; 	appropriate for writing out to an XML file. Note that a data, not a
; 	string, is returned because the bytes contain in them a description
; 	of the string encoding used.
; 

(deftrap-inline "_CFPropertyListCreateXMLData" 
   ((allocator (:pointer :__CFAllocator))
    (propertyList (:pointer :void))
   )
   (:pointer :__CFData)
() )
; 
; 	Recursively creates a copy of the given property list (so nested arrays
; 	and dictionaries are copied as well as the top-most container). The
; 	resulting property list has the mutability characteristics determined
; 	by mutabilityOption.
; 

(deftrap-inline "_CFPropertyListCreateDeepCopy" 
   ((allocator (:pointer :__CFAllocator))
    (propertyList (:pointer :void))
    (mutabilityOption :UInt32)
   )
   (:pointer :void)
() )

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

(defconstant $kCFPropertyListOpenStepFormat 1)
(defconstant $kCFPropertyListXMLFormat_v1_0 100)
(defconstant $kCFPropertyListBinaryFormat_v1_0 #xC8)
(def-mactype :CFPropertyListFormat (find-mactype ':SINT32))

(deftrap-inline "_CFPropertyListIsValid" 
   ((plist (:pointer :void))
    (format :SInt32)
   )
   :Boolean
() )
;  Returns true if the object graph rooted at plist is a valid property list
;  * graph -- that is, no cycles, containing only plist objects, and dictionary
;  * keys are strings. The debugging library version spits out some messages
;  * to be helpful. The plist structure which is to be allowed is given by
;  * the format parameter. 

(deftrap-inline "_CFPropertyListWriteToStream" 
   ((propertyList (:pointer :void))
    (stream (:pointer :__CFWriteStream))
    (format :SInt32)
    (errorString (:pointer :CFSTRINGREF))
   )
   :SInt32
() )
;  Writes the bytes of a plist serialization out to the stream.  The
;  * stream must be opened and configured -- the function simply writes
;  * a bunch of bytes to the stream. The output plist format can be chosen.
;  * Leaves the stream open, but note that reading a plist expects the
;  * reading stream to end wherever the writing ended, so that the
;  * end of the plist data can be identified. Returns the number of bytes
;  * written, or 0 on error. Error messages are not currently localized, but
;  * may be in the future, so they are not suitable for comparison. 

(deftrap-inline "_CFPropertyListCreateFromStream" 
   ((allocator (:pointer :__CFAllocator))
    (stream (:pointer :__CFReadStream))
    (streamLength :SInt32)
    (mutabilityOption :UInt32)
    (format (:pointer :CFPropertyListFormat))
    (errorString (:pointer :CFSTRINGREF))
   )
   (:pointer :void)
() )
;  Same as current function CFPropertyListCreateFromXMLData()
;  * but takes a stream instead of data, and works on any plist file format.
;  * CFPropertyListCreateFromXMLData() also works on any plist file format.
;  * The stream must be open and configured -- the function simply reads a bunch
;  * of bytes from it starting at the current location in the stream, to the END
;  * of the stream, which is expected to be the end of the plist, or up to the
;  * number of bytes given by the length parameter if it is not 0. Error messages
;  * are not currently localized, but may be in the future, so they are not
;  * suitable for comparison. 

; #endif


; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFPROPERTYLIST__ */


(provide-interface "CFPropertyList")