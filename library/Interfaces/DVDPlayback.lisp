(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DVDPlayback.h"
; at Sunday July 2,2006 7:27:43 pm.
; 
;      File:       DVDPlayback/DVDPlayback.h
; 
;      Contains:   API for communicating with DVD playback engine.
; 
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
; 
;      Copyright:  (c) 2001-2003 by Apple Computer, Inc., all rights reserved.
; 
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
; 
;                      http://developer.apple.com/bugreporter/
; 
; 
; -----------------------------------------------------
; 	The DVD Playback application programming interface (API) gives you access to the DVDPlayback framework, 
; 	allowing you to offer DVD playback functionality from within your application.
; 
; 	During a playback "session," the application must perform specific minimum operations, as follows:
; 	1.	Initialize the playback framework with DVDInitialize. The DVDPlayback framework can only be opened by one
; 		process at a time. If a second process attempts to initialize it, an error will be returned.
; 	2.	Set the playback grafport with DVDSetVideoPort(Carbon) or the window with DVDSetVideoWindowID(Cocoa).
; 	3.	Set the gDevice with DVDSetVideoDevice(Carbon) or the display with DVDSetVideoDisplay(Cocoa).
; 	4.	Set the video bounds with DVDSetVideoBounds. This is the bounds within the grafport/window and is in port coordinates.
; 	5.	Open the media with DVDOpenMediaVolume (DVD disc) or DVDOpenMediaFile (VIDEO_TS folder).
; 	6.	Play the media
; 	7.	When finished or switching media, close with the appropriate call (DVDCloseMediaVolume or DVDCloseMediaFile)
; 	8.	When quitting or finishing session, tear down the DVDPlayback framework with DVDDispose.
; -----------------------------------------------------
; #ifndef __DVDPLAYBACK__
; #define __DVDPLAYBACK__

(require-interface "ApplicationServices/ApplicationServices")

(require-interface "Security/Authorization")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; -----------------------------------------------------
;  DVDErrorCode - Errors returned by the framework (-70000 to -70099)
; -----------------------------------------------------

(defconstant $kDVDErrorUnknown -70001)          ; 	Catch all error

(defconstant $kDVDErrorInitializingLib -70002)  ; 	There was an error initializing the playback framework

(defconstant $kDVDErrorUninitializedLib -70003) ; 	The playback framework has not been initialized.

(defconstant $kDVDErrorNotAllowedDuringPlayback -70004); 	action is not allowed during playback

(defconstant $kDVDErrorUnassignedGrafPort -70005); 	A grafport was not set.

(defconstant $kDVDErrorAlreadyPlaying -70006)   ; 	Media is already being played.

(defconstant $kDVDErrorNoFatalErrCallBack -70007); 	The application did not install a callback routine for fatal errors returned by the framework.

(defconstant $kDVDErrorIsAlreadySleeping -70008); 	The framework has already been notified to sleep.

(defconstant $kDVDErrorDontNeedWakeup -70009)   ; 	DVDWakeUp was called when the framework was not asleep.

(defconstant $kDVDErrorTimeOutOfRange -70010)   ; 	Time code is outside the valid range for the current title.

(defconstant $kDVDErrorUserActionNoOp -70011)   ; 	The operation was not allowed by the media at this time.

(defconstant $kDVDErrorMissingDrive -70012)     ; 	The DVD drive is not available.

(defconstant $kDVDErrorNotSupportedConfiguration -70013); 	The current system configuration is not supported.

(defconstant $kDVDErrorNotSupportedFunction -70014); 	The operation is not supported. For example, trying to slow mo backwards.

(defconstant $kDVDErrorNoValidMedia -70015)     ; 	The media was not valid for playback.

(defconstant $kDVDErrorWrongParam -70016)       ; 	The invalid parameter was passed.

(defconstant $kDVDErrorMissingGraphicsDevice -70017); 	A valid graphics device is not available.

(defconstant $kDVDErrorGraphicsDevice -70018)   ; 	A graphics device error was encountered.

(defconstant $kDVDErrorPlaybackOpen -70019)     ; 	The framework is already open (probably by another process).

(defconstant $kDVDErrorInvalidRegionCode -70020); 	The region code was not valid.

(defconstant $kDVDErrorRgnMgrInstall -70021)    ; 	The region manager was not properly installed or missing from the system.

(defconstant $kDVDErrorMismatchedRegionCode -70022); 	The disc region code and the drive region code do not match.

(defconstant $kDVDErrorNoMoreRegionSets -70023) ; 	The drive does not have any region changes left.

(defconstant $kDVDErrordRegionCodeUninitialized -70024); 	The drive region code was not initialized.

(defconstant $kDVDErrorAuthentification -70025) ; 	The user attempting to change the region code could not be authenticated.

(defconstant $kDVDErrorOutOfVideoMemory -70026) ; 	The video driver does not have enough video memory available to playback the media.

(defconstant $kDVDErrorNoAudioOutputDevice -70027); 	An appropriate audio output device could not be found.

(defconstant $kDVDErrorSystem -70028)           ; 	A system error was encountered.
; 	The user has made a selection not supported in the current menu.

(defconstant $kDVDErrorNavigation -70029)

(def-mactype :DVDErrorCode (find-mactype ':sint32))
; -----------------------------------------------------
;  DVDState - The current play state of the framework.
; -----------------------------------------------------

(defconstant $kDVDStateUnknown 0)
(defconstant $kDVDStatePlaying 1)               ;  playing 1x or less (slow mo)

(defconstant $kDVDStatePlayingStill 2)
(defconstant $kDVDStatePaused 3)                ;  pause and step frame

(defconstant $kDVDStateStopped 4)
(defconstant $kDVDStateScanning 5)              ;  playing greater than 1x

(defconstant $kDVDStateIdle 6)

(def-mactype :DVDState (find-mactype ':sint32))
; -----------------------------------------------------
;  DVDMenu - Which menu we are currently on (if any).
; -----------------------------------------------------

(defconstant $kDVDMenuTitle 0)
(defconstant $kDVDMenuRoot 1)
(defconstant $kDVDMenuSubPicture 2)
(defconstant $kDVDMenuAudio 3)
(defconstant $kDVDMenuAngle 4)
(defconstant $kDVDMenuPTT 5)
(defconstant $kDVDMenuNone 6)

(def-mactype :DVDMenu (find-mactype ':UInt32))
; -----------------------------------------------------
;  DVDButtonIndex - Index of the selected menu button.
; -----------------------------------------------------

(defconstant $kDVDButtonIndexNone -1)

(def-mactype :DVDButtonIndex (find-mactype ':SInt32))
; -----------------------------------------------------
;  DVDUserNavigation - The direction the user is trying to navigate on the menu.
; -----------------------------------------------------

(defconstant $kDVDUserNavigationMoveUp 1)
(defconstant $kDVDUserNavigationMoveDown 2)
(defconstant $kDVDUserNavigationMoveLeft 3)
(defconstant $kDVDUserNavigationMoveRight 4)
(defconstant $kDVDUserNavigationEnter 5)

(def-mactype :DVDUserNavigation (find-mactype ':UInt32))
; -----------------------------------------------------
; 	DVDTimePosition -	Used in conjunction with the DVDTimeCode to find an exact 
; 						temporal location within the current title/chapter.
; -----------------------------------------------------

(def-mactype :DVDTimePosition (find-mactype ':UInt32))
; -----------------------------------------------------
;  DVDTimeCode -	Used in conjunction with the DVDTimePosition to find an exact 
; 					temporal location within the current title/chapter.
; -----------------------------------------------------

(defconstant $kDVDTimeCodeUninitialized 0)
(defconstant $kDVDTimeCodeElapsedSeconds 1)
(defconstant $kDVDTimeCodeRemainingSeconds 2)
(defconstant $kDVDTimeCodeTitleDurationSeconds 3);  only useable for GetTime

(defconstant $kDVDTimeCodeChapterElapsedSeconds 4);  "

(defconstant $kDVDTimeCodeChapterRemainingSeconds 5);  "
;  "

(defconstant $kDVDTimeCodeChapterDurationSeconds 6)

(def-mactype :DVDTimeCode (find-mactype ':SInt16))
; -----------------------------------------------------
;  DVDScan Direction -	Direction of play (backward or forward). Backward is currently not supported.
; -----------------------------------------------------

(defconstant $kDVDScanDirectionForward 0)
(defconstant $kDVDScanDirectionBackward 1)

(def-mactype :DVDScanDirection (find-mactype ':SInt8))
; -----------------------------------------------------
;  DVDScanRate - The rate at which to scan (used with DVDScanDirection).
; -----------------------------------------------------

(defconstant $kDVDScanRateOneEigth -8)
(defconstant $kDVDScanRateOneFourth -4)
(defconstant $kDVDScanRateOneHalf -2)
(defconstant $kDVDScanRate1x 1)
(defconstant $kDVDScanRate2x 2)
(defconstant $kDVDScanRate4x 4)
(defconstant $kDVDScanRate8x 8)
(defconstant $kDVDScanRate16x 16)
(defconstant $kDVDScanRate32x 32)

(def-mactype :DVDScanRate (find-mactype ':SInt16))
; -----------------------------------------------------
;  DVDAspectRatio - The current aspect ratio (could be different when on menus 
; 					or in the body of the title).
; -----------------------------------------------------

(defconstant $kDVDAspectRatioUninitialized 0)
(defconstant $kDVDAspectRatio4x3 1)
(defconstant $kDVDAspectRatio4x3PanAndScan 2)
(defconstant $kDVDAspectRatio16x9 3)
(defconstant $kDVDAspectRatioLetterBox 4)

(def-mactype :DVDAspectRatio (find-mactype ':SInt16))
; -----------------------------------------------------
;  DVDFormat - The format of the title.
; -----------------------------------------------------

(defconstant $kDVDFormatUninitialized 0)
(defconstant $kDVDFormatNTSC 1)
(defconstant $kDVDFormatPAL 2)

(def-mactype :DVDFormat (find-mactype ':SInt16))
; -----------------------------------------------------
;  DVDAudioStreamFormat - The different possible audio stream formats.
; -----------------------------------------------------

(defconstant $kDVDAudioUnknownFormat 0)
(defconstant $kDVDAudioAC3Format 1)
(defconstant $kDVDAudioMPEG1Format 2)
(defconstant $kDVDAudioMPEG2Format 3)
(defconstant $kDVDAudioPCMFormat 4)
(defconstant $kDVDAudioDTSFormat 5)
(defconstant $kDVDAudioSDDSFormat 6)

(def-mactype :DVDAudioFormat (find-mactype ':SInt16))
; -----------------------------------------------------
;  DVDLanguageCode - The different possible language codes.
; -----------------------------------------------------

(defconstant $kDVDLanguageCodeUninitialized :|??  |)
(defconstant $kDVDLanguageNoPreference :|**  |)
(defconstant $kDVDLanguageCodeNone :|00  |)
(defconstant $kDVDLanguageCodeAfar :|aa  |)
(defconstant $kDVDLanguageCodeAbkhazian :|ab  |)
(defconstant $kDVDLanguageCodeAfrikaans :|af  |)
(defconstant $kDVDLanguageCodeAmharic :|am  |)
(defconstant $kDVDLanguageCodeArabic :|ar  |)
(defconstant $kDVDLanguageCodeAssamese :|as  |)
(defconstant $kDVDLanguageCodeAymara :|ay  |)
(defconstant $kDVDLanguageCodeAzerbaijani :|az  |)
(defconstant $kDVDLanguageCodeBashkir :|ba  |)
(defconstant $kDVDLanguageCodeByelorussian :|be  |)
(defconstant $kDVDLanguageCodeBulgarian :|bg  |)
(defconstant $kDVDLanguageCodeBihari :|bh  |)
(defconstant $kDVDLanguageCodeBislama :|bi  |)
(defconstant $kDVDLanguageCodeBengali :|bn  |)
(defconstant $kDVDLanguageCodeTibetan :|bo  |)
(defconstant $kDVDLanguageCodeBreton :|br  |)
(defconstant $kDVDLanguageCodeCatalan :|ca  |)
(defconstant $kDVDLanguageCodeCorsican :|co  |)
(defconstant $kDVDLanguageCodeCzech :|cs  |)
(defconstant $kDVDLanguageCodeWelsh :|cy  |)
(defconstant $kDVDLanguageCodeDanish :|da  |)
(defconstant $kDVDLanguageCodeGerman :|de  |)
(defconstant $kDVDLanguageCodeBhutani :|dz  |)
(defconstant $kDVDLanguageCodeGreek :|el  |)
(defconstant $kDVDLanguageCodeEnglish :|en  |)
(defconstant $kDVDLanguageCodeEsperanto :|eo  |)
(defconstant $kDVDLanguageCodeSpanish :|es  |)
(defconstant $kDVDLanguageCodeEstonian :|et  |)
(defconstant $kDVDLanguageCodeBasque :|eu  |)
(defconstant $kDVDLanguageCodePersian :|fa  |)
(defconstant $kDVDLanguageCodeFinnish :|fi  |)
(defconstant $kDVDLanguageCodeFiji :|fj  |)
(defconstant $kDVDLanguageCodeFaeroese :|fo  |)
(defconstant $kDVDLanguageCodeFrench :|fr  |)
(defconstant $kDVDLanguageCodeFrisian :|fy  |)
(defconstant $kDVDLanguageCodeIrish :|ga  |)
(defconstant $kDVDLanguageCodeScotsGaelic :|gd  |)
(defconstant $kDVDLanguageCodeGalician :|gl  |)
(defconstant $kDVDLanguageCodeGuarani :|gn  |)
(defconstant $kDVDLanguageCodeGujarati :|gu  |)
(defconstant $kDVDLanguageCodeHausa :|ha  |)
(defconstant $kDVDLanguageCodeHindi :|hi  |)
(defconstant $kDVDLanguageCodeCroatian :|hr  |)
(defconstant $kDVDLanguageCodeHungarian :|hu  |)
(defconstant $kDVDLanguageCodeArmenian :|hy  |)
(defconstant $kDVDLanguageCodeInterlingua :|ia  |)
(defconstant $kDVDLanguageCodeInterlingue :|ie  |)
(defconstant $kDVDLanguageCodeInupiak :|ik  |)
(defconstant $kDVDLanguageCodeIndonesian :|in  |)
(defconstant $kDVDLanguageCodeIcelandic :|is  |)
(defconstant $kDVDLanguageCodeItalian :|it  |)
(defconstant $kDVDLanguageCodeHebrew :|iw  |)
(defconstant $kDVDLanguageCodeJapanese :|ja  |)
(defconstant $kDVDLanguageCodeYiddish :|ji  |)
(defconstant $kDVDLanguageCodeJavanese :|jw  |)
(defconstant $kDVDLanguageCodeGeorgian :|ka  |)
(defconstant $kDVDLanguageCodeKazakh :|kk  |)
(defconstant $kDVDLanguageCodeGreenlandic :|kl  |)
(defconstant $kDVDLanguageCodeCambodian :|km  |)
(defconstant $kDVDLanguageCodeKannada :|kn  |)
(defconstant $kDVDLanguageCodeKorean :|ko  |)
(defconstant $kDVDLanguageCodeKashmiri :|ks  |)
(defconstant $kDVDLanguageCodeKurdish :|ku  |)
(defconstant $kDVDLanguageCodeKirghiz :|ky  |)
(defconstant $kDVDLanguageCodeLatin :|la  |)
(defconstant $kDVDLanguageCodeLingala :|ln  |)
(defconstant $kDVDLanguageCodeLaothian :|lo  |)
(defconstant $kDVDLanguageCodeLithuanian :|lt  |)
(defconstant $kDVDLanguageCodeLatvian :|lv  |)
(defconstant $kDVDLanguageCodeMalagasy :|mg  |)
(defconstant $kDVDLanguageCodeMaori :|mi  |)
(defconstant $kDVDLanguageCodeMacedonian :|mk  |)
(defconstant $kDVDLanguageCodeMalayalam :|ml  |)
(defconstant $kDVDLanguageCodeMongolian :|mn  |)
(defconstant $kDVDLanguageCodeMoldavian :|mo  |)
(defconstant $kDVDLanguageCodeMarathi :|mr  |)
(defconstant $kDVDLanguageCodeMalay :|ms  |)
(defconstant $kDVDLanguageCodeMaltese :|mt  |)
(defconstant $kDVDLanguageCodeBurmese :|my  |)
(defconstant $kDVDLanguageCodeNauru :|na  |)
(defconstant $kDVDLanguageCodeNepali :|ne  |)
(defconstant $kDVDLanguageCodeDutch :|nl  |)
(defconstant $kDVDLanguageCodeNorwegian :|no  |)
(defconstant $kDVDLanguageCodeOccitan :|oc  |)
(defconstant $kDVDLanguageCodeOromo :|om  |)
(defconstant $kDVDLanguageCodeOriya :|or  |)
(defconstant $kDVDLanguageCodePunjabi :|pa  |)
(defconstant $kDVDLanguageCodePolish :|pl  |)
(defconstant $kDVDLanguageCodePashto :|ps  |)
(defconstant $kDVDLanguageCodePortugese :|pt  |)
(defconstant $kDVDLanguageCodeQuechua :|qu  |)
(defconstant $kDVDLanguageCodeRhaetoRomance :|rm  |)
(defconstant $kDVDLanguageCodeKirundi :|rn  |)
(defconstant $kDVDLanguageCodeRomanian :|ro  |)
(defconstant $kDVDLanguageCodeRussian :|ru  |)
(defconstant $kDVDLanguageCodeKinyarwanda :|rw  |)
(defconstant $kDVDLanguageCodeSanskrit :|sa  |)
(defconstant $kDVDLanguageCodeSindhi :|sd  |)
(defconstant $kDVDLanguageCodeSangro :|sg  |)
(defconstant $kDVDLanguageCodeSerboCroatian :|sh  |)
(defconstant $kDVDLanguageCodeSinghalese :|si  |)
(defconstant $kDVDLanguageCodeSlovak :|sk  |)
(defconstant $kDVDLanguageCodeSlovenian :|sl  |)
(defconstant $kDVDLanguageCodeSamoan :|sm  |)
(defconstant $kDVDLanguageCodeShona :|sn  |)
(defconstant $kDVDLanguageCodeSomali :|so  |)
(defconstant $kDVDLanguageCodeAlbanian :|sq  |)
(defconstant $kDVDLanguageCodeSerbian :|sr  |)
(defconstant $kDVDLanguageCodeSiswati :|ss  |)
(defconstant $kDVDLanguageCodeSesotho :|st  |)
(defconstant $kDVDLanguageCodeSudanese :|su  |)
(defconstant $kDVDLanguageCodeSwedish :|sv  |)
(defconstant $kDVDLanguageCodeSwahili :|sw  |)
(defconstant $kDVDLanguageCodeTamil :|ta  |)
(defconstant $kDVDLanguageCodeTelugu :|te  |)
(defconstant $kDVDLanguageCodeTajik :|tg  |)
(defconstant $kDVDLanguageCodeThai :|th  |)
(defconstant $kDVDLanguageCodeTigrinya :|ti  |)
(defconstant $kDVDLanguageCodeTurkmen :|tk  |)
(defconstant $kDVDLanguageCodeTagalog :|tl  |)
(defconstant $kDVDLanguageCodeSetswana :|tn  |)
(defconstant $kDVDLanguageCodeTonga :|to  |)
(defconstant $kDVDLanguageCodeTurkish :|tr  |)
(defconstant $kDVDLanguageCodeTsonga :|ts  |)
(defconstant $kDVDLanguageCodeTatar :|tt  |)
(defconstant $kDVDLanguageCodeTwi :|tw  |)
(defconstant $kDVDLanguageCodeUkranian :|uk  |)
(defconstant $kDVDLanguageCodeUrdu :|ur  |)
(defconstant $kDVDLanguageCodeUzbek :|uz  |)
(defconstant $kDVDLanguageCodeVietnamese :|vi  |)
(defconstant $kDVDLanguageCodeVolapuk :|vo  |)
(defconstant $kDVDLanguageCodeWolof :|wo  |)
(defconstant $kDVDLanguageCodeXhosa :|xh  |)
(defconstant $kDVDLanguageCodeYoruba :|yo  |)
(defconstant $kDVDLanguageCodeChinese :|zh  |)
(defconstant $kDVDLanguageCodeZulu :|zu  |)

(def-mactype :DVDLanguageCode (find-mactype ':OSType))
; -----------------------------------------------------
;  DVDAudioExtensionCode - The different possible audio extension codes.
; -----------------------------------------------------

(defconstant $kDVDAudioExtensionCodeNotSpecified 0)
(defconstant $kDVDAudioExtensionCodeNormalCaptions 1)
(defconstant $kDVDAudioExtensionCodeNVisualImpaired 2)
(defconstant $kDVDAudioExtensionCodeDirectorsComment1 3)
(defconstant $kDVDAudioExtensionCodeDirectorsComment2 4);  0x05 tp 0x7F reserved
;  0x80 to 0xFF provider defined


(def-mactype :DVDAudioExtensionCode (find-mactype ':OSType))
; -----------------------------------------------------
;  DVDSubpictureExtensionCode - The different possible subpicture extension codes.
; -----------------------------------------------------

(defconstant $kDVDSubpictureExtensionCodeNotSpecified 0)
(defconstant $kDVDSubpictureExtensionCodeCaptionNormalSize 1)
(defconstant $kDVDSubpictureExtensionCodeCaptionBiggerSize 2)
(defconstant $kDVDSubpictureExtensionCodeCaption4Children 3)
(defconstant $kDVDSubpictureExtensionCodeClosedCaptionNormalSize 5)
(defconstant $kDVDSubpictureExtensionCodeClosedCaptionBiggerSize 6)
(defconstant $kDVDSubpictureExtensionCodeClosedCaption4Children 7)
(defconstant $kDVDSubpictureExtensionCodeForcedCaption 9)
(defconstant $kDVDSubpictureExtensionDirectorsCommentNormalSize 13)
(defconstant $kDVDSubpictureExtensionDirectorsCommentBiggerSize 14)
(defconstant $kDVDSubpictureExtensionDirectorsComment4Children 15);  0x10 tp 0x7F reserved
;  0x80 to 0xFF provider defined


(def-mactype :DVDSubpictureExtensionCode (find-mactype ':OSType))
; -----------------------------------------------------
;  DVDRegionCode - The different possible region codes (used for both the disc and the drive).
; -----------------------------------------------------

(defconstant $kDVDRegionCodeUninitialized #xFF)
(defconstant $kDVDRegionCode1 #xFE)
(defconstant $kDVDRegionCode2 #xFD)
(defconstant $kDVDRegionCode3 #xFB)
(defconstant $kDVDRegionCode4 #xF7)
(defconstant $kDVDRegionCode5 #xEF)
(defconstant $kDVDRegionCode6 #xDF)
(defconstant $kDVDRegionCode7 #xBF)
(defconstant $kDVDRegionCode8 127)

(def-mactype :DVDRegionCode (find-mactype ':UInt32))
; -----------------------------------------------------
;  DVDDomainCode - The DVD Domain code...
; -----------------------------------------------------

(defconstant $kDVDFPDomain 0)
(defconstant $kDVDVMGMDomain 1)
(defconstant $kDVDVTSMDomain 2)
(defconstant $kDVDTTDomain 3)
(defconstant $kDVDSTOPDomain 4)
(defconstant $kDVDAMGMDomain 5)
(defconstant $kDVDTTGRDomain 6)

(def-mactype :DVDDomainCode (find-mactype ':UInt32))
; -----------------------------------------------------
;  DVDUOPCode - The DVD UOP code(s)...
; -----------------------------------------------------

(defconstant $kDVDUOPTimePlaySearch 1)
(defconstant $kDVDUOPPTTPlaySearch 2)
(defconstant $kDVDUOPTitlePlay 4)
(defconstant $kDVDUOPStop 8)
(defconstant $kDVDUOPGoUp 16)
(defconstant $kDVDUOPTimePTTSearch 32)
(defconstant $kDVDUOPPrevTopPGSearch 64)
(defconstant $kDVDUOPNextPGSearch #x80)
(defconstant $kDVDUOPForwardScan #x100)
(defconstant $kDVDUOPBackwardScan #x200)
(defconstant $kDVDUOPMenuCallTitle #x400)
(defconstant $kDVDUOPMenuCallRoot #x800)
(defconstant $kDVDUOPMenuCallSubPicture #x1000)
(defconstant $kDVDUOPMenuCallAudio #x2000)
(defconstant $kDVDUOPMenuCallAngle #x4000)
(defconstant $kDVDUOPMenuCallPTT #x8000)
(defconstant $kDVDUOPResume #x10000)
(defconstant $kDVDUOPButton #x20000)
(defconstant $kDVDUOPStillOff #x40000)
(defconstant $kDVDUOPPauseOn #x80000)
(defconstant $kDVDUOPAudioStreamChange #x100000)
(defconstant $kDVDUOPSubPictureStreamChange #x200000)
(defconstant $kDVDUOPAngleChange #x400000)
(defconstant $kDVDUOPKaraokeModeChange #x800000)
(defconstant $kDVDUOPVideoModeChange #x1000000)
(defconstant $kDVDUOPScanOff #x2000000)
(defconstant $kDVDUOPPauseOff #x4000000)

(def-mactype :DVDUOPCode (find-mactype ':UInt32))
; -----------------------------------------------------
;  DVDEventCode - The different event a client can register for to get notified (return value: UInt32)
; -----------------------------------------------------

(defconstant $kDVDEventTitle 1)                 ;  Returned value1: Title

(defconstant $kDVDEventPTT 2)                   ;  Returned value1: Chapter

(defconstant $kDVDEventValidUOP 3)              ;  Returned value1: UOP code mask (DVDUOPCode)

(defconstant $kDVDEventAngle 4)                 ;  Returned value1: StreamID

(defconstant $kDVDEventAudioStream 5)           ;  Returned value1: StreamID

(defconstant $kDVDEventSubpictureStream 6)      ;  Returned value1: streamID  / (value2 != 0): visible

(defconstant $kDVDEventDisplayMode 7)           ;  Returned value1: DVDAspectRatio

(defconstant $kDVDEventDomain 8)                ;  Returned value1: DVDDomainCode

(defconstant $kDVDEventBitrate 9)               ;  Returned value1: Bits / sec

(defconstant $kDVDEventStill 10)                ;  Returned value1: On (1) - Off (0)

(defconstant $kDVDEventPlayback 11)             ;  Returned value1: DVDState

(defconstant $kDVDEventVideoStandard 12)        ;  Returned value1: DVDFormat

(defconstant $kDVDEventStreams 13)              ;  Returned value1: None (trigger for general stream change)

(defconstant $kDVDEventScanSpeed 14)            ;  Returned value1: Speed (1x,2x,3x,...)

(defconstant $kDVDEventMenuCalled 15)           ;  Returned value1: DVDMenu

(defconstant $kDVDEventParental 16)             ;  Returned value1: parental level number

(defconstant $kDVDEventPGC 17)                  ;  Returned value1: PGC number

(defconstant $kDVDEventGPRM 18)                 ;  Returned value1: GPRM index / value2: data 

(defconstant $kDVDEventRegionMismatch 19)       ;  Returned value1: disc region

(defconstant $kDVDEventTitleTime 20)            ;  Returned value1: elapsed time / value2: duration of title [ms] 

(defconstant $kDVDEventSubpictureStreamNumbers 21);  Returned value1: number of subpicture streams in title

(defconstant $kDVDEventAudioStreamNumbers 22)   ;  Returned value1: number of audio streams in title

(defconstant $kDVDEventAngleNumbers 23)         ;  Returned value1: number of angles in title

(defconstant $kDVDEventError 24)                ;  Returned value1: DVDErrorCode

(defconstant $kDVDEventCCInfo 25)               ;  Returned value1: cc event opcode, value2: cc event data

(defconstant $kDVDEventChapterTime 26)          ;  Returned value1: elapsed time / value2: duration of current chapter [ms]


(def-mactype :DVDEventCode (find-mactype ':UInt32))
; -----------------------------------------------------
;  Callback definitions
; 
; 	WARNING:	The callbaks will be called from a different thread. Do not attempt to draw directly from the callback.
; 				Store the information and do any actually drawing when you are back in your thread.
; 
; 	DVDFatalErrCallBackFunctionPtr -	Called when the playback framework encountered an unrecoverable error.
; 										inRefCon is the refcon passed in when the callback was registered.
; 	DVDEventCallBackFunctionPtr -		Called when the playback framework encountered an event change.
; 										Arguments are the actual event, the specific data for that event (title num, angle, etc.),
; 										and inRefCon is the refcon passed in when the callback was registered.
; 										If the call was registered for multiple events, each event will be called separately.
; -----------------------------------------------------

(def-mactype :DVDFatalErrCallBackFunctionPtr (find-mactype ':pointer)); (DVDErrorCode inError , UInt32 inRefCon)

(def-mactype :DVDEventCallBackFunctionPtr (find-mactype ':pointer)); (DVDEventCode inEventCode , UInt32 inEventValue1 , UInt32 inEventValue2 , UInt32 inRefCon)
; #pragma export on
; -----------------------------------------------------
; 	API Calls
; -----------------------------------------------------
; -----------------------------------------------------
; 	Set up and tear down:
; 
; 	You must initialize the playback framework before using it and dispose of it when done.
; 	Usually called upon application startup and quit. Only one application can use the playback framework 
; 	at a time.
; 	  
; 	DVDInitialize	-	Call when preparing for playback. Usually when the application is initializing.
; 						Returns an error of kDVDErrorPlaybackOpen if the playback framework is already being used.
; 	DVDDispose		- 	Call when completely done with playback. Usually when the application is quitting.
; -----------------------------------------------------

(deftrap-inline "_DVDInitialize" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )

(deftrap-inline "_DVDDispose" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Opening and closing media:
; 
; 	These calls allow opening media from disc (DVDOpenMediaVolume) or from a VIDEO_TS
; 	folder (DVDOpenMediaFile).  You must close any currently open disc or file before opening
; 	a new one.  For both Open calls you must provide an FSRef to the VIDEO_TS folder.
; 	
; 	DVDIsValidMediaRef	- 	Returns true if the FSRef points to a valid media layout.
; 	DVDHasMedia 		- 	Returns true if the playback framework has media to play and
; 							the framework had recveived an Open call on the media.
; 	DVDOpenMediaFile	- 	Opens a VIDEO_TS folder (can be on a hard drive or a dvd disc).
; 	DVDCloseMediaFile	- 	Closes a previously opened VIDEO_TS folder.
; 	DVDOpenMediaVolume	- 	Opens a DVD disc for playback.
; 	DVDCloseMediaVolume	-	Closes a previously opened DVD disc.
; -----------------------------------------------------

(deftrap-inline "_DVDIsValidMediaRef" 
   ((inRef (:pointer :FSRef))
    (outIsValid (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_DVDHasMedia" 
   ((outHasMedia (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_DVDOpenMediaFile" 
   ((inFile (:pointer :FSRef))
   )
   :OSStatus
() )

(deftrap-inline "_DVDCloseMediaFile" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )

(deftrap-inline "_DVDOpenMediaVolume" 
   ((inVolume (:pointer :FSRef))
   )
   :OSStatus
() )

(deftrap-inline "_DVDCloseMediaVolume" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Video device:
; 
; 	These calls are used to get and set the screen used for playback typical for Carbon.
; 
; 	DVDIsSupportedDevice	-	Returns TRUE if this device is known to support DVD playback.  Could 
; 							 	return FALSE for a device capable DVD playback but using a different 
; 								video driver than the one currently in use.  DVDSetVideoPort must have 
; 								been previously called with a valid port for this call to work properly.
; 	DVDSwitchToDevice		- 	Switches active to the new playback device. It will return with an error
; 								if the new device is not suppported and keep the old device
; 	DVDSetVideoDevice		- 	Set the device to playback video on.
; 	DVDSetVideoDevice		- 	Returns the device video playback is on.
; -----------------------------------------------------

(deftrap-inline "_DVDIsSupportedDevice" 
   ((inDevice (:Handle :GDEVICE))
    (outSupported (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_DVDSwitchToDevice" 
   ((newDevice (:Handle :GDEVICE))
    (outSupported (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_DVDSetVideoDevice" 
   ((inDevice (:Handle :GDEVICE))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetVideoDevice" 
   ((outDevice (:pointer :GDHandle))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Video display:
; 
; 	These calls are used to get and set the screen used for playback typical for Appkit/CoreGraphics.
; 
; 	DVDIsSupportedDisplay	-	Returns TRUE if this display is known to support DVD playback.  Could 
; 							 	return FALSE for a display capable DVD playback but using a different 
; 								video driver than the one currently in use.  DVDSetVideoWindowID must have 
; 								been previously called with a valid window for this call to work properly.
; 	DVDSwitchToDisplay		- 	Switches active to the new playback display. It will return with an error
; 								if the new display is not suppported and keep the old display
; 	DVDSetVideoDisplay		- 	Set the display to playback video on.
; 	DVDSetVideoDisplay		- 	Returns the display video playback is on.
; -----------------------------------------------------

(deftrap-inline "_DVDIsSupportedDisplay" 
   ((inDisplay (:pointer :_CGDirectDisplayID))
    (outSupported (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_DVDSwitchToDisplay" 
   ((newDisplay (:pointer :_CGDirectDisplayID))
    (outSupported (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_DVDSetVideoDisplay" 
   ((inDisplay (:pointer :_CGDirectDisplayID))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetVideoDisplay" 
   ((outDisplay (:pointer :CGDirectDisplayID))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Video:
; 
; 	These calls are used to get and set video related information.
; 
; 	DVDSetVideoPort			-	Sets the grafport to play into and causes the appropriate
; 							 	video driver to be loaded.  Passing NULL causes the
; 								low-level DVD driver to close.
; 	DVDGetVideoPort			- 	Returns the grafport the playback framework is set to.
; 	DVDSetVideoWindowID		-	Sets the window id to play into and causes the appropriate
; 							 	video driver to be loaded.  Passing NULL causes the
; 								low-level DVD driver to close.
; 	DVDGetVideoWindowID		- 	Returns the window id the playback framework is set to.
; 	DVDSetVideoBounds		- 	Sets (in port coordinates) the rect to play the video in.
; 	DVDGetVideoBounds		- 	Returns (in port coordinates) the rect used to play video.
; 	DVDGetVideoKeyColor		- 	Returns the key color used but the video driver.
; 	DVDGetNativeVideoSize	- 	Returns the default width and height for the title.
; 	DVDGetAspectRatio		- 	Returns the aspect ratio of the current title. Use this 
; 							  	with the native video size to calculate the video bounds.
; 	DVDSetAspectRatio		- 	Set the aspect ratio to use for the current title.
; 	DVDGetFormatStandard	- 	Returns the format of the title.
; -----------------------------------------------------

(deftrap-inline "_DVDSetVideoPort" 
   ((inVidPort (:pointer :OpaqueGrafPtr))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetVideoPort" 
   ((outVidPort (:pointer :CGrafPtr))
   )
   :OSStatus
() )

(deftrap-inline "_DVDSetVideoWindowID" 
   ((inVidWindowID :UInt32)
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetVideoWindowID" 
   ((outVidWindowID (:pointer :UInt32))
   )
   :OSStatus
() )

(deftrap-inline "_DVDSetVideoBounds" 
   ((inPortRect (:pointer :Rect))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetVideoBounds" 
   ((outPortRect (:pointer :Rect))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetVideoKeyColor" 
   ((outKeyColor (:pointer :RGBColor))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetNativeVideoSize" 
   ((outWidth (:pointer :UInt16))
    (outHeight (:pointer :UInt16))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetAspectRatio" 
   ((outRatio (:pointer :DVDASPECTRATIO))
   )
   :OSStatus
() )

(deftrap-inline "_DVDSetAspectRatio" 
   ((inRatio :SInt16)
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetFormatStandard" 
   ((outFormat (:pointer :DVDFORMAT))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Audio:
; 
; 	These calls are used to get and set audio related information.
; 	
; 	DVDGetAudioStreamFormat	-	Gets the current audio format (AC3,for example).
; -----------------------------------------------------

(deftrap-inline "_DVDGetAudioStreamFormat" 
   ((outFormat (:pointer :DVDAUDIOFORMAT))
    (outBitsPerSample (:pointer :UInt32))
    (outSamplesPerSecond (:pointer :UInt32))
    (outChannels (:pointer :UInt32))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Time:
; 
; 	These calls are used to get and set the current playback position relative to the 
; 	beginning or end of the title.
; 	
; 	DVDSetTime	-	Sets the current playback position in the current title based on a time 
; 				  	position in seconds relative to the time code (elapsed,remaining).
; 	DVDSetTime	- 	Gets the current playback position in the current title in seconds relative 
; 				  	to the requested time code (elapsed,remaining).
; -----------------------------------------------------

(deftrap-inline "_DVDSetTime" 
   ((inTimeCode :SInt16)
    (inTime :UInt32)
    (inFrames :UInt16)
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetTime" 
   ((inTimeCode :SInt16)
    (outTime (:pointer :DVDTIMEPOSITION))
    (outFrames (:pointer :UInt16))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Miscellaneous:
; 	
; 	DVDGetState		- 	Returns the current play state of the DVDPlayback framework.
; 	DVDIdle			- 	Allows the framework to get a consistent time to process at. (Might be removed in the future).
; 	DVDUpdateVideo	- 	Forces the video to be updated.
; -----------------------------------------------------

(deftrap-inline "_DVDGetState" 
   ((outState (:pointer :DVDSTATE))
   )
   :OSStatus
() )

(deftrap-inline "_DVDIdle" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )

(deftrap-inline "_DVDUpdateVideo" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Playback control:
; 	
; 	DVDIsPlaying	- 	Returns true if the framework has media and is playing (even if paused).
; 	DVDIsPaused		- 	Returns true if the framework has media and is paused.
; 	DVDPlay			- 	Starts playing the media.
; 	DVDPause		- 	Pauses the media if currently playing.
; 	DVDResume		-	Starts playing if currently paused.
; 	DVDStop			- 	Stops if playing.
; 	DVDScan			- 	Fast forwards or rewinds depending on DVDScanDirection at the speed
; 						specified in DVDScanRate.
; 	DVDGetScanRate	- 	Returns the current scan direction and rate.
; 	DVDStepFrame	- 	Steps one frame in the direction specified in DVDScanDirection.
; 						Currently only supports kDVDScanDirectionForward.
; -----------------------------------------------------

(deftrap-inline "_DVDIsPlaying" 
   ((outIsPlaying (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_DVDIsPaused" 
   ((outIsPaused (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_DVDPlay" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )

(deftrap-inline "_DVDPause" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )

(deftrap-inline "_DVDResume" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )

(deftrap-inline "_DVDStop" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )

(deftrap-inline "_DVDScan" 
   ((inRate :SInt16)
    (inDirection :SInt8)
   )
   :OSStatus
() )
;  fast forward, rewind, slow mo

(deftrap-inline "_DVDGetScanRate" 
   ((outRate (:pointer :DVDSCANRATE))
    (outDirection (:pointer :DVDSCANDIRECTION))
   )
   :OSStatus
() )
;  get the current play rate (fast forward, etc)

(deftrap-inline "_DVDStepFrame" 
   ((inDirection :SInt8)
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Volume:
; 
; 	These calls are used to adjust the playback volume. The playback volume is relative
; 	to the current system volume.
; 
; 	DVDIsMuted				-	Returns true if the playback volume is currently muted.
; 	DVDMute					- 	Toggles the mute setting on or off.
; 	DVDSetAudioVolume		- 	Sets the playback volume (0 - 255).
; 	DVDGetAudioVolume		- 	Gets the current playback volume (0 - 255).
; 	DVDGetAudioVolumeInfo	- 	Gets the playback volume info (minimum, maximum, and current volume).
; -----------------------------------------------------

(deftrap-inline "_DVDIsMuted" 
   ((outIsMuted (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_DVDMute" 
   ((inMute :Boolean)
   )
   :OSStatus
() )

(deftrap-inline "_DVDSetAudioVolume" 
   ((inVolume :UInt16)
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetAudioVolume" 
   ((outVolume (:pointer :UInt16))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetAudioVolumeInfo" 
   ((outMinVolume (:pointer :UInt16))
    (outCurVolume (:pointer :UInt16))
    (outMaxVolume (:pointer :UInt16))
   )
   :OSStatus
() )
;  can pass null
; -----------------------------------------------------
; 	DVD Menu Navigation:
; 	
; 	DVDHasMenu			-	Returns if input menu type is available.
; 	DVDIsOnMenu			-	Are we currently on a menu, and if so, which one.
; 	DVDGoToMenu			- 	Jump to a particular menu (Root Menu,Sub Picture Menu, etc.).
; 	DVDReturnToTitle	- 	Returns from the menu back to the current position within the title.
; 	DVDGoBackOneLevel	- 	If in a sub menu, move back up one level.
; 	DVDDoUserNavigation	-	Allows the user to navigate between menu buttons. This is usually done
; 							using keyboard keys (arrow keys to move and Enter key to choose a menu item).
; 	DVDDoMenuClick		-	If the point (in port coordinates) coincides with a menu button, it will be selected.
; 	DVDDoMenuMouseOver	-	If the point (in port coordinates) coincides with a menu button, it will be hightlighted
; 							and it's index returned in outIndex.
; -----------------------------------------------------

(deftrap-inline "_DVDHasMenu" 
   ((inMenu :UInt32)
    (outHasMenu (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_DVDIsOnMenu" 
   ((outOnMenu (:pointer :Boolean))
    (outMenu (:pointer :DVDMENU))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGoToMenu" 
   ((inMenu :UInt32)
   )
   :OSStatus
() )

(deftrap-inline "_DVDReturnToTitle" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGoBackOneLevel" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )

(deftrap-inline "_DVDDoUserNavigation" 
   ((inNavigation :UInt32)
   )
   :OSStatus
() )

(deftrap-inline "_DVDDoMenuClick" 
   ((inPortPt :Point)
    (outIndex (:pointer :SInt32))
   )
   :OSStatus
() )

(deftrap-inline "_DVDDoMenuMouseOver" 
   ((inPortPt :Point)
    (outIndex (:pointer :SInt32))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Title:
; 	
; 	DVDSetTitle		-	Set the title to play (1 - 99).
; 	DVDGetTitle		- 	Gets the current title.
; 	DVDGetNumTitles	- 	Gets the number of titles available on the media.
; -----------------------------------------------------

(deftrap-inline "_DVDSetTitle" 
   ((inTitleNum :UInt16)
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetTitle" 
   ((outTitleNum (:pointer :UInt16))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetNumTitles" 
   ((outNumTitles (:pointer :UInt16))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Chapters:
; 
;  	These calls are made within the context of the currently playing title.
; 	
; 	DVDHasPreviousChapter	-	Returns true if there is a chapter before the current chapter.
; 	DVDHasNextChapter		-	Returns true if there is a chapter after the current chapter.
; 	DVDSetChapter			- 	Sets the chapter to play.
; 	DVDGetChapter			- 	Gets the current chapter.
; 	DVDGetNumChapters		- 	Gets the number of chapters in the current title.
; 	DVDPreviousChapter		- 	Sets to the previous chapter on the current title.
; 	DVDNextChapter			-	Sets to the next chapter on the current title.
; -----------------------------------------------------

(deftrap-inline "_DVDHasPreviousChapter" 
   ((outHasChapter (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_DVDHasNextChapter" 
   ((outHasChapter (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_DVDSetChapter" 
   ((inChapterNum :UInt16)
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetChapter" 
   ((outChapterNum (:pointer :UInt16))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetNumChapters" 
   ((inTitleNum :UInt16)
    (outNumChapters (:pointer :UInt16))
   )
   :OSStatus
() )

(deftrap-inline "_DVDPreviousChapter" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )

(deftrap-inline "_DVDNextChapter" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Angles:
; 
;  	These calls are made within the context of the currently playing title.
; 	
; 	DVDSetAngle		-	Sets the angle to display.
; 	DVDGetAngle		-	Gets the angle displayed.
; 	DVDGetNumAngles	-	Gets the number of angles currently available.
; -----------------------------------------------------

(deftrap-inline "_DVDSetAngle" 
   ((inAngleNum :UInt16)
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetAngle" 
   ((outAngleNum (:pointer :UInt16))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetNumAngles" 
   ((outNumAngles (:pointer :UInt16))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	SubPictures:
; 
;  	These calls are made within the context of the currently playing title.
; 	
; 	DVDDisplaySubPicture		-	Turns the displaying of subpictures on or off.
; 	DVDIsDisplayingSubPicture	- 	Returns true if subpictures are currently being displayed.
; 	DVDSetSubPictureStream		- 	Sets the sub picture stream to display.
; 	DVDGetSubPictureStream		-	Gets the sub picture stream being displayed.
; 	DVDGetNumSubPictureStreams	-	Gets the number of sub pictures streams currently available.
; -----------------------------------------------------

(deftrap-inline "_DVDDisplaySubPicture" 
   ((inDisplay :Boolean)
   )
   :OSStatus
() )

(deftrap-inline "_DVDIsDisplayingSubPicture" 
   ((outDisplayingSubPicture (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_DVDSetSubPictureStream" 
   ((inStreamNum :UInt16)
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetSubPictureStream" 
   ((outStreamNum (:pointer :UInt16))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetNumSubPictureStreams" 
   ((outNumStreams (:pointer :UInt16))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Audio Stream:
; 
;  	These calls are made within the context of the currently playing title.
; 	
; 	DVDSetAudioStream		-	Sets the audio stream to use.
; 	DVDGetAudioStream		-	Gets the audio stream currently being used.
; 	DVDGetNumAudioStreams	-	Gets the number of audio streams currently available.
; -----------------------------------------------------

(deftrap-inline "_DVDSetAudioStream" 
   ((inStreamNum :UInt16)
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetAudioStream" 
   ((outStreamNum (:pointer :UInt16))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetNumAudioStreams" 
   ((outNumStreams (:pointer :UInt16))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Language Codes:
; 	
; 	The Set calls set the default language codes to be used if the user does not specifically change them. The
; 	language code decides which stream will be used.
; 	The Get calls return the language code in use or to be used by a particular stream.
; 	
; 	DVDSetDefaultSubPictureLanguageCode		-	Sets the default subpicture language and extension to be used 
; 												when subpictures are turned on.
; 	DVDGetSubPictureLanguageCode			- 	Returns the subpicture language code and extension to be used 
; 												when subpictures are on.
; 	DVDGetSubPictureLanguageCodeByStream	-	Returns the subpicture language code and extension for a 
; 												particular subpicture stream.
; 	
; 	DVDSetDefaultAudioLanguageCode			-	Sets the default audio language code and extension to be used.
; 	DVDGetAudioLanguageCode					- 	Returns the audio language code and extension currently used.
; 	DVDGetAudioLanguageCodeByStream			- 	Returns the audio language code and extension for a particular stream.
; 	
; 	DVDSetDefaultMenuLanguageCode			-	Sets the default menu language code to be used.
; 	DVDGetMenuLanguageCode					-	Returns the menu language code being used.
; -----------------------------------------------------

(deftrap-inline "_DVDSetDefaultSubPictureLanguageCode" 
   ((inCode :OSType)
    (inExtension :OSType)
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetSubPictureLanguageCode" 
   ((outCode (:pointer :DVDLANGUAGECODE))
    (outExtension (:pointer :DVDSUBPICTUREEXTENSIONCODE))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetSubPictureLanguageCodeByStream" 
   ((inStreamNum :UInt16)
    (outCode (:pointer :DVDLANGUAGECODE))
    (outExtension (:pointer :DVDSUBPICTUREEXTENSIONCODE))
   )
   :OSStatus
() )

(deftrap-inline "_DVDSetDefaultAudioLanguageCode" 
   ((inCode :OSType)
    (inExtension :OSType)
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetAudioLanguageCode" 
   ((outCode (:pointer :DVDLANGUAGECODE))
    (outExtension (:pointer :DVDAUDIOEXTENSIONCODE))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetAudioLanguageCodeByStream" 
   ((inStreamNum :UInt16)
    (outCode (:pointer :DVDLANGUAGECODE))
    (outExtension (:pointer :DVDAUDIOEXTENSIONCODE))
   )
   :OSStatus
() )

(deftrap-inline "_DVDSetDefaultMenuLanguageCode" 
   ((inCode :OSType)
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetMenuLanguageCode" 
   ((outCode (:pointer :DVDLANGUAGECODE))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Region Codes:
; 
; 	The drive region code must match the DVD disc region code. These calls allow getting the disc region code
; 	and getting or setting the drive region code. 
; 	NOTE:	The drive region code is stored in the drive and can only be set a total of 5 times. 
; 		  	On the last time, the drive will be permanently locked to that region code.
; 	
; 	DVDGetDiscRegionCode	-	Returns the region codes available on the disc (can be more than one).
; 	DVDGetDriveRegionCode	-	Returns the region code the drive is set to and how many changes are left.
; 	DVDSetDriveRegionCode	-	Sets the drive region code (requires user authentication). 
; -----------------------------------------------------	

(deftrap-inline "_DVDGetDiscRegionCode" 
   ((outCode (:pointer :DVDREGIONCODE))
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetDriveRegionCode" 
   ((outCode (:pointer :DVDREGIONCODE))
    (outNumberChangesLeft (:pointer :SInt16))
   )
   :OSStatus
() )

(deftrap-inline "_DVDSetDriveRegionCode" 
   ((inCode :UInt32)
    (inAuthorization (:pointer :AuthorizationOpaqueRef))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Features:
; 
; 	DVDEnableWebAccess	-	Turns DVD@ccess support on or off.
; -----------------------------------------------------

(deftrap-inline "_DVDEnableWebAccess" 
   ((inEnable :Boolean)
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Call Backs:
; 
; 	DVDSetFatalErrorCallBack		-	Required. Allows the framework to return an unrecoverable error.
; 										After receiving the fatal error, the framework can not continue, but
; 										must still be properly released.
; 	DVDRegisterEventCallBack		-	Optional. Allows the client to register to get notified about DVD playback changes.
; 										More than one call back can be registered and multiple events can be registered per callback.
; 	DVDUnregisterEventCallBack		-	Unregister an event callback.
; 	DVDIsRegisteredEventCallBack	-	Check if event callback is already registered.
; 
; 	DVDSetTimeEventRate				-	Sets the rate of the time DVD event "kDVDEventTime"; default:900 ms.
; 	DVDGetTimeEventRate				-	Gets the rate of the time DVD event.
; 
; -----------------------------------------------------

(deftrap-inline "_DVDSetFatalErrorCallBack" 
   ((inCallBackProc :pointer)
    (inRefCon :UInt32)
   )
   :OSStatus
() )

(deftrap-inline "_DVDRegisterEventCallBack" 
   ((inCallBackProc :pointer)
    (inCode (:pointer :DVDEVENTCODE))
    (inCodeCount :UInt32)
    (inRefCon :UInt32)
    (outCallBackID (:pointer :UInt32))
   )
   :OSStatus
() )

(deftrap-inline "_DVDUnregisterEventCallBack" 
   ((inCallBackID :UInt32)
   )
   :OSStatus
() )

(deftrap-inline "_DVDIsRegisteredEventCallBack" 
   ((inCallBackID :UInt32)
   )
   :Boolean
() )

(deftrap-inline "_DVDSetTimeEventRate" 
   ((inMilliseconds :UInt32)
   )
   :OSStatus
() )

(deftrap-inline "_DVDGetTimeEventRate" 
   ((outMilliseconds (:pointer :UInt32))
   )
   :OSStatus
() )
; -----------------------------------------------------
; 	Sleep:
; 
; 	The client must register for sleep notifications with the system so that it can notify the
; 	framework of sleep and wake notifications.
; 
; 	DVDSleep	- Call when system is putting machine to sleep so playback information can be saved.
; 	DVDWakeUp	- Call when system is waking up so playback information can be reset.
; -----------------------------------------------------

(deftrap-inline "_DVDSleep" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )

(deftrap-inline "_DVDWakeUp" 
   ((ARG2 (:nil :nil))
   )
   :OSStatus
() )
; #pragma export reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __DVDPLAYBACK__ */


(provide-interface "DVDPlayback")