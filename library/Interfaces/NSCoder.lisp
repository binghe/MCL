(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSCoder.h"
; at Sunday July 2,2006 7:30:38 pm.
; 	NSCoder.h
; 	Copyright (c) 1993-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSCoder : NSObject

- (void)encodeValueOfObjCType:(const char *)type at:(const void *)addr;
- (void)encodeDataObject:(NSData *)data;
- (void)decodeValueOfObjCType:(const char *)type at:(void *)data;
- (NSData *)decodeDataObject;
- (unsigned)versionForClassName:(NSString *)className;

|#
#| @INTERFACE 
NSCoder (NSExtendedCoder)
    
- (void)encodeObject:(id)object;
- (void)encodePropertyList:(id)aPropertyList;
- (void)encodeRootObject:(id)rootObject;
- (void)encodeBycopyObject:(id)anObject;
- (void)encodeByrefObject:(id)anObject;
- (void)encodeConditionalObject:(id)object;
- (void)encodeValuesOfObjCTypes:(const char *)types, ...;
- (void)encodeArrayOfObjCType:(const char *)type count:(unsigned)count at:(const void *)array;
- (void)encodeBytes:(const void *)byteaddr length:(unsigned)length;

- (id)decodeObject;
- (id)decodePropertyList;
- (void)decodeValuesOfObjCTypes:(const char *)types, ...;
- (void)decodeArrayOfObjCType:(const char *)itemType count:(unsigned)count at:(void *)array;
- (void *)decodeBytesWithReturnedLength:(unsigned *)lengthp;

- (void)setObjectZone:(NSZone *)zone;
- (NSZone *)objectZone;

- (unsigned)systemVersion;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (BOOL)allowsKeyedCoding;

- (void)encodeObject:(id)objv forKey:(NSString *)key;
- (void)encodeConditionalObject:(id)objv forKey:(NSString *)key;
- (void)encodeBool:(BOOL)boolv forKey:(NSString *)key;
- (void)encodeInt:(int)intv forKey:(NSString *)key;
- (void)encodeInt32:(int32_t)intv forKey:(NSString *)key;
- (void)encodeInt64:(int64_t)intv forKey:(NSString *)key;
- (void)encodeFloat:(float)realv forKey:(NSString *)key;
- (void)encodeDouble:(double)realv forKey:(NSString *)key;
- (void)encodeBytes:(const uint8_t *)bytesp length:(unsigned)lenv forKey:(NSString *)key;

- (BOOL)containsValueForKey:(NSString *)key;
- (id)decodeObjectForKey:(NSString *)key;
- (BOOL)decodeBoolForKey:(NSString *)key;
- (int)decodeIntForKey:(NSString *)key;
- (int32_t)decodeInt32ForKey:(NSString *)key;
- (int64_t)decodeInt64ForKey:(NSString *)key;
- (float)decodeFloatForKey:(NSString *)key;
- (double)decodeDoubleForKey:(NSString *)key;
- (const uint8_t *)decodeBytesForKey:(NSString *)key returnedLength:(unsigned *)lengthp;   #endif

|#

(deftrap-inline "_NXReadNSObjectFromCoder" 
   ((decoder (:pointer :nscoder))
   )
   (:pointer :nsobject)
() )
;  Given an NSCoder, returns an object previously written with
;    NXWriteNSObject(). The returned object is autoreleased. 
#| @INTERFACE 
NSCoder (NSTypedstreamCompatibility)

- (void)encodeNXObject:(id)object;

    
- (id)decodeNXObject;


|#

(provide-interface "NSCoder")