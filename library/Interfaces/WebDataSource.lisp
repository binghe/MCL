(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebDataSource.h"
; at Sunday July 2,2006 7:32:17 pm.
; 	
;     WebDataSource.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
; 
;     Public header file.
; 

; #import <Cocoa/Cocoa.h>

; #import <WebKit/WebDocument.h>
; !
;     @class WebDataSource
;     @discussion A WebDataSource represents the data associated with a web page.
;     A datasource has a WebDocumentRepresentation which holds an appropriate
;     representation of the data.  WebDataSources manage a hierarchy of WebFrames.
;     WebDataSources are typically related to a view by their containing WebFrame.
; 
#| @INTERFACE 
WebDataSource : NSObject
{
private
    WebDataSourcePrivate *_private;
}


- (id)initWithRequest:(NSURLRequest *)request;


- (NSData *)data;


- (id <WebDocumentRepresentation>)representation;


- (WebFrame *)webFrame;


- (NSURLRequest *)initialRequest;


- (NSMutableURLRequest *)request;


- (NSURLResponse *)response;


- (NSString *)textEncodingName;


- (BOOL)isLoading;


- (NSString *)pageTitle;

|#

(provide-interface "WebDataSource")