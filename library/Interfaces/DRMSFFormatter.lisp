(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRMSFFormatter.h"
; at Sunday July 2,2006 7:27:43 pm.
; 
;      File:       DiscRecordingEngine/DRMSFFormatter.h
;  
;      Contains:   NSFormatter subclass to format DRMSF objects.
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 

; #import <Foundation/Foundation.h>
; !
; 	@class		DRMSFFormatter
; 	@abstract	NSFormatter subclass
; 	@discussion Instances of DRMSFFormatter format the textual representation of cells that contain 
; 				MSF objects and convert textual representations of msf values into MSF objects.
; 				DRMSFFormatters are typically instantiated in IB.
; 
#| @INTERFACE 
DRMSFFormatter : NSFormatter
{
    
	NSString*	_format;
}


- (id) initWithFormat:(NSString*)format;


- (NSString*) format;

- (void) setFormat:(NSString*)format;

|#

(provide-interface "DRMSFFormatter")