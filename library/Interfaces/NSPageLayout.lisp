(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPageLayout.h"
; at Sunday July 2,2006 7:30:55 pm.
; 
; 	NSPageLayout.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSApplication.h>

; #import <AppKit/NSPanel.h>		// For NSCancelButton & NSOKButton.

; #import <Foundation/NSObject.h>
; #ifndef WIN32
;  Tags for use with -viewWithTag:.  NSPAGELAYOUT IS NO LONGER A SUBCLASS OF NSPANEL.  THESE ARE ALL DEPRECATED.

(defconstant $NSPLImageButton 50)
(defconstant $NSPLTitleField 51)
(defconstant $NSPLPaperNameButton 52)
(defconstant $NSPLUnitsButton 54)
(defconstant $NSPLWidthForm 55)
(defconstant $NSPLHeightForm 56)
(defconstant $NSPLOrientationMatrix 57)
(defconstant $NSPLCancelButton $nscancelbutton)
(defconstant $NSPLOKButton $nsokbutton)
#| @INTERFACE 
NSPageLayout : NSObject

{

private

        unsigned char _184BytesOfPrivateData[184];
    
}

+ (NSPageLayout *)pageLayout;

- (void)beginSheetWithPrintInfo:(NSPrintInfo *)printInfo modalForWindow:(NSWindow *)docWindow delegate:(id)delegate didEndSelector:(SEL)didEndSelector contextInfo:(void *)contextInfo;

- (int)runModal;
- (int)runModalWithPrintInfo:(NSPrintInfo *)pInfo;

- (NSView *)accessoryView;
- (void)setAccessoryView:(NSView *)aView;

- (NSPrintInfo *)printInfo;
- (void)readPrintInfo;
- (void)writePrintInfo;

- (void)convertOldFactor:(float *)oldFactor newFactor:(float *)newFactor;
- (void)pickedButton:(id)sender;
- (void)pickedOrientation:(id)sender;
- (void)pickedPaperSize:(id)sender;
- (void)pickedUnits:(id)sender;

|#
;  interface NSPageLayout
#| @INTERFACE 
NSApplication(NSPageLayoutPanel)

- (void)runPageLayout:(id)sender;

|#
;  interface NSApplication(NSPageLayoutPanel)
#| 
; #else // WIN32
#| @INTERFACE 
NSPageLayout : NSObject

{

        void *_printdlg;
    NSPrintInfo *_printInfo;
    id _accessoryView;
    unsigned int _reservedPageLayout1;

}

+ (NSPageLayout *)pageLayout;

- (void)setAccessoryView:(NSView *)aView;
- (NSView *)accessoryView;
- (void)readPrintInfo;
- (void)writePrintInfo;
- (NSPrintInfo *)printInfo;
- (int)runModalWithPrintInfo:(NSPrintInfo *)pInfo;
- (int)runModal;

|#
;  interface NSPageLayout
#| @INTERFACE 
NSApplication(NSPageLayoutPanel)

- (void)runPageLayout:(id)sender;

|#
;  interface NSApplication(NSPageLayoutPanel)
 |#

; #endif // WIN32


(provide-interface "NSPageLayout")