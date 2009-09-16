(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebPolicyDelegate.h"
; at Sunday July 2,2006 7:32:18 pm.
; 	
;     WebPolicyDelegate.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 

; #import <Cocoa/Cocoa.h>
; !
;   @enum WebNavigationType
;   @abstract The type of action that triggered a possible navigation.
;   @constant WebNavigationTypeLinkClicked A link with an href was clicked.
;   @constant WebNavigationTypeFormSubmitted A form was submitted.
;   @constant WebNavigationTypeBackForward The user chose back or forward.
;   @constant WebNavigationTypeReload The User hit the reload button.
;   @constant WebNavigationTypeFormResubmitted A form was resubmitted (by virtue of doing back, forward or reload).
;   @constant WebNavigationTypeOther Navigation is taking place for some other reason.
; 

(defconstant $WebNavigationTypeLinkClicked 0)
(defconstant $WebNavigationTypeFormSubmitted 1)
(defconstant $WebNavigationTypeBackForward 2)
(defconstant $WebNavigationTypeReload 3)
(defconstant $WebNavigationTypeFormResubmitted 4)
(defconstant $WebNavigationTypeOther 5)
(def-mactype :WebNavigationType (find-mactype ':SINT32))
(def-mactype :WebActionNavigationTypeKey (find-mactype '(:pointer :NSString)))
;  NSNumber (WebActionType)
(def-mactype :WebActionElementKey (find-mactype '(:pointer :NSString)))
;  NSDictionary of element info
(def-mactype :WebActionButtonKey (find-mactype '(:pointer :NSString)))
;  NSEventType
(def-mactype :WebActionModifierFlagsKey (find-mactype '(:pointer :NSString)))
;  NSNumber (unsigned)
(def-mactype :WebActionOriginalURLKey (find-mactype '(:pointer :NSString)))
;  NSURL
; !
;     @protocol WebPolicyDecisionListener
;     @discussion This protocol is used to call back with the results of a
;     policy decision. This provides the ability to make these decisions
;     asyncrhonously, which means the decision can be made by prompting
;     with a sheet, for example.
; 
#| @PROTOCOL 
WebPolicyDecisionListener <NSObject>


- (void)use;

- (void)download;


- (void)ignore;

|#
; !
;     @category WebPolicyDelegate
;     @discussion While loading a URL, WebKit asks the WebPolicyDelegate for
;     policies that determine the action of what to do with the URL or the data that
;     the URL represents. Typically, the policy handler methods are called in this order:
; 
;     decidePolicyForNewWindowAction:request:newFrameName:decisionListener: (at most once)<BR>
;     decidePolicyForNavigationAction:request:frame:decisionListener: (zero or more times)<BR>
;     decidePolicyForMIMEType:request:frame: (zero or more times)<BR>
; 
;     New window policy is always checked. Navigation policy is checked
;     for the initial load and every redirect unless blocked by an
;     earlier policy. Content policy is checked once the content type is
;     known, unless an earlier policy prevented it.
; 
;     In rare cases, content policy might be checked more than
;     once. This occurs when loading a "multipart/x-mixed-replace"
;     document, also known as "server push". In this case, multiple
;     documents come in one navigation, with each replacing the last. In
;     this case, conent policy will be checked for each one.
; 
#| @INTERFACE 
NSObject (WebPolicyDelegate)


- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)actionInformation
                                                           request:(NSURLRequest *)request
                                                             frame:(WebFrame *)frame
                                                  decisionListener:(id<WebPolicyDecisionListener>)listener;


- (void)webView:(WebView *)webView decidePolicyForNewWindowAction:(NSDictionary *)actionInformation
                                                          request:(NSURLRequest *)request
                                                     newFrameName:(NSString *)frameName
                                                 decisionListener:(id<WebPolicyDecisionListener>)listener;


- (void)webView:(WebView *)webView decidePolicyForMIMEType:(NSString *)type
                                                   request:(NSURLRequest *)request
                                                     frame:(WebFrame *)frame
                                          decisionListener:(id<WebPolicyDecisionListener>)listener;


- (void)webView:(WebView *)webView unableToImplementPolicyWithError:(NSError *)error frame:(WebFrame *)frame;

|#

(provide-interface "WebPolicyDelegate")