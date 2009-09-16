(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSKeyedArchiver.h"
; at Sunday July 2,2006 7:30:51 pm.
; 	NSKeyedArchiver.h
; 	Copyright (c) 2001-2003, Apple, Inc. All rights reserved.
; 

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

; #import <Foundation/NSCoder.h>

; #import <Foundation/NSGeometry.h>

; #import <Foundation/NSPropertyList.h>
(def-mactype :NSInvalidArchiveOperationException (find-mactype '(:pointer :NSString)))
(def-mactype :NSInvalidUnarchiveOperationException (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSKeyedArchiver : NSCoder {
private
    void *_stream;
    uint32_t _flags;
    id _delegate;
    void *_containers;
    void *_objects;
    void *_objRefMap;
    void *_replacementMap;
    void *_classNameMap;
    void *_conditionals;
    void *_classes;
    int32_t _genericKey;
    void *_cache;
    uint32_t _cacheSize;
    void *_reserved3;
    void *_reserved2;
    void *_reserved1;
    void *_reserved0;
}

+ (NSData *)archivedDataWithRootObject:(id)rootObject;
+ (BOOL)archiveRootObject:(id)rootObject toFile:(NSString *)path;

- (id)initForWritingWithMutableData:(NSMutableData *)data;

- (void)setDelegate:(id)delegate;
- (id)delegate;

- (void)setOutputFormat:(NSPropertyListFormat)format;
- (NSPropertyListFormat)outputFormat;

- (void)finishEncoding;

+ (void)setClassName:(NSString *)codedName forClass:(Class)cls;
- (void)setClassName:(NSString *)codedName forClass:(Class)cls;
		
+ (NSString *)classNameForClass:(Class)cls;
- (NSString *)classNameForClass:(Class)cls;

- (void)encodeObject:(id)objv forKey:(NSString *)key;
- (void)encodeConditionalObject:(id)objv forKey:(NSString *)key;
- (void)encodeBool:(BOOL)boolv forKey:(NSString *)key;
- (void)encodeInt:(int)intv forKey:(NSString *)key;	- (void)encodeInt32:(int32_t)intv forKey:(NSString *)key;
- (void)encodeInt64:(int64_t)intv forKey:(NSString *)key;
- (void)encodeFloat:(float)realv forKey:(NSString *)key;
- (void)encodeDouble:(double)realv forKey:(NSString *)key;
- (void)encodeBytes:(const uint8_t *)bytesp length:(unsigned)lenv forKey:(NSString *)key;

|#
#| @INTERFACE 
NSKeyedUnarchiver : NSCoder {
private
    id _delegate;
    uint32_t _flags;
    void *_objRefMap;
    void *_replacementMap;
    void *_nameClassMap;
    void *_tmpRefObjMap;
    void *_refObjMap;
    int32_t _genericKey;
    const void *_data;
    const uint8_t *_bytes;
    void *_offsetData;
    void *_containers;
    void *_objects;
    void *_reserved3;
    void *_reserved2;
    void *_reserved1;
    void *_reserved0;
}

+ (id)unarchiveObjectWithData:(NSData *)data;
+ (id)unarchiveObjectWithFile:(NSString *)path;

- (id)initForReadingWithData:(NSData *)data;

- (void)setDelegate:(id)delegate;
- (id)delegate;

- (void)finishDecoding;

+ (void)setClass:(Class)cls forClassName:(NSString *)codedName;
- (void)setClass:(Class)cls forClassName:(NSString *)codedName;
		
+ (Class)classForClassName:(NSString *)codedName;
- (Class)classForClassName:(NSString *)codedName;

- (BOOL)containsValueForKey:(NSString *)key;

- (id)decodeObjectForKey:(NSString *)key;
- (BOOL)decodeBoolForKey:(NSString *)key;
- (int)decodeIntForKey:(NSString *)key;		- (int32_t)decodeInt32ForKey:(NSString *)key;
- (int64_t)decodeInt64ForKey:(NSString *)key;
- (float)decodeFloatForKey:(NSString *)key;
- (double)decodeDoubleForKey:(NSString *)key;
- (const uint8_t *)decodeBytesForKey:(NSString *)key returnedLength:(unsigned *)lengthp;	
|#
#| @INTERFACE 
NSCoder (NSGeometryKeyedCoding)

- (void)encodePoint:(NSPoint)point forKey:(NSString *)key;
- (void)encodeSize:(NSSize)size forKey:(NSString *)key;
- (void)encodeRect:(NSRect)rect forKey:(NSString *)key;

- (NSPoint)decodePointForKey:(NSString *)key;
- (NSSize)decodeSizeForKey:(NSString *)key;
- (NSRect)decodeRectForKey:(NSString *)key;

|#
#| @INTERFACE 
NSObject (NSKeyedArchiverDelegate)

- (id)archiver:(NSKeyedArchiver *)archiver willEncodeObject:(id)object;
				                                        
- (void)archiver:(NSKeyedArchiver *)archiver didEncodeObject:(id)object;
				
- (void)archiver:(NSKeyedArchiver *)archiver willReplaceObject:(id)object withObject:(id)newObject;
				
- (void)archiverWillFinish:(NSKeyedArchiver *)archiver;
	
- (void)archiverDidFinish:(NSKeyedArchiver *)archiver;
	
|#
#| @INTERFACE 
NSObject (NSKeyedUnarchiverDelegate)

- (Class)unarchiver:(NSKeyedUnarchiver *)unarchiver cannotDecodeObjectOfClassName:(NSString *)name originalClasses:(NSArray *)classNames;
				                
- (id)unarchiver:(NSKeyedUnarchiver *)unarchiver didDecodeObject:(id)object;
					
- (void)unarchiver:(NSKeyedUnarchiver *)unarchiver willReplaceObject:(id)object withObject:(id)newObject;
				
- (void)unarchiverWillFinish:(NSKeyedUnarchiver *)unarchiver;
	
- (void)unarchiverDidFinish:(NSKeyedUnarchiver *)unarchiver;
	
|#
#| @INTERFACE 
NSObject (NSKeyedArchiverObjectSubstitution)

- (Class)classForKeyedArchiver;
			                		
- (id)replacementObjectForKeyedArchiver:(NSKeyedArchiver *)archiver;
				                			
|#
#| @INTERFACE 
NSObject (NSKeyedUnarchiverObjectSubstitution)

+ (Class)classForKeyedUnarchiver;
	                        
|#

; #endif


(provide-interface "NSKeyedArchiver")