;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  7 9/3/96   akh  remove more of the stuff that has moved elsewhere
;;  3 12/1/95  akh  get lfun-bits from closure-function in find-applicable-methods
;;  2 10/23/95 akh  no concatenate 'base-string in window title
;;  16 5/22/95 akh  make-ed-help-items - make string adjustable
;;  15 5/7/95  slh  balloon help mods.
;;  14 5/4/95  akh  move binding of *gonna-change-pos-and-sel*
;;  13 4/24/95 akh  add optional prefix in format-definition-pathname
;;  11 4/12/95 akh  fix list definitions dialog - we lost filter-table
;;  10 4/10/95 akh  again
;;  9 4/10/95  akh  fix mismatch paren
;;  7 4/10/95  akh  dont remember
;;  5 4/7/95   akh  'character => 'base-character
;;  4 4/4/95   akh  c-x c-i is back to just inspect
;;  8 3/15/95  akh  dont remember
;;  6 3/2/95   akh  use *tool-back-color*
;;  4 1/25/95  akh  key-cap has back-color
;;                  dialogs more colorful
;;  3 1/17/95  akh  use with-event-processing-enabled
;;  (do not edit before this line!!)

(in-package :ccl)

; Copyright 1987-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2006 Digitool, Inc.

#|
;; Modification History
;
;; %text-input-event-handler-2 - only make-string if needed
;; comment out some unused code
;; ----- 5.2b6
;;  ed-current/next-top-level-sexp - look for any eol followed by #\(
;; (setf wptr) of tsm-document-mixin also puts back the regions if gone.
;; ----- 5.2b5
;; text-input-event-handler - just pass on if command-key is down
;; ---- 5.2b4 
;; forget using terminate-when-ureachable
;; %text-input-event-handler-2 fix so dingbats from character palette works
;; ------ 5.2b3
; %text-input-event-handler-2 fix so gets font right in empty buffer if script OK
; text-input-event-handler just passes through if keyscript is Roman and font is Symbol or Dingbats
; Hebrew and Arabic do not work - draw ok but caret is in wrong place
; lose class unicode-fred-item -  tsm-fred-item now does the whole job
; add stuff for tsmdocument allowing CJK inline input
; def-i-search #\backspace another fix re: don't go past end of buffer
; ed-top-level-sexp-start-pos looks for any eol-char followed by (
; ------ 5.2b1
; search does unicode.
; def-i-search #\backspace don't go past end of buffer
; ----------- 5.1 final
; my-string-to-window does string-string-equal -  no change string-equal
;-------- 4.3f1c1
; 07/01/99 akh ed-current-sexp ignores warnings too??
; 06/26/99 akh fixes for "search works" below
;'--------------- 4.3b3
; 03/03/99 akh  search works even if no mini-buffer
; 10/15/98 akh  ed-inspect-current-sexp - correct test for *top-listener*
; 08/23/96 bill  Remove sieve-table. It's in fred-help.lisp now.
; -------------  4.0b1
;  4/24/96 bill  edit-definition-p does package dwim both before and after removing trailing
;                period, comma, or colon. 
; -------------- MCL-PPC 3.9
;  3/26/96 gb    lowmem accessors.
;  6/08/95 slh   help-specs
;  4/12/95 slh   moved out arrow-dialog-item classes
;  4/06/95 slh   broke out arglist.lisp; macroexpanders will print to window if not LDS
;                check other listener dependencies
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
; 2/28/95 slh   removed *inspect-history-items* (unused)
;-------------- 3.0d17
;    ?    alice ...
; edit-definition-p obeys *current-package-only* for get info
; ed-help-window has no zoom box since he doesnt do window-size-parts (snarl)
; sieve-table does dialog-item-action
; i-search-search doesnt call i-search-prompt, callers try to minimize messing with the prompt which
; is frequently unchanged or gets one char added, i-search-prompt very slightly less silly.
; N.B. run-fred-command does not mess with the mini-buffer when shadowing-comtab is *i-search-comtab*
; make-ed-help-items copy-tree => copy-list
; dont set-table-sequence in ed-help, do dialog-item-action, dont show window-defs-dialog till done
; definitions dialog downcases name and omits period
; move method set-table-sequence to arrow-dialog-item
;10/24/93 alice in menu-of-defs do go-to-def inline, no more filter-string arg in list-definitions,
;		optimize method-position-item a little.
;10/20/93 alice add slot last-cell and method set-table-sequence to filtered-arrow-blah, use last-cell in
;		update-ed-help-doc
;10/11/93 alice nuke edit-anything-result-pos, add defs-select-dialog class, set-view-size of
;		menu-of-defs-dialog had a bug
;10/08/93 alice defined-in-listener-p is dead code. find-method-by-names defaults missing specs to t,
;		making trace more friendly
;10/03/93 alice my-string-to-window no longer random, find-applicable-methods was weird with
;		partial specializers. edit-definition-spec-lessp - typo if eql specs 
;10/02/93 alice parse-definition-spec checks function-spec-p (name), get-source-files-blah gets
;		all applicable methods whether or not source file info.
;09/26/93 alice sieve-table works better searching backwards
;08/27/93 alice sieve-table binds *string-compare-script* to roman, dtrt with non-alpha graphic chars
;08/14/93 alice sieve-table and substringp faster, ed-help smaller chunksz in doc view
;-------- RIP
;;start of added text
;08/14/93 alice sieve-table and substringp faster, ed-help smaller chunksz in doc view
;-------- RIP
;------------- 3.0d12
06/19/93 alice make-ed-help-items sorting got broken by new fat chars %code-char of > #xff.
06/17/93 alice buffer-current-symbol - tries to dtrt for interactive-arglist and external
		vs internal symbols - but what other uses does she have for which this is
		brain dead? apparently none. aux-find-symbol now means find it by some
		other means and if failure buffer-current-symbol is still in charge.
		read-#-prefixed-symbol changes accordingly.
		Make a patch for patch 3 of this please.
05/21/93 alice edit-definition-spec no longer looks for aborts - he shouldn't have to
05/05/93 alice nuke some message dialogs
04/29/93 bill  current-process -> *current-process*
04/28/93 bill  in make-ed-help-items - make sure we pass a string to stream-write-entire-string
04/22/93 bill  (format t ...) -> (message-dialog (format nil ...))
               Ask before searching all open windows (do we like this? I do.)
               choose-restart doesn't include restarts with no report-function
04/21/93 bill  look for aborts in edit-definition-spec. This should be done differently.
-------------- 2.1d5
04/28/93 alice sieve-table for ed-help does select and update doc - is it too slow?
04/24/93 alice edit-definition - if no-show don't leap off to single def
		(for get-info dialog)
04/20/93 alice cell-to-string-function in menu-of-defs-dialog was brain dead
		ed-help - double-click does edit-definition
04/05/93 alice menu-of-defs-dialog does "contains:" like others, nuke searchable-xxx
		cell-to-string-function (filtered-mumble) returns
-------------- 2.1d4
02/15/93 alice use (edit-menu) not *edit-menu*, lots of other stuff too
01/24/93 alice get-source-files-with-types&classes - dont find-applicable-methods when no special
01/18/93 bill  choose-restart now works with processes
11/20/92 gb    do a few things in the "top listener process."  Should do more ...
09/18/92 bill   ed-inspect-current-sexp no longer skips over reader macros.
08/21/92 bill   (arglist #'(lambda (...) ...) no longer calls arglist-from-help-file
04/16/92 bill   i-search-do-keystroke no longer looks at *current-event*.
                This makes it possible to do keyboard macros that include c-s or c-r
11/27/92 alice edit-definition parses #<standard-method ..>
11/26/92 alice arglist-to-stream and mini-buffer-output return t if happy, else nil
		ed-arglist (c-x c-a) makes arglist hang out till expr closes.
11/23/92 alice source-files-with-types&classes Obeys *direct-methods-only* for edit-anything-dialog
11/14/92 alice edit-definition positions window w.r.to *edit-anything-dialog*
		documentation-dialog replaced with edit-anything-dialog
10/08/92 alice stomp out *emacs-mode*
07/02/92 alice stomp out last 2 uses of shift-not-command-key-p
06/22/92 clean up a bit, make meta-. error report less verbose and clearer
 	tweak to edit-definition-spec-lessp for edit-callers,  make dialog do the same as meta-.
06/17/92 fix definition-spec-lessp for (setf ..), show which are setf when both
06/17/92 alice if method with specializers find all the applicaple methods sorted by applicability
04/16/92 alice fix ed-select-top-level-sexp (c-m-h) when at end by giving ed-current/next... another arg
03/06/92 alice search-for-def remove package qualifier in (setf blob)
02/20/91 alice def-i-search c-g and backspace - judicious use of (max 0 ...)
01/29/91 alice search-method-classes deal with (object t) as well as object when class is t
--------------  2.0
02/22/92 (alice from "post 2.0f2c5:i-search patch") judicious use of (max 0 ...) prevents errors
               in C-G, C-Backspace.
------------------- 2.0f2c5
01/07/92 gb    don't require RECORDS.
01/02/92 bill  arglist now properly passes the use-help-file to %arglist.
12/23/91 bill  arglist-to-stream strips parens around arglist strings.
               %arglist-internal doesn't look at uncompile-function result for macros.
12/29/91 alice documentation-dialog - adapt to new form of action-function
12/17/91 alice c-m-e and c-m-a get shift modifier, ed-top-level-sexp call window-package
12/14/91 alice %arglist-internal call find-unencapsulated-definition with method not %method-function - doesn't really matter!
------------------- 2.0b4
11/12/91 bill  add help specs to the menu-of-defs-dialog.
11/11/91 alice - gary figured out how to fix timing screws in choose-restart
11/04/91 bill  record-arglist saves when (or *save-arglist-info* *save-local-symbols*)
10/20/91 alice change arg classes => specializers in edit-definition-p
10/10/91 alice search c-y and c-w don't die at buffer end
10/09/91 bill  "Enter the name of symbol." -> "Enter the name of a symbol."
09/18/91 bill  ed-current-sexp special cases '#_xxx
09/17/91 bill  choose-restart no longer fails if called a second time after the first
               window is closed
10/04/91 alice reverse search wraps correctly
09/20/91 alice menu-of-defs-dialog calls menu-update *edit-menu* (gotta be a better way)
------------------- 2.0b3
08/30/91 bill  edit-definition-spec-lessp
08/24/91 bill  Option key during button click closes edit-definition dialog
08/12/91 bill  add interface-definition-p to edit-definition-p
08/02/91 alice choose-restart had lost his eval-enqueue making it difficult to type
07/30/91 alice fred-commands window has tabs (what a concept), add listener commands
07/29/91 alice fix delete in i-search (account for failed chars in selection)
07/26/91 alice c-s c-y snarfs selection if any, documentation-dialog is modeless
08/14/91 gb    eval-enqueue in choose-restart, after all.
07/21/91 gb    use dynamic-extent; no :elements-per-bucket in hash-tables.
07/19/91 alice search-for-def do both (defstruct aaa ...) and (defstruct (aaa ...))
07/09/91 alice ed-select-current-sexp - dont change cursor
07/02/91 alice better choose-restart
07/05/91 bill  format-definition-pathnames can get a list of pathnames
               Not done yet: these pathnames need to be split up into multiple entries.
07/01/91 bill  window-defs-dialog is a generic-function again so that the
               "List Definitions" menu-item will call method-exists-p on it.
               Don't blink unmatched double quote characters.
06/27/91 bill  ed-eval-or-compile-current-sexp was a copy of window-eval-selection.
               ed-eval-current-sexp was almost a copy.
06/29/p1 alice add another arg to ed-current-sexp - whether to skip read macros
06/28/91 alice reinstate blinking excess right parens
06/27/91 alice choose-restart not modal (hoo ha)
06/26/91 alice edit-definition dialog is not modal (hooray)
		list-definitions has growbox, default-button, selects first item and heeds arrows.
06/24/91 alice c-s don't try to move-mark past end of buffer
06/20/91 alice add c-m-w to search comtab
06/19/91 alice i-search make sure buffers and marks match! nuke *i-search-buffer-size*
06/17/91 alice search-for-def-dumb - dont check type (that was the point)
		do search-for-def dumber too if known to be defined therein
		(search-check-type t) = T, a few defmethod => defun
06/07/91 alice search-def-features get em in keyword package
; ------------------ 2.0b2
05/14/91 bill  buffer-current-symbol comes out from in-line in ed-current-symbol
05/09/91 bill  support DEFGENERIC in *define-type-alist*
05/06/91 bill  ed-edit-definition puts up dialog if error from ed-current-sexp
05/01/91 bill  no ignore-errors in ed-current-sexp.  If you ask for an sexp and don't
               find one, the most useful feedback is an error
04/25/91 bill  ed-current-symbol takes optional start & end args.
05/20/91 gb    recognize &restv.  New macro arglist scheme.
05/02/91 alice ed-delete-bwd/fwd-delimiters appear to be unused
05/02/91 alice i-search-do-keystroke set *default-command-p* = t
		& #\rubout doesnt get added to search string
04/24/91 alice make-ed-help-items, put all the digits except function-digit at end
04/22/91 alice fix i-search-backspace to backup by words correctly, tweak i-search-add-char
               to store delta in both cases
03/26/91 bill add method-combination & method-combination-evaluator to *define-type-alist*
03/20/91 bill arglist-from-map didn't work for method-function's
03/15/91 bill buffer-select-blink-pos does the right thing for cursor after #(1 2 3)
              ignore-errors around full-pathname in pathname-to-window (window-title
              may not be a valid pathname)
02/27/91 bill do not specify :cell-size for the car-dialog-item in menu-of-defs-dialog
03/12/91 alice ed-edit-definition - if not known to be in a file, then look in all fred-windows
03/12/91 alice c-m-e and c-m-h - end of expr to window bottom (instead of top)
03/07/91 alice buffer-skip-fwd-reader-macros - special case for #(
02/20/91 alice edit-definition - if recorded source file looks pathname-like but
         does not exist, let  (ed pathname) get an error stead of looking in listener
02/08/91 alice buffer-bwd-sexp - back up one #||#, not over one or many
02/08/91 alice edit-definition call probe-file not full-pathname
02/07/91 alice&bill pathname-to-window - dont use window-title
----------- 2.0b1
02/05/91 bill ed-start-top-level-sexp & ed-end-top-level-sexp for listener.
02/04/91 joe  Make sure ed-current-sexp returns two values.
02/04/91 bill ed-eval-or-compile-top-level-sexp works with cursor at beginning
              of function def.
02/01/91 bill mini-buffer-arglist does terpri if symbol has no arglist.
              This makes it work when *clear-mini-buffer* is false
01/24/91 bill add over-sharps parameter to buffer-bwd-sexp for ed-transpose-sexps
01/30/91 alice c-m-e, c-m-a, c-m-h and friends
01/25/91 alice ed-top-level-sexp-start-pos - just look for newline (
01/23/91 bill add def"trap" to *define-type-alist*.
              ed-current-sexp parses #_symbol & #$symbol specially for meta-.
-------------- 2.0a5
01/03/91 bill an arglist found as (getf (%lfun-info ...) 'arglist) is reported
              as coming from the :definition.
01/02/91 bill arglist-to-stream prints "??" for macros with no help-file or
              user-declared arglist info
12/12/90 bill documentation uses the help file.  arglist-string
12/06/90 bill arglist-from-help-file
11/28/90 alice buffer-bwd-sexp remove the thing that looked back two chars for a #
11/26/90 alice nuke *fast-eval*
11/14/90 bill add "`" to buffer-bwd-sexp prefix characters.
11/06/90 bill buffer-select-blink-pos agrees with the new buffer-bwd-sexp
11/02/90 bill view-default-font for menu-of-defs-dialog.  car-dialog-item inherits its font.
11/01/90 blll  pathname-to-window-title in format-definition-pathnames
10/30/90 bill  ignore-errors in ed-current-sexp
               buffer-skip-fwd-reader-macros
10/26/90 alice "pos" vice 0 in buffer-bwd-sexp.
10/25/90 bill buffer-bwd-sexp skips over #x and any element of "#,'"
10/24/90 bill bind package around macroexpand in ed-macroexpand-...
10/23/90 bill Only search for FRED-WINDOW's in MY-STRING-TO-WINDOW
              Fix (edit-definition '(setf wptr)).  Make edit-definition-p coerce
              a function to its name.
10/24/90 akh bills fix for meta-. (setf blah) and edit-definition-p for function
10/24/90 akh bills fix to my-string-to-window (just look at fred-windows)
10/18/90 akh andrews fix for printing methods in edit-definition select table
10/15/90 akh dont search inspector windows
10/10/90 akh buffer-bwd-sexp - dont match a " or | with beginning of buffer
10/10/90 akh dont creep when control-s/r null string
10/20/90 bill pull edit-definition-p out of edit-definition
09/24/90 bill make arglist-to-stream handle dotted arglists.
09/24/90 bill :include-invisibles in pathname-to-window
09/21/90 bill successful i-search pushes a mark.
              *read-#-dispatch-macros-for-arglist* -> *autoload-traps*
10/11/90 gb   arglist-from-map only counts nclosed once.  No more %str-length.  Try to
;             snarf arglist string from %lfun-info; needs work.
09/13/90 akh fix get-source-files for new info storage
08/29/90 akh  do qualifiers and all classes when searching for defmethods
              adapt for new way of storing source file info
08/25/90 akh  fix search so that *i-search-backup-list* doesnt have odd length
08/21/90 akh  bwd-over-semi-comment-or-end is improved
08/21/90 akh  make forward blinking work at last
08/16/90 akh  fix meta-. for defmethod (setf foo) - tweaks for speed
09/14/90 bill remove history stuff from ed-inspect-current-sexp
08/29/90 bill make edit-definition do (sort of) the right thing for a method arg
              and a function arg.
08/23/90 bill fred-start-mark -> fred-display-start-mark, (setf arglist),
              ed-macroexpand-1-current-sexp prints at least once.
              Fix arglist for closures.
08/21/90 bill  arglist-to-stream doesn't print if no function binding.
               %ARGLIST takes the temp-cons-p arg, ARGLIST doesn't
08/16/90 akh   fix meta-. for defmethod (setf foo) - tweaks for speed
08/17/90 bill fix window-scroll when *next-screen-context-lines* is a float.
08/16/90 bill Remove consing from arglist-to-stream
08/13/90 bill Added arglist.  arglist-to-stream calls arglist with-temporary-consing
08/13/90 gb   use %source-files vice gethash.  Yow, abstraction.
08/13/90 alms punted string-to-window
              ed just calls fred in more cases
              edit-definition calls find-symbol instead of intern
08/11/90 bill add single-selection? arg to window-enqueue-region calls when applicable
08/10/90 bill No package prefix on arguments in arglist-from-map & arglist-from-compiled-def 
08/08/90 gb   parameterized search-check-type from Alice.
07/31/90 bill  New get-string-from-user arglist.
               use next-screen-context-lines function vice *next-screen-context-lines* var
07/26/90 bill fix arglist-to-stream for generic-function's, add *help-output*
08/06/90 akh  fix pathname-to-window to use window-title if window has no file
08/06/90 akh  add function string-to-window, change edit-definition to call when appropriate
08/02/90 akh  search-for-fry-def distingush type - e.g. if looking for class require defclass
08/01/90 akh  make search-for-fry-def much less idiotic - deal with #+,#-, #||# etc.
07/29/90 akh  edit-definition - try with stripped trailing punctuation char if any
07/28/90 akh  get-source-files and friend remove nils from list
07/06/90 bill arglist-to-stream: remove encapsulation.
07/05/90 bill nix wptr-if-bound, arglist-from-map: method's no longer take an extra arg.
              *minibuffer-help-output* -> *mini-buffer-help-output*
              Make control-x exit out of i-search correctly.
06/25/90 bill :table-height -> :table-dimensions
06/21/90 bill make pathname-to-window agree with fred-initialize.
06/20/90 bill eliminate redundant repetition of last form from
              ed-macroexpand-1-current-sexp.
06/12/90 bill buffer-current-sexp, current-sexp* -> ed-current-sexp*,
              window-start-mark -> fred-start-mark, window-update -> fred-update,
              ed-skip-* -> buffer-skip-*
06/04/90 gb   isearch changes per alms.
05/24/90 bill :window-position & :window-size -> :view-position & :view-size
05/23/90 bill ^R in incremental search no longer moves the mark before the
              beginning of the buffer.  Still has a glitch that you can't wrap
              to end of buffer if there is an instance of what you're looking for
              at the beginning.
04/30/90 gb   choose-restart.
04/11/90 gz   Some ed-xxx fns renamed to buffer-xxx.
              word-chars -> *fred-word-constituents*.
04/10/90 gz  dialog-item-font -> view-font
04/10/90 gz   ed-compile-top-level-sexp -> ed-eval-or-compile-top-level-sexp
03/05/90 bill window-key-event-handler => view-key-event-handler
03/01/90 bill view-buffer => fred-buffer
02/23/90 bill arglist-to-stream does nothing for a symbol with no function definition.
02/14/90 bill in ed-select-top-level-sexp: frec-set-sel => set-selection-range
              to set the mark so the new ed-kill-region will work.
1/3/90    gz   Use '%lambda-list -> %lambda-lists% in arglist-to-stream.
12/29/89  gz   Fix in pathname-to-window for dot-less filenames.
02/07/90 bill Make menu-of-defs-dialog go away if it's window is closed.
              kludgey, but more informative arglist-from-map for generic-functions.
 5-Dec-89 Mly  Somwhat debogify arglist code
11/18/89  gz  lambda lists, source files in hash tables now.
12-Nov-89 Mly ed-skip-bwd-wsp&comments, bwd-over-semi-comment-or-end, buffer-bwd-sexp
              ed-eval-current-sexp was calling slot-boundp/value with transposed args
10/18/89  gz  use lfun-keyvect in arglist-from-compiled-def
28-sep-89 as  added filter option to list-definitions
09/28/89 bill Add ed-push-mark to ed-edit-definition & edit-definition
;09/27/89 gb simple-string -> ensure-simple-string.
09/17/89 gb   remove asks from macroexpand code.  No (f)bound-anywhere 
              anywhere.
09/16/89 bill Remove the last vestiges of object-lisp windows.
              There are still a couple of (ask nil ...)'s in the macroexpand
09/13/89 bill Convert to CLOS
09/11/89 bill arglist-to-stream: function-binding is no more.
9/11/89   gz  Use first-selected-cell.
09/06/89 bill change window-of-defs-dialog to CLOS
              Add method-position-item to create a defmethod description line
              for List Definitions.
08/30/89 bill search-for-def, search-for-clos-def, search-for-fry-def:
              update to search for defmethod for class specificier
07/29/89 bill my-dialog => (objvar my-dialog)
07/28/89 bill "dialog" => "dialog-object"
05/20/89  gz window-update -> window-object-update.
04/20/89  as i-search-backspace updates prompt, couple other tweaks
03/18/89  gz window-foo -> window-object-foo.  Comtab fixes per as.
14-apr-89 as ed-current-symbol, minibuffer arglist stuff
             removed ED-BETWEEN-NON-CLOSE-AND-OPEN-PAREN?
13-apr-89 as operations on top-level sexp's <compile, start, end, select>
9-apr-89  as new incremental search
03/09/89 gz symbolic names for lfun bits.
7-apr-89  as %str-cat takes rest arg
12/30/88  gz New buffers.  Use buffer-read.
             my-file-name -> window-filename, full-namestring -> full-pathname.
12/25/88  gz Allow obfuns if class=nil in search-for-def.
12/16/88  gz ed-lquoted-p -> buffer-lquoted-p
             ed-search-unquoted -> buffer-backward-search-unquoted
12/11/88  gz mark-position -> buffer-position
12/2/88   gz buffer-line -> count-buffer-lines.
11/16/88  gz new fred windows. Merged in fred-execute.

;10/29/88 gb proclaimed *doc-output* special.
8/23/88 gz   declarations
 8/16/88 gz  non-hitype comtabs.
8/10/88 gz   fred-additions-*.lisp -> fred-additions.lisp. Flushed pre-1.0 edit
	     history.  Split off the simpler commands to a new fred-misc file.
6/27/88 jaj  ed-get-documentation better for non-symbols
6/24/88 as   new syntax for ed-insert-with-style
 6/23/88 as   edit-definition-error checks fboundp for macros and special-forms
              fixes to ed-arglist
6/23/88 as   buffer-insert-with-style -> ed-insert-with-style
 6/22/88 as   additions to ed-arglist for compiled defs
 6/21/88 jaj  removed call to print-listener-prompt
6/16/88 as   incremental-search handles spaces
 6/16/88 as   new select-item-from-list return value
6/9/88  as   calls to show-documentation don't pass second arg
             incremental-search handles tildes, returns, tabs
 6/9/88  as   fixes to ed-arglist, et al
 6/01/88 as   ~& in edit-definition-error
6/01/88 as   new version of ed-inspect-current-sexp
 5/31/88 as   mods to ed-edit-definition
5/31/88 as   punted front-fred-window, get-selected-string
5/29/88 as   call show-documentation instead of documentation
 5/29/88 as   style mods to ed-arglist-aux
5/26/88 as   yet another get-string-from-user syntax
 5/25/88 jaj  added file-modeline-package
5/24/88 jaj  added ed-transpose-[sexps|words]
 5/22/88 as   mod to edit-definition
 5/20/88 as   edit-definition and arglist stuff from Pearl
5/20/88 as   new ed-get-documentation, documentation dialog
             new get-string-from-user calling sequence
             (proclaim '(object-variable edwin))
5/19/88 as   changes to incremental search to support new key-decoding
             punted insert-killed-string-from-menu dialog
 5/13/88 jaj  edwin-select-blink-pos doesn't blink for quoted chars
5/12/88 as   added new set of functions
2/17/88 cfry fixed get-selected-string which fixes c-x-c-i
 2/14/87 gb   moved function-args to backtrace.lisp.
1/28/88  as  made get-selected-string not call first-edwin, not take
                optional arg
01/28/88 as   removed references to fred-menu-p
10/15/87 cfry kludged  keystroke-code-string so that a meta-u char would
             have a string of "m-U" instead of "m-u"
             the shift info is lost before keystroke is put into the comtab
10/15/87 jaj moved *next-screen-context-lines* to l1-inits
10/13/87 jaj bind *package* for those things that are eval-enqueued
9/29/87 jaj moved buffer-line to L1-edcmd.lisp
 8/26/87 as   removed excess redrawing from defs-in-buffer
7/25/87 gz   check emacs-mode in ed-help
7/24/87 cfry fixed fred-help to include c-x cmds.
            sped up blinking forward paren.
7/16/87 as  ed-help hard-codes size
7/16/87 as  ed-help no longer mouse sensitive 
7/13/87 jaj init-lists use keywords
6/23/87 gz   removed print-listener-prompt, is now in l1-readloop.
6/19/87 cfry extended ed-help to handle c-x comtab 
                    [and any other nested comtabs]
6/3/87  gz  changed ed-help for new comtab setup.
5/12/87 cfry fixed ed-skip-fwd-vertical-comment
5/03/87 cfry *help-position/size* -> *help-window-position/size*
        deleted def for FRED since l1-edwin now has all that functionality
; 4/19/87 cfry converted from rectangle to pos&size
4/18/87 cfry acutized warning message in fred-cmd-action
   4/14/87 cfry ed-make-sized-window changed procid to 8 so you get a grow-icon
                object-class fred-menu update
; 4/6/87 gz removed the wsp etc. defconstants, now in fredenv.
|#

(defvar *ed-show-setf* nil)

;; this is a kludge - not for general use - finds any window that does not have
;; an associated file - may be "listener" or "new"
(defun my-string-to-window (string)
  (dolist (w1 (windows :class 'fred-window))
    (when (and (not (window-filename w1))
               (string-equal string (window-title w1))
               )
      (return w1))))

;a patch to this fn from L1-edwin.lisp to make forward blinking chars.
;previously named edwin-select-blink-pos and not called by anyone (08/21/90)
; no doubt because it was brain damaged but it did try to forward blink.
; seems to  be called with end = 0 - my my - ignore it

(defun buffer-select-blink-pos (w start end &aux pos ch temp-pos pos-1)
  "returns non-neg integer to blink or NIL if no char should be blinked."
  (declare (ignore start))
  (setq pos (buffer-position w))
  (setq end (buffer-size w))
  (cond ;check for bwd blink first
         ((and (> pos 1)
               (or (eq (setq ch (buffer-char w (setq pos-1 (- pos 1)))) #\) )
                   (eq ch #\"))
               (not (buffer-lquoted-p w pos-1))
               (setq temp-pos (buffer-bwd-sexp w pos))
               (cond ((and (eq temp-pos pos-1) (neq ch #\")) temp-pos) ; we're unbalanced
                     ((setq temp-pos (buffer-forward-find-char
                               w (if (eq ch #\") #\" #\() temp-pos pos-1))
                      (1- temp-pos)))))
         ((and (> pos 1)
               (eq ch #\#)
               (eq (buffer-char w (- pos 2)) #\|)) ;start comment
          (buffer-skip-bwd-#comment w 0 (- pos 2)))
         ;no bwd blink so check for fwd blink
        ((and (< pos end)
              (setq ch (buffer-char w pos))
              (cond ((eq ch #\()
                     (setq temp-pos (buffer-fwd-up-sexp w (%i+ pos 1) end)))
                    ((or (eq ch #\")
                         (and (eq ch #\#)
                              (< (%i+ pos 1) end)
                              (eq (buffer-char w (%i+ pos 1)) #\|)))
                     (setq temp-pos (buffer-fwd-sexp w pos end ch))))
              (not (buffer-lquoted-p w  pos)))         
        ;fwd blink paren or double-quote. limit search to next cr-open-paren
          (- temp-pos 1))))


(defun buffer-char-pos (buf char-or-string &key start end from-end &aux pos)
  (setq start (buffer-position buf (or start (if from-end 0)))
        end (buffer-position buf (or end (if (not from-end) t))))
    (cond ((> start end) (error "start > end: ~S ~S" start end))
         (from-end ;search backwards
          (buffer-backward-find-char buf char-or-string start end))
         (t ;search forward
           (setq pos (buffer-forward-find-char buf char-or-string start end))
           (if pos 
               (- pos 1)))))


; used in sourceserver
(defun buffer-string-pos (buf string &key start end from-end &aux pos)
  (setq start (buffer-position buf (or start (if from-end 0)))
        end (buffer-position buf (or end (if (not from-end) t))))
     (cond ((> start end) (error "start > end: ~S ~S" start end))
         (from-end ;search backwards
          (buffer-backward-search buf string start end))
         (t ;search forward
           (setq pos (buffer-forward-search buf string start end))
           (if pos 
               (- pos (if (characterp string) 1 (length (string string))))))))




;this code came from edwcmd and was patched.

(defun buffer-bwd-sexp (buf &optional pos over-sharps)
  "Returns POSITION that is the beginning of the sexp behind POS."
  (when (null pos)(setq pos (buffer-position buf)))
  (let ((pos (buffer-skip-bwd-wsp&comments buf 0 pos T))) ; dont skip #||#    
    (when (or (null pos) (zerop pos))
      (return-from buffer-bwd-sexp 0))
    (when (and (> pos 1) (buffer-substring-p buf "|#" (- pos 1)))
      (return-from buffer-bwd-sexp (buffer-skip-bwd-#comment buf 0 pos)))
    (let* ((ch (if (buffer-lquoted-p buf pos) #\A (buffer-char buf pos)))
           (pos (case ch
                  ((#\))
                   (or (buffer-bwd-up-sexp buf pos)
                       pos))
                  ((#\" #\| )
                   (or (buffer-backward-search-unquoted buf ch pos)
                       pos))
                  (t
                   (let ((pos (buffer-backward-search-unquoted 
                               buf symbol-specials pos)))
                     (if pos (1+ pos) 0))))))
      (loop
        (unless pos (return 0))
        (let ((old-pos pos))
          (when (and over-sharps
                     (>= pos 2)
                     (eq (buffer-char buf (- pos 2)) #\#))
            (setq pos (- pos 2)))
          (setq pos (buffer-backward-find-not-char buf ",@'#`" 0 pos))
          (if pos (incf pos))
          (when (eq pos old-pos) (return pos)))))))

(defun buffer-skip-fwd-reader-macros (buf &optional pos)
  (when (null pos) (setq pos (buffer-position buf)))
  (let ((size (buffer-size buf)))
    (loop
      (unless pos (return size))
      (let ((old-pos pos))
        (when (and (<= (+ pos 2) size) (eq (buffer-char buf pos) #\#))
          (if (eq (buffer-char buf (+ pos 1)) #\()
            (setq pos (+ pos 1))
            (setq pos (+ pos 2))))
        (setq pos (buffer-forward-find-not-char buf ",'@`" pos size))
        (if pos (decf pos))
        (when (eq pos old-pos) (return pos))))))

(defun buffer-skip-bwd-wsp&comments (w &optional start end no-sharp)
  "Searches back from end [excluding end] to start.
 Returns pos of first non-white char not in a comment
 If start is > end, error.
 If no non-whitespace, non-comment chars from start to END, return NIL.
 Thus returns NIL or 0 <= returned-value < end.
 If cursor is inside a comment, this should return pos of the first
 non-whitespace char, even if that happens to be within that comment."
  (when (null start)(setq start (buffer-position w)))
  (when (null end)(setq end (buffer-size w)))
  (let ((semi-pos (in-semi-comment? w end)))
    (when semi-pos
      (let ((temp (bwd-over-whitespace-or-end w start end)))
        (when (> temp semi-pos)
          (return-from buffer-skip-bwd-wsp&comments (1- temp))))))
  (do ((pos end))
      (nil)
    (let* ((temp (bwd-over-whitespace-or-end w start pos)) ;just after non-white
           (semi-pos (bwd-over-semi-comment-or-end w start temp))) ;on semi maybe
      (setq temp (min temp semi-pos))
      (when (null no-sharp)
        (setq temp (bwd-over-vertical-comment-or-end
                  w start temp)))
      (cond ((< temp pos)
             (setq pos temp))
            ((zerop pos)
             (return 0))
            (t
             (return (- pos 1)))))))

(defun bwd-over-whitespace-or-end (w start end &aux result)
  "Returns the pos after the first non-whitespace looking backward from END
   or, if there is no whitespace in back of END, return END."
   (setq result (buffer-backward-find-not-char w wsp&cr start end))
   (if result 
       (+ result 1)
       end))

(defun bwd-over-semi-comment-or-end (w start end)
  "Returns pos of semi-colon or END.
 If START happens to be >semi position, return START.
 Start is expected to be <= end."
  (let ((result (semi-on-line-pos w end)))
    (cond ((or (not result) ;no semi on line
               (>= result end)) ;semi is forward of end
           end)
          ((> start result)
           start)
          ;; we've got a semi on the line with end on it that is before end
          ;; but is it within a string? result is the semi-position
          ;; fails if a string containing the ; begins on a prior line
          (t (let ((pos (buffer-line-start w end)))
               (loop
                 (when (>= pos result)(return result))
                 (setq pos (buffer-forward-search-unquoted w #\" pos end))
                 (cond ((or (null pos)(> pos result))
                        (return result)))                            
                 (setq pos (buffer-forward-search-unquoted w #\" (%i+ pos 1) end))
                 (cond ((null pos)(return result))
                       ((< result pos)
                        (setq result (buffer-forward-search-unquoted w #\; pos end))
                        (when (not result)(return end))))
                 (setq pos (%i+ pos 1))))))))
    
   
(defun bwd-over-vertical-comment-or-end (w start end &aux result)
     "if the char just before END is a # and the char before it is a |
       then return the pos of the matching # before it or error.
      If end is not just in front of a | and # then return end."
      "does  handle nested vertical comments, does not work when END
      is within a verical comment."
      (cond ((and (> end 1) 
                  (buffer-substring-p w "|#" (- end 2))) ;got #||#
             (setq result (buffer-skip-bwd-#comment w start (- end 2)))
             (if result
                (if (> start result)
                    start
                    result)
                 end))
            (t end)))                        

(defun in-semi-comment? (buf &optional pos &aux result)
  "Returns the position of the semi-colon if POS is within a semi-colon comment.
   Otherwise returns NIL. 
   If the first semi-colon on the line is at pos, returns nil."
  (when (null pos)(setq pos (buffer-position buf)))
   (setq result (semi-on-line-pos buf pos))
   (if (and result (< result pos))
       result))

(defun semi-on-line-pos (buf &optional pos)
  "returns char position of first semi on line or NIL."
   (setq pos (buffer-forward-find-char  buf #\; 
                              (buffer-line-start buf pos)
                              (buffer-line-end buf pos)))
   (when pos (%i- pos 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


#|            
(defmethod window-scroll ((w fred-mixin) &optional pos count)
  "count is the number of lines between the first line displayed and
   the line that POS is on. If this number is <= 0, then POS will be visible."
  (with-slot-values (frec) w
    (when (null count)
      (setq count (- (next-screen-context-lines (frec-full-lines frec)))))
    (frec-set-sel frec pos pos)
    (set-mark (fred-display-start-mark w) (frec-screen-line-start frec pos count))
    (fred-update w)))
|#



(defparameter *help-output* *standard-output*)



#|
(defun ed-current-sexp-start-pos (w &optional pos)
  "If a selection, just return the pos of the beginning of the selection.
   If no selection, return the pos of the first char in the current sexp,
   or NIL if not obviously in a sexp. [cursor surrounded by whitespace]
   "
  (multiple-value-bind (b e) (frec-get-sel (slot-value w 'frec))
    (when (neq b e) (return-from ed-current-sexp-start-pos b)))
  (buffer-current-sexp-start (fred-buffer w) pos))
|#

(defun ed-current-sexp-bounds (w &optional pos)
  (multiple-value-bind (b e) (frec-get-sel (slot-value w 'frec))
    (if (eq b e)
      (buffer-current-sexp-bounds (fred-buffer w) pos)
      (values b e))))

(defmacro sexp-ignore-warnings-and-errors (&rest forms)
  `(handler-case (progn ,@forms)
     (warning (condition)(declare (ignore condition)) (values nil nil))
     (error (condition) (declare (ignore condition)) (values nil nil))))

(defmethod ed-current-sexp ((w fred-mixin) &optional pos dont-skip &aux
                            (buf (fred-buffer w)))
  (multiple-value-bind (b e) (frec-get-sel (slot-value w 'frec))
    (declare (fixnum b e))
    (if (or (neq b e)
            (setq e t b (buffer-current-sexp-start buf pos)))
      (let* ((pkg (window-package w))
             (*package* (if (null pkg) *package* (pkg-arg pkg)))
             (size (buffer-size buf)))
        (when (and (or (eql #\# (buffer-char buf b))
                       (and (eql #\' (buffer-char buf b))
                            (< (1+ b) size)
                            (eql #\# (buffer-char buf (1+ b)))
                            (incf b)))
                   (< (1+ b) size)
                   (%str-member (buffer-char buf (1+ b )) "_$"))
          (multiple-value-bind (symbol end-pos)
                               (sexp-ignore-warnings-and-errors
                                 (buffer-read buf b e))
            (if symbol
              (return-from ed-current-sexp (values symbol end-pos))
              (incf b))))
        (when (not dont-skip) (setq b (buffer-skip-fwd-reader-macros buf b)))
        ; skip from edit-definition, get-doc,
        ; dont from read and and macroexpand 
        (sexp-ignore-warnings-and-errors
         (buffer-read buf b e)))
      (values nil nil))))



(defmethod ed-read-current-sexp ((w fred-mixin) &optional pos)
  (multiple-value-bind (exp endp) (ed-current-sexp w pos t)
    (if endp (pprint exp) (ed-beep))))

(defmethod ed-inspect-current-sexp ((w fred-mixin) &optional pos)
  (multiple-value-bind (form endp) (ed-current-sexp w  pos)
    (if (not  endp)
      (if (eq (view-window w) *top-listener*)
        (inspect *)
        (edit-anything-dialog :inspect))
      (inspect form))))

(defmethod ed-info-current-sexp ((w fred-mixin))
  (multiple-value-bind (b e)(ed-current-sexp-bounds w)
    (if (eq b e)(ed-beep)
        (inspect (ed-current-sexp w e)))))

        ;(edit-anything-dialog nil (buffer-substring (fred-buffer w) b e)(window-package w)))))


#|
(defparameter %documentation-dialog-string "")
(defvar *documentation-dialog* nil)

(defun documentation-dialog ()
  (if (and *documentation-dialog*
           (wptr *documentation-dialog*))
    (window-select *documentation-dialog*)
    (setq *documentation-dialog*
          (get-string-from-user
           "Enter the name of a symbol.  The documentation string (if there is one) will be shown."
           :initial-string %documentation-dialog-string
           :modeless t
           :window-title "Documentation"
           :action-function
           #'(lambda (new-string)               
               (setq %documentation-dialog-string new-string) 
               (show-documentation 
                (read-from-string %documentation-dialog-string nil nil)))))))
|#


#|
(defun ed-line-start-pos (w &optional pos)
  (buffer-line-start w pos))

(defun ed-line-end-pos (w &optional pos)
  (buffer-line-end w pos))
|#


;Returns starting postion of the current top level sexp.
;ignores region, just looks at current cursor position.
;Generally gets sexp that cursor is in.
;If cursor is not in a sexp, and cursor is at the beginning of a line,
;gets the sexp after the cursor, else gets the one before the cursor.
;Returns NIL if can't find top level sexp.




(defun ed-top-level-sexp-start-pos (w &optional pos maybe-stationary)
  (when (null pos)(setq pos (buffer-position w)))
  (when (and maybe-stationary
             (< pos (buffer-size w)))
    (incf pos))
  (loop
    (setq pos (buffer-backward-find-char w #\( pos))
    (when (null pos)(return nil))
    (when (or (eq pos 0)
              (char-eolp (buffer-char w (1- pos))))
      (return pos))
    (setq pos (1- pos))) 
  pos)


#|
(defun ed-top-level-sexp-start-pos (w &optional pos maybe-stationary)
  (when (null pos)(setq pos (buffer-position w)))
  (when (and maybe-stationary
             (< pos (buffer-size w)))
    (incf pos))
  (loop
    (setq pos (buffer-backward-find-char w eol-string pos))
    (when (null pos)
      (if (and (neq 0 (buffer-size w))(eq (buffer-char w 0) #\())
        (return 0)
        (return nil)))
    (when (eq (buffer-char w (1+ pos)) #\()
      (return (1+ pos)))))
|#

#|
; anybody use this?
(defun ed-top-level-sexp (w &aux pos pkg)
  "Return top level sexp or NIL if none. 2nd value is NIL if no top level exp."
  (if (setq pos (ed-top-level-sexp-start-pos w))
    (let ((*package* (if (setq pkg (window-package w))
                       (pkg-arg pkg) *package*)))
      (buffer-read w pos))
    (values nil nil)))
|#



; current or preceding
(defmethod ed-start-top-level-sexp ((w fred-mixin) &optional select)  ; c-m-a
  (let* ((buf (fred-buffer w))
         (pos (ed-top-level-sexp-start-pos buf)))
    (if pos
      (let ((frec (frec w)))
        (if (not select)
          (frec-set-sel frec pos pos)
          (frec-extend-selection frec pos)))
      (ed-beep))))

(defmethod ed-select-start-top-level-sexp ((w fred-mixin))
  (ed-start-top-level-sexp w t))

#|
(defmethod ed-current/next-top-level-sexp ((w fred-mixin) &optional current)
  (let* ((buf (fred-buffer w))
         (old-pos (buffer-position buf))
         (start (ed-top-level-sexp-start-pos buf))
         (end (and start (buffer-fwd-sexp buf start))))
    (when (or (null end)
              (if current (< end old-pos)(<= end old-pos)))
      (setq start (buffer-forward-search buf "
(" (or end old-pos)))
      (cond (start (setq start (1- start))
                   (setq end (buffer-fwd-sexp buf start)))
            (t (setq end nil))))
    (values start end)))
|#

(defmethod ed-current/next-top-level-sexp ((w fred-mixin) &optional current)
  (let* ((buf (fred-buffer w))
         (old-pos (buffer-position buf))
         (start (ed-top-level-sexp-start-pos buf))
         (end (and start (buffer-fwd-sexp buf start))))
    (when (or (null end)
              (if current (< end old-pos)(<= end old-pos))) 
      (setq start (buffer-find-eol-left-paren buf (or end old-pos)))
      (cond (start (setq start (1- start))
                   (setq end (buffer-fwd-sexp buf start)))
            (t (setq end nil))))
    (values start end)))

(defun buffer-find-eol-left-paren (buffer pos)
  (let ((size (buffer-size buffer)))
    (loop 
      (when (>= pos size)(return nil))
      (setq pos (buffer-forward-find-char buffer #\( pos))      
      (when (not pos) (return nil)) 
      (when (> pos 1)
        (when (char-eolp (buffer-char buffer (- pos 2)))
          (return pos)))
      (incf pos)
      )))

(defmethod ed-end-top-level-sexp ((w fred-mixin) &optional select) ; c-m-e
  (let ((end (nth-value 1 (ed-current/next-top-level-sexp  w))))                       
    (if (not end)
        (ed-beep)
        (let ((frec (slot-value w 'frec)))
          (if (not select)
            (frec-set-sel frec end end)
            (frec-extend-selection frec end))
          (window-scroll-to-bottom w end)))))

(defmethod ed-select-end-top-level-sexp ((w fred-mixin))
  (ed-end-top-level-sexp w t))




(defmethod ed-select-top-level-sexp ((w fred-mixin)) ; c-m-h
  (multiple-value-bind (start end)
                       (ed-current/next-top-level-sexp  w t) 
    (if (not (and start end))
        (ed-beep)
        (progn
          (set-selection-range w start end)
          (window-scroll-to-bottom w end)))))


;This needs to be made more consistent with double-clicking...
; No double-clicking needs to be consistent with this - done (08/22/90)
(defmethod ed-select-current-sexp ((w fred-mixin))
  (unless (selectionp w)
    (multiple-value-bind (start end) (ed-current-sexp-bounds w)
      (if start
        #|(let* ((frec (frec w)) ; like c-m-h
               (pos (buffer-position (fr.cursor frec))))
          (cond ((< start pos)
                 (frec-set-sel frec end start)
                 (window-show-cursor w))
                (t (frec-set-sel frec start end)
                   (window-scroll-to-bottom w))))
        |#
        (frec-set-sel-simple (frec w) start end) ; like double click
        (ed-beep)))))

(defmethod ed-indent-sexp ((w fred-mixin))
  "leave top line of region in the same place, but indent
   everything under it in that sexp."
  (multiple-value-bind (start-pos end-pos) (ed-current-sexp-bounds w)
    (if start-pos
      (ed-indent-for-lisp w start-pos end-pos)
      (ed-beep))))

#| ;; below is in examples;font-search.lisp
(defparameter *font-search-mask* (cons #xffffffff 0))
;; font mask #xffff0000
;; face mask #xff00
;; color mask #xff

(defclass font-pop-up (font-menu pop-up-menu)())

(defmethod menu-update ((menu font-pop-up)) nil)

(defvar *font-search-color* 0)
(defvar *font-search-font* 0)
(defvar *font-search-style* 0)

(defclass font-dialog (dialog)())

(defparameter *VERY-LIGHT-GRAY* #xeeeeee)

;; find blue text or whatever -  find font like where we're at  now 
;; - kinda weird cause it backs up 1 for consecutive calls
;; uses masks set by dialog or init values.

(defmethod ed-find-this-font-again ((w fred-mixin) )
  (let* ((buffer (fred-buffer w))
         (pos (buffer-position buffer))
         (ffmask (car *font-search-mask*))
         (msmask (cdr *font-search-mask*)))    
    (multiple-value-bind (ff ms)(buffer-char-font-codes buffer (if (eq pos 0) 0 (1- pos)))
      (do-font-search-sub w ff ms ffmask msmask))))

;;; search for font specified by dialog

(defmethod do-font-search ((w fred-mixin))
  (let* ((ffmask (car *font-search-mask*))
         (msmask (cdr *font-search-mask*))
         (ff (logior (ash *font-search-font* 16)(ash *font-search-style* 8) *font-search-color*))
         (ms 0))
    (do-font-search-sub w ff ms ffmask msmask)))

(defmethod do-font-search-sub ((w fred-mixin) ff ms ffmask msmask)
  (let* ((buffer (fred-buffer w))
         (pos (buffer-position buffer)))
    (let* ((start-pos (or (if (font-matches buffer pos ff ms ffmask msmask) pos)
                          (buffer-find-font-matching buffer pos ff ms ffmask msmask)))
           (end-pos (if start-pos (buffer-find-font-not-matching buffer start-pos ff ms ffmask msmask))))
      (if (not start-pos)
        (ed-beep)
        (progn 
          (set-selection-range w start-pos (or end-pos (buffer-size buffer)))
          (window-show-selection w) ;; leaves mark at end (past it)
          )))))

(defun buffer-find-font-not-matching (buffer pos ff ms ffmask msmask)
  (let ((next-pos (buffer-next-font-change buffer pos)))
    (loop
      (when (not next-pos)
        (return-from buffer-find-font-not-matching nil))
      (when (not (font-matches buffer next-pos ff ms ffmask msmask))
        (return-from buffer-find-font-not-matching next-pos))
      (setq pos next-pos)
      (setq next-pos (buffer-next-font-change buffer pos)))))

(defun buffer-find-font-matching (buffer pos ff ms ffmask msmask)
  (let ((next-pos (buffer-next-font-change buffer pos)))
    (loop
      (when (not next-pos)
        (return-from buffer-find-font-matching nil))
      (when (font-matches buffer next-pos ff ms ffmask msmask)
        (return-from buffer-find-font-matching next-pos))
      (setq pos next-pos)
      (setq next-pos (buffer-next-font-change buffer pos)))))

(defun font-matches (buffer pos ff ms ffmask msmask)
  (multiple-value-bind (next-ff next-ms)(buffer-char-font-codes buffer pos)
    (and (eql (logand ff ffmask) (logand next-ff ffmask))
         (eql (logand ms msmask) (logand next-ms msmask)))))


(defun font-search-action (item w &optional top)
  (declare (ignore w))
  (let* ((dialog (view-window item))
         (font-pu (view-named 'font-pop-up dialog))
         (color-pu (view-named 'color-pop-up dialog))
         (style-pu (view-named 'style-pop-up dialog)))
    (let* ((num (pop-up-menu-default-item font-pu))
           (font-item (nth (1- num) (menu-items font-pu))))
      (if (equalp (menu-item-title font-item) "Any font")
        (progn  (setf (car *font-search-mask*) #xFFFF))
        (progn (setf (car *font-search-mask*) #xffffffff)
               (setq *font-search-font* (font-number-from-name (attribute font-item))))))
    (let* ((num (pop-up-menu-default-item color-pu))
           (color-item (nth (1- num) (menu-items color-pu))))
      (if (equalp (menu-item-title color-item) "Any color")
        (setf (car *font-search-mask*) (logand (car *font-search-mask*) #xffffff00))
        (setq *font-search-color* (second (car (attribute color-item))))))    
    (let* ((num (pop-up-menu-default-item style-pu))
           (style-item (nth (1- num) (menu-items style-pu))))
      (if (equalp (menu-item-title style-item) "Any style")
        (setf (car *font-search-mask*) (logand (car *font-search-mask*) #xffff00ff))
        (setq *font-search-style* (style-arg (attribute style-item)))))
    (let* ((window (target))
           (key-handler (current-key-handler window)))
      (if (typep key-handler 'fred-mixin)
        (progn
          (if top (window-top key-handler))
          (do-font-search key-handler))
        (ed-beep)))))


(defun font-dialog (w &optional ff ms)
  (let ((dialog (or (front-window :class 'font-dialog)
                    (make-font-dialog w))))
    (window-select dialog)
    (let ((font-pop-up (view-named 'font-pop-up dialog))
          (color-pop-up (view-named 'color-pop-up dialog))
          (style-pop-up (view-named 'style-pop-up dialog)))
      (when (or ff ms)
      (let* (;(font (ash ff -16))
             (style (logand #xff (ash ff -8)))
             (color (logand #xff ff)))
        (let* ((item (find-menu-item font-pop-up (car (font-spec ff ms))))
               (pos (position item (menu-items font-pop-up))))
          (set-pop-up-menu-default-item font-pop-up (1+ pos)))
        (let ((pos (position color
                             (menu-items color-pop-up)
                             :key #'(lambda (item)
                                      (ignore-errors ;; huh
                                       (when (typep item 'font-menu-item)(second (car (attribute item))))))
                             :test 'eql)))
          (set-pop-up-menu-default-item color-pop-up (1+ pos)))
        (let ((pos (position style
                             (menu-items style-pop-up)
                             :key #'(lambda (item)
                                      (ignore-errors
                                       (when (typep item 'font-menu-item)
                                         (style-arg (attribute item)))))
                             :test 'eql)))
          (set-pop-up-menu-default-item style-pop-up (1+ pos))))))))

(defun make-font-dialog (w)
  (let ((font-pop-up (make-instance 'font-pop-up :menu-title "Font: "
                                    :view-position #@(10 10)
                                    :menu-colors `(:menu-body ,*VERY-LIGHT-GRAY*)  ;,*tool-back-color*) ;; lighter still
                                    :view-nick-name 'font-pop-up
                                    ))
        (color-pop-up (make-instance 'font-pop-up :menu-title "Color:"
                                     :view-position #@(10 40)
                                     :menu-colors `(:menu-body ,*VERY-LIGHT-GRAY*)
                                     :view-nick-name 'color-pop-up))
        (style-pop-up (make-instance 'font-pop-up :menu-title "Style:"
                                     :view-position #@(10 70)
                                     :menu-colors `(:menu-body ,*VERY-LIGHT-GRAY*)
                                     :view-nick-name 'style-pop-up))
        (search-button (make-instance 'button-dialog-item :dialog-item-text "Search"
                                      :view-position #@(60 104)
                                      :default-button t
                                      :dialog-item-action #'(lambda (item) (font-search-action item w))))
        (from-top-button (make-instance 'button-dialog-item :dialog-item-text "From top"
                                      :view-position #@(150 104)
                                      :dialog-item-action #'(lambda (item) (font-search-action item w t)))))
    
    (let ((*font-menu* font-pop-up))
      (add-font-menus))
    (add-menu-items font-pop-up (make-instance 'menu-item :menu-item-title "-")
                    (make-instance 'menu-item :menu-item-title "Any Font"))
    (add-font-color-items color-pop-up)
    (add-menu-items color-pop-up (make-instance 'menu-item :menu-item-title "-")
                    (make-instance 'menu-item :menu-item-title "Any Color"))
    (add-font-style-items style-pop-up)
    (add-menu-items style-pop-up (make-instance 'menu-item :menu-item-title "-")
                    (make-instance 'menu-item :menu-item-title "Any Style")) 
    (make-instance 'font-dialog  :window-title "Font Search"
                   :back-color *tool-back-color*
                   :view-subviews (list font-pop-up color-pop-up style-pop-up search-button from-top-button))))
         
      

(defmethod ed-setup-find-font ((w fred-mixin))
  (let* ((buffer (fred-buffer w))
         (pos (buffer-position buffer)))
    (multiple-value-bind (ff ms)(buffer-char-font-codes buffer pos)
      (font-dialog w ff ms))))

;; c-m-r is already used

(def-fred-command (:control :meta #\s) ed-find-this-font-again)
(def-fred-command (:control :meta :shift #\s) ed-setup-find-font)
|#
                             
 
;;incremental search

;;;;;;;;;;;
;;
;; various state parameters
;;

;; I think maybe-start-isearch made it a base-string - fixed now
(defparameter *i-search-search-string* (make-array 12 :element-type 'character
                                                :fill-pointer 0
                                                :adjustable t))

(defparameter *i-search-forward-p* t)

(defparameter *i-search-original-pos* 0)

(defparameter *i-search-found-p* t)

(defparameter *i-search-note-string* "")

(defparameter *i-search-backup-list* '())

(defparameter *i-search-failed-characters* 0)

(defparameter *i-search-started* nil)

(defparameter *i-search-start-mark* nil)

(defparameter *i-search-end-mark* nil)

;(defparameter *i-search-buffer-size* 0)

(defun unichar-for-w (w char)
  (let* ((buffer (fred-buffer w))
         (ff (buffer-font-codes buffer))
         (encoding (font-to-encoding-no-error (ash ff -16)))
         (script (get-key-script)))
    (let ((res (convert-char-to-unicode char (if (neq script #$smroman) script encoding))))
      res)))
  

(defparameter *i-search-control-q-comtab*
  (make-comtab #'(lambda (w)
                   (i-search-add-char w (unichar-for-w w *current-character*))
                   (i-search-prompt w)
                   (install-shadowing-comtab w *i-search-comtab* nil))))

;;;;;;;;;;;;;
;;
;; the i-search comtab
;;

(defparameter *i-search-comtab* (make-comtab 'i-search-do-keystroke))

(defun i-search-do-keystroke (w)
  (declare (special *default-command-p*))
  (let* ((key-code *current-keystroke*)
         (char *current-character*))
    (if (and (or (%i> key-code 32)
                 (eql char #\return)
                 (eql char #\tab)
                 (eql char #\space))
             (neq char #\rubout)
             (eql key-code (logand #xff key-code)))
      (i-search-add-char w (unichar-for-w w char))
      (progn
        (ed-push-mark w (car *i-search-original-pos*))
        (remove-shadowing-comtab w)
        ;(collapse-selection w t) ; I like this but Mac weenies probably wont
        (run-fred-command w (keystroke-function w key-code))
        (setq *default-command-p* t)
        (i-search-all-done w)))))


(eval-when (eval compile #-bccl load)
  (defmacro def-i-search (keystroke &body body)
    `(comtab-set-key *i-search-comtab*
                     ',keystroke
                     #'(lambda (w)
                         ,@body))))

(def-i-search (:control #\s)
  (let* ((start-mark *i-search-start-mark*)
         (pos (buffer-position start-mark))
         (foundp *i-search-found-p*))
    (if foundp
        ;found last time, so we mark the position and search again
        (progn 
          (when (neq pos (cadr *i-search-backup-list*))
            (push pos *i-search-backup-list*)
            (push 0 *i-search-backup-list*))
          (unless (or (eq 0 (length *i-search-search-string*))
                      (eq pos (buffer-size start-mark)))
            (move-mark start-mark 1)))
        ;not found last time, so we wrap if last search was forward
        (progn
          (when *i-search-forward-p*          
            (setq *i-search-note-string* " Wrapping")
            (set-mark start-mark 0))))
    (setq *i-search-forward-p* t)
    (i-search-search w)
    (unless (and foundp *i-search-found-p*)(i-search-prompt w))))

(def-i-search (:control #\r)
  (let* ((start-mark *i-search-start-mark*)
         (pos (buffer-position start-mark))
         (end-mark *i-search-end-mark*)
         (foundp *i-search-found-p*))
    (if foundp
      ;found last time, so we mark the position and search again
      (progn
        (when (neq pos (cadr *i-search-backup-list*)) 
          (push pos *i-search-backup-list*)
          (push 0 *i-search-backup-list*))
          (set-mark end-mark (max 0 (- pos  1)))) ; was 2
      ;not found last time, so we wrap if last search was backward
      (progn
        (unless *i-search-forward-p*
          (setq *i-search-note-string* " Wrapping")
          (set-mark end-mark (buffer-size start-mark)))))
    (setq *i-search-forward-p* nil)
    (i-search-search w)
    (unless (and foundp *i-search-found-p*)(i-search-prompt w))))

(def-i-search #\escape
  (collapse-selection w *i-search-forward-p*)
  (i-search-all-done w))

(def-i-search (:control #\g)
  (if (eq *i-search-failed-characters* 0)
      (progn
        (collapse-selection w *i-search-forward-p*)
        (set-mark (fred-buffer w) (car *i-search-original-pos*))
        (set-mark (fred-display-start-mark w) (cdr *i-search-original-pos*))
        (i-search-all-done w))
      (let* ((search-string *i-search-search-string*))
        (set-fill-pointer search-string
                          (max 0 (%i- (fill-pointer search-string) ; <<
                                      *i-search-failed-characters*)))
        (setq *i-search-failed-characters* 0)
        (i-search-search w)
        (i-search-prompt w))))

#|
(def-i-search #\backspace
  (let* ((search-string *i-search-search-string*)
         (start-mark *i-search-start-mark*)
         (end-mark *i-search-end-mark*)
         delta)
    (if *i-search-backup-list*
      (progn
        (setq delta (or (pop *i-search-backup-list*) 0))
        (setf (fill-pointer search-string)
              (- (fill-pointer search-string) delta))
        (setq *i-search-failed-characters* (max 0 (- *i-search-failed-characters* 1)))
        (set-mark start-mark (or (pop *i-search-backup-list*) start-mark))
        (set-mark end-mark (min (max 0 (%i+ (buffer-position start-mark) ; <<
                                            (%i- (length search-string) *i-search-failed-characters*)))
                                (buffer-size start-mark)))
        (set-mark (fred-buffer w) start-mark)
        (set-selection-range w end-mark)
        (i-search-prompt w)
        (window-show-selection w))
      (ed-beep))))
|#

(def-i-search #\backspace
  (let* ((search-string *i-search-search-string*)
         (start-mark *i-search-start-mark*)
         (end-mark *i-search-end-mark*)
         delta)
    (if *i-search-backup-list*
      (progn
        (setq delta (or (pop *i-search-backup-list*) 0))
        (setf (fill-pointer search-string)
              (- (fill-pointer search-string) delta))
        (setq *i-search-failed-characters* (max 0 (- *i-search-failed-characters* 1)))
        (let* ((bufsize (buffer-size start-mark))
               (backup (pop *i-search-backup-list*)))
          (when backup
            (setq backup (max 0 (min backup bufsize))))
          (set-mark start-mark (or backup start-mark))
          (set-mark end-mark (min (max 0 (%i+ (buffer-position start-mark) ; <<
                                              (%i- (length search-string) *i-search-failed-characters*)))
                                  bufsize)))
        (set-mark (fred-buffer w) start-mark)
        (set-selection-range w end-mark)
        (i-search-prompt w)
        (window-show-selection w))
      (ed-beep))))

(def-i-search (:control #\q)
  (set-mini-buffer w "~&Type Quoted Character: ")
  (install-shadowing-comtab  w *i-search-control-q-comtab* nil))

(def-i-search (:control #\w)
  (let* ((start-mark *i-search-start-mark*)
         (end-mark *i-search-end-mark*)
         (buf (fred-buffer w)))
    (unless *i-search-started*
      (set-mark end-mark start-mark))
    (if (>= (buffer-position end-mark)(buffer-size buf))
      (ed-beep)
      (let* ((pos (buffer-forward-find-not-char buf
                                                *fred-word-constituents*
                                                (%i+ 1 (buffer-position end-mark))
                                                t)))
        (i-search-add-char w (if pos (%i- pos 1)(buffer-size start-mark)))))))

(def-i-search (:control :meta #\w)
  (let* ((start-mark *i-search-start-mark*)
         (end-mark *i-search-end-mark*)
         (buf (fred-buffer w)))
    (unless *i-search-started*
      (set-mark end-mark start-mark))
    (let* ((pos (buffer-fwd-sexp buf (%i+ 1 (buffer-position end-mark)))))
      (i-search-add-char w (if pos pos (buffer-size start-mark))))))

(def-i-search (:control #\y)
  (let* ((start-mark *i-search-start-mark*)
         (end-mark *i-search-end-mark*)
         (buf (fred-buffer w)))
    (block nil
      (unless *i-search-started*
        (multiple-value-bind (b e)(selection-range w)
          (cond ((neq b e)
                 (set-mark start-mark b)
                 (set-mark end-mark b)
                 (i-search-add-char w e)
                 (return-from nil nil))
                (t (set-mark end-mark start-mark)))))
      (if (>= (buffer-position end-mark)(buffer-size buf))
        (ed-beep)
        (let* ((pos (buffer-forward-find-char buf
                                              eol-string ;#\return
                                              (%i+ 1 (buffer-position end-mark))
                                              t)))
          (i-search-add-char w (if pos (%i- pos 1) (buffer-size start-mark))))))))


;;;;;;;;;;;;;;;;;;
;;
;; i-search functions
;;

(defmethod ed-i-search-forward ((w fred-mixin))
  (if t ;(view-mini-buffer w)
    (init-i-search w t)
    (ed-beep)))

(defmethod ed-i-search-reverse ((w fred-mixin))
  (if t ;(view-mini-buffer w)
    (init-i-search w nil)
    (ed-beep)))


(defun init-i-search (w forward-p &aux
                          (buf (fred-buffer w)))
  (install-shadowing-comtab w *i-search-comtab* nil)
  (setq *i-search-forward-p* forward-p
        *i-search-original-pos* (cons (buffer-position buf)
                                      (buffer-position (fred-display-start-mark w)))
        *i-search-found-p* t
        *i-search-failed-characters* 0
        *i-search-backup-list* (list (length *i-search-search-string*)
                                     (buffer-position buf))
        *i-search-note-string* ""
        *i-search-started* nil
        *i-search-start-mark* (make-mark buf)
        *i-search-end-mark* (make-mark buf))
  (i-search-prompt w))


(defmethod i-search-prompt ((view fred-mixin) &optional init)
  (i-search-prompt (view-window view) init))

(defmethod i-search-prompt ((w window) &optional init)(declare (ignore init)) nil)


(defmethod i-search-prompt ((w fred-window) &optional init)
  (let ((mb (view-mini-buffer w))
        (str "i-search"))
    (when mb
      (let* ((buf (fred-buffer mb))
             (pos (buffer-position buf))
             (bpos (buffer-line-start buf buf 0)))                        
          (cond ((and (not init) bpos (< bpos pos)
                      (not (string-eol-position  *i-search-search-string*))
                      (progn
                        (if (not (view-status-line w))
                         (setq bpos (+ bpos (length (view-package-string w)) 2)))
                        (when (< bpos (buffer-size buf))
                          (buffer-substring-p buf str bpos))))
                 ; works when no pkg preface
                 (buffer-delete buf (+ bpos (length str)) (buffer-size buf)))
                (t (setq init t)))
          (when init 
            (stream-fresh-line mb)
            (buffer-insert buf str))
          (buffer-insert buf *i-search-note-string*)
          (buffer-insert buf (if *i-search-forward-p* ": " " reverse: "))
          (buffer-insert buf *i-search-search-string*)
          (fred-update mb)))))

(defun i-search-add-char (w char-or-pos)
  (let* ((end-mark *i-search-end-mark*)
         (pos (buffer-position *i-search-start-mark*))
         (search-string *i-search-search-string*)
         (started *i-search-started*)
         (foundp *i-search-found-p*))
    
    (unless started
      (setf (fill-pointer search-string) 0
            *i-search-backup-list* ()))
    (push pos *i-search-backup-list*)
    (if (characterp char-or-pos)
        (progn 
          (push 1 *i-search-backup-list*)
          (vector-push-extend char-or-pos search-string))
        (progn
          (push (- char-or-pos (buffer-position end-mark))
                *i-search-backup-list*)
          (until (eq (buffer-position end-mark)
                     char-or-pos)
            (vector-push-extend (buffer-char end-mark)
                                search-string)
            (move-mark end-mark 1))))
    (setq *i-search-note-string* "")    
    (i-search-search w)
    (if (and started foundp (eq 0 (length *i-search-note-string*))(characterp char-or-pos))
      (let* ((mb (view-mini-buffer w)))
        (when mb
          (stream-tyo mb char-or-pos)
          (mini-buffer-show-cursor w)
          (fred-update mb)))
      (i-search-prompt w))))

(defun i-search-all-done (w)
  (let ((comtab (fred-shadowing-comtab w)))
    (when (or (eq comtab *i-search-comtab*)
              (null comtab))
      (remove-shadowing-comtab w" (Search Complete."))))

(defun i-search-search (w)
  (setq *i-search-started* t)
  (let* ((buf (fred-buffer w))
         (search-string *i-search-search-string*)
         (forward-p *i-search-forward-p*)
         (found-p nil)
         (start-mark *i-search-start-mark*)
         (end-mark *i-search-end-mark*))
    (when (and start-mark (not (same-buffer-p start-mark buf)))
      (setq start-mark (setq *i-search-start-mark* (make-mark buf))))
    (when (and end-mark (not (same-buffer-p end-mark buf)))
      (setq end-mark (setq *i-search-end-mark*  (make-mark buf))))
    (setq found-p
          (if forward-p
              (buffer-forward-search buf
                                     search-string
                                     start-mark
                                     t)
              (buffer-backward-search buf
                                      search-string
                                      (min (1+ (buffer-position end-mark))
                                           (buffer-size buf))
                                      0)))
    (setq *i-search-found-p* found-p)
    (let ((w " Wrapping") (fw " Failing wrapping"))
      (setq *i-search-note-string*
            (if found-p
              (if (equal *i-search-note-string* fw) w "")
              (if (equal *i-search-note-string* w) fw " Failing"))))
    (cond (found-p
           (setq *i-search-failed-characters* 0)
           (if forward-p
             (progn
               (set-mark start-mark (- found-p
                                       (length search-string)))
               (set-mark end-mark found-p))
             (progn
               (set-mark start-mark found-p)
               (set-mark end-mark (+ found-p
                                     (length search-string)))))
           (set-mark buf start-mark)
           (set-selection-range w end-mark)
           (window-show-selection w))
          ((eq (car *i-search-backup-list*) 0)
           (ed-beep))
          ((eql (setq *i-search-failed-characters*
                      (%i+ *i-search-failed-characters* 1))
                1)
           (ed-beep)))))

;;;;;;;;;;;;; 
;; below is all the stuff to allow inline input with CJK keyboards - from Takehike Abe <keke@gol.com>
;; uses #_NewTSMDocument



;; from Takehiko Abe tsm-carbon.lisp

(defparameter *hilite-color-alist*
  '((#.#$kRawText . #.*red-color*)
    (#.#$kSelectedRawText . #.*black-color*)
    (#.#$kConvertedText . #.*gray-color*)
    (#.#$kSelectedConvertedText . #.*black-color*)))

;; refcon is the key in *tsm-documents-table*
(defun %new-tsm-document (refcon &optional (interfaces (list #$kUnicodeDocument)))
  (declare (fixnum refcon))
  (let ((len (length interfaces))
        (err 0))
    (declare (fixnum len err))
    (rlet ((supported-interfaces (list :array :ostype len))
           (doc-id :TSMDocumentID))
      (dotimes (i len)
        (declare (fixnum i))
        (%put-ostype supported-interfaces
                     (elt interfaces i)
                     (* i 4)))
      (setq err (#_NewTSMDocument len supported-interfaces 
                 doc-id
                 refcon))
      (if (eq err #$noerr)
        (%get-ptr doc-id)
        ; (cnd:trap-error "NewTSMDocument" err)
        (error "NewTSMDocument returned ~A." err)
        ))))

(defloadvar *tsm-documents-table* (make-hash-table :weak :value))

(defun %get-tsm-document (tsm-key)
  (gethash tsm-key *tsm-documents-table*))

(defun %add-tsm-document (tsm-doc)
  (flet ((unique-key ()
           ;; tsm sends refcon=0 for invalid doc in classic
           (do ((new-key (1+ (random #xFFFFE))))
               ((not (gethash new-key *tsm-documents-table*))
                new-key)
             (declare (fixnum new-key))
             (incf new-key))))
    ;; (declare (dynamic-extent unique-key))
    (without-interrupts
      (let ((key (unique-key)))
        (declare (fixnum key))
        (setf (gethash key *tsm-documents-table*) tsm-doc)
        key))))


(defclass tsm-document-mixin ()
  ((tsm-ptr :initform nil :reader tsm-ptr)
   (key :initform nil :reader tsm-document-key)
   ;; buffer-position when inline-input session starts.
   (inline-offset :initform nil)
   (selection-p :initform nil :accessor selection-p)
   ;; ugly workaround. updaterange after getselectedtext event
   ;; returns wrong value causing delete to fail.
   (getselectedtext-called-p :initform nil :accessor getselectedtext-called-p)
   (inline-input-region :initform (#_newrgn)    ; ok?
                        :accessor tsm-document-inline-input-region)
   (hilite-region :initform (#_newrgn)
                  :accessor tsm-document-hilite-region)))


#| ;; do this in (setf wptr) method now
;; create new tsm-document before it gets wptr. this matters
(defmethod initialize-instance :around ((self tsm-document-mixin) 
                                        &key (interfaces (list #$kUnicodeDocument)))  
  (let ((key (%add-tsm-document self)))
    (declare (fixnum key))
    (setf (slot-value self 'key) key
          (slot-value self 'tsm-ptr) (%new-tsm-document key interfaces)))
  (terminate-when-unreachable self)
  (call-next-method))
|#


(defmethod terminate ((self tsm-document-mixin))
  (when (tsm-ptr self)
    (#_deletetsmdocument (tsm-ptr self))
    (setf (slot-value self 'tsm-ptr) nil))
  (when (tsm-document-inline-input-region self)
    (#_disposergn (tsm-document-inline-input-region self))
    (setf (tsm-document-inline-input-region self) nil))
  (when (tsm-document-hilite-region self)
    (#_disposergn (tsm-document-hilite-region self))
    (setf (tsm-document-hilite-region self) nil)))

(add-pascal-upp-alist-macho 'text-handler-proc "NewEventHandlerUPP")


(defpascal text-handler-proc (:ptr nexthandler :eventref event
                               :ptr userdata
                               :osstatus)
  (declare (ignore nexthandler userdata))
  (rlet ((key :uint32))
    (if (eq #$noerr (#_geteventparameter event
                     #$kEventParamTextInputSendRefCon
                     #$typeuint32  
                     (%null-ptr)
                     (record-length :uint32)
                     (%null-ptr)
                     key))
      (let ((doc (%get-tsm-document (%get-unsigned-long key))))
        ;; in classic doc can be nil why? Refcon = 0
        ;; 2004-04-05 note: above classic problem may be due to
        ;; my use of #_neweventhandlerupp? 
        (if doc
          (text-input-event-handler doc event)
          #$eventnothandlederr))
      #$eventnothandlederr)))


(defmethod (setf wptr) :before (new-wptr (self tsm-document-mixin))  
  (when new-wptr
    ;; create new tsm-document before it gets wptr. this matters
    (when (not (tsm-ptr self))  ;; in case got removed from window, then put back - actually always done here today
      (let ((key (%add-tsm-document self)))
        (declare (fixnum key))
        (if (not (tsm-document-inline-input-region self))
          (setf (tsm-document-inline-input-region self) (#_newrgn)))
        (if (not (tsm-document-hilite-region self))
          (setf (tsm-document-hilite-region self) (#_newrgn)))
        
        (setf (slot-value self 'key) key
              (slot-value self 'tsm-ptr) (%new-tsm-document key (list #$kUnicodeDocument))))
      ;; do we need this? - no
      ;(terminate-when-unreachable self)
      )
    (%stack-block ((specs #.(* 5 (record-length :eventtypespec))))
      ;; 1
      (%put-ostype specs #$kEventClassTextInput)  ;; eventclass
      (%put-long specs #$kEventTextInputUpdateActiveInputArea 4)  ;; eventkind
      ;; 2 added for korean
      (%put-ostype specs #$kEventClassTextInput 8)
      (%put-long specs #$kEventTextInputUnicodeForKeyEvent 12)
      ;; 3
      (%put-ostype specs #$kEventClassTextInput 16)
      (%put-long specs #$kEventTextInputOffsetToPos 20)
      ;; 4
      (%put-ostype specs #$kEventClassTextInput 24)
      (%put-long specs #$kEventTextInputPosToOffset 28)
      ;; 5
      (%put-ostype specs #$kEventClassTextInput 32)
      (%put-long specs #$kEventTextInputGetSelectedText 36)
      (#_InstallEventHandler (#_getwindoweventtarget new-wptr)
       text-handler-proc  ;; should be text-handler-proc !
       5 specs (%null-ptr) (%null-ptr)))))

;; Calling ActivateTSMDocument before NewTSMDocument and InstallEventHandler
;; crashes MCL.

(defmethod view-activate-event-handler :after ((self tsm-document-mixin))
  (when (eq self (current-key-handler (view-window self)))
    (let ((tsm-ptr (tsm-ptr self)))
      (when tsm-ptr
        (#_activatetsmdocument tsm-ptr)))))

(defmethod view-deactivate-event-handler :after ((self tsm-document-mixin))
  (let ((tsm-ptr (tsm-ptr self)))
    (when tsm-ptr
      (#_FixTSMDocument tsm-ptr)
      (#_deactivatetsmdocument tsm-ptr))))

(defmethod view-click-event-handler :before ((view tsm-document-mixin) where)
  (declare (ignore where))
  (let ((tsm-ptr (tsm-ptr view)))
    (when tsm-ptr
      (#_FixTSMDocument tsm-ptr))))

;; this is cheating i know.
(defmethod set-view-size :before ((view tsm-document-mixin) h &optional v)
  (declare (ignore h v))
  (when (tsm-ptr view)
    (#_FixTSMDocument (tsm-ptr view))))

(defmethod window-can-do-operation ((tsm-doc tsm-document-mixin) op &optional item)
  (declare (ignore op item))
  (if (updating-input-area-p tsm-doc)
    nil
    (call-next-method)))

;; The slot inline-offset stores buffer-position when an inline-input
;; session is started. When an inline-input session is terminated, it
;; is set to nil. When text-input-event-handler is called, it first
;; checks inline-offset value. If the value is nil [which means that
;; the session has just started], it sets the slot to buffer-position
;; of the document.

(defun updating-input-area-p (tsm-doc)
  (slot-value tsm-doc 'inline-offset))

(defmacro %inline-input-offset (doc)
  `(slot-value ,doc 'inline-offset))

(defmacro %set-inline-input-offset (doc offset)
  `(setf (slot-value ,doc 'inline-offset) ,offset))

;;;
;;; text-input-event-handler
;;;


(define-condition tsm-error (error) ())

(define-condition tsm-get-event-parameter-error (tsm-error)
                  ((error-code :initarg :error-code
                               :reader tsm-error-code)
                   (parameter-name :initarg :parameter-name
                                   :reader tsm-error-parameter-name))
  (:report (lambda (condition stream)
             (format stream "GetEventParameter for ~A failed [~A]."
                     (tsm-error-parameter-name condition)
                     (tsm-error-code condition)))))

;; why are these all macros?

#|
(defmacro %get-event-script (event)
  (let ((slrecord (gensym))
        (err (gensym)))
    `(rlet ((,slrecord :scriptlanguagerecord))
       (let ((,err (require-trap #_geteventparameter ,event
                                 #.#$kEventParamTextInputSendSLRec
                                 #.#$typeIntlWritingCode
                                 (%null-ptr)
                                 #.(record-length :scriptlanguagerecord)
                                 (%null-ptr)
                                 ,slrecord)))
         (declare (fixnum ,err))
         (unless (eq #$noerr ,err)
           (error 'tsm-get-event-parameter-error
                  :error-code ,err
                  :parameter-name "#$kEventParamTextInputSendSLRec")))
       (pref ,slrecord :scriptlanguagerecord.fscript))))
|#

(defun %get-event-script (event)  
  (rlet ((slrecord :scriptlanguagerecord))
    (let ((err (#_geteventparameter event
                #$kEventParamTextInputSendSLRec
                #$typeIntlWritingCode
                (%null-ptr)
                (record-length :scriptlanguagerecord)
                (%null-ptr)
                slrecord)))
      (declare (fixnum err))
      (unless (eq #$noerr err)
        (error 'tsm-get-event-parameter-error
               :error-code err
               :parameter-name "#$kEventParamTextInputSendSLRec")))
    (pref slrecord :scriptlanguagerecord.fscript)))

;; do we need this?
#+ignore
(defmacro %get-event-mac-encoding (event)
  (let ((encoding (gensym))
        (err (gensym)))
    `(rlet ((,encoding :uint32))
       (let ((,err (require-trap #_GetEventParameter ,event
                                 #.#$kEventParamTextInputSendTextServiceMacEncoding
                                 #.#$typeUInt32
                                 (%null-ptr)
                                 #.(record-length :uint32)
                                 (%null-ptr)
                                 ,encoding)))
         (declare (fixnum ,err))
         (unless (eq #$noerr ,err)
           (error 'tsm-get-event-parameter-error
                  :error-code ,err
                  :parameter-name "#$kEventParamTextInputSendTextServiceMacEncoding"))
         (%get-unsigned-long ,encoding)))))

;; just return nil
#|
(defmacro %get-event-mac-encoding2 (event)
  (let ((encoding (gensym))
        (err (gensym)))
    `(rlet ((,encoding :uint32))
       (let ((,err (require-trap #_GetEventParameter ,event
                                 #.#$kEventParamTextInputSendTextServiceMacEncoding
                                 #.#$typeUInt32
                                 (%null-ptr)
                                 #.(record-length :uint32)
                                 (%null-ptr)
                                 ,encoding)))
         (declare (fixnum ,err))
         (when (ccl::%izerop ,err)
           (%get-unsigned-long ,encoding))))))
|#

#|
(defun %get-event-mac-encoding2 (event)  
  (rlet ((encoding :uint32))
    (let ((err (#_GetEventParameter event
                #$kEventParamTextInputSendTextServiceMacEncoding
                #$typeUInt32
                (%null-ptr)
                #.(record-length :uint32)
                (%null-ptr)
                encoding)))
      (declare (fixnum err))
      (when (eq err #$noerr)
        (%get-unsigned-long encoding)))))
|#

#|
(defmacro %get-event-component-instance (event)
  (let ((instance (gensym))
        (err (gensym)))
    `(rlet ((,instance :pointer))
       (let ((,err (require-trap #_GetEventParameter ,event
                                 #.#$kEventParamTextInputSendComponentInstance
                                 #.#$typeComponentInstance
                                 (%null-ptr)
                                 #.(record-length :ComponentInstance)
                                 (%null-ptr)
                                 ,instance)))
         (declare (fixnum ,err))
         (when (eq #$noerr ,err)
           (%get-ptr ,instance))))))
|#

#|
(defun %get-event-component-instance (event)  
  (rlet ((instance :pointer))
    (let ((err (#_GetEventParameter event
                #$kEventParamTextInputSendComponentInstance
                #$typeComponentInstance
                (%null-ptr)
                #.(record-length :ComponentInstance)
                (%null-ptr)
                instance)))
      (declare (fixnum err))
      (when (eq #$noerr err)
        (%get-ptr instance)))))
|#

;; not used today
#|
(defmacro %get-event-language (event)
  (let ((slrecord (gensym))
        (err (gensym)))
    `(rlet ((,slrecord :scriptlanguagerecord))
       (let ((,err (require-trap #_geteventparameter ,event
                                 #.#$kEventParamTextInputSendSLRec
                                 #.#$typeIntlWritingCode
                                 (%null-ptr)
                                 #.(record-length :scriptlanguagerecord)
                                 (%null-ptr)
                                 ,slrecord)))
         (declare (fixnum ,err))
         (unless (eq #$noerr ,err)
           (error 'tsm-get-event-parameter-error
                  :error-code ,err
                  :parameter-name "#$kEventParamTextInputSendSLRec")))
       (pref ,slrecord :scriptlanguagerecord.fLanguage))))
|#

#|
(defmacro %get-event-char (event)
  (let ((char (gensym)))
    `(rlet ((,char :unsigned-byte))
       (if (ccl::%izerop (require-trap #_geteventparameter ,event
                                       #.#$kEventParamTextInputSendText
                                       #.#$typechar
                                       (%null-ptr)
                                       1
                                       (%null-ptr)
                                       ,char))
         (%get-unsigned-byte ,char)
         nil))))
|#

#|  ;; unused today
(defun %get-event-char (event)
  (rlet ((char :unsigned-byte))
    (if (eq #$noerr (#_geteventparameter event
                     #$kEventParamTextInputSendText
                     #$typechar
                     (%null-ptr)
                     1
                     (%null-ptr)
                     char))
      (%get-unsigned-byte char)
      nil)))
|#


(defclass tsm-fred-item (tsm-document-mixin fred-item) ())  ;; also in new-fred-window.lisp

(defclass window-fred-item (tsm-fred-item)())  ;; also in new-fred-window.lisp - tsm-fred-item that lives in a fred-window




;;;window-fred-item vs. fred-item  ???  - so it can do similar magic as window-fred-item
;;; which has a fred-update-method that fixes modified-markers 
;;; set-mini-buffer - see below - not needed if window-fred-item
;;; ed-yank-file - which doesn't work and hasn't for a long time - fixed ed-yank-file

;; could also maybe add tsm-document-mixin to the class fred-dialog-item - done


;; why wait for gc to do this? - lets do it now
(defmethod remove-view-from-window :after ((item tsm-document-mixin))
  (without-interrupts
   (terminate item)
   (let ((key (slot-value item 'key)))
     (when key 
       (remhash key *tsm-documents-table*)
       (setf (slot-value item 'key) nil)))
   ;(cancel-terminate-when-unreachable item)
   )) 

#|
(progn
  (defmethod ed-other-window ((w fred-mixin))
    (setq w (view-window w))
    (if *modal-dialog-on-top*
      (ed-beep)
      (let ((other-window #'(lambda (window)
                              (unless (or (eq w window) 
                                          (typep window 'ccl:listener)
                                          (not (typep window 'ccl:fred-window)))
                                (window-select window)
                                (return-from ed-other-window window)))))
        (declare (dynamic-extent other-window))
        (map-windows other-window))))
  
  (comtab-set-key *control-x-comtab* '(:control #\l) 'ed-other-window)
  
  (comtab-set-key *comtab* '(:control #\H) 'ed-rubout-char)
  (comtab-set-key *comtab* '(:control #\m) 'ed-newline-and-indent)
  (comtab-set-key *comtab* '(:control #\i)
                      #'(lambda (fred-item)
                          (ed-insert-char fred-item #\tab))))
|#




;; need to specialize
;; tsm-doc-buffer-position
;; tsm-doc-buffer-delete
;; tsm-doc-buffer-insert
;; tsm-doc-show-cursor
;; tsm-doc-update
;; tsm-doc-draw-hilite
;; tsm-doc-set-inline-input-region
;; tsm-doc-clear

;;; 2005-11-28
;;; tsm-doc-draw-hilite problem
;;;
;;; When text is drawn into CGContext, hilite lines [which are drawn with QD]
;;; blinks.

;;;__________________________________________________________________________
;;;
;;; Having problem with korean direct input.
;;; used GDB to examine how TextEdit does its job:
;;;
;;; 2004-04-04
;;; ----------
;;; Examined TextEdit for its TSMDocument interfaces:
;;; 
;;;    keke:~$ gdb /Applications/TextEdit.app/Contents/MacOS/TextEdit
;;;    [...]
;;;    Reading symbols for shared libraries ... done
;;;    (gdb) fb NewTSMDocument
;;;    Function "NewTSMDocument" not defined.
;;;    Breakpoint 1 at 0x0
;;;    (gdb) r
;;;    Starting program: /Applications/TextEdit.app/Contents/MacOS/TextEdit
;;;    Reading symbols for shared libraries ................................ done
;;;    Re-enabling shared library breakpoints: 1
;;;    
;;;    Breakpoint 1, 0x928a1afc in NewTSMDocument ()
;;;    (gdb) x/i $r3
;;;    0x2:    Cannot access memory at address 0x2
;;;    (gdb) x/i *$r4
;;;    0x74737663:     Cannot access memory at address 0x74737663
;;;    (gdb) x/i *($r4 + 4)
;;;    0x75646f63:     Cannot access memory at address 0x75646f63
;;;    (gdb) c
;;;    Continuing.
;;;    
;;;    Program exited normally.
;;;    (gdb) 
;;; 
;;; - $3 is the first arg to #_NewTSMDocument :  numOfInterface
;;; 
;;;   * Got 0x2. so TSMDocument for TextEdit has two interfaces.
;;; 
;;; - $4 is the second arg to #_NewTSMDocument : supportedInterfaceTypes
;;; 
;;;   * The first interface is 0x74737663. --> :|tsvc| == #$kTextService
;;;   * The second interface is 0x75646f63. --> :|udoc| == #$kUnicodeDocument
;;;
;;; So, TextEdit has both #$kTextService and #$kUnicodeDocument
;;;
;;; Is that why Korean direct input works for TextEdit but not for
;;; unicode-document-mixin?
;;;
;;;
;;; 2004-04-06
;;; ----------
;;; Examined TextEdit again. This time watched GetEventParameter.
;;; Since it is called a lot, I used a condition:
;;; 
;;;     break GetEventParameter if $r4 == 0x74737478 
;;; 
;;; 0x74737478 is #$kEventParamTextInputSendText
;;; [note that "tbreak BlockMoveData" is also useful. It is used to
;;;  copy the text to GetEventParameter's buffer.]
;;; 
;;; The conclusion is that TextEdit is indeed getting precomposed hangul
;;; syllable in unicode. So I must be missing something.
;;; 
;;; [Note that GetEventParameter breaks each time it is called.
;;;  So if I type 'r' key in korean, go back to gdb and continue
;;;  from break, and type 'k' key, I get two independent characters
;;;  not precomposed syllable. To avoid this, just type 'r' and 'k'
;;;  quickly and go back to gdb]
;;;
;;;
;;; 2004-04-07
;;; ----------
;;;
;;; From: "Takehiko Abe" <keke@gol.com>
;;; To: "Carbon Dev" <carbon-development@lists.apple.com>
;;; Subject: Re: Korean direct input and TextInput event
;;; Date: Wed, 7 Apr 2004 17:51:03 +0900
;;; Message-Id: <20040407085103.27711@roaming.gol.com>
;;; 
;;; I wrote:
;;; 
;;; > On non-unicode TSM document, a korean input method generates
;;; > a pre-composed character for me. It does not on Unicode
;;; > TSMDocument when 'Direct Input' option is enabled.
;;; > [...]
;;; >
;;; > Is this expected?
;;; > 
;;; >  A. Yes it is. You have to construct korean precomposed
;;; >     chars (hangul syllables) by yourself.
;;; > 
;;; >  B. No it is not. You must be missing something.
;;; 
;;; I discovered that I get a precomposed char if I type two
;;; keys rapidly enough. I must be missing something.
;;; 
;;; I also found that I get the old behavior back if I don't reply
;;; kEventTextInputOffsetToPos with kEventParamTextInputReplyPoint.
;;; Strange. I put 'don't handle if korean' kludge. So it works
;;; now... but I don't feel right.
;;;
;;;__________________________________________________________________________

;;; kEventTSMDocumentAccessGetSelectedRange ??
;;; 



(defmethod tsm-doc-buffer-position ((doc tsm-document-mixin))
  (buffer-position (fred-buffer doc)))

(defmethod tsm-doc-buffer-delete ((doc tsm-document-mixin) start end)
  (block body
    ;; choosing kotoeri menu commands [control-1 & control-2]
    ;; results in out of bounds error. The handler ignores
    ;; this error.
    ;; --> this is not the case anymore. FIXIT
    ;; 2004-06-20
    ;; the bug is back! this time its simplified chinese
    (handler-bind ((error
                    #'(lambda (c)
                        #-tsm-debug (declare (ignore c))
                        #+tsm-debug
                        (format t "~%Error at tsm-doc-buffer-delete:~%~
                                   ~A" c)
                        (return-from body))))
      (buffer-delete (fred-buffer doc) start end))))

(defmethod tsm-doc-buffer-insert ((self tsm-document-mixin) string &optional position fixp)
  (buffer-insert (fred-buffer self) string position)
  (when fixp
    (ed-history-add self
                          (or position (buffer-position (fred-buffer self)))
                          string
                          (selection-p self))))

(defmethod tsm-doc-update ((doc tsm-document-mixin))
  (fred-update doc))

(defmethod tsm-doc-clear ((tsm-doc tsm-document-mixin))
  (clear-1 tsm-doc nil))

(defmethod tsm-doc-draw-hilite ((fred tsm-document-mixin) start end style)
  (declare (fixnum start end style))
  (let* ((frec (frec fred))
         (color 0)
         (ascents (fr.lineascents frec))
         (heights (fr.lineheights frec)))
    (declare (fixnum color))
    (case style
      ((#.#$kCaretPosition)
       ;; in Traditional Chinese, we receive #$kCaretPosition after the
       ;; text is confirmed. e.g. typing "han", #\space, #\return produces
       ;; and confirms the character HAN. Then, we get #$kCaretPosition
       ;; message to set caret to before the confirmed char.
       ;; --> made text-input-event-handler not to call tsm-doc-hilite if
       ;; inline-input-session is exited by confirmation.
       (set-selection-range fred start end)
       (fred-update fred)               ; required for cursor pos to update
       (return-from tsm-doc-draw-hilite))
      ((#.#$kRawText #.#$kSelectedRawText #.#$kConvertedText
        #.#$kSelectedConvertedText)
       (setq color (cdr (assoc style *hilite-color-alist*))))
      ;; getting 0 for style. what are they?
      (t (return-from tsm-doc-draw-hilite)))
    (multiple-value-bind (start start-line)
                         (%screen-point frec start (fr.wrap-p frec))
      (multiple-value-bind (end end-line)
                           (%screen-point frec end)
        (when (and start end)
          (with-focused-view fred
            (with-fore-color color
              (with-pen-saved-simple
                (#_pensize 1 2)
                (if (and (fr.wrap-p frec)
                         (not (eql start-line end-line)))
                  ;; FIXIT traverses all lines which is not necessary
                  (loop for line-len fixnum across (fr.linevec frec)
                        for line-num fixnum from 0
                        for adjust fixnum = (max (- (svref heights start-line)
                                                    (svref ascents start-line)
                                                    4)          ; was 2
                                                 0)
                        with char-pos fixnum = 0
                        do
                        (incf char-pos line-len)
                        (cond ((= line-num start-line)
                               (%%draw-hilite-line
                                  fred
                                  (1+ (point-h start)) (+ adjust (point-v start))
                                  (- (point-h (%screen-point frec char-pos)) 2)
                                  (+ adjust (point-v start))))
                              ((< start-line line-num end-line)
                               (let ((p (%screen-point frec char-pos)))
                                 (%%draw-hilite-line
                                  fred
                                  0 (+ adjust (point-v p))
                                  (- (point-h p) 2) (+ adjust (point-v p)))))
                              ((= line-num end-line)
                               (%%draw-hilite-line
                                fred
                                0 (+ adjust (point-v end))
                                (- (point-h end) 2) (+ adjust (point-v end))))))
                  (let ((adjust (max (- (svref heights start-line)
                                        (svref ascents start-line)
                                        4)      ; was 2
                                     0)))
                    (declare (fixnum adjust))
                    (%%draw-hilite-line 
                     fred 
                     (1+ (point-h start)) (+ adjust (point-v start))
                     (- (point-h end) 2) (+ adjust (point-v end)))
                    ))))))))))

(defun %%draw-hilite-line (doc start-h start-v end-h end-v)
  (declare (fixnum start-h start-v end-h end-v))
  (#_moveto start-h start-v)
  (#_lineto end-h end-v)
  (rlet ((r :rect :top start-v :left start-h
            :bottom (+ 2 end-v) :right (1+ end-h)))     ; 1+ adhoc
    (#_rectrgn ccl::*temp-rgn* r)
    (#_unionrgn (tsm-document-hilite-region doc)
     ccl::*temp-rgn*
     (tsm-document-hilite-region doc))))

#|
;; testing hilite line with cgcontext

(defun %%draw-hilite-line (doc start-h start-v end-h end-v)
  (declare (fixnum start-h start-v end-h end-v))
  (cg:with-cg-context (context doc)
    (cg:with-path context
      (rlet ((color :rgbcolor))
        (#_getforecolor color)
        (cg:set-stroke-color context (rgb-to-color color) 0.9s0))
      (#_cgcontextsetlinewidth context 2.0s0)
      (#_cgcontextmovetopoint context (cg:sfloat start-h) (cg:sfloat start-v))
      (#_cgcontextaddlinetopoint context (cg:sfloat end-h) (cg:sfloat end-v)))
    (#_cgcontextstrokepath context))
  (rlet ((r :rect :top start-v :left start-h
            :bottom (+ 2 end-v) :right (1+ end-h)))     ; 1+ adhoc
    (#_rectrgn ccl::*temp-rgn* r)
    (#_unionrgn (tsm-document-hilite-region doc)
     ccl::*temp-rgn*
     (tsm-document-hilite-region doc))))
|#

(defmethod tsm-doc-set-inline-input-region ((fred tsm-document-mixin) start end)
  (when (and start end)
    (let* ((region (tsm-document-inline-input-region fred))
           (frec (frec fred))
           (lineheights (fr.lineheights frec)))
      (when (null region)  ;; why??- maybe tsm-doc got removed from window then put back - that is fixed now
        (setq region (setf (tsm-document-inline-input-region fred) (#_newrgn))))
      (multiple-value-bind (s start-line)
                           (%screen-point frec start
                                               (fr.wrap-p frec))   ; 2003-01-21
        (multiple-value-bind (e end-line)
                             (%screen-point frec end)
          (if (and (fr.wrap-p frec)
                   ;; too ugly FIXIT
                   (or (and (null start-line) (null end-line))
                       (not (eql start-line end-line))))
            ;; this is very ugly. if line wrapping is enabled,
            ;; we need to walk down lines and adds to the region.
            ;; FIXIT
            (let ((sline (or start-line 0))
                  (eline (or end-line (1- (fr.numlines frec))))
                  (line-widths (fr.linewidths frec))
                  (s2 (or s 
                          (make-point 0 (linevec-ref lineheights 0))))
                  (vpos 0))
              (declare (fixnum sline eline vpos))
              (rlet ((rect :rect))
                ;; first line
                (setq vpos (point-v s2))
                (#_setrect rect
                 (point-h s2)
                 (- (point-v s2)
                    (linevec-ref lineheights sline))
                 ;FIXIT line-widths has got negative values
                 ; dont know what I'm doing.
                 (abs (linevec-ref line-widths sline))     ; eek FIXIT
                 vpos)
                #+ignore
                (format t "left: ~A top: ~A right: ~A :bottom ~A~%"
                        (point-h s2)
                        (- (point-v s2)
                           (linevec-ref lineheights sline))
                        (linevec-ref line-widths sline)
                        vpos)
                (#_rectrgn region rect)
                ;; lines inbetween
                (do ((line (1+ sline) (1+ line)))
                    ((>= line eline))
                  (declare (fixnum line))
                  (#_setrect rect
                   0
                   vpos
                   ;; FIXIT see above
                   (abs (linevec-ref line-widths line))
                   (incf vpos (linevec-ref lineheights line)))
                  (#_rectrgn *temp-rgn* rect)
                  (#_unionrgn region *temp-rgn* region))
                ;; last line
                (#_setrect :ptr rect
                 :word 0
                 :word vpos
                 :long (or e
                           (make-point 0 (+ (linevec-ref lineheights eline)
                                            vpos))))
                (#_rectrgn *temp-rgn* rect)
                (#_unionrgn region *temp-rgn* region)
                )
              #+ignore
              (with-focused-view fred   ; just to see if rgn is set right.
                (#_paintrgn region))
              (#_tsmsetinlineinputregion 
               (tsm-ptr fred)
               (wptr fred)
               region))
            (when (and s e)             ; no need to check anymore?
              (let ((height (max (linevec-ref lineheights start-line)
                                 (linevec-ref lineheights end-line))))
                (declare (fixnum height))
                (rlet ((rect :rect :top (- (point-v s) height) :left (point-h s)
                             :bottomright e))
                  (#_rectrgn region rect)
                  (#_tsmsetinlineinputregion 
                   (tsm-ptr fred)
                   ;; #_getwindowport does not work in this case.
                   ;; so when to use and when not???
                   (wptr fred)
                   region))))))))))

(defmethod tsm-doc-offset-to-point ((self tsm-document-mixin) offset)
  (declare (fixnum offset))
  ;; 2003-01-21 added screen-char-point? optional arg.
  ;; Without it, it returns the coordinate of the char at the
  ;; end of the previous line for the char at the beginning of a line
  ;; when line-wrap is on.
  ;; don't know if this is a correct use of the arg but it seems
  ;; to work. FIXIT
  (let* ((frec (frec self))
         (pt (%screen-point frec offset 
                                 (fr.wrap-p frec))))
    (if pt
      (convert-coordinates pt
                           self
                           (view-window self))
      ;; bogus value FIXIT
      (progn
        (print "warning: tsm-doc-offset-to-point errored")
        0))))

(defmethod tsm-doc-buffer-substring ((self tsm-document-mixin) end 
                                     &optional start string)
  (buffer-substring (fred-buffer self) end start string))


(defvar *symbol-font-id*)
(defvar *dingbats-font-id*)

(def-ccl-pointers dingbats ()
  (setq *symbol-font-id* (font-number-from-name-simple  "Symbol"))
  (setq *dingbats-font-id* (font-number-from-name-simple  "Zapf Dingbats")))

(defmethod text-input-event-handler ((tsm-doc tsm-document-mixin) event)
  (if (or (command-key-now-p)
          (and (eq #$smroman (get-key-script))
               (let ((font-id (ash (buffer-font-codes (fred-buffer tsm-doc)) -16)))
                 (or (eq font-id *symbol-font-id*) 
                     (eq font-id *dingbats-font-id*))))) ;; especially so that symbol font will work  - but what about character palette?        
    #$eventnothandlederr
    (handler-bind ((tsm-error
                    #'(lambda (c)
                        (declare (ignore c))
                        (%set-inline-input-offset tsm-doc nil)
                        (return-from text-input-event-handler 
                          #$eventnothandlederr))))      
      (%text-input-event-handler-2 tsm-doc event)))) 


(defun %text-input-to-raw-key-event (event)
  (rlet ((raw-event :pointer))
    (when (eq #$noerr (#_geteventparameter event
                       #$kEventParamTextInputSendKeyboardEvent
                       #$TypeEventRef
                       (%null-ptr)
                       4
                       (%null-ptr)
                       raw-event))
      (%get-ptr raw-event))))

(defloadvar *old-hilite-region* nil)
(defun %hilite-range-2 (tsm-doc event offset &aux (size 0) (err 0))
  (declare (fixnum offset size err))
  ;; initialize for new hilite region
  (unless *old-hilite-region*
    (setq *old-hilite-region* (#_newrgn)))
  (if (null (tsm-document-hilite-region tsm-doc))  ;; why ? happened with interface toolkit
    (setf (tsm-document-hilite-region tsm-doc) (#_newrgn)))
  (#_copyrgn (tsm-document-hilite-region tsm-doc) *old-hilite-region*)
  (#_setemptyrgn (tsm-document-hilite-region tsm-doc))
  (rlet ((range :textrangearray)
         (actual-size :unsigned-long))
    (setq err (#_geteventparameter event
               #$kEventParamTextInputSendHiliteRng
               #$typeTextRangeArray
               (%null-ptr)
               (record-length :textrangearray)
               actual-size
               range))
    (unless (eq err #$noerr)
      ;(format t "%hilite-range error: ~A~%" err)
      (return-from %hilite-range-2))
    (setq size (%get-unsigned-long actual-size)))
  (%stack-block ((range size))
    (#_geteventparameter
     event #$kEventParamTextInputSendHiliteRng
     #$typeTextRangeArray (%null-ptr) size (%null-ptr) range)
    (let ((count (pref range :textrangearray.fNumOfRanges)))
      (declare (fixnum count))
      (%setf-macptr range (pref range :textrangearray.frange))
      (dotimes (i count)
        (declare (fixnum i))
        (tsm-doc-draw-hilite tsm-doc
                             (+ offset (ash (pref range :textrange.fstart) -1))
                             (+ offset (ash (pref range :textrange.fend) -1))
                             (pref range :textrange.fhilitestyle))
        (%incf-ptr range (record-length :textrange)))))
  (#_DiffRgn *old-hilite-region*
   (tsm-document-hilite-region tsm-doc)
   *old-hilite-region*)
  (invalidate-region tsm-doc *old-hilite-region*))

(defun %adjust-pin-range-2 (tsm-doc event offset)
  (declare (fixnum offset))
  (rlet ((range :textrange))
    (let ((err (#_geteventparameter event 
                #$kEventParamTextInputSendPinRng
                #$typeTextRange
                (%null-ptr)
                (record-length :textrange)
                (%null-ptr)
                range)))
      (declare (fixnum err))
      (when (eq #$noerr err)
        (tsm-doc-show-cursor tsm-doc 
                             (+ offset (ash (pref range :textrange.fstart) -1))
                             (+ offset (ash (pref range :textrange.fend) -1)))))))

;;;
;;; %component-language and %korean-p
;;; These are no longer used.
;;;

#|
(ccl::defloadvar *components-table* '())

;; returns list of supported languages by component.
(defun %component-language (component)
  (unless (%null-ptr-p component)
    (let ((record (assoc component *components-table* :test #'eql)))
      (if record
        (cdr record)
        (let ((lang (%%component-language component)))
          (push (cons component lang) *components-table*)
          lang)))))

(ccl::defloadvar *script-language-support-handle*
  (#_newhandle
   (record-length :scriptlanguagesupport)))

(defun %%component-language (component)
  (rlet ((script-handle :pointer))
    (%put-ptr script-handle *script-language-support-handle*)
    (when (zerop (#_getscriptlanguagesupport component script-handle))
      (with-dereferenced-handles ((val (%get-ptr script-handle)))
        (let ((langs '())
              (array (%inc-ptr val 2)))
          (dotimes (i (pref val :scriptlanguagesupport.fscriptlanguagecount))
            (push (pref array :scriptlanguagerecord.flanguage) langs)
            (%incf-ptr array 4))
          langs)))))

(defun %korean-p (event)
  (let ((component (%get-event-component-instance event)))
    (when (and component
               (not (%null-ptr-p component)))
      (member #$langkorean (%component-language component)))))

;; the value of fscript does not make sense.
; (defun %supported-script-language (component)
;   (unless (%null-ptr-p component)
;     (rlet ((script-handle :pointer))
;       (%put-ptr script-handle *script-language-support-handle*)
;       (when (zerop (#_getscriptlanguagesupport component script-handle))
;         (with-dereferenced-handles ((val (%get-ptr script-handle)))
;           (let ((langs '())
;                 (array (%inc-ptr val 2)))
;             (dotimes (i (pref val :scriptlanguagesupport.fscriptlanguagecount))
;               (push (cons (pref array :scriptlanguagerecord.flanguage)
;                           (pref array :scriptlanguagerecord.fscript)) langs)
;               (%incf-ptr array 4))
;             langs))))))
|#

;; how do I make run-fred-command to work with textinput event?
;; * we don't want to run fred-command from inside the carbon event handler.
;; --> we need to return #$eventnothandlederr and let the ccl::do-keydown-event
;; to handle it. but it's getting unicode chars...?

;; 2005-12-07
;; any char > #x7F is handled by text-input-event handler before do-keydown-event
;; sees it.

;; from keke 
(defun %text-input-event-handler-2 (tsm-doc event &aux (event-script 
                                                        (ignore-errors (%get-event-script event))))
  ;; 2005-12-15
  ;; sometimes [but not always] event-script is not available [= nil] at the
  ;; beginning of japanese inline input session. As a result, japanese font is
  ;; not set [buffer-set-font-codes below is not called]. I've been wondering
  ;; why fred suddenly starts using hiragino instead of osaka font. This is
  ;; why.
  (unless event-script
    (rlet ((rec :scriptlanguagerecord))
      ;; doh #_gettextservicelanguage works more reliable than %get-event-script ?
      ;; it seems so.
      (when (eq #$noerr (#_gettextservicelanguage rec))
        (setq event-script (pref rec :scriptlanguagerecord.fscript)))))
  (macrolet ((%inside-input-session-p (doc)
               ;; %inline-input-offset == nil means that a new inline input
               ;; session has just begun. non-nil value means we're already
               ;; in the middle of it.
               `(%inline-input-offset ,doc)))
    ;; 2005-01-27 experimental
    ;; set the font to keyboard script here instead of at frec-idle
    ;; 2005-12-08 ignore it for now and see what ill effect it might cause:
    ;; * During japanese inline input session, both roman chars and jp chars
    ;;   are appears on screen. If the keyscript is in macroman at the beginning
    ;;   of the session and we do not set buffer font to japanese here, atsui
    ;;   keeps using a roman font for roman chars and falls back to a japanese
    ;;   font for jp chars. Since the heights of the fonts are likely to differ
    ;;   this produces a annoying effect where text moves up & down during
    ;;   the inline input session.
    ;;
    ;; * the above effect does not really occur because %redraw-screen-lines
    ;;   sets the font once atsui uses its fallback font.
    ;;
    #+ignore
    (unless (%inside-input-session-p tsm-doc)     ; nil => start of the inline-input session
      (when (and event-script
                 (not (= event-script #$smunicodescript)))
        (let* ((frec (frec tsm-doc))
               (buf (fred-buffer tsm-doc))
               (keyscript (ff-script (buffer-char-font-codes buf))))
          ;; 2005-12-16 fr.keyscript is not reliable.
          (when (not (eql event-script keyscript #+ignore (fr.keyscript frec)))
            (multiple-value-bind (ff ms)
                                 (buffer-find-font-in-script buf event-script)
              ; (print (font-spec ff ms))
              (buffer-set-font-codes buf ff ms))
            (setf (fr.keyscript frec) event-script)))))
    ;; keyboard->font matching still does not work well.
    ;; This time, we do not even bother to check buffer-char-font-codes.
    ;; This seems more reliable. Is this too expensive?
    ;; 2006-01-02 too expensive? no. but we need to learn why if indeed
    ;; this works better. i don't see any reason that this works better.
    (unless (%inside-input-session-p tsm-doc)        ; nil => start of the inline-input session
      (when (and event-script
                 (not (= event-script #$smunicodescript)))
        (let* ((frec (frec tsm-doc))
               (buf (fred-buffer tsm-doc))
               ff ms)          
          (multiple-value-setq (ff ms) (buffer-char-font-codes buf)) ;; fix so works in empty buffer - actually looks like buffer-find-font-in-script is broken
          (when (not (eq (ff-script ff) event-script))
            (multiple-value-setq (ff ms) (buffer-find-font-in-script buf event-script))
            (buffer-set-font-codes buf ff ms))
          (setf (fr.keyscript frec) event-script))))
    
    ;;2006-01-02 experimental
    ;; it may be possible to use key-layout to tell different scripts
    ;; among unicodescript [unicode script is a silly idea. There's no
    ;; such thing as unicode script.]
    #+ignore
    (when (= event-script #$smunicodescript)
      (print (kl::key-layout-name (ccl::current-key-layout))))
    
    (let ((err 0)
          (offset (or (%inline-input-offset tsm-doc)
                      (tsm-doc-buffer-position tsm-doc))))
      (declare (fixnum err offset))
        (case (#_geteventkind event)
        ((#.#$kEventTextInputUpdateActiveInputArea)
         ;; if there's a selection at the beginning of inline session,
         ;; save selection into slot and delete them.
         ; (format t "offset1 ~a~%" offset)
         (unless (%inside-input-session-p tsm-doc)
           (multiple-value-bind (s e)
                                (selection-range tsm-doc)
             (when (and s e (not (= s e)))
               (tsm-doc-clear tsm-doc)    ; adhoc
               (setf (selection-p tsm-doc) t)
               (setq offset s)))
           (%set-inline-input-offset tsm-doc offset)
           (pre-update-event-handler tsm-doc event))
         (multiple-value-bind (start end)
                              (%update-range-2 tsm-doc event offset)
           ; (format t "start ~a end ~a~%" start end)
           (%set-inline-input-offset tsm-doc start)
           (%adjust-pin-range-2 tsm-doc event offset)
           (tsm-doc-update tsm-doc)
           ;; inline-offset = nil means an inline input
           ;; session is terminated [all text is committed]. So no reason
           ;; to call %hilite-rage in that case. [we actually get #$kCaretPositionin
           ;; message in Chinese after a char is confirmed.]
           (when start
             (%hilite-range-2 tsm-doc event offset)
             (tsm-doc-set-inline-input-region tsm-doc start end))
           (unless start
             (invalidate-region tsm-doc (tsm-document-hilite-region tsm-doc))
             (#_setemptyrgn (tsm-document-hilite-region tsm-doc))
             (setf (selection-p tsm-doc) nil)))
         #$noerr)
        ((#.#$kEventTextInputUnicodeForKeyEvent)
         ;; 2005-02-04
         (when (and event-script (= event-script #$smroman))
           ;; 2005-02-13
           ;; More Kludge:
           ;; If event-script is macroman, then we want to exit from
           ;; this carbon event handler and let the do-keydown-event
           ;; to handle the event [because otherwise some fred-commands
           ;; are not run].
           ;;
           ;; However, simply exiting when smRoman disables Character
           ;; Palette input for some chars [e.g. combining marks].
           ;;
           ;; So we need to check the raw keyevent and see if MacChar is
           ;; available in the event. If it is NOT available, then we need
           ;; to handle the event in here because do-keydown-event will
           ;; not receive the non-MacChar character.
           ;;
           ;; I expected GetEventParameter returns error if Macchar is
           ;; not available but it is not so. It returns #$noerr but
           ;; the size is 0.
           ;; 
           (let ((raw (%text-input-to-raw-key-event event)))
             (when raw
               (rlet ((size :unsigned-long))
                 (let ((err (#_geteventparameter raw
                             #$kEventParamKeyMacCharCodes
                             #$typechar
                             (%null-ptr)
                             0
                             size
                             (%null-ptr))))
                   (declare (fixnum err))
                   ;; what if we get the error here? FIXIT
                   (when (and (eq err #$noerr)
                              (not (eq 0 (%get-unsigned-long size))))
                     ;; 2006-05-03 test modifers. otherwise zapf dingbats from character palette wont work
                     (rlet ((mods :uint32))
                       (when (and (eq #$noerr (#_geteventparameter raw
                                               #$kEventParamKeyModifiers
                                               #$typeuint32
                                               (%null-ptr)
                                               4
                                               size
                                               mods))
                                  (not (eq 0 (%get-unsigned-long size)))
                                  (not (eq 0 (logand (%get-unsigned-long mods)
                                                     (logior #$cmdKey #$optionkey #$shiftkey #$rightshiftkey
                                                             #$controlKey #$rightControlKey)))))
                         (return-from %text-input-event-handler-2 #$eventnothandlederr)))))))))
         (let* ((result #$eventNotHandledErr)
                (size (%get-text-length event t))
                (len (ash size -1)))
           (declare (fixnum size len))
           (%stack-block ((buf size))
             (when (eq #$noerr (#_geteventparameter event
                                  #$kEventParamTextInputSendText
                                  #$typeUnicodeText
                                  (%null-ptr)
                                  size
                                  (%null-ptr)
                                  buf))
               (if (> len 1)
                 ;; text input event can send more than one 'char's when
                 ;; the char-code > #xFFFF -- ie surrogate pairs.
                 (let ((text (make-string len :element-type 'extended-character)))
                   (dotimes (i len)
                     (setf (char text i) (code-char (%get-unsigned-word buf (* i 2)))))
                   (buffer-insert (fred-buffer tsm-doc) text)
                   (fred-update tsm-doc)
                   (setq result #$noerr))
                 (let ((charcode (%get-unsigned-word buf)))
                   (declare (fixnum charcode))
                   ;; 2005-12-07 #x7f was #x7e. #x7e was a simple mistake i hope.
                   (if (> charcode #x7f)
                     ;; we have non ascii char, so handle it here.
                     (progn
                       (buffer-insert (fred-buffer tsm-doc) (code-char charcode))
                       ;; 2005-12-07 17:55:21 dubious FIXIT
                       ;; disabled it for now
                       ;; 2005-12-13 enabled.
                       (window-show-cursor tsm-doc)
                       (fred-update tsm-doc)
                       (setq result #$noerr))
                     ;; We have ascii char. Return not-handled-err so that ccl::do-event
                     ;; will see it. [menu-commands won't work if do-event doesn't see it.]
                     ;; But if the char is #\delete and the script is Korean,
                     ;; treat it specially. see tsm-carbon.lisp for detail.
                     (if (and event-script
                              (= #$smKorean event-script)
                              (= charcode (char-code #\delete))
                              (event-available-p-kind #$kEventClassKeyBoard 
                                                 #$kEventRawKeyDown))
                       (progn
                         (tsm-doc-buffer-delete tsm-doc (1- offset) offset)
                         (setq result #$noerr))
                       (setq result #$eventnothandlederr)))))))
           result))
        ((#.#$kEventTextInputOffsetToPos)
         (let ((result #$eventnothandlederr))
           (declare (fixnum result))
           (rlet ((offset-ptr :sint32)
                  (point :point))
             (setq err (#_GetEventParameter event
                        #$kEventParamTextInputSendTextOffset
                        #$typeLongInteger
                        (%null-ptr)
                        4
                        (%null-ptr)
                        offset-ptr))
             (unless (eq #$noerr err)
               (error 'tsm-get-event-parameter-error
                      :error-code err
                      :parameter-name "#$kEventParamTextInputSendTextOffset"))
             (let ((p-offset (%get-signed-long offset-ptr)))
               (declare (fixnum p-offset))
               (when (or (not (zerop p-offset))
                         ;; 2005-01-30
                         ;; this horrible kludge seems no longer necessary.
                         ; (not (%korean-p event))
                         (%inside-input-session-p tsm-doc))
                 (%put-long point
                            (%local-to-global 
                             (wptr tsm-doc)
                             (tsm-doc-offset-to-point 
                              tsm-doc
                              (+ p-offset offset))))
                 (#_SetEventParameter event #$kEventParamTextInputReplyPoint
                  #$typeQDPoint
                  (record-length :point)
                  point)
                 (setq result #$noerr))))
           result
           #$noerr                        ; huh? FIXIT
           ))
        ((#.#$kEventTextInputPosToOffset)
         ;; ad hoc only works for FRED. <-- too late no going back.
         (rlet ((point :point))
           (setq err (#_GetEventParameter event 
                      #$kEventParamTextInputSendCurrentPoint
                      #$typeQDPoint
                      (%null-ptr)
                      (record-length :point)
                      (%null-ptr)
                      point))
           (unless (eq err #$noerr)
             (error 'tsm-get-event-parameter-error
                    :error-code err
                    :parameter-name "#$kEventParamTextInputSendCurrentPoint"))
           (let ((pos (frec-point-pos (frec tsm-doc)
                                            (%global-to-local (wptr tsm-doc) 
                                                                   (%get-long point)))))
             (if pos
               (rlet ((offset-ptr :sint32)
                      (region-class :short #$kTSMInsideOfActiveInputArea))    ; its short
                 (%put-long offset-ptr (- pos offset))
                 (#_SetEventParameter event #$kEventParamTextInputReplyTextOffset
                  #$typeLongInteger
                  4
                  offset-ptr)
                 ;; http://people.netscape.com/ftang/paper/unicode22/mac_intl.ppt
                 ;; says the comment in CarbonEvent.h which says RegionClass is
                 ;; typelongInteger is wrong. and InsideMac TextServicesManager's
                 ;; :short is correct.
                 (#_SetEventParameter event #$kEventParamTextInputReplyRegionClass
                  #$typeShortInteger 2 region-class)
                 #$noerr)
               #$eventnothandlederr))))
        #+ignore
        ((#.#$kEventTextInputShowHideBottomWindow)
         (rlet ((bool :byte 0))
           (#_seteventparameter event
            #$kEventParamTextInputReplyShowHide
            #$typeBoolean
            1
            bool))
         (rlet ((bool :byte))
           (if (and (eq #$noerr (#_geteventparameter event
                                 #$kEventParamTextInputSendShowHide
                                 #$typeBoolean
                                 (%null-ptr)
                                 1
                                 (%null-ptr)
                                 bool))
                    (eq 0 (%get-byte bool)))
             #$noerr
             #$eventnothandlederr))
         #$eventnothandlederr )
        ((#.#$kEventTextInputGetSelectedText)
         (let ((selection
                (multiple-value-bind (s e)
                                     (selection-range tsm-doc)
                  (when (and s e (not (= s e)))
                    (tsm-doc-buffer-substring tsm-doc e s)))))
           (declare (dynamic-extent selection))
           (if selection
             #+ignore  ;; looks wrong to me??
             (with-cstrs ((text-ptr selection))
               (#_SetEventParameter event #$kEventParamTextInputReplyText
                #$typeUnicodeText
                (byte-length selection)   ; byte-length not length
                text-ptr)
               (setf (getselectedtext-called-p tsm-doc) t)
               #$noerr)
             #-ignore
             (let ((len (length selection)))  ;; how do we get here to test?
               (%stack-block ((ubuf (%i+ len len)))
                 (copy-string-to-ptr selection 0 len ubuf)
                 (#_SetEventParameter event #$kEventParamTextInputReplyText
                  #$typeUnicodeText
                  (%i+ len len)   ; byte-length not length
                  ubuf)
                 (setf (getselectedtext-called-p tsm-doc) t)
                 #$noerr))
             #$eventnothandlederr)))
        (t #$eventnothandlederr)))))



;; typeTextRangeArray
;; %hilite-range
;; %get-update-ranges
;; 

(defun %ustring-from-ptr (ptr length)
  (declare (fixnum length)
           (optimize (speed 3) (safety 0)))
  (let ((new-string (make-string length :element-type 'extended-character)))
    (%copy-ptr-to-ivector ptr 0 new-string 0 (* length 2))
    new-string))

(defun %update-range-2 (tsm-doc event offset)
  (declare (fixnum offset))
  (let* ((fixlen (ash (%get-fix-length event) -1))
         (text-bytes (%get-text-length event t))
         (text-length (ash text-bytes -1)))
    (declare (fixnum fixlen text-bytes text-length))
    ; (format t "fixlen: ~d~%" fixlen)
    (%stack-block ((text text-bytes))
      (unless (eq 0 text-length)
        ;; when text-length = 0, GetEventParameter returns -50 [#$paramErr].
        (let ((err (#_geteventparameter event
                    #$kEventParamTextInputSendText
                    #$typeunicodetext
                    (%null-ptr)
                    text-bytes
                    (%null-ptr)
                    text)))
          (declare (fixnum err))
          (unless (eq err #$noerr)
            (error 'tsm-get-event-parameter-error
                   :error-code err
                   :parameter-name "#$kEventParamTextInputSendText"))))
      (if (%izerop fixlen)
        (multiple-value-bind (update-range1 update-range2)
                             (%get-update-ranges event t)
          (unless (getselectedtext-called-p tsm-doc)
            (tsm-doc-buffer-delete tsm-doc
                                   (+ (ash (point-h update-range1) -1) offset)
                                   (+ (ash (point-v update-range1) -1) offset)))
          ;; is this the right place? FIXIT
          (setf (getselectedtext-called-p tsm-doc) nil)
          (if (eq 0 text-length)
            ;; no text left means session is terminated.
            ;; this can happen when a user deleted all the uncommited text.
            nil
            (progn
              ; (print (%ustring-from-ptr text text-length))
              ; (format t "text-length ~d~%"  text-length)
              ; (format t "#@(~d ~d)~%" (point-h update-range2) (point-v update-range2))
              ; (print (%ustring-from-ptr text text-length))
              ;; 2005-12-13
              ;; added window-show-cursor
              ;; without-interrupts keeps hilite line intact.
              (without-interrupts
               (tsm-doc-buffer-insert
                tsm-doc
                (subseq (%ustring-from-ptr text text-length)
                        (ash (point-h update-range2) -1)
                        (ash (point-v update-range2) -1))
                (+ (ash (point-h update-range1) -1) offset))
               (window-show-cursor tsm-doc))
              (values offset 
                      (+ offset text-length)))))
        ;; From carbondev:
        ;; Input methods indicate that they are confirming an inline session in
        ;; two different ways. the first is to set fixedLength to -1.  The second
        ;; is to make fixedLength equal to the totalLength of the text returned
        ;; in the EventRef.
        (if (or (= fixlen -1) (= text-length fixlen))
          (progn
            ;(print-update-event event)
            ;; delete all uncommited text and insert new one
            (tsm-doc-buffer-delete tsm-doc offset (tsm-doc-buffer-position tsm-doc))
            (tsm-doc-buffer-insert tsm-doc
                                   (%ustring-from-ptr text text-length)
                                   offset
                                   t)
            ;; end of an inline input session
            nil)
          ;; seems we never reach here with CJK input methods installed default
          ;; in OSX 10.2.3,
          (multiple-value-bind (update-range1 update-range2)
                               (%get-update-ranges event t)
            (print "never seen it before!")     ; FIXIT
            (tsm-doc-buffer-delete tsm-doc
                                   (+ (ash (point-h update-range1) -1) offset)
                                   (+ (ash (point-v update-range1) -1) offset))
            (let ((string (%ustring-from-ptr text fixlen)))
              (tsm-doc-buffer-insert tsm-doc string offset t)
              (let ((offset (+ offset (length string))))
                (declare (fixnum offset))
                (tsm-doc-buffer-insert tsm-doc
                                       (%ustring-from-ptr
                                        (%inc-ptr text (ash (point-h update-range2) -1))
                                        (- (ash (point-v update-range2) -1)
                                           (ash (point-h update-range2) -1)))
                                       offset)
                (values offset
                        (+ offset (- text-length fixlen)))))))))))


;;;
;;;__________________________________________________________________________
;;;
;;;  File:	tsm-carbon.lisp
;;;  Date:	2003-07-15
;;;  version:	1.1.1
;;;  Author:	Takehiko Abe <keke@gol.com>
;;;
;;;  Copyright (c) 2002-2004 Takehiko Abe
;;;__________________________________________________________________________

;;; History
;;; 2004-04-11  removed tsm-doc-selection-range. just use ccl:selection-range
;;; 2004-03-30  modifying to incorporate unicode support
;;;             - added optional unicode-p arg to %get-text-length
;;; 2003-07-15  trying to cope with 'Character Palette' as much as possible.
;;;             see %text-input-event-handler
;;; 2003-07-11  v1.1
;;; 2003-06-13	v1.0 initial public release
;;; 2002-11-27  v0.9
;;;


;;;
;;; TODO
;;; * Dispose event handlers! <-- No need. I'm caching it already.
;;;
;;; * in wrapping mode, we need to handle set-view-size event.
;;;   --> why anyone wants to change view-size?? just call FixTSMDocument.
;;;       that's enough.
;;;
;;; * Replace ccl::defglobal with something sensible.
;;;

;;;
;;; Bugs
;;;
;;; * word-wrapping mode still has problems.
;;;
;;; * %adjust-pin-range do not work well.
;;;   [ tsm-doc-show-cursor ]
;;;
;;; * flaky in classic carbon.
;;;
;;; * Korean hanja input suddenly stopped working in my system. why
;;;   
;;;

;;; Workarounds:
;;;
;;; * #$kEventTextInputGetSelectedText
;;;
;;;   Kotoeri (japanese Input method) uses this event to initiate the
;;;   following operations to a selected text.
;;;
;;;   It does:
;;;   1. Convert Kanji chars back to Hiragana chars.
;;;   2. Convert Kanji chars to a new Kanji char which
;;;      a. has common parts as the original Kanji char
;;;      b. is related to the original Knaji char
;;;
;;;   When we receive this event, we send selected chars to Kotoeri.
;;;   Then Kotoeri signals usual #$kEventTextInputUpdateActiveInputArea
;;;   event.
;;;   
;;;   However, Kotoeri seems to set update-range for old text to a wrong
;;;   value in case of the operation 2.
;;;
;;;   With the operation 1, Kotoeri sends 0-0 for update-range for
;;;   old-text, which means we do not touch old text and leave it as is.
;;;   This is sensible because we want to clear the selection right after
;;;   an inline input session begins anyway.
;;;
;;;   With the operation 2, Kotoeri sends non-zero update-range for old text.
;;;   If the selection is 2bytes long, it sends range of 0-4. When it is 4
;;;   bytes long, it sends 0-8. This means that we will get into trouble
;;;   even if we don't clear the text beforehand.
;;;
;;;   To work around this Kotoeri bug, I added the getselectedtext-called-p
;;;   slot tsm-document-mixin. The slot is set to T when we get
;;;   #$kEventTextInputGetSelectedText to notify %update-range that
;;;   it must ignore update-range for old text [and do not delete any text.]
;;;
;;; * When 'Input by a Character' mode is enabled, Korean input method posts
;;;   #\Delete keyevent to client in the middle of inline-input session to
;;;   replace the old char.
;;;
;;;   If we allow the #\delete keyevent falling through to the normal
;;;   view-key-event-handler, we get the unwanted screen redraw.
;;;
;;;   To handle the keyevent, we need to distinguish user generated
;;;   keyevent and the input method generated keyevent.
;;;
;;;   --> Check the event queue if there is a next event carrying the
;;;       new character to replace the old. And if there is, we assume
;;;       the #\delete keyevent is generated by the input method and
;;;       handle it in text-input-event-handler without updating the
;;;       screen.
;;;
;;;       * I used the #_ReceiveNextEvent with timeout to check the existence
;;;         of the pending event.
;;;       * (#_GetNumEventsInQueue (#_GetCurrentEventQueue)) could be used
;;;         but it does not tell the difference between the keyevent entered
;;;         through the soft keyboard palette.
;;;   --> further investigation revealed that the pending event does not
;;;       'carry the new char to replace the old'. It contains another #\delete
;;;       key. 
;;;
;;;       * When checked directly from a handler for #$kEventClassKeyboard,
;;;         the event is the normal #$kEventRawKeydown indicating #\delete char.
;;;         When checked indirectly with #_ReceiveNextEvent from a
;;;         #$kEventTextInputUnicodeForKeyEvent, the same rawkey event carries
;;;         keycode of 51 [which is #\delete] but it has 0 for MacCharcode
;;;         [means #\Null]. This pending #\null and #\delete hybrid keyevent
;;;         never arrives as the #$kEventTextInputUnicodeForKeyEvent though.
;;;         It vanishes somewhere inside the event handling chain.
;;;
;;;       * Maybe I should check MacCharcode being 0 [#\null] to identify the
;;;         fake #\delete char rather than simply check with #_ReceiveNextEvent.
;;;


#|

No documentation for #$kEventTextInputGetSelectedText and
#$kEventTextInputPosToOffset.

* #$kEventTextInputGetSelectedText

  I found #$kGetSelectedText in AERegistry.lisp but there's no
  info for this too. Finally in WASTE 1.3 source, I found
  kGetText [which is not in interfaces anymore.].

  #$kEventParamTextInputReplyText

* #$kEventTextInputPosToOffset

  There is #$kPos2Offset in AERegistry.lisp. And InsideMac for
  Text Services Manager has documentation for it.

;; Note 2003-08-25

#$kEventTextInputGetSelectedText is mentioned in TN2079
<http://developer.apple.com/technotes/tn2002/tn2079.html>



|#



;;;
;;; text-input-event-handler
;;;

#|
(define-condition tsm-error (error) ())

(define-condition tsm-get-event-parameter-error (tsm-error)
                  ((error-code :initarg :error-code
                               :reader tsm-error-code)
                   (parameter-name :initarg :parameter-name
                                   :reader tsm-error-parameter-name))
  (:report (lambda (condition stream)
             (format stream "GetEventParameter for ~A failed [~A]."
                     (tsm-error-parameter-name condition)
                     (tsm-error-code condition)))))
|#


#|
(defmethod text-input-event-handler ((tsm-doc tsm-document-mixin) event)
  (handler-bind ((tsm-error
                  #'(lambda (c)
                      #-tsm-debug (declare (ignore c))
                      #+tsm-debug (princ c)
                      (%set-inline-input-offset tsm-doc nil)
                      (return-from text-input-event-handler 
                                   #$eventnothandlederr))))
    (%text-input-event-handler tsm-doc event)))
|#



#|
(defmethod tsm-doc-set-script-for-insert ((tsm-doc tsm-document-mixin) script)
  (declare (ignore script)))
|#


; (defun event-available-p (class kind)
;   (rlet ((spec :eventtypespec
;                :eventClass class
;                :eventKind kind)
;          (event :eventref))
;     (when (ccl::%izerop (#_receivenextevent
;                          1
;                          spec
;                          #$kEventDurationNoWait ; #$kEventDurationMillisecond
;                          nil
;                          event))
;       (rlet (; (char :unsigned-byte)
;              (key :uint32)
;              (mod :uint32)
;              )
;         (if (zerop (#_geteventparameter (%get-ptr event)
;                     #$kEventParamKeyCode        ; #$kEventParamKeyMacCharCodes
;                     #$typeUInt32        ; #$typeChar
;                     (%null-ptr)
;                     4                   ; 1
;                     (%null-ptr)
;                     key))
;           (format t "char=~A~%" (%get-unsigned-long key))
;           (print :ahoi))
;         (if (zerop (#_geteventparameter (%get-ptr event)
;                     #$kEventParamKeyModifiers        ; #$kEventParamKeyMacCharCodes
;                     #$typeUInt32        ; #$typeChar
;                     (%null-ptr)
;                     4                   ; 1
;                     (%null-ptr)
;                     mod))
;           (format t "mod=~A~%" (%get-unsigned-long mod))
;           (print :ahoi2)))
;       t)))


(defun event-available-p-kind (class kind)
  (rlet ((spec :eventtypespec
               :eventClass class
               :eventKind kind)
         (event :eventref))
    (eq #$noerr (#_receivenextevent
                   1
                   spec
                   #$kEventDurationNoWait ; #$kEventDurationMillisecond
                   nil
                   event))))


;; for debugging
(defun peek-event (&optional (wait #$kEventDurationMillisecond))
  (rlet ((event :eventref)
         (class :unsigned-long))
    (when (zerop (#_receivenextevent
                  0
                  (%null-ptr)
                  wait
                  nil
                  event))
      (%put-long class (#_geteventclass (%get-ptr event)))
      (list (%get-ostype class)
            (#_geteventkind (%get-ptr event))))))




(defun %get-text-length (event &optional unicode-p)  
  (rlet ((size :unsigned-long))
    (let ((err (#_geteventparameter event
                #$kEventParamTextInputSendText
                (if unicode-p #$typeUnicodeText #$typechar)
                (%null-ptr)
                0
                size
                (%null-ptr))))
      (declare (fixnum err))
      (if (eq err #$noerr)
        (%get-unsigned-long size)
        (error 'tsm-get-event-parameter-error
               :error-code err
               :parameter-name "#$kEventParamTextInputSendText")))))



(defun %get-fix-length (event)  
  (rlet ((fixlen :sint32))
    (let ((err (#_geteventparameter event
                #$kEventParamTextInputSendFixLen
                #$typelonginteger
                (%null-ptr)
                4
                (%null-ptr)
                fixlen)))
      (declare (fixnum err))
      (if (eq err #$noerr)
        (%get-signed-long fixlen)
        (error 'tsm-get-event-parameter-error
               :error-code err
               :parameter-name "#$kEventParamTextInputSendFixLen.")))))

;;; %update-range manupilates inline text. Returns
;;; a new start and end position of inline text.
;;; Returns nil when all inline text is confirmed
;;; no text is left inline.




;; for debugging
(defun print-update-event (event)
  (multiple-value-bind (r1 r2)
                       (%get-update-ranges event)
    (format t "fixlen: ~A~%~
               textlen: ~A~%~
               range1: #@(~A ~A)~%~
               range2: #@(~A ~A)~%"
            (%get-fix-length event)
            (%get-text-length event)
            (point-h r1) (point-v r1)
            (point-h r2) (point-v r2))))

(defloadvar *old-hilite-region* nil)

;; not called today
#+ignore
(defun %hilite-range (tsm-doc event offset &aux (size 0) (err 0))
  (declare (fixnum offset size err))
  ;; initialize for new hilite region
  (unless *old-hilite-region*
    (setq *old-hilite-region* (#_newrgn)))
  (#_copyrgn (tsm-document-hilite-region tsm-doc) *old-hilite-region*)
  (#_setemptyrgn (tsm-document-hilite-region tsm-doc))
  (rlet ((range :textrangearray)
         (actual-size :unsigned-long))
    (setq err (#_geteventparameter event
               #$kEventParamTextInputSendHiliteRng
               #$typeTextRangeArray
               (%null-ptr)
               (record-length :textrangearray)
               actual-size
               range))
    (unless (eq err #$noerr)
      ;(format t "%hilite-range error: ~A~%" err)
      (return-from %hilite-range))
    (setq size (%get-unsigned-long actual-size)))
  (%stack-block ((range size))
    (#_geteventparameter
     event #$kEventParamTextInputSendHiliteRng
     #$typeTextRangeArray (%null-ptr) size (%null-ptr) range)
    (let ((count (pref range :textrangearray.fNumOfRanges)))
      (declare (fixnum count))
      (%setf-macptr range (pref range :textrangearray.frange))
      (dotimes (i count)
        (declare (fixnum i))
        (tsm-doc-draw-hilite tsm-doc
                             (+ offset (pref range :textrange.fstart))
                             (+ offset (pref range :textrange.fend))
                             (pref range :textrange.fhilitestyle))
        (%incf-ptr range (record-length :textrange)))))
  (#_DiffRgn *old-hilite-region*
   (tsm-document-hilite-region tsm-doc)
   *old-hilite-region*)
  (invalidate-region tsm-doc *old-hilite-region*))


;; not called today
#+ignore
(defun %adjust-pin-range (tsm-doc event offset)
  (declare (fixnum offset))
  (rlet ((range :textrange))
    (let ((err (#_geteventparameter event 
                #$kEventParamTextInputSendPinRng
                #$typeTextRange
                (%null-ptr)
                #.(record-length :textrange)
                (%null-ptr)
                range)))
      (declare (fixnum err))
      (when (eq err #$noerr)
        (tsm-doc-show-cursor tsm-doc 
                             (+ offset (pref range :textrange.fstart))
                             (+ offset (pref range :textrange.fend)))))))


;;;
;;; New version.
;;;
;;; Optimized based on the assumptions that are:
;;; 1. textrangearray contains only 2 textranges.
;;;    [ :textrangearray.fNumOfRanges == 2]
;;; 2. the size of textrangearray for updaterange is always 22.
;;;    [22 = :textrangearray.fNumOfRanges [2byte] + fRange [10byte] X 2]
;;;
;;; Notes:
;;; TextRangeArray[0] contains range of old text to be udpated.
;;; TextRangeArray[1] contains range of new text to replace the portion
;;; of old text specified in the array[0].
;;;
;;; I thought TextRangeArray may contain more than 2 ranges but that
;;; does not seem to be the case. Otoh TextRangeArray for
;;; #$kEventParamTextInputSendHiliteRng contains more than 2 ranges.
;;; 

#|
(defun %get-update-ranges (event)
  (%stack-block ((range-array 22))
    (let ((err (#_geteventparameter event
                #$kEventParamTextInputSendUpdateRng
                #$typeTextRangeArray
                (%null-ptr)
                22
                (%null-ptr)
                range-array)))
      (declare (fixnum err))
      ;; assuming the size of :TextRangeArray is always 2. Is this OK? FIXIT
      ;; range-array[0] specifies a range of old text to be updated.
      (if (eq #$noerr err)
        (progn (%setf-macptr range-array (pref range-array :textrangearray.frange))
               (let ((s1 (pref range-array :textrange.fstart))
                     (e1 (pref range-array :textrange.fend)))
                 (declare (fixnum s1 e1))
                 ;; range-array[1] specifies a range of new text to replace the old text.
                 (%incf-ptr range-array #.(record-length :textrange))
                 (values (make-point s1 e1)
                         (make-point (pref range-array :textrange.fstart)
                                     (pref range-array :textrange.fend)))))
        (if (= err #$eventParameterNotFoundErr)
          ;; ADHOC this is bogus but getting this result when non-trad Chinese.
          (values 0 0)
          (error 'tsm-get-event-parameter-error
                 :error-code err
                 :parameter-name "#$kEventParamTextInputSendUpdateRng"))))))
|#

(defun %get-update-ranges (event &optional unicode-p)
  (declare (ignore unicode-p))
  (%stack-block ((range-array 22))
    (let ((err (#_geteventparameter event
                #$kEventParamTextInputSendUpdateRng
                #$typeTextRangeArray
                (%null-ptr)
                22
                (%null-ptr)
                range-array)))
      (declare (fixnum err))
      ;; assuming the size of :TextRangeArray is always 2. Is this OK? FIXIT
      ;; range-array[0] specifies a range of old text to be updated.
      (if (eq #$noerr err)
        (progn (%setf-macptr range-array (pref range-array :textrangearray.frange))
               (let ((s1 (pref range-array :textrange.fstart))
                     (e1 (pref range-array :textrange.fend)))
                 (declare (fixnum s1 e1))
                 ;; range-array[1] specifies a range of new text to replace the old text.
                 (%incf-ptr range-array (record-length :textrange))
                 (values (make-point s1 e1)
                         (make-point (pref range-array :textrange.fstart)
                                     (pref range-array :textrange.fend)))))
        (if (= err #$eventParameterNotFoundErr)
          ;; ADHOC this is bogus but getting this result when non-trad Chinese.
          (values 0 0)
          (error 'tsm-get-event-parameter-error
                 :error-code err
                 :parameter-name "#$kEventParamTextInputSendUpdateRng"))))))


;;;
;;; Generic functions
;;;

(defgeneric pre-update-event-handler (tsm-doc event)
  (:documentation
   "called once at the beginning of a new update-event."))

(defmethod pre-update-event-handler ((tsm-doc tsm-document-mixin) event)
  (declare (ignore event))
  nil)

(defgeneric tsm-doc-buffer-position (tsm-doc))


;; need this
(defmethod tsm-doc-show-cursor ((self tsm-document-mixin) start end)
  (declare (ignore start end)))

(defgeneric tsm-doc-clear (tsm-doc)
  (:documentation
   "clears selection.
[Ad-hoc. only used once in %text-input-event-handler-2]
"))



;;;;;;; from Takehiko Abe bidi.lisp

#|
 ;; codepoints < #x3400
(defparameter *bidi-table-01*  #(:BN :BN :BN :BN :BN :BN :BN :BN :BN :S :B :S :WS :B :BN :BN :BN :BN :BN :BN :BN :BN 
                                     :BN :BN :BN :BN :BN :BN :B :B :B :S :WS :ON :ON :ET :ET :ET :ON :ON :ON :ON :ON 
                                     :ET :CS :ET :CS :ES :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :CS :ON :ON :ON :ON 
                                     :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L 
                                     :L :L :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L 
                                     :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :BN :BN :BN :BN :BN :BN :B :BN :BN :BN
                                     :BN :BN :BN :BN :BN :BN :BN :BN :BN :BN :BN :BN :BN :BN :BN :BN :BN :BN :BN :BN 
                                     :BN :BN :BN :CS :ON :ET :ET :ET :ET :ON :ON :ON :ON :L :ON :ON :ON :ON :ON :ET :ET
                                     :EN :EN :ON :L :ON :ON :ON :EN :L :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L 
                                     :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :L :L :L :L :L :L :L :L :L :L :L :L
                                     :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :L :L :L :L :L :L :L
                                     :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L 
                                     :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L 
                                     :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L 
                                     :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L 
                                     :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L 
                                     :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :L :L :L :L :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :L :L :L :ON :ON :L :L :L :L :L :L :L :L :ON :L :L :L :L :L :ON :ON :L :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :NSM :NSM :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :L :L :L :L :L :L :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :NSM :NSM :NSM :R :NSM :R :NSM :NSM :R :NSM :L :L :L :L :L :L :L :L :L :L :L :R :R :R :R :R :R :R :R :R :R :R :R :R :R :R :R :R :R :R :R :R :R :R :R :R :R :R :L :L :L :L :L :R :R :R :R :R :L :L :L :L :L :L :L :L :L :L :L :AL :AL :AL :AL :L :L :L :L :L :L :L :L :CS :AL :ON :ON :NSM :NSM :NSM :NSM :NSM :NSM :L :L :L :L :L :AL :L :L :L :AL :L :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :L :L :L :L :L :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :L :L :L :L :L :L :AN :AN :AN :AN :AN :AN :AN :AN :AN :AN :ET :AN :AN :AL :AL :AL :NSM :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :NSM :NSM :NSM :NSM :NSM :NSM :NSM :AL :NSM :NSM :NSM :NSM :NSM :NSM :NSM :AL :AL :NSM :NSM :ON :NSM :NSM :NSM :NSM :AL :AL :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :L :BN :AL :NSM :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :L :AL :AL :AL :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :AL :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :L :L :L :NSM :L :L :L :NSM :NSM :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :NSM :NSM :NSM :NSM :L :L :L :L :L :L :L :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ET :ET :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :NSM :NSM :L :L :L :L :NSM :NSM :L :L :NSM :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :NSM :NSM :NSM :NSM :NSM :L :NSM :NSM :L :L :L :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :ET :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :NSM :L :NSM :NSM :NSM :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :L :L :L :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ET :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :NSM :L :L :L :L :L :NSM :NSM :NSM :L :NSM :NSM :NSM :NSM :L :L :L :L :L :L :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :NSM :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :L :L :L :NSM :NSM :NSM :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :L :L :L :ET :L :L :L :L :L :L :L :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :NSM :NSM :NSM :NSM :NSM :NSM :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :NSM :NSM :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :NSM :L :NSM :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :NSM :NSM :NSM :NSM :NSM :L :NSM :NSM :L :L :L :L :L :L :L :L :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :NSM :NSM :L :NSM :L :L :L :NSM :NSM :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :WS :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :L :L :L :L :L :L :L :NSM :L :L :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :L :L :L :L :L :L :ET :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :NSM :NSM :NSM :WS :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :NSM :L :L :L :L :NSM :NSM :NSM :NSM :NSM :L :L :L :L :L :L :NSM :L :L :L :L :L :L :NSM :NSM :NSM :L :L :L :L :ON :L :L :L :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :L :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :L :WS :WS :WS :WS :WS :WS :WS :WS :WS :WS :WS :BN :BN :BN :L :R :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :WS :B :LRE :RLE :PDF :LRO :RLO :WS :ET :ET :ET :ET :ET :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :ON :L :L :L :L :L :L :L :WS :BN :BN :BN :BN :L :L :L :L :L :L :BN :BN :BN :BN :BN :BN :EN :L :L :L :EN :EN :EN :EN :EN :EN :ET :ET :ON :ON :ON :L :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :ET :ET :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ET :ET :ET :ET :ET :ET :ET :ET :ET :ET :ET :ET :ET :ET :ET :ET :ET :ET :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :L :ON :ON :ON :ON :L :ON :ON :L :L :L :L :L :L :L :L :L :L :ON :L :ON :ON :ON :L :L :L :L :L :ON :ON :ON :ON :ON :ON :L :ON :L :ON :L :ON :L :L :L :L :ET :L :L :L :ON :L :L :L :L :L :L :L :ON :ON :L :L :L :L :ON :ON :ON :ON :ON :L :L :L :L :L :ON :ON :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ET :ET :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :EN :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :L :ON :ON :ON :ON :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :ON :L :ON :ON :ON :ON :L :L :L :ON :L :ON :ON :ON :ON :ON :ON :ON :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :WS :ON :ON :ON :ON :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :NSM :NSM :NSM :NSM :NSM :NSM :ON :L :L :L :L :L :ON :ON :L :L :L :L :L :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :ON :ON :L :L :L :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON))
;; codepoints #xFB1D --> #xFFF
(defparameter *bidi-table-02*   #(:R :NSM :R :R :R :R :R :R :R :R :R :R :ET :R :R :R :R :R :R :R :R :R :R :R :R :R :L 
                                     :R :R :R :R :R :L :R :L :R :R :L :R :R :L :R :R :R :R :R :R :R :R :R :R :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :L :L :L :L :L :L
                                     :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL 
                                     :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :L :L :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :ON :L :L :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :NSM :NSM :NSM :NSM :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :CS :ON :CS :L :ON :CS :ON :ON :ON :ON :ON :ON :ON :ON :ON :ET :ON :ON :ET :ET :ON :ON :ON :L :ON :ET :ET :ON :L :L :L :L :AL :AL :AL :AL :AL :L :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :AL :L :L :BN :L :ON :ON :ET :ET :ET :ON :ON :ON :ON :ON :ET :CS :ET :CS :ES :EN :EN :EN :EN :EN :EN :EN :EN :EN :EN :CS :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :L :ET :ET :ON :ON :ON :ET :ET :L :ON :ON :ON :ON :ON :ON :ON :L :L :L :L :L :L :L :L :L :L :BN :BN :BN :ON :ON :L :L))


(defun bidi-type (code)
  (declare (fixnum code))
  ;; partitioned codes to avoid linear search. but this is
  ;; done pretty arbitrary.
  (if (ccl::%i< code #x3400)
    (svref *bidi-table-01* code)
    (if (ccl::%i< code #xFB1D)
      (cond 
       ((<= #x3400 code #x4DB5) :L)
       ((<= #x4E00 code #xA48C) :L)       ; cjk ideograph
       ((<= #xAC00 code #xD7A3) :L)       ; hangul syllable
       ((<= #x4DC0 code #x4DFF) :ON)
       ((<= #xA490 code #xA4C6) :ON)
       (t :L))
      (if (ccl::%i< code #x1D400)
        (if (ccl::%i< code #x10000)
          (aref *bidi-table-02* (ccl::%i- code #xFB1D))
          (cond
           ((<= #x10000 code #x10100) :L)
           ((= #x10101 code) :ON)
           ((<= #x10102 code #x107FF) :L)
           
           ((<= #x10800 code #x10805) :R)
           ((= #x10808 code) :R)
           ((<= #x1080A code #x10835) :R)
           ((<= #x10837 code #x10838) :R)
           ((= #x1083C code) :R)
           ((= #x1083F code) :R)
           
           ((<= #x1D000 code #x1D0F5) :L)
           ((<= #x1D100 code #x1D126) :L)
           ((<= #x1D12A code #x1D166) :L)
           ((<= #x1D167 code #x1D169) :NSM)
           ((<= #x1D16A code #x1D172) :L)
           ((<= #x1D173 code #x1D17A) :BN)
           ((<= #x1D17B code #x1D182) :NSM)
           ((<= #x1D183 code #x1D184) :L)
           ((<= #x1D185 code #x1D18B) :NSM)
           ((<= #x1D18C code #x1D1A9) :L)
           ((<= #x1D1AA code #x1D1AD) :NSM)
           ((<= #x1D1AE code #x1D1DD) :L)
           ((<= #x1D300 code #x1D356) :ON)
           (t :L)))
        
        (if (ccl::%i< code #xF0000)
          (cond
           ; ((<= #x1D400 code #x1D7C9) :L)
           ((<= #x20000 code #x2FA1D) :L)
           ((<= #x1D7CE code #x1D7FF) :EN)
           ((<= #xE0001 code #xE007F) :BN)
           ((<= #xE0100 code #xE01EF) :NSM)
           (t :L))
          :L)))))

(defun bidi-type-category (code)
  "returns :strong-L :strong-R :weak or :neutral"
  (case (bidi-type code)
    ((:L :LRE :LRO) :strong-l)
    ((:R :AL :RLE :RLO) :strong-r)
    ((:PDF :EN :ES :ET :AN :CS :NSM :BN) :weak)
    ((:B :S :WS :ON) :neutral)))
|#


#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
