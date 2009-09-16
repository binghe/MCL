(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SKDocument.h"
; at Sunday July 2,2006 7:23:42 pm.
; 
;      File:       SearchKit/SKDocument.h
;  
;      Contains:   SearchKit Interfaces.
;  
;      Version:    SearchKit-60~16
;  
;      Copyright:  © 2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __SKDOCUMENT__
; #define __SKDOCUMENT__
; #ifndef __CFBASE__

(require-interface "CoreFoundation/CFBase")

; #endif

; #ifndef __CFURL__

(require-interface "CoreFoundation/CFURL")

; #endif


(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
;  *  SKDocumentRef
;  *  
;  *  Summary:
;  *    An opaque data type representing a document.
;  *  
;  *  Discussion:
;  *    A document reference is a generic descriptor to a document. It is
;  *    built from a document scheme, a parent document, and a document
;  *    name.
;  

(def-mactype :SKDocumentRef (find-mactype '(:pointer :__SKDocument)))
; 
;  *  SKDocumentGetTypeID()
;  *  
;  *  Summary:
;  *    Returns the type identifier of the SKDocument type.
;  *  
;  *  Result:
;  *    Returns a CFTypeID object, or <tt>NULL</tt> on failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKDocumentGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
; 
;  *  SKDocumentCreateWithURL()
;  *  
;  *  Summary:
;  *    Creates a reference to a document with a URL.
;  *  
;  *  Discussion:
;  *    Use SKDocumentCreateWithURL to create a reference to a file or
;  *    other URL. This function must be balanced with a call at a later
;  *    time to CFRelease.
;  *  
;  *  Parameters:
;  *    
;  *    inURL:
;  *      Only "file:" URLs can be used with the SKIndexAddDocument
;  *      function, but the URL scheme may be anything you like if you
;  *      use the SKIndexAddDocumentWithText function. The scheme of the
;  *      document created is set to the scheme of the URL used.
;  *  
;  *  Result:
;  *    Returns a reference to the document, or <tt>NULL</tt> on failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKDocumentCreateWithURL" 
   ((inURL (:pointer :__CFURL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKDocument)
() )
; 
;  *  SKDocumentCopyURL()
;  *  
;  *  Summary:
;  *    Builds a CFURL object from a document reference.
;  *  
;  *  Result:
;  *    Returns a CFURL object, or <tt>NULL</tt> on failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKDocumentCopyURL" 
   ((inDocument (:pointer :__SKDocument))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFURL)
() )
; 
;  *  SKDocumentCreate()
;  *  
;  *  Summary:
;  *    Create a document based on a scheme, parent, and name.
;  *  
;  *  Discussion:
;  *    The parent can be <tt>NULL</tt>, but either a scheme or a parent
;  *    must be specified. This function must be balanced with a call at
;  *    a later time to CFRelease
;  *  
;  *  Parameters:
;  *    
;  *    inScheme:
;  *      Analogous to the scheme of a URL. Documents with a "file"
;  *      scheme can be read by the <tt>SKIndexAddDocument</tt> function
;  *      (see SearchKit.h). The scheme may be anything you like if you
;  *      use the SKIndexAddDocumentWithText function. If the scheme is
;  *      <tt>NULL</tt>, it will be set to be the same as the parent.
;  *    
;  *    inParent:
;  *      The reference to the document or container one step up in the
;  *      document hierarchy.
;  *    
;  *    inName:
;  *      The name of this document. For a "file" scheme, it is the name
;  *      of the file or the container, not its path. The path can be
;  *      constructed by following parent links.
;  *  
;  *  Result:
;  *    Returns a reference to the document, or <tt>NULL</tt> on failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKDocumentCreate" 
   ((inScheme (:pointer :__CFString))
    (inParent (:pointer :__SKDocument))         ;  can be NULL 
    (inName (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKDocument)
() )
; 
;  *  SKDocumentGetSchemeName()
;  *  
;  *  Summary:
;  *    Gets the scheme name of a document.
;  *  
;  *  Parameters:
;  *    
;  *    inDocument:
;  *      The document whose scheme name you want to get.
;  *  
;  *  Result:
;  *    Returns a CFString object, or <tt>NULL</tt> on failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKDocumentGetSchemeName" 
   ((inDocument (:pointer :__SKDocument))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )
; 
;  *  SKDocumentGetName()
;  *  
;  *  Summary:
;  *    Gets the name of a document.
;  *  
;  *  Parameters:
;  *    
;  *    inDocument:
;  *      The document whose name you want to get.
;  *  
;  *  Result:
;  *    Returns a CFString object, or <tt>NULL</tt> on failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKDocumentGetName" 
   ((inDocument (:pointer :__SKDocument))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )
; 
;  *  SKDocumentGetParent()
;  *  
;  *  Summary:
;  *    Gets a reference to the parent document of a document.
;  *  
;  *  Parameters:
;  *    
;  *    inDocument:
;  *      The document whose parent you want to get.
;  *  
;  *  Result:
;  *    Returns a reference to the parent document, or <tt>NULL</tt> on
;  *    failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKDocumentGetParent" 
   ((inDocument (:pointer :__SKDocument))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKDocument)
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __SKDOCUMENT__ */


(provide-interface "SKDocument")