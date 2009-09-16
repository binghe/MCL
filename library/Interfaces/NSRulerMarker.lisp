(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSRulerMarker.h"
; at Sunday July 2,2006 7:30:57 pm.
; 
;         NSRulerMarker.h
;         Application Kit
;         Copyright (c) 1994-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>
#| @INTERFACE 
NSRulerMarker : NSObject <NSCopying, NSCoding> {
    
    NSRulerView *_ruler;
    float _location;
    NSImage *_image;
    NSPoint _imageOrigin;

    struct __rFlags {
        unsigned int movable:1;
        unsigned int removable:1;
        unsigned int dragging:1;
        unsigned int pinned:1;
        unsigned int _reserved:28;
    } _rFlags;

    id _representedObject;
}



- (id)initWithRulerView:(NSRulerView *)ruler markerLocation:(float)location image:(NSImage *)image imageOrigin:(NSPoint)imageOrigin;
    


- (NSRulerView *)ruler;
    

- (void)setMarkerLocation:(float)location;
- (float)markerLocation;
    
- (void)setImage:(NSImage *)image;
- (NSImage *)image;
    
- (void)setImageOrigin:(NSPoint)imageOrigin;
- (NSPoint)imageOrigin;
    
- (void)setMovable:(BOOL)flag;
- (void)setRemovable:(BOOL)flag;
- (BOOL)isMovable;
- (BOOL)isRemovable;
    
- (BOOL)isDragging;
    
- (void)setRepresentedObject:(id <NSCopying>)representedObject;
- (id <NSCopying>)representedObject;
    


- (NSRect)imageRectInRuler;
    
- (float)thicknessRequiredInRuler;
    
- (void)drawRect:(NSRect)rect;
    
- (BOOL)trackMouse:(NSEvent *)mouseDownEvent adding:(BOOL)isAdding;
    
|#

(provide-interface "NSRulerMarker")