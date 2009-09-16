(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SFKeychainSettingsPanel.h"
; at Sunday July 2,2006 7:31:56 pm.
; 
; 	SFKeychainSettingsPanel.h
; 	SecurityInterface
; 	Copyright (c) 2000-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
; #ifndef _SFKEYCHAINSETTINGSPANEL_H_
; #define _SFKEYCHAINSETTINGSPANEL_H_

; #import <Cocoa/Cocoa.h>

(require-interface "Security/SecKeychain")
; !
; 	@class SFKeychainSettingsPanel 
;     @abstract SFKeychainSettingsPanel is a panel and sheet interface that allows users to change their keychain settings.
; 
#| @INTERFACE 
SFKeychainSettingsPanel : NSPanel 
{
private
    IBOutlet NSTextField *_panelMessage;
    IBOutlet AutoLockTextValue *_autoLockValue;
    IBOutlet NSStepper *_autoLockStepper;
    IBOutlet NSButton *_autoLockCtrl;	
    IBOutlet NSButton *_lockOnSleepCtrl;	
    IBOutlet NSButton *_cancelButton;	
    IBOutlet NSButton *_saveButton;	
    IBOutlet NSWindow *_panel;
    NSString *_keychainNameStr;
    NSWindow *_parentWindowForSheet;	
    SEL _clientDidEndSelector;
    id _clientDelegate;			
    void *_clientContextInfo;
    unsigned long _lockIntervalVal;
	SecKeychainRef _keychainRef;
    BOOL _lockOnSleepVal;
    SecKeychainSettings _settings;
    void *_reserved_SFKeychainSettingsPanel;
}


+ (SFKeychainSettingsPanel *)sharedKeychainSettingsPanel;


- (int)runModalForSettings:(SecKeychainSettings *)settings keychain:(SecKeychainRef)keychain;


- (void)beginSheetForWindow:(NSWindow *)docWindow modalDelegate:(id)delegate didEndSelector:(SEL)didEndSelector contextInfo:(void *)contextInfo settings:(SecKeychainSettings *)settings keychain:(SecKeychainRef)keychain;

|#

; #endif /* !_SFKEYCHAINSETTINGSPANEL_H_ */


(provide-interface "SFKeychainSettingsPanel")