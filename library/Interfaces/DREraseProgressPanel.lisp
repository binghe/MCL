(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DREraseProgressPanel.h"
; at Sunday July 2,2006 7:27:42 pm.
; 
;      File:       DiscRecordingUI/DREraseProgressPanel.h
;  
;      Contains:   Panel to display progress while erasing media.
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
; " Posted when the DREraseProgressPanel is about to begin displaying progress.
; 
; 	This notification contains a notification object but no userInfo 
; 	dictionary. The notification object is the DREraseProgressPanel that
; 	will be displayed.
; "
(def-mactype :DREraseProgressPanelWillBeginNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; " Posted when the DREraseProgressPanel has finished and is about to go away.
; 
; 	This notification contains a notification object but no userInfo 
; 	dictionary. The notification object is the DREraseProgressPanel that
; 	will be closed.
; "
(def-mactype :DREraseProgressPanelDidFinishNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; " A DREraseProgressPanel object manages a panel that displays and updates erase progress. 
; 	The erase panel is responsible for begining the erase. You start the erase and
; 	display the progress panel on screen by calling #beginProgressSheetForErase:modalForWindow:
; 	if you want a sheet interface, or beginProgressPanelForErase: if you want a non-modal
; 	panel. 
; 	
; 	A DREraseProgressPanel is able to send an #eraseProgressPanel:eraseDidFinish: message
; 	to it's delegate when the erase completes. This method allows the delegate to take over 
; 	end-of-erase handling from the erase progress panel to customize error dialogs or
; 	user notification. "
#| @INTERFACE 
DREraseProgressPanel : NSPanel
{
    
	IBOutlet NSTextField*			_taskDescription;
	IBOutlet NSProgressIndicator*	_progress;
	IBOutlet NSImageView*			_icon;
	
	id						_owner;
	DRErase*				_eraseObject;
	NSSound*				_successSound;
	NSSound*				_failureSound;
	NSString*				_description;
}


+ (DREraseProgressPanel*) progressPanel;


- (void) beginProgressSheetForErase:(DRErase*)erase modalForWindow:(NSWindow *)docWindow;
- (void) beginProgressPanelForErase:(DRErase*)erase;


- (void) setDescription:(NSString*)description;
- (NSString*) description;

|#
#| @INTERFACE 
NSObject (DREraseProgressPanelDelegateMethods)


- (void) eraseProgressPanelWillBegin:(NSNotification*)aNotification;


- (void) eraseProgressPanelDidFinish:(NSNotification*)aNotification;


- (BOOL) eraseProgressPanel:(DREraseProgressPanel*)theErasePanel eraseDidFinish:(DRErase*)erase;

|#

(provide-interface "DREraseProgressPanel")