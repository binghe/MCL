(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DiscRecordingUIResources.h"
; at Sunday July 2,2006 7:27:40 pm.
; 
;      File:       DiscRecordingUI/DiscRecordingUIResources.h
;  
;      Contains:   Resources provided by the DiscRecordingUI framework.
;  
;       Version:   Technology: Mac OS X
;                  Release:    Mac OS X
;  
;     Copyright:   (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 

; #import <Cocoa/Cocoa.h>

; #import <AvailabilityMacros.h>
; !
; 	@const		DRBurnIcon
; 	@discussion	The name of the burn icon image.
; 
(def-mactype :DRBurnIcon (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DREraseIcon
; 	@discussion	The name of the erase icon image.
; 
(def-mactype :DREraseIcon (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER

(provide-interface "DiscRecordingUIResources")