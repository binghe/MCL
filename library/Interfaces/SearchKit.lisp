(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SearchKit.h"
; at Sunday July 2,2006 7:23:42 pm.
; 
;      File:       SearchKit/SearchKit.h
;  
;      Contains:   SearchKit Interfaces.
;  
;      Version:    SearchKit-60~16
;  
;      Copyright:  © 2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; 
;  *  This framework provides required capabilities to index, search, and analyze the
;  *  text of documents. A document is simply an item from which terms can be extracted. 
;  *  (i.e. a file on a computer, a record in a database, a sentence, ...)
;  
; #ifndef __SEARCHKIT__
; #define __SEARCHKIT__
; #ifndef __COREFOUNDATION__

(require-interface "CoreFoundation/CoreFoundation")

; #endif

; #ifndef __SKDOCUMENT__

(require-interface "SearchKit/SKDocument")

; #endif

; #ifndef __SKANALYSIS__

(require-interface "SearchKit/SKAnalysis")

; #endif

; #ifndef __SKINDEX__

(require-interface "SearchKit/SKIndex")

; #endif

; #ifndef __SKSEARCH__

(require-interface "SearchKit/SKSearch")

; #endif


; #endif /* __SEARCHKIT__ */


(provide-interface "SearchKit")