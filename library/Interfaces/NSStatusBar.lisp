(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSStatusBar.h"
; at Sunday July 2,2006 7:31:00 pm.
; 
;         NSStatusBar.h
;         Application Kit
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <Foundation/NSObject.h>
(defconstant $NSVariableStatusItemLength -1)
; #define	NSVariableStatusItemLength	(-1)
(defconstant $NSSquareStatusItemLength -2)
; #define	NSSquareStatusItemLength	(-2)
#| @INTERFACE 
NSStatusBar : NSObject
{
 private
    long      _fReserved1;
    long      _fReserved2;
    long      _fReserved3;
    long      _fReserved4;
}

+ (NSStatusBar*) systemStatusBar;

- (NSStatusItem*) statusItemWithLength:(float)length;
- (void) removeStatusItem:(NSStatusItem*)item;

- (BOOL)     isVertical;
- (float)    thickness;

|#

(provide-interface "NSStatusBar")