(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSNibLoading.h"
; at Sunday July 2,2006 7:30:53 pm.
; 
; 	NSNibLoading.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSBundle.h>
#| @INTERFACE 
NSBundle(NSNibLoading)

+ (BOOL)loadNibFile:(NSString *)fileName externalNameTable:(NSDictionary *)context withZone:(NSZone *)zone;
    

+ (BOOL)loadNibNamed:(NSString *)nibName owner:(id)owner;
    

- (BOOL)loadNibFile:(NSString *)fileName externalNameTable:(NSDictionary *)context withZone:(NSZone *)zone;
    

|#
#| @INTERFACE 
NSObject (NSNibAwaking)
- (void)awakeFromNib;
|#

(provide-interface "NSNibLoading")