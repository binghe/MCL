(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSMovie.h"
; at Sunday July 2,2006 7:30:53 pm.
; 
;         NSMovie.h
;         Application Kit
;         Copyright (c) 2000-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <Foundation/Foundation.h>
#| @INTERFACE 
NSMovie : NSObject <NSCopying, NSCoding> {
  private
    void*    _movie;
    NSURL*   _url;
    struct {
	int dispose:1;
	int reserved:31;
    } _movieFlags;
    long     _reserved1;
    long     _reserved2;
}

- (id) initWithMovie:(void* )movie;			- (id) initWithURL:(NSURL*)url byReference:(BOOL)byRef;	- (id) initWithPasteboard:(NSPasteboard*)pasteboard;

- (void*)QTMovie;
- (NSURL*)URL;

+ (NSArray*) movieUnfilteredFileTypes;
+ (NSArray*) movieUnfilteredPasteboardTypes;
+ (BOOL) canInitWithPasteboard:(NSPasteboard*)pasteboard;

|#

(provide-interface "NSMovie")