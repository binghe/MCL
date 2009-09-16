(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Files.h"
; at Sunday July 2,2006 7:23:15 pm.
; 
;      File:       CarbonCore/Files.h
;  
;      Contains:   File Manager (MFS, HFS, and HFS+) Interfaces.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __FILES__
; #define __FILES__
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
; #ifndef __OSUTILS__

(require-interface "CarbonCore/OSUtils")

; #endif

; #ifndef __TEXTCOMMON__
#| #|
#include <CarbonCoreTextCommon.h>
#endif
|#
 |#
; #ifndef __UTCUTILS__
#| #|
#include <CarbonCoreUTCUtils.h>
#endif
|#
 |#
;  Finder constants were moved to Finder.Å 
; #ifndef __FINDER__
#| #|
#include <CarbonCoreFinder.h>
#endif
|#
 |#
; #ifndef __CFURL__

(require-interface "CoreFoundation/CFURL")

; #endif

; #ifndef __CFRUNLOOP__

(require-interface "CoreFoundation/CFRunLoop")

; #endif


(require-interface "sys/types")

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
;  HFSUniStr255 is the Unicode equivalent of Str255 
(defrecord HFSUniStr255
   (length :UInt16)                             ;  number of unicode characters 
   (unicode (:array :UInt16 255))               ;  unicode characters 
)

;type name? (%define-record :HFSUniStr255 (find-record-descriptor ':HFSUniStr255))

(def-mactype :ConstHFSUniStr255Param (find-mactype '(:pointer :HFSUniStr255)))

(defconstant $fsCurPerm 0)                      ;  open access permissions in ioPermssn 

(defconstant $fsRdPerm 1)
(defconstant $fsWrPerm 2)
(defconstant $fsRdWrPerm 3)
(defconstant $fsRdWrShPerm 4)
(defconstant $fsRdDenyPerm 16)                  ;  for use with OpenDeny and OpenRFDeny 

(defconstant $fsWrDenyPerm 32)                  ;  for use with OpenDeny and OpenRFDeny 


(defconstant $fsRtParID 1)
(defconstant $fsRtDirID 2)

(defconstant $fsAtMark 0)                       ;  positioning modes in ioPosMode 

(defconstant $fsFromStart 1)
(defconstant $fsFromLEOF 2)
(defconstant $fsFromMark 3)
;  ioPosMode flags 

(defconstant $pleaseCacheBit 4)                 ;  please cache this request 

(defconstant $pleaseCacheMask 16)
(defconstant $noCacheBit 5)                     ;  please don't cache this request 

(defconstant $noCacheMask 32)
(defconstant $rdVerifyBit 6)                    ;  read verify mode 

(defconstant $rdVerifyMask 64)
(defconstant $rdVerify 64)                      ;  old name of rdVerifyMask 

(defconstant $forceReadBit 6)
(defconstant $forceReadMask 64)
(defconstant $newLineBit 7)                     ;  newline mode 

(defconstant $newLineMask #x80)
(defconstant $newLineCharMask #xFF00)           ;  newline character 

;  CatSearch Search bitmask Constants 

(defconstant $fsSBPartialName 1)
(defconstant $fsSBFullName 2)
(defconstant $fsSBFlAttrib 4)
(defconstant $fsSBFlFndrInfo 8)
(defconstant $fsSBFlLgLen 32)
(defconstant $fsSBFlPyLen 64)
(defconstant $fsSBFlRLgLen #x80)
(defconstant $fsSBFlRPyLen #x100)
(defconstant $fsSBFlCrDat #x200)
(defconstant $fsSBFlMdDat #x400)
(defconstant $fsSBFlBkDat #x800)
(defconstant $fsSBFlXFndrInfo #x1000)
(defconstant $fsSBFlParID #x2000)
(defconstant $fsSBNegate #x4000)
(defconstant $fsSBDrUsrWds 8)
(defconstant $fsSBDrNmFls 16)
(defconstant $fsSBDrCrDat #x200)
(defconstant $fsSBDrMdDat #x400)
(defconstant $fsSBDrBkDat #x800)
(defconstant $fsSBDrFndrInfo #x1000)
(defconstant $fsSBDrParID #x2000)
(defconstant $fsSBNodeID #x8000)
(defconstant $fsSBAttributeModDate #x10000)
(defconstant $fsSBAccessDate #x20000)
(defconstant $fsSBPermissions #x40000)
(defconstant $fsSBSkipPackageContents #x80000)
(defconstant $fsSBSkipHiddenItems #x100000)
(defconstant $fsSBUserID #x200000)
(defconstant $fsSBGroupID #x400000)
;  CatSearch Search bit value Constants 

(defconstant $fsSBPartialNameBit 0)             ; ioFileName points to a substring

(defconstant $fsSBFullNameBit 1)                ; ioFileName points to a match string

(defconstant $fsSBFlAttribBit 2)                ; search includes file attributes

(defconstant $fsSBFlFndrInfoBit 3)              ; search includes finder info

(defconstant $fsSBFlLgLenBit 5)                 ; search includes data logical length

(defconstant $fsSBFlPyLenBit 6)                 ; search includes data physical length

(defconstant $fsSBFlRLgLenBit 7)                ; search includes resource logical length

(defconstant $fsSBFlRPyLenBit 8)                ; search includes resource physical length

(defconstant $fsSBFlCrDatBit 9)                 ; search includes create date

(defconstant $fsSBFlMdDatBit 10)                ; search includes modification date

(defconstant $fsSBFlBkDatBit 11)                ; search includes backup date

(defconstant $fsSBFlXFndrInfoBit 12)            ; search includes extended finder info

(defconstant $fsSBFlParIDBit 13)                ; search includes file's parent ID

(defconstant $fsSBNegateBit 14)                 ; return all non-matches

(defconstant $fsSBDrUsrWdsBit 3)                ; search includes directory finder info

(defconstant $fsSBDrNmFlsBit 4)                 ; search includes directory valence

(defconstant $fsSBDrCrDatBit 9)                 ; directory-named version of fsSBFlCrDatBit

(defconstant $fsSBDrMdDatBit 10)                ; directory-named version of fsSBFlMdDatBit

(defconstant $fsSBDrBkDatBit 11)                ; directory-named version of fsSBFlBkDatBit

(defconstant $fsSBDrFndrInfoBit 12)             ; directory-named version of fsSBFlXFndrInfoBit

(defconstant $fsSBDrParIDBit 13)                ; directory-named version of fsSBFlParIDBit

(defconstant $fsSBNodeIDBit 15)                 ;  search by range of nodeID 

(defconstant $fsSBAttributeModDateBit 16)       ;  search by range of attributeModDate 

(defconstant $fsSBAccessDateBit 17)             ;  search by range of accessDate [CatalogSearch only] 

(defconstant $fsSBPermissionsBit 18)            ;  search by value/mask of permissions [CatalogSearch only] 

(defconstant $fsSBSkipPackageContentsBit 19)    ; do not return items inside of packages

(defconstant $fsSBSkipHiddenItemsBit 20)        ; do not return items with an invisible element in their path

(defconstant $fsSBUserIDBit 21)                 ;  search by userID in permissions field [CatalogSearch only] 

(defconstant $fsSBGroupIDBit 22)                ;  search by groupID in permissions field [CatalogSearch only] 

;  vMAttrib (GetVolParms) bit position constants 

(defconstant $bLimitFCBs 31)
(defconstant $bLocalWList 30)
(defconstant $bNoMiniFndr 29)
(defconstant $bNoVNEdit 28)
(defconstant $bNoLclSync 27)
(defconstant $bTrshOffLine 26)
(defconstant $bNoSwitchTo 25)
(defconstant $bNoDeskItems 20)
(defconstant $bNoBootBlks 19)
(defconstant $bAccessCntl 18)
(defconstant $bNoSysDir 17)
(defconstant $bHasExtFSVol 16)
(defconstant $bHasOpenDeny 15)
(defconstant $bHasCopyFile 14)
(defconstant $bHasMoveRename 13)
(defconstant $bHasDesktopMgr 12)
(defconstant $bHasShortName 11)
(defconstant $bHasFolderLock 10)
(defconstant $bHasPersonalAccessPrivileges 9)
(defconstant $bHasUserGroupList 8)
(defconstant $bHasCatSearch 7)
(defconstant $bHasFileIDs 6)
(defconstant $bHasBTreeMgr 5)
(defconstant $bHasBlankAccessPrivileges 4)
(defconstant $bSupportsAsyncRequests 3)         ;  asynchronous requests to this volume are handled correctly at any time

(defconstant $bSupportsTrashVolumeCache 2)
;  vMAttrib (GetVolParms) bit position constants 

(defconstant $bHasDirectIO 1)
;  vMExtendedAttributes (GetVolParms) bit position constants 

(defconstant $bIsEjectable 0)                   ;  volume is in an ejectable disk drive 

(defconstant $bSupportsHFSPlusAPIs 1)           ;  volume supports HFS Plus APIs directly (not through compatibility layer) 

(defconstant $bSupportsFSCatalogSearch 2)       ;  volume supports FSCatalogSearch 

(defconstant $bSupportsFSExchangeObjects 3)     ;  volume supports FSExchangeObjects 

(defconstant $bSupports2TBFiles 4)              ;  volume supports supports 2 terabyte files 

(defconstant $bSupportsLongNames 5)             ;  volume supports file/directory/volume names longer than 31 characters 

(defconstant $bSupportsMultiScriptNames 6)      ;  volume supports file/directory/volume names with characters from multiple script systems 

(defconstant $bSupportsNamedForks 7)            ;  volume supports forks beyond the data and resource forks 

(defconstant $bSupportsSubtreeIterators 8)      ;  volume supports recursive iterators not at the volume root 

(defconstant $bL2PCanMapFileBlocks 9)           ;  volume supports Lg2Phys SPI correctly 

(defconstant $bParentModDateChanges 10)         ;  Changing a file or folder causes its parent's mod date to change 

(defconstant $bAncestorModDateChanges 11)       ;  Changing a file or folder causes all ancestor mod dates to change 

(defconstant $bSupportsSymbolicLinks 13)        ;  volume supports the creation and use of symbolic links (Mac OS X only) 

(defconstant $bIsAutoMounted 14)                ;  volume was mounted automatically (Mac OS X only) 

(defconstant $bAllowCDiDataHandler 17)          ;  allow QuickTime's CDi data handler to examine this volume 

(defconstant $bSupportsExclusiveLocks 18)       ;  volume supports exclusive opens for writing 

(defconstant $bSupportsJournaling 19)           ;  volume supports journal (journal may not be active) 

(defconstant $bNoVolumeSizes 20)                ;  volume is unable to report volume size or free space 

(defconstant $bIsCaseSensitive 22)              ;  volume is case sensitive 

(defconstant $bIsCasePreserving 23)             ;  volume is case preserving 

(defconstant $bDoNotDisplay 24)                 ;  volume should not be displayed in UI 

;  Desktop Database, ffsGetIconMessage and fsmGetFSIconMessage icon type and size Constants 

(defconstant $kLargeIcon 1)
(defconstant $kLarge4BitIcon 2)
(defconstant $kLarge8BitIcon 3)
(defconstant $kSmallIcon 4)
(defconstant $kSmall4BitIcon 5)
(defconstant $kSmall8BitIcon 6)
(defconstant $kicnsIconFamily #xEF)             ;  Note: The 'icns' icon family record is variable sized. 


(defconstant $kLargeIconSize #x100)
(defconstant $kLarge4BitIconSize #x200)
(defconstant $kLarge8BitIconSize #x400)
(defconstant $kSmallIconSize 64)
(defconstant $kSmall4BitIconSize #x80)
(defconstant $kSmall8BitIconSize #x100)
;  Large Volume Constants 

(defconstant $kWidePosOffsetBit 8)
(defconstant $kUseWidePositioning #x100)
(defconstant $kMaximumBlocksIn4GB #x7FFFFF)
;  Foreign Privilege Model Identifiers 

(defconstant $fsUnixPriv 1)
;  Authentication Constants 

(defconstant $kNoUserAuthentication 1)
(defconstant $kPassword 2)
(defconstant $kEncryptPassword 3)
(defconstant $kTwoWayEncryptPassword 6)
;  mapping codes (ioObjType) for MapName & MapID 

(defconstant $kOwnerID2Name 1)
(defconstant $kGroupID2Name 2)
(defconstant $kOwnerName2ID 3)
(defconstant $kGroupName2ID 4)                  ;  types of oj object to be returned (ioObjType) for _GetUGEntry 

(defconstant $kReturnNextUser 1)
(defconstant $kReturnNextGroup 2)
(defconstant $kReturnNextUG 3)
;  vcbFlags bits 

(defconstant $kVCBFlagsIdleFlushBit 3)          ;  Set if volume should be flushed at idle time 

(defconstant $kVCBFlagsIdleFlushMask 8)
(defconstant $kVCBFlagsHFSPlusAPIsBit 4)        ;  Set if volume implements HFS Plus APIs itself (not via emulation) 

(defconstant $kVCBFlagsHFSPlusAPIsMask 16)
(defconstant $kVCBFlagsHardwareGoneBit 5)       ;  Set if disk driver returned a hardwareGoneErr to Read or Write 

(defconstant $kVCBFlagsHardwareGoneMask 32)
(defconstant $kVCBFlagsVolumeDirtyBit 15)       ;  Set if volume information has changed since the last FlushVol 

(defconstant $kVCBFlagsVolumeDirtyMask #x8000)
;  ioVAtrb bits returned by PBHGetVInfo and PBXGetVolInfo 

(defconstant $kioVAtrbDefaultVolumeBit 5)       ;  Set if the volume is the default volume 

(defconstant $kioVAtrbDefaultVolumeMask 32)
(defconstant $kioVAtrbFilesOpenBit 6)           ;  Set if there are open files or iterators 

(defconstant $kioVAtrbFilesOpenMask 64)
(defconstant $kioVAtrbHardwareLockedBit 7)      ;  Set if volume is locked by a hardware setting 

(defconstant $kioVAtrbHardwareLockedMask #x80)
(defconstant $kioVAtrbSoftwareLockedBit 15)     ;  Set if volume is locked by software 

(defconstant $kioVAtrbSoftwareLockedMask #x8000)
;  ioFlAttrib bits returned by PBGetCatInfo 
;  file and directory attributes in ioFlAttrib 

(defconstant $kioFlAttribLockedBit 0)           ;  Set if file or directory is locked 

(defconstant $kioFlAttribLockedMask 1)
(defconstant $kioFlAttribResOpenBit 2)          ;  Set if resource fork is open 

(defconstant $kioFlAttribResOpenMask 4)
(defconstant $kioFlAttribDataOpenBit 3)         ;  Set if data fork is open 

(defconstant $kioFlAttribDataOpenMask 8)
(defconstant $kioFlAttribDirBit 4)              ;  Set if this is a directory 

(defconstant $kioFlAttribDirMask 16)
(defconstant $ioDirFlg 4)                       ;  Set if this is a directory (old name) 

(defconstant $ioDirMask 16)
(defconstant $kioFlAttribCopyProtBit 6)         ;  Set if AppleShare server "copy-protects" the file 

(defconstant $kioFlAttribCopyProtMask 64)
(defconstant $kioFlAttribFileOpenBit 7)         ;  Set if file (either fork) is open 

(defconstant $kioFlAttribFileOpenMask #x80)     ;  ioFlAttrib for directories only 

(defconstant $kioFlAttribInSharedBit 2)         ;  Set if the directory is within a shared area of the directory hierarchy 

(defconstant $kioFlAttribInSharedMask 4)
(defconstant $kioFlAttribMountedBit 3)          ;  Set if the directory is a share point that is mounted by some user 

(defconstant $kioFlAttribMountedMask 8)
(defconstant $kioFlAttribSharePointBit 5)       ;  Set if the directory is a share point 

(defconstant $kioFlAttribSharePointMask 32)
;  ioFCBFlags bits returned by PBGetFCBInfo 

(defconstant $kioFCBWriteBit 8)                 ;  Data can be written to this file 

(defconstant $kioFCBWriteMask #x100)
(defconstant $kioFCBResourceBit 9)              ;  This file is a resource fork 

(defconstant $kioFCBResourceMask #x200)
(defconstant $kioFCBWriteLockedBit 10)          ;  File has a locked byte range 

(defconstant $kioFCBWriteLockedMask #x400)
(defconstant $kioFCBLargeFileBit 11)            ;  File may grow beyond 2GB; cache uses file blocks, not bytes 

(defconstant $kioFCBLargeFileMask #x800)
(defconstant $kioFCBSharedWriteBit 12)          ;  File is open for shared write access 

(defconstant $kioFCBSharedWriteMask #x1000)
(defconstant $kioFCBFileLockedBit 13)           ;  File is locked (write-protected) 

(defconstant $kioFCBFileLockedMask #x2000)
(defconstant $kioFCBOwnClumpBit 14)             ;  File has clump size specified in FCB 

(defconstant $kioFCBOwnClumpMask #x4000)
(defconstant $kioFCBModifiedBit 15)             ;  File has changed since it was last flushed 

(defconstant $kioFCBModifiedMask #x8000)
;  ioACUser bits returned by PBGetCatInfo 
;  Note: you must clear ioACUser before calling PBGetCatInfo because some file systems do not use this field 

(defconstant $kioACUserNoSeeFolderBit 0)        ;  Set if user does not have See Folder privileges 

(defconstant $kioACUserNoSeeFolderMask 1)
(defconstant $kioACUserNoSeeFilesBit 1)         ;  Set if user does not have See Files privileges 

(defconstant $kioACUserNoSeeFilesMask 2)
(defconstant $kioACUserNoMakeChangesBit 2)      ;  Set if user does not have Make Changes privileges 

(defconstant $kioACUserNoMakeChangesMask 4)
(defconstant $kioACUserNotOwnerBit 7)           ;  Set if user is not owner of the directory 

(defconstant $kioACUserNotOwnerMask #x80)
;  Folder and File values of access privileges in ioACAccess 

(defconstant $kioACAccessOwnerBit 31)           ;  User is owner of directory 

(defconstant $kioACAccessOwnerMask #x80000000)
(defconstant $kioACAccessBlankAccessBit 28)     ;  Directory has blank access privileges 

(defconstant $kioACAccessBlankAccessMask #x10000000)
(defconstant $kioACAccessUserWriteBit 26)       ;  User has write privileges 

(defconstant $kioACAccessUserWriteMask #x4000000)
(defconstant $kioACAccessUserReadBit 25)        ;  User has read privileges 

(defconstant $kioACAccessUserReadMask #x2000000)
(defconstant $kioACAccessUserSearchBit 24)      ;  User has search privileges 

(defconstant $kioACAccessUserSearchMask #x1000000)
(defconstant $kioACAccessEveryoneWriteBit 18)   ;  Everyone has write privileges 

(defconstant $kioACAccessEveryoneWriteMask #x40000)
(defconstant $kioACAccessEveryoneReadBit 17)    ;  Everyone has read privileges 

(defconstant $kioACAccessEveryoneReadMask #x20000)
(defconstant $kioACAccessEveryoneSearchBit 16)  ;  Everyone has search privileges 

(defconstant $kioACAccessEveryoneSearchMask #x10000)
(defconstant $kioACAccessGroupWriteBit 10)      ;  Group has write privileges 

(defconstant $kioACAccessGroupWriteMask #x400)
(defconstant $kioACAccessGroupReadBit 9)        ;  Group has read privileges 

(defconstant $kioACAccessGroupReadMask #x200)
(defconstant $kioACAccessGroupSearchBit 8)      ;  Group has search privileges 

(defconstant $kioACAccessGroupSearchMask #x100)
(defconstant $kioACAccessOwnerWriteBit 2)       ;  Owner has write privileges 

(defconstant $kioACAccessOwnerWriteMask 4)
(defconstant $kioACAccessOwnerReadBit 1)        ;  Owner has read privileges 

(defconstant $kioACAccessOwnerReadMask 2)
(defconstant $kioACAccessOwnerSearchBit 0)      ;  Owner has search privileges 

(defconstant $kioACAccessOwnerSearchMask 1)
(defconstant $kfullPrivileges #x70007)          ;  all privileges for everybody and owner

(defconstant $kownerPrivileges 7)               ;  all privileges for owner only

;  values of user IDs and group IDs 

(defconstant $knoUser 0)
(defconstant $kadministratorUser 1)

(defconstant $knoGroup 0)
(defrecord GetVolParmsInfoBuffer
   (vMVersion :SInt16)                          ; version number
   (vMAttrib :signed-long)                      ; bit vector of attributes (see vMAttrib constants)
   (vMLocalHand :Handle)                        ; handle to private data
   (vMServerAdr :signed-long)                   ; AppleTalk server address or zero
                                                ;        vMVersion 1 GetVolParmsInfoBuffer ends here 
   (vMVolumeGrade :signed-long)                 ; approx. speed rating or zero if unrated
   (vMForeignPrivID :SInt16)                    ; foreign privilege model supported or zero if none
                                                ;        vMVersion 2 GetVolParmsInfoBuffer ends here 
   (vMExtendedAttributes :signed-long)          ; extended attribute bits (see vMExtendedAttributes constants)
                                                ;        vMVersion 3 GetVolParmsInfoBuffer ends here 
   (vMDeviceID :pointer)                        ;  device id name for interoperability with IOKit 
                                                ;        vMVersion 4 GetVolParmsInfoBuffer ends here 
   (vMMaxNameLength :UInt32)
                                                ;        vMVersion 5 GetVolParmsInfoBuffer ends here 
)

;type name? (%define-record :GetVolParmsInfoBuffer (find-record-descriptor ':GetVolParmsInfoBuffer))

;type name? (def-mactype :ParamBlockRec (find-mactype ':ParamBlockRec))

(def-mactype :ParmBlkPtr (find-mactype '(:pointer :ParamBlockRec)))

(def-mactype :IOCompletionProcPtr (find-mactype ':pointer)); (ParmBlkPtr paramBlock)

(def-mactype :IOCompletionUPP (find-mactype '(:pointer :OpaqueIOCompletionProcPtr)))
(defrecord IOParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioRefNum :SInt16)                           ; refNum for I/O operation
   (ioVersNum :SInt8)                           ; version number
   (ioPermssn :SInt8)                           ; Open: permissions (byte)
   (ioMisc :pointer)                            ; Rename: new name (GetEOF,SetEOF: logical end of file) (Open: optional ptr to buffer) (SetFileType: new type)
   (ioBuffer :pointer)                          ; data buffer Ptr
   (ioReqCount :signed-long)                    ; requested byte count; also = ioNewDirID
   (ioActCount :signed-long)                    ; actual byte count completed
   (ioPosMode :SInt16)                          ; initial file positioning
   (ioPosOffset :signed-long)                   ; file position offset
)

;type name? (%define-record :IOParam (find-record-descriptor ':IOParam))

(def-mactype :IOParamPtr (find-mactype '(:pointer :IOParam)))
(defrecord FileParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioFRefNum :SInt16)                          ; reference number
   (ioFVersNum :SInt8)                          ; version number
   (filler1 :SInt8)
   (ioFDirIndex :SInt16)                        ; GetFInfo directory index
   (ioFlAttrib :SInt8)                          ; GetFInfo: in-use bit=7, lock bit=0
   (ioFlVersNum :SInt8)                         ; file version number
   (ioFlFndrInfo :FInfo)                        ; user info
   (ioFlNum :UInt32)                            ; GetFInfo: file number; TF- ioDirID
   (ioFlStBlk :UInt16)                          ; start file block (0 if none)
   (ioFlLgLen :signed-long)                     ; logical length (EOF)
   (ioFlPyLen :signed-long)                     ; physical length
   (ioFlRStBlk :UInt16)                         ; start block rsrc fork
   (ioFlRLgLen :signed-long)                    ; file logical length rsrc fork
   (ioFlRPyLen :signed-long)                    ; file physical length rsrc fork
   (ioFlCrDat :UInt32)                          ; file creation date& time (32 bits in secs)
   (ioFlMdDat :UInt32)                          ; last modified date and time
)

;type name? (%define-record :FileParam (find-record-descriptor ':FileParam))

(def-mactype :FileParamPtr (find-mactype '(:pointer :FileParam)))
(defrecord VolumeParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (filler2 :signed-long)
   (ioVolIndex :SInt16)                         ; volume index number
   (ioVCrDate :UInt32)                          ; creation date and time
   (ioVLsBkUp :UInt32)                          ; last backup date and time
   (ioVAtrb :UInt16)                            ; volume attrib
   (ioVNmFls :UInt16)                           ; number of files in directory
   (ioVDirSt :UInt16)                           ; start block of file directory
   (ioVBlLn :SInt16)                            ; GetVolInfo: length of dir in blocks
   (ioVNmAlBlks :UInt16)                        ; for compatibilty ioVNmAlBlks * ioVAlBlkSiz <= 2 GB
   (ioVAlBlkSiz :UInt32)                        ; for compatibilty ioVAlBlkSiz is <= $0000FE00 (65,024)
   (ioVClpSiz :UInt32)                          ; GetVolInfo: bytes to allocate at a time
   (ioAlBlSt :UInt16)                           ; starting disk(512-byte) block in block map
   (ioVNxtFNum :UInt32)                         ; GetVolInfo: next free file number
   (ioVFrBlk :UInt16)                           ; GetVolInfo: # free alloc blks for this vol
)

;type name? (%define-record :VolumeParam (find-record-descriptor ':VolumeParam))

(def-mactype :VolumeParamPtr (find-mactype '(:pointer :VolumeParam)))
(defrecord CntrlParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioCRefNum :SInt16)                          ; refNum for I/O operation
   (csCode :SInt16)                             ; word for control status code
   (csParam (:array :SInt16 11))                ; operation-defined parameters
)

;type name? (%define-record :CntrlParam (find-record-descriptor ':CntrlParam))

(def-mactype :CntrlParamPtr (find-mactype '(:pointer :CntrlParam)))
(defrecord SlotDevParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioSRefNum :SInt16)
   (ioSVersNum :SInt8)
   (ioSPermssn :SInt8)
   (ioSMix :pointer)
   (ioSFlags :SInt16)
   (ioSlot :SInt8)
   (ioID :SInt8)
)

;type name? (%define-record :SlotDevParam (find-record-descriptor ':SlotDevParam))

(def-mactype :SlotDevParamPtr (find-mactype '(:pointer :SlotDevParam)))
(defrecord MultiDevParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioMRefNum :SInt16)
   (ioMVersNum :SInt8)
   (ioMPermssn :SInt8)
   (ioMMix :pointer)
   (ioMFlags :SInt16)
   (ioSEBlkPtr :pointer)
)

;type name? (%define-record :MultiDevParam (find-record-descriptor ':MultiDevParam))

(def-mactype :MultiDevParamPtr (find-mactype '(:pointer :MultiDevParam)))
(defrecord ParamBlockRec
   (:variant
   (
   (ioParam :IOParam)
   )
   (
   (fileParam :FileParam)
   )
   (
   (volumeParam :VolumeParam)
   )
   (
   (cntrlParam :CntrlParam)
   )
   (
   (slotDevParam :SlotDevParam)
   )
   (
   (multiDevParam :MultiDevParam)
   )
   )
)
(defrecord HFileInfo
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioFRefNum :SInt16)
   (ioFVersNum :SInt8)
   (filler1 :SInt8)
   (ioFDirIndex :SInt16)
   (ioFlAttrib :SInt8)
   (ioACUser :SInt8)
   (ioFlFndrInfo :FInfo)
   (ioDirID :signed-long)
   (ioFlStBlk :UInt16)
   (ioFlLgLen :signed-long)
   (ioFlPyLen :signed-long)
   (ioFlRStBlk :UInt16)
   (ioFlRLgLen :signed-long)
   (ioFlRPyLen :signed-long)
   (ioFlCrDat :UInt32)
   (ioFlMdDat :UInt32)
   (ioFlBkDat :UInt32)
   (ioFlXFndrInfo :FXInfo)
   (ioFlParID :signed-long)
   (ioFlClpSiz :signed-long)
)

;type name? (%define-record :HFileInfo (find-record-descriptor ':HFileInfo))
(defrecord DirInfo
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioFRefNum :SInt16)
   (ioFVersNum :SInt8)
   (filler1 :SInt8)
   (ioFDirIndex :SInt16)
   (ioFlAttrib :SInt8)
   (ioACUser :SInt8)
   (ioDrUsrWds :DInfo)
   (ioDrDirID :signed-long)
   (ioDrNmFls :UInt16)
   (filler3 (:array :SInt16 9))
   (ioDrCrDat :UInt32)
   (ioDrMdDat :UInt32)
   (ioDrBkDat :UInt32)
   (ioDrFndrInfo :DXInfo)
   (ioDrParID :signed-long)
)

;type name? (%define-record :DirInfo (find-record-descriptor ':DirInfo))
(defrecord CInfoPBRec
   (:variant
   (
   (hFileInfo :HFileInfo)
   )
   (
   (dirInfo :DirInfo)
   )
   )
)

;type name? (%define-record :CInfoPBRec (find-record-descriptor ':CInfoPBRec))

(def-mactype :CInfoPBPtr (find-mactype '(:pointer :CInfoPBRec)))
(defrecord XCInfoPBRec
   (qLink (:pointer :QElem))
   (qType :SInt16)
   (ioTrap :SInt16)
   (ioCmdAddr :pointer)
   (ioCompletion :pointer)                      ;  --> A pointer to a completion routine 
   (ioResult :SInt16)                           ;  --> The result code of the function 
   (ioNamePtr (:pointer :UInt8))                ;  --> Pointer to pathname to object 
   (ioVRefNum :SInt16)                          ;  --> A volume specification 
   (filler1 :signed-long)
   (ioShortNamePtr (:pointer :UInt8))           ;  <-> A pointer to the short name string buffer - required! 
   (filler2 :SInt16)
   (ioPDType :SInt16)                           ;  <-- The ProDOS file type 
   (ioPDAuxType :signed-long)                   ;  <-- The ProDOS aux type 
   (filler3 (:array :signed-long 2))
   (ioDirID :signed-long)                       ;  --> A directory ID 
)

;type name? (%define-record :XCInfoPBRec (find-record-descriptor ':XCInfoPBRec))

(def-mactype :XCInfoPBPtr (find-mactype '(:pointer :XCInfoPBRec)))
;  Catalog position record 
(defrecord CatPositionRec
   (initialize :signed-long)
   (priv (:array :SInt16 6))
)

;type name? (%define-record :CatPositionRec (find-record-descriptor ':CatPositionRec))
(defrecord FSSpec
   (vRefNum :SInt16)
   (parID :signed-long)
   (name (:string 63))                          ;  a Str63 on MacOS
)

;type name? (%define-record :FSSpec (find-record-descriptor ':FSSpec))

(def-mactype :FSSpecPtr (find-mactype '(:pointer :FSSpec)))

(def-mactype :FSSpecHandle (find-mactype '(:handle :FSSpec)))
;  pointer to array of FSSpecs 

(def-mactype :FSSpecArrayPtr (find-mactype ':FSSpecPtr))
;  
;     The only difference between "const FSSpec*" and "ConstFSSpecPtr" is 
;     that as a parameter, ConstFSSpecPtr is allowed to be NULL 
; 

(def-mactype :ConstFSSpecPtr (find-mactype '(:pointer :FSSpec)))
;  
;     The following are structures to be filled out with the _PBGetVolMountInfo call
;     and passed back into the _PBVolumeMount call for external file system mounts. 
; 
;  the "signature" of the file system 

(def-mactype :VolumeType (find-mactype ':OSType))
;  the signature for AppleShare 

(defconstant $AppleShareMediaType :|afpm|)
; 
;     VolMount stuff was once in FSM.Å
; 
(defrecord VolMountInfoHeader
   (length :SInt16)                             ;  length of location data (including self) 
   (media :OSType)                              ;  type of media.  Variable length data follows 
)

;type name? (%define-record :VolMountInfoHeader (find-record-descriptor ':VolMountInfoHeader))

(def-mactype :VolMountInfoPtr (find-mactype '(:pointer :VolMountInfoHeader)))
;  The new volume mount info record.  The old one is included for compatibility. 
;     the new record allows access by foriegn filesystems writers to the flags 
;     portion of the record. This portion is now public.  
; 
(defrecord VolumeMountInfoHeader
   (length :SInt16)                             ;  length of location data (including self) 
   (media :OSType)                              ;  type of media (must be registered with Apple) 
   (flags :SInt16)                              ;  volume mount flags. Variable length data follows 
)

;type name? (%define-record :VolumeMountInfoHeader (find-record-descriptor ':VolumeMountInfoHeader))

(def-mactype :VolumeMountInfoHeaderPtr (find-mactype '(:pointer :VolumeMountInfoHeader)))
;  volume mount flags 

(defconstant $volMountNoLoginMsgFlagBit 0)      ;  Input to VolumeMount: If set, the file system 

(defconstant $volMountNoLoginMsgFlagMask 1)     ;   should suppresss any log-in message/greeting dialog 

(defconstant $volMountExtendedFlagsBit 7)       ;  Input to VolumeMount: If set, the mount info is a 

(defconstant $volMountExtendedFlagsMask #x80)   ;   AFPXVolMountInfo record for 3.7 AppleShare Client 

(defconstant $volMountInteractBit 15)           ;  Input to VolumeMount: If set, it's OK for the file system 

(defconstant $volMountInteractMask #x8000)      ;   to perform user interaction to mount the volume 

(defconstant $volMountChangedBit 14)            ;  Output from VoumeMount: If set, the volume was mounted, but 

(defconstant $volMountChangedMask #x4000)       ;   the volume mounting information record needs to be updated. 

(defconstant $volMountFSReservedMask #xFF)      ;  bits 0-7 are defined by each file system for its own use 

(defconstant $volMountSysReservedMask #xFF00)   ;  bits 8-15 are reserved for Apple system use 

(defrecord AFPVolMountInfo
   (length :SInt16)                             ;  length of location data (including self) 
   (media :OSType)                              ;  type of media 
   (flags :SInt16)                              ;  bits for no messages, no reconnect 
   (nbpInterval :SInt8)                         ;  NBP Interval parameter (IM2, p.322) 
   (nbpCount :SInt8)                            ;  NBP Interval parameter (IM2, p.322) 
   (uamType :SInt16)                            ;  User Authentication Method 
   (zoneNameOffset :SInt16)                     ;  short positive offset from start of struct to Zone Name 
   (serverNameOffset :SInt16)                   ;  offset to pascal Server Name string 
   (volNameOffset :SInt16)                      ;  offset to pascal Volume Name string 
   (userNameOffset :SInt16)                     ;  offset to pascal User Name string 
   (userPasswordOffset :SInt16)                 ;  offset to pascal User Password string 
   (volPasswordOffset :SInt16)                  ;  offset to pascal Volume Password string 
   (AFPData (:array :character 144))            ;  variable length data may follow 
)

;type name? (%define-record :AFPVolMountInfo (find-record-descriptor ':AFPVolMountInfo))

(def-mactype :AFPVolMountInfoPtr (find-mactype '(:pointer :AFPVolMountInfo)))
;  AFPXVolMountInfo is the new AFP volume mount info record, requires the 3.7 AppleShare Client 
(defrecord AFPXVolMountInfo
   (length :SInt16)                             ;  length of location data (including self) 
   (media :OSType)                              ;  type of media 
   (flags :SInt16)                              ;  bits for no messages, no reconnect 
   (nbpInterval :SInt8)                         ;  NBP Interval parameter (IM2, p.322) 
   (nbpCount :SInt8)                            ;  NBP Interval parameter (IM2, p.322) 
   (uamType :SInt16)                            ;  User Authentication Method type 
   (zoneNameOffset :SInt16)                     ;  short positive offset from start of struct to Zone Name 
   (serverNameOffset :SInt16)                   ;  offset to pascal Server Name string 
   (volNameOffset :SInt16)                      ;  offset to pascal Volume Name string 
   (userNameOffset :SInt16)                     ;  offset to pascal User Name string 
   (userPasswordOffset :SInt16)                 ;  offset to pascal User Password string 
   (volPasswordOffset :SInt16)                  ;  offset to pascal Volume Password string 
   (extendedFlags :SInt16)                      ;  extended flags word 
   (uamNameOffset :SInt16)                      ;  offset to a pascal UAM name string 
   (alternateAddressOffset :SInt16)             ;  offset to Alternate Addresses in tagged format 
   (AFPData (:array :character 176))            ;  variable length data may follow 
)

;type name? (%define-record :AFPXVolMountInfo (find-record-descriptor ':AFPXVolMountInfo))

(def-mactype :AFPXVolMountInfoPtr (find-mactype '(:pointer :AFPXVolMountInfo)))

(defconstant $kAFPExtendedFlagsAlternateAddressMask 1);   bit in AFPXVolMountInfo.extendedFlags that means alternateAddressOffset is used

;  constants for use in AFPTagData.fType field

(defconstant $kAFPTagTypeIP 1)                  ;  4 byte IP address (MSB first)            

(defconstant $kAFPTagTypeIPPort 2)              ;  4 byte IP address, 2 byte port (MSB first)     

(defconstant $kAFPTagTypeDDP 3)                 ;  Net,Node,Socket Sent by the server, currently unused by the client 

(defconstant $kAFPTagTypeDNS 4)                 ;  DNS name in  address:port format   (total length variable up to 254 chars of dns name)          

;  constants for use in AFPTagData.fLength field

(defconstant $kAFPTagLengthIP 6)
(defconstant $kAFPTagLengthIPPort 8)
(defconstant $kAFPTagLengthDDP 6)
(defrecord AFPTagData
   (fLength :UInt8)                             ;  length of this data tag including the fLength field 
   (fType :UInt8)
   (fData (:array :UInt8 1))                    ;  variable length data 
)

;type name? (%define-record :AFPTagData (find-record-descriptor ':AFPTagData))
(defrecord AFPAlternateAddress
                                                ;  ¥¥¥ÊNOTE: fVersion was missing in 3.2 Universal Interfaces
   (fVersion :UInt8)                            ;  version of the structure (currently 0x00)
   (fAddressCount :UInt8)
   (fAddressList (:array :UInt8 1))             ;  actually variable length packed set of AFPTagData 
)

;type name? (%define-record :AFPAlternateAddress (find-record-descriptor ':AFPAlternateAddress))
(defrecord DTPBRec
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioDTRefNum :SInt16)                         ;  desktop refnum 
   (ioIndex :SInt16)
   (ioTagInfo :signed-long)
   (ioDTBuffer :pointer)
   (ioDTReqCount :signed-long)
   (ioDTActCount :signed-long)
   (ioFiller1 :SInt8)
   (ioIconType :UInt8)
   (ioFiller2 :SInt16)
   (ioDirID :signed-long)
   (ioFileCreator :OSType)
   (ioFileType :OSType)
   (ioFiller3 :signed-long)
   (ioDTLgLen :signed-long)
   (ioDTPyLen :signed-long)
   (ioFiller4 (:array :SInt16 14))
   (ioAPPLParID :signed-long)
)

;type name? (%define-record :DTPBRec (find-record-descriptor ':DTPBRec))

(def-mactype :DTPBPtr (find-mactype '(:pointer :DTPBRec)))
(defrecord HIOParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioRefNum :SInt16)
   (ioVersNum :SInt8)
   (ioPermssn :SInt8)
   (ioMisc :pointer)
   (ioBuffer :pointer)
   (ioReqCount :signed-long)
   (ioActCount :signed-long)
   (ioPosMode :SInt16)
   (ioPosOffset :signed-long)
)

;type name? (%define-record :HIOParam (find-record-descriptor ':HIOParam))

(def-mactype :HIOParamPtr (find-mactype '(:pointer :HIOParam)))
(defrecord HFileParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioFRefNum :SInt16)
   (ioFVersNum :SInt8)
   (filler1 :SInt8)
   (ioFDirIndex :SInt16)
   (ioFlAttrib :SInt8)
   (ioFlVersNum :SInt8)
   (ioFlFndrInfo :FInfo)
   (ioDirID :signed-long)
   (ioFlStBlk :UInt16)
   (ioFlLgLen :signed-long)
   (ioFlPyLen :signed-long)
   (ioFlRStBlk :UInt16)
   (ioFlRLgLen :signed-long)
   (ioFlRPyLen :signed-long)
   (ioFlCrDat :UInt32)
   (ioFlMdDat :UInt32)
)

;type name? (%define-record :HFileParam (find-record-descriptor ':HFileParam))

(def-mactype :HFileParamPtr (find-mactype '(:pointer :HFileParam)))
(defrecord HVolumeParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (filler2 :signed-long)
   (ioVolIndex :SInt16)
   (ioVCrDate :UInt32)
   (ioVLsMod :UInt32)
   (ioVAtrb :SInt16)
   (ioVNmFls :UInt16)
   (ioVBitMap :UInt16)
   (ioAllocPtr :UInt16)
   (ioVNmAlBlks :UInt16)
   (ioVAlBlkSiz :UInt32)
   (ioVClpSiz :UInt32)
   (ioAlBlSt :UInt16)
   (ioVNxtCNID :UInt32)
   (ioVFrBlk :UInt16)
   (ioVSigWord :UInt16)
   (ioVDrvInfo :SInt16)
   (ioVDRefNum :SInt16)
   (ioVFSID :SInt16)
   (ioVBkUp :UInt32)
   (ioVSeqNum :SInt16)
   (ioVWrCnt :UInt32)
   (ioVFilCnt :UInt32)
   (ioVDirCnt :UInt32)
   (ioVFndrInfo (:array :signed-long 8))
)

;type name? (%define-record :HVolumeParam (find-record-descriptor ':HVolumeParam))

(def-mactype :HVolumeParamPtr (find-mactype '(:pointer :HVolumeParam)))
(defrecord XIOParam
   (qLink (:pointer :QElem))
   (qType :SInt16)
   (ioTrap :SInt16)
   (ioCmdAddr :pointer)
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr))
   (ioResult :SInt16)
   (ioNamePtr (:pointer :UInt8))
   (ioVRefNum :SInt16)
   (ioRefNum :SInt16)
   (ioVersNum :SInt8)
   (ioPermssn :SInt8)
   (ioMisc :pointer)
   (ioBuffer :pointer)
   (ioReqCount :signed-long)
   (ioActCount :signed-long)
   (ioPosMode :SInt16)                          ;  must have kUseWidePositioning bit set 
   (ioWPosOffset :wide)                         ;  wide positioning offset 
)

;type name? (%define-record :XIOParam (find-record-descriptor ':XIOParam))

(def-mactype :XIOParamPtr (find-mactype '(:pointer :XIOParam)))
(defrecord XVolumeParam
   (qLink (:pointer :QElem))
   (qType :SInt16)
   (ioTrap :SInt16)
   (ioCmdAddr :pointer)
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr))
   (ioResult :SInt16)
   (ioNamePtr (:pointer :UInt8))
   (ioVRefNum :SInt16)
   (ioXVersion :UInt32)                         ;  this XVolumeParam version (0) 
   (ioVolIndex :SInt16)
   (ioVCrDate :UInt32)
   (ioVLsMod :UInt32)
   (ioVAtrb :SInt16)
   (ioVNmFls :UInt16)
   (ioVBitMap :UInt16)
   (ioAllocPtr :UInt16)
   (ioVNmAlBlks :UInt16)
   (ioVAlBlkSiz :UInt32)
   (ioVClpSiz :UInt32)
   (ioAlBlSt :UInt16)
   (ioVNxtCNID :UInt32)
   (ioVFrBlk :UInt16)
   (ioVSigWord :UInt16)
   (ioVDrvInfo :SInt16)
   (ioVDRefNum :SInt16)
   (ioVFSID :SInt16)
   (ioVBkUp :UInt32)
   (ioVSeqNum :SInt16)
   (ioVWrCnt :UInt32)
   (ioVFilCnt :UInt32)
   (ioVDirCnt :UInt32)
   (ioVFndrInfo (:array :signed-long 8))
   (ioVTotalBytes :UInt64)                      ;  total number of bytes on volume 
   (ioVFreeBytes :UInt64)                       ;  number of free bytes on volume 
)

;type name? (%define-record :XVolumeParam (find-record-descriptor ':XVolumeParam))

(def-mactype :XVolumeParamPtr (find-mactype '(:pointer :XVolumeParam)))
(defrecord AccessParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (filler3 :SInt16)
   (ioDenyModes :SInt16)                        ; access rights data
   (filler4 :SInt16)
   (filler5 :SInt8)
   (ioACUser :SInt8)                            ; access rights for directory only
   (filler6 :signed-long)
   (ioACOwnerID :signed-long)                   ; owner ID
   (ioACGroupID :signed-long)                   ; group ID
   (ioACAccess :signed-long)                    ; access rights
   (ioDirID :signed-long)
)

;type name? (%define-record :AccessParam (find-record-descriptor ':AccessParam))

(def-mactype :AccessParamPtr (find-mactype '(:pointer :AccessParam)))
(defrecord ObjParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (filler7 :SInt16)
   (ioObjType :SInt16)                          ; function code
   (ioObjNamePtr (:pointer :UInt8))             ; ptr to returned creator/group name
   (ioObjID :signed-long)                       ; creator/group ID
)

;type name? (%define-record :ObjParam (find-record-descriptor ':ObjParam))

(def-mactype :ObjParamPtr (find-mactype '(:pointer :ObjParam)))
(defrecord CopyParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioDstVRefNum :SInt16)                       ; destination vol identifier
   (filler8 :SInt16)
   (ioNewName (:pointer :UInt8))                ; ptr to destination pathname
   (ioCopyName (:pointer :UInt8))               ; ptr to optional name
   (ioNewDirID :signed-long)                    ; destination directory ID
   (filler14 :signed-long)
   (filler15 :signed-long)
   (ioDirID :signed-long)
)

;type name? (%define-record :CopyParam (find-record-descriptor ':CopyParam))

(def-mactype :CopyParamPtr (find-mactype '(:pointer :CopyParam)))
(defrecord WDParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioWDCreated :SInt16)
   (ioWDIndex :SInt16)
   (ioWDProcID :signed-long)
   (ioWDVRefNum :SInt16)
   (filler10 :SInt16)
   (filler11 :signed-long)
   (filler12 :signed-long)
   (filler13 :signed-long)
   (ioWDDirID :signed-long)
)

;type name? (%define-record :WDParam (find-record-descriptor ':WDParam))

(def-mactype :WDParamPtr (find-mactype '(:pointer :WDParam)))
(defrecord FIDParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (filler14 :signed-long)
   (ioDestNamePtr (:pointer :UInt8))            ;  dest file name 
   (filler15 :signed-long)
   (ioDestDirID :signed-long)                   ;  dest file's directory id 
   (filler16 :signed-long)
   (filler17 :signed-long)
   (ioSrcDirID :signed-long)                    ;  source file's directory id 
   (filler18 :SInt16)
   (ioFileID :signed-long)                      ;  file ID 
)

;type name? (%define-record :FIDParam (find-record-descriptor ':FIDParam))

(def-mactype :FIDParamPtr (find-mactype '(:pointer :FIDParam)))
(defrecord ForeignPrivParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioFiller21 :signed-long)
   (ioFiller22 :signed-long)
   (ioForeignPrivBuffer :pointer)
   (ioForeignPrivActCount :signed-long)
   (ioForeignPrivReqCount :signed-long)
   (ioFiller23 :signed-long)
   (ioForeignPrivDirID :signed-long)
   (ioForeignPrivInfo1 :signed-long)
   (ioForeignPrivInfo2 :signed-long)
   (ioForeignPrivInfo3 :signed-long)
   (ioForeignPrivInfo4 :signed-long)
)

;type name? (%define-record :ForeignPrivParam (find-record-descriptor ':ForeignPrivParam))

(def-mactype :ForeignPrivParamPtr (find-mactype '(:pointer :ForeignPrivParam)))
(defrecord CSParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (ioMatchPtr (:pointer :FSSpec))              ;  match array 
   (ioReqMatchCount :signed-long)               ;  maximum allowable matches 
   (ioActMatchCount :signed-long)               ;  actual match count 
   (ioSearchBits :signed-long)                  ;  search criteria selector 
   (ioSearchInfo1 (:pointer :CInfoPBRec))       ;  search values and range lower bounds 
   (ioSearchInfo2 (:pointer :CInfoPBRec))       ;  search values and range upper bounds 
   (ioSearchTime :signed-long)                  ;  length of time to run search 
   (ioCatPosition :CatPositionRec)              ;  current position in the catalog 
   (ioOptBuffer :pointer)                       ;  optional performance enhancement buffer 
   (ioOptBufSize :signed-long)                  ;  size of buffer pointed to by ioOptBuffer 
)

;type name? (%define-record :CSParam (find-record-descriptor ':CSParam))

(def-mactype :CSParamPtr (find-mactype '(:pointer :CSParam)))
(defrecord HParamBlockRec
   (:variant
   (
   (ioParam :HIOParam)
   )
   (
   (fileParam :HFileParam)
   )
   (
   (volumeParam :HVolumeParam)
   )
   (
   (accessParam :AccessParam)
   )
   (
   (objParam :ObjParam)
   )
   (
   (copyParam :CopyParam)
   )
   (
   (wdParam :WDParam)
   )
   (
   (fidParam :FIDParam)
   )
   (
   (csParam :CSParam)
   )
   (
   (foreignPrivParam :ForeignPrivParam)
   )
   )
)

;type name? (%define-record :HParamBlockRec (find-record-descriptor ':HParamBlockRec))

(def-mactype :HParmBlkPtr (find-mactype '(:pointer :HParamBlockRec)))
(defrecord CMovePBRec
   (qLink (:pointer :QElem))
   (qType :SInt16)
   (ioTrap :SInt16)
   (ioCmdAddr :pointer)
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr))
   (ioResult :SInt16)
   (ioNamePtr (:pointer :UInt8))
   (ioVRefNum :SInt16)
   (filler1 :signed-long)
   (ioNewName (:pointer :UInt8))
   (filler2 :signed-long)
   (ioNewDirID :signed-long)
   (filler3 (:array :signed-long 2))
   (ioDirID :signed-long)
)

;type name? (%define-record :CMovePBRec (find-record-descriptor ':CMovePBRec))

(def-mactype :CMovePBPtr (find-mactype '(:pointer :CMovePBRec)))
(defrecord WDPBRec
   (qLink (:pointer :QElem))
   (qType :SInt16)
   (ioTrap :SInt16)
   (ioCmdAddr :pointer)
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr))
   (ioResult :SInt16)
   (ioNamePtr (:pointer :UInt8))
   (ioVRefNum :SInt16)
   (filler1 :SInt16)
   (ioWDIndex :SInt16)
   (ioWDProcID :signed-long)
   (ioWDVRefNum :SInt16)
   (filler2 (:array :SInt16 7))
   (ioWDDirID :signed-long)
)

;type name? (%define-record :WDPBRec (find-record-descriptor ':WDPBRec))

(def-mactype :WDPBPtr (find-mactype '(:pointer :WDPBRec)))
(defrecord FCBPBRec
   (qLink (:pointer :QElem))
   (qType :SInt16)
   (ioTrap :SInt16)
   (ioCmdAddr :pointer)
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr))
   (ioResult :SInt16)
   (ioNamePtr (:pointer :UInt8))
   (ioVRefNum :SInt16)
   (ioRefNum :SInt16)
   (filler :SInt16)
   (ioFCBIndx :SInt16)
   (filler1 :SInt16)
   (ioFCBFlNm :signed-long)
   (ioFCBFlags :SInt16)
   (ioFCBStBlk :UInt16)
   (ioFCBEOF :signed-long)
   (ioFCBPLen :signed-long)
   (ioFCBCrPs :signed-long)
   (ioFCBVRefNum :SInt16)
   (ioFCBClpSiz :signed-long)
   (ioFCBParID :signed-long)
)

;type name? (%define-record :FCBPBRec (find-record-descriptor ':FCBPBRec))

(def-mactype :FCBPBPtr (find-mactype '(:pointer :FCBPBRec)))
(defrecord VCB
   (qLink (:pointer :QElem))
   (qType :SInt16)
   (vcbFlags :SInt16)
   (vcbSigWord :UInt16)
   (vcbCrDate :UInt32)
   (vcbLsMod :UInt32)
   (vcbAtrb :SInt16)
   (vcbNmFls :UInt16)
   (vcbVBMSt :SInt16)
   (vcbAllocPtr :SInt16)
   (vcbNmAlBlks :UInt16)
   (vcbAlBlkSiz :signed-long)
   (vcbClpSiz :signed-long)
   (vcbAlBlSt :SInt16)
   (vcbNxtCNID :signed-long)
   (vcbFreeBks :UInt16)
   (vcbVN (:string 27))
   (vcbDrvNum :SInt16)
   (vcbDRefNum :SInt16)
   (vcbFSID :SInt16)
   (vcbVRefNum :SInt16)
   (vcbMAdr :pointer)
   (vcbBufAdr :pointer)
   (vcbMLen :SInt16)
   (vcbDirIndex :SInt16)
   (vcbDirBlk :SInt16)
   (vcbVolBkUp :UInt32)
   (vcbVSeqNum :UInt16)
   (vcbWrCnt :signed-long)
   (vcbXTClpSiz :signed-long)
   (vcbCTClpSiz :signed-long)
   (vcbNmRtDirs :UInt16)
   (vcbFilCnt :signed-long)
   (vcbDirCnt :signed-long)
   (vcbFndrInfo (:array :signed-long 8))
   (vcbVCSize :UInt16)
   (vcbVBMCSiz :UInt16)
   (vcbCtlCSiz :UInt16)
   (vcbXTAlBlks :UInt16)
   (vcbCTAlBlks :UInt16)
   (vcbXTRef :SInt16)
   (vcbCTRef :SInt16)
   (vcbCtlBuf :pointer)
   (vcbDirIDM :signed-long)
   (vcbOffsM :SInt16)
)

;type name? (%define-record :VCB (find-record-descriptor ':VCB))

(def-mactype :VCBPtr (find-mactype '(:pointer :VCB)))
(defrecord DrvQEl
   (qLink (:pointer :QElem))
   (qType :SInt16)
   (dQDrive :SInt16)
   (dQRefNum :SInt16)
   (dQFSID :SInt16)
   (dQDrvSz :UInt16)
   (dQDrvSz2 :UInt16)
)

;type name? (%define-record :DrvQEl (find-record-descriptor ':DrvQEl))

(def-mactype :DrvQElPtr (find-mactype '(:pointer :DrvQEl)))
; 
;  *  NewIOCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewIOCompletionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueIOCompletionProcPtr)
() )
; 
;  *  DisposeIOCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeIOCompletionUPP" 
   ((userUPP (:pointer :OpaqueIOCompletionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeIOCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeIOCompletionUPP" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
    (userUPP (:pointer :OpaqueIOCompletionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;    PBOpenSync(), PBOpenAsync(), PBOpenImmed() were moved to Devices.h
;    PBCloseSync(), PBCloseAsync(), PBCloseImmed() were moved to Devices.h
;    PBReadSync(), PBReadAsync(), PBReadImmed() were moved to Devices.h
;    PBWriteSync(), PBWriteAsync(), PBWriteImmed() were moved to Devices.h
; 
; 
;  *  PBGetVInfoSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBGetVInfoAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBXGetVolInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  

(deftrap-inline "_PBXGetVolInfoSync" 
   ((paramBlock (:pointer :XVolumeParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBXGetVolInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  

(deftrap-inline "_PBXGetVolInfoAsync" 
   ((paramBlock (:pointer :XVolumeParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetVolSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBGetVolAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBSetVolSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBSetVolAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBFlushVolSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBFlushVolSync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBFlushVolAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBFlushVolAsync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHTrashVolumeCachesSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  
; 
;  *  PBCreateSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBCreateAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBDeleteSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBDeleteAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBOpenDFSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBOpenDFAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBOpenRFSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBOpenRFAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBRenameSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBRenameAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBGetFInfoSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBGetFInfoAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBSetFInfoSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBSetFInfoAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBSetFLockSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBSetFLockAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBRstFLockSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBRstFLockAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBSetFVersSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBSetFVersAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBAllocateSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBAllocateSync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBAllocateAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBAllocateAsync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetEOFSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetEOFSync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetEOFAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetEOFAsync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetEOFSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBSetEOFSync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetEOFAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBSetEOFAsync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetFPosSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetFPosSync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetFPosAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetFPosAsync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetFPosSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBSetFPosSync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetFPosAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBSetFPosAsync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBFlushFileSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBFlushFileSync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBFlushFileAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBFlushFileAsync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBMountVol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBUnmountVol()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBUnmountVol" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBUnmountVolImmed()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  
; 
;  *  PBEject()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBOffLine()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBCatSearchSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBCatSearchSync" 
   ((paramBlock (:pointer :CSParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCatSearchAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBCatSearchAsync" 
   ((paramBlock (:pointer :CSParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetVol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  UnmountVol()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_UnmountVol" 
   ((volName (:pointer :UInt8))                 ;  can be NULL 
    (vRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  Eject()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  FlushVol()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FlushVol" 
   ((volName (:pointer :UInt8))                 ;  can be NULL 
    (vRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HSetVol()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HSetVol" 
   ((volName (:pointer :UInt8))                 ;  can be NULL 
    (vRefNum :SInt16)
    (dirID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  AddDrive() was moved to Devices.h
; 
;  *  FSOpen()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  OpenDF()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  FSClose()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSClose" 
   ((refNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSRead()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSRead" 
   ((refNum :SInt16)
    (count (:pointer :long))
    (buffPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSWrite()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSWrite" 
   ((refNum :SInt16)
    (count (:pointer :long))
    (buffPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetVInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  GetFInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  GetVol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  Create()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  FSDelete()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  OpenRF()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  Rename()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SetFInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SetFLock()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  RstFLock()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  Allocate()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Allocate" 
   ((refNum :SInt16)
    (count (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetEOF()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetEOF" 
   ((refNum :SInt16)
    (logEOF (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetEOF()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetEOF" 
   ((refNum :SInt16)
    (logEOF :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetFPos()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetFPos" 
   ((refNum :SInt16)
    (filePos (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetFPos()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetFPos" 
   ((refNum :SInt16)
    (posMode :SInt16)
    (posOff :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetVRefNum()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetVRefNum" 
   ((fileRefNum :SInt16)
    (vRefNum (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  fsopen()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  getvinfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  getfinfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  getvol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  setvol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  unmountvol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  eject()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  flushvol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  create()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  fsdelete()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  openrf()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  fsrename()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  setfinfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  setflock()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  rstflock()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBOpenWDSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBOpenWDAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBCloseWDSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBCloseWDAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBHSetVolSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHSetVolSync" 
   ((paramBlock (:pointer :WDPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHSetVolAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHSetVolAsync" 
   ((paramBlock (:pointer :WDPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHGetVolSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHGetVolSync" 
   ((paramBlock (:pointer :WDPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHGetVolAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHGetVolAsync" 
   ((paramBlock (:pointer :WDPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCatMoveSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBCatMoveSync" 
   ((paramBlock (:pointer :CMovePBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCatMoveAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBCatMoveAsync" 
   ((paramBlock (:pointer :CMovePBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDirCreateSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDirCreateSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDirCreateAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDirCreateAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetWDInfoSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBGetWDInfoAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBGetFCBInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetFCBInfoSync" 
   ((paramBlock (:pointer :FCBPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetFCBInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetFCBInfoAsync" 
   ((paramBlock (:pointer :FCBPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetCatInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetCatInfoSync" 
   ((paramBlock (:pointer :CInfoPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetCatInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetCatInfoAsync" 
   ((paramBlock (:pointer :CInfoPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetCatInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBSetCatInfoSync" 
   ((paramBlock (:pointer :CInfoPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetCatInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBSetCatInfoAsync" 
   ((paramBlock (:pointer :CInfoPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBAllocContigSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBAllocContigSync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBAllocContigAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBAllocContigAsync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBLockRangeSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBLockRangeSync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBLockRangeAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBLockRangeAsync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBUnlockRangeSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBUnlockRangeSync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBUnlockRangeAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBUnlockRangeAsync" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetVInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBSetVInfoSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetVInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBSetVInfoAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHGetVInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHGetVInfoSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHGetVInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHGetVInfoAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHOpenSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHOpenSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHOpenAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHOpenAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHOpenRFSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHOpenRFSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHOpenRFAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHOpenRFAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHOpenDFSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHOpenDFSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHOpenDFAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHOpenDFAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHCreateSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHCreateSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHCreateAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHCreateAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHDeleteSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHDeleteSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHDeleteAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHDeleteAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHRenameSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHRenameSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHRenameAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHRenameAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHRstFLockSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHRstFLockSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHRstFLockAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHRstFLockAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHSetFLockSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHSetFLockSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHSetFLockAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHSetFLockAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHGetFInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHGetFInfoSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHGetFInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHGetFInfoAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHSetFInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHSetFInfoSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHSetFInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHSetFInfoAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBMakeFSSpecSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBMakeFSSpecSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBMakeFSSpecAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBMakeFSSpecAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FInitQueue()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PBDirectIOOpenDFSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  PBDirectIOOpenRFSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  PBDirectIOCloseSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  PBDirectIOReadSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  PBDirectIOReadAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  PBDirectIOWriteSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  PBDirectIOWriteAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  GetFSQHdr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  GetVCBQHdr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
;  GetDrvQHdr was moved to Devices.h
; 
;  *  HGetVol()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HGetVol" 
   ((volName (:pointer :UInt8))
    (vRefNum (:pointer :short))
    (dirID (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HOpen()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HOpen" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
    (fileName (:pointer :STR255))
    (permission :SInt8)
    (refNum (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HOpenDF()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HOpenDF" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
    (fileName (:pointer :STR255))
    (permission :SInt8)
    (refNum (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HOpenRF()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HOpenRF" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
    (fileName (:pointer :STR255))
    (permission :SInt8)
    (refNum (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AllocContig()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AllocContig" 
   ((refNum :SInt16)
    (count (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HCreate()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HCreate" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
    (fileName (:pointer :STR255))
    (creator :OSType)
    (fileType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DirCreate()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DirCreate" 
   ((vRefNum :SInt16)
    (parentDirID :signed-long)
    (directoryName (:pointer :STR255))
    (createdDirID (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HDelete()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HDelete" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
    (fileName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HGetFInfo()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HGetFInfo" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
    (fileName (:pointer :STR255))
    (fndrInfo (:pointer :FInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HSetFInfo()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HSetFInfo" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
    (fileName (:pointer :STR255))
    (fndrInfo (:pointer :FInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HSetFLock()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HSetFLock" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
    (fileName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HRstFLock()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HRstFLock" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
    (fileName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HRename()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HRename" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
    (oldName (:pointer :STR255))
    (newName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CatMove()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CatMove" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
    (oldName (:pointer :STR255))
    (newDirID :signed-long)
    (newName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  OpenWD()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  CloseWD()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  GetWDInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
;   shared environment  
; 
;  *  PBHGetVolParmsSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHGetVolParmsSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHGetVolParmsAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHGetVolParmsAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHGetLogInInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHGetLogInInfoSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHGetLogInInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHGetLogInInfoAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHGetDirAccessSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHGetDirAccessSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHGetDirAccessAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHGetDirAccessAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHSetDirAccessSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHSetDirAccessSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHSetDirAccessAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHSetDirAccessAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHMapIDSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHMapIDSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHMapIDAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHMapIDAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHMapNameSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHMapNameSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHMapNameAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHMapNameAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHCopyFileSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHCopyFileSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHCopyFileAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHCopyFileAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHMoveRenameSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHMoveRenameSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHMoveRenameAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHMoveRenameAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHOpenDenySync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHOpenDenySync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHOpenDenyAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHOpenDenyAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHOpenRFDenySync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHOpenRFDenySync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBHOpenRFDenyAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBHOpenRFDenyAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetXCatInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  

(deftrap-inline "_PBGetXCatInfoSync" 
   ((paramBlock (:pointer :XCInfoPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetXCatInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  

(deftrap-inline "_PBGetXCatInfoAsync" 
   ((paramBlock (:pointer :XCInfoPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBExchangeFilesSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBExchangeFilesSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBExchangeFilesAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBExchangeFilesAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCreateFileIDRefSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBCreateFileIDRefSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCreateFileIDRefAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBCreateFileIDRefAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBResolveFileIDRefSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBResolveFileIDRefSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBResolveFileIDRefAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBResolveFileIDRefAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDeleteFileIDRefSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDeleteFileIDRefSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDeleteFileIDRefAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDeleteFileIDRefAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetForeignPrivsSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetForeignPrivsSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetForeignPrivsAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetForeignPrivsAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetForeignPrivsSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBSetForeignPrivsSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetForeignPrivsAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBSetForeignPrivsAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;   Desktop Manager  
; 
;  *  PBDTGetPath()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTGetPath" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTCloseDown()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTCloseDown" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTAddIconSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTAddIconSync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTAddIconAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTAddIconAsync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTGetIconSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTGetIconSync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTGetIconAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTGetIconAsync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTGetIconInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTGetIconInfoSync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTGetIconInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTGetIconInfoAsync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTAddAPPLSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTAddAPPLSync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTAddAPPLAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTAddAPPLAsync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTRemoveAPPLSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTRemoveAPPLSync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTRemoveAPPLAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTRemoveAPPLAsync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTGetAPPLSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTGetAPPLSync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTGetAPPLAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTGetAPPLAsync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTSetCommentSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTSetCommentSync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTSetCommentAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTSetCommentAsync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTRemoveCommentSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTRemoveCommentSync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTRemoveCommentAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTRemoveCommentAsync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTGetCommentSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTGetCommentSync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTGetCommentAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTGetCommentAsync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTFlushSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTFlushSync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTFlushAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTFlushAsync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTResetSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTResetSync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTResetAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTResetAsync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTGetInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTGetInfoSync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTGetInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTGetInfoAsync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTOpenInform()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTOpenInform" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTDeleteSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTDeleteSync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDTDeleteAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBDTDeleteAsync" 
   ((paramBlock (:pointer :DTPBRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;   VolumeMount traps  
; 
;  *  PBGetVolMountInfoSize()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetVolMountInfoSize" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetVolMountInfo()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetVolMountInfo" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBVolumeMount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBVolumeMount" 
   ((paramBlock (:pointer :PARAMBLOCKREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;   FSp traps  
; 
;  *  FSMakeFSSpec()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSMakeFSSpec" 
   ((vRefNum :SInt16)
    (dirID :signed-long)
    (fileName (:pointer :STR255))
    (spec (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSpOpenDF()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSpOpenDF" 
   ((spec (:pointer :FSSpec))
    (permission :SInt8)
    (refNum (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSpOpenRF()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSpOpenRF" 
   ((spec (:pointer :FSSpec))
    (permission :SInt8)
    (refNum (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSpCreate()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSpCreate" 
   ((spec (:pointer :FSSpec))
    (creator :OSType)
    (fileType :OSType)
    (scriptTag :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSpDirCreate()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSpDirCreate" 
   ((spec (:pointer :FSSpec))
    (scriptTag :SInt16)
    (createdDirID (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSpDelete()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSpDelete" 
   ((spec (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSpGetFInfo()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSpGetFInfo" 
   ((spec (:pointer :FSSpec))
    (fndrInfo (:pointer :FInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSpSetFInfo()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSpSetFInfo" 
   ((spec (:pointer :FSSpec))
    (fndrInfo (:pointer :FInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSpSetFLock()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSpSetFLock" 
   ((spec (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSpRstFLock()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSpRstFLock" 
   ((spec (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSpRename()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSpRename" 
   ((spec (:pointer :FSSpec))
    (newName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSpCatMove()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSpCatMove" 
   ((source (:pointer :FSSpec))
    (dest (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSpExchangeFiles()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FSpExchangeFiles" 
   ((source (:pointer :FSSpec))
    (dest (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBShareSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBShareSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBShareAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBShareAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBUnshareSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBUnshareSync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBUnshareAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBUnshareAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetUGEntrySync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetUGEntrySync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetUGEntryAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PBGetUGEntryAsync" 
   ((paramBlock (:pointer :HParamBlockRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;     The PBxxx() routines are obsolete.  
;     
;     Use the PBxxxSync() or PBxxxAsync() version instead.
; 
; #define PBGetVInfo(pb, async) ((async) ? PBGetVInfoAsync(pb) : PBGetVInfoSync(pb))
; #define PBXGetVolInfo(pb, async) ((async) ? PBXGetVolInfoAsync(pb) : PBXGetVolInfoSync(pb))
; #define PBGetVol(pb, async) ((async) ? PBGetVolAsync(pb) : PBGetVolSync(pb))
; #define PBSetVol(pb, async) ((async) ? PBSetVolAsync(pb) : PBSetVolSync(pb))
; #define PBFlushVol(pb, async) ((async) ? PBFlushVolAsync(pb) : PBFlushVolSync(pb))
; #define PBCreate(pb, async) ((async) ? PBCreateAsync(pb) : PBCreateSync(pb))
; #define PBDelete(pb, async) ((async) ? PBDeleteAsync(pb) : PBDeleteSync(pb))
; #define PBOpenDF(pb, async) ((async) ? PBOpenDFAsync(pb) : PBOpenDFSync(pb))
; #define PBOpenRF(pb, async) ((async) ? PBOpenRFAsync(pb) : PBOpenRFSync(pb))
; #define PBRename(pb, async) ((async) ? PBRenameAsync(pb) : PBRenameSync(pb))
; #define PBGetFInfo(pb, async) ((async) ? PBGetFInfoAsync(pb) : PBGetFInfoSync(pb))
; #define PBSetFInfo(pb, async) ((async) ? PBSetFInfoAsync(pb) : PBSetFInfoSync(pb))
; #define PBSetFLock(pb, async) ((async) ? PBSetFLockAsync(pb) : PBSetFLockSync(pb))
; #define PBRstFLock(pb, async) ((async) ? PBRstFLockAsync(pb) : PBRstFLockSync(pb))
; #define PBSetFVers(pb, async) ((async) ? PBSetFVersAsync(pb) : PBSetFVersSync(pb))
; #define PBAllocate(pb, async) ((async) ? PBAllocateAsync(pb) : PBAllocateSync(pb))
; #define PBGetEOF(pb, async) ((async) ? PBGetEOFAsync(pb) : PBGetEOFSync(pb))
; #define PBSetEOF(pb, async) ((async) ? PBSetEOFAsync(pb) : PBSetEOFSync(pb))
; #define PBGetFPos(pb, async) ((async) ? PBGetFPosAsync(pb) : PBGetFPosSync(pb))
; #define PBSetFPos(pb, async) ((async) ? PBSetFPosAsync(pb) : PBSetFPosSync(pb))
; #define PBFlushFile(pb, async) ((async) ? PBFlushFileAsync(pb) : PBFlushFileSync(pb))
; #define PBCatSearch(pb, async) ((async) ? PBCatSearchAsync(pb) : PBCatSearchSync(pb))
; #define PBOpenWD(pb, async) ((async) ? PBOpenWDAsync(pb) : PBOpenWDSync(pb))
; #define PBCloseWD(pb, async) ((async) ? PBCloseWDAsync(pb) : PBCloseWDSync(pb))
; #define PBHSetVol(pb, async) ((async) ? PBHSetVolAsync(pb) : PBHSetVolSync(pb))
; #define PBHGetVol(pb, async) ((async) ? PBHGetVolAsync(pb) : PBHGetVolSync(pb))
; #define PBCatMove(pb, async) ((async) ? PBCatMoveAsync(pb) : PBCatMoveSync(pb))
; #define PBDirCreate(pb, async) ((async) ? PBDirCreateAsync(pb) : PBDirCreateSync(pb))
; #define PBGetWDInfo(pb, async) ((async) ? PBGetWDInfoAsync(pb) : PBGetWDInfoSync(pb))
; #define PBGetFCBInfo(pb, async) ((async) ? PBGetFCBInfoAsync(pb) : PBGetFCBInfoSync(pb))
; #define PBGetCatInfo(pb, async) ((async) ? PBGetCatInfoAsync(pb) : PBGetCatInfoSync(pb))
; #define PBSetCatInfo(pb, async) ((async) ? PBSetCatInfoAsync(pb) : PBSetCatInfoSync(pb))
; #define PBAllocContig(pb, async) ((async) ? PBAllocContigAsync(pb) : PBAllocContigSync(pb))
; #define PBLockRange(pb, async) ((async) ? PBLockRangeAsync(pb) : PBLockRangeSync(pb))
; #define PBUnlockRange(pb, async) ((async) ? PBUnlockRangeAsync(pb) : PBUnlockRangeSync(pb))
; #define PBSetVInfo(pb, async) ((async) ? PBSetVInfoAsync(pb) : PBSetVInfoSync(pb))
; #define PBHGetVInfo(pb, async) ((async) ? PBHGetVInfoAsync(pb) : PBHGetVInfoSync(pb))
; #define PBHOpen(pb, async) ((async) ? PBHOpenAsync(pb) : PBHOpenSync(pb))
; #define PBHOpenRF(pb, async) ((async) ? PBHOpenRFAsync(pb) : PBHOpenRFSync(pb))
; #define PBHOpenDF(pb, async) ((async) ? PBHOpenDFAsync(pb) : PBHOpenDFSync(pb))
; #define PBHCreate(pb, async) ((async) ? PBHCreateAsync(pb) : PBHCreateSync(pb))
; #define PBHDelete(pb, async) ((async) ? PBHDeleteAsync(pb) : PBHDeleteSync(pb))
; #define PBHRename(pb, async) ((async) ? PBHRenameAsync(pb) : PBHRenameSync(pb))
; #define PBHRstFLock(pb, async) ((async) ? PBHRstFLockAsync(pb) : PBHRstFLockSync(pb))
; #define PBHSetFLock(pb, async) ((async) ? PBHSetFLockAsync(pb) : PBHSetFLockSync(pb))
; #define PBHGetFInfo(pb, async) ((async) ? PBHGetFInfoAsync(pb) : PBHGetFInfoSync(pb))
; #define PBHSetFInfo(pb, async) ((async) ? PBHSetFInfoAsync(pb) : PBHSetFInfoSync(pb))
; #define PBMakeFSSpec(pb, async) ((async) ? PBMakeFSSpecAsync(pb) : PBMakeFSSpecSync(pb))
; #define PBHGetVolParms(pb, async) ((async) ? PBHGetVolParmsAsync(pb) : PBHGetVolParmsSync(pb))
; #define PBHGetLogInInfo(pb, async) ((async) ? PBHGetLogInInfoAsync(pb) : PBHGetLogInInfoSync(pb))
; #define PBHGetDirAccess(pb, async) ((async) ? PBHGetDirAccessAsync(pb) : PBHGetDirAccessSync(pb))
; #define PBHSetDirAccess(pb, async) ((async) ? PBHSetDirAccessAsync(pb) : PBHSetDirAccessSync(pb))
; #define PBHMapID(pb, async) ((async) ? PBHMapIDAsync(pb) : PBHMapIDSync(pb))
; #define PBHMapName(pb, async) ((async) ? PBHMapNameAsync(pb) : PBHMapNameSync(pb))
; #define PBHCopyFile(pb, async) ((async) ? PBHCopyFileAsync(pb) : PBHCopyFileSync(pb))
; #define PBHMoveRename(pb, async) ((async) ? PBHMoveRenameAsync(pb) : PBHMoveRenameSync(pb))
; #define PBHOpenDeny(pb, async) ((async) ? PBHOpenDenyAsync(pb) : PBHOpenDenySync(pb))
; #define PBHOpenRFDeny(pb, async) ((async) ? PBHOpenRFDenyAsync(pb) : PBHOpenRFDenySync(pb))
; #define PBExchangeFiles(pb, async) ((async) ? PBExchangeFilesAsync(pb) : PBExchangeFilesSync(pb))
; #define PBCreateFileIDRef(pb, async) ((async) ? PBCreateFileIDRefAsync(pb) : PBCreateFileIDRefSync(pb))
; #define PBResolveFileIDRef(pb, async) ((async) ? PBResolveFileIDRefAsync(pb) : PBResolveFileIDRefSync(pb))
; #define PBDeleteFileIDRef(pb, async) ((async) ? PBDeleteFileIDRefAsync(pb) : PBDeleteFileIDRefSync(pb))
; #define PBGetForeignPrivs(pb, async) ((async) ? PBGetForeignPrivsAsync(pb) : PBGetForeignPrivsSync(pb))
; #define PBSetForeignPrivs(pb, async) ((async) ? PBSetForeignPrivsAsync(pb) : PBSetForeignPrivsSync(pb))
; #define PBDTAddIcon(pb, async) ((async) ? PBDTAddIconAsync(pb) : PBDTAddIconSync(pb))
; #define PBDTGetIcon(pb, async) ((async) ? PBDTGetIconAsync(pb) : PBDTGetIconSync(pb))
; #define PBDTGetIconInfo(pb, async) ((async) ? PBDTGetIconInfoAsync(pb) : PBDTGetIconInfoSync(pb))
; #define PBDTAddAPPL(pb, async) ((async) ? PBDTAddAPPLAsync(pb) : PBDTAddAPPLSync(pb))
; #define PBDTRemoveAPPL(pb, async) ((async) ? PBDTRemoveAPPLAsync(pb) : PBDTRemoveAPPLSync(pb))
; #define PBDTGetAPPL(pb, async) ((async) ? PBDTGetAPPLAsync(pb) : PBDTGetAPPLSync(pb))
; #define PBDTSetComment(pb, async) ((async) ? PBDTSetCommentAsync(pb) : PBDTSetCommentSync(pb))
; #define PBDTRemoveComment(pb, async) ((async) ? PBDTRemoveCommentAsync(pb) : PBDTRemoveCommentSync(pb))
; #define PBDTGetComment(pb, async) ((async) ? PBDTGetCommentAsync(pb) : PBDTGetCommentSync(pb))
; #define PBDTFlush(pb, async) ((async) ? PBDTFlushAsync(pb) : PBDTFlushSync(pb))
; #define PBDTReset(pb, async) ((async) ? PBDTResetAsync(pb) : PBDTResetSync(pb))
; #define PBDTGetInfo(pb, async) ((async) ? PBDTGetInfoAsync(pb) : PBDTGetInfoSync(pb))
; #define PBDTDelete(pb, async) ((async) ? PBDTDeleteAsync(pb) : PBDTDeleteSync(pb))

(def-mactype :FSVolumeRefNum (find-mactype ':SInt16))

(defconstant $kFSInvalidVolumeRefNum 0)
(defrecord FSRef
   (hidden (:array :UInt8 80))                  ;  private to File Manager; ¥¥ need symbolic constant 
)

;type name? (%define-record :FSRef (find-record-descriptor ':FSRef))

(def-mactype :FSRefPtr (find-mactype '(:pointer :FSRef)))
; 
;  *  FSPermissionInfo
;  *  
;  *  Discussion:
;  *    This structure is used when kFSCatInfoPermissions is passed to
;  *    the HFSPlus API. On return from GetCatalogInfo and
;  *    GetCatalogInfoBulk, the userID, groupID, and mode fields are
;  *    returned.  When passed to SetCatalogInfo, only the mode field is
;  *    set.  See chmod(2) for details about the mode field. This is
;  *    supported on Mac OS X only.
;  
(defrecord FSPermissionInfo
   (userID :UInt32)
   (groupID :UInt32)
   (reserved1 :UInt8)
   (userAccess :UInt8)
   (mode :UInt16)
   (reserved2 :UInt32)
)

;type name? (%define-record :FSPermissionInfo (find-record-descriptor ':FSPermissionInfo))
;   CatalogInfoBitmap describes which fields of the CatalogInfo you wish to get or set.

(def-mactype :FSCatalogInfoBitmap (find-mactype ':UInt32))

(defconstant $kFSCatInfoNone 0)
(defconstant $kFSCatInfoTextEncoding 1)
(defconstant $kFSCatInfoNodeFlags 2)            ;  Locked (bit 0) and directory (bit 4) only 

(defconstant $kFSCatInfoVolume 4)
(defconstant $kFSCatInfoParentDirID 8)
(defconstant $kFSCatInfoNodeID 16)
(defconstant $kFSCatInfoCreateDate 32)
(defconstant $kFSCatInfoContentMod 64)
(defconstant $kFSCatInfoAttrMod #x80)
(defconstant $kFSCatInfoAccessDate #x100)
(defconstant $kFSCatInfoBackupDate #x200)
(defconstant $kFSCatInfoPermissions #x400)
(defconstant $kFSCatInfoFinderInfo #x800)
(defconstant $kFSCatInfoFinderXInfo #x1000)
(defconstant $kFSCatInfoValence #x2000)         ;  Folders only, zero for files 

(defconstant $kFSCatInfoDataSizes #x4000)       ;  Data fork logical and physical size 

(defconstant $kFSCatInfoRsrcSizes #x8000)       ;  Resource fork logical and physical size 

(defconstant $kFSCatInfoSharingFlags #x10000)   ;  sharingFlags: kioFlAttribMountedBit, kioFlAttribSharePointBit 

(defconstant $kFSCatInfoUserPrivs #x20000)      ;  userPrivileges 

(defconstant $kFSCatInfoUserAccess #x80000)     ;  (OS X only) 

(defconstant $kFSCatInfoSetOwnership #x100000)  ;  (OS X only) 

(defconstant $kFSCatInfoAllDates #x3E0)
(defconstant $kFSCatInfoGettableInfo #x3FFFF)
(defconstant $kFSCatInfoSettableInfo #x1FE3)    ;  flags, dates, permissions, Finder info, text encoding 
;  bits that are currently reserved 

(defconstant $kFSCatInfoReserved #xFFFC0000)
;   Constants for nodeFlags field of FSCatalogInfo 

(defconstant $kFSNodeLockedBit 0)               ;  Set if file or directory is locked 

(defconstant $kFSNodeLockedMask 1)
(defconstant $kFSNodeResOpenBit 2)              ;  Set if the resource fork is open 

(defconstant $kFSNodeResOpenMask 4)
(defconstant $kFSNodeDataOpenBit 3)             ;  Set if the data fork is open 

(defconstant $kFSNodeDataOpenMask 8)
(defconstant $kFSNodeIsDirectoryBit 4)          ;  Set if the object is a directory 

(defconstant $kFSNodeIsDirectoryMask 16)
(defconstant $kFSNodeCopyProtectBit 6)
(defconstant $kFSNodeCopyProtectMask 64)
(defconstant $kFSNodeForkOpenBit 7)             ;  Set if the file or directory has any open fork 

(defconstant $kFSNodeForkOpenMask #x80)
(defconstant $kFSNodeHardLinkBit 8)             ;  Set if the file is a hard link 

(defconstant $kFSNodeHardLinkMask #x100)
;   Constants for sharingFlags field of FSCatalogInfo 

(defconstant $kFSNodeInSharedBit 2)             ;  Set if a directory is within a share point 

(defconstant $kFSNodeInSharedMask 4)
(defconstant $kFSNodeIsMountedBit 3)            ;  Set if a directory is a share point currently mounted by some user 

(defconstant $kFSNodeIsMountedMask 8)
(defconstant $kFSNodeIsSharePointBit 5)         ;  Set if a directory is a share point (exported volume) 

(defconstant $kFSNodeIsSharePointMask 32)
(defrecord FSCatalogInfo
   (nodeFlags :UInt16)                          ;  node flags 
   (volume :SInt16)                             ;  object's volume ref 
   (parentDirID :UInt32)                        ;  parent directory's ID 
   (nodeID :UInt32)                             ;  file/directory ID 
   (sharingFlags :UInt8)                        ;  kioFlAttribMountedBit and kioFlAttribSharePointBit 
   (userPrivileges :UInt8)                      ;  user's effective AFP privileges (same as ioACUser) 
   (reserved1 :UInt8)
   (reserved2 :UInt8)
   (createDate :UTCDateTime)                    ;  date and time of creation 
   (contentModDate :UTCDateTime)                ;  date and time of last fork modification 
   (attributeModDate :UTCDateTime)              ;  date and time of last attribute modification 
   (accessDate :UTCDateTime)                    ;  date and time of last access (for Mac OS X) 
   (backupDate :UTCDateTime)                    ;  date and time of last backup 
   (permissions (:array :UInt32 4))             ;  permissions (for Mac OS X) 
   (finderInfo (:array :UInt8 16))              ;  Finder information part 1 
   (extFinderInfo (:array :UInt8 16))           ;  Finder information part 2 
   (dataLogicalSize :UInt64)                    ;  files only 
   (dataPhysicalSize :UInt64)                   ;  files only 
   (rsrcLogicalSize :UInt64)                    ;  files only 
   (rsrcPhysicalSize :UInt64)                   ;  files only 
   (valence :UInt32)                            ;  folders only 
   (textEncodingHint :UInt32)
)

;type name? (%define-record :FSCatalogInfo (find-record-descriptor ':FSCatalogInfo))

(def-mactype :FSCatalogInfoPtr (find-mactype '(:pointer :FSCatalogInfo)))
(defrecord FSRefParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ; ptr to Vol:FileName string
   (ioVRefNum :SInt16)                          ; volume refnum (DrvNum for Eject and MountVol)
   (reserved1 :SInt16)                          ;  was ioRefNum 
   (reserved2 :UInt8)                           ;  was ioVersNum 
   (reserved3 :UInt8)                           ;  was ioPermssn 
   (ref (:pointer :FSRef))                      ;  Input ref; the target of the call 
   (whichInfo :UInt32)
   (catInfo (:pointer :FSCatalogInfo))
   (nameLength :UInt32)                         ;  input name length for create/rename 
   (name (:pointer :UniChar))                   ;  input name for create/rename 
   (ioDirID :signed-long)
   (spec (:pointer :FSSpec))
   (parentRef (:pointer :FSRef))                ;  ref of directory to move another ref to 
   (newRef (:pointer :FSRef))                   ;  Output ref 
   (textEncodingHint :UInt32)                   ;  for Rename, MakeFSRefUnicode 
   (outName (:pointer :HFSUniStr255))           ;  Output name for GetCatalogInfo 
)

;type name? (%define-record :FSRefParam (find-record-descriptor ':FSRefParam))

(def-mactype :FSRefParamPtr (find-mactype '(:pointer :FSRefParam)))

(def-mactype :FSIterator (find-mactype '(:pointer :OpaqueFSIterator)))

(defconstant $kFSIterateFlat 0)                 ;  Immediate children of container only 

(defconstant $kFSIterateSubtree 1)              ;  Entire subtree rooted at container 

(defconstant $kFSIterateDelete 2)
(defconstant $kFSIterateReserved #xFFFFFFFC)

(def-mactype :FSIteratorFlags (find-mactype ':UInt32))
(defrecord FSSearchParams
   (searchTime :SInt32)                         ;  a Time Manager duration 
   (searchBits :UInt32)                         ;  which fields to search on 
   (searchNameLength :UInt32)
   (searchName (:pointer :UniChar))
   (searchInfo1 (:pointer :FSCatalogInfo))      ;  values and lower bounds 
   (searchInfo2 (:pointer :FSCatalogInfo))      ;  masks and upper bounds 
)

;type name? (%define-record :FSSearchParams (find-record-descriptor ':FSSearchParams))

(def-mactype :FSSearchParamsPtr (find-mactype '(:pointer :FSSearchParams)))
(defrecord FSCatalogBulkParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (containerChanged :Boolean)                  ;  true if container changed since last iteration 
   (reserved :UInt8)                            ;  make following fields 4-byte aligned 
   (iteratorFlags :UInt32)
   (iterator (:pointer :OpaqueFSIterator))
   (container (:pointer :FSRef))                ;  directory/volume to iterate 
   (maximumItems :UInt32)
   (actualItems :UInt32)
   (whichInfo :UInt32)
   (catalogInfo (:pointer :FSCatalogInfo))      ;  returns an array 
   (refs (:pointer :FSRef))                     ;  returns an array 
   (specs (:pointer :FSSpec))                   ;  returns an array 
   (names (:pointer :HFSUniStr255))             ;  returns an array 
   (searchParams (:pointer :FSSearchParams))
)

;type name? (%define-record :FSCatalogBulkParam (find-record-descriptor ':FSCatalogBulkParam))

(def-mactype :FSCatalogBulkParamPtr (find-mactype '(:pointer :FSCatalogBulkParam)))

(def-mactype :FSAllocationFlags (find-mactype ':UInt16))

(defconstant $kFSAllocDefaultFlags 0)           ;  as much as possible, not contiguous 

(defconstant $kFSAllocAllOrNothingMask 1)       ;  allocate all of the space, or nothing 

(defconstant $kFSAllocContiguousMask 2)         ;  new space must be one contiguous piece 

(defconstant $kFSAllocNoRoundUpMask 4)          ;  don't round up allocation to clump size 

(defconstant $kFSAllocReservedMask #xFFF8)      ;  these bits are reserved and must not be set 

(defrecord FSForkIOParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (reserved1 :pointer)                         ;  was ioNamePtr 
   (reserved2 :SInt16)                          ;  was ioVRefNum 
   (forkRefNum :SInt16)                         ;  same as ioRefNum 
   (reserved3 :UInt8)                           ;  was ioVersNum 
   (permissions :SInt8)                         ;  desired access to the fork 
   (ref (:pointer :FSRef))                      ;  which object to open 
   (buffer :pointer)                            ; data buffer Ptr
   (requestCount :UInt32)                       ; requested byte count
   (actualCount :UInt32)                        ; actual byte count completed
   (positionMode :UInt16)                       ; initial file positioning
   (positionOffset :SInt64)                     ; file position offset
   (allocationFlags :UInt16)
   (allocationAmount :UInt64)
   (forkNameLength :UInt32)                     ;  input; length of fork name 
   (forkName (:pointer :UniChar))               ;  input; name of fork 
   (forkIterator :CatPositionRec)
   (outForkName (:pointer :HFSUniStr255))       ;  output; name of fork 
)

;type name? (%define-record :FSForkIOParam (find-record-descriptor ':FSForkIOParam))

(def-mactype :FSForkIOParamPtr (find-mactype '(:pointer :FSForkIOParam)))
(defrecord FSForkInfo
   (flags :SInt8)                               ;  copy of FCB flags 
   (permissions :SInt8)
   (volume :SInt16)
   (reserved2 :UInt32)
   (nodeID :UInt32)                             ;  file or directory ID 
   (forkID :UInt32)                             ;  fork ID 
   (currentPosition :UInt64)
   (logicalEOF :UInt64)
   (physicalEOF :UInt64)
   (process :UInt64)                            ;  should be ProcessSerialNumber 
)

;type name? (%define-record :FSForkInfo (find-record-descriptor ':FSForkInfo))

(def-mactype :FSForkInfoPtr (find-mactype '(:pointer :FSForkInfo)))
(defrecord FSForkCBInfoParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (desiredRefNum :SInt16)                      ;  0 to iterate, non-0 for specific refnum 
   (volumeRefNum :SInt16)                       ;  volume to match, or 0 for all volumes 
   (iterator :SInt16)                           ;  0 to start iteration 
   (actualRefNum :SInt16)                       ;  actual refnum found 
   (ref (:pointer :FSRef))
   (forkInfo (:pointer :FSForkInfo))
   (forkName (:pointer :HFSUniStr255))
)

;type name? (%define-record :FSForkCBInfoParam (find-record-descriptor ':FSForkCBInfoParam))

(def-mactype :FSForkCBInfoParamPtr (find-mactype '(:pointer :FSForkCBInfoParam)))

(def-mactype :FSVolumeInfoBitmap (find-mactype ':UInt32))

(defconstant $kFSVolInfoNone 0)
(defconstant $kFSVolInfoCreateDate 1)
(defconstant $kFSVolInfoModDate 2)
(defconstant $kFSVolInfoBackupDate 4)
(defconstant $kFSVolInfoCheckedDate 8)
(defconstant $kFSVolInfoFileCount 16)
(defconstant $kFSVolInfoDirCount 32)
(defconstant $kFSVolInfoSizes 64)               ;  totalBytes and freeBytes 

(defconstant $kFSVolInfoBlocks #x80)            ;  blockSize, totalBlocks, freeBlocks 

(defconstant $kFSVolInfoNextAlloc #x100)
(defconstant $kFSVolInfoRsrcClump #x200)
(defconstant $kFSVolInfoDataClump #x400)
(defconstant $kFSVolInfoNextID #x800)
(defconstant $kFSVolInfoFinderInfo #x1000)
(defconstant $kFSVolInfoFlags #x2000)
(defconstant $kFSVolInfoFSInfo #x4000)          ;  filesystemID, signature 

(defconstant $kFSVolInfoDriveInfo #x8000)       ;  driveNumber, driverRefNum 

(defconstant $kFSVolInfoGettableInfo #xFFFF)    ;  This seems like it is here just for completeness 

(defconstant $kFSVolInfoSettableInfo #x3004)    ;  backup date, Finder info, flags 

;  FSVolumeInfo.flags bits.  These are the same as for ioVAtrb, but with nicer names. 

(defconstant $kFSVolFlagDefaultVolumeBit 5)     ;  Set if the volume is the default volume 

(defconstant $kFSVolFlagDefaultVolumeMask 32)
(defconstant $kFSVolFlagFilesOpenBit 6)         ;  Set if there are open files or iterators 

(defconstant $kFSVolFlagFilesOpenMask 64)
(defconstant $kFSVolFlagHardwareLockedBit 7)    ;  Set if volume is locked by a hardware setting 

(defconstant $kFSVolFlagHardwareLockedMask #x80)
(defconstant $kFSVolFlagJournalingActiveBit 14) ;  Set if journaling is active on volume 

(defconstant $kFSVolFlagJournalingActiveMask #x4000)
(defconstant $kFSVolFlagSoftwareLockedBit 15)   ;  Set if volume is locked by software 

(defconstant $kFSVolFlagSoftwareLockedMask #x8000)
(defrecord FSVolumeInfo
                                                ;  Dates -- zero means "never" or "unknown" 
   (createDate :UTCDateTime)
   (modifyDate :UTCDateTime)
   (backupDate :UTCDateTime)
   (checkedDate :UTCDateTime)
                                                ;  File/Folder counts -- return zero if unknown 
   (fileCount :UInt32)                          ;  total files on volume 
   (folderCount :UInt32)                        ;  total folders on volume 
                                                ;  Note: no root directory counts 
   (totalBytes :UInt64)                         ;  total number of bytes on volume 
   (freeBytes :UInt64)                          ;  number of free bytes on volume 
                                                ;  HFS and HFS Plus specific.  Set fields to zero if not appropriate 
   (blockSize :UInt32)                          ;  size (in bytes) of allocation blocks 
   (totalBlocks :UInt32)                        ;  number of allocation blocks in volume 
   (freeBlocks :UInt32)                         ;  number of unused allocation blocks 
   (nextAllocation :UInt32)                     ;  start of next allocation search 
   (rsrcClumpSize :UInt32)                      ;  default resource fork clump size 
   (dataClumpSize :UInt32)                      ;  default data fork clump size 
   (nextCatalogID :UInt32)                      ;  next unused catalog node ID ¥¥¥ OYG ¥¥¥ need to make HFSVolumes.h work Should be HFSCatalogNodeID
   (finderInfo (:array :UInt8 32))              ;  information used by Finder 
                                                ;  Identifying information 
   (flags :UInt16)                              ;  ioVAtrb 
   (filesystemID :UInt16)                       ;  ioVFSID 
   (signature :UInt16)                          ;  ioVSigWord, unique within an FSID 
   (driveNumber :UInt16)                        ;  ioVDrvInfo 
   (driverRefNum :SInt16)                       ;  ioVDRefNum 
)

;type name? (%define-record :FSVolumeInfo (find-record-descriptor ':FSVolumeInfo))

(def-mactype :FSVolumeInfoPtr (find-mactype '(:pointer :FSVolumeInfo)))
(defrecord FSVolumeInfoParam
   (qLink (:pointer :QElem))                    ; queue link in header
   (qType :SInt16)                              ; type byte for safety check
   (ioTrap :SInt16)                             ; FS: the Trap
   (ioCmdAddr :pointer)                         ; FS: address to dispatch to
   (ioCompletion (:pointer :OpaqueIOCompletionProcPtr)); completion routine addr (0 for synch calls)
   (ioResult :SInt16)                           ; result code
   (ioNamePtr (:pointer :UInt8))                ;  unused 
   (ioVRefNum :SInt16)                          ;  volume refnum 
   (volumeIndex :UInt32)                        ;  index, or 0 to use ioVRefNum 
   (whichInfo :UInt32)                          ;  which volumeInfo fields to get/set 
   (volumeInfo (:pointer :FSVolumeInfo))        ;  information about the volume 
   (volumeName (:pointer :HFSUniStr255))        ;  output; pointer to volume name 
   (ref (:pointer :FSRef))                      ;  volume's FSRef 
)

;type name? (%define-record :FSVolumeInfoParam (find-record-descriptor ':FSVolumeInfoParam))

(def-mactype :FSVolumeInfoParamPtr (find-mactype '(:pointer :FSVolumeInfoParam)))
; 
;     MakeFSRef
;     Create an FSRef for an existing object specified by a combination
;     of volume refnum, parent directory, and pathname.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ioNamePtr       A pointer to a pathname
;     ->  ioVRefNum       A volume specification
;     ->  ioDirID         A directory ID
;     <-  newRef          A pointer to an FSRef
; 
; 
;  *  FSpMakeFSRef()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSpMakeFSRef" 
   ((source (:pointer :FSSpec))
    (newRef (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBMakeFSRefSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBMakeFSRefSync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBMakeFSRefAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBMakeFSRefAsync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     MakeFSRefUnicode
;     Create an FSRef for an existing object specified by 
;     Parent FSRef and Unicode name.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ref             A pointer to the parent directory FSRef
;     ->  name            A pointer to Unicde name
;     ->  nameLength      The length of the Unicode Name
;     ->  textEncodingHint A suggested text encoding to use for the name
;     <-  newRef          A pointer to an FSRef
; 
; 
;  *  FSMakeFSRefUnicode()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSMakeFSRefUnicode" 
   ((parentRef (:pointer :FSRef))
    (nameLength :UInt32)
    (name (:pointer :UniChar))
    (textEncodingHint :UInt32)
    (newRef (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBMakeFSRefUnicodeSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBMakeFSRefUnicodeSync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBMakeFSRefUnicodeAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBMakeFSRefUnicodeAsync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     CompareFSRefs
;     Test whether two FSRefs refer to the same file or directory.
;     If they do, noErr is returned.  Otherwise, an appropriate error
;     (such as errFSRefsDifferent) is returned.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ref             A pointer to the first FSRef
;     ->  parentRef       A pointer to the second FSRef
; 
; 
;  *  FSCompareFSRefs()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSCompareFSRefs" 
   ((ref1 (:pointer :FSRef))
    (ref2 (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCompareFSRefsSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCompareFSRefsSync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCompareFSRefsAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCompareFSRefsAsync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     CreateFileUnicode
;     Creates a new file.  The input filename is in Unicode.
;     You can optionally set catalog info for the file.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ref             The directory where the file is to be created
;     ->  whichInfo       Which catalog info fields to set
;     ->  catInfo         The values for catalog info fields to set; may be NULL
;     ->  nameLength      Number of Unicode characters in the file's name
;     ->  name            A pointer to the Unicode name
;     <-  spec            A pointer to the FSSpec for the new directory; may be NULL
;     <-  newRef          A pointer to the FSRef for the new file; may be NULL
; 
; 
;  *  FSCreateFileUnicode()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSCreateFileUnicode" 
   ((parentRef (:pointer :FSRef))
    (nameLength :UInt32)
    (name (:pointer :UniChar))
    (whichInfo :UInt32)
    (catalogInfo (:pointer :FSCatalogInfo))     ;  can be NULL 
    (newRef (:pointer :FSRef))                  ;  can be NULL 
    (newSpec (:pointer :FSSpec))                ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCreateFileUnicodeSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCreateFileUnicodeSync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCreateFileUnicodeAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCreateFileUnicodeAsync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     CreateDirectoryUnicode
;     Creates a new directory.  The input directory name is in Unicode.
;     You can optionally set catalog info for the directory.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ref             The parent directory where the directory is to be created
;     ->  whichInfo       Which catalog info fields to set
;     ->  catInfo         The values for catalog info fields to set; may be NULL
;     ->  nameLength      Number of Unicode characters in the directory's name
;     ->  name            A pointer to the Unicode name
;     <-  ioDirID         The DirID of the new directory
;     <-  spec            A pointer to the FSSpec for the new directory; may be NULL
;     <-  newRef          A pointer to the FSRef for the new directory; may be NULL
; 
; 
;  *  FSCreateDirectoryUnicode()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSCreateDirectoryUnicode" 
   ((parentRef (:pointer :FSRef))
    (nameLength :UInt32)
    (name (:pointer :UniChar))
    (whichInfo :UInt32)
    (catalogInfo (:pointer :FSCatalogInfo))     ;  can be NULL 
    (newRef (:pointer :FSRef))                  ;  can be NULL 
    (newSpec (:pointer :FSSpec))                ;  can be NULL 
    (newDirID (:pointer :UInt32))               ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCreateDirectoryUnicodeSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCreateDirectoryUnicodeSync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCreateDirectoryUnicodeAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCreateDirectoryUnicodeAsync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     DeleteObject
;     Deletes an existing file or directory.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ref             The file or directory to be deleted
; 
; 
;  *  FSDeleteObject()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSDeleteObject" 
   ((ref (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDeleteObjectSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBDeleteObjectSync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDeleteObjectAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBDeleteObjectAsync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     MoveObject
;     Move an existing file or directory into a different directory.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ref             The file or directory to be moved
;     ->  parentRef       The file or directory will be moved into this directory
;     <-  newRef          A new FSRef for the file or directory in its new location;
;                         optional, may be NULL
;     NOTE: Moving an object may change its FSRef.  If you want to continue to
;     refer to the object, you should pass a non-NULL pointer in newRef and use
;     that returned FSRef to access the object after the move.  The FSRef passed
;     in "ref" may or may not be usable to access the object after it is moved.
;     "newRef" may point to the same storage as "parentRef" or "ref".
; 
; 
;  *  FSMoveObject()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSMoveObject" 
   ((ref (:pointer :FSRef))
    (destDirectory (:pointer :FSRef))
    (newRef (:pointer :FSRef))                  ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBMoveObjectSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBMoveObjectSync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBMoveObjectAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBMoveObjectAsync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     ExchangeObjects
;     swap the contents of two files.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ref             The first file 
;     ->  parentRef       The second file 
; 
; 
;  *  FSExchangeObjects()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSExchangeObjects" 
   ((ref (:pointer :FSRef))
    (destRef (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBExchangeObjectsSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBExchangeObjectsSync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBExchangeObjectsAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBExchangeObjectsAsync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     RenameUnicode
;     Change the name of an existing file or directory.  The new name is in
;     Unicode.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ref             The file or directory to be moved
;     ->  nameLength      Number of Unicode characters in the new name
;     ->  name            A pointer to the new Unicode name
;     ->  textEncodingHint A suggested text encoding to use for the name
;     <-  newRef          A new FSRef for the file or directory; may be NULL
;     NOTE: Renaming an object may change its FSRef.  If you want to continue to
;     refer to the object, you should pass a non-NULL pointer in newRef and use
;     that returned FSRef to access the object after the rename.  The FSRef passed
;     in "ref" may or may not be usable to access the object after it is renamed.
;     "newRef" may point to the same storage as "ref".
; 
; 
;  *  FSRenameUnicode()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSRenameUnicode" 
   ((ref (:pointer :FSRef))
    (nameLength :UInt32)
    (name (:pointer :UniChar))
    (textEncodingHint :UInt32)
    (newRef (:pointer :FSRef))                  ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBRenameUnicodeSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBRenameUnicodeSync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBRenameUnicodeAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBRenameUnicodeAsync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     GetCatalogInfo
;     Returns various information about a given file or directory.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ref             The file or directory whose information is to be returned
;     ->  whichInfo       Which catalog info fields to get
;     <-  catInfo         The returned values of catalog info fields; may be NULL
;     <-  spec            A pointer to the FSSpec for the object; may be NULL
;     <-  parentRef       A pointer to the FSRef for the object's parent directory; may be NULL
;     <-  outName         The Unicode name is returned here.  This pointer may be NULL.
;     Note: All of the outputs are optional; if you don't want that particular output, just
;     set its pointer to NULL.  This is the call to use to map from an FSRef to an FSSpec.
; 
; 
;  *  FSGetCatalogInfo()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSGetCatalogInfo" 
   ((ref (:pointer :FSRef))
    (whichInfo :UInt32)
    (catalogInfo (:pointer :FSCatalogInfo))     ;  can be NULL 
    (outName (:pointer :HFSUniStr255))          ;  can be NULL 
    (fsSpec (:pointer :FSSpec))                 ;  can be NULL 
    (parentRef (:pointer :FSRef))               ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetCatalogInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBGetCatalogInfoSync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetCatalogInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBGetCatalogInfoAsync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     SetCatalogInfo
;     Set catalog information about a given file or directory.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ref             The file or directory whose information is to be changed
;     ->  whichInfo       Which catalog info fields to set
;     ->  catInfo         The new values of catalog info fields
;     Note: Only some of the catalog info fields may be set.  The settable fields
;     are given by the constant kFSCatInfoSettableInfo; no other bits may be set in
;     whichInfo.
; 
; 
;  *  FSSetCatalogInfo()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSSetCatalogInfo" 
   ((ref (:pointer :FSRef))
    (whichInfo :UInt32)
    (catalogInfo (:pointer :FSCatalogInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetCatalogInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBSetCatalogInfoSync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetCatalogInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBSetCatalogInfoAsync" 
   ((paramBlock (:pointer :FSRefParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     OpenIterator
;     Creates an FSIterator to iterate over a directory or subtree.  The
;     iterator can then be passed to GetCatalogInfoBulk or CatalogSearch.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     <-  iterator        The returned FSIterator
;     ->  iteratorFlags   Controls whether the iterator iterates over subtrees
;                         or just the immediate children of the container.
;     ->  container       An FSRef for the directory to iterate (or root of
;                         the subtree to iterate).
; 
; 
;  *  FSOpenIterator()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSOpenIterator" 
   ((container (:pointer :FSRef))
    (iteratorFlags :UInt32)
    (iterator (:pointer :FSITERATOR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBOpenIteratorSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBOpenIteratorSync" 
   ((paramBlock (:pointer :FSCatalogBulkParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBOpenIteratorAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBOpenIteratorAsync" 
   ((paramBlock (:pointer :FSCatalogBulkParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     CloseIterator
;     Invalidates and disposes an FSIterator.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  iterator        The returned FSIterator
; 
; 
;  *  FSCloseIterator()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSCloseIterator" 
   ((iterator (:pointer :OpaqueFSIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCloseIteratorSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCloseIteratorSync" 
   ((paramBlock (:pointer :FSCatalogBulkParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCloseIteratorAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCloseIteratorAsync" 
   ((paramBlock (:pointer :FSCatalogBulkParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     GetCatalogInfoBulk
;     Iterates over catalog objects and returns information about them.
;     For now, iterator must have been created with kFSIterateFlat option.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  iterator        The iterator
;     ->  maximumItems    The maximum number of items to return
;     <-  actualItems     The actual number of items returned
;     <-  containerChanged Set to true if the container's contents changed
;     ->  whichInfo       The catalog information fields to return for each item
;     <-  catalogInfo     An array of catalog information; one for each returned item
;     <-  refs            An array of FSRefs; one for each returned item
;     <-  specs           An array of FSSpecs; one for each returned item
;     <-  names           An array of filenames; one for each returned item
;     Note: The catalogInfo, refs, specs, names, and containerChanged are all optional outputs;
;     if you don't want that particular output, set its pointer to NULL.
; 
; 
;  *  FSGetCatalogInfoBulk()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSGetCatalogInfoBulk" 
   ((iterator (:pointer :OpaqueFSIterator))
    (maximumObjects :UInt32)
    (actualObjects (:pointer :ITEMCOUNT))
    (containerChanged (:pointer :Boolean))      ;  can be NULL 
    (whichInfo :UInt32)
    (catalogInfos (:pointer :FSCatalogInfo))    ;  can be NULL 
    (refs (:pointer :FSRef))                    ;  can be NULL 
    (specs (:pointer :FSSpec))                  ;  can be NULL 
    (names (:pointer :HFSUniStr255))            ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetCatalogInfoBulkSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBGetCatalogInfoBulkSync" 
   ((paramBlock (:pointer :FSCatalogBulkParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetCatalogInfoBulkAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBGetCatalogInfoBulkAsync" 
   ((paramBlock (:pointer :FSCatalogBulkParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     CatalogSearch
;     Iterates over catalog objects, searching for objects that match given
;     search criteria.  Returns various information about matching objects.
;     For now, iterator must have been created with kFSIterateSubtree option
;     and the container must have been the root directory of a volume.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  iterator        The iterator
;     ->  maximumItems    The maximum number of items to return
;     <-  actualItems     The actual number of items returned
;     <-  containerChanged Set to true if the container's contents changed
;     ->  whichInfo       The catalog information fields to return for each item
;     <-  catalogInfo     An array of catalog information; one for each returned item
;     <-  refs            An array of FSRefs; one for each returned item
;     <-  specs           An array of FSSpecs; one for each returned item
;     <-  names           An array of filenames; one for each returned item
;     ->  searchParams    The criteria that controls the matching, including timeout, a bitmap
;                         controlling the fields to compare, and the (Unicode) name to compare.
;     Note: The catalogInfo, refs, specs, and names are all optional outputs; if you don't want
;     that particular output, set its pointer to NULL.
; 
; 
;  *  FSCatalogSearch()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSCatalogSearch" 
   ((iterator (:pointer :OpaqueFSIterator))
    (searchCriteria (:pointer :FSSearchParams))
    (maximumObjects :UInt32)
    (actualObjects (:pointer :ITEMCOUNT))
    (containerChanged (:pointer :Boolean))      ;  can be NULL 
    (whichInfo :UInt32)
    (catalogInfos (:pointer :FSCatalogInfo))    ;  can be NULL 
    (refs (:pointer :FSRef))                    ;  can be NULL 
    (specs (:pointer :FSSpec))                  ;  can be NULL 
    (names (:pointer :HFSUniStr255))            ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCatalogSearchSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCatalogSearchSync" 
   ((paramBlock (:pointer :FSCatalogBulkParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCatalogSearchAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCatalogSearchAsync" 
   ((paramBlock (:pointer :FSCatalogBulkParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     CreateFork
;     Create a named fork for a file or directory.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ref             The file or directory
;     ->  forkNameLength  The length of the fork name (in Unicode characters)
;     ->  forkName        The name of the fork to open (in Unicode)
; 
; 
;  *  FSCreateFork()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSCreateFork" 
   ((ref (:pointer :FSRef))
    (forkNameLength :UInt32)
    (forkName (:pointer :UniChar))              ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCreateForkSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCreateForkSync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCreateForkAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCreateForkAsync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     DeleteFork
;     Delete a named fork of a file or directory.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ref             The file or directory
;     ->  forkNameLength  The length of the fork name (in Unicode characters)
;     ->  forkName        The name of the fork to open (in Unicode)
; 
; 
;  *  FSDeleteFork()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSDeleteFork" 
   ((ref (:pointer :FSRef))
    (forkNameLength :UInt32)
    (forkName (:pointer :UniChar))              ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDeleteForkSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBDeleteForkSync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBDeleteForkAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBDeleteForkAsync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     IterateForks
;     Return the names and sizes of the forks of a file or directory.
;     One fork is returned per call.
;     ->  ioCompletion    A pointer to a completion routine.
;     <-  ioResult        The result code of the function.
;     ->  ref             The file or directory containing the forks.
;     <-  positionOffset  The length of the fork, in bytes.
;     <-  allocationAmount The space allocated to the fork (physical length).
;     <-  outForkName     The name of the fork in Unicode.
;     <>  forkIterator    Maintains state between calls for a given FSRef.
;                         Before the first call, set the initialize field to zero.
; 
; 
;  *  FSIterateForks()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSIterateForks" 
   ((ref (:pointer :FSRef))
    (forkIterator (:pointer :CatPositionRec))
    (forkName (:pointer :HFSUniStr255))         ;  can be NULL 
    (forkSize (:pointer :SInt64))               ;  can be NULL 
    (forkPhysicalSize (:pointer :UInt64))       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBIterateForksSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBIterateForksSync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBIterateForksAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBIterateForksAsync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     OpenFork
;     Open a fork for reading and/or writing.  Allows the opened fork
;     to grow beyond 2GB in size.  All volumes should support data and
;     resource forks.  Other named forks may be supported by some
;     volumes.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ref             The file or directory containing the fork to open
;     ->  forkNameLength  The length of the fork name (in Unicode characters)
;     ->  forkName        The name of the fork to open (in Unicode)
;     ->  permissions     The access (read and/or write) you want
;     <-  forkRefNum      The reference number for accessing the open fork
; 
; 
;  *  FSOpenFork()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSOpenFork" 
   ((ref (:pointer :FSRef))
    (forkNameLength :UInt32)
    (forkName (:pointer :UniChar))              ;  can be NULL 
    (permissions :SInt8)
    (forkRefNum (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBOpenForkSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBOpenForkSync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBOpenForkAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBOpenForkAsync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     ReadFork
;     Read data from a fork opened via OpenFork.  The first byte to read is
;     indicated by a combination of positionMode and positionOffset.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  forkRefNum      The reference number of the fork to read from
;     <-  buffer          Pointer to buffer where data will be returned
;     ->  requestCount    The number of bytes to read
;     <-  actualCount     The number of bytes actually read
;     ->  positionMode    The base location for start of read
;     ->  positionOffset  The offset from base location for start of read
; 
; 
;  *  FSReadFork()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSReadFork" 
   ((forkRefNum :SInt16)
    (positionMode :UInt16)
    (positionOffset :SInt64)
    (requestCount :UInt32)
    (buffer :pointer)
    (actualCount (:pointer :BYTECOUNT))         ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBReadForkSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBReadForkSync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBReadForkAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBReadForkAsync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     WriteFork
;     Write data to a fork opened via OpenFork.  The first byte to write is
;     indicated by a combination of positionMode and positionOffset.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  forkRefNum      The reference number of the fork to write to
;     ->  buffer          Pointer to data to write
;     ->  requestCount    The number of bytes to write
;     <-  actualCount     The number of bytes actually written
;     ->  positionMode    The base location for start of write
;     ->  positionOffset  The offset from base location for start of write
; 
; 
;  *  FSWriteFork()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSWriteFork" 
   ((forkRefNum :SInt16)
    (positionMode :UInt16)
    (positionOffset :SInt64)
    (requestCount :UInt32)
    (buffer :pointer)
    (actualCount (:pointer :BYTECOUNT))         ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBWriteForkSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBWriteForkSync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBWriteForkAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBWriteForkAsync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     GetForkPosition
;     Get the current (default) position of a fork that was
;     opened via OpenFork.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  forkRefNum      The reference number of the fork
;     <-  positionOffset  The current position of the fork
; 
; 
;  *  FSGetForkPosition()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSGetForkPosition" 
   ((forkRefNum :SInt16)
    (position (:pointer :SInt64))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetForkPositionSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBGetForkPositionSync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetForkPositionAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBGetForkPositionAsync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     SetForkPosition
;     Set the current (default) position of a fork that was
;     opened via OpenFork.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  forkRefNum      The reference number of the fork
;     ->  positionMode    The base location for the new position
;     ->  positionOffset  The offset of the new position from the base
; 
; 
;  *  FSSetForkPosition()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSSetForkPosition" 
   ((forkRefNum :SInt16)
    (positionMode :UInt16)
    (positionOffset :SInt64)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetForkPositionSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBSetForkPositionSync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetForkPositionAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBSetForkPositionAsync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     GetForkSize
;     Get the current logical size (end-of-file) of an open fork.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  forkRefNum      The reference number of the fork
;     <-  positionOffset  The logical size of the fork, in bytes
; 
; 
;  *  FSGetForkSize()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSGetForkSize" 
   ((forkRefNum :SInt16)
    (forkSize (:pointer :SInt64))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetForkSizeSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBGetForkSizeSync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetForkSizeAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBGetForkSizeAsync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     SetForkSize
;     Set the logical size (end-of-file) of an open fork.  This
;     may cause space to be allocated or deallocated.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  forkRefNum      The reference number of the fork
;     ->  positionMode    The base location for the new size
;     ->  positionOffset  The offset of the new size from the base
; 
; 
;  *  FSSetForkSize()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSSetForkSize" 
   ((forkRefNum :SInt16)
    (positionMode :UInt16)
    (positionOffset :SInt64)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetForkSizeSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBSetForkSizeSync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetForkSizeAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBSetForkSizeAsync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     AllocateFork
;     Allocate space to an open fork.  Typically, the space to be
;     allocated is beyond the current size of the fork, to reserve
;     space so the file will be able to grow later.  Some volume
;     formats are unable to allocate space beyond the logical size
;     of the fork.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  forkRefNum      The reference number of the fork
;     ->  positionMode    The base location for start of allocation
;     ->  positionOffset  The offset of the start of allocation
;     ->  allocationFlags Zero or more of the following flags:
;         kFSAllocContiguousMask
;                 Any newly allocated space must be one contiguous piece.
;         kFSAllocAllOrNothingMask
;                 All of the request space must be available, or the call
;                 will fail.  (If not set, the call may succeed even though
;                 some of the requested space wasn't allocated.)
;         kFSAllocNoRoundUpMask
;                 Do not allocate additional space.  (If not set, a volume
;                 may allocate additional space in order to reduce fragmentation.)
;     <>  allocationAmount    The number of bytes to allocate
;                             On output, the number of bytes actually added
; 
; 
;  *  FSAllocateFork()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSAllocateFork" 
   ((forkRefNum :SInt16)
    (flags :UInt16)
    (positionMode :UInt16)
    (positionOffset :SInt64)
    (requestCount :UInt64)
    (actualCount (:pointer :UInt64))            ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBAllocateForkSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBAllocateForkSync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBAllocateForkAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBAllocateForkAsync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     FlushFork
;     Flush a fork.  Any data written to this fork refnum is flushed to the device.
;     The volume's control structures are also flushed to the device.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  forkRefNum      The reference number of the fork to flush
; 
; 
;  *  FSFlushFork()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSFlushFork" 
   ((forkRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBFlushForkSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBFlushForkSync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBFlushForkAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBFlushForkAsync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     CloseFork
;     Flush and close a fork.  Any data written to this fork refnum is flushed
;     to the device.  The volume's control structures are also flushed to the device.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  forkRefNum      The reference number of the fork to close
; 
; 
;  *  FSCloseFork()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSCloseFork" 
   ((forkRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCloseForkSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCloseForkSync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBCloseForkAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBCloseForkAsync" 
   ((paramBlock (:pointer :FSForkIOParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     GetForkCBInfo
;     Return information about an open fork.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     <>  desiredRefNum   If non-zero on input, then get information for this refnum;
;                         unchanged on output.  If zero on input, iterate over all open
;                         forks (possibly limited to a single volume); on output, contains
;                         the fork's refnum.
;     ->  volumeRefNum    Used when desiredRefNum is zero on input.  Set to 0 to iterate over all
;                         volumes, or set to a FSVolumeRefNum to limit iteration to that volume.
;     <>  iterator        Used when desiredRefNum is zero on input.  Set to 0 before iterating.
;                         Pass the iterator returned by the previous call to continue iterating.
;     <-  actualRefNum    The refnum of the open fork.
;     <-  ref             The FSRef for the file or directory that contains the fork.
;     <-  forkInfo        Various information about the open fork.
;     <-  outForkName     The name of the fork
;     Note: the foundRefNum, ref, forkInfo, and fork name outputs are all optional; if you don't want
;     a particular output, then set its pointer to NULL.  If forkName is NULL, then forkNameLength
;     will be undefined.
;     Note: Returning the forkInfo generally does not require a disk access.  Returning the
;     ref or forkName may cause disk access for some volume formats.
; 
; 
;  *  FSGetForkCBInfo()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSGetForkCBInfo" 
   ((desiredRefNum :SInt16)
    (volume :SInt16)
    (iterator (:pointer :SInt16))               ;  can be NULL 
    (actualRefNum (:pointer :SInt16))           ;  can be NULL 
    (forkInfo (:pointer :FSForkInfo))           ;  can be NULL 
    (ref (:pointer :FSRef))                     ;  can be NULL 
    (outForkName (:pointer :HFSUniStr255))      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetForkCBInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBGetForkCBInfoSync" 
   ((paramBlock (:pointer :FSForkCBInfoParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetForkCBInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBGetForkCBInfoAsync" 
   ((paramBlock (:pointer :FSForkCBInfoParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     GetVolumeInfo
;     Returns various information about a given volume, or indexing over all volumes.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     <>  ioVRefNum       On input, the volume reference number or drive number whose
;                         information is to be returned (if volumeIndex is 0); same
;                         as "volume" input to FSGetVolumeInfo.
;                         On output, the actual volume reference number; same as
;                         "actualVolume" output of FSGetVolumeInfo.
;     ->  volumeIndex     The index of the desired volume, or 0 to use ioVRefNum
;     ->  whichInfo       Which volInfo info fields to get
;     <-  volumeInfo      The returned values of Volume info fields; may be NULL
;     <-  name            The Unicode name is returned here.  This pointer may be NULL.
;     Note: All of the outputs are optional; if you don't want that particular output, just
;     set its pointer to NULL.
; 
; 
;  *  FSGetVolumeInfo()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSGetVolumeInfo" 
   ((volume :SInt16)
    (volumeIndex :UInt32)
    (actualVolume (:pointer :FSVOLUMEREFNUM))   ;  can be NULL 
    (whichInfo :UInt32)
    (info (:pointer :FSVolumeInfo))             ;  can be NULL 
    (volumeName (:pointer :HFSUniStr255))       ;  can be NULL 
    (rootDirectory (:pointer :FSRef))           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetVolumeInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBGetVolumeInfoSync" 
   ((paramBlock (:pointer :FSVolumeInfoParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBGetVolumeInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBGetVolumeInfoAsync" 
   ((paramBlock (:pointer :FSVolumeInfoParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     SetVolumeInfo
;     Set information about a given volume.
;     ->  ioCompletion    A pointer to a completion routine
;     <-  ioResult        The result code of the function
;     ->  ioVRefNum       The volume whose information is to be changed
;     ->  whichInfo       Which catalog info fields to set
;     ->  volumeInfo      The new values of volume info fields
;     Note: Only some of the volume info fields may be set.  The settable fields
;     are given by the constant kFSVolInfoSettableInfo; no other bits may be set in
;     whichInfo.
; 
; 
;  *  FSSetVolumeInfo()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSSetVolumeInfo" 
   ((volume :SInt16)
    (whichInfo :UInt32)
    (info (:pointer :FSVolumeInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetVolumeInfoSync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBSetVolumeInfoSync" 
   ((paramBlock (:pointer :FSVolumeInfoParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PBSetVolumeInfoAsync()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_PBSetVolumeInfoAsync" 
   ((paramBlock (:pointer :FSVolumeInfoParam))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     FSGetDataForkName
;     Returns the constant for the name of the data fork (the empty string)
; 
; 
;  *  FSGetDataForkName()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSGetDataForkName" 
   ((dataForkName (:pointer :HFSUniStr255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;     FSGetResourceForkName
;     Returns the constant for the name of the resource fork
;     (currently "RESOURCE_FORK").
; 
; 
;  *  FSGetResourceForkName()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_FSGetResourceForkName" 
   ((resourceForkName (:pointer :HFSUniStr255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FSRefMakePath()
;  *  
;  *  Summary:
;  *    converts an FSRef to a POSIX path
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Parameters:
;  *    
;  *    ref:
;  *      the file/dir to get the POSIX path for
;  *    
;  *    path:
;  *      a pointer to a buffer which FSRefMakePath will fill with a UTF8
;  *      encoded C string representing the path the the specified FSRef
;  *    
;  *    maxPathSize:
;  *      the maximum size path length in bytes that path can hold
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSRefMakePath" 
   ((ref (:pointer :FSRef))
    (path (:pointer :UInt8))
    (maxPathSize :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FSPathMakeRef()
;  *  
;  *  Summary:
;  *    converts a POSIX path to an FSRef
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Parameters:
;  *    
;  *    path:
;  *      a pointer to a UTF8 encoded C String that is a POSIX path
;  *    
;  *    ref:
;  *      a pointer to an FSRef to fill in
;  *    
;  *    isDirectory:
;  *      an optional pointer to a Boolean that will be filled in with
;  *      whether the specified path is a directory (vs. a file)
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSPathMakeRef" 
   ((path (:pointer :UInt8))
    (ref (:pointer :FSRef))
    (isDirectory (:pointer :Boolean))           ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNMessage
;  *  
;  *  Discussion:
;  *    Messages broadcast about a directory.  If system clients (such as
;  *    the Finder) are interested in changes to a directory, they will
;  *    receive notifications when application code broadcasts change
;  *    messages about that directory.
;  

(def-mactype :FNMessage (find-mactype ':UInt32))

(defconstant $kFNDirectoryModifiedMessage 1)
; 
;  *  FNNotify()
;  *  
;  *  Summary:
;  *    Broadcasts notification of changes to the specified directory.
;  *  
;  *  Discussion:
;  *    FNNotify is used to notify system clients (such as the Finder) of
;  *    modifications to the contents of a directory, specifically
;  *    addition or removal of files or folders from the directory. The
;  *    Finder and other system clients will refresh their views of the
;  *    specified directory when they receive the change notification.
;  *    FNNotify is not meant to notify the Finder of changes to a
;  *    specific file (for example, changes to a file's type or creator);
;  *    for that purpose, use a kAESync AppleEvent sent to the Finder.
;  *  
;  *  Parameters:
;  *    
;  *    ref:
;  *      The directory for which to broadcast the notification
;  *    
;  *    message:
;  *      An indication of what happened to the target directory
;  *    
;  *    flags:
;  *      Options about delivery of the notification (specify kNilOptions
;  *      for default behaviour)
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FNNotify" 
   ((ref (:pointer :FSRef))
    (message :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNNotifyByPath()
;  *  
;  *  Summary:
;  *    Broadcasts notification of changes to the specified directory.
;  *  
;  *  Parameters:
;  *    
;  *    path:
;  *      Path to the directory for which to broadcast the notification
;  *    
;  *    message:
;  *      An indication of what happened to the target directory
;  *    
;  *    flags:
;  *      Options about delivery of the notification (specify kNilOptions
;  *      for default behaviour)
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FNNotifyByPath" 
   ((path (:pointer :UInt8))
    (message :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNNotifyAll()
;  *  
;  *  Discussion:
;  *    Broadcasts notification of changes to the filesystem (should only
;  *    be used by installers or programs which make lots of changes and
;  *    only send one broadcast).
;  *  
;  *  Parameters:
;  *    
;  *    message:
;  *      An indication of what happened
;  *    
;  *    flags:
;  *      Options about delivery of the notification (specify kNilOptions
;  *      for default behaviour)
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FNNotifyAll" 
   ((message :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FNSubscriptionRef
;  *  
;  *  Discussion:
;  *    A token associated with a notification subscription.  The
;  *    subscriber gets one back when they subscribe to notifications for
;  *    a particular directory, and they supply it when the unsubscribe. 
;  *    It is also delivered along with the notifications for that
;  *    subscription.
;  

(def-mactype :FNSubscriptionRef (find-mactype '(:pointer :OpaqueFNSubscriptionRef)))
; 
;  *  Discussion:
;  *    Options that can be specified at subscription time.
;  
; 
;    * Specify this option if you do not want to receive notifications on
;    * this subscription when FNNotifyAll is called; by default any
;    * subscription is also implicitly a subscription to wildcard
;    * notifications
;    

(defconstant $kFNNoImplicitAllSubscription 1)
; 
;    * Specify this option if you want to receive notifications on this
;    * subscription when your application is in background.  By default
;    * notifications will be coalesced and and delivered when your
;    * application becomes foreground.
;    

(defconstant $kFNNotifyInBackground 2)
; 
;  *  FNSubscriptionProcPtr
;  *  
;  *  Discussion:
;  *    Callback delivered for directory notifications.
;  *  
;  *  Parameters:
;  *    
;  *    message:
;  *      An indication of what happened
;  *    
;  *    flags:
;  *      Options about delivery of the notification (typically
;  *      kNilOptions)
;  *    
;  *    refcon:
;  *      User reference supplied with subscription
;  *    
;  *    subscription:
;  *      Subscription corresponding to this notification
;  

(def-mactype :FNSubscriptionProcPtr (find-mactype ':pointer)); (FNMessage message , OptionBits flags , void * refcon , FNSubscriptionRef subscription)

(def-mactype :FNSubscriptionUPP (find-mactype '(:pointer :OpaqueFNSubscriptionProcPtr)))
; 
;  *  NewFNSubscriptionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewFNSubscriptionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueFNSubscriptionProcPtr)
() )
; 
;  *  DisposeFNSubscriptionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeFNSubscriptionUPP" 
   ((userUPP (:pointer :OpaqueFNSubscriptionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeFNSubscriptionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeFNSubscriptionUPP" 
   ((message :UInt32)
    (flags :UInt32)
    (refcon :pointer)
    (subscription (:pointer :OpaqueFNSubscriptionRef))
    (userUPP (:pointer :OpaqueFNSubscriptionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FNSubscribe()
;  *  
;  *  Summary:
;  *    Subscribe to change notifications for the specified directory.
;  *  
;  *  Parameters:
;  *    
;  *    directoryRef:
;  *      Directory for which the caller wants notifications
;  *    
;  *    callback:
;  *      Function to call back when a notification arrives
;  *    
;  *    refcon:
;  *      User state carried with the subscription
;  *    
;  *    flags:
;  *      Options for future use (specify kNilOptions, or one of the
;  *      FNSubscriptionOptions)
;  *    
;  *    subscription:
;  *      Subscription token for subsequent query or unsubscription
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FNSubscribe" 
   ((directoryRef (:pointer :FSRef))
    (callback (:pointer :OpaqueFNSubscriptionProcPtr))
    (refcon :pointer)
    (flags :UInt32)
    (subscription (:pointer :FNSUBSCRIPTIONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  FNSubscribeByPath()
;  *  
;  *  Summary:
;  *    Subscribe to change notifications for the specified directory.
;  *  
;  *  Parameters:
;  *    
;  *    directoryPath:
;  *      Directory for which the caller wants notifications
;  *    
;  *    callback:
;  *      Function to call back when a notification arrives
;  *    
;  *    refcon:
;  *      User state carried with the subscription
;  *    
;  *    flags:
;  *      Options for future use (specify kNilOptions, or one of the
;  *      FNSubscriptionOptions)
;  *    
;  *    subscription:
;  *      Subscription token for subsequent query or unsubscription
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FNSubscribeByPath" 
   ((directoryPath (:pointer :UInt8))
    (callback (:pointer :OpaqueFNSubscriptionProcPtr))
    (refcon :pointer)
    (flags :UInt32)
    (subscription (:pointer :FNSUBSCRIPTIONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  FNUnsubscribe()
;  *  
;  *  Summary:
;  *    Release a subscription which is no longer needed.
;  *  
;  *  Parameters:
;  *    
;  *    subscription:
;  *      Subscription previously returned from FNSubscribe or
;  *      FNSubscribeForPath
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FNUnsubscribe" 
   ((subscription (:pointer :OpaqueFNSubscriptionRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  FNGetDirectoryForSubscription()
;  *  
;  *  Summary:
;  *    Fetch the directory for which this subscription was originally
;  *    entered. There is no path variant because paths are fragile, and
;  *    the path may have changed.  If the caller does not care about
;  *    this subtlety, she can call FSRefMakePath to get a path from the
;  *    returned ref.
;  *  
;  *  Parameters:
;  *    
;  *    subscription:
;  *      Subscription previously returned from FNSubscribe or
;  *      FNSubscribeForPath
;  *    
;  *    ref:
;  *      Directory for which this subscription was created
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FNGetDirectoryForSubscription" 
   ((subscription (:pointer :OpaqueFNSubscriptionRef))
    (ref (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
;  Async Volume Operation Status return values

(defconstant $kAsyncMountInProgress 1)
(defconstant $kAsyncMountComplete 2)
(defconstant $kAsyncUnmountInProgress 3)
(defconstant $kAsyncUnmountComplete 4)
(defconstant $kAsyncEjectInProgress 5)
(defconstant $kAsyncEjectComplete 6)

(def-mactype :FSMountStatus (find-mactype ':UInt32))

(def-mactype :FSEjectStatus (find-mactype ':UInt32))

(def-mactype :FSUnmountStatus (find-mactype ':UInt32))

(def-mactype :FSVolumeOperation (find-mactype '(:pointer :OpaqueFSVolumeOperation)))

(def-mactype :FSVolumeMountProcPtr (find-mactype ':pointer)); (FSVolumeOperation volumeOp , void * clientData , OSStatus err , FSVolumeRefNum mountedVolumeRefNum)

(def-mactype :FSVolumeUnmountProcPtr (find-mactype ':pointer)); (FSVolumeOperation volumeOp , void * clientData , OSStatus err , FSVolumeRefNum volumeRefNum , pid_t dissenter)

(def-mactype :FSVolumeEjectProcPtr (find-mactype ':pointer)); (FSVolumeOperation volumeOp , void * clientData , OSStatus err , FSVolumeRefNum volumeRefNum , pid_t dissenter)

(def-mactype :FSVolumeMountUPP (find-mactype '(:pointer :OpaqueFSVolumeMountProcPtr)))

(def-mactype :FSVolumeUnmountUPP (find-mactype '(:pointer :OpaqueFSVolumeUnmountProcPtr)))

(def-mactype :FSVolumeEjectUPP (find-mactype '(:pointer :OpaqueFSVolumeEjectProcPtr)))
; 
;  *  NewFSVolumeMountUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewFSVolumeMountUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueFSVolumeMountProcPtr)
() )
; 
;  *  NewFSVolumeUnmountUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewFSVolumeUnmountUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueFSVolumeUnmountProcPtr)
() )
; 
;  *  NewFSVolumeEjectUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewFSVolumeEjectUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueFSVolumeEjectProcPtr)
() )
; 
;  *  DisposeFSVolumeMountUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeFSVolumeMountUPP" 
   ((userUPP (:pointer :OpaqueFSVolumeMountProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  DisposeFSVolumeUnmountUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeFSVolumeUnmountUPP" 
   ((userUPP (:pointer :OpaqueFSVolumeUnmountProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  DisposeFSVolumeEjectUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeFSVolumeEjectUPP" 
   ((userUPP (:pointer :OpaqueFSVolumeEjectProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  InvokeFSVolumeMountUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeFSVolumeMountUPP" 
   ((volumeOp (:pointer :OpaqueFSVolumeOperation))
    (clientData :pointer)
    (err :SInt32)
    (mountedVolumeRefNum :SInt16)
    (userUPP (:pointer :OpaqueFSVolumeMountProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  InvokeFSVolumeUnmountUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeFSVolumeUnmountUPP" 
   ((volumeOp (:pointer :OpaqueFSVolumeOperation))
    (clientData :pointer)
    (err :SInt32)
    (volumeRefNum :SInt16)
    (dissenter :SInt32)
    (userUPP (:pointer :OpaqueFSVolumeUnmountProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  InvokeFSVolumeEjectUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeFSVolumeEjectUPP" 
   ((volumeOp (:pointer :OpaqueFSVolumeOperation))
    (clientData :pointer)
    (err :SInt32)
    (volumeRefNum :SInt16)
    (dissenter :SInt32)
    (userUPP (:pointer :OpaqueFSVolumeEjectProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  Discussion:
;  *    Options that can be passed to the FSMountServerVolumeCalls. These
;  *    options are not for use with the local volumes.
;  
; 
;    * Specify this option if you do want the volume displayed as a stand
;    * along volume in the UI.
;    

(defconstant $kFSMountServerMarkDoNotDisplay 1)
; 
;    * Specify this option if you do not want other processes notified
;    * that this volume has been mounted.
;    

(defconstant $kFSMountServerMountWithoutNotification 2)
; 
;    * Specify this option if you want the volume mounted on the mountdir
;    * passed in instead of in it.
;    

(defconstant $kFSMountServerMountOnMountDir 4)
; 
;  *  FSCreateVolumeOperation()
;  *  
;  *  Discussion:
;  *    This routine will return an FSVolumeOperation which can be used
;  *    for an async volume operation.  When the operation is completed
;  *    the volumeOp should be disposed of to free the memory associated
;  *    with the operation using FSDisposeVolumeOperation.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    volumeOp:
;  *      The new FSVolumeOperation.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSCreateVolumeOperation" 
   ((volumeOp (:pointer :FSVOLUMEOPERATION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSDisposeVolumeOperation()
;  *  
;  *  Discussion:
;  *    This routine will release the memory associated with the passed
;  *    in volumeOp. It will return paramErr is the volumeOp is in use.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    volumeOp:
;  *      The FSVolumeOperation to release.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSDisposeVolumeOperation" 
   ((volumeOp (:pointer :OpaqueFSVolumeOperation))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSMountLocalVolumeSync()
;  *  
;  *  Discussion:
;  *    This routine will mount the disk specified by diskID at mountDir
;  *    (or the default location if mountDir is NULL).  This routine
;  *    returns after the mount is complete.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    diskID:
;  *      The disk to mount.
;  *    
;  *    mountDir:
;  *      Pass in NULL (currently only NULL is supported).
;  *    
;  *    mountedVolumeRefNum:
;  *      The volume ref num of the newly mounted volume.
;  *    
;  *    flags:
;  *      Options for future use.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSMountLocalVolumeSync" 
   ((diskID (:pointer :__CFString))
    (mountDir (:pointer :__CFURL))              ;  can be NULL 
    (mountedVolumeRefNum (:pointer :FSVOLUMEREFNUM))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSMountLocalVolumeAsync()
;  *  
;  *  Discussion:
;  *    This routine will start the process to disk specified by diskID
;  *    at mountDir (or the default location if mountDir is NULL).  If a
;  *    callback is provided the provided function will be called when
;  *    the mount operation is complete.  Once this routine returns noErr
;  *    the status of the operation can be found using
;  *    FSGetAsyncMountStatus.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    diskID:
;  *      The disk to mount.
;  *    
;  *    mountDir:
;  *      Pass in NULL (currently only NULL is supported).
;  *    
;  *    volumeOp:
;  *      An FSVolumeOperation returned by FSCreateVolumeOperation
;  *    
;  *    clientData:
;  *      client data associated with the operation.
;  *    
;  *    flags:
;  *      Options for future use.
;  *    
;  *    callback:
;  *      Function to call when mount is complete.
;  *    
;  *    runloop:
;  *      Runloop to run on.
;  *    
;  *    runloopMode:
;  *      Mode for runloop.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSMountLocalVolumeAsync" 
   ((diskID (:pointer :__CFString))
    (mountDir (:pointer :__CFURL))              ;  can be NULL 
    (volumeOp (:pointer :OpaqueFSVolumeOperation))
    (clientData :pointer)                       ;  can be NULL 
    (flags :UInt32)
    (callback (:pointer :OpaqueFSVolumeMountProcPtr));  can be NULL 
    (runloop (:pointer :__CFRunLoop))
    (runloopMode (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSMountServerVolumeSync()
;  *  
;  *  Discussion:
;  *    This routine will mount the server specified by url at mountDir
;  *    (or the default location if mountDir is NULL).  An optional user
;  *    and password can be passed in for authentication. If no user or
;  *    password is provided then the underlying file system will handle
;  *    authentication if required.  This routine returns after the mount
;  *    is complete.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    url:
;  *      The server to mount.
;  *    
;  *    mountDir:
;  *      The directory to mount the server to (default if NULL).
;  *    
;  *    user:
;  *      String to pass as user for authentication.
;  *    
;  *    password:
;  *      String to pass as password for authenticated log in.
;  *    
;  *    mountedVolumeRefNum:
;  *      The volume ref num of the newly mounted volume.
;  *    
;  *    flags:
;  *      Options for future use.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSMountServerVolumeSync" 
   ((url (:pointer :__CFURL))
    (mountDir (:pointer :__CFURL))
    (user (:pointer :__CFString))
    (password (:pointer :__CFString))
    (mountedVolumeRefNum (:pointer :FSVOLUMEREFNUM))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSMountServerVolumeAsync()
;  *  
;  *  Discussion:
;  *    This routine will start the process to mount the server specified
;  *    by url at mountDir (or the default location if mountDir is NULL).
;  *     An optional user and password can be passed in for
;  *    authentication. If no user or password is provided then the
;  *    underlying file system will handle authentication if required. 
;  *    If a callback is provided the provided function will be called
;  *    when the mount operation is complete.  Once this routine returns
;  *    noErr the status of the operation can be found using
;  *    FSGetAsyncMountStatus.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    url:
;  *      The server to mount.
;  *    
;  *    mountDir:
;  *      The directory to mount the server to (default if NULL).
;  *    
;  *    user:
;  *      String to pass as user for authentication.
;  *    
;  *    password:
;  *      String to pass as password for authenticated log in.
;  *    
;  *    volumeOp:
;  *      An FSVolumeOperation returned by FSCreateVolumeOperation
;  *    
;  *    clientData:
;  *      client data associated with the operation.
;  *    
;  *    flags:
;  *      Options for future use.
;  *    
;  *    callback:
;  *      Function to call when mount is complete.
;  *    
;  *    runloop:
;  *      Runloop run on.
;  *    
;  *    runloopMode:
;  *      Mode for runloop.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSMountServerVolumeAsync" 
   ((url (:pointer :__CFURL))
    (mountDir (:pointer :__CFURL))              ;  can be NULL 
    (user (:pointer :__CFString))               ;  can be NULL 
    (password (:pointer :__CFString))           ;  can be NULL 
    (volumeOp (:pointer :OpaqueFSVolumeOperation))
    (clientData :pointer)                       ;  can be NULL 
    (flags :UInt32)
    (callback (:pointer :OpaqueFSVolumeMountProcPtr));  can be NULL 
    (runloop (:pointer :__CFRunLoop))
    (runloopMode (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSGetAsyncMountStatus()
;  *  
;  *  Discussion:
;  *    This routine returns the current status of an asynchronous mount
;  *    operation. A return value of noErr signifies that the status
;  *    parameter has been filled with valid information.  If the status
;  *    is kAsyncMountComplete then the rest of data returned is valid. 
;  *    If the status is anything else then the volumeOpStatus and
;  *    mountedVolumeRefNum parameters are invalid (The clientData will
;  *    be ok).
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    volumeOp:
;  *      The async volume operation to get status about.
;  *    
;  *    status:
;  *      The status of the operation.
;  *    
;  *    volumeOpStatus:
;  *      If status is kAsyncMountComplete then this contains the
;  *      OSStatus for the operation.
;  *    
;  *    mountedVolumeRefNum:
;  *      If status is kAsyncMountComplete and volumeOpStatus is noErr
;  *      then this is the volume ref num for the newly mounted volume.
;  *    
;  *    clientData:
;  *      client data associated with the original
;  *      FSMountServerVolumeAsync operation.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSGetAsyncMountStatus" 
   ((volumeOp (:pointer :OpaqueFSVolumeOperation))
    (status (:pointer :FSMOUNTSTATUS))
    (volumeOpStatus (:pointer :OSStatus))       ;  can be NULL 
    (mountedVolumeRefNum (:pointer :FSVOLUMEREFNUM));  can be NULL 
    (clientData :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSUnmountVolumeSync()
;  *  
;  *  Discussion:
;  *    This routine unmounts the volume specified by vRefNum.  If the
;  *    volume cannot be unmounted the pid of the process which denied
;  *    the unmount will be returned in the dissenter parameter.  This
;  *    routine returns after the unmount is complete.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      The volume reference number of the volume to unmount.
;  *    
;  *    flags:
;  *      Options for future use.
;  *    
;  *    dissenter:
;  *      pid of the process which denied the unmount if the unmount is
;  *      denied.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSUnmountVolumeSync" 
   ((vRefNum :SInt16)
    (flags :UInt32)
    (dissenter (:pointer :PID_T))               ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSUnmountVolumeAsync()
;  *  
;  *  Discussion:
;  *    This routine starts the process of unmounting the volume
;  *    specified by vRefNum. If a callback is provided the provided
;  *    function will be called when the unmount operation is complete. 
;  *    Once this routine returns noErr the status of the operation can
;  *    be found using FSGetAsyncUnmountStatus.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      The volume reference number of the volume to unmount.
;  *    
;  *    flags:
;  *      Options for future use.
;  *    
;  *    volumeOp:
;  *      An FSVolumeOperation returned by FSCreateVolumeOperation
;  *    
;  *    clientData:
;  *      client data associated with the operation.
;  *    
;  *    callback:
;  *      Function to call when unmount is complete.
;  *    
;  *    runloop:
;  *      Runloop to run on.
;  *    
;  *    runloopMode:
;  *      Mode for runloop.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSUnmountVolumeAsync" 
   ((vRefNum :SInt16)
    (flags :UInt32)
    (volumeOp (:pointer :OpaqueFSVolumeOperation))
    (clientData :pointer)
    (callback (:pointer :OpaqueFSVolumeUnmountProcPtr));  can be NULL 
    (runloop (:pointer :__CFRunLoop))
    (runloopMode (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSGetAsyncUnmountStatus()
;  *  
;  *  Discussion:
;  *    This routine returns the current status of an asynchronous
;  *    unmount operation. A return value of noErr signifies that the
;  *    status parameter has been filled with valid information.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    volumeOp:
;  *      The async volume operation to get status about.
;  *    
;  *    status:
;  *      The status of the operation.
;  *    
;  *    volumeOpStatus:
;  *      If status is kAsyncUnmountComplete then this contains the
;  *      OSStatus for the operation.
;  *    
;  *    volumeRefNum:
;  *      volume reference number of volume being unmounted.
;  *    
;  *    dissenter:
;  *      pid of the process which denied the unmount if the unmount is
;  *      denied.
;  *    
;  *    clientData:
;  *      client data associated with the original
;  *      FSMountServerVolumeAsync operation.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSGetAsyncUnmountStatus" 
   ((volumeOp (:pointer :OpaqueFSVolumeOperation))
    (status (:pointer :FSUNMOUNTSTATUS))
    (volumeOpStatus (:pointer :OSStatus))       ;  can be NULL 
    (volumeRefNum (:pointer :FSVOLUMEREFNUM))   ;  can be NULL 
    (dissenter (:pointer :PID_T))               ;  can be NULL 
    (clientData :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSCancelVolumeOperation()
;  *  
;  *  Discussion:
;  *    This routine will cancel and outstanding asynchronous volume
;  *    mounting operation. It currently is only supported for server
;  *    mounts.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    volumeOp:
;  *      The async volume operation to cancel.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSCancelVolumeOperation" 
   ((volumeOp (:pointer :OpaqueFSVolumeOperation))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSEjectVolumeSync()
;  *  
;  *  Discussion:
;  *    This routine ejects the volume specified by vRefNum.  If the
;  *    volume cannot be ejected the pid of the process which denied the
;  *    unmount will be returned in the dissenter parameter.  This
;  *    routine returns after the eject is complete.  Ejecting a volume
;  *    will result in the unmounting of other volumes on the same device.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      The volume reference number of the volume to eject.
;  *    
;  *    flags:
;  *      Options for future use.
;  *    
;  *    dissenter:
;  *      pid of the process which denied the unmount if the eject is
;  *      denied.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSEjectVolumeSync" 
   ((vRefNum :SInt16)
    (flags :UInt32)
    (dissenter (:pointer :PID_T))               ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSEjectVolumeAsync()
;  *  
;  *  Discussion:
;  *    This routine starts the process of ejecting the volume specified
;  *    by vRefNum. If a callback is provided the provided function will
;  *    be called when the eject operation is complete.  Once this
;  *    routine returns noErr the status of the operation can be found
;  *    using FSGetAsyncEjectStatus.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      The volume reference number of the volume to eject.
;  *    
;  *    flags:
;  *      Options for future use.
;  *    
;  *    volumeOp:
;  *      An FSVolumeOperation returned by FSCreateVolumeOperation
;  *    
;  *    clientData:
;  *      client data associated with the operation.
;  *    
;  *    callback:
;  *      Function to call when eject is complete.
;  *    
;  *    runloop:
;  *      Runloop to run on.
;  *    
;  *    runloopMode:
;  *      Mode for runloop.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSEjectVolumeAsync" 
   ((vRefNum :SInt16)
    (flags :UInt32)
    (volumeOp (:pointer :OpaqueFSVolumeOperation))
    (clientData :pointer)
    (callback (:pointer :OpaqueFSVolumeEjectProcPtr));  can be NULL 
    (runloop (:pointer :__CFRunLoop))
    (runloopMode (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSGetAsyncEjectStatus()
;  *  
;  *  Discussion:
;  *    This routine returns the current status of an asynchronous eject
;  *    operation. A return value of noErr signifies that the status
;  *    parameter has been filled with valid information.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    volumeOp:
;  *      The async volume operation to get status about.
;  *    
;  *    status:
;  *      The status of the operation.
;  *    
;  *    volumeOpStatus:
;  *      If status is kAsyncEjectComplete then this contains the
;  *      OSStatus for the operation.
;  *    
;  *    volumeRefNum:
;  *      volume reference number of volume being ejected.
;  *    
;  *    dissenter:
;  *      pid of the process which denied the unmount if the eject is
;  *      denied.
;  *    
;  *    clientData:
;  *      client data associated with the original
;  *      FSMountServerVolumeAsync operation.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSGetAsyncEjectStatus" 
   ((volumeOp (:pointer :OpaqueFSVolumeOperation))
    (status (:pointer :FSEJECTSTATUS))
    (volumeOpStatus (:pointer :OSStatus))       ;  can be NULL 
    (volumeRefNum (:pointer :FSVOLUMEREFNUM))   ;  can be NULL 
    (dissenter (:pointer :PID_T))               ;  can be NULL 
    (clientData :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSCopyDiskIDForVolume()
;  *  
;  *  Discussion:
;  *    This routine returns a copy of the diskID for the passed in
;  *    volume.  The caller is responsible for releasing the CFString
;  *    later.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      FSVolumeRefNum of the target volume.
;  *    
;  *    diskID:
;  *      The diskID string associated with the target volume.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSCopyDiskIDForVolume" 
   ((vRefNum :SInt16)
    (diskID (:pointer :CFSTRINGREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  FSCopyURLForVolume()
;  *  
;  *  Discussion:
;  *    This routine returns a copy of the url for the passed in volume. 
;  *    The caller is responsible for releasing the CFURL later.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    vRefNum:
;  *      FSVolumeRefNum of the target volume.
;  *    
;  *    url:
;  *      The url associated with the target volume.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FSCopyURLForVolume" 
   ((vRefNum :SInt16)
    (url (:pointer :CFURLRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __FILES__ */


(provide-interface "Files")