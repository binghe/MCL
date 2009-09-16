(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebDocument.h"
; at Sunday July 2,2006 7:32:17 pm.
; 	
;     WebDocument.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 

; #import <Cocoa/Cocoa.h>
; !
;     @protocol WebDocumentView
;     @discussion Protocol implemented by the document view of WebFrameView
; 
#| @PROTOCOL 
WebDocumentView <NSObject>


- (void)setDataSource:(WebDataSource *)dataSource;


- (void)dataSourceUpdated:(WebDataSource *)dataSource;


- (void)setNeedsLayout:(BOOL)flag;


- (void)layout;


- (void)viewWillMoveToHostWindow:(NSWindow *)hostWindow;


- (void)viewDidMoveToHostWindow;

|#
; !
;     @protocol WebDocumentSearching
;     @discussion Optional protocol for searching document view of WebFrameView. 
; 
#| @PROTOCOL 
WebDocumentSearching <NSObject>

- (BOOL)searchFor:(NSString *)string direction:(BOOL)forward caseSensitive:(BOOL)caseFlag wrap:(BOOL)wrapFlag;
|#
; !
;     @protocol WebDocumentText
;     @discussion Optional protocol for supporting text operations.
; 
#| @PROTOCOL 
WebDocumentText <NSObject>


- (BOOL)supportsTextEncoding;


- (NSString *)string;


- (NSAttributedString *)attributedString;


- (NSString *)selectedString;


- (NSAttributedString *)selectedAttributedString;



- (void)selectAll;


- (void)deselectAll;

|#
; !
;     @protocol WebDocumentRepresentation
;     @discussion Protocol implemented by the document representation of a data source.
; 
#| @PROTOCOL 
WebDocumentRepresentation <NSObject>

- (void)setDataSource:(WebDataSource *)dataSource;


- (void)receivedData:(NSData *)data withDataSource:(WebDataSource *)dataSource;


- (void)receivedError:(NSError *)error withDataSource:(WebDataSource *)dataSource;


- (void)finishedLoadingWithDataSource:(WebDataSource *)dataSource;


- (BOOL)canProvideDocumentSource;


- (NSString *)documentSource;


- (NSString *)title;

|#

(provide-interface "WebDocument")