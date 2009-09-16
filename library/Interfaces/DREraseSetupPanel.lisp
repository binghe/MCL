(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DREraseSetupPanel.h"
; at Sunday July 2,2006 7:27:42 pm.
; 
;      File:       DiscRecordingUI/DREraseSetupPanel.h
;  
;      Contains:   Panel to create and configure a DRErase object.
;  
;       Version:   Technology: Mac OS X
;                  Release:    Mac OS X
;  
;     Copyright:   (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 

; #import <DiscRecording/DiscRecording.h>

; #import <DiscRecordingUI/DRSetupPanel.h>
; !
; 	@class			DREraseSetupPanel
; 	@abstract		Manages a panel that allows users to specify the
; 					parameters of an erase. 
; 	@discussion		This class supports choosing the 
; 					device to use and what sort of erase to perform.
; 					
; 					When the panel is closed by the user choosing to
; 					erase the media in the device, the device is
; 					exclusively held by the application for its own use
; 					to prevent possible bad or corrupt media from
; 					causing problem for the rest of the system. This
; 					means that if the erase object obtained from the
; 					panel is not used to do an erase, the device will
; 					remain unavailable to other applications until the
; 					esclusive access is released.
; 
#| @INTERFACE 
DREraseSetupPanel : DRSetupPanel
{
    
	IBOutlet NSMatrix*		_eraseTypes;

	id						_state;
	void*					_auxStorage;
}





+ (DREraseSetupPanel*) setupPanel;





- (DRErase*) eraseObject;





- (IBAction) eraseType:(id) sender;

|#

(provide-interface "DREraseSetupPanel")