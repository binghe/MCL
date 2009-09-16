(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Video.h"
; at Sunday July 2,2006 7:24:32 pm.
; 
;      File:       QD/Video.h
;  
;      Contains:   Video Driver Interfaces.
;  
;      Version:    Quickdraw-150~1
;  
;      Copyright:  © 1986-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __VIDEO__
; #define __VIDEO__
; #ifndef __QUICKDRAW__
#| #|
#include <QDQuickdraw.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k

(defconstant $mBaseOffset 1)                    ; Id of mBaseOffset.

(defconstant $mRowBytes 2)                      ; Video sResource parameter Id's 

(defconstant $mBounds 3)                        ; Video sResource parameter Id's 

(defconstant $mVersion 4)                       ; Video sResource parameter Id's 

(defconstant $mHRes 5)                          ; Video sResource parameter Id's 

(defconstant $mVRes 6)                          ; Video sResource parameter Id's 

(defconstant $mPixelType 7)                     ; Video sResource parameter Id's 

(defconstant $mPixelSize 8)                     ; Video sResource parameter Id's 

(defconstant $mCmpCount 9)                      ; Video sResource parameter Id's 

(defconstant $mCmpSize 10)                      ; Video sResource parameter Id's 

(defconstant $mPlaneBytes 11)                   ; Video sResource parameter Id's 

(defconstant $mVertRefRate 14)                  ; Video sResource parameter Id's 

(defconstant $mVidParams 1)                     ; Video parameter block id.

(defconstant $mTable 2)                         ; Offset to the table.

(defconstant $mPageCnt 3)                       ; Number of pages

(defconstant $mDevType 4)                       ; Device Type

(defconstant $oneBitMode #x80)                  ; Id of OneBitMode Parameter list.

(defconstant $twoBitMode #x81)                  ; Id of TwoBitMode Parameter list.

(defconstant $fourBitMode #x82)                 ; Id of FourBitMode Parameter list.

(defconstant $eightBitMode #x83)                ; Id of EightBitMode Parameter list.


(defconstant $sixteenBitMode #x84)              ; Id of SixteenBitMode Parameter list.

(defconstant $thirtyTwoBitMode #x85)            ; Id of ThirtyTwoBitMode Parameter list.

(defconstant $firstVidMode #x80)                ; The new, better way to do the above. 

(defconstant $secondVidMode #x81)               ;  QuickDraw only supports six video 

(defconstant $thirdVidMode #x82)                ;  at this time.      

(defconstant $fourthVidMode #x83)
(defconstant $fifthVidMode #x84)
(defconstant $sixthVidMode #x85)
(defconstant $spGammaDir 64)
(defconstant $spVidNamesDir 65)
;  csTimingFormat values in VDTimingInfo 
;  look in the declaration rom for timing info 

(defconstant $kDeclROMtables :|decl|)
(defconstant $kDetailedTimingFormat :|arba|)    ;  Timing is a detailed timing

;  Size of a block of EDID (Extended Display Identification Data) 

(defconstant $kDDCBlockSize #x80)
;  ddcBlockType constants

(defconstant $kDDCBlockTypeEDID 0)              ;  EDID block type. 

;  ddcFlags constants

(defconstant $kDDCForceReadBit 0)               ;  Force a new read of the EDID. 
;  Mask for kddcForceReadBit. 

(defconstant $kDDCForceReadMask 1)
;  Timing mode constants for Display Manager MultiMode support
;     Corresponding   .h equates are in Video.h
;                     .a equates are in Video.a
;                     .r equates are in DepVideoEqu.r
;     
;     The second enum is the old names (for compatibility).
;     The first enum is the new names.
; 

(defconstant $timingInvalid 0)                  ;     Unknown timing… force user to confirm. 

(defconstant $timingInvalid_SM_T24 8)           ;     Work around bug in SM Thunder24 card.

(defconstant $timingApple_FixedRateLCD 42)      ;     Lump all fixed-rate LCDs into one category.

(defconstant $timingApple_512x384_60hz #x82)    ;   512x384  (60 Hz) Rubik timing. 

(defconstant $timingApple_560x384_60hz #x87)    ;   560x384  (60 Hz) Rubik-560 timing. 

(defconstant $timingApple_640x480_67hz #x8C)    ;   640x480  (67 Hz) HR timing. 

(defconstant $timingApple_640x400_67hz #x91)    ;   640x400  (67 Hz) HR-400 timing. 

(defconstant $timingVESA_640x480_60hz #x96)     ;   640x480  (60 Hz) VGA timing. 

(defconstant $timingVESA_640x480_72hz #x98)     ;   640x480  (72 Hz) VGA timing. 

(defconstant $timingVESA_640x480_75hz #x9A)     ;   640x480  (75 Hz) VGA timing. 

(defconstant $timingVESA_640x480_85hz #x9E)     ;   640x480  (85 Hz) VGA timing. 

(defconstant $timingGTF_640x480_120hz #x9F)     ;   640x480  (120 Hz) VESA Generalized Timing Formula 

(defconstant $timingApple_640x870_75hz #xA0)    ;   640x870  (75 Hz) FPD timing.

(defconstant $timingApple_640x818_75hz #xA5)    ;   640x818  (75 Hz) FPD-818 timing.

(defconstant $timingApple_832x624_75hz #xAA)    ;   832x624  (75 Hz) GoldFish timing.

(defconstant $timingVESA_800x600_56hz #xB4)     ;   800x600  (56 Hz) SVGA timing. 

(defconstant $timingVESA_800x600_60hz #xB6)     ;   800x600  (60 Hz) SVGA timing. 

(defconstant $timingVESA_800x600_72hz #xB8)     ;   800x600  (72 Hz) SVGA timing. 

(defconstant $timingVESA_800x600_75hz #xBA)     ;   800x600  (75 Hz) SVGA timing. 

(defconstant $timingVESA_800x600_85hz #xBC)     ;   800x600  (85 Hz) SVGA timing. 

(defconstant $timingVESA_1024x768_60hz #xBE)    ;  1024x768  (60 Hz) VESA 1K-60Hz timing. 

(defconstant $timingVESA_1024x768_70hz #xC8)    ;  1024x768  (70 Hz) VESA 1K-70Hz timing. 

(defconstant $timingVESA_1024x768_75hz #xCC)    ;  1024x768  (75 Hz) VESA 1K-75Hz timing (very similar to timingApple_1024x768_75hz). 

(defconstant $timingVESA_1024x768_85hz #xD0)    ;  1024x768  (85 Hz) VESA timing. 

(defconstant $timingApple_1024x768_75hz #xD2)   ;  1024x768  (75 Hz) Apple 19" RGB. 

(defconstant $timingApple_1152x870_75hz #xDC)   ;  1152x870  (75 Hz) Apple 21" RGB. 

(defconstant $timingAppleNTSC_ST #xE6)          ;   512x384  (60 Hz, interlaced, non-convolved). 

(defconstant $timingAppleNTSC_FF #xE8)          ;   640x480  (60 Hz, interlaced, non-convolved). 

(defconstant $timingAppleNTSC_STconv #xEA)      ;   512x384  (60 Hz, interlaced, convolved). 

(defconstant $timingAppleNTSC_FFconv #xEC)      ;   640x480  (60 Hz, interlaced, convolved). 

(defconstant $timingApplePAL_ST #xEE)           ;   640x480  (50 Hz, interlaced, non-convolved). 

(defconstant $timingApplePAL_FF #xF0)           ;   768x576  (50 Hz, interlaced, non-convolved). 

(defconstant $timingApplePAL_STconv #xF2)       ;   640x480  (50 Hz, interlaced, convolved). 

(defconstant $timingApplePAL_FFconv #xF4)       ;   768x576  (50 Hz, interlaced, convolved). 

(defconstant $timingVESA_1280x960_75hz #xFA)    ;  1280x960  (75 Hz) 

(defconstant $timingVESA_1280x960_60hz #xFC)    ;  1280x960  (60 Hz) 

(defconstant $timingVESA_1280x960_85hz #xFE)    ;  1280x960  (85 Hz) 

(defconstant $timingVESA_1280x1024_60hz #x104)  ;  1280x1024 (60 Hz) 

(defconstant $timingVESA_1280x1024_75hz #x106)  ;  1280x1024 (75 Hz) 

(defconstant $timingVESA_1280x1024_85hz #x10C)  ;  1280x1024 (85 Hz) 

(defconstant $timingVESA_1600x1200_60hz #x118)  ;  1600x1200 (60 Hz) VESA timing. 

(defconstant $timingVESA_1600x1200_65hz #x11A)  ;  1600x1200 (65 Hz) VESA timing. 

(defconstant $timingVESA_1600x1200_70hz #x11C)  ;  1600x1200 (70 Hz) VESA timing. 

(defconstant $timingVESA_1600x1200_75hz #x11E)  ;  1600x1200 (75 Hz) VESA timing (pixel clock is 189.2 Mhz dot clock). 

(defconstant $timingVESA_1600x1200_80hz #x120)  ;  1600x1200 (80 Hz) VESA timing (pixel clock is 216>? Mhz dot clock) - proposed only. 

(defconstant $timingVESA_1600x1200_85hz #x121)  ;  1600x1200 (85 Hz) VESA timing (pixel clock is 229.5 Mhz dot clock). 

(defconstant $timingVESA_1792x1344_60hz #x128)  ;  1792x1344 (60 Hz) VESA timing (204.75 Mhz dot clock). 

(defconstant $timingVESA_1792x1344_75hz #x12A)  ;  1792x1344 (75 Hz) VESA timing (261.75 Mhz dot clock). 

(defconstant $timingVESA_1856x1392_60hz #x12C)  ;  1856x1392 (60 Hz) VESA timing (218.25 Mhz dot clock). 

(defconstant $timingVESA_1856x1392_75hz #x12E)  ;  1856x1392 (75 Hz) VESA timing (288 Mhz dot clock). 

(defconstant $timingVESA_1920x1440_60hz #x130)  ;  1920x1440 (60 Hz) VESA timing (234 Mhz dot clock). 

(defconstant $timingVESA_1920x1440_75hz #x132)  ;  1920x1440 (75 Hz) VESA timing (297 Mhz dot clock). 

(defconstant $timingSMPTE240M_60hz #x190)       ;  60Hz V, 33.75KHz H, interlaced timing, 16:9 aspect, typical resolution of 1920x1035. 

(defconstant $timingFilmRate_48hz #x19A)        ;  48Hz V, 25.20KHz H, non-interlaced timing, typical resolution of 640x480. 

(defconstant $timingSony_1600x1024_76hz #x1F4)  ;  1600x1024 (76 Hz) Sony timing (pixel clock is 170.447 Mhz dot clock). 

(defconstant $timingSony_1920x1080_60hz #x1FE)  ;  1920x1080 (60 Hz) Sony timing (pixel clock is 159.84 Mhz dot clock). 

(defconstant $timingSony_1920x1080_72hz #x208)  ;  1920x1080 (72 Hz) Sony timing (pixel clock is 216.023 Mhz dot clock). 

(defconstant $timingSony_1920x1200_76hz #x21C)  ;  1900x1200 (76 Hz) Sony timing (pixel clock is 243.20 Mhz dot clock). 

(defconstant $timingApple_0x0_0hz_Offline #x226);  Indicates that this timing will take the display off-line and remove it from the system. 

;  Deprecated timing names.

(defconstant $timingApple12 #x82)
(defconstant $timingApple12x #x87)
(defconstant $timingApple13 #x8C)
(defconstant $timingApple13x #x91)
(defconstant $timingAppleVGA #x96)
(defconstant $timingApple15 #xA0)
(defconstant $timingApple15x #xA5)
(defconstant $timingApple16 #xAA)
(defconstant $timingAppleSVGA #xB4)
(defconstant $timingApple1Ka #xBE)
(defconstant $timingApple1Kb #xC8)
(defconstant $timingApple19 #xD2)
(defconstant $timingApple21 #xDC)
(defconstant $timingSony_1900x1200_74hz #x212)  ;  1900x1200 (74 Hz) Sony timing (pixel clock is 236.25 Mhz dot clock). 

(defconstant $timingSony_1900x1200_76hz #x21C)  ;  1900x1200 (76 Hz) Sony timing (pixel clock is 245.48 Mhz dot clock). 

;  csConnectFlags values in VDDisplayConnectInfo 

(defconstant $kAllModesValid 0)                 ;  All modes not trimmed by primary init are good close enough to try 

(defconstant $kAllModesSafe 1)                  ;  All modes not trimmed by primary init are know to be safe 

(defconstant $kReportsTagging 2)                ;  Can detect tagged displays (to identify smart monitors) 

(defconstant $kHasDirectConnection 3)           ;  True implies that driver can talk directly to device (e.g. serial data link via sense lines) 

(defconstant $kIsMonoDev 4)                     ;  Says whether there’s an RGB (0) or Monochrome (1) connection. 

(defconstant $kUncertainConnection 5)           ;  There may not be a display (no sense lines?). 

(defconstant $kTaggingInfoNonStandard 6)        ;  Set when csConnectTaggedType/csConnectTaggedData are non-standard (i.e., not the Apple CRT sense codes). 

(defconstant $kReportsDDCConnection 7)          ;  Card can do ddc (set kHasDirectConnect && kHasDDCConnect if you actually found a ddc display). 

(defconstant $kHasDDCConnection 8)              ;  Card has ddc connect now. 

(defconstant $kConnectionInactive 9)            ;  Set when the connection is NOT currently active (generally used in a multiconnection environment). 

(defconstant $kDependentConnection 10)          ;  Set when some ascpect of THIS connection depends on another (will generally be set in a kModeSimulscan environment). 

(defconstant $kBuiltInConnection 11)            ;  Set when connection is KNOWN to be built-in (this is not the same as kHasDirectConnection). 

(defconstant $kOverrideConnection 12)           ;  Set when the reported connection is not the true one, but is one that has been forced through a SetConnection call 

(defconstant $kFastCheckForDDC 13)              ;  Set when all 3 are true: 1) sense codes indicate DDC display could be attached 2) attempted fast check 3) DDC failed 

(defconstant $kReportsHotPlugging 14)           ;  Detects and reports hot pluggging on connector (via VSL also implies DDC will be up to date w/o force read) 

;  csDisplayType values in VDDisplayConnectInfo 

(defconstant $kUnknownConnect 1)                ;  Not sure how we’ll use this, but seems like a good idea. 

(defconstant $kPanelConnect 2)                  ;  For use with fixed-in-place LCD panels. 

(defconstant $kPanelTFTConnect 2)               ;  Alias for kPanelConnect 

(defconstant $kFixedModeCRTConnect 3)           ;   For use with fixed-mode (i.e., very limited range) displays. 

(defconstant $kMultiModeCRT1Connect 4)          ;  320x200 maybe, 12" maybe, 13" (default), 16" certain, 19" maybe, 21" maybe 

(defconstant $kMultiModeCRT2Connect 5)          ;  320x200 maybe, 12" maybe, 13" certain, 16" (default), 19" certain, 21" maybe 

(defconstant $kMultiModeCRT3Connect 6)          ;  320x200 maybe, 12" maybe, 13" certain, 16" certain, 19" default, 21" certain 

(defconstant $kMultiModeCRT4Connect 7)          ;  Expansion to large multi mode (not yet used) 

(defconstant $kModelessConnect 8)               ;  Expansion to modeless model (not yet used) 

(defconstant $kFullPageConnect 9)               ;  640x818 (to get 8bpp in 512K case) and 640x870 (these two only) 

(defconstant $kVGAConnect 10)                   ;  640x480 VGA default -- question everything else 

(defconstant $kNTSCConnect 11)                  ;  NTSC ST (default), FF, STconv, FFconv 

(defconstant $kPALConnect 12)                   ;  PAL ST (default), FF, STconv, FFconv 

(defconstant $kHRConnect 13)                    ;  Straight-6 connect -- 640x480 and 640x400 (to get 8bpp in 256K case) (these two only) 

(defconstant $kPanelFSTNConnect 14)             ;  For use with fixed-in-place LCD FSTN (aka “Supertwist”) panels 

(defconstant $kMonoTwoPageConnect 15)           ;  1152x870 Apple color two-page display 

(defconstant $kColorTwoPageConnect 16)          ;  1152x870 Apple B&W two-page display 

(defconstant $kColor16Connect 17)               ;  832x624 Apple B&W two-page display 

(defconstant $kColor19Connect 18)               ;  1024x768 Apple B&W two-page display 

(defconstant $kGenericCRT 19)                   ;  Indicates nothing except that connection is CRT in nature. 

(defconstant $kGenericLCD 20)                   ;  Indicates nothing except that connection is LCD in nature. 

(defconstant $kDDCConnect 21)                   ;  DDC connection, always set kHasDDCConnection 

(defconstant $kNoConnect 22)                    ;  No display is connected - load sensing or similar level of hardware detection is assumed (used by resident drivers that support hot plugging when nothing is currently connected) 

;  csTimingFlags values in VDTimingInfoRec 

(defconstant $kModeValid 0)                     ;  Says that this mode should NOT be trimmed. 

(defconstant $kModeSafe 1)                      ;  This mode does not need confirmation 

(defconstant $kModeDefault 2)                   ;  This is the default mode for this type of connection 

(defconstant $kModeShowNow 3)                   ;  This mode should always be shown (even though it may require a confirm) 

(defconstant $kModeNotResize 4)                 ;  This mode should not be used to resize the display (eg. mode selects a different connector on card) 

(defconstant $kModeRequiresPan 5)               ;  This mode has more pixels than are actually displayed 

(defconstant $kModeInterlaced 6)                ;  This mode is interlaced (single pixel lines look bad). 

(defconstant $kModeShowNever 7)                 ;  This mode should not be shown in the user interface. 

(defconstant $kModeSimulscan 8)                 ;  Indicates that more than one display connection can be driven from a single framebuffer controller. 

(defconstant $kModeNotPreset 9)                 ;  Indicates that the timing is not a factory preset for the current display (geometry may need correction) 

(defconstant $kModeBuiltIn 10)                  ;  Indicates that the display mode is for the built-in connect only (on multiconnect devices like the PB 3400) Only the driver is quieried 

(defconstant $kModeStretched 11)                ;  Indicates that the display mode will be stretched/distorted to match the display aspect ratio 

;  csDepthFlags in VDVideoParametersInfoRec 

(defconstant $kDepthDependent 0)                ;  Says that this depth mode may cause dependent changes in other framebuffers (and . 

;  csResolutionFlags bit flags for VDResolutionInfoRec 

(defconstant $kResolutionHasMultipleDepthSizes 0);  Says that this mode has different csHorizontalPixels, csVerticalLines at different depths (usually slightly larger at lower depths) 

;     Power Mode constants for VDPowerStateRec.powerState.  Note the numeric order does not match the power state order 

(defconstant $kAVPowerOff 0)                    ;  Power fully off

(defconstant $kAVPowerStandby 1)
(defconstant $kAVPowerSuspend 2)
(defconstant $kAVPowerOn 3)
(defconstant $kHardwareSleep #x80)
(defconstant $kHardwareWake #x81)
(defconstant $kHardwareWakeFromSuspend #x82)
(defconstant $kHardwareWakeToDoze #x83)
(defconstant $kHardwareWakeToDozeFromSuspend #x84)
;     Power Mode masks and bits for VDPowerStateRec.powerFlags.  

(defconstant $kPowerStateNeedsRefresh 0)        ;  When leaving this power mode, a display will need refreshing   

(defconstant $kPowerStateSleepAwareBit 1)       ;  if gestaltPCCardDockingSelectorFix, Docking mgr checks this bit before checking kPowerStateSleepAllowedBit 

(defconstant $kPowerStateSleepForbiddenBit 2)   ;  if kPowerStateSleepAwareBit, Docking mgr checks this bit before sleeping 

(defconstant $kPowerStateSleepCanPowerOffBit 3) ;  supports power down sleep (ie PCI power off)

(defconstant $kPowerStateSleepNoDPMSBit 4)      ;  Bug #2425210.  Do not use DPMS with this display.

(defconstant $kPowerStateSleepWaketoDozeBit 5)  ;  Supports Wake to Doze 

(defconstant $kPowerStateNeedsRefreshMask 1)
(defconstant $kPowerStateSleepAwareMask 2)
(defconstant $kPowerStateSleepForbiddenMask 4)
(defconstant $kPowerStateSleepCanPowerOffMask 8)
(defconstant $kPowerStateSleepNoDPMSMask 16)
(defconstant $kPowerStateSleepWaketoDozeMask 32)
;  Control Codes 

(defconstant $cscReset 0)
(defconstant $cscKillIO 1)
(defconstant $cscSetMode 2)
(defconstant $cscSetEntries 3)
(defconstant $cscSetGamma 4)
(defconstant $cscGrayPage 5)
(defconstant $cscGrayScreen 5)
(defconstant $cscSetGray 6)
(defconstant $cscSetInterrupt 7)
(defconstant $cscDirectSetEntries 8)
(defconstant $cscSetDefaultMode 9)
(defconstant $cscSwitchMode 10)                 ;  Takes a VDSwitchInfoPtr 

(defconstant $cscSetSync 11)                    ;  Takes a VDSyncInfoPtr 

(defconstant $cscSavePreferredConfiguration 16) ;  Takes a VDSwitchInfoPtr 

(defconstant $cscSetHardwareCursor 22)          ;  Takes a VDSetHardwareCursorPtr 

(defconstant $cscDrawHardwareCursor 23)         ;  Takes a VDDrawHardwareCursorPtr 

(defconstant $cscSetConvolution 24)             ;  Takes a VDConvolutionInfoPtr 

(defconstant $cscSetPowerState 25)              ;  Takes a VDPowerStatePtr 

(defconstant $cscPrivateControlCall 26)         ;  Takes a VDPrivateSelectorDataPtr 

(defconstant $cscSetMultiConnect 28)            ;  Takes a VDMultiConnectInfoPtr 

(defconstant $cscSetClutBehavior 29)            ;  Takes a VDClutBehavior 

(defconstant $cscSetDetailedTiming 31)          ;  Takes a VDDetailedTimingPtr 

(defconstant $cscDoCommunication 33)            ;  Takes a VDCommunicationPtr 

(defconstant $cscProbeConnection 34)            ;  Takes nil pointer (may generate a kFBConnectInterruptServiceType service interrupt)

(defconstant $cscUnusedCall 127)                ;  This call used to expend the scrn resource.  Its imbedded data contains more control info 

;  Status Codes 

(defconstant $cscGetMode 2)
(defconstant $cscGetEntries 3)
(defconstant $cscGetPageCnt 4)
(defconstant $cscGetPages 4)                    ;  This is what C&D 2 calls it. 

(defconstant $cscGetPageBase 5)
(defconstant $cscGetBaseAddr 5)                 ;  This is what C&D 2 calls it. 

(defconstant $cscGetGray 6)
(defconstant $cscGetInterrupt 7)
(defconstant $cscGetGamma 8)
(defconstant $cscGetDefaultMode 9)
(defconstant $cscGetCurMode 10)                 ;  Takes a VDSwitchInfoPtr 

(defconstant $cscGetSync 11)                    ;  Takes a VDSyncInfoPtr 

(defconstant $cscGetConnection 12)              ;  Return information about the connection to the display 

(defconstant $cscGetModeTiming 13)              ;  Return timing info for a mode 

(defconstant $cscGetModeBaseAddress 14)         ;  Return base address information about a particular mode 

(defconstant $cscGetScanProc 15)                ;  QuickTime scan chasing routine 

(defconstant $cscGetPreferredConfiguration 16)  ;  Takes a VDSwitchInfoPtr 

(defconstant $cscGetNextResolution 17)          ;  Takes a VDResolutionInfoPtr 

(defconstant $cscGetVideoParameters 18)         ;  Takes a VDVideoParametersInfoPtr 

(defconstant $cscGetGammaInfoList 20)           ;  Takes a VDGetGammaListPtr 

(defconstant $cscRetrieveGammaTable 21)         ;  Takes a VDRetrieveGammaPtr 

(defconstant $cscSupportsHardwareCursor 22)     ;  Takes a VDSupportsHardwareCursorPtr 

(defconstant $cscGetHardwareCursorDrawState 23) ;  Takes a VDHardwareCursorDrawStatePtr 

(defconstant $cscGetConvolution 24)             ;  Takes a VDConvolutionInfoPtr 

(defconstant $cscGetPowerState 25)              ;  Takes a VDPowerStatePtr 

(defconstant $cscPrivateStatusCall 26)          ;  Takes a VDPrivateSelectorDataPtr 

(defconstant $cscGetDDCBlock 27)                ;  Takes a VDDDCBlockPtr  

(defconstant $cscGetMultiConnect 28)            ;  Takes a VDMultiConnectInfoPtr 

(defconstant $cscGetClutBehavior 29)            ;  Takes a VDClutBehaviorPtr 

(defconstant $cscGetTimingRanges 30)            ;  Takes a VDDisplayTimingRangePtr 

(defconstant $cscGetDetailedTiming 31)          ;  Takes a VDDetailedTimingPtr 

(defconstant $cscGetCommunicationInfo 32)       ;  Takes a VDCommunicationInfoPtr 

;  Bit definitions for the Get/Set Sync call

(defconstant $kDisableHorizontalSyncBit 0)
(defconstant $kDisableVerticalSyncBit 1)
(defconstant $kDisableCompositeSyncBit 2)
(defconstant $kEnableSyncOnBlue 3)
(defconstant $kEnableSyncOnGreen 4)
(defconstant $kEnableSyncOnRed 5)
(defconstant $kNoSeparateSyncControlBit 6)
(defconstant $kTriStateSyncBit 7)
(defconstant $kHorizontalSyncMask 1)
(defconstant $kVerticalSyncMask 2)
(defconstant $kCompositeSyncMask 4)
(defconstant $kDPMSSyncMask 7)
(defconstant $kTriStateSyncMask #x80)
(defconstant $kSyncOnBlueMask 8)
(defconstant $kSyncOnGreenMask 16)
(defconstant $kSyncOnRedMask 32)
(defconstant $kSyncOnMask 56)
;     Power Mode constants for translating DPMS modes to Get/SetSync calls.  

(defconstant $kDPMSSyncOn 0)
(defconstant $kDPMSSyncStandby 1)
(defconstant $kDPMSSyncSuspend 2)
(defconstant $kDPMSSyncOff 7)
;  Bit definitions for the Get/Set Convolution call

(defconstant $kConvolved 0)
(defconstant $kLiveVideoPassThru 1)
(defconstant $kConvolvedMask 1)
(defconstant $kLiveVideoPassThruMask 2)
(defrecord VPBlock
   (vpBaseOffset :signed-long)                  ; Offset to page zero of video RAM (From minorBaseOS).
   (vpRowBytes :SInt16)                         ; Width of each row of video memory.
   (vpBounds :Rect)                             ; BoundsRect for the video display (gives dimensions).
   (vpVersion :SInt16)                          ; PixelMap version number.
   (vpPackType :SInt16)
   (vpPackSize :signed-long)
   (vpHRes :signed-long)                        ; Horizontal resolution of the device (pixels per inch).
   (vpVRes :signed-long)                        ; Vertical resolution of the device (pixels per inch).
   (vpPixelType :SInt16)                        ; Defines the pixel type.
   (vpPixelSize :SInt16)                        ; Number of bits in pixel.
   (vpCmpCount :SInt16)                         ; Number of components in pixel.
   (vpCmpSize :SInt16)                          ; Number of bits per component
   (vpPlaneBytes :signed-long)                  ; Offset from one plane to the next.
)

;type name? (%define-record :VPBlock (find-record-descriptor ':VPBlock))

(def-mactype :VPBlockPtr (find-mactype '(:pointer :VPBlock)))
(defrecord VDEntryRecord
   (csTable :pointer)                           ; (long) pointer to color table entry=value, r,g,b:INTEGER
)

;type name? (%define-record :VDEntryRecord (find-record-descriptor ':VDEntryRecord))

(def-mactype :VDEntRecPtr (find-mactype '(:pointer :VDEntryRecord)))
;  Parm block for SetGray control call 
(defrecord VDGrayRecord
   (csMode :Boolean)                            ; Same as GDDevType value (0=color, 1=mono)
   (filler :SInt8)
)

;type name? (%define-record :VDGrayRecord (find-record-descriptor ':VDGrayRecord))

(def-mactype :VDGrayPtr (find-mactype '(:pointer :VDGrayRecord)))
;  Parm block for SetInterrupt call 
(defrecord VDFlagRecord
   (csMode :SInt8)
   (filler :SInt8)
)

;type name? (%define-record :VDFlagRecord (find-record-descriptor ':VDFlagRecord))

(def-mactype :VDFlagRecPtr (find-mactype '(:pointer :VDFlagRecord)))
;  Parm block for SetEntries control call 
(defrecord VDSetEntryRecord
   (csTable (:pointer :ColorSpec))              ; Pointer to an array of color specs
   (csStart :SInt16)                            ; Which spec in array to start with, or -1
   (csCount :SInt16)                            ; Number of color spec entries to set
)

;type name? (%define-record :VDSetEntryRecord (find-record-descriptor ':VDSetEntryRecord))

(def-mactype :VDSetEntryPtr (find-mactype '(:pointer :VDSetEntryRecord)))
;  Parm block for SetGamma control call 
(defrecord VDGammaRecord
   (csGTable :pointer)                          ; pointer to gamma table
)

;type name? (%define-record :VDGammaRecord (find-record-descriptor ':VDGammaRecord))

(def-mactype :VDGamRecPtr (find-mactype '(:pointer :VDGammaRecord)))
(defrecord VDBaseAddressInfoRec
   (csDevData :signed-long)                     ;  LONGINT - (long) timing mode 
   (csDevBase :signed-long)                     ;  LONGINT - (long) base address of the mode 
   (csModeReserved :SInt16)                     ;  INTEGER - (short) will some day be the depth 
   (csModeBase :signed-long)                    ;  LONGINT - (long) reserved 
)

;type name? (%define-record :VDBaseAddressInfoRec (find-record-descriptor ':VDBaseAddressInfoRec))

(def-mactype :VDBaseAddressInfoPtr (find-mactype '(:pointer :VDBaseAddressInfoRec)))
(defrecord VDSwitchInfoRec
   (csMode :UInt16)                             ; (word) mode depth
   (csData :UInt32)                             ; (long) functional sResource of mode
   (csPage :UInt16)                             ; (word) page to switch in
   (csBaseAddr :pointer)                        ; (long) base address of page (return value)
   (csReserved :UInt32)                         ; (long) Reserved (set to 0) 
)

;type name? (%define-record :VDSwitchInfoRec (find-record-descriptor ':VDSwitchInfoRec))

(def-mactype :VDSwitchInfoPtr (find-mactype '(:pointer :VDSwitchInfoRec)))
(defrecord VDTimingInfoRec
   (csTimingMode :UInt32)                       ;  LONGINT - (long) timing mode (a la InitGDevice) 
   (csTimingReserved :UInt32)                   ;  LONGINT - (long) reserved 
   (csTimingFormat :UInt32)                     ;  LONGINT - (long) what format is the timing info 
   (csTimingData :UInt32)                       ;  LONGINT - (long) data supplied by driver 
   (csTimingFlags :UInt32)                      ;  LONGINT - (long) mode within device 
)

;type name? (%define-record :VDTimingInfoRec (find-record-descriptor ':VDTimingInfoRec))

(def-mactype :VDTimingInfoPtr (find-mactype '(:pointer :VDTimingInfoRec)))
(defrecord VDDisplayConnectInfoRec
   (csDisplayType :UInt16)                      ;  INTEGER - (word) Type of display connected 
   (csConnectTaggedType :UInt8)                 ;  BYTE - type of tagging 
   (csConnectTaggedData :UInt8)                 ;  BYTE - tagging data 
   (csConnectFlags :UInt32)                     ;  LONGINT - (long) tell us about the connection 
   (csDisplayComponent :UInt32)                 ;  LONGINT - (long) if the card has a direct connection to the display, it returns the display component here (FUTURE) 
   (csConnectReserved :UInt32)                  ;  LONGINT - (long) reserved 
)

;type name? (%define-record :VDDisplayConnectInfoRec (find-record-descriptor ':VDDisplayConnectInfoRec))

(def-mactype :VDDisplayConnectInfoPtr (find-mactype '(:pointer :VDDisplayConnectInfoRec)))
(defrecord VDMultiConnectInfoRec
   (csDisplayCountOrNumber :UInt32)             ;  For GetMultiConnect, returns count n of 1..n connections; otherwise, indicates the ith connection.
   (csConnectInfo :VDDisplayConnectInfoRec)     ;  Standard VDDisplayConnectionInfo for connection i.
)

;type name? (%define-record :VDMultiConnectInfoRec (find-record-descriptor ':VDMultiConnectInfoRec))

(def-mactype :VDMultiConnectInfoPtr (find-mactype '(:pointer :VDMultiConnectInfoRec)))
;  RawSenseCode
;     This abstract data type is not exactly abstract.  Rather, it is merely enumerated constants
;     for the possible raw sense code values when 'standard' sense code hardware is implemented.
; 
;     For 'standard' sense code hardware, the raw sense is obtained as follows:
;         • Instruct the frame buffer controller NOT to actively drive any of the monitor sense lines
;         • Read the state of the monitor sense lines 2, 1, and 0.  (2 is the MSB, 0 the LSB)
; 
;     IMPORTANT Note: 
;     When the 'kTaggingInfoNonStandard' bit of 'csConnectFlags' is FALSE, then these constants 
;     are valid 'csConnectTaggedType' values in 'VDDisplayConnectInfo' 
; 
; 

(def-mactype :RawSenseCode (find-mactype ':UInt8))

(defconstant $kRSCZero 0)
(defconstant $kRSCOne 1)
(defconstant $kRSCTwo 2)
(defconstant $kRSCThree 3)
(defconstant $kRSCFour 4)
(defconstant $kRSCFive 5)
(defconstant $kRSCSix 6)
(defconstant $kRSCSeven 7)
;  ExtendedSenseCode
;     This abstract data type is not exactly abstract.  Rather, it is merely enumerated constants
;     for the values which are possible when the extended sense algorithm is applied to hardware
;     which implements 'standard' sense code hardware.
; 
;     For 'standard' sense code hardware, the extended sense code algorithm is as follows:
;     (Note:  as described here, sense line 'A' corresponds to '2', 'B' to '1', and 'C' to '0')
;         • Drive sense line 'A' low and read the values of 'B' and 'C'.  
;         • Drive sense line 'B' low and read the values of 'A' and 'C'.
;         • Drive sense line 'C' low and read the values of 'A' and 'B'.
; 
;     In this way, a six-bit number of the form BC/AC/AB is generated. 
; 
;     IMPORTANT Note: 
;     When the 'kTaggingInfoNonStandard' bit of 'csConnectFlags' is FALSE, then these constants 
;     are valid 'csConnectTaggedData' values in 'VDDisplayConnectInfo' 
; 
; 

(def-mactype :ExtendedSenseCode (find-mactype ':UInt8))

(defconstant $kESCZero21Inch 0)                 ;  21" RGB                     

(defconstant $kESCOnePortraitMono 20)           ;  Portrait Monochrome              

(defconstant $kESCTwo12Inch 33)                 ;  12" RGB                    

(defconstant $kESCThree21InchRadius 49)         ;  21" RGB (Radius)               

(defconstant $kESCThree21InchMonoRadius 52)     ;  21" Monochrome (Radius)           

(defconstant $kESCThree21InchMono 53)           ;  21" Monochrome               

(defconstant $kESCFourNTSC 10)                  ;  NTSC                     

(defconstant $kESCFivePortrait 30)              ;  Portrait RGB              

(defconstant $kESCSixMSB1 3)                    ;  MultiScan Band-1 (12" thru 1Six")  

(defconstant $kESCSixMSB2 11)                   ;  MultiScan Band-2 (13" thru 19")       

(defconstant $kESCSixMSB3 35)                   ;  MultiScan Band-3 (13" thru 21")       

(defconstant $kESCSixStandard 43)               ;  13"/14" RGB or 12" Monochrome   

(defconstant $kESCSevenPAL 0)                   ;  PAL                        

(defconstant $kESCSevenNTSC 20)                 ;  NTSC                     

(defconstant $kESCSevenVGA 23)                  ;  VGA                        

(defconstant $kESCSeven16Inch 45)               ;  16" RGB (GoldFish)               

(defconstant $kESCSevenPALAlternate 48)         ;  PAL (Alternate)                

(defconstant $kESCSeven19Inch 58)               ;  Third-Party 19”                 

(defconstant $kESCSevenDDC 62)                  ;  DDC display                   

(defconstant $kESCSevenNoDisplay 63)            ;  No display connected           

;  DepthMode
;     This abstract data type is used to to reference RELATIVE pixel depths.
;     Its definition is largely derived from its past usage, analogous to 'xxxVidMode'
; 
;     Bits per pixel DOES NOT directly map to 'DepthMode'  For example, on some
;     graphics hardware, 'kDepthMode1' may represent 1 BPP, whereas on other
;     hardware, 'kDepthMode1' may represent 8BPP.
; 
;     DepthMode IS considered to be ordinal, i.e., operations such as <, >, ==, etc.
;     behave as expected.  The values of the constants which comprise the set are such
;     that 'kDepthMode4 < kDepthMode6' behaves as expected.
; 

(def-mactype :DepthMode (find-mactype ':UInt16))

(defconstant $kDepthMode1 #x80)
(defconstant $kDepthMode2 #x81)
(defconstant $kDepthMode3 #x82)
(defconstant $kDepthMode4 #x83)
(defconstant $kDepthMode5 #x84)
(defconstant $kDepthMode6 #x85)

(defconstant $kFirstDepthMode #x80)             ;  These constants are obsolete, and just included    

(defconstant $kSecondDepthMode #x81)            ;  for clients that have converted to the above     

(defconstant $kThirdDepthMode #x82)             ;  kDepthModeXXX constants.                

(defconstant $kFourthDepthMode #x83)
(defconstant $kFifthDepthMode #x84)
(defconstant $kSixthDepthMode #x85)
(defrecord VDPageInfo
   (csMode :SInt16)                             ; (word) mode within device
   (csData :signed-long)                        ; (long) data supplied by driver
   (csPage :SInt16)                             ; (word) page to switch in
   (csBaseAddr :pointer)                        ; (long) base address of page
)

;type name? (%define-record :VDPageInfo (find-record-descriptor ':VDPageInfo))

(def-mactype :VDPgInfoPtr (find-mactype '(:pointer :VDPageInfo)))
(defrecord VDSizeInfo
   (csHSize :SInt16)                            ; (word) desired/returned h size
   (csHPos :SInt16)                             ; (word) desired/returned h position
   (csVSize :SInt16)                            ; (word) desired/returned v size
   (csVPos :SInt16)                             ; (word) desired/returned v position
)

;type name? (%define-record :VDSizeInfo (find-record-descriptor ':VDSizeInfo))

(def-mactype :VDSzInfoPtr (find-mactype '(:pointer :VDSizeInfo)))
(defrecord VDSettings
   (csParamCnt :SInt16)                         ; (word) number of params
   (csBrightMax :SInt16)                        ; (word) max brightness
   (csBrightDef :SInt16)                        ; (word) default brightness
   (csBrightVal :SInt16)                        ; (word) current brightness
   (csCntrstMax :SInt16)                        ; (word) max contrast
   (csCntrstDef :SInt16)                        ; (word) default contrast
   (csCntrstVal :SInt16)                        ; (word) current contrast
   (csTintMax :SInt16)                          ; (word) max tint
   (csTintDef :SInt16)                          ; (word) default tint
   (csTintVal :SInt16)                          ; (word) current tint
   (csHueMax :SInt16)                           ; (word) max hue
   (csHueDef :SInt16)                           ; (word) default hue
   (csHueVal :SInt16)                           ; (word) current hue
   (csHorizDef :SInt16)                         ; (word) default horizontal
   (csHorizVal :SInt16)                         ; (word) current horizontal
   (csHorizMax :SInt16)                         ; (word) max horizontal
   (csVertDef :SInt16)                          ; (word) default vertical
   (csVertVal :SInt16)                          ; (word) current vertical
   (csVertMax :SInt16)                          ; (word) max vertical
)

;type name? (%define-record :VDSettings (find-record-descriptor ':VDSettings))

(def-mactype :VDSettingsPtr (find-mactype '(:pointer :VDSettings)))
(defrecord VDDefMode
   (csID :UInt8)
   (filler :SInt8)
)

;type name? (%define-record :VDDefMode (find-record-descriptor ':VDDefMode))

(def-mactype :VDDefModePtr (find-mactype '(:pointer :VDDefMode)))
(defrecord VDSyncInfoRec
   (csMode :UInt8)
   (csFlags :UInt8)
)

;type name? (%define-record :VDSyncInfoRec (find-record-descriptor ':VDSyncInfoRec))

(def-mactype :VDSyncInfoPtr (find-mactype '(:pointer :VDSyncInfoRec)))

(def-mactype :AVIDType (find-mactype ':UInt32))

(def-mactype :DisplayIDType (find-mactype ':UInt32))

(def-mactype :DisplayModeID (find-mactype ':UInt32))

(def-mactype :VideoDeviceType (find-mactype ':UInt32))

(def-mactype :GammaTableID (find-mactype ':UInt32))
; 
;    All displayModeID values from 0x80000000 to 0xFFFFFFFF and 0x00
;    are reserved for Apple Computer.
; 
;  Constants for the cscGetNextResolution call 

(defconstant $kDisplayModeIDCurrent 0)          ;  Reference the Current DisplayModeID 

(defconstant $kDisplayModeIDInvalid #xFFFFFFFF) ;  A bogus DisplayModeID in all cases 

(defconstant $kDisplayModeIDFindFirstResolution #xFFFFFFFE);  Used in cscGetNextResolution to reset iterator 

(defconstant $kDisplayModeIDNoMoreResolutions #xFFFFFFFD);  Used in cscGetNextResolution to indicate End Of List 

(defconstant $kDisplayModeIDFindFirstProgrammable #xFFFFFFFC);  Used in cscGetNextResolution to find unused programmable timing 

(defconstant $kDisplayModeIDBootProgrammable #xFFFFFFFB);  This is the ID given at boot time by the OF driver to a programmable timing 
;  Lowest (unsigned) DisplayModeID reserved by Apple 

(defconstant $kDisplayModeIDReservedBase #x80000000)
;  Constants for the GetGammaInfoList call 

(defconstant $kGammaTableIDFindFirst #xFFFFFFFE);  Get the first gamma table ID 

(defconstant $kGammaTableIDNoMoreTables #xFFFFFFFD);  Used to indicate end of list 

(defconstant $kGammaTableIDSpecific 0)          ;  Return the info for the given table id 

;  Constants for GetMultiConnect call

(defconstant $kGetConnectionCount #xFFFFFFFF)   ;  Used to get the number of possible connections in a “multi-headed” framebuffer environment.

(defconstant $kActivateConnection 0)            ;  Used for activating a connection (csConnectFlags value).
;  Used for deactivating a connection (csConnectFlags value.)

(defconstant $kDeactivateConnection #x200)
;  VDCommunicationRec.csBusID values

(defconstant $kVideoDefaultBus 0)
;  VDCommunicationInfoRec.csBusType values

(defconstant $kVideoBusTypeInvalid 0)
(defconstant $kVideoBusTypeI2C 1)
;  VDCommunicationRec.csSendType and VDCommunicationRec.csReplyType values and bits in VDCommunicationInfoRec.csSupportedTypes.

(defconstant $kVideoNoTransactionType 0)        ;  No transaction

(defconstant $kVideoSimpleI2CType 1)            ;  Simple I2C message

(defconstant $kVideoDDCciReplyType 2)           ;  DDC/ci message (with imbedded length)

;  VDCommunicationRec.csCommFlags and VDCommunicationInfoRec.csSupportedCommFlags
;  If set, the driver should delay csMinReplyDelay micro seconds between send and recieve

(defconstant $kVideoReplyMicroSecDelayMask 1)
(defrecord VDResolutionInfoRec
   (csPreviousDisplayModeID :UInt32)            ;  ID of the previous resolution in a chain 
   (csDisplayModeID :UInt32)                    ;  ID of the next resolution 
   (csHorizontalPixels :UInt32)                 ;  # of pixels in a horizontal line at the max depth 
   (csVerticalLines :UInt32)                    ;  # of lines in a screen at the max depth 
   (csRefreshRate :signed-long)                 ;  Vertical Refresh Rate in Hz 
   (csMaxDepthMode :UInt16)                     ;  0x80-based number representing max bit depth 
   (csResolutionFlags :UInt32)                  ;  Reserved - flag bits 
   (csReserved :UInt32)                         ;  Reserved 
)

;type name? (%define-record :VDResolutionInfoRec (find-record-descriptor ':VDResolutionInfoRec))

(def-mactype :VDResolutionInfoPtr (find-mactype '(:pointer :VDResolutionInfoRec)))
(defrecord VDVideoParametersInfoRec
   (csDisplayModeID :UInt32)                    ;  the ID of the resolution we want info on 
   (csDepthMode :UInt16)                        ;  The bit depth we want the info on (0x80 based) 
   (csVPBlockPtr (:pointer :VPBlock))           ;  Pointer to a video parameter block 
   (csPageCount :UInt32)                        ;  Number of pages supported by the resolution 
   (csDeviceType :UInt32)                       ;  Device Type:  Direct, Fixed or CLUT; 
   (csDepthFlags :UInt32)                       ;  Flags 
)

;type name? (%define-record :VDVideoParametersInfoRec (find-record-descriptor ':VDVideoParametersInfoRec))

(def-mactype :VDVideoParametersInfoPtr (find-mactype '(:pointer :VDVideoParametersInfoRec)))
(defrecord VDGammaInfoRec
   (csLastGammaID :UInt32)                      ;  the ID of the previous gamma table 
   (csNextGammaID :UInt32)                      ;  the ID of the next gamma table 
   (csGammaPtr :pointer)                        ;  Ptr to a gamma table data 
   (csReserved :UInt32)                         ;  Reserved 
)

;type name? (%define-record :VDGammaInfoRec (find-record-descriptor ':VDGammaInfoRec))

(def-mactype :VDGammaInfoPtr (find-mactype '(:pointer :VDGammaInfoRec)))
(defrecord VDGetGammaListRec
   (csPreviousGammaTableID :UInt32)             ;  ID of the previous gamma table 
   (csGammaTableID :UInt32)                     ;  ID of the gamma table following csPreviousDisplayModeID 
   (csGammaTableSize :UInt32)                   ;  Size of the gamma table in bytes 
   (csGammaTableName (:pointer :char))          ;  Gamma table name (c-string) 
)

;type name? (%define-record :VDGetGammaListRec (find-record-descriptor ':VDGetGammaListRec))

(def-mactype :VDGetGammaListPtr (find-mactype '(:pointer :VDGetGammaListRec)))
(defrecord VDRetrieveGammaRec
   (csGammaTableID :UInt32)                     ;  ID of gamma table to retrieve 
   (csGammaTablePtr (:pointer :GammaTbl))       ;  Location to copy desired gamma to 
)

;type name? (%define-record :VDRetrieveGammaRec (find-record-descriptor ':VDRetrieveGammaRec))

(def-mactype :VDRetrieveGammaPtr (find-mactype '(:pointer :VDRetrieveGammaRec)))
(defrecord VDSetHardwareCursorRec
   (csCursorRef :pointer)                       ;  reference to cursor data 
   (csReserved1 :UInt32)                        ;  reserved for future use 
   (csReserved2 :UInt32)                        ;  should be ignored 
)

;type name? (%define-record :VDSetHardwareCursorRec (find-record-descriptor ':VDSetHardwareCursorRec))

(def-mactype :VDSetHardwareCursorPtr (find-mactype '(:pointer :VDSetHardwareCursorRec)))
(defrecord VDDrawHardwareCursorRec
   (csCursorX :SInt32)                          ;  x coordinate 
   (csCursorY :SInt32)                          ;  y coordinate 
   (csCursorVisible :UInt32)                    ;  true if cursor is must be visible 
   (csReserved1 :UInt32)                        ;  reserved for future use 
   (csReserved2 :UInt32)                        ;  should be ignored 
)

;type name? (%define-record :VDDrawHardwareCursorRec (find-record-descriptor ':VDDrawHardwareCursorRec))

(def-mactype :VDDrawHardwareCursorPtr (find-mactype '(:pointer :VDDrawHardwareCursorRec)))
(defrecord VDSupportsHardwareCursorRec
   (csSupportsHardwareCursor :UInt32)
                                                ;  true if hardware cursor is supported 
   (csReserved1 :UInt32)                        ;  reserved for future use 
   (csReserved2 :UInt32)                        ;  must be zero 
)

;type name? (%define-record :VDSupportsHardwareCursorRec (find-record-descriptor ':VDSupportsHardwareCursorRec))

(def-mactype :VDSupportsHardwareCursorPtr (find-mactype '(:pointer :VDSupportsHardwareCursorRec)))
(defrecord VDHardwareCursorDrawStateRec
   (csCursorX :SInt32)                          ;  x coordinate 
   (csCursorY :SInt32)                          ;  y coordinate 
   (csCursorVisible :UInt32)                    ;  true if cursor is visible 
   (csCursorSet :UInt32)                        ;  true if cursor successfully set by last set control call 
   (csReserved1 :UInt32)                        ;  reserved for future use 
   (csReserved2 :UInt32)                        ;  must be zero 
)

;type name? (%define-record :VDHardwareCursorDrawStateRec (find-record-descriptor ':VDHardwareCursorDrawStateRec))

(def-mactype :VDHardwareCursorDrawStatePtr (find-mactype '(:pointer :VDHardwareCursorDrawStateRec)))
(defrecord VDConvolutionInfoRec
   (csDisplayModeID :UInt32)                    ;  the ID of the resolution we want info on 
   (csDepthMode :UInt16)                        ;  The bit depth we want the info on (0x80 based) 
   (csPage :UInt32)
   (csFlags :UInt32)
   (csReserved :UInt32)
)

;type name? (%define-record :VDConvolutionInfoRec (find-record-descriptor ':VDConvolutionInfoRec))

(def-mactype :VDConvolutionInfoPtr (find-mactype '(:pointer :VDConvolutionInfoRec)))
(defrecord VDPowerStateRec
   (powerState :UInt32)
   (powerFlags :UInt32)
   (powerReserved1 :UInt32)
   (powerReserved2 :UInt32)
)

;type name? (%define-record :VDPowerStateRec (find-record-descriptor ':VDPowerStateRec))

(def-mactype :VDPowerStatePtr (find-mactype '(:pointer :VDPowerStateRec)))
; 
;     Private Data to video drivers.
;     
;     In versions of MacOS with multiple address spaces (System 8), the OS 
;     must know the extent of parameters in order to move them between the caller
;     and driver.  The old private-selector model for video drivers does not have
;     this information so:
;     
;     For post-7.x Systems private calls should be implemented using the cscPrivateCall
; 
(defrecord VDPrivateSelectorDataRec
   (privateParameters (:pointer :void))         ;  Caller's parameters
   (privateParametersSize :UInt32)              ;  Size of data sent from caller to driver
   (privateResults (:pointer :void))            ;  Caller's return area. Can be nil, or same as privateParameters.
   (privateResultsSize :UInt32)                 ;  Size of data driver returns to caller. Can be nil, or same as privateParametersSize.
)

;type name? (%define-record :VDPrivateSelectorDataRec (find-record-descriptor ':VDPrivateSelectorDataRec))
(defrecord VDPrivateSelectorRec
   (reserved :UInt32)                           ;  Reserved (set to 0). 
   (data (:array :VDPrivateSelectorDataRec 1))
)

;type name? (%define-record :VDPrivateSelectorRec (find-record-descriptor ':VDPrivateSelectorRec))
(defrecord VDDDCBlockRec
   (ddcBlockNumber :UInt32)                     ;  Input -- DDC EDID (Extended Display Identification Data) number (1-based) 
   (ddcBlockType :FourCharCode)                 ;  Input -- DDC block type (EDID/VDIF) 
   (ddcFlags :UInt32)                           ;  Input -- DDC Flags
   (ddcReserved :UInt32)                        ;  Reserved 
   (ddcBlockData (:array :unsigned-byte 128))   ;  Output -- DDC EDID/VDIF data (kDDCBlockSize) 
)

;type name? (%define-record :VDDDCBlockRec (find-record-descriptor ':VDDDCBlockRec))

(def-mactype :VDDDCBlockPtr (find-mactype '(:pointer :VDDDCBlockRec)))
;  timingSyncConfiguration

(defconstant $kSyncInterlaceMask #x80)
(defconstant $kSyncAnalogCompositeMask 0)
(defconstant $kSyncAnalogCompositeSerrateMask 4)
(defconstant $kSyncAnalogCompositeRGBSyncMask 2)
(defconstant $kSyncAnalogBipolarMask 8)
(defconstant $kSyncAnalogBipolarSerrateMask 4)
(defconstant $kSyncAnalogBipolarSRGBSyncMask 2)
(defconstant $kSyncDigitalCompositeMask 16)
(defconstant $kSyncDigitalCompositeSerrateMask 4)
(defconstant $kSyncDigitalCompositeMatchHSyncMask 4)
(defconstant $kSyncDigitalSeperateMask 24)
(defconstant $kSyncDigitalVSyncPositiveMask 4)
(defconstant $kSyncDigitalHSyncPositiveMask 2)
(defrecord VDDisplayTimingRangeRec
   (csRangeSize :UInt32)                        ;  Init to sizeof(VDDisplayTimingRangeRec) 
   (csRangeType :UInt32)                        ;  Init to 0 
   (csRangeVersion :UInt32)                     ;  Init to 0 
   (csRangeReserved :UInt32)                    ;  Init to 0 
   (csRangeBlockIndex :UInt32)                  ;  Requested block (first index is 0)
   (csRangeGroup :UInt32)                       ;  set to 0 
   (csRangeBlockCount :UInt32)                  ;  # blocks 
   (csRangeFlags :UInt32)                       ;  dependent video 
   (csMinPixelClock :UInt64)                    ;  Min dot clock in Hz 
   (csMaxPixelClock :UInt64)                    ;  Max dot clock in Hz 
   (csMaxPixelError :UInt32)                    ;  Max dot clock error 
   (csTimingRangeSyncFlags :UInt32)
   (csTimingRangeSignalLevels :UInt32)
   (csReserved0 :UInt32)
   (csMinFrameRate :UInt32)                     ;  Hz 
   (csMaxFrameRate :UInt32)                     ;  Hz 
   (csMinLineRate :UInt32)                      ;  Hz 
   (csMaxLineRate :UInt32)                      ;  Hz 
   (csMaxHorizontalTotal :UInt32)               ;  Clocks - Maximum total (active + blanking) 
   (csMaxVerticalTotal :UInt32)                 ;  Clocks - Maximum total (active + blanking) 
   (csMaxTotalReserved1 :UInt32)                ;  Reserved 
   (csMaxTotalReserved2 :UInt32)                ;  Reserved 
                                                ;  Some cards require that some timing elements
                                                ;  be multiples of a "character size" (often 8
                                                ;  clocks).  The "xxxxCharSize" fields document
                                                ;  those requirements.
   (csCharSizeHorizontalActive :UInt8)          ;  Character size 
   (csCharSizeHorizontalBlanking :UInt8)        ;  Character size 
   (csCharSizeHorizontalSyncOffset :UInt8)      ;  Character size 
   (csCharSizeHorizontalSyncPulse :UInt8)       ;  Character size 
   (csCharSizeVerticalActive :UInt8)            ;  Character size 
   (csCharSizeVerticalBlanking :UInt8)          ;  Character size 
   (csCharSizeVerticalSyncOffset :UInt8)        ;  Character size 
   (csCharSizeVerticalSyncPulse :UInt8)         ;  Character size 
   (csCharSizeHorizontalBorderLeft :UInt8)      ;  Character size 
   (csCharSizeHorizontalBorderRight :UInt8)     ;  Character size 
   (csCharSizeVerticalBorderTop :UInt8)         ;  Character size 
   (csCharSizeVerticalBorderBottom :UInt8)      ;  Character size 
   (csCharSizeHorizontalTotal :UInt8)           ;  Character size for active + blanking 
   (csCharSizeVerticalTotal :UInt8)             ;  Character size for active + blanking 
   (csCharSizeReserved1 :UInt16)                ;  Reserved (Init to 0) 
   (csMinHorizontalActiveClocks :UInt32)
   (csMaxHorizontalActiveClocks :UInt32)
   (csMinHorizontalBlankingClocks :UInt32)
   (csMaxHorizontalBlankingClocks :UInt32)
   (csMinHorizontalSyncOffsetClocks :UInt32)
   (csMaxHorizontalSyncOffsetClocks :UInt32)
   (csMinHorizontalPulseWidthClocks :UInt32)
   (csMaxHorizontalPulseWidthClocks :UInt32)
   (csMinVerticalActiveClocks :UInt32)
   (csMaxVerticalActiveClocks :UInt32)
   (csMinVerticalBlankingClocks :UInt32)
   (csMaxVerticalBlankingClocks :UInt32)
   (csMinVerticalSyncOffsetClocks :UInt32)
   (csMaxVerticalSyncOffsetClocks :UInt32)
   (csMinVerticalPulseWidthClocks :UInt32)
   (csMaxVerticalPulseWidthClocks :UInt32)
   (csMinHorizontalBorderLeft :UInt32)
   (csMaxHorizontalBorderLeft :UInt32)
   (csMinHorizontalBorderRight :UInt32)
   (csMaxHorizontalBorderRight :UInt32)
   (csMinVerticalBorderTop :UInt32)
   (csMaxVerticalBorderTop :UInt32)
   (csMinVerticalBorderBottom :UInt32)
   (csMaxVerticalBorderBottom :UInt32)
   (csReserved1 :UInt32)                        ;  Reserved (Init to 0)
   (csReserved2 :UInt32)                        ;  Reserved (Init to 0)
   (csReserved3 :UInt32)                        ;  Reserved (Init to 0)
   (csReserved4 :UInt32)                        ;  Reserved (Init to 0)
   (csReserved5 :UInt32)                        ;  Reserved (Init to 0)
   (csReserved6 :UInt32)                        ;  Reserved (Init to 0)
   (csReserved7 :UInt32)                        ;  Reserved (Init to 0)
   (csReserved8 :UInt32)                        ;  Reserved (Init to 0)
)

;type name? (%define-record :VDDisplayTimingRangeRec (find-record-descriptor ':VDDisplayTimingRangeRec))

(def-mactype :VDDisplayTimingRangePtr (find-mactype '(:pointer :VDDisplayTimingRangeRec)))
;  csDisplayModeState

(defconstant $kDMSModeReady 0)                  ;  Display Mode ID is configured and ready

(defconstant $kDMSModeNotReady 1)               ;  Display Mode ID is is being programmed

(defconstant $kDMSModeFree 2)                   ;  Display Mode ID is not associated with a timing

;  Video driver Errors -10930 to -10959 

(defconstant $kTimingChangeRestrictedErr -10930)
(defconstant $kVideoI2CReplyPendingErr -10931)
(defconstant $kVideoI2CTransactionErr -10932)
(defconstant $kVideoI2CBusyErr -10933)
(defconstant $kVideoI2CTransactionTypeErr -10934)
(defconstant $kVideoBufferSizeErr -10935)
;  csTimingRangeSignalLevels

(defconstant $kRangeSupportsSignal_0700_0300_Bit 0)
(defconstant $kRangeSupportsSignal_0714_0286_Bit 1)
(defconstant $kRangeSupportsSignal_1000_0400_Bit 2)
(defconstant $kRangeSupportsSignal_0700_0000_Bit 3)
(defconstant $kRangeSupportsSignal_0700_0300_Mask 1)
(defconstant $kRangeSupportsSignal_0714_0286_Mask 2)
(defconstant $kRangeSupportsSignal_1000_0400_Mask 4)
(defconstant $kRangeSupportsSignal_0700_0000_Mask 8)
;  csSignalConfig

(defconstant $kDigitalSignalBit 0)              ;  Do not set.  Mac OS does not currently support arbitrary digital timings

(defconstant $kAnalogSetupExpectedBit 1)        ;  Analog displays - display expects a blank-to-black setup or pedestal.  See VESA signal standards.

(defconstant $kDigitalSignalMask 1)
(defconstant $kAnalogSetupExpectedMask 2)
;  csSignalLevels for analog

(defconstant $kAnalogSignalLevel_0700_0300 0)
(defconstant $kAnalogSignalLevel_0714_0286 1)
(defconstant $kAnalogSignalLevel_1000_0400 2)
(defconstant $kAnalogSignalLevel_0700_0000 3)
;  csTimingRangeSyncFlags

(defconstant $kRangeSupportsSeperateSyncsBit 0)
(defconstant $kRangeSupportsSyncOnGreenBit 1)
(defconstant $kRangeSupportsCompositeSyncBit 2)
(defconstant $kRangeSupportsVSyncSerrationBit 3)
(defconstant $kRangeSupportsSeperateSyncsMask 1)
(defconstant $kRangeSupportsSyncOnGreenMask 2)
(defconstant $kRangeSupportsCompositeSyncMask 4)
(defconstant $kRangeSupportsVSyncSerrationMask 8)
;  csHorizontalSyncConfig and csVerticalSyncConfig

(defconstant $kSyncPositivePolarityBit 0)       ;  Digital separate sync polarity for analog interfaces (0 => negative polarity)

(defconstant $kSyncPositivePolarityMask 1)
;  For timings with kDetailedTimingFormat.
(defrecord VDDetailedTimingRec
   (csTimingSize :UInt32)                       ;  Init to sizeof(VDDetailedTimingRec)
   (csTimingType :UInt32)                       ;  Init to 0
   (csTimingVersion :UInt32)                    ;  Init to 0
   (csTimingReserved :UInt32)                   ;  Init to 0
   (csDisplayModeID :UInt32)                    ;  Init to 0
   (csDisplayModeSeed :UInt32)                  ;  
   (csDisplayModeState :UInt32)                 ;  Display Mode state
   (csDisplayModeAlias :UInt32)                 ;  Mode to use when programmed.
   (csSignalConfig :UInt32)
   (csSignalLevels :UInt32)
   (csPixelClock :UInt64)                       ;  Hz
   (csMinPixelClock :UInt64)                    ;  Hz - With error what is slowest actual clock 
   (csMaxPixelClock :UInt64)                    ;  Hz - With error what is fasted actual clock 
   (csHorizontalActive :UInt32)                 ;  Pixels
   (csHorizontalBlanking :UInt32)               ;  Pixels
   (csHorizontalSyncOffset :UInt32)             ;  Pixels
   (csHorizontalSyncPulseWidth :UInt32)         ;  Pixels
   (csVerticalActive :UInt32)                   ;  Lines
   (csVerticalBlanking :UInt32)                 ;  Lines
   (csVerticalSyncOffset :UInt32)               ;  Lines
   (csVerticalSyncPulseWidth :UInt32)           ;  Lines
   (csHorizontalBorderLeft :UInt32)             ;  Pixels
   (csHorizontalBorderRight :UInt32)            ;  Pixels
   (csVerticalBorderTop :UInt32)                ;  Lines
   (csVerticalBorderBottom :UInt32)             ;  Lines
   (csHorizontalSyncConfig :UInt32)
   (csHorizontalSyncLevel :UInt32)              ;  Future use (init to 0)
   (csVerticalSyncConfig :UInt32)
   (csVerticalSyncLevel :UInt32)                ;  Future use (init to 0)
   (csReserved1 :UInt32)                        ;  Init to 0
   (csReserved2 :UInt32)                        ;  Init to 0
   (csReserved3 :UInt32)                        ;  Init to 0
   (csReserved4 :UInt32)                        ;  Init to 0
   (csReserved5 :UInt32)                        ;  Init to 0
   (csReserved6 :UInt32)                        ;  Init to 0
   (csReserved7 :UInt32)                        ;  Init to 0
   (csReserved8 :UInt32)                        ;  Init to 0
)

;type name? (%define-record :VDDetailedTimingRec (find-record-descriptor ':VDDetailedTimingRec))

(def-mactype :VDDetailedTimingPtr (find-mactype '(:pointer :VDDetailedTimingRec)))

(def-mactype :VDClutBehavior (find-mactype ':UInt32))

(def-mactype :VDClutBehaviorPtr (find-mactype '(:pointer :UInt32)))

(defconstant $kSetClutAtSetEntries 0)           ;  SetEntries behavior is to update clut during SetEntries call

(defconstant $kSetClutAtVBL 1)                  ;  SetEntries behavior is to upate clut at next vbl

(defrecord VDCommunicationRec
   (csBusID :SInt32)                            ;  kVideoDefaultBus for single headed cards.
   (csCommFlags :UInt32)                        ;  Always zero
   (csMinReplyDelay :UInt32)                    ;  Minimum delay between send and reply transactions (units depend on csCommFlags)
   (csReserved2 :UInt32)                        ;  Always zero
   (csSendAddress :UInt32)                      ;  Usually I2C address (eg 0x6E)
   (csSendType :UInt32)                         ;  See kVideoSimpleI2CType etc.
   (csSendBuffer (:pointer :void))              ;  Pointer to the send buffer
   (csSendSize :UInt32)                         ;  Number of bytes to send
   (csReplyAddress :UInt32)                     ;  Address from which to read (eg 0x6F for kVideoDDCciReplyType I2C address)
   (csReplyType :UInt32)                        ;  See kVideoDDCciReplyType etc.
   (csReplyBuffer (:pointer :void))             ;  Pointer to the reply buffer
   (csReplySize :UInt32)                        ;  Max bytes to reply (size of csReplyBuffer)
   (csReserved3 :UInt32)
   (csReserved4 :UInt32)
   (csReserved5 :UInt32)                        ;  Always zero
   (csReserved6 :UInt32)                        ;  Always zero
)

;type name? (%define-record :VDCommunicationRec (find-record-descriptor ':VDCommunicationRec))

(def-mactype :VDCommunicationPtr (find-mactype '(:pointer :VDCommunicationRec)))
(defrecord VDCommunicationInfoRec
   (csBusID :SInt32)                            ;  kVideoDefaultBus for single headed cards. 
   (csBusType :UInt32)                          ;  See kVideoBusI2C etc.
   (csMinBus :SInt32)                           ;  Minimum bus (usually kVideoDefaultBus).  Used to probe additional busses
   (csMaxBus :SInt32)                           ;  Max bus (usually kVideoDefaultBus).  Used to probe additional busses
   (csSupportedTypes :UInt32)                   ;  Bit field for first 32 supported transaction types.  Eg. 0x07 => support for kVideoNoTransactionType, kVideoSimpleI2CType and kVideoDDCciReplyType.
   (csSupportedCommFlags :UInt32)               ;  Return the flags csCommFlags understood by this driver.
   (csReserved2 :UInt32)                        ;  Always zero
   (csReserved3 :UInt32)                        ;  Always zero
   (csReserved4 :UInt32)                        ;  Always zero
   (csReserved5 :UInt32)                        ;  Always zero
   (csReserved6 :UInt32)                        ;  Always zero
   (csReserved7 :UInt32)                        ;  Always zero
)

;type name? (%define-record :VDCommunicationInfoRec (find-record-descriptor ':VDCommunicationInfoRec))

(def-mactype :VDCommunicationInfoPtr (find-mactype '(:pointer :VDCommunicationInfoRec)))
; #pragma options align=reset

; #endif /* __VIDEO__ */


(provide-interface "Video")