(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPathUtilities.h"
; at Sunday July 2,2006 7:30:55 pm.
; 	NSPathUtilities.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSString.h>

; #import <Foundation/NSArray.h>
#| @INTERFACE 
NSString (NSStringPathExtensions)

+ (NSString *)pathWithComponents:(NSArray *)components;
- (NSArray *)pathComponents;

- (BOOL)isAbsolutePath;

- (NSString *)lastPathComponent;
- (NSString *)stringByDeletingLastPathComponent;
- (NSString *)stringByAppendingPathComponent:(NSString *)str;

- (NSString *)pathExtension;
- (NSString *)stringByDeletingPathExtension;
- (NSString *)stringByAppendingPathExtension:(NSString *)str;

- (NSString *)stringByAbbreviatingWithTildeInPath;
- (NSString *)stringByExpandingTildeInPath;

- (NSString *)stringByStandardizingPath;

- (NSString *)stringByResolvingSymlinksInPath;

- (NSArray *)stringsByAppendingPaths:(NSArray *)paths;

- (unsigned)completePathIntoString:(NSString **)outputName caseSensitive:(BOOL)flag matchesIntoArray:(NSArray **)outputArray filterTypes:(NSArray *)filterTypes;

- (const char *)fileSystemRepresentation;
- (BOOL)getFileSystemRepresentation:(char *)cname maxLength:(unsigned)max;

|#
#| @INTERFACE 
NSArray (NSArrayPathExtensions)

- (NSArray *)pathsMatchingExtensions:(NSArray *)filterTypes;

|#

(deftrap-inline "_NSUserName" 
   (
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSFullUserName" 
   (
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSHomeDirectory" 
   (
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSHomeDirectoryForUser" 
   ((userName (:pointer :NSString))
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSTemporaryDirectory" 
   (
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSOpenStepRootDirectory" 
   (
   )
   (:pointer :NSString)
() )

(defconstant $NSApplicationDirectory 1)         ;  supported applications (Applications)

(defconstant $NSDemoApplicationDirectory 2)     ;  unsupported applications, demonstration versions (Demos)

(defconstant $NSDeveloperApplicationDirectory 3);  developer applications (Developer/Applications)

(defconstant $NSAdminApplicationDirectory 4)    ;  system and network administration applications (Administration)

(defconstant $NSLibraryDirectory 5)             ;  various user-visible documentation, support, and configuration files, resources (Library)

(defconstant $NSDeveloperDirectory 6)           ;  developer resources (Developer)

(defconstant $NSUserDirectory 7)                ;  user home directories (Users)

(defconstant $NSDocumentationDirectory 8)       ;  documentation (Documentation)

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

(defconstant $NSDocumentDirectory 9)            ;  documents (Documents)

; #endif


(defconstant $NSAllApplicationsDirectory 100)   ;  all directories where applications can occur

(defconstant $NSAllLibrariesDirectory 101)      ;  all directories where resources can occur

(def-mactype :NSSearchPathDirectory (find-mactype ':SINT32))

(defconstant $NSUserDomainMask 1)               ;  user's home directory --- place to install user's personal items (~)

(defconstant $NSLocalDomainMask 2)              ;  local to the current machine --- place to install items available to everyone on this machine (/Library)

(defconstant $NSNetworkDomainMask 4)            ;  publically available location in the local area network --- place to install items available on the network (/Network)

(defconstant $NSSystemDomainMask 8)             ;  provided by Apple, unmodifiable (/System)

(defconstant $NSAllDomainsMask #xFFFF)          ;  all domains: all of the above and future items

(def-mactype :NSSearchPathDomainMask (find-mactype ':SINT32))

(deftrap-inline "_NSSearchPathForDirectoriesInDomains" 
   ((directory :SInt32)
    (domainMask :SInt32)
    (expandTilde :Boolean)
   )
   (:pointer :nsarray)
() )

(provide-interface "NSPathUtilities")