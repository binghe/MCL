(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PMIOModule.h"
; at Sunday July 2,2006 7:31:11 pm.
; 
;      File:       PMIOModule.h
;  
;      Contains:   Mac OS X Printing Manager IO Module Interfaces.
;  
;      Version:    Technology: Mac OS X
;                  Release:    1.0
;  
;      Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
; 
; #ifndef __PMIOMODULE__
; #define __PMIOMODULE__

(require-interface "ApplicationServices/ApplicationServices")

(require-interface "CoreFoundation/CFString")

(require-interface "PrintCore/PMTicket")

(require-interface "PrintCore/PMPluginHeader")

(require-interface "PrintCore/PMErrors")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
;  context ID for IO Modules 

(def-mactype :IOMContext (find-mactype '(:pointer :OpaqueIOMContext)))
;  kPMPrinterURI corresponds to a CFString to a connection-specific 
; address specification for the printer. For instance, on an lpd connection  
; this would be an address of the form lpd://<host>/<queue name>. 
; #define	kPMPrinterURI					CFSTR("Printer URI")
;  System-supported connection type names used in identifying the different connection types
; and for requesting lookup information from Printer Modules. PrintCenter does not use these 
; strings in its UI, instead it gets the actual UI strings from the Printer Browser Module. 
; #define   kPMAppleTalkConnection        CFSTR("AppleTalk")
; #define   kPMUSBConnection          	CFSTR("USB")
; #define   kPMLPRConnection          	CFSTR("LPR")
; #define   kPMDirServicesConnection      CFSTR("Directory Services")
; #define	  kPMRendezvousConnection	CFSTR("Rendezvous")
;  possible attributes that can be requested from an IO Module and allow clients to determine various 
; characteristics about the IOM, its connection type, and the target printer.  The same attribute can 
; be used for getting a value or setting it. 
; #define     kPMBiDiAttr                 CFSTR("Supports BiDirectional Communication")	/* bi-directional communication capability */
; #define     kPM8BitChannelAttr          CFSTR("Supports 8-bit Channel")					/* full 8-bit per byte data (vs. 7) */	
; #define     kPMTransparentByteRange     CFSTR("Supports Transparent Byte Range")		/* transparent byte range */
; #define     kPMJobIDAttr                CFSTR("Supports JobID")							/* in-printer-jobID	*/	
; #define     kPMTimeoutAttr              CFSTR("Supports Timeout")						/* get/set timeout duration */
; #define     kPMTStatusAttr              CFSTR("Supports T Status Request")				/* status on the T channel */
;  Used with the IOMGetAttribute call, a supporting IO Module will hand back
;  * a copy of a CFStringRef describing the last error encountered. If there was
;  * no last error, or if there is no available string then NULL is passed back.
;  
; #define	    kPMLastErrorStrAttr		CFSTR("Last Error")
;  Type ID, interface ID for the IOM CFPlugin 
(defconstant $kIOModuleTypeIDStr "EE5A5E5C-C2DD-11D3-84B5-00050209D9C1")
; #define  kIOModuleTypeIDStr     "EE5A5E5C-C2DD-11D3-84B5-00050209D9C1"
(defconstant $kIOModuleIntfIDStr "F4F7510C-C2DD-11D3-93A5-00050209D9C1")
; #define  kIOModuleIntfIDStr     "F4F7510C-C2DD-11D3-93A5-00050209D9C1"
;  IOM API version numbers (see PMPluginHeader.h for the meaning of these defintions) 
(defconstant $kIOMBuildVersionMajor 1)
; #define  kIOMBuildVersionMajor  1
(defconstant $kIOMBuildVersionMinor 0)
; #define  kIOMBuildVersionMinor  0
(defconstant $kIOMBaseVersionMajor 1)
; #define  kIOMBaseVersionMajor   1
(defconstant $kIOMBaseVersionMinor 0)
; #define  kIOMBaseVersionMinor   0
;  IOMProcs contains the routines required to be exported by an IOM Module. 
(defrecord IOMProcs
                                                ;  The plugin header is required with all plugins and must proceed object's layout.
   (pluginHeader :PMPLUGINHEADER)
                                                ;  The actual IO Module routine Procs
                                                ;  GetConnectionInfo: returns the connection type and the path to the companion browser module
                                                ;  relative to the IOM 
                                                ;  The connection types: AppleTalk, USB, LPR, and Directory Services are reserved by Apple.
   (GetConnectionInfo (:pointer :callback))     ;((OSStatus , GetConnectionInfo) (CFStringRef * connectionType , CFStringRef * pbmPath))
                                                ;  Initialize: creates a context to store local variables during an IO session.  printerAddress of
                                                ;  the target printer is passed as CFDataRef as defined by the protocol and set by the Printer Browser Module
   (Initialize (:pointer :callback))            ;((OSStatus , Initialize) (const CFDataRef printerAddress , IOMContext * ioModuleContextPtr))
                                                ;  Open: open IO connection with the target device.  The parameter buffSize is set
                                                ;  by the IOM to return its maximum write buffer size.
   (Open (:pointer :callback))                  ;((OSStatus , Open) (IOMContext ioModuleContext , PMTicketRef jobTicket , UInt32 * bufferSize))
                                                ;  Read: read data from the device over the read channel, if any.  
   (Read (:pointer :callback))                  ;((OSStatus , Read) (IOMContext ioModuleContext , Ptr buffer , UInt32 * size , Boolean * eoj))
                                                ;  Write: write data to the device
   (Write (:pointer :callback))                 ;((OSStatus , Write) (IOMContext ioModuleContext , Ptr buffer , UInt32 * size , Boolean eoj))
                                                ;  Status: get status from the device
   (Status (:pointer :callback))                ;((OSStatus , Status) (IOMContext ioModuleContext , CFStringRef * status))
                                                ;  GetAttribute: checks if a defined IO attribute is supported by the target IO connection.  If the requested 
                                                ;  'attribute' is supported and available, it's returned in 'result'.  If supported but not available, error code 
                                                ;  kAttrNotAvailable is returned.  If the attribute is not supported, kPMNotImplemented is returned.
   (GetAttribute (:pointer :callback))          ;((OSStatus , GetAttribute) (IOMContext ioModuleContext , CFStringRef attribute , CFTypeRef * result))
                                                ;  SetAttribute: sets a pre-defined 'attribute' to a given value passed in 'data'.  Only supported attributes
                                                ;  can be set; otherwise kAttrNotAvailable or kPMNotImplemented is returned.
   (SetAttribute (:pointer :callback))          ;((OSStatus , SetAttribute) (IOMContext ioModuleContext , CFStringRef attribute , CFTypeRef data))
                                                ;  Close: close IO connection with the target device.  The parameter 'abort' indicates whether the current job
                                                ;  is to be canceled before closing connection (true; i.e. user cancels) or not (false; i.e. normal job completion).
   (Close (:pointer :callback))                 ;((OSStatus , Close) (IOMContext ioModuleContext , Boolean abort))
                                                ;  Terminate: dispose of any data allocated in Initialize.
   (Terminate (:pointer :callback))             ;((OSStatus , Terminate) (IOMContext * ioModuleContextPtr))
)
;  IOM interface is an object containing addresses to the module's entry points:
(defrecord IOMInterface
   (vtable (:pointer :IOMPROCS))
)

(def-mactype :IOMInterfaceRef (find-mactype '(:pointer :IOMInterface)))
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __PMIOMODULE__ */


(provide-interface "PMIOModule")