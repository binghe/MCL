(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSURLAuthenticationChallenge.h"
; at Sunday July 2,2006 7:31:03 pm.
; 	
;     NSURLAuthenticationChallenge.h
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
;     @protocol NSURLAuthenticationChallengeSender 
;     @discussion This protocol represents the sender of an
;     authentication challenge. It has methods to provide a credential,
;     to continue without any credential, getting whatever failure
;     result would happen in that case, or to cancel.
; 
#| @PROTOCOL 
NSURLAuthenticationChallengeSender <NSObject>


- (void)useCredential:(NSURLCredential *)credential forAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;


- (void)continueWithoutCredentialForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;


- (void)cancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;

|#
; !
;     @class NSURLAuthenticationChallenge
;     @discussion This class represents an authentication challenge. It
;     provides all the information about the challenge, and has a method
;     to indicate when it's done.
; 
#| @INTERFACE 
NSURLAuthenticationChallenge : NSObject
{
private
    NSURLAuthenticationChallengeInternal *_internal;
}


- (id)initWithProtectionSpace:(NSURLProtectionSpace *)space proposedCredential:(NSURLCredential *)credential previousFailureCount:(int)previousFailureCount failureResponse:(NSURLResponse *)response error:(NSError *)error sender:(id<NSURLAuthenticationChallengeSender>)sender;


- (id)initWithAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge sender:(id<NSURLAuthenticationChallengeSender>)sender;


- (NSURLProtectionSpace *)protectionSpace;


- (NSURLCredential *)proposedCredential;


- (int)previousFailureCount;


- (NSURLResponse *)failureResponse;


- (NSError *)error;


- (id<NSURLAuthenticationChallengeSender>)sender;

|#

; #endif


(provide-interface "NSURLAuthenticationChallenge")