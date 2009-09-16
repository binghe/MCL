(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:MoviesFormat.h"
; at Sunday July 2,2006 7:30:08 pm.
; 
;      File:       QuickTime/MoviesFormat.h
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
; #ifndef __MOVIESFORMAT__
; #define __MOVIESFORMAT__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __MOVIES__
#| #|
#include <QuickTimeMovies.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k

(defconstant $kMovieVersion 0)                  ;  version number of the format here described 

; ***************************************
; *
; *   General Types -
; *       These types are used in more than one of the
; *       directory types.
; *
; ***************************************
;  MoviesUserData is the type used for user data in movie and track directories 
(defrecord MoviesUserData
   (size :signed-long)                          ;  size of this user data 
   (udType :signed-long)                        ;  type of user data 
   (data (:array :character 1))                 ;  the user data 
)

;type name? (%define-record :MoviesUserData (find-record-descriptor ':MoviesUserData))
(defrecord UserDataAtom
   (size :signed-long)
   (atomType :signed-long)
   (userData (:array :MoviesUserData 1))
)

;type name? (%define-record :UserDataAtom (find-record-descriptor ':UserDataAtom))
;  MoviesDataDescription tells us where the data for the movie or track lives.
;    The data can follow the directory, be in the datafork of the same file as the directory resource,
;    be in the resource fork of the same file as the directory resource, be in another file in the
;    data fork or resource fork, or require a specific bottleneck to fetch the data. 
; ***************************************
; *
; *   MediaDirectory information -
; *       The MediaDirectory is tightly coupled to the data.
; *
; ***************************************
;  SampleDescription is in Movies.h 
(defrecord SampleDescriptionAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'stsd' 
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (numEntries :signed-long)
   (sampleDescTable (:array :SampleDescription 1))
)

;type name? (%define-record :SampleDescriptionAtom (find-record-descriptor ':SampleDescriptionAtom))
;  TimeToSampleNum maps physical sample time to physical sample number. 
(defrecord TimeToSampleNum
   (sampleCount :signed-long)
   (sampleDuration :signed-long)
)

;type name? (%define-record :TimeToSampleNum (find-record-descriptor ':TimeToSampleNum))
(defrecord TimeToSampleNumAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'stts' 
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (numEntries :signed-long)
   (timeToSampleNumTable (:array :TimeToSampleNum 1))
)

;type name? (%define-record :TimeToSampleNumAtom (find-record-descriptor ':TimeToSampleNumAtom))
;  SyncSamples is a list of the physical samples which are self contained. 
(defrecord SyncSampleAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'stss' 
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (numEntries :signed-long)
   (syncSampleTable (:array :signed-long 1))
)

;type name? (%define-record :SyncSampleAtom (find-record-descriptor ':SyncSampleAtom))
;  SampleToChunk maps physical sample number to chunk number. 
;  same as SampleToChunk, but redundant first sample is removed 
(defrecord SampleToChunk
   (firstChunk :signed-long)
   (samplesPerChunk :signed-long)
   (sampleDescriptionID :signed-long)
)

;type name? (%define-record :SampleToChunk (find-record-descriptor ':SampleToChunk))
(defrecord SampleToChunkAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'stsc' 
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (numEntries :signed-long)
   (sampleToChunkTable (:array :SampleToChunk 1))
)

;type name? (%define-record :SampleToChunkAtom (find-record-descriptor ':SampleToChunkAtom))
(defrecord ChunkOffsetAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'stco' 
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (numEntries :signed-long)
   (chunkOffsetTable (:array :signed-long 1))
)

;type name? (%define-record :ChunkOffsetAtom (find-record-descriptor ':ChunkOffsetAtom))
(defrecord SampleSizeAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'stsz' 
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (sampleSize :signed-long)
   (numEntries :signed-long)
   (sampleSizeTable (:array :signed-long 1))
)

;type name? (%define-record :SampleSizeAtom (find-record-descriptor ':SampleSizeAtom))
(defrecord ShadowSync
   (fdSampleNum :signed-long)
   (syncSampleNum :signed-long)
)

;type name? (%define-record :ShadowSync (find-record-descriptor ':ShadowSync))
(defrecord ShadowSyncAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'stsz' 
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (numEntries :signed-long)
   (shadowSyncTable (:array :ShadowSync 1))
)

;type name? (%define-record :ShadowSyncAtom (find-record-descriptor ':ShadowSyncAtom))
(defrecord SampleTableAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'stbl' 
   (sampleDescription :SampleDescriptionAtom)
   (timeToSampleNum :TimeToSampleNumAtom)
   (sampleToChunk :SampleToChunkAtom)
   (syncSample :SyncSampleAtom)
   (sampleSize :SampleSizeAtom)
   (chunkOffset :ChunkOffsetAtom)
   (shadowSync :ShadowSyncAtom)
)

;type name? (%define-record :SampleTableAtom (find-record-descriptor ':SampleTableAtom))
(defrecord PublicHandlerInfo
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (componentType :signed-long)
   (componentSubType :signed-long)
   (componentManufacturer :signed-long)
   (componentFlags :signed-long)
   (componentFlagsMask :signed-long)
   (componentName (:array :character 1))
)

;type name? (%define-record :PublicHandlerInfo (find-record-descriptor ':PublicHandlerInfo))
(defrecord HandlerAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'hdlr' 
   (hInfo :PublicHandlerInfo)
)

;type name? (%define-record :HandlerAtom (find-record-descriptor ':HandlerAtom))
;  a data reference is a private structure 

(def-mactype :DataRefAtom (find-mactype ':signed-long))
(defrecord DataInfoAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'dinf' 
   (dataRef :signed-long)
)

;type name? (%define-record :DataInfoAtom (find-record-descriptor ':DataInfoAtom))
(defrecord RgnAtom
   (size :signed-long)
   (atomType :signed-long)
   (rgnSize :SInt16)
   (rgnBBox :Rect)
   (data (:array :character 1))
)

;type name? (%define-record :RgnAtom (find-record-descriptor ':RgnAtom))
(defrecord MatteCompressedAtom
   (size :signed-long)
   (atomType :signed-long)
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (matteImageDescription :ImageDescription)
   (matteData (:array :character 1))
)

;type name? (%define-record :MatteCompressedAtom (find-record-descriptor ':MatteCompressedAtom))
(defrecord MatteAtom
   (size :signed-long)
   (atomType :signed-long)
   (aCompressedMatte :MatteCompressedAtom)
)

;type name? (%define-record :MatteAtom (find-record-descriptor ':MatteAtom))
(defrecord ClippingAtom
   (size :signed-long)
   (atomType :signed-long)
   (aRgnClip :RgnAtom)
)

;type name? (%define-record :ClippingAtom (find-record-descriptor ':ClippingAtom))
; **********************
; * Media Info Example Structures
; **********************
(defrecord VideoMediaInfoHeader
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (graphicsMode :SInt16)                       ;  for QD - transfer mode 
   (opColorRed :SInt16)                         ;  opcolor for transfer mode 
   (opColorGreen :SInt16)
   (opColorBlue :SInt16)
)

;type name? (%define-record :VideoMediaInfoHeader (find-record-descriptor ':VideoMediaInfoHeader))
(defrecord VideoMediaInfoHeaderAtom
   (size :signed-long)                          ;  size of Media info 
   (atomType :signed-long)                      ;  = 'vmhd' 
   (vmiHeader :VideoMediaInfoHeader)
)

;type name? (%define-record :VideoMediaInfoHeaderAtom (find-record-descriptor ':VideoMediaInfoHeaderAtom))
(defrecord VideoMediaInfo
   (size :signed-long)                          ;  size of Media info 
   (atomType :signed-long)                      ;  = 'minf' 
   (header :VideoMediaInfoHeaderAtom)
   (dataHandler :HandlerAtom)
   (dataInfo :DataInfoAtom)
   (sampleTable :SampleTableAtom)
)

;type name? (%define-record :VideoMediaInfo (find-record-descriptor ':VideoMediaInfo))
(defrecord SoundMediaInfoHeader
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (balance :SInt16)
   (rsrvd :SInt16)
)

;type name? (%define-record :SoundMediaInfoHeader (find-record-descriptor ':SoundMediaInfoHeader))
(defrecord SoundMediaInfoHeaderAtom
   (size :signed-long)                          ;  size of Media info 
   (atomType :signed-long)                      ;  = 'vmhd' 
   (smiHeader :SoundMediaInfoHeader)
)

;type name? (%define-record :SoundMediaInfoHeaderAtom (find-record-descriptor ':SoundMediaInfoHeaderAtom))
(defrecord SoundMediaInfo
   (size :signed-long)                          ;  size of Media info 
   (atomType :signed-long)                      ;  = 'minf' 
   (header :SoundMediaInfoHeaderAtom)
   (dataHandler :HandlerAtom)
   (dataReference :signed-long)
   (sampleTable :SampleTableAtom)
)

;type name? (%define-record :SoundMediaInfo (find-record-descriptor ':SoundMediaInfo))
;  whatever data the media handler needs goes after the atomType 
(defrecord MediaInfo
   (size :signed-long)
   (atomType :signed-long)
)

;type name? (%define-record :MediaInfo (find-record-descriptor ':MediaInfo))
; **********************
; * Media Directory Structures
; **********************
(defrecord MediaHeader
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (creationTime :signed-long)                  ;  seconds since Jan 1904 when directory was created 
   (modificationTime :signed-long)              ;  seconds since Jan 1904 when directory was appended 
   (timeScale :signed-long)                     ;  start time for Media (Media time) 
   (duration :signed-long)                      ;  length of Media (Media time) 
   (language :SInt16)
   (quality :SInt16)
)

;type name? (%define-record :MediaHeader (find-record-descriptor ':MediaHeader))
(defrecord MediaHeaderAtom
   (size :signed-long)
   (atomType :signed-long)
   (header :MediaHeader)
)

;type name? (%define-record :MediaHeaderAtom (find-record-descriptor ':MediaHeaderAtom))
(defrecord MediaDirectory
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'mdia' 
   (mediaHeader :MediaHeaderAtom)               ;  standard Media information 
   (mediaHandler :HandlerAtom)
   (mediaInfo :MediaInfo)
)

;type name? (%define-record :MediaDirectory (find-record-descriptor ':MediaDirectory))
; **********************
; * Track Structures
; **********************

(defconstant $TrackEnable 1)
(defconstant $TrackInMovie 2)
(defconstant $TrackInPreview 4)
(defconstant $TrackInPoster 8)
(defrecord TrackHeader
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (creationTime :signed-long)                  ;  seconds since Jan 1904 when directory was created 
   (modificationTime :signed-long)              ;  seconds since Jan 1904 when directory was appended 
   (trackID :signed-long)
   (reserved1 :signed-long)
   (duration :signed-long)                      ;  length of track (track time) 
   (reserved2 :signed-long)
   (reserved3 :signed-long)
   (layer :SInt16)
   (alternateGroup :SInt16)
   (volume :SInt16)
   (reserved4 :SInt16)
   (matrix :MatrixRecord)
   (trackWidth :signed-long)
   (trackHeight :signed-long)
)

;type name? (%define-record :TrackHeader (find-record-descriptor ':TrackHeader))
(defrecord TrackHeaderAtom
   (size :signed-long)                          ;  size of track header 
   (atomType :signed-long)                      ;  = 'tkhd' 
   (header :TrackHeader)
)

;type name? (%define-record :TrackHeaderAtom (find-record-descriptor ':TrackHeaderAtom))
(defrecord EditListType
   (trackDuration :signed-long)
   (mediaTime :signed-long)
   (mediaRate :signed-long)
)

;type name? (%define-record :EditListType (find-record-descriptor ':EditListType))
(defrecord EditListAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = elst 
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (numEntries :signed-long)
   (editListTable (:array :EditListType 1))
)

;type name? (%define-record :EditListAtom (find-record-descriptor ':EditListAtom))
(defrecord EditsAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = edts 
   (editList :EditListAtom)
)

;type name? (%define-record :EditsAtom (find-record-descriptor ':EditsAtom))
(defrecord TrackLoadSettings
   (preloadStartTime :signed-long)
   (preloadDuration :signed-long)
   (preloadFlags :signed-long)
   (defaultHints :signed-long)
)

;type name? (%define-record :TrackLoadSettings (find-record-descriptor ':TrackLoadSettings))
(defrecord TrackLoadSettingsAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = load 
   (settings :TrackLoadSettings)
)

;type name? (%define-record :TrackLoadSettingsAtom (find-record-descriptor ':TrackLoadSettingsAtom))
(defrecord TrackDirectory
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'trak' 
   (trackHeader :TrackHeaderAtom)               ;  standard track information 
   (trackClip :ClippingAtom)
   (edits :EditsAtom)
   (media :MediaDirectory)
   (userData :UserDataAtom)                     ;  space for extending with new data types 
)

;type name? (%define-record :TrackDirectory (find-record-descriptor ':TrackDirectory))
; ***************************************
; *
; *   MovieDirectory -
; *       The MovieDirectory is the top level structure which
; *       holds the TrackInstance describing where the
; *       TrackDirectories are.
; *
; ***************************************
(defrecord MovieHeader
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (creationTime :signed-long)                  ;  seconds since Jan 1904 when directory was created 
   (modificationTime :signed-long)              ;  seconds since Jan 1904 when directory was appended 
   (timeScale :signed-long)                     ;  Time specifications 
   (duration :signed-long)
   (preferredRate :signed-long)                 ;  rate at which to play this movie 
   (preferredVolume :SInt16)                    ;  volume to play movie at 
   (reserved1 :SInt16)
   (preferredLong1 :signed-long)
   (preferredLong2 :signed-long)
   (matrix :MatrixRecord)
   (previewTime :signed-long)                   ;  time in track the proxy begins (track time) 
   (previewDuration :signed-long)               ;  how long the proxy lasts (track time) 
   (posterTime :signed-long)                    ;  time in track the proxy begins (track time) 
   (selectionTime :signed-long)                 ;  time in track the proxy begins (track time) 
   (selectionDuration :signed-long)             ;  time in track the proxy begins (track time) 
   (currentTime :signed-long)                   ;  time in track the proxy begins (track time) 
   (nextTrackID :signed-long)                   ;  next value to use for a TrackID 
)

;type name? (%define-record :MovieHeader (find-record-descriptor ':MovieHeader))
(defrecord MovieHeaderAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'mvhd' 
   (header :MovieHeader)
)

;type name? (%define-record :MovieHeaderAtom (find-record-descriptor ':MovieHeaderAtom))
(defrecord TrackDirectoryEntry
   (trackDirectory :TrackDirectory)             ;  Track directory information 
)

;type name? (%define-record :TrackDirectoryEntry (find-record-descriptor ':TrackDirectoryEntry))
(defrecord MovieDirectory
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'moov' 
   (header :MovieHeaderAtom)
   (movieClip :ClippingAtom)
                                                ;  Track Directories 
   (track (:array :TrackDirectoryEntry 1))      ;  Track directory information 
                                                ;  User data for Movie 
   (userData :UserDataAtom)                     ;  space for user extensions 
)

;type name? (%define-record :MovieDirectory (find-record-descriptor ':MovieDirectory))
; ***************************************
; ***************************************
;  Movie formats and tags 
;  some system defined format IDs 

(defconstant $MOVIE_TYPE :|moov|)
(defconstant $TRACK_TYPE :|trak|)
(defconstant $MEDIA_TYPE :|mdia|)
(defconstant $VIDEO_TYPE :|vide|)
(defconstant $SOUND_TYPE :|soun|)
;  atom id's 

(defconstant $MovieAID :|moov|)
(defconstant $MovieHeaderAID :|mvhd|)
(defconstant $ClipAID :|clip|)
(defconstant $RgnClipAID :|crgn|)
(defconstant $MatteAID :|matt|)
(defconstant $MatteCompAID :|kmat|)
(defconstant $TrackAID :|trak|)
(defconstant $UserDataAID :|udta|)
(defconstant $TrackHeaderAID :|tkhd|)
(defconstant $EditsAID :|edts|)
(defconstant $EditListAID :|elst|)
(defconstant $MediaAID :|mdia|)
(defconstant $MediaHeaderAID :|mdhd|)
(defconstant $MediaInfoAID :|minf|)
(defconstant $VideoMediaInfoHeaderAID :|vmhd|)
(defconstant $SoundMediaInfoHeaderAID :|smhd|)
(defconstant $GenericMediaInfoHeaderAID :|gmhd|)
(defconstant $GenericMediaInfoAID :|gmin|)
(defconstant $DataInfoAID :|dinf|)
(defconstant $DataRefAID :|dref|)
(defconstant $SampleTableAID :|stbl|)
(defconstant $STSampleDescAID :|stsd|)
(defconstant $STTimeToSampAID :|stts|)
(defconstant $STSyncSampleAID :|stss|)
(defconstant $STSampleToChunkAID :|stsc|)
(defconstant $STShadowSyncAID :|stsh|)
(defconstant $HandlerAID :|hdlr|)
(defconstant $STSampleSizeAID :|stsz|)
(defconstant $STChunkOffsetAID :|stco|)
(defconstant $STChunkOffset64AID :|co64|)
(defconstant $STSampleIDAID :|stid|)
(defconstant $DataRefContainerAID :|drfc|)
(defconstant $TrackReferenceAID :|tref|)
(defconstant $ColorTableAID :|ctab|)
(defconstant $LoadSettingsAID :|load|)
(defconstant $PropertyAtomAID :|code|)
(defconstant $InputMapAID :|imap|)
(defconstant $MovieBufferHintsAID :|mbfh|)
(defconstant $MovieDataRefAliasAID :|mdra|)
(defconstant $SoundLocalizationAID :|sloc|)
(defconstant $CompressedMovieAID :|cmov|)
(defconstant $CompressedMovieDataAID :|cmvd|)
(defconstant $DataCompressionAtomAID :|dcom|)
(defconstant $ReferenceMovieRecordAID :|rmra|)
(defconstant $ReferenceMovieDescriptorAID :|rmda|)
(defconstant $ReferenceMovieDataRefAID :|rdrf|)
(defconstant $ReferenceMovieVersionCheckAID :|rmvc|)
(defconstant $ReferenceMovieDataRateAID :|rmdr|)
(defconstant $ReferenceMovieComponentCheckAID :|rmcd|)
(defconstant $ReferenceMovieQualityAID :|rmqu|)
(defconstant $ReferenceMovieLanguageAID :|rmla|)
(defconstant $ReferenceMovieCPURatingAID :|rmcs|)
(defconstant $ReferenceMovieAlternateGroupAID :|rmag|)
(defconstant $ReferenceMovieNetworkStatusAID :|rnet|)
(defconstant $CloneMediaAID :|clon|)
(defconstant $FileTypeAID :|ftyp|)
(defconstant $SecureContentInfoAID :|sinf|)
(defconstant $SecureContentSchemeTypeAID :|schm|)
(defconstant $SecureContentSchemeInfoAID :|schi|)
;  Text ATOM definitions
(defrecord TextBoxAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'tbox' 
   (textBox :Rect)                              ;  New text box (overrides defaultTextBox)
)

;type name? (%define-record :TextBoxAtom (find-record-descriptor ':TextBoxAtom))
(defrecord HiliteAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'hlit' 
   (selStart :signed-long)                      ;  hilite selection start character
   (selEnd :signed-long)                        ;  hilite selection end character
)

;type name? (%define-record :HiliteAtom (find-record-descriptor ':HiliteAtom))
(defrecord KaraokeRec
   (timeVal :signed-long)
   (beginHilite :SInt16)
   (endHilite :SInt16)
)

;type name? (%define-record :KaraokeRec (find-record-descriptor ':KaraokeRec))
(defrecord KaraokeAtom
   (numEntries :signed-long)
   (karaokeEntries (:array :KaraokeRec 1))
)

;type name? (%define-record :KaraokeAtom (find-record-descriptor ':KaraokeAtom))
;  for ReferenceMovieDataRefRecord.flags

(defconstant $kDataRefIsSelfContained 1)
(defrecord ReferenceMovieDataRefRecord
   (flags :signed-long)
   (dataRefType :OSType)
   (dataRefSize :signed-long)
   (dataRef (:array :character 1))
)

;type name? (%define-record :ReferenceMovieDataRefRecord (find-record-descriptor ':ReferenceMovieDataRefRecord))
;  for VersionCheckRecord.checkType

(defconstant $kVersionCheckMin 0)               ;  val1 is the min. version required

(defconstant $kVersionCheckMask 1)              ;  (gestalt return value & val2) must == val1

(defrecord QTAltVersionCheckRecord
   (flags :signed-long)                         ;  currently always 0
   (gestaltTag :OSType)
   (val1 :UInt32)
   (val2 :UInt32)
   (checkType :SInt16)
)

;type name? (%define-record :QTAltVersionCheckRecord (find-record-descriptor ':QTAltVersionCheckRecord))
;  some helpful constants for DataRateRecord.dataRate 

(defconstant $kDataRate144ModemRate #x578)
(defconstant $kDataRate288ModemRate #xAF0)
(defconstant $kDataRateISDNRate #x15E0)
(defconstant $kDataRateDualISDNRate #x2BC0)
(defconstant $kDataRate256kbpsRate #x6400)
(defconstant $kDataRate384kbpsRate #x9600)
(defconstant $kDataRate512kbpsRate #xC800)
(defconstant $kDataRate768kbpsRate #x12C00)
(defconstant $kDataRate1MbpsRate #x186A0)
(defconstant $kDataRateT1Rate #x249F0)
(defconstant $kDataRateInfiniteRate #x7FFFFFFF)
(defconstant $kDataRateDefaultIfNotSet #x15E0)
(defrecord QTAltDataRateRecord
   (flags :signed-long)                         ;  currently always 0
   (dataRate :signed-long)
)

;type name? (%define-record :QTAltDataRateRecord (find-record-descriptor ':QTAltDataRateRecord))
(defrecord QTAltComponentCheckRecord
   (flags :signed-long)                         ;  currently always 0 
   (cd :ComponentDescription)
   (minVersion :UInt32)
)

;type name? (%define-record :QTAltComponentCheckRecord (find-record-descriptor ':QTAltComponentCheckRecord))
(defrecord QTAltLanguageRecord
   (flags :signed-long)                         ;  currently always 0
   (language :SInt16)
)

;type name? (%define-record :QTAltLanguageRecord (find-record-descriptor ':QTAltLanguageRecord))

(defconstant $kQTCPUSpeed1Rating 100)           ;  slowest

(defconstant $kQTCPUSpeed2Rating #xC8)
(defconstant $kQTCPUSpeed3Rating #x12C)
(defconstant $kQTCPUSpeed4Rating #x190)
(defconstant $kQTCPUSpeed5Rating #x1F4)         ;  fastest

(defrecord QTAltCPURatingRecord
   (flags :UInt32)                              ;  currently always 0
   (speed :UInt16)
)

;type name? (%define-record :QTAltCPURatingRecord (find-record-descriptor ':QTAltCPURatingRecord))
(defrecord ReferenceMovieNetworkStatusRecord
   (flags :UInt32)                              ;  currently always 0
   (valueCount :UInt32)                         ;  how many status values are in array
   (netStatusValues (:array :signed-long 1))    ;  a value from kQTNetworkStatus... constants
)

;type name? (%define-record :ReferenceMovieNetworkStatusRecord (find-record-descriptor ':ReferenceMovieNetworkStatusRecord))
(defrecord CloneRecord
   (flags :signed-long)
   (masterTrackID :signed-long)                 ;  track ID of the track we're cloning 
)

;type name? (%define-record :CloneRecord (find-record-descriptor ':CloneRecord))
(defrecord CloneAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = clon 
   (cloneInfo :CloneRecord)
)

;type name? (%define-record :CloneAtom (find-record-descriptor ':CloneAtom))
(defrecord FileTypeAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'ftyp' 
   (majorBrand :signed-long)                    ;  best use brand 
   (minorVersion :signed-long)
   (compatibleBrands (:array :signed-long 4))   ;  1 or greater 
)

;type name? (%define-record :FileTypeAtom (find-record-descriptor ':FileTypeAtom))

(defconstant $kQTFileTypeBrandQuickTimeMovie :|qt  |);  QuickTime movie files

(defconstant $kQTFileTypeBrandISOFile :|isom|)  ;  ISO Base Media files

(defconstant $kQTFileTypeBrandMPEG4v1 :|mp41|)  ;  MPEG-4 (ISO/IEC 14496-1) version 1 files

(defconstant $kQTFileTypeBrandMPEG4v2 :|mp42|)  ;  MPEG-4 (ISO/IEC 14496-1) version 2 files

(defrecord SecureContentInfoAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'sinf' 
)

;type name? (%define-record :SecureContentInfoAtom (find-record-descriptor ':SecureContentInfoAtom))
(defrecord SecureContentSchemeTypeAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'schm' 
   (flags :signed-long)                         ;  1 byte of version / 3 bytes of flags 
   (schemeType :signed-long)
   (schemeVersion :UInt32)
                                                ;  if flags & 1, C string holding URL for security component server
)

;type name? (%define-record :SecureContentSchemeTypeAtom (find-record-descriptor ':SecureContentSchemeTypeAtom))
(defrecord SecureContentSchemeInfoAtom
   (size :signed-long)
   (atomType :signed-long)                      ;  = 'schi' 
)

;type name? (%define-record :SecureContentSchemeInfoAtom (find-record-descriptor ':SecureContentSchemeInfoAtom))
; #pragma options align=reset

; #endif /* __MOVIESFORMAT__ */


(provide-interface "MoviesFormat")