(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:MusicPlayer.h"
; at Sunday July 2,2006 7:27:03 pm.
; 
;      File:       MusicPlayer.h
;  
;      Contains:   MusicPlayer application interfaces
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2000-2001 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __MusicPlayer
; #define __MusicPlayer

(require-interface "CoreServices/CoreServices")

(require-interface "CoreFoundation/CoreFoundation")

(require-interface "AudioUnit/MusicDevice")

(require-interface "AudioToolbox/AUGraph")

(require-interface "CoreMIDI/MIDIServices")

; #if defined(__cplusplus)
#|
extern "C"
{
#endif
|#
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  Basic idea behind the Sequencing Services APIs:
; 
; 		A MusicSequence contains an arbitrary number of tracks (MusicTrack)
; 		each of which contains time-stamped (in units of beats)
; 		events in time-increasing order.  There are various types of events, defined below,
; 		including the expected MIDI events, tempo, and extended events.
; 		A MusicTrack has properties which may be inspected and assigned, including support
; 		for looping, muting/soloing, and time-stamp interpretation.
; 		APIs exist for iterating through the events in a MusicTrack, and for performing
; 		basic editing operations on them.
; 
; 		Each MusicSequence may have an associated AUGraph object, which represents a set
; 		of AudioUnits and the connections between them.  Then, each MusicTrack of the
; 		MusicSequence may address its events to a specific AudioUnit within the AUGraph.
; 		In such a manner, it's possible to automate arbitrary parameters of AudioUnits,
; 		and schedule notes to be played to MusicDevices (AudioUnit software synthesizers)
; 		within an arbitrary audio processing network (AUGraph).
; 
;  MusicSequence global information is:
; 		- an AUGraph
; 		- copyright and other textual info
; 
;  MusicTrack properties are:
; 		- AUNode (in the AUGraph) of the AudioUnit addressed by the MusicTrack
; 		- mute / solo state
; 		- offset time
; 		- loop time and number of loops
; 				The default looping behaviour is to loop once through the entire track
; 				pass zero in for inNumberOfLoops to loop forever
; 		- time units for the event timestamps (beats, seconds, ...)
; 			beats go through tempo map, seconds map absolute time
; 		- automated - in this case the track:
; 			(1) Can only contain parameter events
; 				- these events are interpreted as points in the automation curve
; 			(2) Track can only address a v2 AudioUnit 
; 		- duration - the time of the last event in the track plus any additional time that is allowed
; 			when for instance a MIDI file is read in and puts its end of track event past the last event
; 			to allow for fading out of ending notes
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  definition of the events supported by the sequencer
;  music event types, including both MIDI and "extended" protocol

(defconstant $kMusicEventType_NULL 0)
(defconstant $kMusicEventType_ExtendedNote 1)   ;  note with variable number of arguments (non-MIDI)

(defconstant $kMusicEventType_ExtendedControl 2);  control change (non-MIDI)

(defconstant $kMusicEventType_ExtendedTempo 3)  ;  tempo change in BPM

(defconstant $kMusicEventType_User 4)           ;  user defined data

(defconstant $kMusicEventType_Meta 5)           ;  standard MIDI file meta event

(defconstant $kMusicEventType_MIDINoteMessage 6);  MIDI note-on with duration (for note-off)

(defconstant $kMusicEventType_MIDIChannelMessage 7);  MIDI channel messages (other than note-on/off)

(defconstant $kMusicEventType_MIDIRawData 8)    ;  for system exclusive data

(defconstant $kMusicEventType_Parameter 9)      ;  general purpose AudioUnit parameter

(defconstant $kMusicEventType_AUPreset 10)      ;  this is the AU's user preset CFDictionaryRef (the ClassInfo property)
;  always keep at end

(defconstant $kMusicEventType_Last 11)
;  these are flags that can be passed in with MusicSequenceLoadSMFDataWithFlags
; if this flag is set the resultant Sequence will contain:
;  a tempo track
;  1 track for each MIDI Channel that is found in the SMF
;  1 track for SysEx or MetaEvents - this will be the last track 
;  in the sequence after the LoadSMFWithFlags calls

(defconstant $kMusicSequenceLoadSMF_ChannelsToTracks 1)

(def-mactype :MusicSequenceLoadFlags (find-mactype ':UInt32))

(def-mactype :MusicEventType (find-mactype ':UInt32))

(def-mactype :MusicTimeStamp (find-mactype ':double-float))
;  pass this value in to indicate a time passed the last event in the track
;  in this way, it's possible to perform edits on tracks which include all events
;  starting at some particular time up to and including the last event
(defconstant $kMusicTimeStamp_EndOfTrack 1.0E+9)
; #define kMusicTimeStamp_EndOfTrack			1000000000.0
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  event representation
(defrecord MIDINoteMessage
   (channel :UInt8)
   (note :UInt8)
   (velocity :UInt8)
   (reserved :UInt8)
   (duration :single-float)
)
(defrecord MIDIChannelMessage
   (status :UInt8)
                                                ;  contains message and channel
                                                ;  message specific data
   (data1 :UInt8)
   (data2 :UInt8)
   (reserved :UInt8)
)
(defrecord MIDIRawData
   (length :UInt32)
   (data (:array :UInt8 1))
)
(defrecord MIDIMetaEvent
   (metaEventType :UInt8)
   (unused1 :UInt8)
   (unused2 :UInt8)
   (unused3 :UInt8)
   (dataLength :UInt32)
   (data (:array :UInt8 1))
)
(defrecord MusicEventUserData
   (length :UInt32)
   (data (:array :UInt8 1))
)
(defrecord ExtendedNoteOnEvent
   (instrumentID :UInt32)
   (groupID :UInt32)
   (duration :single-float)
   (extendedParams :MusicDeviceNoteParams)
)
(defrecord ExtendedControlEvent
   (groupID :UInt32)
   (controlID :UInt32)
   (value :single-float)
)
(defrecord ParameterEvent
   (parameterID :UInt32)
   (scope :UInt32)
   (element :UInt32)
   (value :single-float)
)
(defrecord ExtendedTempoEvent
   (bpm :double-float)
)
(defrecord AUPresetEvent
   (scope :UInt32)
   (element :UInt32)
   (preset (:pointer :void))
)

(def-mactype :MusicPlayer (find-mactype '(:pointer :OpaqueMusicPlayer)))

(def-mactype :MusicSequence (find-mactype '(:pointer :OpaqueMusicSequence)))

(def-mactype :MusicTrack (find-mactype '(:pointer :OpaqueMusicTrack)))

(def-mactype :MusicEventIterator (find-mactype '(:pointer :OpaqueMusicEventIterator)))
;  See MusicSequenceSetUserCallback

(def-mactype :MusicSequenceUserCallback (find-mactype ':pointer)); (void * inClientData , MusicSequence inSequence , MusicTrack inTrack , MusicTimeStamp inEventTime , const MusicEventUserData * inEventData , MusicTimeStamp inStartSliceBeat , MusicTimeStamp inEndSliceBeat)

(defconstant $kAudioToolboxErr_TrackIndexError -10859)
(defconstant $kAudioToolboxErr_TrackNotFound -10858)
(defconstant $kAudioToolboxErr_EndOfTrack -10857)
(defconstant $kAudioToolboxErr_StartOfTrack -10856)
(defconstant $kAudioToolboxErr_IllegalTrackDestination -10855)
(defconstant $kAudioToolboxErr_NoSequence -10854)
(defconstant $kAudioToolboxErr_InvalidEventType -10853)
(defconstant $kAudioToolboxErr_InvalidPlayerState -10852)
(defconstant $kAudioToolboxErr_CannotDoInCurrentContext -10863)
;  Can't dispose a sequence whilst a MusicPlayer has it. Thus either, before disposing a MusicSequence
;  you either DiposeMusicPlayer or MusicPlayerSetSequence (NULL or another sequence)
;  DisposeMusicSequence will return kAudioToolboxErr_CannotDoInCurrentContext if disposing a sequence 
;  that is in use.
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  MusicPlayer (transport) API's

(deftrap-inline "_NewMusicPlayer" 
   ((outPlayer (:pointer :MUSICPLAYER))
   )
   :OSStatus
() )

(deftrap-inline "_DisposeMusicPlayer" 
   ((inPlayer (:pointer :OpaqueMusicPlayer))
   )
   :OSStatus
() )

(deftrap-inline "_MusicPlayerSetSequence" 
   ((inPlayer (:pointer :OpaqueMusicPlayer))
    (inSequence (:pointer :OpaqueMusicSequence))
   )
   :OSStatus
() )

(deftrap-inline "_MusicPlayerGetSequence" 
   ((inPlayer (:pointer :OpaqueMusicPlayer))
    (outSequence (:pointer :MUSICSEQUENCE))
   )
   :OSStatus
() )
;  The Get and Set Time calls take a specification of time
;  as beats. This positions (or retrieves) the time as beats
;  based on the attached Sequence of the MusicPlayer 

(deftrap-inline "_MusicPlayerSetTime" 
   ((inPlayer (:pointer :OpaqueMusicPlayer))
    (inTime :double-float)
   )
   :OSStatus
() )

(deftrap-inline "_MusicPlayerGetTime" 
   ((inPlayer (:pointer :OpaqueMusicPlayer))
    (outTime (:pointer :MUSICTIMESTAMP))
   )
   :OSStatus
() )
;  Returns a host time value for a given beats time based on the
;  time that the sequence started playing.
; 
;  As this call is only valid if the player is playing this
;  call will return an error if the player is not playing or
;  the postion of the player (its "starting beat") when the
;  player was started.
;  (see the MusicSequence calls for beat<->seconds calls for these speculations)
; 
;  This call is totally dependent on the Sequence attached to the Player,
;  (primarily the tempo map of the Sequence), so the player must have
;  a sequence attached to it or an error is returned.

(deftrap-inline "_MusicPlayerGetHostTimeForBeats" 
   ((inPlayer (:pointer :OpaqueMusicPlayer))
    (inBeats :double-float)
    (outHostTime (:pointer :UInt64))
   )
   :OSStatus
() )
;  Returns a time in beats given a host time based on the
;  time that the sequence started playing.
; 
;  As this call is only valid if the player is playing this
;  call will return an error if the player is not playing, or
;  if inHostTime is sometime before the Player was started.
;  (see the MusicSequence calls for beat<->seconds calls for these speculations)
; 
;  This call is totally dependent on the Sequence attached to the Player,
;  (primarily the tempo map of the Sequence), so the player must have
;  a sequence attached to it or an error is returned.

(deftrap-inline "_MusicPlayerGetBeatsForHostTime" 
   ((inPlayer (:pointer :OpaqueMusicPlayer))
    (inHostTime :UInt64)
    (outBeats (:pointer :MUSICTIMESTAMP))
   )
   :OSStatus
() )
;  allows synth devices to load instrument samples, etc.

(deftrap-inline "_MusicPlayerPreroll" 
   ((inPlayer (:pointer :OpaqueMusicPlayer))
   )
   :OSStatus
() )

(deftrap-inline "_MusicPlayerStart" 
   ((inPlayer (:pointer :OpaqueMusicPlayer))
   )
   :OSStatus
() )

(deftrap-inline "_MusicPlayerStop" 
   ((inPlayer (:pointer :OpaqueMusicPlayer))
   )
   :OSStatus
() )
;  This call returns a non-zero value in outIsPlaying if the player has been
;  started and not stopped. It may have "played" past the valid events of the attached
;  MusicSequence, but it is still considered to be playing (and its time value increasing)
;  in that situation.

(deftrap-inline "_MusicPlayerIsPlaying" 
   ((inPlayer (:pointer :OpaqueMusicPlayer))
    (outIsPlaying (:pointer :Boolean))
   )
   :OSStatus
() )
;  This call will Scale the playback rate by the specified amount
;  It will alter the scheduling of events - so cannot be 0 or less than zero.

(deftrap-inline "_MusicPlayerSetPlayRateScalar" 
   ((inPlayer (:pointer :OpaqueMusicPlayer))
    (inScaleRate :double-float)
   )
   :OSStatus
() )

(deftrap-inline "_MusicPlayerGetPlayRateScalar" 
   ((inPlayer (:pointer :OpaqueMusicPlayer))
    (outScaleRate (:pointer :Float64))
   )
   :OSStatus
() )
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  MusicSequence API's

(deftrap-inline "_NewMusicSequence" 
   ((outSequence (:pointer :MUSICSEQUENCE))
   )
   :OSStatus
() )

(deftrap-inline "_DisposeMusicSequence" 
   ((inSequence (:pointer :OpaqueMusicSequence))
   )
   :OSStatus
() )
;  create a new track in the sequence

(deftrap-inline "_MusicSequenceNewTrack" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (outTrack (:pointer :MUSICTRACK))
   )
   :OSStatus
() )
;  removes the track from a sequence and disposes the track

(deftrap-inline "_MusicSequenceDisposeTrack" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (inTrack (:pointer :OpaqueMusicTrack))
   )
   :OSStatus
() )

(deftrap-inline "_MusicSequenceGetTrackCount" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (outNumberOfTracks (:pointer :UInt32))
   )
   :OSStatus
() )

(deftrap-inline "_MusicSequenceGetIndTrack" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (inTrackIndex :UInt32)
    (outTrack (:pointer :MUSICTRACK))
   )
   :OSStatus
() )
;  returns error if track is not found in the sequence

(deftrap-inline "_MusicSequenceGetTrackIndex" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (inTrack (:pointer :OpaqueMusicTrack))
    (outTrackIndex (:pointer :UInt32))
   )
   :OSStatus
() )
;  Tempo events are segregated onto a separate track when imported from a MIDI File.
;  Only tempo events in this special tempo track (which is not accessible with 
;  MusicSequenceGetTrackCount / MusicSequenceGetIndTrack) have effect on playback.
;  This track may be edited like any other, however.

(deftrap-inline "_MusicSequenceGetTempoTrack" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (outTrack (:pointer :MUSICTRACK))
   )
   :OSStatus
() )
;  To address the sequence events to a particular AUGraph, use MusicSequenceSetAUGraph()
;  By default the first AUNode representing a DLS MusicDevice will be used as the destination
;  Please see MusicTrackSetDestNode() in order to change the addressing on a track by track basis.
; 
;  Instead of addressing a sequence to an AUGraph, the MusicSequenceSetMIDIEndpoint() call may
;  be used to set all tracks to address the particular MIDI device.
;  It is then possible to override individual tracks to address either a different MIDIEndpoint
;  with MusicTrackSetDestMIDIEndpoint() or an AudioUnit with MusicTrackSetDestNode().
;  This allows the mixing of sequencing software synths (and other AudioUnits) along with
;  MIDI devices.

(deftrap-inline "_MusicSequenceSetAUGraph" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (inGraph (:pointer :OpaqueAUGraph))
   )
   :OSStatus
() )

(deftrap-inline "_MusicSequenceGetAUGraph" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (outGraph (:pointer :AUGRAPH))
   )
   :OSStatus
() )
;  convenience function which sets the destination of each MusicTrack in the MusicSequence
;  to the given MIDIEndpointRef

(deftrap-inline "_MusicSequenceSetMIDIEndpoint" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (inEndpoint (:pointer :OpaqueMIDIEndpoint))
   )
   :OSStatus
() )
;  standard MIDI files (SMF, and RMF)
;  MusicSequenceLoadSMF() also intelligently parses an RMID file to extract SMF part

(deftrap-inline "_MusicSequenceLoadSMF" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (inFileSpec (:pointer :FSSpec))
   )
   :OSStatus
() )

(deftrap-inline "_MusicSequenceLoadSMFData" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (inData (:pointer :__CFData))
   )
   :OSStatus
() )
;  passing a value of zero for the flags makes this call equivalent to MusicSequenceLoadSMFData
;  a paramErr is returned if the sequence has ANY data in it and the flags value is != 0
;  This will create a sequence with the first tracks containing MIDI Channel data
;  IF the MIDI file had Meta events or SysEx data, then the last track in the sequence
;  will contain that data.

(deftrap-inline "_MusicSequenceLoadSMFWithFlags" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (inFileRef (:pointer :FSRef))
    (inFlags :UInt32)
   )
   :OSStatus
() )

(deftrap-inline "_MusicSequenceLoadSMFDataWithFlags" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (inData (:pointer :__CFData))
    (inFlags :UInt32)
   )
   :OSStatus
() )
;  inResolution is relationship between "tick" and quarter note for saving to SMF
;   - pass in zero to use default (480 PPQ, normally)

(deftrap-inline "_MusicSequenceSaveSMF" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (inFileSpec (:pointer :FSSpec))
    (inResolution :UInt16)
   )
   :OSStatus
() )

(deftrap-inline "_MusicSequenceSaveSMFData" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (outData (:pointer :CFDataRef))
    (inResolution :UInt16)
   )
   :OSStatus
() )
;  Additional APIs will be created for persistence (loading/saving) of MusicSequences
;  which contain non-MIDI events.  A new sequence data format must be defined.
;  "reverses" (in time) all events (including tempo events)

(deftrap-inline "_MusicSequenceReverse" 
   ((inSequence (:pointer :OpaqueMusicSequence))
   )
   :OSStatus
() )
;  Returns a seconds value that would correspond to the supplied beats 

(deftrap-inline "_MusicSequenceGetSecondsForBeats" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (inBeats :double-float)
    (outSeconds (:pointer :Float64))
   )
   :OSStatus
() )
;  Returns a beats value that would correspond to the supplied seconds 

(deftrap-inline "_MusicSequenceGetBeatsForSeconds" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (inSeconds :double-float)
    (outBeats (:pointer :MUSICTIMESTAMP))
   )
   :OSStatus
() )
;  This call is used to register (or remove if inCallback is NULL) a callback 
;  that the MusicSequence will call for ANY UserEvents that are added to any of the
;  tracks of the sequence.
;  If there is a callback registered, then UserEvents WILL BE CHASED when 
;  MusicPlayerSetTime is called. In that case the inStartSliceBeat and inEndSliceBeat
;  will both be the same value and will be the beat that the player is chasing too.
;  In normal cases, where the sequence data is being scheduled for playback, the
;  following will apply:
; 	inStartSliceBeat <= inEventTime < inEndSliceBeat
;  The only exception to this is if the track that owns the MusicEvent is looping.
;  In this case the start beat will still be less than the end beat (so your callback
;  can still determine that it is playing, and what beats are currently being scheduled),
;  however, the inEventTime will be the original time-stamped time of the user event. 

(deftrap-inline "_MusicSequenceSetUserCallback" 
   ((inSequence (:pointer :OpaqueMusicSequence))
    (inCallback :pointer)
    (inClientData :pointer)
   )
   :OSStatus
() )
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  MusicTrack API's

(deftrap-inline "_MusicTrackGetSequence" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (outSequence (:pointer :MUSICSEQUENCE))
   )
   :OSStatus
() )
;  This overrides any previous MIDIEndpoint destination or AUNode destination

(deftrap-inline "_MusicTrackSetDestNode" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inNode :SInt32)
   )
   :OSStatus
() )
;  This overrides any previous MIDIEndpoint destination or AUNode destination

(deftrap-inline "_MusicTrackSetDestMIDIEndpoint" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inEndpoint (:pointer :OpaqueMIDIEndpoint))
   )
   :OSStatus
() )
;  returns kAudioToolboxErr_IllegalTrackDestination if the track destination is
;  a MIDIEndpointRef and NOT an AUNode

(deftrap-inline "_MusicTrackGetDestNode" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (outNode (:pointer :AUNODE))
   )
   :OSStatus
() )
;  returns kAudioToolboxErr_IllegalTrackDestination if the track destination is
;  an AUNode and NOT a MIDIEndpointRef

(deftrap-inline "_MusicTrackGetDestMIDIEndpoint" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (outEndpoint (:pointer :MIDIENDPOINTREF))
   )
   :OSStatus
() )
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  SequenceTrack Properties:
; 
;  inLength is currently ignored for the properties with fixed size...

(deftrap-inline "_MusicTrackSetProperty" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inPropertyID :UInt32)
    (inData :pointer)
    (inLength :UInt32)
   )
   :OSStatus
() )
;  if outData is NULL, then the length of the data will be passed back in outLength
;  This allows the client to allocate a buffer of the correct size (useful for variable
;  length properties -- currently all properties have fixed size)

(deftrap-inline "_MusicTrackGetProperty" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inPropertyID :UInt32)
    (outData :pointer)
    (ioLength (:pointer :UInt32))
   )
   :OSStatus
() )
;  the values for these properties are always passed by addressed (with get or set)
;  struct {MusicTimeStamp loopLength; long numberOfLoops;};

(defconstant $kSequenceTrackProperty_LoopInfo 0);  MusicTimeStamp offsetTime;

(defconstant $kSequenceTrackProperty_OffsetTime 1);  Boolean muteState;

(defconstant $kSequenceTrackProperty_MuteStatus 2);  Boolean soloState;

(defconstant $kSequenceTrackProperty_SoloStatus 3); UInt32 automatedState;

(defconstant $kSequenceTrackProperty_AutomatedParameters 4);  MusicTimeStamp trackLength

(defconstant $kSequenceTrackProperty_TrackLength 5)
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  Editing operations on sequence tracks
;  Note: All time ranges are as follows [starttime, endtime)
;  In other words, the range includes the start time, but includes events only up
;  to, but NOT including the end time...
;  inMoveTime may be negative to move events backwards in time

(deftrap-inline "_MusicTrackMoveEvents" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inStartTime :double-float)
    (inEndTime :double-float)
    (inMoveTime :double-float)
   )
   :OSStatus
() )

(deftrap-inline "_NewMusicTrackFrom" 
   ((inSourceTrack (:pointer :OpaqueMusicTrack))
    (inSourceStartTime :double-float)
    (inSourceEndTime :double-float)
    (outNewTrack (:pointer :MUSICTRACK))
   )
   :OSStatus
() )
;  removes all events in the given range												

(deftrap-inline "_MusicTrackClear" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inStartTime :double-float)
    (inEndTime :double-float)
   )
   :OSStatus
() )
;  same as MusicTrackClear(), but also moves all following events back
;  by the range's duration

(deftrap-inline "_MusicTrackCut" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inStartTime :double-float)
    (inEndTime :double-float)
   )
   :OSStatus
() )
;  the given source range is inserted at inDestInsertTime in inDestTrack
;  (all events at and after inDestInsertTime in inDestTrack are moved forward by the
;   range's duration)

(deftrap-inline "_MusicTrackCopyInsert" 
   ((inSourceTrack (:pointer :OpaqueMusicTrack))
    (inSourceStartTime :double-float)
    (inSourceEndTime :double-float)
    (inDestTrack (:pointer :OpaqueMusicTrack))
    (inDestInsertTime :double-float)
   )
   :OSStatus
() )
;  the given source range is merged with events starting at inDestInsertTime in inDestTrack

(deftrap-inline "_MusicTrackMerge" 
   ((inSourceTrack (:pointer :OpaqueMusicTrack))
    (inSourceStartTime :double-float)
    (inSourceEndTime :double-float)
    (inDestTrack (:pointer :OpaqueMusicTrack))
    (inDestInsertTime :double-float)
   )
   :OSStatus
() )
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  actual event representation and manipulation within a track....
; 
;  Here we need to be very careful to be able to deal with both SMF type of MIDI events, and
;  also be upwardly compatible with an extended MPEG4-SA like paradigm!
; 
;  The solution is to hide the internal event representation from the client
;  and allow access to the events through accessor functions.  The user, in this way, can
;  examine and create standard events, or any user-defined event.
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  sequence track event access and manipulation
;  event iterator objects on tracks

(deftrap-inline "_NewMusicEventIterator" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (outIterator (:pointer :MUSICEVENTITERATOR))
   )
   :OSStatus
() )

(deftrap-inline "_DisposeMusicEventIterator" 
   ((inIterator (:pointer :OpaqueMusicEventIterator))
   )
   :OSStatus
() )
;  passing in kMusicTimeStamp_EndOfTrack for inBeat will position "iterator" to the end of track
;     	(which is pointing to the space just AFTER the last event)
; 		(use MusicEventIteratorPreviousEvent() to backup one, if you want last event)

(deftrap-inline "_MusicEventIteratorSeek" 
   ((inIterator (:pointer :OpaqueMusicEventIterator))
    (inTimeStamp :double-float)
   )
   :OSStatus
() )
;  seeks track "iterator" to the next event
;   (if the iterator is at the last event, then it moves PAST the last event and no longer points to an event
;  ALWAYS check to see if there is an event at the iterator

(deftrap-inline "_MusicEventIteratorNextEvent" 
   ((inIterator (:pointer :OpaqueMusicEventIterator))
   )
   :OSStatus
() )
;  seeks track "iterator" to the previous event
;   (if the iterator is already at the first event, then it remains unchanged and
;    an error is returned)

(deftrap-inline "_MusicEventIteratorPreviousEvent" 
   ((inIterator (:pointer :OpaqueMusicEventIterator))
   )
   :OSStatus
() )
;  returns an error if the track's "iterator" is currently at the end of the track
;  depending on the event type, cast the returned void* pointer to:
; 
; 		kMusicEventType_ExtendedNote			ExtendedNoteOnEvent*
; 		kMusicEventType_ExtendedControl			ExtendedControlEvent*
; 		kMusicEventType_ExtendedTempo			ExtendedTempoEvent*
; 		kMusicEventType_User					<user-defined-data>*
; 		kMusicEventType_Meta					MIDIMetaEvent*
; 		kMusicEventType_MIDINoteMessage			MIDINoteMessage*
; 		kMusicEventType_MIDIChannelMessage		MIDIChannelMessage*
; 		kMusicEventType_MIDIRawData				MIDIRawData*
; 		kMusicEventType_Parameter				ParameterEvent*
; 		kMusicEventType_AUPreset				AUPresetEvent*

(deftrap-inline "_MusicEventIteratorGetEventInfo" 
   ((inIterator (:pointer :OpaqueMusicEventIterator))
    (outTimeStamp (:pointer :MUSICTIMESTAMP))
    (outEventType (:pointer :MUSICEVENTTYPE))
    (outEventData :pointer)
    (outEventDataSize (:pointer :UInt32))
   )
   :OSStatus
() )
;  replaces the current event; note that its type may change but its time may not

(deftrap-inline "_MusicEventIteratorSetEventInfo" 
   ((inIterator (:pointer :OpaqueMusicEventIterator))
    (inEventType :UInt32)
    (inEventData :pointer)
   )
   :OSStatus
() )
;  deletes the event at the current "iterator"

(deftrap-inline "_MusicEventIteratorDeleteEvent" 
   ((inIterator (:pointer :OpaqueMusicEventIterator))
   )
   :OSStatus
() )

(deftrap-inline "_MusicEventIteratorSetEventTime" 
   ((inIterator (:pointer :OpaqueMusicEventIterator))
    (inTimeStamp :double-float)
   )
   :OSStatus
() )
;  We're NOT CHECKING THE ERROR CODE HERE!!!!!!
;  To use the iterator going forward when looping...
;  	New Iterator (points at first event)
; 	bool hasCurrentEvent;
; 	MusicEventIteratorHasCurrentEvent(iter, &hasCurrentEvent);
;  	while (hasCurrentEvent) {
;  		do work... MusicEventIteratorGetEventInfo (iter, ...
; 		
; 		MusicEventIteratorNextEvent (iter)
; 		MusicEventIteratorHasCurrentEvent(iter, &hasCurrentEvent);
; 	}
;  Or to go back...
;  	New Iterator
;  	MusicEventIteratorSeek (iter, kMusicTimeStamp_EndOfTrack) -> will point it past the last event
; 
;  	while (MusicEventIteratorPreviousEvent (iter) == noErr) {
;  		do work... MusicEventIteratorGetEventInfo (iter, ...
; 
;  	}
;  You can "rock" the Iterator back and forwards as well of course

(deftrap-inline "_MusicEventIteratorHasPreviousEvent" 
   ((inIterator (:pointer :OpaqueMusicEventIterator))
    (outHasPreviousEvent (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_MusicEventIteratorHasNextEvent" 
   ((inIterator (:pointer :OpaqueMusicEventIterator))
    (outHasNextEvent (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_MusicEventIteratorHasCurrentEvent" 
   ((inIterator (:pointer :OpaqueMusicEventIterator))
    (outHasCurrentEvent (:pointer :Boolean))
   )
   :OSStatus
() )
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  adding time-stamped events to the track

(deftrap-inline "_MusicTrackNewMIDINoteEvent" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inTimeStamp :double-float)
    (inMessage (:pointer :MIDINOTEMESSAGE))
   )
   :OSStatus
() )

(deftrap-inline "_MusicTrackNewMIDIChannelEvent" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inTimeStamp :double-float)
    (inMessage (:pointer :MIDICHANNELMESSAGE))
   )
   :OSStatus
() )

(deftrap-inline "_MusicTrackNewMIDIRawDataEvent" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inTimeStamp :double-float)
    (inRawData (:pointer :MIDIRAWDATA))
   )
   :OSStatus
() )

(deftrap-inline "_MusicTrackNewExtendedNoteEvent" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inTimeStamp :double-float)
    (inInfo (:pointer :EXTENDEDNOTEONEVENT))
   )
   :OSStatus
() )

(deftrap-inline "_MusicTrackNewExtendedControlEvent" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inTimeStamp :double-float)
    (inInfo (:pointer :EXTENDEDCONTROLEVENT))
   )
   :OSStatus
() )

(deftrap-inline "_MusicTrackNewParameterEvent" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inTimeStamp :double-float)
    (inInfo (:pointer :PARAMETEREVENT))
   )
   :OSStatus
() )

(deftrap-inline "_MusicTrackNewExtendedTempoEvent" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inTimeStamp :double-float)
    (inBPM :double-float)
   )
   :OSStatus
() )

(deftrap-inline "_MusicTrackNewMetaEvent" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inTimeStamp :double-float)
    (inMetaEvent (:pointer :MIDIMETAEVENT))
   )
   :OSStatus
() )

(deftrap-inline "_MusicTrackNewUserEvent" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inTimeStamp :double-float)
    (inUserData (:pointer :MUSICEVENTUSERDATA))
   )
   :OSStatus
() )

(deftrap-inline "_MusicTrackNewAUPresetEvent" 
   ((inTrack (:pointer :OpaqueMusicTrack))
    (inTimeStamp :double-float)
    (inPresetEvent (:pointer :AUPRESETEVENT))
   )
   :OSStatus
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif // __MusicPlayer


(provide-interface "MusicPlayer")