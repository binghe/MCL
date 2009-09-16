(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QD.h"
; at Sunday July 2,2006 7:23:47 pm.
; 
;      File:       QD/QD.h
;  
;      Contains:   Master include for QD private framework
;  
;      Version:    Quickdraw-150~1
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __QD__
; #define __QD__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __COREGRAPHICS__

(require-interface "CoreGraphics/CoreGraphics")

; #endif

; #ifndef __COLORSYNC__

(require-interface "ColorSync/ColorSync")

; #endif

; #ifndef __ATS__
#| #|
#include <ATSATS.h>
#endif
|#
 |#
; #ifndef __AE__

(require-interface "AE/AE")

; #endif

; #ifndef __QUICKDRAW__

(require-interface "QD/Quickdraw")

; #endif

; #ifndef __QDOFFSCREEN__

(require-interface "QD/QDOffscreen")

; #endif

; #ifndef __QDPICTTOCGCONTEXT__

(require-interface "QD/QDPictToCGContext")

; #endif

; #ifndef __QUICKDRAWTEXT__
#| #|
#include <QDQuickdrawText.h>
#endif
|#
 |#
; #ifndef __FONTS__

(require-interface "QD/Fonts")

; #endif

; #ifndef __PALETTES__

(require-interface "QD/Palettes")

; #endif

; #ifndef __PICTUTILS__

(require-interface "QD/PictUtils")

; #endif

; #ifndef __VIDEO__

(require-interface "QD/Video")

; #endif

; #ifndef __DISPLAYS__

(require-interface "QD/Displays")

; #endif

; #ifndef __FONTSYNC__

(require-interface "QD/FontSync")

; #endif

; #ifndef __ATSUNICODE__

(require-interface "QD/ATSUnicode")

; #endif

; #ifndef __ATSUNICODETYPES__
#| #|
#include <QDATSUnicodeTypes.h>
#endif
|#
 |#
; #ifndef __ATSUNICODEOBJECTS__
#| #|
#include <QDATSUnicodeObjects.h>
#endif
|#
 |#
; #ifndef __ATSUNICODEDRAWING__
#| #|
#include <QDATSUnicodeDrawing.h>
#endif
|#
 |#
; #ifndef __ATSUNICODEFONTS__
#| #|
#include <QDATSUnicodeFonts.h>
#endif
|#
 |#
; #ifndef __ATSUNICODEGLYPHS__
#| #|
#include <QDATSUnicodeGlyphs.h>
#endif
|#
 |#
; #ifndef __ATSUNICODEFLATTENING__
#| #|
#include <QDATSUnicodeFlattening.h>
#endif
|#
 |#
; #ifndef __ATSUNICODEDIRECTACCESS__
#| #|
#include <QDATSUnicodeDirectAccess.h>
#endif
|#
 |#

; #endif /* __QD__ */


(provide-interface "QD")