(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OT.h"
; at Sunday July 2,2006 7:31:09 pm.
; 
;      File:       OT/OT.h
;  
;      Contains:   Master include for OT private framework
;  
;      Version:    OpenTransport-90~46
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __OT__
; #define __OT__
; #ifndef __CARBONCORE__
#| #|
#include <CarbonCoreCarbonCore.h>
#endif
|#
 |#
; #ifndef __OPENTRANSPORT__
#| #|
#include <OSServicesOpenTransport.h>
#endif
|#
 |#
; #ifndef __OPENTRANSPORTPROVIDERS__
#| #|
#include <OSServicesOpenTransportProviders.h>
#endif
|#
 |#
; #ifndef __OPENTRANSPORTPROTOCOL__
#| #|
#include <OSServicesOpenTransportProtocol.h>
#endif
|#
 |#

; #endif /* __OT__ */


(provide-interface "OT")