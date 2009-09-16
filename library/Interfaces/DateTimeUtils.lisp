(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DateTimeUtils.h"
; at Sunday July 2,2006 7:23:15 pm.
; 
;      File:       CarbonCore/DateTimeUtils.h
;  
;      Contains:   International Date and Time Interfaces (previously in TextUtils)
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1994-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __DATETIMEUTILS__
; #define __DATETIMEUTILS__
; #ifndef __CONDITIONALMACROS__
#| #|
#include <CarbonCoreConditionalMacros.h>
#endif
|#
 |#
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __UTCUTILS__
#| #|
#include <CarbonCoreUTCUtils.h>
#endif
|#
 |#
; #ifndef __CFDATE__

(require-interface "CoreFoundation/CFDate")

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
; 
; 
;     Here are the current routine names and the translations to the older forms.
;     Please use the newer forms in all new code and migrate the older names out of existing
;     code as maintainance permits.
;     
;     New Name                    Old Name(s)
;     
;     DateString                  IUDatePString IUDateString 
;     InitDateCache
;     LongDateString              IULDateString
;     LongTimeString              IULTimeString
;     StringToDate                String2Date
;     StringToTime                                
;     TimeString                  IUTimeString IUTimePString
;     LongDateToSeconds           LongDate2Secs
;     LongSecondsToDate           LongSecs2Date
;     DateToSeconds               Date2Secs
;     SecondsToDate               Secs2Date
; 
; 
;     Carbon only supports the new names.  The old names are undefined for Carbon targets.
;     This is true for C, Assembly and Pascal.
;     
;     InterfaceLib always has exported the old names.  For C macros have been defined to allow
;     the use of the new names.  For Pascal and Assembly using the new names will result
;     in link errors. 
;     
; 

(def-mactype :ToggleResults (find-mactype ':SInt16))
;  Toggle results 

(defconstant $toggleUndefined 0)
(defconstant $toggleOK 1)
(defconstant $toggleBadField 2)
(defconstant $toggleBadDelta 3)
(defconstant $toggleBadChar 4)
(defconstant $toggleUnknown 5)
(defconstant $toggleBadNum 6)
(defconstant $toggleOutOfRange 7)               ; synonym for toggleErr3

(defconstant $toggleErr3 7)
(defconstant $toggleErr4 8)
(defconstant $toggleErr5 9)
;  Date equates 

(defconstant $smallDateBit 31)                  ; Restrict valid date/time to range of Time global

(defconstant $togChar12HourBit 30)              ; If toggling hour by char, accept hours 1..12 only

(defconstant $togCharZCycleBit 29)              ; Modifier for togChar12HourBit: accept hours 0..11 only

(defconstant $togDelta12HourBit 28)             ; If toggling hour up/down, restrict to 12-hour range (am/pm)

(defconstant $genCdevRangeBit 27)               ; Restrict date/time to range used by genl CDEV

(defconstant $validDateFields -1)
(defconstant $maxDateField 10)

(defconstant $eraMask 1)
(defconstant $yearMask 2)
(defconstant $monthMask 4)
(defconstant $dayMask 8)
(defconstant $hourMask 16)
(defconstant $minuteMask 32)
(defconstant $secondMask 64)
(defconstant $dayOfWeekMask #x80)
(defconstant $dayOfYearMask #x100)
(defconstant $weekOfYearMask #x200)
(defconstant $pmMask #x400)
(defconstant $dateStdMask 127)                  ; default for ValidDate flags and ToggleDate TogglePB.togFlags


(def-mactype :LongDateField (find-mactype ':SInt8))

(defconstant $eraField 0)
(defconstant $yearField 1)
(defconstant $monthField 2)
(defconstant $dayField 3)
(defconstant $hourField 4)
(defconstant $minuteField 5)
(defconstant $secondField 6)
(defconstant $dayOfWeekField 7)
(defconstant $dayOfYearField 8)
(defconstant $weekOfYearField 9)
(defconstant $pmField 10)
(defconstant $res1Field 11)
(defconstant $res2Field 12)
(defconstant $res3Field 13)

(def-mactype :DateForm (find-mactype ':SInt8))

(defconstant $shortDate 0)
(defconstant $longDate 1)
(defconstant $abbrevDate 2)
;  StringToDate status values 

(defconstant $fatalDateTime #x8000)             ;  StringToDate and String2Time mask to a fatal error 

(defconstant $longDateFound 1)                  ;  StringToDate mask to long date found 

(defconstant $leftOverChars 2)                  ;  StringToDate & Time mask to warn of left over characters 

(defconstant $sepNotIntlSep 4)                  ;  StringToDate & Time mask to warn of non-standard separators 

(defconstant $fieldOrderNotIntl 8)              ;  StringToDate & Time mask to warn of non-standard field order 

(defconstant $extraneousStrings 16)             ;  StringToDate & Time mask to warn of unparsable strings in text 

(defconstant $tooManySeps 32)                   ;  StringToDate & Time mask to warn of too many separators 

(defconstant $sepNotConsistent 64)              ;  StringToDate & Time mask to warn of inconsistent separators 

(defconstant $tokenErr #x8100)                  ;  StringToDate & Time mask for 'tokenizer err encountered' 

(defconstant $cantReadUtilities #x8200)
(defconstant $dateTimeNotFound #x8400)
(defconstant $dateTimeInvalid #x8800)

(def-mactype :StringToDateStatus (find-mactype ':SInt16))

(def-mactype :String2DateStatus (find-mactype ':SInt16))
(defrecord DateCacheRecord
   (hidden (:array :SInt16 256))                ;  only for temporary use 
)

;type name? (%define-record :DateCacheRecord (find-record-descriptor ':DateCacheRecord))

(def-mactype :DateCachePtr (find-mactype '(:pointer :DateCacheRecord)))
(defrecord DateTimeRec
   (year :SInt16)
   (month :SInt16)
   (day :SInt16)
   (hour :SInt16)
   (minute :SInt16)
   (second :SInt16)
   (dayOfWeek :SInt16)
)

;type name? (%define-record :DateTimeRec (find-record-descriptor ':DateTimeRec))

(%define-record :LongDateTime (find-record-descriptor ':SInt64))

; #if TARGET_RT_BIG_ENDIAN
(defrecord LongDateCvt
   (:variant
   (
   (c :SInt64)
   )
   (
   (lHigh :UInt32)
   (lLow :UInt32)
   )
   )
)

;type name? (%define-record :LongDateCvt (find-record-descriptor ':LongDateCvt))
#| 
; #else
(defrecord LongDateCvt
   (:variant
   (
   (c :SInt64)
   )
   (
   (lLow :UInt32)
   (lHigh :UInt32)
   )
   )
)

;type name? (%define-record :LongDateCvt (find-record-descriptor ':LongDateCvt))
 |#

; #endif  /* TARGET_RT_BIG_ENDIAN */

(defrecord LongDateRec
   (:variant
   (
   (era :SInt16)
   (year :SInt16)
   (month :SInt16)
   (day :SInt16)
   (hour :SInt16)
   (minute :SInt16)
   (second :SInt16)
   (dayOfWeek :SInt16)
   (dayOfYear :SInt16)
   (weekOfYear :SInt16)
   (pm :SInt16)
   (res1 :SInt16)
   (res2 :SInt16)
   (res3 :SInt16)
   )
   (
   (list (:array :SInt16 14))
   )
                                                ; Index by LongDateField!
   (
   (eraAlt :SInt16)
   (oldDate :DateTimeRec)
   )
   )
)

;type name? (%define-record :LongDateRec (find-record-descriptor ':LongDateRec))

(def-mactype :DateDelta (find-mactype ':SInt8))
(defrecord TogglePB
   (togFlags :signed-long)                      ; caller normally sets low word to dateStdMask=$7F
   (amChars :FourCharCode)                      ; from 'itl0', but uppercased
   (pmChars :FourCharCode)                      ; from 'itl0', but uppercased
   (reserved (:array :signed-long 4))
)

;type name? (%define-record :TogglePB (find-record-descriptor ':TogglePB))
; 
;     Conversion utilities between CF and Carbon time types. 
; 
; 
;  *  UCConvertUTCDateTimeToCFAbsoluteTime()
;  *  
;  *  Discussion:
;  *    Use UCConvertUTCDateTimeToCFAbsoluteTime to convert from a
;  *    UTCDDateTime to a CFAbsoluteTime. Remember that the epoch for
;  *    UTCDateTime is January 1, 1904 while the epoch for CFAbsoluteTime
;  *    is January 1, 2001.
;  *  
;  *  Parameters:
;  *    
;  *    iUTCDate:
;  *      A pointer to a UTCDateTime struct that represents the time you
;  *      wish to convert from.
;  *    
;  *    oCFTime:
;  *      A pointer to a CFAbsoluteTime. On successful return, this will
;  *      contain the converted time from the input time type.
;  *  
;  *  Result:
;  *    A result code indicating whether or not conversion was successful.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_UCConvertUTCDateTimeToCFAbsoluteTime" 
   ((iUTCDate (:pointer :UTCDateTime))
    (oCFTime (:pointer :CFABSOLUTETIME))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  UCConvertSecondsToCFAbsoluteTime()
;  *  
;  *  Discussion:
;  *    Use UCConvertSecondsToCFAbsoluteTime to convert from the normal
;  *    seconds representation of time to a CFAbsoluteTime. Remember that
;  *    the epoch for seconds is January 1, 1904 while the epoch for
;  *    CFAbsoluteTime is January 1, 2001.
;  *  
;  *  Parameters:
;  *    
;  *    iSeconds:
;  *      A UInt32 value that represents the time you wish to convert
;  *      from.
;  *    
;  *    oCFTime:
;  *      A pointer to a CFAbsoluteTime. On successful return, this will
;  *      contain the converted time from the input time type.
;  *  
;  *  Result:
;  *    A result code indicating whether or not conversion was successful.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_UCConvertSecondsToCFAbsoluteTime" 
   ((iSeconds :UInt32)
    (oCFTime (:pointer :CFABSOLUTETIME))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  UCConvertLongDateTimeToCFAbsoluteTime()
;  *  
;  *  Discussion:
;  *    Use UCConvertLongDateTimeToCFAbsoluteTime to convert from a
;  *    LongDateTime to a CFAbsoluteTime. Remember that the epoch for
;  *    LongDateTime is January 1, 1904 while the epoch for
;  *    CFAbsoluteTime is January 1, 2001.
;  *  
;  *  Parameters:
;  *    
;  *    iLongTime:
;  *      A LongDateTime value that represents the time you wish to
;  *      convert from.
;  *    
;  *    oCFTime:
;  *      A pointer to a CFAbsoluteTime. On successful return, this will
;  *      contain the converted time from the input time type.
;  *  
;  *  Result:
;  *    A result code indicating whether or not conversion was successful.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_UCConvertLongDateTimeToCFAbsoluteTime" 
   ((iLongTime :LONGDATETIME)
    (oCFTime (:pointer :CFABSOLUTETIME))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  UCConvertCFAbsoluteTimeToUTCDateTime()
;  *  
;  *  Discussion:
;  *    Use UCConvertCFAbsoluteTimeToUTCDateTime to convert from a
;  *    CFAbsoluteTime to a UTCDateTime. Remember that the epoch for
;  *    UTCDateTime is January 1, 1904 while the epoch for CFAbsoluteTime
;  *    is January 1, 2001.
;  *  
;  *  Parameters:
;  *    
;  *    iCFTime:
;  *      A CFAbsoluteTime value that represents the time you wish to
;  *      convert from.
;  *    
;  *    oUTCDate:
;  *      A pointer to a UTCDateTime. On successful return, this will
;  *      contain the converted time from the CFAbsoluteTime input.
;  *  
;  *  Result:
;  *    A result code indicating whether or not conversion was successful.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_UCConvertCFAbsoluteTimeToUTCDateTime" 
   ((iCFTime :double-float)
    (oUTCDate (:pointer :UTCDateTime))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  UCConvertCFAbsoluteTimeToSeconds()
;  *  
;  *  Discussion:
;  *    Use UCConvertCFAbsoluteTimeToSeconds to convert from a
;  *    CFAbsoluteTime to a UInt32 representation of seconds. Remember
;  *    that the epoch for seconds is January 1, 1904 while the epoch for
;  *    CFAbsoluteTime is January 1, 2001.
;  *  
;  *  Parameters:
;  *    
;  *    iCFTime:
;  *      A CFAbsoluteTime value that represents the time you wish to
;  *      convert from.
;  *    
;  *    oSeconds:
;  *      A pointer to a UInt32. On successful return, this will contain
;  *      the converted time from the CFAbsoluteTime input.
;  *  
;  *  Result:
;  *    A result code indicating whether or not conversion was successful.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_UCConvertCFAbsoluteTimeToSeconds" 
   ((iCFTime :double-float)
    (oSeconds (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  UCConvertCFAbsoluteTimeToLongDateTime()
;  *  
;  *  Discussion:
;  *    Use UCConvertCFAbsoluteTimeToLongDateTime to convert from a
;  *    CFAbsoluteTime to a LongDateTime. Remember that the epoch for
;  *    LongDateTime is January 1, 1904 while the epoch for
;  *    CFAbsoluteTime is January 1, 2001.
;  *  
;  *  Parameters:
;  *    
;  *    iCFTime:
;  *      A CFAbsoluteTime value that represents the time you wish to
;  *      convert from.
;  *    
;  *    oLongDate:
;  *      A pointer to a LongDateTime. On successful return, this will
;  *      contain the converted time from the CFAbsoluteTime input.
;  *  
;  *  Result:
;  *    A result code indicating whether or not conversion was successful.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_UCConvertCFAbsoluteTimeToLongDateTime" 
   ((iCFTime :double-float)
    (oLongDate (:pointer :LONGDATETIME))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;     These routine are available in Carbon with their new name
; 
; 
;  *  DateString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DateString" 
   ((dateTime :signed-long)
    (longFlag :SInt8)
    (result (:pointer :STR255))
    (intlHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TimeString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TimeString" 
   ((dateTime :signed-long)
    (wantSeconds :Boolean)
    (result (:pointer :STR255))
    (intlHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LongDateString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LongDateString" 
   ((dateTime (:pointer :LONGDATETIME))
    (longFlag :SInt8)
    (result (:pointer :STR255))
    (intlHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LongTimeString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LongTimeString" 
   ((dateTime (:pointer :LONGDATETIME))
    (wantSeconds :Boolean)
    (result (:pointer :STR255))
    (intlHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     These routine are available in Carbon and InterfaceLib with their new name
; 
; 
;  *  InitDateCache()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InitDateCache" 
   ((theCache (:pointer :DateCacheRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  StringToDate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StringToDate" 
   ((textPtr :pointer)
    (textLen :signed-long)
    (theCache (:pointer :DateCacheRecord))
    (lengthUsed (:pointer :long))
    (dateTime (:pointer :LongDateRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  StringToTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StringToTime" 
   ((textPtr :pointer)
    (textLen :signed-long)
    (theCache (:pointer :DateCacheRecord))
    (lengthUsed (:pointer :long))
    (dateTime (:pointer :LongDateRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  LongDateToSeconds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LongDateToSeconds" 
   ((lDate (:pointer :LongDateRec))
    (lSecs (:pointer :LONGDATETIME))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LongSecondsToDate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LongSecondsToDate" 
   ((lSecs (:pointer :LONGDATETIME))
    (lDate (:pointer :LongDateRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ToggleDate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ToggleDate" 
   ((lSecs (:pointer :LONGDATETIME))
    (field :SInt8)
    (delta :SInt8)
    (ch :SInt16)
    (params (:pointer :TogglePB))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  ValidDate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ValidDate" 
   ((vDate (:pointer :LongDateRec))
    (flags :signed-long)
    (newSecs (:pointer :LONGDATETIME))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  ReadDateTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ReadDateTime" 
   ((time (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDateTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetDateTime" 
   ((secs (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetDateTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetDateTime" 
   ((time :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetTime" 
   ((d (:pointer :DateTimeRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetTime" 
   ((d (:pointer :DateTimeRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DateToSeconds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DateToSeconds" 
   ((d (:pointer :DateTimeRec))
    (secs (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SecondsToDate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SecondsToDate" 
   ((secs :UInt32)
    (d (:pointer :DateTimeRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     These routine are available in InterfaceLib using their old name.
;     Macros allow using the new names in all source code.
; 
; 
;  *  IUDateString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IUTimeString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IUDatePString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IUTimePString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IULDateString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IULTimeString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if CALL_NOT_IN_CARBON
#| 
; #define DateString(dateTime, longFlag, result, intlHandle)          IUDatePString( dateTime, longFlag, result, intlHandle)
; #define TimeString(dateTime, wantSeconds, result, intlHandle)          IUTimePString(dateTime, wantSeconds, result, intlHandle)
; #define LongDateString(dateTime, longFlag, result, intlHandle)          IULDateString(dateTime, longFlag, result, intlHandle)
; #define LongTimeString(dateTime, wantSeconds, result, intlHandle)          IULTimeString(dateTime, wantSeconds, result, intlHandle)
 |#

; #endif /* CALL_NOT_IN_CARBON */


; #if OLDROUTINENAMES
#| 
; #define String2Date(textPtr, textLen, theCache, lengthUsed, dateTime)           StringToDate(textPtr, textLen, theCache, lengthUsed, dateTime)
; #define String2Time(textPtr, textLen, theCache, lengthUsed, dateTime)           StringToTime(textPtr, textLen, theCache, lengthUsed, dateTime)
; #define LongDate2Secs(lDate, lSecs) LongDateToSeconds(lDate, lSecs)
; #define LongSecs2Date(lSecs, lDate) LongSecondsToDate(lSecs, lDate)
; #define Date2Secs(d, secs) DateToSeconds(d, secs)
; #define Secs2Date(secs, d) SecondsToDate(secs, d)
 |#

; #endif  /* OLDROUTINENAMES */

; 
;  *  iudatestring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  iudatepstring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  iutimestring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  iutimepstring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  iuldatestring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  iultimestring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __DATETIMEUTILS__ */


(provide-interface "DateTimeUtils")