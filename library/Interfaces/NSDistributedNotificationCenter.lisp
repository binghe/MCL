(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSDistributedNotificationCenter.h"
; at Sunday July 2,2006 7:30:46 pm.
; 	NSDistributedNotificationCenter.h
; 	Copyright (c) 1996-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSNotification.h>
(def-mactype :NSLocalNotificationCenterType (find-mactype '(:pointer :NSString)))
;  Distributes notifications to all tasks on the sender's machine.

(defconstant $NSNotificationSuspensionBehaviorDrop 1);  The server will not queue any notifications with this name and object until setSuspended:NO is called.

(defconstant $NSNotificationSuspensionBehaviorCoalesce 2);  The server will only queue the last notification of the specified name and object; earlier notifications are dropped.  In cover methods for which suspension behavior is not an explicit argument, NSNotificationSuspensionBehaviorCoalesce is the default.

(defconstant $NSNotificationSuspensionBehaviorHold 3);  The server will hold all matching notifications until the queue has been filled (queue size determined by the server) at which point the server may flush queued notifications.

(defconstant $NSNotificationSuspensionBehaviorDeliverImmediately 4);  The server will deliver notifications matching this registration irrespective of whether setSuspended:YES has been called.  When a notification with this suspension behavior is matched, it has the effect of first flushing
;  any queued notifications.  The effect is somewhat as if setSuspended:NO were first called if the app is suspended, followed by
;  the notification in question being delivered, followed by a transition back to the previous suspended or unsuspended state.

(def-mactype :NSNotificationSuspensionBehavior (find-mactype ':SINT32))
#| @INTERFACE 
NSDistributedNotificationCenter : NSNotificationCenter

+ (NSDistributedNotificationCenter *)notificationCenterForType:(NSString *)notificationCenterType;

+ (id)defaultCenter;

- (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name object:(NSString *)object suspensionBehavior:(NSNotificationSuspensionBehavior)suspensionBehavior;

- (void)postNotificationName:(NSString *)name object:(NSString *)object userInfo:(NSDictionary *)userInfo deliverImmediately:(BOOL)deliverImmediately;

#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

enum {
    NSNotificationDeliverImmediately = (1 << 0),
    NSNotificationPostToAllSessions = (1 << 1)
};

- (void)postNotificationName:(NSString *)name object:(NSString *)object userInfo:(NSDictionary *)userInfo options:(unsigned)options;

#endif

- (void)setSuspended:(BOOL)suspended;
    
- (BOOL)suspended;

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(NSString *)anObject;

- (void)postNotificationName:(NSString *)aName object:(NSString *)anObject;
- (void)postNotificationName:(NSString *)aName object:(NSString *)anObject userInfo:(NSDictionary *)aUserInfo;
- (void)removeObserver:(id)observer name:(NSString *)aName object:(NSString *)anObject;

|#

(provide-interface "NSDistributedNotificationCenter")