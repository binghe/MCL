(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SystemSound.h"
; at Sunday July 2,2006 7:23:33 pm.
; 
;      File:       OSServices/SystemSound.h
;  
;      Contains:   SystemSound include file
;  
;      Version:    OSServices-62.7~16
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __SYSTEMSOUND__
; #define __SYSTEMSOUND__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __FILES__
#| #|
#include <CarbonCoreFiles.h>
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
;  ================================================================================ 
;  Errors                                                                           
;  ================================================================================ 

(defconstant $kSystemSoundNoError 0)
(defconstant $kSystemSoundUnspecifiedError -1500)
;  ================================================================================ 
;  Types                                                                            
;  ================================================================================ 

(def-mactype :SystemSoundActionID (find-mactype ':UInt32))

(def-mactype :SystemSoundCompletionProcPtr (find-mactype ':pointer)); (SystemSoundActionID actionID , void * userData)

(def-mactype :SystemSoundCompletionUPP (find-mactype '(:pointer :OpaqueSystemSoundCompletionProcPtr)))
; 
;  *  NewSystemSoundCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSystemSoundCompletionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :OpaqueSystemSoundCompletionProcPtr)
() )
; 
;  *  DisposeSystemSoundCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSystemSoundCompletionUPP" 
   ((userUPP (:pointer :OpaqueSystemSoundCompletionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  *  InvokeSystemSoundCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSystemSoundCompletionUPP" 
   ((actionID :UInt32)
    (userData :pointer)
    (userUPP (:pointer :OpaqueSystemSoundCompletionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
;  ================================================================================ 
;  Public APIs                                                                      
;  ================================================================================ 
; 
;  *  AlertSoundPlay()
;  *  
;  *  Summary:
;  *    Play an Alert Sound
;  *  
;  *  Discussion:
;  *    Play the user's current alert sound, interrupting any previously
;  *    playing alert sound.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AlertSoundPlay" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  AlertSoundPlayCustomSound()
;  *  
;  *  Summary:
;  *    Play a User designated Alert Sound
;  *  
;  *  Discussion:
;  *    Play a sound, designated by a SystemSoundActionID, with the
;  *    behavior of AlertSoundPlay().
;  *  
;  *  Parameters:
;  *    
;  *    inAction:
;  *      A SystemSoundActionID indicating the desired Sound to be played
;  *      with AlertSound behavior.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AlertSoundPlayCustomSound" 
   ((inAction :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  *  SystemSoundPlay()
;  *  
;  *  Summary:
;  *    Play a System Sound
;  *  
;  *  Discussion:
;  *    Immediately play the sound designated by actionID. Use for one
;  *    time actions that do not require a duration or modification
;  *    during playback. Sustain loops in the sound will be ignored.
;  *  
;  *  Parameters:
;  *    
;  *    inAction:
;  *      A SystemSoundActionID indicating the desired System Sound to be
;  *      played.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SystemSoundPlay" 
   ((inAction :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  SystemSoundGetActionID()
;  *  
;  *  Summary:
;  *    Create a 'custom' System Sound by providing an audio file.
;  *  
;  *  Discussion:
;  *    If the user wants to add a sound that can be played via
;  *    SystemSoundPlay(), an FSRef for an audio file can be passed and a
;  *    SystemSoundActionID, which can be passed to SystemSoundPlay(),
;  *    will be returned .
;  *  
;  *  Parameters:
;  *    
;  *    userFile:
;  *      An const FSRef * for the audio file to be used as a System
;  *      Sound. Any audio file supported by the AudioFile APIs in the
;  *      AudioToolbox framework may be used.
;  *    
;  *    outAction:
;  *      If successful, a SystemSoundActionID will be returned, which in
;  *      turn can be passed to SystemSoundPlay().
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SystemSoundGetActionID" 
   ((userFile (:pointer :FSRef))
    (outAction (:pointer :SYSTEMSOUNDACTIONID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  SystemSoundRemoveActionID()
;  *  
;  *  Summary:
;  *    Remove a 'custom' System Sound.
;  *  
;  *  Discussion:
;  *    If the user no longer needs to use the custom system sound that
;  *    was created via SystemSoundGetActionID, this function should be
;  *    called so the SystemSoundServer can release resources that are no
;  *    longer needed.
;  *  
;  *  Parameters:
;  *    
;  *    inAction:
;  *      A SystemSoundActionID indicating the desired System Sound to be
;  *      removed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SystemSoundRemoveActionID" 
   ((inAction :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  SystemSoundSetCompletionRoutine()
;  *  
;  *  Summary:
;  *    Call the provided Completion Routine when the provided
;  *    SystemSoundActionID finishes playing in the server.
;  *  
;  *  Discussion:
;  *    Once set, the System Sound Server will send a message to the
;  *    System Sound Client indicating which SystemSoundActionID has
;  *    finished playing.
;  *  
;  *  Parameters:
;  *    
;  *    inAction:
;  *      The SystemSoundActionID that the completion routine will be
;  *      associated with.
;  *    
;  *    inRunLoop:
;  *      A CFRunLoopRef indicating the desired run loop the completion
;  *      routine should be run on. Pass NULL for the main run loop.
;  *    
;  *    inRunLoopMode:
;  *      A CFStringRef indicating the run loop mode for the runloop mode
;  *      for the runloop where the completion routine will be executed.
;  *      Pass NULL to use kCFRunLoopDefaultMode.
;  *    
;  *    inCompletionRoutine:
;  *      A SystemSoundCompletionProc for the completion routine proc to
;  *      be called when the provided SystemSoundActionID has completed
;  *      playing in the server.
;  *    
;  *    inUserData:
;  *      A void * to pass user data to the completion routine.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SystemSoundSetCompletionRoutine" 
   ((inAction :UInt32)
    (inRunLoop (:pointer :__CFRunLoop))
    (inRunLoopMode (:pointer :__CFString))
    (inCompletionRoutine (:pointer :OpaqueSystemSoundCompletionProcPtr))
    (inUserData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  SystemSoundRemoveCompletionRoutine()
;  *  
;  *  Summary:
;  *    Remove the Completion Routine being used for the provided
;  *    SystemSoundActionID.
;  *  
;  *  Discussion:
;  *    To be called when it is no longer desired for the Completion
;  *    Routine to be called when a System Sound action has finished
;  *    playing.
;  *  
;  *  Parameters:
;  *    
;  *    inAction:
;  *      A SystemSoundActionID that currently has an associated
;  *      completion routine.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SystemSoundRemoveCompletionRoutine" 
   ((inAction :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __SYSTEMSOUND__ */


(provide-interface "SystemSound")