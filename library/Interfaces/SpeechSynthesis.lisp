(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SpeechSynthesis.h"
; at Sunday July 2,2006 7:24:45 pm.
; 
;      File:       SpeechSynthesis/SpeechSynthesis.h
;  
;      Contains:   Speech Interfaces.
;  
;      Version:    SpeechSynthesis-3.2.19~13
;  
;      Copyright:  © 1989-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __SPEECHSYNTHESIS__
; #define __SPEECHSYNTHESIS__
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
; #pragma options align=mac68k

(defconstant $kTextToSpeechSynthType :|ttsc|)
(defconstant $kTextToSpeechVoiceType :|ttvd|)
(defconstant $kTextToSpeechVoiceFileType :|ttvf|)
(defconstant $kTextToSpeechVoiceBundleType :|ttvb|)

(defconstant $kNoEndingProsody 1)
(defconstant $kNoSpeechInterrupt 2)
(defconstant $kPreflightThenPause 4)

(defconstant $kImmediate 0)
(defconstant $kEndOfWord 1)
(defconstant $kEndOfSentence 2)
; ------------------------------------------
;  GetSpeechInfo & SetSpeechInfo selectors  
; ------------------------------------------

(defconstant $soStatus :|stat|)
(defconstant $soErrors :|erro|)
(defconstant $soInputMode :|inpt|)
(defconstant $soCharacterMode :|char|)
(defconstant $soNumberMode :|nmbr|)
(defconstant $soRate :|rate|)
(defconstant $soPitchBase :|pbas|)
(defconstant $soPitchMod :|pmod|)
(defconstant $soVolume :|volm|)
(defconstant $soSynthType :|vers|)
(defconstant $soRecentSync :|sync|)
(defconstant $soPhonemeSymbols :|phsy|)
(defconstant $soCurrentVoice :|cvox|)
(defconstant $soCommandDelimiter :|dlim|)
(defconstant $soReset :|rset|)
(defconstant $soCurrentA5 :|myA5|)
(defconstant $soRefCon :|refc|)
(defconstant $soTextDoneCallBack :|tdcb|)       ;  use with SpeechTextDoneProcPtr

(defconstant $soSpeechDoneCallBack :|sdcb|)     ;  use with SpeechDoneProcPtr

(defconstant $soSyncCallBack :|sycb|)           ;  use with SpeechSyncProcPtr

(defconstant $soErrorCallBack :|ercb|)          ;  use with SpeechErrorProcPtr

(defconstant $soPhonemeCallBack :|phcb|)        ;  use with SpeechPhonemeProcPtr

(defconstant $soWordCallBack :|wdcb|)
(defconstant $soSynthExtension :|xtnd|)
(defconstant $soSoundOutput :|sndo|)
(defconstant $soOutputToFileWithCFURL :|opaf|)  ;  Pass a CFURLRef to write to this file, NULL to generate sound.

; ------------------------------------------
;  Speaking Mode Constants                  
; ------------------------------------------

(defconstant $modeText :|TEXT|)                 ;  input mode constants             

(defconstant $modePhonemes :|PHON|)
(defconstant $modeNormal :|NORM|)               ;  character mode and number mode constants 

(defconstant $modeLiteral :|LTRL|)

(defconstant $soVoiceDescription :|info|)
(defconstant $soVoiceFile :|fref|)
; 
;    The speech manager sources may or may not need SpeechChannelRecord.
;    If not, the .i file should be changed to use the opaque mechanism.
; 
(defrecord SpeechChannelRecord
   (data (:array :signed-long 1))
)

;type name? (%define-record :SpeechChannelRecord (find-record-descriptor ':SpeechChannelRecord))

(def-mactype :SpeechChannel (find-mactype '(:pointer :SpeechChannelRecord)))
(defrecord VoiceSpec
   (creator :OSType)
   (id :OSType)
)

;type name? (%define-record :VoiceSpec (find-record-descriptor ':VoiceSpec))

(def-mactype :VoiceSpecPtr (find-mactype '(:pointer :VoiceSpec)))

(defconstant $kNeuter 0)
(defconstant $kMale 1)
(defconstant $kFemale 2)
(defrecord VoiceDescription
   (length :signed-long)
   (voice :VoiceSpec)
   (version :signed-long)
   (name (:string 63))
   (comment (:string 255))
   (gender :SInt16)
   (age :SInt16)
   (script :SInt16)
   (language :SInt16)
   (region :SInt16)
   (reserved (:array :signed-long 4))
)

;type name? (%define-record :VoiceDescription (find-record-descriptor ':VoiceDescription))
(defrecord VoiceFileInfo
   (fileSpec :FSSpec)
   (resID :SInt16)
)

;type name? (%define-record :VoiceFileInfo (find-record-descriptor ':VoiceFileInfo))
(defrecord SpeechStatusInfo
   (outputBusy :Boolean)
   (outputPaused :Boolean)
   (inputBytesLeft :signed-long)
   (phonemeCode :SInt16)
)

;type name? (%define-record :SpeechStatusInfo (find-record-descriptor ':SpeechStatusInfo))
(defrecord SpeechErrorInfo
   (count :SInt16)
   (oldest :SInt16)
   (oldPos :signed-long)
   (newest :SInt16)
   (newPos :signed-long)
)

;type name? (%define-record :SpeechErrorInfo (find-record-descriptor ':SpeechErrorInfo))
(defrecord SpeechVersionInfo
   (synthType :OSType)
   (synthSubType :OSType)
   (synthManufacturer :OSType)
   (synthFlags :signed-long)
   (synthVersion :NumVersion)
)

;type name? (%define-record :SpeechVersionInfo (find-record-descriptor ':SpeechVersionInfo))
(defrecord PhonemeInfo
   (opcode :SInt16)
   (phStr (:string 15))
   (exampleStr (:string 31))
   (hiliteStart :SInt16)
   (hiliteEnd :SInt16)
)

;type name? (%define-record :PhonemeInfo (find-record-descriptor ':PhonemeInfo))
(defrecord PhonemeDescriptor
   (phonemeCount :SInt16)
   (thePhonemes (:array :PhonemeInfo 1))
)

;type name? (%define-record :PhonemeDescriptor (find-record-descriptor ':PhonemeDescriptor))
(defrecord SpeechXtndData
   (synthCreator :OSType)
   (synthData (:array :unsigned-byte 2))
)

;type name? (%define-record :SpeechXtndData (find-record-descriptor ':SpeechXtndData))
(defrecord DelimiterInfo
   (startDelimiter (:array :unsigned-byte 2))
   (endDelimiter (:array :unsigned-byte 2))
)

;type name? (%define-record :DelimiterInfo (find-record-descriptor ':DelimiterInfo))

(def-mactype :SpeechTextDoneProcPtr (find-mactype ':pointer)); (SpeechChannel chan , long refCon , const void ** nextBuf , unsigned long * byteLen , long * controlFlags)

(def-mactype :SpeechDoneProcPtr (find-mactype ':pointer)); (SpeechChannel chan , long refCon)

(def-mactype :SpeechSyncProcPtr (find-mactype ':pointer)); (SpeechChannel chan , long refCon , OSType syncMessage)

(def-mactype :SpeechErrorProcPtr (find-mactype ':pointer)); (SpeechChannel chan , long refCon , OSErr theError , long bytePos)

(def-mactype :SpeechPhonemeProcPtr (find-mactype ':pointer)); (SpeechChannel chan , long refCon , short phonemeOpcode)

(def-mactype :SpeechWordProcPtr (find-mactype ':pointer)); (SpeechChannel chan , long refCon , unsigned long wordPos , unsigned short wordLen)

(def-mactype :SpeechTextDoneUPP (find-mactype '(:pointer :OpaqueSpeechTextDoneProcPtr)))

(def-mactype :SpeechDoneUPP (find-mactype '(:pointer :OpaqueSpeechDoneProcPtr)))

(def-mactype :SpeechSyncUPP (find-mactype '(:pointer :OpaqueSpeechSyncProcPtr)))

(def-mactype :SpeechErrorUPP (find-mactype '(:pointer :OpaqueSpeechErrorProcPtr)))

(def-mactype :SpeechPhonemeUPP (find-mactype '(:pointer :OpaqueSpeechPhonemeProcPtr)))

(def-mactype :SpeechWordUPP (find-mactype '(:pointer :OpaqueSpeechWordProcPtr)))
; 
;  *  NewSpeechTextDoneUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSpeechTextDoneUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSpeechTextDoneProcPtr)
() )
; 
;  *  NewSpeechDoneUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSpeechDoneUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSpeechDoneProcPtr)
() )
; 
;  *  NewSpeechSyncUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSpeechSyncUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSpeechSyncProcPtr)
() )
; 
;  *  NewSpeechErrorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSpeechErrorUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSpeechErrorProcPtr)
() )
; 
;  *  NewSpeechPhonemeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSpeechPhonemeUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSpeechPhonemeProcPtr)
() )
; 
;  *  NewSpeechWordUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSpeechWordUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSpeechWordProcPtr)
() )
; 
;  *  DisposeSpeechTextDoneUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSpeechTextDoneUPP" 
   ((userUPP (:pointer :OpaqueSpeechTextDoneProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSpeechDoneUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSpeechDoneUPP" 
   ((userUPP (:pointer :OpaqueSpeechDoneProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSpeechSyncUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSpeechSyncUPP" 
   ((userUPP (:pointer :OpaqueSpeechSyncProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSpeechErrorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSpeechErrorUPP" 
   ((userUPP (:pointer :OpaqueSpeechErrorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSpeechPhonemeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSpeechPhonemeUPP" 
   ((userUPP (:pointer :OpaqueSpeechPhonemeProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSpeechWordUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSpeechWordUPP" 
   ((userUPP (:pointer :OpaqueSpeechWordProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSpeechTextDoneUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSpeechTextDoneUPP" 
   ((chan (:pointer :SpeechChannelRecord))
    (refCon :signed-long)
    (nextBuf :pointer)
    (byteLen (:pointer :UInt32))
    (controlFlags (:pointer :long))
    (userUPP (:pointer :OpaqueSpeechTextDoneProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSpeechDoneUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSpeechDoneUPP" 
   ((chan (:pointer :SpeechChannelRecord))
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueSpeechDoneProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSpeechSyncUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSpeechSyncUPP" 
   ((chan (:pointer :SpeechChannelRecord))
    (refCon :signed-long)
    (syncMessage :OSType)
    (userUPP (:pointer :OpaqueSpeechSyncProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSpeechErrorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSpeechErrorUPP" 
   ((chan (:pointer :SpeechChannelRecord))
    (refCon :signed-long)
    (theError :SInt16)
    (bytePos :signed-long)
    (userUPP (:pointer :OpaqueSpeechErrorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSpeechPhonemeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSpeechPhonemeUPP" 
   ((chan (:pointer :SpeechChannelRecord))
    (refCon :signed-long)
    (phonemeOpcode :SInt16)
    (userUPP (:pointer :OpaqueSpeechPhonemeProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSpeechWordUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSpeechWordUPP" 
   ((chan (:pointer :SpeechChannelRecord))
    (refCon :signed-long)
    (wordPos :UInt32)
    (wordLen :UInt16)
    (userUPP (:pointer :OpaqueSpeechWordProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SpeechManagerVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_SpeechManagerVersion" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :NumVersion
() )
; 
;  *  MakeVoiceSpec()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_MakeVoiceSpec" 
   ((creator :OSType)
    (id :OSType)
    (voice (:pointer :VoiceSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CountVoices()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_CountVoices" 
   ((numVoices (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetIndVoice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_GetIndVoice" 
   ((index :SInt16)
    (voice (:pointer :VoiceSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetVoiceDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_GetVoiceDescription" 
   ((voice (:pointer :VoiceSpec))
    (info (:pointer :VoiceDescription))
    (infoLength :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetVoiceInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_GetVoiceInfo" 
   ((voice (:pointer :VoiceSpec))
    (selector :OSType)
    (voiceInfo :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewSpeechChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_NewSpeechChannel" 
   ((voice (:pointer :VoiceSpec))               ;  can be NULL 
    (chan (:pointer :SPEECHCHANNEL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DisposeSpeechChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_DisposeSpeechChannel" 
   ((chan (:pointer :SpeechChannelRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SpeakString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_SpeakString" 
   ((textToBeSpoken (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SpeakText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_SpeakText" 
   ((chan (:pointer :SpeechChannelRecord))
    (textBuf :pointer)
    (textBytes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SpeakBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_SpeakBuffer" 
   ((chan (:pointer :SpeechChannelRecord))
    (textBuf :pointer)
    (textBytes :UInt32)
    (controlFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  StopSpeech()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_StopSpeech" 
   ((chan (:pointer :SpeechChannelRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  StopSpeechAt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_StopSpeechAt" 
   ((chan (:pointer :SpeechChannelRecord))
    (whereToStop :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PauseSpeechAt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_PauseSpeechAt" 
   ((chan (:pointer :SpeechChannelRecord))
    (whereToPause :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ContinueSpeech()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_ContinueSpeech" 
   ((chan (:pointer :SpeechChannelRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SpeechBusy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_SpeechBusy" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SpeechBusySystemWide()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_SpeechBusySystemWide" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetSpeechRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_SetSpeechRate" 
   ((chan (:pointer :SpeechChannelRecord))
    (rate :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetSpeechRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_GetSpeechRate" 
   ((chan (:pointer :SpeechChannelRecord))
    (rate (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetSpeechPitch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_SetSpeechPitch" 
   ((chan (:pointer :SpeechChannelRecord))
    (pitch :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetSpeechPitch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_GetSpeechPitch" 
   ((chan (:pointer :SpeechChannelRecord))
    (pitch (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetSpeechInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_SetSpeechInfo" 
   ((chan (:pointer :SpeechChannelRecord))
    (selector :OSType)
    (speechInfo :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetSpeechInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_GetSpeechInfo" 
   ((chan (:pointer :SpeechChannelRecord))
    (selector :OSType)
    (speechInfo :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  TextToPhonemes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_TextToPhonemes" 
   ((chan (:pointer :SpeechChannelRecord))
    (textBuf :pointer)
    (textBytes :UInt32)
    (phonemeBuf :Handle)
    (phonemeBytes (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  UseDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechLib 1.0 and later
;  

(deftrap-inline "_UseDictionary" 
   ((chan (:pointer :SpeechChannelRecord))
    (dictionary :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __SPEECHSYNTHESIS__ */


(provide-interface "SpeechSynthesis")