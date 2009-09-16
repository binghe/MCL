(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SFChooseIdentityPanel.h"
; at Sunday July 2,2006 7:31:56 pm.
; 
; 	SFChooseIdentityPanel.h
; 	SecurityInterface
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
; #ifndef _SFCHOOSEIDENTITYPANEL_H_
; #define _SFCHOOSEIDENTITYPANEL_H_

; #import <Cocoa/Cocoa.h>

(require-interface "Security/SecIdentity")
; !
; 	@class SFChooseIdentityPanel 
;     @abstract SFChooseIdentityPanel is a panel and sheet interface that allows a user to pick from a list of identities that exist in the system.
; 
#| @INTERFACE 
SFChooseIdentityPanel : NSPanel
{
private
    IBOutlet NSTextField *_panelMessage;
    IBOutlet NSPopUpButton *_identityPopup;
    IBOutlet SFCertificateView *_certificateView;
    IBOutlet NSButton *_cancelButton;	
    IBOutlet NSButton *_okButton;	
    int _indexOfChosenIdentity;
    SecCertificateRef _currCertRefDisplayed;
    NSArray *_identities;
    NSWindow *_parentWindowForSheet;	
    IBOutlet NSWindow *_panel;
    SEL _clientDidEndSelector;
    id _clientDelegate;			
    void *_clientContextInfo;
    void *_reserved_SFChooseIdentityPanel;
}


+ (SFChooseIdentityPanel *)sharedChooseIdentityPanel;


- (int)runModalForIdentities:(NSArray *)identities message:(NSString *)message;


- (void)beginSheetForWindow:(NSWindow *)docWindow modalDelegate:(id)delegate didEndSelector:(SEL)didEndSelector contextInfo:(void *)contextInfo identities:(NSArray *)identities message:(NSString *)message;


- (SecIdentityRef)identity;

|#

; #endif /* !_SFCHOOSEIDENTITYPANEL_H_ */


(provide-interface "SFChooseIdentityPanel")