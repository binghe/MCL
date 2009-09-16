(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ScreenSaverDefaults.h"
; at Sunday July 2,2006 7:31:38 pm.
; 
; 	ScreenSaverDefaults.h
; 	ScreenSaver
; 	Copyright (c) 2000-2, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/Foundation.h>
#| @INTERFACE 
ScreenSaverDefaults : NSUserDefaults 
{
private
    void			*_reserved4;
    void			*_reserved5;
}

+ (id)defaultsForModuleWithName:(NSString*)moduleName;

|#

(provide-interface "ScreenSaverDefaults")