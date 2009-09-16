(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SFKeychainSavePanel.h"
; at Sunday July 2,2006 7:31:56 pm.
; 
; 	SFKeychainSavePanel.h
; 	SecurityInterface
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
; #ifndef _SFKEYCHAINSAVEPANEL_H_
; #define _SFKEYCHAINSAVEPANEL_H_

; #import <AppKit/AppKit.h>

(require-interface "Security/SecKeychain")
; !
; 	@class SFKeychainSavePanel
;     @abstract SFKeychainSavePanel is a panel and sheet interface used to create a keychain using the NSSavePanel UI.
; 
#| @INTERFACE 
SFKeychainSavePanel : NSSavePanel 
{
private
    IBOutlet NSView *_customView;
    IBOutlet NSTextField *_message;
	NSString *_password;
	NSString *_kcFullPathName;
	NSString *_startPath;
	NSString *_keychainFileName;
    SecKeychainRef _returnedKeychain;
	NSWindow *_parentWindowForSheet;	
    SEL	_clientDidEndSelector;
	id	_clientDelegate;			
	void *_contextInfo;
    OSStatus _result;
    void *_reserved_SFKeychainSavePanel;
}


+ (SFKeychainSavePanel *)sharedKeychainSavePanel;


- (int)runModalForDirectory:(NSString *)path file:(NSString *)name;


- (void)setPassword:(NSString *)password;


- (SecKeychainRef)keychain;


- (void)beginSheetForDirectory:(NSString *)path file:(NSString *)name modalForWindow:(NSWindow *)docWindow modalDelegate:(id)delegate didEndSelector:(SEL)didEndSelector contextInfo:(void *)contextInfo;

|#

; #endif /* !_SFKEYCHAINSAVEPANEL_H_ */


(provide-interface "SFKeychainSavePanel")