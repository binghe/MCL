(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRBurnSetupPanel.h"
; at Sunday July 2,2006 7:27:42 pm.
; 
;      File:       DiscRecordingUI/DRBurnSetupPanel.h
;  
;      Contains:   Panel to create and configure a DRBurn object.
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
; 	@class		DRBurnSetupPanel
; 	@abstract 	Manages a panel that allows users to specify the
; 				parameters of an burn.
; 	@discussion	This class supports choosing the the device to use, whether or not
; 				to verify the burned data and how to handle the burned disc when it completes.
; 
#| @INTERFACE 
DRBurnSetupPanel : DRSetupPanel
{
    
	IBOutlet id				_advancedItems;
	IBOutlet NSButton*		_expander;
	IBOutlet NSPopUpButton*	_burnSpeedPopup;
	IBOutlet NSButton*		_appendable;
	IBOutlet NSMatrix*		_completionActions;
	IBOutlet NSButton*		_testBurn;
	IBOutlet NSButton*		_verifyBurn;
	id						_state;
	float					_delta;
	IBOutlet NSButton*		_eraseDisc;
	void*					_unused;
	void*					_auxStorage;
}





+ (DRBurnSetupPanel*) setupPanel;





- (void) setDefaultButtonTitle:(NSString*)title;


- (void) setCanSelectTestBurn:(BOOL)flag;


- (void) setCanSelectAppendableMedia:(BOOL)flag;





- (DRBurn*) burnObject;





- (IBAction) expand:(id) sender;


- (IBAction) burnSpeed:(id) sender;


- (IBAction) appendable:(id) sender;


- (IBAction) completionAction:(id) sender;


- (IBAction) testBurn:(id) sender;


- (IBAction) verifyBurn:(id) sender;

|#
; !
; 	@const		DRBurnSetupPanelDefaultButtonDefaultTitle
; 	@discussion	Passing this to <b>setDefaultButtonTitle:</b> causes the panel to redisplay the 
; 				default button title.
; 
(def-mactype :DRBurnSetupPanelDefaultButtonDefaultTitle (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER

(provide-interface "DRBurnSetupPanel")