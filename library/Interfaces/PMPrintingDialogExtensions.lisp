(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PMPrintingDialogExtensions.h"
; at Sunday July 2,2006 7:31:15 pm.
; 
;      File:       PMPrintingDialogExtensions.h
;  
;      Contains:   Mac OS X Printing Manager Print Dialog Extensions' Interfaces.
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
; #ifndef __PMPRINTINGDIALOGEXTENSIONS__
; #define __PMPRINTINGDIALOGEXTENSIONS__

(require-interface "ApplicationServices/ApplicationServices")

(require-interface "CoreFoundation/CoreFoundation")

(require-interface "Print/Print")

(require-interface "PrintCore/PMTicket")

(require-interface "PrintCore/PMPluginHeader")

(require-interface "PrintCore/PMErrors")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;     Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(defconstant $kEventUpdatePrintButton :|prbt|)
; 
; Direction of sync
; 

(defconstant $kPMSyncTicketFromPane $false)
(defconstant $kPMSyncPaneFromTicket $true)
; 
; Feature request flags...
; 

(defconstant $kPMPDENoFlags 0)                  ;  Empty flag word. 

(defconstant $kPMPDENoSummary 1)                ;  Won't provide summary string. 
;  All flags set.

(defconstant $kPMPDEAllFlags -1)
; 
;     Parameters for printing events:
;     
;     kEventPrintingPDEResize
;         -->     kEventParamDirectObject     typeControlRef
;         -->     kEventParamPDEHeight        typeUInt32
;         
;     When sent to the this event is sent to the PageSetup or Print Dialog, the PDE pane
;     will be resized to match the new height.  The kEventParamDirectObject needs to be the 
;     embedderUserPane that is passed into Initialize
; 

(defconstant $kEventClassPrinting :|prnt|)
(defconstant $kEventPrintingPDEResize :|rqsz|)
(defconstant $kEventParamPDEHeight :|pdeh|)
; 
; Define Printing Dialog Extensions CFPlugIn constants.
; 
; First, the base string for all constants relating to Printing Dialog Extensions.
; 
(defconstant $kPMPDEBase "com.apple.printing.pde")
; #define kPMPDEBase "com.apple.printing.pde"
; 
; Define the Type and Interface keys for Printing Dialog Extensions.
; 
; #define kPMPDEAppType           CFSTR(kPMPDEBase ".app")
; #define KPMPDEPrinterType       CFSTR(kPMPDEBase ".pm")
; #define kPMPDEInterface         CFSTR(kPMPDEBase ".ui")
; 
; Define the Kind IDs for Universal and Standard Printing Dialog Extensions.
; 
;  Implemented Universal 
; #define kPMPageAttributesKindID         CFSTR("com.apple.print.pde.PageAttributesKind")
; #define kPMCopiesAndPagesPDEKindID      CFSTR("com.apple.print.pde.CopiesAndPagesKind")
; #define kPMLayoutPDEKindID              CFSTR("com.apple.print.pde.LayoutUserOptionKind")
; #define kPMOutputOptionsPDEKindID       CFSTR("com.apple.print.pde.OutputOptionsKind")
; #define kPMDuplexPDEKindID              CFSTR("com.apple.print.pde.DuplexKind")
; #define kPMCustomPaperSizePDEKindID     CFSTR("com.apple.print.pde.CustomPaperSizeKind")
; #define kPMCoverPagePDEKindID           CFSTR("com.apple.print.pde.CoverPageKind")
; #define kPMSchedulerPDEKindID           CFSTR("com.apple.print.pde.SchedulerKind")
; #define kPMImagingOptionsPDEKindID		CFSTR("com.apple.print.pde.ImagingOptionsKind")
; #define kPMFaxCoverPagePDEKindID		CFSTR("com.apple.print.pde.FaxCoverPageKind")
; #define kPMFaxModemPDEKindID			CFSTR("com.apple.print.pde.FaxModemKind")
; #define kPMPaperHandlingPDEKindID		CFSTR("com.apple.print.pde.PaperHandlingKind")
; #define kPMSummaryPanelKindID			CFSTR("com.apple.print.pde.SummaryKind")
;  Unimplemented Universal 
; #define kPMPaperSourcePDEKindID         CFSTR("com.apple.print.pde.PaperSourceKind")
; #define kPMPriorityPDEKindID            CFSTR("com.apple.print.pde.PriorityKind")
; #define kPMRotationScalingPDEKindID     CFSTR("com.apple.print.pde.RotationScalingKind")
;  Implemented Standard 
; #define kPMErrorHandlingPDEKindID		CFSTR("com.apple.print.pde.ErrorHandlingKind")
; #define kPMPaperFeedPDEKindID           CFSTR("com.apple.print.pde.PaperFeedKind")
; #define kPMPrinterFeaturesPDEKindID		CFSTR("com.apple.print.pde.PrinterFeaturesKind")
;  Unimplemented Standard 
; #define kPMColorPDEKindID               CFSTR("com.apple.print.pde.ColorKind")
; #define kPMQualityMediaPDEKindID        CFSTR("com.apple.print.pde.QualityMediaPDEKind")
;   These constants are used by PDE's to obtain the PMTicketRef data for the corresponding
;     piece of data.
; 
; #define kPDE_PMPrintSettingsRef 	CFSTR("PMPrintSettingsTicket")
; #define kPDE_PMPageFormatRef	 	CFSTR("PMPageFormatTicket")
; #define kPDE_PMJobTemplateRef 		CFSTR("PMJobTemplateTicket")
; #define kPDE_PMPrinterInfoRef 		CFSTR("PMPrinterInfoTicket")
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;     Type Definitions
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
; Basic types...
; 

(def-mactype :PMPDERef (find-mactype ':SInt32))

(def-mactype :PMPDEContext (find-mactype ':UInt32))

(def-mactype :PMPDEFlags (find-mactype ':UInt32))
;  Just for testing this .... 
; #define    TEST_PLUGINS_LINKED_IN     1 
;  Type and Interface IDs. 
; #define kDialogExtensionIntfIDStr			CFSTR("A996FD7E-B738-11D3-8519-0050E4603277")
; #define kGeneralPageSetupDialogTypeIDStr		CFSTR("6E6ED964-B738-11D3-952F-0050E4603277")
; #define kGeneralPrintDialogTypeIDStr			CFSTR("C1BF838E-B72A-11D3-9644-0050E4603277")
; #define kAppPageSetupDialogTypeIDStr			CFSTR("B9A0DA98-E57F-11D3-9E83-0050E4603277")
; #define kAppPrintDialogTypeIDStr			CFSTR("BCB07250-E57F-11D3-8CA6-0050E4603277")
; #define kAppPrintThumbnailTypeIDStr			CFSTR("9320FE03-B5D5-11D5-84D1-003065D6135E")
; #define kPrinterModuleTypeIDStr				CFSTR("BDB091F4-E57F-11D3-B5CC-0050E4603277")
;  Versioning info. 
;  Update following values when you append new APIs to the end of interface: 
(defconstant $kPDEBuildVersionMajor 1)
; #define kPDEBuildVersionMajor   1
(defconstant $kPDEBuildVersionMinor 0)
; #define kPDEBuildVersionMinor   0
;  Update following values when you obsolete some APIs in the interface. 
;  Since this will break the upward compatibility chain such practice is 
;  strongly discouraged - if it can be helped at all. 
(defconstant $kPDEBaseVersionMajor 1)
; #define kPDEBaseVersionMajor        1
(defconstant $kPDEBaseVersionMinor 0)
; #define kPDEBaseVersionMinor        0
;  Interface layout - object and vtable: 

;type name? (def-mactype :PlugInIntf (find-mactype ':PlugInIntf))

;type name? (def-mactype :PlugInIntfVTable (find-mactype ':PlugInIntfVTable))
(defrecord PlugInIntf
                                                ;  Plugin interface is an object containing vtable address:
   (vtable (:pointer :PlugInIntfVTable))
)
(defrecord PlugInIntfVTable
                                                ;  ---- API 'IMMUTABLE' Begin: ----
                                                ;  The plugin header is required with all plugins.
                                                ;  This must lead object's layout.
   (plugInHeader :PMPLUGINHEADER)
                                                ;  ---- API Version 1.0 Begin: ----
                                                ;  Entry points for Printing Dialog Extension modules...
   (Prologue (:pointer :callback))              ;((OSStatus , Prologue) (PMPDEContext * context , OSType * creator , CFStringRef * userOptionKind , CFStringRef * title , UInt32 * maxH , UInt32 * maxV))
   (Initialize (:pointer :callback))            ;((OSStatus , Initialize) (PMPDEContext context , PMPDEFlags * flags , PMPDERef ref , ControlRef embedderUserPane , PMPrintSession printSession))
   (Sync (:pointer :callback))                  ;((OSStatus , Sync) (PMPDEContext context , PMPrintSession printSession , Boolean reinitializePlugIn))
   (GetSummaryText (:pointer :callback))        ;((OSStatus , GetSummaryText) (PMPDEContext context , CFArrayRef * titleArray , CFArrayRef * summaryArray))
   (Open (:pointer :callback))                  ;((OSStatus , Open) (PMPDEContext context))
   (Close (:pointer :callback))                 ;((OSStatus , Close) (PMPDEContext context))
   (Terminate (:pointer :callback))             ;((OSStatus , Terminate) (PMPDEContext context , OSStatus status))
)
;  Some commonly used routines used by PDEs 

(deftrap-inline "_PMCreateLocalizedPaperSizeCFString" 
   ((listofPaperTickets (:pointer :OpaquePMTicketRef))
    (paperToUse :UInt16)
   )
   (:pointer :__CFString)
() )
;  Lower level version of the same function, this time passing the single PaperInfo.

(deftrap-inline "_PMCreatePaperSizeCFString" 
   ((selectedPaper (:pointer :OpaquePMTicketRef))
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_PMUpdatePrintButton" 
   ((dest :UInt16)
   )
   nil
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __PMPRINTINGDIALOGEXTENSIONS__ */


(provide-interface "PMPrintingDialogExtensions")