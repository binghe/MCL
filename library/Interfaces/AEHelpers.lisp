(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AEHelpers.h"
; at Sunday July 2,2006 7:24:27 pm.
; 
;      File:       AE/AEHelpers.h
;  
;      Contains:   AEPrint, AEBuild and AEStream for Carbon
;  
;      Version:    AppleEvents-275~1
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; 
;  * Originally from AEGIzmos by Jens Alfke, circa 1992.
;  
; #ifndef __AEHELPERS__
; #define __AEHELPERS__

(require-interface "stdarg")
; #ifndef __APPLEEVENTS__
#| #|
#include <AEAppleEvents.h>
#endif
|#
 |#
; #ifndef __AEDATAMODEL__
#| #|
#include <AEAEDataModel.h>
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
; 
;  * AEBuild:
;  *
;  * AEBuild provides a very high level abstraction for building
;  * complete AppleEvents and complex ObjectSpeciers.  Using AEBuild it
;  * is easy to produce a textual representation of an AEDesc.  The
;  * format is similar to the stdio printf call, where meta data is
;  * extracted from a format string and used to build the final
;  * representation.
;  * 
;  * For more information on AEBuild and other APIs in AEHelpers, see:
;  *     <http://developer.apple.com/technotes/tn/tn2045.html>
;  
;  Syntax Error Codes: 

(def-mactype :AEBuildErrorCode (find-mactype ':UInt32))

(defconstant $aeBuildSyntaxNoErr 0)             ;  (No error) 

(defconstant $aeBuildSyntaxBadToken 1)          ;  Illegal character 

(defconstant $aeBuildSyntaxBadEOF 2)            ;  Unexpected end of format string 

(defconstant $aeBuildSyntaxNoEOF 3)             ;  Unexpected extra stuff past end 

(defconstant $aeBuildSyntaxBadNegative 4)       ;  "-" not followed by digits 

(defconstant $aeBuildSyntaxMissingQuote 5)      ;  Missing close "'" 

(defconstant $aeBuildSyntaxBadHex 6)            ;  Non-digit in hex string 

(defconstant $aeBuildSyntaxOddHex 7)            ;  Odd # of hex digits 

(defconstant $aeBuildSyntaxNoCloseHex 8)        ;  Missing "È" 

(defconstant $aeBuildSyntaxUncoercedHex 9)      ;  Hex string must be coerced to a type 

(defconstant $aeBuildSyntaxNoCloseString 10)    ;  Missing "Ó" 

(defconstant $aeBuildSyntaxBadDesc 11)          ;  Illegal descriptor 

(defconstant $aeBuildSyntaxBadData 12)          ;  Bad data value inside (É) 

(defconstant $aeBuildSyntaxNoCloseParen 13)     ;  Missing ")" after data value 

(defconstant $aeBuildSyntaxNoCloseBracket 14)   ;  Expected "," or "]" 

(defconstant $aeBuildSyntaxNoCloseBrace 15)     ;  Expected "," or "}" 

(defconstant $aeBuildSyntaxNoKey 16)            ;  Missing keyword in record 

(defconstant $aeBuildSyntaxNoColon 17)          ;  Missing ":" after keyword in record 

(defconstant $aeBuildSyntaxCoercedList 18)      ;  Cannot coerce a list 

(defconstant $aeBuildSyntaxUncoercedDoubleAt 19);  "@@" substitution must be coerced 

;  A structure containing error state.
(defrecord AEBuildError
   (fError :UInt32)
   (fErrorPos :UInt32)
)

;type name? (%define-record :AEBuildError (find-record-descriptor ':AEBuildError))
; 
;    Create an AEDesc from the format string.  AEBuildError can be NULL, in which case
;    no explicit error information will be returned.
; 
; 
;  *  AEBuildDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEBuildDesc" 
   ((dst (:pointer :AEDesc))
    (error (:pointer :AEBuildError))            ;  can be NULL 
    (src (:pointer :char))
#| |...|  ;; What should this do?
    |#
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  varargs version of AEBuildDesc
; 
;  *  vAEBuildDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_vAEBuildDesc" 
   ((dst (:pointer :AEDesc))
    (error (:pointer :AEBuildError))            ;  can be NULL 
    (src (:pointer :char))
    (args (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Append parameters to an existing AppleEvent
; 
;  *  AEBuildParameters()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEBuildParameters" 
   ((event (:pointer :AppleEvent))
    (error (:pointer :AEBuildError))            ;  can be NULL 
    (format (:pointer :char))
#| |...|  ;; What should this do?
    |#
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  varargs version of AEBuildParameters
; 
;  *  vAEBuildParameters()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_vAEBuildParameters" 
   ((event (:pointer :AppleEvent))
    (error (:pointer :AEBuildError))            ;  can be NULL 
    (format (:pointer :char))
    (args (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Building an entire Apple event:
; 
;  *  AEBuildAppleEvent()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEBuildAppleEvent" 
   ((theClass :FourCharCode)
    (theID :FourCharCode)
    (addressType :FourCharCode)
    (addressData :pointer)
    (addressLength :signed-long)
    (returnID :SInt16)
    (transactionID :signed-long)
    (result (:pointer :AppleEvent))
    (error (:pointer :AEBuildError))            ;  can be NULL 
    (paramsFmt (:pointer :char))
#| |...|  ;; What should this do?
    |#
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  varargs version of AEBuildAppleEvent
; 
;  *  vAEBuildAppleEvent()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_vAEBuildAppleEvent" 
   ((theClass :FourCharCode)
    (theID :FourCharCode)
    (addressType :FourCharCode)
    (addressData :pointer)
    (addressLength :signed-long)
    (returnID :SInt16)
    (transactionID :signed-long)
    (resultEvt (:pointer :AppleEvent))
    (error (:pointer :AEBuildError))            ;  can be NULL 
    (paramsFmt (:pointer :char))
    (args (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  * AEPrintDescToHandle
;  *
;  * AEPrintDescToHandle provides a way to turn an AEDesc into a textual
;  * representation.  This is most useful for debugging calls to
;  * AEBuildDesc and friends.  The Handle returned should be disposed by
;  * the caller.  The size of the handle is the actual number of
;  * characters in the string.
;  
; 
;  *  AEPrintDescToHandle()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEPrintDescToHandle" 
   ((desc (:pointer :AEDesc))
    (result (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  * AEStream:
;  *
;  * The AEStream interface allows you to build AppleEvents by appending
;  * to an opaque structure (an AEStreamRef) and then turning this
;  * structure into an AppleEvent.  The basic idea is to open the
;  * stream, write data, and then close it - closing it produces an
;  * AEDesc, which may be partially complete, or may be a complete
;  * AppleEvent.
;  

(def-mactype :AEStreamRef (find-mactype '(:pointer :OpaqueAEStreamRef)))
; 
;    Create and return an AEStreamRef
;    Returns NULL on memory allocation failure
; 
; 
;  *  AEStreamOpen()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamOpen" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueAEStreamRef)
() )
; 
;    Closes and disposes of an AEStreamRef, producing
;    results in the desc.  You must dispose of the desc yourself.
;    If you just want to dispose of the AEStreamRef, you can pass NULL for desc.
; 
; 
;  *  AEStreamClose()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamClose" 
   ((ref (:pointer :OpaqueAEStreamRef))
    (desc (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    Prepares an AEStreamRef for appending data to a newly created desc.
;    You append data with AEStreamWriteData
; 
; 
;  *  AEStreamOpenDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamOpenDesc" 
   ((ref (:pointer :OpaqueAEStreamRef))
    (newType :FourCharCode)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Append data to the previously opened desc.
; 
;  *  AEStreamWriteData()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamWriteData" 
   ((ref (:pointer :OpaqueAEStreamRef))
    (data :pointer)
    (length :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    Finish a desc.  After this, you can close the stream, or adding new
;    descs, if you're assembling a list.
; 
; 
;  *  AEStreamCloseDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamCloseDesc" 
   ((ref (:pointer :OpaqueAEStreamRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Write data as a desc to the stream
; 
;  *  AEStreamWriteDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamWriteDesc" 
   ((ref (:pointer :OpaqueAEStreamRef))
    (newType :FourCharCode)
    (data :pointer)
    (length :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Write an entire desc to the stream
; 
;  *  AEStreamWriteAEDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamWriteAEDesc" 
   ((ref (:pointer :OpaqueAEStreamRef))
    (desc (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    Begin a list.  You can then append to the list by doing
;    AEStreamOpenDesc, or AEStreamWriteDesc.
; 
; 
;  *  AEStreamOpenList()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamOpenList" 
   ((ref (:pointer :OpaqueAEStreamRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Finish a list.
; 
;  *  AEStreamCloseList()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamCloseList" 
   ((ref (:pointer :OpaqueAEStreamRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    Begin a record.  A record usually has type 'reco', however, this is
;    rather generic, and frequently a different type is used.
; 
; 
;  *  AEStreamOpenRecord()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamOpenRecord" 
   ((ref (:pointer :OpaqueAEStreamRef))
    (newType :FourCharCode)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Change the type of a record.
; 
;  *  AEStreamSetRecordType()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamSetRecordType" 
   ((ref (:pointer :OpaqueAEStreamRef))
    (newType :FourCharCode)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Finish a record
; 
;  *  AEStreamCloseRecord()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamCloseRecord" 
   ((ref (:pointer :OpaqueAEStreamRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    Add a keyed descriptor to a record.  This is analogous to AEPutParamDesc.
;    it can only be used when writing to a record.
; 
; 
;  *  AEStreamWriteKeyDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamWriteKeyDesc" 
   ((ref (:pointer :OpaqueAEStreamRef))
    (key :FourCharCode)
    (newType :FourCharCode)
    (data :pointer)
    (length :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    OpenDesc for a keyed record entry.  You can use AEStreamWriteData
;    after opening a keyed desc.
; 
; 
;  *  AEStreamOpenKeyDesc()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamOpenKeyDesc" 
   ((ref (:pointer :OpaqueAEStreamRef))
    (key :FourCharCode)
    (newType :FourCharCode)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Write a key to the stream - you can follow this with an AEWriteDesc.
; 
;  *  AEStreamWriteKey()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamWriteKey" 
   ((ref (:pointer :OpaqueAEStreamRef))
    (key :FourCharCode)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    Create a complete AppleEvent.  This creates and returns a new stream.
;    Use this call to populate the meta fields in an AppleEvent record.
;    After this, you can add your records, lists and other parameters.
; 
; 
;  *  AEStreamCreateEvent()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamCreateEvent" 
   ((clazz :FourCharCode)
    (id :FourCharCode)
    (targetType :FourCharCode)
    (targetData :pointer)
    (targetLength :signed-long)
    (returnID :SInt16)
    (transactionID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueAEStreamRef)
() )
; 
;    This call lets you augment an existing AppleEvent using the stream
;    APIs.  This would be useful, for example, in constructing the reply
;    record in an AppleEvent handler.  Note that AEStreamOpenEvent will
;    consume the AppleEvent passed in - you can't access it again until the
;    stream is closed.  When you're done building the event, AEStreamCloseStream
;     will reconstitute it.
; 
; 
;  *  AEStreamOpenEvent()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamOpenEvent" 
   ((event (:pointer :AppleEvent))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueAEStreamRef)
() )
;  Mark a keyword as being an optional parameter.
; 
;  *  AEStreamOptionalParam()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AEStreamOptionalParam" 
   ((ref (:pointer :OpaqueAEStreamRef))
    (key :FourCharCode)
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

; #endif /* __AEHELPERS__ */


(provide-interface "AEHelpers")