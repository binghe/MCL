(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSFileHandle.h"
; at Sunday July 2,2006 7:30:47 pm.
; 	NSFileHandle.h
; 	Copyright (c) 1995-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSArray.h>

; #import <Foundation/NSRange.h>
#| @INTERFACE 
NSFileHandle : NSObject

- (NSData *)availableData;

- (NSData *)readDataToEndOfFile;
- (NSData *)readDataOfLength:(unsigned int)length;

- (void)writeData:(NSData *)data;

- (unsigned long long)offsetInFile;
- (unsigned long long)seekToEndOfFile;
- (void)seekToFileOffset:(unsigned long long)offset;

- (void)truncateFileAtOffset:(unsigned long long)offset;
- (void)synchronizeFile;
- (void)closeFile;

|#
#| @INTERFACE 
NSFileHandle (NSFileHandleCreation)

+ (id)fileHandleWithStandardInput;
+ (id)fileHandleWithStandardOutput;
+ (id)fileHandleWithStandardError;
+ (id)fileHandleWithNullDevice;

+ (id)fileHandleForReadingAtPath:(NSString *)path;
+ (id)fileHandleForWritingAtPath:(NSString *)path;
+ (id)fileHandleForUpdatingAtPath:(NSString *)path;

|#
(def-mactype :NSFileHandleOperationException (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileHandleReadCompletionNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileHandleReadToEndOfFileCompletionNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileHandleConnectionAcceptedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileHandleDataAvailableNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileHandleNotificationDataItem (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileHandleNotificationFileHandleItem (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileHandleNotificationMonitorModes (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSFileHandle (NSFileHandleAsynchronousAccess)

- (void)readInBackgroundAndNotifyForModes:(NSArray *)modes;
- (void)readInBackgroundAndNotify;

- (void)readToEndOfFileInBackgroundAndNotifyForModes:(NSArray *)modes;
- (void)readToEndOfFileInBackgroundAndNotify;

- (void)acceptConnectionInBackgroundAndNotifyForModes:(NSArray *)modes;
- (void)acceptConnectionInBackgroundAndNotify;

- (void)waitForDataInBackgroundAndNotifyForModes:(NSArray *)modes;
- (void)waitForDataInBackgroundAndNotify;

|#
#| @INTERFACE 
NSFileHandle (NSFileHandlePlatformSpecific)

#if defined(__WIN32__)
- (id)initWithNativeHandle:(void *)nativeHandle closeOnDealloc:(BOOL)closeopt;
- (id)initWithNativeHandle:(void *)nativeHandle;
- (void *)nativeHandle;
#endif	

- (id)initWithFileDescriptor:(int)fd closeOnDealloc:(BOOL)closeopt;
- (id)initWithFileDescriptor:(int)fd;
- (int)fileDescriptor;

|#
#| @INTERFACE 
NSPipe : NSObject

- (NSFileHandle *)fileHandleForReading;
- (NSFileHandle *)fileHandleForWriting;

- (id)init;
+ (id)pipe;

|#

(provide-interface "NSFileHandle")