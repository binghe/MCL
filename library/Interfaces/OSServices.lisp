(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OSServices.h"
; at Sunday July 2,2006 7:23:31 pm.
; 
;      File:       OSServices/OSServices.h
;  
;      Contains:   Master include for OSServices private framework
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
; #ifndef __OSSERVICES__
; #define __OSSERVICES__
; #ifndef __CARBONCORE__
#| #|
#include <CarbonCoreCarbonCore.h>
#endif
|#
 |#
; #ifndef __APPLEDISKPARTITIONS__

(require-interface "OSServices/AppleDiskPartitions")

; #endif

; #ifndef __ICONSTORAGE__

(require-interface "OSServices/IconStorage")

; #endif

; #ifndef __POWER__

(require-interface "OSServices/Power")

; #endif

; #ifndef __SCSI__

(require-interface "OSServices/SCSI")

; #endif

; #ifndef __SYSTEMSOUND__

(require-interface "OSServices/SystemSound")

; #endif


(require-interface "OSServices/OpenTransport")

(require-interface "OSServices/OpenTransportProviders")

(require-interface "OSServices/OpenTransportProtocol")

(require-interface "OSServices/NSLCore")

(require-interface "OSServices/SecurityCore")

; #endif /* __OSSERVICES__ */


(provide-interface "OSServices")