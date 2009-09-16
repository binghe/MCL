(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OpenTransport.h"
; at Sunday July 2,2006 7:23:33 pm.
; 
;      File:       OT/OpenTransport.h
;  
;      Contains:   Open Transport client interface file.
;  
;      Version:    OpenTransport-90~46
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __OPENTRANSPORT__
; #define __OPENTRANSPORT__
; 
;    The following table shows how to map from the old (pre-Universal
;    Interfaces) header file name to the equivalent Universal Interfaces
;    header file name.
;     Old Header              New Header
;     ----------              ----------
;     cred.h                  OpenTransportProtocol.h
;     dlpi.h                  OpenTransportProtocol.h
;     miioccom.h              OpenTransportProtocol.h
;     mistream.h              OpenTransportProtocol.h/OpenTransportKernel.h
;     modnames.h              OpenTransportProtocol.h
;     OpenTptAppleTalk.h      OpenTransportProviders.h
;     OpenTptClient.h         OpenTransportProtocol.h
;     OpenTptCommon.h         OpenTransportProtocol.h
;     OpenTptConfig.h         OpenTransportProtocol.h
;     OpenTptDevLinks.h       OpenTransportProviders.h
;     OpenTptInternet.h       OpenTransportProviders.h
;     OpenTptISDN.h           OpenTransportProviders.h
;     OpenTptLinks.h          OpenTransportProviders.h
;     OpenTptModule.h         OpenTransportKernel.h
;     OpenTptPCISupport.h     OpenTransportKernel.h
;     OpenTptSerial.h         OpenTransportProviders.h
;     OpenTptXTI.h            OpenTransportUNIX.r
;     OpenTransport.h         OpenTransport.h
;     OpenTransport.r         OpenTransport.r
;     OTConfig.r              OpenTransportProtocol.r
;     OTDebug.h               OpenTransport.h
;     OTSharedLibs.h          OpenTransportProviders.h
;     strlog.h                OpenTransportProtocol.h/OpenTransportKernel.h
;     stropts.h               OpenTransportProtocol.h/OpenTransportUNIX.h
;     strstat.h               OpenTransportProtocol.h
;     tihdr.h                 OpenTransportProtocol.h
; 
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __MIXEDMODE__
#| #|
#include <CarbonCoreMixedMode.h>
#endif
|#
 |#
; #ifndef __MACERRORS__
#| #|
#include <CarbonCoreMacErrors.h>
#endif
|#
 |#
; #ifdef __cplusplus
#| #|
#include <stddef.h>
#endif
|#
 |#
;  #include <OTEnvironment.h> 
; #define _CDECL

; #if defined(__SC__) || defined(THINK_CPLUS) || defined(__MRC__)
#| ; #ifdef __cplusplus
#|
     #undef _CDECL
      #define _CDECL          _cdecl
 #endif
|#
 |#

; #endif


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

;  ***** Setup Default Compiler Variables *****
; 
;    OTKERNEL is used to indicate whether the code is being built
;    for the kernel environment.  It defaults to 0.  If you include
;    "OpenTransportKernel.h" before including this file,
;    it will be 1 and you will only be able to see stuff available
;    to kernel code.
; 
; #ifndef OTKERNEL
(defconstant $OTKERNEL 0)
; #define OTKERNEL 0

; #endif  /* !defined(OTKERNEL) */

; 
;    OTUNIXERRORS determines whether this file defines a bunch of
;    common UNIX error codes, like EPERM.  Typically, client code does
;    not want to do this because of the possibility of a clash with
;    other code modules, like the standard C libraries, that also
;    defines these routines.  However, client code can turn it on to
;    get these definitions.  This might be done by protocol stack
;    infrastructure, or some other low-level code.
;    "OpenTransportKernel.i" sets this flag before include
;    "OpenTransport.h" because kernel modules typically need these
;    error codes.  Note that kernel modules shouldn't be including
;    standard C libraries, so this is rarely a problem.
;    In general, the clash between OT and standard C definitions
;    of these error codes is rarely a problem becasue both OT
;    and the C libraries define them to have the same value.  But
;    I'm sure this check is useful to some people.
; 
; #ifndef OTUNIXERRORS
#| #|
#define OTUNIXERRORS 0
#endif
|#
 |#
;  !defined(OTUNIXERRORS) 
; 
;    OTDEBUG is used to control the behaviour of the OT debugging
;    macros.  If you set it to non-zero, the macros will generate code
;    that drops you into the debugger.  If you set it to 0, or leave it
;    undefined, the macros are compiled out.
;    Setting up this compiler variable is a little tricky because previous
;    versions of the OT interfaces used a different variable, qDebug.
;    We replaced qDebug with OTDEBUG because qDebug does not fit into
;    the OT namespace.  But I didn't want to break a lot of currently
;    building code.  The following tricky compiler variable footwork
;    avoids this.
;    There are four outcomes when this code is compiled, depending on
;    whether qDebug and OTDEBUG are defined beforehand.  The following
;    table shows the outcome in each case.
;    qDebug     OTDEBUG    Outcome       Explanation  
;    ------     -------    -------       -----------
;    defined    defined    OTDEBUG wins  Mixed legacy and new code, we believe the new code.
;    defined    undefined  qDebug wins   Legacy code.
;    undefined  defined    OTDEBUG wins  New code.
;    undefined  undefined  no debugging  No debugging.
; 
; #ifdef qDebug
#| #|
#ifndefOTDEBUG
#define OTDebug qDebug
#endif 

#endif
|#
 |#
;  defined(qDebug) 
; #ifndef OTDEBUG
(defconstant $OTDEBUG 0)
; #define OTDEBUG 0

; #endif  /* !defined(OTDEBUG) */

; #ifndef BuildingOTForKernel
(defconstant $BuildingOTForKernel 0)
; #define BuildingOTForKernel 0

; #endif  /* !defined(BuildingOTForKernel) */

;  Carbon Applications have some restrictions on using OT
; #ifndef OTCARBONAPPLICATION
(defconstant $OTCARBONAPPLICATION 0)
; #define OTCARBONAPPLICATION 0

; #endif  /* !defined(OTCARBONAPPLICATION) */

; 
;    ***** Normalise 68K Calling C Conventions *****
;    Define special types that handle the difference in parameter passing
;    between different Mac OS C compilers when generating 68K code.  OT
;    exports C calling conventions routines, and various C compilers use
;    various different conventions.  Differences in the placement of the result
;    are covered above, where we output pragma pointers_in_D0.  The other big
;    difference is how the compilers pass integer parameters less than 32 bits.
;    The MPW compiler always extends these to 32 bits; other compilers simply
;    push a value of the appropriate size.  We overcome this difference by
;    defining special OTFooParam types, which are only used when passing
;    sub 32 bit values to routines.  They are always defined to a 32 bit
;    size, which makes all the compilers do the same thing.
;    One weird consequence of this is that in more strict type checking
;    languages (eg Pascal) OTBooleanParam is not compatible with Boolean.
;    Sorry.
; 
; 
;    Large tracts of OT source still uses boolean_p etc.
;    So we continue to define the old types for Apple
;    clients.  The long term fix is to remove all the
;    uses of these type from the OT source, but that's
;    beyond the scope of my work right now.
; 

(def-mactype :OTUInt8Param (find-mactype ':UInt8))

(def-mactype :OTUInt16Param (find-mactype ':UInt16))

(def-mactype :OTSInt16Param (find-mactype ':SInt16))

(def-mactype :OTSInt8Param (find-mactype ':SInt8))

(def-mactype :OTBooleanParam (find-mactype ':Boolean))

(def-mactype :uchar_p (find-mactype ':UInt8))

(def-mactype :ushort_p (find-mactype ':UInt16))

(def-mactype :short_p (find-mactype ':SInt16))

(def-mactype :char_p (find-mactype ':SInt8))

(def-mactype :boolean_p (find-mactype ':Boolean))

; #if defined(__MWERKS__) || defined(THINK_C) || defined(SYMANTEC_CPLUS) || defined(SYMANTEC_C) || defined (__xlc) || defined (__xlC) || defined (__xlC__)
#| 
(def-mactype :OTByteCount (find-mactype ':UInt32))

(def-mactype :OTItemCount (find-mactype ':UInt32))

(def-mactype :OTInt32 (find-mactype ':SInt32))

(def-mactype :OTUInt32 (find-mactype ':UInt32))
 |#

; #else

(def-mactype :OTByteCount (find-mactype ':UInt32))

(def-mactype :OTItemCount (find-mactype ':UInt32))

(def-mactype :OTInt32 (find-mactype ':signed-long))

(def-mactype :OTUInt32 (find-mactype ':UInt32))

; #endif


(def-mactype :int_t (find-mactype ':signed-long))

(def-mactype :uint_t (find-mactype ':UInt32))
;  ***** C++ Support *****
; 
;    Setup _MDECL to be _cdecl when compiling C++ code with
;    compilers that support it, or nothing otherwise.
; 
; #define _MDECL

; #if defined(__SC__) || defined(THINK_CPLUS) || defined(__MRC__)
#| ; #ifdef __cplusplus
#|
     #undef _MDECL
      #define _MDECL          _cdecl
 #endif
|#
 |#

; #endif

;  ***** Shared Library Prefixes *****
(defconstant $kOTLibraryVersion "1.1")
; #define kOTLibraryVersion      "1.1"
(defconstant $kOTLibraryPrefix "OTLib$")
; #define kOTLibraryPrefix         "OTLib$"
(defconstant $kOTModulePrefix "OTModl$")
; #define kOTModulePrefix            "OTModl$"
(defconstant $kOTClientPrefix "OTClnt$")
; #define kOTClientPrefix           "OTClnt$"
(defconstant $kOTKernelPrefix "OTKrnl$")
; #define kOTKernelPrefix           "OTKrnl$"

(defconstant $kOTCFMClass :|otan|)
;  ***** Miscellaneous Type Definitions *****
;  A millisecond timeout value

(def-mactype :OTTimeout (find-mactype ':UInt32))
;  An ID number in connections/transactions     

(def-mactype :OTSequence (find-mactype ':SInt32))
;  An ID number for registered names            

(def-mactype :OTNameID (find-mactype ':SInt32))
; 
;    A protocol-specific reason code for failure.
;    Usually a Unix-style positive error code.
; 

(def-mactype :OTReason (find-mactype ':SInt32))
;  Number of outstanding connection requests at a time.

(def-mactype :OTQLen (find-mactype ':UInt32))
;  Will become internationalizeable shortly (yeah, right).

(def-mactype :OTClientName (find-mactype '(:pointer :UInt8)))
;  The command code in STREAMS messages.

(def-mactype :OTCommand (find-mactype ':SInt32))
;  value describing a client

(def-mactype :OTClient (find-mactype '(:pointer :void)))
; 
;     OT now defines its own version of the standard C "offsetof"
;     macro so as to avoid including <stddef.h>.
; 
; #define OTOffsetOf(structure,field) ((ByteCount)&((structure *) 0)->field)
;  ***** Debugging Macros *****
(defconstant $kOTFatalErr "FB ")
; #define kOTFatalErr                "FB "
(defconstant $kOTNonfatalErr "NB ")
; #define kOTNonfatalErr            "NB "
(defconstant $kOTExtFatalErr "FX ")
; #define kOTExtFatalErr            "FX "
(defconstant $kOTExtNonfatalErr "NX ")
; #define kOTExtNonfatalErr     "NX "
(defconstant $kOTUserFatalErr "UF ")
; #define kOTUserFatalErr           "UF "
(defconstant $kOTUserErr "UE ")
; #define kOTUserErr                "UE "
(defconstant $kOTUserNonfatalErr "UE ")
; #define kOTUserNonfatalErr        "UE "
(defconstant $kOTInfoErr "IE ")
; #define kOTInfoErr                "IE "
(defconstant $kOTInfoBreak "IN ")
; #define kOTInfoBreak          "IN "
; 
;  *  OTDebugStr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #if qDebug > 0
; #define OTDebugBreak(str)           OTDebugStr(str)
; #define OTDebugTest(val, str)       { if ( val ) OTDebugStr(str); }
; #define OTAssert(name, cond)        ((cond) ? ((void) 0) : (OTDebugStr( __FILE__ ": " #name ": " #cond )))
#| 
; #else
; #define OTDebugBreak(str)
; #define OTDebugTest(val, str)
; #define OTAssert(name, cond)
 |#

; #endif /* qDebug > 0 */


; #if qDebug > 1 || qDebug2 > 1
; #define OTDebugBreak2(str)          OTDebugStr(str)
; #define OTDebugTest2(val, str)      { if ( val) OTDebugStr(str); }
#| 
; #else
; #define OTDebugBreak2(str)
; #define OTDebugTest2(val, str)
 |#

; #endif   /* qDebug > 1 || qDebug2 > 1 */

; 
;    ***** Flags Used When Opening Providers *****
;    Important
;    OT does not currently support any of these flags.  You should
;    always pass 0 to a parameter of type OTOpenFlags.  If you need
;    to modify the mode of operation of a provider, use OTSetBlocking,
;    OTSetSynchronous, etc.
; 

(def-mactype :OTOpenFlags (find-mactype ':UInt32))

(defconstant $kO_ASYNC 1)
(defconstant $kO_NDELAY 4)
(defconstant $kO_NONBLOCK 4)

; #if CALL_NOT_IN_CARBON
#| 
; 
;    BSD defines O_ASYNC, O_NDELAY and O_NONBLOCK in fcntl.h 
;    Use kO_ASYNC, kO_NDELAY and kO_NONBLOCK in the unlikely event you need the OT value in Carbon
; 

(defconstant $O_ASYNC 1)
(defconstant $O_NDELAY 4)
(defconstant $O_NONBLOCK 4)
 |#

; #endif  /* CALL_NOT_IN_CARBON */

;  ***** UNIX-Style Error Codes *****

(def-mactype :OTUnixErr (find-mactype ':UInt16))
; 
;    These definitions are only compiled if you're building kernel code
;    or you explicit request them by setting OTUNIXERRORS.  See the
;    description of these compiler variables, given above.
; 

; #if OTKERNEL || OTUNIXERRORS
; 
;    There may be some error code confusions with other compiler vendor header
;    files - However, these match both MPW and AIX definitions.
; 
; 
;    First we undefine the #defined ones we know about so that we can put them
;    in an enum.  Of course, this is only going to work in C, but hopefully
;    other languages won't have these symbols overloaded.
; 
; #undef EPERM
; #undef ENOENT
; #undef ENORSRC
; #undef EINTR
; #undef EIO
; #undef ENXIO
; #undef E2BIG
; #undef EBADF
; #undef EAGAIN
; #undef ENOMEM
; #undef EACCES
; #undef EFAULT
; #undef EBUSY
; #undef EEXIST
; #undef ENODEV
; #undef EINVAL
; #undef ENOTTY
; #undef ERANGE
; #undef ESRCH
; #undef EPIPE

(defconstant $EPERM 1)                          ;  Permission denied            

(defconstant $ENOENT 2)                         ;  No such file or directory       

(defconstant $ENORSRC 3)                        ;  No such resource               

(defconstant $EINTR 4)                          ;  Interrupted system service        

(defconstant $EIO 5)                            ;  I/O error                 

(defconstant $ENXIO 6)                          ;  No such device or address       

(defconstant $EBADF 9)                          ;  Bad file number                 

(defconstant $EAGAIN 11)                        ;  Try operation again later       

(defconstant $ENOMEM 12)                        ;  Not enough space               

(defconstant $EACCES 13)                        ;  Permission denied            

(defconstant $EFAULT 14)                        ;  Bad address                   

(defconstant $EBUSY 16)                         ;  Device or resource busy          

(defconstant $EEXIST 17)                        ;  File exists                   

(defconstant $ENODEV 19)                        ;  No such device               

(defconstant $EINVAL 22)                        ;  Invalid argument               

(defconstant $ENOTTY 25)                        ;  Not a character device          

(defconstant $EPIPE 32)                         ;  Broken pipe                   

(defconstant $ERANGE 34)                        ;  Math result not representable   

(defconstant $EDEADLK 35)                       ;  Call would block so was aborted       

(defconstant $EWOULDBLOCK 35)                   ;  Or a deadlock would occur       

(defconstant $EALREADY 37)
(defconstant $ENOTSOCK 38)                      ;  Socket operation on non-socket     

(defconstant $EDESTADDRREQ 39)                  ;  Destination address required      

(defconstant $EMSGSIZE 40)                      ;  Message too long               

(defconstant $EPROTOTYPE 41)                    ;  Protocol wrong type for socket     

(defconstant $ENOPROTOOPT 42)                   ;  Protocol not available          

(defconstant $EPROTONOSUPPORT 43)               ;  Protocol not supported          

(defconstant $ESOCKTNOSUPPORT 44)               ;  Socket type not supported       

(defconstant $EOPNOTSUPP 45)                    ;  Operation not supported on socket  

(defconstant $EADDRINUSE 48)                    ;  Address already in use          

(defconstant $EADDRNOTAVAIL 49)                 ;  Can't assign requested address     

(defconstant $ENETDOWN 50)                      ;  Network is down                 

(defconstant $ENETUNREACH 51)                   ;  Network is unreachable          

(defconstant $ENETRESET 52)                     ;  Network dropped connection on reset    

(defconstant $ECONNABORTED 53)                  ;  Software caused connection abort     

(defconstant $ECONNRESET 54)                    ;  Connection reset by peer          

(defconstant $ENOBUFS 55)                       ;  No buffer space available       

(defconstant $EISCONN 56)                       ;  Socket is already connected         

(defconstant $ENOTCONN 57)                      ;  Socket is not connected          

(defconstant $ESHUTDOWN 58)                     ;  Can't send after socket shutdown     

(defconstant $ETOOMANYREFS 59)                  ;  Too many references: can't splice  

(defconstant $ETIMEDOUT 60)                     ;  Connection timed out             

(defconstant $ECONNREFUSED 61)                  ;  Connection refused           

(defconstant $EHOSTDOWN 64)                     ;  Host is down                

(defconstant $EHOSTUNREACH 65)                  ;  No route to host               

(defconstant $EPROTO 70)                        ;  STREAMS protocol error          

(defconstant $ETIME 71)
(defconstant $ENOSR 72)
(defconstant $EBADMSG 73)
(defconstant $ECANCEL 74)
(defconstant $ENOSTR 75)
(defconstant $ENODATA 76)
(defconstant $EINPROGRESS 77)
(defconstant $ESRCH 78)
(defconstant $ENOMSG 79)
(defconstant $ELASTERRNO 79)

; #endif  /* OTKERNEL || OTUNIXERRORS */

;  ***** Open Transport/XTI Error codes *****

(def-mactype :OTXTIErr (find-mactype ':UInt16))

(defconstant $TSUCCESS 0)                       ;  No Error occurred             

(defconstant $TBADADDR 1)                       ;  A Bad address was specified          

(defconstant $TBADOPT 2)                        ;  A Bad option was specified          

(defconstant $TACCES 3)                         ;  Missing access permission          

(defconstant $TBADF 4)                          ;  Bad provider reference           

(defconstant $TNOADDR 5)                        ;  No address was specified             

(defconstant $TOUTSTATE 6)                      ;  Call issued in wrong state          

(defconstant $TBADSEQ 7)                        ;  Sequence specified does not exist   

(defconstant $TSYSERR 8)                        ;  A system error occurred              

(defconstant $TLOOK 9)                          ;  An event occurred - call Look()         

(defconstant $TBADDATA 10)                      ;  An illegal amount of data was specified    

(defconstant $TBUFOVFLW 11)                     ;  Passed buffer not big enough          

(defconstant $TFLOW 12)                         ;  Provider is flow-controlled          

(defconstant $TNODATA 13)                       ;  No data available for reading       

(defconstant $TNODIS 14)                        ;  No disconnect indication available     

(defconstant $TNOUDERR 15)                      ;  No Unit Data Error indication available    

(defconstant $TBADFLAG 16)                      ;  A Bad flag value was supplied       

(defconstant $TNOREL 17)                        ;  No orderly release indication available    

(defconstant $TNOTSUPPORT 18)                   ;  Command is not supported             

(defconstant $TSTATECHNG 19)                    ;  State is changing - try again later       

(defconstant $TNOSTRUCTYPE 20)                  ;  Bad structure type requested for OTAlloc   

(defconstant $TBADNAME 21)                      ;  A bad endpoint name was supplied      

(defconstant $TBADQLEN 22)                      ;  A Bind to an in-use address with qlen > 0

(defconstant $TADDRBUSY 23)                     ;  Address requested is already in use       

(defconstant $TINDOUT 24)                       ;  Accept failed because of pending listen    

(defconstant $TPROVMISMATCH 25)                 ;  Tried to accept on incompatible endpoint   

(defconstant $TRESQLEN 26)
(defconstant $TRESADDR 27)
(defconstant $TQFULL 28)
(defconstant $TPROTO 29)                        ;  An unspecified provider error occurred 

(defconstant $TBADSYNC 30)                      ;  A synchronous call at interrupt time     

(defconstant $TCANCELED 31)                     ;  The command was cancelled          

(defconstant $TLASTXTIERROR 31)
; 
;    ***** Mac OS Error Codes *****
;    Most OT client routines return an OSStatus error code, a 32 bit type
;    defined in "MacTypes.h".  The OT-unique error code values are
;    defined below.  Many of these are generated by remapping XTI error
;    codes (Txxxx) and UNIX error codes (Exxxx) to a reserved range
;    in the OSStatus space.
;    Some routines return an OTResult type, indicating
;    that the routine might fail with a negative error, succeed with noErr,
;    or possible return a positive value indicating some status.
; 

(def-mactype :OTResult (find-mactype ':SInt32))
; 
;  * These map the Open Transport/XTI errors (the Txxxx error codes), and the
;  * StdCLib Exxxx error codes into unique spaces in the Mac OS OSStatus space.
;  
; #define XTI2OSStatus(x)           (-3149 - (x))
; #define E2OSStatus(x)         (-3199 - (x))
; #define OSStatus2XTI(x)          ((OTXTIErr)(-3149 - (x)))
; #define OSStatus2E(x)         ((OTUnixErr)(-3199 - (x)))
; #define IsXTIError(x)           ((x) < -3149 && (x) >= (-3149 - TLASTXTIERROR))
; #define IsEError(x)             ((x) < -3199 && (x) >= (-3199 - ELASTERRNO))
;  ***** OTAddress *****
; 
;    OTAddress type defines the standard header for all OT address formats.
;    It consists of one 16 bit integer, which defines the address format
;    used, followed by an arbitrary number of bytes which are protocol-specific.
;    Conceptually, all OT address formats are subtypes of this type,
;    extended with fields that are specific to the protocol.  For example,
;    OTInetAddress starts with the OTAddressType field and then continues
;    to include a host IP address and a port number.
; 

(defconstant $kOTGenericName 0)                 ;  Protocol specific data is just a string, interpreted in a protocol-specific fashion.


(def-mactype :OTAddressType (find-mactype ':UInt16))
(defrecord OTAddress
   (fAddressType :UInt16)                       ;  The address format of this address...
   (fAddress (:array :UInt8 1))                 ;  ... followed by protocol specific address information.
)

;type name? (%define-record :OTAddress (find-record-descriptor ':OTAddress))
; 
;    ***** OTAlloc Constants *****
;    Note:
;    In general, Apple recommends that you avoid the OTAlloc call because
;    using it extensively causes your program to allocate and deallocate
;    many memory blocks, with each extra memory allocation costing time.
; 
; 
;    OTStructType defines the structure type to be allocated using the OTAlloc
;    call.
; 

(defconstant $T_BIND 1)
(defconstant $T_OPTMGMT 2)
(defconstant $T_CALL 3)
(defconstant $T_DIS 4)
(defconstant $T_UNITDATA 5)
(defconstant $T_UDERROR 6)
(defconstant $T_INFO 7)
(defconstant $T_REPLYDATA 8)
(defconstant $T_REQUESTDATA 9)
(defconstant $T_UNITREQUEST 10)
(defconstant $T_UNITREPLY 11)

(def-mactype :OTStructType (find-mactype ':UInt32))
; 
;    These values are used in the "fields" parameter of the OTAlloc call
;    to define which fields of the structure should be allocated.
; 

(defconstant $T_ADDR 1)
(defconstant $T_OPT 2)
(defconstant $T_UDATA 4)
(defconstant $T_ALL #xFFFF)

(def-mactype :OTFieldsType (find-mactype ':UInt32))
;  ***** OTFlags *****
; 
;    This type is used to describe bitwise flags in OT data structures
;    and parameters.  Think of it as the OT analogue to the OptionBits
;    type in "MacTypes.h".
; 

(def-mactype :OTFlags (find-mactype ':UInt32))
; 
;    These flags are used when sending and receiving data.  The
;    constants defined are masks.
; 

(defconstant $T_MORE 1)                         ;  More data to come in message     

(defconstant $T_EXPEDITED 2)                    ;  Data is expedited, if possible 

(defconstant $T_ACKNOWLEDGED 4)                 ;  Acknowledge transaction         

(defconstant $T_PARTIALDATA 8)                  ;  Partial data - more coming     

(defconstant $T_NORECEIPT 16)                   ;  No event on transaction done     

(defconstant $T_TIMEDOUT 32)                    ;  Reply timed out              

;  These flags are used in the TOptMgmt structure to request services.

(defconstant $T_NEGOTIATE 4)
(defconstant $T_CHECK 8)
(defconstant $T_DEFAULT 16)
(defconstant $T_CURRENT #x80)
; 
;    These flags are used in the TOptMgmt and TOption structures to
;    return results.
; 

(defconstant $T_SUCCESS 32)
(defconstant $T_FAILURE 64)
(defconstant $T_PARTSUCCESS #x100)
(defconstant $T_READONLY #x200)
(defconstant $T_NOTSUPPORT #x400)
; 
;    Mentat's code does an #ifdef on this symbol, so we have to #define
;    it as well as declare it as an enum.  But only for Apple builds because
;    we don't want internal weirdness to propagate to developers.
; 
; #define T_CURRENT T_CURRENT
; #define T_PARTSUCCESS T_PARTSUCCESS
; #define T_NOTSUPPORT T_NOTSUPPORT
; #define T_READONLY T_READONLY
; 
;    ***** OTBand *****
;    A band is a STREAMS concepts which defines the priority of data
;    on a stream.  Although this type is defined as a 32 bit number
;    for efficiency's sake, bands actually only range from 0 to 255. 
;    Typically band 0 is used for normal data and band 1 for expedited data.
; 

(def-mactype :OTBand (find-mactype ':UInt32))
;  ***** Object References *****
; 
;    This deserves some explanation.  If you're compiling for
;    C++, the C++ definitions of TEndpoint and TMapper at the
;    end of this file are invoked, which lets the compiler
;    know that they are both subclasses of TProvider.  This
;    way the compiler will do the right subclass type checking,
;    ie you will be able to pass an EndpointRef to a parameter
;    of type ProviderRef, but not vice versa.
;    On the other hand, if your compiling for straighth C,
;    everything is defined as void.  This is somewhat dangerous,
;    but it prevents you have to cast an EndpointRef to a
;    ProviderRef every time you call a function that works
;    on all forms of providers.
; 
; #ifdef __cplusplus
#| #|
  typedef class TProvider*  ProviderRef;
  typedef class TEndpoint*  EndpointRef;
  typedef class TMapper*    MapperRef;
|#
 |#

; #else

(def-mactype :ProviderRef (find-mactype '(:pointer :void)))

(def-mactype :EndpointRef (find-mactype '(:pointer :void)))

(def-mactype :MapperRef (find-mactype '(:pointer :void)))

; #endif

(defconstant $kOTInvalidRef 0)
; #define kOTInvalidRef   0L
(defconstant $kOTInvalidProviderRef 0)
; #define kOTInvalidProviderRef   ((ProviderRef)0L)
(defconstant $kOTInvalidEndpointRef 0)
; #define kOTInvalidEndpointRef   ((EndpointRef)0L)
(defconstant $kOTInvalidMapperRef 0)
; #define kOTInvalidMapperRef     ((MapperRef)0L)
;  ***** Event Codes *****
; 
;    OT event codes values for Open Transport.  These are the event codes that
;    are sent to notification routine (notifiers).
; 

(def-mactype :OTEventCode (find-mactype ':UInt32))
; 
;    Events are divided into numerous categories:
;    
;    1. (0x0000xxxx) The core XTI events have identifiers of the form
;       T_XXXX.  These signal that an XTI event has occured on a stream.
;    2. (0x1000xxxx) Private events are reserved for protocol specific
;       events.  Each protocol stack defines them as appropriate for
;       its own usage.
;    3. (0x2000xxxxx) Completion events have identifiers of the form
;       T_XXXXCOMPLETE.  These signal the completion of some asynchronous
;       API routine, and are only delivered if the endpoint is in asynchronous
;       mode.
;    4. (0x2100xxxx) Stream events are generally encountered when programming
;       the raw streams API and indicate some event on a raw stream, or
;       some other event of interest in the STREAMS kernel.
;    5. (0x2200xxxx) Signal events indicate that a signal has arrived on
;       a raw stream.  See "Signal Values" for details.
;    6. (0x2300xxxx) General provider events that might be generated by any
;       provider.
;    7. (0x2400xxxx) System events sent to all providers.
;    8. (0x2500xxxx) System events sent to registered clients.
;    9. (0x2600xxxx) System events used by configurators.
;   10. (0x2700xxxx) Events sent to registered OT clients.
; 
; 
;    All event codes not described here are reserved by Apple.  If you receive
;    an event code you do not understand, ignore it!
; 

(defconstant $T_LISTEN 1)                       ;  An connection request is available     

(defconstant $T_CONNECT 2)                      ;  Confirmation of a connect request  

(defconstant $T_DATA 4)                         ;  Standard data is available        

(defconstant $T_EXDATA 8)                       ;  Expedited data is available         

(defconstant $T_DISCONNECT 16)                  ;  A disconnect is available       

(defconstant $T_ERROR 32)                       ;  obsolete/unused in library        

(defconstant $T_UDERR 64)                       ;  A Unit Data Error has occurred     

(defconstant $T_ORDREL #x80)                    ;  An orderly release is available       

(defconstant $T_GODATA #x100)                   ;  Flow control lifted on standard data   

(defconstant $T_GOEXDATA #x200)                 ;  Flow control lifted on expedited data

(defconstant $T_REQUEST #x400)                  ;  An Incoming request is available     

(defconstant $T_REPLY #x800)                    ;  An Incoming reply is available     

(defconstant $T_PASSCON #x1000)                 ;  State is now T_DATAXFER          

(defconstant $T_RESET #x2000)                   ;  Protocol has been reset          

(defconstant $kPRIVATEEVENT #x10000000)         ;  Base of the private event range.

(defconstant $kCOMPLETEEVENT #x20000000)        ;  Base of the completion event range.

(defconstant $T_BINDCOMPLETE #x20000001)        ;  Bind call is complete          

(defconstant $T_UNBINDCOMPLETE #x20000002)      ;  Unbind call is complete          

(defconstant $T_ACCEPTCOMPLETE #x20000003)      ;  Accept call is complete          

(defconstant $T_REPLYCOMPLETE #x20000004)       ;  SendReply call is complete        

(defconstant $T_DISCONNECTCOMPLETE #x20000005)  ;  Disconnect call is complete         

(defconstant $T_OPTMGMTCOMPLETE #x20000006)     ;  OptMgmt call is complete          

(defconstant $T_OPENCOMPLETE #x20000007)        ;  An Open call is complete          

(defconstant $T_GETPROTADDRCOMPLETE #x20000008) ;  GetProtAddress call is complete       

(defconstant $T_RESOLVEADDRCOMPLETE #x20000009) ;  A ResolveAddress call is complet     

(defconstant $T_GETINFOCOMPLETE #x2000000A)     ;  A GetInfo call is complete        

(defconstant $T_SYNCCOMPLETE #x2000000B)        ;  A Sync call is complete          

(defconstant $T_MEMORYRELEASED #x2000000C)      ;  No-copy memory was released         

(defconstant $T_REGNAMECOMPLETE #x2000000D)     ;  A RegisterName call is complete       

(defconstant $T_DELNAMECOMPLETE #x2000000E)     ;  A DeleteName call is complete   

(defconstant $T_LKUPNAMECOMPLETE #x2000000F)    ;  A LookupName call is complete   

(defconstant $T_LKUPNAMERESULT #x20000010)      ;  A LookupName is returning a name     

(defconstant $kOTSyncIdleEvent #x20000011)      ;  Synchronous call Idle event         

(defconstant $kSTREAMEVENT #x21000000)          ;  Base of the raw stream event range.

(defconstant $kOTReservedEvent1 #x21000001)     ;  reserved for internal use by OT       

(defconstant $kGetmsgEvent #x21000002)          ;  A GetMessage call is complete   

(defconstant $kStreamReadEvent #x21000003)      ;  A Read call is complete          

(defconstant $kStreamWriteEvent #x21000004)     ;  A Write call is complete          

(defconstant $kStreamIoctlEvent #x21000005)     ;  An Ioctl call is complete       

(defconstant $kOTReservedEvent2 #x21000006)     ;  reserved for internal use by OT       

(defconstant $kStreamOpenEvent #x21000007)      ;  An OpenStream call is complete     

(defconstant $kPollEvent #x21000008)            ;  A Poll call is complete          

(defconstant $kOTReservedEvent3 #x21000009)     ;  reserved for internal use by OT       

(defconstant $kOTReservedEvent4 #x2100000A)     ;  reserved for internal use by OT       

(defconstant $kOTReservedEvent5 #x2100000B)     ;  reserved for internal use by OT       

(defconstant $kOTReservedEvent6 #x2100000C)     ;  reserved for internal use by OT       

(defconstant $kOTReservedEvent7 #x2100000D)     ;  reserved for internal use by OT       

(defconstant $kOTReservedEvent8 #x2100000E)     ;  reserved for internal use by OT       

(defconstant $kSIGNALEVENT #x22000000)          ;  A signal has arrived on a raw stream, see "Signal Values" below.

(defconstant $kPROTOCOLEVENT #x23000000)        ;  Some event from the protocols   

(defconstant $kOTProviderIsDisconnected #x23000001);  Provider is temporarily off-line     

(defconstant $kOTProviderIsReconnected #x23000002);  Provider is now back on-line      

(defconstant $kOTProviderWillClose #x24000001)  ;  Provider will close immediately       

(defconstant $kOTProviderIsClosed #x24000002)   ;  Provider was closed              

(defconstant $kOTPortDisabled #x25000001)       ;  Port is now disabled, result is 0, cookie is port ref 

(defconstant $kOTPortEnabled #x25000002)        ;  Port is now enabled, result is 0, cookie is port ref 

(defconstant $kOTPortOffline #x25000003)        ;  Port is now offline, result is 0, cookie is port ref 

(defconstant $kOTPortOnline #x25000004)         ;  Port is now online, result is 0, cookie is port ref 

(defconstant $kOTClosePortRequest #x25000005)   ;  Request to close/yield, result is reason, cookie is OTPortCloseStruct* 

(defconstant $kOTYieldPortRequest #x25000005)   ;  Request to close/yield, result is reason, cookie is OTPortCloseStruct* 

(defconstant $kOTNewPortRegistered #x25000006)  ;  New port has been registered, cookie is port ref 

(defconstant $kOTPortNetworkChange #x25000007)  ;  Port may have moved to a new network, result is 0, cookie is port ref 

(defconstant $kOTConfigurationChanged #x26000001);  Protocol configuration changed     

(defconstant $kOTSystemSleep #x26000002)
(defconstant $kOTSystemShutdown #x26000003)
(defconstant $kOTSystemAwaken #x26000004)
(defconstant $kOTSystemIdle #x26000005)
(defconstant $kOTSystemSleepPrep #x26000006)
(defconstant $kOTSystemShutdownPrep #x26000007)
(defconstant $kOTSystemAwakenPrep #x26000008)
(defconstant $kOTStackIsLoading #x27000001)     ;  Sent before Open Transport attempts to load the TCP/IP protocol stack.

(defconstant $kOTStackWasLoaded #x27000002)     ;  Sent after the TCP/IP stack has been successfully loaded.

(defconstant $kOTStackIsUnloading #x27000003)   ;  Sent before Open Transport unloads the TCP/IP stack.

; 
;    The following event codes are used internally by Open Transport
;    but not documented to developers.  I had to remove them from the
;    above list because Interfacer won't let me put a hard conditional
;    inside an enum declaration.
; 

(defconstant $kOTDisablePortEvent #x21000001)
(defconstant $kStreamCloseEvent #x21000006)
(defconstant $kBackgroundStreamEvent #x21000009)
(defconstant $kIoctlRecvFdEvent #x2100000A)
(defconstant $kOTTryShutdownEvent #x2100000B)   ;  probably not used by current OT (2.5)

(defconstant $kOTScheduleTerminationEvent #x2100000C)
(defconstant $kOTEnablePortEvent #x2100000D)
(defconstant $kOTNewPortRegisteredEvent #x2100000E)
(defconstant $kOTPortOfflineEvent #x2100000F)
(defconstant $kOTPortOnlineEvent #x21000010)
(defconstant $kOTPortNetworkChangeEvent #x21000011)
;  ***** Event Classification Macros ***** 
; #define IsOTPrivateEvent(x)         (((x) & 0x70000000L) == kPRIVATEEVENT)
; #define IsOTCompleteEvent(x)     (((x) & 0x7f000000L) == kCOMPLETEEVENT)
; #define IsOTProtocolEvent(x)        (((x) & 0x7f000000L) == kPROTOCOLEVENT)
; #define IsOTStreamEvent(x)          (((x) & 0x7f000000L) == kSTREAMEVENT)
; #define IsOTSignalEvent(x)            (((x) & 0x7f000000L) == kSIGNALEVENT)
; #define GetOTEventCode(x)         (x)
; 
;    ***** Signal Values *****
;    Signals that are generated by a raw stream.  When writing a notifier
;    for a raw stream, add these values to kSIGNALEVENT to determine what
;    event you are receiving.
; 

(defconstant $kSIGHUP 1)
(defconstant $kSIGURG 16)
(defconstant $kSIGPOLL 30)
(defconstant $SIGHUP 1)
; #define SIGHUP  1
(defconstant $SIGURG 16)
; #define SIGURG  16
; 
;    ***** Notifier Type Definition *****
;    Open Transport notifiers must conform to the OTNotifyProcPtr prototype.
;    Even though a OTNotifyUPP is a OTNotifyProcPtr on pre-Carbon system,
;    use NewOTNotifyUPP() and friends to make your source code portable to OS X and Carbon.
; 

(def-mactype :OTNotifyProcPtr (find-mactype ':pointer)); (void * contextPtr , OTEventCode code , OTResult result , void * cookie)

(def-mactype :OTNotifyUPP (find-mactype '(:pointer :OpaqueOTNotifyProcPtr)))
; 
;  *  NewOTNotifyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewOTNotifyUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueOTNotifyProcPtr)
() )
; 
;  *  DisposeOTNotifyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeOTNotifyUPP" 
   ((userUPP (:pointer :OpaqueOTNotifyProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeOTNotifyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeOTNotifyUPP" 
   ((contextPtr :pointer)
    (code :UInt32)
    (result :SInt32)
    (cookie :pointer)
    (userUPP (:pointer :OpaqueOTNotifyProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  ***** Option Management Definitions *****
;  The XTI Level number of a protocol.

(defconstant $XTI_GENERIC #xFFFF)               ;  level for XTI options 


(def-mactype :OTXTILevel (find-mactype ':UInt32))
;  The XTI name of a protocol option.

(def-mactype :OTXTIName (find-mactype ':UInt32))
;  XTI names for options used with XTI_GENERIC above

(defconstant $XTI_DEBUG 1)
(defconstant $XTI_LINGER #x80)
(defconstant $XTI_RCVBUF #x1002)
(defconstant $XTI_RCVLOWAT #x1004)
(defconstant $XTI_SNDBUF #x1001)
(defconstant $XTI_SNDLOWAT #x1003)
(defconstant $XTI_PROTOTYPE #x1005)
(defconstant $OPT_CHECKSUM #x600)               ;  Set checksumming = UInt32 - 0 or 1)

(defconstant $OPT_RETRYCNT #x601)               ;  Set a retry counter = UInt32 (0 = infinite)

(defconstant $OPT_INTERVAL #x602)               ;  Set a retry interval = UInt32 milliseconds

(defconstant $OPT_ENABLEEOM #x603)              ;  Enable the EOM indication = UInt8 (0 or 1)

(defconstant $OPT_SELFSEND #x604)               ;  Enable Self-sending on broadcasts = UInt32 (0 or 1)

(defconstant $OPT_SERVERSTATUS #x605)           ;  Set Server Status (format is proto dependent)

(defconstant $OPT_ALERTENABLE #x606)            ;  Enable/Disable protocol alerts

(defconstant $OPT_KEEPALIVE 8)                  ;  See t_keepalive structure

;  ***** Ioctl Definitions *****
; 
;    All OT ioctl numbers are formed using the MIOC_CMD macro,
;    which divides the ioctl space by protocol space (the
;    first parameter) and ioctl number within that protocol
;    space (the second parameter).  This macro is only available
;    to C users but it's relatively easy to synthesise its
;    results in other languages.
; 
; #define MIOC_CMD(t,v)   ((((t)&0xFF) << 8) | ((v)&0xFF))
;  The following is a registry of the ioctls protocol spaces.

(defconstant $MIOC_STREAMIO 65)                 ;  Basic Stream ioctl() cmds - I_PUSH, I_LOOK, etc. 

(defconstant $MIOC_TMOD 97)                     ;  ioctl's for tmod test module    

(defconstant $MIOC_STRLOG 98)                   ;  ioctl's for Mentat's log device      

(defconstant $MIOC_ND 99)                       ;  ioctl's for Mentat's nd device        

(defconstant $MIOC_ECHO 100)                    ;  ioctl's for Mentat's echo device   

(defconstant $MIOC_TLI 101)                     ;  ioctl's for Mentat's timod module  

(defconstant $MIOC_RESERVEDf 102)               ;  reserved, used by SVR4 FIOxxx   

(defconstant $MIOC_SAD 103)                     ;  ioctl's for Mentat's sad module      

(defconstant $MIOC_ARP 104)                     ;  ioctl's for Mentat's arp module      

(defconstant $MIOC_HAVOC 72)                    ;  Havoc module ioctls.           

(defconstant $MIOC_RESERVEDi 105)               ;  reserved, used by SVR4 SIOCxxx     

(defconstant $MIOC_SIOC 106)                    ;  sockio.h socket ioctl's           

(defconstant $MIOC_TCP 107)                     ;  tcp.h ioctl's                

(defconstant $MIOC_DLPI 108)                    ;  dlpi.h additions             

(defconstant $MIOC_SOCKETS 109)                 ;  Mentat sockmod ioctl's           

(defconstant $MIOC_IPX 111)                     ;  ioctls for IPX               

(defconstant $MIOC_OT 79)                       ;  ioctls for Open Transport       

(defconstant $MIOC_ATALK 84)                    ;  ioctl's for AppleTalk          

(defconstant $MIOC_SRL 85)                      ;  ioctl's for Serial           

(defconstant $MIOC_RESERVEDp 112)               ;  reserved, used by SVR4          

(defconstant $MIOC_RESERVEDr 114)               ;  reserved, used by SVR4          

(defconstant $MIOC_RESERVEDs 115)               ;  reserved, used by SVR4          

(defconstant $MIOC_CFIG 122)                    ;  ioctl's for private configuration 

;  OT specific ioctls.

(defconstant $I_OTGetMiscellaneousEvents #x4F01);  sign up for Misc Events              

(defconstant $I_OTSetFramingType #x4F02)        ;  Set framing option for link          

(defconstant $kOTGetFramingValue #xFFFFFFFF)    ;  Use this value to read framing        

(defconstant $I_OTSetRawMode #x4F03)            ;  Set raw mode for link            

(defconstant $kOTSetRecvMode 1)
(defconstant $kOTSendErrorPacket 2)
(defconstant $I_OTConnect #x4F04)               ;  Generic connect request for links   

(defconstant $I_OTDisconnect #x4F05)            ;  Generic disconnect request for links     
;  Send a script to a module          

(defconstant $I_OTScript #x4F06)
;  Structure for the I_OTScript Ioctl.
(defrecord OTScriptInfo
   (fScriptType :UInt32)
   (fTheScript :pointer)
   (fScriptLength :UInt32)
)

;type name? (%define-record :OTScriptInfo (find-record-descriptor ':OTScriptInfo))
; 
;    ***** XTI States *****
;    These are the potential values returned by OTGetEndpointState and OTSync
;    which represent the XTI state of an endpoint.
; 

(def-mactype :OTXTIStates (find-mactype ':UInt32))

(defconstant $T_UNINIT 0)                       ;  addition to standard xti.h 

(defconstant $T_UNBND 1)                        ;  unbound                 

(defconstant $T_IDLE 2)                         ;  idle                

(defconstant $T_OUTCON 3)                       ;  outgoing connection pending    

(defconstant $T_INCON 4)                        ;  incoming connection pending    

(defconstant $T_DATAXFER 5)                     ;  data transfer          

(defconstant $T_OUTREL 6)                       ;  outgoing orderly release     

(defconstant $T_INREL 7)                        ;  incoming orderly release     

; 
;    ***** General XTI Definitions *****
;    These definitions are typically used during option management.
; 

(defconstant $T_YES 1)
(defconstant $T_NO 0)
(defconstant $T_UNUSED -1)
(defconstant $kT_NULL 0)
(defconstant $T_ABSREQ #x8000)

(defconstant $kT_UNSPEC #xFFFFFFFD)
(defconstant $T_ALLOPT 0)
; 
;    T_NULL and T_UNSPEC have different values in BSD headers.  If you want the
;    OT values, use kT_NULL or kT_UNSPEC.
; 
; 
;    ***** OTConfiguration *****
;    This is a "black box" structure used to define the configuration of a
;    provider or endpoint.  This file defines a very limited set of operations
;    on a configuration.  "OpenTransportClient.h" extends this with extra
;    operations used by protocol stacks but not typically needed by clients.
; 
; #ifdef __cplusplus
#| #|
typedef class OTConfiguration*          OTConfigurationRef;
|#
 |#

; #else

(def-mactype :OTConfigurationRef (find-mactype '(:pointer :OTConfiguration)))

; #endif

(defconstant $kOTNoMemoryConfigurationPtr 0)
; #define kOTNoMemoryConfigurationPtr     ((OTConfigurationRef)0L)
; #define kOTInvalidConfigurationPtr      ((OTConfigurationRef)-1L)
;  ***** Option Management Structures *****
;  This structure describes the contents of a single option in a buffer.
(defrecord TOptionHeader
   (len :UInt32)                                ;  total length of option          
                                                ;  = sizeof(TOptionHeader) + length     
                                                ;      of option value in bytes       
   (level :UInt32)                              ;  protocol affected            
   (name :UInt32)                               ;  option name                   
   (status :UInt32)                             ;  status value                
)

;type name? (%define-record :TOptionHeader (find-record-descriptor ':TOptionHeader))
; 
;    This structure describes the contents of a single option in a buffer.
;    It differs from TOptionHeader in that it includes the value field,
;    which acts as an unbounded array representing the value of the option.
; 
(defrecord TOption
   (len :UInt32)                                ;  total length of option          
                                                ;  = sizeof(TOption) + length 
                                                ;      of option value in bytes       
   (level :UInt32)                              ;  protocol affected            
   (name :UInt32)                               ;  option name                   
   (status :UInt32)                             ;  status value                
   (value (:array :UInt32 1))                   ;  data goes here               
)

;type name? (%define-record :TOption (find-record-descriptor ':TOption))
;  Some useful constants when manipulating option buffers.

(defconstant $kOTOptionHeaderSize 16)
(defconstant $kOTBooleanOptionDataSize 4)
(defconstant $kOTBooleanOptionSize 20)
(defconstant $kOTOneByteOptionSize 17)
(defconstant $kOTTwoByteOptionSize 18)
(defconstant $kOTFourByteOptionSize 20)
; 
;     This macro will align return the value of "len", rounded up to the next
;     4-byte boundary.
; 
; #define T_ALIGN(len) (((UInt32)(len)+(sizeof(SInt32)-1)) & ~(sizeof(SInt32)-1))
; 
;    This macro will return the next option in the buffer, given the previous option
;     in the buffer, returning NULL if there are no more.
;     You start off by setting prevOption = (TOption*)theBuffer
;   (Use OTNextOption for a more thorough check - it ensures the end
;    of the option is in the buffer as well.)
; 
; #define OPT_NEXTHDR(theBuffer, theBufLen, prevOption)    (((char*)(prevOption) + T_ALIGN((prevOption)->len) < (char*)(theBuffer) + (theBufLen)) ?              (TOption*)((char*)(prevOption)+T_ALIGN((prevOption)->len))            : (TOption*)NULL)
;  t_kpalive is used with OPT_KEEPALIVE option.
(defrecord t_kpalive
   (kp_onoff :SInt32)                           ;  option on/off   
   (kp_timeout :SInt32)                         ;  timeout in minutes 
)

;type name? (%define-record :t_kpalive (find-record-descriptor ':t_kpalive))
;  t_linger is used with XTI_LINGER option.
(defrecord t_linger
   (l_onoff :SInt32)                            ;  option on/off 
   (l_linger :SInt32)                           ;  linger time 
)

;type name? (%define-record :t_linger (find-record-descriptor ':t_linger))
; 
;    ***** TEndpointInfo *****
;    This structure is returned from the GetEndpointInfo call and contains
;    information about an endpoint.  But first, some special flags and types.
; 
;  Values returned in servtype field of TEndpointInfo.

(def-mactype :OTServiceType (find-mactype ':UInt32))

(defconstant $T_COTS 1)                         ;  Connection-mode service                    

(defconstant $T_COTS_ORD 2)                     ;  Connection service with orderly release          

(defconstant $T_CLTS 3)                         ;  Connectionless-mode service                   

(defconstant $T_TRANS 5)                        ;  Connection-mode transaction service              

(defconstant $T_TRANS_ORD 6)                    ;  Connection transaction service with orderly release    

(defconstant $T_TRANS_CLTS 7)                   ;  Connectionless transaction service           

;  Masks for the flags field of TEndpointInfo.

(defconstant $T_SENDZERO 1)                     ;  supports 0-length TSDU's          

(defconstant $T_XPG4_1 2)                       ;  supports the GetProtAddress call     

(defconstant $T_CAN_SUPPORT_MDATA #x10000000)   ;  support M_DATAs on packet protocols    

(defconstant $T_CAN_RESOLVE_ADDR #x40000000)    ;  Supports ResolveAddress call      

(defconstant $T_CAN_SUPPLY_MIB #x20000000)      ;  Supports SNMP MIB data          

; 
;    Special-case values for in the tsdu, etsdu, connect, and discon
;    fields of TEndpointInfo.
; 

(defconstant $T_INFINITE -1)                    ;  supports infinit amounts of data     
;  Does not support data transmission 

(defconstant $T_INVALID -2)

(def-mactype :OTDataSize (find-mactype ':SInt32))
;  Now the TEndpointInfo structure proper.
(defrecord TEndpointInfo
   (addr :SInt32)                               ;  Maximum size of an address        
   (options :SInt32)                            ;  Maximum size of options          
   (tsdu :SInt32)                               ;  Standard data transmit unit size     
   (etsdu :SInt32)                              ;  Expedited data transmit unit size  
   (connect :SInt32)                            ;  Maximum data size on connect      
   (discon :SInt32)                             ;  Maximum data size on disconnect       
   (servtype :UInt32)                           ;  service type                
   (flags :UInt32)                              ;  Flags (see above for values)      
)

;type name? (%define-record :TEndpointInfo (find-record-descriptor ':TEndpointInfo))
; 
;    "OpenTransport.h" no longer defines "struct t_info".  We recommend
;    that you use TEndpointInfo instead.  If this is impossible, use
;    the definition of "struct t_info" in "OpenTransportXTI.h".
; 
;  ***** OTPortRecord *****
;  Unique identifier for a port.

(def-mactype :OTPortRef (find-mactype ':UInt32))

(def-mactype :OTPortRefPtr (find-mactype '(:pointer :UInt32)))

(defconstant $kOTInvalidPortRef 0)
;  Valid values for the bus type element of an OTPortRef.

(def-mactype :OTBusType (find-mactype ':UInt8))

(defconstant $kOTUnknownBusPort 0)
(defconstant $kOTMotherboardBus 1)
(defconstant $kOTNuBus 2)
(defconstant $kOTPCIBus 3)
(defconstant $kOTGeoPort 4)
(defconstant $kOTPCCardBus 5)
(defconstant $kOTFireWireBus 6)
(defconstant $kOTLastBusIndex 15)
; 
;    A couple of special values for the device type element of an
;    OTPortRef.  See "OpenTransportDevices.h" for the standard values.
; 

(def-mactype :OTDeviceType (find-mactype ':UInt16))

(defconstant $kOTNoDeviceType 0)
(defconstant $kOTADEVDevice 1)                  ;  An Atalk ADEV   

(defconstant $kOTMDEVDevice 2)                  ;  A TCP/IP MDEV   

(defconstant $kOTLocalTalkDevice 3)             ;  LocalTalk       

(defconstant $kOTIRTalkDevice 4)                ;  IRTalk          

(defconstant $kOTTokenRingDevice 5)             ;  Token Ring        

(defconstant $kOTISDNDevice 6)                  ;  ISDN             

(defconstant $kOTATMDevice 7)                   ;  ATM              

(defconstant $kOTSMDSDevice 8)                  ;  SMDS             

(defconstant $kOTSerialDevice 9)                ;  Serial           

(defconstant $kOTEthernetDevice 10)             ;  Ethernet          

(defconstant $kOTSLIPDevice 11)                 ;  SLIP Pseudo-device 

(defconstant $kOTPPPDevice 12)                  ;  PPP Pseudo-device  

(defconstant $kOTModemDevice 13)                ;  Modem Pseudo-Device    

(defconstant $kOTFastEthernetDevice 14)         ;  100 MB Ethernet       

(defconstant $kOTFDDIDevice 15)                 ;  FDDI             

(defconstant $kOTIrDADevice 16)                 ;  IrDA Infrared   

(defconstant $kOTATMSNAPDevice 17)              ;  ATM SNAP emulation 

(defconstant $kOTFibreChannelDevice 18)         ;  Fibre Channel   

(defconstant $kOTFireWireDevice 19)             ;  FireWire link Device   

(defconstant $kOTPseudoDevice #x3FF)            ;  used where no other defined device type will work

(defconstant $kOTLastDeviceIndex #x3FE)
;  Special case values for the slot number element of an OTPortRef.

(defconstant $kOTLastSlotNumber #xFF)
(defconstant $kOTLastOtherNumber #xFF)

(def-mactype :OTSlotNumber (find-mactype ':UInt16))
;  Accessor functions for the various elements of the OTPortRef.
; 
;  *  OTCreatePortRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTCreatePortRef" 
   ((busType :UInt8)
    (devType :UInt16)
    (slot :UInt16)
    (other :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  OTGetDeviceTypeFromPortRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTGetDeviceTypeFromPortRef" 
   ((ref :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt16
() )
; 
;  *  OTGetBusTypeFromPortRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTGetBusTypeFromPortRef" 
   ((ref :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt16
() )
; 
;  *  OTGetSlotFromPortRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTGetSlotFromPortRef" 
   ((ref :UInt32)
    (other (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt16
() )
; 
;  *  OTSetDeviceTypeInPortRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTSetDeviceTypeInPortRef" 
   ((ref :UInt32)
    (devType :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  OTSetBusTypeInPortRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTSetBusTypeInPortRef" 
   ((ref :UInt32)
    (busType :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;     Convenience macros for generating specific types of OTPortRefs.
; 
; #define OTCreateNuBusPortRef(devType, slot, other)    OTCreatePortRef(kOTNuBus, devType, slot, other)
; #define OTCreatePCIPortRef(devType, slot, other)     OTCreatePortRef(kOTPCIBus, devType, slot, other)
; #define OTCreatePCCardPortRef(devType, slot, other)      OTCreatePortRef(kOTPCCardBus, devType, slot, other)
;  Name length definitions for various fields in OTPortRecord.

(defconstant $kMaxModuleNameLength 31)          ;  max length of a STREAMS module name

(defconstant $kMaxModuleNameSize 32)
(defconstant $kMaxProviderNameLength 35)        ;  providers allow 4 characters for minor number

(defconstant $kMaxProviderNameSize 36)
(defconstant $kMaxSlotIDLength 7)               ;  PCI slot names tend to be short

(defconstant $kMaxSlotIDSize 8)
(defconstant $kMaxResourceInfoLength 31)        ;  max length of a configuration helper name

(defconstant $kMaxResourceInfoSize 32)
(defconstant $kMaxPortNameLength 35)            ;  max size allowed to define a port

(defconstant $kMaxPortNameSize 36)
; 
;    Masks for the fPortFlags field of OTPortRecord
;    If no bits are set, the port is currently inactive.
; 

(defconstant $kOTPortIsActive 1)
(defconstant $kOTPortIsDisabled 2)
(defconstant $kOTPortIsUnavailable 4)
(defconstant $kOTPortIsOffline 8)
;  Masks for the fInfoFlags field of the OTPortRecord.

(defconstant $kOTPortIsDLPI 1)
(defconstant $kOTPortIsTPI 2)
(defconstant $kOTPortCanYield 4)                ;  will not be set until the port is used for the first time

(defconstant $kOTPortCanArbitrate 8)            ;  will not be set until the port is used for the first time

(defconstant $kOTPortIsTransitory 16)
(defconstant $kOTPortAutoConnects 32)
(defconstant $kOTPortIsSystemRegistered #x4000)
(defconstant $kOTPortIsPrivate #x8000)
(defconstant $kOTPortIsAlias #x80000000)
; 
;    One OTPortRecord is created for each instance of a port.
;    For Instance 'enet' identifies an ethernet port.
;    A OTPortRecord for each ethernet card it finds, with an
;    OTPortRef that will uniquely allow the driver to determine which
;    port it is supposed to open on.
; 
(defrecord OTPortRecord
   (fRef :UInt32)
   (fPortFlags :UInt32)
   (fInfoFlags :UInt32)
   (fCapabilities :UInt32)
   (fNumChildPorts :UInt32)
   (fChildPorts (:pointer :OTPortRef))
   (fPortName (:array :character 36))
   (fModuleName (:array :character 32))
   (fSlotID (:array :character 8))
   (fResourceInfo (:array :character 32))
   (fReserved (:array :character 164))
)

;type name? (%define-record :OTPortRecord (find-record-descriptor ':OTPortRecord))
; 
;    Routines for finding, registering and unregistering ports.
;    IMPORTANT:
;    These routines have two versions, one for the client and one
;    for the kernel.  Make sure you use and link with the right ones.
; 

; #if !OTKERNEL
; 
;  *  OTGetIndexedPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientUtilLib 1.0 and later
;  

(deftrap-inline "_OTGetIndexedPort" 
   ((portRecord (:pointer :OTPortRecord))
    (index :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  Index through the ports in the system
; 
;  *  OTFindPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientUtilLib 1.0 and later
;  

(deftrap-inline "_OTFindPort" 
   ((portRecord (:pointer :OTPortRecord))
    (portName (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  Find an OTPortRecord for a port using it's name
; 
;  *  OTFindPortByRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientUtilLib 1.0 and later
;  

(deftrap-inline "_OTFindPortByRef" 
   ((portRecord (:pointer :OTPortRecord))
    (ref :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  Find an OTPortRecord for a port using it's OTPortRef
; 
;  *  OTRegisterPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientUtilLib 1.0 and later
;  
; 
;    Register a port. The name the port was registered under is returned in
;    the fPortName field.
; 
; 
;  *  OTUnregisterPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientUtilLib 1.0 and later
;  
; 
;    Unregister the port with the given name (If you re-register the
;    port, it may get a different name - use OTChangePortState if
;    that is not desireable).  Since a single OTPortRef can be registered
;    with several names, the API needs to use the portName rather than
;    the OTPortRef to disambiguate.
; 
; 
;  *  OTChangePortState()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientUtilLib 1.0 and later
;  
;  Change the state of the port.

; #endif  /* !OTKERNEL */

;  ***** Data Buffers *****
; 
;    TNetbuf is the basic structure used to pass data back and forth
;    between the Open Transport protocols and their clients
; 
(defrecord TNetbuf
   (maxlen :UInt32)
   (len :UInt32)
   (buf (:pointer :UInt8))
)

;type name? (%define-record :TNetbuf (find-record-descriptor ':TNetbuf))
; 
;    Some rarely used low-level routines in this file take a strbuf
;    as a parameter.  This is the raw streams equivalent of a TNetbuf.
;    The key difference is that the maxlen and len fields are signed,
;    which allows you to specify extra operations by providing a
;    negative value.
; 
(defrecord strbuf
   (maxlen :SInt32)                             ;  max buffer length 
   (len :SInt32)                                ;  length of data 
   (buf (:pointer :char))                       ;  pointer to buffer 
)

;type name? (%define-record :strbuf (find-record-descriptor ':strbuf))
; 
;    OTData is used in a TNetbuf or netbuf to send
;    non-contiguous data.  Set the 'len' field of the netbuf to the
;    constant kNetbufDataIsOTData to signal that the 'buf' field of the
;    netbuf actually points to one of these structures instead of a
;    memory buffer.
; 
(defrecord OTData
   (fNext :pointer)
   (fData :pointer)
   (fLen :UInt32)
)

;type name? (%define-record :OTData (find-record-descriptor ':OTData))

(defconstant $kNetbufDataIsOTData #xFFFFFFFE)
; 
;    OTBuffer is used for no-copy receives.  When receiving, you can
;    set the receive length to kOTNetbufDataIsOTBufferStar and then
;    pass the address of an OTBuffer* as the receive buffer.  OT will
;    fill it out to point to a chain of OTBuffers.
;    When you are done with it, you must call the OTReleaseBuffer function.
;    For best performance, you need to call OTReleaseBuffer quickly.
;    Only data netbufs may use this - no netbufs for addresses or options, or the like.
;    Any OTBuffer returned to you by OT is read only!
;    The astute will notice that this has a high correlation with the
;    STREAMS msgb data type.  The fields are commented with their
;    corresponding msgb field name.
; 
(defrecord OTBuffer
   (fLink :pointer)                             ;  b_next
   (fLink2 :pointer)                            ;  b_prev
   (fNext (:pointer :otbuffer))                 ;  b_cont
   (fData (:pointer :UInt8))                    ;  b_rptr
   (fLen :UInt32)                               ;  b_wptr
   (fSave :pointer)                             ;  b_datap
   (fBand :UInt8)                               ;  b_band
   (fType :UInt8)                               ;  b_pad1
   (fPad1 :UInt8)
   (fFlags :UInt8)                              ;  b_flag
)

;type name? (%define-record :OTBuffer (find-record-descriptor ':OTBuffer))

(defconstant $kOTNetbufDataIsOTBufferStar #xFFFFFFFD)
; 
;    OTBufferInfo is used with OTReadBuffer to keep track of where you
;    are in the buffer, since the OTBuffer is "read-only".
; 
;  Use the OTInitBuffer macro to initialise this structure from an OTBuffer chain.
(defrecord OTBufferInfo
   (fBuffer (:pointer :OTBuffer))
   (fOffset :UInt32)
   (fPad :UInt8)
)

;type name? (%define-record :OTBufferInfo (find-record-descriptor ':OTBufferInfo))
; #define OTInitBufferInfo(infoPtr, theBuffer)     (infoPtr)->fBuffer = theBuffer;               (infoPtr)->fPad = (theBuffer)->fPad1;         (infoPtr)->fOffset  = 0
; 
;    If the endpoint supports "raw mode" (the T_CAN_SUPPORT_MDATA bit will
;    be set in the TEndpointInfo::flags field), then you specify the
;    raw mode packet by putting the kOTNetbufIsRawMode value in
;    the udata.addr.len field when calling OTSndUData and also set the
;    udata.opt.len, udata.opt.buf, and udata.addr.buf fields to 0.
; 

(defconstant $kOTNetbufIsRawMode #xFFFFFFFF)
; 
;    ***** Standard XTI Parameter Types *****
;    These structures are all used as parameters to the standard
;    XTI routines.
; 
; 
;    TBind holds binding information for calls to
;    OTGetProtAddress, OTResolveAddress and OTBind.
; 
(defrecord TBind
   (addr :TNetbuf)
   (qlen :UInt32)
)

;type name? (%define-record :TBind (find-record-descriptor ':TBind))
; 
;    TDiscon is passed to RcvDisconnect to find out additional information
;    about the disconnect.
; 
(defrecord TDiscon
   (udata :TNetbuf)
   (reason :SInt32)
   (sequence :SInt32)
)

;type name? (%define-record :TDiscon (find-record-descriptor ':TDiscon))
; 
;    TCall holds information about a connection and is a parameter to
;    OTConnect, OTRcvConnect, OTListen, OTAccept, and OTSndDisconnect.
; 
(defrecord TCall
   (addr :TNetbuf)
   (opt :TNetbuf)
   (udata :TNetbuf)
   (sequence :SInt32)
)

;type name? (%define-record :TCall (find-record-descriptor ':TCall))
;  TUnitData describes a datagram in calls to OTSndUData and OTRcvUData.
(defrecord TUnitData
   (addr :TNetbuf)
   (opt :TNetbuf)
   (udata :TNetbuf)
)

;type name? (%define-record :TUnitData (find-record-descriptor ':TUnitData))
; 
;    TUDErr is used to get information about a datagram error using
;    OTRcvUDErr.
; 
(defrecord TUDErr
   (addr :TNetbuf)
   (opt :TNetbuf)
   (error :SInt32)
)

;type name? (%define-record :TUDErr (find-record-descriptor ':TUDErr))
;  TOptMgmt is passed to the OTOptionManagement call to read or set protocol
(defrecord TOptMgmt
   (opt :TNetbuf)
   (flags :UInt32)
)

;type name? (%define-record :TOptMgmt (find-record-descriptor ':TOptMgmt))
; 
;    ***** Transactional XTI Parameter Types *****
;    These structures are all used as parameters to the OT's
;    XTI-like routines for transaction protocols.
; 
; 
;    TRequest is passed to OTSndRequest and OTRcvRequest that contains the information
;    about the request.
; 
(defrecord TRequest
   (data :TNetbuf)
   (opt :TNetbuf)
   (sequence :SInt32)
)

;type name? (%define-record :TRequest (find-record-descriptor ':TRequest))
;  TReply is passed to OTSndReply to send a reply to an incoming request.
(defrecord TReply
   (data :TNetbuf)
   (opt :TNetbuf)
   (sequence :SInt32)
)

;type name? (%define-record :TReply (find-record-descriptor ':TReply))
; 
;    TUnitRequest is passed to OTSndURequest and OTRcvURequest that contains
;    the information about the request.
; 
(defrecord TUnitRequest
   (addr :TNetbuf)
   (opt :TNetbuf)
   (udata :TNetbuf)
   (sequence :SInt32)
)

;type name? (%define-record :TUnitRequest (find-record-descriptor ':TUnitRequest))
;  TUnitReply is passed to OTSndUReply to send a reply to an incoming request.
(defrecord TUnitReply
   (opt :TNetbuf)
   (udata :TNetbuf)
   (sequence :SInt32)
)

;type name? (%define-record :TUnitReply (find-record-descriptor ':TUnitReply))
; 
;    ***** Mapper Parameter Types *****
;    These structures are all used as parameters to the OT's
;    mapper routines.
; 
;  TRegisterRequest holds the name to register in a call to OTRegisterName.
(defrecord TRegisterRequest
   (name :TNetbuf)
   (addr :TNetbuf)
   (flags :UInt32)
)

;type name? (%define-record :TRegisterRequest (find-record-descriptor ':TRegisterRequest))
; 
;    TRegisterReply returns information about the registered name in a call
;    to OTRegisterName.
; 
(defrecord TRegisterReply
   (addr :TNetbuf)
   (nameid :SInt32)
)

;type name? (%define-record :TRegisterReply (find-record-descriptor ':TRegisterReply))
;  TLookupRequest holds the name to look up in a call to OTLookupName.
(defrecord TLookupRequest
   (name :TNetbuf)
   (addr :TNetbuf)
   (maxcnt :UInt32)
   (timeout :UInt32)
   (flags :UInt32)
)

;type name? (%define-record :TLookupRequest (find-record-descriptor ':TLookupRequest))
; 
;    TLookupReply returns information about the found names after a call
;    to OTLookupName.
; 
(defrecord TLookupReply
   (names :TNetbuf)
   (rspcount :UInt32)
)

;type name? (%define-record :TLookupReply (find-record-descriptor ':TLookupReply))
; 
;    TLookupBuffer describes the contents of the names buffer pointed
;    to by the TLookupReply.
; 
(defrecord TLookupBuffer
   (fAddressLength :UInt16)
   (fNameLength :UInt16)
   (fAddressBuffer (:array :UInt8 1))
)

;type name? (%define-record :TLookupBuffer (find-record-descriptor ':TLookupBuffer))
; 
;     OTNextLookupBuffer allows you to step through a packed array
;    of TLookupBuffers.
; 
; #define OTNextLookupBuffer(buf)            ((TLookupBuffer*)                         ((char*)buf + ((OTOffsetOf(TLookupBuffer, fAddressBuffer) + buf->fAddressLength + buf->fNameLength + 3) & ~3)))
;  ***** Initializing and Shutting Down Open Transport *****

; #if !OTKERNEL

(def-mactype :OTClientContextPtr (find-mactype '(:pointer :OpaqueOTClientContextPtr)))
; 
;    For Carbon the InitOpenTransport interface has changed so it takes a flags parameter 
;    and returns a client context pointer.
;    The flag passed to indicates whether OT should be initialized for application use or for some other target
;    (for example, plugins that run in an application context but not the application itself.)
;    Applications that are not interested in the value of the client context pointer may pass NULL
;    as outClientContext -- they will pass NULL to other routines that take a OTClientContextPtr.
; 

(def-mactype :OTInitializationFlags (find-mactype ':UInt32))

(defconstant $kInitOTForApplicationMask 1)
(defconstant $kInitOTForExtensionMask 2)
; 
;  *  InitOpenTransportInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InitOpenTransportInContext" 
   ((flags :UInt32)
    (outClientContext (:pointer :OTCLIENTCONTEXTPTR));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    Under Carbon, CloseOpenTransport takes a client context pointer.  Applications may pass NULL
;    after calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
;    valid client context.
; 
; 
;  *  CloseOpenTransportInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CloseOpenTransportInContext" 
   ((clientContext (:pointer :OpaqueOTClientContextPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InitOpenTransport()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  InitOpenTransportUtilities()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CloseOpenTransport()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTRegisterAsClient()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;    This registers yourself as a client for any miscellaneous Open Transport
;    notifications that come along. CloseOpenTransport will automatically do
;    an OTUnregisterAsClient, if you have not already done so.
; 
; 
;  *  OTUnregisterAsClient()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTRegisterAsClientInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTRegisterAsClientInContext" 
   ((name (:pointer :UInt8))
    (proc (:pointer :OpaqueOTNotifyProcPtr))
    (clientContext (:pointer :OpaqueOTClientContextPtr));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTUnregisterAsClientInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTUnregisterAsClientInContext" 
   ((clientContext (:pointer :OpaqueOTClientContextPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )

; #if OTCARBONAPPLICATION
#|                                              ;  The following macro may be used by applications only.
; #define InitOpenTransport() InitOpenTransportInContext(kInitOTForApplicationMask, NULL)
; #define CloseOpenTransport() CloseOpenTransportInContext(NULL)
; #define OTRegisterAsClient(name, proc) OTRegisterAsClientInContext(name, proc, NULL)
; #define OTUnregisterAsClient() OTUnregisterAsClientInContext(NULL)
 |#

; #endif  /* OTCARBONAPPLICATION */


; #endif  /* !OTKERNEL */

;  ***** Tasking Model *****
; 
;    OTEnterInterrupt/OTLeaveInterrupt are normally used within the kernel to
;    tell Open Transport we're at hardware interrupt time.  Clients can also
;    them to do the same.
; 
; 
;  *  OTEnterInterrupt()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTLeaveInterrupt()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTIsAtInterruptLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTCanLoadLibraries()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;    All OT task callbacks use the same prototype, shown below.
;    This is only a UPP for CFM-68K clients.
; 

(def-mactype :OTProcessProcPtr (find-mactype ':pointer)); (void * arg)

(def-mactype :OTProcessUPP (find-mactype '(:pointer :OpaqueOTProcessProcPtr)))
; 
;  *  NewOTProcessUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewOTProcessUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueOTProcessProcPtr)
() )
; 
;  *  DisposeOTProcessUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeOTProcessUPP" 
   ((userUPP (:pointer :OpaqueOTProcessProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeOTProcessUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeOTProcessUPP" 
   ((arg :pointer)
    (userUPP (:pointer :OpaqueOTProcessProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

; #if !OTKERNEL
; 
;    Under Carbon, OTCreateDeferredTask takes a client context pointer.  Applications may pass NULL
;    after calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
;    valid client context.
; 
; 
;  *  OTCreateDeferredTaskInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTCreateDeferredTaskInContext" 
   ((upp (:pointer :OpaqueOTProcessProcPtr))
    (arg :pointer)
    (clientContext (:pointer :OpaqueOTClientContextPtr));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )

; #endif  /* !OTKERNEL */

; 
;    OT deferred tasks are often more convenience that standard Mac OS
;    although they have no significant advantages beyond convenience.
; 

(def-mactype :OTDeferredTaskRef (find-mactype ':signed-long))
; 
;  *  OTCreateDeferredTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTScheduleDeferredTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTScheduleDeferredTask" 
   ((dtCookie :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OTScheduleInterruptTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTDestroyDeferredTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTDestroyDeferredTask" 
   ((dtCookie :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )

; #if OTCARBONAPPLICATION
#|                                              ;  The following macro may be used by applications only.
; #define OTCreateDeferredTask(upp, arg) OTCreateDeferredTaskInContext(upp, arg, NULL)
 |#

; #endif  /* OTCARBONAPPLICATION */


; #if !OTKERNEL
; 
;    OT system tasks allow you to schedule a procedure to be called
;    at system task time.  Potentially useful, but it relies on someone
;    calling SystemTask (or WaitNextEvent, which calls SystemTask).
;    Not available to kernel code because relying on system task time
;    to make progress is likely to result in deadlocks.
; 

(def-mactype :OTSystemTaskRef (find-mactype ':signed-long))
; 
;  *  OTCreateSystemTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTDestroySystemTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTScheduleSystemTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTCancelSystemTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTCanMakeSyncCall()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTCanMakeSyncCall" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )

; #endif  /* !OTKERNEL */

;  ***** Interface to Providers *****

; #if !OTKERNEL
; 
;  *  OTAsyncOpenProvider()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTOpenProvider()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCloseProvider()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTCloseProvider" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTTransferProviderOwnership()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTWhoAmI()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTGetProviderPortRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTIoctl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTIoctl" 
   ((ref (:pointer :void))
    (cmd :UInt32)
    (data :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  OTGetMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTGetPriorityMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTPutMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTPutPriorityMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTSetAsynchronous()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTSetAsynchronous" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTSetSynchronous()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTSetSynchronous" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTIsSynchronous()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTIsSynchronous" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OTSetBlocking()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTSetBlocking" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTSetNonBlocking()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTSetNonBlocking" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTIsBlocking()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTIsBlocking" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OTInstallNotifier()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTInstallNotifier" 
   ((ref (:pointer :void))
    (proc (:pointer :OpaqueOTNotifyProcPtr))
    (contextPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTUseSyncIdleEvents()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTUseSyncIdleEvents" 
   ((ref (:pointer :void))
    (useEvents :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTRemoveNotifier()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTRemoveNotifier" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTLeaveNotifier()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTLeaveNotifier" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTEnterNotifier()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTEnterNotifier" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OTAckSends()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTAckSends" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTDontAckSends()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTDontAckSends" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTIsAckingSends()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTIsAckingSends" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OTCancelSynchronousCalls()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTCancelSynchronousCalls" 
   ((ref (:pointer :void))
    (err :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #define OTIsNonBlocking(ref)   (!OTIsBlocking(ref))
; #define OTIsAsynchronous(ref)  (!OTIsSynchronous(ref))

; #endif  /* !OTKERNEL */

;  ***** Interface to Endpoints *****

; #if !OTKERNEL
;  Open/Close
; 
;    Under Carbon, the OpenEndpoint routines take a client context pointer.  Applications may pass NULL after
;    calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
;    valid client context.
; 
; 
;  *  OTOpenEndpointInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTOpenEndpointInContext" 
   ((config (:pointer :OTConfiguration))
    (oflag :UInt32)
    (info (:pointer :TEndpointInfo))            ;  can be NULL 
    (err (:pointer :OSStatus))
    (clientContext (:pointer :OpaqueOTClientContextPtr));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :void)
() )
; 
;  *  OTAsyncOpenEndpointInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTAsyncOpenEndpointInContext" 
   ((config (:pointer :OTConfiguration))
    (oflag :UInt32)
    (info (:pointer :TEndpointInfo))            ;  can be NULL 
    (upp (:pointer :OpaqueOTNotifyProcPtr))
    (contextPtr :pointer)
    (clientContext (:pointer :OpaqueOTClientContextPtr));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTOpenEndpoint()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTAsyncOpenEndpoint()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #if OTCARBONAPPLICATION
#|                                              ;  The following macros may be used by applications only.
; #define OTOpenEndpoint(config, oflag, info, err)  OTOpenEndpointInContext(config, oflag, info, err, NULL)
; #define OTAsyncOpenEndpoint(config, oflag, info, proc, contextPtr)  OTAsyncOpenEndpointInContext(config, oflag, info, proc, contextPtr, NULL)
 |#

; #endif  /* OTCARBONAPPLICATION */

;  Misc Information
; 
;  *  OTGetEndpointInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTGetEndpointInfo" 
   ((ref (:pointer :void))
    (info (:pointer :TEndpointInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTGetEndpointState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTGetEndpointState" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  OTLook()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTLook" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  OTSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTCountDataBytes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTCountDataBytes" 
   ((ref (:pointer :void))
    (countPtr (:pointer :OTBYTECOUNT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  OTGetProtAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTGetProtAddress" 
   ((ref (:pointer :void))
    (boundAddr (:pointer :TBind))               ;  can be NULL 
    (peerAddr (:pointer :TBind))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTResolveAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTResolveAddress" 
   ((ref (:pointer :void))
    (reqAddr (:pointer :TBind))
    (retAddr (:pointer :TBind))
    (timeOut :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Allocating structures
; 
;    Note:
;    In general, Apple recommends that you avoid the OTAlloc call because
;    using it extensively causes your program to allocate and deallocate
;    many memory blocks, with each extra memory allocation costing time.
; 
; 
;    Under Carbon, OTAlloc takes a client context pointer.  Applications may pass NULL after
;    calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
;    valid client context.
; 
; 
;  *  OTAllocInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTAllocInContext" 
   ((ref (:pointer :void))
    (structType :UInt32)
    (fields :UInt32)
    (err (:pointer :OSStatus))
    (clientContext (:pointer :OpaqueOTClientContextPtr));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :void)
() )
; 
;  *  OTAlloc()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #if OTCARBONAPPLICATION
#|                                              ;  The following macro may be used by applications only.
; #define OTAlloc(ref, structType, fields, err) OTAllocInContext(ref, structType, fields, err, NULL)
 |#

; #endif  /* OTCARBONAPPLICATION */

; 
;  *  OTFree()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTFree" 
   ((ptr :pointer)
    (structType :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
;  Option management
;  It looks simple enough...
; 
;  *  OTOptionManagement()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTOptionManagement" 
   ((ref (:pointer :void))
    (req (:pointer :TOptMgmt))
    (ret (:pointer :TOptMgmt))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  ... but then the hidden complexity emerges.
; 
;  *  OTCreateOptions()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientUtilLib 1.0 and later
;  
; 
;  *  OTCreateOptionString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientUtilLib 1.0 and later
;  
; 
;  *  OTNextOption()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTNextOption" 
   ((buffer (:pointer :UInt8))
    (buflen :UInt32)
    (prevOptPtr (:pointer :TOption))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTFindOption()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTFindOption" 
   ((buffer (:pointer :UInt8))
    (buflen :UInt32)
    (level :UInt32)
    (name :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :TOption)
() )
;  Bind/Unbind
; 
;  *  OTBind()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTBind" 
   ((ref (:pointer :void))
    (reqAddr (:pointer :TBind))                 ;  can be NULL 
    (retAddr (:pointer :TBind))                 ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTUnbind()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTUnbind" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Connection creation/tear-down
; 
;  *  OTConnect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTConnect" 
   ((ref (:pointer :void))
    (sndCall (:pointer :TCall))
    (rcvCall (:pointer :TCall))                 ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTRcvConnect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTRcvConnect" 
   ((ref (:pointer :void))
    (call (:pointer :TCall))                    ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTListen()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTListen" 
   ((ref (:pointer :void))
    (call (:pointer :TCall))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTAccept()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTAccept" 
   ((listener (:pointer :void))
    (worker (:pointer :void))
    (call (:pointer :TCall))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTSndDisconnect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTSndDisconnect" 
   ((ref (:pointer :void))
    (call (:pointer :TCall))                    ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTSndOrderlyDisconnect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTSndOrderlyDisconnect" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTRcvDisconnect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTRcvDisconnect" 
   ((ref (:pointer :void))
    (discon (:pointer :TDiscon))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTRcvOrderlyDisconnect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTRcvOrderlyDisconnect" 
   ((ref (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Connection-oriented send/receive
; 
;  *  OTRcv()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTRcv" 
   ((ref (:pointer :void))
    (buf :pointer)
    (nbytes :UInt32)
    (flags (:pointer :OTFLAGS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  OTSnd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTSnd" 
   ((ref (:pointer :void))
    (buf :pointer)
    (nbytes :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
;  Connectionless send/receive
; 
;  *  OTSndUData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTSndUData" 
   ((ref (:pointer :void))
    (udata (:pointer :TUnitData))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTRcvUData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTRcvUData" 
   ((ref (:pointer :void))
    (udata (:pointer :TUnitData))
    (flags (:pointer :OTFLAGS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTRcvUDErr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTRcvUDErr" 
   ((ref (:pointer :void))
    (uderr (:pointer :TUDErr))                  ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Connection-oriented transactions
; 
;  *  OTSndRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTRcvReply()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTSndReply()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTRcvRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTCancelRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTCancelReply()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
;  Connectionless transactions
; 
;  *  OTSndURequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTRcvUReply()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTSndUReply()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTRcvURequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTCancelURequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
; 
;  *  OTCancelUReply()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  
;  Interface to Mappers
; 
;    Under Carbon, the OpenMapper routines take a client context pointer.  Applications may pass NULL after
;    calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
;    valid client context.
; 
; 
;  *  OTAsyncOpenMapperInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTAsyncOpenMapperInContext" 
   ((config (:pointer :OTConfiguration))
    (oflag :UInt32)
    (upp (:pointer :OpaqueOTNotifyProcPtr))
    (contextPtr :pointer)
    (clientContext (:pointer :OpaqueOTClientContextPtr));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTOpenMapperInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTOpenMapperInContext" 
   ((config (:pointer :OTConfiguration))
    (oflag :UInt32)
    (err (:pointer :OSStatus))
    (clientContext (:pointer :OpaqueOTClientContextPtr));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :void)
() )
; 
;  *  OTAsyncOpenMapper()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTOpenMapper()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #if OTCARBONAPPLICATION
#|                                              ;  The following macros may be used by applications only.
; #define OTAsyncOpenMapper(config, oflag, proc, contextPtr) OTAsyncOpenMapperInContext(config, oflag, proc, contextPtr, NULL)
; #define OTOpenMapper(config, oflag, err) OTOpenMapperInContext(config, oflag, err, NULL)
 |#

; #endif  /* OTCARBONAPPLICATION */

; 
;  *  OTRegisterName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTRegisterName" 
   ((ref (:pointer :void))
    (req (:pointer :TRegisterRequest))
    (reply (:pointer :TRegisterReply))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTDeleteName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTDeleteName" 
   ((ref (:pointer :void))
    (name (:pointer :TNetbuf))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTDeleteNameByID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTDeleteNameByID" 
   ((ref (:pointer :void))
    (nameID :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  OTLookupName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTLookupName" 
   ((ref (:pointer :void))
    (req (:pointer :TLookupRequest))
    (reply (:pointer :TLookupReply))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Basic configuration manipulation
; 
;  *  OTCreateConfiguration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientUtilLib 1.0 and later
;  

(deftrap-inline "_OTCreateConfiguration" 
   ((path (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OTConfiguration)
() )
; 
;  *  OTCloneConfiguration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientUtilLib 1.0 and later
;  

(deftrap-inline "_OTCloneConfiguration" 
   ((cfig (:pointer :OTConfiguration))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OTConfiguration)
() )
; 
;  *  OTDestroyConfiguration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientUtilLib 1.0 and later
;  

(deftrap-inline "_OTDestroyConfiguration" 
   ((cfig (:pointer :OTConfiguration))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    This file defines a very limited set of operations
;    on a configuration.  "OpenTransportClient.h" extends this with extra
;    operations used by protocol stacks but not typically needed by clients.
; 
;  Interrupt-safe memory allocators
; 
;    Under Carbon, OTAllocMem takes a client context pointer.  Applications may pass NULL after
;    calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
;    valid client context.
; 
; 
;  *  OTAllocMemInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTAllocMemInContext" 
   ((size :UInt32)
    (clientContext (:pointer :OpaqueOTClientContextPtr));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :void)
() )
; 
;  *  OTAllocMem()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTFreeMem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientUtilLib 1.0 and later
;  

(deftrap-inline "_OTFreeMem" 
   ((mem :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

; #if OTCARBONAPPLICATION
#|                                              ;  The following macros may be used by applications only.
; #define OTAllocMem(s) OTAllocMemInContext(s, NULL)
 |#

; #endif  /* OTCARBONAPPLICATION */

;  Miscellaneous and Generic Routines
; 
;    Neither of these routines should be necessary to the correct
;    operation of an OT program.  If you're calling them, think again.
; 
; 
;  *  OTDelay()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTDelay" 
   ((seconds :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTClientLib 1.0 and later
;  

(deftrap-inline "_OTIdle" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

; #endif  /* !OTKERNEL */

; 
;    ***** Open Transport Utility Routines *****
;    All of these routines are available to both client and kernel.
; 
;  Memory and String Routines
; 
;    These are preferable, especially in the kernel case, to the standard
;    C equivalents because they don't require you to link with StdCLib.
; 
; 
;  *  OTMemcpy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTMemcpy" 
   ((dest :pointer)
    (src :pointer)
    (nBytes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTMemcmp()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTMemcmp" 
   ((mem1 :pointer)
    (mem2 :pointer)
    (nBytes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OTMemmove()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTMemmove" 
   ((dest :pointer)
    (src :pointer)
    (nBytes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTMemzero()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTMemzero" 
   ((dest :pointer)
    (nBytes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTMemset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTMemset" 
   ((dest :pointer)
    (toSet :UInt8)
    (nBytes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTStrLength()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTStrLength" 
   ((str (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  OTStrCopy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTStrCopy" 
   ((dest (:pointer :char))
    (src (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTStrCat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTStrCat" 
   ((dest (:pointer :char))
    (src (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTStrEqual()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTStrEqual" 
   ((src1 (:pointer :char))
    (src2 (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  Timer Utilities
; 
;    OTGetTimeStamp returns time in "tick" numbers, stored in 64 bits.
;    This timestamp can be used as a base number for calculating elapsed 
;    time.
;    OTSubtractTimeStamps returns a pointer to the "result" parameter.
;     
;    OTGetClockTimeInSecs returns time since Open Transport was initialized
;    in seconds.
; 

(%define-record :OTTimeStamp (find-record-descriptor ':UnsignedWide))
; 
;  *  OTGetTimeStamp()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTGetTimeStamp" 
   ((currentTime (:pointer :OTTIMESTAMP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTSubtractTimeStamps()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTSubtractTimeStamps" 
   ((result (:pointer :OTTIMESTAMP))
    (startTime (:pointer :OTTIMESTAMP))
    (endEnd (:pointer :OTTIMESTAMP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :UnsignedWide)
() )
; 
;  *  OTTimeStampInMilliseconds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTTimeStampInMilliseconds" 
   ((delta (:pointer :OTTIMESTAMP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  OTTimeStampInMicroseconds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTTimeStampInMicroseconds" 
   ((delta (:pointer :OTTIMESTAMP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  OTElapsedMilliseconds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTElapsedMilliseconds" 
   ((startTime (:pointer :OTTIMESTAMP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  OTElapsedMicroseconds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTElapsedMicroseconds" 
   ((startTime (:pointer :OTTIMESTAMP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  OTGetClockTimeInSecs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTGetClockTimeInSecs" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  ***** OT Link Element *****
; 
;    When using OT linked lists, all pointers to other elements are
;    represented by the OTLink structure.  When operating on link
;    lists, you always pass in the address of the OTLink on which
;    list elements are chained.
; 
(defrecord OTLink
   (fNext (:pointer :otlink))
; #ifdef __cplusplus
#| #|

      
   void    Init()                      { fNext = NULL; }
#endif
|#
 |#
)

;type name? (%define-record :OTLink (find-record-descriptor ':OTLink))
; 
;     You can use this macro to map from an OTLink field to the
;   structure in which it's embedded.
; 
; #define OTGetLinkObject(link, struc, field)      ((struc*)((char*)(link) - OTOffsetOf(struc, field)))
;  OTLIFO
; 
;    These are functions to implement a LIFO list that is interrupt-safe.
;    The only function which is not is OTReverseList.  Normally, you create
;    a LIFO list, populate it at interrupt time, and then use OTLIFOStealList
;    to atomically remove the list, and OTReverseList to flip the list so that
;    it is a FIFO list, which tends to be more useful.
; 
(defrecord OTLIFO
   (fHead (:pointer :OTLink))
; #ifdef __cplusplus
#| #|

   
  void    Init();
    void    Enqueue(OTLink* link);
 OTLink* Dequeue();
 OTLink* StealList();
   Boolean IsEmpty();
#endif
|#
 |#
)

;type name? (%define-record :OTLIFO (find-record-descriptor ':OTLIFO))
; 
;    This function atomically enqueues the link onto the
;    front of the list.
; 
; 
;  *  OTLIFOEnqueue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTLIFOEnqueue" 
   ((list (:pointer :OTLIFO))
    (link (:pointer :OTLink))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    This function atomically dequeues the first element
;    on the list.
; 
; 
;  *  OTLIFODequeue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTLIFODequeue" 
   ((list (:pointer :OTLIFO))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OTLink)
() )
; 
;    This function atomically empties the list and returns a
;    pointer to the first element on the list.
; 
; 
;  *  OTLIFOStealList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTLIFOStealList" 
   ((list (:pointer :OTLIFO))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OTLink)
() )
; 
;    This function reverses a list that was stolen by
;    OTLIFOStealList.  It is NOT atomic.  It returns the
;    new starting list.
; 
; 
;  *  OTReverseList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTReverseList" 
   ((list (:pointer :OTLink))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OTLink)
() )
; #ifdef __cplusplus
#| #|

   
  inline  void    OTLIFO::Init()                      { fHead = NULL; }
  inline  void    OTLIFO::Enqueue(OTLink* link)       { OTLIFOEnqueue(this, link); }
 inline  OTLink* OTLIFO::Dequeue()                   { return OTLIFODequeue(this); }
    inline  OTLink* OTLIFO::StealList()                 { return OTLIFOStealList(this); }
  inline  Boolean OTLIFO::IsEmpty()                   { return fHead == NULL; }
#endif
|#
 |#
;  OTList
; 
;    An OTList is a non-interrupt-safe list, but has more features than the
;    OTLIFO list. It is a standard singly-linked list.
; 
; 
;    The following is the prototype for a list element comparison function,
;    which returns true if the element described by linkToCheck matches
;    the client criteria (typically held in ref).
;    This is only a UPP for CFM-68K clients.
; 

(def-mactype :OTListSearchProcPtr (find-mactype ':pointer)); (const void * ref , OTLink * linkToCheck)

(def-mactype :OTListSearchUPP (find-mactype '(:pointer :OpaqueOTListSearchProcPtr)))
; 
;  *  NewOTListSearchUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewOTListSearchUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueOTListSearchProcPtr)
() )
; 
;  *  DisposeOTListSearchUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeOTListSearchUPP" 
   ((userUPP (:pointer :OpaqueOTListSearchProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeOTListSearchUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeOTListSearchUPP" 
   ((ref :pointer)
    (linkToCheck (:pointer :OTLink))
    (userUPP (:pointer :OpaqueOTListSearchProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
(defrecord OTList
   (fHead (:pointer :OTLink))
; #ifdef __cplusplus
#| #|
    
  void        Init();
    Boolean     IsEmpty();
 void        AddFirst(OTLink* link);
    void        AddLast(OTLink* link);
 OTLink*     GetFirst();
    OTLink*     GetLast();
 OTLink*     RemoveFirst();
 OTLink*     RemoveLast();
  Boolean     IsInList(OTLink* link);
    OTLink*     FindLink(OTListSearchUPP proc, const void* ref);
   Boolean     RemoveLink(OTLink* link);
  OTLink*     FindAndRemoveLink(OTListSearchUPP proc, const void* ref);
  OTLink*     GetIndexedLink(OTItemCount index);
#endif
|#
 |#
)

;type name? (%define-record :OTList (find-record-descriptor ':OTList))
;  Add the link to the list at the front
; 
;  *  OTAddFirst()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTAddFirst" 
   ((list (:pointer :OTList))
    (link (:pointer :OTLink))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  Add the link to the list at the end
; 
;  *  OTAddLast()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTAddLast" 
   ((list (:pointer :OTList))
    (link (:pointer :OTLink))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  Remove the first link from the list
; 
;  *  OTRemoveFirst()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTRemoveFirst" 
   ((list (:pointer :OTList))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OTLink)
() )
;  Remove the last link from the list
; 
;  *  OTRemoveLast()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTRemoveLast" 
   ((list (:pointer :OTList))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OTLink)
() )
;  Return the first link from the list
; 
;  *  OTGetFirst()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTGetFirst" 
   ((list (:pointer :OTList))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OTLink)
() )
;  Return the last link from the list
; 
;  *  OTGetLast()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTGetLast" 
   ((list (:pointer :OTList))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OTLink)
() )
;  Return true if the link is present in the list
; 
;  *  OTIsInList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTIsInList" 
   ((list (:pointer :OTList))
    (link (:pointer :OTLink))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    Find a link in the list which matches the search criteria
;    established by the search proc and the refPtr.  This is done
;    by calling the search proc, passing it the refPtr and each
;    link in the list, until the search proc returns true.
;    NULL is returned if the search proc never returned true.
; 
; 
;  *  OTFindLink()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTFindLink" 
   ((list (:pointer :OTList))
    (proc (:pointer :OpaqueOTListSearchProcPtr))
    (ref :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OTLink)
() )
;  Remove the specified link from the list, returning true if it was found
; 
;  *  OTRemoveLink()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTRemoveLink" 
   ((list (:pointer :OTList))
    (link (:pointer :OTLink))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  Similar to OTFindLink, but it also removes it from the list.
; 
;  *  OTFindAndRemoveLink()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTFindAndRemoveLink" 
   ((list (:pointer :OTList))
    (proc (:pointer :OpaqueOTListSearchProcPtr))
    (ref :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OTLink)
() )
;  Return the "index"th link in the list
; 
;  *  OTGetIndexedLink()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTGetIndexedLink" 
   ((list (:pointer :OTList))
    (index :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OTLink)
() )
;  OTEnqueue/OTDequeue
; 
;    These routines are atomic, mighty weird, and generally not
;    worth the complexity.  If you need atomic list operations,
;    use OTLIFO instead.
; 
; 
;    This function puts "object" on the listHead, and places the
;    previous value at listHead into the pointer at "object" plus
;    linkOffset.
; 
; 
;  *  OTEnqueue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTEnqueue" 
   ((listHead :pointer)
    (object :pointer)
    (linkOffset :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    This function returns the head object of the list, and places
;    the pointer at "object" + linkOffset into the listHead
; 
; 
;  *  OTDequeue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTDequeue" 
   ((listHead :pointer)
    (linkOffset :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :void)
() )
; #ifdef __cplusplus
#| #|
    
  inline  void        OTList::Init()                  { fHead = NULL; }   
   inline  Boolean     OTList::IsEmpty()               { return fHead == NULL; }
  inline  void        OTList::AddFirst(OTLink* link)  { OTAddFirst(this, link); }
    inline  void        OTList::AddLast(OTLink* link)   { OTAddLast(this, link); }
 inline  OTLink*     OTList::GetFirst()              { return OTGetFirst(this); }
   inline  OTLink*     OTList::GetLast()               { return OTGetLast(this); }
    inline  OTLink*     OTList::RemoveFirst()           { return OTRemoveFirst(this); }
    inline  OTLink*     OTList::RemoveLast()            { return OTRemoveLast(this); }
 inline  Boolean     OTList::IsInList(OTLink* link)  { return OTIsInList(this, link); }
 inline  OTLink*     OTList::FindLink(OTListSearchUPP proc, const void* ref)
                                                        { return OTFindLink(this, proc, ref); }
    inline  Boolean     OTList::RemoveLink(OTLink* link) { return OTRemoveLink(this, link); }
  inline  OTLink*     OTList::FindAndRemoveLink(OTListSearchUPP proc, const void* ref)
                                                       { return OTFindAndRemoveLink(this, proc, ref); }
   inline  OTLink*     OTList::GetIndexedLink(OTItemCount index)
                                                      { return OTGetIndexedLink(this, index); }
#endif
|#
 |#
;  Atomic Operations
; 
;    Note:
;    The Bit operations return the previous value of the bit (0 or non-zero).
;    The memory pointed to must be a single byte and only bits 0 through 7 are
;    valid.  Bit 0 corresponds to a mask of 0x01, and Bit 7 to a mask of 0x80.
; 
; 
;    WARNING!
;    void* and UInt32 locations MUST be on 4-byte boundaries.
;    UInt16 locations must not cross a 4-byte boundary.
; 
; 
;  *  OTAtomicSetBit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTAtomicSetBit" 
   ((bytePtr (:pointer :UInt8))
    (bitNumber :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    bset.b d0,(a0)
;    sne d0
;    moveq #1,d1
;    and.l d1,d0
; 
; 
;  *  OTAtomicClearBit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTAtomicClearBit" 
   ((bytePtr (:pointer :UInt8))
    (bitNumber :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    bclr.b d0,(a0)
;    sne d0
;    moveq #1,d1
;    and.l d1,d0
; 
; 
;  *  OTAtomicTestBit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTAtomicTestBit" 
   ((bytePtr (:pointer :UInt8))
    (bitNumber :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    btst.b d0,(a0)
;    sne d0 *|
;    moveq #1,d1
;    and.l d1,d0 *|
; 
; 
;  *  OTCompareAndSwapPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTCompareAndSwapPtr" 
   ((oldValue :pointer)
    (newValue :pointer)
    (dest :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    cas.l    d0,d1,(a0)  *|
;    seq      d0          *|
;    moveq #1,d1; and.l d1,d0 *|
; 
; 
;  *  OTCompareAndSwap32()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTCompareAndSwap32" 
   ((oldValue :UInt32)
    (newValue :UInt32)
    (dest (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    cas.l    d0,d1,(a0)  *|
;    seq      d0          *|
;    moveq #1,d1; and.l d1,d0 *|
; 
; 
;  *  OTCompareAndSwap16()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTCompareAndSwap16" 
   ((oldValue :UInt32)
    (newValue :UInt32)
    (dest (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    cas.w    d0,d1,(a0)  *|
;    seq      d0          *|
;    moveq #1,d1; and.l d1,d0 *|
; 
; 
;  *  OTCompareAndSwap8()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTCompareAndSwap8" 
   ((oldValue :UInt32)
    (newValue :UInt32)
    (dest (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    cas.b    d0,d1,(a0)  *|
;    seq      d0          *|
;    moveq #1,d1; and.l d1,d0 *|
; 
; 
;  *  OTAtomicAdd32()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTAtomicAdd32" 
   ((toAdd :SInt32)
    (dest (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;    move.l   d0,a1       *|
;    move.l   (a0),d1     *|
;    move.l   d1,d0       *|
;    add.l    a1,d0       *|
;    cas.l    d1,d0,(a0)  *|
;    bne.s    @1          *|
; 
; 
;  *  OTAtomicAdd16()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTAtomicAdd16" 
   ((toAdd :SInt32)
    (dest (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
;  Not used frequently enough to justify inlining.
; 
;  *  OTAtomicAdd8()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTAtomicAdd8" 
   ((toAdd :SInt32)
    (dest (:pointer :SInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt8
() )
;  Not used frequently enough to justify inlining.
;  OTLock is just a convenience type with some convenient macros.

(def-mactype :OTLock (find-mactype ':UInt8))
; #define OTClearLock(lockPtr)   *(lockPtr) = 0
; #define OTAcquireLock(lockPtr)   (OTAtomicSetBit(lockPtr, 0) == 0)
; ******************************************************************************
; **
; ** FROM HERE ON DOWN ARE THE C++ Interfaces to Open Transport
; **
; *******************************************************************************
; #ifdef __cplusplus
#| #|
}                   


#if!OTKERNEL

class TProvider
{
    private:
        void*       operator new(size_t);
        void        operator delete(void*)  {}
        
                    public: 
        OSStatus    Close()             { return OTCloseProvider(this); }

        OSStatus    SetNonBlocking()    { return OTSetNonBlocking(this); }
        OSStatus    SetBlocking()       { return OTSetBlocking(this); }
        Boolean     IsBlocking()        { return OTIsBlocking(this); }
        Boolean     IsNonBlocking()     { return !OTIsBlocking(this); }
        OSStatus    SetSynchronous()    { return OTSetSynchronous(this); }
        OSStatus    SetAsynchronous()   { return OTSetAsynchronous(this); }
        Boolean     IsSynchronous()     { return OTIsSynchronous(this); }
        Boolean     IsAsynchronous()    { return !OTIsSynchronous(this); }
        
        OSStatus    AckSends()          { return OTAckSends(this); }
        OSStatus    DontAckSends()      { return OTDontAckSends(this); }
        Boolean     IsAckingSends()     { return OTIsAckingSends(this); }

        void        CancelSynchronousCalls(OSStatus err)
                    { (void)OTCancelSynchronousCalls(this, err); }

        OSStatus    InstallNotifier(OTNotifyUPP proc, void* ptr)
                    { return OTInstallNotifier(this, proc, ptr); }

        OSStatus    UseSyncIdleEvents()
                    { return OTUseSyncIdleEvents(this, true); }

        OSStatus    DontUseSyncIdleEvents()
                    { return OTUseSyncIdleEvents(this, false); }
                    
        void        RemoveNotifier()
                    { OTRemoveNotifier(this); }
        
        Boolean     EnterNotifier()
                    { return OTEnterNotifier(this); }
                    
        void        LeaveNotifier()
                    { OTLeaveNotifier(this); }
                    
#ifCALL_NOT_IN_CARBON
        OTPortRef   GetOTPortRef()
                    { return OTGetProviderPortRef(this); }
                    
        ProviderRef TransferOwnership(OTClient prevOwner, OSStatus* errPtr)
                    { return OTTransferProviderOwnership(this, prevOwner, errPtr); }
#endif                    
        SInt32      Ioctl(UInt32 cmd, void* data)
                    { return OTIoctl(this, cmd, data); }
        SInt32      Ioctl(UInt32 cmd, long data)
                    { return OTIoctl(this, cmd, (void*)data); }
                    
#ifCALL_NOT_IN_CARBON
        OTResult    GetMessage(strbuf* ctlbuf, strbuf* databuf, OTFlags* flagPtr)
                    { return OTGetMessage(this, ctlbuf, databuf, flagPtr); }
        OTResult    GetPriorityMessage(strbuf* ctlbuf, strbuf* databuf,
                                       OTBand* bandPtr, OTFlags* flagPtr)
                    { return OTGetPriorityMessage(this, ctlbuf, databuf, bandPtr, flagPtr); }
        OSStatus    PutMessage(const strbuf* ctlbuf, const strbuf* databuf,
                               OTFlags flags)
                    { return OTPutMessage(this, ctlbuf, databuf, flags); }
        OSStatus    PutPriorityMessage(const strbuf* ctlbuf, const strbuf* databuf,
                                       OTBand band, OTFlags flags)
                    { return OTPutPriorityMessage(this, ctlbuf, databuf, band, flags); }
#endif                    

    public:
        void*   fData;
};
        

#ifdefFree
#undef Free
#endif        


class TEndpoint : public TProvider
{
    public:
                    OSStatus    GetEndpointInfo(TEndpointInfo* info)
                    { return OTGetEndpointInfo(this, info); }
                    
        OSStatus    GetProtAddress(TBind* boundAddr, TBind* peerAddr)
                    { return OTGetProtAddress(this, boundAddr, peerAddr); }
                    
        OSStatus    ResolveAddress(TBind* reqAddr, TBind* retAddr, OTTimeout timeout)
                    { return OTResolveAddress(this, reqAddr, retAddr, timeout); }
                    
        OTResult    GetEndpointState()      
                    { return OTGetEndpointState(this); }
                    
        OTResult    Look()
                    { return OTLook(this); }
                    
#ifCALL_NOT_IN_CARBON
        OTResult    Sync()
                    { return OTSync(this); }
#endif                    void*       AllocInContext(OTStructType structType, UInt32 fields, OSStatus* err = NULL, OTClientContextPtr clientContext = NULL)
                    { return OTAllocInContext(this, structType, fields, err, clientContext); }
                    
        void*       Alloc(OTStructType structType, UInt32 fields, OSStatus* err = NULL)
                    {
                #ifTARGET_API_MAC_CARBON
                         return OTAllocInContext(this, structType, fields, err, NULL);
                #else                         return OTAlloc(this, structType, fields, err);
                #endif                    };
                    
        OTResult    Free(void* ptr, OTStructType structType)
                    { return OTFree(ptr, structType); }
                    OSStatus    OptionManagement(TOptMgmt* req, TOptMgmt* ret)
                    { return OTOptionManagement(this, req, ret); }
                    OSStatus    Bind(TBind* reqAddr, TBind* retAddr)
                    { return OTBind(this, reqAddr, retAddr); }
                    
        OSStatus    Unbind()
                    { return OTUnbind(this); }
                    OSStatus    Connect(TCall* sndCall, TCall* rcvCall)
                    { return OTConnect(this, sndCall, rcvCall); }
                    
        OSStatus    RcvConnect(TCall* call)
                    { return OTRcvConnect(this, call); }
                    
        OSStatus    Listen(TCall* call)
                    { return OTListen(this, call); }
                    
        OSStatus    Accept(EndpointRef resRef, TCall* call)
                    { return OTAccept(this, resRef, call); }
                    
        OSStatus    SndDisconnect(TCall* call)
                    { return OTSndDisconnect(this, call); }
                    
        OSStatus    SndOrderlyDisconnect()
                    { return OTSndOrderlyDisconnect(this); }
                    
        OSStatus    RcvDisconnect(TDiscon* discon)
                    { return OTRcvDisconnect(this, discon); }
                    
        OSStatus    RcvOrderlyDisconnect()
                    { return OTRcvOrderlyDisconnect(this); }
                    OTResult    Snd(void* buf, OTByteCount nbytes, OTFlags flags)
                    { return OTSnd(this, buf, nbytes, flags); }
                    
        OTResult    Rcv(void* buf, OTByteCount nbytes, OTFlags* flagP)
                    { return OTRcv(this, buf, nbytes, flagP); }
                    OSStatus    SndUData(TUnitData* udata)
                    { return OTSndUData(this, udata); }
                    
        OSStatus    RcvUData(TUnitData* udata, OTFlags* flagP)
                    { return OTRcvUData(this, udata, flagP); }
                    
        OSStatus    RcvUDErr(TUDErr* uderr)
                    { return OTRcvUDErr(this, uderr); }

#ifCALL_NOT_IN_CARBON
                    OSStatus    SndRequest(TRequest* req, OTFlags reqFlags)
                    { return OTSndRequest(this, req, reqFlags); }

        OSStatus    RcvReply(TReply* reply, OTFlags* replyFlags)
                    { return OTRcvReply(this, reply, replyFlags); }
                    
        OSStatus    SndReply(TReply* reply, OTFlags flags)
                    { return OTSndReply(this, reply, flags); }
                    
        OSStatus    RcvRequest(TRequest* req, OTFlags* flags)
                    { return OTRcvRequest(this, req, flags); }
                    
        OSStatus    CancelRequest(OTSequence seq)
                    { return OTCancelRequest(this, seq); }
                    
        OSStatus    CancelReply(OTSequence seq)
                    { return OTCancelReply(this, seq); }
                    OSStatus    SndURequest(TUnitRequest* req, OTFlags reqFlags)
                    { return OTSndURequest(this, req, reqFlags); }

        OSStatus    RcvUReply(TUnitReply* reply, OTFlags* replyFlags)
                    { return OTRcvUReply(this, reply, replyFlags); }
                    
        OSStatus    SndUReply(TUnitReply* reply, OTFlags flags)
                    { return OTSndUReply(this, reply, flags); }
                    
        OSStatus    RcvURequest(TUnitRequest* req, OTFlags* flags)
                    { return OTRcvURequest(this, req, flags); }
                    
        OSStatus    CancelURequest(OTSequence seq)
                    { return OTCancelURequest(this, seq); }
                    
        OSStatus    CancelUReply(OTSequence seq)
                    { return OTCancelUReply(this, seq); }
#endif                    OTResult    CountDataBytes(OTByteCount* countPtr)
                    { return OTCountDataBytes(this, countPtr); }
};



class TMapper : public TProvider
{
    public:
        OSStatus    RegisterName(TRegisterRequest* req, TRegisterReply* reply)
                    { return OTRegisterName(this, req, reply); }
                
        OSStatus    DeleteName(TNetbuf* name)
                    { return OTDeleteName(this, name); }
                
        OSStatus    DeleteName(OTNameID theID)  
                    { return OTDeleteNameByID(this, theID); }
                
        OSStatus    LookupName(TLookupRequest* req, TLookupReply* reply)
                    { return OTLookupName(this, req, reply); }
};

#endif 

extern "C" {        #endif
|#
 |#
;  __cplusplus 

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

; #endif /* __OPENTRANSPORT__ */


(provide-interface "OpenTransport")