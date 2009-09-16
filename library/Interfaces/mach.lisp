(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mach.h"
; at Sunday July 2,2006 7:30:19 pm.
; #ifndef _LIBSA_MACH_MACH_H_
; #define _LIBSA_MACH_MACH_H_

(require-interface "mach/mach_types")

(require-interface "mach/vm_map")

(deftrap-inline "_mach_task_self" 
   (
   )
   :vm_map_t
() )

(deftrap-inline "_mach_error_string" 
   ((ARG2 :signed-long)
   )
   (:pointer :character)
() )

; #endif /* _LIBSA_MACH_MACH_H_ */


(provide-interface "mach")