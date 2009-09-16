(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSNotificationQueue.h"
; at Sunday July 2,2006 7:30:53 pm.
; 	NSNotificationQueue.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

(defconstant $NSPostWhenIdle 1)
(defconstant $NSPostASAP 2)
(defconstant $NSPostNow 3)
(def-mactype :NSPostingStyle (find-mactype ':SINT32))

(defconstant $NSNotificationNoCoalescing 0)
(defconstant $NSNotificationCoalescingOnName 1)
(defconstant $NSNotificationCoalescingOnSender 2)
(def-mactype :NSNotificationCoalescing (find-mactype ':SINT32))
#| @INTERFACE 
NSNotificationQueue : NSObject {
private
    id		_notificationCenter;
    void	*_asapQueue;
    void	*_asapObs;
    void	*_idleQueue;
    void	*_idleObs;
}

+ (NSNotificationQueue *)defaultQueue;

- (id)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter;

- (void)enqueueNotification:(NSNotification *)notification postingStyle:(NSPostingStyle)postingStyle;
- (void)enqueueNotification:(NSNotification *)notification postingStyle:(NSPostingStyle)postingStyle coalesceMask:(unsigned)coalesceMask forModes:(NSArray *)modes;

- (void)dequeueNotificationsMatching:(NSNotification *)notification coalesceMask:(unsigned)coalesceMask;

|#

(provide-interface "NSNotificationQueue")