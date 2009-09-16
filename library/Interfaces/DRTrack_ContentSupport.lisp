(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRTrack_ContentSupport.h"
; at Sunday July 2,2006 7:27:43 pm.
; 
;      File:       DiscRecordingContent/DRTrack_ContentSupport.h
;  
;      Contains:   ObjC interface to track objects used in filesystem creation.
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 

; #import <Foundation/Foundation.h>

; #import <DiscRecordingEngine/DRTrack.h>

; #import <DiscRecordingEngine/DRMSF.h>

; #import <DiscRecordingContent/DRFolder.h>

(require-interface "AvailabilityMacros")
;  ------------------------------------------------------------------------------ 
;  Preconfigured track types 
; " This category on DRTrack creates a track configured to burn audio data to disc. "
#| @INTERFACE 
DRTrack (AudioContentCreation)



+ (DRTrack*) trackForAudioOfLength:(DRMSF*)length producer:(id)producer;


#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
+ (DRTrack*) trackForAudioFile:(NSString*)path;
#endif

|#
; " This category on DRTrack creates a custom DRTrack instance which is set up to burn
; 	a DRFolder to disc. It implements only one method, <b>trackForRootFolder:</b> which
; 	creates and returns a fully configured track to the caller. "
#| @INTERFACE 
DRTrack (DataContentCreation)


+ (DRTrack*) trackForRootFolder:(DRFolder*)rootFolder;

|#

(provide-interface "DRTrack_ContentSupport")