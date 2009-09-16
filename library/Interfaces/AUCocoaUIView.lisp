(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AUCocoaUIView.h"
; at Sunday July 2,2006 7:26:52 pm.
; 
;      File:       AUCocoaUIView.h
;  
;      Contains:   Specification of Protocol for Cocoa based UI Views for AudioUnits
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 

; #import <Cocoa/Cocoa.h>

(require-interface "AudioUnit/AudioUnit")
#| @PROTOCOL 
AUCocoaUIBase

- (unsigned) interfaceVersion;

- (NSView *) uiViewForAudioUnit:(AudioUnit)inAudioUnit withSize:(NSSize)inPreferredSize;

|#

(provide-interface "AUCocoaUIView")