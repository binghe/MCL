;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  2 10/5/97  akh  see below
;;  3 5/20/96  akh  probably no change
;;  2 10/17/95 akh  merge patches
;;  3 4/4/95   akh  message dialog needn't be modal, add frob for standin event thing (maybe only for lisp-dev-sys)
;;  19 3/22/95 akh  dont remember
;;  18 3/20/95 akh  undelined view line moves down wr to text for descenders
;;  16 3/15/95 akh  fix botched merge
;;  15 3/14/95 akh  search-files uses "ccl:**;*.lisp" if no file being edited
;;  13 3/2/95  akh  use *tool-back-color*, callers-action-function also needed to get values BEFORE closing the window
;;  12 2/23/95 slh  added *string-compare-script* to env vars
;;  11 2/23/95 slh  untrace popup
;;  10 2/21/95 slh  removed naughty word (file is public now)
;;  9 2/17/95  slh  save/revert prefs; *pascal-full-longs* env var
;;  8 2/17/95  akh  probably no change
;;  5 1/17/95  akh  apropos-dialog has back-color
;;  (do not edit before this line!!)


(in-package "CCL")

#| :lib:ccl-menus.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2004 Digitool, Inc.

;; Modification History
;; arrow-dialog-item - lose view-corners, set-view-size/position erase-focus-rect
;; get-string-from-user - limit size of message text
;; call-with-window-background - default to white-color
;; view-click-event-handler of arrow-dialog-item - the copy thing requires option + command - maybe remove it? - done
;; ------ 5.2b5
;; message-dialog gets a :window-type arg
;; -------- 5.1b3
;; look-for-a-button-named-cancel wont return a default button named cancel
;; add :window-type keyword arg to get-string-from-user
;; add Alex R's ERASE-FOCUS-RECT-P method for editable-text-dialog-item
;; undo below - let table-dialog-item deal with it
;; define set-view-size for arrow-dialog-item
; function frame-table-item defined, it calls frame-key-handler method
; draw-nil-theme-focus-rect fancier, frame-key-handler for table draws the black frame if not keyhdlr vs getting via invalidate-view
; more hullabalo in frame-key-handler
; get-string-from-user - better layout - room for improvement?
; look-for-a-button-not-this-one -> look-for-a-button-named-cancel
; select-item-from-list says which button is the cancel-button
; view-key-event-handler for arrow-dialog-item does not press some random button in the containing window if #\esc is typed
; get-string-from-user uses cancel-button so esc works in spite of presence of a key handler.
; rename frame-table-item -> frame-dialog-item, no longer need with-back-color - the real bug was elsewhere
; add support for the page up, page down, home and end keys in arrow-dialog-item. from Gary Warren King
; frame-table-item for table again
; fiddle with frame-table-item for table when window not active ??
; frame-table-item different for basic-editable-text-dialog-item
;; ------ 5.1b2
; tweak to with-back-color in frame-table-item
; frame-table-item does drawthemefocusrect
; ---------- 5.1b1
; ss - find-file-methods works now when pathname has a numeric argument between "#" and "p"
; 11-06-03 - fix esc in arrow-dialog-item - weird feature I think.
; ---------- 5.0 final
; def-ccl-pointers scrap - does ignore-errors - don't ask me why needed
; select-item-from-list not collapsible if modal - actually modal-dialog does this now
; -------- 4.4b5
; get-string-from-user - :theme-background t, message-dialog ditto
; tweak h-size of cancel button in select-item-from-list if osx-p
;; -----4.4b4??
; view-click-event-handler of arrow-dialog-item - option-key-p puts whole sequence in scrap - from gary warren king
; select-item-from-list - :theme-background t
; --------- 4.4b3
; def-ccl-pointers scrap moved here - don't ask me why
; 05/03/99 akh arrow-dialog-item does esc = cancel 
; 04/16/99 akh message dialog :back-color defaults to *tool-back-color*
;;; ----------- 4.3b1
; 04/16/98 akh set-table-sequence ((table arrow-dialog-item) seq) - dont deselect if contents of new = contents old
; 02/23/98 akh set-table-sequence ((table arrow-dialog-item) - don't check eq'ness of new and old seq
; 02/14/98 akh set-table-sequence for arrow-dialog-item - don't scroll to cell if there are no cells
; 09/29/97 akh   find-vile-method (for command-d) works better for quoted string
;  8/12/96 bill  (method set-table-sequence (arrow-dialog-item t)) doesn't
;                Mess with the selection if the new sequence is EQ to the old.
;  6/08/95 slh   help-specs
;  4/12/95 slh   arrow-dialog-item classes here now
;  4/11/95 slh   defvar *event-error-dialog* (for warning)
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
; 3/16/95 slh   Paige's Trace Dialog suggestions
; 2/27/95 slh   sequence-dialog-item copy tries to put text & lisp in scrap
;-------------  3.0d17
; 2/22/95 slh   added "Untrace" popup menu to Trace Dialog
; 2/21/95 slh   definitions-action-function: get info before closing dialog
; 2/17/95 slh   added *pascal-full-longs* to compiler prefs
; 2/15/95 slh   removed do-dialog-file-search & friends; boyer-moore now built in
; 2/14/95 slh   finished save/revert prefs
; 1/25/95 slh   save/load preferences (started)
;-------------  3.0d16
; highlight-table-cell for arrow dialog-item uses highlight-rect-frame (highlight color vs black)
; search-file-dialog doesnt mess with file type of pathname of front window.
; edit-anything-dialog heeds package for definitions and applicable-methods, add "All packages"
;  which only makes sense for those two options - and is a misnomer since it just finds the first.
; nuke *apropos-type-titles*, use make-menu-items in a couple of places
; reset-env-table-sequence calls update-env-table with no-click t 
; arrow-dialog-item keeps scroll bars drawn when window is active - looks better to me
; use make-dialog-item to save space, edit-anything-dialog - set-view-font to be sure
; arrow-dialog-item defaults table-hscrollp nil
; set-view-size (select-dialog) changed so usable by dialogs containing other stuff that need not move
; dont set-table-sequence when creating environment-dialog, do dialog-item-action
; install-view-in-window of arrow-dialog-item does cell-select 0
; set-view-size of select-dialog need not set-cell-size
; set-table-sequence scrolls to 0,0
; downcase symbols using *print-case* rather than blind downcase
; view-click-event-handler for arrow-dialog-item - dont do default button when double click in scroll
; view-key-event-handler for arrow-dialog-item deals with wrapped tables and left and right arrows
; fold do-table-copy into its one caller - copy, ditto do-arrow
; make-specializer-items sets last-function-name earlier
; nuke 3 calls to invalidate-view - set-pop-up-menu-default-item does it for us
; window-can-do-operation and copy for arrow-dialog-item move to sequence-dialog-item, methods for select-dialog use these
; nuke specials *trace-dialog*, *search-file-dialog*, *apropos-dialog* view-key-event-hdlr trace-dialog not needed
;10/27/93 alice environment-dialog checks legal typein values sooner rather than later, defaults had a
;		bug if sequence was temp not original. nuke view-key-event-handler (select-dialog) - let arrow
;		dialog-item do it. print-base-chk forgot to check for fixnum
;10/23/93 alice edit-anything-dialog & trace - dont always set package, apropos behavior consistent with others.
;		set-default-package-item uses set-pop-up-menu-default-item vs (setf ..) to get checks right
;10/20/93 alice nuke class env-filtered-arrow-dialog-item by moving its functionality to filtered-blah
;10/16/93 alice edit-anything-dialog enable/disable of typein-menu doesnt need to do the editable-text
;		inspect does selected-table-cell if any
;10/11/93 alice select-item-from-list takes a dialog-class arg and may tile, add file-select-dialog class,
;		nuke arrow-dialog class
;10/10/93 alice make-specializer-items - dont die if no specializers.
;10/08/93 alice ead-contents-to-string is dead code, get-spec-from-dialog gets qualifiers even if no specializers.
;10/04/93 alice make-specializer-items - dont error on (eql blah)
;10/03/93 alice edit-anything-dialog - Applicable methods is more exactly that. Table sequence includes
; all applicable methods even if no source info. If no methods print a msg. Definitions-action-function
; will ask if select a guy with no source info.
;10/02/93 alice add update-default-button method for edit-anything-dialog making cut etal work
;		nuke-anything-result nukes both doc and table.
;		def-preference-var was brain dead and moves to l1-edwin.
;		allow def-preference-var's before this file is loaded.
;		edit-anything-dialog nukes result if initial-string.
;09/30/93 alice view-key-event-handler of (view edit-anything-dialog) dont nuke result if ch is #\tab
; 		install-table & install-fred-item - remove invisible key handlers so tab acts sensibly
;08/31/93 alice make-specializer-items - dont error if not legal function spec
;08/14/93 alice buffer-chunk-size 128 for scrolling-fred-views
;------------
;; 06/24/93 alice added def-preference-var macro, added *control-key-mapping* and *fred-history-length*
;		to preferences
;06/03/93 alice bind  *standard-output* to itself if not of type terminal-io in search-file-dialog
; 06/03/93 bill  eval-enqueue -> process-run-function in search-file-dialog
; -------------- 3.0d8
; 05/04/93 alice some eval-enqueue -> with-event-processing-enabled - huh?
; 05/01/93 alice add *print-lines* to printing variables
; 05/05/93 bill  remove make-menu-item. It's defined in l1-menus.lisp
; 03/19/93 bill  message-dialog was overlapped by the menubar so I moved it down.
; -------------- 2.1d5
l 04/28/93 alice nuke *env-select*
; 04/25/93 alice nil-or-num -> nil-or-number
; 04/23/93 alice definitions-action-function - dont use last-function-name (only set by specializers)
; 04/17/93 alice sort specializers in make-specializer-items
; 04/05/93 alice filter-env-table => filter-table using cell-to-string-function (table)
; o4/04/93 alice trace-dialog handler-case => handler-bind, and throw to bypass rest of %error
; 04/04/93 alice arrow-dialog-item - double click does default-button action if any
; 04/02/93 alice edit-anything-dialog less "flashy" by changing positions rather than containers
; -------------- 2.1d4
; 03/10/93 alice select-item-from-list - make parts function of size, debutton fits text.
; 02/19/93 alice environment-dialog and print-options-dialog merged => preferences
; 02/12/93 alice move apropos-dialog here cause she uses a macro
; 01/18/93 alice added the get-info dialog, trace-dialog, arrow-dialog-item
 08/25/92 bill  The search files dialog no longer generates an error if someone
                double clicks on white space in the list.
 04/14/92 bill  string-dialog-debutton no longer assumes that every editable-text-dialog-item is a fred-dialog-item
;-------------- 2.0
; 03/15/92 bill  resolve aliases in do-dialog-file-search
;----------- 2.0f3
 12/29/91 alice get-string-from-user and select-item-from-list more sensible usage of action-function
;------------ 2.0b4
 11/12/91 bill  :allow-empty-strings initarg on get-string-from-user
 10/31/91 bill  add help-specs to print-options-dialog & environment-dialog
 10/09/91 bill  "Enter the name of symbol." -> "Enter the name of a symbol."
 09/26/91 alice open selected file => open selection
 09/18/91 alice bill's fix to window-can-do-operation for arrow-dialog
 09/09/91 alice edit-definition-dialog has some text.
----------- 2.0b3
 09/04/91 alice rearrange appearance of get-string-from-user 
 08/06/91 alice environment-dialog move buttons to bottom right
 08/06/91 alice print-options-dialog add *print-readably*, swap ok & cancel buttons
 08/06/91 alice get-string-from-user put default button on bottom right per user interface poo pah
 07/26/91 alice get-string-from-user has modeless option, used by edit-definition-dialog
 06/17/91 bill show some context in maybe-start-isearch
 07/21/91 alice arrow-dialog disable cut, clear, paste - do copy
 07/15/91 alice search-file-dialog - default-button initially enabled iff 2 non-empty strings
 06/30/91 alice scroll more zealously in view-key... for arrows
 06/29 91 alice print-options-dialog no error on eof in read-from-string - tasteful ?
 06/29/91 alice get-string-from-user enable default-button iff non-empty, ditto search files
 06/29/91 alice aesthetic tweak in select-item-from-list, also had a bug in modal case
 06/27/91 alice file-search beeps when finds nothing, select-item-from-list has more args
 06/26/91 alice file-selection dialog looks like edit-definition dialog with scroll bar etal.
		both are non-modal, select first cell, and heed arrows
 06/25/91 alice nother fix to print-options dialog
 -------- 2.0b2
 02/27/91 bill remove :cell-size from select-item-from-list.  Use the default.
 02/07/91 alice ccl; => ccl:
 ----- 2.0b1
 01/07/91 gb   replace *fasl-compiler-warnings* with *autoload-lisp-package*
               in env. dialog.
 12/28/90 bill add *arglist-on-space* & *autoload-traps* to environment dialog
 12/13/90 bill (... :grow-icon-p t ...) in file-selection-dialog
 12/11/90 bill (setf menu-item-update-function) -> set-menu-item-update-function
               fix a display glitch in maybe-start-isearch
 12/01/90 bill remove LOOP from alanr's resizeable select-item-from-list
 11/26/90 alice nuke *fast-eval*
 11/02/90 bill maybe-start-isearch for do-dialog-file-search (thanx to ALANR)
 11/01/90 bill alanr's resizeable select-item-from-list.
 08/24/90 bill Fix *print-case* = :studly in print-options-dialog
 08/10/90 bill file-selection-dialog comes out-of-line from do-dialog-file-search
 08/07/90 bill in do-dialog-file-search: let dialog compute the width
 08/03/90 bill  add :view-size & :view-position to do-dialog-file-search.
 07/31/90 bill  New get-string-from-user arglist.
 07/09/90 alice make 1st 2 args to get-string-from-user be required
 07/05/90 bill nix wptr-if-bound
               menu-item-update-function for *open-selected-file-menu-item*
               dialog-items -> subviews
 07/04/90 bill The size of the comment string was too high in search-file-dialog
 06/25/90 bill remove :procid & :default-button-enabled default-initargs
 06/12/90 bill window-buffer -> fred-buffer
 05/24/90 bill :window-position & :window-size -> :view-position & :view-size
 05/02/90 bill search-file-dialog class replaces anonymous dialog.
 04/30/90 gb   big hole where *compiler-warnings* used to be.  Would anyone miss
               *paste-with-styles* ?
 04/10/90 gz  dialog-item-font -> view-font
 02/20/90 bill environment-dialog & print-options-dialog no longer permanent.
 02/16/90 bill current-editable-text => current-key-handler
 02/05/90 bill Update for new dialogs.
 12/27/89 gz   Rearrange obsolete #-bccl conditionals.
               environment/print-options-dialog-class -> ..-dialog.
 09/30/89 bill In search-files function inside of files-containing-string:
               saved a-file for printing if open fails.
 09/30/89 bill Renamed *line-width* to *print-right-margin* for new pretty
               printer.  Mod print-options-dialog to suit.
 09/16/89 bill Removed the last vestiges of object-lisp windows.
 09/05/89 bill Convert dialogs to CLOS.  Remove trace-dialog
 08/31/89 bill Fix menu-item-update to work with CLOS windows.
 08/25/89 bill menu-item-update: disable unless the front-window is an object
               Need to update to work with CLOS windows.
 07/28/89 bill my-dialog => (objvar my-dialog)
 07/28/89 bill "dialog" => "dialog-object"
 07/20/89 gz clos menus.
19-Apr-89 as *button-dialog-item* -> *default-button-dialog-item*
 03/18/89 gz   window-foo -> window-object-foo.
 12/30/88 gz   Don't bother reading font info in search-files.
               New buffers.
 16/11/88 gz   new fred windows.
  9/10/88 gz   Only search TEXT files in files-containing-string.
  8/23/88 gz   declarations.  Removed dummy defs for inspect.
  6/23/88 as   tweaked search-files messages, trace message
               find-file-methods merges with *default-pathname-defaults*
               added a couple environment variables
  6/21/88 jaj  removed call to print-listener-prompt
  6/21/88 as   new stuff in environment dialog
  6/16/88 as   select-item-from-list returns list of cells
  6/01/88 as   eval -> symbol-value, new syms on environment dialog
  5/31/88 as   new centering for print-options and environment dialogs
               punted choose-package
               edit-definition-dialog doesn't use get-selected-string
  5/23/88 as   yet another get-string-from-user syntax
  5/23/88 as   punted init-eval-menu
  5/22/88 as   edit-definition-dialog prints message if def not found
  5/20/88 as   added select-item-from-list, search-files support
               new versions of get-string-from user and message-dialog
  5/19/88 as   trace-dialog
  1/28/88 as   removed some commented out code
  1/12/88 gb   enforced class/instance distinction for *environment-dialog(-class)*,
               *print-options-dialog(-class)*.  Compile actions at compile time.
  9/29/87 jaj  auto-load features now load from "fasls;" rather that "ccl;aux:"
---------------------------------Version 1.0------------------------------------
  8/04/87 jaj  moved *emacs-mode* and added *break-on-errors*
  8/04/87 gz   Made kill-string-insert-via-menu force a window update.
               merge with ".lisp" in find-file-methods.
  7/31/87 gb   var-box for *backtrace-on-errors* vice *break-on-errors*.
  7/30/87 gz   commented out this apropos dialog altogether.
  7/29/87 gz   made apropos not call choose-package, pop up listener.
  7/30/87 as   restored choose-package
               added period to error message
               fixed edit-selected-string for empty string
  7/27/87 gz   move-mark -> set-mark. Less consing in open-selected-file.
               commented out edit-selected-file.
  7/26/87 as   get-string-from-user uses built-in throw to cancel, auto centers
               message-dialog compiles action, auto centers
               *menu-bar-bottom*  ==> *menubar-bottom*
  7/25/87 am   made get-string-from-user throw to cancel when cancel is seclected.
               edit-definition-dialog apropos-dialog modified for the above change.
  7/25/87 gz   #-bccl on autoloading inspector defs.
               use flet to make fns smaller.
  7/25/87 as   added *emacs-mode* and *save-definitions* to environment menu
               added code for 'open-selected-file'
  7/23/87 cfry ?* -> *
  7/22/87 as   removed support code for some help menus
               hard coded size of some windows
  7/19/87 as   switched *cheap-eval* to *fast-eval*
               purged big-picture-p
               moved screen dimension defvar's to l1-init.lisp
  7/18/87 as   added disabled *cheap-eval* to env-menu
  7/17/87 jaj  up to window spec
  7/13/87 jaj  init-lists use keywords. Changed for new menus.
  7/11/87 as   fixed item-sizes in print-options dialog
  7/10/87 jaj  made the specialized fns window-show work properly for
               no args supplied.
  7/8/87  gz   removed set-sf-dir.
  7/1/87  gz   New exist arg scheme.  Use defobject. removed defvars for
               *apple-menu* etc, in level-1 now.
  6/23/87 am   removed choose-file. choose-file-dialog exists now.
  6/23/87 gz   no args to print-listener-prompt
  6/22/87 gz   added &aux vars
  6/21/87 as   get-string-from-user fixes for new dialogs
               added (proclaim '(object-variable . . .))
               removed unused lexical variables (thanks gary)
  6/19/87 gb   %have -> have.
  6/19/87 jaj  changed *crude-debug* to *break-on-errors*. fixed message-dialog
  6/18/87 jaj  dialog-item-check -> check-box-check etc.
               removed calls to add-dialog-item (now use add-dialog-items)
  6/12/87 gb   menu initialization assumes menus created in level-1, partly
               conditionalized for #-bccl.
  6/10/87 gb   no more user-pick-file-any.  Allow text, fasl files only in load
               menu item.
  6/9/87  as   print-options dialog now updates to correct values
               rewrote 'get-string-from-user'.  new option arg syntax (same as
                  'message-dialog').  updated calls to this.
               removed several pages of commented out code
  6/8/87  as   removed 'describe' from tools menu
               rewrote 'message-dialog' using new dialogs.  new optional arg
                syntax (message-dialog <string> &optional <position> <size>)
  6/6/87  as   separated the lisp menu into two menus, 'eval' and 'tools'
               removed 'env' menu, and put functionality in dialog boxes
                  accessible from 'tools'
  6/3/87  gz   restore menu-key equiv. for Eval Selection, m-<x> instead of o-<x>
; 5/21/87 gb    use %(h)get-signed-word.  Mercifully decided *NOT* to delete
;              "dummy definitions" (no comment) of inspect, control-inspect,
;              etc., even though they were not mentioned in this mod history.
  5/7/87 cfry  installed *compile-definitions* on ENV menu
; 5/6/87  gz   Use standard  string in describing point stuff.
; 5/03/87 cfry put in GB's *da-menu* -> *apple-menu* fix from his 5/01/87 update
               *listener-position* -> *listener-window-position*
               *listener-size* -> *listener-window-size*
               *help-position* -> *help-window-position*
               *help-size* -> *help-window-size*
             moved fred & listener dimension vars to l1-edwin & l1-listener
; 5/2/87  gz   use closures in help menu.
; 5/1/87  gz  Avoid evaluated menu actions.
; 4/30/87 cfry fixed choose-package menu items actions
;              extended Screen Size help to contain fred, help & listener windows
; 4/27/87 cfry added VARIABLES help. Improved packages help.
; 4/17/87 cfry added (setq *default-menubar* ...)
;               simplified and fixed env menu items to always be apropriately
;              checked or unchecked. load-verbose can now just take t or nil.
;              use (load "foo" :print t) for load-verbose FORMS functionality.
;              fixed logical-dir help window update
;         removed move-size-window [obsolete]
;        replaced rectangles with window-position & window-size
;        made help features and screen-size into little help windows
;            like the rest of help
; 4/16/87 cfry made describe-dialog more polite.
; 4/15/87 gz delete -> remove in choose-package. tsk tsk...
; 4/14/87 cfry added declarations help, Added Evalto lisp menu, put key cmd
;         equivalents on Lisp Menu. fixed kill-string-insert-via-menu.
;         fred-menu class object update
; 4/11/87 cfry removed rm package symbols, now diagnostic-aid.lisp
;         adds to the menus if they exist
;4/10/87 jaj changed to new records
;4/6/87 gz converted ERROR calls to CL syntax.
;4/1/87 gz removed call to prepend-default-dir
; 87 03 31 cfry  renamed *edit-definition-string* to %edit-definition-string
;                made edit-definition-dialog look at selected region just like
;                describe-dialog does. Similar fix to apropos-dialog plus
;                plus let user select package for apropos.
;                added "Traps" help
;                added "Packages" help
;                reorganized menu bar items somewhat
;3/27/87 gz title-to-window -> find-window.

|#



(require :pop-up-menu)


(defun return-cancel (i)
  (declare (ignore i))
  (return-from-modal-dialog :cancel))


;Is this used anywhere?  Why isn't it *search-window-position* and
; *search-window-size* like all the other size parameters??
; search height = 50, search width = 162
; on MAC top = 292, left =  350
#|
(defparameter *search-rectangle* (list (- *screen-height* 50 1)
                                       (- *screen-width* 162 1)
                                       (1- *screen-height*) 
                                       (1- *screen-width*)))
|#



;(defparameter *max-menu-item-length* 26)
(defclass string-dialog (dialog)
  ((allow-empty-strings :initform nil :initarg :allow-empty-strings)))

(defclass get-string-dialog (string-dialog)())

(defmethod set-view-size ((dialog get-string-dialog) h &optional v)
  (declare (ignore h v))
  (let* ((old-size (view-size dialog)))
    (call-next-method)
    (let* ((new-size (view-size dialog))
           (hdelta (make-point (- (point-h old-size)(point-h new-size)) 0))
           (subs (view-subviews dialog))
           (len (length subs)))
      (dotimes (i len)
        (let ((sub (elt subs i)))
          (if (typep sub 'button-dialog-item)
            (set-view-position sub (subtract-points (view-position sub) hdelta))
            (if (typep sub 'editable-text-dialog-item)
              (set-view-size sub (subtract-points (view-size sub) hdelta)))))))))

;; could be prettier, need a set-view-size method - move buttons, resize editable-text - done
; 140 x 80 is about minumum useful size - neg size is invisible
(defun get-string-from-user (message 
                             &key
                             initial-string
                             (size #@(365 100))
                             (position '(:bottom 140))
                             (ok-text "OK")
                             (cancel-text "Cancel")
                             (modeless nil)
                             (window-title "")
                             (window-type :document-with-grow)
                             (back-color *tool-back-color*)
                             (allow-empty-strings nil)
                             (action-function #'identity)
                             cancel-function
                             (theme-background t)
                             &aux dialog (delta 0) (message-len 0) message-item)
  (when (not initial-string) (setq initial-string ""))
  (if t (setq delta 20)(setq delta 10))  
  (when message 
    (setq message-item (make-instance 'static-text-dialog-item
                         :text-truncation :end
                         :view-position (make-point 6 (- (point-v size) 54 delta))
                         :dialog-item-text message))
    (let* ((msize (view-default-size message-item))
           (mh (point-h msize)))  ;; would be nice if static text had a truncate option -now it does
      (setq mh (min mh (- (point-h size) 100)))
      (set-view-size message-item (make-point mh (point-v msize))))
    (setq message-len (+ 6 (point-h (view-size message-item)))))
  (flet ((act-on-text (item)
           (let ((e-item
                  (find-subview-of-type (view-container item)
                                        'editable-text-dialog-item)))
             (funcall action-function (dialog-item-text e-item)))))    
    (setq dialog (make-instance 
                   'get-string-dialog
                   :view-position position
                   :view-size size
                   :close-box-p (if modeless t nil)
                   :grow-box-p t
                   :window-type window-type
                   :window-title window-title
                   :window-show nil
                   :back-color back-color
                   :theme-background theme-background
                   :allow-empty-strings allow-empty-strings
                   :view-subviews
                   (list
                     (make-dialog-item
                       'default-button-dialog-item
                       (make-point (- (point-h size) 74)
                                   (- (point-v size) 20 delta))
                       #@(62 20)
                       ok-text
                       (if (not modeless)
                         #'(lambda (item)
                             (return-from-modal-dialog (act-on-text item)))
                         #'act-on-text))                     
                     (make-dialog-item 'button-dialog-item
                                       (make-point (- (point-h size) 154)
                                                   (- (point-v size) 20 delta))
                                       #@(62 20)
                                       cancel-text
                                       (or cancel-function
                                       #'(lambda (item)
                                           (if (not modeless) 
                                             (return-from-modal-dialog :cancel)
                                             (window-close (view-window item)))))
                                       :cancel-button t)
                     (make-dialog-item 'editable-text-dialog-item
                                        (make-point (+ 6 message-len) (- (point-v size) 54 delta))
                                        (make-point (- (point-h size) delta message-len) 16)
                                        initial-string))))
    (when message (add-subviews  dialog  message-item))
    
    (update-default-button dialog)
    (cond ((not modeless)         
           (modal-dialog dialog))
          (t (window-show dialog)
             dialog))))

; for dialogs which require non-empty strings to enable the default-button.
; used by apropos, get-string-from-user and search-files

(defmethod view-key-event-handler :after ((d string-dialog) ch)
  (declare (ignore ch))
  (update-default-button d))

(defmethod update-default-button ((d string-dialog))
  (let ((debutton (default-button d)))
    (when debutton
      (let ((text-items (subviews d 'editable-text-dialog-item)))
        (when text-items
          (let ((empties (slot-value d 'allow-empty-strings)))
            (if (or (eq empties t)
                    (dolist (item text-items t) ; enables if no text-items but there should be some
                      (unless (and (consp empties)(memq (view-nick-name item) empties))
                        (when (eq 0 (dialog-item-text-length item))
                          (return nil)))))
              (dialog-item-enable debutton)
              (dialog-item-disable debutton))))))))



(defmethod dialog-item-text-length ((item dialog-item))
  (length (dialog-item-text item)))

(defmethod dialog-item-text-length ((item fred-mixin))
  (buffer-size (fred-buffer item)))

(defmethod dialog-item-text-length ((item static-text-dialog-item))
  (let ((h (dialog-item-handle item)))
    (if h
      (#_GetHandleSize h)
      (length (slot-value item 'dialog-item-text))))) 

; need close box if modal nil 
(defun message-dialog (message &key (ok-text "OK")
                              (size #@(335 100))
                              (modal t)   ; if not modal its callers job to select
                              (title "Warning")
                              window-type
                              (back-color *tool-back-color*)
                              (theme-background t)
                              (position (list :top (+ *menubar-bottom* 10))))
  (let* ((message-width (- (point-h size) 85))
         (new-dialog
          (make-instance
           'dialog
           :view-position position
           :view-size size
           :window-title title
           :window-type (or window-type (if modal :movable-dialog :document))
           :close-box-p (if modal nil t)
           :window-show nil
           :back-color back-color
           :theme-background theme-background
           :view-subviews
           `(,(make-instance 
               'static-text-dialog-item
               :dialog-item-text message
               :view-size (make-point
                                  message-width
                                  (- (point-v size)
                                     30)))
             ,@(if modal
                 (list (make-dialog-item
                        'default-button-dialog-item
                        (subtract-points size #@(75 35))
                        #@(62 20)
                        ok-text
                        #'(lambda (item)
                            (declare (ignore item))
                            (return-from-modal-dialog t)))))))))
    (if modal
      (modal-dialog new-dialog)
      new-dialog)))

(defvar *event-error-dialog* nil)

; preallocate for better chance of being able to show?
(def-ccl-pointers evt-dialog6 nil
  (setq *event-error-dialog* (message-dialog "Error in event processor.
No room for another process. 
Future errors will be ignored." :modal nil)))



; (message-dialog "hi there")


;;used instead of modal fred menus
;;used only by edit-definition .  Suggestions welcome
;(defclass arrow-dialog (window) ())
(defclass select-dialog (window) ())

; wouldnt need these if sequence-dialog-item were guaranteed to be a key-handler

(defmethod window-can-do-operation ((d select-dialog) op &optional item)
  (let ((s-item (or (current-key-handler d)(find-subview-of-type d 'sequence-dialog-item))))
    (when s-item (window-can-do-operation s-item op item))))

(defmethod copy ((dialog select-dialog))
  (let* ((s-item (or (current-key-handler dialog)
                     (find-subview-of-type  dialog 'sequence-dialog-item))))
    (when s-item (copy s-item))))

(defmethod set-view-size ((view select-dialog) h &optional v)
  (declare (ignore h v))
  (let* ((old-size (view-size view)))
    (call-next-method)    
    (let* ((new-size (view-size view))
           (delta (subtract-points new-size old-size)))      
      (dovector (v (view-subviews view))
        (if (typep v 'sequence-dialog-item)
          (set-view-size v (add-points (view-size v) delta))
          (if (typep v 'button-dialog-item)
            (set-view-position v (add-points (view-position v) delta)))))
      new-size)))

(defun select-item-from-list (the-list &key (window-title "Select an Item")
                                            (selection-type :single)
                                            table-print-function 
                                            (action-function #'identity)
                                            (default-button-text "OK")
                                            (sequence-item-class 'arrow-dialog-item)
                                            (view-size #@(400 138))
                                            (view-position '(:top 90) pos-p)
                                            (theme-background t)
                                            dialog-class
                                            modeless
                                            (help-spec 14086)
                                            (list-spec 14087)
                                            (button-spec 14088))
  "Displays the elements of a list, and returns the item chosen by the user"
  (let (debutton dialog)
    (flet ((act-on-items (item)
             (let ((s-item (find-subview-of-type (view-container item)
                                          'sequence-dialog-item)))
               (funcall action-function 
                        (mapcar #'(lambda (c) (cell-contents s-item c))
                                (selected-cells s-item))))))
      (when (and dialog-class (not pos-p) modeless)
        (let ((w (front-window :class 'select-dialog)))  ; or dialog-class?
          (when w (setq view-position (add-points (view-position w) #@(15 15))))))
      (setq debutton
            (make-instance 
             'default-button-dialog-item
             :dialog-item-text default-button-text
             :dialog-item-enabled-p the-list
             :help-spec button-spec
             :dialog-item-action
             (cond 
              ((not modeless)
               #'(lambda (item)
                   (return-from-modal-dialog (act-on-items item))))
              (t
               #'act-on-items))))
      (let* ((bsize (view-default-size debutton))
             bpos)
        (setq bsize (make-point (max 60 (point-h bsize)) (point-v bsize))
              bpos (make-point (- (point-h view-size) 25 (point-h bsize))
                               (- (point-v view-size) 7 (point-v bsize))))
        (set-view-size debutton bsize)
        (set-view-position debutton bpos)
        (setq dialog
              (make-instance
                (or dialog-class 'select-dialog)
                :window-type :document-with-grow
                :close-box-p (if modeless t nil)
                :window-title window-title
                :view-size view-size
                :view-position view-position
                :window-show nil ;modeless
                :back-color *tool-back-color*
                :theme-background theme-background
                :help-spec help-spec
                :view-subviews
                (list*
                 (make-instance
                   sequence-item-class
                   :view-position #@(4 4)
                   :view-size (make-point (- (point-h view-size) 8)
                                          (- (point-v view-size) (point-v bsize) 20))
                   ;:table-hscrollp nil
                   :table-sequence the-list
                   :table-print-function table-print-function
                   :selection-type selection-type
                   :help-spec list-spec)
                 debutton
                 (if (not modeless)
                   (list
                    (make-dialog-item 'button-dialog-item
                                      (make-point (- (point-h bpos) 80)
                                                  (point-v bpos))
                                      (make-point (if t #|(osx-p)|# 64 60) (point-v bsize))
                                      "Cancel"
                                      #'return-cancel
                                      :cancel-button t
                                      :help-spec 15012))
                   nil))))
        ;(when the-list (cell-select sdi (index-to-cell sdi 0))) ; let arrow-dialog-item do this
        (cond (modeless ; select first then show is prettier
               (window-show dialog)
               dialog)
              
              (t (#_changewindowattributes (wptr dialog) 0 #$kWindowCollapseBoxAttribute)
                 (modal-dialog dialog)))))))


; is there something more tasteful to do if multiple selection enabled?
#|
(defmethod view-key-event-handler ((dialog select-dialog) char)
  (case char
    ((#\uparrow #\downarrow)
     (let* ((s-item (car (subviews dialog
                                   'sequence-dialog-item))))
       (when s-item
         (do-arrow s-item char))))
    (t (when (next-method-p)(call-next-method)))))
|#

  
; (select-item-from-list '("item one" "item two" "third item" "fourth item"))
; (select-item-from-list '(1 2 3 4 5 6 7) :window-title "Choose a number" :selection-type :disjoint)

(defun selected-cell-contents (table)
  (let ((c (first-selected-cell table)))
    (when c (cell-contents table c))))


(defun open-selected-file ()
  (let ((file (open-selected-file-test)))
    (if  file (ed file) (ed-beep))))

(defmethod open-file-item-file ((w window))
  (let ((key (current-key-handler w)))
    (when (and key (method-exists-p 'open-file-item-file key))
      (open-file-item-file key))))

(defun open-selected-file-test (&aux (w (front-window)) sel)
  (ignore-errors 
   (when (setq sel (open-file-item-file w))
     (or (find-file-methods sel)
         (let ((p1 (position-if-not #'whitespacep sel))
               (p2 (position-if-not #'whitespacep sel :from-end t)))
           (if (or (neq p1 0)(neq p2 (1- (length sel))))
             (find-file-methods (subseq sel p1 (1+ p2)))))))))


(defun find-file-methods (file-string)
  (let* ((sel-length   (length file-string))
         (first-of-sel (elt file-string 0))
         (last-of-sel  (elt file-string (1- sel-length)))
         (first-three-of-sel (if (> sel-length 2)
                               (subseq file-string 0 3)))
         (file (ignore-errors (full-pathname file-string))))
    (cond ((and file
                (or (setq file (probe-file file))
                    (lds (setq file (probe-file
                                     (merge-pathnames file-string
                                                      *.lisp-pathname*)))
                         nil)))
           file)
          ((and (eq last-of-sel #\")
                (or (equalp first-three-of-sel "#p\"")
                    (equalp first-three-of-sel "#.\"")
                    (equalp first-three-of-sel "#1p")
                    (equalp first-three-of-sel "#2p")
                    (equalp first-three-of-sel "#3p")
                    (equalp first-three-of-sel "#4p")
                    (eq first-of-sel #\")))
           (let ((temp (read-from-string file-string)))
             (when (and (setq file (full-pathname temp))
                        (or (setq file (probe-file file))
                            (lds (setq file (probe-file
                                             (merge-pathnames temp
                                                              *.lisp-pathname*)))
                                 nil)))
               file))))))



(defclass arrow-dialog-item (focus-rect-mixin key-handler-mixin sequence-dialog-item)()
  (:default-initargs
    :table-sequence nil
    :table-hscrollp nil))

#|
(defmethod view-click-event-handler ((item arrow-dialog-item) where)
  ;(declare (ignore where))  ; shouldn't this be a method on key-handler-mixin?
  ;; the put-scrap is a non intuitive user interface and besides didn't work without the (put-scrap :text xxxx nil)
  ;; consider removing it - also wrong if text not 7bit ascii - er um not mac encoded 
  (when (and (option-key-p)(command-key-p))
    (put-scrap :lisp (table-sequence item))
    (let ((text (with-output-to-string (stream)
                  (mapc #'(lambda (cell)
                              (format stream "~A~%" cell))
                        (table-sequence item)))))
      (if (not (7bit-ascii-p text))(setq text (convert-string text #$kcfstringencodingunicode #$kcfstringencodingmacroman)))
      (put-scrap :text text nil)))
  (set-current-key-handler (view-window item) item)
  (call-next-method)
  (when (and (not (dialog-item-action-function item))(double-click-p)
             (point<= where (add-points (view-position item)(table-inner-size item))))    
    (let* ((w (view-window item))
           (button (default-button w)))
      (when (and button (first-selected-cell item))
        (dialog-item-action button)))))
|#

(defmethod view-click-event-handler ((item arrow-dialog-item) where)
  ;(declare (ignore where))  ; shouldn't this be a method on key-handler-mixin?
  ;; the put-scrap is a non intuitive user interface and besides didn't work without the (put-scrap :text xxxx nil)
  ;; consider removing the "feature"
  #+ignore
  (when (and (option-key-p)(command-key-p))
    (put-scraps (table-sequence item)
                (with-output-to-string (stream)
                  (mapc #'(lambda (cell)
                              (format stream "~A~%" cell))
                        (table-sequence item)))))
  (set-current-key-handler (view-window item) item)
  (call-next-method)
  (when (and (not (dialog-item-action-function item))(double-click-p)
             (point<= where (add-points (view-position item)(table-inner-size item))))    
    (let* ((w (view-window item))
           (button (default-button w)))
      (when (and button (first-selected-cell item))
        (dialog-item-action button)))))

(defmethod view-cursor ((item arrow-dialog-item) where)
  (declare (ignore where))
  *arrow-cursor*)

(defmethod install-view-in-window :after ((table arrow-dialog-item) w)
  (declare (ignore w))
  (when (table-sequence table) (cell-select table 0)))

; the following 3 methods keep scroll-bars drawn unless window is inactive
(defmethod view-deactivate-event-handler ((item arrow-dialog-item))
  (if (not (window-active-p (view-window item)))
    (call-next-method)
    (let ((cell (first-selected-cell item)))
      (when cell (redraw-cell item cell)))))

(defmethod exit-key-handler ((item arrow-dialog-item) next)
  (declare (ignore next))
  ; kind of incestuous - else its still the key handler when get to highlight-table-cell
  (setf (%get-current-key-handler (view-window item)) nil)  ;; don't think we need this now.
 t)

;; not used?
(defmethod highlight-table-cell ((item arrow-dialog-item) cell rect selectedp)
  (declare (ignore selectedp cell))
  (let* ((w (view-window item)))
    (if  (and w (or (not (window-active-p w))(neq item (current-key-handler w))))
      (highlight-rect-frame rect)      
      (call-next-method))))


;; else set-view-size screws up for arrow-dialog-item
;; and new window doesn't get any right
(defmethod view-draw-contents :after ((item focus-rect-mixin))
  (frame-key-handler item)) 

#|
(defmethod set-view-size ((item arrow-dialog-item) h &optional v)
  (declare (ignore h v))
  (with-focused-view (view-container item)
    (multiple-value-bind (tl br)(view-corners item)
      (rlet ((rect :rect :topleft tl :botright br))          
        (#_eraserect rect))  ;; maybe not needed? - is if window has a back-color
      (call-next-method)
      (invalidate-view item t))))
|#

#|
(defmethod set-table-sequence ((table arrow-dialog-item) seq)
  (let ((same-seq (eq seq (table-sequence table))))
    (unless same-seq
      (let ((c (first-selected-cell table)))
        (when c (cell-deselect table c))))
    (call-next-method)
    (unless same-seq
      (when (not (eql (length seq) 0))
        (cell-select table 0)
        (scroll-to-cell table 0)))))
|#

(defmethod set-table-sequence ((table arrow-dialog-item) seq)
  ;; new-seq may be eq old-seq but with different fill-pointer
  (let* ((fc (first-selected-cell table))
         (same-seq (eq seq (table-sequence table))))
    (when (not same-seq)
      (when fc 
        (cell-deselect table fc)
        (setq fc nil)))
    (call-next-method)
    ;; for unknown reasons initialize-instance calls set-table-sequence
    ;; before cell size is set.
    (when (cell-size table)
      (let ((new-dims (table-dimensions table)))
        (when (and fc 
                   (or (not (< (point-h fc) (point-h new-dims)))
                       (not (< (point-v fc) (point-v new-dims)))))
          (cell-deselect table fc)
          (setq fc nil))
        (when (and (not fc)
                   (not (eql (length seq) 0)))
          (cell-select table 0)
          (scroll-to-cell table 0))))))

#|
(defmethod view-key-event-handler ((item arrow-dialog-item) char)
  (let ((delta (case char
                 (#\uparrow #@(0 -1))
                 (#\downarrow #@(0 1))
                 (#\backarrow #@(-1 0))
                 (#\forwardarrow #@(1 0))))
        window)
    (cond
     (delta 
      (let* ((cell (first-selected-cell item))
             new-cell)
        (if (not cell)
          (setq new-cell #@(0 0))
          (when cell (setq new-cell (add-points cell delta))))
        (when new-cell
          (when (point<= #@(0 0) 
                         new-cell 
                         (subtract-points (table-dimensions item) #@(1 1)))
            (when cell (cell-deselect item cell))
            (cell-select item new-cell)
            (when (or (null (cell-position item new-cell))
                      ; doesnt seem to mind asking about one beyond list
                      (null (cell-position item (add-points new-cell delta))))
              (scroll-to-cell item new-cell))
            (dialog-item-action item)))))
     ((and (and (eql char #\esc) (setq window (view-window item)) (default-button window))           
           (let ((d-button (default-button window)))
             (block foo
               (let ((x (look-for-a-button-not-this-one window d-button)))                 
                 (when (and x (neq x d-button))
                   (when (dialog-item-enabled-p x)
                     (press-button x)
                     (return-from foo t))))))))
     (t (call-next-method)))))
|#
;; Copyright, Gary Warren King, 2002.
(defmethod view-key-event-handler ((item arrow-dialog-item) char)
  (let ((delta (case char
                 (#\uparrow #@(0 -1))
                 (#\downarrow #@(0 1))
                 (#\backarrow #@(-1 0))
                 (#\forwardarrow #@(1 0))
                 (#\Page (make-point 0 (min (wholly-visible-rows item)
                                            (- (length (table-sequence item)) 
                                               (point-v (first-selected-cell item)) 1))))
                 (#\PageUp (make-point 0 (- (min (wholly-visible-rows item)
                                                 (point-v (first-selected-cell item))))))
                 (#\Home (make-point 0 (- (point-v (first-selected-cell item)))))
                 (#\End (make-point 0 (- (length (table-sequence item)) 
                                         (point-v (first-selected-cell item)) 1)))))
        window)
    (declare (ignore-if-unused window))
    (cond
     (delta 
      (let* ((cell (first-selected-cell item))
             new-cell)
        (if (not cell)
          (setq new-cell #@(0 0))
          (when cell (setq new-cell (add-points cell delta))))
        (when new-cell
          (when (point<= #@(0 0) 
                         new-cell 
                         (subtract-points (table-dimensions item) #@(1 1)))
            (when cell (cell-deselect item cell))
            (cell-select item new-cell)
            (when (or (null (cell-position item new-cell))
                      ; doesnt seem to mind asking about one beyond list
                      (null (cell-position item (add-points new-cell delta))))
              (scroll-to-cell item new-cell))
            (dialog-item-action item)))))
     ;; forget below - makes no sense to me. it's up to the containing dialog to decide what #\esc should do if anything
     #+ignore
     ((and (and (eql char #\esc) (setq window (view-window item)) (default-button window))
           (let ((d-button (default-button window)))
             (block foo
               (do-subviews (x window 'button-dialog-item)
                 (when (neq x d-button)
                   (when (dialog-item-enabled-p x)
                     (press-button x)
                     (return-from foo t))))))))
     (t (call-next-method)))))

;; look for a button named "cancel" which assumes we parlez anglais
;; but should be using :cancel-button these days anyway
#+ignore ; this conses - why?
(defun look-for-a-button-named-cancel (view &optional button)
  (declare (ignore button))
  (or (do-subviews (x view 'button-dialog-item)
        (when (string-equal (dialog-item-text x) "Cancel")
          (return x)))
      (do-subviews (x view 'view)
        (let ((foo (look-for-a-button-named-cancel x)))
          (when foo (return foo))))))
        
(defun look-for-a-button-named-cancel (view &optional button)
  (declare (ignore button))  
  (let ((subs (view-subviews view)))
    (dotimes (i (length subs))
      (let ((it (elt subs i)))
        (when (and (typep it 'button-dialog-item)(string-equal (dialog-item-text it) "cancel")(not (default-button-p it)))
          (return it))
        (when (and (typep it 'view))
          (let ((res (look-for-a-button-named-cancel it)))
            (when res (return res))))))))




;;;;;;;;;;;;;;;;;;;;;;
;;
;;Draw a border when is current-key-handler unless only key-handler
;;

#| ;; focus-rect-mixin does it
(defmethod view-draw-contents ((item arrow-dialog-item))
  (call-next-method)
  (let ((w (view-window item)))
    (when  w
      (frame-key-handler item))))
|#

#|
(defmethod view-corners ((item arrow-dialog-item))
  (let ((pos (view-position item)))
    (values
     (subtract-points pos #@(4 4))
     (add-points pos (add-points (view-size item) #@(4 4))))))
|#

#|  ;; focus-rect-mixin does it
(defmethod set-view-size ((item arrow-dialog-item) h &optional v)
  (declare (ignore-if-unused v))
  (with-focused-view (view-container item)
    (erase-focus-rect item)
    (call-next-method)
    (frame-key-handler item)))

(defmethod set-view-position ((item arrow-dialog-item) h &optional v)
  (declare (ignore-if-unused v))
  (with-focused-view (view-container item)
    (erase-focus-rect item)
    (call-next-method)
    (frame-key-handler item)))


(defmethod erase-focus-rect ((item arrow-dialog-item))
  (let* ((w (view-window item)))
    (when w
      (let ((pos (view-position item)))
        (rlet ((rect :rect :topleft pos :bottomright (add-points pos (view-size item))))
          (draw-nil-theme-focus-rect w rect))
        ))))
|#


(defmacro with-window-background (window &body body)
  (let ((fn (gensym)))
    `(let ((,fn #'(lambda nil ,@body)))
       (declare (dynamic-extent ,fn))
       (call-with-window-background ,window ,fn))))

(defun call-with-window-background (window fn) 
  (without-interrupts ;; assuming fn doesn't take long
   (if (window-theme-background window)
     (let ((prior (window-prior-theme-drawing-state window)))
       (if prior
         (rlet ((old-statep :ptr))
           (if (not (macptrp prior))(error "phooey"))
           (#_getthemedrawingstate old-statep)
           (#_setthemedrawingstate prior nil)
           (funcall fn)
           (#_setthemedrawingstate (%get-ptr old-statep) t))
         (funcall fn)))         
     (let ((back (or (slot-value window 'back-color) *white-color*)))
         (call-with-back-color back fn)))))

(defun draw-nil-theme-focus-rect (window rect)
  (with-window-background window (#_drawthemefocusrect rect nil)))        
  

;; for back compatibility - e.g. CLIM
(defun frame-table-item (item &optional blah)
  (declare (ignore blah))
  (frame-key-handler item))

(defmethod frame-key-handler ((item table-dialog-item))
  (let* ((w (view-window item)))
    (when (and w (cdr (key-handler-list w)))      
      (let ((pos (view-position item))
            (active-p (window-active-p w)))
        (rlet ((rect :rect topleft pos bottomright (add-points pos (view-size item))))          
          (if (and active-p (eq item (current-key-handler w)))                         
            (progn              
              (#_drawthemefocusrect rect t))
            (progn              
              (with-fore-color (if (not active-p)
                                 (if t #|(osx-p)|# *light-gray-color* *gray-color*)  ;; do we like this 
                                 (or (part-color item :frame) *black-color*))
                (#_insetRect rect -1 -1)
                (#_FrameRect rect))
              ;(if (not (osx-p))  (#_insetrect rect 1 1))              
              (draw-nil-theme-focus-rect w rect))))))))

;; Alexander Repenning: make this user controlable
(defmethod ERASE-FOCUS-RECT-P ((Self basic-editable-text-dialog-item))
  t)

(defmethod frame-key-handler ((item fred-dialog-item))
  (let* ((w (view-window item)))
    (when (and w) ; (cdr (key-handler-list w)))      
      (let ((pos (view-position item))
            (active-p (window-active-p w)))
        ;(when (and (theme-background-p w) (window-prior-theme-drawing-state w))(push 'cow phoo)) ;; it happens if a window update event comes along while drawing something else
        (rlet ((rect :rect :topleft pos :bottomright (add-points pos (view-size item))))          
          (if (and active-p (eq item (current-key-handler w)))                         
            (progn              
              (#_drawthemefocusrect rect t))              
            (progn 
              (#_insetrect rect -1 -1)              
              (#_DrawThemeEditTextFrame rect (if active-p #$kThemeStateActive #$kthemeStateInActive))
              (#_insetrect rect -1 -1)
              (when (erase-focus-rect-p item) ;; ??
                (draw-nil-theme-focus-rect w rect))
              )))))))

(defmethod frame-key-handler ((item simple-view))
  nil)

#|
(defmethod view-activate-event-handler :after  ((item arrow-dialog-item))
  ;(if t (invalidate-view item))
  (frame-key-handler item))

(defmethod view-deactivate-event-handler :after ((item arrow-dialog-item))
  ;(if t (invalidate-view item))
  (frame-key-handler item))
|#


(defclass filtered-arrow-dialog-item (arrow-dialog-item)
  ((:original :initarg :original :initform nil :accessor original-table-sequence)
   (:vector :initform nil :accessor temp-table-vector)
   (:cell-to-string-function :initarg :cell-to-string-function :initform nil
                             :reader cell-to-string-function)
   (:last-cell :initform nil :accessor table-last-cell)))

(def-ccl-pointers scrap ()
  (setq *scrap-state* nil
        *external-scrap* nil
        *external-style-scrap* nil)
  ; errors sometimes esp when started by applescript
  (ignore-errors (get-external-scrap)))

;; here from l1-edcmd
#+ignore
(queue-fixup
 (setq *use-external-style-scrap* t))

(setq *use-external-style-scrap* t)



#|
(defclass searchable-table-dialog-item (arrow-dialog-item)())

(defmethod view-key-event-handler ((table searchable-table-dialog-item) char)
  (if (char-lessp char #\space)
    (call-next-method)
    (find-thing-with-string table char)))

(defmethod view-cursor ((item searchable-table-dialog-item) where)
  (declare (ignore where item))
  *arrow-cursor*)
|#

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
	3	1/2/95	akh	reduce flashies in maybe-start-i-search
	4	1/5/95	akh	more fussing with maybe-start-isearch
|# ;(do not edit past this line!!)
