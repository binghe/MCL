(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Icons.h"
; at Sunday July 2,2006 7:24:37 pm.
; 
;      File:       HIServices/Icons.h
;  
;      Contains:   Icon Utilities and Icon Services Interfaces.
;  
;      Version:    HIServices-125.6~1
;  
;      Copyright:  © 1990-2003 by Apple Computer, Inc. All rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __ICONS__
; #define __ICONS__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __QUICKDRAW__
#| #|
#include <QDQuickdraw.h>
#endif
|#
 |#
; #ifndef __CGCONTEXT__

(require-interface "CoreGraphics/CGContext")

; #endif


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
;  The following are icons for which there are both icon suites and SICNs. 
;  Avoid using icon resources if possible. Use IconServices instead. 

(defconstant $kGenericDocumentIconResource -4000)
(defconstant $kGenericStationeryIconResource -3985)
(defconstant $kGenericEditionFileIconResource -3989)
(defconstant $kGenericApplicationIconResource -3996)
(defconstant $kGenericDeskAccessoryIconResource -3991)
(defconstant $kGenericFolderIconResource -3999)
(defconstant $kPrivateFolderIconResource -3994)
(defconstant $kFloppyIconResource -3998)
(defconstant $kTrashIconResource -3993)
(defconstant $kGenericRAMDiskIconResource -3988)
(defconstant $kGenericCDROMIconResource -3987)
;  The following are icons for which there are SICNs only. 
;  Avoid using icon resources if possible. Use IconServices instead. 

(defconstant $kDesktopIconResource -3992)
(defconstant $kOpenFolderIconResource -3997)
(defconstant $kGenericHardDiskIconResource -3995)
(defconstant $kGenericFileServerIconResource -3972)
(defconstant $kGenericSuitcaseIconResource -3970)
(defconstant $kGenericMoverObjectIconResource -3969)
;  The following are icons for which there are icon suites only. 
;  Avoid using icon resources if possible. Use IconServices instead. 

(defconstant $kGenericPreferencesIconResource -3971)
(defconstant $kGenericQueryDocumentIconResource -16506)
(defconstant $kGenericExtensionIconResource -16415)
(defconstant $kSystemFolderIconResource -3983)
(defconstant $kHelpIconResource -20271)
(defconstant $kAppleMenuFolderIconResource -3982)
;  Obsolete. Use named constants defined above. 

(defconstant $genericDocumentIconResource -4000)
(defconstant $genericStationeryIconResource -3985)
(defconstant $genericEditionFileIconResource -3989)
(defconstant $genericApplicationIconResource -3996)
(defconstant $genericDeskAccessoryIconResource -3991)
(defconstant $genericFolderIconResource -3999)
(defconstant $privateFolderIconResource -3994)
(defconstant $floppyIconResource -3998)
(defconstant $trashIconResource -3993)
(defconstant $genericRAMDiskIconResource -3988)
(defconstant $genericCDROMIconResource -3987)
(defconstant $desktopIconResource -3992)
(defconstant $openFolderIconResource -3997)
(defconstant $genericHardDiskIconResource -3995)
(defconstant $genericFileServerIconResource -3972)
(defconstant $genericSuitcaseIconResource -3970)
(defconstant $genericMoverObjectIconResource -3969)
(defconstant $genericPreferencesIconResource -3971)
(defconstant $genericQueryDocumentIconResource -16506)
(defconstant $genericExtensionIconResource -16415)
(defconstant $systemFolderIconResource -3983)
(defconstant $appleMenuFolderIconResource -3982)
;  Avoid using icon resources if possible. Use IconServices instead. 

(defconstant $kStartupFolderIconResource -3981)
(defconstant $kOwnedFolderIconResource -3980)
(defconstant $kDropFolderIconResource -3979)
(defconstant $kSharedFolderIconResource -3978)
(defconstant $kMountedFolderIconResource -3977)
(defconstant $kControlPanelFolderIconResource -3976)
(defconstant $kPrintMonitorFolderIconResource -3975)
(defconstant $kPreferencesFolderIconResource -3974)
(defconstant $kExtensionsFolderIconResource -3973)
(defconstant $kFontsFolderIconResource -3968)
(defconstant $kFullTrashIconResource -3984)
;  Obsolete. Use named constants defined above. 

(defconstant $startupFolderIconResource -3981)
(defconstant $ownedFolderIconResource -3980)
(defconstant $dropFolderIconResource -3979)
(defconstant $sharedFolderIconResource -3978)
(defconstant $mountedFolderIconResource -3977)
(defconstant $controlPanelFolderIconResource -3976)
(defconstant $printMonitorFolderIconResource -3975)
(defconstant $preferencesFolderIconResource -3974)
(defconstant $extensionsFolderIconResource -3973)
(defconstant $fontsFolderIconResource -3968)
(defconstant $fullTrashIconResource -3984)
;  Alignment type values. 

(defconstant $kAlignNone 0)
(defconstant $kAlignVerticalCenter 1)
(defconstant $kAlignTop 2)
(defconstant $kAlignBottom 3)
(defconstant $kAlignHorizontalCenter 4)
(defconstant $kAlignAbsoluteCenter 5)
(defconstant $kAlignCenterTop 6)
(defconstant $kAlignCenterBottom 7)
(defconstant $kAlignLeft 8)
(defconstant $kAlignCenterLeft 9)
(defconstant $kAlignTopLeft 10)
(defconstant $kAlignBottomLeft 11)
(defconstant $kAlignRight 12)
(defconstant $kAlignCenterRight 13)
(defconstant $kAlignTopRight 14)
(defconstant $kAlignBottomRight 15)
;  Obsolete. Use names defined above. 

(defconstant $atNone 0)
(defconstant $atVerticalCenter 1)
(defconstant $atTop 2)
(defconstant $atBottom 3)
(defconstant $atHorizontalCenter 4)
(defconstant $atAbsoluteCenter 5)
(defconstant $atCenterTop 6)
(defconstant $atCenterBottom 7)
(defconstant $atLeft 8)
(defconstant $atCenterLeft 9)
(defconstant $atTopLeft 10)
(defconstant $atBottomLeft 11)
(defconstant $atRight 12)
(defconstant $atCenterRight 13)
(defconstant $atTopRight 14)
(defconstant $atBottomRight 15)

(def-mactype :IconAlignmentType (find-mactype ':SInt16))
;  Transform type values. 

(defconstant $kTransformNone 0)
(defconstant $kTransformDisabled 1)
(defconstant $kTransformOffline 2)
(defconstant $kTransformOpen 3)
(defconstant $kTransformLabel1 #x100)
(defconstant $kTransformLabel2 #x200)
(defconstant $kTransformLabel3 #x300)
(defconstant $kTransformLabel4 #x400)
(defconstant $kTransformLabel5 #x500)
(defconstant $kTransformLabel6 #x600)
(defconstant $kTransformLabel7 #x700)
(defconstant $kTransformSelected #x4000)
(defconstant $kTransformSelectedDisabled #x4001)
(defconstant $kTransformSelectedOffline #x4002)
(defconstant $kTransformSelectedOpen #x4003)
;  Obsolete. Use names defined above. 

(defconstant $ttNone 0)
(defconstant $ttDisabled 1)
(defconstant $ttOffline 2)
(defconstant $ttOpen 3)
(defconstant $ttLabel1 #x100)
(defconstant $ttLabel2 #x200)
(defconstant $ttLabel3 #x300)
(defconstant $ttLabel4 #x400)
(defconstant $ttLabel5 #x500)
(defconstant $ttLabel6 #x600)
(defconstant $ttLabel7 #x700)
(defconstant $ttSelected #x4000)
(defconstant $ttSelectedDisabled #x4001)
(defconstant $ttSelectedOffline #x4002)
(defconstant $ttSelectedOpen #x4003)

(def-mactype :IconTransformType (find-mactype ':SInt16))
;  Selector mask values. 

(defconstant $kSelectorLarge1Bit 1)
(defconstant $kSelectorLarge4Bit 2)
(defconstant $kSelectorLarge8Bit 4)
(defconstant $kSelectorLarge32Bit 8)
(defconstant $kSelectorLarge8BitMask 16)
(defconstant $kSelectorSmall1Bit #x100)
(defconstant $kSelectorSmall4Bit #x200)
(defconstant $kSelectorSmall8Bit #x400)
(defconstant $kSelectorSmall32Bit #x800)
(defconstant $kSelectorSmall8BitMask #x1000)
(defconstant $kSelectorMini1Bit #x10000)
(defconstant $kSelectorMini4Bit #x20000)
(defconstant $kSelectorMini8Bit #x40000)
(defconstant $kSelectorHuge1Bit #x1000000)
(defconstant $kSelectorHuge4Bit #x2000000)
(defconstant $kSelectorHuge8Bit #x4000000)
(defconstant $kSelectorHuge32Bit #x8000000)
(defconstant $kSelectorHuge8BitMask #x10000000)
(defconstant $kSelectorAllLargeData #xFF)
(defconstant $kSelectorAllSmallData #xFF00)
(defconstant $kSelectorAllMiniData #xFF0000)
(defconstant $kSelectorAllHugeData #xFF000000)
(defconstant $kSelectorAll1BitData #x1010101)
(defconstant $kSelectorAll4BitData #x2020202)
(defconstant $kSelectorAll8BitData #x4040404)
(defconstant $kSelectorAll32BitData #x8000808)
(defconstant $kSelectorAllAvailableData #xFFFFFFFF)
;  Obsolete. Use names defined above. 

(defconstant $svLarge1Bit 1)
(defconstant $svLarge4Bit 2)
(defconstant $svLarge8Bit 4)
(defconstant $svSmall1Bit #x100)
(defconstant $svSmall4Bit #x200)
(defconstant $svSmall8Bit #x400)
(defconstant $svMini1Bit #x10000)
(defconstant $svMini4Bit #x20000)
(defconstant $svMini8Bit #x40000)
(defconstant $svAllLargeData #xFF)
(defconstant $svAllSmallData #xFF00)
(defconstant $svAllMiniData #xFF0000)
(defconstant $svAll1BitData #x1010101)
(defconstant $svAll4BitData #x2020202)
(defconstant $svAll8BitData #x4040404)
(defconstant $svAllAvailableData #xFFFFFFFF)

(def-mactype :IconSelectorValue (find-mactype ':UInt32))

(def-mactype :IconActionProcPtr (find-mactype ':pointer)); (ResType theType , Handle * theIcon , void * yourDataPtr)

(def-mactype :IconGetterProcPtr (find-mactype ':pointer)); (ResType theType , void * yourDataPtr)

(def-mactype :IconActionUPP (find-mactype '(:pointer :OpaqueIconActionProcPtr)))

(def-mactype :IconGetterUPP (find-mactype '(:pointer :OpaqueIconGetterProcPtr)))
; 
;  *  NewIconActionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewIconActionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueIconActionProcPtr)
() )
; 
;  *  NewIconGetterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewIconGetterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueIconGetterProcPtr)
() )
; 
;  *  DisposeIconActionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeIconActionUPP" 
   ((userUPP (:pointer :OpaqueIconActionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeIconGetterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeIconGetterUPP" 
   ((userUPP (:pointer :OpaqueIconGetterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeIconActionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeIconActionUPP" 
   ((theType :FourCharCode)
    (theIcon (:pointer :Handle))
    (yourDataPtr :pointer)
    (userUPP (:pointer :OpaqueIconActionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeIconGetterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeIconGetterUPP" 
   ((theType :FourCharCode)
    (yourDataPtr :pointer)
    (userUPP (:pointer :OpaqueIconGetterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )

(def-mactype :IconGetter (find-mactype ':pointer))

(def-mactype :IconAction (find-mactype ':pointer))
;  CIconHandle, GetCIcon(), PlotCIcon(), and DisposeCIcon() moved here from Quickdraw.h
(defrecord (CIcon :handle)
   (iconPMap :PixMap)                           ; the icon's pixMap
   (iconMask :BitMap)                           ; the icon's mask
   (iconBMap :BitMap)                           ; the icon's bitMap
   (iconData :Handle)                           ; the icon's data
   (iconMaskData (:array :SInt16 1))            ; icon's mask and BitMap data
)

;type name? (%define-record :CIcon (find-record-descriptor ':CIcon))

(def-mactype :CIconPtr (find-mactype '(:pointer :CIcon)))

(def-mactype :CIconHandle (find-mactype '(:handle :CIcon)))
; 
;  *  GetCIcon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetCIcon" 
   ((iconID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :CIcon)
() )
; 
;  *  PlotCIcon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PlotCIcon" 
   ((theRect (:pointer :Rect))
    (theIcon (:Handle :CIcon))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCIcon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposeCIcon" 
   ((theIcon (:Handle :CIcon))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  GetIcon and PlotIcon moved here from ToolUtils
; 
;  *  GetIcon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetIcon" 
   ((iconID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  PlotIcon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PlotIcon" 
   ((theRect (:pointer :Rect))
    (theIcon :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     Note:   IconSuiteRef and IconCacheRef should be an abstract types, 
;             but too much source code already relies on them being of type Handle.
; 

(def-mactype :IconSuiteRef (find-mactype ':Handle))

(def-mactype :IconCacheRef (find-mactype ':Handle))
;  IconRefs are 32-bit values identifying cached icon data. IconRef 0 is invalid.

(def-mactype :IconRef (find-mactype '(:pointer :OpaqueIconRef)))
; 
;  *  PlotIconID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PlotIconID" 
   ((theRect (:pointer :Rect))
    (align :SInt16)
    (transform :SInt16)
    (theResID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewIconSuite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewIconSuite" 
   ((theIconSuite (:pointer :ICONSUITEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AddIconToSuite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AddIconToSuite" 
   ((theIconData :Handle)
    (theSuite :Handle)
    (theType :FourCharCode)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetIconFromSuite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetIconFromSuite" 
   ((theIconData (:pointer :Handle))
    (theSuite :Handle)
    (theType :FourCharCode)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ForEachIconDo()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ForEachIconDo" 
   ((theSuite :Handle)
    (selector :UInt32)
    (action (:pointer :OpaqueIconActionProcPtr))
    (yourDataPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetIconSuite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetIconSuite" 
   ((theIconSuite (:pointer :ICONSUITEREF))
    (theResID :SInt16)
    (selector :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DisposeIconSuite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposeIconSuite" 
   ((theIconSuite :Handle)
    (disposeData :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PlotIconSuite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PlotIconSuite" 
   ((theRect (:pointer :Rect))
    (align :SInt16)
    (transform :SInt16)
    (theIconSuite :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  MakeIconCache()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MakeIconCache" 
   ((theCache (:pointer :ICONCACHEREF))
    (makeIcon (:pointer :OpaqueIconGetterProcPtr))
    (yourDataPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  LoadIconCache()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LoadIconCache" 
   ((theRect (:pointer :Rect))
    (align :SInt16)
    (transform :SInt16)
    (theIconCache :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PlotIconMethod()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PlotIconMethod" 
   ((theRect (:pointer :Rect))
    (align :SInt16)
    (transform :SInt16)
    (theMethod (:pointer :OpaqueIconGetterProcPtr))
    (yourDataPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetLabel()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Panther
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetLabel" 
   ((labelNumber :SInt16)
    (labelColor (:pointer :RGBColor))
    (labelString (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PtInIconID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PtInIconID" 
   ((testPt :Point)
    (iconRect (:pointer :Rect))
    (align :SInt16)
    (iconID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  PtInIconSuite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PtInIconSuite" 
   ((testPt :Point)
    (iconRect (:pointer :Rect))
    (align :SInt16)
    (theIconSuite :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  PtInIconMethod()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PtInIconMethod" 
   ((testPt :Point)
    (iconRect (:pointer :Rect))
    (align :SInt16)
    (theMethod (:pointer :OpaqueIconGetterProcPtr))
    (yourDataPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  RectInIconID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RectInIconID" 
   ((testRect (:pointer :Rect))
    (iconRect (:pointer :Rect))
    (align :SInt16)
    (iconID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  RectInIconSuite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RectInIconSuite" 
   ((testRect (:pointer :Rect))
    (iconRect (:pointer :Rect))
    (align :SInt16)
    (theIconSuite :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  RectInIconMethod()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RectInIconMethod" 
   ((testRect (:pointer :Rect))
    (iconRect (:pointer :Rect))
    (align :SInt16)
    (theMethod (:pointer :OpaqueIconGetterProcPtr))
    (yourDataPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  IconIDToRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_IconIDToRgn" 
   ((theRgn (:pointer :OpaqueRgnHandle))
    (iconRect (:pointer :Rect))
    (align :SInt16)
    (iconID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  IconSuiteToRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_IconSuiteToRgn" 
   ((theRgn (:pointer :OpaqueRgnHandle))
    (iconRect (:pointer :Rect))
    (align :SInt16)
    (theIconSuite :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  IconMethodToRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_IconMethodToRgn" 
   ((theRgn (:pointer :OpaqueRgnHandle))
    (iconRect (:pointer :Rect))
    (align :SInt16)
    (theMethod (:pointer :OpaqueIconGetterProcPtr))
    (yourDataPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetSuiteLabel()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetSuiteLabel" 
   ((theSuite :Handle)
    (theLabel :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetSuiteLabel()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetSuiteLabel" 
   ((theSuite :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetIconCacheData()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetIconCacheData" 
   ((theCache :Handle)
    (theData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetIconCacheData()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetIconCacheData" 
   ((theCache :Handle)
    (theData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetIconCacheProc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetIconCacheProc" 
   ((theCache :Handle)
    (theProc (:pointer :ICONGETTERUPP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetIconCacheProc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetIconCacheProc" 
   ((theCache :Handle)
    (theProc (:pointer :OpaqueIconGetterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PlotIconHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PlotIconHandle" 
   ((theRect (:pointer :Rect))
    (align :SInt16)
    (transform :SInt16)
    (theIcon :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PlotSICNHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PlotSICNHandle" 
   ((theRect (:pointer :Rect))
    (align :SInt16)
    (transform :SInt16)
    (theSICN :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PlotCIconHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PlotCIconHandle" 
   ((theRect (:pointer :Rect))
    (align :SInt16)
    (transform :SInt16)
    (theCIcon (:Handle :CIcon))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    IconServices is an efficient mechanism to share icon data amongst multiple 
;    clients. It avoids duplication of data; it provides efficient caching, 
;    releasing memory when the icon data is no longer needed; it can provide
;    the appropriate icon for any filesystem object; it can provide commonly 
;    used icons (caution, note, help...); it is Appearance-savvy: the icons
;    are switched when appropriate.
;    IconServices refer to cached icon data using IconRef, a 32-bit opaque
;    value. IconRefs are reference counted. When there are no more "owners" 
;    of an IconRef, the memory used by the icon bitmap is disposed of.
;    Two files of same type and creator with no custom icon will have the same IconRef.
;    Files with custom icons will have their own IconRef.
; 
; 
;    Use the special creator kSystemIconsCreator to get "standard" icons 
;    that are not associated with a file, such as the help icon.
;    Note that all lowercase creators are reserved by Apple.
; 

(defconstant $kSystemIconsCreator :|macs|)
; 
;    Type of the predefined/generic icons. For example, the call:
;       err = GetIconRef(kOnSystemDisk, kSystemIconsCreator, kHelpIcon, &iconRef);
;    will retun in iconRef the IconRef for the standard help icon.
; 
;  Generic Finder icons 

(defconstant $kClipboardIcon :|CLIP|)
(defconstant $kClippingUnknownTypeIcon :|clpu|)
(defconstant $kClippingPictureTypeIcon :|clpp|)
(defconstant $kClippingTextTypeIcon :|clpt|)
(defconstant $kClippingSoundTypeIcon :|clps|)
(defconstant $kDesktopIcon :|desk|)
(defconstant $kFinderIcon :|FNDR|)
(defconstant $kComputerIcon :|root|)
(defconstant $kFontSuitcaseIcon :|FFIL|)
(defconstant $kFullTrashIcon :|ftrh|)
(defconstant $kGenericApplicationIcon :|APPL|)
(defconstant $kGenericCDROMIcon :|cddr|)
(defconstant $kGenericControlPanelIcon :|APPC|)
(defconstant $kGenericControlStripModuleIcon :|sdev|)
(defconstant $kGenericComponentIcon :|thng|)
(defconstant $kGenericDeskAccessoryIcon :|APPD|)
(defconstant $kGenericDocumentIcon :|docu|)
(defconstant $kGenericEditionFileIcon :|edtf|)
(defconstant $kGenericExtensionIcon :|INIT|)
(defconstant $kGenericFileServerIcon :|srvr|)
(defconstant $kGenericFontIcon :|ffil|)
(defconstant $kGenericFontScalerIcon :|sclr|)
(defconstant $kGenericFloppyIcon :|flpy|)
(defconstant $kGenericHardDiskIcon :|hdsk|)
(defconstant $kGenericIDiskIcon :|idsk|)
(defconstant $kGenericRemovableMediaIcon :|rmov|)
(defconstant $kGenericMoverObjectIcon :|movr|)
(defconstant $kGenericPCCardIcon :|pcmc|)
(defconstant $kGenericPreferencesIcon :|pref|)
(defconstant $kGenericQueryDocumentIcon :|qery|)
(defconstant $kGenericRAMDiskIcon :|ramd|)
(defconstant $kGenericSharedLibaryIcon :|shlb|)
(defconstant $kGenericStationeryIcon :|sdoc|)
(defconstant $kGenericSuitcaseIcon :|suit|)
(defconstant $kGenericURLIcon :|gurl|)
(defconstant $kGenericWORMIcon :|worm|)
(defconstant $kInternationalResourcesIcon :|ifil|)
(defconstant $kKeyboardLayoutIcon :|kfil|)
(defconstant $kSoundFileIcon :|sfil|)
(defconstant $kSystemSuitcaseIcon :|zsys|)
(defconstant $kTrashIcon :|trsh|)
(defconstant $kTrueTypeFontIcon :|tfil|)
(defconstant $kTrueTypeFlatFontIcon :|sfnt|)
(defconstant $kTrueTypeMultiFlatFontIcon :|ttcf|)
(defconstant $kUserIDiskIcon :|udsk|)
(defconstant $kUnknownFSObjectIcon :|unfs|)
(defconstant $kInternationResourcesIcon :|ifil|);  old name

;  Internet locations 

(defconstant $kInternetLocationHTTPIcon :|ilht|)
(defconstant $kInternetLocationFTPIcon :|ilft|)
(defconstant $kInternetLocationAppleShareIcon :|ilaf|)
(defconstant $kInternetLocationAppleTalkZoneIcon :|ilat|)
(defconstant $kInternetLocationFileIcon :|ilfi|)
(defconstant $kInternetLocationMailIcon :|ilma|)
(defconstant $kInternetLocationNewsIcon :|ilnw|)
(defconstant $kInternetLocationNSLNeighborhoodIcon :|ilns|)
(defconstant $kInternetLocationGenericIcon :|ilge|)
;  Folders 

(defconstant $kGenericFolderIcon :|fldr|)
(defconstant $kDropFolderIcon :|dbox|)
(defconstant $kMountedFolderIcon :|mntd|)
(defconstant $kOpenFolderIcon :|ofld|)
(defconstant $kOwnedFolderIcon :|ownd|)
(defconstant $kPrivateFolderIcon :|prvf|)
(defconstant $kSharedFolderIcon :|shfl|)
;  Sharing Privileges icons 

(defconstant $kSharingPrivsNotApplicableIcon :|shna|)
(defconstant $kSharingPrivsReadOnlyIcon :|shro|)
(defconstant $kSharingPrivsReadWriteIcon :|shrw|)
(defconstant $kSharingPrivsUnknownIcon :|shuk|)
(defconstant $kSharingPrivsWritableIcon :|writ|)
;  Users and Groups icons 

(defconstant $kUserFolderIcon :|ufld|)
(defconstant $kWorkgroupFolderIcon :|wfld|)
(defconstant $kGuestUserIcon :|gusr|)
(defconstant $kUserIcon :|user|)
(defconstant $kOwnerIcon :|susr|)
(defconstant $kGroupIcon :|grup|)
;  Special folders 

(defconstant $kAppearanceFolderIcon :|appr|)
(defconstant $kAppleExtrasFolderIcon #x616578C4); 'aexÄ'

(defconstant $kAppleMenuFolderIcon :|amnu|)
(defconstant $kApplicationsFolderIcon :|apps|)
(defconstant $kApplicationSupportFolderIcon :|asup|)
(defconstant $kAssistantsFolderIcon #x617374C4) ; 'astÄ'

(defconstant $kColorSyncFolderIcon :|prof|)
(defconstant $kContextualMenuItemsFolderIcon :|cmnu|)
(defconstant $kControlPanelDisabledFolderIcon :|ctrD|)
(defconstant $kControlPanelFolderIcon :|ctrl|)
(defconstant $kControlStripModulesFolderIcon #x736476C4); 'sdvÄ'

(defconstant $kDocumentsFolderIcon :|docs|)
(defconstant $kExtensionsDisabledFolderIcon :|extD|)
(defconstant $kExtensionsFolderIcon :|extn|)
(defconstant $kFavoritesFolderIcon :|favs|)
(defconstant $kFontsFolderIcon :|font|)         ; 'Ählp' 

(defconstant $kHelpFolderIcon #xC4686C70)
(defconstant $kInternetFolderIcon #x696E74C4)   ; 'intÄ'
; 'Änet' 

(defconstant $kInternetPlugInFolderIcon #xC46E6574)
(defconstant $kInternetSearchSitesFolderIcon :|issf|); 'Äloc' 

(defconstant $kLocalesFolderIcon #xC46C6F63)
(defconstant $kMacOSReadMeFolderIcon #x6D6F72C4); 'morÄ'

(defconstant $kPublicFolderIcon :|pubf|)
(defconstant $kPreferencesFolderIcon #x707266C4); 'prfÄ'

(defconstant $kPrinterDescriptionFolderIcon :|ppdf|); 'Äprd' 

(defconstant $kPrinterDriverFolderIcon #xC4707264)
(defconstant $kPrintMonitorFolderIcon :|prnt|)
(defconstant $kRecentApplicationsFolderIcon :|rapp|)
(defconstant $kRecentDocumentsFolderIcon :|rdoc|)
(defconstant $kRecentServersFolderIcon :|rsrv|) ; 'Äscr' 

(defconstant $kScriptingAdditionsFolderIcon #xC4736372); 'Älib' 

(defconstant $kSharedLibrariesFolderIcon #xC46C6962)
(defconstant $kScriptsFolderIcon #x736372C4)    ; 'scrÄ'

(defconstant $kShutdownItemsDisabledFolderIcon :|shdD|)
(defconstant $kShutdownItemsFolderIcon :|shdf|)
(defconstant $kSpeakableItemsFolder :|spki|)
(defconstant $kStartupItemsDisabledFolderIcon :|strD|)
(defconstant $kStartupItemsFolderIcon :|strt|)
(defconstant $kSystemExtensionDisabledFolderIcon :|macD|)
(defconstant $kSystemFolderIcon :|macs|)        ; 'Ätex' 

(defconstant $kTextEncodingsFolderIcon #xC4746578)
(defconstant $kUsersFolderIcon #x757372C4)      ; 'usrÄ'

(defconstant $kUtilitiesFolderIcon #x757469C4)  ; 'utiÄ'

(defconstant $kVoicesFolderIcon :|fvoc|)
;  Badges 

(defconstant $kAppleScriptBadgeIcon :|scrp|)
(defconstant $kLockedBadgeIcon :|lbdg|)
(defconstant $kMountedBadgeIcon :|mbdg|)
(defconstant $kSharedBadgeIcon :|sbdg|)
(defconstant $kAliasBadgeIcon :|abdg|)
(defconstant $kAlertCautionBadgeIcon :|cbdg|)
;  Alert icons 

(defconstant $kAlertNoteIcon :|note|)
(defconstant $kAlertCautionIcon :|caut|)
(defconstant $kAlertStopIcon :|stop|)
;  Networking icons 

(defconstant $kAppleTalkIcon :|atlk|)
(defconstant $kAppleTalkZoneIcon :|atzn|)
(defconstant $kAFPServerIcon :|afps|)
(defconstant $kFTPServerIcon :|ftps|)
(defconstant $kHTTPServerIcon :|htps|)
(defconstant $kGenericNetworkIcon :|gnet|)
(defconstant $kIPFileServerIcon :|isrv|)
;  Toolbar icons 

(defconstant $kToolbarCustomizeIcon :|tcus|)
(defconstant $kToolbarDeleteIcon :|tdel|)
(defconstant $kToolbarFavoritesIcon :|tfav|)
(defconstant $kToolbarHomeIcon :|thom|)
;  Other icons 

(defconstant $kAppleLogoIcon :|capl|)
(defconstant $kAppleMenuIcon :|sapl|)
(defconstant $kBackwardArrowIcon :|baro|)
(defconstant $kFavoriteItemsIcon :|favr|)
(defconstant $kForwardArrowIcon :|faro|)
(defconstant $kGridIcon :|grid|)
(defconstant $kHelpIcon :|help|)
(defconstant $kKeepArrangedIcon :|arng|)
(defconstant $kLockedIcon :|lock|)
(defconstant $kNoFilesIcon :|nfil|)
(defconstant $kNoFolderIcon :|nfld|)
(defconstant $kNoWriteIcon :|nwrt|)
(defconstant $kProtectedApplicationFolderIcon :|papp|)
(defconstant $kProtectedSystemFolderIcon :|psys|)
(defconstant $kRecentItemsIcon :|rcnt|)
(defconstant $kShortcutIcon :|shrt|)
(defconstant $kSortAscendingIcon :|asnd|)
(defconstant $kSortDescendingIcon :|dsnd|)
(defconstant $kUnlockedIcon :|ulck|)
(defconstant $kConnectToIcon :|cnct|)
(defconstant $kGenericWindowIcon :|gwin|)
(defconstant $kQuestionMarkIcon :|ques|)
(defconstant $kDeleteAliasIcon :|dali|)
(defconstant $kEjectMediaIcon :|ejec|)
(defconstant $kBurningIcon :|burn|)
(defconstant $kRightContainerArrowIcon :|rcar|)
;   IconServicesUsageFlags 

(def-mactype :IconServicesUsageFlags (find-mactype ':UInt32))

(defconstant $kIconServicesNormalUsageFlag 0)
(defconstant $kIconServicesNoBadgeFlag 1)       ;  available on Panther and later 

(defconstant $kIconServicesUpdateIfNeededFlag 2);  available on Panther and later 

; 
;   kIconServicesCatalogInfoMask - Minimal bitmask for use with
;     GetIconRefFromFileInfo(). Use this mask with FSGetCatalogInfo
;     before calling GetIconRefFromFileInfo(). Please note kFSCatInfoFinderXInfo flag is
;     valid only on MacOS X and must be cleared from CatalogInfoMask before
;     passing to GetIconRefFromFileInfo while running under MacOS 9 (or error will be returned)
; 

(defconstant $kIconServicesCatalogInfoMask #x81C5E)
; 
;  *  PlotIconRefFlags
;  *  
;  *  Discussion:
;  *    Flags that can be passed to the PlotIconRefInContext routine.
;  

(def-mactype :PlotIconRefFlags (find-mactype ':UInt32))
; 
;    * Draw the icon image and alpha channel.
;    

(defconstant $kPlotIconRefNormalFlags 0)
; 
;    * Only draw the alpha channel.
;    

(defconstant $kPlotIconRefNoImage 2)
; 
;    * Only draw the image.
;    

(defconstant $kPlotIconRefNoMask 4)
; 
;   ==============================================================================
;    Initialization and Termination
;   ==============================================================================
; 
; 
;    IconServicesInit
;    
;    Call this routine once per classic 68K application initialization.
;    This routine does not need to be called at boot time.
; 
; 
;  *  IconServicesInit()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  
; 
;    IconServicesTerminate:
;    
;    Call this routine once from the termination of a classic 68K application.
;    This routine does not need to be called at boot time.
; 
; 
;  *  IconServicesTerminate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  
; 
;   ==============================================================================
;    Converting data structures
;   ==============================================================================
; 
; 
;    IconRefToIconFamily
;    This routines returns a new IconFamily that contains the data corresponding
;    to the specified IconRef.
; 
; 
;  *  IconRefToIconFamily()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_IconRefToIconFamily" 
   ((theIconRef (:pointer :OpaqueIconRef))
    (whichIcons :UInt32)
    (iconFamily (:pointer :ICONFAMILYHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    IconFamilyToIconSuite
;    This routine transfers the data from an icon family handle into an icon suite.
; 
; 
;  *  IconFamilyToIconSuite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_IconFamilyToIconSuite" 
   ((iconFamily (:Handle :IconFamilyResource))
    (whichIcons :UInt32)
    (iconSuite (:pointer :ICONSUITEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    IconSuiteToIconFamily
;    This routine transfers the data in an icon suite into an icon family.
; 
; 
;  *  IconSuiteToIconFamily()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_IconSuiteToIconFamily" 
   ((iconSuite :Handle)
    (whichIcons :UInt32)
    (iconFamily (:pointer :ICONFAMILYHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    SetIconFamilyData
;    Change the data of an icon family. The data is copied.
;    The type can be one of the icon type, or 'PICT'.
;    The data will be compressed if needed.
; 
; 
;  *  SetIconFamilyData()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_SetIconFamilyData" 
   ((iconFamily (:Handle :IconFamilyResource))
    (iconType :OSType)
    (h :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    GetIconFamilyData
;    Return a copy of the data in the icon family.
;    The type can be one of the icon type, or 'PICT'
;    The data will be returned uncompressed.
;    The handle (h) will be resized as appropriate. If no data of the 
;    requested type is present, the handle size will be set to 0.
; 
; 
;  *  GetIconFamilyData()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_GetIconFamilyData" 
   ((iconFamily (:Handle :IconFamilyResource))
    (iconType :OSType)
    (h :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   ==============================================================================
;    Reference counting
;   ==============================================================================
; 
; 
;    GetIconRefOwners
;    
;    This routine returns the reference count for the IconRef, or number of owners.
;    
;    A valid IconRef always has at least one owner.
; 
; 
;  *  GetIconRefOwners()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_GetIconRefOwners" 
   ((theIconRef (:pointer :OpaqueIconRef))
    (owners (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    AcquireIconRef
;    This routine increments the reference count for the IconRef
; 
; 
;  *  AcquireIconRef()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_AcquireIconRef" 
   ((theIconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    ReleaseIconRef
;    
;    This routine decrements the reference count for the IconRef.
;    
;    When the reference count reaches 0, all memory allocated for the icon
;    is disposed. Any subsequent use of the IconRef is invalid.
; 
; 
;  *  ReleaseIconRef()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_ReleaseIconRef" 
   ((theIconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   ==============================================================================
;    Getting an IconRef
;   ==============================================================================
; 
; 
;    GetIconRefFromFile
;    
;    This routine returns an icon ref for the specified file, folder or volume.
;    The label information is provided separately, since two files with the same icon 
;    but a different label would share the same iconRef. The label can be used in 
;    PlotIconRef() for example.
;    
;    Use this routine if you have no information about the file system object. If 
;    you have already done a GetCatInfo on the file and want to save some I/O, 
;    call GetIconRefFromFolder() if you know it's a folder with no custom icon or 
;    call GetIconRef() if it's a file with no custom icon.
;    This routine increments the reference count of the returned IconRef. Call 
;    ReleaseIconRef() when you're done with it.
; 
; 
;  *  GetIconRefFromFile()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_GetIconRefFromFile" 
   ((theFile (:pointer :FSSpec))
    (theIconRef (:pointer :ICONREF))
    (theLabel (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    GetIconRef
;    
;    This routine returns an icon ref for an icon in the desktop database or
;    for a registered icon.
;    The system registers a set of icon such as the help icon with the creator 
;    code kSystemIconsCreator. See above for a list of the registered system types.
;    The vRefNum is used as a hint on where to look for the icon first. Use 
;    kOnSystemDisk if you don't know what to pass.
;    This routine increments the reference count of the returned IconRef. Call 
;    ReleaseIconRef() when you're done with it.
; 
; 
;  *  GetIconRef()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_GetIconRef" 
   ((vRefNum :SInt16)
    (creator :OSType)
    (iconType :OSType)
    (theIconRef (:pointer :ICONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    GetIconRefFromFolder
;    
;    This routine returns an icon ref for a folder with no custom icon.
;    Use the more generic, but slightly slower, GetIconRefFromFile() if
;    you don't already have the necessary info about the file.
;    Attributes should be CInfoPBRec.dirInfo.ioFlAttrib for this folder.
;    Access privileges should be CInfoPBRec.dirInfo.ioACUser for this folder.
;    This routine increments the reference count of the IconRef. Call ReleaseIconRef() 
;    when you're done with it.
; 
; 
;  *  GetIconRefFromFolder()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_GetIconRefFromFolder" 
   ((vRefNum :SInt16)
    (parentFolderID :SInt32)
    (folderID :SInt32)
    (attributes :SInt8)
    (accessPrivileges :SInt8)
    (theIconRef (:pointer :ICONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  GetIconRefFromFileInfo
; 
;  *  GetIconRefFromFileInfo()
;  *  
;  *  Summary:
;  *    This routine returns an IconRef for a file with minimal file I/O.
;  *  
;  *  Discussion:
;  *    To minimize file operations, FSGetCatalogInfo should be called
;  *    prior to calling this routine. The FSCatalogInfo should
;  *    correspond to kIconServicesCatalogInfoMask The name should be
;  *    fetched and passed in. If either the name or the correct catalog
;  *    info is not passed in, this routine will do file operations for
;  *    this information instead.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Parameters:
;  *    
;  *    inRef:
;  *      An FSRef for the target file
;  *    
;  *    inFileNameLength:
;  *      The length of the name of the target file
;  *    
;  *    inFileName:
;  *      The name of the target file
;  *    
;  *    inWhichInfo:
;  *      The mask of file info already acquired.
;  *    
;  *    inCatalogInfo:
;  *      The catalog info already acquired.
;  *    
;  *    inUsageFlags:
;  *      The usage flags for this call (use
;  *      kIconServicesNormalUsageFlag).
;  *    
;  *    outIconRef:
;  *      The output IconRef for the routine.
;  *    
;  *    outLabel:
;  *      The output label for the icon/file.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetIconRefFromFileInfo" 
   ((inRef (:pointer :FSRef))
    (inFileNameLength :UInt32)
    (inFileName (:pointer :UniChar))            ;  can be NULL 
    (inWhichInfo :UInt32)
    (inCatalogInfo (:pointer :FSCatalogInfo))   ;  can be NULL 
    (inUsageFlags :UInt32)
    (outIconRef (:pointer :ICONREF))
    (outLabel (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
;  GetIconRefFromTypeInfo
; 
;  *  GetIconRefFromTypeInfo()
;  *  
;  *  Summary:
;  *    Create an IconRef for a type information.
;  *  
;  *  Discussion:
;  *    Creates IconRef based on provided type info. Any of the input
;  *    parameters can be zero (meaning it is unknown). Returns generic
;  *    document icon in case if all parameters are zeroes. Calling the
;  *    routine with non zero inCreator and inType and zero inExtension
;  *    and inMIMEType is equivalent to GetIconRef(kOnSystemDisk,
;  *    inCreator, inType).
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inCreator:
;  *      The creator.
;  *    
;  *    inType:
;  *      The type.
;  *    
;  *    inExtension:
;  *      The extension.
;  *    
;  *    inMIMEType:
;  *      The MIME type.
;  *    
;  *    inUsageFlags:
;  *      The usage flags for this call (use
;  *      kIconServicesNormalUsageFlag).
;  *    
;  *    outIconRef:
;  *      The output IconRef for the routine.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetIconRefFromTypeInfo" 
   ((inCreator :OSType)
    (inType :OSType)
    (inExtension (:pointer :__CFString))
    (inMIMEType (:pointer :__CFString))
    (inUsageFlags :UInt32)
    (outIconRef (:pointer :ICONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSErr
() )
;  GetIconRefFromIconFamilyPtr
; 
;  *  GetIconRefFromIconFamilyPtr()
;  *  
;  *  Summary:
;  *    Create an IconRef for the IconFamilyPtr.
;  *  
;  *  Discussion:
;  *    This routine creates IconRef for the IconFamilyPtr.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inIconFamilyPtr:
;  *      The icon data
;  *    
;  *    inSize:
;  *      The icon data size
;  *    
;  *    outIconRef:
;  *      The output IconRef for the routine.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetIconRefFromIconFamilyPtr" 
   ((inIconFamilyPtr (:pointer :IconFamilyResource))
    (inSize :signed-long)
    (outIconRef (:pointer :ICONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;   ==============================================================================
;    Adding and modifying IconRef
;   ==============================================================================
; 
; 
;    RegisterIconRefFromIconFamily
;    This routine adds a new entry to the IconRef registry. Other clients will be 
;    able to access it using the (creator, iconType) pair specified here.
;    Lower-case creators are reserved for the system.
;    Consider using RegisterIconRefFromResource() if possible, since the data 
;    registered using RegisterIconRefFromFamily() cannot be purged.
;    The iconFamily data is copied and the caller is reponsible for disposing of it.
;    This routine increments the reference count of the IconRef. Call ReleaseIconRef() 
;    when you're done with it.
; 
; 
;  *  RegisterIconRefFromIconFamily()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_RegisterIconRefFromIconFamily" 
   ((creator :OSType)
    (iconType :OSType)
    (iconFamily (:Handle :IconFamilyResource))
    (theIconRef (:pointer :ICONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    RegisterIconRefFromResource
;    
;    Registers an IconRef from a resouce file.  
;    Lower-case creators are reserved for the system.
;    The icon data to be fetched is either classic icon data or an icon family.  
;    The 'icns' icon family is searched for before the classic icon data.
;    This routine increments the reference count of the IconRef. Call ReleaseIconRef() 
;    when you're done with it.
; 
; 
;  *  RegisterIconRefFromResource()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_RegisterIconRefFromResource" 
   ((creator :OSType)
    (iconType :OSType)
    (resourceFile (:pointer :FSSpec))
    (resourceID :SInt16)
    (theIconRef (:pointer :ICONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  RegisterIconRefFromFSRef
; 
;  *  RegisterIconRefFromFSRef()
;  *  
;  *  Discussion:
;  *    This routine registers an IconRef from a ".icns" file and
;  *    associates it with a creator/type pair.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Parameters:
;  *    
;  *    creator:
;  *      The creator code for the icns file.
;  *    
;  *    iconType:
;  *      The type code for the icns file
;  *    
;  *    iconFile:
;  *      The FSRef of the icns file.
;  *    
;  *    theIconRef:
;  *      The output IconRef for the routine.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RegisterIconRefFromFSRef" 
   ((creator :OSType)
    (iconType :OSType)
    (iconFile (:pointer :FSRef))
    (theIconRef (:pointer :ICONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;    UnregisterIconRef
;    
;    Removes the specified icon from the icon cache (if there are no users of it).  
;    If some clients are using this iconRef, then the IconRef will be removed when the 
;    last user calls ReleaseIconRef.
; 
; 
;  *  UnregisterIconRef()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_UnregisterIconRef" 
   ((creator :OSType)
    (iconType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    UpdateIconRef
;    
;    Call this routine to force an update of the data for iconRef.
;    
;    For example after changing an icon in the desktop database or changing the custom 
;    icon of a file. Note that after _adding_ a custom icon to file or folder, you 
;    need to call GetIconRefFromFile() to get a new IconRef specific to this file. 
;    
;    This routine does nothing if the IconRef is a registered icon.
; 
; 
;  *  UpdateIconRef()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_UpdateIconRef" 
   ((theIconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    OverrideIconRefFromResource
;    
;    This routines replaces the bitmaps of the specified IconRef with the ones
;    in the specified resource file.
; 
; 
;  *  OverrideIconRefFromResource()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_OverrideIconRefFromResource" 
   ((theIconRef (:pointer :OpaqueIconRef))
    (resourceFile (:pointer :FSSpec))
    (resourceID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    OverrideIconRef
;    
;    This routines replaces the bitmaps of the specified IconRef with the ones
;    from the new IconRef.
; 
; 
;  *  OverrideIconRef()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_OverrideIconRef" 
   ((oldIconRef (:pointer :OpaqueIconRef))
    (newIconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    RemoveIconRefOverride
;    This routine remove an override if one was applied to the icon and 
;    reverts back to the original bitmap data.
; 
; 
;  *  RemoveIconRefOverride()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_RemoveIconRefOverride" 
   ((theIconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   ==============================================================================
;    Creating composite IconRef
;   ==============================================================================
; 
; 
;    CompositeIconRef
;    
;    Superimposes an IconRef on top of another one
; 
; 
;  *  CompositeIconRef()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_CompositeIconRef" 
   ((backgroundIconRef (:pointer :OpaqueIconRef))
    (foregroundIconRef (:pointer :OpaqueIconRef))
    (compositeIconRef (:pointer :ICONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    IsIconRefComposite
;    Indicates if a given icon ref is a composite of two other icon refs (and which ones)
;    If it isn't a composite, backgroundIconRef and foreGroundIconRef will be 0.
; 
; 
;  *  IsIconRefComposite()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_IsIconRefComposite" 
   ((compositeIconRef (:pointer :OpaqueIconRef))
    (backgroundIconRef (:pointer :ICONREF))
    (foregroundIconRef (:pointer :ICONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   ==============================================================================
;    Using IconRef
;   ==============================================================================
; 
; 
;    IsValidIconRef
;    Return true if the iconRef passed in is a valid icon ref
; 
; 
;  *  IsValidIconRef()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_IsValidIconRef" 
   ((theIconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    PlotIconRef
;    
;    This routine plots the IconRef.  It mostly takes the same parameters as 
;    PlotIconSuite. Pass kIconServicesNormalUsageFlag as a default value for 
;    IconServicesUsageFlags.
; 
; 
;  *  PlotIconRef()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_PlotIconRef" 
   ((theRect (:pointer :Rect))
    (align :SInt16)
    (transform :SInt16)
    (theIconServicesUsageFlags :UInt32)
    (theIconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  PlotIconRefInContext
; 
;  *  PlotIconRefInContext()
;  *  
;  *  Discussion:
;  *    This routines plots an IconRef using Quartz/CoreGraphics.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inContext:
;  *      The graphics context to use.
;  *    
;  *    inRect:
;  *      The rect to plot the icon in.
;  *    
;  *    inAlign:
;  *      The icon alignment.
;  *    
;  *    inTransform:
;  *      The icon transform.
;  *    
;  *    inLabelColor:
;  *      The icon label color.
;  *    
;  *    inFlags:
;  *      The drawing flags to use (usually kPlotIconRefNormalFlags).
;  *    
;  *    inIconRef:
;  *      The IconRef to plot.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PlotIconRefInContext" 
   ((inContext (:pointer :CGContext))
    (inRect (:pointer :CGRect))
    (inAlign :SInt16)
    (inTransform :SInt16)
    (inLabelColor (:pointer :RGBColor))
    (inFlags :UInt32)
    (inIconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;    PtInIconRef
;    
;    This routine indicates if testPt would hit the icon designated by iconRef.
;    It mostly takes the same parameters as PtInIconSuite.
;    Pass kIconServicesNormalUsageFlag as a default value for IconServicesUsageFlags.
; 
; 
;  *  PtInIconRef()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_PtInIconRef" 
   ((testPt (:pointer :Point))
    (iconRect (:pointer :Rect))
    (align :SInt16)
    (theIconServicesUsageFlags :UInt32)
    (theIconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    RectInIconRef
;    
;    This routine indicates if testRect would intersect the icon designated by iconRef.
;    It mostly takes the same parameters as RectInIconSuite.
;    Pass kIconServicesNormalUsageFlag as a default value for IconServicesUsageFlags.
; 
; 
;  *  RectInIconRef()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_RectInIconRef" 
   ((testRect (:pointer :Rect))
    (iconRect (:pointer :Rect))
    (align :SInt16)
    (iconServicesUsageFlags :UInt32)
    (theIconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    IconRefToRgn
;    
;    This routine returns a region for the icon.
;    It mostly takes the same parameters as IconSuiteToRgn.
;    Pass kIconServicesNormalUsageFlag as a default value for IconServicesUsageFlags.
; 
; 
;  *  IconRefToRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_IconRefToRgn" 
   ((theRgn (:pointer :OpaqueRgnHandle))
    (iconRect (:pointer :Rect))
    (align :SInt16)
    (iconServicesUsageFlags :UInt32)
    (theIconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    GetIconSizesFromIconRef
;    
;    This routine returns an IconSelectorValue indicating the depths and sizes of 
;    icon data which are actually available.  It takes an IconSelectorValue 
;    indicating which sizes/depths the caller is interested and returns an 
;    IconSelectorValue indicating which sizes/depths exist.
;    
;    Caution:
;    
;    This is potentially an extremely expensive call as IconServices may be forced 
;    to attempt fetching the data for the IconRef's sizes/depths which may result 
;    in hitting the local disk or even the network to obtain the data to determine 
;    which sizes/depths actually exist.
;    Pass kIconServicesNormalUsageFlag as a default value for IconServicesUsageFlags.
;    
;    This call is deprecated. Please use IsDataAvailableInIconRef() instead.
; 
; 
;  *  GetIconSizesFromIconRef()   *** DEPRECATED ***
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_GetIconSizesFromIconRef" 
   ((iconSelectorInput :UInt32)
    (iconSelectorOutputPtr (:pointer :ICONSELECTORVALUE))
    (iconServicesUsageFlags :UInt32)
    (theIconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
;  IsDataAvailableInIconRef
; 
;  *  IsDataAvailableInIconRef()
;  *  
;  *  Summary:
;  *    Check if IconRef has specific data.
;  *  
;  *  Discussion:
;  *    This routine returns true if inIconKind icon data is availabe or
;  *    can be created.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inIconKind:
;  *      The icon data kind
;  *    
;  *    inIconRef:
;  *      The IconRef to test.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsDataAvailableInIconRef" 
   ((inIconKind :OSType)
    (inIconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;   ==============================================================================
;    Flushing IconRef data
;   ==============================================================================
; 
; 
;    FlushIconRefs
;    
;    Making this call will dispose of all the data for the specified icons if 
;    the data can be reacquired, for example if the data is provided from a resource.
;    '****' is a wildcard for all types or all creators.
; 
; 
;  *  FlushIconRefs()   *** DEPRECATED ***
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_FlushIconRefs" 
   ((creator :OSType)
    (iconType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;    FlushIconRefsByVolume
;    
;    This routine disposes of the data for the icons related to the indicated volume
;    if this data can be reacquired, for example if the data is provided from a 
;    resource.
; 
; 
;  *  FlushIconRefsByVolume()   *** DEPRECATED ***
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_FlushIconRefsByVolume" 
   ((vRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;   ==============================================================================
;    Controling custom icons
;   ==============================================================================
; 
; 
;    SetCustomIconsEnabled
;    
;    Enable or disable custom icons on the specified volume.
; 
; 
;  *  SetCustomIconsEnabled()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_SetCustomIconsEnabled" 
   ((vRefNum :SInt16)
    (enableCustomIcons :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    GetCustomIconsEnabled
;    
;    Return true if custom icons are enabled on the specified volume, false otherwise.
; 
; 
;  *  GetCustomIconsEnabled()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_GetCustomIconsEnabled" 
   ((vRefNum :SInt16)
    (customIconsEnabled (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    IsIconRefMaskEmpty
;    Returns true if the mask for this icon is blank
; 
; 
;  *  IsIconRefMaskEmpty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
;  

(deftrap-inline "_IsIconRefMaskEmpty" 
   ((iconRef (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;    GetIconRefVariant
;    Icon variants allows different images to be used with different icon state.
;    For example, the 'open' variant for a folder could be represented with
;    an open folder.
;    Given an icon ref and a desired variant, this routine returns an icon
;    ref (which may be the same as the input icon ref) and a transformation 
;    which should be used with PlotIconRef() to render the icon appropriately.
;    The returned icon ref should be used to do hit-testing.
; 
; 
;  *  GetIconRefVariant()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 9.0 and later
;  

(deftrap-inline "_GetIconRefVariant" 
   ((inIconRef (:pointer :OpaqueIconRef))
    (inVariant :OSType)
    (outTransform (:pointer :ICONTRANSFORMTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueIconRef)
() )
; 
;   ==============================================================================
;    Icon files (.icns files)
;   ==============================================================================
; 
; 
;    RegisterIconRefFromIconFile
;    This routine adds a new entry to the IconRef registry. Other clients will be 
;    able to access it using the (creator, iconType) pair specified here.
;    Lower-case creators are reserved for the system.
;    If the creator is kSystemIconsCreator and the iconType is 0, a new IconRef
;    is always returned. Otherwise, if the creator and type have already been
;    registered, the previously registered IconRef is returned.
;    This routine increments the reference count of the IconRef. Call ReleaseIconRef() 
;    when you're done with it.
; 
; 
;  *  RegisterIconRefFromIconFile()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version Jaguar
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 9.0 and later
;  

(deftrap-inline "_RegisterIconRefFromIconFile" 
   ((creator :OSType)
    (iconType :OSType)
    (iconFile (:pointer :FSSpec))
    (theIconRef (:pointer :ICONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    ReadIconFile
;    Read the specified icon file into the icon family handle.
;    The caller is responsible for disposing the iconFamily
; 
; 
;  *  ReadIconFile()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 9.0 and later
;  

(deftrap-inline "_ReadIconFile" 
   ((iconFile (:pointer :FSSpec))
    (iconFamily (:pointer :ICONFAMILYHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  ReadIconFromFSRef
; 
;  *  ReadIconFromFSRef()
;  *  
;  *  Discussion:
;  *    This routine reads an icon (icns) file into memory.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    ref:
;  *      The FSRef for the icon file.
;  *    
;  *    iconFamily:
;  *      The handle for the icon family.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ReadIconFromFSRef" 
   ((ref (:pointer :FSRef))
    (iconFamily (:pointer :ICONFAMILYHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;    WriteIconFile
;    Write the iconFamily handle to the specified file
; 
; 
;  *  WriteIconFile()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in IconServicesLib 9.0 and later
;  

(deftrap-inline "_WriteIconFile" 
   ((iconFamily (:Handle :IconFamilyResource))
    (iconFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __ICONS__ */


(provide-interface "Icons")