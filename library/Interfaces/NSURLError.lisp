(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSURLError.h"
; at Sunday July 2,2006 7:31:04 pm.
; 	
;     NSURLError.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 
;  Note: To use the APIs described in these headers, you must perform
;  a runtime check for Foundation-462.1 or later.

; #import <AvailabilityMacros.h>

; #if defined(MAC_OS_X_VERSION_10_2) && (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2)
; 
;     @discussion Constants used by NSError to differentiate between "domains" of error codes, 
;     serving as a discriminator for error codes that originate from different subsystems or sources.
;     @constant WebFoundationErrorDomain Indicates a WebFoundation error.
; 
(def-mactype :NSURLErrorDomain (find-mactype '(:pointer :NSString)))
; !
;     @const NSErrorFailingURLStringKey
;     @abstract The NSError userInfo dictionary key used to store and retrieve 
;     the URL which caused a load to fail.
; 
(def-mactype :NSErrorFailingURLStringKey (find-mactype '(:pointer :NSString)))
; !
;     @enum NSURL-related Error Codes
;     @abstract Constants used by NSError to indicate errors in the WebFoundation domain
;     @discussion Documentation on each constant forthcoming.
; 

(defconstant $NSURLErrorUnknown -1)
(defconstant $NSURLErrorCancelled -999)
(defconstant $NSURLErrorBadURL -1000)
(defconstant $NSURLErrorTimedOut -1001)
(defconstant $NSURLErrorUnsupportedURL -1002)
(defconstant $NSURLErrorCannotFindHost -1003)
(defconstant $NSURLErrorCannotConnectToHost -1004)
(defconstant $NSURLErrorNetworkConnectionLost -1005)
(defconstant $NSURLErrorDNSLookupFailed -1006)
(defconstant $NSURLErrorHTTPTooManyRedirects -1007)
(defconstant $NSURLErrorResourceUnavailable -1008)
(defconstant $NSURLErrorNotConnectedToInternet -1009)
(defconstant $NSURLErrorRedirectToNonExistentLocation -1010)
(defconstant $NSURLErrorBadServerResponse -1011)
(defconstant $NSURLErrorUserCancelledAuthentication -1012)
(defconstant $NSURLErrorUserAuthenticationRequired -1013)
(defconstant $NSURLErrorZeroByteResource -1014)
(defconstant $NSURLErrorFileDoesNotExist -1100)
(defconstant $NSURLErrorFileIsDirectory -1101)
(defconstant $NSURLErrorNoPermissionsToReadFile -1102)
(defconstant $NSURLErrorSecureConnectionFailed -1200)
(defconstant $NSURLErrorServerCertificateHasBadDate -1201)
(defconstant $NSURLErrorServerCertificateUntrusted -1202)
(defconstant $NSURLErrorServerCertificateHasUnknownRoot -1203)
(defconstant $NSURLErrorCannotLoadFromNetwork -2000);  Download and file I/O errors

(defconstant $NSURLErrorCannotCreateFile -3000)
(defconstant $NSURLErrorCannotOpenFile -3001)
(defconstant $NSURLErrorCannotCloseFile -3002)
(defconstant $NSURLErrorCannotWriteToFile -3003)
(defconstant $NSURLErrorCannotRemoveFile -3004)
(defconstant $NSURLErrorCannotMoveFile -3005)
(defconstant $NSURLErrorDownloadDecodingFailedMidStream -3006)
(defconstant $NSURLErrorDownloadDecodingFailedToComplete -3007)
; #endif


(provide-interface "NSURLError")