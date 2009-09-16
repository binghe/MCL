(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSURLCache.h"
; at Sunday July 2,2006 7:31:03 pm.
; 	
;     NSURLCache.h
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
;     @enum NSURLCacheStoragePolicy
;     
;     @discussion The NSURLCacheStoragePolicy enum defines constants that
;     can be used to specify the type of storage that is allowable for an
;     NSCachedURLResponse object that is to be stored in an NSURLCache.
;     
;     @constant NSURLCacheStorageAllowed Specifies that storage in an
;     NSURLCache is allowed without restriction.
; 
;     @constant NSURLCacheStorageAllowedInMemoryOnly Specifies that
;     storage in an NSURLCache is allowed; however storage should be
;     done in memory only, no disk storage should be done.
; 
;     @constant NSURLCacheStorageNotAllowed Specifies that storage in an
;     NSURLCache is not allowed in any fashion, either in memory or on
;     disk.
; 

(defconstant $NSURLCacheStorageAllowed 0)
(defconstant $NSURLCacheStorageAllowedInMemoryOnly 1)
(defconstant $NSURLCacheStorageNotAllowed 2)
(def-mactype :NSURLCacheStoragePolicy (find-mactype ':SINT32))
; !
;     @class NSCachedURLResponse
;     NSCachedURLResponse is a class whose objects functions as a wrapper for
;     objects that are stored in the framework's caching system. 
;     It is used to maintain characteristics and attributes of a cached 
;     object. 
; 
#| @INTERFACE 
NSCachedURLResponse : NSObject <NSCoding, NSCopying>
{
    NSCachedURLResponseInternal *_internal;
}


- (id)initWithResponse:(NSURLResponse *)response data:(NSData *)data;


- (id)initWithResponse:(NSURLResponse *)response data:(NSData *)data userInfo:(NSDictionary *)userInfo storagePolicy:(NSURLCacheStoragePolicy)storagePolicy;


- (NSURLResponse *)response;


- (NSData *)data;


- (NSDictionary *)userInfo;


- (NSURLCacheStoragePolicy)storagePolicy;

|#
#| @INTERFACE 
NSURLCache : NSObject
{
    private
    NSURLCacheInternal *_internal;
}


+ (NSURLCache *)sharedURLCache;


+ (void)setSharedURLCache:(NSURLCache *)cache;


- (id)initWithMemoryCapacity:(unsigned)memoryCapacity diskCapacity:(unsigned)diskCapacity diskPath:(NSString *)path;


- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request;


- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request;


- (void)removeCachedResponseForRequest:(NSURLRequest *)request;


- (void)removeAllCachedResponses;


- (unsigned)memoryCapacity;


- (unsigned)diskCapacity;


- (void)setMemoryCapacity:(unsigned)memoryCapacity;


- (void)setDiskCapacity:(unsigned)diskCapacity;


- (unsigned)currentMemoryUsage;


- (unsigned)currentDiskUsage;

|#

; #endif


(provide-interface "NSURLCache")