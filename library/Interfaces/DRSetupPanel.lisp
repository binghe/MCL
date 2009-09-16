(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRSetupPanel.h"
; at Sunday July 2,2006 7:27:43 pm.
; 
;      File:       DiscRecordingUI/DRSetupPanel.h
;  
;      Contains:   Base class for the DiscRecordingUI setup panels.
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

; #import <Cocoa/Cocoa.h>

; #import <DiscRecording/DiscRecording.h>

; #import <AvailabilityMacros.h>
; !
; 	@class		DRSetupPanel
; 	@discussion	This class is the base class for setup panels in the DiscRecordingUI
; 				framework. It provides a base framework for handling device
; 				selection, ejection and confirming or cancelling the panel.
; 
#| @INTERFACE 
DRSetupPanel : NSPanel
{
    
	IBOutlet NSButton*		_ok;
	IBOutlet NSButton*		_cancel;
	IBOutlet NSButton*		_eject;
	IBOutlet NSTextField*	_userMessage;
	IBOutlet NSImageView*	_icon;
	
	id						_owner;
	DRDevice*				_device;

	int						_reservation;
	id						_controller;
	id						_setupDelegate;
	SEL						_didEndSelector;
}





- (id) initWithNibName:(NSString*)nibName;





- (int) runSetupPanel;


- (void) beginSetupSheetForWindow:(NSWindow*)owner modalDelegate:(id)modalDelegate didEndSelector:(SEL)didEndSelector contextInfo:(void*)contextInfo;





- (IBAction) ok:(id)sender;


- (IBAction) cancel:(id)sender;


- (IBAction) eject:(id)sender;


- (IBAction) open:(id)sender;


- (IBAction) close:(id)sender;





- (void) deviceSelectionChanged:(DRDevice*)device;


- (BOOL) mediaStateChanged:(NSDictionary*)status;





- (void) setupForDisplay;

|#
; !
; 	@constant	DRSetupPanelDeviceSelectionChangedNotification
; 	@abstract	Type of notification sent when the device selection changes.
; 
(def-mactype :DRSetupPanelDeviceSelectionChangedNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	
; 	@constant	DRSetupPanelSelectedDeviceKey
; 	@abstract	Key in the userInfo dictionary when the
; 				DRSetupPanelDeviceSelectionChangedNotification is received.
; 
(def-mactype :DRSetupPanelSelectedDeviceKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@class		DRSetupPanelDelegate
; 	@abstract	The DRSetupPanelDelegate category defines a set of methods that
; 				delegates of the setup panels can implement to control the behavior of the panel.
; 
#| @INTERFACE 
NSObject(DRSetupPanelDelegate)


- (BOOL) setupPanel:(DRSetupPanel*)aPanel deviceCouldBeTarget:(DRDevice*)device;


- (void) setupPanelDeviceSelectionChanged:(NSNotification*)aNotification;


- (BOOL) setupPanelShouldHandleMediaReservations:(DRSetupPanel*)aPanel;


- (BOOL) setupPanel:(DRSetupPanel*)aPanel deviceContainsSuitableMedia:(DRDevice*)device promptString:(NSString**)prompt;

|#

(provide-interface "DRSetupPanel")