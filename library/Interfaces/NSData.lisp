(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSData.h"
; at Sunday July 2,2006 7:30:45 pm.
; 	NSData.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSRange.h>
; ***************	Immutable Data		***************
#| @INTERFACE 
NSData : NSObject <NSCopying, NSMutableCopying, NSCoding>

- (unsigned)length;
- (const void *)bytes;

|#
#| @INTERFACE 
NSData (NSExtendedData)

- (NSString *)description;
- (void)getBytes:(void *)buffer;
- (void)getBytes:(void *)buffer length:(unsigned)length;
- (void)getBytes:(void *)buffer range:(NSRange)range;
- (BOOL)isEqualToData:(NSData *)other;
- (NSData *)subdataWithRange:(NSRange)range;
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
- (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically; 
|#
#| @INTERFACE 
NSData (NSDataCreation)

+ (id)data;
+ (id)dataWithBytes:(const void *)bytes length:(unsigned)length;
+ (id)dataWithBytesNoCopy:(void *)bytes length:(unsigned)length;
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
+ (id)dataWithBytesNoCopy:(void *)bytes length:(unsigned)length freeWhenDone:(BOOL)b;
#endif
+ (id)dataWithContentsOfFile:(NSString *)path;
+ (id)dataWithContentsOfURL:(NSURL *)url;
+ (id)dataWithContentsOfMappedFile:(NSString *)path;
- (id)initWithBytes:(const void *)bytes length:(unsigned)length;
- (id)initWithBytesNoCopy:(void *)bytes length:(unsigned)length;
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (id)initWithBytesNoCopy:(void *)bytes length:(unsigned)length freeWhenDone:(BOOL)b;
#endif
- (id)initWithContentsOfFile:(NSString *)path;
- (id)initWithContentsOfURL:(NSURL *)url;
- (id)initWithContentsOfMappedFile:(NSString *)path;
- (id)initWithData:(NSData *)data;
+ (id)dataWithData:(NSData *)data;

|#
; ***************	Mutable Data		***************
#| @INTERFACE 
NSMutableData : NSData

- (void *)mutableBytes;
- (void)setLength:(unsigned)length;

|#
#| @INTERFACE 
NSMutableData (NSExtendedMutableData)

- (void)appendBytes:(const void *)bytes length:(unsigned)length;
- (void)appendData:(NSData *)other;
- (void)increaseLengthBy:(unsigned)extraLength;
- (void)replaceBytesInRange:(NSRange)range withBytes:(const void *)bytes;
- (void)resetBytesInRange:(NSRange)range;
- (void)setData:(NSData *)data;
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (void)replaceBytesInRange:(NSRange)range withBytes:(const void *)replacementBytes length:(unsigned)replacementLength;
#endif

|#
#| @INTERFACE 
NSMutableData (NSMutableDataCreation)

+ (id)dataWithCapacity:(unsigned)aNumItems;
+ (id)dataWithLength:(unsigned)length;
- (id)initWithCapacity:(unsigned)capacity;
- (id)initWithLength:(unsigned)length;

|#

(provide-interface "NSData")