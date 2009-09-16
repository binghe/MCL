(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPDFImageRep.h"
; at Sunday July 2,2006 7:30:56 pm.
; 
;         NSPDFImageRep.h
;         Application Kit
;         Copyright (c) 1999-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSImageRep.h>
#| @INTERFACE 
NSPDFImageRep : NSImageRep
{
  private
    NSData* _pdfData;
    int     _reserved1;
    int     _reserved2;

    id      _private;
}

+ (id)imageRepWithData:(NSData*)pdfData;
- (id)initWithData:(NSData*)pdfData;

- (NSData*)PDFRepresentation;
- (NSRect)bounds;			
- (void) setCurrentPage:(int)page;	- (int)  currentPage;
- (int)  pageCount;

|#

(provide-interface "NSPDFImageRep")