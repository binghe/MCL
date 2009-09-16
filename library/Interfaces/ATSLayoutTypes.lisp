(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ATSLayoutTypes.h"
; at Sunday July 2,2006 7:23:45 pm.
; 
;      File:       ATS/ATSLayoutTypes.h
;  
;      Contains:   Apple Type Services layout public structures and constants.
;  
;      Version:    ATS-135~1
;  
;      Copyright:  © 1994-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __ATSLAYOUTTYPES__
; #define __ATSLAYOUTTYPES__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __SFNTLAYOUTTYPES__

(require-interface "ATS/SFNTLayoutTypes")

; #endif

; #ifndef __ATSTYPES__

(require-interface "ATS/ATSTypes")

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
;  --------------------------------------------------------------------------- 
;  CONSTANTS and related scalar types 
;  --------------------------------------------------------------------------- 
;  --------------------------------------------------------------------------- 
;  Miscellaneous Constants 
;  --------------------------------------------------------------------------- 

(defconstant $kATSUseGlyphAdvance #x7FFFFFFF)   ;  assignment to use natural glyph advance value 

(defconstant $kATSUseLineHeight #x7FFFFFFF)     ;  assignment to use natural line ascent/descent values 
;  negativeInfinity 

(defconstant $kATSNoTracking #x80000000)
;  --------------------------------------------------------------------------- 
; 
;  *  Summary:
;  *    These values are passed into the ATSUGetGlyphBounds function to
;  *    indicate whether the width of the resulting typographic glyph
;  *    bounds will be determined using the caret origin, glyph origin in
;  *    device space, or glyph origin in fractional absolute positions
;  
; 
;    * Specifies that the width of the typographic glyph bounds will be
;    * determined using the caret origin. The caret origin is halfway
;    * between two characters.
;    

(defconstant $kATSUseCaretOrigins 0)
; 
;    * Specifies that the width of the typographic glyph bounds will be
;    * determined using the glyph origin in device space. This is useful
;    * for adjusting text on the screen.
;    

(defconstant $kATSUseDeviceOrigins 1)
; 
;    * Specifies that the width of the typographic glyph bounds will be
;    * determined using the glyph origin in fractional absolute
;    * positions, which are uncorrected for device display. This provides
;    * the ideal position of laid-out text and is useful for scaling text
;    * on the screen. This origin is also used to get the width of the
;    * typographic bounding rectangle when you call ATSUMeasureText.
;    

(defconstant $kATSUseFractionalOrigins 2)
(defconstant $kATSUseOriginFlags 3)
;  ---------------------------------------------------------------------------- 
; 
;  *  ATSULayoutOperationSelector
;  *  
;  *  Summary:
;  *    This is used to select which operations to override, or which
;  *    operation is currently being run.
;  

(def-mactype :ATSULayoutOperationSelector (find-mactype ':UInt32))
; 
;    * No Layout operation is currently selected.
;    

(defconstant $kATSULayoutOperationNone 0)
; 
;    * Select the Justification operation.
;    

(defconstant $kATSULayoutOperationJustification 1)
; 
;    * Select the character morphing operation.
;    

(defconstant $kATSULayoutOperationMorph 2)
; 
;    * Select the kerning adjustment operation.
;    

(defconstant $kATSULayoutOperationKerningAdjustment 4)
; 
;    * Select the baseline adjustment operation.
;    

(defconstant $kATSULayoutOperationBaselineAdjustment 8)
; 
;    * Select the tracking adjustment operation.
;    

(defconstant $kATSULayoutOperationTrackingAdjustment 16)
; 
;    * Select the period of time after ATSUI has finished all of it's
;    * layout operations.
;    

(defconstant $kATSULayoutOperationPostLayoutAdjustment 32)
(defconstant $kATSULayoutOperationAppleReserved #xFFFFFFC0)
;  ---------------------------------------------------------------------------- 
; 
;  *  ATSULayoutOperationCallbackStatus
;  *  
;  *  Summary:
;  *    One of these must be returned by a
;  *    ATSUDLayoutOperationOverrideUPP callback function in order to
;  *    indicate ATSUI's status.
;  

(def-mactype :ATSULayoutOperationCallbackStatus (find-mactype ':UInt32))
; 
;    * Return this if the callback function has totally handled the
;    * operation which triggered the callback and does not need ATSUI to
;    * run any further processing for the operation.
;    

(defconstant $kATSULayoutOperationCallbackStatusHandled 0)
; 
;    * Return this if the callback function has not totally handled the
;    * operation which triggered the callback and needs ATSUI to run it's
;    * own processing.
;    

(defconstant $kATSULayoutOperationCallbackStatusContinue 1)
;  ---------------------------------------------------------------------------- 
; 
;  *  ATSLineLayoutOptions
;  *  
;  *  Summary:
;  *    ATSLineLayoutOptions are normally set in an ATSUTextLayout object
;  *    via the kATSULineLayoutOptionsTag layout control attribute. They
;  *    can also be set in an ATSLineLayoutParams structure.
;  

(def-mactype :ATSLineLayoutOptions (find-mactype ':UInt32))
; 
;    * No options specified.
;    

(defconstant $kATSLineNoLayoutOptions 0)
; 
;    * This line option is no longer used.
;    

(defconstant $kATSLineIsDisplayOnly 1)          ;  obsolete option
; 
;    * Specifies that no hangers to be formed on the line.
;    

(defconstant $kATSLineHasNoHangers 2)
; 
;    * Specifies that no optical alignment to be performed on the line.
;    

(defconstant $kATSLineHasNoOpticalAlignment 4)
; 
;    * Specifies that space charcters should not be treated as hangers.
;    

(defconstant $kATSLineKeepSpacesOutOfMargin 8)
; 
;    * Specifies no post-compensation justification is to be performed.
;    

(defconstant $kATSLineNoSpecialJustification 16)
; 
;    * Specifies that if the line is the last of a paragraph, it will not
;    * get justified.
;    

(defconstant $kATSLineLastNoJustification 32)
; 
;    * Specifies that the displayed line glyphs will adjust for device
;    * metrics.
;    

(defconstant $kATSLineFractDisable 64)
; 
;    * Specifies that the carets at the ends of the line will be
;    * guarenteed to be perpendicular to the baseline.
;    

(defconstant $kATSLineImposeNoAngleForEnds #x80)
; 
;    * Highlights for the line end characters will be extended to 0 and
;    * the specified line width.
;    

(defconstant $kATSLineFillOutToWidth #x100)
; 
;    * Specifies that the tab character width will be automatically
;    * adjusted to fit the specified line width.
;    

(defconstant $kATSLineTabAdjustEnabled #x200)
; 
;    * Specifies that any leading value specified by a font will be
;    * ignored.
;    

(defconstant $kATSLineIgnoreFontLeading #x400)
; 
;    * Specifies that ATS produce antialiased glyph images despite system
;    * preferences or CGContext settings.
;    

(defconstant $kATSLineApplyAntiAliasing #x800)
; 
;    * Specifies that ATS turn-off antialiasing glyph imaging despite
;    * system preferences or CGContext settings (negates
;    * kATSLineApplyAntiAliasing bit if set).
;    

(defconstant $kATSLineNoAntiAliasing #x1000)
; 
;    * Specifies that if the line width is not sufficient to hold all its
;    * glyphs, glyph positions are allowed to extend beyond the line's
;    * assigned width so negative justification is not used.
;    

(defconstant $kATSLineDisableNegativeJustification #x2000)
; 
;    * Specifies that lines with any integer glyph positioning (due to
;    * either any character non-antialiased or kATSLineFractDisable
;    * specified), not automatically esthetically adjust individual
;    * character positions while rendering to display.
;    

(defconstant $kATSLineDisableAutoAdjustDisplayPos #x4000)
; 
;    * Specifies that rendering be done through Quickdraw (default
;    * rendering in ATSUI is through CoreGraphics on MacOSX).
;    

(defconstant $kATSLineUseQDRendering #x8000)
; 
;    * Specifies that any Justification operations will not be run.
;    

(defconstant $kATSLineDisableAllJustification #x10000)
; 
;    * Specifies that any glyph morphing operations will not be run.
;    

(defconstant $kATSLineDisableAllGlyphMorphing #x20000)
; 
;    * Specifies that any kerning adjustment operations will not be run.
;    

(defconstant $kATSLineDisableAllKerningAdjustments #x40000)
; 
;    * Specifies that any baseline adjustment operations will not be run.
;    

(defconstant $kATSLineDisableAllBaselineAdjustments #x80000)
; 
;    * Specifies that any tracking adjustment operations will not be run.
;    

(defconstant $kATSLineDisableAllTrackingAdjustments #x100000)
; 
;    * Convenience constant for turning-off all adjustments.
;    

(defconstant $kATSLineDisableAllLayoutOperations #x1F0000)
; 
;    * Specifies to optimize for displaying text only.  Note, rounded
;    * device metrics will be used instead of fractional path metrics.
;    

(defconstant $kATSLineUseDeviceMetrics #x1000000)
; 
;    * Specifies that line breaking should occur at the nearest
;    * character, not word.  This could cause a word to be split among
;    * multiple lines.
;    

(defconstant $kATSLineBreakToNearestCharacter #x2000000)
; 
;    * These bits are reserved by Apple and will result in a invalid
;    * value error if attemped to set. Obsolete constants:
;    

(defconstant $kATSLineAppleReserved #xFCE00000)
;  --------------------------------------------------------------------------- 
; 
;  *  ATSStyleRenderingOptions
;  *  
;  *  Summary:
;  *    ATSStyleRenderingOptions are set in the ATSUStyle object via the
;  *    attribute tag kATSUStyleRenderingOptions. They provide finer
;  *    control over how the style is rendered.
;  

(def-mactype :ATSStyleRenderingOptions (find-mactype ':UInt32))
; 
;    * No options specified.
;    

(defconstant $kATSStyleNoOptions 0)
; 
;    * Specifies that ATS produce "unhinted" glyph outlines (default is
;    * hinted glyph outlines).
;    

(defconstant $kATSStyleNoHinting 1)
; 
;    * Specifies that ATS produce antialiased glyph images despite system
;    * preferences or CGContext settings.
;    

(defconstant $kATSStyleApplyAntiAliasing 2)
; 
;    * Specifies that ATS turn-off antialiasing glyph imaging despite
;    * system preferences or CGContext settings (negates
;    * kATSStyleApplyAntiAliasing bit if set).
;    

(defconstant $kATSStyleNoAntiAliasing 4)
; 
;    * These bits are reserved by Apple and will result in a invalid
;    * value error if attemped to set.
;    

(defconstant $kATSStyleAppleReserved #xFFFFFFF8)
; 
;    * (OBSOLETE) Specifies that ATS produce "hinted" glyph outlines (the
;    * default behavior). THIS NAME IS OBSOLETE. DO NOT USE. It's only
;    * left in for backwards compatibility.
;    

(defconstant $kATSStyleApplyHints 0)
;  --------------------------------------------------------------------------- 
; 
;  *  ATSGlyphInfoFlags
;  *  
;  *  Summary:
;  *    ATSGlyphInfoFlags are set in the individual ATSLayoutRecord
;  *    structures and apply only to the ATSGlyphRef in that structure.
;  *    The are used by the layout engine to flag a glyph with specific
;  *    properties.
;  

(def-mactype :ATSGlyphInfoFlags (find-mactype ':UInt32))
; 
;    * These bits are Apple reserved and may result in an invalid value
;    * error if attempted to set.
;    

(defconstant $kATSGlyphInfoAppleReserved #x1FFBFFE8)
; 
;    * The glyph attaches to another glyph.
;    

(defconstant $kATSGlyphInfoIsAttachment #x80000000)
; 
;    * The glyph can hang off left/top edge of line.
;    

(defconstant $kATSGlyphInfoIsLTHanger #x40000000)
; 
;    * The glyph can hang off right/bottom edge of line.
;    

(defconstant $kATSGlyphInfoIsRBHanger #x20000000)
; 
;    * The glyph is not really a glyph at all, but an end-marker designed
;    * to allow the calculation of the previous glyph's advance.
;    

(defconstant $kATSGlyphInfoTerminatorGlyph #x80000)
; 
;    * The glyph is a white space glyph.
;    

(defconstant $kATSGlyphInfoIsWhiteSpace #x40000)
; 
;    * Glyph has a style specified imposed width (i.e. advance)
;    

(defconstant $kATSGlyphInfoHasImposedWidth 16)
; 
;    * A three-bit mask, that can be used to get the size of the original
;    * character that spawned this glyph. When a logical 'and' operation
;    * with this mask and an ATSGlyphInfoFlags variable, it will yield
;    * the size in bytes of the original character (0 - 7 bytes possible).
;    

(defconstant $kATSGlyphInfoByteSizeMask 7)
;  --------------------------------------------------------------------------- 
;  STRUCTURED TYPES and related constants 
;  --------------------------------------------------------------------------- 
; 
;  *  ATSLayoutRecord
;  *  
;  *  Summary:
;  *    The ATSLayoutRecord structure defines all the needed info for a
;  *    single glyph during the layout process.  This struct must be
;  *    declared as the first element of an enclosing glyph record struct
;  *    defined by ATSUI DirectAccess clients.
;  
(defrecord ATSLayoutRecord
                                                ; 
;    * The glyph ID reference.
;    
   (glyphID :UInt16)
                                                ; 
;    * These flags describe the individual state of the glyph (see above).
;    
   (flags :UInt32)
                                                ; 
;    * The byte offset of the original character that spawned this glyph.
;    
   (originalOffset :UInt32)
                                                ; 
;    * This is the real position that the glyph sits.
;    
   (realPos :signed-long)
)

;type name? (%define-record :ATSLayoutRecord (find-record-descriptor ':ATSLayoutRecord))
;  --------------------------------------------------------------------------- 
; 
;  *  ATSTrapezoid
;  *  
;  *  Summary:
;  *    The ATSTrapezoid structure supplies a convenient container for
;  *    glyph bounds in trapezoidal form.
;  
(defrecord ATSTrapezoid
   (upperLeft :FixedPoint)
   (upperRight :FixedPoint)
   (lowerRight :FixedPoint)
   (lowerLeft :FixedPoint)
)

;type name? (%define-record :ATSTrapezoid (find-record-descriptor ':ATSTrapezoid))
;  --------------------------------------------------------------------------- 
; 
;  *  ATSJustWidthDeltaEntryOverride
;  *  
;  *  Summary:
;  *    The JustWidthDeltaEntryOverride structure specifies values for
;  *    the grow and shrink case during justification, both on the left
;  *    and on the right. It also contains flags.  This particular
;  *    structure is used for passing justification overrides to LLC. For
;  *    further sfnt resource 'just' table constants and structures, see
;  *    SFNTLayoutTypes.h.
;  
(defrecord ATSJustWidthDeltaEntryOverride
                                                ; 
;    * ems AW can grow by at most on LT
;    
   (beforeGrowLimit :signed-long)
                                                ; 
;    * ems AW can shrink by at most on LT
;    
   (beforeShrinkLimit :signed-long)
                                                ; 
;    * ems AW can grow by at most on RB
;    
   (afterGrowLimit :signed-long)
                                                ; 
;    * ems AW can shrink by at most on RB
;    
   (afterShrinkLimit :signed-long)
                                                ; 
;    * flags controlling grow case
;    
   (growFlags :UInt16)
                                                ; 
;    * flags controlling shrink case
;    
   (shrinkFlags :UInt16)
)

;type name? (%define-record :ATSJustWidthDeltaEntryOverride (find-record-descriptor ':ATSJustWidthDeltaEntryOverride))
;  The JustPriorityOverrides type is an array of 4 width delta records, one per priority level override. 
(defrecord ATSJustPriorityWidthDeltaOverrides
   (contents (:array :ATSJustWidthDeltaEntryOverride 4))
)                                               ;  ---------------------------------------------------------------------------- 
; 
;  *  ATSULineRef
;  *  
;  *  Summary:
;  *    A reference to a line that is being laid out. This is passed into
;  *    the ATSUDirectLayoutOperationOverrideUPP callback function to be
;  *    used by the ATSUDirectGetLayoutDataArrayPtrFromLineRef function.
;  *    The only way to get a line ref is inside of the callback. The
;  *    only time the line ref is valid is inside of the callback.
;  

(def-mactype :ATSULineRef (find-mactype '(:pointer :ATSGlyphVector)))
;  ---------------------------------------------------------------------------- 
;  DirectAccess Layout Callback Definitions                                     
;  ---------------------------------------------------------------------------- 
; 
;  *  ATSUDirectLayoutOperationOverrideProcPtr
;  *  
;  *  Summary:
;  *    Callback definition for a low-level adjustment routine hook.
;  *  
;  *  Discussion:
;  *    This callback can be set in an ATSUTextLayout object by setting
;  *    the attribute tag kATSULayoutOperationOverrideTag and passing in
;  *    a ATSULayoutOperationOverrideSpecifier structure into
;  *    ATSUSetLayoutAttribute. This callback will be called whenever an
;  *    ATSUI call triggers a re-layout for each operation it is
;  *    installed for. The operation that triggered the callback will be
;  *    set in the iCurrentOperation parameter. The callback function
;  *    defined by the developer is only required to do one thing: return
;  *    it's status to ATSUI as to what it has done. This is done via the
;  *    oCallbackStatus parameter. It needs to tell ATSUI if it had
;  *    handled the layout operation or if it still needs ATSUI to run
;  *    it's own processes. iOperationCallbackParameterPtr is there in
;  *    case there are ever any ATSUDirectLayoutOperationSelector which
;  *    require extra parameters to be passed into the callback function.
;  *    It is currently unused and will always be set to NULL. iRefCon is
;  *    the constant that is set in the ATSUTextLayout object that
;  *    spawned the operation by the ATSUSetTextLayoutRefCon() API.
;  *    Within the context of the callback itself, only a limited subset
;  *    of ATSUI APIs may be called. Basically, only the APIs that have
;  *    no chance of triggering a re-layout are allowed to be called. The
;  *    reason for this restriction is to prevent runaway recursion. Most
;  *    of the APIs that have "create", "get", or "copy" are safe. Any
;  *    attempt to call one of the restricted APIs will result in an
;  *    immediate return with the kATSUInvalidCallInsideCallbackErr
;  *    error. ATSULayoutOperationSelector and
;  *    ATSULayoutOperationCallbackStatus are defined in ATSLayoutTypes.i.
;  

(def-mactype :ATSUDirectLayoutOperationOverrideProcPtr (find-mactype ':pointer)); (ATSULayoutOperationSelector iCurrentOperation , ATSULineRef iLineRef , UInt32 iRefCon , void * iOperationCallbackParameterPtr , ATSULayoutOperationCallbackStatus * oCallbackStatus)

(def-mactype :ATSUDirectLayoutOperationOverrideUPP (find-mactype '(:pointer :OpaqueATSUDirectLayoutOperationOverrideProcPtr)))
; 
;  *  NewATSUDirectLayoutOperationOverrideUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewATSUDirectLayoutOperationOverrideUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueATSUDirectLayoutOperationOverrideProcPtr)
() )
; 
;  *  DisposeATSUDirectLayoutOperationOverrideUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeATSUDirectLayoutOperationOverrideUPP" 
   ((userUPP (:pointer :OpaqueATSUDirectLayoutOperationOverrideProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  InvokeATSUDirectLayoutOperationOverrideUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeATSUDirectLayoutOperationOverrideUPP" 
   ((iCurrentOperation :UInt32)
    (iLineRef (:pointer :ATSGlyphVector))
    (iRefCon :UInt32)
    (iOperationCallbackParameterPtr :pointer)
    (oCallbackStatus (:pointer :ATSULAYOUTOPERATIONCALLBACKSTATUS))
    (userUPP (:pointer :OpaqueATSUDirectLayoutOperationOverrideProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
;  ---------------------------------------------------------------------------- 
; 
;  *  ATSULayoutOperationOverrideSpecifier
;  *  
;  *  Summary:
;  *    This structure is used to install a callback for one or more
;  *    ATSUI operations. To do this, simply passed one of these
;  *    structure into the ATSUSetLayoutControls call with the
;  *    kATSULayoutOperationOverrideTag tag.
;  
(defrecord ATSULayoutOperationOverrideSpecifier
                                                ; 
;    * A bitfield containing the selector for the operations in which the
;    * callback will be installed for.
;    
   (operationSelector :UInt32)
   (overrideUPP (:pointer :OpaqueATSUDirectLayoutOperationOverrideProcPtr))
)

;type name? (%define-record :ATSULayoutOperationOverrideSpecifier (find-record-descriptor ':ATSULayoutOperationOverrideSpecifier))
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __ATSLAYOUTTYPES__ */


(provide-interface "ATSLayoutTypes")