(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:KeychainCore.h"
; at Sunday July 2,2006 7:23:37 pm.
; 
;      File:       SecurityCore/KeychainCore.h
;  
;      Contains:   Keychain low-level Interfaces
;  
;      Version:    SecurityCore-60~117
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __KEYCHAINCORE__
; #define __KEYCHAINCORE__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __FILES__
#| #|
#include <CarbonCoreFiles.h>
#endif
|#
 |#
; #ifndef __ALIASES__
#| #|
#include <CarbonCoreAliases.h>
#endif
|#
 |#
; #ifndef __CODEFRAGMENTS__
#| #|
#include <CarbonCoreCodeFragments.h>
#endif
|#
 |#
; #ifndef __MACERRORS__
#| #|
#include <CarbonCoreMacErrors.h>
#endif
|#
 |#

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
; #pragma options align=mac68k
;  Data structures and types 
; #ifndef __SEC_TYPES__
; #define __SEC_TYPES__

(def-mactype :SecKeychainRef (find-mactype '(:pointer :OpaqueSecKeychainRef)))

(def-mactype :SecKeychainItemRef (find-mactype '(:pointer :OpaqueSecKeychainItemRef)))

(def-mactype :SecKeychainSearchRef (find-mactype '(:pointer :OpaqueSecKeychainSearchRef)))

(def-mactype :SecKeychainAttrType (find-mactype ':OSType))

(def-mactype :SecKeychainStatus (find-mactype ':UInt32))
(defrecord SecKeychainAttribute
   (tag :OSType)                                ;  4-byte attribute tag 
   (length :UInt32)                             ;  Length of attribute data 
   (data :pointer)                              ;  Pointer to attribute data 
)

;type name? (%define-record :SecKeychainAttribute (find-record-descriptor ':SecKeychainAttribute))

(def-mactype :SecKeychainAttributePtr (find-mactype '(:pointer :SecKeychainAttribute)))
(defrecord SecKeychainAttributeList
   (count :UInt32)                              ;  How many attributes in the array 
   (attr (:pointer :SecKeychainAttribute))      ;  Pointer to first attribute in array 
)

;type name? (%define-record :SecKeychainAttributeList (find-record-descriptor ':SecKeychainAttributeList))

; #endif


(def-mactype :KCRef (find-mactype ':SecKeychainRef))

(def-mactype :KCItemRef (find-mactype ':SecKeychainItemRef))

(def-mactype :KCSearchRef (find-mactype ':SecKeychainSearchRef))

(%define-record :KCAttribute (find-record-descriptor ':SecKeychainAttribute))

(%define-record :KCAttributeList (find-record-descriptor ':SecKeychainAttributeList))

(def-mactype :KCAttrType (find-mactype ':OSType))

(def-mactype :KCStatus (find-mactype ':UInt32))

(def-mactype :KCEvent (find-mactype ':UInt16))

(defconstant $kIdleKCEvent 0)                   ;  null event 

(defconstant $kLockKCEvent 1)                   ;  a keychain was locked 

(defconstant $kUnlockKCEvent 2)                 ;  a keychain was unlocked 

(defconstant $kAddKCEvent 3)                    ;  an item was added to a keychain 

(defconstant $kDeleteKCEvent 4)                 ;  an item was deleted from a keychain 

(defconstant $kUpdateKCEvent 5)                 ;  an item was updated 

(defconstant $kPasswordChangedKCEvent 6)        ;  the keychain identity was changed 

(defconstant $kSystemKCEvent 8)                 ;  the keychain client can process events 

(defconstant $kDefaultChangedKCEvent 9)         ;  the default keychain was changed 

(defconstant $kDataAccessKCEvent 10)            ;  a process has accessed a keychain item's data 

(defconstant $kKeychainListChangedKCEvent 11)   ;  the list of keychains has changed 


(def-mactype :KCEventMask (find-mactype ':UInt16))

(defconstant $kIdleKCEventMask 1)
(defconstant $kLockKCEventMask 2)
(defconstant $kUnlockKCEventMask 4)
(defconstant $kAddKCEventMask 8)
(defconstant $kDeleteKCEventMask 16)
(defconstant $kUpdateKCEventMask 32)
(defconstant $kPasswordChangedKCEventMask 64)
(defconstant $kSystemEventKCEventMask #x100)
(defconstant $kDefaultChangedKCEventMask #x200)
(defconstant $kDataAccessKCEventMask #x400)
(defconstant $kEveryKCEventMask #xFFFF)         ;  all of the above

(defrecord AFPServerSignature
   (contents (:array :UInt8 16))
)
(defrecord KCPublicKeyHash
   (contents (:array :UInt8 20))
)
(defrecord KCCallbackInfo
   (version :UInt32)
   (item (:pointer :OpaqueSecKeychainItemRef))
   (processID (:array :signed-long 2))          ;  unavailable on Mac OS X
   (event (:array :signed-long 4))              ;  unavailable on Mac OS X
   (keychain (:pointer :OpaqueSecKeychainRef))
)

;type name? (%define-record :KCCallbackInfo (find-record-descriptor ':KCCallbackInfo))

(defconstant $kUnlockStateKCStatus 1)
(defconstant $kRdPermKCStatus 2)
(defconstant $kWrPermKCStatus 4)

(defconstant $kCertificateKCItemClass :|cert|)  ;  Certificate 

(defconstant $kAppleSharePasswordKCItemClass :|ashp|);  Appleshare password 

(defconstant $kInternetPasswordKCItemClass :|inet|);  Internet password 

(defconstant $kGenericPasswordKCItemClass :|genp|);  Generic password 


(def-mactype :KCItemClass (find-mactype ':FourCharCode))
;  Common attributes 

(defconstant $kClassKCItemAttr :|clas|)         ;  Item class (KCItemClass) 

(defconstant $kCreationDateKCItemAttr :|cdat|)  ;  Date the item was created (UInt32) 

(defconstant $kModDateKCItemAttr :|mdat|)       ;  Last time the item was updated (UInt32) 

(defconstant $kDescriptionKCItemAttr :|desc|)   ;  User-visible description string (string) 

(defconstant $kCommentKCItemAttr :|icmt|)       ;  User's comment about the item (string) 

(defconstant $kCreatorKCItemAttr :|crtr|)       ;  Item's creator (OSType) 

(defconstant $kTypeKCItemAttr :|type|)          ;  Item's type (OSType) 

(defconstant $kScriptCodeKCItemAttr :|scrp|)    ;  Script code for all strings (ScriptCode) 

(defconstant $kLabelKCItemAttr :|labl|)         ;  Item label (string) 

(defconstant $kInvisibleKCItemAttr :|invi|)     ;  Invisible (boolean) 

(defconstant $kNegativeKCItemAttr :|nega|)      ;  Negative (boolean) 

(defconstant $kCustomIconKCItemAttr :|cusi|)    ;  Custom icon (boolean) 

(defconstant $kAccountKCItemAttr :|acct|)       ;  User account (string) 
;  Unique Generic password attributes 

(defconstant $kServiceKCItemAttr :|svce|)       ;  Service (string) 

(defconstant $kGenericKCItemAttr :|gena|)       ;  User-defined attribute (untyped bytes) 
;  Unique Internet password attributes 

(defconstant $kSecurityDomainKCItemAttr :|sdmn|);  Security domain (string) 

(defconstant $kServerKCItemAttr :|srvr|)        ;  Server's domain name or IP address (string) 

(defconstant $kAuthTypeKCItemAttr :|atyp|)      ;  Authentication Type (KCAuthType) 

(defconstant $kPortKCItemAttr :|port|)          ;  Port (UInt16) 

(defconstant $kPathKCItemAttr :|path|)          ;  Path (string) 
;  Unique Appleshare password attributes 

(defconstant $kVolumeKCItemAttr :|vlme|)        ;  Volume (string) 

(defconstant $kAddressKCItemAttr :|addr|)       ;  Server address (IP or domain name) or zone name (string) 

(defconstant $kSignatureKCItemAttr :|ssig|)     ;  Server signature block (AFPServerSignature) 
;  Unique AppleShare and Internet attributes 

(defconstant $kProtocolKCItemAttr :|ptcl|)      ;  Protocol (KCProtocolType) 
;  Certificate attributes 

(defconstant $kSubjectKCItemAttr :|subj|)       ;  Subject distinguished name (DER-encoded data) 

(defconstant $kCommonNameKCItemAttr :|cn  |)    ;  Common Name (UTF8-encoded string) 

(defconstant $kIssuerKCItemAttr :|issu|)        ;  Issuer distinguished name (DER-encoded data) 

(defconstant $kSerialNumberKCItemAttr :|snbr|)  ;  Certificate serial number (DER-encoded data) 

(defconstant $kEMailKCItemAttr :|mail|)         ;  E-mail address (ASCII-encoded string) 

(defconstant $kPublicKeyHashKCItemAttr :|hpky|) ;  Hash of public key (KCPublicKeyHash), 20 bytes max. 

(defconstant $kIssuerURLKCItemAttr :|iurl|)     ;  URL of the certificate issuer (ASCII-encoded string) 
;  Shared by keys and certificates 

(defconstant $kEncryptKCItemAttr :|encr|)       ;  Encrypt (Boolean) 

(defconstant $kDecryptKCItemAttr :|decr|)       ;  Decrypt (Boolean) 

(defconstant $kSignKCItemAttr :|sign|)          ;  Sign (Boolean) 

(defconstant $kVerifyKCItemAttr :|veri|)        ;  Verify (Boolean) 

(defconstant $kWrapKCItemAttr :|wrap|)          ;  Wrap (Boolean) 

(defconstant $kUnwrapKCItemAttr :|unwr|)        ;  Unwrap (Boolean) 

(defconstant $kStartDateKCItemAttr :|sdat|)     ;  Start Date (UInt32) 

(defconstant $kEndDateKCItemAttr :|edat|)       ;  End Date (UInt32) 


(def-mactype :KCItemAttr (find-mactype ':FourCharCode))

(defconstant $kKCAuthTypeNTLM :|ntlm|)
(defconstant $kKCAuthTypeMSN :|msna|)
(defconstant $kKCAuthTypeDPA :|dpaa|)
(defconstant $kKCAuthTypeRPA :|rpaa|)
(defconstant $kKCAuthTypeHTTPDigest :|httd|)
(defconstant $kKCAuthTypeDefault :|dflt|)

(def-mactype :KCAuthType (find-mactype ':FourCharCode))

(defconstant $kKCProtocolTypeFTP :|ftp |)
(defconstant $kKCProtocolTypeFTPAccount :|ftpa|)
(defconstant $kKCProtocolTypeHTTP :|http|)
(defconstant $kKCProtocolTypeIRC :|irc |)
(defconstant $kKCProtocolTypeNNTP :|nntp|)
(defconstant $kKCProtocolTypePOP3 :|pop3|)
(defconstant $kKCProtocolTypeSMTP :|smtp|)
(defconstant $kKCProtocolTypeSOCKS :|sox |)
(defconstant $kKCProtocolTypeIMAP :|imap|)
(defconstant $kKCProtocolTypeLDAP :|ldap|)
(defconstant $kKCProtocolTypeAppleTalk :|atlk|)
(defconstant $kKCProtocolTypeAFP :|afp |)
(defconstant $kKCProtocolTypeTelnet :|teln|)

(def-mactype :KCProtocolType (find-mactype ':FourCharCode))

(def-mactype :KCCertAddOptions (find-mactype ':UInt32))

(defconstant $kSecOptionReserved #xFF)          ;  First byte reserved for SecOptions flags 

(defconstant $kCertUsageShift 8)                ;  start at bit 8 

(defconstant $kCertUsageSigningAdd #x100)
(defconstant $kCertUsageSigningAskAndAdd #x200)
(defconstant $kCertUsageVerifyAdd #x400)
(defconstant $kCertUsageVerifyAskAndAdd #x800)
(defconstant $kCertUsageEncryptAdd #x1000)
(defconstant $kCertUsageEncryptAskAndAdd #x2000)
(defconstant $kCertUsageDecryptAdd #x4000)
(defconstant $kCertUsageDecryptAskAndAdd #x8000)
(defconstant $kCertUsageKeyExchAdd #x10000)
(defconstant $kCertUsageKeyExchAskAndAdd #x20000)
(defconstant $kCertUsageRootAdd #x40000)
(defconstant $kCertUsageRootAskAndAdd #x80000)
(defconstant $kCertUsageSSLAdd #x100000)
(defconstant $kCertUsageSSLAskAndAdd #x200000)
(defconstant $kCertUsageAllAdd #x7FFFFF00)

(def-mactype :KCVerifyStopOn (find-mactype ':UInt16))

(defconstant $kPolicyKCStopOn 0)
(defconstant $kNoneKCStopOn 1)
(defconstant $kFirstPassKCStopOn 2)
(defconstant $kFirstFailKCStopOn 3)

(def-mactype :KCCertSearchOptions (find-mactype ':UInt32))

(defconstant $kCertSearchShift 0)               ;  start at bit 0 

(defconstant $kCertSearchSigningIgnored 0)
(defconstant $kCertSearchSigningAllowed 1)
(defconstant $kCertSearchSigningDisallowed 2)
(defconstant $kCertSearchSigningMask 3)
(defconstant $kCertSearchVerifyIgnored 0)
(defconstant $kCertSearchVerifyAllowed 4)
(defconstant $kCertSearchVerifyDisallowed 8)
(defconstant $kCertSearchVerifyMask 12)
(defconstant $kCertSearchEncryptIgnored 0)
(defconstant $kCertSearchEncryptAllowed 16)
(defconstant $kCertSearchEncryptDisallowed 32)
(defconstant $kCertSearchEncryptMask 48)
(defconstant $kCertSearchDecryptIgnored 0)
(defconstant $kCertSearchDecryptAllowed 64)
(defconstant $kCertSearchDecryptDisallowed #x80)
(defconstant $kCertSearchDecryptMask #xC0)
(defconstant $kCertSearchWrapIgnored 0)
(defconstant $kCertSearchWrapAllowed #x100)
(defconstant $kCertSearchWrapDisallowed #x200)
(defconstant $kCertSearchWrapMask #x300)
(defconstant $kCertSearchUnwrapIgnored 0)
(defconstant $kCertSearchUnwrapAllowed #x400)
(defconstant $kCertSearchUnwrapDisallowed #x800)
(defconstant $kCertSearchUnwrapMask #xC00)
(defconstant $kCertSearchPrivKeyRequired #x1000)
(defconstant $kCertSearchAny 0)
;  Other constants 

(defconstant $kAnyPort 0)

(defconstant $kAnyProtocol 0)
(defconstant $kAnyAuthType 0)
;  Opening and getting information about the Keychain Manager 
; 
;  *  KCGetKeychainManagerVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCGetKeychainManagerVersion" 
   ((returnVers (:pointer :UInt32))
   )
   :OSStatus
() )

; #if TARGET_RT_MAC_CFM
; #ifdef __cplusplus
#| #|
    inline pascal Boolean KeychainManagerAvailable() { return ((KCGetKeychainManagerVersion != (void*)kUnresolvedCFragSymbolAddress) && (KCGetKeychainManagerVersion(nil) != cfragNoSymbolErr)); }
|#
 |#

; #else
; #define KeychainManagerAvailable()  ((KCGetKeychainManagerVersion != (void*)kUnresolvedCFragSymbolAddress) && (KCGetKeychainManagerVersion(nil) != cfragNoSymbolErr))

; #endif

#| 
; #elif TARGET_RT_MAC_MACHO
;  Keychain is always available on OS X 
; #ifdef __cplusplus
#|
    inline pascal Boolean KeychainManagerAvailable() { return true; }
|#

; #else
; #define KeychainManagerAvailable()  (true)

; #endif

 |#

; #endif  /*  */

;  Managing the Human Interface 
; 
;  *  KCSetInteractionAllowed()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_KCSetInteractionAllowed" 
   ((state :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCIsInteractionAllowed()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_KCIsInteractionAllowed" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  Creating references to keychains 
; 
;  *  KCMakeKCRefFromFSSpec()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_KCMakeKCRefFromFSSpec" 
   ((keychainFSSpec (:pointer :FSSpec))
    (keychain (:pointer :KCREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCMakeKCRefFromAlias()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_KCMakeKCRefFromAlias" 
   ((keychainAlias (:Handle :AliasRecord))
    (keychain (:pointer :KCREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCMakeAliasFromKCRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_KCMakeAliasFromKCRef" 
   ((keychain (:pointer :OpaqueSecKeychainRef))
    (keychainAlias (:pointer :ALIASHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCReleaseKeychain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_KCReleaseKeychain" 
   ((keychain (:pointer :KCREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Specifying the default keychain 
; 
;  *  KCGetDefaultKeychain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_KCGetDefaultKeychain" 
   ((keychain (:pointer :KCREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCSetDefaultKeychain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_KCSetDefaultKeychain" 
   ((keychain (:pointer :OpaqueSecKeychainRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Getting information about a keychain 
; 
;  *  KCGetStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCGetStatus" 
   ((keychain (:pointer :OpaqueSecKeychainRef)) ;  can be NULL 
    (keychainStatus (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCGetKeychain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCGetKeychain" 
   ((item (:pointer :OpaqueSecKeychainItemRef))
    (keychain (:pointer :KCREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCGetKeychainName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_KCGetKeychainName" 
   ((keychain (:pointer :OpaqueSecKeychainRef))
    (keychainName (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Enumerating available keychains 
; 
;  *  KCCountKeychains()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCCountKeychains" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt16
() )
; 
;  *  KCGetIndKeychain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCGetIndKeychain" 
   ((index :UInt16)
    (keychain (:pointer :KCREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )

(def-mactype :KCCallbackProcPtr (find-mactype ':pointer)); (KCEvent keychainEvent , KCCallbackInfo * info , void * userContext)

(def-mactype :KCCallbackUPP (find-mactype '(:pointer :OpaqueKCCallbackProcPtr)))
; 
;  *  NewKCCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewKCCallbackUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueKCCallbackProcPtr)
() )
; 
;  *  DisposeKCCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeKCCallbackUPP" 
   ((userUPP (:pointer :OpaqueKCCallbackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeKCCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeKCCallbackUPP" 
   ((keychainEvent :UInt16)
    (info (:pointer :KCCallbackInfo))
    (userContext :pointer)
    (userUPP (:pointer :OpaqueKCCallbackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  High-level interface for retrieving passwords 
; 
;  *  KCFindAppleSharePassword()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCFindAppleSharePassword" 
   ((serverSignature (:pointer :AFPSERVERSIGNATURE));  can be NULL 
    (serverAddress (:pointer :UInt8))           ;  can be NULL 
    (serverName (:pointer :UInt8))              ;  can be NULL 
    (volumeName (:pointer :UInt8))              ;  can be NULL 
    (accountName (:pointer :UInt8))             ;  can be NULL 
    (maxLength :UInt32)
    (passwordData :pointer)
    (actualLength (:pointer :UInt32))
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCFindInternetPassword()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCFindInternetPassword" 
   ((serverName (:pointer :UInt8))              ;  can be NULL 
    (securityDomain (:pointer :UInt8))          ;  can be NULL 
    (accountName (:pointer :UInt8))             ;  can be NULL 
    (port :UInt16)
    (protocol :OSType)
    (authType :OSType)
    (maxLength :UInt32)
    (passwordData :pointer)
    (actualLength (:pointer :UInt32))
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCFindInternetPasswordWithPath()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_KCFindInternetPasswordWithPath" 
   ((serverName (:pointer :UInt8))              ;  can be NULL 
    (securityDomain (:pointer :UInt8))          ;  can be NULL 
    (accountName (:pointer :UInt8))             ;  can be NULL 
    (path (:pointer :UInt8))                    ;  can be NULL 
    (port :UInt16)
    (protocol :OSType)
    (authType :OSType)
    (maxLength :UInt32)
    (passwordData :pointer)
    (actualLength (:pointer :UInt32))
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCFindGenericPassword()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCFindGenericPassword" 
   ((serviceName (:pointer :UInt8))             ;  can be NULL 
    (accountName (:pointer :UInt8))             ;  can be NULL 
    (maxLength :UInt32)
    (passwordData :pointer)
    (actualLength (:pointer :UInt32))
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Keychain Manager callbacks 
; 
;  *  KCAddCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCAddCallback" 
   ((callbackProc (:pointer :OpaqueKCCallbackProcPtr))
    (eventMask :UInt16)
    (userContext :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCRemoveCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCRemoveCallback" 
   ((callbackProc (:pointer :OpaqueKCCallbackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Creating and editing a keychain item 
; 
;  *  KCNewItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCNewItem" 
   ((itemClass :FourCharCode)
    (itemCreator :OSType)
    (length :UInt32)
    (data :pointer)
    (item (:pointer :KCITEMREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCSetAttribute()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCSetAttribute" 
   ((item (:pointer :OpaqueSecKeychainItemRef))
    (attr (:pointer :KCATTRIBUTE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCGetAttribute()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCGetAttribute" 
   ((item (:pointer :OpaqueSecKeychainItemRef))
    (attr (:pointer :KCATTRIBUTE))
    (actualLength (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCSetData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCSetData" 
   ((item (:pointer :OpaqueSecKeychainItemRef))
    (length :UInt32)
    (data :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Managing keychain items 
; 
;  *  KCUpdateItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCUpdateItem" 
   ((item (:pointer :OpaqueSecKeychainItemRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCReleaseItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCReleaseItem" 
   ((item (:pointer :KCITEMREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCCopyItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_KCCopyItem" 
   ((item (:pointer :OpaqueSecKeychainItemRef))
    (destKeychain (:pointer :OpaqueSecKeychainRef))
    (copy (:pointer :KCITEMREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Searching and enumerating keychain items 
; 
;  *  KCFindFirstItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCFindFirstItem" 
   ((keychain (:pointer :OpaqueSecKeychainRef)) ;  can be NULL 
    (attrList (:pointer :KCATTRIBUTELIST))      ;  can be NULL 
    (search (:pointer :KCSEARCHREF))
    (item (:pointer :KCITEMREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCFindNextItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCFindNextItem" 
   ((search (:pointer :OpaqueSecKeychainSearchRef))
    (item (:pointer :KCITEMREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCReleaseSearch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCReleaseSearch" 
   ((search (:pointer :KCSEARCHREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Managing keychain items 
; 
;  *  KCDeleteItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCDeleteItem" 
   ((item (:pointer :OpaqueSecKeychainItemRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCGetData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCGetData" 
   ((item (:pointer :OpaqueSecKeychainItemRef))
    (maxLength :UInt32)
    (data :pointer)
    (actualLength (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Locking a keychain 
; 
;  *  KCLock()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCLock" 
   ((keychain (:pointer :OpaqueSecKeychainRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Routines that use "C" strings 
; 
;  *  kcgetkeychainname()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_kcgetkeychainname" 
   ((keychain (:pointer :OpaqueSecKeychainRef))
    (keychainName (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  kcfindapplesharepassword()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_kcfindapplesharepassword" 
   ((serverSignature (:pointer :AFPSERVERSIGNATURE));  can be NULL 
    (serverAddress (:pointer :char))            ;  can be NULL 
    (serverName (:pointer :char))               ;  can be NULL 
    (volumeName (:pointer :char))               ;  can be NULL 
    (accountName (:pointer :char))              ;  can be NULL 
    (maxLength :UInt32)
    (passwordData :pointer)
    (actualLength (:pointer :UInt32))
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  kcfindinternetpassword()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_kcfindinternetpassword" 
   ((serverName (:pointer :char))               ;  can be NULL 
    (securityDomain (:pointer :char))           ;  can be NULL 
    (accountName (:pointer :char))              ;  can be NULL 
    (port :UInt16)
    (protocol :OSType)
    (authType :OSType)
    (maxLength :UInt32)
    (passwordData :pointer)
    (actualLength (:pointer :UInt32))
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  kcfindinternetpasswordwithpath()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_kcfindinternetpasswordwithpath" 
   ((serverName (:pointer :char))               ;  can be NULL 
    (securityDomain (:pointer :char))           ;  can be NULL 
    (accountName (:pointer :char))              ;  can be NULL 
    (path (:pointer :char))                     ;  can be NULL 
    (port :UInt16)
    (protocol :OSType)
    (authType :OSType)
    (maxLength :UInt32)
    (passwordData :pointer)
    (actualLength (:pointer :UInt32))
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  kcfindgenericpassword()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_kcfindgenericpassword" 
   ((serviceName (:pointer :char))              ;  can be NULL 
    (accountName (:pointer :char))              ;  can be NULL 
    (maxLength :UInt32)
    (passwordData :pointer)
    (actualLength (:pointer :UInt32))
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __KEYCHAINCORE__ */


(provide-interface "KeychainCore")