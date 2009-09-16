(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:HFSVolumes.h"
; at Sunday July 2,2006 7:23:30 pm.
; 
;      File:       CarbonCore/HFSVolumes.h
;  
;      Contains:   On-disk data structures for HFS and HFS Plus volumes.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1984-2003 by Apple Computer, Inc.  All rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __HFSVOLUMES__
; #define __HFSVOLUMES__
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
; #ifndef __FINDER__
#| #|
#include <CarbonCoreFinder.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k
;  Signatures used to differentiate between HFS and HFS Plus volumes 

(defconstant $kHFSSigWord #x4244)               ;  'BD' in ASCII 

(defconstant $kHFSPlusSigWord #x482B)           ;  'H+' in ASCII 

(defconstant $kHFSPlusVersion 4)                ;  will change as format changes (version 4 shipped with Mac OS 8.1) 

(defconstant $kHFSPlusMountVersion :|8.10|)     ;  will change as implementations change ('8.10' in Mac OS 8.1) 

;  CatalogNodeID is used to track catalog objects 

(def-mactype :HFSCatalogNodeID (find-mactype ':UInt32))

(defconstant $kHFSMaxVolumeNameChars 27)
(defconstant $kHFSMaxFileNameChars 31)
(defconstant $kHFSPlusMaxFileNameChars #xFF)
;  Extent overflow file data structures 
;  HFS Extent key 
(defrecord HFSExtentKey
   (keyLength :UInt8)                           ;  length of key, excluding this field 
   (forkType :UInt8)                            ;  0 = data fork, FF = resource fork 
   (fileID :UInt32)                             ;  file ID 
   (startBlock :UInt16)                         ;  first file allocation block number in this extent 
)

;type name? (%define-record :HFSExtentKey (find-record-descriptor ':HFSExtentKey))
;  HFS Plus Extent key 
(defrecord HFSPlusExtentKey
   (keyLength :UInt16)                          ;  length of key, excluding this field 
   (forkType :UInt8)                            ;  0 = data fork, FF = resource fork 
   (pad :UInt8)                                 ;  make the other fields align on 32-bit boundary 
   (fileID :UInt32)                             ;  file ID 
   (startBlock :UInt32)                         ;  first file allocation block number in this extent 
)

;type name? (%define-record :HFSPlusExtentKey (find-record-descriptor ':HFSPlusExtentKey))
;  Number of extent descriptors per extent record 

(defconstant $kHFSExtentDensity 3)
(defconstant $kHFSPlusExtentDensity 8)
;  HFS extent descriptor 
(defrecord HFSExtentDescriptor
   (startBlock :UInt16)                         ;  first allocation block 
   (blockCount :UInt16)                         ;  number of allocation blocks 
)

;type name? (%define-record :HFSExtentDescriptor (find-record-descriptor ':HFSExtentDescriptor))
;  HFS Plus extent descriptor 
(defrecord HFSPlusExtentDescriptor
   (startBlock :UInt32)                         ;  first allocation block 
   (blockCount :UInt32)                         ;  number of allocation blocks 
)

;type name? (%define-record :HFSPlusExtentDescriptor (find-record-descriptor ':HFSPlusExtentDescriptor))
;  HFS extent record 
(defrecord HFSExtentRecord
   (contents (:array :HFSExtentDescriptor 3))
)                                               ;  HFS Plus extent record 
(defrecord HFSPlusExtentRecord
   (contents (:array :HFSPlusExtentDescriptor 8))
)                                               ;  Fork data info (HFS Plus only) - 80 bytes 
(defrecord HFSPlusForkData
   (logicalSize :UInt64)                        ;  fork's logical size in bytes 
   (clumpSize :UInt32)                          ;  fork's clump size in bytes 
   (totalBlocks :UInt32)                        ;  total blocks used by this fork 
   (extents :HFSPLUSEXTENTRECORD)               ;  initial set of extents 
)

;type name? (%define-record :HFSPlusForkData (find-record-descriptor ':HFSPlusForkData))
;  Permissions info (HFS Plus only) - 16 bytes 
(defrecord HFSPlusPermissions
   (ownerID :UInt32)                            ;  user or group ID of file/folder owner 
   (groupID :UInt32)                            ;  additional user of group ID 
   (permissions :UInt32)                        ;  permissions (bytes: unused, owner, group, everyone) 
   (specialDevice :UInt32)                      ;  UNIX: device for character or block special file 
)

;type name? (%define-record :HFSPlusPermissions (find-record-descriptor ':HFSPlusPermissions))
;  Catalog file data structures 

(defconstant $kHFSRootParentID 1)               ;  Parent ID of the root folder 

(defconstant $kHFSRootFolderID 2)               ;  Folder ID of the root folder 

(defconstant $kHFSExtentsFileID 3)              ;  File ID of the extents file 

(defconstant $kHFSCatalogFileID 4)              ;  File ID of the catalog file 

(defconstant $kHFSBadBlockFileID 5)             ;  File ID of the bad allocation block file 

(defconstant $kHFSAllocationFileID 6)           ;  File ID of the allocation file (HFS Plus only) 

(defconstant $kHFSStartupFileID 7)              ;  File ID of the startup file (HFS Plus only) 

(defconstant $kHFSAttributesFileID 8)           ;  File ID of the attribute file (HFS Plus only) 

(defconstant $kHFSBogusExtentFileID 15)         ;  Used for exchanging extents in extents file 

(defconstant $kHFSFirstUserCatalogNodeID 16)
;  HFS catalog key 
(defrecord HFSCatalogKey
   (keyLength :UInt8)                           ;  key length (in bytes) 
   (reserved :UInt8)                            ;  reserved (set to zero) 
   (parentID :UInt32)                           ;  parent folder ID 
   (nodeName (:string 31))                      ;  catalog node name 
)

;type name? (%define-record :HFSCatalogKey (find-record-descriptor ':HFSCatalogKey))
;  HFS Plus catalog key 
(defrecord HFSPlusCatalogKey
   (keyLength :UInt16)                          ;  key length (in bytes) 
   (parentID :UInt32)                           ;  parent folder ID 
   (nodeName :HFSUniStr255)                     ;  catalog node name 
)

;type name? (%define-record :HFSPlusCatalogKey (find-record-descriptor ':HFSPlusCatalogKey))
;  Catalog record types 
;  HFS Catalog Records 

(defconstant $kHFSFolderRecord #x100)           ;  Folder record 

(defconstant $kHFSFileRecord #x200)             ;  File record 

(defconstant $kHFSFolderThreadRecord #x300)     ;  Folder thread record 

(defconstant $kHFSFileThreadRecord #x400)       ;  File thread record 
;  HFS Plus Catalog Records 

(defconstant $kHFSPlusFolderRecord 1)           ;  Folder record 

(defconstant $kHFSPlusFileRecord 2)             ;  File record 

(defconstant $kHFSPlusFolderThreadRecord 3)     ;  Folder thread record 

(defconstant $kHFSPlusFileThreadRecord 4)       ;  File thread record 

;  Catalog file record flags 

(defconstant $kHFSFileLockedBit 0)              ;  file is locked and cannot be written to 

(defconstant $kHFSFileLockedMask 1)
(defconstant $kHFSThreadExistsBit 1)            ;  a file thread record exists for this file 

(defconstant $kHFSThreadExistsMask 2)
;  HFS catalog folder record - 70 bytes 
(defrecord HFSCatalogFolder
   (recordType :SInt16)                         ;  record type 
   (flags :UInt16)                              ;  folder flags 
   (valence :UInt16)                            ;  folder valence 
   (folderID :UInt32)                           ;  folder ID 
   (createDate :UInt32)                         ;  date and time of creation 
   (modifyDate :UInt32)                         ;  date and time of last modification 
   (backupDate :UInt32)                         ;  date and time of last backup 
   (userInfo :DInfo)                            ;  Finder information 
   (finderInfo :DXInfo)                         ;  additional Finder information 
   (reserved (:array :UInt32 4))                ;  reserved - set to zero 
)

;type name? (%define-record :HFSCatalogFolder (find-record-descriptor ':HFSCatalogFolder))
;  HFS Plus catalog folder record - 88 bytes 
(defrecord HFSPlusCatalogFolder
   (recordType :SInt16)                         ;  record type = HFS Plus folder record 
   (flags :UInt16)                              ;  file flags 
   (valence :UInt32)                            ;  folder's valence (limited to 2^16 in Mac OS) 
   (folderID :UInt32)                           ;  folder ID 
   (createDate :UInt32)                         ;  date and time of creation 
   (contentModDate :UInt32)                     ;  date and time of last content modification 
   (attributeModDate :UInt32)                   ;  date and time of last attribute modification 
   (accessDate :UInt32)                         ;  date and time of last access (Rhapsody only) 
   (backupDate :UInt32)                         ;  date and time of last backup 
   (permissions :HFSPlusPermissions)            ;  permissions (for Rhapsody) 
   (userInfo :DInfo)                            ;  Finder information 
   (finderInfo :DXInfo)                         ;  additional Finder information 
   (textEncoding :UInt32)                       ;  hint for name conversions 
   (reserved :UInt32)                           ;  reserved - set to zero 
)

;type name? (%define-record :HFSPlusCatalogFolder (find-record-descriptor ':HFSPlusCatalogFolder))
;  HFS catalog file record - 102 bytes 
(defrecord HFSCatalogFile
   (recordType :SInt16)                         ;  record type 
   (flags :UInt8)                               ;  file flags 
   (fileType :SInt8)                            ;  file type (unused ?) 
   (userInfo :FInfo)                            ;  Finder information 
   (fileID :UInt32)                             ;  file ID 
   (dataStartBlock :UInt16)                     ;  not used - set to zero 
   (dataLogicalSize :SInt32)                    ;  logical EOF of data fork 
   (dataPhysicalSize :SInt32)                   ;  physical EOF of data fork 
   (rsrcStartBlock :UInt16)                     ;  not used - set to zero 
   (rsrcLogicalSize :SInt32)                    ;  logical EOF of resource fork 
   (rsrcPhysicalSize :SInt32)                   ;  physical EOF of resource fork 
   (createDate :UInt32)                         ;  date and time of creation 
   (modifyDate :UInt32)                         ;  date and time of last modification 
   (backupDate :UInt32)                         ;  date and time of last backup 
   (finderInfo :FXInfo)                         ;  additional Finder information 
   (clumpSize :UInt16)                          ;  file clump size (not used) 
   (dataExtents :HFSEXTENTRECORD)               ;  first data fork extent record 
   (rsrcExtents :HFSEXTENTRECORD)               ;  first resource fork extent record 
   (reserved :UInt32)                           ;  reserved - set to zero 
)

;type name? (%define-record :HFSCatalogFile (find-record-descriptor ':HFSCatalogFile))
;  HFS Plus catalog file record - 248 bytes 
(defrecord HFSPlusCatalogFile
   (recordType :SInt16)                         ;  record type = HFS Plus file record 
   (flags :UInt16)                              ;  file flags 
   (reserved1 :UInt32)                          ;  reserved - set to zero 
   (fileID :UInt32)                             ;  file ID 
   (createDate :UInt32)                         ;  date and time of creation 
   (contentModDate :UInt32)                     ;  date and time of last content modification 
   (attributeModDate :UInt32)                   ;  date and time of last attribute modification 
   (accessDate :UInt32)                         ;  date and time of last access (Rhapsody only) 
   (backupDate :UInt32)                         ;  date and time of last backup 
   (permissions :HFSPlusPermissions)            ;  permissions (for Rhapsody) 
   (userInfo :FInfo)                            ;  Finder information 
   (finderInfo :FXInfo)                         ;  additional Finder information 
   (textEncoding :UInt32)                       ;  hint for name conversions 
   (reserved2 :UInt32)                          ;  reserved - set to zero 
                                                ;  start on double long (64 bit) boundry 
   (dataFork :HFSPlusForkData)                  ;  size and block data for data fork 
   (resourceFork :HFSPlusForkData)              ;  size and block data for resource fork 
)

;type name? (%define-record :HFSPlusCatalogFile (find-record-descriptor ':HFSPlusCatalogFile))
;  HFS catalog thread record - 46 bytes 
(defrecord HFSCatalogThread
   (recordType :SInt16)                         ;  record type 
   (reserved (:array :SInt32 2))                ;  reserved - set to zero 
   (parentID :UInt32)                           ;  parent ID for this catalog node 
   (nodeName (:string 31))                      ;  name of this catalog node 
)

;type name? (%define-record :HFSCatalogThread (find-record-descriptor ':HFSCatalogThread))
;  HFS Plus catalog thread record -- 264 bytes 
(defrecord HFSPlusCatalogThread
   (recordType :SInt16)                         ;  record type 
   (reserved :SInt16)                           ;  reserved - set to zero 
   (parentID :UInt32)                           ;  parent ID for this catalog node 
   (nodeName :HFSUniStr255)                     ;  name of this catalog node (variable length) 
)

;type name? (%define-record :HFSPlusCatalogThread (find-record-descriptor ':HFSPlusCatalogThread))
; 
;     These are the types of records in the attribute B-tree.  The values were chosen
;     so that they wouldn't conflict with the catalog record types.
; 

(defconstant $kHFSPlusAttrInlineData 16)        ;  if size <  kAttrOverflowSize 

(defconstant $kHFSPlusAttrForkData 32)          ;  if size >= kAttrOverflowSize 

(defconstant $kHFSPlusAttrExtents 48)           ;  overflow extents for large attributes 

; 
;     HFSPlusAttrInlineData
;     For small attributes, whose entire value is stored within this one
;     B-tree record.
;     There would not be any other records for this attribute.
; 
(defrecord HFSPlusAttrInlineData
   (recordType :UInt32)                         ;     = kHFSPlusAttrInlineData
   (reserved :UInt32)
   (logicalSize :UInt32)                        ;     size in bytes of userData
   (userData (:array :UInt8 2))                 ;     variable length; space allocated is a multiple of 2 bytes
)

;type name? (%define-record :HFSPlusAttrInlineData (find-record-descriptor ':HFSPlusAttrInlineData))
; 
;     HFSPlusAttrForkData
;     For larger attributes, whose value is stored in allocation blocks.
;     If the attribute has more than 8 extents, there will be additonal
;     records (of type HFSPlusAttrExtents) for this attribute.
; 
(defrecord HFSPlusAttrForkData
   (recordType :UInt32)                         ;     = kHFSPlusAttrForkData
   (reserved :UInt32)
   (theFork :HFSPlusForkData)                   ;     size and first extents of value
)

;type name? (%define-record :HFSPlusAttrForkData (find-record-descriptor ':HFSPlusAttrForkData))
; 
;     HFSPlusAttrExtents
;     This record contains information about overflow extents for large,
;     fragmented attributes.
; 
(defrecord HFSPlusAttrExtents
   (recordType :UInt32)                         ;     = kHFSPlusAttrExtents
   (reserved :UInt32)
   (extents :HFSPLUSEXTENTRECORD)               ;     additional extents
)

;type name? (%define-record :HFSPlusAttrExtents (find-record-descriptor ':HFSPlusAttrExtents))
;   A generic Attribute Record
(defrecord HFSPlusAttrRecord
   (:variant
   (
   (recordType :UInt32)
   )
   (
   (inlineData :HFSPlusAttrInlineData)
   )
   (
   (forkData :HFSPlusAttrForkData)
   )
   (
   (overflowExtents :HFSPlusAttrExtents)
   )
   )
)

;type name? (%define-record :HFSPlusAttrRecord (find-record-descriptor ':HFSPlusAttrRecord))
;  Key and node lengths 

(defconstant $kHFSPlusExtentKeyMaximumLength 10)
(defconstant $kHFSExtentKeyMaximumLength 7)
(defconstant $kHFSPlusCatalogKeyMaximumLength #x204)
(defconstant $kHFSPlusCatalogKeyMinimumLength 6)
(defconstant $kHFSCatalogKeyMaximumLength 9)
(defconstant $kHFSCatalogKeyMinimumLength -22)
(defconstant $kHFSPlusCatalogMinNodeSize #x1000)
(defconstant $kHFSPlusExtentMinNodeSize #x200)
(defconstant $kHFSPlusAttrMinNodeSize #x1000)
;  HFS and HFS Plus volume attribute bits 
;  Bits 0-6 are reserved (always cleared by MountVol call) 

(defconstant $kHFSVolumeHardwareLockBit 7)      ;  volume is locked by hardware 

(defconstant $kHFSVolumeUnmountedBit 8)         ;  volume was successfully unmounted 

(defconstant $kHFSVolumeSparedBlocksBit 9)      ;  volume has bad blocks spared 

(defconstant $kHFSVolumeNoCacheRequiredBit 10)  ;  don't cache volume blocks (i.e. RAM or ROM disk) 

(defconstant $kHFSBootVolumeInconsistentBit 11) ;  boot volume is inconsistent (System 7.6 and later) 
;  Bits 12-14 are reserved for future use 

(defconstant $kHFSVolumeSoftwareLockBit 15)     ;  volume is locked by software 

(defconstant $kHFSVolumeHardwareLockMask #x80)
(defconstant $kHFSVolumeUnmountedMask #x100)
(defconstant $kHFSVolumeSparedBlocksMask #x200)
(defconstant $kHFSVolumeNoCacheRequiredMask #x400)
(defconstant $kHFSBootVolumeInconsistentMask #x800)
(defconstant $kHFSVolumeSoftwareLockMask #x8000)
(defconstant $kHFSMDBAttributesMask #x8380)

(defconstant $kHFSCatalogNodeIDsReusedBit 12)   ;  nextCatalogID wrapped around 

(defconstant $kHFSCatalogNodeIDsReusedMask #x1000)
;  Master Directory Block (HFS only) - 162 bytes 
;  Stored at sector #2 (3rd sector) 
(defrecord HFSMasterDirectoryBlock
                                                ;  These first fields are also used by MFS 
   (drSigWord :UInt16)                          ;  volume signature 
   (drCrDate :UInt32)                           ;  date and time of volume creation 
   (drLsMod :UInt32)                            ;  date and time of last modification 
   (drAtrb :UInt16)                             ;  volume attributes 
   (drNmFls :UInt16)                            ;  number of files in root folder 
   (drVBMSt :UInt16)                            ;  first block of volume bitmap 
   (drAllocPtr :UInt16)                         ;  start of next allocation search 
   (drNmAlBlks :UInt16)                         ;  number of allocation blocks in volume 
   (drAlBlkSiz :UInt32)                         ;  size (in bytes) of allocation blocks 
   (drClpSiz :UInt32)                           ;  default clump size 
   (drAlBlSt :UInt16)                           ;  first allocation block in volume 
   (drNxtCNID :UInt32)                          ;  next unused catalog node ID 
   (drFreeBks :UInt16)                          ;  number of unused allocation blocks 
   (drVN (:string 27))                          ;  volume name 
                                                ;  Master Directory Block extensions for HFS 
   (drVolBkUp :UInt32)                          ;  date and time of last backup 
   (drVSeqNum :UInt16)                          ;  volume backup sequence number 
   (drWrCnt :UInt32)                            ;  volume write count 
   (drXTClpSiz :UInt32)                         ;  clump size for extents overflow file 
   (drCTClpSiz :UInt32)                         ;  clump size for catalog file 
   (drNmRtDirs :UInt16)                         ;  number of directories in root folder 
   (drFilCnt :UInt32)                           ;  number of files in volume 
   (drDirCnt :UInt32)                           ;  number of directories in volume 
   (drFndrInfo (:array :SInt32 8))              ;  information used by the Finder 
   (drEmbedSigWord :UInt16)                     ;  embedded volume signature (formerly drVCSize) 
   (drEmbedExtent :HFSExtentDescriptor)         ;  embedded volume location and size (formerly drVBMCSize and drCtlCSize) 
   (drXTFlSize :UInt32)                         ;  size of extents overflow file 
   (drXTExtRec :HFSEXTENTRECORD)                ;  extent record for extents overflow file 
   (drCTFlSize :UInt32)                         ;  size of catalog file 
   (drCTExtRec :HFSEXTENTRECORD)                ;  extent record for catalog file 
)

;type name? (%define-record :HFSMasterDirectoryBlock (find-record-descriptor ':HFSMasterDirectoryBlock))
;  HFSPlusVolumeHeader (HFS Plus only) - 512 bytes 
;  Stored at sector #2 (3rd sector) and second-to-last sector. 
(defrecord HFSPlusVolumeHeader
   (signature :UInt16)                          ;  volume signature == 'H+' 
   (version :UInt16)                            ;  current version is kHFSPlusVersion 
   (attributes :UInt32)                         ;  volume attributes 
   (lastMountedVersion :UInt32)                 ;  implementation version which last mounted volume 
   (reserved :UInt32)                           ;  reserved - set to zero 
   (createDate :UInt32)                         ;  date and time of volume creation 
   (modifyDate :UInt32)                         ;  date and time of last modification 
   (backupDate :UInt32)                         ;  date and time of last backup 
   (checkedDate :UInt32)                        ;  date and time of last disk check 
   (fileCount :UInt32)                          ;  number of files in volume 
   (folderCount :UInt32)                        ;  number of directories in volume 
   (blockSize :UInt32)                          ;  size (in bytes) of allocation blocks 
   (totalBlocks :UInt32)                        ;  number of allocation blocks in volume (includes this header and VBM
   (freeBlocks :UInt32)                         ;  number of unused allocation blocks 
   (nextAllocation :UInt32)                     ;  start of next allocation search 
   (rsrcClumpSize :UInt32)                      ;  default resource fork clump size 
   (dataClumpSize :UInt32)                      ;  default data fork clump size 
   (nextCatalogID :UInt32)                      ;  next unused catalog node ID 
   (writeCount :UInt32)                         ;  volume write count 
   (encodingsBitmap :UInt64)                    ;  which encodings have been use  on this volume 
   (finderInfo (:array :UInt8 32))              ;  information used by the Finder 
   (allocationFile :HFSPlusForkData)            ;  allocation bitmap file 
   (extentsFile :HFSPlusForkData)               ;  extents B-tree file 
   (catalogFile :HFSPlusForkData)               ;  catalog B-tree file 
   (attributesFile :HFSPlusForkData)            ;  extended attributes B-tree file 
   (startupFile :HFSPlusForkData)               ;  boot file 
)

;type name? (%define-record :HFSPlusVolumeHeader (find-record-descriptor ':HFSPlusVolumeHeader))
;  ---------- HFS and HFS Plus B-tree structures ---------- 
;  BTNodeDescriptor -- Every B-tree node starts with these fields. 
(defrecord BTNodeDescriptor
   (fLink :UInt32)                              ;     next node at this level
   (bLink :UInt32)                              ;     previous node at this level
   (kind :SInt8)                                ;     kind of node (leaf, index, header, map)
   (height :UInt8)                              ;     zero for header, map; child is one more than parent
   (numRecords :UInt16)                         ;     number of records in this node
   (reserved :UInt16)                           ;     reserved; set to zero
)

;type name? (%define-record :BTNodeDescriptor (find-record-descriptor ':BTNodeDescriptor))
;  Constants for BTNodeDescriptor kind 

(defconstant $kBTLeafNode -1)
(defconstant $kBTIndexNode 0)
(defconstant $kBTHeaderNode 1)
(defconstant $kBTMapNode 2)
;  BTHeaderRec -- The first record of a B-tree header node 
(defrecord BTHeaderRec
   (treeDepth :UInt16)                          ;     maximum height (usually leaf nodes)
   (rootNode :UInt32)                           ;     node number of root node
   (leafRecords :UInt32)                        ;     number of leaf records in all leaf nodes
   (firstLeafNode :UInt32)                      ;     node number of first leaf node
   (lastLeafNode :UInt32)                       ;     node number of last leaf node
   (nodeSize :UInt16)                           ;     size of a node, in bytes
   (maxKeyLength :UInt16)                       ;     reserved
   (totalNodes :UInt32)                         ;     total number of nodes in tree
   (freeNodes :UInt32)                          ;     number of unused (free) nodes in tree
   (reserved1 :UInt16)                          ;     unused
   (clumpSize :UInt32)                          ;     reserved
   (btreeType :UInt8)                           ;     reserved
   (reserved2 :UInt8)                           ;     reserved
   (attributes :UInt32)                         ;     persistent attributes about the tree
   (reserved3 (:array :UInt32 16))              ;     reserved
)

;type name? (%define-record :BTHeaderRec (find-record-descriptor ':BTHeaderRec))
;  Constants for BTHeaderRec attributes 

(defconstant $kBTBadCloseMask 1)                ;     reserved

(defconstant $kBTBigKeysMask 2)                 ;     key length field is 16 bits

(defconstant $kBTVariableIndexKeysMask 4)       ;     keys in index nodes are variable length

; #pragma options align=reset

; #endif /* __HFSVOLUMES__ */


(provide-interface "HFSVolumes")