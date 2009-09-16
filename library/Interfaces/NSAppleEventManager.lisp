(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSAppleEventManager.h"
; at Sunday July 2,2006 7:30:35 pm.
; 
; 	NSAppleEventManager.h
; 	Copyright (c) 1997-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <ApplicationServices/ApplicationServices.h>

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

(def-mactype :NSAppleEventManagerSuspensionID (find-mactype '(:pointer :__NSAppleEventManagerSuspension)))

; #endif

(def-mactype :NSAppleEventTimeOutDefault (find-mactype ':double))
(def-mactype :NSAppleEventTimeOutNone (find-mactype ':double))
(def-mactype :NSAppleEventManagerWillProcessFirstEventNotification (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSAppleEventManager : NSObject {
    private
    BOOL _isPreparedForDispatch;
    char _padding[3];
}

+ (NSAppleEventManager *)sharedAppleEventManager;

- (void)setEventHandler:(id)handler andSelector:(SEL)handleEventSelector forEventClass:(AEEventClass)eventClass andEventID:(AEEventID)eventID;
- (void)removeEventHandlerForEventClass:(AEEventClass)eventClass andEventID:(AEEventID)eventID;

- (OSErr)dispatchRawAppleEvent:(const AppleEvent *)theAppleEvent withRawReply:(AppleEvent *)theReply handlerRefCon:(UInt32)handlerRefCon;

#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (NSAppleEventDescriptor *)currentAppleEvent;

- (NSAppleEventDescriptor *)currentReplyAppleEvent;

- (NSAppleEventManagerSuspensionID)suspendCurrentAppleEvent;

- (NSAppleEventDescriptor *)appleEventForSuspensionID:(NSAppleEventManagerSuspensionID)suspensionID;

- (NSAppleEventDescriptor *)replyAppleEventForSuspensionID:(NSAppleEventManagerSuspensionID)suspensionID;

- (void)setCurrentAppleEventAndReplyEventWithSuspensionID:(NSAppleEventManagerSuspensionID)suspensionID;

- (void)resumeWithSuspensionID:(NSAppleEventManagerSuspensionID)suspensionID;

#endif

|#

(provide-interface "NSAppleEventManager")