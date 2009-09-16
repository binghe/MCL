(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Drag.h"
; at Sunday July 2,2006 7:24:52 pm.
; 
;      File:       HIToolbox/Drag.h
;  
;      Contains:   Drag and Drop Interfaces.
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1992-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __DRAG__
; #define __DRAG__
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
; 
;  *  HIPoint
;  *  
;  *  Discussion:
;  *    HIPoint is a new, floating point-based type to help express
;  *    coordinates in a much richer fashion than the classic QuickDraw
;  *    points. It will, in time, be more heavily used throughout the
;  *    Toolbox. For now, it is replacing our use of typeQDPoint in mouse
;  *    events. This is to better support sub-pixel tablet coordinates.
;  *    If you ask for a mouse location with typeQDPoint, and the point
;  *    is actually stored as typeHIPoint, it will automatically be
;  *    coerced to typeQDPoint for you, so this change should be largely
;  *    transparent to applications. HIPoints are in screen space, i.e.
;  *    the top left of the screen is 0, 0.
;  

(%define-record :HIPoint (find-record-descriptor ':CGPoint))
; 
;  *  HISize
;  *  
;  *  Discussion:
;  *    HISize is a floating point-based type to help express dimensions
;  *    in a much richer fashion than the classic QuickDraw coordinates.
;  

(%define-record :HISize (find-record-descriptor ':CGSize))
; 
;  *  HIRect
;  *  
;  *  Discussion:
;  *    HIRect is a new, floating point-based type to help express
;  *    rectangles in a much richer fashion than the classic QuickDraw
;  *    rects. It will, in time, be more heavily used throughout the
;  *    Toolbox. HIRects are in screen space, i.e. the top left of the
;  *    screen is 0, 0.
;  

(%define-record :HIRect (find-record-descriptor ':CGRect))
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ DRAG MANAGER DATA TYPES
;   _________________________________________________________________________________________________________
; 

(def-mactype :DragRef (find-mactype '(:pointer :OpaqueDragRef)))

(def-mactype :DragItemRef (find-mactype ':UInt32))

(def-mactype :FlavorType (find-mactype ':OSType))
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ DRAG ATTRIBUTES
;   _________________________________________________________________________________________________________
; 

(def-mactype :DragAttributes (find-mactype ':UInt32))

(defconstant $kDragHasLeftSenderWindow 1)       ;  drag has left the source window since TrackDrag

(defconstant $kDragInsideSenderApplication 2)   ;  drag is occurring within the sender application
;  drag is occurring within the sender window

(defconstant $kDragInsideSenderWindow 4)
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ DRAG BEHAVIORS
;   _________________________________________________________________________________________________________
; 

(def-mactype :DragBehaviors (find-mactype ':UInt32))

(defconstant $kDragBehaviorNone 0)              ;  do zoomback animation for failed drags (normally enabled).

(defconstant $kDragBehaviorZoomBackAnimation 1)
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ DRAG IMAGE FLAGS
;   _________________________________________________________________________________________________________
; 

(def-mactype :DragImageFlags (find-mactype ':UInt32))
;  drag region and image

(defconstant $kDragRegionAndImage 16)
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ DRAG IMAGE TRANSLUCENCY LEVELS
;   _________________________________________________________________________________________________________
; 

(defconstant $kDragStandardTranslucency 0)      ;  65% image translucency (standard)

(defconstant $kDragDarkTranslucency 1)          ;  50% image translucency

(defconstant $kDragDarkerTranslucency 2)        ;  25% image translucency

(defconstant $kDragOpaqueTranslucency 3)        ;  0% image translucency (opaque)

; 
;   _________________________________________________________________________________________________________
;       
;    ¥ DRAG DRAWING PROCEDURE MESSAGES
;   _________________________________________________________________________________________________________
; 

(def-mactype :DragRegionMessage (find-mactype ':SInt16))

(defconstant $kDragRegionBegin 1)               ;  initialize drawing

(defconstant $kDragRegionDraw 2)                ;  draw drag feedback

(defconstant $kDragRegionHide 3)                ;  hide drag feedback

(defconstant $kDragRegionIdle 4)                ;  drag feedback idle time

(defconstant $kDragRegionEnd 5)                 ;  end of drawing

; 
;   _________________________________________________________________________________________________________
;       
;    ¥ ZOOM ACCELERATION
;   _________________________________________________________________________________________________________
; 

(def-mactype :ZoomAcceleration (find-mactype ':SInt16))

(defconstant $kZoomNoAcceleration 0)            ;  use linear interpolation

(defconstant $kZoomAccelerate 1)                ;  ramp up step size

(defconstant $kZoomDecelerate 2)                ;  ramp down step size

; 
;   _________________________________________________________________________________________________________
;       
;    ¥ FLAVOR FLAGS
;   _________________________________________________________________________________________________________
; 

(def-mactype :FlavorFlags (find-mactype ':UInt32))

(defconstant $flavorSenderOnly 1)               ;  flavor is available to sender only

(defconstant $flavorSenderTranslated 2)         ;  flavor is translated by sender

(defconstant $flavorNotSaved 4)                 ;  flavor should not be saved

(defconstant $flavorSystemTranslated #x100)     ;  flavor is translated by system
;  flavor data is promised by sender

(defconstant $flavorDataPromised #x200)
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ FILE SYSTEM CONSTANTS
;   _________________________________________________________________________________________________________
; 

(defconstant $kDragFlavorTypeHFS :|hfs |)       ;  flavor type for HFS data

(defconstant $kDragFlavorTypePromiseHFS :|phfs|);  flavor type for promised HFS data

(defconstant $flavorTypeHFS :|hfs |)            ;  old name

(defconstant $flavorTypePromiseHFS :|phfs|)     ;  old name


(defconstant $kDragPromisedFlavorFindFile :|rWm1|);  promisedFlavor value for Find File

(defconstant $kDragPromisedFlavor :|fssP|)      ;  promisedFlavor value for everything else


(defconstant $kDragPseudoCreatorVolumeOrDirectory :|MACS|);  "creator code" for volume or directory

(defconstant $kDragPseudoFileTypeVolume :|disk|);  "file type" for volume

(defconstant $kDragPseudoFileTypeDirectory :|fold|);  "file type" for directory

; 
;   _________________________________________________________________________________________________________
;       
;    ¥ SPECIAL FLAVORS
;   _________________________________________________________________________________________________________
; 

(defconstant $flavorTypeDirectory :|diry|)      ;  flavor type for AOCE directories

; 
;   _________________________________________________________________________________________________________
;       
;    ¥ FLAVORS FOR FINDER 8.0 AND LATER
;   _________________________________________________________________________________________________________
; 

(defconstant $kFlavorTypeClippingName :|clnm|)  ;  name hint for clipping file (preferred over 'clfn')

(defconstant $kFlavorTypeClippingFilename :|clfn|);  name for clipping file

(defconstant $kFlavorTypeUnicodeClippingName :|ucln|);  unicode name hint for clipping file (preferred over 'uclf')

(defconstant $kFlavorTypeUnicodeClippingFilename :|uclf|);  unicode name for clipping file

(defconstant $kFlavorTypeDragToTrashOnly :|fdtt|);  for apps that want to allow dragging private data to the trash

(defconstant $kFlavorTypeFinderNoTrackingBehavior :|fntb|);  Finder completely ignores any drag containing this flavor

; 
;   _________________________________________________________________________________________________________
;       
;    ¥ DRAG TRACKING HANDLER MESSAGES
;   _________________________________________________________________________________________________________
; 

(def-mactype :DragTrackingMessage (find-mactype ':SInt16))

(defconstant $kDragTrackingEnterHandler 1)      ;  drag has entered handler

(defconstant $kDragTrackingEnterWindow 2)       ;  drag has entered window

(defconstant $kDragTrackingInWindow 3)          ;  drag is moving within window

(defconstant $kDragTrackingLeaveWindow 4)       ;  drag has exited window

(defconstant $kDragTrackingLeaveHandler 5)      ;  drag has exited handler

; 
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;    ¥ STANDARD DROP LOCATIONS
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  Summary:
;  *    Standard Drop Location constants
;  *  
;  *  Discussion:
;  *    The following constants define common "meta" drop locations.
;  
; 
;    * The drop location was in the trash.  This is set when a drag is
;    * dropped on the trash icon.  Setting this standard drop location
;    * sets the traditional drop location to an alias to the trash folder
;    * automatically.
;    

(defconstant $kDragStandardDropLocationTrash :|trsh|)
; 
;    * The receiver did not specify a drop lcoation. This is the default.
;    

(defconstant $kDragStandardDropLocationUnknown :|unkn|)

(def-mactype :StandardDropLocation (find-mactype ':OSType))
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ DRAG ACTIONS
;   _________________________________________________________________________________________________________
; 
; 
;  *  Summary:
;  *    Drag Action constants
;  *  
;  *  Discussion:
;  *    The following constants define, in a general way, what actions a
;  *    drag should or has performed.  Some drag actions enforce a mode
;  *    of operation while others are flexible suggestions.  These
;  *    constants are used in conjunction with the
;  *    Get/SetDragAllowableActions() and Get/SetDragDropAction() APIs. 
;  *    Adopting the Drag Action APIs increases compatability with the
;  *    Cocoa drag operation model.
;  
; 
;    * Suggests nothing should be/was done with the data in a drag.  When
;    * set as an allowable action for remote drags, the drag will not be
;    * sent to apps other than the sender.
;    

(defconstant $kDragActionNothing 0)
; 
;    * Suggests the data contained within the drag can be/was copied.
;    

(defconstant $kDragActionCopy 1)
; 
;    * Suggests the data contained within the drag can be/is shared.
;    

(defconstant $kDragActionAlias 2)
; 
;    * Suggests the drag action is can be defined by the drag destination
;    * or was not defined by the drag destination.
;    

(defconstant $kDragActionGeneric 4)
; 
;    * Suggests the drag action should be negotiated privately between
;    * the drag source and destination.
;    

(defconstant $kDragActionPrivate 8)
; 
;    * Description forthcoming.
;    

(defconstant $kDragActionMove 16)
; 
;    * Description forthcoming.
;    

(defconstant $kDragActionDelete 32)
; 
;    * All of the above drag actions are allowed.
;    

(defconstant $kDragActionAll #xFFFFFFFF)

(def-mactype :DragActions (find-mactype ':UInt32))
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ HFS FLAVORS
;   _________________________________________________________________________________________________________
; 
(defrecord HFSFlavor
   (fileType :OSType)                           ;  file type 
   (fileCreator :OSType)                        ;  file creator 
   (fdFlags :UInt16)                            ;  Finder flags 
   (fileSpec :FSSpec)                           ;  file system specification 
)

;type name? (%define-record :HFSFlavor (find-record-descriptor ':HFSFlavor))
(defrecord PromiseHFSFlavor
   (fileType :OSType)                           ;  file type 
   (fileCreator :OSType)                        ;  file creator 
   (fdFlags :UInt16)                            ;  Finder flags 
   (promisedFlavor :OSType)                     ;  promised flavor containing an FSSpec 
)

;type name? (%define-record :PromiseHFSFlavor (find-record-descriptor ':PromiseHFSFlavor))
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ APPLICATION-DEFINED DRAG HANDLER ROUTINES
;   _________________________________________________________________________________________________________
; 

(def-mactype :DragTrackingHandlerProcPtr (find-mactype ':pointer)); (DragTrackingMessage message , WindowRef theWindow , void * handlerRefCon , DragRef theDrag)

(def-mactype :DragReceiveHandlerProcPtr (find-mactype ':pointer)); (WindowRef theWindow , void * handlerRefCon , DragRef theDrag)

(def-mactype :DragTrackingHandlerUPP (find-mactype '(:pointer :OpaqueDragTrackingHandlerProcPtr)))

(def-mactype :DragReceiveHandlerUPP (find-mactype '(:pointer :OpaqueDragReceiveHandlerProcPtr)))
; 
;  *  NewDragTrackingHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDragTrackingHandlerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDragTrackingHandlerProcPtr)
() )
; 
;  *  NewDragReceiveHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDragReceiveHandlerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDragReceiveHandlerProcPtr)
() )
; 
;  *  DisposeDragTrackingHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDragTrackingHandlerUPP" 
   ((userUPP (:pointer :OpaqueDragTrackingHandlerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDragReceiveHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDragReceiveHandlerUPP" 
   ((userUPP (:pointer :OpaqueDragReceiveHandlerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDragTrackingHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDragTrackingHandlerUPP" 
   ((message :SInt16)
    (theWindow (:pointer :OpaqueWindowPtr))
    (handlerRefCon :pointer)
    (theDrag (:pointer :OpaqueDragRef))
    (userUPP (:pointer :OpaqueDragTrackingHandlerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeDragReceiveHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDragReceiveHandlerUPP" 
   ((theWindow (:pointer :OpaqueWindowPtr))
    (handlerRefCon :pointer)
    (theDrag (:pointer :OpaqueDragRef))
    (userUPP (:pointer :OpaqueDragReceiveHandlerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ APPLICATION-DEFINED ROUTINES
;   _________________________________________________________________________________________________________
; 

(def-mactype :DragSendDataProcPtr (find-mactype ':pointer)); (FlavorType theType , void * dragSendRefCon , DragItemRef theItemRef , DragRef theDrag)

(def-mactype :DragInputProcPtr (find-mactype ':pointer)); (Point * mouse , SInt16 * modifiers , void * dragInputRefCon , DragRef theDrag)

(def-mactype :DragDrawingProcPtr (find-mactype ':pointer)); (DragRegionMessage message , RgnHandle showRegion , Point showOrigin , RgnHandle hideRegion , Point hideOrigin , void * dragDrawingRefCon , DragRef theDrag)

(def-mactype :DragSendDataUPP (find-mactype '(:pointer :OpaqueDragSendDataProcPtr)))

(def-mactype :DragInputUPP (find-mactype '(:pointer :OpaqueDragInputProcPtr)))

(def-mactype :DragDrawingUPP (find-mactype '(:pointer :OpaqueDragDrawingProcPtr)))
; 
;  *  NewDragSendDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDragSendDataUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDragSendDataProcPtr)
() )
; 
;  *  NewDragInputUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDragInputUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDragInputProcPtr)
() )
; 
;  *  NewDragDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDragDrawingUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDragDrawingProcPtr)
() )
; 
;  *  DisposeDragSendDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDragSendDataUPP" 
   ((userUPP (:pointer :OpaqueDragSendDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDragInputUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDragInputUPP" 
   ((userUPP (:pointer :OpaqueDragInputProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDragDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDragDrawingUPP" 
   ((userUPP (:pointer :OpaqueDragDrawingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDragSendDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDragSendDataUPP" 
   ((theType :OSType)
    (dragSendRefCon :pointer)
    (theItemRef :UInt32)
    (theDrag (:pointer :OpaqueDragRef))
    (userUPP (:pointer :OpaqueDragSendDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeDragInputUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDragInputUPP" 
   ((mouse (:pointer :Point))
    (modifiers (:pointer :SInt16))
    (dragInputRefCon :pointer)
    (theDrag (:pointer :OpaqueDragRef))
    (userUPP (:pointer :OpaqueDragInputProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeDragDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDragDrawingUPP" 
   ((message :SInt16)
    (showRegion (:pointer :OpaqueRgnHandle))
    (showOrigin :Point)
    (hideRegion (:pointer :OpaqueRgnHandle))
    (hideOrigin :Point)
    (dragDrawingRefCon :pointer)
    (theDrag (:pointer :OpaqueDragRef))
    (userUPP (:pointer :OpaqueDragDrawingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ INSTALLING AND REMOVING HANDLERS API'S
;   _________________________________________________________________________________________________________
; 
; 
;  *  InstallTrackingHandler()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_InstallTrackingHandler" 
   ((trackingHandler (:pointer :OpaqueDragTrackingHandlerProcPtr))
    (theWindow (:pointer :OpaqueWindowPtr))
    (handlerRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InstallReceiveHandler()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_InstallReceiveHandler" 
   ((receiveHandler (:pointer :OpaqueDragReceiveHandlerProcPtr))
    (theWindow (:pointer :OpaqueWindowPtr))
    (handlerRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveTrackingHandler()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_RemoveTrackingHandler" 
   ((trackingHandler (:pointer :OpaqueDragTrackingHandlerProcPtr))
    (theWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveReceiveHandler()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_RemoveReceiveHandler" 
   ((receiveHandler (:pointer :OpaqueDragReceiveHandlerProcPtr))
    (theWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ CREATING & DISPOSING
;   _________________________________________________________________________________________________________
; 
; 
;  *  NewDrag()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_NewDrag" 
   ((theDrag (:pointer :DRAGREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DisposeDrag()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_DisposeDrag" 
   ((theDrag (:pointer :OpaqueDragRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ DRAG PASTEBOARD
;   _________________________________________________________________________________________________________
; 
; 
;  *  NewDragWithPasteboard()
;  *  
;  *  Discussion:
;  *    Creates a new Drag reference containing the pasteboard reference
;  *    provided.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inPasteboard:
;  *      A pasteboard created by the drag sender for use with the drag.
;  *      Items may be added to the pasteboard via the Pasteboard Manager
;  *      API either before or after this routine is called. It is still
;  *      possible to add data via the Drag Manager API, but only after
;  *      this routine is called. It is the drag sender's responsibility
;  *      to clear the pasteboard before adding items. It is also the
;  *      drag sender's responsibility to release the pasteboard.  This
;  *      may be done at any time after this routine is called. The
;  *      pasteboard is retained by the Drag Manager for the duration of
;  *      the drag.
;  *    
;  *    outDrag:
;  *      A drag reference which receives the newly created drag.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDragWithPasteboard" 
   ((inPasteboard (:pointer :OpaquePasteboardRef))
    (outDrag (:pointer :DRAGREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  GetDragPasteboard()
;  *  
;  *  Discussion:
;  *    Returns the pasteboard reference contained within the provided
;  *    drag reference. This routine may be called by a drag sender or
;  *    receiver at any point after a valid drag reference has been
;  *    created/received.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrag:
;  *      The drag reference containing the requested pasteboard.
;  *    
;  *    outPasteboard:
;  *      A pasteboard reference which receives the pasteboard contained
;  *      by the drag.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDragPasteboard" 
   ((inDrag (:pointer :OpaqueDragRef))
    (outPasteboard (:pointer :PASTEBOARDREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ ADDING DRAG ITEM FLAVORS
;   _________________________________________________________________________________________________________
; 
; 
;     The method for setting Drag Manager promises differs from that for Scrap Manger promises.  This chart
;     describes the method for setting drag promises via AddDragItemFlavor().
;     
;         dataPtr         dataSize                                result
;      pointer value  actual data size    The data of size dataSize pointed to by dataPtr is added to the drag.
;         NULL             ignored        A promise is placed on the drag.
; 
; 
;  *  AddDragItemFlavor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_AddDragItemFlavor" 
   ((theDrag (:pointer :OpaqueDragRef))
    (theItemRef :UInt32)
    (theType :OSType)
    (dataPtr :pointer)
    (dataSize :signed-long)
    (theFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDragItemFlavorData()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_SetDragItemFlavorData" 
   ((theDrag (:pointer :OpaqueDragRef))
    (theItemRef :UInt32)
    (theType :OSType)
    (dataPtr :pointer)
    (dataSize :signed-long)
    (dataOffset :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ PROVIDING CALLBACK PROCEDURES
;   _________________________________________________________________________________________________________
; 
; 
;  *  SetDragSendProc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_SetDragSendProc" 
   ((theDrag (:pointer :OpaqueDragRef))
    (sendProc (:pointer :OpaqueDragSendDataProcPtr))
    (dragSendRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDragInputProc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_SetDragInputProc" 
   ((theDrag (:pointer :OpaqueDragRef))
    (inputProc (:pointer :OpaqueDragInputProcPtr))
    (dragInputRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDragDrawingProc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_SetDragDrawingProc" 
   ((theDrag (:pointer :OpaqueDragRef))
    (drawingProc (:pointer :OpaqueDragDrawingProcPtr))
    (dragDrawingRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ SETTING THE DRAG IMAGE
;   _________________________________________________________________________________________________________
; 
; 
;  *  SetDragImage()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 7.5 and later
;  

(deftrap-inline "_SetDragImage" 
   ((theDrag (:pointer :OpaqueDragRef))
    (imagePixMap (:Handle :PixMap))
    (imageRgn (:pointer :OpaqueRgnHandle))
    (imageOffsetPt :Point)
    (theImageFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDragImageWithCGImage()
;  *  
;  *  Discussion:
;  *    Used by the sender of the drag to set the image, in CGImage
;  *    format, to be displayed as user feedback during the drag.  This
;  *    API may be called  at any point during the drag to update the
;  *    image.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDrag:
;  *      The drag reference for which the image will be displayed.
;  *    
;  *    inCGImage:
;  *      The CGImageRef for the image to be displayed during the drag. 
;  *      The image is retained internally by the Drag Manager for the
;  *      duration of the drag so it may be released by the client
;  *      immediately after setting.
;  *    
;  *    inImageOffsetPt:
;  *      A pointer to the offset from the mouse to the upper left of the
;  *      image (normally expressed in negative values).  This differs
;  *      from the usage of the offset passed to SetDragImage().  Here,
;  *      an offset of ( -30, -30 ) will center a 60x60 pixel image on
;  *      the drag mouse.
;  *    
;  *    inImageFlags:
;  *      The flags determining image drawing during the drag.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDragImageWithCGImage" 
   ((inDrag (:pointer :OpaqueDragRef))
    (inCGImage (:pointer :CGImage))
    (inImageOffsetPt (:pointer :HIPOINT))
    (inImageFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ ALTERING THE BEHAVIOR OF A DRAG
;   _________________________________________________________________________________________________________
; 
; 
;  *  ChangeDragBehaviors()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 9.0 and later
;  

(deftrap-inline "_ChangeDragBehaviors" 
   ((theDrag (:pointer :OpaqueDragRef))
    (inBehaviorsToSet :UInt32)
    (inBehaviorsToClear :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ PERFORMING A DRAG
;   _________________________________________________________________________________________________________
; 
; 
;  *  TrackDrag()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_TrackDrag" 
   ((theDrag (:pointer :OpaqueDragRef))
    (theEvent (:pointer :EventRecord))
    (theRegion (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ GETTING DRAG ITEM INFORMATION
;   _________________________________________________________________________________________________________
; 
; 
;  *  CountDragItems()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_CountDragItems" 
   ((theDrag (:pointer :OpaqueDragRef))
    (numItems (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDragItemReferenceNumber()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_GetDragItemReferenceNumber" 
   ((theDrag (:pointer :OpaqueDragRef))
    (index :UInt16)
    (theItemRef (:pointer :DRAGITEMREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CountDragItemFlavors()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_CountDragItemFlavors" 
   ((theDrag (:pointer :OpaqueDragRef))
    (theItemRef :UInt32)
    (numFlavors (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetFlavorType()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_GetFlavorType" 
   ((theDrag (:pointer :OpaqueDragRef))
    (theItemRef :UInt32)
    (index :UInt16)
    (theType (:pointer :FLAVORTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetFlavorFlags()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_GetFlavorFlags" 
   ((theDrag (:pointer :OpaqueDragRef))
    (theItemRef :UInt32)
    (theType :OSType)
    (theFlags (:pointer :FLAVORFLAGS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetFlavorDataSize()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_GetFlavorDataSize" 
   ((theDrag (:pointer :OpaqueDragRef))
    (theItemRef :UInt32)
    (theType :OSType)
    (dataSize (:pointer :SIZE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetFlavorData()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_GetFlavorData" 
   ((theDrag (:pointer :OpaqueDragRef))
    (theItemRef :UInt32)
    (theType :OSType)
    (dataPtr :pointer)
    (dataSize (:pointer :SIZE))
    (dataOffset :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ DRAG ITEM BOUNDS
;   _________________________________________________________________________________________________________
; 
; 
;  *  GetDragItemBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_GetDragItemBounds" 
   ((theDrag (:pointer :OpaqueDragRef))
    (theItemRef :UInt32)
    (itemBounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDragItemBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_SetDragItemBounds" 
   ((theDrag (:pointer :OpaqueDragRef))
    (theItemRef :UInt32)
    (itemBounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ DROP LOCATIONS
;   _________________________________________________________________________________________________________
; 
; 
;  *  GetDropLocation()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_GetDropLocation" 
   ((theDrag (:pointer :OpaqueDragRef))
    (dropLocation (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDropLocation()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_SetDropLocation" 
   ((theDrag (:pointer :OpaqueDragRef))
    (dropLocation (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ STANDARD DROP LOCATIONS
;   _________________________________________________________________________________________________________
; 
; 
;  *  GetStandardDropLocation()
;  *  
;  *  Discussion:
;  *    Gets the standard drop location that was set by the receiver of
;  *    the drag.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theDrag:
;  *      The drag reference from which to retrieve the allowable drag
;  *      actions.
;  *    
;  *    outDropLocation:
;  *      A pointer to the standard drop location, set by the receiver,
;  *      representing the location where the drag was dropped.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetStandardDropLocation" 
   ((theDrag (:pointer :OpaqueDragRef))
    (outDropLocation (:pointer :STANDARDDROPLOCATION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  SetStandardDropLocation()
;  *  
;  *  Discussion:
;  *    Used by the receiver of the drag to set the standard drop
;  *    location.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theDrag:
;  *      The drag reference from which to retrieve the allowable drag
;  *      actions.
;  *    
;  *    dropLocation:
;  *      The standard drop location representing the location where the
;  *      drag was dropped.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetStandardDropLocation" 
   ((theDrag (:pointer :OpaqueDragRef))
    (dropLocation :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ GETTING INFORMATION ABOUT A DRAG
;   _________________________________________________________________________________________________________
; 
; 
;  *  GetDragAttributes()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_GetDragAttributes" 
   ((theDrag (:pointer :OpaqueDragRef))
    (flags (:pointer :DRAGATTRIBUTES))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDragMouse()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_GetDragMouse" 
   ((theDrag (:pointer :OpaqueDragRef))
    (mouse (:pointer :Point))
    (globalPinnedMouse (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDragMouse()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_SetDragMouse" 
   ((theDrag (:pointer :OpaqueDragRef))
    (globalPinnedMouse :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDragOrigin()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_GetDragOrigin" 
   ((theDrag (:pointer :OpaqueDragRef))
    (globalInitialMouse (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDragModifiers()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_GetDragModifiers" 
   ((theDrag (:pointer :OpaqueDragRef))
    (modifiers (:pointer :SInt16))
    (mouseDownModifiers (:pointer :SInt16))
    (mouseUpModifiers (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ ACCESSING DRAG ACTIONS
;   _________________________________________________________________________________________________________
; 
; 
;  *  GetDragAllowableActions()
;  *  
;  *  Discussion:
;  *    Gets the actions the drag sender has allowed the receiver to
;  *    perform. These are not requirements, but they highly suggested
;  *    actions which allows the drag receiver to improve harmony across
;  *    the system.  The allowable actions received are always those
;  *    local to the caller's process.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theDrag:
;  *      The drag reference from which to retreive the allowable drag
;  *      actions.
;  *    
;  *    outActions:
;  *      A pointer to receive the field of allowable drag actions.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDragAllowableActions" 
   ((theDrag (:pointer :OpaqueDragRef))
    (outActions (:pointer :DRAGACTIONS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  SetDragAllowableActions()
;  *  
;  *  Discussion:
;  *    Sets the actions the receiver of the drag is allowed to perform. 
;  *    These are not requirements, but they highly suggested actions
;  *    which allows the drag receiver to improve harmony across the
;  *    system.  The caller may select wether these drag actions apply to
;  *    a local or remote process.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theDrag:
;  *      The drag reference in which to set the allowable drag actions.
;  *    
;  *    inActions:
;  *      A field of allowable drag actions to be set.
;  *    
;  *    isLocal:
;  *      A boolean value allowing the drag sender to distinguish between
;  *      those drag actions allowable by the local receiver versus a
;  *      remote one.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDragAllowableActions" 
   ((theDrag (:pointer :OpaqueDragRef))
    (inActions :UInt32)
    (isLocal :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  GetDragDropAction()
;  *  
;  *  Discussion:
;  *    Gets the action performed by the receiver of the drag.  More than
;  *    one action may have been performed.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theDrag:
;  *      The drag reference from which to retreive the performed drop
;  *      action.
;  *    
;  *    outAction:
;  *      A pointer to receive the drag action performed.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDragDropAction" 
   ((theDrag (:pointer :OpaqueDragRef))
    (outAction (:pointer :DRAGACTIONS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  SetDragDropAction()
;  *  
;  *  Discussion:
;  *    Sets the action performed by the receiver of the drag.  More than
;  *    one action may be performed.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    theDrag:
;  *      The drag reference in which to set the performed drop action.
;  *    
;  *    inAction:
;  *      The drop action performed.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDragDropAction" 
   ((theDrag (:pointer :OpaqueDragRef))
    (inAction :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ DRAG HIGHLIGHTING
;   _________________________________________________________________________________________________________
; 
; 
;  *  ShowDragHilite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_ShowDragHilite" 
   ((theDrag (:pointer :OpaqueDragRef))
    (hiliteFrame (:pointer :OpaqueRgnHandle))
    (inside :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HideDragHilite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_HideDragHilite" 
   ((theDrag (:pointer :OpaqueDragRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DragPreScroll()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_DragPreScroll" 
   ((theDrag (:pointer :OpaqueDragRef))
    (dH :SInt16)
    (dV :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DragPostScroll()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_DragPostScroll" 
   ((theDrag (:pointer :OpaqueDragRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  UpdateDragHilite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_UpdateDragHilite" 
   ((theDrag (:pointer :OpaqueDragRef))
    (updateRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDragHiliteColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 7.5 and later
;  

(deftrap-inline "_GetDragHiliteColor" 
   ((window (:pointer :OpaqueWindowPtr))
    (color (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;       
;    ¥ UTILITIES
;   _________________________________________________________________________________________________________
; 
; 
;  *  WaitMouseMoved()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_WaitMouseMoved" 
   ((initialGlobalMouse :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  ZoomRects()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_ZoomRects" 
   ((fromRect (:pointer :Rect))
    (toRect (:pointer :Rect))
    (zoomSteps :SInt16)
    (acceleration :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ZoomRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_ZoomRegion" 
   ((region (:pointer :OpaqueRgnHandle))
    (zoomDistance :Point)
    (zoomSteps :SInt16)
    (acceleration :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   _________________________________________________________________________________________________________
;    ¥ OLD NAMES
;      These are provided for compatiblity with older source bases.  It is recommended to not use them since
;      they may removed from this interface file at any time.
;   _________________________________________________________________________________________________________
; 

(def-mactype :DragReference (find-mactype ':DragRef))

(def-mactype :ItemReference (find-mactype ':UInt32))

; #if OLDROUTINENAMES
#| 
(defconstant $dragHasLeftSenderWindow 1)        ;  drag has left the source window since TrackDrag 

(defconstant $dragInsideSenderApplication 2)    ;  drag is occurring within the sender application 

(defconstant $dragInsideSenderWindow 4)         ;  drag is occurring within the sender window 


(defconstant $dragTrackingEnterHandler 1)       ;  drag has entered handler 

(defconstant $dragTrackingEnterWindow 2)        ;  drag has entered window 

(defconstant $dragTrackingInWindow 3)           ;  drag is moving within window 

(defconstant $dragTrackingLeaveWindow 4)        ;  drag has exited window 

(defconstant $dragTrackingLeaveHandler 5)       ;  drag has exited handler 


(defconstant $dragRegionBegin 1)                ;  initialize drawing 

(defconstant $dragRegionDraw 2)                 ;  draw drag feedback 

(defconstant $dragRegionHide 3)                 ;  hide drag feedback 

(defconstant $dragRegionIdle 4)                 ;  drag feedback idle time 

(defconstant $dragRegionEnd 5)                  ;  end of drawing 


(defconstant $zoomNoAcceleration 0)             ;  use linear interpolation 

(defconstant $zoomAccelerate 1)                 ;  ramp up step size 

(defconstant $zoomDecelerate 2)                 ;  ramp down step size 


(defconstant $kDragStandardImage 0)             ;  65% image translucency (standard)

(defconstant $kDragDarkImage 1)                 ;  50% image translucency

(defconstant $kDragDarkerImage 2)               ;  25% image translucency

(defconstant $kDragOpaqueImage 3)               ;  0% image translucency (opaque)

 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __DRAG__ */


(provide-interface "Drag")