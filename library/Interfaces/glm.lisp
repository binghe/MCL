(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:glm.h"
; at Sunday July 2,2006 7:27:53 pm.
; 
;     File:	AGL/glm.h
; 
;     Contains:	Basic GLMemoryLibrary data types, constants and function prototypes.
; 
;     Version:	Technology:	Mac OS X
;                 Release:	GM
;  
;      Copyright:  (c) 2000-2002 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef _GLM_H
; #define _GLM_H

(require-interface "OpenGL/gl")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
; ** Interface version
; 
(defconstant $GLM_VERSION_2_0 1)
; #define GLM_VERSION_2_0                  1
; 
; ** Mode types - glmSetMode
; 
(defconstant $GLM_OVERRIDE_MODE 1)
; #define GLM_OVERRIDE_MODE                0x0001
(defconstant $GLM_SYSTEM_HEAP_MODE 2)
; #define GLM_SYSTEM_HEAP_MODE             0x0002
(defconstant $GLM_APPLICATION_HEAP_MODE 3)
; #define GLM_APPLICATION_HEAP_MODE        0x0003
(defconstant $GLM_MULTIPROCESSOR_MODE 4)
; #define GLM_MULTIPROCESSOR_MODE          0x0004
; 
; ** Function types - glmSetFunc
; 
(defconstant $GLM_PAGE_ALLOCATION_FUNC_PTR 1)
; #define GLM_PAGE_ALLOCATION_FUNC_PTR     0x0001
(defconstant $GLM_PAGE_FREE_FUNC_PTR 2)
; #define GLM_PAGE_FREE_FUNC_PTR           0x0002
(defconstant $GLM_ZERO_FUNC_PTR 3)
; #define GLM_ZERO_FUNC_PTR                0x0003
(defconstant $GLM_COPY_FUNC_PTR 4)
; #define GLM_COPY_FUNC_PTR                0x0004
(defconstant $GLM_SET_UBYTE_FUNC_PTR 5)
; #define GLM_SET_UBYTE_FUNC_PTR           0x0005
(defconstant $GLM_SET_USHORT_FUNC_PTR 6)
; #define GLM_SET_USHORT_FUNC_PTR          0x0006
(defconstant $GLM_SET_UINT_FUNC_PTR 7)
; #define GLM_SET_UINT_FUNC_PTR            0x0007
(defconstant $GLM_SET_DOUBLE_FUNC_PTR 8)
; #define GLM_SET_DOUBLE_FUNC_PTR          0x0008
; 
; ** Integer types - glmSetInteger
; 
(defconstant $GLM_PAGE_SIZE 1)
; #define GLM_PAGE_SIZE                    0x0001
; 
; ** Integer types - glmGetInteger
; 
; #define GLM_PAGE_SIZE                  0x0001
(defconstant $GLM_NUMBER_PAGES 2)
; #define GLM_NUMBER_PAGES                 0x0002
(defconstant $GLM_CURRENT_MEMORY 3)
; #define GLM_CURRENT_MEMORY               0x0003
(defconstant $GLM_MAXIMUM_MEMORY 4)
; #define GLM_MAXIMUM_MEMORY               0x0004
; 
; ** Integer types - glmGetError
; 
(defconstant $GLM_NO_ERROR 0)
; #define GLM_NO_ERROR                     0
(defconstant $GLM_INVALID_ENUM 1)
; #define GLM_INVALID_ENUM                 0x0001
(defconstant $GLM_INVALID_VALUE 2)
; #define GLM_INVALID_VALUE                0x0002
(defconstant $GLM_INVALID_OPERATION 3)
; #define GLM_INVALID_OPERATION            0x0003
(defconstant $GLM_OUT_OF_MEMORY 4)
; #define GLM_OUT_OF_MEMORY                0x0004
; 
; ** Function pointer types
; 

(def-mactype :GLMPageAllocFunc (find-mactype ':pointer)); (GLsizei size)

(def-mactype :GLMPageFreeFunc (find-mactype ':pointer)); (GLvoid * ptr)

(def-mactype :GLMZeroFunc (find-mactype ':pointer)); (GLubyte * buffer , GLsizei width , GLsizei height , GLsizei skip)

(def-mactype :GLMCopyFunc (find-mactype ':pointer)); (const GLubyte * src , GLubyte * dst , GLsizei width , GLsizei height , GLsizei src_skip , GLsizei dst_skip)

(def-mactype :GLMSetUByteFunc (find-mactype ':pointer)); (GLubyte * buffer , GLsizei width , GLsizei height , GLsizei skip , GLubyte value)

(def-mactype :GLMSetUShortFunc (find-mactype ':pointer)); (GLushort * buffer , GLsizei width , GLsizei height , GLsizei skip , GLushort value)

(def-mactype :GLMSetUIntFunc (find-mactype ':pointer)); (GLuint * buffer , GLsizei width , GLsizei height , GLsizei skip , GLuint value)

(def-mactype :GLMSetDoubleFunc (find-mactype ':pointer)); (GLdouble * buffer , GLsizei width , GLsizei height , GLsizei skip , GLdouble value)
(defrecord GLMfunctions
   (:variant
   (
   (page_alloc_func :pointer)
   )
   (
   (page_free_func :pointer)
   )
   (
   (zero_func :pointer)
   )
   (
   (copy_func :pointer)
   )
   (
   (set_ubyte_func :pointer)
   )
   (
   (set_ushort_func :pointer)
   )
   (
   (set_uint_func :pointer)
   )
   (
   (set_double_func :pointer)
   )
   )
)
; 
; ** Prototypes
; 

(deftrap-inline "_glmSetMode" 
   ((mode :UInt32)
   )
   nil
() )

(deftrap-inline "_glmSetFunc" 
   ((type :UInt32)
    (func (:pointer :GLMFUNCTIONS))
   )
   nil
() )

(deftrap-inline "_glmSetInteger" 
   ((param :UInt32)
    (value :signed-long)
   )
   nil
() )

(deftrap-inline "_glmGetInteger" 
   ((param :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_glmPageFreeAll" 
   (
   )
   nil
() )

(deftrap-inline "_glmMalloc" 
   ((size :signed-long)
   )
   (:pointer :GLVOID)
() )

(deftrap-inline "_glmCalloc" 
   ((nmemb :signed-long)
    (size :signed-long)
   )
   (:pointer :GLVOID)
() )

(deftrap-inline "_glmRealloc" 
   ((ptr (:pointer :GLVOID))
    (size :signed-long)
   )
   (:pointer :GLVOID)
() )

(deftrap-inline "_glmFree" 
   ((ptr (:pointer :GLVOID))
   )
   nil
() )
;  16 byte aligned 

(deftrap-inline "_glmVecAlloc" 
   ((size :signed-long)
   )
   (:pointer :GLVOID)
() )

(deftrap-inline "_glmVecFree" 
   ((ptr (:pointer :GLVOID))
   )
   nil
() )
;  32 byte aligned and 32 byte padded 

(deftrap-inline "_glmDCBAlloc" 
   ((size :signed-long)
   )
   (:pointer :GLVOID)
() )

(deftrap-inline "_glmDCBFree" 
   ((ptr (:pointer :GLVOID))
   )
   nil
() )

(deftrap-inline "_glmZero" 
   ((buffer (:pointer :GLUBYTE))
    (width :signed-long)
    (height :signed-long)
    (rowbytes :signed-long)
   )
   nil
() )

(deftrap-inline "_glmCopy" 
   ((src (:pointer :GLUBYTE))
    (dst (:pointer :GLUBYTE))
    (width :signed-long)
    (height :signed-long)
    (src_rowbytes :signed-long)
    (dst_rowbytes :signed-long)
   )
   nil
() )

(deftrap-inline "_glmSetUByte" 
   ((buffer (:pointer :GLUBYTE))
    (width :signed-long)
    (height :signed-long)
    (row_elems :signed-long)
    (value :UInt8)
   )
   nil
() )

(deftrap-inline "_glmSetUShort" 
   ((buffer (:pointer :GLUSHORT))
    (width :signed-long)
    (height :signed-long)
    (row_elems :signed-long)
    (value :UInt16)
   )
   nil
() )

(deftrap-inline "_glmSetUInt" 
   ((buffer (:pointer :GLUINT))
    (width :signed-long)
    (height :signed-long)
    (row_elems :signed-long)
    (value :UInt32)
   )
   nil
() )

(deftrap-inline "_glmSetDouble" 
   ((buffer (:pointer :GLDOUBLE))
    (width :signed-long)
    (height :signed-long)
    (row_elems :signed-long)
    (value :double-float)
   )
   nil
() )

(deftrap-inline "_glmGetError" 
   (
   )
   :UInt32
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _GLM_H */


(provide-interface "glm")