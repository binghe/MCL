(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:stdlib.h"
; at Sunday July 2,2006 7:22:58 pm.
; #ifndef _LIBSA_STDLIB_H_
; #define _LIBSA_STDLIB_H_

(require-interface "sys/cdefs")
; #ifndef _BSD_SIZE_T_DEFINED_
#| #|
#define _BSD_SIZE_T_DEFINED_
typedef __SIZE_TYPE__    size_t;
#endif
|#
 |#
; #ifndef NULL
; #define NULL   (0)

; #endif

(def-mactype :kld_basefile_name (find-mactype '(:pointer :char)))

(deftrap-inline "_malloc" 
   ((size :unsigned-long)
   )
   (:pointer :void)
() )

(deftrap-inline "_free" 
   ((address :pointer)
   )
   nil
() )

(deftrap-inline "_free_all" 
   (
   )
   nil
() )
;  "Free" all memory blocks

(deftrap-inline "_malloc_reset" 
   (
   )
   nil
() )
;  Destroy all memory regions

(deftrap-inline "_realloc" 
   ((address :pointer)
    (new_size :unsigned-long)
   )
   (:pointer :void)
() )

(deftrap-inline "_strrchr" 
   ((cp (:pointer :char))
    (ch :signed-long)
   )
   (:pointer :character)
() )

(deftrap-inline "_qsort" 
   ((array :pointer)
    (nmembers :unsigned-long)
    (member_size :unsigned-long)
    (ARG2 (:pointer :callback))                 ;(int (const void * , const void *))

   )
   nil
() )

(deftrap-inline "_bsearch" 
   ((key (:pointer :register))
    (base0 :pointer)
    (nmemb :unsigned-long)
    (size :register)
    (compar (:pointer :callback))               ;(register (const void * , const void *))

   )
   (:pointer :void)
() )
;  These are defined in the kernel.
;  

(deftrap-inline "_strtol" 
   ((ARGH (:pointer :char))
    (ARGH (:pointer :char))
    (ARG2 :signed-long)
   )
   :SInt32
() )

(deftrap-inline "_strtoul" 
   ((ARGH (:pointer :char))
    (ARGH (:pointer :char))
    (ARG2 :signed-long)
   )
   :UInt32
() )

; #endif /* _LIBSA_STDLIB_H_ */


(provide-interface "stdlib")