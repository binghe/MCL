(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSEPSImageRep.h"
; at Sunday July 2,2006 7:30:46 pm.
; 
; 	NSEPSImageRep.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSImageRep.h>
#| @INTERFACE 
NSEPSImageRep : NSImageRep {
    
    NSPoint _bBoxOrigin;
    NSData *_epsData;
    NSPDFImageRep* _pdfImageRep;
}

+ (id)imageRepWithData:(NSData *)epsData;	
- (id)initWithData:(NSData *)epsData;

- (void)prepareGState;

- (NSData *)EPSRepresentation;

- (NSRect)boundingBox;

|#

(provide-interface "NSEPSImageRep")