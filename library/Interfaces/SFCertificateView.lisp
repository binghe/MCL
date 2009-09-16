(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SFCertificateView.h"
; at Sunday July 2,2006 7:31:55 pm.
; 
; 	SFCertificateView.h
; 	SecurityInterface
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
; #ifndef _SFCERTIFICATEVIEW_H_
; #define _SFCERTIFICATEVIEW_H_

; #import <AppKit/AppKit.h>

(require-interface "Security/SecCertificate")
; !
; 	@class SFCertificateView
;     @abstract SFCertificateView is a NSView that displays the contents of a certificate.
; 
#| @INTERFACE 
SFCertificateView : NSView
{
private
    void *_reserved;
}


- (void)setCertificate:(SecCertificateRef)certificate;


- (SecCertificateRef)certificate;


- (void)setEditableTrust:(BOOL)editable;


- (BOOL)isEditable;


- (void)setDisplayTrust:(BOOL)display;


- (BOOL)isTrustDisplayed;


- (void)saveTrustSettings;

|#

; #endif /* !_SFCERTIFICATEVIEW_H_ */


(provide-interface "SFCertificateView")