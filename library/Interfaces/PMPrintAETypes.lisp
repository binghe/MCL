(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PMPrintAETypes.h"
; at Sunday July 2,2006 7:24:43 pm.
; 
;      File:       PMPrintAETypes.h
;  
;      Contains:   Mac OS X Printing Manager AE definitions.
;  
;      Version:    Technology: Mac OS X
;                  Release:    1.0
;  
;      Copyright:  © 2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
; 
; #ifndef __PMPrintAETypes__
; #define __PMPrintAETypes__

(require-interface "AvailabilityMacros")

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
(defconstant $kPMPrintSettingsAEType "pset")
; #define	kPMPrintSettingsAEType			'pset'
(defconstant $kPMShowPrintDialogAEType "pdlg")
; #define kPMShowPrintDialogAEType		'pdlg'
(defconstant $kPMPrinterAEType "trpr")
; #define kPMPrinterAEType				'trpr'
(defconstant $kPMCopiesAEProp "copies")
; #define kPMCopiesAEProp					"copies"
(defconstant $kPMCopiesAEKey "lwcp")
; #define kPMCopiesAEKey					'lwcp'
; #define kPMCopieAEType					typeSInt32
(defconstant $kPMCollateAEProp "collating")
; #define kPMCollateAEProp				"collating"
(defconstant $kPMCollateAEKey "lwcl")
; #define kPMCollateAEKey					'lwcl'
; #define kPMCollateAEType				typeBoolean
(defconstant $kPMFirstPageAEProp "starting page")
; #define kPMFirstPageAEProp				"starting page"
(defconstant $kPMFirstPageAEKey "lwfp")
; #define kPMFirstPageAEKey				'lwfp'
; #define kPMFirstPageAEType				typeSInt32
(defconstant $kPMLastPageAEProp "ending page")
; #define kPMLastPageAEProp				"ending page"
(defconstant $kPMLastPageAEKey "lwlp")
; #define kPMLastPageAEKey				'lwlp'
; #define kPMLastPageAEType				typeSInt32
(defconstant $kPMLayoutAcrossAEProp "pages across")
; #define kPMLayoutAcrossAEProp				"pages across"
(defconstant $kPMLayoutAcrossAEKey "lwla")
; #define kPMLayoutAcrossAEKey				'lwla'
; #define kPMLayoutAcrossAEType				typeSInt32
(defconstant $kPMLayoutDownAEProp "pages down")
; #define kPMLayoutDownAEProp				"pages down"
(defconstant $kPMLayoutDownAEKey "lwld")
; #define kPMLayoutDownAEKey				'lwld'
; #define kPMLayoutDownAEType				typeSInt32
(defconstant $kPMErrorHandlingAEProp "error handling")
; #define kPMErrorHandlingAEProp				"error handling"
(defconstant $kPMErrorHandlingAEKey "lweh")
; #define kPMErrorHandlingAEKey				'lweh'
; #define kPMErrorHandlingAEType				typeEnumerated
(defconstant $kPMPrintTimeAEProp "requested print time")
; #define kPMPrintTimeAEProp				"requested print time"
(defconstant $kPMPrintTimeAEKey "lwqt")
; #define kPMPrintTimeAEKey				'lwqt'
; #define kPMPrintTimeAEType				cLongDateTime
(defconstant $kPMFeatureAEProp "printer features")
; #define kPMFeatureAEProp				"printer features"
(defconstant $kPMFeatureAEKey "lwpf")
; #define kPMFeatureAEKey					'lwpf'
; #define kPMFeatureAEType				typeAEList
(defconstant $kPMFaxNumberAEProp "fax number")
; #define	kPMFaxNumberAEProp				"fax number"
(defconstant $kPMFaxNumberAEKey "faxn")
; #define kPMFaxNumberAEKey				'faxn'
; #define kPMFaxNumberAEType				typeChar
(defconstant $kPMTargetPrinterAEProp "target printer")
; #define kPMTargetPrinterAEProp			"target printer"
(defconstant $kPMTargetPrinterAEKey "trpr")
; #define kPMTargetPrinterAEKey			'trpr'
; #define kPMTargetPrinterAEType			typeChar
; ** Enumerations **
;  For kPMErrorHandlingAEType 
(defconstant $kPMErrorHandlingStandardEnum "lwst")
; #define kPMErrorHandlingStandardEnum		'lwst'
(defconstant $kPMErrorHandlingDetailedEnum "lwdt")
; #define kPMErrorHandlingDetailedEnum		'lwdt'
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif		// __PRINTAETYPES__


(provide-interface "PMPrintAETypes")