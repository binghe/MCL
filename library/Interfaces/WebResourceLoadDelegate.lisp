(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebResourceLoadDelegate.h"
; at Sunday July 2,2006 7:32:18 pm.
; 
;     WebResourceLoadDelegate.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.
;     
;     Public header file.
;  
; !
;     @category  WebResourceLoadDelegate
;     @discussion Implementors of this protocol will receive messages indicating
;     that a resource is about to be loaded, data has been received for a resource,
;     an error has been received for a resource, and completion of a resource load.
;     Implementors are also given the opportunity to mutate requests before they are sent.
;     The various progress methods of this protocol all receive an identifier as the
;     parameter.  This identifier can be used to track messages associated with a single
;     resource.  For example, a single resource may generate multiple 
;     resource:willSendRequest:redirectResponse:fromDataSource: messages as it's URL is redirected.
; 
#| @INTERFACE 
NSObject (WebResourceLoadDelegate)


- (id)webView:(WebView *)sender identifierForInitialRequest:(NSURLRequest *)request fromDataSource:(WebDataSource *)dataSource;


- (NSURLRequest *)webView:(WebView *)sender resource:(id)identifier willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(WebDataSource *)dataSource;


- (void)webView:(WebView *)sender resource:(id)identifier didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge fromDataSource:(WebDataSource *)dataSource;


- (void)webView:(WebView *)sender resource:(id)identifier didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge fromDataSource:(WebDataSource *)dataSource;


- (void)webView:(WebView *)sender resource:(id)identifier didReceiveResponse:(NSURLResponse *)response fromDataSource:(WebDataSource *)dataSource;


- (void)webView:(WebView *)sender resource:(id)identifier didReceiveContentLength: (unsigned)length fromDataSource:(WebDataSource *)dataSource;


- (void)webView:(WebView *)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource;


- (void)webView:(WebView *)sender resource:(id)identifier didFailLoadingWithError:(NSError *)error fromDataSource:(WebDataSource *)dataSource;


- (void)webView:(WebView *)sender plugInFailedWithError:(NSError *)error dataSource:(WebDataSource *)dataSource;

|#

(provide-interface "WebResourceLoadDelegate")