(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:HIShape.h"
; at Sunday July 2,2006 7:24:58 pm.
; 
;      File:       HIToolbox/HIShape.h
;  
;      Contains:   Generic Abstract Shape API
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 2001-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __HISHAPE__
; #define __HISHAPE__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __CARBONEVENTS__
#| #|
#include <HIToolboxCarbonEvents.h>
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
; 
;  *  HIShape
;  *  
;  *  Discussion:
;  *    HIShape is an abstract shape object for use with some of the
;  *    HIToolbox APIs. It is designed as a replacement for RgnHandles
;  *    (though it is currently implemented in terms of them at the time
;  *    of this writing). This abstraction will allow us to avoid using
;  *    QD types in our APIs, particularly in HIView. 
;  *    
;  *    One of the biggest benefits of HIShape is that we have mutable
;  *    and immutable variants. This means that immutable shapes can be
;  *    created and passed around and 'copied' very quickly, since they
;  *    are actually refcounted when copied. This avoids needing to do
;  *    the handle-to-handle copies that occur right now with
;  *    RgnHandle-based APIs. 
;  *    
;  *    IMPORTANT: Unfortunately, this header is somewhat useless in Mac
;  *    OS X 10.2. We did not get to use HIShapeRefs anywhere in our
;  *    HIView APIs, yet it was too late to pull this header for fear of
;  *    breakage. So look at this header as a kind of sneak peek. You can
;  *    use this APIs to start using HIShapeRefs in your own code if you
;  *    wish though. When the Toolbox starts to use this in future
;  *    releases, you will be able to pass your HIShapeRefs directly into
;  *    APIs as you'd expect.
;  

(def-mactype :HIShapeRef (find-mactype '(:pointer :__HIShape)))

(def-mactype :HIMutableShapeRef (find-mactype '(:pointer :__HIShape)))
; 
;  *  HIShapeGetTypeID()
;  *  
;  *  Discussion:
;  *    Returns the CF type ID for the HIShape class.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Result:
;  *    A CF type ID.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )
; ======================================================================================
;   IMMUTABLE FUNCTIONS                                                                 
; ======================================================================================
; 
;  *  HIShapeCreateWithQDRgn()
;  *  
;  *  Discussion:
;  *    Creates an immutable shape based on an existing Quickdraw region
;  *    handle.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRgn:
;  *      The Quickdraw region from which to create the HIShape.
;  *  
;  *  Result:
;  *    An immutable HIShape reference.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeCreateWithQDRgn" 
   ((inRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__HIShape)
() )
; 
;  *  HIShapeCreateWithRect()
;  *  
;  *  Discussion:
;  *    Creates an immutable, rectangular shape based on a given
;  *    rectangle.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inRect:
;  *      The HIRect from which to create the resulting shape.
;  *  
;  *  Result:
;  *    An immutable HIShape reference.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeCreateWithRect" 
   ((inRect (:pointer :HIRECT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__HIShape)
() )
; 
;  *  HIShapeCreateCopy()
;  *  
;  *  Discussion:
;  *    Creates an immutable copy of a mutable or immutable HIShape.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape:
;  *      The existing HIShapeRef you wish to copy.
;  *  
;  *  Result:
;  *    An immutable HIShape reference.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeCreateCopy" 
   ((inShape (:pointer :__HIShape))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__HIShape)
() )
; 
;  *  HIShapeCreateIntersection()
;  *  
;  *  Discussion:
;  *    Creates a new immutable shape which is the intersection of two
;  *    others.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape1:
;  *      An existing HIShapeRef.
;  *    
;  *    inShape2:
;  *      An existing HIShapeRef.
;  *  
;  *  Result:
;  *    A new immutable HIShapeRef.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeCreateIntersection" 
   ((inShape1 (:pointer :__HIShape))
    (inShape2 (:pointer :__HIShape))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__HIShape)
() )
; 
;  *  HIShapeCreateDifference()
;  *  
;  *  Discussion:
;  *    Creates a new immutable shape which is the difference of two
;  *    others. The second shape is subtracted from the first.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape1:
;  *      An existing HIShapeRef.
;  *    
;  *    inShape2:
;  *      An existing HIShapeRef.
;  *  
;  *  Result:
;  *    A new immutable HIShapeRef.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeCreateDifference" 
   ((inShape1 (:pointer :__HIShape))
    (inShape2 (:pointer :__HIShape))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__HIShape)
() )
; 
;  *  HIShapeCreateUnion()
;  *  
;  *  Discussion:
;  *    Creates a new immutable shape which is the union of two others.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape1:
;  *      An existing HIShapeRef.
;  *    
;  *    inShape2:
;  *      An existing HIShapeRef.
;  *  
;  *  Result:
;  *    A new immutable HIShapeRef.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeCreateUnion" 
   ((inShape1 (:pointer :__HIShape))
    (inShape2 (:pointer :__HIShape))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__HIShape)
() )
; 
;  *  HIShapeIsEmpty()
;  *  
;  *  Discussion:
;  *    Returns true if the given HIShapeRef is empty, i.e. its area is
;  *    empty.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape:
;  *      The existing HIShapeRef you wish to test.
;  *  
;  *  Result:
;  *    A boolean result.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeIsEmpty" 
   ((inShape (:pointer :__HIShape))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Boolean
() )
; 
;  *  HIShapeIsRectangular()
;  *  
;  *  Discussion:
;  *    Returns true if the given HIShapeRef is rectangular.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape:
;  *      The existing HIShapeRef you wish to test.
;  *  
;  *  Result:
;  *    A boolean result.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeIsRectangular" 
   ((inShape (:pointer :__HIShape))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Boolean
() )
; 
;  *  HIShapeContainsPoint()
;  *  
;  *  Discussion:
;  *    Returns true if the given HIShapeRef contains the point passed in.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape:
;  *      An existing HIShapeRef.
;  *    
;  *    inPoint:
;  *      The point to check.
;  *  
;  *  Result:
;  *    A boolean result.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeContainsPoint" 
   ((inShape (:pointer :__HIShape))
    (inPoint (:pointer :HIPOINT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Boolean
() )
; 
;  *  HIShapeGetBounds()
;  *  
;  *  Discussion:
;  *    Returns the bounding rectangle of a given HIShapeRef.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape:
;  *      An existing HIShapeRef.
;  *    
;  *    outRect:
;  *      Receives the bounding rectangle.
;  *  
;  *  Result:
;  *    A pointer to the rectangle you passed in, for convenience.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeGetBounds" 
   ((inShape (:pointer :__HIShape))
    (outRect (:pointer :HIRECT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :CGRect)
() )
; 
;  *  HIShapeGetAsQDRgn()
;  *  
;  *  Discussion:
;  *    Changes a given Quickdraw region handle to have the same shape as
;  *    a given HIShapeRef. Essentially you are converting an HIShapeRef
;  *    into a RgnHandle. This conversion may lose fidelity depending on
;  *    how the shape was created originally.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape:
;  *      An existing HIShapeRef.
;  *    
;  *    outRgn:
;  *      An existing region to change.
;  *  
;  *  Result:
;  *    An operating system status code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeGetAsQDRgn" 
   ((inShape (:pointer :__HIShape))
    (outRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  HIShapeReplacePathInCGContext()
;  *  
;  *  Discussion:
;  *    Given an HIShapeRef and a CGContextRef, make the current path in
;  *    the context represent the shape. You might use this to clip to a
;  *    shape, for example. You could call this function and then
;  *    immediately call CGContextClip.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape:
;  *      An existing HIShapeRef.
;  *    
;  *    inContext:
;  *      The context to apply the shape to.
;  *  
;  *  Result:
;  *    An operating system status code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeReplacePathInCGContext" 
   ((inShape (:pointer :__HIShape))
    (inContext (:pointer :CGContext))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  HIShapeSetQDClip()
;  *  
;  *  Discussion:
;  *    Given an HIShapeRef and a Quickdraw port, set the current clip in
;  *    the port to the shape.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape:
;  *      An existing HIShapeRef.
;  *    
;  *    inPort:
;  *      The port to set the clip for.
;  *  
;  *  Result:
;  *    An operating system status code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeSetQDClip" 
   ((inShape (:pointer :__HIShape))
    (inPort (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; ======================================================================================
;   MUTABLE FUNCTIONS                                                                   
; ======================================================================================
; 
;  *  HIShapeCreateMutable()
;  *  
;  *  Discussion:
;  *    Creates a new, mutable, empty shape.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Result:
;  *    A mutable shape reference.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeCreateMutable" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__HIShape)
() )
; 
;  *  HIShapeCreateMutableCopy()
;  *  
;  *  Discussion:
;  *    Given an existing HIShapeRef, creates a new mutable copy.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inOrig:
;  *      The shape to copy.
;  *  
;  *  Result:
;  *    A mutable shape reference.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeCreateMutableCopy" 
   ((inOrig (:pointer :__HIShape))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__HIShape)
() )
; 
;  *  HIShapeSetEmpty()
;  *  
;  *  Discussion:
;  *    Sets a mutable shape to be an empty shape.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape:
;  *      The shape to empty.
;  *  
;  *  Result:
;  *    An operating system status code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeSetEmpty" 
   ((inShape (:pointer :__HIShape))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  HIShapeIntersect()
;  *  
;  *  Discussion:
;  *    Takes two shapes and sets a third to be their intersection.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape1:
;  *      The first shape.
;  *    
;  *    inShape2:
;  *      The second shape.
;  *    
;  *    outResult:
;  *      The shape to receive the result of the intersection. This can
;  *      be one of the source shapes.
;  *  
;  *  Result:
;  *    An operating system status code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeIntersect" 
   ((inShape1 (:pointer :__HIShape))
    (inShape2 (:pointer :__HIShape))
    (outResult (:pointer :__HIShape))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  HIShapeDifference()
;  *  
;  *  Discussion:
;  *    Takes two shapes and sets a third to be their difference. The
;  *    second shape is subtracted from the first.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape1:
;  *      The first shape.
;  *    
;  *    inShape2:
;  *      The second shape.
;  *    
;  *    outResult:
;  *      The shape to receive the result of the intersection. This can
;  *      be one of the source shapes.
;  *  
;  *  Result:
;  *    An operating system status code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeDifference" 
   ((inShape1 (:pointer :__HIShape))
    (inShape2 (:pointer :__HIShape))
    (outResult (:pointer :__HIShape))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  HIShapeUnion()
;  *  
;  *  Discussion:
;  *    Takes two shapes and sets a third to be their union.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape1:
;  *      The first shape.
;  *    
;  *    inShape2:
;  *      The second shape.
;  *    
;  *    outResult:
;  *      The shape to receive the result of the union. This can be one
;  *      of the source shapes.
;  *  
;  *  Result:
;  *    An operating system status code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeUnion" 
   ((inShape1 (:pointer :__HIShape))
    (inShape2 (:pointer :__HIShape))
    (outResult (:pointer :__HIShape))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  HIShapeOffset()
;  *  
;  *  Discussion:
;  *    Offsets a shape by some delta.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inShape:
;  *      The shape to offset.
;  *    
;  *    inDX:
;  *      The delta to move the shape on the X axis.
;  *    
;  *    inDY:
;  *      The delta to move the shape on the Y axis.
;  *  
;  *  Result:
;  *    An operating system status code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIShapeOffset" 
   ((inShape (:pointer :__HIShape))
    (inDX :single-float)
    (inDY :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __HISHAPE__ */


(provide-interface "HIShape")