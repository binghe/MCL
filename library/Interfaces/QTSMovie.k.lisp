(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QTSMovie.k.h"
; at Sunday July 2,2006 7:31:21 pm.
; 
;      File:       QTSMovie.k.h
;  
;      Contains:   QuickTime Interfaces.
;  
;      Version:    QuickTime_6
;  
;      Copyright:  © 1990-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __QTSMOVIE_K__
; #define __QTSMOVIE_K__

(require-interface "QuickTime/QTSMovie")
; 
; 	Example usage:
; 
; 		#define QTSMEDIA_BASENAME()	Fred
; 		#define QTSMEDIA_GLOBALS()	FredGlobalsHandle
; 		#include <QuickTime/QTSMovie.k.h>
; 
; 	To specify that your component implementation does not use globals, do not #define QTSMEDIA_GLOBALS
; 
; #ifdef QTSMEDIA_BASENAME
#| #|
	#ifndefQTSMEDIA_GLOBALS
		#define QTSMEDIA_GLOBALS() 
		#define ADD_QTSMEDIA_COMMA 
	#else		#define ADD_QTSMEDIA_COMMA ,
	#endif	#define QTSMEDIA_GLUE(a,b) a
; #b
#COMPILER-DIRECTIVE 	#define QTSMEDIA_STRCAT(a,b) QTSMEDIA_GLUE(a,b)
	#define ADD_QTSMEDIA_BASENAME(name) QTSMEDIA_STRCAT(QTSMEDIA_BASENAME(),name)

	EXTERN_API( ComponentResult  ) ADD_QTSMEDIA_BASENAME(SetInfo) (QTSMEDIA_GLOBALS() ADD_QTSMEDIA_COMMA OSType  inSelector, void * ioParams);

	EXTERN_API( ComponentResult  ) ADD_QTSMEDIA_BASENAME(GetInfo) (QTSMEDIA_GLOBALS() ADD_QTSMEDIA_COMMA OSType  inSelector, void * ioParams);

	EXTERN_API( ComponentResult  ) ADD_QTSMEDIA_BASENAME(SetIndStreamInfo) (QTSMEDIA_GLOBALS() ADD_QTSMEDIA_COMMA SInt32  inIndex, OSType  inSelector, void * ioParams);

	EXTERN_API( ComponentResult  ) ADD_QTSMEDIA_BASENAME(GetIndStreamInfo) (QTSMEDIA_GLOBALS() ADD_QTSMEDIA_COMMA SInt32  inIndex, OSType  inSelector, void * ioParams);

#endif
|#
 |#
;  QTSMEDIA_BASENAME 

; #endif /* __QTSMOVIE_K__ */


(provide-interface "QTSMovie.k")