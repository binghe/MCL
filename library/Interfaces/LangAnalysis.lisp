(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:LangAnalysis.h"
; at Sunday July 2,2006 7:24:44 pm.
; 
;      File:       LangAnalysis/LangAnalysis.h
;  
;      Contains:   Master include for LangAnalysis private framework
;  
;      Version:    LanguageAnalysis-124~1
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __LANGANALYSIS__
; #define __LANGANALYSIS__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __AE__
#| #|
#include <AEAE.h>
#endif
|#
 |#
; #ifndef __LANGUAGEANALYSIS__

(require-interface "LangAnalysis/LanguageAnalysis")

; #endif

; #ifndef __DICTIONARY__
#| #|
#include <LangAnalysisDictionary.h>
#endif
|#
 |#

; #endif /* __LANGANALYSIS__ */


(provide-interface "LangAnalysis")