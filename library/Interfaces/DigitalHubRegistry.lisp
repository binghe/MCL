(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DigitalHubRegistry.h"
; at Sunday July 2,2006 7:25:11 pm.
; 
;      File:       OpenScripting/DigitalHubRegistry.h
;  
;      Contains:   Digital Hub AppleEvents
;  
;      Version:    OSA-62~76
;  
;      Copyright:  © 2002-2003 by Apple Computer, Inc.  All rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __DIGITALHUBREGISTRY__
; #define __DIGITALHUBREGISTRY__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __AEREGISTRY__
#| #|
#include <AEAERegistry.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

;  class 

(defconstant $kDigiHubEventClass :|dhub|)
;  events

(defconstant $kDigiHubMusicCD :|aucd|)          ;  1635083108 0x61756364

(defconstant $kDigiHubPictureCD :|picd|)        ;  1885954916 0x70696364

(defconstant $kDigiHubVideoDVD :|vdvd|)         ;  1986295396 0x76647664

(defconstant $kDigiHubBlankCD :|bcd |)          ;  1650680864 0x62636420

(defconstant $kDigiHubBlankDVD :|bdvd|)         ;  1650751076 0x62647664

; 
;     Parameters for Digital Hub AppleEvents:
;                     
;         kDigiHubMusicCD
;         Required parameters:
;         -->     keyDirectObject         typeFSRef
; 
;         kDigiHubPictureCD
;         Required parameters:
;         -->     keyDirectObject         typeFSRef
;                 
;         kDigiHubVideoDVD
;         Required parameters:
;         -->     keyDirectObject         typeFSRef
;                 
;         kDigiHubBlankCD
;         Required parameters:
;         -->     keyDirectObject         typeUTF8Text
; 
;         kDigiHubBlankDVD
;         Required parameters:
;         -->     keyDirectObject         typeUTF8Text
; 
; 

; #endif /* __DIGITALHUBREGISTRY__ */


(provide-interface "DigitalHubRegistry")