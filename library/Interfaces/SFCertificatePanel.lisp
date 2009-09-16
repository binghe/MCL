(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SFCertificatePanel.h"
; at Sunday July 2,2006 7:31:55 pm.
; 
; 	SFCertificatePanel.h
; 	SecurityInterface
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
; #ifndef _SFCERTIFICATEPANEL_H_
; #define _SFCERTIFICATEPANEL_H_

; #import <Cocoa/Cocoa.h>

(require-interface "Security/SecCertificate")
; !
; 	@class SFCertificatePanel 
;     @abstract SFCertificatePanel is a panel and sheet interface that displays a certificate.
; 
#| @INTERFACE 
SFCertificatePanel : NSPanel
{
private
    IBOutlet SFCertificateView *_certView;
    IBOutlet NSWindow *_panel;
    IBOutlet NSButton *_okButton;	
	IBOutlet NSTableView *_certTable;
    NSWindow *_parentWindowForSheet;	
    SEL _clientDidEndSelector;
    id _clientDelegate;			
    void *_clientContextInfo;
    NSMutableArray *_certDataArray;
    void *_reserved_SFCertificatePanel;
}


+ (SFCertificatePanel *)sharedCertificatePanel;


- (int)runModalForCertificates:(NSArray *)certificates showGroup:(BOOL)showGroup;


- (void)beginSheetForWindow:(NSWindow *)docWindow modalDelegate:(id)delegate didEndSelector:(SEL)didEndSelector contextInfo:(void *)contextInfo certificates:(NSArray *)certificates showGroup:(BOOL)showGroup;

|#

; #endif /* !_SFCERTIFICATEPANEL_H_ */


(provide-interface "SFCertificatePanel")