(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Movies.h"
; at Sunday July 2,2006 7:28:03 pm.
; 
;      File:       QuickTime/Movies.h
;  
;      Contains:   QuickTime Interfaces.
;  
;      Version:    QuickTime_6
;  
;      Copyright:  © 1990-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __MOVIES__
; #define __MOVIES__
; #ifndef __CARBON__
#| #|
#include <CarbonCarbon.h>
#endif
|#
 |#
; #ifndef __IMAGECOMPRESSION__
#| #|
#include <QuickTimeImageCompression.h>
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

; #if TARGET_API_MAC_OSX

(require-interface "CoreAudio/CoreAudio")

; #endif

;   "kFix1" is defined in FixMath as "fixed1"  
;  error codes are in Errors.[haa] 
;  gestalt codes are in Gestalt.[hpa] 

(defconstant $MovieFileType :|MooV|)
(defconstant $MovieScrapType :|moov|)

(defconstant $MovieResourceType :|moov|)
(defconstant $MovieForwardPointerResourceType :|fore|)
(defconstant $MovieBackwardPointerResourceType :|back|)

(defconstant $MovieResourceAtomType :|moov|)
(defconstant $MovieDataAtomType :|mdat|)
(defconstant $FreeAtomType :|free|)
(defconstant $SkipAtomType :|skip|)
(defconstant $WideAtomPlaceholderType :|wide|)

(defconstant $MediaHandlerType :|mhlr|)
(defconstant $DataHandlerType :|dhlr|)

(defconstant $VideoMediaType :|vide|)
(defconstant $SoundMediaType :|soun|)
(defconstant $TextMediaType :|text|)
(defconstant $BaseMediaType :|gnrc|)
(defconstant $MPEGMediaType :|MPEG|)
(defconstant $MusicMediaType :|musi|)
(defconstant $TimeCodeMediaType :|tmcd|)
(defconstant $SpriteMediaType :|sprt|)
(defconstant $FlashMediaType :|flsh|)
(defconstant $MovieMediaType :|moov|)
(defconstant $TweenMediaType :|twen|)
(defconstant $ThreeDeeMediaType :|qd3d|)
(defconstant $SkinMediaType :|skin|)
(defconstant $HandleDataHandlerSubType :|hndl|)
(defconstant $PointerDataHandlerSubType :|ptr |)
(defconstant $NullDataHandlerSubType :|null|)
(defconstant $ResourceDataHandlerSubType :|rsrc|)
(defconstant $URLDataHandlerSubType :|url |)
(defconstant $AliasDataHandlerSubType :|alis|)
(defconstant $WiredActionHandlerType :|wire|)

(defconstant $VisualMediaCharacteristic :|eyes|)
(defconstant $AudioMediaCharacteristic :|ears|)
(defconstant $kCharacteristicCanSendVideo :|vsnd|)
(defconstant $kCharacteristicProvidesActions :|actn|)
(defconstant $kCharacteristicNonLinear :|nonl|)
(defconstant $kCharacteristicCanStep :|step|)
(defconstant $kCharacteristicHasNoDuration :|noti|)
(defconstant $kCharacteristicHasSkinData :|skin|)
(defconstant $kCharacteristicProvidesKeyFocus :|keyf|)

(defconstant $kUserDataMovieControllerType :|ctyp|)
(defconstant $kUserDataName :|name|)            ; '©alb' 

(defconstant $kUserDataTextAlbum #xA9616C62)
(defconstant $kUserDataTextArtist #xA9415254)   ; '©aut' 

(defconstant $kUserDataTextAuthor #xA9617574)   ; '©chp' 

(defconstant $kUserDataTextChapter #xA9636870)  ; '©cmt' 

(defconstant $kUserDataTextComment #xA9636D74)  ; '©com' 

(defconstant $kUserDataTextComposer #xA9636F6D) ; '©cpy' 

(defconstant $kUserDataTextCopyright #xA9637079); '©day' 

(defconstant $kUserDataTextCreationDate #xA9646179); '©des' 

(defconstant $kUserDataTextDescription #xA9646573); '©dir' 

(defconstant $kUserDataTextDirector #xA9646972) ; '©dis' 

(defconstant $kUserDataTextDisclaimer #xA9646973); '©enc' 

(defconstant $kUserDataTextEncodedBy #xA9656E63); '©nam' 

(defconstant $kUserDataTextFullName #xA96E616D) ; '©gen' 

(defconstant $kUserDataTextGenre #xA967656E)    ; '©hst' 

(defconstant $kUserDataTextHostComputer #xA9687374); '©inf' 

(defconstant $kUserDataTextInformation #xA9696E66); '©key' 

(defconstant $kUserDataTextKeywords #xA96B6579) ; '©mak' 

(defconstant $kUserDataTextMake #xA96D616B)     ; '©mod' 

(defconstant $kUserDataTextModel #xA96D6F64)    ; '©ope' 

(defconstant $kUserDataTextOriginalArtist #xA96F7065); '©fmt' 

(defconstant $kUserDataTextOriginalFormat #xA9666D74); '©src' 

(defconstant $kUserDataTextOriginalSource #xA9737263); '©prf' 

(defconstant $kUserDataTextPerformers #xA9707266); '©prd' 

(defconstant $kUserDataTextProducer #xA9707264)
(defconstant $kUserDataTextProduct #xA9505244)  ; '©swr' 

(defconstant $kUserDataTextSoftware #xA9737772) ; '©req' 

(defconstant $kUserDataTextSpecialPlaybackRequirements #xA9726571); '©trk' 

(defconstant $kUserDataTextTrack #xA974726B)    ; '©wrn' 

(defconstant $kUserDataTextWarning #xA977726E)  ; '©wrt' 

(defconstant $kUserDataTextWriter #xA9777274)   ; '©url' 

(defconstant $kUserDataTextURLLink #xA975726C)  ; '©ed1' 

(defconstant $kUserDataTextEditDate1 #xA9656431)
(defconstant $kUserDataAnimatedGIFLoopCount :|gifc|);  data is big-endian UInt16 

(defconstant $kQTAnimatedGIFLoopCountInfinite 0)
(defconstant $kUserDataAnimatedGIFBufferingSize :|gifb|);  data is big-endian UInt32 


(defconstant $kUserDataUnicodeBit #x80)

(defconstant $DoTheRightThing 0)

(def-mactype :Movie (find-mactype '(:handle :MovieType)))

(def-mactype :PtrToMovie (find-mactype '(:pointer :Movie)))

(def-mactype :Track (find-mactype '(:handle :TrackType)))

(def-mactype :Media (find-mactype '(:handle :MediaType)))

(def-mactype :UserData (find-mactype '(:handle :UserDataRecord)))

(def-mactype :MovieEditState (find-mactype '(:handle :MovieStateRecord)))

(def-mactype :TrackEditState (find-mactype '(:handle :TrackStateRecord)))

(def-mactype :QTRestrictionSet (find-mactype '(:handle :QTRestrictionSetRecord)))

(def-mactype :SpriteWorld (find-mactype '(:pointer :SpriteWorldRecord)))

(def-mactype :Sprite (find-mactype '(:pointer :SpriteRecord)))

(def-mactype :QTTweener (find-mactype '(:pointer :QTTweenerRecord)))
(defrecord (SampleDescription :handle)
   (descSize :signed-long)
   (dataFormat :signed-long)
   (resvd1 :signed-long)
   (resvd2 :SInt16)
   (dataRefIndex :SInt16)
)

;type name? (%define-record :SampleDescription (find-record-descriptor ':SampleDescription))

(def-mactype :SampleDescriptionPtr (find-mactype '(:pointer :SampleDescription)))

(def-mactype :SampleDescriptionHandle (find-mactype '(:handle :SampleDescription)))

(def-mactype :QTBandwidthReference (find-mactype '(:handle :QTBandwidthUsageRecord)))

(def-mactype :QTScheduledBandwidthReference (find-mactype '(:handle :QTScheduledBandwidthUsageRecord)))

(defconstant $kQTNetworkStatusNoNetwork -2)
(defconstant $kQTNetworkStatusUncertain -1)
(defconstant $kQTNetworkStatusNotConnected 0)
(defconstant $kQTNetworkStatusConnected 1)

(def-mactype :QTAtomContainer (find-mactype ':Handle))

(def-mactype :QTAtom (find-mactype ':signed-long))

(def-mactype :QTAtomType (find-mactype ':signed-long))

(def-mactype :QTAtomID (find-mactype ':signed-long))
;  QTFloatDouble is the 64-bit IEEE-754 standard

(def-mactype :QTFloatDouble (find-mactype ':double-float))
;  QTFloatSingle is the 32-bit IEEE-754 standard

(def-mactype :QTFloatSingle (find-mactype ':single-float))
(defrecord (SoundDescription :handle)
   (descSize :signed-long)                      ;  total size of SoundDescription including extra data 
   (dataFormat :signed-long)                    ;  sound format 
   (resvd1 :signed-long)                        ;  reserved for apple use. set to zero 
   (resvd2 :SInt16)                             ;  reserved for apple use. set to zero 
   (dataRefIndex :SInt16)
   (version :SInt16)                            ;  which version is this data 
   (revlevel :SInt16)                           ;  what version of that codec did this 
   (vendor :signed-long)                        ;  whose  codec compressed this data 
   (numChannels :SInt16)                        ;  number of channels of sound 
   (sampleSize :SInt16)                         ;  number of bits per sample 
   (compressionID :SInt16)                      ;  unused. set to zero. 
   (packetSize :SInt16)                         ;  unused. set to zero. 
   (sampleRate :UInt32)                         ;  sample rate sound is captured at 
)

;type name? (%define-record :SoundDescription (find-record-descriptor ':SoundDescription))

(def-mactype :SoundDescriptionPtr (find-mactype '(:pointer :SoundDescription)))

(def-mactype :SoundDescriptionHandle (find-mactype '(:handle :SoundDescription)))
;  version 1 of the SoundDescription record
(defrecord SoundDescriptionV1
                                                ;  original fields
   (desc :SoundDescription)
                                                ;  fixed compression ratio information
   (samplesPerPacket :UInt32)
   (bytesPerPacket :UInt32)
   (bytesPerFrame :UInt32)
   (bytesPerSample :UInt32)
                                                ;  additional atom based fields ([long size, long type, some data], repeat)
)

;type name? (%define-record :SoundDescriptionV1 (find-record-descriptor ':SoundDescriptionV1))

(def-mactype :SoundDescriptionV1Ptr (find-mactype '(:pointer :SoundDescriptionV1)))

(def-mactype :SoundDescriptionV1Handle (find-mactype '(:handle :SoundDescriptionV1)))

(defconstant $kTx3gSampleType :|tx3g|)
(defconstant $kTx3gFontTableAtomType :|ftab|)
(defconstant $kTx3gBlinkAtomType :|blnk|)
(defrecord Tx3gRGBAColor
   (red :UInt8)
   (green :UInt8)
   (blue :UInt8)
   (transparency :UInt8)
)

;type name? (%define-record :Tx3gRGBAColor (find-record-descriptor ':Tx3gRGBAColor))
(defrecord Tx3gStyleRecord
   (startChar :UInt16)
   (endChar :UInt16)
   (fontID :UInt16)
   (fontFace :UInt8)
   (fontSize :UInt8)
   (fontColor :Tx3gRGBAColor)
)

;type name? (%define-record :Tx3gStyleRecord (find-record-descriptor ':Tx3gStyleRecord))

(def-mactype :Tx3gStylePtr (find-mactype '(:pointer :Tx3gStyleRecord)))

(def-mactype :Tx3gStyleHandle (find-mactype '(:handle :Tx3gStyleRecord)))
(defrecord Tx3gStyleTableRecord
   (count :UInt16)
   (table (:array :Tx3gStyleRecord 1))
)

;type name? (%define-record :Tx3gStyleTableRecord (find-record-descriptor ':Tx3gStyleTableRecord))

(def-mactype :Tx3gStyleTablePtr (find-mactype '(:pointer :Tx3gStyleTableRecord)))

(def-mactype :Tx3gStyleTableHandle (find-mactype '(:handle :Tx3gStyleTableRecord)))
(defrecord Tx3gFontRecord
   (fontID :UInt16)
   (nameLength :UInt8)
   (name (:array :UInt8 1))
)

;type name? (%define-record :Tx3gFontRecord (find-record-descriptor ':Tx3gFontRecord))

(def-mactype :Tx3gFontRecordPtr (find-mactype '(:pointer :Tx3gFontRecord)))
(defrecord Tx3gFontTableRecord
   (entryCount :UInt16)
   (fontEntries (:array :Tx3gFontRecord 1))
)

;type name? (%define-record :Tx3gFontTableRecord (find-record-descriptor ':Tx3gFontTableRecord))

(def-mactype :Tx3gFontTablePtr (find-mactype '(:pointer :Tx3gFontTableRecord)))

(def-mactype :Tx3gFontTableHandle (find-mactype '(:handle :Tx3gFontTableRecord)))
(defrecord Tx3gDescription
   (descSize :signed-long)
   (dataFormat :signed-long)
   (resvd1 :signed-long)
   (resvd2 :SInt16)
   (dataRefIndex :SInt16)
   (displayFlags :UInt32)
   (horizontalJustification :character)
   (verticalJustification :character)
   (backgroundColor :Tx3gRGBAColor)
   (defaultTextBox :Rect)
   (defaultStyle :Tx3gStyleRecord)
)

;type name? (%define-record :Tx3gDescription (find-record-descriptor ':Tx3gDescription))

(def-mactype :Tx3gDescriptionPtr (find-mactype '(:pointer :Tx3gDescription)))

(def-mactype :Tx3gDescriptionHandle (find-mactype '(:handle :Tx3gDescription)))
(defrecord (TextDescription :handle)
   (descSize :signed-long)                      ;  Total size of TextDescription
   (dataFormat :signed-long)                    ;  'text'
   (resvd1 :signed-long)
   (resvd2 :SInt16)
   (dataRefIndex :SInt16)
   (displayFlags :signed-long)                  ;  see enum below for flag values
   (textJustification :signed-long)             ;  Can be: teCenter,teFlush -Default,-Right,-Left
   (bgColor :RGBColor)                          ;  Background color
   (defaultTextBox :Rect)                       ;  Location to place the text within the track bounds
   (defaultStyle :ScrpSTElement)                ;  Default style (struct defined in TextEdit.h)
   (defaultFontName (:array :character 1))      ;  Font Name (pascal string - struct extended to fit) 
)

;type name? (%define-record :TextDescription (find-record-descriptor ':TextDescription))

(def-mactype :TextDescriptionPtr (find-mactype '(:pointer :TextDescription)))

(def-mactype :TextDescriptionHandle (find-mactype '(:handle :TextDescription)))
(defrecord SpriteDescription
   (descSize :signed-long)                      ;  total size of SpriteDescription including extra data 
   (dataFormat :signed-long)                    ;   
   (resvd1 :signed-long)                        ;  reserved for apple use 
   (resvd2 :SInt16)
   (dataRefIndex :SInt16)
   (version :signed-long)                       ;  which version is this data 
   (decompressorType :OSType)                   ;  which decompressor to use, 0 for no decompression 
   (sampleFlags :signed-long)                   ;  how to interpret samples 
)

;type name? (%define-record :SpriteDescription (find-record-descriptor ':SpriteDescription))

(def-mactype :SpriteDescriptionPtr (find-mactype '(:pointer :SpriteDescription)))

(def-mactype :SpriteDescriptionHandle (find-mactype '(:handle :SpriteDescription)))
(defrecord FlashDescription
   (descSize :signed-long)
   (dataFormat :signed-long)
   (resvd1 :signed-long)
   (resvd2 :SInt16)
   (dataRefIndex :SInt16)
   (version :signed-long)                       ;  which version is this data 
   (decompressorType :OSType)                   ;  which decompressor to use, 0 for no decompression 
   (flags :signed-long)
)

;type name? (%define-record :FlashDescription (find-record-descriptor ':FlashDescription))

(def-mactype :FlashDescriptionPtr (find-mactype '(:pointer :FlashDescription)))

(def-mactype :FlashDescriptionHandle (find-mactype '(:handle :FlashDescription)))
(defrecord ThreeDeeDescription
   (descSize :signed-long)                      ;  total size of ThreeDeeDescription including extra data 
   (dataFormat :signed-long)                    ;   
   (resvd1 :signed-long)                        ;  reserved for apple use 
   (resvd2 :SInt16)
   (dataRefIndex :SInt16)
   (version :signed-long)                       ;  which version is this data 
   (rendererType :signed-long)                  ;  which renderer to use, 0 for default 
   (decompressorType :signed-long)              ;  which decompressor to use, 0 for default 
)

;type name? (%define-record :ThreeDeeDescription (find-record-descriptor ':ThreeDeeDescription))

(def-mactype :ThreeDeeDescriptionPtr (find-mactype '(:pointer :ThreeDeeDescription)))

(def-mactype :ThreeDeeDescriptionHandle (find-mactype '(:handle :ThreeDeeDescription)))
(defrecord DataReferenceRecord
   (dataRefType :OSType)
   (dataRef :Handle)
)

;type name? (%define-record :DataReferenceRecord (find-record-descriptor ':DataReferenceRecord))

(def-mactype :DataReferencePtr (find-mactype '(:pointer :DataReferenceRecord)))
; --------------------------
;   Music Sample Description
; --------------------------
(defrecord MusicDescription
   (descSize :signed-long)
   (dataFormat :signed-long)                    ;  'musi' 
   (resvd1 :signed-long)
   (resvd2 :SInt16)
   (dataRefIndex :SInt16)
   (musicFlags :signed-long)
   (headerData (:array :UInt32 1))              ;  variable size! 
)

;type name? (%define-record :MusicDescription (find-record-descriptor ':MusicDescription))

(def-mactype :MusicDescriptionPtr (find-mactype '(:pointer :MusicDescription)))

(def-mactype :MusicDescriptionHandle (find-mactype '(:handle :MusicDescription)))

(defconstant $kMusicFlagDontPlay2Soft 1)
(defconstant $kMusicFlagDontSlaveToMovie 2)

(defconstant $dfDontDisplay 1)                  ;  Don't display the text

(defconstant $dfDontAutoScale 2)                ;  Don't scale text as track bounds grows or shrinks

(defconstant $dfClipToTextBox 4)                ;  Clip update to the textbox

(defconstant $dfUseMovieBGColor 8)              ;  Set text background to movie's background color

(defconstant $dfShrinkTextBoxToFit 16)          ;  Compute minimum box to fit the sample

(defconstant $dfScrollIn 32)                    ;  Scroll text in until last of text is in view 

(defconstant $dfScrollOut 64)                   ;  Scroll text out until last of text is gone (if both set, scroll in then out)

(defconstant $dfHorizScroll #x80)               ;  Scroll text horizontally (otherwise it's vertical)

(defconstant $dfReverseScroll #x100)            ;  vert: scroll down rather than up; horiz: scroll backwards (justfication dependent)

(defconstant $dfContinuousScroll #x200)         ;  new samples cause previous samples to scroll out 

(defconstant $dfFlowHoriz #x400)                ;  horiz scroll text flows in textbox rather than extend to right 

(defconstant $dfContinuousKaraoke #x800)        ;  ignore begin offset, hilite everything up to the end offset(karaoke)

(defconstant $dfDropShadow #x1000)              ;  display text with a drop shadow 

(defconstant $dfAntiAlias #x2000)               ;  attempt to display text anti aliased

(defconstant $dfKeyedText #x4000)               ;  key the text over background

(defconstant $dfInverseHilite #x8000)           ;  Use inverse hiliting rather than using hilite color
;  changes text color in place of hiliting. 

(defconstant $dfTextColorHilite #x10000)

(defconstant $searchTextDontGoToFoundTime #x10000)
(defconstant $searchTextDontHiliteFoundText #x20000)
(defconstant $searchTextOneTrackOnly #x40000)
(defconstant $searchTextEnabledTracksOnly #x80000)
; use these with the text property routines
;  set property parameter / get property parameter

(defconstant $kTextTextHandle 1)                ;  Handle / preallocated Handle

(defconstant $kTextTextPtr 2)                   ;  Pointer

(defconstant $kTextTEStyle 3)                   ;  TextStyle * / TextStyle *

(defconstant $kTextSelection 4)                 ;  long [2] / long [2]

(defconstant $kTextBackColor 5)                 ;  RGBColor * / RGBColor *

(defconstant $kTextForeColor 6)                 ;  RGBColor * / RGBColor *

(defconstant $kTextFace 7)                      ;  long / long *

(defconstant $kTextFont 8)                      ;  long / long *

(defconstant $kTextSize 9)                      ;  long / long *

(defconstant $kTextAlignment 10)                ;  short * / short *

(defconstant $kTextHilite 11)                   ;  hiliteRecord * / hiliteRecord *

(defconstant $kTextDropShadow 12)               ;  dropShadowRecord * / dropShadowRecord *

(defconstant $kTextDisplayFlags 13)             ;  long / long *

(defconstant $kTextScroll 14)                   ;  TimeValue * / TimeValue *

(defconstant $kTextRelativeScroll 15)           ;  Point *

(defconstant $kTextHyperTextFace 16)            ;  hyperTextSetFace * / hyperTextSetFace *

(defconstant $kTextHyperTextColor 17)           ;  hyperTextSetColor * / hyperTextSetColor *

(defconstant $kTextKeyEntry 18)                 ;  short

(defconstant $kTextMouseDown 19)                ;  Point *

(defconstant $kTextTextBox 20)                  ;  Rect * / Rect *

(defconstant $kTextEditState 21)                ;  short / short *

(defconstant $kTextLength 22)                   ;        / long *


(defconstant $k3DMediaRendererEntry :|rend|)
(defconstant $k3DMediaRendererName :|name|)
(defconstant $k3DMediaRendererCode :|rcod|)
;  progress messages 

(defconstant $movieProgressOpen 0)
(defconstant $movieProgressUpdatePercent 1)
(defconstant $movieProgressClose 2)
;  progress operations 

(defconstant $progressOpFlatten 1)
(defconstant $progressOpInsertTrackSegment 2)
(defconstant $progressOpInsertMovieSegment 3)
(defconstant $progressOpPaste 4)
(defconstant $progressOpAddMovieSelection 5)
(defconstant $progressOpCopy 6)
(defconstant $progressOpCut 7)
(defconstant $progressOpLoadMovieIntoRam 8)
(defconstant $progressOpLoadTrackIntoRam 9)
(defconstant $progressOpLoadMediaIntoRam 10)
(defconstant $progressOpImportMovie 11)
(defconstant $progressOpExportMovie 12)

(defconstant $mediaQualityDraft 0)
(defconstant $mediaQualityNormal 64)
(defconstant $mediaQualityBetter #x80)
(defconstant $mediaQualityBest #xC0)
; ****
;     Interactive Sprites Support
; ****
;  QTEventRecord flags

(defconstant $kQTEventPayloadIsQTList 1)
(defrecord QTEventRecord
   (version :signed-long)
   (eventType :OSType)
   (where :Point)
   (flags :signed-long)
   (payloadRefcon :signed-long)                 ;  from here down only present if version >= 2
   (param1 :signed-long)
   (param2 :signed-long)
   (param3 :signed-long)
)

;type name? (%define-record :QTEventRecord (find-record-descriptor ':QTEventRecord))

(def-mactype :QTEventRecordPtr (find-mactype '(:pointer :QTEventRecord)))
(defrecord QTAtomSpec
   (container :Handle)
   (atom :signed-long)
)

;type name? (%define-record :QTAtomSpec (find-record-descriptor ':QTAtomSpec))

(def-mactype :QTAtomSpecPtr (find-mactype '(:pointer :QTAtomSpec)))
(defrecord ResolvedQTEventSpec
   (actionAtom :QTAtomSpec)
   (targetTrack (:Handle :TrackType))
   (targetRefCon :signed-long)
)

;type name? (%define-record :ResolvedQTEventSpec (find-record-descriptor ':ResolvedQTEventSpec))

(def-mactype :ResolvedQTEventSpecPtr (find-mactype '(:pointer :ResolvedQTEventSpec)))
;  action constants 

(defconstant $kActionMovieSetVolume #x400)      ;  (short movieVolume) 

(defconstant $kActionMovieSetRate #x401)        ;  (Fixed rate) 

(defconstant $kActionMovieSetLoopingFlags #x402);  (long loopingFlags) 

(defconstant $kActionMovieGoToTime #x403)       ;  (TimeValue time) 

(defconstant $kActionMovieGoToTimeByName #x404) ;  (Str255 timeName) 

(defconstant $kActionMovieGoToBeginning #x405)  ;  no params 

(defconstant $kActionMovieGoToEnd #x406)        ;  no params 

(defconstant $kActionMovieStepForward #x407)    ;  no params 

(defconstant $kActionMovieStepBackward #x408)   ;  no params 

(defconstant $kActionMovieSetSelection #x409)   ;  (TimeValue startTime, TimeValue endTime) 

(defconstant $kActionMovieSetSelectionByName #x40A);  (Str255 startTimeName, Str255 endTimeName) 

(defconstant $kActionMoviePlaySelection #x40B)  ;  (Boolean selectionOnly) 

(defconstant $kActionMovieSetLanguage #x40C)    ;  (long language) 

(defconstant $kActionMovieChanged #x40D)        ;  no params 

(defconstant $kActionMovieRestartAtTime #x40E)  ;  (TimeValue startTime, Fixed rate) 

(defconstant $kActionMovieGotoNextChapter #x40F);  no params 

(defconstant $kActionMovieGotoPreviousChapter #x410);  no params 

(defconstant $kActionMovieGotoFirstChapter #x411);  no params 

(defconstant $kActionMovieGotoLastChapter #x412);  no params 

(defconstant $kActionMovieGotoChapterByIndex #x413);  ( short index ) 

(defconstant $kActionMovieSetScale #x414)       ;  (Fixed xScale, Fixed yScale) 

(defconstant $kActionTrackSetVolume #x800)      ;  (short volume) 

(defconstant $kActionTrackSetBalance #x801)     ;  (short balance) 

(defconstant $kActionTrackSetEnabled #x802)     ;  (Boolean enabled) 

(defconstant $kActionTrackSetMatrix #x803)      ;  (MatrixRecord matrix) 

(defconstant $kActionTrackSetLayer #x804)       ;  (short layer) 

(defconstant $kActionTrackSetClip #x805)        ;  (RgnHandle clip) 

(defconstant $kActionTrackSetCursor #x806)      ;  (QTATomID cursorID) 

(defconstant $kActionTrackSetGraphicsMode #x807);  (ModifierTrackGraphicsModeRecord graphicsMode) 

(defconstant $kActionTrackSetIdleFrequency #x808);  (long frequency) 

(defconstant $kActionTrackSetBassTreble #x809)  ;  (short base, short treble) 

(defconstant $kActionSpriteSetMatrix #xC00)     ;  (MatrixRecord matrix) 

(defconstant $kActionSpriteSetImageIndex #xC01) ;  (short imageIndex) 

(defconstant $kActionSpriteSetVisible #xC02)    ;  (short visible) 

(defconstant $kActionSpriteSetLayer #xC03)      ;  (short layer) 

(defconstant $kActionSpriteSetGraphicsMode #xC04);  (ModifierTrackGraphicsModeRecord graphicsMode) 

(defconstant $kActionSpritePassMouseToCodec #xC06);  no params 

(defconstant $kActionSpriteClickOnCodec #xC07)  ;  Point localLoc 

(defconstant $kActionSpriteTranslate #xC08)     ;  (Fixed x, Fixed y, Boolean isAbsolute) 

(defconstant $kActionSpriteScale #xC09)         ;  (Fixed xScale, Fixed yScale) 

(defconstant $kActionSpriteRotate #xC0A)        ;  (Fixed degrees) 

(defconstant $kActionSpriteStretch #xC0B)       ;  (Fixed p1x, Fixed p1y, Fixed p2x, Fixed p2y, Fixed p3x, Fixed p3y, Fixed p4x, Fixed p4y) 

(defconstant $kActionSpriteSetCanBeHitTested #xC16);  (short canBeHitTested) 

(defconstant $kActionQTVRSetPanAngle #x1000)    ;  (float panAngle) 

(defconstant $kActionQTVRSetTiltAngle #x1001)   ;  (float tiltAngle) 

(defconstant $kActionQTVRSetFieldOfView #x1002) ;  (float fieldOfView) 

(defconstant $kActionQTVRShowDefaultView #x1003);  no params 

(defconstant $kActionQTVRGoToNodeID #x1004)     ;  (UInt32 nodeID) 

(defconstant $kActionQTVREnableHotSpot #x1005)  ;  long ID, Boolean enable 

(defconstant $kActionQTVRShowHotSpots #x1006)   ;  Boolean show 

(defconstant $kActionQTVRTranslateObject #x1007);  float xMove, float yMove 

(defconstant $kActionQTVRSetViewState #x100D)   ;  long viewStateType, short state 

(defconstant $kActionMusicPlayNote #x1400)      ;  (long sampleDescIndex, long partNumber, long delay, long pitch, long velocity, long duration) 

(defconstant $kActionMusicSetController #x1401) ;  (long sampleDescIndex, long partNumber, long delay, long controller, long value) 

(defconstant $kActionCase #x1800)               ;  [(CaseStatementActionAtoms)] 

(defconstant $kActionWhile #x1801)              ;  [(WhileStatementActionAtoms)] 

(defconstant $kActionGoToURL #x1802)            ;  (C string urlLink) 

(defconstant $kActionSendQTEventToSprite #x1803);  ([(SpriteTargetAtoms)], QTEventRecord theEvent) 

(defconstant $kActionDebugStr #x1804)           ;  (Str255 theString) 

(defconstant $kActionPushCurrentTime #x1805)    ;  no params 

(defconstant $kActionPushCurrentTimeWithLabel #x1806);  (Str255 theLabel) 

(defconstant $kActionPopAndGotoTopTime #x1807)  ;  no params 

(defconstant $kActionPopAndGotoLabeledTime #x1808);  (Str255 theLabel) 

(defconstant $kActionStatusString #x1809)       ;  (C string theString, long stringTypeFlags) 

(defconstant $kActionSendQTEventToTrackObject #x180A);  ([(TrackObjectTargetAtoms)], QTEventRecord theEvent) 

(defconstant $kActionAddChannelSubscription #x180B);  (Str255 channelName, C string channelsURL, C string channelsPictureURL) 

(defconstant $kActionRemoveChannelSubscription #x180C);  (C string channelsURL) 

(defconstant $kActionOpenCustomActionHandler #x180D);  (long handlerID, ComponentDescription handlerDesc) 

(defconstant $kActionDoScript #x180E)           ;  (long scriptTypeFlags, CString command, CString arguments) 

(defconstant $kActionDoCompressedActions #x180F);  (compressed QTAtomContainer prefixed with eight bytes: long compressorType, long decompressedSize) 

(defconstant $kActionSendAppMessage #x1810)     ;  (long appMessageID) 

(defconstant $kActionLoadComponent #x1811)      ;  (ComponentDescription handlerDesc) 

(defconstant $kActionSetFocus #x1812)           ;  [(TargetAtoms theObject)] 

(defconstant $kActionDontPassKeyEvent #x1813)   ;  no params 

(defconstant $kActionSetRandomSeed #x1814)      ;  long randomSeed 

(defconstant $kActionSpriteTrackSetVariable #x1C00);  (QTAtomID variableID, float value) 

(defconstant $kActionSpriteTrackNewSprite #x1C01);  (QTAtomID spriteID, short imageIndex, MatrixRecord *matrix, short visible, short layer, ModifierTrackGraphicsModeRecord *graphicsMode, QTAtomID actionHandlingSpriteID) 

(defconstant $kActionSpriteTrackDisposeSprite #x1C02);  (QTAtomID spriteID) 

(defconstant $kActionSpriteTrackSetVariableToString #x1C03);  (QTAtomID variableID, C string value) 

(defconstant $kActionSpriteTrackConcatVariables #x1C04);  (QTAtomID firstVariableID, QTAtomID secondVariableID, QTAtomID resultVariableID ) 

(defconstant $kActionSpriteTrackSetVariableToMovieURL #x1C05);  (QTAtomID variableID, < optional: [(MovieTargetAtoms)] > ) 

(defconstant $kActionSpriteTrackSetVariableToMovieBaseURL #x1C06);  (QTAtomID variableID, < optional: [(MovieTargetAtoms)] > ) 

(defconstant $kActionSpriteTrackSetAllSpritesHitTestingMode #x1C0D)
(defconstant $kActionSpriteTrackNewImage #x1C0E);  (C string imageURL, QTAtomID desiredID) 

(defconstant $kActionSpriteTrackDisposeImage #x1C0F);  (short imageIndex) 

(defconstant $kActionApplicationNumberAndString #x2000);  (long aNumber, Str255 aString ) 

(defconstant $kActionQD3DNamedObjectTranslateTo #x2400);  (Fixed x, Fixed y, Fixed z ) 

(defconstant $kActionQD3DNamedObjectScaleTo #x2401);  (Fixed xScale, Fixed yScale, Fixed zScale ) 

(defconstant $kActionQD3DNamedObjectRotateTo #x2402);  (Fixed xDegrees, Fixed yDegrees, Fixed zDegrees ) 

(defconstant $kActionFlashTrackSetPan #x2800)   ;  (short xPercent, short yPercent ) 

(defconstant $kActionFlashTrackSetZoom #x2801)  ;  (short zoomFactor ) 

(defconstant $kActionFlashTrackSetZoomRect #x2802);  (long left, long top, long right, long bottom ) 

(defconstant $kActionFlashTrackGotoFrameNumber #x2803);  (long frameNumber ) 

(defconstant $kActionFlashTrackGotoFrameLabel #x2804);  (C string frameLabel ) 

(defconstant $kActionFlashTrackSetFlashVariable #x2805);  (C string path, C string name, C string value, Boolean updateFocus) 

(defconstant $kActionFlashTrackDoButtonActions #x2806);  (C string path, long buttonID, long transition) 

(defconstant $kActionMovieTrackAddChildMovie #x2C00);  (QTAtomID childMovieID, C string childMovieURL) 

(defconstant $kActionMovieTrackLoadChildMovie #x2C01);  (QTAtomID childMovieID) 

(defconstant $kActionMovieTrackLoadChildMovieWithQTListParams #x2C02);  (QTAtomID childMovieID, C string qtlistXML) 

(defconstant $kActionTextTrackPasteText #x3000) ;  (C string theText, long startSelection, long endSelection ) 

(defconstant $kActionTextTrackSetTextBox #x3003);  (short left, short top, short right, short bottom) 

(defconstant $kActionTextTrackSetTextStyle #x3004);  (Handle textStyle) 

(defconstant $kActionTextTrackSetSelection #x3005);  (long startSelection, long endSelection ) 

(defconstant $kActionTextTrackSetBackgroundColor #x3006);  (ModifierTrackGraphicsModeRecord backgroundColor ) 

(defconstant $kActionTextTrackSetForegroundColor #x3007);  (ModifierTrackGraphicsModeRecord foregroundColor ) 

(defconstant $kActionTextTrackSetFace #x3008)   ;  (long fontFace ) 

(defconstant $kActionTextTrackSetFont #x3009)   ;  (long fontID ) 

(defconstant $kActionTextTrackSetSize #x300A)   ;  (long fontSize ) 

(defconstant $kActionTextTrackSetAlignment #x300B);  (short alignment ) 

(defconstant $kActionTextTrackSetHilite #x300C) ;  (long startHighlight, long endHighlight, ModifierTrackGraphicsModeRecord highlightColor ) 

(defconstant $kActionTextTrackSetDropShadow #x300D);  (Point dropShadow, short transparency ) 

(defconstant $kActionTextTrackSetDisplayFlags #x300E);  (long flags ) 

(defconstant $kActionTextTrackSetScroll #x300F) ;  (long delay ) 

(defconstant $kActionTextTrackRelativeScroll #x3010);  (short deltaX, short deltaY ) 

(defconstant $kActionTextTrackFindText #x3011)  ;  (long flags, Str255 theText, ModifierTrackGraphicsModeRecord highlightColor ) 

(defconstant $kActionTextTrackSetHyperTextFace #x3012);  (short index, long fontFace ) 

(defconstant $kActionTextTrackSetHyperTextColor #x3013);  (short index, ModifierTrackGraphicsModeRecord highlightColor ) 

(defconstant $kActionTextTrackKeyEntry #x3014)  ;  (short character ) 

(defconstant $kActionTextTrackMouseDown #x3015) ;  no params 

(defconstant $kActionTextTrackSetEditable #x3016);  (short editState) 

(defconstant $kActionListAddElement #x3400)     ;  (C string parentPath, long atIndex, C string newElementName) 

(defconstant $kActionListRemoveElements #x3401) ;  (C string parentPath, long startIndex, long endIndex) 

(defconstant $kActionListSetElementValue #x3402);  (C string elementPath, C string valueString) 

(defconstant $kActionListPasteFromXML #x3403)   ;  (C string xml, C string targetParentPath, long startIndex) 

(defconstant $kActionListSetMatchingFromXML #x3404);  (C string xml, C string targetParentPath) 

(defconstant $kActionListSetFromURL #x3405)     ;  (C string url, C string targetParentPath ) 

(defconstant $kActionListExchangeLists #x3406)  ;  (C string url, C string parentPath) 

(defconstant $kActionListServerQuery #x3407)    ;  (C string url, C string keyValuePairs, long flags, C string parentPath) 


(defconstant $kOperandExpression 1)
(defconstant $kOperandConstant 2)
(defconstant $kOperandSubscribedToChannel 3)    ;  C string channelsURL 

(defconstant $kOperandUniqueCustomActionHandlerID 4)
(defconstant $kOperandCustomActionHandlerIDIsOpen 5);  long ID 

(defconstant $kOperandConnectionSpeed 6)
(defconstant $kOperandGMTDay 7)
(defconstant $kOperandGMTMonth 8)
(defconstant $kOperandGMTYear 9)
(defconstant $kOperandGMTHours 10)
(defconstant $kOperandGMTMinutes 11)
(defconstant $kOperandGMTSeconds 12)
(defconstant $kOperandLocalDay 13)
(defconstant $kOperandLocalMonth 14)
(defconstant $kOperandLocalYear 15)
(defconstant $kOperandLocalHours 16)
(defconstant $kOperandLocalMinutes 17)
(defconstant $kOperandLocalSeconds 18)
(defconstant $kOperandRegisteredForQuickTimePro 19)
(defconstant $kOperandPlatformRunningOn 20)
(defconstant $kOperandQuickTimeVersion 21)
(defconstant $kOperandComponentVersion 22)      ;  C string type, C string subType, C string manufacturer 

(defconstant $kOperandOriginalHandlerRefcon 23)
(defconstant $kOperandTicks 24)
(defconstant $kOperandMaxLoadedTimeInMovie 25)
(defconstant $kOperandEventParameter 26)        ;  short index 

(defconstant $kOperandFreeMemory 27)
(defconstant $kOperandNetworkStatus 28)
(defconstant $kOperandQuickTimeVersionRegistered 29);  long version 

(defconstant $kOperandSystemVersion 30)
(defconstant $kOperandMovieVolume #x400)
(defconstant $kOperandMovieRate #x401)
(defconstant $kOperandMovieIsLooping #x402)
(defconstant $kOperandMovieLoopIsPalindrome #x403)
(defconstant $kOperandMovieTime #x404)
(defconstant $kOperandMovieDuration #x405)
(defconstant $kOperandMovieTimeScale #x406)
(defconstant $kOperandMovieWidth #x407)
(defconstant $kOperandMovieHeight #x408)
(defconstant $kOperandMovieLoadState #x409)
(defconstant $kOperandMovieTrackCount #x40A)
(defconstant $kOperandMovieIsActive #x40B)
(defconstant $kOperandMovieName #x40C)
(defconstant $kOperandMovieID #x40D)
(defconstant $kOperandMovieChapterCount #x40E)
(defconstant $kOperandMovieChapterIndex #x40F)
(defconstant $kOperandMovieChapterName #x410)
(defconstant $kOperandMovieChapterNameByIndex #x411);  ( short index ) 

(defconstant $kOperandMovieChapterIndexByName #x412);  (c string name)  

(defconstant $kOperandMovieAnnotation #x413)    ;  (c string requested, long flags) 

(defconstant $kOperandMovieConnectionFlags #x414)
(defconstant $kOperandMovieConnectionString #x415)
(defconstant $kOperandTrackVolume #x800)
(defconstant $kOperandTrackBalance #x801)
(defconstant $kOperandTrackEnabled #x802)
(defconstant $kOperandTrackLayer #x803)
(defconstant $kOperandTrackWidth #x804)
(defconstant $kOperandTrackHeight #x805)
(defconstant $kOperandTrackDuration #x806)
(defconstant $kOperandTrackName #x807)
(defconstant $kOperandTrackID #x808)
(defconstant $kOperandTrackIdleFrequency #x809)
(defconstant $kOperandTrackBass #x80A)
(defconstant $kOperandTrackTreble #x80B)
(defconstant $kOperandSpriteBoundsLeft #xC00)
(defconstant $kOperandSpriteBoundsTop #xC01)
(defconstant $kOperandSpriteBoundsRight #xC02)
(defconstant $kOperandSpriteBoundsBottom #xC03)
(defconstant $kOperandSpriteImageIndex #xC04)
(defconstant $kOperandSpriteVisible #xC05)
(defconstant $kOperandSpriteLayer #xC06)
(defconstant $kOperandSpriteTrackVariable #xC07);  [QTAtomID variableID] 

(defconstant $kOperandSpriteTrackNumSprites #xC08)
(defconstant $kOperandSpriteTrackNumImages #xC09)
(defconstant $kOperandSpriteID #xC0A)
(defconstant $kOperandSpriteIndex #xC0B)
(defconstant $kOperandSpriteFirstCornerX #xC0C)
(defconstant $kOperandSpriteFirstCornerY #xC0D)
(defconstant $kOperandSpriteSecondCornerX #xC0E)
(defconstant $kOperandSpriteSecondCornerY #xC0F)
(defconstant $kOperandSpriteThirdCornerX #xC10)
(defconstant $kOperandSpriteThirdCornerY #xC11)
(defconstant $kOperandSpriteFourthCornerX #xC12)
(defconstant $kOperandSpriteFourthCornerY #xC13)
(defconstant $kOperandSpriteImageRegistrationPointX #xC14)
(defconstant $kOperandSpriteImageRegistrationPointY #xC15)
(defconstant $kOperandSpriteTrackSpriteIDAtPoint #xC16);  short x, short y 

(defconstant $kOperandSpriteName #xC17)
(defconstant $kOperandSpriteCanBeHitTested #xC21);  short 

(defconstant $kOperandSpriteTrackAllSpritesHitTestingMode #xC22)
(defconstant $kOperandSpriteTrackImageIDByIndex #xC23);  short imageIndex 

(defconstant $kOperandSpriteTrackImageIndexByID #xC24);  QTAtomID 

(defconstant $kOperandQTVRPanAngle #x1000)
(defconstant $kOperandQTVRTiltAngle #x1001)
(defconstant $kOperandQTVRFieldOfView #x1002)
(defconstant $kOperandQTVRNodeID #x1003)
(defconstant $kOperandQTVRHotSpotsVisible #x1004)
(defconstant $kOperandQTVRViewCenterH #x1005)
(defconstant $kOperandQTVRViewCenterV #x1006)
(defconstant $kOperandQTVRViewStateCount #x1007)
(defconstant $kOperandQTVRViewState #x1008)     ;  long viewStateType 

(defconstant $kOperandMouseLocalHLoc #x1400)    ;  [TargetAtoms aTrack] 

(defconstant $kOperandMouseLocalVLoc #x1401)    ;  [TargetAtoms aTrack] 

(defconstant $kOperandKeyIsDown #x1402)         ;  [short modKeys, char asciiValue] 

(defconstant $kOperandRandom #x1403)            ;  [short min, short max] 

(defconstant $kOperandCanHaveFocus #x1404)      ;  [(TargetAtoms theObject)] 

(defconstant $kOperandHasFocus #x1405)          ;  [(TargetAtoms theObject)] 

(defconstant $kOperandTextTrackEditable #x1800)
(defconstant $kOperandTextTrackCopyText #x1801) ;  long startSelection, long endSelection 

(defconstant $kOperandTextTrackStartSelection #x1802)
(defconstant $kOperandTextTrackEndSelection #x1803)
(defconstant $kOperandTextTrackTextBoxLeft #x1804)
(defconstant $kOperandTextTrackTextBoxTop #x1805)
(defconstant $kOperandTextTrackTextBoxRight #x1806)
(defconstant $kOperandTextTrackTextBoxBottom #x1807)
(defconstant $kOperandTextTrackTextLength #x1808)
(defconstant $kOperandListCountElements #x1C00) ;  (C string parentPath) 

(defconstant $kOperandListGetElementPathByIndex #x1C01);  (C string parentPath, long index) 

(defconstant $kOperandListGetElementValue #x1C02);  (C string elementPath) 

(defconstant $kOperandListCopyToXML #x1C03)     ;  (C string parentPath, long startIndex, long endIndex) 

(defconstant $kOperandSin #x2000)               ;  float x    

(defconstant $kOperandCos #x2001)               ;  float x    

(defconstant $kOperandTan #x2002)               ;  float x    

(defconstant $kOperandATan #x2003)              ;  float x    

(defconstant $kOperandATan2 #x2004)             ;  float y, float x   

(defconstant $kOperandDegreesToRadians #x2005)  ;  float x 

(defconstant $kOperandRadiansToDegrees #x2006)  ;  float x 

(defconstant $kOperandSquareRoot #x2007)        ;  float x 

(defconstant $kOperandExponent #x2008)          ;  float x 

(defconstant $kOperandLog #x2009)               ;  float x 

(defconstant $kOperandFlashTrackVariable #x2400);  [CString path, CString name] 

(defconstant $kOperandStringLength #x2800)      ;  (C string text) 

(defconstant $kOperandStringCompare #x2801)     ;  (C string aText, C string bText, Boolean caseSensitive, Boolan diacSensitive) 

(defconstant $kOperandStringSubString #x2802)   ;  (C string text, long offset, long length) 

(defconstant $kOperandStringConcat #x2803)      ;  (C string aText, C string bText) 


(defconstant $kFirstMovieAction #x400)
(defconstant $kLastMovieAction #x414)
(defconstant $kFirstTrackAction #x800)
(defconstant $kLastTrackAction #x809)
(defconstant $kFirstSpriteAction #xC00)
(defconstant $kLastSpriteAction #xC16)
(defconstant $kFirstQTVRAction #x1000)
(defconstant $kLastQTVRAction #x100D)
(defconstant $kFirstMusicAction #x1400)
(defconstant $kLastMusicAction #x1401)
(defconstant $kFirstSystemAction #x1800)
(defconstant $kLastSystemAction #x1814)
(defconstant $kFirstSpriteTrackAction #x1C00)
(defconstant $kLastSpriteTrackAction #x1C0F)
(defconstant $kFirstApplicationAction #x2000)
(defconstant $kLastApplicationAction #x2000)
(defconstant $kFirstQD3DNamedObjectAction #x2400)
(defconstant $kLastQD3DNamedObjectAction #x2402)
(defconstant $kFirstFlashTrackAction #x2800)
(defconstant $kLastFlashTrackAction #x2806)
(defconstant $kFirstMovieTrackAction #x2C00)
(defconstant $kLastMovieTrackAction #x2C02)
(defconstant $kFirstTextTrackAction #x3000)
(defconstant $kLastTextTrackAction #x3016)
(defconstant $kFirstMultiTargetAction #x3400)
(defconstant $kLastMultiTargetAction #x3407)
(defconstant $kFirstAction #x400)
(defconstant $kLastAction #x3407)
;  target atom types

(defconstant $kTargetMovie :|moov|)             ;  no data 

(defconstant $kTargetMovieName :|mona|)         ;  (PString movieName) 

(defconstant $kTargetMovieID :|moid|)           ;  (long movieID) 

(defconstant $kTargetRootMovie :|moro|)         ;  no data 

(defconstant $kTargetParentMovie :|mopa|)       ;  no data 

(defconstant $kTargetChildMovieTrackName :|motn|);  (PString childMovieTrackName) 

(defconstant $kTargetChildMovieTrackID :|moti|) ;  (long childMovieTrackID) 

(defconstant $kTargetChildMovieTrackIndex :|motx|);  (long childMovieTrackIndex) 

(defconstant $kTargetChildMovieMovieName :|momn|);  (PString childMovieName) 

(defconstant $kTargetChildMovieMovieID :|momi|) ;  (long childMovieID) 

(defconstant $kTargetTrackName :|trna|)         ;  (PString trackName) 

(defconstant $kTargetTrackID :|trid|)           ;  (long trackID) 

(defconstant $kTargetTrackType :|trty|)         ;  (OSType trackType) 

(defconstant $kTargetTrackIndex :|trin|)        ;  (long trackIndex) 

(defconstant $kTargetSpriteName :|spna|)        ;  (PString spriteName) 

(defconstant $kTargetSpriteID :|spid|)          ;  (QTAtomID spriteID) 

(defconstant $kTargetSpriteIndex :|spin|)       ;  (short spriteIndex) 

(defconstant $kTargetQD3DNamedObjectName :|nana|);  (CString objectName) 

(defconstant $kTargetCurrentQTEventParams :|evpa|);  no data 

;  action container atom types

(defconstant $kQTEventType :|evnt|)
(defconstant $kAction :|actn|)
(defconstant $kWhichAction :|whic|)
(defconstant $kActionParameter :|parm|)
(defconstant $kActionTarget :|targ|)
(defconstant $kActionFlags :|flag|)
(defconstant $kActionParameterMinValue :|minv|)
(defconstant $kActionParameterMaxValue :|maxv|)
(defconstant $kActionListAtomType :|list|)
(defconstant $kExpressionContainerAtomType :|expr|)
(defconstant $kConditionalAtomType :|test|)
(defconstant $kOperatorAtomType :|oper|)
(defconstant $kOperandAtomType :|oprn|)
(defconstant $kCommentAtomType :|why |)
(defconstant $kCustomActionHandler :|cust|)
(defconstant $kCustomHandlerID :|id  |)
(defconstant $kCustomHandlerDesc :|desc|)
(defconstant $kQTEventRecordAtomType :|erec|)
;  QTEvent types 

(defconstant $kQTEventMouseClick :|clik|)
(defconstant $kQTEventMouseClickEnd :|cend|)
(defconstant $kQTEventMouseClickEndTriggerButton :|trig|)
(defconstant $kQTEventMouseEnter :|entr|)
(defconstant $kQTEventMouseExit :|exit|)
(defconstant $kQTEventMouseMoved :|move|)
(defconstant $kQTEventFrameLoaded :|fram|)
(defconstant $kQTEventIdle :|idle|)
(defconstant $kQTEventKey :|key |)              ;  qtevent.param1 = key, qtevent.param2 = modifiers, qtEvent.param3 = scanCode 

(defconstant $kQTEventMovieLoaded :|load|)
(defconstant $kQTEventRequestToModifyMovie :|reqm|)
(defconstant $kQTEventListReceived :|list|)
(defconstant $kQTEventKeyUp :|keyU|)            ;  qtevent.param1 = key, qtevent.param2 = modifiers, qtEvent.param3 = scanCode 

;  flags for the kActionFlags atom 

(defconstant $kActionFlagActionIsDelta 2)
(defconstant $kActionFlagParameterWrapsAround 4)
(defconstant $kActionFlagActionIsToggle 8)
;  flags for stringTypeFlags field of the QTStatusStringRecord 

(defconstant $kStatusStringIsURLLink 2)
(defconstant $kStatusStringIsStreamingStatus 4)
(defconstant $kStatusHasCodeNumber 8)           ;  high 16 bits of stringTypeFlags is error code number

(defconstant $kStatusIsError 16)
;  flags for scriptTypeFlags field of the QTDoScriptRecord

(defconstant $kScriptIsUnknownType 1)
(defconstant $kScriptIsJavaScript 2)
(defconstant $kScriptIsLingoEvent 4)
(defconstant $kScriptIsVBEvent 8)
(defconstant $kScriptIsProjectorCommand 16)
(defconstant $kScriptIsAppleScript 32)
;  flags for CheckQuickTimeRegistration routine

(defconstant $kQTRegistrationDialogTimeOutFlag 1)
(defconstant $kQTRegistrationDialogShowDialog 2)
(defconstant $kQTRegistrationDialogForceDialog 4)
;  constants for kOperatorAtomType IDs (operator types)

(defconstant $kOperatorAdd :|add |)
(defconstant $kOperatorSubtract :|sub |)
(defconstant $kOperatorMultiply :|mult|)
(defconstant $kOperatorDivide :|div |)
(defconstant $kOperatorOr :|or  |)
(defconstant $kOperatorAnd :|and |)
(defconstant $kOperatorNot :|not |)
(defconstant $kOperatorLessThan :|<   |)
(defconstant $kOperatorLessThanEqualTo :|<=  |)
(defconstant $kOperatorEqualTo :|=   |)
(defconstant $kOperatorNotEqualTo :|!=  |)
(defconstant $kOperatorGreaterThan :|>   |)
(defconstant $kOperatorGreaterThanEqualTo :|>=  |)
(defconstant $kOperatorModulo :|mod |)
(defconstant $kOperatorIntegerDivide :|idiv|)
(defconstant $kOperatorAbsoluteValue :|abs |)
(defconstant $kOperatorNegate :|neg |)
;  constants for kOperandPlatformRunningOn

(defconstant $kPlatformMacintosh 1)
(defconstant $kPlatformWindows 2)
;  flags for kOperandSystemVersion

(defconstant $kSystemIsWindows9x #x10000)
(defconstant $kSystemIsWindowsNT #x20000)
(defconstant $kSystemIsClassicBlueBox #x40000)
;  constants for MediaPropertiesAtom

(defconstant $kMediaPropertyNonLinearAtomType :|nonl|)
(defconstant $kMediaPropertyHasActions 105)
;  property types

(def-mactype :QTPropertyClass (find-mactype ':OSType))

(def-mactype :QTPropertyID (find-mactype ':OSType))

(def-mactype :QTPropertyValueType (find-mactype ':OSType))

(def-mactype :QTPropertyValuePtr (find-mactype '(:pointer :void)))

(def-mactype :ConstQTPropertyValuePtr (find-mactype '(:pointer :void)))
;  TimeBase and TimeRecord moved to MacTypes.h 

(def-mactype :TimeBaseFlags (find-mactype ':UInt32))

(defconstant $loopTimeBase 1)
(defconstant $palindromeLoopTimeBase 2)
(defconstant $maintainTimeBaseZero 4)

(def-mactype :QTCallBack (find-mactype '(:pointer :QTCallBackHeader)))
;  CallBack equates 

(def-mactype :QTCallBackFlags (find-mactype ':UInt16))

(defconstant $triggerTimeFwd 1)                 ;  when curTime exceeds triggerTime going forward 

(defconstant $triggerTimeBwd 2)                 ;  when curTime exceeds triggerTime going backwards 

(defconstant $triggerTimeEither 3)              ;  when curTime exceeds triggerTime going either direction 

(defconstant $triggerRateLT 4)                  ;  when rate changes to less than trigger value 

(defconstant $triggerRateGT 8)                  ;  when rate changes to greater than trigger value 

(defconstant $triggerRateEqual 16)              ;  when rate changes to equal trigger value 

(defconstant $triggerRateLTE 20)
(defconstant $triggerRateGTE 24)
(defconstant $triggerRateNotEqual 28)
(defconstant $triggerRateChange 0)
(defconstant $triggerAtStart 1)
(defconstant $triggerAtStop 2)

(def-mactype :TimeBaseStatus (find-mactype ':UInt32))

(defconstant $timeBaseBeforeStartTime 1)
(defconstant $timeBaseAfterStopTime 2)
(defconstant $timeBaseRateChanging 4)

(def-mactype :QTCallBackType (find-mactype ':UInt16))

(defconstant $callBackAtTime 1)
(defconstant $callBackAtRate 2)
(defconstant $callBackAtTimeJump 3)
(defconstant $callBackAtExtremes 4)
(defconstant $callBackAtTimeBaseDisposed 5)
(defconstant $callBackAtInterrupt #x8000)
(defconstant $callBackAtDeferredTask #x4000)

(def-mactype :QTCallBackProcPtr (find-mactype ':pointer)); (QTCallBack cb , long refCon)

(def-mactype :QTCallBackUPP (find-mactype '(:pointer :OpaqueQTCallBackProcPtr)))

(defconstant $qtcbNeedsRateChanges 1)           ;  wants to know about rate changes 

(defconstant $qtcbNeedsTimeChanges 2)           ;  wants to know about time changes 

(defconstant $qtcbNeedsStartStopChanges 4)      ;  wants to know when TimeBase start/stop is changed

(defrecord QTCallBackOpaqueHeader
   (callBackFlags :signed-long)
   (reserved1 :signed-long)
   (qtPrivate (:array :SInt8 52))
)

;type name? (%define-record :QTCallBackOpaqueHeader (find-record-descriptor ':QTCallBackOpaqueHeader))

(def-mactype :QTSyncTaskProcPtr (find-mactype ':pointer)); (void * task)

(def-mactype :QTSyncTaskUPP (find-mactype '(:pointer :OpaqueQTSyncTaskProcPtr)))
(defrecord QTSyncTaskRecord
   (qLink :pointer)
   (proc (:pointer :OpaqueQTSyncTaskProcPtr))
)

;type name? (%define-record :QTSyncTaskRecord (find-record-descriptor ':QTSyncTaskRecord))

(def-mactype :QTSyncTaskPtr (find-mactype '(:pointer :QTSyncTaskRecord)))

(def-mactype :MovieRgnCoverProcPtr (find-mactype ':pointer)); (Movie theMovie , RgnHandle changedRgn , long refcon)

(def-mactype :MovieProgressProcPtr (find-mactype ':pointer)); (Movie theMovie , short message , short whatOperation , Fixed percentDone , long refcon)

(def-mactype :MovieDrawingCompleteProcPtr (find-mactype ':pointer)); (Movie theMovie , long refCon)

(def-mactype :TrackTransferProcPtr (find-mactype ':pointer)); (Track t , long refCon)

(def-mactype :GetMovieProcPtr (find-mactype ':pointer)); (long offset , long size , void * dataPtr , void * refCon)

(def-mactype :MoviePreviewCallOutProcPtr (find-mactype ':pointer)); (long refcon)

(def-mactype :TextMediaProcPtr (find-mactype ':pointer)); (Handle theText , Movie theMovie , short * displayFlag , long refcon)

(def-mactype :ActionsProcPtr (find-mactype ':pointer)); (void * refcon , Track targetTrack , long targetRefCon , QTEventRecordPtr theEvent)

(def-mactype :DoMCActionProcPtr (find-mactype ':pointer)); (void * refcon , short action , void * params , Boolean * handled)

(def-mactype :MovieExecuteWiredActionsProcPtr (find-mactype ':pointer)); (Movie theMovie , void * refcon , long flags , QTAtomContainer wiredActions)

(def-mactype :MoviePrePrerollCompleteProcPtr (find-mactype ':pointer)); (Movie theMovie , OSErr prerollErr , void * refcon)

(def-mactype :QTNextTaskNeededSoonerCallbackProcPtr (find-mactype ':pointer)); (TimeValue duration , unsigned long flags , void * refcon)

(def-mactype :MoviesErrorProcPtr (find-mactype ':pointer)); (OSErr theErr , long refcon)

(def-mactype :MovieRgnCoverUPP (find-mactype '(:pointer :OpaqueMovieRgnCoverProcPtr)))

(def-mactype :MovieProgressUPP (find-mactype '(:pointer :OpaqueMovieProgressProcPtr)))

(def-mactype :MovieDrawingCompleteUPP (find-mactype '(:pointer :OpaqueMovieDrawingCompleteProcPtr)))

(def-mactype :TrackTransferUPP (find-mactype '(:pointer :OpaqueTrackTransferProcPtr)))

(def-mactype :GetMovieUPP (find-mactype '(:pointer :OpaqueGetMovieProcPtr)))

(def-mactype :MoviePreviewCallOutUPP (find-mactype '(:pointer :OpaqueMoviePreviewCallOutProcPtr)))

(def-mactype :TextMediaUPP (find-mactype '(:pointer :OpaqueTextMediaProcPtr)))

(def-mactype :ActionsUPP (find-mactype '(:pointer :OpaqueActionsProcPtr)))

(def-mactype :DoMCActionUPP (find-mactype '(:pointer :OpaqueDoMCActionProcPtr)))

(def-mactype :MovieExecuteWiredActionsUPP (find-mactype '(:pointer :OpaqueMovieExecuteWiredActionsProcPtr)))

(def-mactype :MoviePrePrerollCompleteUPP (find-mactype '(:pointer :OpaqueMoviePrePrerollCompleteProcPtr)))

(def-mactype :QTNextTaskNeededSoonerCallbackUPP (find-mactype '(:pointer :OpaqueQTNextTaskNeededSoonerCallbackProcPtr)))

(def-mactype :MoviesErrorUPP (find-mactype '(:pointer :OpaqueMoviesErrorProcPtr)))

(def-mactype :MediaHandler (find-mactype ':ComponentInstance))

(def-mactype :DataHandler (find-mactype ':ComponentInstance))

(def-mactype :MediaHandlerComponent (find-mactype ':Component))

(def-mactype :DataHandlerComponent (find-mactype ':Component))

(def-mactype :HandlerError (find-mactype ':signed-long))

(defconstant $keepInRam 1)                      ;  load and make non-purgable

(defconstant $unkeepInRam 2)                    ;  mark as purgable

(defconstant $flushFromRam 4)                   ;  empty those handles

(defconstant $loadForwardTrackEdits 8)          ;     load track edits into ram for playing forward
;     load track edits into ram for playing in reverse

(defconstant $loadBackwardTrackEdits 16)

(defconstant $newMovieActive 1)
(defconstant $newMovieDontResolveDataRefs 2)
(defconstant $newMovieDontAskUnresolvedDataRefs 4)
(defconstant $newMovieDontAutoAlternates 8)
(defconstant $newMovieDontUpdateForeBackPointers 16)
(defconstant $newMovieDontAutoUpdateClock 32)
(defconstant $newMovieAsyncOK #x100)
(defconstant $newMovieIdleImportOK #x400)
(defconstant $newMovieDontInteractWithUser #x800)
;  track usage bits 

(defconstant $trackUsageInMovie 2)
(defconstant $trackUsageInPreview 4)
(defconstant $trackUsageInPoster 8)
;  Add/GetMediaSample flags 

(defconstant $mediaSampleNotSync 1)             ;  sample is not a sync sample (eg. is frame differenced 
;  sample is a shadow sync 

(defconstant $mediaSampleShadowSync 2)

(defconstant $pasteInParallel 1)
(defconstant $showUserSettingsDialog 2)
(defconstant $movieToFileOnlyExport 4)
(defconstant $movieFileSpecValid 8)

(defconstant $nextTimeMediaSample 1)
(defconstant $nextTimeMediaEdit 2)
(defconstant $nextTimeTrackEdit 4)
(defconstant $nextTimeSyncSample 8)
(defconstant $nextTimeStep 16)
(defconstant $nextTimeEdgeOK #x4000)
(defconstant $nextTimeIgnoreActiveSegment #x8000)

(def-mactype :nextTimeFlagsEnum (find-mactype ':UInt16))

(defconstant $createMovieFileDeleteCurFile #x80000000)
(defconstant $createMovieFileDontCreateMovie #x40000000)
(defconstant $createMovieFileDontOpenFile #x20000000)
(defconstant $createMovieFileDontCreateResFile #x10000000)

(def-mactype :createMovieFileFlagsEnum (find-mactype ':UInt32))

(defconstant $flattenAddMovieToDataFork 1)
(defconstant $flattenActiveTracksOnly 4)
(defconstant $flattenDontInterleaveFlatten 8)
(defconstant $flattenFSSpecPtrIsDataRefRecordPtr 16)
(defconstant $flattenCompressMovieResource 32)
(defconstant $flattenForceMovieResourceBeforeMovieData 64)

(def-mactype :movieFlattenFlagsEnum (find-mactype ':UInt32))
;  magic res ID 

(defconstant $movieInDataForkResID -1)

(defconstant $mcTopLeftMovie 1)                 ;  usually centered 

(defconstant $mcScaleMovieToFit 2)              ;  usually only scales down 

(defconstant $mcWithBadge 4)                    ;  give me a badge 

(defconstant $mcNotVisible 8)                   ;  don't show controller 
;  gimme a frame 

(defconstant $mcWithFrame 16)

(defconstant $movieScrapDontZeroScrap 1)
(defconstant $movieScrapOnlyPutMovie 2)

(defconstant $dataRefSelfReference 1)
(defconstant $dataRefWasNotResolved 2)

(def-mactype :dataRefAttributesFlags (find-mactype ':UInt32))
;  data ref returned is movie default data ref 

(defconstant $kMovieAnchorDataRefIsDefault 1)

(defconstant $hintsScrubMode 1)                 ;  mask == && (if flags == scrub on, flags != scrub off) 

(defconstant $hintsLoop 2)
(defconstant $hintsDontPurge 4)
(defconstant $hintsUseScreenBuffer 32)
(defconstant $hintsAllowInterlace 64)
(defconstant $hintsUseSoundInterp #x80)
(defconstant $hintsHighQuality #x100)           ;  slooooow 

(defconstant $hintsPalindrome #x200)
(defconstant $hintsInactive #x800)
(defconstant $hintsOffscreen #x1000)
(defconstant $hintsDontDraw #x2000)
(defconstant $hintsAllowBlacklining #x4000)
(defconstant $hintsDontUseVideoOverlaySurface #x10000)
(defconstant $hintsIgnoreBandwidthRestrictions #x20000)
(defconstant $hintsPlayingEveryFrame #x40000)
(defconstant $hintsAllowDynamicResize #x80000)
(defconstant $hintsSingleField #x100000)
(defconstant $hintsNoRenderingTimeOut #x200000)
(defconstant $hintsFlushVideoInsteadOfDirtying #x400000)
(defconstant $hintsEnableSubPixelPositioning #x800000)
(defconstant $hintsRenderingMode #x1000000)     ;  asks media handlers not to call UpdateSystemActivity etc 

(defconstant $hintsAllowIdleSleep #x2000000)

(def-mactype :playHintsEnum (find-mactype ':UInt32))

(defconstant $mediaHandlerFlagBaseClient 1)

(def-mactype :mediaHandlerFlagsEnum (find-mactype ':UInt32))

(defconstant $movieTrackMediaType 1)
(defconstant $movieTrackCharacteristic 2)
(defconstant $movieTrackEnabledOnly 4)
(defrecord SampleReferenceRecord
   (dataOffset :signed-long)
   (dataSize :signed-long)
   (durationPerSample :signed-long)
   (numberOfSamples :signed-long)
   (sampleFlags :SInt16)
)

;type name? (%define-record :SampleReferenceRecord (find-record-descriptor ':SampleReferenceRecord))

(def-mactype :SampleReferencePtr (find-mactype '(:pointer :SampleReferenceRecord)))
(defrecord SampleReference64Record
   (dataOffset :wide)
   (dataSize :UInt32)
   (durationPerSample :signed-long)
   (numberOfSamples :UInt32)
   (sampleFlags :SInt16)
)

;type name? (%define-record :SampleReference64Record (find-record-descriptor ':SampleReference64Record))

(def-mactype :SampleReference64Ptr (find-mactype '(:pointer :SampleReference64Record)))
; ************************
; * Initialization Routines 
; *************************
; 
;  *  CheckQuickTimeRegistration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CheckQuickTimeRegistration" 
   ((registrationKey :pointer)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  EnterMovies()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_EnterMovies" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ExitMovies()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ExitMovies" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

(defconstant $kQTEnterMoviesFlagDontSetComponentsThreadMode 1)
; 
;  *  EnterMoviesOnThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_EnterMoviesOnThread" 
   ((inFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  ExitMoviesOnThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_ExitMoviesOnThread" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; ************************
; * Error Routines 
; *************************
; 
;  *  GetMoviesError()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMoviesError" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ClearMoviesStickyError()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ClearMoviesStickyError" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMoviesStickyError()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMoviesStickyError" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMoviesErrorProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMoviesErrorProc" 
   ((errProc (:pointer :OpaqueMoviesErrorProcPtr))
    (refcon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ************************
; * Idle Routines 
; *************************
; 
;  *  MoviesTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MoviesTask" 
   ((theMovie (:Handle :MovieType))
    (maxMilliSecToUse :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PrerollMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PrerollMovie" 
   ((theMovie (:Handle :MovieType))
    (time :signed-long)
    (Rate :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PrePrerollMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_PrePrerollMovie" 
   ((m (:Handle :MovieType))
    (time :signed-long)
    (rate :signed-long)
    (proc (:pointer :OpaqueMoviePrePrerollCompleteProcPtr))
    (refcon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AbortPrePrerollMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_AbortPrePrerollMovie" 
   ((m (:Handle :MovieType))
    (err :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LoadMovieIntoRam()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_LoadMovieIntoRam" 
   ((theMovie (:Handle :MovieType))
    (time :signed-long)
    (duration :signed-long)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  LoadTrackIntoRam()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_LoadTrackIntoRam" 
   ((theTrack (:Handle :TrackType))
    (time :signed-long)
    (duration :signed-long)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  LoadMediaIntoRam()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_LoadMediaIntoRam" 
   ((theMedia (:Handle :MediaType))
    (time :signed-long)
    (duration :signed-long)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMovieActive()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieActive" 
   ((theMovie (:Handle :MovieType))
    (active :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMovieActive()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieActive" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  QTGetWallClockTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTGetWallClockTimeBase" 
   ((wallClockTimeBase (:pointer :TIMEBASE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; ************************
; * Idle Management
; *************************

(def-mactype :IdleManager (find-mactype '(:pointer :OpaqueIdleManager)))
; 
;  *  QTIdleManagerOpen()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTIdleManagerOpen" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueIdleManager)
() )
; 
;  *  QTIdleManagerClose()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTIdleManagerClose" 
   ((im (:pointer :OpaqueIdleManager))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTIdleManagerGetNextIdleTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTIdleManagerGetNextIdleTime" 
   ((im (:pointer :OpaqueIdleManager))
    (nextIdle (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTIdleManagerSetNextIdleTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTIdleManagerSetNextIdleTime" 
   ((im (:pointer :OpaqueIdleManager))
    (nextIdle (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTIdleManagerSetNextIdleTimeNever()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTIdleManagerSetNextIdleTimeNever" 
   ((im (:pointer :OpaqueIdleManager))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTIdleManagerSetNextIdleTimeNow()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTIdleManagerSetNextIdleTimeNow" 
   ((im (:pointer :OpaqueIdleManager))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTIdleManagerSetNextIdleTimeDelta()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTIdleManagerSetNextIdleTimeDelta" 
   ((im (:pointer :OpaqueIdleManager))
    (duration :signed-long)
    (scale :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTIdleManagerSetParent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTIdleManagerSetParent" 
   ((im (:pointer :OpaqueIdleManager))
    (parent (:pointer :OpaqueIdleManager))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTIdleManagerNeedsAnIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTIdleManagerNeedsAnIdle" 
   ((im (:pointer :OpaqueIdleManager))
    (needsOne (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; ************************
; * Carbon Movie Control
; *************************
;  Movie Control option bits

(defconstant $kMovieControlOptionHideController 1)
(defconstant $kMovieControlOptionLocateTopLeft 2)
(defconstant $kMovieControlOptionEnableEditing 4)
(defconstant $kMovieControlOptionHandleEditingHI 8)
(defconstant $kMovieControlOptionSetKeysEnabled 16)
(defconstant $kMovieControlOptionManuallyIdled 32)
;  Item tags for use in GetControlData() (some with SetControlData()) calls on Movie Controls

(defconstant $kMovieControlDataMovieController :|mc  |)
(defconstant $kMovieControlDataMovie :|moov|)
(defconstant $kMovieControlDataManualIdling :|manu|)
; 
; ** CreateMovieControl() -   This is the public API routine that creates a Movie Control. Given a window and location
; **                          plus a movie, it constructs a Movie Control with a Movie Controller in the window.
; 
; 
;  *  CreateMovieControl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateMovieControl" 
   ((theWindow (:pointer :OpaqueWindowPtr))
    (localRect (:pointer :Rect))
    (theMovie (:Handle :MovieType))
    (options :UInt32)
    (returnedControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; ************************
; * calls for playing movies, previews, posters
; *************************
; 
;  *  StartMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_StartMovie" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StopMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_StopMovie" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GoToBeginningOfMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GoToBeginningOfMovie" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GoToEndOfMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GoToEndOfMovie" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  IsMovieDone()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_IsMovieDone" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  GetMoviePreviewMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMoviePreviewMode" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SetMoviePreviewMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMoviePreviewMode" 
   ((theMovie (:Handle :MovieType))
    (usePreview :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ShowMoviePoster()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ShowMoviePoster" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PlayMoviePreview()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PlayMoviePreview" 
   ((theMovie (:Handle :MovieType))
    (callOutProc (:pointer :OpaqueMoviePreviewCallOutProcPtr))
    (refcon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ************************
; * calls for controlling movies & tracks which are playing
; *************************
; 
;  *  GetMovieTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieTimeBase" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :TimeBaseRecord)
() )
; 
;  *  SetMovieMasterTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieMasterTimeBase" 
   ((theMovie (:Handle :MovieType))
    (tb (:pointer :TimeBaseRecord))
    (slaveZero (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMovieMasterClock()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieMasterClock" 
   ((theMovie (:Handle :MovieType))
    (clockMeister (:pointer :ComponentRecord))
    (slaveZero (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ChooseMovieClock()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_ChooseMovieClock" 
   ((m (:Handle :MovieType))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  GetMovieGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieGWorld" 
   ((theMovie (:Handle :MovieType))
    (port (:pointer :CGrafPtr))
    (gdh (:pointer :GDHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMovieGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieGWorld" 
   ((theMovie (:Handle :MovieType))
    (port (:pointer :OpaqueGrafPtr))
    (gdh (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

(defconstant $movieDrawingCallWhenChanged 0)
(defconstant $movieDrawingCallAlways 1)
; 
;  *  SetMovieDrawingCompleteProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieDrawingCompleteProc" 
   ((theMovie (:Handle :MovieType))
    (flags :signed-long)
    (proc (:pointer :OpaqueMovieDrawingCompleteProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMovieNaturalBoundsRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieNaturalBoundsRect" 
   ((theMovie (:Handle :MovieType))
    (naturalBounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetNextTrackForCompositing()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetNextTrackForCompositing" 
   ((theMovie (:Handle :MovieType))
    (theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :TrackType)
() )
; 
;  *  GetPrevTrackForCompositing()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetPrevTrackForCompositing" 
   ((theMovie (:Handle :MovieType))
    (theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :TrackType)
() )
; 
;  *  SetTrackGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackGWorld" 
   ((theTrack (:Handle :TrackType))
    (port (:pointer :OpaqueGrafPtr))
    (gdh (:Handle :GDEVICE))
    (proc (:pointer :OpaqueTrackTransferProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMoviePict()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMoviePict" 
   ((theMovie (:Handle :MovieType))
    (time :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :Picture)
() )
; 
;  *  GetTrackPict()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackPict" 
   ((theTrack (:Handle :TrackType))
    (time :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :Picture)
() )
; 
;  *  GetMoviePosterPict()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMoviePosterPict" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :Picture)
() )
;  called between Begin & EndUpdate 
; 
;  *  UpdateMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_UpdateMovie" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvalidateMovieRegion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_InvalidateMovieRegion" 
   ((theMovie (:Handle :MovieType))
    (invalidRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *** spatial movie routines ***
; 
;  *  GetMovieBox()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieBox" 
   ((theMovie (:Handle :MovieType))
    (boxRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMovieBox()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieBox" 
   ((theMovie (:Handle :MovieType))
    (boxRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; * movie display clip 
; 
;  *  GetMovieDisplayClipRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieDisplayClipRgn" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; 
;  *  SetMovieDisplayClipRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieDisplayClipRgn" 
   ((theMovie (:Handle :MovieType))
    (theClip (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; * movie src clip 
; 
;  *  GetMovieClipRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieClipRgn" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; 
;  *  SetMovieClipRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieClipRgn" 
   ((theMovie (:Handle :MovieType))
    (theClip (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; * track src clip 
; 
;  *  GetTrackClipRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackClipRgn" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; 
;  *  SetTrackClipRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackClipRgn" 
   ((theTrack (:Handle :TrackType))
    (theClip (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; * bounds in display space (not clipped by display clip) 
; 
;  *  GetMovieDisplayBoundsRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieDisplayBoundsRgn" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; 
;  *  GetTrackDisplayBoundsRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackDisplayBoundsRgn" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; * bounds in movie space 
; 
;  *  GetMovieBoundsRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieBoundsRgn" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; 
;  *  GetTrackMovieBoundsRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackMovieBoundsRgn" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; * bounds in track space 
; 
;  *  GetTrackBoundsRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackBoundsRgn" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; * mattes - always in track space 
; 
;  *  GetTrackMatte()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackMatte" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :PixMap)
() )
; 
;  *  SetTrackMatte()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackMatte" 
   ((theTrack (:Handle :TrackType))
    (theMatte (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMatte()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeMatte" 
   ((theMatte (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; * video out 
; 
;  *  SetMovieVideoOutput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_SetMovieVideoOutput" 
   ((theMovie (:Handle :MovieType))
    (vout (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ************************
; * calls for getting/saving movies
; *************************
; 
;  *  NewMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewMovie" 
   ((flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MovieType)
() )
; 
;  *  PutMovieIntoHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PutMovieIntoHandle" 
   ((theMovie (:Handle :MovieType))
    (publicMovie :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PutMovieIntoDataFork()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PutMovieIntoDataFork" 
   ((theMovie (:Handle :MovieType))
    (fRefNum :SInt16)
    (offset :signed-long)
    (maxSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PutMovieIntoDataFork64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_PutMovieIntoDataFork64" 
   ((theMovie (:Handle :MovieType))
    (fRefNum :signed-long)
    (offset (:pointer :wide))
    (maxSize :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PutMovieIntoStorage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_PutMovieIntoStorage" 
   ((theMovie (:Handle :MovieType))
    (dh (:pointer :ComponentInstanceRecord))
    (offset (:pointer :wide))
    (maxSize :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  PutMovieForDataRefIntoHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_PutMovieForDataRefIntoHandle" 
   ((theMovie (:Handle :MovieType))
    (dataRef :Handle)
    (dataRefType :OSType)
    (publicMovie :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  DisposeMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeMovie" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ************************
; * Movie State Routines
; *************************
; 
;  *  GetMovieCreationTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieCreationTime" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetMovieModificationTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieModificationTime" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetMovieTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieTimeScale" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SetMovieTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieTimeScale" 
   ((theMovie (:Handle :MovieType))
    (timeScale :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMovieDuration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieDuration" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GetMovieRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieRate" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SetMovieRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieRate" 
   ((theMovie (:Handle :MovieType))
    (rate :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMoviePreferredRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMoviePreferredRate" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SetMoviePreferredRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMoviePreferredRate" 
   ((theMovie (:Handle :MovieType))
    (rate :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMoviePreferredVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMoviePreferredVolume" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetMoviePreferredVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMoviePreferredVolume" 
   ((theMovie (:Handle :MovieType))
    (volume :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMovieVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieVolume" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetMovieVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieVolume" 
   ((theMovie (:Handle :MovieType))
    (volume :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMovieMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieMatrix" 
   ((theMovie (:Handle :MovieType))
    (matrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMovieMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieMatrix" 
   ((theMovie (:Handle :MovieType))
    (matrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMoviePreviewTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMoviePreviewTime" 
   ((theMovie (:Handle :MovieType))
    (previewTime (:pointer :TIMEVALUE))
    (previewDuration (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMoviePreviewTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMoviePreviewTime" 
   ((theMovie (:Handle :MovieType))
    (previewTime :signed-long)
    (previewDuration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMoviePosterTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMoviePosterTime" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SetMoviePosterTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMoviePosterTime" 
   ((theMovie (:Handle :MovieType))
    (posterTime :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMovieSelection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieSelection" 
   ((theMovie (:Handle :MovieType))
    (selectionTime (:pointer :TIMEVALUE))
    (selectionDuration (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMovieSelection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieSelection" 
   ((theMovie (:Handle :MovieType))
    (selectionTime :signed-long)
    (selectionDuration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMovieActiveSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieActiveSegment" 
   ((theMovie (:Handle :MovieType))
    (startTime :signed-long)
    (duration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMovieActiveSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieActiveSegment" 
   ((theMovie (:Handle :MovieType))
    (startTime (:pointer :TIMEVALUE))
    (duration (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMovieTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieTime" 
   ((theMovie (:Handle :MovieType))
    (currentTime (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SetMovieTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieTime" 
   ((theMovie (:Handle :MovieType))
    (newtime (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMovieTimeValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieTimeValue" 
   ((theMovie (:Handle :MovieType))
    (newtime :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMovieUserData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieUserData" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :UserDataRecord)
() )
; 
;  *  QTGetTimeUntilNextTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTGetTimeUntilNextTask" 
   ((duration (:pointer :long))
    (scale :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTInstallNextTaskNeededSoonerCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTInstallNextTaskNeededSoonerCallback" 
   ((callbackProc (:pointer :OpaqueQTNextTaskNeededSoonerCallbackProcPtr))
    (scale :signed-long)
    (flags :UInt32)
    (refcon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTUninstallNextTaskNeededSoonerCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTUninstallNextTaskNeededSoonerCallback" 
   ((callbackProc (:pointer :OpaqueQTNextTaskNeededSoonerCallbackProcPtr))
    (refcon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  GetMovieRateChangeConstraints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_GetMovieRateChangeConstraints" 
   ((theMovie (:Handle :MovieType))
    (minimumDelay (:pointer :TimeRecord))
    (maximumDelay (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; ************************
; * Track/Media finding routines
; *************************
; 
;  *  GetMovieTrackCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieTrackCount" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetMovieTrack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieTrack" 
   ((theMovie (:Handle :MovieType))
    (trackID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :TrackType)
() )
; 
;  *  GetMovieIndTrack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieIndTrack" 
   ((theMovie (:Handle :MovieType))
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :TrackType)
() )
; 
;  *  GetMovieIndTrackType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieIndTrackType" 
   ((theMovie (:Handle :MovieType))
    (index :signed-long)
    (trackType :OSType)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :TrackType)
() )
; 
;  *  GetTrackID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackID" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetTrackMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackMovie" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MovieType)
() )
; ************************
; * Track creation routines
; *************************
; 
;  *  NewMovieTrack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewMovieTrack" 
   ((theMovie (:Handle :MovieType))
    (width :signed-long)
    (height :signed-long)
    (trackVolume :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :TrackType)
() )
; 
;  *  DisposeMovieTrack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeMovieTrack" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ************************
; * Track State routines
; *************************
; 
;  *  GetTrackCreationTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackCreationTime" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetTrackModificationTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackModificationTime" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetTrackEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackEnabled" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SetTrackEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackEnabled" 
   ((theTrack (:Handle :TrackType))
    (isEnabled :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTrackUsage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackUsage" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetTrackUsage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackUsage" 
   ((theTrack (:Handle :TrackType))
    (usage :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTrackDuration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackDuration" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GetTrackOffset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackOffset" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SetTrackOffset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackOffset" 
   ((theTrack (:Handle :TrackType))
    (movieOffsetTime :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTrackLayer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackLayer" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetTrackLayer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackLayer" 
   ((theTrack (:Handle :TrackType))
    (layer :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTrackAlternate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackAlternate" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :TrackType)
() )
; 
;  *  SetTrackAlternate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackAlternate" 
   ((theTrack (:Handle :TrackType))
    (alternateT (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetAutoTrackAlternatesEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetAutoTrackAlternatesEnabled" 
   ((theMovie (:Handle :MovieType))
    (enable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SelectMovieAlternates()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SelectMovieAlternates" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTrackVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackVolume" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetTrackVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackVolume" 
   ((theTrack (:Handle :TrackType))
    (volume :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTrackMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackMatrix" 
   ((theTrack (:Handle :TrackType))
    (matrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetTrackMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackMatrix" 
   ((theTrack (:Handle :TrackType))
    (matrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTrackDimensions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackDimensions" 
   ((theTrack (:Handle :TrackType))
    (width (:pointer :Fixed))
    (height (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetTrackDimensions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackDimensions" 
   ((theTrack (:Handle :TrackType))
    (width :signed-long)
    (height :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTrackUserData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackUserData" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :UserDataRecord)
() )
; 
;  *  GetTrackDisplayMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackDisplayMatrix" 
   ((theTrack (:Handle :TrackType))
    (matrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetTrackSoundLocalizationSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackSoundLocalizationSettings" 
   ((theTrack (:Handle :TrackType))
    (settings (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetTrackSoundLocalizationSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackSoundLocalizationSettings" 
   ((theTrack (:Handle :TrackType))
    (settings :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ************************
; * get Media routines
; *************************
; 
;  *  NewTrackMedia()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewTrackMedia" 
   ((theTrack (:Handle :TrackType))
    (mediaType :OSType)
    (timeScale :signed-long)
    (dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MediaType)
() )
; 
;  *  DisposeTrackMedia()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeTrackMedia" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTrackMedia()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackMedia" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MediaType)
() )
; 
;  *  GetMediaTrack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaTrack" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :TrackType)
() )
; ************************
; * Media State routines
; *************************
; 
;  *  GetMediaCreationTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaCreationTime" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetMediaModificationTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaModificationTime" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetMediaTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaTimeScale" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SetMediaTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaTimeScale" 
   ((theMedia (:Handle :MediaType))
    (timeScale :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMediaDuration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaDuration" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GetMediaLanguage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaLanguage" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetMediaLanguage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaLanguage" 
   ((theMedia (:Handle :MediaType))
    (language :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMediaQuality()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaQuality" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetMediaQuality()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaQuality" 
   ((theMedia (:Handle :MediaType))
    (quality :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMediaHandlerDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaHandlerDescription" 
   ((theMedia (:Handle :MediaType))
    (mediaType (:pointer :OSType))
    (creatorName (:pointer :STR255))
    (creatorManufacturer (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMediaUserData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaUserData" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :UserDataRecord)
() )
; 
;  *  GetMediaInputMap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaInputMap" 
   ((theMedia (:Handle :MediaType))
    (inputMap (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMediaInputMap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaInputMap" 
   ((theMedia (:Handle :MediaType))
    (inputMap :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ************************
; * Media Handler routines
; *************************
; 
;  *  GetMediaHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaHandler" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentInstanceRecord)
() )
; 
;  *  SetMediaHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaHandler" 
   ((theMedia (:Handle :MediaType))
    (mH (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ************************
; * Media's Data routines
; *************************
; 
;  *  BeginMediaEdits()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_BeginMediaEdits" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  EndMediaEdits()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_EndMediaEdits" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMediaDefaultDataRefIndex()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaDefaultDataRefIndex" 
   ((theMedia (:Handle :MediaType))
    (index :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMediaDataHandlerDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaDataHandlerDescription" 
   ((theMedia (:Handle :MediaType))
    (index :SInt16)
    (dhType (:pointer :OSType))
    (creatorName (:pointer :STR255))
    (creatorManufacturer (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMediaDataHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaDataHandler" 
   ((theMedia (:Handle :MediaType))
    (index :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentInstanceRecord)
() )
; 
;  *  SetMediaDataHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaDataHandler" 
   ((theMedia (:Handle :MediaType))
    (index :SInt16)
    (dataHandler (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDataHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetDataHandler" 
   ((dataRef :Handle)
    (dataHandlerSubType :OSType)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentRecord)
() )
; 
;  *  OpenADataHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_OpenADataHandler" 
   ((dataRef :Handle)
    (dataHandlerSubType :OSType)
    (anchorDataRef :Handle)
    (anchorDataRefType :OSType)
    (tb (:pointer :TimeBaseRecord))
    (flags :signed-long)
    (dh (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ************************
; * Media Sample Table Routines
; *************************
; 
;  *  GetMediaSampleDescriptionCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaSampleDescriptionCount" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetMediaSampleDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaSampleDescription" 
   ((theMedia (:Handle :MediaType))
    (index :signed-long)
    (descH (:Handle :SampleDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMediaSampleDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaSampleDescription" 
   ((theMedia (:Handle :MediaType))
    (index :signed-long)
    (descH (:Handle :SampleDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMediaSampleCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaSampleCount" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetMediaSyncSampleCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaSyncSampleCount" 
   ((theMedia (:Handle :MediaType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SampleNumToMediaTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SampleNumToMediaTime" 
   ((theMedia (:Handle :MediaType))
    (logicalSampleNum :signed-long)
    (sampleTime (:pointer :TIMEVALUE))
    (sampleDuration (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MediaTimeToSampleNum()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaTimeToSampleNum" 
   ((theMedia (:Handle :MediaType))
    (time :signed-long)
    (sampleNum (:pointer :long))
    (sampleTime (:pointer :TIMEVALUE))
    (sampleDuration (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AddMediaSample()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddMediaSample" 
   ((theMedia (:Handle :MediaType))
    (dataIn :Handle)
    (inOffset :signed-long)
    (size :UInt32)
    (durationPerSample :signed-long)
    (sampleDescriptionH (:Handle :SampleDescription))
    (numberOfSamples :signed-long)
    (sampleFlags :SInt16)
    (sampleTime (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AddMediaSampleReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddMediaSampleReference" 
   ((theMedia (:Handle :MediaType))
    (dataOffset :signed-long)
    (size :UInt32)
    (durationPerSample :signed-long)
    (sampleDescriptionH (:Handle :SampleDescription))
    (numberOfSamples :signed-long)
    (sampleFlags :SInt16)
    (sampleTime (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AddMediaSampleReferences()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddMediaSampleReferences" 
   ((theMedia (:Handle :MediaType))
    (sampleDescriptionH (:Handle :SampleDescription))
    (numberOfSamples :signed-long)
    (sampleRefs (:pointer :SampleReferenceRecord))
    (sampleTime (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AddMediaSampleReferences64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_AddMediaSampleReferences64" 
   ((theMedia (:Handle :MediaType))
    (sampleDescriptionH (:Handle :SampleDescription))
    (numberOfSamples :signed-long)
    (sampleRefs (:pointer :SampleReference64Record))
    (sampleTime (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMediaSample()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaSample" 
   ((theMedia (:Handle :MediaType))
    (dataOut :Handle)
    (maxSizeToGrow :signed-long)
    (size (:pointer :long))
    (time :signed-long)
    (sampleTime (:pointer :TIMEVALUE))
    (durationPerSample (:pointer :TIMEVALUE))
    (sampleDescriptionH (:Handle :SampleDescription))
    (sampleDescriptionIndex (:pointer :long))
    (maxNumberOfSample :signed-long)
    (numberOfSamples (:pointer :long))
    (sampleFlags (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMediaSampleReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaSampleReference" 
   ((theMedia (:Handle :MediaType))
    (dataOffset (:pointer :long))
    (size (:pointer :long))
    (time :signed-long)
    (sampleTime (:pointer :TIMEVALUE))
    (durationPerSample (:pointer :TIMEVALUE))
    (sampleDescriptionH (:Handle :SampleDescription))
    (sampleDescriptionIndex (:pointer :long))
    (maxNumberOfSamples :signed-long)
    (numberOfSamples (:pointer :long))
    (sampleFlags (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMediaSampleReferences()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaSampleReferences" 
   ((theMedia (:Handle :MediaType))
    (time :signed-long)
    (sampleTime (:pointer :TIMEVALUE))
    (sampleDescriptionH (:Handle :SampleDescription))
    (sampleDescriptionIndex (:pointer :long))
    (maxNumberOfEntries :signed-long)
    (actualNumberofEntries (:pointer :long))
    (sampleRefs (:pointer :SampleReferenceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMediaSampleReferences64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GetMediaSampleReferences64" 
   ((theMedia (:Handle :MediaType))
    (time :signed-long)
    (sampleTime (:pointer :TIMEVALUE))
    (sampleDescriptionH (:Handle :SampleDescription))
    (sampleDescriptionIndex (:pointer :long))
    (maxNumberOfEntries :signed-long)
    (actualNumberofEntries (:pointer :long))
    (sampleRefs (:pointer :SampleReference64Record))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMediaPreferredChunkSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaPreferredChunkSize" 
   ((theMedia (:Handle :MediaType))
    (maxChunkSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMediaPreferredChunkSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaPreferredChunkSize" 
   ((theMedia (:Handle :MediaType))
    (maxChunkSize (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMediaShadowSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaShadowSync" 
   ((theMedia (:Handle :MediaType))
    (frameDiffSampleNum :signed-long)
    (syncSampleNum :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMediaShadowSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaShadowSync" 
   ((theMedia (:Handle :MediaType))
    (frameDiffSampleNum :signed-long)
    (syncSampleNum (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ************************
; * Editing Routines
; *************************
; 
;  *  InsertMediaIntoTrack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_InsertMediaIntoTrack" 
   ((theTrack (:Handle :TrackType))
    (trackStart :signed-long)
    (mediaTime :signed-long)
    (mediaDuration :signed-long)
    (mediaRate :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InsertTrackSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_InsertTrackSegment" 
   ((srcTrack (:Handle :TrackType))
    (dstTrack (:Handle :TrackType))
    (srcIn :signed-long)
    (srcDuration :signed-long)
    (dstIn :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InsertMovieSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_InsertMovieSegment" 
   ((srcMovie (:Handle :MovieType))
    (dstMovie (:Handle :MovieType))
    (srcIn :signed-long)
    (srcDuration :signed-long)
    (dstIn :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InsertEmptyTrackSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_InsertEmptyTrackSegment" 
   ((dstTrack (:Handle :TrackType))
    (dstIn :signed-long)
    (dstDuration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InsertEmptyMovieSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_InsertEmptyMovieSegment" 
   ((dstMovie (:Handle :MovieType))
    (dstIn :signed-long)
    (dstDuration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DeleteTrackSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DeleteTrackSegment" 
   ((theTrack (:Handle :TrackType))
    (startTime :signed-long)
    (duration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DeleteMovieSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DeleteMovieSegment" 
   ((theMovie (:Handle :MovieType))
    (startTime :signed-long)
    (duration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ScaleTrackSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ScaleTrackSegment" 
   ((theTrack (:Handle :TrackType))
    (startTime :signed-long)
    (oldDuration :signed-long)
    (newDuration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ScaleMovieSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ScaleMovieSegment" 
   ((theMovie (:Handle :MovieType))
    (startTime :signed-long)
    (oldDuration :signed-long)
    (newDuration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ************************
; * Hi-level Editing Routines
; *************************
; 
;  *  CutMovieSelection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CutMovieSelection" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MovieType)
() )
; 
;  *  CopyMovieSelection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CopyMovieSelection" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MovieType)
() )
; 
;  *  PasteMovieSelection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PasteMovieSelection" 
   ((theMovie (:Handle :MovieType))
    (src (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AddMovieSelection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddMovieSelection" 
   ((theMovie (:Handle :MovieType))
    (src (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ClearMovieSelection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ClearMovieSelection" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PasteHandleIntoMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PasteHandleIntoMovie" 
   ((h :Handle)
    (handleType :OSType)
    (theMovie (:Handle :MovieType))
    (flags :signed-long)
    (userComp (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PutMovieIntoTypedHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PutMovieIntoTypedHandle" 
   ((theMovie (:Handle :MovieType))
    (targetTrack (:Handle :TrackType))
    (handleType :OSType)
    (publicMovie :Handle)
    (start :signed-long)
    (dur :signed-long)
    (flags :signed-long)
    (userComp (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  IsScrapMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_IsScrapMovie" 
   ((targetTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentRecord)
() )
; ************************
; * Middle-level Editing Routines
; *************************
; 
;  *  CopyTrackSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CopyTrackSettings" 
   ((srcTrack (:Handle :TrackType))
    (dstTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CopyMovieSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CopyMovieSettings" 
   ((srcMovie (:Handle :MovieType))
    (dstMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AddEmptyTrackToMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddEmptyTrackToMovie" 
   ((srcTrack (:Handle :TrackType))
    (dstMovie (:Handle :MovieType))
    (dataRef :Handle)
    (dataRefType :OSType)
    (dstTrack (:pointer :TRACK))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

(defconstant $kQTCloneShareSamples 1)
(defconstant $kQTCloneDontCopyEdits 2)
; 
;  *  AddClonedTrackToMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_AddClonedTrackToMovie" 
   ((srcTrack (:Handle :TrackType))
    (dstMovie (:Handle :MovieType))
    (flags :signed-long)
    (dstTrack (:pointer :TRACK))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ************************
; * movie & track edit state routines
; *************************
; 
;  *  NewMovieEditState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewMovieEditState" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MovieStateRecord)
() )
; 
;  *  UseMovieEditState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_UseMovieEditState" 
   ((theMovie (:Handle :MovieType))
    (toState (:Handle :MovieStateRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DisposeMovieEditState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeMovieEditState" 
   ((state (:Handle :MovieStateRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewTrackEditState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewTrackEditState" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :TrackStateRecord)
() )
; 
;  *  UseTrackEditState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_UseTrackEditState" 
   ((theTrack (:Handle :TrackType))
    (state (:Handle :TrackStateRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DisposeTrackEditState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeTrackEditState" 
   ((state (:Handle :TrackStateRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ************************
; * track reference routines
; *************************
; 
;  *  AddTrackReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddTrackReference" 
   ((theTrack (:Handle :TrackType))
    (refTrack (:Handle :TrackType))
    (refType :OSType)
    (addedIndex (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DeleteTrackReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DeleteTrackReference" 
   ((theTrack (:Handle :TrackType))
    (refType :OSType)
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetTrackReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackReference" 
   ((theTrack (:Handle :TrackType))
    (refTrack (:Handle :TrackType))
    (refType :OSType)
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetTrackReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackReference" 
   ((theTrack (:Handle :TrackType))
    (refType :OSType)
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :TrackType)
() )
; 
;  *  GetNextTrackReferenceType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetNextTrackReferenceType" 
   ((theTrack (:Handle :TrackType))
    (refType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSType
() )
; 
;  *  GetTrackReferenceCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackReferenceCount" 
   ((theTrack (:Handle :TrackType))
    (refType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; ************************
; * high level file conversion routines
; *************************
; 
;  *  ConvertFileToMovieFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ConvertFileToMovieFile" 
   ((inputFile (:pointer :FSSpec))
    (outputFile (:pointer :FSSpec))
    (creator :OSType)
    (scriptTag :SInt16)
    (resID (:pointer :short))
    (flags :signed-long)
    (userComp (:pointer :ComponentInstanceRecord))
    (proc (:pointer :OpaqueMovieProgressProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ConvertMovieToFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ConvertMovieToFile" 
   ((theMovie (:Handle :MovieType))
    (onlyTrack (:Handle :TrackType))
    (outputFile (:pointer :FSSpec))
    (fileType :OSType)
    (creator :OSType)
    (scriptTag :SInt16)
    (resID (:pointer :short))
    (flags :signed-long)
    (userComp (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ConvertMovieToDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_ConvertMovieToDataRef" 
   ((m (:Handle :MovieType))
    (onlyTrack (:Handle :TrackType))
    (dataRef :Handle)
    (dataRefType :OSType)
    (fileType :OSType)
    (creator :OSType)
    (flags :signed-long)
    (userComp (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  ConvertDataRefToMovieDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_ConvertDataRefToMovieDataRef" 
   ((inputDataRef :Handle)
    (inputDataRefType :OSType)
    (outputDataRef :Handle)
    (outputDataRefType :OSType)
    (creator :OSType)
    (flags :signed-long)
    (userComp (:pointer :ComponentInstanceRecord))
    (proc (:pointer :OpaqueMovieProgressProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )

(defconstant $kGetMovieImporterValidateToFind 1)
(defconstant $kGetMovieImporterAllowNewFile 2)
(defconstant $kGetMovieImporterDontConsiderGraphicsImporters 4)
(defconstant $kGetMovieImporterDontConsiderFileOnlyImporters 64);  reject aggressive movie importers which have dontAutoFileMovieImport set

(defconstant $kGetMovieImporterAutoImportOnly #x400)
; 
;  *  GetMovieImporterForDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieImporterForDataRef" 
   ((dataRefType :OSType)
    (dataRef :Handle)
    (flags :signed-long)
    (importer (:pointer :Component))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

(defconstant $kQTGetMIMETypeInfoIsQuickTimeMovieType :|moov|);  info is a pointer to a Boolean

(defconstant $kQTGetMIMETypeInfoIsUnhelpfulType :|dumb|);  info is a pointer to a Boolean

; 
;  *  QTGetMIMETypeInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_QTGetMIMETypeInfo" 
   ((mimeStringStart (:pointer :char))
    (mimeStringLength :SInt16)
    (infoSelector :OSType)
    (infoDataPtr :pointer)
    (infoDataSize (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ************************
; * Movie Timebase Conversion Routines
; *************************
; 
;  *  TrackTimeToMediaTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TrackTimeToMediaTime" 
   ((value :signed-long)
    (theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GetTrackEditRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackEditRate" 
   ((theTrack (:Handle :TrackType))
    (atTime :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; ************************
; * Miscellaneous Routines
; *************************
; 
;  *  GetMovieDataSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieDataSize" 
   ((theMovie (:Handle :MovieType))
    (startTime :signed-long)
    (duration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetMovieDataSize64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GetMovieDataSize64" 
   ((theMovie (:Handle :MovieType))
    (startTime :signed-long)
    (duration :signed-long)
    (dataSize (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetTrackDataSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackDataSize" 
   ((theTrack (:Handle :TrackType))
    (startTime :signed-long)
    (duration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetTrackDataSize64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GetTrackDataSize64" 
   ((theTrack (:Handle :TrackType))
    (startTime :signed-long)
    (duration :signed-long)
    (dataSize (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMediaDataSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaDataSize" 
   ((theMedia (:Handle :MediaType))
    (startTime :signed-long)
    (duration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetMediaDataSize64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GetMediaDataSize64" 
   ((theMedia (:Handle :MediaType))
    (startTime :signed-long)
    (duration :signed-long)
    (dataSize (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PtInMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PtInMovie" 
   ((theMovie (:Handle :MovieType))
    (pt :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  PtInTrack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PtInTrack" 
   ((theTrack (:Handle :TrackType))
    (pt :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; ************************
; * Group Selection Routines
; *************************
; 
;  *  SetMovieLanguage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieLanguage" 
   ((theMovie (:Handle :MovieType))
    (language :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ************************
; * User Data
; *************************
; 
;  *  GetUserData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetUserData" 
   ((theUserData (:Handle :UserDataRecord))
    (data :Handle)
    (udType :OSType)
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AddUserData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddUserData" 
   ((theUserData (:Handle :UserDataRecord))
    (data :Handle)
    (udType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveUserData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_RemoveUserData" 
   ((theUserData (:Handle :UserDataRecord))
    (udType :OSType)
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CountUserDataType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CountUserDataType" 
   ((theUserData (:Handle :UserDataRecord))
    (udType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetNextUserDataType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetNextUserDataType" 
   ((theUserData (:Handle :UserDataRecord))
    (udType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetUserDataItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetUserDataItem" 
   ((theUserData (:Handle :UserDataRecord))
    (data :pointer)
    (size :signed-long)
    (udType :OSType)
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetUserDataItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetUserDataItem" 
   ((theUserData (:Handle :UserDataRecord))
    (data :pointer)
    (size :signed-long)
    (udType :OSType)
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AddUserDataText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddUserDataText" 
   ((theUserData (:Handle :UserDataRecord))
    (data :Handle)
    (udType :OSType)
    (index :signed-long)
    (itlRegionTag :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetUserDataText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetUserDataText" 
   ((theUserData (:Handle :UserDataRecord))
    (data :Handle)
    (udType :OSType)
    (index :signed-long)
    (itlRegionTag :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveUserDataText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_RemoveUserDataText" 
   ((theUserData (:Handle :UserDataRecord))
    (udType :OSType)
    (index :signed-long)
    (itlRegionTag :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewUserData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewUserData" 
   ((theUserData (:pointer :USERDATA))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DisposeUserData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeUserData" 
   ((theUserData (:Handle :UserDataRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewUserDataFromHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewUserDataFromHandle" 
   ((h :Handle)
    (theUserData (:pointer :USERDATA))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PutUserDataIntoHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PutUserDataIntoHandle" 
   ((theUserData (:Handle :UserDataRecord))
    (h :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

(defconstant $kQTCopyUserDataReplace :|rplc|)   ;  Delete all destination user data items and then add source user data items 

(defconstant $kQTCopyUserDataMerge :|merg|)     ;  Add source user data items to destination user data 

; 
;  *  CopyMovieUserData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_CopyMovieUserData" 
   ((srcMovie (:Handle :MovieType))
    (dstMovie (:Handle :MovieType))
    (copyRule :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  CopyTrackUserData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_CopyTrackUserData" 
   ((srcTrack (:Handle :TrackType))
    (dstTrack (:Handle :TrackType))
    (copyRule :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  CopyMediaUserData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_CopyMediaUserData" 
   ((srcMedia (:Handle :MediaType))
    (dstMedia (:Handle :MediaType))
    (copyRule :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  CopyUserData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_CopyUserData" 
   ((srcUserData (:Handle :UserDataRecord))
    (dstUserData (:Handle :UserDataRecord))
    (copyRule :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  SetMoviePropertyAtom()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_SetMoviePropertyAtom" 
   ((theMovie (:Handle :MovieType))
    (propertyAtom :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMoviePropertyAtom()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_GetMoviePropertyAtom" 
   ((theMovie (:Handle :MovieType))
    (propertyAtom (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMediaNextInterestingTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaNextInterestingTime" 
   ((theMedia (:Handle :MediaType))
    (interestingTimeFlags :SInt16)
    (time :signed-long)
    (rate :signed-long)
    (interestingTime (:pointer :TIMEVALUE))
    (interestingDuration (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTrackNextInterestingTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackNextInterestingTime" 
   ((theTrack (:Handle :TrackType))
    (interestingTimeFlags :SInt16)
    (time :signed-long)
    (rate :signed-long)
    (interestingTime (:pointer :TIMEVALUE))
    (interestingDuration (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMovieNextInterestingTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieNextInterestingTime" 
   ((theMovie (:Handle :MovieType))
    (interestingTimeFlags :SInt16)
    (numMediaTypes :SInt16)
    (whichMediaTypes (:pointer :OSType))
    (time :signed-long)
    (rate :signed-long)
    (interestingTime (:pointer :TIMEVALUE))
    (interestingDuration (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CreateMovieFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CreateMovieFile" 
   ((fileSpec (:pointer :FSSpec))
    (creator :OSType)
    (scriptTag :SInt16)
    (createMovieFileFlags :signed-long)
    (resRefNum (:pointer :short))
    (newmovie (:pointer :Movie))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  OpenMovieFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_OpenMovieFile" 
   ((fileSpec (:pointer :FSSpec))
    (resRefNum (:pointer :short))
    (permission :SInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CloseMovieFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CloseMovieFile" 
   ((resRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DeleteMovieFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DeleteMovieFile" 
   ((fileSpec (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewMovieFromFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewMovieFromFile" 
   ((theMovie (:pointer :Movie))
    (resRefNum :SInt16)
    (resId (:pointer :short))                   ;  can be NULL 
    (resName (:pointer :UInt8))
    (newMovieFlags :SInt16)
    (dataRefWasChanged (:pointer :Boolean))     ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewMovieFromHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewMovieFromHandle" 
   ((theMovie (:pointer :Movie))
    (h :Handle)
    (newMovieFlags :SInt16)
    (dataRefWasChanged (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewMovieFromDataFork()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewMovieFromDataFork" 
   ((theMovie (:pointer :Movie))
    (fRefNum :SInt16)
    (fileOffset :signed-long)
    (newMovieFlags :SInt16)
    (dataRefWasChanged (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewMovieFromDataFork64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_NewMovieFromDataFork64" 
   ((theMovie (:pointer :Movie))
    (fRefNum :signed-long)
    (fileOffset (:pointer :wide))
    (newMovieFlags :SInt16)
    (dataRefWasChanged (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewMovieFromUserProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewMovieFromUserProc" 
   ((m (:pointer :Movie))
    (flags :SInt16)
    (dataRefWasChanged (:pointer :Boolean))
    (getProc (:pointer :OpaqueGetMovieProcPtr))
    (refCon :pointer)
    (defaultDataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewMovieFromDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewMovieFromDataRef" 
   ((m (:pointer :Movie))
    (flags :SInt16)
    (id (:pointer :short))
    (dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewMovieFromStorageOffset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_NewMovieFromStorageOffset" 
   ((theMovie (:pointer :Movie))
    (dh (:pointer :ComponentInstanceRecord))
    (fileOffset (:pointer :wide))
    (newMovieFlags :SInt16)
    (dataRefWasChanged (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  NewMovieForDataRefFromHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_NewMovieForDataRefFromHandle" 
   ((theMovie (:pointer :Movie))
    (h :Handle)
    (newMovieFlags :SInt16)
    (dataRefWasChanged (:pointer :Boolean))
    (dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  AddMovieResource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddMovieResource" 
   ((theMovie (:Handle :MovieType))
    (resRefNum :SInt16)
    (resId (:pointer :short))
    (resName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  UpdateMovieResource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_UpdateMovieResource" 
   ((theMovie (:Handle :MovieType))
    (resRefNum :SInt16)
    (resId :SInt16)
    (resName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveMovieResource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_RemoveMovieResource" 
   ((resRefNum :SInt16)
    (resId :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CreateMovieStorage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_CreateMovieStorage" 
   ((dataRef :Handle)
    (dataRefType :OSType)
    (creator :OSType)
    (scriptTag :SInt16)
    (createMovieFileFlags :signed-long)
    (outDataHandler (:pointer :DATAHANDLER))
    (newmovie (:pointer :Movie))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  OpenMovieStorage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_OpenMovieStorage" 
   ((dataRef :Handle)
    (dataRefType :OSType)
    (flags :signed-long)
    (outDataHandler (:pointer :DATAHANDLER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  CloseMovieStorage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_CloseMovieStorage" 
   ((dh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  DeleteMovieStorage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_DeleteMovieStorage" 
   ((dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  AddMovieToStorage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_AddMovieToStorage" 
   ((theMovie (:Handle :MovieType))
    (dh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  UpdateMovieInStorage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_UpdateMovieInStorage" 
   ((theMovie (:Handle :MovieType))
    (dh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  HasMovieChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_HasMovieChanged" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  ClearMovieChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ClearMovieChanged" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMovieDefaultDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieDefaultDataRef" 
   ((theMovie (:Handle :MovieType))
    (dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMovieDefaultDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieDefaultDataRef" 
   ((theMovie (:Handle :MovieType))
    (dataRef (:pointer :Handle))
    (dataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMovieAnchorDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_SetMovieAnchorDataRef" 
   ((theMovie (:Handle :MovieType))
    (dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMovieAnchorDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_GetMovieAnchorDataRef" 
   ((theMovie (:Handle :MovieType))
    (dataRef (:pointer :Handle))
    (dataRefType (:pointer :OSType))
    (outFlags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMovieColorTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieColorTable" 
   ((theMovie (:Handle :MovieType))
    (ctab (:Handle :ColorTable))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMovieColorTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieColorTable" 
   ((theMovie (:Handle :MovieType))
    (ctab (:pointer :CTABHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FlattenMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_FlattenMovie" 
   ((theMovie (:Handle :MovieType))
    (movieFlattenFlags :signed-long)
    (theFile (:pointer :FSSpec))
    (creator :OSType)
    (scriptTag :SInt16)
    (createMovieFileFlags :signed-long)
    (resId (:pointer :short))
    (resName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FlattenMovieData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_FlattenMovieData" 
   ((theMovie (:Handle :MovieType))
    (movieFlattenFlags :signed-long)
    (theFile (:pointer :FSSpec))
    (creator :OSType)
    (scriptTag :SInt16)
    (createMovieFileFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MovieType)
() )
; 
;  *  FlattenMovieDataToDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_FlattenMovieDataToDataRef" 
   ((theMovie (:Handle :MovieType))
    (movieFlattenFlags :signed-long)
    (dataRef :Handle)
    (dataRefType :OSType)
    (creator :OSType)
    (scriptTag :SInt16)
    (createMovieFileFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:Handle :MovieType)
() )
; 
;  *  SetMovieProgressProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieProgressProc" 
   ((theMovie (:Handle :MovieType))
    (p (:pointer :OpaqueMovieProgressProcPtr))
    (refcon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMovieProgressProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_GetMovieProgressProc" 
   ((theMovie (:Handle :MovieType))
    (p (:pointer :MOVIEPROGRESSUPP))
    (refcon (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CreateShortcutMovieFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_CreateShortcutMovieFile" 
   ((fileSpec (:pointer :FSSpec))
    (creator :OSType)
    (scriptTag :SInt16)
    (createMovieFileFlags :signed-long)
    (targetDataRef :Handle)
    (targetDataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  MovieSearchText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieSearchText" 
   ((theMovie (:Handle :MovieType))
    (text :pointer)
    (size :signed-long)
    (searchFlags :signed-long)
    (searchTrack (:pointer :TRACK))
    (searchTime (:pointer :TIMEVALUE))
    (searchOffset (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetPosterBox()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetPosterBox" 
   ((theMovie (:Handle :MovieType))
    (boxRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPosterBox()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetPosterBox" 
   ((theMovie (:Handle :MovieType))
    (boxRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMovieSegmentDisplayBoundsRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieSegmentDisplayBoundsRgn" 
   ((theMovie (:Handle :MovieType))
    (time :signed-long)
    (duration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; 
;  *  GetTrackSegmentDisplayBoundsRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackSegmentDisplayBoundsRgn" 
   ((theTrack (:Handle :TrackType))
    (time :signed-long)
    (duration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; 
;  *  SetMovieCoverProcs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMovieCoverProcs" 
   ((theMovie (:Handle :MovieType))
    (uncoverProc (:pointer :OpaqueMovieRgnCoverProcPtr))
    (coverProc (:pointer :OpaqueMovieRgnCoverProcPtr))
    (refcon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMovieCoverProcs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieCoverProcs" 
   ((theMovie (:Handle :MovieType))
    (uncoverProc (:pointer :MOVIERGNCOVERUPP))
    (coverProc (:pointer :MOVIERGNCOVERUPP))
    (refcon (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetTrackStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackStatus" 
   ((theTrack (:Handle :TrackType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GetMovieStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMovieStatus" 
   ((theMovie (:Handle :MovieType))
    (firstProblemTrack (:pointer :TRACK))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(defconstant $kMovieLoadStateError -1)
(defconstant $kMovieLoadStateLoading #x3E8)
(defconstant $kMovieLoadStateLoaded #x7D0)
(defconstant $kMovieLoadStatePlayable #x2710)
(defconstant $kMovieLoadStatePlaythroughOK #x4E20)
(defconstant $kMovieLoadStateComplete #x186A0)
; 
;  *  GetMovieLoadState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_GetMovieLoadState" 
   ((theMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; ***
;     Thread related Movie routines
; ***
; 
;  *  AttachMovieToCurrentThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_AttachMovieToCurrentThread" 
   ((m (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  DetachMovieFromCurrentThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_DetachMovieFromCurrentThread" 
   ((m (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  GetMovieThreadAttachState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_GetMovieThreadAttachState" 
   ((m (:Handle :MovieType))
    (outAttachedToCurrentThread (:pointer :Boolean))
    (outAttachedToAnyThread (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; ***
;     CanQuickTimeOpenFile, etc.
; ***
;  Input flags for CanQuickTimeOpenFile/DataRef 

(defconstant $kQTDontUseDataToFindImporter 1)
(defconstant $kQTDontLookForMovieImporterIfGraphicsImporterFound 2)
(defconstant $kQTAllowOpeningStillImagesAsMovies 4)
(defconstant $kQTAllowImportersThatWouldCreateNewFile 8);  eg, TEXT and PICT movie importers

(defconstant $kQTAllowAggressiveImporters 16)
;  Determines whether the file could be opened using a graphics importer or opened in place as a movie. 
; 
;  *  CanQuickTimeOpenFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_CanQuickTimeOpenFile" 
   ((fileSpec (:pointer :FSSpec))
    (fileType :OSType)
    (fileNameExtension :OSType)
    (outCanOpenWithGraphicsImporter (:pointer :Boolean))
    (outCanOpenAsMovie (:pointer :Boolean))
    (outPreferGraphicsImporter (:pointer :Boolean))
    (inFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Determines whether the file could be opened using a graphics importer or opened in place as a movie. 
; 
;  *  CanQuickTimeOpenDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_CanQuickTimeOpenDataRef" 
   ((dataRef :Handle)
    (dataRefType :OSType)
    (outCanOpenWithGraphicsImporter (:pointer :Boolean))
    (outCanOpenAsMovie (:pointer :Boolean))
    (outPreferGraphicsImporter (:pointer :Boolean))
    (inFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ***
;     Data Reference Utilities
; ***

(defconstant $kQTNativeDefaultPathStyle -1)
(defconstant $kQTPOSIXPathStyle 0)
(defconstant $kQTHFSPathStyle 1)
(defconstant $kQTWindowsPathStyle 2)

(def-mactype :QTPathStyle (find-mactype ':UInt32))
; 
;  *  QTNewDataReferenceFromFSRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTNewDataReferenceFromFSRef" 
   ((fileRef (:pointer :FSRef))
    (flags :UInt32)
    (outDataRef (:pointer :Handle))
    (outDataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTNewDataReferenceFromFSRefCFString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTNewDataReferenceFromFSRefCFString" 
   ((directoryRef (:pointer :FSRef))
    (fileName (:pointer :__CFString))
    (flags :UInt32)
    (outDataRef (:pointer :Handle))
    (outDataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTNewDataReferenceFromFSSpec()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTNewDataReferenceFromFSSpec" 
   ((fsspec (:pointer :FSSpec))
    (flags :UInt32)
    (outDataRef (:pointer :Handle))
    (outDataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTNewDataReferenceWithDirectoryCFString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTNewDataReferenceWithDirectoryCFString" 
   ((inDataRef :Handle)
    (inDataRefType :OSType)
    (targetName (:pointer :__CFString))
    (flags :UInt32)
    (outDataRef (:pointer :Handle))
    (outDataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTNewDataReferenceFromFullPathCFString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTNewDataReferenceFromFullPathCFString" 
   ((filePath (:pointer :__CFString))
    (pathStyle :UInt32)
    (flags :UInt32)
    (outDataRef (:pointer :Handle))
    (outDataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTNewDataReferenceFromCFURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTNewDataReferenceFromCFURL" 
   ((url (:pointer :__CFURL))
    (flags :UInt32)
    (outDataRef (:pointer :Handle))
    (outDataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTNewDataReferenceFromURLCFString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTNewDataReferenceFromURLCFString" 
   ((urlString (:pointer :__CFString))
    (flags :UInt32)
    (outDataRef (:pointer :Handle))
    (outDataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTGetDataReferenceDirectoryDataReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTGetDataReferenceDirectoryDataReference" 
   ((dataRef :Handle)
    (dataRefType :OSType)
    (flags :UInt32)
    (outDataRef (:pointer :Handle))
    (outDataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTGetDataReferenceTargetNameCFString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTGetDataReferenceTargetNameCFString" 
   ((dataRef :Handle)
    (dataRefType :OSType)
    (name (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTGetDataReferenceFullPathCFString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTGetDataReferenceFullPathCFString" 
   ((dataRef :Handle)
    (dataRefType :OSType)
    (style :UInt32)
    (outPath (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTGetDataHandlerDirectoryDataReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTGetDataHandlerDirectoryDataReference" 
   ((dh (:pointer :ComponentInstanceRecord))
    (flags :UInt32)
    (outDataRef (:pointer :Handle))
    (outDataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTGetDataHandlerTargetNameCFString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTGetDataHandlerTargetNameCFString" 
   ((dh (:pointer :ComponentInstanceRecord))
    (fileName (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTGetDataHandlerFullPathCFString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTGetDataHandlerFullPathCFString" 
   ((dh (:pointer :ComponentInstanceRecord))
    (style :UInt32)
    (outPath (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; ***
;     Movie Controller support routines
; ***
; 
;  *  NewMovieController()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewMovieController" 
   ((theMovie (:Handle :MovieType))
    (movieRect (:pointer :Rect))
    (someFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentInstanceRecord)
() )
; 
;  *  DisposeMovieController()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeMovieController" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ShowMovieInformation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ShowMovieInformation" 
   ((theMovie (:Handle :MovieType))
    (filterProc (:pointer :OpaqueModalFilterProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ****
;     Scrap routines
; ****
; 
;  *  PutMovieOnScrap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PutMovieOnScrap" 
   ((theMovie (:Handle :MovieType))
    (movieScrapFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewMovieFromScrap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewMovieFromScrap" 
   ((newMovieFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MovieType)
() )
; ****
;     DataRef routines
; ****
; 
;  *  GetMediaDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaDataRef" 
   ((theMedia (:Handle :MediaType))
    (index :SInt16)
    (dataRef (:pointer :Handle))
    (dataRefType (:pointer :OSType))
    (dataRefAttributes (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMediaDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaDataRef" 
   ((theMedia (:Handle :MediaType))
    (index :SInt16)
    (dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetMediaDataRefAttributes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaDataRefAttributes" 
   ((theMedia (:Handle :MediaType))
    (index :SInt16)
    (dataRefAttributes :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AddMediaDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddMediaDataRef" 
   ((theMedia (:Handle :MediaType))
    (index (:pointer :short))
    (dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMediaDataRefCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaDataRefCount" 
   ((theMedia (:Handle :MediaType))
    (count (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTNewAlias()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTNewAlias" 
   ((fss (:pointer :FSSpec))
    (alias (:pointer :ALIASHANDLE))
    (minimal :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ****
;     Playback hint routines
; ****
; 
;  *  SetMoviePlayHints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMoviePlayHints" 
   ((theMovie (:Handle :MovieType))
    (flags :signed-long)
    (flagsMask :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetMediaPlayHints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaPlayHints" 
   ((theMedia (:Handle :MediaType))
    (flags :signed-long)
    (flagsMask :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMediaPlayHints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaPlayHints" 
   ((theMedia (:Handle :MediaType))
    (flags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ****
;     Load time track hints
; ****

(defconstant $preloadAlways 1)
(defconstant $preloadOnlyIfEnabled 2)
; 
;  *  SetTrackLoadSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTrackLoadSettings" 
   ((theTrack (:Handle :TrackType))
    (preloadTime :signed-long)
    (preloadDuration :signed-long)
    (preloadFlags :signed-long)
    (defaultHints :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTrackLoadSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTrackLoadSettings" 
   ((theTrack (:Handle :TrackType))
    (preloadTime (:pointer :TIMEVALUE))
    (preloadDuration (:pointer :TIMEVALUE))
    (preloadFlags (:pointer :long))
    (defaultHints (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ****
;     Big screen TV
; ****

(defconstant $fullScreenHideCursor 1)
(defconstant $fullScreenAllowEvents 2)
(defconstant $fullScreenDontChangeMenuBar 4)
(defconstant $fullScreenPreflightSize 8)
(defconstant $fullScreenDontSwitchMonitorResolution 16)
(defconstant $fullScreenCaptureDisplay 32)      ;  capturedisplay is a mac os x specific parameter 
;  capturealldisplays is a mac os x specific parameter 

(defconstant $fullScreenCaptureAllDisplays 64)
; 
;  *  BeginFullScreen()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_BeginFullScreen" 
   ((restoreState (:pointer :Ptr))
    (whichGD (:Handle :GDEVICE))
    (desiredWidth (:pointer :short))
    (desiredHeight (:pointer :short))
    (newWindow (:pointer :WindowRef))
    (eraseColor (:pointer :RGBColor))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  EndFullScreen()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_EndFullScreen" 
   ((fullState :pointer)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ****
;     Wired Actions
; ****
;  flags for MovieExecuteWiredActions

(defconstant $movieExecuteWiredActionDontExecute 1)
; 
;  *  AddMovieExecuteWiredActionsProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_AddMovieExecuteWiredActionsProc" 
   ((theMovie (:Handle :MovieType))
    (proc (:pointer :OpaqueMovieExecuteWiredActionsProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveMovieExecuteWiredActionsProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_RemoveMovieExecuteWiredActionsProc" 
   ((theMovie (:Handle :MovieType))
    (proc (:pointer :OpaqueMovieExecuteWiredActionsProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  MovieExecuteWiredActions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MovieExecuteWiredActions" 
   ((theMovie (:Handle :MovieType))
    (flags :signed-long)
    (actions :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ****
;     Keyboard Navigation/Editable Text Field Support
; ****
; 
;    Navigation Direction Constants
;         for MediaNavigateTargetRefCon
; 

(defconstant $kRefConNavigationNext 0)
(defconstant $kRefConNavigationPrevious 1)
; 
;    Refcon Properties 
;         for MediaRefConGetProerty/MediaRefConSetProperty
; 

(defconstant $kRefConPropertyCanHaveFocus 1)    ;  Boolean 

(defconstant $kRefConPropertyHasFocus 2)        ;  Boolean 

;  media properties

(defconstant $kTrackFocusCanEditFlag :|kedt|)
(defconstant $kTrackDefaultFocusFlags :|kfoc|)
(defconstant $kTrackFocusDefaultRefcon :|kref|)
;  focus flags

(defconstant $kTrackFocusOn 1)
(defconstant $kTrackHandlesTabs 2)              ;  this is reserved for a future release

; ****
;     Flash track properties
; ****

(defconstant $kFlashTrackPropertyAcceptAllClicks :|clik|);  type of media property atom; data is a Boolean 

; ****
;     Sprite Toolbox
; ****

(defconstant $kBackgroundSpriteLayerNum #x7FFF)
;   Sprite Properties

(defconstant $kSpritePropertyMatrix 1)
(defconstant $kSpritePropertyImageDescription 2)
(defconstant $kSpritePropertyImageDataPtr 3)
(defconstant $kSpritePropertyVisible 4)
(defconstant $kSpritePropertyLayer 5)
(defconstant $kSpritePropertyGraphicsMode 6)
(defconstant $kSpritePropertyImageDataSize 7)
(defconstant $kSpritePropertyActionHandlingSpriteID 8)
(defconstant $kSpritePropertyCanBeHitTested 9)
(defconstant $kSpritePropertyImageIndex 100)
(defconstant $kSpriteTrackPropertyBackgroundColor 101)
(defconstant $kSpriteTrackPropertyOffscreenBitDepth 102)
(defconstant $kSpriteTrackPropertySampleFormat 103)
(defconstant $kSpriteTrackPropertyScaleSpritesToScaleWorld 104)
(defconstant $kSpriteTrackPropertyHasActions 105)
(defconstant $kSpriteTrackPropertyVisible 106)
(defconstant $kSpriteTrackPropertyQTIdleEventsFrequency 107)
(defconstant $kSpriteTrackPropertyAllSpritesHitTestingMode 108)
(defconstant $kSpriteTrackPropertyPreferredDepthInterpretationMode 109)
(defconstant $kSpriteImagePropertyRegistrationPoint #x3E8)
(defconstant $kSpriteImagePropertyGroupID #x3E9)
;  values for kSpriteTrackPropertyPreferredDepthInterpretationMode

(defconstant $kSpriteTrackPreferredDepthCompatibilityMode 0)
(defconstant $kSpriteTrackPreferredDepthModernMode 1)
;  values for kSpriteTrackPropertyAllSpritesHitTestingMode

(defconstant $kSpriteHitTestUseSpritesOwnPropertiesMode 0)
(defconstant $kSpriteHitTestTreatAllSpritesAsHitTestableMode 1)
(defconstant $kSpriteHitTestTreatAllSpritesAsNotHitTestableMode 2)
;  special value for kSpriteTrackPropertyQTIdleEventsFrequency (the default)

(defconstant $kNoQTIdleEvents -1)
;  GetSpriteProperties for accessing invalid SpriteWorldRegion

(defconstant $kGetSpriteWorldInvalidRegionAndLeaveIntact -1)
(defconstant $kGetSpriteWorldInvalidRegionAndThenSetEmpty -2)
;  flagsIn for SpriteWorldIdle

(defconstant $kOnlyDrawToSpriteWorld 1)
(defconstant $kSpriteWorldPreflight 2)
;  flagsOut for SpriteWorldIdle

(defconstant $kSpriteWorldDidDraw 1)
(defconstant $kSpriteWorldNeedsToDraw 2)
;  flags for sprite track sample format

(defconstant $kKeyFrameAndSingleOverride 2)
(defconstant $kKeyFrameAndAllOverrides 4)
;  sprite world flags

(defconstant $kScaleSpritesToScaleWorld 2)
(defconstant $kSpriteWorldHighQuality 4)
(defconstant $kSpriteWorldDontAutoInvalidate 8)
(defconstant $kSpriteWorldInvisible 16)
(defconstant $kSpriteWorldDirtyInsteadOfFlush 32)
; 
;  *  NewSpriteWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewSpriteWorld" 
   ((newSpriteWorld (:pointer :SPRITEWORLD))
    (destination (:pointer :OpaqueGrafPtr))
    (spriteLayer (:pointer :OpaqueGrafPtr))
    (backgroundColor (:pointer :RGBColor))
    (background (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DisposeSpriteWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeSpriteWorld" 
   ((theSpriteWorld (:pointer :SpriteWorldRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetSpriteWorldClip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetSpriteWorldClip" 
   ((theSpriteWorld (:pointer :SpriteWorldRecord))
    (clipRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetSpriteWorldMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetSpriteWorldMatrix" 
   ((theSpriteWorld (:pointer :SpriteWorldRecord))
    (matrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetSpriteWorldGraphicsMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetSpriteWorldGraphicsMode" 
   ((theSpriteWorld (:pointer :SpriteWorldRecord))
    (mode :signed-long)
    (opColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SpriteWorldIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteWorldIdle" 
   ((theSpriteWorld (:pointer :SpriteWorldRecord))
    (flagsIn :signed-long)
    (flagsOut (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvalidateSpriteWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_InvalidateSpriteWorld" 
   ((theSpriteWorld (:pointer :SpriteWorldRecord))
    (invalidArea (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SpriteWorldHitTest()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteWorldHitTest" 
   ((theSpriteWorld (:pointer :SpriteWorldRecord))
    (flags :signed-long)
    (loc :Point)
    (spriteHit (:pointer :SPRITE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SpriteHitTest()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteHitTest" 
   ((theSprite (:pointer :SpriteRecord))
    (flags :signed-long)
    (loc :Point)
    (wasHit (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DisposeAllSprites()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeAllSprites" 
   ((theSpriteWorld (:pointer :SpriteWorldRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetSpriteWorldFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetSpriteWorldFlags" 
   ((spriteWorld (:pointer :SpriteWorldRecord))
    (flags :signed-long)
    (flagsMask :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewSprite()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewSprite" 
   ((newSprite (:pointer :SPRITE))
    (itsSpriteWorld (:pointer :SpriteWorldRecord))
    (idh (:Handle :ImageDescription))
    (imageDataPtr :pointer)
    (matrix (:pointer :MatrixRecord))
    (visible :Boolean)
    (layer :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DisposeSprite()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeSprite" 
   ((theSprite (:pointer :SpriteRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvalidateSprite()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_InvalidateSprite" 
   ((theSprite (:pointer :SpriteRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetSpriteProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetSpriteProperty" 
   ((theSprite (:pointer :SpriteRecord))
    (propertyType :signed-long)
    (propertyValue :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetSpriteProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetSpriteProperty" 
   ((theSprite (:pointer :SpriteRecord))
    (propertyType :signed-long)
    (propertyValue :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ****
;     QT Atom Data Support
; ****

(defconstant $kParentAtomIsContainer 0)
;  create and dispose QTAtomContainer objects
; 
;  *  QTNewAtomContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTNewAtomContainer" 
   ((atomData (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTDisposeAtomContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTDisposeAtomContainer" 
   ((atomData :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  locating nested atoms within QTAtomContainer container
; 
;  *  QTGetNextChildType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTGetNextChildType" 
   ((container :Handle)
    (parentAtom :signed-long)
    (currentChildType :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTCountChildrenOfType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTCountChildrenOfType" 
   ((container :Handle)
    (parentAtom :signed-long)
    (childType :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  QTFindChildByIndex()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTFindChildByIndex" 
   ((container :Handle)
    (parentAtom :signed-long)
    (atomType :signed-long)
    (index :SInt16)
    (id (:pointer :QTATOMID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTFindChildByID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTFindChildByID" 
   ((container :Handle)
    (parentAtom :signed-long)
    (atomType :signed-long)
    (id :signed-long)
    (index (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTNextChildAnyType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTNextChildAnyType" 
   ((container :Handle)
    (parentAtom :signed-long)
    (currentChild :signed-long)
    (nextChild (:pointer :QTATOM))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  set a leaf atom's data
; 
;  *  QTSetAtomData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTSetAtomData" 
   ((container :Handle)
    (atom :signed-long)
    (dataSize :signed-long)
    (atomData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  extracting data
; 
;  *  QTCopyAtomDataToHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTCopyAtomDataToHandle" 
   ((container :Handle)
    (atom :signed-long)
    (targetHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTCopyAtomDataToPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTCopyAtomDataToPtr" 
   ((container :Handle)
    (atom :signed-long)
    (sizeOrLessOK :Boolean)
    (size :signed-long)
    (targetPtr :pointer)
    (actualSize (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTGetAtomTypeAndID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTGetAtomTypeAndID" 
   ((container :Handle)
    (atom :signed-long)
    (atomType (:pointer :QTATOMTYPE))
    (id (:pointer :QTATOMID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  extract a copy of an atom and all of it's children, caller disposes
; 
;  *  QTCopyAtom()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTCopyAtom" 
   ((container :Handle)
    (atom :signed-long)
    (targetContainer (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  obtaining direct reference to atom data
; 
;  *  QTLockContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTLockContainer" 
   ((container :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTGetAtomDataPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTGetAtomDataPtr" 
   ((container :Handle)
    (atom :signed-long)
    (dataSize (:pointer :long))
    (atomData (:pointer :Ptr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTUnlockContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTUnlockContainer" 
   ((container :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    building QTAtomContainer trees
;    creates and inserts new atom at specified index, existing atoms at or after index are moved toward end of list
;    used for Top-Down tree creation
; 
; 
;  *  QTInsertChild()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTInsertChild" 
   ((container :Handle)
    (parentAtom :signed-long)
    (atomType :signed-long)
    (id :signed-long)
    (index :SInt16)
    (dataSize :signed-long)
    (data :pointer)
    (newAtom (:pointer :QTATOM))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  inserts children from childrenContainer as children of parentAtom
; 
;  *  QTInsertChildren()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTInsertChildren" 
   ((container :Handle)
    (parentAtom :signed-long)
    (childrenContainer :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  destruction
; 
;  *  QTRemoveAtom()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTRemoveAtom" 
   ((container :Handle)
    (atom :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTRemoveChildren()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTRemoveChildren" 
   ((container :Handle)
    (atom :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  replacement must be same type as target
; 
;  *  QTReplaceAtom()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTReplaceAtom" 
   ((targetContainer :Handle)
    (targetAtom :signed-long)
    (replacementContainer :Handle)
    (replacementAtom :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSwapAtoms()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTSwapAtoms" 
   ((container :Handle)
    (atom1 :signed-long)
    (atom2 :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSetAtomID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTSetAtomID" 
   ((container :Handle)
    (atom :signed-long)
    (newID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTGetAtomParent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_QTGetAtomParent" 
   ((container :Handle)
    (childAtom :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SetMediaPropertyAtom()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetMediaPropertyAtom" 
   ((theMedia (:Handle :MediaType))
    (propertyAtom :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMediaPropertyAtom()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMediaPropertyAtom" 
   ((theMedia (:Handle :MediaType))
    (propertyAtom (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ****
;     Tween Support
; ****

;type name? (def-mactype :TweenRecord (find-mactype ':TweenRecord))

(def-mactype :TweenerDataProcPtr (find-mactype ':pointer)); (TweenRecord * tr , void * tweenData , long tweenDataSize , long dataDescriptionSeed , Handle dataDescription , ICMCompletionProcRecordPtr asyncCompletionProc , UniversalProcPtr transferProc , void * refCon)

(def-mactype :TweenerDataUPP (find-mactype '(:pointer :OpaqueTweenerDataProcPtr)))
(defrecord TweenRecord
   (version :signed-long)
   (container :Handle)
   (tweenAtom :signed-long)
   (dataAtom :signed-long)
   (percent :signed-long)
   (dataProc (:pointer :OpaqueTweenerDataProcPtr))
   (private1 :pointer)
   (private2 :pointer)
)
(defrecord TweenV1Record
   (version :signed-long)
   (container :Handle)
   (tweenAtom :signed-long)
   (dataAtom :signed-long)
   (percent :signed-long)
   (dataProc (:pointer :OpaqueTweenerDataProcPtr))
   (private1 :pointer)
   (private2 :pointer)
   (fractPercent :signed-long)
)

;type name? (%define-record :TweenV1Record (find-record-descriptor ':TweenV1Record))

(defconstant $kTweenRecordNoFlags 0)
(defconstant $kTweenRecordIsAtInterruptTime 1)
(defrecord TweenV2Record
   (version :signed-long)
   (container :Handle)
   (tweenAtom :signed-long)
   (dataAtom :signed-long)
   (percent :signed-long)
   (dataProc (:pointer :OpaqueTweenerDataProcPtr))
   (private1 :pointer)
   (private2 :pointer)
   (fractPercent :signed-long)
   (flags :signed-long)
)

;type name? (%define-record :TweenV2Record (find-record-descriptor ':TweenV2Record))
; 
;  *  QTNewTween()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTNewTween" 
   ((tween (:pointer :QTTWEENER))
    (container :Handle)
    (tweenAtom :signed-long)
    (maxTime :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTDisposeTween()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTDisposeTween" 
   ((tween (:pointer :QTTweenerRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTDoTween()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTDoTween" 
   ((tween (:pointer :QTTweenerRecord))
    (atTime :signed-long)
    (result :Handle)
    (resultSize (:pointer :long))
    (tweenDataProc (:pointer :OpaqueTweenerDataProcPtr))
    (tweenDataRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;     QTDoTweenPtr is an interrupt-safe version of QTDoTween.  It has the following limitations:
;      - not all tween types support this call (those which must allocated memory), in which case they return codecUnimpErr.
;      - the QTAtomContainer used for the tween must be locked
;      - the dataSize must be large enough to contain the result
;      - this call is not supported for sequence tweens, use interpolation tweens instead
; 
; 
;  *  QTDoTweenPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTDoTweenPtr" 
   ((tween (:pointer :QTTweenerRecord))
    (atTime :signed-long)
    (result :pointer)
    (resultSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; ****
;     Sound Description Manipulations
; ****
; 
;  *  AddSoundDescriptionExtension()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddSoundDescriptionExtension" 
   ((desc (:Handle :SoundDescription))
    (extension :Handle)
    (idType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetSoundDescriptionExtension()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetSoundDescriptionExtension" 
   ((desc (:Handle :SoundDescription))
    (extension (:pointer :Handle))
    (idType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveSoundDescriptionExtension()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_RemoveSoundDescriptionExtension" 
   ((desc (:Handle :SoundDescription))
    (idType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ****
;     Preferences
; ****
; 
;  *  GetQuickTimePreference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetQuickTimePreference" 
   ((preferenceType :OSType)
    (preferenceAtom (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetQuickTimePreference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetQuickTimePreference" 
   ((preferenceType :OSType)
    (preferenceAtom :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ****
;     Effects and dialog Support
; ****
;  atom types for entries in the effects list

(defconstant $kEffectNameAtom :|name|)          ;  name of effect 

(defconstant $kEffectTypeAtom :|type|)          ;  codec sub-type for effect 

(defconstant $kEffectManufacturerAtom :|manu|)  ;  codec manufacturer for effect 

(defrecord QTParamPreviewRecord
   (sourceID :signed-long)                      ;  1 based source identifier
   (sourcePicture (:Handle :Picture))           ;  picture for preview, must not dispose until dialog is disposed
)

;type name? (%define-record :QTParamPreviewRecord (find-record-descriptor ':QTParamPreviewRecord))

(def-mactype :QTParamPreviewPtr (find-mactype '(:pointer :QTParamPreviewRecord)))
(defrecord QTParamDialogEventRecord
   (theEvent (:pointer :EventRecord))           ;  Event received by the dialog 
   (whichDialog (:pointer :OpaqueDialogPtr))    ;  dialog that event was directed towards 
   (itemHit :SInt16)                            ;  dialog item which was hit 
)

;type name? (%define-record :QTParamDialogEventRecord (find-record-descriptor ':QTParamDialogEventRecord))

(def-mactype :QTParamDialogEventPtr (find-mactype '(:pointer :QTParamDialogEventRecord)))
(defrecord QTParamFetchPreviewRecord
   (theWorld (:pointer :OpaqueGrafPtr))         ;  the world into which to draw the preview 
   (percentage :signed-long)                    ;  frame percentage (from 0.0 - 1.0) to be drawn 
)

;type name? (%define-record :QTParamFetchPreviewRecord (find-record-descriptor ':QTParamFetchPreviewRecord))

(def-mactype :QTParamFetchPreviewPtr (find-mactype '(:pointer :QTParamFetchPreviewRecord)))

; #if TARGET_API_MAC_CARBON
;  Only available on OS X 

(defconstant $kEffectParentWindowCarbon :|carb|)
(defrecord QTEventLoopDescriptionRecord
   (recordSize :signed-long)                    ;  must be == sizeof(QTEventLoopDescriptionRecord) 
   (windowRefKind :signed-long)                 ;  kind of window reference 
   (parentWindow :pointer)                      ;  parent window (for sheets) or NIL to use Carbon FrontWindow() 
   (eventTarget :pointer)                       ;  EventTargetRef to receive kHICommandOK and kHICommandCancel 
)

(def-mactype :QTEventLoopDescriptionPtr (find-mactype '(:POINTER :QTEventLoopDescriptionRecord)))

; #endif


(defconstant $pdActionConfirmDialog 1)          ;  no param

(defconstant $pdActionSetAppleMenu 2)           ;  param is MenuRef

(defconstant $pdActionSetEditMenu 3)            ;  param is MenuRef

(defconstant $pdActionGetDialogValues 4)        ;  param is QTAtomContainer

(defconstant $pdActionSetPreviewUserItem 5)     ;  param is long

(defconstant $pdActionSetPreviewPicture 6)      ;  param is QTParamPreviewPtr;

(defconstant $pdActionSetColorPickerEventProc 7);  param is UserEventUPP

(defconstant $pdActionSetDialogTitle 8)         ;  param is StringPtr 

(defconstant $pdActionGetSubPanelMenu 9)        ;  param is MenuRef* 

(defconstant $pdActionActivateSubPanel 10)      ;  param is long 

(defconstant $pdActionConductStopAlert 11)      ;  param is StringPtr 

(defconstant $pdActionModelessCallback 12)      ;  param is QTParamDialogEventPtr 

(defconstant $pdActionFetchPreview 13)          ;  param is QTParamFetchPreviewPtr 

(defconstant $pdActionSetDialogSettings 14)     ;  param is QTAtomContainer 

(defconstant $pdActionGetDialogSettings 15)     ;  param is QTAtomContainer 

(defconstant $pdActionGetNextSample 16)         ;  param is QTAtomContainer with effect sample to change - createdDialog may be NIL 

(defconstant $pdActionGetPreviousSample 17)     ;  param is QTAtomContainer with effect sample to change - createdDialog may be NIL 

(defconstant $pdActionCompactSample 18)         ;  param is QTAtomContainer with effect sample to compact, - createdDialog may be NIL 

(defconstant $pdActionSetEditCallout 19)        ;  param is QTParamPreviewCalloutPtr, can be NIL 

(defconstant $pdActionSetSampleTime 20)         ;  param is QTParamSampleTimePtr, can be NIL 

(defconstant $pdActionDoEditCommand 21)         ;  param is long with menu command (ie, mcMenuCut etc) 

(defconstant $pdActionGetSubPanelMenuValue 22)  ;  param is long and returns current sub-panel value selected by the effect 
;  Action codes and typedefs used for custom controls within effects 

(defconstant $pdActionCustomNewControl 23)      ;  param is QTCustomControlNewPtr 

(defconstant $pdActionCustomDisposeControl 24)  ;  param is QTCustomControlNewPtr 

(defconstant $pdActionCustomPositionControl 25) ;  param is QTCustomControlPositionControlPtr 

(defconstant $pdActionCustomShowHideControl 26) ;  param is QTCustomControlShowHideControlPtr 

(defconstant $pdActionCustomHandleEvent 27)     ;  param is QTCustomControlHandleEventPtr 

(defconstant $pdActionCustomSetFocus 28)        ;  param is QTCustomControlSetFocusPtr 

(defconstant $pdActionCustomSetEditMenu 29)     ;  param is QTCustomControlSetEditMenuPtr 

(defconstant $pdActionCustomSetPreviewPicture 30);  param is QTCustomControlSetPreviewPicturePtr 

(defconstant $pdActionCustomSetEditCallout 31)  ;  param is QTCustomControlSetEditCalloutPtr 

(defconstant $pdActionCustomGetEnableValue 32)  ;  param is QTCustomControlGetEnableValuePtr 

(defconstant $pdActionCustomSetSampleTime 33)   ;  param is QTCustomControlSetSampleTimePtr 

(defconstant $pdActionCustomGetValue 34)        ;  param is QTCustomControlGetValue 

(defconstant $pdActionCustomDoEditCommand 35)   ;  param is QTCustomControlDoEditCommand 
;  more actions for the dialog 

(defconstant $pdActionRunInEventLoop 36)        ;  param is QTEventLoopDescriptionPtr - OS X only

(defconstant $pdActionConvertSettingsToXML 37)  ;  param is QTAtomContainer* inbound, Handle* outbound contains the XML - createdDialog may be NIL 

(defconstant $pdActionConvertSettingsToXMLWithComments 38);  param is QTAtomContainer* inbound, Handle* outbound contains the XML with comments - createdDialog may be NIL 

(defconstant $pdActionConvertSettingsToText 39) ;  param is QTAtomContainer* inbound, Handle* outbound contains human readable text - createdDialog may be NIL 

(defconstant $pdActionConvertXMLToSettings 40)  ;  param is Handle* inbound, QTAtomContainer* outbound contains parameters - createdDialog may be NIL 

(defconstant $pdActionSetPropertyComponent 41)  ;  param is QTParamComponentPropertyPtr 

;  Sample Time information 

(defconstant $pdSampleTimeDisplayOptionsNone 0)
(defrecord QTParamComponentPropertyRecord
   (component (:pointer :ComponentInstanceRecord));  component to call for get/set properties
   (defaultClass :OSType)                       ;  default property class if not overriden by a given parameter
)

;type name? (%define-record :QTParamComponentPropertyRecord (find-record-descriptor ':QTParamComponentPropertyRecord))

(def-mactype :QTParamComponentPropertyPtr (find-mactype '(:pointer :QTParamComponentPropertyRecord)))
(defrecord QTParamSampleTimeRecord
   (displayOptions :signed-long)
   (sampleStartTime :TimeRecord)
   (sampleDuration :signed-long)
   (framesPerSecond :signed-long)               ;  if 0, will cause revert to seconds display
)

;type name? (%define-record :QTParamSampleTimeRecord (find-record-descriptor ':QTParamSampleTimeRecord))

(def-mactype :QTParamSampleTimePtr (find-mactype '(:pointer :QTParamSampleTimeRecord)))
;  Preview change callout information 
(defrecord QTParamPreviewCalloutRecord
   (calloutProc (:pointer :OpaqueMoviePreviewCallOutProcPtr));  called when user makes editing changes to dialog.  May be NIL.  You should return true from your function. 
   (refCon :signed-long)                        ;  passed to the callout procedure 
)

;type name? (%define-record :QTParamPreviewCalloutRecord (find-record-descriptor ':QTParamPreviewCalloutRecord))

(def-mactype :QTParamPreviewCalloutPtr (find-mactype '(:pointer :QTParamPreviewCalloutRecord)))

(defconstant $pdOptionsCollectOneValue 1)       ;  should collect a single value only

(defconstant $pdOptionsAllowOptionalInterpolations 2);  non-novice interpolation options are shown 

(defconstant $pdOptionsModalDialogBox 4)        ;  dialog box should be modal 

(defconstant $pdOptionsEditCurrentEffectOnly 8) ;  List of effects will not be shown 

(defconstant $pdOptionsHidePreview 16)          ;  Preview item will not be shown 

(defconstant $pdOptionsDisplayAsSheet 32)       ;  Dialog will be used as a sheet (on platforms that support it) 


(def-mactype :QTParameterDialogOptions (find-mactype ':signed-long))
;  ------- CUSTOM EFFECT CONTROLS
; 
;     Effects may choose to implement custom controls to allow the user to more easily edit complex parameters
;     that are ill-served by simple sliders or type in boxes.   Effects may allow a custom control for either
;     a single parameter, or for a group of parameters.
;     
;     Parameter(s) for a custom control must still be data types defined by the standard set, or for
;     complex records of data, must be defined within a group as individual parameters made up from base
;     data types (for example, a point is a group containing two Fixed point numbers).  
;     This is to allow applications that do not wish to use the custom control for the effect to set values themselves.
;     
;     Effects should be aware that these custom controls may be deployed by the application in either a dialog or
;     a window, with application defined background colors or patterns, along with application defined font
;     characteristics for the window.
;     
;     It is recommended that effects implement custom controls only when needed, and that custom controls be used
;     for specific types of parameters (ie, point, rectangle, polygon, path) rather than the entire user interface
;     for the effect.  Effects may choose to implement multiple custom controls which combine with standard controls
;     to present the total user interface.  For effects which have very complex user interfaces not well suited for 
;     inclusion within a single window, it is recommended to use kParameterImageIsPreset -- which allows the effect to
;     have an external editing application for parameters which may then be set within the standard UI via the open file 
;     dialog or drag and drop.  The Lens Flare effect's "Flare Type" is an example of such a preset.
; 
;     For parameters that use a custom control to control a single parameter value, a new behavior
;     flag has been added (kCustomControl), and the behavior for the parameter should be kParameterItemControl.
;     
;     For parameters that are groups, the same flag (kCustomControl) should be used, and the behavior
;     should be kParameterItemGroupDivider.  Groups with the kCustomControl bit set will be implemented
;     by calling the custom control for that group -- the parameters within that group will not be processed
;     in the normal manner.
;     
;     In both cases, the new customType and customID fields of the behavior must be filled in.  These are 
;     used in order to allow your custom control to determine which parameter is being edited in the case
;     where the custom control is used for the editing of multiple parameters.  These values are passed into
;     the pdActionCustomNewControl call.  Since the custom control mechanism is also used by QuickTime's
;     default effect dialogs, you should be prepared to pass onto the base effect any pdActionCustomNewControl
;     calls for type/id pairs that you do not handle yourself.  When  pdActionCustomNewControl is called
;     for controls of types handled by QuickTime, customType is kParameterAtomTypeAndID and customID is
;     the ID of the parameter atom. 
; 
; 
;     pdActionCustomNewControlControl is called by application to create a new custom control or set of controls
;     for an effect parameter.  When pdActionCustomNewControl is called, the effect should perform any
;     basic allocation it needs for storage and return the result in storage. The options parameter tells
;     the control if the application wishes to support interpolated, optionally interpolated, or a single
;     value parameter.
;     
;     Since pdActionCustomNewControlControl may be called upon your effect for other items within the
;     dialog, it is recommended that your effect have an easy way to determine which controls it implements:
;      a) by having storage be a pointer with an OSType at the begining to mark controls
;         implemented by your code.
;      - or -
;      b) keeping track in your component globals those custom controls which you have created.
;     
;     When pdActionCustomDisposeControl is called any allocation done by the control should be disposed. In addition, 
;     pdActionCustomDisposeControl is the last chance the control has to commit any user changes into the sample.
;     Controls which implement type in fields typically need to commit any final user edits at this time.
; 
(defrecord QTCustomControlNewRecord
   (storage :pointer)                           ;  storage allocated/disposed by the control
   (options :signed-long)                       ;  options used to control interpolation/not
   (sample :Handle)                             ;  sample that holds the data to be edited
   (customType :signed-long)                    ;  custom type and ID specified by effect for creation of this control
   (customID :signed-long)
)

;type name? (%define-record :QTCustomControlNewRecord (find-record-descriptor ':QTCustomControlNewRecord))

(def-mactype :QTCustomControlNewPtr (find-mactype '(:pointer :QTCustomControlNewRecord)))
; 
;     pdActionCustomPositionControl is called by the application to position the control within a window or dialog.
; 
;     The control should determine if it will fit in the alloted area and position itself there.  It should also
;     return the space taken up by the control.   Note you are free to implement controls which are variable in size depending upon
;     which parameter you are editing.  You need not scale your control to the requested size.  If the area presented to your
;     control is too small, set didFit to false.  You should still return in used the size you would have liked to use for
;     the control.   The application will then try again with a new size.  Note that all
;     controls must be able to fit within a minimum of 300 by 250 pixels.
;     
;     Custom controls that draw text should make note of the text font, size, and style at this time in order
;     to properly display within application windows.
;     
;     Note that the default state for the control is hidden.  You will receive a pdActionCustomShowHideControl
;     in order to enable your control.  You should not draw your control in response to pdActionCustomPositionControl.
; 
(defrecord QTCustomControlPositionControlRecord
   (storage :pointer)                           ;  storage for the control
   (window (:pointer :OpaqueWindowPtr))         ;  window to be used by the control
   (location :Rect)                             ;  location within the window the control may use
   (used :Rect)                                 ;  returned by the control to indicate size it actually used
   (didFit :Boolean)                            ;  did the control fit in the specified area?
   (pad (:array :Boolean 3))
)

;type name? (%define-record :QTCustomControlPositionControlRecord (find-record-descriptor ':QTCustomControlPositionControlRecord))

(def-mactype :QTCustomControlPositionControlPtr (find-mactype '(:pointer :QTCustomControlPositionControlRecord)))
; 
;     pdActionCustomShowHideControl is called when the application wishes to enable/disable your control, or 
;     completely disable drawing of the control
;     
;     Your control should make note of the new state (if different from the last) and perform an InvalRect()
;     on your drawing area, or you may draw your control's initial state in the case of show.  You should not
;     attempt to erase your control as the result of a hide -- instead call InvalRect() and allow the application
;     to process the resulting event as appropriate.
; 
(defrecord QTCustomControlShowHideControlRecord
   (storage :pointer)                           ;  storage for the control
   (show :Boolean)                              ;  display the control?
   (enable :Boolean)                            ;  enable the control (ie, black vs gray display)
   (pad (:array :Boolean 2))
)

;type name? (%define-record :QTCustomControlShowHideControlRecord (find-record-descriptor ':QTCustomControlShowHideControlRecord))

(def-mactype :QTCustomControlShowHideControlPtr (find-mactype '(:pointer :QTCustomControlShowHideControlRecord)))
; 
;     pdActionCustomHandleEvent is called to allow your custom control to process events.
;     
;     Typical controls handle the following events:
;         - activate - to draw your control in normal/gray mode
;         - update - to draw your control
;         - mouseDown - to handle clicks
;         - keyDown - to handle typing when you have focus
;         - idle - to perform idle drawing (if applicable)
;     If your control handles the entire event, set didProcess to true.  If
;     you handled the event, but other controls still need the event, set didProcess to false.
;     
;     If your control supports the concept of focus for the purposes of typing (such as by having
;     a type-in box for the parameter) then you set the tookFocus Boolean as part of your processing
;     of the event.  It is assumed that your control will draw the appropriate focus UI as a result, and
;     the calling application will disable any focus drawing within the remainder of the UI.
; 
;     By default, custom controls are not given idle time.  If you need idle time, set needIdle to true
;     in response to the even that causes you to need idle (typically the taking of focus, or the first draw).
;     Your control will continue to be given idle events until you set needIdle to false in response to
;     a nullEvent.
; 
(defrecord QTCustomControlHandleEventRecord
   (storage :pointer)                           ;  storage for the control
   (pEvent (:pointer :EventRecord))             ;  event to process
   (didProcess :Boolean)                        ;  did we process entire event?
   (tookFocus :Boolean)                         ;  did we take focus as a result of this event (typically mouseDowns)
   (needIdle :Boolean)                          ;  does this control need idle events?
   (didEdit :Boolean)                           ;  did we edit the samples?
)

;type name? (%define-record :QTCustomControlHandleEventRecord (find-record-descriptor ':QTCustomControlHandleEventRecord))

(def-mactype :QTCustomControlHandleEventPtr (find-mactype '(:pointer :QTCustomControlHandleEventRecord)))
; 
;     pdActionCustomSetFocus is called in order to set or advance the current focus of the user interface, typically
;     because the user has pressed the tab or shift-tab keys, or because the user clicked within the area defined by
;     your control.
;     
;     Your control will be called with pdActionFocusFirst,  pdActionFocusLast, or pdActionFocusOff to set or clear focus on your
;     control.  Your control will be called with pdActionFocusForward or pdActionFocusBackward to cycle
;     focus within your control (if your control has multiple focus).  If your control does not support focus,
;     or the focus request results in focus moving beyond your supported range, return pdActionFocusOff in
;     the focus parameter.  Otherwise, return the focus that you set.
;     
;     Controls which have no focus would always set focus to be pdActionFocusOff.
;     
;     Controls with a single focus would set pdActionFocusFirst when requsted to set either
;     pdActionFocusFirst or pdActionFocusLast, and would set pdActionFocusOff for either
;     pdActionFocusForward or pdActionFocusBackward.
; 

(defconstant $pdActionFocusOff 0)               ;  no focus 

(defconstant $pdActionFocusFirst 1)             ;  focus on first element 

(defconstant $pdActionFocusLast 2)              ;  focus on last element 

(defconstant $pdActionFocusForward 3)           ;  focus on next element 

(defconstant $pdActionFocusBackward 4)          ;  focus on previous element 

(defrecord QTCustomControlSetFocusRecord
   (storage :pointer)                           ;  storage for the control
   (focus :signed-long)                         ;  focus to set, return resulting focus
)

;type name? (%define-record :QTCustomControlSetFocusRecord (find-record-descriptor ':QTCustomControlSetFocusRecord))

(def-mactype :QTCustomControlSetFocusPtr (find-mactype '(:pointer :QTCustomControlSetFocusRecord)))
;  
;     pdActionCustomSetEditMenu will be called to inform your custom control of the location of the edit menu.
;     
;     If your control has editing boxes, this is useful in order to allow the user to perform cut/copy/paste operations
;     when focus is on one of these boxes.
; 
(defrecord QTCustomControlSetEditMenuRecord
   (storage :pointer)                           ;  storage for the control
   (editMenu (:pointer :OpaqueMenuRef))         ;  edit menu, or NIL
)

;type name? (%define-record :QTCustomControlSetEditMenuRecord (find-record-descriptor ':QTCustomControlSetEditMenuRecord))

(def-mactype :QTCustomControlSetEditMenuPtr (find-mactype '(:pointer :QTCustomControlSetEditMenuRecord)))
; 
;     pdActionCustomSetPreviewPicture will be called to inform your custom control of preview information that you
;     may wish to use in the drawing of your user interface.  
; 
(defrecord QTCustomControlSetPreviewPictureRecord
   (storage :pointer)                           ;  storage for the control
   (preview (:pointer :QTParamPreviewRecord))   ;  preview to set
)

;type name? (%define-record :QTCustomControlSetPreviewPictureRecord (find-record-descriptor ':QTCustomControlSetPreviewPictureRecord))

(def-mactype :QTCustomControlSetPreviewPicturePtr (find-mactype '(:pointer :QTCustomControlSetPreviewPictureRecord)))
; 
;     pdActionCustomSetEditCallout tells your control of the need by the application to be informed of
;     changes to the parameter values (typically for the purposes of updating previews).
;     
;     If a callout is available, your custom control should call it whenever a change has been
;     made to the parameter(s) that your control is editing (as a result of user actions, most typically).
;     If you choose not to implement this, live dragging or updating of values will not work.
; 
(defrecord QTCustomControlSetEditCalloutRecord
   (storage :pointer)                           ;  storage for the control
   (callout (:pointer :QTParamPreviewCalloutRecord));  requested callout, or NIL to disable
)

;type name? (%define-record :QTCustomControlSetEditCalloutRecord (find-record-descriptor ':QTCustomControlSetEditCalloutRecord))

(def-mactype :QTCustomControlSetEditCalloutPtr (find-mactype '(:pointer :QTCustomControlSetEditCalloutRecord)))
; 
;     pdActionCustomGetEnableValue allows you to return a value for the purposes of enabling/disabling
;     other controls.
;     Most custom controls do not need to implement this call.
;     
;     If your control is able to control the enabling and disabling of other parameter controls (such as is done
;     by standard pop up or enumerated type controls), you need to supply a value that can be use for greater than/less than
;     types of comparisons.
; 
(defrecord QTCustomControlGetEnableValueRecord
   (storage :pointer)                           ;  storage for the control
   (currentValue :signed-long)                  ;  value to compare against for enable/disable purposes
)

;type name? (%define-record :QTCustomControlGetEnableValueRecord (find-record-descriptor ':QTCustomControlGetEnableValueRecord))

(def-mactype :QTCustomControlGetEnableValuePtr (find-mactype '(:pointer :QTCustomControlGetEnableValueRecord)))
; 
;     pdActionCustomSetSampleTime tells your control information from the application about the duration
;     and start time for the sample being edited.
;     
;     Most controls do not need this information, but some may choose to use it in the interface
;     they present the user.  However, this call need not be made by applications, so the custom
;     control should be prepared to run when the sample time information is not available.
; 
(defrecord QTCustomControlSetSampleTimeRecord
   (storage :pointer)                           ;  storage for the control
   (sampleTime (:pointer :QTParamSampleTimeRecord));  sample time information or NIL
)

;type name? (%define-record :QTCustomControlSetSampleTimeRecord (find-record-descriptor ':QTCustomControlSetSampleTimeRecord))

(def-mactype :QTCustomControlSetSampleTimePtr (find-mactype '(:pointer :QTCustomControlSetSampleTimeRecord)))
; 
;     pdActionCustomGetValue tells your control to store any value(s) into the specified atom container.
;     
;     All custom controls must implement this call
; 
(defrecord QTCustomControlGetValueRecord
   (storage :pointer)                           ;  storage for the control
   (sample :Handle)                             ;  sample to store into
)

;type name? (%define-record :QTCustomControlGetValueRecord (find-record-descriptor ':QTCustomControlGetValueRecord))

(def-mactype :QTCustomControlGetValuePtr (find-mactype '(:pointer :QTCustomControlGetValueRecord)))
; 
;     pdActionCustomDoEditCommand tells your control to handle edit commands if it allow focus and type in boxes.
;     
;     All custom controls must implement this call if they support edit boxes
; 
(defrecord QTCustomControlDoEditCommandRecord
   (storage :pointer)                           ;  storage for the control
   (command :signed-long)                       ;  command to execute, return 0 here if processed
)

;type name? (%define-record :QTCustomControlDoEditCommandRecord (find-record-descriptor ':QTCustomControlDoEditCommandRecord))

(def-mactype :QTCustomControlDoEditCommandPtr (find-mactype '(:pointer :QTCustomControlDoEditCommandRecord)))

(def-mactype :QTParameterDialog (find-mactype ':signed-long))

(defconstant $elOptionsIncludeNoneInList 1)     ;  "None" effect is included in list 


(def-mactype :QTEffectListOptions (find-mactype ':signed-long))

(defconstant $effectIsRealtime 0)               ;  effect can be rendered in real time 

; 
;     QTGetEffectsListExtended is a call that provides for 
;     more advanced filtering of effects to be placed into the
;     effect list.  Applications can filter on:
;      1) number of input sources
;      2) effect major or minor class
;      3) custom filtering through a callback
;     The callback will be called for each effect which passes
;     the other criteria for inclusion.  If the callback
;     returns a true result the effect will be included in the list.
;     
;     Note that your filter proc may receive multiple effects from various
;     manufacturers.  If you return true for multiple effects of a given type
;     only the one with the higher parameter version number will be included.
;     If you wish other filtering (such as effects from a given manufacturer, you
;     can do this by return false for the other effects and true for those
;     that you prefer.
; 

(def-mactype :QTEffectListFilterProcPtr (find-mactype ':pointer)); (Component effect , long effectMinSource , long effectMaxSource , OSType majorClass , OSType minorClass , void * refcon)

(def-mactype :QTEffectListFilterUPP (find-mactype '(:pointer :OpaqueQTEffectListFilterProcPtr)))
; 
;  *  QTGetEffectsList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTGetEffectsList" 
   ((returnedList (:pointer :QTATOMCONTAINER))
    (minSources :signed-long)
    (maxSources :signed-long)
    (getOptions :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTGetEffectsListExtended()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTGetEffectsListExtended" 
   ((returnedList (:pointer :QTATOMCONTAINER))
    (minSources :signed-long)
    (maxSources :signed-long)
    (getOptions :signed-long)
    (majorClass :OSType)
    (minorClass :OSType)
    (filterProc (:pointer :OpaqueQTEffectListFilterProcPtr))
    (filterRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTCreateStandardParameterDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTCreateStandardParameterDialog" 
   ((effectList :Handle)
    (parameters :Handle)
    (dialogOptions :signed-long)
    (createdDialog (:pointer :QTPARAMETERDIALOG))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTIsStandardParameterDialogEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTIsStandardParameterDialogEvent" 
   ((pEvent (:pointer :EventRecord))
    (createdDialog :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTDismissStandardParameterDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTDismissStandardParameterDialog" 
   ((createdDialog :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTStandardParameterDialogDoAction()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTStandardParameterDialogDoAction" 
   ((createdDialog :signed-long)
    (action :signed-long)
    (params :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTGetEffectSpeed()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTGetEffectSpeed" 
   ((parameters :Handle)
    (pFPS (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ****
;     Error reporting
; ****
(defrecord QTErrorReplacementRecord
   (numEntries :signed-long)
   (replacementString (:array (POINTER UINT8) 1));  array of numEntries StringPtrs (each String is allocated separately).
)

;type name? (%define-record :QTErrorReplacementRecord (find-record-descriptor ':QTErrorReplacementRecord))

(def-mactype :QTErrorReplacementPtr (find-mactype '(:pointer :QTErrorReplacementRecord)))
; 
;     QTAddMovieError is used to add orthogonal errors to a list of errors that will
;     later be reported (at the end of an import or playback, for example).  Errors are stored
;     in 'qter' resources within the component.
;     
;     QTAddMovieError(Movie       addTo,                          // in: movie to add error to
;                     Component   adder,                          // in: component which is adding the error
;                     long        errorCode,                      // in: error code being added
;                     QTErrorReplacementPtr   stringReplacements);// in: list of strings to subsitute (in order) for "^1", "^2", etc
; 
; 
;  *  QTAddMovieError()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTAddMovieError" 
   ((movieH (:Handle :MovieType))
    (c (:pointer :ComponentRecord))
    (errorCode :signed-long)
    (stringReplacements (:pointer :QTErrorReplacementRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; ****
;     Access Keys
; ****

(defconstant $kAccessKeyAtomType :|acky|)

(defconstant $kAccessKeySystemFlag 1)
; 
;  *  QTGetAccessKeys()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTGetAccessKeys" 
   ((accessKeyType (:pointer :STR255))
    (flags :signed-long)
    (keys (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTRegisterAccessKey()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTRegisterAccessKey" 
   ((accessKeyType (:pointer :STR255))
    (flags :signed-long)
    (accessKey :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTUnregisterAccessKey()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTUnregisterAccessKey" 
   ((accessKeyType (:pointer :STR255))
    (flags :signed-long)
    (accessKey :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ****
;     Content Restrictions
; ****
; 
;  *  QTGetMovieRestrictions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTGetMovieRestrictions" 
   ((theMovie (:Handle :MovieType))
    (outRestrictionSet (:pointer :QTRESTRICTIONSET))
    (outSeed (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTRestrictionsGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTRestrictionsGetInfo" 
   ((inRestrictionSet (:Handle :QTRestrictionSetRecord))
    (outRestrictionClassCount (:pointer :long))
    (outSeed (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTRestrictionsGetIndClass()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTRestrictionsGetIndClass" 
   ((inRestrictionSet (:Handle :QTRestrictionSetRecord))
    (inIndex :signed-long)
    (outClass (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTRestrictionsGetItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTRestrictionsGetItem" 
   ((inRestrictionSet (:Handle :QTRestrictionSetRecord))
    (inRestrictionClass :OSType)
    (outRestrictions (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTGetSupportedRestrictions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTGetSupportedRestrictions" 
   ((inRestrictionClass :OSType)
    (outRestrictionIDs (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTCreateUUID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTCreateUUID" 
   ((outUUID (:pointer :QTUUID))
    (creationFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTEqualUUIDs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTEqualUUIDs" 
   ((uuid1 (:pointer :QTUUID))
    (uuid2 (:pointer :QTUUID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Boolean
() )
; ****
;     Time table
; ****
; 
;  *  MakeTrackTimeTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MakeTrackTimeTable" 
   ((trackH (:Handle :TrackType))
    (offsets (:pointer :long))
    (startTime :signed-long)
    (endTime :signed-long)
    (timeIncrement :signed-long)
    (firstDataRefIndex :SInt16)
    (lastDataRefIndex :SInt16)
    (retdataRefSkew (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  MakeMediaTimeTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MakeMediaTimeTable" 
   ((theMedia (:Handle :MediaType))
    (offsets (:pointer :long))
    (startTime :signed-long)
    (endTime :signed-long)
    (timeIncrement :signed-long)
    (firstDataRefIndex :SInt16)
    (lastDataRefIndex :SInt16)
    (retdataRefSkew (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMaxLoadedTimeInMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetMaxLoadedTimeInMovie" 
   ((theMovie (:Handle :MovieType))
    (time (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTMovieNeedsTimeTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTMovieNeedsTimeTable" 
   ((theMovie (:Handle :MovieType))
    (needsTimeTable (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTGetDataRefMaxFileOffset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTGetDataRefMaxFileOffset" 
   ((movieH (:Handle :MovieType))
    (dataRefType :OSType)
    (dataRef :Handle)
    (offset (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ****
;     Bandwidth management support
; ****

(defconstant $ConnectionSpeedPrefsType :|cspd|)
(defconstant $BandwidthManagementPrefsType :|bwmg|)
(defrecord ConnectionSpeedPrefsRecord
   (connectionSpeed :signed-long)
)

;type name? (%define-record :ConnectionSpeedPrefsRecord (find-record-descriptor ':ConnectionSpeedPrefsRecord))

(def-mactype :ConnectionSpeedPrefsPtr (find-mactype '(:pointer :ConnectionSpeedPrefsRecord)))

(def-mactype :ConnectionSpeedPrefsHandle (find-mactype '(:handle :ConnectionSpeedPrefsRecord)))
(defrecord BandwidthManagementPrefsRecord
   (overrideConnectionSpeedForBandwidth :Boolean)
)

;type name? (%define-record :BandwidthManagementPrefsRecord (find-record-descriptor ':BandwidthManagementPrefsRecord))

(def-mactype :BandwidthManagementPrefsPtr (find-mactype '(:pointer :BandwidthManagementPrefsRecord)))

(def-mactype :BandwidthManagementPrefsHandle (find-mactype '(:handle :BandwidthManagementPrefsRecord)))

(defconstant $kQTIdlePriority 10)
(defconstant $kQTNonRealTimePriority 20)
(defconstant $kQTRealTimeSharedPriority 25)
(defconstant $kQTRealTimePriority 30)

(defconstant $kQTBandwidthNotifyNeedToStop 1)
(defconstant $kQTBandwidthNotifyGoodToGo 2)
(defconstant $kQTBandwidthChangeRequest 4)
(defconstant $kQTBandwidthQueueRequest 8)
(defconstant $kQTBandwidthScheduledRequest 16)
(defconstant $kQTBandwidthVoluntaryRelease 32)

(def-mactype :QTBandwidthNotificationProcPtr (find-mactype ':pointer)); (long flags , void * reserved , void * refcon)
(defrecord QTScheduledBandwidthRecord
   (recordSize :signed-long)                    ;  total number of bytes in QTScheduledBandwidthRecord
   (priority :signed-long)
   (dataRate :signed-long)
   (startTime :wide)                            ;  bandwidth usage start time
   (duration :wide)                             ;  duration of bandwidth usage (0 if unknown)
   (prerollDuration :wide)                      ;  time for negotiation before startTime (0 if unknown)
   (scale :signed-long)                         ;  timescale of value/duration/prerollDuration fields
   (base (:pointer :TimeBaseRecord))            ;  timebase
)

;type name? (%define-record :QTScheduledBandwidthRecord (find-record-descriptor ':QTScheduledBandwidthRecord))

(def-mactype :QTScheduledBandwidthPtr (find-mactype '(:pointer :QTScheduledBandwidthRecord)))

(def-mactype :QTScheduledBandwidthHandle (find-mactype '(:handle :QTScheduledBandwidthRecord)))

(def-mactype :QTBandwidthNotificationUPP (find-mactype '(:pointer :OpaqueQTBandwidthNotificationProcPtr)))
; 
;  *  QTBandwidthRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_QTBandwidthRequest" 
   ((priority :signed-long)
    (callback (:pointer :OpaqueQTBandwidthNotificationProcPtr))
    (refcon :pointer)
    (bwRef (:pointer :QTBANDWIDTHREFERENCE))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTBandwidthRequestForTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_QTBandwidthRequestForTimeBase" 
   ((tb (:pointer :TimeBaseRecord))
    (priority :signed-long)
    (callback (:pointer :OpaqueQTBandwidthNotificationProcPtr))
    (refcon :pointer)
    (bwRef (:pointer :QTBANDWIDTHREFERENCE))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTBandwidthRelease()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_QTBandwidthRelease" 
   ((bwRef (:Handle :QTBandwidthUsageRecord))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTScheduledBandwidthRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_QTScheduledBandwidthRequest" 
   ((scheduleRec (:pointer :QTScheduledBandwidthRecord))
    (notificationCallback (:pointer :OpaqueQTBandwidthNotificationProcPtr))
    (refcon :pointer)
    (sbwRef (:pointer :QTSCHEDULEDBANDWIDTHREFERENCE))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTScheduledBandwidthRelease()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_QTScheduledBandwidthRelease" 
   ((sbwRef (:Handle :QTScheduledBandwidthUsageRecord))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewQTCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTCallBackUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQTCallBackProcPtr)
() )
; 
;  *  NewQTSyncTaskUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTSyncTaskUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQTSyncTaskProcPtr)
() )
; 
;  *  NewMovieRgnCoverUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMovieRgnCoverUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMovieRgnCoverProcPtr)
() )
; 
;  *  NewMovieProgressUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMovieProgressUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMovieProgressProcPtr)
() )
; 
;  *  NewMovieDrawingCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMovieDrawingCompleteUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMovieDrawingCompleteProcPtr)
() )
; 
;  *  NewTrackTransferUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewTrackTransferUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTrackTransferProcPtr)
() )
; 
;  *  NewGetMovieUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewGetMovieUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueGetMovieProcPtr)
() )
; 
;  *  NewMoviePreviewCallOutUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMoviePreviewCallOutUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMoviePreviewCallOutProcPtr)
() )
; 
;  *  NewTextMediaUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewTextMediaUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTextMediaProcPtr)
() )
; 
;  *  NewActionsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewActionsUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueActionsProcPtr)
() )
; 
;  *  NewDoMCActionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDoMCActionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDoMCActionProcPtr)
() )
; 
;  *  NewMovieExecuteWiredActionsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMovieExecuteWiredActionsUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMovieExecuteWiredActionsProcPtr)
() )
; 
;  *  NewMoviePrePrerollCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMoviePrePrerollCompleteUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMoviePrePrerollCompleteProcPtr)
() )
; 
;  *  NewQTNextTaskNeededSoonerCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTNextTaskNeededSoonerCallbackUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueQTNextTaskNeededSoonerCallbackProcPtr)
() )
; 
;  *  NewMoviesErrorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMoviesErrorUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMoviesErrorProcPtr)
() )
; 
;  *  NewTweenerDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewTweenerDataUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTweenerDataProcPtr)
() )
; 
;  *  NewQTEffectListFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTEffectListFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueQTEffectListFilterProcPtr)
() )
; 
;  *  NewQTBandwidthNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTBandwidthNotificationUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQTBandwidthNotificationProcPtr)
() )
; 
;  *  DisposeQTCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTCallBackUPP" 
   ((userUPP (:pointer :OpaqueQTCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQTSyncTaskUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTSyncTaskUPP" 
   ((userUPP (:pointer :OpaqueQTSyncTaskProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMovieRgnCoverUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMovieRgnCoverUPP" 
   ((userUPP (:pointer :OpaqueMovieRgnCoverProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMovieProgressUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMovieProgressUPP" 
   ((userUPP (:pointer :OpaqueMovieProgressProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMovieDrawingCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMovieDrawingCompleteUPP" 
   ((userUPP (:pointer :OpaqueMovieDrawingCompleteProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeTrackTransferUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeTrackTransferUPP" 
   ((userUPP (:pointer :OpaqueTrackTransferProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeGetMovieUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeGetMovieUPP" 
   ((userUPP (:pointer :OpaqueGetMovieProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMoviePreviewCallOutUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMoviePreviewCallOutUPP" 
   ((userUPP (:pointer :OpaqueMoviePreviewCallOutProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeTextMediaUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeTextMediaUPP" 
   ((userUPP (:pointer :OpaqueTextMediaProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeActionsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeActionsUPP" 
   ((userUPP (:pointer :OpaqueActionsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDoMCActionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDoMCActionUPP" 
   ((userUPP (:pointer :OpaqueDoMCActionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMovieExecuteWiredActionsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMovieExecuteWiredActionsUPP" 
   ((userUPP (:pointer :OpaqueMovieExecuteWiredActionsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMoviePrePrerollCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMoviePrePrerollCompleteUPP" 
   ((userUPP (:pointer :OpaqueMoviePrePrerollCompleteProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQTNextTaskNeededSoonerCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTNextTaskNeededSoonerCallbackUPP" 
   ((userUPP (:pointer :OpaqueQTNextTaskNeededSoonerCallbackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  DisposeMoviesErrorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMoviesErrorUPP" 
   ((userUPP (:pointer :OpaqueMoviesErrorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeTweenerDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeTweenerDataUPP" 
   ((userUPP (:pointer :OpaqueTweenerDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQTEffectListFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTEffectListFilterUPP" 
   ((userUPP (:pointer :OpaqueQTEffectListFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  DisposeQTBandwidthNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTBandwidthNotificationUPP" 
   ((userUPP (:pointer :OpaqueQTBandwidthNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQTCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTCallBackUPP" 
   ((cb (:pointer :QTCallBackHeader))
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueQTCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQTSyncTaskUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTSyncTaskUPP" 
   ((task :pointer)
    (userUPP (:pointer :OpaqueQTSyncTaskProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeMovieRgnCoverUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMovieRgnCoverUPP" 
   ((theMovie (:Handle :MovieType))
    (changedRgn (:pointer :OpaqueRgnHandle))
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueMovieRgnCoverProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeMovieProgressUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMovieProgressUPP" 
   ((theMovie (:Handle :MovieType))
    (message :SInt16)
    (whatOperation :SInt16)
    (percentDone :signed-long)
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueMovieProgressProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeMovieDrawingCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMovieDrawingCompleteUPP" 
   ((theMovie (:Handle :MovieType))
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueMovieDrawingCompleteProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeTrackTransferUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeTrackTransferUPP" 
   ((t (:Handle :TrackType))
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueTrackTransferProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeGetMovieUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeGetMovieUPP" 
   ((offset :signed-long)
    (size :signed-long)
    (dataPtr :pointer)
    (refCon :pointer)
    (userUPP (:pointer :OpaqueGetMovieProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeMoviePreviewCallOutUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMoviePreviewCallOutUPP" 
   ((refcon :signed-long)
    (userUPP (:pointer :OpaqueMoviePreviewCallOutProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeTextMediaUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeTextMediaUPP" 
   ((theText :Handle)
    (theMovie (:Handle :MovieType))
    (displayFlag (:pointer :short))
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueTextMediaProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeActionsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeActionsUPP" 
   ((refcon :pointer)
    (targetTrack (:Handle :TrackType))
    (targetRefCon :signed-long)
    (theEvent (:pointer :QTEventRecord))
    (userUPP (:pointer :OpaqueActionsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeDoMCActionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDoMCActionUPP" 
   ((refcon :pointer)
    (action :SInt16)
    (params :pointer)
    (handled (:pointer :Boolean))
    (userUPP (:pointer :OpaqueDoMCActionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeMovieExecuteWiredActionsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMovieExecuteWiredActionsUPP" 
   ((theMovie (:Handle :MovieType))
    (refcon :pointer)
    (flags :signed-long)
    (wiredActions :Handle)
    (userUPP (:pointer :OpaqueMovieExecuteWiredActionsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeMoviePrePrerollCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMoviePrePrerollCompleteUPP" 
   ((theMovie (:Handle :MovieType))
    (prerollErr :SInt16)
    (refcon :pointer)
    (userUPP (:pointer :OpaqueMoviePrePrerollCompleteProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQTNextTaskNeededSoonerCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTNextTaskNeededSoonerCallbackUPP" 
   ((duration :signed-long)
    (flags :UInt32)
    (refcon :pointer)
    (userUPP (:pointer :OpaqueQTNextTaskNeededSoonerCallbackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  InvokeMoviesErrorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMoviesErrorUPP" 
   ((theErr :SInt16)
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueMoviesErrorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeTweenerDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeTweenerDataUPP" 
   ((tr (:pointer :TWEENRECORD))
    (tweenData :pointer)
    (tweenDataSize :signed-long)
    (dataDescriptionSeed :signed-long)
    (dataDescription :Handle)
    (asyncCompletionProc (:pointer :ICMCompletionProcRecord))
    (transferProc (:pointer :RoutineDescriptor))
    (refCon :pointer)
    (userUPP (:pointer :OpaqueTweenerDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeQTEffectListFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTEffectListFilterUPP" 
   ((effect (:pointer :ComponentRecord))
    (effectMinSource :signed-long)
    (effectMaxSource :signed-long)
    (majorClass :OSType)
    (minorClass :OSType)
    (refcon :pointer)
    (userUPP (:pointer :OpaqueQTEffectListFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Boolean
() )
; 
;  *  InvokeQTBandwidthNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTBandwidthNotificationUPP" 
   ((flags :signed-long)
    (reserved :pointer)
    (refcon :pointer)
    (userUPP (:pointer :OpaqueQTBandwidthNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ****
;     Connection Speed
; ****

(defconstant $ConnectionSpeedIsValidPrefsType :|vspd|)
; 
;  *  QTGetConnectionSpeedFromPrefs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTGetConnectionSpeedFromPrefs" 
   ((pConnectionSpeed (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; ****
;     QT International Text Atom Support
; ****

(defconstant $kITextRemoveEverythingBut 0)
(defconstant $kITextRemoveLeaveSuggestedAlternate 2)

(defconstant $kITextAtomType :|itxt|)
(defconstant $kITextStringAtomType :|text|)
; 
;  *  ITextAddString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ITextAddString" 
   ((container :Handle)
    (parentAtom :signed-long)
    (theRegionCode :SInt16)
    (theString (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ITextRemoveString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ITextRemoveString" 
   ((container :Handle)
    (parentAtom :signed-long)
    (theRegionCode :SInt16)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ITextGetString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ITextGetString" 
   ((container :Handle)
    (parentAtom :signed-long)
    (requestedRegion :SInt16)
    (foundRegion (:pointer :REGIONCODE))
    (theString (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTTextToNativeText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTTextToNativeText" 
   ((theText :Handle)
    (encoding :signed-long)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  QTParseTextHREF inContainer atoms

(defconstant $kQTParseTextHREFText :|text|)     ;  string

(defconstant $kQTParseTextHREFBaseURL :|burl|)  ;  string

(defconstant $kQTParseTextHREFClickPoint :|clik|);  Point; if present, QTParseTextHREF will expand URLs to support server-side image maps

(defconstant $kQTParseTextHREFUseAltDelim :|altd|);  boolean; if no kQTParseTextHREFDelimiter, delim is ':'

(defconstant $kQTParseTextHREFDelimiter :|delm|);  character

(defconstant $kQTParseTextHREFRecomposeHREF :|rhrf|);  Boolean; if true, QTParseTextHREF returns recomposed HREF with URL expanded as appropriate

;  QTParseTextHREF outContainer atoms

(defconstant $kQTParseTextHREFURL :|url |)      ;  string

(defconstant $kQTParseTextHREFTarget :|targ|)   ;  string

(defconstant $kQTParseTextHREFChapter :|chap|)  ;  string

(defconstant $kQTParseTextHREFIsAutoHREF :|auto|);  Boolean

(defconstant $kQTParseTextHREFIsServerMap :|smap|);  Boolean

(defconstant $kQTParseTextHREFHREF :|href|)     ;  string; recomposed HREF with URL expanded as appropriate, suitable for mcActionLinkToURL

(defconstant $kQTParseTextHREFEMBEDArgs :|mbed|);  string; text between 'E<' and '>' to be used as new movie's embed tags

; 
;  *  QTParseTextHREF()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_QTParseTextHREF" 
   ((href (:pointer :char))
    (hrefLen :SInt32)
    (inContainer :Handle)
    (outContainer (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ************************
; * track reference types
; *************************

(defconstant $kTrackReferenceChapterList :|chap|)
(defconstant $kTrackReferenceTimeCode :|tmcd|)
(defconstant $kTrackReferenceModifier :|ssrc|)
; ************************
; * modifier track types
; *************************

(defconstant $kTrackModifierInput #x696E)       ;  is really 'in'

(defconstant $kTrackModifierType #x7479)        ;  is really 'ty'

(defconstant $kTrackModifierReference :|ssrc|)
(defconstant $kTrackModifierObjectID :|obid|)
(defconstant $kTrackModifierInputName :|name|)

(defconstant $kInputMapSubInputID :|subi|)

(defconstant $kTrackModifierTypeMatrix 1)
(defconstant $kTrackModifierTypeClip 2)
(defconstant $kTrackModifierTypeGraphicsMode 5)
(defconstant $kTrackModifierTypeVolume 3)
(defconstant $kTrackModifierTypeBalance 4)
(defconstant $kTrackModifierTypeImage :|vide|)  ;  was kTrackModifierTypeSpriteImage

(defconstant $kTrackModifierObjectMatrix 6)
(defconstant $kTrackModifierObjectGraphicsMode 7)
(defconstant $kTrackModifierType3d4x4Matrix 8)
(defconstant $kTrackModifierCameraData 9)
(defconstant $kTrackModifierSoundLocalizationData 10)
(defconstant $kTrackModifierObjectImageIndex 11)
(defconstant $kTrackModifierObjectLayer 12)
(defconstant $kTrackModifierObjectVisible 13)
(defconstant $kTrackModifierAngleAspectCamera 14)
(defconstant $kTrackModifierPanAngle :|pan |)
(defconstant $kTrackModifierTiltAngle :|tilt|)
(defconstant $kTrackModifierVerticalFieldOfViewAngle :|fov |)
(defconstant $kTrackModifierObjectQTEventSend :|evnt|)
(defconstant $kTrackModifierObjectCanBeHitTested 15)
(defrecord ModifierTrackGraphicsModeRecord
   (graphicsMode :signed-long)
   (opColor :RGBColor)
)

;type name? (%define-record :ModifierTrackGraphicsModeRecord (find-record-descriptor ':ModifierTrackGraphicsModeRecord))
; ************************
; * tween track types
; *************************

(defconstant $kTweenTypeShort 1)
(defconstant $kTweenTypeLong 2)
(defconstant $kTweenTypeFixed 3)
(defconstant $kTweenTypePoint 4)
(defconstant $kTweenTypeQDRect 5)
(defconstant $kTweenTypeQDRegion 6)
(defconstant $kTweenTypeMatrix 7)
(defconstant $kTweenTypeRGBColor 8)
(defconstant $kTweenTypeGraphicsModeWithRGBColor 9)
(defconstant $kTweenTypeQTFloatSingle 10)
(defconstant $kTweenTypeQTFloatDouble 11)
(defconstant $kTweenTypeFixedPoint 12)
(defconstant $kTweenType3dScale :|3sca|)
(defconstant $kTweenType3dTranslate :|3tra|)
(defconstant $kTweenType3dRotate :|3rot|)
(defconstant $kTweenType3dRotateAboutPoint :|3rap|)
(defconstant $kTweenType3dRotateAboutAxis :|3rax|)
(defconstant $kTweenType3dRotateAboutVector :|3rvc|)
(defconstant $kTweenType3dQuaternion :|3qua|)
(defconstant $kTweenType3dMatrix :|3mat|)
(defconstant $kTweenType3dCameraData :|3cam|)
(defconstant $kTweenType3dAngleAspectCameraData :|3caa|)
(defconstant $kTweenType3dSoundLocalizationData :|3slc|)
(defconstant $kTweenTypePathToMatrixTranslation :|gxmt|)
(defconstant $kTweenTypePathToMatrixRotation :|gxpr|)
(defconstant $kTweenTypePathToMatrixTranslationAndRotation :|gxmr|)
(defconstant $kTweenTypePathToFixedPoint :|gxfp|)
(defconstant $kTweenTypePathXtoY :|gxxy|)
(defconstant $kTweenTypePathYtoX :|gxyx|)
(defconstant $kTweenTypeAtomList :|atom|)
(defconstant $kTweenTypePolygon :|poly|)
(defconstant $kTweenTypeMultiMatrix :|mulm|)
(defconstant $kTweenTypeSpin :|spin|)
(defconstant $kTweenType3dMatrixNonLinear :|3nlr|)
(defconstant $kTweenType3dVRObject :|3vro|)

(defconstant $kTweenEntry :|twen|)
(defconstant $kTweenData :|data|)
(defconstant $kTweenType :|twnt|)
(defconstant $kTweenStartOffset :|twst|)
(defconstant $kTweenDuration :|twdu|)
(defconstant $kTweenFlags :|flag|)
(defconstant $kTweenOutputMin :|omin|)
(defconstant $kTweenOutputMax :|omax|)
(defconstant $kTweenSequenceElement :|seqe|)
(defconstant $kTween3dInitialCondition :|icnd|)
(defconstant $kTweenInterpolationID :|intr|)
(defconstant $kTweenRegionData :|qdrg|)
(defconstant $kTweenPictureData :|PICT|)
(defconstant $kListElementType :|type|)
(defconstant $kListElementDataType :|daty|)
(defconstant $kNameAtom :|name|)
(defconstant $kInitialRotationAtom :|inro|)
(defconstant $kNonLinearTweenHeader :|nlth|)
;  kTweenFlags

(defconstant $kTweenReturnDelta 1)
(defrecord TweenSequenceEntryRecord
   (endPercent :signed-long)
   (tweenAtomID :signed-long)
   (dataAtomID :signed-long)
)

;type name? (%define-record :TweenSequenceEntryRecord (find-record-descriptor ':TweenSequenceEntryRecord))
; #ifdef __QD3D__
#| #|

struct ThreeDeeVRObjectSample {
  long            rows;  
    long            columns;
   TQ3Matrix4x4    calib1;
    TQ3Matrix4x4    calib2;
    long            reserved1;
 long            reserved2;
};

typedef struct ThreeDeeVRObjectSample ThreeDeeVRObjectSample;

struct ThreeDeeNonLinearSample {
 float           DurFromLastSample;  
   TQ3Matrix4x4    matrix;
};
typedef struct ThreeDeeNonLinearSample ThreeDeeNonLinearSample;

struct ThreeDeeNonLinearTweenHeaderAtom {
  long    number;
    long    dataSize;
  float   tensionFactor;  
 long    reserved1;
 long    reserved2;
};
typedef struct ThreeDeeNonLinearTweenHeaderAtom ThreeDeeNonLinearTweenHeaderAtom;


#endif
|#
 |#

; #if OLDROUTINENAMES
#| 
; ************************
; * Video Media routines
; *************************
; #define GetVideoMediaGraphicsMode      MediaGetGraphicsMode
; #define SetVideoMediaGraphicsMode      MediaSetGraphicsMode
;  use these two routines at your own peril 
; #define ResetVideoMediaStatistics      VideoMediaResetStatistics
; #define GetVideoMediaStatistics           VideoMediaGetStatistics
; ************************
; * Sound Media routines
; *************************
; #define GetSoundMediaBalance            MediaGetSoundBalance
; #define SetSoundMediaBalance           MediaSetSoundBalance
; ************************
; * Text Media routines
; *************************
; #define SetTextProc         TextMediaSetTextProc
; #define AddTextSample      TextMediaAddTextSample
; #define AddTESample          TextMediaAddTESample
; #define AddHiliteSample        TextMediaAddHiliteSample
; #define FindNextText       TextMediaFindNextText
; #define HiliteTextSample  TextMediaHiliteTextSample
; #define SetTextSampleData TextMediaSetTextSampleData
; #define DrawRaw              TextMediaDrawRaw
; #define RawSetup           TextMediaRawSetup
; #define RawIdle               TextMediaRawIdle
; #define SetTextProperty        TextMediaSetTextProperty
; ************************
; * Sprite Media routines
; *************************
; #define SetSpriteMediaSpriteProperty  SpriteMediaSetProperty
; #define GetSpriteMediaSpriteProperty SpriteMediaGetProperty
; #define HitTestSpriteMedia               SpriteMediaHitTestSprites
; #define CountSpriteMediaSprites           SpriteMediaCountSprites
; #define CountSpriteMediaImages          SpriteMediaCountImages
; #define GetSpriteMediaIndImageDescription    SpriteMediaGetIndImageDescription
; #define GetDisplayedSampleNumber      SpriteMediaGetDisplayedSampleNumber
 |#

; #endif /* OLDROUTINENAMES */

; ****
;     Content Restrictions
; ****

(defconstant $kQTRestrictionClassSave :|save|)
(defconstant $kQTRestrictionSaveDontAddMovieResource 1)
(defconstant $kQTRestrictionSaveDontFlatten 2)
(defconstant $kQTRestrictionSaveDontExport 4)
(defconstant $kQTRestrictionSaveDontExtract 8)  ;  don't allow any form of extraction of content

(defconstant $kQTRestrictionClassEdit :|edit|)
(defconstant $kQTRestrictionEditDontCopy 1)     ;  disable copy 

(defconstant $kQTRestrictionEditDontCut 2)      ;  disable cut 

(defconstant $kQTRestrictionEditDontPaste 4)    ;  disable paste 

(defconstant $kQTRestrictionEditDontClear 8)    ;  disable clear

(defconstant $kQTRestrictionEditDontModify 16)  ;  don't allow modification of content

(defconstant $kQTRestrictionEditDontExtract 32) ;  don't allow any form of extraction of content

(defconstant $kQTRestrictionClassPlay :|play|)  ;  disable playback   

(defconstant $kQTRestrictionPlayDontPlay 1)
; ************************
; * Video Media routines
; *************************

(defconstant $videoFlagDontLeanAhead 1)
;  use these five routines at your own peril
; 
;  *  VideoMediaResetStatistics()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VideoMediaResetStatistics" 
   ((mh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VideoMediaGetStatistics()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VideoMediaGetStatistics" 
   ((mh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VideoMediaGetStallCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VideoMediaGetStallCount" 
   ((mh (:pointer :ComponentInstanceRecord))
    (stalls (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VideoMediaSetCodecParameter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_VideoMediaSetCodecParameter" 
   ((mh (:pointer :ComponentInstanceRecord))
    (cType :OSType)
    (parameterID :OSType)
    (parameterChangeSeed :signed-long)
    (dataPtr :pointer)
    (dataSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VideoMediaGetCodecParameter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_VideoMediaGetCodecParameter" 
   ((mh (:pointer :ComponentInstanceRecord))
    (cType :OSType)
    (parameterID :OSType)
    (outParameterData :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; ************************
; * Text Media routines
; *************************
;  Return displayFlags for TextProc 

(defconstant $txtProcDefaultDisplay 0)          ;     Use the media's default

(defconstant $txtProcDontDisplay 1)             ;     Don't display the text

(defconstant $txtProcDoDisplay 2)               ;     Do display the text

; 
;  *  TextMediaSetTextProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TextMediaSetTextProc" 
   ((mh (:pointer :ComponentInstanceRecord))
    (TextProc (:pointer :OpaqueTextMediaProcPtr))
    (refcon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextMediaAddTextSample()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TextMediaAddTextSample" 
   ((mh (:pointer :ComponentInstanceRecord))
    (text :pointer)
    (size :UInt32)
    (fontNumber :SInt16)
    (fontSize :SInt16)
    (textFace :UInt8)
    (textColor (:pointer :RGBColor))
    (backColor (:pointer :RGBColor))
    (textJustification :SInt16)
    (textBox (:pointer :Rect))
    (displayFlags :signed-long)
    (scrollDelay :signed-long)
    (hiliteStart :SInt16)
    (hiliteEnd :SInt16)
    (rgbHiliteColor (:pointer :RGBColor))
    (duration :signed-long)
    (sampleTime (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextMediaAddTESample()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TextMediaAddTESample" 
   ((mh (:pointer :ComponentInstanceRecord))
    (hTE :Handle)
    (backColor (:pointer :RGBColor))
    (textJustification :SInt16)
    (textBox (:pointer :Rect))
    (displayFlags :signed-long)
    (scrollDelay :signed-long)
    (hiliteStart :SInt16)
    (hiliteEnd :SInt16)
    (rgbHiliteColor (:pointer :RGBColor))
    (duration :signed-long)
    (sampleTime (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextMediaAddHiliteSample()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TextMediaAddHiliteSample" 
   ((mh (:pointer :ComponentInstanceRecord))
    (hiliteStart :SInt16)
    (hiliteEnd :SInt16)
    (rgbHiliteColor (:pointer :RGBColor))
    (duration :signed-long)
    (sampleTime (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextMediaDrawRaw()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_TextMediaDrawRaw" 
   ((mh (:pointer :ComponentInstanceRecord))
    (gw (:pointer :OpaqueGrafPtr))
    (gd (:Handle :GDEVICE))
    (data :pointer)
    (dataSize :signed-long)
    (tdh (:Handle :TextDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextMediaSetTextProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_TextMediaSetTextProperty" 
   ((mh (:pointer :ComponentInstanceRecord))
    (atMediaTime :signed-long)
    (propertyType :signed-long)
    (data :pointer)
    (dataSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextMediaRawSetup()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_TextMediaRawSetup" 
   ((mh (:pointer :ComponentInstanceRecord))
    (gw (:pointer :OpaqueGrafPtr))
    (gd (:Handle :GDEVICE))
    (data :pointer)
    (dataSize :signed-long)
    (tdh (:Handle :TextDescription))
    (sampleDuration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextMediaRawIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_TextMediaRawIdle" 
   ((mh (:pointer :ComponentInstanceRecord))
    (gw (:pointer :OpaqueGrafPtr))
    (gd (:Handle :GDEVICE))
    (sampleTime :signed-long)
    (flagsIn :signed-long)
    (flagsOut (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextMediaGetTextProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_TextMediaGetTextProperty" 
   ((mh (:pointer :ComponentInstanceRecord))
    (atMediaTime :signed-long)
    (propertyType :signed-long)
    (data :pointer)
    (dataSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(defconstant $findTextEdgeOK 1)                 ;  Okay to find text at specified sample time

(defconstant $findTextCaseSensitive 2)          ;  Case sensitive search

(defconstant $findTextReverseSearch 4)          ;  Search from sampleTime backwards

(defconstant $findTextWrapAround 8)             ;  Wrap search when beginning or end of movie is hit
;  Begin search at the given character offset into sample rather than edge

(defconstant $findTextUseOffset 16)
; 
;  *  TextMediaFindNextText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TextMediaFindNextText" 
   ((mh (:pointer :ComponentInstanceRecord))
    (text :pointer)
    (size :signed-long)
    (findFlags :SInt16)
    (startTime :signed-long)
    (foundTime (:pointer :TIMEVALUE))
    (foundDuration (:pointer :TIMEVALUE))
    (offset (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextMediaHiliteTextSample()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TextMediaHiliteTextSample" 
   ((mh (:pointer :ComponentInstanceRecord))
    (sampleTime :signed-long)
    (hiliteStart :SInt16)
    (hiliteEnd :SInt16)
    (rgbHiliteColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(defconstant $dropShadowOffsetType :|drpo|)
(defconstant $dropShadowTranslucencyType :|drpt|)
; 
;  *  TextMediaSetTextSampleData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TextMediaSetTextSampleData" 
   ((mh (:pointer :ComponentInstanceRecord))
    (data :pointer)
    (dataType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; ************************
; * Sprite Media routines
; *************************
;  flags for sprite hit test routines 

(defconstant $spriteHitTestBounds 1)            ;     point must only be within sprite's bounding box

(defconstant $spriteHitTestImage 2)             ;   point must be within the shape of the sprite's image

(defconstant $spriteHitTestInvisibleSprites 4)  ;   invisible sprites may be hit tested

(defconstant $spriteHitTestIsClick 8)           ;   for codecs that want mouse events

(defconstant $spriteHitTestLocInDisplayCoordinates 16);     set if you want to pass a display coordiate point to SpriteHitTest
;  set if you want to override each sprites hittestable property as true

(defconstant $spriteHitTestTreatAllSpritesAsHitTestable 32)
;  atom types for sprite media 

(defconstant $kSpriteAtomType :|sprt|)
(defconstant $kSpriteImagesContainerAtomType :|imct|)
(defconstant $kSpriteImageAtomType :|imag|)
(defconstant $kSpriteImageDataAtomType :|imda|)
(defconstant $kSpriteImageDataRefAtomType :|imre|)
(defconstant $kSpriteImageDataRefTypeAtomType :|imrt|)
(defconstant $kSpriteImageGroupIDAtomType :|imgr|)
(defconstant $kSpriteImageRegistrationAtomType :|imrg|)
(defconstant $kSpriteImageDefaultImageIndexAtomType :|defi|)
(defconstant $kSpriteSharedDataAtomType :|dflt|)
(defconstant $kSpriteNameAtomType :|name|)
(defconstant $kSpriteImageNameAtomType :|name|)
(defconstant $kSpriteUsesImageIDsAtomType :|uses|);  leaf data is an array of QTAtomID's, one per image used

(defconstant $kSpriteBehaviorsAtomType :|beha|)
(defconstant $kSpriteImageBehaviorAtomType :|imag|)
(defconstant $kSpriteCursorBehaviorAtomType :|crsr|)
(defconstant $kSpriteStatusStringsBehaviorAtomType :|sstr|)
(defconstant $kSpriteVariablesContainerAtomType :|vars|)
(defconstant $kSpriteStringVariableAtomType :|strv|)
(defconstant $kSpriteFloatingPointVariableAtomType :|flov|)
(defrecord QTRuntimeSpriteDescStruct
   (version :signed-long)                       ;  set to zero
   (spriteID :signed-long)
   (imageIndex :SInt16)
   (matrix :MatrixRecord)
   (visible :SInt16)
   (layer :SInt16)
   (graphicsMode :ModifierTrackGraphicsModeRecord)
   (actionHandlingSpriteID :signed-long)
)

;type name? (%define-record :QTRuntimeSpriteDescStruct (find-record-descriptor ':QTRuntimeSpriteDescStruct))

(def-mactype :QTRuntimeSpriteDescPtr (find-mactype '(:pointer :QTRuntimeSpriteDescStruct)))
; 
;    when filling in QTSpriteButtonBehaviorStruct values -1 may be used to indicate that
;    the state transition does not change the property
; 
(defrecord QTSpriteButtonBehaviorStruct
   (notOverNotPressedStateID :signed-long)
   (overNotPressedStateID :signed-long)
   (overPressedStateID :signed-long)
   (notOverPressedStateID :signed-long)
)

;type name? (%define-record :QTSpriteButtonBehaviorStruct (find-record-descriptor ':QTSpriteButtonBehaviorStruct))

(def-mactype :QTSpriteButtonBehaviorPtr (find-mactype '(:pointer :QTSpriteButtonBehaviorStruct)))
; 
;  *  SpriteMediaSetProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaSetProperty" 
   ((mh (:pointer :ComponentInstanceRecord))
    (spriteIndex :SInt16)
    (propertyType :signed-long)
    (propertyValue :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaGetProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaGetProperty" 
   ((mh (:pointer :ComponentInstanceRecord))
    (spriteIndex :SInt16)
    (propertyType :signed-long)
    (propertyValue :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaHitTestSprites()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaHitTestSprites" 
   ((mh (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
    (loc :Point)
    (spriteHitIndex (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaCountSprites()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaCountSprites" 
   ((mh (:pointer :ComponentInstanceRecord))
    (numSprites (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaCountImages()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaCountImages" 
   ((mh (:pointer :ComponentInstanceRecord))
    (numImages (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaGetIndImageDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaGetIndImageDescription" 
   ((mh (:pointer :ComponentInstanceRecord))
    (imageIndex :SInt16)
    (imageDescription (:Handle :ImageDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaGetDisplayedSampleNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaGetDisplayedSampleNumber" 
   ((mh (:pointer :ComponentInstanceRecord))
    (sampleNum (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaGetSpriteName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaGetSpriteName" 
   ((mh (:pointer :ComponentInstanceRecord))
    (spriteID :signed-long)
    (spriteName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaGetImageName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaGetImageName" 
   ((mh (:pointer :ComponentInstanceRecord))
    (imageIndex :SInt16)
    (imageName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaSetSpriteProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaSetSpriteProperty" 
   ((mh (:pointer :ComponentInstanceRecord))
    (spriteID :signed-long)
    (propertyType :signed-long)
    (propertyValue :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaGetSpriteProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaGetSpriteProperty" 
   ((mh (:pointer :ComponentInstanceRecord))
    (spriteID :signed-long)
    (propertyType :signed-long)
    (propertyValue :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaHitTestAllSprites()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaHitTestAllSprites" 
   ((mh (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
    (loc :Point)
    (spriteHitID (:pointer :QTATOMID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaHitTestOneSprite()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaHitTestOneSprite" 
   ((mh (:pointer :ComponentInstanceRecord))
    (spriteID :signed-long)
    (flags :signed-long)
    (loc :Point)
    (wasHit (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaSpriteIndexToID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaSpriteIndexToID" 
   ((mh (:pointer :ComponentInstanceRecord))
    (spriteIndex :SInt16)
    (spriteID (:pointer :QTATOMID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaSpriteIDToIndex()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaSpriteIDToIndex" 
   ((mh (:pointer :ComponentInstanceRecord))
    (spriteID :signed-long)
    (spriteIndex (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaGetSpriteActionsForQTEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaGetSpriteActionsForQTEvent" 
   ((mh (:pointer :ComponentInstanceRecord))
    (event (:pointer :QTEventRecord))
    (spriteID :signed-long)
    (container (:pointer :QTATOMCONTAINER))
    (atom (:pointer :QTATOM))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaSetActionVariable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaSetActionVariable" 
   ((mh (:pointer :ComponentInstanceRecord))
    (variableID :signed-long)
    (value (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaGetActionVariable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaGetActionVariable" 
   ((mh (:pointer :ComponentInstanceRecord))
    (variableID :signed-long)
    (value (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaGetIndImageProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SpriteMediaGetIndImageProperty" 
   ((mh (:pointer :ComponentInstanceRecord))
    (imageIndex :SInt16)
    (imagePropertyType :signed-long)
    (imagePropertyValue :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaNewSprite()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_SpriteMediaNewSprite" 
   ((mh (:pointer :ComponentInstanceRecord))
    (newSpriteDesc (:pointer :QTRuntimeSpriteDescStruct))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaDisposeSprite()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_SpriteMediaDisposeSprite" 
   ((mh (:pointer :ComponentInstanceRecord))
    (spriteID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaSetActionVariableToString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_SpriteMediaSetActionVariableToString" 
   ((mh (:pointer :ComponentInstanceRecord))
    (variableID :signed-long)
    (theCString :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaGetActionVariableAsString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_SpriteMediaGetActionVariableAsString" 
   ((mh (:pointer :ComponentInstanceRecord))
    (variableID :signed-long)
    (theCString (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaNewImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_SpriteMediaNewImage" 
   ((mh (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
    (desiredID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaDisposeImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_SpriteMediaDisposeImage" 
   ((mh (:pointer :ComponentInstanceRecord))
    (imageIndex :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaImageIndexToID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_SpriteMediaImageIndexToID" 
   ((mh (:pointer :ComponentInstanceRecord))
    (imageIndex :SInt16)
    (imageID (:pointer :QTATOMID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  SpriteMediaImageIDToIndex()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_SpriteMediaImageIDToIndex" 
   ((mh (:pointer :ComponentInstanceRecord))
    (imageID :signed-long)
    (imageIndex (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; ************************
; * Flash Media routines
; *************************
; 
;  *  FlashMediaSetPan()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_FlashMediaSetPan" 
   ((mh (:pointer :ComponentInstanceRecord))
    (xPercent :SInt16)
    (yPercent :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FlashMediaSetZoom()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_FlashMediaSetZoom" 
   ((mh (:pointer :ComponentInstanceRecord))
    (factor :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FlashMediaSetZoomRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_FlashMediaSetZoomRect" 
   ((mh (:pointer :ComponentInstanceRecord))
    (left :signed-long)
    (top :signed-long)
    (right :signed-long)
    (bottom :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FlashMediaGetRefConBounds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_FlashMediaGetRefConBounds" 
   ((mh (:pointer :ComponentInstanceRecord))
    (refCon :signed-long)
    (left (:pointer :long))
    (top (:pointer :long))
    (right (:pointer :long))
    (bottom (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FlashMediaGetRefConID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_FlashMediaGetRefConID" 
   ((mh (:pointer :ComponentInstanceRecord))
    (refCon :signed-long)
    (refConID (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FlashMediaIDToRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_FlashMediaIDToRefCon" 
   ((mh (:pointer :ComponentInstanceRecord))
    (refConID :signed-long)
    (refCon (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FlashMediaGetDisplayedFrameNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_FlashMediaGetDisplayedFrameNumber" 
   ((mh (:pointer :ComponentInstanceRecord))
    (flashFrameNumber (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FlashMediaFrameNumberToMovieTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_FlashMediaFrameNumberToMovieTime" 
   ((mh (:pointer :ComponentInstanceRecord))
    (flashFrameNumber :signed-long)
    (movieTime (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FlashMediaFrameLabelToMovieTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_FlashMediaFrameLabelToMovieTime" 
   ((mh (:pointer :ComponentInstanceRecord))
    (theLabel :pointer)
    (movieTime (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FlashMediaGetFlashVariable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_FlashMediaGetFlashVariable" 
   ((mh (:pointer :ComponentInstanceRecord))
    (path (:pointer :char))
    (name (:pointer :char))
    (theVariableCStringOut (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FlashMediaSetFlashVariable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_FlashMediaSetFlashVariable" 
   ((mh (:pointer :ComponentInstanceRecord))
    (path (:pointer :char))
    (name (:pointer :char))
    (value (:pointer :char))
    (updateFocus :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FlashMediaDoButtonActions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_FlashMediaDoButtonActions" 
   ((mh (:pointer :ComponentInstanceRecord))
    (path (:pointer :char))
    (buttonID :signed-long)
    (transition :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  FlashMediaGetSupportedSwfVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_FlashMediaGetSupportedSwfVersion" 
   ((mh (:pointer :ComponentInstanceRecord))
    (swfVersion (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  sample format atoms

(defconstant $kMovieMediaDataReference :|mmdr|) ;  data reference

(defconstant $kMovieMediaDefaultDataReferenceID :|ddri|);  atom id

(defconstant $kMovieMediaSlaveTime :|slti|)     ;  boolean

(defconstant $kMovieMediaSlaveAudio :|slau|)    ;  boolean

(defconstant $kMovieMediaSlaveGraphicsMode :|slgr|);  boolean

(defconstant $kMovieMediaAutoPlay :|play|)      ;  boolean

(defconstant $kMovieMediaLoop :|loop|)          ;  UInt8 (0=no loop, 1=loop, 2=palindrome loop)

(defconstant $kMovieMediaUseMIMEType :|mime|)   ;  string indicating the MIME type to use for the dataref (usually not required)

(defconstant $kMovieMediaTitle :|titl|)         ;  string of the media's title (tooltips)

(defconstant $kMovieMediaAltText :|altt|)       ;  string of alternate text if media isn't loaded

(defconstant $kMovieMediaClipBegin :|clpb|)     ;  MovieMediaTimeRecord of start time of embedded media

(defconstant $kMovieMediaClipDuration :|clpd|)  ;  MovieMediaTimeRecord of duration of embedded media

(defconstant $kMovieMediaRegionAtom :|regi|)    ;  contains subatoms that describe layout

(defconstant $kMovieMediaSlaveTrackDuration :|sltr|);  Boolean indicating that media handler should adjust track and media based on actual embedded movie duration

(defconstant $kMovieMediaEnableFrameStepping :|enfs|);  boolean. if true stepping on external movie steps frames within embedded movie.

(defconstant $kMovieMediaBackgroundColor :|bkcl|);  RGBColor.

(defconstant $kMovieMediaPrerollTime :|prer|)   ;  SInt32 indicating preroll time

;  fit types

(defconstant $kMovieMediaFitNone 0)
(defconstant $kMovieMediaFitScroll :|scro|)
(defconstant $kMovieMediaFitClipIfNecessary :|hidd|)
(defconstant $kMovieMediaFitFill :|fill|)
(defconstant $kMovieMediaFitMeet :|meet|)
(defconstant $kMovieMediaFitSlice :|slic|)
;  sub atoms for region atom

(defconstant $kMovieMediaSpatialAdjustment :|fit |);  OSType from kMovieMediaFit*

(defconstant $kMovieMediaRectangleAtom :|rect|)
(defconstant $kMovieMediaTop :|top |)
(defconstant $kMovieMediaLeft :|left|)
(defconstant $kMovieMediaWidth :|wd  |)
(defconstant $kMovieMediaHeight :|ht  |)
;  contained movie properties

(defconstant $kMoviePropertyDuration :|dura|)   ;  TimeValue *

(defconstant $kMoviePropertyTimeScale :|tims|)  ;  TimeValue *

(defconstant $kMoviePropertyTime :|timv|)       ;  TimeValue *

(defconstant $kMoviePropertyNaturalBounds :|natb|);  Rect *

(defconstant $kMoviePropertyMatrix :|mtrx|)     ;  Matrix *

(defconstant $kMoviePropertyTrackList :|tlst|)  ;  long ***


(defconstant $kTrackPropertyMediaType :|mtyp|)  ;  OSType

(defconstant $kTrackPropertyInstantiation :|inst|);  MovieMediaInstantiationInfoRecord

(defrecord MovieMediaTimeRecord
   (time :wide)
   (scale :signed-long)
)

;type name? (%define-record :MovieMediaTimeRecord (find-record-descriptor ':MovieMediaTimeRecord))
(defrecord MovieMediaInstantiationInfoRecord
   (immediately :Boolean)
   (pad :Boolean)
   (bitRate :SInt32)
)

;type name? (%define-record :MovieMediaInstantiationInfoRecord (find-record-descriptor ':MovieMediaInstantiationInfoRecord))
; ************************
; * Movie Media routines
; *************************
; 
;  *  MovieMediaGetChildDoMCActionCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_MovieMediaGetChildDoMCActionCallback" 
   ((mh (:pointer :ComponentInstanceRecord))
    (doMCActionCallbackProc (:pointer :DOMCACTIONUPP))
    (refcon (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieMediaGetDoMCActionCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_MovieMediaGetDoMCActionCallback" 
   ((mh (:pointer :ComponentInstanceRecord))
    (doMCActionCallbackProc (:pointer :DOMCACTIONUPP))
    (refcon (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieMediaGetCurrentMovieProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_MovieMediaGetCurrentMovieProperty" 
   ((mh (:pointer :ComponentInstanceRecord))
    (whichProperty :OSType)
    (value :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieMediaGetCurrentTrackProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_MovieMediaGetCurrentTrackProperty" 
   ((mh (:pointer :ComponentInstanceRecord))
    (trackID :signed-long)
    (whichProperty :OSType)
    (value :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieMediaGetChildMovieDataReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_MovieMediaGetChildMovieDataReference" 
   ((mh (:pointer :ComponentInstanceRecord))
    (dataRefID :signed-long)
    (dataRefIndex :SInt16)
    (dataRefType (:pointer :OSType))
    (dataRef (:pointer :Handle))
    (dataRefIDOut (:pointer :QTATOMID))
    (dataRefIndexOut (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieMediaSetChildMovieDataReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_MovieMediaSetChildMovieDataReference" 
   ((mh (:pointer :ComponentInstanceRecord))
    (dataRefID :signed-long)
    (dataRefType :OSType)
    (dataRef :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieMediaLoadChildMovieFromDataReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_MovieMediaLoadChildMovieFromDataReference" 
   ((mh (:pointer :ComponentInstanceRecord))
    (dataRefID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; ************************
; * 3D Media routines
; *************************
; 
;  *  Media3DGetNamedObjectList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_Media3DGetNamedObjectList" 
   ((mh (:pointer :ComponentInstanceRecord))
    (objectList (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  Media3DGetRendererList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_Media3DGetRendererList" 
   ((mh (:pointer :ComponentInstanceRecord))
    (rendererList (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  Media3DGetCurrentGroup()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_Media3DGetCurrentGroup" 
   ((mh (:pointer :ComponentInstanceRecord))
    (group :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  Media3DTranslateNamedObjectTo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_Media3DTranslateNamedObjectTo" 
   ((mh (:pointer :ComponentInstanceRecord))
    (objectName (:pointer :char))
    (x :signed-long)
    (y :signed-long)
    (z :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  Media3DScaleNamedObjectTo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_Media3DScaleNamedObjectTo" 
   ((mh (:pointer :ComponentInstanceRecord))
    (objectName (:pointer :char))
    (xScale :signed-long)
    (yScale :signed-long)
    (zScale :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  Media3DRotateNamedObjectTo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_Media3DRotateNamedObjectTo" 
   ((mh (:pointer :ComponentInstanceRecord))
    (objectName (:pointer :char))
    (xDegrees :signed-long)
    (yDegrees :signed-long)
    (zDegrees :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  Media3DSetCameraData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_Media3DSetCameraData" 
   ((mh (:pointer :ComponentInstanceRecord))
    (cameraData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  Media3DGetCameraData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_Media3DGetCameraData" 
   ((mh (:pointer :ComponentInstanceRecord))
    (cameraData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  Media3DSetCameraAngleAspect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_Media3DSetCameraAngleAspect" 
   ((mh (:pointer :ComponentInstanceRecord))
    (fov :single-float)
    (aspectRatioXToY :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  Media3DGetCameraAngleAspect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_Media3DGetCameraAngleAspect" 
   ((mh (:pointer :ComponentInstanceRecord))
    (fov (:pointer :QTFLOATSINGLE))
    (aspectRatioXToY (:pointer :QTFLOATSINGLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  Media3DSetCameraRange()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_Media3DSetCameraRange" 
   ((mh (:pointer :ComponentInstanceRecord))
    (tQ3CameraRange :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  Media3DGetCameraRange()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_Media3DGetCameraRange" 
   ((mh (:pointer :ComponentInstanceRecord))
    (tQ3CameraRange :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  Media3DGetViewObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_Media3DGetViewObject" 
   ((mh (:pointer :ComponentInstanceRecord))
    (tq3viewObject :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; ***************************************
; *                                       *
; *   M O V I E   C O N T R O L L E R     *
; *                                       *
; ***************************************

(defconstant $MovieControllerComponentType :|play|)

(defconstant $kMovieControllerQTVRFlag 1)
(defconstant $kMovieControllerDontDisplayToUser 2)

(def-mactype :MovieController (find-mactype ':ComponentInstance))

(def-mactype :MovieControllerPtr (find-mactype '(:handle :ComponentInstanceRecord)))

(defconstant $mcActionIdle 1)                   ;  no param

(defconstant $mcActionDraw 2)                   ;  param is WindowRef

(defconstant $mcActionActivate 3)               ;  no param

(defconstant $mcActionDeactivate 4)             ;  no param

(defconstant $mcActionMouseDown 5)              ;  param is pointer to EventRecord

(defconstant $mcActionKey 6)                    ;  param is pointer to EventRecord

(defconstant $mcActionPlay 8)                   ;  param is Fixed, play rate

(defconstant $mcActionGoToTime 12)              ;  param is TimeRecord

(defconstant $mcActionSetVolume 14)             ;  param is a short

(defconstant $mcActionGetVolume 15)             ;  param is pointer to a short

(defconstant $mcActionStep 18)                  ;  param is number of steps (short)

(defconstant $mcActionSetLooping 21)            ;  param is Boolean

(defconstant $mcActionGetLooping 22)            ;  param is pointer to a Boolean

(defconstant $mcActionSetLoopIsPalindrome 23)   ;  param is Boolean

(defconstant $mcActionGetLoopIsPalindrome 24)   ;  param is pointer to a Boolean

(defconstant $mcActionSetGrowBoxBounds 25)      ;  param is a Rect

(defconstant $mcActionControllerSizeChanged 26) ;  no param

(defconstant $mcActionSetSelectionBegin 29)     ;  param is TimeRecord

(defconstant $mcActionSetSelectionDuration 30)  ;  param is TimeRecord, action only taken on set-duration

(defconstant $mcActionSetKeysEnabled 32)        ;  param is Boolean

(defconstant $mcActionGetKeysEnabled 33)        ;  param is pointer to Boolean

(defconstant $mcActionSetPlaySelection 34)      ;  param is Boolean

(defconstant $mcActionGetPlaySelection 35)      ;  param is pointer to Boolean

(defconstant $mcActionSetUseBadge 36)           ;  param is Boolean

(defconstant $mcActionGetUseBadge 37)           ;  param is pointer to Boolean

(defconstant $mcActionSetFlags 38)              ;  param is long of flags

(defconstant $mcActionGetFlags 39)              ;  param is pointer to a long of flags

(defconstant $mcActionSetPlayEveryFrame 40)     ;  param is Boolean

(defconstant $mcActionGetPlayEveryFrame 41)     ;  param is pointer to Boolean

(defconstant $mcActionGetPlayRate 42)           ;  param is pointer to Fixed

(defconstant $mcActionShowBalloon 43)           ;  param is a pointer to a boolean. set to false to stop balloon

(defconstant $mcActionBadgeClick 44)            ;  param is pointer to Boolean. set to false to ignore click

(defconstant $mcActionMovieClick 45)            ;  param is pointer to event record. change "what" to nullEvt to kill click

(defconstant $mcActionSuspend 46)               ;  no param

(defconstant $mcActionResume 47)                ;  no param

(defconstant $mcActionSetControllerKeysEnabled 48);  param is Boolean

(defconstant $mcActionGetTimeSliderRect 49)     ;  param is pointer to rect

(defconstant $mcActionMovieEdited 50)           ;  no param

(defconstant $mcActionGetDragEnabled 51)        ;  param is pointer to Boolean

(defconstant $mcActionSetDragEnabled 52)        ;  param is Boolean

(defconstant $mcActionGetSelectionBegin 53)     ;  param is TimeRecord

(defconstant $mcActionGetSelectionDuration 54)  ;  param is TimeRecord

(defconstant $mcActionPrerollAndPlay 55)        ;  param is Fixed, play rate

(defconstant $mcActionGetCursorSettingEnabled 56);  param is pointer to Boolean

(defconstant $mcActionSetCursorSettingEnabled 57);  param is Boolean

(defconstant $mcActionSetColorTable 58)         ;  param is CTabHandle

(defconstant $mcActionLinkToURL 59)             ;  param is Handle to URL

(defconstant $mcActionCustomButtonClick 60)     ;  param is pointer to EventRecord

(defconstant $mcActionForceTimeTableUpdate 61)  ;  no param

(defconstant $mcActionSetControllerTimeLimits 62);  param is pointer to 2 time values min/max. do no send this message to controller. used internally only.

(defconstant $mcActionExecuteAllActionsForQTEvent 63);  param is ResolvedQTEventSpecPtr

(defconstant $mcActionExecuteOneActionForQTEvent 64);  param is ResolvedQTEventSpecPtr

(defconstant $mcActionAdjustCursor 65)          ;  param is pointer to EventRecord (WindowRef is in message parameter)

(defconstant $mcActionUseTrackForTimeTable 66)  ;  param is pointer to {long trackID; Boolean useIt}. do not send this message to controller. 

(defconstant $mcActionClickAndHoldPoint 67)     ;  param is point (local coordinates). return true if point has click & hold action (e.g., VR object movie autorotate spot)

(defconstant $mcActionShowMessageString 68)     ;  param is a StringPtr

(defconstant $mcActionShowStatusString 69)      ;  param is a QTStatusStringPtr

(defconstant $mcActionGetExternalMovie 70)      ;  param is a QTGetExternalMoviePtr

(defconstant $mcActionGetChapterTime 71)        ;  param is a QTGetChapterTimePtr

(defconstant $mcActionPerformActionList 72)     ;  param is a QTAtomSpecPtr

(defconstant $mcActionEvaluateExpression 73)    ;  param is a QTEvaluateExpressionPtr

(defconstant $mcActionFetchParameterAs 74)      ;  param is a QTFetchParameterAsPtr

(defconstant $mcActionGetCursorByID 75)         ;  param is a QTGetCursorByIDPtr

(defconstant $mcActionGetNextURL 76)            ;  param is a Handle to URL

(defconstant $mcActionMovieChanged 77)
(defconstant $mcActionDoScript 78)              ;  param is QTDoScriptPtr

(defconstant $mcActionRestartAtTime 79)         ;  param is QTResartAtTimePtr

(defconstant $mcActionGetIndChapter 80)         ;  param is QTChapterInfoPtr

(defconstant $mcActionLinkToURLExtended 81)     ;  param is QTAtomContainer as used by QTParseHREF

(defconstant $mcActionSetVolumeStep 82)         ;  param is short containing amount to step volume via arrow keys - default = 64

(defconstant $mcActionAutoPlay 83)              ;  param is Fixed, play rate

(defconstant $mcActionPauseToBuffer 84)         ;  param is Fixed, play rate on restart

(defconstant $mcActionAppMessageReceived 85)    ;  param is a long, application message

(defconstant $mcActionMovieFinished 86)         ;  no param

(defconstant $mcActionEvaluateExpressionWithType 89);  param is a QTEvaluateExpressionWithTypePtr

(defconstant $mcActionGetMovieName 90)          ;  param is a p String Handle

(defconstant $mcActionGetMovieID 91)            ;  param is pointer to long

(defconstant $mcActionGetMovieActive 92)        ;  param is pointer to Boolean

(defconstant $mcActionGetKeyboardFocus 93)      ;  param is QTKeyboardFocusPtr

(defconstant $mcActionSetKeyboardFocus 94)      ;  param is QTKeyboardFocusPtr

(defconstant $mcActionAddActionNotification 95) ;  param is QTMCActionNotificationPtr

(defconstant $mcActionRemoveActionNotification 96);  param is QTMCActionNotificationPtr

(defconstant $mcActionKeyUp 97)                 ;  param is pointer to EventRecord 

(defconstant $mcActionGetConnectionStatus 98)   ;  param is QTConnectionStatusPtr

(defconstant $mcActionChapterListChanged 99)    ;  no param 

(defconstant $mcActionMovieLoadStateChanged 100);  param is SInt32, new load state

(defconstant $mcActionEditStateChanged 101)     ;  param is a Boolean, editing enabled?


(def-mactype :mcAction (find-mactype ':SInt16))

(defconstant $mcFlagSuppressMovieFrame 1)
(defconstant $mcFlagSuppressStepButtons 2)
(defconstant $mcFlagSuppressSpeakerButton 4)
(defconstant $mcFlagsUseWindowPalette 8)
(defconstant $mcFlagsDontInvalidate 16)
(defconstant $mcFlagsUseCustomButton 32)

(defconstant $mcPositionDontInvalidate 32)

(def-mactype :mcFlags (find-mactype ':UInt32))

(defconstant $kMCIEEnabledButtonPicture 1)
(defconstant $kMCIEDisabledButtonPicture 2)
(defconstant $kMCIEDepressedButtonPicture 3)
(defconstant $kMCIEEnabledSizeBoxPicture 4)
(defconstant $kMCIEDisabledSizeBoxPicture 5)
(defconstant $kMCIEEnabledUnavailableButtonPicture 6)
(defconstant $kMCIEDisabledUnavailableButtonPicture 7)
(defconstant $kMCIESoundSlider #x80)
(defconstant $kMCIESoundThumb #x81)
(defconstant $kMCIEColorTable #x100)
(defconstant $kMCIEIsFlatAppearance #x101)
(defconstant $kMCIEDoButtonIconsDropOnDepress #x102)

(def-mactype :MCInterfaceElement (find-mactype ':UInt32))

(def-mactype :MCActionFilterProcPtr (find-mactype ':pointer)); (MovieController mc , short * action , void * params)

(def-mactype :MCActionFilterWithRefConProcPtr (find-mactype ':pointer)); (MovieController mc , short action , void * params , long refCon)

(def-mactype :MCActionNotificationProcPtr (find-mactype ':pointer)); (MovieController mc , short action , void * params , UInt32 inFlags , UInt32 * outFlags , void * refCon)

(def-mactype :MCActionFilterUPP (find-mactype '(:pointer :OpaqueMCActionFilterProcPtr)))

(def-mactype :MCActionFilterWithRefConUPP (find-mactype '(:pointer :OpaqueMCActionFilterWithRefConProcPtr)))

(def-mactype :MCActionNotificationUPP (find-mactype '(:pointer :OpaqueMCActionNotificationProcPtr)))
; 
;     menu related stuff
; 

(defconstant $mcInfoUndoAvailable 1)
(defconstant $mcInfoCutAvailable 2)
(defconstant $mcInfoCopyAvailable 4)
(defconstant $mcInfoPasteAvailable 8)
(defconstant $mcInfoClearAvailable 16)
(defconstant $mcInfoHasSound 32)
(defconstant $mcInfoIsPlaying 64)
(defconstant $mcInfoIsLooping #x80)
(defconstant $mcInfoIsInPalindrome #x100)
(defconstant $mcInfoEditingEnabled #x200)
(defconstant $mcInfoMovieIsInteractive #x400)
;  menu item codes

(defconstant $mcMenuUndo 1)
(defconstant $mcMenuCut 3)
(defconstant $mcMenuCopy 4)
(defconstant $mcMenuPaste 5)
(defconstant $mcMenuClear 6)
;  messages to the application via mcActionAppMessageReceived

(defconstant $kQTAppMessageSoftwareChanged 1)   ;  notification to app that installed QuickTime software has been updated

(defconstant $kQTAppMessageWindowCloseRequested 3);  request for app to close window containing movie controller

(defconstant $kQTAppMessageExitFullScreenRequested 4);  request for app to turn off full screen mode if active

(defconstant $kQTAppMessageDisplayChannels 5)   ;  request for app to display the channel UI

(defconstant $kQTAppMessageEnterFullScreenRequested 6);  request for app to turn on full screen mode

;  structures used as mcActionFilterProc params
(defrecord QTStatusStringRecord
   (stringTypeFlags :signed-long)
   (statusString (:pointer :char))
)

;type name? (%define-record :QTStatusStringRecord (find-record-descriptor ':QTStatusStringRecord))

(def-mactype :QTStatusStringPtr (find-mactype '(:pointer :QTStatusStringRecord)))
(defrecord QTGetExternalMovieRecord
   (targetType :signed-long)                    ;  set to kTargetMovieName or kTargetMovieID
   (movieName (:pointer :UInt8))
   (movieID :signed-long)
   (theMovie (:pointer :Movie))
   (theController (:Handle :ComponentInstanceRecord))
)

;type name? (%define-record :QTGetExternalMovieRecord (find-record-descriptor ':QTGetExternalMovieRecord))

(def-mactype :QTGetExternalMoviePtr (find-mactype '(:pointer :QTGetExternalMovieRecord)))
(defrecord QTGetChapterTimeRecord
   (chapterName (:pointer :UInt8))
   (chapterTime :TimeRecord)
)

;type name? (%define-record :QTGetChapterTimeRecord (find-record-descriptor ':QTGetChapterTimeRecord))

(def-mactype :QTGetChapterTimePtr (find-mactype '(:pointer :QTGetChapterTimeRecord)))
(defrecord QTChapterInfoRecord
   (index :signed-long)                         ;  first chapter has index of 1
   (time :signed-long)                          ;  -1 if no more chapters available
   (name (:string 255))
)

;type name? (%define-record :QTChapterInfoRecord (find-record-descriptor ':QTChapterInfoRecord))

(def-mactype :QTChapterInfoPtr (find-mactype '(:pointer :QTChapterInfoRecord)))
(defrecord QTEvaluateExpressionRecord
   (expressionSpec :QTAtomSpec)
   (expressionResult (:pointer :float))
)

;type name? (%define-record :QTEvaluateExpressionRecord (find-record-descriptor ':QTEvaluateExpressionRecord))

(def-mactype :QTEvaluateExpressionPtr (find-mactype '(:pointer :QTEvaluateExpressionRecord)))
(defrecord QTEvaluateExpressionWithTypeRecord
   (recordSize :signed-long)                    ;  Size of structure (fill in at allocation) 
   (expressionSpec :QTAtomSpec)
   (expressionResult (:pointer :float))
   (fetchAsType :signed-long)
   (nonNumericResult :Handle)
                                                ;  Current size is 24 
)

;type name? (%define-record :QTEvaluateExpressionWithTypeRecord (find-record-descriptor ':QTEvaluateExpressionWithTypeRecord))

(def-mactype :QTEvaluateExpressionWithTypePtr (find-mactype '(:pointer :QTEvaluateExpressionWithTypeRecord)))
(defrecord QTFetchParameterAsRecord
   (paramListSpec :QTAtomSpec)
   (paramIndex :signed-long)
   (paramType :signed-long)
   (allowedFlags :signed-long)
   (min :pointer)
   (max :pointer)
   (currentValue :pointer)
   (newValue :pointer)
   (isUnsignedValue :Boolean)
)

;type name? (%define-record :QTFetchParameterAsRecord (find-record-descriptor ':QTFetchParameterAsRecord))

(def-mactype :QTFetchParameterAsPtr (find-mactype '(:pointer :QTFetchParameterAsRecord)))
(defrecord QTGetCursorByIDRecord
   (cursorID :SInt16)
   (colorCursorData :Handle)
   (reserved1 :signed-long)
)

;type name? (%define-record :QTGetCursorByIDRecord (find-record-descriptor ':QTGetCursorByIDRecord))

(def-mactype :QTGetCursorByIDPtr (find-mactype '(:pointer :QTGetCursorByIDRecord)))
(defrecord QTDoScriptRecord
   (scriptTypeFlags :signed-long)
   (command (:pointer :char))
   (arguments (:pointer :char))
)

;type name? (%define-record :QTDoScriptRecord (find-record-descriptor ':QTDoScriptRecord))

(def-mactype :QTDoScriptPtr (find-mactype '(:pointer :QTDoScriptRecord)))
(defrecord QTRestartAtTimeRecord
   (startTime :signed-long)                     ;  time scale is the movie timescale
   (rate :signed-long)                          ;  if rate is zero, the movie's current rate is maintained
)

;type name? (%define-record :QTRestartAtTimeRecord (find-record-descriptor ':QTRestartAtTimeRecord))

(def-mactype :QTRestartAtTimePtr (find-mactype '(:pointer :QTRestartAtTimeRecord)))
;  values for paramType field of QTFetchParameterAsRecord

(defconstant $kFetchAsBooleanPtr 1)
(defconstant $kFetchAsShortPtr 2)
(defconstant $kFetchAsLongPtr 3)
(defconstant $kFetchAsMatrixRecordPtr 4)
(defconstant $kFetchAsModifierTrackGraphicsModeRecord 5)
(defconstant $kFetchAsHandle 6)
(defconstant $kFetchAsStr255 7)
(defconstant $kFetchAsFloatPtr 8)
(defconstant $kFetchAsPointPtr 9)
(defconstant $kFetchAsNewAtomContainer 10)
(defconstant $kFetchAsQTEventRecordPtr 11)
(defconstant $kFetchAsFixedPtr 12)
(defconstant $kFetchAsSetControllerValuePtr 13)
(defconstant $kFetchAsRgnHandle 14)             ;  flipped to native

(defconstant $kFetchAsComponentDescriptionPtr 15)
(defconstant $kFetchAsCString 16)

(defconstant $kQTCursorOpenHand -19183)
(defconstant $kQTCursorClosedHand -19182)
(defconstant $kQTCursorPointingHand -19181)
(defconstant $kQTCursorRightArrow -19180)
(defconstant $kQTCursorLeftArrow -19179)
(defconstant $kQTCursorDownArrow -19178)
(defconstant $kQTCursorUpArrow -19177)
(defconstant $kQTCursorIBeam -19176)
;  keyboard focus items

(defconstant $kKeyboardAllowFocus 1)
(defconstant $kKeyboardHaveFocus 2)
(defconstant $kKeyboardValidate 4)

(defconstant $kRefConNavigateClick :|clik|)
(defrecord QTKeyboardFocusRecord
   (recordSize :signed-long)                    ;  -> size of structure
   (navigation :signed-long)                    ;  -> same as in MediaNavigateTargetRefCon
   (focusRefCon :signed-long)                   ;  <-> refcon
   (focusFlags :SInt16)                         ;  <-> flags from kKeyboard... enum 
)

;type name? (%define-record :QTKeyboardFocusRecord (find-record-descriptor ':QTKeyboardFocusRecord))

(def-mactype :QTKeyboardFocusPtr (find-mactype '(:pointer :QTKeyboardFocusRecord)))

(defconstant $kQTMCActionNotifyBefore 1)
(defconstant $kQTMCActionNotifyAfter 2)
(defconstant $kQTMCActionNotifyParamChanged #x100)
(defconstant $kQTMCActionNotifyCancelled #x200)
(defconstant $kQTMCActionNotifyUserFilterCancelled #x400)
(defconstant $kQTMCActionNotifySignature :|noti|)
(defrecord QTMCActionNotificationRecord
   (returnSignature :OSType)                    ;  Set to zero when passed to movieController, set to 'noti' if mcActionAddActionNotification is implemented
   (notifyAction (:pointer :OpaqueMCActionNotificationProcPtr));  Function to be called at action time
   (refcon :pointer)                            ;  Something to pass to the action function
   (flags :UInt32)                              ;  Option flags
)

;type name? (%define-record :QTMCActionNotificationRecord (find-record-descriptor ':QTMCActionNotificationRecord))

(def-mactype :QTMCActionNotificationPtr (find-mactype '(:pointer :QTMCActionNotificationRecord)))
(defrecord QTConnectionStatusRecord
   (flags :SInt16)
   (error :SInt16)
   (message :Handle)
)

;type name? (%define-record :QTConnectionStatusRecord (find-record-descriptor ':QTConnectionStatusRecord))

(def-mactype :QTConnectionStatusPtr (find-mactype '(:pointer :QTConnectionStatusRecord)))
;  target management 
; 
;  *  MCSetMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCSetMovie" 
   ((mc (:pointer :ComponentInstanceRecord))
    (theMovie (:Handle :MovieType))
    (movieWindow (:pointer :OpaqueWindowPtr))
    (where :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCGetIndMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCGetIndMovie" 
   ((mc (:pointer :ComponentInstanceRecord))
    (index :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MovieType)
() )
; #define MCGetMovie(mc) MCGetIndMovie(mc, 0)
; 
;  *  MCRemoveAllMovies()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCRemoveAllMovies" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCRemoveAMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCRemoveAMovie" 
   ((mc (:pointer :ComponentInstanceRecord))
    (m (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCRemoveMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCRemoveMovie" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  event handling etc. 
; 
;  *  MCIsPlayerEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCIsPlayerEvent" 
   ((mc (:pointer :ComponentInstanceRecord))
    (e (:pointer :EventRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  obsolete. use MCSetActionFilterWithRefCon instead. 
; 
;  *  MCSetActionFilter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCSetActionFilter" 
   ((mc (:pointer :ComponentInstanceRecord))
    (blob (:pointer :OpaqueMCActionFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     proc is of the form:
;         Boolean userPlayerFilter(MovieController mc, short *action, void *params) =
;     proc returns TRUE if it handles the action, FALSE if not
;     action is passed as a VAR so that it could be changed by filter
;     this is consistent with the current dialog manager stuff
;     params is any potential parameters that go with the action
;         such as set playback rate to xxx.
; 
; 
;  *  MCDoAction()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCDoAction" 
   ((mc (:pointer :ComponentInstanceRecord))
    (action :SInt16)
    (params :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  state type things 
; 
;  *  MCSetControllerAttached()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCSetControllerAttached" 
   ((mc (:pointer :ComponentInstanceRecord))
    (attach :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCIsControllerAttached()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCIsControllerAttached" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCSetControllerPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCSetControllerPort" 
   ((mc (:pointer :ComponentInstanceRecord))
    (gp (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCGetControllerPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCGetControllerPort" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueGrafPtr)
() )
; 
;  *  MCSetVisible()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCSetVisible" 
   ((mc (:pointer :ComponentInstanceRecord))
    (visible :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCGetVisible()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCGetVisible" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCGetControllerBoundsRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCGetControllerBoundsRect" 
   ((mc (:pointer :ComponentInstanceRecord))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCSetControllerBoundsRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCSetControllerBoundsRect" 
   ((mc (:pointer :ComponentInstanceRecord))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCGetControllerBoundsRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCGetControllerBoundsRgn" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; 
;  *  MCGetWindowRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCGetWindowRgn" 
   ((mc (:pointer :ComponentInstanceRecord))
    (w (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
;  other stuff 
; 
;  *  MCMovieChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCMovieChanged" 
   ((mc (:pointer :ComponentInstanceRecord))
    (m (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     called when the app has changed thing about the movie (like bounding rect) or rate. So that we
;         can update our graphical (and internal) state accordingly.
; 
; 
;  *  MCSetDuration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCSetDuration" 
   ((mc (:pointer :ComponentInstanceRecord))
    (duration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     duration to use for time slider -- will be reset next time MCMovieChanged is called
;         or MCSetMovie is called
; 
; 
;  *  MCGetCurrentTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCGetCurrentTime" 
   ((mc (:pointer :ComponentInstanceRecord))
    (scale (:pointer :TIMESCALE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     returns the time value and the time scale it is on. if there are no movies, the
;         time scale is passed back as 0. scale is an optional parameter
; 
; 
; 
;  *  MCNewAttachedController()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCNewAttachedController" 
   ((mc (:pointer :ComponentInstanceRecord))
    (theMovie (:Handle :MovieType))
    (w (:pointer :OpaqueWindowPtr))
    (where :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     makes theMovie the only movie attached to the controller. makes the controller visible.
;     the window and where parameters are passed a long to MCSetMovie and behave as
;     described there
; 
; 
;  *  MCDraw()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCDraw" 
   ((mc (:pointer :ComponentInstanceRecord))
    (w (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCActivate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCActivate" 
   ((mc (:pointer :ComponentInstanceRecord))
    (w (:pointer :OpaqueWindowPtr))
    (activate :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCIdle" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCKey()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCKey" 
   ((mc (:pointer :ComponentInstanceRecord))
    (key :SInt8)
    (modifiers :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCClick()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCClick" 
   ((mc (:pointer :ComponentInstanceRecord))
    (w (:pointer :OpaqueWindowPtr))
    (where :Point)
    (when :signed-long)
    (modifiers :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     calls for editing
; 
; 
;  *  MCEnableEditing()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCEnableEditing" 
   ((mc (:pointer :ComponentInstanceRecord))
    (enabled :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCIsEditingEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCIsEditingEnabled" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  MCCopy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCCopy" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MovieType)
() )
; 
;  *  MCCut()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCCut" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MovieType)
() )
; 
;  *  MCPaste()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCPaste" 
   ((mc (:pointer :ComponentInstanceRecord))
    (srcMovie (:Handle :MovieType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCClear()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCClear" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCUndo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCUndo" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  somewhat special stuff
;  
; 
;  *  MCPositionController()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCPositionController" 
   ((mc (:pointer :ComponentInstanceRecord))
    (movieRect (:pointer :Rect))
    (controllerRect (:pointer :Rect))
    (someFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCGetControllerInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCGetControllerInfo" 
   ((mc (:pointer :ComponentInstanceRecord))
    (someFlags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCSetClip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCSetClip" 
   ((mc (:pointer :ComponentInstanceRecord))
    (theClip (:pointer :OpaqueRgnHandle))
    (movieClip (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCGetClip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCGetClip" 
   ((mc (:pointer :ComponentInstanceRecord))
    (theClip (:pointer :RGNHANDLE))
    (movieClip (:pointer :RGNHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCDrawBadge()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCDrawBadge" 
   ((mc (:pointer :ComponentInstanceRecord))
    (movieRgn (:pointer :OpaqueRgnHandle))
    (badgeRgn (:pointer :RGNHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCSetUpEditMenu()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCSetUpEditMenu" 
   ((mc (:pointer :ComponentInstanceRecord))
    (modifiers :signed-long)
    (mh (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCGetMenuString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCGetMenuString" 
   ((mc (:pointer :ComponentInstanceRecord))
    (modifiers :signed-long)
    (item :SInt16)
    (aString (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCSetActionFilterWithRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCSetActionFilterWithRefCon" 
   ((mc (:pointer :ComponentInstanceRecord))
    (blob (:pointer :OpaqueMCActionFilterWithRefConProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCPtInController()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCPtInController" 
   ((mc (:pointer :ComponentInstanceRecord))
    (thePt :Point)
    (inController (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCInvalidate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCInvalidate" 
   ((mc (:pointer :ComponentInstanceRecord))
    (w (:pointer :OpaqueWindowPtr))
    (invalidRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCAdjustCursor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCAdjustCursor" 
   ((mc (:pointer :ComponentInstanceRecord))
    (w (:pointer :OpaqueWindowPtr))
    (where :Point)
    (modifiers :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCGetInterfaceElement()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MCGetInterfaceElement" 
   ((mc (:pointer :ComponentInstanceRecord))
    (whichElement :UInt32)
    (element :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCGetDoActionsProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MCGetDoActionsProc" 
   ((mc (:pointer :ComponentInstanceRecord))
    (doMCActionProc (:pointer :DOMCACTIONUPP))
    (doMCActionRefCon (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCAddMovieSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_MCAddMovieSegment" 
   ((mc (:pointer :ComponentInstanceRecord))
    (srcMovie (:Handle :MovieType))
    (scaled :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCTrimMovieSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_MCTrimMovieSegment" 
   ((mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MCSetIdleManager()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MCSetIdleManager" 
   ((mc (:pointer :ComponentInstanceRecord))
    (im (:pointer :OpaqueIdleManager))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
;  Called (but not implemented) by controllers that derive from the standard movie controller.
;    All controllers except standard movie controller must delegate this call. 

(defconstant $kControllerUnderstandsIdleManagers 1)
; 
;  *  MCSetControllerCapabilities()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MCSetControllerCapabilities" 
   ((mc (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
    (flagsMask :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; ***************************************
; *                                       *
; *       T  I  M  E  B  A  S  E          *
; *                                       *
; ***************************************
; 
;  *  NewTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewTimeBase" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :TimeBaseRecord)
() )
; 
;  *  DisposeTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeTimeBase" 
   ((tb (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTimeBaseTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTimeBaseTime" 
   ((tb (:pointer :TimeBaseRecord))
    (s :signed-long)
    (tr (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SetTimeBaseTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTimeBaseTime" 
   ((tb (:pointer :TimeBaseRecord))
    (tr (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetTimeBaseValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTimeBaseValue" 
   ((tb (:pointer :TimeBaseRecord))
    (t :signed-long)
    (s :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTimeBaseRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTimeBaseRate" 
   ((tb (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SetTimeBaseRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTimeBaseRate" 
   ((tb (:pointer :TimeBaseRecord))
    (r :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTimeBaseStartTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTimeBaseStartTime" 
   ((tb (:pointer :TimeBaseRecord))
    (s :signed-long)
    (tr (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SetTimeBaseStartTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTimeBaseStartTime" 
   ((tb (:pointer :TimeBaseRecord))
    (tr (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTimeBaseStopTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTimeBaseStopTime" 
   ((tb (:pointer :TimeBaseRecord))
    (s :signed-long)
    (tr (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SetTimeBaseStopTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTimeBaseStopTime" 
   ((tb (:pointer :TimeBaseRecord))
    (tr (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTimeBaseFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTimeBaseFlags" 
   ((tb (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetTimeBaseFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTimeBaseFlags" 
   ((tb (:pointer :TimeBaseRecord))
    (timeBaseFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetTimeBaseMasterTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTimeBaseMasterTimeBase" 
   ((slave (:pointer :TimeBaseRecord))
    (master (:pointer :TimeBaseRecord))
    (slaveZero (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTimeBaseMasterTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTimeBaseMasterTimeBase" 
   ((tb (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :TimeBaseRecord)
() )
; 
;  *  SetTimeBaseMasterClock()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTimeBaseMasterClock" 
   ((slave (:pointer :TimeBaseRecord))
    (clockMeister (:pointer :ComponentRecord))
    (slaveZero (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTimeBaseMasterClock()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTimeBaseMasterClock" 
   ((tb (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentInstanceRecord)
() )
; 
;  *  ConvertTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ConvertTime" 
   ((theTime (:pointer :TimeRecord))
    (newBase (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ConvertTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ConvertTimeScale" 
   ((theTime (:pointer :TimeRecord))
    (newScale :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AddTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddTime" 
   ((dst (:pointer :TimeRecord))
    (src (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SubtractTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SubtractTime" 
   ((dst (:pointer :TimeRecord))
    (src (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTimeBaseStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTimeBaseStatus" 
   ((tb (:pointer :TimeBaseRecord))
    (unpinnedTime (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetTimeBaseZero()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetTimeBaseZero" 
   ((tb (:pointer :TimeBaseRecord))
    (zero (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetTimeBaseEffectiveRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetTimeBaseEffectiveRate" 
   ((tb (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GetTimeBaseRateChangeStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_GetTimeBaseRateChangeStatus" 
   ((tb (:pointer :TimeBaseRecord))
    (scale :signed-long)
    (ratedChangedTo (:pointer :Fixed))
    (flags (:pointer :TIMEBASESTATUS))
    (rateChangeTimeBaseTime (:pointer :TimeRecord))
    (rateChangeClockTime (:pointer :TimeRecord))
    (currentClockTime (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  ConvertTimeToClockTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_ConvertTimeToClockTime" 
   ((time (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  *  GetTimeBaseMasterOffsetTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_GetTimeBaseMasterOffsetTimeBase" 
   ((tb (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :TimeBaseRecord)
() )
; 
;  *  SetTimeBaseOffsetTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_SetTimeBaseOffsetTimeBase" 
   ((tb (:pointer :TimeBaseRecord))
    (offsettb (:pointer :TimeBaseRecord))
    (offsetZero (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  AttachTimeBaseToCurrentThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_AttachTimeBaseToCurrentThread" 
   ((tb (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  DetachTimeBaseFromCurrentThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_DetachTimeBaseFromCurrentThread" 
   ((tb (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  GetTimeBaseThreadAttachState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_GetTimeBaseThreadAttachState" 
   ((inTimeBase (:pointer :TimeBaseRecord))
    (outAttachedToCurrentThread (:pointer :Boolean))
    (outAttachedToAnyThread (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; ***************************************
; *                                       *
; *       C  A  L  L  B  A  C  K          *
; *                                       *
; ***************************************
; 
;  *  NewCallBack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_NewCallBack" 
   ((tb (:pointer :TimeBaseRecord))
    (cbType :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :QTCallBackHeader)
() )
; 
;  *  DisposeCallBack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DisposeCallBack" 
   ((cb (:pointer :QTCallBackHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetCallBackType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetCallBackType" 
   ((cb (:pointer :QTCallBackHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetCallBackTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetCallBackTimeBase" 
   ((cb (:pointer :QTCallBackHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :TimeBaseRecord)
() )
; 
;  *  CallMeWhen()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CallMeWhen" 
   ((cb (:pointer :QTCallBackHeader))
    (callBackProc (:pointer :OpaqueQTCallBackProcPtr))
    (refCon :signed-long)
    (param1 :signed-long)
    (param2 :signed-long)
    (param3 :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CancelCallBack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CancelCallBack" 
   ((cb (:pointer :QTCallBackHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ***************************************
; *                                       *
; *       C L O C K   C A L L B A C K     *
; *             S U P P O R T             *
; *                                       *
; ***************************************
; 
;  *  AddCallBackToTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_AddCallBackToTimeBase" 
   ((cb (:pointer :QTCallBackHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveCallBackFromTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_RemoveCallBackFromTimeBase" 
   ((cb (:pointer :QTCallBackHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetFirstCallBack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetFirstCallBack" 
   ((tb (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :QTCallBackHeader)
() )
; 
;  *  GetNextCallBack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetNextCallBack" 
   ((cb (:pointer :QTCallBackHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :QTCallBackHeader)
() )
; 
;  *  ExecuteCallBack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ExecuteCallBack" 
   ((cb (:pointer :QTCallBackHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ***************************************
; *                                       *
; *   M O V I E  P R O P E R T I E S      *
; *                                       *
; ***************************************

(def-mactype :QTMoviePropertyListenerProcPtr (find-mactype ':pointer)); (Movie inMovie , QTPropertyClass inPropClass , QTPropertyID inPropID , void * inUserData)

(def-mactype :QTMoviePropertyListenerUPP (find-mactype '(:pointer :OpaqueQTMoviePropertyListenerProcPtr)))
; 
;  *  QTGetMoviePropertyInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTGetMoviePropertyInfo" 
   ((inMovie (:Handle :MovieType))
    (inPropClass :OSType)
    (inPropID :OSType)
    (outPropType (:pointer :QTPROPERTYVALUETYPE))
    (outPropValueSize (:pointer :ByteCount))
    (outPropertyFlags (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTGetMovieProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTGetMovieProperty" 
   ((inMovie (:Handle :MovieType))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inPropValueSize :UInt32)
    (outPropValueAddress (:pointer :void))
    (outPropValueSizeUsed (:pointer :ByteCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTSetMovieProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTSetMovieProperty" 
   ((inMovie (:Handle :MovieType))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inPropValueSize :UInt32)
    (inPropValueAddress (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTAddMoviePropertyListener()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTAddMoviePropertyListener" 
   ((inMovie (:Handle :MovieType))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inListenerProc (:pointer :OpaqueQTMoviePropertyListenerProcPtr))
    (inUserData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  QTRemoveMoviePropertyListener()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QTRemoveMoviePropertyListener" 
   ((inMovie (:Handle :MovieType))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inListenerProc (:pointer :OpaqueQTMoviePropertyListenerProcPtr))
    (inUserData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
; 
;  *  MusicMediaGetIndexedTunePlayer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MusicMediaGetIndexedTunePlayer" 
   ((ti (:pointer :ComponentInstanceRecord))
    (sampleDescIndex :signed-long)
    (tp (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  UPP call backs 
; 
;  *  NewMCActionFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMCActionFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMCActionFilterProcPtr)
() )
; 
;  *  NewMCActionFilterWithRefConUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMCActionFilterWithRefConUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMCActionFilterWithRefConProcPtr)
() )
; 
;  *  NewMCActionNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMCActionNotificationUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :OpaqueMCActionNotificationProcPtr)
() )
; 
;  *  NewQTMoviePropertyListenerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 9.9 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTMoviePropertyListenerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :OpaqueQTMoviePropertyListenerProcPtr)
() )
; 
;  *  DisposeMCActionFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMCActionFilterUPP" 
   ((userUPP (:pointer :OpaqueMCActionFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMCActionFilterWithRefConUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMCActionFilterWithRefConUPP" 
   ((userUPP (:pointer :OpaqueMCActionFilterWithRefConProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMCActionNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMCActionNotificationUPP" 
   ((userUPP (:pointer :OpaqueMCActionNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  *  DisposeQTMoviePropertyListenerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 9.9 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTMoviePropertyListenerUPP" 
   ((userUPP (:pointer :OpaqueQTMoviePropertyListenerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  *  InvokeMCActionFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMCActionFilterUPP" 
   ((mc (:pointer :ComponentInstanceRecord))
    (action (:pointer :short))
    (params :pointer)
    (userUPP (:pointer :OpaqueMCActionFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeMCActionFilterWithRefConUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMCActionFilterWithRefConUPP" 
   ((mc (:pointer :ComponentInstanceRecord))
    (action :SInt16)
    (params :pointer)
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueMCActionFilterWithRefConProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeMCActionNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMCActionNotificationUPP" 
   ((mc (:pointer :ComponentInstanceRecord))
    (action :SInt16)
    (params :pointer)
    (inFlags :UInt32)
    (outFlags (:pointer :UInt32))
    (refCon :pointer)
    (userUPP (:pointer :OpaqueMCActionNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  *  InvokeQTMoviePropertyListenerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 9.9 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTMoviePropertyListenerUPP" 
   ((inMovie (:Handle :MovieType))
    (inPropClass :OSType)
    (inPropID :OSType)
    (inUserData :pointer)
    (userUPP (:pointer :OpaqueQTMoviePropertyListenerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
;  selectors for component calls 

(defconstant $kVideoMediaResetStatisticsSelect #x105)
(defconstant $kVideoMediaGetStatisticsSelect #x106)
(defconstant $kVideoMediaGetStallCountSelect #x10E)
(defconstant $kVideoMediaSetCodecParameterSelect #x10F)
(defconstant $kVideoMediaGetCodecParameterSelect #x110)
(defconstant $kTextMediaSetTextProcSelect #x101)
(defconstant $kTextMediaAddTextSampleSelect #x102)
(defconstant $kTextMediaAddTESampleSelect #x103)
(defconstant $kTextMediaAddHiliteSampleSelect #x104)
(defconstant $kTextMediaDrawRawSelect #x109)
(defconstant $kTextMediaSetTextPropertySelect #x10A)
(defconstant $kTextMediaRawSetupSelect #x10B)
(defconstant $kTextMediaRawIdleSelect #x10C)
(defconstant $kTextMediaGetTextPropertySelect #x10D)
(defconstant $kTextMediaFindNextTextSelect #x105)
(defconstant $kTextMediaHiliteTextSampleSelect #x106)
(defconstant $kTextMediaSetTextSampleDataSelect #x107)
(defconstant $kSpriteMediaSetPropertySelect #x101)
(defconstant $kSpriteMediaGetPropertySelect #x102)
(defconstant $kSpriteMediaHitTestSpritesSelect #x103)
(defconstant $kSpriteMediaCountSpritesSelect #x104)
(defconstant $kSpriteMediaCountImagesSelect #x105)
(defconstant $kSpriteMediaGetIndImageDescriptionSelect #x106)
(defconstant $kSpriteMediaGetDisplayedSampleNumberSelect #x107)
(defconstant $kSpriteMediaGetSpriteNameSelect #x108)
(defconstant $kSpriteMediaGetImageNameSelect #x109)
(defconstant $kSpriteMediaSetSpritePropertySelect #x10A)
(defconstant $kSpriteMediaGetSpritePropertySelect #x10B)
(defconstant $kSpriteMediaHitTestAllSpritesSelect #x10C)
(defconstant $kSpriteMediaHitTestOneSpriteSelect #x10D)
(defconstant $kSpriteMediaSpriteIndexToIDSelect #x10E)
(defconstant $kSpriteMediaSpriteIDToIndexSelect #x10F)
(defconstant $kSpriteMediaGetSpriteActionsForQTEventSelect #x110)
(defconstant $kSpriteMediaSetActionVariableSelect #x111)
(defconstant $kSpriteMediaGetActionVariableSelect #x112)
(defconstant $kSpriteMediaGetIndImagePropertySelect #x113)
(defconstant $kSpriteMediaNewSpriteSelect #x114)
(defconstant $kSpriteMediaDisposeSpriteSelect #x115)
(defconstant $kSpriteMediaSetActionVariableToStringSelect #x116)
(defconstant $kSpriteMediaGetActionVariableAsStringSelect #x117)
(defconstant $kSpriteMediaNewImageSelect #x11B)
(defconstant $kSpriteMediaDisposeImageSelect #x11C)
(defconstant $kSpriteMediaImageIndexToIDSelect #x11D)
(defconstant $kSpriteMediaImageIDToIndexSelect #x11E)
(defconstant $kFlashMediaSetPanSelect #x101)
(defconstant $kFlashMediaSetZoomSelect #x102)
(defconstant $kFlashMediaSetZoomRectSelect #x103)
(defconstant $kFlashMediaGetRefConBoundsSelect #x104)
(defconstant $kFlashMediaGetRefConIDSelect #x105)
(defconstant $kFlashMediaIDToRefConSelect #x106)
(defconstant $kFlashMediaGetDisplayedFrameNumberSelect #x107)
(defconstant $kFlashMediaFrameNumberToMovieTimeSelect #x108)
(defconstant $kFlashMediaFrameLabelToMovieTimeSelect #x109)
(defconstant $kFlashMediaGetFlashVariableSelect #x10A)
(defconstant $kFlashMediaSetFlashVariableSelect #x10B)
(defconstant $kFlashMediaDoButtonActionsSelect #x10C)
(defconstant $kFlashMediaGetSupportedSwfVersionSelect #x10D)
(defconstant $kMovieMediaGetChildDoMCActionCallbackSelect #x102)
(defconstant $kMovieMediaGetDoMCActionCallbackSelect #x103)
(defconstant $kMovieMediaGetCurrentMoviePropertySelect #x104)
(defconstant $kMovieMediaGetCurrentTrackPropertySelect #x105)
(defconstant $kMovieMediaGetChildMovieDataReferenceSelect #x106)
(defconstant $kMovieMediaSetChildMovieDataReferenceSelect #x107)
(defconstant $kMovieMediaLoadChildMovieFromDataReferenceSelect #x108)
(defconstant $kMedia3DGetNamedObjectListSelect #x101)
(defconstant $kMedia3DGetRendererListSelect #x102)
(defconstant $kMedia3DGetCurrentGroupSelect #x103)
(defconstant $kMedia3DTranslateNamedObjectToSelect #x104)
(defconstant $kMedia3DScaleNamedObjectToSelect #x105)
(defconstant $kMedia3DRotateNamedObjectToSelect #x106)
(defconstant $kMedia3DSetCameraDataSelect #x107)
(defconstant $kMedia3DGetCameraDataSelect #x108)
(defconstant $kMedia3DSetCameraAngleAspectSelect #x109)
(defconstant $kMedia3DGetCameraAngleAspectSelect #x10A)
(defconstant $kMedia3DSetCameraRangeSelect #x10D)
(defconstant $kMedia3DGetCameraRangeSelect #x10E)
(defconstant $kMedia3DGetViewObjectSelect #x10F)
(defconstant $kMCSetMovieSelect 2)
(defconstant $kMCGetIndMovieSelect 5)
(defconstant $kMCRemoveAllMoviesSelect 6)
(defconstant $kMCRemoveAMovieSelect 3)
(defconstant $kMCRemoveMovieSelect 6)
(defconstant $kMCIsPlayerEventSelect 7)
(defconstant $kMCSetActionFilterSelect 8)
(defconstant $kMCDoActionSelect 9)
(defconstant $kMCSetControllerAttachedSelect 10)
(defconstant $kMCIsControllerAttachedSelect 11)
(defconstant $kMCSetControllerPortSelect 12)
(defconstant $kMCGetControllerPortSelect 13)
(defconstant $kMCSetVisibleSelect 14)
(defconstant $kMCGetVisibleSelect 15)
(defconstant $kMCGetControllerBoundsRectSelect 16)
(defconstant $kMCSetControllerBoundsRectSelect 17)
(defconstant $kMCGetControllerBoundsRgnSelect 18)
(defconstant $kMCGetWindowRgnSelect 19)
(defconstant $kMCMovieChangedSelect 20)
(defconstant $kMCSetDurationSelect 21)
(defconstant $kMCGetCurrentTimeSelect 22)
(defconstant $kMCNewAttachedControllerSelect 23)
(defconstant $kMCDrawSelect 24)
(defconstant $kMCActivateSelect 25)
(defconstant $kMCIdleSelect 26)
(defconstant $kMCKeySelect 27)
(defconstant $kMCClickSelect 28)
(defconstant $kMCEnableEditingSelect 29)
(defconstant $kMCIsEditingEnabledSelect 30)
(defconstant $kMCCopySelect 31)
(defconstant $kMCCutSelect 32)
(defconstant $kMCPasteSelect 33)
(defconstant $kMCClearSelect 34)
(defconstant $kMCUndoSelect 35)
(defconstant $kMCPositionControllerSelect 36)
(defconstant $kMCGetControllerInfoSelect 37)
(defconstant $kMCSetClipSelect 40)
(defconstant $kMCGetClipSelect 41)
(defconstant $kMCDrawBadgeSelect 42)
(defconstant $kMCSetUpEditMenuSelect 43)
(defconstant $kMCGetMenuStringSelect 44)
(defconstant $kMCSetActionFilterWithRefConSelect 45)
(defconstant $kMCPtInControllerSelect 46)
(defconstant $kMCInvalidateSelect 47)
(defconstant $kMCAdjustCursorSelect 48)
(defconstant $kMCGetInterfaceElementSelect 49)
(defconstant $kMCGetDoActionsProcSelect 50)
(defconstant $kMCAddMovieSegmentSelect 51)
(defconstant $kMCTrimMovieSegmentSelect 52)
(defconstant $kMCSetIdleManagerSelect 53)
(defconstant $kMCSetControllerCapabilitiesSelect 54)
(defconstant $kMusicMediaGetIndexedTunePlayerSelect #x101)
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __MOVIES__ */


(provide-interface "Movies")