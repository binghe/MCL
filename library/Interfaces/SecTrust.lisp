(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SecTrust.h"
; at Sunday July 2,2006 7:31:43 pm.
; 
;  * Copyright (c) 2002 Apple Computer, Inc. All Rights Reserved.
;  * 
;  * The contents of this file constitute Original Code as defined in and are
;  * subject to the Apple Public Source License Version 1.2 (the 'License').
;  * You may not use this file except in compliance with the License. Please obtain
;  * a copy of the License at http://www.apple.com/publicsource and read it before
;  * using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS
;  * OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES, INCLUDING WITHOUT
;  * LIMITATION, ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
;  * PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT. Please see the License for the
;  * specific language governing rights and limitations under the License.
;  
; !
; 	@header SecTrust
; 	The functions and data types in SecTrust implement trust computation and allows the user to apply trust decisions to the trust configuration.
; 
; #ifndef _SECURITY_SECTRUST_H_
; #define _SECURITY_SECTRUST_H_

(require-interface "Security/SecBase")

(require-interface "Security/cssmtype")

(require-interface "Security/cssmapple")

(require-interface "CoreFoundation/CoreFoundation")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
; !
; 	@typedef SecTrustResultType
; 	@abstract Specifies the trust result type.
; 	@constant kSecTrustResultInvalid Indicates an invalid setting or result.
; 	@constant kSecTrustResultProceed Indicates you may proceed.  This value may be returned by the SecTrustEvaluate function or stored as part of the user trust settings. 
; 	@constant kSecTrustResultConfirm Indicates confirmation with the user is required before proceeding.  This value may be returned by the SecTrustEvaluate function or stored as part of the user trust settings. 
; 	@constant kSecTrustResultDeny Indicates a user-configured deny; do not proceed. This value may be returned by the SecTrustEvaluate function or stored as part of the user trust settings. 
; 	@constant kSecTrustResultUnspecified Indicates user intent is unknown. This value may be returned by the SecTrustEvaluate function or stored as part of the user trust settings. 
; 	@constant kSecTrustResultRecoverableTrustFailure Indicates a trust framework failure; retry after fixing inputs. This value may be returned by the SecTrustEvaluate function but not stored as part of the user trust settings. 
; 	@constant kSecTrustResultFatalTrustFailure Indicates a trust framework failure; no "easy" fix. This value may be returned by the SecTrustEvaluate function but not stored as part of the user trust settings.
; 	@constant kSecTrustResultOtherError Indicates a failure other than that of trust evaluation. This value may be returned by the SecTrustEvaluate function but not stored as part of the user trust settings.
;  

(defconstant $kSecTrustResultInvalid 0)
(defconstant $kSecTrustResultProceed 1)
(defconstant $kSecTrustResultConfirm 2)
(defconstant $kSecTrustResultDeny 3)
(defconstant $kSecTrustResultUnspecified 4)
(defconstant $kSecTrustResultRecoverableTrustFailure 5)
(defconstant $kSecTrustResultFatalTrustFailure 6)
(defconstant $kSecTrustResultOtherError 7)
(def-mactype :SecTrustResultType (find-mactype ':SINT32))
; !
; 	@typedef SecTrustUserSetting
; 	@abstract Specifies user-specified trust settings.
; 

(def-mactype :SecTrustUserSetting (find-mactype ':SInt32))
; !
; 	@typedef SecTrustRef
; 	@abstract A pointer to an opaque trust management structure.
; 

(def-mactype :SecTrustRef (find-mactype '(:pointer :OpaqueSecTrustRef)))
; !
; 	@function SecTrustGetTypeID
; 	@abstract Returns the type identifier of SecTrust instances.
; 	@result The CFTypeID of SecTrust instances.
; 

(deftrap-inline "_SecTrustGetTypeID" 
   (
   )
   :UInt32
() )
; !
; 	@function SecTrustCreateWithCertificates
; 	@abstract Creates a trust based on the given certificates and policies.
;     @param certificates The group of certificates to verify.
;     @param policies An array of one or more policies. You may pass a SecPolicyRef
; 		to represent a single policy.
; 	@param trustRef On return, a pointer to the trust management reference.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecTrustCreateWithCertificates" 
   ((certificates (:pointer :__CFArray))
    (policies (:pointer :void))
    (trustRef (:pointer :SECTRUSTREF))
   )
   :SInt32
() )
; !
; 	@function SecTrustSetParameters
; 	@abstract Sets the action and action data for a trust.
; 	@param trustRef The reference to the trust to change.
; 	@param action A CSSM trust action.
; 	@param actionData A reference to action data.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
;  

(deftrap-inline "_SecTrustSetParameters" 
   ((trustRef (:pointer :OpaqueSecTrustRef))
    (action :UInt32)
    (actionData (:pointer :__CFData))
   )
   :SInt32
() )
; !
; 	@function SecTrustSetAnchorCertificates
; 	@abstract Sets the anchor certificates for a given trust.
; 	@param trust A reference to a trust.
; 	@param anchorCertificates An array of anchor certificates.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecTrustSetAnchorCertificates" 
   ((trust (:pointer :OpaqueSecTrustRef))
    (anchorCertificates (:pointer :__CFArray))
   )
   :SInt32
() )
; !
; 	@function SecTrustSetKeychains
; 	@abstract Sets the keychains for a given trust.
; 	@param trust A reference to a trust.
;     @param keychainOrArray An reference to an array of keychains to search, a single keychain or NULL to search the user's default keychain search list.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecTrustSetKeychains" 
   ((trust (:pointer :OpaqueSecTrustRef))
    (keychainOrArray (:pointer :void))
   )
   :SInt32
() )
; !
; 	@function SecTrustSetVerifyDate
; 	@abstract Verifies the date of a given trust.
; 	@param trust A reference to the trust to verify.
; 	@param verifyDate The date to verify.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecTrustSetVerifyDate" 
   ((trust (:pointer :OpaqueSecTrustRef))
    (verifyDate (:pointer :__CFDate))
   )
   :SInt32
() )
; !
; 	@function SecTrustEvaluate
; 	@abstract Evaluates a trust.
; 	@param trust A reference to the trust to evaluate.
; 	@param result A pointer to a result type.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).	
; 

(deftrap-inline "_SecTrustEvaluate" 
   ((trust (:pointer :OpaqueSecTrustRef))
    (result (:pointer :SecTrustResultType))
   )
   :SInt32
() )
; !
; 	@function SecTrustGetResult
; 	@abstract Returns detail information on the outcome of a call to SecTrustEvaluate.
; 	@param trustRef A reference to a trust.
; 	@param result A pointer to the result from the call to SecTrustEvaluate.
; 	@param certChain On return, a pointer to the certificate chain used to validate the input certificate.
; 	@param statusChain On return, a pointer to the status of the certificate chain.  Do not attempt to free this pointer; it remains valid until the trust is destroyed or the next call to SecTrustEvaluate.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecTrustGetResult" 
   ((trustRef (:pointer :OpaqueSecTrustRef))
    (result (:pointer :SecTrustResultType))
    (certChain (:pointer :CFArrayRef))
    (statusChain (:pointer :cssm_tp_apple_evidence_info))
   )
   :SInt32
() )
; !
; 	@function SecTrustGetCssmResult
; 	@abstract Gets the CSSM trust result.
; 	@param trust A reference to a trust.
; 	@param result On return, a pointer to the CSSM trust result.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecTrustGetCssmResult" 
   ((trust (:pointer :OpaqueSecTrustRef))
    (result (:pointer :CSSM_TP_VERIFY_CONTEXT_RESULT_PTR))
   )
   :SInt32
() )
; !
; 	@function SecTrustGetTPHandle
; 	@abstract Gets the CSSM trust handle
; 	@param trust A reference to a trust.
; 	@param handle On return, a pointer to a CSSM trust handle.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecTrustGetTPHandle" 
   ((trust (:pointer :OpaqueSecTrustRef))
    (handle (:pointer :CSSM_TP_HANDLE))
   )
   :SInt32
() )
; !
; 	@function SecTrustCopyAnchorCertificates
; 	@abstract Returns the anchor (root) certificates.
;     @param anchors On return, a pointer to the anchors (roots).  This may be used with the function SecCertificateGroupVerify.  Call the CFRelease function to release this pointer.
;     @result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecTrustCopyAnchorCertificates" 
   ((anchors (:pointer :CFArrayRef))
   )
   :SInt32
() )
; !
; 	@function SecTrustGetCSSMAnchorCertificates
; 	@abstract Retrieves the CSSM anchor certificates.
; 	@param cssmAnchors A pointer to an array of anchor certificates.
; 	@param cssmAnchorCount A pointer to the number of certificates in anchors.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecTrustGetCSSMAnchorCertificates" 
   ((cssmAnchors (:pointer :CSSM_DATA))
    (cssmAnchorCount (:pointer :UInt32))
   )
   :SInt32
() )
; !
; 	@function SecTrustGetUserTrust
; 	@abstract Gets the user-specified trust settings of a certificate and policy.
; 	@param certificate A reference to a certificate.
; 	@param policy A reference to a policy.
; 	@param trustSetting On return, a pointer to the user specified trust settings.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecTrustGetUserTrust" 
   ((certificate (:pointer :OpaqueSecCertificateRef))
    (policy (:pointer :OpaqueSecPolicyRef))
    (trustSetting (:pointer :SECTRUSTUSERSETTING))
   )
   :SInt32
() )
; !
; 	@function SecTrustSetUserTrust
; 	@abstract Sets the user-specified trust settings of a certificate and policy.
; 	@param certificate A reference to a certificate.
; 	@param policy A reference to a policy.
; 	@param trustSetting The user-specified trust settings.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecTrustSetUserTrust" 
   ((certificate (:pointer :OpaqueSecCertificateRef))
    (policy (:pointer :OpaqueSecPolicyRef))
    (trustSetting :SInt32)
   )
   :SInt32
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* !_SECURITY_SECTRUST_H_ */


(provide-interface "SecTrust")