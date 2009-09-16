(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSUserDefaultsController.h"
; at Sunday July 2,2006 7:31:05 pm.
; 
; 	NSUserDefaultsController.h
; 	Application Kit
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
;  

; #import <AppKit/NSController.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
#| @INTERFACE 
NSUserDefaultsController : NSController {
private
	void *_reserved3;
	void *_reserved4;
    NSUserDefaults *_defaults;
    NSMutableDictionary *_valueBuffer;
    NSDictionary *_initialValues;
    struct __userDefaultsControllerFlags {
        unsigned int _sharedInstance:1;
        unsigned int _appliesImmediately:1;
        unsigned int _reservedUserDefaultsController:30;
    } _userDefaultsControllerFlags;
}

+ (id)sharedUserDefaultsController;

- (id)initWithDefaults:(NSUserDefaults *)defaults initialValues:(NSDictionary *)initialValues;    
- (NSUserDefaults *)defaults;
- (void)setInitialValues:(NSDictionary *)initialValues;
- (NSDictionary *)initialValues;

- (void)setAppliesImmediately:(BOOL)flag;   - (BOOL)appliesImmediately;

- (id)values;    
- (void)revert:(id)sender;
- (void)save:(id)sender;    - (void)revertToInitialValues:(id)sender;    
|#

; #endif


(provide-interface "NSUserDefaultsController")