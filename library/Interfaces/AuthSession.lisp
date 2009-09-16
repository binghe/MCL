(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AuthSession.h"
; at Sunday July 2,2006 7:27:07 pm.
; 
;  * Copyright (c) 2000-2003 Apple Computer, Inc. All Rights Reserved.
;  * 
;  * The contents of this file constitute Original Code as defined in and are
;  * subject to the Apple Public Source License Version 1.2 (the 'License').
;  * You may not use this file except in compliance with the License. Please obtain
;  * a copy of the License at http://www.apple.com/publicsource and read it before
;  * using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS
;  * OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES, INCLUDING WITHOUT
;  * LIMITATION, ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
;  * PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT. Please see the License for the
;  * specific language governing rights and limitations under the License.
;  
; 
;  *  AuthSession.h
;  *  AuthSession - APIs for managing login, authorization, and security Sessions.
;  

; #if !defined(__AuthSession__)
(defconstant $__AuthSession__ 1)
; #define __AuthSession__ 1

(require-interface "Security/Authorization")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
; !
; 	@header AuthSession
; 
; 	The Session API provides specialized applications access to Session management and inquiry
;     functions. This is a specialized API that should not be of interest to most people.
; 	
; 	The Security subsystem separates all processes into Security "sessions". Each process is in
; 	exactly one session, and session membership inherits across fork/exec. Sessions form boundaries
; 	for security-related state such as authorizations, keychain lock status, and the like.
; 	Typically, each successful login (whether graphical or through ssh & friends) creates
; 	a separate session. System daemons (started at system startup) belong to the "root session"
; 	which has no user nor graphics access.
;     
; 	Sessions are identified with SecuritySessionIds. A session has a set of attributes
; 	that are set on creation and can be retrieved with SessionGetInfo().
; 	
; 	There are similar session concepts in the system, related but not necessarily
; 	completely congruous. In particular, graphics sessions track security sessions
; 	(but only for graphic logins).
; 
; !
; 	@typedef SecuritySessionId
; 	These are externally visible identifiers for authorization sessions.
;         Different sessions have different identifiers; beyond that, you can't
;         tell anything from these values.
;     SessionIds can be compared for equality as you'd expect, but you should be careful
;         to use attribute bits wherever appropriate.
; 

(def-mactype :SecuritySessionId (find-mactype ':UInt32))
; !
;     @enum SecuritySessionId
;     Here are some special values for SecuritySessionId. You may specify those
;         on input to SessionAPI functions. They will never be returned from such
;         functions.
; 

(defconstant $noSecuritySession 0)              ;  definitely not a valid SecuritySessionId 
;  the Session I (the caller) am in 

(defconstant $callerSecuritySession (- $SECURITYSESSIONID 1))
; !
;     @enum SessionAttributeBits
;     Each Session has a set of attribute bits. You can get those from the
;         SessionGetInfo API function.
;  

(def-mactype :SessionAttributeBits (find-mactype ':UInt32))

(defconstant $sessionIsRoot 1)                  ;  is the root session (startup/system programs) 

(defconstant $sessionHasGraphicAccess 16)       ;  graphic subsystem (CoreGraphics et al) available 

(defconstant $sessionHasTTY 32)                 ;  /dev/tty is available 

(defconstant $sessionIsRemote #x1000)           ;  session was established over the network 
;  the following bits are used internally; do not try to set them

(defconstant $sessionWasInitialized #x8000)     ;  session has been set up by its leader 

; !
;     @enum SessionCreationFlags
;     These flags control how a new session is created by SessionCreate.
;         They have no permanent meaning beyond that.
;  

(def-mactype :SessionCreationFlags (find-mactype ':UInt32))

(defconstant $sessionKeepCurrentBootstrap #x8000);  caller has allocated sub-bootstrap (expert use only) 

; !
; 	@enum SessionStatus
; 	Error codes returned by AuthSession API.
;     Note that the AuthSession APIs can also return Authorization API error codes.
; 

(defconstant $errSessionSuccess 0)              ;  all is well 

(defconstant $errSessionInvalidId -60500)       ;  invalid session id specified 

(defconstant $errSessionInvalidAttributes -60501);  invalid set of requested attribute bits 

(defconstant $errSessionAuthorizationDenied -60502);  you are not allowed to do this 

(defconstant $errSessionInternal -60008)        ;  internal error 

(defconstant $errSessionInvalidFlags -60011)    ;  invalid flags/options 

; !
;     @function SessionGetInfo
;     Obtain information about a session. You can ask about any session whose
; 	identifier you know. Use the callerSecuritySession constant to ask about
; 	your own session (the one your process is in).
; 
;     @param session (input) The Session you are asking about. Can be one of the
;         special constants defined above.
; 	
; 	@param sessionId (output/optional) The actual SecuritySessionId for the session you asked about.
;         Will never be one of those constants.
;         
;     @param attributes (output/optional) Receives the attribute bits for the session.
; 
;     @result An OSStatus indicating success (noErr) or an error cause.
;     
;     errSessionInvalidId -60500 Invalid session id specified
; 
; 

(deftrap-inline "_SessionGetInfo" 
   ((session :UInt32)
    (sessionId (:pointer :SECURITYSESSIONID))
    (attributes (:pointer :SESSIONATTRIBUTEBITS))
   )
   :SInt32
() )
; !
;     @function SessionCreate
;     This (very specialized) function creates a security session.
; 	Upon completion, the new session contains the calling process (and none other).
; 	You cannot create a session for someone else, and cannot avoid being placed
; 	into the new session. This is (currently) the only call that changes a process's
; 	session membership.
;     By default, a new bootstrap subset port is created for the calling process. The process
;     acquires this new port as its bootstrap port, which all its children will inherit.
;     If you happen to have created the subset port on your own, you can pass the
;     sessionKeepCurrentBootstrap flag, and SessionCreate will use it. Note however that
;     you cannot supersede a prior SessionCreate call that way; only a single SessionCreate
;     call is allowed for each Session (however made).
; 	This call will discard any security information established for the calling process.
; 	In particular, any authorization handles acquired will become invalid, and so will any
; 	keychain related information. We recommend that you call SessionCreate before
; 	making any other security-related calls that establish rights of any kind, to the
; 	extent this is practical. Also, we strongly recommend that you do not perform
; 	security-related calls in any other threads while calling SessionCreate.
;     
;     @param flags Flags controlling how the session is created.
;     
;     @param attributes The set of attribute bits to set for the new session.
;         Not all bits can be set this way.
;     
;     @result An OSStatus indicating success (noErr) or an error cause.
;     
;     errSessionInvalidAttributes -60501 Attempt to set invalid attribute bits	
;     errSessionAuthorizationDenied -60502 Attempt to re-initialize a session
;     errSessionInvalidFlags -60011 Attempt to specify unsupported flag bits
;     
; 

(deftrap-inline "_SessionCreate" 
   ((flags :UInt32)
    (attributes :UInt32)
   )
   :SInt32
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __AuthSession__ */


(provide-interface "AuthSession")