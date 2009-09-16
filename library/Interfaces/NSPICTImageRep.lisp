(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPICTImageRep.h"
; at Sunday July 2,2006 7:30:56 pm.
; 
;         NSPICTImageRep.h
;         Application Kit
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSImageRep.h>
#| @INTERFACE 
NSPICTImageRep : NSImageRep
{
    
    NSPoint      _pictOrigin;		
    NSData*      _pictData;
    unsigned int _reserved1;
    unsigned int _reserved2;
}

+ (id)imageRepWithData:(NSData*)pictData;
- (id)initWithData:(NSData*)pictData;

- (NSData*) PICTRepresentation;
- (NSRect)  boundingBox;

|#

(provide-interface "NSPICTImageRep")