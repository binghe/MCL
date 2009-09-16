(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSHTTPCookieStorage.h"
; at Sunday July 2,2006 7:30:50 pm.
; 	
;     NSHTTPCookieStorage.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 
;  Note: To use the APIs described in these headers, you must perform
;  a runtime check for Foundation-462.1 or later.

; #import <AvailabilityMacros.h>

; #if defined(MAC_OS_X_VERSION_10_2) && (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2)

; #import <Foundation/NSObject.h>
; !
;     @enum NSHTTPCookieAcceptPolicy
;     @abstract Values for the different cookie accept policies
;     @constant NSHTTPCookieAcceptPolicyAlways Accept all cookies
;     @constant NSHTTPCookieAcceptPolicyNever Reject all cookies
;     @constant NSHTTPCookieAcceptPolicyOnlyFromMainDocumentDomain Accept cookies
;     only from the main document domain
; 

(defconstant $NSHTTPCookieAcceptPolicyAlways 0)
(defconstant $NSHTTPCookieAcceptPolicyNever 1)
(defconstant $NSHTTPCookieAcceptPolicyOnlyFromMainDocumentDomain 2)
(def-mactype :NSHTTPCookieAcceptPolicy (find-mactype ':SINT32))
; !
;     @class NSHTTPCookieStorage 
;     @discussion NSHTTPCookieStorage implements a singleton object (shared
;     instance) which manages the shared cookie store.  It has methods
;     to allow clients to set and remove cookies, and get the current
;     set of cookies.  It also has convenience methods to parse and
;     generate cookie-related HTTP header fields.
; 
#| @INTERFACE 
NSHTTPCookieStorage : NSObject
{
    private
    NSHTTPCookieStorageInternal *_internal;
}


+ (NSHTTPCookieStorage *)sharedHTTPCookieStorage;


- (NSArray *)cookies;


- (void)setCookie:(NSHTTPCookie *)cookie;


- (void)deleteCookie:(NSHTTPCookie *)cookie;


- (NSArray *)cookiesForURL:(NSURL *)URL;


- (void)setCookies:(NSArray *)cookies forURL:(NSURL *)URL mainDocumentURL:(NSURL *)mainDocumentURL;


- (NSHTTPCookieAcceptPolicy)cookieAcceptPolicy;


- (void)setCookieAcceptPolicy:(NSHTTPCookieAcceptPolicy)cookieAcceptPolicy;

|#
; !
;     @const NSHTTPCookieManagerAcceptPolicyChangedNotification
;     @discussion Name of notification that should be posted to the
;     distributed notification center whenever the accept cookies
;     preference is changed
; 
(def-mactype :NSHTTPCookieManagerAcceptPolicyChangedNotification (find-mactype '(:pointer :NSString)))
; !
;     @const NSHTTPCookieManagerCookiesChangedNotification
;     @abstract Notification sent when the set of cookies changes
; 
(def-mactype :NSHTTPCookieManagerCookiesChangedNotification (find-mactype '(:pointer :NSString)))

; #endif


(provide-interface "NSHTTPCookieStorage")