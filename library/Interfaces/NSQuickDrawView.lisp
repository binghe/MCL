(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSQuickDrawView.h"
; at Sunday July 2,2006 7:30:57 pm.
; 
;         NSQuickDrawView.h
;         Application Kit
;         Copyright (c) 1999-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSView.h>
#| @INTERFACE 
NSQuickDrawView : NSView
{
private
    void*  _qdPort;
    void*  _savePort;
    BOOL   _synchToView;
}

- (void*) qdPort;

|#

(provide-interface "NSQuickDrawView")