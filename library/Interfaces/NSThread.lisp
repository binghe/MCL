(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSThread.h"
; at Sunday July 2,2006 7:31:03 pm.
; 	NSThread.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSThread : NSObject  {
private
    unsigned		seqNum;
    unsigned		state;
    NSMutableDictionary	*threadDictionary;
    id			runLoop;
    void		*excHandlers;
    void		*autoreleasePool;
    id			doQueue;
    id			doConversation;
    unsigned		doConversationCount;
    id			doConversationRequest;
    void		*params;
    void		*reserved;
}

+ (NSThread *)currentThread;

+ (void)detachNewThreadSelector:(SEL)selector toTarget:(id)target withObject:(id)argument;

+ (BOOL)isMultiThreaded;

- (NSMutableDictionary *)threadDictionary;

+ (void)sleepUntilDate:(NSDate *)date;

+ (void)exit;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
+ (double)threadPriority;
+ (BOOL)setThreadPriority:(double)priority;
#endif

|#
(def-mactype :NSWillBecomeMultiThreadedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSDidBecomeSingleThreadedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSThreadWillExitNotification (find-mactype '(:pointer :NSString)))

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
#| @INTERFACE 
NSObject (NSMainThreadPerformAdditions)

- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait modes:(NSArray *)array;
- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait;
	
|#

; #endif


(provide-interface "NSThread")