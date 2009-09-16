(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PMTicket.h"
; at Sunday July 2,2006 7:31:11 pm.
; 
;      File:       PMTicket.h
;  
;      Contains:   Mac OS X Printing Manager Job Ticket Interfaces.
;  
;      Version:    Technology: Mac OS X
;                  Release:    1.0
;  
;      Copyright:  © 1998-2002 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __PMTICKET__
; #define __PMTICKET__
; #ifndef __APPLICATIONSERVICES__
#| #|
	#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef	__PMERRORS__
#| #|
	#include <PrintCorePMErrors.h>
#endif
|#
 |#
; #ifndef __COREFOUNDATION__

(require-interface "CoreFoundation/CoreFoundation")

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
;  SECTION I: DATA TYPES, STUCTURES, and CONSTANTS 
;  General opaque Ticket object reference. This is returned when you create a PageFormat, 
;  PrintSettings, DocumentInfo, JobInfo, or JobTicket. A list of Job Tickets or other 
;  tickets can be saved as a list of references. 

(def-mactype :PMTicketRef (find-mactype '(:pointer :OpaquePMTicketRef)))

(def-mactype :PMTemplateRef (find-mactype '(:pointer :OpaquePMTemplateRef)))
;  Constant that will be useful in calling Job Ticket functions. 
; #define kPMDontFetchItem    NULL            /* Used to ask GetItem if an item exists. */
;  The following constant determines if the ticket code sets an item in the top level ticket 
;  or down in some sub-ticket within the top level ticket. If passed as the document number, 
;  the ticket code will simply set the item in the ticket passed. If the document number is 
;  non "kTopLevel" but the page number is "kTopLevel", the ticket code will set the item in the 
;  document level sub-ticket. If both parameters are non "kTopLevel", the ticket code will set 
;  the item in the correct sub ticket for the document and page. 
;  For now, all calls should use kPMTopLevel for document and page numbers, or the passed in 
;  docment and page numbers if they are available. In the future we expect to enable embedded 
;  document and page tickets. 
(defconstant $kPMTopLevel 0)
; #define kPMTopLevel ((UInt32)0)
;  There are several different types of tickets that use the same accessor functions and  
;   allow the programmer to use different keys to access the proper fields in each ticket. 
;       A Job Ticket has the following structure: 
;           Job Ticket 
;               Job Ticket Fields 
;               Page Format Ticket (required) 
;                   Paper Info Ticket (required) 
;               Print Settings Ticket (required) 
;                   Paper Info Ticket (required) 
;  DOWNSTREAM TICKETS - Heading from PC or PJC to other modules. 
; #define kPMJobTicket                CFSTR( "com.apple.print.JobTicket" )
; #define kPMDocumentTicket           CFSTR( "com.apple.print.DocumentTicket" )
; #define kPMPageTicket               CFSTR( "com.apple.print.PageTicket" )
; #define kPMPageFormatTicket         CFSTR( "com.apple.print.PageFormatTicket" )
; #define kPMPrintSettingsTicket      CFSTR( "com.apple.print.PrintSettingsTicket" )
; #define kPMDestinationTicket        CFSTR( "com.apple.print.DestinationTicket" )
; #define kPMConverterSetupTicket     CFSTR( "com.apple.print.ConverterSetupTicket" )
;  UPSTREAM TICKETS - Expected to be created by low level modules and passed up. 
; #define kPMPrinterInfoTicket        CFSTR( "com.apple.print.PrinterInfoTicket" )
; #define kPMModuleInfoTicket         CFSTR( "com.apple.print.ModuleInfoTicket" )
;  OTHER TICKETS, going either direction 
; #define kPMTicketList               CFSTR( "com.apple.print.TicketList" ) 
; #define kPMPaperInfoTicket          CFSTR( "com.apple.print.PaperInfoTicket" ) 
;  An enum to keep track in a programmatic way of which type of ticket we're working 
;  with. These do not need to match up with the order of tickets listed in the ticket 
;  types in PMTicket.h because we convert from string to enum in an internal function. 
;  NOTE: If this list is added to, a couple different functions in PMTicket.c and 
;        PMTicketInternal.c need to be updated. 
;  Warning: Don't user these tags when creating tickets.  Use the CFSTRs above. 

(def-mactype :PMTicketType (find-mactype ':SInt16))

(defconstant $kPMTicketTypeUnknown -1)
(defconstant $kPMJobTicketType 1)
(defconstant $kPMDocumentTicketType 2)
(defconstant $kPMPageTicketType 3)
(defconstant $kPMPageFormatTicketType 4)
(defconstant $kPMPrintSettingsTicketType 5)
(defconstant $kPMPrinterInfoTicketType 6)
(defconstant $kPMDestinationTicketType 7)
(defconstant $kPMConverterSetupTicketType 8)
(defconstant $kPMModuleInfoTicketType 9)
(defconstant $kPMTicketListType 10)
(defconstant $kPMPaperInfoTicketType 11)
;  An enum to demark where in the printing process we are. This value will be stored in the 
;  print settings ticket at the top level in the Job Ticket. It will be used to signal shift 
;  from one phase to the next and may be set by just about any part of the system. Users will 
;  want to check for ">" (greater than) or "<" (less than) conditions when possible, allowing 
;  for additional phases to be defined later on. 

(def-mactype :PMPrintingPhaseType (find-mactype ':UInt16))

(defconstant $kPMPhaseUnknown 0)                ;  Not clear what phase we're in yet. 

(defconstant $kPMPhasePreDialog 1)              ;  Just before we execute the code to open the dialog. 

(defconstant $kPMPhaseDialogsUp 2)              ;  One of the dialogs is in front of the user. 

(defconstant $kPMPhasePostDialogs 3)            ;  Dialogs are down, not yet spooling. 

(defconstant $kPMPhasePreAppDrawing 4)          ;  Just before we begin to spool 

(defconstant $kPMPhaseAppDrawing 5)             ;  We're spooling drawing commands from the app. 

(defconstant $kPMPhasePostAppDrawing 6)         ;  Finished with spooling, not yet rendering or converting. 

(defconstant $kPMPhasePreConversion 7)          ;  Just before we begin to convert to PS, Raster, or other final format. 

(defconstant $kPMPhaseConverting 8)             ;  Converting from Spool file to final printer format. 

(defconstant $kPMPhasePostConversion 9)         ;  Done with printer ready data, waiting for completion. 

(defconstant $kPMPhasePrinting 10)              ;  In the process of waiting for the printer. 


(def-mactype :PMTicketErrors (find-mactype ':SInt16))
;  BATCH PROCESSING ENUMS AND STRUCTURES  
;  - Look in this section for help creating statically defined tickets. 
;  We have the ability to create a Ticket from an array of key/item pairs that define 
;  the keys and items for the entries in the ticket. To facilitate easy conversion of 
;  these key/item pairs, we've defined a few constants to help in the batch processing of 
;  these arrays. These are basically key types that are allowed for batch processing. 

(def-mactype :PMTicketItemType (find-mactype ':UInt16))

(defconstant $kPMItemInvalidType 0)
(defconstant $kPMItemCStringType 1)             ;  a C string pointed to by a char* 

(defconstant $kPMItemSInt32Type 2)              ;  a C signed 32 bit integer. 

(defconstant $kPMItemBooleanType 3)             ;  A Boolean 

(defconstant $kPMItemCStrListType 4)            ;  A list of c-strings. 

(defconstant $kPMItemPMRectType 5)              ;  A pointer to a PMRect 

(defconstant $kPMItemSInt32ListType 6)          ;  A pointer to a SInt32List 

(defconstant $kPMItemPMRectListType 7)          ;  A pointer to a PMRectList 

;  A structure that holds a list of CString pointers, along with a definition for a constant list. 
(defrecord CStrList
   (count :SInt32)                              ;  Number of CString pointers in the array. 
   (** (:pointer :callback))                    ;(char strArray)
                                                ;  Pointer to first CString pointer. 
)

;type name? (%define-record :CStrList (find-record-descriptor ':CStrList))

(%define-record :ConstCStrList (find-record-descriptor ':CStrList))
;  A structure to hold a list of Signed 32 bit integers.  
(defrecord SInt32List
   (count :SInt32)                              ;  Number of Signed 32 bit values in array. 
   (sInt32Array (:pointer :SInt32))             ;  Pointer to the first 32 bit value in array. 
)

;type name? (%define-record :SInt32List (find-record-descriptor ':SInt32List))

(%define-record :ConstSInt32List (find-record-descriptor ':SInt32List))
;  A structure to hold a list of PMRect structures. PMRect is defined in PMDefinitions.h 
;  and is basically a set of four doubles (top, left, bottom, and right). 
(defrecord PMRectList
   (count :SInt32)                              ;  Number of PMRect pointers in the array. 
   (** (:pointer :callback))                    ;(PMRect pmRectArray)
                                                ;  Pointer to the first PMRect pointer. 
)

;type name? (%define-record :PMRectList (find-record-descriptor ':PMRectList))

(%define-record :ConstPMRectList (find-record-descriptor ':PMRectList))
;  CF types can't be statically initialized, but CString and Pascal strings can be. 
;  We have created utilities to convert from static C and Pascal based data into CF types. 
;  The structure below will serve as a statically defined "Ticket Item" that can then be 
;  converted into a job ticket item. An array of these structures would be made into a ticket. 
(defrecord PMTicketItemStruct
   (key (:pointer :char))                       ;  The CString for the key. 
   (itemType :UInt16)                           ;  What type of item is being defined in union below. 
   (locked :Boolean)                            ;  Can other callers change this after it's entered in a ticket? 
   (:variant
                                                ;  The item data itself. 
   (
   (GenericData :pointer)
   )
                                                ;  Generic data 
   (
   (cString (:pointer :char))
   )
                                                ;  kPMItemCStringType 
   (
   (sInt32 :SInt32)
   )
                                                ;  kPMItemSInt32Type 
   (
   (boolean :UInt32)
   )
                                                ;  kPMItemBooleanType 
   (
   (cStrlist (:pointer :CONSTCSTRLIST))
   )
                                                ;  kPMItemCStrListType 
   (
   (rect (:pointer :PMRect))
   )
                                                ;  kPMItemPMRectType 
   (
   (sInt32List (:pointer :CONSTSINT32LIST))
   )
                                                ;  kPMItemSInt32ListType 
   (
   (pmRectList (:pointer :CONSTPMRECTLIST))
   )
                                                ;  kPMItemPMRectListType 
   )
)

;type name? (%define-record :PMTicketItemStruct (find-record-descriptor ':PMTicketItemStruct))
;  END OF BATCH PROCESSING ENUMS AND STRUCTURES 
;  ENUMS for Ticket Values 
;  The values for kPMDuplexingKey 

(defconstant $kPMDuplexNone 1)                  ;  Print on both sides of the paper, pages flip from left to right.

(defconstant $kPMDuplexNoTumble 2)              ;  Print on both sides of the paper, tumbling on so pages flip top to bottom.

(defconstant $kPMDuplexTumble 3)                ;  Print on only one side of the paper, but tumble the images while printing.

(defconstant $kPMSimplexTumble 4)
;  If the kPMDuplexingKey is not in a ticket then kPMDuplexDefault should be assumed.
;  
(defconstant $kPMDuplexDefault 1)
; #define	kPMDuplexDefault	(kPMDuplexNone)
;  The values for kPMCoverPageKey 

(defconstant $kPMCoverPageNone 1)               ;  Print a cover page before printing the document.

(defconstant $kPMCoverPageBefore 2)             ;  Print a cover page after printing the document.

(defconstant $kPMCoverPageAfter 3)
;  If the kPMDuplexingKey is not in a ticket then kPMDuplexDefault should be assumed.
;  
(defconstant $kPMCoverPageDefault 1)
; #define	kPMCoverPageDefault	(kPMCoverPageNone)
;  Values for the kPMPSErrorHandlerKey 

(defconstant $kPSNoErrorHandler 0)
(defconstant $kPSErrorHandler 1)
;  If the kPMCopyCollateKey is not present, then kPMCopyCollateDefault should be assumed. 
; #define kPMCopyCollateDefault	(true)
;  END OF SECTION I: DATA TYPES, STUCTURES, and CONSTANTS 
;  SECTION II: TICKET KEYS 
;  - Look in this section for particular predefined keys for various tickets. 
;  Each key is defined to store it's data as a particular CF type, but there are some  
;   utilities defined to fetch data in different formats. For instance, it would be simple 
;   to read in the Job Name as a CFString, or as a 'C' string. 
;  Ticket: PAPER INFO TICKET
;     This ticket contains a single Paper Info set, with all the information necessary to 
;     describe a paper type available from the Printer Module.
; 
(defconstant $kPMPaperInfoPrelude "com.apple.print.PaperInfo.")
; #define kPMPaperInfoPrelude                 "com.apple.print.PaperInfo."
; #define kPMPaperNameStr                     kPMPaperInfoPrelude "PMPaperName"
; #define kPMPaperNameKey                     CFSTR( kPMPaperNameStr )                    /* CFString for the name of the paper displayed in UI */
; #define kPMPPDPaperNameStr		    kPMPaperInfoPrelude "ppd.PMPaperName"
; #define kPMPPDPaperNameKey		    CFSTR( kPMPPDPaperNameStr )			/* CFString for the PPD name of the paper. */
; #define kPMUnadjustedPaperRectStr           kPMPaperInfoPrelude "PMUnadjustedPaperRect"
; #define kPMUnadjustedPaperRectKey           CFSTR( kPMUnadjustedPaperRectStr )          /* CFArray of 4 CFNumbers of kCFNumberDoubleType for paper size in points. */
; #define kPMUnadjustedPageRectStr            kPMPaperInfoPrelude "PMUnadjustedPageRect"
; #define kPMUnadjustedPageRectKey            CFSTR( kPMUnadjustedPageRectStr )           /* CFArray of 4 CFNumbers of kCFNumberDoubleType for page size within the paper, in points. */
; #define kPMMatchPaperStr            		kPMPaperInfoPrelude "PMMatchPaper"
; #define kPMMatchPaperKey            		CFSTR( kPMMatchPaperStr )           		/* CFBoolean tells if we need to find a closest match for this paper */
; #define kPMConstrainedPaperStr            	kPMPaperInfoPrelude "PMConstrainedPaper"
; #define kPMConstrainedPaperKey            	CFSTR( kPMConstrainedPaperStr )           	/* CFBoolean tells if this paper is constrained */
;  Ticket: PAGE FORMAT TICKET
;     Describes the application's drawing environment, including resolution, scaling, and
;     orientation. All information in the page format ticket is saved with the user's document,
;     so the single paper info stored inside the page format ticket describes the logical page
;     an application may draw to. This logical page is then mapped to a physical page defined
;     in the Print Settings Ticket.
; 
(defconstant $kPMPageFormatPrelude "com.apple.print.PageFormat.")
; #define kPMPageFormatPrelude                "com.apple.print.PageFormat."
; #define kPMAdjustedPaperRectStr             kPMPageFormatPrelude "PMAdjustedPaperRect"
; #define kPMAdjustedPaperRectKey             CFSTR( kPMAdjustedPaperRectStr )            /* CFArray of 4 CFNumbers of kCFNumberDoubleType for scaled and rotated page rectangle. */
; #define kPMAdjustedPageRectStr              kPMPageFormatPrelude "PMAdjustedPageRect"
; #define kPMAdjustedPageRectKey              CFSTR( kPMAdjustedPageRectStr )             /* CFArray of 4 CFNumbers of kCFNumberDoubleType for scaled and rotated page rectangle, in points. */
; #define kPMDrawingResHorizontalStr          kPMPageFormatPrelude "PMHorizontalRes"
; #define kPMDrawingResHorizontalKey          CFSTR( kPMDrawingResHorizontalStr )         /* CFNumber - kCFNumberDoubleType, Drawing resolution in horizontal direction. */
; #define kPMDrawingResVerticalStr            kPMPageFormatPrelude "PMVerticalRes"
; #define kPMDrawingResVerticalKey            CFSTR( kPMDrawingResVerticalStr )           /* CFNumber - kCFNumberDoubleType, Drawing resolution in vertical direction. */
; #define kPMPageScalingHorizontalStr         kPMPageFormatPrelude "PMScaling"
; #define kPMPageScalingHorizontalKey         CFSTR( kPMPageScalingHorizontalStr )        /* CFNumber - kCFNumberDoubleType, Horizontal scaling factor applied to original page size - 1 = 100% */
; #define kPMPageScalingVerticalStr           kPMPageFormatPrelude "PMVerticalScaling"
; #define kPMPageScalingVerticalKey           CFSTR( kPMPageScalingVerticalStr )          /* CFNumber - kCFNumberDoubleType, Vertical scaling factor applied to original page size - 1 = 100%. */
; #define kPMPageOrientationStr               kPMPageFormatPrelude "PMOrientation"
; #define kPMPageOrientationKey               CFSTR( kPMPageOrientationStr )              /* CFNumber - kCFNumberSInt32Type, PMOrientation, 1 = portrait, 2 = landscape, 3 = reverse landscape, 4 = reverse portrait. */
; #define kPMPageBackupRecordHdlStr           kPMPageFormatPrelude "BackupPrintRecordHandle"
; #define kPMPageBackupRecordHdlKey           CFSTR( kPMPageBackupRecordHdlStr )          /* CFData - Print record handle, allowing easy access during most calls. Not used when flattened. (OS8 Only) */
; #define kPMPageBackupRecordDataStr          kPMPageFormatPrelude "BackupPrintRecord"
; #define kPMPageBackupRecordDataKey          CFSTR( kPMPageBackupRecordDataStr )         /* CFData - Print record stored in complete form - used when flattening Ticket w/ record. (OS8 only) */
; #define kPMPageCustomDialogHdlStr           kPMPageFormatPrelude "CustomDialogRecord"
; #define kPMPageCustomDialogHdlKey           CFSTR( kPMPageCustomDialogHdlStr )      	/* CFData - Handle to the print record using for custom dialog calls. Not stored when flattened. (OS8 Only) */
; #define kPMFormattingPrinterStr          	kPMPageFormatPrelude "FormattingPrinter"
; #define kPMFormattingPrinterKey          	CFSTR( kPMFormattingPrinterStr )      		/* CFString - name of the formating printer */
;  Ticket: PRINT SETTINGS TICKET
;     Contains the user's print dialog selections. Includes items set by the application to
;     further refine the output produced on the printer. Information in this ticket may also
;     be saved with the decument, but are likely to be overwritten by any saved settings. 
;     Logical page information is mapped to the physical page defined in this ticket.
; 
(defconstant $kPMPrintSettingsPrelude "com.apple.print.PrintSettings.")
; #define kPMPrintSettingsPrelude             "com.apple.print.PrintSettings."
; #define kPMDestinationTypeStr               kPMPrintSettingsPrelude "PMDestinationType"
; #define kPMDestinationTypeKey               CFSTR( kPMDestinationTypeStr )              /* CFNumber, kCFNumberSInt32Type kPMDestinationPrinter kPMDestinationFile kPMDestinationFax. */
; #define kPMOutputFilenameStr                kPMPrintSettingsPrelude "PMOutputFilename"
; #define kPMOutputFilenameKey                CFSTR( kPMOutputFilenameStr )               /* CFString - URL for the output filename. */
; #define kPMCopiesStr                        kPMPrintSettingsPrelude "PMCopies"
; #define kPMCopiesKey                        CFSTR( kPMCopiesStr )                       /* CFNumber, kCFNumberSInt32Type, number of copies to print. */
; #define kPMCopyCollateStr                   kPMPrintSettingsPrelude "PMCopyCollate"
; #define kPMCopyCollateKey                   CFSTR( kPMCopyCollateStr )                  /* CFBoolean, Turns on collating */
(defconstant $kPMOutputOrderStr "OutputOrder")
; #define kPMOutputOrderStr		   "OutputOrder"
; #define kPMOutputOrderKey		    CFSTR(kPMOutputOrderStr)			/* CFString, Reverse or Normal. default is Printer Specific */
(defconstant $kPMPageSetStr "page-set")
; #define kPMPageSetStr		   	    "page-set"
; #define kPMPageSetKey			    CFSTR(kPMPageSetStr)	/* CFString, even, odd, or all. default is all */
; #define kPMPageRangeStr                     kPMPrintSettingsPrelude "PMPageRange"
; #define kPMPageRangeKey                     CFSTR( kPMPageRangeStr )                    /* CFArray of kCFNumberSInt32Type, each pair indicating valid range of pages that the application is able to print. Does not signify user choices. */
; #define kPMFirstPageStr                     kPMPrintSettingsPrelude "PMFirstPage"
; #define kPMFirstPageKey                     CFSTR( kPMFirstPageStr )                    /* CFNumber - kCFNumberSInt32Type, first page selected by user to print. */
; #define kPMLastPageStr                      kPMPrintSettingsPrelude "PMLastPage"
; #define kPMLastPageKey                      CFSTR( kPMLastPageStr )                     /* CFNumber - kCFNumberSInt32Type, last page selected by user to print. */
; #define kPMBorderStr                        kPMPrintSettingsPrelude "PMBorder"
; #define kPMBorderKey                        CFSTR( kPMBorderStr )                       /* CFBoolean - If true, we do borders. */
; #define kPMBorderTypeStr                    kPMPrintSettingsPrelude "PMBorderType"
; #define kPMBorderTypeKey                    CFSTR( kPMBorderTypeStr )                   /* CFNumber - kCFNumberSInt32Type, Enum (PMBorderType) */
; #define kPMLayoutNUpStr                     kPMPrintSettingsPrelude "PMLayoutNUp"
; #define kPMLayoutNUpKey                     CFSTR( kPMLayoutNUpStr )                    /* CFBoolean, Turns on N-Up layout. */
; #define kPMLayoutRowsStr                    kPMPrintSettingsPrelude "PMLayoutRows"
; #define kPMLayoutRowsKey                    CFSTR( kPMLayoutRowsStr )                   /* CFNumber - kCFNumberSInt32Type, indicates number of layout rows. */
; #define kPMLayoutColumnsStr                 kPMPrintSettingsPrelude "PMLayoutColumns"
; #define kPMLayoutColumnsKey                 CFSTR( kPMLayoutColumnsStr )                /* CFNumber - kCFNumberSInt32Type, indicates number of layout columns. */
; #define kPMLayoutDirectionStr               kPMPrintSettingsPrelude "PMLayoutDirection"
; #define kPMLayoutDirectionKey               CFSTR( kPMLayoutDirectionStr )              /* CFNumber - kCFNumberSInt32Type, Enum (PMLayoutDirection) */
; #define kPMLayoutTileOrientationStr         kPMPrintSettingsPrelude "PMLayoutTileOrientation"
; #define kPMLayoutTileOrientationKey         CFSTR( kPMLayoutTileOrientationStr )        /* CFNumber - kCFNumberSInt32Type, PMOrientation, 1 = portrait, 2 = landscape, etc. */
; #define kPMQualityStr                       kPMPrintSettingsPrelude "PMQuality"
; #define kPMQualityKey                       CFSTR( kPMQualityStr )                      /* CFNumber - kCFNumberSInt32Type, Enum, draft, normal, best */
; #define kPMPaperTypeStr                     kPMPrintSettingsPrelude "PMPaperType"
; #define kPMPaperTypeKey                     CFSTR( kPMPaperTypeStr )                    /* CFNumber - kCFNumberSInt32Type, Enum, draft, normal, best */
; #define kPMJobStateStr                      kPMPrintSettingsPrelude "PMJobState"
; #define kPMJobStateKey                      CFSTR( kPMJobStateStr )                     /* CFNumber - kCFNumberSInt32Type, Enum, active = 0, pending, hold until, hold indefinitely, aborted, finished */
; #define kPMJobHoldUntilTimeStr              kPMPrintSettingsPrelude "PMJobHoldUntilTime"
; #define kPMJobHoldUntilTimeKey              CFSTR( kPMJobHoldUntilTimeStr )             /* CFDate - Time we expect to print the job. */
; #define kPMJobPriorityStr                   kPMPrintSettingsPrelude "PMJobPriority"
; #define kPMJobPriorityKey                   CFSTR( kPMJobPriorityStr )                  /* CFNumber - kCFNumberSInt32Type, Enum, Low = 0, normal, urgent */
; #define kPMPaperSourceStr                   kPMPrintSettingsPrelude "PMPaperSource"
; #define kPMPaperSourceKey                   CFSTR( kPMPaperSourceStr )                  /* CFNUmber - kCFNumberSInt32Type, Enum, paper sources. */
; #define kPMDuplexingStr                     kPMPrintSettingsPrelude "PMDuplexing"
; #define kPMDuplexingKey                     CFSTR( kPMDuplexingStr )                    /* CFNumber - kCFNumberSInt32Type, Enum, kPMDuplexNone,  kPMDuplexNoTumble, kPMDuplexTumble, kPMSimplexTumble */
; #define kPMDuplexingRequiresFlippedMarginAdjustStr   kPMPrintSettingsPrelude "PMDuplexingRequiresFlippedMargins"
; #define kPMDuplexingRequiresFlippedMarginAdjustKey CFSTR( kPMDuplexingRequiresFlippedMarginAdjustStr )	
;  CFBoolean indicating, when duplexing and the OS is flipping
;                                                                                             the coordinate system to provide support for the destination
;                                                                                             tumble mode, whether the raster supplied to the printer
;                                                                                             should begin at a different distance from the top of the sheet
;                                                                                             than is normally generated. 
; #define kPMHasCustomDuplexPDEStr   			kPMPrintSettingsPrelude "HasCustomDuplexPDE"
; #define kPMHasCustomDuplexPDEKey 			CFSTR( kPMHasCustomDuplexPDEStr )	
;  CFBoolean indicating that the Tioga Printer Module has its own Duplex PDE. 
; #define kPMColorModeStr                     kPMPrintSettingsPrelude "PMColorMode"
; #define kPMColorModeKey                     CFSTR( kPMColorModeStr )                    /* CFNumber - kCFNumberSInt32Type, Enum, B/W, Grayscale, Color, HiFi Color. */
; #define kPMColorSpaceModelStr                     kPMPrintSettingsPrelude "PMColorSpaceModel"
; #define kPMColorSpaceModelKey                     CFSTR( kPMColorSpaceModelStr )                    /* CFNumber - kCFNumberSInt32Type, Enum, see PMColorSpaceModel. */
; #define kPMColorSyncProfileIDStr            kPMPrintSettingsPrelude "PMColorSyncProfileID"
; #define kPMColorSyncProfileIDKey            CFSTR( kPMColorSyncProfileIDStr )           /* CFNumber - kCFNumberSInt32Type, ID of profile to use. */
; #define kPMPrintScalingHorizontalStr        kPMPrintSettingsPrelude "PMScaling"
; #define kPMPrintScalingHorizontalKey        CFSTR( kPMPrintScalingHorizontalStr )       /* CFNumber - kCFNumberDoubleType, Horizontal scaling factor applied to original page size. */
; #define kPMPrintScalingVerticalStr          kPMPrintSettingsPrelude "PMVerticalScaling"
; #define kPMPrintScalingVerticalKey          CFSTR( kPMPrintScalingVerticalStr )         /* CFNumber - kCFNumberDoubleType, Vertical scaling factor applied to original page size. */
; #define kPMPrintScalingAlignmentStr         kPMPrintSettingsPrelude "PMScalingAlignment"
; #define kPMPrintScalingAlignmentKey         CFSTR( kPMPrintScalingAlignmentStr )        /* CFNumber - kCFNumberSInt32Type, Enum (PMScalingAlignment) */
; #define kPMPrintOrientationStr              kPMPrintSettingsPrelude "PMOrientation"
; #define kPMPrintOrientationKey              CFSTR( kPMPrintOrientationStr )             /* CFNumber - kCFNumberSInt32Type, PMOrientation, 1 = portrait, 2 = landscape, etc. */
; #define kPMPreviewStr                       kPMPrintSettingsPrelude "PMPreview"
; #define kPMPreviewKey                       CFSTR( kPMPreviewStr )                      /* CFString - YES means the user clicked on the Preview button */
; #define kPMPrintBackupRecordHdlStr          kPMPrintSettingsPrelude "BackupPrintRecordHandle"
; #define kPMPrintBackupRecordHdlKey          CFSTR( kPMPrintBackupRecordHdlStr )         /* CFData - Print record handle, allowing easy access during most calls. Not used when flattened. (OS8 Only) */
; #define kPMPrintBackupRecordDataStr         kPMPrintSettingsPrelude "BackupPrintRecord"
; #define kPMPrintBackupRecordDataKey         CFSTR( kPMPrintBackupRecordDataStr )        /* CFData - Print record stored in complete form - used when flattening Ticket w/ record. (OS8 only) */
; #define kPMPrintCustomDialogHdlStr          kPMPrintSettingsPrelude "CustomDialogRecord"
; #define kPMPrintCustomDialogHdlKey          CFSTR( kPMPrintCustomDialogHdlStr )         /* CFData - Handle to the print record using for custom dialog calls. Not stored when flattened. (OS8 Only) */
; #define kPMPrimaryPaperFeedStr				kPMPrintSettingsPrelude "PMPrimaryPaperFeed"
; #define kPMPrimaryPaperFeedKey				CFSTR( kPMPrimaryPaperFeedStr )				/* CFArray - main & option PPD key for input paper feed */
; #define kPMSecondaryPaperFeedStr			kPMPrintSettingsPrelude "PMSecondaryPaperFeed"
; #define kPMSecondaryPaperFeedKey			CFSTR( kPMSecondaryPaperFeedStr )			/* CFArray - main & option PPD key for input paper feed */
; #define kPMPSErrorHandlerStr				kPMPrintSettingsPrelude "PMPSErrorHandler"
; #define kPMPSErrorHandlerKey				CFSTR( kPMPSErrorHandlerStr )				/* CFNumber - kCFNumberSInt32Type  */
; #define kPMPSErrorOnScreenStr				kPMPrintSettingsPrelude "PMPSErrorOnScreen"
; #define kPMPSErrorOnScreenKey				CFSTR( kPMPSErrorOnScreenStr )				/* CFBoolean, Turns on PS error on screen notification.  */
; #define kPMPSTraySwitchStr					kPMPrintSettingsPrelude "PMPSTraySwitch"
; #define kPMPSTraySwitchKey					CFSTR( kPMPSTraySwitchStr )					/* CFArray - main & option PPD key for tray switching */
; #define kPMTotalBeginPagesStr		    		kPMPrintSettingsPrelude "PMTotalBeginPages"
; #define kPMTotalBeginPagesKey		    	CFSTR( kPMTotalBeginPagesStr )			/* CFNumber the total number of times beginpage was called */
; #define kPMTotalSidesImagedStr		    		kPMPrintSettingsPrelude "PMTotalSidesImaged"
; #define kPMTotalSidesImagedKey		    	CFSTR( kPMTotalSidesImagedStr )			/* CFNumber the total number of sides that will printed. Does not take into account duplex and collation */
(defconstant $kPMFaxNumberStr "phone")
; #define kPMFaxNumberStr						"phone"
; #define kPMFaxNumberKey		    			CFSTR( kPMFaxNumberStr )			/* CFString - fax number to dial */
(defconstant $kPMFaxToStr "faxTo")
; #define kPMFaxToStr							"faxTo"
; #define kPMFaxToKey		    				CFSTR( kPMFaxToStr )				/* CFString - entire fax to line */
(defconstant $kPMFaxPrefixStr "faxPrefix")
; #define kPMFaxPrefixStr						"faxPrefix"
; #define kPMFaxPrefixKey		    			CFSTR( kPMFaxPrefixStr )			/* CFString - fax prefix to dial */
(defconstant $kPMFaxSubjectStr "faxSubject")
; #define kPMFaxSubjectStr					"faxSubject"
; #define kPMFaxSubjectKey		    		CFSTR( kPMFaxSubjectStr )			/* CFString - fax subject linee*/
(defconstant $kPMFaxCoverSheetStr "faxCoverSheet")
; #define kPMFaxCoverSheetStr					"faxCoverSheet"
; #define kPMFaxCoverSheetKey			   		CFSTR( kPMFaxCoverSheetStr )		/* CFString - fax cover sheet */
(defconstant $kPMFaxCoverSheetMessageStr "faxCoverSheetMessage")
; #define kPMFaxCoverSheetMessageStr			"faxCoverSheetMessage"
; #define kPMFaxCoverSheetMessageKey	   		CFSTR( kPMFaxCoverSheetMessageStr )	/* CFString - fax cover sheet message*/
(defconstant $kPMFaxToneDialingStr "faxToneDialing")
; #define kPMFaxToneDialingStr				"faxToneDialing"
; #define kPMFaxToneDialingKey		   		CFSTR( kPMFaxToneDialingStr )		/* CFString - fax use tone dialing */
(defconstant $kPMFaxUseSoundStr "faxUseSound")
; #define kPMFaxUseSoundStr					"faxUseSound"
; #define kPMFaxUseSoundKey		    		CFSTR( kPMFaxUseSoundStr )			/* CFString - fax use sound */
(defconstant $kPMFaxWaitForDialToneStr "faxWaitForDialTone")
; #define kPMFaxWaitForDialToneStr			"faxWaitForDialTone"
; #define kPMFaxWaitForDialToneKey		    CFSTR( kPMFaxWaitForDialToneStr )	/* CFString - fax wait for dial tone */
; #define kPMCoverPageStr                     kPMPrintSettingsPrelude "PMCoverPage"
; #define kPMCoverPageKey                     CFSTR( kPMCoverPageStr )                    /* CFNumber - kCFNumberSInt32Type, Enum, kPMCoverPageNone,  kPMCoverPageBefore, kPMCoverPageAfter */
; #define kPMCoverPageSourceStr				kPMPrintSettingsPrelude "PMCoverPageSource"
; #define kPMCoverPageSourceKey				CFSTR( kPMCoverPageSourceStr )				/* CFArray - main & option PPD key for cover page paper source */
(defconstant $kPMDestinationPrinterIDStr "DestinationPrinterID")
; #define kPMDestinationPrinterIDStr		"DestinationPrinterID"
; #define kPMDestinationPrinterIDKey		CFSTR( kPMDestinationPrinterIDStr )	/* CFStringRef - the printer ID corresponding to the destination printer */
;  Ticket: PAGE TICKET
;     Future Feature. Intended to hold Page Format and Print Settings ticket for a single
;     page of the document. Not yet implemented.
; 
(defconstant $kPMPageTicketPrelude "com.apple.print.PageTicket.")
; #define kPMPageTicketPrelude                "com.apple.print.PageTicket."
;  Ticket: DOCUMENT TICKET
;     Future Feature. Intended to hold multiple Page Tickets and separate Page Format
;     and Print Settings tickets for a single document. Not yet implemented. For now,
;     the keys listed here will be included at the Job Ticket Level.
; 
(defconstant $kPMDocumentTicketPrelude "com.apple.print.DocumentTicket.")
; #define kPMDocumentTicketPrelude            "com.apple.print.DocumentTicket."
; #define kPMSpoolFormatStr                   kPMDocumentTicketPrelude "PMSpoolFormat"
; #define kPMSpoolFormatKey                   CFSTR( kPMSpoolFormatStr )                  /* CFString. Indicates format of data stored in the spool file. */
; #define kPMPrinterModuleFormatStr           kPMDocumentTicketPrelude "PMDocPMInputFormat"
; #define kPMPrinterModuleFormatKey           CFSTR( kPMPrinterModuleFormatStr )          /* CFString. Indicates format of data going to the Printer Module. */
;  Ticket: JOB TICKET
;     Holds a Page Format and Print Settings ticket, as well as a few other fields that 
;     are Job Specific, such as information about the user that submitted the job. The
;     fidelity bit controls what happens when the system encounters settings that can't
;     be obeyed.
;     In the future a Job Ticket may hold multiple document tickets in addition to the 
;     Print Settings and Page Format tickets.
; 
(defconstant $kPMJobTicketPrelude "com.apple.print.JobInfo.")
; #define kPMJobTicketPrelude                 "com.apple.print.JobInfo."
; #define kPMJobNameStr                       kPMJobTicketPrelude "PMJobName"
; #define kPMJobNameKey                       CFSTR( kPMJobNameStr )                      /* CFString, The name of the job to be displayed in the queue window. */
; #define kPMApplicationNameStr				kPMJobTicketPrelude "PMApplicationName"
; #define kPMApplicationNameKey				CFSTR( kPMApplicationNameStr)				/* CFString, The application's name */
; #define kPMUserLanguageStr                  kPMJobTicketPrelude "PMUserLanguage"
; #define kPMUserLanguageKey                  CFSTR(kPMUserLanguageStr )                  /* CFNumber - kCFNumberSInt32Type, TBD how this is interpreted. */
; #define kPMJobOwnerStr                      kPMJobTicketPrelude "PMJobOwner"
; #define kPMJobOwnerKey                      CFSTR( kPMJobOwnerStr )                     /* CFString - Name of the user who submitted the job. */
; #define kPMJobTemplateStr                   kPMJobTicketPrelude "PMJobTemplate"
; #define kPMJobTemplateKey                   CFSTR( kPMJobTemplateStr )                  /* CFDictionary - PMTemplateRef, actually. See PMTemplate.h */
; #define kPMPhaseStr                         kPMJobTicketPrelude "PMPrintingPhase"
; #define kPMPhaseKey                         CFSTR( kPMPhaseStr )                        /* CFNumber, kCFNumberSInt32Type, Enum - Spooling, RIPing, etc. */
; #define kPMOutputTypeStr		    		kPMJobTicketPrelude "PMOutputType"
; #define kPMOutputTypeKey		    		CFSTR( kPMOutputTypeStr )			/* CFString, Mime type from the kPMOutputTypeListKey array the printer module should generate. */
;  Ticket: LIST TICKET
;     Contains a list of other tickets. There is no restriction on the type of tickets
;     that can be stored in a list, any ticket will do. 
; 
(defconstant $kPMTicketListPrelude "com.apple.print.TicketList.")
; #define kPMTicketListPrelude                "com.apple.print.TicketList."
;  Ticket: Printer Info Ticket
;     Created by the Printer Module to describe features and settings of the current
;     printer. This is information largely used by the Printer Module itself and the Print
;     Dialog Extensions associated with the PM. All "range" type values that would be 
;     verified at dialog time should go in a separate Template.
; 
(defconstant $kPMPrinterInfoPrelude "com.apple.print.PrinterInfo.")
; #define kPMPrinterInfoPrelude               "com.apple.print.PrinterInfo."
; #define kPMPrinterLongNameStr               kPMPrinterInfoPrelude "PMPrinterLongName"
; #define kPMPrinterLongNameKey               CFSTR( kPMPrinterLongNameStr )              /* CFString, Full name of the printer. */
; #define kPMPrinterShortNameStr              kPMPrinterInfoPrelude "PMPrinterShortName"
; #define kPMPrinterShortNameKey              CFSTR( kPMPrinterShortNameStr )             /* CFString, Shorter name to use when you have less space. */
; #define kPMMakeAndModelNameStr              kPMPrinterInfoPrelude "PMMakeAndModelName"
; #define kPMMakeAndModelNameKey              CFSTR( kPMMakeAndModelNameStr )             /* CFString, Product name is used for ???? */
; #define kPMPrinterAddressStr                kPMPrinterInfoPrelude "PMPrinterAddress"
; #define kPMPrinterAddressKey                CFSTR( kPMPrinterAddressStr )               /* CFData, Product address.  */
; #define kPMSupportsColorStr                 kPMPrinterInfoPrelude "PMSupportsColor"
; #define kPMSupportsColorKey                 CFSTR( kPMSupportsColorStr )                /* CFBoolean, If Non-zero, printer/PM can do color. */
; #define kPMDoesCopiesStr                    kPMPrinterInfoPrelude "PMDoesCopies"
; #define kPMDoesCopiesKey                    CFSTR(kPMDoesCopiesStr )                    /* CFBoolean, If Non-zero, printer/PM can do copies */
; #define kPMDoesCopyCollateStr               kPMPrinterInfoPrelude "PMDoesCopyCollate"
; #define kPMDoesCopyCollateKey               CFSTR( kPMDoesCopyCollateStr )              /* CFBoolean, If Non-zero, printer/PM can collate. */
; #define kPMDoesReverseOrderStr              kPMPrinterInfoPrelude "PMDoesReverseOrder"
; #define kPMDoesReverseOrderKey              CFSTR( kPMDoesReverseOrderStr )             /* CFBoolean, If Non-zero, printer/PM can reverse the printing order. */
; #define kPMInputFileTypeListStr             kPMPrinterInfoPrelude "PMInputFileTypeList"
; #define kPMInputFileTypeListKey             CFSTR( kPMInputFileTypeListStr )            /* CFArray of CFStrings indicating file types. See PMDefinitions.h for complete list. */
; #define kPMOutputTypeListStr		    kPMPrinterInfoPrelude "PMOutputTypeList"
; #define kPMOutputTypeListKey		    CFSTR(kPMOutputTypeListStr)			/* CFArray of CFStrings indicating the MIME type for the data is can send to an IO module. */
; #define kPMPPDNameStr		    	    kPMPrinterInfoPrelude "PPD"
; #define kPMPPDNameKey			    CFSTR(kPMPPDNameStr)			/* CFString, containing the URL of the PPD to associate with printer. */
;  Postscript printing related tags 
; #define kPMPostScriptLevelStr               kPMPrinterInfoPrelude "PMPostScriptLevel"
; #define kPMPostScriptLevelKey               CFSTR( kPMPostScriptLevelStr )              /* CFNumber - kCFNumberSInt32Type, indicates PostScript Language level. Contains one of the values from the enum below */
; #define kPMPostScriptVersionStr				kPMPrinterInfoPrelude "PMPSVersion"
; #define kPMPostScriptVersionKey				CFSTR( kPMPostScriptVersionStr )			// CFString e.g."2040.113"
; #define kPMPostScriptRevisionStr			kPMPrinterInfoPrelude "PMPSRevision"
; #define kPMPostScriptRevisionKey			CFSTR( kPMPostScriptRevisionStr ) 			// CFNumber - kCFNumberSInt32Type, contains the PostScript revision which is an integer.
; #define kPMPostScriptTrueTypeFontRasterizerStr		kPMPrinterInfoPrelude "PMPSTTRasterizer"
; #define kPMPostScriptTrueTypeFontRasterizerKey		CFSTR( kPMPostScriptTrueTypeFontRasterizerStr ) 	// CFNumber - kCFNumberSInt32Type, contains one of the values from the enum below.
;  Enum for the possible font rasterizers. 
; /  unknown

(defconstant $kPMPSTTRasterizerUnknown 0)       ; /  none

(defconstant $kPMPSTTRasterizerNone 1)          ; /  accept 68k

(defconstant $kPMPSTTRasterizerAccept68K 2)     ; / type 42

(defconstant $kPMPSTTRasterizerType42 3)
;  Enum for possible PostScript Language Levels. 
; / Level 2 Compatible, may take advantage of Level 3 features

(defconstant $kPMPSTargetLanguageLevel2and3 -3) ; / Level 1 Compatible, may take advantage of Level 2 and 3 features

(defconstant $kPMPSTargetLanguageLevel1and2 -2) ; / language level of target is unknown

(defconstant $kPMPSTargetLanguageLevelUnknown -1); / level 1

(defconstant $kPMPSTargetLanguageLevel1 1)      ; / level 2

(defconstant $kPMPSTargetLanguageLevel2 2)      ; / level 3

(defconstant $kPMPSTargetLanguageLevel3 3)      ;  default

(defconstant $kPMPSTargetLanguageLevelDefault -1)
;  Note, we've removed the PMLanguageInfoKey because it's not valid to store strings or structures, everything needs to be a CFType.
; #define kPMTotalMemInstalledStr             kPMPrinterInfoPrelude "PMTotalMemInstalled"
; #define kPMTotalMemInstalledKey             CFSTR( kPMTotalMemInstalledStr )            /* CFNumber - kCFNumberSInt32Type, Memory on the Printer itself. */
; #define kPMTotalMemAvailableStr             kPMPrinterInfoPrelude "PMTotalMemAvailable"
; #define kPMTotalMemAvailableKey             CFSTR( kPMTotalMemAvailableStr )            /* CFNumber - kCFNumberSInt32Type, Remaining memory available for use. */
;  PPD related tags 
; #define kPMDescriptionFileStr               kPMPrinterInfoPrelude "PMDescriptionFile"
; #define kPMDescriptionFileKey               CFSTR( kPMDescriptionFileStr )              /* CFString, PPD file name or other description file. */
; #define kPMCompiledPPDStr                   kPMPrinterInfoPrelude "PMCompiledPPD"
; #define kPMCompiledPPDKey                   CFSTR( kPMCompiledPPDStr )                  /* CFData, Compiled PPD file to ease parsing after the fact. Not sure we need. */
;  ColorSync related tags 
; #define kPMColorDeviceIDStr                 kPMPrinterInfoPrelude "PMColorDeviceID"
; #define kPMColorDeviceIDKey                 CFSTR( kPMColorDeviceIDStr )                /* CFString, representing a CFUUID - must be unique per device */
; #define kPMColorSyncProfilesStr				kPMPrinterInfoPrelude "PMColorSyncProfiles"
; #define kPMColorSyncProfilesKey				CFSTR( kPMColorSyncProfilesStr )			/* CFArray - of CFDicts, one for each factory profile. */
;  Installable options string. 
; #define kPMInstallableOptionStr             kPMPrinterInfoPrelude "PMInstallableOption" 
; #define kPMInstallableOptionKey             CFSTR( kPMInstallableOptionStr )            /* CFData, Installable options from PPD file. */ 
;  Suggested app drawing resolutions 
; #define kPMPrinterSuggestedResStr           kPMPrinterInfoPrelude "PMPrinterSuggestedRes"
; #define kPMPrinterSuggestedResKey           CFSTR( kPMPrinterSuggestedResStr ) 			/* CFArray -  array of pairs of kCFNumberDoubleType - One pair for each recommended resolution*/ 
;  Min and max range of resolutions 
; #define kPMPrinterMinResStr                 kPMPrinterInfoPrelude "PMPrinterMinRes"
; #define kPMPrinterMinResKey                 CFSTR( kPMPrinterMinResStr ) 				/* CFArray - 2 CFNumber, kCFNumberDoubleType, min resolution of printer */ 
; #define kPMPrinterMaxResStr                 kPMPrinterInfoPrelude "PMPrinterMaxRes"
; #define kPMPrinterMaxResKey                 CFSTR( kPMPrinterMaxResStr ) 				/* CFArray - 2 CFNumber, kCFNumberDoubleType, max resolution of printer */ 
;  driver creator code 
; #define kPMDriverCreatorStr					kPMPrinterInfoPrelude "PMDriverCreator"		
; #define kPMDriverCreatorKey					CFSTR(kPMDriverCreatorStr)					// CFNumber - kCFNumberSInt32Type creator signiture  for  driver
;  Printer Resident font data handle 
; #define kPMPrinterFontStr                   kPMPrinterInfoPrelude "Printer Fonts"		
; #define kPMPrinterFontKey                   CFSTR( kPMPrinterFontStr )                  /* CFData, Printer resident fonts from printer query. */
; #define kPMPrinterIsPostScriptDriverStr		kPMPrinterInfoPrelude "PMIsPostScriptDriver"
; #define kPMPrinterIsPostScriptDriverKey		CFSTR(kPMPrinterIsPostScriptDriverStr)		// CFBoolean - PJCIsPostScriptDriver
; !
;  * The value of this key is a CFBoolean representing the result of querying the PostScript printer
;  * about its ability to accept binary data. It is possible for the underlying communications
;  * to support binary data, both high bit characters and control characters, but for a
;  * spooler on the other end of the channel to not accept binary data. This value represents
;  * the spooler/printer's abilities.
;  
; #define kPMIsBinaryOKStr			kPMPrinterInfoPrelude "PMIsBinaryOK"
; #define kPMIsBinaryOKKey			CFSTR(kPMIsBinaryOKStr)
; !
;  * The value of this key is a CFBoolean indicating whether the communications channel can
;  * transmit characters in the range 0x80 - )xFF inclusive without them being damaged or
;  * interpreted as channel control characters.
;  
; #define kPM8BitCommStr			kPMPrinterInfoPrelude "PM8BitComm"
; #define kPM8BitCommKey			CFSTR(kPM8BitCommStr)		// CFBoolean - Can the comm channel take bytes with the high bit set?
; !
;  * The value of this key is a CFBoolean indicating whether the communications channel can
;  * transmit characters in the range 0x00 - 0x1F inclusive without them being damaged or
;  * interpreted as channel control characters.
;  
; #define kPMTransparentCommStr			kPMPrinterInfoPrelude "PMTransparentComm"
; #define kPMTransparentCommKey			CFSTR(kPMTransparentCommStr)
;  Ticket: Converter Setup Ticket
;     Contains controls for converter. Generally, the Printer Module and Job Manager will set
;     tags in this ticket to control the various settings of the conversion process. 
; 
(defconstant $kPMConverterSetupPrelude "com.apple.print.ConverterSetup.")
; #define kPMConverterSetupPrelude            "com.apple.print.ConverterSetup."
; #define kPMBandingRequestedStr              kPMConverterSetupPrelude "PMBandingRequested"
; #define kPMBandingRequestedKey              CFSTR( kPMBandingRequestedStr )             /* CFBoolean, turns on banding if it's available. */
; #define kPMRequiredBandHeightStr            kPMConverterSetupPrelude "PMRequiredBandHeight"
; #define kPMRequiredBandHeightKey            CFSTR( kPMRequiredBandHeightStr )           /* CFNumber, number of scan lines needed for each band. Could be whole page, in which case banding is disabled. */
; #define kPMDepthSwitchingEnabledStr         kPMConverterSetupPrelude "PMDepthSwitching"
; #define kPMDepthSwitchingEnabledKey         CFSTR( kPMDepthSwitchingEnabledStr )        /* CFBoolean. If true, the printer module wants converter to switch between b/w bands and color bands when possible. */
; #define kPMWhiteSkippingEnabledStr          kPMConverterSetupPrelude "PMWhiteSpaceSkipping"
; #define kPMWhiteSkippingEnabledKey          CFSTR( kPMWhiteSkippingEnabledStr )         /* CFBoolean. If true, the printer module wants converter to skip over white space if possible. */
; #define kPMConverterResHorizontalStr        kPMConverterSetupPrelude "PMConversionResHorizontal"
; #define kPMConverterResHorizontalKey        CFSTR( kPMConverterResHorizontalStr )       /* CFNumber, CFNumberDoubleType indicating horizontal final rendering resolution. */
; #define kPMConverterResVerticalStr          kPMConverterSetupPrelude "PMConversionResVertcial"
; #define kPMConverterResVerticalKey          CFSTR( kPMConverterResVerticalStr )         /* CFNumber, CFNumberDoubleType indicating vertical final rendering resolution. */
; #define kPMRequestedPixelFormatStr          kPMConverterSetupPrelude "PMPixelFormat"
; #define kPMRequestedPixelFormatKey          CFSTR( kPMRequestedPixelFormatStr )         /* CFNumber, CFNumberLongType, indicates the pixel format requested of the converter. */
; #define kPMRequestedPixelLayoutStr          kPMConverterSetupPrelude "PMPixelLayout"
; #define kPMRequestedPixelLayoutKey          CFSTR( kPMRequestedPixelLayoutStr )         /* CFNumber, CFNumberLongType, indicates the pixel layout requested of the converter. */
; #define kPMCVColorSyncProfileIDStr			kPMConverterSetupPrelude "PMProfileID"
; #define kPMCVColorSyncProfileIDKey			CFSTR( kPMCVColorSyncProfileIDStr )			/* CFNumber, kCFNumberSInt32Type, the profile ID for the profile to be used with this job. */
;  END OF SECTION II: TICKET KEYS 
;  SECTION III, FUNCTIONS: 
;  Create, or copy a Ticket. As a Ticket is created, its type is stored in the object itself 
;  and used to help the programmer make sure they are adding the correct fields to the object. 

(deftrap-inline "_PMTicketCreate" 
   ((allocator (:pointer :__CFAllocator))
    (ticketType (:pointer :__CFString))
    (newTicket (:pointer :PMTICKETREF))
   )
   :OSStatus
() )

(deftrap-inline "_PMTicketCopy" 
   ((allocator (:pointer :__CFAllocator))
    (sourceTicket (:pointer :OpaquePMTicketRef))
    (destinationTicket (:pointer :PMTICKETREF))
   )
   :OSStatus
() )
;  Retain, release, or get retain count of a Ticket. The behavior is modelled after 
;  CoreFoundation's CFRetain, CFRelease, and CFGetRetainCount APIs. 

(deftrap-inline "_PMTicketGetRetainCount" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (retainCount (:pointer :CFIndex))
   )
   :OSStatus
() )

(deftrap-inline "_PMTicketRetain" 
   ((ticket (:pointer :OpaquePMTicketRef))
   )
   :OSStatus
() )

(deftrap-inline "_PMTicketRelease" 
   ((ticket (:pointer :OpaquePMTicketRef))
   )
   :OSStatus
() )
;  PMTicketReleaseAndClear does the same thing as PMTicketRelease except that it sets the 
;  passed in pointer to NULL, which we think is good programming practice. Other references 
;  to the ticket may still be valid, but this one is no longer expected to be used. 

(deftrap-inline "_PMTicketReleaseAndClear" 
   ((ticket (:pointer :PMTICKETREF))
   )
   :OSStatus
() )
;  Tickets may be locked by the printing system, so we provide a function to determine if 
;  the ticket is indeed locked. Any attempted changes to a locked ticket will result in 
;  "kPMTicketLocked" error. 

(deftrap-inline "_PMTicketGetLockedState" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (lockedState (:pointer :Boolean))
   )
   :OSStatus
() )
;  To confirm that we have a real ticket, this short function gets called. 

(deftrap-inline "_PMTicketConfirmTicket" 
   ((ticket (:pointer :OpaquePMTicketRef))
   )
   :OSStatus
() )
;  We validate an entire ticket by calling our PMTicketValidate function, passing a template  
;  which contains constraints for all the values in the ticket. Those entries in the ticket 
;  that don't have constraints will not be checked, so developers can add their own custom 
;  data. For now we have to verify a single ticket at a time. Future updates will allow the 
;  caller to confirm an entire tree of tickets. 

(deftrap-inline "_PMTicketValidate" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (verifyingTemplate (:pointer :OpaquePMTemplateRef))
    (invalidItems (:pointer :CFArrayRef))
   )
   :OSStatus
() )
;  A couple of utility functions to find out what type of ticket is references, as well 
;  as access to the allocator function passed in for a ticket. We also provide a function 
;  to check the API version for a ticket, to protect against future conversion problems 
;  from old to new tickets. 

(deftrap-inline "_PMTicketGetType" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (ticketType (:pointer :CFStringRef))
   )
   :OSStatus
() )

(deftrap-inline "_PMTicketGetEnumType" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (ticketType (:pointer :PMTICKETTYPE))
   )
   :OSStatus
() )

(deftrap-inline "_PMTicketGetAllocator" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (allocator (:pointer :CFALLOCATORREF))
   )
   :OSStatus
() )

(deftrap-inline "_PMTicketGetAPIVersion" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (apiVersion (:pointer :CFStringRef))
   )
   :OSStatus
() )
;  To store a Ticket object it needs to be converted to XML, a serialization that 
;  creates human readable text. If the data is to be written to file anyway, a second 
;  function is provided to go "all the way." 
;  Convert to XML 

(deftrap-inline "_PMTicketToXML" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (anXMLTicket (:pointer :CFDataRef))
   )
   :OSStatus
() )
;  Convert to XML and write to file 

(deftrap-inline "_PMTicketWriteXMLToFile" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (path (:pointer :char))
   )
   :OSStatus
() )
;  Convert to XML and write to FILE stream. 

(deftrap-inline "_PMTicketWriteXML" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (file (:pointer :file))
   )
   :OSStatus
() )
;  Convert from XML 

(deftrap-inline "_PMXMLToTicket" 
   ((allocator (:pointer :__CFAllocator))
    (anXMLTicket (:pointer :__CFData))
    (ticket (:pointer :PMTICKETREF))
    (conversionError (:pointer :CFStringRef))
   )
   :OSStatus
() )
;  Convert from XML File 

(deftrap-inline "_PMXMLURLToTicket" 
   ((allocator (:pointer :__CFAllocator))
    (anXMLURL (:pointer :__CFURL))
    (ticket (:pointer :PMTICKETREF))
    (format (:pointer :CFPropertyListFormat))
    (errorString (:pointer :CFStringRef))
   )
   :OSStatus
() )
;  Read from file and convert from XML. 

(deftrap-inline "_PMTicketReadXMLFromFile" 
   ((allocator (:pointer :__CFAllocator))
    (path (:pointer :char))
    (ticket (:pointer :PMTICKETREF))
    (errorString (:pointer :CFStringRef))
   )
   :OSStatus
() )
;  To add an item to a ticket, the "SetItem" call for the specific data type is used whenever  
;  possible. This adds a new item if one doesn't exist and updates a previous item if it  
;  already exists. The "locked" field will determine if subsequent updates are allowed. 
;  Strings: 
;  CFString 

(deftrap-inline "_PMTicketSetCFString" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (item (:pointer :__CFString))
    (locked :Boolean)
   )
   :OSStatus
() )
;  Pascal String 

(deftrap-inline "_PMTicketSetPString" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (value (:pointer :UInt8))
    (locked :Boolean)
   )
   :OSStatus
() )
;  'C' String 

(deftrap-inline "_PMTicketSetCString" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (value (:pointer :char))
    (locked :Boolean)
   )
   :OSStatus
() )
;  Array of 'C' Strings 

(deftrap-inline "_PMTicketSetCStringArray" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (cStringArray (:pointer :char))
    (count :UInt32)
    (locked :Boolean)
   )
   :OSStatus
() )
;  Numbers: 
;  CFNumber 

(deftrap-inline "_PMTicketSetCFNumber" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (item (:pointer :__CFNumber))
    (locked :Boolean)
   )
   :OSStatus
() )
;  SInt32 

(deftrap-inline "_PMTicketSetSInt32" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (value :SInt32)
    (locked :Boolean)
   )
   :OSStatus
() )
;  Array of SInt32 

(deftrap-inline "_PMTicketSetSInt32Array" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (sInt32Array (:pointer :SInt32))
    (count :UInt32)
    (locked :Boolean)
   )
   :OSStatus
() )
;  UInt32 
;  NOTE: The underlying code uses SInt32s in the CF code, so this function can't set -1 
;  as the largest unsigned number. Please avoid setting the high bit 

(deftrap-inline "_PMTicketSetUInt32" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (value :UInt32)
    (locked :Boolean)
   )
   :OSStatus
() )
;  Array of UInt32 
;  NOTE: The underlying code uses SInt32s in the CF code, so this function can't set -1 
;  as the largest unsigned number. Please avoid setting the high bit 

(deftrap-inline "_PMTicketSetUInt32Array" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (uInt32Array (:pointer :UInt32))
    (count :UInt32)
    (locked :Boolean)
   )
   :OSStatus
() )
;  Double 

(deftrap-inline "_PMTicketSetDouble" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (value :double-float)
    (locked :Boolean)
   )
   :OSStatus
() )
;  Array of doubles 

(deftrap-inline "_PMTicketSetDoubleArray" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (array (:pointer :double))
    (count :UInt32)
    (changeable :Boolean)
   )
   :OSStatus
() )
;  PMResolution - Array of 2 Doubles 

(deftrap-inline "_PMTicketSetPMResolution" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (value (:pointer :PMResolution))
    (locked :Boolean)
   )
   :OSStatus
() )
;  Array of PMResolution 

(deftrap-inline "_PMTicketSetPMResolutionArray" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (pmResolutionArray (:pointer :PMResolution))
    (count :UInt32)
    (locked :Boolean)
   )
   :OSStatus
() )
;  PMRect - Array of 4 Doubles 

(deftrap-inline "_PMTicketSetPMRect" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (value (:pointer :PMRect))
    (locked :Boolean)
   )
   :OSStatus
() )
;  Array of PMRects 

(deftrap-inline "_PMTicketSetPMRectArray" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (pmRectArray (:pointer :PMRect))
    (count :UInt32)
    (locked :Boolean)
   )
   :OSStatus
() )
;  Raw Data 
;  CFData 

(deftrap-inline "_PMTicketSetCFData" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (item (:pointer :__CFData))
    (locked :Boolean)
   )
   :OSStatus
() )
;  UInt8 - 'C' Bytes 

(deftrap-inline "_PMTicketSetBytes" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (data (:pointer :UInt8))
    (size :UInt32)
    (locked :Boolean)
   )
   :OSStatus
() )
;  Booleans 
;  CFBoolean 

(deftrap-inline "_PMTicketSetCFBoolean" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (item (:pointer :__CFBoolean))
    (locked :Boolean)
   )
   :OSStatus
() )
;  'C' Boolean 

(deftrap-inline "_PMTicketSetBoolean" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (value :Boolean)
    (locked :Boolean)
   )
   :OSStatus
() )
;  Dates 

(deftrap-inline "_PMTicketSetCFDate" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (item (:pointer :__CFDate))
    (locked :Boolean)
   )
   :OSStatus
() )
;  Arrays 

(deftrap-inline "_PMTicketSetCFArray" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (item (:pointer :__CFArray))
    (locked :Boolean)
   )
   :OSStatus
() )
;  Dictionaries 

(deftrap-inline "_PMTicketSetCFDictionary" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (item (:pointer :__CFDictionary))
    (locked :Boolean)
   )
   :OSStatus
() )
;  Templates, which are defined to be opaque. 

(deftrap-inline "_PMTicketSetTemplate" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (item (:pointer :OpaquePMTemplateRef))
    (locked :Boolean)
   )
   :OSStatus
() )
;  Generic CF Type 

(deftrap-inline "_PMTicketSetItem" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (item (:pointer :void))
    (locked :Boolean)
   )
   :OSStatus
() )
; ****
; Warning: PMTicketSetMetaItem is being deprecated.
; ****

(deftrap-inline "_PMTicketSetMetaItem" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (key (:pointer :__CFString))
    (item (:pointer :void))
   )
   :OSStatus
() )
;  Convert an array of static item structures into entries for a ticket and add them one at 
;  a time to the ticket. Could fail part way through. 

(deftrap-inline "_PMTicketFillFromArray" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (items (:pointer :PMTicketItemStruct))
    (itemCount :UInt32)
   )
   :OSStatus
() )
;  If an item must be copied from one ticket to another, use the "CopyItem" call to 
;  make the simple transfer. This will update the recorded date and client ID for the item. 
;  The "locked" field will determine if subsequent updates may be made. 

(deftrap-inline "_PMTicketCopyItem" 
   ((sourceTicket (:pointer :OpaquePMTicketRef))
    (destTicket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
    (locked :Boolean)
   )
   :OSStatus
() )
;  A couple of functions that will help in managing the "locked" state of any ticket 
;  item. These functions only work for items directly stored in the current ticket, not 
;  for items in sub-tickets. 

(deftrap-inline "_PMTicketIsItemLocked" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (key (:pointer :__CFString))
    (locked (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_PMTicketLockItem" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
   )
   :OSStatus
() )

(deftrap-inline "_PMTicketUnlockItem" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
   )
   :OSStatus
() )
;  Disable an item using PMTicketDelete. Future callers will see "ItemNotFound" errors. 
;  This call actually tags a new set of structures to the end of an item's dictionary, in 
;  order to keep a history of the item. 

(deftrap-inline "_PMTicketDeleteItem" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (clientID (:pointer :__CFString))
    (key (:pointer :__CFString))
   )
   :OSStatus
() )
;  Release an item (quite different from delete) when you want it completely removed from the 
;  ticket. This can only be done if the item is unlocked. 

(deftrap-inline "_PMTicketReleaseItem" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (key (:pointer :__CFString))
   )
   :OSStatus
() )
;  Fetching an item back out of the ticket requires the "GetItem" call for the particular type 
;  of data you're fetching. In some cases, the caller doesn't know what type of data is being 
;  returned, so we have a generic "GetItem" call, but for all other cases developers are  
;  encouraged to use the specific call for the data they need, thus enabling type checking and 
;  reducing errors. 
;  Returns true if item exists. 

(deftrap-inline "_PMTicketContainsItem" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
   )
   :Boolean
() )
;  Strings 
;  CFString 

(deftrap-inline "_PMTicketGetCFString" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (item (:pointer :CFStringRef))
   )
   :OSStatus
() )
;  Pascal String 

(deftrap-inline "_PMTicketGetPString" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (bufferSize :UInt32)
    (encoding :UInt32)
    (value (:pointer :UInt8))
   )
   :OSStatus
() )
;  'C' String 

(deftrap-inline "_PMTicketGetCString" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (bufferSize :UInt32)
    (encoding :UInt32)
    (value (:pointer :char))
   )
   :OSStatus
() )
;  Numbers 
;  CFNumber 

(deftrap-inline "_PMTicketGetCFNumber" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (item (:pointer :CFNUMBERREF))
   )
   :OSStatus
() )
;  SInt32 

(deftrap-inline "_PMTicketGetSInt32" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (value (:pointer :SInt32))
   )
   :OSStatus
() )
;  UInt32 

(deftrap-inline "_PMTicketGetUInt32" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (value (:pointer :UInt32))
   )
   :OSStatus
() )
;  Double 

(deftrap-inline "_PMTicketGetDouble" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (value (:pointer :double))
   )
   :OSStatus
() )
;  PMResolution - Array of 2 doubles 

(deftrap-inline "_PMTicketGetPMResolution" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (res (:pointer :PMResolution))
   )
   :OSStatus
() )

(deftrap-inline "_PMTicketGetIndexPMResolution" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (index :UInt32)
    (res (:pointer :PMResolution))
   )
   :OSStatus
() )
;  PMRect - Array of 4 doubles 

(deftrap-inline "_PMTicketGetPMRect" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (value (:pointer :PMRect))
   )
   :OSStatus
() )
;  Raw Data 
;  CFData 

(deftrap-inline "_PMTicketGetCFData" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (item (:pointer :CFDataRef))
   )
   :OSStatus
() )
;  UInt8 - 'C' Bytes 
;  NOTE: Caller is expected to call twice if size is unknown, passing null for data pointer 
;  and a valid pointer for the size before allocating space and calling back with both pointers 
;  set, this time with valid data pointer and valid size pointer pointing to # of bytes requested. 

(deftrap-inline "_PMTicketGetBytes" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (data (:pointer :UInt8))
    (size (:pointer :UInt32))
   )
   :OSStatus
() )
;  Booleans 
;  CFBoolean 

(deftrap-inline "_PMTicketGetCFBoolean" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (item (:pointer :CFBOOLEANREF))
   )
   :OSStatus
() )
;  'C' Boolean  

(deftrap-inline "_PMTicketGetBoolean" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (value (:pointer :Boolean))
   )
   :OSStatus
() )
;  Dates 

(deftrap-inline "_PMTicketGetCFDate" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (item (:pointer :CFDATEREF))
   )
   :OSStatus
() )
;  Non-numeric Arrays 

(deftrap-inline "_PMTicketGetCFArray" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (item (:pointer :CFArrayRef))
   )
   :OSStatus
() )
;  Dictionaries 

(deftrap-inline "_PMTicketGetCFDictionary" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (item (:pointer :CFDictionaryRef))
   )
   :OSStatus
() )
;  PMTemplates, which are defined to be opaque. 

(deftrap-inline "_PMTicketCreateTemplate" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (item (:pointer :PMTEMPLATEREF))
   )
   :OSStatus
() )
;  The generic calls for regular items and meta items. See notes on "SetMetaItem" for more details. 

(deftrap-inline "_PMTicketGetItem" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (key (:pointer :__CFString))
    (item (:pointer :CFTypeRef))
   )
   :OSStatus
() )
; ****
; Warning: PMTicketGetMetaItem is being deprecated.
; ****

(deftrap-inline "_PMTicketGetMetaItem" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (key (:pointer :__CFString))
    (item (:pointer :CFTypeRef))
   )
   :OSStatus
() )
;  Any ticket can contain another ticket, allowing us to store multiple PageFormat tickets 
;  (one for each page) and multiple Document Info tickets (for multi-document jobs). The following 
;  functions allow us to put a ticket into another ticket as a sub-ticket, and retreive it 
;  later on. 

(deftrap-inline "_PMTicketSetTicket" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (ticketToAdd (:pointer :OpaquePMTicketRef))
    (index :UInt32)
   )
   :OSStatus
() )

(deftrap-inline "_PMTicketContainsTicket" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (requestedType (:pointer :__CFString))
    (index :UInt32)
    (exists (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_PMTicketGetTicket" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (requestedType (:pointer :__CFString))
    (index :UInt32)
    (retrievedTicket (:pointer :PMTICKETREF))
   )
   :OSStatus
() )

(deftrap-inline "_PMTicketRemoveTicket" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (typeToRemove (:pointer :__CFString))
    (index :UInt32)
   )
   :OSStatus
() )

(deftrap-inline "_PMTicketGetPPDDict" 
   ((ticket (:pointer :OpaquePMTicketRef))
    (nodeIndex1 :UInt32)
    (nodeIndex2 :UInt32)
    (dict (:pointer :CFMutableDictionaryRef))
   )
   :OSStatus
() )
; !
;  * @function	PMTicketCreateDict
;  * @abstract	Distill a ticket into a dictionary.
;  *
;  * @discussion	This function extracts the key value pairs from a ticket
;  *		and places them into a dictionary. Information maintained
;  *		by the ticket, such as who added a value and when is lost.
;  

(deftrap-inline "_PMTicketCreateDict" 
   ((ticket (:pointer :OpaquePMTicketRef))
   )
   (:pointer :__CFDictionary)
() )
; !
;  * @function	PMTicketHasEqualValues
;  * @abstract	Return true of the two tickets have equal values for their
;  *		keys.
;  *
;  * @param	ticket1		A valid PMTicketRef.
;  *
;  * @param	ticket2		A valid PMTicketRef.
;  *
;  * @discussion	This function ignores any extra information maintained by tickets,
;  *		such as the client who entered the value and when. The comparison
;  *		is based solely on the keys and values in the ticket.
;  

(deftrap-inline "_PMTicketHasEqualValues" 
   ((ticket1 (:pointer :OpaquePMTicketRef))
    (ticket2 (:pointer :OpaquePMTicketRef))
   )
   :Boolean
() )

(deftrap-inline "_PMSessionGetTicketFromSession" 
   ((session (:pointer :OpaquePMPrintSession))
    (key (:pointer :__CFString))
    (theTicket (:pointer :PMTICKETREF))
   )
   :OSStatus
() )

(deftrap-inline "_PMSessionGetTemplateFromSession" 
   ((session (:pointer :OpaquePMPrintSession))
    (key (:pointer :__CFString))
    (theTemplate (:pointer :PMTEMPLATEREF))
   )
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __PMTICKET__ */


(provide-interface "PMTicket")