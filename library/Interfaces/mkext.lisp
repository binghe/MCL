(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mkext.h"
; at Sunday July 2,2006 7:30:28 pm.
; #ifndef _MKEXT_H_
(defconstant $_MKEXT_H_ 1)
; #define _MKEXT_H_ 1

(require-interface "sys/cdefs")

(require-interface "sys/types")

(require-interface "mach/machine")
(defconstant $MKEXT_MAGIC "MKXT")
; #define MKEXT_MAGIC 'MKXT'
(defconstant $MKEXT_SIGN "MOSX")
; #define MKEXT_SIGN 'MOSX'
(defconstant $MKEXT_EXTN ".mkext")
; #define MKEXT_EXTN ".mkext"
;  All binary values are big-endian
;  If all fields are 0 then this file slot is empty
;  If compsize is zero then the file isn't compressed.
(defrecord mkext_file
   (offset :unsigned-long)                      ;  4 bytes
   (compsize :unsigned-long)                    ;  4 bytes
   (realsize :unsigned-long)                    ;  4 bytes
   (modifiedsecs :signed-long)                  ;  4 bytes
)
;  The plist file entry is mandatory, but module may be empty
(defrecord mkext_kext
   (plist :MKEXT_FILE)                          ;  16 bytes
   (module :MKEXT_FILE)                         ;  16 bytes
)
(defrecord mkext_header
   (magic :UInt32)                              ;  'MKXT'
   (signature :UInt32)                          ;  'MOSX'
   (length :UInt32)
   (adler32 :UInt32)
   (version :UInt32)                            ;  vers resource, currently '1.0.0', 0x01008000
   (numkexts :UInt32)
   (cputype :signed-long)                       ;  CPU_TYPE_ANY for fat executables
   (cpusubtype :signed-long)                    ;  CPU_SUBTYPE_MULITPLE for executables
   (kext (:array :MKEXT_KEXT 1))                ;  64 bytes/entry
)

(deftrap-inline "_compress_lzss" 
   ((dst (:pointer :u_int8_t))
    (dstlen :UInt32)
    (src (:pointer :u_int8_t))
    (srclen :UInt32)
   )
   (:pointer :UInt8)
() )

(deftrap-inline "_decompress_lzss" 
   ((dst (:pointer :u_int8_t))
    (src (:pointer :u_int8_t))
    (srclen :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_adler32" 
   ((src (:pointer :u_int8_t))
    (length :SInt32)
   )
   :UInt32
() )

; #endif /* _MKEXT_H_ */


(provide-interface "mkext")