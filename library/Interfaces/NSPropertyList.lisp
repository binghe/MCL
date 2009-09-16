(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPropertyList.h"
; at Sunday July 2,2006 7:30:57 pm.
; 	NSPropertyList.h
; 	Copyright (c) 2002-2003, Apple, Inc. All rights reserved.
; 

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

; #import <Foundation/NSObject.h>

(require-interface "CoreFoundation/CFPropertyList")

(defconstant $NSPropertyListImmutable 0)
(defconstant $NSPropertyListMutableContainers 1)
(defconstant $NSPropertyListMutableContainersAndLeaves 2)
(def-mactype :NSPropertyListMutabilityOptions (find-mactype ':SINT32))

(defconstant $NSPropertyListOpenStepFormat 1)
(defconstant $NSPropertyListXMLFormat_v1_0 100)
(defconstant $NSPropertyListBinaryFormat_v1_0 #xC8)
(def-mactype :NSPropertyListFormat (find-mactype ':SINT32))
;  Note: the old-style binary plist format of NSSerializer and NSDeserializer is version "0.5"
#| @INTERFACE 
NSPropertyListSerialization : NSObject {
    void *reserved[6];
}

+ (BOOL)propertyList:(id)plist isValidForFormat:(NSPropertyListFormat)format;
+ (NSData *)dataFromPropertyList:(id)plist format:(NSPropertyListFormat)format errorDescription:(NSString **)errorString;
+ (id)propertyListFromData:(NSData *)data mutabilityOption:(NSPropertyListMutabilityOptions)opt format:(NSPropertyListFormat *)format errorDescription:(NSString **)errorString;

|#

; #endif


(provide-interface "NSPropertyList")