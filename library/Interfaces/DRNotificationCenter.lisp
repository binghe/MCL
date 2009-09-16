(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRNotificationCenter.h"
; at Sunday July 2,2006 7:27:43 pm.
; 
;      File:       DiscRecordingEngine/DRNotificationCenter.h
;  
;      Contains:   Interface for registering to receive notifications from 
; 				 DiscRecording. 
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 

; #import <Foundation/Foundation.h>

; #import <DiscRecordingEngine/DRCoreNotifications.h>
; !
; 	@class 		DRNotificationCenter
; 	@discussion	A DRNotificationCenter object (or simply, notification center) is
; 				essentially a notification dispatch table. It notifies all observers of
; 				notifications meeting specific criteria. This information is encapsulated in
; 				NSNotification objects, also known as notifications. Client objects register
; 				themselves with the notification center as observers of specific notifications
; 				posted by DiscRecording. When an event occurs, DiscRecording posts an appropriate
; 				notification to the notification center. The notification center dispatches a
; 				message to each registered observer, passing the notification as the sole
; 				argument.
; 				
; 				There are two main differences between a DRNotificationCenter and the
; 				NSNotificationCenter from Foundation. First is that only DiscRecording
; 				posts notifications received through this mechanism. You use this to 
; 				obtain device plug/unplug events, burn status, etc. Second, there can be
; 				multple notification centers active at once. Each run loop of your application
; 				will have it's own notification center and notifications from that notification
; 				center will be posted to the runloop it was created on.
; 
#| @INTERFACE 
DRNotificationCenter : NSObject 
{ 
private
	void*	_ref;
}


+ (DRNotificationCenter*) currentRunLoopCenter;


- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)notificationName object:(id)anObject;


- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject;

|#

(provide-interface "DRNotificationCenter")