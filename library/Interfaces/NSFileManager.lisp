(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSFileManager.h"
; at Sunday July 2,2006 7:30:47 pm.
; 	NSFileManager.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSEnumerator.h>

; #import <Foundation/NSDictionary.h>

; #import <CoreFoundation/CFBase.h>
;  Version number where NSFileManager can copy/move/enumerate resources forks correctly
(defconstant $NSFoundationVersionWithFileManagerResourceForkSupport 412)
; #define NSFoundationVersionWithFileManagerResourceForkSupport 412
#| @INTERFACE 
NSFileManager : NSObject

+ (NSFileManager *)defaultManager;

- (NSString *)currentDirectoryPath;
- (BOOL)changeCurrentDirectoryPath:(NSString *)path;

- (NSDictionary *)fileAttributesAtPath:(NSString *)path traverseLink:(BOOL)yorn;

- (BOOL)changeFileAttributes:(NSDictionary *)attributes atPath:(NSString *)path;

- (BOOL)fileExistsAtPath:(NSString *)path;
- (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDirectory;
- (BOOL)isReadableFileAtPath:(NSString *)path;
- (BOOL)isWritableFileAtPath:(NSString *)path;
- (BOOL)isExecutableFileAtPath:(NSString *)path;
- (BOOL)isDeletableFileAtPath:(NSString *)path;

- (NSString *)displayNameAtPath:(NSString *)path;

- (BOOL)contentsEqualAtPath:(NSString *)path1 andPath:(NSString *)path2;
- (BOOL)linkPath:(NSString *)src toPath:(NSString *)dest handler:handler;
- (BOOL)copyPath:(NSString *)src toPath:(NSString *)dest handler:handler;

- (BOOL)movePath:(NSString *)src toPath:(NSString *)dest handler:handler;	

- (BOOL)removeFileAtPath:(NSString *)path handler:handler;

- (NSArray *)directoryContentsAtPath:(NSString *)path;
- (NSDirectoryEnumerator *)enumeratorAtPath:(NSString *)path;
- (NSArray *)subpathsAtPath:(NSString *)path;

- (BOOL)createDirectoryAtPath:(NSString *)path attributes:(NSDictionary *)attributes;

- (NSData *)contentsAtPath:(NSString *)path;
- (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data attributes:(NSDictionary *)attr;

- (NSString *)pathContentOfSymbolicLinkAtPath:(NSString *)path;
- (BOOL)createSymbolicLinkAtPath:(NSString *)path pathContent:(NSString *)otherpath;

- (NSDictionary *)fileSystemAttributesAtPath:(NSString *)path;

- (const char *)fileSystemRepresentationWithPath:(NSString *)path;
- (NSString *)stringWithFileSystemRepresentation:(const char *)str length:(unsigned)len;
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (NSArray *)componentsToDisplayForPath:(NSString *)path;
#endif
|#
#| @INTERFACE 
NSObject (NSCopyLinkMoveHandler)
- (BOOL)fileManager:(NSFileManager *)fm shouldProceedAfterError:(NSDictionary *)errorInfo;
- (void)fileManager:(NSFileManager *)fm willProcessPath:(NSString *)path;
|#
#| @INTERFACE 
NSDirectoryEnumerator : NSEnumerator
- (NSDictionary *)fileAttributes;
- (NSDictionary *)directoryAttributes;
- (void)skipDescendents;
|#
; *************** File Attributes ***************
(def-mactype :NSFileType (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileTypeDirectory (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileTypeRegular (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileTypeSymbolicLink (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileTypeSocket (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileTypeCharacterSpecial (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileTypeBlockSpecial (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileTypeUnknown (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileSize (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileModificationDate (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileReferenceCount (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileDeviceIdentifier (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileOwnerAccountName (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileGroupOwnerAccountName (find-mactype '(:pointer :NSString)))
(def-mactype :NSFilePosixPermissions (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileSystemNumber (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileSystemFileNumber (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileExtensionHidden (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileHFSCreatorCode (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileHFSTypeCode (find-mactype '(:pointer :NSString)))

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
(def-mactype :NSFileImmutable (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileAppendOnly (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileCreationDate (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileOwnerAccountID (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileGroupOwnerAccountID (find-mactype '(:pointer :NSString)))

; #endif

;  File System attributes 
(def-mactype :NSFileSystemSize (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileSystemFreeSize (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileSystemNodes (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileSystemFreeNodes (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSDictionary (NSFileAttributes)

- (unsigned long long)fileSize;
- (NSDate *)fileModificationDate;
- (NSString *)fileType;
- (unsigned long)filePosixPermissions;
- (NSString *)fileOwnerAccountName;
- (NSString *)fileGroupOwnerAccountName;
#if !defined(__WIN32__)
- (unsigned long)fileSystemNumber;
- (unsigned long)fileSystemFileNumber;
#endif	
- (BOOL)fileExtensionHidden;
- (OSType)fileHFSCreatorCode;
- (OSType)fileHFSTypeCode;
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (BOOL)fileIsImmutable;
- (BOOL)fileIsAppendOnly;
- (NSDate *)fileCreationDate;
- (NSNumber *)fileOwnerAccountID;
- (NSNumber *)fileGroupOwnerAccountID;
#endif
|#

(provide-interface "NSFileManager")