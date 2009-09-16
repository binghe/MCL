(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPort.h"
; at Sunday July 2,2006 7:30:56 pm.
; 	NSPort.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #if defined(__WIN32__)
#| 
(require-interface "winsock")

(def-mactype :NSSocketNativeHandle (find-mactype ':SOCKET))
 |#

; #else

(def-mactype :NSSocketNativeHandle (find-mactype ':signed-long))

; #endif /* __WIN32__ */

(def-mactype :NSPortDidBecomeInvalidNotification (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSPort : NSObject <NSCopying, NSCoding>

+ (id)allocWithZone:(NSZone *)zone;

+ (NSPort *)port;

- (void)invalidate;
- (BOOL)isValid;

- (void)setDelegate:(id)anId;
- (id)delegate;

- (void)scheduleInRunLoop:(NSRunLoop *)runLoop forMode:(NSString *)mode;
- (void)removeFromRunLoop:(NSRunLoop *)runLoop forMode:(NSString *)mode;

- (unsigned)reservedSpaceLength;	- (BOOL)sendBeforeDate:(NSDate *)limitDate components:(NSMutableArray *)components from:(NSPort *) receivePort reserved:(unsigned)headerSpaceReserved;
- (BOOL)sendBeforeDate:(NSDate *)limitDate msgid:(unsigned)msgID components:(NSMutableArray *)components from:(NSPort *)receivePort reserved:(unsigned)headerSpaceReserved;
										
- (void)addConnection:(NSConnection *)conn toRunLoop:(NSRunLoop *)runLoop forMode:(NSString *)mode;
- (void)removeConnection:(NSConnection *)conn fromRunLoop:(NSRunLoop *)runLoop forMode:(NSString *)mode;
				
|#
#| @INTERFACE 
NSObject (NSPortDelegateMethods)

- (void)handlePortMessage:(NSPortMessage *)message;
			
|#

; #if defined(__MACH__)
#| #| @INTERFACE 
NSMachPort : NSPort {
    private
    id _delegate;
    void *_tickler;
    int _machPort;
    unsigned _reserved;
}

+ (NSPort *)portWithMachPort:(int)machPort;

- (id)initWithMachPort:(int)machPort;	- (int)machPort;

- (void)scheduleInRunLoop:(NSRunLoop *)runLoop forMode:(NSString *)mode;
- (void)removeFromRunLoop:(NSRunLoop *)runLoop forMode:(NSString *)mode;
			
|#
#| @INTERFACE 
NSObject (NSMachPortDelegateMethods)

- (void)handleMachMessage:(void *)msg;

|#
 |#

; #endif /* __MACH__ */

;  A subclass of NSPort which can be used for local
;  message sending on all platforms.
#| @INTERFACE 
NSMessagePort : NSPort {
    private
    void *_port;
    id _delegate;
}

|#
;  A subclass of NSPort which can be used for remote
;  message sending on all platforms.
#| @INTERFACE 
NSSocketPort : NSPort {
    private
    void *_receiver;
    void *_connectors;
    void *_loops;
    void *_data;
    id _signature;
    id _delegate;
    id _lock;
    unsigned _maxSize;
    unsigned _maxSockets;
    unsigned _reserved;
}

- (id)init;
- (id)initWithTCPPort:(unsigned short)port;
- (id)initWithProtocolFamily:(int)family socketType:(int)type protocol:(int)protocol address:(NSData *)address;
- (id)initWithProtocolFamily:(int)family socketType:(int)type protocol:(int)protocol socket:(NSSocketNativeHandle)sock;
- (id)initRemoteWithTCPPort:(unsigned short)port host:(NSString *)hostName;
- (id)initRemoteWithProtocolFamily:(int)family socketType:(int)type protocol:(int)protocol address:(NSData *)address;
- (int)protocolFamily;
- (int)socketType;
- (int)protocol;
- (NSData *)address;
- (NSSocketNativeHandle)socket;

|#

(provide-interface "NSPort")