(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OpenTransportProviders.h"
; at Sunday July 2,2006 7:23:34 pm.
; 
;      File:       OT/OpenTransportProviders.h
;  
;      Contains:   This file contains provider-specific definitions for various built-in providers.
;  
;      Version:    OpenTransport-90~46
;  
;      Copyright:  © 1993-2003 by Apple Computer, Inc. and Mentat Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __OPENTRANSPORTPROVIDERS__
; #define __OPENTRANSPORTPROVIDERS__
; #ifndef __OPENTRANSPORT__
#| #|
#include <OSServicesOpenTransport.h>
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

; #if defined(__MWERKS__) && TARGET_CPU_68K
#| ; #pragma push
; #pragma pointers_in_D0
 |#

; #endif

;  ***** TCP/IP *****
;  Basic types

(def-mactype :InetPort (find-mactype ':UInt16))

(def-mactype :InetHost (find-mactype ':UInt32))
;   Enums used as address type designations.
(defconstant $AF_INET 2)
; #define AF_INET 2

(defconstant $AF_DNS 42)
; 
;     Enum which can be used to bind to all IP interfaces
;     rather than a specific one.
; 

(defconstant $kOTAnyInetAddress 0)              ;  Wildcard

; 
;    Define the InetSvcRef type.  This type needs special
;    processing because in C++ it's a subclass of TProvider.
;    See the definition of TEndpointRef in "OpenTransport.h"
;    for the logic behind this definition.
; 
; #ifdef __cplusplus
#| #|
 typedef class TInternetServices*   InetSvcRef;
|#
 |#

; #else

(def-mactype :InetSvcRef (find-mactype '(:pointer :void)))

; #endif

; #define kDefaultInternetServicesPath        ((OTConfigurationRef)-3L)
;  Shared library prefixes
(defconstant $kInetVersion "3.1.1")
; #define kInetVersion   "3.1.1"
(defconstant $kInetPrefix "ot:inet$")
; #define kInetPrefix     "ot:inet$"
;  Module Names
(defconstant $kDNRName "dnr")
; #define kDNRName       "dnr"
(defconstant $kTCPName "tcp")
; #define kTCPName      "tcp"
(defconstant $kUDPName "udp")
; #define kUDPName      "udp"
(defconstant $kRawIPName "rawip")
; #define kRawIPName        "rawip"
;  XTI Options
;  Protocol levels

(defconstant $INET_IP 0)
(defconstant $INET_TCP 6)
(defconstant $INET_UDP 17)
;  TCP Level Options

(defconstant $TCP_NODELAY 1)
(defconstant $TCP_MAXSEG 2)
(defconstant $TCP_NOTIFY_THRESHOLD 16)          ; * not a real XTI option 

(defconstant $TCP_ABORT_THRESHOLD 17)           ; * not a real XTI option 

(defconstant $TCP_CONN_NOTIFY_THRESHOLD 18)     ; * not a real XTI option 

(defconstant $TCP_CONN_ABORT_THRESHOLD 19)      ; * not a real XTI option 

(defconstant $TCP_OOBINLINE 20)                 ; * not a real XTI option 

(defconstant $TCP_URGENT_PTR_TYPE 21)           ; * not a real XTI option 

(defconstant $TCP_KEEPALIVE 8)                  ;  keepalive defined in OpenTransport.h 

; 
;    Mentat's code does an #ifdef on this symbol, so we have to #define
;    it as well as declare it as an enum.  But only for Apple builds because
;    we don't want internal weirdness to propagate to developers.
; 
; #define TCP_NODELAY TCP_NODELAY
; #define TCP_MAXSEG TCP_MAXSEG
; #define TCP_NOTIFY_THRESHOLD TCP_NOTIFY_THRESHOLD
; #define TCP_ABORT_THRESHOLD TCP_ABORT_THRESHOLD
; #define TCP_CONN_NOTIFY_THRESHOLD TCP_CONN_NOTIFY_THRESHOLD
; #define TCP_CONN_ABORT_THRESHOLD TCP_CONN_ABORT_THRESHOLD
; #define TCP_OOBINLINE TCP_OOBINLINE
; #define TCP_URGENT_PTR_TYPE TCP_URGENT_PTR_TYPE
; #define TCP_KEEPALIVE TCP_KEEPALIVE

(defconstant $T_GARBAGE 2)
;  UDP Level Options

(defconstant $UDP_CHECKSUM #x600)
(defconstant $UDP_RX_ICMP 2)
; 
;    Mentat's code does an #ifdef on this symbol, so we have to #define
;    it as well as declare it as an enum.  But only for Apple builds because
;    we don't want internal weirdness to propagate to developers.
; 
; #define UDP_CHECKSUM UDP_CHECKSUM
; #define UDP_RX_ICMP UDP_RX_ICMP
;  IP Level Options

(defconstant $kIP_OPTIONS 1)
(defconstant $kIP_TOS 2)
(defconstant $kIP_TTL 3)
(defconstant $kIP_REUSEADDR 4)
(defconstant $kIP_DONTROUTE 16)
(defconstant $kIP_BROADCAST 32)
(defconstant $kIP_REUSEPORT #x200)
(defconstant $kIP_HDRINCL #x1002)
(defconstant $kIP_RCVOPTS #x1005)
(defconstant $kIP_RCVDSTADDR #x1007)
(defconstant $kIP_MULTICAST_IF #x1010)          ;  set/get IP multicast interface 

(defconstant $kIP_MULTICAST_TTL #x1011)         ;  set/get IP multicast timetolive    

(defconstant $kIP_MULTICAST_LOOP #x1012)        ;  set/get IP multicast loopback  

(defconstant $kIP_ADD_MEMBERSHIP #x1013)        ;  add an IP group membership     

(defconstant $kIP_DROP_MEMBERSHIP #x1014)       ;  drop an IP group membership       

(defconstant $kIP_BROADCAST_IFNAME #x1015)      ;  Set interface for broadcasts   

(defconstant $kIP_RCVIFADDR #x1016)             ;  Set interface for broadcasts   

(defconstant $IP_OPTIONS 1)
; #define IP_OPTIONS 1
; 
;    BSD's netinet/in.h uses different values for the same IP_ logical constants.
;    If you are using OT and want those values, prefix your use with k
;    e.g. change IP_TTL to kIP_TTL in your source code
; 

(defconstant $DVMRP_INIT 100)                   ;  DVMRP-specific setsockopt commands, from ip_mroute.h

(defconstant $DVMRP_DONE 101)
(defconstant $DVMRP_ADD_VIF 102)
(defconstant $DVMRP_DEL_VIF 103)
(defconstant $DVMRP_ADD_LGRP 104)
(defconstant $DVMRP_DEL_LGRP 105)
(defconstant $DVMRP_ADD_MRT 106)
(defconstant $DVMRP_DEL_MRT 107)
;  IP_TOS precdence levels

(defconstant $T_ROUTINE 0)
(defconstant $T_PRIORITY 1)
(defconstant $T_IMMEDIATE 2)
(defconstant $T_FLASH 3)
(defconstant $T_OVERRIDEFLASH 4)
(defconstant $T_CRITIC_ECP 5)
(defconstant $T_INETCONTROL 6)
(defconstant $T_NETCONTROL 7)
;   IP_TOS type of service

(defconstant $T_NOTOS 0)
(defconstant $T_LDELAY 16)
(defconstant $T_HITHRPT 8)
(defconstant $T_HIREL 4)
; #define SET_TOS(prec,tos)   (((0x7 & (prec)) << 5) | (0x1c & (tos)))
;  IP Multicast option structures
(defrecord TIPAddMulticast
   (multicastGroupAddress :UInt32)
   (interfaceAddress :UInt32)
)

;type name? (%define-record :TIPAddMulticast (find-record-descriptor ':TIPAddMulticast))
;  Protocol-specific events

(defconstant $T_DNRSTRINGTOADDRCOMPLETE #x10000001)
(defconstant $T_DNRADDRTONAMECOMPLETE #x10000002)
(defconstant $T_DNRSYSINFOCOMPLETE #x10000003)
(defconstant $T_DNRMAILEXCHANGECOMPLETE #x10000004)
(defconstant $T_DNRQUERYCOMPLETE #x10000005)
;  InetAddress
(defrecord InetAddress
   (fAddressType :UInt16)                       ;  always AF_INET
   (fPort :UInt16)                              ;  Port number 
   (fHost :UInt32)                              ;  Host address in net byte order
   (fUnused (:array :UInt8 8))                  ;  Traditional unused bytes
)

;type name? (%define-record :InetAddress (find-record-descriptor ':InetAddress))
;  Domain Name Resolver (DNR) 

(defconstant $kMaxHostAddrs 10)
(defconstant $kMaxSysStringLen 32)
(defconstant $kMaxHostNameLen #xFF)
(defrecord InetDomainName
   (contents (:array :character 256))
)
(defrecord InetHostInfo
   (name :INETDOMAINNAME)
   (addrs (:array :UInt32 10))
)

;type name? (%define-record :InetHostInfo (find-record-descriptor ':InetHostInfo))
(defrecord InetSysInfo
   (cpuType (:array :character 32))
   (osType (:array :character 32))
)

;type name? (%define-record :InetSysInfo (find-record-descriptor ':InetSysInfo))
(defrecord InetMailExchange
   (preference :UInt16)
   (exchange :INETDOMAINNAME)
)

;type name? (%define-record :InetMailExchange (find-record-descriptor ':InetMailExchange))
(defrecord DNSQueryInfo
   (qType :UInt16)
   (qClass :UInt16)
   (ttl :UInt32)
   (name :INETDOMAINNAME)
   (responseType :UInt16)                       ;  answer, authority, or additional
   (resourceLen :UInt16)                        ;  actual length of array which follows
   (resourceData (:array :character 4))         ;  size varies
)

;type name? (%define-record :DNSQueryInfo (find-record-descriptor ':DNSQueryInfo))
;  DNSAddress
; 
;    The DNSAddress format is optional and may be used in connects,
;    datagram sends, and resolve address calls.   The name takes the 
;    format "somewhere.com" or "somewhere.com:portnumber" where
;    the ":portnumber" is optional.   The length of this structure
;    is arbitrarily limited to the overall max length of a domain
;    name (255 chars), although a longer one can be use successfully
;    if you use this as a template for doing so.   However, the domain name 
;    is still limited to 255 characters.
; 
(defrecord DNSAddress
   (fAddressType :UInt16)                       ;  always AF_DNS
   (fName :INETDOMAINNAME)
)

;type name? (%define-record :DNSAddress (find-record-descriptor ':DNSAddress))
;  InetInterfaceInfo

(defconstant $kDefaultInetInterface -1)

(defconstant $kInetInterfaceInfoVersion 3)
(defrecord InetInterfaceInfo
   (fAddress :UInt32)
   (fNetmask :UInt32)
   (fBroadcastAddr :UInt32)
   (fDefaultGatewayAddr :UInt32)
   (fDNSAddr :UInt32)
   (fVersion :UInt16)
   (fHWAddrLen :UInt16)
   (fHWAddr (:pointer :UInt8))
   (fIfMTU :UInt32)
   (fReservedPtrs (:array :pointer 2))
   (fDomainName :INETDOMAINNAME)
   (fIPSecondaryCount :UInt32)
   (fReserved (:array :UInt8 252))
)

;type name? (%define-record :InetInterfaceInfo (find-record-descriptor ':InetInterfaceInfo))
;  InetDHCPOption

(defconstant $kAllDHCPOptions -1)
(defconstant $kDHCPLongOption 126)
(defconstant $kDHCPLongOptionReq 127)
(defrecord InetDHCPOption
   (fOptionTag :UInt8)
   (fOptionLen :UInt8)
   (fOptionValue :UInt8)
)

;type name? (%define-record :InetDHCPOption (find-record-descriptor ':InetDHCPOption))
;  TCP/IP Utility Routines
; 
;  *  OTInitInetAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInitInetAddress" 
   ((addr (:pointer :InetAddress))
    (port :UInt16)
    (host :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTInitDNSAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInitDNSAddress" 
   ((addr (:pointer :DNSAddress))
    (str (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  OTInetStringToHost()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInetStringToHost" 
   ((str (:pointer :char))
    (host (:pointer :INETHOST))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTInetHostToString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInetHostToString" 
   ((host :UInt32)
    (str (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTInetGetInterfaceInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInetGetInterfaceInfo" 
   ((info (:pointer :InetInterfaceInfo))
    (val :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTInetGetSecondaryAddresses()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInetGetSecondaryAddresses" 
   ((addr (:pointer :INETHOST))
    (count (:pointer :UInt32))
    (val :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTInetGetDHCPConfigInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  InetServices & DNR Calls

; #if !OTKERNEL
; 
;    Under Carbon, OTOpenInternetServices routines take a client context pointer.  Applications may pass NULL
;    after calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
;    valid client context.
; 
; 
;  *  OTOpenInternetServicesInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTOpenInternetServicesInContext" 
   ((cfig (:pointer :OTConfiguration))
    (oflag :UInt32)
    (err (:pointer :OSStatus))
    (clientContext (:pointer :OpaqueOTClientContextPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :void)
() )
; 
;  *  OTAsyncOpenInternetServicesInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTAsyncOpenInternetServicesInContext" 
   ((cfig (:pointer :OTConfiguration))
    (oflag :UInt32)
    (upp (:pointer :OpaqueOTNotifyProcPtr))
    (contextPtr :pointer)
    (clientContext (:pointer :OpaqueOTClientContextPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTOpenInternetServices()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTAsyncOpenInternetServices()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #if OTCARBONAPPLICATION
#|                                              ;  The following macro may be used by applications only.
; #define OTOpenInternetServices(cfig, oflags, err) OTOpenInternetServicesInContext(cfig, oflags, err, NULL)
; #define OTAsyncOpenInternetServices(cfig, oflags, proc, contextPtr)  OTAsyncOpenInternetServicesInContext(cfig, oflags, proc, contextPtr, NULL)
 |#

; #endif  /* OTCARBONAPPLICATION */

; 
;  *  OTInetStringToAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInetStringToAddress" 
   ((ref (:pointer :void))
    (name (:pointer :char))
    (hinfo (:pointer :InetHostInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTInetAddressToName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInetAddressToName" 
   ((ref (:pointer :void))
    (addr :UInt32)
    (name (:pointer :INETDOMAINNAME))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTInetSysInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInetSysInfo" 
   ((ref (:pointer :void))
    (name (:pointer :char))
    (sysinfo (:pointer :InetSysInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTInetMailExchange()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInetMailExchange" 
   ((ref (:pointer :void))
    (name (:pointer :char))
    (num (:pointer :UInt16))
    (mx (:pointer :InetMailExchange))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTInetQuery()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInetQuery" 
   ((ref (:pointer :void))
    (name (:pointer :char))
    (qClass :UInt16)
    (qType :UInt16)
    (buf (:pointer :char))
    (buflen :UInt32)
    (argv :pointer)
    (argvlen :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}                   
class TInternetServices : public TProvider
{
    public:
            OSStatus    StringToAddress(char* name, InetHostInfo* hinfo)
                        { return OTInetStringToAddress(this, name, hinfo); }
                    
            OSStatus    AddressToName(InetHost addr, InetDomainName name)
                        { return OTInetAddressToName(this, addr, name); }
                    
            OSStatus    SysInfo(char* name, InetSysInfo* sysinfo )
                        { return OTInetSysInfo(this, name, sysinfo); }
                    
            OSStatus    MailExchange(char* name, UInt16* num, InetMailExchange* mx)
                        { return OTInetMailExchange(this, name, num, mx); }
                        
            OSStatus    Query(char* name, UInt16 qClass, UInt16 qType, 
                              char* buf, OTByteCount buflen, 
                              void** argv, OTByteCount argvlen,
                              OTFlags flags)
                        { return OTInetQuery(this, name, qClass, qType, buf, buflen, argv, argvlen, flags); }
};

extern "C" {        
#endif
|#
 |#

; #endif  /* !OTKERNEL */

;  ***** AppleTalk *****
;  Shared library prefixes
(defconstant $kATalkVersion "1.1")
; #define kATalkVersion  "1.1"
(defconstant $kATalkPrefix "ot:atlk$")
; #define kATalkPrefix  "ot:atlk$"
(defconstant $kATBinderID "ot:atbd$")
; #define kATBinderID      "ot:atbd$"
; ******************************************************************************
; ** Module definitions
; *******************************************************************************
;  XTI Levels

(defconstant $ATK_DDP :|DDP |)
(defconstant $ATK_AARP :|AARP|)
(defconstant $ATK_ATP :|ATP |)
(defconstant $ATK_ADSP :|ADSP|)
(defconstant $ATK_ASP :|ASP |)
(defconstant $ATK_PAP :|PAP |)
(defconstant $ATK_NBP :|NBP |)
(defconstant $ATK_ZIP :|ZIP |)
;  Module Names
(defconstant $kDDPName "ddp")
; #define kDDPName       "ddp"
(defconstant $kATPName "atp")
; #define   kATPName        "atp"
(defconstant $kADSPName "adsp")
; #define kADSPName     "adsp"
(defconstant $kASPName "asp")
; #define  kASPName        "asp"
(defconstant $kPAPName "pap")
; #define kPAPName      "pap"
(defconstant $kNBPName "nbp")
; #define kNBPName      "nbp"
(defconstant $kZIPName "zip")
; #define kZIPName      "zip"
(defconstant $kLTalkName "ltlk")
; #define kLTalkName        "ltlk"
(defconstant $kLTalkAName "ltlkA")
; #define kLTalkAName      "ltlkA"
(defconstant $kLTalkBName "ltlkB")
; #define kLTalkBName     "ltlkB"
; 
;    Protocol-specific Options
;    NOTE:
;    All Protocols support OPT_CHECKSUM (Value is (unsigned long)T_YES/T_NO)
;    ATP supports OPT_RETRYCNT (# Retries, 0 = try once) and
;                 OPT_INTERVAL (# Milliseconds to wait)
; 

(defconstant $DDP_OPT_HOPCOUNT #x2100)          ;  DDP UnitDataReq Only - set hop count, Value is (unsigned long)  hop count   


(defconstant $DDP_OPT_CHECKSUM #x600)
(defconstant $DDP_OPT_SRCADDR #x2101)           ;  DDP UnitDataReq Only - set src address, Value is DDPAddress 

(defconstant $ATP_OPT_REPLYCNT #x2110)          ;  AppleTalk - ATP Resp Pkt Ct Type, Value is (unsigned long)  pkt count 

(defconstant $ATP_OPT_DATALEN #x2111)           ;  AppleTalk - ATP Pkt Data Len Type, Value is (unsigned long) length 

(defconstant $ATP_OPT_RELTIMER #x2112)          ;  AppleTalk - ATP Release Timer Type, Value is (unsigned long) timer, (See Inside AppleTalk, second edition 

(defconstant $ATP_OPT_TRANID #x2113)            ;  Value is (unsigned long) Boolean, Used to request Transaction ID, Returned with Transaction ID on requests 

(defconstant $PAP_OPT_OPENRETRY #x2120)         ;  AppleTalk - PAP OpenConn Retry count, Value is (unsigned long) T_YES/T_NO 

;  Protocol-Specific Events
; 
;    If you send the IOCTL: OTIoctl(I_OTGetMiscellaneousEvents, 1),
;    you will receive the T_ATALKxxx events on your endpoint.
;    NOTE: The endpoint does not need to be bound.
; 

(defconstant $kAppleTalkEvent #x23010000)
(defconstant $T_GETMYZONECOMPLETE #x23010001)
(defconstant $T_GETLOCALZONESCOMPLETE #x23010002)
(defconstant $T_GETZONELISTCOMPLETE #x23010003)
(defconstant $T_GETATALKINFOCOMPLETE #x23010004)
(defconstant $T_ATALKROUTERDOWNEVENT #x23010033);  No routers have been seen for a while.  If the cookie is NULL, all routers are gone.  Otherwise, there is still an ARA router hanging around being used, and only the local cable has been  timed out.

(defconstant $T_ATALKROUTERUPEVENT #x23010034)  ;  We didn't have a router, but now one has come up. Cookie is NULL for a normal router coming up, non-NULL for an ARA router coming on-line

(defconstant $T_ATALKZONENAMECHANGEDEVENT #x23010035);  A Zone name change was issued from the router, so our AppleTalk Zone has changed.

(defconstant $T_ATALKCONNECTIVITYCHANGEDEVENT #x23010036);  An ARA connection was established (cookie != NULL), or was disconnected (cookie == NULL)

(defconstant $T_ATALKINTERNETAVAILABLEEVENT #x23010037);  A router has appeared, and our address is in the startup range.  Cookie is hi/lo of new cable range.
;  A router has appeared, and it's incompatible with our current address.  Cookie is hi/lo of new cable range.

(defconstant $T_ATALKCABLERANGECHANGEDEVENT #x23010038)

(defconstant $T_ATALKBADROUTEREVENT #x23010046) ;  A bad router has appeared/disappeared on our network.

(defconstant $T_ALLNODESTAKENEVENT #x23010047)
(defconstant $T_FIXEDNODETAKENEVENT #x23010048)
(defconstant $T_MPPCOMPATCFIGEVENT #x23010049)
(defconstant $T_FIXEDNODEBADEVENT #x2301004A)

(defconstant $kAllATalkRoutersDown 0)           ;  This indicates that all routers are offline

(defconstant $kLocalATalkRoutersDown -1)        ;  This indicates that all local routers went offline, but an ARA router is still active
;  This indicates that ARA was disconnected, do it's router went offline, and we have no local routers to fall back onto.

(defconstant $kARARouterDisconnected -2)

(defconstant $kARARouterOnline -1)              ;  We had no local routers, but an ARA router is now online.

(defconstant $kATalkRouterOnline 0)             ;  We had no routers, but a local router is now online
;  We have an ARA router, but now we've seen a local router as well

(defconstant $kLocalATalkRouterOnline -2)
; #define IsAppleTalkEvent(x)         ((x) & 0xffff0000) == kAppleTalkEvent)
;  Protocol-specific IOCTLs

(defconstant $ATALK_IOC_FULLSELFSEND #x542F)    ;  Turn on/off full self-send (it's automatic for non-backward-compatible links)
;  ADSP Forward Reset

(defconstant $ADSP_IOC_FORWARDRESET #x543C)
;  Protocol-specific constants
;  ECHO

(defconstant $kECHO_TSDU #x249)                 ;  Max. # of data bytes.

;  NBP

(defconstant $kNBPMaxNameLength 32)
(defconstant $kNBPMaxTypeLength 32)
(defconstant $kNBPMaxZoneLength 32)
(defconstant $kNBPSlushLength 9)                ;  Extra space for @, : and a few escape chars

(defconstant $kNBPMaxEntityLength 99)
(defconstant $kNBPEntityBufferSize 105)
(defconstant $kNBPWildCard 61)                  ;  NBP name and type match anything '='

(defconstant $kNBPImbeddedWildCard #xC5)        ;  NBP name and type match some 'Å'

(defconstant $kNBPDefaultZone 42)               ;  NBP default zone '*'

;  ZIP

(defconstant $kZIPMaxZoneLength 32)

(defconstant $kDDPAddressLength 8)              ;  value to use in netbuf.len field, Maximum length of AppleTalk address

(defconstant $kNBPAddressLength 105)
(defconstant $kAppleTalkAddressLength 113)
; #define OTCopyDDPAddress(addr, dest)                 {                                                     ((UInt32*)(dest))[0] = ((UInt32*)(addr))[0];          ((UInt32*)(dest))[1] = ((UInt32*)(addr))[1];      }
; ******************************************************************************
; ** CLASS TAppleTalkServices
; *******************************************************************************

; #if !OTKERNEL
; 
;    Define the ATSvcRef type.  This type needs special
;    processing because in C++ it's a subclass of TProvider.
;    See the definition of TEndpointRef in "OpenTransport.h"
;    for the logic behind this definition.
; 
; #ifdef __cplusplus
#| #|
    typedef class TAppleTalkServices*   ATSvcRef;
|#
 |#

; #else

(def-mactype :ATSvcRef (find-mactype '(:pointer :void)))

; #endif

; #define kDefaultAppleTalkServicesPath       ((OTConfigurationRef)-3L)
; 
;    Under Carbon, OpenAppleTalkServices routines take a client context pointer.  Applications may pass NULL
;    after calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
;    valid client context.
; 
; 
;  *  OTAsyncOpenAppleTalkServicesInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTAsyncOpenAppleTalkServicesInContext" 
   ((cfig (:pointer :OTConfiguration))
    (flags :UInt32)
    (proc (:pointer :OpaqueOTNotifyProcPtr))
    (contextPtr :pointer)
    (clientContext (:pointer :OpaqueOTClientContextPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTOpenAppleTalkServicesInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTOpenAppleTalkServicesInContext" 
   ((cfig (:pointer :OTConfiguration))
    (flags :UInt32)
    (err (:pointer :OSStatus))
    (clientContext (:pointer :OpaqueOTClientContextPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :void)
() )
; 
;  *  OTAsyncOpenAppleTalkServices()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTOpenAppleTalkServices()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #if OTCARBONAPPLICATION
#|                                              ;  The following macro may be used by applications only.
; #define OTOpenAppleTalkServices(cfig, oflags, err) OTOpenAppleTalkServicesInContext(cfig, oflags, err, NULL)
; #define OTAsyncOpenAppleTalkServices(cfig, oflags, proc, contextPtr) OTAsyncOpenAppleTalkServicesInContext(cfig, oflags, proc, contextPtr, NULL)
 |#

; #endif  /* OTCARBONAPPLICATION */

;  Get the zone associated with the ATSvcRef
; 
;  *  OTATalkGetMyZone()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTATalkGetMyZone" 
   ((ref (:pointer :void))
    (zone (:pointer :TNetbuf))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    Get the list of available zones associated with the local cable
;    of the ATSvcRef
; 
; 
;  *  OTATalkGetLocalZones()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTATalkGetLocalZones" 
   ((ref (:pointer :void))
    (zones (:pointer :TNetbuf))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Get the list of all zones on the internet specified by the ATSvcRef
; 
;  *  OTATalkGetZoneList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTATalkGetZoneList" 
   ((ref (:pointer :void))
    (zones (:pointer :TNetbuf))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Stores an AppleTalkInfo structure into the TNetbuf (see later in this file)
; 
;  *  OTATalkGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTATalkGetInfo" 
   ((ref (:pointer :void))
    (info (:pointer :TNetbuf))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}                   
class TAppleTalkServices : public TProvider
{
    public:
            OSStatus    GetMyZone(TNetbuf* zone)        { return OTATalkGetMyZone(this, zone); }
            OSStatus    GetLocalZones(TNetbuf* zones)   { return OTATalkGetLocalZones(this, zones); }
            OSStatus    GetZoneList(TNetbuf* zones)     { return OTATalkGetZoneList(this, zones); }
            OSStatus    GetInfo(TNetbuf* info)          { return OTATalkGetInfo(this, info); }
};

extern "C" {        
#endif
|#
 |#
;  _cplus 

; #endif  /* !OTKERNEL */

;  AppleTalk Addressing
; 
;    The NBPEntity structure is used to manipulate NBP names without regard
;    to issues of what kind of "special" characters are in the name.
;    
;    When stored as an address in an NBPAddress or DDPNBPAddress, they are 
;    stored as a character string, which is currently just ASCII, but in the
;    future may be UniChar, or some other internationalizable scripting set.
;    The string following an NBPAddress or DDPNBPAddress is intended to be
;    suitable for showing to users, whereas NBPEntity is not.
;    WARNING: NBPAddress and DDPNBPAddress structures do not "know" the length
;    of the address.  That must have been obtained as part of a Lookup or
;    ResolveAddress call.
; 

(defconstant $AF_ATALK_FAMILY #x100)
(defconstant $AF_ATALK_DDP #x100)
(defconstant $AF_ATALK_DDPNBP #x101)
(defconstant $AF_ATALK_NBP #x102)
(defconstant $AF_ATALK_MNODE #x103)
(defrecord NBPEntity
   (fEntity (:array :UInt8 99))
)

;type name? (%define-record :NBPEntity (find-record-descriptor ':NBPEntity))
(defrecord DDPAddress
   (fAddressType :UInt16)                       ;  One of the enums above
   (fNetwork :UInt16)
   (fNodeID :UInt8)
   (fSocket :UInt8)
   (fDDPType :UInt8)
   (fPad :UInt8)
; #ifdef __cplusplus
#| #|
    
  void            Init(const DDPAddress&);
   void            Init(UInt16 net, UInt8 node, UInt8 socket);
    void            Init(UInt16 net, UInt8 node, UInt8 socket, UInt8 type);

   void            SetSocket(UInt8);
  void            SetType(UInt8);
    void            SetNode(UInt8);
    void            SetNetwork(UInt16);

   OTByteCount     GetAddressLength() const;
  OTAddressType   GetAddressType() const;
    UInt8           GetSocket() const;
 UInt8           GetType() const;
   UInt8           GetNode() const;
   UInt16          GetNetwork() const;

   Boolean         operator==(const DDPAddress&) const;
   Boolean         operator!=(const DDPAddress&) const;
   void            operator=(const DDPAddress&);
#endif
|#
 |#
)

;type name? (%define-record :DDPAddress (find-record-descriptor ':DDPAddress))
(defrecord NBPAddress
   (fAddressType :UInt16)                       ;  One of the enums above
   (fNBPNameBuffer (:array :UInt8 105))
; #ifdef __cplusplus
#| #|
    
  OTByteCount     Init();
    OTByteCount     Init(const NBPEntity&);
    OTByteCount     Init(const char*);
 OTByteCount     Init(const char*, OTByteCount len);
    Boolean         ExtractEntity(NBPEntity&, OTByteCount len);

   OTAddressType   GetAddressType() const;
#endif
|#
 |#
)

;type name? (%define-record :NBPAddress (find-record-descriptor ':NBPAddress))
(defrecord DDPNBPAddress
   (fAddressType :UInt16)                       ;  One of the enums above
   (fNetwork :UInt16)
   (fNodeID :UInt8)
   (fSocket :UInt8)
   (fDDPType :UInt8)
   (fPad :UInt8)
   (fNBPNameBuffer (:array :UInt8 105))
; #ifdef __cplusplus
#| #|
    
  void            Init(const DDPAddress&);
   void            Init(UInt16 net, UInt8 node, UInt8 socket);
    void            Init(UInt16 net, UInt8 node, UInt8 socket, UInt8 type);

   void            SetSocket(UInt8);
  void            SetType(UInt8);
    void            SetNode(UInt8);
    void            SetNetwork(UInt16);
    
   OTAddressType   GetAddressType() const;
    UInt8           GetSocket() const;
 UInt8           GetType() const;
   UInt8           GetNode() const;
   UInt16          GetNetwork() const;
    
   Boolean         ExtractEntity(NBPEntity&, OTByteCount len);
    OTByteCount     SetNBPEntity(const NBPEntity&);
    OTByteCount     SetNBPEntity(const char*);
 OTByteCount     SetNBPEntity(const char*, OTByteCount len);
    
   Boolean         operator==(const DDPAddress&) const;
#endif
|#
 |#
)

;type name? (%define-record :DDPNBPAddress (find-record-descriptor ':DDPNBPAddress))
;  These are some utility routines for dealing with NBP and DDP addresses. 
;  Functions to initialize the various AppleTalk Address types
; 
;  *  OTInitDDPAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInitDDPAddress" 
   ((addr (:pointer :DDPAddress))
    (net :UInt16)
    (node :UInt8)
    (socket :UInt8)
    (ddpType :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTInitNBPAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInitNBPAddress" 
   ((addr (:pointer :NBPAddress))
    (name (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  OTInitDDPNBPAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInitDDPNBPAddress" 
   ((addr (:pointer :DDPNBPAddress))
    (name (:pointer :char))
    (net :UInt16)
    (node :UInt8)
    (socket :UInt8)
    (ddpType :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  Compare 2 DDP addresses for equality
; 
;  *  OTCompareDDPAddresses()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTCompareDDPAddresses" 
   ((addr1 (:pointer :DDPAddress))
    (addr2 (:pointer :DDPAddress))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  Init an NBPEntity to a NULL name
; 
;  *  OTInitNBPEntity()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTInitNBPEntity" 
   ((entity (:pointer :NBPEntity))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  Get the length an NBPEntity would have when stored as an address
; 
;  *  OTGetNBPEntityLengthAsAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTGetNBPEntityLengthAsAddress" 
   ((entity (:pointer :NBPEntity))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  Store an NBPEntity into an address buffer
; 
;  *  OTSetAddressFromNBPEntity()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTSetAddressFromNBPEntity" 
   ((nameBuf (:pointer :UInt8))
    (entity (:pointer :NBPEntity))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  Create an address buffer from a string (use -1 for len to use strlen)
; 
;  *  OTSetAddressFromNBPString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTSetAddressFromNBPString" 
   ((addrBuf (:pointer :UInt8))
    (name (:pointer :char))
    (len :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;    Create an NBPEntity from an address buffer. False is returned if
;      the address was truncated.
; 
; 
;  *  OTSetNBPEntityFromAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTSetNBPEntityFromAddress" 
   ((entity (:pointer :NBPEntity))
    (addrBuf (:pointer :UInt8))
    (len :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  Routines to set a piece of an NBP entity from a character string
; 
;  *  OTSetNBPName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTSetNBPName" 
   ((entity (:pointer :NBPEntity))
    (name (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OTSetNBPType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTSetNBPType" 
   ((entity (:pointer :NBPEntity))
    (typeVal (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OTSetNBPZone()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTSetNBPZone" 
   ((entity (:pointer :NBPEntity))
    (zone (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  Routines to extract pieces of an NBP entity
; 
;  *  OTExtractNBPName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTExtractNBPName" 
   ((entity (:pointer :NBPEntity))
    (name (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTExtractNBPType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTExtractNBPType" 
   ((entity (:pointer :NBPEntity))
    (typeVal (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTExtractNBPZone()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTExtractNBPZone" 
   ((entity (:pointer :NBPEntity))
    (zone (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; #ifdef __cplusplus
#| #|


inline void DDPAddress::operator=(const DDPAddress& addr)
{
    *(UInt32*)&fAddressType = *(UInt32*)&addr.fAddressType;
    *(UInt32*)&fNodeID = *(UInt32*)&addr.fNodeID;
}

inline Boolean DDPAddress::operator==(const DDPAddress& addr) const
{
    return OTCompareDDPAddresses(&addr, this);
}

inline Boolean DDPAddress::operator!=(const DDPAddress& addr) const
{
    return !OTCompareDDPAddresses(&addr, this);
}

inline void DDPAddress::SetSocket(UInt8 socket)
{
    fSocket = socket;
}

inline void DDPAddress::SetNode(UInt8 node)
{
    fNodeID = node;
}

inline void DDPAddress::SetType(UInt8 type)
{
    fDDPType = type;
}

inline void DDPAddress::SetNetwork(UInt16 net)
{
    fNetwork = net;
}

inline OTByteCount DDPAddress::GetAddressLength() const
{
    return kDDPAddressLength;
}

inline OTAddressType DDPAddress::GetAddressType() const
{
    return fAddressType;
}

inline UInt8 DDPAddress::GetSocket() const
{
    return fSocket;
}

inline UInt8 DDPAddress::GetNode() const
{
    return fNodeID;
}

inline UInt8 DDPAddress::GetType() const
{
    return fDDPType;
}

inline UInt16 DDPAddress::GetNetwork() const
{
    return fNetwork;
}

inline void  DDPAddress::Init(UInt16 net, UInt8 node,
                              UInt8 socket)
{
    fAddressType = AF_ATALK_DDP;
    SetNetwork(net);
    SetNode(node);
    SetSocket(socket);
    SetType(0);
}

inline void  DDPAddress::Init(UInt16 net, UInt8 node,
                              UInt8 socket, UInt8 type)
{
    fAddressType = AF_ATALK_DDP;
    SetNetwork(net);
    SetNode(node);
    SetSocket(socket);
    SetType(type);
}

inline void DDPAddress::Init(const DDPAddress& addr)
{
    *(UInt32*)&fAddressType = *(UInt32*)&addr.fAddressType;
    *(UInt32*)&fNodeID = *(UInt32*)&addr.fNodeID;
}


inline OTByteCount NBPAddress::Init()
{
    fAddressType = AF_ATALK_NBP;
    return sizeof(OTAddressType);
}

inline OTByteCount NBPAddress::Init(const NBPEntity& addr)
{
    fAddressType = AF_ATALK_NBP;
    return sizeof(OTAddressType) + OTSetAddressFromNBPEntity(fNBPNameBuffer, &addr);
}

inline OTByteCount NBPAddress::Init(const char* name)
{
    fAddressType = AF_ATALK_NBP;
    return sizeof(OTAddressType) + OTSetAddressFromNBPString(fNBPNameBuffer, name, -1);
}

inline OTByteCount NBPAddress::Init(const char* name, OTByteCount len)
{
    fAddressType = AF_ATALK_NBP;
    return sizeof(OTAddressType) + OTSetAddressFromNBPString(fNBPNameBuffer, name, (SInt32)len);
}

inline Boolean NBPAddress::ExtractEntity(NBPEntity& entity, OTByteCount len)
{
    return OTSetNBPEntityFromAddress(&entity, fNBPNameBuffer, len);
}
    
inline OTAddressType NBPAddress::GetAddressType() const
{
    return fAddressType;
}
    

inline Boolean DDPNBPAddress::operator==(const DDPAddress& addr) const
{
    return OTCompareDDPAddresses((const DDPAddress*)this, &addr);
}

inline void DDPNBPAddress::SetSocket(UInt8 socket)
{
    fSocket = socket;
}

inline void DDPNBPAddress::SetNode(UInt8 node)
{
    fNodeID = node;
}

inline void DDPNBPAddress::SetType(UInt8 type)
{
    fDDPType = type;
}

inline void DDPNBPAddress::SetNetwork(UInt16 net)
{
    fNetwork = net;
}

inline OTAddressType DDPNBPAddress::GetAddressType() const
{
    return fAddressType;
}

inline UInt8 DDPNBPAddress::GetSocket() const
{
    return fSocket;
}

inline UInt8 DDPNBPAddress::GetNode() const
{
    return fNodeID;
}

inline UInt8 DDPNBPAddress::GetType() const
{
    return fDDPType;
}

inline UInt16 DDPNBPAddress::GetNetwork() const
{
    return fNetwork;
}

inline void DDPNBPAddress::Init(UInt16 net, UInt8 node,
                                UInt8 socket)
{
    fAddressType = AF_ATALK_DDPNBP;
    SetNetwork(net);
    SetNode(node);
    SetSocket(socket);
    SetType(0);
}

inline void DDPNBPAddress::Init(UInt16 net, UInt8 node,
                                UInt8 socket, UInt8 type)
{
    fAddressType = AF_ATALK_DDPNBP;
    SetNetwork(net);
    SetNode(node);
    SetSocket(socket);
    SetType(type);
}

inline void DDPNBPAddress::Init(const DDPAddress& addr)
{
    fAddressType = AF_ATALK_DDPNBP;
    SetNetwork(addr.GetNetwork());
    SetNode(addr.GetNode());
    SetSocket(addr.GetSocket());
    SetType(addr.GetType());
    fNBPNameBuffer[0] = 0;
}

inline OTByteCount DDPNBPAddress::SetNBPEntity(const NBPEntity& entity)
{
    return OTSetAddressFromNBPEntity(fNBPNameBuffer, &entity) + kDDPAddressLength;
}

inline OTByteCount DDPNBPAddress::SetNBPEntity(const char* name)
{
    return OTSetAddressFromNBPString(fNBPNameBuffer, name, -1) + kDDPAddressLength;
}

inline OTByteCount DDPNBPAddress::SetNBPEntity(const char* name, OTByteCount len)
{
    return OTSetAddressFromNBPString(fNBPNameBuffer, name, (SInt32)len) + kDDPAddressLength;
}

inline Boolean DDPNBPAddress::ExtractEntity(NBPEntity& entity, OTByteCount len)
{
    return OTSetNBPEntityFromAddress(&entity, fNBPNameBuffer, len);
}

#endif
|#
 |#
;  __cplusplus 
;  AppleTalkInfo as used by the OTGetATalkInfo function
(defrecord AppleTalkInfo
   (fOurAddress :DDPAddress)                    ;  Our DDP address (network # & node)
   (fRouterAddress :DDPAddress)                 ;  The address of a router on our cable
   (fCableRange (:array :UInt16 2))             ;  The current cable range
   (fFlags :UInt16)                             ;  See below
)

;type name? (%define-record :AppleTalkInfo (find-record-descriptor ':AppleTalkInfo))
;  For the fFlags field in AppleTalkInfo

(defconstant $kATalkInfoIsExtended 1)           ;  This is an extended (phase 2) network

(defconstant $kATalkInfoHasRouter 2)            ;  This cable has a router

(defconstant $kATalkInfoOneZone 4)              ;  This cable has only one zone

;  ***** Ethernet *****
;  Interface option flags
;  Ethernet framing options

(defconstant $kOTFramingEthernet 1)
(defconstant $kOTFramingEthernetIPX 2)
(defconstant $kOTFraming8023 4)
(defconstant $kOTFraming8022 8)
; 
;    These are obsolete and will be going away in OT 1.5.
;    Hmmm, OT 1.5 got cancelled.  The status of these options
;    is uncertain.
; 
;  RawMode options

(defconstant $kOTRawRcvOn 0)
(defconstant $kOTRawRcvOff 1)
(defconstant $kOTRawRcvOnWithTimeStamp 2)

(defconstant $DL_PROMISC_OFF 0)                 ;  OPT_SETPROMISCUOUS value

;  Module definitions
;  Module IDs

(defconstant $kT8022ModuleID #x1BBC)
(defconstant $kEnetModuleID #x1BBD)
(defconstant $kTokenRingModuleID #x1BBE)
(defconstant $kFDDIModuleID #x1BBF)
;  Module Names
(defconstant $kEnet8022Name "enet8022x")
; #define kEnet8022Name      "enet8022x"
(defconstant $kEnetName "enet")
; #define kEnetName           "enet"
(defconstant $kFastEnetName "fenet")
; #define kFastEnetName        "fenet"
(defconstant $kTokenRingName "tokn")
; #define kTokenRingName      "tokn"
(defconstant $kFDDIName "fddi")
; #define kFDDIName            "fddi"
(defconstant $kIRTalkName "irtlk")
; #define kIRTalkName          "irtlk"
(defconstant $kSMDSName "smds")
; #define kSMDSName           "smds"
(defconstant $kATMName "atm")
; #define kATMName         "atm"
(defconstant $kT8022Name "tpi8022x")
; #define kT8022Name            "tpi8022x"
(defconstant $kATMSNAPName "atmsnap")
; #define kATMSNAPName     "atmsnap"
(defconstant $kFireWireName "firewire")
; #define kFireWireName     "firewire"
(defconstant $kFibreChannelName "fibre")
; #define kFibreChannelName    "fibre"
;  Address Family

(defconstant $AF_8022 #x2008)                   ;  Our 802.2 generic address family

;  XTI Levels

(defconstant $LNK_ENET :|ENET|)
(defconstant $LNK_TOKN :|TOKN|)
(defconstant $LNK_FDDI :|FDDI|)
(defconstant $LNK_TPI :|LTPI|)
;  Options

(defconstant $OPT_ADDMCAST #x1000)
(defconstant $OPT_DELMCAST #x1001)
(defconstant $OPT_RCVPACKETTYPE #x1002)
(defconstant $OPT_RCVDESTADDR #x1003)
(defconstant $OPT_SETRAWMODE #x1004)
(defconstant $OPT_SETPROMISCUOUS #x1005)

(def-mactype :OTPacketType (find-mactype ':UInt32))

(defconstant $kETypeStandard 0)
(defconstant $kETypeMulticast 1)
(defconstant $kETypeBroadcast 2)
(defconstant $kETRawPacketBit #x80000000)
(defconstant $kETTimeStampBit #x40000000)
;  Link related constants

(defconstant $kMulticastLength 6)               ;  length of an ENET hardware addressaddress

(defconstant $k48BitAddrLength 6)
(defconstant $k8022DLSAPLength 2)               ;  The protocol type is our DLSAP

(defconstant $k8022SNAPLength 5)
(defconstant $kEnetAddressLength 8)             ;  length of an address field used by the ENET enpoint
;     = k48BitAddrLength + sizeof(protocol type)

(defconstant $kSNAPSAP #xAA)                    ;  Special DLSAPS for ENET

(defconstant $kIPXSAP #xFF)
(defconstant $kMax8022SAP #xFE)
(defconstant $k8022GlobalSAP #xFF)
(defconstant $kMinDIXSAP #x5DD)
(defconstant $kMaxDIXSAP #xFFFF)
;  Generic Address Structure
(defrecord T8022Address
   (fAddrFamily :UInt16)
   (fHWAddr (:array :UInt8 6))
   (fSAP :UInt16)
   (fSNAP (:array :UInt8 5))
)

;type name? (%define-record :T8022Address (find-record-descriptor ':T8022Address))

(defconstant $k8022BasicAddressLength 10)
(defconstant $k8022SNAPAddressLength 15)
;  Some helpful stuff for dealing with 48 bit addresses
; #define OTCompare48BitAddresses(p1, p2)                                                          (*(const UInt32*)((const UInt8*)(p1)) == *(const UInt32*)((const UInt8*)(p2)) &&           *(const UInt16*)(((const UInt8*)(p1))+4) == *(const UInt16*)(((const UInt8*)(p2))+4) )
; #define OTCopy48BitAddress(p1, p2)                                               (*(UInt32*)((UInt8*)(p2)) = *(const UInt32*)((const UInt8*)(p1)),              *(UInt16*)(((UInt8*)(p2))+4) = *(const UInt16*)(((const UInt8*)(p1))+4) )
; #define OTClear48BitAddress(p1)                                                   (*(UInt32*)((UInt8*)(p1)) = 0,                                                 *(UInt16*)(((UInt8*)(p1))+4) = 0 )
; #define OTCompare8022SNAP(p1, p2)                                                        (*(const UInt32*)((const UInt8*)(p1)) == *(const UInt32*)((const UInt8*)(p2)) &&       *(((const UInt8*)(p1))+4) == *(((const UInt8*)(p2))+4) )
; #define OTCopy8022SNAP(p1, p2)                                                 (*(UInt32*)((UInt8*)(p2)) = *(const UInt32*)((const UInt8*)(p1)),          *(((UInt8*)(p2))+4) = *(((const UInt8*)(p1))+4) )
; #define OTIs48BitBroadcastAddress(p1)                     (*(UInt32*)((UInt8*)(p1)) == 0xffffffff &&             *(UInt16*)(((UInt8*)(p1))+4) == 0xffff )
; #define OTSet48BitBroadcastAddress(p1)                     (*(UInt32*)((UInt8*)(p1)) = 0xffffffff,                *(UInt16*)(((UInt8*)(p1))+4) = 0xffff )
; #define OTIs48BitZeroAddress(p1)                (*(UInt32*)((UInt8*)(p1)) == 0 &&              *(UInt16*)(((UInt8*)(p1))+4) == 0 )
;  Link related constants

(defconstant $kEnetPacketHeaderLength 14)
(defconstant $kEnetTSDU #x5EA)                  ;  The TSDU for ethernet.

(defconstant $kTokenRingTSDU #x116A)            ;  The TSDU for TokenRing.

(defconstant $kFDDITSDU #x116A)                 ;  The TSDU for FDDI. 

(defconstant $k8022SAPLength 1)
(defconstant $k8022BasicHeaderLength 3)         ;  define the length of the header portion of an 802.2 packet.
;  = SSAP+DSAP+ControlByte

(defconstant $k8022SNAPHeaderLength 8)
; ******************************************************************************
; ** Address Types recognized by the Enet DLPI
; *******************************************************************************

(def-mactype :EAddrType (find-mactype ':UInt32))

(defconstant $keaStandardAddress 0)
(defconstant $keaMulticast 1)
(defconstant $keaBroadcast 2)
(defconstant $keaBadAddress 3)
(defconstant $keaRawPacketBit #x80000000)
(defconstant $keaTimeStampBit #x40000000)
;  Packet Header Structures
(defrecord EnetPacketHeader
   (fDestAddr (:array :UInt8 6))
   (fSourceAddr (:array :UInt8 6))
   (fProto :UInt16)
)

;type name? (%define-record :EnetPacketHeader (find-record-descriptor ':EnetPacketHeader))
(defrecord T8022Header
   (fDSAP :UInt8)
   (fSSAP :UInt8)
   (fCtrl :UInt8)
)

;type name? (%define-record :T8022Header (find-record-descriptor ':T8022Header))
(defrecord T8022SNAPHeader
   (fDSAP :UInt8)
   (fSSAP :UInt8)
   (fCtrl :UInt8)
   (fSNAP (:array :UInt8 5))
)

;type name? (%define-record :T8022SNAPHeader (find-record-descriptor ':T8022SNAPHeader))
(defrecord T8022FullPacketHeader
   (fEnetPart :EnetPacketHeader)
   (f8022Part :T8022SNAPHeader)
)

;type name? (%define-record :T8022FullPacketHeader (find-record-descriptor ':T8022FullPacketHeader))
;  Define the lengths of the structures above

(defconstant $kT8022HeaderLength 3)
(defconstant $kT8022SNAPHeaderLength 8)
(defconstant $kT8022FullPacketHeaderLength 22)
;  ***** Serial *****
;  Module Definitions
;  XTI Level

(defconstant $COM_SERIAL :|SERL|)
;  Version Number
(defconstant $kSerialABVersion "1.1.1")
; #define kSerialABVersion   "1.1.1"
;  Module Names
(defconstant $kSerialABName "serialAB")
; #define kSerialABName      "serialAB"
(defconstant $kSerialName "serial")
; #define kSerialName          "serial"
(defconstant $kSerialPortAName "serialA")
; #define kSerialPortAName   "serialA"
(defconstant $kSerialPortBName "serialB")
; #define kSerialPortBName  "serialB"

(defconstant $kSerialABModuleID #x1C20)

(defconstant $kOTSerialFramingAsync 1)          ;  Support Async serial mode         

(defconstant $kOTSerialFramingHDLC 2)           ;  Support HDLC synchronous serial mode   

(defconstant $kOTSerialFramingSDLC 4)           ;  Support SDLC synchronous serial mode   

(defconstant $kOTSerialFramingAsyncPackets 8)   ;  Support Async "packet" serial mode 

(defconstant $kOTSerialFramingPPP 16)           ;  Port does its own PPP framing - wants unframed packets from PPP 

;  IOCTL Calls for Serial Drivers

(defconstant $I_SetSerialDTR #x5500)            ;  Set DTR (0 = off, 1 = on)

(defconstant $kOTSerialSetDTROff 0)
(defconstant $kOTSerialSetDTROn 1)
(defconstant $I_SetSerialBreak #x5501)          ;  Send a break on the line - kOTSerialSetBreakOff = off, kOTSerialSetBreakOn = on,
;  Any other number is the number of milliseconds to leave break on, then
;  auto shutoff

(defconstant $kOTSerialSetBreakOn #xFFFFFFFF)
(defconstant $kOTSerialSetBreakOff 0)
(defconstant $I_SetSerialXOffState #x5502)      ;  Force XOFF state - 0 = Unconditionally clear XOFF state, 1 = unconditionally set it

(defconstant $kOTSerialForceXOffTrue 1)
(defconstant $kOTSerialForceXOffFalse 0)
(defconstant $I_SetSerialXOn #x5503)            ;  Send an XON character, 0 = send only if in XOFF state, 1 = send always

(defconstant $kOTSerialSendXOnAlways 1)
(defconstant $kOTSerialSendXOnIfXOffTrue 0)
(defconstant $I_SetSerialXOff #x5504)           ;  Send an XOFF character, 0 = send only if in XON state, 1 = send always

(defconstant $kOTSerialSendXOffAlways 1)
(defconstant $kOTSerialSendXOffIfXOnTrue 0)
;  Option Management for Serial Drivers
; 
;    These options are all 4-byte values.
;    BaudRate is the baud rate.
;    DataBits is the number of data bits.
;    StopBits is the number of stop bits times 10.
;    Parity is an enum
; 

(defconstant $SERIAL_OPT_BAUDRATE #x100)        ;  UInt32 

(defconstant $SERIAL_OPT_DATABITS #x101)        ;  UInt32 

(defconstant $SERIAL_OPT_STOPBITS #x102)        ;  UInt32 10, 15 or 20 for 1, 1.5 or 2    

(defconstant $SERIAL_OPT_PARITY #x103)          ;  UInt32 

(defconstant $SERIAL_OPT_STATUS #x104)          ;  UInt32 
;  The "Status" option is a 4-byte value option that is ReadOnly
;  It returns a bitmap of the current serial status

(defconstant $SERIAL_OPT_HANDSHAKE #x105)       ;  UInt32 
;  The "Handshake" option defines what kind of handshaking the serial port
;  will do for line flow control.  The value is a 32-bit value defined by
;  the function or macro SerialHandshakeData below.
;  For no handshake, or CTS handshake, the onChar and offChar parameters
;  are ignored.

(defconstant $SERIAL_OPT_RCVTIMEOUT #x106)      ;  The "RcvTimeout" option defines how long the receiver should wait before delivering
;  less than the RcvLoWat number of characters.  If RcvLoWat is 0, then the RcvTimeout
;  is how long a gap to wait for before delivering characters.  This parameter is advisory,
;  and serial drivers are free to deliver data whenever they deem it convenient.  For instance,
;  many serial drivers will deliver data whenever 64 bytes have been received, since 64 bytes
;  is the smallest STREAMS buffer size. Keep in mind that timeouts are quantized, so be sure to
;  look at the return value of the option to determine what it was negotiated to.

(defconstant $SERIAL_OPT_ERRORCHARACTER #x107)  ;  This option defines how characters with parity errors are handled.
;  A 0 value will disable all replacement.  A single character value in the low
;  byte designates the replacement character.  When characters are received with a 
;  parity error, they are replaced by this specified character.  If a valid incoming
;  character matches the replacement character, then the received character's msb is
;  cleared. For this situation, the alternate character is used, if specified in bits
;  8 through 15 of the option long, with 0xff being place in bits 16 through 23.
;  Whenever a valid character is received that matches the first replacement character,
;  it is replaced with this alternate character.

(defconstant $SERIAL_OPT_EXTCLOCK #x108)        ;  The "ExtClock" requests an external clock.  A 0-value turns off external clocking.
;  Any other value is a requested divisor for the external clock.  Be aware that
;  not all serial implementations support an external clock, and that not all
;  requested divisors will be supported if it does support an external clock.

(defconstant $SERIAL_OPT_BURSTMODE #x109)       ;  The "BurstMode" option informs the serial driver that it should continue looping,
;  reading incoming characters, rather than waiting for an interrupt for each character.
;  This option may not be supported by all Serial driver

(defconstant $SERIAL_OPT_DUMMY #x10A)           ;  placeholder


(def-mactype :ParityOptionValues (find-mactype ':UInt32))

(defconstant $kOTSerialNoParity 0)
(defconstant $kOTSerialOddParity 1)
(defconstant $kOTSerialEvenParity 2)

(defconstant $kOTSerialSwOverRunErr 1)
(defconstant $kOTSerialBreakOn 8)
(defconstant $kOTSerialParityErr 16)
(defconstant $kOTSerialOverrunErr 32)
(defconstant $kOTSerialFramingErr 64)
(defconstant $kOTSerialXOffSent #x10000)
(defconstant $kOTSerialDTRNegated #x20000)
(defconstant $kOTSerialCTLHold #x40000)
(defconstant $kOTSerialXOffHold #x80000)
(defconstant $kOTSerialOutputBreakOn #x1000000)

(defconstant $kOTSerialXOnOffInputHandshake 1)  ;  Want XOn/XOff handshake for incoming characters    

(defconstant $kOTSerialXOnOffOutputHandshake 2) ;  Want XOn/XOff handshake for outgoing characters    

(defconstant $kOTSerialCTSInputHandshake 4)     ;  Want CTS handshake for incoming characters     

(defconstant $kOTSerialDTROutputHandshake 8)    ;  Want DTR handshake for outoing characters   

; #ifdef __cplusplus
#| #|

   inline UInt32 OTSerialHandshakeData(UInt16 type, UInt8 onChar, UInt8 offChar)
  {
      return (((UInt32)type) << 16) | (((UInt32)onChar) << 8) | offChar;
 }

|#
 |#

; #else
; #define OTSerialHandshakeData(type, onChar, offChar)          ((((UInt32)type) << 16) | (((UInt32)onChar) << 8) | offChar)

; #endif

; #ifdef __cplusplus
#| #|

inline UInt32 OTSerialSetErrorCharacter(UInt8 rep)
{
  return (UInt32)rep & 0x000000ff;
}

inline UInt32 OTSerialSetErrorCharacterWithAlternate(UInt8 rep, UInt8 alternate)
{
 return (((rep & 0xff) | ((alternate & 0xff) << 8)) | 0x80000000L);
}

|#
 |#

; #else
; #define OTSerialSetErrorCharacter(rep)   ((rep) & 0xff)
; #define OTSerialSetErrorCharacterWithAlternate(rep, alternate)    ((((rep) & 0xff) | (((alternate) & 0xff) << 8)) | 0x80000000L)

; #endif

;  Default attributes for the serial ports

(defconstant $kOTSerialDefaultBaudRate #x4B00)
(defconstant $kOTSerialDefaultDataBits 8)
(defconstant $kOTSerialDefaultStopBits 10)
(defconstant $kOTSerialDefaultParity 0)
(defconstant $kOTSerialDefaultHandshake 0)
(defconstant $kOTSerialDefaultOnChar 17)
(defconstant $kOTSerialDefaultOffChar 19)
(defconstant $kOTSerialDefaultSndBufSize #x400)
(defconstant $kOTSerialDefaultRcvBufSize #x400)
(defconstant $kOTSerialDefaultSndLoWat 96)
(defconstant $kOTSerialDefaultRcvLoWat 1)
(defconstant $kOTSerialDefaultRcvTimeout 10)
;  ***** ISDN *****
;  Module Definitions
;  XTI Level

(defconstant $COM_ISDN :|ISDN|)
;  Module Names
(defconstant $kISDNName "isdn")
; #define kISDNName       "isdn"

(defconstant $kISDNModuleID #x1C84)
;  ISDN framing methods, set using the I_OTSetFramingType IOCTL

(defconstant $kOTISDNFramingTransparentSupported 16);  Support Transparent mode    

(defconstant $kOTISDNFramingHDLCSupported 32)   ;  Support HDLC Synchronous mode  

(defconstant $kOTISDNFramingV110Supported 64)   ;  Support V.110 Asynchronous mode    

(defconstant $kOTISDNFramingV14ESupported #x80) ;  Support V.14 Asynchronous mode     

;  Miscellaneous equates
;  Disconnect reason codes (from Q.931)

(defconstant $kOTISDNUnallocatedNumber 1)
(defconstant $kOTISDNNoRouteToSpecifiedTransitNetwork 2)
(defconstant $kOTISDNNoRouteToDestination 3)
(defconstant $kOTISDNChannelUnacceptable 6)
(defconstant $kOTISDNNormal 16)
(defconstant $kOTISDNUserBusy 17)
(defconstant $kOTISDNNoUserResponding 18)
(defconstant $kOTISDNNoAnswerFromUser 19)
(defconstant $kOTISDNCallRejected 21)
(defconstant $kOTISDNNumberChanged 22)
(defconstant $kOTISDNNonSelectedUserClearing 26)
(defconstant $kOTISDNDestinationOutOfOrder 27)
(defconstant $kOTISDNInvalidNumberFormat 28)
(defconstant $kOTISDNFacilityRejected 29)
(defconstant $kOTISDNNormalUnspecified 31)
(defconstant $kOTISDNNoCircuitChannelAvailable 34)
(defconstant $kOTISDNNetworkOutOfOrder 41)
(defconstant $kOTISDNSwitchingEquipmentCongestion 42)
(defconstant $kOTISDNAccessInformationDiscarded 43)
(defconstant $kOTISDNRequestedCircuitChannelNotAvailable 44)
(defconstant $kOTISDNResourceUnavailableUnspecified 45)
(defconstant $kOTISDNQualityOfServiceUnvailable 49)
(defconstant $kOTISDNRequestedFacilityNotSubscribed 50)
(defconstant $kOTISDNBearerCapabilityNotAuthorized 57)
(defconstant $kOTISDNBearerCapabilityNotPresentlyAvailable 58)
(defconstant $kOTISDNCallRestricted 59)
(defconstant $kOTISDNServiceOrOptionNotAvilableUnspecified 63)
(defconstant $kOTISDNBearerCapabilityNotImplemented 65)
(defconstant $kOTISDNRequestedFacilityNotImplemented 69)
(defconstant $kOTISDNOnlyRestrictedDigitalBearer 70)
(defconstant $kOTISDNServiceOrOptionNotImplementedUnspecified 79)
(defconstant $kOTISDNCallIdentityNotUsed 83)
(defconstant $kOTISDNCallIdentityInUse 84)
(defconstant $kOTISDNNoCallSuspended 85)
(defconstant $kOTISDNCallIdentityCleared 86)
(defconstant $kOTISDNIncompatibleDestination 88)
(defconstant $kOTISDNInvalidTransitNetworkSelection 91)
(defconstant $kOTISDNInvalidMessageUnspecified 95)
(defconstant $kOTISDNMandatoryInformationElementIsMissing 96)
(defconstant $kOTISDNMessageTypeNonExistentOrNotImplemented 97)
(defconstant $kOTISDNInterworkingUnspecified 127)
;  OTISDNAddress
; 
;    The OTISDNAddress has the following format:
;    "xxxxxx*yy"
;    where 'x' is the phone number and 'y' is the sub address (if available
;    in the network. The characters are coded in ASCII (IA5), and valid
;    characters are: '0'-'9','#','*'.
;    The max length of the each phone number is 21 characters (?) and the max
;    subaddress length is network dependent.
;    When using bonded channels the phone numbers are separated by '&'.
;    The X.25 user data is preceded by '@'.
; 

(defconstant $kAF_ISDN #x2000)
;  BSD value for AF_ISDN conflicts, so OT Carbon clients must use kAF_ISDN

(defconstant $kOTISDNMaxPhoneSize 32)
(defconstant $kOTISDNMaxSubSize 4)
(defrecord OTISDNAddress
   (fAddressType :UInt16)
   (fPhoneLength :UInt16)
   (fPhoneNumber (:array :character 37))
)

;type name? (%define-record :OTISDNAddress (find-record-descriptor ':OTISDNAddress))
;  IOCTL Calls for ISDN
;  ISDN shares the same ioctl space as serial.

(defconstant $MIOC_ISDN 85)                     ;  ISDN ioctl() cmds 


(defconstant $I_OTISDNAlerting #x5564)          ;  Send or receive an ALERTING message

(defconstant $I_OTISDNSuspend #x5565)           ;  Send a SUSPEND message
;  The parameter is the Call Identity (Maximum 8 octets)

(defconstant $I_OTISDNSuspendAcknowledge #x5566);  Receive a SUSPEND ACKNOWLEDGE message

(defconstant $I_OTISDNSuspendReject #x5567)     ;  Receive a SUSPEND REJECT message

(defconstant $I_OTISDNResume #x5568)            ;  Send a RESUME message
;  The parameter is the Call Identity (Maximum 8 octets)

(defconstant $I_OTISDNResumeAcknowledge #x5569) ;  Receive a RESUME ACKNOWLEDGE message

(defconstant $I_OTISDNResumeReject #x556A)      ;  Receive a RESUME REJECT message
;  Send or receive a FACILITY message

(defconstant $I_OTISDNFaciltity #x556B)
;  Connect user data size

(defconstant $kOTISDNMaxUserDataSize 32)
;  Option management calls for ISDN

(defconstant $ISDN_OPT_COMMTYPE #x200)
(defconstant $ISDN_OPT_FRAMINGTYPE #x201)
(defconstant $ISDN_OPT_56KADAPTATION #x202)
;  For ISDN_OPT_COMMTYPE...

(defconstant $kOTISDNTelephoneALaw 1)           ;  G.711 A-law                

(defconstant $kOTISDNTelephoneMuLaw 26)         ;  G.711 µ-law                

(defconstant $kOTISDNDigital64k 13)             ;  unrestricted digital (default)     

(defconstant $kOTISDNDigital56k 37)             ;  user rate 56Kb/s           

(defconstant $kOTISDNVideo64k 41)               ;  video terminal at 64Kb/s    

(defconstant $kOTISDNVideo56k 42)               ;  video terminal at 56Kb/s    

;  For ISDN_OPT_FRAMINGTYPE...

(defconstant $kOTISDNFramingTransparent 16)     ;  Transparent mode           

(defconstant $kOTISDNFramingHDLC 32)            ;  HDLC synchronous mode (default)    

(defconstant $kOTISDNFramingV110 64)            ;  V.110 asynchronous mode       

(defconstant $kOTISDNFramingV14E #x80)          ;  V.14E asynchronous mode         

;  For ISDN_OPT_56KADAPTATION...

(defconstant $kOTISDNNot56KAdaptation $false)   ;  not 56K Adaptation (default)     

(defconstant $kOTISDN56KAdaptation $true)       ;  56K Adaptation           

;  Default options, you do not need to set these

(defconstant $kOTISDNDefaultCommType 13)
(defconstant $kOTISDNDefaultFramingType 32)
(defconstant $kOTISDNDefault56KAdaptation $kOTISDNNot56KAdaptation)
; ******************************************************************************
; *   Constants for Open Transport-based Remote Access/PPP API
; *******************************************************************************
;  OTCreateConfiguration name for PPP control endpoint
(defconstant $kPPPControlName "ppp")
; #define kPPPControlName     "ppp"
;  XTI Level

(defconstant $COM_PPP :|PPPC|)
;  Options limits

(defconstant $kPPPMaxIDLength #xFF)
(defconstant $kPPPMaxPasswordLength #xFF)
(defconstant $kPPPMaxDTEAddressLength 127)
(defconstant $kPPPMaxCallInfoLength #xFF)
;  Various XTI option value constants

(defconstant $kPPPStateInitial 1)
(defconstant $kPPPStateClosed 2)
(defconstant $kPPPStateClosing 3)
(defconstant $kPPPStateOpening 4)
(defconstant $kPPPStateOpened 5)

(defconstant $kPPPConnectionStatusIdle 1)
(defconstant $kPPPConnectionStatusConnecting 2)
(defconstant $kPPPConnectionStatusConnected 3)
(defconstant $kPPPConnectionStatusDisconnecting 4)

(defconstant $kPPPMinMRU 0)
(defconstant $kPPPMaxMRU #x1194)

(defconstant $kIPCPTCPHdrCompressionDisabled 0)
(defconstant $kIPCPTCPHdrCompressionEnabled 1)

(defconstant $kPPPCompressionDisabled 0)
(defconstant $kPPPProtoCompression 1)
(defconstant $kPPPAddrCompression 2)

(defconstant $kPPPNoOutAuthentication 0)
(defconstant $kPPPCHAPOrPAPOutAuthentication 1)

(defconstant $kCCReminderTimerDisabled 0)
(defconstant $kCCIPIdleTimerDisabled 0)

(defconstant $kPPPScriptTypeModem 1)
(defconstant $kPPPScriptTypeConnect 2)
(defconstant $kPPPMaxScriptSize #x7D00)

(defconstant $kE164Address 1)
(defconstant $kPhoneAddress 1)
(defconstant $kCompoundPhoneAddress 2)
(defconstant $kX121Address 3)

(defconstant $kPPPConnectionStatusDialogsFlag 1)
(defconstant $kPPPConnectionRemindersFlag 2)
(defconstant $kPPPConnectionFlashingIconFlag 4)
(defconstant $kPPPOutPasswordDialogsFlag 8)
(defconstant $kPPPAllAlertsDisabledFlag 0)
(defconstant $kPPPAllAlertsEnabledFlag 15)

(defconstant $kPPPAsyncMapCharsNone 0)
(defconstant $kPPPAsyncMapCharsXOnXOff #xA0000)
(defconstant $kPPPAsyncMapCharsAll #xFFFFFFFF)
;  Option names

(defconstant $IPCP_OPT_GETREMOTEPROTOADDR #x7000)
(defconstant $IPCP_OPT_GETLOCALPROTOADDR #x7001)
(defconstant $IPCP_OPT_TCPHDRCOMPRESSION #x7002)
(defconstant $LCP_OPT_PPPCOMPRESSION #x7003)
(defconstant $LCP_OPT_MRU #x7004)
(defconstant $LCP_OPT_RCACCMAP #x7005)
(defconstant $LCP_OPT_TXACCMAP #x7006)
(defconstant $SEC_OPT_OUTAUTHENTICATION #x7007)
(defconstant $SEC_OPT_ID #x7008)
(defconstant $SEC_OPT_PASSWORD #x7009)
(defconstant $CC_OPT_REMINDERTIMER #x7010)
(defconstant $CC_OPT_IPIDLETIMER #x7011)
(defconstant $CC_OPT_DTEADDRESSTYPE #x7012)
(defconstant $CC_OPT_DTEADDRESS #x7013)
(defconstant $CC_OPT_CALLINFO #x7014)
(defconstant $CC_OPT_GETMISCINFO #x7015)
(defconstant $PPP_OPT_GETCURRENTSTATE #x7016)
(defconstant $LCP_OPT_ECHO #x7017)              ;  Available on Mac OS X only 

(defconstant $CC_OPT_SERIALPORTNAME #x7200)
;  Endpoint events

(defconstant $kPPPEvent #x230F0000)
(defconstant $kPPPConnectCompleteEvent #x230F0001)
(defconstant $kPPPSetScriptCompleteEvent #x230F0002)
(defconstant $kPPPDisconnectCompleteEvent #x230F0003)
(defconstant $kPPPDisconnectEvent #x230F0004)
(defconstant $kPPPIPCPUpEvent #x230F0005)
(defconstant $kPPPIPCPDownEvent #x230F0006)
(defconstant $kPPPLCPUpEvent #x230F0007)
(defconstant $kPPPLCPDownEvent #x230F0008)
(defconstant $kPPPLowerLayerUpEvent #x230F0009)
(defconstant $kPPPLowerLayerDownEvent #x230F000A)
(defconstant $kPPPAuthenticationStartedEvent #x230F000B)
(defconstant $kPPPAuthenticationFinishedEvent #x230F000C)
(defconstant $kPPPDCEInitStartedEvent #x230F000D)
(defconstant $kPPPDCEInitFinishedEvent #x230F000E)
(defconstant $kPPPDCECallStartedEvent #x230F000F)
(defconstant $kPPPDCECallFinishedEvent #x230F0010)

; #if CALL_NOT_IN_CARBON
#|                                              ;  Support for modem script endpoints: 
;  The Configuration name for the Opentransport Modem/Script engine. 
; #define kScriptName        "Script"
;  To check if the  Modem/Script engine is installed you should interrogate
;    the proper Gestalt Selectors for Open Transport-based Modem libraries. 
; #define gestaltOpenTptModem             'otmo'
; #define gestaltOpenTptModemPresent       0
; #define gestaltOpenTptModemVersion       'otmv'
; #define kGestaltOpenTptModemVersion      0x01000080
;  These are the  Modem/Script Configurator error codes.  Other codes may be
;    returned from Open Transport and operating system routines. 
; #define kModemNoError               0
; #define kModemOutOfMemory           -14000
; #define kModemPreferencesMissing    -14001
; #define kModemScriptMissing         -14002
;  The Modem Configuration pref resource file constants. 
; #define kModemConfigFileCreator     'modm'
; #define kModemConfigFileType        'mdpf'
; #define kModemConfigVersion         0x00010000
; #define kModemConfigExportType      'mdex'
; #define kModemScriptType            'mlts' /* Same as ARA 1.0/2.0 */
; #define kModemScriptCreator         'slnk'    /* Same as ARA 1.0/2.0 */
;  Configuration resource constants. 
; #define kModemConfigTypeModem       'ccl '  /* Type for Modem config resource  */
; #define kModemSelectedConfigID      1     /* ID of resource containing..     */
; #define kModemSelectedConfigType    'ccfg'    /* the ID of current selected CCL  */
; #define kModemConfigNameType        'cnam'    /* type of config name rez         */
; #define kModemConfigTypeLocks       'lkmd'    /* Types for lock rez              */
; #define kModemConfigFirstID         128       /* lowest id for configuration rez */
;  Maximum script file name size.  Same as "name" field of FSSpec. 
; #define kMaxScriptNameSize            64
;  File name to use only if the internationalized one can't be read
;    from the resource fork. 
; #define kDefaultModemPrefsFileName   "\pModem Preferences"
;  Dial tone modes 

(defconstant $kDialToneNormal 0)
(defconstant $kDialToneIgnore 1)
(defconstant $kDialToneManual 2)
;  Modem Configuration Resource format for Modem configuration info. 
(defrecord RAConfigModem
   (version :UInt32)
   (useModemScript :Boolean)
   (modemScript :FSSpec)
   (modemSpeakerOn :Boolean)
   (modemPulseDial :Boolean)
   (modemDialToneMode :UInt32)
   (lowerLayerName (:array :SInt8 36))
)
 |#

; #endif  /* CALL_NOT_IN_CARBON */

; ******************************************************************************
; *   IOCTL constants for I_OTConnect, I_OTDisconnect and I_OTScript
; *   are defined in OpenTransport.h
; *******************************************************************************
; ******************************************************************************
; *   PPPMRULimits
; *******************************************************************************
(defrecord PPPMRULimits
   (mruSize :UInt32)                            ;  proposed or actual
   (upperMRULimit :UInt32)
   (lowerMRULimit :UInt32)
)

;type name? (%define-record :PPPMRULimits (find-record-descriptor ':PPPMRULimits))
; ******************************************************************************
; *   CCMiscInfo
; *******************************************************************************
(defrecord CCMiscInfo
   (connectionStatus :UInt32)
   (connectionTimeElapsed :UInt32)
   (connectionTimeRemaining :UInt32)
   (bytesTransmitted :UInt32)
   (bytesReceived :UInt32)
   (reserved :UInt32)
)

;type name? (%define-record :CCMiscInfo (find-record-descriptor ':CCMiscInfo))
; ******************************************************************************
; *   LCPEcho
; *******************************************************************************
;  Set both fields to zero to disable sending of LCP echo requests
(defrecord LCPEcho
   (retryCount :UInt32)
   (retryPeriod :UInt32)                        ;  in milliseconds
)

;type name? (%define-record :LCPEcho (find-record-descriptor ':LCPEcho))
; ******************************************************************************
; *   Bits used to tell kind of product
; *******************************************************************************

(defconstant $kRAProductClientOnly 2)
(defconstant $kRAProductOnePortServer 3)
(defconstant $kRAProductManyPortServer 4)

; #if defined(__MWERKS__) && TARGET_CPU_68K
#| ; #pragma pop
 |#

; #endif

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __OPENTRANSPORTPROVIDERS__ */


(provide-interface "OpenTransportProviders")