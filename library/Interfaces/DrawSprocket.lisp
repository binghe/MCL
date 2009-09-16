(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DrawSprocket.h"
; at Sunday July 2,2006 7:27:41 pm.
; 
;      File:       DrawSprocket/DrawSprocket.h
;  
;      Contains:   Games Sprockets: DrawSprocket interfaces
;  
;      Version:    DrawSprocket-2.0.50~947
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __DRAWSPROCKET__
; #define __DRAWSPROCKET__
; #ifndef __CARBON__
#| #|
#include <CarbonCarbon.h>
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
; #pragma options align=power

; #if PRAGMA_ENUM_ALWAYSINT
#| ; #pragma enumsalwaysint on
 |#

; #endif

; 
; ********************************************************************************
; ** constants
; ********************************************************************************
; 
(def-mactype :DSpDepthMask (find-mactype ':sint32))

(defconstant $kDSpDepthMask_1 1)
(defconstant $kDSpDepthMask_2 2)
(defconstant $kDSpDepthMask_4 4)
(defconstant $kDSpDepthMask_8 8)
(defconstant $kDSpDepthMask_16 16)
(defconstant $kDSpDepthMask_32 32)
(defconstant $kDSpDepthMask_All -1)

;type name? (def-mactype :DSpDepthMask (find-mactype ':DSpDepthMask))
(def-mactype :DSpColorNeeds (find-mactype ':sint32))

(defconstant $kDSpColorNeeds_DontCare 0)
(defconstant $kDSpColorNeeds_Request 1)
(defconstant $kDSpColorNeeds_Require 2)

;type name? (def-mactype :DSpColorNeeds (find-mactype ':DSpColorNeeds))
(def-mactype :DSpContextState (find-mactype ':sint32))

(defconstant $kDSpContextState_Active 0)
(defconstant $kDSpContextState_Paused 1)
(defconstant $kDSpContextState_Inactive 2)

;type name? (def-mactype :DSpContextState (find-mactype ':DSpContextState))
;  kDSpContextOption_QD3DAccel not yet implemented 
(def-mactype :DSpContextOption (find-mactype ':sint32))
;     kDSpContextOption_QD3DAccel       = 1<<0,

(defconstant $kDSpContextOption_PageFlip 2)
(defconstant $kDSpContextOption_DontSyncVBL 4)
(defconstant $kDSpContextOption_Stereoscopic 8)

;type name? (def-mactype :DSpContextOption (find-mactype ':DSpContextOption))
(def-mactype :DSpAltBufferOption (find-mactype ':sint32))

(defconstant $kDSpAltBufferOption_RowBytesEqualsWidth 1)

;type name? (def-mactype :DSpAltBufferOption (find-mactype ':DSpAltBufferOption))
(def-mactype :DSpBufferKind (find-mactype ':sint32))

(defconstant $kDSpBufferKind_Normal 0)

;type name? (def-mactype :DSpBufferKind (find-mactype ':DSpBufferKind))
(def-mactype :DSpBlitMode (find-mactype ':sint32))

(defconstant $kDSpBlitMode_Plain 0)
(defconstant $kDSpBlitMode_SrcKey 1)
(defconstant $kDSpBlitMode_DstKey 2)
(defconstant $kDSpBlitMode_Interpolation 4)

;type name? (def-mactype :DSpBlitMode (find-mactype ':DSpBlitMode))
; 
; ********************************************************************************
; ** data types
; ********************************************************************************
; 

(def-mactype :DSpAltBufferReference (find-mactype '(:pointer :OpaqueDSpAltBufferReference)))

(def-mactype :DSpContextReference (find-mactype '(:pointer :OpaqueDSpContextReference)))

(def-mactype :DSpContextReferenceConst (find-mactype '(:pointer :OpaqueDSpContextReference)))
; #define kDSpEveryContext ((DSpContextReference)NULL)

(def-mactype :DSpEventProcPtr (find-mactype ':pointer)); (EventRecord * inEvent)

(def-mactype :DSpCallbackProcPtr (find-mactype ':pointer)); (DSpContextReference inContext , void * inRefCon)

(def-mactype :DSpEventUPP (find-mactype '(:pointer :OpaqueDSpEventProcPtr)))

(def-mactype :DSpCallbackUPP (find-mactype '(:pointer :OpaqueDSpCallbackProcPtr)))
; 
;  *  NewDSpEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  NewDSpCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeDSpEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeDSpCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeDSpEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeDSpCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
(defrecord DSpContextAttributes
   (frequency :signed-long)
   (displayWidth :UInt32)
   (displayHeight :UInt32)
   (reserved1 :UInt32)
   (reserved2 :UInt32)
   (colorNeeds :UInt32)
   (colorTable (:Handle :ColorTable))
   (contextOptions :UInt32)
   (backBufferDepthMask :UInt32)
   (displayDepthMask :UInt32)
   (backBufferBestDepth :UInt32)
   (displayBestDepth :UInt32)
   (pageCount :UInt32)
   (filler (:array :character 3))
   (gameMustConfirmSwitch :Boolean)
   (reserved3 (:array :UInt32 4))
)

;type name? (%define-record :DSpContextAttributes (find-record-descriptor ':DSpContextAttributes))

(def-mactype :DSpContextAttributesPtr (find-mactype '(:pointer :DSpContextAttributes)))
(defrecord DSpAltBufferAttributes
   (width :UInt32)
   (height :UInt32)
   (options :DSpAltBufferOption)
#|
; Warning: type-size: unknown type DSPALTBUFFEROPTION
|#
   (reserved (:array :UInt32 4))
)

;type name? (%define-record :DSpAltBufferAttributes (find-record-descriptor ':DSpAltBufferAttributes))

;type name? (def-mactype :DSpBlitInfo (find-mactype ':DSpBlitInfo))

(def-mactype :DSpBlitDoneProc (find-mactype ':pointer)); (DSpBlitInfo * info)
(defrecord DSpBlitInfo
   (completionFlag :Boolean)
   (filler (:array :character 3))
   (completionProc :pointer)
   (srcContext (:pointer :OpaqueDSpContextReference))
   (srcBuffer (:pointer :OpaqueGrafPtr))
   (srcRect :Rect)
   (srcKey :UInt32)
   (dstContext (:pointer :OpaqueDSpContextReference))
   (dstBuffer (:pointer :OpaqueGrafPtr))
   (dstRect :Rect)
   (dstKey :UInt32)
   (mode :DSpBlitMode)
#|
; Warning: type-size: unknown type DSPBLITMODE
|#
   (reserved (:array :UInt32 4))
)

(def-mactype :DSpBlitInfoPtr (find-mactype '(:pointer :DSpBlitInfo)))
; 
; ********************************************************************************
; ** function prototypes
; ********************************************************************************
; 
; 
; ** global operations
; 
; 
;  *  DSpStartup()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpStartup" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpShutdown()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpShutdown" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpGetVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.7 and later
;  

(deftrap-inline "_DSpGetVersion" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :NumVersion
() )
; 
;  *  DSpGetFirstContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpGetFirstContext" 
   ((inDisplayID :UInt32)
    (outContext (:pointer :DSPCONTEXTREFERENCE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpGetNextContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpGetNextContext" 
   ((inCurrentContext (:pointer :OpaqueDSpContextReference))
    (outContext (:pointer :DSPCONTEXTREFERENCE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpGetCurrentContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.7 and later
;  

(deftrap-inline "_DSpGetCurrentContext" 
   ((inDisplayID :UInt32)
    (outContext (:pointer :DSPCONTEXTREFERENCE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpFindBestContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpFindBestContext" 
   ((inDesiredAttributes (:pointer :DSpContextAttributes))
    (outContext (:pointer :DSPCONTEXTREFERENCE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpFindBestContextOnDisplayID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.7 and later
;  

(deftrap-inline "_DSpFindBestContextOnDisplayID" 
   ((inDesiredAttributes (:pointer :DSpContextAttributes))
    (outContext (:pointer :DSPCONTEXTREFERENCE))
    (inDisplayID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpCanUserSelectContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpUserSelectContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpProcessEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpProcessEvent" 
   ((inEvent (:pointer :EventRecord))
    (outEventWasProcessed (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpSetBlankingColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpSetBlankingColor" 
   ((inRGBColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpSetDebugMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpSetDebugMode" 
   ((inDebugMode :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpFindContextFromPoint()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpFindContextFromPoint" 
   ((inGlobalPoint :Point)
    (outContext (:pointer :DSPCONTEXTREFERENCE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpGetMouse()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpGetMouse" 
   ((outGlobalPoint (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
; ** alternate buffer operations
; 
; 
;  *  DSpAltBuffer_New()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpAltBuffer_Dispose()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpAltBuffer_InvalRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpAltBuffer_GetCGrafPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
; ** context operations
; 
;  general 
; 
;  *  DSpContext_GetAttributes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_GetAttributes" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (outAttributes (:pointer :DSpContextAttributes))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_Reserve()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_Reserve" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (inDesiredAttributes (:pointer :DSpContextAttributes))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_Queue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.7 and later
;  

(deftrap-inline "_DSpContext_Queue" 
   ((inParentContext (:pointer :OpaqueDSpContextReference))
    (inChildContext (:pointer :OpaqueDSpContextReference))
    (inDesiredAttributes (:pointer :DSpContextAttributes))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_Switch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.7 and later
;  

(deftrap-inline "_DSpContext_Switch" 
   ((inOldContext (:pointer :OpaqueDSpContextReference))
    (inNewContext (:pointer :OpaqueDSpContextReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_Release()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_Release" 
   ((inContext (:pointer :OpaqueDSpContextReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_Dispose()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DSpContext_Dispose" 
   ((inContext (:pointer :OpaqueDSpContextReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_GetDisplayID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_GetDisplayID" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (outDisplayID (:pointer :DISPLAYIDTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_GlobalToLocal()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_GlobalToLocal" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (ioPoint (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_LocalToGlobal()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_LocalToGlobal" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (ioPoint (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_SetVBLProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpContext_GetFlattenedSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpContext_Flatten()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpContext_Restore()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpContext_GetMonitorFrequency()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_GetMonitorFrequency" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (outFrequency (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_SetMaxFrameRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpContext_GetMaxFrameRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpContext_SetState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_SetState" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (inState :DSpContextState)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_GetState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_GetState" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (outState (:pointer :DSpContextState))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_IsBusy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_IsBusy" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (outBusyFlag (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  dirty rectangles 
; 
;  *  DSpContext_SetDirtyRectGridSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpContext_GetDirtyRectGridSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpContext_GetDirtyRectGridUnits()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpContext_InvalBackBufferRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
;  underlays 
; 
;  *  DSpContext_SetUnderlayAltBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
; 
;  *  DSpContext_GetUnderlayAltBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  
;  gamma 
; 
;  *  DSpContext_FadeGammaOut()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_FadeGammaOut" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (inZeroIntensityColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_FadeGammaIn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_FadeGammaIn" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (inZeroIntensityColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_FadeGamma()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_FadeGamma" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (inPercentOfOriginalIntensity :sint32)
    (inZeroIntensityColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  buffering 
; 
;  *  DSpContext_SwapBuffers()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_SwapBuffers" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (inBusyProc (:pointer :OpaqueDSpCallbackProcPtr))
    (inUserRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_GetBackBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_GetBackBuffer" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (inBufferKind :DSpBufferKind)
    (outBackBuffer (:pointer :CGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_GetFrontBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.1 and later
;  

(deftrap-inline "_DSpContext_GetFrontBuffer" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (outFrontBuffer (:pointer :CGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  clut operations 
; 
;  *  DSpContext_SetCLUTEntries()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_SetCLUTEntries" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (inEntries (:pointer :ColorSpec))
    (inStartingEntry :UInt16)
    (inLastEntry :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DSpContext_GetCLUTEntries()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DrawSprocket.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
;  

(deftrap-inline "_DSpContext_GetCLUTEntries" 
   ((inContext (:pointer :OpaqueDSpContextReference))
    (outEntries (:pointer :ColorSpec))
    (inStartingEntry :UInt16)
    (inLastEntry :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  blit operations 
; 
;  *  DSpBlit_Faster()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.1 and later
;  
; 
;  *  DSpBlit_Fastest()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DrawSprocketLib 1.1 and later
;  

; #if PRAGMA_ENUM_ALWAYSINT
#| ; #pragma enumsalwaysint reset
 |#

; #endif

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __DRAWSPROCKET__ */


(provide-interface "DrawSprocket")