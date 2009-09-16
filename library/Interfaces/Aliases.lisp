(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Aliases.h"
; at Sunday July 2,2006 7:23:20 pm.
; 
;      File:       CarbonCore/Aliases.h
;  
;      Contains:   Alias Manager Interfaces.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1989-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __ALIASES__
; #define __ALIASES__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
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

(def-mactype :FSAliasInfoBitmap (find-mactype ':UInt32))

(defconstant $kFSAliasInfoNone 0)               ;  no valid info

(defconstant $kFSAliasInfoVolumeCreateDate 1)   ;  volume creation date is valid

(defconstant $kFSAliasInfoTargetCreateDate 2)   ;  target creation date is valid

(defconstant $kFSAliasInfoFinderInfo 4)         ;  file type and creator are valid

(defconstant $kFSAliasInfoIsDirectory 8)        ;  isDirectory boolean is valid

(defconstant $kFSAliasInfoIDs 16)               ;  parentDirID and nodeID are valid

(defconstant $kFSAliasInfoFSInfo 32)            ;  filesystemID and signature are valid

(defconstant $kFSAliasInfoVolumeFlags 64)       ;  volumeIsBootVolume, volumeIsAutomounted, volumeIsEjectable and volumeHasPersistentFileIDs are valid


(defconstant $rAliasType :|alis|)               ;  Aliases are stored as resources of this type 

;  define alias resolution action rules mask 

(defconstant $kARMMountVol 1)                   ;  mount the volume automatically 

(defconstant $kARMNoUI 2)                       ;  no user interface allowed during resolution 

(defconstant $kARMMultVols 8)                   ;  search on multiple volumes 

(defconstant $kARMSearch #x100)                 ;  search quickly 

(defconstant $kARMSearchMore #x200)             ;  search further 

(defconstant $kARMSearchRelFirst #x400)         ;  search target on a relative path first 

(defconstant $kARMTryFileIDFirst #x800)         ;  search by file id before path 

;  define alias record information types 

(defconstant $asiZoneName -3)                   ;  get zone name 

(defconstant $asiServerName -2)                 ;  get server name 

(defconstant $asiVolumeName -1)                 ;  get volume name 

(defconstant $asiAliasName 0)                   ;  get aliased file/folder/volume name 

(defconstant $asiParentName 1)                  ;  get parent folder name 

;  ResolveAliasFileWithMountFlags options 

(defconstant $kResolveAliasFileNoUI 1)          ;  no user interaction during resolution 

(defconstant $kResolveAliasTryFileIDFirst 2)    ;  search by file id before path 

;  define the alias record that will be the blackbox for the caller 
(defrecord (AliasRecord :handle)
   (userType :OSType)                           ;  appl stored type like creator type 
   (aliasSize :UInt16)                          ;  alias record size in bytes, for appl usage 
)

;type name? (%define-record :AliasRecord (find-record-descriptor ':AliasRecord))

(def-mactype :AliasPtr (find-mactype '(:pointer :AliasRecord)))

(def-mactype :AliasHandle (find-mactype '(:handle :AliasRecord)))
;  info block to pass to FSCopyAliasInfo 
(defrecord FSAliasInfo
   (volumeCreateDate :UTCDateTime)
   (targetCreateDate :UTCDateTime)
   (fileType :OSType)
   (fileCreator :OSType)
   (parentDirID :UInt32)
   (nodeID :UInt32)
   (filesystemID :UInt16)
   (signature :UInt16)
   (volumeIsBootVolume :Boolean)
   (volumeIsAutomounted :Boolean)
   (volumeIsEjectable :Boolean)
   (volumeHasPersistentFileIDs :Boolean)
   (isDirectory :Boolean)
)

;type name? (%define-record :FSAliasInfo (find-record-descriptor ':FSAliasInfo))

(def-mactype :FSAliasInfoPtr (find-mactype '(:pointer :FSAliasInfo)))
;  alias record information type 

(def-mactype :AliasInfoType (find-mactype ':SInt16))
; 
;  *  NewAlias()
;  *  
;  *  Summary:
;  *    create a new alias between fromFile and target, returns alias
;  *    record handle
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewAlias" 
   ((fromFile (:pointer :FSSpec))               ;  can be NULL 
    (target (:pointer :FSSpec))
    (alias (:pointer :ALIASHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewAliasMinimal()
;  *  
;  *  Summary:
;  *    create a minimal new alias for a target and return alias record
;  *    handle
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewAliasMinimal" 
   ((target (:pointer :FSSpec))
    (alias (:pointer :ALIASHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewAliasMinimalFromFullPath()
;  *  
;  *  Summary:
;  *    create a minimal new alias from a target fullpath (optional zone
;  *    and server name) and return alias record handle
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewAliasMinimalFromFullPath" 
   ((fullPathLength :SInt16)
    (fullPath :pointer)
    (zoneName (:pointer :UInt8))
    (serverName (:pointer :UInt8))
    (alias (:pointer :ALIASHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ResolveAlias()
;  *  
;  *  Summary:
;  *    given an alias handle and fromFile, resolve the alias, update the
;  *    alias record and return aliased filename and wasChanged flag.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ResolveAlias" 
   ((fromFile (:pointer :FSSpec))               ;  can be NULL 
    (alias (:Handle :AliasRecord))
    (target (:pointer :FSSpec))
    (wasChanged (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetAliasInfo()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    Use FSCopyAliasInfo instead.
;  *  
;  *  Summary:
;  *    This call does not work on all aliases. Given an alias handle and
;  *    an index specifying requested alias information type, return the
;  *    information from alias record as a string. An empty string is
;  *    returned when the index is greater than the number of levels
;  *    between the target and root.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetAliasInfo" 
   ((alias (:Handle :AliasRecord))
    (index :SInt16)
    (theString (:pointer :Str63))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  IsAliasFile()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  

(deftrap-inline "_IsAliasFile" 
   ((fileFSSpec (:pointer :FSSpec))
    (aliasFileFlag (:pointer :Boolean))
    (folderFlag (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ResolveAliasWithMountFlags()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  

(deftrap-inline "_ResolveAliasWithMountFlags" 
   ((fromFile (:pointer :FSSpec))               ;  can be NULL 
    (alias (:Handle :AliasRecord))
    (target (:pointer :FSSpec))
    (wasChanged (:pointer :Boolean))
    (mountFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ResolveAliasFile()
;  *  
;  *  Summary:
;  *    Given a file spec, return target file spec if input file spec is
;  *    an alias. It resolves the entire alias chain or one step of the
;  *    chain.  It returns info about whether the target is a folder or
;  *    file; and whether the input file spec was an alias or not.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ResolveAliasFile" 
   ((theSpec (:pointer :FSSpec))
    (resolveAliasChains :Boolean)
    (targetIsFolder (:pointer :Boolean))
    (wasAliased (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ResolveAliasFileWithMountFlags()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  

(deftrap-inline "_ResolveAliasFileWithMountFlags" 
   ((theSpec (:pointer :FSSpec))
    (resolveAliasChains :Boolean)
    (targetIsFolder (:pointer :Boolean))
    (wasAliased (:pointer :Boolean))
    (mountFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FollowFinderAlias()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  

(deftrap-inline "_FollowFinderAlias" 
   ((fromFile (:pointer :FSSpec))               ;  can be NULL 
    (alias (:Handle :AliasRecord))
    (logon :Boolean)
    (target (:pointer :FSSpec))
    (wasChanged (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  
;    Low Level Routines 
; 
; 
;  *  UpdateAlias()
;  *  
;  *  Summary:
;  *    given a fromFile-target pair and an alias handle, update the
;  *    alias record pointed to by alias handle to represent target as
;  *    the new alias.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_UpdateAlias" 
   ((fromFile (:pointer :FSSpec))               ;  can be NULL 
    (target (:pointer :FSSpec))
    (alias (:Handle :AliasRecord))
    (wasChanged (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

(def-mactype :AliasFilterProcPtr (find-mactype ':pointer)); (CInfoPBPtr cpbPtr , Boolean * quitFlag , Ptr myDataPtr)

(def-mactype :AliasFilterUPP (find-mactype '(:pointer :OpaqueAliasFilterProcPtr)))
; 
;  *  NewAliasFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewAliasFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueAliasFilterProcPtr)
() )
; 
;  *  DisposeAliasFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeAliasFilterUPP" 
   ((userUPP (:pointer :OpaqueAliasFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeAliasFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeAliasFilterUPP" 
   ((cpbPtr (:pointer :CInfoPBRec))
    (quitFlag (:pointer :Boolean))
    (myDataPtr :pointer)
    (userUPP (:pointer :OpaqueAliasFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  MatchAlias()
;  *  
;  *  Summary:
;  *    Given an alias handle and fromFile, match the alias and return
;  *    FSSpecs to the aliased file(s) and needsUpdate flag
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MatchAlias" 
   ((fromFile (:pointer :FSSpec))               ;  can be NULL 
    (rulesMask :UInt32)
    (alias (:Handle :AliasRecord))
    (aliasCount (:pointer :short))
    (aliasList (:pointer :FSSpec))
    (needsUpdate (:pointer :Boolean))
    (aliasFilter (:pointer :OpaqueAliasFilterProcPtr))
    (yourDataPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ResolveAliasFileWithMountFlagsNoUI()
;  *  
;  *  Summary:
;  *    variation on ResolveAliasFile that does not prompt user with a
;  *    dialog
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ResolveAliasFileWithMountFlagsNoUI" 
   ((theSpec (:pointer :FSSpec))
    (resolveAliasChains :Boolean)
    (targetIsFolder (:pointer :Boolean))
    (wasAliased (:pointer :Boolean))
    (mountFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  MatchAliasNoUI()
;  *  
;  *  Summary:
;  *    variation on MatchAlias that does not prompt user with a dialog
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_MatchAliasNoUI" 
   ((fromFile (:pointer :FSSpec))               ;  can be NULL 
    (rulesMask :UInt32)
    (alias (:Handle :AliasRecord))
    (aliasCount (:pointer :short))
    (aliasList (:pointer :FSSpec))
    (needsUpdate (:pointer :Boolean))
    (aliasFilter (:pointer :OpaqueAliasFilterProcPtr))
    (yourDataPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSNewAlias()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_FSNewAlias" 
   ((fromFile (:pointer :FSRef))                ;  can be NULL 
    (target (:pointer :FSRef))
    (inAlias (:pointer :ALIASHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSNewAliasMinimal()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_FSNewAliasMinimal" 
   ((target (:pointer :FSRef))
    (inAlias (:pointer :ALIASHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSIsAliasFile()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_FSIsAliasFile" 
   ((fileRef (:pointer :FSRef))
    (aliasFileFlag (:pointer :Boolean))
    (folderFlag (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSResolveAliasWithMountFlags()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_FSResolveAliasWithMountFlags" 
   ((fromFile (:pointer :FSRef))                ;  can be NULL 
    (inAlias (:Handle :AliasRecord))
    (target (:pointer :FSRef))
    (wasChanged (:pointer :Boolean))
    (mountFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSResolveAlias()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_FSResolveAlias" 
   ((fromFile (:pointer :FSRef))                ;  can be NULL 
    (alias (:Handle :AliasRecord))
    (target (:pointer :FSRef))
    (wasChanged (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSResolveAliasFileWithMountFlags()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_FSResolveAliasFileWithMountFlags" 
   ((theRef (:pointer :FSRef))
    (resolveAliasChains :Boolean)
    (targetIsFolder (:pointer :Boolean))
    (wasAliased (:pointer :Boolean))
    (mountFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSResolveAliasFile()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_FSResolveAliasFile" 
   ((theRef (:pointer :FSRef))
    (resolveAliasChains :Boolean)
    (targetIsFolder (:pointer :Boolean))
    (wasAliased (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSFollowFinderAlias()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_FSFollowFinderAlias" 
   ((fromFile (:pointer :FSRef))                ;  can be NULL 
    (alias (:Handle :AliasRecord))
    (logon :Boolean)
    (target (:pointer :FSRef))
    (wasChanged (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSUpdateAlias()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_FSUpdateAlias" 
   ((fromFile (:pointer :FSRef))                ;  can be NULL 
    (target (:pointer :FSRef))
    (alias (:Handle :AliasRecord))
    (wasChanged (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSNewAliasUnicode()
;  *  
;  *  Summary:
;  *    Creates an alias given a ref to the target's parent directory and
;  *    the target's unicode name.  If the target does not exist fnfErr
;  *    will be returned but the alias will still be created.  This
;  *    allows the creation of aliases to targets that do not exist.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    fromFile:
;  *      The starting point for a relative search.
;  *    
;  *    targetParentRef:
;  *      An FSRef to the parent directory of the target.
;  *    
;  *    targetNameLength:
;  *      Number of Unicode characters in the target's name.
;  *    
;  *    targetName:
;  *      A pointer to the Unicode name.
;  *    
;  *    inAlias:
;  *      A Handle to the newly created alias record.
;  *    
;  *    isDirectory:
;  *      On input, if target does not exist, a flag to indicate whether
;  *      or not the target is a directory.  On output, if the target did
;  *      exist, an flag indicating if the target is a directory.  Pass
;  *      NULL in the non-existant case if unsure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSNewAliasUnicode" 
   ((fromFile (:pointer :FSRef))                ;  can be NULL 
    (targetParentRef (:pointer :FSRef))
    (targetNameLength :UInt32)
    (targetName (:pointer :UniChar))
    (inAlias (:pointer :ALIASHANDLE))
    (isDirectory (:pointer :Boolean))           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  FSNewAliasMinimalUnicode()
;  *  
;  *  Summary:
;  *    Creates a minimal alias given a ref to the target's parent
;  *    directory and the target's unicode name.  If the target does not
;  *    exist fnfErr will be returned but the alias will still be created.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    targetParentRef:
;  *      An FSRef to the parent directory of the target.
;  *    
;  *    targetNameLength:
;  *      Number of Unicode characters in the target's name.
;  *    
;  *    targetName:
;  *      A pointer to the Unicode name.
;  *    
;  *    inAlias:
;  *      A Handle to the newly created alias record.
;  *    
;  *    isDirectory:
;  *      On input, if target does not exist, a flag to indicate whether
;  *      or not the
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSNewAliasMinimalUnicode" 
   ((targetParentRef (:pointer :FSRef))
    (targetNameLength :UInt32)
    (targetName (:pointer :UniChar))
    (inAlias (:pointer :ALIASHANDLE))
    (isDirectory (:pointer :Boolean))           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  FSMatchAlias()
;  *  
;  *  Summary:
;  *    Given an alias handle and fromFile, match the alias and return
;  *    FSRefs to the aliased file(s) and needsUpdate flag
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSMatchAlias" 
   ((fromFile (:pointer :FSRef))                ;  can be NULL 
    (rulesMask :UInt32)
    (inAlias (:Handle :AliasRecord))
    (aliasCount (:pointer :short))
    (aliasList (:pointer :FSRef))
    (needsUpdate (:pointer :Boolean))
    (aliasFilter (:pointer :OpaqueAliasFilterProcPtr))
    (yourDataPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  FSMatchAliasNoUI()
;  *  
;  *  Summary:
;  *    variation on FSMatchAlias that does not prompt user with a dialog
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSMatchAliasNoUI" 
   ((fromFile (:pointer :FSRef))                ;  can be NULL 
    (rulesMask :UInt32)
    (inAlias (:Handle :AliasRecord))
    (aliasCount (:pointer :short))
    (aliasList (:pointer :FSRef))
    (needsUpdate (:pointer :Boolean))
    (aliasFilter (:pointer :OpaqueAliasFilterProcPtr))
    (yourDataPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  FSCopyAliasInfo()
;  *  
;  *  Discussion:
;  *    This routine will return the requested information from the
;  *    passed in aliasHandle.  The information is gathered only from the
;  *    alias record so it may not match what is on disk (no disk i/o is
;  *    performed).  The whichInfo paramter is an output parameter that
;  *    signifies which fields in the info record contain valid data.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inAlias:
;  *      A handle to the alias record to get the information from.
;  *    
;  *    targetName:
;  *      The name of the target item.
;  *    
;  *    volumeName:
;  *      The name of the volume the target resides on.
;  *    
;  *    pathString:
;  *      POSIX path to target.
;  *    
;  *    whichInfo:
;  *      An indication of which fields in the info block contain valid
;  *      data.
;  *    
;  *    info:
;  *      Returned information about the alias.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSCopyAliasInfo" 
   ((inAlias (:Handle :AliasRecord))
    (targetName (:pointer :HFSUniStr255))       ;  can be NULL 
    (volumeName (:pointer :HFSUniStr255))       ;  can be NULL 
    (pathString (:pointer :CFSTRINGREF))        ;  can be NULL 
    (whichInfo (:pointer :FSALIASINFOBITMAP))   ;  can be NULL 
    (info (:pointer :FSAliasInfo))              ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __ALIASES__ */


(provide-interface "Aliases")