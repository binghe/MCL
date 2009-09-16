(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSNibConnector.h"
; at Sunday July 2,2006 7:30:53 pm.
; 
; 	NSNibConnector.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSNibConnector : NSObject <NSCoding>
{
    private
    id _source;		
    id _destination;	
    NSString *_label;	
}
- (id)source;
- (void)setSource:(id)source;
- (id)destination;
- (void)setDestination:(id)destination;
- (NSString *)label;
- (void)setLabel:(NSString *)label;
- (void)replaceObject:(id)oldObject withObject:(id)newObject;
- (void)establishConnection;
|#

(provide-interface "NSNibConnector")