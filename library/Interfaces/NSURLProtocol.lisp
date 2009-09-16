(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSURLProtocol.h"
; at Sunday July 2,2006 7:31:04 pm.
; 	
;     NSURLProtocol.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 
;  Note: To use the APIs described in these headers, you must perform
;  a runtime check for Foundation-462.1 or later.

; #import <AvailabilityMacros.h>

; #if defined(MAC_OS_X_VERSION_10_2) && (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2)

; #import <Foundation/NSObject.h>

; #import <Foundation/NSURLCache.h>
; !
;     @header NSURLProtocol.h
; 
;     This header file describes the constructs used to represent URL
;     protocols, and describes the extensible system by which specific
;     classes can be made to handle the loading of particular URL types or
;     schemes.
;     
;     <p>NSURLProtocol is an abstract class which provides the
;     basic structure for performing protocol-specific loading of URL
;     data.
;     
;     <p>The NSURLProtocolClient describes the integration points a
;     protocol implemention can use to hook into the URL loading system.
;     NSURLProtocolClient describes the methods a protocol implementation
;     needs to drive the URL loading system from a NSURLProtocol subclass.
;     
;     <p>To support customization of protocol-specific requests,
;     protocol implementors are encouraged to provide categories on
;     NSURLRequest and NSMutableURLRequest. Protocol implementors who
;     need to extend the capabilities of NSURLRequest and
;     NSMutableURLRequest in this way can store and retrieve
;     protocol-specific request data by using the
;     <tt>+propertyForKey:inRequest:</tt> and
;     <tt>+setProperty:forKey:inRequest:</tt> class methods on
;     NSURLProtocol. See the NSHTTPURLRequest on NSURLRequest and
;     NSMutableHTTPURLRequest on NSMutableURLRequest for examples of
;     such extensions.
;     
;     <p>An essential responsibility for a protocol implementor is
;     creating a NSURLResponse for each request it processes successfully.
;     A protocol implementor may wish to create a custom, mutable 
;     NSURLResponse class to aid in this work.
; 
; !
; @protocol NSURLProtocolClient
; @discussion NSURLProtocolClient provides the interface to the URL
; loading system that is intended for use by NSURLProtocol
; implementors.
; 
#| @PROTOCOL 
NSURLProtocolClient <NSObject>


- (void)URLProtocol:(NSURLProtocol *)protocol wasRedirectedToRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse;

    
- (void)URLProtocol:(NSURLProtocol *)protocol cachedResponseIsValid:(NSCachedURLResponse *)cachedResponse;

    
- (void)URLProtocol:(NSURLProtocol *)protocol didReceiveResponse:(NSURLResponse *)response cacheStoragePolicy:(NSURLCacheStoragePolicy)policy;

    
- (void)URLProtocol:(NSURLProtocol *)protocol didLoadData:(NSData *)data;

    
- (void)URLProtocolDidFinishLoading:(NSURLProtocol *)protocol;

    
- (void)URLProtocol:(NSURLProtocol *)protocol didFailWithError:(NSError *)error;

    
- (void)URLProtocol:(NSURLProtocol *)protocol didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;

    
- (void)URLProtocol:(NSURLProtocol *)protocol didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;

|#
; !
;     @class NSURLProtocol
;     
;     @abstract NSURLProtocol is an abstract class which provides the
;     basic structure for performing protocol-specific loading of URL
;     data. Concrete subclasses handle the specifics associated with one
;     or more protocols or URL schemes.
; 
#| @INTERFACE 
NSURLProtocol : NSObject
{
    private
    NSURLProtocolInternal *_internal;
}


- (id)initWithRequest:(NSURLRequest *)request cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id <NSURLProtocolClient>)client;


- (id <NSURLProtocolClient>)client;


- (NSURLRequest *)request;


- (NSCachedURLResponse *)cachedResponse;


  

+ (BOOL)canInitWithRequest:(NSURLRequest *)request;


+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request;


+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b;


- (void)startLoading;


- (void)stopLoading;




+ (id)propertyForKey:(NSString *)key inRequest:(NSURLRequest *)request;


+ (void)setProperty:(id)value forKey:(NSString *)key inRequest:(NSMutableURLRequest *)request;


+ (BOOL)registerClass:(Class)protocolClass;


+ (void)unregisterClass:(Class)protocolClass;

|#

; #endif


(provide-interface "NSURLProtocol")