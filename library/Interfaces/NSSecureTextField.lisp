(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSSecureTextField.h"
; at Sunday July 2,2006 7:30:59 pm.
; 
;         NSSecureTextField.h
;         Application Kit
;         Copyright (c) 1995-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSTextField.h>

; #import <AppKit/NSTextFieldCell.h>
#| @INTERFACE 
NSSecureTextField : NSTextField {

}
|#
#| @INTERFACE 
NSSecureTextFieldCell : NSTextFieldCell {

    private
    BOOL _echosBullets;
}

- (void)setEchosBullets:(BOOL)flag;
- (BOOL)echosBullets;

|#

(provide-interface "NSSecureTextField")