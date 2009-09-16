(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRFile.h"
; at Sunday July 2,2006 7:27:42 pm.
; 
;      File:       DiscRecordingContent/DRFile.h
;  
;      Contains:   ObjC interface to file objects used in filesystem creation.
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

; #import <DiscRecordingContent/DRFSObject.h>

; #import <AvailabilityMacros.h>
; !
; 	@class		DRFile
; 	@abstract	Represents a file to be created on the disc.
; 	@discussion
; 				A file can be either a pointer to a real file or can be created at burn time from data passed 
; 				into the burn engine as requested. DRFile's can only exist inside of "virtual"
; 				DRFolder objects.
; 
#| @INTERFACE 
DRFile : DRFSObject
{ }


+ (DRFile*) fileWithPath:(NSString*)path;


- (id) initWithPath:(NSString*)path;

|#
; " This category on DRFile implements methods that allow the
; 	file to be specified using data passed in at creation time. "
#| @INTERFACE 
DRFile (VirtualFiles)


+ (DRFile*) virtualFileWithName:(NSString*)name data:(NSData*)data;


+ (DRFile*) virtualFileWithName:(NSString*)name dataProducer:(id)producer;


- (id) initWithName:(NSString*)name data:(NSData*)data;


- (id) initWithName:(NSString*)name dataProducer:(id)producer;

|#
; " This category on DRFile implements methods that allow various
; 	link/alias files to be created on the resulting disc which may not
; 	exist in the source. "
#| @INTERFACE 
DRFile (VirtualLinks)


+ (DRFile*) hardLinkPointingTo:(DRFile*)original inFilesystem:(NSString*)filesystem;


+ (DRFile*) symLinkPointingTo:(DRFSObject*)original inFilesystem:(NSString*)filesystem;


+ (DRFile*) finderAliasPointingTo:(DRFSObject*)original inFilesystem:(NSString*)filesystem;


- (id) initWithLinkType:(NSString*)linkType pointingTo:(DRFSObject*)original inFilesystem:(NSString*)filesystem;

|#
; !
; 	@const		DRLinkTypeHardLink
; 	@discussion	A hard link.
; 
(def-mactype :DRLinkTypeHardLink (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRLinkTypeSymbolicLink
; 	@discussion	A symbolic link.
; 
(def-mactype :DRLinkTypeSymbolicLink (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRLinkTypeFinderAlias
; 	@discussion	A Finder alias.
; 
(def-mactype :DRLinkTypeFinderAlias (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@typedef	DRFileFork
; 	@abstract	Index used for accessing the forks of a file.
; 	@discussion	The data fork and resource fork always have fixed indices.  Other forks
; 				may be allowed in the future.
; 

(def-mactype :DRFileFork (find-mactype ':UInt32))
; !	@constant	DRFileForkData
; 		@abstract	Typically, the data fork contains the primary information for the file and
; 					is the fork used for files such as JPEGs, text files, etc.
; 	

(defconstant $DRFileForkData 0)
; !	@constant	DRFileForkResource
; 		@abstract	Typically, the resource fork contains secondary meta-data, which is not
; 					important to the primary content of the file and may safely be ignored
; 					when the file is sent to a filesystem or OS which does not support
; 					multiple forks.  See Inside Macintosh: Resources for more information on
; 					the format of a resource fork.
; 	

(defconstant $DRFileForkResource 1)
; !
; 	@protocol	DRFileDataProduction
; 	@abstract	Informal protocol describing methods implemented by the file data producer.
; 	@discussion	The DRFileDataProduction informal protocol defines those methods that a file data producer 
; 				instance must implement. A file data producer is the object that
; 				resposible for providing the file data to the burn engine on request
; 
#| @PROTOCOL 
DRFileDataProduction


- (uint64_t) calculateSizeOfFile:(DRFile*)file fork:(DRFileFork)fork estimating:(BOOL)estimate;


- (BOOL) prepareFileForBurn:(DRFile*)file;


- (uint32_t) produceFile:(DRFile*)file fork:(DRFileFork)fork intoBuffer:(char*)buffer length:(uint32_t)bufferLength atAddress:(uint64_t)address blockSize:(uint32_t)blockSize;


- (BOOL) prepareFileForVerification:(DRFile*)file;


- (void) cleanupFileAfterBurn:(DRFile*)file;

|#

(provide-interface "DRFile")