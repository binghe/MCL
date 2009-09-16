(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:tclPlatDecls.h"
; at Sunday July 2,2006 7:32:04 pm.
; 
;  * tclPlatDecls.h --
;  *
;  *	Declarations of platform specific Tcl APIs.
;  *
;  * Copyright (c) 1998-1999 by Scriptics Corporation.
;  * All rights reserved.
;  *
;  * RCS: @(#) $Id: tclPlatDecls.h,v 1.1.1.5 2003/07/09 01:33:47 landonf Exp $
;  
; #ifndef _TCLPLATDECLS
; #define _TCLPLATDECLS
; 
;  *  Pull in the typedef of TCHAR for windows.
;  

; #if defined(__CYGWIN__)
#| 
(def-mactype :TCHAR (find-mactype ':character))
 |#

; #elif defined(__WIN32__) && !defined(_TCHAR_DEFINED)
#| 
(require-interface "tchar")
; #   ifndef _TCHAR_DEFINED
;  Borland seems to forget to set this. 

(def-mactype :TCHAR (find-mactype ':_TCHAR))
; #	define _TCHAR_DEFINED
 |#

; #   endif


; #   if defined(_MSC_VER) && defined(__STDC__)
#|                                              ;  MSVC++ misses this. 

(def-mactype :TCHAR (find-mactype ':_TCHAR))
 |#

; #   endif


; #endif

;  !BEGIN!: Do not edit below this line. 
; 
;  * Exported function declarations:
;  
; #ifdef __WIN32__
#| #|

EXTERN TCHAR *		Tcl_WinUtfToTChar _ANSI_ARGS_((CONST char * str, 
				int len, Tcl_DString * dsPtr));

EXTERN char *		Tcl_WinTCharToUtf _ANSI_ARGS_((CONST TCHAR * str, 
				int len, Tcl_DString * dsPtr));
#endif
|#
 |#
;  __WIN32__ 
; #ifdef MAC_TCL
#| #|

EXTERN void		Tcl_MacSetEventProc _ANSI_ARGS_((
				Tcl_MacConvertEventPtr procPtr));

EXTERN char *		Tcl_MacConvertTextResource _ANSI_ARGS_((
				Handle resource));

EXTERN int		Tcl_MacEvalResource _ANSI_ARGS_((Tcl_Interp * interp, 
				CONST char * resourceName, 
				int resourceNumber, CONST char * fileName));

EXTERN Handle		Tcl_MacFindResource _ANSI_ARGS_((Tcl_Interp * interp, 
				long resourceType, CONST char * resourceName, 
				int resourceNumber, CONST char * resFileRef, 
				int * releaseIt));

EXTERN int		Tcl_GetOSTypeFromObj _ANSI_ARGS_((
				Tcl_Interp * interp, Tcl_Obj * objPtr, 
				OSType * osTypePtr));

EXTERN void		Tcl_SetOSTypeObj _ANSI_ARGS_((Tcl_Obj * objPtr, 
				OSType osType));

EXTERN Tcl_Obj *	Tcl_NewOSTypeObj _ANSI_ARGS_((OSType osType));

EXTERN int		strncasecmp _ANSI_ARGS_((CONST char * s1, 
				CONST char * s2, size_t n));

EXTERN int		strcasecmp _ANSI_ARGS_((CONST char * s1, 
				CONST char * s2));
#endif
|#
 |#
;  MAC_TCL 
; #ifdef MAC_OSX_TCL
#| #|

EXTERN int		Tcl_MacOSXOpenBundleResources _ANSI_ARGS_((
				Tcl_Interp * interp, CONST char * bundleName, 
				int hasResourceFile, int maxPathLen, 
				char * libraryPath));

EXTERN int		Tcl_MacOSXOpenVersionedBundleResources _ANSI_ARGS_((
				Tcl_Interp * interp, CONST char * bundleName, 
				CONST char * bundleVersion, 
				int hasResourceFile, int maxPathLen, 
				char * libraryPath));
#endif
|#
 |#
;  MAC_OSX_TCL 
(defrecord TclPlatStubs
   (magic :signed-long)
   (hooks (:pointer :tclplatstubhooks))
; #ifdef __WIN32__
#| #|
    TCHAR * (*tcl_WinUtfToTChar) _ANSI_ARGS_((CONST char * str, int len, Tcl_DString * dsPtr)); 
    char * (*tcl_WinTCharToUtf) _ANSI_ARGS_((CONST TCHAR * str, int len, Tcl_DString * dsPtr)); 
#endif
|#
 |#
                                                ;  __WIN32__ 
; #ifdef MAC_TCL
#| #|
    void (*tcl_MacSetEventProc) _ANSI_ARGS_((Tcl_MacConvertEventPtr procPtr)); 
    char * (*tcl_MacConvertTextResource) _ANSI_ARGS_((Handle resource)); 
    int (*tcl_MacEvalResource) _ANSI_ARGS_((Tcl_Interp * interp, CONST char * resourceName, int resourceNumber, CONST char * fileName)); 
    Handle (*tcl_MacFindResource) _ANSI_ARGS_((Tcl_Interp * interp, long resourceType, CONST char * resourceName, int resourceNumber, CONST char * resFileRef, int * releaseIt)); 
    int (*tcl_GetOSTypeFromObj) _ANSI_ARGS_((Tcl_Interp * interp, Tcl_Obj * objPtr, OSType * osTypePtr)); 
    void (*tcl_SetOSTypeObj) _ANSI_ARGS_((Tcl_Obj * objPtr, OSType osType)); 
    Tcl_Obj * (*tcl_NewOSTypeObj) _ANSI_ARGS_((OSType osType)); 
    int (*strncasecmp) _ANSI_ARGS_((CONST char * s1, CONST char * s2, size_t n)); 
    int (*strcasecmp) _ANSI_ARGS_((CONST char * s1, CONST char * s2)); 
#endif
|#
 |#
                                                ;  MAC_TCL 
; #ifdef MAC_OSX_TCL
#| #|
    int (*tcl_MacOSXOpenBundleResources) _ANSI_ARGS_((Tcl_Interp * interp, CONST char * bundleName, int hasResourceFile, int maxPathLen, char * libraryPath)); 
    int (*tcl_MacOSXOpenVersionedBundleResources) _ANSI_ARGS_((Tcl_Interp * interp, CONST char * bundleName, CONST char * bundleVersion, int hasResourceFile, int maxPathLen, char * libraryPath)); 
#endif
|#
 |#
                                                ;  MAC_OSX_TCL 
)
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
(def-mactype :tclPlatStubsPtr (find-mactype '(:pointer :TclPlatStubs)))
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #if defined(USE_TCL_STUBS) && !defined(USE_TCL_STUB_PROCS)
#| 
; 
;  * Inline function declarations:
;  
; #ifdef __WIN32__
#|
#ifndefTcl_WinUtfToTChar
#define Tcl_WinUtfToTChar \
	(tclPlatStubsPtr->tcl_WinUtfToTChar) 
#endif#ifndefTcl_WinTCharToUtf
#define Tcl_WinTCharToUtf \
	(tclPlatStubsPtr->tcl_WinTCharToUtf) 
#endif#endif
|#
;  __WIN32__ 
; #ifdef MAC_TCL
#|
#ifndefTcl_MacSetEventProc
#define Tcl_MacSetEventProc \
	(tclPlatStubsPtr->tcl_MacSetEventProc) 
#endif#ifndefTcl_MacConvertTextResource
#define Tcl_MacConvertTextResource \
	(tclPlatStubsPtr->tcl_MacConvertTextResource) 
#endif#ifndefTcl_MacEvalResource
#define Tcl_MacEvalResource \
	(tclPlatStubsPtr->tcl_MacEvalResource) 
#endif#ifndefTcl_MacFindResource
#define Tcl_MacFindResource \
	(tclPlatStubsPtr->tcl_MacFindResource) 
#endif#ifndefTcl_GetOSTypeFromObj
#define Tcl_GetOSTypeFromObj \
	(tclPlatStubsPtr->tcl_GetOSTypeFromObj) 
#endif#ifndefTcl_SetOSTypeObj
#define Tcl_SetOSTypeObj \
	(tclPlatStubsPtr->tcl_SetOSTypeObj) 
#endif#ifndefTcl_NewOSTypeObj
#define Tcl_NewOSTypeObj \
	(tclPlatStubsPtr->tcl_NewOSTypeObj) 
#endif#ifndefstrncasecmp
#define strncasecmp \
	(tclPlatStubsPtr->strncasecmp) 
#endif#ifndefstrcasecmp
#define strcasecmp \
	(tclPlatStubsPtr->strcasecmp) 
#endif#endif
|#
;  MAC_TCL 
; #ifdef MAC_OSX_TCL
#|
#ifndefTcl_MacOSXOpenBundleResources
#define Tcl_MacOSXOpenBundleResources \
	(tclPlatStubsPtr->tcl_MacOSXOpenBundleResources) 
#endif#ifndefTcl_MacOSXOpenVersionedBundleResources
#define Tcl_MacOSXOpenVersionedBundleResources \
	(tclPlatStubsPtr->tcl_MacOSXOpenVersionedBundleResources) 
#endif#endif
|#
;  MAC_OSX_TCL 
 |#

; #endif /* defined(USE_TCL_STUBS) && !defined(USE_TCL_STUB_PROCS) */

;  !END!: Do not edit above this line. 

; #endif /* _TCLPLATDECLS */


(provide-interface "tclPlatDecls")