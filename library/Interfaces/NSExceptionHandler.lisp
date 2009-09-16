(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSExceptionHandler.h"
; at Sunday July 2,2006 7:30:47 pm.
; 
; 	NSExceptionHandler.h
; 	Exception Handling
; 	Copyright (c) 1998, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import "ExceptionHandlingDefines.h"

; #import <Foundation/NSObject.h>
(def-mactype :NSUncaughtSystemExceptionException (find-mactype '(:pointer :NSString)))
(def-mactype :NSUncaughtRuntimeErrorException (find-mactype '(:pointer :NSString)))
(def-mactype :NSStackTraceKey (find-mactype '(:pointer :NSString)))
;  key for stack trace in exception's userInfo

(deftrap-inline "_NSExceptionHandlerResume" 
   ((ARG2 (:NIL :NIL))
   )
   nil
() )
;  resume when hung for debugger

(defconstant $NSLogUncaughtExceptionMask 1)
(defconstant $NSHandleUncaughtExceptionMask 2)
(defconstant $NSLogUncaughtSystemExceptionMask 4)
(defconstant $NSHandleUncaughtSystemExceptionMask 8)
(defconstant $NSLogUncaughtRuntimeErrorMask 16)
(defconstant $NSHandleUncaughtRuntimeErrorMask 32)
(defconstant $NSLogTopLevelExceptionMask 64)
(defconstant $NSHandleTopLevelExceptionMask #x80)
(defconstant $NSLogOtherExceptionMask #x100)
(defconstant $NSHandleOtherExceptionMask #x200)
(defconstant $NSLogAndHandleEveryExceptionMask 1023)
; #define NSLogAndHandleEveryExceptionMask (NSLogUncaughtExceptionMask|NSLogUncaughtSystemExceptionMask|NSLogUncaughtRuntimeErrorMask|NSHandleUncaughtExceptionMask|NSHandleUncaughtSystemExceptionMask|NSHandleUncaughtRuntimeErrorMask|NSLogTopLevelExceptionMask|NSHandleTopLevelExceptionMask|NSLogOtherExceptionMask|NSHandleOtherExceptionMask)

(defconstant $NSHangOnUncaughtExceptionMask 1)
(defconstant $NSHangOnUncaughtSystemExceptionMask 2)
(defconstant $NSHangOnUncaughtRuntimeErrorMask 4)
(defconstant $NSHangOnTopLevelExceptionMask 8)
(defconstant $NSHangOnOtherExceptionMask 16)
(defconstant $NSHangOnEveryExceptionMask 31)
; #define NSHangOnEveryExceptionMask (NSHangOnUncaughtExceptionMask|NSHangOnUncaughtSystemExceptionMask|NSHangOnUncaughtRuntimeErrorMask|NSHangOnTopLevelExceptionMask|NSHangOnOtherExceptionMask)
#| @INTERFACE 
NSExceptionHandler : NSObject
{
private
    id _delegate;
    NSString *_exceptionLoggingConnectionName;
    struct {
        unsigned int exceptionHandlingMask:10;
        unsigned int reserved:10;
        unsigned int exceptionHangingMask:5;
        unsigned int reserved1:5;
        unsigned int drwh:1;
        unsigned int drwl:1;
    } _ehFlags;
    void *_reserved;
}

+ (NSExceptionHandler *)defaultExceptionHandler;
- (void)setExceptionHandlingMask:(unsigned int)aMask;
- (unsigned int)exceptionHandlingMask;
- (void)setExceptionHangingMask:(unsigned int)aMask;
- (unsigned int)exceptionHangingMask;
- (void)setDelegate:(id)anObject;
- (id)delegate;

|#
#| @INTERFACE 
NSObject(NSExceptionHandlerDelegate)

- (BOOL)exceptionHandler:(NSExceptionHandler *)sender shouldLogException:(NSException *)exception mask:(unsigned int)aMask;	- (BOOL)exceptionHandler:(NSExceptionHandler *)sender shouldHandleException:(NSException *)exception mask:(unsigned int)aMask;	
|#

(provide-interface "NSExceptionHandler")