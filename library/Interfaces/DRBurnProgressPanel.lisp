(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRBurnProgressPanel.h"
; at Sunday July 2,2006 7:27:42 pm.
; 
;      File:       DiscRecordingUI/DRBurnProgressPanel.h
;  
;      Contains:   Panel to display progress while burning data to media.
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
; " Posted when the DRBurnProgressPanel is about to begin displaying progress.
; 
; 	This notification contains a notification object but no userInfo 
; 	dictionary. The notification object is the DRBurnProgressPanel that
; 	will be displayed.
; "
(def-mactype :DRBurnProgressPanelWillBeginNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; " Posted when the DRBurnProgressPanel has finished and is about to go away.
; 
; 	This notification contains a notification object but no userInfo 
; 	dictionary. The notification object is the DRBurnProgressPanel that
; 	will be closed.
; "
(def-mactype :DRBurnProgressPanelDidFinishNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; " A DRBurnProgressPanel object manages a panel that displays and updates burn progress. 
; 	The burn panel is responsible for begining the burn. You start the burn and
; 	display the progress panel on screen by calling #beginProgressSheetForBurn:modalForWindow:
; 	if you want a sheet interface, or beginProgressPanelForBurn: if you want a non-modal
; 	panel. 
; 	
; 	A DRBurnProgressPanel is able to send a #burnProgressPanel:burnDidFinish: message
; 	to it's delegate when the burn completes. This method allows the delegate to take over 
; 	end-of-burn handling from the burn progress panel to customize error dialogs or
; 	user notification. "
#| @INTERFACE 
DRBurnProgressPanel : NSPanel
{
    
	IBOutlet NSTextField*			_status;
	IBOutlet NSTextField*			_taskDescription;
	IBOutlet NSProgressIndicator*	_progress;
	IBOutlet NSImageView*			_icon;
	IBOutlet NSButton*				_stopButton;
	
	id						_owner;
	DRBurn*					_burnObject;
	NSSound*				_successSound;
	NSSound*				_failureSound;
	NSString*				_description;
 	BOOL					_verbose;
	NSString*				_curState;
}


+ (DRBurnProgressPanel*) progressPanel;


- (void) beginProgressSheetForBurn:(DRBurn*)burn layout:(id)layout modalForWindow:(NSWindow *)docWindow;
- (void) beginProgressPanelForBurn:(DRBurn*)burn layout:(id)layout;


- (void) setDescription:(NSString*)description;
- (NSString*) description;

- (void) setVerboseProgressStatus:(BOOL)verbose;
- (BOOL) verboseProgressStatus;


- (IBAction) stopBurn:(id)sender;

|#
#| @INTERFACE 
NSObject (DRBurnProgressPanelDelegateMethods)


- (void) burnProgressPanelWillBegin:(NSNotification*)aNotification;


- (void) burnProgressPanelDidFinish:(NSNotification*)aNotification;


- (BOOL) burnProgressPanel:(DRBurnProgressPanel*)theBurnPanel burnDidFinish:(DRBurn*)burn;

|#

(provide-interface "DRBurnProgressPanel")