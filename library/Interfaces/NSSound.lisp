(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSSound.h"
; at Sunday July 2,2006 7:31:00 pm.
; 
;         NSSound.h
; 	Application Kit
; 	Copyright (c) 1997-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSBundle.h>

; #import <AppKit/AppKitDefines.h>
(def-mactype :NSSoundPboardType (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSSound : NSObject <NSCopying, NSCoding> {
private
    id _delegate;
    void *_info;
    void *_reserved[7];
}

+ (id)soundNamed:(NSString *)name;
    

- (id)initWithContentsOfURL:(NSURL *)url byReference:(BOOL)byRef;
    

- (id)initWithContentsOfFile:(NSString *)path byReference:(BOOL)byRef;

- (id)initWithData:(NSData *)data;
    

- (BOOL)setName:(NSString *)string;
- (NSString *)name;

+ (BOOL)canInitWithPasteboard:(NSPasteboard *)pasteboard;
+ (NSArray *)soundUnfilteredFileTypes;
+ (NSArray *)soundUnfilteredPasteboardTypes;
- (id)initWithPasteboard:(NSPasteboard *)pasteboard;
- (void)writeToPasteboard:(NSPasteboard *)pasteboard;

- (BOOL)play;		
- (BOOL)pause;		
- (BOOL)resume;		
- (BOOL)stop;
- (BOOL)isPlaying;

- (id)delegate;
- (void)setDelegate:(id)aDelegate;

|#
#| @INTERFACE 
NSObject (NSSoundDelegateMethods)

- (void)sound:(NSSound *)sound didFinishPlaying:(BOOL)aBool;

|#
#| @INTERFACE 
NSBundle (NSBundleSoundExtensions)

- (NSString *)pathForSoundResource:(NSString *)name;
    

|#

(provide-interface "NSSound")