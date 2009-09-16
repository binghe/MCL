(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPortNameServer.h"
; at Sunday July 2,2006 7:30:56 pm.
; 	NSPortNameServer.h
; 	Copyright (c) 1993-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSPortNameServer : NSObject

+ (NSPortNameServer *)systemDefaultPortNameServer;

- (NSPort *)portForName:(NSString *)name;
- (NSPort *)portForName:(NSString *)name host:(NSString *)host;

- (BOOL)registerPort:(NSPort *)port name:(NSString *)name;

- (BOOL)removePortForName:(NSString *)name;

|#

; #if defined(__MACH__)
#| #| @INTERFACE 
NSMachBootstrapServer : NSPortNameServer
		
+ (id)sharedInstance;

- (NSPort *)portForName:(NSString *)name;
- (NSPort *)portForName:(NSString *)name host:(NSString *)host;
		
- (BOOL)registerPort:(NSPort *)port name:(NSString *)name;


|#
 |#

; #endif

#| @INTERFACE 
NSMessagePortNameServer : NSPortNameServer
		
+ (id)sharedInstance;

- (NSPort *)portForName:(NSString *)name;
- (NSPort *)portForName:(NSString *)name host:(NSString *)host;
		

|#
#| @INTERFACE 
NSSocketPortNameServer : NSPortNameServer
		
+ (id)sharedInstance;

- (NSPort *)portForName:(NSString *)name;
- (NSPort *)portForName:(NSString *)name host:(NSString *)host;
    - (BOOL)registerPort:(NSPort *)port name:(NSString *)name;

- (BOOL)removePortForName:(NSString *)name;
     
- (NSPort *)portForName:(NSString *)name host:(NSString *)host nameServerPortNumber:(unsigned short)portNumber;
- (BOOL)registerPort:(NSPort *)port name:(NSString *)name nameServerPortNumber:(unsigned short)portNumber;
- (void)setDefaultNameServerPortNumber:(unsigned short)portNumber;
- (unsigned short)defaultNameServerPortNumber;

|#

(provide-interface "NSPortNameServer")