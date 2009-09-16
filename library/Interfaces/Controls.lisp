(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Controls.h"
; at Sunday July 2,2006 7:24:50 pm.
; 
;      File:       HIToolbox/Controls.h
;  
;      Contains:   Control Manager interfaces
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CONTROLS__
; #define __CONTROLS__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __ICONS__
#| #|
#include <HIServicesIcons.h>
#endif
|#
 |#
; #ifndef __APPEARANCE__

(require-interface "HIToolbox/Appearance")

; #endif

; #ifndef __HIOBJECT__
#| #|
#include <HIToolboxHIObject.h>
#endif
|#
 |#
; #ifndef __MENUS__
#| #|
#include <HIToolboxMenus.h>
#endif
|#
 |#
; #ifndef __TEXTEDIT__

(require-interface "HIToolbox/TextEdit")

; #endif

; #ifndef __DRAG__

(require-interface "HIToolbox/Drag")

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
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • Resource Types                                                                                    
; ——————————————————————————————————————————————————————————————————————————————————————————————————————

(defconstant $kControlDefProcType :|CDEF|)
(defconstant $kControlTemplateResourceType :|CNTL|)
(defconstant $kControlColorTableResourceType :|cctb|)
(defconstant $kControlDefProcResourceType :|CDEF|)
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • Format of a ‘CNTL’ resource                                                                       
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
(defrecord ControlTemplate
   (controlRect :Rect)
   (controlValue :SInt16)
   (controlVisible :Boolean)
   (fill :UInt8)
   (controlMaximum :SInt16)
   (controlMinimum :SInt16)
   (controlDefProcID :SInt16)
   (controlReference :SInt32)
   (controlTitle (:string 255))
)

;type name? (%define-record :ControlTemplate (find-record-descriptor ':ControlTemplate))

(def-mactype :ControlTemplatePtr (find-mactype '(:pointer :ControlTemplate)))

(def-mactype :ControlTemplateHandle (find-mactype '(:handle :ControlTemplate)))
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • ControlRef                                                                                        
; ——————————————————————————————————————————————————————————————————————————————————————————————————————

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
;type name? (def-mactype :ControlRecord (find-mactype ':ControlRecord))

(def-mactype :ControlPtr (find-mactype '(:pointer :ControlRecord)))

(def-mactype :ControlRef (find-mactype '(:pointer :ControlPtr)))
 |#

; #else

(def-mactype :ControlRef (find-mactype '(:pointer :OpaqueControlRef)))

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */

;  ControlHandle is obsolete. Use ControlRef.

(def-mactype :ControlHandle (find-mactype ':ControlRef))

(def-mactype :ControlPartCode (find-mactype ':SInt16))
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;  • Control ActionProcPtr                                                                              
; ——————————————————————————————————————————————————————————————————————————————————————————————————————

(def-mactype :ControlActionProcPtr (find-mactype ':pointer)); (ControlRef theControl , ControlPartCode partCode)

(def-mactype :ControlActionUPP (find-mactype '(:pointer :OpaqueControlActionProcPtr)))
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • ControlRecord                                                                                     
; ——————————————————————————————————————————————————————————————————————————————————————————————————————

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
(defrecord (ControlRecord :handle)
   (nextControl (:pointer :OpaqueControlRef))   ;  in Carbon use embedding heirarchy functions
   (contrlOwner (:pointer :OpaqueWindowPtr))    ;  in Carbon use GetControlOwner or EmbedControl
   (contrlRect :Rect)                           ;  in Carbon use Get/SetControlBounds
   (contrlVis :UInt8)                           ;  in Carbon use IsControlVisible, SetControlVisibility
   (contrlHilite :UInt8)                        ;  in Carbon use GetControlHilite, HiliteControl
   (contrlValue :SInt16)                        ;  in Carbon use Get/SetControlValue, Get/SetControl32BitValue
   (contrlMin :SInt16)                          ;  in Carbon use Get/SetControlMinimum, Get/SetControl32BitMinimum
   (contrlMax :SInt16)                          ;  in Carbon use Get/SetControlMaximum, Get/SetControl32BitMaximum
   (contrlDefProc :Handle)                      ;  not supported in Carbon
   (contrlData :Handle)                         ;  in Carbon use Get/SetControlDataHandle
   (contrlAction (:pointer :OpaqueControlActionProcPtr));  in Carbon use Get/SetControlAction
   (contrlRfCon :SInt32)                        ;  in Carbon use Get/SetControlReference
   (contrlTitle (:string 255))                  ;  in Carbon use Get/SetControlTitle
)
 |#

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */

; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;  • Control ActionProcPtr : Epilogue                                                                   
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
; 
;  *  NewControlActionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlActionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlActionProcPtr)
() )
; 
;  *  DisposeControlActionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlActionUPP" 
   ((userUPP (:pointer :OpaqueControlActionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeControlActionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlActionUPP" 
   ((theControl (:pointer :OpaqueControlRef))
    (partCode :SInt16)
    (userUPP (:pointer :OpaqueControlActionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • Control Color Table                                                                               
; ——————————————————————————————————————————————————————————————————————————————————————————————————————

(defconstant $cFrameColor 0)
(defconstant $cBodyColor 1)
(defconstant $cTextColor 2)
(defconstant $cThumbColor 3)
(defconstant $kNumberCtlCTabEntries 4)
(defrecord (CtlCTab :handle)
   (ccSeed :SInt32)
   (ccRider :SInt16)
   (ctSize :SInt16)
   (ctTable (:array :ColorSpec 4))
)

;type name? (%define-record :CtlCTab (find-record-descriptor ':CtlCTab))

(def-mactype :CCTabPtr (find-mactype '(:pointer :CtlCTab)))

(def-mactype :CCTabHandle (find-mactype '(:handle :CtlCTab)))
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • Auxiliary Control Record                                                                          
; ——————————————————————————————————————————————————————————————————————————————————————————————————————

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
(defrecord (AuxCtlRec :handle)
   (acNext :Handle)                             ;  not supported in Carbon
   (acOwner (:pointer :OpaqueControlRef))       ;  not supported in Carbon
   (acCTable (:Handle :CtlCTab))                ;  not supported in Carbon
   (acFlags :SInt16)                            ;  not supported in Carbon
   (acReserved :SInt32)                         ;  not supported in Carbon
   (acRefCon :SInt32)                           ;  in Carbon use Get/SetControlProperty if you need more refCons
)

;type name? (def-mactype :AuxCtlRec (find-mactype ':AuxCtlRec))

(def-mactype :AuxCtlPtr (find-mactype '(:pointer :AuxCtlRec)))

(def-mactype :AuxCtlHandle (find-mactype '(:pointer :AuxCtlPtr)))
 |#

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */

; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Variants                                                                  
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :ControlVariant (find-mactype ':SInt16))

(defconstant $kControlNoVariant 0)              ;  No variant
;  Control uses owning windows font to display text

(defconstant $kControlUsesOwningWindowsFontVariant 8)
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Part Codes                                                                
; ——————————————————————————————————————————————————————————————————————————————————————
;  Basic part codes 

(defconstant $kControlNoPart 0)
(defconstant $kControlIndicatorPart #x81)
(defconstant $kControlDisabledPart #xFE)
(defconstant $kControlInactivePart #xFF)
;  Use this constant in Get/SetControlData when the data referred to is not         
;  specific to a part, but rather the entire control, e.g. the list handle of a     
;  list box control.                                                                

(defconstant $kControlEntireControl 0)
;   Meta-Parts                                                                          
;                                                                                       
;   If you haven't guessed from looking at other toolbox headers. We like the word      
;   'meta'. It's cool. So here's one more for you. A meta-part is a part used in a call 
;   to the GetControlRegion API. These parts are parts that might be defined by a       
;   control, but should not be returned from calls like TestControl, et al. They define 
;   a region of a control, presently the structure and the content region. The content  
;   region is only defined by controls that can embed other controls. It is the area    
;   that embedded content can live.                                                     
;                                                                                       
;   Along with these parts, you can also pass in normal part codes to get the regions   
;   of the parts. Not all controls fully support this at the time this was written.     

(defconstant $kControlStructureMetaPart -1)
(defconstant $kControlContentMetaPart -2)
(defconstant $kControlOpaqueMetaPart -3)        ;  Jaguar or later
;  Panther or later, only used for async window dragging. Default is structure region.

(defconstant $kControlClickableMetaPart -4)
;  focusing part codes 

(defconstant $kControlFocusNoPart 0)            ;  tells control to clear its focus

(defconstant $kControlFocusNextPart -1)         ;  tells control to focus on the next part
;  tells control to focus on the previous part

(defconstant $kControlFocusPrevPart -2)

(def-mactype :ControlFocusPart (find-mactype ':SInt16))
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • Control Collection Tags                                                                           
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   These are standard tags that you will find in the initial data Collection that is passed in the     
;   'param' parameter to the initCntl message, and in the kEventParamInitCollection parameter to the    
;   kEventControlInitialize event (Carbon only).                                                        
;                                                                                                       
;   All tags at ID zero in a control's Collection are reserved for Control Manager use.                 
;   Custom control definitions should use other IDs.                                                    
;                                                                                                       
;   Most of these tags are interpreted when you call CreateCustomControl; the Control Manager will put  
;   the value in the right place before calling the control definition with the initialization message. 
; 
;  *  Discussion:
;  *    Control Collection Tags
;  
; 
;    * Rect - the bounding rectangle.
;    

(defconstant $kControlCollectionTagBounds :|boun|)
; 
;    * SInt32 - the value
;    

(defconstant $kControlCollectionTagValue :|valu|)
; 
;    * SInt32 - the minimum
;    

(defconstant $kControlCollectionTagMinimum :|min |)
; 
;    * SInt32 - the maximum
;    

(defconstant $kControlCollectionTagMaximum :|max |)
; 
;    * SInt32 - the view size
;    

(defconstant $kControlCollectionTagViewSize :|view|)
; 
;    * Boolean - the visible state. Only interpreted on CarbonLib
;    * versions up through 1.5.x and Mac OS X versions 10.0.x. Not
;    * interpreted on CarbonLib 1.6 and later. Not interpreted on Mac OS
;    * 10.1 and later. We recommend you do not use this tag at all.
;    

(defconstant $kControlCollectionTagVisibility :|visi|)
; 
;    * SInt32 - the refCon
;    

(defconstant $kControlCollectionTagRefCon :|refc|)
; 
;    * arbitrarily sized character array - the title
;    

(defconstant $kControlCollectionTagTitle :|titl|)
; 
;    * bytes as received via CFStringCreateExternalRepresentation
;    

(defconstant $kControlCollectionTagUnicodeTitle :|uttl|)
; 
;    * OSType - the ControlID signature
;    

(defconstant $kControlCollectionTagIDSignature :|idsi|)
; 
;    * SInt32 - the ControlID id
;    

(defconstant $kControlCollectionTagIDID :|idid|)
; 
;    * UInt32 - the command
;    

(defconstant $kControlCollectionTagCommand :|cmd |)
; 
;    * SInt16 - the variant
;    

(defconstant $kControlCollectionTagVarCode :|varc|)
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • Control Image Content                                                                             
; ——————————————————————————————————————————————————————————————————————————————————————————————————————

(defconstant $kControlContentTextOnly 0)
(defconstant $kControlNoContent 0)
(defconstant $kControlContentIconSuiteRes 1)
(defconstant $kControlContentCIconRes 2)
(defconstant $kControlContentPictRes 3)
(defconstant $kControlContentICONRes 4)
(defconstant $kControlContentIconSuiteHandle #x81)
(defconstant $kControlContentCIconHandle #x82)
(defconstant $kControlContentPictHandle #x83)
(defconstant $kControlContentIconRef #x84)
(defconstant $kControlContentICON #x85)
(defconstant $kControlContentCGImageRef #x86)

(def-mactype :ControlContentType (find-mactype ':SInt16))
(defrecord ControlButtonContentInfo
   (contentType :SInt16)
   (:variant
   (
   (resID :SInt16)
   )
   (
   (cIconHandle (:Handle :CIcon))
   )
   (
   (iconSuite :Handle)
   )
   (
   (iconRef (:pointer :OpaqueIconRef))
   )
   (
   (picture (:Handle :Picture))
   )
   (
   (ICONHandle :Handle)
   )
   (
   (imageRef (:pointer :CGImage))
   )
   )
)

;type name? (%define-record :ControlButtonContentInfo (find-record-descriptor ':ControlButtonContentInfo))

(def-mactype :ControlButtonContentInfoPtr (find-mactype '(:pointer :ControlButtonContentInfo)))

(%define-record :ControlImageContentInfo (find-record-descriptor ':ControlButtonContentInfo))

(def-mactype :ControlImageContentInfoPtr (find-mactype '(:pointer :ControlButtonContentInfo)))
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • Control Key Script Behavior                                                                       
; ——————————————————————————————————————————————————————————————————————————————————————————————————————

(defconstant $kControlKeyScriptBehaviorAllowAnyScript :|any |);  leaves the current keyboard alone and allows user to change the keyboard.

(defconstant $kControlKeyScriptBehaviorPrefersRoman :|prmn|);  switches the keyboard to roman, but allows them to change it as desired.

(defconstant $kControlKeyScriptBehaviorRequiresRoman :|rrmn|);  switches the keyboard to roman and prevents the user from changing it.


(def-mactype :ControlKeyScriptBehavior (find-mactype ':UInt32))
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • Control Font Style                                                                                
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;     SPECIAL FONT USAGE NOTES: You can specify the font to use for many control types.
;     The constants below are meta-font numbers which you can use to set a particular
;     control's font usage. There are essentially two modes you can use: 1) default,
;     which is essentially the same as it always has been, i.e. it uses the system font, unless
;     directed to use the window font via a control variant. 2) you can specify to use
;     the big or small system font in a generic manner. The Big system font is the font
;     used in menus, etc. Chicago has filled that role for some time now. Small system
;     font is currently Geneva 10. The meta-font number implies the size and style.
; 
;     NOTE:       Not all font attributes are used by all controls. Most, in fact, ignore
;                 the fore and back color (Static Text is the only one that does, for
;                 backwards compatibility). Also size, face, and addFontSize are ignored
;                 when using the meta-font numbering.
; 
;  Meta-font numbering - see note above 

(defconstant $kControlFontBigSystemFont -1)     ;  force to big system font

(defconstant $kControlFontSmallSystemFont -2)   ;  force to small system font

(defconstant $kControlFontSmallBoldSystemFont -3);  force to small bold system font

(defconstant $kControlFontViewSystemFont -4)    ;  force to views system font (DataBrowser control only)
;  force to mini system font

(defconstant $kControlFontMiniSystemFont -5)
;  Add these masks together to set the flags field of a ControlFontStyleRec 
;  They specify which fields to apply to the text. It is important to make  
;  sure that you specify only the fields that you wish to set.              

(defconstant $kControlUseFontMask 1)
(defconstant $kControlUseFaceMask 2)
(defconstant $kControlUseSizeMask 4)
(defconstant $kControlUseForeColorMask 8)
(defconstant $kControlUseBackColorMask 16)
(defconstant $kControlUseModeMask 32)
(defconstant $kControlUseJustMask 64)
(defconstant $kControlUseAllMask #xFF)
(defconstant $kControlAddFontSizeMask #x100)
;  AddToMetaFont indicates that we want to start with a standard system     
;  font, but then we'd like to add the other attributes. Normally, the meta 
;  font ignores all other flags                                             

(defconstant $kControlAddToMetaFontMask #x200)  ;  Available in Appearance 1.1 or later

;  UseThemeFontID indicates that the font field of the ControlFontStyleRec  
;  should be interpreted as a ThemeFontID (see Appearance.h). In all other  
;  ways, specifying a ThemeFontID is just like using one of the control     
;  meta-fonts IDs. kControlUseThemeFontIDMask and kControlUseFontMask are   
;  mutually exclusive; you can only specify one of them. If you specify     
;  both of them, the behavior is undefined.                                 

(defconstant $kControlUseThemeFontIDMask #x80)  ;  Available in Mac OS X or later

(defrecord ControlFontStyleRec
   (flags :SInt16)
   (font :SInt16)
   (size :SInt16)
   (style :SInt16)
   (mode :SInt16)
   (just :SInt16)
   (foreColor :RGBColor)
   (backColor :RGBColor)
)

;type name? (%define-record :ControlFontStyleRec (find-record-descriptor ':ControlFontStyleRec))

(def-mactype :ControlFontStylePtr (find-mactype '(:pointer :ControlFontStyleRec)))
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • Click Activation Results                                                                          
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   These are for use with GetControlClickActivation. The enumerated values should be pretty            
;   self-explanatory, but just in case:                                                                 
;   • Activate/DoNotActivate indicates whether or not to change the owning window's z-ordering before   
;       processing the click. If activation is requested, you may also want to immediately redraw the   
;       newly exposed portion of the window.                                                            
;   • Ignore/Handle Click indicates whether or not to call an appropriate click handling API (like      
;       HandleControlClick) in respose to the event.                                                    

(defconstant $kDoNotActivateAndIgnoreClick 0)   ;  probably never used. here for completeness.

(defconstant $kDoNotActivateAndHandleClick 1)   ;  let the control handle the click while the window is still in the background.

(defconstant $kActivateAndIgnoreClick 2)        ;  control doesn't want to respond directly to the click, but window should still be brought forward.

(defconstant $kActivateAndHandleClick 3)        ;  control wants to respond to the click, but only after the window has been activated.


(def-mactype :ClickActivationResult (find-mactype ':UInt32))
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • Common data tags for Get/SetControlData                                                           
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
; 
;  *  Discussion:
;  *    Get/SetControlData Common Tags
;  

(defconstant $kControlFontStyleTag :|font|)
(defconstant $kControlKeyFilterTag :|fltr|)
; 
;    * Sent with a pointer to a ControlKind record to be filled in.  Only
;    * valid for GetControlData.
;    

(defconstant $kControlKindTag :|kind|)
; 
;    * Sent with a pointer to a ControlSize.  Only valid with explicitly
;    * sizeable controls.  Currently supported by the check box, combo
;    * box, progress bar, indeterminate progress bar, radio button, round
;    * button, scroll bar, slider and the tab.  Check your return value!
;    * As of 10.2.5, the push button and data browser accept this tag.
;    * The data browser only changes the size of its scrollbars. As of
;    * Mac OS X 10.3, chasing arrows, disclosure button, popup button,
;    * scroll view, search field and little arrows control also accept
;    * this tag. Still check your return values!
;    

(defconstant $kControlSizeTag :|size|)
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • Control Feature Bits                                                                              
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
; 
;  *  Discussion:
;  *    Control Feature Bits - Returned by GetControlFeatures
;  

(defconstant $kControlSupportsGhosting 1)
(defconstant $kControlSupportsEmbedding 2)
(defconstant $kControlSupportsFocus 4)
(defconstant $kControlWantsIdle 8)
(defconstant $kControlWantsActivate 16)
(defconstant $kControlHandlesTracking 32)
(defconstant $kControlSupportsDataAccess 64)
(defconstant $kControlHasSpecialBackground #x80)
(defconstant $kControlGetsFocusOnClick #x100)
(defconstant $kControlSupportsCalcBestRect #x200)
(defconstant $kControlSupportsLiveFeedback #x400)
(defconstant $kControlHasRadioBehavior #x800)   ;  Available in Appearance 1.0.1 or later

(defconstant $kControlSupportsDragAndDrop #x1000);  Available in Carbon

(defconstant $kControlAutoToggles #x4000)       ;  Available in Appearance 1.1 or later

(defconstant $kControlSupportsGetRegion #x20000);  Available in Appearance 1.1 or later

(defconstant $kControlSupportsFlattening #x80000);  Available in Carbon

(defconstant $kControlSupportsSetCursor #x100000);  Available in Carbon

(defconstant $kControlSupportsContextualMenus #x200000);  Available in Carbon

(defconstant $kControlSupportsClickActivation #x400000);  Available in Carbon

(defconstant $kControlIdlesWithTimer #x800000)  ;  Available in Carbon - this bit indicates that the control animates automatically
; 
;    * Reported by controls that expect clients to use an action proc
;    * that increments its value when the up button is pressed and
;    * decrement its value when the down button is pressed. (Most
;    * controls, such as scroll bars and sliders, expect the opposite).
;    * This allows the Control Manager to calculate the proper amount of
;    * sleep time during a tracking loop. This is only respected in Mac
;    * OS X 10.3 and later.
;    

(defconstant $kControlInvertsUpDownValueMeaning #x1000000)
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
;   • Control Messages                                                                                  
; ——————————————————————————————————————————————————————————————————————————————————————————————————————

(defconstant $drawCntl 0)
(defconstant $testCntl 1)
(defconstant $calcCRgns 2)
(defconstant $initCntl 3)                       ;  Param is Collection, result is OSStatus

(defconstant $dispCntl 4)
(defconstant $posCntl 5)
(defconstant $thumbCntl 6)
(defconstant $dragCntl 7)
(defconstant $autoTrack 8)
(defconstant $calcCntlRgn 10)
(defconstant $calcThumbRgn 11)
(defconstant $drawThumbOutline 12)
(defconstant $kControlMsgDrawGhost 13)
(defconstant $kControlMsgCalcBestRect 14)       ;  Calculate best fitting rectangle for control

(defconstant $kControlMsgHandleTracking 15)
(defconstant $kControlMsgFocus 16)              ;  param indicates action.

(defconstant $kControlMsgKeyDown 17)
(defconstant $kControlMsgIdle 18)
(defconstant $kControlMsgGetFeatures 19)
(defconstant $kControlMsgSetData 20)
(defconstant $kControlMsgGetData 21)
(defconstant $kControlMsgActivate 22)
(defconstant $kControlMsgSetUpBackground 23)
(defconstant $kControlMsgCalcValueFromPos 26)
(defconstant $kControlMsgTestNewMsgSupport 27)  ;  See if this control supports new messaging

(defconstant $kControlMsgSubValueChanged 25)    ;  Available in Appearance 1.0.1 or later

(defconstant $kControlMsgSubControlAdded 28)    ;  Available in Appearance 1.0.1 or later

(defconstant $kControlMsgSubControlRemoved 29)  ;  Available in Appearance 1.0.1 or later

(defconstant $kControlMsgApplyTextColor 30)     ;  Available in Appearance 1.1 or later

(defconstant $kControlMsgGetRegion 31)          ;  Available in Appearance 1.1 or later

(defconstant $kControlMsgFlatten 32)            ;  Available in Carbon. Param is Collection.

(defconstant $kControlMsgSetCursor 33)          ;  Available in Carbon. Param is ControlSetCursorRec

(defconstant $kControlMsgDragEnter 38)          ;  Available in Carbon. Param is DragRef, result is boolean indicating acceptibility of drag.

(defconstant $kControlMsgDragLeave 39)          ;  Available in Carbon. As above.

(defconstant $kControlMsgDragWithin 40)         ;  Available in Carbon. As above.

(defconstant $kControlMsgDragReceive 41)        ;  Available in Carbon. Param is DragRef, result is OSStatus indicating success/failure.

(defconstant $kControlMsgDisplayDebugInfo 46)   ;  Available in Carbon on X.

(defconstant $kControlMsgContextualMenuClick 47);  Available in Carbon. Param is ControlContextualMenuClickRec

(defconstant $kControlMsgGetClickActivation 48) ;  Available in Carbon. Param is ControlClickActivationRec


(def-mactype :ControlDefProcMessage (find-mactype ':SInt16))
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Sizes                                                                     
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  Discussion:
;  *    ControlSize values to be used in conjunction with SetControlData
;  *    and the kControlSizeTag.
;  
; 
;    * Use the control's default drawing variant.  This does not apply to
;    * Scroll Bars, for which Normal is Large.
;    

(defconstant $kControlSizeNormal 0)
; 
;    * Use the control's small drawing variant.  Currently supported by
;    * the Check Box, Combo Box, Radio Button, Scroll Bar, Slider and Tab
;    * controls.
;    

(defconstant $kControlSizeSmall 1)
; 
;    * Use the control's small drawing variant.  Currently supported by
;    * the Indeterminate Progress Bar, Progress Bar and Round Button
;    * controls.
;    

(defconstant $kControlSizeLarge 2)
; 
;    * Use the control's miniature drawing variant. This does not apply
;    * to many of the controls, since this is a brand new control size.
;    

(defconstant $kControlSizeMini 3)
; 
;    * Control drawing variant determined by the control's bounds.  This
;    * ControlSize is currently only available with Scroll Bars and Popup
;    * Buttons to support their legacy behavior of drawing differently
;    * within different bounds. It is preferred to explicitly use one of
;    * the available control sizes.
;    

(defconstant $kControlSizeAuto #xFFFF)

(def-mactype :ControlSize (find-mactype ':UInt16))
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Constants for drawCntl message (passed in param)                                  
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kDrawControlEntireControl 0)
(defconstant $kDrawControlIndicatorOnly #x81)
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Constants for dragCntl message (passed in param)                                  
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kDragControlEntireControl 0)
(defconstant $kDragControlIndicator 1)
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Drag Constraint Structure for thumbCntl message (passed in param)                 
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord IndicatorDragConstraint
   (limitRect :Rect)
   (slopRect :Rect)
   (axis :UInt16)
)

;type name? (%define-record :IndicatorDragConstraint (find-record-descriptor ':IndicatorDragConstraint))

(def-mactype :IndicatorDragConstraintPtr (find-mactype '(:pointer :IndicatorDragConstraint)))
; ——————————————————————————————————————————————————————————————————————————————————————
;   CDEF should return as result of kControlMsgTestNewMsgSupport                        
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kControlSupportsNewMessages :| ok |)
; ——————————————————————————————————————————————————————————————————————————————————————
;   This structure is passed into a CDEF when called with the kControlMsgHandleTracking 
;   message                                                                             
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord ControlTrackingRec
   (startPt :Point)
   (modifiers :UInt16)
   (action (:pointer :OpaqueControlActionProcPtr))
)

;type name? (%define-record :ControlTrackingRec (find-record-descriptor ':ControlTrackingRec))

(def-mactype :ControlTrackingPtr (find-mactype '(:pointer :ControlTrackingRec)))
; ——————————————————————————————————————————————————————————————————————————————————————
;  This structure is passed into a CDEF when called with the kControlMsgKeyDown message 
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord ControlKeyDownRec
   (modifiers :UInt16)
   (keyCode :SInt16)
   (charCode :SInt16)
)

;type name? (%define-record :ControlKeyDownRec (find-record-descriptor ':ControlKeyDownRec))

(def-mactype :ControlKeyDownPtr (find-mactype '(:pointer :ControlKeyDownRec)))
; ——————————————————————————————————————————————————————————————————————————————————————
;  This structure is passed into a CDEF when called with the kControlMsgGetData or      
;  kControlMsgSetData message                                                           
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord ControlDataAccessRec
   (tag :FourCharCode)
   (part :FourCharCode)
   (size :signed-long)
   (dataPtr :pointer)
)

;type name? (%define-record :ControlDataAccessRec (find-record-descriptor ':ControlDataAccessRec))

(def-mactype :ControlDataAccessPtr (find-mactype '(:pointer :ControlDataAccessRec)))
; ——————————————————————————————————————————————————————————————————————————————————————
;  This structure is passed into a CDEF when called with the kControlCalcBestRect msg   
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord ControlCalcSizeRec
   (height :SInt16)
   (width :SInt16)
   (baseLine :SInt16)
)

;type name? (%define-record :ControlCalcSizeRec (find-record-descriptor ':ControlCalcSizeRec))

(def-mactype :ControlCalcSizePtr (find-mactype '(:pointer :ControlCalcSizeRec)))
; ——————————————————————————————————————————————————————————————————————————————————————
;  This structure is passed into a CDEF when called with the kControlMsgSetUpBackground 
;  message is sent                                                                      
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord ControlBackgroundRec
   (depth :SInt16)
   (colorDevice :Boolean)
)

;type name? (%define-record :ControlBackgroundRec (find-record-descriptor ':ControlBackgroundRec))

(def-mactype :ControlBackgroundPtr (find-mactype '(:pointer :ControlBackgroundRec)))
; ——————————————————————————————————————————————————————————————————————————————————————
;  This structure is passed into a CDEF when called with the kControlMsgApplyTextColor  
;  message is sent                                                                      
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord ControlApplyTextColorRec
   (depth :SInt16)
   (colorDevice :Boolean)
   (active :Boolean)
)

;type name? (%define-record :ControlApplyTextColorRec (find-record-descriptor ':ControlApplyTextColorRec))

(def-mactype :ControlApplyTextColorPtr (find-mactype '(:pointer :ControlApplyTextColorRec)))
; ——————————————————————————————————————————————————————————————————————————————————————
;  This structure is passed into a CDEF when called with the kControlMsgGetRegion       
;  message is sent                                                                      
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord ControlGetRegionRec
   (region (:pointer :OpaqueRgnHandle))
   (part :SInt16)
)

;type name? (%define-record :ControlGetRegionRec (find-record-descriptor ':ControlGetRegionRec))

(def-mactype :ControlGetRegionPtr (find-mactype '(:pointer :ControlGetRegionRec)))
; ——————————————————————————————————————————————————————————————————————————————————————
;  This structure is passed into a CDEF when the kControlMsgSetCursor message is sent   
;  Only sent on Carbon                                                                  
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord ControlSetCursorRec
   (localPoint :Point)
   (modifiers :UInt16)
   (cursorWasSet :Boolean)                      ;  your CDEF must set this to true if you set the cursor, or false otherwise
)

;type name? (%define-record :ControlSetCursorRec (find-record-descriptor ':ControlSetCursorRec))

(def-mactype :ControlSetCursorPtr (find-mactype '(:pointer :ControlSetCursorRec)))
; ——————————————————————————————————————————————————————————————————————————————————————
;  This structure is passed into a CDEF when the kControlMsgContextualMenuClick message 
;  is sent                                                                              
;  Only sent on Carbon                                                                  
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord ControlContextualMenuClickRec
   (localPoint :Point)
   (menuDisplayed :Boolean)                     ;  your CDEF must set this to true if you displayed a menu, or false otherwise
)

;type name? (%define-record :ControlContextualMenuClickRec (find-record-descriptor ':ControlContextualMenuClickRec))

(def-mactype :ControlContextualMenuClickPtr (find-mactype '(:pointer :ControlContextualMenuClickRec)))
; ——————————————————————————————————————————————————————————————————————————————————————
;  This structure is passed into a CDEF when the kControlMsgGetClickActivation message  
;  is sent                                                                              
;  Only sent on Carbon                                                                  
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord ControlClickActivationRec
   (localPoint :Point)
   (modifiers :UInt16)
   (result :UInt32)                             ;  your CDEF must pass the desired result back
)

;type name? (%define-record :ControlClickActivationRec (find-record-descriptor ':ControlClickActivationRec))

(def-mactype :ControlClickActivationPtr (find-mactype '(:pointer :ControlClickActivationRec)))
; ——————————————————————————————————————————————————————————————————————————————————————
;   • ‘CDEF’ entrypoint                                                                 
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :ControlDefProcPtr (find-mactype ':pointer)); (SInt16 varCode , ControlRef theControl , ControlDefProcMessage message , SInt32 param)

(def-mactype :ControlDefUPP (find-mactype '(:pointer :OpaqueControlDefProcPtr)))
; 
;  *  NewControlDefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlDefUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlDefProcPtr)
() )
; 
;  *  DisposeControlDefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlDefUPP" 
   ((userUPP (:pointer :OpaqueControlDefProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeControlDefUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlDefUPP" 
   ((varCode :SInt16)
    (theControl (:pointer :OpaqueControlRef))
    (message :SInt16)
    (param :SInt32)
    (userUPP (:pointer :OpaqueControlDefProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   Control Key Filter                                                                  
; ——————————————————————————————————————————————————————————————————————————————————————
;  Certain controls can have a keyfilter attached to them.                              
;  Definition of a key filter for intercepting and possibly changing keystrokes         
;  which are destined for a control.                                                    
;  Key Filter Result Codes                                                          
;  The filter proc should return one of the two constants below. If                 
;  kKeyFilterBlockKey is returned, the key is blocked and never makes it to the     
;  control. If kKeyFilterPassKey is returned, the control receives the keystroke.   

(defconstant $kControlKeyFilterBlockKey 0)
(defconstant $kControlKeyFilterPassKey 1)

(def-mactype :ControlKeyFilterResult (find-mactype ':SInt16))

(def-mactype :ControlKeyFilterProcPtr (find-mactype ':pointer)); (ControlRef theControl , SInt16 * keyCode , SInt16 * charCode , EventModifiers * modifiers)

(def-mactype :ControlKeyFilterUPP (find-mactype '(:pointer :OpaqueControlKeyFilterProcPtr)))
; 
;  *  NewControlKeyFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlKeyFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlKeyFilterProcPtr)
() )
; 
;  *  DisposeControlKeyFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlKeyFilterUPP" 
   ((userUPP (:pointer :OpaqueControlKeyFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeControlKeyFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlKeyFilterUPP" 
   ((theControl (:pointer :OpaqueControlRef))
    (keyCode (:pointer :SInt16))
    (charCode (:pointer :SInt16))
    (modifiers (:pointer :EVENTMODIFIERS))
    (userUPP (:pointer :OpaqueControlKeyFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • DragGrayRgn Constatns                                                             
;                                                                                       
;    For DragGrayRgnUPP used in TrackControl()                                          
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $noConstraint 0)
(defconstant $hAxisOnly 1)
(defconstant $vAxisOnly 2)
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Creation/Deletion/Persistence                                             
; ——————————————————————————————————————————————————————————————————————————————————————
;   CreateCustomControl is only available as part of Carbon                             

(defconstant $kControlDefProcPtr 0)             ;  raw proc-ptr based access

(defconstant $kControlDefObjectClass 1)         ;  event-based definition (Mac OS X only)


(def-mactype :ControlDefType (find-mactype ':UInt32))
(defrecord ControlDefSpec
   (defType :UInt32)
   (:variant
   (
   (defProc (:pointer :OpaqueControlDefProcPtr))
   )
   (
   (classRef :pointer)
   )
   )
)

;type name? (%define-record :ControlDefSpec (find-record-descriptor ':ControlDefSpec))
; 
;  *  CreateCustomControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateCustomControl" 
   ((owningWindow (:pointer :OpaqueWindowPtr))
    (contBounds (:pointer :Rect))
    (def (:pointer :ControlDefSpec))
    (initData (:pointer :OpaqueCollection))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NewControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewControl" 
   ((owningWindow (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (controlTitle (:pointer :STR255))
    (initiallyVisible :Boolean)
    (initialValue :SInt16)
    (minimumValue :SInt16)
    (maximumValue :SInt16)
    (procID :SInt16)
    (controlReference :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlRef)
() )
; 
;  *  GetNewControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetNewControl" 
   ((resourceID :SInt16)
    (owningWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlRef)
() )
; 
;  *  DisposeControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposeControl" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  KillControls()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_KillControls" 
   ((theWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FlattenControl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  UnflattenControl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Definition Registration                                                   
; ——————————————————————————————————————————————————————————————————————————————————————

(def-mactype :ControlCNTLToCollectionProcPtr (find-mactype ':pointer)); (const Rect * bounds , SInt16 value , Boolean visible , SInt16 max , SInt16 min , SInt16 procID , SInt32 refCon , ConstStr255Param title , Collection collection)

(def-mactype :ControlCNTLToCollectionUPP (find-mactype '(:pointer :OpaqueControlCNTLToCollectionProcPtr)))
; 
;  *  NewControlCNTLToCollectionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlCNTLToCollectionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlCNTLToCollectionProcPtr)
() )
; 
;  *  DisposeControlCNTLToCollectionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlCNTLToCollectionUPP" 
   ((userUPP (:pointer :OpaqueControlCNTLToCollectionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeControlCNTLToCollectionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlCNTLToCollectionUPP" 
   ((bounds (:pointer :Rect))
    (value :SInt16)
    (visible :Boolean)
    (max :SInt16)
    (min :SInt16)
    (procID :SInt16)
    (refCon :SInt32)
    (title (:pointer :STR255))
    (collection (:pointer :OpaqueCollection))
    (userUPP (:pointer :OpaqueControlCNTLToCollectionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RegisterControlDefinition()
;  *  
;  *  Summary:
;  *    Associates or dissociates a control definition with a virtual
;  *    CDEF resource ID.
;  *  
;  *  Discussion:
;  *    In GetNewControl or NewControl on Carbon, the Control Manager
;  *    needs to know how to map the procID to a ControlDefSpec. With
;  *    RegisterControlDefinition, your application can inform the
;  *    Control Manager which ControlDefSpec to call when it sees a
;  *    request to use a 'CDEF' of a particular resource ID. Since custom
;  *    control definitions receive their initialization data in a
;  *    Collection passed in the 'param' parameter, you must also provide
;  *    a procedure to convert the bounds, min, max, and other parameters
;  *    to NewControl into a Collection. If you don't provide a
;  *    conversion proc, your control will receive an empty collection
;  *    when it is sent the initialization message. If you want the
;  *    value, min, visibility, etc. to be given to the control, you must
;  *    add the appropriate tagged data to the collection. See the
;  *    Control Collection Tags above. If you want to unregister a
;  *    ControlDefSpec that you have already registered, call
;  *    RegisterControlDefinition with the same CDEF resource ID, but
;  *    pass NULL for the inControlDef parameter. In this situation,
;  *    inConversionProc is effectively ignored.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inCDEFResID:
;  *      The virtual CDEF resource ID to which you'd like to associate
;  *      or dissociate the control definition.
;  *    
;  *    inControlDef:
;  *      A pointer to a ControlDefSpec which represents the control
;  *      definition you want to register, or NULL if you are attempting
;  *      to unregister a control definition.
;  *    
;  *    inConversionProc:
;  *      The conversion proc which will translate the NewControl
;  *      parameters into a Collection.
;  *  
;  *  Result:
;  *    An OSStatus code indicating success or failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RegisterControlDefinition" 
   ((inCDEFResID :SInt16)
    (inControlDef (:pointer :ControlDefSpec))
    (inConversionProc (:pointer :OpaqueControlCNTLToCollectionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Visible State                                                             
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  HiliteControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HiliteControl" 
   ((theControl (:pointer :OpaqueControlRef))
    (hiliteState :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ShowControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ShowControl" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HideControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HideControl" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  following state routines available only with Appearance 1.0 and later
; 
;  *  IsControlActive()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_IsControlActive" 
   ((inControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  IsControlVisible()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_IsControlVisible" 
   ((inControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  ActivateControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_ActivateControl" 
   ((inControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DeactivateControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DeactivateControl" 
   ((inControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetControlVisibility()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetControlVisibility" 
   ((inControl (:pointer :OpaqueControlRef))
    (inIsVisible :Boolean)
    (inDoDraw :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  following state routines available only on Mac OS X and later
; 
;  *  IsControlEnabled()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsControlEnabled" 
   ((inControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  EnableControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_EnableControl" 
   ((inControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DisableControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisableControl" 
   ((inControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Imaging                                                                   
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  DrawControls()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DrawControls" 
   ((theWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  Draw1Control()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Draw1Control" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; #define DrawOneControl(theControl) Draw1Control(theControl)
; 
;  *  UpdateControls()
;  *  
;  *  Summary:
;  *    Redraws the controls that intersect a specified region in a
;  *    window.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose controls to redraw.
;  *    
;  *    inUpdateRegion:
;  *      The region (in local coordinates) describing which controls to
;  *      redraw. In Mac OS 10.1 and later, and in CarbonLib 1.5 and
;  *      later, you may pass NULL for this parameter to redraw the
;  *      controls intersecting the visible region of the window.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_UpdateControls" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inUpdateRegion (:pointer :OpaqueRgnHandle));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  following imaging routines available only with Appearance 1.0 and later
; 
;  *  GetBestControlRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetBestControlRect" 
   ((inControl (:pointer :OpaqueControlRef))
    (outRect (:pointer :Rect))
    (outBaseLineOffset (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetControlFontStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetControlFontStyle" 
   ((inControl (:pointer :OpaqueControlRef))
    (inStyle (:pointer :ControlFontStyleRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DrawControlInCurrentPort()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DrawControlInCurrentPort" 
   ((inControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetUpControlBackground()
;  *  
;  *  Summary:
;  *    Applies the proper background color for the given control to the
;  *    current port.
;  *  
;  *  Discussion:
;  *    An embedding-savvy control which erases before drawing must
;  *    ensure that its background color properly matches the body color
;  *    of any parent controls on top of which it draws. This routine
;  *    asks the Control Manager to determine and apply the proper
;  *    background color to the current port. If a ControlColorProc has
;  *    been provided for the given control, the proc will be called to
;  *    set up the background color. If no proc exists, or if the proc
;  *    returns a value other than noErr, the Control Manager ascends the
;  *    parent chain for the given control looking for a control which
;  *    has a special background (see the kControlHasSpecialBackground
;  *    feature bit). The first such parent is asked to set up the
;  *    background color (see the kControlMsgSetUpBackground message). If
;  *    no such parent exists, the Control Manager applies any ThemeBrush
;  *    which has been associated with the owning window (see
;  *    SetThemeWindowBackground). Available in Appearance 1.0 (Mac OS
;  *    8), CarbonLib 1.0, Mac OS X, and later.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The ControlRef that wants to erase.
;  *    
;  *    inDepth:
;  *      A short integer indicating the color depth of the device onto
;  *      which drawing will take place.
;  *    
;  *    inIsColorDevice:
;  *      A Boolean indicating whether the draw device is a color device.
;  *  
;  *  Result:
;  *    An OSStatus code indicating success or failure. The most likely
;  *    error is a controlHandleInvalidErr, resulting from a bad
;  *    ControlRef. Any non-noErr result indicates that the color set up
;  *    failed, and that the caller should probably give up its attempt
;  *    to draw.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetUpControlBackground" 
   ((inControl (:pointer :OpaqueControlRef))
    (inDepth :SInt16)
    (inIsColorDevice :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetUpControlTextColor()
;  *  
;  *  Summary:
;  *    Applies the proper text color for the given control to the
;  *    current port.
;  *  
;  *  Discussion:
;  *    An embedding-savvy control which draws text must ensure that its
;  *    text color properly contrasts the background on which it draws.
;  *    This routine asks the Control Manager to determine and apply the
;  *    proper text color to the current port. If a ControlColorProc has
;  *    been provided for the given control, the proc will be called to
;  *    set up the text color. If no proc exists, or if the proc returns
;  *    a value other than noErr, the Control Manager ascends the parent
;  *    chain for the given control looking for a control which has a
;  *    special background (see the kControlHasSpecialBackground feature
;  *    bit). The first such parent is asked to set up the text color
;  *    (see the kControlMsgApplyTextColor message). If no such parent
;  *    exists, the Control Manager chooses a text color which contrasts
;  *    any ThemeBrush which has been associated with the owning window
;  *    (see SetThemeWindowBackground). Available in Appearance 1.1 (Mac
;  *    OS 8.5), CarbonLib 1.0, Mac OS X, and later.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The ControlRef that wants to draw text.
;  *    
;  *    inDepth:
;  *      A short integer indicating the color depth of the device onto
;  *      which drawing will take place.
;  *    
;  *    inIsColorDevice:
;  *      A Boolean indicating whether the draw device is a color device.
;  *  
;  *  Result:
;  *    An OSStatus code indicating success or failure. The most likely
;  *    error is a controlHandleInvalidErr, resulting from a bad
;  *    ControlRef. Any non-noErr result indicates that the color set up
;  *    failed, and that the caller should probably give up its attempt
;  *    to draw.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_SetUpControlTextColor" 
   ((inControl (:pointer :OpaqueControlRef))
    (inDepth :SInt16)
    (inIsColorDevice :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ControlColorProcPtr
;  *  
;  *  Discussion:
;  *    Callback allowing clients to specify/override the background
;  *    color and text color that a Control will use during drawing. Your
;  *    procedure should make the color changes to the current port. See
;  *    SetControlColorProc, SetUpControlBackground, and
;  *    SetUpControlTextColor for more information. Available on Mac OS
;  *    8.5, CarbonLib 1.1, Mac OS X, and later.
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      A reference to the Control for whom your proc is setting up
;  *      colors.
;  *    
;  *    inMessage:
;  *      A ControlDefProcMessage indicating what sort of color your
;  *      procedure should set up. It will be either
;  *      kControlMsgApplyTextColor or kControlMsgSetUpBackground.
;  *      kControlMsgApplyTextColor is a request to set up the
;  *      appropriate text color (by setting the current port's
;  *      foreground color, pen information, etc.).
;  *      kControlMsgSetUpBackground is a request to set up the
;  *      appropriate background color (the current port's background
;  *      color, pattern, etc.).
;  *    
;  *    inDrawDepth:
;  *      A short integer indicating the bit depth of the device into
;  *      which the Control is drawing. The bit depth is typically passed
;  *      in as a result of someone someone trying to draw properly
;  *      across multiple monitors with different bit depths. If your
;  *      procedure wants to handle proper color set up based on bit
;  *      depth, it should use this parameter to help decide what color
;  *      to apply.
;  *    
;  *    inDrawInColor:
;  *      A Boolean indicating whether or not the device that the Control
;  *      is drawing into is a color device. The value is typically
;  *      passed in as a result of someone trying to draw properly across
;  *      multiple monitors which may or may not be color devices. If
;  *      your procedure wants to handle proper color set up for both
;  *      color and grayscale devices, it should use this parameter to
;  *      help decide what color to apply.
;  *  
;  *  Result:
;  *    An OSStatus code indicating success or failure. Returning noErr
;  *    is an indication that your proc completely handled the color set
;  *    up. If you return any other value, the Control Manager will fall
;  *    back to the normal color set up mechanism.
;  

(def-mactype :ControlColorProcPtr (find-mactype ':pointer)); (ControlRef inControl , SInt16 inMessage , SInt16 inDrawDepth , Boolean inDrawInColor)

(def-mactype :ControlColorUPP (find-mactype '(:pointer :OpaqueControlColorProcPtr)))
; 
;  *  NewControlColorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlColorUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlColorProcPtr)
() )
; 
;  *  DisposeControlColorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlColorUPP" 
   ((userUPP (:pointer :OpaqueControlColorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeControlColorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlColorUPP" 
   ((inControl (:pointer :OpaqueControlRef))
    (inMessage :SInt16)
    (inDrawDepth :SInt16)
    (inDrawInColor :Boolean)
    (userUPP (:pointer :OpaqueControlColorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetControlColorProc()
;  *  
;  *  Summary:
;  *    Associates a ControlColorUPP with a given Control, thereby
;  *    allowing you to bypass the embedding hierarchy-based color setup
;  *    of SetUpControlBackground/SetUpControlTextColor and replace it
;  *    with your own.
;  *  
;  *  Discussion:
;  *    Before an embedded Control can erase, it calls
;  *    SetUpControlBackground to have its background color set up by any
;  *    parent controls. Similarly, any Control which draws text calls
;  *    SetUpControlTextColor to have the appropriate text color set up.
;  *    This allows certain controls (such as Tabs and Placards) to offer
;  *    special backgrounds and text colors for any child controls. By
;  *    default, the SetUp routines only move up the Control Manager
;  *    embedding hierarchy looking for a parent which has a special
;  *    background. This is fine in a plain vanilla embedding case, but
;  *    many application frameworks find it troublesome; if there are
;  *    interesting views between two Controls in the embedding
;  *    hierarchy, the framework needs to be in charge of the background
;  *    and text colors, otherwise drawing defects will occur. You can
;  *    only associate a single color proc with a given ControlRef.
;  *    Available on Mac OS 8.5, CarbonLib 1.1, Mac OS X, and later.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The ControlRef with whom the color proc should be associated.
;  *    
;  *    inProc:
;  *      The color proc to associate with the ControlRef. If you pass
;  *      NULL, the ControlRef will be dissociated from any previously
;  *      installed color proc.
;  *  
;  *  Result:
;  *    An OSStatus code indicating success or failure. The most likely
;  *    error is a controlHandleInvalidErr resulting from a bad
;  *    ControlRef.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_SetControlColorProc" 
   ((inControl (:pointer :OpaqueControlRef))
    (inProc (:pointer :OpaqueControlColorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Mousing                                                                   
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;     NOTE ON CONTROL ACTION PROCS
; 
;     When using the TrackControl() call when tracking an indicator, the actionProc parameter
;     (type ControlActionUPP) should be replaced by a parameter of type DragGrayRgnUPP
;     (see Quickdraw.h).
; 
;     If, however, you are using the live feedback variants of scroll bars or sliders, you
;     must pass a ControlActionUPP in when tracking the indicator as well. This functionality
;     is available in Appearance 1.0 or later.
; 
; 
;  *  TrackControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TrackControl" 
   ((theControl (:pointer :OpaqueControlRef))
    (startPoint :Point)
    (actionProc (:pointer :OpaqueControlActionProcPtr));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  DragControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DragControl" 
   ((theControl (:pointer :OpaqueControlRef))
    (startPoint :Point)
    (limitRect (:pointer :Rect))
    (slopRect (:pointer :Rect))
    (axis :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TestControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TestControl" 
   ((theControl (:pointer :OpaqueControlRef))
    (testPoint :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  FindControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FindControl" 
   ((testPoint :Point)
    (theWindow (:pointer :OpaqueWindowPtr))
    (theControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
;  The following mousing routines available only with Appearance 1.0 and later  
;                                                                               
;  HandleControlClick is preferable to TrackControl when running under          
;  Appearance 1.0 as you can pass in modifiers, which some of the new controls  
;  use, such as edit text and list boxes.                                       
;  NOTE: Passing NULL for the outPart parameter of FindControlUnderMouse is only
;        supported in systems later than 10.1.x                                 
; 
;  *  FindControlUnderMouse()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_FindControlUnderMouse" 
   ((inWhere :Point)
    (inWindow (:pointer :OpaqueWindowPtr))
    (outPart (:pointer :ControlPartCode))       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlRef)
() )
; 
;  *  HandleControlClick()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_HandleControlClick" 
   ((inControl (:pointer :OpaqueControlRef))
    (inWhere :Point)
    (inModifiers :UInt16)
    (inAction (:pointer :OpaqueControlActionProcPtr));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
;  Contextual Menu support in the Control Manager is only available on Carbon.  
;  If the control didn't display a contextual menu (possibly because the point  
;  was in a non-interesting part), the menuDisplayed output parameter will be   
;  false. If the control did display a menu, menuDisplayed will be true.        
;  This in on Carbon only                                                       
; 
;  *  HandleControlContextualMenuClick()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 9.0 and later
;  

(deftrap-inline "_HandleControlContextualMenuClick" 
   ((inControl (:pointer :OpaqueControlRef))
    (inWhere :Point)
    (menuDisplayed (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Some complex controls (like Data Browser) require proper sequencing of       
;  window activation and click processing. In some cases, the control might     
;  want the window to be left inactive yet still handle the click, or vice-     
;  versa. The GetControlClickActivation routine lets a control client ask the   
;  control how it wishes to behave for a particular click.                      
;  This in on Carbon only.                                                      
; 
;  *  GetControlClickActivation()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 9.0 and later
;  

(deftrap-inline "_GetControlClickActivation" 
   ((inControl (:pointer :OpaqueControlRef))
    (inWhere :Point)
    (inModifiers :UInt16)
    (outResult (:pointer :CLICKACTIVATIONRESULT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Events (available only with Appearance 1.0 and later)                     
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  HandleControlKey()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_HandleControlKey" 
   ((inControl (:pointer :OpaqueControlRef))
    (inKeyCode :SInt16)
    (inCharCode :SInt16)
    (inModifiers :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  IdleControls()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_IdleControls" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Control Mouse Tracking (available with Carbon)                                     
; ——————————————————————————————————————————————————————————————————————————————————————
;  The HandleControlSetCursor routine requests that a given control set the cursor to   
;  something appropriate based on the mouse location.                                   
;  If the control didn't want to set the cursor (because the point was in a             
;  non-interesting part), the cursorWasSet output parameter will be false. If the       
;  control did set the cursor, cursorWasSet will be true.                               
;  Carbon only.                                                                         
; 
;  *  HandleControlSetCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 9.0 and later
;  

(deftrap-inline "_HandleControlSetCursor" 
   ((control (:pointer :OpaqueControlRef))
    (localPoint :Point)
    (modifiers :UInt16)
    (cursorWasSet (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Positioning                                                               
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  MoveControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MoveControl" 
   ((theControl (:pointer :OpaqueControlRef))
    (h :SInt16)
    (v :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SizeControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SizeControl" 
   ((theControl (:pointer :OpaqueControlRef))
    (w :SInt16)
    (h :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Title                                                                     
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  SetControlTitle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetControlTitle" 
   ((theControl (:pointer :OpaqueControlRef))
    (title (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetControlTitle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetControlTitle" 
   ((theControl (:pointer :OpaqueControlRef))
    (title (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetControlTitleWithCFString()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetControlTitleWithCFString" 
   ((inControl (:pointer :OpaqueControlRef))
    (inString (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CopyControlTitleAsCFString()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CopyControlTitleAsCFString" 
   ((inControl (:pointer :OpaqueControlRef))
    (outString (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Value                                                                     
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  GetControlValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetControlValue" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetControlValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetControlValue" 
   ((theControl (:pointer :OpaqueControlRef))
    (newValue :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetControlMinimum()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetControlMinimum" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetControlMinimum()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetControlMinimum" 
   ((theControl (:pointer :OpaqueControlRef))
    (newMinimum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetControlMaximum()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetControlMaximum" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetControlMaximum()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetControlMaximum" 
   ((theControl (:pointer :OpaqueControlRef))
    (newMaximum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  proportional scrolling/32-bit value support is new with Appearance 1.1
; 
;  *  GetControlViewSize()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_GetControlViewSize" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetControlViewSize()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_SetControlViewSize" 
   ((theControl (:pointer :OpaqueControlRef))
    (newViewSize :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetControl32BitValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_GetControl32BitValue" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetControl32BitValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_SetControl32BitValue" 
   ((theControl (:pointer :OpaqueControlRef))
    (newValue :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetControl32BitMaximum()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_GetControl32BitMaximum" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetControl32BitMaximum()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_SetControl32BitMaximum" 
   ((theControl (:pointer :OpaqueControlRef))
    (newMaximum :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetControl32BitMinimum()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_GetControl32BitMinimum" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetControl32BitMinimum()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_SetControl32BitMinimum" 
   ((theControl (:pointer :OpaqueControlRef))
    (newMinimum :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     IsValidControlHandle will tell you if the handle you pass in belongs to a control
;     the Control Manager knows about. It does not sanity check the data in the control.
; 
; 
;  *  IsValidControlHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_IsValidControlHandle" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Control IDs                                                                        
;  Carbon only.                                                                         
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  ControlID
;  *  
;  *  Summary:
;  *    A unique identifier for a control in a window.
;  
(defrecord ControlID
                                                ; 
;    * A four-character signature. When assigning a control ID to your
;    * own controls, you should typically use your application signature
;    * here, or some other signature with an uppercase character. Apple
;    * reserves signatures that contain only lowercase characters.
;    
   (signature :OSType)
                                                ; 
;    * A integer identifying the control. This value should be unique for
;    * a given control across all controls in the same window with the
;    * same signature.
;    
   (id :SInt32)
)

;type name? (%define-record :ControlID (find-record-descriptor ':ControlID))
; 
;  *  SetControlID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetControlID" 
   ((inControl (:pointer :OpaqueControlRef))
    (inID (:pointer :ControlID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetControlID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetControlID" 
   ((inControl (:pointer :OpaqueControlRef))
    (outID (:pointer :ControlID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetControlByID()
;  *  
;  *  Discussion:
;  *    Find a control in a window by its unique ID. 
;  *    
;  *    HIView Notes: This call is replaced as of Mac OS X 10.3 by
;  *    HIViewFindByID. That call lets you start your search at any point
;  *    in the hierarchy, as the first parameter is a view and not a
;  *    window. Either will work, but the HIView API is preferred.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to search.
;  *    
;  *    inID:
;  *      The ID to search for.
;  *    
;  *    outControl:
;  *      The control that was found, or NULL if no control in the window
;  *      had the ID specified.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetControlByID" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inID (:pointer :ControlID))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Control Command IDs                                                                    
;  Carbon only.                                                                         
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  SetControlCommandID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetControlCommandID" 
   ((inControl (:pointer :OpaqueControlRef))
    (inCommandID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetControlCommandID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetControlCommandID" 
   ((inControl (:pointer :OpaqueControlRef))
    (outCommandID (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Control Identification                                                             
;  Carbon only.                                                                         
; ——————————————————————————————————————————————————————————————————————————————————————
(defrecord ControlKind
   (signature :OSType)
   (kind :OSType)
)

;type name? (%define-record :ControlKind (find-record-descriptor ':ControlKind))
; 
;  *  Discussion:
;  *    Control signature kind
;  
; 
;    * Signature of all system controls.
;    

(defconstant $kControlKindSignatureApple :|appl|)
; 
;  *  GetControlKind()
;  *  
;  *  Summary:
;  *    Returns the kind of the given control.
;  *  
;  *  Discussion:
;  *    GetControlKind allows you to query the kind of any control. This
;  *    function is only available in Mac OS X. 
;  *    
;  *    HIView Note: With the advent of HIView, you can just as easily
;  *    use HIObjectCopyClassID to determine what kind of control you are
;  *    looking at. This is only truly deterministic for
;  *    HIToolbox-supplied controls as of Mac OS X 10.3 or later due to
;  *    the fact that the class IDs underwent naming changes before that
;  *    release.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The ControlRef to find the kind of.
;  *    
;  *    outControlKind:
;  *      On successful exit, this will contain the control signature and
;  *      kind. See ControlDefinitions.h for the kinds of each system
;  *      control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetControlKind" 
   ((inControl (:pointer :OpaqueControlRef))
    (outControlKind (:pointer :ControlKind))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Properties                                                                         
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $kControlPropertyPersistent 1)     ;  whether this property gets saved when flattening the control

; 
;  *  GetControlProperty()
;  *  
;  *  Discussion:
;  *    Obtains a piece of data that has been previously associated with
;  *    a control.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    control:
;  *      A ControlRef to the control whose associated data you wish to
;  *      obtain.
;  *    
;  *    propertyCreator:
;  *      An OSType signature, usually the signature of your application.
;  *      Do not use all lower case signatures, as these are reserved for
;  *      use by Apple.
;  *    
;  *    propertyTag:
;  *      An OSType signature, application-defined, identifying the
;  *      property.
;  *    
;  *    bufferSize:
;  *      A value specifying the size of the data to be retrieved. If the
;  *      size of the data is unknown, use the function
;  *      GetControlPropertySize to get the data’s size. If the size
;  *      specified in the bufferSize parameter does not match the actual
;  *      size of the property, GetControlProperty only retrieves data up
;  *      to the size specified or up to the actual size of the property,
;  *      whichever is smaller, and an error is returned.
;  *    
;  *    actualSize:
;  *      On input, a pointer to an unsigned 32-bit integer. On return,
;  *      this value is set to the actual size of the associated data.
;  *      You may pass null for the actualSize parameter if you are not
;  *      interested in this information.
;  *    
;  *    propertyBuffer:
;  *      On input, a pointer to a buffer. This buffer must be big enough
;  *      to fit bufferSize bytes of data. On return, this buffer
;  *      contains a copy of the data that is associated with the
;  *      specified control.
;  *  
;  *  Result:
;  *    A result code indicating success or failure. Most common return
;  *    values are: noErr, paramErr, controlHandleInvalidErr,
;  *    controlPropertyInvalid and controlPropertyNotFoundErr.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_GetControlProperty" 
   ((control (:pointer :OpaqueControlRef))
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (bufferSize :UInt32)
    (actualSize (:pointer :UInt32))             ;  can be NULL 
    (propertyBuffer :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetControlPropertySize()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_GetControlPropertySize" 
   ((control (:pointer :OpaqueControlRef))
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (size (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetControlProperty()
;  *  
;  *  Discussion:
;  *    Obtains a piece of data that has been previously associated with
;  *    a control.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    control:
;  *      A ControlRef to the control whose associated data you wish to
;  *      obtain.
;  *    
;  *    propertyCreator:
;  *      An OSType signature, usually the signature of your application.
;  *      Do not use all lower case signatures, as these are reserved for
;  *      use by Apple.
;  *    
;  *    propertyTag:
;  *      An OSType signature, application-defined, identifying the
;  *      property.
;  *    
;  *    propertySize:
;  *      A value specifying the size of the data.
;  *    
;  *    propertyData:
;  *      On input, a pointer to data of any type. Pass a pointer to a
;  *      buffer containing the data to be associated; this buffer should
;  *      be at least as large as the value specified in the propertySize
;  *      parameter.
;  *    
;  *    propertyBuffer:
;  *      On input, a pointer to a buffer. This buffer must be big enough
;  *      to fit bufferSize bytes of data. On return, this buffer
;  *      contains a copy of the data that is associated with the
;  *      specified control.
;  *  
;  *  Result:
;  *    A result code indicating success or failure. Most common return
;  *    values are: noErr, paramErr, controlHandleInvalidErr and
;  *    controlPropertyInvalid
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_SetControlProperty" 
   ((control (:pointer :OpaqueControlRef))
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (propertySize :UInt32)
    (propertyData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RemoveControlProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_RemoveControlProperty" 
   ((control (:pointer :OpaqueControlRef))
    (propertyCreator :OSType)
    (propertyTag :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetControlPropertyAttributes()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetControlPropertyAttributes" 
   ((control (:pointer :OpaqueControlRef))
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (attributes (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ChangeControlPropertyAttributes()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ChangeControlPropertyAttributes" 
   ((control (:pointer :OpaqueControlRef))
    (propertyCreator :OSType)
    (propertyTag :OSType)
    (attributesToSet :UInt32)
    (attributesToClear :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Regions (Appearance 1.1 or later)                                         
;                                                                                       
;   See the discussion on meta-parts in this header for more information                
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  GetControlRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 8.5 and later
;  

(deftrap-inline "_GetControlRegion" 
   ((inControl (:pointer :OpaqueControlRef))
    (inPart :SInt16)
    (outRegion (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Variant                                                                   
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  GetControlVariant()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetControlVariant" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Action                                                                    
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  SetControlAction()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetControlAction" 
   ((theControl (:pointer :OpaqueControlRef))
    (actionProc (:pointer :OpaqueControlActionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetControlAction()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetControlAction" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlActionProcPtr)
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;  • Control Accessors                                                                  
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  SetControlReference()
;  *  
;  *  Summary:
;  *    This is somewhat of a legacy API. The Set/GetControlProperty API
;  *    is a better mechanism to associate data with a control.
;  *  
;  *  Discussion:
;  *    When you create a control, you specify an initial reference
;  *    value, either in the control resource or in the refCon parameter
;  *    of the function NewControl. You can use the function
;  *    GetControlReference to obtain the current value. You can use this
;  *    value for any purpose.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theControl:
;  *      A ControlRef to the control whose reference value you wish to
;  *      change.
;  *    
;  *    data:
;  *      The new reference value for the control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetControlReference" 
   ((theControl (:pointer :OpaqueControlRef))
    (data :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetControlReference()
;  *  
;  *  Summary:
;  *    This is somewhat of a legacy API. The Set/GetControlProperty API
;  *    is a better mechanism to associate data with a control.
;  *  
;  *  Discussion:
;  *    When you create a control, you specify an initial reference
;  *    value, either in the control resource or in the refCon parameter
;  *    of the function NewControl. You can use this reference value for
;  *    any purpose, and you can use the function SetControlReference to
;  *    change this value.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theControl:
;  *      A ControlRef to the control whose reference value you wish to
;  *      retrieve.
;  *  
;  *  Result:
;  *    The current reference value for the specified control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetControlReference" 
   ((theControl (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
; 
;  *  GetAuxiliaryControlRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
 |#

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */

; 
;  *  SetControlColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Hierarchy (Appearance 1.0 and later only)                                 
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  SendControlMessage()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SendControlMessage" 
   ((inControl (:pointer :OpaqueControlRef))
    (inMessage :SInt16)
    (inParam :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  DumpControlHierarchy()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_DumpControlHierarchy" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inDumpFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CreateRootControl()
;  *  
;  *  Discussion:
;  *    Creates a new 'root control' for a window. This root is actually
;  *    the content area of a window, and spans all of Quickdraw space.
;  *    
;  *    
;  *    HIView Notes: In a composited window, this routine will return
;  *    errRootAlreadyExists. Technically, you cannot create a root
;  *    control in such a window. Instead you would embed views into the
;  *    content view of the window. GetRootControl will return the
;  *    content view in that situation as well.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window for which to create a root control.
;  *    
;  *    outControl:
;  *      On exit, contains the window's root control. In Mac OS 10.1 and
;  *      CarbonLib 1.5 and later, this parameter may be NULL if you
;  *      don't need the ControlRef.
;  *  
;  *  Result:
;  *    A result code indicating success or failure. errRootAlreadyExists
;  *    is returned if the window already has a root control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_CreateRootControl" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outControl (:pointer :ControlRef))         ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetRootControl()
;  *  
;  *  Discussion:
;  *    Returns the 'root control' for a given window. If no root exists
;  *    for the window, errNoRootControl is returned. This root control
;  *    represents the content area of the window, and spans all of
;  *    Quickdraw space. 
;  *    
;  *    HIView Notes: With the advent of HIView, this API and concept are
;  *    considered deprecated. The root of the window in a composited
;  *    window is actually the structure view, and all views (window
;  *    widgets, content view, etc.) are subviews of that top-level view.
;  *    It can be fetched with HIViewGetRoot. In a composited window,
;  *    calling GetRootControl will return the content view, not the true
;  *    root to maintain compatibility with past usage of GetRootControl.
;  *    We recommend using HIViewFindByID with the kHIViewWindowContentID
;  *    control ID to fetch the content view instead of using this call.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to query.
;  *    
;  *    outControl:
;  *      The root control, on output.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetRootControl" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  EmbedControl()
;  *  
;  *  Discussion:
;  *    Adds a subcontrol to the given parent. 
;  *    
;  *    HIView Note: This is replaced by HIViewAddSubview in Mac OS X
;  *    10.2 and beyond. You can call either function in a composited or
;  *    non-composited window, but the HIView variant is preferred.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The subcontrol being added.
;  *    
;  *    inContainer:
;  *      The control which will receive the new subcontrol.
;  *  
;  *  Result:
;  *    An operating system result code. 
;  *    errNeedsCompositedWindow will be returned when you try to embed
;  *    into the content view in a non-compositing window; you can only
;  *    embed into the content view in compositing windows.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_EmbedControl" 
   ((inControl (:pointer :OpaqueControlRef))
    (inContainer (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AutoEmbedControl()
;  *  
;  *  Discussion:
;  *    Based on the bounds of the given control, embed it in the window
;  *    specified. It basically finds the deepest parent the control
;  *    would fit into and embeds it there. This was invented primarily
;  *    for the Dialog Manager so that hierarchies could be generated
;  *    from the flattened DITL list. 
;  *    
;  *    HIView Note: Do NOT call this API in a composited window, its
;  *    results will be unpredictable as the coordinate systems are very
;  *    different.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The subcontrol being added.
;  *    
;  *    inWindow:
;  *      The window which will receive the new subcontrol.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_AutoEmbedControl" 
   ((inControl (:pointer :OpaqueControlRef))
    (inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetSuperControl()
;  *  
;  *  Discussion:
;  *    Returns the parent control of the given one. 
;  *    
;  *    HIView Note: HIViewGetSuperview is the preferred API as of Mac OS
;  *    X 10.2. Either call will work in a composited or non- composited
;  *    window.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The control to query.
;  *    
;  *    outParent:
;  *      The parent control.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetSuperControl" 
   ((inControl (:pointer :OpaqueControlRef))
    (outParent (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CountSubControls()
;  *  
;  *  Discussion:
;  *    Returns the number of children a given control has. This count
;  *    can then be used for calls to GetIndexedSubControl.
;  *    
;  *    
;  *    HIView Note: As of Mac OS X 10.2, the preferred way to walk the
;  *    control hierarchy is to use HIViewGetFirstSubView followed by
;  *    repeated calls to HIViewGetNextView until NULL is returned.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The control to query.
;  *    
;  *    outNumChildren:
;  *      A pointer to a UInt16 to receive the number of children
;  *      controls.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_CountSubControls" 
   ((inControl (:pointer :OpaqueControlRef))
    (outNumChildren (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetIndexedSubControl()
;  *  
;  *  Discussion:
;  *    Returns the child control at a given index in the list of
;  *    subcontrols for the specified parent. 
;  *    
;  *    HIView Note: As of Mac OS X 10.2, the preferred way to walk the
;  *    control hierarchy is to use HIViewGetFirstSubView followed by
;  *    repeated calls to HIViewGetNextView until NULL is returned.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The parent control to query.
;  *    
;  *    inIndex:
;  *      The index of the subcontrol to fetch.
;  *    
;  *    outSubControl:
;  *      A pointer to a control reference to receive the subcontrol. If
;  *      the index is out of range, the contents of this parameter are
;  *      undefined after the call.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetIndexedSubControl" 
   ((inControl (:pointer :OpaqueControlRef))
    (inIndex :UInt16)
    (outSubControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetControlSupervisor()
;  *  
;  *  Discussion:
;  *    Allow one view to intercept clicks for another. When something
;  *    like FindControl or the like is called on the target, it will
;  *    instead return the supervisor. This is largely deprecated these
;  *    days. 
;  *    
;  *    HIView Note: As of Mac OS X 10.2, you can intercept subview
;  *    clicks by overriding the kEventControlInterceptSubviewClick event
;  *    (see CarbonEvents.h).
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The control to intercept clicks for.
;  *    
;  *    inBoss:
;  *      The new supervisor control (can be NULL).
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetControlSupervisor" 
   ((inControl (:pointer :OpaqueControlRef))
    (inBoss (:pointer :OpaqueControlRef))       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Keyboard Focus (available only with Appearance 1.0 and later)                     
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  GetKeyboardFocus()
;  *  
;  *  Discussion:
;  *    Passes back the currently focused control within the given window.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to get the focus of.
;  *    
;  *    outControl:
;  *      On output, this will contain the ControlRef that is currently
;  *      focused in the given window. If there is no currently focused
;  *      control, outControl will contain NULL.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetKeyboardFocus" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetKeyboardFocus()
;  *  
;  *  Discussion:
;  *    Focuses the given part of the given control in a particular
;  *    window. If another control is currently focused in the window,
;  *    focus will be removed from the other control before focus is
;  *    given to the desired control. SetKeyboardFocus respects the full
;  *    keyboard navigation mode.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window which contains the control you want to focus. If the
;  *      window does not contain the control, an error will be returned.
;  *    
;  *    inControl:
;  *      The control you want to focus.
;  *    
;  *    inPart:
;  *      The part of the control you wish to focus. You may pass
;  *      kControlFocusNoPart to clear the focus in the given control.
;  *      You may pass kControlFocusNextPart or kControlFocusPrevPart to
;  *      move the focus within the given control.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetKeyboardFocus" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inControl (:pointer :OpaqueControlRef))
    (inPart :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AdvanceKeyboardFocus()
;  *  
;  *  Discussion:
;  *    Advances the focus to the next most appropriate control. Unless
;  *    overriden in some fashion (either by overriding certain carbon
;  *    events or using the HIViewSetNextFocus API), the Toolbox will use
;  *    a spacially determinant method of focusing, attempting to focus
;  *    left to right, top to bottom in a window, taking groups of
;  *    controls into account. AdvanceKeyboardFocus does not respect the
;  *    full keyboard navigation mode. It will only advance the focus
;  *    between traditionally focusable controls. If you want to advance
;  *    the focus in a way that respects the full keyboard navigation
;  *    mode, use the HIViewAdvanceFocus API.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to advance the focus in.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_AdvanceKeyboardFocus" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ReverseKeyboardFocus()
;  *  
;  *  Discussion:
;  *    Reverses the focus to the next most appropriate control. Unless
;  *    overriden in some fashion (either by overriding certain carbon
;  *    events or using the HIViewSetNextFocus API), the Toolbox will use
;  *    a spacially determinant method of focusing, attempting to focus
;  *    left to right, top to bottom in a window, taking groups of
;  *    controls into account. ReverseKeyboardFocus does not respect the
;  *    full keyboard navigation mode. It will only reverse the focus
;  *    between traditionally focusable controls. If you want to reverse
;  *    the focus in a way that respects the full keyboard navigation
;  *    mode, use the HIViewAdvanceFocus API.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window to reverse the focus in.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_ReverseKeyboardFocus" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ClearKeyboardFocus()
;  *  
;  *  Discussion:
;  *    Clears focus from the currently focused control in a given
;  *    window. The window will be left such that no control is focused
;  *    within it.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window that you want to clear the focus in.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_ClearKeyboardFocus" 
   ((inWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Data (available only with Appearance 1.0 and later)                       
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  GetControlFeatures()
;  *  
;  *  Discussion:
;  *    Returns the set of behaviors, etc. the given view supports. This
;  *    set of features is immutable before Mac OS X 10.3. As of that
;  *    release, the features can be changed with HIViewChangeFeatures.
;  *    That API is the recommended call on Mac OS X 10.3 and later.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The control to query.
;  *    
;  *    outFeatures:
;  *      A pointer to a 32-bit feature bitfield.
;  *  
;  *  Result:
;  *    An operating system error code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetControlFeatures" 
   ((inControl (:pointer :OpaqueControlRef))
    (outFeatures (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetControlData()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetControlData" 
   ((inControl (:pointer :OpaqueControlRef))
    (inPart :SInt16)
    (inTagName :FourCharCode)
    (inSize :signed-long)
    (inData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetControlData()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetControlData" 
   ((inControl (:pointer :OpaqueControlRef))
    (inPart :SInt16)
    (inTagName :FourCharCode)
    (inBufferSize :signed-long)
    (inBuffer :pointer)
    (outActualSize (:pointer :SIZE))            ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetControlDataSize()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetControlDataSize" 
   ((inControl (:pointer :OpaqueControlRef))
    (inPart :SInt16)
    (inTagName :FourCharCode)
    (outMaxSize (:pointer :SIZE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • Control Drag & Drop                                                               
;       Carbon only.                                                                    
; ——————————————————————————————————————————————————————————————————————————————————————
; 
;  *  Discussion:
;  *    DragTrackingMessage values for use with
;  *    HandleControlDragTracking. These are deprecated in favor of the
;  *    drag Carbon Events introduced in Mac OS X 10.2 via HIView.
;  
; 
;    * The drag was previously outside the control and it just now
;    * entered the control.
;    

(defconstant $kDragTrackingEnterControl 2)
; 
;    * The drag was previously inside the control and it is still inside
;    * the control.
;    

(defconstant $kDragTrackingInControl 3)
; 
;    * The drag was previously inside the control and it just now left
;    * the control.
;    

(defconstant $kDragTrackingLeaveControl 4)
; 
;  *  HandleControlDragTracking()
;  *  
;  *  Summary:
;  *    Tells a control to respond visually to a drag.
;  *  
;  *  Discussion:
;  *    Call HandleControlDragTracking when a drag is above a control in
;  *    your window and you want to give that control a chance to draw
;  *    appropriately in response to the drag. Note that in order for a
;  *    control to have any chance of responding to this API, you must
;  *    enable the control's drag and drop support with
;  *    SetControlDragTrackingEnabled. 
;  *    <br>HIView Note: This should not be called in a composited window.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The control the drag is over. Most controls won't track drags
;  *      unless you enable drag tracking on it with
;  *      SetControlDragTrackingEnabled.
;  *    
;  *    inMessage:
;  *      A drag message indicating the state of the drag above the
;  *      control. The meaning of the value you pass in must be relative
;  *      to the control, not the whole window. For when the drag first
;  *      enters the control, you should pass kDragTrackingEnterControl.
;  *      While the drag stays within the control, pass
;  *      kDragTrackingInControl. When the drag leaves the control, pass
;  *      kDragTrackingLeaveControl.
;  *    
;  *    inDrag:
;  *      The drag reference that is over the control.
;  *    
;  *    outLikesDrag:
;  *      On output, this will be a boolean indicating whether the
;  *      control "likes" the drag. A control "likes" the drag if the
;  *      data in the drag ref can be accepted by the control. If the
;  *      control does not like the drag, don't bother calling
;  *      HandleControlDragReceive if the user drops the dragged object
;  *      onto the control.
;  *  
;  *  Result:
;  *    A result code indicating success or failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 9.0 and later
;  

(deftrap-inline "_HandleControlDragTracking" 
   ((inControl (:pointer :OpaqueControlRef))
    (inMessage :SInt16)
    (inDrag (:pointer :OpaqueDragRef))
    (outLikesDrag (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HandleControlDragReceive()
;  *  
;  *  Summary:
;  *    Tells a control to accept the data in drag reference.
;  *  
;  *  Discussion:
;  *    Call HandleControlDragReceive when the user dropped a drag on a
;  *    control in your window. This gives the control the opportunity to
;  *    pull any interesting data out of the drag and insert the data
;  *    into itself. Note that in order for a control to have any chance
;  *    of responding to this API, you must enable the control's drag and
;  *    drop support with SetControlDragTrackingEnabled. 
;  *    <br>HIView Note: This should not be called in a composited window.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The control who should accept the data. Most controls won't
;  *      accept drags unless you enable drag tracking on it with
;  *      SetControlDragTrackingEnabled.
;  *    
;  *    inDrag:
;  *      The drag reference that was dropped on the control.
;  *  
;  *  Result:
;  *    A result code indicating success or failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 9.0 and later
;  

(deftrap-inline "_HandleControlDragReceive" 
   ((inControl (:pointer :OpaqueControlRef))
    (inDrag (:pointer :OpaqueDragRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetControlDragTrackingEnabled()
;  *  
;  *  Summary:
;  *    Tells a control that it should track and receive drags.
;  *  
;  *  Discussion:
;  *    Call SetControlDragTrackingEnabled to turn enable a control's
;  *    support for drag and drop. Controls won't track drags unless you
;  *    first turn on drag and drop support with this API. Some controls
;  *    don't support drag and drop at all; these controls won't track or
;  *    receive drags even if you call this API with true.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The control whose drag tracking enabled state you'd like to set.
;  *    
;  *    inTracks:
;  *      A Boolean indicating whether you want this control to track and
;  *      receive drags.
;  *  
;  *  Result:
;  *    A result code indicating success or failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 9.0 and later
;  

(deftrap-inline "_SetControlDragTrackingEnabled" 
   ((inControl (:pointer :OpaqueControlRef))
    (inTracks :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  IsControlDragTrackingEnabled()
;  *  
;  *  Summary:
;  *    Tells you whether a control's drag track and receive support is
;  *    enabled.
;  *  
;  *  Discussion:
;  *    Call IsControlDragTrackingEnabled to query a whether a control's
;  *    drag and drop support is enabled. Some controls don't support
;  *    drag and drop at all; these controls won't track or receive drags
;  *    even if you call this API and see a true output value.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inControl:
;  *      The control whose drag tracking enabled state you'd like to
;  *      query.
;  *    
;  *    outTracks:
;  *      On output, this will contain a Boolean value whether the
;  *      control's drag and drop support is enabled.
;  *  
;  *  Result:
;  *    A result code indicating success or failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 9.0 and later
;  

(deftrap-inline "_IsControlDragTrackingEnabled" 
   ((inControl (:pointer :OpaqueControlRef))
    (outTracks (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetAutomaticControlDragTrackingEnabledForWindow()
;  *  
;  *  Summary:
;  *    Enables or disables the Control Manager's automatic drag tracking
;  *    for a given window.
;  *  
;  *  Discussion:
;  *    Call SetAutomaticControlDragTrackingEnabledForWindow to turn on
;  *    or off the Control Manager's automatic drag tracking support for
;  *    a given window. By default, your application code is responsible
;  *    for installing drag tracking and receive handlers on a given
;  *    window. The Control Manager, however, has support for
;  *    automatically tracking and receiving drags over controls. The
;  *    Control Manager will detect the control the drag is over and call
;  *    HandleControlDragTracking and HandleControlDragReceive
;  *    appropriately. By default, this automatic support is turned off.
;  *    You can turn on this support by calling
;  *    SetAutomaticControlDragTrackingEnabledForWindow with true. Note
;  *    that earlier versions of system software incorrectly enable this
;  *    support by default; do not rely on this buggy behavior. As of Mac
;  *    OS 10.1.3, Mac OS 9.2, and CarbonLib 1.4, the buggy behavior is
;  *    fixed, and you must call this routine with true to enable
;  *    automatic drag tracking.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window for which you'd like to enable or disable the
;  *      Control Manager's automatic drag tracking support.
;  *    
;  *    inTracks:
;  *      A Boolean value indicating whether you want to enable the
;  *      Control Manager's automatic drag tracking support.
;  *  
;  *  Result:
;  *    A result code indicating success or failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 9.0 and later
;  

(deftrap-inline "_SetAutomaticControlDragTrackingEnabledForWindow" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inTracks :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  IsAutomaticControlDragTrackingEnabledForWindow()
;  *  
;  *  Summary:
;  *    Tells you whether the Control Manager's automatic drag tracking
;  *    is enabled for a given window.
;  *  
;  *  Discussion:
;  *    Call IsAutomaticControlDragTrackingEnabledForWindow to query the
;  *    enabled state of the Control Manager's automatic drag tracking
;  *    support for a given window. See the information on
;  *    SetAutomaticControlDragTrackingEnabledForWindow for more details.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The window whose Control Manager automatic drag tracking enable
;  *      state you'd like to query.
;  *    
;  *    outTracks:
;  *      On output, this will contain a Boolean value whether the
;  *      Control Manager's automatic drag tracking is enabled.
;  *  
;  *  Result:
;  *    A result code indicating success or failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ControlsLib 9.0 and later
;  

(deftrap-inline "_IsAutomaticControlDragTrackingEnabledForWindow" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outTracks (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ——————————————————————————————————————————————————————————————————————————————————————
;   • C Glue                                                                            
; ——————————————————————————————————————————————————————————————————————————————————————

; #if CALL_NOT_IN_CARBON
#| 
; 
;  *  dragcontrol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  newcontrol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  findcontrol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  getcontroltitle()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  setcontroltitle()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  trackcontrol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  testcontrol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
 |#

; #endif  /* CALL_NOT_IN_CARBON */


; #if OLDROUTINENAMES
#|                                              ; ——————————————————————————————————————————————————————————————————————————————————————
;   • OLDROUTINENAMES                                                                   
; ——————————————————————————————————————————————————————————————————————————————————————

(defconstant $useWFont 8)

(defconstant $inThumb #x81)
(defconstant $kNoHiliteControlPart 0)
(defconstant $kInIndicatorControlPart #x81)
(defconstant $kReservedControlPart #xFE)
(defconstant $kControlInactiveControlPart #xFF)
; #define SetCTitle(theControl, title) SetControlTitle(theControl, title)
; #define GetCTitle(theControl, title) GetControlTitle(theControl, title)
; #define UpdtControl(theWindow, updateRgn) UpdateControls(theWindow, updateRgn)
; #define SetCtlValue(theControl, theValue) SetControlValue(theControl, theValue)
; #define GetCtlValue(theControl) GetControlValue(theControl)
; #define SetCtlMin(theControl, minValue) SetControlMinimum(theControl, minValue)
; #define GetCtlMin(theControl) GetControlMinimum(theControl)
; #define SetCtlMax(theControl, maxValue) SetControlMaximum(theControl, maxValue)
; #define GetCtlMax(theControl) GetControlMaximum(theControl)
; #define GetAuxCtl(theControl, acHndl) GetAuxiliaryControlRecord(theControl, acHndl)
; #define SetCRefCon(theControl, data) SetControlReference(theControl, data)
; #define GetCRefCon(theControl) GetControlReference(theControl)
; #define SetCtlAction(theControl, actionProc) SetControlAction(theControl, actionProc)
; #define GetCtlAction(theControl) GetControlAction(theControl)
; #define SetCtlColor(theControl, newColorTable) SetControlColor(theControl, newColorTable)
; #define GetCVariant(theControl) GetControlVariant(theControl)
; #define getctitle(theControl, title) getcontroltitle(theControl, title)
; #define setctitle(theControl, title) setcontroltitle(theControl, title)
 |#

; #endif  /* OLDROUTINENAMES */

;  Getters 
; 
;  *  GetControlBounds()
;  *  
;  *  Discussion:
;  *    Returns the bounds of a control, assumed to be in port
;  *    coordinates. 
;  *    
;  *    HIView Notes: When called in a composited window, this routine
;  *    returns the view's frame, i.e. it is equivalent to calling
;  *    HIViewGetFrame.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    control:
;  *      The control to query
;  *    
;  *    bounds:
;  *      A pointer to a Quickdraw rectangle to be filled in by this call.
;  *  
;  *  Result:
;  *    A pointer to the rectangle passed in bounds.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetControlBounds" 
   ((control (:pointer :OpaqueControlRef))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Rect)
() )
; 
;  *  IsControlHilited()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_IsControlHilited" 
   ((control (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  GetControlHilite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetControlHilite" 
   ((control (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt16
() )
; 
;  *  GetControlOwner()
;  *  
;  *  Discussion:
;  *    Returns the window a control is bound to, or NULL if the control
;  *    is not currently attached to any window.
;  *    
;  *    HIView replacement: HIViewGetWindow (Mac OS X 10.3 or later).
;  *    Either call will work in a composited or non-composited view.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    control:
;  *      The control to query
;  *  
;  *  Result:
;  *    A window reference, or NULL if the control is not attached to a
;  *    window
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetControlOwner" 
   ((control (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  GetControlDataHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetControlDataHandle" 
   ((control (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  GetControlPopupMenuHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetControlPopupMenuHandle" 
   ((control (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMenuRef)
() )
; #define GetControlPopupMenuRef GetControlPopupMenuHandle
; 
;  *  GetControlPopupMenuID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetControlPopupMenuID" 
   ((control (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
;  Setters 
; 
;  *  SetControlDataHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetControlDataHandle" 
   ((control (:pointer :OpaqueControlRef))
    (dataHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetControlBounds()
;  *  
;  *  Discussion:
;  *    Sets the bounds of a control, assumed to be in port coordinates.
;  *    
;  *    
;  *    HIView Notes: When called in a composited window, this routine
;  *    sets the view's frame, i.e. it is equivalent to calling
;  *    HIViewSetFrame. The view will be invalidated as necessary in a
;  *    composited window. HIViewSetFrame is the recommended call in that
;  *    environment.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    control:
;  *      The control to query
;  *    
;  *    bounds:
;  *      A pointer to a Quickdraw rectangle to be used by this call.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetControlBounds" 
   ((control (:pointer :OpaqueControlRef))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetControlPopupMenuHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetControlPopupMenuHandle" 
   ((control (:pointer :OpaqueControlRef))
    (popupMenu (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; #define SetControlPopupMenuRef SetControlPopupMenuHandle
; 
;  *  SetControlPopupMenuID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetControlPopupMenuID" 
   ((control (:pointer :OpaqueControlRef))
    (menuID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __CONTROLS__ */


(provide-interface "Controls")