(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:InternetConfig.h"
; at Sunday July 2,2006 7:24:38 pm.
; 
;      File:       HIServices/InternetConfig.h
;  
;      Contains:   Internet Config interfaces
;  
;      Version:    HIServices-125.6~1
;  
;      Copyright:  � 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; 
;     IMPORTANT NOTES ABOUT THE C HEADERS
;     -----------------------------------
; 
;     o   When you see the parameter 'y *x', you should be aware that
;         you *cannot pass in nil*.  In future this restriction may be eased,
;         especially for the attr parameter to ICGetPref.  Parameters where nil
;         is legal are declared using the explicit pointer type, ie 'yPtr x'.
; 
;     o   Strings are *Pascal* strings.  This means that they must be word aligned.
;         MPW and Think C do this automatically.  The last time I checked, Metrowerks
;         C does not.  If it still doesn't, then IMHO it's a bug in their compiler
;         and you should report it to them.  [IC 1.4 and later no longer require
;         word aligned strings.  You can ignore this warning if you require IC 1.4
;         or greater.]
; 
; *********************************************************************************************
; #ifndef __INTERNETCONFIG__
; #define __INTERNETCONFIG__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __AE__
#| #|
#include <AEAE.h>
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
; ***********************************************************************************************
;   IC error codes
;  ***********************************************************************************************

(defconstant $icPrefNotFoundErr -666)           ;  preference not found (duh!)  

(defconstant $icPermErr -667)                   ;  cannot set preference  

(defconstant $icPrefDataErr -668)               ;  problem with preference data  

(defconstant $icInternalErr -669)               ;  hmm, this is not good  

(defconstant $icTruncatedErr -670)              ;  more data was present than was returned  

(defconstant $icNoMoreWritersErr -671)          ;  you cannot begin a write session because someone else is already doing it  

(defconstant $icNothingToOverrideErr -672)      ;  no component for the override component to capture  

(defconstant $icNoURLErr -673)                  ;  no URL found  

(defconstant $icConfigNotFoundErr -674)         ;  no configuration was found  

(defconstant $icConfigInappropriateErr -675)    ;  incorrect manufacturer code  

(defconstant $icProfileNotFoundErr -676)        ;  profile not found  
;  too many profiles in database  

(defconstant $icTooManyProfilesErr -677)
; ***********************************************************************************************
;   IC versions (not necessarily, but historically, from a component)
;  ***********************************************************************************************

(defconstant $kICComponentInterfaceVersion0 0)  ;  IC >= 1.0  

(defconstant $kICComponentInterfaceVersion1 #x10000);  IC >= 1.1  

(defconstant $kICComponentInterfaceVersion2 #x20000);  IC >= 1.2  

(defconstant $kICComponentInterfaceVersion3 #x30000);  IC >= 2.0  

(defconstant $kICComponentInterfaceVersion4 #x40000);  IC >= 2.5  

(defconstant $kICComponentInterfaceVersion #x40000);  current version number is 4  

; ***********************************************************************************************
;   opaque type for preference reference
;  ***********************************************************************************************

(def-mactype :ICInstance (find-mactype '(:pointer :OpaqueICInstance)))
; ***********************************************************************************************
;   a record that specifies a folder, an array of such records, and a pointer to such an array
;  ***********************************************************************************************
(defrecord ICDirSpec
   (vRefNum :SInt16)
   (dirID :signed-long)
)

;type name? (%define-record :ICDirSpec (find-record-descriptor ':ICDirSpec))
(defrecord ICDirSpecArray
   (contents (:array :ICDirSpec 4))
)
(def-mactype :ICDirSpecArrayPtr (find-mactype '(:pointer :ICDirSpecArray)))
; ***********************************************************************************************
;   preference attributes type, bit number constants, and mask constants
;  ***********************************************************************************************

(def-mactype :ICAttr (find-mactype ':UInt32))

(defconstant $kICAttrLockedBit 0)
(defconstant $kICAttrVolatileBit 1)

(defconstant $kICAttrNoChange #xFFFFFFFF)       ;  pass this to ICSetPref to tell it not to change the attributes  

(defconstant $kICAttrLockedMask 1)
(defconstant $kICAttrVolatileMask 2)
; ***********************************************************************************************
;   permissions for use with ICBegin
;  ***********************************************************************************************

(def-mactype :ICPerm (find-mactype ':UInt8))

(defconstant $icNoPerm 0)
(defconstant $icReadOnlyPerm 1)
(defconstant $icReadWritePerm 2)
; ***********************************************************************************************
;   a reference to an instance's current configuration
;  ***********************************************************************************************

; #if CALL_NOT_IN_CARBON
#| 
(defrecord ICConfigRef
   (manufacturer :OSType)
                                                ;  other private data follows  
)

;type name? (def-mactype :ICConfigRef (find-mactype ':ICConfigRef))

(def-mactype :ICConfigRefPtr (find-mactype '(:pointer :ICConfigRef)))

(def-mactype :ICConfigRefHandle (find-mactype '(:pointer :ICConfigRefPtr)))
 |#

; #endif  /* CALL_NOT_IN_CARBON */

; ***********************************************************************************************
;   profile IDs
;  ***********************************************************************************************

(def-mactype :ICProfileID (find-mactype ':signed-long))

(def-mactype :ICProfileIDPtr (find-mactype '(:pointer :signed-long)))

(defconstant $kICNilProfileID 0)
; ***********************************************************************************************
;   other constants
;  ***********************************************************************************************

(defconstant $kICNoUserInteractionBit 0)

(defconstant $kICNoUserInteractionMask 1)

(defconstant $kICFileType :|ICAp|)
(defconstant $kICCreator :|ICAp|)
; ***********************************************************************************************
;   Apple event constants
;  ***********************************************************************************************

(defconstant $kInternetEventClass :|GURL|)
(defconstant $kAEGetURL :|GURL|)
(defconstant $kAEFetchURL :|FURL|)
(defconstant $keyAEAttaching :|Atch|)
;  AERegistry.i defines a compatible keyAEDestination 

(defconstant $kICEditPreferenceEventClass :|ICAp|)
(defconstant $kICEditPreferenceEvent :|ICAp|)
(defconstant $keyICEditPreferenceDestination :|dest|)
; ***********************************************************************************************
;   constants for use with ICGetVersion
;  ***********************************************************************************************

(defconstant $kICComponentVersion 0)            ;  Return a component version, comparable to kICComponentInterfaceVersion  

(defconstant $kICNumVersion 1)                  ;  Return a NumVersion structure  

; ***********************************************************************************************
;   types and constants for use with kICDocumentFont, et. al.
;  ***********************************************************************************************
(defrecord ICFontRecord
   (size :SInt16)
   (face :UInt8)
   (pad :character)
   (font (:string 255))
)

;type name? (%define-record :ICFontRecord (find-record-descriptor ':ICFontRecord))

(def-mactype :ICFontRecordPtr (find-mactype '(:pointer :ICFontRecord)))

(def-mactype :ICFontRecordHandle (find-mactype '(:handle :ICFontRecord)))
; ***********************************************************************************************
;   types and constants for use with kICCharacterSet, et. al.
;  ***********************************************************************************************
(defrecord ICCharTable
   (netToMac (:array :UInt8 256))
   (macToNet (:array :UInt8 256))
)

;type name? (%define-record :ICCharTable (find-record-descriptor ':ICCharTable))

(def-mactype :ICCharTablePtr (find-mactype '(:pointer :ICCharTable)))

(def-mactype :ICCharTableHandle (find-mactype '(:handle :ICCharTable)))
; ***********************************************************************************************
;   types and constants for use with kICHelper, et. al.
;  ***********************************************************************************************
(defrecord ICAppSpec
   (fCreator :OSType)
   (name (:string 63))
)

;type name? (%define-record :ICAppSpec (find-record-descriptor ':ICAppSpec))

(def-mactype :ICAppSpecPtr (find-mactype '(:pointer :ICAppSpec)))

(def-mactype :ICAppSpecHandle (find-mactype '(:handle :ICAppSpec)))
(defrecord ICAppSpecList
   (numberOfItems :SInt16)
   (appSpecs (:array :ICAppSpec 1))
)

;type name? (%define-record :ICAppSpecList (find-record-descriptor ':ICAppSpecList))

(def-mactype :ICAppSpecListPtr (find-mactype '(:pointer :ICAppSpecList)))

(def-mactype :ICAppSpecListHandle (find-mactype '(:handle :ICAppSpecList)))
; ***********************************************************************************************
;   types and constants for use with kICDownloadFolder, et. al.
;  ***********************************************************************************************

; #if !OLDROUTINENAMES
(defrecord ICFileSpec
   (volName (:string 31))
   (volCreationDate :signed-long)
   (fss :FSSpec)
   (alias :AliasRecord)
                                                ;  plus extra data, aliasSize 0 means no alias manager present when
                                                ;  ICFileSpecification was created
)

;type name? (%define-record :ICFileSpec (find-record-descriptor ':ICFileSpec))

(def-mactype :ICFileSpecPtr (find-mactype '(:pointer :ICFileSpec)))

(def-mactype :ICFileSpecHandle (find-mactype '(:handle :ICFileSpec)))
#| 
; #else
(defrecord ICFileSpec
   (vol_name (:string 31))
   (vol_creation_date :signed-long)
   (fss :FSSpec)
   (alias :AliasRecord)
)

;type name? (%define-record :ICFileSpec (find-record-descriptor ':ICFileSpec))

(def-mactype :ICFileSpecPtr (find-mactype '(:pointer :ICFileSpec)))

(def-mactype :ICFileSpecHandle (find-mactype '(:handle :ICFileSpec)))
 |#

; #endif  /* !OLDROUTINENAMES */


(defconstant $kICFileSpecHeaderSize 18)
; ***********************************************************************************************
;   types and constants for use with ICMapFilename, et. al.
;  ***********************************************************************************************

(def-mactype :ICMapEntryFlags (find-mactype ':signed-long))

(def-mactype :ICFixedLength (find-mactype ':SInt16))

; #if !OLDROUTINENAMES
(defrecord ICMapEntry
   (totalLength :SInt16)
   (fixedLength :SInt16)
   (version :SInt16)
   (fileType :OSType)
   (fileCreator :OSType)
   (postCreator :OSType)
   (flags :signed-long)
                                                ;  variable part starts here
   (extension (:string 255))
   (creatorAppName (:string 255))
   (postAppName (:string 255))
   (MIMEType (:string 255))
   (entryName (:string 255))
)

;type name? (%define-record :ICMapEntry (find-record-descriptor ':ICMapEntry))

(def-mactype :ICMapEntryPtr (find-mactype '(:pointer :ICMapEntry)))

(def-mactype :ICMapEntryHandle (find-mactype '(:handle :ICMapEntry)))
#| 
; #else
(defrecord ICMapEntry
   (total_length :SInt16)
   (fixed_length :SInt16)
   (version :SInt16)
   (file_type :OSType)
   (file_creator :OSType)
   (post_creator :OSType)
   (flags :signed-long)
   (extension (:string 255))
   (creator_app_name (:string 255))
   (post_app_name (:string 255))
   (MIME_type (:string 255))
   (entry_name (:string 255))
)

;type name? (%define-record :ICMapEntry (find-record-descriptor ':ICMapEntry))

(def-mactype :ICMapEntryPtr (find-mactype '(:pointer :ICMapEntry)))

(def-mactype :ICMapEntryHandle (find-mactype '(:handle :ICMapEntry)))
 |#

; #endif  /* !OLDROUTINENAMES */


(defconstant $kICMapFixedLength 22)             ;  number in fixedLength field


(defconstant $kICMapBinaryBit 0)                ;  file should be transfered in binary as opposed to text mode

(defconstant $kICMapResourceForkBit 1)          ;  the resource fork of the file is significant

(defconstant $kICMapDataForkBit 2)              ;  the data fork of the file is significant

(defconstant $kICMapPostBit 3)                  ;  post process using post fields

(defconstant $kICMapNotIncomingBit 4)           ;  ignore this mapping for incoming files

(defconstant $kICMapNotOutgoingBit 5)           ;  ignore this mapping for outgoing files


(defconstant $kICMapBinaryMask 1)               ;  file should be transfered in binary as opposed to text mode

(defconstant $kICMapResourceForkMask 2)         ;  the resource fork of the file is significant

(defconstant $kICMapDataForkMask 4)             ;  the data fork of the file is significant

(defconstant $kICMapPostMask 8)                 ;  post process using post fields

(defconstant $kICMapNotIncomingMask 16)         ;  ignore this mapping for incoming files

(defconstant $kICMapNotOutgoingMask 32)         ;  ignore this mapping for outgoing files

; ***********************************************************************************************
;   types and constants for use with kICServices, et. al.
;  ***********************************************************************************************

(def-mactype :ICServiceEntryFlags (find-mactype ':SInt16))
(defrecord ICServiceEntry
   (name (:string 255))
   (port :SInt16)
   (flags :SInt16)
)

;type name? (%define-record :ICServiceEntry (find-record-descriptor ':ICServiceEntry))

(def-mactype :ICServiceEntryPtr (find-mactype '(:pointer :ICServiceEntry)))

(def-mactype :ICServiceEntryHandle (find-mactype '(:handle :ICServiceEntry)))

(defconstant $kICServicesTCPBit 0)
(defconstant $kICServicesUDPBit 1)              ;  both bits can be set, which means the service is both TCP and UDP, eg daytime


(defconstant $kICServicesTCPMask 1)
(defconstant $kICServicesUDPMask 2)             ;  both bits can be set, which means the service is both TCP and UDP, eg daytime

(defrecord ICServices
   (count :SInt16)
   (services (:array :ICServiceEntry 1))
)

;type name? (%define-record :ICServices (find-record-descriptor ':ICServices))

(def-mactype :ICServicesPtr (find-mactype '(:pointer :ICServices)))

(def-mactype :ICServicesHandle (find-mactype '(:handle :ICServices)))
; ***********************************************************************************************
;   default file name, for internal use, overridden by a component resource
;  ***********************************************************************************************

; #if CALL_NOT_IN_CARBON
#| 
; #define kICDefaultFileName              "\pInternet Preferences"
 |#

; #endif  /* CALL_NOT_IN_CARBON */

; ***********************************************************************************************
;   keys
;  ***********************************************************************************************
;  
;     key reserved for use by Internet Config 
; 
(defconstant $kICReservedKey "\\pkICReservedKey")
; #define kICReservedKey                  "\pkICReservedKey"
; 
;     STR# -- formatted, list of Archie servers  
; 
(defconstant $kICArchieAll "\\pArchieAll")
; #define kICArchieAll                    "\pArchieAll"
; 
;     PString -- formatted, preferred Archie server   
; 
(defconstant $kICArchiePreferred "\\pArchiePreferred")
; #define kICArchiePreferred              "\pArchiePreferred"
; 
;     ICCharTable -- Mac-to-Net and Net-to-Mac character translation   
; 
(defconstant $kICCharacterSet "\\pCharacterSet")
; #define kICCharacterSet                 "\pCharacterSet"
; 
;     ICFontRecord -- font used for proportional text   
; 
(defconstant $kICDocumentFont "\\pDocumentFont")
; #define kICDocumentFont                 "\pDocumentFont"
; 
;     ICFileSpec -- where to put newly downloaded files   
; 
(defconstant $kICDownloadFolder "\\pDownloadFolder")
; #define kICDownloadFolder               "\pDownloadFolder"
; 
;     PString -- user@host.domain, email address of user, ie return address   
; 
(defconstant $kICEmail "\\pEmail")
; #define kICEmail                        "\pEmail"
; 
;     PString -- host.domain, default FTP server   
; 
(defconstant $kICFTPHost "\\pFTPHost")
; #define kICFTPHost                      "\pFTPHost"
; 
;     PString -- second level FTP proxy authorisation   
; 
(defconstant $kICFTPProxyAccount "\\pFTPProxyAccount")
; #define kICFTPProxyAccount              "\pFTPProxyAccount"
; 
;     PString -- host.domain   
; 
(defconstant $kICFTPProxyHost "\\pFTPProxyHost")
; #define kICFTPProxyHost                 "\pFTPProxyHost"
; 
;     PString -- scrambled, password for FTPProxyUser   
; 
(defconstant $kICFTPProxyPassword "\\pFTPProxyPassword")
; #define kICFTPProxyPassword             "\pFTPProxyPassword"
; 
;     PString -- first level FTP proxy authorisation   
; 
(defconstant $kICFTPProxyUser "\\pFTPProxyUser")
; #define kICFTPProxyUser                 "\pFTPProxyUser"
; 
;     PString -- host.domain, default finger server   
; 
(defconstant $kICFingerHost "\\pFingerHost")
; #define kICFingerHost                   "\pFingerHost"
; 
;     PString -- host.domain, default Gopher server   
; 
(defconstant $kICGopherHost "\\pGopherHost")
; #define kICGopherHost                   "\pGopherHost"
; 
;     PString -- host.domain, see note in Prog Docs   
; 
(defconstant $kICGopherProxy "\\pGopherProxy")
; #define kICGopherProxy                  "\pGopherProxy"
; 
;     PString -- host.domain   
; 
(defconstant $kICHTTPProxyHost "\\pHTTPProxyHost")
; #define kICHTTPProxyHost                "\pHTTPProxyHost"
; 
;     ICAppSpec -- helpers for URL schemes   
; 
(defconstant $kICHelper "\\pHelper�")
; #define kICHelper                       "\pHelper""
; 
;     PString -- description for URL scheme   
; 
(defconstant $kICHelperDesc "\\pHelperDesc�")
; #define kICHelperDesc                   "\pHelperDesc""
; 
;     ICAppSpecList -- list of common helpers for URL schemes   
; 
(defconstant $kICHelperList "\\pHelperList�")
; #define kICHelperList                   "\pHelperList""
; 
;     PString -- host.domain, Internet Relay Chat server   
; 
(defconstant $kICIRCHost "\\pIRCHost")
; #define kICIRCHost                      "\pIRCHost"
; 
;     STR# -- formatted, list of Info-Mac servers   
; 
(defconstant $kICInfoMacAll "\\pInfoMacAll")
; #define kICInfoMacAll                   "\pInfoMacAll"
; 
;     PString -- formatted, preferred Info-Mac server   
; 
(defconstant $kICInfoMacPreferred "\\pInfoMacPreferred")
; #define kICInfoMacPreferred             "\pInfoMacPreferred"
; 
;     PString -- string LDAP thing   
; 
(defconstant $kICLDAPSearchbase "\\pLDAPSearchbase")
; #define kICLDAPSearchbase               "\pLDAPSearchbase"
; 
;     PString -- host.domain   
; 
(defconstant $kICLDAPServer "\\pLDAPServer")
; #define kICLDAPServer                   "\pLDAPServer"
; 
;     ICFontRecord -- font used for lists of items (eg news article lists)   
; 
(defconstant $kICListFont "\\pListFont")
; #define kICListFont                     "\pListFont"
; 
;     PString -- host for MacSearch queries   
; 
(defconstant $kICMacSearchHost "\\pMacSearchHost")
; #define kICMacSearchHost                "\pMacSearchHost"
; 
;     PString -- user@host.domain, account from which to fetch mail   
; 
(defconstant $kICMailAccount "\\pMailAccount")
; #define kICMailAccount                  "\pMailAccount"
; 
;     TEXT -- extra headers for mail messages   
; 
(defconstant $kICMailHeaders "\\pMailHeaders")
; #define kICMailHeaders                  "\pMailHeaders"
; 
;     PString -- scrambled, password for MailAccount   
; 
(defconstant $kICMailPassword "\\pMailPassword")
; #define kICMailPassword                 "\pMailPassword"
; 
;     ICMapEntries -- file type mapping, see documentation   
; 
(defconstant $kICMapping "\\pMapping")
; #define kICMapping                      "\pMapping"
; 
;     PString -- host.domain, NNTP server   
; 
(defconstant $kICNNTPHost "\\pNNTPHost")
; #define kICNNTPHost                     "\pNNTPHost"
; 
;     PString -- host.domain, Network Time Protocol (NTP)   
; 
(defconstant $kICNTPHost "\\pNTPHost")
; #define kICNTPHost                      "\pNTPHost"
; 
;     Boolean   
; 
(defconstant $kICNewMailDialog "\\pNewMailDialog")
; #define kICNewMailDialog                "\pNewMailDialog"
; 
;     Boolean -- how to announce new mail   
; 
(defconstant $kICNewMailFlashIcon "\\pNewMailFlashIcon")
; #define kICNewMailFlashIcon             "\pNewMailFlashIcon"
; 
;     Boolean   
; 
(defconstant $kICNewMailPlaySound "\\pNewMailPlaySound")
; #define kICNewMailPlaySound             "\pNewMailPlaySound"
; 
;     PString   
; 
(defconstant $kICNewMailSoundName "\\pNewMailSoundName")
; #define kICNewMailSoundName             "\pNewMailSoundName"
; 
;     PString -- scrambled, password for NewsAuthUsername   
; 
(defconstant $kICNewsAuthPassword "\\pNewsAuthPassword")
; #define kICNewsAuthPassword             "\pNewsAuthPassword"
; 
;     PString -- user name for authorised news servers   
; 
(defconstant $kICNewsAuthUsername "\\pNewsAuthUsername")
; #define kICNewsAuthUsername             "\pNewsAuthUsername"
; 
;     TEXT -- extra headers for news messages   
; 
(defconstant $kICNewsHeaders "\\pNewsHeaders")
; #define kICNewsHeaders                  "\pNewsHeaders"
; 
;     STR# -- list of domains not to be proxied   
; 
(defconstant $kICNoProxyDomains "\\pNoProxyDomains")
; #define kICNoProxyDomains               "\pNoProxyDomains"
; 
;     PString -- for X-Organization string   
; 
(defconstant $kICOrganization "\\pOrganization")
; #define kICOrganization                 "\pOrganization"
; 
;     PString -- host.domain, default Ph server   
; 
(defconstant $kICPhHost "\\pPhHost")
; #define kICPhHost                       "\pPhHost"
; 
;     TEXT -- default response for finger servers   
; 
(defconstant $kICPlan "\\pPlan")
; #define kICPlan                         "\pPlan"
; 
;     ICFontRecord -- font used to print ScreenFont   
; 
(defconstant $kICPrinterFont "\\pPrinterFont")
; #define kICPrinterFont                  "\pPrinterFont"
; 
;     PString -- used to quote responses in news and mail   
; 
(defconstant $kICQuotingString "\\pQuotingString")
; #define kICQuotingString                "\pQuotingString"
; 
;     PString -- real name of user   
; 
(defconstant $kICRealName "\\pRealName")
; #define kICRealName                     "\pRealName"
; 
;     PString -- RTSP Proxy Host
; 
(defconstant $kICRTSPProxyHost "\\pRTSPProxyHost")
; #define kICRTSPProxyHost                "\pRTSPProxyHost"
; 
;     PString -- host.domain, SMTP server   
; 
(defconstant $kICSMTPHost "\\pSMTPHost")
; #define kICSMTPHost                     "\pSMTPHost"
; 
;     ICFontRecord -- font used for monospaced text (eg news articles)   
; 
(defconstant $kICScreenFont "\\pScreenFont")
; #define kICScreenFont                   "\pScreenFont"
; 
;     ICServices -- TCP and IP port-to-name mapping   
; 
(defconstant $kICServices "\\pServices")
; #define kICServices                     "\pServices"
; 
;     TEXT -- append to news and mail messages   
; 
(defconstant $kICSignature "\\pSignature")
; #define kICSignature                    "\pSignature"
; 
;     TEXT -- preferred mailing address   
; 
(defconstant $kICSnailMailAddress "\\pSnailMailAddress")
; #define kICSnailMailAddress             "\pSnailMailAddress"
; 
;     PString -- host.domain, remember that host.domain format allows ":port" and " port"  
; 
(defconstant $kICSocksHost "\\pSocksHost")
; #define kICSocksHost                    "\pSocksHost"
; 
;     PString -- host.domain, default Telnet address   
; 
(defconstant $kICTelnetHost "\\pTelnetHost")
; #define kICTelnetHost                   "\pTelnetHost"
; 
;     STR# -- formatted, list of UMich servers   
; 
(defconstant $kICUMichAll "\\pUMichAll")
; #define kICUMichAll                     "\pUMichAll"
; 
;     PString -- formatted, preferred UMich server   
; 
(defconstant $kICUMichPreferred "\\pUMichPreferred")
; #define kICUMichPreferred               "\pUMichPreferred"
; 
;     Boolean   
; 
(defconstant $kICUseFTPProxy "\\pUseFTPProxy")
; #define kICUseFTPProxy                  "\pUseFTPProxy"
; 
;     Boolean   
; 
(defconstant $kICUseGopherProxy "\\pUseGopherProxy")
; #define kICUseGopherProxy               "\pUseGopherProxy"
; 
;     Boolean   
; 
(defconstant $kICUseHTTPProxy "\\pUseHTTPProxy")
; #define kICUseHTTPProxy                 "\pUseHTTPProxy"
; 
;     Boolean -- use PASV command for FTP transfers   
; 
(defconstant $kICUsePassiveFTP "\\pUsePassiveFTP")
; #define kICUsePassiveFTP                "\pUsePassiveFTP"
; 
;     Boolean
; 
(defconstant $kICUseRTSPProxy "\\pUseRTSPProxy")
; #define kICUseRTSPProxy                 "\pUseRTSPProxy"
; 
;     Boolean   
; 
(defconstant $kICUseSocks "\\pUseSocks")
; #define kICUseSocks                     "\pUseSocks"
; 
;     PString -- no idea   
; 
(defconstant $kICWAISGateway "\\pWAISGateway")
; #define kICWAISGateway                  "\pWAISGateway"
; 
;     PString -- URL, users default WWW page   
; 
(defconstant $kICWWWHomePage "\\pWWWHomePage")
; #define kICWWWHomePage                  "\pWWWHomePage"
; 
;     RGBColor -- background colour for web pages   
; 
(defconstant $kICWebBackgroundColour "\\pWebBackgroundColour")
; #define kICWebBackgroundColour          "\pWebBackgroundColour"
; 
;     RGBColor -- colour for read links   
; 
(defconstant $kICWebReadColor "\\p646F6777쩦ebReadColor")
; #define kICWebReadColor                 "\p646F6777"WebReadColor"
; 
;     PString -- URL, users default search page   
; 
(defconstant $kICWebSearchPagePrefs "\\pWebSearchPagePrefs")
; #define kICWebSearchPagePrefs           "\pWebSearchPagePrefs"
; 
;     RGBColor -- colour for normal text   
; 
(defconstant $kICWebTextColor "\\pWebTextColor")
; #define kICWebTextColor                 "\pWebTextColor"
; 
;     Boolean -- whether to underline links   
; 
(defconstant $kICWebUnderlineLinks "\\p646F6777쩦ebUnderlineLinks")
; #define kICWebUnderlineLinks            "\p646F6777"WebUnderlineLinks"
; 
;     RGBColor -- colour for unread links   
; 
(defconstant $kICWebUnreadColor "\\p646F6777쩦ebUnreadColor")
; #define kICWebUnreadColor               "\p646F6777"WebUnreadColor"
; 
;     PString -- host.domain, default whois server   
; 
(defconstant $kICWhoisHost "\\pWhoisHost")
; #define kICWhoisHost                    "\pWhoisHost"
; ***********************************************************************************************
; 
;       FUNCTIONS
; 
;       What do the annotations after each API mean?
;       --------------------------------------------
; 
;       [r1] Requires IC 1.1 or higher.
;       [r2] Requires IC 1.2 or higher.
;       [r3] Requires IC 2.0 or higher.
;       [r4] Requires IC 2.5 or higher.
;       
;       IMPORTANT:
; 
;       In IC 2.5, instances automatically use the default configuration.
;       You no longer need to configure an instance explicitly, except
;       if your code might run with an older version of IC.  So the following
;       notes only apply to IC 2.0 and earlier.
; 
;       [c1]  You must have specified a configuration before calling this routine.
;       
;       [c2]  You must have specified the default configuration before calling this
;             routine.
;       
;       [c3]  You do not need to specify a configuration before calling this routine.
;       
;       [b1]  You must be inside a Begin/End pair when calling this routine.
;       
;       [b2]  You must be inside a Begin/End read/write pair when calling this routine.
;       
;       [b3]  You do not need to be inside a Begin/End pair when calling this routine.
;       
;       [b4]  If you are getting or setting multiple preferences, you should make this
;             call inside a Begin/End pair. If you do not make this call inside a Begin/End
;             pair, the call will automatically do it for you.
;       
;       [b5]  It is illegal to call this routine inside a Begin/End pair.
; 
;  ***********************************************************************************************
;  ***** Starting Up and Shutting Down *****  
; 
;  *  ICStart()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICStart" 
   ((inst (:pointer :ICINSTANCE))
    (signature :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Call this at application initialisation. Set signature to a value
;    * which has been regsitered with DTS to allow for future expansion
;    * of the IC system. Returns inst as a connection to the IC system.
;    
; 
;  *  ICStop()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICStop" 
   ((inst (:pointer :OpaqueICInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [b5] 
;    * Call this at application initialisation, after which inst
;    * is no longer valid connection to IC.
;    
; 
;  *  ICGetVersion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICGetVersion" 
   ((inst (:pointer :OpaqueICInstance))
    (whichVersion :signed-long)
    (version (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r4] [c3] [b3] 
;    * Returns the version of Internet Config.  Pass kICComponentVersion
;    * to get the version as previously returned by GetComponenVerson.
;    * Pass kICNumVersion to get a NumVersion structure.
;    
;  ***** Specifying a Configuration *****  
; 
;  *  ICFindConfigFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [b5] 
;    * Call to configure this connection to IC.
;    * Set count as the number of valid elements in folders.
;    * Set folders to a pointer to the folders to search.
;    * Setting count to 0 and folders to nil is OK.
;    * Searches the specified folders and then the Preferences folder
;    * in a unspecified manner.
;    
; 
;  *  ICFindUserConfigFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [r1] [b5] 
;    * Similar to ICFindConfigFile except that it only searches the folder
;    * specified in where.  If the input parameters are valid the routine
;    * will always successful configure the instance, creating an
;    * empty configuration if necessary
;    * For use with double-clickable preference files.
;    
; 
;  *  ICGeneralFindConfigFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [r2] [b5] 
;    * Call to configure this connection to IC.
;    * This routine acts as a more general replacement for
;    * ICFindConfigFile and ICFindUserConfigFile.
;    * Set search_prefs to true if you want it to search the preferences folder.
;    * Set can_create to true if you want it to be able to create a new config.
;    * Set count as the number of valid elements in folders.
;    * Set folders to a pointer to the folders to search.
;    * Setting count to 0 and folders to nil is OK.
;    * Searches the specified folders and then optionally the Preferences folder
;    * in a unspecified manner.
;    
; 
;  *  ICChooseConfig()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [r2] [b5] 
;    * Requests the user to choose a configuration, typically using some
;    * sort of modal dialog. If the user cancels the dialog the configuration
;    * state will be unaffected.
;    
; 
;  *  ICChooseNewConfig()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [r2] [b5] 
;    * Requests the user to create a new configuration, typically using some
;    * sort of modal dialog. If the user cancels the dialog the configuration
;    * state will be unaffected.
;    
; 
;  *  ICGetConfigName()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICGetConfigName" 
   ((inst (:pointer :OpaqueICInstance))
    (longname :Boolean)
    (name (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r2] [c1] [b3] 
;    * Returns a string that describes the current configuration at a user
;    * level. Set longname to true if you want a long name, up to 255
;    * characters, or false if you want a short name, typically about 32
;    * characters.
;    * The returned string is for user display only. If you rely on the
;    * exact format of it, you will conflict with any future IC
;    * implementation that doesn't use explicit preference files.
;    
; 
;  *  ICGetConfigReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [r2] [c1] [b3] 
;    * Returns a self-contained reference to the instance's current
;    * configuration.
;    * ref must be a valid non-nil handle and it will be resized to fit the
;    * resulting data.
;    
; 
;  *  ICSetConfigReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [r2] [b5] 
;    * Reconfigures the instance using a configuration reference that was
;    * got using ICGetConfigReference reference. Set the
;    * icNoUserInteraction_bit in flags if you require that this routine
;    * not present a modal dialog. Other flag bits are reserved and should
;    * be set to zero.
;    * ref must not be nil.
;    
;  ***** Private Routines *****
;  * 
;  * If you are calling these routines, you are most probably doing something
;  * wrong.  Please read the documentation for more details.
;   
; 
;  *  ICSpecifyConfigFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [b5] 
;    * For use only by the IC application.
;    * If you call this routine yourself, you will conflict with any
;    * future IC implementation that doesn't use explicit preference files.
;    
; 
;  *  ICRefreshCaches()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [r3] [c1] [b3] 
;    * For use only by the IC application.
;    * If you call this routine yourself, you will conflict with any
;    * future IC implementation that doesn't use explicit preference files.
;    
;  ***** Getting Information *****  
; 
;  *  ICGetSeed()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICGetSeed" 
   ((inst (:pointer :OpaqueICInstance))
    (seed (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [c3] [b3] 
;    * Returns the current seed for the IC prefs database.
;    * This seed changes each time a non-volatile preference is changed.
;    * You can poll this to determine if any cached preferences change.
;    
; 
;  *  ICGetPerm()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICGetPerm" 
   ((inst (:pointer :OpaqueICInstance))
    (perm (:pointer :ICPERM))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [c3] [b3] 
;    * Returns the access permissions currently associated with this instance.
;    * While applications normally know what permissions they have,
;    * this routine is designed for use by override components.
;    
; 
;  *  ICDefaultFileName()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [c3] [b3] 
;    * Returns the default file name for IC preference files.
;    * Applications should never need to call this routine.
;    * If you rely on information returned by this routine yourself,
;    * you may conflict with any future IC implementation that doesn't use
;    * explicit preference files.
;    * The component calls this routine to set up the default IC file name.
;    * This allows this operation to be intercepted by a component that has
;    * captured us. It currently gets it from the component resource file.
;    * The glue version is hardwired to "Internet Preferences".
;    
; 
;  *  ICGetComponentInstance()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [c3] [b3] 
;    * Returns noErr and the connection to the IC component,
;    * if we're using the component.
;    * Returns badComponenInstance and nil if we're operating with glue.
;    
;  ***** Reading and Writing Preferences *****  
; 
;  *  ICBegin()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICBegin" 
   ((inst (:pointer :OpaqueICInstance))
    (perm :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [c1] [b5] 
;    * Starting reading or writing multiple preferences.
;    * A call to this must be balanced by a call to ICEnd.
;    * Do not call WaitNextEvent between these calls.
;    * The perm specifies whether you intend to read or read/write.
;    * Only one writer is allowed per instance.
;    * Note that this may open resource files that are not closed
;    * until you call ICEnd.
;    
; 
;  *  ICGetPref()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICGetPref" 
   ((inst (:pointer :OpaqueICInstance))
    (key (:pointer :STR255))
    (attr (:pointer :ICATTR))
    (buf :pointer)
    (size (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [c1] [b4] 
;    * Reads the preference specified by key from the IC database to the
;    * buffer pointed to by buf and size.
;    * key must not be the empty string.
;    * If buf is nil then no data is returned.
;    * size must be non-negative.
;    * attr and size are always set on return. On errors (except icTruncatedErr)
;    * attr is set to ICattr_no_change and size is set to 0.
;    * size is the actual size of the data.
;    * attr is set to the attributes associated with the preference.
;    * If this routine returns icTruncatedErr then the other returned
;    * values are valid except that only the first size bytes have been
;    * return. size is adjusted to reflect the true size of the preference.
;    * Returns icPrefNotFound if there is no preference for the key.
;    
; 
;  *  ICSetPref()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICSetPref" 
   ((inst (:pointer :OpaqueICInstance))
    (key (:pointer :STR255))
    (attr :UInt32)
    (buf :pointer)
    (size :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [c1] [b4] 
;    * Sets the preference specified by key from the IC database to the
;    * value pointed to by buf and size.
;    * key must not be the empty string.
;    * size must be non-negative. 
;    * If buf is nil then the preference value is not set and size is ignored.
;    * If buf is not nil then the preference value is set to the size
;    * bytes pointed to by buf.
;    * If attr is ICattr_no_change then the preference attributes are not set.
;    * Otherwise the preference attributes are set to attr.
;    * Returns icPermErr if the previous ICBegin was passed icReadOnlyPerm.
;    * Returns icPermErr if current attr is locked, new attr is locked and buf <> nil.
;    
; 
;  *  ICFindPrefHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICFindPrefHandle" 
   ((inst (:pointer :OpaqueICInstance))
    (key (:pointer :STR255))
    (attr (:pointer :ICATTR))
    (prefh :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r2] [c1] [b4] 
;    * This routine effectively replaces ICGetPrefHandle.
;    * Reads the preference specified by key from the IC database into
;    * a handle, prefh.
;    * key must not be the empty string.
;    * attr is set to the attributes associated with the preference.
;    * You must set prefh to a non-nil handle before calling this routine.
;    * If the preference does not exist, icPrefNotFoundErr is returned.
;    
; 
;  *  ICGetPrefHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICGetPrefHandle" 
   ((inst (:pointer :OpaqueICInstance))
    (key (:pointer :STR255))
    (attr (:pointer :ICATTR))
    (prefh (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b4] 
;    * This routine is now obsolete. Use ICFindPrefHandle instead.
;    * Reads the preference specified by key from the IC database into
;    * a newly created handle, prefh.
;    * key must not be the empty string.
;    * attr is set to the attributes associated with the preference.
;    * The incoming value of prefh is ignored.
;    * A new handle is created in the current heap and returned in prefh.
;    * If the routine returns an error, prefh is set to nil.
;    * If the preference does not exist, no error is returned and prefh is set
;    * to an empty handle.
;    
; 
;  *  ICSetPrefHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICSetPrefHandle" 
   ((inst (:pointer :OpaqueICInstance))
    (key (:pointer :STR255))
    (attr :UInt32)
    (prefh :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b4] 
;    * Sets the preference specified by key from the IC database to the
;    * value contained in prefh.
;    * key must not be the empty string.
;    * If prefh is nil then the preference value is not set.
;    * If prefh is not nil then the preference value is set to the data
;    * contained in it.
;    * If attr is ICattr_no_change then the preference attributes are not set.
;    * Otherwise the preference attributes are set to attr.
;    * Returns icPermErr if the previous ICBegin was passed icReadOnlyPerm.
;    * Returns icPermErr if current attr is locked, new attr is locked and prefh <> nil.
;    
; 
;  *  ICCountPref()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICCountPref" 
   ((inst (:pointer :OpaqueICInstance))
    (count (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [c1] [b1] 
;    * Counts the total number of preferences.
;    * If the routine returns an error, count is set to 0.
;    
; 
;  *  ICGetIndPref()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICGetIndPref" 
   ((inst (:pointer :OpaqueICInstance))
    (index :signed-long)
    (key (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [c1] [b1] 
;    * Returns the key of the index'th preference.
;    * index must be positive.
;    * Returns icPrefNotFoundErr if index is greater than the total number of preferences.
;    * If the routine returns an error, key is undefined.
;    
; 
;  *  ICDeletePref()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICDeletePref" 
   ((inst (:pointer :OpaqueICInstance))
    (key (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [c1] [b2] 
;    * Deletes the preference specified by key.
;    * key must not be the empty string.
;    * Returns icPrefNotFound if the preference specified by key is not present.
;    
; 
;  *  ICEnd()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICEnd" 
   ((inst (:pointer :OpaqueICInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [c1] [b1] 
;    * Terminates a preference session, as started by ICBegin.
;    * You must have called ICBegin before calling this routine.
;    
; 
;  *  ICGetDefaultPref()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICGetDefaultPref" 
   ((inst (:pointer :OpaqueICInstance))
    (key (:pointer :STR255))
    (prefH :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r4] [c3] [b5] 
;    * Returns a default preference value for the specified key.  You
;    * must pass in a valid prefH, which is resized to fit the data.
;    
;  ***** User Interface Stuff *****  
; 
;  *  ICEditPreferences()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICEditPreferences" 
   ((inst (:pointer :OpaqueICInstance))
    (key (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b3] 
;    * Instructs IC to display the user interface associated with editing
;    * preferences and focusing on the preference specified by key.
;    * If key is the empty string then no preference should be focused upon.
;    * You must have specified a configuration before calling this routine.
;    * You do not need to call ICBegin before calling this routine.
;    * In the current implementation this launches the IC application
;    * (or brings it to the front) and displays the window containing
;    * the preference specified by key.
;    * It may have a radically different implementation in future
;    * IC systems.
;    
;  ***** URL Handling *****  
; 
;  *  ICLaunchURL()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICLaunchURL" 
   ((inst (:pointer :OpaqueICInstance))
    (hint (:pointer :STR255))
    (data :pointer)
    (len :signed-long)
    (selStart (:pointer :long))
    (selEnd (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b3] 
;    * Parses a URL out of the specified text and feeds it off to the
;    * appropriate helper.
;    * hint indicates the default scheme for URLs of the form "name@address".
;    * If hint is the empty string then URLs of that form are not allowed.
;    * data points to the start of the text. It must not be nil.
;    * len indicates the length of the text. It must be non-negative.
;    * selStart and selEnd should be passed in as the current selection of
;    * the text. This selection is given in the same manner as TextEdit,
;    * ie if selStart = selEnd then there is no selection only an insertion
;    * point. Also selStart � selEnd and 0 � selStart � len and 0 � selEnd � len.
;    * selStart and selEnd are returned as the bounds of the URL. If the
;    * routine returns an error then these new boundaries may be
;    * invalid but they will be close.
;    * The URL is parsed out of the text and passed off to the appropriate
;    * helper using the GURL AppleEvent.
;    
; 
;  *  ICParseURL()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICParseURL" 
   ((inst (:pointer :OpaqueICInstance))
    (hint (:pointer :STR255))
    (data :pointer)
    (len :signed-long)
    (selStart (:pointer :long))
    (selEnd (:pointer :long))
    (url :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b3] 
;    * Parses a URL out of the specified text and returns it in a canonical form
;    * in a handle.
;    * hint indicates the default scheme for URLs of the form "name@address".
;    * If hint is the empty string then URLs of that form are not allowed.
;    * data points to the start of the text. It must not be nil.
;    * len indicates the length of the text. It must be non-negative.
;    * selStart and selEnd should be passed in as the current selection of
;    * the text. This selection is given in the same manner as TextEdit,
;    * ie if selStart = selEnd then there is no selection only an insertion
;    * point. Also selStart � selEnd and 0 � selStart � len and 0 � selEnd � len.
;    * selStart and selEnd are returned as the bounds of the URL. If the
;    * routine returns an error then these new boundaries may be
;    * invalid but they will be close.
;    * The incoming url handle must not be nil.  The resulting URL is normalised
;    * and copied into the url handle, which is resized to fit.
;    
; 
;  *  ICCreateGURLEvent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICCreateGURLEvent" 
   ((inst (:pointer :OpaqueICInstance))
    (helperCreator :OSType)
    (urlH :Handle)
    (theEvent (:pointer :AppleEvent))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r4] [c1] [b3] 
;    * Creates a GURL Apple event, targetted at the application whose creator
;    * code is helperCreator, with a direct object containing the URL text from urlH.
;    
; 
;  *  ICSendGURLEvent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICSendGURLEvent" 
   ((inst (:pointer :OpaqueICInstance))
    (theEvent (:pointer :AppleEvent))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r4] [c1] [b3] 
;    * Sends theEvent to the target application.
;    
;  ***** Mappings Routines *****
;  * 
;  * Routines for interrogating mappings database.
;  * 
;  * ----- High Level Routines -----
;   
; 
;  *  ICMapFilename()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICMapFilename" 
   ((inst (:pointer :OpaqueICInstance))
    (filename (:pointer :STR255))
    (entry (:pointer :ICMapEntry))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b4] 
;    * Takes the name of an incoming file and returns the most appropriate
;    * mappings database entry, based on its extension.
;    * filename must not be the empty string.
;    * Returns icPrefNotFoundErr if no suitable entry is found.
;    
; 
;  *  ICMapTypeCreator()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICMapTypeCreator" 
   ((inst (:pointer :OpaqueICInstance))
    (fType :OSType)
    (fCreator :OSType)
    (filename (:pointer :STR255))
    (entry (:pointer :ICMapEntry))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b4] 
;    * Takes the type and creator (and optionally the name) of an outgoing
;    * file and returns the most appropriate mappings database entry.
;    * The filename may be either the name of the outgoing file or
;    * the empty string.
;    * Returns icPrefNotFoundErr if no suitable entry found.
;    
;  ----- Mid Level Routines -----  
; 
;  *  ICMapEntriesFilename()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICMapEntriesFilename" 
   ((inst (:pointer :OpaqueICInstance))
    (entries :Handle)
    (filename (:pointer :STR255))
    (entry (:pointer :ICMapEntry))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b3] 
;    * Takes the name of an incoming file and returns the most appropriate
;    * mappings database entry, based on its extension.
;    * entries must be a handle to a valid IC mappings database preference.
;    * filename must not be the empty string.
;    * Returns icPrefNotFoundErr if no suitable entry is found.
;    
; 
;  *  ICMapEntriesTypeCreator()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICMapEntriesTypeCreator" 
   ((inst (:pointer :OpaqueICInstance))
    (entries :Handle)
    (fType :OSType)
    (fCreator :OSType)
    (filename (:pointer :STR255))
    (entry (:pointer :ICMapEntry))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b3] 
;    * Takes the type and creator (and optionally the name) of an outgoing
;    * file and returns the most appropriate mappings database entry.
;    * entries must be a handle to a valid IC mappings database preference.
;    * The filename may be either the name of the outgoing file or
;    * the empty string.
;    * Returns icPrefNotFoundErr if no suitable entry found.
;    
;  ----- Low Level Routines -----  
; 
;  *  ICCountMapEntries()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICCountMapEntries" 
   ((inst (:pointer :OpaqueICInstance))
    (entries :Handle)
    (count (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b3] 
;    * Counts the number of entries in the mappings database.
;    * entries must be a handle to a valid IC mappings database preference.
;    * count is set to the number of entries.
;    
; 
;  *  ICGetIndMapEntry()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICGetIndMapEntry" 
   ((inst (:pointer :OpaqueICInstance))
    (entries :Handle)
    (index :signed-long)
    (pos (:pointer :long))
    (entry (:pointer :ICMapEntry))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b3] 
;    * Gets the index'th entry in the mappings database.
;    * entries must be a handle to a valid IC mappings database preference.
;    * index must be in the range from 1 to the number of entries in the database.
;    * The value of pos is ignored on input. pos is set to the position of
;    * the index'th entry in the database and is suitable for passing back
;    * into ICSetMapEntry.
;    * Does not return any user data associated with the entry.
;    
; 
;  *  ICGetMapEntry()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICGetMapEntry" 
   ((inst (:pointer :OpaqueICInstance))
    (entries :Handle)
    (pos :signed-long)
    (entry (:pointer :ICMapEntry))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b3] 
;    * Returns the entry located at position pos in the mappings database.
;    * entries must be a handle to a valid IC mappings database preference.
;    * pos should be 0 to get the first entry. To get the subsequent entries, add
;    * entry.total_size to pos and iterate.
;    * Does not return any user data associated with the entry.
;    
; 
;  *  ICSetMapEntry()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICSetMapEntry" 
   ((inst (:pointer :OpaqueICInstance))
    (entries :Handle)
    (pos :signed-long)
    (entry (:pointer :ICMapEntry))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b3] 
;    * Sets the entry located at position pos in the mappings database.
;    * entries must be a handle to a valid IC mappings database preference.
;    * pos should be either a value returned from ICGetIndMapEntry or a value
;    * calculated using ICGetMapEntry.
;    * entry is a var parameter purely for stack space reasons. It is not
;    * modified in any way.
;    * Any user data associated with the entry is unmodified.
;    
; 
;  *  ICDeleteMapEntry()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICDeleteMapEntry" 
   ((inst (:pointer :OpaqueICInstance))
    (entries :Handle)
    (pos :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b3] 
;    * Deletes the mappings database entry at pos.
;    * entries must be a handle to a valid IC mappings database preference.
;    * pos should be either a value returned from ICGetIndMapEntry or a value
;    * calculated using ICGetMapEntry.
;    * Also deletes any user data associated with the entry.
;    
; 
;  *  ICAddMapEntry()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICAddMapEntry" 
   ((inst (:pointer :OpaqueICInstance))
    (entries :Handle)
    (entry (:pointer :ICMapEntry))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r1] [c1] [b3] 
;    * Adds an entry to the mappings database.
;    * entries must be a handle to a valid IC mappings database preference.
;    * The entry is added to the end of the entries database.
;    * No user data is added.
;    
;  ***** Profile Management Routines *****  
; 
;  *  ICGetCurrentProfile()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICGetCurrentProfile" 
   ((inst (:pointer :OpaqueICInstance))
    (currentID (:pointer :ICProfileID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r3] [c1] [b3] 
;    * Returns the profile ID of the current profile.
;    
; 
;  *  ICSetCurrentProfile()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICSetCurrentProfile" 
   ((inst (:pointer :OpaqueICInstance))
    (newID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r3] [c1] [b3] 
;    * Sets the current profile to the profile specified in newProfile.
;    
; 
;  *  ICCountProfiles()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICCountProfiles" 
   ((inst (:pointer :OpaqueICInstance))
    (count (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r3] [c1] [b1] 
;    * Returns the total number of profiles.
;    
; 
;  *  ICGetIndProfile()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICGetIndProfile" 
   ((inst (:pointer :OpaqueICInstance))
    (index :signed-long)
    (thisID (:pointer :ICProfileID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r3] [c1] [b1] 
;    * Returns the profile ID of the index'th profile.  index must be positive.
;    * Returns icProfileNotFoundErr if index is greater than the total number
;    * of profiles.
;    
; 
;  *  ICGetProfileName()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICGetProfileName" 
   ((inst (:pointer :OpaqueICInstance))
    (thisID :signed-long)
    (name (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r3] [c1] [b3] 
;    * Returns the name of a profile given its ID.  The name may not uniquely
;    * identify the profile.  [That's what the profile ID is for!]  The name
;    * is assumed to be in the system script.
;    
; 
;  *  ICSetProfileName()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICSetProfileName" 
   ((inst (:pointer :OpaqueICInstance))
    (thisID :signed-long)
    (name (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r3] [c1] [b3] 
;    * This routine sets the name of the specified profile.  Profile names
;    * need not be unique.  The name should be in the system script.
;    
; 
;  *  ICAddProfile()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICAddProfile" 
   ((inst (:pointer :OpaqueICInstance))
    (prototypeID :signed-long)
    (newID (:pointer :ICProfileID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r3] [c1] [b2] 
;    * If prototypeID = kICNilProfileID, this routine
;    * creates a default profile, otherwise it creates a
;    * profile by cloning the prototype profile.  The ID
;    * of the new profile is returned in newID.
;    * The new profile will be give a new, unique, name.
;    * This does not switch to the new profile.
;    
; 
;  *  ICDeleteProfile()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  

(deftrap-inline "_ICDeleteProfile" 
   ((inst (:pointer :OpaqueICInstance))
    (thisID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  [r3] [c1] [b2] 
;    * This routine deletes the profile specified by
;    * thisID.  Attempting to delete the current profile
;    * or the last profile will return error.
;    
; ***********************************************************************************************
;   NOTHING BELOW THIS DIVIDER IS IN CARBON
;  ***********************************************************************************************
;  ***** Interrupt Safe Routines *****  
; 
;  *  ICRequiresInterruptSafe()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [r3] [c2] [b3] 
;    * You must call this routine before calling GetMapEntryInterruptSafe
;    * to give IC chance to cache the mappings data in memory.  The only
;    * way to clear this state is to close the instance.  You can not reconfigure
;    * the instance after calling this routine.
;    
; 
;  *  ICGetMappingInterruptSafe()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [r3] [c2] [b3] 
;    * Returns the "Mapping" preference in an interrupt safe fashion.
;    * The preference returned pointer is valid until the next
;    * non-interrupt safe call to IC.  Typically this API is used
;    * by software that needs to map extensions to type and creator
;    * at interrupt time, eg foreign file systems.
;    
; 
;  *  ICGetSeedInterruptSafe()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  [r3] [c2] [b3] 
;    * An interrupt safe version of ICGetSeed.
;    
;  ***** Starting Up and Shutting Down *****  
; 
;  *  ICCStart()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCStart.  
; 
;  *  ICCStop()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCStop.  
; 
;  *  ICCGetVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetVersion.  
;  ***** Specifying a Configuration *****  
; 
;  *  ICCFindConfigFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCFindConfigFile.  
; 
;  *  ICCFindUserConfigFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCFindUserConfigFile.  
; 
;  *  ICCGeneralFindConfigFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGeneralFindConfigFile.  
; 
;  *  ICCChooseConfig()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCChooseConfig.  
; 
;  *  ICCChooseNewConfig()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCChooseNewConfig.  
; 
;  *  ICCGetConfigName()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetConfigName.  
; 
;  *  ICCGetConfigReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetConfigReference.  
; 
;  *  ICCSetConfigReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCSetConfigReference.  
;  ***** Private Routines *****
;  * 
;  * If you are calling these routines, you are most probably doing something
;  * wrong.  Please read the documentation for more details.
;   
; 
;  *  ICCSpecifyConfigFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCSpecifyConfigFile.  
; 
;  *  ICCRefreshCaches()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCRefreshCaches.  
;  ***** Getting Information *****  
; 
;  *  ICCGetSeed()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetSeed.  
; 
;  *  ICCGetPerm()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetPerm.  
; 
;  *  ICCDefaultFileName()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCDefaultFileName.  
; 
;  *  ICCGetComponentInstance()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetComponentInstance.  
;  ***** Reading and Writing Preferences *****  
; 
;  *  ICCBegin()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCBegin.  
; 
;  *  ICCGetPref()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetPref.  
; 
;  *  ICCSetPref()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCSetPref.  
; 
;  *  ICCFindPrefHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCFindPrefHandle.  
; 
;  *  ICCGetPrefHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetPrefHandle.  
; 
;  *  ICCSetPrefHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCSetPrefHandle.  
; 
;  *  ICCCountPref()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCCountPref.  
; 
;  *  ICCGetIndPref()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetIndPref.  
; 
;  *  ICCDeletePref()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCDeletePref.  
; 
;  *  ICCEnd()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCEnd.  
; 
;  *  ICCGetDefaultPref()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetDefaultPref.  
;  ***** User Interface Stuff *****  
; 
;  *  ICCEditPreferences()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCEditPreferences.  
;  ***** URL Handling *****  
; 
;  *  ICCLaunchURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCLaunchURL.  
; 
;  *  ICCParseURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCParseURL.  
; 
;  *  ICCCreateGURLEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCCreateGURLEvent.  
; 
;  *  ICCSendGURLEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCSendGURLEvent.  
;  ***** Mappings Routines *****
;  * 
;  * Routines for interrogating mappings database.
;  * 
;  * ----- High Level Routines -----
;   
; 
;  *  ICCMapFilename()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCMapFilename.  
; 
;  *  ICCMapTypeCreator()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCMapTypeCreator.  
;  ----- Mid Level Routines -----  
; 
;  *  ICCMapEntriesFilename()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCMapEntriesFilename.  
; 
;  *  ICCMapEntriesTypeCreator()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCMapEntriesTypeCreator.  
;  ----- Low Level Routines -----  
; 
;  *  ICCCountMapEntries()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCCountMapEntries.  
; 
;  *  ICCGetIndMapEntry()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetIndMapEntry.  
; 
;  *  ICCGetMapEntry()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetMapEntry.  
; 
;  *  ICCSetMapEntry()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCSetMapEntry.  
; 
;  *  ICCDeleteMapEntry()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCDeleteMapEntry.  
; 
;  *  ICCAddMapEntry()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCAddMapEntry.  
;  ***** Profile Management Routines *****  
; 
;  *  ICCGetCurrentProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetCurrentProfile.  
; 
;  *  ICCSetCurrentProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCSetCurrentProfile.  
; 
;  *  ICCCountProfiles()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCCountProfiles.  
; 
;  *  ICCGetIndProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetIndProfile.  
; 
;  *  ICCGetProfileName()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetProfileName.  
; 
;  *  ICCSetProfileName()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCSetProfileName.  
; 
;  *  ICCAddProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCAddProfile.  
; 
;  *  ICCDeleteProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCDeleteProfile.  
;  ***** Interrupt Safe Routines *****  
; 
;  *  ICCRequiresInterruptSafe()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCRequiresInterruptSafe.  
; 
;  *  ICCGetMappingInterruptSafe()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetMappingInterruptSafe.  
; 
;  *  ICCGetSeedInterruptSafe()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InternetConfig 2.5 and later
;  
;  See comment for ICCGetSeedInterruptSafe.  

; #if CALL_NOT_IN_CARBON
#| 
; ***********************************************************************************************
;   component selectors
;  ***********************************************************************************************

(defconstant $kICCStart 0)
(defconstant $kICCStop 1)
(defconstant $kICCGetVersion 50)
(defconstant $kICCFindConfigFile 2)
(defconstant $kICCFindUserConfigFile 14)
(defconstant $kICCGeneralFindConfigFile 30)
(defconstant $kICCChooseConfig 33)
(defconstant $kICCChooseNewConfig 34)
(defconstant $kICCGetConfigName 35)
(defconstant $kICCGetConfigReference 31)
(defconstant $kICCSetConfigReference 32)
(defconstant $kICCSpecifyConfigFile 3)
(defconstant $kICCRefreshCaches 47)
(defconstant $kICCGetSeed 4)
(defconstant $kICCGetPerm 13)
(defconstant $kICCDefaultFileName 11)
(defconstant $kICCBegin 5)
(defconstant $kICCGetPref 6)
(defconstant $kICCSetPref 7)
(defconstant $kICCFindPrefHandle 36)
(defconstant $kICCGetPrefHandle 26)
(defconstant $kICCSetPrefHandle 27)
(defconstant $kICCCountPref 8)
(defconstant $kICCGetIndPref 9)
(defconstant $kICCDeletePref 12)
(defconstant $kICCEnd 10)
(defconstant $kICCGetDefaultPref 49)
(defconstant $kICCEditPreferences 15)
(defconstant $kICCLaunchURL 17)
(defconstant $kICCParseURL 16)
(defconstant $kICCCreateGURLEvent 51)
(defconstant $kICCSendGURLEvent 52)
(defconstant $kICCMapFilename 24)
(defconstant $kICCMapTypeCreator 25)
(defconstant $kICCMapEntriesFilename 28)
(defconstant $kICCMapEntriesTypeCreator 29)
(defconstant $kICCCountMapEntries 18)
(defconstant $kICCGetIndMapEntry 19)
(defconstant $kICCGetMapEntry 20)
(defconstant $kICCSetMapEntry 21)
(defconstant $kICCDeleteMapEntry 22)
(defconstant $kICCAddMapEntry 23)
(defconstant $kICCGetCurrentProfile 37)
(defconstant $kICCSetCurrentProfile 38)
(defconstant $kICCCountProfiles 39)
(defconstant $kICCGetIndProfile 40)
(defconstant $kICCGetProfileName 41)
(defconstant $kICCSetProfileName 42)
(defconstant $kICCAddProfile 43)
(defconstant $kICCDeleteProfile 44)
(defconstant $kICCRequiresInterruptSafe 45)
(defconstant $kICCGetMappingInterruptSafe 46)
(defconstant $kICCGetSeedInterruptSafe 48)
(defconstant $kICCFirstSelector 0)
(defconstant $kICCLastSelector 52)
; ***********************************************************************************************
;   component selector proc infos
;  ***********************************************************************************************

(defconstant $kICCStartProcInfo #x3F0)
(defconstant $kICCStopProcInfo #xF0)
(defconstant $kICCGetVersionProcInfo #xFF0)
(defconstant $kICCFindConfigFileProcInfo #xEF0)
(defconstant $kICCFindUserConfigFileProcInfo #x3F0)
(defconstant $kICCGeneralFindConfigFileProcInfo #xE5F0)
(defconstant $kICCChooseConfigProcInfo #xF0)
(defconstant $kICCChooseNewConfigProcInfo #xF0)
(defconstant $kICCGetConfigNameProcInfo #xDF0)
(defconstant $kICCGetConfigReferenceProcInfo #x3F0)
(defconstant $kICCSetConfigReferenceProcInfo #xFF0)
(defconstant $kICCSpecifyConfigFileProcInfo #x3F0)
(defconstant $kICCRefreshCachesProcInfo #xF0)
(defconstant $kICCGetSeedProcInfo #x3F0)
(defconstant $kICCGetPermProcInfo #x3F0)
(defconstant $kICCDefaultFileNameProcInfo #x3F0)
(defconstant $kICCGetComponentInstanceProcInfo #x3F0)
(defconstant $kICCBeginProcInfo #x1F0)
(defconstant $kICCGetPrefProcInfo #xFFF0)
(defconstant $kICCSetPrefProcInfo #xFFF0)
(defconstant $kICCFindPrefHandleProcInfo #x3FF0)
(defconstant $kICCGetPrefHandleProcInfo #x3FF0)
(defconstant $kICCSetPrefHandleProcInfo #x3FF0)
(defconstant $kICCCountPrefProcInfo #x3F0)
(defconstant $kICCGetIndPrefProcInfo #xFF0)
(defconstant $kICCDeletePrefProcInfo #x3F0)
(defconstant $kICCEndProcInfo #xF0)
(defconstant $kICCGetDefaultPrefProcInfo #xFF0)
(defconstant $kICCEditPreferencesProcInfo #x3F0)
(defconstant $kICCLaunchURLProcInfo #x3FFF0)
(defconstant $kICCParseURLProcInfo #xFFFF0)
(defconstant $kICCCreateGURLEventProcInfo #x3FF0)
(defconstant $kICCSendGURLEventProcInfo #x3F0)
(defconstant $kICCMapFilenameProcInfo #xFF0)
(defconstant $kICCMapTypeCreatorProcInfo #xFFF0)
(defconstant $kICCMapEntriesFilenameProcInfo #x3FF0)
(defconstant $kICCMapEntriesTypeCreatorProcInfo #x3FFF0)
(defconstant $kICCCountMapEntriesProcInfo #xFF0)
(defconstant $kICCGetIndMapEntryProcInfo #xFFF0)
(defconstant $kICCGetMapEntryProcInfo #x3FF0)
(defconstant $kICCSetMapEntryProcInfo #x3FF0)
(defconstant $kICCDeleteMapEntryProcInfo #xFF0)
(defconstant $kICCAddMapEntryProcInfo #xFF0)
(defconstant $kICCGetCurrentProfileProcInfo #x3F0)
(defconstant $kICCSetCurrentProfileProcInfo #x3F0)
(defconstant $kICCCountProfilesProcInfo #x3F0)
(defconstant $kICCGetIndProfileProcInfo #xFF0)
(defconstant $kICCGetProfileNameProcInfo #xFF0)
(defconstant $kICCSetProfileNameProcInfo #xFF0)
(defconstant $kICCAddProfileProcInfo #xFF0)
(defconstant $kICCDeleteProfileProcInfo #x3F0)
(defconstant $kICCRequiresInterruptSafeProcInfo #xF0)
(defconstant $kICCGetMappingInterruptSafeProcInfo #xFF0)
(defconstant $kICCGetSeedInterruptSafeProcInfo #x3F0)
; ***********************************************************************************************
;   component identifiers
;  ***********************************************************************************************

(defconstant $kICComponentType :|PREF|)
(defconstant $kICComponentSubType :|ICAp|)
(defconstant $kICComponentManufacturer :|JPQE|)
; ***********************************************************************************************
;   The following type is now obsolete.
;   If you're using it, please switch to ComponentInstance or ICInstance.
;  ***********************************************************************************************

; #if OLDROUTINENAMES

(def-mactype :internetConfigurationComponent (find-mactype ':ComponentInstance))

; #endif  /* OLDROUTINENAMES */

 |#

; #endif  /* CALL_NOT_IN_CARBON */

; ***********************************************************************************************
;   old names for stuff declared above
;  ***********************************************************************************************

; #if OLDROUTINENAMES
#| 
(def-mactype :ICError (find-mactype ':signed-long))

(defconstant $ICattr_no_change #xFFFFFFFF)
(defconstant $ICattr_locked_bit 0)
(defconstant $ICattr_locked_mask 1)
(defconstant $ICattr_volatile_bit 1)
(defconstant $ICattr_volatile_mask 2)
(defconstant $icNoUserInteraction_bit 0)
(defconstant $icNoUserInteraction_mask 1)
(defconstant $ICfiletype :|ICAp|)
(defconstant $ICcreator :|ICAp|)
; 
;     ICFileInfo was originally used to define the format of a key.
;     That key was removed, but we forgot to remove ICFileInfo.
;     I hope to remove it entirely, but for the moment it's available
;     if you define OLDROUTINENAMES.
; 
(defrecord ICFileInfo
   (fType :OSType)
   (fCreator :OSType)
   (name (:string 63))
)

;type name? (def-mactype :ICFileInfo (find-mactype ':ICFileInfo))

(def-mactype :ICFileInfoPtr (find-mactype '(:pointer :ICFileInfo)))

(def-mactype :ICFileInfoHandle (find-mactype '(:pointer :ICFileInfoPtr)))

(defconstant $ICfile_spec_header_size 18)

(defconstant $ICmap_binary_bit 0)
(defconstant $ICmap_binary_mask 1)
(defconstant $ICmap_resource_fork_bit 1)
(defconstant $ICmap_resource_fork_mask 2)
(defconstant $ICmap_data_fork_bit 2)
(defconstant $ICmap_data_fork_mask 4)
(defconstant $ICmap_post_bit 3)
(defconstant $ICmap_post_mask 8)
(defconstant $ICmap_not_incoming_bit 4)
(defconstant $ICmap_not_incoming_mask 16)
(defconstant $ICmap_not_outgoing_bit 5)
(defconstant $ICmap_not_outgoing_mask 32)
(defconstant $ICmap_fixed_length 22)

(defconstant $ICservices_tcp_bit 0)
(defconstant $ICservices_tcp_mask 1)
(defconstant $ICservices_udp_bit 1)
(defconstant $ICservices_udp_mask 2)
;     This definitions are a) very long, and b) don't conform
;     to Mac OS standards for naming constants, so I've put
;     them in only if you're using OLDROUTINENAMES.  Please switch
;     to the new names given above.
; 

(defconstant $internetConfigurationComponentType :|PREF|);  the component type 

(defconstant $internetConfigurationComponentSubType :|ICAp|);  the component subtype 

(defconstant $internetConfigurationComponentInterfaceVersion0 0);  IC >= 1.0 

(defconstant $internetConfigurationComponentInterfaceVersion1 #x10000);  IC >= 1.1 

(defconstant $internetConfigurationComponentInterfaceVersion2 #x20000);  IC >= 1.2 

(defconstant $internetConfigurationComponentInterfaceVersion3 #x30000);  IC >= 2.0 
;  current version number is version 3 

(defconstant $internetConfigurationComponentInterfaceVersion #x30000)
 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __INTERNETCONFIG__ */


(provide-interface "InternetConfig")