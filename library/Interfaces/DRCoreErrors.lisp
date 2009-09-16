(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRCoreErrors.h"
; at Sunday July 2,2006 7:27:36 pm.
; 
;      File:       DiscRecordingEngine/DRCoreErrors.h
;  
;      Contains:   Error code interfaces for Disc Recording.
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; !
; 	@header	DRCoreErrors
; 	
; 	This header contains all of the error codes Disc Recording defines. 
; 	
; 	In addition Disc Recording provides functions to map OS errors it defines and sense information
; 	returned from device command errors	to localized string representations.
; 
; #ifndef _H_DRCoreErrors
; #define _H_DRCoreErrors

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __AVAILABILITYMACROS__

(require-interface "AvailabilityMacros")

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(defconstant $kDRFirstErr #x80020000)
(defconstant $kDRInternalErr #x80020000)        ;  Internal Disc Recording error. 

(defconstant $kDRDeviceAccessErr #x80020020)    ;  Device is not accessible, hardware is disconnected, etc. 

(defconstant $kDRDeviceBusyErr #x80020021)      ;  Device is in use by another process 

(defconstant $kDRDeviceCommunicationErr #x80020022);  Device failed to respond properly, unable to recover or retry. 

(defconstant $kDRDeviceInvalidErr #x80020023)   ;  Attempt was made to use an invalid DRDeviceRef. 

(defconstant $kDRDeviceNotReadyErr #x80020024)  ;  Device is unable to respond now, please try again later. 

(defconstant $kDRDeviceNotSupportedErr #x80020025);  Device is not supported for the requested burn operation. 

(defconstant $kDRMediaBusyErr #x80020040)       ;  Disc is busy, usually indicating the volume is unmountable. 

(defconstant $kDRMediaNotPresentErr #x80020041) ;  Disc isn't present, and needs to be. 

(defconstant $kDRMediaNotWritableErr #x80020042);  Disc isn't writable, and needs to be. 

(defconstant $kDRMediaNotSupportedErr #x80020043);  Disc isn't supported for the requested burn operation. 

(defconstant $kDRMediaNotBlankErr #x80020044)   ;  Disc isn't blank, and the requested operation needs it to be. 

(defconstant $kDRMediaNotErasableErr #x80020045);  Disc isn't erasable, and the requested operation needs it to be. 

(defconstant $kDRBurnUnderrunErr #x80020060)    ;  Device drained buffer without burn underrun protection. 

(defconstant $kDRBurnNotAllowedErr #x80020061)  ;  User is not allowed to burn to this device on this system. 

(defconstant $kDRDataProductionErr #x80020062)  ;  Error while producing data for the burn 

(defconstant $kDRVerificationFailedErr #x80020063);  Data verification failed 

(defconstant $kDRTooManyTracksForDVDErr #x80020064);  DVD discs can contain only one track 

(defconstant $kDRBadLayoutErr #x80020065)       ;  Too many tracks or sessions 

(defconstant $kDRUserCanceledErr #x80020066)    ;  User canceled the burn 

(defconstant $kDRFunctionNotSupportedErr #x80020067);  Track producer cannot perform requested function 
;  content errors 

(defconstant $kDRFileModifiedDuringBurnErr #x80020100);  File changed during flatten or burn 

(defconstant $kDRFileLocationConflictErr #x80020101);  Conflicting locations specified for two files 

(defconstant $kDRTooManyNameConflictsErr #x80020102);  Too many filename conflicts to resolve (10,000,000 or more) 
;  drive feature errors 

(defconstant $kDRDeviceBurnStrategyNotAvailableErr #x80020200);  Device does not support the required burn strategy for this burn 

(defconstant $kDRDeviceCantWriteIndexPointsErr #x80020202);  Device does not support writing index points 

(defconstant $kDRDeviceCantWriteISRCErr #x80020203);  Device does not support writing ISRC 

(defconstant $kDRDeviceCantWriteSCMSErr #x80020204);  Device does not support writing SCMS 

; !
; 	@function 	DRCopyLocalizedStringForDiscRecordingError
; 	@abstract 	Maps an operating system error code to a localized string.
; 	@discussion If a localized string cannot be found, this function returns the error code 
; 				as a string.
; 	@param 		osError 	The OS error code.
; 	@result 	A value of type CFStringRef which contains the localized string. 
; 				This reference is implicitly retained by the caller. 
; 

(deftrap-inline "_DRCopyLocalizedStringForDiscRecordingError" 
   ((osError :sint32)
   )
   (:pointer :__CFString)
() )
; !
; 	@function 	DRCopyLocalizedStringForSenseCode
; 	@abstract 	Maps a SCSI sense code to a localized string.
; 	@discussion This function takes a sense code and finds the corresponding localized string. 
; 				If a localized string cannot be found, it returns the sense code as a string.
; 				
; 				This function uses two files to perform its job. The <tt>SenseKey.plist</tt> file
; 				contains mappings from sense codes to the keys for the strings file. The
; 				<tt>SenseKey.strings</tt> file is a localized resource which contains language specific
; 				translations for the sense codes. The <tt>SenseKey.plist</tt> file will probably 
; 				never be modified unless more sense codes are added to the specification.
; 	@param 		senseCode 	A sense code generated by a device conforming to the SCSI standard.
; 	@result 	A value of type CFStringRef containing the localized string. 
; 				This reference is implicitly retained by the caller. 
; 

(deftrap-inline "_DRCopyLocalizedStringForSenseCode" 
   ((senseCode :UInt8)
   )
   (:pointer :__CFString)
() )
; !
; 	@function 	DRCopyLocalizedStringForAdditionalSense
; 	@abstract 	Maps the Additional Sense Code (ASC) and Additional Sense Key Qualifier (ASCQ) to a localized string.
; 	@discussion This function takes an ASC/ASCQ pair and finds the correct localized string corresponding
; 				to that pair. The function attempts to find the exact pair, followed by one of the range ASC codes.
; 				If neither of those can be found, it will determine if the pair is reserved or is a vendor specific pair and will
; 				return a string indicating that. If a localized string cannot be found, it will return the ASC and ASCQ codes 
; 				as a string.
; 				
; 				This function uses two files to perform its job. The <tt>SenseKey.plist</tt> file
; 				contains mappings from sense codes to the keys for the strings file. The
; 				<tt>SenseKey.strings</tt> file is a localized resource which contains language specific
; 				translations for the sense codes. The <tt>SenseKey.plist</tt> file will probably 
; 				never be modified unless more sense codes are added to the specification.
; 	@param 		ASC 	The Additional Sense Code generated by a device conforming the SCSI standard.
; 	@param 		ASCQ 	The Additional Sense Code Qualifier generated by a device conforming to the SCSI standard.
; 	@result 	A value of type CFStringRef containing the localized string. 
; 				This reference is implicitly retained by the caller. 
; 

(deftrap-inline "_DRCopyLocalizedStringForAdditionalSense" 
   ((ASC :UInt8)
    (ASCQ :UInt8)
   )
   (:pointer :__CFString)
() )
; !
; 	@const kDRErrorStatusKey
; 	@discussion	A key for the DRErrorStatus dictionary, returned by any of the DRxxxCopyStatus calls or
; 				kDRxxxStatusChangedNotifications, to describe a failure.  The value of this key is a
; 				CFDictionary object containing error code and device sense information.
; 
(def-mactype :kDRErrorStatusKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRErrorStatusErrorKey
; 	@discussion	A key for the DRErrorStatus dictionary. The value of this key is a CFNumber object containing
; 				the OSStatus value corresponding to the failure.
; 
(def-mactype :kDRErrorStatusErrorKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRErrorStatusErrorStringKey
; 	@discussion	A key for the DRErrorStatus dictionary. The value of this key is a CFString object containing
; 				the localized string describing the kDRErrorStatusErrorKey key.  This value is optional and
; 				may not be present if a suitable string does not exist to describe the failure.
; 
(def-mactype :kDRErrorStatusErrorStringKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRErrorStatusSenseKey
; 	@discussion	A key for the DRErrorStatus dictionary. The value of this key is a CFData object containing
; 				the device sense data describing the failure.  This value is optional and may not be
; 				present if the failure was not device-related, or if the device failed in a way which
; 				did not provide meaningful sense data.
; 
(def-mactype :kDRErrorStatusSenseKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRErrorStatusSenseCodeStringKey
; 	@discussion	A key for the DRErrorStatus dictionary. The value of this key is a CFString object containing
; 				the localized string describing the sense key from the sense data for the failure.
; 				This value is optional and will not be present if the kDRErrorStatusSenseKey key is not present
; 				or if a suitable string does not exist to describe the failure.
; 
(def-mactype :kDRErrorStatusSenseCodeStringKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDRErrorStatusAdditionalSenseStringKey
; 	@discussion	A key for the DRErrorStatus dictionary. The value of this key is a CFString object containing
; 				the localized string describing the additonal sense from the sense data for the
; 				failure.  This value is optional and will not be present if the kDRErrorStatusSenseKey key is
; 				not present or if a suitable string does not exist to describe the failure.
; 
(def-mactype :kDRErrorStatusAdditionalSenseStringKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _H_DRCoreErrors */


(provide-interface "DRCoreErrors")