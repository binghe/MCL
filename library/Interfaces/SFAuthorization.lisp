(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SFAuthorization.h"
; at Sunday July 2,2006 7:31:55 pm.
; 
; 	SFAuthorization.h
; 	SecurityFoundation
; 	Copyright (c) 2000-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
; #ifndef _SFAUTHORIZATION_H_
; #define _SFAUTHORIZATION_H_

; #import <Foundation/Foundation.h>

; #import <Security/Authorization.h>
; !
; 	@class SFAuthorization 
;     @abstract SFAuthorization APIs are used for implementing access control in applications and daemons. It has NSCoder support for proxied objects SFAuthorization is a wrapper for using the Authorization API.
; 
#| @INTERFACE 
SFAuthorization : NSObject <NSCoding>
{
private
	AuthorizationRef _authorization;
    void *_reserved;
}


+ (id)authorization;


- (AuthorizationRef)authorizationRef;


+ (id)authorizationWithFlags:(AuthorizationFlags)flags rights:(const AuthorizationRights *)rights environment:(const AuthorizationEnvironment *)environment;


- (id)initWithFlags:(AuthorizationFlags)flags rights:(const AuthorizationRights *)rights environment:(const AuthorizationEnvironment *)environment;


- (void)invalidateCredentials;


- (OSStatus)permitWithRights:(const AuthorizationRights *)rights flags:(AuthorizationFlags)flags environment:(const AuthorizationEnvironment *)environment authorizedRights:(AuthorizationRights *)authorizedRights;


- (OSStatus)permitWithRight:(AuthorizationString)rightName flags:(AuthorizationFlags)flags;

|#

; #endif /* !_SFAUTHORIZATION_H_ */


(provide-interface "SFAuthorization")