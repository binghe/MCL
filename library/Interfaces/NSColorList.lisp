(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSColorList.h"
; at Sunday July 2,2006 7:30:38 pm.
; 
; 	NSColorList.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
;  An NSColorList is an ordered list of NSColors, identified by keys. These keys are used to identify the colors in the list and are used to display the color to the user in the color panel. Note that the key is only used in indentifying a color in a color list; it has nothing to do with the contents of the color, unless, of course the color list was set up in such a way that the keys matched the color names.
; 
; Instances of NSColorList are created for all user-created color lists (those in the color panel) and various color catalogs (such as Pantone) available on the system.
; 
; NSColorLists post "NSColorListDidChangeNotification" when changed.
; 

; #import <Foundation/NSObject.h>

; #import <AppKit/AppKitDefines.h>

; #import <CoreFoundation/CFDictionary.h>

(def-mactype :NSColorListAuxiliaryOpaque (find-mactype ':NSColorListAuxiliary))
#| @INTERFACE 
NSColorList : NSObject <NSCoding> {
    
    NSMutableArray *_keyArray;
    NSMutableArray *_colorArray;
    CFMutableDictionaryRef _keyToIndexTable;
    NSString *_name;
    NSString *_printerType;
    NSString *_fileName;
    struct _colorListFlags {
	unsigned int colorsLoaded:1;
	unsigned int editable:1;
	unsigned int hasDeviceSpecificLists:1;
	unsigned int dirty:1;
	unsigned int hasFrozen:1;
	unsigned int notificationsDisabled:1;
        unsigned int hasAttemptedLoadingBundleForDirectory:1;
	unsigned int :25;
    } _flags;
    NSColorListAuxiliaryOpaque *_clAuxiliaryStorage;
}


+ (NSArray *)availableColorLists;			


+ (NSColorList *)colorListNamed:(NSString *)name;


- (id)initWithName:(NSString *)name;			
- (id)initWithName:(NSString *)name fromFile:(NSString *)path;	


- (NSString *)name;


- (void)setColor:(NSColor *)color forKey:(NSString *)key;


- (void)insertColor:(NSColor *)color key:(NSString *)key atIndex:(unsigned)loc;


- (void)removeColorWithKey:(NSString *)key;


- (NSColor *)colorWithKey:(NSString *)key;


- (NSArray *)allKeys;


- (BOOL)isEditable;


- (BOOL)writeToFile:(NSString *)path;	


- (void)removeFile;

|#
;  Notifications 
(def-mactype :NSColorListDidChangeNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSColorList")