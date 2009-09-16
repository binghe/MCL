(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPortMessage.h"
; at Sunday July 2,2006 7:30:56 pm.
; 	NSPortMessage.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSPortMessage : NSObject {
    private
    NSPort 		*localPort;
    NSPort 		*remotePort;
    NSMutableArray 	*components;
    unsigned		msgid;
    void		*reserved2;
    void		*reserved;
}

- (id)initWithSendPort:(NSPort *)sendPort receivePort:(NSPort *)replyPort components:(NSArray *)components;

- (NSArray *)components;
- (NSPort *)receivePort;
- (NSPort *)sendPort;
- (BOOL)sendBeforeDate:(NSDate *)date;

- (unsigned)msgid;
- (void)setMsgid:(unsigned)msgid;
|#

(provide-interface "NSPortMessage")