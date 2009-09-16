(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSURLResponse.h"
; at Sunday July 2,2006 7:31:04 pm.
; 	
;     NSURLResponse.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 
;  Note: To use the APIs described in these headers, you must perform
;  a runtime check for Foundation-462.1 or later.

; #import <AvailabilityMacros.h>

; #if defined(MAC_OS_X_VERSION_10_2) && (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2)

; #import <Foundation/NSObject.h>
; #define NSURLResponseUnknownLength ((long long)-1)
; !
;     @class NSURLResponse
; 
;     @abstract An NSURLResponse object represents a URL load response in a
;     manner independent of protocol and URL scheme.
; 
;     @discussion NSURLResponse encapsulates the metadata associated
;     with a URL load. Note that NSURLResponse objects do not contain
;     the actual bytes representing the content of a URL. See
;     NSURLConnection and NSURLConnectionDelegate for more information
;     about receiving the content data for a URL load.
; 
#| @INTERFACE 
NSURLResponse : NSObject <NSCoding, NSCopying>
{
    NSURLResponseInternal *_internal;
}


- (id)initWithURL:(NSURL *)URL MIMEType:(NSString *)MIMEType expectedContentLength:(int)length textEncodingName:(NSString *)name;


- (NSURL *)URL;


- (NSString *)MIMEType;


- (long long)expectedContentLength;


- (NSString *)textEncodingName;


- (NSString *)suggestedFilename;

|#
; !
;     @class NSHTTPURLResponse
; 
;     @abstract An NSHTTPURLResponse object represents a response to an
;     HTTP URL load. It is a specialization of NSURLResponse which
;     provides conveniences for accessing information specific to HTTP
;     protocol responses.
; 
#| @INTERFACE 
NSHTTPURLResponse : NSURLResponse 
{
    NSHTTPURLResponseInternal *_httpInternal;
}


- (int)statusCode;


- (NSDictionary *)allHeaderFields;


+ (NSString *)localizedStringForStatusCode:(int)statusCode;

|#

; #endif


(provide-interface "NSURLResponse")