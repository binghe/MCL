(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Folders.h"
; at Sunday July 2,2006 7:23:27 pm.
; 
;      File:       CarbonCore/Folders.h
;  
;      Contains:   Folder Manager Interfaces.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1995-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __FOLDERS__
; #define __FOLDERS__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __MIXEDMODE__
#| #|
#include <CarbonCoreMixedMode.h>
#endif
|#
 |#
; #ifndef __FILES__
#| #|
#include <CarbonCoreFiles.h>
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

(defconstant $kOnSystemDisk -32768)             ;  previously was 0x8000 but that is an unsigned value whereas vRefNum is signed

(defconstant $kOnAppropriateDisk -32767)        ;  Generally, the same as kOnSystemDisk, but it's clearer that this isn't always the 'boot' disk.
;  Folder Domains - Carbon only.  The constants above can continue to be used, but the folder/volume returned will
;  be from one of the domains below.

(defconstant $kSystemDomain -32766)             ;  Read-only system hierarchy.

(defconstant $kLocalDomain -32765)              ;  All users of a single machine have access to these resources.

(defconstant $kNetworkDomain -32764)            ;  All users configured to use a common network server has access to these resources.

(defconstant $kUserDomain -32763)               ;  Read/write. Resources that are private to the user.
;  Domain referring to the currently configured Classic System Folder

(defconstant $kClassicDomain -32762)
; 
;    The ID of the last domain in the above list, used by the Folder Manager to determine if a given 
;    parameter should be treated as a domain or a volume...
; 

(defconstant $kLastDomainConstant -32762)

(defconstant $kCreateFolder $true)
(defconstant $kDontCreateFolder $false)

(defconstant $kSystemFolderType :|macs|)        ;  the system folder 

(defconstant $kDesktopFolderType :|desk|)       ;  the desktop folder; objects in this folder show on the desk top. 

(defconstant $kSystemDesktopFolderType :|sdsk|) ;  the desktop folder at the root of the hard drive, never the redirected user desktop folder 

(defconstant $kTrashFolderType :|trsh|)         ;  the trash folder; objects in this folder show up in the trash 

(defconstant $kSystemTrashFolderType :|strs|)   ;  the trash folder at the root of the drive, never the redirected user trash folder 

(defconstant $kWhereToEmptyTrashFolderType :|empt|);  the "empty trash" folder; Finder starts empty from here down 

(defconstant $kPrintMonitorDocsFolderType :|prnt|);  Print Monitor documents 

(defconstant $kStartupFolderType :|strt|)       ;  Finder objects (applications, documents, DAs, aliases, to...) to open at startup go here 

(defconstant $kShutdownFolderType :|shdf|)      ;  Finder objects (applications, documents, DAs, aliases, to...) to open at shutdown go here 

(defconstant $kAppleMenuFolderType :|amnu|)     ;  Finder objects to put into the Apple menu go here 

(defconstant $kControlPanelFolderType :|ctrl|)  ;  Control Panels go here (may contain INITs) 

(defconstant $kSystemControlPanelFolderType :|sctl|);  System control panels folder - never the redirected one, always "Control Panels" inside the System Folder 

(defconstant $kExtensionFolderType :|extn|)     ;  System extensions go here 

(defconstant $kFontsFolderType :|font|)         ;  Fonts go here 

(defconstant $kPreferencesFolderType :|pref|)   ;  preferences for applications go here 

(defconstant $kSystemPreferencesFolderType :|sprf|);  System-type Preferences go here - this is always the system's preferences folder, never a logged in user's 

(defconstant $kTemporaryFolderType :|temp|)     ;  temporary files go here (deleted periodically, but don't rely on it.) 

; 
;  *  FindFolder()
;  *  
;  *  Summary:
;  *    Obtains location information for system-related directories.
;  *  
;  *  Discussion:
;  *    For the folder type on the particular volume (specified,
;  *    respectively, in the folderType and vRefNum parameters), the
;  *    FindFolder function returns the directory's volume reference
;  *    number in the foundVRefNum parameter and its directory ID in the
;  *    foundDirID parameter.
;  *    
;  *    The specified folder used for a given volume might be located on
;  *    a different volume in future versions of system software;
;  *    therefore, do not assume the volume that you specify in vRefNum
;  *    and the volume returned in foundVRefNum will be the same.
;  *     
;  *    Specify a volume reference number (or the constant kOnSystemDisk
;  *    for the startup disk) or one of the domain constants ( on Mac OS
;  *    X ) in the vRefNum parameter.
;  *    
;  *    Specify a four-character folder type--or the constant that
;  *    represents it--in the folderType parameter.
;  *    
;  *    Use the constant kCreateFolder in the createFolder parameter to
;  *    tell FindFolder to create a directory if it does not already
;  *    exist; otherwise, use the constant kDontCreateFolder. Directories
;  *    inside the System Folder are created only if the System Folder
;  *    directory exists. The FindFolder function will not create a
;  *    System Folder directory even if you specify the kCreateFolder
;  *    constant in the createFolder parameter.
;  *    
;  *    The FindFolder function returns a nonzero result code if the
;  *    folder isn't found, and it can also return other file system
;  *    errors reported by the File Manager or Memory Manager.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      Pass the volume reference number of the volume on which you
;  *      want to locate a directory, or a constant specifying a disk or
;  *      domain.   The constants which you can use in this parameter are
;  *      described in "Disk and Domain Constants".
;  *      Note that, on Mac OS X, passing a volume reference number in
;  *      this parameter does not make sense for most of the folder type
;  *      selectors which you can specify in the folderType parameter. On
;  *      Mac OS X, folders are "domain-oriented"; because there may be
;  *      more than one domain on any given physical volume, asking for
;  *      these folders on a per-volume basis yields undefined results.
;  *      For example, if you were to request the Fonts folder
;  *      (represented by the selector kFontsFolderType ) on volume -100,
;  *      are you requesting the folder /System/Library/Fonts,
;  *      /Library/Fonts, or ~/Fonts? On Mac OS X you should pass a disk
;  *      or domain constant in this parameter.
;  *    
;  *    folderType:
;  *      A four-character folder type, or a constant that represents the
;  *      type, for the directory you want to find.
;  *    
;  *    createFolder:
;  *      Pass the constant kCreateFolder in this parameter to create a
;  *      directory if it does not already exist; otherwise, pass the
;  *      constant kDontCreateFolder.
;  *    
;  *    foundVRefNum:
;  *      The volume reference number, returned by FindFolder , for the
;  *      volume containing the directory you specify in the folderType
;  *      parameter.
;  *    
;  *    foundDirID:
;  *      The directory ID number, returned by FindFolder , for the
;  *      directory you specify in the folderType parameter.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FindFolder" 
   ((vRefNum :SInt16)
    (folderType :OSType)
    (createFolder :Boolean)
    (foundVRefNum (:pointer :short))
    (foundDirID (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FindFolderExtended()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    Use FindFolder instead wherever possible.
;  *  
;  *  Summary:
;  *    Obtains location information for system-related directories.
;  *  
;  *  Discussion:
;  *    For the folder type on the particular volume (specified,
;  *    respectively, in the folderType and vRefNum parameters), the
;  *    FindFolder function returns the directory's volume reference
;  *    number in the foundVRefNum parameter and its directory ID in the
;  *    foundDirID parameter.
;  *    
;  *    The specified folder used for a given volume might be located on
;  *    a different volume in future versions of system software;
;  *    therefore, do not assume the volume that you specify in vRefNum
;  *    and the volume returned in foundVRefNum will be the same.
;  *     
;  *    Specify a volume reference number (or the constant kOnSystemDisk
;  *    for the startup disk) or one of the domain constants ( on Mac OS
;  *    X ) in the vRefNum parameter.
;  *    
;  *    Specify a four-character folder type--or the constant that
;  *    represents it--in the folderType parameter.
;  *    
;  *    Use the constant kCreateFolder in the createFolder parameter to
;  *    tell FindFolder to create a directory if it does not already
;  *    exist; otherwise, use the constant kDontCreateFolder. Directories
;  *    inside the System Folder are created only if the System Folder
;  *    directory exists. The FindFolder function will not create a
;  *    System Folder directory even if you specify the kCreateFolder
;  *    constant in the createFolder parameter.
;  *    
;  *    The FindFolder function returns a nonzero result code if the
;  *    folder isn't found, and it can also return other file system
;  *    errors reported by the File Manager or Memory Manager.
;  *     FindFolderExtended() is equivalent to FindFolder() on Mac OS X.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      The volume reference number (or the constant kOnSystemDisk for
;  *      the startup disk) or one of the domain constants ( like
;  *      kUserDomain ) of the volume or domain in which you want to
;  *      locate a directory.
;  *    
;  *    folderType:
;  *      A four-character folder type, or a constant that represents the
;  *      type, for the directory you want to find.
;  *    
;  *    createFolder:
;  *      Pass the constant kCreateFolder in this parameter to create a
;  *      directory if it does not already exist; otherwise, pass the
;  *      constant kDontCreateFolder.
;  *    
;  *    foundVRefNum:
;  *      The volume reference number, returned by FindFolder , for the
;  *      volume containing the directory you specify in the folderType
;  *      parameter.
;  *    
;  *    flags:
;  *      The flags passed in which control extended behaviour
;  *    
;  *    data:
;  *      Unique data which is interpreted differently depending on the
;  *      passed in flags.
;  *    
;  *    foundDirID:
;  *      The directory ID number, returned by FindFolder , for the
;  *      directory you specify in the folderType parameter.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FindFolderExtended" 
   ((vRefNum :SInt16)
    (folderType :OSType)
    (createFolder :Boolean)
    (flags :UInt32)
    (data :pointer)
    (foundVRefNum (:pointer :short))
    (foundDirID (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  ReleaseFolder()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    This call is not needed on Mac OS X and later.
;  *  
;  *  Summary:
;  *    On Mac OS 9.x and earlier, release any hold the system may have
;  *    on a given folder on a volume so that the volume may be unmounted.
;  *  
;  *  Discussion:
;  *    On Mac OS 9.x, the system sometimes has files open on volumes
;  *    which need to be closed in order for the volume to be
;  *    successfully unmounted.  This call releases any hold the Folder
;  *    Manager may have for the given volume.
;  *    <br> This call is unnecessary on Mac OS X and later.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      The vRefNum to release.
;  *    
;  *    folderType:
;  *      The folder type to release.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FoldersLib 1.0 and later
;  

(deftrap-inline "_ReleaseFolder" 
   ((vRefNum :SInt16)
    (folderType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  FSFindFolder()
;  *  
;  *  Summary:
;  *    FSFindFolder returns an FSRef for certain system-related
;  *    directories.
;  *  
;  *  Discussion:
;  *    For the folder type on the particular volume (specified,
;  *    respectively, in the folderType and vRefNum parameters), the
;  *    FindFolder function returns the FSRef of that directory. 
;  *     
;  *    The specified folder used for a given volume might be located on
;  *    a different volume in future versions of system software;
;  *    therefore, do not assume the volume that you specify in vRefNum
;  *    and the volume returned in the FSRef will be the same.
;  *    
;  *    Specify a volume reference number (or the constant kOnSystemDisk
;  *    for the startup disk) or one of the domain constants ( on Mac OS
;  *    X ) in the vRefNum parameter.
;  *    
;  *    Specify a four-character folder type--or the constant that
;  *    represents it--in the folderType parameter.
;  *    
;  *    Use the constant kCreateFolder in the createFolder parameter to
;  *    tell FindFolder to create a directory if it does not already
;  *    exist; otherwise, use the constant kDontCreateFolder. Directories
;  *    inside the System Folder are created only if the System Folder
;  *    directory exists. The FindFolder function will not create a
;  *    System Folder directory even if you specify the kCreateFolder
;  *    constant in the createFolder parameter.
;  *    
;  *    The FindFolder function returns a nonzero result code if the
;  *    folder isn't found, and it can also return other file system
;  *    errors reported by the File Manager or Memory Manager.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      The volume reference number (or the constant kOnSystemDisk for
;  *      the startup disk) or one of the domain constants ( like
;  *      kUserDomain ) of the volume or domain in which you want to
;  *      locate a directory.
;  *    
;  *    folderType:
;  *      A four-character folder type, or a constant that represents the
;  *      type, for the directory you want to find.
;  *    
;  *    createFolder:
;  *      Pass the constant kCreateFolder in this parameter to create a
;  *      directory if it does not already exist; otherwise, pass the
;  *      constant kDontCreateFolder.
;  *    
;  *    foundRef:
;  *      The FSRef for the directory you specify on the volume or domain
;  *      and folderType given.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_FSFindFolder" 
   ((vRefNum :SInt16)
    (folderType :OSType)
    (createFolder :Boolean)
    (foundRef (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSFindFolderExtended()   *** DEPRECATED ***
;  *  
;  *  Summary:
;  *    FSFindFolderExtended returns an FSRef for certain system-related
;  *    directories.
;  *  
;  *  Discussion:
;  *    For the folder type on the particular volume (specified,
;  *    respectively, in the folderType and vRefNum parameters), the
;  *    FindFolder function returns the FSRef of that directory. 
;  *     
;  *    The specified folder used for a given volume might be located on
;  *    a different volume in future versions of system software;
;  *    therefore, do not assume the volume that you specify in vRefNum
;  *    and the volume returned in the FSRef will be the same.
;  *    
;  *    Specify a volume reference number (or the constant kOnSystemDisk
;  *    for the startup disk) or one of the domain constants ( on Mac OS
;  *    X ) in the vRefNum parameter.
;  *    
;  *    Specify a four-character folder type--or the constant that
;  *    represents it--in the folderType parameter.
;  *    
;  *    Use the constant kCreateFolder in the createFolder parameter to
;  *    tell FindFolder to create a directory if it does not already
;  *    exist; otherwise, use the constant kDontCreateFolder. Directories
;  *    inside the System Folder are created only if the System Folder
;  *    directory exists. The FindFolder function will not create a
;  *    System Folder directory even if you specify the kCreateFolder
;  *    constant in the createFolder parameter.
;  *    
;  *    The FindFolder function returns a nonzero result code if the
;  *    folder isn't found, and it can also return other file system
;  *    errors reported by the File Manager or Memory Manager.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      The volume reference number (or the constant kOnSystemDisk for
;  *      the startup disk) or one of the domain constants ( like
;  *      kUserDomain ) of the volume or domain in which you want to
;  *      locate a directory.
;  *    
;  *    folderType:
;  *      A four-character folder type, or a constant that represents the
;  *      type, for the directory you want to find.
;  *    
;  *    createFolder:
;  *      Pass the constant kCreateFolder in this parameter to create a
;  *      directory if it does not already exist; otherwise, pass the
;  *      constant kDontCreateFolder.
;  *    
;  *    flags:
;  *      The flags passed in which control extended behaviour
;  *    
;  *    data:
;  *      Unique data which is interpreted differently depending on the
;  *      passed in flags.
;  *    
;  *    foundRef:
;  *      The FSRef for the directory you specify on the volume or domain
;  *      and folderType given.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_FSFindFolderExtended" 
   ((vRefNum :SInt16)
    (folderType :OSType)
    (createFolder :Boolean)
    (flags :UInt32)
    (data :pointer)
    (foundRef (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; ****************************************
;  Extensible Folder Manager declarations 
; ****************************************
; **************************
;  Folder Manager constants 
; **************************

(defconstant $kExtensionDisabledFolderType :|extD|)
(defconstant $kControlPanelDisabledFolderType :|ctrD|)
(defconstant $kSystemExtensionDisabledFolderType :|macD|)
(defconstant $kStartupItemsDisabledFolderType :|strD|)
(defconstant $kShutdownItemsDisabledFolderType :|shdD|)
(defconstant $kApplicationsFolderType :|apps|)
(defconstant $kDocumentsFolderType :|docs|)
;  new constants 

(defconstant $kVolumeRootFolderType :|root|)    ;  root folder of a volume 

(defconstant $kChewableItemsFolderType :|flnt|) ;  items deleted at boot 

(defconstant $kApplicationSupportFolderType :|asup|);  third-party items and folders 
; 'Ätex' 

(defconstant $kTextEncodingsFolderType #xC4746578);  encoding tables 

(defconstant $kStationeryFolderType :|odst|)    ;  stationery 

(defconstant $kOpenDocFolderType :|odod|)       ;  OpenDoc root 

(defconstant $kOpenDocShellPlugInsFolderType :|odsp|);  OpenDoc Shell Plug-Ins in OpenDoc folder 

(defconstant $kEditorsFolderType :|oded|)       ;  OpenDoc editors in MacOS Folder 
; 'Äodf' 

(defconstant $kOpenDocEditorsFolderType #xC46F6466);  OpenDoc subfolder of Editors folder 

(defconstant $kOpenDocLibrariesFolderType :|odlb|);  OpenDoc libraries folder 
; 'Äedi' 

(defconstant $kGenEditorsFolderType #xC4656469) ;  CKH general editors folder at root level of Sys folder 
; 'Ählp' 

(defconstant $kHelpFolderType #xC4686C70)       ;  CKH help folder currently at root of system folder 
; 'Änet' 

(defconstant $kInternetPlugInFolderType #xC46E6574);  CKH internet plug ins for browsers and stuff 
; 'Ämod' 

(defconstant $kModemScriptsFolderType #xC46D6F64);  CKH modem scripts, get 'em OUT of the Extensions folder 

(defconstant $kPrinterDescriptionFolderType :|ppdf|);  CKH new folder at root of System folder for printer descs. 
; 'Äprd' 

(defconstant $kPrinterDriverFolderType #xC4707264);  CKH new folder at root of System folder for printer drivers 
; 'Äscr' 

(defconstant $kScriptingAdditionsFolderType #xC4736372);  CKH at root of system folder 
; 'Älib' 

(defconstant $kSharedLibrariesFolderType #xC46C6962);  CKH for general shared libs. 

(defconstant $kVoicesFolderType :|fvoc|)        ;  CKH macintalk can live here 

(defconstant $kControlStripModulesFolderType :|sdev|);  CKH for control strip modules 

(defconstant $kAssistantsFolderType #x617374C4) ; 'astÄ'
;  SJF for Assistants (MacOS Setup Assistant, etc) 

(defconstant $kUtilitiesFolderType #x757469C4)  ; 'utiÄ'
;  SJF for Utilities folder 

(defconstant $kAppleExtrasFolderType #x616578C4); 'aexÄ'
;  SJF for Apple Extras folder 

(defconstant $kContextualMenuItemsFolderType :|cmnu|);  SJF for Contextual Menu items 

(defconstant $kMacOSReadMesFolderType #x6D6F72C4); 'morÄ'
;  SJF for MacOS ReadMes folder 

(defconstant $kALMModulesFolderType :|walk|)    ;  EAS for Location Manager Module files except type 'thng' (within kExtensionFolderType) 

(defconstant $kALMPreferencesFolderType :|trip|);  EAS for Location Manager Preferences (within kPreferencesFolderType; contains kALMLocationsFolderType) 

(defconstant $kALMLocationsFolderType :|fall|)  ;  EAS for Location Manager Locations (within kALMPreferencesFolderType) 

(defconstant $kColorSyncProfilesFolderType :|prof|);  for ColorSyncª Profiles 

(defconstant $kThemesFolderType :|thme|)        ;  for Theme data files 

(defconstant $kFavoritesFolderType :|favs|)     ;  Favorties folder for Navigation Services 

(defconstant $kInternetFolderType #x696E74C4)   ; 'intÄ'
;  Internet folder (root level of startup volume) 

(defconstant $kAppearanceFolderType :|appr|)    ;  Appearance folder (root of system folder) 

(defconstant $kSoundSetsFolderType :|snds|)     ;  Sound Sets folder (in Appearance folder) 

(defconstant $kDesktopPicturesFolderType #x647470C4); 'dtpÄ'
;  Desktop Pictures folder (in Appearance folder) 

(defconstant $kInternetSearchSitesFolderType :|issf|);  Internet Search Sites folder 

(defconstant $kFindSupportFolderType :|fnds|)   ;  Find support folder 

(defconstant $kFindByContentFolderType :|fbcf|) ;  Find by content folder 

(defconstant $kInstallerLogsFolderType :|ilgf|) ;  Installer Logs folder 

(defconstant $kScriptsFolderType #x736372C4)    ; 'scrÄ'
;  Scripts folder 

(defconstant $kFolderActionsFolderType :|fasf|) ;  Folder Actions Scripts folder 

(defconstant $kLauncherItemsFolderType :|laun|) ;  Launcher Items folder 

(defconstant $kRecentApplicationsFolderType :|rapp|);  Recent Applications folder 

(defconstant $kRecentDocumentsFolderType :|rdoc|);  Recent Documents folder 

(defconstant $kRecentServersFolderType :|rsvr|) ;  Recent Servers folder 

(defconstant $kSpeakableItemsFolderType :|spki|);  Speakable Items folder 

(defconstant $kKeychainFolderType :|kchn|)      ;  Keychain folder 

(defconstant $kQuickTimeExtensionsFolderType :|qtex|);  QuickTime Extensions Folder (in Extensions folder) 

(defconstant $kDisplayExtensionsFolderType :|dspl|);  Display Extensions Folder (in Extensions folder) 

(defconstant $kMultiprocessingFolderType :|mpxf|);  Multiprocessing Folder (in Extensions folder) 

(defconstant $kPrintingPlugInsFolderType :|pplg|);  Printing Plug-Ins Folder (in Extensions folder) 

;  New Folder Types to accommodate the Mac OS X Folder Manager 
;  These folder types are not applicable on Mac OS 9.          

(defconstant $kDomainTopLevelFolderType :|dtop|);  The top-level of a Folder domain, e.g. "/System"

(defconstant $kDomainLibraryFolderType :|dlib|) ;  the Library subfolder of a particular domain

(defconstant $kColorSyncFolderType :|sync|)     ;  Contains ColorSync-related folders

(defconstant $kColorSyncCMMFolderType :|ccmm|)  ;  ColorSync CMMs

(defconstant $kColorSyncScriptingFolderType :|cscr|);  ColorSync Scripting support

(defconstant $kPrintersFolderType :|impr|)      ;  Contains Printing-related folders

(defconstant $kSpeechFolderType :|spch|)        ;  Contains Speech-related folders

(defconstant $kCarbonLibraryFolderType :|carb|) ;  Contains Carbon-specific file

(defconstant $kDocumentationFolderType :|info|) ;  Contains Documentation files (not user documents)

(defconstant $kDeveloperDocsFolderType :|ddoc|) ;  Contains Developer Documentation files and folders

(defconstant $kDeveloperHelpFolderType :|devh|) ;  Contains Developer Help related files

(defconstant $kISSDownloadsFolderType :|issd|)  ;  Contains Internet Search Sites downloaded from the Internet

(defconstant $kUserSpecificTmpFolderType :|utmp|);  Contains temporary items created on behalf of the current user

(defconstant $kCachedDataFolderType :|cach|)    ;  Contains various cache files for different clients

(defconstant $kTemporaryItemsInCacheDataFolderType :|vtmp|)
(defconstant $kMagicTemporaryItemsFolderType :|mtmp|)
(defconstant $kFrameworksFolderType :|fram|)    ;  Contains MacOS X Framework folders     

(defconstant $kPrivateFrameworksFolderType :|pfrm|);  Contains MacOS X Private Framework folders     

(defconstant $kClassicDesktopFolderType :|sdsk|);  MacOS 9 compatible desktop folder - same as 
;  kSystemDesktopFolderType but with a more appropriate
;  name for Mac OS X code.

(defconstant $kDeveloperFolderType :|devf|)     ;  Contains MacOS X Developer Resources

(defconstant $kSystemSoundsFolderType :|ssnd|)  ;  Contains Mac OS X System Sound Files

(defconstant $kComponentsFolderType :|cmpd|)    ;  Contains Mac OS X components

(defconstant $kQuickTimeComponentsFolderType :|wcmp|);  Contains QuickTime components for Mac OS X

(defconstant $kCoreServicesFolderType :|csrv|)  ;  Refers to the "CoreServices" folder on Mac OS X

(defconstant $kPictureDocumentsFolderType :|pdoc|);  Refers to the "Pictures" folder in a users home directory

(defconstant $kMovieDocumentsFolderType :|mdoc|);  Refers to the "Movies" folder in a users home directory
; 'µdoc' 

(defconstant $kMusicDocumentsFolderType #xB5646F63);  Refers to the "Music" folder in a users home directory

(defconstant $kInternetSitesFolderType :|site|) ;  Refers to the "Sites" folder in a users home directory

(defconstant $kPublicFolderType :|pubb|)        ;  Refers to the "Public" folder in a users home directory

(defconstant $kAudioSupportFolderType :|adio|)  ;  Refers to the Audio support folder for Mac OS X

(defconstant $kAudioSoundsFolderType :|asnd|)   ;  Refers to the Sounds subfolder of Audio Support

(defconstant $kAudioSoundBanksFolderType :|bank|);  Refers to the Banks subfolder of the Sounds Folder

(defconstant $kAudioAlertSoundsFolderType :|alrt|);  Refers to the Alert Sounds subfolder of the Sound Folder

(defconstant $kAudioPlugInsFolderType :|aplg|)  ;  Refers to the Plug-ins subfolder of the Audio Folder   

(defconstant $kAudioComponentsFolderType :|acmp|);  Refers to the Components subfolder of the Audio Plug-ins Folder    

(defconstant $kKernelExtensionsFolderType :|kext|);  Refers to the Kernel Extensions Folder on Mac OS X

(defconstant $kDirectoryServicesFolderType :|dsrv|);  Refers to the Directory Services folder on Mac OS X

(defconstant $kDirectoryServicesPlugInsFolderType :|dplg|);  Refers to the Directory Services Plug-Ins folder on Mac OS X 

(defconstant $kInstallerReceiptsFolderType :|rcpt|);  Refers to the "Receipts" folder in Mac OS X

(defconstant $kFileSystemSupportFolderType :|fsys|);  Refers to the [domain]/Library/Filesystems folder in Mac OS X

(defconstant $kAppleShareSupportFolderType :|shar|);  Refers to the [domain]/Library/Filesystems/AppleShare folder in Mac OS X

(defconstant $kAppleShareAuthenticationFolderType :|auth|);  Refers to the [domain]/Library/Filesystems/AppleShare/Authentication folder in Mac OS X

(defconstant $kMIDIDriversFolderType :|midi|)   ;  Refers to the MIDI Drivers folder on Mac OS X

(defconstant $kKeyboardLayoutsFolderType :|klay|);  Refers to the [domain]/Library/KeyboardLayouts folder in Mac OS X

(defconstant $kIndexFilesFolderType :|indx|)    ;  Refers to the [domain]/Library/Indexes folder in Mac OS X

(defconstant $kFindByContentIndexesFolderType :|fbcx|);  Refers to the [domain]/Library/Indexes/FindByContent folder in Mac OS X

(defconstant $kManagedItemsFolderType :|mang|)  ;  Refers to the Managed Items folder for Mac OS X 

(defconstant $kBootTimeStartupItemsFolderType :|empz|);  Refers to the "StartupItems" folder of Mac OS X 

; 'Äloc' 

(defconstant $kLocalesFolderType #xC46C6F63)    ;  PKE for Locales folder 

(defconstant $kFindByContentPluginsFolderType :|fbcp|);  Find By Content Plug-ins 


(defconstant $kUsersFolderType :|usrs|)         ;  "Users" folder, contains one folder for each user. 

(defconstant $kCurrentUserFolderType :|cusr|)   ;  The folder for the currently logged on user. 

(defconstant $kCurrentUserRemoteFolderLocation :|rusf|);  The remote folder for the currently logged on user 

(defconstant $kCurrentUserRemoteFolderType :|rusr|);  The remote folder location for the currently logged on user 

(defconstant $kSharedUserDataFolderType :|sdat|);  A Shared "Documents" folder, readable & writeable by all users 

(defconstant $kVolumeSettingsFolderType :|vsfd|);  Volume specific user information goes here 


(defconstant $kClassicPreferencesFolderType :|cprf|);  "Classic" folder in ~/Library/ for redirected preference files. 


(defconstant $kAppleshareAutomountServerAliasesFolderType #x737276C4); 'srvÄ'
;  Appleshare puts volumes to automount inside this folder. 
; 'Œpps' 

(defconstant $kPreMacOS91ApplicationsFolderType #x8C707073);  The "Applications" folder, pre Mac OS 9.1 
; '”lgf' 

(defconstant $kPreMacOS91InstallerLogsFolderType #x946C6766);  The "Installer Logs" folder, pre Mac OS 9.1 
; 'ŒstÄ' 

(defconstant $kPreMacOS91AssistantsFolderType #x8C7374C4);  The "Assistants" folder, pre Mac OS 9.1 
; 'ŸtiÄ' 

(defconstant $kPreMacOS91UtilitiesFolderType #x9F7469C4);  The "Utilities" folder, pre Mac OS 9.1 
; 'ŒexÄ' 

(defconstant $kPreMacOS91AppleExtrasFolderType #x8C6578C4);  The "Apple Extras" folder, pre Mac OS 9.1 
; 'µorÄ' 

(defconstant $kPreMacOS91MacOSReadMesFolderType #xB56F72C4);  The "Mac OS ReadMes" folder, pre Mac OS 9.1 
; '”ntÄ' 

(defconstant $kPreMacOS91InternetFolderType #x946E74C4);  The "Internet" folder, pre Mac OS 9.1 
; '§rvÄ' 

(defconstant $kPreMacOS91AutomountedServersFolderType #xA77276C4);  The "Servers" folder, pre Mac OS 9.1 
; '¿dst' 
;  The "Stationery" folder, pre Mac OS 9.1 

(defconstant $kPreMacOS91StationeryFolderType #xBF647374)
;  FolderDescFlags values 

(defconstant $kCreateFolderAtBoot 2)
(defconstant $kCreateFolderAtBootBit 1)
(defconstant $kFolderCreatedInvisible 4)
(defconstant $kFolderCreatedInvisibleBit 2)
(defconstant $kFolderCreatedNameLocked 8)
(defconstant $kFolderCreatedNameLockedBit 3)
(defconstant $kFolderCreatedAdminPrivs 16)
(defconstant $kFolderCreatedAdminPrivsBit 4)

(defconstant $kFolderInUserFolder 32)
(defconstant $kFolderInUserFolderBit 5)
(defconstant $kFolderTrackedByAlias 64)
(defconstant $kFolderTrackedByAliasBit 6)
(defconstant $kFolderInRemoteUserFolderIfAvailable #x80)
(defconstant $kFolderInRemoteUserFolderIfAvailableBit 7)
(defconstant $kFolderNeverMatchedInIdentifyFolder #x100)
(defconstant $kFolderNeverMatchedInIdentifyFolderBit 8)
(defconstant $kFolderMustStayOnSameVolume #x200)
(defconstant $kFolderMustStayOnSameVolumeBit 9)
(defconstant $kFolderManagerFolderInMacOS9FolderIfMacOSXIsInstalledMask #x400)
(defconstant $kFolderManagerFolderInMacOS9FolderIfMacOSXIsInstalledBit 10)
(defconstant $kFolderInLocalOrRemoteUserFolder #xA0)

(def-mactype :FolderDescFlags (find-mactype ':UInt32))
;  FolderClass values 

(defconstant $kRelativeFolder :|relf|)
(defconstant $kRedirectedRelativeFolder :|rrel|)
(defconstant $kSpecialFolder :|spcf|)

(def-mactype :FolderClass (find-mactype ':OSType))
;  special folder locations 

(defconstant $kBlessedFolder :|blsf|)
(defconstant $kRootFolder :|rotf|)

(defconstant $kCurrentUserFolderLocation :|cusf|);     the magic 'Current User' folder location


(defconstant $kDictionariesFolderType :|dict|)  ;  Dictionaries folder 

(defconstant $kLogsFolderType :|logs|)          ;  Logs folder 

(defconstant $kDeveloperApplicationsFolderType :|dapp|);  Contains Developer Applications

(defconstant $kPreferencePanesFolderType :|ppan|);  PreferencePanes folder, in .../Library/ 


(def-mactype :FolderType (find-mactype ':OSType))

(def-mactype :FolderLocation (find-mactype ':OSType))
(defrecord FolderDesc
   (descSize :signed-long)
   (foldType :OSType)
   (flags :UInt32)
   (foldClass :OSType)
   (foldLocation :OSType)
   (badgeSignature :OSType)
   (badgeType :OSType)
   (reserved :UInt32)
   (name (:string 63))                          ;  Str63 on MacOS
)

;type name? (%define-record :FolderDesc (find-record-descriptor ':FolderDesc))

(def-mactype :FolderDescPtr (find-mactype '(:pointer :FolderDesc)))

(def-mactype :RoutingFlags (find-mactype ':UInt32))
(defrecord FolderRouting
   (descSize :signed-long)
   (fileType :OSType)
   (routeFromFolder :OSType)
   (routeToFolder :OSType)
   (flags :UInt32)
)

;type name? (%define-record :FolderRouting (find-record-descriptor ':FolderRouting))

(def-mactype :FolderRoutingPtr (find-mactype '(:pointer :FolderRouting)))
;  routing constants 
;   These are bits in the .flags field of the FindFolderUserRedirectionGlobals struct
;     Set this bit to 1 in the .flags field of a FindFolderUserRedirectionGlobals
;     structure if the userName in the struct should be used as the current
;     "User" name

(defconstant $kFindFolderRedirectionFlagUseDistinctUserFoldersBit 0);     Set this bit to 1 and the currentUserFolderVRefNum and currentUserFolderDirID
;     fields of the user record will get used instead of finding the user folder
;     with the userName field.

(defconstant $kFindFolderRedirectionFlagUseGivenVRefAndDirIDAsUserFolderBit 1);     Set this bit to 1 and the remoteUserFolderVRefNum and remoteUserFolderDirID
;     fields of the user record will get used instead of finding the user folder
;     with the userName field.

(defconstant $kFindFolderRedirectionFlagsUseGivenVRefNumAndDirIDAsRemoteUserFolderBit 2)
(defrecord FindFolderUserRedirectionGlobals
   (version :UInt32)
   (flags :UInt32)
   (userName (:string 31))
   (userNameScript :SInt16)
   (currentUserFolderVRefNum :SInt16)
   (currentUserFolderDirID :signed-long)
   (remoteUserFolderVRefNum :SInt16)
   (remoteUserFolderDirID :signed-long)
)

;type name? (%define-record :FindFolderUserRedirectionGlobals (find-record-descriptor ':FindFolderUserRedirectionGlobals))

(def-mactype :FindFolderUserRedirectionGlobalsPtr (find-mactype '(:pointer :FindFolderUserRedirectionGlobals)))

(defconstant $kFolderManagerUserRedirectionGlobalsCurrentVersion 1)
; 
;     These are passed into FindFolderExtended(), FindFolderInternalExtended(), and
;     FindFolderNewInstallerEntryExtended() in the flags field. 
; 
;     These constants only work on Mac OS 9.x.  On Mac OS X, they are ignored.

(defconstant $kFindFolderExtendedFlagsDoNotFollowAliasesBit 0)
(defconstant $kFindFolderExtendedFlagsDoNotUseUserFolderBit 1)
(defconstant $kFindFolderExtendedFlagsUseOtherUserRecord #x1000000)

(def-mactype :FolderManagerNotificationProcPtr (find-mactype ':pointer)); (OSType message , void * arg , void * userRefCon)

(def-mactype :FolderManagerNotificationUPP (find-mactype '(:pointer :OpaqueFolderManagerNotificationProcPtr)))
; 
;  *  NewFolderManagerNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewFolderManagerNotificationUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueFolderManagerNotificationProcPtr)
() )
; 
;  *  DisposeFolderManagerNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeFolderManagerNotificationUPP" 
   ((userUPP (:pointer :OpaqueFolderManagerNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeFolderManagerNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeFolderManagerNotificationUPP" 
   ((message :OSType)
    (arg :pointer)
    (userRefCon :pointer)
    (userUPP (:pointer :OpaqueFolderManagerNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )

(defconstant $kFolderManagerNotificationMessageUserLogIn :|log+|);     Sent by system & third party software after a user logs in.  arg should point to a valid FindFolderUserRedirectionGlobals structure or nil for the owner

(defconstant $kFolderManagerNotificationMessagePreUserLogIn :|logj|);     Sent by system & third party software before a user logs in.  arg should point to a valid FindFolderUserRedirectionGlobals structure or nil for the owner

(defconstant $kFolderManagerNotificationMessageUserLogOut :|log-|);     Sent by system & third party software before a user logs out.  arg should point to a valid FindFolderUserRedirectionGlobals structure or nil for the owner

(defconstant $kFolderManagerNotificationMessagePostUserLogOut :|logp|);     Sent by system & third party software after a user logs out.  arg should point to a valid FindFolderUserRedirectionGlobals structure or nil for the owner

(defconstant $kFolderManagerNotificationDiscardCachedData :|dche|);     Sent by system & third party software when the entire Folder Manager cache should be flushed

(defconstant $kFolderManagerNotificationMessageLoginStartup :|stup|);     Sent by 'Login' application the first time it starts up after each boot

;   These get used in the options parameter of FolderManagerRegisterNotificationProc()

(defconstant $kDoNotRemoveWhenCurrentApplicationQuitsBit 0)
(defconstant $kDoNotRemoveWheCurrentApplicationQuitsBit 0);     Going away soon, use kDoNotRemoveWheCurrentApplicationQuitsBit

;   These get used in the options parameter of FolderManagerCallNotificationProcs()

(defconstant $kStopIfAnyNotificationProcReturnsErrorBit 31)
; 
;  *  AddFolderDescriptor()
;  *  
;  *  Summary:
;  *    Copies the supplied information into a new folder descriptor
;  *    entry in the system folder list. @discussion The
;  *    AddFolderDescriptor function copies the supplied information into
;  *    a new descriptor entry in the system folder list. You need to
;  *    provide folder descriptors for each folder you wish the Folder
;  *    Manager to be able to find via the function FindFolder. For
;  *    example, a child folder located in a parent folder needs to have
;  *    a descriptor created both for it and its parent folder, so that
;  *    the child can be found. This function is supported under Mac OS 8
;  *    and later. 
;  *    On Mac OS X, folder descriptors added in one process are not
;  *    visible in other processes.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    foldType:
;  *      Pass a constant identifying the type of the folder you wish the
;  *      Folder Manager to be able to find. See ÒFolder Type ConstantsÓ.
;  *    
;  *    flags:
;  *      Set these flags to indicate whether a folder is created during
;  *      startup, if the folder name is locked, and if the folder is
;  *      created invisible; see ÒFolder Descriptor FlagsÓ.
;  *    
;  *    foldClass:
;  *      Pass the class of the folder which you wish the Folder Manager
;  *      to be able to find. The folder class determines how the
;  *      foldLocation parameter is interpreted. See "Folder Descriptor
;  *      Classes" for a discussion of relative and special folder
;  *      classes.
;  *    
;  *    foldLocation:
;  *      For a relative folder, specify the folder type of the parent
;  *      folder of the target. For a special folder, specify the
;  *      location of the folder; see ÒFolder Descriptor LocationsÓ.
;  *    
;  *    badgeSignature:
;  *      Reserved. Pass 0.
;  *    
;  *    badgeType:
;  *      Reserved. Pass 0.
;  *    
;  *    name:
;  *      A string specifying the name of the desired folder. For
;  *      relative folders, this is the exact name of the desired folder.
;  *      For special folders, the actual target folder may have a
;  *      different name than the name specified in the folder
;  *      descriptor. For example, the System Folder is often given a
;  *      different name, but it can still be located with FindFolder.
;  *    
;  *    replaceFlag:
;  *      Pass a Boolean value indicating whether you wish to replace a
;  *      folder descriptor that already exists for the specified folder
;  *      type. If true , it replaces the folder descriptor for the
;  *      specified folder type. If false , it does not replace the
;  *      folder descriptor for the specified folder type.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FoldersLib 1.0 and later
;  

(deftrap-inline "_AddFolderDescriptor" 
   ((foldType :OSType)
    (flags :UInt32)
    (foldClass :OSType)
    (foldLocation :OSType)
    (badgeSignature :OSType)
    (badgeType :OSType)
    (name (:pointer :UInt8))
    (replaceFlag :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetFolderDescriptor()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    GetFolderDescriptor is deprecated on Mac OS X.
;  *  
;  *  Summary:
;  *    Obtains the folder descriptor information for the specified
;  *    folder type from the global descriptor list.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    foldType:
;  *      Pass a constant identifying the type of the folder for which
;  *      you wish to get descriptor information. See "Folder Type
;  *      Constants".
;  *    
;  *    descSize:
;  *      Pass the size (in bytes) of the folder descriptor structure for
;  *      which a pointer is passed in the foldDesc parameter. This value
;  *      is needed in order to determine the version of the structure
;  *      being used.
;  *    
;  *    foldDesc:
;  *      Pass a pointer to a folder descriptor structure. On return, the
;  *      folder descriptor structure contains information from the
;  *      global descriptor list for the specified folder type.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FoldersLib 1.0 and later
;  

(deftrap-inline "_GetFolderDescriptor" 
   ((foldType :OSType)
    (descSize :signed-long)
    (foldDesc (:pointer :FolderDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  GetFolderTypes()
;  *  
;  *  Summary:
;  *    Obtains the folder types contained in the global descriptor list.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    requestedTypeCount:
;  *      Pass the number of FolderType values that can fit in the buffer
;  *      pointed to by the theTypes parameter; see ÒFolder Type
;  *      ConstantsÓ.
;  *    
;  *    totalTypeCount:
;  *      Pass a pointer to an unsigned 32-bit integer value. On return,
;  *      the value is set to the total number of FolderType values in
;  *      the list. The totalTypeCount parameter may produce a value that
;  *      is larger or smaller than that of the requestedTypeCount
;  *      parameter. If totalTypeCount is equal to or smaller than the
;  *      value passed in for requestedTypeCount and the value produced
;  *      by the theTypes parameter is non-null, then all folder types
;  *      were returned to the caller.
;  *    
;  *    theTypes:
;  *      Pass a pointer to an array of FolderType values; see "Folder
;  *      Type Constants". On return, the array contains the folder types
;  *      for the installed descriptors. You can step through the array
;  *      and call GetFolderDescriptor for each folder type. Pass null if
;  *      you only want to know the number of descriptors installed in
;  *      the systemÕs global list, rather than the actual folder types
;  *      of those descriptors.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FoldersLib 1.0 and later
;  

(deftrap-inline "_GetFolderTypes" 
   ((requestedTypeCount :UInt32)
    (totalTypeCount (:pointer :UInt32))
    (theTypes (:pointer :FOLDERTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveFolderDescriptor()
;  *  
;  *  Summary:
;  *    Deletes the specified folder descriptor entry from the system
;  *    folder list.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    foldType:
;  *      Pass a constant identifying the type of the folder for which
;  *      you wish to remove a descriptor.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FoldersLib 1.0 and later
;  

(deftrap-inline "_RemoveFolderDescriptor" 
   ((foldType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetFolderName()
;  *  
;  *  Summary:
;  *    Obtains the name of the specified folder.
;  *  
;  *  Discussion:
;  *    The GetFolderName function obtains the name of the folder in the
;  *    folder descriptor, not the name of the folder on the disk. The
;  *    names may differ for a few special folders such as the System
;  *    Folder. For relative folders, however, the actual name is always
;  *    returned. You typically do not need to call this function.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      Pass the volume reference number (or the constant kOnSystemDisk
;  *      for the startup disk) of the volume containing the folder for
;  *      which you wish the name to be identified.
;  *    
;  *    foldType:
;  *      Pass a constant identifying the type of the folder for which
;  *      you wish the name to be identified. See "Folder Type Constants".
;  *    
;  *    foundVRefNum:
;  *      On return, a pointer to the volume reference number for the
;  *      volume containing the folder specified in the foldType
;  *      parameter.
;  *    
;  *    name:
;  *      On return, a string containing the title of the folder
;  *      specified in the foldType and vRefNum parameters.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FoldersLib 1.0 and later
;  

(deftrap-inline "_GetFolderName" 
   ((vRefNum :SInt16)
    (foldType :OSType)
    (foundVRefNum (:pointer :short))
    (name (:pointer :Str63))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AddFolderRouting()
;  *  
;  *  Summary:
;  *    Adds a folder routing structure to the global routing list.
;  *  
;  *  Discussion:
;  *    Your application can use the AddFolderRouting function to specify
;  *    how the Finder routes a given file type. 
;  *    Folder Routing is deprecated on Mac OS X at this time.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    fileType:
;  *      Pass the OSType of the file to be routed.
;  *    
;  *    routeFromFolder:
;  *      Pass the folder type of the "from" folder see "Folder Type
;  *      Constants" for descriptions of possible values. An item dropped
;  *      on the folder specified in this parameter will be routed to the
;  *      folder specified in the routeToFolder parameter.
;  *    
;  *    routeToFolder:
;  *      The folder type of the "to" folder see "Folder Type Constants"
;  *      for descriptions of possible values.
;  *    
;  *    flags:
;  *      Reserved for future use; pass 0.
;  *    
;  *    replaceFlag:
;  *      Pass a Boolean value indicating whether you wish to replace a
;  *      folder routing that already exists. If true , it replaces the
;  *      folder to which the item is being routed. If false , it leaves
;  *      the folder to which the item is being routed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FoldersLib 1.0 and later
;  

(deftrap-inline "_AddFolderRouting" 
   ((fileType :OSType)
    (routeFromFolder :OSType)
    (routeToFolder :OSType)
    (flags :UInt32)
    (replaceFlag :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveFolderRouting()
;  *  
;  *  Summary:
;  *    Deletes a folder routing structure from the global routing list.
;  *  
;  *  Discussion:
;  *    Both the file type and the folder type specified must match those
;  *    of an existing folder routing structure in the global routing
;  *    list for the RemoveFolderRouting function to succeed.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    fileType:
;  *      Pass the file type value contained in the folder routing
;  *      structure to be removed.
;  *    
;  *    routeFromFolder:
;  *      Pass the folder type of the "from" folder see "Folder Type
;  *      Constants" for descriptions of possible values.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FoldersLib 1.0 and later
;  

(deftrap-inline "_RemoveFolderRouting" 
   ((fileType :OSType)
    (routeFromFolder :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FindFolderRouting()
;  *  
;  *  Summary:
;  *    Finds the destination folder from a matching folder routing
;  *    structure for the specified file.
;  *  
;  *  Discussion:
;  *    Both the file type and the folder type specified must match those
;  *    of a folder routing structure in the global routing list for the
;  *    FindFolderRouting function to succeed.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    fileType:
;  *      Pass the file type specified in the appropriate folder routing
;  *      structure for the file for which you wish to find a destination
;  *      folder.
;  *    
;  *    routeFromFolder:
;  *      Pass the folder type of the "from" folder for which you wish to
;  *      find a "to" folder see "Folder Type Constants" for descriptions
;  *      of possible values. An item dropped on the folder specified in
;  *      this parameter will be routed to the folder specified in the
;  *      routeToFolder parameter.
;  *    
;  *    routeToFolder:
;  *      A pointer to a value of type FolderType. On return, the value
;  *      is set to the folder type of the destination folder.
;  *    
;  *    flags:
;  *      Reserved; pass 0.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FoldersLib 1.0 and later
;  

(deftrap-inline "_FindFolderRouting" 
   ((fileType :OSType)
    (routeFromFolder :OSType)
    (routeToFolder (:pointer :FOLDERTYPE))
    (flags (:pointer :ROUTINGFLAGS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetFolderRoutings()
;  *  
;  *  Summary:
;  *    Obtains folder routing information from the global routing list.
;  *  
;  *  Discussion:
;  *    The folder routing information in the global routing list
;  *    determines how the Finder routes files.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    requestedRoutingCount:
;  *      An unsigned 32-bit value. Pass the number of folder routing
;  *      structures that can fit in the buffer pointed to by the
;  *      theRoutings parameter.
;  *    
;  *    totalRoutingCount:
;  *      A pointer to an unsigned 32-bit value. On return, the value is
;  *      set to the number of folder routing structures in the global
;  *      list. If this value is less than or equal to
;  *      requestedRoutingCount , all folder routing structures were
;  *      returned to the caller.
;  *    
;  *    routingSize:
;  *      Pass the size (in bytes) of the FolderRouting structure.
;  *    
;  *    theRoutings:
;  *      Pass a pointer to an array of FolderRouting structures. On
;  *      return the structure(s) contain the requested routing
;  *      information. You may pass null if you do not wish this
;  *      information.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FoldersLib 1.0 and later
;  

(deftrap-inline "_GetFolderRoutings" 
   ((requestedRoutingCount :UInt32)
    (totalRoutingCount (:pointer :UInt32))
    (routingSize :signed-long)
    (theRoutings (:pointer :FolderRouting))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvalidateFolderDescriptorCache()
;  *  
;  *  Summary:
;  *    Invalidates any prior FindFolder results for the specified folder.
;  *  
;  *  Discussion:
;  *    The InvalidateFolderDescriptorCache function searches to see if
;  *    there is currently a cache of results from FindFolder calls on
;  *    the specified folder. If so, it invalidates the cache from the
;  *    previous calls to the FindFolder function in order to force the
;  *    Folder Manager to reexamine the disk when FindFolder is called
;  *    again on the specified directory ID or volume reference number.
;  *    
;  *    
;  *    You should not normally need to call
;  *    InvalidateFolderDescriptorCache.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      Pass the volume reference number (or the constant kOnSystemDisk
;  *      for the startup disk) of the volume containing the folder for
;  *      which you wish the descriptor cache to be invalidated. Pass 0
;  *      to completely invalidate all folder cache information.
;  *    
;  *    dirID:
;  *      Pass the directory ID number for the folder for which you wish
;  *      the descriptor cache to be invalidated. Pass 0 to invalidate
;  *      the cache for all folders on the specified disk.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FoldersLib 1.0 and later
;  

(deftrap-inline "_InvalidateFolderDescriptorCache" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  IdentifyFolder()
;  *  
;  *  Summary:
;  *    Obtains the folder type for the specified folder.
;  *  
;  *  Discussion:
;  *    The folder type is identified for the folder specified by the
;  *    vRefNum and dirID parameters, if such a folder exists. Note that
;  *    IdentifyFolder may take several seconds to complete. Note also
;  *    that if there are multiple folder descriptors that map to an
;  *    individual folder, IdentifyFolder returns the folder type of only
;  *    the first matching descriptor that it finds.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      Pass the volume reference number (or the constant kOnSystemDisk
;  *      for the startup disk) of the volume containing the folder whose
;  *      type you wish to identify.
;  *    
;  *    dirID:
;  *      Pass the directory ID number for the folder whose type you wish
;  *      to identify.
;  *    
;  *    foldType:
;  *      Pass a pointer to a value of type FolderType. On return, the
;  *      value is set to the folder type of the folder with the
;  *      specified vRefNum and dirID parameters; see "Folder Type
;  *      Constants" for descriptions of possible values.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FoldersLib 1.0 and later
;  

(deftrap-inline "_IdentifyFolder" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
    (foldType (:pointer :FOLDERTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FolderManagerRegisterNotificationProc()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    This function is deprecated on Mac OS X.
;  *  
;  *  Summary:
;  *    Register a function to be called at certain times
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    notificationProc:
;  *    
;  *    refCon:
;  *    
;  *    options:
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FolderManagerRegisterNotificationProc" 
   ((notificationProc (:pointer :OpaqueFolderManagerNotificationProcPtr))
    (refCon :pointer)
    (options :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  FolderManagerUnregisterNotificationProc()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    This function is deprecated on Mac OS X.
;  *  
;  *  Summary:
;  *    Unregister a function to be called at certain times
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    notificationProc:
;  *    
;  *    refCon:
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FolderManagerUnregisterNotificationProc" 
   ((notificationProc (:pointer :OpaqueFolderManagerNotificationProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  FolderManagerRegisterCallNotificationProcs()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    This function is deprecated on Mac OS X.
;  *  
;  *  Summary:
;  *    Call the registered Folder Manager notification procs.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    message:
;  *    
;  *    arg:
;  *    
;  *    options:
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FolderManagerRegisterCallNotificationProcs" 
   ((message :OSType)
    (arg :pointer)
    (options :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSStatus
() )
; *****************************
;  MultiUser (At Ease) globals 
; *****************************
; 
;    This structure has been through some evolution since the early days of At Ease 1.0.  The structure
;    has been expanded (and developers should assume that it will continue this way into the future).  Older
;    fields have been obsoleted as the features have changed in newer versions of the code.
; 
;  Some fields in here are really only valid for the network version of Macintosh Manager
(defrecord MultiUserGestalt
                                                ;     Version 1 fields.
   (giVersion :SInt16)                          ;  structure version: 0 = invalid, 6 = OS 9
   (giReserved0 :SInt16)                        ;  [OBSOLETE with v3] giIsActive: if true then At Ease is currently running
   (giReserved1 :SInt16)                        ;  [OBSOLETE] if true then auto create alias
   (giReserved2 :SInt16)                        ;  [OBSOLETE with v6]  if true then request floppy on new saves
   (giReserved3 :SInt16)                        ;  [OBSOLETE] if true then hypercard stacks are shown on Applications panel
   (giReserved4 :FSSpec)                        ;  [OBSOLETE with v6] location of At Ease Items folder
                                                ;     Version 2 fields.
   (giDocsVRefNum :SInt16)                      ;  vrefnum of user's documents location (only valid if not on floppy)
   (giDocsDirID :signed-long)                   ;  directory id of user's documents folder (only valid if not on floppy)
   (giForceSaves :SInt16)                       ;  true if user is forced to save to their documents folder
   (giForceOpens :SInt16)                       ;  true if user is forced to open from their documents folder
   (giSetupName (:string 31))                   ;  name of current setup
   (giUserName (:string 31))                    ;  name of current user
   (giFrontAppName (:string 31))                ;  name of the frontmost application
   (giReserved5 :SInt16)                        ;  [OBSOLETE with v6] true if user has Go To Finder menu item
   (giIsOn :SInt16)                             ;  true if Multiple Users/Macintosh Manager is on right now
                                                ;     Version 3 fields.
                                                ;   There were no additional fields for version 3.x
                                                ;     Version 4 fields.
   (giUserLoggedInType :SInt16)                 ;  0 = normal user, 1 = workgroup admin, 2 = global admin
   (giUserEncryptPwd (:array :character 16))    ;  encrypted user password (our digest form)
   (giUserEnvironment :SInt16)                  ;  0 = panels, 1 = normal Finder, 2 = limited/restricted Finder
   (giReserved6 :signed-long)                   ;  [OBSOLETE]
   (giReserved7 :signed-long)                   ;  [OBSOLETE]
   (giDisableScrnShots :Boolean)                ;  true if screen shots are not allowed
                                                ;     Version 5 fields.
   (giSupportsAsyncFSCalls :Boolean)            ;  Finder uses this to tell if our patches support async trap patches
   (giPrefsVRefNum :SInt16)                     ;  vrefnum of preferences
   (giPrefsDirID :signed-long)                  ;  dirID of the At Ease Items folder on preferences volume
   (giUserLogInTime :UInt32)                    ;  time in seconds we've been logged in (0 or 1 mean not logged in)
   (giUsingPrintQuotas :Boolean)                ;  true if logged in user is using printer quotas
   (giUsingDiskQuotas :Boolean)                 ;  true if logged in user has disk quotas active
                                                ;  Version 6 fields - As of Mac OS 9's "Multiple Users 1.0"
   (giInSystemAccess :Boolean)                  ;  true if system is in System Access (i.e., owner logged in)
   (giUserFolderEnabled :Boolean)               ;  true if FindFolder is redirecting folders (uses giUserName for user)
   (giReserved8 :SInt16)
   (giReserved9 :signed-long)
   (giInLoginScreen :Boolean)                   ;  true if no user has logged in (including owner)
                                                ;  May have more fields added in future, so never check for sizeof(GestaltRec)
)

;type name? (%define-record :MultiUserGestalt (find-record-descriptor ':MultiUserGestalt))

(def-mactype :MultiUserGestaltPtr (find-mactype '(:pointer :MultiUserGestalt)))

(def-mactype :MultiUserGestaltHandle (find-mactype '(:handle :MultiUserGestalt)))
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __FOLDERS__ */


(provide-interface "Folders")