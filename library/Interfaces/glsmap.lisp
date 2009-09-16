(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:glsmap.h"
; at Sunday July 2,2006 7:27:54 pm.
; #ifndef __glsmap_h__
; #define __glsmap_h__
;  Copyright (c) Mark J. Kilgard, 1998.  
;  This program is freely distributable without licensing fees
;    and is provided without guarantee or warrantee expressed or
;    implied. This program is -not- in the public domain. 

; #if defined(_WIN32)
#| 
;  Try hard to avoid including <windows.h> to avoid name space pollution,
;    but Win32's <GL/gl.h> needs APIENTRY and WINGDIAPI defined properly. 

; # if 0
; #  define  WIN32_LEAN_AND_MEAN

(require-interface "windows")

; # else
;  XXX This is from Win32's <windef.h> 
; #  ifndef APIENTRY

; #   if (_MSC_VER >= 800) || defined(_STDCALL_SUPPORTED)
; #    define APIENTRY    __stdcall

; #   else
; #    define APIENTRY

; #   endif


; #  endif

; #  ifndef CALLBACK
;  XXX This is from Win32's <winnt.h> 

; #   if (defined(_M_MRX000) || defined(_M_IX86) || defined(_M_ALPHA) || defined(_M_PPC)) && !defined(MIDL_PASS)
; #    define CALLBACK __stdcall

; #   else
; #    define CALLBACK

; #   endif


; #  endif

;  XXX This is from Win32's <wingdi.h> and <winnt.h> 
; #  ifndef WINGDIAPI
; #   define WINGDIAPI __declspec(dllimport)

; #  endif

;  XXX This is from Win32's <ctype.h> 
; #  ifndef _WCHAR_T_DEFINED

(def-mactype :wchar_t (find-mactype ':UInt16))
; #   define _WCHAR_T_DEFINED

; #  endif


; # endif

; #pragma warning (disable:4244)	/* Disable bogus conversion warnings. */
; #pragma warning (disable:4305)  /* VC++ 5.0 version of above warning. */
 |#

; #endif /* _WIN32 */


(require-interface "OpenGL/gl")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(defconstant $SMAP_CLEAR_SMAP_TEXTURE 1)
(defconstant $SMAP_GENERATE_VIEW_MIPMAPS 2)
(defconstant $SMAP_GENERATE_SMAP_MIPMAPS 4)
(defconstant $SMAP_GENERATE_MIPMAPS 6)          ;  both of above 

(def-mactype :SphereMapFlags (find-mactype ':SINT32))
;  Cube view enumerants. 

(defconstant $SMAP_FRONT 0)
(defconstant $SMAP_TOP 1)
(defconstant $SMAP_BOTTOM 2)
(defconstant $SMAP_LEFT 3)
(defconstant $SMAP_RIGHT 4)
(defconstant $SMAP_BACK 5)

(def-mactype :SphereMap (find-mactype ':_SphereMap))

(deftrap-inline "_smapCreateSphereMap" 
   ((shareSmap (:pointer :SPHEREMAP))
   )
   (:pointer :SPHEREMAP)
() )

(deftrap-inline "_smapDestroySphereMap" 
   ((smap (:pointer :SPHEREMAP))
   )
   nil
() )

(deftrap-inline "_smapConfigureSphereMapMesh" 
   ((smap (:pointer :SPHEREMAP))
    (steps :signed-long)
    (rings :signed-long)
    (edgeExtend :signed-long)
   )
   nil
() )

(deftrap-inline "_smapSetSphereMapTexObj" 
   ((smap (:pointer :SPHEREMAP))
    (texobj :UInt32)
   )
   nil
() )

(deftrap-inline "_smapSetViewTexObj" 
   ((smap (:pointer :SPHEREMAP))
    (texobj :UInt32)
   )
   nil
() )

(deftrap-inline "_smapSetViewTexObjs" 
   ((smap (:pointer :SPHEREMAP))
    (texobjs (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_smapGetSphereMapTexObj" 
   ((smap (:pointer :SPHEREMAP))
    (texobj (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_smapGetViewTexObj" 
   ((smap (:pointer :SPHEREMAP))
    (texobj (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_smapGetViewTexObjs" 
   ((smap (:pointer :SPHEREMAP))
    (texobjs (:pointer :GLUINT))
   )
   nil
() )

(deftrap-inline "_smapSetFlags" 
   ((smap (:pointer :SPHEREMAP))
    (flags :SInt32)
   )
   nil
() )

(deftrap-inline "_smapGetFlags" 
   ((smap (:pointer :SPHEREMAP))
    (flags (:pointer :SphereMapFlags))
   )
   nil
() )

(deftrap-inline "_smapSetViewOrigin" 
   ((smap (:pointer :SPHEREMAP))
    (x :signed-long)
    (y :signed-long)
   )
   nil
() )

(deftrap-inline "_smapSetSphereMapOrigin" 
   ((smap (:pointer :SPHEREMAP))
    (x :signed-long)
    (y :signed-long)
   )
   nil
() )

(deftrap-inline "_smapGetViewOrigin" 
   ((smap (:pointer :SPHEREMAP))
    (x (:pointer :GLINT))
    (y (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_smapGetSphereMapOrigin" 
   ((smap (:pointer :SPHEREMAP))
    (x (:pointer :GLINT))
    (y (:pointer :GLINT))
   )
   nil
() )

(deftrap-inline "_smapSetEye" 
   ((smap (:pointer :SPHEREMAP))
    (eyex :single-float)
    (eyey :single-float)
    (eyez :single-float)
   )
   nil
() )

(deftrap-inline "_smapSetEyeVector" 
   ((smap (:pointer :SPHEREMAP))
    (eye (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_smapSetUp" 
   ((smap (:pointer :SPHEREMAP))
    (upx :single-float)
    (upy :single-float)
    (upz :single-float)
   )
   nil
() )

(deftrap-inline "_smapSetUpVector" 
   ((smap (:pointer :SPHEREMAP))
    (up (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_smapSetObject" 
   ((smap (:pointer :SPHEREMAP))
    (objx :single-float)
    (objy :single-float)
    (objz :single-float)
   )
   nil
() )

(deftrap-inline "_smapSetObjectVector" 
   ((smap (:pointer :SPHEREMAP))
    (obj (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_smapGetEye" 
   ((smap (:pointer :SPHEREMAP))
    (eyex (:pointer :GLFLOAT))
    (eyey (:pointer :GLFLOAT))
    (eyez (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_smapGetEyeVector" 
   ((smap (:pointer :SPHEREMAP))
    (eye (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_smapGetUp" 
   ((smap (:pointer :SPHEREMAP))
    (upx (:pointer :GLFLOAT))
    (upy (:pointer :GLFLOAT))
    (upz (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_smapGetUpVector" 
   ((smap (:pointer :SPHEREMAP))
    (up (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_smapGetObject" 
   ((smap (:pointer :SPHEREMAP))
    (objx (:pointer :GLFLOAT))
    (objy (:pointer :GLFLOAT))
    (objz (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_smapGetObjectVector" 
   ((smap (:pointer :SPHEREMAP))
    (obj (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_smapSetNearFar" 
   ((smap (:pointer :SPHEREMAP))
    (viewNear :single-float)
    (viewFar :single-float)
   )
   nil
() )

(deftrap-inline "_smapGetNearFar" 
   ((smap (:pointer :SPHEREMAP))
    (viewNear (:pointer :GLFLOAT))
    (viewFar (:pointer :GLFLOAT))
   )
   nil
() )

(deftrap-inline "_smapSetSphereMapTexDim" 
   ((smap (:pointer :SPHEREMAP))
    (texdim :signed-long)
   )
   nil
() )

(deftrap-inline "_smapSetViewTexDim" 
   ((smap (:pointer :SPHEREMAP))
    (texdim :signed-long)
   )
   nil
() )

(deftrap-inline "_smapGetSphereMapTexDim" 
   ((smap (:pointer :SPHEREMAP))
    (texdim (:pointer :GLSIZEI))
   )
   nil
() )

(deftrap-inline "_smapGetViewTexDim" 
   ((smap (:pointer :SPHEREMAP))
    (texdim (:pointer :GLSIZEI))
   )
   nil
() )

(deftrap-inline "_smapSetContextData" 
   ((smap (:pointer :SPHEREMAP))
    (context :pointer)
   )
   nil
() )

(deftrap-inline "_smapGetContextData" 
   ((smap (:pointer :SPHEREMAP))
    (context :pointer)
   )
   nil
() )

(deftrap-inline "_smapSetPositionLightsFunc" 
   ((smap (:pointer :SPHEREMAP))
    (positionLights (:pointer :callback))       ;(void (int view , void * context))

   )
   nil
() )

(deftrap-inline "_smapSetDrawViewFunc" 
   ((smap (:pointer :SPHEREMAP))
    (drawView (:pointer :callback))             ;(void (int view , void * context))

   )
   nil
() )

(deftrap-inline "_smapGetPositionLightsFunc" 
   ((smap (:pointer :SPHEREMAP))
    (positionLights (:pointer :callback))       ;(void (int view , void * context))

   )
   nil
() )

(deftrap-inline "_smapGetDrawViewFunc" 
   ((smap (:pointer :SPHEREMAP))
    (drawView (:pointer :callback))             ;(void (int view , void * context))

   )
   nil
() )

(deftrap-inline "_smapGenViewTex" 
   ((smap (:pointer :SPHEREMAP))
    (view :signed-long)
   )
   nil
() )

(deftrap-inline "_smapGenViewTexs" 
   ((smap (:pointer :SPHEREMAP))
   )
   nil
() )

(deftrap-inline "_smapGenSphereMapFromViewTexs" 
   ((smap (:pointer :SPHEREMAP))
   )
   nil
() )

(deftrap-inline "_smapGenSphereMap" 
   ((smap (:pointer :SPHEREMAP))
   )
   nil
() )

(deftrap-inline "_smapGenSphereMapWithOneViewTex" 
   ((smap (:pointer :SPHEREMAP))
   )
   nil
() )

(deftrap-inline "_smapRvecToSt" 
   ((rvec (:pointer :float))
    (st (:pointer :float))
   )
   :signed-long
() )

(deftrap-inline "_smapStToRvec" 
   ((st (:pointer :float))
    (rvec (:pointer :float))
   )
   nil
() )
; #ifdef __cplusplus
#| #|
}

#endif
|#
 |#

; #endif /* __glsmap_h__ */


(provide-interface "glsmap")