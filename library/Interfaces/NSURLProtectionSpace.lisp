(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSURLProtectionSpace.h"
; at Sunday July 2,2006 7:31:04 pm.
; 	
;     NSURLProtectionSpace.h
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
;     @const NSURLProtectionSpaceHTTPProxy
;     @abstract The proxy type for http proxies
; 
(def-mactype :NSURLProtectionSpaceHTTPProxy (find-mactype '(:pointer :NSString)))
; !
;     @const NSURLProtectionSpaceHTTPSProxy
;     @abstract The proxy type for https proxies
; 
(def-mactype :NSURLProtectionSpaceHTTPSProxy (find-mactype '(:pointer :NSString)))
; !
;     @const NSURLProtectionSpaceFTPProxy
;     @abstract The proxy type for ftp proxies
; 
(def-mactype :NSURLProtectionSpaceFTPProxy (find-mactype '(:pointer :NSString)))
; !
;     @const NSURLProtectionSpaceSOCKProxy
;     @abstract The proxy type for SOCKS proxies
; 
(def-mactype :NSURLProtectionSpaceSOCKSProxy (find-mactype '(:pointer :NSString)))
; !
;     @const NSURLAuthenticationMethodDefault
;     @abstract The default authentication method for a protocol
; 
(def-mactype :NSURLAuthenticationMethodDefault (find-mactype '(:pointer :NSString)))
; !
;     @const NSURLAuthenticationMethodHTTPBasic
;     @abstract HTTP basic authentication. Equivalent to
;     NSURLAuthenticationMethodDefault for http.
; 
(def-mactype :NSURLAuthenticationMethodHTTPBasic (find-mactype '(:pointer :NSString)))
; !
;     @const NSURLAuthenticationMethodHTTPDigest
;     @abstract HTTP digest authentication.
; 
(def-mactype :NSURLAuthenticationMethodHTTPDigest (find-mactype '(:pointer :NSString)))
; !
;     @const NSURLAuthenticationMethodHTMLForm
;     @abstract HTML form authentication. Applies to any protocol.
; 
(def-mactype :NSURLAuthenticationMethodHTMLForm (find-mactype '(:pointer :NSString)))
; !
;     @class NSURLProtectionSpace
;     @discussion This class represents a protection space requiring authentication.
; 
#| @INTERFACE 
NSURLProtectionSpace : NSObject <NSCopying>
{
private
    NSURLProtectionSpaceInternal *_internal;
}


- (id)initWithHost:(NSString *)host port:(int)port protocol:(NSString *)protocol realm:(NSString *)realm authenticationMethod:(NSString *)authenticationMethod;


- (id)initWithProxyHost:(NSString *)host port:(int)port type:(NSString *)type realm:(NSString *)realm  authenticationMethod:(NSString *)authenticationMethod;


- (NSString *)realm;


- (BOOL)receivesCredentialSecurely;


- (BOOL)isProxy;


- (NSString *)host;


- (int)port;


- (NSString *)proxyType;


- (NSString *)protocol;


- (NSString *)authenticationMethod;

|#

; #endif


(provide-interface "NSURLProtectionSpace")