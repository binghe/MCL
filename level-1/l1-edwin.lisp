;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: l1-edwin.lisp,v $
;;  Revision 1.36  2006/03/13 04:10:51  alice
;;  ;; add method ed-xform-CRLF, fred-initialize will do it if *transform-CRLF-to-carriageReturn* is true
;;
;;  Revision 1.35  2006/03/08 02:10:43  alice
;;  ;; get rid of :prompt "save file as ..." in calls to choose-new-file-dialog, heed chosen-format from nav popup in window-save-copy-as
;;
;;  Revision 1.34  2006/02/03 00:53:21  alice

;; 
;; ----- 5.2b1
;; (setf fred-word-wrap-p) enables or disables the horizontal scroll bar if it exists
;; window-save-as - don't copy the resource fork - seems to cause problems and if a fred file has other resources it should be handled elsewhere?
;;
;;  Revision 1.33  2005/11/12 20:54:40  alice
;;  ;; add variable *save-as-original-format* to save as whatever it was
;; add method ed-self-insert-maybe-LF - fn of *unix-devotee*
;;
;;  Revision 1.32  2005/09/10 09:40:08  alice
;;  ;; view-restore-position - fix for saved position not main screen
;;
;;  Revision 1.31  2005/07/02 10:37:09  alice
;;  ; add window-ask-revert-dialog, uses #_NavCreateAskDiscardChangesDialog, called by window-revert
; added some unused (commented out) code for window-modal/sheet dialog
; add standard-alert-dialog (osx only) - window-revert and a few others call it if osx-p
;;
;;  Revision 1.30  2005/06/25 21:16:51  alice
;;  ; akh window-revert positions y-or-n-dialog atop relevant window
; 06/23/05 akh window-ask-save uses #_NavCreateAskSaveChangesDialog on OSX
;;
;;  Revision 1.29  2005/04/19 07:05:24  alice
;;  ; window-save-file handles external-format :unix - ugh
;;
;;  Revision 1.28  2005/03/12 04:28:45  alice
;;  ; ed-self-insert does something special for kCFStringEncodingMacSymbol
;;
;;  Revision 1.27  2005/02/18 01:32:30  alice
;;  ; fix the ... thing in pathname-to-window-title
;;
;;  Revision 1.26  2005/02/07 03:29:25  alice
;;  ; yet another version of ed-self-insert
;;
;;  Revision 1.25  2005/02/01 07:01:15  alice
;;  unicode stuff
;;
;;  Revision 1.24  2004/12/20 21:47:41  alice
;;  ; 12/16/04 pass owner to make-buffer 
; 12/14/04 paste does utxt
;;
;;  Revision 1.23  2004/10/03 06:15:28  alice
;;  ; view-save-position - move (when preserve-file-info-p ...)  inside (when name ...) clause
;;
;;  Revision 1.22  2004/09/07 01:41:44  alice
;;  ; bp-and-caret is woi, uses with-pen-saved-simple
;;
;;  Revision 1.21  2004/07/26 21:14:39  alice
;;  ; window-revert  :cancel button  vs :no
;;
;;  Revision 1.20  2004/07/15 20:18:34  alice
;;  ; 07/14/04 view-click-event-handler for fred-mixin - botched scope of without-interrupts
;;
;;  Revision 1.19  2004/07/11 21:11:16  svspire
;;  window-revert dtrt with unix files
;;
;;  Revision 1.18  2004/07/06 20:38:36  alice
;;  ; view-click-event-handler for fred-mixin - do with-text-colors later
;;
;;  Revision 1.17  2004/06/20 22:57:40  alice
;;  ; 06/18/04 window-can-do-operation for undo-more - tiny change
;;
;;  Revision 1.16  2004/06/04 15:10:30  svspire
;;  window-save-as calls update-recent-files so new files get remembered too
;;
;;  Revision 1.15  2004/05/02 01:19:55  alice
;;  ; 04/30/04 no more instance-initialize-mixin
;;
;;  Revision 1.14  2004/04/26 03:56:56  alice
;;  ; 04/26/04 fred-mixin includes instance-initialize-mixin
;;
;;  Revision 1.13  2004/03/25 08:19:59  alice
;;  ; 03/24/04 defgeneric fred-initialize
;;
;;  Revision 1.12  2004/02/23 04:34:29  svspire
;;  Support 'Open Recent' menu item.
;;
;;  Revision 1.11  2004/02/22 00:40:20  alice
;;  ; 02/21/04 view-click-event-handler of fred-mixin - do with-timer
;;
;;  Revision 1.10  2004/02/19 21:09:43  alice
;;  ; 02/19/04 view-save-position - do heed preserve-file-info-p
;;
;;  Revision 1.9  2004/02/10 05:30:45  alice
;;  window-save-file -- maybe write it unix-wise but retain readabilty in buffer
;;
;;  Revision 1.8  2004/01/21 04:22:04  alice
;;  ; 12/20/03 akh align-pos&target fix so that inserted spaces get the font of previous spaces if any.
;;
;;  Revision 1.7  2003/12/08 08:37:13  gtbyers
;;  Don't use DEF-AUX-INIT-FUNCTIONS anymore.
;;
;;  8 10/5/97  akh  see below
;;  7 8/25/97  akh  control-q stuff
;;  6 7/4/97   akh  see below
;;  5 6/2/97   akh  see below
;;  3 4/1/97   akh  see beow
;;  16 1/22/97 akh  add c-x c-p - find unbalanced paren or #comment, beep if none found
;;  15 9/15/96 akh  fred-initialize - buffer-insert-file first, then set wrap from args, then make-frec
;;  14 9/13/96 akh  fred-initialize - put wrap-p and word-wrap-p in the buffer too.
;;  13 7/26/96 akh  rearrange setf fred-wrap-p and word-wrap-p so read-only is caught before changing anything.
;;                  (setf fred-tab-count)
;;  12 7/18/96 akh  dont remember
;;  11 5/20/96 akh  trying italic cursor again
;;  10 4/20/96 akh  remove view-cursor method
;;  9 4/17/96  akh  see below
;;  8 3/27/96  akh  window-can-do for execute selection is more liberal,
;;                             fix ed-style-end to account for color-vector, fix ed-set-view-font for read-only
;;
;;  6 3/9/96   akh  set-view-size for fred-mixin clears paragraph cache
;;  3 10/23/95 akh  fix run-fred-command for new-w = nil
;;  2 10/17/95 akh  merge patches
;;  29 6/9/95  akh  run-fred-command - font stickier when self insert
;;  28 6/8/95  slh  undo, select-all reset insertion-font
;;  26 5/31/95 akh  put back fred-update in window-show-cursor
;;  25 5/31/95 akh  window-save-copy-as gets optional filename argument
;;  24 5/30/95 akh  setting font is stickier so dont lose it when a newline is typed
;;  23 5/23/95 akh  use mac-file-write-date
;;  22 5/22/95 akh  break view-restore-position into two pieces
;;  21 5/19/95 akh  delete some commented out code
;;  20 5/18/95 akh  fred-update for fred-mixin - dont call window-update-event-handler
;;                  This fixes gray windows turning white when paste while initializing (why ?)
;;  19 5/15/95 akh  maybe no change
;;  18 5/10/95 akh  fix a fix
;;  17 5/10/95 akh  dont set-fred-package if no file - messes up listener
;;  16 5/10/95 akh  added method ed-setting-font-p
;;  15 5/8/95  akh  in fred-initialize - set-fred-package to *package* if no file
;;  14 5/4/95  akh  probably no change
;;  13 4/28/95 akh  view-activate-event-handler draws now to fix half caret
;;  12 4/26/95 akh  minor tweeks for speed
;;  10 4/24/95 akh  window-show-cursor does edit-menu business
;;  8 4/10/95  akh  fix for comtab arg to fred-window
;;  6 4/6/95   akh  window-save-as use method application-file-creator
;;  4 4/4/95   akh  setf for wrap-p and word-wrap-p keep things consistent and update screen
;;  22 3/22/95 akh  activate and deactivate are without-interrupts
;;  21 3/20/95 akh  window-show-cursor is without-interrupts
;;  20 3/15/95 akh  window-show-selection - change max back to min else too slow when search string gets extended
;;  19 3/14/95 akh  add with-text-colors in a  bunch of places
;;                  add a :saved mark in history list so we can change modified mark when one undos back to save
;;  16 3/2/95  akh  In fred-update - dont call window-update-event-handler on inactive window
;;                  make sure focused when calling frec-update
;;                  window-show-cursor call update before frec-show-cursor to get background color right
;;  15 2/17/95 akh  move kludge part-color method to fred-mixin
;;  14 2/17/95 akh  eval" => "execute" in window-eval-selection
;;  13 2/9/95  akh  set-fred-display-start-mark focuses in frec-update case
;;  12 2/6/95  akh  get rid of compiler warning in buffer-whine-read-only.
;;  11 2/6/95  akh  
;;  10 1/31/95 akh  changed the text for the Make it Modifiable dialog
;;  8 1/25/95  akh  change text of window-revert dialog
;;  7 1/11/95  akh  move the modeline back to top
;;  6 1/11/95  akh  buffer-whine-read-only has a dialog that lets one make file modro
;;  (do not edit before this line!!)

; L1-edwin.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2007 Digitool, Inc.

;; Modification History
;; dont use buffer-roman
;; standard-alert-dialog - schar -> char, if message not string, coerce to same - fn moved to dialogs
;; ------ 5.2b6
;; add method set-window-filename-simple
;; window-filename-from-fsref does #_removewindowproxy if fsref gone or in trash
;; window-save-as, set-window-filename and pathname-to-window-title - dont *use-namestring-caches*
;; ed-self-insert-maybe-lf fn of *preferred-eol-character*
;; standard-alert-dialog - position arg does something now
;; frec slot for fred-mixin gets :initform nil
;; lose part-color kludge for fred-mixin - it belongs with fred-dialog-item
;; pathname-to-window-title and window-save-as call %file-system-string
;; window-revert - dialog rather than error if file is gonzo, also ask if mod dates dont match
;; window-filename back to full-path vs logical-path - logical done in pathname-to-window-title
;; window-save-file - get external-format from window rather than calling utf-something-p
;; window-save - if file has moved, ask if want to save as original path or new path
;; window-filename-from-fsref - trash => gonzo
;; ed-indent-for-lisp and ed-indent-differently - fix so any eol char works
;; window-revert does ed-xform-crlf rather than doing it in buffer-insert-file, issues a warning if ed-xform-crlf did change
;; ed-xform-crlf returns t if did something else NIL, fred-initialize doen't do ed-xform-crlf - done elsewhere
;; paste does paste-styled-utxt
;; ----- 5.2b5
;; ed-xform-crlf heeds *preferred-eol-character*
;; ------- 5.2b4
;;  ; export standard-alert-dialog
;; window-save-as does #_removewindowproxy
;; *save-as-original-format* initially T, fiddle with window-save etal to obey it if user did not do a choose-file-dialog
;; window-save says :supersede vs :overwrite so errors less likely to be "fatal" to the file content.
;; maybe do  (%buffer-set-read-only (fred-buffer w) nil) sooner in window-save-as so ed-xform-xxx wont whine if invoked 
;; ed-xform-newlines etal do read-only-check
;; beware window-fsref gone bad - e.g. volume unmounted, file deleted etc.
;; standard-alert-dialog - add ability to type first char of button title to select as was done by old y-or-n-dialog
;; ------- 5.2b4
;; set-window-filename does back-translate-pathname
;; window-save and window-revert back-translate path-from-fsref
;; window-save-as loses old fsref if any, window-save uses fsref if exists in case someone moved the file unbeknownst to us
;; ed-self-insert - fix for font = macsymbol - 
;; *unix-devotee* => *unix-line-ending*
;; pathname-to-window-title gets an optional arg to maybe omit directory
;; ------ 5.2b3
;; add method ed-xform-CRLF, fred-initialize will do it if *transform-CRLF-to-carriageReturn* is true
;; get rid of :prompt "save file as ..." in calls to choose-new-file-dialog, heed chosen-format from nav popup in window-save-copy-as
;; export standard-alert-dialog
;; ----- 5.2b1
;; (setf fred-word-wrap-p) enables or disables the horizontal scroll bar if it exists
;; window-save-as - don't copy the resource fork - seems to cause problems and if a fred file has other resources it should be handled elsewhere?
;; add variable *save-as-original-format* to save as whatever it was
;; add method ed-self-insert-maybe-LF - fn of *unix-devotee*
;; view-restore-position - fix for saved position not main screen
;; add window-ask-revert-dialog, uses #_NavCreateAskDiscardChangesDialog, called by window-revert
; added some unused (commented out) code for window-modal/sheet dialog
; add standard-alert-dialog (osx only) - window-revert and a few others call it if osx-p
; akh window-revert positions y-or-n-dialog atop relevant window
; 06/23/05 akh window-ask-save uses #_NavCreateAskSaveChangesDialog on OSX
; window-save-file handles external-format :unix - ugh
; ed-self-insert does something special for kCFStringEncodingMacSymbol
; fix the ... thing in pathname-to-window-title
; yet another version of ed-self-insert
; 12/16/04 pass owner to make-buffer 
; 12/14/04 paste does utxt
; ----- 5.1 final
; view-save-position - move (when preserve-file-info-p ...)  inside (when name ...) clause
; ---------- 5.1b3
; key-handler-idle is woi
; window-revert  :cancel button  vs :no
; 07/14/04 view-click-event-handler for fred-mixin - botched scope of without-interrupts
; 06/11/04 ss window-revert dtrt with unix files
; view-click-event-handler for fred-mixin - do with-text-colors later
; 06/18/04 window-can-do-operation for undo-more - tiny change
; -------- 5.1b2
; 04/30/04 no more instance-initialize-mixin 
; 04/26/04 fred-mixin includes instance-initialize-mixin
; 03/24/04 defgeneric fred-initialize
; support 'Open Recent' menu item
; 02/21/04 view-click-event-handler of fred-mixin - do with-timer
; 02/19/04 view-save-position - do heed preserve-file-info-p
; window-save-file -- maybe write it unix-wise but retain readabilty in buffer
; -------- 5.1b1
; 12/20/03 akh align-pos&target fix so that inserted spaces get the font of previous spaces if any.
; window-save-as more sensible
; copy-of-file-name uses maybe-encoded-strcat - maybe %str-cat should always do that??
; new-window-number ignores encoded string titles
; modernize get-mpsr-info
; pathname-to-window-title handles encoded strings
; -------- 5.0final
; fred-initialize uses *do-unix-hack*
; ----- 5.0b3
; view-activate-event-handler ((w fred-mixin)) from Shannon Spires
; ------- 4.4b4
; 04/30/01 akh window save has same disease on osx as on bbox
; 03/23/01 akh see window-save re classic aka bbox
;; 03/20/01 do flush-volume BEFORE mac-file-write-date - makes classic happier maybe - NOPE
; add ed-xform-linefeeds  to fix the linefeeds in some header files
; akh carbon-compat
; 12/26/99 akh view-restore-position - fix for different OS title-height and border-width
; window-can-do-operation - fix some bogosity
; ----------------- 4.3f1c1
; file-whine-read-only makes sure 'set-file-modify-read-only is loaded in case file acquired readonlyness after opening.
;; ------------- 4.3b2
; AKH - COUPLE of ed-xxx functions become methods
; akh some things are methods which were functions before
; akh buffer-whine-read-only explains file is locked.
; 04/14/99 akh window-save does handle-file-gonzo
; 04/04/99 akh clear-mini-buffer-maybe for listener
;;--------------- 4.3b1
; 02/13/99 akh callers of y-or-n-dialog use *tool-back-color* ??
; 02/02/99 akh stream-position  returns new-pos vs mark
; 12/10/98 akh view-save-position - defend against errors for read-only file etc.
; 10/28/98 akh view-activate-event-handler for fred-mixin - dont hilite selection twice
; 08/14/98 akh window-save-as copies resource fork of original when it makes sense
; 10/28/97 akh window-save deals with handle-buffer-save-conflict - nobody else?
; 09/19/97 akh run-fred-command - quote-twiddles in keystroke-code for set-mini-buffer
; 09/10/97 akh if word-wrap ctrl-n and ctrl-p do screen-lines, also ed-beginning/end-line from alanr
; 07/09/97 akh run-fred-command - ctrl-q echo shows up again, ctrl-q enabling dead keys is optional
; 06/14/97 akh  window-save-as - dont care if file-modcnt is t
; 04/08/97 akh  window-revert calls reparse-modeline with no-create t
; 04/17/97 bill (method stream-clear-input (fred-mixin))
; ------------- 4.1b2
; 03/22/97 akh  ed-find-unbalanced-paren - fix for semi-comment at file end or followed by unmatched )
; 03/06/97 bill  (method Paste :around (fred-mixin)) inverts *paste-with-styles* if
;                processing an event and the shift key is down.
;                (method Copy (fred-mixin)) inverts style copying if processing
;                an event and the shift key is down.
; 01/17/97 bill  get-mpsr-info calls probe-file on the input file name to resolve aliases.
; 01/14/97 bill  (method fred-initialize (fred-mixin)) clears the bf.refcount field of a new buffer.
; akh add c-x c-p
; -------------  4.0
;;<end of added text>
; akh fred-initialize - put wrap-p and word-wrap-p in the buffer too.
; akh rearrange setf fred-wrap-p and word-wrap-p so read-only is caught before changing anything
; 04/24/95 akh trying italic cursor again
; 04/22/96 akh cut, clear, paste - do it if whine returns true - window-can-do OK if read-only
; 04/14/96 akh add view-cursor for fred-mixin, call frec-cursor to get maybe italic-cursor
;		run-fred-command - if buffer-whine-read-only made writable, then do the darn command
; 03/26/96 akh window-can-do for execute selection is more liberal,
;           fix ed-style-end to account for color-vector, fix ed-set-view-font for read-only

; 03/26/96  gb  lowmem accessors.
; 11/29/95 bill  #_PBHSetFInfo -> #_PBHSetFInfoSync to avoid trap emulator
; 11/13/95 gb    use #_PB traps.
;  4/24/95 slh   Copy: don't call add-to-killed-strings, put-scrap will
;  4/04/95 slh   window-save-as: use *ccl-file-creator*
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
; 2/27/95 slh   window-can-do-operation: add execute-whole-buffer
;-------------  3.0d17
; 1/29/95 slh   window-can-do-operation: smarter test for execute-selection
;               added buffer-at-sexp-end
;-------------  3.0d16
; 01/10/93 alice buffer-whine-read-only asks if you want to modify anyway.
; 01/03/95 ed-backward-select-word deal with non roman scripts 
; 12/30/94 ed-set-view-font sets empty-font too if whole buffer selected.
; coords were wrong in fred-update (fred-mixin) - no view-position window needed
; fred-mixin has a fred-update-method - move edit-menu update to it from view-key-event-handler
; window-can-do-operation handles window-save-as, window-save-copy-as
; %set-control-value is dead code
; window-revert uses (set-fred-display-start-mark owner ..) to get all frecs near original pos
; set-fred-display-start-mark calls fred-update vs frec-update for scroll bars.
; buffer-whine-read-only less verbose, new-window-number returns position as well
; run-fred-command does not mess with the mini-buffer when shadowing-comtab is *i-search-comtab*
; window-save-copy-as - deal with buffer-file-write-date
;initialization of fred-history moves from instance-initialize :after fred-mixin
; to fred-initialize (its part of buffer!) - old way caused split panes to nuke history.
;10/18/93 alice ed-indent-for-lisp more likely to succeed in listener
;10/17/93 alice fred-mixin has color-list slot
;10/14/93 alice view-click-event-handler, view-key-event-handler, key-handler-idle,
;		 set-view-size move from fred-item to fred-mixin
;10/02/93 alice def-preference-var moves here from ccl-menus
;09/30/93 alice fred-mixin not a simple view - no more view-cursor for fred-mixin - its key-handler-mixins job
;09/26/93 alice ed-delete-with-history - history pos is (min start end). Nuke some dead code
;		(hide-scroll-bar, draw-scroll-bar-outline, fred-track-scroll-action-proc)
;09/24/93 alice ed-history-add appends if *history-added* is bound and true. *history-added*
;		is unbound at top level.
;09/21/93 alice changed her mind in ed-indent-for-lisp (do set *last-command*)
;		and ed-history-add uses *last-command* AND history (because tab can delete as well as insert)
;09/19/93 alice print-hist-string uses ~S not ~A, ed-history-add relies on history rather than
;		*last-command* to decide whether we are deleting that which we just inserted,
;		ed-indent-for-lisp doesn't set *last-command* to :self-insert
;08/27/93 alice ed-set-view-font calls buffer-set-font-spec instead of doing the same thing
;---------------
;;start of added text

;11/17/93 bill  (setf fred-tabcount) now updates buffer-tabcount and
;               invalidates views.
;10/04/93 bill  more fred-window methods pass to fred-mixin methods
;-------------- 3.0d13
;08/03/93 bill  change some instances of RREF to PREF or HREF
;07/26/93 bill  in window-can-do-operation: get-scrap -> get-scrap-p
;07/20/93 bill  set-view-font-codes checks (and ff ms)
;07/19/93 bill  add :word-wrap-p, :justification, :line-right-p initargs to
;               (method fred-initialize (fred-mixin))
;               Also fred-word-wrap-p, fred-justification, fred-line-right-p
;               accessors.
;               *i-beam-cursor* -> (frec-cursor ...) in view-cursor method
;               Remove fr.position from fred-point-pos
;               frec-hmax -> l1-edfrec
;               do-all-frecs -> map-frecs
;-------------- 3.0d12
;07/14/93 alice view-font-codes (fred-mixin) corresponds to %font-exception for prior newline.
;		what should buffer-font-codes do? we promised to nuke its optional arg.
;		all present callers of it are suspect - several of them intend something else.
; 		buffer-current-font-spec has a doc string
;		that is now incorrect - was it also in reference?
;-------------- 3.0d10
;06/23/93 alice window-set-not-modified - doesnt mess with file-modcnt if it was nil and buffer is empty
;06/23/93 alice ed-history-add - deletion of last char just inserted is not separate event.
;		ed-delete-n changes to accomodate.
;06/03/93 alice bind  *standard-output* to itself if not of type terminal-io in run-fred-command
;06/01/93 bill  bind *standard-output* to *front-window-terminal-io* in run-fred-command
;-------------- 3.0d8
;05/08/93 alice run-fred-command - bind *standard-output* such that if its use would normally
;		cause a new listener to be created,  the front listener, if there is one, will
;		be used instead
;05/04/93 alice make-string 'base-character
;04/22/93 bill  *remove-shadowing-comtab-eventhook* is a little more picky about which events abort
;-------------- 2.1d5
;04/23/93 alice set-view-font-codes and set-view-font can take nil for font meaning clear
;04/17/93 alice well maybe buffer write conflict is ok now
;04/04/93 alice new-window-number factored out of new-window-title
;-------------- 2.1d4
;03/18/93 alice paste doesn;t need to say "nothing to paste" since it should not be called then
;02/23/93 alice nuke fred-history-length and defs-dialog slots from fred-mixin
;02/21/93 alice set-my-file-name => set-window-filename (which is a misnomer)
;02/15/93 alice view-key-event-handler ((w fred-mixin) use (edit-menu) not *edit-menu*
;01/10/93 alice pathname-to-window-title - don't truncate the directory, do include host
;12/26/92 alice added view-mini-buffer for simple-view which returns nil
; 11/30/92 bill run-default-command comes here from l1-edcmd and becomes
;               a generic function.
; 11/23/92 bill window-null-event-handler focuses
;11/17/92 bill  fr.xxx -> accessor functions where possible
;08/24/92 bill  in view-control-click-event-handler: fred-update before scrolling
;               to stop balloon help from messing up dragging the horizontal scroll
;               bar thumb.
;08/05/92 bill  (method set-view-font (fred-mixin t))
;07/31/92 bill  window-ensure-on-screen now calls window-on-screen-position
;               and window-on-screen-size instead of using hard-wired constants.
;06/02/92 bill  window-ensure-on-screen now calls view-default-position &
;               view-default-size before using the wired in defaults.
;06/01/92 bill  Don't set-fred-package to NIL when initializing a fred window
;               This prevents close-window from changing the package.
;04/15/92 bill  Report an abort of an evaluation from a fred buffer in its mini-buffer.
;03/02/92 bill  moon's handle-buffer-save-conflict support
;-------------- 2.0
;03/24/92 bill  interactive-arglist prints an informative message in the modeline
;               instead of errorring if the buffer package does not exist.
;-------------- 2.0f3
;02/22/92 (alice from "post 2.0f2c5:ed-char-patch") make ED-FORWARD-CHAR revert to 2.0b4 
;               behavior - special case if selection, no shift, no explicit prefix
;-------------- 2.0f2c5
;01/07/92 gb    don't require RECORDS.
;12/28/91 alice no more shift-not-command-p - comtab does it for us
;12/17/91 alice fred-package, set-fred-package, fred-initialize and mini-buffer-update, add
;		sneaky-window-package so don't create package until really needed
;12/17/91 alice window-revert button names => revert and cancel instead of yes and no
;12/12/91 bill  #_LoadResource after #_Get1Resource
;12/09/91 alice %err-disp => signal-file-error
;12/04/91 alice dont negate fred-prefix-argument - pass it around instead so things work
;		when not called directly by run-fred-command
;12/01/91 alice window-revert now has no cancel button -  cancel and no had same effect
;12/01/91 alice ed-indent-for-lisp - dont f with the insertion point when selection
;11/27/91 bill  in fred-track-scroll-action-proc: don't call frec-screen-lines until
;               calling frec-update to make sure the frec is in sync with the buffer.
;               This fixes Mark's bug where clicking in the gray area below the Listener's
;               scroll bar thumb while output is happenning will send MCL into uninterruptable
;               infinite loop land.
;------------- 2.0b4
;10/29/91 bill  add :help-spec to window-ask-save
;10/28/91 bill  in window-can-do-operation - Don't attempt to modify non-existent menu-item
;10/16/91 bill  Fix error in ed-split-line when cursor at end of buffer.
;               Reduce consing in (method window-can-do-operation (fred-mixin))
;10/15/91 bill  eradicate window-font & set-window-font
;10/18/91 alice def-load-pointers => def-ccl-pointers
;10/15/91 alice ed-split-line dont die at buffer end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
;10/11/91 alice frec-hmax min is horizontal size not 0
;10/09/91 alice window-save-as merge-pathnames with defaults nil
;10/09/91 alice save overwrites, save-as and save-copy-as supersede
;10/11/91 gb    no more #_PB.
;10/04/91 alice window-save-file  supersedes 
;10/04/91 alice fred-update doesn't set-control-value for hscroll any more (hmax is too slow)
;10/01/91 alice window-menu-item - make check-marks in windows menu be cool for read-only buffers
;09/26/91 alice window-can-do-operation gets the item too in case it wants to f with the title
;09/26/91 alice fred-update and view-control-click-event-handler - fix horizontal scroll
;------------- 2.0b3
;09/04/91 bill  no more fred-update in stream-write-string
;09/03/91 alice view-key-event-handler for fred-mixin might update *edit-menu*
;08/27/91 alice mis parens in window-can-do-op
;08/24/91 gb   use new traps.
;08/12/91 bill stream-eofp for fred-mixin.
;08/09/91 bill quadruple click = select-all
;07/13/91 bill window-save-copy-as needed to specify :host to make-pathname.
;              Otherwise the host came from *default-pathname-defaults*
;08/13/91 alice window-can-do-op also deal with search, undo calls  maybe-update-debutton
;08/12/91 alice cut/clear/paste look upward to perhaps update default button, select-all iff some text
;08/02/91 alice view-save-position mod for new %path-to-iopb
;07/29/91 alice undo doesn't save on killed strings (makes too much noise if undo a replace-rest)
;07/29/91 alice fix ultimate cursor pos (= unchanged) in c-o, replace-with-undo takes append-p arg
;07/23/91 alice window-enqueue-region is a method again
;07/21/91 alice ed-forward/backward-word return pos, fixed glitch in cut
;07/21/91 gb   know that you know about read-only buffers.  Use DYNAMIC-EXTENT
;              vice DOWNWARD-FUNCTION.
;07/19/91 alice cut, copy, paste, clear are conditional - need to change inspector too?
;07/15/91 alice ed-delete-with-undo third arg can be a string (for undo), nuke style arg to ed-insert-with-undo
;		fred-history-length is a slot in fred-mixin, default is *fred-history-length*, overridden in listener
;07/15/91 alice insert-with-history => insert-with-undo ditto replace-with
;07/10/91 alice make-hist => make-fred-history, collapse-selection option :dont move cursor
;07/09/91 alice window-eval-selection 1) don't move cursor 2) nuke selection 3) update
;07/08/91 alice move some initialization for history from fred-window to fred-mixin
;07/08/91 bill set-selection-range no longer replaced by fred-misc.lisp
;07/05/91 bill remove an extraneous ed-beep
;07/03/91 bill fred-hpos calls frec-screen-hpos vice frec-hpos
;06/27/91 bill window-eval-selection passes single-selection? & evalp to
;              window-enqueue-region
;06/26/91 alice new-window-title - dont say :end2 > length str2
;		window-eval-selection - stop bouncing the window around
;------------- 2.0b2
;05/29/91 bill fred-initialize calls reparse-modeline vice doing it in-line
;05/28/91 bill new-window-title
;05/08/91 bill I like my ed-indent-for-lisp fix better
;05/06/91 bill Call *fred-keystroke-hook*
;04/25/91 bill window-revert includes the file name in the confirmation dialog.
;              interactive-arglist inserts the space before looking for symbol.
;05/03/91 alice ed-delete-with-undo - history pos (min start end), nuke some unused slots
;05/03/91 alice prefix-numeric-value => fred-prefix-numeric-value
;05/01/91 alice select iff shift key & no command key (not if caps lock)
;04/29/91 alice ed-kill-line - fencepost if 1 non wsp on line
;04/26/91 alice window-revert clears edit history
;04/24/91 alice change undo such that if anyone adds an "undo ignorant" command, undo wont make hash of
;  		ones buffer (instead it will not undo past the bogus command). Of course it can
;		still fail if an undo doesnt insert/delete the right number of characters.
;04/22/91 alice fix ed-indent-for-lisp when preceding cr( is inside  #||#, also empty line
;04/21/91 alice ed-undo-1 set cursor, undo undo-next show cursor, delete-n failed at 0
;04/18/91 alice added history and new undo stuff
;04/16/91 alice Copy - don't unless selection, next & previous list can select
;04/05/91 alice fix c-m-o
;03/26/91 alice c-m-l errored with c-u
;03/25/91 alice c-m-b and c-m-f puked at limits (new bug)
;03/22/91 alice c-m-) was broken
;03/29/91 bill frec-extend-selection sorts its beg and end args. No it doesn't
;03/21/91 bill Update for using _DrawGrowIcon for window-draw-grow-icon
;03/11/91 bill brain-damage in run-fred-command
;              in window-make-parts, fred-window scroll bars are initially
;              deactivated in case the window is shown as not the front window
;03/08/91 bill UNDO clears the undo-function so that it can be GC'd.
;02/22/91 bill don't show the cursor after window-save.
;02/13/91 bill Correctly handle title updating for all windows sharing a common buffer
;02/12/91 bill new buffer reference counting means save-buffer-p doesn't have to always
;              happen when a fred-mixin is given an explicit buffer.
;              window-enqueue-region does stream-close to force unuse-buffer.
;02/08/91 bill set-view-size-internal needed to run with-focused-view
;03/20/91 alice shadowing-comtab is in fred-mixin
;03/20/91 alice run-fred-command, add special *prefix-command-p* so prefix doesnt step on
;         last command allowing e.g. c-3 c-k c-4 c-k to work!
;03/19/91 alice add shift => select to some but not all motion commands
;03/18/91 alice add ed-forward & backward select-word & char on shift arrow keys
;03/18/91 alice fix c-tab, move when selection except c-b, c-f and left, right arrows
;03/15/91 alice c-m-p, c-m-n dont loop forever if no more
;03/13/91 alice added c-tab
;03/11/91 alice add c-m-n, c-m-p, c-m-u, c-m-), c-m-d. c-m-f expr end to window bottom
;03/11/91 alice add ed-last-buffer <= c-m-l
;03/08/91 alice ed-kill-line take numeric prefix
;03/05/91 alice report-bad-arg gets 2 args
;02/28/91 alice set-view-size-internal from patch 2.0b1p1
;--------- 2.0b1
;01/29/91 bill in keystroke-functions, allow the comtab to be a function.
;01/28/91 bill A couple of cosmetic changes.
;01/18/91 bill set-fred-last-command no longer a :writer (wrong arg order)
;01/15/91 bill add $UpdatEvt to *shadowing-comtab-eventhook*'s list of OK events.
;11/27/90 bill menukey-event-p -> menukey-modifiers-p
;11/01/90 bill (slot-value w 'last-command) -> (fred-last-command w)
;         bill (slot-value w 'prefix-argument) -> (fred-prefix-argument w)
;              *last-command* bound globally to NIL so that editor functions can be
;              called outside of the run-fred-command context
;10/31/90 bill Remove saving and restoring of used resource file: bug was in l1-edbuf.
;10/24/90 bill C-M-click in a fred-mixin does ed-edit-definitionz
;10/23/90 bill remove window-draw-grow-icon: use the one for WINDOW
;10/18/90 bill fred-delete-with-undo obeys fred-copy-styles-p
;01/01/90 bill remove some slot-value's
;09/27/90 bill view-save-position takes a preserve-file-info-p parameter.
;              window-close uses it, *save-position-on-window-close*
;09/21/90 bill in run-fred-command: add frec-delay-cursor-off
;              ed-push-mark in ed-beginning-of-buffer & ed-end-of-buffer.
;              (slot-value w 'frec) -> (frec w)
;09/20/90 bill preserve the used resource file.
;08/16/90 gb   no more %str-length.
;08/22/90 alice window-eval-selection take it from the front too.
;09/18/90 bill (method stream-force-output (mini-buffer))
;09/16/90 bill mini-buffer-push, mini-buffer-pop
;09/10/90 bill in (method stream-tyo fred-mixin): args reveresed to buffer-insert
;09/07/90 bill stream-position for fred-mixin, stream-tyi-function-and-arg
;09/05/90 bill fred-hscroll, set-fred-hscroll
;08/28/90 joe  removed specializations of view-default-position & view-default-size.
;              changed view-restore-position to use view-default-position method
;              instead of *fred-window-position*
;08/23/90 bill Added dont-prompt optional arg to window-revert,
;              shortest-package-nickname for mini-buffer output.
;              Add SCROLLING arg to window-show-cursor
;08/23/90 bill fred-start-mark -> fred-display-start-mark,
;              set-fred-display-start-mark
;08/17/90 bill window-revert reparses the modeline.
;08/13/90 alms window-selection-stream allows NIL filename 
;08/07/90 bill fred-tabcount,
;              *default-save-as-directory* -> (default-choose-file-directory)
;08/01/90 bill set-view-size-internal invalidates controls
;07/30/90 bill view-font-codes returns the font of the current char, not
;              the insertion font.
;07/30/90 bill fred-auto-purge-fonts-p, :auto-purge-fonts-p initarg
;07/26/90 bill Obey view-font in fred-initialize
;07/25/90 bill "Save Copy As…" now creates new name like System 7.
;              view-font-codes for fred-mixin.
;07/23/90 bill *clear-mini-buffer*
;07/05/90 bill nix wptr-if-bound
;              buffer-insert-string -> buffer-insert-substring
;07/03/90 bill Fix to eval-buffer then close window crashing the machine.
;06/25/90 bill fred-copy-styles-p
;06/13/90 bill stream-tyo requires a character second arg
;06/12/90 bill delete view-needs-saving-p,
;              window-point-position -> fred-point-position,
;              window-update -> fred-update, window-hpos -> fred-hpos,
;              add fred-vpos & fred-line-vpos, window-buffer -> fred-buffer,
;              window-start-mark -> fred-start-mark
;06/05/90 bill set-view-font -> set-view-font-codes for fred-mixin.
;06/05/90 bill Can't use VARG inside of with-focused-view anymore.
;              lap-inline -> old-lap-inline
;              with-new-full-port -> with-focused-view.
;06/04/90 bill in choose-**-dialog: :deafult -> :directory.
;05/28/90 gb   Don't use %move-vect in set-window-title.
;05/24/90 bill Only activate a fred-window when in the *foreground*
;              window-position, window-size -> view-position, view-size
;05/23/90 bill Fix (:method window-invalidate-controls :before (fred-window))
;05/05/90 bill update for new scrap handler.
;04/11/90 gz   Some ed-xxx fns renamed to buffer-xxx.
;              word-chars -> *fred-word-constituents*.
;              be more careful in pathname-to-window-title.
;04/04/90 gz   pathname-directory -> directory-namestring.
;04/30/90 gb   window-save-copy-as fix per gz.
;04/26/90 bill fred-last-command & set-fred-last-command.
;04/23/90 bill keep track of window-active-p in view-activate-event-handler
;              and view-deactivate-event-handler for fred-window
;04/16/90 bill window-update in (method fred-window :after initialize-instance)
;              to set the scroll bar position.
;03/20/90 bill initialize-instance => instance-initialize.
;03/15/90      remove window-update from view-activate-event-handler &
;              view-deactivate-event-handler for fred-window & fred-mixin.
;04/03/90 gz   Allow no directory component in pathname-to-window-title.
;         bill remove-shadowing-comtab before running command.
;03/06/90 bill install-shadowing-comtab handles a non-list comtab
;              (so it will work inside of MODAL-DIALOG.
;03/05/90 bill window-key-event-handler => view-key-event-handler
;03/01/90 bill view-buffer => fred-buffer, view-package => fred-package,
;              view-font => fred-font, view-start-mark => fred-start-mark
;              added fred-text-edit-sel-p, fred-wrap-p, fred-chunk-size.
;              Body of (:method initialize-instance :after (fred-mixin))
;              becomes fred-initialize.
;02/28/90 bill window-save-as used to error out on trying to save a buffer
;              that was last saved on an unmounted floppy.  Now it defaults
;              to *default-save-as-directory*
;02/23/90 bill Don't make fred-mixin slots unbound at window-close.
;              Add (:method (setf wptr) (t fred-mixin)) to kill-frec &
;              initialize-frec.
;02/21/90 gz   :buffer-chunk-size arg for fred-mixin initialize-instance.
;02/21/90 bill Add :text-edit-sel-p initarg to fred-mixin.
;02/20/90 bill with-port => with-focused-view.
;02/14/90 bill ed-delete-with-undo: add reverse-p arg to support ed-rubout-word.
;              make select-all go through set-selection-range to push a mark.
;              window-show-cursor: wrap with-focused-view around frec-show-cursor.
;2/13/90  gz   Always use require-type for value (it's (will be) a continuable error).
;              initialize-window :after method to reset file-modcnt, in case
;              view-restore-position changes it.
;01/20/90 gz   added interactive-stream-p.
;01/17/90 gz   clos-fred-track-... -> fred-track-...
;02/12/90 bill fred-window => fred-mixin to support fred-dialog-item.
;12/23/89 bill fix double drawing by (method window-draw-grow-icon (fred-window)):
;              (method window-draw-contents (fred-window)) draws the grow icon.
;              Lots of mods to keep the scroll-bar outlines from being erased.
;12/20/89 bill alms's patch to *remove-shadowing-comtab-eventhook* adds key-up to
;              events that don't remove the shadowing comtab.
;12/11/89 bill (method window-make-parts (fred-window)): remember merged pathname components
;12/08/89 bill Mly's mod to print "(Deleted Package!)" in the mode-line
;11/27/89 bill Move code from in-line in window-restore-position to
;              window-ensure-on-screen. Make it work (the structure & content
;              regions of a window are not valid until it is shown).
;10/31/89 bill  window-save-as use (pathname-type *.lisp-pathname*)
;10/15/89 as  window-save-as et al use *.lisp-pathname*
;10/03/89 gz  initialize-window :after method to reset file-modcnt.
;9/29/89 as   fix to window-save-copy-as
;09/28/89 bill Add (method stream-write-string (fred-window))
;09/27/89 gb simple-string -> ensure-simple-string.
;09/20/89 bill Fix font initialization problem in window-make-parts
;9/16/89 bill Removed last vestiges of object-lisp
;9/13/89 bill Fix menu strings to undo & redo Cut.
;9/12/89 bill Start conversion to CLOS
;9/10/89  gz  be even more careful in window-title (I do wish there was
;             some general mechanism to simply avoid calling any of a selected
;             set of methods on closed windows, instead of zillions functions
;             individually checking for that case...).
;             :|CCL | -> :|CCL2| in window-save-as.
;09/08/89 bill in window-title: check for wptr bound before referencing it.
;08/29/89 gz  mark-ring instance var,  *mark-ring-length*.
;             Clear mini-buffer at start of each command.
;             prefix-argument support in run-fred-command.
;             Handle prefix args in some commands.
;07/20/89 gz  clos menus, window-[save/revert] => window-object-*.
;7/7/89 bill  Add window-set-not-modified
;05/19/89 gz window-update-cursor -> window-object-update-cursor.
;            window-update -> window-object-update.
;04/07/89 gb  $sp8 -> $sp.
;04/01/89  gz New defpascal syntax.
;03/18/89  gz window-foo -> window-object-foo.
;03/12/89  gz CLOS mini-buffer.
;14-apr-89 as interactive-arglist
;9-apr-89  as removed get-next-key-event
;2-apr-89  as save-copy-as
;             pathname-to-window-title puts filename first
;12/30/88  gz New buffers.  stream-filename. New eval-selection scheme.
;12/16/88  gz ed-lquoted-p -> buffer-lquoted-p
;             :supersede -> :overwrite in window-save-file.
;             Use %open-res-file.
;12/11/88  gz mark-position -> buffer-position
;12/10/88  gb  stack discipline in window-make-parts.
;11/26/88  gz  New implementation.
;11/20/88  gz  Moved all edwin/window-related stuff here, buffer stuff to l1-edcmd.
; 9/10/88 gz  tb8$ -> tb$
; 8/29/88 gz  full-namestring -> mac-namestring
; 8/21/88 gz  declarations.
; 7/26/88  gz  Merged 1.2, added unwind-protects in window-restore/save-position
; 7/11/88 jaj if error occurs in buffer-first-in-package signals a continuable
;             error.
; 7/8/88  as  buffer-first-in-package evals in-package form.
; 6/27/88 jaj fixed window-restore-position
; 6/26/88 jaj fixed reserrchk
; 6/21/88 jaj catch :error -> catch-error
; 6/14/88 as  mini-buffer-update does a without-interrupts
; 6/10/88 as  window-font returns three values
;             set-window-font returns nil
; 6/8/88  as  window-save-as forces Allegro CL file types
; 6/8/88  jaj mini-buffer-update clips to larger rect. make sure string to
;             set-window-title is a simple-string
; 6/7/88  jaj window-[save/restore]-position no longer set default font in
;             MPSR resource. done in buffer-[insert/write]-file
; 6/6/88  jaj window-restore-position checks to see if title bar intersects
;             GrayRgn, if not sets position to *fred-window-position*
;             added window-selection-string
; 6/02/88 as  buffer-first-in-package gets (in-package 'mumble) right
;             set-minibuffer "" when opening window
; 5/31/88 as  edwin-ctlh coded inline
;             %error -> :error
; 5/29/88 as  set-window-size/position put new size/pos in minibuffer
; 5/27/88 jaj fixed clicking in mini-buffer
; 5/22/88 as  window-eval-selection/whole buffer record source window
; 5/20/88 as  new y-or-n-dialog calling sequence
; 5/20/88 jaj windows save and restore current insertion font
; 5/17/88 as  mini-buffers are streams
;             mini-buffer-update checks to make sure window still exists
;             window-save-fonts -> window-save-position
;             window-restore-fonts -> window-restore-position
; 5/13/88 as  window-eval-selection/whole-buffer use mini-buffer
;             (proclaim '(instance-variable *fred-window * . . .))
; 5/12/88 as  window-save uses mini-buffer and watch-cursor
;             make-window-parts sets mini-buffer to package
;             mini-buffer-update does _EraseRect
; 5/10/88 jaj added mini-buffers
; 4/4/88  as  opens windows even if old sizing info is bad
;             new versions of set-window-font and window-font
; 3/30/88 jaj kerwordified rlet
; 3/25/88 jaj new style format
; 3/10/88 jaj remember fonts, window position etc.
; 3/9/88  jaj added undo-style instance variable

; 3/30/88 gz  New macptr scheme.  Flushed pre-1.0 edit history.
; 3/2/88  gz  Eliminate compiler warnings.
;01/28/88 as  new window-click-event-handler works better for double-click-drag
;10/25/87 jaj do a buffer-search for "in-package" to speed up buffer-first-in
;             package for most cases.
;10/16/87 jaj added buffer-first-in-package, called by window-make-parts
;10/16/87 as  window-save-as inserts escape characters (uggh!)
;             set-window-filename retains escape characters
;10/15/87 cfry *ibeam-cursor -> *i-beam-cursor*
;10/14/87 jaj bind *package* around window-eval-[selection/whole-buffer]
; 9/29/87 as  window-eval-whole-buffer no longer scrolls to bottom of buffer
;             window-eval-selection uses let* rather than let
; 9/08/87 as  set-window-font merges partial font-spec with current font values
;------------------------------release 1.0---------------------------------

(eval-when (:compile-toplevel :execute)
(require "FREDENV")
)

(defparameter *listener-history-length* 2)

;Dummy macro to replace without-interrupts for debugging
#-bccl (defvar *my-without-interrupts-enabled* t)
#-bccl (defmacro my-without-interrupts (&body body)
  (let ((f (gensym)))
    `(flet ((,f () ,@body))
       (if *my-without-interrupts-enabled*
         (without-interrupts (,f))
         (,f)))))
#+bccl (defmacro my-without-interrupts (&body body) `(without-interrupts ,@body))

; A fred-mixin must be mixed with a simple-view (or view, or window) in order to work.
; key-handler-mixin probably needs to be included also.
(defclass fred-mixin ()
  ((comtab :initarg :comtab :initform *comtab* :accessor fred-comtab)   ; used to be a class var   
   (my-file-name :initform nil)
   (file-modcnt :initform t :accessor file-modcnt)	; default to no saving. See initialize-fred-mixin
   (last-command :initform nil :accessor fred-last-command)
   (goal-column :initform nil)
   ;(undo-modcnt :initform nil)	; not used
   ;(undo-function :initform nil)	; no longer used
   ;(undo-string :initform nil)
   ;(undo-style :initform nil)	; not used
   ;(undo-redo :initform nil :reader fred-undo-redo)
   ;(fred-history :initform nil :reader fred-history)
   (mark-ring :initform nil)
   (prefix-argument :initform nil :accessor fred-prefix-argument)
   ;(defs-dialog :initform nil)
   (comment-column :initform 40)
   (comment-start :initform "; ")
   (frec :accessor frec :initform nil)
   (save-buffer-p :initform nil :accessor fred-save-buffer-p)
   (copy-styles-p :initarg :copy-styles-p :initform nil
                  :accessor fred-copy-styles-p)
   (shadowing-comtab :initform nil :accessor fred-shadowing-comtab)
   (color-list :initarg :part-color-list :initform nil
               :accessor part-color-list)
   ;(history-length :initarg :history-length :initform *fred-history-length*)
   )
  (:default-initargs
    :history-length *fred-history-length*))



(defmethod part-color ((item fred-mixin) key)
  (getf (slot-value item 'color-list) key nil))

(defmethod fred-history ((view fred-mixin))  
  (bf.fred-history (mark-buffer (fred-buffer view))))

(defmethod fred-undo-redo ((view fred-mixin))  
  (bf.undo-redo (mark-buffer (fred-buffer view))))

(defmethod fred-undo-string (view)  
  (bf.undo-string (mark-buffer (fred-buffer view))))

; tells the edit menu whether to say undo or redo
(defun set-fred-undo-redo (w value)
  (setf (bf.undo-redo (mark-buffer (fred-buffer w))) value))

(defun set-fred-history (w value)
  (setf (bf.fred-history (mark-buffer (fred-buffer w))) value))

(defun set-fred-undo-stuff (w last-command undo-string)  
  (set-fred-last-command w last-command)
  (set-real-fred-undo-string w undo-string)
  (set-fred-undo-redo w :undo))

(defun set-fred-undo-string (w string &optional ur)  
  (set-real-fred-undo-string w  string)
  (set-fred-undo-redo w (or ur :undo)))

(defun set-real-fred-undo-string (w string)
  (setf (bf.undo-string (mark.buffer (fred-buffer w))) string))


(defmethod set-fred-last-command ((view fred-mixin) value)
  (setf (fred-last-command view) value))

(defvar *dead-keys-state* t)

(defparameter *dead-keys-state-when-qcomtab-installed* *dead-keys-state*)
(defparameter *control-q-with-dead-keys-enabled* t)

(defmethod set-fred-shadowing-comtab ((view fred-mixin) value)
  (when (and *control-q-with-dead-keys-enabled* (eq (fred-shadowing-comtab view) *control-q-comtab*))
    (when (neq *dead-keys-state* *dead-keys-state-when-qcomtab-installed*)
      (set-dead-keys *dead-keys-state-when-qcomtab-installed*)))
  (setf (fred-shadowing-comtab view) value))


(defmethod fred-auto-purge-fonts-p ((w fred-mixin) &optional 
                                    (new-value nil new-value-p))
  (let ((buf (fred-buffer w)))
    (if new-value-p
      (buffer-purge-fonts-p buf new-value)
      (buffer-purge-fonts-p buf))))

(defmethod fred-update ((fred fred-mixin))
  (let* ((frec (frec fred)))    
    (with-focused-view fred        
      (with-text-colors fred
        (frec-update frec)))))

(defmethod toggle-blinkers ((item fred-mixin) on-p)
  (without-interrupts
   (let ((frec (frec item)))
     (with-focused-view item
       (if on-p (frec-activate frec) (frec-deactivate frec))
       (frec-update frec t)))))

(defvar *default-editor-class* 'fred-window)

(defvar *last-command* nil)
(defvar *show-cursor-p*)
(defvar *current-character*)
(defvar *current-keystroke*)
;(defvar *shadowing-comtab* nil)
(defvar *prefix-comtab-installed* nil)

(defvar *mark-ring-length* 17)

;; set this to t if you want meta-. etal to try to do dtrt with "unix" files
(defparameter *do-unix-hack* nil)

#|
(defmethod instance-initialize :before ((w fred-mixin) &rest initargs)
  (declare (dynamic-extent initargs))
  (apply #'fred-initialize w initargs))

(defmethod instance-initialize :after ((w fred-mixin) &rest initargs)
  (when (fixnump (file-modcnt w))
    (setf (file-modcnt w) (buffer-modcnt (fred-buffer w))))
  (fred-update w)                    ; update scroll bar position
  (when (fboundp 'update-recent-files) (apply 'update-recent-files initargs)))
|#

(defmethod initialize-instance :after ((w fred-mixin) &rest initargs ; &key &allow-other-keys)  ;; ugh  
                                       &key buffer-chunk-size
                                       buffer
                                       save-buffer-p
                                       history-length
                                       auto-purge-fonts-p
                                       text-edit-sel-p
                                       margin draw-outline
                                       filename package wrap-p
                                       word-wrap-p justification
                                       line-right-p )
  (declare (dynamic-extent initargs))
  (declare (ignore buffer-chunk-size buffer save-buffer-p history-length
                   auto-purge-fonts-p text-edit-sel-p margin draw-outline  package wrap-p
                   word-wrap-p justification line-right-p))
  (apply #'fred-initialize w initargs)
  (when (fixnump (file-modcnt w))
    (setf (file-modcnt w) (buffer-modcnt (fred-buffer w))))
  (fred-update w)                    ; update scroll bar position
  (when (and (fboundp 'update-recent-files) filename) (update-recent-files :filename filename)))

(defgeneric fred-initialize (fred-mixin &key &allow-other-keys))

; Split off because the interface designer calls this.
(defmethod fred-initialize ((w fred-mixin)
                            &key
                            (view-font *fred-default-font-spec*)
                            (buffer-chunk-size #x1000)
                            buffer
                            save-buffer-p
                            history-length
                            (auto-purge-fonts-p t)
                            text-edit-sel-p
                            margin
                            filename package wrap-p
                            word-wrap-p justification
                            (line-right-p nil line-right-p-p)
                            ;; wptr
                            view-size
                            &aux frec file)
  ;If both :BUFFER and :FILENAME are specified, the buffer is erased before the
  ; file is inserted.
  ; :PACKAGE means associate package with buffer
  ; :WRAP-P means wrap display at right.
  ;(declare (ignore wptr)) ; << ??
  (if (not buffer)
    (progn
      (setq buffer (make-buffer :chunk-size
                              buffer-chunk-size
                              :font (or view-font *fred-default-font-spec*)
                              :owner nil))
      (setf (bf.refcount (mark-buffer buffer)) 0)
      (setf (bf.fred-history (mark-buffer buffer)) (make-fred-history history-length)))
    (setq buffer (require-type buffer 'buffer-mark)))
  (setf (fred-save-buffer-p w) save-buffer-p)
  (when (null (fred-comtab w))(setf (fred-comtab w) (default-comtab w)))
  (buffer-purge-fonts-p buffer auto-purge-fonts-p)  
  (when (setq file filename)
    (or (probe-file file)
        (progn 
          (setq file (merge-pathnames file *.lisp-pathname*))
          (probe-file file))
        (signal-file-error $err-no-file file))
    ;(setq file (back-translate-pathname file))  ;; ??
    (buffer-delete buffer 0 t)
    (buffer-insert-file buffer file)
    (set-mark buffer 0))  
  (setf (file-modcnt w) (and file (buffer-modcnt buffer)))
  ; provided wrap stuff can override file info but always provided by window-make-parts - phooey
  ; so it only overrides if true
  (when word-wrap-p
    (setf (buffer-word-wrap-p buffer) t)
    (setf (buffer-wrap-p buffer) t))
  (when wrap-p
    (setf (buffer-wrap-p buffer) t))  
  (when line-right-p-p
    (setf (buffer-line-right-p buffer) line-right-p))
  (when justification
    (setf (buffer-justification buffer) justification))
  (setf (frec w)
        (setq frec (make-frec buffer w (or view-size #@(0 0)))))
  (when text-edit-sel-p (setf (fr.text-edit-sel-p frec) t))
  (when margin (setf (fr.margin frec) margin))
  ;(setf (slot-value w 'my-file-name) file)
  ;(set-window-filename w file) ; too soon for this
  
  (if package
    (set-fred-package w package)
    (if file 
      (reparse-modeline w t)
      ;(set-fred-package w *package*)  ; bad idea
      )))

;;(def-aux-init-functions fred-mixin #'fred-initialize)

(defmethod fred-text-edit-sel-p ((w fred-mixin))
  (fr.text-edit-sel-p (frec w)))


; This doesn't refresh the screen. Maybe it should.
(defmethod (setf fred-text-edit-sel-p) (value (w fred-mixin))
  (let ((frec (frec w)))
    (if value
      (setf (fr.text-edit-sel-p frec) t)
      (setf (fr.text-edit-sel-p frec) nil))))

(defmethod fred-wrap-p ((w fred-mixin))
  (fr.wrap-p (frec w)))

; Maybe this should update the screen, too.
; maybe nil should also set word-wrap-p
(defmethod (setf fred-wrap-p) (value (w fred-mixin))
  (let* ((frec (frec w))
         (old (fr.wrap-p frec))
         (buffer (fr.cursor frec)))
    (when (neq value old)       
      (setf (buffer-wrap-p buffer) value)
      (when (null value)(setf (buffer-word-wrap-p buffer) nil))
      (if value
        (setf (fr.wrap-p frec) t)
        (setf (fr.wrap-p frec) nil
              (fr.word-wrap-p frec) nil))
      (setf (fr.bmod frec)(fr.bwin frec)
            (fr.zmod frec)(fr.zwin frec))
      (do-all-frecs other
        (when (and (neq other frec)(eq (fr.cursor other) buffer)) 
          (setf (fr.wrap-p other) value)
          (when (null value)(setf (fr.word-wrap-p other) nil))
          (setf (fr.bmod other)(fr.bwin other)
                (fr.zmod other) 0)))
     (fred-update w)) 
    value))

(defmethod fred-word-wrap-p ((w fred-mixin))
  (fr.word-wrap-p (frec w)))

(defmethod (setf fred-word-wrap-p) (value (w fred-mixin))  
  (let* ((frec (frec w))
         (old (fr.word-wrap-p frec))
         (buffer (fr.cursor frec)))    
    (when (neq value old)
      (let ((parent (view-container w)))
        (when (typep parent 'scrolling-fred-view)
          (let ((bar (find-subview-of-type  parent 'fred-h-scroll-bar)))
            (when bar
              (if (eq value t)
                (progn (set-fred-hscroll w 0)
                       (dialog-item-disable bar))
                (dialog-item-enable bar))))))
      (setf (buffer-word-wrap-p buffer) value) ; do first in case read-only
      (setf (buffer-wrap-p buffer) value)
      (setf (fr.bmod frec)(fr.bwin frec)
            (fr.zmod frec)(fr.zwin frec))
      (if value
        (setf (fr.wrap-p frec) t
              (fr.word-wrap-p frec) t)
        (setf (fr.wrap-p frec) nil
              (fr.word-wrap-p frec) nil))
      (do-all-frecs other
        (when (and (neq other frec) (eq (fr.cursor other) buffer))
          (setf (fr.word-wrap-p other) value)
          (setf (fr.wrap-p other) value)
          (setf (fr.bmod other)(fr.bwin other)
                (fr.zmod other) 0)))
      (fred-update w)))
    value)

(defmethod fred-justification ((w fred-mixin))
  (frec-justification (frec w)))

(defmethod (setf fred-justification) (new-just (w fred-mixin))
  (%set-frec-justification (frec w) new-just))

(defmethod fred-line-right-p ((w fred-mixin))
  (fr.line-right-p (frec w)))

(defmethod (setf fred-line-right-p) (new-lrp (w fred-mixin))
  (setf (fr.line-right-p (frec w)) new-lrp))

(defmethod fred-chunk-size ((w fred-mixin))
  (bf.chunksz (mark.buffer (fred-buffer w))))

(defmethod fred-tabcount ((w fred-mixin))
  (fr.tabcount (frec w)))

; simpler to just make it be property of buffer??
(defmethod (setf fred-tabcount) (value (w fred-mixin))
  (flet ((update (w frec tabcount)
           (setf (fr.tabcount frec) tabcount)
           (when w
             (with-focused-view w
               (frec-draw-contents frec t)
               (fred-update w)))))    
    (let* ((buf (fred-buffer w))
           (mapper #'(lambda (frec)
                       (when (same-buffer-p buf (fr.cursor frec))
                         (update (fr.owner frec) frec value)))))
      (declare (dynamic-extent mapper))
      (unless (eql value (buffer-tabcount buf))
        (when (%buffer-read-only-p buf)
          (%buf-signal-read-only))
        (setf (buffer-tabcount buf) value)
        (map-frecs mapper)))))

#|
(defmethod (setf fred-tabcount) (value (w fred-mixin))
  (setf (fr.tabcount (frec w)) value))
|#


(defun new-window-title (&optional (prefix "New"))
  (let ((index (new-window-number prefix)))
    (if (eql 0 index)
      prefix
      (format nil "~a ~d" prefix index))))

(defun new-window-number (&optional (prefix "New"))
  (let ((index 0)
        (len (length prefix))
        pos)
    (declare (fixnum index len))
    (do-all-windows w
      (let ((title (window-title w)))
        (when (and (not (typep title 'encoded-string))(>= (length title) len)(string-equal prefix title :end2 len))
          (let ((i (if (or (eql len (length title)) 
                           ;(not (eql #\space (char title len)))
                           )
                     0
                     (multiple-value-bind (val idx)
                                          (parse-integer title :start (1+ len)
                                                         :junk-allowed t)
                       (if (eql idx (length title))
                         val
                         -1)))))
            (declare (fixnum i))
            (when (>= i index) (setq index (1+ i))(setq pos (view-position w)))))))
    (values index pos)))


(defvar *save-position-on-window-close* nil)
(defvar *defs-dialogs* nil)


(defmethod (setf wptr) :after (wptr (w fred-mixin))
  (let ((frec (frec w)))
    (when frec
      (if wptr
        (reinit-frec frec wptr w)
        (let ((save-buffer-p (fred-save-buffer-p w)))
          (unless save-buffer-p
            (setf (slot-value w 'mark-ring) nil))
          (kill-frec frec save-buffer-p))))))


#+ignore
(defmethod view-activate-event-handler ((w fred-mixin))
  (without-interrupts
   (let ((frec (frec w)))
     (with-focused-view w
       (with-text-colors w
         (frec-activate frec)
         ; draw the thing now before frec idle happens giving us half caret -
         ; but only draw now if has no selection - no-drawing if sel avoids hilighting sel rgn twice
         (frec-update frec (frec-selp frec)))))))
         ;(frec-update frec t))))))         ; redraw selection box

; This seems to fix the window update problem when window-background-colors are in use.
; I noticed that it didn't seem to be a problem with windows that were saved with a selection
; region. So I eliminated the call to frec-selp.

(defmethod view-activate-event-handler ((w fred-mixin))
  (without-interrupts
   (let ((frec (frec w)))
     (with-focused-view w
       (with-text-colors w
         (frec-activate frec)
         ; draw the thing now before frec idle happens giving us half caret -
         ; but only draw now if has no selection - no-drawing if sel avoids hilighting sel rgn twice
         (frec-update frec #+CARBON-COMPAT22 t #-CARBON-COMPAT22 (frec-selp frec))
         ))))
  (if t #|(osx-p)|# (invalidate-view w)) ; this seems to be necessary in OSX
  )


(defmethod view-deactivate-event-handler ((w fred-mixin))
  (without-interrupts
   (let ((frec (frec w)))
     (with-focused-view w
       (with-text-colors w
         (frec-deactivate frec)
         (frec-update frec t))))))



; HANDLE is a Mac scroll bar.
; Expects the scroll bar's container to be already focused.
#|
(defun hide-scroll-bar (handle)
  (let* ((tl (rref handle :controlrecord.contrlrect.topLeft))
         (br (rref handle :controlrecord.contrlrect.botRight)))
    (rlet ((rect :rect
                 :topLeft (add-points tl #@(1 1))
                 :botRight (subtract-points br #@(1 1))))
      (with-clip-rect rect
        (#_HideControl handle)))))
|#

(defmethod view-cursor ((w fred-mixin) point)
  (let* ((c (call-next-method))
         (frec (frec w)))
    (if (and (eq c *i-beam-cursor*)(frec-up-to-date-p frec))
      (with-font-codes nil nil
        (frec-cursor (frec w) point))
      c)))





#|
(defun draw-scroll-bar-outline (handle)
  (let* ((tl (rref handle :controlrecord.contrlrect.topLeft))
         (br (rref handle :controlrecord.contrlrect.botRight)))
    (rlet ((rect :rect :topLeft tl :botRight br))
      (#_FrameRect rect))))
|#



; Prevent (method instance-initialize :after (simple-view)) from messing
; with my font.
(defmethod set-initial-view-font ((w fred-mixin) font-spec)
  (declare (ignore font-spec)))

; returns the font of the next insertion - does not consider last-command 
(defmethod view-font-codes ((w fred-mixin))
  (let* ((buf (fred-buffer w))
        (index (buffer-insert-font-index buf)))
    (if index  ; if empty empty-font else insert-font else nil
      (buffer-font-index-codes buf index)    
      (multiple-value-bind (b e) (frec-get-sel (frec w))
        (if (or (neq b e) (eq b 0)(char-eolp  (buffer-char buf (1- b))))
          (buffer-char-font-codes buf b)
          (buffer-char-font-codes buf (1- b)))))))

; If bufffer empty set font to use in an empty buffer.
; Else set font to use for next insertion
(defmethod set-view-font-codes ((w fred-mixin) ff ms &optional ff-mask ms-mask)
  (declare (ignore ff-mask ms-mask))
  (let ((buf (fred-buffer w)))
    (if (and ff ms)
      (buffer-set-font-codes buf ff ms)
      (set-buffer-insert-font-index buf nil))))

; New function.
; do the right thing if multiple fonts in selection. The manual said it (set-view-font) did. For once the
; documentation was more correct than the implementation.
; Intended to be called from the font menu or fred. If selection, changes font of selection, otherwise affects
; the font of the next character typed as long as there are no intervening fred commands other
; than self-insert or font setting.

(defmethod ed-setting-font-p ((w fred-mixin))
  (let ((lc (or *last-command* (fred-last-command w))))
    (if (and (consp lc)(eq (%car lc) 'set-font))
      (values (cadr lc) (caddr lc) lc))))

(defmethod ed-set-view-font ((w fred-mixin) font-spec)  
  (let ((mark (fred-buffer w))
        (frec (frec w)))
    (flet ((frec-key-script (frec ff)
             (let ((script (ff-script ff)))
               (when (neq script (fr.keyscript frec))
                 (setf (fr.keyscript frec) script)
                 (set-key-script script)))))
      (declare (dynamic-extent frec-key-script))
      (multiple-value-bind (b e)(frec-get-sel frec)
        (if (eq b e)        
          (cond ((eq 0 (buffer-size mark))
                 (multiple-value-bind (ff ms) (buffer-empty-font-codes mark) ; gets codes of cfont
                   (multiple-value-bind (ff ms) (font-codes font-spec ff ms)
                     (frec-key-script frec ff)                   
                     (set-buffer-empty-font-codes mark ff ms))))  ; will set cfont - the one to use in an empty buffer
                (t (multiple-value-bind (oldff oldms lc)(ed-setting-font-p w)
                     (when (not oldff)
                       (multiple-value-setq (oldff oldms)
                         (buffer-char-font-codes 
                          mark (if (or (eq b 0)(char-eolp (buffer-char mark (- b 1))))
                                 b 
                                 (1- b)))))
                     (multiple-value-bind (ff ms)(font-codes font-spec oldff oldms)
                       (if (not lc)
                         (setf (fred-last-command w)(list 'set-font ff ms))
                         (rplaca (cdr (rplaca (cdr lc) ff)) ms))
                       (frec-key-script frec ff)
                       (set-buffer-insert-font-codes mark ff ms) ; 5/28
                       ))))
          (handler-bind
            ((modify-read-only-buffer
              #'(lambda (c)                                    
                  (declare (ignore c))
                  (if (null (buffer-whine-read-only w))
                    (return-from ed-set-view-font nil)
                    (return-from ed-set-view-font (ed-set-view-font w font-spec)))))) 
            (let* ((style (buffer-get-style mark b e)))
              (buffer-set-font-spec mark font-spec b e)
              (when (and (eq b 0)(eql e (buffer-size mark)))
                (multiple-value-bind (ff ms) (buffer-char-font-codes mark b)
                  (frec-key-script frec ff)
                  (set-buffer-empty-font-codes mark ff ms)))
              (ed-history-add w b (cons "" style))
              (set-fred-undo-string w "Font")
              (fred-update w))))
        font-spec))))

; considers last-command - which may specify the font of next insertion assuming no
; intervening gestures - this seems nutty - see comments at ed-set-view-font

(defmethod ed-view-font-codes ((w fred-mixin))
  (multiple-value-bind (ff ms)(ed-setting-font-p w)
    (if ff
      (values ff ms)
      (view-font-codes w))))

(defmethod ed-view-font-codes ((view simple-view))
  (view-font-codes view))

; no longer changes font of selection - use ed-set-view-font for that
; (why did i (akh) make this gratuitous lack of backward compatibility?
; well ed-set-view-font is undoable and this isnt)
; Set the font to be used for the next insertion. If font spec incomplete, will merge
; with that of buffer-font-codes - ie font for empty, next, or of pos-1 or pos

(defmethod set-view-font ((w fred-mixin) font-spec)
  (let* ((mark (fred-buffer w))
         ;(pos (buffer-position mark))
         )
    (if font-spec
      (multiple-value-bind (oldff oldms) (buffer-font-codes mark)
        (multiple-value-bind (ff ms)(font-codes font-spec oldff oldms)
          (set-view-font-codes w ff ms)))
      (set-view-font-codes w nil nil))))


(defmethod stream-filename ((w fred-mixin))
  (or ;(slot-value w 'my-file-name)  ;; lose that ??
      (buffer-filename (fred-buffer w))
      (let ((window (view-window w)))  ;; maybe lose this bit
        (and window (slot-exists-p window 'real-file-name)
             (slot-value window 'real-file-name)))))


(defmethod window-package ((w fred-mixin))
  (fred-package w))

; used by mini-buffer-update - or give fred-package an optional arg?
(defmethod sneaky-window-package ((w fred-mixin))
  (buffer-getprop (fred-buffer w) 'package))

(defmethod fred-package ((w fred-mixin))
  (let* ((buf (fred-buffer w))
         (pkg (buffer-getprop buf 'package)))
    (when (consp pkg)
      (set-fred-package w nil)
      (mini-buffer-update w) ; in case no modeline
      (setq pkg (reparse-modeline w)))
    pkg))

(defmethod set-window-package ((w fred-mixin) pkg)
  (set-fred-package w pkg))

; if pkg is a cons its car is the name of a non-existent package
(defmethod set-fred-package ((w fred-mixin) pkg)
  (buffer-putprop (fred-buffer w) 'package
                  (if (consp pkg)
                    pkg
                    (if pkg (pkg-arg pkg)))))

(defmethod fred-buffer ((w fred-mixin))
  (fr.cursor (frec-arg (frec w))))

(defmethod fred-display-start-mark ((w fred-mixin))
  (fr.wposm (frec-arg (frec w))))

(defmethod set-fred-display-start-mark ((fred fred-mixin) position &optional no-drawing)
  (let* ((frec (frec-arg (frec fred)))
         (mark (fred-display-start-mark fred)))
    (set-mark mark position) ; 3/25 foo ;(frec-screen-line-start frec position))
    (if no-drawing 
      (with-focused-view fred  ;  we need the right visrgn and updatergn even if no draw.
        (frec-update frec t))  ; scroll bars not updated either
      (fred-update fred))))

(defmethod fred-hscroll ((w fred-mixin))
  (fr.hscroll (frec-arg (frec w))))

(defmethod set-fred-hscroll ((w fred-mixin) hscroll)
  (frec-set-hscroll (frec w) (max 0 hscroll)))

(defmethod fred-margin ((w fred-mixin))
  (fr.margin (frec-arg (frec w))))

(defmethod set-fred-margin ((w fred-mixin) margin)
  (setq margin (require-type margin 'fixnum))
  (setf (fr.margin (frec-arg (frec w))) (max 0 margin)))

(defmethod selection-range ((w fred-mixin))
  (frec-get-sel (frec w)))

(defmethod set-selection-range ((w fred-mixin) &optional pos curpos)
  (let ((size (buffer-size (fred-buffer w))))
    (when (numberp pos) (setq pos (max 0 (min pos size))))
    (when (numberp curpos) (setq curpos (max 0 (min curpos size)))))
  (frec-set-sel (frec w) pos curpos))

(defmethod selectionp ((w fred-mixin))
  (multiple-value-bind (b e) (frec-get-sel (frec w))
    (neq b e)))

;Val can be either the value (>1) or fraction (<= 1).
;if max is specified, same as val/max except treats val=max=0 correctly.
#|
(defun %set-control-value (ctl val &optional max)
  (unless (>= val 0) (report-bad-arg val '(integer 0 *)))
  (let* ((cmin (rref ctl controlrecord.contrlmin))
         (cmax (rref ctl controlrecord.contrlmax)))
    (setq val
          (+ cmin
             (cond ((zerop val) 0)
                   (max (floor (* val (%i- cmax cmin)) max))
                   ((< val 1) (floor (* val (%i- cmax cmin))))
                   (t (round val)))))
    (when (> val cmax) (setq val cmax))
    (unless (eq (rref ctl controlrecord.contrlvalue) val)
      (#_SetControlValue ctl val))))
|#


;Do an update, scrolling if necessary in order to make pos visible
;Maybe call this window-pin-update?
; THIS IS A piece of crap - because frec-show-cursor calls frec-update
; without setting colors 
#|
(defmethod window-show-cursor ((w fred-mixin) &optional pos scrolling)
  (with-focused-view w    
    (frec-show-cursor (frec w) pos scrolling)
    (with-quieted-view w (fred-update w)))) ; ???
|#
; we need to make sense out of window-show-selection and window-show-cursor and we dont
; need both of them please.

(defmethod window-show-cursor ((w fred-mixin) &optional pos scrolling)
  (without-interrupts
   (with-focused-view w
     (with-text-colors w
       (fred-update w)  ; gets us dialog-item-action for fred-dialog-item
       ; but this is ok cause now the call to frec-update does nothing?
       (frec-show-cursor (frec w) pos scrolling)
       (let ((em (edit-menu)))
         (when (not (menu-enabled-p em))(menu-update em)))))))


(defmethod view-click-event-handler ((item fred-mixin) where)
  (with-focused-view item    
    (let ((my-dialog (view-window item)))
      (without-interrupts
       (if (neq item (current-key-handler my-dialog))
         (with-quieted-view item   ; prevents flashing (no flashers allowed)
           (set-current-key-handler my-dialog item nil))))
      (with-text-colors item
        (if (%i< *multi-click-count* 4)
          (with-timer (frec-click (frec item) where #'fred-update item))
          (select-all item))
        (set-fred-last-command item nil)
        (if (and (option-key-p) (or (control-key-p) (command-key-p)))
          (ed-edit-definition item))))))

(defmethod key-handler-idle ((item fred-mixin) &optional dialog)
  (declare (ignore dialog))
  (without-interrupts
   (with-focused-view item
     (with-text-colors item
       (frec-idle (frec item))))))

(defmethod set-view-size ((item fred-mixin) h &optional v
                          &aux (new-size (make-point h v)))
  (unless (eql new-size (view-size item))
    (with-focused-view item
      (with-text-colors item
        (without-interrupts
         (call-next-method)
         (let ((frec (frec item)))
           (if (eq frec para-frec)(setq para-frec nil)) ; lose cache
           (frec-set-size frec new-size))))))
  new-size)



#| ; moved
; this is damn slow - is there a better way - does it matter?
; not if we only call it when messing with horizontal scroll
(defun frec-hmax (frec)
  (let* ((visible-lines (frec-full-lines frec))
         (buf (fr.wposm frec))
         (ipos (buffer-position buf))
         (size-1 (%i- (buffer-size buf) 1))
         (max (point-h (fr.size frec))))
    (dotimes (i visible-lines)
      (let ((epos (buffer-line-end buf ipos)))
        (setq max (max max (%screen-line-width frec ipos (or epos (buffer-size buf)))))
        (when (or (not epos)(>= epos size-1)) (return))
        (setq ipos (1+ epos))))
    max))
|#



(defun shortest-package-nickname (pkg)
  (setq pkg (find-package pkg))
  (let* ((nicknames (package-nicknames pkg))
         (nick (package-name pkg))
         (nick-len (length nick)))
    (dolist (name nicknames)
      (let ((name-len (length name)))
        (when (< name-len nick-len)
          (setq nick name nick-len name-len))))
    nick))




(defmethod stream-tyo ((stream fred-mixin) char)
  (buffer-insert (fred-buffer stream) char))

(defmethod stream-write-string ((stream fred-mixin) string start end)
  (buffer-insert-substring (fred-buffer stream)
                           string start end)
;  (fred-update stream)
  )

(defmethod stream-fresh-line ((stream fred-mixin) &aux pos)
  (let ((buf (fred-buffer stream)))
    (when (and (not (%izerop (setq pos (buffer-position buf))))
               (not (char-eolp (buffer-char buf (%i- pos 1)))))
      (stream-tyo stream (or *preferred-eol-character* #\return)))
    t))

(defmethod stream-column ((stream fred-mixin))
  (let ((buf (fred-buffer stream)))
    (%i- (buffer-position buf)
         (buffer-line-start buf))))

(defmethod stream-force-output ((stream fred-mixin))
  (fred-update stream))

(defmethod stream-tyi ((stream fred-mixin))
  (let ((buffer (fred-buffer stream)))   ; no more buffer-end-p
    (buffer-read-char buffer)))

(defmethod stream-clear-input ((stream fred-mixin))
  nil)

(defmethod stream-untyi ((stream fred-mixin) char)
  (declare (ignore char))
  (move-mark (fred-buffer stream) -1))

(defmethod stream-position ((stream fred-mixin) &optional new-pos)
  (let ((buf (fred-buffer stream)))
    (if new-pos
      (progn (set-mark buf new-pos) new-pos)
      (buffer-position buf))))

(defmethod stream-eofp ((stream fred-mixin))
  (buffer-end-p (fred-buffer stream)))

(defmethod interactive-stream-p ((stream fred-mixin)) t)

(defmethod window-needs-saving-p ((w fred-mixin))
  (let ((file-modcnt (file-modcnt w)))
    (let ((buf (fred-buffer w)))
      (if file-modcnt
        (and (neq file-modcnt t)
             (neq file-modcnt (buffer-modcnt buf)))
        (not (%izerop (buffer-size buf)))))))

(defmethod set-window-doesnt-need-saving ((w fred-mixin))
  (setf (file-modcnt w)(buffer-modcnt (fred-buffer w))))

(defmethod window-buffer-read-only-p ((w fred-mixin)) 
  (%ilogbitp $bf_r/o-flag (bf.fixnum (mark.buffer (fred-buffer w)))))

; Replaced by pathnames.lisp
(defun flush-volume (path)
  (%stack-iopb (pb np)
    (setq path (mac-namestring path))
    (setq path (%substr path 0 (1+ (%str-member #\: path))))
    (when (%i> (length path) 255) (signal-file-error $nsvErr path))
    (%put-string np path)
    (%put-word pb (if (%izerop (%get-byte np)) 0 -1) $ioVolIndex)
    (%put-word pb 0 $ioVRefNum)
    (errchk (#_PBFlushVolSync pb)))
  path)

(defmethod window-save-position ((w fred-mixin)
                                 &optional (name (window-filename w)))
  (view-save-position w name))

#|
(defmethod view-save-position ((view fred-mixin)
                               &optional name preserve-file-info-p
                               &aux refnum pos botright
                               (win (view-window view)) error-p)
  (unless name (setq name (window-filename view)))
  (when name
    (handler-bind ((error #'(lambda (c)
                              (declare (ignore c))
                              (setq error-p t)
                              (return-from view-save-position))))
      (without-interrupts
       (%stack-iopb (pb np)
         (unwind-protect
           (with-macptrs (rsrc)
             (when preserve-file-info-p
               (%path-to-iopb name pb t))             
             (when (setq refnum (%open-res-file2 name))
               (get-mpsr-resource rsrc)
               (with-dereferenced-handles ((rp rsrc))
                 (when win
                   (%put-long rp (setq pos (view-position win))  38)
                   (%put-long rp (setq botright (add-points pos (view-size win))) 42)
                   (%put-long rp pos 46)
                   (%put-long rp botright 50))
                 (multiple-value-bind (s e) (selection-range view)
                   (%put-long rp s 58)
                   (%put-long rp e 62))
                 (%put-long rp (buffer-position (fred-display-start-mark view)) 66))
               (#_ChangedResource rsrc)))
           (when refnum 
             (#_CloseResFile refnum)
             (when (not error-p)
               (when preserve-file-info-p
                 (#_PBHSetFInfoSync :errchk pb))
               (flush-volume name)
               (setf (buffer-file-write-date (fred-buffer view)) (mac-file-write-date name))))))))))
|#

;; lets assume we don't care about preserve-file-info-p - put it back

(defmethod view-save-position ((view fred-mixin)
                               &optional name preserve-file-info-p
                               &aux refnum pos botright
                               (win (view-window view)) error-p old-date)
  ;(declare (ignore-if-unused preserve-file-info-p))
  (unless name (setq name (window-filename view)))  
  (when name
    (when preserve-file-info-p (setq old-date (file-write-date name)))
    (handler-bind ((error #'(lambda (c)
                              (declare (ignore c))
                              (setq error-p t)
                              (return-from view-save-position))))
      (without-interrupts
       (progn ;%stack-iopb (pb np)
         (unwind-protect
           (with-macptrs (rsrc)                          
             (when (setq refnum (%open-res-file2 name))
               (get-mpsr-resource rsrc)
               (with-dereferenced-handles ((rp rsrc))
                 (when win
                   (%put-long rp (setq pos (view-position win))  38)
                   (%put-long rp (setq botright (add-points pos (view-size win))) 42)
                   (%put-long rp pos 46)
                   (%put-long rp botright 50))
                 (multiple-value-bind (s e) (selection-range view)
                   (%put-long rp s 58)
                   (%put-long rp e 62))
                 (%put-long rp (buffer-position (fred-display-start-mark view)) 66))
               (#_ChangedResource rsrc)))
           (when refnum 
             (#_CloseResFile refnum)             
             (when (not error-p)
               (flush-volume name)
               (when preserve-file-info-p (set-file-write-date name old-date))
               (setf (buffer-file-write-date (fred-buffer view)) (mac-file-write-date name))))))))))


(defmethod window-restore-position ((w fred-mixin)
                                    &optional (name (window-filename w)))
  (view-restore-position w name))

(defvar *gonna-change-pos-and-sel* nil)

#|
(defun get-mpsr-info (name &aux (refnum -1) wpos wsize curpos sel-end start-pos)
   (unwind-protect
     (with-macptrs (rsrc)
       (with-pstrs ((np (mac-namestring (probe-file name))))
         (setq refnum (#_HOpenResFile 0 0 np #$fsrdwrperm)))
       (when (neq -1 refnum)
         (#_UseResFile refnum)
         (%setf-macptr rsrc (#_Get1Resource "MPSR" 1005))
         (unless (%null-ptr-p rsrc)
           (#_LoadResource rsrc)
           (with-dereferenced-handles ((rp rsrc))
             (setq wpos (%get-long rp 38))
             (setq wsize (subtract-points (%get-long rp 42) wpos))
             (setq curpos (%get-long rp 58))
             (setq sel-end (%get-long rp 62))
             (setq start-pos (%get-long rp 66))))))
     (unless (eq refnum -1)
       (#_CloseResFile refnum)))
   (values wpos wsize curpos sel-end start-pos))
|#

(defun get-mpsr-info (name &aux (refnum -1) wpos wsize curpos sel-end start-pos)
  (let ((truename (truename name)))
    (unwind-protect
      (rlet ((fsref :fsref))
        (make-fsref-from-path-simple truename fsref)
        (unless (eq -1 (setq refnum (open-resource-file-from-fsref fsref #$fsrdperm)))
          (with-macptrs (rsrc)
            (#_UseResFile refnum)
            (%setf-macptr rsrc (#_Get1Resource "MPSR" 1005))
            (unless (%null-ptr-p rsrc)
              (#_LoadResource rsrc)
              (with-dereferenced-handles ((rp rsrc))
                (setq wpos (%get-long rp 38))
                (setq wsize (subtract-points (%get-long rp 42) wpos))
                (setq curpos (%get-long rp 58))
                (setq sel-end (%get-long rp 62))
                (setq start-pos (%get-long rp 66)))))))
      (unless (eq refnum -1)
        (#_CloseResFile refnum)))
    (values wpos wsize curpos sel-end start-pos)))
        
      


; get keyscript right initially
(defmethod view-restore-position ((view fred-mixin)
                                  &optional (name (window-filename view))
                                  &aux (window (view-window view)))
  (multiple-value-bind (wpos wsize curpos sel-end start-pos)
                       (get-mpsr-info name)
    (when wsize
      (without-interrupts
       (let* ((b-size (buffer-size (fred-buffer view))))      
         (when window
           (set-view-position window wpos) ;; <<
           (let* ((default-pos (window-default-zoom-position window))
                  (default-size (window-default-zoom-size window)))
             (set-view-position window 
                                (max (point-h wpos)(point-h default-pos))
                                (max (point-v wpos)(point-v default-pos)))                                
             (set-view-size window 
                            (min (point-h wsize)(point-h default-size))
                            (min (point-v wsize)(point-v default-size)))
             (window-ensure-on-screen window default-pos default-size)))
         (when (not *gonna-change-pos-and-sel*)
           (set-mark (fred-buffer view) (%imin b-size curpos))
           (set-selection-range view (%imin b-size sel-end))
           (set-mark (fred-display-start-mark view)
                     (%imin b-size start-pos))
           (let ((frec (frec view))  ; add this for right key script initially
                 (keyscript (get-key-script)))
             (when (null (fr.keyscript frec))
               (setf (fr.keyscript frec)(ff-script (buffer-font-codes (fr.buffer frec)))))
             (when (not (eql keyscript (fr.keyscript frec)))
               (set-key-script (fr.keyscript frec)))))))
       (when nil ;window
         (window-ensure-on-screen window #@(6 44))))))
          
        


; Ensure that a window is on the screen.

(defmethod window-ensure-on-screen ((window window) &optional default-position default-size)
  (unless (window-on-screen-p window)
    (set-view-position window (or default-position (view-default-position window)))
    (unless (window-on-screen-p window)
      (set-view-size window (or default-size (view-default-size window)))
      (unless (window-on-screen-p window)
        (set-view-position window (window-on-screen-position window))
        (unless (window-on-screen-p window)
          (set-view-size window (or default-size (window-on-screen-size window))))))))

(defmethod window-on-screen-position ((window window))
  #@(6 44))

(defmethod window-on-screen-size ((window window))
  #@(502 147))

(defmethod window-on-screen-p ((w window))
  (with-macptrs (rgn)
    (unwind-protect
      (let* ((topleft (view-position w))
             (bottomright (add-points topleft (view-size w))))
        (%setf-macptr rgn (#_NewRgn))
        (unless (%null-ptr-p rgn)
          (#_SetRectRgn rgn (point-h topleft) (point-v topleft) (point-h bottomright) (point-v bottomright))
          (#_DiffRgn rgn #-carbon-compat (#_LMGetGrayRgn) #+carbon-compat (#_getgrayrgn) rgn)
          (#_EmptyRgn rgn)))
      (unless (%null-ptr-p rgn) (#_DisposeRgn rgn)))))


(defmethod window-ask-save ((w fred-mixin))
  (let ((window (view-window w)))
    (when (and (window-needs-saving-p w)
               (if t ;(osx-p)
                 (window-ask-save-dialog window)
                 (let ((my-filename (window-filename w)))
                   (y-or-n-dialog 
                    (if my-file-name
                      (format nil "Save changes to file ~s?"
                              (namestring my-file-name))
                      (format nil "Save window ~s to a file?"
                              (window-title window)))
                    :back-color *tool-back-color*
                    :theme-background t
                    :help-spec '(:dialog 11061 :yes-text 11062 :no-text 11063 :cancel-text 11064)))))
      (window-save window))))

;; only works on OSX? - seems OK on OS9 too
(defun window-ask-save-dialog (window)
  (let ((the-nav-dialog nil)
        (window-position (add-points (view-position window) (make-point 10 (window-title-height window))))
        (window-filename (window-filename window)))
    (rlet ((options :navdialogcreationoptions)
           (the-dialog :ptr))
      (with-cfstrs-hairy ((saved-filename (if window-filename 
                                            (namestring-no-cache (back-translate-pathname window-filename))
                                            (window-title window))))
        (set-default-dialog-creation-options options :location window-position 
                                             :savedfilename saved-filename
                                             ;:window window
                                             )        
        (unwind-protect            
          (let ((result (#_NavCreateAskSaveChangesDialog
                         options
                         (if *quitting* #$kNavSaveChangesQuittingApplication #$kNavSaveChangesClosingDocument)
                         (%null-ptr) ; eventproc
                         *my-nav-ud*  ;; = (%null-ptr) today
                         the-dialog)))
            (when (neq result #$noerr)(throw-cancel :cancel))
            (setq the-nav-dialog (%get-ptr the-dialog))
            (with-foreign-window                                      
              (setq result (#_navdialogrun the-nav-dialog)))
            (WHEN (neq result #$noerr) (throw-cancel :cancel))
            (let ((action (#_navdialoggetuseraction the-nav-dialog)))
              (case action 
                (#.#$kNavUserActionSaveChanges t)
                (#.#$kNavUserActionDontSaveChanges nil)
                (t (throw-cancel :cancel)))))
          (when the-nav-dialog (#_navdialogdispose the-nav-dialog))
          (nav-dialog-cleanup))))))

(defun window-ask-revert-dialog (window)  
  (let ((the-nav-dialog nil)
        (window-position (add-points (view-position window) (make-point 10 (window-title-height window))))
        (window-filename (window-filename window)))
    (rlet ((options :navdialogcreationoptions)
           (the-dialog :ptr))
      (with-cfstrs-hairy ((saved-filename (if window-filename 
                                            (namestring-no-cache (back-translate-pathname window-filename))
                                            (window-title window))))
        (set-default-dialog-creation-options options :location window-position 
                                             :savedfilename saved-filename
                                             ;:window window
                                             )        
        (unwind-protect            
          (let ((result (#_NavCreateAskDiscardChangesDialog
                         options
                         (%null-ptr) ; eventproc
                         *my-nav-ud*
                         the-dialog)))
            (when (neq result #$noerr)(throw-cancel :cancel))
            (setq the-nav-dialog (%get-ptr the-dialog))
            (with-foreign-window                                      
              (setq result (#_navdialogrun the-nav-dialog)))
            (WHEN (neq result #$noerr) (throw-cancel :cancel))
            (let ((action (#_navdialoggetuseraction the-nav-dialog)))
              (case action 
                (#.#$kNavUserActionDiscardChanges t)
                (t (throw-cancel :cancel)))))
          (when the-nav-dialog (#_navdialogdispose the-nav-dialog))
          (nav-dialog-cleanup))))))

;; unused because can't make timer work. Also quitting could be messy to handle.
#|
(add-pascal-upp-alist-macho 'sheet-event-wdef "NewNavEventUPP")

(defpascal sheet-event-wdef (:word callbackselector :ptr callbackparms :ptr callbackud) ;#+carbon-compat :ptr #-carbon-compat :long callbackud)   ;; callbackud was :long
  (progn     
    ;(print (list 'cow callbackselector)) ;; 2 12 3 start, useraction, terminate
    #+ignore
    (when (eq callbackselector #$kNavCBStart)
      (let ((wptr (pref callbackparms :navcbrec.window)))
        (mouse-sheet wptr))) 
    (let* ((the-nav-dialog (pref callbackparms :navcbrec.context))
           ;(wptr (pref callbackparms :navcbrec.window))  ;; ain't the window we need - its the sheet
           (window (window-object callbackud)))
      (when  (eq callbackselector #$kNavCBTerminate)          
        (when (and window (typep window 'fred-window))
          (let ((action (#_navdialoggetuseraction the-nav-dialog)))
            ;(print (list 'action action))
            (case action 
              (#.#$kNavUserActionSaveChanges (window-save window))
              (#.#$kNavUserActionDontSaveChanges (progn (set-window-doesnt-need-saving (window-key-handler window))(window-close window))))))
        ;(if (>= *timer-count* 1)(deactivate-timer))
        (#_navdialogdispose the-nav-dialog)
        ))))

(defun window-ask-save-dialog-sheet (window)
  (let ((the-nav-dialog nil)
        ;(window-position (if window (add-points (view-position window) #@(10 26))))
        (window-filename (if  window (window-filename window))))
    (rlet ((options :navdialogcreationoptions)
           (the-dialog :ptr))
      (with-cfstrs-hairy ((saved-filename (if window-filename (namestring window-filename))))
        (set-default-dialog-creation-options options 
                                             :savedfilename saved-filename
                                             )
        (setf (pref options :navdialogCreationoptions.parentWindow) (wptr window))
        (setf (pref options :navdialogcreationoptions.modality) #$kWindowModalityWindowModal) 
        (progn ;unwind-protect            
          (let ((result (#_NavCreateAskSaveChangesDialog
                         options
                         (if *quitting* #$kNavSaveChangesQuittingApplication #$kNavSaveChangesClosingDocument)
                         sheet-event-wdef ;(%null-ptr) ; eventproc
                         (%null-ptr) ;; clientdata
                         the-dialog)))
            (when (neq result #$noerr)(throw-cancel :cancel))
            (setq the-nav-dialog (%get-ptr the-dialog))
            (let ()                                      
              (errchk (#_navdialogrun the-nav-dialog)))))))))


|#

;; #$keventclassMouse mousedown doesn't help because we don't get a mouseup
#|
;; controltrack never happens, controlclick never happens, controlhit happens too late
(defun mouse-sheet (wptr)
  (rlet ((event-spec :eventtypespec
                     :eventclass #$keventclassControl
                     :eventkind #$keventcontrolhit))
    (errchk (#_installeventhandler (#_getWindowEventTarget wptr)
             mouse-down-sheet 1
             event-spec (%null-ptr) (%null-ptr))))
  #+ignore
  (rlet ((event-spec :eventtypespec
                     :eventclass #$keventclassMouse
                     :eventkind #$keventMouseUp))
    (#_installeventhandler (#_getWindowEventTarget wptr)
     mouse-up-sheet 1
     event-spec (%null-ptr) (%null-ptr))
    ))

(add-pascal-upp-alist 'mouse-down-sheet #'(lambda (procptr) (#_NewEventHandlerUPP procptr)))
(defpascal mouse-down-sheet (:ptr targetref :eventref event :word)
  (declare (ignore targetref event))(print 'horse)
  ;(cerror "a" "b")
  (let () ;(prior-level (prior-interrupt-level)))
    ;(push (list 'cow prior-level) foop)  ;; prior level is -1 - so timer also has no effect - fixed with a hammer
    (setq *interrupt-level* 0)
    (do-db-links (db var val)
      (when (eq var '*interrupt-level*)
        (unless (>= (the fixnum val) 0)
          (setf (%fixnum-ref db 8) 0))
        (return)))    
    (if (eq *timer-count* 0)(activate-timer)))
  #$eventnothandlederr)
|# 

(defparameter *save-as-original-format* t)
(export '*save-as-original-format* :ccl)

;; need to handle chosen format here - OK - test it
(defmethod window-save-file ((w fred-mixin) &optional name if-exists external-format did-choose)
  (let ((my-file-name (window-filename w))    
        (file-modcnt (file-modcnt w))
        chosen-format)
    (when (null name)
      (multiple-value-setq (name chosen-format) 
        (choose-new-file-dialog
         :directory (or my-file-name
                        (if (eq file-modcnt t)
                          (window-title (view-window w))
                          (format nil "Temp.~a"
                                  (pathname-type *.lisp-pathname*))))
         ;:prompt "Save File As…"
         ))
      (if (null external-format)(setq external-format chosen-format))
      (setq did-choose t)
      (setq if-exists :supersede))
    (when (and (null external-format)(null did-choose)  *save-as-original-format*)
      (setq external-format (file-external-format w)))
    (setq name (buffer-write-file 
                (fred-buffer w) name :if-exists (or if-exists :supersede) 
                :external-format external-format :window (view-window w)))
    (when *save-fred-window-positions*
      (window-save-position w name))     
    name))

(defun handle-file-moved (orig-path fsref-path window)
  (let ((ans (standard-alert-dialog (format nil "The file \"~A\" has been moved or renamed to \"~A\". Save to..."
                                    (back-translate-pathname orig-path) (back-translate-pathname fsref-path))
                            :YES-text "New"
                            :no-text "Original"
                            :cancel-text "Cancel")))
    ;; change window-filename if New chosen
    (if (null ans) orig-path 
        (if (eq ans t)
           (progn (set-window-filename-simple window fsref-path) fsref-path)
            :cancel))))

;yes - need to handle chosen format here - OK - test  it
(defmethod window-save-copy-as ((w fred-mixin) &optional name)
  (let* ((old-name (window-filename w))
         (chosen-format nil)
         (did-choose nil))
    (unless name
      (multiple-value-setq (name chosen-format) 
        (choose-new-file-dialog :directory (and old-name
                                                (make-pathname
                                                 :host (pathname-host old-name)
                                                 :directory (pathname-directory old-name)
                                                 :name (copy-of-file-name old-name)
                                                 :type (pathname-type old-name)
                                                 :defaults nil))
                                :window-title "Choose a New File for Copy"
                                ;:prompt "Save Copy As…"
                                ))
      (setq did-choose t))
    (let ((write-date (buffer-file-write-date (fred-buffer w))))
      (unwind-protect
        (progn
          (setf (buffer-file-write-date (fred-buffer w)) nil)
          (window-save-file w name :supersede chosen-format did-choose))
        (setf (buffer-file-write-date (fred-buffer w)) write-date)))))

(defun copy-of-file-name (path)
  (let ((new-name (maybe-encoded-strcat  (pathname-name path) " copy")))
    (if (probe-file (merge-pathnames new-name path))
      (let ((idx 1)
            name )
        (loop
          (setq name (maybe-encoded-strcat new-name (format nil " ~a" (incf idx))))
          (unless (probe-file (merge-pathnames name path))
            (return name))))
      new-name)))

#| ;; not used today - were from save-as-xxx menu items
(defmethod window-save-as-utf-16 ((w fred-mixin))
  (window-save-as w :utf-16))

(defmethod window-save-as-utf-8 ((w fred-mixin))
  (window-save-as w :utf-8))

(defmethod window-save-as-unix ((w fred-mixin))
  (window-save-as w :unix))
|#



(defmethod window-save-as ((w fred-mixin) &optional external-format)
  (let ((my-file-name (window-filename w))
        (did-choose nil))
    (let () ;(file-modcnt (file-modcnt w)))
      (if nil ;(eq file-modcnt t)
        (window-save-file w)
        (let* ((*use-namestring-caches* nil)
               (in-dir (if my-file-name (probe-file (directory-namestring (full-pathname my-file-name)))))
               (in-name (if my-file-name (%file-system-string (file-namestring my-file-name))
                            (format nil "Temp.~a" 
                                    (pathname-type *.lisp-pathname*)))))
          (multiple-value-bind (name chosen-type) (choose-new-file-dialog
                                                   :directory in-dir
                                                   :name in-name                                                   
                                                   ;:prompt "Save File As…"
                                                   )
            (when name (setq did-choose t))
            (when (and chosen-type (not external-format))(setq external-format chosen-type))            
            (let ((fsref (window-fsref (view-window w))))
              (when fsref 
                (setf (window-fsref (view-window w)) nil)
                (#_removewindowproxy (wptr w))
                (#_disposeptr fsref)))
            (setq my-file-name (set-window-filename (view-window w) name))            
            (setf (buffer-file-write-date (fred-buffer w)) nil)
            (when (and *preferred-eol-character*
                       (or (not (probe-file name))
                           (not (check-read-only-p name nil))))
              (%buffer-set-read-only (fred-buffer w) nil))   ;; moved up
            (window-save-1  w name :supersede external-format did-choose)
            (%buffer-set-read-only (fred-buffer w) nil)
            (let ((type (if (eq external-format :utf-16) :|utxt| :text)))
              (set-mac-file-type-and-creator my-file-name type (application-file-creator *application*)))                        
            (when (fboundp 'update-recent-files) (funcall 'update-recent-files :filename name))
            my-file-name))))))

(defun fsref-ok-p (fsref)
  (let ((err (#_fsgetcataloginfo fsref #$kFSCatInfoGettableInfo
              (%null-ptr)(%null-ptr)(%null-ptr)(%null-ptr))))
    (eq err #$noerr)))

(defun window-filename-from-fsref (window)
  (let ((fsref (window-fsref window)))
    (when fsref
      (let ((path (if (fsref-ok-p fsref)(ignore-errors (%path-from-fsref fsref)))))  ;; maybe fsref gone bad
        (when (or (not path)  ;;  if someone moved it to trash they probably want it gone.
                  (string-equal ".Trash" (car (last (%pathname-directory path)))))  ;; is this a reliable test?
          (setf (window-fsref window) nil)
          (setq path nil)
          (#_removewindowproxy (wptr window))
          (#_disposeptr fsref))
        path))))
    

(defmethod window-save ((w fred-mixin))
  (let* ((window (view-window w))
         (fsref-path (window-filename-from-fsref window))
         (my-file-name (or fsref-path (window-filename w))))    
    (if (null my-file-name)
      (window-save-as w)
      (progn
        (let ((last-written (mac-file-write-date my-file-name))
              (my-write-date (buffer-file-write-date (fred-buffer w))))
          (when (and my-write-date last-written 
                     (if t ;(not (or (bbox-p)(osx-p)))  ;; wasn't this backwards??
                       (not (eql last-written my-write-date))
                       ;; this is horrible - compensate for classic bug re #_PBFlushVolSync / #_PBGetCatInfoSync
                       ;; at the risk of overwriting something that should not be overwritten.
                       ;; 30 is adhoc from PB G3 - may depend on machine speed or other factors
                       (not (or (eql last-written my-write-date)
                                (< (- last-written my-write-date) 30)))))
            ;; if user says no then we blow out of here else do save
            (handle-buffer-save-conflict my-file-name))
          (when (and my-write-date (null last-written))            
            (let ((ans (handle-file-gonzo my-file-name)))
              (if (null ans)
                (return-from window-save (window-save-as w))
                (if (eq ans :cancel) (return-from window-save)))))
          (when (and (window-filename w) fsref-path)
            (when (not (equalp fsref-path (full-pathname (window-filename w))))
              (let ((ans (handle-file-moved (window-filename w) fsref-path window)))
                (if (eq ans :cancel)(return-from window-save))
                  (setq my-file-name ans))))
          (window-save-1 w my-file-name :supersede)     ;; why not :supersede ???
          (setf (buffer-file-write-date (fred-buffer w))(mac-file-write-date my-file-name))                           
          (ed-history-add w :saved nil)
          )))))


(defun window-save-1 (w my-file-name &optional if-exists external-format did-choose &aux
                        (buffer (fred-buffer w)))
  (let ((file-modcnt (file-modcnt w)))
    (when (neq file-modcnt (buffer-modcnt buffer))
        (with-cursor *watch-cursor*
          (set-mini-buffer w "~&Saving ~s… " my-file-name)
          (set-window-filename w
                (setq my-file-name (window-save-file w my-file-name (or if-exists :overwrite) external-format did-choose)))
          ;This needs to change when we start using fred-dialog-items to edit files. Hopefully never.
          (set-mini-buffer w " Done.")
          (let ((mapper #'(lambda (frec)
                            (when (same-buffer-p buffer (fr.buffer frec))
                              (let ((w (fr.owner frec)))
                                (when (typep w 'fred-mixin)   ; paranoid
                                  (setf (file-modcnt w)
                                        (buffer-modcnt buffer))))))))
            (declare (dynamic-extent mapper))
            (map-frecs mapper))
          (fred-update w))
        (setq *show-cursor-p* nil)
        my-file-name)))

(defmethod window-set-not-modified ((w fred-mixin))
  (let* ((buffer (fred-buffer w))
         (mapper
          #'(lambda (frec &aux owner)
              (when (and (same-buffer-p (fr.buffer frec) buffer)
                         (typep (setq owner (fr.owner frec)) 'fred-mixin))
                (let ((file-modcnt (file-modcnt owner)))
                  (unless (or (eq t file-modcnt)
                              (and (null file-modcnt)
                                   (%izerop (buffer-size buffer))))                    
                    (setf (file-modcnt owner) (buffer-modcnt buffer))))
                (fred-update owner)))))
    (declare (dynamic-extent mapper))
    (map-frecs mapper)))

(export 'standard-alert-dialog)






(defun window-ask-revert-modified-dialog (file-name)
  (let* ((message (format nil "The file \"~A\" has been modified since you last read or wrote it.
Do you want the modified version?" (back-translate-pathname file-name)))
         (ans (standard-alert-dialog message :yes-text "Yes" :no-text nil
                             :cancel-text "No")))
    (eq ans t)))
  

(defmethod window-revert ((w fred-mixin) &optional dont-prompt)
  (let* ((window (view-window w))
         (fsref-path (window-filename-from-fsref window))
         (my-file-name (or fsref-path (window-filename window))) 
         (frec (frec w)))
    (when my-file-name
      (unless (probe-file my-file-name)
        ;(signal-file-error $err-no-file my-file-name)
        (let ((message (format nil "File \"~A\" no longer exists." (back-translate-pathname my-file-name))))
          (standard-alert-dialog message :yes-text "OK" :no-text nil :cancel-text nil)
          (return-from window-revert)))     
      (when (or dont-prompt
                (let ((last-written (mac-file-write-date my-file-name))
                      (my-write-date (buffer-file-write-date (fred-buffer w))))                    
                  (if (eql last-written my-write-date)
                    (window-ask-revert-dialog window)
                    (window-ask-revert-modified-dialog my-file-name))))
        (set-window-filename window my-file-name)
        (let* ((buf (fr.cursor frec))
               (size (buffer-size buf))
               stuff owner curs
               (mapper #'(lambda (frec)
                           (when (and (same-buffer-p buf (setq curs (fr.cursor frec)))
                                      (typep (setq owner (fr.owner frec)) 'fred-mixin))
                             (push (list curs
                                         owner
                                         (buffer-position curs)
                                         (buffer-position (fr.wposm frec)))
                                   stuff)))))
          (declare (dynamic-extent mapper))
          (map-frecs mapper)        
          (buffer-delete buf 0 t)
          (buffer-insert-file buf my-file-name)        
          (clear-edit-history w)
          (let ((did-it))
            (when  (and (or *transform-CRLF-to-CarriageReturn* *transform-CRLF-to-preferred-eol*)
                        (not (file-external-format w)))
              (setq did-it (ed-xform-CRLF w))
              (when did-it
                (standard-alert-dialog (format nil "Yes, we reverted \"~A\" and then heeded *transform-CRLF-to-preferred-eol*."
                                       (back-translate-pathname  my-file-name))
                               :yes-text "OK" :no-text nil :cancel-text nil)))
            (let* ((new-size (buffer-size buf))
                   (modcnt (buffer-modcnt buf)))
              (dolist (s stuff)
                (destructuring-bind (curs owner pos wpos) s
                  (when (not did-it)
                    (setf (file-modcnt owner) modcnt))
                  (set-mark curs (if (%izerop size) 0
                                     (round (* pos new-size) size)))
                  (set-fred-display-start-mark owner (if (%izerop size) 0
                                                         (round (* wpos new-size)
                                                                size)))
                  (reparse-modeline owner t))))))))))

(defmethod set-window-filename ((w fred-mixin) new-name)
  (set-window-filename (view-window w) new-name))


;;here we really just care about the pathname - no modified or not business
;; and no after method for proxy-icon either - class fred-window not defined yet
(defmethod set-window-filename-simple ((window window) new-name)
  (when new-name
    (let ((*use-namestring-caches* nil))
      (let* ((title (application-pathname-to-window-title *application* window new-name))
             (buffer (fred-buffer window)))
        (set-window-title window title)
        (setf (slot-value window 'real-file-name) new-name)
        ;; why dont we just put the pathname in the window
        ;; or perhaps the buffer
        (setf (buffer-filename buffer) new-name)
        #+ignore
        (let ((mapper
               #'(lambda (frec &aux owner)
                   (when (and (same-buffer-p buffer (fr.buffer frec))
                              (typep (setq owner (fr.owner frec)) 'fred-mixin))
                     (setf (slot-value owner 'my-file-name) new-name)))))
          (declare (dynamic-extent mapper))
          (map-frecs mapper))
        new-name))))



(defmethod set-file-external-format ((w fred-mixin) format)
  (let ((window (view-window w)))
    (when window
      (view-put window :external-format format))))

(defmethod file-external-format ((w fred-mixin))
  (let ((window (view-window w)))
    (when window
      (view-get window :external-format))))

(defparameter *pathname-window-title-name-only* nil)
(export '*pathname-window-title-name-only* :ccl)


(defun pathname-to-window-title (pathname &optional (simple *pathname-window-title-name-only*))
  (when pathname ; ??
    (let ((*use-namestring-caches* nil))
      (let* ((name (%file-system-string (file-namestring pathname)))  ;;or (mac-file-namestring-1 pathname) ?   
             (name-len  (if (typep name 'encoded-string)(length (the-string name))(length name)))
             ) 
        (when (> name-len 37)             ; not likely for real files, but...
          (when (stringp name)
            (cond 
             ((extended-string-p name)
              (setq name (%substr name 0 37))
              (setf (schar name 36) #\…))
             (t (setq name (%str-cat (%substr name 0 36) (string #\…)))))))
        (if simple
          name
          (let* ((pathname (back-translate-pathname pathname))
                 (directory (directory-namestring pathname))
                 (host (pathname-host pathname)))      
            (when (and  host (neq host :unspecific))
              (setq directory (maybe-encoded-strcat-many host ":" directory)))
            (maybe-encoded-strcat-many name " {" directory "}"))))))) 


(defmethod select-all ((w fred-mixin))
  (set-selection-range w t 0)
  (fred-update w)
  (set-buffer-insert-font-index (fred-buffer w) nil)
  (set-fred-last-command w nil))


(defmethod window-selection-stream ((w fred-mixin) start end)
  (make-instance 'selection-stream
                 :fred-item w
                 :start start
                 :end end
                 :filename (or (window-filename w)
                               ; if we leave this in,
                               ; record-source-file records #P"New" for New buffer
                               ; which is bogus but
                               ; if we take it out, record source file gets nil 
                               ;(slot-value w 'object-name)
                               )
                 :package (window-package w)))


(defparameter *remove-shadowing-comtab-eventhook*
  #'(lambda (&aux (event *current-event*)
                  (code (pref event :eventrecord.what)))
      (when (or (eql code $MButDwnEvt)
                (and (eq code $KeyDwnEvt)
                     (menukey-modifiers-p (pref event :eventrecord.modifiers))))
        (remove-shadowing-comtab (front-window) " …Cancelled.")) ; gasp
      nil))



(defun install-shadowing-comtab (w comtab &optional (prefix t))
  (setq *eventhook*
        (cons *remove-shadowing-comtab-eventhook*
              (if (listp *eventhook*) *eventhook* (list *eventhook*))))
  (when (and *control-q-with-dead-keys-enabled* (eq comtab *control-q-comtab*))
    (setq *dead-keys-state-when-qcomtab-installed* *dead-keys-state*)
    (when (null *dead-keys-state*)
      (set-dead-keys t)))
  (set-fred-shadowing-comtab w comtab)  
  (when t ;prefix 
    (if (typep w 'window)(setq w (current-key-handler w)))
    (view-put w 'prefix-comtab prefix)))

(defmethod view-mini-buffer ((view simple-view)) nil)

(defun remove-shadowing-comtab (&optional (w (front-window)) (message nil)) ; gasp
  (when message
    (set-mini-buffer w message))
  (cond ((typep w 'fred-mixin)
         (set-fred-shadowing-comtab w nil)
         (view-put w 'prefix-comtab nil))
        ((typep w 'view)
         (let ((key (current-key-handler w)))
           (when key
             (when (fred-shadowing-comtab key)
               (view-put key 'prefix-comtab nil)
               (set-fred-shadowing-comtab key nil))))))
  (setq ; *prefix-comtab-installed* nil
        *eventhook* (delete *remove-shadowing-comtab-eventhook*
                            *eventhook*
                            :test #'eq)))


(defmethod view-key-event-handler ((w fred-mixin) *current-character*)
  (with-focused-view w
    (with-text-colors w
      (let* ((*current-keystroke* (event-keystroke (pref *current-event* eventrecord.Message)
                                                   (pref *current-event* eventrecord.Modifiers)))
             ;         (*processing-events* nil)
             (hook *fred-keystroke-hook*)
             (tab (or hook (fred-shadowing-comtab w) (fred-comtab w))))
        (declare (special *current-keystroke* *processing-events*))
        (if (and hook (or (functionp hook) (symbolp hook)))
          (funcall hook w)
          (run-fred-command w (keystroke-function w *current-keystroke* tab)))))))



(defmethod keystroke-function ((w fred-mixin) keystroke
                               &optional (tab
                                          (or (fred-shadowing-comtab w)
                                              (fred-comtab w)))
                               &aux
                               fn
                               (code (keystroke-code keystroke)))
  (if (comtabp tab)
    (let* ((c code) (seen ()))
      (while (fixnump (setq fn (or (comtab-get-key tab c)
                                   (comtab-default tab))))
        (setq seen (cons c seen) c fn)
        (when (memq fn seen) (error "Circular definition for ~S!"
                                    (keystroke-name code))))
      fn)
    tab))

(defvar *clear-mini-buffer* t)
(defvar *history-added*)

(defmethod run-default-command ((w fred-mixin) comtab)
  (declare (special *last-command* *default-command-p*))
  (setf (fred-last-command w) *last-command*)
  (run-fred-command
   w (keystroke-function 
      w *current-keystroke* comtab))
  (setq *default-command-p* t))

(defun quote-twiddle (string)
  (let ((pos (%str-member #\~ string)))
    (if pos
      (let ((res (%str-cat  (%substr string 0 pos) "~~")))
        (if (<  pos (length string))
          (%str-cat  res (quote-twiddle (%substr string (1+ pos) (length string))))
          res))
      string)))

(defmethod run-fred-command ((w fred-mixin) fn
                             &aux (was-prefixed (view-get w 'prefix-comtab))
                             ;last-command
                             )
  ;Assumes *current-character/keystroke* have been bound by caller.
  (handler-case
    (if (comtabp fn)
      (run-fred-prefix w fn)
      (let* ((*last-command* (fred-last-command w))
             (*show-cursor-p* t)
             (*prefix-command-p* nil)  ; could get rid of these by having fns return values. Even C can do that!
             (*default-command-p* nil)
             (*history-added* nil)
             (buffer (fred-buffer w))
             (modcnt (buffer-modcnt buffer)))
        (declare (special *last-command* *show-cursor-p* *prefix-command-p* *default-command-p*))
        (set-fred-last-command w nil)
        (let ((mini-buffer (view-mini-buffer w)))
          (if was-prefixed
            (progn
              ;(when mini-buffer (format-keystroke *current-keystroke* mini-buffer))
              (when  mini-buffer 
                (set-mini-buffer w (quote-twiddle (keystroke-code-string *current-keystroke*))))
              (remove-shadowing-comtab w nil))
            (when (and *clear-mini-buffer*
                       ; thats real general
                       (not (let ((shadow (fred-shadowing-comtab w))) ; weird for bootstrap
                              (and shadow (eq shadow *i-search-comtab*)))))
              (clear-mini-buffer-maybe w))))
        (unwind-protect
          (let ((*standard-output* (ed-standard-output)))
            (frec-delay-cursor-off (frec w) t)
            (funcall fn w)
            (clear-mini-buffer-after w))
          (let ((lc (fred-last-command w))) ; 5/28
            (if (eq lc :self-insert) ; fix I'm typing black mon
              (when (not (buffer-insert-font-index buffer))
                (multiple-value-bind (ff ms)(buffer-font-codes buffer) 
                  (set-buffer-insert-font-codes buffer ff ms)))
              (when (and  ;(neq lc :self-insert)
                     (or (not (consp lc))(neq (car lc) 'set-font)))
                ; any thing except self insert or font setting clears insert font
                ; - so do frec-click and frec-deactivate cut, clear and paste and undo
                (set-buffer-insert-font-index buffer nil)                      
                (let* ((new-w (current-key-handler (front-window)))) ; may have changed
                  (when new-w
                    (when *fred-auto-set-keyscript*
                      (unless  (let ((shadow (fred-shadowing-comtab new-w))) ; ditto - weird for bootstrap
                                 (and shadow (eq shadow *i-search-comtab*)))
                        (if (neq w new-w)
                          (when (typep new-w 'fred-mixin)
                            (let* ((buffer (fred-buffer new-w))
                                   (ff (buffer-font-codes buffer))   ; added 6/17/95
                                   (script (ff-script ff)))
                              (unless (eql script (get-key-script))
                                (set-key-script script)
                                (setf (fr.keyscript (frec new-w)) script))))
                          (let* ((ff (buffer-font-codes buffer)) ; there are faster ways?
                                 (script (ff-script ff))
                                 (frec (frec w)))
                            (when (not (eql script (fr.keyscript frec)))
                              (set-key-script script)
                              (setf (fr.keyscript frec) script)))))))))))
          (unless *default-command-p*
            (if *prefix-command-p*
              (set-fred-last-command w *last-command*)
              (setf (fred-prefix-argument w) nil))
            (when (and (not (eql modcnt (buffer-modcnt buffer))) ; something changed
                       (fred-history w)
                       (not *history-added*))  ; but no new history
              (ed-history-add w :bogus nil))))
        (when (wptr w)
          (if (and *show-cursor-p* (not *prefix-command-p*))
            (window-show-cursor w)
            (fred-update w)))))
    (modify-read-only-buffer (c) 
     (declare (ignore c))
     (if (buffer-whine-read-only w)
       ; if made writable then do it
       (run-fred-command w fn)))))

(defun ed-standard-output ()
  (if (and (null *top-listener*)
           (typep *standard-output* 'terminal-io))
    *front-listener-terminal-io*
    *standard-output*))


(defun clear-mini-buffer-maybe (w)
  (let* ((mini-buffer (view-mini-buffer w))
         (buf (fred-buffer w))
         (argpos (buffer-arglist-pos buf)))
    (when mini-buffer
      (if argpos
        (let* ((pos (buffer-position buf))
               (epos (buffer-fwd-up-sexp buf argpos pos)))
          (when (and (not epos)(typep w 'listener-fred-item))
            (setq epos (buffer-forward-find-char buf #\?)))
          (when (or epos (< pos (buffer-position argpos)))
            (stream-fresh-line mini-buffer)
            (buffer-arglist-pos buf nil)))
        (stream-fresh-line mini-buffer)
        ))))

; his job is to see if # prefix is worthwhile no longer calls find-symbol
(defun read-#-prefixed-symbol (string package)
  (and *autoload-traps*
       (if (and (> (length string) 2) (eq (char string 0) #\#))
         (let* ((*package* package)
                (res (ignore-errors (read-from-string string))))
           (and (symbolp res) res)))))

(defun clear-mini-buffer-after (w)
  (when *clear-mini-buffer*
    (let* ((buf (fred-buffer w))
           (mini-buffer (view-mini-buffer w)))
      (when mini-buffer
        (multiple-value-bind (argpos argsym)(buffer-arglist-pos buf)           
          (when argpos          
            (when (not (eq argsym (ed-current-symbol w #'read-#-prefixed-symbol argpos)))
              (stream-fresh-line (view-mini-buffer w))
              (buffer-arglist-pos buf nil))))))))
        
      
  
; return t if made writable else nil                             
(defun buffer-whine-read-only (w)
  (ed-beep)
  (let* ((mbuf (view-mini-buffer w))
         (file (window-filename w))
         ans)
    (when mbuf
      (stream-fresh-line mbuf)
      (stream-write-entire-string mbuf "Buffer is read-only!")
      (stream-force-output mbuf))
    (cond
     ((and (or (fboundp 'set-file-modify-read-only)
               (probe-file "ccl:sourceserver;read-only.lisp"))
           file
           (not (file-locked-p file)))
      (setq ans (catch-cancel
                  (let ((message "Buffer is read only. Make the local file and buffer modifiable? Or just the buffer?"))                      
                    (standard-alert-dialog message
                                           :yes-text "File" 
                                           :no-text "Buffer"
                                           :cancel-text "Neither"
                                           :alert-type #$kalertnotealert)))) 
      (if (eq ans :cancel)(return-from buffer-whine-read-only nil))
      (when (not (fboundp 'set-file-modify-read-only)) ; do now so file-whine doesnt need to
        (load "ccl:sourceserver;read-only"))  ;(require :read-only)      
      (if (eq ans t)
        (funcall 'set-file-modify-read-only file))
      (%buffer-set-read-only (fred-buffer w) nil)
      (fred-update w)
      t)
     ((file-locked-p file)
      (setq ans (catch-cancel (standard-alert-dialog "The buffer is read only because the file is locked. Make the buffer modifiable? (But you won't be able to save it to the file until the file is unlocked.)"
                                  :yes-text "Yes" 
                                  :no-text "No"
                                  :cancel-text nil)))
      (if (eq ans t)
        (progn 
          (%buffer-set-read-only (fred-buffer w) nil)
          (fred-update w)
          t)))
                  
     (t nil))))

(defun file-whine-read-only (path)
  (let* ((message "File is read only. Make the local file modifiable?")
         (ans (standard-alert-dialog message
                                     :yes-text "Yes" :no-text nil :cancel-text "Cancel")))
    (when (eq ans t)
      (when (not (fboundp 'set-file-modify-read-only))
        (load "ccl:sourceserver;read-only"))
      
      (funcall 'set-file-modify-read-only path)
      t)))

(defmethod run-fred-prefix ((w fred-mixin) comtab 
                            &aux (mini-buffer (view-mini-buffer w)))
  (when mini-buffer
    (stream-fresh-line mini-buffer)
    (format-keystroke *current-keystroke* mini-buffer)
    (princ " " mini-buffer)
    (fred-update (view-window w)))
  (install-shadowing-comtab w comtab))

; when replacing a selection, use his font unless did set-font or key-script is different
(defmethod ed-insert-char ((w fred-mixin) char
                           &aux (frec (frec w))
                           (buf (fred-buffer w))
                           ;(wposm (fred-display-start-mark w))
                           undo-cons sel-ff sel-ms)
  (multiple-value-bind (b e) (frec-get-sel frec)
    (when (neq b e)
      (multiple-value-setq (sel-ff sel-ms)(buffer-char-font-codes buf b))
      (setq undo-cons (ed-delete-with-undo w b e nil))      
      (fred-update w)    ; is this really needed?
      )
    ; below makes no sense to me - so lose it
    (when nil (and (<= (fr.bwin frec) ;(frec-screen-line-start frec wposm)
                   (buffer-position buf))
               (< (buffer-position buf)
                  (buffer-position wposm)))
      (set-mark wposm buf))
    (let* ((lc *last-command*)
           (font (when (and (consp lc)(eq (%car lc) 'set-font))
                   (add-buffer-font buf (%cadr lc) (%caddr lc)))))
      ; when replacing a selection, use his font unless  key-script is different
      (when (and (not font) sel-ff) ; <<
        (when (eq (get-key-script)(ff-script sel-ff))
          (setq font (add-buffer-font buf sel-ff sel-ms))))
      (cond ((fred-history w)
             (ed-insert-with-undo w char
                                  (buffer-position buf) 
                                  (or undo-cons (eq lc ':self-insert))
                                  font)
             (set-fred-undo-stuff w :self-insert "Typing"))
            (t (buffer-insert buf char nil font))))))



(defmethod setup-undo ((w fred-mixin) function &optional (string "Undo"))
  (ed-history-add w function '%no-args%) ; fn takes no args
  (when string (set-real-fred-undo-string w string)))

(defmethod setup-undo-with-args ((w fred-mixin) function arg &optional string)
  (ed-history-add w function arg)
  (when string (set-real-fred-undo-string w string)))
  

; called from menu - its always undo (sometimes called redo)
; its never undo-next
(defmethod undo ((w fred-mixin))
  (let* ((undo-redo (fred-undo-redo w))
         (*last-command* nil))  ; so we don't do undo-next
    (when  (ed-history-get w)
      (ed-history-undo w)
      (set-fred-undo-redo w (if (eq undo-redo :redo) :undo :redo))
      (set-buffer-insert-font-index (fred-buffer w) nil)
      (window-show-cursor w)
      )))



; cut clear copy paste select-all undo undo-more
(defvar *undo-redo-alist* nil)

(defmethod window-can-do-operation ((w fred-mixin) op &optional item)  
  (case op
    (undo 
     (let ((undo-string (fred-undo-string w)))
       (let ((front "Undo ")
             (hist (ed-history-get w)))             
         (cond 
          ((and #|undo-string|# hist)
           (let ((undo-redo (fred-undo-redo w)))
             (when (eq undo-redo :redo)
               (setq front "Redo "))
             (when (or (null undo-string)(not (and (consp hist)(functionp (car hist)) (neq (cdr hist) '%no-args%))))
               ;; was (or (null undo-string) (not (and (functionp (listp (car hist))) (neq (cdr hist) '%no-args))))
               (setq undo-string
                     (if undo-string
                       (let* ((cell (cdr (or (assoc undo-string *undo-redo-alist* :test 'equal)
                                             (car (push (list undo-string nil) *undo-redo-alist*)))))                              
                              (str (if (eq undo-redo :redo) (cdr cell)(car cell))))                         
                         (unless str
                           (setq str (%str-cat front undo-string))
                           (if (eq undo-redo :redo)(rplacd cell str)(rplaca cell str)))
                         str)
                       front))))
           (when item (set-menu-item-title item undo-string))
           t)
          (t (when item (set-menu-item-title item "Undo"))
             nil)))))
    (undo-more
     (let ((last (fred-last-command w)))
       (and (consp last)(eq (car last) 'undo)
            (ed-history-get w (+ 2 (cdr last)))
            (memq (fred-undo-redo w) '(:redo :undo))))) ;; was just :redo
    (paste
     ; something to paste and not read-only
     (and #|(not (window-buffer-read-only-p w))|# (get-scrap-p :fred)))
    (search (and (not *modal-dialog-on-top*)
                 (neq 0 (buffer-size (fred-buffer w)))))
    ((select-all execute-whole-buffer)
     (neq 0 (buffer-size (fred-buffer w))))
    ((window-save-as window-save-copy-as) t) ; what did we have in mind here - non-empty?
    (t (multiple-value-bind (b e) (selection-range w)
         (case op
           ((cut clear)            
            (and (neq b e) #|(not (window-buffer-read-only-p w))|#))
           (copy
            (neq b e))
           (execute-selection
            (or (neq b e)
                (multiple-value-bind (start end)
                                     (buffer-current-sexp-bounds (fred-buffer w) b)
                  (neq start end)))))))))

(defun buffer-at-sexp-end (buf b e)
  (multiple-value-bind (start end)
                       (buffer-current-sexp-bounds buf b)
    (and start (eq end e))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;

;This "current-sexp" concept isn't all that bad, but it's a loss that it only
;applies to these few fry functions.  It needs to be better integrated with
;double-clicking and the sexp-related level-1/lib functions.  Also, what should
;happen if we started out in the middle of the "current sexp"?  Stay in place?
;Move over it?  We also need to standardize what happens when there's no
;"current sexp" - do nothing? beep? bring up a get-string dialog?

(defun buffer-current-sexp-start (buf &optional pos &aux char bwd-char)
  (when (null pos)(setq pos (buffer-position buf)))
  (setq char
        (cond ((eq pos (buffer-size buf)) #\return)
              ((buffer-lquoted-p buf pos) #\A)
              (t (buffer-char buf pos))))
  (setq bwd-char
        (cond ((eq pos 0) #\return)
              ((buffer-lquoted-p buf (1- pos)) #\A)
              (t (buffer-char buf (1- pos)))))
  (cond ((or (eq bwd-char #\)) (eq bwd-char #\"))
         (values (buffer-bwd-sexp buf pos) pos))
        ((or (eq char #\() (eq char #\")) pos)
        ((and (not (whitespacep bwd-char))
              (not (eq bwd-char #\()))
         ;we're in the middle of or just behind a symbol
         (buffer-bwd-sexp buf pos))
        ((not (whitespacep char))
         ;we're just in front of a symbol
         pos)
        (t nil)))

(defun buffer-current-sexp-bounds (buf &optional pos)
  (when (null pos)(setq pos (buffer-position buf)))
  (multiple-value-bind (start end)(buffer-current-sexp-start buf pos)
    (when start
       (when (null end)(setq end (buffer-fwd-sexp buf start)))
       (and end (values start end)))))

(defun buffer-current-sexp (buf &optional pos)
  (let ((b (buffer-current-sexp-start buf pos)))
    (when b
      (buffer-read buf b))))

(defmethod undo-more ((w fred-mixin))
  (let ((*last-command* (fred-last-command w)))
    (ed-history-undo w)
    (set-buffer-insert-font-index (fred-buffer w) nil)
    (set-fred-undo-string w nil :redo)
    (window-show-cursor w)
    ))


(defmethod ed-delete-with-undo ((w fred-mixin) start end
                                &optional (save-p t) reverse-p append-p
                                &aux
                                (buf (fred-buffer w))
                                (word-chars *fred-word-constituents*)
                                undo-cons string)
  "deletes range, saves deleted stuff on kill-ring,
   and returns the deleted string and style in a cons."
  (when (buffer-mark-p start)(setq start (buffer-position start)))
  (when (buffer-mark-p end)(setq end (buffer-position end)))
  (cond ((stringp end)(setq string end)(setq end (+ start (length string))))
        (t (setq string (buffer-substring buf start end))))
  (when (neq start end)
    (setq undo-cons (cons string (buffer-get-style buf start end))
          save-p (if (eq save-p :never) nil
                     (or save-p
                         (and (buffer-forward-find-char buf word-chars
                                                        start end)
                              (buffer-forward-find-not-char buf word-chars
                                                            start end)))))
    (ed-history-add w (min start end) undo-cons append-p reverse-p)
    (buffer-delete buf start end)
    ; today the undo stuff always remembers the style, but the kill ring may not
    (if (not (fred-copy-styles-p w))(setq undo-cons (cons string nil)))
    (if (eq *last-command* :kill)
        (progn
          (rplaca *killed-strings*
                  (if reverse-p
                    (concat-string-conses undo-cons
                                          (first-killed-string))
                    (concat-string-conses (first-killed-string)
                                          undo-cons)))
          (set-mini-buffer w "~&Appended to last kill"))
        (when save-p
          (add-to-killed-strings undo-cons)
          (set-mini-buffer w "~&Killed region saved")))
    (let ((last *last-command*))
      (unless (and (consp last) (eq (car last) 'undo))
        (set-fred-undo-stuff w :kill "Kill")))
    undo-cons))

;;;;;;;;;;;
;;cut, copy, and paste
;;
;;cut and copy move to both the kill-ring and scrap
;;paste uses the scrap
;;

(defmethod Cut ((w fred-mixin))
  (when (window-buffer-read-only-p w)
    (if (null (buffer-whine-read-only w))
      (return-from cut)))
  (Copy w)
  (set-fred-last-command w nil)      
  (rplaca *killed-strings* (cons "" nil))
  (clear-1 w "Cut"))

(defmethod Copy ((w fred-mixin) &aux
                 (frec (frec w))
                 (buf (fred-buffer w)))
  (multiple-value-bind (b e) (frec-get-sel frec)
    (when (neq b e)
      (let ((copy-styles (fred-copy-styles-p w)))
        (when (and (boundp '*current-event*) (shift-key-p))
          (setq copy-styles (not copy-styles)))
        (put-scrap :fred (cons (buffer-substring buf b e)
                               (if copy-styles
                                 (buffer-get-style buf b e))))
        (set-buffer-insert-font-index (fred-buffer w) nil) ; 5/28
        (set-fred-last-command w :kill)))))

(defmethod Clear ((w fred-mixin))
  (when (window-buffer-read-only-p w)
    (if (null (buffer-whine-read-only w))
      (return-from clear)))  
  (set-buffer-insert-font-index (fred-buffer w) nil)  ; 5/28
  (clear-1 w "Clear"))

(defun Clear-1 (w string &aux
                  (frec (frec w)))
  (multiple-value-bind (b e) (frec-get-sel frec)
    (when (neq b e)
      (let* ((*last-command* (fred-last-command w)))
        (declare (special *last-command*))
        (ed-delete-with-undo w b e)
        (set-fred-undo-stuff w :clear string)
        (maybe-update-debutton w)
        (window-show-cursor w)))))

(defun maybe-update-debutton (w)
  (let ((p (view-container w)))
    (when (and p (method-exists-p 'update-default-button p))
      (update-default-button p))))

(defmethod Paste :around ((w fred-mixin))
  (declare (ignore w))
  (if (and (boundp '*current-event*) (shift-key-p))
    (let ((*paste-with-styles* (not *paste-with-styles*)))
      (call-next-method))
    (call-next-method)))

(defmethod Paste ((w fred-mixin))
  (when (window-buffer-read-only-p w)
    (if (null (buffer-whine-read-only w))
      (return-from paste)))
  (if (get-scrap-flavor-flags :|utxt|)
    (paste-styled-utxt w)
    (let* ((scrap (get-scrap :fred))
           (string (car scrap))
           (frec (frec w)))
      (If string
        (multiple-value-bind (b e) (frec-get-sel frec)
          (let* ((*last-command* (fred-last-command w))
                 (lc *last-command*))
            (declare (special *last-command*))
            (when (neq b e)
              (ed-delete-with-undo w b e))
            ; or *paste-with-styles* ?            
            (ed-insert-with-undo w (if (fred-copy-styles-p w) scrap string) b (neq b e)
                                 (when (and (consp lc)
                                            (eq (car lc) 'set-font)
                                            (add-buffer-font (fred-buffer w) (cadr lc) (caddr lc)))))
            ;(window-show-cursor w)
            (set-fred-undo-stuff w :paste "Paste")
            (set-buffer-insert-font-index (fred-buffer w) nil)  ; 5/28
            (maybe-update-debutton w)            
            )
          (window-show-range w b (buffer-position (fred-buffer w)))
          (setq *show-cursor-p* nil))))))




(defun buffer-arglist-pos (buf &optional (val nil val-p) sym)
  (if (not val-p)
    (let ((pair (buffer-getprop buf :arglist-pos)))
      (if (consp pair) (values (car pair)(cdr pair)) pair))
    (buffer-putprop buf :arglist-pos (if val (cons (make-mark buf val t) sym) nil))))




(defmethod ed-backward-sexp ((w fred-mixin) &optional select
                             &aux
                             (frec (frec w))
                             (c (fred-buffer w))
                             (opos (buffer-position c))
                             pos)
  (when (not select)(collapse-selection w nil))
  (let ((n (fred-prefix-numeric-value w)))
    (cond ((%i< n 0)
           (setf (fred-prefix-argument w) (- n))
           (ed-forward-sexp w select))
          ((dotimes (i n t)
	     (declare (fixnum i))
             (setq pos (buffer-bwd-sexp c pos)) ; returns 0 if none
             (when (or (null pos)(eq pos opos))(return nil))
             (setq opos pos))
           (if select 
             (frec-extend-selection frec pos)
             (set-mark c pos)))
          (t (ed-beep)))))

(defmethod ed-backward-select-sexp ((w fred-mixin))
  (ed-backward-sexp w t))



(defmethod ed-forward-sexp ((w fred-mixin) &optional select
                            &aux
                            (frec (frec w))
                            (c (fred-buffer w))
                            (opos (buffer-position c))
                            pos)
  (when (not select)(collapse-selection w t))
  (let ((n (fred-prefix-numeric-value w)))
    (cond ((%i< n 0)
           (setf (fred-prefix-argument w) (- n))
           (ed-backward-sexp w select))
          ((dotimes (i n t)
	     (declare (fixnum i))
             (setq pos (buffer-fwd-sexp c pos))
             (when (or (null pos)(eq pos opos))
               (return nil))
             (setq opos pos))
           (if select
             (frec-extend-selection frec pos)
             (set-mark c pos))
           (window-scroll-to-bottom w pos))              
          (t (ed-beep)))))

(defmethod ed-forward-select-sexp ((w fred-mixin))
  (ed-forward-sexp w t))

(defmethod ed-select-next-list ((w fred-mixin))
  (ed-next-list w t))
; c-m-n
(defmethod ed-next-list ((w fred-mixin) &optional select
                         &aux 
                         (frec (frec w))
                         (c (fred-buffer w))
                         (pos (buffer-position c))
                         (opos pos))
  (when (not select)(collapse-selection w nil))
  (let ((n (fred-prefix-numeric-value w)))
    (cond 
     ((%i< n 0)
      (setf (fred-prefix-argument w) (- n))(ed-previous-list w))
     (t  (loop
           (setq pos (buffer-fwd-sexp c pos))
           (cond ((and pos (neq pos opos))
                  (when (eql (buffer-char c (1- pos)) #\))
                    (setq n (%i- n 1))
                    (when (%i<= n 0)
                      (if select
                        (frec-extend-selection frec pos)
                        (set-mark c pos))
                      (window-scroll-to-bottom w pos)
                      (return))))
                 (t (ed-beep)(return)))
           (setq opos pos))))))

(defmethod ed-select-previous-list ((w fred-mixin))
  (ed-previous-list w t))

; c-m-p
(defmethod ed-previous-list ((w fred-mixin) &optional select
                             &aux 
                             (frec (frec w))
                             (c (fred-buffer w))
                             (pos (buffer-position c))
                             (opos pos))
  (when (not select)(collapse-selection w nil))
  (let ((n (fred-prefix-numeric-value w)))
    (cond
     ((%i< n 0)
      (setf (fred-prefix-argument w) (- n))(ed-next-list w))
     (t (loop
          (setq pos (buffer-bwd-sexp c pos)) ; rets 0 if no more
          (cond ((and pos (not (eq pos opos)))
                 (when (eql (buffer-char c pos) #\()
                   (setq n (%i- n 1))
                   (when (%i<= n 0)
                     (if select
                       (frec-extend-selection frec pos)
                       (set-mark c pos))
                     (return))))
                (t (ed-beep)(return)))
          (setq opos pos))))))

; do these calls to collapse-sel make sense?? - nooooo
; collapse-selection nukes a selection and puts point at beginning or end 
; c-m-u
(defmethod ed-bwd-up-list ((w fred-mixin) &optional n &aux 
                           (c (fred-buffer w))
                           (pos (buffer-position c)))
  (collapse-selection w nil)
  (when (null n)(setq n (fred-prefix-numeric-value w)))
  (let (fwdp)
      (when (%i< n 0)(setq fwdp t)(setq n (- n)))
      (loop
        (setq pos (if fwdp
                    (buffer-fwd-up-sexp c pos)
                    (buffer-bwd-up-sexp c pos)))
        (cond ((and pos (eql (buffer-char c (if fwdp (%i- pos 1) pos)) (if fwdp #\) #\()))
               (setq n (%i- n 1))
               (when (%i<= n 0)
                 (set-mark c pos)(return)))
              ((not pos) (ed-beep)(return))))))

; c-m-d - maybe
(defmethod ed-down-list ((w fred-mixin) &aux 
                           (c (fred-buffer w))
                           (pos (buffer-position c))
                           (end (buffer-size c)))
  (collapse-selection w nil)
  (let ((n (fred-prefix-numeric-value w)))
    (cond ((minusp n) (ed-beep))
          (t
           (setq pos (buffer-skip-fwd-wsp&comments c pos end))
           (loop 
             (when pos
               (let ((ch (buffer-char c pos)))
                 (cond ((eql ch #\))(setq pos nil))
                       ((eql ch #\()
                        (setq pos (when (%i< pos end)(+ 1 pos)))
                        (setq n (1- n))))))
             (when (or (%i<= n 0)(null pos))(return))
             (setq pos (buffer-fwd-sexp c pos))
             (when pos (setq pos (buffer-skip-fwd-wsp&comments c pos end))))
           (cond (pos
                  (set-mark c pos))
                 (t (ed-beep)))))))

; c-m-)
(defmethod ed-fwd-up-list ((w fred-mixin))
  (ed-bwd-up-list w (- (fred-prefix-numeric-value w))))
  

(defmethod fred-prefix-numeric-value ((w fred-mixin))
  (let ((arg (fred-prefix-argument w)))
    (cond ((null arg) 1)
          ((eq arg 'minus) -1)
          ((listp arg) (car arg))
          ((fixnump arg) arg)
	  (t 1))))
; c-m-l
(defmethod ed-last-buffer ((w fred-mixin))
  (let ((n (fred-prefix-numeric-value w)))
    (setq w (view-window w))
    (if *modal-dialog-on-top*
      (ed-beep)
      (let* ((temp #'(lambda (window)
                       (unless (or (eq w window) (not (typep window 'fred-window)))
                         (setq n (1- n))
                         (when (< n 1)
                           (window-select window)
                           (return-from ed-last-buffer window))))))
        (declare (dynamic-extent temp))
        (setq *show-cursor-p* nil)
        (map-windows temp)))))

#|
(defmethod ed-self-insert ((w fred-mixin))
  (dotimes (i (fred-prefix-numeric-value w))
    (declare (fixnum i))
    (ed-insert-char w *current-character*)))
|#

#|
(defmethod ed-self-insert ((w fred-mixin))
  (let ((char (convert-char-to-unicode *current-character* (font-to-encoding-no-error (ash (view-font-codes w) -16)))))
    (dotimes (i (fred-prefix-numeric-value w))
      (declare (fixnum i))
      (ed-insert-char w char))))
|#


(defmethod ed-self-insert-maybe-LF ((w fred-mixin))
  (let ((char *current-character*))
    (if (and (eq char #\return) (eq *preferred-eol-character* #\linefeed))
      (setq *current-character* #\linefeed))
    (ed-self-insert w)))

;; now does the right thing for fonts symbol and dingbats
;; and doesn't louse up e.g. ctrl-q option-n n
(defmethod ed-self-insert ((w fred-mixin))
  (let* ((char *current-character*)
         (buffer (fred-buffer w))
         ;(insert-idx (buffer-insert-font-index buffer))
         )
    (multiple-value-bind (ff ms)(buffer-font-codes buffer)
      (let ((encoding (font-to-encoding-no-error (ash ff -16))))
        (setq char (convert-char-to-unicode char encoding))
        (dotimes (i (fred-prefix-numeric-value w))
          (declare (fixnum i))
          (ed-insert-char w char)
          (when (eq encoding #$kcfstringencodingmacsymbol)  ;;  needed - else font may become OSAKA - encoding-for-uchar sometimes Japanese
            (let ((pos (buffer-position buffer)))
              (buffer-set-font-codes buffer ff ms (1- pos) pos))))
        ;; some macsymbol chars become Japanese - put font back for next typing
        #+ignore
        (if (and insert-idx (eq encoding #$kcfstringencodingmacsymbol))
          (set-buffer-insert-font-index buffer insert-idx))))))

(defmethod ed-digit ((w fred-mixin))
  (declare (special *prefix-command-p*))
  (if (fred-prefix-argument w)
    (progn (setq *prefix-command-p* t)
           (ed-numeric-argument w))
    (ed-self-insert w)))

(defmethod ed-open-line ((w fred-mixin))
  (let ((n (fred-prefix-numeric-value w))
        (eol-char (or *preferred-eol-character* #\return)))
    (when (> n 0)
      (if (eq n 1)
        (ed-insert-char w eol-char)  ; use ed-insert-char so c-m-o in listener will be bold
        (ed-insert-with-undo w (make-string n :element-type 'base-character 
                                            :initial-element eol-char)))
      (move-mark (fred-buffer w) (- n)))))

; c-m-o
(defmethod ed-split-line ((w fred-mixin) &aux
                          (buf (fred-buffer w))
                          (ipos (buffer-position buf))
                          (pos (buffer-forward-find-not-char buf wsp ipos)))
  (when pos
    (decf pos)
    (let ((b (buffer-line-start buf ipos)))
      (set-mark buf pos)
      (ed-open-line w) ; inserts n new lines leaving cursor where it was
      ; bug if prefix is  <= 0
      (set-mark buf (+ pos (fred-prefix-numeric-value w)))
      (ed-insert-with-undo w (make-string (- pos b) :element-type 'base-character :initial-element #\space) (buffer-position buf) t)
      (set-mark buf pos))))

; backward delete
(defmethod ed-rubout-char ((w fred-mixin))
  (ed-delete-n w (- (fred-prefix-numeric-value w))))

; c-d and delete fwd
(defmethod ed-delete-char ((w fred-mixin))
  (ed-delete-n w (fred-prefix-numeric-value w)))

(defmethod ed-delete-n ((w fred-mixin) n)
  (multiple-value-bind (b e) (frec-get-sel (frec w))
    (if (neq b e)
      (clear w)
      (let* ((buf (fred-buffer w))
             (size (buffer-size buf))
             (pos (buffer-position buf))
             (end (+ pos n)))
        (when (%i> pos end)
          (psetq pos end end pos))            
        (if (%i< pos 0) (setq pos 0)
            (if (%i< size end) (setq end size)))
        (if (<= -1 n 1)
          (progn (set-fred-undo-stuff w :kill-1 "Kill") ; history may change this
                 (ed-delete-with-history w pos end (eq *last-command* :kill-1)(< n 0)))
          (ed-delete-with-undo w pos end t (< n 0)))))))


(defmethod ed-kill-line ((w fred-mixin) &aux 
                         (frec (frec w))
                         (c (fred-buffer w))
                         (end (buffer-size c)))
  (let ((n (fred-prefix-argument w)) b e)
    (cond ((null n)
           (multiple-value-setq (b e) (frec-get-sel frec))
           (when (and (eq b e)
                      (or (eq b (setq e (buffer-line-end c)))
                          (%i> (buffer-forward-find-not-char c wsp b end) e))
                      (neq e end))
             (setq e (%i+ e 1))))           
          (t (setq n (fred-prefix-numeric-value w))
             (setq b (buffer-position c))
             (cond ((or (>= n 0)(eq b (buffer-line-start c b 0)))
                    (setq e (buffer-line-start c b n)))
                   (t (setq e (buffer-line-start c b (1+ n)))))))
    (ed-delete-with-undo w b e t (and n (<= n 0)))))             

(defmethod ed-end-of-line ((w fred-mixin) &aux
                           (c (fred-buffer w)))
  (collapse-selection w t)
  (if (fred-word-wrap-p w)
    (let ((end (frec-screen-line-start (frec w)(buffer-position c) 1)))      
      (set-mark c (if (eql end (buffer-size c)) end (1- end))))
    (set-mark c (buffer-line-end c))))

(defmethod ed-select-end-of-line ((w fred-mixin))
  (frec-extend-selection (frec w) (buffer-line-end (fred-buffer w))))

(defmethod ed-end-of-buffer ((w fred-mixin))
  (ed-push-mark w)
  (frec-set-sel (frec w) t t))


(defmethod ed-forward-word ((w fred-mixin) &aux
                            (c (fred-buffer w)))
  (multiple-value-bind (pos end fwd)
                       (fred-selection-for-word-command w t)
    (when (and pos end)
      (setq pos (if fwd end pos))
      (set-mark c pos)
      pos)))

(defmethod ed-beginning-of-line ((w fred-mixin) &aux
                                 (c (fred-buffer w)))
  (collapse-selection w nil)
  (if (fred-word-wrap-p w)
    (let* ((frec (frec w))
           (curpos (buffer-position c))
           (line-pos 
            (let ((pos (frec-screen-line-start frec curpos)))
              (when (and (eql curpos (buffer-size c))(eql pos curpos))  ; happens at buffer end with no newline
                (setq pos (frec-screen-line-start frec curpos -1)))
              pos)))
      ;(set-mark c line-pos)
      ;; do the following dance to ensure that the cursor is at
      ;; the beginning of the line rather than the end it has a habit of going to.
      (unless (eql line-pos (buffer-size c))
        (set-mark c (1+ line-pos))) ;(ed-forward-char w)
      (fred-update w)
      (set-mark c line-pos)) ; w))
    (set-mark c (buffer-line-start c))))

(defmethod ed-select-beginning-of-line ((w fred-mixin))
  (frec-extend-selection (frec w) (buffer-line-start (fred-buffer w))))


(defmethod ed-beginning-of-buffer ((w fred-mixin))
  (ed-push-mark w)
  (frec-set-sel (frec w) 0 0))

(defmethod ed-forward-char ((w fred-mixin) &optional (fwd t) select)
  (let* ((frec (frec w))
         (pfx (fred-prefix-numeric-value w))
         (n (if fwd pfx (- pfx))))
    (when (< n 0)
      (setq fwd nil))
    (when (or select (null (collapse-selection w fwd)) (fred-prefix-argument w)) ; << was pfx
      (let* ((buf (fred-buffer w))
             (pos (buffer-position buf))
             (end (+ pos n)))
        (cond
         ((> end (buffer-size buf))(ed-beep))
         ((< end 0) (ed-beep))
         (select (frec-extend-selection frec end pos))
         (t (set-mark buf end)))))))

(defmethod ed-backward-char ((w fred-mixin))
  (ed-forward-char w nil))

(defmethod ed-forward-select-char ((w fred-mixin))
  (ed-forward-char w t t))

(defmethod ed-backward-select-char ((w fred-mixin))
  (ed-forward-char w nil t))

(defun frec-extend-selection (frec end &optional (beg (buffer-position (fr.cursor frec))))
    (multiple-value-bind (ibeg iend)
                         (frec-get-sel frec)
      (cond
       ((eq ibeg iend)
        (frec-set-sel frec beg end))
       ((eq beg ibeg)
        (frec-set-sel frec iend end))
       ((eq beg iend)
        (frec-set-sel frec ibeg end))
       (t (error "Shouldnt")))))


(defmethod ed-backward-word ((w fred-mixin) &optional fwd &aux
                             (c (fred-buffer w)))
  (multiple-value-bind (pos end fwd)
                       (fred-selection-for-word-command w fwd)
    (when (and pos end)
      (setq pos (if fwd end pos))
      (set-mark c pos)
      pos)))

; numeric args work but kinda silly cause awkward to type
; start, extend, or shrink selection
(defmethod ed-backward-select-word ((w fred-mixin) &optional fwd &aux
                                    (buf (fred-buffer w))
                                    (frec (frec w))
                                    (pos (buffer-position buf)))
  (multiple-value-bind (ibeg iend)
                       (selection-range w)
    (multiple-value-bind (beg end fwd)
                         (fred-selection-for-word-command w fwd t)
      ; beg and end are hunk to add or subtract to/from current region
      (when (and beg end)
        (when (neq ibeg iend)
          ; adjust for shrinking unless nuking - is this really necessary?
          ; MPW doesnt do it
          (let ((roman nil)) ;(if (not fwd) (buffer-roman buf 0 beg)(buffer-roman buf end))))
            (cond ((not fwd)
                   (when (and (eq pos iend)(neq ibeg beg))
                     (setq beg (1+ (or (if roman
                                         (buffer-backward-find-char buf *fred-word-constituents* beg)
                                         (buffer-backward-not-break-char buf beg))
                                       -1)))))
                  (t (when (and (eq pos ibeg)(neq iend end))
                       (setq end (1- (or 
                                      (if roman
                                        (buffer-forward-find-char buf *fred-word-constituents* end)
                                        (buffer-forward-not-break-char buf end))
                                      (buffer-size buf)))))))))
        (frec-extend-selection frec (if fwd end beg) (if fwd beg end))))))



(defmethod ed-forward-select-word ((w fred-mixin))
  (ed-backward-select-word w t))
 

(defmethod ed-next-line ((w fred-mixin) &optional n)
  (set-mark (fred-buffer w) (ed-next-line-pos w nil n)))

(defun ed-next-line-pos (w &optional select n)
  (when (null n)(setq n (fred-prefix-numeric-value w)))
  (let* ((c (fred-buffer w))
         (frec (frec w)))    
    (when (null select)(collapse-selection w (>= n 0)))
    (if (fr.word-wrap-p frec)
      (ed-next-line-pos-wrap w n)
      (let* ((line-pos (buffer-line-start c))
             (new-line-pos (buffer-line-start c line-pos n))
             (goal-pos (+ new-line-pos
                          (if (eq *last-command* 'vertical-motion)
                            (slot-value w 'goal-column)
                            (setf (slot-value w 'goal-column)
                                  (- (buffer-position c) line-pos)))))
             (end-pos (buffer-line-end c new-line-pos)))
        (when (< end-pos goal-pos) (setq goal-pos end-pos))
        (set-fred-last-command w 'vertical-motion)
        (values goal-pos (>= n 0))))))


(defun ed-next-line-pos-wrap (w n)
  (let* ((c (fred-buffer w))
         (frec (frec w)))
    (let* ((curpos (buffer-position c))
           (line-pos 
            (let ((pos (%frec-screen-line-start frec curpos)))
              (when (and (eql pos curpos)(eql curpos (buffer-size c))(minusp n))  ; happens at buffer end with no newline
                (setq pos (%frec-screen-line-start frec curpos -1)))
              pos))
           (new-line-pos (%frec-screen-line-start frec line-pos n))
           (goal-pos (+ new-line-pos
                        (if (eq *last-command* 'vertical-motion)
                          (slot-value w 'goal-column)
                          (setf (slot-value w 'goal-column)
                                (- (buffer-position c) line-pos)))))
           (end-pos 
            (let* ((end (%frec-screen-line-start frec new-line-pos 1)))
              end)))
      (when (< end-pos goal-pos) 
        (setq goal-pos (if (eql end-pos (buffer-size c)) end-pos (1- end-pos))))
      (set-fred-last-command w 'vertical-motion)
      (values goal-pos (>= n 0)))))
 
(defmethod ed-previous-line ((w fred-mixin))
  (ed-next-line w (- (fred-prefix-numeric-value w))))

(defmethod ed-select-next-line ((w fred-mixin) &optional n &aux 
                                (frec (frec w)))
  (when (null n)(setq n (fred-prefix-numeric-value w)))
  (let ((goal-pos (ed-next-line-pos w t n)))
    (frec-extend-selection frec goal-pos)))

(defmethod ed-select-previous-line ((w fred-mixin))
  (ed-select-next-line w (- (fred-prefix-numeric-value w))))

(defmethod collapse-selection ((w fred-mixin) fwdp)
  (let ((frec (frec w)))
    (multiple-value-bind (b e) (frec-get-sel frec)
      (when (neq b e)
        (cond 
         ((eq fwdp :dont) (frec-set-sel-simple frec))
         (t (when fwdp (setq b e))
            (frec-set-sel frec b b)))
        t))))

(defmethod ed-indent-for-lisp ((w fred-mixin) &optional b e &aux 
                               (frec (frec w))
                               (c (fred-buffer w)) fwd)
  (unless (and b e) 
    (multiple-value-setq (b e) (frec-get-sel frec))
    (when (neq b e) (if (eq e (buffer-position c))(setq fwd t))))
  (prog* ((pos (buffer-line-start c b))
          (two (or (eq (fred-last-command w) :append)(and (eq b e)(eq *last-command* :self-insert))))
          ; & remember listener oddness
          (cnt -1)
          defun ind)
    (set-mark c e)
    loop
    (when (<= cnt 0)
      (incf cnt)
      #+ignore
      (setq defun (or (buffer-backward-search c " 
\(" pos) 0))
      #-ignore
      (setq defun (or  (ed-top-level-sexp-start-pos c pos) 0))
      (when (typep w 'listener-fred-item)
        (let ((pos2 (buffer-backward-search c "
? (" pos)))
          (when pos2 (setq defun (max pos2 defun))))))
    (when (setq ind (lisp-indentation c defun pos))
      (if (align-pos&target w pos ind two) (setq two t)))
    (setq pos (buffer-line-start c pos 1))
    (when (%i< pos (buffer-position c)) (go loop))
    (when (and two (eq b e))(set-fred-last-command w :self-insert))
    (collapse-selection w fwd)))

(defun align-pos&target (w pos ind &optional append &aux
                           (frec (frec w)) 
                           (c (fred-buffer w)))
  (let ((font-index (buffer-char-font-index c pos)))
    (let* ((epos (buffer-fwd-skip-wsp c pos))
           (epos-hpos (frec-hpos frec epos)) 
           (ind-hpos (frec-hpos frec ind)))
      (cond ((> epos-hpos ind-hpos)
             (when (neq pos epos)
               (ed-delete-with-history w pos epos append)
               (setq append t)))
            ((< epos-hpos ind-hpos)
             (setq pos epos)))
      (when (neq epos-hpos ind-hpos)
        (set-buffer-insert-font-index c font-index)
        (setq epos (frec-indent-to-col frec pos ind-hpos))
        (ed-history-add w pos (make-string (- epos pos) :element-type 'base-character :initial-element #\space) append)
        (setq append t))
      (when (< (buffer-position c) epos) (set-mark c epos))    
      append)))


; c-tab
(defmethod ed-indent-differently ((w fred-mixin))
  (let* ((frec (frec w))
         (c (fred-buffer w)))
    (collapse-selection w nil)
    (let* ((pos (buffer-line-start c (buffer-position c)))
           (b (min (buffer-line-end c pos)(buffer-fwd-skip-wsp c pos)))           
           (start (or (ed-top-level-sexp-start-pos c pos) 0))  ;was (or (buffer-backward-search c "
                                                               ;\(" pos) 0))
           (ind (lisp-indentation c start pos)))
      (when ind
        (when (not (< (frec-hpos frec b) (frec-hpos frec ind)))
          (let ((ind-max (buffer-line-end c ind))
                (next ind))
            (cond 
             ((loop
                (setq next (buffer-fwd-sexp c next))                
                (cond (next
                        (setq next (buffer-fwd-skip-wsp c next))
                        (cond ((< next ind-max)
                               (when (< (frec-hpos frec b)(frec-hpos frec next))
                                 (setq ind next)
                                 (return t)))
                              (t (return))))
                       (t (return)))))
              (t (setq ind (+ 1 (or (buffer-bwd-up-sexp c ind) -1)))))))
        (align-pos&target w pos ind)))))
    

(defun frec-indent-to-col (frec pos hpos)
  (while (%i< (frec-hpos frec pos) hpos) ;Nobody could accuse us of efficiency!
    (buffer-insert (fr.cursor frec) #\space pos)
    (setq pos (%i+ pos 1)))
  pos)

(defmethod ed-insert-with-style ((w fred-mixin) string style &optional pos)
  "inserts string with given style.  shadowed by the listener"
  (when string
    (buffer-insert-with-style (fred-buffer w)
                              string
                              (if *paste-with-styles* style)
                              pos)))

(defmethod fred-point-position ((w fred-mixin) h &optional v)
  (let ((frec (frec w)))
    (frec-point-pos frec (make-point h v))))

(defmethod fred-hpos ((w fred-mixin) &optional pos)
  (frec-screen-hpos (frec w) pos))

(defmethod fred-vpos ((w fred-mixin) &optional (pos (buffer-position (fred-buffer w))))
  (let ((point (%screen-point (frec w) pos)))
    (if point (point-v point) -1)))

(defmethod fred-line-vpos ((w fred-mixin) line-num)
  (frec-screen-line-vpos (frec w) line-num))

; c-x c-p ?
;; find unbalanced paren or #comment, beep if none found
;; should be meta-x f u if only we had meta-x
(defmethod ed-find-unbalanced-paren ((w fred-mixin))
  (let* ((buf (fred-buffer w))
         (pos 0)
         (nextpos 0)
         (end (buffer-size buf)))
    (loop
      (tagbody
        top
        (when (eq pos end)(ed-beep)(return nil))
        (let ((fpos (buffer-forward-find-not-char buf wsp&cr pos)))
          (when (null fpos)(ed-beep)(return nil))
          (setq pos (1- fpos)))
        (when (eql (buffer-char buf pos) #\;)
          (let ((nextpos (buffer-forward-find-eol buf pos)))
            (when (not nextpos) (ed-beep)(return nil))
            (setq pos nextpos)
            (go top)))
        (when (eq pos end)(ed-beep)(return nil))
        (setq nextpos (buffer-fwd-sexp buf pos))  ; screwy if ; comment followed by right paren
        (when (null nextpos)
          ;(set-mark buf pos)          
          (set-selection-range w pos (1+ pos))
          (return pos))
        (when (eq nextpos (1+ pos))
          ;(set-mark buf pos)
          (set-selection-range w pos (1+ pos))
          (return pos))
        (setq pos nextpos)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; History and undo

;(defvar *ed-history-length* 20)  ; ? how long should this be - maybe 40?
; 
; length 1 gets you undo on the edit menu - does listener want that ??????
; maybe include it with length = 1, and release note if one wants more.

; make this belong to fred windows - not to listener!?
; do history iff window has one 
(defun make-fred-history (length)
  (if (null length)(setq length 1))  ; used to do (list nil) which doesn't work
  (cond ((eql length 0)
         nil)
        (t (let ((l (make-list length)))
             (rplacd (last l) l)
             l))))

(defun history-length (thing)
  (let ((i 0) (ls thing) saved-p)
    (when ls
      (loop
        (when (eq :saved (car ls))(setq saved-p t))
        (setq i (+ i 1))      
        (setq ls (cdr ls))
        (when (or (null ls)(eq ls thing))
          (return))))
    (values i saved-p)))


  

; make this user friendly some how - use format
; truncate strings to a line or 2 & put it on a key
(defun ed-print-history (w)
  (flet ((print-hist-sub (thing) 
          (let (string)
            (cond ((consp (cdr thing))
                   (setq string (cadr thing))
                   (format t "~A" "delete "))
                  (t (setq string (cdr thing))
                     (format t "~A" "insert ")))
            (print-hist-string string t)
            (format t "~D" (car thing)))))                                                                                                     	
    (let ((length (history-length (fred-history w))))
      (dotimes (i (if (null length) 25 (min length 25))) 
        (declare (fixnum i))
        (let ((thing (ed-history-get w i)))
          (format t "~%~D~3T" i)
          (cond ((memq thing '(:bogus :saved))
                 (format t "~S" thing))
                ((fixnump (car thing))
                 (print-hist-sub thing))
                ((consp (car thing))
                 (let ((one t))
                 (dolist (e thing)
                   (when (not one)(format t "~%   "))
                   (setq one nil)
                   (print-hist-sub e))))
                (t (format t "~S"  thing))))))))

; maybe nuke or elide leading whitespace, or show the whole string?
; unless its huge 
(defun print-hist-string (string stream)
  (cond ((< (length string) 40)
         (format stream "~s~50,0T" string))
        (t (format stream "~s...~50,0T" (%substr string 0 37)))))

    
; insert - pos . string
; delete - pos . undo-cons
; car may also be a function taking args w and cdr
; function . arg
; if append, merge sequential inserts or delete
; maybe out of order undo's can't work??

(defmethod ed-history-add ((w fred-mixin) start string/cons &optional append-p bwdp) ; beware of appending deletions if dunno if bwd
  ;(declare (ignore w))
  (let ((hist (fred-history w))
        (history-added-bound (boundp '*history-added*)))
    (when hist
      ;(when (and (eq start :bogus)(not (typep w 'listener))) (break))
      (when (buffer-mark-p start)(setq start (buffer-position start)))
      (when (buffer-mark-p string/cons)(setq string/cons (buffer-position string/cons)))
      (when (and history-added-bound (not append-p)(not (memq start '(:bogus :saved))))
        (setq append-p *history-added*))
      (let ((olde (car hist))
            newstyle pstart pend prev ilen)
        (when (and olde (not (memq olde '(:bogus :saved))))
          (setq prev (if (consp (car olde))(car olde) olde)
                pstart (car prev)
                pend (cdr prev)))        
        (cond ((and prev
                    (eq *last-command* :self-insert)  ; the one before this
                    (fixnump pstart)
                    (eq :kill-1 (fred-last-command w))  ; this one
                    (consp string/cons)(not (consp pend)) ; ?delete of thing just inserted
                    ;(eq 1 (length (car string/cons))) ; :kill-1 assures this                    
                    bwdp
                    (setq ilen (length pend))
                    (eq start (1- (+ pstart ilen)))
                    (> ilen 1))
               (set-fred-undo-stuff w :self-insert "Typing")
               (rplacd prev (%substr pend 0 (1- ilen))))
              ((and prev append-p)
               (when (and (consp olde)(not (consp (car olde))))
                 (setq olde (list olde)))
               (let* ()
                 (cond ((and (fixnump start)(fixnump pstart)(consp string/cons)(consp pend)  ; consecutive deletions
                             (if (not bwdp) 
                               (eq pstart start)
                               (eq pstart (+ start (length (car string/cons)))))
                             (setq newstyle (merge-styles (%cdr string/cons)(%cdr pend))))
                        (rplacd pend newstyle)
                        (when bwdp (rplaca prev start))
                        (rplaca pend                             
                                (if (not bwdp)
                                 (%str-cat (%car pend)(%car string/cons))
                                 (%str-cat (%car string/cons) (%car pend)))))
                       ((and (fixnump start)(fixnump pstart)(not (consp string/cons))(not (consp pend)) ; consecutive insertions
                             (or (when (eq start (+ pstart (length pend)))
                                   ; two insertions in forward order
                                   (rplacd prev (%str-cat pend string/cons))
                                   t)
                                 (when (eq (+ start (length string/cons)) pstart)
                                   ; two insertions in backward order - huh?
                                   (rplacd prev (%str-cat string/cons pend))
                                   t))))
                       (t (rplaca hist (cons (cons start string/cons) olde))))))
              (t (set-fred-undo-string w nil) ; any body who wants an undo string should set it after history-add 
                 (set-fred-history w (setq hist (cdr hist)))
                 (rplaca hist (if (memq start '(:bogus :saved)) start (cons start string/cons))))))
      (when history-added-bound (setq *history-added* t)))
  start))

(defun merge-styles (style1 style2)
  ; do the simplest - contain one font and its the same - just fiddle the end
  (if (not (and (arrayp style1)(arrayp style2)))
    (if (equalp style1 style2) style1)
    (when (and (eq 1 (uvref style1 0))(eq 1 (uvref style2 0)) ; nfonts
               (eq (uvref style1 1)(uvref style2 1))  ; font face
               (eq (uvref style1 2)(uvref style2 2)) ; font mode
               (eq (length style1) 7)(eq (length style2) 7))  ; this almost has to be true
      ; can we just bash one of the styles????
      (let* ((newstyle (copy-uvector style1))
             (w1 (uvref newstyle 5))
             (w2 (uvref newstyle 6))
             (w3 (uvref style2 5))
             (w4 (uvref style2 6)))      
        (setq w1 (logior (ash w1 16) w2))
        (setq w3 (+ w1 (logior (ash w3 16) w4)))
        (setf (uvref newstyle 5)(ash w3 -16))
        (setf (uvref newstyle 6)(logand w3 #xffff))
        newstyle))))
#|
; fancier merge styles - is this worth the trouble - just store a list of lists!
; assume these are for the same buffer
(defun merge-styles (style1 style2)
  ; do the simplest - contain one font and its the same - just fiddle the end
  (if (not (and (arrayp style1)(arrayp style2)))
    (if (equalp style1 style2) style1)
    (let* ((nfonts1 (uvref style1 0))
           (nfonts2 (uvref style2 0))
           (nfonts nfonts1))
      (do ((i 1 (+ i 2)))
          ((eq i (+ nfonts2 nfonts2)))
        (let ((ff (uvref style2 i))
              (ms (uvref style2 (+ i 1))))
          (when
            (do ((j 1 (+ j 2)))
                ((eq j (+ nfonts1 nfonts1)) t)
              (cond ((and (eq ff (uvref style1 j))
                          (eq ms (uvref style1 (+ j 1))))
                     (return))))
            (setq nfonts (1+ nfonts)))))
      (let ((newstyle (make-array (+ 1 nfonts nfonts (- (length style1) (+ nfonts1 nfonts1 1))
                                     (- (length style2)(+ nfonts2 nfonts2 1))))))
        ; unless of course they run together
        (setf (uvref newstyle 0) nfonts)
        (do ((i 1 (+ i 2)))
            ((eq i (+ nfonts1 nfonts1)))
          (setf (uvref newstyle i)(uvref style1 i))
          (setf (uvref newstyle (+ i 1)(uvref style1 (+ i 1)))))
        (let ((idx (+ nfonts1 nfonts1 1)))
          (dotimes (i nfonts2)
            (let ((ff (uvref style2 (+ i i 1)))
                  (ms (uvref style2 (+ i i 2))))
              (when
                (do ((j 1 (+ j 2)))
                    ((eq j (+ nfonts1 nfonts1)) t)
                  (cond ((and (eq ff (uvref style1 j))
                              (eq ms (uvref style1 (+ j 1))))
                         (return))))
                (setf (uvref newsytle idx) ff)
                (setf (uvref newstyle (+ idx 1)) ms)
                (setq idx (+ idx 2)))))
          (do ((j (+ 1 nfonts1 nfonts1) (+ j 2)))
              ((eq j (length style1)))
            (setf (uvref newstyle idx) (uvref style1 j))
            (setf (uvref newstyle (+ idx 1))(uvref style1 (+ j 1)))
            (setq idx (+ idx 2)))
          (
|#  


(defmethod ed-replace-with-undo ((w fred-mixin) start end string &optional append-p)
  (let ((buf (fred-buffer w)))
    (when (buffer-mark-p start)(setq start (buffer-position start)))
    (when (buffer-mark-p end)(setq end (buffer-position end)))
    (cond ((fred-history w)
           (when (neq start end)
             (ed-delete-with-history w start end append-p)
             (setq append-p t))
           (ed-insert-with-undo w string start append-p)
           (set-fred-undo-stuff w :replace "Replace"))
          (t (when (neq start end)(buffer-delete buf start end))
             (buffer-insert buf string start)
             nil))))

(defun ed-history-get (w &optional (n 0) end)
  ;(declare (ignore w))
  ; get nth back
  (let* ((hist (fred-history w))
         (val (when hist
                (cond ((eq n 0)
                       (car hist))
                      (t (let ((b1 hist)
                               (s1 hist))
                           (dotimes (i n)
                             (setq s1 (cdr s1))
                             (when (eq s1 hist)(return-from ed-history-get nil)))
                           (loop                 
                             (when (eq s1 hist) (return (car b1)))
                             (setq s1 (cdr s1))
                             (setq b1 (cdr b1)))))))))
    (if (or end (neq val :bogus)) val nil)))

(defun clear-edit-history (w)
  (let ((hist (fred-history w)))
    (when hist
      (let ((hh hist))
        (loop 
          (rplaca hh nil)
          (setq hh (cdr hh))
          (when (eq hh hist)(return)))))))
        

(defmethod ed-history-undo ((w fred-mixin))
  (let ((last *last-command*)
        (undo-n 0))
    (cond ((and (consp last)(eq (car last) 'undo))
           (rplacd last (setq undo-n (+ 2 (cdr last))))
           (set-fred-undo-stuff w last nil))
          (t (setq last (set-fred-last-command w (setq *last-command* (cons 'undo 0))))))
    (let ((thing (ed-history-get w undo-n))
          (undo-string (fred-undo-string w))
          set-nom)
      (if (eq thing :saved)
        (progn
          (setq thing (ed-history-get w (setq undo-n (1+ undo-n))))
          (when (and (consp last)(eq (car last) 'undo))
            (rplacd last undo-n))) 
        (when thing 
          (let ((tem (ed-history-get w (1+ undo-n))))
            (when (eq tem :saved)
              (setq set-nom t)
              (when (and (consp last)(eq (car last) 'undo))
                (rplacd last  (1+ undo-n)))))))
      (cond ((null thing)(ed-beep))
            ((not (listp thing)))
            ((consp (car thing)) ; multiple
             (ed-undo-1 w (car thing))
             (dolist (evt (cdr thing))
               (ed-undo-1 w evt t)))
            (t (ed-undo-1 w thing)))
      (when (null (fred-undo-string w))(set-fred-undo-string w undo-string :redo)) ; put em back
      (maybe-update-debutton w)
      (when (or set-nom
                (and (null (ed-history-get w (+ undo-n 2) t))
                     (multiple-value-bind (len saved-p)(history-length (fred-history w))
                       (and (not saved-p)
                            (< (+ undo-n 2) len)))))
        (window-set-not-modified w)
              ))))

; insert - pos, string
; delete - pos undo-cons
; or (function pos) or (function list) or (function '%no-args%) => no args
(defun ed-undo-1 (w evt &optional append-p)
  (let ((buf (fred-buffer w))
        (string/cons (cdr evt))
        (start (car evt)))
    (cond 
     ((fixnump start)
      (set-mark buf start)
      (cond
       ((consp string/cons)
        ; was deletion - insert it
        (let ((str (%car string/cons)))
          (cond 
           ((eq 0 (length str)) ; unless it was just a font change
            (let* ((oldstyle (%cdr string/cons))
                   (e (ed-style-end oldstyle))
                   (style (buffer-get-style buf start (+ start e))))              
              (buffer-set-style buf oldstyle start)
              (ed-history-add w start (cons "" style) append-p)))
           (t
            (buffer-insert-with-style buf
                                      str
                                      (%cdr string/cons) ; was conditional on fred-copy-styles-p
                                      start)
            (ed-history-add  w start str append-p)))))          
       (t ; was insertion - delete-it - save-p?? yeh otherwise sometimes saved, sometimes not
        ;(when (not (equal string/cons (buffer-substring buf start (+ start (length string/cons)))))
        ; (break)) ; or quit and mark history :bogus?
        
        (ed-delete-with-undo w start string/cons :never nil append-p))))
     ((eq string/cons '%no-args%) (funcall start)) ; documented undo closure that stupidly takes no args
     (t (funcall start w string/cons)))))

(defun ed-style-end (style)
  (when (consp style)(setq style (car style))) ; may be cons of style and color-vector
  (let* ((len (length style)))
    (if (> len 3)
      (let ((w1 (aref style (- len 2)))
            (w2 (aref style (- len 1))))
        (logior (ash (logand w1 #xff) 8) w2))
      0)))


; added the font argument
(defmethod ed-insert-with-undo ((w  fred-mixin) string &optional pos append-p font)
  (let ((buf (fred-buffer w)) style) ; end)
    (when (not pos)(setq pos buf))
    (when (buffer-mark-p pos)(setq pos (buffer-position pos)))
    (cond ((consp string)(setq style (%cdr string) string (%car string))) 
          ((characterp string)(setq string (string string)))) ; ed-history-add requires this
    ;(setq end (+ (if (fixnump pos) pos (buffer-position pos)) (1- (length string))))
    (if style
      (ed-insert-with-style w string style pos)
      (buffer-insert buf string pos font))
    (ed-history-add w pos string append-p)))

; just save on history, not kill-ring - for e.g. delete whitespace
(defmethod ed-delete-with-history ((w fred-mixin) start end &optional append-p reverse-p)
  (let ((buf (fred-buffer w)) cons)
    (when (neq start end)
      (setq cons (make-undo-cons w start end))
      (ed-history-add  w (min start end) cons append-p reverse-p)
      (buffer-delete buf start end)
      t)))

(defun make-undo-cons (w start end)
  (let ((buf (fred-buffer w)))
    (when (neq start end)
      (cons (buffer-substring buf start end)
            (buffer-get-style buf start end)))))

;; return T if OK, nil if not
(defun read-only-check (w)
  (if (window-buffer-read-only-p w)
    (let ((ans (buffer-whine-read-only w)))
      (when ans (mini-buffer-update w))
      ans)
    T))        
    
;; linefeed to return for whole buffer = c-x c-f
(defmethod ed-xform-linefeeds ((w fred-mixin))
  (ed-xform-eol-from-to w #\linefeed #\return))

;; go the other way
(defmethod ed-xform-newlines ((w fred-mixin))
  (ed-xform-eol-from-to w #\return #\linefeed))

(defmethod ed-xform-eol-from-to ((w fred-mixin) from-char to-char)
  (let* ((buf (fred-buffer w))
         (old-pos (buffer-position buf))
         (len (buffer-size buf))
         did-it)
    (dotimes (i len)
      (when (eql (buffer-char buf i) from-char)
        (when (not did-it)
          (if (not (read-only-check w))(return-from ed-xform-eol-from-to nil))
          (setq did-it t))
        (buffer-char-replace buf to-char i)))
    (buffer-position buf old-pos)
    (fred-update w)))
  

(defmethod ed-xform-CRLF ((w fred-mixin))
  (let* ((buf (fred-buffer w))
         (old-pos (buffer-position buf))
         (len (buffer-size buf))
         (i 0)
         (keep-cr t)
         did-it)
    (declare (fixnum i LEN old-pos))
    (if (and (eq *preferred-eol-character* #\linefeed)(not *transform-crlf-to-carriagereturn*))
      (setq keep-cr nil))
    (loop
      (when (>= i len)(return))
      (when (eql (buffer-char buf i) #\return)
        (when (and (< i len)(eql (buffer-char buf (1+ i)) #\linefeed))
          (when (not did-it)
            (if (not (read-only-check w))(return-from ed-xform-crlf nil))
            (setq did-it t))
          (if keep-cr
            (buffer-delete buf (+ i 1)(+ i 2))
            (buffer-delete buf i (+ i 1)))
          (when (< i old-pos)(decf old-pos)) ;; ??
          (setq len (1- len))))
      (setq i (1+ i)))
    (buffer-position buf old-pos)
    (when did-it 
      (fred-update w))
    did-it))




#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
	3	1/2/95	akh	use set-buffer-empty-font-codes, also do when whole buffer is selected
	4	1/5/95	akh	non roman word breaks
  5   1/6/95   akh   use with-quieted-view in window-show-cursor
|# ;(do not edit past this line!!)