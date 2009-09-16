(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:KeychainHI.h"
; at Sunday July 2,2006 7:25:16 pm.
; 
;      File:       SecurityHI/KeychainHI.h
;  
;      Contains:   Keychain API's with Human Interfaces
;  
;      Version:    SecurityHI-90~157
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __KEYCHAINHI__
; #define __KEYCHAINHI__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
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
;  High-level interface for storing passwords 
; 
;  *  KCAddAppleSharePassword()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCAddAppleSharePassword" 
   ((serverSignature (:pointer :AFPSERVERSIGNATURE))
    (serverAddress (:pointer :UInt8))
    (serverName (:pointer :UInt8))
    (volumeName (:pointer :UInt8))
    (accountName (:pointer :UInt8))
    (passwordLength :UInt32)
    (passwordData :pointer)
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCAddInternetPassword()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCAddInternetPassword" 
   ((serverName (:pointer :UInt8))
    (securityDomain (:pointer :UInt8))
    (accountName (:pointer :UInt8))
    (port :UInt16)
    (protocol :OSType)
    (authType :OSType)
    (passwordLength :UInt32)
    (passwordData :pointer)
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCAddInternetPasswordWithPath()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_KCAddInternetPasswordWithPath" 
   ((serverName (:pointer :UInt8))
    (securityDomain (:pointer :UInt8))
    (accountName (:pointer :UInt8))
    (path (:pointer :UInt8))
    (port :UInt16)
    (protocol :OSType)
    (authType :OSType)
    (passwordLength :UInt32)
    (passwordData :pointer)
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCAddGenericPassword()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCAddGenericPassword" 
   ((serviceName (:pointer :UInt8))
    (accountName (:pointer :UInt8))
    (passwordLength :UInt32)
    (passwordData :pointer)
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Low-level interface for storing keychain items 
; 
;  *  KCAddItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCAddItem" 
   ((item (:pointer :OpaqueSecKeychainItemRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Managing keychains 
; 
;  *  KCUnlock()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCUnlock" 
   ((keychain (:pointer :OpaqueSecKeychainRef)) ;  can be NULL 
    (password (:pointer :UInt8))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCCreateKeychain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_KCCreateKeychain" 
   ((password (:pointer :UInt8))                ;  can be NULL 
    (keychain (:pointer :KCREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  KCChangeSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_KCChangeSettings" 
   ((keychain (:pointer :OpaqueSecKeychainRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  kcunlock()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_kcunlock" 
   ((keychain (:pointer :OpaqueSecKeychainRef)) ;  can be NULL 
    (password (:pointer :char))                 ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  kccreatekeychain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_kccreatekeychain" 
   ((password (:pointer :char))                 ;  can be NULL 
    (keychain (:pointer :KCREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  kcaddapplesharepassword()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_kcaddapplesharepassword" 
   ((serverSignature (:pointer :AFPSERVERSIGNATURE))
    (serverAddress (:pointer :char))
    (serverName (:pointer :char))
    (volumeName (:pointer :char))
    (accountName (:pointer :char))
    (passwordLength :UInt32)
    (passwordData :pointer)
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  kcaddinternetpassword()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_kcaddinternetpassword" 
   ((serverName (:pointer :char))
    (securityDomain (:pointer :char))
    (accountName (:pointer :char))
    (port :UInt16)
    (protocol :OSType)
    (authType :OSType)
    (passwordLength :UInt32)
    (passwordData :pointer)
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  kcaddinternetpasswordwithpath()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  

(deftrap-inline "_kcaddinternetpasswordwithpath" 
   ((serverName (:pointer :char))
    (securityDomain (:pointer :char))
    (accountName (:pointer :char))
    (path (:pointer :char))
    (port :UInt16)
    (protocol :OSType)
    (authType :OSType)
    (passwordLength :UInt32)
    (passwordData :pointer)
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  kcaddgenericpassword()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in KeychainLib 1.0 and later
;  

(deftrap-inline "_kcaddgenericpassword" 
   ((serviceName (:pointer :char))
    (accountName (:pointer :char))
    (passwordLength :UInt32)
    (passwordData :pointer)
    (item (:pointer :KCITEMREF))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Working with certificates 
; 
;  *  KCFindX509Certificates()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  
; 
;  *  KCChooseCertificate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in KeychainLib 2.0 and later
;  
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __KEYCHAINHI__ */


(provide-interface "KeychainHI")