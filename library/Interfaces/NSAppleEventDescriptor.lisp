(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSAppleEventDescriptor.h"
; at Sunday July 2,2006 7:30:34 pm.
; 
; 	NSAppleEventDescriptor.h
; 	Copyright (c) 1997-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <ApplicationServices/ApplicationServices.h>
#| @INTERFACE 
NSAppleEventDescriptor : NSObject<NSCopying> {
    private
    AEDesc _desc;
    BOOL _hasValidDesc;
    char _padding[3];
}

+ (NSAppleEventDescriptor *)nullDescriptor;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
+ (NSAppleEventDescriptor *)descriptorWithDescriptorType:(DescType)descriptorType bytes:(const void *)bytes length:(unsigned int)byteCount;
#endif
+ (NSAppleEventDescriptor *)descriptorWithDescriptorType:(DescType)descriptorType data:(NSData *)data;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
+ (NSAppleEventDescriptor *)descriptorWithBoolean:(Boolean)boolean;
+ (NSAppleEventDescriptor *)descriptorWithEnumCode:(OSType)enumerator;
+ (NSAppleEventDescriptor *)descriptorWithInt32:(SInt32)signedInt;
+ (NSAppleEventDescriptor *)descriptorWithTypeCode:(OSType)typeCode;
#endif

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
+ (NSAppleEventDescriptor *)descriptorWithString:(NSString *)string;
#endif

+ (NSAppleEventDescriptor *)appleEventWithEventClass:(AEEventClass)eventClass eventID:(AEEventID)eventID targetDescriptor:(NSAppleEventDescriptor *)targetDescriptor returnID:(AEReturnID)returnID transactionID:(AETransactionID)transactionID;
+ (NSAppleEventDescriptor *)listDescriptor;
+ (NSAppleEventDescriptor *)recordDescriptor;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (id)initWithAEDescNoCopy:(const AEDesc *)aeDesc;
#endif

- (id)initWithDescriptorType:(DescType)descriptorType bytes:(const void *)bytes length:(unsigned int)byteCount;
- (id)initWithDescriptorType:(DescType)descriptorType data:(NSData *)data;
- (id)initWithEventClass:(AEEventClass)eventClass eventID:(AEEventID)eventID targetDescriptor:(NSAppleEventDescriptor *)targetDescriptor returnID:(AEReturnID)returnID transactionID:(AETransactionID)transactionID;
- (id)initListDescriptor;
- (id)initRecordDescriptor;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (const AEDesc *)aeDesc;
#endif

- (DescType)descriptorType;
- (NSData *)data;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (Boolean)booleanValue;
- (OSType)enumCodeValue;
- (SInt32)int32Value;
- (OSType)typeCodeValue;
#endif

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (NSString *)stringValue;
#endif

- (AEEventClass)eventClass;
- (AEEventID)eventID;
- (AEReturnID)returnID;
- (AETransactionID)transactionID;

- (void)setParamDescriptor:(NSAppleEventDescriptor *)descriptor forKeyword:(AEKeyword)keyword;
- (NSAppleEventDescriptor *)paramDescriptorForKeyword:(AEKeyword)keyword;
- (void)removeParamDescriptorWithKeyword:(AEKeyword)keyword;

- (void)setAttributeDescriptor:(NSAppleEventDescriptor *)descriptor forKeyword:(AEKeyword)keyword;
- (NSAppleEventDescriptor *)attributeDescriptorForKeyword:(AEKeyword)keyword;

- (int)numberOfItems;

- (void)insertDescriptor:(NSAppleEventDescriptor *)descriptor atIndex:(long int)index;
- (NSAppleEventDescriptor *)descriptorAtIndex:(long int)index;
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (void)removeDescriptorAtIndex:(long int)index;
#else
- (void)removeDecriptorAtIndex:(long int)index;
#endif

- (void)setDescriptor:(NSAppleEventDescriptor *)descriptor forKeyword:(AEKeyword)keyword;
- (NSAppleEventDescriptor *)descriptorForKeyword:(AEKeyword)keyword;
- (void)removeDescriptorWithKeyword:(AEKeyword)keyword;

- (AEKeyword)keywordForDescriptorAtIndex:(long int)index;

- (NSAppleEventDescriptor *)coerceToDescriptorType:(DescType)descriptorType;

|#

(provide-interface "NSAppleEventDescriptor")