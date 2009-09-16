(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ATSUnicodeGlyphs.h"
; at Sunday July 2,2006 7:24:36 pm.
; 
;      File:       QD/ATSUnicodeGlyphs.h
;  
;      Contains:   ATSUI glyph handling functions.
;  
;      Version:    Quickdraw-150~1
;  
;      Copyright:  © 2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __ATSUNICODEGLYPHS__
; #define __ATSUNICODEGLYPHS__
; #ifndef __ATSUNICODETYPES__
#| #|
#include <QDATSUnicodeTypes.h>
#endif
|#
 |#
;  ---------------------------------------------------------------------------- 
;  ATSUI glyph metrics                                                          
;  ---------------------------------------------------------------------------- 

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
; 
;  *  ATSUGlyphGetIdealMetrics()
;  *  
;  *  Summary:
;  *    Obtains resolution-independent font metric information for glyphs
;  *    associated with a given style object.
;  *  
;  *  Discussion:
;  *    The advance width is the full horizontal width of the glyph as
;  *    measured from its origin to the origin of the next glyph on the
;  *    line, including the left-side and right-side bearings. For
;  *    vertical text, the advance height is the sum of the top-side
;  *    bearing, the bounding-box height, and the bottom-side bearing.
;  *    You can call the ATSUGlyphGetIdealMetrics function to obtain an
;  *    array of ATSGlyphIdealMetrics structures containing values for
;  *    the specified glyphs' advance and side bearings.
;  *    ATSUGlyphGetIdealMetrics can analyze both horizontal and vertical
;  *    text, automatically producing the appropriate bearing values
;  *    (oriented for width or height, respectively) for each. You should
;  *    call ATSUGlyphGetIdealMetrics to obtain resolution-independent
;  *    glyph metrics. To obtain device-adjusted (that is,
;  *    resolution-dependent) glyph metrics, call the function
;  *    ATSUGlyphGetScreenMetrics.
;  *  
;  *  Parameters:
;  *    
;  *    iATSUStyle:
;  *      A style referring to a font you wish to obtain glyph metrics
;  *      from.
;  *    
;  *    iNumOfGlyphs:
;  *      The number of glyph IDs you are passing in to be examined. This
;  *      value should be equal to the size of the array you are passing
;  *      in for the iGlyphIDs parameter.
;  *    
;  *    iGlyphIDs:
;  *      An array of glyph IDs referring to glyphs for which you wish to
;  *      obtain metrics.
;  *    
;  *    iInputOffset:
;  *      A ByteOffset value specifying the offset in bytes between glyph
;  *      IDs in the iGlyphIDs array.
;  *    
;  *    oIdealMetrics:
;  *      A pointer to memory you have allocated for an array of
;  *      ATSGlyphIdealMetrics structures. On return, each structure
;  *      contains advance and side-bearing values for a glyph. See
;  *      ATSTypes.h for more information regarding the
;  *      ATSGlyphIdealMetrics structure.
;  *  
;  *  Result:
;  *    On success, noErr is returned. See MacErrors.h for possible error
;  *    codes.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
;  

(deftrap-inline "_ATSUGlyphGetIdealMetrics" 
   ((iATSUStyle (:pointer :OpaqueATSUStyle))
    (iNumOfGlyphs :UInt32)
    (iGlyphIDs (:pointer :GLYPHID))
    (iInputOffset :UInt32)
    (oIdealMetrics (:pointer :ATSGlyphIdealMetrics))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSUGlyphGetScreenMetrics()
;  *  
;  *  Summary:
;  *    Obtains device-adjusted font metric information for glyphs
;  *    associated with a given style object.
;  *  
;  *  Discussion:
;  *    You can call the ATSUGlyphGetScreenMetrics function to obtain an
;  *    array of ATSGlyphScreenMetrics structures containing values for
;  *    the specified glyphs' advance and side bearings, top left,
;  *    height, and width. You should call ATSUGlyphGetScreenMetrics to
;  *    obtain device-adjusted (that is, resolution-dependent) glyph
;  *    metrics. To obtain resolution-independent glyph metrics, call the
;  *    function ATSUGlyphGetIdealMetrics.
;  *  
;  *  Parameters:
;  *    
;  *    iATSUStyle:
;  *      A style referring to a font you wish to obtain glyph metrics
;  *      from.
;  *    
;  *    iNumOfGlyphs:
;  *      The number of glyph IDs you are passing in to be examined. This
;  *      value should be equal to the size of the array you are passing
;  *      in for the iGlyphIDs parameter.
;  *    
;  *    iGlyphIDs:
;  *      An array of glyph IDs referring to glyphs for which you wish to
;  *      obtain metrics.
;  *    
;  *    iInputOffset:
;  *      A ByteOffset value specifying the offset in bytes between glyph
;  *      IDs in the iGlyphIDs array.
;  *    
;  *    iForcingAntiAlias:
;  *      A Boolean value indicating whether anti-aliasing is forced for
;  *      the style object.
;  *    
;  *    iAntiAliasSwitch:
;  *      A Boolean value indicating whether anti-aliasing is currently
;  *      on or off.
;  *    
;  *    oScreenMetrics:
;  *      A pointer to memory you have allocated for an array of
;  *      ATSGlyphScreenMetrics structures. On return, each structure
;  *      contains advance and side-bearing values for a glyph. See
;  *      ATSTypes.h for more information regarding the
;  *      ATSGlyphScreenMetrics structure.
;  *  
;  *  Result:
;  *    On success, noErr is returned. See MacErrors.h for possible error
;  *    codes.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
;  

(deftrap-inline "_ATSUGlyphGetScreenMetrics" 
   ((iATSUStyle (:pointer :OpaqueATSUStyle))
    (iNumOfGlyphs :UInt32)
    (iGlyphIDs (:pointer :GLYPHID))
    (iInputOffset :UInt32)
    (iForcingAntiAlias :Boolean)
    (iAntiAliasSwitch :Boolean)
    (oScreenMetrics (:pointer :ATSGlyphScreenMetrics))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  ---------------------------------------------------------------------------- 
;  ATSUI glyph curve access functions and callbacks                             
;  ---------------------------------------------------------------------------- 
; 
;  *  ATSUGetNativeCurveType()
;  *  
;  *  Summary:
;  *    Returns the native curve format for a specific font.
;  *  
;  *  Discussion:
;  *    Use this function to decide whether to call
;  *    ATSUGlyphGetQuadraticPaths or ATSUGlyphGetCubicPaths. Both
;  *    functions will return curves for all valid ATSUI fonts, but if
;  *    the curve type you request is not the native curve type of the
;  *    font, the curves you get back will be mathematically converted,
;  *    rather than native font data. See the definition of ATSCurveType
;  *    in ATSTypes.h for possible return values from this function.
;  *  
;  *  Parameters:
;  *    
;  *    iATSUStyle:
;  *      A style referencing a font for which you wish to obtain the
;  *      native curve type.
;  *    
;  *    oCurveType:
;  *      On return, a value indicating the native curve type of the font
;  *      referenced by iATSUStyle. See the definition of ATSCurveType in
;  *      ATSTypes.h for a list of possible return values for this
;  *      parameter.
;  *  
;  *  Result:
;  *    On success, noErr is returned. See MacErrors.h for possible error
;  *    codes.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
;  

(deftrap-inline "_ATSUGetNativeCurveType" 
   ((iATSUStyle (:pointer :OpaqueATSUStyle))
    (oCurveType (:pointer :ATSCURVETYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSQuadraticNewPathProcPtr
;  *  
;  *  Discussion:
;  *    A pointer to a client supplied callback function for handling
;  *    glyph curve drawing operations. This callback handles operations
;  *    to start a new drawing path.
;  *  
;  *  Parameters:
;  *    
;  *    callBackDataPtr:
;  *      A pointer to any application specific data that may have been
;  *      passed to the callbacks through the iCallbackDataPtr parameter
;  *      of the ATSUGlyphGetQuadraticPaths function.
;  *  
;  *  Result:
;  *    Return status. Pass any errors you wish to propagate back to the
;  *    original caller of ATSUGlyphGetQuadraticPaths through this return
;  *    value. Note that any nonzero result from this callback will halt
;  *    the curve drawing process.
;  

(def-mactype :ATSQuadraticNewPathProcPtr (find-mactype ':pointer)); (void * callBackDataPtr)

(def-mactype :ATSQuadraticNewPathUPP (find-mactype '(:pointer :OpaqueATSQuadraticNewPathProcPtr)))
; 
;  *  NewATSQuadraticNewPathUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewATSQuadraticNewPathUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueATSQuadraticNewPathProcPtr)
() )
; 
;  *  DisposeATSQuadraticNewPathUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeATSQuadraticNewPathUPP" 
   ((userUPP (:pointer :OpaqueATSQuadraticNewPathProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeATSQuadraticNewPathUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeATSQuadraticNewPathUPP" 
   ((callBackDataPtr :pointer)
    (userUPP (:pointer :OpaqueATSQuadraticNewPathProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSQuadraticLineProcPtr
;  *  
;  *  Discussion:
;  *    A pointer to a client supplied callback function for handling
;  *    glyph curve drawing operations. This callback handles operations
;  *    to draw straight lines.
;  *  
;  *  Parameters:
;  *    
;  *    pt1:
;  *      The starting point of the line.
;  *    
;  *    pt2:
;  *      The end point of the line.
;  *    
;  *    callBackDataPtr:
;  *      A pointer to any application specific data that may have been
;  *      passed to the callbacks through the iCallbackDataPtr parameter
;  *      of the ATSUGlyphGetQuadraticPaths function.
;  *  
;  *  Result:
;  *    Return status. Pass any errors you wish to propagate back to the
;  *    original caller of ATSUGlyphGetQuadraticPaths through this return
;  *    value. Note that any nonzero result from this callback will halt
;  *    the curve drawing process.
;  

(def-mactype :ATSQuadraticLineProcPtr (find-mactype ':pointer)); (const Float32Point * pt1 , const Float32Point * pt2 , void * callBackDataPtr)

(def-mactype :ATSQuadraticLineUPP (find-mactype '(:pointer :OpaqueATSQuadraticLineProcPtr)))
; 
;  *  NewATSQuadraticLineUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewATSQuadraticLineUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueATSQuadraticLineProcPtr)
() )
; 
;  *  DisposeATSQuadraticLineUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeATSQuadraticLineUPP" 
   ((userUPP (:pointer :OpaqueATSQuadraticLineProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeATSQuadraticLineUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeATSQuadraticLineUPP" 
   ((pt1 (:pointer :Float32Point))
    (pt2 (:pointer :Float32Point))
    (callBackDataPtr :pointer)
    (userUPP (:pointer :OpaqueATSQuadraticLineProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSQuadraticCurveProcPtr
;  *  
;  *  Discussion:
;  *    A pointer to a client supplied callback function for handling
;  *    glyph curve drawing operations. This callback handles operations
;  *    to draw curves. The curve is a quadratic patch specified by a
;  *    start point (pt1), and end point (pt2), and a single control
;  *    point (controlPt).
;  *  
;  *  Parameters:
;  *    
;  *    pt1:
;  *      The starting point of the curve.
;  *    
;  *    controlPt:
;  *      The off-curve control point.
;  *    
;  *    pt2:
;  *      The end point of the curve.
;  *    
;  *    callBackDataPtr:
;  *      A pointer to any application specific data that may have been
;  *      passed to the callbacks through the iCallbackDataPtr parameter
;  *      of the ATSUGlyphGetQuadraticPaths function.
;  *  
;  *  Result:
;  *    Return status. Pass any errors you wish to propagate back to the
;  *    original caller of ATSUGlyphGetQuadraticPaths through this return
;  *    value. Note that any nonzero result from this callback will halt
;  *    the curve drawing process.
;  

(def-mactype :ATSQuadraticCurveProcPtr (find-mactype ':pointer)); (const Float32Point * pt1 , const Float32Point * controlPt , const Float32Point * pt2 , void * callBackDataPtr)

(def-mactype :ATSQuadraticCurveUPP (find-mactype '(:pointer :OpaqueATSQuadraticCurveProcPtr)))
; 
;  *  NewATSQuadraticCurveUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewATSQuadraticCurveUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueATSQuadraticCurveProcPtr)
() )
; 
;  *  DisposeATSQuadraticCurveUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeATSQuadraticCurveUPP" 
   ((userUPP (:pointer :OpaqueATSQuadraticCurveProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeATSQuadraticCurveUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeATSQuadraticCurveUPP" 
   ((pt1 (:pointer :Float32Point))
    (controlPt (:pointer :Float32Point))
    (pt2 (:pointer :Float32Point))
    (callBackDataPtr :pointer)
    (userUPP (:pointer :OpaqueATSQuadraticCurveProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSQuadraticClosePathProcPtr
;  *  
;  *  Discussion:
;  *    A pointer to a client supplied callback function for handling
;  *    glyph curve drawing operations. This callback handles operations
;  *    to close the current drawing path.
;  *  
;  *  Parameters:
;  *    
;  *    callBackDataPtr:
;  *      A pointer to any application specific data that may have been
;  *      passed to the callbacks through the iCallbackDataPtr parameter
;  *      of the ATSUGlyphGetQuadraticPaths function.
;  *  
;  *  Result:
;  *    Return status. Pass any errors you wish to propagate back to the
;  *    original caller of ATSUGlyphGetQuadraticPaths through this return
;  *    value. Note that any nonzero result from this callback will halt
;  *    the curve drawing process.
;  

(def-mactype :ATSQuadraticClosePathProcPtr (find-mactype ':pointer)); (void * callBackDataPtr)

(def-mactype :ATSQuadraticClosePathUPP (find-mactype '(:pointer :OpaqueATSQuadraticClosePathProcPtr)))
; 
;  *  NewATSQuadraticClosePathUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewATSQuadraticClosePathUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueATSQuadraticClosePathProcPtr)
() )
; 
;  *  DisposeATSQuadraticClosePathUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeATSQuadraticClosePathUPP" 
   ((userUPP (:pointer :OpaqueATSQuadraticClosePathProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeATSQuadraticClosePathUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeATSQuadraticClosePathUPP" 
   ((callBackDataPtr :pointer)
    (userUPP (:pointer :OpaqueATSQuadraticClosePathProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSUGlyphGetQuadraticPaths()
;  *  
;  *  Summary:
;  *    Uses a callback mechanism to obtain a set of Quadratic outlines
;  *    for a specified glyph in a specified font.
;  *  
;  *  Discussion:
;  *    This function will allow you to use callbacks to obtain the exact
;  *    outline of a specified glyph, in quadratic form. Although this
;  *    function will always return results for any valid ATSUI font, you
;  *    should first use the function ATSUGetNativeCurveType to determine
;  *    the native format of the glyph you are interested in. Then,
;  *    either call ATSUGlyphGetQuadraticPaths or ATSUGlyphGetCubicPaths
;  *    based on the result. Otherwise, you may end up with curves that
;  *    are mathematically converted from cubic to quadratic (or vice
;  *    versa), instead of getting native font data. See the definitions
;  *    of ATSQuadraticNewPathProcPtr, ATSQuadraticLineProcPtr,
;  *    ATSQuadraticCurveProcPtr, and ATSQuadraticClosePathProcPtr for
;  *    more information about setting up the callbacks.
;  *  
;  *  Parameters:
;  *    
;  *    iATSUStyle:
;  *      A style referring to a font you wish to obtain a set of glyph
;  *      outlines from.
;  *    
;  *    iGlyphID:
;  *      A ID number referring to the glyph for which you wish to obtain
;  *      outline data. Use the ATSUI direct access functions in
;  *      ATSUnicodeDirectAccess.h to obtain values to pass for this
;  *      parameter.
;  *    
;  *    iNewPathProc:
;  *      A pointer to a callback function for quadratic new path
;  *      operations. See the definition of ATSQuadraticNewPathProcPtr
;  *      for more information about creating, disposing, and invoking
;  *      this type of Universal Procedure Pointer.
;  *    
;  *    iLineProc:
;  *      A pointer to a callback function for quadratic LineTo
;  *      operations. See the definition of ATSQuadraticLineProcPtr for
;  *      more information about creating, disposing, and invoking this
;  *      type of Universal Procedure Pointer.
;  *    
;  *    iCurveProc:
;  *      A pointer to a callback function for quadratic curve
;  *      operations. See the definition of ATSQuadraticCurveProcPtr for
;  *      more information about creating, disposing, and invoking this
;  *      type of Universal Procedure Pointer.
;  *    
;  *    iClosePathProc:
;  *      A pointer to a callback function for quadratic close path
;  *      operations. See the definition of ATSQuadraticClosePathProcPtr
;  *      for more information about creating, disposing, and invoking
;  *      this type of Universal Procedure Pointer.
;  *    
;  *    iCallbackDataPtr:
;  *      Any valid pointer. Any application specific data you wish to
;  *      pass to your callbacks may be sent through this parameter.
;  *    
;  *    oCallbackResult:
;  *      On return, status returned by callback functions. If an error
;  *      occurs, callbacks may communicate it through this parameter.
;  *  
;  *  Result:
;  *    On success, noErr is returned. See MacErrors.h for possible error
;  *    codes.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
;  

(deftrap-inline "_ATSUGlyphGetQuadraticPaths" 
   ((iATSUStyle (:pointer :OpaqueATSUStyle))
    (iGlyphID :UInt16)
    (iNewPathProc (:pointer :OpaqueATSQuadraticNewPathProcPtr))
    (iLineProc (:pointer :OpaqueATSQuadraticLineProcPtr))
    (iCurveProc (:pointer :OpaqueATSQuadraticCurveProcPtr))
    (iClosePathProc (:pointer :OpaqueATSQuadraticClosePathProcPtr))
    (iCallbackDataPtr :pointer)
    (oCallbackResult (:pointer :OSStatus))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSCubicMoveToProcPtr
;  *  
;  *  Discussion:
;  *    A pointer to a client supplied callback function for handling
;  *    glyph curve drawing operations. This callback handles operations
;  *    to move the current pen location.
;  *  
;  *  Parameters:
;  *    
;  *    pt:
;  *      The point to which to move the current pen location.
;  *    
;  *    callBackDataPtr:
;  *      A pointer to any application specific data that may have been
;  *      passed to the callbacks through the iCallbackDataPtr parameter
;  *      of the ATSUGlyphGetCubicPaths function.
;  *  
;  *  Result:
;  *    Return status. Pass any errors you wish to propagate back to the
;  *    original caller of ATSUGlyphGetCubicPaths through this return
;  *    value. Note that any nonzero result from this callback will halt
;  *    the curve drawing process.
;  

(def-mactype :ATSCubicMoveToProcPtr (find-mactype ':pointer)); (const Float32Point * pt , void * callBackDataPtr)

(def-mactype :ATSCubicMoveToUPP (find-mactype '(:pointer :OpaqueATSCubicMoveToProcPtr)))
; 
;  *  NewATSCubicMoveToUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewATSCubicMoveToUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueATSCubicMoveToProcPtr)
() )
; 
;  *  DisposeATSCubicMoveToUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeATSCubicMoveToUPP" 
   ((userUPP (:pointer :OpaqueATSCubicMoveToProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeATSCubicMoveToUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeATSCubicMoveToUPP" 
   ((pt (:pointer :Float32Point))
    (callBackDataPtr :pointer)
    (userUPP (:pointer :OpaqueATSCubicMoveToProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSCubicLineToProcPtr
;  *  
;  *  Discussion:
;  *    A pointer to a client supplied callback function for handling
;  *    glyph curve drawing operations. This callback handles operations
;  *    to draw straight lines.
;  *  
;  *  Parameters:
;  *    
;  *    pt:
;  *      The end point of the line to be drawn. The starting point is
;  *      whatever the current pen position is.
;  *    
;  *    callBackDataPtr:
;  *      A pointer to any application specific data that may have been
;  *      passed to the callbacks through the iCallbackDataPtr parameter
;  *      of the ATSUGlyphGetCubicPaths function.
;  *  
;  *  Result:
;  *    Return status. Pass any errors you wish to propagate back to the
;  *    original caller of ATSUGlyphGetCubicPaths through this return
;  *    value. Note that any nonzero result from this callback will halt
;  *    the curve drawing process.
;  

(def-mactype :ATSCubicLineToProcPtr (find-mactype ':pointer)); (const Float32Point * pt , void * callBackDataPtr)

(def-mactype :ATSCubicLineToUPP (find-mactype '(:pointer :OpaqueATSCubicLineToProcPtr)))
; 
;  *  NewATSCubicLineToUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewATSCubicLineToUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueATSCubicLineToProcPtr)
() )
; 
;  *  DisposeATSCubicLineToUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeATSCubicLineToUPP" 
   ((userUPP (:pointer :OpaqueATSCubicLineToProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeATSCubicLineToUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeATSCubicLineToUPP" 
   ((pt (:pointer :Float32Point))
    (callBackDataPtr :pointer)
    (userUPP (:pointer :OpaqueATSCubicLineToProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSCubicCurveToProcPtr
;  *  
;  *  Discussion:
;  *    A pointer to a client supplied callback function for handling
;  *    glyph curve drawing operations. This callback handles operations
;  *    to draw a curve. The curve is a Bezier patch defined by two
;  *    off-curve control points (pt1 and pt2), and an endpoint (pt3).
;  *    The starting point is whatever the current pen position is.
;  *  
;  *  Parameters:
;  *    
;  *    pt1:
;  *      The first off-curve control point.
;  *    
;  *    pt2:
;  *      The second off-curve control point.
;  *    
;  *    pt3:
;  *      The end point of the curve.
;  *    
;  *    callBackDataPtr:
;  *      A pointer to any application specific data that may have been
;  *      passed to the callbacks through the iCallbackDataPtr parameter
;  *      of the ATSUGlyphGetCubicPaths function.
;  *  
;  *  Result:
;  *    Return status. Pass any errors you wish to propagate back to the
;  *    original caller of ATSUGlyphGetCubicPaths through this return
;  *    value. Note that any nonzero result from this callback will halt
;  *    the curve drawing process.
;  

(def-mactype :ATSCubicCurveToProcPtr (find-mactype ':pointer)); (const Float32Point * pt1 , const Float32Point * pt2 , const Float32Point * pt3 , void * callBackDataPtr)

(def-mactype :ATSCubicCurveToUPP (find-mactype '(:pointer :OpaqueATSCubicCurveToProcPtr)))
; 
;  *  NewATSCubicCurveToUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewATSCubicCurveToUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueATSCubicCurveToProcPtr)
() )
; 
;  *  DisposeATSCubicCurveToUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeATSCubicCurveToUPP" 
   ((userUPP (:pointer :OpaqueATSCubicCurveToProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeATSCubicCurveToUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeATSCubicCurveToUPP" 
   ((pt1 (:pointer :Float32Point))
    (pt2 (:pointer :Float32Point))
    (pt3 (:pointer :Float32Point))
    (callBackDataPtr :pointer)
    (userUPP (:pointer :OpaqueATSCubicCurveToProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSCubicClosePathProcPtr
;  *  
;  *  Discussion:
;  *    A pointer to a client supplied callback function for handling
;  *    glyph curve drawing operations. This callback handles operations
;  *    to close the current drawing path.
;  *  
;  *  Parameters:
;  *    
;  *    callBackDataPtr:
;  *      A pointer to any application specific data that may have been
;  *      passed to the callbacks through the iCallbackDataPtr parameter
;  *      of the ATSUGlyphGetCubicPaths function.
;  *  
;  *  Result:
;  *    Return status. Pass any errors you wish to propagate back to the
;  *    original caller of ATSUGlyphGetCubicPaths through this return
;  *    value. Note that any nonzero result from this callback will halt
;  *    the curve drawing process.
;  

(def-mactype :ATSCubicClosePathProcPtr (find-mactype ':pointer)); (void * callBackDataPtr)

(def-mactype :ATSCubicClosePathUPP (find-mactype '(:pointer :OpaqueATSCubicClosePathProcPtr)))
; 
;  *  NewATSCubicClosePathUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewATSCubicClosePathUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueATSCubicClosePathProcPtr)
() )
; 
;  *  DisposeATSCubicClosePathUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeATSCubicClosePathUPP" 
   ((userUPP (:pointer :OpaqueATSCubicClosePathProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeATSCubicClosePathUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeATSCubicClosePathUPP" 
   ((callBackDataPtr :pointer)
    (userUPP (:pointer :OpaqueATSCubicClosePathProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSUGlyphGetCubicPaths()
;  *  
;  *  Summary:
;  *    Uses a callback mechanism to obtain a set of Cubic outlines for a
;  *    specified glyph in a specified font.
;  *  
;  *  Discussion:
;  *    This function will allow you to use callbacks to obtain the exact
;  *    outline of a specified glyph, in cubic form. Although this
;  *    function will always return results for any valid ATSUI font, you
;  *    should first use the function ATSUGetNativeCurveType to determine
;  *    the native format of the glyph you are interested in. Then,
;  *    either call ATSUGlyphGetQuadraticPaths or ATSUGlyphGetCubicPaths
;  *    based on the result. Otherwise, you may end up with curves that
;  *    are mathematically converted from quadratic to cubic (or vice
;  *    versa), instead of getting native font data. See the definitions
;  *    of ATSCubicMoveToProcPtr, ATSCubicLineToProcPtr,
;  *    ATSCubicCurveToProcPtr, and ATSCubicClosePathProcPtr for more
;  *    information about setting up the callbacks.
;  *  
;  *  Parameters:
;  *    
;  *    iATSUStyle:
;  *      A style referring to a font you wish to obtain a set of glyph
;  *      outlines from.
;  *    
;  *    iGlyphID:
;  *      A ID number referring to the glyph for which you wish to obtain
;  *      outline data. Use the ATSUI direct access functions in
;  *      ATSUnicodeDirectAccess.h to obtain values to pass for this
;  *      parameter.
;  *    
;  *    iMoveToProc:
;  *      A pointer to a callback function for cubic MoveTo operations.
;  *      See the definition of ATSCubicMoveToProcPtr for more
;  *      information about creating, disposing, and invoking this type
;  *      of Universal Procedure Pointer.
;  *    
;  *    iLineToProc:
;  *      A pointer to a callback function for cubic LineTo operations.
;  *      See the definition of ATSCubicLineToProcPtr for more
;  *      information about creating, disposing, and invoking this type
;  *      of Universal Procedure Pointer.
;  *    
;  *    iCurveToProc:
;  *      A pointer to a callback function for cubic CurveTo operations.
;  *      See the definition of ATSCubicCurveToProcPtr for more
;  *      information about creating, disposing, and invoking this type
;  *      of Universal Procedure Pointer.
;  *    
;  *    iClosePathProc:
;  *      A pointer to a callback function for cubic MoveTo operations.
;  *      See the definition of ATSCubicClosePathProcPtr for more
;  *      information about creating, disposing, and invoking this type
;  *      of Universal Procedure Pointer.
;  *    
;  *    iCallbackDataPtr:
;  *      Any valid pointer. Any application specific data you wish to
;  *      pass to your callbacks may be sent through this parameter.
;  *    
;  *    oCallbackResult:
;  *      On return, status returned by callback functions. If an error
;  *      occurs, callbacks may communicate it through this parameter.
;  *  
;  *  Result:
;  *    On success, noErr is returned. See MacErrors.h for possible error
;  *    codes.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
;  

(deftrap-inline "_ATSUGlyphGetCubicPaths" 
   ((iATSUStyle (:pointer :OpaqueATSUStyle))
    (iGlyphID :UInt16)
    (iMoveToProc (:pointer :OpaqueATSCubicMoveToProcPtr))
    (iLineToProc (:pointer :OpaqueATSCubicLineToProcPtr))
    (iCurveToProc (:pointer :OpaqueATSCubicCurveToProcPtr))
    (iClosePathProc (:pointer :OpaqueATSCubicClosePathProcPtr))
    (iCallbackDataPtr :pointer)                 ;  can be NULL 
    (oCallbackResult (:pointer :OSStatus))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSUGlyphGetCurvePaths()
;  *  
;  *  Summary:
;  *    Obtains glyph curve data without the use of callbacks.
;  *  
;  *  Discussion:
;  *    This function will return glyph curve data in a single data
;  *    structure rather than through the use of callbacks, but you must
;  *    parse the data structure yourself. ATSUGlyphGetCubicPaths and
;  *    ATSUGlyphGetQuadraticPaths will parse the glyph data for you and
;  *    use the callbacks you provide them to give you access to the
;  *    individual points on the curves. Typically you use the function
;  *    ATSUGlyphGetCurvePaths by calling it twice, as follows: (1) Pass
;  *    a valid style and glyphID into the iATSUStyle and iGlyphID
;  *    parameters, respectively, 0 for the ioBufferSize parameter, and
;  *    NULL for the oPaths parameter. ATSUGlyphGetCurvePaths returns the
;  *    size to use for the oPaths array in the ioBufferSize parameter.
;  *    (2) Allocate enough space an array of the returned size, then
;  *    call the ATSUGlyphGetCurvePaths again, passing a pointer to the
;  *    array in the oPaths parameter. On return, the array contains the
;  *    glyph outline data.
;  *  
;  *  Parameters:
;  *    
;  *    iATSUStyle:
;  *      A style referring to a font you wish to obtain a set of glyph
;  *      outlines from.
;  *    
;  *    iGlyphID:
;  *      A ID number referring to the glyph for which you wish to obtain
;  *      outline data. Use the ATSUI direct access functions in
;  *      ATSUnicodeDirectAccess.h to obtain values to pass for this
;  *      parameter.
;  *    
;  *    ioBufferSize:
;  *      On input, the size of the buffer you have allocated for the
;  *      oPaths parameter. On return, the actual size of the data
;  *      structure that has been copied into the oPaths parameter.
;  *    
;  *    oPaths:
;  *      On return, a data structure containing glyph outline
;  *      information. See ATSTypes.h for a definition of this data
;  *      structure.
;  *  
;  *  Result:
;  *    On success, noErr is returned. See MacErrors.h for possible error
;  *    codes.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
;  

(deftrap-inline "_ATSUGlyphGetCurvePaths" 
   ((iATSUStyle (:pointer :OpaqueATSUStyle))
    (iGlyphID :UInt16)
    (ioBufferSize (:pointer :ByteCount))
    (oPaths (:pointer :ATSUCurvePaths))         ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Functions listed beyond this point are either deprecated or not recommended 
;  ---------------------------------------------------------------------------- 
;  ATSUI glyphInfo access (deprecated)                                          
;  ---------------------------------------------------------------------------- 
; 
;  *  ATSUGetGlyphInfo()
;  *  
;  *  Summary:
;  *    Obtains a copy of the style and layout information for each glyph
;  *    in a line.
;  *  
;  *  Discussion:
;  *    Please see ATSUnicodeDirectAccess.h for replacement functions.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
;  

(deftrap-inline "_ATSUGetGlyphInfo" 
   ((iTextLayout (:pointer :OpaqueATSUTextLayout))
    (iLineStart :UInt32)
    (iLineLength :UInt32)
    (ioBufferSize (:pointer :ByteCount))
    (oGlyphInfoPtr (:pointer :ATSUGlyphInfoArray))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ATSUDrawGlyphInfo()
;  *  
;  *  Summary:
;  *    Draws glyphs at the specified location, based on style and layout
;  *    information specified for each glyph.
;  *  
;  *  Discussion:
;  *    Please see ATSUnicodeDirectAccess.h for replacement functions.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
;  

(deftrap-inline "_ATSUDrawGlyphInfo" 
   ((iGlyphInfoArray (:pointer :ATSUGlyphInfoArray))
    (x :single-float)
    (y :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __ATSUNICODEGLYPHS__ */


(provide-interface "ATSUnicodeGlyphs")