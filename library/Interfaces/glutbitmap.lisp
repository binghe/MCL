(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:glutbitmap.h"
; at Sunday July 2,2006 7:27:55 pm.
; #ifndef __glutbitmap_h__
; #define __glutbitmap_h__
;  Copyright (c) Mark J. Kilgard, 1994. 
;  This program is freely distributable without licensing fees 
;    and is provided without guarantee or warrantee expressed or 
;    implied. This program is -not- in the public domain. 

(require-interface "glut")
(defrecord BitmapCharRec
   (width :signed-long)
   (height :signed-long)
   (xorig :single-float)
   (yorig :single-float)
   (advance :single-float)
   (bitmap (:pointer :GLUBYTE))
#|
 confused about , * BitmapCharPtr
|#
)
(defrecord BitmapFontRec
   (name (:pointer :char))
   (num_chars :signed-long)
   (first :signed-long)
   (const (:pointer :callback))                 ;(BitmapCharRec * * ch)
#|
 confused about , * BitmapFontPtr
|#
)

(def-mactype :GLUTbitmapFont (find-mactype '(:pointer :void)))

; #endif /* __glutbitmap_h__ */


(provide-interface "glutbitmap")