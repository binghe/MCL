(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFNetwork.h"
; at Sunday July 2,2006 7:23:38 pm.
; 
;      File:       CFNetwork/CFNetwork.h
;  
;      Contains:   CoreFoundation Network header
;  
;      Version:    CFNetwork-71.2~1
;  
;      Copyright:  © 2001-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CFNETWORK__
; #define __CFNETWORK__
; #ifndef __COREFOUNDATION__

(require-interface "CoreFoundation/CoreFoundation")

; #endif

; #ifndef __CFSOCKETSTREAM__

(require-interface "CFNetwork/CFSocketStream")

; #endif

; #ifndef __CFFTPSTREAM__

(require-interface "CFNetwork/CFFTPStream")

; #endif

; #ifndef __CFHOST__
#| #|
#include <CFNetworkCFHost.h>
#endif
|#
 |#
; #ifndef __CFHTTPMESSAGE__

(require-interface "CFNetwork/CFHTTPMessage")

; #endif

; #ifndef __CFHTTPSTREAM__

(require-interface "CFNetwork/CFHTTPStream")

; #endif

; #ifndef __CFNETSERVICES__
#| #|
#include <CFNetworkCFNetServices.h>
#endif
|#
 |#

; #endif /* __CFNETWORK__ */


(provide-interface "CFNetwork")