(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSURLHandle.h"
; at Sunday July 2,2006 7:31:04 pm.
; 	NSURLHandle.h
; 	Copyright (c) 1997-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
;  HTTP Specific Property Keys
(def-mactype :NSHTTPPropertyStatusCodeKey (find-mactype '(:pointer :NSString)))
(def-mactype :NSHTTPPropertyStatusReasonKey (find-mactype '(:pointer :NSString)))
(def-mactype :NSHTTPPropertyServerHTTPVersionKey (find-mactype '(:pointer :NSString)))
(def-mactype :NSHTTPPropertyRedirectionHeadersKey (find-mactype '(:pointer :NSString)))
(def-mactype :NSHTTPPropertyErrorPageDataKey (find-mactype '(:pointer :NSString)))

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
(def-mactype :NSHTTPPropertyHTTPProxy (find-mactype '(:pointer :NSString)))
;  NSDictionary containing proxy information to use in place of proxy identified in SystemConfiguration.framework
;  To avoid any proxy use, pass an empty dictionary

; #endif


; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  FTP Specific Property Keys
;  All keys are optional.  The default configuration allows an
;  anonymous, passive-mode, one-off transfer of the specified URL.
(def-mactype :NSFTPPropertyUserLoginKey (find-mactype '(:pointer :NSString)))
;  NSString - default "anonymous"
(def-mactype :NSFTPPropertyUserPasswordKey (find-mactype '(:pointer :NSString)))
;  NSString - default "NSURLHandle@apple.com"
(def-mactype :NSFTPPropertyActiveTransferModeKey (find-mactype '(:pointer :NSString)))
;  NSNumber BOOL - default NO (i.e. passive mode)
(def-mactype :NSFTPPropertyFileOffsetKey (find-mactype '(:pointer :NSString)))
;  NSNumber - default 0

; #endif


; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  NSDictionary containing proxy information to use in place of proxy identified in SystemConfiguration.framework
;  To avoid any proxy use, pass an empty dictionary
(def-mactype :NSFTPPropertyFTPProxy (find-mactype '(:pointer :NSString)))

; #endif


(defconstant $NSURLHandleNotLoaded 0)
(defconstant $NSURLHandleLoadSucceeded 1)
(defconstant $NSURLHandleLoadInProgress 2)
(defconstant $NSURLHandleLoadFailed 3)
(def-mactype :NSURLHandleStatus (find-mactype ':SINT32))
#| @PROTOCOL 
NSURLHandleClient
- (void)URLHandle:(NSURLHandle *)sender resourceDataDidBecomeAvailable:(NSData *)newBytes;
- (void)URLHandleResourceDidBeginLoading:(NSURLHandle *)sender;
- (void)URLHandleResourceDidFinishLoading:(NSURLHandle *)sender;
- (void)URLHandleResourceDidCancelLoading:(NSURLHandle *)sender;
- (void)URLHandle:(NSURLHandle *)sender resourceDidFailLoadingWithReason:(NSString *)reason;
|#
#| @INTERFACE 
NSURLHandle:NSObject
{
    NSMutableArray *_clients;
    id _data; 
    NSURLHandleStatus _status;
    int _reserved;
}

+ (void)registerURLHandleClass:(Class)anURLHandleSubclass; + (Class)URLHandleClassForURL:(NSURL *)anURL;

- (NSURLHandleStatus)status;
- (NSString *)failureReason; 
- (void)addClient:(id <NSURLHandleClient>)client;
- (void)removeClient:(id <NSURLHandleClient>)client;

- (void)loadInBackground;
- (void)cancelLoadInBackground;

- (NSData *)resourceData; - (NSData *)availableResourceData;  
#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (long long) expectedResourceDataSize;	#endif

- (void)flushCachedData;

- (void)backgroundLoadDidFailWithReason:(NSString *)reason; - (void)didLoadBytes:(NSData *)newBytes loadComplete:(BOOL)yorn;

+ (BOOL)canInitWithURL:(NSURL *)anURL;
+ (NSURLHandle *)cachedHandleForURL:(NSURL *)anURL;
- initWithURL:(NSURL *)anURL cached:(BOOL)willCache;

- (id)propertyForKey:(NSString *)propertyKey;  - (id)propertyForKeyIfAvailable:(NSString *)propertyKey;
- (BOOL)writeProperty:(id)propertyValue forKey:(NSString *)propertyKey;
- (BOOL)writeData:(NSData *)data; 
- (NSData *)loadInForeground;   - (void)beginLoadInBackground;  - (void)endLoadInBackground;    
|#

(provide-interface "NSURLHandle")