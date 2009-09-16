(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:LSInfo.h"
; at Sunday July 2,2006 7:24:45 pm.
; 
;      File:       LaunchServices/LSInfo.h
;  
;      Contains:   Public interfaces for LaunchServices.framework
;  
;      Version:    LaunchServices-98~1
;  
;      Copyright:  © 2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __LSINFO__
; #define __LSINFO__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #pragma options align=mac68k
;  ======================================================================================================== 
;  LaunchServices Type & Constants                                                                          
;  ======================================================================================================== 

(defconstant $kLSAppInTrashErr -10660)          ;  The app cannot be run when inside a Trash folder

(defconstant $kLSUnknownErr -10810)
(defconstant $kLSNotAnApplicationErr -10811)
(defconstant $kLSNotInitializedErr -10812)
(defconstant $kLSDataUnavailableErr -10813)     ;  e.g. no kind string

(defconstant $kLSApplicationNotFoundErr -10814) ;  e.g. no application claims the file

(defconstant $kLSUnknownTypeErr -10815)
(defconstant $kLSDataTooOldErr -10816)
(defconstant $kLSDataErr -10817)
(defconstant $kLSLaunchInProgressErr -10818)    ;  e.g. opening an alreay opening application

(defconstant $kLSNotRegisteredErr -10819)
(defconstant $kLSAppDoesNotClaimTypeErr -10820)
(defconstant $kLSAppDoesNotSupportSchemeWarning -10821);  not an error, just a warning

(defconstant $kLSServerCommunicationErr -10822) ;  cannot set recent items

(defconstant $kLSCannotSetInfoErr -10823)       ;  you may not set item info for this item

(defconstant $kLSNoRegistrationInfoErr -10824)  ;  the item contains no registration info

(defconstant $kLSIncompatibleSystemVersionErr -10825);  the app cannot run on the current OS version

(defconstant $kLSNoLaunchPermissionErr -10826)  ;  user doesn't have permission to launch the app (managed networks)

(defconstant $kLSNoExecutableErr -10827)        ;  the executable is missing or has an unusable format

(defconstant $kLSNoClassicEnvironmentErr -10828);  the Classic environment was required but is not available
;  the app cannot run simultaneously in two different sessions

(defconstant $kLSMultipleSessionsNotSupportedErr -10829)

(def-mactype :LSInitializeFlags (find-mactype ':UInt32))

(defconstant $kLSInitializeDefaults 1)
;  do not use 

(defconstant $kLSMinCatInfoBitmap #x180A)
;  Index returned from LSGetExtensionInfo when name has no extension

(defconstant $kLSInvalidExtensionIndex #xFFFFFFFF)

(def-mactype :LSRequestedInfo (find-mactype ':UInt32))

(defconstant $kLSRequestExtension 1)            ;  thread-safe in 10.0

(defconstant $kLSRequestTypeCreator 2)          ;  thread-safe in 10.0

(defconstant $kLSRequestBasicFlagsOnly 4)       ;  thread-safe in 10.2

(defconstant $kLSRequestAppTypeFlags 8)         ;  thread-safe in 10.2

(defconstant $kLSRequestAllFlags 16)            ;  thread-safe in 10.2

(defconstant $kLSRequestIconAndKind 32)         ;  thread-safe in 10.2

(defconstant $kLSRequestExtensionFlagsOnly 64)  ;  thread-safe in 10.0
;  thread-safe in 10.2

(defconstant $kLSRequestAllInfo #xFFFFFFFF)

(def-mactype :LSItemInfoFlags (find-mactype ':UInt32))

(defconstant $kLSItemInfoIsPlainFile 1)         ;  Not a directory, volume, or symlink

(defconstant $kLSItemInfoIsPackage 2)           ;  Packaged directory

(defconstant $kLSItemInfoIsApplication 4)       ;  Single-file or packaged application

(defconstant $kLSItemInfoIsContainer 8)         ;  Directory (includes packages) or volume

(defconstant $kLSItemInfoIsAliasFile 16)        ;  Alias file (includes sym links)

(defconstant $kLSItemInfoIsSymlink 32)          ;  UNIX sym link

(defconstant $kLSItemInfoIsInvisible 64)        ;  Invisible by any known mechanism

(defconstant $kLSItemInfoIsNativeApp #x80)      ;  Carbon or Cocoa native app

(defconstant $kLSItemInfoIsClassicApp #x100)    ;  CFM/68K Classic app

(defconstant $kLSItemInfoAppPrefersNative #x200);  Carbon app that prefers to be launched natively

(defconstant $kLSItemInfoAppPrefersClassic #x400);  Carbon app that prefers to be launched in Classic

(defconstant $kLSItemInfoAppIsScriptable #x800) ;  App can be scripted

(defconstant $kLSItemInfoIsVolume #x1000)       ;  Item is a volume

(defconstant $kLSItemInfoExtensionIsHidden #x100000);  Item has a hidden extension


(def-mactype :LSRolesMask (find-mactype ':UInt32))

(defconstant $kLSRolesNone 1)                   ;  no claim is made about support for this type/scheme

(defconstant $kLSRolesViewer 2)                 ;  claim to be able to view this type/scheme

(defconstant $kLSRolesEditor 4)                 ;  claim to be able to edit this type/scheme
;  claim to do it all

(defconstant $kLSRolesAll #xFFFFFFFF)

(def-mactype :LSKindID (find-mactype ':UInt32))

(defconstant $kLSUnknownKindID 0)

(defconstant $kLSUnknownType 0)
(defconstant $kLSUnknownCreator 0)
(defrecord LSItemInfoRecord
   (flags :UInt32)
   (filetype :OSType)
   (creator :OSType)
   (extension (:pointer :__CFString))           ;  release when finished
   (iconFileName (:pointer :__CFString))        ;  not for general use
   (kindID :UInt32)                             ;  not for general use
)

;type name? (%define-record :LSItemInfoRecord (find-record-descriptor ':LSItemInfoRecord))

(def-mactype :LSAcceptanceFlags (find-mactype ':UInt32))

(defconstant $kLSAcceptDefault 1)
(defconstant $kLSAcceptAllowLoginUI 2)          ;  show UI to log in if necessary

;  ======================================================================================================== 
;  LaunchServices API                                                                                       
;  ======================================================================================================== 
; 
;  *  LSInit()   *** DEPRECATED ***
;  *  
;  *  Discussion:
;  *    LSInit is deprecated. Do not use.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework but deprecated in 10.3
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSInit" 
   ((inFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSStatus
() )
; 
;  *  LSTerm()   *** DEPRECATED ***
;  *  
;  *  Discussion:
;  *    LSTerm is deprecated. It does nothing.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework but deprecated in 10.3
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSTerm" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSStatus
() )
; 
;  *  LSCopyItemInfoForRef()
;  *  
;  *  Summary:
;  *    Return information about an item.
;  *  
;  *  Discussion:
;  *    Returns as much or as little information as requested about
;  *    inItemRef.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inItemRef:
;  *      The FSRef of the item about which information is requested.
;  *    
;  *    inWhichInfo:
;  *      Flags indicating which information to return
;  *    
;  *    outItemInfo:
;  *      Information is returned in this structure. Must not be NULL
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSCopyItemInfoForRef" 
   ((inItemRef (:pointer :FSRef))
    (inWhichInfo :UInt32)
    (outItemInfo (:pointer :LSItemInfoRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LSCopyItemInfoForURL()
;  *  
;  *  Summary:
;  *    Return information about an item.
;  *  
;  *  Discussion:
;  *    Returns as much or as little information as requested about inURL.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inURL:
;  *      The CFURLRef of the item about which information is requested.
;  *    
;  *    inWhichInfo:
;  *      Flags indicating which information to return
;  *    
;  *    outItemInfo:
;  *      Information is returned in this structure. Must not be NULL
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSCopyItemInfoForURL" 
   ((inURL (:pointer :__CFURL))
    (inWhichInfo :UInt32)
    (outItemInfo (:pointer :LSItemInfoRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LSGetExtensionInfo()
;  *  
;  *  Summary:
;  *    Get information about the extension for a file system name.
;  *  
;  *  Discussion:
;  *    Returns the starting index of the extension (not including the
;  *    period) or kLSInvalidExtensionIndex if the input name has no
;  *    extension.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inNameLen:
;  *      The number of the UniChars in inNameBuffer.
;  *    
;  *    inNameBuffer:
;  *      The buffer containing the name's Unicode characters.
;  *    
;  *    outExtStartIndex:
;  *      On success, the starting index of the extension if there is one
;  *      (not including the period). Set to kLSInvalidExtensionIndex if
;  *      inNameBuffer does not contain a valid extension.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSGetExtensionInfo" 
   ((inNameLen :UInt32)
    (inNameBuffer (:pointer :UniChar))
    (outExtStartIndex (:pointer :UniCharCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  LSCopyDisplayNameForRef()
;  *  
;  *  Summary:
;  *    Get the display name for an FSRef.
;  *  
;  *  Discussion:
;  *    Return a copy of the display name for an FSRef. Takes into
;  *    consideration whether this item has a hidden extension or not.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inRef:
;  *      The FSRef for which the display name is desired.
;  *    
;  *    outDisplayName:
;  *      Pointer to the CFString into which the display name should be
;  *      copied. Callers must dispose of the resulting CFString.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSCopyDisplayNameForRef" 
   ((inRef (:pointer :FSRef))
    (outDisplayName (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  LSCopyDisplayNameForURL()
;  *  
;  *  Summary:
;  *    Get the display name for a CFURLRef.
;  *  
;  *  Discussion:
;  *    Return a copy of the display name for a CFURLRef. Takes into
;  *    consideration whether this item has a hidden extension or not.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inURL:
;  *      The URL for which the display name is desired.
;  *    
;  *    outDisplayName:
;  *      Pointer to the CFString into which the display name should be
;  *      copied. Callers must dispose of the resulting CFString.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSCopyDisplayNameForURL" 
   ((inURL (:pointer :__CFURL))
    (outDisplayName (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  LSSetExtensionHiddenForRef()
;  *  
;  *  Summary:
;  *    Sets whether the extension for an FSRef is hidden or not.
;  *  
;  *  Discussion:
;  *    Sets the necessary file system state to indicate that the
;  *    extension for inRef is hidden, as in the Finder. You can
;  *    determine if an FSRef's extension is hidden using
;  *    LSCopyItemInfoForRef.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inRef:
;  *      The FSRef for which the extension is to be hidden or shown.
;  *    
;  *    inHide:
;  *      True to hide inRef's extension, false to show it.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSSetExtensionHiddenForRef" 
   ((inRef (:pointer :FSRef))
    (inHide :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  LSSetExtensionHiddenForURL()
;  *  
;  *  Summary:
;  *    Sets whether the extension for a CFURLRef is hidden or not.
;  *  
;  *  Discussion:
;  *    Sets the necessary file system state to indicate that the
;  *    extension for inURL is hidden, as in the Finder. You can
;  *    determine if a CFURLRef's extension is hidden using
;  *    LSCopyItemInfoForURL.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inURL:
;  *      The CFURLRef for which the extension is to be hidden or shown.
;  *    
;  *    inHide:
;  *      True to hide inURL's extension, false to show it.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSSetExtensionHiddenForURL" 
   ((inURL (:pointer :__CFURL))
    (inHide :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  LSCopyKindStringForRef()
;  *  
;  *  Summary:
;  *    Get the kind string for an item.
;  *  
;  *  Discussion:
;  *    Returns the kind string as used in the Finder and elsewhere for
;  *    inFSRef. The CFStringRef must be released after use.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inFSRef:
;  *      The item for which the kind string is requested.
;  *    
;  *    outKindString:
;  *      A CFStringRef* to receive the copied kind string object. This
;  *      CFStringRef must be released eventually.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSCopyKindStringForRef" 
   ((inFSRef (:pointer :FSRef))
    (outKindString (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LSCopyKindStringForURL()
;  *  
;  *  Summary:
;  *    Get the kind string for an item.
;  *  
;  *  Discussion:
;  *    Returns the kind string as used in the Finder and elsewhere for
;  *    inURL. The CFStringRef must be released after use.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inURL:
;  *      The item for which the kind string is requested.
;  *    
;  *    outKindString:
;  *      A CFStringRef* to receive the copied kind string object. This
;  *      CFStringRef must be released eventually.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSCopyKindStringForURL" 
   ((inURL (:pointer :__CFURL))
    (outKindString (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LSCopyKindStringForTypeInfo()
;  *  
;  *  Summary:
;  *    Return the kind string for items like the provided info
;  *  
;  *  Discussion:
;  *    Returns the kind string as shown in the Finder for the those
;  *    items whose type, creator, and/or extension match the provided
;  *    information. The kind string returned will be the one that most
;  *    closely describes all the information provided. The kind string
;  *    is subject to the document binding preferences that have been
;  *    specified by the user. For example, if a creator is specified but
;  *    the user has asked for files with the given
;  *    creator/type/extension combination to open in an application with
;  *    a different creator, the kind string will be loaded from the
;  *    user's preferred application.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inType:
;  *      The OSType file type for which you want a kind string. Specify
;  *      kLSUnknownType if no file type information is available.
;  *    
;  *    inCreator:
;  *      The OSType creator for which you want a kind string. Specify
;  *      kLSUnknownCreator if no creator information is available.
;  *    
;  *    inExtension:
;  *      The extension for which you want a kind string. Specify NULL if
;  *      no extension information is available.
;  *    
;  *    outKindString:
;  *      A CFStringRef* to receive the copied kind string object. This
;  *      CFStringRef must be released eventually.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSCopyKindStringForTypeInfo" 
   ((inType :OSType)
    (inCreator :OSType)
    (inExtension (:pointer :__CFString))        ;  can be NULL 
    (outKindString (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  LSCopyKindStringForMIMEType()
;  *  
;  *  Summary:
;  *    Get the kind string for the specified MIME type.
;  *  
;  *  Discussion:
;  *    Returns the localized kind string describing the specified MIME
;  *    type.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inMIMEType:
;  *      The string specifying the MIME type.
;  *    
;  *    outKindString:
;  *      A CFStringRef* to receive the copied kind string object. This
;  *      CFStringRef must be released eventually.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSCopyKindStringForMIMEType" 
   ((inMIMEType (:pointer :__CFString))
    (outKindString (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  LSGetApplicationForItem()
;  *  
;  *  Summary:
;  *    Return the application used to open an item.
;  *  
;  *  Discussion:
;  *    Consults the binding tables to return the application that would
;  *    be used to open inItemRef if it were double-clicked in the
;  *    Finder. This application will be the user-specified override if
;  *    appropriate or the default otherwise. If no application is known
;  *    to LaunchServices suitable for opening this item,
;  *    kLSApplicationNotFoundErr will be returned.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inItemRef:
;  *      The FSRef of the item for which the application is requested.
;  *    
;  *    inRoleMask:
;  *      Whether to return the editor or viewer for inItemRef. If you
;  *      don't care which, use kLSRolesAll.
;  *    
;  *    outAppRef:
;  *      Filled in with the FSRef of the application if not NULL.
;  *    
;  *    outAppURL:
;  *      Filled in with the CFURLRef of the application if not NULL.
;  *      THIS FUNCTION, DESPITE ITS NAME, RETAINS THE URL REFERENCE ON
;  *      BEHALF OF THE CALLER. THE CALLER MUST EVENTUALLY RELEASE THE
;  *      RETURNED URL REFERENCE.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSGetApplicationForItem" 
   ((inItemRef (:pointer :FSRef))
    (inRoleMask :UInt32)
    (outAppRef (:pointer :FSRef))               ;  can be NULL 
    (outAppURL (:pointer :CFURLRef))            ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LSGetApplicationForInfo()
;  *  
;  *  Summary:
;  *    Return the application used to open items with particular data.
;  *  
;  *  Discussion:
;  *    Consults the binding tables to return the application that would
;  *    be used to open items with type, creator, and/or extension as
;  *    provided if they were double-clicked in the Finder. This
;  *    application will be the default for items like this if one has
;  *    been set. If no application is known to LaunchServices suitable
;  *    for opening such items, kLSApplicationNotFoundErr will be
;  *    returned. Not all three input parameters can be NULL at the same
;  *    time nor can both output parameters be NULL at the same time.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inType:
;  *      The file type to consider. Can be kLSUnknownType.
;  *    
;  *    inCreator:
;  *      The file creator to consider. Can be kLSUnknownCreator.
;  *    
;  *    inExtension:
;  *      The file name extension to consider. Can be NULL.
;  *    
;  *    inRoleMask:
;  *      Whether to return the editor or viewer for inItemRef. If you
;  *      don't care which, use kLSRolesAll.
;  *    
;  *    outAppRef:
;  *      Filled in with the FSRef of the application if not NULL.
;  *    
;  *    outAppURL:
;  *      Filled in with the CFURLRef of the application if not NULL.
;  *      THIS FUNCTION, DESPITE ITS NAME, RETAINS THE URL REFERENCE ON
;  *      BEHALF OF THE CALLER. THE CALLER MUST EVENTUALLY RELEASE THE
;  *      RETURNED URL REFERENCE.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSGetApplicationForInfo" 
   ((inType :OSType)
    (inCreator :OSType)
    (inExtension (:pointer :__CFString))        ;  can be NULL 
    (inRoleMask :UInt32)
    (outAppRef (:pointer :FSRef))               ;  can be NULL 
    (outAppURL (:pointer :CFURLRef))            ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LSCopyApplicationForMIMEType()
;  *  
;  *  Summary:
;  *    Return the application used to handle data with the specified
;  *    MIME type.
;  *  
;  *  Discussion:
;  *    The returned application URL will be the user's preferred handler
;  *    for the MIME type if one has been set. If no user preferred
;  *    application has been set, Launch Services will select a default
;  *    handler for the MIME type. If no application is known to handle
;  *    the MIME type, kLSApplicationNotFoundErr will be returned.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inMIMEType:
;  *      The string specifying the MIME type.
;  *    
;  *    inRoleMask:
;  *      A role mask that the chosen application must satisfy. Use
;  *      kLSRolesAll if the role is not important.
;  *    
;  *    outAppURL:
;  *      Receives the copied CFURLRef, which must be released by the
;  *      caller.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSCopyApplicationForMIMEType" 
   ((inMIMEType (:pointer :__CFString))
    (inRoleMask :UInt32)
    (outAppURL (:pointer :CFURLRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  LSGetApplicationForURL()
;  *  
;  *  Summary:
;  *    Return the application used to open an item.
;  *  
;  *  Discussion:
;  *    Consults the binding tables to return the application that would
;  *    be used to open inURL if it were double-clicked in the Finder.
;  *    This application will be the user-specified override if
;  *    appropriate or the default otherwise. If no application is known
;  *    to LaunchServices suitable for opening this item,
;  *    kLSApplicationNotFoundErr will be returned.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inURL:
;  *      The CFURLRef of the item for which the application is requested.
;  *    
;  *    inRoleMask:
;  *      Whether to return the editor or viewer for inItemRef. If you
;  *      don't care which, use kLSRolesAll.
;  *    
;  *    outAppRef:
;  *      Filled in with the FSRef of the application if not NULL.
;  *    
;  *    outAppURL:
;  *      Filled in with the CFURLRef of the application if not NULL.
;  *      THIS FUNCTION, DESPITE ITS NAME, RETAINS THE URL REFERENCE ON
;  *      BEHALF OF THE CALLER. THE CALLER MUST EVENTUALLY RELEASE THE
;  *      RETURNED URL REFERENCE.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSGetApplicationForURL" 
   ((inURL (:pointer :__CFURL))
    (inRoleMask :UInt32)
    (outAppRef (:pointer :FSRef))               ;  can be NULL 
    (outAppURL (:pointer :CFURLRef))            ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LSFindApplicationForInfo()
;  *  
;  *  Summary:
;  *    Locate a specific application.
;  *  
;  *  Discussion:
;  *    Returns the application with the corresponding input information.
;  *    The registry of applications is consulted first in order of
;  *    bundleID, then creator, then name. All comparisons are case
;  *    insensitive and 'ties' are decided first by version, then by
;  *    native vs. Classic.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inCreator:
;  *      The file creator to consider. Can be kLSUnknownCreator.
;  *    
;  *    inBundleID:
;  *      The bundle ID to consider. Can be NULL.
;  *    
;  *    inName:
;  *      The name to consider. Can be NULL. Must include any extensions
;  *      that are part of the file system name, e.g. '.app'.
;  *    
;  *    outAppRef:
;  *      Filled in with the FSRef of the application if not NULL.
;  *    
;  *    outAppURL:
;  *      Filled in with the CFURLRef of the application if not NULL.
;  *      THIS FUNCTION, DESPITE ITS NAME, RETAINS THE URL REFERENCE ON
;  *      BEHALF OF THE CALLER. THE CALLER MUST EVENTUALLY RELEASE THE
;  *      RETURNED URL REFERENCE.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSFindApplicationForInfo" 
   ((inCreator :OSType)
    (inBundleID (:pointer :__CFString))         ;  can be NULL 
    (inName (:pointer :__CFString))             ;  can be NULL 
    (outAppRef (:pointer :FSRef))               ;  can be NULL 
    (outAppURL (:pointer :CFURLRef))            ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LSCanRefAcceptItem()
;  *  
;  *  Summary:
;  *    Determine whether an item can accept another item.
;  *  
;  *  Discussion:
;  *    Returns in outAcceptsItem whether inTargetRef can accept
;  *    inItemFSRef as in a drag and drop operation. If inRoleMask is
;  *    other than kLSRolesAll then make sure inTargetRef claims to
;  *    fulfill the requested role.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inItemFSRef:
;  *      FSRef of the item about which acceptance is requested.
;  *    
;  *    inTargetRef:
;  *      FSRef of the potential target.
;  *    
;  *    inRoleMask:
;  *      The role(s) the target must claim in order to consider
;  *      acceptance.
;  *    
;  *    inFlags:
;  *      Use kLSAcceptDefault.
;  *    
;  *    outAcceptsItem:
;  *      Filled in with result. Must not be NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSCanRefAcceptItem" 
   ((inItemFSRef (:pointer :FSRef))
    (inTargetRef (:pointer :FSRef))
    (inRoleMask :UInt32)
    (inFlags :UInt32)
    (outAcceptsItem (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LSCanURLAcceptURL()
;  *  
;  *  Summary:
;  *    Determine whether an item can accept another item.
;  *  
;  *  Discussion:
;  *    Returns in outAcceptsItem whether inTargetURL can accept
;  *    inItemURL as in a drag and drop operation. If inRoleMask is other
;  *    than kLSRolesAll then make sure inTargetRef claims to fulfill the
;  *    requested role.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inItemURL:
;  *      CFURLRef of the item about which acceptance is requested.
;  *    
;  *    inTargetURL:
;  *      CFURLRef of the potential target.
;  *    
;  *    inRoleMask:
;  *      The role(s) the target must claim in order to consider
;  *      acceptance.
;  *    
;  *    inFlags:
;  *      Use kLSAcceptDefault.
;  *    
;  *    outAcceptsItem:
;  *      Filled in with result. Must not be NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSCanURLAcceptURL" 
   ((inItemURL (:pointer :__CFURL))
    (inTargetURL (:pointer :__CFURL))
    (inRoleMask :UInt32)
    (inFlags :UInt32)
    (outAcceptsItem (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LSRegisterURL()
;  *  
;  *  Discussion:
;  *    If the specified URL refers to an application or other bundle
;  *    claiming to handle documents or URLs, add the bundle's document
;  *    and URL claims to the Launch Services database.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    inURL:
;  *      The CFURLRef of the item (a directory or file) to be registered.
;  *    
;  *    inUpdate:
;  *      When false, LSRegisterURL does not register the item if it has
;  *      already been registered and the current modification date of
;  *      the item has not changed from when it was last registered. When
;  *      true, the item's registered info is updated, even if the
;  *      modification has not changed.
;  *  
;  *  Result:
;  *    An OSStatus value: noErr - Success kLSNoRegistrationInfoErr - The
;  *    item does not contain info requiring registration kLSDataErr -
;  *    The item's property list info is malformed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSRegisterURL" 
   ((inURL (:pointer :__CFURL))
    (inUpdate :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  LSRegisterFSRef()
;  *  
;  *  Discussion:
;  *    If the specified FSRef refers to an application or other bundle
;  *    claiming to handle documents or URLs, add the bundle's document
;  *    and URL claims to the Launch Services database.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    inRef:
;  *      The FSRef of the item to be registered.
;  *    
;  *    inUpdate:
;  *      When false, LSRegisterFSRef does not register the item if it
;  *      has already been registered and the current modification date
;  *      of the item has not changed from when it was last registered.
;  *      When true, the item's registered info is updated, even if the
;  *      modification has not changed.
;  *  
;  *  Result:
;  *    An OSStatus value: noErr - Success kLSNoRegistrationInfoErr - The
;  *    item does not contain info requiring registration kLSDataErr -
;  *    The item's property list info is malformed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSRegisterFSRef" 
   ((inRef (:pointer :FSRef))
    (inUpdate :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  LSCopyApplicationURLsForURL()
;  *  
;  *  Discussion:
;  *    Returns an array of URLs to applications that offer the requested
;  *    role(s) for the input item.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    inURL:
;  *      The CFURLRef of the item for which all suitable applications
;  *      are desired. If the URL is a file URL, it is treated as a
;  *      document, and applications are selected based on the document's
;  *      type information. Otherwise, applications are selected based on
;  *      the URL's scheme.
;  *    
;  *    inRoleMask:
;  *      The role(s) which must intersect with the role provided by an
;  *      application for the specified item in order for the application
;  *      to be included in the result. Pass kLSRolesAll if any role is
;  *      acceptable.
;  *  
;  *  Result:
;  *    An array of CFURLRefs, one for each application which can open
;  *    inURL with at least one of the roles in inRoleMask, or NULL if no
;  *    applications can open the item. When an array is returned, you
;  *    must eventually release it.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSCopyApplicationURLsForURL" 
   ((inURL (:pointer :__CFURL))
    (inRoleMask :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFArray)
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __LSINFO__ */


(provide-interface "LSInfo")