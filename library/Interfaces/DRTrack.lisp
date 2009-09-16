(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRTrack.h"
; at Sunday July 2,2006 7:27:43 pm.
; 
;      File:       DiscRecordingEngine/DRTrack.h
;  
;      Contains:   Base class for track handling.
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 

; #import <Foundation/Foundation.h>

; #import <DiscRecordingEngine/DRCoreTrack.h>

; #import <DiscRecordingEngine/DRDevice.h>

(require-interface "stdint")

(require-interface "AvailabilityMacros")
; !
; 	@class 		DRTrack
; 	@abstract	The DRTrack class represents a track on the burned disc.
; 	@discussion	
; 	<h3>About tracks</h3>
; 
; 	A DRTrack provides data to the for the burn and contains a description of the 
; 	track on disc (length, block type, data format, etc). 
; 	Data is provided for the burn in a real-time thread. It is up to the track to 
; 	provide this data in a timely manner, otherwise a burn underrun can occur and
; 	ruin a disc.
; 	
; 	<h3>Data Production</h3>
; 
; 	DRTracks do not typically store or cache the data to be written to disk, instead the 
; 	data is streamed to the disc from some data producer as it's needed. This is 
; 	accomplished through an object associated with the track when the track is created 
; 	called the <i>track producer</i>. A track producer is a class you create that implements 
; 	the DRTrackDataProduction informal protocol. This informal protocol defines all of 
; 	the methods that a track object will call during a burn to obtain data. See the 
; 	documentation for the DRTrackDataProduction informal protocol for more information.
; 	
; 	<h3>Track Properties</h3>
; 
; 	A DRTrack object contains several properties which define the track for the burn.
; 	These properties are stored in an NSDictionary and are accessed through the <b>properties</b>
; 	and <b>setProperties:</b> methods. 
; 	
; 	There are several properties that are required to be present and if they are not, will 
; 	cause the burn to fail. These are:
; 	
; 	<ul>
; 	<li>DRTrackLengthKey	Length of the track (see the DRMSF class documentation)</li>
; 	<li>DRBlockSizeKey	Size in bytes of each track block</li>
; 	<li>DRBlockTypeKey	Type of each track block</li>
; 	<li>DRDataFormKey		Data form of each block in the track</li>
; 	<li>DRSessionFormatKey Session format of the track</li>
; 	<li>DRTrackModeKey	Track mode of the track</li>
; 	</ul>
; 	
; 	The possible values of these properties are defined in the Mt. Fuji (IFF-8090i) 
; 	specification for CD/DVD devices. It's up to you to understand the possble values
; 	and meanings of each. However, there are two categories on DRTrack which you may 
; 	find useful. The first defines a method - <b>trackWithAudioOfLength:producer:</b> - which
; 	creates a track configured with the required properties to burn an audio track. The
; 	second defines - <b>trackForRootFolder:</b> - which uses the content creation classes to
; 	create a fully prepared track ready to write a data track. 
; 	
; 	All other keys contained in the properties dictionary are optional and can be omitted.
; 
#| @INTERFACE 
DRTrack : NSObject 
{ 
private
	void*	_ref;
}


- (id) initWithProducer:(id)producer;


- (NSDictionary*) properties;


- (void) setProperties:(NSDictionary*)properties;


- (float) testProductionSpeedForInterval:(NSTimeInterval)interval;


- (float) testProductionSpeedForLength:(uint32_t)length;


#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (uint64_t) estimateLength;
#endif

|#
;  ------------------------------------ 
;  Property convenience methods 
#| @INTERFACE 
DRTrack (PropertyConvenience)


- (DRMSF*) length;


- (DRMSF*) preGap;


- (void) setPreGap:(DRMSF*)preGap;

|#
;  ------------------------------------ 
; !
; 	@protocol 	DRTrackDataProduction
; 	@abstract	Informal protocol describing methods implemented by a track data producer.
; 	@discussion	
; 	The DRTrackDataProduction informal protocol defines those methods that a track data producer 
; 	instance can implement. A track data producer is the object that is
; 	resposible for providing the track data to the burn engine on request. 
; 	
; 	In concept a track data producer similar to an NSTable data source in Cocoa. 
; 	Each producer method receives a pointer to the track it should produce data for. 
; 	There is one method that <b>must</b> be implemented -
; 	<b>produceDataForTrack:intoBuffer:length:atAddress:blockSize:ioFlags:</b>.
; 	
; 	The methods of this protocol will be called in roughly this order:
; 	
; 	<ol type="1">
; 	<li><b>prepareTrackForBurn:</b></li>
; 	<li><b>producePreGapForTrack:intoBuffer:length:atAddress:blockSize:ioFlags:</b></li>
; 	<li><b>produceDataForTrack:intoBuffer:length:atAddress:blockSize:ioFlags:</b></li>
; 	<li><b>prepareTrackForVerification:</b></li>
; 	<li><b>verifyDataForTrack:inBuffer:length:atAddress:blockSize:ioFlags:</b></li>
; 	<li><b>cleanupTrackAfterVerification:</b></li>
; 	<li><b>cleanupTrackAfterBurn:</b></li>
; 	</ol>
; 	
; 	If verification of the disc is not requested, or a track omits or defines 
; 	DRVerificationTypeKey to be DRVerificationTypeNone, then 
; 	<b>prepareTrackForVerification:</b>, 
; 	<b>verifyDataForTrack:inBuffer:length:atAddress:blockSize:ioFlags:</b> and
; 	<b>cleanupTrackAfterVerification:</b>
; 	will not be called.
; 	
; 	During a burn, <b>produceDataForTrack:intoBuffer:length:atAddress:blockSize:ioFlags:</b> is called
; 	very frequently in a real-time thread. Because of this, it is of utmost importance that
; 	this method very effficient and does not perform any long task, since by doing so, the
; 	burn may fail because data is not available to write to the disc.
; 
#| @PROTOCOL 
DRTrackDataProduction


#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (uint64_t) estimateLengthOfTrack:(DRTrack*)track;
#endif


- (BOOL) prepareTrack:(DRTrack*)track forBurn:(DRBurn*)burn toMedia:(NSDictionary*)mediaInfo;


- (void) cleanupTrackAfterBurn:(DRTrack*)track;


- (uint32_t) producePreGapForTrack:(DRTrack*)track intoBuffer:(char*)buffer length:(uint32_t)bufferLength atAddress:(uint64_t)address blockSize:(uint32_t)blockSize ioFlags:(uint32_t*)flags;


- (uint32_t) produceDataForTrack:(DRTrack*)track intoBuffer:(char*)buffer length:(uint32_t)bufferLength atAddress:(uint64_t)address blockSize:(uint32_t)blockSize ioFlags:(uint32_t*)flags;


- (BOOL) prepareTrackForVerification:(DRTrack*)track;


- (BOOL) verifyDataForTrack:(DRTrack*)track inBuffer:(const char*)buffer length:(uint32_t)bufferLength atAddress:(uint64_t)address blockSize:(uint32_t)blockSize ioFlags:(uint32_t*)flags;


- (BOOL) cleanupTrackAfterVerification:(DRTrack*)track;

|#
;  ------------------------------------ 
; 	The following track properties are required, and must be set on every track. 
; 	Note that the preconfigured tracks have these properties set already. 

; #if 0
#| ; #pragma mark Required Track Properties
 |#

; #endif

; !
; 	@const		DRTrackLengthKey
; 	@discussion	DRMSF representing the length of the track (see the DRMSF class documentation)
; 
(def-mactype :DRTrackLengthKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRBlockSizeKey
; 	@discussion	NSNumber containing the size in bytes of each track block. 
; 				See the Mt. Fuji (INF-8090i) specification for CD/DVD devices for possible
; 				values for this property.
; 
(def-mactype :DRBlockSizeKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRBlockTypeKey
; 	@discussion	NSNumber containing the type of each track block.
; 				See the Mt. Fuji (INF-8090i) specification for CD/DVD devices for possible
; 				values for this property.
; 
(def-mactype :DRBlockTypeKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDataFormKey
; 	@discussion	NSNumber containing the data form of each block in the track.
; 				See the Mt. Fuji (INF-8090i) specification for CD/DVD devices for possible
; 				values for this property.
; 
(def-mactype :DRDataFormKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRSessionFormatKey
; 	@discussion	NSNumber containing the session format of the track.
; 				See the Mt. Fuji (INF-8090i) specification for CD/DVD devices for possible
; 				values for this property.
; 
(def-mactype :DRSessionFormatKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRTrackModeKey
; 	@discussion	NSNumber containing the track mode of the track.
; 				See the Mt. Fuji (INF-8090i) specification for CD/DVD devices for possible
; 				values for this property.
; 
(def-mactype :DRTrackModeKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ------------------------------------ 
; 	The following track properties are optional, and are not required.  The burn engine
; 	will generally assume reasonable defaults, but if you need more specific control
; 	over particular properties you can use these keys. 

; #if 0
#| ; #pragma mark Optional Track Properties
 |#

; #endif

; !
; 	@const		DRVerificationTypeKey
; 	@discussion	NSString indicating the type of verification to be performed. If this is not
; 				present, the track will not be verified.
; 
(def-mactype :DRVerificationTypeKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRMaxBurnSpeedKey
; 	@discussion	NSNumber containing the maximum burn speed at which data can be produced. 
; 				The speed is represented in KB/s (1 KB = 1000 bytes).  This key can only
; 				be used to limit the speed at which the burn runs.
; 
(def-mactype :DRMaxBurnSpeedKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRPreGapLengthKey
; 	@discussion	For CD tracks only.  NSNumber containing the length of silence or data at the
; 				beginning of the track.  This defaults to 2 seconds of silence. If this 
; 				key is present, the track producer will be asked for the pregap data first.
; 				If the producer implements the proper selector, then it's the responsibility
; 				of the producer to provide data for the pregap, otherwise that length of 
; 				silence will be produced by DiscRecording.
; 
(def-mactype :DRPreGapLengthKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDVDTimestampKey
; 	@discussion	For DVD tracks only.  NSData containing the DVD timestamp structure sent
; 				through the SEND DVD STRUCTURE command.  The contents of this will be
; 				sent directly to the drive.
; 
(def-mactype :DRDVDTimestampKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDVDCopyrightInfoKey
; 	@discussion	For DVD tracks only.  NSData containing the DVD copyright info structure
; 				sent through the SEND DVD STRUCTURE command.  The contents of this will
; 				be sent directly to the drive.
; 
(def-mactype :DRDVDCopyrightInfoKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRTrackISRCKey
; 	@discussion	For CD-DA audio tracks only.  This key points to an NSData containing
; 				exactly 12 bytes, which will be written to the disc as the International
; 				Standard Recording Code (ISRC).  If this key is not present, no ISRC
; 				is written.
; 				
; 				The use of this value should conform to the specifications of the IFPI. See
; 				http://www.ifpi.org/isrc/ for more details on the ISRC standard.
; 				
; 				Not all drives are capable of the write modes necessary to write the ISRC.
; 				If this key is present in any track and the drive cannot write the ISRC, the
; 				burn will fail with kDRDeviceCantWriteISRCErr.
; 
(def-mactype :DRTrackISRCKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRIndexPointsKey
; 	@discussion	For CD tracks only. This key points to an NSArray of NSNumbers, indicating
; 				the index points inside the track.  Each index point is specified as a number
; 				of blocks (frames) relative to the start of the track.  There are 75 blocks
; 				in one second of CD audio.  No more than 98 index points may be specified
; 				for a track.
; 				
; 				Not all drives are capable of writing index points, and not all consumer
; 				CD players report or use them.  If this key is present in any track and the
; 				drive cannot write index points, the burn will fail with
; 				kDRDeviceCantWriteIndexPointsErr.
; 
(def-mactype :DRIndexPointsKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRAudioPreEmphasisKey
; 	@discussion	For CD-DA audio tracks only. This key points to a BOOL value indicating
; 				whether the track includes pre-emphasis of 50/15us.  If this key is not
; 				present, the engine will use a default value of NO.  On the media, this
; 				key corresponds to bit 0 of the control field in sub-channel Q.
; 
(def-mactype :DRAudioPreEmphasisKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRAudioFourChannelKey
; 	@discussion	For CD-DA audio tracks only. This key points to a BOOL value indicating
; 				whether the track data has four channels, as opposed to the
; 				two channels of normal stereo.  If this key is not present, the engine
; 				will use a default value of NO and standard two-channel stereo
; 				is assumed.
; 				
; 				Note that while four-channel is technically allowed in the Red Book,
; 				it never caught on and is probably being replaced by SACD, so
; 				you probably shouldn't attempt to use it.
; 				
; 				On the media, this key corresponds to bit 3 of the control field in
; 				sub-channel Q.
; 
(def-mactype :DRAudioFourChannelKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRSerialCopyManagementStateKey
; 	@discussion	For CD tracks only.  This key points to an NSString value indicating the
; 				SCMS state of the track.  If this key is not present, no SCMS data is
; 				written.
; 				
; 				Not all drives are capable of writing SCMS.  If this key is present in
; 				any track and the drive cannot write SCMS, the burn will fail with
; 				kDRDeviceCantWriteSCMSErr.
; 
(def-mactype :DRSerialCopyManagementStateKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  ------------------------------------ 
;  Verification types 
; !
; 	@const		DRVerificationTypeProduceAgain
; 	@discussion	One of the possible values of the DRVerificationTypeKey.
; 				The engine will simply begin another production cycle and start calling 
; 				<b>produceDataIntoBuffer:length:atAddress:blockSize:ioFlags:</b> again.
; 
(def-mactype :DRVerificationTypeProduceAgain (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRVerificationTypeReceiveData
; 	@discussion	One of the possible values of the DRVerificationTypeKey.
; 				The engine will begin reading data from the disc and calling
; 				<b>verifyDataInBuffer:length:atAddress:blockSize:ioFlags:</b>.
; 
(def-mactype :DRVerificationTypeReceiveData (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRVerificationTypeNone
; 	@discussion	One of the possible values of the DRVerificationTypeKey.
; 				No verification is desired, so verification will be skipped.
; 
(def-mactype :DRVerificationTypeNone (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ------------------------------------ 
;  SCMS states 
; !
; 	@const		DRSCMSCopyrightFree
; 	@discussion	One possible value for the DRSerialCopyManagementStateKey.  Indicates that
; 				the track has no copying restrictions.  Copies of this track should also be
; 				copyright free.
; 
(def-mactype :DRSCMSCopyrightFree (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRSCMSCopyrightProtectedOriginal
; 	@discussion	One possible value for the DRSerialCopyManagementStateKey.  Indicates that
; 				the track is an original subject to copyright protection.  Digital copying of
; 				this track should be allowed, but copies should be marked with SCMS.
; 
(def-mactype :DRSCMSCopyrightProtectedOriginal (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRSCMSCopyrightProtectedCopy
; 	@discussion	One possible value for the DRSerialCopyManagementStateKey.  Indicates that
; 				the track is a first-generation copy of an original that was subject to copy
; 				protection.  No further digital copying should be allowed.
; 
(def-mactype :DRSCMSCopyrightProtectedCopy (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  ------------------------------------ 
; 	The following track properties are read-only, and are only valid on DRTrackRefs
; 	that have been created by the burn engine to represent the existing tracks on a disc. 

; #if 0
#| ; #pragma mark Read-Only Track Properties
 |#

; #endif

; !
; 	@const		DRNextWritableAddressKey
; 	@discussion	This key points to a NSNumber value holding the LBA of the next writable address
; 				in the track. This key is not present in closed tracks.
; 
(def-mactype :DRNextWritableAddressKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRTrackStartAddressKey
; 	@discussion	This key points to a NSNumber value holding the LBA of the start address for the
; 				track.
; 
(def-mactype :DRTrackStartAddressKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRFreeBlocksKey
; 	@discussion	This key points to a NSNumber value holding the length, in blocks, which is
; 				still available in a writable track.
; 
(def-mactype :DRFreeBlocksKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRTrackNumberKey
; 	@discussion	This key points to a NSNumber value holding the physical track number of a track.
; 
(def-mactype :DRTrackNumberKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRSessionNumberKey
; 	@discussion	This key points to a NSNumber value holding the physical session number of a track.
; 
(def-mactype :DRSessionNumberKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRTrackTypeKey
; 	@discussion	This key points to a NSString indicating the type of track. Possible values are: 
; 				DRTrackTypeInvisible, DRTrackTypeIncomplete, DRTrackTypeReserved or DRTrackTypeClosed.
; 
(def-mactype :DRTrackTypeKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRTrackIsEmptyKey
; 	@discussion	This key points to a BOOL and indicates whether the track is empty.
; 
(def-mactype :DRTrackIsEmptyKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRTrackPacketTypeKey
; 	@discussion	This key points to a NSString indicating the kind of packets being written.
; 
(def-mactype :DRTrackPacketTypeKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRTrackPacketSizeKey
; 	@discussion	This key points to a NSNumber that contains the number of blocks per packet for
; 				the disc. It will only be present if the disc contains fixed packets. This key
; 				will contain 16 for DVD media, and typically contains either 16 or 32 for CD media.
; 
(def-mactype :DRTrackPacketSizeKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  --------------------------------- 
;  Track types 
; !
; 	@const		DRTrackTypeInvisible
; 	@discussion	If this is the value of the DRTrackTypeKey then the track is invisible and
; 				available to writing. If it is packet written and not closed, DRPacketTypeKey will
; 				be present, along with DRTrackPacketType and DRTrackPacketSize keys.
; 
(def-mactype :DRTrackTypeInvisible (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRTrackTypeIncomplete
; 	@discussion	If this is the value of the DRTrackTypeKey then the track is not invisible or
; 				reserved and is available for writing.
; 
(def-mactype :DRTrackTypeIncomplete (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRTrackTypeReserved
; 	@discussion	If this is the value of the DRTrackTypeKey then the track is reserved for writing.
; 
(def-mactype :DRTrackTypeReserved (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRTrackTypeClosed
; 	@discussion	If this is the value of the DRTrackTypeKey then the track has been
; 				written and is closed.
; 
(def-mactype :DRTrackTypeClosed (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  --------------------------------- 
;  Packet types 
; !
; 	@const		DRTrackPacketTypeFixed
; 	@discussion	If this is the value of the DRTrackPacketTypeKey then the disc is writen with
; 				fixed sized packets.  When this value is present the DRPacketSizeKey will also be
; 				present.
; 
(def-mactype :DRTrackPacketTypeFixed (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		DRTrackPacketTypeVariable
; 	@discussion	If this is the value of the DRTrackPacketTypeKey then the disc is written with
; 				sequential variable sized packets.  The presence of this value indicates the lack
; 				of the DRPacketSizeKey.
; 
(def-mactype :DRTrackPacketTypeVariable (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  ------------------------------------ 
;  Filesystem track properties 
;  These properties are valid only on tracks created through the DataContent category.
; 	In general the burn engine will assume reasonable defaults; only change these properties
; 	if you require a specific behavior. 

; #if 0
#| ; #pragma mark Filesystem Track Properties
 |#

; #endif

; !
; 	@const		DRISOLevel
; 	@discussion	NSNumber containing the ISO level of the ISO-9660 filesystem on the track. Currently should be 1 or 2.
; 
(def-mactype :DRISOLevel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRVolumeSet
; 	@discussion	NSString indicating the volume set name for ISO and Joliet volumes.
; 
(def-mactype :DRVolumeSet (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRPublisher
; 	@discussion	NSString indicating the publisher for ISO and Joliet volumes.
; 
(def-mactype :DRPublisher (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDataPreparer
; 	@discussion	NSString indicating the data preparer for ISO and Joliet volumes.
; 
(def-mactype :DRDataPreparer (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRApplicationIdentifier
; 	@discussion	NSString indicating the application identifier for ISO and Joliet volumes.
; 
(def-mactype :DRApplicationIdentifier (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRSystemIdentifier
; 	@discussion	NSString indicating the system identifier for ISO and Joliet volumes.
; 
(def-mactype :DRSystemIdentifier (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRCopyrightFile
; 	@discussion	DRFile pointing to the copyright file for ISO and Joliet volumes. The file must be in the root directory.
; 
(def-mactype :DRCopyrightFile (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRAbstractFile
; 	@discussion	DRFile pointing to the abstract file for ISO and Joliet volumes. The file must be in the root directory.
; 
(def-mactype :DRAbstractFile (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRBibliographicFile
; 	@discussion	DRFile pointing to the bibliographic file for ISO and Joliet volumes. The file must be in the root directory.
; 
(def-mactype :DRBibliographicFile (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRBlockSize
; 	@discussion	NSNumber indicating the block size of the track. Currently always 2048.  Do not change.
; 
(def-mactype :DRBlockSize (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRDefaultDate
; 	@discussion	NSDate containing the default date to use for any unspecified dates in the filesystem. The current date and time is used if unspecified.
; 
(def-mactype :DRDefaultDate (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRVolumeCreationDate
; 	@discussion	NSDate containing the volume creation date. DRDefaultDate is used if unspecified.
; 
(def-mactype :DRVolumeCreationDate (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRVolumeModificationDate
; 	@discussion	NSDate containing the volume modification date. DRDefaultDate is used if unspecified.
; 
(def-mactype :DRVolumeModificationDate (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRVolumeCheckedDate
; 	@discussion		NSDate containing the volume-checked date for HFS+ volumes. DRDefaultDate is used if unspecified.
; 
(def-mactype :DRVolumeCheckedDate (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRVolumeExpirationDate
; 	@discussion	NSDate containing the volume expiration date for ISO and Joliet volumes.
; 
(def-mactype :DRVolumeExpirationDate (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRVolumeEffectiveDate
; 	@discussion	NSDate containing the date and time at which the volume is effective for ISO and Joliet volumes.
; 
(def-mactype :DRVolumeEffectiveDate (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRISOMacExtensions
; 	@discussion	NSBoolean indicating whether the track should have Mac extensions.
; 
(def-mactype :DRISOMacExtensions (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRISORockRidgeExtensions
; 	@discussion	NSBoolean indicating whether the track should have RockRidge (POSIX) extensions.
; 
(def-mactype :DRISORockRidgeExtensions (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRSuppressMacSpecificFiles
; 	@discussion	NSBoolean indicating whether the track should suppress Mac-specific files from
; 				non-HFS filesystems.
; 
(def-mactype :DRSuppressMacSpecificFiles (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER

(provide-interface "DRTrack")