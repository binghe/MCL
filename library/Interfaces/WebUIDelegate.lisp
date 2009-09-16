(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebUIDelegate.h"
; at Sunday July 2,2006 7:32:18 pm.
; 
;     WebUIDelegate.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 

; #import <Cocoa/Cocoa.h>

; #import <Foundation/NSURLRequest.h>
; !
;     @enum WebMenuItemTag
;     @discussion Each menu item in the default menu items array passed in
;     contextMenuItemsForElement:defaultMenuItems: has its tag set to one of the WebMenuItemTags.
;     When iterating through the default menu items array, use the tag to differentiate between them.
; 

(defconstant $WebMenuItemTagOpenLinkInNewWindow 1)
(defconstant $WebMenuItemTagDownloadLinkToDisk 2)
(defconstant $WebMenuItemTagCopyLinkToClipboard 3)
(defconstant $WebMenuItemTagOpenImageInNewWindow 4)
(defconstant $WebMenuItemTagDownloadImageToDisk 5)
(defconstant $WebMenuItemTagCopyImageToClipboard 6)
(defconstant $WebMenuItemTagOpenFrameInNewWindow 7)
(defconstant $WebMenuItemTagCopy 8)
; !
;     @protocol WebOpenPanelResultListener
;     @discussion This protocol is used to call back with the results of
;     the file open panel requested by runOpenPanelForFileButtonWithResultListener:
; 
#| @PROTOCOL 
WebOpenPanelResultListener <NSObject>


- (void)chooseFilename:(NSString *)fileName;


- (void)cancel;

|#
; !
;     @category WebUIDelegate
;     @discussion A class that implements WebUIDelegate provides
;     window-related methods that may be used by Javascript, plugins and
;     other aspects of web pages. These methods are used to open new
;     windows and control aspects of existing windows.
; 
#| @INTERFACE 
NSObject (WebUIDelegate)


- (WebView *)webView:(WebView *)sender createWebViewWithRequest:(NSURLRequest *)request;


- (void)webViewShow:(WebView *)sender;


- (void)webViewClose:(WebView *)sender;


- (void)webViewFocus:(WebView *)sender;


- (void)webViewUnfocus:(WebView *)sender;


- (NSResponder *)webViewFirstResponder:(WebView *)sender;


- (void)webView:(WebView *)sender makeFirstResponder:(NSResponder *)responder;


- (void)webView:(WebView *)sender setStatusText:(NSString *)text;


- (NSString *)webViewStatusText:(WebView *)sender;


- (BOOL)webViewAreToolbarsVisible:(WebView *)sender;


- (void)webView:(WebView *)sender setToolbarsVisible:(BOOL)visible;


- (BOOL)webViewIsStatusBarVisible:(WebView *)sender;


- (void)webView:(WebView *)sender setStatusBarVisible:(BOOL)visible;


- (BOOL)webViewIsResizable:(WebView *)sender;


- (void)webView:(WebView *)sender setResizable:(BOOL)resizable;


- (void)webView:(WebView *)sender setFrame:(NSRect)frame;


- (NSRect)webViewFrame:(WebView *)sender;


- (void)webView:(WebView *)sender setContentRect:(NSRect)contentRect;


- (NSRect)webViewContentRect:(WebView *)sender;


- (void)webView:(WebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message;


- (BOOL)webView:(WebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message;


- (NSString *)webView:(WebView *)sender runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText;


- (void)webView:(WebView *)sender runOpenPanelForFileButtonWithResultListener:(id<WebOpenPanelResultListener>)resultListener;


- (void)webView:(WebView *)sender mouseDidMoveOverElement:(NSDictionary *)elementInformation modifierFlags:(unsigned int)modifierFlags;


- (NSArray *)webView:(WebView *)sender contextMenuItemsForElement:(NSDictionary *)element defaultMenuItems:(NSArray *)defaultMenuItems;

|#

(provide-interface "WebUIDelegate")