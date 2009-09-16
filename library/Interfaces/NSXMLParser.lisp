(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSXMLParser.h"
; at Sunday July 2,2006 7:31:06 pm.
; 	NSXMLParser.h
;         Copyright 2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
#| @INTERFACE 
NSXMLParser : NSObject {
private
    void * _parser;
    id _delegate;
    void * _reserved1;
    void * _reserved2;
    void * _reserved3;
}
- (id)initWithContentsOfURL:(NSURL *)url;  - (id)initWithData:(NSData *)data; 
- (id)delegate;
- (void)setDelegate:(id)delegate;

- (void)setShouldProcessNamespaces:(BOOL)shouldProcessNamespaces;
- (void)setShouldReportNamespacePrefixes:(BOOL)shouldReportNamespacePrefixes;
- (void)setShouldResolveExternalEntities:(BOOL)shouldResolveExternalEntities;

- (BOOL)shouldProcessNamespaces;
- (BOOL)shouldReportNamespacePrefixes;
- (BOOL)shouldResolveExternalEntities;

- (BOOL)parse;	- (void)abortParsing;	
- (NSError *)parserError;	
|#
;  Once a parse has begun, the delegate may be interested in certain parser state. These methods will only return meaningful information during parsing, or after an error has occurred.
#| @INTERFACE 
NSXMLParser (NSXMLParserLocatorAdditions)
- (NSString *)publicID;
- (NSString *)systemID;
- (int)lineNumber;
- (int)columnNumber;
|#
; 
;  
;  For the discussion of event methods, assume the following XML:
; 
;  <?xml version="1.0" encoding="UTF-8"?>
;  <?xml-stylesheet type='text/css' href='cvslog.css'?>
;  <!DOCTYPE cvslog SYSTEM "cvslog.dtd">
;  <cvslog xmlns="http://xml.apple.com/cvslog">
;    <radar:radar xmlns:radar="http://xml.apple.com/radar">
;      <radar:bugID>2920186</radar:bugID>
;      <radar:title>API/NSXMLParser: there ought to be an NSXMLParser</radar:title>
;    </radar:radar>
;  </cvslog>
;  
;  
;  The parser's delegate is informed of events through the methods in the NSXMLParserDelegateEventAdditions category.
#| @INTERFACE 
NSObject (NSXMLParserDelegateEventAdditions)
- (void)parserDidStartDocument:(NSXMLParser *)parser;
    - (void)parserDidEndDocument:(NSXMLParser *)parser;
    
- (void)parser:(NSXMLParser *)parser foundNotationDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID;

- (void)parser:(NSXMLParser *)parser foundUnparsedEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID notationName:(NSString *)notationName;

- (void)parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(NSString *)type defaultValue:(NSString *)defaultValue;

- (void)parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model;

- (void)parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(NSString *)value;

- (void)parser:(NSXMLParser *)parser foundExternalEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
                        
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
    
- (void)parser:(NSXMLParser *)parser didStartMappingPrefix:(NSString *)prefix toURI:(NSString *)namespaceURI;
            
- (void)parser:(NSXMLParser *)parser didEndMappingPrefix:(NSString *)prefix;
    
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
    
- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString;
    
- (void)parser:(NSXMLParser *)parser foundProcessingInstructionWithTarget:(NSString *)target data:(NSString *)data;
    
- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment;
    
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock;
    
- (NSData *)parser:(NSXMLParser *)parser resolveExternalEntityName:(NSString *)name systemID:(NSString *)systemID;
    
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError;
    
- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError;
    
|#
(def-mactype :NSXMLParserErrorDomain (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  for use with NSError.
;  Error reporting

(defconstant $NSXMLParserInternalError 1)
(defconstant $NSXMLParserOutOfMemoryError 2)
(defconstant $NSXMLParserDocumentStartError 3)
(defconstant $NSXMLParserEmptyDocumentError 4)
(defconstant $NSXMLParserPrematureDocumentEndError 5)
(defconstant $NSXMLParserInvalidHexCharacterRefError 6)
(defconstant $NSXMLParserInvalidDecimalCharacterRefError 7)
(defconstant $NSXMLParserInvalidCharacterRefError 8)
(defconstant $NSXMLParserInvalidCharacterError 9)
(defconstant $NSXMLParserCharacterRefAtEOFError 10)
(defconstant $NSXMLParserCharacterRefInPrologError 11)
(defconstant $NSXMLParserCharacterRefInEpilogError 12)
(defconstant $NSXMLParserCharacterRefInDTDError 13)
(defconstant $NSXMLParserEntityRefAtEOFError 14)
(defconstant $NSXMLParserEntityRefInPrologError 15)
(defconstant $NSXMLParserEntityRefInEpilogError 16)
(defconstant $NSXMLParserEntityRefInDTDError 17)
(defconstant $NSXMLParserParsedEntityRefAtEOFError 18)
(defconstant $NSXMLParserParsedEntityRefInPrologError 19)
(defconstant $NSXMLParserParsedEntityRefInEpilogError 20)
(defconstant $NSXMLParserParsedEntityRefInInternalSubsetError 21)
(defconstant $NSXMLParserEntityReferenceWithoutNameError 22)
(defconstant $NSXMLParserEntityReferenceMissingSemiError 23)
(defconstant $NSXMLParserParsedEntityRefNoNameError 24)
(defconstant $NSXMLParserParsedEntityRefMissingSemiError 25)
(defconstant $NSXMLParserUndeclaredEntityError 26)
(defconstant $NSXMLParserUnparsedEntityError 28)
(defconstant $NSXMLParserEntityIsExternalError 29)
(defconstant $NSXMLParserEntityIsParameterError 30)
(defconstant $NSXMLParserUnknownEncodingError 31)
(defconstant $NSXMLParserEncodingNotSupportedError 32)
(defconstant $NSXMLParserStringNotStartedError 33)
(defconstant $NSXMLParserStringNotClosedError 34)
(defconstant $NSXMLParserNamespaceDeclarationError 35)
(defconstant $NSXMLParserEntityNotStartedError 36)
(defconstant $NSXMLParserEntityNotFinishedError 37)
(defconstant $NSXMLParserLessThanSymbolInAttributeError 38)
(defconstant $NSXMLParserAttributeNotStartedError 39)
(defconstant $NSXMLParserAttributeNotFinishedError 40)
(defconstant $NSXMLParserAttributeHasNoValueError 41)
(defconstant $NSXMLParserAttributeRedefinedError 42)
(defconstant $NSXMLParserLiteralNotStartedError 43)
(defconstant $NSXMLParserLiteralNotFinishedError 44)
(defconstant $NSXMLParserCommentNotFinishedError 45)
(defconstant $NSXMLParserProcessingInstructionNotStartedError 46)
(defconstant $NSXMLParserProcessingInstructionNotFinishedError 47)
(defconstant $NSXMLParserNotationNotStartedError 48)
(defconstant $NSXMLParserNotationNotFinishedError 49)
(defconstant $NSXMLParserAttributeListNotStartedError 50)
(defconstant $NSXMLParserAttributeListNotFinishedError 51)
(defconstant $NSXMLParserMixedContentDeclNotStartedError 52)
(defconstant $NSXMLParserMixedContentDeclNotFinishedError 53)
(defconstant $NSXMLParserElementContentDeclNotStartedError 54)
(defconstant $NSXMLParserElementContentDeclNotFinishedError 55)
(defconstant $NSXMLParserXMLDeclNotStartedError 56)
(defconstant $NSXMLParserXMLDeclNotFinishedError 57)
(defconstant $NSXMLParserConditionalSectionNotStartedError 58)
(defconstant $NSXMLParserConditionalSectionNotFinishedError 59)
(defconstant $NSXMLParserExternalSubsetNotFinishedError 60)
(defconstant $NSXMLParserDOCTYPEDeclNotFinishedError 61)
(defconstant $NSXMLParserMisplacedCDATAEndStringError 62)
(defconstant $NSXMLParserCDATANotFinishedError 63)
(defconstant $NSXMLParserMisplacedXMLDeclarationError 64)
(defconstant $NSXMLParserSpaceRequiredError 65)
(defconstant $NSXMLParserSeparatorRequiredError 66)
(defconstant $NSXMLParserNMTOKENRequiredError 67)
(defconstant $NSXMLParserNAMERequiredError 68)
(defconstant $NSXMLParserPCDATARequiredError 69)
(defconstant $NSXMLParserURIRequiredError 70)
(defconstant $NSXMLParserPublicIdentifierRequiredError 71)
(defconstant $NSXMLParserLTRequiredError 72)
(defconstant $NSXMLParserGTRequiredError 73)
(defconstant $NSXMLParserLTSlashRequiredError 74)
(defconstant $NSXMLParserEqualExpectedError 75)
(defconstant $NSXMLParserTagNameMismatchError 76)
(defconstant $NSXMLParserUnfinishedTagError 77)
(defconstant $NSXMLParserStandaloneValueError 78)
(defconstant $NSXMLParserInvalidEncodingNameError 79)
(defconstant $NSXMLParserCommentContainsDoubleHyphenError 80)
(defconstant $NSXMLParserInvalidEncodingError 81)
(defconstant $NSXMLParserExternalStandaloneEntityError 82)
(defconstant $NSXMLParserInvalidConditionalSectionError 83)
(defconstant $NSXMLParserEntityValueRequiredError 84)
(defconstant $NSXMLParserNotWellBalancedError 85)
(defconstant $NSXMLParserExtraContentError 86)
(defconstant $NSXMLParserInvalidCharacterInEntityError 87)
(defconstant $NSXMLParserParsedEntityRefInInternalError 88)
(defconstant $NSXMLParserEntityRefLoopError 89)
(defconstant $NSXMLParserEntityBoundaryError 90)
(defconstant $NSXMLParserInvalidURIError 91)
(defconstant $NSXMLParserURIFragmentError 92)
(defconstant $NSXMLParserNoDTDError 94)
(defconstant $NSXMLParserDelegateAbortedParseError #x200)
(def-mactype :NSXMLParserError (find-mactype ':SINT32))

; #endif		// Availability guard


(provide-interface "NSXMLParser")