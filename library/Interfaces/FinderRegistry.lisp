(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:FinderRegistry.h"
; at Sunday July 2,2006 7:25:11 pm.
; 
;      File:       OpenScripting/FinderRegistry.h
;  
;      Contains:   Data types for Finder AppleEvents
;  
;      Version:    OSA-62~76
;  
;      Copyright:  © 1991-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __FINDERREGISTRY__
; #define __FINDERREGISTRY__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __OSA__
#| #|
#include <OpenScriptingOSA.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; 
;   //////////////////////////////////////
;    Finder Suite
;   //////////////////////////////////////
; 
; 
;    The old Finder Event suite was 'FNDR'
;    The new suite is 'fndr'
; 

(defconstant $kAEFinderSuite :|fndr|)
; 
;   //////////////////////////////////////
;    Finder Events
;   //////////////////////////////////////
; 

(defconstant $kAECleanUp :|fclu|)
(defconstant $kAEEject :|ejct|)
(defconstant $kAEEmpty :|empt|)
(defconstant $kAEErase :|fera|)
(defconstant $kAEGestalt :|gstl|)
(defconstant $kAEPutAway :|ptwy|)
(defconstant $kAERebuildDesktopDB :|rddb|)
(defconstant $kAESync :|fupd|)
(defconstant $kAEInterceptOpen :|fopn|)
;  "Sort" from the database suite:

(defconstant $kAEDatabaseSuite :|DATA|)
(defconstant $kAESort :|SORT|)
; 
;   ////////////////////////////////////////////////////////////////////////
;    Classes
;    Note: all classes are defined up front so that the property definitions
;    can reference classes.
;   ////////////////////////////////////////////////////////////////////////
; 

(defconstant $cInternalFinderObject :|obj |)    ;  cReference - used to distinguish objects used inside the Finder only

; 
;    Main Finder class definitions
;    Indentation implies object model hierarchy
; 
;  We do not use class cItem from AERegistry.r. Instead our class Item is a cObject
;          cItem                        = 'citm',   // defined in AERegistry.r
;           cFile                    = 'file',  // defined in AERegistry.r

(defconstant $cAliasFile :|alia|)
(defconstant $cApplicationFile :|appf|)
(defconstant $cControlPanelFile :|ccdv|)
(defconstant $cDeskAccessoryFile :|dafi|)
(defconstant $cDocumentFile :|docf|)
(defconstant $cFontFile :|fntf|)
(defconstant $cSoundFile :|sndf|)
(defconstant $cClippingFile :|clpf|)
(defconstant $cContainer :|ctnr|)
(defconstant $cDesktop :|cdsk|)
(defconstant $cSharableContainer :|sctr|)
(defconstant $cDisk :|cdis|)
(defconstant $cFolder :|cfol|)
(defconstant $cSuitcase :|stcs|)
(defconstant $cAccessorySuitcase :|dsut|)
(defconstant $cFontSuitcase :|fsut|)
(defconstant $cTrash :|ctrs|)
(defconstant $cDesktopPrinter :|dskp|)
(defconstant $cPackage :|pack|)
(defconstant $cContentSpace :|dwnd|)            ;           cWindow                    = 'cwin',       // defined in AERegistry.r

(defconstant $cContainerWindow :|cwnd|)
(defconstant $cInfoWindow :|iwnd|)
(defconstant $cSharingWindow :|swnd|)
(defconstant $cStatusWindow :|qwnd|)
(defconstant $cClippingWindow :|lwnd|)
(defconstant $cPreferencesWindow :|pwnd|)
(defconstant $cDTPWindow :|dtpw|)
(defconstant $cProcess :|prcs|)
(defconstant $cAccessoryProcess :|pcda|)
(defconstant $cApplicationProcess :|pcap|)
(defconstant $cGroup :|sgrp|)
(defconstant $cUser :|cuse|)                    ;          cApplication                  = 'capp',     // defined in AERegistry.r

(defconstant $cSharingPrivileges :|priv|)
(defconstant $cPreferences :|cprf|)
(defconstant $cLabel :|clbl|)
(defconstant $cSound :|snd |)
(defconstant $cAliasList :|alst|)
(defconstant $cSpecialFolders :|spfl|)          ;  For use by viewer search engines:

(defconstant $cOnlineDisk :|cods|)
(defconstant $cOnlineLocalDisk :|clds|)
(defconstant $cOnlineRemoteDisk :|crds|)        ;  Miscellaneous class definitions

(defconstant $cEntireContents :|ects|)
(defconstant $cIconFamily :|ifam|)
; 
;   //////////////////////////////////////
;    Properties
;   //////////////////////////////////////
; 
;  Properties of class cItem (really cObject)
;     pBounds                        = 'pbnd',       // defined in AERegistry.r

(defconstant $pComment :|comt|)
(defconstant $pContainer :|ctnr|)
(defconstant $pContentSpace :|dwnd|)
(defconstant $pCreationDateOld :|crtd|)         ;  to support pre-Finder 8 scripts

(defconstant $pCreationDate :|ascd|)            ;  from File Commands OSAX

(defconstant $pDescription :|dscr|)
(defconstant $pDisk :|cdis|)
(defconstant $pFolderOld :|cfol|)               ;  to support pre-Finder 8 scripts

(defconstant $pFolder :|asdr|)                  ;  from File Commands OSAX

(defconstant $pIconBitmap :|iimg|)              ;     pID                           = 'ID  ',        // defined in AERegistry.r

(defconstant $pInfoWindow :|iwnd|)
(defconstant $pKind :|kind|)
(defconstant $pLabelIndex :|labi|)
(defconstant $pModificationDateOld :|modd|)     ;  to support pre-Finder 8 scripts

(defconstant $pModificationDate :|asmo|)        ;  from File Commands OSAX
;     pName                      = 'pnam',         // defined in AERegistry.r

(defconstant $pPhysicalSize :|phys|)
(defconstant $pPosition :|posn|)
(defconstant $pIsSelected :|issl|)
(defconstant $pSize :|ptsz|)                    ;  pPointSize defined in AERegistry.r

(defconstant $pWindow :|cwin|)
(defconstant $pPreferencesWindow :|pwnd|)
;  Properties of class cFile (subclass of cItem)

(defconstant $pFileCreator :|fcrt|)
(defconstant $pFileType :|asty|)                ;  from File Commands OSAX

(defconstant $pFileTypeOld :|fitp|)             ;  to support pre-Finder 8 scripts

(defconstant $pIsLocked :|aslk|)                ;  from File Commands OSAX

(defconstant $pIsLockedOld :|islk|)             ;  to support pre-Finder 8 scripts
;     pIsStationeryPad               = 'pspd',         // defined in AERegistry.r                
;     pVersion                    = 'vers',       // defined in AERegistry.r

(defconstant $pProductVersion :|ver2|)
;  Properties of class cAliasFile (subclass of cFile)

(defconstant $pOriginalItem :|orig|)
;  Properties of class cApplicationFile (subclass of cFile)

(defconstant $pMinAppPartition :|mprt|)
(defconstant $pAppPartition :|appt|)
(defconstant $pSuggestedAppPartition :|sprt|)
(defconstant $pIsScriptable :|isab|)
;  Properties of class cURLFile (subclass of cFile)

(defconstant $pInternetLocation :|iloc|)
;  Properties of class cSoundFile (subclass of cFile)

(defconstant $pSound :|snd |)
; 
;    Properties of class cControlPanel (Views CP only) (subclass of cFile)
;    Note: the other view-like preference settings are not available in the Views
;    control panel. These properties are only offered here for backward compatability.
;    To set the full range of Finder Preferences, use the Preferences object.
; 

(defconstant $pShowFolderSize :|sfsz|)          ;  Moved to a per-folder basis in Finder 8.0 HIS

(defconstant $pShowComment :|scom|)             ;  Moved to a per-folder basis in Finder 8.0 HIS

(defconstant $pShowDate :|sdat|)                ;  Moved to a per-folder basis in Finder 8.0 HIS

(defconstant $pShowCreationDate :|scda|)        ;  Moved to a per-folder basis in Finder 8.0 HIS

(defconstant $pShowKind :|sknd|)                ;  Moved to a per-folder basis in Finder 8.0 HIS

(defconstant $pShowLabel :|slbl|)               ;  Moved to a per-folder basis in Finder 8.0 HIS

(defconstant $pShowSize :|ssiz|)                ;  Moved to a per-folder basis in Finder 8.0 HIS

(defconstant $pShowVersion :|svrs|)             ;  Moved to a per-folder basis in Finder 8.0 HIS

(defconstant $pSortDirection :|sord|)
(defconstant $pShowDiskInfo :|sdin|)            ;  Always on in Finder 8.0 HIS

(defconstant $pListViewIconSize :|lvis|)        ;  Moved to a per-folder basis in Finder 8.0 HIS

(defconstant $pGridIcons :|fgrd|)               ;  Moved to a per-folder basis in Finder 8.0 HIS

(defconstant $pStaggerIcons :|fstg|)            ;  No longer part of the Finder 8.0 HIS

(defconstant $pViewFont :|vfnt|)
(defconstant $pViewFontSize :|vfsz|)
;  Properties of class cContainer (subclass of cItem)

(defconstant $pCompletelyExpanded :|pexc|)
(defconstant $pContainerWindow :|cwnd|)
(defconstant $pEntireContents :|ects|)
(defconstant $pExpandable :|pexa|)
(defconstant $pExpanded :|pexp|)
(defconstant $pPreviousView :|svew|)            ;     pSelection                    = 'sele',       // defined in AERegistry.r

(defconstant $pView :|pvew|)
(defconstant $pIconSize :|lvis|)                ;  defined above

(defconstant $pKeepArranged :|arrg|)            ;  OBSOLETE in Finder 9 or later

(defconstant $pKeepArrangedBy :|arby|)          ;  OBSOLETE in Finder 9 or later

;  Properties of class cDesktop (subclass of cContainer)

(defconstant $pStartupDisk :|sdsk|)
(defconstant $pTrash :|trsh|)
;  Properties of class cSharableContainer (subclass of cContainer)

(defconstant $pOwner :|sown|)
(defconstant $pOwnerPrivileges :|ownr|)
(defconstant $pGroup :|sgrp|)
(defconstant $pGroupPrivileges :|gppr|)
(defconstant $pGuestPrivileges :|gstp|)
(defconstant $pArePrivilegesInherited :|iprv|)
(defconstant $pExported :|sexp|)
(defconstant $pMounted :|smou|)
(defconstant $pSharingProtection :|spro|)
(defconstant $pSharing :|shar|)
(defconstant $pSharingWindow :|swnd|)
;  Properties of class cDisk (subclass of cSharableContainer)

(defconstant $pCapacity :|capa|)
(defconstant $pEjectable :|isej|)
(defconstant $pFreeSpace :|frsp|)
(defconstant $pLocal :|isrv|)
(defconstant $pIsStartup :|istd|)
;  Properties of class cTrash (subclass of cSharableContainer)

(defconstant $pWarnOnEmpty :|warn|)
;  Properties of class cWindow (subclass of cContentSpace)
;     pBounds                        = 'pbnd',   // defined in AERegistry.r
;     pHasCloseBox                = 'hclb',     // defined in AERegistry.r
;     pIsFloating                    = 'isfl',     // defined in AERegistry.r
;     pIndex                     = 'pidx',     // defined in AERegistry.r
;     pIsModal                    = 'pmod',   // defined in AERegistry.r
;     pPosition                    = 'posn',     // defined above
;     pIsResizable                = 'prsz',     // defined in AERegistry.r
;     pHasTitleBar                = 'ptit',     // defined in AERegistry.r
;     pVisible                    = 'pvis',   // defined in AERegistry.r
;     pIsZoomable                    = 'iszm',     // defined in AERegistry.r
;     pIsZoomed                    = 'pzum',     // defined in AERegistry.r

(defconstant $pIsZoomedFull :|zumf|)
(defconstant $pIsPopup :|drwr|)
(defconstant $pIsPulledOpen :|pull|)            ;  only applies to popup windows

(defconstant $pIsCollapsed :|wshd|)             ;  only applies to normal windows

;  Properties of class cContainerWindow (subclass of cWindow)

(defconstant $pObject :|cobj|)
;  Properties of class cSharingWindow (subclass of cWindow)

(defconstant $pSharableContainer :|sctr|)
;  Properties of class cInfoWindow (subclass of cWindow)

(defconstant $pInfoPanel :|panl|)
;  Properties of networking support

(defconstant $pFileShareOn :|fshr|)
(defconstant $pFileShareStartingUp :|fsup|)
(defconstant $pProgramLinkingOn :|iac |)
;  Properties of class cPreferencesWindow (subclass of cWindow)
;     pShowFolderSize                   = 'sfsz',         // defined above for Views CP
;     pShowComment                = 'scom',      // defined above for Views CP

(defconstant $pShowModificationDate :|sdat|)    ;  pShowDate defined above for Views CP
;     pShowKind                    = 'sknd',        // defined above for Views CP
;     pShowLabel                    = 'slbl',         // defined above for Views CP
;     pShowSize                    = 'ssiz',        // defined above for Views CP
;     pShowVersion                = 'svrs',      // defined above for Views CP
;     pShowCreationDate             = 'scda',      // Removed from Finder 8.0 HIS
;     pShowFileType                 = 'sfty',       // Removed from Finder 8.0 HIS
;     pShowFileCreator               = 'sfcr',         // Removed from Finder 8.0 HIS
;     pListViewIconSize             = 'lvis',      // defined above for Views CP
;     pGridIcons                    = 'fgrd',         // defined above for Views CP
;     pStaggerIcons                 = 'fstg',       // defined above for Views CP
;     pViewFont                    = 'vfnt',        // defined above for Views CP
;     pViewFontSize                 = 'vfsz',       // defined above for Views CP

(defconstant $pUseRelativeDate :|urdt|)         ;  Moved to a per-folder basis in Finder 8.0 HIS

(defconstant $pDelayBeforeSpringing :|dela|)
(defconstant $pSpringOpenFolders :|sprg|)
(defconstant $pUseShortMenus :|usme|)
(defconstant $pUseWideGrid :|uswg|)
(defconstant $pLabel1 :|lbl1|)
(defconstant $pLabel2 :|lbl2|)
(defconstant $pLabel3 :|lbl3|)
(defconstant $pLabel4 :|lbl4|)
(defconstant $pLabel5 :|lbl5|)
(defconstant $pLabel6 :|lbl6|)
(defconstant $pLabel7 :|lbl7|)
(defconstant $pDefaultIconViewIconSize :|iisz|)
(defconstant $pDefaultButtonViewIconSize :|bisz|)
(defconstant $pDefaultListViewIconSize :|lisz|) ;  old use of this name is now pIconSize

(defconstant $pIconViewArrangement :|iarr|)
(defconstant $pButtonViewArrangement :|barr|)
; 
;    The next bunch are the various arrangements that make up
;    enumArrangement
; 

(defconstant $pNoArrangement :|narr|)
(defconstant $pSnapToGridArrangement :|grda|)
(defconstant $pByNameArrangement :|nama|)
(defconstant $pByModificationDateArrangement :|mdta|)
(defconstant $pByCreationDateArrangement :|cdta|)
(defconstant $pBySizeArrangement :|siza|)
(defconstant $pByKindArrangement :|kina|)
(defconstant $pByLabelArrangement :|laba|)
;   #define pObject                                 cObject         // defined above
;  Properties of class cProcess (subclass of cObject)
;     pName                      = 'pnam',         // defined in AERegistry.r

(defconstant $pFile :|file|)                    ;     pCreatorType                = 'fcrt',      // defined above
;     pFileType                    = 'asty',        // defined above
;     pIsFrontProcess                   = 'pisf',         // defined in AERegistry.r
;     pAppPartition                 = 'appt',       // defined above

(defconstant $pPartitionSpaceUsed :|pusd|)      ;     pIsScriptable                 = 'isab',       // defined in AERegistry.r
;     pVisible                    = 'pvis'      // defined in AERegistry.r

(defconstant $pLocalAndRemoteEvents :|revt|)
(defconstant $pHasScriptingTerminology :|hscr|)
;  Properties of class cAccessoryProcess (subclass of cProcess)

(defconstant $pDeskAccessoryFile :|dafi|)
;  Properties of class cApplicationProcess (subclass of cProcess)

(defconstant $pApplicationFile :|appf|)
; 
;    Properties of class cGroup (subclass of cObject)
;   enum {
;     pBounds
;     pIconBitmap
;     pLabelIndex
;     pName
;     pPosition
;     pWindow                                 = cWindow           // defined above
;   };
; 
;  Properties of class cUser (subclass of cObject)
;     pBounds
;     pIconBitmap
;     pLabelIndex
;     pName
;     pPosition
;     pWindow                        = cWindow,        // defined above

(defconstant $pCanConnect :|ccon|)
(defconstant $pCanChangePassword :|ccpw|)
(defconstant $pCanDoProgramLinking :|ciac|)
(defconstant $pIsOwner :|isow|)
(defconstant $pARADialIn :|arad|)
(defconstant $pShouldCallBack :|calb|)
(defconstant $pCallBackNumber :|cbnm|)
; 
;    Properties of class cApplication (subclass of cObject)
;    NOTE: properties for the special folders must match their respective kXXXFolderType constants
; 

(defconstant $pAboutMacintosh :|abbx|)
(defconstant $pAppleMenuItemsFolder :|amnu|)    ;  kAppleMenuFolderType
;     pClipboard                    = 'pcli',         // defined in AERegistry.r

(defconstant $pControlPanelsFolder :|ctrl|)     ;  kControlPanelFolderType

(defconstant $pDesktop :|desk|)                 ;  kDesktopFolderType

(defconstant $pExtensionsFolder :|extn|)        ;  kExtensionFolderType
;     pFileShareOn                = 'fshr',      // defined above

(defconstant $pFinderPreferences :|pfrp|)
(defconstant $pFontsFolder :|font|)
(defconstant $pFontsFolderPreAllegro :|ffnt|)   ;  DO NOT USE THIS - FOR BACKWARDS COMPAT ONLY
;     pIsFrontProcess                   = 'pisf',         // defined in AERegistry.r
;     pInsertionLoc                 = 'pins',       // defined in AERegistry.r

(defconstant $pLargestFreeBlock :|mfre|)
(defconstant $pPreferencesFolder :|pref|)       ;  kPreferencesFolderType
;     pProductVersion                   = 'ver2',         // defined above
;     pUserSelection                  = 'pusl',        // defined in AERegistry.r
;     pFileShareStartingUp             = 'fsup',        // defined above

(defconstant $pShortCuts :|scut|)
(defconstant $pShutdownFolder :|shdf|)
(defconstant $pStartupItemsFolder :|strt|)      ;  kStartupFolderType

(defconstant $pSystemFolder :|macs|)            ;  kSystemFolderType

(defconstant $pTemporaryFolder :|temp|)         ;  kTemporaryFolderType
;     pVersion                    = 'vers',       // defined in AERegistry.r

(defconstant $pViewPreferences :|pvwp|)         ;     pVisible                    = 'pvis',       // defined in AERegistry.r

(defconstant $pStartingUp :|awak|)              ;  private property to tell whether the Finder is fully up and running

;  Properties of class cSharingPrivileges (subclass of cObject)

(defconstant $pSeeFiles :|prvr|)
(defconstant $pSeeFolders :|prvs|)
(defconstant $pMakeChanges :|prvw|)
; 
;    Properties of class cPreferences (subclass of cObject)
;   enum {
;     pShowFolderSize                         = 'sfsz',           // defined above for Views CP
;     pShowComment                            = 'scom',           // defined above for Views CP
;     pShowModificationDate                   = pShowDate,            // pShowDate defined above for Views CP
;     pShowKind                               = 'sknd',           // defined above for Views CP
;     pShowLabel                              = 'slbl',           // defined above for Views CP
;     pShowSize                               = 'ssiz',           // defined above for Views CP
;     pShowVersion                            = 'svrs',           // defined above for Views CP
;     pShowCreationDate                       = 'scda',           // defined in cPreferencesWindow
;     pShowFileType                           = 'sfty',           // defined in cPreferencesWindow
;     pShowFileCreator                        = 'sfcr',           // defined in cPreferencesWindow
;     pListViewIconSize                       = 'lvis',           // defined above for Views CP
;     pGridIcons                              = 'fgrd',           // defined above for Views CP
;     pStaggerIcons                           = 'fstg',           // defined above for Views CP
;     pViewFont                               = 'vfnt',           // defined above for Views CP
;     pViewFontSize                           = 'vfsz',           // defined above for Views CP
;     pUseRelativeDate                        = 'urdt',           // defined in cPreferencesWindow
;     pDelayBeforeSpringing                   = 'dela',           // defined in cPreferencesWindow
;     pShowMacOSFolder                        = 'sosf',           // defined in cPreferencesWindow
;     pUseShortMenus                          = 'usme',           // defined in cPreferencesWindow
;     pUseCustomNewMenu                       = 'ucnm',           // defined in cPreferencesWindow
;     pShowDesktopInBackground                = 'sdtb',           // defined in cPreferencesWindow
;     pActivateDesktopOnClick                 = 'adtc',           // defined in cPreferencesWindow
;     pLabel1                                 = 'lbl1',           // defined in cPreferencesWindow
;     pLabel2                                 = 'lbl2',           // defined in cPreferencesWindow
;     pLabel3                                 = 'lbl3',           // defined in cPreferencesWindow
;     pLabel4                                 = 'lbl4',           // defined in cPreferencesWindow
;     pLabel5                                 = 'lbl5',           // defined in cPreferencesWindow
;     pLabel6                                 = 'lbl6',           // defined in cPreferencesWindow
;     pLabel7                                 = 'lbl7',           // defined in cPreferencesWindow
;     pWindow                                 = cWindow           // defined above
;   };
; 
; 
;    Properties of class cLabel (subclass of cObject)
;   enum {
;     pName                                   = 'pnam',           // defined in AERegistry.r
;     pColor                                  = 'colr',           // defined in AERegistry.r
;   };
; 
;  Misc Properties

(defconstant $pSmallIcon :|smic|)
(defconstant $pSmallButton :|smbu|)
(defconstant $pLargeButton :|lgbu|)
(defconstant $pGrid :|grid|)
; 
;   //////////////////////////////////////
;    Enumerations defined by the Finder
;   //////////////////////////////////////
; 

(defconstant $enumViewBy :|vwby|)
(defconstant $enumGestalt :|gsen|)
(defconstant $enumConflicts :|cflc|)
(defconstant $enumExistingItems :|exsi|)
(defconstant $enumOlderItems :|oldr|)

(defconstant $enumDate :|enda|)
(defconstant $enumAnyDate :|anyd|)
(defconstant $enumToday :|tday|)
(defconstant $enumYesterday :|yday|)
(defconstant $enumThisWeek :|twek|)
(defconstant $enumLastWeek :|lwek|)
(defconstant $enumThisMonth :|tmon|)
(defconstant $enumLastMonth :|lmon|)
(defconstant $enumThisYear :|tyer|)
(defconstant $enumLastYear :|lyer|)
(defconstant $enumBeforeDate :|bfdt|)
(defconstant $enumAfterDate :|afdt|)
(defconstant $enumBetweenDate :|btdt|)
(defconstant $enumOnDate :|ondt|)

(defconstant $enumAllDocuments :|alld|)
(defconstant $enumFolders :|fold|)
(defconstant $enumAliases :|alia|)
(defconstant $enumStationery :|stat|)

(defconstant $enumWhere :|wher|)
(defconstant $enumAllLocalDisks :|aldk|)
(defconstant $enumAllRemoteDisks :|ardk|)
(defconstant $enumAllDisks :|alld|)
(defconstant $enumAllOpenFolders :|aofo|)

(defconstant $enumIconSize :|isiz|)
(defconstant $enumSmallIconSize :|smic|)
(defconstant $enumMiniIconSize :|miic|)
(defconstant $enumLargeIconSize :|lgic|)

(defconstant $enumSortDirection :|sodr|)
(defconstant $enumSortDirectionNormal :|snrm|)
(defconstant $enumSortDirectionReverse :|srvs|)

(defconstant $enumArrangement :|earr|)
;  Get Info Window panel enumeration

(defconstant $enumInfoWindowPanel :|ipnl|)
(defconstant $enumGeneralPanel :|gpnl|)
(defconstant $enumSharingPanel :|spnl|)
(defconstant $enumStatusNConfigPanel :|scnl|)
(defconstant $enumFontsPanel :|fpnl|)
(defconstant $enumMemoryPanel :|mpnl|)
;  Preferences panel enumeration

(defconstant $enumPrefsWindowPanel :|pple|)
(defconstant $enumPrefsGeneralPanel :|pgnp|)
(defconstant $enumPrefsLabelPanel :|plbp|)
(defconstant $enumPrefsIconViewPanel :|pivp|)
(defconstant $enumPrefsButtonViewPanel :|pbvp|)
(defconstant $enumPrefsListViewPanel :|plvp|)
; 
;   //////////////////////////////////////
;    Types defined by the Finder
;   //////////////////////////////////////
; 

(defconstant $typeIconFamily :|ifam|)           ;  An AEList of typeIconAndMask, type8BitIcon, & c.

(defconstant $typeIconAndMask :|ICN#|)
(defconstant $type8BitMask :|l8mk|)
(defconstant $type32BitIcon :|il32|)
(defconstant $type8BitIcon :|icl8|)
(defconstant $type4BitIcon :|icl4|)
(defconstant $typeSmallIconAndMask :|ics#|)
(defconstant $typeSmall8BitMask :|s8mk|)
(defconstant $typeSmall32BitIcon :|is32|)
(defconstant $typeSmall8BitIcon :|ics8|)
(defconstant $typeSmall4BitIcon :|ics4|)
(defconstant $typeRelativeTime :|rtim|)
(defconstant $typeConceptualTime :|timc|)
; 
;   //////////////////////////////////////
;    Keywords defined by the Finder
;   //////////////////////////////////////
; 

(defconstant $keyIconAndMask :|ICN#|)
(defconstant $key32BitIcon :|il32|)
(defconstant $key8BitIcon :|icl8|)
(defconstant $key4BitIcon :|icl4|)
(defconstant $key8BitMask :|l8mk|)
(defconstant $keySmallIconAndMask :|ics#|)
(defconstant $keySmall8BitIcon :|ics8|)
(defconstant $keySmall4BitIcon :|ics4|)
(defconstant $keySmall32BitIcon :|is32|)
(defconstant $keySmall8BitMask :|s8mk|)
(defconstant $keyMini1BitMask :|icm#|)
(defconstant $keyMini4BitIcon :|icm4|)
(defconstant $keyMini8BitIcon :|icm8|)
(defconstant $keyAEUsing :|usin|)
(defconstant $keyAEReplacing :|alrp|)
(defconstant $keyAENoAutoRouting :|rout|)
(defconstant $keyLocalPositionList :|mvpl|)
(defconstant $keyGlobalPositionList :|mvpg|)
(defconstant $keyRedirectedDocumentList :|fpdl|)
; 
;   //////////////////////////////////////
;    New prepositions used by the Finder
;   //////////////////////////////////////
; 

(defconstant $keyASPrepositionHas :|has |)
(defconstant $keyAll :|kyal|)
(defconstant $keyOldFinderItems :|fsel|)
; 
;   //////////////////////////////////////
;    New key forms used by the Finder
;   //////////////////////////////////////
; 

(defconstant $formAlias :|alis|)
(defconstant $formCreator :|fcrt|)
; 
;   //////////////////////////////////////
;    Finder error codes
;   //////////////////////////////////////
; 

(defconstant $errFinderIsBusy -15260)
(defconstant $errFinderWindowNotOpen -15261)
(defconstant $errFinderCannotPutAway -15262)
(defconstant $errFinderWindowMustBeIconView -15263);  RequireWindowInIconView

(defconstant $errFinderWindowMustBeListView -15264);  RequireWindowInListView

(defconstant $errFinderCantMoveToDestination -15265)
(defconstant $errFinderCantMoveSource -15266)
(defconstant $errFinderCantOverwrite -15267)
(defconstant $errFinderIncestuousMove -15268)   ;  Could just use errFinderCantMoveSource

(defconstant $errFinderCantMoveToAncestor -15269);  Could also use errFinderCantMoveSource

(defconstant $errFinderCantUseTrashedItems -15270)
(defconstant $errFinderItemAlreadyInDest -15271);  Move from folder A to folder A

(defconstant $errFinderUnknownUser -15272)      ;  Includes unknown group

(defconstant $errFinderSharePointsCantInherit -15273)
(defconstant $errFinderWindowWrongType -15274)
(defconstant $errFinderPropertyNowWindowBased -15275)
(defconstant $errFinderAppFolderProtected -15276);  used by General controls when folder protection is on

(defconstant $errFinderSysFolderProtected -15277);  used by General controls when folder protection is on

(defconstant $errFinderBoundsWrong -15278)
(defconstant $errAEValueOutOfRange -15279)
(defconstant $errFinderPropertyDoesNotApply -15280)
(defconstant $errFinderFileSharingMustBeOn -15281)
(defconstant $errFinderMustBeActive -15282)
(defconstant $errFinderVolumeNotFound -15283)   ;  more descriptive than what we get with nsvErr

(defconstant $errFinderLockedItemsInTrash -15284);  there are some locked items in the trash

(defconstant $errFinderOnlyLockedItemsInTrash -15285);  all the items (except folders) in the trash are locked

(defconstant $errFinderProgramLinkingMustBeOn -15286)
(defconstant $errFinderWindowMustBeButtonView -15287)
(defconstant $errFinderBadPackageContents -15288);  something is wrong within the package   

(defconstant $errFinderUnsupportedInsidePackages -15289);  operation cannot be used on items within a package     

(defconstant $errFinderCorruptOpenFolderList -15290);  was -15276 in Finder 8.6 and earlier, but that conflicted with General Controls

(defconstant $errFinderNoInvisibleFiles -15291) ;  was -15277 in Finder 8.6 and earlier, but that conflicted with General Controls

(defconstant $errFinderCantDeleteImmediately -15292);  cannot delete immediately via scripting

(defconstant $errFinderLastReserved -15379)

; #endif /* __FINDERREGISTRY__ */


(provide-interface "FinderRegistry")