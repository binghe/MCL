(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AudioFile.h"
; at Sunday July 2,2006 7:26:58 pm.
; 
;      File:       AudioToolbox/AudioFile.h
; 
;      Contains:   API for manipulating Audio Files.
; 
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
; 
;      Copyright:  (c) 1985-2001 by Apple Computer, Inc., all rights reserved.
; 
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
; 
;                         http://developer.apple.com/bugreporter/
; 
; 

; #if !defined(__AudioFile_h__)
; #define __AudioFile_h__
; =============================================================================
; 	Includes
; =============================================================================

(require-interface "CoreAudio/CoreAudio")

(require-interface "CoreServices/CoreServices")

; #if defined(__cplusplus)
#|
extern "C"
{
#endif
|#
;  File Types: types used when specifying the type of file to create and returned from get property (file format)

(defconstant $kAudioFileAIFFType :|AIFF|)
(defconstant $kAudioFileAIFCType :|AIFC|)
(defconstant $kAudioFileWAVEType :|WAVE|)
(defconstant $kAudioFileSoundDesigner2Type :|Sd2f|)
(defconstant $kAudioFileNextType :|NeXT|)
(defconstant $kAudioFileMP3Type :|MPG3|)
(defconstant $kAudioFileAC3Type :|ac-3|)
(defconstant $kAudioFileAAC_ADTSType :|adts|)
;  Error Codes: AudioFile error codes

(defconstant $kAudioFileUnspecifiedError :|wht?|)
(defconstant $kAudioFileUnsupportedFileTypeError :|typ?|)
(defconstant $kAudioFileUnsupportedDataFormatError :|fmt?|)
(defconstant $kAudioFileUnsupportedPropertyError :|pty?|)
(defconstant $kAudioFileBadPropertySizeError :|!siz|)
(defconstant $kAudioFilePermissionsError :|prm?|)
(defconstant $kAudioFileNotOptimizedError :|optm|)
(defconstant $kAudioFileFormatNameUnavailableError :|nme?|);  file format specific error codes

(defconstant $kAudioFileInvalidChunkError :|chk?|);  applies to AIFF, WAVE chunks

(defconstant $kAudioFileDoesNotAllow64BitDataSizeError :|off?|);  applies to AIFF, WAVE files

(defconstant $kAudioFileInvalidPacketOffsetError :|pck?|)
(defconstant $kAudioFileInvalidFileError :|dta?|);  data could not be parsed 

(defconstant $kAudioFileOperationNotSupportedError #x6F703F3F);  'op??', integer used because of trigraph

; =============================================================================
; 	Types specific to the Audio File API
; =============================================================================

(def-mactype :AudioFileID (find-mactype '(:pointer :OpaqueAudioFileID)))

(def-mactype :AudioFilePropertyID (find-mactype ':UInt32))
; =============================================================================
; 	Routines
; =============================================================================
; ----------------------------------------------------------------------------------
;     AudioFileCreate - creates a new audio file located in the parent directory 
;                       provided. Upon success, an AudioFileID is returned which can
;                       be used for subsequent calls to the AudioFile APIs.
;                       
;     inParentRef 	- an FSRef to the directory where  the new file should be created.
;     inFileName 		- a CFStringRef containing the name of the file to be created.
;     inFileType 		- a UInt32 indicating the type of audio file to create. Constants are
;                       provided above in the header file.
;     inFormat 		- an AudioStreamBasicDescription describing the data format that will be
;                       added to the audio file.
;     inFlags 		- relevent flags for creating/opening the file. Currently zero.
;     outNewFileRef 	- on success, the FSRef of the newly created file.
;     outAudioFile  	- upon success, an AudioFileID that can be used for subsequent AudioFile calls.
; //----------------------------------------------------------------------------------

(deftrap-inline "_AudioFileCreate" 
   ((inParentRef (:pointer :FSRef))
    (inFileName (:pointer :__CFString))
    (inFileType :UInt32)
    (inFormat (:pointer :AudioStreamBasicDescription))
    (inFlags :UInt32)
    (outNewFileRef (:pointer :FSRef))
    (outAudioFile (:pointer :AUDIOFILEID))
   )
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;     AudioFileInitialize - Use AudioFileInitialize to wipe clean an existing audio file
;                           and prepare it to be populated with new data.
;     
;     inFileRef 		- the FSRef of an existing audio file.
;     inFileType 		- a UInt32 indicating the type of audio file to initialize the file to. 
;                       Constants are provided above in the header file.
;     inFormat 		- an AudioStreamBasicDescription describing the data format that will be
;                       added to the audio file.
;     inFlags 		- relevent flags for creating/opening the file. Currently zero.
;     outAudioFile	- upon success, an AudioFileID that can be used for subsequent
;                       AudioFile calls.
; //----------------------------------------------------------------------------------

(deftrap-inline "_AudioFileInitialize" 
   ((inFileRef (:pointer :FSRef))
    (inFileType :UInt32)
    (inFormat (:pointer :AudioStreamBasicDescription))
    (inFlags :UInt32)
    (outAudioFile (:pointer :AUDIOFILEID))
   )
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;     AudioFileOpen - Open an existing audio file.
;     
;     inFileRef 		- the FSRef of an existing audio file.
;     inPermissions 	- use the permission constants used by FSOpenFork().
;     inFlags 		- relevent flags for creating/opening the file. Currently zero.
;     outAudioFile	- upon success, an AudioFileID that can be used for subsequent AudioFile calls.
; //----------------------------------------------------------------------------------

(deftrap-inline "_AudioFileOpen" 
   ((inFileRef (:pointer :FSRef))
    (inPermissions :SInt8)
    (inFlags :UInt32)
    (outAudioFile (:pointer :AUDIOFILEID))
   )
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;     AudioFileInitializeWithCallbacks - Wipe clean an existing file. You provide callbacks that the AudioFile API
; 		will use to get the data. 
;     
;     inRefCon 				- a constant that will be passed to your callbacks.
; 	AudioFile_ReadProc		- a function that will be called when AudioFile needs to read data.
; 	AudioFile_WriteProc		- a function that will be called when AudioFile needs to write data.
; 	AudioFile_GetSizeProc	- a function that will be called when AudioFile needs to know the file size.
; 	AudioFile_SetSizeProc	- a function that will be called when AudioFile needs to set the file size.
; 	
;     inFileType 		- a UInt32 indicating the type of audio file to initialize the file to. 
;                       Constants are provided above in the header file.
;     inFormat 		- an AudioStreamBasicDescription describing the data format that will be
;                       added to the audio file.
;     inFlags 		- relevent flags for creating/opening the file. Currently zero.
;     outAudioFile	- upon success, an AudioFileID that can be used for subsequent
;                       AudioFile calls.
; //----------------------------------------------------------------------------------

(def-mactype :AudioFile_ReadProc (find-mactype ':pointer)); (void * inRefCon , SInt64 inPosition , ByteCount requestCount , void * buffer , ByteCount * actualCount)

(def-mactype :AudioFile_WriteProc (find-mactype ':pointer)); (void * inRefCon , SInt64 inPosition , ByteCount requestCount , const void * buffer , ByteCount * actualCount)

(def-mactype :AudioFile_GetSizeProc (find-mactype ':pointer)); (void * inRefCon)

(def-mactype :AudioFile_SetSizeProc (find-mactype ':pointer)); (void * inRefCon , SInt64 inSize)

(deftrap-inline "_AudioFileInitializeWithCallbacks" 
   ((inRefCon :pointer)
    (inReadFunc :pointer)
    (inWriteFunc :pointer)
    (inGetSizeFunc :pointer)
    (inSetSizeFunc :pointer)
    (inFileType :UInt32)
    (inFormat (:pointer :AudioStreamBasicDescription))
    (inFlags :UInt32)
    (outAudioFile (:pointer :AUDIOFILEID))
   )
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;     AudioFileOpenWithCallbacks - Open an existing file. You provide callbacks that the AudioFile API
; 		will use to get the data. 
;     
;     inRefCon 				- a constant that will be passed to your callbacks.
; 	AudioFile_ReadProc		- a function that will be called when AudioFile needs to read data.
; 	AudioFile_WriteProc		- a function that will be called when AudioFile needs to write data.
; 	AudioFile_GetSizeProc	- a function that will be called when AudioFile needs to know the file size.
; 	AudioFile_SetSizeProc	- a function that will be called when AudioFile needs to set the file size.
; 	
;     inFlags 		- relevent flags for creating/opening the file. Currently zero.
;     outAudioFile	- upon success, an AudioFileID that can be used for subsequent
;                       AudioFile calls.
; //----------------------------------------------------------------------------------

(deftrap-inline "_AudioFileOpenWithCallbacks" 
                                                ;  not seekable, read only
   ((inRefCon :pointer)
    (inReadFunc :pointer)
    (inWriteFunc :pointer)
    (inGetSizeFunc :pointer)
    (inSetSizeFunc :pointer)
    (inFlags :UInt32)
    (outAudioFile (:pointer :AUDIOFILEID))
   )
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;     AudioFileClose - Close an existing audio file.
; //----------------------------------------------------------------------------------

(deftrap-inline "_AudioFileClose" 
   ((inAudioFile (:pointer :OpaqueAudioFileID))
   )
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;     AudioFileOptimize - Optimize the file so additional audio data can be appended to 
;                         the existing data. Generally, this will place the audio data at 
;                         the end of the file so additional writes can be placed to the 
;                         file end. This can be a potentially expensive and time-consuming operation 
;                         and should not be used during time critical operations. There is 
;                         a kAudioFilePropertyIsOptimized property for checking on the optimized state 
;                         of the file.
; //----------------------------------------------------------------------------------

(deftrap-inline "_AudioFileOptimize" 
   ((inAudioFile (:pointer :OpaqueAudioFileID))
   )
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;     AudioFileReadBytes - Read bytes of audio data from the audio file. 
;      
;     inUseCache 		- true if it is desired to cache the data upon read, else false
;     inStartingByte	- the byte offset of the audio data desired to be returned
;     ioNumBytes 		- on input, the number of bytes to read, on output, the number of
;                       bytes actually read.
;     outBuffer 		- outBuffer should be a void * to user allocated memory of size: 
;                       number of bytes requested.
; //----------------------------------------------------------------------------------

(deftrap-inline "_AudioFileReadBytes" 
   ((inAudioFile (:pointer :OpaqueAudioFileID))
    (inUseCache :Boolean)
    (inStartingByte :SInt64)
    (ioNumBytes (:pointer :UInt32))
    (outBuffer :pointer)
   )
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;     AudioFileWriteBytes - Read bytes of audio data from the audio file. 
;      
;     inUseCache 		- true if it is desired to cache the data upon write, else false
;     inStartingByte 	- the byte offset where the audio data should be written
;     ioNumBytes 		- on input, the number of bytes to write, on output, the number of
;                       bytes actually written.
;     inBuffer 		- inBuffer should be a void * containing the bytes to be written
; //----------------------------------------------------------------------------------

(deftrap-inline "_AudioFileWriteBytes" 
   ((inAudioFile (:pointer :OpaqueAudioFileID))
    (inUseCache :Boolean)
    (inStartingByte :SInt64)
    (ioNumBytes (:pointer :UInt32))
    (inBuffer :pointer)
   )
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;     AudioFileReadPackets - Read packets of audio data from the audio file. For all 
;                            uncompressed formats, packet = frame.
; 
;     inUseCache 				- true if it is desired to cache the data upon read, else false
;     outNumBytes 			- on output, the number of bytes actually returned
;     outPacketDescriptions 	- on output, an array of packet descriptions describing
;                               the packets being returned. NULL may be passed for this
;                               parameter. Nothing will be returned for linear pcm data.   
;     inStartingPacket 		- the packet index of the first packet desired to be returned
;     ioNumPackets 			- on input, the number of packets to read, on output, the number of
;                               packets actually read.
;     outBuffer 				- outBuffer should be a void * to user allocated memory of size: 
;                               number of bytes requested.
; //----------------------------------------------------------------------------------

(deftrap-inline "_AudioFileReadPackets" 
   ((inAudioFile (:pointer :OpaqueAudioFileID))
    (inUseCache :Boolean)
    (outNumBytes (:pointer :UInt32))
    (outPacketDescriptions (:pointer :AudioStreamPacketDescription))
    (inStartingPacket :SInt64)
    (ioNumPackets (:pointer :UInt32))
    (outBuffer :pointer)
   )
   :OSStatus
() )
; ----------------------------------------------------------------------------------
;     AudioFileWritePackets - Write packets of audio data to the audio file. For all 
;                             uncompressed formats, packet = frame
; 							
;     inUseCache 				- true if it is desired to cache the data upon write, else false
;     inNumBytes 				- the number of bytes being provided for write
;     inPacketDescriptions 	- an array of packet descriptions describing the packets being 
;                               provided. Not all formats require packet descriptions to be 
;                               provided. NULL may be passed if no descriptions are required.
;     inStartingPacket 		- the packet index of where the first packet provided should be placed
;     ioNumPackets 			- on input, the number of packets to write, on output, the number of
;                               packets actually written.
;     inBuffer 				- a void * to user allocated memory containing the packets to write
; //----------------------------------------------------------------------------------

(deftrap-inline "_AudioFileWritePackets" 
   ((inAudioFile (:pointer :OpaqueAudioFileID))
    (inUseCache :Boolean)
    (inNumBytes :UInt32)
    (inPacketDescriptions (:pointer :AudioStreamPacketDescription))
    (inStartingPacket :SInt64)
    (ioNumPackets (:pointer :UInt32))
    (inBuffer :pointer)
   )
   :OSStatus
() )
; =============================================================================
; 	Audio File Properties
; =============================================================================

(defconstant $kAudioFilePropertyFileFormat :|ffmt|);  A UInt32 that identifies the format of the file

(defconstant $kAudioFilePropertyDataFormat :|dfmt|);  An AudioStreamBasicDescription describing the format of the audio data

(defconstant $kAudioFilePropertyIsOptimized :|optm|);  A UInt32 indicating whether an Audio File has been optimized.
;  Optimized meaning it is ready to start having sound data written
;  to it. A value of 0 indicates the file needs to be optimized.
;  A value of 1 indicates the file is currently optimized

(defconstant $kAudioFilePropertyMagicCookieData :|mgic|);  A void * pointing to memory set up by the caller.

(defconstant $kAudioFilePropertyAudioDataByteCount :|bcnt|);  a UInt64 that indicates the number of bytes of audio data contained in the file

(defconstant $kAudioFilePropertyAudioDataPacketCount :|pcnt|);  a UInt64 that indicates the number of packets of audio data contained in the file

(defconstant $kAudioFilePropertyMaximumPacketSize :|psze|);  a UInt32 that indicates the maximum size of a packet for the data contained in the file

(defconstant $kAudioFilePropertyDataOffset :|doff|);  a SInt64 that indicates the byte offset in the file of the audio data.

(defconstant $kAudioFilePropertyChannelLayout :|cmap|);  An AudioChannelLayout struct.

(defconstant $kAudioFilePropertyDeferSizeUpdates :|dszu|);  A UInt32. If 1, then updating the files sizes in the header is not done for every write, 
;  but deferred until the file is read, optimized or closed. This is more efficient, but less safe
;  since, if the application crashes before the size is updated, the file may not be readable.
;  The default value is zero, it always updates header.

(defconstant $kAudioFilePropertyDataFormatName :|fnme|);  This is deprecated. Use kAudioFormatProperty_FormatName in AudioFormat.h instead.

; -----------------------------------------------------------------------------
; 	AudioFileGetPropertyInfo
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioFileGetPropertyInfo" 
   ((inAudioFile (:pointer :OpaqueAudioFileID))
    (inPropertyID :UInt32)
    (outDataSize (:pointer :UInt32))
    (isWritable (:pointer :UInt32))
   )
   :OSStatus
() )
; -----------------------------------------------------------------------------
; 	AudioFileGetProperty
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioFileGetProperty" 
   ((inAudioFile (:pointer :OpaqueAudioFileID))
    (inPropertyID :UInt32)
    (ioDataSize (:pointer :UInt32))
    (outPropertyData :pointer)
   )
   :OSStatus
() )
; -----------------------------------------------------------------------------
; 	AudioFileSetProperty
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioFileSetProperty" 
   ((inAudioFile (:pointer :OpaqueAudioFileID))
    (inPropertyID :UInt32)
    (inDataSize :UInt32)
    (inPropertyData :pointer)
   )
   :OSStatus
() )
; =============================================================================
; 	Audio File Global Info Properties
; =============================================================================

(defconstant $kAudioFileGlobalInfo_ReadableTypes :|afrf|);  No specifier needed. Must be set to NULL.
;  Returns an array of UInt32 containing the file types 
;  (i.e. AIFF, WAVE, etc) that can be opened for reading.
;  The array can be used when creating a StandardGetFileDialog().

(defconstant $kAudioFileGlobalInfo_WritableTypes :|afwf|);  No specifier needed. Must be set to NULL.
;  Returns an array of UInt32 containing the file types 
;  (i.e. AIFF, WAVE, etc) that can be opened for writing.

(defconstant $kAudioFileGlobalInfo_FileTypeName :|ftnm|);  Specifier is a pointer to a UInt32 containing a file type.
;  Returns a CFString containing the name for the file type. 

(defconstant $kAudioFileGlobalInfo_ExtensionsForType :|fext|);  Specifier is a pointer to a UInt32 containing a file type.
;  Returns a CFArray of CFStrings containing the file extensions 
;  that are recognized for this file type. 

(defconstant $kAudioFileGlobalInfo_AllExtensions :|alxt|);  No specifier needed. Must be set to NULL.
;  Returns a CFArray of CFStrings containing all file extensions 
;  that are recognized. The array be used when creating an NSOpenPanel.

(defconstant $kAudioFileGlobalInfo_AvailableFormatIDs :|fmid|);  Specifier is a pointer to a UInt32 containing a file type.
;  Returns a array of format IDs for formats that can be read. 

(defconstant $kAudioFileGlobalInfo_AvailableStreamDescriptionsForFormat :|sdid|);  Specifier is a pointer to a AudioFileTypeAndFormatID struct defined below.
;  Returns an array of AudioStreamBasicDescriptions which have all of the 
;  formats for a particular file type and format ID. The AudioStreamBasicDescriptions
;  have the following fields filled in: mFormatID, mFormatFlags, mBitDepth
;  This is used as a specifier for kAudioFileGlobalInfo_AvailableStreamDescriptions
(defrecord AudioFileTypeAndFormatID
   (mFileType :UInt32)
   (mFormatID :UInt32)
)

;type name? (def-mactype :AudioFileTypeAndFormat (find-mactype ':AudioFileTypeAndFormat))
; -----------------------------------------------------------------------------
; 	AudioFileGetGlobalInfoSize
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioFileGetGlobalInfoSize" 
   ((inPropertyID :UInt32)
    (inSpecifierSize :UInt32)
    (inSpecifier :pointer)
    (outDataSize (:pointer :UInt32))
   )
   :OSStatus
() )
; -----------------------------------------------------------------------------
; 	AudioFileGetGlobalInfo
; -----------------------------------------------------------------------------

(deftrap-inline "_AudioFileGetGlobalInfo" 
   ((inPropertyID :UInt32)
    (inSpecifierSize :UInt32)
    (inSpecifier :pointer)
    (ioDataSize (:pointer :UInt32))
    (outPropertyData :pointer)
   )
   :OSStatus
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif


(provide-interface "AudioFile")