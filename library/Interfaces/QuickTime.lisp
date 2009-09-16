(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QuickTime.h"
; at Sunday July 2,2006 7:31:23 pm.
; 
;      File:       QuickTime/QuickTime.h
;  
;      Contains:   Master include for all of QuickTime on OS X
;  
;      Version:    QuickTime_6
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __QUICKTIME__
; #define __QUICKTIME__
; #ifndef __CARBON__
#| #|
#include <CarbonCarbon.h>
#endif
|#
 |#
; #ifndef __QTML__
#| #|
#include <QuickTimeQTML.h>
#endif
|#
 |#
; #ifndef __MEDIAHANDLERS__
#| #|
#include <QuickTimeMediaHandlers.h>
#endif
|#
 |#
; #ifndef __MOVIES__
#| #|
#include <QuickTimeMovies.h>
#endif
|#
 |#
; #ifndef __MOVIESFORMAT__
#| #|
#include <QuickTimeMoviesFormat.h>
#endif
|#
 |#
; #ifndef __QUICKTIMEVR__

(require-interface "QuickTime/QuickTimeVR")

; #endif

; #ifndef __QUICKTIMEVRFORMAT__

(require-interface "QuickTime/QuickTimeVRFormat")

; #endif

; #ifndef __IMAGECOMPRESSION__
#| #|
#include <QuickTimeImageCompression.h>
#endif
|#
 |#
; #ifndef __IMAGECODEC__
#| #|
#include <QuickTimeImageCodec.h>
#endif
|#
 |#
; #ifndef __QUICKTIMEMUSIC__
#| #|
#include <QuickTimeQuickTimeMusic.h>
#endif
|#
 |#
; #ifndef __QUICKTIMECOMPONENTS__
#| #|
#include <QuickTimeQuickTimeComponents.h>
#endif
|#
 |#
; #ifndef __QUICKTIMESTREAMING__
#| #|
#include <QuickTimeQuickTimeStreaming.h>
#endif
|#
 |#
; #ifndef __QTSMOVIE__
#| #|
#include <QuickTimeQTSMovie.h>
#endif
|#
 |#
; #ifndef __QTSTREAMINGCOMPONENTS__
#| #|
#include <QuickTimeQTStreamingComponents.h>
#endif
|#
 |#

; #endif /* __QUICKTIME__ */


(provide-interface "QuickTime")