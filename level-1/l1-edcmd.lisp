;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  8 10/22/97 akh  *external-style-scrap* => nil more ofter
;;  7 6/9/97   akh  some stuff moved here
;;  6 6/2/97   akh  see below
;;  4 4/1/97   akh  see below
;;  11 1/22/97 akh  ed-toggle-auto-keyscript (meta-j) for Kanji users
;;  9 7/18/96  akh  get-dead-keys-state, some command defs move to files that implements them
;;  8 6/16/96  akh  add get-dead-keys-state
;;  8 5/30/95  akh  dont die during put-external-scrap if scrap is bogus-thing-p
;;  7 5/22/95  akh  bind *gonna-change-pos-and-sel* around fred-update in fred - reduces flicker
;;  (do not edit before this line!!)


; L1-edcmd.lisp
; Copyright 1987-1988 Coral Software Corp
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2005 Digitool, Inc.

(in-package :ccl)

; Modification History
;; dont call buffer-roman
;; ------- 5.2b6
;; use OS defs for #$cmdkey etc
;; do the internalize-scrap stuff only if :text but not :|utxt|
;; added put-scrap-flavor for :|utxt| - now how to say use it?  - TextEdit does both but no styles
;; so do both :text and :|utxt| in put-scrap-flavor (eql :fred) - also do :|ustl|
;; ------ 5.2b5
;; make a hashtable for color->color-index
;; internalize-scrap ((handler text-scrap-handler)) - checks for text-ptr NIL
;; ------- 5.2b4
;; change get-current-scrapref for new headers
;; lose two deftrap-inlines  if #+interfaces-3
;; 10/31/05 #\return does ed-self-insert-maybe-lf in %initial-comtab%
;; internalize-scrap - fix for unicode
;; something was fouled in the comtab-get source
;; put-scrap-flavor unscrambles unicode
;; 01/18/05 *fred-word-constituents* is transformed to unicode later
;; 12/10/04 eol stuff
;; ------- 5.1final
;; buffer-skip-package-prefix skips #\- too
;; ------- 5.1b2
;; fred don't call mac-file-namestring Please
;; set-dead-keys maybe does something on Jaguar
;; -------- 5.0 final
;; fix event-keystroke for custom keyboards - from Takehike Abe
;; --------- 5.0b5
;; 12/20/02 akh fix pointer-char-length-sub
;; now fix the multi script case of external scrap
;; fix char-pos byte-pos confusion in external/internal scraps
;; akh  semi fix for get-external-scrap/internalize-scrap when styl has two byte script
;;   if only one script win
;;   if more than one script lose

;; fix for possible negative font and style-vectors
;; extend put-scrap to include @@ and @@@ and set these to the second and third most 
;;   recently copied items. from Gary Warren King
;; ------- 4.4b5
;; set-dead-keys does nothing if jaguar-p - it no longer works
;; 4.4b4
;; -----------
;; 07/05/02 akh fix to set-internal-scrap from Terje N. - oops fix is wrong
;; -------- 4.4b3
;; 01/28/01 AKH event-keystroke compensate for crock in OS9.1
;; add ed-xform-linefeeds  ;; to fix the linefeeds in some header files
;; scrap stuff for carbon
;; getscript -> getscriptvariable
; 11/24/99 akh get/set-dead-keys more PC ?
;------------- 4.3f1c1
; 05/19/99 akh add c-m-r = ed-reset-font
; 05/17/99 akh event-keystroke - fix for shift functionkey
; 05/06/99 akh *fred-word-constituents* gets some more alpha-char-p chars
;; ------------ 4.3b1
; 09/29/98 akh the default function for %initial-comtab% allows any darn thing unless control or command  - e.g (:meta #\s) = ß 
; 10/21/97 akh get-external-scrap and put-scrap nullify *external-style-scrap* too please
; 06/06/97 akh fred-palette-closest-entry and palette-closest entry here from new-fred-window
; 06/03/97 akh def-ccl-pointers scrap moved to color.lisp - after initialize-fred-palette
; 05/05/97 akh  add-subviews to *fred-special-indent-alist* from walker sigismund.
; 04/02/97 bill fred-style-vector->scrap-style-handle returns from Alice's kill ring.
; 03/31/97 akh  scrap-style-handle->fred-style-vector - dotimes returns the font-index if found
;               get rid of 0 length runs
; 03/06/97 gb   *use-external-style-scrap*: queue-fixup per Bill.
; 03/04/97 bill Support for the :|styl| scrap:
;               *use-external-style-scrap*, scrap-style-handle->fred-style-vector,
;               fred-style-vector->scrap-style-handle, fred-color-index->rgb,
;               (method externalize-scrap :after (text-scrap-handler)),
;               *external-style-scrap*, (method internalize-scrap :after (text-scrap-handler)),
;               add *external-style-scrap* to (method convert-scrap (text-scrap-handler fred-scrap-handler))
; ------------- 4.0
; akh  ed-toggle-auto-keyscript (meta-j) for Kanji users
; 09/11/96 bill (def-ccl-pointers dead-keys ...) no longer sets *dead-keys-state*.
; ------------- 4.0b1
; 05/02/96 bill Fix brain-damage in keystroke-name
; 03/26/96  gb  lowmem accessors.
; 03/09/96 bill  reserrchk uses #_ResError instead of low memory global
; 02/26/96 bill  add define-condition to *fred-special-indent-alist*
; 02/23/96 bill  from slh: add :shift & :command to the report-bad-arg list in keystroke-code
; 11/29/95 bill  New trap names to avoid trap emulator.
;  4/24/95 slh   set-internal-scrap: noop if scrap nil; $scrapvars: compile/eval only
;                maybe-get-ext-scrap; get-scrap-p: default optional to nil
;-------------- 3.0d17
;01/03/95 alice buffer-word-bounds deal with non-roman scripts, add buffer-roman, buffer-forward-break-char etc.
;08/28/93 alice buffer-set-font-spec was brain damaged
;07/26/93 bill  New function: get-scrap-p, use it in get-scrap
;07/31/93 alice buffer-bwd-up-sexp moves to l1-edbuf.lisp 
;----------R.I.P.
;-------------- 3.0d12
;07/14/93 alice buffer-set-font-spec faster
;06/16/93 alice internalize-scrap uses %str-from-ptr-in-script
;06/11/93 alice buffer-bwd-up-sexp somewhat faster
;06/06/93 alice event-keystroke - dont lose shift key for non alpha 
;11/24/92 alice control-x control-i is ed-info-current-sexp (get info)
;10/24/92 alice concat-string-conses - dont assume the style vectors merge!
;10/09/92 alice use mostly the same key modifier bits as we get from the event. Formerly arbitrarily different and unnamed
;10/08/92 alice stomp out *emacs-mode*,  event-keystroke and keystroke-code allow command, event-keystroke does cmd key mapping 
;07/02/92 alice stomp out last 2 uses of shift-not-command-key-p
;11/30/92 bill   run-default-command -> l1-edwin
;07/31/92 bill   c-m-m & c-n with the caps lock key no longer behave
;                as if the shift key is down.
;04/29/92 bill   add THE to *fred-special-indent-alist*
;--------------- 2.0
;03/17/92 bill   remove define-condition from *fred-special-indent-alist*
;--------------- 2.0f3
;02/21/92 (alice from 2.0f2c5 bootpatch0) BUFFER-MODELINE-PACKAGE ignores errors when reading.
;------------- 2.0f2
;12/28/91 alice comtab-get, event-keystroke, keystroke-code and %initial-comtab - make :shift explicit for alpha & ctrl or meta
;12/19/91 alice no more ignore-errors in buffer-modeline-package, optional arg no-create,
;		he and buffer-first-in-package will cerror if package no exist & no-create is nil (unless the modeline says create)
;12/17/91 alice "to" => "containing" in fred, c-m-e and c-m-a get shift key modifier
;12/06/91 alice add accented characters to fred-word-constituents so capitalize-region works in Canada and Europe
;12/01/91 alice buffer-skip-fwd-wsp&comments defend against nil arguments (happened in flet indentation)
;12/10/91 gb    %signal-error -> %err-disp.
;12/12/91 bill  #_LoadResource after #_GetResource & #_Get1Resource
;-------------- 2.0b4
;11/12/91 bill  Bill's simplification of Gary's fix of Bill's translation of Gary's fix
;11/11/91 alice gary's fix to the fix
;11/04/91 bill  GB's fix to event-keystroke
;10/29/91 alice def-load-pointers => def-ccl-pointers
;10/04/91 gb   try to do _KeyTrans right.
;-------- 2.0b3
;08/24/91 gb    use new traps.
;07/15/91 alice add c-x u = c-_
;07/09/91 alice in buffer-special-indent-p move buffer-skip-package-prefix up a ways
;07/01/91 bill %get-cstr is renamed to %get-cstring and moved to l1-utils
;06/20/91 bill <shift><backspace> same as <backspace>
;06/17/91 bill make buffer-first-in-package skip a DEFPACKAGE form if there is one.
;06/14/91 bill add MAKE-INSTANCE to *fred-special-indent-alist*
;06/10/91 bill add LOCALLY to *fred-special-indent-alist*
;06/06/91 bill buffer-special-indent-p supports functions in *fred-special-indent-p*
;              buffer-fwd-sexp returns NIL if it reaches its end arg
;              This makes "(defun foo(x)" (missing space) indent properly.
;              buffer-fwd-sexp has a new skip-#-comments arg which is used
;              by the indentation code.
;06/13/91 alice event-keystroke - allow shift delete, escape does collapse-selection cause I said so
;06/11/91 alice NO defmethod in fred-special-indent-alist
;------------ 2.0b2
;06/03/91 bill buffer-first-in-package skips sharp comments at beginning of file.
;05/30/91 bill brain-damage in buffer-first-in-package
;05/29/91 bill buffer-modeline-range & buffer-modeline-attribute-range
;              c-m-m is reparse-modeline, c-m-M is add-modeline
;              buffer-first-in-package requires the in-package to be the first form,
;              that the in-package form has a single argument, and that the argument
;              is a constant.
;05/28/91 alice #\ForwardDelete (not #\Rubout) in comtab
;05/20/91 alice defobfun => defmethod in *fred-special-indent-alist*
;05/20/91 gb   call LISPM-MAKE-PACKAGE when parsing mode line.  Still calls BUFFER-FIRST-
;              IN-PACKAGE; shouldn't.
;05/08/91 bill flet-indentation, buffer-bwd-up-sexp takes an optional start parameter
;04/29/91 bill add fbind, generic-flet, generic-function, generic-labels to *fred-special-indent-alist*
;04/22/91 alice event-keystroke, let function keys be  control modified, merge bills change
;04/21/91 alice shift modifier doesnt pertain to cmd key
;04/18/91 alice control-_ is undo 
;04/17/91 alice lisp-indentation could loop forever in (while (buffer-fwd-sexp ...) ...) - when broken??
;04/16/91 alice use E.G. #\Help instead of #\^E in comtab so fred commmands dialog more meaningful
;04/09/91 bill event-keystroke - Speed up and make work on old Mac Plus UK keyboards.
;03/22/91 bill set-type-predicate vice property list hacking for comtabp
;03/19/91 bill add define-method-combination to *fred-special-indent-alist*
;03/04/91 bill no truncation to 32000 chars for externalize-scrap.
;02/28/91 bill magic #xNN words -> :ostype in get-mpsr-resource
;03/21/91 alice meta-tab self-inserts
;03/20/91 alice fix running default fred-commands w.r. to last command and prefix arg
;03/18/91 alice shift -> and meta-shift -> (maybe)
;03/11/91 alice add c-m-o, m-\, c-m-d => down list ala gnu
;03/08/91 alice add control digits and control meta too
;03/05/91 alice no more 1 arg report-bad-arg
;--------------- 2.0b1
;01/29/91 bill (setq @ scrap) in PUT-SCRAP to make a short-cut for getting the copied
;              object from the inspector.
;01/24/91 bill add ignored over-sharps arg to buffer-bwd-exp (used in fred-additions version).
;12/22/91 bill buffer-first-in-package evals "(in-package foo)" vice "foo"
;              It also handles package prefixed correctly
;12/11/90 bill buffer-fwd-sexp error'd at end of buffer
;11/19/90 bill make def-fred-command a little more forgiving.
;11/09/90 bill JOE's fix to buffer-first-in-package
;10/31/90 bill :OSTYPE "MPSR" vice :word ...
;10/25/90 bill buffer-word-bounds uses *fred-word-constituents* vice symbol-specials
;              buffer-double-click-bounds
;10/22/90 bill C-+ same as C-= so Mac Plus folks can type <Command><Shift>=
;10/18/90 bill put-scrap needed to get-external-scrap if there was one.
;10/02/90 bill ed-beep ignores any number of args.
;09/28/90 gb   don't clobber $applscratch in internalize-scrap.
;09/12/90 bill add return-from to *fred-special-indent-alist*
;              alms's patch to event-keystroke.
;08/24/90 bill *fred-special-indent-alist* def moves to l1-utils.
;08/21/90 akh  add multiple-value-setq to indent alist - remove some inited optionals
;08/21/90 akh  tweaks to buffer-fwd-sexp - pass it ch at pos if you have it
;08/16/90 akh  put Gails new speedy buffer-fwd-up-sexp in l1-edbuf
;08/13/90 alms fred has better query string
;07/31/90 bill ed-help invoked by both c-/ and c-?
;07/25/90 bill buffer-skip-package-prefix in buffer-special-indent-p
;08/03/90 akh  buffer-skip-fwd-wsp&comments - dont look at start+1 if >= end.
;07/06/90 bill c-m-d = ed-kill-forward-sexp
;06/25/90 bill Consolidate def-load-pointers for scraps.
;06/21/90 bill fred queries if a window already exists for the file.
;06/18/90 bill in cons-comtab: restore 'last-command slot before run-fred-command
;              c-m-backspace becomes ed-kill-backward-sexp vice ed-delete-bwd-delimiters.
;06/18/90 bill add clear-killed-strings
;06/12/90 bill ed-skip-* -> buffer-skip-*
;06/12/90 bill ed-kill-sexp -> ed-kill-forward-sexp, window-update -> fred-update
;06/07/90 bill (ecase .1) -> (ecase . 1)
;              allow (defpackage ...) (in-package ...) in buffer-first-in-package.
;05/21/90 bill add ecase to *fred-special-indent-alist*
;05/05/90 bill Update for new scrap handler.
;04/30/90 bill add do-subviews to *fred-special-indent-alist*
;4/10/90  gz  ed-compile-top-level-sexp -> ed-eval-or-compile-top-level-sexp
;             Some ed-xxx fns renamed to buffer-xxx.
;             word-chars -> *fred-word-constituents*.
;04/06/90 gz  Better error handling in buffer-first-in-package.
;03/16/90 bill Add do-all-windows to *fred-special-indent-alist*
;02/14/90 gz  Re-init *scrap-count* when load.
;12/28/89 gz  More buffer-first-in-package tweaks from mly.
;             No more catch-error.
;12/27/89 gz   Remove obsolete #-bccl conditionalizations.
;12/22/89 bill Remove defmethod from *fred-special-indent-alist*
;12/08/89 bill Mly's mod to make buffer-modeline-package compatible with LispM
;10/12/89 as  buffer-modeline-package defaults :use to nil
;10/4/89  gz  flush some bootstrapping optional args.
;09/27/89 gb simple-string -> ensure-simple-string.
;09/17/89 gb   Don't even indent ASK nicely, just for spite.
;09/16/89 bill Removed last vestiges of object-lisp
;09/12/89 bill Make default-function for %comtab% take optional args to support
;              clos editor.  Add optional arg to ed-beep, too.
;09/11/89 bill Add clos-fred for debugging
;09/11/89 bill ed-skip-fwd-#comment always returned nil.  buffer-fwd-sexp had a
;              fencepost error for skipping a blank #||# comment.
;08/30/89  gz key bindings for c-u, m-<digit> and <digit>, c-space(c-@), c-x c-x.
;07/19/89  gz added dovector to fred-special-indent-alist.
;             window-save -> window-object-save.
;7/7/89  bill Add (:meta ~) to %initial-comtab%
;05/20/89  gz window-update -> window-object-update
;05/02/89  gz Initialize *comtab* here.
;03/17/89  gz %cons-comtab.
;8-apr-89  as new comtab mechanism
;01/05/89  gz Added error system forms to special-indent-alist.
;12/28/88  gz Use istruct-typep.  New buffers. New buffer streams. Added buffer-read.
;12/21/88  gz release removed resource in buffer-write-file.
;12/16/88 gz ed-lquoted-p -> buffer-lquoted-p
;            ed-search-unquoted -> buffer-backward-search-unquoted
;12/11/88 gz mark-position -> buffer-position
;12/09/88 gz  _ChangedRsrc the right resource in buffer-write-file.
;             Don't pass null-ptr to _AddResource in buffer-write-file, get-mpsr-resource.
;12/2/88  gz  format-keystroke doesn't cons up keystroke name.
;             moved buffer-line to fred-misc.
;11/26/88 gz  Added buffer-insert-with-style
;11/25/88 gz  fencepost in buffer-next-font-change.
;11/20/88 gz  Moved all buffer-related stuff here, all edwin/window stuff to l1-edwin.
; 11/19/88 gb dispatch on functionp or symbolp
;10/18/88 gz  Made get-next-key-event a *fred-window* function.
; 9/10/88 gz  tb8$ -> tb$
; 9/1/88  gz  removed <frobs>-in-directory from special-indent-alist.
; 8/20/88 gz  added lap-inline to special-indent-alist
; 8/13/88 gb  %pl-search -> pl-search.
; 8/08/88 gz  added if# to special-indent-alist.  Cleaned up the lisp-8 comtab
;	      conversion.  Don't put spaces in character names in minibuffer.
;	      Moved transpose-chars, ed-kill-region and word casification cmds
;	      to fred-misc.  Made (this) buffer-bwd-sexp handle #||# comments.
;	      ed-kill-line is now the real def.
; 7/26/88 gz  Merged 1.2, put back the slower but correct ed-indent-to-col,
;	      put Open calls back inside unwind-protects.
;	      Made add-to/rotate-killed-strings work on any size ring.
; 6/27/88 gb  most-positive-fixnum -> (lsh -1 -1) to bootstrap.
; 3/31/88 gz  New macptr scheme.  Flush pre-1.0 edit history.
; 6/27/88 jaj fixed buffer-insert-file
; 6/26/88 jaj cleaned up unwind-protects with _CloseResFile
; 6/24/88 as  buffer-write-file errors on locked files
;             ed-insert-with-style has new calling sequence
; 6/23/88 as  buffer-insert-with-style -> ed-insert-with-style
; 6/22/88 as  rotate-killed-strings doesn't infinitely recurse
; 6/21/88 as  rotate-killed-strings skips empty slots
; 6/16/88 as  buffer-insert-with-style doesn't set style in listeners
; 6/10/88 as  style vectors keep the length of the run (though the handles still don't)
;             various clean up to high-level buffer-font code
; 6/10/88 jaj close open resfiles in buffer-[insert/write]-file
; 6/9/88  as  handle<->array conversion gets size right
;             get-next-key-event uses princ instead of format (for tilde's sake)
; 6/8/88  as  buffer-insert-with-style doesn't insert nil's.
; 6/7/88  jaj buffer-insert-file and buffer-write-file set/get the current
;             font in the MPSR resource
; 5/31/88 as *current-keystroke* bound to keystroke-code, not name
;            punted edwin-ctlh
; 5/29/88 as handle-to-array used by buffer-get-style
; 5/27/88 as format-keystroke not an obfun, doesn't call typecase
; 5/19/88 as get-next-key-event handles command-keys
;            clear and paste bind *last-command*
;            punted reset-killed-string-menu
;            fix to ed-insert-char
; 5/18/88 as punted wreplace
;            *fred-scrap* is different from *killed-strings*
; 5/17/88 as run-fred-command checks if command closed the window
;            buffer-insert-file restores font information
;            buffer-write-file saves font information
; 5/15/88 as paste uses mini-buffer
;            run-fred-prefix doesn't assume control-x
; 5/13/88 as new function: buffer-insert-with-style
;            styles don't generally cons handles
;            new undo mechanism
;5/13/88 jaj fixed buffer-bwd-up-sexp to handle semi-colon comments
;5/12/88 jaj second arg to buffer-word-bounds is now optional
; 5/12/88 as new get-next-key-event uses mini-buffer, less modal
;            slightly faster ed-indent-to-col
;            ed-skip-fwd-wsp&comment understands #||#'s
; 4/9/88 jaj added function keys to event-keystroke, keystroke-name and
;            keystroke-code
; 4/7/88 as  buffer-replace-font-spec, buffer-font-spec-to-index
; 4/6/88 as  new set-buffer-font, buffer-set-font-spec
;            paste doesn't set-buffer-style for listeners
; 4/6/88 jaj  elt called with args in correct order in add-to-killed-strings
; 4/6/88 jaj  removed reset-killed-strings-menu, fixed full killed-strings
;             with styles. removed "styl" scrap handling
; 1/25/88 jaj setctlvalue to zero instead of one in edwin-set-vscroll
;10/14/87 jaj fixed control-key for non-printing chars in event-keystroke
;10/12/87 cfry buffer-insert-file now accepts pathnames with escapes
;9/29/87 jaj moved buffer-line here from fred-additions-2
;9/16/87 jaj WSearch scroll includes context-lines
;----------------------------Version 1.0---------------------------------------

(defvar *fred-history-length* 20)



;(defconstant $functionkey 10)
(defconstant $functionkeybit 10)

(defconstant $functionkeyMask (ash 1 $functionkeybit))
(defconstant $cmdKeyMask (ash 1 #$cmdkeybit)) ; 8
(defconstant $shiftKeyMask (ash 1 #$shiftkeybit)) ;9 
(defconstant $optionKeyMask (ash 1 #$optionkeybit)) ; 11
(defconstant $controlKeyMask (ash 1 #$controlkeybit)) ; 12


;; this gets turned into a unicode string later - now it is unicode here
(defparameter *fred-word-constituents* 
  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@$%^&*_+=<>.?|ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôöõúùûüÀÃÕÂÊÁËÈÍÎÏÌÓÔÒÚÛÙßÆØæøŒœÿŸﬁﬂı")

(defun fred (&optional name new-window &aux w)
  (setq w (if (null name)
            (make-instance *default-editor-class*)
            (let ((w (and (not new-window) (pathname-to-window name))))
              (if (and w
                       (y-or-n-dialog
                        (format nil "Select old window containing ~s or open a new window?"
                                (file-namestring name))
                        :yes-text "Old"
                        :no-text "New"
                        :back-color *tool-back-color*))
                (return-from fred (progn (window-select w) w))
                (make-instance *default-editor-class* :filename name)))))
  #| ; why do it at all? 5/28
  (let ((*gonna-change-pos-and-sel* t))
    ; kludge that prevents frec update from drawing - cuts flicker 
      (fred-update w))|#
  w)


; Replaced by lib;fred-additions.lisp
(defun pathname-to-window (pathname)
  (declare (ignore pathname))
  nil)

(defun comtabp (comtab?) (istruct-typep comtab? 'comtab))
(set-type-predicate 'comtab 'comtabp)

(defun comtab-data (comtab)
  (if (comtabp comtab) (%comtab-data comtab) (%badarg comtab 'comtab)))

(defun comtab-default (comtab)
  (if (comtabp comtab) (%comtab-default comtab) (%badarg comtab 'comtab)))

(defun comtab-set-default (comtab new-value)
  (if (comtabp comtab) (setf (%comtab-default comtab) new-value) (%badarg comtab 'comtab)))

(defun make-comtab (&optional default)
  (%cons-comtab '() (cond ((comtabp default)
                           #'(lambda (w)(run-default-command w default)))
                          ((not default)
                           #'(lambda (w)(run-default-command w *comtab*)))                               
                          (t default))))

(defun copy-comtab (&optional (from-comtab *comtab*))
  (%cons-comtab (copy-tree (comtab-data (or from-comtab %initial-comtab%)))
                (comtab-default (or from-comtab %initial-comtab%))))

(defun comtab-get (comtab keystroke &aux (code (keystroke-code keystroke))
                                         (a (assq code (comtab-data comtab))))
 "Internal. Returns (function . doc-string-info)"
  (when (and (null a)(%ilogbitp #$shiftkeybit code))
    (setq code (%ilogand code (lognot #$shiftkey)))
    (setq a (assq code (comtab-data comtab))))
  (when (and (null a) (not (%izerop (%ilogand #x-100 code))))
    ;Try changing case.
    (setq a (let ((ch (%ilogand #xFF code)))
              (cond ((and (%i<= 97 ch) (%i<= ch 122))
                     (assq (%i- code 32) (%comtab-data comtab)))
                    ((and (%i<= 65 ch) (%i<= ch 90))
                     (assq (%i+ code 32) (%comtab-data comtab)))))))
  (%cdr a))

(defun comtab-get-key (comtab keystroke)
 (%car (comtab-get comtab keystroke)))

(defun comtab-key-documentation (comtab keystroke)
  (let ((doc (%cdr (comtab-get comtab keystroke))))
    (if (fixnump doc) (%rsc-string doc) doc)))

(defun comtab-set-key (comtab keystroke function &optional doc-string)
  (when (and doc-string (not (stringp doc-string))) (report-bad-arg doc-string 'string))
  (unless (or (functionp function) (symbolp function) (comtabp function))
    (setq function (keystroke-code function)))
  (let ((code (keystroke-code keystroke)))
    (if (null function)
      (setf (%comtab-data comtab) (remove-from-alist code (comtab-data comtab)))
      (let* ((def (cons function doc-string))
             (a (assq code (comtab-data comtab))))
        (if a (%rplacd a def)
          (setf (%comtab-data comtab) (cons (cons code def) (%comtab-data comtab)))))))
  comtab)

(defmacro def-fred-command (keystroke function &optional doc-string)
  (if (symbolp function) (setq function `',function))
  (if (and (listp function) (eq (car function) 'lambda))
    (setq function `(function ,function)))
  `(comtab-set-key *comtab* ',keystroke ,function ,doc-string))

(defun comtab-find-keys (comtab function)
  (unless (or (functionp function)
              (symbolp function))
    (setq function (keystroke-code function)))
  (do ((alist (comtab-data comtab) (%cdr alist))
       (keys))
      ((null alist) keys)
   (when (eq (%cadr (%car alist)) function) (push (%car (%car alist)) keys))))

(defun keystroke-name (keystroke &aux (code (keystroke-code keystroke)))
  (cond ((%izerop (%ilogand #x-100 code))
         (%code-char code))
        ((%izerop (%ilogand #x-2000 code))
         (let ((name (list (%code-char (%ilogand code #xff)))))
           (when (%ilogbitp #$optionkeybit code) (push ':meta name))
           (when (%ilogbitp #$controlkeybit code) (push ':control name))
           (when (%ilogbitp $functionkeybit code) (push ':function name))
           (when (%ilogbitp #$shiftkeybit code) (push ':shift name))  ; left and right arrow today
           name))
        (t code)))

; replaced-by lib;chars.lisp
(defun char-name (c) c)

(defun format-keystroke (keystroke stream)
  (setq keystroke (keystroke-code keystroke))
  (cond ((%izerop (%ilogand #x-100 keystroke))
         (setq keystroke (%code-char keystroke))
         (princ (if (eq keystroke #\Return) "Return"
                    (or (char-name keystroke) keystroke)) stream))
        ((%izerop (%ilogand #x-2000 keystroke))
	 (when (%ilogbitp $functionkeybit keystroke) (princ "f-" stream))
	 (when (%ilogbitp #$controlkeybit keystroke) (princ "c-" stream))
	 (when (%ilogbitp #$optionkeybit keystroke) (princ "m-" stream))
         (when (%ilogbitp #$shiftkeybit keystroke) (princ "shift-" stream))         
         (format-keystroke (%ilogand keystroke #xff) stream))))

(defun keystroke-code (keystroke &aux (code keystroke))
  (cond ((fixnump code)
         code)
        ((characterp code) (%char-code code))
        ((consp code)
         (let ((mods 0))
           (while (cdr code)
             (cond ((eq (%car code) ':control) (setq mods (%ilogior #$controlkey mods)))
                   ((eq (%car code) ':meta) (setq mods (%ilogior #$optionkey mods)))
                   ((eq (%car code) ':function) (setq mods (%ilogior $functionkeymask mods)))
                   ((eq (%car code) ':shift)(setq mods (%ilogior #$shiftKey mods)))
                   ((eq (%car code) ':command)(setq mods (%ilogior #$cmdkey mods)))
                   (t (report-bad-arg (%car code) '(member :control :meta :function :shift :command))))
             (setq code (%cdr code)))
           (unless (characterp (setq code (%car code))) (report-bad-arg code 'character))
           (when (and (%ilogbitp #$shiftkeybit mods)(alpha-char-p code))
             (setq code (char-upcase code)))
           (%ilogior mods (%char-code code))))
        (t (report-bad-arg keystroke '(or fixnum character cons)))))

(defparameter *control-x-comtab*
  (let ((comtab (make-comtab 'ed-beep)))
    ;(comtab-set-key comtab '(:control #\a)    'ed-arglist) ; moved to arglist
    ;(comtab-set-key comtab '(:control #\c)    'ed-eval-or-compile-top-level-sexp) ; move to l1-ed-lds
    ;(comtab-set-key comtab '(:control #\d)    'ed-get-documentation) ; move to doc-window
    ;(comtab-set-key comtab '(:control #\e)    'ed-eval-current-sexp)
    ;(comtab-set-key comtab '(:control #\i)    'ed-info-current-sexp) ; move to inspector
    ;(comtab-set-key comtab '(:control #\m)    'ed-macroexpand-current-sexp)
    (comtab-set-key comtab '(:control #\p)     'ed-find-unbalanced-paren)
    (comtab-set-key comtab '(:control #\r)    'ed-read-current-sexp)     
    
    (comtab-set-key comtab #\h                'select-all)
    (comtab-set-key comtab '(:control #\s)    'window-save)
    (comtab-set-key comtab '(:control #\v)    'edit-select-file) ;Should be c-x c-r
    (comtab-set-key comtab '(:control #\w)    'window-save-as)
    (comtab-set-key comtab '(:control #\x)    'ed-exchange-point-and-mark)
    (comtab-set-key comtab '(:control #\space) 'ed-delete-forward-whitespace)
    (comtab-set-key comtab #\;                'ed-set-comment-column)
    (comtab-set-key comtab '(:control #\u)    'ed-history-undo)
    (comtab-set-key comtab #\escape	      'remove-shadowing-comtab)
    (comtab-set-key comtab '(:control #\g)    'remove-shadowing-comtab)
    (comtab-set-key comtab '(:control #\f)    'ed-xform-linefeeds)  ;; fix the pig ffing linefeeds
    comtab))

(defparameter *control-q-comtab* (make-comtab 'ed-self-insert))




(defparameter %initial-comtab%
  (let ((comtab (make-comtab #'(lambda (w)
                                 (let ((code (keystroke-code *current-keystroke*)))
                                   (if (or (%izerop (%ilogand #x-100 code))
                                           (and (not (logbitp #$controlkeybit code))
                                                (not (logbitp #$cmdkeybit code))))
                                     (ed-self-insert w)
                                     (ed-beep w)))))))
  (comtab-set-key comtab #\escape		 'ed-collapse-selection) 
  (comtab-set-key comtab #\Backspace             'ed-rubout-char)
  (comtab-set-key comtab '(:shift #\backspace)   'ed-rubout-char)
  (comtab-set-key comtab '(:meta #\backspace)    'ed-rubout-word)
  (comtab-set-key comtab '(:control :meta #\backspace) 'ed-kill-backward-sexp)  ; 'ed-delete-bwd-delimiters)
  (comtab-set-key comtab #\Tab                   'ed-indent-for-lisp)
  (comtab-set-key comtab '(:control #\tab)       'ed-indent-differently)
  (comtab-set-key comtab '(:meta #\tab)          'ed-self-insert)	
  (comtab-set-key comtab #\Return                'ed-self-insert-maybe-LF)
  (comtab-set-key comtab #\BackArrow             'ed-backward-char)
  (comtab-set-key comtab '(:meta #\BackArrow)    'ed-backward-word)
  (comtab-set-key comtab '(:shift #\BackArrow)   'ed-backward-select-char)
  (comtab-set-key comtab '(:meta :shift #\BackArrow)    'ed-backward-select-word)  
  (comtab-set-key comtab '(:control #\BackArrow) 'ed-backward-sexp)
  (comtab-set-key comtab '(:control :shift #\BackArrow) 'ed-backward-select-sexp)
  (comtab-set-key comtab '(:control :meta #\BackArrow) 'ed-backward-sexp)
  (comtab-set-key comtab '(:control :meta :shift #\BackArrow) 'ed-backward-select-sexp)
  (comtab-set-key comtab #\ForwardArrow          'ed-forward-char)
  (comtab-set-key comtab '(:meta #\ForwardArrow) 'ed-forward-word)
  (comtab-set-key comtab '(:shift #\ForwardArrow) 'ed-forward-select-char)
  (comtab-set-key comtab '(:meta :shift #\ForwardArrow) 'ed-forward-select-word)
  (comtab-set-key comtab '(:control #\ForwardArrow) 'ed-forward-sexp)
  (comtab-set-key comtab '(:control :shift #\ForwardArrow) 'ed-forward-select-sexp)
  (comtab-set-key comtab '(:control :meta #\ForwardArrow) 'ed-forward-sexp)
  (comtab-set-key comtab '(:control :meta :shift #\ForwardArrow) 'ed-forward-select-sexp)
  (comtab-set-key comtab #\UpArrow               'ed-previous-line)
  (comtab-set-key comtab '(:shift #\UpArrow)     'ed-select-previous-line)
  (comtab-set-key comtab '(:control :meta #\UpArrow)  'ed-previous-list)
  (comtab-set-key comtab '(:control :meta :shift #\UpArrow)  'ed-select-previous-list)
  (comtab-set-key comtab #\DownArrow             'ed-next-line)
  (comtab-set-key comtab '(:shift #\DownArrow)   'ed-select-next-line)
  (comtab-set-key comtab '(:control :meta #\DownArrow)   'ed-next-list)
  (comtab-set-key comtab '(:control :meta :shift #\DownArrow)   'ed-select-next-list)
  ;(comtab-set-key comtab #\Enter                 'ed-eval-or-compile-current-sexp)
  ;(comtab-set-key comtab #\space                 'interactive-arglist) ; moved to arglist

  (comtab-set-key comtab '(:control #\return)    'ed-newline-and-indent)
  (comtab-set-key comtab '(:meta #\space)        'ed-delete-whitespace)

  (comtab-set-key comtab '(:control #\a)         'ed-beginning-of-line)
  (comtab-set-key comtab '(:control :shift #\A)  'ed-select-beginning-of-line)
  (comtab-set-key comtab '(:control :meta #\a)   'ed-start-top-level-sexp)
  (comtab-set-key comtab '(:control :meta :shift  #\A)	 'ed-select-start-top-level-sexp)  ; cheats
  (comtab-set-key comtab '(:control #\b)         'ed-backward-char)
  (comtab-set-key comtab '(:control :shift #\B)  'ed-backward-select-char)
  (comtab-set-key comtab '(:meta #\b)            'ed-backward-word)
  (comtab-set-key comtab '(:meta :shift #\B)     'ed-backward-select-word)
  (comtab-set-key comtab '(:control :meta #\b)   'ed-backward-sexp)
  (comtab-set-key comtab '(:control :meta :shift #\B)   'ed-backward-select-sexp)
  (comtab-set-key comtab '(:meta #\c)            'ed-capitalize-word)
  (comtab-set-key comtab '(:control #\d)         'ed-delete-char)
  (comtab-set-key comtab '(:meta #\d)            'ed-delete-word)
  (comtab-set-key comtab '(:control :meta #\d)   'ed-down-list) ;'ed-kill-forward-sexp)   ;'ed-delete-fwd-delimiters)
  (comtab-set-key comtab '(:control #\e)         'ed-end-of-line)
  (comtab-set-key comtab '(:control :shift #\E)  'ed-select-end-of-line)
  (comtab-set-key comtab '(:control :meta #\e)   'ed-end-top-level-sexp)
  (comtab-set-key comtab '(:control :meta :shift #\E)   'ed-select-end-top-level-sexp)  ; this one cheats
  (comtab-set-key comtab '(:control #\f)         'ed-forward-char)
  (comtab-set-key comtab '(:control :shift #\F)  'ed-forward-select-char)
  (comtab-set-key comtab '(:meta #\f)            'ed-forward-word)
  (comtab-set-key comtab '(:meta :shift #\F)     'ed-forward-select-word)
  (comtab-set-key comtab '(:control :meta #\f)   'ed-forward-sexp)
  (comtab-set-key comtab '(:control :meta :shift #\F)   'ed-forward-select-sexp)
  ;(comtab-set-key comtab '(:control #\i)         'ed-inspect-current-sexp)
  (comtab-set-key comtab '(:meta #\j) 'ed-toggle-auto-keyscript)
  (comtab-set-key comtab '(:control #\k)         'ed-kill-line)
  (comtab-set-key comtab '(:control :meta #\k)   'ed-kill-forward-sexp)
  (comtab-set-key comtab '(:meta #\l)            'ed-downcase-word)
  (comtab-set-key comtab '(:control :meta #\l)   'ed-last-buffer)
  ;(comtab-set-key comtab '(:control #\m)         'ed-macroexpand-1-current-sexp)
  (comtab-set-key comtab '(:meta #\m)            'ed-back-to-indentation)
  (comtab-set-key comtab '(:control :meta #\m)   'reparse-modeline)
  (comtab-set-key comtab '(:control :meta :shift #\M)   'add-modeline)
  (comtab-set-key comtab '(:control #\n)         'ed-next-line)
  (comtab-set-key comtab '(:control :shift #\N)  'ed-select-next-line)
  (comtab-set-key comtab '(:control :meta #\n)   'ed-next-list)
  (comtab-set-key comtab '(:control :meta :shift #\N)   'ed-select-next-list)
  (comtab-set-key comtab '(:control #\o)         'ed-open-line)
  (comtab-set-key comtab '(:control :meta #\o)   'ed-split-line)
  (comtab-set-key comtab '(:control #\p)         'ed-previous-line)
  (comtab-set-key comtab '(:control :shift #\P) 'ed-select-previous-line)
  (comtab-set-key comtab '(:control :meta #\p)  'ed-previous-list)
  (comtab-set-key comtab '(:control :meta :shift #\P)  'ed-select-previous-list) 
  (comtab-set-key comtab '(:control #\q)         *control-q-comtab*)
  (comtab-set-key comtab '(:control :meta #\q)   'ed-indent-sexp)
  (comtab-set-key comtab '(:control #\s)         'ed-i-search-forward)
  (comtab-set-key comtab '(:control #\r)         'ed-i-search-reverse)
  (comtab-set-key comtab '(:control #\t)         'ed-transpose-chars)
  (comtab-set-key comtab '(:meta #\t)            'ed-transpose-words)
  (comtab-set-key comtab '(:control :meta #\t)   'ed-transpose-sexps)
  (comtab-set-key comtab '(:control #\u)         'ed-universal-argument)
  (comtab-set-key comtab '(:control :meta #\u)   'ed-bwd-up-list)
  (comtab-set-key comtab '(:meta #\U)            'ed-upcase-word)
    ;lower case meta-u is a "dead" key hence we must use upper case u .
  (comtab-set-key comtab '(:control #\v)         'ed-next-screen)  
  (comtab-set-key comtab '(:control :shift #\V)  'ed-select-next-screen)
  (comtab-set-key comtab '(:meta #\v)            'ed-previous-screen)
  (comtab-set-key comtab '(:meta :shift #\V)     'ed-select-previous-screen)
  (comtab-set-key comtab '(:control #\w)         'ed-kill-region)
  (comtab-set-key comtab '(:meta #\w)            'ed-copy-region-as-kill)
  (comtab-set-key comtab '(:control #\x)         *control-x-comtab*)
  (comtab-set-key comtab '(:control #\y)         'ed-yank)
  (comtab-set-key comtab '(:meta #\y)            'ed-yank-pop)

  (comtab-set-key comtab '(:meta #\<)            'ed-beginning-of-buffer)
  (comtab-set-key comtab '(:meta #\>)            'ed-end-of-buffer)

  (comtab-set-key comtab '(:meta #\;)            'ed-indent-comment)
  (comtab-set-key comtab '(:control :meta #\;)   'ed-kill-comment)

  (comtab-set-key comtab #\PageUp		'ed-previous-screen)  	; page up
  (comtab-set-key comtab '(:shift #\PageUp)	'ed-select-previous-screen)
  (comtab-set-key comtab #\pageDown		'ed-next-screen)  	; page down
  (comtab-set-key comtab '(:shift #\pageDown)	'ed-select-next-screen)
  (comtab-set-key comtab #\Home			'ed-beginning-of-buffer)	; home
  (comtab-set-key comtab #\End                  'ed-end-of-buffer)	; end		
  (comtab-set-key comtab  #\ForwardDelete        'ed-delete-char)
  (comtab-set-key comtab '(:function #\1)        'undo)
  (comtab-set-key comtab '(:function #\2)        'cut)
  (comtab-set-key comtab '(:function #\3)        'copy)
  (comtab-set-key comtab '(:function #\4)        'paste)
   
 
  (comtab-set-key comtab '(:meta #\#)            'ed-insert-sharp-comment)
  (comtab-set-key comtab '(:meta  #\")           'ed-insert-double-quotes)
  (comtab-set-key comtab '(:meta  #\()           'ed-insert-parens)
  (comtab-set-key comtab '(:control :meta  #\()  'ed-bwd-up-list)  ; same as c-m-u  
  (comtab-set-key comtab '(:meta #\))            'ed-move-over-close-and-reindent)
  (comtab-set-key comtab '(:control :meta #\))   'ed-fwd-up-list)
  (comtab-set-key comtab '(:meta #\\)            'ed-delete-horizontal-whitespace)
  

  ;(comtab-set-key comtab '(:control #\/)         'ed-help) ; moved to fred-help
  ;(comtab-set-key comtab '(:control #\?)         'ed-help) ; ditto
  (comtab-set-key comtab '(:control #\=)         'ed-what-cursor-position)
  (comtab-set-key comtab '(:control #\+)         'ed-what-cursor-position)   ; for mac plus users
  ;(comtab-set-key comtab '(:meta #\.)      'ed-edit-definition)   ; moved to edit-definition
  ;(comtab-set-key comtab #\Help                    'ed-inspect-current-sexp) 	; help moved to inspector
  (comtab-set-key comtab '(:control :meta #\Space) 'ed-select-current-sexp)
  (comtab-set-key comtab '(:control #\Space)     'ed-push/pop-mark-ring)
  (comtab-set-key comtab '(:control :meta #\h)   'ed-select-top-level-sexp)
  (comtab-set-key comtab '(:control :meta #\@)   '(:control :meta #\Space))
  (comtab-set-key comtab '(:control #\@)         '(:control #\Space))
  (comtab-set-key comtab '(:meta #\~)            'window-set-not-modified)
  (comtab-set-key comtab '(:control #\_)         'ed-history-undo)
  (comtab-set-key comtab '(:control :meta #\_)   'ed-print-history)
  (comtab-set-key comtab '(:control :meta #\r)   'ed-reset-font)
  
  (comtab-set-key comtab '#\0                    'ed-digit)
  (comtab-set-key comtab '#\-                    'ed-digit)
  (comtab-set-key comtab '#\1                    'ed-digit)
  (comtab-set-key comtab '#\2                    'ed-digit)
  (comtab-set-key comtab '#\3                    'ed-digit)
  (comtab-set-key comtab '#\4                    'ed-digit)
  (comtab-set-key comtab '#\5                    'ed-digit)
  (comtab-set-key comtab '#\6                    'ed-digit)
  (comtab-set-key comtab '#\7                    'ed-digit)
  (comtab-set-key comtab '#\8                    'ed-digit)
  (comtab-set-key comtab '#\9                    'ed-digit)

  (comtab-set-key comtab '(:meta #\-)            'ed-numeric-argument)
  (comtab-set-key comtab '(:meta #\0)            'ed-numeric-argument)
  (comtab-set-key comtab '(:meta #\1)            'ed-numeric-argument)
  (comtab-set-key comtab '(:meta #\2)            'ed-numeric-argument)
  (comtab-set-key comtab '(:meta #\3)            'ed-numeric-argument)
  (comtab-set-key comtab '(:meta #\4)            'ed-numeric-argument)
  (comtab-set-key comtab '(:meta #\5)            'ed-numeric-argument)
  (comtab-set-key comtab '(:meta #\6)            'ed-numeric-argument)
  (comtab-set-key comtab '(:meta #\7)            'ed-numeric-argument)
  (comtab-set-key comtab '(:meta #\8)            'ed-numeric-argument)
  (comtab-set-key comtab '(:meta #\9)            'ed-numeric-argument)
  (comtab-set-key comtab '(:control #\-)         'ed-numeric-argument)
  (comtab-set-key comtab '(:control #\0)         'ed-numeric-argument)
  (comtab-set-key comtab '(:control #\1)         'ed-numeric-argument)
  (comtab-set-key comtab '(:control #\2)         'ed-numeric-argument)
  (comtab-set-key comtab '(:control #\3)         'ed-numeric-argument)
  (comtab-set-key comtab '(:control #\4)         'ed-numeric-argument)
  (comtab-set-key comtab '(:control #\5)         'ed-numeric-argument)
  (comtab-set-key comtab '(:control #\6)         'ed-numeric-argument)
  (comtab-set-key comtab '(:control #\7)         'ed-numeric-argument)
  (comtab-set-key comtab '(:control #\8)         'ed-numeric-argument)
  (comtab-set-key comtab '(:control #\9)         'ed-numeric-argument)
  (comtab-set-key comtab '(:control :meta #\-)   'ed-numeric-argument)
  (comtab-set-key comtab '(:control :meta #\0)   'ed-numeric-argument)
  (comtab-set-key comtab '(:control :meta #\1)   'ed-numeric-argument)
  (comtab-set-key comtab '(:control :meta #\2)   'ed-numeric-argument)
  (comtab-set-key comtab '(:control :meta #\3)   'ed-numeric-argument)
  (comtab-set-key comtab '(:control :meta #\4)   'ed-numeric-argument)
  (comtab-set-key comtab '(:control :meta #\5)   'ed-numeric-argument)
  (comtab-set-key comtab '(:control :meta #\6)   'ed-numeric-argument)
  (comtab-set-key comtab '(:control :meta #\7)   'ed-numeric-argument)
  (comtab-set-key comtab '(:control :meta #\8)   'ed-numeric-argument)
  (comtab-set-key comtab '(:control :meta #\9)   'ed-numeric-argument)

  comtab))

(defparameter *comtab* %initial-comtab%)
(defparameter *listener-comtab* %initial-comtab%) ; redefined in l1-listener

#| ;; old one
(defun get-dead-keys (&aux ret temp)
  (let* ((kchr-ptr (%get-ptr (%get-ptr (%int-to-ptr #x2b6)) 14))
         (ct-num (%get-word kchr-ptr 258))
         (dk-start (+ 260 (* ct-num 128)))
         (dk-num (%get-word kchr-ptr dk-start)))
    (declare (dynamic-extent kchr-ptr))
    (do* ((offset (+ dk-start 2) 
                  (+ offset 6 (* 2 (%get-word kchr-ptr (+ offset 2)))))
          (count dk-num (1- count))
          table keycode)
         ((zerop count) ret)
      (setq table (%get-byte kchr-ptr offset)
            keycode (%get-byte kchr-ptr (+ offset 1)))
      (if (setq temp (assq table ret))
        (rplacd temp (cons keycode (cdr temp)))
        (push (list table keycode) ret)))))



(defun get-dead-keys-2 (&aux ret temp)
  (let ((sys-kchr (#_getresource "KCHR" (#_getscriptvariable #$smroman #$smscriptkeys))))
    (#_LoadResource sys-kchr)
    (with-dereferenced-handles ((kchr-ptr sys-kchr))
      (let* (;(kchr-ptr (%get-ptr (%get-ptr (%int-to-ptr #x2b6)) 14))
             (ct-num (%get-word kchr-ptr 258))
             (dk-start (+ 260 (* ct-num 128)))
             (dk-num (%get-word kchr-ptr dk-start)))
        (declare (dynamic-extent kchr-ptr))
        (do* ((offset (+ dk-start 2) 
                      (+ offset 6 (* 2 (%get-word kchr-ptr (+ offset 2)))))
              (count dk-num (1- count))
              table keycode)
             ((zerop count) ret)
          (setq table (%get-byte kchr-ptr offset)
                keycode (%get-byte kchr-ptr (+ offset 1)))
          (if (setq temp (assq table ret))
            (rplacd temp (cons keycode (cdr temp)))
            (push (list table keycode) ret)))))))
|#

(defun get-dead-keys (&aux ret temp)
  (let* ((kchr-ptr (%int-to-ptr (#_getscriptmanagervariable  #$smKCHRCache)))
         (ct-num (%get-word kchr-ptr 258))
         (dk-start (+ 260 (* ct-num 128)))
         (dk-num (%get-word kchr-ptr dk-start)))
    (declare (dynamic-extent kchr-ptr))
    (do* ((offset (+ dk-start 2) 
                  (+ offset 6 (* 2 (%get-word kchr-ptr (+ offset 2)))))
          (count dk-num (1- count))
          table keycode)
         ((zerop count) ret)
      (setq table (%get-byte kchr-ptr offset)
            keycode (%get-byte kchr-ptr (+ offset 1)))
      (if (setq temp (assq table ret))
        (rplacd temp (cons keycode (cdr temp)))
        (push (list table keycode) ret)))))


(defun get-dead-keys-state () ; this here is the state we want
  *dead-keys-state*)

; this here is the state that is - not used now?
(defun get-dead-keys-state1 ()
  (let* ((kchr-ptr (%int-to-ptr (#_getscriptmanagervariable  #$smKCHRCache)))
         (base-table (%inc-ptr kchr-ptr 260))
         (table (%null-ptr)))
    (declare (dynamic-extent kchr-ptr base-table table))
    (dolist (table-entry *default-dead-keys*)
      (%setf-macptr table (%inc-ptr base-table (* 128 (car table-entry))))
      (dolist (keycode (cdr table-entry))
        (when (eq 0 (%get-byte table  keycode))
          ; so if any one is dead we assume all dead - morbid
          (return-from get-dead-keys-state1 t))))))

(defparameter *default-dead-keys* nil)

(def-ccl-pointers dead-keys ()
  (setq *default-dead-keys* (get-dead-keys)))

#| ;; OLD ONE
(defun set-dead-keys (flag)
  (let* ((kchr-ptr (%get-ptr (%get-ptr (%int-to-ptr #x2b6)) 14))
         (base-table (%inc-ptr kchr-ptr 260))
         (table (%null-ptr)))
    (declare (dynamic-extent kchr-ptr base-table table))
    (dolist (table-entry *default-dead-keys*)
      (%setf-macptr table (%inc-ptr base-table (* 128 (car table-entry))))
      (dolist (keycode (cdr table-entry))
        (%put-byte table (if flag 0 (%get-byte base-table keycode)) keycode)))
    (setq *dead-keys-state* flag)))


;;; doesn't work
(defun set-dead-keys-2 (flag)
  (when t
    (let ((sys-kchr (#_getresource "KCHR" (#_getscriptvariable #$smroman #$smscriptkeys))))
      (#_LoadResource sys-kchr)
      ;(#_hsetstate sys-kchr 0)
      (with-dereferenced-handles ((kchr-ptr sys-kchr))
        (let* (;(kchr-ptr (%get-ptr (%get-ptr (%int-to-ptr #x2b6)) 14))
               (base-table (%inc-ptr kchr-ptr 260))
               (table (%null-ptr)))
          (declare (dynamic-extent  base-table table))
          (dolist (table-entry *default-dead-keys*)
            (%setf-macptr table (%inc-ptr base-table (* 128 (car table-entry))))
            (dolist (keycode (cdr table-entry))
              (%put-byte table (if flag 0 (%get-byte base-table keycode)) keycode)))
          (setq *dead-keys-state* flag)))))
  flag)
|#

;; this works - is it any more P.C.
(defun set-dead-keys (flag)
  (if (jaguar-p)
    (setq *dead-keys-state* flag) ;nil   ;; the kchrCache is read only on Jaguar
    (let* ((kchr-ptr (%int-to-ptr (#_getscriptmanagervariable  #$smKCHRCache)))
           (base-table (%inc-ptr kchr-ptr 260))
           (table (%null-ptr)))
      (declare (dynamic-extent kchr-ptr base-table table))
      (dolist (table-entry *default-dead-keys*)
        (%setf-macptr table (%inc-ptr base-table (* 128 (car table-entry))))
        (dolist (keycode (cdr table-entry))
          (%put-byte table (if flag 0 (%get-byte base-table keycode)) keycode)))
      (setq *dead-keys-state* flag))))
    






#|
(defloadvar *old-keytrans-address* (#_GetTrapAddress :new :sys #_KeyTrans))
(defloadvar *new-keytrans-address* (let* ((q '#.(%lap-words '((bset.b ($ 7) (sp 9)) (jmp (@L 0)))))
                                          (n (length q))
                                          (p (#_NewPtr  (+ n n))))
                                     (declare (fixnum n))
                                     (dotimes (i n)
                                       (setf (%get-word p (%i+ i i)) (pop q)))
                                     (setf (%get-ptr p (%i- (%i+ n n) 4)) *old-keytrans-address*)
                                     p))
(defun set-dead-keys (flag)
  (#_SetTrapAddress :new :sys (if flag *old-keytrans-address* *new-keytrans-address*) #_KeyTrans))
|#

(defloadvar *lisp-keytrans-state* (#_NewPtrClear 4))
(defloadvar *current-kchr-id* (#_GetScriptvariable #$smRoman #$smScriptKeys))

(defun get-kchr-copy (&optional res-macptr (id *current-kchr-id*))
  (rlet ((h :handle))
    (let* ((sys-kchr (#_GetResource "KCHR" id))
           (handle-state
            (progn
              (if (%null-ptr-p sys-kchr)
                (error "Can't find 'KCHR' resource #~d" id))
              (#_LoadResource sys-kchr)
              (#_HGetState sys-kchr))))
      (declare (dynamic-extent sys-kchr))
      (#_HLock sys-kchr)
      (setf (%get-ptr h) sys-kchr)
      (#_HandToHand h)
      (#_HSetState sys-kchr handle-state)
      (if (null res-macptr) (setq res-macptr (%null-ptr)))
      (%setf-macptr res-macptr (%get-ptr h))
      res-macptr)))

#|(defloadvar *current-kchr-resource* (get-kchr-copy))|#

(defloadvar *current-kchr-resource* (unless (jaguar-p) (get-kchr-copy)))

#|
;; KLGetCurrentKeyboardLayout is in Keyboards.h

/System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/
HIToolbox.framework/Versions/A/Headers/Keyboards.h

Keyboard Layout Services:
<http://developer.apple.com/techpubs/macosx/Carbon/text/KeyBoardLayoutServices/keyboardlayoutservices.html>

|#

#-interfaces-3
(eval-when (:compile-toplevel :load-toplevel :execute)
(deftrap-inline "_KLGetCurrentKeyboardLayout"
  ((oKeyboardLayout :pointer))
  :OSStatus
  ())

(deftrap-inline "_KLGetKeyboardLayoutProperty"
  ((iKeyboardLayout :pointer)
   (iPropertyTag :uint32)
   (oValue :pointer))
  :OSStatus
  ())
)

;(defconstant kKLKCHRData 0)

#|
(defun current-key-layout ()
  (rlet ((layout :pointer))
    (#_KLGetCurrentKeyBoardLayout layout)
    (%get-ptr layout)))

(defun get-kchr (key-layout)
  (rlet ((kchr :pointer))
    (#_KLGetKeyboardLayoutProperty key-layout #$kKLKCHRData kchr)
    (%get-ptr kchr)))
|#

(defun get-current-kchr ()
  (rlet ((layout :pointer)
         (kchr :pointer))
    (#_KLGetCurrentKeyBoardLayout layout)
    (#_KLGetKeyboardLayoutProperty (%get-ptr layout) #$kKLKCHRData kchr)
    (%get-ptr kchr)))
  

;(defvar *current-key-layout* nil)
(defvar *current-kchr* nil)

(def-ccl-pointers jkbd ()
  (when (jaguar-p)
    ;(setq *current-key-layout* (current-key-layout))
    (setq *current-kchr* (get-current-kchr))))



;this version fixes a bug whereby control-p was disambiguated from
;function keys (which also have a key-code of control-p) by the
;location on the keyboard (location may vary from one country to another).
;the new version checks if the control-key was pressed.

(defun event-keystroke (message modifiers)
  (declare (fixnum message modifiers))
  (if message
    (let* ((ch (logand #xFF message))
           (keycode (%ilogand #x7f (ash message -8)))
           (fkey-alist '((122 . 49)(120 . 50)(99 . 51)(118 . 52)(96 . 53)(97 . 54)
                         (98 . 55)(100 . 56)(101 . 57)(109 . 65)(103 . 66)(111 . 67)
                         (105 . 68)(107 . 69)(113 . 70)))
           foo)
      (declare (fixnum keycode ch))      
      (setq ch 
            (if (and (eq ch 16)(setq foo (cdr (assq keycode fkey-alist))))  ;; (defconstant $kFunctionKeyCharCode 16) = (char-code #\^P) 
              (the fixnum (+ $functionkeymask (the fixnum foo)))
              (progn
                (if (and (eql ch #.(char-code #\^P)) ;; CONTROL-P - CROCK IN OS 9.1 loses option-key - something about hot vs cold function keys
                         (let ((*current-event* NIL))
                           (Option-KEY-P)))
                  (setq modifiers (logior modifiers #$optionkey)))
                (if (eql 0 (logand modifiers #.(- #xff00 #x600))) ; no mods but shift or capslock (logior #$shiftkey #$alphalock)
                  ch
                  ;; 2003-03-03 keke@gol.com
                  ;; do not call get-kchr-copy if Jaguar.
                  ;; - this leaves *current-kchr-resource* and *current-kchr-resource*
                  ;;   untouched. may break something else.
                  (if (jaguar-p)
                    (let ((kchrID (#_GetScriptvariable #$smRoman #$smScriptKeys)))
                      (unless (eq kchrID *current-kchr-id*)
                        (without-interrupts
                         (%put-long *lisp-keytrans-state* 0)
                         (setq *current-kchr-id* kchrID)
                         ;(setq *current-key-layout* (current-key-layout))
                         (setq *current-kchr* (get-current-kchr))))
                      (logand #xFF (the fixnum
                                     (#_KeyTranslate
                                      *current-kchr* ;(get-kchr *current-key-layout*)  ;; do it once
                                      (+ keycode
                                         (logand (logior #$shiftkey #$alphalock) modifiers))
                                      *lisp-keytrans-state*))))
                    (let* ((kchrID (#_GetScriptvariable #$smRoman #$smScriptKeys))
                           (curkchr *current-kchr-resource*))
                      (unless (eq kchrID *current-kchr-id*)
                        (without-interrupts
                         (%put-long *lisp-keytrans-state* 0)
                         (#_DisposeHandle curkchr)
                         (get-kchr-copy curkchr (setq *current-kchr-id* kchrID))))
                      (with-dereferenced-handles ((p curkchr))
                        (logand #xff (the fixnum
                                       (#_KeyTranslate  
                                        p
                                        (+ keycode 
                                           (logand (logior #$shiftkey #$alphalock) modifiers))
                                        *lisp-keytrans-state*))))))))))
      (when (and *control-key-mapping* (%ilogbitp #$cmdkeybit modifiers))      
        (setq modifiers              
              (case *control-key-mapping*           
                (:command              
                 (if (%ilogbitp #$shiftkeybit modifiers) ; shifted
                   (logand modifiers (lognot #$shiftkey)) ; becomes command
                   ; unshifted becomes control
                   (logior #$controlkey (logand modifiers (lognot #$cmdkey)))))
                (:command-shift
                 (if (%ilogbitp #$shiftkeybit modifiers)
                   (logior #$controlkey (logand modifiers (lognot (logior #$cmdkey #$shiftkey)))) ; becomes control
                   modifiers))
                (t modifiers))))
      (if (and (logbitp #$ShiftKeyBit modifiers)
               ;(not (logbitp $CmdKey modifiers)))
               (or (< ch #x20)(eq ch #x7f)
                   (logbitp $functionkeybit ch)  ;; what? 
                   (and (let ((char (%code-char ch)))
                          (and char (alpha-char-p char)))
                        (or (%ilogbitp #$controlkeyBit modifiers)(%ilogbitp #$optionkeyBit modifiers)(%ilogbitp #$cmdkeyBit modifiers))))
               (neq ch 13))   ;(eq ch (%char-code #\Backarrow)) ; or < #x20 but not = 13 ?
           ;(eq ch (%char-code #\ForwardArrow)) ; these are 28-31
           ;(eq ch (%char-code #\UpArrow))
           ;(eq ch (%char-code #\DownArrow))))
           (setq ch (logior ch #$shiftkey)))      
      (setq ch (logior ch (logand modifiers (logior #$controlkey #$optionkey #$cmdkey))))      
      ch)
    0))



;;>> Don't break things you don't understand!!
;;>> Here's how it SHOULD work for compatibility with Lisp Machines,
;;>>  which is what this must be compatible with by definition
;;
;; FOO => (make-package "FOO") [:use "LISP"]
;; (FOO) => (make-package "FOO" :use ())
;; (FOO (bar baz) 100) => (make-package "FOO" :USE '(BAR BAZ)) [ignore cruddy lispm size spec]
;; (FOO (bar baz)) => (make-package "FOO" :USE '(BAR BAZ)))
;; (FOO &rest x) => (apply #'make-package "FOO" x)
(defun buffer-modeline-package (buffer &optional no-create)
  (block top
    (multiple-value-bind (pos end) (buffer-modeline-attribute-range buffer 'package)
      (when pos
        (ignore-errors
         (multiple-value-bind (form pos) (ignore-errors (buffer-read buffer pos end))
           (when (and pos form)
             (flet ((foo (name &rest args)
                      (or (find-package name)
                          (if no-create
                            name
                            (apply #'lispm-make-package name args)))))
               (if (not (consp form))
                 (return-from top 
                   (or (find-package form)
                       (if no-create
                         form 
                         (progn
                           (cerror "Forms will be read in the package bound to *package*" "Package ~A does not exist" form)
                           (buffer-putprop buffer 'package nil)
                           ; return t says we had a modeline 
                           t))))  
                 (let ((len (list-length form)))
                   (cond ((null len)
                          (return-from top nil))
                         ((eql len 1)
                          (return-from top (foo (car form)))))
                   (when (and (eql len 3)
                              (integerp (caddr form))
                              (not (keywordp (cadr form))))
                     ;; lispm abortion
                     (setq form (cons (car form) (cddr form))
                           len (1- len)))
                   (cond ((eql len 2)
                          (return-from top (foo (car form) :use (cadr form))))
                         ((evenp len)
                          (return-from top nil))
                         (t
                          (return-from top (apply #'foo form))))))))))))
    nil))

(defun buffer-modeline-range (buffer)
  (let* ((pos (buffer-forward-find-not-char buffer wsp&cr 0 t))
         (end (and pos (buffer-forward-find-eol buffer pos))))
    (when (and end
               (setq pos (buffer-forward-search buffer "-*-" (%i- pos 1) (decf end))))
      (let ((end2 (buffer-backward-search buffer "-*-" end pos)))
        (when end2 (setq end end2)))
      (values pos end))))

(defun buffer-modeline-attribute-range (buffer attribute &optional start end)
  (unless (and start end)
    (multiple-value-setq (start end) (buffer-modeline-range buffer)))
  (setq attribute (string attribute))
  (when start
    (let ((pos start)
          colon
          next
          (len (length attribute)))
      (loop
        (unless (setq colon (buffer-forward-search buffer #\: pos end))
          (return nil))
        (setq next (1- (or (buffer-forward-search buffer #\; colon end) (1+ end))))
        (setq pos (or (buffer-backward-find-char buffer wsp colon pos) (1- pos)))
        (incf pos)
        (when (and (eq len (- colon pos 1))
                   (buffer-substring-p buffer attribute pos))
          (setq colon (1- (or (buffer-forward-find-not-char buffer wsp colon next) (1+ colon))))
          (return (values colon 
                          (1+ (or (buffer-backward-find-not-char buffer wsp next colon)
                                  (1- next))))))
        (setq pos (1+ next))
        (when (>= pos end) (return nil))))))

(defun buffer-first-in-package (buffer &optional no-create  &aux package-name)
  (handler-case
    (let* (start end sym e temp)
      (flet ((find-form (buffer pos)
               (let (start end)
                 (and (setq start (buffer-skip-fwd-wsp&comments
                                   buffer pos (buffer-size buffer)))
                      (setq end (buffer-fwd-sexp buffer start))
                      (< start end)
                      (eql (buffer-char buffer start) #\()
                      (progn
                        (incf start)
                        (values (buffer-current-symbol buffer start) start end))))))
        (multiple-value-setq (sym start end) (find-form buffer 0))
        (when (eq sym 'defpackage)
          (multiple-value-setq (sym start end) (find-form buffer end)))
        (when (eq sym 'in-package)
          (setq start (buffer-fwd-sexp buffer start)
                e (and start (buffer-fwd-sexp buffer start)))
          (when e
            (setq temp (buffer-skip-fwd-wsp&comments buffer e end))
            (when (and temp (eq (1+ temp) end))
              (setq package-name (let ((*package* *ccl-package*))
                                   (buffer-read buffer start e))))))))    
    (error (c)
           (warn "Error while searching for in-package: ~A~%Window will be opened without a window-package." c)
           nil))
  (when package-name
    (if (and (listp package-name) (eq (car package-name) 'quote))
      (setq package-name (cadr package-name)))
    (let ((pkg (find-package package-name)))
      (or pkg
          (if no-create 
            package-name
            (progn
              (cerror "Forms will be read in the package bound to *package*" "Package ~A does not exist" package-name)
              (buffer-putprop buffer 'package nil)))))))

; Redefined in fred-additions.
(%fhave 'buffer-current-symbol
        (qlfun buffer-current-symbol (&rest rest)
          (declare (ignore rest))
          nil))

(defun ed-beep (&rest args)
  (declare (ignore args))
  (#_SysBeep 3))

(defun buffer-word-bounds (buf &optional pos)
  (when (not pos)(setq pos (buffer-position buf)))
  (let* (;(bline (buffer-line-start buf pos)) ; what if its word-wrapped
         ;(eline (buffer-line-end buf pos))
         )
    (if nil ;(buffer-roman buf bline eline)
      (let ((end (buffer-forward-find-not-char buf *fred-word-constituents* pos))
            (start (buffer-backward-find-not-char buf *fred-word-constituents* pos)))
        (values (if start (%i+ start 1) 0) (if end (%i- end 1) (buffer-size buf))))
      ; aargh this will be stupidly slow
      (let* ((end (buffer-forward-break-char buf pos ))
             (start (buffer-backward-break-char buf pos )))
        (values (if start (1+ start) 0) (if end (1- end) (buffer-size buf)))))))

#|
(defun buffer-non-roman (buf &optional (start 0) (end (buffer-size buf)))
  (multiple-value-bind (script next-pos)(buffer-next-script-change buf start end)
    (or next-pos (neq script #$smRoman))))
|#

; are we roman script between start and end
; unused by us
#+ignore
(defun buffer-roman (buf &optional (start 0) (end (buffer-size buf)))
  (multiple-value-bind (script next-pos)(buffer-next-script-change buf start end)
    (and (not next-pos) (eq script #$smRoman))))

; returns one beyond the break char - for consistency with buffer-forward-mumble - yech
(DEFUN buffer-forward-break-char (buf start &optional (end (buffer-size buf)))
  (block nil
    (while (< start end)
      (when (new-char-word-break-p (buffer-char buf start))
        (return (1+ start)))
      (setq start (1+ start)))))

; dont look at char at start
(defun buffer-backward-break-char (buf start &optional (end 0)) ; end < start  
  (setq start (1- start))
  (block nil
    (while (>= start end)
      (when (new-char-word-break-p (buffer-char buf start) )
        (return start))
      (setq start (1- start)))))

(defun buffer-backward-not-break-char (buf start &optional (end 0)) ; end < start  
  (setq start (1- start))
  (block nil
    (while (>= start end)
      (when (not (new-char-word-break-p (buffer-char buf start)))
        (return start))
      (setq start (1- start)))))

(defun buffer-forward-not-break-char (buf start &optional (end (buffer-size buf)))  
  (block nil
    (while (<= start end)
      (when (not (new-char-word-break-p (buffer-char buf start)))
        (return (1+ start)))
      (setq start (1+ start)))))
            
        
        

(defun buffer-double-click-bounds (buf &optional pos)
  (unless pos (setq pos (buffer-position buf)))
  (let ((atom-word-mode (or (control-key-p) (command-key-p)))
        end start)
    (unless atom-word-mode
      (multiple-value-setq (start end) (buffer-word-bounds buf pos)))
    (if (or atom-word-mode (and (eq start pos) (eq end pos)))
      (buffer-current-sexp-bounds buf pos)
      (values start end))))

(defun buffer-lquoted-p (buf pos)
  (%buffer-lquoted-p (mark-buffer buf) pos))

(defun %buffer-lquoted-p (the-buf pos &aux qp)
  (while (and (neq pos 0)
              (eq #\\ (%buffer-char the-buf (setq pos (%i- pos 1)))))
    (setq qp (not qp)))
  qp)

;Move up, backwards from POS, COUNT open parens. COUNT must be positive.
; this gets confused by an unpaired " in a semi comment like this
; attempt to fix that will probably be confused by newline in a ""


(defun buffer-fwd-skip-delimited (buf str pos end)
  (while (and (setq pos (buffer-forward-find-char buf str pos end))
              (eq (buffer-char buf (%i- pos 1)) #\\))
     (unless (eq pos end) (setq pos (%i+ pos 1))))
  pos)

;Assumes first char is symbol constituent or escape.
(defun buffer-fwd-symbol (buf pos end &aux ch)
  (tagbody loop
    (setq pos (buffer-forward-find-char buf symbol-specials pos end))
    (cond ((null pos) (setq pos end))
          ((eq (setq ch (buffer-char buf (%i- pos 1))) #\\)
           (when (neq pos end) (setq pos (%i+ pos 1)) (go loop))
           (setq pos nil))
          ((eq ch #\|)
           (when (setq pos (buffer-fwd-skip-delimited buf "\\|" pos end)) (go loop)))
          (t (setq pos (%i- pos 1)))))
  pos)

#|
(defun buffer-skip-fwd-#comment (buf pos end &aux (count 1))
  ;Find end of #||# comment assuming we're starting inside it.
  (while (and (setq pos (buffer-forward-find-char buf "#\|" pos end))
              (neq pos end))
    (if (eq #\# (buffer-char buf (%i- pos 1)))
      (when (eq #\| (buffer-char buf pos))
        (setq pos (%i+ pos 1) count (%i+ count 1)))
      (when (eq #\# (buffer-char buf pos))
        (setq pos (%i+ pos 1) count (%i- count 1))
        (when (%izerop count) (return-from buffer-skip-fwd-#comment pos))))))
|#

(defun buffer-skip-fwd-#comment (buf pos end &aux (count 1))
  ;Find end of #||# comment assuming we're starting inside it.
  (while (setq pos (buffer-forward-find-char buf "#\|" pos end))
    (let ((c2 (buffer-char buf pos)))
      (if (eq (buffer-char buf (%i- pos 1)) #\#)
        (when (eq #\| c2)
          (setq pos (%i+ pos 1) count (%i+ count 1)))
        (when (eq c2 #\#) 
          (setq pos (%i+ pos 1) count (%i- count 1))
          (when (%izerop count) (return-from buffer-skip-fwd-#comment pos)))))))
#|
(defun buffer-skip-bwd-#comment (buf pos &optional (end 0) &aux (count 1))
  ;Find start of #||# comment assuming we're starting inside it.
  (while (and (setq pos (buffer-forward-find-char buf "#\|" pos end))
              (neq pos end))
    (if (eq #\# (buffer-char buf pos))
      (when (eq #\| (buffer-char buf (%i- pos 1)))
        (setq pos (%i- pos 1) count (%i+ count 1)))
      (when (eq #\# (buffer-char buf (%i- pos 1)))
        (setq pos (%i- pos 1) count (%i- count 1))
        (when (eq count 0) (return-from buffer-skip-bwd-#comment pos))))))
|#

; N.B. this starts at end, quits at pos
(defun buffer-skip-bwd-#comment (buf pos end &aux (count 1))
  ;Find start of #||# comment assuming we're starting inside it.  
  (while (and (setq end (buffer-backward-find-char buf "#\|" pos end))
              (< pos end))
    (let ((c0 (buffer-char buf (%i- end 1))))
      (if (eq #\# (buffer-char buf end))
        (when (eq #\| c0)
          (setq count (%i+ count 1) end  (%i- end 1)))
        (when (eq #\# c0)
          (setq end (%i- end 1) count (%i- count 1))
          (when (eq count 0)
                (return-from buffer-skip-bwd-#comment end)))))))


    



;redefined in tools:fred-additions-1 to skip over ;-comments.
(defun buffer-bwd-sexp (buf &optional pos over-sharps &aux ch)
  (declare (ignore over-sharps))
  (when (null pos)(setq pos (buffer-position buf)))
  (unless (setq pos (buffer-backward-find-not-char buf wsp&cr pos))
      (return-from buffer-bwd-sexp 0))
  (setq ch (buffer-char buf pos))
  (if (buffer-lquoted-p buf pos) (setq ch #\A))
  (cond ((eq ch #\)) (buffer-bwd-up-sexp buf pos))
        ((or (eq ch #\") (eq ch #\|)) (buffer-backward-search-unquoted buf ch pos))
        ((and (eq ch #\#)
              (not (%izerop pos))
              (eq (buffer-char buf (%i- pos 1)) #\|)
              (not (buffer-lquoted-p buf (%i- pos 1))))
         (buffer-skip-bwd-#comment buf (%i- pos 1)))
        ((setq pos (buffer-backward-search-unquoted buf atom-specials pos)) (%i+ pos 1))
        (t 0)))

(defun buffer-skip-fwd-wsp&comments (buf start end)
  (when (and start end (< start end))
    (while (and (setq start (buffer-forward-find-not-char buf wsp&cr start end))
                (setq start (%i- start 1))
                (let ((char (buffer-char buf start)))
                  (or (and (eq char #\#)
                           (%i< (%i+ start 1) end)
                           (eq (buffer-char buf (%i+ start 1)) #\|)
                           (setq start
                                 (buffer-skip-fwd-#comment buf (%i+ start 2) end))
                           (neq start end)
                           (setq char (buffer-char buf start)))
                      (when (eq char #\;)
                        (setq start (buffer-forward-find-eol buf 
                                                              start 
                                                              end)))))))
    start))

#|
(comtab-set-key *comtab*
                '(:control #\i)
                #'(lambda (&aux (edw (objvar edwin)))
                    (set-mark edw
                    (buffer-skip-fwd-wsp&comments edw
                                              (buffer-position edw)
                                              (buffer-size edw)))))
|#

;Skip forward over whitespace, comments, and prefix chars.
(defun real-sexp-start (buf pos end)
  (while (and (setq pos (buffer-forward-find-not-char buf prefix&wsp&cr pos end))
              (eq (buffer-char buf (%i- pos 1)) #\;)
              (setq pos (buffer-forward-find-eol buf pos end))))
  (and pos (%i- pos 1)))

;Back up over prefix chars
(defun backward-prefix-chars (buf pos)
  (if (setq pos (buffer-backward-find-not-char buf "`',@" pos))
    (%i+ pos 1) 0))

(defun buffer-fwd-sexp (buf &optional pos end ch ignore-#-comments)
  (when (null pos)(setq pos (buffer-position buf)))
  (when (null end) (setq end (buffer-size buf)))
  (when (and (null ch) (< pos end)) (setq ch (buffer-char buf pos)))
  (let ((agn nil))
    (prog ()
      top
     (return
      (cond ((>= pos end) nil)
            ((eq ch #\() (buffer-fwd-up-sexp buf (%i+ pos 1) end))
            ((eq ch #\)) (%i+ pos 1))
            ((eq ch #\#)
             (setq pos (buffer-forward-find-not-char buf "0123456789" (%i+ pos 1) end))
             (cond ((null pos) end)
                   ((eq (setq ch (buffer-char buf (%i- pos 1))) #\#) pos)
                   ((%str-member ch wsp&cr) (%i- pos 1))
                   ((eq ch #\|)
                    (when (setq pos (buffer-skip-fwd-#comment buf pos end))
                      (if ignore-#-comments
                        (progn (setq agn nil) (go top))
                        pos)))
                   (t (when (%str-member ch "\\(\"") (setq pos (%i- pos 1)))
                      (buffer-fwd-sexp buf pos end))))
            ((eq ch #\") (buffer-fwd-skip-delimited buf "\"\\" (%i+ pos 1) end))
            ((not agn)
             (let ((newpos pos))
                 (while (and (setq newpos (buffer-forward-find-not-char buf prefix&wsp&cr newpos end))
                         (eq (buffer-char buf (%i- newpos 1)) #\;)
                         (setq newpos (buffer-forward-find-eol buf  newpos end))))
                 (when newpos
                   (setq newpos (%i- newpos 1))
                   (if  (eq newpos pos)
                     (buffer-fwd-symbol buf pos end)
                     (progn (setq pos newpos)
                            (setq ch (buffer-char buf newpos))
                            (setq agn t)
                            (go top))))))
            (t (buffer-fwd-symbol buf pos end)))))))

(defun buffer-fwd-skip-wsp (buf &optional pos)
  (if (setq pos (buffer-forward-find-not-char buf wsp pos))
    (%i- pos 1)
    (buffer-size buf)))

;This should be hand-coded to speed up Tab, and also so it doesn't cons...
(defun buffer-scan-lists (buf pos end)
  (unless (<= pos end) (error "~S > ~S" pos end))
  (prog ((last-start nil) (last-end nil) (open-stack ()) start p char)
   next
    (setq start pos)
    (setq pos (buffer-forward-find-char buf "();\"\\|" start end))
    (when (null pos)
      (return (values (%car open-stack) last-start last-end)))
    (setq char (buffer-char buf (%i- pos 1)))
    (when (eq char #\()
      (setq open-stack (push (%i- pos 1) open-stack))
      (setq last-start nil last-end nil)
      (go next))
    (when (eq char #\))
      (when (null open-stack) (return (values nil nil pos)))
      (setq last-start (pop open-stack))
      (setq last-end pos)
      (go next))
    (when (eq char #\")
      (unless (setq p (buffer-fwd-skip-delimited buf "\"\\" pos end))
        (return (values (%car open-stack) (%i- pos 1) nil)))
      (setq last-start (%i- pos 1) last-end (setq pos p))
      (go next))
    (when (eq char #\|)
      (if (and (%i<= start (%i- pos 2))
               (eq (buffer-char buf (%i- pos 2)) #\#))
        (unless (setq p (buffer-skip-fwd-#comment buf pos end))
          (return (values (car open-stack) (%i- pos 2) nil)))
        (unless (setq p (buffer-fwd-skip-delimited buf "|\\" pos end))
          (return (values (car open-stack) (%i- pos 1) nil))))
      (setq pos p)
      (go next))
    (when (eq char #\\)
      (when (eq pos end) (return (values (%car open-stack) (%i- pos 1) nil)))
      (setq pos (%i+ pos 1))
      (go next))
    (unless (setq p (buffer-forward-find-eol buf  pos end))
      (return (values (%car open-stack) (%i- pos 1) nil)))
    (setq pos p)
    (go next)))

((lambda (alist)
   (dolist (cell alist)
     (setf (assq (car cell) *fred-special-indent-alist*) (cdr cell))))
  '((add-subviews . 1)
    (block . 1)
    (case . 1)
    (catch . 1)
    (compiler-let . 1)
    (ctypecase . 1)
    (define-condition . 2)
    (define-method-combination . 3)
    (defun . 2)
    (defmacro . 2)
    (defmethod . defmethod-special-indent)
    (defpascal . 2)
    (defsetf . 3)
    (do . 2)
    (do* . 2)
    (dolist . 1)
    (dotimes . 1)
    (dovector . 1)
    (do-dialog-items . 1)
    (do-symbols . 1)
    (do-external-symbols . 1)
    (do-all-symbols . 1)
    (do-windows . 1)
    (do-all-windows . 1)
    (do-subviews . 1)
    (do-wptrs . 1)
    (ecase . 1)
    (etypecase . 1)
    (eval-when . 1)
    (flet . 1)
    (fbind . 1)
    (generic-flet . 1)
    (generic-function . 1)
    (generic-labels . 1)
    (if . 1)
    (labels . 1)
    (lambda . 1)
    (lap-inline . 1)
    (lap . 0)
    (let . 1)
    (let* . 1)
    (locally . 1)                       ; not quite right, but better than nothing.
    (loop . 0)
    (make-instance . 1)
    (macrolet . 1)
    (multiple-value-bind . 2)
    (multiple-value-prog1 . 1)
    (multiple-value-setq . 1)
    (prog1 . 1)
    (prog . 1)
    (prog* . 1)
    (progn . 0)
    (progv . 2)
    (return-from . 1)
    (tagbody . 0)
    (the . 1)
    (typecase . 1)
    (unless . 1)
    (unwind-protect . 1)
    (when . 1)
    (until . 1)
    (while . 1)
    (if# . 1)
    (old-lap-inline . 1)
    (qlfun . 2)
    (%stack-block . 1)
    (%vstack-block . 1)
    (%stack-iopb . 1)
    (rlet . 1)
    (restart-case . 1)
    (restart-bind . 1)
    (handler-case . 1)
    (handler-bind . 1)
    (debind . 2)
    (destructuring-bind . 2)
    (symbol-macrolet . 1)
    (old-lap-inline . 1)
    (print-unreadable-object . 1)
    ))

(defvar *fred-body-indent* 2)

(defun buffer-special-indent-p (buf pos &aux str end len)
  (when (setq end (buffer-fwd-sexp buf pos))
    (setq pos (buffer-skip-package-prefix buf pos end))
    (setq len (%i- end pos))
    (dolist (a *fred-special-indent-alist*)
      (setq str (string (car a)))
      (when (and (eq len (length str))
                 (buffer-substring-p buf str pos))
        (let ((count (%cdr a)))
          (if (or (and (symbolp count) (fboundp count)) (functionp count))
            (setq count (funcall count buf pos)))
          (return-from buffer-special-indent-p (values count end)))))    
    (when (or (buffer-substring-p buf "def" pos)
              (buffer-substring-p buf "with-" pos))
      (return-from buffer-special-indent-p (values 'defun end)))))

(defun defmethod-special-indent (buf pos)
  (let ((size (buffer-size buf)))
    (if (and
         (setq pos (buffer-fwd-sexp buf pos))   ; over "DEFMETHOD"
         (setq pos (buffer-fwd-sexp buf pos nil nil t)))  ; over function-name
      (let ((res 2))
        (while (and (setq pos (buffer-skip-fwd-wsp&comments buf pos size))
                    (< pos size)
                    (not (eql #\( (buffer-char buf pos)))
                    (setq pos (buffer-fwd-sexp buf pos)))
          (incf res))
        res)
      2)))

(defun Buffer-Skip-Package-Prefix (buf &optional 
                                       (pos (buffer-position buf))
                                       (end (buffer-size buf)))
  (let ((idx pos)
        (chars *fred-word-constituents*)
        char)
    (while (< idx end)
      (setq char (buffer-char buf idx))
      (when (eq char #\:)
        (return-from buffer-skip-package-prefix
          (if (eq (buffer-char buf (incf idx)) #\:) (1+ idx) idx)))
      (unless (or (eq char #\-)(%str-member char chars))
        (return-from buffer-skip-package-prefix pos))
      (incf idx))
    pos))

(defun lisp-indentation (buf start end)
  (or (flet-indentation buf start end)
      (prog* ((limit end)
              (scan-count 0)
              count inner scan-pos prev-end last-end last-start next line-start)
        top 
        (setq count scan-count)
        (multiple-value-bind (outer xstart xend) (buffer-scan-lists buf start limit)
          (when (and xstart (null xend))  ;Inside string or comment
            (return (and (eq (buffer-char buf xstart) #\")
                         (eq (buffer-char buf (%i- end 2)) #\~)
                         (%i+ xstart 1))))
          (when (and xend (null xstart))  ;Unmatched close
            (setq start xend)
            (go top))
          (when (null outer) (return 0))
          (setq inner (%i+ outer 1))
          (if xstart (setq scan-pos xstart last-end xend scan-count (%i+ scan-count 1))
              (setq scan-pos inner last-end inner))
          (setq prev-end nil)
          (while (and (setq next (buffer-fwd-sexp buf last-end limit nil t))
                      (not (= (the fixnum last-end)(the fixnum next))))
            (setq prev-end last-end last-end next scan-count (%i+ scan-count 1)))                  
          (when (eq last-end inner) (return inner))
          (setq last-start (if prev-end (real-sexp-start buf prev-end last-end)
                               scan-pos))
          (setq line-start (buffer-line-start buf last-start))
          (when (%i<= line-start outer) ;All on one line
            (multiple-value-bind (spec pos) (buffer-special-indent-p buf inner)
              (when (eq spec 'defun) (return (%i+ outer *fred-body-indent*)))
              (when (and (fixnump spec) (%i>= spec 0))
                (if (%i<= pos scan-pos)
                  (while (and (%i<= scan-count spec)
                              (setq pos (buffer-fwd-sexp buf pos scan-pos nil t)))
                    (setq scan-count (%i+ scan-count 1)))
                  (setq scan-count (%i- scan-count 1)))
                (when (eq scan-count spec) (return (%i+ outer *fred-body-indent*)))
                (when (%izerop scan-count)
                  (return (%i+ outer *fred-body-indent*)))))
            (let ((pos (real-sexp-start buf inner end)))
              (return
               (backward-prefix-chars buf
                                      (if (or (%str-member (buffer-char buf pos) "()\"0123456789#")
                                              (and (not (%izerop outer))
                                                   (eq (buffer-char buf (%i- outer 1)) #\'))
                                              (null (setq next
                                                          (real-sexp-start
                                                           buf
                                                           (buffer-fwd-sexp buf pos end nil t) end))))
                                        pos next)))))
          (multiple-value-bind (l-outer l-start l-end)
                               (buffer-scan-lists buf line-start last-start)
            (when (or (and l-start (null l-end))
                      (and l-end (null l-start))
                      l-outer)
              (setq limit last-start scan-count (%i+ count 1))
              (go top)))
          (multiple-value-bind (spec pos) (buffer-special-indent-p buf inner)
            (when (and (fixnump spec) (%i>= spec 0))
              (if (%i<= pos scan-pos)
                (while (and (%i<= scan-count spec)
                            (setq pos (buffer-fwd-sexp buf pos scan-pos nil t)))
                  (setq scan-count (%i+ scan-count 1)))
                (setq scan-count (%i- scan-count 1)))
              (when (eq scan-count spec) (return (%i+ outer *fred-body-indent*)))))
          (return (backward-prefix-chars buf (real-sexp-start buf line-start end)))))))

(defparameter *flet-like-symbols* '(flet labels generic-flet generic-labels macrolet))

; Return the column to which to indent the line at END searching back
; to START for an FLET-like form.
; Return NIL if no FLET-like form is found.
(defun flet-indentation (buf start end)
  (let ((binding-pos (find-enclosing-flet buf start end)))
    (when binding-pos
      (incf binding-pos)
      (let* ((size (buffer-size buf))
             (fun-pos (or (buffer-skip-fwd-wsp&comments buf binding-pos size) size))
             (line-start (buffer-line-start buf fun-pos))
             (line-end (1- (buffer-line-start buf line-start 1)))
             (arglist (or (buffer-skip-fwd-wsp&comments buf (buffer-fwd-sexp buf fun-pos nil nil t) size) 
                          size))
             (arglist-line (buffer-line-start buf arglist))
             (first-form (or (buffer-skip-fwd-wsp&comments buf (buffer-fwd-sexp buf arglist nil nil t) size)
                             size))
             (first-form-line (buffer-line-start buf first-form))
             (end-line (buffer-line-start buf end)))
        (declare (fixnum line-start arglist arglist-line first-form first-form-line end-line))
        (unless (<= end fun-pos)
          (cond ((<= end-line arglist-line)
                 (min (+ fun-pos 3) line-end))
                ((<= end-line first-form-line)
                 (min (+ fun-pos 1) line-end))
                (t first-form)))))))

(defun find-enclosing-flet (buf start end)
  ; Search back to start of this binding
  (let ((first-up (buffer-bwd-up-sexp buf end 1 start))
        pos)
    (when (or (null first-up) (<= first-up start))
      (return-from find-enclosing-flet nil))
    (setq pos (buffer-bwd-up-sexp buf first-up 1 start))
    (when (or (null pos) (<= pos start))
      (return-from find-enclosing-flet nil))
    (when (and (setq pos (buffer-bwd-sexp buf pos))
               (> pos start)
               (setq pos (buffer-skip-package-prefix buf pos))
               (< pos (buffer-size buf))
               (not (eql #\( (buffer-char buf pos)))
               (let ((end (buffer-fwd-sexp buf pos nil nil t)))
                 (and end
                      (member (buffer-substring buf end pos) *flet-like-symbols*
                              :test #'string-equal))))
      first-up)))

(defun buffer-backward-search-unquoted (buf ch pos &optional end)
  (when (null end)(setq end 0)) ;huh?
  (while (setq pos (buffer-backward-find-char buf ch pos end))
    (unless (buffer-lquoted-p buf pos)
      (return-from buffer-backward-search-unquoted pos))))

(defun buffer-forward-search-unquoted (buf ch pos &optional end)
  (when (null end)(setq end (buffer-size buf)))
  (while (setq pos (buffer-forward-find-char buf ch pos end))
    (unless (buffer-lquoted-p buf (%i- pos 1))
      (return-from buffer-forward-search-unquoted (%i- pos 1)))))

;returns nil nil if nothing to read, else form and end position.
(defun buffer-read (buffer &optional start end)
  (with-open-stream (stream (make-instance 'buffer-stream
                                           :buffer buffer :start start :end end))
    (let ((value (read-preserving-whitespace stream nil stream)))
      (if (eq value stream)
        (values nil nil)
        (values value (stream-position stream))))))

(defun get-mpsr-resource (&optional (rsrc (%null-ptr)))
  (%setf-macptr rsrc (#_Get1Resource "MPSR" 1005)) ;MPSR
  (if (%null-ptr-p rsrc)
    (progn
      (%setf-macptr rsrc (#_NewHandleClear :errchk 72))
      (with-dereferenced-handles ((rp rsrc))
        (%put-word rp 6 34)               ;tab width
        (%put-word rp 8 36)               ;tab count
        (%put-long rp #@(3 41) 38)
        (%put-long rp #@(506 298) 42)
        (%put-long rp #@(3 41) 46)
        (%put-long rp #@(506 298) 50)
        (%put-long rp 0 54)               ;date
        (%put-long rp 0 58)               ;sel start
        (%put-long rp 0 62)               ;sel end
        (%put-long rp 0 66)               ;window start
        (%put-word rp #x100 70))
      (with-pstr (no-name "")
        (#_AddResource rsrc "MPSR" 1005 no-name)))
    (#_LoadResource rsrc))
  rsrc)

(defun concat-string-conses (cons-1 cons-2)
  (if (and (not (consp (car cons-1)))(not (consp (car cons-2))))
    (let ((style1 (cdr cons-1))
          (style2 (cdr cons-2))) ; don't assume fonts match
      (let ((newstyle (merge-styles style1 style2)))
        (if newstyle
          (cons (concatenate 'string (car cons-1) (car cons-2))
                newstyle)
          (list cons-1 cons-2))))    
      (if (consp (car cons-1))
        (progn 
          (rplacd (last cons-1)(list cons-2))
          cons-1)               
        (cons cons-1 cons-2))))


(defparameter *killed-strings* 
  (let ((r ()))
    (dotimes (x 26)
      (declare (fixnum x))
      (push (cons "" nil) r))
    (rplacd (nthcdr 25 r) r)))

(defun add-to-killed-strings (string-style-cons &aux (ring *killed-strings*))
  (do ((last ring (cdr last)))
      ((eq (cdr last) ring)
       (setq *killed-strings* (rplaca last string-style-cons)))))

(defun clear-killed-strings (&aux (ring *killed-strings*))
  (let ((last ring))
    (loop
      (setf (car last) (cons "" nil))
      (if (eq (setq last (cdr last)) ring) (return)))))

#|
(defun rotate-killed-strings (&optional (count 0))
  (setq *killed-strings* (cdr *killed-strings*))
  (when (and (equal (car *killed-strings*) '(""))
             (< count 26))
    (rotate-killed-strings (+ count 1))))
|#
(defun rotate-killed-strings (&optional (count 0) &aux (ring *killed-strings*)
						       (len 1))
  (do ((last (cdr ring) (cdr last))) ((eq last ring)) (setq len (1+ len)))
  (loop
    (setq ring (cdr ring))
    (unless (and (equal (car ring) '("")) (<= (setq count (1+ count)) len))
       (setq *killed-strings* ring)
       (return nil))))

;;;Scrap Stuff

(defparameter *scrap-state* nil "A list of scrap-types")
(defparameter *external-scrap* nil "A list of external scrap-types")
(defvar *scrap-groups* '((:text :fred :lisp)))
(defvar *scrap-handler-alist* nil)


(defun add-scrap-handler (type handler)
  (let ((cell (assq type *scrap-handler-alist*)))
    (if cell
      (setf (cdr cell) handler)
      (push (cons type handler) *scrap-handler-alist*)))
  handler)

(defclass scrap-handler ()
  ((internal-scrap :initform nil :initarg :internal-scrap)))

(defmethod get-internal-scrap ((handler scrap-handler))
  (let ((the-scrap (slot-value handler 'internal-scrap)))
    ; lets try not to die when quitting if bogus thing in scrap - method dispatch hates it. 5/28
    (when (not (bogus-thing-p the-scrap)) 
      (convert-and-store-scrap the-scrap handler))))

(defvar *inside-set-internal-scrap* nil)

(defmethod set-internal-scrap ((handler scrap-handler) value)
  (setf (slot-value handler 'internal-scrap) value)
  (when value
    (let* ((scrap-type (scrap-type handler)))
      (when scrap-type
        (pushnew scrap-type *scrap-state*)
        (unless *inside-set-internal-scrap*
          (let ((*inside-set-internal-scrap* t)
                (group (dolist (g *scrap-groups*)
                         (when (memq scrap-type g)
                           (return g)))))
            (when group
              (dolist (type group)
                (unless (eq type scrap-type)
                  (let ((h (cdr (assq type *scrap-handler-alist*))))
                    (when (and h) ;(not (slot-value h 'internal-scrap))) ;; from Terje N.
                      (pushnew type *scrap-state*)                    
                      (set-internal-scrap h handler)))))))))))
  value)

(defmethod externalize-scrap ((handler scrap-handler)))

(defmethod internalize-scrap ((handler scrap-handler)))

(defmethod scrap-type ((handler scrap-handler)))

(defmethod convert-and-store-scrap (from to)
  (declare (ignore to))
  from)

(defmethod convert-and-store-scrap ((from scrap-handler) (to scrap-handler))
  (setf (slot-value to 'internal-scrap) (convert-scrap from to)))

(defclass text-scrap-handler (scrap-handler) ())
(defparameter *text-scrap-handler* (make-instance 'text-scrap-handler))
(add-scrap-handler :text *text-scrap-handler*)

(defmethod scrap-type ((handler text-scrap-handler)) :text)

; For debugging
#|
(defmethod internalize-scrap :around (handler)
  (declare (ignore handler))
  (beep 2))

(defmethod get-internal-scrap :around (handler)
  (declare (ignore handler))
  (beep))
|#

#-carbon-compat
(defmethod externalize-scrap ((handler text-scrap-handler))
  (let* ((string (get-internal-scrap handler)))
    (when string
      (with-macptrs ((h #-carbon-compat (#_LMGetTEScrpHandle) #+carbon-compat (#_TEGetScrapHandle)))
        (%str-to-handle string h nil)
        (with-pointers ((p h))
          ;;This is a little weird because _PutScrap can trigger a gc
          (#_PutScrap (#_GetHandleSize h) :text  p))
        (#_SetHandleSize :errchk h 0)))))


#-carbon-compat
(defmethod internalize-scrap ((handler text-scrap-handler))
  (with-macptrs ((h #-carbon-compat (#_LMGetTEScrpHandle) #+carbon-compat (#_TEGetScrapHandle)))
    (%stack-block ((poffset 4))
      (let ((size (%imax 0 (#_GetScrap h :text poffset))))
        (with-pointers ((p h))
          (set-internal-scrap handler (%str-from-ptr-in-script p size)))
        (#_SetHandleSize :errchk h 0)))))



;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Support for the :|styl| scrap
;;;

; Set this to NIL to make Fred ignore styles when importing from or exporting to the
; external scrap.
(defvar *use-external-style-scrap* nil)
#+ignore ;; doesn't work today - move it elsewhere - to ccl-menus - actually the problem was elsewhere
(queue-fixup
 (setq *use-external-style-scrap* t))



; The scrap format type of a style record is :|styl|.
; It has the same byte format as a TextEdit 'styl' record.
; I.e., it is a record of type :StScrpRec
;
; the Fred style vector is a vector with an element-type of '(unsigned-byte 16)
; 2 bytes - # of fonts
; each font 2 bytes font code, 1 byte size, 1 byte face 
; 2 short words for each run? 1 byte font index, 3 bytes offset
; no long's to avoid bignums???

(defun scrap-style-handle->fred-style-vector (scrap-style-handle string)
  (with-dereferenced-handles ((scrap-style-record scrap-style-handle))
    (let ((count (pref scrap-style-record :StScrpRec.scrpNStyles))
          (font-specs (make-array 10 :adjustable t :fill-pointer 0))       ; #((font . size/face) ...)
          (colors (make-array 10 :adjustable t :fill-pointer 0))
          (got-a-color nil)
          (string-length (length string))
          (font-indices.start-positions nil))
      (with-macptrs ((scrap-style-element (pref scrap-style-record
                                                :StScrpRec.scrpStyleTab)))
        (dotimes (i count)
          (let ((font (pref scrap-style-element :ScrpSTElement.scrpFont))
                (start-position (pref scrap-style-element :ScrpStElement.scrpStartChar))
                (face (pref scrap-style-element :ScrpSTElement.scrpFace))
                (size (pref scrap-style-element :ScrpSTElement.scrpSize)))
            ;(if (minusp font)(setq font (font-out font)))
            (with-macptrs ((rgb (pref scrap-style-element :ScrpStElement.scrpColor)))
              (let* ((color (rgb-to-color rgb))
                     (color-index (color->ff-index color)))
                (unless (eql color-index 0)
                  (setq got-a-color t))   ; need color info
                ; Look for an existing font/color
                (let ((font-index (dotimes (i (length font-specs))
                                    (let ((a-font.a-size (aref font-specs i))
                                          (a-color-index (aref colors i)))
                                      (when (and (eql font (car a-font.a-size))
                                                 (let ((size/face (cdr a-font.a-size)))
                                                   (and (eql size (ash size/face -8))
                                                        (eql face (logand size/face #xff))))
                                                 (eql color-index a-color-index))
                                        (return i))))))
                  (if font-index
                    (incf font-index)
                    (progn
                      (vector-push-extend (cons font (+ (ash size 8) face)) font-specs)
                      (vector-push-extend color-index colors)
                      (setq font-index (length font-specs))))
                  ; get rid of 0 length font runs, still may leave font changes that are not really changes
                  (if (and font-indices.start-positions
                           (eql start-position (cdar font-indices.start-positions)))
                    (setf (caar font-indices.start-positions) font-index)
                    (push (cons font-index start-position) font-indices.start-positions))))))
          (%incf-ptr scrap-style-element (record-length :ScrpSTElement)))
        (let* ((style-count (length font-specs))
               (style-vector-size (+ 1 (* 2 style-count)
                                     (* 2 (length font-indices.start-positions))
                                     2))
               (style-vector (make-array style-vector-size :element-type '(unsigned-byte 16)))
               (index 0))
          (setf (aref style-vector 0) style-count)
          (dotimes (i style-count)
            (let* ((font.size/face (aref font-specs i))
                   (font (car font.size/face))
                   (size/face (cdr font.size/face)))
              ;(push (list 'from font) poo)
              (setf (aref style-vector (incf index)) (font-out font)
                    (aref style-vector (incf index)) size/face)))
          (setq font-indices.start-positions (nreverse font-indices.start-positions))
          (dolist (font-index.start-position font-indices.start-positions)
            (let ((font-index (car font-index.start-position))
                  (start-position (cdr font-index.start-position)))
              (if (extended-string-p string)(setq start-position (byte-pos->char-pos start-position string)))
              (setf (aref style-vector (incf index)) (+ (ash font-index 8) (ash start-position -16))
                    (aref style-vector (incf index)) (logand start-position #xffff))))
          (setf (aref style-vector (incf index)) (ash string-length -16)
                (aref style-vector (incf index)) (logand string-length #xffff))
          (if got-a-color
            (let* ((color-count (length colors))
                   (color-vector (make-array (1+ color-count) :element-type '(signed-byte 16))))
              (setf (aref color-vector 0) color-count)
              (dotimes (i color-count)
                (setf (aref color-vector (1+ i)) (aref colors i)))
              (cons style-vector color-vector))
            style-vector))))))

(defun fred-style-vector->scrap-style-handle (style-vector scrap-style-handle &optional string)
  (let (real-style-vector colors)
    (if (listp style-vector)
      (setq real-style-vector (car style-vector)
            colors (cdr style-vector))
      (setq real-style-vector style-vector))
    (setq real-style-vector (require-type real-style-vector '(simple-array (unsigned-byte 16))))
    (when colors
      (setq colors (require-type colors '(simple-array (signed-byte 16)))))
    (let* ((style-count (aref real-style-vector 0))
           (run-index (* 2 style-count))
           (run-words (- (length real-style-vector) (1+ run-index)))
           (run-count (1- (require-type (/ run-words 2) 'fixnum)))
           (handle-size (+ (get-field-offset :StScrpRec.scrpStyleTab)
                           (* run-count (record-length ScrpSTElement)))))
      (#_SetHandleSize scrap-style-handle handle-size)  ;; :errchk causes error
      (with-dereferenced-handles ((p scrap-style-handle))
        (setf (pref p :StScrpRec.scrpNStyles) run-count)
        (%incf-ptr p (get-field-offset :StScrpRec.scrpStyleTab))
        (dotimes (i run-count)
          (let* ((word0 (aref real-style-vector (incf run-index)))
                 (word1 (aref real-style-vector (incf run-index)))
                 (font-index (1- (ash word0 -8)))
                 (start-position (+ (ash (logand word0 #xff) 16) word1))
                 (color-index (if colors (aref colors (1+ font-index)) 0))
                 (font (aref real-style-vector (1+ (* 2 font-index))))
                 (size/face (aref real-style-vector (+ 2 (* 2 font-index))))
                 (size (ash size/face -8))
                 (face (logand size/face #xff)))
            (declare (fixnum word0 word1 font-index start-position color-index font mode/size mode size))
            (setq font (font-in font)) ;??
            ;(push (list 'to-style font) poo)
            (multiple-value-bind (a d w l)
                                 (font-codes-info
                                  (make-point (ash face 8) font)
                                  (make-point size 0))
              (declare (ignore w))
              (if (extended-string-p string)(setq start-position (char-pos->byte-pos start-position string)))
              (setf (pref p :ScrpStElement.scrpStartChar) start-position
                    (pref p :ScrpStElement.scrpHeight) (+ a d l)
                    (pref p :ScrpStElement.scrpAscent) a
                    (pref p :ScrpStElement.scrpFont) font
                    (pref p :ScrpStElement.scrpFace) face
                    (pref p :ScrpStElement.scrpSize) size)
              (with-macptrs ((rgb (pref p :ScrpStElement.scrpColor)))
                (fred-color-index->rgb color-index rgb))))
          (%incf-ptr p (record-length :ScrpStElement))))))
  scrap-style-handle)

(defun byte-pos->char-pos (byte-pos string)
  (LET ((bytes-so-far 0))
    (let ((res
           (dotimes (i (length string))
             (if (>= bytes-so-far byte-pos)(return i))
             (let ((charcode (%scharcode string i)))
               (cond ((> charcode #xff)(incf bytes-so-far 2))
                     (t (incf bytes-so-far 1)))))))
      (or res (length string)))))

(defun char-pos->byte-pos (char-pos string)
   (byte-length string nil 0 char-pos))  ;; script arg ignored today


(defun fred-color-index->rgb (color-index rgb)
  (if (or (eql 0 color-index) (null *fred-palette*))
    (setf (pref rgb :RGBcolor.red) 0
          (pref rgb :RGBcolor.green) 0
          (pref rgb :RGBcolor.blue) 0)
    (#_GetEntryColor *fred-palette* color-index rgb)))

#-carbon-compat
(defmethod externalize-scrap :after ((handler text-scrap-handler))
  (when *use-external-style-scrap*
    (let* ((fred-scrap-handler (cdr (assq :fred *scrap-handler-alist*)))
           (style-vector (and fred-scrap-handler (cdr (get-internal-scrap fred-scrap-handler)))))
      (when style-vector
        (with-macptrs ((h #-carbon-compat (#_LMGetTEScrpHandle) #+carbon-compat (#_TEGetScrapHandle)))
          (fred-style-vector->scrap-style-handle style-vector h)
          (with-pointers ((p h))
            ;;This is a little weird because _PutScrap can trigger a gc
            (#_PutScrap (#_GetHandleSize h) :|styl| p))
          (#_SetHandleSize :errchk h 0))))))

(defvar *external-style-scrap* nil)


#-carbon-compat
(defmethod internalize-scrap :after ((handler text-scrap-handler))
  (if *use-external-style-scrap*
    (with-macptrs ((h #-carbon-compat (#_LMGetTEScrpHandle) #+carbon-compat (#_TEGetScrapHandle)))
      (%stack-block ((poffset 4))
        (let ((size (%imax 0 (#_GetScrap h :|styl| poffset))))
          (declare (fixnum size))
          (setq *external-style-scrap*
                (and (> size 0)
                     (scrap-style-handle->fred-style-vector h (length (get-internal-scrap handler)))))          
          (#_SetHandleSize :errchk h 0))))
    (setq *external-style-scrap* nil)))

(defclass fred-scrap-handler (scrap-handler) ())
(defparameter *fred-scrap-handler* (make-instance 'fred-scrap-handler))
(add-scrap-handler :fred *fred-scrap-handler*)

(defmethod scrap-type ((handler fred-scrap-handler)) :fred)

(defmethod set-internal-scrap :after ((handler fred-scrap-handler) scrap)
  (when scrap
    (add-to-killed-strings
     (if (typep scrap 'scrap-handler)
       (make-instance (class-of scrap) :internal-scrap (get-internal-scrap scrap))
       scrap))))

(defun first-killed-string ()
  (let ((res (car *killed-strings*)))
    (if (listp res)
      res
      (setf (car *killed-strings*) (convert-scrap res *fred-scrap-handler*)))))

(defclass lisp-scrap-handler (scrap-handler) ())
(defparameter *lisp-scrap-handler* (make-instance 'lisp-scrap-handler))
(add-scrap-handler :lisp *lisp-scrap-handler*)

(defmethod scrap-type ((handler lisp-scrap-handler)) :lisp)

(defmethod convert-scrap ((from text-scrap-handler) (to fred-scrap-handler))
  (cons (get-internal-scrap from) (if *use-external-style-scrap* *external-style-scrap*)))

(defmethod convert-scrap ((from text-scrap-handler) (to lisp-scrap-handler))
  (scrap-string-to-lisp-value (get-internal-scrap from)))

(defun scrap-string-to-lisp-value (string)
  (multiple-value-bind (value error) (ignore-errors (prog1 (read-from-string string)))
    (if error string value)))

(defmethod convert-scrap ((from fred-scrap-handler) (to text-scrap-handler))
  (car (get-internal-scrap from)))

(defmethod convert-scrap ((from fred-scrap-handler) (to lisp-scrap-handler))
  (scrap-string-to-lisp-value (car (get-internal-scrap from))))

(defmethod convert-scrap ((from lisp-scrap-handler) (to text-scrap-handler))
  (lisp-value-to-scrap-string (get-internal-scrap from)))

(defun lisp-value-to-scrap-string (value)
  (let ((*print-pretty* t)
        (*print-circle* t))
    (with-output-to-string (stream) (prin1 value stream)))) 

(defmethod convert-scrap ((from lisp-scrap-handler) (to fred-scrap-handler))
  (list (lisp-value-to-scrap-string (get-internal-scrap from))))

#+ignore
(eval-when (:compile-toplevel :execute)
  (load "ccl:library;interfaces;scrap-patch.lisp"))

#-carbon-compat
(defun get-external-scrap (&aux temp)
  "Only called when there is external scrap to be had" ; - usually anyway
  (without-interrupts
   (if (neq 0 (setq temp (#_LoadScrap))) (%err-disp temp))
   (setq *scrap-state* nil
         *external-scrap* nil
         *external-style-scrap* nil
         *scrap-count* (#_LMGetScrapCount))
   (when (plusp (#_LMGetScrapState))
     (with-dereferenced-handles ((scrap-ptr #-carbon-compat-22 (#_LMGetScrapHandle) #+carbon-compat-22 (#_GetScrapHandle)))
       (do* ((offset 0 (+ 8
                          offset
                          (%ilogand2 -2
                                     (%i+ 1 (%get-long scrap-ptr (%i+ offset 4))))))
             (scrap-size (#_LMGetScrapSize))
             scrap-type)
            ((>= offset scrap-size))
         (setq scrap-type 
               (make-keyword (%str-from-ptr (%inc-ptr scrap-ptr offset) 4)))
         (pushnew scrap-type *external-scrap*)
         (unless (memq scrap-type *scrap-state*)
           (when (setq temp (assq scrap-type *scrap-handler-alist*))
             (internalize-scrap (cdr temp)))
           (pushnew scrap-type *scrap-state*)))))))


#+carbon-compat
(progn

(defvar *scrap-secret-number* nil)
(setq *scrap-secret-number* 0)  ;; actually same as value of (#_lmgetscrapcount)
;; not the analogue of LMGetScrapCount which has to do with how many times something has been put in scrap by apps not me or maybe me too
;; this is how many are there now - mebbe
(defun get-current-scrap-count ()
  (rlet ((count :unsigned-long))
    (let ((scrap (get-current-scrapref)))
      (let ((err (#_GetScrapFlavorCount scrap count)))
        (when (neq err #$noerr)(%err-disp err)))
      (values (%get-unsigned-long count)              
              scrap))))

;; 0 if exists nil otherwise
(defun get-scrap-flavor-flags (type)
  (rlet ((flags :unsigned-long))    
    (let ((scrap (get-current-scrapref)))
      (let ((err (#_GetScrapFlavorFlags scrap type flags)))  ;; errors if none else flags = 0 usually
        (when (eq err #$noerr)
          (%get-unsigned-long flags))))))

(defun get-scrap-flavor-size (type)
  (rlet ((size :signed-long))    
    (let ((scrap (get-current-scrapref)))
      (let ((err (#_GetScrapFlavorSize scrap type size)))
        (when (eq err #$noerr)
          (%get-signed-long size))))))

#+old
(defmethod get-scrap-flavor-data ((type (eql :text)) &optional something) ;; only text today
  (declare (ignore something))
  (when (get-scrap-flavor-flags type)
    (rlet ((rsize :signed-long))
      (let* ((dest nil)
             (size nil)
             (scrap (get-current-scrapref)))
        (unwind-protect
          (Progn
            (let* ((err (#_GetScrapFlavorSize scrap type rsize)))
              (if (eq err #$noerr)
                (setq size (%get-signed-long rsize))
                (return-from get-scrap-flavor-data nil)))            
            (setq dest (#_NewPtr :errchk size))
            (let ((err (#_GetScrapFlavorData scrap type rsize dest)))
              (When (eq err #$noerr)
                (%str-from-ptr-in-script dest size))))
          (when dest (#_DisposePtr dest)))))))

(defmethod get-scrap-flavor-data ((type (eql :text)) &optional script) ;; only text today
  ;(declare (ignore something))
  (when (get-scrap-flavor-flags type)
    (rlet ((rsize :signed-long))
      (let* ((dest nil)
             (size nil)
             (scrap (get-current-scrapref)))
        (unwind-protect
          (Progn
            (let* ((err (#_GetScrapFlavorSize scrap type rsize)))
              (if (eq err #$noerr)
                (setq size (%get-signed-long rsize))
                (return-from get-scrap-flavor-data nil)))            
            (setq dest (#_NewPtr :errchk size))
            (let ((err (#_GetScrapFlavorData scrap type rsize dest)))
              (When (eq err #$noerr)
                (%str-from-ptr-in-script dest size script))))
          (when dest (#_DisposePtr dest)))))))

(defun get-scrap-style-handle ()
  (let ((type :|styl|))
    (when *use-external-style-scrap*
      (when (get-scrap-flavor-flags type)
        (rlet ((rsize :signed-long))
          (let ((dest-handle nil)(size nil))
            (progn
              (Let ((scrap (get-current-scrapref))) ;; actually same as #_lmgetscrapcount
                (let ((err (#_GetScrapFlavorSize scrap type rsize)))
                  (if (eq err #$noerr)
                    (setq size (%get-signed-long rsize))
                    (return-from get-scrap-style-handle nil)))              
                (setq dest-handle (#_NewHandle :errchk size))
                (with-dereferenced-handles ((dest dest-handle))
                  (let ((err (#_GetScrapFlavorData scrap type rsize dest)))  
                    (when (eq err #$noerr)
                      dest-handle)))))))))))

 ;; is  called today - might even work
(defmethod get-scrap-flavor-data ((type (eql :|styl|)) &optional string) ;; string not really optional
  (when *use-external-style-scrap*
    (when (get-scrap-flavor-flags type)
      (rlet ((rsize :signed-long))
        (let ((dest-handle nil)(size nil))
          (unwind-protect
            (progn
              (Let ((scrap (get-current-scrapref))) ;; actually same as #_lmgetscrapcount
                (let ((err (#_GetScrapFlavorSize scrap type rsize)))
                  (if (eq err #$noerr)
                    (setq size (%get-signed-long rsize))
                    (return-from get-scrap-flavor-data nil)))              
                (setq dest-handle (#_NewHandle :errchk size))
                (with-dereferenced-handles ((dest dest-handle))
                  (let ((err (#_GetScrapFlavorData scrap type rsize dest)))  
                    (when (eq err #$noerr)
                      (scrap-style-handle->fred-style-vector dest-handle string))))))
            (when dest-handle (#_DisposeHandle dest-handle))))))))

 

(defmethod get-scrap-flavor-data (type &optional x)(declare (ignore type x)) nil)

(defmethod put-scrap-flavor ((type (eql :text)) string)
  (let ((data nil)
        (byte-len nil))
    (unwind-protect
      (progn
        (clear-current-scrap)
        (let ((scrap (get-current-scrapref)))
          (setq data (#_NewPtr :errchk (1+ (setq byte-len (byte-length string))))) ;; does it need to be terminated? - probably not
          (%put-string-segment-contents data string 0 (length string))
          (%put-byte data 0 byte-len)
          ;; seems to think "desk scrap isn't initialized" - sometimes works sometimes doesn't - better now
          (let ((err 
                 (#_PutScrapFlavor scrap type 0 byte-len data)))
            (when (neq err #$noerr)(%err-disp err)))))
      (when data (#_DisposePtr data)))))

(defmethod put-scrap-flavor ((type (eql :|utxt|)) string)
  (let ((data nil)
        (len (length string)))
    (unwind-protect
      (progn
        ;(clear-current-scrap)  ;; no let :text do it
        (let ((scrap (get-current-scrapref)))
          (setq data (#_NewPtr :errchk (+ len len))) 
          (copy-string-to-ptr string 0 len data)
          ;; seems to think "desk scrap isn't initialized" - sometimes works sometimes doesn't - better now
          (let ((err 
                 (#_PutScrapFlavor scrap type 0 (+ len len) data)))
            (when (neq err #$noerr)(%err-disp err)))))
      (when data (#_DisposePtr data)))))


;; can do on application-resume I think
(defun get-external-scrap (&aux temp) ;; ok got here at startup
  "Only called when there is external scrap to be had" ; - usually anyway
  (progn ;ignore-errors  ;; why - else fails at boot
  (without-interrupts
   (when (and (neq 0 (get-current-scrap-count))) ;; is scrap to be had
     (setq *scrap-state* nil
           *external-scrap* nil
           *external-style-scrap* nil
           *scrap-count* *scrap-secret-number*)
     (let ()
       (when (get-scrap-flavor-flags :text) ;; something there
         (pushnew :text *external-scrap*)
         (unless (memq :text *scrap-state*)
           (when (setq temp (assq :text *scrap-handler-alist*))
             (internalize-scrap (cdr temp)))
           (pushnew :text *scrap-state*)))
       #+ignore ;; the text one did it already
       (when (get-scrap-flavor-flags :|styl|) 
         (unless nil ;(memq :fred *scrap-state*)
           (when (setq temp (assq :fred *scrap-handler-alist*))
             (internalize-scrap (cdr temp)))
           (pushnew :fred *scrap-state*)))
       (dolist (entry *scrap-handler-alist*)
         (when (not (memq (car entry) *scrap-state*))
           (when (setq temp (cdr entry))
             (internalize-scrap temp))
           (pushnew (car entry) *scrap-state*))))))))

#+old
(defmethod internalize-scrap ((handler text-scrap-handler))
  (when (get-scrap-flavor-flags :text)
    (set-internal-scrap handler (get-scrap-flavor-data :text))))

#|
(defmethod internalize-scrap ((handler text-scrap-handler))
  (when (get-scrap-flavor-flags :text)
    (let* ((style-handle (get-scrap-style-handle)))
      ;; rather inefficient - we may grovel over the style handle 3 times
      ;; once to see if it has more than one script
      ;; if so then again to make sense of the text
      ;; and finally to transform the style handle to a fred style vector
      (when style-handle
        (unwind-protect
          (let* ((all-scripts nil)
                 (two-byte-scripts nil))
            (with-dereferenced-handles ((sp style-handle))
              (let ((nfonts (pref sp :StScrpRec.scrpNStyles)))
                (with-macptrs ((scrap-style-element (pref sp :StScrpRec.scrpStyleTab)))
                  (dotimes (i nfonts)
                    (let* ((font (pref scrap-style-element :ScrpSTElement.scrpFont))                         
                           (script (#_fonttoscript font)))
                      ;(print (list nfonts font (pref scrap-style-element :scrpstelement.scrpstartchar)))
                      (when (two-byte-script-p script)
                        (pushnew script two-byte-scripts))
                      (pushnew script all-scripts)
                      (%incf-ptr scrap-style-element (record-length :ScrpSTElement))))
                  (when two-byte-scripts
                    (cond ((and ;(eq (length two-byte-scripts) 1)
                            (eq (length all-scripts) 1))
                           (return-from internalize-scrap 
                             (set-internal-scrap handler (get-scrap-flavor-data :text (car two-byte-scripts)))))
                          (t (return-from internalize-scrap 
                               (set-internal-scrap handler (internalize-scrap-text style-handle))))))))))
          (when (macptrp style-handle) (#_disposehandle style-handle))))          
      (set-internal-scrap handler (get-scrap-flavor-data :text)))))
|#

;; boot problem if non 7bit-ascii string scrap hanging around
(when (not (fboundp 'convert-string))
  (defun convert-string (string in out)
    (declare (ignore in out))
    string))


(defmethod internalize-scrap ((handler text-scrap-handler))
  (when (and (get-scrap-flavor-flags :text)(not (get-scrap-flavor-flags :|utxt|)))
    (let* ((style-handle (get-scrap-style-handle)))
      (cond
       (style-handle
        (unwind-protect
          (set-internal-scrap handler (internalize-scrap-text style-handle))
          (when (macptrp style-handle) (#_disposehandle style-handle))))
       (t
        (multiple-value-bind (text-ptr text-len)(get-scrap-flavor-text)
          (when text-ptr
            ;; I dont think we care what "it" is as long as non nil - ah we do if no :|utxt| in town
            (let ((it (%str-from-ptr text-ptr text-len)))
              (when (not (7bit-ascii-p it))  ;; so who sez its macroman?
                (setq it (convert-string it #$kcfstringencodingmacroman #$kcfstringencodingunicode)))
              (set-internal-scrap handler it))
            (#_disposeptr text-ptr))))))))

#|
;; known to have at least one two byte script and more than one script
(defun internalize-scrap-text (style-handle)
  (with-dereferenced-handles ((sp style-handle))
    (let* ((nfonts (pref sp :StScrpRec.scrpNStyles))
           (font-array (make-array nfonts))
           (start-byte-array (make-array nfonts)))
      (declare (dynamic-extent font-array start-byte-array))      
      (with-macptrs ((scrap-style-element (pref sp :StScrpRec.scrpStyleTab)))
        (dotimes (i nfonts)
          (let* ((font (pref scrap-style-element :ScrpSTElement.scrpFont)))
            (setf (aref font-array i) font)
            (setf (aref start-byte-array i) (pref scrap-style-element :scrpstelement.scrpstartchar)))
            (%incf-ptr scrap-style-element (record-length :ScrpSTElement)))
        (multiple-value-bind (text-ptr text-len) (get-scrap-flavor-text)
          (let ((string))
            (when text-ptr
              (dotimes (i nfonts)
                (let* ((font (aref font-array i))
                       (script (#_fonttoscript font))
                       (start-byte (aref start-byte-array i))
                       (end-byte (if (= i (1- nfonts)) text-len (aref start-byte-array (+ i 1)))))
                  (let ((next (sub-str-from-ptr-in-script text-ptr start-byte end-byte script)))
                    (setq string (if string (concatenate 'string string next) next)))))
              (#_disposeptr text-ptr)
              string)))))))
|#

;; ugh - what is this for? - in case another app put :text with :|styl| but no :|utxt| (e.g. MCL 5.1)
(defun internalize-scrap-text (style-handle)
  (with-dereferenced-handles ((sp style-handle))
    (let* ((nfonts (pref sp :StScrpRec.scrpNStyles))
           (font-array (make-array nfonts))
           (start-byte-array (make-array nfonts)))
      (declare (dynamic-extent font-array start-byte-array))      
      (with-macptrs ((scrap-style-element (pref sp :StScrpRec.scrpStyleTab)))
        (dotimes (i nfonts)
          (let* ((font (pref scrap-style-element :ScrpSTElement.scrpFont)))
            (setf (aref font-array i) font)
            (setf (aref start-byte-array i) (pref scrap-style-element :scrpstelement.scrpstartchar)))
            (%incf-ptr scrap-style-element (record-length :ScrpSTElement)))
        (multiple-value-bind (text-ptr text-len) (get-scrap-flavor-text)
          (let ((strings)
                string)
            (when text-ptr
              (dotimes (i nfonts)
                (let* ((font (aref font-array i))
                       (script (#_fonttoscript font))
                       (start-byte (aref start-byte-array i))
                       (end-byte (if (= i (1- nfonts)) text-len (aref start-byte-array (+ i 1)))))
                  (let ((next (sub-str-from-ptr-in-script text-ptr start-byte end-byte script))
                        (encoding (font-to-encoding-no-error font)))
                    (setq next (convert-string next encoding #$kcfstringencodingunicode))
                    (push next strings))))
              (when strings (setq string (if (cdr strings)(apply #'%str-cat (nreverse strings)) (car strings))))
              (#_disposeptr text-ptr)
              string)))))))


(defun sub-str-from-ptr-in-script (pointer start-byte end-byte script)
  (let ((table (get-char-byte-table script)))
    (if (not table)
      (sub-str-from-pointer pointer start-byte end-byte)
      (multiple-value-bind (chars fatp) (pointer-char-length-sub pointer start-byte end-byte script)
        (cond
         ((not fatp) (sub-str-from-pointer pointer start-byte end-byte))
         (t 
          (let ((new-string (make-string chars :element-type 'extended-character)))
            (sub-pointer-to-string-in-script pointer new-string chars script start-byte)
            new-string)))))))


(defun sub-str-from-pointer (pointer start end)
  (let ((len (- end start)))
    (%copy-ptr-to-ivector pointer start (make-string len :element-type 'base-character) 0 len)))


(defun sub-pointer-to-string-in-script (pointer string string-len script &optional start-byte)
  (let* ((table (get-char-byte-table script))
         (i start-byte))
    (dotimes (j string-len)
      (let ((c (%get-byte pointer i)))
        (cond ((and table (eql 1 (aref table c)))
               (setq c (%ilogior (%ilsl 8 c)(%get-byte pointer (%i+ 1 i))))
               (setq i (%i+ i 2)))
              (t (setq i (%i+ i 1))))
        (setf (%scharcode string j) c)))
    string))

;; start and end are byte positions

(defun pointer-char-length-sub (pointer start end script)
  (let ((table (get-char-byte-table script)))
    (cond ((not table) (- end start))
          (t (let ((i start)
                   (j 0))
               (until (%i>= i end)
                 (let ((c (%get-byte pointer i)))
                   (if (eql 1 (aref table c))
                     (setq i (%i+ i 2))
                     (setq i (%i+ i 1)))
                   (setq j (%i+ j 1))))
               (values j (%i< j (- end start))))))))

;; subset of get-scrap-flavor-data :text
(defun get-scrap-flavor-text ()
  (let ((type :text))
    (rlet ((rsize :signed-long))
      (let* ((dest nil)
             (size nil)
             (scrap (get-current-scrapref)))
        (unwind-protect
          (Progn
            (let* ((err (#_GetScrapFlavorSize scrap type rsize)))
              (if (eq err #$noerr)
                (setq size (%get-signed-long rsize))
                (return-from get-scrap-flavor-text nil)))            
            (setq dest (#_NewPtr :errchk size))
            (let ((err (#_GetScrapFlavorData scrap type rsize dest)))
              (When (eq err #$noerr)
                (values dest size)))))))))





;; assumes text already gotten - here if style available too
;; this stuff is so screwy it should be shot.
(defmethod internalize-scrap ((handler fred-scrap-handler))
  (when (get-scrap-flavor-flags :|styl|)
    (let ((string (get-scrap :text)))
      (when string 
        (let ((style (get-scrap-flavor-data :|styl| string)))
          (set-internal-scrap handler (cons string style)))))))



;; used to do this before application-suspend, now gotta do in put-scrap every time instead or something
;; so maybe this should be a noop or put-external-scrap should be a noop - it is now
;; and this isn't called
;; They say that the suspend event doesn't arrive till AFTER the app has been suspended
;; and then the put scrap won't work. One can however promise a scrap - too much trouble.
#|
(defmethod externalize-scrap ((handler text-scrap-handler))
  (let* ((string (get-internal-scrap handler)))
    (when string
      (put-scrap-flavor :text string))))
|#

(defvar @@ nil)

;;; ---------------------------------------------------------------------------

(defvar @@@ nil)

;;; ---------------------------------------------------------------------------

(export '(@@ @@@))

;;; ---------------------------------------------------------------------------


(defun put-scrap (scrap-type scrap &optional (overwritep t) &aux temp)
  (without-interrupts
   (if overwritep
     (progn
       (dolist (s-type *scrap-state*)
         (when (setq temp (assq s-type *scrap-handler-alist*))
           (set-internal-scrap (cdr temp) nil)))
       (setq *scrap-state* nil
             *external-scrap* nil
             *external-style-scrap* nil
             *scrap-count* (get-current-scrapref))) ;; or something
     (maybe-get-ext-scrap))
   (if (setq temp (assq scrap-type *scrap-handler-alist*))
     (progn (set-internal-scrap (cdr temp) scrap)            
            (put-scrap-flavor scrap-type scrap))
     (error "There is no scrap handler for scrap type ~s" scrap-type))
   (pushnew scrap-type *scrap-state*))
  (setq @@@ @@ @@ @ @ scrap))

(defun maybe-get-ext-scrap ()
  (when (neq *scrap-count* (get-current-scrapref)) ;; or something
    (get-external-scrap)))

(defmethod put-scrap-flavor (type thing)
  (declare (ignore type thing)))

(defun clear-current-scrap ()
  ;(errchk (#_loadscrap))
  (errchk (#_ClearCurrentScrap))
  nil)

;; new headers say itsa pointer
(defun get-current-scrapref ()
  (rlet ((poo :ptr))
    ;(errchk (#_loadscrap))
    (errchk (#_GetCurrentScrap poo))
    (setq *scrap-secret-number* (%get-ptr poo))))  

#|
(defmethod put-scrap-flavor ((type (eql :fred)) scrap)
  (if (cdr scrap)
    (setq scrap (do-scrap-song-and-dance scrap)))  
  (put-scrap-flavor :text (car scrap))
  (if (cdr scrap)(put-scrap-flavor :|styl| (cdr scrap))))
|#

(defmethod put-scrap-flavor ((type (eql :fred)) scrap)
  (let ((orig-string (car scrap)))  ;; do :|ustl| too
    (if (cdr scrap)
      (setq scrap (do-scrap-song-and-dance scrap)))  
    (put-scrap-flavor :text (car scrap))  ;; do first because he does clear-current-scrap
    (if (cdr scrap)(put-scrap-flavor :|styl| (cdr scrap)))
    (put-scrap-flavor :|utxt| orig-string)
    (if (cdr scrap)
      (put-scrap-flavor :|ustl| (cdr scrap)))))

(defun do-scrap-song-and-dance (scrap)
  ;; make the string be mac encoded but still character wise
  (let ((string (car scrap))
        (style-vector (cdr scrap))
        parts)
    (cond 
     ((7bit-ascii-p string)
      scrap)
     (t (if (listp style-vector)
          (setq style-vector (car style-vector)))
        (setq style-vector (require-type style-vector '(simple-array (unsigned-byte 16))))    
        (let* ((style-count (aref style-vector 0))
               (run-index (* 2 style-count))
               (run-words (- (length style-vector) (1+ run-index)))
               (run-count (1- (require-type (/ run-words 2) 'fixnum))))
          (declare (fixnum style-count run-index run-words run-count))
          (dotimes (i run-count)
            (let* ((word0 (aref style-vector (incf run-index)))
                   (word1 (aref style-vector (incf run-index)))
                   (font-index (1- (ash word0 -8)))
                   (start-position (+ (ash (logand word0 #xff) 16) word1)) ;; start pos is in chars                   
                   (end-position (if (eq i (1- run-count))
                                   (length string)
                                   (+ (ash (logand (aref style-vector (%i+ 1 run-index)) #xff) 16)
                                      (aref style-vector (%i+ 2 run-index)))))
                   (font (aref style-vector (1+ (%i* 2 font-index)))))
              (declare (fixnum word0 word1 font-index start-position end-position font))
              (setq font (font-in font)) ;?? - maybe neg
              ;; lots of garbage - could dump all the parts into a stack buffer
              ;; or create a utxt scrap but I dunno how many apps like that nor how to create the ustl scrap
              ;; or do promise scrap - dunno how to do that either
              (let* ((substring (if (and (eq start-position 0)(eq end-position (length string)))
                                  string
                                  (%substr string start-position end-position)))
                     (encoding (font-to-encoding-no-error font)))
                ;(push (list substring encoding) barf)
                (push (convert-string substring #$kcfstringencodingunicode (or encoding #$kcfstringencodingmacroman)) parts))))
          (cons (if (eq (length parts) 1) (car parts) (apply #'%str-cat (nreverse parts)))
                (cdr scrap)))))))
  

;; assume already put the text - don't want to clearcurrentscrap
(defmethod put-scrap-flavor ((type (eql :|styl|)) style-vector)
  ;; data is a fred style vector
  (when *use-external-style-scrap*
    (let ((handle))
      (unwind-protect
        (progn
          (setq handle (#_NewHandle :errchk 0))
          (fred-style-vector->scrap-style-handle style-vector handle (get-scrap :TEXT))
          (let ((len (#_GetHandleSize handle)))
            (let ((scrap (get-current-scrapref)))
              (with-dereferenced-handles ((data handle))
                (let ((err 
                       (#_PutScrapFlavor scrap type 0 len data)))
                  (when (neq err #$noerr)(%err-disp err)))))))
        (when handle (#_DisposeHandle handle)))))) ;??


;;
(defmethod internalize-scrap :after ((handler text-scrap-handler))
  (let ((fred-scrap-handler (cdr (assq :fred *scrap-handler-alist*))))
    (when fred-scrap-handler (internalize-scrap fred-scrap-handler))))
)
    



#| ; moved to color.lisp - after initialize-fred-palette
(def-ccl-pointers scrap ()
  (setq *scrap-state* nil
        *external-scrap* nil)
  (get-external-scrap))
|#

#-carbon-compat
(defun put-external-scrap ()
  (without-interrupts 
   (unless *external-scrap* (#_ZeroScrap))
   (setq *scrap-count* (#_LMGetScrapCount))
   (dolist (scrap-type *scrap-state*)
     (unless (memq scrap-type *external-scrap*)
       (externalize-scrap
        (cdr (assq scrap-type *scrap-handler-alist*)))
       (push scrap-type *external-scrap*)))))

#+carbon-compat
(defun put-external-scrap () nil)

(defvar @ nil)

#-carbon-compat
(defun put-scrap (scrap-type scrap &optional (overwritep t) &aux temp)
  (without-interrupts
   (if overwritep
     (progn
       (dolist (s-type *scrap-state*)
         (when (setq temp (assq s-type *scrap-handler-alist*))
           (set-internal-scrap (cdr temp) nil)))
       (setq *scrap-state* nil
             *external-scrap* nil
             *external-style-scrap* nil
             *scrap-count* (#_LMGetScrapCount)))
     (maybe-get-ext-scrap))
   (if (setq temp (assq scrap-type *scrap-handler-alist*))
     (set-internal-scrap (cdr temp) scrap)
     (error "There is no scrap handler for scrap type ~s" scrap-type))
   (pushnew scrap-type *scrap-state*))
  (setq @ scrap))

#-carbon-compat
(defun maybe-get-ext-scrap ()
  (when (neq *scrap-count* (#_LMGetScrapCount))
    (get-external-scrap)))


(defun get-scrap (scrap-type)
  (without-interrupts
   (if (get-scrap-p scrap-type)
     (values (get-internal-scrap (cdr (assq scrap-type *scrap-handler-alist*))) t))))

(defun get-scrap-p (scrap-type &optional get-external-scrap-p)
  (without-interrupts
   (when get-external-scrap-p
     (maybe-get-ext-scrap))
   (memq scrap-type *scrap-state*)))


;;;New buffer font-spec stuff after here

(defun buffer-set-font-spec (buffer font-spec &optional start end)
  "If no start, the insertion font is set.
  Always merges with the current font."
  (if start
    (progn
      (multiple-value-setq  (start end) (buffer-range buffer start end))
      (let ((buf (mark.buffer buffer)))
        ; maybe
        (when (%i> (%i+ (bf.bfonts buf)(bf.afonts buf)) 2000)
          (let ((gappos (bf.gappos buf)))
            (when (neq start gappos)
              (%move-gap buf (%i- start gappos)))))
        (until (eq start end)
          (multiple-value-bind (pos font fidx)(%buf-find-font buf start)
            (declare (ignore pos))
            (let ((next (%buf-next-font-change buf fidx)))
              (when (or (null next) (%i> next end)) (setq next end))
              (multiple-value-bind (ff ms) (%buffer-font-codes buf font)
                (multiple-value-setq (ff ms) (font-codes font-spec ff ms))
                (buffer-set-font-codes buffer ff ms start next))
              (setq start next))))))
    (multiple-value-bind (ff ms) (buffer-font-codes buffer)
      (multiple-value-setq (ff ms) (font-codes font-spec ff ms))
      (buffer-set-font-codes buffer ff ms)))
  t)

(defun buffer-replace-font-spec (buf old-spec new-spec)
  "replaces the old spec with the new one."
  (multiple-value-bind (old-ff old-ms) (font-codes old-spec)
    (multiple-value-bind (new-ff new-ms) (font-codes new-spec old-ff old-ms)
      (buffer-replace-font-codes buf old-ff old-ms new-ff new-ms))))

(defun buffer-char-font-spec (place &optional position)
  "returns the font spec of the character at the given position"
  (multiple-value-bind (ff ms) (buffer-char-font-codes place position)
    (font-spec ff ms)))

(defun buffer-current-font-spec (buffer)
  "returns the font spec of the current insertion font"
  (multiple-value-bind (ff ms) (buffer-font-codes buffer)
    (font-spec ff ms)))

(defun buffer-insert-with-style (buf string style &optional start-pos)
  (setq start-pos (buffer-position buf start-pos))
  (buffer-insert buf string start-pos)
  (when style
    (buffer-set-style buf style start-pos)))

(defun reserrchk (&aux num)
  (unless (eql 0 (setq num (#_ResError)))
    (%err-disp num)))

(defvar *fred-color-hash* nil)

(def-ccl-pointers fred-color ()
  (setq *fred-color-hash* (make-hash-table :test #'eq)))

;; below 2 fns from new-fred-window.lisp
(defun fred-palette-closest-entry (color)
  (if *fred-palette*
    (or (if (eq color *black-color*) 0)
        (gethash color *fred-color-hash*)
        (let ((val (palette-closest-entry *fred-palette* color t)))
          (setf (gethash color *fred-color-hash*) val)))
    0)
  )



; This is wrong, but simple: cartesian distance in the RGB cube is
; not a very good measure of color closeness.
; palette is a palette handle
; color is an MCL 24-bit color
(defun palette-closest-entry (palette color &optional ignore-0)
  (flet ((hi8 (x) (round x 256)))
    (multiple-value-bind (red green blue) (color-values color)
      (setq red (hi8 red)
            green (hi8 green)
            blue (hi8 blue))
      (let ((distance (* 3 256 256))
            (index 0))
        (flet ((square (x) (* x x)))
          (rlet ((rgb :RGBColor))
            (dotimes (i (href palette :palette.PMEntries))
              (unless (and ignore-0 (eql i 0))
                (#_GetEntryColor palette i rgb)
                (let ((d (+ (square (- red (hi8 (pref rgb :RGBColor.red))))
                            (square (- green (hi8 (pref rgb :RGBColor.green))))
                            (square (- blue (hi8 (pref rgb :RGBColor.blue)))))))
                  (when (< d distance)
                    (setq distance d
                          index i)
                    (when (eq d 0) (return))))))))
        index))))




#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
	3	1/5/95	akh	non roman word breaks
|# ;(do not edit past this line!!)
