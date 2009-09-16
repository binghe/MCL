(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PMErrors.h"
; at Sunday July 2,2006 7:31:10 pm.
; 
;      File:       PMErrors.h
;  
;      Contains:   Mac OS X Printing Manager Error Codes.
;  
;      Version:    Technology: Mac OS X
;                  Release:    1.0
;  
;      Copyright:  © 2001 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 	History:
; 		09/06/00	amq		Created.	
; 
; 
; #ifndef __PMERRORS__
; #define __PMERRORS__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __COREFOUNDATION__

(require-interface "CoreFoundation/CoreFoundation")

; #endif


; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

; #if PRAGMA_IMPORT
#| ; #pragma import on
 |#

; #endif


; #if PRAGMA_STRUCT_ALIGN
#| ; #pragma options align=mac68k
 |#

; #elif PRAGMA_STRUCT_PACKPUSH
#| ; #pragma pack(push, 2)
 |#

; #elif PRAGMA_STRUCT_PACK
#| ; #pragma pack(2)
 |#

; #endif


; #if 0
#|                                              ;  General error codes originally in PMDefinitions (-30870 to -30899)

(defconstant $kPMNoError 0)                     ;  no error 

(defconstant $kPMGeneralError -30870)           ;  general error 

(defconstant $kPMOutOfScope -30871)             ;  an API call is out of scope 

(defconstant $kPMInvalidParameter -50)          ;  a required parameter is missing or invalid 

(defconstant $kPMNoDefaultPrinter -30872)       ;  no default printer selected 

(defconstant $kPMNotImplemented -30873)         ;  this API call is not supported 

(defconstant $kPMNoSuchEntry -30874)            ;  no such entry 

(defconstant $kPMInvalidPrintSettings -30875)   ;  the printsettings reference is invalid 

(defconstant $kPMInvalidPageFormat -30876)      ;  the pageformat reference is invalid 

(defconstant $kPMValueOutOfRange -30877)        ;  a value passed in is out of range 
;  the lock value was ignored 

(defconstant $kPMLockIgnored 0)                 ;  the print session is invalid 

(defconstant $kPMInvalidPrinter -30880)         ;  the printer reference is invalid 

(defconstant $kPMObjectInUse -30881)            ;  the object is in use 
 |#

; #endif

;  general purpose printing error codes used by various printing modules 

(defconstant $kPMAllocationFailure -108)        ;  out of memory error 

(defconstant $kPMInternalError -30870)          ;  internal printing error 

(defconstant $kPMInvalidIndex -30882)           ;  invalid index in array 

(defconstant $kPMStringConversionFailure -30883);  error converting a string 

(defconstant $kPMXMLParseError -30884)          ;  error parsing XML data 

(defconstant $kPMInvalidJobTemplate -30885)     ;  invalid job template 

(defconstant $kPMInvalidPrinterInfo -30886)     ;  invalid printer info ticket 

(defconstant $kPMInvalidConnection -30887)      ;  invalid connection type 

(defconstant $kPMInvalidKey -30888)             ;  invalid key in ticket or template or dictionary 

(defconstant $kPMInvalidValue -30889)           ;  invalid value in ticket or template or dictionary 

(defconstant $kPMInvalidAllocator -30890)       ;  invalid memory allocator 

(defconstant $kPMInvalidTicket -30891)          ;  invalid job ticket 

(defconstant $kPMInvalidItem -30892)            ;  invalid item in ticket or template or dictionary 

(defconstant $kPMInvalidType -30893)            ;  invalid type in ticket or template or dictionary 

(defconstant $kPMInvalidReply -30894)           ;  invalid reply from a remote server/client 

(defconstant $kPMInvalidFileType -30895)        ;  invalid file type in queue 

(defconstant $kPMInvalidObject -30896)          ;  invalid object or internal error 

(defconstant $kPMInvalidPaper -30897)           ;  Invalid PMPaper. 

(defconstant $kPMInvalidCalibrationTarget -30898);  invalid dictionary specifying printer calibration target 
;  Print Job Creator and Printing Dialog Extension error codes (-9500 to -9540) 

(defconstant $kPMNoDefaultItem -9500)           ;  unused; to be removed 

(defconstant $kPMNoDefaultSettings -9501)       ;  unused; to be removed 

(defconstant $kPMInvalidPDEContext -9530)       ;  invalid printing dialog extension context 

(defconstant $kPMDontSwitchPDEError -9531)      ;  tells the pjc not to switch panels 

(defconstant $kPMUnableToFindProcess -9532)     ;  unable to find the Finder.app process 

(defconstant $kPMFeatureNotInstalled -9533)     ;  printer is feature capable, but not installed 
;  PrintCenter and Printer Browser error codes (-9540 to -9579) 

(defconstant $kPMInvalidPBMRef -9540)           ;  invalid printer browser module reference.

(defconstant $kPMNoSelectedPrinters -9541)      ;  no selected printers or error getting selection.

(defconstant $kPMInvalidLookupSpec -9542)       ;  error retrieving lookup specification. 

(defconstant $kPMSyncRequestFailed -9543)       ;  error handling sync request. 

(defconstant $kPMEditRequestFailed -9544)       ;  error handling request to update Edit menu 

(defconstant $kPMPrBrowserNoUI -9545)           ;  got UI function call with no UI present. 
;  Job Ticket error codes (-9580 to -9619) 

(defconstant $kPMTicketTypeNotFound -9580)      ;  we can't find the ticket type in our ticket. 

(defconstant $kPMUpdateTicketFailed -9581)      ;  attempt to update ticket to current API failed. 

(defconstant $kPMValidateTicketFailed -9582)    ;  ticket has at least one key that's invalid. 

(defconstant $kPMSubTicketNotFound -9583)       ;  sub ticket requested is not stored in this ticket. 

(defconstant $kPMInvalidSubTicket -9584)        ;  unable to add the requested sub-ticket. 

(defconstant $kPMDeleteSubTicketFailed -9585)   ;  sub ticket could not be deleted. 

(defconstant $kPMItemIsLocked -9586)            ;  item's locked flag was true when attempt made to update. 

(defconstant $kPMTicketIsLocked -9587)          ;  caller may not change a locked ticket. 

(defconstant $kPMTemplateIsLocked -9588)        ;  caller can't change the template. 

(defconstant $kPMKeyNotFound -9589)             ;  the requested update is for a key that doesn't exist. 

(defconstant $kPMKeyNotUnique -9590)            ;  the key passed in already exists in the ticket, can't make a new one. 

(defconstant $kPMUnknownDataType -9591)         ;  couldn't determine proper CF type for the value passed in. 
;  ClientPrintingLib (-9620 to -9629) 

(defconstant $kPMCreateMessageFailed -9620)     ;  could not create message 

(defconstant $kPMServerCommunicationFailed -9621);  communication with print server failed 

(defconstant $kPMKeyOrValueNotFound -9623)      ;  missing required key or value 

(defconstant $kPMMessagingError -9624)          ;  could not connect to message port or send a message to remote client 
;  Queue Manager (-9630 to -9659) 

(defconstant $kPMServerNotFound -9630)          ;  print server not found 

(defconstant $kPMServerAlreadyRunning -9631)    ;  print server is already running 

(defconstant $kPMServerSuspended -9632)         ;  server suspended 

(defconstant $kPMServerAttributeRestricted -9633);  access to attribute restricted 

(defconstant $kPMFileOrDirOperationFailed -9634);  file/directory operation failed 

(defconstant $kPMUserOrGroupNotFound -9635)     ;  specified user/group not found 

(defconstant $kPMPermissionError -9636)         ;  permission related error 

(defconstant $kPMUnknownMessage -9637)          ;  unknown message 

(defconstant $kPMQueueNotFound -9638)           ;  queue not found 

(defconstant $kPMQueueAlreadyExists -9639)      ;  queue already exists 

(defconstant $kPMQueueJobFailed -9640)          ;  could not queue a new job 

(defconstant $kPMJobNotFound -9641)             ;  job not found 

(defconstant $kPMJobBusy -9642)                 ;  job is busy 

(defconstant $kPMJobCanceled -9643)             ;  job has aborted 

(defconstant $kPMDocumentNotFound -9644)        ;  document not found 
;  Job Manager (-9660 to -9699) 

(defconstant $kPMPMSymbolNotFound -9660)        ;  a required printer module symbol is missing 

(defconstant $kPMIOMSymbolNotFound -9661)       ;  a required IO module symbol is missing 

(defconstant $kPMCVMSymbolNotFound -9662)       ;  a required converter module symbol is missing 

(defconstant $kPMInvalidPMContext -9663)        ;  PrinterModule context is invalid 

(defconstant $kPMInvalidIOMContext -9664)       ;  IO Module context is invalid 

(defconstant $kPMInvalidCVMContext -9665)       ;  Converter Module context is invalid 

(defconstant $kPMInvalidJobID -9666)            ;  JobID passed from Printer Module is not valid 

(defconstant $kPMNoPrinterJobID -9667)          ;  no JobID from target printer/connection 

(defconstant $kPMJobStreamOpenFailed -9668)     ;  failed to open job stream 

(defconstant $kPMJobStreamReadFailed -9669)     ;  failed to read from job stream 

(defconstant $kPMJobStreamEndError -9670)       ;  reached end of job stream 

(defconstant $kPMJobManagerAborted -9671)       ;  Job Manager is aborting 

(defconstant $kPMJobGetTicketBadFormatError -9672);  The XML for the printer module tickets could not be parsed. 

(defconstant $kPMJobGetTicketReadError -9673)   ;  There was an unknown error reading stdout from the PrintJobMgr 
;  Converters (-9700 to -9739) 

(defconstant $kPMPluginNotFound -9701)          ;  Converter plugin not found 

(defconstant $kPMPluginRegisterationFailed -9702);  Converter Plugin error 

(defconstant $kPMFontNotFound -9703)            ;  Font not found 

(defconstant $kPMFontNameTooLong -9704)         ;  font name too long 

(defconstant $kPMGeneralCGError -9705)          ;  CoreGraphics returned error 

(defconstant $kPMInvalidState -9706)            ;  Invalid converter state 
;  Printer Modules (-9740 to -9779) 
;  IO Modules (-9780 to -9799) 

(defconstant $kPMInvalidPrinterAddress -9780)   ;  a file or connection could not be open 

(defconstant $kPMOpenFailed -9781)              ;  a file or connection could not be open 

(defconstant $kPMReadFailed -9782)              ;  file/connection read failed 

(defconstant $kPMWriteFailed -9783)             ;  file/connection write failed 

(defconstant $kPMStatusFailed -9784)            ;  connection status failed 

(defconstant $kPMCloseFailed -9785)             ;  close file/connection failed 

(defconstant $kPMUnsupportedConnection -9786)   ;  connection type not supported 

(defconstant $kPMIOAttrNotAvailable -9787)      ;  IO attribute not available on current connection type 

(defconstant $kPMReadGotZeroData -9788)         ;  Read got zero bytes, but no error. 
;  End of list 

(defconstant $kPMLastErrorCodeToMakeMaintenanceOfThisListEasier -9799)

; #if PRAGMA_STRUCT_ALIGN
#| ; #pragma options align=reset
 |#

; #elif PRAGMA_STRUCT_PACKPUSH
#| ; #pragma pack(pop)
 |#

; #elif PRAGMA_STRUCT_PACK
#| ; #pragma pack()
 |#

; #endif

; #ifdef PRAGMA_IMPORT_OFF
#| #|
#pragma import off
|#
 |#

; #elif PRAGMA_IMPORT
#| ; #pragma import reset
 |#

; #endif

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __PMERRORS__ */


(provide-interface "PMErrors")