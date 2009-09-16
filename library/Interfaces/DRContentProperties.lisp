(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRContentProperties.h"
; at Sunday July 2,2006 7:27:38 pm.
; 
;      File:       DiscRecordingContent/DRContentProperties.h
;  
;      Contains:   Property strings for filesystem objects.
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
; #ifndef _H_DRContentProperties
; #define _H_DRContentProperties

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifndef __COREFOUNDATION__

(require-interface "CoreFoundation/CoreFoundation")

; #endif

; #ifndef __AVAILABILITYMACROS__

(require-interface "AvailabilityMacros")

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
;  -------------------------------------------------------------------------------- 
;  Keys for track properties 
; ! @constant	kDRISOLevel
; 	@abstract	The key for indicating the ISO level of the ISO-9660 filesystem on the track. 
; 	@discussion	Value is a CFNumberRef, currently should be 1 or 2.
; 
(def-mactype :kDRISOLevel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRVolumeSet
; 	@abstract	(ISO/Joliet) The key for indicating the volume set name.
; 	@discussion	Value is a CFStringRef.
; 
(def-mactype :kDRVolumeSet (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRPublisher
; 	@abstract	(ISO/Joliet) The key for indicating the publisher string.
; 	@discussion	Value is a CFStringRef.
; 
(def-mactype :kDRPublisher (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRDataPreparer
; 	@abstract	(ISO/Joliet) The key for indicating the data preparer.
; 	@discussion	Value is a CFStringRef.
; 
(def-mactype :kDRDataPreparer (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRSystemIdentifier
; 	@abstract	(ISO/Joliet) The key for indicating the system identifier.
; 	@discussion	Value is a CFStringRef.
; 				Only the first 32 characters (ISO) or 16 characters (Joliet)
; 				will be used, after being mapped into a legal character set.
; 				Note, this value will NOT be used if Mac extensions are turned
; 				on - with Mac extensions, the system identifier will always be
; 				"APPLE COMPUTER, INC., TYPE: 0002"
; 
(def-mactype :kDRSystemIdentifier (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRApplicationIdentifier
; 	@abstract	(ISO/Joliet) The key for indicating the application identifier.
; 	@discussion	Value is a CFStringRef.
; 				Only the first 32 characters (ISO) or 16 characters (Joliet)
; 				will be used, after being mapped into a legal character set.
; 
(def-mactype :kDRApplicationIdentifier (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRCopyrightFile
; 	@abstract	(ISO/Joliet) The key for indicating the copyright file.
; 	@discussion	Value is a DRFileRef (which must be in the root directory).
; 
(def-mactype :kDRCopyrightFile (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRAbstractFile
; 	@abstract	(ISO/Joliet) The key for indicating the abstract file.
; 	@discussion	Value is a DRFileRef (which must be in the root directory).
; 
(def-mactype :kDRAbstractFile (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRBibliographicFile
; 	@abstract	(ISO/Joliet) The key for indicating the bibliographic file.
; 	@discussion	Value is a DRFileRef (which must be in the root directory).
; 
(def-mactype :kDRBibliographicFile (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; ! @constant	kDRBlockSize
; 	@abstract	The key for indicating the block size of the track.
; 	@discussion	Value is a CFNumberRef, currently always 2048.  Do not change.
; 
(def-mactype :kDRBlockSize (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; ! @constant	kDRDefaultDate
; 	@abstract	The default date for any unspecified dates in the filesystem.
; 	@discussion	Value is a CFDateRef.  The current date and time is used if unspecified.
; 
(def-mactype :kDRDefaultDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRVolumeCreationDate
; 	@abstract	The key for indicating the volume creation date.
; 	@discussion	Value is a CFDateRef.  kDRDefaultDate is used if unspecified.
; 
(def-mactype :kDRVolumeCreationDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRVolumeModificationDate
; 	@abstract	The key for indicating the volume modification date.
; 	@discussion	Value is a CFDateRef.  kDRDefaultDate is used if unspecified.
; 
(def-mactype :kDRVolumeModificationDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRVolumeCheckedDate
; 	@abstract	(HFS+) The key for indicating the volume-checked date.
; 	@discussion	Value is a CFDateRef.  kDRDefaultDate is used if unspecified.
; 
(def-mactype :kDRVolumeCheckedDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRVolumeExpirationDate
; 	@abstract	(ISO/Joliet) The date and time at which the volume expires.
; 	@discussion	Value is a CFDateRef.  Empty if unspecified.
; 
(def-mactype :kDRVolumeExpirationDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRVolumeEffectiveDate
; 	@abstract	(ISO/Joliet) The date and time at which the volume is effective.
; 	@discussion	Value is a CFDateRef.  Empty if unspecified.
; 
(def-mactype :kDRVolumeEffectiveDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRISOMacExtensions
; 	@abstract	(ISO/Joliet) Whether to add ISO/Joliet Mac extensions when appropriate.
; 	@discussion	Value is a CFBooleanRef.
; 
(def-mactype :kDRISOMacExtensions (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRISORockRidgeExtensions
; 	@abstract	(ISO/Joliet) Whether to add RockRidge (POSIX extensions) when appropriate.
; 	@discussion	Value is a CFBooleanRef.
; 
(def-mactype :kDRISORockRidgeExtensions (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRSuppressMacSpecificFiles
; 	@abstract	Whether to suppress Mac-specific files from non-HFS filesystems.
; 	@discussion	Value is a CFBooleanRef.
; 
(def-mactype :kDRSuppressMacSpecificFiles (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  -------------------------------------------------------------------------------- 
;  Keys for accessing names and properties 
; !
; 	@constant	kDRAllFilesystems
; 	@abstract	The key for accessing the name or properties for the file in
; 				all filesystems together.
; 	@discussion	When this key is used to refer to a name, it refers to the
; 				base name (which has no naming restrictions).
; 
(def-mactype :kDRAllFilesystems (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@constant	kDRISO9660
; 	@abstract	The key for accessing the ISO-9660 properties for the file.
; 	@discussion	This key is used to refer specifically to the properties for the file.
; 	
; 				This key cannot be used to refer to the name of the file; it is ambiguous,
; 				since the name may be in either level 1 or level 2 format.
; 
(def-mactype :kDRISO9660 (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRISO9660LevelOne
; 	@abstract	The key for accessing the ISO-9660 level 1 name for the file.
; 	@discussion	This key is used to refer specifically to the name generated for ISO-9660 if
; 				the ISO level is set to 1.  When used for a property, it is equivalent
; 				in use to the kDRISO9660 key and acts as a synonym for that key.
; 				
; 				ISO9660 level 1 names are in the form typically known as 8.3 - eight
; 				characters of name and three characters of extension (if it's a file;
; 				directories can't have extensions).  Character set is limited to
; 				A-Z, 0-9, and _.
; 
(def-mactype :kDRISO9660LevelOne (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRISO9660LevelTwo
; 	@abstract	The key for accessing the ISO-9660 level 2 name for the file.
; 	@discussion	This key is used to refer specifically to the name generated for ISO-9660 if
; 				the ISO level is set to 2.  When used for a property, it is equivalent
; 				in use to the kDRISO9660 key and acts as a synonym for that key.
; 	
; 				ISO9660 level 2 names can be 32 chars long, are limited to a subset
; 				of the 7-bit ASCII chars (capital letters, numbers, space, punctuation),
; 				and are only allowed one "." character.
; 
(def-mactype :kDRISO9660LevelTwo (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRJoliet
; 	@abstract	The key for accessing the Joliet name/properties for the file.
; 	@discussion	Joliet names can be 64 precomposed unicode characters long, but are only
; 				allowed one "." character and many punctuation characters are illegal.
; 
(def-mactype :kDRJoliet (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRHFSPlus
; 	@abstract	The key for accessing the HFS+ name/properties for the file.
; 	@discussion	HFS+ names can be up to 255 decomposed unicode characters long.
; 
(def-mactype :kDRHFSPlus (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  -------------------------------------------------------------------------------- 
;  Keys for file/folder properties 
; !	@constant	kDRISO9660VersionNumber
; 	@abstract	The property key for the ISO9660 version number for the object.
; 	@discussion	Value is a CFNumber, default value is 1.
; 
(def-mactype :kDRISO9660VersionNumber (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRInvisible
; 	@abstract	The property key for the invisibility of the object.
; 	@discussion	Value is a CFBooleanRef.
; 
(def-mactype :kDRInvisible (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; ! @constant	kDRCreationDate
; 	@abstract	The property key for the item's creation date.
; 	@discussion	Value is a CFDateRef.
; 
(def-mactype :kDRCreationDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; ! @constant	kDRContentModificationDate
; 	@abstract	The property key for the item's content modification date.
; 	@discussion	Value is a CFDateRef.
; 
(def-mactype :kDRContentModificationDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; ! @constant	kDRAttributeModificationDate
; 	@abstract	The property key for the item's attribute modification date.
; 	@discussion	Value is a CFDateRef.
; 
(def-mactype :kDRAttributeModificationDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; ! @constant	kDRAccessDate
; 	@abstract	The property key for the item's last-accessed date.
; 	@discussion	Value is a CFDateRef.
; 
(def-mactype :kDRAccessDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; ! @constant	kDRBackupDate
; 	@abstract	The property key for the item's backup date.
; 	@discussion	Value is a CFDateRef.
; 
(def-mactype :kDRBackupDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRRecordingDate
; 	@abstract	The property key for the item's recording date.
; 	@discussion	Value is a CFDateRef.
; 
(def-mactype :kDRRecordingDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDREffectiveDate
; 	@abstract	The property key for the item's effective date, the date at which
; 				the contents become valid.
; 	@discussion	Value is a CFDateRef.
; 
(def-mactype :kDREffectiveDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRExpirationDate
; 	@abstract	The property key for the item's expiration date, the date at which
; 				the contents become no longer valid.
; 	@discussion	Value is a CFDateRef.
; 
(def-mactype :kDRExpirationDate (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRPosixFileMode
; 	@abstract	The posix file mode.
; 	@discussion	Value is a CFNumber.
; 
(def-mactype :kDRPosixFileMode (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRPosixUID
; 	@abstract	The posix file UID.
; 	@discussion	Value is a CFNumber.
; 
(def-mactype :kDRPosixUID (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRPosixGID
; 	@abstract	The posix file GID.
; 	@discussion	Value is a CFNumber.
; 
(def-mactype :kDRPosixGID (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRHFSPlusTextEncodingHint
; 	@abstract	The property key for the item's text encoding hint (HFS+ only).
; 	@discussion	Value is a CFNumber.  This value is used by the MacOS to help when converting
; 				the natively UTF-16 filename into an 8-bit-per-character representation (such
; 				as MacRoman, Shift-JIS, or UTF8).  If not set, default behavior is to call
; 				CFStringGetMostCompatibleMacStringEncoding(CFStringGetSmallestEncoding()).
; 
(def-mactype :kDRHFSPlusTextEncodingHint (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRHFSPlusCatalogNodeID
; 	@abstract	The property key for the item's catalog node ID (HFS+ only).
; 	@discussion	Value is a CFNumber.  Currently, this value if set is only a suggestion.
; 				The burn engine will attempt to use this node ID, but may use another value
; 				if it needs to resolve conflicts.  Default behavior is to allocate node IDs
; 				incrementally from kHFSFirstUserCatalogNodeID.
; 
(def-mactype :kDRHFSPlusCatalogNodeID (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRMacFileType
; 	@abstract	The property key for a file's type (MacOS only).
; 	@discussion	Value is a CFDataRef containing an OSType.
; 
(def-mactype :kDRMacFileType (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRMacFileCreator
; 	@abstract	The property key for a file's creator (MacOS only).
; 	@discussion	Value is a CFDataRef containing an OSType.
; 
(def-mactype :kDRMacFileCreator (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; ! @constant	kDRMacWindowBounds
; 	@abstract	The property key for the window bounds for a folder (MacOS only).
; 	@discussion	Value is a CFDataRef containing a Rect.
; 
(def-mactype :kDRMacWindowBounds (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRMacIconLocation
; 	@abstract	The property key for the item's icon location in its parent folder (MacOS only).
; 	@discussion	Value is a CFDataRef containing a Point.
; 
(def-mactype :kDRMacIconLocation (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRMacScrollPosition
; 	@abstract	The property key for the folder's scroll position (MacOS only).
; 	@discussion	Value is a CFDataRef containing a Point.
; 
(def-mactype :kDRMacScrollPosition (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRMacWindowView
; 	@abstract	The property key for the folder's window view (MacOS only).
; 	@discussion	Value is a CFNumber.
; 
(def-mactype :kDRMacWindowView (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRMacFinderFlags
; 	@abstract	The property key for the item's Finder flags (MacOS only).
; 	@discussion	Value is a CFNumber.  The "invisible" bit is ignored - use kDRInvisibility instead.
; 
(def-mactype :kDRMacFinderFlags (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !	@constant	kDRMacExtendedFinderFlags
; 	@abstract	The property key for the item's extended Finder flags (MacOS only).
; 	@discussion	Value is a CFNumber.
; 
(def-mactype :kDRMacExtendedFinderFlags (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _H_DRContentProperties */


(provide-interface "DRContentProperties")