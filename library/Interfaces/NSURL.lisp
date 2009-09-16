(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSURL.h"
; at Sunday July 2,2006 7:31:03 pm.
; 	NSURL.h
; 	Copyright (c) 1997-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSURLHandle.h>

; #import <Foundation/NSString.h>
;  As more schemes are used and understood, strong constants for them will be added here
(def-mactype :NSURLFileScheme (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSURL: NSObject <NSCoding, NSCopying, NSURLHandleClient>
{
    NSString *_urlString;
    NSURL *_baseURL;
    void *_clients;
    void *_reserved;
}
        
- initWithScheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path;
- initFileURLWithPath:(NSString *)path;  + (id)fileURLWithPath:(NSString *)path;

- initWithString:(NSString *)URLString;
- initWithString:(NSString *)URLString relativeToURL:(NSURL *)baseURL; + (id)URLWithString:(NSString *)URLString;
+ (id)URLWithString:(NSString *)URLString relativeToURL:(NSURL *)baseURL;

- (NSString *)absoluteString;
- (NSString *)relativeString; - (NSURL *)baseURL; - (NSURL *)absoluteURL; 
- (NSString *)scheme;
- (NSString *)resourceSpecifier;


- (NSString *)host;
- (NSNumber *)port;
- (NSString *)user;
- (NSString *)password;
- (NSString *)path;
- (NSString *)fragment;
- (NSString *)parameterString;
- (NSString *)query;
- (NSString *)relativePath; 
- (BOOL)isFileURL; 
- (NSURL *)standardizedURL;
|#
#| @INTERFACE 
NSURL (NSURLLoading)
- (NSData *)resourceDataUsingCache:(BOOL)shouldUseCache; - (void)loadResourceDataNotifyingClient:(id)client usingCache:(BOOL)shouldUseCache; - (id)propertyForKey:(NSString *)propertyKey;

- (BOOL)setResourceData:(NSData *)data;
- (BOOL)setProperty:(id)property forKey:(NSString *)propertyKey;

- (NSURLHandle *)URLHandleUsingCache:(BOOL)shouldUseCache; 
|#
#| @INTERFACE 
NSObject(NSURLClient)
- (void)URL:(NSURL *)sender resourceDataDidBecomeAvailable:(NSData *)newBytes;
- (void)URLResourceDidFinishLoading:(NSURL *)sender;
- (void)URLResourceDidCancelLoading:(NSURL *)sender;
- (void)URL:(NSURL *)sender resourceDidFailLoadingWithReason:(NSString *)reason;
|#

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
#| @INTERFACE 
NSString (NSURLUtilities)


- (NSString *)stringByAddingPercentEscapesUsingEncoding:(NSStringEncoding)enc;


- (NSString *)stringByReplacingPercentEscapesUsingEncoding:(NSStringEncoding)enc;

|#

; #endif


(provide-interface "NSURL")