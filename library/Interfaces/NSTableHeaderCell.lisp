(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTableHeaderCell.h"
; at Sunday July 2,2006 7:31:01 pm.
; 
;         NSTableHeaderCell.h
;         Application Kit
;         Copyright (c) 1995-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSTextFieldCell.h>
#| @INTERFACE 
NSTableHeaderCell : NSTextFieldCell {

}

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

- (void)drawSortIndicatorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView ascending:(BOOL)ascending priority:(int)priority;
    
- (NSRect)sortIndicatorRectForBounds:(NSRect)theRect;
        
#endif

|#

(provide-interface "NSTableHeaderCell")