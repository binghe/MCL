(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SFAuthorizationView.h"
; at Sunday July 2,2006 7:31:55 pm.
; 
; 	SFAuthorizationView.h
; 	SecurityInterface
;     Copyright (c) 2000-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
; #ifndef _SFAUTHORIZATIONVIEW_H_
; #define _SFAUTHORIZATIONVIEW_H_

; #import <Cocoa/Cocoa.h>

; #import <SecurityFoundation/SFAuthorization.h>
; !
; 	@typedef SFAuthorizationViewState
; 	@abstract Defines the current state of the authorization view.
; 	@constant SFAuthorizationStartupState Indicates the state is starting up.
; 	@constant SFAuthorizationViewLockedState Indicates the state is locked.
; 	@constant SFAuthorizationViewInProgressState Indicates the state is 'in progress'.
; 	@constant SFAuthorizationViewUnlockedState Indicates the state is unlocked.
; 

(defconstant $SFAuthorizationStartupState 0)
(defconstant $SFAuthorizationViewLockedState 1)
(defconstant $SFAuthorizationViewInProgressState 2)
(defconstant $SFAuthorizationViewUnlockedState 3)
(def-mactype :SFAuthorizationViewState (find-mactype ':SINT32))
; !
;     @class SFAuthorizationView
;     @abstract SFAuthorizationView is a custom view that you can use to visually represent restricted functionality, requiring authorization for access.
;     @discussion  You can add SFAuthorizationView to your application as a custom view, make your controller the delegate for the view and initialize the view by setting a right string (setString:) or rights structure (setAuthorizationRights:) to check for, as well as auto-updates (setAutoupdate:) or manual updates (updateStatus:). Note that you'll have to call updateStatus: to set the lock icon to its initial state. Changes to the current state as well as the startup state (after the initial updateStatus) are communicated to the delegate.  Implementing any of the following is optional):
;     <ul>
;       <li>authorized: changed to unlocked
;       <li>deauthorized: changed to locked
;       <li>shouldDeauthorize: when a user wants to lock, the delegates can react to this before it happens and avoid it by returning NO.
;       <li>cancelAuthorization: the user cancelled authorization.
;     </ul> 
; Calls to updateStatus: return YES if in the unlocked state, NO otherwise. Note that when committing changes or performing actions, authorization has to be checked again before going ahead with it. The default behavior of this view is to pre-authorize rights, if this is not possible it will unlock and wait for authorization to be checked when explicitly required. For handing the SFAuthorization (authorization:) to another process it's NSCoder support can be used.
; 
#| @INTERFACE 
SFAuthorizationView : NSView
{
protected
	SFAnimatedLockButton *_button;
    NSButton *_textButton;
	AuthorizationRights *_authorizationRights;
	SFAuthorization *_authorization;
	id _delegate;
	int	_currentState;
    BOOL _authorized;
    NSTimeInterval _timeInterval;
    AuthorizationFlags _flags;
	void *_privateData;
}


- (void)setString:(AuthorizationString)authorizationString;


- (void)setAuthorizationRights:(const AuthorizationRights *)authorizationRights;


- (AuthorizationRights *)authorizationRights;


- (SFAuthorization *)authorization;


- (BOOL)updateStatus:(id)inSender;


- (void)setAutoupdate:(BOOL)autoupdate;


- (void)setAutoupdate:(BOOL)autoupdate interval:(NSTimeInterval)interval;


- (SFAuthorizationViewState)authorizationState;


- (void)setEnabled:(BOOL)enabled;


- (BOOL)isEnabled;


- (void)setFlags:(AuthorizationFlags)flags;


- (void)setDelegate:(id)delegate;


- (id)delegate;


- (BOOL)authorize:(id)inSender;


- (BOOL)deauthorize:(id)inSender;

|#
; !
;     @category NSObject(SFAuthorizationViewDelegate)
;     @abstract Optionally implement these delegate methods to obtain the state of the authorization object.
; 
#| @INTERFACE 
NSObject (SFAuthorizationViewDelegate)


- (void)authorizationViewDidAuthorize:(SFAuthorizationView *)view;


- (void)authorizationViewDidDeauthorize:(SFAuthorizationView *)view;


- (BOOL)authorizationViewShouldDeauthorize:(SFAuthorizationView *)view;


- (void)authorizationViewCreatedAuthorization:(SFAuthorizationView *)view;


- (void)authorizationViewReleasedAuthorization:(SFAuthorizationView *)view;
|#

; #endif /* !_SFAUTHORIZATIONVIEW_H_ */


(provide-interface "SFAuthorizationView")