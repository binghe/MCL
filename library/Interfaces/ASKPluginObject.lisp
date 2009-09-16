(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ASKPluginObject.h"
; at Sunday July 2,2006 7:26:39 pm.
; 	ASKPluginObject.h
; 	Copyright 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Cocoa/Cocoa.h>
#| @INTERFACE 
ASKPluginObject : NSObject 

+ (void)pluginDidLoad:(NSBundle *)bundle;

|#

(provide-interface "ASKPluginObject")