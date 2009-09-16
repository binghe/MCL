(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:md5.h"
; at Sunday July 2,2006 7:30:26 pm.
;  MD5.H - header file for MD5C.C
;  
;  Copyright (C) 1991-2, RSA Data Security, Inc. Created 1991. All
; rights reserved.
; 
; License to copy and use this software is granted provided that it
; is identified as the "RSA Data Security, Inc. MD5 Message-Digest
; Algorithm" in all material mentioning or referencing this software
; or this function.
; 
; License is also granted to make and use derivative works provided
; that such works are identified as "derived from the RSA Data
; Security, Inc. MD5 Message-Digest Algorithm" in all material
; mentioning or referencing the derived work.
; 
; RSA Data Security, Inc. makes no representations concerning either
; the merchantability of this software or the suitability of this
; software for any particular purpose. It is provided "as is"
; without express or implied warranty of any kind.
; 
; These notices must be retained in any copies of any part of this
; documentation and/or software.
;  
; #ifndef _SYS_MD5_H_
; #define _SYS_MD5_H_

(require-interface "sys/appleapiopts")

; #if !defined(KERNEL) || defined(__APPLE_API_PRIVATE)
;  MD5 context. 
(defrecord MD5Context
   (state (:array :UInt32 4))
                                                ;  state (ABCD) 
   (count (:array :UInt32 2))
                                                ;  number of bits, modulo 2^64 (lsb first) 
   (buffer (:array :UInt8 64))
                                                ;  input buffer 
)
(%define-record :MD5_CTX (find-record-descriptor :MD5CONTEXT))

(require-interface "sys/cdefs")

(deftrap-inline "_MD5Init" 
   ((ARGH (:pointer :MD5_CTX))
   )
   :void
() )

(deftrap-inline "_MD5Update" 
   ((ARGH (:pointer :MD5_CTX))
    (* (:pointer :UInt8))
    (int :UInt32)
   )
   :void
() )

(deftrap-inline "_MD5Pad" 
   ((ARGH (:pointer :MD5_CTX))
   )
   :void
() )

(deftrap-inline "_MD5Final" 
   ((char (:pointer :UInt8))
    (ARGH (:pointer :MD5_CTX))
   )
   :void
() )

(deftrap-inline "_MD5End" 
   ((ARGH (:pointer :MD5_CTX))
    (ARGH (:pointer :char))
   )
   (:pointer :character)
() )

(deftrap-inline "_MD5File" 
   ((ARGH (:pointer :char))
    (ARGH (:pointer :char))
   )
   (:pointer :character)
() )

(deftrap-inline "_MD5Data" 
   ((* (:pointer :UInt8))
    (int :UInt32)
    (ARGH (:pointer :char))
   )
   (:pointer :character)
() )
; #ifdef KERNEL
#| #|
void MD5Transform __P((u_int32_t [4], const unsigned char [64]));
#endif
|#
 |#

; #endif /* !KERNEL || __APPLE_API_PRIVATE */


; #endif /* _SYS_MD5_H_ */


(provide-interface "md5")