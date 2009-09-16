(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRCoreTrack.h"
; at Sunday July 2,2006 7:27:34 pm.
; 
;      File:       DiscRecordingEngine/DRCoreTrack.h
;  
;      Contains:   Track object interfaces for Disc Recording.
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
; #ifndef _H_DRCoreTrack
; #define _H_DRCoreTrack

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef _H_DRCoreDevice

(require-interface "DiscRecordingEngine/DRCoreDevice")

; #endif

; #ifndef _H_DRCoreObject
#| #|
#include <DiscRecordingEngineDRCoreObject.h>
#endif
|#
 |#
; #ifndef __AVAILABILITYMACROS__

(require-interface "AvailabilityMacros")

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; !
; 	@typedef DRTrackRef
; 	A reference to a DRTrack object.
; 

(def-mactype :DRTrackRef (find-mactype '(:pointer :__DRTrack)))
; !
; 	@function	DRTrackGetTypeID
; 	@abstract	Returns the Core Foundation type identifier of all DRTrack instances.
; 

(deftrap-inline "_DRTrackGetTypeID" 
   ((ARG2 (:nil :nil))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )
; !
; 	@typedef	DRTrackMessage
; 	@abstract	Messages sent to the DRTrackCallbackProc callback.
; 

(def-mactype :DRTrackMessage (find-mactype ':UInt32))
; !
;     @typedef 	DRTrackCallbackProc
;     @abstract	Callback defined in the client to produce track data for recording.
; 	@discussion	If your callback does not support a given function, it should return
; 				a value of kDRFunctionNotSupportedErr. 
;     @param 		track		The track with this callback is associated.
;     @param		message		Indicates the type of data requested as one of the constants
;     						in the Track Messages enumeration.
;  	@param		ioParam		Parameters are message-specific.
;     @result 	Error code.  Your client application should return a value of kDRFunctionNotSupportedErr
; 				when a message is received that you don't respond to, and a value of noErr when
; 				the message is handled successfully.  Any other error will cause
; 				the burn to immediately fail with the value you return as the error code.
; 

(def-mactype :DRTrackCallbackProc (find-mactype ':pointer)); (DRTrackRef track , DRTrackMessage message , void * ioParam)

;type name? (def-mactype :DRTrackProductionInfo (find-mactype ':DRTrackProductionInfo))
; !
; 	@function	DRTrackCreate
; 	@abstract	Creates a new track object.
; 	@param		properties	A CFDictionary object containing the track properties. If this
; 							parameter is not a valid CFDictionary object the behavior is undefined.
; 	@param		callbacks	A pointer to a DRTrackCallbackProc callback. If this callback is NULL
; 							the behavior is undefined.
; 	@result		A reference to the new DRTrack object.
; 

(deftrap-inline "_DRTrackCreate" 
   ((properties (:pointer :__CFDictionary))
    (callback :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__DRTrack)
() )
; !
; 	@function	DRTrackSetProperties
; 	@abstract	Sets the properties of the track.
; 	@param		track		The track whose properties will be set. If this parameter 
; 							is not a valid DRTrack object, the behavior is undefined. 
; 	@param		properties	A CFDictionary object containing the track properties. If this
; 							parameter is not a valid CFDictionary object the behavior is undefined.
; 

(deftrap-inline "_DRTrackSetProperties" 
   ((track (:pointer :__DRTrack))
    (properties (:pointer :__CFDictionary))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; !
; 	@function	DRTrackGetProperties
; 	@abstract	Returns the properties of the track.
; 	@param		track		The track whose properties will be retrieved. If this parameter 
; 							is not a valid DRTrack object, the behavior is undefined. 
; 	@result		A CFMutableDictionary object containing the track properties.
; 

(deftrap-inline "_DRTrackGetProperties" 
   ((track (:pointer :__DRTrack))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__CFDictionary)
() )
; !
; 	@function	DRTrackSpeedTest
; 	@abstract	Tests the speed at which data can be produced.
; 	@discussion	Runs a test track-production cycle, calling the produceData callback for the specified 
; 				number of milliseconds or until the specified number of bytes have been 
; 				produced, whichever comes first.
; 				
; 				Use this function to verify that the produceData callback can produce data fast 
; 				enough to satisfy the data throughput requirements of the burn.
; 				
; 				This function will automatically set a value for the kDRMaxBurnSpeedKey key in the track's
; 				properties dictionary, with a value equal to the return result.
; 	@param		track			The track to test. 
; 	@param		howManyMilliseconds	The maximum duration for the test production cycle. The 
; 								test may not run for the full requested duration if the byte limit
; 								is reached first. If this parameter is 0, the result is
; 								undefined.
; 	@param		howManyBytes	The maximum number of bytes of data the client should produce before
; 								completing the test. The test may not produce the requested number of bytes 
; 								if the time limit is reached first. If this parameter is 0, the result 
; 								is undefined. 
; 	@result		The maximum throughput obtained during the test cycle.
; 

(deftrap-inline "_DRTrackSpeedTest" 
   ((track (:pointer :__DRTrack))
    (howManyMilliseconds :UInt32)
    (howManyBytes :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :single-float
() )
; !
; 	@function	DRTrackEstimateLength
; 	@abstract	Asks the track producer for a block size estimate.
; 	@discussion	This function calls the track producer to ask it to estimate the block size
; 				needed for its data.  This call is passed through to the DRTrackCallbackProc
; 				track production callback as kDRTrackMessageEstimateLength.
; 				
; 				For some types of tracks, this call may be very expensive.  For example,
; 				a file system track (DRFilesystemTrack) may need to iterate through folders 
; 				on disk to provide an accurate estimate. If a large number of files and folders 
; 				are involved, this call may take 30 seconds or more.  Since your
; 				main thread should not block for this long, you may wish to call this
; 				function on a separate thread.
; 				
; 				The return value is the size in blocks that is specified in the
; 				track's properties dictionary.
; 				
; 	@param		track		The track to query.
; 	@result		The size of the track in blocks.
; 

(deftrap-inline "_DRTrackEstimateLength" 
   ((track (:pointer :__DRTrack))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :uint64
() )
;  ------------------------------------ 
; 	The following track properties are required, and must be set on every track.  See the
; 	end of this file for definitions of common values. 
; #pragma mark Required Track Properties
; !
; 	@const		kDRTrackLengthKey
; 	@discussion	Required Key. This key corresponds to a CFNumber object containing the length of 
; 				the track data in blocks.
; 
(def-mactype :kDRTrackLengthKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		kDRBlockSizeKey
; 	@discussion	Required key. This key corresponds to a CFNumber object containing the size
; 				of each block of the track. Common values are defined in the Block Sizes
; 				enumeration.
; 
(def-mactype :kDRBlockSizeKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		kDRBlockTypeKey
; 	@discussion	Required key. This key corresponds to a CFNumber object containing the type
; 				of each block of the track. Common values are defined in the Block Types
; 				enumeration.
; 
(def-mactype :kDRBlockTypeKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		kDRDataFormKey
; 	@discussion	Required key. This key corresponds to a CFNumber object containing the data format
; 				of each block of the track. Common values are defined in the Data Forms
; 				enumeration.
; 
(def-mactype :kDRDataFormKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		kDRSessionFormatKey
; 	@discussion	Required key. This key corresponds to a CFNumber object containing the session format
; 				of the track. Common values are defined in the Session Mode enumeration.
; 
(def-mactype :kDRSessionFormatKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		kDRTrackModeKey
; 	@discussion	Required key. This key corresponds to a CFNumber object containing the track mode
; 				of the track. Common values are defined in the Track Modes enumeration.
; 
(def-mactype :kDRTrackModeKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ------------------------------------ 
; 	The following track properties are optional, and are not required.  The burn engine
; 	will generally assume reasonable defaults, but if you need more specific control
; 	over particular properties you can use these keys. 
; #pragma mark Optional Track Properties
; !
; 	@const		kDRVerificationTypeKey
; 	@discussion	Optional key. This track property key corresponds to a CFString object indicating the kind of verification
; 				that should be performed. If the key is not present, no verification will take 
; 				place.
; 
(def-mactype :kDRVerificationTypeKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		kDRDVDCopyrightInfoKey
; 	@discussion	Optional key. This track property key corresponds to a CFData object containing Multi-Media Command 
; 				(MMC) copyright data. This data will be sent directly to the drive. If this key is 
; 				not present, no copyright information will be sent.
; 
(def-mactype :kDRDVDCopyrightInfoKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		kDRDVDTimestampKey
; 	@discussion	Optional key. This track property key corresponds to a CFData object containing Multi-Media Command 
; 				(MMC) timestamp data. This data will be sent directly to the drive. If this key 
; 				is not present, no timestamp will be sent.
; 
(def-mactype :kDRDVDTimestampKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		kDRBufferZone1DataKey
; 	@discussion	Optional key. This track property key corresponds to a CFData object containing the data to
; 				write to Buffer Zone 1 on drives which support it, such as the Pioneer DVR-S201.
; 				This data will be sent directly to the drive. If this key is not present, no 
; 				Buffer Zone 1 data will be sent.
; 
(def-mactype :kDRBufferZone1DataKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		kDRMaxBurnSpeedKey
; 	@discussion	Optional key. This track property key corresponds to a CFNumber object containing  
; 				the maximum sustained rate at which your application will request data from the 
; 				track callback, in units of kilobytes per second where 1 kilobyte = 1,000 bytes.
; 				
; 				The value for kDRMaxBurnSpeedKey must be greater than the drive's minimum burn 
; 				speed. It is usually safe to specify the appropriate flavor of 1x 
; 				(kDRDeviceBurnSpeedCD1x or kDRDeviceBurnSpeedDVD1x), but some drives cannot slow  
; 				all the way down to 1x.
; 				
; 				Given the capabilities of the drive, the bus, and the recordable disc, the burn speed used 
; 				when writing a layout will generally be the highest data rate possible that is less 
; 				than or equal to the value of kDRMaxBurnSpeedKey for every track, as well as less
; 				than or equal to the value of the kDRBurnRequestSpeedKey key for the burn object.
; 				
; 				When this key is not present, the requested maximum sustained data rate defaults
; 				to a value of infinity. In this case, the Disc Recording engine assumes that your 
; 				track callback can produce data at any rate requested.
; 
(def-mactype :kDRMaxBurnSpeedKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		kDRPreGapLengthKey
; 	@discussion	Optional key. This track property key corresponds to a CFNumber object containing the length in blocks of 
; 				empty space, or pregap, to be recorded before the track. If this key is not
; 				present the Disc Recording engine will assume a 2 second, or 150 block, pregap.
; 
(def-mactype :kDRPreGapLengthKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		kDRTrackISRCKey
; 	@discussion	Optional key. For CD-DA audio tracks only.  This track property key corresponds to a CFData
; 				object containing exactly 12 bytes, which will be written to the disc as the
; 				International Standard Recording Code (ISRC).  If this key is not present,
; 				no ISRC data is written.
; 				
; 				The use of this value should conform to the specifications of the IFPI.  See
; 				http://www.ifpi.org/isrc for details on the ISRC standard.
; 				
; 				Not all drives can write ISRC data. If this key is present in any track and 
; 				the drive cannot write ISRC data, the burn will fail with a return value of 
; 				kDRDeviceCantWriteISRCErr.
; 
(def-mactype :kDRTrackISRCKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRIndexPointsKey
; 	@discussion	Optional key. For CD tracks only.  This track property key corresponds to a CFArray object
; 				containing CFNumber objects	describing index points within the track.  Each 
; 				index point is specified as a number of blocks, equivalent to frames, relative 
; 				to the start of the track.  There are 75 blocks in one second of CD audio.  No 
; 				more than 98 index points may be specified for a track.
; 				
; 				Not all drives can write index points, and not all consumer CD players report or 
; 				use them.  If this key is present in any track and the drive cannot write index 
; 				points, the burn will fail with a return value of kDRDeviceCantWriteIndexPointsErr.
; 
(def-mactype :kDRIndexPointsKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRAudioPreEmphasisKey
; 	@discussion	Optional key. For CD-DA audio tracks only. This track property key corresponds to a CFBoolean
; 				value indicating whether the track includes pre-emphasis of 50/15 microseconds.
; 				If this key is not present, the engine will use a default value of
; 				<tt>false</tt>.  On the disc, this key corresponds to bit 0 of the
; 				control field in sub-channel Q.
; 
(def-mactype :kDRAudioPreEmphasisKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRAudioFourChannelKey
; 	@discussion	Optional key. For CD-DA audio tracks only. This track property key corresponds to a CFBoolean
; 				value indicating whether the track data has four channels, as opposed to the
; 				two channels of normal stereo.  If this key is not present, the engine
; 				will use a default value of <tt>false</tt> and standard two-channel stereo
; 				is assumed.
; 				
; 				Four-channel audio is supported in the Red Book standard but never 
; 				caught on. It is probably being replaced by SACD, so you probably shouldn't 
; 				attempt to use it.
; 				
; 				On the disc, this key corresponds to bit 3 of the control field in
; 				sub-channel Q.
; 
(def-mactype :kDRAudioFourChannelKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRSerialCopyManagementStateKey
; 	@discussion	Optional key. For CD tracks only.  This track property key corresponds to a CFString value
; 				indicating the Serial Copy Management System (SCMS) state of the track.  If 
; 				this key is not present, no SCMS data is written.
; 				
; 				Not all drives are capable of writing SCMS data.  If this key is present in any
; 				track and the drive cannot write SCMS, the burn will fail with a return value
; 				of kDRDeviceCantWriteSCMSErr.
; 
(def-mactype :kDRSerialCopyManagementStateKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  ------------------------------------ 
;  Verification types 
; !
; 	@const		kDRVerificationTypeNone
; 	@discussion	One value for the kDRVerificationTypeKey dictionary key. This value indicates
; 				the engine will not do any sort of verification on the track data.
; 
(def-mactype :kDRVerificationTypeNone (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		kDRVerificationTypeProduceAgain
; 	@discussion	One value for the kDRVerificationTypeKey dictionary key. This value indicates
; 				the engine will start another production cycle and the client 
; 				simply produces data again from the start.
; 				
; 				Note that this verification mode currently only works with data CDs and DVDs.
; 
(def-mactype :kDRVerificationTypeProduceAgain (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		kDRVerificationTypeReceiveData
; 	@discussion	One value for the kDRVerificationTypeKey dictionary key. This value indicates
; 				the engine will read data from the disc and send it to the client
; 				through a series of calls to the callback.
; 
(def-mactype :kDRVerificationTypeReceiveData (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ------------------------------------ 
;  SCMS states 
; !
; 	@const		kDRSCMSCopyrightFree
; 	@discussion	One value for the kDRSerialCopyManagementStateKey dictionary key. This value indicates that
; 				the track has no copying restrictions.  Copies of this track should also be
; 				copyright free.
; 
(def-mactype :kDRSCMSCopyrightFree (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRSCMSCopyrightProtectedOriginal
; 	@discussion	One value for the kDRSerialCopyManagementStateKey dictionary key. This value indicates that
; 				the track is an original subject to copyright protection.  Digital copying of
; 				this track should be allowed, but copies should be marked with appropriate Serial Copy 
; 				Management System (SCMS) data.
; 
(def-mactype :kDRSCMSCopyrightProtectedOriginal (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRSCMSCopyrightProtectedCopy
; 	@discussion	One value for the kDRSerialCopyManagementStateKey dictionary key. This value indicates that
; 				the track is a first-generation copy of an original that was subject to copy
; 				protection.  No further digital copying should be allowed.
; 
(def-mactype :kDRSCMSCopyrightProtectedCopy (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  ------------------------------------ 
; 	The following track properties are read-only, and are only valid on DRTrackRefs
; 	that have been created by the burn engine to represent the existing tracks on a disc. 
; #pragma mark Read-Only Track Properties
; !
; 	@const		kDRNextWritableAddressKey
; 	@discussion	This key corresponds to a CFNumber object containing the Logical Block Address (LBA)
; 				of the next writable address in the track. This key is not present in closed tracks.
; 
(def-mactype :kDRNextWritableAddressKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRTrackStartAddressKey
; 	@discussion	This key corresponds to a CFNumber object containing the Logical Block Address (LBA)
; 				of the start address for the track.
; 
(def-mactype :kDRTrackStartAddressKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRFreeBlocksKey
; 	@discussion	This key corresponds to a CFNumber object containing the length, in blocks, which is
; 				still available in a writable track.
; 
(def-mactype :kDRFreeBlocksKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRTrackNumberKey
; 	@discussion	This key corresponds to a CFNumber object containing the physical track number of a track.
; 
(def-mactype :kDRTrackNumberKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRSessionNumberKey
; 	@discussion	This key corresponds to a CFNumber object containing the physical session number of a track.
; 
(def-mactype :kDRSessionNumberKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRTrackTypeKey
; 	@discussion	This key corresponds to a CFString object indicating the type of track. Possible values are 
; 				kDRTrackTypeInvisible, kDRTrackTypeIncomplete, kDRTrackTypeReserved, or kDRTrackTypeClosed.
; 
(def-mactype :kDRTrackTypeKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRTrackIsEmptyKey
; 	@discussion	This key corresponds to a CFBoolean object and indicates whether the track is empty.
; 
(def-mactype :kDRTrackIsEmptyKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRTrackPacketTypeKey
; 	@discussion	This key corresponds to a CFString value indicating the kind of packets being written.
; 
(def-mactype :kDRTrackPacketTypeKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRTrackPacketSizeKey
; 	@discussion	This key corresponds to a CFNumber object that contains the number of blocks per packet for
; 				the disc. It will only be present if the disc contains fixed packets. This key
; 				will contain '16' for DVD media, and typically contains either '16' or '32' for CD media.
; 
(def-mactype :kDRTrackPacketSizeKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  --------------------------------- 
;  Track types 
; !
; 	@const		kDRTrackTypeInvisible
; 	@discussion	One value for the kDRTrackTypeKey dictionary key. This value indicates the track is 
; 				invisible and available for writing. If it is packet written and not closed, 
; 				the kDRTrackPacketType key will be present along with the kDRTrackPacketSize keys.
; 
(def-mactype :kDRTrackTypeInvisible (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRTrackTypeIncomplete
; 	@discussion	One value for the kDRTrackTypeKey dictionary key. This value indicates the track is 
; 				not invisible or reserved and is available for writing.
; 
(def-mactype :kDRTrackTypeIncomplete (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRTrackTypeReserved
; 	@discussion	One value for the kDRTrackTypeKey dictionary key. This value indicates the track is 
; 				reserved for writing.
; 
(def-mactype :kDRTrackTypeReserved (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRTrackTypeClosed
; 	@discussion	One value for the kDRTrackTypeKey dictionary key. This value indicates the track has been
; 				written and is closed.
; 
(def-mactype :kDRTrackTypeClosed (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  --------------------------------- 
;  Packet types 
; !
; 	@const		kDRTrackPacketTypeFixed
; 	@discussion	One value for the kDRTrackPacketTypeKey dictionary key. This value indicates the disc is 
; 				writen with fixed sized packets.  When this value is present the kDRPacketSizeKey 
; 				dictionary key will also be present.
; 
(def-mactype :kDRTrackPacketTypeFixed (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const		kDRTrackPacketTypeVariable
; 	@discussion	One value for the kDRTrackPacketTypeKey dictionary key. This value indicates the disc is 
; 				written with sequential, variable-sized packets.  When this key is present, the 
; 				kDRPacketSizeKey dictionary key will not be.
; 
(def-mactype :kDRTrackPacketTypeVariable (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  --------------------------------- 
;  The following keys are used in dictionaries sent as the ioParam in a callback. 
; #pragma mark PreBurn Track Message Properties
; !
; 	@const		kDRBurnKey
; 	@discussion	This key corresponds to the DRBurn object for which the PreBurn message applies.
; 
(def-mactype :kDRBurnKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  --------------------------------- 
;  The following values are commonly used values for the track properties in a few standard types of CDs. 
; #pragma mark - Block Sizes
; !
; 	@enum 		Block Sizes
; 	@abstract	Common block sizes for different types of track data.
; 	@constant	kDRBlockSizeAudio		Audio data.
; 	@constant	kDRBlockSizeMode1Data	Mode 1 data.
; 	@constant	kDRBlockSizeMode2Data	Mode 2 data. Photo CD and CD-i use this.
; 	@constant	kDRBlockSizeDVDData		DVD data.
; 

(defconstant $kDRBlockSizeAudio #x930)
(defconstant $kDRBlockSizeMode1Data #x800)
(defconstant $kDRBlockSizeMode2Data #x91C)
(defconstant $kDRBlockSizeDVDData #x800)
; #pragma mark - Block Types
; !
; 	@enum 		Block Types
; 	@abstract	Common block type values for types of track data.
; 	@constant	kDRBlockTypeAudio		Audio data.
; 	@constant	kDRBlockTypeMode1Data	Mode 1 data.
; 	@constant	kDRBlockTypeMode2Data	Mode 2 data. Photo CD and CD-i use this.
; 	@constant	kDRBlockTypeDVDData		DVD data.
; 

(defconstant $kDRBlockTypeAudio 0)
(defconstant $kDRBlockTypeMode1Data 8)
(defconstant $kDRBlockTypeMode2Data 13)
(defconstant $kDRBlockTypeDVDData 8)
; #pragma mark - Data Forms
; !
; 	@enum 		Data Forms
; 	@abstract	Common data form values for types of track data.
; 	@constant	kDRDataFormAudio		Audio data.
; 	@constant	kDRDataFormMode1Data	Mode 1 data.
; 	@constant	kDRDataFormMode2Data	Mode 2 data. Photo CD and CD-i use this.
; 	@constant	kDRDataFormDVDData		DVD data.
; 

(defconstant $kDRDataFormAudio 0)
(defconstant $kDRDataFormMode1Data 16)
(defconstant $kDRDataFormMode2Data 32)
(defconstant $kDRDataFormDVDData 16)
; #pragma mark - Track Modes
; !
; 	@enum 		Track Modes
; 	@abstract	Common track mode values for types of track data.
; 	@constant	kDRTrackModeAudio		Audio data.
; 	@constant	kDRTrackMode1Data		Mode 1 data.
; 	@constant	kDRTrackMode2Data		Mode 2 data. Photo CD and CD-i use this.
; 	@constant	kDRTrackModeDVDData		DVD data.
; 

(defconstant $kDRTrackModeAudio 0)
(defconstant $kDRTrackMode1Data 4)
(defconstant $kDRTrackMode2Data 4)
(defconstant $kDRTrackModeDVDData 5)
; #pragma mark - Session Format
; !
; 	@enum 		Session Format
; 	@abstract	Common session format values for types of track data.
; 	@constant	kDRSessionFormatAudio		Audio data.
; 	@constant	kDRSessionFormatMode1Data	Mode 1 data.
; 	@constant	kDRSessionFormatCDI			CD-I disc.
; 	@constant	kDRSessionFormatCDXA		CD-ROM XA disc.
; 	@constant	kDRSessionFormatDVDData		DVD data.
; 

(defconstant $kDRSessionFormatAudio 0)
(defconstant $kDRSessionFormatMode1Data 0)
(defconstant $kDRSessionFormatCDI 16)
(defconstant $kDRSessionFormatCDXA 32)
(defconstant $kDRSessionFormatDVDData 0)
; #pragma mark - Track Flags
; !
; 	@enum	Track Flags
; 	@discussion	These flags are options in the DRTrackProductionInfo structure.
; 	@constant	kDRFlagNoMoreData	Indicates the end of variable length data.
; 

(defconstant $kDRFlagNoMoreData 1)
; #pragma mark - Track Messages
; !
; 	@enum	Track Messages
; 	@constant kDRTrackMessagePreBurn				Message sent to the track production callback indicating a burn is about to begin.
; 													Clients should open any files needed to produce data and get ready to 
; 													start sending data.
; 													
; 													The ioParam parameter contains a CFDictionary object with information about 
; 													the burn. It currently holds kDRBurnKey and kDRDeviceMediaInfoKey dictionary keys, 
; 													but may be extended to hold other properties in the future.
; 
; 	@constant kDRTrackMessageProduceData			Message sent to the track production callback requesting that the client 
; 													produce the next chunk of data for the track.
; 													
; 													The ioParam parameter is a pointer to a DRTrackProductionInfo structure.
; 													
; 	@constant kDRTrackMessageVerificationStarting	Message sent to the callback proc indicating that verification 
; 													is about to begin.
; 													
; 													ioParam is not used and is NULL.
; 																										
; 	@constant kDRTrackMessageVerifyData				Message sent to the track production callback when the client has chosen
; 													the kDRVerificationTypeReceiveData option. 
; 													
; 													The ioParam parameter is a pointer to a DRTrackProductionInfo structure describing 
;     												the data passed to the callback.
;     												
; 	@constant kDRTrackMessageVerificationDone		Message sent to the track production callback when verification is complete.
; 	
; 													The ioParam parameter is not used and is NULL.
; 													
; 	@constant kDRTrackMessagePostBurn				Message sent to the track production callback indicating a burn has completed.
; 										
; 													The ioParam parameter is not used and is NULL.
; 
; 	@constant kDRTrackMessageEstimateLength			Message sent to the track production callback asking it to estimate
; 													the length of the track.  This message is sent outside of a burn
; 													cycle, when the DRTrackEstimateSize function is called.  
; 													
; 													The ioParam parameter is a pointer to a UInt64 value, which the callback fills 
; 													in with an estimated number of blocks for the track.  The estimate should
; 													be reasonably accurate and no smaller than the actual size that
; 													will be needed. 
; 	
; 	@constant kDRTrackMessageProducePreGap			Message sent to the track production callback requesting that the client
; 													produce the next chunk of the pregap.
; 													
; 													The ioParam parameter is a pointer to a DRTrackProductionInfo structure.
; 

(defconstant $kDRTrackMessagePreBurn :|pre |)
(defconstant $kDRTrackMessageProduceData :|prod|)
(defconstant $kDRTrackMessageVerificationStarting :|vstr|)
(defconstant $kDRTrackMessageVerifyData :|vrfy|)
(defconstant $kDRTrackMessageVerificationDone :|vdon|)
(defconstant $kDRTrackMessagePostBurn :|post|)
(defconstant $kDRTrackMessageEstimateLength :|esti|);  added in 10.3 

(defconstant $kDRTrackMessageProducePreGap :|prpr|);  added in 10.3 

; !
; 	@struct		DRTrackProductionInfo
; 	@abstract	Parmeter block used for data production.
; 	@field		buffer				In - The buffer to produce into. This buffer is passed into the
; 									track production callback and only the contents should be modified.
; 	@field		reqCount			In - The number of bytes requested by the engine.
; 	@field		actCount			Out - The number of bytes actually produced (between 0 and reqCount).
; 	@field		flags				InOut - Miscellaneous flags. Flags are passed into the track production callback  
; 									callback from the Disc Recording engine and the callback can set flags to be 
; 									passed back to the engine.
; 	@field		blockSize			In - The block size the engine is expecting. For best results, return 
; 									multiples of this size. 
; 	@field		requestedAddress	In - The byte address that the burn engine is requesting from the 
; 									object (0-based). This increments when you send data, as one 
; 									would expect. 
; 
(defrecord DRTrackProductionInfo
   (buffer :pointer)
   (reqCount :UInt32)
   (actCount :UInt32)
   (flags :UInt32)
   (blockSize :UInt32)
   (requestedAddress :uint64)
)
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _H_DRCoreTrack */


(provide-interface "DRCoreTrack")