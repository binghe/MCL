(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSSpeechSynthesizer.h"
; at Sunday July 2,2006 7:31:00 pm.
; 
; 	NSSpeechSynthesizer.h
; 	Application Kit
; 	Copyright (c) 2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/AppKitDefines.h>

; #import <Foundation/NSObject.h>

; #import <Foundation/NSRange.h>
(def-mactype :NSVoiceName (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSVoiceIdentifier (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSVoiceAge (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSVoiceGender (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSVoiceDemoText (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSVoiceLanguage (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSVoiceGenderNeuter (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSVoiceGenderMale (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSVoiceGenderFemale (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
#| @INTERFACE 
NSSpeechSynthesizer : NSObject {
private     id	_privateNSSpeechSynthesizerVars;
}

- (id)initWithVoice:(NSString *)voice;

- (BOOL)startSpeakingString:(NSString *)string;
- (BOOL)startSpeakingString:(NSString *)string toURL:(NSURL *)url;
- (void)stopSpeaking;
- (BOOL)isSpeaking;

- (id)delegate;
- (void)setDelegate:(id)anObject;
- (NSString *)voice;
- (BOOL)setVoice:(NSString *)voice;
- (BOOL)usesFeedbackWindow;
- (void)setUsesFeedbackWindow:(BOOL)flag;

+ (BOOL)isAnyApplicationSpeaking;
+ (NSString *)defaultVoice;
+ (NSArray *)availableVoices;
+ (NSDictionary *)attributesForVoice:(NSString*)voice;

|#
#| @INTERFACE 
NSObject (NSSpeechSynthesizerDelegate)

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking;
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakWord:(NSRange)characterRange ofString:(NSString *)string;
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakPhoneme:(short)phonemeOpcode;

|#

; #endif


(provide-interface "NSSpeechSynthesizer")