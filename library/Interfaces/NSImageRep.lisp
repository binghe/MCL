(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSImageRep.h"
; at Sunday July 2,2006 7:30:50 pm.
; 
; 	NSImageRep.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>

; #import <AppKit/AppKitDefines.h>
;  NSImageRepMatchesDevice indicates the value is variable, depending on the output device. It can be passed in (or received back) as the value of bitsPerSample, pixelsWide, and pixelsHigh.
; 

(defconstant $NSImageRepMatchesDevice 0)
#| @INTERFACE 
NSImageRep : NSObject <NSCopying, NSCoding> {
    
    struct __repFlags {
	unsigned int hasAlpha:1;
	unsigned int isOpaque:1;
        unsigned int cacheParamsComputed:1;
        unsigned int cacheAlphaComputed:1;
        unsigned int loadState:2;
        unsigned int reserved:2;
        unsigned int bitsPerSample:8;
	unsigned int gsaved:16;
    } _repFlags;
    NSString *_colorSpaceName;
    NSSize _size;
    int _pixelsWide;
    int _pixelsHigh;
}


- (BOOL)draw;
- (BOOL)drawAtPoint:(NSPoint)point;
- (BOOL)drawInRect:(NSRect)rect;


- (void)setSize:(NSSize)aSize;
- (NSSize)size;
- (void)setAlpha:(BOOL)flag;
- (BOOL)hasAlpha;
- (void)setOpaque:(BOOL)flag;
- (BOOL)isOpaque;
- (void)setColorSpaceName:(NSString *)string;
- (NSString *)colorSpaceName;
- (void)setBitsPerSample:(int)anInt;
- (int)bitsPerSample;
- (void)setPixelsWide:(int)anInt;
- (int)pixelsWide;
- (void)setPixelsHigh:(int)anInt;
- (int)pixelsHigh;




+ (void)registerImageRepClass:(Class)imageRepClass;
+ (void)unregisterImageRepClass:(Class)imageRepClass;
+ (NSArray *)registeredImageRepClasses;
+ (Class)imageRepClassForFileType:(NSString *)type;
+ (Class)imageRepClassForPasteboardType:(NSString *)type;
+ (Class)imageRepClassForData:(NSData *)data;
	

+ (BOOL)canInitWithData:(NSData *)data;


+ (NSArray *)imageUnfilteredFileTypes;
+ (NSArray *)imageUnfilteredPasteboardTypes;


+ (NSArray *)imageFileTypes;
+ (NSArray *)imagePasteboardTypes;


+ (BOOL)canInitWithPasteboard:(NSPasteboard *)pasteboard;


+ (NSArray *)imageRepsWithContentsOfFile:(NSString *)filename;
+ (id)imageRepWithContentsOfFile:(NSString *)filename;
+ (NSArray *)imageRepsWithContentsOfURL:(NSURL *)url;
+ (id)imageRepWithContentsOfURL:(NSURL *)url;
+ (NSArray *)imageRepsWithPasteboard:(NSPasteboard *)pasteboard;
+ (id)imageRepWithPasteboard:(NSPasteboard *)pasteboard;

|#
;  Notifications 
; #define NSImageRepRegistryChangedNotification NSImageRepRegistryDidChangeNotification /* obsolete name */
(def-mactype :NSImageRepRegistryDidChangeNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSImageRep")