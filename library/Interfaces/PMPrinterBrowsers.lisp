(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PMPrinterBrowsers.h"
; at Sunday July 2,2006 7:31:13 pm.
; 
;  	File:		PMPrinterBrowsers.h
;  
;  	Contains:	Mac OS X Printing Manager Printer Browser Module Interfaces
;  
;  	Version:	Technology:	Tioga Kitchen
;  				Release:	1.0
;  
;  	Copyright:	© 1999-2001 by Apple Computer, Inc., all rights reserved
;  
;  	Bugs?:		For bug reports, consult the following page on
;  				the World Wide Web:
;  
;  					http://developer.apple.com/bugreporter/
;  
; 
; 
; #ifndef __PMPRINTERBROWSERS__
; #define __PMPRINTERBROWSERS__

(require-interface "ApplicationServices/ApplicationServices")

(require-interface "CoreFoundation/CoreFoundation")

(require-interface "CoreFoundation/CFBundle")

(require-interface "Carbon/Carbon")

; #if COREFOUNDATION_CFPLUGINCOM_SEPARATE

(require-interface "CoreFoundation/CFPlugInCOM")

; #endif /* COREFOUNDATION_CFPLUGINCOM_SEPARATE */

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 	Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
; Invalid printer browser reference number.
; 
; #define	kPMPrBrowserInvalidRef			-1
; 
; Current version of the printer browser module API, which specifies the format
; of the functions and various structures used in the API.
; 
(defconstant $kPMPrBrowserAPIVersion 1)
; #define	kPMPrBrowserAPIVersion	1
; 
; Constants required for retrieving standard icons supplied by PrintCenter...
; 
; Any standard icons supplied by PrintCenter for use in displaying printer
; browser HI will have been registered with Icon Services when the printer
; browser module is loaded. The printer browser module need only call GetIconRef()
; with the appropriate constants to obtain a reference to the required icon.
; 
; PrintCenter creator code.
; 
(defconstant $kPMPrBrowserPCCreator "pctr")
; #define	kPMPrBrowserPCCreator					'pctr'
(defconstant $kPMPrBrowserWorksetPrinterIconType "wspr")
; #define	kPMPrBrowserWorksetPrinterIconType		'wspr'
(defconstant $kPMPrBrowserUnknownPrinterIconType "?ptr")
; #define kPMPrBrowserUnknownPrinterIconType		'?ptr'
; 
; PrintCenter flags...
; 
; These flags are passed by PrintCenter in the Prologue() function.
; 

(defconstant $kPMPrBrowserPCNoFlags 0)          ;  Empty flag word. 

(defconstant $kPMPrBrowserPCNoUI 1)             ;  PBM will be loaded without UI. 

(defconstant $kPMPrBrowserPCGetTitle 16)        ;  [Internal] used to obtain the title for the browser [never passed to plugins] 
;  All flags set. 

(defconstant $kPMPrBrowserPCAllFlags (- $UINT32 1))
; 
; Printer browser module CFPlugIn constants.
; 
; Define the CFPlugIn Type for printer browser modules. All printer browser modules
; must be plug-ins of this type.
; 
; Users of these IDs should convert these to CFStrings (probably using the CFSTR
; macro) and then call CFUUIDCreateFromString() to obtain a CFUUIDRef. Note that
; the CFUUIDRef may refer to an existing CFUUID, so the caller should call
; CFRelease() on the CFUUIDRef() when he no longer needs it.
; 
(defconstant $kPMPrBrowserPlugInType "23F71E46-95CC-1226-AC04-000502ADB00B")
; #define kPMPrBrowserPlugInType	"23F71E46-95CC-1226-AC04-000502ADB00B"
; 
; Define the ID of the Interface that supplies the APIVersion() function. All
; printer browser modules must supply this Interface.
; 
(defconstant $kPMInterfaceAPIVersion "1D6BF822-95D0-1226-A8ED-000502ADB00B")
; #define kPMInterfaceAPIVersion	"1D6BF822-95D0-1226-A8ED-000502ADB00B"
; 
; Define the ID of the Interface that supplies the printer browser module API. All
; printer browser modules must supply this Interface.
; 
(defconstant $kPMInterfacePrBrowser "86544C22-95D0-1226-91D5-000502ADB00B")
; #define kPMInterfacePrBrowser	"86544C22-95D0-1226-91D5-000502ADB00B"
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 	Type Definitions
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
; Basic types...
; 

(def-mactype :PMPrBrowserRef (find-mactype ':SInt32))
;  Printer browser module reference. 

(def-mactype :PMPrBrowserContext (find-mactype ':UInt32))
;  PB Module private context. 

(def-mactype :PMPrBrowserFlags (find-mactype ':UInt32))
;  PB Module feature request flags. 
; 
; Printer browser module-specific keys for the printer lookup specification 
; dictionary. This CFDictionary is supplied by the printer module and provides 
; the printer browser module with the information it needs to browse for a given 
; type of printer over its connection type, and to display it in the browser 
; view.
; 
; The printer module supplies the following keys and values (these are more 
; fully defined in PMPrinterModule.h):
; 
; kPMPrBrowserLookupKindKey: a CFStringRef to a human-readable printer type 
; string that can be displayed in the browser view.
; 
; kPMPrBrowserLookupInfoKey: a CFPropertyListRef to connection-specific 
; information used to look up a particular kind of printer over a given IO 
; connection.
; 
; kPMPrBrowserLookupIconKey: a CFDataRef to the icon family data for the 
; printer icon to be displayed in the browser view.
; 
; In addition, PrintCenter adds the following information to the lookup
; specification dictionary:
; 
; kPMPrBrowserLookupRefKey: a CFTypeRef to PrintCenter-specific information 
; that must be returned by the printer browser module in the printer selection 
; specfication dictionary (see below) when a printer is selected that was 
; located using this lookup specification.
; 
; PrintCenter informs the printer browser module of the number of lookup
; specification dictionaries that are available when the module's Initialize()
; function is called. Thereafter, the printer browser module can obtain
; a copy of any of the lookup specification dictionaries by calling the
; PMPrBrowserGetLookupSpec callback and specifying an index between 0 and n-1, 
; where n is the number of lookup specification dictionaries.
; 
; PrintCenter creates a full copy of the printer lookup specification dictionary
; before passing it to the printer browser module; the printer browser module
; should call ::CFRelease() on the dictionary when it is no longer needed.
; 
(defconstant $kPMPrBrowserLookupRefStr "PrBrowser Lookup Reference")
; #define	kPMPrBrowserLookupRefStr	"PrBrowser Lookup Reference"
; #define	kPMPrBrowserLookupRefKey	CFSTR(kPMPrBrowserLookupRefStr)		// CFTypeRef
; 
; Keys for the printer selection specification dictionary. This CFDictionary 
; specifies the printers selected in the browser view. An array of these
; dictionaries is is passed back to PrintCenter when it calls the printer
; browser module's GetSelectedPrinters() function. 
; 
; An array of selection specification dictionaries is passed from PrintCenter
; to the printer browser module when PrintCenter calls the WorksetPrinters()
; function. These dictionaries specify which printers are already in the
; Workset. The printer browser module can use this information to indicate in
; its UI whether a printer has been added to the Workset. It can also use
; this information in non-UI mode to avoid supplying duplicate printers during
; automatic printer discovery.
; 
; kPMPrBrowserSelectNameKey corresponds to a CFStringRef to a human-readable 
; printer name string, obtained from the printer or otherwise constructed by 
; the printer browser module.
; 
; kPMPrBrowserSelectKindKey corresponds to a CFStringRef to a human-readable 
; printer description string that can be displayed in the PrintCenter Workset
; window. For printer that uses Apple's PostScript printer module over an 
; AppleTalk connection, this would be the string "PostScript printer". Often 
; this is the same as the string corresponding to kPMPrBrowserLookupKindKey
; in the printer lookup specification dictionary, but it is possible that 
; more specific printer model information might be obtained by the printer
; browser module during the lookup.
; 
; kPMPrBrowserSelectAddrKey corresponds to a CFDataRef to a connection-specific 
; address specification for the printer. On an AppleTalk connection, this would 
; be a standard NBP address of the form <name>:<type>@<zone>.
; 
; kPMPrBrowserSelectRefKey corresponds to a CFTypeRef whose value is the same
; as that corresponding to kPMPrBrowserLookupRefKey in the printer lookup
; specification dictionary. The reference value in the lookup specification
; dictionary that was used to locate the selected printer must be copied into
; the printer selection specification dictionary and assigned this key.
; 
; When PrintCenter supplies printer selection specification dictionaries using
; the WorksetPrinters() function, the dictionaries do not contain a
; kPMPrBrowserSelectRefKey entry; the printer browser module should not expect
; to find a corresponding value for this key in those dictionaries.
; 
; PrintCenter gets information about selected printers when it calls the
; printer browser module's GetSelectedPrinters() function.
; 
; PrintCenter will call ::CFRelease() on the printer selection specification
; dictionary when it is no longer needed.
; 
; The printer browser module should call ::CFRelease() on the array of
; printer selection specification dictionaries supplied via the WorksetPrinters()
; function when they are no longer needed.
; 
(defconstant $kPMPrBrowserSelectNameStr "PrBrowser Selection Name")
; #define	kPMPrBrowserSelectNameStr	"PrBrowser Selection Name"
; #define	kPMPrBrowserSelectNameKey	CFSTR(kPMPrBrowserSelectNameStr)	// CFStringRef
(defconstant $kPMPrBrowserSelectKindStr "PrBrowser Selection Kind")
; #define	kPMPrBrowserSelectKindStr	"PrBrowser Selection Kind"
; #define	kPMPrBrowserSelectKindKey	CFSTR(kPMPrBrowserSelectKindStr)	// CFStringRef
(defconstant $kPMPrBrowserSelectAddrStr "PrBrowser Selection Address")
; #define	kPMPrBrowserSelectAddrStr	"PrBrowser Selection Address"
; #define	kPMPrBrowserSelectAddrKey	CFSTR(kPMPrBrowserSelectAddrStr)	// CFDataRef
(defconstant $kPMPrBrowserSelectRefStr "PrBrowser Selection Reference")
; #define	kPMPrBrowserSelectRefStr	"PrBrowser Selection Reference"
; #define	kPMPrBrowserSelectRefKey	CFSTR(kPMPrBrowserSelectRefStr)		// CFTypeRef
; 
; PrintCenter callback routines for printer browser modules.
; 
; typedef CALLBACK_API_C( OSStatus , PMPrBrowserEditStatusProcPtr )( PMPrBrowserRef ref, PMPrBrowserEditFlags editFlags );

(def-mactype :PMPrBrowserGetLookupSpecProcPtr (find-mactype ':pointer)); (PMPrBrowserRef ref , UInt32 specIndex , CFDictionaryRef * lookupSpec)

(def-mactype :PMPrBrowserSelectionStatusProcPtr (find-mactype ':pointer)); (PMPrBrowserRef ref , Boolean selected , Boolean addNow)

(def-mactype :PMPrBrowserSyncRequestProcPtr (find-mactype ':pointer)); (PMPrBrowserRef ref)
; 
; Callback parameter block.
; 
(defrecord PMPrBrowserCallbacks
   (version :SInt32)
                                                ;  Version number; always set to kPMPrBrowserAPIVersion. 
   (getLookupSpec :pointer)
   (syncRequest :pointer)
   (selStatus :pointer)
)

;type name? (%define-record :PMPrBrowserCallbacks (find-record-descriptor ':PMPrBrowserCallbacks))

(def-mactype :PMPrBrowserCallbacksPtr (find-mactype '(:pointer :PMPrBrowserCallbacks)))

(def-mactype :PMPrBrowserCallbackHdl (find-mactype '(:handle :PMPrBrowserCallbacks)))
; 
; Required entry points for printer browser modules...
; 

(def-mactype :PMPrBrowserAPIVersionProcPtr (find-mactype ':pointer)); (void)

(def-mactype :PMPrBrowserGetSelectedPrintersProcPtr (find-mactype ':pointer)); (PMPrBrowserContext context , CFArrayRef * printers)

(def-mactype :PMPrBrowserInitializeProcPtr (find-mactype ':pointer)); (PMPrBrowserContext context , PMPrBrowserRef ref , PMPrBrowserCallbacksPtr callbacks , ControlRef pbUserPaneCtlHdl , UInt32 numLookupSpecs)

(def-mactype :PMPrBrowserPrologueProcPtr (find-mactype ':pointer)); (PMPrBrowserContext * context , PMPrBrowserFlags prologueFlags , CFStringRef * title , UInt32 * minH , UInt32 * minV , UInt32 * maxH , UInt32 * maxV)

(def-mactype :PMPrBrowserResizeProcPtr (find-mactype ':pointer)); (PMPrBrowserContext context , const Rect * frameRect)

(def-mactype :PMPrBrowserSyncProcPtr (find-mactype ':pointer)); (PMPrBrowserContext context)

(def-mactype :PMPrBrowserTerminateProcPtr (find-mactype ':pointer)); (PMPrBrowserContext context , OSStatus status)

(def-mactype :PMPrBrowserWorksetPrintersProcPtr (find-mactype ':pointer)); (PMPrBrowserContext context , CFArrayRef printers)
; 
; Define the Interface structures returned by Factories.
; 
; PMInterfaceAPIVersion Interface...
; 
(defrecord PMInterfaceAPIVersion
   (u :IUNKNOWNVTBL)
                                                ;  Supplies COM compatibility; required of all CFPlugIns. 
   (apiVersion :pointer)
)

;type name? (%define-record :PMInterfaceAPIVersion (find-record-descriptor ':PMInterfaceAPIVersion))

(def-mactype :PMInterfaceAPIVersionPtr (find-mactype '(:pointer :PMInterfaceAPIVersion)))

(def-mactype :PMInterfaceAPIVersionHdl (find-mactype '(:handle :PMInterfaceAPIVersion)))
; 
; PMInterfacePrBrowser Interface...
; 
(defrecord PMInterfacePrBrowser
   (u :IUNKNOWNVTBL)
                                                ;  Supplies COM compatibility; required of all CFPlugIns. 
                                                ; 
; 	Required entry points.
; 	
   (getSelectedPrinters :pointer)
   (initialize :pointer)
   (prologue :pointer)
   (resize :pointer)
   (sync :pointer)
   (terminate :pointer)
   (worksetPrinters :pointer)
)

;type name? (%define-record :PMInterfacePrBrowser (find-record-descriptor ':PMInterfacePrBrowser))

(def-mactype :PMInterfacePrBrowserPtr (find-mactype '(:pointer :PMInterfacePrBrowser)))

(def-mactype :PMInterfacePrBrowserHdl (find-mactype '(:handle :PMInterfacePrBrowser)))
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __PMPRINTERBROWSERS__ */


(provide-interface "PMPrinterBrowsers")