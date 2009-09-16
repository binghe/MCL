(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSFontDescriptor.h"
; at Sunday July 2,2006 7:30:48 pm.
; 
; 	NSFontDescriptor.h
; 	Application Kit
; 	Copyright (c) 2003-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <AppKit/AppKitDefines.h>

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
#| @INTERFACE 
NSFontDescriptor: NSObject <NSCopying, NSCoding> {

    NSMutableDictionary *_attributes;
    id _reserved1;
    id _reserved2;
    id _reserved3;
    id _reserved4;
    id _reserved5;
}

- (id)initWithFontAttributes:(NSDictionary *)attributes;
+ (id)fontDescriptorWithFontAttributes:(NSDictionary *)attributes;
+ (id)fontDescriptorWithName:(NSString *)fontName size:(float)size;
- (NSDictionary *)fontAttributes;
|#

; #endif

;  Predefined font attributes not defined in NSAttributedString.h 
(def-mactype :NSFontFamilyAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSFontNameAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSFontFaceAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSFontSizeAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSFontVisibleNameAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSFontColorAttribute (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER

(provide-interface "NSFontDescriptor")