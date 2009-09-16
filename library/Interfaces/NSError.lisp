(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSError.h"
; at Sunday July 2,2006 7:30:46 pm.
; 	NSError.h
; 	Copyright 2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  Key in userInfo. In simple cases, for subsystems wishing to provide their error description up-front. Value should be a NSString.
(def-mactype :NSLocalizedDescriptionKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Key in userInfo. A recommended standard way to embed NSErrors from underlying calls. The value of this key should be an NSError.
(def-mactype :NSUnderlyingErrorKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Predefined domains; value of "code" will correspond to preexisting values in these domains.
(def-mactype :NSPOSIXErrorDomain (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSOSStatusErrorDomain (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSMachErrorDomain (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
#| @INTERFACE 
NSError : NSObject <NSCopying, NSCoding> {
    private
    void *_reserved;
    int _code;
    NSString *_domain;
    NSDictionary *_userInfo;
}


- (id)initWithDomain:(NSString *)domain code:(int)code userInfo:(NSDictionary *)dict;
+ (id)errorWithDomain:(NSString *)domain code:(int)code userInfo:(NSDictionary *)dict;


- (NSString *)domain;
- (int)code;


- (NSDictionary *)userInfo;


- (NSString *)localizedDescription;

|#

; #endif


(provide-interface "NSError")