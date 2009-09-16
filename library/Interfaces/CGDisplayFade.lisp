(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGDisplayFade.h"
; at Sunday July 2,2006 7:24:16 pm.
; 
;  *  CGDisplayFade.h
;  *  CoreGraphics
;  *
;  *  API to fade displays to and from a solid color, without resorting
;  *  to playing with the gamma table APIs and losing ColorSync calibration.
;  *
;  *  These APIs should be used in perference to manipulating the gamma tables
;  *  for purposes of performing fade effects.
;  *
;  *  Copyright (c) 2002 Apple Computer, Inc. All rights reserved.
;  *
;  
; #ifndef __CGDISPLAY_FADE_H__
(defconstant $__CGDISPLAY_FADE_H__ 1)
; #define __CGDISPLAY_FADE_H__ 1

(require-interface "CoreGraphics/CGDirectDisplay")

(require-interface "CoreGraphics/CGDisplayConfiguration")

(def-mactype :CGDisplayFadeReservationToken (find-mactype ':UInt32))
(defconstant $kCGDisplayFadeReservationInvalidToken 0)
; #define kCGDisplayFadeReservationInvalidToken (0)

(def-mactype :CGDisplayBlendFraction (find-mactype ':single-float))
; 
;  * Values for the limits of the fade.
;  *	kCGDisplayBlendNormal represents a normal display state
;  *	kCGDisplayBlendSolidColor represents a display blended to a solid color
;  
(defconstant $kCGDisplayBlendNormal 0.0)
; #define kCGDisplayBlendNormal		(0.0)
(defconstant $kCGDisplayBlendSolidColor 1.0)
; #define kCGDisplayBlendSolidColor	(1.0)
; 
;  * Time in seconds to perform a fade operation.
;  

(def-mactype :CGDisplayFadeInterval (find-mactype ':single-float))
; 
;  *
;  * Most fade operations done by apps and games are done around display
;  * configuration changes.  This API adds control over a built-in fade
;  * effect when performing display configuration changes.
;  *
;  * The default fade effect on a display mode change uses a fade-out of
;  * 0.3 seconds and a fade-in of 0.5 seconds.  Color fades to French Blue
;  * for a normal desktop, and black when displays are captured.
;  *
;  * CGConfigureDisplayFadeEffect sets the display fade time and color
;  * for a display reconfigure operation.
;  * Call after CGBeginDisplayConfiguration() and before
;  * calling CGCompleteDisplayConfiguration().
;  *
;  * When CGCompleteDisplayConfiguration() is called, a fade-out effect will be
;  * done prior to the display reconfiguration.  When the display reconfiguration
;  * is complete, control returns to the calling program, while a fade-in effect
;  * runs asynchronously.
;  

(deftrap-inline "_CGConfigureDisplayFadeEffect" 
   ((configRef (:pointer :_CGDisplayConfigRef))
    (fadeOutSeconds :single-float)
    (fadeInSeconds :single-float)
    (fadeRed :single-float)
    (fadeGreen :single-float)
    (fadeBlue :single-float)
   )
   :SInt32
() )
; 
;  * It may also be desirable to perform fade operations at other times, as when
;  * transitioning between game play and cinematic sequences.  The following API
;  * provides a mechanism for controlling display fade operations outside of display
;  * mode reconfigurations.
;  

(def-mactype :CGDisplayReservationInterval (find-mactype ':single-float))
(defconstant $kCGMaxDisplayReservationInterval 15.0)
; #define kCGMaxDisplayReservationInterval	(15.0)
; 
;  * Before performing fade operation, the caller must reserve the hardware
;  * for the expected period of time that the program will be doing fades
;  *
;  * A reservation token is returned that must be passed in on subsequent calls.
;  *
;  * Failing to release the hardware by the end of the reservation interval will
;  * result in the reservation token becomingn invalid, and the hardware being
;  * unfaded back to a normal state.  The reservation interval is limited (clipped)
;  * to 15 seconds maximum, and should be greater than zero.
;  *
;  * Returns kCGErrorNoneAvailable if another reservation is in effect,
;  * and kCGErrorSuccess on success.
;  

(deftrap-inline "_CGAcquireDisplayFadeReservation" 
   ((seconds :single-float)
    (pNewToken (:pointer :CGDISPLAYFADERESERVATIONTOKEN))
   )
   :SInt32
() )
; 
;  * Releases a display fade reservation, and unfades the display if needed
;  * The reservation token myToken is no longer valid after this operation.
;  *
;  * CGReleaseDisplayFadeReservation may be safely called while an async fade
;  * operation is running, and if the ending blend value is kCGDisplayBlendNormal,
;  * will not disturb the running operation.  The reservation is dropped when the
;  * fade opertion completes.
;  *
;  * Returns kCGErrorIllegalArgument if myToken is not the valid reservation token,
;  * and kCGErrorSuccess on success.
;  

(deftrap-inline "_CGReleaseDisplayFadeReservation" 
   ((myToken :UInt32)
   )
   :SInt32
() )
; 
;  * The actual fade mechanism:
;  *
;  * The function takes the current reservation token,
;  * a time interval to perform the fade operation in seconds,
;  * a starting and ending blend coefficient, an RGB color in device space,
;  * and a boolean to indicate that the operation should be done synchronously.
;  *
;  * Over the fade operation time interval, the system will interpolate a
;  * blending coefficient between the starting and ending values given,
;  * applying a nonlinear (sine-based) bias term, and will blend the video output
;  * with the specified color based on the resulting value.
;  *
;  * If the time interval is specifed as 0.0, then the ending state blend value is
;  * applied at once and the function returns.
;  *
;  * The maximum allowable time interval is 15 seconds.
;  *
;  * If the parameter 'synchronous' is true, the function does not return
;  * til the fade operation is complete.  If false, the function returns at once,
;  * and the fade operation runs asynchronously.
;  *
;  * CGReleaseDisplayFadeReservation may be safely called while an async fade
;  * operation is running, and if the ending blend value is kCGDisplayBlendNormal,
;  * will not disturb the running operation.  The reservation is dropped when the
;  * fade opertion completes.
;  *
;  * Invalid parameters result in a return value of kCGErrorIllegalArgument.
;  * Trying to start a fade operation while an asynchronous fade operation is running
;  * results in a return value of kCGErrorNoneAvailable.
;  *
;  * To perform a 2 second fade to black, waiting til complete:
;  *
;  *	CGDisplayFade(myToken,
;  *      	      2.0,			// 2 seconds 
;  *		      kCGDisplayBlendNormal,	// Starting state 
;  *		      kCGDisplayBlendSolidColor, // Ending state 
;  *		      0.0, 0.0, 0.0,		// black 
;  *		      true);			// Wait for completion 
;  *
;  * To perform a 2 second fade from black to normal, without waiting for completion:
;  *
;  *	CGDisplayFade(myToken,
;  *      	      2.0,			// 2 seconds 
;  *		      kCGDisplayBlendSolidColor, // Starting state 
;  *		      kCGDisplayBlendNormal,	// Ending state 
;  *		      0.0, 0.0, 0.0,		// black 
;  *		      false);			// Don't wait for completion 
;  

(deftrap-inline "_CGDisplayFade" 
   ((myToken :UInt32)
    (seconds :single-float)
    (startBlend :single-float)
    (endBlend :single-float)
    (redBlend :single-float)
    (greenBlend :single-float)
    (blueBlend :single-float)
    (synchronous :signed-long)
   )
   :SInt32
() )
; 
;  * Returns true if a fade operation is currently in progress.
;  

(deftrap-inline "_CGDisplayFadeOperationInProgress" 
   (
   )
   :signed-long
() )

; #endif /* __CGDISPLAY_FADE_H__ */


(provide-interface "CGDisplayFade")