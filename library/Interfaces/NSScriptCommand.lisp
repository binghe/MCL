(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSScriptCommand.h"
; at Sunday July 2,2006 7:30:58 pm.
; 
; 	NSScriptCommand.h
; 	Copyright (c) 1997-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>
;  Error codes for general command execution problems (not typedef'd to allow subclasses to define their own values)

(defconstant $NSNoScriptError 0)
(defconstant $NSReceiverEvaluationScriptError 1);  Problem evaluating receiver specifier

(defconstant $NSKeySpecifierEvaluationScriptError 2);  Problem evaluating key specifier (for commands that have them)

(defconstant $NSArgumentEvaluationScriptError 3);  Problem evaluating an argument specifier

(defconstant $NSReceiversCantHandleCommandScriptError 4);  The receivers dont support the command

(defconstant $NSRequiredArgumentsMissingScriptError 5);  One or more required arguments are missing

(defconstant $NSArgumentsWrongScriptError 6)    ;  One or more arguments are of wrong type or are otherwise invalid

(defconstant $NSUnknownKeyScriptError 7)        ;  Other miscellaneous internal error

(defconstant $NSInternalScriptError 8)          ;  Other miscellaneous internal error

(defconstant $NSOperationNotSupportedForKeyScriptError 9)
(defconstant $NSCannotCreateScriptCommandError 10)
#| @INTERFACE 
NSScriptCommand : NSObject <NSCoding> {

        private
    NSScriptCommandDescription *_commandDescription;
    id _directParameter;
    NSScriptObjectSpecifier *_receiversSpecifier;
    id _evaluatedReceivers;
    NSMutableDictionary *_arguments;
    NSMutableDictionary *_evaluatedArguments;
    struct {
        unsigned int hasEvaluatedReceivers:1;
        unsigned int hasEvaluatedArguments:1;
        unsigned int hasBeenValidated:1;
        unsigned int isWellFormed:1;
        unsigned int RESERVED:28;
    } _flags;
    void *_moreVars;
    void *_reserved;

}

- (id)initWithCommandDescription:(NSScriptCommandDescription *)commandDef;

- (NSScriptCommandDescription *)commandDescription;
    
- (void)setDirectParameter:(id)directParameter;
- (id)directParameter;
    
- (void)setReceiversSpecifier:(NSScriptObjectSpecifier *)receiversRef;
- (NSScriptObjectSpecifier *)receiversSpecifier;
        
- (id)evaluatedReceivers;
    
- (void)setArguments:(NSDictionary *)args;
- (NSDictionary *)arguments;
- (NSDictionary *)evaluatedArguments;
    
- (BOOL)isWellFormed;
    
- (id)performDefaultImplementation;

- (id)executeCommand;

- (void)setScriptErrorNumber:(int)errorNumber;
- (int)scriptErrorNumber;

- (void)setScriptErrorString:(NSString *)errorString;
- (NSString *)scriptErrorString;

#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

+ (NSScriptCommand *)currentCommand;

- (NSAppleEventDescriptor *)appleEvent;

- (void)suspendExecution;

- (void)resumeExecutionWithResult:(id)result;

#endif

|#

(provide-interface "NSScriptCommand")