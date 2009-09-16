(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPrintInfo.h"
; at Sunday July 2,2006 7:30:56 pm.
; 
; 	NSPrintInfo.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSGeometry.h>

; #import <Foundation/NSObject.h>

; #import <AppKit/AppKitDefines.h>
;  Valid values for the NSPrintOrientation attribute.

(defconstant $NSPortraitOrientation 0)
(defconstant $NSLandscapeOrientation 1)
(def-mactype :NSPrintingOrientation (find-mactype ':SINT32))
;  Valid values for the NSPrintHorizontalPagination and NSPrintVerticalPagination attributes.

(defconstant $NSAutoPagination 0)
(defconstant $NSFitPagination 1)
(defconstant $NSClipPagination 2)
(def-mactype :NSPrintingPaginationMode (find-mactype ':SINT32))
;  Valid values for the NSPrintJobDisposition attribute.
(def-mactype :NSPrintSpoolJob (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintPreviewJob (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintSaveJob (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintCancelJob (find-mactype '(:pointer :NSString)))
;  Keys for page setup attributes that are recognized by NSPrintInfo.
(def-mactype :NSPrintPaperName (find-mactype '(:pointer :NSString)))
;  an NSString
(def-mactype :NSPrintPaperSize (find-mactype '(:pointer :NSString)))
;  an NSValue containing an NSSize, in points
(def-mactype :NSPrintOrientation (find-mactype '(:pointer :NSString)))
;  an NSNumber containing NSPortraitOrientation or NSLandscapeOrientation
(def-mactype :NSPrintScalingFactor (find-mactype '(:pointer :NSString)))
;  an NSNumber containing a floating-point percentage
;  Keys for pagination attributes that are recognized by NSPrintInfo.
(def-mactype :NSPrintLeftMargin (find-mactype '(:pointer :NSString)))
;  an NSNumber containing a measurement in floating-point points
(def-mactype :NSPrintRightMargin (find-mactype '(:pointer :NSString)))
;  an NSNumber containing a measurement in floating-point points
(def-mactype :NSPrintTopMargin (find-mactype '(:pointer :NSString)))
;  an NSNumber containing a measurement in floating-point points
(def-mactype :NSPrintBottomMargin (find-mactype '(:pointer :NSString)))
;  an NSNumber containing a measurement in floating-point points
(def-mactype :NSPrintHorizontallyCentered (find-mactype '(:pointer :NSString)))
;  an NSNumber containing a boolean value
(def-mactype :NSPrintVerticallyCentered (find-mactype '(:pointer :NSString)))
;  an NSNumber containing a boolean value
(def-mactype :NSPrintHorizontalPagination (find-mactype '(:pointer :NSString)))
;  an NSNumber containing NSAutoPagination, NSFitPagination, or NSClipPagination
(def-mactype :NSPrintVerticalPagination (find-mactype '(:pointer :NSString)))
;  an NSNumber containing NSAutoPagination, NSFitPagination, or NSClipPagination
;  Keys for print job attributes that are recognized by NSPrintInfo.
(def-mactype :NSPrintPrinter (find-mactype '(:pointer :NSString)))
;  an NSPrinter
(def-mactype :NSPrintCopies (find-mactype '(:pointer :NSString)))
;  an NSNumber containing the number of copies of the print job to be printed
(def-mactype :NSPrintAllPages (find-mactype '(:pointer :NSString)))
;  an NSNumber containing a boolean value
(def-mactype :NSPrintFirstPage (find-mactype '(:pointer :NSString)))
;  an NSNumber containing the one-based index of the first job in the page to print
(def-mactype :NSPrintLastPage (find-mactype '(:pointer :NSString)))
;  an NSNumber containing the one-based index of the last job in the page to print
(def-mactype :NSPrintMustCollate (find-mactype '(:pointer :NSString)))
;  an NSNumber containing a boolean value
(def-mactype :NSPrintReversePageOrder (find-mactype '(:pointer :NSString)))
;  an NSNumber containing a boolean value
(def-mactype :NSPrintJobDisposition (find-mactype '(:pointer :NSString)))
;  an NSString equal to NSPrintSpoolJob, NSPrintPreviewJob, NSPrintSaveJob, or NSPrintCancelJob
(def-mactype :NSPrintSavePath (find-mactype '(:pointer :NSString)))
;  an NSString containing a path to which the job file will be saved, for NSPrintSaveJob
#| @INTERFACE 
NSPrintInfo : NSObject<NSCopying, NSCoding> {
    private
    NSMutableDictionary *_attributes;
    void *_moreVars;
}

+ (void)setSharedPrintInfo:(NSPrintInfo *)printInfo;
+ (NSPrintInfo *)sharedPrintInfo;

- (id)initWithDictionary:(NSDictionary *)attributes;

- (NSMutableDictionary *)dictionary;

- (void)setPaperName:(NSString *)name;
- (void)setPaperSize:(NSSize)size;
- (void)setOrientation:(NSPrintingOrientation)orientation;
- (NSString *)paperName;
- (NSSize)paperSize;
- (NSPrintingOrientation)orientation;

- (void)setLeftMargin:(float)margin;
- (void)setRightMargin:(float)margin;
- (void)setTopMargin:(float)margin;
- (void)setBottomMargin:(float)margin;
- (float)leftMargin;
- (float)rightMargin;
- (float)topMargin;
- (float)bottomMargin;
- (void)setHorizontallyCentered:(BOOL)flag;
- (void)setVerticallyCentered:(BOOL)flag;
- (BOOL)isHorizontallyCentered;
- (BOOL)isVerticallyCentered;
- (void)setHorizontalPagination:(NSPrintingPaginationMode)mode;
- (void)setVerticalPagination:(NSPrintingPaginationMode)mode;
- (NSPrintingPaginationMode)horizontalPagination;
- (NSPrintingPaginationMode)verticalPagination;

- (void)setJobDisposition:(NSString *)disposition;
- (NSString *)jobDisposition;

- (void)setPrinter:(NSPrinter *)printer;
- (NSPrinter *)printer;

- (void)setUpPrintOperationDefaultValues;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (NSRect)imageablePageBounds;

#endif

#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (NSString *)localizedPaperName;

#endif

+ (NSPrinter *)defaultPrinter;

+ (void)setDefaultPrinter:(NSPrinter *)printer;

+ (NSSize)sizeForPaperName:(NSString *)name;

|#
;  Keys for attributes that were deprecated in Mac OS 10.2.  NSPrintInfo does not recognizes these attributes.  For backward binary compatibility, -[NSPrintInfo setUpPrintOperationDefaultValues] does however set default values for the NSPrintJobFeatures (an empty dictionary) and NSPrintPagesPerSheet (1) attributes.
(def-mactype :NSPrintFormName (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintJobFeatures (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintManualFeed (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintPagesPerSheet (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintPaperFeed (find-mactype '(:pointer :NSString)))
;  Keys for attributes that were deprecated in Mac OS X Public Beta.  NSPrintInfo does not recognizes these attributes.
(def-mactype :NSPrintFaxCoverSheetName (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintFaxHighResolution (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintFaxModem (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintFaxReceiverNames (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintFaxReceiverNumbers (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintFaxReturnReceipt (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintFaxSendTime (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintFaxTrimPageEnds (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintFaxUseCoverSheet (find-mactype '(:pointer :NSString)))
;  A job disposition that was deprecated in Mac OS X Public Beta.  NSPrintInfo treats this job disposition as synonymous with NSPrintSpoolJob.
(def-mactype :NSPrintFaxJob (find-mactype '(:pointer :NSString)))

(provide-interface "NSPrintInfo")