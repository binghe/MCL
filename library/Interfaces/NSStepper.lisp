(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSStepper.h"
; at Sunday July 2,2006 7:31:01 pm.
; 
;         NSStepper.h
;         Application Kit
;         Copyright (c) 2000-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSControl.h>
#| @INTERFACE 
NSStepper : NSControl {
  private
    unsigned int _reserved1;
    unsigned int _reserved2;
    unsigned int _reserved3;
    unsigned int _reserved4;
}

- (double)minValue;
- (void)setMinValue:(double)minValue;

- (double)maxValue;
- (void)setMaxValue:(double)maxValue;

- (double)increment;
- (void)setIncrement:(double)increment;

- (BOOL)valueWraps;
- (void)setValueWraps:(BOOL)valueWraps;

- (BOOL)autorepeat;
- (void)setAutorepeat:(BOOL)autorepeat;

|#

(provide-interface "NSStepper")