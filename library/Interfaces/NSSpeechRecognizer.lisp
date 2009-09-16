(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSSpeechRecognizer.h"
; at Sunday July 2,2006 7:31:00 pm.
; 
; 	NSSpeechRecognizer.h
; 	Application Kit
; 	Copyright (c) 2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/AppKitDefines.h>

; #import <Foundation/NSObject.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
#| @INTERFACE 
NSSpeechRecognizer : NSObject {
private     id	_privateNSSpeechRecognizerVars;
}

- (id)init;

- (void)startListening;
- (void)stopListening;

- (id)delegate;
- (void)setDelegate:(id)anObject;

- (NSArray *)commands;
- (void)setCommands:(NSArray *)commands;

- (NSString *)displayedCommandsTitle;
- (void)setDisplayedCommandsTitle:(NSString *)title;

- (BOOL)listensInForegroundOnly;
- (void)setListensInForegroundOnly:(BOOL)flag;

- (BOOL)blocksOtherRecognizers;
- (void)setBlocksOtherRecognizers:(BOOL)flag;

|#
#| @INTERFACE 
NSObject (NSSpeechRecognizerDelegate)

- (void)speechRecognizer:(NSSpeechRecognizer *)sender didRecognizeCommand:(id)command;

|#

; #endif


(provide-interface "NSSpeechRecognizer")