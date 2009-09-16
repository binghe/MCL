(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPreferencePane.h"
; at Sunday July 2,2006 7:30:56 pm.
; 
;  *  NSPreferencePane.h
;  *  PreferencePanes
;  *
;  *  Copyright (c) 2001 Apple. All rights reserved.
;  *
;  

; #import <Cocoa/Cocoa.h>
(def-mactype :NSPreferencePaneUnselectReply (find-mactype ':sint32))

(defconstant $NSUnselectCancel 0)
(defconstant $NSUnselectNow 1)
(defconstant $NSUnselectLater 2)
(def-mactype :NSPreferencePaneUnselectReply (find-mactype ':SINT32))
(def-mactype :NSPreferencePaneDoUnselectNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSPreferencePaneCancelUnselectNotification (find-mactype '(:pointer :NSString)))
;  Help Menu support
; #define	kNSPrefPaneHelpMenuInfoPListKey			@"NSPrefPaneHelpAnchors"
; #define	kNSPrefPaneHelpMenuTitleKey				@"title"		
; #define	kNSPrefPaneHelpMenuAnchorKey			@"anchor"				
#| @INTERFACE 
NSPreferencePane : NSObject
{
	private
										IBOutlet NSWindow *_window;
	
						IBOutlet NSView *_initialKeyView;
		IBOutlet NSView *_firstKeyView;
		IBOutlet NSView *_lastKeyView;
	
		NSView *_mainView;
		
		NSBundle *_bundle;
	
		id _reserved1;
		id _reserved2;
		id _reserved3;
}

- (id)initWithBundle:(NSBundle *) bundle;

- (NSBundle *) bundle;

- (NSView *) loadMainView;

- (void) mainViewDidLoad;

- (NSString *) mainNibName;

- (void) assignMainView;

- (void) willSelect;
- (void) didSelect;

- (NSPreferencePaneUnselectReply) shouldUnselect;

- (void) replyToShouldUnselect:(BOOL)shouldUnselect;

- (void) willUnselect;
- (void) didUnselect;

- (void) setMainView:(NSView *)view;

- (NSView *) mainView;

- (NSView *) initialKeyView;

- (void) setInitialKeyView:(NSView *)view;

- (NSView *) firstKeyView;

- (void) setFirstKeyView:(NSView *)view;

- (NSView *) lastKeyView;

- (void) setLastKeyView:(NSView *)view;

- (BOOL) autoSaveTextFields;

- (BOOL) isSelected;

- (void) updateHelpMenuWithArray:(NSArray *)inArrayOfMenuItems;
|#

(provide-interface "NSPreferencePane")