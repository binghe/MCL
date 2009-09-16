(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebFrameLoadDelegate.h"
; at Sunday July 2,2006 7:32:18 pm.
; 	
;     WebFrameLoadDelegate.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.
;     
;     Public header file.
; 

; #import <Cocoa/Cocoa.h>
; !
;     @category WebFrameLoadDelegate
;     @discussion A WebView's WebFrameLoadDelegate tracks the loading progress of its frames.
;     When a data source of a frame starts to load, the data source is considered "provisional".
;     Once at least one byte is received, the data source is considered "committed". This is done
;     so the contents of the frame will not be lost if the new data source fails to successfully load.
; 
#| @INTERFACE 
NSObject (WebFrameLoadDelegate)


- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame;


- (void)webView:(WebView *)sender didReceiveServerRedirectForProvisionalLoadForFrame:(WebFrame *)frame;


- (void)webView:(WebView *)sender didFailProvisionalLoadWithError:(NSError *)error forFrame:(WebFrame *)frame;


- (void)webView:(WebView *)sender didCommitLoadForFrame:(WebFrame *)frame;


- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title forFrame:(WebFrame *)frame;


- (void)webView:(WebView *)sender didReceiveIcon:(NSImage *)image forFrame:(WebFrame *)frame;


- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame;


- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame;


- (void)webView:(WebView *)sender didChangeLocationWithinPageForFrame:(WebFrame *)frame;


- (void)webView:(WebView *)sender willPerformClientRedirectToURL:(NSURL *)URL delay:(NSTimeInterval)seconds fireDate:(NSDate *)date forFrame:(WebFrame *)frame;


- (void)webView:(WebView *)sender didCancelClientRedirectForFrame:(WebFrame *)frame;


- (void)webView:(WebView *)sender willCloseFrame:(WebFrame *)frame;

|#

(provide-interface "WebFrameLoadDelegate")