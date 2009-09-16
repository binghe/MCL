(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Finder.h"
; at Sunday July 2,2006 7:23:07 pm.
; 
;      File:       CarbonCore/Finder.h
;  
;      Contains:   Finder flags and container types.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1990-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __FINDER__
; #define __FINDER__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k
;  Creator and type of clipping files 

(defconstant $kClippingCreator :|drag|)
(defconstant $kClippingPictureType :|clpp|)
(defconstant $kClippingTextType :|clpt|)
(defconstant $kClippingSoundType :|clps|)
(defconstant $kClippingUnknownType :|clpu|)
;  Creator and type of Internet Location files 

(defconstant $kInternetLocationCreator :|drag|)
(defconstant $kInternetLocationHTTP :|ilht|)
(defconstant $kInternetLocationFTP :|ilft|)
(defconstant $kInternetLocationFile :|ilfi|)
(defconstant $kInternetLocationMail :|ilma|)
(defconstant $kInternetLocationNNTP :|ilnw|)
(defconstant $kInternetLocationAFP :|ilaf|)
(defconstant $kInternetLocationAppleTalk :|ilat|)
(defconstant $kInternetLocationNSL :|ilns|)
(defconstant $kInternetLocationGeneric :|ilge|)
;  Custom icon family resource ID 

(defconstant $kCustomIconResource -16455)
;  In order to specify any of the information described in the 
;  CustomBadgeResource data structure you must clear the kExtendedFlagsAreInvalid 
;  and set kExtendedFlagHasCustomBadge of the FXInfo.fdXFlags or DXInfo.frXFlags field, 
;  and add a resource of type kCustomBadgeResourceType and ID kCustomBadgeResourceID to 
;  the file or to the "Icon/n" file for a folder 

(defconstant $kCustomBadgeResourceType :|badg|)
(defconstant $kCustomBadgeResourceID -16455)
(defconstant $kCustomBadgeResourceVersion 0)
(defrecord CustomBadgeResource
   (version :SInt16)                            ;  This is version kCustomBadgeResourceVersion
   (customBadgeResourceID :SInt16)              ;  If not 0, the ID of a resource to use on top
                                                ;  of the icon for this file or folder
   (customBadgeType :OSType)                    ;  If not 0, the type and creator of an icon
   (customBadgeCreator :OSType)                 ;  to use on top of the icon
   (windowBadgeType :OSType)                    ;  If not 0, the type and creator of an icon
   (windowBadgeCreator :OSType)                 ;  to display in the header of the window for this 
                                                ;  file or folder
   (overrideType :OSType)                       ;  If not 0, the type and creator of an icon to
   (overrideCreator :OSType)                    ;  use INSTEAD of the icon for this file or folder
)

;type name? (%define-record :CustomBadgeResource (find-record-descriptor ':CustomBadgeResource))

(def-mactype :CustomBadgeResourcePtr (find-mactype '(:pointer :CustomBadgeResource)))

(def-mactype :CustomBadgeResourceHandle (find-mactype '(:handle :CustomBadgeResource)))
;  You can specify routing information for a file by including a 'rout' 0 
;     resource in it and setting the kExtendedFlagHasRoutingInfo bit in the extended 
;     Finder flags. 
;     The 'rout' resource is an array of RoutingResourceEntry. Each entry is considered
;     in turn. The first matching entry is used.
;     If the creator and fileType match the file being dropped and targetFolder match
;     the folder ID of the folder being dropped onto, then the file is rerouted 
;     into the specified destination folder.
;     The only target folder currently supported is the system folder, 
;     kSystemFolderType = 'macs'.
; 

(defconstant $kRoutingResourceType :|rout|)
(defconstant $kRoutingResourceID 0)
(defrecord RoutingResourceEntry
   (creator :OSType)                            ;  Use '****' or 0 to match any creator 
   (fileType :OSType)                           ;  Use '****' or 0 to match any file type 
   (targetFolder :OSType)                       ;  Folder ID of the folder this file was dropped onto 
   (destinationFolder :OSType)                  ;  Folder that the source will be routed to 
   (reservedField :OSType)                      ;  Set to 0 
)

;type name? (%define-record :RoutingResourceEntry (find-record-descriptor ':RoutingResourceEntry))

(def-mactype :RoutingResourcePtr (find-mactype '(:pointer :RoutingResourceEntry)))

(def-mactype :RoutingResourceHandle (find-mactype '(:handle :RoutingResourceEntry)))
;  Types for special container aliases 

(defconstant $kContainerFolderAliasType :|fdrp|);  type for folder aliases 

(defconstant $kContainerTrashAliasType :|trsh|) ;  type for trash folder aliases 

(defconstant $kContainerHardDiskAliasType :|hdsk|);  type for hard disk aliases 

(defconstant $kContainerFloppyAliasType :|flpy|);  type for floppy aliases 

(defconstant $kContainerServerAliasType :|srvr|);  type for server aliases 

(defconstant $kApplicationAliasType :|adrp|)    ;  type for application aliases 

(defconstant $kContainerAliasType :|drop|)      ;  type for all other containers 

(defconstant $kDesktopPrinterAliasType :|dtpa|) ;  type for Desktop Printer alias 

(defconstant $kContainerCDROMAliasType :|cddr|) ;  type for CD-ROM alias 

(defconstant $kApplicationCPAliasType :|acdp|)  ;  type for application control panel alias 

(defconstant $kApplicationDAAliasType :|addp|)  ;  type for application DA alias 

(defconstant $kPackageAliasType :|fpka|)        ;  type for plain package alias 

(defconstant $kAppPackageAliasType :|fapa|)     ;  type for application package alias 

;  Types for Special folder aliases 

(defconstant $kSystemFolderAliasType :|fasy|)
(defconstant $kAppleMenuFolderAliasType :|faam|)
(defconstant $kStartupFolderAliasType :|fast|)
(defconstant $kPrintMonitorDocsFolderAliasType :|fapn|)
(defconstant $kPreferencesFolderAliasType :|fapf|)
(defconstant $kControlPanelFolderAliasType :|fact|)
(defconstant $kExtensionFolderAliasType :|faex|)
;  Types for AppleShare folder aliases 

(defconstant $kExportedFolderAliasType :|faet|)
(defconstant $kDropFolderAliasType :|fadr|)
(defconstant $kSharedFolderAliasType :|fash|)
(defconstant $kMountedFolderAliasType :|famn|)
;  Finder flags (finderFlags, fdFlags and frFlags) 
;  Any flag reserved or not specified should be set to 0. 
;  If a flag applies to a file, but not to a folder, make sure to check 
;  that the item is not a folder by checking ((ParamBlockRec.ioFlAttrib & ioDirMask) == 0) 

(defconstant $kIsOnDesk 1)                      ;  Files and folders (System 6) 

(defconstant $kColor 14)                        ;  Files and folders 
;  bit 0x0020 was kRequireSwitchLaunch, but is now reserved for future use

(defconstant $kIsShared 64)                     ;  Files only (Applications only) 
;  If clear, the application needs to write to 
;  its resource fork, and therefore cannot be 
;  shared on a server 

(defconstant $kHasNoINITs #x80)                 ;  Files only (Extensions/Control Panels only) 
;  This file contains no INIT resource 

(defconstant $kHasBeenInited #x100)             ;  Files only 
;  Clear if the file contains desktop database 
;  resources ('BNDL', 'FREF', 'open', 'kind'...) 
;  that have not been added yet. Set only by the Finder 
;  Reserved for folders - make sure this bit is cleared for folders 
;  bit 0x0200 was the letter bit for AOCE, but is now reserved for future use 

(defconstant $kHasCustomIcon #x400)             ;  Files and folders 

(defconstant $kIsStationery #x800)              ;  Files only 

(defconstant $kNameLocked #x1000)               ;  Files and folders 

(defconstant $kHasBundle #x2000)                ;  Files only 

(defconstant $kIsInvisible #x4000)              ;  Files and folders 

(defconstant $kIsAlias #x8000)                  ;  Files only 

;  Obsolete. Use names defined above. 

(defconstant $fOnDesk 1)
(defconstant $fHasBundle #x2000)
(defconstant $fInvisible #x4000)
;  Obsolete 

(defconstant $fTrash -3)
(defconstant $fDesktop -2)
(defconstant $fDisk 0)

; #if OLDROUTINENAMES
#| 
(defconstant $kIsStationary #x800)
 |#

; #endif  /* OLDROUTINENAMES */

;  Extended flags (extendedFinderFlags, fdXFlags and frXFlags) 
;  Any flag not specified should be set to 0. 

(defconstant $kExtendedFlagsAreInvalid #x8000)  ;  If set the other extended flags are ignored 

(defconstant $kExtendedFlagHasCustomBadge #x100);  Set if the file or folder has a badge resource 

(defconstant $kExtendedFlagHasRoutingInfo 4)    ;  Set if the file contains routing info resource 

;  Use a filetype in this range to indicate that a file is temporarily busy 
;  (while it is being downloaded or installed, for example).  This prevents 
;  Finder 8.5 and later from trying to change the item's attributes before it 
;  is fully created. -- If you provide a series of 'BNDL' icons for your creator 
;  and some of these filetypes, you can achieve limited icon animation while 
;  the file creation progresses. 

(defconstant $kFirstMagicBusyFiletype :|bzy |)
(defconstant $kLastMagicBusyFiletype :|bzy?|)
;  Use this date as a file's or folder's creation date to indicate that it is 
;  temporarily busy (while it is being downloaded or installed, for example). 
;  This prevents Finder from trying to change the item's attributes before it 
;  is fully created (Finder 8.5 and 8.6 check file creation dates; later Finders 
;  may check folder creation dates as well). 

(defconstant $kMagicBusyCreationDate #x4F3AFDB0)
; ------------------------------------------------------------------------
; 
;    The following data structures are binary compatible with FInfo, DInfo,
;    FXInfo and DXInfo but represent the Mac OS 8 semantic of the fields.
;    Use these data structures preferably to FInfo, etc...
; 
; ------------------------------------------------------------------------
(defrecord FileInfo
   (fileType :OSType)                           ;  The type of the file 
   (fileCreator :OSType)                        ;  The file's creator 
   (finderFlags :UInt16)                        ;  ex: kHasBundle, kIsInvisible... 
   (location :Point)                            ;  File's location in the folder 
                                                ;  If set to {0, 0}, the Finder will place the item automatically 
   (reservedField :UInt16)                      ;  (set to 0) 
)

;type name? (%define-record :FileInfo (find-record-descriptor ':FileInfo))
(defrecord FolderInfo
   (windowBounds :Rect)                         ;  The position and dimension of the folder's window 
   (finderFlags :UInt16)                        ;  ex. kIsInvisible, kNameLocked, etc.
   (location :Point)                            ;  Folder's location in the parent folder 
                                                ;  If set to {0, 0}, the Finder will place the item automatically 
   (reservedField :UInt16)                      ;  (set to 0) 
)

;type name? (%define-record :FolderInfo (find-record-descriptor ':FolderInfo))
(defrecord ExtendedFileInfo
   (reserved1 (:array :SInt16 4))               ;  Reserved (set to 0) 
   (extendedFinderFlags :UInt16)                ;  Extended flags (custom badge, routing info...) 
   (reserved2 :SInt16)                          ;  Reserved (set to 0). Comment ID if high-bit is clear 
   (putAwayFolderID :SInt32)                    ;  Put away folder ID 
)

;type name? (%define-record :ExtendedFileInfo (find-record-descriptor ':ExtendedFileInfo))
(defrecord ExtendedFolderInfo
   (scrollPosition :Point)                      ;  Scroll position (for icon views) 
   (reserved1 :SInt32)                          ;  Reserved (set to 0) 
   (extendedFinderFlags :UInt16)                ;  Extended flags (custom badge, routing info...) 
   (reserved2 :SInt16)                          ;  Reserved (set to 0). Comment ID if high-bit is clear 
   (putAwayFolderID :SInt32)                    ;  Put away folder ID 
)

;type name? (%define-record :ExtendedFolderInfo (find-record-descriptor ':ExtendedFolderInfo))
; ------------------------------------------------------------------------
; 
;    The following data structures are here for compatibility.
;    Use the new data structures replacing them if possible (i.e. FileInfo 
;    instead of FInfo, etc...)
; 
; ------------------------------------------------------------------------
;  File info 
; 
;      IMPORTANT:
;      In MacOS 8, the fdFldr field has become reserved for the Finder.
; 
(defrecord FInfo
   (fdType :OSType)                             ;  The type of the file 
   (fdCreator :OSType)                          ;  The file's creator 
   (fdFlags :UInt16)                            ;  Flags ex. kHasBundle, kIsInvisible, etc. 
   (fdLocation :Point)                          ;  File's location in folder. 
                                                ;  If set to {0, 0}, the Finder will place the item automatically 
   (fdFldr :SInt16)                             ;  Reserved (set to 0) 
)

;type name? (%define-record :FInfo (find-record-descriptor ':FInfo))
;  Extended file info 
; 
;      IMPORTANT:
;      In MacOS 8, the fdIconID and fdComment fields were changed
;      to become reserved fields for the Finder.
;      The fdScript has become an extended flag.
; 
(defrecord FXInfo
   (fdIconID :SInt16)                           ;  Reserved (set to 0) 
   (fdReserved (:array :SInt16 3))              ;  Reserved (set to 0) 
   (fdScript :SInt8)                            ;  Extended flags. Script code if high-bit is set 
   (fdXFlags :SInt8)                            ;  Extended flags 
   (fdComment :SInt16)                          ;  Reserved (set to 0). Comment ID if high-bit is clear 
   (fdPutAway :SInt32)                          ;  Put away folder ID 
)

;type name? (%define-record :FXInfo (find-record-descriptor ':FXInfo))
;  Folder info 
; 
;      IMPORTANT:
;      In MacOS 8, the frView field was changed to become reserved 
;      field for the Finder.
; 
(defrecord DInfo
   (frRect :Rect)                               ;  Folder's window bounds 
   (frFlags :UInt16)                            ;  Flags ex. kIsInvisible, kNameLocked, etc.
   (frLocation :Point)                          ;  Folder's location in parent folder 
                                                ;  If set to {0, 0}, the Finder will place the item automatically 
   (frView :SInt16)                             ;  Reserved (set to 0) 
)

;type name? (%define-record :DInfo (find-record-descriptor ':DInfo))
;  Extended folder info 
; 
;      IMPORTANT:
;      In MacOS 8, the frOpenChain and frComment fields were changed
;      to become reserved fields for the Finder.
;      The frScript has become an extended flag.
; 
(defrecord DXInfo
   (frScroll :Point)                            ;  Scroll position 
   (frOpenChain :SInt32)                        ;  Reserved (set to 0) 
   (frScript :SInt8)                            ;  Extended flags. Script code if high-bit is set 
   (frXFlags :SInt8)                            ;  Extended flags 
   (frComment :SInt16)                          ;  Reserved (set to 0). Comment ID if high-bit is clear 
   (frPutAway :SInt32)                          ;  Put away folder ID 
)

;type name? (%define-record :DXInfo (find-record-descriptor ':DXInfo))
;  ControlPanelDefProcPtr and cdev constants have all been moved to Processes.i
; #pragma options align=reset

; #endif /* __FINDER__ */


(provide-interface "Finder")