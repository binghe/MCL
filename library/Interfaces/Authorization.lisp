(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Authorization.h"
; at Sunday July 2,2006 7:27:07 pm.
; 
;  * Copyright (c) 2000-2002 Apple Computer, Inc. All Rights Reserved.
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
;  *  Authorization.h -- APIs for implementing access control in applications
;  *  and daemons.
;  
; #ifndef _SECURITY_AUTHORIZATION_H_
; #define _SECURITY_AUTHORIZATION_H_

(require-interface "CoreServices/../Frameworks/CarbonCore.framework/Headers/MacTypes")

(require-interface "stdio")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
; !
; 	@header Authorization
; 	Version 1.0 10/16/2000
; 
; 	The Authorization API contains all the APIs that a application or tool that need pre-authorization or need an authorization desision made.
; 	
; 	A typical use cases are a preference panel that would start off calling AuthorizationCreate() (without UI) to get an authorization object.  Then call AuthorizationCopyRights() to figure out what is currently allowed.
; 	
; 	If any of the operations that the preference panel wishes to perform are currently not allowed the lock icon in the window would show up in the locked state.  Otherwise it would show up unlocked.
; 	
; 	When the user locks the lock AuthorizationFree() is called with the kAuthorizationFlagDestroyRights to destroy any authorization rights that have been aquired.
; 	
; 	When the user unlocks the lock AuthorizationCreate() is called with the kAuthorizationFlagInteractionAllowed and kAuthorizationFlagExtendRights flags to obtain all required rights.  The old authorization object can be freed by calling AuthorizationFree() with no flags.
; 
; 
; !
; 	@defined kAuthorizationEmptyEnvironment
; 	Parameter to specify to AuthorizationCreate when no environment is being provided.
; 
; #define kAuthorizationEmptyEnvironment	NULL
; !
; 	@enum AuthorizationStatus
; 	Error codes returned by Authorization API.
; 
; 
;     Note: the comments that appear after these errors are used to create SecErrorMessages.strings.
;     The comments must not be multi-line, and should be in a form meaningful to an end user. If
;     a different or additional comment is needed, it can be put in the header doc format, or on a
;     line that does not start with errZZZ.
; 

(defconstant $errAuthorizationSuccess 0)        ;  The operation completed successfully. 

(defconstant $errAuthorizationInvalidSet -60001);  The set parameter is invalid. 

(defconstant $errAuthorizationInvalidRef -60002);  The authorization parameter is invalid. 

(defconstant $errAuthorizationInvalidTag -60003);  The tag parameter is invalid. 

(defconstant $errAuthorizationInvalidPointer -60004);  The authorizedRights parameter is invalid. 

(defconstant $errAuthorizationDenied -60005)    ;  The authorization was denied. 

(defconstant $errAuthorizationCanceled -60006)  ;  The authorization was cancelled by the user. 

(defconstant $errAuthorizationInteractionNotAllowed -60007);  The authorization was denied since no user interaction was possible. 

(defconstant $errAuthorizationInternal -60008)  ;  something else went wrong 

(defconstant $errAuthorizationExternalizeNotAllowed -60009);  authorization externalization denied 

(defconstant $errAuthorizationInternalizeNotAllowed -60010);  authorization internalization denied 

(defconstant $errAuthorizationInvalidFlags -60011);  invalid option flag(s) 

(defconstant $errAuthorizationToolExecuteFailure -60031);  cannot execute privileged tool 

(defconstant $errAuthorizationToolEnvironmentError -60032);  privileged tool environment error 

(defconstant $errAuthorizationBadAddress -60033);  invalid socket address requested 
; !
; 	@enum AuthorizationFlags
; 	Optional flags passed in to serveral Authorization APIs. See the description of AuthorizationCreate, AuthorizationCopyRights and AuthorizationFree for a description of how they affect those calls.
; 

(defconstant $kAuthorizationFlagDefaults 0)
(defconstant $kAuthorizationFlagInteractionAllowed 1)
(defconstant $kAuthorizationFlagExtendRights 2)
(defconstant $kAuthorizationFlagPartialRights 4)
(defconstant $kAuthorizationFlagDestroyRights 8)
(defconstant $kAuthorizationFlagPreAuthorize 16);  private bits (do not use)

(defconstant $kAuthorizationFlagNoData #x100000)
; !
; 	@typedef AuthorizationFlags
; 	Optional flags passed in to AuthorizationCreate.
; 

(def-mactype :AuthorizationFlags (find-mactype ':UInt32))
; !
; 	@enum AuthorizationRightFlags
; 	Flags returned in the flags field of ItemSet Items when calling AuthorizationCopyRights().
; 

(defconstant $kAuthorizationFlagCanNotPreAuthorize 1)
; !
; 	@typedef AuthorizationRef
; 	Opaque reference to an authorization object.
; 

(def-mactype :AuthorizationRef (find-mactype '(:pointer :AuthorizationOpaqueRef)))
; !
; 	@typedef AuthorizationString
; 	A zero terminated string in UTF-8 encoding.
; 

(def-mactype :AuthorizationString (find-mactype '(:pointer :character)))
; !
; 	@struct AuthorizationItem
; 	Each AuthorizationItem describes a single string-named item with optional
; 	parameter value. The value must be contiguous memory of valueLength bytes;
; 	internal structure is defined separately for each name.
; 
; 	@field name name of the item, as an AuthorizationString. Mandatory.
; 	@field valueLength Number of bytes in parameter value. Must be 0 if no parameter value.
; 	@field value Pointer to the optional parameter value associated with name.
; 	Must be NULL if no parameter value.
; 	@field flags Reserved field. Must be set to 0 on creation. Do not modify after that.
; 
(defrecord AuthorizationItem
   (name (:pointer :character))
   (valueLength :UInt32)
   (value :pointer)
   (flags :UInt32)
)
; !
; 	@struct AuthorizationItemSet
; 	An AuthorizationItemSet structure represents a set of zero or more AuthorizationItems.  Since it is a set it should not contain any identical AuthorizationItems.
; 
; 	@field count Number of items identified by items.
; 	@field items Pointer to an array of items.
; 
(defrecord AuthorizationItemSet
   (count :UInt32)
   (items (:pointer :AUTHORIZATIONITEM))
)
; !
; 	@struct AuthorizationExternalForm
; 	An AuthorizationExternalForm structure can hold the externalized form of
; 	an AuthorizationRef. As such, it can be transmitted across IPC channels
; 	to other processes, which can re-internalize it to recover a valid AuthorizationRef
; 	handle.
; 	The data contained in an AuthorizationExternalForm should be considered opaque.
; 
; 	SECURITY NOTE: Applications should take care to not disclose the AuthorizationExternalForm to
; 	potential attackers since it would authorize rights to them.
; 

(defconstant $kAuthorizationExternalFormLength 32)
(defrecord AuthorizationExternalForm   (bytes (:array :character 32))
)
; !
; 	@typedef AuthorizationRights
; 	An AuthorizationItemSet representing a set of rights each with an associated argument (value).
; 	Each argument value is as defined for the specific right they belong to.  Argument values may not contain pointers as the should be copyable to different address spaces.
; 

(%define-record :AuthorizationRights (find-record-descriptor ':AuthorizationItemSet))
; !
; 	@typedef AuthorizationEnvironment
; 	An AuthorizationItemSet representing environmental information of potential use
; 	to authorization decisions.
; 

(%define-record :AuthorizationEnvironment (find-record-descriptor ':AuthorizationItemSet))
; !
;     @function AuthorizationCreate
;     Create a new autorization object which can be used in other authorization calls.  When the authorization is no longer needed AuthorizationFree should be called.
; 
; 	When the kAuthorizationFlagInteractionAllowed flag is set, user interaction will happen when required.  Failing to set this flag will result in this call failing with a errAuthorizationInteractionNotAllowed status when interaction is required.
; 
; 	Setting the kAuthorizationFlagExtendRights flag will extend the currently available rights. If this flag is set the returned AuthorizationRef will grant all the rights requested when errAuthorizationSuccess is returned. If this flag is not set the operation will almost certainly succeed, but no attempt will be made to make the requested rights availible.
; 		Call AuthorizationCopyRights to figure out which of the requested rights are granted by the returned AuthorizationRef.
; 
; 	Setting the kAuthorizationFlagPartialRights flag will cause this call to succeed if only some of the requested rights are being granted by the returned AuthorizationRef. Unless this flag is set this API will fail if not all the requested rights could be obtained.
; 
; 	Setting the kAuthorizationFlagDestroyRights flag will prevent any rights obtained during this call from being preserved after returning from this API (This is most useful when the authorization parameter is NULL and the caller doesn't want to affect the session state in any way).
; 
; 	Setting the kAuthorizationFlagPreAuthorize flag will pre authorize the requested rights so that at a later time -- by calling AuthorizationMakeExternalForm() follow by AuthorizationCreateFromExternalForm() -- the obtained rights can be used in a different process.  Rights that can't be preauthorized will be treated as if they were authorized for the sake of returning an error (in other words if all rights are either authorized or could not be preauthorized this call will still succeed).
; 		The rights which could not be preauthorized are not currently authorized and may fail to authorize when a later call to AuthorizationCopyRights() is made, unless the kAuthorizationFlagExtendRights and kAuthorizationFlagInteractionAllowed flags are set.  Even then they might still fail if the user does not supply the correct credentials.
; 		The reason for passing in this flag is to provide correct audit trail information and to avoid unnecessary user interaction.
; 
;     @param rights (input/optional) An AuthorizationItemSet containing rights for which authorization is being requested.  If none are specified the resulting AuthorizationRef will authorize nothing at all.
;     @param environment (input/optional) An AuthorizationItemSet containing enviroment state used when making the autorization decision.  See the AuthorizationEnvironment type for details.
;     @param flags (input) options specified by the AuthorizationFlags enum.  set all unused bits to zero to allow for future expansion.
;     @param authorization (output optional) A pointer to an AuthorizationRef to be returned.  When the returned AuthorizationRef is no longer needed AuthorizationFree should be called to prevent anyone from using the aquired rights.  If NULL is specified no new rights are returned, but the system will attempt to authorize all the requested rights and return the appropriate status.
; 
;     @result errAuthorizationSuccess 0 authorization or all requested rights succeeded.
; 
; 	errAuthorizationDenied -60005 The authorization for one or more of the requested rights was denied.
; 
; 	errAuthorizationCanceled -60006 The authorization was cancelled by the user.
; 
; 	errAuthorizationInteractionNotAllowed -60007 The authorization was denied since no interaction with the user was allowed.
; 

(deftrap-inline "_AuthorizationCreate" 
   ((rights (:pointer :AUTHORIZATIONRIGHTS))
    (environment (:pointer :AUTHORIZATIONENVIRONMENT))
    (flags :UInt32)
    (authorization (:pointer :AUTHORIZATIONREF))
   )
   :SInt32
() )
; !
;     @function AuthorizationFree
;     Destroy an AutorizationRef object. If the kAuthorizationFlagDestroyRights flag is passed,
; 	any rights associated with the authorization are lost. Otherwise, only local resources
; 	are released, and the rights may still be available to other clients.
; 
; 	Setting the kAuthorizationFlagDestroyRights flag will prevent any rights that were obtained by the specified authorization object to be preserved after returning from this API.  This effectivaly locks down all potentially shared authorizations.
; 
;     @param authorization (input) The authorization object on which this operation is performed.
; 	
; 	@param flags (input) Bit mask of option flags to this call.
; 
;     @result errAuthorizationSuccess 0 No error.
; 
;     errAuthorizationInvalidRef -60002 The authorization parameter is invalid.
; 

(deftrap-inline "_AuthorizationFree" 
   ((authorization (:pointer :AuthorizationOpaqueRef))
    (flags :UInt32)
   )
   :SInt32
() )
; !
; 	@function AuthorizationCopyRights
;     Given a set of rights, return the subset that is currently authorized
;     by the AuthorizationRef given.
; 
; 	When the kAuthorizationFlagInteractionAllowed flag is set, user interaction will happen when required.  Failing to set this flag will result in this call failing with a errAuthorizationInteractionNotAllowed status when interaction is required.
; 
; 	Setting the kAuthorizationFlagExtendRights flag will extend the currently available rights.
; 
; 	Setting the kAuthorizationFlagPartialRights flag will cause this call to succeed if only some of the requested rights are being granted by the returned AuthorizationRef.  Unless this flag is set this API will fail if not all the requested rights could be obtained.
; 
; 	Setting the kAuthorizationFlagDestroyRights flag will prevent any additional rights obtained during this call from being preserved after returning from this API.
; 
; 	Setting the kAuthorizationFlagPreAuthorize flag will pre authorize the requested rights so that at a later time -- by calling AuthorizationMakeExternalForm() follow by AuthorizationCreateFromExternalForm() -- the obtained rights can be used in a different process.  Rights that can't be preauthorized will be treated as if they were authorized for the sake of returning an error (in other words if all rights are either authorized or could not be preauthorized this call will still succeed), and they will be returned in authorizedRights with their kAuthorizationFlagCanNotPreAuthorize bit in the flags field set to 1.
; 		The rights which could not be preauthorized are not currently authorized and may fail to authorize when a later call to AuthorizationCopyRights() is made, unless the kAuthorizationFlagExtendRights and kAuthorizationFlagInteractionAllowed flags are set.  Even then they might still fail if the user does not supply the correct credentials.
; 		The reason for passing in this flag is to provide correct audit trail information and to avoid unnecessary user interaction.
; 
; 	Setting the kAuthorizationFlagPreAuthorize flag will pre authorize the requested rights so that at a later time -- by calling AuthorizationMakeExternalForm() follow by AuthorizationCreateFromExternalForm() -- the obtained rights can be used in a different process.  When this flags is specified rights that can't be preauthorized will be returned as if they were authorized with their kAuthorizationFlagCanNotPreAuthorize bit in the flags field set to 1.  These rights are not currently authorized and may fail to authorize later unless kAuthorizationFlagExtendRights and kAuthorizationFlagInteractionAllowed flags are set when the actual authorization is done.  And even then they might still fail if the user does not supply the correct credentials.
; 
;     @param authorization (input) The authorization object on which this operation is performed.
;     @param rights (input) A rights set (see AuthorizationCreate).
;     @param environment (input/optional) An AuthorizationItemSet containing enviroment state used when making the autorization decision.  See the AuthorizationEnvironment type for details.
;     @param flags (input) options specified by the AuthorizationFlags enum.  set all unused bits to zero to allow for future expansion.
;     @param authorizedRights (output/optional) A pointer to a newly allocated AuthorizationInfoSet in which the authorized subset of rights are returned (authorizedRights should be deallocated by calling AuthorizationFreeItemSet() when it is no longer needed).  If NULL the only information returned is the status.  Note that if the kAuthorizationFlagPreAuthorize flag was specified rights that could not be preauthorized are returned in authorizedRights, but their flags contains the kAuthorizationFlagCanNotPreAuthorize bit.
; 
;     @result errAuthorizationSuccess 0 No error.
; 
; 	errAuthorizationInvalidRef -60002 The authorization parameter is invalid.
; 
;     errAuthorizationInvalidSet -60001 The rights parameter is invalid.
; 
;     errAuthorizationInvalidPointer -60004 The authorizedRights parameter is invalid.
; 

(deftrap-inline "_AuthorizationCopyRights" 
   ((authorization (:pointer :AuthorizationOpaqueRef))
    (rights (:pointer :AUTHORIZATIONRIGHTS))
    (environment (:pointer :AUTHORIZATIONENVIRONMENT))
    (flags :UInt32)
    (authorizedRights (:pointer :AUTHORIZATIONRIGHTS))
   )
   :SInt32
() )
; !
; 	@function AuthorizationCopyInfo
; 	Returns sideband information (e.g. access credentials) obtained from a call to AuthorizationCreate.  The format of this data depends of the tag specified.
; 	
;     @param authorization (input) The authorization object on which this operation is performed.
;     @param tag (input/optional) An optional string tag specifing which sideband information should be returned.  When NULL is specified all available information is returned.
;     @param flags (input) options specified by the AuthorizationFlags enum.  set all unused bits to zero to allow for future expansion.
;     @param info (output) A pointer to a newly allocated AuthorizationInfoSet in which the requested sideband infomation is returned (info should be deallocated by calling AuthorizationFreeItemSet() when it is no longer needed).
; 
;     @result errAuthorizationSuccess 0 No error.
; 
;     errAuthorizationInvalidRef -60002 The authorization parameter is invalid.
; 
;     errAuthorizationInvalidTag -60003 The tag parameter is invalid.
; 
;     errAuthorizationInvalidPointer -60004 The info parameter is invalid.
; 

(deftrap-inline "_AuthorizationCopyInfo" 
   ((authorization (:pointer :AuthorizationOpaqueRef))
    (tag (:pointer :character))
    (info (:pointer :AuthorizationItemSet))
   )
   :SInt32
() )
; !
; 	@function AuthorizationMakeExternalForm
; 	Turn an Authorization into an external "byte blob" form so it can be
; 	transmitted to another process.
; 	Note that *storing* the external form somewhere will probably not do what
; 	you want, since authorizations are bounded by sessions, processes, and possibly
; 	time limits. This is for online transmission of authorizations.
; 	
; 	@param authorization The (valid) authorization reference to externalize
; 	@param extForm Pointer to an AuthorizationExternalForm variable to fill.
; 	
;         @result errAuthorizationSuccess 0 No error.
; 
;         errAuthorizationExternalizeNotAllowed -60009 Externalizing this authorization is not allowed.
; 
;         errAuthorizationInvalidRef -60002 The authorization parameter is invalid.
; 
; 
; 

(deftrap-inline "_AuthorizationMakeExternalForm" 
   ((authorization (:pointer :AuthorizationOpaqueRef))
    (extForm (:pointer :AUTHORIZATIONEXTERNALFORM))
   )
   :SInt32
() )
; !
; 	@function AuthorizationCreateFromExternalForm
; 	Turn an Authorization into an external "byte blob" form so it can be
; 	transmitted to another process.
; 	Note that *storing* the external form somewhere will probably not do what
; 	you want, since authorizations are bounded by sessions, processes, and possibly
; 	time limits. This is for online transmission of authorizations.
; 	
; 	@param extForm Pointer to an AuthorizationExternalForm value.
; 	@param authorization Will be filled with a valid AuthorizationRef on success.
; 	
; 	@result errAuthorizationInternalizeNotAllowed -60010 Internalizing this authorization is not allowed.
; 

(deftrap-inline "_AuthorizationCreateFromExternalForm" 
   ((extForm (:pointer :AUTHORIZATIONEXTERNALFORM))
    (authorization (:pointer :AUTHORIZATIONREF))
   )
   :SInt32
() )
; !
; 	@function AuthorizationFreeItemSet
; 	Release the memory allocated for an AuthorizationItemSet that was allocated
; 	by an API call.
; 	
;     @param set The AuthorizationItemSet to deallocate.
; 
;     @result errAuthorizationSuccess 0 No error.
; 
;     errAuthorizationInvalidSet -60001 The set parameter is invalid.
; 

(deftrap-inline "_AuthorizationFreeItemSet" 
   ((set (:pointer :AuthorizationItemSet))
   )
   :SInt32
() )
; !
; 	@function AuthorizationExecuteWithPrivileges
; 	Run an executable tool with enhanced privileges after passing
; 	suitable authorization procedures.
; 	
; 	@param authorization An authorization reference that is used to authorize
; 	access to the enhanced privileges. It is also passed to the tool for
; 	further access control.
; 	@param pathToTool Full pathname to the tool that should be executed
; 	with enhanced privileges.
; 	@param options Option bits (reserved). Must be zero.
; 	@param arguments An argv-style vector of strings to be passed to the tool.
; 	@param communicationsPipe Assigned a UNIX stdio FILE pointer for
; 	a bidirectional pipe to communicate with the tool. The tool will have
; 	this pipe as its standard I/O channels (stdin/stdout). If NULL, do not
; 	establish a communications pipe.
;  

(deftrap-inline "_AuthorizationExecuteWithPrivileges" 
   ((authorization (:pointer :AuthorizationOpaqueRef))
    (pathToTool (:pointer :char))
    (options :UInt32)
    (arguments (:pointer :char))
    (communicationsPipe (:pointer :file))
   )
   :SInt32
() )
; !
; 	@function AuthorizationCopyPrivilegedReference
; 	From within a tool launched via the AuthorizationExecuteWithPrivileges function
; 	ONLY, retrieve the AuthorizationRef originally passed to that function.
; 	While AuthorizationExecuteWithPrivileges already verified the authorization to
; 	launch your tool, the tool may want to avail itself of any additional pre-authorizations
; 	the caller may have obtained through that reference.
;  

(deftrap-inline "_AuthorizationCopyPrivilegedReference" 
   ((authorization (:pointer :AUTHORIZATIONREF))
    (flags :UInt32)
   )
   :SInt32
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* !_SECURITY_AUTHORIZATION_H_ */


(provide-interface "Authorization")