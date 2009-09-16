(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:KextManager.h"
; at Sunday July 2,2006 7:30:16 pm.
; #ifndef __KEXTMANAGER_H__
; #define __KEXTMANAGER_H__

(require-interface "CoreFoundation/CoreFoundation")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(deftrap-inline "_KextManagerCreateURLForBundleIdentifier" 
   ((allocator (:pointer :__CFAllocator))
    (bundleIdentifier (:pointer :__CFString))
   )
   (:pointer :__CFURL)
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif __KEXTMANAGER_H__


(provide-interface "KextManager")