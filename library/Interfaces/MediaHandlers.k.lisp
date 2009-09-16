(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:MediaHandlers.k.h"
; at Sunday July 2,2006 7:30:27 pm.
; 
;      File:       MediaHandlers.k.h
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
; #ifndef __MEDIAHANDLERS_K__
; #define __MEDIAHANDLERS_K__

(require-interface "QuickTime/MediaHandlers")
; 
; 	Example usage:
; 
; 		#define CALLCOMPONENT_BASENAME()	Fred
; 		#define CALLCOMPONENT_GLOBALS()	FredGlobalsHandle
; 		#include <QuickTime/MediaHandlers.k.h>
; 
; 	To specify that your component implementation does not use globals, do not #define CALLCOMPONENT_GLOBALS
; 
; #ifdef CALLCOMPONENT_BASENAME
#| #|
	#ifndefCALLCOMPONENT_GLOBALS
		#define CALLCOMPONENT_GLOBALS() 
		#define ADD_CALLCOMPONENT_COMMA 
	#else		#define ADD_CALLCOMPONENT_COMMA ,
	#endif	#define CALLCOMPONENT_GLUE(a,b) a
; #b
#COMPILER-DIRECTIVE 	#define CALLCOMPONENT_STRCAT(a,b) CALLCOMPONENT_GLUE(a,b)
	#define ADD_CALLCOMPONENT_BASENAME(name) CALLCOMPONENT_STRCAT(CALLCOMPONENT_BASENAME(),name)

	EXTERN_API( ComponentResult  ) ADD_CALLCOMPONENT_BASENAME(ExecuteWiredAction) (CALLCOMPONENT_GLOBALS() ADD_CALLCOMPONENT_COMMA QTAtomContainer  actionContainer, QTAtom  actionAtom, QTCustomActionTargetPtr  target, QTEventRecordPtr  event);

#endif
|#
 |#
;  CALLCOMPONENT_BASENAME 
; 
; 	Example usage:
; 
; 		#define MEDIA_BASENAME()	Fred
; 		#define MEDIA_GLOBALS()	FredGlobalsHandle
; 		#include <QuickTime/MediaHandlers.k.h>
; 
; 	To specify that your component implementation does not use globals, do not #define MEDIA_GLOBALS
; 
; #ifdef MEDIA_BASENAME
#| #|
	#ifndefMEDIA_GLOBALS
		#define MEDIA_GLOBALS() 
		#define ADD_MEDIA_COMMA 
	#else		#define ADD_MEDIA_COMMA ,
	#endif	#define MEDIA_GLUE(a,b) a
; #b
#COMPILER-DIRECTIVE 	#define MEDIA_STRCAT(a,b) MEDIA_GLUE(a,b)
	#define ADD_MEDIA_BASENAME(name) MEDIA_STRCAT(MEDIA_BASENAME(),name)

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetChunkManagementFlags) (MEDIA_GLOBALS() ADD_MEDIA_COMMA UInt32  flags, UInt32  flagsMask);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetChunkManagementFlags) (MEDIA_GLOBALS() ADD_MEDIA_COMMA UInt32 * flags);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetPurgeableChunkMemoryAllowance) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Size  allowance);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetPurgeableChunkMemoryAllowance) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Size * allowance);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(EmptyAllPurgeableChunks) (MEDIA_GLOBALS());

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(Initialize) (MEDIA_GLOBALS() ADD_MEDIA_COMMA GetMovieCompleteParams * gmc);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetHandlerCapabilities) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  flags, long  flagsMask);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(Idle) (MEDIA_GLOBALS() ADD_MEDIA_COMMA TimeValue  atMediaTime, long  flagsIn, long * flagsOut, const TimeRecord * movieTime);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetMediaInfo) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Handle  h);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(PutMediaInfo) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Handle  h);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetActive) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Boolean  enableMedia);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetRate) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Fixed  rate);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GGetStatus) (MEDIA_GLOBALS() ADD_MEDIA_COMMA ComponentResult * statusErr);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(TrackEdited) (MEDIA_GLOBALS());

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetMediaTimeScale) (MEDIA_GLOBALS() ADD_MEDIA_COMMA TimeScale  newTimeScale);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetMovieTimeScale) (MEDIA_GLOBALS() ADD_MEDIA_COMMA TimeScale  newTimeScale);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetGWorld) (MEDIA_GLOBALS() ADD_MEDIA_COMMA CGrafPtr  aPort, GDHandle  aGD);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetDimensions) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Fixed  width, Fixed  height);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetClip) (MEDIA_GLOBALS() ADD_MEDIA_COMMA RgnHandle  theClip);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetMatrix) (MEDIA_GLOBALS() ADD_MEDIA_COMMA MatrixRecord * trackMovieMatrix);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetTrackOpaque) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Boolean * trackIsOpaque);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetGraphicsMode) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  mode, const RGBColor * opColor);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetGraphicsMode) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long * mode, RGBColor * opColor);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GSetVolume) (MEDIA_GLOBALS() ADD_MEDIA_COMMA short  volume);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetSoundBalance) (MEDIA_GLOBALS() ADD_MEDIA_COMMA short  balance);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetSoundBalance) (MEDIA_GLOBALS() ADD_MEDIA_COMMA short * balance);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetNextBoundsChange) (MEDIA_GLOBALS() ADD_MEDIA_COMMA TimeValue * when);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetSrcRgn) (MEDIA_GLOBALS() ADD_MEDIA_COMMA RgnHandle  rgn, TimeValue  atMediaTime);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(Preroll) (MEDIA_GLOBALS() ADD_MEDIA_COMMA TimeValue  time, Fixed  rate);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SampleDescriptionChanged) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  index);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(HasCharacteristic) (MEDIA_GLOBALS() ADD_MEDIA_COMMA OSType  characteristic, Boolean * hasIt);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetOffscreenBufferSize) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Rect * bounds, short  depth, CTabHandle  ctab);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetHints) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  hints);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetName) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Str255  name, long  requestedLanguage, long * actualLanguage);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(ForceUpdate) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  forceUpdateFlags);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetDrawingRgn) (MEDIA_GLOBALS() ADD_MEDIA_COMMA RgnHandle * partialRgn);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GSetActiveSegment) (MEDIA_GLOBALS() ADD_MEDIA_COMMA TimeValue  activeStart, TimeValue  activeDuration);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(InvalidateRegion) (MEDIA_GLOBALS() ADD_MEDIA_COMMA RgnHandle  invalRgn);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetNextStepTime) (MEDIA_GLOBALS() ADD_MEDIA_COMMA short  flags, TimeValue  mediaTimeIn, TimeValue * mediaTimeOut, Fixed  rate);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetNonPrimarySourceData) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  inputIndex, long  dataDescriptionSeed, Handle  dataDescription, void * data, long  dataSize, ICMCompletionProcRecordPtr  asyncCompletionProc, ICMConvertDataFormatUPP  transferProc, void * refCon);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(ChangedNonPrimarySource) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  inputIndex);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(TrackReferencesChanged) (MEDIA_GLOBALS());

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetSampleDataPointer) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  sampleNum, Ptr * dataPtr, long * dataSize, long * sampleDescIndex);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(ReleaseSampleDataPointer) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  sampleNum);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(TrackPropertyAtomChanged) (MEDIA_GLOBALS());

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetTrackInputMapReference) (MEDIA_GLOBALS() ADD_MEDIA_COMMA QTAtomContainer  inputMap);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetVideoParam) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  whichParam, unsigned short * value);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetVideoParam) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  whichParam, unsigned short * value);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(Compare) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Boolean * isOK, Media  srcMedia, ComponentInstance  srcMediaComponent);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetClock) (MEDIA_GLOBALS() ADD_MEDIA_COMMA ComponentInstance * clock);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetSoundOutputComponent) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Component  outputComponent);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetSoundOutputComponent) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Component * outputComponent);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetSoundLocalizationData) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Handle  data);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetInvalidRegion) (MEDIA_GLOBALS() ADD_MEDIA_COMMA RgnHandle  rgn);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SampleDescriptionB2N) (MEDIA_GLOBALS() ADD_MEDIA_COMMA SampleDescriptionHandle  sampleDescriptionH);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SampleDescriptionN2B) (MEDIA_GLOBALS() ADD_MEDIA_COMMA SampleDescriptionHandle  sampleDescriptionH);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(QueueNonPrimarySourceData) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  inputIndex, long  dataDescriptionSeed, Handle  dataDescription, void * data, long  dataSize, ICMCompletionProcRecordPtr  asyncCompletionProc, const ICMFrameTimeRecord * frameTime, ICMConvertDataFormatUPP  transferProc, void * refCon);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(FlushNonPrimarySourceData) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  inputIndex);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetURLLink) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Point  displayWhere, Handle * urlLink);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(MakeMediaTimeTable) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long ** offsets, TimeValue  startTime, TimeValue  endTime, TimeValue  timeIncrement, short  firstDataRefIndex, short  lastDataRefIndex, long * retDataRefSkew);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(HitTestForTargetRefCon) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  flags, Point  loc, long * targetRefCon);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(HitTestTargetRefCon) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  targetRefCon, long  flags, Point  loc, Boolean * wasHit);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetActionsForQTEvent) (MEDIA_GLOBALS() ADD_MEDIA_COMMA QTEventRecordPtr  event, long  targetRefCon, QTAtomContainer * container, QTAtom * atom);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(DisposeTargetRefCon) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  targetRefCon);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(TargetRefConsEqual) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  firstRefCon, long  secondRefCon, Boolean * equal);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetActionsCallback) (MEDIA_GLOBALS() ADD_MEDIA_COMMA ActionsUPP  actionsCallbackProc, void * refcon);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(PrePrerollBegin) (MEDIA_GLOBALS() ADD_MEDIA_COMMA TimeValue  time, Fixed  rate, PrePrerollCompleteUPP  completeProc, void * refcon);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(PrePrerollCancel) (MEDIA_GLOBALS() ADD_MEDIA_COMMA void * refcon);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(EnterEmptyEdit) (MEDIA_GLOBALS());

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(CurrentMediaQueuedData) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long * milliSecs);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetEffectiveVolume) (MEDIA_GLOBALS() ADD_MEDIA_COMMA short * volume);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(ResolveTargetRefCon) (MEDIA_GLOBALS() ADD_MEDIA_COMMA QTAtomContainer  container, QTAtom  atom, long * targetRefCon);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetSoundLevelMeteringEnabled) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Boolean * enabled);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetSoundLevelMeteringEnabled) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Boolean  enable);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetSoundLevelMeterInfo) (MEDIA_GLOBALS() ADD_MEDIA_COMMA LevelMeterInfoPtr  levelInfo);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetEffectiveSoundBalance) (MEDIA_GLOBALS() ADD_MEDIA_COMMA short * balance);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetScreenLock) (MEDIA_GLOBALS() ADD_MEDIA_COMMA Boolean  lockIt);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetDoMCActionCallback) (MEDIA_GLOBALS() ADD_MEDIA_COMMA DoMCActionUPP  doMCActionCallbackProc, void * refcon);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetErrorString) (MEDIA_GLOBALS() ADD_MEDIA_COMMA ComponentResult  theError, Str255  errorString);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetSoundEqualizerBands) (MEDIA_GLOBALS() ADD_MEDIA_COMMA MediaEQSpectrumBandsRecordPtr  spectrumInfo);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetSoundEqualizerBands) (MEDIA_GLOBALS() ADD_MEDIA_COMMA MediaEQSpectrumBandsRecordPtr  spectrumInfo);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetSoundEqualizerBandLevels) (MEDIA_GLOBALS() ADD_MEDIA_COMMA UInt8 * bandLevels);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(DoIdleActions) (MEDIA_GLOBALS());

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetSoundBassAndTreble) (MEDIA_GLOBALS() ADD_MEDIA_COMMA short  bass, short  treble);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetSoundBassAndTreble) (MEDIA_GLOBALS() ADD_MEDIA_COMMA short * bass, short * treble);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(TimeBaseChanged) (MEDIA_GLOBALS());

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(MCIsPlayerEvent) (MEDIA_GLOBALS() ADD_MEDIA_COMMA const EventRecord * e, Boolean * handledIt);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetMediaLoadState) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long * mediaLoadState);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(VideoOutputChanged) (MEDIA_GLOBALS() ADD_MEDIA_COMMA ComponentInstance  vout);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(EmptySampleCache) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  sampleNum, long  sampleCount);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetPublicInfo) (MEDIA_GLOBALS() ADD_MEDIA_COMMA OSType  infoSelector, void * infoDataPtr, Size * ioDataSize);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetPublicInfo) (MEDIA_GLOBALS() ADD_MEDIA_COMMA OSType  infoSelector, void * infoDataPtr, Size  dataSize);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GetUserPreferredCodecs) (MEDIA_GLOBALS() ADD_MEDIA_COMMA CodecComponentHandle * userPreferredCodecs);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(SetUserPreferredCodecs) (MEDIA_GLOBALS() ADD_MEDIA_COMMA CodecComponentHandle  userPreferredCodecs);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(RefConSetProperty) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  refCon, long  propertyType, void * propertyValue);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(RefConGetProperty) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  refCon, long  propertyType, void * propertyValue);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(NavigateTargetRefCon) (MEDIA_GLOBALS() ADD_MEDIA_COMMA long  navigation, long * refCon);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GGetIdleManager) (MEDIA_GLOBALS() ADD_MEDIA_COMMA IdleManager * pim);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GSetIdleManager) (MEDIA_GLOBALS() ADD_MEDIA_COMMA IdleManager  im);

	EXTERN_API( ComponentResult  ) ADD_MEDIA_BASENAME(GGetLatency) (MEDIA_GLOBALS() ADD_MEDIA_COMMA TimeRecord * latency);

#endif
|#
 |#
;  MEDIA_BASENAME 
;  MixedMode ProcInfo constants for component calls 

(defconstant $uppCallComponentExecuteWiredActionProcInfo #xFFF0)
(defconstant $uppMediaSetChunkManagementFlagsProcInfo #xFF0)
(defconstant $uppMediaGetChunkManagementFlagsProcInfo #x3F0)
(defconstant $uppMediaSetPurgeableChunkMemoryAllowanceProcInfo #x3F0)
(defconstant $uppMediaGetPurgeableChunkMemoryAllowanceProcInfo #x3F0)
(defconstant $uppMediaEmptyAllPurgeableChunksProcInfo #xF0)
(defconstant $uppMediaInitializeProcInfo #x3F0)
(defconstant $uppMediaSetHandlerCapabilitiesProcInfo #xFF0)
(defconstant $uppMediaIdleProcInfo #xFFF0)
(defconstant $uppMediaGetMediaInfoProcInfo #x3F0)
(defconstant $uppMediaPutMediaInfoProcInfo #x3F0)
(defconstant $uppMediaSetActiveProcInfo #x1F0)
(defconstant $uppMediaSetRateProcInfo #x3F0)
(defconstant $uppMediaGGetStatusProcInfo #x3F0)
(defconstant $uppMediaTrackEditedProcInfo #xF0)
(defconstant $uppMediaSetMediaTimeScaleProcInfo #x3F0)
(defconstant $uppMediaSetMovieTimeScaleProcInfo #x3F0)
(defconstant $uppMediaSetGWorldProcInfo #xFF0)
(defconstant $uppMediaSetDimensionsProcInfo #xFF0)
(defconstant $uppMediaSetClipProcInfo #x3F0)
(defconstant $uppMediaSetMatrixProcInfo #x3F0)
(defconstant $uppMediaGetTrackOpaqueProcInfo #x3F0)
(defconstant $uppMediaSetGraphicsModeProcInfo #xFF0)
(defconstant $uppMediaGetGraphicsModeProcInfo #xFF0)
(defconstant $uppMediaGSetVolumeProcInfo #x2F0)
(defconstant $uppMediaSetSoundBalanceProcInfo #x2F0)
(defconstant $uppMediaGetSoundBalanceProcInfo #x3F0)
(defconstant $uppMediaGetNextBoundsChangeProcInfo #x3F0)
(defconstant $uppMediaGetSrcRgnProcInfo #xFF0)
(defconstant $uppMediaPrerollProcInfo #xFF0)
(defconstant $uppMediaSampleDescriptionChangedProcInfo #x3F0)
(defconstant $uppMediaHasCharacteristicProcInfo #xFF0)
(defconstant $uppMediaGetOffscreenBufferSizeProcInfo #x3BF0)
(defconstant $uppMediaSetHintsProcInfo #x3F0)
(defconstant $uppMediaGetNameProcInfo #x3FF0)
(defconstant $uppMediaForceUpdateProcInfo #x3F0)
(defconstant $uppMediaGetDrawingRgnProcInfo #x3F0)
(defconstant $uppMediaGSetActiveSegmentProcInfo #xFF0)
(defconstant $uppMediaInvalidateRegionProcInfo #x3F0)
(defconstant $uppMediaGetNextStepTimeProcInfo #xFEF0)
(defconstant $uppMediaSetNonPrimarySourceDataProcInfo #xFFFFF0)
(defconstant $uppMediaChangedNonPrimarySourceProcInfo #x3F0)
(defconstant $uppMediaTrackReferencesChangedProcInfo #xF0)
(defconstant $uppMediaGetSampleDataPointerProcInfo #xFFF0)
(defconstant $uppMediaReleaseSampleDataPointerProcInfo #x3F0)
(defconstant $uppMediaTrackPropertyAtomChangedProcInfo #xF0)
(defconstant $uppMediaSetTrackInputMapReferenceProcInfo #x3F0)
(defconstant $uppMediaSetVideoParamProcInfo #xFF0)
(defconstant $uppMediaGetVideoParamProcInfo #xFF0)
(defconstant $uppMediaCompareProcInfo #x3FF0)
(defconstant $uppMediaGetClockProcInfo #x3F0)
(defconstant $uppMediaSetSoundOutputComponentProcInfo #x3F0)
(defconstant $uppMediaGetSoundOutputComponentProcInfo #x3F0)
(defconstant $uppMediaSetSoundLocalizationDataProcInfo #x3F0)
(defconstant $uppMediaGetInvalidRegionProcInfo #x3F0)
(defconstant $uppMediaSampleDescriptionB2NProcInfo #x3F0)
(defconstant $uppMediaSampleDescriptionN2BProcInfo #x3F0)
(defconstant $uppMediaQueueNonPrimarySourceDataProcInfo #x3FFFFF0)
(defconstant $uppMediaFlushNonPrimarySourceDataProcInfo #x3F0)
(defconstant $uppMediaGetURLLinkProcInfo #xFF0)
(defconstant $uppMediaMakeMediaTimeTableProcInfo #x3AFFF0)
(defconstant $uppMediaHitTestForTargetRefConProcInfo #x3FF0)
(defconstant $uppMediaHitTestTargetRefConProcInfo #xFFF0)
(defconstant $uppMediaGetActionsForQTEventProcInfo #xFFF0)
(defconstant $uppMediaDisposeTargetRefConProcInfo #x3F0)
(defconstant $uppMediaTargetRefConsEqualProcInfo #x3FF0)
(defconstant $uppMediaSetActionsCallbackProcInfo #xFF0)
(defconstant $uppMediaPrePrerollBeginProcInfo #xFFF0)
(defconstant $uppMediaPrePrerollCancelProcInfo #x3F0)
(defconstant $uppMediaEnterEmptyEditProcInfo #xF0)
(defconstant $uppMediaCurrentMediaQueuedDataProcInfo #x3F0)
(defconstant $uppMediaGetEffectiveVolumeProcInfo #x3F0)
(defconstant $uppMediaResolveTargetRefConProcInfo #x3FF0)
(defconstant $uppMediaGetSoundLevelMeteringEnabledProcInfo #x3F0)
(defconstant $uppMediaSetSoundLevelMeteringEnabledProcInfo #x1F0)
(defconstant $uppMediaGetSoundLevelMeterInfoProcInfo #x3F0)
(defconstant $uppMediaGetEffectiveSoundBalanceProcInfo #x3F0)
(defconstant $uppMediaSetScreenLockProcInfo #x1F0)
(defconstant $uppMediaSetDoMCActionCallbackProcInfo #xFF0)
(defconstant $uppMediaGetErrorStringProcInfo #xFF0)
(defconstant $uppMediaGetSoundEqualizerBandsProcInfo #x3F0)
(defconstant $uppMediaSetSoundEqualizerBandsProcInfo #x3F0)
(defconstant $uppMediaGetSoundEqualizerBandLevelsProcInfo #x3F0)
(defconstant $uppMediaDoIdleActionsProcInfo #xF0)
(defconstant $uppMediaSetSoundBassAndTrebleProcInfo #xAF0)
(defconstant $uppMediaGetSoundBassAndTrebleProcInfo #xFF0)
(defconstant $uppMediaTimeBaseChangedProcInfo #xF0)
(defconstant $uppMediaMCIsPlayerEventProcInfo #xFF0)
(defconstant $uppMediaGetMediaLoadStateProcInfo #x3F0)
(defconstant $uppMediaVideoOutputChangedProcInfo #x3F0)
(defconstant $uppMediaEmptySampleCacheProcInfo #xFF0)
(defconstant $uppMediaGetPublicInfoProcInfo #x3FF0)
(defconstant $uppMediaSetPublicInfoProcInfo #x3FF0)
(defconstant $uppMediaGetUserPreferredCodecsProcInfo #x3F0)
(defconstant $uppMediaSetUserPreferredCodecsProcInfo #x3F0)
(defconstant $uppMediaRefConSetPropertyProcInfo #x3FF0)
(defconstant $uppMediaRefConGetPropertyProcInfo #x3FF0)
(defconstant $uppMediaNavigateTargetRefConProcInfo #xFF0)
(defconstant $uppMediaGGetIdleManagerProcInfo #x3F0)
(defconstant $uppMediaGSetIdleManagerProcInfo #x3F0)
(defconstant $uppMediaGGetLatencyProcInfo #x3F0)

; #endif /* __MEDIAHANDLERS_K__ */


(provide-interface "MediaHandlers.k")