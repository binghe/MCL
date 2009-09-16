(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebPreferences.h"
; at Sunday July 2,2006 7:32:18 pm.
; 	
;     WebPreferences.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 

; #import <Foundation/Foundation.h>
(def-mactype :WebPreferencesChangedNotification (find-mactype '(:pointer :NSString)))
; !
;     @class WebPreferences
; 
#| @INTERFACE 
WebPreferences: NSObject <NSCoding>
{
private
    WebPreferencesPrivate *_private;
}


+ (WebPreferences *)standardPreferences;


- (id)initWithIdentifier:(NSString *)anIdentifier;


- (NSString *)identifier;


- (NSString *)standardFontFamily;


- (void)setStandardFontFamily:(NSString *)family;


- (NSString *)fixedFontFamily;


- (void)setFixedFontFamily:(NSString *)family;


- (NSString *)serifFontFamily;


- (void)setSerifFontFamily:(NSString *)family;


- (NSString *)sansSerifFontFamily;


- (void)setSansSerifFontFamily:(NSString *)family;


- (NSString *)cursiveFontFamily;


- (void)setCursiveFontFamily:(NSString *)family;


- (NSString *)fantasyFontFamily;


- (void)setFantasyFontFamily:(NSString *)family;


- (int)defaultFontSize;


- (void)setDefaultFontSize:(int)size;


- (int)defaultFixedFontSize;


- (void)setDefaultFixedFontSize:(int)size;


- (int)minimumFontSize;


- (void)setMinimumFontSize:(int)size;


- (NSString *)defaultTextEncodingName;


- (void)setDefaultTextEncodingName:(NSString *)encoding;


- (BOOL)userStyleSheetEnabled;


- (void)setUserStyleSheetEnabled:(BOOL)flag;


- (NSURL *)userStyleSheetLocation;


- (void)setUserStyleSheetLocation:(NSURL *)URL;


- (BOOL)isJavaEnabled;


- (void)setJavaEnabled:(BOOL)flag;


- (BOOL)isJavaScriptEnabled;


- (void)setJavaScriptEnabled:(BOOL)flag;


- (BOOL)javaScriptCanOpenWindowsAutomatically;


- (void)setJavaScriptCanOpenWindowsAutomatically:(BOOL)flag;


- (BOOL)arePlugInsEnabled;


- (void)setPlugInsEnabled:(BOOL)flag;


- (BOOL)allowsAnimatedImages;


- (void)setAllowsAnimatedImages:(BOOL)flag;


- (BOOL)allowsAnimatedImageLooping;


- (void)setAllowsAnimatedImageLooping: (BOOL)flag;


- (void)setLoadsImagesAutomatically: (BOOL)flag;


- (BOOL)loadsImagesAutomatically;


- (void)setAutosaves:(BOOL)flag;


- (BOOL)autosaves;

|#

(provide-interface "WebPreferences")