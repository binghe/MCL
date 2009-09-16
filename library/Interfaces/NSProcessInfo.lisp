(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSProcessInfo.h"
; at Sunday July 2,2006 7:30:57 pm.
; 	NSProcessInfo.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
;  Constants returned by -operatingSystem 

(defconstant $NSWindowsNTOperatingSystem 1)
(defconstant $NSWindows95OperatingSystem 2)
(defconstant $NSSolarisOperatingSystem 3)
(defconstant $NSHPUXOperatingSystem 4)
(defconstant $NSMACHOperatingSystem 5)
(defconstant $NSSunOSOperatingSystem 6)
(defconstant $NSOSF1OperatingSystem 7)
#| @INTERFACE 
NSProcessInfo : NSObject {
    private	
    NSDictionary	*environment;
    NSArray		*arguments;
    NSString		*hostName;    
    NSString		*name;
    void		*reserved;
}

+ (NSProcessInfo *)processInfo;	

- (NSDictionary *)environment;

- (NSArray *)arguments;

- (NSString *)hostName;

- (NSString *)processName;

- (int)processIdentifier;

- (void)setProcessName:(NSString *)newName;

- (NSString *)globallyUniqueString;

- (unsigned int)operatingSystem;
- (NSString *)operatingSystemName;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (NSString *)operatingSystemVersionString;	
#endif

|#

(provide-interface "NSProcessInfo")