(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPrintPanel.h"
; at Sunday July 2,2006 7:30:56 pm.
; 
; 	NSPrintPanel.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/AppKitDefines.h>

; #import <Foundation/NSObject.h>

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  Valid values for passing into -[NSPrintPanel setJobStyleHint:].
(def-mactype :NSPrintPhotoJobStyleHint (find-mactype '(:pointer :NSString)))

; #endif

;  Tags for use with -viewWithTag:.  NSPRINTPANEL IS NO LONGER A SUBCLASS OF NSPANEL.  THESE ARE ALL DEPRECATED.

(defconstant $NSPPSaveButton 3)
(defconstant $NSPPPreviewButton 4)
(defconstant $NSFaxButton 5)
(defconstant $NSPPTitleField 40)
(defconstant $NSPPImageButton 41)
(defconstant $NSPPNameTitle 42)
(defconstant $NSPPNameField 43)
(defconstant $NSPPNoteTitle 44)
(defconstant $NSPPNoteField 45)
(defconstant $NSPPStatusTitle 46)
(defconstant $NSPPStatusField 47)
(defconstant $NSPPCopiesField 49)
(defconstant $NSPPPageChoiceMatrix 50)
(defconstant $NSPPPageRangeFrom 51)
(defconstant $NSPPPageRangeTo 52)
(defconstant $NSPPScaleField 53)
(defconstant $NSPPOptionsButton 54)
(defconstant $NSPPPaperFeedButton 55)
(defconstant $NSPPLayoutButton 56)
#| @INTERFACE 
NSPrintPanel : NSObject

{

        unsigned char _244BytesOfPrivateData[244];

}

+ (NSPrintPanel *)printPanel;

- (void)beginSheetWithPrintInfo:(NSPrintInfo *)printInfo modalForWindow:(NSWindow *)docWindow delegate:(id)delegate didEndSelector:(SEL)didEndSelector contextInfo:(void *)contextInfo;

- (int)runModal;

- (NSView *)accessoryView;
- (void)setAccessoryView:(NSView *)aView;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (void)setJobStyleHint:(NSString *)hint;
- (NSString *)jobStyleHint;

#endif

- (void)updateFromPrintInfo;
- (void)finalWritePrintInfo;

- (void)pickedAllPages:(id)sender;
- (void)pickedButton:(id)sender;
- (void)pickedLayoutList:(id)sender;

|#
;  interface NSPrintPanel

(provide-interface "NSPrintPanel")