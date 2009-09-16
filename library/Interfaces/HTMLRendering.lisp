(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:HTMLRendering.h"
; at Sunday July 2,2006 7:25:14 pm.
; 
;      File:       HTMLRendering/HTMLRendering.h
;  
;      Contains:   HTML Rendering Library Interfaces.
;  
;      Version:    HTMLRenderingLib-66~1
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __HTMLRENDERING__
; #define __HTMLRENDERING__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __EVENTS__
#| #|
#include <HIToolboxEvents.h>
#endif
|#
 |#
; #ifndef __CONTROLS__
#| #|
#include <HIToolboxControls.h>
#endif
|#
 |#
; #ifndef __HITOOLBOX__
#| #|
#include <HIToolboxHIToolbox.h>
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

(def-mactype :HRReference (find-mactype '(:pointer :OpaqueHRReference)))
; 
;  *  HRGetHTMLRenderingLibVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRGetHTMLRenderingLibVersion" 
   ((returnVers (:pointer :NumVersion))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )

; #if TARGET_RT_MAC_CFM
; #ifdef __cplusplus
#| #|
    inline pascal Boolean HRHTMLRenderingLibAvailable() { return ((HRGetHTMLRenderingLibVersion != (void*)kUnresolvedCFragSymbolAddress) ); }
|#
 |#

; #else
; #define HRHTMLRenderingLibAvailable()   ((HRGetHTMLRenderingLibVersion != (void*)kUnresolvedCFragSymbolAddress) )

; #endif

#| 
; #elif TARGET_RT_MAC_MACHO
; #ifdef __cplusplus
#|
    inline pascal Boolean HRHTMLRenderingLibAvailable() { return true; }
|#

; #else
; #define HRHTMLRenderingLibAvailable()   (true)

; #endif

 |#

; #endif  /*  */


(defconstant $kHRRendererHTML32Type :|ht32|)    ;  HTML 3.2 

; 
;  *  HRNewReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRNewReference" 
   ((hrRef (:pointer :HRREFERENCE))
    (rendererType :OSType)
    (grafPtr (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRNewReferenceInWindow()
;  *  
;  *  Discussion:
;  *    Use this API from  a Carbon App. All the contrrols created by the
;  *    HTML renderer will be embedded in the root control of the window
;  *    specified by the window ref.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Pointer to the new reference created and returned by the
;  *      renderer.
;  *    
;  *    rendererType:
;  *      Type of the renderer e.g. kHRRendererHTML32Type. Only this type
;  *      is supported for now.
;  *    
;  *    inWindowRef:
;  *      Reference to the window for which rendering area will be
;  *      specified.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRNewReferenceInWindow" 
   ((hrRef (:pointer :HRREFERENCE))
    (rendererType :OSType)
    (inWindowRef (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRDisposeReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRDisposeReference" 
   ((hrRef (:pointer :OpaqueHRReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRFreeMemory()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRFreeMemory" 
   ((inBytesNeeded :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
;  System level notifications 
; 
;  *  HRScreenConfigurationChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRScreenConfigurationChanged" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HRIsHREvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRIsHREvent" 
   ((eventRecord (:pointer :EventRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  Drawing 
; 
;  *  HRSetGrafPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRSetGrafPtr" 
   ((hrRef (:pointer :OpaqueHRReference))
    (grafPtr (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRSetWindowRef()
;  *  
;  *  Discussion:
;  *    Use this API from  a Carbon App. All the contrrols created by the
;  *    HTML renderer will be moved in the root control of the window
;  *    specified by the window ref. All the drawing will now happen in
;  *    the specified window.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    windowRef:
;  *      new Reference to the window to be attached to the above hrRef.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRSetWindowRef" 
   ((hrRef (:pointer :OpaqueHRReference))
    (windowRef (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRSetEmbeddingControl()
;  *  
;  *  Discussion:
;  *    Use this API to tell the HTML Renderer to embed all the controls
;  *    it has created so far and the new controls it creates after this
;  *    call to be embedded in the given control. Useful if you wish to
;  *    have an HTML displayed with in your dialog. e.g. Software Update
;  *    needs this.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    controlRef:
;  *      all the future controls created by renderer are embeded in this
;  *      controlRef.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRSetEmbeddingControl" 
   ((hrRef (:pointer :OpaqueHRReference))
    (controlRef (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRActivate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRActivate" 
   ((hrRef (:pointer :OpaqueHRReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRDeactivate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRDeactivate" 
   ((hrRef (:pointer :OpaqueHRReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRDraw()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRDraw" 
   ((hrRef (:pointer :OpaqueHRReference))
    (updateRgnH (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRDrawInPort()
;  *  
;  *  Discussion:
;  *    Use this API from  a Carbon App.  All the drawing will now happen
;  *    in the specified port. This is the API you want to use to draw in
;  *    an offscreen port, for example when printing. You could also use
;  *    this API to draw in an on screen port.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    updateRgnH:
;  *      Region to be updated.
;  *    
;  *    grafPtr:
;  *      A graf pointer to render HTML into.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRDrawInPort" 
   ((hrRef (:pointer :OpaqueHRReference))
    (updateRgnH (:pointer :OpaqueRgnHandle))
    (grafPtr (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRSetRenderingRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRSetRenderingRect" 
   ((hrRef (:pointer :OpaqueHRReference))
    (renderingRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGetRenderedImageSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRGetRenderedImageSize" 
   ((hrRef (:pointer :OpaqueHRReference))
    (renderingSize (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGetRenderedImageSize32()
;  *  
;  *  Discussion:
;  *    Use this API when the rendered image could have coordinates
;  *    larger than what SInt16 can hold.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    height:
;  *      Height of the image is returned in this parameter.
;  *    
;  *    width:
;  *      Width of the image is returned in this parameter.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRGetRenderedImageSize32" 
   ((hrRef (:pointer :OpaqueHRReference))
    (height (:pointer :UInt32))
    (width (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRScrollToLocation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRScrollToLocation" 
   ((hrRef (:pointer :OpaqueHRReference))
    (location (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRScrollToImageLocation32()
;  *  
;  *  Discussion:
;  *    Use this API when specifying location to scroll to. Location is
;  *    specified in image space.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    h:
;  *      Horizontal location.
;  *    
;  *    v:
;  *      Vertical location.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRScrollToImageLocation32" 
   ((hrRef (:pointer :OpaqueHRReference))
    (h :SInt32)
    (v :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRForceQuickdraw()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRForceQuickdraw" 
   ((hrRef (:pointer :OpaqueHRReference))
    (forceQuickdraw :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )

(def-mactype :HRScrollbarState (find-mactype ':SInt16))

(defconstant $eHRScrollbarOn 0)
(defconstant $eHRScrollbarOff 1)
(defconstant $eHRScrollbarAuto 2)
; 
;  *  HRSetScrollbarState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRSetScrollbarState" 
   ((hrRef (:pointer :OpaqueHRReference))
    (hScrollbarState :SInt16)
    (vScrollbarState :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRSetDrawBorder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRSetDrawBorder" 
   ((hrRef (:pointer :OpaqueHRReference))
    (drawBorder :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRSetGrowboxCutout()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRSetGrowboxCutout" 
   ((hrRef (:pointer :OpaqueHRReference))
    (allowCutout :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Navigation 
; 
;  *  HRGoToFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRGoToFile" 
   ((hrRef (:pointer :OpaqueHRReference))
    (fsspec (:pointer :FSSpec))
    (addToHistory :Boolean)
    (forceRefresh :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGoToURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRGoToURL" 
   ((hrRef (:pointer :OpaqueHRReference))
    (url (:pointer :char))
    (addToHistory :Boolean)
    (forceRefresh :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGoToAnchor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRGoToAnchor" 
   ((hrRef (:pointer :OpaqueHRReference))
    (anchorName (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGoToPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRGoToPtr" 
   ((hrRef (:pointer :OpaqueHRReference))
    (buffer (:pointer :char))
    (bufferSize :UInt32)
    (addToHistory :Boolean)
    (forceRefresh :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGoToFSRef()
;  *  
;  *  Discussion:
;  *    Use these API from  a Carbon App instead of using HRGoToFile,
;  *    HRGoToURL, HRGoToAnchor and HRGoToPtr. These APIs are same in
;  *    behavior with their old counter parts. The only difference is
;  *    that they take FSRef, CFURLRef, CFString, and CFData as
;  *    parameters.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    fref:
;  *      Reference to HTML file that is be opened and rendered.
;  *    
;  *    addToHistory:
;  *      true if this file URL should be added to history.
;  *    
;  *    forceRefresh:
;  *      true if the rendering area should be refreshed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRGoToFSRef" 
   ((hrRef (:pointer :OpaqueHRReference))
    (fref (:pointer :FSRef))
    (addToHistory :Boolean)
    (forceRefresh :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGoToCFURL()
;  *  
;  *  Discussion:
;  *    Use these API from  a Carbon App instead of using HRGoToFile,
;  *    HRGoToURL, HRGoToAnchor and HRGoToPtr. These APIs are same in
;  *    behavior with their old counter parts. The only difference is
;  *    that they take FSRef, CFURLRef, CFString, and CFData as
;  *    parameters.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    url:
;  *      Reference to url that is be rendered.
;  *    
;  *    addToHistory:
;  *      true if this URL should be added to history.
;  *    
;  *    forceRefresh:
;  *      true if the rendering area should be refreshed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRGoToCFURL" 
   ((hrRef (:pointer :OpaqueHRReference))
    (url (:pointer :__CFURL))
    (addToHistory :Boolean)
    (forceRefresh :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGoToAnchorCFString()
;  *  
;  *  Discussion:
;  *    Use these API from  a Carbon App instead of using HRGoToFile,
;  *    HRGoToURL, HRGoToAnchor and HRGoToPtr. These APIs are same in
;  *    behavior with their old counter parts. The only difference is
;  *    that they take FSRef, CFURLRef, CFString, and CFData as
;  *    parameters.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    anchorName:
;  *      Name of the anchor to be displayed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRGoToAnchorCFString" 
   ((hrRef (:pointer :OpaqueHRReference))
    (anchorName (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGoToData()
;  *  
;  *  Discussion:
;  *    Use these API from  a Carbon App instead of using HRGoToFile,
;  *    HRGoToURL, HRGoToAnchor and HRGoToPtr. These APIs are same in
;  *    behavior with their old counter parts. The only difference is
;  *    that they take FSRef, CFURLRef, CFString, and CFData as
;  *    parameters.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    data:
;  *      Reference to data in the memory that is be rendered.
;  *    
;  *    addToHistory:
;  *      true if this file URL should be added to history.
;  *    
;  *    forceRefresh:
;  *      true if the rendering area should be refreshed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRGoToData" 
   ((hrRef (:pointer :OpaqueHRReference))
    (data (:pointer :__CFData))
    (addToHistory :Boolean)
    (forceRefresh :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Accessors 
;  either file url or url of <base> tag 
; 
;  *  HRGetRootURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRGetRootURL" 
   ((hrRef (:pointer :OpaqueHRReference))
    (rootURLH :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  url of <base> tag 
; 
;  *  HRGetBaseURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRGetBaseURL" 
   ((hrRef (:pointer :OpaqueHRReference))
    (baseURLH :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  file url 
; 
;  *  HRGetHTMLURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRGetHTMLURL" 
   ((hrRef (:pointer :OpaqueHRReference))
    (HTMLURLH :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGetTitle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRGetTitle" 
   ((hrRef (:pointer :OpaqueHRReference))
    (title (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGetHTMLFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRGetHTMLFile" 
   ((hrRef (:pointer :OpaqueHRReference))
    (fsspec (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGetRootURLAsCFString()
;  *  
;  *  Discussion:
;  *    Use these API from  a Carbon App instead of using HRGetRootURL,
;  *    HRGetBaseURL, HRGetHTMLURL, HRGetTitle and HRGetHTMLFile. These
;  *    APIs are same in behavior with their old counter parts. The only
;  *    difference is that they take CFString, CFURLRef, and FSRef as
;  *    parameters.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    rootString:
;  *      Get CFString equivalent for the root url.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRGetRootURLAsCFString" 
   ((hrRef (:pointer :OpaqueHRReference))
    (rootString (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGetBaseURLAsCFString()
;  *  
;  *  Discussion:
;  *    Use these API from  a Carbon App instead of using HRGetRootURL,
;  *    HRGetBaseURL, HRGetHTMLURL, HRGetTitle and HRGetHTMLFile. These
;  *    APIs are same in behavior with their old counter parts. The only
;  *    difference is that they take CFString, CFURLRef, and FSRef as
;  *    parameters.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    baseString:
;  *      Get CFString equivalent for the base url.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRGetBaseURLAsCFString" 
   ((hrRef (:pointer :OpaqueHRReference))
    (baseString (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGetHTMLURLAsCFURL()
;  *  
;  *  Discussion:
;  *    Use these API from  a Carbon App instead of using HRGetRootURL,
;  *    HRGetBaseURL, HRGetHTMLURL, HRGetTitle and HRGetHTMLFile. These
;  *    APIs are same in behavior with their old counter parts. The only
;  *    difference is that they take CFString, CFURLRef, and FSRef as
;  *    parameters.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    theURL:
;  *      Get currently displayed HTML as a CFURL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRGetHTMLURLAsCFURL" 
   ((hrRef (:pointer :OpaqueHRReference))
    (theURL (:pointer :CFURLRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGetTitleAsCFString()
;  *  
;  *  Discussion:
;  *    Use these API from  a Carbon App instead of using HRGetRootURL,
;  *    HRGetBaseURL, HRGetHTMLURL, HRGetTitle and HRGetHTMLFile. These
;  *    APIs are same in behavior with their old counter parts. The only
;  *    difference is that they take CFString, CFURLRef, and FSRef as
;  *    parameters.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    title:
;  *      Get title of the currently displayed HTML as a CFString.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRGetTitleAsCFString" 
   ((hrRef (:pointer :OpaqueHRReference))
    (title (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRGetHTMLFileAsFSRef()
;  *  
;  *  Discussion:
;  *    Use these API from  a Carbon App instead of using HRGetRootURL,
;  *    HRGetBaseURL, HRGetHTMLURL, HRGetTitle and HRGetHTMLFile. These
;  *    APIs are same in behavior with their old counter parts. The only
;  *    difference is that they take CFString, CFURLRef, and FSRef as
;  *    parameters.
;  *  
;  *  Parameters:
;  *    
;  *    hrRef:
;  *      Reference to the renderer object.
;  *    
;  *    fref:
;  *      Get currently displayed HTML as a FSRef.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRGetHTMLFileAsFSRef" 
   ((hrRef (:pointer :OpaqueHRReference))
    (fref (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Utilities 
; 
;  *  HRUtilCreateFullURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRUtilCreateFullURL" 
   ((rootURL (:pointer :char))
    (linkURL (:pointer :char))
    (fullURLH :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRUtilGetFSSpecFromURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRUtilGetFSSpecFromURL" 
   ((rootURL (:pointer :char))
    (linkURL (:pointer :char))
    (destSpec (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  urlHandle should be valid on input 
; 
;  *  HRUtilGetURLFromFSSpec()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRUtilGetURLFromFSSpec" 
   ((fsspec (:pointer :FSSpec))
    (urlHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRUtilCreateFullCFURL()
;  *  
;  *  Discussion:
;  *    Use these API from  a Carbon App instead of using
;  *    HRUtilCreateFullURL, HRUtilGetFSSpecFromURL,
;  *    HRUtilGetURLFromFSSpec. These APIs are same in behavior with
;  *    their old counter parts. The only difference is that they take
;  *    CFURLRef, and FSRef as parameters.
;  *  
;  *  Parameters:
;  *    
;  *    rootString:
;  *      a CFString for the root.
;  *    
;  *    linkString:
;  *      a CFString for a partial link.
;  *    
;  *    url:
;  *      Fully qualified URL is returned after attaching a link string
;  *      to the root.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRUtilCreateFullCFURL" 
   ((rootString (:pointer :__CFString))
    (linkString (:pointer :__CFString))
    (url (:pointer :CFURLRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRUtilGetFSRefFromURL()
;  *  
;  *  Discussion:
;  *    Use these API from  a Carbon App instead of using
;  *    HRUtilCreateFullURL, HRUtilGetFSSpecFromURL,
;  *    HRUtilGetURLFromFSSpec. These APIs are same in behavior with
;  *    their old counter parts. The only difference is that they take
;  *    CFURLRef, and FSRef as parameters.
;  *  
;  *  Parameters:
;  *    
;  *    rootString:
;  *      a CFString for the root.
;  *    
;  *    linkString:
;  *      a CFString for a partial link.
;  *    
;  *    destRef:
;  *      File reference is returned for the complete path created after
;  *      attaching link string to the root. If File does not exist,
;  *      fnfErr is returned as a function result.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRUtilGetFSRefFromURL" 
   ((rootString (:pointer :__CFString))
    (linkString (:pointer :__CFString))
    (destRef (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HRUtilGetURLFromFSRef()
;  *  
;  *  Discussion:
;  *    Use these API from  a Carbon App instead of using
;  *    HRUtilCreateFullURL, HRUtilGetFSSpecFromURL,
;  *    HRUtilGetURLFromFSSpec. These APIs are same in behavior with
;  *    their old counter parts. The only difference is that they take
;  *    CFURLRef, and FSRef as parameters.
;  *  
;  *  Parameters:
;  *    
;  *    fileRef:
;  *      Refernce to a file whose URL is desired.
;  *    
;  *    url:
;  *      a fully qualified URL is returned in this parameter. The
;  *      returned URL gives the path of the file specified in the above
;  *      parameter.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRUtilGetURLFromFSRef" 
   ((fileRef (:pointer :FSRef))
    (url (:pointer :CFURLRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Visited links
; 
;     If you register a function here, it will be called to determine
;     whether or not the given URL has been visited. It should return
;     true if the URL has been visited.
;     
;     In addition to the URLs that the application may add to the list
;     of visited links, it should also add URLs that the user clicks
;     on. These URLs can be caught by the "add URL to history" callback
;     below.
;  

(def-mactype :HRWasURLVisitedProcPtr (find-mactype ':pointer)); (const char * url , void * refCon)

(def-mactype :HRWasURLVisitedUPP (find-mactype '(:pointer :OpaqueHRWasURLVisitedProcPtr)))
; 
;  *  HRRegisterWasURLVisitedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRRegisterWasURLVisitedUPP" 
   ((inWasURLVisitedUPP (:pointer :OpaqueHRWasURLVisitedProcPtr))
    (hrRef (:pointer :OpaqueHRReference))
    (inRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HRUnregisterWasURLVisitedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRUnregisterWasURLVisitedUPP" 
   ((hrRef (:pointer :OpaqueHRReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     Use these API from  a Carbon App instead of using HRRegisterWasURLVisitedUPP, HRUnregisterWasURLVisitedUPP. 
;     These APIs are same in behavior with their old counter parts. The only difference is that they take 
;     CFURLRef as parameters.
;         
; 

(def-mactype :HRWasCFURLVisitedProcPtr (find-mactype ':pointer)); (CFURLRef url , void * refCon)

(def-mactype :HRWasCFURLVisitedUPP (find-mactype '(:pointer :OpaqueHRWasCFURLVisitedProcPtr)))
; 
;  *  HRRegisterWasCFURLVisitedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRRegisterWasCFURLVisitedUPP" 
   ((inWasCFURLVisitedUPP (:pointer :OpaqueHRWasCFURLVisitedProcPtr))
    (hrRef (:pointer :OpaqueHRReference))
    (inRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HRUnregisterWasCFURLVisitedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRUnregisterWasCFURLVisitedUPP" 
   ((hrRef (:pointer :OpaqueHRReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     New URL
; 
;     If you register a function here, it will be called every time
;     the renderer is going to display a new URL. A few examples of how
;     you might use this include...
;     
;         (a) maintaining a history of URLs
;         (b) maintainging a list of visited links
;         (c) setting a window title based on the new URL
; 

(def-mactype :HRNewURLProcPtr (find-mactype ':pointer)); (const char * url , const char * targetFrame , Boolean addToHistory , void * refCon)

(def-mactype :HRNewURLUPP (find-mactype '(:pointer :OpaqueHRNewURLProcPtr)))
; 
;  *  HRRegisterNewURLUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRRegisterNewURLUPP" 
   ((inNewURLUPP (:pointer :OpaqueHRNewURLProcPtr))
    (hrRef (:pointer :OpaqueHRReference))
    (inRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HRUnregisterNewURLUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRUnregisterNewURLUPP" 
   ((hrRef (:pointer :OpaqueHRReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  
;     Use these API from  a Carbon App instead of using HRRegisterNewURLUPP, HRUnregisterNewURLUPP. 
;     These APIs are same in behavior with their old counter parts. The only difference is that they take 
;     CFURLRef as parameters.
; 

(def-mactype :HRNewCFURLProcPtr (find-mactype ':pointer)); (CFURLRef url , CFStringRef targetString , Boolean addToHistory , void * refCon)

(def-mactype :HRNewCFURLUPP (find-mactype '(:pointer :OpaqueHRNewCFURLProcPtr)))
; 
;  *  HRRegisterNewCFURLUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRRegisterNewCFURLUPP" 
   ((inURLUPP (:pointer :OpaqueHRNewCFURLProcPtr))
    (hrRef (:pointer :OpaqueHRReference))
    (inRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HRUnregisterNewCFURLUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRUnregisterNewCFURLUPP" 
   ((hrRef (:pointer :OpaqueHRReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     URL to FSSpec function
; 
;     If you register a function here, it will be called every time
;     the renderer is going to locate a file. The function will be
;     passed an enum indicating the type of file being asked for.
;  

(def-mactype :URLSourceType (find-mactype ':UInt16))

(defconstant $kHRLookingForHTMLSource 1)
(defconstant $kHRLookingForImage 2)
(defconstant $kHRLookingForEmbedded 3)
(defconstant $kHRLookingForImageMap 4)
(defconstant $kHRLookingForFrame 5)

(def-mactype :HRURLToFSSpecProcPtr (find-mactype ':pointer)); (const char * rootURL , const char * linkURL , FSSpec * fsspec , URLSourceType urlSourceType , void * refCon)

(def-mactype :HRURLToFSSpecUPP (find-mactype '(:pointer :OpaqueHRURLToFSSpecProcPtr)))
; 
;  *  HRRegisterURLToFSSpecUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRRegisterURLToFSSpecUPP" 
   ((inURLToFSSpecUPP (:pointer :OpaqueHRURLToFSSpecProcPtr))
    (hrRef (:pointer :OpaqueHRReference))
    (inRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HRUnregisterURLToFSSpecUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
;  

(deftrap-inline "_HRUnregisterURLToFSSpecUPP" 
   ((hrRef (:pointer :OpaqueHRReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  
;     Use these API from  a Carbon App instead of using HRRegisterURLToFSSpecUPP, HRUnregisterURLToFSSpecUPP. 
;     These APIs are same in behavior with their old counter parts. The only difference is that they take 
;     FSRef as parameters.
; 

(def-mactype :HRURLToFSRefProcPtr (find-mactype ':pointer)); (CFStringRef rootString , CFStringRef linkString , FSRef * fref , URLSourceType urlSourceType , void * refCon)

(def-mactype :HRURLToFSRefUPP (find-mactype '(:pointer :OpaqueHRURLToFSRefProcPtr)))
; 
;  *  HRRegisterURLToFSRefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRRegisterURLToFSRefUPP" 
   ((inURLToFSRefUPP (:pointer :OpaqueHRURLToFSRefProcPtr))
    (hrRef (:pointer :OpaqueHRReference))
    (inRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HRUnregisterURLToFSRefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HRUnregisterURLToFSRefUPP" 
   ((hrRef (:pointer :OpaqueHRReference))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NewHRWasURLVisitedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewHRWasURLVisitedUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueHRWasURLVisitedProcPtr)
() )
; 
;  *  NewHRWasCFURLVisitedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewHRWasCFURLVisitedUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueHRWasCFURLVisitedProcPtr)
() )
; 
;  *  NewHRNewURLUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewHRNewURLUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueHRNewURLProcPtr)
() )
; 
;  *  NewHRNewCFURLUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewHRNewCFURLUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueHRNewCFURLProcPtr)
() )
; 
;  *  NewHRURLToFSSpecUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewHRURLToFSSpecUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueHRURLToFSSpecProcPtr)
() )
; 
;  *  NewHRURLToFSRefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewHRURLToFSRefUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueHRURLToFSRefProcPtr)
() )
; 
;  *  DisposeHRWasURLVisitedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeHRWasURLVisitedUPP" 
   ((userUPP (:pointer :OpaqueHRWasURLVisitedProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeHRWasCFURLVisitedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeHRWasCFURLVisitedUPP" 
   ((userUPP (:pointer :OpaqueHRWasCFURLVisitedProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeHRNewURLUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeHRNewURLUPP" 
   ((userUPP (:pointer :OpaqueHRNewURLProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeHRNewCFURLUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeHRNewCFURLUPP" 
   ((userUPP (:pointer :OpaqueHRNewCFURLProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeHRURLToFSSpecUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeHRURLToFSSpecUPP" 
   ((userUPP (:pointer :OpaqueHRURLToFSSpecProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeHRURLToFSRefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeHRURLToFSRefUPP" 
   ((userUPP (:pointer :OpaqueHRURLToFSRefProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeHRWasURLVisitedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeHRWasURLVisitedUPP" 
   ((url (:pointer :char))
    (refCon :pointer)
    (userUPP (:pointer :OpaqueHRWasURLVisitedProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeHRWasCFURLVisitedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeHRWasCFURLVisitedUPP" 
   ((url (:pointer :__CFURL))
    (refCon :pointer)
    (userUPP (:pointer :OpaqueHRWasCFURLVisitedProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeHRNewURLUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeHRNewURLUPP" 
   ((url (:pointer :char))
    (targetFrame (:pointer :char))
    (addToHistory :Boolean)
    (refCon :pointer)
    (userUPP (:pointer :OpaqueHRNewURLProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InvokeHRNewCFURLUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeHRNewCFURLUPP" 
   ((url (:pointer :__CFURL))
    (targetString (:pointer :__CFString))
    (addToHistory :Boolean)
    (refCon :pointer)
    (userUPP (:pointer :OpaqueHRNewCFURLProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InvokeHRURLToFSSpecUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeHRURLToFSSpecUPP" 
   ((rootURL (:pointer :char))
    (linkURL (:pointer :char))
    (fsspec (:pointer :FSSpec))
    (urlSourceType :UInt16)
    (refCon :pointer)
    (userUPP (:pointer :OpaqueHRURLToFSSpecProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InvokeHRURLToFSRefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeHRURLToFSRefUPP" 
   ((rootString (:pointer :__CFString))
    (linkString (:pointer :__CFString))
    (fref (:pointer :FSRef))
    (urlSourceType :UInt16)
    (refCon :pointer)
    (userUPP (:pointer :OpaqueHRURLToFSRefProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __HTMLRENDERING__ */


(provide-interface "HTMLRendering")