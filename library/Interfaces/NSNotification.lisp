(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSNotification.h"
; at Sunday July 2,2006 7:30:53 pm.
; 	NSNotification.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
; ***************	Notifications	***************
#| @INTERFACE 
NSNotification : NSObject <NSCopying, NSCoding>

- (NSString *)name;
- (id)object;
- (NSDictionary *)userInfo;

|#
#| @INTERFACE 
NSNotification (NSNotificationCreation)

+ (id)notificationWithName:(NSString *)aName object:(id)anObject;
+ (id)notificationWithName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

|#
; ***************	Notification Center	***************
#| @INTERFACE 
NSNotificationCenter : NSObject {
    protected
    void *_impl;
    void *_pad[12];  }

+ (id)defaultCenter;
    
- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

- (void)postNotification:(NSNotification *)notification;
- (void)postNotificationName:(NSString *)aName object:(id)anObject;
- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject;

|#

(provide-interface "NSNotification")