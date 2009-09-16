(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSCustomImageRep.h"
; at Sunday July 2,2006 7:30:45 pm.
; 
; 	NSCustomImageRep.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSImageRep.h>
#| @INTERFACE 
NSCustomImageRep : NSImageRep {
    
    SEL _drawMethod;
    id _drawObject;
    unsigned int _reserved;
}

- (id)initWithDrawSelector:(SEL)aMethod delegate:(id)anObject;
- (SEL)drawSelector;
- (id)delegate;

|#

(provide-interface "NSCustomImageRep")