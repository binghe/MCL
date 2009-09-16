(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSAppleScript.h"
; at Sunday July 2,2006 7:30:35 pm.
; 
; 	NSAppleScript.h
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

; #import <Foundation/NSObject.h>
;  If the result of -initWithContentsOfURL:error:, -compileAndReturnError:, -executeAndReturnError:, or -executeAppleEvent:error:, signals failure (nil, NO, nil, or nil, respectively), a pointer to an autoreleased dictionary is put at the location pointed to by the error parameter.  The error info dictionary may contain entries that use any combination of the following keys, including no entries at all.
(def-mactype :NSAppleScriptErrorMessage (find-mactype '(:pointer :NSString)))
;  NSString
(def-mactype :NSAppleScriptErrorNumber (find-mactype '(:pointer :NSString)))
;  NSNumber
(def-mactype :NSAppleScriptErrorAppName (find-mactype '(:pointer :NSString)))
;  NSString
(def-mactype :NSAppleScriptErrorBriefMessage (find-mactype '(:pointer :NSString)))
;  NSString
(def-mactype :NSAppleScriptErrorRange (find-mactype '(:pointer :NSString)))
;  NSValue (containing a range)
#| @INTERFACE 
NSAppleScript : NSObject<NSCopying> {
    private
    NSString *_source;
    unsigned long _compiledScriptID;
    void *_reserved1;
    void *_reserved2;
}

- (id)initWithContentsOfURL:(NSURL *)url error:(NSDictionary **)errorInfo;

- (id)initWithSource:(NSString *)source;

- (NSString *)source;

- (BOOL)isCompiled;

- (BOOL)compileAndReturnError:(NSDictionary **)errorInfo;

- (NSAppleEventDescriptor *)executeAndReturnError:(NSDictionary **)errorInfo;

- (NSAppleEventDescriptor *)executeAppleEvent:(NSAppleEventDescriptor *)event error:(NSDictionary **)errorInfo;

|#

; #endif


(provide-interface "NSAppleScript")