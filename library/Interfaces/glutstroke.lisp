(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:glutstroke.h"
; at Sunday July 2,2006 7:27:55 pm.
; #ifndef __glutstroke_h__
; #define __glutstroke_h__
;  Copyright (c) Mark J. Kilgard, 1994. 
;  This program is freely distributable without licensing fees 
;    and is provided without guarantee or warrantee expressed or 
;    implied. This program is -not- in the public domain. 

; #if defined(_WIN32)
#| ; #pragma warning (disable:4244)  /* disable bogus conversion warnings */
; #pragma warning (disable:4305)  /* VC++ 5.0 version of above warning. */
 |#

; #endif

(defrecord CoordRec
   (x :single-float)
   (y :single-float)
#|
 confused about , * CoordPtr
|#
)
(defrecord StrokeRec
   (num_coords :signed-long)
   (coord (:pointer :COORDREC))
#|
 confused about , * StrokePtr
|#
)
(defrecord StrokeCharRec
   (num_strokes :signed-long)
   (stroke (:pointer :STROKEREC))
   (center :single-float)
   (right :single-float)
#|
 confused about , * StrokeCharPtr
|#
)
(defrecord StrokeFontRec
   (name (:pointer :char))
   (num_chars :signed-long)
   (ch (:pointer :STROKECHARREC))
   (top :single-float)
   (bottom :single-float)
#|
 confused about , * StrokeFontPtr
|#
)

(def-mactype :GLUTstrokeFont (find-mactype '(:pointer :void)))

; #endif /* __glutstroke_h__ */


(provide-interface "glutstroke")