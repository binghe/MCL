(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SKSearch.h"
; at Sunday July 2,2006 7:23:44 pm.
; 
;      File:       SearchKit/SKSearch.h
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
; #ifndef __SKSEARCH__
; #define __SKSEARCH__
; #ifndef __CFBASE__

(require-interface "CoreFoundation/CFBase")

; #endif

; #ifndef __CFURL__

(require-interface "CoreFoundation/CFURL")

; #endif

; #ifndef __CFDICTIONARY__

(require-interface "CoreFoundation/CFDictionary")

; #endif

; #ifndef __SKINDEX__
#| #|
#include <SearchKitSKIndex.h>
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
;  *  SKSearchGroupRef
;  *  
;  *  Summary:
;  *    An opaque data type representing a search group.
;  *  
;  *  Discussion:
;  *    A search group is a group of indexes to be searched.
;  

(def-mactype :SKSearchGroupRef (find-mactype '(:pointer :__SKSearchGroup)))
; 
;  *  SKSearchGroupGetTypeID()
;  *  
;  *  Summary:
;  *    Returns the type identifier for the SKSearchGroup type.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKSearchGroupGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
; 
;  *  SKSearchResultsRef
;  *  
;  *  Summary:
;  *    An opaque data type representing search results.
;  

(def-mactype :SKSearchResultsRef (find-mactype '(:pointer :__SKSearchResults)))
; 
;  *  SKSearchResultsGetTypeID()
;  *  
;  *  Summary:
;  *    Returns the type identifier for the SKSearchResults object.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKSearchResultsGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
; 
;  *  SKSearchType
;  *  
;  *  Discussion:
;  *    The various search types you can use with
;  *    <tt>SKSearchResultsCreateWithQuery</tt>. Each of these specifies
;  *    a set of ranked search hits. The kSKSearchRanked and
;  *    kSKSearchPrefixRanked constants can be used for all index types.
;  *    The kSKSearchBooleanRanked and kSKSearchRequiredRanked constants
;  *    cannot be used for Vector indexes.
;  
(def-mactype :SKSearchType (find-mactype ':sint32))
; 
;    * Basic ranked search.
;    

(defconstant $kSKSearchRanked 0)
; 
;    * The query can include boolean operators including '|', '&', '!',
;    * '(', and ')'.
;    

(defconstant $kSKSearchBooleanRanked 1)
; 
;    * The query can specify required ('+') or excluded ('-') terms.
;    

(defconstant $kSKSearchRequiredRanked 2)
; 
;    * Prefix-based search.
;    

(defconstant $kSKSearchPrefixRanked 3)

;type name? (def-mactype :SKSearchType (find-mactype ':SKSearchType))
; 
;  *  SKSearchResultsFilterCallBack
;  *  
;  *  Summary:
;  *    A callback function for hit testing during searching.
;  *  
;  *  Discussion:
;  *    Return <tt>true</tt> to keep this document in the results,
;  *    <tt>false</tt> to filter it out.
;  

(def-mactype :SKSearchResultsFilterCallBack (find-mactype ':pointer)); (SKIndexRef inIndex , SKDocumentRef inDocument , void * inContext)
; 
;  *  SKSearchGroupCreate()
;  *  
;  *  Summary:
;  *    Creates a search group as an array of references to indexes.
;  *  
;  *  Discussion:
;  *    A search group is used to search one or more indexes.
;  *  
;  *  Parameters:
;  *    
;  *    inArrayOfInIndexes:
;  *      A CFArray object containing SKIndex objects.
;  *  
;  *  Result:
;  *    SKSearchGroupRef    A reference to an SKSearchGroup opaque type.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKSearchGroupCreate" 
   ((inArrayOfInIndexes (:pointer :__CFArray))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKSearchGroup)
() )
; 
;  *  SKSearchGroupCopyIndexes()
;  *  
;  *  Summary:
;  *    Gets the indexes for a search group.
;  *  
;  *  Result:
;  *    A CFArray object containing SKIndex objects.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKSearchGroupCopyIndexes" 
   ((inSearchGroup (:pointer :__SKSearchGroup))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFArray)
() )
; 
;  *  SKSearchResultsCreateWithQuery()
;  *  
;  *  Summary:
;  *    Queries the indexes in a search group.
;  *  
;  *  Discussion:
;  *    A call to this function must be balanced with a call at a later
;  *    time to <tt>CFRelease</tt>.
;  *  
;  *  Parameters:
;  *    
;  *    inSearchGroup:
;  *      A reference to the search group.
;  *    
;  *    inQuery:
;  *      The query string to search for.
;  *    
;  *    inSearchType:
;  *      The type of search to perform. See the <tt>SKSearchType</tt>
;  *      enumeration for options.
;  *    
;  *    inMaxFoundDocuments:
;  *      The maximum number of found items to return. Your client must
;  *      specify a positive value.
;  *    
;  *    inContext:
;  *      A client-specified context. May be <tt>NULL</tt>.
;  *    
;  *    inFilterCallBack:
;  *      A callback function for hit testing during searching. May be
;  *      <tt>NULL</tt>.
;  *  
;  *  Result:
;  *    SKSearchResultsRef  A reference to an SKSearchResults opaque type.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKSearchResultsCreateWithQuery" 
   ((inSearchGroup (:pointer :__SKSearchGroup))
    (inQuery (:pointer :__CFString))
    (inSearchType :SKSearchType)
    (inMaxFoundDocuments :SInt32)
    (inContext :pointer)
    (inFilterCallBack :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKSearchResults)
() )
; 
;  *  SKSearchResultsCreateWithDocuments()
;  *  
;  *  Summary:
;  *    Finds documents similar to given example documents by searching
;  *    the indexes in a search group.
;  *  
;  *  Discussion:
;  *    A call to SKSearchResultsCreateWithDocuments must be balanced
;  *    with a call at a later time to <tt>CFRelease</tt>.
;  *  
;  *  Parameters:
;  *    
;  *    inSearchGroup:
;  *      A reference to the search group.
;  *    
;  *    inExampleDocuments:
;  *      An array of example documents. The documents must previously
;  *      have been indexed.
;  *    
;  *    inMaxFoundDocuments:
;  *      The maximum number of found items to return. Your client must
;  *      specify a positive value.
;  *    
;  *    inContext:
;  *      A client-specified context. May be <tt>NULL</tt>.
;  *    
;  *    inFilterCallBack:
;  *      A callback function for hit testing during searching. May be
;  *      <tt>NULL</tt>.
;  *  
;  *  Result:
;  *    SKSearchResultsRef  A reference to an SKSearchResults opaque type.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKSearchResultsCreateWithDocuments" 
   ((inSearchGroup (:pointer :__SKSearchGroup))
    (inExampleDocuments (:pointer :__CFArray))
    (inMaxFoundDocuments :SInt32)
    (inContext :pointer)
    (inFilterCallBack :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SKSearchResults)
() )
; 
;  *  SKSearchResultsGetCount()
;  *  
;  *  Summary:
;  *    Gets the total number of found items in a search.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKSearchResultsGetCount" 
   ((inSearchResults (:pointer :__SKSearchResults))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
;  *  SKSearchResultsGetInfoInRange()
;  *  
;  *  Summary:
;  *    Fills in requested results, returns number of items that were
;  *    returned.
;  *  
;  *  Discussion:
;  *    Search results are returned in descending order of relevance
;  *    score.
;  *  
;  *  Parameters:
;  *    
;  *    inSearchResults:
;  *      A reference to the search results.
;  *    
;  *    inRange:
;  *      A CFRange value pair, specified as (location, length). The
;  *      location value specifies the starting item by ranking. The
;  *      length value specifies the total number of items. Examples:
;  *      (0,1) means the first item, which is also the highest ranking
;  *      item. (1,1) means the second item, which is also the
;  *      second-highest ranking item. (0,5) means to get the first 5
;  *      items.
;  *    
;  *    outDocumentsArray:
;  *      An array of found documents.
;  *    
;  *    outIndexesArray:
;  *      An array of indexes in which the found docouments reside. May
;  *      be <tt>NULL</tt> provided that the client does not care.
;  *    
;  *    outScoresArray:
;  *      An array of correspondence scores for found items. May be
;  *      <tt>NULL</tt>.
;  *  
;  *  Result:
;  *    The number of items returned -- usually the same number as
;  *    specified.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKSearchResultsGetInfoInRange" 
   ((inSearchResults (:pointer :__SKSearchResults))
    (location :SInt32)
    (length :SInt32)
    (outDocumentsArray (:pointer :SKDOCUMENTREF))
    (outIndexesArray (:pointer :SKINDEXREF))
    (outScoresArray (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; 
;  *  SKSearchResultsCopyMatchingTerms()
;  *  
;  *  Summary:
;  *    Gets the matching terms for the specified search result item
;  *    index.
;  *  
;  *  Parameters:
;  *    
;  *    inSearchResults:
;  *      A reference to the search results.
;  *    
;  *    inItem:
;  *      The search result item index, starting from 1.
;  *  
;  *  Result:
;  *    A reference to a CFArray object of term IDs.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SKSearchResultsCopyMatchingTerms" 
   ((inSearchResults (:pointer :__SKSearchResults))
    (inItem :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFArray)
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

; #endif /* __SKSEARCH__ */


(provide-interface "SKSearch")