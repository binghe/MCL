(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSShadow.h"
; at Sunday July 2,2006 7:31:00 pm.
; 
; 	NSShadow.h
; 	Application Kit
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
;  NSShadow stores the properties of a drop shadow to be added to drawing.  

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
#| @INTERFACE 
NSShadow : NSObject <NSCopying, NSCoding> {
    
    unsigned int _shadowFlags;
    NSSize _shadowOffset;
    float _shadowBlurRadius;
    NSColor *_shadowColor;
    float _reservedFloat[3];
    void *_reserved;
}

- (id)init;     
- (NSSize)shadowOffset;  - (void)setShadowOffset:(NSSize)offset;

- (float)shadowBlurRadius;      - (void)setShadowBlurRadius:(float)val;

- (NSColor *)shadowColor;	- (void)setShadowColor:(NSColor *)color;

- (void)set;

|#

; #endif


(provide-interface "NSShadow")