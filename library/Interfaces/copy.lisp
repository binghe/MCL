(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:copy.h"
; at Sunday July 2,2006 7:27:24 pm.
; 
;  *
;  * Written By Linas Vepstas November 1991 
;  
; #define COPY_THREE_WORDS(A,B) {							struct three_words { long a, b, c, };					*(struct three_words *) (A) = *(struct three_words *) (B);	}
; #define COPY_FOUR_WORDS(A,B) {							struct four_words { long a, b, c, d, };					*(struct four_words *) (A) = *(struct four_words *) (B);	}
;  ============================================================= 

(provide-interface "copy")