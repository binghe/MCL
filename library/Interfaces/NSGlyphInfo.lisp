(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSGlyphInfo.h"
; at Sunday July 2,2006 7:30:49 pm.
; 	
; 	NSGlyphInfo.h
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSString.h>

; #import <AppKit/NSFont.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2

(defconstant $NSIdentityMappingCharacterCollection 0);  Identity mapping (CID == NSGlyph)

(defconstant $NSAdobeCNS1CharacterCollection 1) ;  Adobe-CNS1

(defconstant $NSAdobeGB1CharacterCollection 2)  ;  Adobe-GB1

(defconstant $NSAdobeJapan1CharacterCollection 3);  Adobe-Japan1

(defconstant $NSAdobeJapan2CharacterCollection 4);  Adobe-Japan2

(defconstant $NSAdobeKorea1CharacterCollection 5);  Adobe-Korea1
(def-mactype :NSCharacterCollection (find-mactype ':SINT32))
#| @INTERFACE 
NSGlyphInfo : NSObject <NSCoding> {
    NSString *_baseString;
}

+ (NSGlyphInfo *)glyphInfoWithGlyphName:(NSString *)glyphName forFont:(NSFont *)font baseString:(NSString *)theString;

+ (NSGlyphInfo *)glyphInfoWithGlyph:(NSGlyph)glyph forFont:(NSFont *)font baseString:(NSString *)theString;

+ (NSGlyphInfo *)glyphInfoWithCharacterIdentifier:(unsigned int)cid collection:(NSCharacterCollection)characterCollection baseString:(NSString *)theString;

- (NSString *)glyphName;

- (unsigned int)characterIdentifier;

- (NSCharacterCollection)characterCollection;
|#

; #endif


(provide-interface "NSGlyphInfo")