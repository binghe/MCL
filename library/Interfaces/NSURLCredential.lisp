(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSURLCredential.h"
; at Sunday July 2,2006 7:31:04 pm.
; 	
;     NSURLCredential.h
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
;     @enum NSURLCredentialPersistence
;     @abstract Constants defining how long a credential will be kept around
;     @constant NSURLCredentialPersistenceNone This credential won't be saved.
;     @constant NSURLCredentialPersistenceForSession This credential will only be stored for this session.
;     @constant NSURLCredentialPersistencePermanent This credential will be stored permanently and shared with other applications.
; 

(defconstant $NSURLCredentialPersistenceNone 0)
(defconstant $NSURLCredentialPersistenceForSession 1)
(defconstant $NSURLCredentialPersistencePermanent 2)
(def-mactype :NSURLCredentialPersistence (find-mactype ':SINT32))
; !
;     @class NSURLCredential
;     @discussion This class is an immutable object representing an
;     authentication credential - a user and a password.
; 
#| @INTERFACE 
NSURLCredential : NSObject <NSCopying>
{
    private
    NSURLCredentialInternal *_internal;
}


- (id)initWithUser:(NSString *)user password:(NSString *)password persistence:(NSURLCredentialPersistence)persistence;


+ (NSURLCredential *)credentialWithUser:(NSString *)user password:(NSString *)password persistence:(NSURLCredentialPersistence)persistence;


- (NSString *)user;


- (NSString *)password;


- (BOOL)hasPassword;


- (NSURLCredentialPersistence)persistence;

|#

; #endif


(provide-interface "NSURLCredential")