(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SFCertificateTrustPanel.h"
; at Sunday July 2,2006 7:31:55 pm.
; 
; 	SFCertificateTrustPanel.h
; 	SecurityInterface
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
; #ifndef _SFCERTIFICATETRUSTPANEL_H_
; #define _SFCERTIFICATETRUSTPANEL_H_

; #import <Cocoa/Cocoa.h>

; #import <SecurityInterface/SFCertificatePanel.h>

; #import <SecurityInterface/SFCertificateView.h>

(require-interface "Security/SecTrust")
; !
;     @class SFCertificateTrustPanel 
;     @abstract SFCertificateTrustPanel is a panel and sheet interface that allows a user to apply trust decisions to the trust configuration.
; 
#| @INTERFACE 
SFCertificateTrustPanel : SFCertificatePanel 
{
private
	IBOutlet NSSplitView *_splitView;		
	IBOutlet NSTextField *_messageView;		
	IBOutlet NSButton *_saveChangesButton;
    IBOutlet NSButton *_cancelButton;	
	NSString *_defaultMessage;
	BOOL _saveChanges;
	void *_reservedTrust;
}


+ (SFCertificateTrustPanel *)sharedCertificateTrustPanel;


- (int)runModalForTrust:(SecTrustRef)trust message:(NSString *)message;


- (void)beginSheetForWindow:(NSWindow *)docWindow modalDelegate:(id)delegate didEndSelector:(SEL)didEndSelector contextInfo:(void *)contextInfo trust:(SecTrustRef)trust message:(NSString *)message;

|#

; #endif /* !_SFCERTIFICATETRUSTPANEL_H_ */


(provide-interface "SFCertificateTrustPanel")