(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSStream.h"
; at Sunday July 2,2006 7:31:01 pm.
; 	NSStream.h
;         Copyright 2003, Apple, Inc. All rights reserved
; 

; #import <Foundation/NSObject.h>

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

(defconstant $NSStreamStatusNotOpen 0)
(defconstant $NSStreamStatusOpening 1)
(defconstant $NSStreamStatusOpen 2)
(defconstant $NSStreamStatusReading 3)
(defconstant $NSStreamStatusWriting 4)
(defconstant $NSStreamStatusAtEnd 5)
(defconstant $NSStreamStatusClosed 6)
(defconstant $NSStreamStatusError 7)
(def-mactype :NSStreamStatus (find-mactype ':SINT32))

(defconstant $NSStreamEventNone 0)
(defconstant $NSStreamEventOpenCompleted 1)
(defconstant $NSStreamEventHasBytesAvailable 2)
(defconstant $NSStreamEventHasSpaceAvailable 4)
(defconstant $NSStreamEventErrorOccurred 8)
(defconstant $NSStreamEventEndEncountered 16)
(def-mactype :NSStreamEvent (find-mactype ':SINT32))
;  NSStream is an abstract class encapsulating the common API to NSInputStream and NSOutputStream.
;  Subclassers of NSInputStream and NSOutputStream must also implement these methods.
#| @INTERFACE 
NSStream : NSObject
- (void)open;
- (void)close;

- (id)delegate;
- (void)setDelegate:(id)delegate;
    
- (id)propertyForKey:(NSString *)key;
- (BOOL)setProperty:(id)property forKey:(NSString *)key;

- (void)scheduleInRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode;
- (void)removeFromRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode;

- (NSStreamStatus)streamStatus;
- (NSError *)streamError;
|#
;  NSInputStream is an abstract class representing the base functionality of a read stream.
;  Subclassers are required to implement these methods.
#| @INTERFACE 
NSInputStream : NSStream
- (int)read:(uint8_t *)buffer maxLength:(unsigned int)len;
    
- (BOOL)getBuffer:(uint8_t **)buffer length:(unsigned int *)len;
    
- (BOOL)hasBytesAvailable;
    
|#
;  NSOutputStream is an abstract class representing the base functionality of a write stream.
;  Subclassers are required to implement these methods.
#| @INTERFACE 
NSOutputStream : NSStream
- (int)write:(const uint8_t *)buffer maxLength:(unsigned int)len;
    
- (BOOL)hasSpaceAvailable;
    
|#
#| @INTERFACE 
NSStream (NSSocketStreamCreationExtensions)
+ (void)getStreamsToHost:(NSHost *)host port:(int)port inputStream:(NSInputStream **)inputStream outputStream:(NSOutputStream **)outputStream;
|#
;  The NSInputStreamExtensions category contains additional initializers and convenience routines for dealing with NSInputStreams.
#| @INTERFACE 
NSInputStream (NSInputStreamExtensions)
- (id)initWithData:(NSData *)data;
- (id)initWithFileAtPath:(NSString *)path;

+ (id)inputStreamWithData:(NSData *)data;
+ (id)inputStreamWithFileAtPath:(NSString *)path;
|#
;  The NSOutputStreamExtensions category contains additiona initializers and convenience routines for dealing with NSOutputStreams.
#| @INTERFACE 
NSOutputStream (NSOutputStreamExtensions)
- (id)initToMemory;
- (id)initToBuffer:(uint8_t *)buffer capacity:(unsigned int)capacity;
- (id)initToFileAtPath:(NSString *)path append:(BOOL)shouldAppend;

+ (id)outputStreamToMemory;
+ (id)outputStreamToBuffer:(uint8_t *)buffer capacity:(unsigned int)capacity;
+ (id)outputStreamToFileAtPath:(NSString *)path append:(BOOL)shouldAppend;
|#
#| @INTERFACE 
NSObject (NSStreamDelegateEventExtensions)
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode;
|#
;  NSString constants for the propertyForKey/setProperty:forKey: API
;  String constants for the setting of the socket security level.
(def-mactype :NSStreamSocketSecurityLevelKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  use this as the key for setting one of the following values for the security level of the target stream.
(def-mactype :NSStreamSocketSecurityLevelNone (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSStreamSocketSecurityLevelSSLv2 (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSStreamSocketSecurityLevelSSLv3 (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSStreamSocketSecurityLevelTLSv1 (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSStreamSocketSecurityLevelNegotiatedSSL (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSStreamSOCKSProxyConfigurationKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Value is an NSDictionary containing the key/value pairs below. The dictionary returned from SystemConfiguration for SOCKS proxies will work without alteration.
(def-mactype :NSStreamSOCKSProxyHostKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Value is an NSString
(def-mactype :NSStreamSOCKSProxyPortKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Value is an NSNumber
(def-mactype :NSStreamSOCKSProxyVersionKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Value is one of NSStreamSOCKSProxyVersion4 or NSStreamSOCKSProxyVersion5
(def-mactype :NSStreamSOCKSProxyUserKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Value is an NSString
(def-mactype :NSStreamSOCKSProxyPasswordKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Value is an NSString
(def-mactype :NSStreamSOCKSProxyVersion4 (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Value for NSStreamSOCKProxyVersionKey
(def-mactype :NSStreamSOCKSProxyVersion5 (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Value for NSStreamSOCKProxyVersionKey
(def-mactype :NSStreamDataWrittenToMemoryStreamKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Key for obtaining the data written to a memory stream.
(def-mactype :NSStreamFileCurrentOffsetKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Value is an NSNumber representing the current absolute offset of the stream.
;  NSString constants for error domains.
(def-mactype :NSStreamSocketSSLErrorDomain (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  SSL errors are to be interpreted via <Security/SecureTransport.h>
(def-mactype :NSStreamSOCKSErrorDomain (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER

; #endif		// Availability guard


(provide-interface "NSStream")