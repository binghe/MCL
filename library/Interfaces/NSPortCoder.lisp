(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPortCoder.h"
; at Sunday July 2,2006 7:30:56 pm.
; 	NSPortCoder.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSCoder.h>
#| @INTERFACE 
NSPortCoder : NSCoder

- (BOOL)isBycopy;
- (BOOL)isByref;
- (NSConnection *)connection;
- (void)encodePortObject:(NSPort *)aport;
- (NSPort *)decodePortObject;

+ portCoderWithReceivePort:(NSPort *)rcvPort sendPort:(NSPort *)sndPort components:(NSArray *)comps;
- (id)initWithReceivePort:(NSPort *)rcvPort sendPort:(NSPort *)sndPort components:(NSArray *)comps;
- (void)dispatch;

|#
#| @INTERFACE 
NSObject (NSDistributedObjects)

- (Class)classForPortCoder;

- (id)replacementObjectForPortCoder:(NSPortCoder *)coder;

|#

(provide-interface "NSPortCoder")