(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebView.h"
; at Sunday July 2,2006 7:27:55 pm.
; 	
;     WebView.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 

; #import <Cocoa/Cocoa.h>
;  These strings are keys into the element dictionary provided in
;  the WebContextMenuDelegate's contextMenuItemsForElement and the WebwebViewPolicyDelegate's clickPolicyForElement.
(def-mactype :WebElementFrameKey (find-mactype '(:pointer :NSString)))
;  WebFrame of the element
(def-mactype :WebElementImageAltStringKey (find-mactype '(:pointer :NSString)))
;  NSString of the ALT attribute of the image element
(def-mactype :WebElementImageKey (find-mactype '(:pointer :NSString)))
;  NSImage of the image element
(def-mactype :WebElementImageRectKey (find-mactype '(:pointer :NSString)))
;  NSValue of an NSRect, the rect of the image element
(def-mactype :WebElementImageURLKey (find-mactype '(:pointer :NSString)))
;  NSURL of the image element
(def-mactype :WebElementIsSelectedKey (find-mactype '(:pointer :NSString)))
;  NSNumber of BOOL indicating whether the element is selected text or not 
(def-mactype :WebElementLinkURLKey (find-mactype '(:pointer :NSString)))
;  NSURL of the link if the element is within an anchor
(def-mactype :WebElementLinkTargetFrameKey (find-mactype '(:pointer :NSString)))
;  NSString of the target of the anchor
(def-mactype :WebElementLinkTitleKey (find-mactype '(:pointer :NSString)))
;  NSString of the title of the anchor
(def-mactype :WebElementLinkLabelKey (find-mactype '(:pointer :NSString)))
;  NSString of the text within the anchor
; 
;  @discussion Notifications sent by WebView to mark the progress of loads.
;  @constant WebViewProgressStartedNotification Posted whenever a load begins in the WebView, including
;  a load that is initiated in a subframe.  After receiving this notification zero or more
;  WebViewProgressEstimateChangedNotifications will be sent.  The userInfo will be nil.
;  @constant WebViewProgressEstimateChangedNotification Posted whenever the value of
;  estimatedProgress changes.  The userInfo will be nil.
;  @constant WebViewProgressFinishedNotification Posted when the load for a WebView has finished.
;  The userInfo will be nil.
; 
(def-mactype :WebViewProgressStartedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :WebViewProgressEstimateChangedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :WebViewProgressFinishedNotification (find-mactype '(:pointer :NSString)))
; !
;     @class WebView
;     WebView manages the interaction between WebFrameViews and WebDataSources.  Modification
;     of the policies and behavior of the WebKit is largely managed by WebViews and their
;     delegates.
;     
;     <p>
;     Typical usage:
;     </p>
;     <pre>
;     WebView *webView;
;     WebFrame *mainFrame;
;     
;     webView  = [[WebView alloc] initWithFrame: NSMakeRect (0,0,640,480)];
;     mainFrame = [webView mainFrame];
;     [mainFrame loadRequest:request];
;     </pre>
;     
;     WebViews have the following delegates:  WebUIDelegate, WebResourceLoadDelegate,
;     WebFrameLoadDelegate, and WebPolicyDelegate.
;     
;     WebKit depends on the WebView's WebUIDelegate for all window
;     related management, including opening new windows and controlling the user interface
;     elements in those windows.
;     
;     WebResourceLoadDelegate is used to monitor the progress of resources as they are
;     loaded.  This delegate may be used to present users with a progress monitor.
;     
;     The WebFrameLoadDelegate receives messages when the URL in a WebFrame is
;     changed.
;     
;     WebView's WebPolicyDelegate can make determinations about how
;     content should be handled, based on the resource's URL and MIME type.
; 
#| @INTERFACE 
WebView : NSView
{
private
    WebViewPrivate *_private;
}


+ (BOOL)canShowMIMEType:(NSString *)MIMEType;



+ (BOOL)canShowMIMETypeAsHTML:(NSString *)MIMEType;


- (id)initWithFrame:(NSRect)frame frameName:(NSString *)frameName groupName:(NSString *)groupName;

    
- (void)setUIDelegate:(id)delegate;


- (id)UIDelegate;


- (void)setResourceLoadDelegate:(id)delegate;

    
- (id)resourceLoadDelegate;

    
- (void)setDownloadDelegate:(id)delegate;

    
- (id)downloadDelegate;

    
- (void)setFrameLoadDelegate:(id)delegate;

    
- (id)frameLoadDelegate;

    
- (void)setPolicyDelegate:(id)delegate;

    
- (id)policyDelegate;

    
- (WebFrame *)mainFrame;

    
- (WebBackForwardList *)backForwardList;

    
- (void)setMaintainsBackForwardList:(BOOL)flag;

    
- (BOOL)goBack;

    
- (BOOL)goForward;

    
- (BOOL)goToBackForwardItem:(WebHistoryItem *)item;

    
- (void)setTextSizeMultiplier:(float)multiplier;

    
- (float)textSizeMultiplier;


- (void)setApplicationNameForUserAgent:(NSString *)applicationName;


- (NSString *)applicationNameForUserAgent;


- (void)setCustomUserAgent:(NSString *)userAgentString;


- (NSString *)customUserAgent;


- (NSString *)userAgentForURL:(NSURL *)URL;



- (BOOL)supportsTextEncoding;


- (void)setCustomTextEncodingName:(NSString *)encodingName;


- (NSString *)customTextEncodingName;


- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;


- (void)setPreferences: (WebPreferences *)prefs;


- (WebPreferences *)preferences;


- (void)setPreferencesIdentifier:(NSString *)anIdentifier;


- (NSString *)preferencesIdentifier;



- (void)setHostWindow:(NSWindow *)hostWindow;


- (NSWindow *)hostWindow;


- (BOOL)searchFor:(NSString *)string direction:(BOOL)forward caseSensitive:(BOOL)caseFlag wrap:(BOOL)wrapFlag;


+ (void)registerViewClass:(Class)viewClass representationClass:(Class)representationClass forMIMEType:(NSString *)MIMEType;



- (void)setGroupName:(NSString *)groupName;


- (NSString *)groupName;



- (double)estimatedProgress;

|#
#| @INTERFACE 
WebView (WebIBActions) <NSUserInterfaceValidations>
- (IBAction)takeStringURLFrom:(id)sender;
- (IBAction)stopLoading:(id)sender;
- (IBAction)reload:(id)sender;
- (BOOL)canGoBack;
- (IBAction)goBack:(id)sender;
- (BOOL)canGoForward;
- (IBAction)goForward:(id)sender;
- (BOOL)canMakeTextLarger;
- (IBAction)makeTextLarger:(id)sender;
- (BOOL)canMakeTextSmaller;
- (IBAction)makeTextSmaller:(id)sender;
|#

(provide-interface "WebView")