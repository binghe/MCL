(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSHTTPCookie.h"
; at Sunday July 2,2006 7:30:50 pm.
; 	
;     NSHTTPCookie.h
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
;     @const NSHTTPCookieName
;     @discussion Key for cookie name
; 
(def-mactype :NSHTTPCookieName (find-mactype '(:pointer :NSString)))
; !
;     @const NSHTTPCookieValue
;     @discussion Key for cookie value
; 
(def-mactype :NSHTTPCookieValue (find-mactype '(:pointer :NSString)))
; !
;     @const NSHTTPCookieOriginURL
;     @discussion Key for cookie origin URL
; 
(def-mactype :NSHTTPCookieOriginURL (find-mactype '(:pointer :NSString)))
; !
;     @const NSHTTPCookieVersion
;     @discussion Key for cookie version
; 
(def-mactype :NSHTTPCookieVersion (find-mactype '(:pointer :NSString)))
; !
;     @const NSHTTPCookieDomain
;     @discussion Key for cookie domain
; 
(def-mactype :NSHTTPCookieDomain (find-mactype '(:pointer :NSString)))
; !
;     @const NSHTTPCookiePath
;     @discussion Key for cookie path
; 
(def-mactype :NSHTTPCookiePath (find-mactype '(:pointer :NSString)))
; !
;     @const NSHTTPCookieSecure
;     @discussion Key for cookie secure flag
; 
(def-mactype :NSHTTPCookieSecure (find-mactype '(:pointer :NSString)))
; !
;     @const NSHTTPCookieExpires
;     @discussion Key for cookie expiration date
; 
(def-mactype :NSHTTPCookieExpires (find-mactype '(:pointer :NSString)))
; !
;     @const NSHTTPCookieComment
;     @discussion Key for cookie comment text
; 
(def-mactype :NSHTTPCookieComment (find-mactype '(:pointer :NSString)))
; !
;     @const NSHTTPCookieCommentURL
;     @discussion Key for cookie comment URL
; 
(def-mactype :NSHTTPCookieCommentURL (find-mactype '(:pointer :NSString)))
; !
;     @const NSHTTPCookieDiscard
;     @discussion Key for cookie discard (session-only) flag
; 
(def-mactype :NSHTTPCookieDiscard (find-mactype '(:pointer :NSString)))
; !
;     @const NSHTTPCookieMaximumAge
;     @discussion Key for cookie maximum age (an alternate way of specifying the expiration)
; 
(def-mactype :NSHTTPCookieMaximumAge (find-mactype '(:pointer :NSString)))
; !
;     @const NSHTTPCookiePort
;     @discussion Key for cookie ports
; 
(def-mactype :NSHTTPCookiePort (find-mactype '(:pointer :NSString)))
; !
;     @class NSHTTPCookie
;     @abstract NSHTTPCookie represents an http cookie.
;     @discussion A NSHTTPCookie instance represents a single http cookie. It is
;     an immutable object initialized from a dictionary that contains
;     the various cookie attributes. It has accessors to get the various
;     attributes of a cookie.
; 
#| @INTERFACE 
NSHTTPCookie : NSObject
{
private
    NSHTTPCookieInternal * _cookiePrivate;
}


- (id)initWithProperties:(NSDictionary *)properties;


+ (id)cookieWithProperties:(NSDictionary *)properties;


+ (NSDictionary *)requestHeaderFieldsWithCookies:(NSArray *)cookies;


+ (NSArray *)cookiesWithResponseHeaderFields:(NSDictionary *)headerFields forURL:(NSURL *)URL;


- (NSDictionary *)properties;


- (unsigned)version;


- (NSString *)name;


- (NSString *)value;


- (NSDate *)expiresDate;


- (BOOL)isSessionOnly;


- (NSString *)domain;


- (NSString *)path;


- (BOOL)isSecure;


- (NSString *)comment;


- (NSURL *)commentURL;


- (NSArray *)portList;

|#

; #endif


(provide-interface "NSHTTPCookie")