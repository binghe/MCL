(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:FontPanel.h"
; at Sunday July 2,2006 7:25:14 pm.
; 
;      File:       CommonPanels/FontPanel.h
;  
;      Contains:   Carbon Font Panel package Interfaces.
;  
;      Version:    CommonPanels-70~11
;  
;      Copyright:  © 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __FONTPANEL__
; #define __FONTPANEL__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
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
; #pragma options align=mac68k
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;     Font Panel-Related Events
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
;  *  Discussion:
;  *    Event classes
;  
; 
;    * Events related to font selection or handling.
;    

(defconstant $kEventClassFont :|font|)
; 
;  *  Summary:
;  *    Common command IDs
;  
; 
;    * The state of the Font Panel should be toggled, displaying it or
;    * hiding it as necessary. If the user closes the Font Panel directly
;    * from the window, the application will receive a
;    * kEventFontPanelClosed event.
;    

(defconstant $kHICommandShowHideFontPanel :|shfp|)
;  Font Events 
; 
;  *  Summary:
;  *    Font events (kEventClassFont)
;  *  
;  *  Discussion:
;  *    When the user closes the Font Panel, a kEventWindowClosed event
;  *    will be detected by the Carbon event handler installed by the
;  *    system. The system then notifies the application that the Font
;  *    Panel has closed by posting a Carbon Event Manager event. This
;  *    allows the application to update any menu items or other controls
;  *    whose state may have to change because the Font Panel has closed.
;  *    kEventWindowClosed has no parameters. When the user selects an
;  *    item in the Font Panel, the system will send a
;  *    kEventFontSelection event to the event target specified when the
;  *    application called SetFontPanelInfo(). kEventFontSelection will
;  *    contain parameters reflecting the current Font Panel selection in
;  *    all supported formats. Font events are available after Mac OS X
;  *    10.2 in the Carbon framework.
;  
; 
;    * The Font Panel has been closed. The application should update its
;    * corresponding UI element (e.g., a menu item) accordingly.
;    

(defconstant $kEventFontPanelClosed 1)
; 
;    * The user has specified font settings in the Font Panel. The
;    * application can obtain these settings from the event, in which
;    * they are stored as parameters. Not all parameters are guaranteed
;    * to be present; the application should check for all those which it
;    * recognizes and apply the ones found as appropriate to the target
;    * text.
;    

(defconstant $kEventFontSelection 2)
; 
;     Parameters for font events:
; 
;     kEventFontPanelClosed
;         None.
;         
;     kEventFontSelection
;         -->     kEventParamATSUFontID               typeATSUFontID
;         -->     kEventParamATSUFontSize             typeATSUSize
;         -->     kEventParamFMFontFamily             typeFMFontFamily
;         -->     kEventParamFMFontSize               typeFMFontSize
;         -->     kEventParamFontColor                typeFontColor
;         -->     kEventParamDictionary               typeCFDictionary 
; 

(defconstant $typeATSUFontID :|magn|)           ;  ATSUI font ID.

(defconstant $typeATSUSize :|fixd|)             ;  ATSUI font size.

(defconstant $typeFMFontFamily :|shor|)         ;  Font family reference.

(defconstant $typeFMFontStyle :|shor|)          ;  Quickdraw font style

(defconstant $typeFMFontSize :|shor|)           ;  Integer font size.

(defconstant $typeFontColor :|cRGB|)            ;  Font color spec (optional).

(defconstant $kEventParamATSUFontID :|auid|)    ;  typeATSUFontID

(defconstant $kEventParamATSUFontSize :|ausz|)  ;  typeATSUSize

(defconstant $kEventParamFMFontFamily :|fmfm|)  ;  typeFMFontFamily

(defconstant $kEventParamFMFontStyle :|fmst|)   ;  typeFMFontStyle

(defconstant $kEventParamFMFontSize :|fmsz|)    ;  typeFMFontSize

(defconstant $kEventParamFontColor :|fclr|)     ;  typeFontColor

(defconstant $kEventParamDictionary :|dict|)    ;     typeCFDictionaryRef

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;     Key constants to be used to access data inside the dictionary that may
;     be contained in the kEventFontSelection dictionary.
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
;  *  kFontPanelATSUFontIDKey
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFontPanelATSUFontIDKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; Value is a CFNumber containing the ATSU Font ID
; 
;  *  kFontPanelVariationAxesKey
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFontPanelVariationAxesKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Value is a CFDataRef containing one or more ATSUI Variation Axes
; 
;  *  kFontPanelVariationValuesKey
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFontPanelVariationValuesKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; Value is a CFDataRef containing one or more ATSU Variation values
; 
;  *  kFontPanelFeatureTypesKey
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFontPanelFeatureTypesKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;   Value is a CFDataRef containing one or more ATSUI feature types
; 
;  *  kFontPanelFeatureSelectorsKey
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFontPanelFeatureSelectorsKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;   Value is a CFDataRef containing one or more ATSUI feature selectors
; 
;  *  kFontPanelAttributesKey
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFontPanelAttributesKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; 
;   const <CFString> string kFontPanelAttributesKey           =   "FontAttributes";
;     Value is a CFDictionaryRef containing three keyed values.  Each value is
;     a CFDataRef.  One CFDataRef contains one or more ATSUAttributeTags.
;     One CFDataRef contains one or more value sizes for each tag.  And the last
;     CFDataRef contains the actual values.  It is important to understand that
;     these are the actual values and not value ptrs.  To pass these values to
;     ATSUI they must be converted into ptrs.  The following code fragment demonstrates
;     one technique
;     CFDataRef       values;
;     CFDataRef       tags;
;     CFDataRef       sizes;
;     if (    CFDictionaryGetValueIfPresent( attributesDict, kFontPanelAttributeValuesKey, &values ) &&
;             CFDictionaryGetValueIfPresent( attributesDict, kFontPanelAttributeTagsKey, &tags )
;             CFDictionaryGetValueIfPresent( attributesDict, kFontPanelAttributeSizesKey, &sizes ))
;     {
;         ItemCount               count = CFDataGetLength( tags )/sizeof(ATSUAttributeTag);
;         CFIndex                 index;
;         ATSUAttributeValuePtr   valuePtrs = malloc( count * sizeof(ATSUAttributeValuePtr) );
;         UInt32*                 sizePtr = (UInt32*)CFDataGetBytePtr(sizes);
;         UInt32*                 bytePtr = (UInt32*)CFDataGetBytePtr(values);
;         for ( index = 0; index < count; index++ )
;         {
;             valuePtrs[index] = bytePtr;
;             bytePtr = (UInt32*)( (UInt8*)bytePtr + sizePtr[index]);
;         }
;         verify_noerr( ATSUSetAttributes( someATSUStyle, count, (ATSUAttributeTag*)CFDataGetBytePtr(tags),sizePtr, valuePtrs ) );
;         free( valuePtrs );
; 
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;     Keys to access the CFDataRefs inside the attributes dictionary (see above)
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
;  *  kFontPanelAttributeTagsKey
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFontPanelAttributeTagsKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; Value is a CFDataRef containing one or more style attribute tags
; 
;  *  kFontPanelAttributeSizesKey
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFontPanelAttributeSizesKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; Value is a CFDataRef containing one or more style attribute sizes
; 
;  *  kFontPanelAttributeValuesKey
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFontPanelAttributeValuesKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; Value is a CFDataRef containing one or more style values
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;     Other Font Panel Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
; Error codes (Font Panel codes in range [-8880,-8899]).
; 

(defconstant $fontPanelShowErr -8880)           ;  Can't display the Font Panel.

(defconstant $fontPanelSelectionStyleErr -8881) ;  Bad font selection style info.
;  Unsupported record version.

(defconstant $fontPanelFontSelectionQDStyleVersionErr -8882)
; 
; Type of font information passed in SetFontPanelInfo(). If the client is
; sending ATSUI style data, it specifies kFontSelectionATSUIType; if it is
; sending Quickdraw style data, it specifies kFontSelectionQDType.
; 

(defconstant $kFontSelectionATSUIType :|astl|)  ;  Use ATSUIStyle collection.

(defconstant $kFontSelectionQDType :|qstl|)     ;  Use FontSelectionQDStyle record.

; 
; Supported versions of the FontSelectionQDStyle record. Clients should always set
; the <version> field to one of these values.
; 

(defconstant $kFontSelectionQDStyleVersionZero 0)
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;     Font Panel Types
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
; Record specifying the font information to be specified in the Font
; Panel. This record is used if the client is sending Quickdraw style data
; (i.e., it specified kFontSelectionQDType in SetFontPanelInfo()).
; 
(defrecord FontSelectionQDStyle
   (version :UInt32)                            ;  Version number of struct.
   (instance :FMFontFamilyInstance)             ;  Font instance data.
   (size :SInt16)                               ;  Size of font in points.
   (hasColor :Boolean)                          ;  true if color info supplied.
   (reserved :UInt8)                            ;  Filler byte.
   (color :RGBColor)                            ;  Color specification for font.
)

;type name? (%define-record :FontSelectionQDStyle (find-record-descriptor ':FontSelectionQDStyle))

(def-mactype :FontSelectionQDStylePtr (find-mactype '(:pointer :FontSelectionQDStyle)))
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;     Font Panel Functions
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
;  *  FPIsFontPanelVisible()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FPIsFontPanelVisible" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Boolean
() )
; 
;  *  FPShowHideFontPanel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FPShowHideFontPanel" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  SetFontInfoForSelection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetFontInfoForSelection" 
   ((iStyleType :OSType)
    (iNumStyles :UInt32)
    (iStyles :pointer)
    (iFPEventTarget (:pointer :OpaqueHIObjectRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;     Font Collection Functions
; 
;     In 10.3 the ability to create and modify font collections is available.  Font
;     collections are files containing font descriptions.  Font descriptions are
;     encapsulated in the opaque object FCFontDescriptorRef. A FCFontDescriptroRef
;     is a CFType.  To release one call CFRelease.
;     
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;     Font Collection Types
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(def-mactype :FCFontDescriptorRef (find-mactype '(:pointer :OpaqueFCFontDescriptorRef)))
; 
;  *  FCCopyCollectionNames()
;  *  
;  *  Discussion:
;  *    FCCopyCollectionNames returns a copy of the CFArrayRef containing
;  *    the displayable names of every font collection available to the
;  *    current user.
;  *  
;  *  Result:
;  *    A CFArrayRef containing CFStringRefs where each CFStringRef
;  *    contains a font collection's displayable name. Callers are
;  *    responsible for releasing the returned CFArrayRef.  If the
;  *    operation is not successful NULL is returned.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FCCopyCollectionNames" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFArray)
() )
; 
;  *  FCCopyFontDescriptorsInCollection()
;  *  
;  *  Discussion:
;  *    FCCopyFontDescriptorsInCollection copies the fontDescriptors in a
;  *    named collection into an array.
;  *  
;  *  Parameters:
;  *    
;  *    iCollection:
;  *      The name of a collection that descriptors should be copied from.
;  *  
;  *  Result:
;  *    A CFArrayRef containing copies of the FCFontDescriptorRefs
;  *    contained in the name collection.  Callers are responsible for
;  *    releasing the returned CFArrayRef.  The FCFontDescriptorRefs are
;  *    retained when added to the array and released when the array is
;  *    destroyed.  You can access a font descriptor in the array in the
;  *    following manner: fd =
;  *    (FCFontDescriptorRef)CFArrayGetValueAtIndex(array, i);
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FCCopyFontDescriptorsInCollection" 
   ((iCollection (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFArray)
() )
; 
;  *  FCAddCollection()
;  *  
;  *  Discussion:
;  *    Add a collection to the font descriptor collections available to
;  *    the current user. If the collection is successfully added noErr
;  *    is returned.  If the collection is not added an error code is
;  *    returned.
;  *  
;  *  Parameters:
;  *    
;  *    iCollection:
;  *      the name of the collection to add.
;  *    
;  *    iCollectionOptions:
;  *      currently there are no options.  Set to kNilOptions.  This
;  *      parameter is available for future expansion.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FCAddCollection" 
   ((iCollection (:pointer :__CFString))
    (iCollectionOptions :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  FCRemoveCollection()
;  *  
;  *  Discussion:
;  *    Remove a named collection from the font descriptor collections
;  *    available to the current user. Returns noErr if the collection
;  *    was successfully removed.  An appropriate error code is returned
;  *    if the operation was not successful.
;  *  
;  *  Parameters:
;  *    
;  *    iCollection:
;  *      the name of the collection to remove.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FCRemoveCollection" 
   ((iCollection (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  FCAddFontDescriptorToCollection()
;  *  
;  *  Discussion:
;  *    Add a font descriptor to the named collection.  noErr is returned
;  *    if the font descriptor is added. An error code describing the
;  *    failure is returned if the descriptor is not added.
;  *  
;  *  Parameters:
;  *    
;  *    iDescriptor:
;  *      the font descriptor that should be added.  The
;  *      FCFontDescriptorRef is retained when it is added to the
;  *      collection.  After calling this function the caller may release
;  *      their copy.
;  *    
;  *    iCollection:
;  *      the name of the collection to which the font descriptor should
;  *      be added.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FCAddFontDescriptorToCollection" 
   ((iDescriptor (:pointer :OpaqueFCFontDescriptorRef))
    (iCollection (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  FCRemoveFontDescriptorFromCollection()
;  *  
;  *  Discussion:
;  *    Remove a font descriptor from the named collection.  An error is
;  *    returned if the font descriptor can not be removed.  noErr is
;  *    returned if the descriptor is removed.
;  *  
;  *  Parameters:
;  *    
;  *    iDescriptor:
;  *      the descriptor that should be removed.
;  *    
;  *    iCollection:
;  *      the name of the collection that the descriptor should be
;  *      removed from.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FCRemoveFontDescriptorFromCollection" 
   ((iDescriptor (:pointer :OpaqueFCFontDescriptorRef))
    (iCollection (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
;     Font Descriptor Attribute Keys
;     
;     Font Descriptors contain font attributes that are set and accessed via a set of 
;     keys.  The keys are all constant CFStringRefs.
; 
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
;  *  kFCFontFamilyAttribute
;  *  
;  *  Discussion:
;  *    The key for a CFStringRef that contains a font family name (e.g.
;  *    Baskerville).
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFCFontFamilyAttribute (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; 
;  *  kFCFontNameAttribute
;  *  
;  *  Discussion:
;  *    The key for a CFStringRef containing a font name (e.g.
;  *    Baskerville-Italic).
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFCFontNameAttribute (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; 
;  *  kFCFontFaceAttribute
;  *  
;  *  Discussion:
;  *    The key for a CFStringRef containing a face name (e.g. Italic).
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFCFontFaceAttribute (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; 
;  *  kFCFontSizeAttribute
;  *  
;  *  Discussion:
;  *    The key for a CFNumber containg the font size (e.g. 12).
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFCFontSizeAttribute (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; 
;  *  kFCFontVisibleNameAttribute
;  *  
;  *  Discussion:
;  *    The Key for a CFStringRef containing the name that should be used
;  *    in a UI to describe the font.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFCFontVisibleNameAttribute (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; 
;  *  kFCFontCGColorAttribute
;  *  
;  *  Discussion:
;  *    The Key for a CGColorRef containing the fonts color.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
(def-mactype :kFCFontCGColorAttribute (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; 
;  *  FCFontDescriptorCreateWithFontAttributes()
;  *  
;  *  Discussion:
;  *    Create a font descriptor using the attributes contained in the
;  *    dictionary.
;  *  
;  *  Parameters:
;  *    
;  *    iAttributes:
;  *      a dictionary containing one or more of the attributes described
;  *      above.
;  *  
;  *  Result:
;  *    A valid FCFontDescriptorRef.  NULL if one cannot be created.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FCFontDescriptorCreateWithFontAttributes" 
   ((iAttributes (:pointer :__CFDictionary))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :OpaqueFCFontDescriptorRef)
() )
; 
;  *  FCFontDescriptorCreateWithName()
;  *  
;  *  Discussion:
;  *    Create a font descriptor using a fontname and font size.
;  *  
;  *  Parameters:
;  *    
;  *    iFontName:
;  *      The name of the font (e.g. Baskerville-Italic).
;  *    
;  *    iSize:
;  *      the size of the font. (e.g. 12.0).
;  *  
;  *  Result:
;  *    A valid FCFontDescriptorRef.  NULL if one cannot be created.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FCFontDescriptorCreateWithName" 
   ((iFontName (:pointer :__CFString))
    (iSize :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :OpaqueFCFontDescriptorRef)
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __FONTPANEL__ */


(provide-interface "FontPanel")