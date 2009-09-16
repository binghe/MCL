(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebFrame.h"
; at Sunday July 2,2006 7:32:18 pm.
; 	
;     WebFrame.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 

; #import <Foundation/Foundation.h>
; !
;     @class WebFrame
;     @discussion Every web page is represented by at least one WebFrame.  A WebFrame
;     has a WebFrameView and a WebDataSource.
; 
#| @INTERFACE 
WebFrame : NSObject
{
private
    WebFramePrivate *_private;
}


- (id)initWithName:(NSString *)name webFrameView:(WebFrameView *)view webView:(WebView *)webView;


- (NSString *)name;


- (WebView *)webView;


- (WebFrameView *)frameView;


- (void)loadRequest:(NSURLRequest *)request;


- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)encodingName baseURL:(NSURL *)URL;


- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)URL;


- (WebDataSource *)dataSource;


- (WebDataSource *)provisionalDataSource;


- (void)stopLoading;


- (void)reload;


- (WebFrame *)findFrameNamed:(NSString *)name;


- (WebFrame *)parentFrame;


- (NSArray *)childFrames;

|#

(provide-interface "WebFrame")