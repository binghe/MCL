(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFXMLNode.h"
; at Sunday July 2,2006 7:22:54 pm.
; 	CFXMLNode.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFXMLNODE__)
(defconstant $__COREFOUNDATION_CFXMLNODE__ 1)
; #define __COREFOUNDATION_CFXMLNODE__ 1

(require-interface "CoreFoundation/CFArray")

(require-interface "CoreFoundation/CFDictionary")

(require-interface "CoreFoundation/CFString")

(require-interface "CoreFoundation/CFTree")

(require-interface "CoreFoundation/CFURL")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(defconstant $kCFXMLNodeCurrentVersion 1)

(def-mactype :CFXMLNodeRef (find-mactype '(:pointer :__CFXMLNode)))

(def-mactype :CFXMLTreeRef (find-mactype ':CFTreeRef))
;   An CFXMLNode describes an individual XML construct - like a tag, or a comment, or a string
;     of character data.  Each CFXMLNode contains 3 main pieces of information - the node's type,
;     the data string, and a pointer to an additional data structure.  The node's type ID is an enum
;     value of type CFXMLNodeTypeID.  The data string is always a CFStringRef; the meaning of the
;     string is dependent on the node's type ID. The format of the additional data is also dependent
;     on the node's type; in general, there is a custom structure for each type that requires
;     additional data.  See below for the mapping from type ID to meaning of the data string and
;     structure of the additional data.  Note that these structures are versioned, and may change
;     as the parser changes.  The current version can always be identified by kCFXMLNodeCurrentVersion;
;     earlier versions can be identified and used by passing earlier values for the version number
;     (although the older structures would have been removed from the header).
; 
;     An CFXMLTree is simply a CFTree whose context data is known to be an CFXMLNodeRef.  As
;     such, an CFXMLTree can be used to represent an entire XML document; the CFTree
;     provides the tree structure of the document, while the CFXMLNodes identify and describe
;     the nodes of the tree.  An XML document can be parsed to a CFXMLTree, and a CFXMLTree
;     can generate the data for the equivalent XML document - see CFXMLParser.h for more
;     information on parsing XML.
;     
;  Type codes for the different possible XML nodes; this list may grow.

(defconstant $kCFXMLNodeTypeDocument 1)
(defconstant $kCFXMLNodeTypeElement 2)
(defconstant $kCFXMLNodeTypeAttribute 3)
(defconstant $kCFXMLNodeTypeProcessingInstruction 4)
(defconstant $kCFXMLNodeTypeComment 5)
(defconstant $kCFXMLNodeTypeText 6)
(defconstant $kCFXMLNodeTypeCDATASection 7)
(defconstant $kCFXMLNodeTypeDocumentFragment 8)
(defconstant $kCFXMLNodeTypeEntity 9)
(defconstant $kCFXMLNodeTypeEntityReference 10)
(defconstant $kCFXMLNodeTypeDocumentType 11)
(defconstant $kCFXMLNodeTypeWhitespace 12)
(defconstant $kCFXMLNodeTypeNotation 13)
(defconstant $kCFXMLNodeTypeElementTypeDeclaration 14)
(defconstant $kCFXMLNodeTypeAttributeListDeclaration 15)
(def-mactype :CFXMLNodeTypeCode (find-mactype ':SINT32))
(defrecord CFXMLElementInfo
   (attributes (:pointer :__CFDictionary))
   (attributeOrder (:pointer :__CFArray))
   (isEmpty :Boolean)
   (_reserved (:array :character 3))
)
(defrecord CFXMLProcessingInstructionInfo
   (dataString (:pointer :__CFString))
)
(defrecord CFXMLDocumentInfo
   (sourceURL (:pointer :__CFURL))
   (encoding :UInt32)
)
(defrecord CFXMLExternalID
   (systemID (:pointer :__CFURL))
   (publicID (:pointer :__CFString))
)
(defrecord CFXMLDocumentTypeInfo
   (externalID :CFXMLEXTERNALID)
)
(defrecord CFXMLNotationInfo
   (externalID :CFXMLEXTERNALID)
)
(defrecord CFXMLElementTypeDeclarationInfo                                                ;  This is expected to change in future versions 
   (contentDescription (:pointer :__CFString))
)
(defrecord CFXMLAttributeDeclarationInfo                                                ;  This is expected to change in future versions 
   (attributeName (:pointer :__CFString))
   (typeString (:pointer :__CFString))
   (defaultString (:pointer :__CFString))
)
(defrecord CFXMLAttributeListDeclarationInfo
   (numberOfAttributes :SInt32)
   (attributes (:pointer :CFXMLATTRIBUTEDECLARATIONINFO))
)

(defconstant $kCFXMLEntityTypeParameter 0)      ;  Implies parsed, internal 

(defconstant $kCFXMLEntityTypeParsedInternal 1)
(defconstant $kCFXMLEntityTypeParsedExternal 2)
(defconstant $kCFXMLEntityTypeUnparsed 3)
(defconstant $kCFXMLEntityTypeCharacter 4)
(def-mactype :CFXMLEntityTypeCode (find-mactype ':SINT32))
(defrecord CFXMLEntityInfo
   (entityType :SInt32)
   (replacementText (:pointer :__CFString))     ;  NULL if entityType is external or unparsed 
   (entityID :CFXMLEXTERNALID)                  ;  entityID.systemID will be NULL if entityType is internal 
   (notationName (:pointer :__CFString))        ;  NULL if entityType is parsed 
)
(defrecord CFXMLEntityReferenceInfo
   (entityType :SInt32)
)
; 
;  dataTypeCode                       meaning of dataString                format of infoPtr
;  ===========                        =====================                =================
;  kCFXMLNodeTypeDocument             <currently unused>                   CFXMLDocumentInfo *
;  kCFXMLNodeTypeElement              tag name                             CFXMLElementInfo *
;  kCFXMLNodeTypeAttribute            <currently unused>                   <currently unused>
;  kCFXMLNodeTypeProcessInstruction   name of the target                   CFXMLProcessingInstructionInfo *
;  kCFXMLNodeTypeComment              text of the comment                  NULL
;  kCFXMLNodeTypeText                 the text's contents                  NULL
;  kCFXMLNodeTypeCDATASection         text of the CDATA                    NULL
;  kCFXMLNodeTypeDocumentFragment     <currently unused>                   <currently unused>
;  kCFXMLNodeTypeEntity               name of the entity                   CFXMLEntityInfo *
;  kCFXMLNodeTypeEntityReference      name of the referenced entity        CFXMLEntityReferenceInfo *
;  kCFXMLNodeTypeDocumentType         name given as top-level element      CFXMLDocumentTypeInfo *
;  kCFXMLNodeTypeWhitespace           text of the whitespace               NULL
;  kCFXMLNodeTypeNotation             notation name                        CFXMLNotationInfo *
;  kCFXMLNodeTypeElementTypeDeclaration     tag name                       CFXMLElementTypeDeclarationInfo *
;  kCFXMLNodeTypeAttributeListDeclaration   tag name                       CFXMLAttributeListDeclarationInfo *
; 

(deftrap-inline "_CFXMLNodeGetTypeID" 
   (
   )
   :UInt32
() )
;  Creates a new node based on xmlType, dataString, and additionalInfoPtr.  version (together with xmlType) determines the expected structure of additionalInfoPtr 

(deftrap-inline "_CFXMLNodeCreate" 
   ((alloc (:pointer :__CFAllocator))
    (xmlType :SInt32)
    (dataString (:pointer :__CFString))
    (additionalInfoPtr :pointer)
    (version :SInt32)
   )
   (:pointer :__CFXMLNode)
() )
;  Creates a copy of origNode (which may not be NULL). 

(deftrap-inline "_CFXMLNodeCreateCopy" 
   ((alloc (:pointer :__CFAllocator))
    (origNode (:pointer :__CFXMLNode))
   )
   (:pointer :__CFXMLNode)
() )

(deftrap-inline "_CFXMLNodeGetTypeCode" 
   ((node (:pointer :__CFXMLNode))
   )
   :SInt32
() )

(deftrap-inline "_CFXMLNodeGetString" 
   ((node (:pointer :__CFXMLNode))
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFXMLNodeGetInfoPtr" 
   ((node (:pointer :__CFXMLNode))
   )
   (:pointer :void)
() )

(deftrap-inline "_CFXMLNodeGetVersion" 
   ((node (:pointer :__CFXMLNode))
   )
   :SInt32
() )
;  CFXMLTreeRef 
;  Creates a childless, parentless tree from node 

(deftrap-inline "_CFXMLTreeCreateWithNode" 
   ((allocator (:pointer :__CFAllocator))
    (node (:pointer :__CFXMLNode))
   )
   (:pointer :__CFTree)
() )
;  Extracts and returns the node stored in xmlTree 

(deftrap-inline "_CFXMLTreeGetNode" 
   ((xmlTree (:pointer :__CFTree))
   )
   (:pointer :__CFXMLNode)
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFXMLNODE__ */


(provide-interface "CFXMLNode")