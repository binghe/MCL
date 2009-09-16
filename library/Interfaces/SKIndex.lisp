(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SKIndex.h"
; at Sunday July 2,2006 7:23:43 pm.
; 
;      File:       SearchKit/SKIndex.h
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
; #ifndef __SKINDEX__
; #define __SKINDEX__
; #ifndef __CFBASE__

(require-interface "CoreFoundation/CFBase")

; #endif

; #ifndef __CFURL__

(require-interface "CoreFoundation/CFURL")

; #endif

; #ifndef __CFDICTIONARY__

(require-interface "CoreFoundation/CFDictionary")

; #endif

; #ifndef __SKDOCUMENT__
#| #|
#include <SearchKitSKDocument.h>
#endif
|#
 |#
; 
;  *  CFTypes for use with SearchKit
;  

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

; #if PRAGMA_ENUM_ALWAYSINT
#| ; #pragma enumsalwaysint on
 |#

; #endif

; 
;  *  SKIndexRef
;  *  
;  *  Summary:
;  *    An opaque data type representing an index.
;  

(def-mactype :SKIndexRef (find-mactype '(:pointer :__SKIndex)))
; 
;  *  SKIndexGetTypeID()
;  *  
;  *  Summary:
;  *    Returns the type identifier for the index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
; 
;  *  SKIndexDocumentIteratorRef
;  *  
;  *  Summary:
;  *    An opaque data type representing an index iterator.
;  

(def-mactype :SKIndexDocumentIteratorRef (find-mactype '(:pointer :__SKIndexDocumentIterator)))
; 
;  *  SKIndexDocumentIteratorGetTypeID()
;  *  
;  *  Summary:
;  *    Returns the type identifier of the index iterator.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexDocumentIteratorGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
; 
;  * enumeration types
;  
; 
;  *  SKIndexType
;  *  
;  *  Summary:
;  *    The possible index types for SearchKit indexes.
;  
(def-mactype :SKIndexType (find-mactype ':sint32))
; 
;    * Unknown index type.
;    

(defconstant $kSKIndexUnknown 0)
; 
;    * Inverted index, mapping terms to documents.
;    

(defconstant $kSKIndexInverted 1)
; 
;    * Vector index, mapping documents to terms.
;    

(defconstant $kSKIndexVector 2)
; 
;    * Index type with all the capabilities of an inverted and a vector
;    * index.
;    

(defconstant $kSKIndexInvertedVector 3)

;type name? (def-mactype :SKIndexType (find-mactype ':SKIndexType))
; 
;  *  SKDocumentIndexState
;  *  
;  *  Summary:
;  *    The indexing state of a document.
;  
(def-mactype :SKDocumentIndexState (find-mactype ':sint32))
; 
;    * Document is not indexed.
;    

(defconstant $kSKDocumentStateNotIndexed 0)
; 
;    * Document is indexed.
;    

(defconstant $kSKDocumentStateIndexed 1)
; 
;    * Document is not in the index but will be added after the index is
;    * flushed or closed.
;    

(defconstant $kSKDocumentStateAddPending 2)
; 
;    * Document is in the index but will be deleted after the index is
;    * flushed or closed.
;    

(defconstant $kSKDocumentStateDeletePending 3)

;type name? (def-mactype :SKDocumentIndexState (find-mactype ':SKDocumentIndexState))
; 
;  *  SKIndexCreateWithURL()
;  *  
;  *  Summary:
;  *    Creates a named index in a file whose location is specified with
;  *    a CFURL object.
;  *  
;  *  Discussion:
;  *    When an index is created, the client must also specify the index
;  *    type. The name can be <tt>NULL</tt>. A file can contain more than
;  *    one index. If the analysis properties dictionary is not
;  *    specified, the default dictionary is used. The various analysis
;  *    properties are described in the SKAnalysis.h header file. Use the
;  *    <tt>SKIndexGetAnalysisProperties</tt> function to get the
;  *    analysis properties of an index. A call to this function must be
;  *    balanced with a call at a later time to <tt>CFRelease</tt>.
;  *  
;  *  Parameters:
;  *    
;  *    inURL:
;  *      A reference to a CFURL object containing the location of the
;  *      index.
;  *    
;  *    inIndexName:
;  *      A reference to a CFString object containing the name of the
;  *      index. May be <tt>NULL</tt>.
;  *    
;  *    inIndexType:
;  *      The index type.
;  *    
;  *    inAnalysisProperties:
;  *      A reference to the analysis properties dictionary. May be
;  *      <tt>NULL</tt>.
;  *  
;  *  Result:
;  *    SKIndexRef  A reference to the index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexCreateWithURL" 
   ((inURL (:pointer :__CFURL))
    (inIndexName (:pointer :__CFString))        ;  can be NULL 
    (inIndexType :SKIndexType)
    (inAnalysisProperties (:pointer :__CFDictionary));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKIndex)
() )
; 
;  *  SKIndexOpenWithURL()
;  *  
;  *  Summary:
;  *    Opens an existing, named index stored in a file whose location is
;  *    specified with a CFURL object.
;  *  
;  *  Discussion:
;  *    A call to this function must be balanced with a call at a later
;  *    time to <tt>CFRelease</tt>.
;  *  
;  *  Parameters:
;  *    
;  *    inURL:
;  *      A reference to a file CFURL object containing the location of
;  *      the index.
;  *    
;  *    inIndexName:
;  *      A reference to a CFString object containing the name of the
;  *      index. May be <tt>NULL</tt>.
;  *    
;  *    inWriteAccess:
;  *      A boolean value indicating whether the index is open for
;  *      writing.
;  *  
;  *  Result:
;  *    SKIndexRef  A reference to the index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexOpenWithURL" 
   ((inURL (:pointer :__CFURL))
    (inIndexName (:pointer :__CFString))        ;  can be NULL 
    (inWriteAccess :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKIndex)
() )
; 
;  *  SKIndexCreateWithMutableData()
;  *  
;  *  Summary:
;  *    Creates a named index stored in a CFData object; the name can be
;  *    <tt>NULL</tt>.
;  *  
;  *  Parameters:
;  *    
;  *    inData:
;  *      A reference to a CFMutableData object containing the index to
;  *      create.
;  *    
;  *    inIndexName:
;  *      A reference to a CFString object containing the name of the
;  *      index. May be <tt>NULL</tt>.
;  *    
;  *    inIndexType:
;  *      A reference to the index type.
;  *    
;  *    inAnalysisProperties:
;  *      A reference to the analysis properties dictionary. May be
;  *      <tt>NULL</tt>.
;  *  
;  *  Result:
;  *    SKIndexRef  A reference to the index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexCreateWithMutableData" 
   ((inData (:pointer :__CFData))
    (inIndexName (:pointer :__CFString))        ;  can be NULL 
    (inIndexType :SKIndexType)
    (inAnalysisProperties (:pointer :__CFDictionary));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKIndex)
() )
; 
;  *  SKIndexOpenWithData()
;  *  
;  *  Summary:
;  *    Opens an existing, named index stored in a CFData object.
;  *  
;  *  Discussion:
;  *    The index may be searched but not updated. To open the index for
;  *    updating, use the <tt>SKIndexOpenWithMutableData</tt> function. A
;  *    call to this function must be balanced with a call at a later
;  *    time to <tt>CFRelease</tt>.
;  *  
;  *  Parameters:
;  *    
;  *    inData:
;  *      A reference to a CFData object containing the index to open.
;  *    
;  *    inIndexName:
;  *      A reference to a CFString object containing the name of the
;  *      index. May be <tt>NULL</tt>.
;  *  
;  *  Result:
;  *    SKIndexRef  A reference to the index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexOpenWithData" 
   ((inData (:pointer :__CFData))
    (inIndexName (:pointer :__CFString))        ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKIndex)
() )
; 
;  *  SKIndexOpenWithMutableData()
;  *  
;  *  Summary:
;  *    Opens an existing, named index stored in a CFData object.
;  *  
;  *  Discussion:
;  *    The index may be searched or updated. To open the index for
;  *    search only, use the <tt>SKIndexOpenWithData</tt> function. A
;  *    call to this function must be balanced with a call at a later
;  *    time to <tt>CFRelease</tt>.
;  *  
;  *  Parameters:
;  *    
;  *    inData:
;  *      A reference to a CFMutableData object containing the index to
;  *      open.
;  *    
;  *    inIndexName:
;  *      A reference to a CFString object containing the name of the
;  *      index. May be <tt>NULL</tt>.
;  *  
;  *  Result:
;  *    SKIndexRef  A reference to the index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexOpenWithMutableData" 
   ((inData (:pointer :__CFData))
    (inIndexName (:pointer :__CFString))        ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKIndex)
() )
; 
;  *  SKIndexFlush()
;  *  
;  *  Summary:
;  *    Forces SearchKit to flush all caches associated with an index.
;  *  
;  *  Discussion:
;  *    Index caches can become stale when clients add or remove
;  *    documents. Before searching an index you need to call
;  *    <tt>SKIndexFlush</tt>, even though the cache flushing may take
;  *    some time.
;  *  
;  *  Result:
;  *    Returns a Boolean value of <tt>true</tt> on success or
;  *    <tt>false</tt> on failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexFlush" 
   ((inIndex (:pointer :__SKIndex))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  *  SKIndexSetMaximumBytesBeforeFlush()
;  *  
;  *  Summary:
;  *    Sets the memory size limit for an index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexSetMaximumBytesBeforeFlush" 
   ((inIndex (:pointer :__SKIndex))
    (inBytesForUpdate :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  *  SKIndexGetMaximumBytesBeforeFlush()
;  *  
;  *  Summary:
;  *    Gets the memory size limit for an index, measured in bytes.
;  *  
;  *  Result:
;  *    Returns a CFIndex object containing the memory size limit for an
;  *    index. On failure, returns 0.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexGetMaximumBytesBeforeFlush" 
   ((inIndex (:pointer :__SKIndex))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
;  *  SKIndexCompact()
;  *  
;  *  Summary:
;  *    Attempts to defragment and compact the index.
;  *  
;  *  Discussion:
;  *    This function takes time. Call it only when the index is too
;  *    fragmented. You can test for fragmentation be examining the ratio
;  *    of the total document count, obtained with
;  *    <tt>SKIndexGetDocumentCount</tt>, to the maximum document ID,
;  *    obtained with <tt>SKIndexGetMaximumDocumentID</tt>.
;  *  
;  *  Result:
;  *    Returns a Boolean value of <tt>true</tt> on success or
;  *    <tt>false</tt> on failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexCompact" 
   ((inIndex (:pointer :__SKIndex))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  *  SKIndexGetIndexType()
;  *  
;  *  Summary:
;  *    Gets the type of an index.
;  *  
;  *  Discussion:
;  *    See the <tt>SKIndexType</tt> enumeration for a list of the
;  *    various index types.
;  *  
;  *  Result:
;  *    Returns the type of the index. On failure, returns a value of
;  *    kSKIndexUnknown.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexGetIndexType" 
   ((inIndex (:pointer :__SKIndex))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SKIndexType
() )
; 
;  *  SKIndexGetAnalysisProperties()
;  *  
;  *  Summary:
;  *    Gets the text analysis properties of an index.
;  *  
;  *  Result:
;  *    Returns a CFDictionary object containing the index's text
;  *    analysis properties. On failure, returns <tt>NULL</tt>.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexGetAnalysisProperties" 
   ((inIndex (:pointer :__SKIndex))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFDictionary)
() )
; 
;  *  SKIndexGetDocumentCount()
;  *  
;  *  Summary:
;  *    Gets the total number of documents represented in an index.
;  *  
;  *  Discussion:
;  *    Indexed documents have an indexing state of
;  *    kSKDocumentStateIndexed. See the <tt>SKDocumentIndexState</tt>
;  *    enumeration.
;  *  
;  *  Result:
;  *    Returns CFIndex object containing the number of documents in the
;  *    index. On failure, returns 0.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexGetDocumentCount" 
   ((inIndex (:pointer :__SKIndex))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
;  * Managing documents inside an index
;  
; 
;  *  SKIndexAddDocumentWithText()
;  *  
;  *  Summary:
;  *    Adds a document and its text to an index.
;  *  
;  *  Parameters:
;  *    
;  *    inIndex:
;  *      A reference to the index to which you are adding the document.
;  *    
;  *    inDocument:
;  *      A reference to the document to add.
;  *    
;  *    inDocumentText:
;  *      A reference to the document text. May be <tt>NULL</tt>.
;  *    
;  *    inCanReplace:
;  *      A boolean value indicating whether a document with the same
;  *      descriptor can be overwritten.
;  *  
;  *  Result:
;  *    Returns a Boolean value of <tt>true</tt> on success or
;  *    <tt>false</tt> on failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexAddDocumentWithText" 
   ((inIndex (:pointer :__SKIndex))
    (inDocument (:pointer :__SKDocument))
    (inDocumentText (:pointer :__CFString))     ;  can be NULL 
    (inCanReplace :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  *  SKIndexAddDocument()
;  *  
;  *  Summary:
;  *    Adds a document to an index.
;  *  
;  *  Discussion:
;  *    This function uses the input document and the optional MIME type
;  *    hint to get the document text using plug-in-based text
;  *    extractors. Call <tt>SKLoadDefaultExtractorPlugIns</tt> to load
;  *    the default text extractors.
;  *  
;  *  Parameters:
;  *    
;  *    inDocument:
;  *      A reference to the document to add. The document scheme must be
;  *      of type "file" to use this function. If it's not, call
;  *      <tt>SKIndexAddDocumentWithText</tt> instead.
;  *    
;  *    inIndex:
;  *      A reference to the index to which you are adding the document.
;  *    
;  *    inDocument:
;  *      A reference to the document to add.
;  *    
;  *    inMIMETypeHint:
;  *      The MIME type hint for the document. May be <tt>NULL</tt>.
;  *    
;  *    inCanReplace:
;  *      A boolean value indicating whether a document with the same
;  *      descriptor can be overwritten.
;  *  
;  *  Result:
;  *    Returns a Boolean value of <tt>true</tt> on success or
;  *    <tt>false</tt> on failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexAddDocument" 
   ((inIndex (:pointer :__SKIndex))
    (inDocument (:pointer :__SKDocument))
    (inMIMETypeHint (:pointer :__CFString))     ;  can be NULL 
    (inCanReplace :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  *  SKIndexRemoveDocument()
;  *  
;  *  Summary:
;  *    Removes a document and its children, if any, from an index.
;  *  
;  *  Parameters:
;  *    
;  *    inIndex:
;  *      A reference to the index from which you want to remove the
;  *      document.
;  *    
;  *    inDocument:
;  *      A reference to the document to remove.
;  *  
;  *  Result:
;  *    Returns a Boolean value of <tt>true</tt> on success or
;  *    <tt>false</tt> on failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexRemoveDocument" 
   ((inIndex (:pointer :__SKIndex))
    (inDocument (:pointer :__SKDocument))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  *  SKIndexCopyDocumentProperties()
;  *  
;  *  Summary:
;  *    Copies the user-defined properties of a document in an index to a
;  *    dictionary.
;  *  
;  *  Result:
;  *    Returns a CFDictionary object, or <tt>NULL</tt> on failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexCopyDocumentProperties" 
   ((inIndex (:pointer :__SKIndex))
    (inDocument (:pointer :__SKDocument))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFDictionary)
() )
; 
;  *  SKIndexSetDocumentProperties()
;  *  
;  *  Summary:
;  *    Sets the user-defined properties of a document in an index. A
;  *    document's properties are persistently stored in the index. The
;  *    existing properties dictionary will be replaced with the new one.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexSetDocumentProperties" 
   ((inIndex (:pointer :__SKIndex))
    (inDocument (:pointer :__SKDocument))
    (inProperties (:pointer :__CFDictionary))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  *  SKIndexGetDocumentState()
;  *  
;  *  Summary:
;  *    Gets the current indexing state of a document in an index.
;  *  
;  *  Discussion:
;  *    A document can be in 1 of 4 states, as defined by the
;  *    <tt>SKDocumentIndexState</tt> enumeration: not indexed, indexed,
;  *    not in the index but will be added after the index is flushed or
;  *    closed, and in the index but will be deleted after the index is
;  *    flushed or closed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexGetDocumentState" 
   ((inIndex (:pointer :__SKIndex))
    (inDocument (:pointer :__SKDocument))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SKDocumentIndexState
() )
; 
;  *  SKIndexGetDocumentID()
;  *  
;  *  Summary:
;  *    Gets the ID of a document in an index.
;  *  
;  *  Discussion:
;  *    The document ID is a persistent way to identify the document in
;  *    an index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexGetDocumentID" 
   ((inIndex (:pointer :__SKIndex))
    (inDocument (:pointer :__SKDocument))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
;  *  SKIndexCopyDocumentForDocumentID()
;  *  
;  *  Summary:
;  *    Copies a document reference by way of a document ID in an index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexCopyDocumentForDocumentID" 
   ((inIndex (:pointer :__SKIndex))
    (inDocumentID :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKDocument)
() )
; 
;  *  SKIndexRenameDocument()
;  *  
;  *  Summary:
;  *    Changes the name of a document in an index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexRenameDocument" 
   ((inIndex (:pointer :__SKIndex))
    (inDocument (:pointer :__SKDocument))
    (inNewName (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  *  SKIndexMoveDocument()
;  *  
;  *  Summary:
;  *    Changes the parent of a document in an index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexMoveDocument" 
   ((inIndex (:pointer :__SKIndex))
    (inDocument (:pointer :__SKDocument))
    (inNewParent (:pointer :__SKDocument))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  *  SKIndexDocumentIteratorCreate()
;  *  
;  *  Summary:
;  *    Creates an iterator for an index based on a starting document
;  *    reference.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexDocumentIteratorCreate" 
   ((inIndex (:pointer :__SKIndex))
    (inParentDocument (:pointer :__SKDocument))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKIndexDocumentIterator)
() )
; 
;  *  SKIndexDocumentIteratorCopyNext()
;  *  
;  *  Summary:
;  *    Gets the next document reference from a document iterator.
;  *  
;  *  Discussion:
;  *    This function returns <tt>NULL</tt> when there are no more
;  *    documents. You must call <tt>CFRelease</tt> on all retrieved
;  *    document references that are non-null.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexDocumentIteratorCopyNext" 
   ((inIterator (:pointer :__SKIndexDocumentIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKDocument)
() )
; 
;  * Documents in Index
;  
; 
;  *  SKIndexGetMaximumDocumentID()
;  *  
;  *  Summary:
;  *    Gets the highest-numbered document ID in an index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexGetMaximumDocumentID" 
   ((inIndex (:pointer :__SKIndex))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
;  *  SKIndexGetDocumentTermCount()
;  *  
;  *  Summary:
;  *    Gets the number of terms for a given document in an index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexGetDocumentTermCount" 
   ((inIndex (:pointer :__SKIndex))
    (inDocumentID :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
;  *  SKIndexCopyTermIDArrayForDocumentID()
;  *  
;  *  Summary:
;  *    Gets the IDs for the terms of a document in an index.
;  *  
;  *  Result:
;  *    A reference to a CFArray object containing CFNumber objects.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexCopyTermIDArrayForDocumentID" 
   ((inIndex (:pointer :__SKIndex))
    (inDocumentID :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFArray)
() )
; 
;  *  SKIndexGetDocumentTermFrequency()
;  *  
;  *  Summary:
;  *    Gets the frequency of occurrences of a given term in a document.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexGetDocumentTermFrequency" 
   ((inIndex (:pointer :__SKIndex))
    (inDocumentID :SInt32)
    (inTermID :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
;  * Terms in Index
;  *
;  * A term is a word from the content of a document.
;  
; 
;  *  SKIndexGetMaximumTermID()
;  *  
;  *  Summary:
;  *    Gets the highest-numbered term ID in an index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexGetMaximumTermID" 
   ((inIndex (:pointer :__SKIndex))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
;  *  SKIndexGetTermDocumentCount()
;  *  
;  *  Summary:
;  *    Gets the number of documents containing a given term in an index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexGetTermDocumentCount" 
   ((inIndex (:pointer :__SKIndex))
    (inTermID :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
;  *  SKIndexCopyDocumentIDArrayForTermID()
;  *  
;  *  Summary:
;  *    Gets the IDs of the documents containing a given term in an index.
;  *  
;  *  Result:
;  *    A reference to a CFArray object containing CFNumber objects.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexCopyDocumentIDArrayForTermID" 
   ((inIndex (:pointer :__SKIndex))
    (inTermID :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFArray)
() )
; 
;  *  SKIndexCopyTermStringForTermID()
;  *  
;  *  Summary:
;  *    Gets the term specified by a term ID in an index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexCopyTermStringForTermID" 
   ((inIndex (:pointer :__SKIndex))
    (inTermID :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )
; 
;  *  SKIndexGetTermIDForTermString()
;  *  
;  *  Summary:
;  *    Gets the term ID for a given term in an index.
;  *  
;  *  Discussion:
;  *    If the term isn't found, return a value of kCFNotFound.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKIndexGetTermIDForTermString" 
   ((inIndex (:pointer :__SKIndex))
    (inTermString (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
;  *  SKLoadDefaultExtractorPlugIns()
;  *  
;  *  Summary:
;  *    Loads the default text extractor plug-ins.
;  *  
;  *  Discussion:
;  *    A text extractor knows the format of a specific kind of document.
;  *    For example, various text extractors can return the text of a PDF
;  *    document, strip the tags of an HTML document, and so on. Loading
;  *    extractors allows the <tt>SKIndexAddDocument</tt> function to
;  *    extract the text from supported documents, leaving the markup
;  *    behind.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKLoadDefaultExtractorPlugIns" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

; #if PRAGMA_ENUM_ALWAYSINT
#| ; #pragma enumsalwaysint reset
 |#

; #endif

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __SKINDEX__ */


(provide-interface "SKIndex")