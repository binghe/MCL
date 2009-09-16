;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: color.lisp,v $
;;  Revision 1.12  2006/02/03 22:11:51  alice
;;  ; lose get-aux-control and friend
;;
;;  Revision 1.11  2004/07/06 20:45:27  alice
;;  ; with-fore-color and with-back-color - memory of themedrawingstate is window specific, not global
;;
;;  Revision 1.10  2004/07/04 08:24:04  alice
;;   set-part-color window :content puts new color in back-color slot too
;;
;;  Revision 1.9  2004/05/11 20:36:29  alice
;;  ; 05/10/04 *tool-back-color* lighter if osx
;;
;;  Revision 1.8  2004/05/02 01:35:32  alice
;;  small change for timer in user-pick-color - still doesn't work
;;
;;  Revision 1.7  2004/03/01 00:09:28  alice
;;  use theme-background slot in with-fore-color and with-back-color
;;
;;  Revision 1.6  2004/01/19 22:03:59  alice
;;  ; 12/28/03 user-pick-color whines on OSX if timer is desired
; 12/18/03 avoid timer in user-pick-color if OS9 - hangs the app
;;
;;  Revision 1.5  2003/12/07 00:18:38  alice
;;   12/02/03 user-pick-color timer stuff - doesn't work
; 11/01/03 theme-background not osx dependent - its in two macros
;;
;;  Revision 1.4  2003/02/06 19:31:45  gtbyers
;;  Move defvars of *IS-INITIALIZED*,  a few other things to l1-init.
;;
;;  7 10/22/97 akh  see below
;;  6 10/5/97  akh  see below
;;  5 6/9/97   akh  see below
;;  4 6/2/97   akh  no part-color method for table-dialog-item
;;  10 10/3/96 slh  dont call initialize-fred-palette unless fbound
;;  9 4/19/96  akh  Karsten's fix for menu defaults
;;  7 3/9/96   akh  (with-port %temp-port% ..) in user-pick-color (why?)
;;  2 10/17/95 akh  merge patches
;;  2 4/10/95  akh  set-part-color returns old color too.
;;  7 3/2/95   akh  define *tool-back-color*, *tool-line-color*
;;  6 2/17/95  akh  make *lighter-gray-color* better for 8 bit color.
;;                  (why is this dialog item gray?)
;;  5 2/17/95  akh  mumble some comments re gray colors
;;  3 1/25/95  akh  added *lighter-gray-color*
;;  (do not edit before this line!!)

;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-2000 Digitool, Inc.

; Modification History
;
;; no change
;; ------ 5.2b5
; lose get-aux-control and friend
; with-fore-color and with-back-color - memory of themedrawingstate is window specific, not global
; set-part-color window :content puts new color in back-color slot too
; ------- 5.1b2
; 05/10/04 *tool-back-color* lighter if osx
; 12/28/03 user-pick-color whines on OSX if timer is desired
; 12/18/03 avoid timer in user-pick-color if OS9 - hangs the app
; 12/02/03 user-pick-color timer stuff - doesn't work
; 11/01/03 theme-background not osx dependent - its in two macros 
; 10/28/03 fix set-part-color for window :content - from Gary King
; menubar color-list slot is inited to NIL for CLIM.
; with-fore-color also theme-background aware and hopefully we only normalizethemedrawingstate once - weird
; set-menu-color-table for menubar warns vs crashing if osx-p
; with-back-color is theme-background aware
; ------- 4.4b3
; 09/01/00 akh  make-color divide by 256 vs 257 - same as _color2index when millions? 
; def-ccl-pointers scrap moves to ccl-menus.lisp
;10/21/97 akh  def-ccl-pointers scrap - nullify *external-style-scrap*
;06/04/97 akh  initialize-fred-palette moves here for sure this time
;06/03/97 akh  def-ccl-pointers scrap moves here because initialize-fred-palette has to happen first
;05/14/97 akh  comment out redundant and wrong set-part-color for table-dialog-item
;05/20/97 bill Steven Feist's fix to find-screen
;------------- 4.1
;04/15/97 bill What used to be the body of (def-ccl-pointers color-menubar ...)
;              moves to initialize-menubar-color. That is called by
;              (method menu-install (menu)). This causes that code to run
;              after the first menu has been installed instead of before.
;              Apparently there is no menu color table until the first menu
;              is installed. This fixes Andrew Begel's "Font Color" menu background
;              color bug.
;------------- 4.1b2
;03/12/96 bill alanr's fixes to set-table-color, (method set-part-color (window t t))
;01/17/96 bill (initialize-fred-palette) moves here from "ccl:l1;new-fred-window.lisp".
;              set-menu-color-table does nothing if the menu-id is NIL.
;              (method update-color-defaults (menu)) doesn't call traps on null ids.
;01/10/96 bill update-color-defaults doesn't attempt to call a trap on NIL menu-id
;12/05/95 slh  update trap names
;10/24/95 slh  de-lapified: set-menu-color-table; use rlet, BlockMoveData.
; 5/03/95 slh  requires
;06/27/94 bill Karsten Poeck's fix to (method set-part-color (table-dialog-item t t))
;              Changing the color of a cell only redraws that cell, not the whole table.
;------------- 3.0d13
;11/19/92 bill grafport-fore-color, grafport-back-color
;08/25/92 bill Oliver's patch to make-color, color-red & friends.
;08/10/92 bill modernize some of the trap calls. Autoload some constants.
;05/01/92 bill find-best-color-screen returns two more values: color-p & bits/pixel
;04/21/92 bill (method set-part-color (table-dialog-item t t)) needed to focus
;03/04/92 bill (method set-part-color (control-dialog-item t t)) needed to focus.
;------------- 2.0
;03/16/92 bill Make setting colors for the menubar work correctly.
;              Used to get random colors if there was no menubar color table.
;              This is a system 7 bug, I believe, as the menubar entry
;              is deleted as soon as a menu is pulled down.
;------------  2.0f3
;01/07/92 gb   don't require RECORDS.
;10/30/91 bill remove -iv on the end of slot names
;08/24/91 gb   with-new-trap-syntax.
;06/21/91 bill with-back-color
;06/21/91 bill find-screen & find-best-color-screen work when no *color-available*
;06/10/91 bill find-screen
;------------- 2.0b2
;04/16/91 bill Add #| commented-out |# code to test for the _GetAuxCtl bug.
;03/20/91 bill ALMS's fix to (method set-part-color (table-dialog-item t t))
;03/14/91 bill new optional rgb arg to color-to-rgb.
;03/12/91 bill patch set-control-part-color to get around bug in _GetAuxCtl in system 7.
;02/22/91 bill remove redundant definition of *light-gray-color*
;03/04/91 alice report-bad-arg gets 2 args or use error instead.
;------------ 2.0b1
;01//8/91 bill Macros use require-trap vice assuming TRAPS & RECORDS are loaded.
;11/20/90 bill Bullet-proof find-best-color-screen
;11/05/90 bill *white-color* moves to l1-init.lisp
;11/02/90 bill make set-back-color invalidate the view the new way.
;07/05/90 bill nix wptr-if-bound
;06/25/90 bill add redisplay-p arg to set-back-color,
;              eliminate %set-fore-color, %set-back-color, %get-fore-color per ALMS
;              add :position arg to user-pick-color and make args keywords.
;06/19/90 bill set-part-color for window returns the new-color
;05/04/90 bill set-color-defaults: do nothing unless *color-available*
;04/12/90 bill Remove mouse-location arg from user-pick-color
;04/03/90 bill auxctlrec is a handle structure.
;              Add a %get-ptr to default-control-color-table
;03/27/90 bill _GetMaxDevice shouldn't return NULL, but it sometimes does.
;03/26/90 bill %car & %cadr were unsafe in set-part-color-loop
;03/17/90 bill if set-part-color for control-dialog-item & table-dialog-item:
;              (wptr ...) => (wptr-if-bound ...)
;03/13/90 bill find-best-color-screen for user-pick-color.
;              screen-xxx, do-screens.
;03/12/90 bill dialog-items no longer have a slot named 'my-dialog
;02/27/90 bill real-color-equal
;02/15/90 bill inval-dialog-item => invalidate-view.
;12/29/89 bill *color-available* & *black-color* moved to l1-init
;12/26/89 bill missing args to default-window-color-table
;09/16/89 bill Removed the last vestiges of object-lisp windows.
; 09/09/89 bill Convert dialog obfuns to defmethods.  Add color window methods.
; 07/28/89 bill "dialog-" => "dialog-object-"
;7/20/89   gz  clos menus.  color stuff from sysutils.
;4/24/89   gz  recompute %initial-menubar-colors in dumped lisp.
;20-apr-89 as lisp-2.0-ification
;12/20/88 as  get-fore-color, get-back-color
;12/7/88  as  many changes
;12/6/88  as  (set-part-color *menu*) doesn't redraw as much
;10/29/88 as  user-pick-color defaults color to *black-color*
;10/6/88  as  user-pick-color throws to cancel

(in-package :ccl)

(eval-when (:execute :compile-toplevel)
  ;(require "TOOLEQU")
  (require "LISPEQU")
  (require "LEVEL-2"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           color-support                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; color stuff

; we moved this stuff here to color.lisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; This  adds color to font specs and Fred windows & dialog items.
;;; A font spec can have one of 256 colors. The colors are represented
;;; by their index in the system 8-bit color table, with the exception
;;; that color index 0 means use the default foreground color.
;;;
;;; A font spec can now have a (:color x) or (:color-index y) entry.
;;; x is a 24-bit MCL color, as returned by make-color
;;; y is an integer between 0 and 255 inclusive.
;;; Examples: (font-codes '("Monaco" 12 :bold (:color #.*red-color*)))
;;;           (font-codes '("Chicago" 9 (:color-index 5)))
;;;
;;; should we be conditional on *color-available* which isnt defined till later?

;;; should we be conditional on *color-available* which isnt defined till later?
;;; It shouldn't be later, initializing it is on *lisp-system-pointer-functions*
;;; and this is on *lisp-user-pointer-functions*.  -- K‡lm‡n

(defun initialize-fred-palette ()
  (let (ctable)
    (if *color-available*
      (unwind-protect
        (progn
          (setq ctable (#_GetCTable 72))
          (when (%null-ptr-p ctable)
            (error "Can't allocate color table"))
          (let* ((entries (1+ (href ctable :colorTable.ctSize)))
                 (palette (#_NewPalette entries ctable #$pmCourteous 0)))
            (when (%null-ptr-p palette)
              (error "Couldn't allocate palette"))
            #|
          (rlet ((rgb :RGBColor
                      :red 0 :green 0 :blue 0))
            (#_SetEntryColor palette 0 rgb)
            (setf (pref rgb :RGBColor.red) 65535
                  (pref rgb :RGBColor.green) 65535
                  (pref rgb :RGBColor.blue) 65535)
            (#_SetEntryColor palette (1- entries) rgb))
          |#
            (setq *fred-palette* palette)))
        (when (and ctable (not (%null-ptr-p ctable)))
          (#_DisposeCTable ctable)))
      (setq *fred-palette* nil))
    )
  nil)


#| Moved to l1-init
(defvar *color-available*  nil)
|#


(def-ccl-pointers color ()
  (setq *color-available* (getf *environs* :color-quickdraw))
  (when (fboundp 'initialize-fred-palette)
    (initialize-fred-palette)))



;;;;;;;;;
;;
;;  color abstraction
;;  a "color" is an rgb stored in 24 bits of a fixnum
;;  a few redefinitions could easily change this storage
;;  to make for more bits of color at the cost of consing
;;
;;  this could use some lapification, and possibly inlining
;;

#|
(defun make-color (red green blue)
  "given red, green, and blue, returns an encoded rgb value"
  (flet ((check-color (color)
           (unless (and (fixnump color)
                        (<= 0 (the fixnum color))
                        (<= (the fixnum color) 65535))
             (error "Illegal color component: ~s" color))))
    (declare (inline check-color))
    (check-color red)
    (check-color green)
    (check-color blue))
  (locally (declare (fixnum red green blue))
    (logior (the fixnum (ash (the fixnum (round red 257)) 16))
            (the fixnum (ash (the fixnum (round green 257)) 8))
            (the fixnum (round blue 257)))))


(defun make-color (red green blue)
  "given red, green, and blue, returns an encoded rgb value"
  (flet ((check-color (color)
           (unless (and (fixnump color)
                        (<= 0 (the fixnum color))
                        (<= (the fixnum color) 65535))
             (error "Illegal color component: ~s" color))))
    (declare (inline check-color))
    (check-color red)
    (check-color green)
    (check-color blue))
  (locally (declare (fixnum red green blue))
    (let* ((r (round red 256))
           (g (round green 256))
           (b (round blue 256)))
      (declare (fixnum r g b))
      (logior (the fixnum (ash  (the fixnum (min r 255)) 16))
              (the fixnum (ash (the fixnum (min g 255)) 8))
              (the fixnum (min b 255))))))

(let ((rgb3 (make-record :rgbcolor)))
  (setf (rref rgb3 :rgbcolor.red) 0)
  (setf (rref rgb3 :rgbcolor.green) 0)
  (dotimes (i 65536)
    (setf (rref rgb3 :rgbcolor.blue) i)    
    (when (neq (#_color2index rgb3) (truncate i 256)) (print i))))


(defun make-color (red green blue)
  "given red, green, and blue, returns an encoded rgb value"
  (flet ((check-color (color)
           (unless (and (fixnump color)
                        (<= 0 (the fixnum color))
                        (<= (the fixnum color) 65535))
             (error "Illegal color component: ~s" color))))
    (declare (inline check-color))
    (check-color red)
    (check-color green)
    (check-color blue))
  (locally (declare (fixnum red green blue))
    (let* ((r (truncate red 256))
           (g (truncate green 256))
           (b (truncate blue 256)))
      (declare (fixnum r g b))
      (logior (the fixnum (ash  r 16))
              (the fixnum (ash g 8))
              (the fixnum b)))))
|#

(defun make-color (red green blue)
  "given red, green, and blue, returns an encoded rgb value"
  (flet ((check-color (color)
           (unless (and (fixnump color)
                        (<= 0 (the fixnum color))
                        (<= (the fixnum color) 65535))
             (error "Illegal color component: ~s" color))))
    (declare (inline check-color))
    (check-color red)
    (check-color green)
    (check-color blue))
  (locally (declare (fixnum red green blue))
    (let* ((r (logand red #xff00))
           (g (logand green #xff00))
           (b (logand blue #xff00)))
      (declare (fixnum r g b))
      (logior (the fixnum (ash  r 8))
              (the fixnum g)
              (the fixnum (ash b -8))))))

;; now if only we understood why it puts the 8 bits in top and bottom of 16 ...
(defun color-red (color &optional (component (logand (the fixnum (lsh color -16)) #xff)))
  "returns the red portion of the color"
  (declare (fixnum component))
  (the fixnum (+ (the fixnum (ash component 8)) component)))

(defun color-green (color &optional (component (logand (the fixnum (lsh color -8)) #xff)))
  "returns the green portion of the color"
  (declare (fixnum component))
  (the fixnum (+ (the fixnum (ash component 8)) component)))

(defun color-blue (color &optional (component (logand color #xff)))
  "returns the blue portion of the color"
  (declare (fixnum component))
  (the fixnum (+ (the fixnum (ash component 8)) component)))

(defun color-values (color)
  "given an encoded color, returns the red, green, and blue components"
  (values
   (color-red color)
   (color-green color)
   (color-blue color)))

(defun color-to-rgb (color &optional rgb)
  "given an encoded rgb, returns a color record"
  (multiple-value-bind (red green blue)
                       (color-values color)
    (if (and rgb (macptrp rgb))
      (progn
        (setf (rref rgb rgbcolor.red) red)
        (setf (rref rgb rgbcolor.green) green)
        (setf (rref rgb rgbcolor.blue) blue)
        rgb)
      (make-record :rgbcolor
                   :red red
                   :green green
                   :blue blue))))

(defun rgb-to-color (rgb)
  "returns an encoded color from a Macintosh rgbcolor record"
  (make-color (rref rgb :rgbcolor.red)
              (rref rgb :rgbcolor.green)
              (rref rgb :rgbcolor.blue)))


(defmacro with-rgb ((rgb-var color) &body body)
  "creates an rgb from a color for the duration of the body"
  (let* ((color-val (make-symbol "COLOR-VAL")))
    `(let* ((,color-val ,color))
       (rlet ((,rgb-var :rgbcolor
                        :red (color-red ,color-val)
                        :green (color-green ,color-val)
                        :blue (color-blue ,color-val)))
         ,@body))))

(defun real-color-equal (color1 color2)
  "returns true if the colors will display as the same color on the current device"
  (or (eq color1 color2)
      (and *color-available*
           color1 color2
           (with-rgb (one color1)
             (with-rgb (two color2)
               (eq (#_Color2Index one)
                   (#_Color2Index two)))))))

;;;;;;;;;;;;
;;
;;  some predefined colors
;;  

;if we change the representation of colors, this code must be changed
(setq *black-color* 0)                  ; defined in l1-init
(setq *white-color* 16777215)           ; ditto
(defparameter *pink-color* 15861892)
(defparameter *red-color* 14485510)
(defparameter *orange-color* 16737282)
(defparameter *yellow-color* 16577285)
(defparameter *green-color* 2078484)
(defparameter *dark-green-color* 25617)
(defparameter *light-blue-color* 175082)
(defparameter *blue-color* 212)
(defparameter *purple-color* 4587685)
(defparameter *brown-color* 5647365)
(defparameter *tan-color* 9466170)
(defparameter *gray-color* #x808080)
(defparameter *light-gray-color* #xc0c0c0)
(defparameter *lighter-gray-color* #xdddddd) ; or e0 whats it look like in color? WHITE
; c0c0c0 is cool if 8bit but then light gray needs to be darker
; f0f0f0 is cool if 4bit but is white if 8 bit (huh)
(defparameter *dark-gray-color* #x404040)

(defparameter *tool-back-color* (if (osx-p) #xeeeeee *lighter-gray-color*))
(defparameter *tool-line-color* *light-gray-color*)
(defparameter *power-book-back-color* #xeeeeee)

(def-ccl-pointers tool-foo ()
  (setq *tool-back-color* (if (osx-p) #xeeeeee *lighter-gray-color*)))

#|
; here is apparent scoop on gray's
 in 8 bit palette (standard I think - from resedit)
aaaaaa light
555555 darker
eeeeee looks white to me
dddddd nearly white
888888 light
777777 somewhat darker
444444 "
222222 "
111111 dark

 in 4 bit color palette - there are only a few (3 I think)
eeeeee white
dddddd light
aaaaaa light
888888
777777 same as 8?
666666
555555 dark
444444 dark
222222 TAN
111111 black
 in power book 4 bit gray palette things are different
  and appear to be different from a color monitors 4 bit gray scale palette
 power book f0f0f0 is a nice light gray (really blue), ffffff is white (clearly)
  eeeeee looks same as f0f0f0, dddddd is darker but maybe ok as compromise for 4bit 
 on color monitor set to 4 bit gray f0f0f0 is WHITE - oh foo
 oh screw it - either we distinguish 4bit from greater - or let user set tool colors??
|#





(defvar *black-rgb*)
(defvar *white-rgb*)

(def-ccl-pointers rgb-colors ()
  (setq *black-rgb* (color-to-rgb *black-color*))
  (setq *white-rgb* (color-to-rgb *white-color*)))



;;;;;;;;;;;;;;;;;;;;;;;
;;
;; color-tables
;;
;;  color-tables are used in many places in the toolbox.
;;  they contain a header and a list of color entries.
;;  Each entry has a part code and rgb.  The part codes are used
;;  to color the parts of various things, such as windows and controls.
;;
;;  color-tables are allocated on the Mac Heap, and hence aren't garbage
;;  collected.  In many cases however, the ROM will automatically dispose
;;  of them when the owning object (e.g. window, control, etc) is disposed.
;;


(defconstant c-table-contents 10
  "the offset past the header in a color table, plus offset to rgb")
(defconstant c-element-size 8 "number of bytes per element")

(defun copy-color-table (old-table &optional new-table)
  (let* ((size (#_GetHandleSize old-table)))
    (unless new-table
      (setq new-table (#_NewHandle size)))
    (with-dereferenced-handles ((old old-table)
                                (new new-table))
      (#_BlockMoveData old new size))
    new-table))

(eval-when (:execute :compile-toplevel #+bccl :load-toplevel)
  (defmacro element-rgb-offset (element)
    `(%i+ c-table-contents
          (%i* ,element c-element-size)))
  )

(defun c-table-in-range-p (color-table element)
  (unless (handlep color-table)
    (report-bad-arg color-table '(satisfies handlep)))
  (<= 0 element (%hget-word color-table 6)))

(defun table-color (color-table element)
  "returns the color of an element in a color table"
  (unless (c-table-in-range-p color-table element)
    (error "Element ~S not in range of color table ~S." element color-table))
  (with-dereferenced-handles ((ptr color-table))
    (with-macptrs ((rgb (%inc-ptr ptr (element-rgb-offset element))))
      (rgb-to-color rgb))))

(defun set-table-color (color-table element new-color)
  "sets the color of an element in a table"
  (unless (c-table-in-range-p color-table element)
    (error "Element ~S not in range of color table ~S." element color-table))
  (let ((element-start (element-rgb-offset element)))
    (with-dereferenced-handles ((ptr color-table))
      (with-rgb (rgb new-color)
        (%put-word ptr element (%i- element-start 2))
        (%put-word ptr (%get-word rgb) element-start)
        (%put-word ptr (%get-word rgb 2) (%i+ element-start 2))
        (%put-word ptr (%get-word rgb 4) (%i+ element-start 4))))
    new-color))


;;;;;;;;;
;;
;; using colors with objects
;;

(defmethod set-part-color-loop (part colors)
  (while colors
    (set-part-color part (car colors) (cadr colors))
    (setq colors (%cddr colors))))

(defmethod part-color (part key)
  (getf (slot-value part 'color-list) key nil))

(defmethod set-part-color (part key new-color)
  (if new-color
    (setf (getf (slot-value part 'color-list) key) new-color)
    (remf (slot-value part 'color-list) key)))

(defmethod part-color-list (part)
  (slot-value part 'color-list))

;;;;;;;;;;;;;;;;;;;;
;;
;; rudimentary window-color functions
;;


(defmethod set-fore-color ((w window) color)
  (when *color-available*
    (with-rgb (rec color)
      (with-port (wptr w)
        (#_rgbforecolor rec)))))

(defmethod set-back-color ((w window) color &optional (redisplay-p t))
  (when *color-available*
    (with-rgb (rec color)
      (with-focused-view w
        (#_rgbbackcolor rec)
        (when redisplay-p
          (invalidate-view w t))))))

(defmethod get-fore-color ((w window))
  #-carbon-compat
  (with-port (wptr w)
    (grafport-fore-color))
  #+carbon-compat
  (with-macptrs ((port (#_getwindowport (wptr w))))
    (rlet ((color-rec :rgbcolor))
      (#_getportforecolor port color-rec)
      (rgb-to-color color-rec))))

(defun grafport-fore-color ()
  (When *color-available*
    (rlet ((color-rec :rgbcolor))
      (#_getforecolor color-rec)
      (rgb-to-color color-rec))))

(defmethod get-back-color ((w window))
  #-carbon-compat
  (with-port (wptr w)
    (grafport-back-color))
  #+carbon-compat
  (with-macptrs ((port (#_getwindowport (wptr w))))
    (rlet ((color-rec :rgbcolor))
      (#_getportbackcolor port color-rec)
      (rgb-to-color color-rec))))

(defun grafport-back-color ()
  (when *color-available*
    (rlet ((color-rec :rgbcolor))
      (#_getbackcolor color-rec)
      (rgb-to-color color-rec))))

(defvar *is-normalized* nil)         
       


#+ignore
(defparameter *color-pat-alist*
  `((,*white-color* . ,*white-pattern*)))





;;;;;;;;;;;;
;;
;;  set the colors of parts of windows
;;

(eval-when (:execute :compile-toplevel #-bccl :load-toplevel)
  (defconstant cWtable-size 5))

(defvar *window-color-part-alist*
  '((:content . #.#$wContentColor)
    (:frame . #.#$wFrameColor)
    (:text . #.#$wTextColor)
    (:hilite . #.#$wHiliteColor)
    (:title-bar . #.#$wTitleBarColor)))


(defmethod set-part-color ((w window) part new-color
                              &aux
                              new-table had-before wptr old-color
                              (part-offset
                               (%cdr (assq part *window-color-part-alist*))))
  (declare (ignore-if-unused part new-color new-table had-before wptr old-color part-offset))
  (assert part-offset () "~a isn't one of ~a" part *window-color-part-alist*)
  ;(dbg 128)  
  (if (and *color-available*
           ;(slot-boundp w 'wptr)
           (setq wptr (slot-value w 'wptr))
           part-offset)    
    ;; this is n.g. for carbon - dunno if anything replaces it
    #-carbon-compat
    (let ((old-table (rlet ((old-table :pointer))
                       (#_GetAuxWin (slot-value w 'wptr) old-table)
                       (rref (%get-ptr old-table) :auxwinrec.awctable))))
      (setq had-before (not (eql (#_getresource "wctb" 0) old-table)))
      (call-next-method)
      
      (setq new-table (if (null had-before)
                        (default-window-color-table w)
                        old-table))
      (when (and had-before (not new-color))
        (let ((default (default-window-color-table w)))
          (unwind-protect
            (setq new-color (table-color default part-offset))
            (#_DisposeHandle default))))
      (setq old-color (table-color new-table part-offset))
      (when new-color
        (set-table-color new-table part-offset new-color))
      (#_SetWinColor wptr new-table)
      (values new-color old-color))
    #+carbon-compat
    (progn
      (call-next-method)
      ; can't find frame,text,hilite,titlebar - which don't work anyway
      ; AND below now works thanks to Gary King
      (case part
        (:content
         (set-back-color w new-color)
         (setf (slot-value w 'back-color) new-color)))
      (values new-color old-color))
    
    (call-next-method)))

(defmethod default-window-color-table ((w window))
  (%default-window-color-table))

(defun %default-window-color-table ()
  #-carbon-compat
  (rlet ((old-table :pointer))
    (#_GetAuxWin (%null-ptr) old-table)
    (copy-color-table (rref (%get-ptr old-table)
                            :auxwinrec.awctable))))


;;;;;;;;;;;;;;
;;
;; control colors
;;
;; not object-oriented.  Sets the colors of the actual mac-controls
;;

(defvar *control-color-part-alist*
  '((:frame . #.#$cFrameColor)
    (:body . #.#$cBodyColor)
    (:text . #.#$cTextColor)
    (:thumb . #.#$cThumbColor)))

(defun set-control-part-color (c-handle part-code new-color &aux hadp)
  (declare (ignore-if-unused c-handle part-code new-color hadp))
  #-carbon-compat ; sigh
  (when *color-available*
    (with-macptrs (new-table)
      (multiple-value-setq (new-table hadp) (get-aux-ctl c-handle new-table))
      (when (and hadp (not new-color))
        (setq new-color
              (table-color (default-control-color-table nil) part-code)))
      (when new-color
        (set-table-color new-table part-code new-color))
      (#_SetControlColor c-handle new-table))))

; Patch the broken system 7 _GetAuxCtl: always returns TRUE.
; Returns two values, a color table for the given control-handle and a boolean
; saying whether it already had one.
; If the second value is NIL, the color table will be a newly consed handle.
#|
(defun get-aux-ctl (c-handle &optional (new-table (%null-ptr)))
  (rlet ((old-table :pointer))
    (if (and (#_GetAuxiliaryControlRecord c-handle old-table)
             (progn
               (%setf-macptr new-table (rref (%get-ptr old-table) :auxCtlRec.AcCTable))
               (not (eql new-table (default-control-color-table nil)))))
      (values new-table t)
      (values (default-control-color-table) nil))))

(defun default-control-color-table (&optional (copy-p t))
  (rlet ((old-table :pointer))
    (#_GetAuxiliaryControlRecord (%null-ptr) old-table)
    (let ((color-table (rref (%get-ptr old-table) :auxctlrec.acctable)))
      (if copy-p
        (copy-color-table color-table)
        color-table))))
|#

#|
; Here's a function to test the _GetAuxCtl bug.
(defun gac (view &optional (handle (dialog-item-handle view)))
  (when handle
    (rlet ((old-table :pointer))
      (values (#_GetAuxiliaryControlRecord handle old-table)
              (let ((table (%get-ptr old-table)))
                (unless (%null-ptr-p table)
                  (rref table :auxCtlRec.accTable)))))))

(defparameter *w* (make-instance 'window))
(defparameter *b* (make-instance 'button-dialog-item
                                 :dialog-item-text "OK"
                                 :view-container *w*))
; If the following two forms return the same values, the bug is still there.
(gac *b*)
(gac *b* (%null-ptr))

|#

;;;;;;;;;;;;
;;
;; dialog-item colors
;;

(defmethod set-part-color ((d dialog-item) part new-color)
  (declare (ignore part new-color))
  (call-next-method)
  (invalidate-view d))


;;;;;;;;;;;;;;
;;
;;control dialog items

(defmethod set-part-color ((d control-dialog-item) part new-color)
  (without-interrupts
   (call-next-method)
   (when (and (wptr d)
              (setq part (%cdr (assq part *control-color-part-alist*))))
     (with-focused-dialog-item (d)
       (set-control-part-color (dialog-item-handle d) part new-color)))))

;;;;;;;;;;;;;;
;;
;;table dialog items
#| ; its in dialogs.lisp today - and this is wrong today
(defmethod set-part-color ((d table-dialog-item) part new-color)
  (without-interrupts
   (if (integerp part)
     ; Change the color of one cell
     (progn
       (if new-color
         (setf (getf (slot-value d 'color-list) part) new-color)
         (remf (slot-value d 'color-list) part))
       (redraw-cell d part))
     ; Change some other color attribute
     (progn
       (call-next-method)
       (let ((handle (dialog-item-handle d)))
         (when (and (wptr d)
                    handle
                    (setq part (%cdr (assq part *control-color-part-alist*))))
           (with-macptrs ((h-scroll (rref handle :listrec.hscroll))
                          (v-scroll (rref handle :listrec.vscroll)))
             (with-focused-dialog-item (d)
               (unless (%null-ptr-p h-scroll)
                 (set-control-part-color h-scroll part new-color))
               (unless (%null-ptr-p v-scroll)
                 (set-control-part-color v-scroll part new-color))))))))))
|#


;;;;;;;;;;;;;;
;;
;; menus et al

(defparameter *menubar-color-part-alist*
  '((:default-menu-title . 4)
    (:default-menu-background . 10)
    (:default-item-title . 16)
    (:menubar . 22)))

(defparameter *menu-color-part-alist*
  '((:menu-title . 4)
    (:default-item-title . 16)
    (:menu-background . 22)))

(defparameter *menu-item-color-part-alist*
  '((:item-mark . 4)
    (:item-title . 10)
    (:item-key . 16)))

(defun %current-menubar-colors (&aux plist centry)
  (rlet ((mtab :mcentry))
    (without-interrupts
     (unless (%null-ptr-p (setq centry (#_GetMCEntry 0 0)))
       (#_BlockMoveData centry mtab #.(record-length :mcentry))
       (dolist (x *menubar-color-part-alist*)
         (setq plist (list* (%car x)
                            (rgb-to-color (%inc-ptr mtab (%cdr x)))
                            plist)))
       plist))))

(defvar %initial-menubar-colors ())

(defun set-menu-color-table (menu-id item-id part-code color &aux where)
  (declare (ignore-if-unused where menu-id item-id part-code color))
  (when (and t) ;(osx-p)#|(eq 0 menu-id)|#)
    #|(warn "Dont try to set menubar colors on OSX.")|#
    (return-from set-menu-color-table nil))
  #+ignore
  (when (and menu-id *color-available*)
    (rlet ((entry :mcentry))
      (without-interrupts
       (with-macptrs ((old-entry (#_GetMCEntry menu-id item-id)))
         (if (or (not (%null-ptr-p old-entry))
                 (and (not (eql 0 item-id))
                      (not (%null-ptr-p (progn (setq where :menu)
                                               (%setf-macptr 
                                                old-entry
                                                (#_GetMCEntry menu-id 0))))))
                 (and (not (eql 0 menu-id))
                      (not (%null-ptr-p (progn (setq where :menubar)
                                               (%setf-macptr
                                                old-entry
                                                (#_GetMCEntry 0 0)))))))
           (#_BlockMoveData old-entry entry #.(record-length :mcentry))
           (dolist (part '(:menubar :default-item-title :default-menu-background
                           :default-menu-title))
             (let* ((color (getf %initial-menubar-colors part))
                    (part-code (cdr (assq part *menubar-color-part-alist*))))
               (with-rgb (rgb color)
                 (#_BlockMoveData rgb
                  (%inc-ptr entry part-code)
                  (record-length :RGBColor))))))))
      ; Clean up for defaults.  See IM V-234
      (cond (t nil)   ;; I think this is all obsolete
            ((null where))
            ((eq where :menu)           ; wanted menu-item, got menu
             ; rgb3 -> rgb1 & rgb2
             #-ppc-target
             (lap-inline ()
               (:variable entry)
               (move.l (varg entry) atemp0)
               (jsr_subprim $sp-macptrptr)
               (move.l (atemp0 $mctRGB3) (atemp0 $mctRGB1))
               (move.w (atemp0 (+ $mctRGB3 4)) (atemp0 (+ $mctRGB1 4)))
               (move.l (atemp0 $mctRGB3) (atemp0 $mctRGB2))
               (move.w (atemp0 (+ $mctRGB3 4)) (atemp0 (+ $mctRGB2 4))))
             #+ppc-target
             (let ((l (%get-long entry $mctRGB3))
                   (w (%get-word entry (+ $mctRGB3 4))))
               (%put-long entry l $mctRGB1)
               (%put-word entry w (+ $mctRGB1 4))
               (%put-long entry l $mctRGB2)
               (%put-word entry w (+ $mctRGB2 4))))
            ((eql item-id 0)            ; Wanted menu, got menubar
             ; rgb2 <-> rgb4
             #-ppc-target
             (lap-inline ()
               (:variable entry)
               (move.l (varg entry) atemp0)
               (jsr_subprim $sp-macptrptr)
               (move.l (atemp0 $mctrgb2) dtemp0)
               (move.w (atemp0 (+ $mctRGB2 4)) dtemp1)
               (move.l (atemp0 $mctRGB4) (atemp0 $mctRGB2))
               (move.w (atemp0 (+ $mctRGB4 4)) (atemp0 (+ $mctRGB2 4)))
               (move.l dtemp0 (atemp0 $mctRGB4))
               (move.w dtemp1 (atemp0 (+ $mctRGB4 4))))
             #+ppc-target
             (let ((l (%get-long entry $mctRGB2))
                   (w (%get-word entry (+ $mctRGB2 4))))
               (%put-long entry (%get-long entry $mctRGB4) $mctRGB2)
               (%put-word entry (%get-word entry (+ $mctRGB4 4)) (+ $mctRGB2 4))
               (%put-long entry l $mctRGB4)
               (%put-word entry w (+ $mctRGB4 4))))
            (t                          ; wanted menu-item, got menubar
             ; rgb2 -> rgb4, rgb3 -> rgb1 & rgb2
             #-ppc-target
             (lap-inline ()
               (:variable entry)
               (move.l (varg entry) atemp0)
               (jsr_subprim $sp-macptrptr)
               (move.l (atemp0 $mctRGB2) (atemp0 $mctRGB4))
               (move.w (atemp0 (+ $mctRGB2 4)) (atemp0 (+ $mctRGB4 4)))
               (move.l (atemp0 $mctRGB3) (atemp0 $mctRGB1))
               (move.w (atemp0 (+ $mctRGB3 4)) (atemp0 (+ $mctRGB1 4)))
               (move.l (atemp0 $mctRGB3) (atemp0 $mctRGB2))
               (move.w (atemp0 (+ $mctRGB3 4)) (atemp0 (+ $mctRGB2 4))))
             #+ppc-target
             (let ((l (%get-long entry $mctRGB3))
                   (w (%get-word entry (+ $mctRGB3 4))))
               (%put-long entry (%get-long entry $mctRGB2) $mctRGB4)
               (%put-word entry (%get-word entry (+ $mctRGB2 4)) (+ $mctRGB4 4))
               (%put-long entry l $mctRGB1)
               (%put-word entry w (+ $mctRGB1 4))
               (%put-long entry l $mctRGB2)
               (%put-word entry w (+ $mctRGB2 4)))))
      (%put-word entry menu-id)
      (%put-word entry item-id 2)
      (progn
        (with-rgb (rgb color)
          (#_BlockMoveData rgb (%inc-ptr entry part-code) 6))
        (#_SetMCEntries 1 entry)))))


;;menubar

(defclass menubar ()
  ((color-list :initform nil)))

(defparameter *menubar* (make-instance 'menubar))

(defvar *menubar-color-initialized* nil)

(defun initialize-menubar-color ()
  (unless *menubar-color-initialized*
    (setq *menubar-color-initialized* t)
    (setq %initial-menubar-colors
          (or (and *color-available* (%current-menubar-colors))
              '(:menubar #.*white-color*
                :default-item-title #.*black-color*
                :default-menu-background #.*white-color*
                :default-menu-title #.*black-color*)))
    (setf (slot-value *menubar* 'color-list)
          (copy-list %initial-menubar-colors))))

(def-ccl-pointers color-menubar ()
  (setq *menubar-color-initialized* nil))

(initialize-menubar-color)

(defmethod set-part-color :after ((menubar menubar) part new-color &aux part-code)
  (unless new-color
    (setq new-color (getf %initial-menubar-colors part)))
  (when (setq part-code (%cdr (assq part *menubar-color-part-alist*)))
    (set-menu-color-table 0 0 part-code new-color))
  (dolist (menu %menubar) (update-color-defaults menu))
  (when (or (eq part :menubar)
            (eq part :default-menu-title))
    (draw-menubar-if))
  new-color)


;*** called for dumplisp?
(defmethod update-colors ((menubar menubar))
  (let* ((*menubar-frozen* t))
    (set-part-color-loop menubar (slot-value menubar 'color-list)))
  (draw-menubar-if))

;;;;;;;;;;;;;;;;;;;;;;
;;
;;  menus
;;

(defmethod set-part-color :after ((menu menu) part new-color)
  (when (and new-color (slot-value menu 'menu-handle))
    (set-mac-part-color menu part new-color))
  (update-color-defaults menu)
  (when (and (eq part :menu-title) (memq menu %menubar))
    (draw-menubar-if))
  new-color)

(defmethod set-mac-part-color ((menu menu) part new-color &aux
                                            code (owner (slot-value menu 'owner)))
  (cond ((and owner (setq code
                          (%cdr (assoc part *menu-item-color-part-alist*))))
         (set-menu-color-table (slot-value owner 'menu-id)
                               (menu-item-number menu)
                               code
                               new-color))
        ((setq code (%cdr (assoc part *menu-color-part-alist*)))
         (set-menu-color-table (slot-value menu 'menu-id) 0 code new-color))))

(defmethod update-color-defaults ((menu menu) &aux owner)
  (when *color-available*
    (if (slot-value menu 'color-list)
      (flet ((one-part (local-key default-key)
                       (or (part-color menu local-key)
                           (set-mac-part-color menu
                                               local-key
                                               (part-color *menubar* default-key)))))
        (one-part :menu-title :default-menu-title)
        (one-part :default-item-title :default-item-title)
        (one-part :menu-background :default-menu-background))
      (let ((id (menu-id menu)))
        (when id
          (#_DeleteMCEntries id 0))
        (when (setq owner (menu-owner menu))
          (let ((owner-id (menu-id owner)))
            (when owner-id
              (#_DeleteMCEntries owner-id (menu-item-number menu)))))))
    (dolist (item (slot-value menu 'item-list))
      (update-color-defaults item))))


;;menu-items

(defmethod set-part-color :after ((item menu-item) part new-color)
  (when (slot-value item 'owner)
    (when new-color (set-mac-part-color item part new-color))
    (update-color-defaults item))
  new-color)

(defmethod set-mac-part-color ((item menu-item) part new-color)
  (when (setq part (%cdr (assq part *menu-item-color-part-alist*)))
    (set-menu-color-table (slot-value (slot-value item 'owner) 'menu-id)
                          (menu-item-number item)
                          part new-color)))

(defmethod part-color-with-default ((item menu-element) local-key
                                    &aux (owner (slot-value item 'owner)))
  (or (part-color item local-key)
      (part-color item :item-title)
      (and owner (part-color owner :default-item-title))
      (part-color *menubar* :default-item-title)))

(defmethod update-color-defaults ((item menu-item))
  (when *color-available*
    (let* ((owner (slot-value item 'owner)))
      (when owner
        (let*  ((id (menu-id owner)))
          (when id
            (if (slot-value item 'color-list)
              (progn
                (set-mac-part-color item :item-title
                                    (part-color-with-default item :item-title))
                (set-mac-part-color item :item-mark
                                    (part-color-with-default item :item-mark))
                (set-mac-part-color item :item-key
                                    (part-color-with-default item :item-key)))
              (#_DeleteMCEntries id (menu-item-number item)))))))))


;;;;;;;;;;;
;;
;; some handy tools
;;

#|
(defun user-pick-color (&key (color *black-color*) 
                             (prompt "Pick a color")
                             (position (default-pick-color-position)))
  "lets the user choose a color with the standard mac window"
  (with-cursor *arrow-cursor*
    (if *color-available*
      (with-port %temp-port%  ; << added this - serendipitous guess
        (with-rgb (rgb color)
          (with-pstrs ((pp prompt))
            (if (#_GetColor position pp rgb rgb)
                (rgb-to-color rgb)
                (throw-cancel)))))
        (if (y-or-n-dialog prompt
                           :yes-text "Black"
                           :no-text "White")
            *black-color*
            *white-color*))))
|#

(defun user-pick-color (&key (color *black-color*) 
                             (prompt "Pick a color")
                             (position (default-pick-color-position)))
  "lets the user choose a color with the standard mac window"
  ;; timer usually works but not always when the pop-up-menu is clicked
  ;; doesn't work when mouse down
  (progn
    (with-cursor *arrow-cursor*
      (if *color-available*
        (with-port %temp-port%  ; << added this - serendipitous guess
          (setq *interrupt-level* 0)  ;; why does with port do without-interrupts??
          (with-rgb (rgb color)
            (with-pstrs ((pp prompt))
              (if (if t ; (osx-p)
                    (progn 
                      (if *timer-interval* 
                        (progn
                          (warn "The timer probaly won't work here")
                          (with-timer (#_GetColor position pp rgb rgb)))
                        (#_GetColor position pp rgb rgb)))
                    
                    (#_getcolor position pp rgb rgb))  ;; timer makes a mess on OS9
                (rgb-to-color rgb)
                (throw-cancel)))))
        (if (y-or-n-dialog prompt
                           :yes-text "Black"
                           :no-text "White")
          *black-color*
          *white-color*)))))


;; Find the deepest screen.
;; If there is a choice, use the one that the nearby-window is on.
(defun default-pick-color-position (&optional (mouse-position (view-mouse-position nil)))
  (multiple-value-bind (position size)
                       (find-best-color-screen :mouse-position mouse-position)
    (let ((width (point-h size))
          (height (point-v size))
          (dialog-width 440)
          (dialog-height 280))          ; determined emperically
    (add-points position
                (make-point (floor (- width dialog-width) 2)
                            (floor (- height dialog-height) 3))))))

(defun screen-attribute (screen attribute)
  (#_TestDeviceAttribute screen attribute))

(defun screen-active-p (screen)
  (and (screen-attribute screen #$screenDevice)
       (screen-attribute screen #$screenActive)))

(defun screen-color-p (screen)
  (screen-attribute screen #$gdDevType))

(defun screen-bits (screen)
  (href (href screen :GDevice.gdPMap) :PixMap.PixelSize))

#|  ;; moved to l1-init
(defun screen-position (screen)
  (rref screen :GDevice.gdRect.topleft))

(defun screen-size (screen)
  (subtract-points
   (rref screen :GDevice.gdRect.bottomright)
   (screen-position screen)))
|#

(defmacro do-screens ((s &optional (active-only? t)) &body body)
  `(with-macptrs ((,s (require-trap #_GetDeviceList)))
     (loop
       (if (%null-ptr-p ,s) (return))
       (when ,(if active-only? `(screen-active-p ,s) t)
         ,@body)
       (%setf-macptr ,s (require-trap #_GetNextDevice ,s)))))

(unless (assq 'do-screens *fred-special-indent-alist*)
  (push '(do-screens . 1) *fred-special-indent-alist*))

; Return two values, the position and size of the best color screen
; that is near mouse-position.
; If the mouse is on any color screen and most-bits? is nil, return that screen.
; If most-bits? is true, return the color screen with the most bits using
; mouse-position only to break ties.
(defun find-best-color-screen (&key (mouse-position (view-mouse-position nil))
                                    (most-bits? t) screen)
  (if *color-available*
    (rlet ((rect :rect :topleft mouse-position :bottomright (add-points mouse-position #@(1 1))))
      (with-macptrs ((maxScreen (#_GetMaxDevice rect)))
        (let* ((got-max? (not (%null-ptr-p maxScreen)))
               (max-color? (and got-max? (screen-color-p maxScreen)))
               (max-bits (if got-max? (screen-bits maxScreen) 0)))
          (unless (and max-color? (not most-bits?))
            (do-screens (screen)
              (let ((color? (screen-color-p screen))
                    (bits (screen-bits screen)))
                (when (or (%null-ptr-p maxScreen)
                          (and color? (not max-color?))
                          (and (eq color? max-color?)
                               (> bits max-bits)))
                  (setq max-bits bits
                        max-color? color?)
                  (%setf-macptr maxScreen screen)))))
          (if screen
            (%setf-macptr screen maxScreen))
          (values (screen-position maxScreen)
                  (screen-size maxScreen)
                  max-color?
                  max-bits))))
    (progn
      (if screen (%setf-macptr screen (%null-ptr)))
      (values #@(0 0) *screen-size*))))

(defun find-screen (point &optional return-screen)
  (when return-screen
    (%setf-macptr return-screen (%null-ptr)))
  (if *color-available*
    (do-screens (screen)
      (let* ((pos (screen-position screen))
             (pos-h (point-h pos))
             (pos-v (point-v pos))
             (size (screen-size screen))
             (h (point-h point))
             (v (point-v point)))
        (declare (fixnum pos-h pos-v h v))
        (when
          (and (<= pos-h h)
               (< h (the fixnum (+ pos-h (the fixnum (point-h size)))))
               (<= pos-v v)
               (< v (the fixnum (+ pos-v (the fixnum (point-v size))))))
          (when return-screen (%setf-macptr return-screen screen))
          (return (values pos size)))))
    (let ((size (make-point *screen-width* *screen-height*)))
      (and (point<= #@(0 0) point size)
           (not (eql point size))
           (values #@(0 0) size)))))

        

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
