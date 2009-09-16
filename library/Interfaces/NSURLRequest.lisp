(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSURLRequest.h"
; at Sunday July 2,2006 7:31:04 pm.
; 	
;     NSURLRequest.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 
;  Note: To use the APIs described in these headers, you must perform
;  a runtime check for Foundation-462.1 or later.

; #import <AvailabilityMacros.h>

; #if defined(MAC_OS_X_VERSION_10_2) && (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2)

; #import <Foundation/NSObject.h>

; #import <Foundation/NSDate.h>
; !
;     @header NSURLRequest.h
; 
;     This header file describes the constructs used to represent URL
;     load requests in a manner independent of protocol and URL scheme.
;     Immutable and mutable variants of this URL load request concept
;     are described, named NSURLRequest and NSMutableURLRequest,
;     respectively. A collection of constants is also declared to
;     exercise control over URL content caching policy.
; 
;     <p>NSURLRequest and NSMutableURLRequest are designed to be
;     customized to support protocol-specific requests. Protocol
;     implementors who need to extend the capabilities of NSURLRequest
;     and NSMutableURLRequest are encouraged to provide categories on
;     these classes as appropriate to support protocol-specific data. To
;     store and retrieve data, category methods can use the
;     <tt>+propertyForKey:inRequest:</tt> and
;     <tt>+setProperty:forKey:inRequest:</tt> class methods on
;     NSURLProtocol. See the NSHTTPURLRequest on NSURLRequest and
;     NSMutableHTTPURLRequest on NSMutableURLRequest for examples of
;     such extensions.
; 
;     <p>The main advantage of this design is that a client of the URL
;     loading library can implement request policies in a standard way
;     without type checking of requests or protocol checks on URLs. Any
;     protocol-specific details that have been set on a URL request will
;     be used if they apply to the particular URL being loaded, and will
;     be ignored if they do not apply.
; 
; !
;     @enum NSURLRequestCachePolicy
;     
;     @discussion The NSURLRequestCachePolicy enum defines constants that
;     can be used to specify the type of interactions that take place with
;     the caching system when the URL loading system processes a request.
;     Specifically, these constants cover interactions that have to do
;     with whether already-existing cache data is returned to satisfy a
;     URL load request.
;     
;     @constant NSURLRequestUseProtocolCachePolicy Specifies that the
;     caching logic defined in the protocol implementation, if any, is
;     used for a particular URL load request. This is the default policy
;     for URL load requests.
;               
;     @constant NSURLRequestReloadIgnoringCacheData Specifies that the
;     data for the URL load should be loaded from the origin source. No
;     existing cache data, regardless of its freshness or validity,
;     should be used to satisfy a URL load request.
;               
;     @constant NSURLRequestReturnCacheDataElseLoad Specifies that the
;     existing cache data should be used to satisfy a URL load request,
;     regardless of its age or expiration date. However, if there is no
;     existing data in the cache corresponding to a URL load request,
;     the URL is loaded from the origin source.
;               
;     @constant NSURLRequestReturnCacheDataDontLoad Specifies that the
;     existing cache data should be used to satisfy a URL load request,
;     regardless of its age or expiration date. However, if there is no
;     existing data in the cache corresponding to a URL load request, no
;     attempt is made to load the URL from the origin source, and the
;     load is considered to have failed. This constant specifies a
;     behavior that is similar to an "offline" mode.
; 

(defconstant $NSURLRequestUseProtocolCachePolicy 0)
(defconstant $NSURLRequestReloadIgnoringCacheData 1)
(defconstant $NSURLRequestReturnCacheDataElseLoad 2)
(defconstant $NSURLRequestReturnCacheDataDontLoad 3)
(def-mactype :NSURLRequestCachePolicy (find-mactype ':SINT32))
; !
;     @class NSURLRequest
;     
;     @abstract An NSURLRequest object represents a URL load request in a
;     manner independent of protocol and URL scheme.
;     
;     @discussion NSURLRequest encapsulates two basic data elements about
;     a URL load request:
;     <ul>
;     <li>The URL to load.
;     <li>The policy to use when consulting the URL content cache made
;     available by the implementation.
;     </ul>
;     In addition, NSURLRequest is designed to be extended to support
;     protocol-specific data by adding categories to access a property
;     object provided in an interface targeted at protocol implementors.
;     <ul>
;     <li>Protocol implementors should direct their attention to the
;     NSURLRequestExtensibility category on NSURLRequest for more
;     information on how to provide extensions on NSURLRequest to
;     support protocol-specific request information.
;     <li>Clients of this API who wish to create NSURLRequest objects to
;     load URL content should consult the protocol-specific NSURLRequest
;     categories that are available. The NSHTTPURLRequest category on
;     NSURLRequest is an example.
;     </ul>
;     <p>
;     Objects of this class are used to create NSURLConnection instances,
;     which can are used to perform the load of a URL, or as input to the
;     NSURLConnection class method which performs synchronous loads.
; 
#| @INTERFACE 
NSURLRequest : NSObject <NSCoding, NSCopying, NSMutableCopying>
{
    private
    NSURLRequestInternal *_internal;
}


+ (id)requestWithURL:(NSURL *)URL;


+ (id)requestWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval;


- (id)initWithURL:(NSURL *)URL;


- (id)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval;


- (NSURL *)URL;


- (NSURLRequestCachePolicy)cachePolicy;


- (NSTimeInterval)timeoutInterval;


- (NSURL *)mainDocumentURL;

|#
; ! 
;     @class NSMutableURLRequest
;     
;     @abstract An NSMutableURLRequest object represents a mutable URL load
;     request in a manner independent of protocol and URL scheme.
;     
;     @discussion This specialization of NSURLRequest is provided to aid
;     developers who may find it more convenient to mutate a single request
;     object for a series of URL loads instead of creating an immutable
;     NSURLRequest for each load. This programming model is supported by
;     the following contract stipulation between NSMutableURLRequest and 
;     NSURLConnection: NSURLConnection makes a deep copy of each 
;     NSMutableURLRequest object passed to one of its initializers.    
;     <p>NSMutableURLRequest is designed to be extended to support
;     protocol-specific data by adding categories to access a property
;     object provided in an interface targeted at protocol implementors.
;     <ul>
;     <li>Protocol implementors should direct their attention to the
;     NSMutableURLRequestExtensibility category on
;     NSMutableURLRequest for more information on how to provide
;     extensions on NSMutableURLRequest to support protocol-specific
;     request information.
;     <li>Clients of this API who wish to create NSMutableURLRequest
;     objects to load URL content should consult the protocol-specific
;     NSMutableURLRequest categories that are available. The
;     NSMutableHTTPURLRequest category on NSMutableURLRequest is an
;     example.
;     </ul>
; 
#| @INTERFACE 
NSMutableURLRequest : NSURLRequest


- (void)setURL:(NSURL *)URL;


- (void)setCachePolicy:(NSURLRequestCachePolicy)policy;


- (void)setTimeoutInterval:(NSTimeInterval)seconds;


- (void)setMainDocumentURL:(NSURL *)URL;

|#
; !
;     @category NSURLRequest(NSHTTPURLRequest) 
;     The NSHTTPURLRequest on NSURLRequest provides methods for accessing
;     information specific to HTTP protocol requests.
; 
#| @INTERFACE 
NSURLRequest (NSHTTPURLRequest) 


- (NSString *)HTTPMethod;


- (NSDictionary *)allHTTPHeaderFields;


- (NSString *)valueForHTTPHeaderField:(NSString *)field;


- (NSData *)HTTPBody;


- (BOOL)HTTPShouldHandleCookies;

|#
; !
;     @category NSMutableURLRequest(NSMutableHTTPURLRequest) 
;     The NSMutableHTTPURLRequest on NSMutableURLRequest provides methods
;     for configuring information specific to HTTP protocol requests.
; 
#| @INTERFACE 
NSMutableURLRequest (NSMutableHTTPURLRequest) 


- (void)setHTTPMethod:(NSString *)method;


- (void)setAllHTTPHeaderFields:(NSDictionary *)headerFields;


- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;


- (void)addValue:(NSString *)value forHTTPHeaderField:(NSString *)field;


- (void)setHTTPBody:(NSData *)data;


- (void)setHTTPShouldHandleCookies:(BOOL)should;

|#

; #endif


(provide-interface "NSURLRequest")