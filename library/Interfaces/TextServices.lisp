(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:TextServices.h"
; at Sunday July 2,2006 7:25:00 pm.
; 
;      File:       HIToolbox/TextServices.h
;  
;      Contains:   Text Services Manager Interfaces.
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1991-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __TEXTSERVICES__
; #define __TEXTSERVICES__
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
; #ifndef __MENUS__
#| #|
#include <HIToolboxMenus.h>
#endif
|#
 |#
; #ifndef __AEINTERACTION__

(require-interface "HIToolbox/AEInteraction")

; #endif

; #ifndef __CARBONEVENTS__
#| #|
#include <HIToolboxCarbonEvents.h>
#endif
|#
 |#
; #ifndef __ATSUNICODE__
#| #|
#include <QDATSUnicode.h>
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

(defconstant $kTextService :|tsvc|)             ;  component type for the component description 


(defconstant $kTSMVersion #x150)                ;  Version 1.5 of the Text Services Manager 

(defconstant $kTSM15Version #x150)
(defconstant $kTSM20Version #x200)              ;  Version 2.0 as of MacOSX 10.0 

(defconstant $kTSM22Version #x220)              ;  Version 2.2 as of MacOSX 10.3 

;   Interface types for NewTSMDocument
(defrecord InterfaceTypeList
   (contents (:array :OSType 1))
)
(def-mactype :TSMDocumentInterfaceType (find-mactype ':OSType))
; 
;  *  Summary:
;  *    InterfaceTypeList - array of OSTypes passed to NewTSMDocument to
;  *    specify capabilities of the new TSMDocument.
;  *  
;  *  Discussion:
;  *    TSM's Interface types, as of 10.3, are also stored as TSMDocument
;  *    properties, so once a TSMDocument is created, you can easily find
;  *    out what were its InterfaceTypes at document creation.
;  
; 
;    * This is the traditional TSMDocument type.  It does not support
;    * Unicode. TSM will convert all Unicode produced by input methods to
;    * the Mac encoding represented by the current keyboard script (or
;    * the Mac encoding specified by the input method producing text.) 
;    * Full Unicode input sources may not be selectable when this
;    * TSMDocument is active.
;    

(defconstant $kTextServiceDocumentInterfaceType :|tsvc|);  TSM Document type for traditional (non-Unicode) NewTSMDocument 
; 
;    * TSMTE document type.  This requests automatic management of inline
;    * input sessions by TextEdit (the text engine.)  See Technote TE27 -
;    * Inline Input for TextEdit with TSMTE.
;    

(defconstant $kTSMTEDocumentInterfaceType :|tmTE|);  TSM Document type for TSMTE document (see kTSMTEInterfaceType - TSMTE.h) 
; 
;    * Unicode-savvy TSMDocument.  TSM will pass thru all Unicode text
;    * unchanged. When this TSMDocument is active, the full range of
;    * input sources is available to the user, such as Unicode keyboard
;    * layouts.
;    

(defconstant $kUnicodeDocumentInterfaceType :|udoc|);  TSM Document type for Unicode-savvy application 
;     Older names, to be deprecated

(defconstant $kUnicodeDocument :|udoc|)         ;  TSM Document type for Unicode-savvy application 

; 
;     TextServiceClass constants supported by TSM
;     Same as component subtype for the component description
; 

(def-mactype :TextServiceClass (find-mactype ':OSType))
; 
;  *  Summary:
;  *    TextService classes
;  *  
;  *  Discussion:
;  *    Text Service classes fall in two categories or behaviors.  Text
;  *    services that belong to some classes are exclusive of oneanother
;  *    within a given Mac script code, such input methods of the
;  *    keyboard class. Input Methods of other classes are additive in
;  *    nature, regardless of the current keyboard script. Within a given
;  *    class and script, exclusive input methods can only be activated
;  *    one at a time.  Input methods in additive classes are keyboard
;  *    script agnostic and can be active in parallel with other text
;  *    services in the same class, such as multiple character palettes.
;  
; 
;    * Text service class for keyboard input methods.  Behavior is
;    * exclusive. Input Methods in this class are normally associated
;    * with a Mac ScriptCode or Unicode, although they can be associated
;    * with several scripts by adopting the Input Mode protocol.
;    

(defconstant $kKeyboardInputMethodClass :|inpm|)
; 
;    * Text service class for Ink (Handwriting) input methods.  Behavior
;    * is Additive. Text Services in the Ink class do not belong to any
;    * given script in the sense that those of the Keyboard class do. 
;    * Once selected, this kind of text service will remain active
;    * regardless of the current keyboard script. Although text services
;    * in this class are keyboard script agnostic, like input methods of
;    * the keyboard class they can still profess to produce only those
;    * Unicodes that are encoded in the mac encoding specified in their
;    * component description record or their implementation of the
;    * GetScriptLanguageSupport component call. Unlike input methods in
;    * the keyboard class, multiple such text services can be activate in
;    * parallel, although Mac OS X only provides System UI for Apple's
;    * Ink input method currently.
;    

(defconstant $kInkInputMethodClass :|ink |)
; 
;    * Text service class for Character Palette input methods.  Behavior
;    * is Additive. Text Services in the character palette class do not
;    * belong to any given script in the same sense that do those of the
;    * Keyboard class.  Once selected, this kind of text service will
;    * remain active regardless of the current keyboard script. Although
;    * text services in this class are keyboard script agnostic, like
;    * input methods of the keyboard class they can still profess to
;    * produce only those Unicodes that are encoded in the mac encoding
;    * specified in their component description record or their
;    * implementation of the GetScriptLanguageSupport component call.
;    * Unlike input methods in the keyboard class, multiple such text
;    * services can be activate in parallel, and unlike input methods in
;    * the Ink class, Mac OS X provides System UI to allow the user to
;    * both enable and select multiple such input methods.
;    

(defconstant $kCharacterPaletteInputMethodClass :|cplt|)
; 
;    * Text Service class for Speech input methods.  Behavior is
;    * Additive. Similar to Character palette class.  System UI for these
;    * has not yet been determined.
;    

(defconstant $kSpeechInputMethodClass :|voic|)
; 
;    * Text Service class for Optical Character Recognition input
;    * methods.  Behavior is Additive. Similar to Character palette
;    * class.  System UI for these has not yet been determined.
;    

(defconstant $kOCRInputMethodClass :|ocr |)
;  New opaque definitions for types 

(def-mactype :TSMDocumentID (find-mactype '(:pointer :OpaqueTSMDocumentID)))
;  TSMDocumentID Properties
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  TSMDocumentID Properties                                                             
;                                                                                       
;  With the following property APIs, you can attach any piece of data you'd like to a   
;  TSMDocument.
;  to attach the data to the menu itself, and not to any specific menu item.            
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(def-mactype :TSMDocumentPropertyTag (find-mactype ':OSType))
; 
;  *  Summary:
;  *    TSMDocument Property Tags
;  *  
;  *  Discussion:
;  *    With the following property APIs, you can attach any piece of
;  *    data you'd like to a TSMDocument.  The property tags pre-defined
;  *    below by TSM fall in several categories. Read-only properties: 
;  *    these property tags are actually the interface type used to
;  *    create a TSMDocument, such as kUnicodeDocumentInterfaceType.
;  *    These properties are all property value-independent... see below.
;  *    Value-independent properties:  these property tags are value
;  *    independent. Only the fact that the tag is or is not a property
;  *    of a TSMDocument is important.  These are used where the
;  *    existence of the property is sufficient... Read-only TSMDocment
;  *    properties are examples of value independent properties.
;  *    SupportGlyphInfo is another. Pass a non-NULL actualSize parameter
;  *    and a NULL propertyBuffer to check if the property exists (i.e.
;  *    to obtain the size.) Value-dependent properties:  these are
;  *    properties for which the value is meaningful.  Examples of this
;  *    are the Refcon ProtocolVersion properties. NOTE: 
;  *    Value-independent properties can read by other clients, in
;  *    particular input methods.  For example, input methods may want to
;  *    query the current TSMDocument to see if supports unrestricted
;  *    Unicode input, or if it supports the GlyphInfo protocol.
;  
;     
;     Property values for value-independent property tags (i.e. only the existence of
;     the property is meaningful).  To remove these properties, use TSMRemoveDocumentProperty.
;     To test these properties, it is sufficient to obtain the property's size, i.e. buffer = NULL
;     and test for error.
;     Read-only (value-independent) properties
;     Identical to Interface types passed to NewTSMDocument
; 
;    * Property is read-only, value-independent.  The value is identical
;    * to the TextServiceDocument interface type, but is not needed. 
;    * Simply test for existence of the property. Property available in
;    * TSM 2.2 and later
;    

(defconstant $kTSMDocumentTextServicePropertyTag :|tsvc|)
; 
;    * Property is read-only, value-independent.  The value is identical
;    * to the UnicodeDocument interface type, but is not needed.  Simply
;    * test for existence of the property. Property available in TSM 2.2
;    * and later
;    

(defconstant $kTSMDocumentUnicodePropertyTag :|udoc|)
; 
;    * Property is read-only, value-independent.  The value is identical
;    * to the TSMTEDocument interface type, but is not needed.  Simply
;    * test for existence of the property. Property available in TSM 2.2
;    * and later
;    

(defconstant $kTSMDocumentTSMTEPropertyTag :|tmTE|);     
;     Settable value-independent properties
; 
;    * Property is value-independent.  The existence of this property in
;    * a TSMDocument indicates that the event handlers associated with
;    * the TSMDocument are aware of TSM's GlyhInfo data structure.  This
;    * structure allows the input source producing text to apply Glyph
;    * IDs, CIDs, or Fonts to subranges of text produced. This is useful
;    * for characters in Unicode private use area, such as Windings. For
;    * more information, see the Glyph Access protocol described in
;    * TechNote TN20TT. By convention, this value can be a UInt32 with a
;    * value of 0, but this is really arbitrary.  Simply test for
;    * existence of the property. Property available in TSM 1.5 from
;    * MacOSX 10.2 and later
;    

(defconstant $kTSMDocumentSupportGlyphInfoPropertyTag :|dpgi|);   property value is arbitrary
; 
;    * Property is value-independent.  The presence of this property tag
;    * indicates that the TSMDocument should use TSM's floating input
;    * window to handle input from input methods.  This form of input
;    * does not support Unicode input by default, unless the
;    * UnicodeInputWindow property is set. By convention, this value can
;    * be a UInt32 with a value of 0, but this is really arbitrary. 
;    * Simply test for existence of the property. Property available in
;    * TSM 2.2 and later
;    

(defconstant $kTSMDocumentUseFloatingWindowPropertyTag :|uswm|);     use bottom-line input (floating TSM) window for text input
; 
;    * Property is value-independent.  The presence of this property tag
;    * indicates that although the TSMDocument has been told to use TSM's
;    * floating input window to handle input from input methods, the
;    * floating window is to support Unicode input.  This is useful when
;    * non input-related activity is to produce Unicode, such as keyboard
;    * navigation . By convention, this value can be a UInt32 with a
;    * value of 0, but this is really arbitrary.  Simply test for
;    * existence of the property. Property available in TSM 2.2 and later
;    

(defconstant $kTSMDocumentUnicodeInputWindowPropertyTag :|dpub|);     Unicode support in bottom line input window
; 
;    * Property is value-independent.  The presence of this property tag
;    * indicates that the event handlers associated with this TSMDocument
;    * support TSM's DocumentAccess event suite (see CarbonEvents.h) This
;    * property also indicates that the handler for TSM's
;    * kEventTextInputUpdateActiveInputArea event supports the
;    * 'replaceRange' parameter and that the handler is a Carbon event
;    * handler, not an AppleEvent handler. By convention, this value can
;    * be a UInt32 with a value of 0, but this is really arbitrary. 
;    * Simply test for existence of the property. Property available in
;    * TSM 2.2 and later
;    

(defconstant $kTSMDocumentSupportDocumentAccessPropertyTag :|dapy|);     support TSM Document Access protocol
;     Older names, to be deprecated

(defconstant $kTSMDocumentPropertySupportGlyphInfo :|dpgi|)
(defconstant $kTSMDocumentPropertyUnicodeInputWindow :|dpub|);     
;     Settable value-dependent properties
;     Property values for the following property tags are meaningful
; 
;    * Property is value-dependent.  The property value initially
;    * contains the Refcon value passed to NewTSMDocument. This property
;    * is useful for changing the refcon on-the-fly after the TSMDocument
;    * has been created. The refcon value is a long, the same as that
;    * passed to NewTSMDocument. Property available in TSM 2.2 and later
;    

(defconstant $kTSMDocumentRefconPropertyTag :|refc|);     refcon passed to TSMDocument (UInt32)
; 
;    * Property is value-dependent.  The property value indicates which
;    * input mode should be used by the current keyboard-class input
;    * method.  It is useful for temporarily restricting text input to a
;    * subset of characters normally produced by an input method in a
;    * given script, such as Katakana for Japanese input.  See details in
;    * TextServiceProperty API below. Also note that this property tag
;    * and value are passed unchanged to the TextServiceProperty API, so
;    * it also serves as a TextServicePropertyTag. See
;    * kTextServiceInputModePropertyTag for discussion on the values
;    * associated with this property. Usage Note:  Property value is a
;    * CFStringRef. With TSMGetTextServiceProperty, the behavior is that
;    * of a Copy function. The implementation of
;    * TSMSetTextServiceProperty (in the component) retains or copies the
;    * CFString... in either case the caller is responsible for releasing
;    * its reference. Property available in TSM 2.2 and later
;    

(defconstant $kTSMDocumentInputModePropertyTag :|imim|);     Input mode property for input methods (CFStringRef - see Input Modes below)

; 
;  *  TSMSetDocumentProperty()
;  *  
;  *  Summary:
;  *    Set a TSMDocument property
;  *  
;  *  Discussion:
;  *    With the following property APIs, you can attach any piece of
;  *    data you'd like to a TSMDocument.  Other uses include setting a
;  *    (value-independent) property for input methods to query in order
;  *    to determine an application's compliance with various TSM
;  *    protocols. NOTE:  Property values are currently typed as SInt32,
;  *    but should really be a void* since a variety of data types are
;  *    used in practice. Note that the semantics for refcounted objects
;  *    is ambiguous, so retain/release model is discussed for each
;  *    TSM-defined property individually.  (See notes for
;  *    TSMDocumentPropertyTag) Error Codes (MacErrors.h): 
;  *    tsmComponentPropertyUnsupportedErr tsmInputModeChangeFailedErr
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TSMSetDocumentProperty" 
   ((docID (:pointer :OpaqueTSMDocumentID))
    (propertyTag :OSType)
    (propertySize :UInt32)
    (propertyData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  TSMGetDocumentProperty()
;  *  
;  *  Summary:
;  *    Get a TSMDocument property
;  *  
;  *  Discussion:
;  *    With the following property APIs, you can attach any piece of
;  *    data you'd like to a TSMDocument.  Other uses include setting a
;  *    (value-independent) property for input methods to query in order
;  *    to determine an application's compliance with various TSM
;  *    protocols. NOTE:  Property values are currently typed as SInt32,
;  *    but should really be a void* since a variety of data types are
;  *    used in practice. Note that the semantics for refcounted objects
;  *    is ambiguous, so retain/release model is discussed for each
;  *    TSM-defined property individually.  (See notes for
;  *    TSMDocumentPropertyTag) Error Codes (MacErrors.h)
;  *    tsmDocPropertyNotFoundErr tsmDocPropertyBufferTooSmallErr
;  *    tsmComponentPropertyNotFoundErr tsmComponentPropertyUnsupportedErr
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TSMGetDocumentProperty" 
   ((docID (:pointer :OpaqueTSMDocumentID))
    (propertyTag :OSType)
    (bufferSize :UInt32)
    (actualSize (:pointer :UInt32))
    (propertyBuffer :pointer)                   ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  TSMRemoveDocumentProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TSMRemoveDocumentProperty" 
   ((docID (:pointer :OpaqueTSMDocumentID))
    (propertyTag :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
;  Language and Script constants

(defconstant $kUnknownLanguage #xFFFF)
(defconstant $kUnknownScript #xFFFF)
(defconstant $kNeutralScript #xFFFF)
;  Component Flags in ComponentDescription 

(defconstant $bTakeActiveEvent 15)              ;  bit set if the component takes active event 

(defconstant $bHandleAERecording 16)            ;  bit set if the component takes care of recording Apple Events <new in vers2.0> 

(defconstant $bScriptMask #x7F00)               ;  bit 8 - 14 

(defconstant $bLanguageMask #xFF)               ;  bit 0 - 7  
;  bit 0 - 14  

(defconstant $bScriptLanguageMask #x7FFF)
;  Low level routines which are dispatched directly to the Component Manager 

(defconstant $kCMGetScriptLangSupport 1)        ;  Component Manager call selector 1 

(defconstant $kCMInitiateTextService 2)         ;  Component Manager call selector 2 

(defconstant $kCMTerminateTextService 3)        ;  Component Manager call selector 3 

(defconstant $kCMActivateTextService 4)         ;  Component Manager call selector 4 

(defconstant $kCMDeactivateTextService 5)       ;  Component Manager call selector 5 

(defconstant $kCMTextServiceEvent 6)            ;  Component Manager call selector 6 

(defconstant $kCMTextServiceEventRef 6)
(defconstant $kCMGetTextServiceMenu 7)          ;  Component Manager call selector 7 

(defconstant $kCMTextServiceMenuSelect 8)       ;  Component Manager call selector 8 

(defconstant $kCMFixTextService 9)              ;  Component Manager call selector 9 

(defconstant $kCMSetTextServiceCursor 10)       ;  Component Manager call selector 10 

(defconstant $kCMHidePaletteWindows 11)         ;  Component Manager call selector 11 

(defconstant $kCMGetTextServiceProperty 12)     ;  Component Manager call selector 12 

(defconstant $kCMSetTextServiceProperty 13)     ;  Component Manager call selector 13 

(defconstant $kCMUCTextServiceEvent 14)         ;  Component Manager call selector 14 

(defconstant $kCMCopyTextServiceInputModeList 15);  Component Manager call selector 15 

;  extract Script/Language code from Component flag ... 
; #define     mGetScriptCode(cdRec)       ((ScriptCode)   ((cdRec.componentFlags & bScriptMask) >> 8))
; #define     mGetLanguageCode(cdRec)     ((LangCode)     cdRec.componentFlags & bLanguageMask)
;  Text Service Info List 
(defrecord TextServiceInfo
   (fComponent (:pointer :ComponentRecord))
   (fItemName (:string 255))
)

;type name? (%define-record :TextServiceInfo (find-record-descriptor ':TextServiceInfo))

(def-mactype :TextServiceInfoPtr (find-mactype '(:pointer :TextServiceInfo)))
(defrecord TextServiceList
   (fTextServiceCount :SInt16)                  ;  number of entries in the 'fServices' array 
   (fServices (:array :TextServiceInfo 1))      ;  Note: array of 'TextServiceInfo' records follows 
)

;type name? (%define-record :TextServiceList (find-record-descriptor ':TextServiceList))

(def-mactype :TextServiceListPtr (find-mactype '(:pointer :TextServiceList)))

(def-mactype :TextServiceListHandle (find-mactype '(:handle :TextServiceList)))
(defrecord ScriptLanguageRecord
   (fScript :SInt16)
   (fLanguage :SInt16)
)

;type name? (%define-record :ScriptLanguageRecord (find-record-descriptor ':ScriptLanguageRecord))
(defrecord ScriptLanguageSupport
   (fScriptLanguageCount :SInt16)               ;  number of entries in the 'fScriptLanguageArray' array 
   (fScriptLanguageArray (:array :ScriptLanguageRecord 1));  Note: array of 'ScriptLanguageRecord' records follows 
)

;type name? (%define-record :ScriptLanguageSupport (find-record-descriptor ':ScriptLanguageSupport))

(def-mactype :ScriptLanguageSupportPtr (find-mactype '(:pointer :ScriptLanguageSupport)))

(def-mactype :ScriptLanguageSupportHandle (find-mactype '(:handle :ScriptLanguageSupport)))
(defrecord TSMGlyphInfo
   (range :CFRange)                             ;     two SInt32s
   (fontRef :UInt32)
   (collection :UInt16)                         ;     kGlyphCollectionXXX enum
   (glyphID :UInt16)                            ;     GID (when collection==0) or CID
)

;type name? (%define-record :TSMGlyphInfo (find-record-descriptor ':TSMGlyphInfo))
(defrecord TSMGlyphInfoArray
   (numGlyphInfo :UInt32)                       ;     UInt32
   (glyphInfo (:array :TSMGlyphInfo 1))
)

;type name? (%define-record :TSMGlyphInfoArray (find-record-descriptor ':TSMGlyphInfoArray))
;  High level TSM Doucment routines 
; 
;  *  NewTSMDocument()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewTSMDocument" 
   ((numOfInterface :SInt16)
    (supportedInterfaceTypes (:pointer :INTERFACETYPELIST))
    (idocID (:pointer :TSMDOCUMENTID))
    (refcon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DeleteTSMDocument()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DeleteTSMDocument" 
   ((idocID (:pointer :OpaqueTSMDocumentID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ActivateTSMDocument()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ActivateTSMDocument" 
   ((idocID (:pointer :OpaqueTSMDocumentID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DeactivateTSMDocument()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DeactivateTSMDocument" 
   ((idocID (:pointer :OpaqueTSMDocumentID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FixTSMDocument()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FixTSMDocument" 
   ((idocID (:pointer :OpaqueTSMDocumentID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetServiceList()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetServiceList" 
   ((numOfInterface :SInt16)
    (supportedInterfaceTypes (:pointer :OSType))
    (serviceInfo (:pointer :TEXTSERVICELISTHANDLE))
    (seedValue (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  OpenTextService()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_OpenTextService" 
   ((idocID (:pointer :OpaqueTSMDocumentID))
    (aComponent (:pointer :ComponentRecord))
    (aComponentInstance (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CloseTextService()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CloseTextService" 
   ((idocID (:pointer :OpaqueTSMDocumentID))
    (aComponentInstance (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SendAEFromTSMComponent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SendAEFromTSMComponent" 
   ((theAppleEvent (:pointer :AppleEvent))
    (reply (:pointer :AppleEvent))
    (sendMode :SInt32)
    (sendPriority :SInt16)
    (timeOutInTicks :signed-long)
    (idleProc (:pointer :OpaqueAEIdleProcPtr))
    (filterProc (:pointer :OpaqueAEFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SendTextInputEvent()
;  *  
;  *  Discussion:
;  *    This API replaces SendAEFromTSMComponent on Mac OS X only. Input
;  *    Methods on Mac OS X are Carbon Event based instead of AppleEvent
;  *    based.  The Carbon TextInput events which they generate are
;  *    provided to TSM for dispatching via this API.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib N.e.v.e.r and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SendTextInputEvent" 
   ((inEvent (:pointer :OpaqueEventRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDefaultInputMethod()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetDefaultInputMethod" 
   ((ts (:pointer :ComponentRecord))
    (slRecordPtr (:pointer :ScriptLanguageRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDefaultInputMethod()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetDefaultInputMethod" 
   ((ts (:pointer :COMPONENT))
    (slRecordPtr (:pointer :ScriptLanguageRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetTextServiceLanguage()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetTextServiceLanguage" 
   ((slRecordPtr (:pointer :ScriptLanguageRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetTextServiceLanguage()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetTextServiceLanguage" 
   ((slRecordPtr (:pointer :ScriptLanguageRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  UseInputWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_UseInputWindow" 
   ((idocID (:pointer :OpaqueTSMDocumentID))
    (useWindow :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  TSMSetInlineInputRegion()
;  *  
;  *  Summary:
;  *    Tell TSM what region and which window make up the inline input
;  *    session.
;  *  
;  *  Discussion:
;  *    Tell TSM about the region occupied by an inline input session. If
;  *    the location of certain mouse events (clicks, mouse moved) occur
;  *    within the specified inline input region, TSM will forward these
;  *    events to the current Input Method so that it can interact with
;  *    the user. Note: If you do not specify this information, TSM will
;  *    need to intercept mouse events in the entire content region as
;  *    the default, when an input method is active, in order to ensure
;  *    that input methods can manage user interaction properly.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inTSMDocument:
;  *      The document.
;  *    
;  *    inWindow:
;  *      The window that contains the inline input session. You can pass
;  *      NULL for this parameter to indicate the user focus window.
;  *    
;  *    inRegion:
;  *      The region occupied by the current inline input region. This
;  *      should be in the coordinates of the port associated with the
;  *      window you passed to inPort. It will need to be recomputed when
;  *      the text content of the inline input session content changes
;  *      (i.e. due to Update Active Input Area events) and when the
;  *      region moves for other reasons, such as window resized,
;  *      scrolling, etc. If you pass a NULL region for this parameter,
;  *      TSM will default to intercept mouse events in the focus
;  *      window's content region.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TSMSetInlineInputRegion" 
   ((inTSMDocument (:pointer :OpaqueTSMDocumentID))
    (inWindow (:pointer :OpaqueWindowPtr))
    (inRegion (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Following calls from Classic event loops not needed for Carbon clients. 
; 
;  *  TSMEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  TSMMenuSelect()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SetTSMCursor()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
;  Following ServiceWindow API replaced by Window Manager API in Carbon. 
; 
;  *  NewServiceWindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  CloseServiceWindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  GetFrontServiceWindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  FindServiceWindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  NewCServiceWindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  
;  Explicit initialization not needed for Carbon clients, since TSM is 
;  instanciated per-context. 
; 
;  *  InitTSMAwareApplication()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  CloseTSMAwareApplication()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
;  Component Manager Interfaces to Input Methods 
; 
;  *  GetScriptLanguageSupport()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetScriptLanguageSupport" 
   ((ts (:pointer :ComponentInstanceRecord))
    (scriptHdl (:pointer :SCRIPTLANGUAGESUPPORTHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InitiateTextService()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InitiateTextService" 
   ((ts (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TerminateTextService()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TerminateTextService" 
   ((ts (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ActivateTextService()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ActivateTextService" 
   ((ts (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DeactivateTextService()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DeactivateTextService" 
   ((ts (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GetTextServiceMenu()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetTextServiceMenu" 
   ((ts (:pointer :ComponentInstanceRecord))
    (serviceMenu (:pointer :MenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  New Text Service call in Carbon. 
;  Note: Only Raw Key and Mouse-flavored events are passed to Text Services on MacOS X. 
; 
;  *  TextServiceEventRef()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TextServiceEventRef" 
   ((ts (:pointer :ComponentInstanceRecord))
    (event (:pointer :OpaqueEventRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextServiceEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  UCTextServiceEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  
; 
;  *  TextServiceMenuSelect()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SetTextServiceCursor()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  FixTextService()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FixTextService" 
   ((ts (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  HidePaletteWindows()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HidePaletteWindows" 
   ((ts (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     Text Service Properties and standard values
;     (used with GetTextServiceProperty/SetTextServiceProperty)
; 

(def-mactype :TextServicePropertyTag (find-mactype ':OSType))
; 
;  *  Summary:
;  *    TextService Properties
;  *  
;  *  Discussion:
;  *    Text Service properties are passed directly to a text service
;  *    component via Component Mgr glue provided by TSM.  Applications
;  *    that have special knowledge of specific input methods can
;  *    communicate private properties between each other. The 2
;  *    following errors have been introduced (as of Mac OS X 10.3) to
;  *    better support these API: tsmComponentPropertyUnsupportedErr  // 
;  *    SetTextServiceProperty failed tsmComponentPropertyNotFoundErr    
;  *    //  GetTextServiceProperty failed
;  
;  Typing input mode property tag 
; 
;    * The JaTypingMethod property is becoming obsolete.  It was
;    * introduced as a way for the Setup Assistant to tell Apple's
;    * Kotoeri (Japanese) input method to switch to either Roman or
;    * Katakana input mode in certain text fields. The entire input mode
;    * mechanism is being superceded by kTextServiceInputModePropertyTag.
;    * Property available in TSM 1.5 on MacOSX 10.0 and later
;    

(defconstant $kTextServiceJaTypingMethodPropertyTag :|jtyp|);  Japanese input method typing property
; 
;    * The InputMode property is a CFStringRef that uniquely identifies
;    * which input mode should be made current by a keyboard class input
;    * method, if possible. Input modes are either generic, i.e.
;    * pre-defined by TSM, or specific to an input method.  An example of
;    * a generic input mode is Katakana input (Japanese) where input in a
;    * text field needs to be restricted to that character subset.
;    * Another is Roman input mode.  This is useful to temporarily
;    * provide Roman input from an input method that normally allows text
;    * input in another script. The advantage to this over forcing the
;    * keyboard script to Roman is that the same input method's UI
;    * continues to be available to the user, even though the input
;    * script has changed. An example of a special input mode (input
;    * method specific) is Hanin input mode in Traditional Chinese input
;    * methods. To temporarily change the current input mode from
;    * whatever it is to a generic one, use GetTextServiceProperty to
;    * obtain the current input mode, then SetTextServiceProperty to
;    * switch to the generic mode, and when done restore the original
;    * input mode. Input Methods themselves make known what input modes
;    * they support via the CopyTextServiceInputModeList component call. 
;    * If the input method does not support a specified inputMode,
;    * GetTextServiceProperty and SetTextServiceProperty will return
;    * tsmComponentPropertyUnsupportedErr.  GetTextServiceProperty will
;    * return tsmComponentPropertyNotFoundErr.  RemoveTextServiceProperty
;    * is not supported with this tag. NOTE: This property tag is
;    * identical to the kTSMDocumentInputModePropertyTag passed to the
;    * TSMDocumentProperty API.  This allows the tag and value to be
;    * passed through without interpretation. NOTE: Input modes
;    * CFStringRef's are cast to SInt32 in these API. Property available
;    * in TSM 2.2 and later Error Codes (MacErrors.h)
;    * tsmComponentPropertyUnsupportedErr - SetTextServiceProperty does
;    * not support the specified inputMode. tsmInputModeChangeFailedErr -
;    * can be returned if an input method failed to succeed in switching
;    * to the requested input mode.
;    

(defconstant $kTextServiceInputModePropertyTag :|imim|);  input mode property for input methods
;     NOTE:  This property is being deprecated.  Use kTextServiceInputModePropertyTag instead. 

(defconstant $kIMJaTypingMethodProperty :|jtyp|);  Typing method property for Japanese input methods
;  Typing method property values for kTextServiceJaTypingMethodPropertyTag 

(defconstant $kIMJaTypingMethodRoman :|roma|)   ;  Roman typing

(defconstant $kIMJaTypingMethodKana :|kana|)    ;  Kana typing


(def-mactype :TextServicePropertyValue (find-mactype ':SInt32))
; 
;     Generic, restricted, input modes
;     Used as values for kTextServiceInputModePropertyTag TextServiceProperty API.
;     These values require a cast from CFStringRef to SInt32.
; 
;   Restrict output to Roman characters only
; #define kTextServiceInputModeRoman      CFSTR("com.apple.inputmethod.Roman")
; #define kTextServiceInputModePassword   CFSTR("com.apple.inputmethod.Password")
;   Restrict output to Hiragana characters only (no conversion to Kanji, i.e. yomi)
; #define kTextServiceInputModeJapaneseHiragana  CFSTR("com.apple.inputmethod.Japanese.Hiragana")
;   Restrict output to Katakana characters only (no conversion to Kanji)
; #define kTextServiceInputModeJapaneseKatakana  CFSTR("com.apple.inputmethod.Japanese.Katakana")
; #define kTextServiceInputModeJapaneseFullWidthRoman  CFSTR("com.apple.inputmethod.Japanese.FullWidthRoman")
; #define kTextServiceInputModeJapaneseHalfWidthKana  CFSTR("com.apple.inputmethod.Japanese.HalfWidthKana")
; #define kTextServiceInputModeJapanesePlaceName  CFSTR("com.apple.inputmethod.Japanese.PlaceName")
; #define kTextServiceInputModeJapaneseFirstName  CFSTR("com.apple.inputmethod.Japanese.FirstName")
; #define kTextServiceInputModeJapaneseLastName  CFSTR("com.apple.inputmethod.Japanese.LastName")
;   Restrict output to Bopomofo characters only (no conversion to Han)
; #define kTextServiceInputModeBopomofo   CFSTR("com.apple.inputmethod.TradChinese.Bopomofo")
; #define kTextServiceInputModeTradChinesePlaceName  CFSTR("com.apple.inputmethod.TradChinese.PlaceName")
;   Restrict output to Hangul syllables only (no conversion to Hanja)
; #define kTextServiceInputModeHangul     CFSTR("com.apple.inputmethod.Korean.Hangul")
; 
;     Generic, unrestricted, Input Mode strings
;     Used as values for kTextServiceInputModePropertyTag in TextServiceProperty API.
;     Unrestricted Japanese output
; 
; #define kTextServiceInputModeJapanese   CFSTR("com.apple.inputmethod.Japanese")
;   Traditional Chinese generic (unrestricted) input mode
; #define kTextServiceInputModeTradChinese  CFSTR("com.apple.inputmethod.TradChinese")
;   Simplified Chinese generic (unrestricted) input mode
; #define kTextServiceInputModeSimpChinese  CFSTR("com.apple.inputmethod.SimpChinese")
;   Korean generic (unrestricted) output (i.e. Hanja possible)
; #define kTextServiceInputModeKorean     CFSTR("com.apple.inputmethod.Korean")
; 
;  *  GetTextServiceProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetTextServiceProperty" 
   ((ts (:pointer :ComponentInstanceRecord))
    (inPropertyTag :OSType)
    (outPropertyValue (:pointer :TEXTSERVICEPROPERTYVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SetTextServiceProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetTextServiceProperty" 
   ((ts (:pointer :ComponentInstanceRecord))
    (inPropertyTag :OSType)
    (inPropertyValue :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CopyTextServiceInputModeList()
;  *  
;  *  Summary:
;  *    Obtain a copy of the set of input modes supported by a
;  *    keyboard-class input method.
;  *  
;  *  Discussion:
;  *    This Component call is only intended to be supported by input
;  *    methods that adopt the Input Mode protocol. If this component
;  *    call is not supported by an input method, calls to the
;  *    TextServiceProperty API with the kTextServiceInputModePropertyTag
;  *    property will fail with tsmComponentPropertyUnsupportedErr. Below
;  *    is the layout of the CFDictionary returned. <dict> <key>
;  *    kTSInputModeListKey </key> <dict> <key> modeSignature : (internal
;  *    ascii name) </key> <!-- This can be any of the generic input
;  *    modes defined in this file, --> <!--    such as
;  *    kTextServiceInputModeRoman, or can be a private input --> <!--   
;  *    mode such as CFSTR(
;  *    "com.apple.MyInputmethod.Japanese.CoolInputMode" ) --> <dict>
;  *    <key>menuIconFile</key> <string> (path for menu icon image file)
;  *    </string> <key>alternateMenuIconFile</key> <string> (path for
;  *    alternate menu icon image file -- when item is hilited) </string>
;  *    <key>paletteIconFile</key> <string> (path for palette icon image
;  *    file) </string> <key>defaultState</key> <boolean> (default on/off
;  *    state) </boolean> <key>script</key> <string> (scriptCode string
;  *    for this mode, i.e. "smRoman", "smJapanese", ...) </string>
;  *    <key>primaryInScript</key> <boolean> (true if this is primary
;  *    mode in this script) </boolean> <key>isVisible</key> <boolean>
;  *    (true if this input mode should appear in System UI) </boolean>
;  *    <key>keyEquivalentModifiers</key> <integer> (modifiers)
;  *    </integer> <key>keyEquivalent</key> <string> (key equivalent
;  *    character) </string> <key>JISKeyboardShortcut</key> <integer>
;  *    (optional: 0=none,1=hiragana,2=katakana,3=eisu) </integer>
;  *    </dict> </dict> <key> kTSVisibleInputModeOrderedArrayKey </key>
;  *    <!-- This array defines the ordering (for UI purposes) of input
;  *    modes that are --> <!--    both visible and enabled (either by
;  *    default, i.e. by the System, or by --> <!--    the user, i.e. via
;  *    System provided UI) --> <array> <value> modeSignature </value>
;  *    </array> </dict> Available in TSM 2.2 and later Important:  This
;  *    dictionary must also be present in the component bundle's
;  *    Info.plist, in addition to being available through this component
;  *    call.  This will allow retrival of input modes by the System
;  *    without opening the component.  The component call will be used
;  *    whenever the System is notified of a change in the contents of
;  *    the inputMode list, such as when the name or key-equivalents of
;  *    individual input modes have changed. Note:       If, when the
;  *    input method is first activated in a login session, the settings
;  *    of the individual input modes (names or key-equivalents) differ
;  *    from the default settings as found in the component bundle's
;  *    Info.plist, the System will need to be notified of the change. 
;  *    The input method does this by sending out a
;  *    kEventTextInputInputMenuChanged Carbon event, just as it is when
;  *    the change originally took place.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CopyTextServiceInputModeList" 
   ((ts (:pointer :ComponentInstanceRecord))
    (outInputModes (:pointer :CFDictionaryRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;     Key for InputMode dictionary in Component bundle's Info.plist
;     Value is a dictionary describing the set of input modes implemented by the component.
;         The supported keys in this dictionary are:
;             kTSInputModeListKey
;             kTSVisibleInputModeOrderedArrayKey
;     See CopyTextServiceInputModeList() for more details.
; 
; #define kComponentBundleInputModeDictKey  CFSTR("ComponentInputModeDict")
; 
;     Key for dictionary of individual input modes
;     NOTE:  This key is used both in the Component bundle's Info.plist dictionary and the dictionary
;             returned by the CopyTextServiceInputModeList() component call.
; 
; #define kTSInputModeListKey             CFSTR("tsInputModeListKey")
; #define kTSInputModeMenuIconFileKey     CFSTR("tsInputModeMenuIconFileKey")
; #define kTSInputModeAlternateMenuIconFileKey  CFSTR("tsInputModeAlternateMenuIconFileKey")
; #define kTSInputModePaletteIconFileKey  CFSTR("tsInputModePaletteIconFileKey")
; #define kTSInputModeDefaultStateKey     CFSTR("tsInputModeDefaultStateKey")
; #define kTSInputModeScriptKey           CFSTR("tsInputModeScriptKey")
; #define kTSInputModePrimaryInScriptKey  CFSTR("tsInputModePrimaryInScriptKey")
; #define kTSInputModeIsVisibleKey        CFSTR("tsInputModeIsVisibleKey")
; #define kTSInputModeKeyEquivalentModifiersKey  CFSTR("tsInputModeKeyEquivalentModifiersKey")
; #define kTSInputModeKeyEquivalentKey    CFSTR("tsInputModeKeyEquivalentKey")
; #define kTSInputModeJISKeyboardShortcutKey  CFSTR("tsInputModeJISKeyboardShortcutKey")
; 
;     Key for array of visible input modes to determine UI ordering
;     NOTE:  This key is intended to be used both in the Component bundle's Info.plist dictionary and in
;             in the dictionary returned by the CopyTextServiceInputModeList() component call.  In the latter
;             case, the array should contain only the set of visible input modes that are also enabled.
; 
; #define kTSVisibleInputModeOrderedArrayKey  CFSTR("tsVisibleInputModeOrderedArrayKey")
; 
;  *  TSMCopyInputMethodEnabledInputModes()
;  *  
;  *  Summary:
;  *    Obtain the array of a component's enabled (and visible) input
;  *    modes.
;  *  
;  *  Discussion:
;  *    The intended use of this API is to allow an input method to query
;  *    the System for the subset of its own input modes that are
;  *    enabled, so that the component's own UI can ommit input modes
;  *    disabled by the user or the System. This API is only meaningful
;  *    for input methods that adopt the Input Mode protocol.  If the
;  *    component passed is not inputMode-savvy, the returned array will
;  *    be NULL. The enabled input modes returned in the array are always
;  *    visible ones, i.e. those input modes for which
;  *    kTSInputModeIsVisibleKey is true because non-visible input modes
;  *    are not tracked by the System. It is the responsibility of the
;  *    caller to release the returned array. <array> <value>
;  *    modeSignature : (internal ascii name) </value> </array> Available
;  *    in TSM 2.2 and later
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TSMCopyInputMethodEnabledInputModes" 
   ((inComponent (:pointer :ComponentRecord))
    (outInputModeArray (:pointer :CFArrayRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  *  TSMSelectInputMode()
;  *  
;  *  Summary:
;  *    Make the specified input method input mode the current input
;  *    source.
;  *  
;  *  Discussion:
;  *    The intended use of this API is to allow an input method to
;  *    select one of its own input modes as the current input source and
;  *    update the TextInput menu icon in the menubar. This API is only
;  *    meaningful for input methods that adopt TSM's Input Mode
;  *    protocol. Available in TSM 2.2 and later
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TSMSelectInputMode" 
   ((inComponent (:pointer :ComponentRecord))
    (inInputMode (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
;  Get the active TSMDocument in the current application context.       
;  If TSM has enabled bottom line input mode because no TSMDocument     
;  is active, NULL will be returned.                                    
; 
;  *  TSMGetActiveDocument()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TSMGetActiveDocument" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTSMDocumentID)
() )
; 
;  *  GetDefaultInputMethodOfClass()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDefaultInputMethodOfClass" 
   ((aComp (:pointer :COMPONENT))
    (slRecPtr (:pointer :ScriptLanguageRecord))
    (tsClass :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  SetDefaultInputMethodOfClass()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDefaultInputMethodOfClass" 
   ((aComp (:pointer :ComponentRecord))
    (slRecPtr (:pointer :ScriptLanguageRecord))
    (tsClass :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  SelectTextService()
;  *  
;  *  Summary:
;  *    Select a text service component
;  *  
;  *  Discussion:
;  *    This API is currently only intended for use by input methods in
;  *    text service classes which are "additive" in nature, that is
;  *    where the input method can operate in parallel to other input
;  *    methods in the same class and other additive text service
;  *    classes.  An example of such a class is the Character Palette
;  *    class.  It is not for use by traditional input methods, such as
;  *    those that belong to the keyboard input method class.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SelectTextService" 
   ((aComp (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  DeselectTextService()
;  *  
;  *  Summary:
;  *    Deselect a text service component
;  *  
;  *  Discussion:
;  *    See SelectTextService.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DeselectTextService" 
   ((aComp (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  IsTextServiceSelected()
;  *  
;  *  Summary:
;  *    Checks if a text service component is selected
;  *  
;  *  Discussion:
;  *    See SelectTextService.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsTextServiceSelected" 
   ((aComp (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )

; #if OLDROUTINENAMES
#| 
(defconstant $kInputMethodService :|inpm|)

(defconstant $kUnicodeTextService :|utsv|)      ;  Component type for Unicode Text Service 

 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __TEXTSERVICES__ */


(provide-interface "TextServices")