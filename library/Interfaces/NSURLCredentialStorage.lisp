(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSURLCredentialStorage.h"
; at Sunday July 2,2006 7:31:04 pm.
; 	
;     NSURLCredentialStorage.h
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
;     @class NSURLCredentialStorage
;     @discussion NSURLCredentialStorage implements a singleton
;     object (shared instance) which manages the shared credentials
;     cache.
; 
#| @INTERFACE 
NSURLCredentialStorage : NSObject
{
    private
    NSURLCredentialStorageInternal *_internal;
}


+ (NSURLCredentialStorage *)sharedCredentialStorage;


- (NSDictionary *)credentialsForProtectionSpace:(NSURLProtectionSpace *)space;


- (NSDictionary *)allCredentials;


- (void)setCredential:(NSURLCredential *)credential forProtectionSpace:(NSURLProtectionSpace *)space;


- (void)removeCredential:(NSURLCredential *)credential forProtectionSpace:(NSURLProtectionSpace *)space;


- (NSURLCredential *)defaultCredentialForProtectionSpace:(NSURLProtectionSpace *)space;


- (void)setDefaultCredential:(NSURLCredential *)credential forProtectionSpace:(NSURLProtectionSpace *)space;

|#
; !
;     @const NSURLCredentialStorageChangedNotification
;     @abstract This notification is sent on the main thread whenever
;     the set of stored credentials changes.
; 
(def-mactype :NSURLCredentialStorageChangedNotification (find-mactype '(:pointer :NSString)))

; #endif


(provide-interface "NSURLCredentialStorage")