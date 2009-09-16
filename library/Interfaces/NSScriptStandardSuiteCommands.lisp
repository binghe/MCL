(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSScriptStandardSuiteCommands.h"
; at Sunday July 2,2006 7:30:58 pm.
; 
; 	NSScriptStandardSuiteCommands.h
; 	Copyright (c) 1997-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSScriptCommand.h>

(defconstant $NSSaveOptionsYes 0)
(defconstant $NSSaveOptionsNo 1)
(defconstant $NSSaveOptionsAsk 2)
(def-mactype :NSSaveOptions (find-mactype ':SINT32))
#| @INTERFACE 
NSCloneCommand : NSScriptCommand {
    private
    NSScriptObjectSpecifier *_keySpecifier;
}

- (void)setReceiversSpecifier:(NSScriptObjectSpecifier *)receiversRef;
    
- (NSScriptObjectSpecifier *)keySpecifier;

|#
#| @INTERFACE 
NSCloseCommand : NSScriptCommand {}

- (NSSaveOptions)saveOptions;
    
|#
#| @INTERFACE 
NSCountCommand : NSScriptCommand {}

|#
#| @INTERFACE 
NSCreateCommand : NSScriptCommand {
    private
    void *_privateVars;
}

- (NSScriptClassDescription *)createClassDescription;
    
- (NSDictionary *)resolvedKeyDictionary;
    
|#
#| @INTERFACE 
NSDeleteCommand : NSScriptCommand {
    private
    NSScriptObjectSpecifier *_keySpecifier;
}

- (void)setReceiversSpecifier:(NSScriptObjectSpecifier *)receiversRef;
    
- (NSScriptObjectSpecifier *)keySpecifier;

|#
#| @INTERFACE 
NSExistsCommand : NSScriptCommand {}

|#
#| @INTERFACE 
NSGetCommand : NSScriptCommand {}

|#
#| @INTERFACE 
NSMoveCommand : NSScriptCommand {
    private
    NSScriptObjectSpecifier *_keySpecifier;
}

- (void)setReceiversSpecifier:(NSScriptObjectSpecifier *)receiversRef;
    
- (NSScriptObjectSpecifier *)keySpecifier;

|#
#| @INTERFACE 
NSQuitCommand : NSScriptCommand {}

- (NSSaveOptions)saveOptions;
    
|#
#| @INTERFACE 
NSSetCommand : NSScriptCommand {
    private
    NSScriptObjectSpecifier *_keySpecifier;
}

- (void)setReceiversSpecifier:(NSScriptObjectSpecifier *)receiversRef;
    
- (NSScriptObjectSpecifier *)keySpecifier;

|#

(provide-interface "NSScriptStandardSuiteCommands")