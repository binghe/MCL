(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SpeechRecognition.h"
; at Sunday July 2,2006 7:25:15 pm.
; 
;      File:       SpeechRecognition/SpeechRecognition.h
;  
;      Contains:   Apple Speech Recognition Toolbox Interfaces.
;  
;      Version:    SpeechRecognition-3.3.9~8
;  
;      Copyright:  © 1992-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __SPEECHRECOGNITION__
; #define __SPEECHRECOGNITION__
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
;  Error Codes [Speech recognition gets -5100 through -5199] 

(defconstant $kSRNotAvailable -5100)            ;  the service requested is not avail or applicable 

(defconstant $kSRInternalError -5101)           ;  a system internal or hardware error condition 

(defconstant $kSRComponentNotFound -5102)       ;  a needed system resource was not located 

(defconstant $kSROutOfMemory -5103)             ;  an out of memory error occurred in the toolbox memory space 

(defconstant $kSRNotASpeechObject -5104)        ;  the object specified is no longer or never was valid 

(defconstant $kSRBadParameter -5105)            ;  an invalid parameter was specified 

(defconstant $kSRParamOutOfRange -5106)         ;  when we say 0-100, don't pass in 101. 

(defconstant $kSRBadSelector -5107)             ;  an unrecognized selector was specified 

(defconstant $kSRBufferTooSmall -5108)          ;  returned from attribute access functions 

(defconstant $kSRNotARecSystem -5109)           ;  the object used was not a SRRecognitionSystem 

(defconstant $kSRFeedbackNotAvail -5110)        ;  there is no feedback window associated with SRRecognizer 

(defconstant $kSRCantSetProperty -5111)         ;  a non-settable property was specified 

(defconstant $kSRCantGetProperty -5112)         ;  a non-gettable property was specified 

(defconstant $kSRCantSetDuringRecognition -5113);  the property can't be set while recognition is in progress -- do before or between utterances. 

(defconstant $kSRAlreadyListening -5114)        ;  in response to SRStartListening 

(defconstant $kSRNotListeningState -5115)       ;  in response to SRStopListening 

(defconstant $kSRModelMismatch -5116)           ;  no acoustical models are avail to match request 

(defconstant $kSRNoClientLanguageModel -5117)   ;  trying to access a non-specified SRLanguageModel 

(defconstant $kSRNoPendingUtterances -5118)     ;  nothing to continue search on 

(defconstant $kSRRecognitionCanceled -5119)     ;  an abort error occurred during search 

(defconstant $kSRRecognitionDone -5120)         ;  search has finished, but nothing was recognized 

(defconstant $kSROtherRecAlreadyModal -5121)    ;  another recognizer is modal at the moment, so can't set this recognizer's kSRBlockModally property right now 

(defconstant $kSRHasNoSubItems -5122)           ;  SRCountItems or related routine was called on an object without subelements -- e.g. a word -- rather than phrase, path, or LM. 

(defconstant $kSRSubItemNotFound -5123)         ;  returned when accessing a non-existent sub item of a container 

(defconstant $kSRLanguageModelTooBig -5124)     ;  Cant build language models so big 

(defconstant $kSRAlreadyReleased -5125)         ;  this object has already been released before 

(defconstant $kSRAlreadyFinished -5126)         ;  the language model can't be finished twice 

(defconstant $kSRWordNotFound -5127)            ;  the spelling couldn't be found in lookup(s) 

(defconstant $kSRNotFinishedWithRejection -5128);  property not found because the LMObj is not finished with rejection 

(defconstant $kSRExpansionTooDeep -5129)        ;  Language model is left recursive or is embedded too many levels 

(defconstant $kSRTooManyElements -5130)         ;  Too many elements added to phrase or path or other langauge model object 

(defconstant $kSRCantAdd -5131)                 ;  Can't add given type of object to the base SRLanguageObject (e.g.in SRAddLanguageObject)   

(defconstant $kSRSndInSourceDisconnected -5132) ;  Sound input source is disconnected 

(defconstant $kSRCantReadLanguageObject -5133)  ;  An error while trying to create new Language object from file or pointer -- possibly bad format 
;  non-release debugging error codes are included here 
;  you'd better wait for this feature in a future release 

(defconstant $kSRNotImplementedYet -5199)
;  Type Definitions 

(def-mactype :SRSpeechObject (find-mactype '(:pointer :OpaqueSRSpeechObject)))

(def-mactype :SRRecognitionSystem (find-mactype ':SRSpeechObject))

(def-mactype :SRRecognizer (find-mactype ':SRSpeechObject))

(def-mactype :SRSpeechSource (find-mactype ':SRSpeechObject))

(def-mactype :SRRecognitionResult (find-mactype ':SRSpeechSource))

(def-mactype :SRLanguageObject (find-mactype ':SRSpeechObject))

(def-mactype :SRLanguageModel (find-mactype ':SRLanguageObject))

(def-mactype :SRPath (find-mactype ':SRLanguageObject))

(def-mactype :SRPhrase (find-mactype ':SRLanguageObject))

(def-mactype :SRWord (find-mactype ':SRLanguageObject))
;  between 0 and 100 

(def-mactype :SRSpeedSetting (find-mactype ':UInt16))
;  between 0 and 100 

(def-mactype :SRRejectionLevel (find-mactype ':UInt16))
;  When an event occurs, the user supplied proc will be called with a pointer   
;   to the param passed in and a flag to indicate conditions such               
;   as interrupt time or system background time.                                
(defrecord SRCallBackStruct
   (what :signed-long)                          ;  one of notification flags 
   (message :signed-long)                       ;  contains SRRecognitionResult id 
   (instance (:pointer :OpaqueSRSpeechObject))  ;  ID of recognizer being notified 
   (status :SInt16)                             ;  result status of last search 
   (flags :SInt16)                              ;  non-zero if occurs during interrupt 
   (refCon :signed-long)                        ;  user defined - set from SRCallBackParam 
)

;type name? (%define-record :SRCallBackStruct (find-record-descriptor ':SRCallBackStruct))
;  Call back procedure definition 

(def-mactype :SRCallBackProcPtr (find-mactype ':pointer)); (SRCallBackStruct * param)

(def-mactype :SRCallBackUPP (find-mactype '(:pointer :OpaqueSRCallBackProcPtr)))
; 
;  *  NewSRCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSRCallBackUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSRCallBackProcPtr)
() )
; 
;  *  DisposeSRCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSRCallBackUPP" 
   ((userUPP (:pointer :OpaqueSRCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSRCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSRCallBackUPP" 
   ((param (:pointer :SRCallBackStruct))
    (userUPP (:pointer :OpaqueSRCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
(defrecord SRCallBackParam
   (callBack (:pointer :OpaqueSRCallBackProcPtr))
   (refCon :signed-long)
)

;type name? (%define-record :SRCallBackParam (find-record-descriptor ':SRCallBackParam))
;  Recognition System Types 

(defconstant $kSRDefaultRecognitionSystemID 0)
;  Recognition System Properties 

(defconstant $kSRFeedbackAndListeningModes :|fbwn|);  short: one of kSRNoFeedbackHasListenModes, kSRHasFeedbackHasListenModes, kSRNoFeedbackNoListenModes 

(defconstant $kSRRejectedWord :|rejq|)          ;  the SRWord used to represent a rejection 

(defconstant $kSRCleanupOnClientExit :|clup|)   ;  Boolean: Default is true. The rec system and everything it owns is disposed when the client application quits 


(defconstant $kSRNoFeedbackNoListenModes 0)     ;  next allocated recognizer has no feedback window and doesn't use listening modes   

(defconstant $kSRHasFeedbackHasListenModes 1)   ;  next allocated recognizer has feedback window and uses listening modes          

(defconstant $kSRNoFeedbackHasListenModes 2)    ;  next allocated recognizer has no feedback window but does use listening modes  

;  Speech Source Types 

(defconstant $kSRDefaultSpeechSource 0)
(defconstant $kSRLiveDesktopSpeechSource :|dklv|);  live desktop sound input 

(defconstant $kSRCanned22kHzSpeechSource :|ca22|);  AIFF file based 16 bit, 22.050 KHz sound input 

;  Notification via Apple Event or Callback 
;  Notification Flags 

(defconstant $kSRNotifyRecognitionBeginning 1)  ;  recognition can begin. client must now call SRContinueRecognition or SRCancelRecognition 
;  recognition has terminated. result (if any) is available. 

(defconstant $kSRNotifyRecognitionDone 2)
;  Apple Event selectors 
;  AppleEvent message class  

(defconstant $kAESpeechSuite :|sprc|)
;  AppleEvent message event ids 

(defconstant $kAESpeechDone :|srsd|)
(defconstant $kAESpeechDetected :|srbd|)
;  AppleEvent Parameter ids 

(defconstant $keySRRecognizer :|krec|)
(defconstant $keySRSpeechResult :|kspr|)
(defconstant $keySRSpeechStatus :|ksst|)
;  AppleEvent Parameter types 

(defconstant $typeSRRecognizer :|trec|)
(defconstant $typeSRSpeechResult :|tspr|)
;  SRRecognizer Properties 

(defconstant $kSRNotificationParam :|noti|)     ;  see notification flags below 

(defconstant $kSRCallBackParam :|call|)         ;  type SRCallBackParam 

(defconstant $kSRSearchStatusParam :|stat|)     ;  see status flags below 

(defconstant $kSRAutoFinishingParam :|afin|)    ;  automatic finishing applied on LM for search 

(defconstant $kSRForegroundOnly :|fgon|)        ;  Boolean. Default is true. If true, client recognizer only active when in foreground.   

(defconstant $kSRBlockBackground :|blbg|)       ;  Boolean. Default is false. If true, when client recognizer in foreground, rest of LMs are inactive.    

(defconstant $kSRBlockModally :|blmd|)          ;  Boolean. Default is false. When true, this client's LM is only active LM; all other LMs are inactive. Be nice, don't be modal for long periods! 

(defconstant $kSRWantsResultTextDrawn :|txfb|)  ;  Boolean. Default is true. If true, search results are posted to Feedback window 

(defconstant $kSRWantsAutoFBGestures :|dfbr|)   ;  Boolean. Default is true. If true, client needn't call SRProcessBegin/End to get default feedback behavior 

(defconstant $kSRSoundInVolume :|volu|)         ;  short in [0..100] log scaled sound input power. Can't set this property 

(defconstant $kSRReadAudioFSSpec :|aurd|)       ;  *FSSpec. Specify FSSpec where raw audio is to be read (AIFF format) using kSRCanned22kHzSpeechSource. Reads until EOF 

(defconstant $kSRCancelOnSoundOut :|caso|)      ;  Boolean: Default is true.  If any sound is played out during utterance, recognition is aborted. 

(defconstant $kSRSpeedVsAccuracyParam :|sped|)  ;  SRSpeedSetting between 0 and 100 

;  0 means more accurate but slower. 
;  100 means (much) less accurate but faster. 

(defconstant $kSRUseToggleListen 0)             ;  listen key modes 

(defconstant $kSRUsePushToTalk 1)

(defconstant $kSRListenKeyMode :|lkmd|)         ;  short: either kSRUseToggleListen or kSRUsePushToTalk 

(defconstant $kSRListenKeyCombo :|lkey|)        ;  short: Push-To-Talk key combination; high byte is high byte of event->modifiers, the low byte is the keycode from event->message 

(defconstant $kSRListenKeyName :|lnam|)         ;  Str63: string representing ListenKeyCombo 

(defconstant $kSRKeyWord :|kwrd|)               ;  Str255: keyword preceding spoken commands in kSRUseToggleListen mode 

(defconstant $kSRKeyExpected :|kexp|)           ;  Boolean: Must the PTT key be depressed or the key word spoken before recognition can occur? 

;  Operational Status Flags 

(defconstant $kSRIdleRecognizer 1)              ;  engine is not active 

(defconstant $kSRSearchInProgress 2)            ;  search is in progress 

(defconstant $kSRSearchWaitForAllClients 4)     ;  search is suspended waiting on all clients' input 

(defconstant $kSRMustCancelSearch 8)            ;  something has occurred (sound played, non-speech detected) requiring the search to abort 
;  we're about to start searching 

(defconstant $kSRPendingSearch 16)
;  Recognition Result Properties 

(defconstant $kSRTEXTFormat :|TEXT|)            ;  raw text in user supplied memory 

(defconstant $kSRPhraseFormat :|lmph|)          ;  SRPhrase containing result words 

(defconstant $kSRPathFormat :|lmpt|)            ;  SRPath containing result phrases or words 

(defconstant $kSRLanguageModelFormat :|lmfm|)   ;  top level SRLanguageModel for post parse 

;  SRLanguageObject Family Properties 

(defconstant $kSRSpelling :|spel|)              ;  spelling of a SRWord or SRPhrase or SRPath, or name of a SRLanguageModel 

(defconstant $kSRLMObjType :|lmtp|)             ;  Returns one of SRLanguageObject Types listed below 

(defconstant $kSRRefCon :|refc|)                ;  4 bytes of user storage 

(defconstant $kSROptional :|optl|)              ;  Boolean -- true if SRLanguageObject is optional    

(defconstant $kSREnabled :|enbl|)               ;  Boolean -- true if SRLanguageObject enabled 

(defconstant $kSRRepeatable :|rptb|)            ;  Boolean -- true if SRLanguageObject is repeatable 

(defconstant $kSRRejectable :|rjbl|)            ;  Boolean -- true if SRLanguageObject is rejectable (Recognition System's kSRRejectedWord 
;        object can be returned in place of SRLanguageObject with this property)   

(defconstant $kSRRejectionLevel :|rjct|)        ;  SRRejectionLevel between 0 and 100 

;  LM Object Types -- returned as kSRLMObjType property of language model objects 

(defconstant $kSRLanguageModelType :|lmob|)     ;  SRLanguageModel 

(defconstant $kSRPathType :|path|)              ;  SRPath 

(defconstant $kSRPhraseType :|phra|)            ;  SRPhrase 

(defconstant $kSRWordType :|word|)              ;  SRWord 

;  a normal and reasonable rejection level 

(defconstant $kSRDefaultRejectionLevel 50)
; ******************************************************************************
;                       NOTES ON USING THE API                                  
;                                                                               
;       All operations (with the exception of SRGetRecognitionSystem) are       
;       directed toward an object allocated or begot from New, Get and Read     
;       type calls.                                                             
;                                                                               
;       There is a simple rule in dealing with allocation and disposal:         
;                                                                               
;       *   all toolbox allocations are obtained from a SRRecognitionSystem     
;                                                                               
;       *   if you obtain an object via New or Get, then you own a reference    
;           to that object and it must be released via SRReleaseObject when     
;           you no longer need it                                               
;                                                                               
;       *   when you receive a SRRecognitionResult object via AppleEvent or     
;           callback, it has essentially been created on your behalf and so     
;           you are responsible for releasing it as above                       
;                                                                               
;       *   when you close a SRRecognitionSystem, all remaining objects which       
;           were allocated with it will be forcefully released and any          
;           remaining references to those objects will be invalid.              
;                                                                               
;       This translates into a very simple guideline:                           
;           If you allocate it or have it allocated for you, you must release   
;           it.  If you are only peeking at it, then don't release it.          
;                                                                               
; ******************************************************************************
;  Opening and Closing of the SRRecognitionSystem 
; 
;  *  SROpenRecognitionSystem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SROpenRecognitionSystem" 
   ((system (:pointer :SRRECOGNITIONSYSTEM))
    (systemID :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRCloseRecognitionSystem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRCloseRecognitionSystem" 
   ((system (:pointer :OpaqueSRSpeechObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Accessing Properties of any Speech Object 
; 
;  *  SRSetProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRSetProperty" 
   ((srObject (:pointer :OpaqueSRSpeechObject))
    (selector :OSType)
    (property :pointer)
    (propertyLen :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRGetProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRGetProperty" 
   ((srObject (:pointer :OpaqueSRSpeechObject))
    (selector :OSType)
    (property :pointer)
    (propertyLen (:pointer :SIZE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Any object obtained via New or Get type calls must be released 
; 
;  *  SRReleaseObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRReleaseObject" 
   ((srObject (:pointer :OpaqueSRSpeechObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRGetReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRGetReference" 
   ((srObject (:pointer :OpaqueSRSpeechObject))
    (newObjectRef (:pointer :SRSpeechObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  SRRecognizer Instance Functions 
; 
;  *  SRNewRecognizer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRNewRecognizer" 
   ((system (:pointer :OpaqueSRSpeechObject))
    (recognizer (:pointer :SRRECOGNIZER))
    (sourceID :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRStartListening()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRStartListening" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRStopListening()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRStopListening" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRSetLanguageModel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRSetLanguageModel" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
    (languageModel (:pointer :OpaqueSRSpeechObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRGetLanguageModel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRGetLanguageModel" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
    (languageModel (:pointer :SRLANGUAGEMODEL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRContinueRecognition()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRContinueRecognition" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRCancelRecognition()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRCancelRecognition" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRIdle" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Language Model Building and Manipulation Functions 
; 
;  *  SRNewLanguageModel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRNewLanguageModel" 
   ((system (:pointer :OpaqueSRSpeechObject))
    (model (:pointer :SRLANGUAGEMODEL))
    (name :pointer)
    (nameLength :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRNewPath()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRNewPath" 
   ((system (:pointer :OpaqueSRSpeechObject))
    (path (:pointer :SRPATH))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRNewPhrase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRNewPhrase" 
   ((system (:pointer :OpaqueSRSpeechObject))
    (phrase (:pointer :SRPHRASE))
    (text :pointer)
    (textLength :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRNewWord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRNewWord" 
   ((system (:pointer :OpaqueSRSpeechObject))
    (word (:pointer :SRWORD))
    (text :pointer)
    (textLength :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Operations on any object of the SRLanguageObject family 
; 
;  *  SRPutLanguageObjectIntoHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRPutLanguageObjectIntoHandle" 
   ((languageObject (:pointer :OpaqueSRSpeechObject))
    (lobjHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRPutLanguageObjectIntoDataFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRPutLanguageObjectIntoDataFile" 
   ((languageObject (:pointer :OpaqueSRSpeechObject))
    (fRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRNewLanguageObjectFromHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRNewLanguageObjectFromHandle" 
   ((system (:pointer :OpaqueSRSpeechObject))
    (languageObject (:pointer :SRLanguageObject))
    (lObjHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRNewLanguageObjectFromDataFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRNewLanguageObjectFromDataFile" 
   ((system (:pointer :OpaqueSRSpeechObject))
    (languageObject (:pointer :SRLanguageObject))
    (fRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SREmptyLanguageObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SREmptyLanguageObject" 
   ((languageObject (:pointer :OpaqueSRSpeechObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRChangeLanguageObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRChangeLanguageObject" 
   ((languageObject (:pointer :OpaqueSRSpeechObject))
    (text :pointer)
    (textLength :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRAddLanguageObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRAddLanguageObject" 
   ((base (:pointer :OpaqueSRSpeechObject))
    (addon (:pointer :OpaqueSRSpeechObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRAddText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRAddText" 
   ((base (:pointer :OpaqueSRSpeechObject))
    (text :pointer)
    (textLength :signed-long)
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRRemoveLanguageObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRRemoveLanguageObject" 
   ((base (:pointer :OpaqueSRSpeechObject))
    (toRemove (:pointer :OpaqueSRSpeechObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Traversing SRRecognitionResults or SRLanguageObjects 
; 
;  *  SRCountItems()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRCountItems" 
   ((container (:pointer :OpaqueSRSpeechObject))
    (count (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRGetIndexedItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRGetIndexedItem" 
   ((container (:pointer :OpaqueSRSpeechObject))
    (item (:pointer :SRSpeechObject))
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRSetIndexedItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRSetIndexedItem" 
   ((container (:pointer :OpaqueSRSpeechObject))
    (item (:pointer :OpaqueSRSpeechObject))
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRRemoveIndexedItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRRemoveIndexedItem" 
   ((container (:pointer :OpaqueSRSpeechObject))
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Utilizing the System Feedback Window 
; 
;  *  SRDrawText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRDrawText" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
    (dispText :pointer)
    (dispLength :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRDrawRecognizedText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRDrawRecognizedText" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
    (dispText :pointer)
    (dispLength :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRSpeakText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRSpeakText" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
    (speakText :pointer)
    (speakLength :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRSpeakAndDrawText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRSpeakAndDrawText" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
    (text :pointer)
    (textLength :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRStopSpeech()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRStopSpeech" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRSpeechBusy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRSpeechBusy" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SRProcessBegin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRProcessBegin" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
    (failed :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SRProcessEnd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
;  

(deftrap-inline "_SRProcessEnd" 
   ((recognizer (:pointer :OpaqueSRSpeechObject))
    (failed :Boolean)
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

; #endif /* __SPEECHRECOGNITION__ */


(provide-interface "SpeechRecognition")