(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTask.h"
; at Sunday July 2,2006 7:31:02 pm.
; 	NSTask.h
; 	Copyright (c) 1996-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSTask : NSObject


- (id)init;

- (void)setLaunchPath:(NSString *)path;
- (void)setArguments:(NSArray *)arguments;
- (void)setEnvironment:(NSDictionary *)dict;
	- (void)setCurrentDirectoryPath:(NSString *)path;
	
- (void)setStandardInput:(id)input;
- (void)setStandardOutput:(id)output;
- (void)setStandardError:(id)error;

- (NSString *)launchPath;
- (NSArray *)arguments;
- (NSDictionary *)environment;
- (NSString *)currentDirectoryPath;

- (id)standardInput;
- (id)standardOutput;
- (id)standardError;

- (void)launch;

- (void)interrupt; - (void)terminate; 
- (BOOL)suspend;
- (BOOL)resume;

- (int)processIdentifier; 
- (BOOL)isRunning;

- (int)terminationStatus;

|#
#| @INTERFACE 
NSTask (NSTaskConveniences)

+ (NSTask *)launchedTaskWithLaunchPath:(NSString *)path arguments:(NSArray *)arguments;
	
- (void)waitUntilExit;
	
|#
(def-mactype :NSTaskDidTerminateNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSTask")