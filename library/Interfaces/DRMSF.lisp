(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRMSF.h"
; at Sunday July 2,2006 7:27:43 pm.
; 
;      File:       DiscRecordingEngine/DRMSF.h
;  
;      Contains:   Minutes/Seconds/Frames handling.
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
; 	@class		DRMSF
; 	@abstract	Representation of a time interval expressed in minutes, seconds and frames. 
; 	@discussion	In CD/DVD-land, minutes/seconds/frames are used to identify positioning on a disc (which is 
; 				most useful on an audio disc), but applies to any position on a disc no matter what type of 
; 				data is present.
; 				
; 				A frame is equivalent to a sector or block in normal disk parlance. 75 frames make up one
; 				second, so a 2 second pause (typical pregap size) is 150 frames. 
; 
#| @INTERFACE 
DRMSF : NSNumber
{
	unsigned long _value;
}


+ (DRMSF*) msf;


+ (DRMSF*) msfWithFrames:(unsigned long)frames;


+ (DRMSF*) msfWithString:(NSString*)string;


- (id) initWithFrames:(unsigned long)frames;


- (id) initWithString:(NSString*)string;


- (unsigned long) minutes;


- (unsigned long) seconds;


- (unsigned long) frames;


- (unsigned long) sectors;


- (DRMSF*) msfByAdding:(DRMSF*)msf;


- (DRMSF*) msfBySubtracting:(DRMSF*)msf;


- (NSString*) description;


- (NSString*) descriptionWithFormat:(NSString*) format;


- (BOOL) isEqualToMSF:(DRMSF*)otherDRMSF;

|#

(provide-interface "DRMSF")